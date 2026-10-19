from common31 import *
from collections import Counter
import subprocess
def main():
 if not (OUT/'FROZEN_BASELINE.json').exists():
  paths=[p for p in (ROOT/'MolecularDynamics').rglob('*') if p.is_file()]
  for n in range(1,8):
   paths += [p for p in (ROOT/f'blueprint/ch{n:02}').rglob('*') if p.is_file() and '__pycache__' not in p.parts]
   paths += [ROOT/f'Blueprint/Ch{n:02}.lean']
   paths += list((ROOT/'docs/review').glob(f'CH{n:02}_*'))
  dump(OUT/'FROZEN_BASELINE.json',{p.relative_to(ROOT).as_posix():sha(p) for p in paths})
 for p in [LEAN,BASE/'ch08_source.json',BASE/'local_audit.json',BASE/'proof_attempts.json']:
  dest=OUT/(p.stem+'.before'+p.suffix)
  if not dest.exists():dest.write_bytes(p.read_bytes())
 tasks=load(BASE/'mathcopilot_tasks/MANIFEST.json')
 tt={t['subtask']:t for b in tasks for t in b['subtasks']}
 rows=[];bindings=[]
 for p in sorted((BASE/'mathcopilot_results').glob('BATCH*_result.json')):
  d=load(p)
  assert all(sha(ROOT/k)==h for k,h in d['input_sha256'].items())
  for item in d['items']:
   t=tt[item['subtask']];folder=ROOT/t['path'];m=load(folder/'MANIFEST.json')
   assert item['source_id'] in m['source_ids']
   for k,h in item['input_sha256'].items():
    assert m['input_sha256'][k]==h,(item['source_id'],k)
   rows.append(dict(batch=d['batch'],**item))
  bindings.append(dict(batch=d['batch'],path=p.relative_to(ROOT).as_posix(),sha256=sha(p),merged_from=d.get('merged_from'),items=len(d['items'])))
 counts=Counter(x['audit']['verdict'] for x in rows)
 assert counts==dict(PASS=74,FAIL=5,NEEDS_HUMAN=24),counts
 assert len({x['source_id'] for x in rows})==103
 dump(OUT/'RETURNS.json',rows);dump(OUT/'RETURN_REGISTRATION.json',dict(counts=counts,bindings=bindings,input_binding='all shared and per-item hashes match unchanged original compact manifests'))
 dump(OUT/'FAIL_QUEUE.json',[r for r in rows if r['audit']['verdict']=='FAIL'])
 dump(BASE/'website_audit.json',[dict(source_id=r['source_id'],audit=r['audit'],json_review=r['json_review'],closeout31_return=r,effective_status={'PASS':'网站PASS（首轮原送审版本）','FAIL':'按网站意见修复中','NEEDS_HUMAN':'待分流'}[r['audit']['verdict']]) for r in rows])
 dump(BASE/'WEBSITE_SUMMARY.json',dict(total=103,first_round=dict(counts),website_pass=74,repairing=5,awaiting_reaudit=0))
 gg=groups();src={s['source_id']:s for s in load(BASE/'ch08_source.json')}
 for verdict in ['FAIL','NEEDS_HUMAN']:
  lines=[]
  for r in rows:
   if r['audit']['verdict']!=verdict:continue
   sid=r['source_id'];lines += ['\n### '+sid+' '+src[sid]['pdf_page'],json.dumps(r['audit'],ensure_ascii=False,indent=2),json.dumps(r['json_review'],ensure_ascii=False,indent=2)]
   if verdict=='FAIL':lines+=['```lean',gg[sid]['code'],'```']
  (OUT/(verdict+'_REVIEW.txt')).write_text('\n'.join(lines),encoding='utf-8')
 print('REGISTERED',dict(counts))
if __name__=='__main__':main()
