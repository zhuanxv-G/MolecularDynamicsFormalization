from common26 import *
import subprocess
def main():
 reps=load(OUT/'REPAIRS.json');assert len(reps)==8 and all(r['exit_code']==0 for r in reps)
 final_label=reps[-1]['source_id'].split('-')[-1]
 receipt=load(OUT/'compiled'/(final_label+'.json'));assert receipt['exit_code']==0 and receipt['canonical_sha256']==sha(LEAN)
 text=LEAN.read_text(encoding='utf-8');names=re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',text)
 probe=OUT/'FINAL_COMPILE.lean';probe.write_text(text+'\n'+'\n'.join('#print axioms MD.Ch06.'+n for n in names)+'\n',encoding='utf-8')
 assert receipt['input_sha256']==sha(probe)
 raw=(OUT/'compiled'/(final_label+'.log')).read_bytes();(OUT/'FINAL_COMPILE.log').write_bytes(raw)
 assert sha(OUT/'FINAL_COMPILE.log')==receipt['log_sha256']
 printed={m[1].split('MD.Ch06.')[-1] for m in re.finditer(r"'([^']+)' (?:depends on axioms:|does not depend on any axioms)",raw.decode('utf-8-sig'))}
 receipt.update(declarations=names,missing_axiom_outputs=sorted(set(names)-printed));assert not receipt['missing_axiom_outputs']
 dump(OUT/'FINAL_COMPILE.json',receipt)
 (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch06\n\n'+'\n'.join('#print axioms MD.Ch06.'+n for n in names)+'\n',encoding='utf-8')
 print('FINAL SINGLE-FILE AND ALL AXIOMS PASS',len(names),flush=True)
 report=OUT/'full/CHECK_REPORT.json'
 if report.exists():
  saved=load(report)
  if saved.get('machine_check_status')=='passed' and load(OUT/'FULL_BINDING.json')['canonical_sha256']==sha(LEAN):print('FULL CHECK already passed',flush=True);return
  raise RuntimeError('Existing incomplete check; inspect before choosing a new report directory.')
 with (OUT/'full-check-run.log').open('wb') as f:
  result=subprocess.run(['pwsh','-NoProfile','-File','scripts/check.ps1','-ReportDirectory',str(OUT/'full')],cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
 dump(OUT/'FULL_BINDING.json',dict(canonical_sha256=sha(LEAN),exit_code=result.returncode,report_sha256=sha(report),run_log_sha256=sha(OUT/'full-check-run.log')))
 assert result.returncode==0,load(report)
 print('FULL CHECK PASS',flush=True)
if __name__=='__main__':main()
