# T3 集成说明

正式候选：`evidence/IntegrationCandidate.lean`，SHA256 `89b808b5f181e6b388023dc25b604043ac1d1868eb2db971ea0e419e5fbba1ac`。含五个新增定义、18条完整定理，使用namespace MolecularDynamics；导入Chapter01.LocalTrajectories并复用其中massOperator/velocityOperator。主草稿独立namespace T3Implementation，只依赖稳定T1，作为复核输入保留。

候选与共享T2接口的独立编译已经通过Probe08及Probe10。共享T2源码SHA `2867aa94d87c65afa6869d2f3bc552f828de797862e4ab334fd480044b535538`，olean SHA `f32ba29b63c9e47119469b1b291730cfd90bb27b98bb220695fd31e2a4e11606`，前后未变。T2在并行聊天已提交HEAD `675fcaedbdef7b6ec57393c1ee99e9ca727da649`；这只是本轮实查HEAD，不把其他聊天CI结果计为T3 CI。

T2旧名massOperator_apply/velocityOperator_apply返回矩阵作用表达，因此候选坐标simp定理分别叫massOperator_coordinate/velocityOperator_coordinate。候选删除两个重复算子定义和重复逆作用定理，保留18条其余证明，避免名称冲突。九个原Goal及证明不必放入正式模块，它们在Probe10中专门核对目标一致性。

共享owner接收后：

1. 核对本候选及T2接口哈希。若接口已变，先重新独立编译候选和原九Goal；不得复用旧成功。
2. 安装为`MolecularDynamics/Chapter01/Hamiltonian.lean`，顶层加入导入；在Scratch按正式文件名补关键#print axioms。
3. 同步FORMALIZATION_MAP/ASSUMPTIONS/STATUS与共享CURRENT_STATE/WORK_LOG。七ID对应九个一般目标，不能报作九个章节；登记物理正质量、代数最小假设、U可微性及未证明的轨道/守恒范围。
4. 运行`pwsh -NoProfile -File scripts/check.ps1 -ReportDirectory docs/verification/2026-10-03-T3-first-batch`，确认源码扫描、完整构建、Scratch、公理与输入哈希通过；之后按用户已授权GitHub流程保存并核对CI。
5. 收取MathCopilot独立原报告与输入台账，核对固定字节和输出SHA。网站报告不能替代本地固定版本验收；负责人语义签核另登记。

本聊天没有直接安装正式模块，也没有暂存、提交、推送共享owner的文件。交付目录可由owner按整批保存；evidence保留失败尝试与实际成功日志。
