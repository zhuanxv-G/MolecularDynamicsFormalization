import sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'closeout31'))
from common31 import ROOT,load,dump,sha
OUT=Path(__file__).resolve().parent
BASE=OUT.parent
from collections import Counter
import subprocess
manifest=load(BASE/'mathcopilot_tasks/EAUDIT_MANIFEST.json')
tt={t['subtask']:t for b in manifest for t in b['subtasks']}
rows=[];bindings=[]
for p in sorted((BASE/'mathcopilot_results/eaudit').glob('EAUDIT*_result.json')):
 d=load(p)
 for x in d['items']:
  t=tt[x['subtask']];folder=ROOT/t['path'];m=load(folder/'MANIFEST.json')
  assert sha(folder/'MANIFEST.json')==t['manifest_sha256']
  assert x['source_id']==t['source_id'] and x['source_id'] in m['source_ids']
  for k,h in d['input_sha256'].items():
   original=OUT/'ch08_source.before.json' if k=='blueprint/ch08/ch08_source.json' else ROOT/k
   assert m['input_sha256'][k]==h and sha(original)==h,(k,h)
  for k,h in x.get('input_sha256',{}).items():assert m['input_sha256'][k]==h
  assert sha(folder/'PASTE.txt')==m['files']['PASTE.txt']['sha256']
  assert sha(folder/'PAGES.pdf')==m['input_sha256']['PAGES.pdf']
  rows.append(dict(batch=d['batch'],**x))
 bindings.append(dict(batch=d['batch'],path=p.relative_to(ROOT).as_posix(),sha256=sha(p),merged_from=d.get('merged_from'),items=len(d['items'])))
counts=Counter(x['audit']['verdict'] for x in rows)
assert counts==dict(PASS=2,NEEDS_HUMAN=8) and len(rows)==len({x['source_id'] for x in rows})==10 and len(bindings)==4
assert not subprocess.check_output(['git','log','--format=%H','718f75f0..HEAD','--','Blueprint/Ch08.lean'],cwd=ROOT).strip()
dump(OUT/'RETURNS.json',rows)
dump(OUT/'RETURN_REGISTRATION.json',dict(counts=dict(PASS=2,FAIL=0,NEEDS_HUMAN=8),bindings=bindings,input_binding='source_id/subtask, shared and optional per-item hashes, original manifest/PASTE/PDF bytes checked exactly',lean_sha256=sha(ROOT/'Blueprint/Ch08.lean')))
sys.stdout.reconfigure(encoding='utf-8')
for x in rows:
 print('\n###',x['source_id'])
 print('AUDIT',jsonstr:=__import__('json').dumps(x['audit'],ensure_ascii=False))
 c=x['json_review'].get('corrected_json',{})
 print('METADATA',__import__('json').dumps({k:c[k] for k in ['statement_latex','statement_scope','extra_assumptions','issues','source_page_verification'] if k in c},ensure_ascii=False))
 print('ISSUES',__import__('json').dumps(x['json_review'].get('issues',[]),ensure_ascii=False))
