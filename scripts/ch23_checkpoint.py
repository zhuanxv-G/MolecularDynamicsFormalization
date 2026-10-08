"""Maintain the chapter 2/3 resumption entry without changing automation."""
from pathlib import Path
from datetime import datetime
import sys, re

root = Path(__file__).resolve().parents[1]
phase = sys.argv[1]
next_step = sys.argv[2]
task = ('第2章审阅交付（docs/review/CH02_CLAIMS.csv），完成后自动进行第3章（CH03_CLAIMS.csv），'
        '第3章交付后停止并等待用户。第1章已交付待导师审阅，不再修改；第6章仍暂停。')
if phase.startswith('第3章') or phase == '第2章已交付审阅，正在进行第3章':
    task = '第2章已交付审阅，正在进行第3章（docs/review/CH03_CLAIMS.csv）；第3章交付后停止并等待用户。第1章冻结；第6章仍暂停。'
if phase == '第2、3章已交付审阅，等待用户指示':
    task = '第2、3章已交付审阅，等待用户指示。以后每次唤醒只确认此状态，不做新的数学工作，不进入第4章。第1章冻结；第6章仍暂停。'
state = root / 'docs/handoff/CURRENT_STATE.zh-CN.md'
state.write_text('# 当前可操作状态\n\n当前任务：' + task + '\n\n阶段：' + phase + '\n下一步：' + next_step + '\n\n'
                 '第1章冻结（源码及审阅材料）；第6章暂停。heartbeat lean保持原ACTIVE/15分钟配置，未修改。\n'
                 '每次唤醒只读AGENTS.md、本文件顶部、WORK_LOG最新条目及当前章CLAIMS.csv；按下一步接续。\n'
                 '验证状态以当前章验收文件为准；Prop陈述不计为完整证明，导师语义审阅待完成。\n', encoding='utf-8')
if phase == '接续入口已改写':
    p = root / 'AGENTS.md'
    s = p.read_text(encoding='utf-8-sig')
    start = s.index('- 2026-10-08 用户最高优先级新指令：')
    end = s.index('\n- 2026-10-04 用户重新限定', start)
    s = s[:start] + '''- 2026-10-08 用户最高优先级新指令：当前任务是第2章审阅交付（docs/review/CH02_CLAIMS.csv），完成并push后自动进行第3章（CH03_CLAIMS.csv）；第3章交付后停止并等待用户，不进入第4章。第1章已交付待导师审阅，冻结源码和审阅材料；仅复用时发现编译问题可修并记日志；第6章仍暂停。
- 当前章依次执行：逐页正文清单并提交 → 忠实Lean陈述与限时证明 → 完整/10–15重点审阅材料 → scripts/check.ps1、公理审计、commit与push。状态使用defined/proved/statement_only/weakened/not_formalizable_now，defined与proved分别统计，已证明结论只计proved。
- 未证内容写在当前章Statements.lean，格式def name_statement : Prop := ...；不得写True或把结论藏进假设。每条三次候选验收失败或缺大型理论时降级并继续。Theorem 3.1先给完整忠实陈述，仅证明有限截断/已有引理组合，不搭建大型后向误差一般理论。
- 每个阶段更新CURRENT_STATE顶部下一步；每检查点WORK_LOG不超过3行；只维护当前章CLAIMS与审阅材料，不向历史进度文档追加长篇，不复制Draft，源码未变不重算哈希。每次唤醒只读本文件、CURRENT_STATE顶部、WORK_LOG最新条目及当前章CLAIMS.csv。heartbeat lean保持ACTIVE及原15分钟频率，不关闭、删除或修改。
''' + s[end:]
    s = s.replace('上面的第1章 Prop 陈述规则', '上面的当前章 Prop 陈述规则').replace('当前阶段只更新第1章清单和简短交接。', '当前阶段只更新第2/3章清单和简短交接。')
    p.write_text(s, encoding='utf-8')
    (root / 'docs/handoff/RESUME_PROMPT.zh-CN.md').write_text('''# 接续提示词

当前任务：''' + task + '''

只读AGENTS.md、CURRENT_STATE顶部、WORK_LOG最新条目和当前章CLAIMS.csv，按CURRENT_STATE的下一步继续，不重复已提交阶段。
第2章：清单提交→忠实陈述/限时证明→两份审阅材料→完整验收、公理审计、commit与push；完成后写「第2章已交付审阅，正在进行第3章」并直接执行第3章同流程。
第3章Theorem 3.1只做完整忠实陈述及有限时间内可证部分，不搭建大型一般理论。完成push后写「第2、3章已交付审阅，等待用户指示」，以后唤醒只确认状态，不进入第4章。
第1章冻结，第6章暂停；heartbeat lean保持ACTIVE/15分钟，禁止关闭、删除或修改。每条三次候选失败就降级并继续；defined与proved分开统计，Prop定义不算证明。
''', encoding='utf-8')
else:
    p=root/'AGENTS.md';s=p.read_text(encoding='utf-8-sig')
    s=re.sub(r'\n当前阶段：[^\n]*\n','\n',s)
    s=re.sub(r'\n{3,}', '\n\n', s)
    s=s.replace('# 项目接续与形式化约定\n','# 项目接续与形式化约定\n\n当前阶段：'+task+'\n',1)
    s=s.replace('当前任务是第2章审阅交付','本次任务顺序是第2章审阅交付')
    p.write_text(s,encoding='utf-8')
    p=root/'docs/handoff/RESUME_PROMPT.zh-CN.md';s=p.read_text(encoding='utf-8-sig')
    s=re.sub(r'当前任务：[^\n]*','当前任务：'+task,s,count=1)
    p.write_text(s,encoding='utf-8')
with (root / 'docs/handoff/WORK_LOG.zh-CN.md').open('a', encoding='utf-8') as f:
    f.write('\n## 2026-10-08 第2/3章：' + phase + '\n下一步：' + next_step + '\n')
print(phase, next_step)
