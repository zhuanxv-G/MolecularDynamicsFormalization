"""Register original two-hash EAUDIT01 returns after the current local section push."""
import copy,hashlib,json,subprocess
from datetime import datetime
from integrate_website_returns import ROOT,sha,read,dump,git,integrate
from eaudit_review_tasks import declarations
from build_mathcopilot_compact import definitions
BASE=ROOT/'blueprint/ch01';RAW=BASE/'mathcopilot_results/eaudit';TASK=BASE/'mathcopilot_tasks/EAUDIT01'
RECEIPT=RAW/'REGISTRATION_20261014.json'

def register():
 paths=sorted(RAW.glob('EAUDIT01_*_result.json'));assert len(paths)==5
 hashes={p.relative_to(ROOT).as_posix():sha(p) for p in paths}
 if RECEIPT.exists():
  assert read(RECEIPT)['raw_files']==hashes;print('Existing EAUDIT01 return receipt reused.');return
 generation=git('log','-1','--format=%H','--',(TASK/'MANIFEST.json').relative_to(ROOT).as_posix())
 blob=lambda rel:subprocess.check_output(['git','show',generation+':'+rel],cwd=ROOT)
 historical_source=blob('blueprint/ch01/ch01_source.json');historical_lean=blob('Blueprint/Ch01.lean')
 old_sources={s['source_id']:s for s in json.loads(historical_source)}
 current={s['source_id']:s for s in read(BASE/'ch01_source.json')};ds=declarations(1)
 root=read(TASK/'MANIFEST.json');index=definitions(sorted({x['path'] for row in root for x in read(ROOT/row['path']/'MANIFEST.json')['definition_excerpts']}))
 history=git('log','--format=%H',generation+'..HEAD','--','MolecularDynamics/').splitlines()
 rows=[]
 for p in paths:
  data=read(p);assert data['batch']=='EAUDIT01' and len(data['items'])==1
  item=data['items'][0];sid=item['source_id'];assert sid in current and item['audit']['lean_decl']==current[sid]['lean_decl']
  row=next(r for r in root if r['source_id']==sid);folder=ROOT/row['path'];mp=folder/'MANIFEST.json';m=read(mp)
  assert sha(mp)==row['manifest_sha256'] and m['source_ids']==[sid]
  definition_checks=[]
  for d in m['definition_excerpts']:
   choices=index.get(d['name'],[])
   match=any(c['path']==d['path'] and c['namespace']==d['namespace'] and hashlib.sha256(c['code'].encode()).hexdigest()==d['code_sha256'] for c in choices)
   definition_checks.append(dict(path=d['path'],name=d['name'],matches=match))
  checks=dict(source_json_returned=data.get('source_json_sha256')==m['source_json_sha256'],
   lean_returned=data.get('lean_sha256')==m['lean_sha256'],
   historical_source_blob=hashlib.sha256(historical_source).hexdigest()==m['source_json_sha256'],
   historical_lean_blob=hashlib.sha256(historical_lean).hexdigest()==m['lean_sha256'],
   current_signature=ds[sid]['signature_sha256']==m['signature_sha256'],
   source_entry_unchanged=current[sid]==old_sources[sid],formal_dependencies_unchanged=not history,
   definition_excerpts=all(d['matches'] for d in definition_checks))
  reasons=[k+'未匹配' for k,v in checks.items() if not v]
  binding=dict(bound=not reasons,rule='EAUDIT01 original source_json_sha256/lean_sha256 protocol',version=generation[:12],
   generation_commit=generation,input_sha256={'blueprint/ch01/ch01_source.json':m['source_json_sha256'],'Blueprint/Ch01.lean':m['lean_sha256']},
   checks=checks,definition_excerpt_checks=definition_checks,reasons=reasons,
   scope='原EAUDIT01要求的两项SHA均回显并核对真实git历史blob，任务子MANIFEST和所有定义摘录核验；当前该条源码/签名相同。缺哈希不提升。')
  rows.append(dict(source_id=sid,raw_path=p.relative_to(ROOT).as_posix(),raw_sha256=sha(p),json_review=item['json_review'],audit=item['audit'],binding=binding,
   manifest=mp.relative_to(ROOT).as_posix(),manifest_sha256=sha(mp),source_corrections_applied=False))
 dump(RECEIPT,dict(batch='EAUDIT01',registered_at=datetime.now().isoformat(),raw_files=hashes,generation_commit=generation,items=rows))
 integrate(1)
 print('EAUDIT01 raw registration:',[(r['source_id'],r['audit']['verdict'],r['binding']['bound'],r['binding']['reasons']) for r in rows])

if __name__=='__main__':register()
