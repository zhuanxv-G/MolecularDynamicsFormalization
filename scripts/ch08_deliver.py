"""Commit and push only the authorized final chapter-8 delivery."""
from ch08_pipeline import *

def main():
    c=json.loads((BASE/'closeout/COMPLETION.json').read_text(encoding='utf-8'))
    assert c['machine_check_status']=='passed' and c['body_all_items_on_disk'] and c['final_full_check_passed']
    assert c['canonical_sha256']==sha(ROOT/'Blueprint/Ch08.lean')
    assert c['source_json_sha256']==sha(BASE/'ch08_source.json')
    assert c['full_report_sha256']==sha(ROOT/c['full_report'])
    assert c['missing_project_definitions']==0 and not c['website_submitted']
    verify_frozen()
    assert subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip()=='chapter08-blueprint'
    files=['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md',
      'docs/handoff/WORK_LOG.zh-CN.md','Blueprint/Ch08.lean','blueprint/ch08',
      'docs/review/CH08_BLUEPRINT.zh-CN.md','docs/review/CH08_ERRATA.zh-CN.md','docs/review/CH08_SUMMARY_FOR_MENTOR.zh-CN.md']
    files += [p.relative_to(ROOT).as_posix() for p in (ROOT/'scripts').glob('ch08_*.py')]
    for line in subprocess.check_output(['git','ls-files','--stage'],cwd=ROOT,text=True).splitlines():
        meta,name=line.split('\t',1)
        if name.startswith('Blueprint/ch08/'):
            mode,blob,stage=meta.split();assert stage=='0'
            subprocess.run(['git','update-index','--force-remove','--',name],cwd=ROOT,check=True)
            subprocess.run(['git','update-index','--add','--cacheinfo',mode,blob,'blueprint/ch08/'+name[len('Blueprint/ch08/'):]],cwd=ROOT,check=True)
    subprocess.run(['git','-c','core.ignorecase=false','add','--',*files],cwd=ROOT,check=True)
    logs=[p.relative_to(ROOT).as_posix() for p in (BASE/'validation').rglob('*.log')]
    logs += [p.relative_to(ROOT).as_posix() for p in (BASE/'closeout').rglob('*.log')]
    if logs:subprocess.run(['git','-c','core.ignorecase=false','add','-f','--',*logs],cwd=ROOT,check=True)
    blob=subprocess.check_output(['git','hash-object','-w','--','Blueprint/Ch08.lean'],cwd=ROOT,text=True).strip()
    for name in subprocess.check_output(['git','ls-files'],cwd=ROOT,text=True).splitlines():
        if name.casefold()=='blueprint/ch08.lean' and name!='Blueprint/Ch08.lean':
            subprocess.run(['git','update-index','--force-remove','--',name],cwd=ROOT,check=True)
    subprocess.run(['git','update-index','--add','--cacheinfo','100644',blob,'Blueprint/Ch08.lean'],cwd=ROOT,check=True)
    staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
    for name in staged:
        assert name.casefold() in {p.casefold() for p in files} or name.casefold().startswith('blueprint/ch08/'),('Unrelated staged file',name)
    subprocess.run(['git','commit','-m',f'ch08: complete local blueprint and {c["batches"]} review batches ({c["entries"]} items)'],cwd=ROOT,check=True)
    subprocess.run(['git','push','-u','origin','chapter08-blueprint'],cwd=ROOT,check=True)
    print('COMMITTED AND PUSHED',subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),flush=True)

if __name__=='__main__':main()
