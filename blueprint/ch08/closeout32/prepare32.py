from pathlib import Path
import json, hashlib, subprocess
ROOT=Path(__file__).resolve().parents[3]
OUT=Path(__file__).resolve().parent
BASE=OUT.parent
def load(p): return json.loads(Path(p).read_text(encoding='utf-8-sig'))
def dump(p,d): Path(p).write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
def sha(p): return hashlib.sha256(Path(p).read_bytes()).hexdigest()
d=load(BASE/'closeout31/HEARTBEAT_REQUEST.json')
old=d['prompt']; middle=old[old.index('每次唤醒'):old.index('停止条件为31号')]
d['prompt']='按32号继续第8章收口。\n先核对AGENTS、CURRENT_STATE顶部、WORK_LOG最新及blueprint/ch08/PROGRESS.md，从最近已验证检查点接续；先 git status 并复用已通过证据。\n唯一任务为第8章最终收口；第1–7章与MolecularDynamics/正式库字节冻结，不再送网站、不生成新EAUDIT包。\n\n第32号全文见blueprint/ch08/USER_INSTRUCTION_32.zh-CN.md。登记10条复审（2 PASS/0 FAIL/8 NEEDS_HUMAN），只修元数据和文档，分版登记、目视核对原页，最后一次完整check、提交并push。\n\n'+middle+'停止条件为32号第5节：第8章FAIL修复中=0；一次完整check通过；正式库0 sorry、0 axiom；第1–7章文件字节未变；提交并push；CURRENT_STATE顶部为“第8章最终收口完成；全书第1–8章正文收口，等待用户新指令”。达到后停止发送，ACTIVE配置保留，然后停止。'
dump(OUT/'HEARTBEAT_REQUEST.json',d)
paths=list((ROOT/'MolecularDynamics').rglob('*'))
for n in range(1,8):
 paths+=list((ROOT/f'blueprint/ch{n:02}').rglob('*'))+[ROOT/f'Blueprint/Ch{n:02}.lean']+list((ROOT/'docs/review').glob(f'CH{n:02}_*'))
paths+=list((BASE/'mathcopilot_tasks').rglob('*'))+[ROOT/'Blueprint/Ch08.lean']
if not (OUT/'FROZEN_BASELINE.json').exists():
 dump(OUT/'FROZEN_BASELINE.json',{p.relative_to(ROOT).as_posix():sha(p) for p in paths if p.is_file()})
 dump(OUT/'INITIAL_GIT_STATUS.json',dict(head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),status=subprocess.check_output(['git','status','--short'],cwd=ROOT,text=True)))
for name in ['ch08_source.json','website_audit.json','local_audit.json','proof_attempts.json']:
 dest=OUT/(Path(name).stem+'.before.json')
 if not dest.exists(): dest.write_bytes((BASE/name).read_bytes())
print(json.dumps(d,ensure_ascii=False))
