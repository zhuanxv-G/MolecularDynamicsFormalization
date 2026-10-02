# T2 第一批正式本地验收

2026-10-03，Asia/Shanghai。固定 Lean 4.34.0 / mathlib
`5ed2965256430c3649e86755f9576b54eca72435`，分支
`chapter01-kinetic-energy-nonneg`，检查起始 HEAD
`121a9d02ad15500c630e505b363d5f04106d617f`。

## 已实际验证

- `pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T2-first-batch` 退出0。
- 配置和实际 Lean/mathlib 固定版本、无 mathlib tracked 修改、源码扫描、正式库构建（8930 jobs）、Scratch 和全导入项目命名空间公理审计（93声明）通过。
- 对 L0、S1、B1–B4、E1 与初值域成员辅助定理显式打印公理；仅含 `propext`、`Classical.choice`、`Quot.sound`。全命名空间审计覆盖未单列的辅助声明。
- 检查开始和结束时所有受检输入 SHA256 一致；原命令、时间、输入列表和日志哈希由 `CHECK_REPORT.json` 记录。
- 之前草稿 attempt01 的 B4 函数复合展开失败已保存；加 `Function.comp_apply` 后 attempt02 退出0，没有诊断。最终正式库额外包括限制时间域、连续性、初始域成员三条辅助证明。

## 数学范围

`LocalTrajectories.lean` 包含五个定义与十五条完整定理证明，对应七个首批规格 ID及必要语义/接口辅助结果。实际重看教材印刷18–19/PDF41–42及此前本轮重看的印刷24/PDF47，核对正负号、速度/动量和固定质量关系。二阶桥接只在开放时间集合使用普通双侧导数；反向桥接已给双侧导数，故不增开集假设。

B3 的代数层使用显式力模型关系；势能可微应用层及独立 HasGradientAt 结论暴露真实梯度语义。自由粒子是明确构造的初值解，不能据此推广到任意力场。

## 尚未验证或完成

- 本报告不包含新 T2 GitHub CI 结果，后续另存。
- MathCopilot 已完成并返回首批陈述审阅；此前网站 S1 起草在17秒后因旧账户额度失败，没有完成草稿。本地完整证明的独立网站审阅仍待完成。
- 负责人最终教材语义签核 pending。机器验收不替代该签核。
- 一般局部存在、唯一性、闭区间端点二阶导数、最大解延拓、全局流、能量守恒和 Theorem1.1 均未由本批证明。
