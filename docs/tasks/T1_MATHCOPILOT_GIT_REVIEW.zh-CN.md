# T1 固定 Git 输入的 MathCopilot 审阅指令

上传器未成功时采用本批；不会声称 ZIP 被接收。准备发送，实际发送状态见交接记录。

```text
T1 网站独立审阅与证明复核批（ID：T1-website-review-c7d9778）。

请使用当前 formal math 项目已安装的 Lean Blueprint，先独立核对数学陈述和依赖；保存结论后再使用 Lean Proof 审阅本批完整 Lean 证明。用户已授权推进 T1。请记录实际调用的技能，缺技能就具体报告，不把技能选择或提示词出现名字算作调用。

本次上传器未返回文件选择器，所以没有接收 ZIP；本批按 Git 固定提交提供输入，不声明 ZIP/清单哈希匹配，不混用 T1-preparation-v1/v2 元数据。
正式仓库：https://github.com/zhuanxv-G/MolecularDynamicsFormalization
分支：chapter01-kinetic-energy-nonneg
精确提交：c7d9778fe981c24ba7281db730206d1cfefbba4d
固定 Lean：leanprover/lean4:v4.34.0；mathlib 锁定 5ed2965256430c3649e86755f9576b54eca72435。
输入是上述提交的源码及 docs/tasks/T1_SPEC.zh-CN.md、T1_API_CHECK.zh-CN.md、FORMALIZATION_MAP.md、ASSUMPTIONS.md、STATUS.md、AGENTS.md 和 docs/verification/2026-10-02-T1/。T1_SPEC/API 的“未证明/旧 HEAD”是准备历史；新源码以本提交为准。本地该源码已通过固定版本完整检查（8929 jobs、Scratch、60项项目声明公理依赖审计），但不代表网站独立审阅或负责人签核通过。

请核对实际项目根/分支/HEAD。若现有工程不同，在隔离副本读取精确提交或直接读取固定提交内容，不覆盖既有工作树，不默用 main 或历史 bdcd1ec。先读取陈述规格，在完成第一阶段报告前不借最终证明跳过假设审阅。
教材已在项目根：Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf，461页，SHA256 1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036。本批仅核对 §1.2，印刷18–19 / PDF41–42；无法看原页必须明确未核对。

逐项核对11个ID：T1-I1/I2、M1/M2/M3、E1、P1–P5（I2/P3各两条，共13定理）。重点：
1. N是粒子数，N_c=N*d是环境配置坐标数，N_d是局部自由度；约束减少N_d，不直接把环境坐标改成3N-r。
2. Fin N × Fin d 经 finProdFinEquiv 粒子优先展开，编号a.val+d*i.val；质量沿d个方向重复。d=1、3对应教材，其余维数是推广。
3. 粒子速度使用每粒子 EuclideanSpace 的欧氏范数，不能用外层普通函数范数替代。
4. 动能表达桥接对任意实质量成立，不增加正质量假设。
5. 坐标正性反推出粒子正性需0<d；N=0/d=0是明确代数退化，不给空量词物理解释。
6. 正定和逆关系假设严格正质量；一般奇异矩阵的逆不能无条件解释为逐坐标倒数。重点审阅 inverse identity 的 IsUnit determinant 条件。
7. 本批仅代数桥接，不处理轨道/ODE/Hamiltonian一致性/沿解守恒/Theorem1.1。
第一阶段给出变量/量词/准确结论、假设、教材对应和API/依赖顺序，记录所有修订建议，不能默改目标。

第二阶段审阅 MolecularDynamics/Chapter01/ParticleCoordinates.lean 的13条完整证明、顶层导入和 scripts/CheckAxioms.lean。可做托管Lean完整导入闭包检查或固定版本shell检查；记录实际版本/命令/退出码/完整日志，未暴露版本写unknown，缺lake/pwsh报告不能运行，不升级固定版本，不复制本地成功为网站成功。发现问题时保存独立建议/草稿，不覆盖正式代码。禁止sorry、admit、新项目axiom、unsafe绕过或假设目标结论。

请保存到 docs/tasks/T1_mathcopilot_return_git/：
RETURN_METADATA.json（本批ID、输入来源git、实际HEAD/版本/技能/检查和输出SHA256，未知项明确未知）；
T1_STATEMENTS_REVIEW.zh-CN.md；
T1_DEPENDENCY_BLUEPRINT.zh-CN.md；
T1_PROOF_REVIEW.zh-CN.md（13条证明逐项结果及接口/假设风险）；
T1_ENVIRONMENT_AND_CHECKS.zh-CN.md；
T1_REVIEW_LEDGER.csv（11个ID，区分陈述/证明/机器/语义状态）；
T1_STATEMENT_CHANGES.csv（无修订保留表头并说明）；
实际检查探针和原始日志。
不要推送/合并/重置/升级依赖/删除文件或向其他聊天发送消息；完整报告交付后停止，列出输出位置和未完成项。负责人的最终教材语义签核仍由本地另行登记。
```
