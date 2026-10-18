from common25 import *
from local_compile import compile_recorded
import subprocess

def main():
 text=LEAN.read_text(encoding='utf-8')
 names=re.findall(r'(?m)^(?:@\[[^\]\n]+\]\s*)*(?:(?:noncomputable|private|protected)\s+)*(?:theorem|lemma|def|abbrev)\s+(\w+)',text)
 (BASE/'CheckAxioms.lean').write_text('import Blueprint.Ch06\n\n'+'\n'.join('#print axioms MD.Ch06.'+n for n in names)+'\n',encoding='utf-8')
 probe=OUT/'FINAL_COMPILE.lean'
 probe.write_text(text+'\n'+'\n'.join('#print axioms MD.Ch06.'+n for n in names)+'\n',encoding='utf-8')
 # The last official single-file compiler elaboration already checks this exact
 # text and all axiom commands. Bind that evidence, then perform the required
 # complete native build/fresh checks once; do not reload the same probe again.
 receipt=load(OUT/'compiled/SUPPLEMENT-final.json')
 assert receipt['exit_code']==0 and receipt['canonical_sha256']==sha(LEAN)
 assert receipt['input_sha256']==sha(probe)
 original_log=OUT/'compiled/SUPPLEMENT-final.log'
 assert sha(original_log)==receipt['log_sha256']
 output=original_log.read_bytes();(OUT/'FINAL_COMPILE.log').write_bytes(output)
 printed={m[1].split('MD.Ch06.')[-1] for m in re.finditer(r"'([^']+)' (?:depends on axioms:|does not depend on any axioms)",output.decode('utf-8-sig'))}
 receipt.update(canonical_sha256=sha(LEAN),declarations=names,missing_axiom_outputs=sorted(set(names)-printed))
 dump(OUT/'FINAL_COMPILE.json',receipt)
 assert receipt['exit_code']==0 and not receipt['missing_axiom_outputs'],receipt
 print('FINAL SINGLE-FILE COMPILER PASS',len(names),flush=True)
 report=OUT/'full/CHECK_REPORT.json'
 if report.exists():
  saved=load(report)
  if saved.get('machine_check_status')=='passed' and (OUT/'FULL_BINDING.json').exists() and load(OUT/'FULL_BINDING.json')['canonical_sha256']==sha(LEAN):
   print('FULL CHECK already passed',flush=True);return
  raise RuntimeError('Existing incomplete full check: inspect report before choosing a new run directory.')
 with (OUT/'full-check-run.log').open('wb') as f:
  result=subprocess.run(['pwsh','-NoProfile','-File','scripts/check.ps1','-ReportDirectory',str(OUT/'full')],cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
 dump(OUT/'FULL_BINDING.json',dict(canonical_sha256=sha(LEAN),exit_code=result.returncode,report_sha256=sha(report),run_log_sha256=sha(OUT/'full-check-run.log')))
 assert result.returncode==0,load(report)
 print('FULL CHECK PASS',flush=True)

if __name__=='__main__':main()
