"""Stage exact Chapter 2 paths on case-insensitive Windows filesystems."""
import subprocess
from ch02_data import ROOT
def canonical(p):
    if p.lower().startswith('blueprint/ch02/'):return 'blueprint/ch02/'+p.split('/',2)[2]
    if p.lower()=='blueprint/ch02.lean':return 'Blueprint/Ch02.lean'
    return p
def stage(paths):
    entries=subprocess.check_output(['git','ls-files','--stage'],cwd=ROOT,text=True).splitlines()
    remove=[]
    for e in entries:
        meta,path=e.split('\t',1)
        if canonical(path)!=path:remove.append('0 '+'0'*40+'\t'+path+'\0')
    if remove:subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=''.join(remove).encode('utf-8'),check=True)
    files=[]
    for relative in paths:
        p=ROOT/relative
        files.extend(x for x in p.rglob('*') if x.is_file()) if p.is_dir() else files.append(p)
    payload=[]
    for p in files:
        relative=canonical(p.relative_to(ROOT).as_posix())
        blob=subprocess.check_output(['git','hash-object','-w','--path='+relative,str(p)],cwd=ROOT,text=True).strip()
        payload.append('100644 '+blob+'\t'+relative+'\0')
    subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=''.join(payload).encode('utf-8'),check=True)
    indexed=subprocess.check_output(['git','ls-files'],cwd=ROOT,text=True).splitlines()
    assert all(canonical(p)==p for p in indexed),'Noncanonical index path'
    assert 'Blueprint/Ch02.lean' in indexed,'Blueprint source not staged'

if __name__=='__main__':
    stage(['.gitattributes','Blueprint/Ch02.lean','blueprint/ch02','scripts/ch02_stage.py'])
