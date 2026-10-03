# T4 首批正式机器验收

- 时间：2026-10-03 13:56–13:59 +08:00。
- 工程基点：`21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1`；T4 源码为验收时工作树输入，逐件 SHA256 见 `CHECK_REPORT.json`。
- 命令：`pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T4-first-batch`，进程 PATH 先置本地固定 Lean 4.34.0 的 bin 目录，以避免 elan 联网更新失败。
- 结果：退出0；工具链 Lean 4.34.0、mathlib `5ed2965256430c3649e86755f9576b54eca72435` 匹配；源码扫描通过；`lake build` 8935 jobs 成功；`Scratch.lean` 编译成功；182 个项目声明的依赖审计通过。关键新定理只依赖 `propext`、`Classical.choice`、`Quot.sound`。原日志和哈希在本目录。
- 范围：已有保守机械解的能量守恒；C¹ 力场给出局部初值解；全局 Lipschitz 场下唯一性；逐方向合力为零时总动量守恒。教材原页已视觉核对印刷19/PDF42和印刷24/PDF47；这不是负责人最终语义签核。
- 未验证：此源码快照的远端 CI；MathCopilot 完整证明独立审阅；局部 C¹ 条件下唯一性、最大/全局解和完整稳定性定理。
