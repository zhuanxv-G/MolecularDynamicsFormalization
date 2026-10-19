from pathlib import Path
import sys,subprocess,hashlib
sys.path.insert(0,str(Path(__file__).resolve().parent.parent/'closeout31'))
from common31 import ROOT,load,dump,sha
OUT=Path(__file__).resolve().parent
assert load(OUT/'DELIVERY_VALIDATION.json')['status']=='PASS'
assert load(OUT/'COMPLETION.json')['status']=='PASS'
assert subprocess.check_output(['git','branch','--show-current'],cwd=ROOT,text=True).strip()=='chapter08-blueprint'
existing=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
fixed=['AGENTS.md','docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/WORK_LOG.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md','blueprint/ch08/USER_INSTRUCTION_32.zh-CN.md','blueprint/ch08/PROGRESS.md','blueprint/ch08/LOCAL_PIPELINE.md','blueprint/ch08/WEBSITE_SUMMARY.json','blueprint/ch08/ch08_source.json','blueprint/ch08/local_audit.json','blueprint/ch08/website_audit.json']
fixed += [f'docs/review/CH08_{n}.zh-CN.md' for n in ['BLUEPRINT','ERRATA','SUMMARY_FOR_MENTOR']]
files=fixed+[p.relative_to(ROOT).as_posix() for p in OUT.rglob('*') if p.is_file() and '__pycache__' not in p.parts]
files += [p.relative_to(ROOT).as_posix() for p in (OUT.parent/'mathcopilot_results/eaudit').glob('EAUDIT*_result.json')]
assert set(existing)<=set(files),('Unexpected staged paths',set(existing)-set(files))
subprocess.run(['git','-c','core.ignorecase=false','add','-f','--',*files],cwd=ROOT,check=True)
staged=subprocess.check_output(['git','diff','--cached','--name-only'],cwd=ROOT,text=True).splitlines()
allowed=set(files)
exact=0;normalized=[]
for name in staged:
 assert name in allowed,name
 actual=subprocess.check_output(['git','show',':'+name],cwd=ROOT)
 if name.startswith('blueprint/ch08/'):
  assert hashlib.sha256(actual).hexdigest()==sha(ROOT/name),('staged bytes differ',name)
  exact+=1
 else:
  assert actual.replace(b'\r\n',b'\n')==(ROOT/name).read_bytes().replace(b'\r\n',b'\n'),('staged content differs',name)
  normalized.append(name)
subprocess.run(['git','diff','--cached','--check'],cwd=ROOT,check=True)
dump(OUT/'STAGED_BYTE_CHECK.json',dict(status='PASS',staged_files_before_receipt=len(staged),all_paths_authorized=True,exact_ch08_files=exact,documentation_line_endings_normalized=normalized,note='第8章所有返回、元数据、日志及收口证据原始字节相等；根规则和文档按Git既有CRLF/LF规则比较内容。',excluded='第1–7章既存日志、全部既存无关文件及运行缓存未暂存'))
subprocess.run(['git','-c','core.ignorecase=false','add','--','blueprint/ch08/closeout32/STAGED_BYTE_CHECK.json'],cwd=ROOT,check=True)
subprocess.run(['git','commit','-m','ch08: finalize re-audit closeout without Lean changes (instruction 32)'],cwd=ROOT,check=True)
subprocess.run(['git','push','origin','chapter08-blueprint'],cwd=ROOT,check=True)
head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
remote=subprocess.check_output(['git','ls-remote','origin','refs/heads/chapter08-blueprint'],cwd=ROOT,text=True).split()[0]
assert head==remote
assert sha(ROOT/'Blueprint/Ch08.lean')=='a58849c40e30a4a6b189163f42a49e0cbdf00bd48a39a77048bfd04ff88f8a16'
assert not subprocess.check_output(['git','diff','--name-only',head,'--',*fixed],cwd=ROOT).strip()
print('COMMITTED AND REMOTE VERIFIED',head,flush=True)
