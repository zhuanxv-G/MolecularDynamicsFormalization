# 当前状态与接续检查点

最后更新：2026-10-03 21:03 +08:00（Asia/Shanghai）。分支 `chapter01-kinetic-energy-nonneg`，实查 HEAD `7c61e9d001887066bfa03771343ce91e7ce68ddb` 已推送；该 HEAD 的远端 run `37122822014` / job `111202155182` 成功。新 T4 动量界批次已完成本地与远端机器验收。

## 当前任务与授权

用户在聊天 `01a0ffda-cfb1-7463-84c9-563be032f701` 要求审核并完成 T2 原聊天 `01a0fcdd-009c-76a2-9618-536d0b3396d0`、T5 原聊天 `01a0fd88-8180-74a3-bd70-8094d7722317` 的未完成事项，持续授权 MathCopilot、本地形式化与原工作分支 Git 保存。既有 T2/T5 机器验收完成；核心收尾是固定提交的独立网站完整证明审阅与报告收取。后续数学依赖已承接到 T4。

T3 接续聊天 `01a0ffde-bd33-7c63-96d4-67969e803263` 维护专属 T3 文档/证据。其正式 Hamiltonian 提交已集成，不覆盖其专属未跟踪材料。本工作树的原 `FORMALIZATION_PLAN.md`、旧 WEBSITE_STATUS、T1/T2/T3/T5 专属未跟踪材料保留，仅暂存本批明确文件。

## T3 接续独立检查点（2026-10-03 20:27 +08:00）

- 所有者聊天`01a0ffde-bd33-7c63-96d4-67969e803263`仅负责T3收尾。固定代码提交`21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1`已推送；本地8932 jobs/171声明审计、原九Goal、七边界及原页对照均完成，负责人最终语义签核仍pending。
- 本轮实际下载并核验远端run37101092891/job111140613029的成功ZIP：artifact11266920446，5013字节、SHA`0124589fa611127393b6394e14d282a9fce319d4cc06eb666116347de5d4e0b1`。11件成员/10份原日志/15项固定Git输入/56件冻结交付与两探针SHA全部匹配。证据在`docs/verification/2026-10-03-T3-first-batch-retry03/remote-ci/`；此次是收件复核，没有重新运行本地Lean。
- 原共享网站T3请求先后因capacity和usage limit中断；另一T2/T5附件随后明确替换范围。已另开独立网站会话，短正文加完整规范启动成功，实际读取Lean Blueprint/Lean Proof流程和固定归档，精确核实Lean4.34.0，当前正在新隔离目录中物化固定mathlib并构建。不要在T2/T5会话发送T3、不要向独立T3重复发送。
- 新T3源目录`/workspace/.mathcopilot/reviews/T3_21b4d6cbb512_independent_20261003/source/repo`；目标收件ZIP`/workspace/share/T3_READONLY_REVIEW_21b4_20261003.zip`。运行截图/状态/新指令在`docs/tasks/T3_implementation/continuation-20261003/`。网站完整原报告和实际Lean检查结果尚未收齐。
- 恢复第一动作：观察独立T3网站会话，结束后下载报告及原日志，核对固定提交和输入/输出SHA，处理真实意见；不重做已通过证明，不纳入另一个聊天正在推进的T4源码与未提交材料。

## 已完成与实际验证

