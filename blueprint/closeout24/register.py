from common import *
from collections import Counter
RANGES={2:(74,96),3:(67,85),4:(69,91),5:(43,62)}
EXPECTED={2:dict(PASS=59,FAIL=4,NEEDS_HUMAN=12),3:dict(PASS=55,FAIL=10,NEEDS_HUMAN=13),4:dict(PASS=91,FAIL=7,NEEDS_HUMAN=12),5:dict(PASS=97,FAIL=6,NEEDS_HUMAN=14)}
def main():
 allrows=[]
 for ch,(lo,hi) in RANGES.items():
  b=base(ch);dest=OUT/f'ch{ch:02}';dest.mkdir(exist_ok=True)
  web=load(b/'website_audit.json');by={w['source_id']:w for w in web};rows=[];bindings=[]
  for rel in [f'Blueprint/Ch{ch:02}.lean',f'blueprint/ch{ch:02}/ch{ch:02}_source.json',f'blueprint/ch{ch:02}/website_audit.json',f'blueprint/ch{ch:02}/local_audit.json',f'blueprint/ch{ch:02}/proof_attempts.json']:
   p=ROOT/rel;target=dest/(p.stem+'.before'+p.suffix)
   if p.exists() and not target.exists():target.write_bytes(p.read_bytes())
  for n in range(lo,hi+1):
   p=b/f'mathcopilot_results/eaudit/EAUDIT{n:02}_result.json';d=load(p);checks={}
   for rel,h in d['input_sha256'].items():
    inp=ROOT/rel if '/' in rel else b/f'mathcopilot_tasks/EAUDIT{n:02}'/rel
    checks[rel]=dict(expected=h,actual=sha(inp));assert checks[rel]['actual']==h,(ch,n,rel)
   bindings.append(dict(batch=d['batch'],path=p.relative_to(ROOT).as_posix(),sha256=sha(p),input_hashes=checks,merged_from=d.get('merged_from')))
   for item in d['items']:
    sid=item['source_id'];w=by[sid]
    if 'closeout24_return' not in w:
     w.setdefault('website_history',[]).append({k:v for k,v in w.items() if k!='website_history'})
     w['closeout24_return']=item;w['closeout24_binding']=bindings[-1];w['audit']=item['audit']
     w['effective_status']={'PASS':'网站PASS（EAUDIT复审）','FAIL':'按网站意见修复中','NEEDS_HUMAN':'原书疑误待导师；各版本分别登记'}[item['audit']['verdict']]
    rows.append(dict(chapter=ch,batch=d['batch'],**item))
  counts=Counter(x['audit']['verdict'] for x in rows);assert counts==EXPECTED[ch],counts
  assert len(set(x['source_id'] for x in rows))==len(rows)
  dump(b/'website_audit.json',web);dump(dest/'RETURN_REGISTRATION.json',dict(total=len(rows),counts=counts,bindings=bindings))
  dump(dest/'RETURNS.json',rows)
  summary=load(b/'WEBSITE_SUMMARY.json');summary.update(closeout24_returns=dict(counts),awaiting_reaudit=0,repairing=counts['FAIL'],local_repairs=0);dump(b/'WEBSITE_SUMMARY.json',summary)
  p=b/'PROGRESS.md';text=p.read_text(encoding='utf-8-sig');text='\n'.join('|'.join([*line.split('|')[:3],' '+by[line.split('|')[1].strip()]['effective_status']+' ',*line.split('|')[4:]]) if line.startswith('| MD-') else line for line in text.splitlines())
  if not text.startswith(f'# 第{ch}章24号'):p.write_text(f'# 第{ch}章24号最终收口进行中\n\n本轮返回{len(rows)}条：PASS {counts["PASS"]} / FAIL {counts["FAIL"]} / NEEDS_HUMAN {counts["NEEDS_HUMAN"]}；27项按意见修复及文档统一正在进行，未完成终验。\n\n'+text+'\n',encoding='utf-8')
  print(ch,len(rows),dict(counts),flush=True);allrows+=rows
 dump(OUT/'RETURNS.json',allrows)
 dump(OUT/'FAIL_QUEUE.json',[x for x in allrows if x['audit']['verdict']=='FAIL'])
 print('REGISTERED',len(allrows),'FAIL',sum(x['audit']['verdict']=='FAIL' for x in allrows))
if __name__=='__main__':main()
