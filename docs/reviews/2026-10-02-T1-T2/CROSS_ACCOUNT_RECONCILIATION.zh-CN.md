# 跨账户接续：T1/T2 网站审阅回执与本地陈述修订

检查时间：2026-10-02 22:07 +08:00（Asia/Shanghai）。这是对中断后已保存证据的核对和新增类型探针，不是 T1/T2 原网站报告的完整取回，也不是新的 T2 证明。

## 实际恢复的状态

- 本地分支 `chapter01-kinetic-energy-nonneg`，HEAD `121a9d02ad15500c630e505b363d5f04106d617f`，mathlib HEAD `5ed2965256430c3649e86755f9576b54eca72435`。当前 `NBody.lean` 与 `ParticleCoordinates.lean` SHA256 分别为 `45a16307a724348917d8bd9f9eab47cd1a74ec54ba32b468a0e8ead670432696` 和 `c390c5d56eb3e55f6d0dc463c52321d777997fb6ba568e52e15e30eb9efafc48`，与 T1 网站元数据及固定 Git 对象相同。正式 Lean、版本和验收入口当前无工作树差异。
- `REVIEW_OUTCOME.zh-CN.md` 与 `WEBSITE_STATUS.json` 在中断前 21:23 已记录：T1 已送审并取得网站最终静态审阅结论；T2 v2 于 21:15:15 已送审。旧 `CURRENT_STATE` 20:47 的“T2 尚未发送”已过时，不可重发。
- 本地 `mathcopilot-T1/RETURN_METADATA.json` 是从网站编辑器复制的完整可解析元数据（6761 字节，SHA256 `90ca5a3bf7f7c3266cf20da12fab44210cd697b8c1ab800875beacdcb0787f1c`）。21:27 的 `T1_RETURN_METADATA_VALIDATION.json` 核对 26 个固定 Git 原始对象哈希全部匹配，并核对当前两份数学源码哈希；它没有网站原输出文件自报哈希，**不能证明复制品与网站原文件逐字节相同**。另外六份 T1 原报告尚未落本地。
- `../tmp/t1-t2-review-20261002/T2_WEBSITE_PROGRESS.snapshot.txt`（53673 字节，SHA256 `f387fb52c8334cdf063b6c3b77a6f0c6dfc12055be893a735845546ad53d1a0e`）比旧交接更新：页面记录 T2 Lean Blueprint 已给出七 ID 结论，并称 20/20 区块的原文件长度和 SHA256 均匹配，其中 15 个 CRLF、5 个 LF。它显示两份报告及网站给出的哈希；原报告尚未落本地，截图末尾仍有“停止回复”按钮，故本次不声称重新确认网站任务已完全结束。
- 当前本地 T2 v2 正文仍为 93795 字节、SHA256 `00dd541e8dfd87e318a4115679fe954dc91917e24cb6806ab82671ecc794ec5c`，与网站回执所示原文一致。网站另确认整体 CRLF 转 LF 的传输文本；该整体哈希不能替代逐原文件校验，逐块校验依据上述页面快照单列。

## T2 七项结论的可核对范围

| ID | 21:27 网站页面快照所示结论 | 本地后续动作 |
| --- | --- | --- |
| T2-L0 | 两侧 inverse 根命题可接受；两个矩阵 `mulVec` 坐标桥接应显式进入 L0 声明包 | 保留原 inverse 类型，另列无正质量前提的 `massOperator`、`velocityOperator` 坐标作用目标 |
| T2-S1 | 接受 | 原候选类型保持待证明 |
| T2-B1 | 接受 | 原候选类型保持待证明 |
| T2-B2 | 接受；不增加正质量，证明依赖邻域等式 | 原候选类型保持待证明 |
| T2-B3 | 分层修订 | 保留 `hFU` 驱动的纯代数桥接；另列势能在 Q 上可微的教材梯度应用层 |
| T2-B4 | 接受；不需要 `IsOpen I` | 不把其他正向桥接的开区间条件误加到 B4 |
| T2-E1 | 接受，但仅为 `F=0` 的第一阶局部 IVP | 不登记为 `U=0`、二阶方程或守恒的 Lean 证明 |

