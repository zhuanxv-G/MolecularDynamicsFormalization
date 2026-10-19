from common31 import *
import subprocess
p=OUT/'full/CHECK_REPORT.json'
if p.exists():
 assert load(p)['machine_check_status']=='passed','Inspect existing report; never overwrite evidence'
 assert load(OUT/'FULL_BINDING.json')['canonical_sha256']==sha(LEAN)
 print('REUSED FULL',flush=True)
else:
 with (OUT/'full-check-run.log').open('wb') as f:
  r=subprocess.run(['pwsh','-NoProfile','-File','scripts/check.ps1','-ReportDirectory',str(OUT/'full')],cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
 dump(OUT/'FULL_BINDING.json',dict(canonical_sha256=sha(LEAN),source_sha256=sha(BASE/'ch08_source.json'),exit_code=r.returncode,report_sha256=sha(p)))
 assert r.returncode==0,load(p)
 print('FULL CHECK PASS',flush=True)
