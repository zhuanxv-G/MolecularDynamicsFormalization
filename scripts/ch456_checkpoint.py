"""Short, durable chapter 4-6 checkpoints; leave heartbeat configuration untouched."""
from pathlib import Path
import sys, re, subprocess
root=Path(__file__).resolve().parents[1]
phase,next_step=sys.argv[1:3]
task='依次完成第4、5、6章审阅交付。第1-3章冻结；第6章封存成果可复用但不得在此阶段做新证明。第6章完成后停止等待用户。'
if phase.startswith('第4章已交付'):
    task='第4章已交付审阅，正在进行第5章；随后仅映射第6章既有成果。第1-3章冻结；第6章封存断点不恢复、不做新证明；完成后停止等待用户。'
if phase.startswith('第5章已交付'):
    task='第4、5章已交付审阅，正在进行第6章既有成果映射；不做新证明、不恢复封存断点。第1-3章冻结；第6章交付后停止等待用户。'
if phase=='第4、5、6章已交付审阅，等待用户指示':
    task='第4、5、6章已交付审阅，等待用户指示。以后每次唤醒只确认该状态，不做新的数学工作，不进入第7章。第1-3章冻结；第6章封存断点保持原样。'
head=subprocess.check_output(['git','rev-parse','--short','HEAD'],cwd=root,text=True).strip()
branch=subprocess.check_output(['git','branch','--show-current'],cwd=root,text=True).strip()
(root/'docs/handoff/CURRENT_STATE.zh-CN.md').write_text(
    '# 当前可操作状态\n\n当前任务：'+task+'\n\n阶段：'+phase+'\n下一步：'+next_step+
    '\n\n分支：'+branch+'；检查点HEAD：'+head+'；未提交文件以git status --short为准。\n'
    '第1-3章冻结；第6章CanonicalKernelConstant等封存断点保持原样。\n'
    'heartbeat lean保持ACTIVE及15分钟频率，未修改。\n'
    '每次唤醒只读AGENTS.md、本文件顶部、WORK_LOG最新条目和当前章CLAIMS.csv。\n'
    'Prop陈述不是证明；机器验收以各章VALIDATION.json为准，导师语义审阅待完成。\n',encoding='utf-8')
for filename,prefix in [('AGENTS.md','当前阶段：'),('docs/handoff/RESUME_PROMPT.zh-CN.md','当前任务：')]:
    p=root/filename;s=p.read_text(encoding='utf-8-sig')
    s=re.sub(re.escape(prefix)+r'[^\n]*',prefix+task,s,count=1)
    p.write_text(s,encoding='utf-8')
with (root/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-08 第4/5/6章：'+phase+'\n下一步：'+next_step+'\n')
print(phase)
