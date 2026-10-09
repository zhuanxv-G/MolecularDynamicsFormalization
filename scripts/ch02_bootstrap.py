"""Record immutable inputs and establish the user-authorized Chapter 2 entry."""
from pathlib import Path
import hashlib, json, subprocess

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'blueprint/ch02'
BASE.mkdir(parents=True, exist_ok=True)
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
tracked = subprocess.check_output(['git','ls-files'], cwd=ROOT, text=True).splitlines()
protected = [p for p in tracked if p.startswith(('blueprint/ch01/','MolecularDynamics/'))
             or p == 'Blueprint/Ch01.lean' or p.startswith('docs/review/CH01_')]
unrelated = [p for folder in ['output','tmp','docs/review/check-full06','scripts/__pycache__']
             for p in (ROOT/folder).rglob('*') if p.is_file()]
unrelated += [ROOT/'scripts/export_ch01_review_pdf.py']
snapshot = dict(base_head=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
                branch='chapter02-blueprint', protected={p:sha(ROOT/p) for p in protected},
                unrelated={p.relative_to(ROOT).as_posix():sha(p) for p in unrelated},
                source_pdf={p.name:sha(p) for p in ROOT.parent.glob('Leimkuhler2015b*.pdf')})
(BASE/'BASELINE.json').write_text(json.dumps(snapshot,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
task='当前任务：第2章本地五步流程（见 blueprint/ch02/PROGRESS.md）；第1章暂停在等待网站审校（见 blueprint/ch01/mathcopilot_tasks/INDEX.md）。'
next_step='下一步：核对第2章印刷p.53–94/PDF75–116正文，逐节完成JSON、忠实Blueprint、本地预审、compact任务包及证明；从§2.1开始。'
for relative in ['docs/handoff/CURRENT_STATE.zh-CN.md','docs/handoff/RESUME_PROMPT.zh-CN.md']:
    p=ROOT/relative; lines=p.read_text(encoding='utf-8').splitlines()
    lines[2]=task; lines[3]=next_step
    if 'CURRENT_STATE' in relative:
        stop=next((i for i,l in enumerate(lines[4:],4) if l.startswith('## ')),len(lines))
        lines=lines[:4]+['','范围：正文印刷p.53–94（PDF75–116），p.94 Exercises起排除；第3章PDF119起，不进入。',
            '分支：chapter02-blueprint；起点8fac966abdc551c63ddaea7c8504f80f89ff812d。其他任务文件保留、不删不提交。',
            '约束：正式库及第1章交付字节冻结，基线见blueprint/ch02/BASELINE.json；heartbeat lean ACTIVE/15分钟不修改。',
            '验证：已视觉核对章首、正文/习题页界；全章原页、逐字转录、语义和Lean检查随节推进。网站不可用，均待网站审计。','']+lines[stop:]
    else:
        lines=lines[:4]+['',
            '每次唤醒只读AGENTS、CURRENT_STATE顶部、WORK_LOG最新和blueprint/ch02/PROGRESS.md，再按下一步读取相关输入。',
            '第2章按第1章本地五步流程逐节工作，正式库不改且0 sorry；Blueprint允许by sorry。每小批单文件Lean，每节完整scripts/check.ps1及逐条公理审计，每节一次commit并push。',
            '第1章暂停等待网站审校，blueprint/ch01/、Blueprint/Ch01.lean及docs/review/CH01_*逐字节冻结；仅新返回件可在第2章当前节提交后按原EAUDIT规则整合，repair_log只追加，修签名后重审。',
            '第2章每批≤8条A原文审校+C只读语义审计；直接生成PASTE.txt+原页PDF+SHA256 MANIFEST，合计<256000字节，同时保留完整版BATCH。网站未返回写待网站审计，不伪造PASS或冻结。',
            '只证本地PASS；优先桥接→短证明；单条3次失败或缺大型理论保留sorry并继续，导师问题记录后继续。',
            '固定Lean4.34.0/Mathlibv4.34.0。状态仅self-contained / checked+documented priors / incomplete，含sorryAx必须incomplete；唯一逐条表blueprint/ch02/PROGRESS.md。',
            '每检查点更新CURRENT_STATE，WORK_LOG条目≤3行。heartbeat lean保持ACTIVE/15分钟，不进入第3章。',
            '完成标准：全章JSON/Blueprint/本地预审/compact批次齐全、能证已证、7段文档生成、完整check通过、push；完成后第1、2章均等待用户提交批次。']
    p.write_text('\n'.join(lines)+'\n',encoding='utf-8')
p=ROOT/'AGENTS.md'; text=p.read_text(encoding='utf-8'); lines=text.splitlines();lines[2]=task;lines[3]=next_step
text='\n'.join(lines)+'\n'
text=text.replace('## 当前最高优先级范围（2026-10-09用户夜间指令）','## 第1章规则（暂停；仅新返回件整合时适用）')
text=text.replace('heartbeat lean保持ACTIVE/15分钟、不修改；不进入第2章。','heartbeat lean保持ACTIVE/15分钟、不修改；第1章暂停，按下述第2章范围继续，不进入第3章。')
text += '\n## 当前最高优先级范围（2026-10-09第2章新指令）\n\n'
text += '- 第2章正文印刷p.53–94/PDF75–116，习题和参考文献排除；逐字JSON→忠实Blueprint→本地模板C预审与A+C包→PASS条目本地证明→终验与7段文档。旧CH02_CLAIMS.csv的160条全部映射。\n'
text += '- 唯一逐条进度blueprint/ch02/PROGRESS.md；每批≤8条，直接生成compact子任务PASTE.txt、裁原页PDF和SHA256 MANIFEST，指令加附件<256000字节；保留完整版BATCH。\n'
text += '- 第1章全部交付冻结，BASELINE.json保存字节哈希；没有新返回件不碰第1章。新件在第2章当前节提交后按原EAUDIT及repair_log追加规则整合，随后回第2章。\n'
text += '- 共享脚本不改生成器，另写ch02版本；正式库源码和签名不改、保持0 sorry。Blueprint可sorry；其余禁止项、[EXTRA]、[ERRATUM?]、NEEDS_HUMAN和原页渲染要求同第1章。\n'
text += '- 每节一次commit并push已授权；每小批单文件lake env lean，每节完整scripts/check.ps1及逐条#print axioms。单条3次失败或缺大型理论记录继续，不等待导师。\n'
text += '- 每次唤醒只读本文件、CURRENT_STATE顶部、WORK_LOG最新、ch02/PROGRESS，再按下一步读取输入。每检查点更新状态、日志≤3行；不向STATUS/FORMALIZATION_MAP/ASSUMPTIONS追加长文。\n'
text += '- 固定Lean4.34.0/Mathlibv4.34.0，heartbeat lean ACTIVE/15分钟原样，不进入第3章；完成全章及push后第1、2章均等待用户提交MathCopilot批次，仅有新件时整合。\n'
p.write_text(text,encoding='utf-8')
(BASE/'PROGRESS.md').write_text('# 第2章本地五步流程进度\n\n范围：印刷p.53–94 / PDF75–116，Exercises起排除。\n下一步：§2.1原页转录及忠实Blueprint；160旧条全部待映射。网站不可用，待网站审计。\n',encoding='utf-8')
with (ROOT/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-09 第2章第0步\n从8fac966建chapter02-blueprint；入口改为第2章，第1章暂停且字节冻结，其他任务文件保留，heartbeat原样。\n已核对正文p.53–94/PDF75–116页界；下一步§2.1，网站不可用、待审。\n')
print('Recorded',len(protected),'protected and',len(unrelated),'unrelated files; entry updated.')
