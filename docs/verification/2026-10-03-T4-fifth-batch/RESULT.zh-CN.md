# T4 第五批完整本地验收

新增 MomentumBounds.lean（5 个完整定理）和 MechanicalConfinement.lean（2 个完整定理），顶层、Scratch 与 CheckAxioms 已集成。实际 `scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T4-fifth-batch` 退出码 0。

- 固定 Lean 4.34.0、mathlib 5ed2965256430c3649e86755f9576b54eca72435；源码扫描通过。
- lake build：8938 jobs，退出 0。
- Scratch：退出 0；关键新定理 #print axioms 仅标准逻辑依赖。
- 全命名空间公理审计：201 imported project declarations；允许项仅 propext、Classical.choice、Quot.sound。
- 受检输入哈希前后稳定；具体开始/结束时刻与每项日志 SHA 在 CHECK_REPORT.json。
- 当前结果不证明最大/全局延拓，也不证明完整 Theorem 1.1。独立网站本批只覆盖固定9baf的T2/T5；新T4网站复核和负责人最终语义签核尚未完成。

探索失败：首个单文件检查未返回诊断，已停止本次进程；第二次报三项错误，原因是 positivity/field_simp 未显式取得 hm i。改为明确的正分母和非零质量证明后本次完整验收通过。失败不计成功。
