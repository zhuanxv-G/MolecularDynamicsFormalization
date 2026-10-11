"""Explicit staging with canonical Blueprint/ vs blueprint/ paths on Windows."""
import re,subprocess,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def canonical(p):
    if re.match(r'(?i)^blueprint/ch\d\d/',p):return 'blueprint/'+p.split('/',2)[1].lower()+'/'+p.split('/',2)[2]
    if re.fullmatch(r'(?i)blueprint/ch\d\d\.lean',p):return 'Blueprint/'+Path(p).name[0].upper()+Path(p).name[1:]
    return p
def stage(paths,allow_ch01_return=False):
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
    owned_files={}
    for p in files:
        relative=canonical(p.relative_to(ROOT).as_posix())
        forbidden=('MolecularDynamics/','output/','tmp/','docs/review/check-full06/','scripts/__pycache__/')
        if not allow_ch01_return:forbidden+=('blueprint/ch01/','docs/review/CH01_')
        assert not relative.startswith(forbidden)
        assert not any(c in relative for c in '\n\r\0')
        owned_files[relative]=p
    # --stdin-paths applies the same per-path attributes as --path. A single
    # process avoids thousands of Windows process launches per checkpoint.
    relative_paths=list(owned_files)
    blob_input=''.join(json.dumps(p,ensure_ascii=False)+'\n' for p in relative_paths).encode('utf-8')
    blobs=subprocess.check_output(['git','hash-object','-w','--stdin-paths'],cwd=ROOT,input=blob_input).decode().splitlines()
    assert len(blobs)==len(relative_paths) and all(re.fullmatch('[0-9a-f]{40}',b) for b in blobs)
    payload=['100644 '+blob+'\t'+relative+'\0' for relative,blob in zip(relative_paths,blobs)]
    subprocess.run(['git','-c','core.ignorecase=false','update-index','-z','--index-info'],cwd=ROOT,input=''.join(payload).encode(),check=True)
    staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
    assert all(canonical(p)==p for p in staged)
    forbidden=('MolecularDynamics/','output/','tmp/','docs/review/check-full06/','scripts/__pycache__/')
    if not allow_ch01_return:forbidden+=('blueprint/ch01/','docs/review/CH01_')
    assert not any(p.startswith(forbidden) for p in staged)
