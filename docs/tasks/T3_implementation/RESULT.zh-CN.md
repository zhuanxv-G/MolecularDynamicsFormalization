# T3 完整证明交付

更新时间：2026-10-03T01:30:41.837487+08:00。本批九个原规格一般目标已完整证明，并在固定Lean 4.34.0 / mathlib `5ed2965256430c3649e86755f9576b54eca72435` 通过实际编译。当前交付是隔离证明和正式集成候选；尚未安装到正式库，MathCopilot独立复核与负责人最终语义签核未完成。

例如单坐标m=2、v=3、p=6、U(q)=7时，速度动能与动量动能都为9，Hamiltonian为16。该数值例只用于解释；一般n、任意相应变量的完整证明见下面九项。

| 规格ID | 原Goal | 完整定理 | 假设及解释 |
| --- | --- | --- | --- |
| T3-K1 | matrixKineticGoal | momentumKineticEnergy_eq_inner | 各坐标质量严格正 |
| T3-E1 | velocityEnergyGoal | massHamiltonian_massOperator | 任意实质量、任意势能 |
| T3-P1 | particleEnergyGoal | massHamiltonian_particle | 任意N,d含0；粒子优先展开 |
| T3-G1 | coordinateGradientGoal | hasGradientAt_momentumKineticEnergy | 任意实质量；实际HasGradientAt |
| T3-G1 | matrixGradientGoal | gradient_momentumKineticEnergy_eq_velocityOperator | 各坐标质量严格正 |
| T3-G2 | positionGradientGoal | hasGradientAt_position_slice | U在q处可微；实际HasGradientAt |
| T3-G2 | positionTotalGradientGoal | gradient_position_slice | 任意U；只解释为总函数恒等式 |
| T3-V1 | vectorFieldGoal | hamiltonianVectorField_eq | 正质量；静态切片梯度向量场 |
| T3-R1 | inverseEnergyGoal | massHamiltonian_velocityOperator | 各坐标质量严格正 |

## 实际机器验证

- Probe05：主草稿完整核心证明，退出0、无警告；源码SHA `33109e04154f6bc29b96038e4a45a0e36da1b7de2b2d09a5071f7814987a8b4e`。
- Probe06：原准备规格九个Prop的逐一完整证明，退出0、无警告。只替换namespace，不改变Goal或增加前提。
- Probe07：七条边界命名引理，退出0、无警告。包括混合零质量m=(0,2)、p=(0,4)时坐标K=4而整个奇异矩阵逆形式K=0，空坐标和负质量例。
- Probe08：正式MolecularDynamics namespace、复用T2算子的候选文件，18条命名定理全部打印公理，退出0、无警告。
- Probe10：候选文件对原九个Goal逐一完整证明，退出0、无警告；与Probe08使用的T2源码及olean哈希一致。
- 上述公理输出只有propext、Classical.choice、Quot.sound。10个稳定输入与起始冻结字节一致。实际源/日志/退出码保存在evidence；完整清单见MANIFEST.json。

Probe01、03是修正前Lean失败尝试，Probe04曾通过但有风格警告，均保留而不作为最终成功证据。Probe09受Windows沙箱账户的Git所有权检查阻断，Lean未执行源文件，原runner又无法读取mathlib HEAD，因此子进程实际退出码未保存；仅据原日志记录阻断，不推测退出码。Probe10采用进程内精确仓库safe.directory，未修改全局Git设置，成功验证相同源字节。

## 教材语义与未完成项

主定义采用印刷24/PDF47、印刷25/PDF48的固定正对角质量模型；本轮实际重新查看这两页的原图，其他相关页沿用准备阶段视觉证据。粒子/坐标能量桥接沿已有T1排列。质量按坐标固定，不把位置相关M(q)、约束广义坐标或一般Legendre上确界论证纳入本批。

真实动量梯度由有限和的Frechet导数证明得到；位置真实梯度显式要求U在q可微。没有把总gradient等式等同于真实导数。向量场用两个欧氏切片梯度，不要求现有PhaseSpace乘积范数有未经建立的内积结构。代数及梯度命题允许零维；零/负质量总除法可定义不意味着物理模型可采用它们。

尚未验证：T3正式库安装后的scripts/check.ps1与远端CI、MathCopilot本批原报告、负责人最终语义签核。T2的旧成功构建不替代T3集成检查。本批不证明真实时间轨道解等价、能量守恒、解存在唯一性、全局延拓或Theorem 1.1。

## 并行交付和接续

T2共享owner管理正式库、顶层/Scratch、共享数学状态、Git及CI；T3仅写自己的tmp和本交付目录。`evidence/IntegrationCandidate.lean`可在其协调下安装到Hamiltonian模块，具体动作见INTEGRATION.zh-CN.md。未覆盖T2/T5成果，没有为凑满时长开启新数学批次。

MathCopilot本批未发送。三个浏览器读取/导航请求均超时，打开面板只返回queued；保存的T2状态另称网站旧账户限额提示02:48 AM后重试，尚未在本聊天重新确认。`t3`自动接续保留，只处理已列缺口；使用CHECKPOINT和REVIEW_SEND_BODY恢复，不重做九个证明。实际额度恢复、离线重启未经实测；不能运行时等待用户手动“继续T3”。
