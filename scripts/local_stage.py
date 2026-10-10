"""Explicit staging with canonical Blueprint/ vs blueprint/ paths on Windows."""
import re,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def canonical(p):
    if re.match(r'(?i)^blueprint/ch\d\d/',p):return 'blueprint/'+p.split('/',2)[1].lower()+'/'+p.split('/',2)[2]
    if re.fullmatch(r'(?i)blueprint/ch\d\d\.lean',p):return 'Blueprint/'+Path(p).name[0].upper()+Path(p).name[1:]
    return p
def stage(paths):
    entries=subprocess.check_output(['git','ls-files','--stage'],cwd=ROOT,text=True).splitlines()
    removals=[]
    for e in entries:
        meta,p=e.split('\t',1)
        owned=any(p.startswith(x.rstrip('/')+'/') for x in paths if (ROOT/x).is_dir())
        if canonical(p)!=p or (owned and not (ROOT/p).exists()):removals.append('0 '+'0'*40+'\t'+p+'\0')
    if removals:subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=''.join(removals).encode(),check=True)
    files=[]
    for relative in paths:
        p=ROOT/relative
        files.extend(x for x in p.rglob('*') if x.is_file()) if p.is_dir() else files.append(p)
    payload=[]
    for p in files:
        relative=canonical(p.relative_to(ROOT).as_posix())
        assert not relative.startswith(('MolecularDynamics/','blueprint/ch01/','output/','tmp/','docs/review/check-full06/','scripts/__pycache__/','docs/review/CH01_'))
        blob=subprocess.check_output(['git','hash-object','-w','--path='+relative,str(p)],cwd=ROOT,text=True).strip()
        payload.append('100644 '+blob+'\t'+relative+'\0')
    subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=''.join(payload).encode(),check=True)
    staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
    assert all(canonical(p)==p for p in staged)
    assert not any(p.startswith(('MolecularDynamics/','blueprint/ch01/','output/','tmp/','docs/review/check-full06/','scripts/__pycache__/','docs/review/CH01_')) for p in staged)
