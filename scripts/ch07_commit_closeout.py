"""Commit and push only the verified chapter-7 closeout files."""
from ch07_pipeline import *

verify_frozen()
done=json.loads((BASE/'closeout/COMPLETION.json').read_text(encoding='utf-8'))
assert done['machine_check_status']=='passed' and done['canonical_sha256']==sha(ROOT/'Blueprint/Ch07.lean')
assert done['source_json_sha256']==sha(BASE/'ch07_source.json')
assert subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip()=='chapter07-blueprint'
files=['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md',
       'docs/handoff/WORK_LOG.zh-CN.md','Blueprint/Ch07.lean','blueprint/ch07',
       'docs/review/CH07_BLUEPRINT.zh-CN.md','docs/review/CH07_ERRATA.zh-CN.md',
       'docs/review/CH07_SUMMARY_FOR_MENTOR.zh-CN.md']
files += [p.relative_to(ROOT).as_posix() for p in (ROOT/'scripts').glob('ch07_*.py')]
subprocess.run(['git','-c','core.ignorecase=false','add','--',*files],cwd=ROOT,check=True)
logs=[p.relative_to(ROOT).as_posix() for folder in [BASE/'validation',BASE/'closeout'] for p in folder.rglob('*.log')]
if logs:subprocess.run(['git','-c','core.ignorecase=false','add','-f','--',*logs],cwd=ROOT,check=True)
for name in subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines():
    assert name.casefold() in {p.casefold() for p in files} or name.casefold().startswith('blueprint/ch07/'),name
subprocess.run(['git','diff','--cached','--check','--','.',
                ':!blueprint/ch07/validation/**',':!blueprint/ch07/closeout/**'],cwd=ROOT,check=True)
subprocess.run(['git','commit','-m','ch07: complete local workflow and stop at chapter end (118 items)'],cwd=ROOT,check=True)
subprocess.run(['git','push','-u','origin','chapter07-blueprint'],cwd=ROOT,check=True)
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
remote=subprocess.check_output(['git','ls-remote','origin','refs/heads/chapter07-blueprint'],cwd=ROOT,text=True).split()[0]
assert head==remote
verify_frozen()
print('VERIFIED COMMITTED PUSHED',head)
