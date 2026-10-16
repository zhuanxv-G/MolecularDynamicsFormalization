"""Sequential authorized repair continuation; stops at any failed check."""
import subprocess,time
import psutil
from integrate_website_returns import ROOT,read,sha
from repair_cinfty import run as cinfty,resume_prepared
from website_repair_finish import finish

def accept(ch,variant=None):
    receipt=ROOT/f'blueprint/ch{ch:02}/validation/WEBSITE_REPAIR_CHAPTER_ACCEPTANCE.json'
    if receipt.exists():
        d=read(receipt)
        assert d['lean_sha256']==sha(ROOT/f'Blueprint/Ch{ch:02}.lean')
        assert d['source_sha256']==sha(ROOT/f'blueprint/ch{ch:02}/ch{ch:02}_source.json')
        print('REUSE_CHAPTER_ACCEPTANCE',ch,flush=True);return
    folder=ROOT/(f'blueprint/ch{ch:02}/validation/WEBSITE_REPAIR_CHAPTER_END'+('_'+variant if variant else '')+'/full-check')
    # An interrupted Python coordinator may leave its native PowerShell check
    # alive. Wait for that exact invocation, rather than duplicating phases.
    announced=False
    while True:
        active=[]
        for p in psutil.process_iter(['pid','cmdline']):
            try:
                args=p.info['cmdline'] or []
                if any(a.replace('\\','/') in ('scripts/check.ps1',(ROOT/'scripts/check.ps1').as_posix()) for a in args) and str(folder) in args:active.append(p.pid)
            except (psutil.NoSuchProcess,psutil.AccessDenied):pass
        if not active:break
        if not announced:print('WAIT_EXISTING_FULL_CHECK',ch,active,flush=True);announced=True
        time.sleep(5)
    try:finish(ch,variant)
    except subprocess.CalledProcessError as exc:
        if receipt.exists() and exc.cmd==['git','push']:
            subprocess.run(['git','-c','http.sslBackend=openssl','push'],cwd=ROOT,check=True)
        else:raise

def run():
    for ch in (2,3,4):
        cinfty(ch);accept(ch,'CINFTY')
    from repair_ch05 import run as chapter5
    resume_prepared(5)
    sources=read(ROOT/'blueprint/ch05/ch05_source.json')
    for section in dict.fromkeys(s['section'] for s in sources):chapter5(section)
    accept(5)
    print('ALL_CHAPTER_REPAIRS_ACCEPTED; finalize user handoff and stop.',flush=True)

if __name__=='__main__':run()