- T2 `LocalTrajectories.lean`：五定义、十五完整证明，七规格 ID，真实导数/Newton 双向桥接和 B3 可微语义层。本地完整检查、允许公理审计与远端 CI 已通过。
- T5 `PotentialBarriers.lean`：五定义、二十五完整证明，严格极小、球面正差、任意球内初值的条件留球和边界。本地完整检查与远端 CI 已通过，固定源为 `9baf87f89d07138a95bfbfe1f37d45dd54946cf7`。
- T3 `Hamiltonian.lean`：五定义、十八完整证明，固定质量静态 Hamiltonian 关系；正式提交 `21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1` 的本地验收和 CI 已通过。T3 独立网站原报告不在本批范围。
- T4 已有 `EnergyConservation.lean`、`LocalExistence.lean`、`MomentumConservation.lean`、`Equilibrium.lean`：已有保守机械解的能量守恒、C¹ 局部存在/初始邻域唯一性、全球 Lipschitz 下共同区间唯一性、合力为零时总动量分量守恒、严格极小的零动量平衡桥接；各相应本地与远端检查已通过。
- 本轮新增 `MomentumBounds.lean`（五完整定理）、`MechanicalConfinement.lean`（两完整定理）：动能控制动量范数；紧位置集与连续势能导出紧相能量子水平集；真实机械ODE导出守恒再应用T5屏障，得到给定开区间内未来位置/相空间界。没有假设全程留球或欲证相集紧性。
- 第五批完整检查实际运行20:16:02--20:20:54，退出0：固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435、源码扫描、8938 jobs、Scratch、201声明公理审计、输入哈希稳定。关键定理仅 propext/Classical.choice/Quot.sound。证据：`docs/verification/2026-10-03-T4-fifth-batch/`。
- 本轮实际重新渲染查看教材印刷25--26/PDF48--49、印刷32/PDF55；本地语义复核在第五批目录，负责人/学长最终签核仍 pending。

## MathCopilot：固定包已送达，原报告仍待收取，当前页面不对应该任务

- 指定项目页 `https://mathcopilot.cn/projects/e275fa19-2b16-4592-8433-8b01d11ef422` 已用 Browser `26.930.31730` 实际打开。固定 T2/T5 包仍已发送，网站已确认固定 `9baf87f`、73702 字节、SHA256 `2d7f3fdb096fcb68faabbf0e85426065f3f615ee0a33935cb8e1301ed81c3e4d` 和 14/14 区块字节/SHA/Git blob 匹配。
- 本次实时页面侧栏只有四个任务；搜索 `T2` 只显示不相关的 T3 任务，没有固定 T2/T5 审阅任务。选中的原始项目任务是较早的 T1/T2/T3 混合对话，当前有一个不相关的运行回复；页面同时显示 usage limit，预计恢复时间为 `2026-10-04 00:45`（网站显示）。没有停止该任务，也没有重复发送 T2/T5。
- 当前网站状态证据在 `docs/reviews/2026-10-03-T2-T5-proofs/CURRENT_ATTEMPT.json` 和 `WEBSITE_STATUS.json`；固定输入包为 `../tmp/t2-t5-proof-review-20261003/T2_T5_REVIEW_INPUT_PACKET.zh-CN.md`。T2/T5 原始报告仍未收取，不能把旧 T2 陈述报告或 T3 页面状态当成本批完整证明审阅。
- 网站先前已安装并报告 Lean 4.34.0，固定依赖缓存获取阶段后未返回最终编译或原报告；TLS 截断、线程资源失败和 usage limit 均保留为失败证据。

## 尚未完成

1. 第五批机器验收已完成；提交 `7c61e9d` 已推送，对应 CI 成功，元数据在第五批目录。
2. T2/T5网站完整报告及本地哈希验收；当前实时页面不显示该固定任务且额度阻塞，不能再发送同一审阅任务。
3. 新T4独立网站证明审阅，以及负责人/学长最终教材语义签核；代理不能替代本人签署。
4. 数学后续：最大/全局ODE延拓、从任意足够近初值推出全未来时间的完整Theorem1.1和严格sup上界。当前紧性与区间相界只是依赖，不能计作完整稳定性。

## 恢复第一动作

先检查实际HEAD与未提交文件；查询本批代码CI（若已提交）。读取网站当前最新短状态，若仍运行就等待且继续独立工作；只有任务结束后收取原报告，不重发审阅。源码若再变化，另建唯一验收目录运行完整scripts/check.ps1。失败方法/历史检查证据见WORK_LOG，首次单文件等待与三项正质量推理错误均不计成功。
