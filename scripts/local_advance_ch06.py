"""Land <=8 entries at a time; stop on diagnostics, not on user confirmations."""
import argparse,json,subprocess,hashlib
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
PY=__import__('sys').executable
a=argparse.ArgumentParser();a.add_argument('section');a.add_argument('modules',nargs='+')
a.add_argument('--proofs',nargs='*',default=[]);a.add_argument('--next',required=True)
a.add_argument('--resume-after-batches',action='store_true')
x=a.parse_args();assert len(x.proofs)<=8
base=ROOT/'blueprint/ch06';data=ROOT/'scripts/ch06_data.py'
def call(args):
    print('Running:', ' '.join(map(str,args)),flush=True)
    subprocess.run(list(map(str,args)),cwd=ROOT,check=True)
def generate(label):
    # The axiom probe is the entire canonical source followed by #print commands;
    # one fresh Lean invocation therefore performs both batch checks.
    call([PY,'scripts/local_blueprint.py','6','--batch',label,
          '--step','③–⑤§'+x.section+'逐批验证'])
    call([PY,'scripts/ch06_batch_axioms.py',label])
    call([PY,'scripts/ch06_sync22.py'])
for module in x.modules:
    assert module.startswith('ch06_section') and (ROOT/'scripts'/f'{module}.py').exists()
    old=data.read_text(encoding='utf-8')
    before=len(json.loads((base/'ch06_source.json').read_text(encoding='utf-8')))
    if x.resume_after_batches:
        assert 'import '+module+'\n' in old,module
        continue
    if 'import '+module+'\n' not in old:
        assert '\nimport json\n' in old
        data.write_text(old.replace('\nimport json\n','\nimport '+module+'\nimport json\n',1),encoding='utf-8')
        count=int(subprocess.check_output([PY,'-c',
            "import sys;sys.path.insert(0,'scripts');import ch06_data;print(len(ch06_data.RECORDS))"],cwd=ROOT,text=True))
        assert 0<count-before<=8,(module,before,count)
    label=module.removeprefix('ch06_')+'-'+hashlib.sha256((ROOT/'scripts'/f'{module}.py').read_bytes()).hexdigest()[:8]
    generate(label)
if x.proofs:
    call([PY,'scripts/local_short_search.py','6',*x.proofs])
    for key in x.proofs:
        routes=json.loads((base/'validation/short_search'/f'{key}.json').read_text(encoding='utf-8'))
        assert any(r['exit_code']==0 for r in routes) or len(routes)>=3, 'Inspect and revise bounded proof route: '+key
    digest=hashlib.sha256(''.join((base/'validation/short_search'/f'{k}.json').read_text(encoding='utf-8') for k in x.proofs).encode()).hexdigest()[:10]
    generate('sec'+x.section+'-proofs-'+digest)
folder='blueprint/ch06/validation/section'+x.section.replace('.','')
call([PY,'scripts/local_section_check.py','6',folder,'--reuse-shared',
      'blueprint/ch01/validation/CLOSEOUT21/full'])
call([PY,'scripts/local_checkpoint.py','6',x.section,folder,x.next])
print('SECTION COMMITTED AND PUSHED:',x.section,flush=True)
