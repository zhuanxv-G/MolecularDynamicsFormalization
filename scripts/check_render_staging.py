"""Fail closed on public-path boundaries and staged newline changes."""
import json, subprocess
from fix_github_render import git, OUT, write

def eol(b):
    crlf=b.count(b'\r\n'); lf=b.count(b'\n')-crlf;cr=b.count(b'\r')-crlf
    return 'mixed' if (crlf and lf) or cr else 'crlf' if crlf else 'lf' if lf else 'none'

paths=git('diff','--cached','--name-only').decode().splitlines()
allowed_scripts={'scripts/fix_github_render.py','scripts/check_github_render.py','scripts/check_render_staging.py'}
assert paths
assert all(p=='README.md' or p.startswith('docs/review/') or p in allowed_scripts for p in paths),paths
ahead=git('diff','--name-only','origin/main..HEAD').decode().splitlines()
assert all(p=='README.md' or p.startswith('docs/review/') or p in allowed_scripts for p in ahead),ahead
assert subprocess.run(['git','merge-base','--is-ancestor','6f5be4d6','HEAD']).returncode==1
assert subprocess.run(['git','merge-base','--is-ancestor','origin/main','HEAD']).returncode==0
checks={}
for p in paths:
    idx=git('ls-files','--eol','--',p).decode().split()[0].removeprefix('i/')
    original=subprocess.run(['git','show','origin/main:'+p],capture_output=True)
    before=eol(original.stdout) if original.returncode==0 else None
    assert before is None or before==idx,(p,before,idx)
    if p in allowed_scripts:assert subprocess.run(['git','cat-file','-e','book-ch01-08-render:'+p],capture_output=True).returncode!=0
    checks[p]=dict(origin=before,index=idx)
normal=git('diff','--cached','--stat');ignore=git('diff','--cached','--ignore-cr-at-eol','--stat')
assert normal==ignore,(normal,ignore)
write(OUT/'render_staging_check.json',json.dumps(dict(passed=True,files=checks,stat=normal.decode()),indent=2)+'\n')
print('PASS: public paths, ancestor exclusion, index EOL, identical staged stats; files=',len(paths))
