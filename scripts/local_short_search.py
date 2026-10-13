"""At most eight compiler-backed local PASS attempts; three routes per item."""
import importlib,json,hashlib,re,sys,subprocess
from datetime import datetime
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
ch=int(sys.argv[1]);keys=sys.argv[2:]
assert ch in (5,6) and 0<len(keys)<=8 and len(set(keys))==len(keys)
data=importlib.import_module(f'ch{ch:02}_data')
candidates=importlib.import_module(f'ch{ch:02}_short_candidates').proofs
folder=data.BASE/'validation/short_search';folder.mkdir(parents=True,exist_ok=True)
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
pending={}
for key in keys:
    r=next(r for r in data.RECORDS if r['source_id'].endswith('-'+key))
    assert r['local_verdict']=='PASS'
    state=folder/f'{key}.json';routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
    if any(x['exit_code']==0 for x in routes) or len(routes)>=3:
        print(key,'saved routes reused');continue
    timer=data.BASE/'section_timeboxes.json'
    if ch==5 and timer.exists():
        box=json.loads(timer.read_text(encoding='utf-8')).get(r['section'])
        if box:
            due=datetime.fromisoformat(box['deadline'])
            if datetime.now(due.tzinfo)>=due:
                (folder/f'{key}.timebox.json').write_text(json.dumps(dict(section=r['section'],deadline=box['deadline'],status='expired',action='No further proof attempt; keep sorry and continue.'),indent=2)+'\n',encoding='utf-8')
                print(key,'section timebox expired; keep sorry and continue');continue
    proof=candidates[key]
    if routes:
        fix=folder/f'{key}-next-proof.txt';assert fix.exists(),'Read diagnostic and write revised route first.'
        proof=fix.read_text(encoding='utf-8')
    pending[key]=(r,proof,routes)
if not pending:sys.exit()
header=f'''import MolecularDynamics.Chapter{ch:02}.ReviewProofs
import Mathlib.MeasureTheory.Function.LpSpace.Indicator
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Tactic
open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter{ch:02}Review
open scoped BigOperators Topology ContDiff InnerProductSpace ENNReal
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch{ch:02}Short
variable {{E : Type*}} [NormedAddCommGroup E] [NormedSpace ℝ E]
'''
# Only already-checked proofs and actual definitions provide dependencies.
background='\n\n'.join(r['code'] for r in data.RECORDS if r['source_id'].split('-')[-1] not in pending and not re.search(r'\bsorry\b',r['code']))
if ch==5:
    header=header.replace('import Mathlib.Tactic','import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar\nimport Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform\nimport Mathlib.Analysis.Calculus.ParametricIntegral\nimport Mathlib.Analysis.Calculus.Deriv.Slope\nimport Mathlib.Analysis.Calculus.LineDeriv.IntegrationByParts\nimport Mathlib.Analysis.Calculus.Taylor\nimport Mathlib.Analysis.SpecialFunctions.Gamma.Basic\nimport MolecularDynamics.Chapter01.ReviewDefinitions\nimport Mathlib.Tactic')
if not (ROOT/f'MolecularDynamics/Chapter{ch:02}/ReviewProofs.lean').exists():
    header=header.replace(f'import MolecularDynamics.Chapter{ch:02}.ReviewProofs',f'import MolecularDynamics.Chapter{ch:02}.Statements')
if ch==6:
    header=header.replace('import Mathlib.Tactic',
        'import Mathlib.Analysis.Calculus.Deriv.MeanValue\nimport Mathlib.Analysis.Calculus.Deriv.Shift\nimport Mathlib.Analysis.Calculus.Taylor\nimport Mathlib.Tactic')
    header=header.replace('open Set Filter Matrix MeasureTheory MolecularDynamics',
        'open Set Filter Matrix MeasureTheory ProbabilityTheory MolecularDynamics')
    header=header.replace('open scoped BigOperators Topology ContDiff InnerProductSpace ENNReal',
        'open scoped BigOperators Topology ContDiff InnerProductSpace ENNReal NNReal')
def compile_group(group,label):
    text=header+background+'\n\n';ranges={}
    for key,(r,proof,_) in group.items():
        first=len(text.splitlines())+1
        assert 'by\n  sorry' in r['code'],key
        text+=r['code'].replace('by\n  sorry','by\n  '+proof)+'\n\n'
        ranges[key]=(first,len(text.splitlines()))
    text+=f'end MD.Ch{ch:02}Short\n'
    src=folder/f'route-{label}.lean';log=src.with_suffix('.log');receipt=src.with_suffix('.compile.json')
    if src.exists():assert src.read_text(encoding='utf-8')==text
    else:src.write_text(text,encoding='utf-8')
    if receipt.exists():
        saved=json.loads(receipt.read_text(encoding='utf-8'));assert saved['input_sha256']==sha(src) and saved['log_sha256']==sha(log)
        return src,log,saved['exit_code'],ranges,log.read_text(encoding='utf-8')
    from local_compile import compile_recorded
    result,output,reused=compile_recorded(['lake','env','lean',str(src.relative_to(ROOT))],ROOT,src,log,receipt,reuse_failure=True)
    return src,log,result['exit_code'],ranges,output.decode('utf-8',errors='replace')
label=hashlib.sha256('-'.join(k+str(len(v[2])+1) for k,v in pending.items()).encode()).hexdigest()[:20]
src,log,code,ranges,out=compile_group(pending,label)
def save(key,source,rawlog,exit_code):
    r,proof,routes=pending[key]
    routes.append(dict(route=len(routes)+1,exit_code=exit_code,proof=proof if exit_code==0 else None,
        source=source.relative_to(ROOT).as_posix(),log=rawlog.relative_to(ROOT).as_posix(),source_sha256=sha(source),log_sha256=sha(rawlog)))
    (folder/f'{key}.json').write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(key,'PASS' if exit_code==0 else f'failed route {len(routes)}')
if code==0:
    for key in pending:save(key,src,log,0)
else:
    lines=[int(x) for x in re.findall(r':(\d+):\d+: error(?:\([^)]*\))?:',out)]
    assert lines and all(any(a<=n<=b for a,b in ranges.values()) for n in lines),out
    for key,(a,b) in ranges.items():
        if any(a<=n<=b for n in lines):save(key,src,log,code)
        else:
            ss,ll,cc,_,oo=compile_group({key:pending[key]},label+'-'+key)
            save(key,ss,ll,cc)
            if cc:print(oo[-2400:])
    print(out[-3200:])
