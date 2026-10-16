"""Stage only explicit chapter-1 files without repeated Windows directory probes."""
import sys,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];sys.path.insert(0,str(ROOT/'scripts'))
from local_stage import canonical

def stage():
    candidates=subprocess.check_output(['git','ls-files','--modified','--others','--exclude-standard'],cwd=ROOT,text=True,encoding='utf-8').splitlines()
    exact={'AGENTS.md','Blueprint/Ch01.lean','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','docs/handoff/LEAN_HEARTBEAT_UPDATE.json','docs/handoff/LOCAL_PIPELINE.md','docs/review/CH01_BLUEPRINT.zh-CN.md','docs/review/CH01_ERRATA.zh-CN.md','docs/review/CH01_SUMMARY_FOR_MENTOR.zh-CN.md'}
    paths=sorted({canonical(x) for x in candidates if (x in exact or x.startswith('blueprint/ch01/')) and '__pycache__' not in x and not x.endswith('.pyc') and (ROOT/x).is_file()})
    assert all('\n' not in x and '\0' not in x for x in paths)
    tracked=subprocess.check_output(['git','ls-files','--stage'],cwd=ROOT,text=True).splitlines()
    removals=[]
    for line in tracked:
        _,p=line.split('\t',1)
        if canonical(p)!=p:removals.append('0 '+'0'*40+'\t'+p+'\0')
    if removals:subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=''.join(removals).encode(),check=True)
    hashes=subprocess.check_output(['git','hash-object','-w','--stdin-paths'],cwd=ROOT,input=''.join(json.dumps(p,ensure_ascii=False)+'\n' for p in paths).encode()).decode().splitlines()
    assert len(hashes)==len(paths)
    payload=''.join('100644 '+h+'\t'+p+'\0' for p,h in zip(paths,hashes))
    subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=payload.encode(),check=True)
    staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
    assert set(staged)<=set(paths) and all(canonical(p)==p for p in staged)
    assert not any(p.startswith(('MolecularDynamics/','blueprint/ch02/','blueprint/ch03/','blueprint/ch04/','blueprint/ch05/','blueprint/ch06/')) for p in staged)
    print('Staged',len(staged),'owned chapter-1 and handoff files',flush=True)

if __name__=='__main__':stage()
