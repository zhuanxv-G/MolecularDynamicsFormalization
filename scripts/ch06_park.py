from pathlib import Path
import json, subprocess, shutil
root = Path(__file__).resolve().parents[1]
park = root / 'docs/parked/chapter06-20261008'
park.mkdir(parents=True, exist_ok=True)
public = json.loads((root / 'docs/verification/2026-10-08-LangevinCanonicalKernelConstant/PUBLIC_DECLARATIONS.json').read_text(encoding='utf-8-sig'))
for rel in ['MolecularDynamics/Chapter06/LangevinCanonicalKernelConstant.lean', 'docs/verification/2026-10-08-LangevinCanonicalKernelConstant', 'docs/reviews/2026-10-08-LangevinCanonicalKernelConstant']:
    src = (root / rel).resolve()
    dst = (park / ('formal-source' if src.suffix == '.lean' else src.parent.name) / src.name).resolve()
    assert src.is_relative_to(root.resolve()) and dst.is_relative_to(park.resolve())
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.move(str(src), str(dst))
for rel in ['Scratch.lean','scripts/CheckAxioms.lean']:
    p = root / rel
    s = p.read_text(encoding='utf-8-sig')
    s = '\n'.join(line for line in s.splitlines() if not any(name in line for name in public)) + '\n'
    p.write_text(s.rstrip() + '\n', encoding='utf-8')
p = root / 'MolecularDynamicsFormalization.lean'
s = p.read_text(encoding='utf-8-sig')
lines = s.splitlines()
seen = set()
lines = [line for line in lines if not (line.startswith('import ') and (line in seen or seen.add(line)))]
p.write_text('\n'.join(lines).rstrip()+'\n',encoding='utf-8')
for rel in ['docs/NOTATION_INVENTORY.csv','docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv']:
    p = root/rel
    s=p.read_text(encoding='utf-8-sig')
    p.write_text('\n'.join(line for line in s.splitlines() if 'CanonicalKernelConstant' not in line)+'\n',encoding='utf-8')
for rel in ['ASSUMPTIONS.md','FORMALIZATION_MAP.md']:
    p=root/rel
    s=p.read_text(encoding='utf-8-sig')
    p.write_text('\n'.join(line for line in s.splitlines() if 'CanonicalKernelConstant' not in line).rstrip()+'\n',encoding='utf-8')
(root/'docs/handoff/CHAPTER06_PARKED.zh-CN.md').write_text('''# 第6章暂停断点（2026-10-08）
用户明确暂停第6章；未经用户新指令不得恢复。
已验收：LangevinCanonicalKernelContinuousTest，提交 4b886f4ea5fdb0d91121e915e642f55e312b4643。
停在：CanonicalKernelConstant，粗核函数 reference/canonical 几乎处处常数及零均值核为零的六声明。
local04 退出0；full-check01 在 Scratch 阶段失败，未正式验收，不计成果。
未验收正式候选已移到 docs/parked/chapter06-20261008/formal-source/。
候选源码、原局部日志/退出码、脚本、JSON报告原样位于该目录的 verification/ 与 reviews/。
KernelShift、WeakH1 等已提交验收成果保留；顶层撤销未验收核常数声明检查与重复导入。
恢复后的第一步（仅用户明确恢复后）：读封存 full-check01 的失败日志，检查集成导入；不要重做已验收证明。
完整闭核的反向常数包含、H1密度、实际生成元core、Poisson等仍未证明。
当前下一步只执行第1章正文清单与审阅交付。
''',encoding='utf-8')
p=root/'docs/handoff/CURRENT_STATE.zh-CN.md'
s=p.read_text(encoding='utf-8').replace('第0步：旧聊天仍在运行第6章 full-check01，尚未完成；等待停止共享写入后判定验收或封存，不做新数学。','第0步：CanonicalKernelConstant full-check01 失败，原样封存；基线4b886f4，详见CHAPTER06_PARKED.zh-CN.md。正在验证顶层并备份。')
p.write_text(s,encoding='utf-8')
with (root/'docs/handoff/WORK_LOG.zh-CN.md').open('a',encoding='utf-8') as f:
    f.write('\n## 2026-10-08 第6章封存\nCanonicalKernelConstant完整报告失败；源码/证据原样移至docs/parked/chapter06-20261008，正式库已撤去其检查。\n下一步：顶层验证与commit/push，然后只做第1章。\n')
print('Chapter06 candidate parked unchanged; imports/checks cleaned.')
