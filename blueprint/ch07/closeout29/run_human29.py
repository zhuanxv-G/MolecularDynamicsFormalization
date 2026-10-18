from human29 import *
from lsp29 import LeanCompiler
import supplement29,finalize29

c=LeanCompiler();done=[]
try:
 for row in load(OUT/'RETURNS.json'):
  if row['audit']['verdict']!='NEEDS_HUMAN':continue
  label='HUMAN-'+row['source_id'].split('-')[-1];saved=OUT/(label+'-PREPARED.json')
  item=load(saved) if saved.exists() else process(row)
  if item['signature_changed']:
   receipt=OUT/'compiled'/(label+'.json');probe=receipt.with_suffix('.lean');valid=False
   if receipt.exists():
    rr=load(receipt)
    valid=rr['exit_code']==0 and rr['input_sha256']==sha(probe) and rr['log_sha256']==sha(probe.with_suffix('.log')) and groups(probe.read_text(encoding='utf-8'))[row['source_id']]['code']==groups()[row['source_id']]['code']
   if not valid:check(label+'-r2' if receipt.exists() else label,c)
   else:print('REUSED',label,flush=True)
  done.append(item);dump(OUT/'HUMAN_REPAIRS.json',done)
 supplement29.main(c)
 finalize29.scopes()
 check('FINAL-CURRENT',c)
 finalize29.final_compile()
finally:c.close()
