# T1 收尾审阅专用指令

本文件是 2026-10-02 当前授权范围的发送正文。截至生成时尚未发送；只做既有 T1 审阅，不起草 T2 或其他新证明。

```text
批次：T1-review-20261002-readonly。
请在当前 formal math 项目实际使用 Lean Blueprint 审阅已有 T1 陈述/依赖，再使用 Lean Proof 复核已有13条完整证明。Lean Proof在这里仅用于审阅现成证明，不重证明T1，不起草任何新目标，不启动T2。记录实际技能参与，不能把选中技能当调用完成。

输入仓库：https://github.com/zhuanxv-G/MolecularDynamicsFormalization
数学实现提交：c7d9778fe981c24ba7281db730206d1cfefbba4d。
已验证可读的源码目录提交：052eea2edd51fd806edf6a9dacbb6cc3353fc82f。
本地当前HEAD：121a9d02ad15500c630e505b363d5f04106d617f；后两提交不改变本批数学源码。
固定Lean v4.34.0；mathlib5ed2965256430c3649e86755f9576b54eca72435。

先记录实际工作目录、分支和完整HEAD。已知网站工作区bdcd1ecd与远端发布分支分叉；本批只用git show 052eea2:<path>读取目标Git对象，不改网站工作树，不pull/checkout/merge/reset/rebase或升级依赖。缺Git对象则明确报告，不能默用当前工作区源码。语义索引曾返回无关mathcopilot-lean-test；不重建/配置/修复索引，不把源码读取等同语义检索通过。

实际读取固定对象中的AGENTS.md、docs/tasks/T1_SPEC.zh-CN.md、T1_API_CHECK.zh-CN.md、MolecularDynamics/Notation.lean、BasicDefinitions.lean、Chapter01/NBody.lean、Chapter01/ParticleCoordinates.lean、顶层导入、scripts/CheckAxioms.lean、FORMALIZATION_MAP.md、ASSUMPTIONS.md、STATUS.md及docs/verification/2026-10-02-T1/。
T1_SPEC的“尚未证明”、旧HEAD和旧注释描述是准备历史；实际正式源码已有13条theorem，顶层导入和Notation注释已修正。ParticleCoordinates.lean原始字节SHA256应为c390c5d56eb3e55f6d0dc463c52321d777997fb6ba568e52e15e30eb9efafc48；NBody.lean为45a16307a724348917d8bd9f9eab47cd1a74ec54ba32b468a0e8ead670432696。若不匹配，停止给出验收结论并记录差异。

教材为项目已有Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf，461页，SHA2561939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036；审阅印刷18–19/PDF41–42。无法查看原页就明确写未核对，不能按书名或本地报告假称网站已看图。

先逐ID独立审前提/结论/语义：T1-I1/I2/M1/M2/M3/E1/P1–P5，共11ID、13定理（I2/P3各两条）。重点：n=N_c而非受约束自由度N_d；索引a+d*i，d=1、3与原页对应，其余是推广；使用每粒子欧氏范数；动能等式对任意实质量；正性反向需0<d；正定和inverse需严格正质量；mul_nonsing_inv/nonsing_inv_mul实际需IsUnit determinant；逐项逆不能无条件用于奇异矩阵；N=0/d=0只作代数退化。T1不含轨道、ODE、Hamiltonian一致性或守恒。

随后逐条阅读现有13条证明，报告是否存在多余/缺失假设、定义偏差、API误读、新公理或隐藏目标结论，并明确是否影响T2的质量/坐标/逆矩阵依赖。本地与CI已有固定版本历史成功；本轮不重跑整套构建，不安装或下载新工具链，不把历史结果复制成网站新检查。必要的现成API只读核对或小类型检查需报告实际环境、命令、退出码和原始输出；未运行写未运行。

请仅新增独立审阅文档于docs/tasks/T1_mathcopilot_return_git/（若同名已存在则用本批日期子目录，保留旧文件）：RETURN_METADATA.json、T1_STATEMENTS_REVIEW.zh-CN.md、T1_DEPENDENCY_BLUEPRINT.zh-CN.md、T1_PROOF_REVIEW.zh-CN.md、T1_ENVIRONMENT_AND_CHECKS.zh-CN.md、T1_REVIEW_LEDGER.csv、T1_STATEMENT_CHANGES.csv。记录实际输入SHA、技能参与、版本和全部未验证项；建议修订放报告，不改任何正式Lean/已有文档/共享handoff。负责人语义签核单列pending。

只完成T1收尾审阅后停止。禁止新证明起草、sorry/admit/新项目公理/unsafe绕过、提交/推送/合并/重置、索引配置及向其他对话发送消息。最终列出逐ID结论、对T2的影响、输出路径和未完成项。
```
