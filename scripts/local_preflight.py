"""Compile the next <=8 declarations without changing a running checkpoint.

The future canonical file is serialized byte for byte. A later batch may reuse
the receipt only if its entire canonical input and immutable raw log match.
"""
import importlib,json,sys
from pathlib import Path
from local_blueprint import ROOT,pipeline
from local_compile import compile_recorded

ch=int(sys.argv[1]);module=sys.argv[2];label=sys.argv[3]
p=pipeline(ch)
assert module not in sys.modules
prior=ROOT/f'Blueprint/Ch{ch:02}.lean'
header=prior.read_text(encoding='utf-8').split('/-- source_id:',1)[0]
folder=p.BASE/'validation/preflight';folder.mkdir(exist_ok=True)
def serialize():
    chunks=[header]
    for r in p.RECORDS:
        comment=f"/-- source_id: {r['source_id']} · {r['label'] or r['kind']} · §{r['section']} · 印刷p.{r['printed_page']} / PDFp.{r['pdf_page']}"
        comment+=''.join('\n[EXTRA] '+x for x in r['extra_assumptions'])
        comment+=''.join('\n['+x.get('code','NEEDS_HUMAN')+'] '+x['detail'] for x in r['issues'])
        chunks += [comment+' -/\n'+r['code']+'\n\n']
    return ''.join(chunks+[f'end MD.Ch{ch:02}\n'])
for dependency in sys.argv[4:]:
    assert dependency not in sys.modules
    importlib.import_module(dependency)
    expected=serialize()
    accepted=False
    for saved in folder.glob('*.json'):
        if saved.stem.endswith('-RUNNING'):continue
        d=json.loads(saved.read_text(encoding='utf-8'))
        source=saved.with_suffix('.lean');raw=saved.with_suffix('.log')
        if (d.get('exit_code')==0 and source.exists() and source.read_text(encoding='utf-8')==expected
            and p.sha(source)==d['input_sha256'] and raw.exists() and d['log_sha256']==p.sha(raw)):
            accepted=True;break
    assert accepted,'Dependent preflight must already have passed: '+dependency
before=len(p.RECORDS)
importlib.import_module(module)
assert 0<len(p.RECORDS)-before<=8
text=serialize()
source=folder/f'{label}.lean';log=source.with_suffix('.log');receipt=source.with_suffix('.json')
if source.exists():assert source.read_text(encoding='utf-8')==text
else:source.write_text(text,encoding='utf-8')
result,output,reused=compile_recorded(['lake','env','lean',str(source.relative_to(ROOT))],ROOT,source,log,receipt,reuse_failure=True)
print(output.decode('utf-8',errors='replace'))
print('Preflight',label,'records',len(p.RECORDS),'exit',result['exit_code'])
sys.exit(result['exit_code'])
