# T3 MathCopilot 审阅指令（本轮未发送）

本批已授权的是本地准备和送审材料生成。本文件没有发送，不表示网站已参与T3。T1/T2网站审阅仍由原对话协调；后续发送本批时需要明确附加尚未提交的文件，不能仅给Git HEAD。正式起草/集成按陈述审阅后的安排推进。

## 第一阶段：独立陈述和依赖审阅

以下正文可复制到 formal math 项目的新独立审阅任务；本轮只生成正文。

```text
请在 formal math 项目调用 Lean Blueprint，独立审阅 T3「固定对角质量的具体 Hamiltonian 一致性」的定义、七项规格ID、九个目标类型、全部假设和依赖。必要时用 Math Brainstorm 检查数学路线。请返回可复核报告，不修改正式 Lean 库、不调用 Lean Proof 起草完整目标、不执行 Git 提交/推送/合并/重置或索引重建。

固定输入仓库 https://github.com/zhuanxv-G/MolecularDynamicsFormalization，工作分支 chapter01-kinetic-energy-nonneg，源码基准提交121a9d02ad15500c630e505b363d5f04106d617f。固定 Lean v4.34.0，mathlib checkout5ed2965256430c3649e86755f9576b54eca72435。先报告实际读取的Git对象、网站工作区HEAD和工具版本，三者不要混用；网站已有分叉提交不得覆盖。如果固定对象不可取得，列明缺少输入，不按当前网站工作区代替。

本轮T3材料尚未提交，必须取得另行附加输入：T3_SPEC.zh-CN.md、T3_API_CHECK.zh-CN.md、T3_INPUTS_AND_ACCEPTANCE.zh-CN.md、本任务指令，以及T3_INPUT_MANIFEST.json列明的CandidateDefs.lean、Probe03_TargetTypes.lean/log/result、7份最终通过探针的源/log/result、原页审计和冻结源码。每份输入核对实际SHA256；文件名或HEAD不能代替收到文件的证据。原T2陈述还在审阅，massOperator/velocityOperator只是经类型验证的候选包装，不能声称已正式实现。

教材本轮原页核对为印刷18–19/PDF41–42、22–26/PDF45–49，核心印刷24/PDF47的p=M(q)qdot、H=pᵀM(q)⁻¹p/2+U和固定M的Hamilton方程，印刷25/PDF48为常数正定M⁻¹背景。PDF为461页，SHA2561939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036。所见原页、物理解释和形式化补充前提分别记录。

逐ID审阅T3-K1/E1/P1/G1/G2/V1/R1：
1. K定义为sum_i p_i²/(2*m_i)。实数总除法下H(q,Mv)=既有速度总能量对任意实质量成立，不能为E1/P1添多余正性；但不把零/负质量当本批物理模型。
2. 教材整个矩阵非奇异逆与坐标倒数不能无条件相等。K1、矩阵梯度、任意动量速度恢复采用∀i,0<m_i并复用现有T1逆矩阵结果。核对m=(0,2),p=(0,4)时坐标K=4、M⁻¹=0、矩阵K=0的已编译反例。
3. G1坐标真实梯度是p_i/m_i，对任意实质量可作固定系数多项式；矩阵版本才加正质量。核对平方项/常数系数/有限和/CLM-toDual/HasGradientAt完整路线；小适配通过不等于一般gradient K已证明。
4. q/p偏梯度分别是欧氏切片。现有PhaseSpace为普通Prod，不假定整个PhaseSpace具匹配内积结构。总gradient加常数等式无可微前提，但HasGradientAt或真实F=-∇U解释须U在q可微/真实梯度证据；若仅Q内可微，明确q∈Q与Q开放或邻域条件。
5. 本批V1只核对静态Hamilton向量场的总函数等式；沿真实时间轨道的Hamilton/Newton双向解等价必须接入T2真实导数、解区间和共享包装。能量沿解守恒属于T4。
6. 维数包括n=0、N=0、d=0；粒子正性反向桥接的d>0不得误加到P1。速度/动量虽然是透明类型别名，不能混淆物理含义。
7. 不纳入变质量M(q)、一般非对角矩阵/约束模型、一般Legendre上确界证明、全局解/延拓/Flow、Theorem1.1。教材Legendre讨论有凸性背景，仅可逆不保证上确界达成。

返回T3_REVIEW.zh-CN.md，包含：实际读取的提交及全部附加输入SHA256；实际Lean/mathlib/技能/检查工具版本；逐ID接受/修订/拒绝/依赖缺口；完整准确的Lean假设与结论类型；固定版本完整声明名/module/type；原页对应和形式化补充条件；与T1审阅及T2命名/接口的依赖；建议证明顺序；实际运行命令、退出码、日志和未验证事项；负责人待签核项。选择技能不等于实际调用，明确每种工具实际参与。

禁止sorry/admit、新增项目公理、unsafe绕过证明、把目标结论预置进假设。没有可用固定工程环境时，如实标明类型/证明未检查；网站单文件检查成功不能替代本地正式check.ps1与负责人语义复核。未完成目标留在文档，不塞占位证明进正式库。
```

## 第二阶段：后续起草的进入条件

本轮没有生成或发送“立即起草”指令。开始后续证明批次前，应取得逐ID独立审阅结果、解决T1质量/坐标/inverse依赖问题、确定T2共享包装最终名称，并固定新的输入快照。届时选择Lean Proof按K1/E1→P1/R1→G1→G2→V1分批起草，记录完整证明和实际公理/编译证据。本地审阅集成后运行固定验收脚本和CI；真实轨道等价另立T2接口任务。

原始可发送正文和附加内容由 `../tmp/t3-preparation-20261002/T3_SEND_BODY.txt` 保存；完整内容/源哈希见对应meta和manifest。它只是本地送审包，不是发送成功证据。
