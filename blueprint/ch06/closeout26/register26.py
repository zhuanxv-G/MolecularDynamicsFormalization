from common26 import *
from collections import Counter
import subprocess
def main():
 if not (OUT/'FROZEN_BASELINE.json').exists():
  paths=[p for p in (ROOT/'MolecularDynamics').rglob('*') if p.is_file()]
  for n in range(1,6):
   paths += [p for p in (ROOT/f'blueprint/ch{n:02}').rglob('*') if p.is_file() and '__pycache__' not in p.parts]
   paths += [ROOT/f'Blueprint/Ch{n:02}.lean']
   paths += list((ROOT/'docs/review').glob(f'CH{n:02}_*'))
  paths += [p for p in (BASE/'mathcopilot_tasks').rglob('*') if p.is_file()]
  dump(OUT/'FROZEN_BASELINE.json',{p.relative_to(ROOT).as_posix():sha(p) for p in paths})
  dump(OUT/'INITIAL_GIT_STATUS.json',dict(head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),status=subprocess.check_output(['git','status','--short'],cwd=ROOT,text=True)))
 for p in [LEAN,BASE/'ch06_source.json',BASE/'website_audit.json',BASE/'local_audit.json',BASE/'proof_attempts.json']:
  dest=OUT/(p.stem+'.before'+p.suffix)
  if not dest.exists():dest.write_bytes(p.read_bytes())
 original=subprocess.check_output(['git','show','30aa0ce4:Blueprint/Ch06.lean'],cwd=ROOT)
 assert hashlib.sha256(original).hexdigest()==sha(OUT/'Ch06.before.lean')
 rows=[];bindings=[]
 for p in sorted((BASE/'mathcopilot_results/eaudit').glob('EAUDIT*_result.json')):
  d=load(p)
  for item in d['items']:
   sub=item['subtask'];folder=BASE/'mathcopilot_tasks'/d['batch']/sub[-1];m=load(folder/'MANIFEST.json')
   assert item['source_id']==m['source_id']
   for k,h in d['input_sha256'].items():
    assert m['input_sha256'][k]==h,(sub,k)
    before=OUT/('Ch06.before.lean' if k=='Blueprint/Ch06.lean' else 'ch06_source.before.json')
    assert sha(before)==h,(sub,k)
   for k,h in item.get('input_sha256',{}).items():assert m['input_sha256'][k]==h
   assert sha(folder/'PASTE.txt')==m['paste_sha256']
   assert sha(folder/'PAGES.pdf')==m['input_sha256']['PAGES.pdf']
   rows.append(dict(batch=d['batch'],**item))
  bindings.append(dict(batch=d['batch'],path=p.relative_to(ROOT).as_posix(),sha256=sha(p),merged_from=d.get('merged_from'),items=len(d['items'])))
 counts=Counter(x['audit']['verdict'] for x in rows)
 assert counts==dict(PASS=25,FAIL=8,NEEDS_HUMAN=27),counts
 assert len({r['source_id'] for r in rows})==60
 dump(OUT/'RETURNS.json',rows);dump(OUT/'RETURN_REGISTRATION.json',dict(counts=counts,bindings=bindings,input_binding='shared and per-item hashes checked against original manifests; submitted Lean equals 30aa0ce4'))
 dump(OUT/'FAIL_QUEUE.json',[r for r in rows if r['audit']['verdict']=='FAIL'])
 web=load(OUT/'website_audit.before.json');rr={r['source_id']:r for r in rows}
 for w in web:
  if w['source_id'] in rr:
   r=rr[w['source_id']];w.update(closeout26_return=r,audit=r['audit'],json_review=r['json_review'],effective_status={'PASS':'网站复审PASS（原送审版本）','FAIL':'按网站意见修复中','NEEDS_HUMAN':'按版本分流中'}[r['audit']['verdict']])
 dump(BASE/'website_audit.json',web)
 dump(BASE/'WEBSITE_SUMMARY.json',dict(total=249,first_round=dict(PASS=179,FAIL=25,NEEDS_HUMAN=45),reaudit=dict(counts),repairing=8,awaiting_reaudit=0))
 lines=[];ss={s['source_id']:s for s in load(BASE/'ch06_source.json')}
 for r in rows:
  lines += ['\n### '+r['source_id']+' '+r['audit']['verdict'],json.dumps(r,ensure_ascii=False,indent=2)]
 (OUT/'REVIEW.txt').write_text('\n'.join(lines),encoding='utf-8')
 print('REGISTERED',dict(counts),flush=True)
if __name__=='__main__':main()
