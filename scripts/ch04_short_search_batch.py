"""Compile at most eight independent short candidates; split errors from verified successes."""
import ast,sys,json,hashlib,subprocess,importlib,re
from ch04_data import ROOT,BASE,RECORDS
mods={'RotationTraceIdentity':'44b','RotationSkew':'44b','RigidVelocity':'44b',
      'InertiaSkewIdentity':'44c','InertiaTraceCorrected':'44c','RotationTrajectory':'44extras','SecondMomentDiagonal':'44extras','AngularInertia':'441','RotationBodyEnergy':'44extras','RigidInvariants':'441','RigidHamiltonianField':'441extra','ExactPlanarRotation':'441exact'}
keys=sys.argv[1:];assert 0<len(keys)<=8 and len(set(keys))==len(keys)
tree=ast.parse((ROOT/'scripts/ch04_short_search_algebra.py').read_text(encoding='utf-8'))
proofs=ast.literal_eval(next(x.value for x in tree.body if isinstance(x,ast.Assign) and any(isinstance(y,ast.Name) and y.id=='proofs' for y in x.targets)))
folder=BASE/'validation/short_search';folder.mkdir(parents=True,exist_ok=True)
pending={}
for key in keys:
    importlib.import_module('ch04_section'+mods[key])
    record=next(r for r in RECORDS if r['source_id'].endswith('-'+key));assert record['local_verdict']=='PASS'
    path=folder/f'{key}.json';routes=json.loads(path.read_text(encoding='utf-8')) if path.exists() else []
    if any(x['exit_code']==0 for x in routes) or len(routes)>=3:
        print(key,'saved evidence reused');continue
    candidate=proofs[key]
    # Subsequent routes are deliberately supplied from compiler diagnostics.
    fix=folder/f'{key}-next-proof.txt'
    if routes:
        assert fix.exists(),f'{key}: write a revised route after reading its last diagnostic'
        candidate=fix.read_text(encoding='utf-8')
    pending[key]=(record,candidate,routes)
if not pending:sys.exit()
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
header='''import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
set_option maxHeartbeats 500000
'''
def compile_group(group,label):
    ranges={};text=header
    for key,(r,proof,_) in group.items():
        first=len(text.splitlines())+1
        text+='namespace MD.Ch04Short'+key+'\n'+r['code'].replace('by\n  sorry','by\n  '+proof)+'\nend MD.Ch04Short'+key+'\n'
        ranges[key]=(first,len(text.splitlines()))
    src=folder/('algebra-batch-'+label+'.lean');log=src.with_suffix('.log')
    if src.exists():assert src.read_text(encoding='utf-8')==text,src
    else:src.write_text(text,encoding='utf-8')
    receipt=src.with_suffix('.compile.json')
    if receipt.exists():
        saved=json.loads(receipt.read_text(encoding='utf-8'))
        assert saved['input_sha256']==sha(src) and saved['log_sha256']==sha(log)
        return src,log,saved['exit_code'],ranges,log.read_text(encoding='utf-8')
    result=subprocess.run(['lake','env','lean',str(src.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    log.write_bytes(result.stdout)
    receipt.write_text(json.dumps(dict(exit_code=result.returncode,input_sha256=sha(src),log_sha256=sha(log)),indent=2)+'\n',encoding='utf-8')
    return src,log,result.returncode,ranges,result.stdout.decode('utf-8',errors='replace')
label=hashlib.sha256('-'.join(k+str(len(v[2])+1) for k,v in pending.items()).encode()).hexdigest()[:20]
src,log,code,ranges,out=compile_group(pending,label)
def save(key,source,rawlog,exit_code):
    r,proof,routes=pending[key]
    routes.append(dict(route=len(routes)+1,exit_code=exit_code,proof=proof if exit_code==0 else None,
        source=source.relative_to(ROOT).as_posix(),log=rawlog.relative_to(ROOT).as_posix(),
        source_sha256=sha(source),log_sha256=sha(rawlog)))
    (folder/f'{key}.json').write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(key,'PASS' if exit_code==0 else 'failed route '+str(len(routes)))
if code==0:
    for key in pending:save(key,src,log,0)
else:
    lines=[int(x) for x in re.findall(r':(\d+):\d+: error(?:\([^)]*\))?:',out)]
    assert lines and all(any(lo<=n<=hi for lo,hi in ranges.values()) for n in lines),out
    failed={key for key,(lo,hi) in ranges.items() if any(lo<=n<=hi for n in lines)}
    for key in failed:save(key,src,log,code)
    print(out[-9000:])
    remaining={key:value for key,value in pending.items() if key not in failed}
    if remaining:
        goodsrc,goodlog,goodcode,_,goodout=compile_group(remaining,label+'-passing-subset')
        assert goodcode==0,goodout
        for key in remaining:save(key,goodsrc,goodlog,0)