网站摘要没有报告 T1 对 T2 坐标数、正质量和 inverse 依赖的新阻断；T1 的 11 个 ID、13 条既有定理均获静态审阅接受。这里的“接受”来自保存的页面回执，不是本次取得的完整原报告，也不替代负责人教材语义签核或固定版本重新构建。

## 本地精确候选与验证

冻结的 `T2_SPEC.zh-CN.md`、原 v1/v2 送审正文和输入清单均不改动。本次把修订写在隔离文件 `../tmp/t2-resume-20261002/Probe04_ReviewDelta.lean`：

本次实际重看教材印刷 18–19/PDF 41–42 与印刷 24/PDF 47 的既有渲染图：印刷 18 式 (1.3) 给 `Mq̈=F(q)=-∇U(q)`，说明 `N_c` 是配置坐标数、独立约束后 `N_d=N_c-r`，并写出三维对角质量重复；印刷 19 给沿解的能量与 `dp_i/dt=F_i` 计算；印刷 24 给 `p=M(q)q̇`、可逆时 `v=M(q)⁻¹p` 以及常质量下 `q̇=M⁻¹p, ṗ=F=-∂U/∂q`。本项目当前只处理固定对角质量。教材这些页没有给出本候选目标所需的完整可微性、开时间集和配置域条件，因此相关假设是显式形式化补充。当前 PDF 为 11701675 字节，SHA256 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`，与交接基准匹配。

1. L0 新列 `massOperatorCoordinatesGoal`：`∀ v i, massOperator μ v i = (diagonalMassMatrix μ).mulVec v i`；`velocityOperatorCoordinatesGoal`：`∀ p i, velocityOperator μ p i = ((diagonalMassMatrix μ)⁻¹).mulVec p i`。两者本身不需质量正性；质量正性仍用于原 L0 两侧 inverse。原先成功的 `Probe02b_Adapters.lean` 已用 `rfl` 检查这两种坐标等式的小型示例。
2. B3 原 `nBodyBridgeGoal` 保留为 `nBodyBridgeAlgebraicGoal`，仍需 `hFU : ∀ q ∈ Q, F q = -gradient U q`，但自身不证明 U 可微。应用层有两个准确的候选前提形式：直接给 `∀ q ∈ Q, DifferentiableAt ℝ U q`；或给 `IsOpen Q` 与 `DifferentiableOn ℝ U Q`。两种类型都保留原 hFU、时间开集和解谓词。可微性是解释为教材真梯度的语义条件，不应反向塞进纯代数核心。
3. 使用工程固定 Lean v4.34.0 和锁定 mathlib 执行 `lake env lean ../tmp/t2-resume-20261002/Probe04_ReviewDelta.lean`，实际退出码 0，日志无错误/警告，打印了五个候选 Prop 的完整类型。源文件 3576 字节/SHA256 `c27891bd30ee9b38a672084354cd7810a1a79cf5b59ce9a61ec1ec3163f33b6a`；日志 1919 字节/SHA256 `2b52c9efbb8f0a26bacd3c451c172a923a5ce002b0ad2fd01b897d5f366e7c93`。这只验证**类型可表达**，没有证明这些目标，也没有修改正式源码或运行整套工程检查。

## 未完成和恢复动作

- 本次浏览器项目标签打开后页面读取连续超时；网页读取工具也无法访问该项目。没有从网站取回 T1 其余六份原报告或 T2 两份原报告；尤其未对 T2 `T2_REVIEW.zh-CN.md` 自报 SHA256 `bda5ac3cfbb088d508a05e4360ca6292d0412582ccc817957f32aff76f8b4801`、`T2_REVIEW_LEDGER.csv` 自报 SHA256 `96ead0d71d97902e185db7ede2bda71e38a5ed2fbc18b09ab28b2c9993755c49` 做本地原字节验收。
- 页面可用后先只读取回九份原报告，核对文件内容、哈希、逐 ID 限制与这里的摘要，再更新 T2 规格的正式待审版本。不要重复发送已送审的 T1/T2，也不要把网站工作区 HEAD `bdcd1ecd...` 当本地 `121a9d0...`。
- T2-L0/S1/B1–B4/E1 仍无完整 Lean 证明；T3 仅完成准备。负责人语义签核、T2 正式构建、局部存在唯一性和全局流均未完成。本轮未提交、推送、合并、重置或向网站发送新任务。
