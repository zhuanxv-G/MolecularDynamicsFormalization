from register30 import *

def main():
    receipt=load(OUT/'FINAL_COMPILE.json')
    assert receipt['exit_code']==0 and receipt['canonical_sha256']==sha(ROOT/'Blueprint/Ch07.lean')
    p=OUT/'full/CHECK_REPORT.json'
    assert not p.exists(), 'Never overwrite a full check report'
    with (OUT/'full-check-run.log').open('wb') as f:
        r=subprocess.run(['pwsh','-NoProfile','-File','scripts/check.ps1','-ReportDirectory',str(OUT/'full')],cwd=ROOT,stdout=f,stderr=subprocess.STDOUT)
    report=load(p)
    dump(OUT/'FULL_BINDING.json',dict(canonical_sha256=sha(ROOT/'Blueprint/Ch07.lean'),source_sha256=sha(BASE/'ch07_source.json'),exit_code=r.returncode,report_sha256=sha(p),status=report['machine_check_status']))
    assert r.returncode==0 and report['machine_check_status']=='passed',report.get('error')
    print('FULL CHECK PASS',flush=True)

if __name__=='__main__':main()
