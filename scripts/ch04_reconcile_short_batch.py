"""Recover the first batch's typed diagnostics without repeating its compilation."""
import sys,ast,re,json,hashlib,subprocess,importlib
from pathlib import Path
from ch04_data import ROOT,BASE,RECORDS
src=ROOT/sys.argv[1];log=src.with_suffix('.log');raw=src.read_text(encoding='utf-8');out=log.read_text(encoding='utf-8')
assert 'algebra-batch-' in src.name
for mod in ['44b','44c','44extras','441']:importlib.import_module('ch04_section'+mod)
tree=ast.parse((ROOT/'scripts/ch04_short_search_algebra.py').read_text(encoding='utf-8'))
proofs=ast.literal_eval(next(x.value for x in tree.body if isinstance(x,ast.Assign) and any(isinstance(y,ast.Name) and y.id=='proofs' for y in x.targets)))
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
errors=[int(x) for x in re.findall(r':(\d+):\d+: error(?:\([^)]*\))?:',out)]
groups={}
for m in re.finditer(r'namespace MD.Ch04Short(\w+)\n[\s\S]*?end MD.Ch04Short\1\n',raw):
    key=m.group(1);lo=raw[:m.start()].count('\n')+1;hi=raw[:m.end()].count('\n')
    groups[key]=(m.group(),any(lo<=n<=hi for n in errors))
remaining=[]
def save(key,source,rawlog,code):
    state=src.parent/(key+'.json');routes=json.loads(state.read_text(encoding='utf-8')) if state.exists() else []
    if any(x['source']==source.relative_to(ROOT).as_posix() for x in routes):return
    routes.append(dict(route=len(routes)+1,exit_code=code,proof=proofs[key] if code==0 else None,
        source=source.relative_to(ROOT).as_posix(),log=rawlog.relative_to(ROOT).as_posix(),source_sha256=sha(source),log_sha256=sha(rawlog)))
    state.write_text(json.dumps(routes,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(key,'verified PASS' if code==0 else 'first route failed')
for key,(block,failed) in groups.items():
    if failed:save(key,src,log,1)
    else:remaining.append(key)
target=src.with_name(src.stem+'-reconciled-passing.lean');text=raw[:raw.index('namespace MD.Ch04Short')]+''.join(groups[k][0] for k in remaining)
if target.exists():assert target.read_text(encoding='utf-8')==text
else:target.write_text(text,encoding='utf-8')
receipt=target.with_suffix('.compile.json');goodlog=target.with_suffix('.log')
if receipt.exists():
    r=json.loads(receipt.read_text(encoding='utf-8'));assert r['input_sha256']==sha(target) and r['log_sha256']==sha(goodlog);code=r['exit_code']
else:
    run=subprocess.run(['lake','env','lean',str(target.relative_to(ROOT))],cwd=ROOT,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    goodlog.write_bytes(run.stdout);code=run.returncode
    receipt.write_text(json.dumps(dict(exit_code=code,input_sha256=sha(target),log_sha256=sha(goodlog)),indent=2)+'\n',encoding='utf-8')
assert code==0,goodlog.read_text(encoding='utf-8')
for key in remaining:save(key,target,goodlog,0)
