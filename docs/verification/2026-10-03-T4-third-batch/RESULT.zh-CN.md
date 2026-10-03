# T4 局部唯一性扩展验收

- 时间：2026-10-03 14:42–14:52 +08:00。
- 工程基点：提交 `9e146e83d1747fb7cc4194b0b67fdbce8cb955eb` 之前的工作树；本批新增 `LocalExistence.lean` 的 C¹ 初始状态附近唯一性定理及其 Scratch/公理审计入口。完整输入哈希见 `CHECK_REPORT.json`。
- 失败尝试：`T4-second-batch` 因把 `set_option ... in` 放在命名定理前的命令位置不被 Lean 4.34.0 接受，lake build 在 `LocalExistence.lean` 失败；该报告保留为失败证据，不作验收结果。修正为文件级 `set_option maxHeartbeats 100000` 后重新执行。
- 成功命令：`pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T4-third-batch`，使用本地固定 Lean 4.34.0 的 bin 目录。退出0；版本和 mathlib revision 匹配；源码扫描通过；8935 jobs 构建、Scratch 编译和 184 个项目声明的依赖审计通过。新定理依赖只含 `propext`、`Classical.choice`、`Quot.sound`。
- 数学范围：C¹ 力场给出局部解；机械场在共同初始状态 C¹ 时，两条已存在于同一开放时间集的解在初始时刻邻域内相等；全局 Lipschitz 版本仍给出整个共同开区间的相等；能量和逐方向总动量结果保持不变。
- 未验证：该新快照的远端 CI；MathCopilot 独立完整证明审阅；最大/全局解延拓和完整 Theorem 1.1；负责人最终教材语义签核。
