# 第6章暂停断点（2026-10-08）
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
