# 当前状态与接续检查点

最后更新：2026-10-03 20:23 +08:00（Asia/Shanghai）。分支 `chapter01-kinetic-energy-nonneg`，实查 HEAD `c82c163296acf75f33eefca3ea584c476728817a` 已推送；该 HEAD 的远端 run `37106363308` 成功。新 T4 动量界批次已完整本地验证，正在提交/推送与核对 CI。

## 当前任务与授权

用户在聊天 `01a0ffda-cfb1-7463-84c9-563be032f701` 要求审核并完成 T2 原聊天 `01a0fcdd-009c-76a2-9618-536d0b3396d0`、T5 原聊天 `01a0fd88-8180-74a3-bd70-8094d7722317` 的未完成事项，持续授权 MathCopilot、本地形式化与原工作分支 Git 保存。既有 T2/T5 机器验收完成；核心收尾是固定提交的独立网站完整证明审阅与报告收取。后续数学依赖已承接到 T4。

T3 接续聊天 `01a0ffde-bd33-7c63-96d4-67969e803263` 维护专属 T3 文档/证据。其正式 Hamiltonian 提交已集成，不覆盖其专属未跟踪材料。本工作树的原 `FORMALIZATION_PLAN.md`、旧 WEBSITE_STATUS、T1/T2/T3/T5 专属未跟踪材料保留，仅暂存本批明确文件。

## 已完成与实际验证

- T2 `LocalTrajectories.lean`：五定义、十五完整证明，七规格 ID，真实导数/Newton 双向桥接和 B3 可微语义层。本地完整检查、允许公理审计与远端 CI 已通过。
- T5 `PotentialBarriers.lean`：五定义、二十五完整证明，严格极小、球面正差、任意球内初值的条件留球和边界。本地完整检查与远端 CI 已通过，固定源为 `9baf87f89d07138a95bfbfe1f37d45dd54946cf7`。
- T3 `Hamiltonian.lean`：五定义、十八完整证明，固定质量静态 Hamiltonian 关系；正式提交 `21b4d6cbb5121c5f194a4dda9b9d718148b2e1a1` 的本地验收和 CI 已通过。T3 独立网站原报告不在本批范围。
- T4 已有 `EnergyConservation.lean`、`LocalExistence.lean`、`MomentumConservation.lean`、`Equilibrium.lean`：已有保守机械解的能量守恒、C¹ 局部存在/初始邻域唯一性、全球 Lipschitz 下共同区间唯一性、合力为零时总动量分量守恒、严格极小的零动量平衡桥接；各相应本地与远端检查已通过。
- 本轮新增 `MomentumBounds.lean`（五完整定理）、`MechanicalConfinement.lean`（两完整定理）：动能控制动量范数；紧位置集与连续势能导出紧相能量子水平集；真实机械ODE导出守恒再应用T5屏障，得到给定开区间内未来位置/相空间界。没有假设全程留球或欲证相集紧性。
- 第五批完整检查实际运行20:16:02--20:20:54，退出0：固定Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435、源码扫描、8938 jobs、Scratch、201声明公理审计、输入哈希稳定。关键定理仅 propext/Classical.choice/Quot.sound。证据：`docs/verification/2026-10-03-T4-fifth-batch/`。
- 本轮实际重新渲染查看教材印刷25--26/PDF48--49、印刷32/PDF55；本地语义复核在第五批目录，负责人/学长最终签核仍 pending。

## MathCopilot：已发送并在执行，禁止重复发送

- 指定项目页 `https://mathcopilot.cn/projects/e275fa19-2b16-4592-8433-8b01d11ef422`，新版 Browser `26.930.31730` 正文和操作已恢复。
- 本轮已将 REVIEW_SEND_BODY 与固定原字节包填入并发送；大段文本自动转换为附件。网站明确承认本次只处理固定9baf的T2/T5，并确认73702字节、SHA256 `2d7f3fdb096fcb68faabbf0e85426065f3f615ee0a33935cb8e1301ed81c3e4d` 和14/14区块字节/SHA/Git blob均匹配。网站还按公开不可变归档逐字核对输入。
- 网站已实际安装并报告Lean4.34.0，当前lake build仍在获取固定manifest的mathlib；未得到最终编译或原报告。旧T3两条请求分别遇到model capacity/usage limit，不计完成。
- 当前尝试证据：`docs/reviews/2026-10-03-T2-T5-proofs/CURRENT_ATTEMPT.json`、`REVIEW_RUNNING.png`。固定输入包保持 `../tmp/t2-t5-proof-review-20261003/T2_T5_REVIEW_INPUT_PACKET.zh-CN.md`。
- 收尾交付：T2_PROOF_REVIEW.zh-CN.md、T5_PROOF_REVIEW.zh-CN.md、REVIEW_LEDGER.csv、RETURN_METADATA.json、原检查日志；收取后本地核对输入/输出字节与SHA，按逐项结论修订真实问题。

## 尚未完成

1. 第五批新源码提交、推送及远端CI（本地通过不代替CI）。
2. T2/T5网站完整报告及本地哈希验收；网站仍在运行，不能再发送同一审阅任务。
3. 新T4独立网站证明审阅，以及负责人/学长最终教材语义签核；代理不能替代本人签署。
4. 数学后续：最大/全局ODE延拓、从任意足够近初值推出全未来时间的完整Theorem1.1和严格sup上界。当前紧性与区间相界只是依赖，不能计作完整稳定性。

## 恢复第一动作

先检查实际HEAD与未提交文件；查询本批代码CI（若已提交）。读取网站当前最新短状态，若仍运行就等待且继续独立工作；只有任务结束后收取原报告，不重发审阅。源码若再变化，另建唯一验收目录运行完整scripts/check.ps1。失败方法/历史检查证据见WORK_LOG，首次单文件等待与三项正质量推理错误均不计成功。
