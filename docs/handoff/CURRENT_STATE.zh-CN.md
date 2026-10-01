# 当前状态与接续检查点

最后更新：2026-10-02 00:45 +08:00（Asia/Shanghai）。实际分支 `chapter01-kinetic-energy-nonneg`，HEAD `9587329cf646889b6ebbab7133ae76dce156450d`。提交前/后的状态须以实际 Git 为准；不能把本文件的历史基准当成永久 HEAD。

## 当前任务与已授权范围

用户明确要求：先推送，直接做第四项 Lean 知识库/索引，然后推进 T1。提交/推送当前工作分支、网站目标项目索引操作、必要材料和 T1 指令发送及实现已授权；不重复询问这些授权。不合并 main，不重置，不改固定版本，不覆盖用户既有 FORMALIZATION_PLAN.md 修改。

## 最新完成与未完成

1. **基线推送和远端 CI 已完成。** 提交 `9587329cf646889b6ebbab7133ae76dce156450d` 已推送；GitHub Actions run36887786627 / job110455409268 对该提交 success：Lean4.34.0、锁定mathlib、8928jobs构建、Scratch、36项目声明依赖审计。artifact11175850137。证据 `docs/verification/2026-10-02-remote-ci/`。没有修改 main。
2. **第四项实际核对已开展，但索引未就绪。** 网站 settings→Git 选择 zhuanxv-G/MolecularDynamicsFormalization，仓库显示已就绪，语义检索实际关闭。点击更新，完成/HEAD未暴露；勾选启用并保存，显示“无法连接 MathCopilot 服务器：Failed to fetch / TypeError: Failed to fetch”。立即重建禁用。现用本地MiniLM-L6，没有添加Zotero或外部付费Embedding。索引HEAD、ready状态、声明检索命中均未验证。记录 `docs/knowledge/LEAN_LIBRARY_CHECK.*`。故障截图在上层tmp/t1-implementation，不提交含账号页面截图。
3. **T1 正式实现和本地机器验收已完成。** 新增 `MolecularDynamics/Chapter01/ParticleCoordinates.lean`，13条完整引理覆盖11个规格ID（I2/P3各两条），无占位/新公理；同步顶层导入、Notation坐标数说明、映射/假设/STATUS和关键公理打印。
4. **T1整套正式检查通过。** `pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory ../deliverables/local-check-20261002-T1-run1`，00:24–00:26，退出0：固定版本、源码扫描、8929jobs、Scratch、60项项目声明公理审计；关键引理只依赖propext/Classical.choice/Quot.sound。12个输入和10份原始日志的哈希复核通过，证据 `docs/verification/2026-10-02-T1/`。CHECK_REPORT SHA256 `98b7b40708e2ce6003d1a183f0c162848320b4cd02f134256f3a8be7aaf7f33d`。该运行检查9587329上的未提交工作树，以源码SHA绑定；基线远端CI不能替代新T1 CI。
5. **网站T1报告仍待完成。** 已进入 formal math 项目，选择“形式化与蓝图”(/lean-blueprint)。网站可打开项目文件，但上传菜单/上传文件均未返回浏览器文件选择器（60s超时），没有上传成功。没有发送任务。可按已授权范围改用Git输入与项目中已有教材，明确这不是ZIP接收/哈希通过。不能把MathCopilot本批参与写成已完成。负责人最终教材语义签核仍pending。

## T1固定材料与数学范围

- 原v1包保持不变：`../deliverables/T1-preparation-v1/T1-preparation-v1.zip`，SHA256 `4b80ba09755f1f518371fa89083a26554373faf51daaa8ffb2e86d73041af8d4`。
- 新v2包：`../deliverables/T1-preparation-v2/T1-preparation-v2.zip`，基准9587329，SHA256 `84df8f79ba1e94f7155ce37452925de2d9331983f65bce03d0e677fd5c906d35`，37成员/35清单记录/19核心输入，CRC/字节/哈希/版本通过。它是新源码集成前的陈述审阅快照，不能用它覆盖后来工程。v2入口/提示词/配置/清单在docs/tasks/；当前未上传。
- T1_SPEC/API等文档保留原准备历史；其“未证明/旧HEAD/等待实现”描述不是当前状态。当前实现对所有实质量证明动能等式；反向质量正性需要0<d；矩阵正定和逆关系显式要求严格正质量。粒子优先编号a+d*i；d=1、3对应教材，其余是推广，N=0/d=0是代数退化。
- 本轮重新查看印刷18–19/PDF41–42，核对N/N_c/N_d、质量排列、每粒子欧氏范数。机器证明与本地原页核对已完成；网站独立审阅/负责人签核未完成。没有证明轨道、ODE、沿解能量守恒、Hamiltonian一致性或Theorem1.1。
- 隔离草稿、失败编译、全13定理公理输出保留 `../tmp/t1-implementation/`。首次求和简化顺序失败，调整后成功；一次输出捕获错误后重跑确认。正式集成后重新跑全工程，不能套用旧草稿成功。

## 工作区与稳定约定

- 正式工程：C:/Users/ustc/Desktop/formal math/MolecularDynamicsFormalization。
- 仓库：https://github.com/zhuanxv-G/MolecularDynamicsFormalization；工作分支chapter01-kinetic-energy-nonneg。
- Lean：leanprover/lean4:v4.34.0；mathlib manifest/checkout：5ed2965256430c3649e86755f9576b54eca72435。未经用户要求不升级。
- 教材为根目录Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf，461页，SHA2561939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036。
- 目标为整本8章、3附录、数学类习题、未编号结论和必要外部依赖；准确性优先，无硬期限。路线 `docs/WHOLE_BOOK_ROADMAP.zh-CN.md`。196目录节点/72符号/21编号候选/首轮72ledger是清点，不是证明进度。首轮抽样不是全书逐页审阅。
- 用户确认Math Brainstorm、Lean Blueprint、Lean Proof已启用并安装到项目。本轮实际登录会话已检测；技能选择不等于实际调用。托管Lean/mathlib版本仍未知。
- Git schannel凭据初始化失败；保持TLS校验的openssl后端可用。基线push在沙箱退出1后，经自动审核批准的require_escalated成功；没有审核拒绝或读凭据。
- 保留用户FORMALIZATION_PLAN.md修改；其余本批源码/报告/交接/知识库/v2文件等待本批提交。上层教材/ZIP/tmp不在正式Git内。没有调用子agent。

## 下一步

先检查实际Git和T1证据，提交/推送本批完整实现并确认新提交CI。随后向 formal math 项目发送明确的Git输入T1审阅批（上传不可用时不要谎称ZIP已收到）。网站任务启动后读取真实返回，逐条验收陈述/假设/依赖；如无法启动，保存可发送指令与错误，继续保持网站状态pending。第四项在服务器连接恢复后保存启用、更新仓库、重建并查询已知动能引理，记录实际HEAD与完整类型。

T1闭环后队列：T2时间轨道/局部ODE、T3具体Hamiltonian一致性、T4能量守恒、T5严格极小值屏障、全局延拓/Theorem1.1。不并行铺开未稳定章节。严格极小值不等于Hessian正定；局部解不等于全局流；一般力场不自动守恒总动量。
