# T2 MathCopilot 指令（本轮未发送）

本文件提供两阶段可复制指令，均未发送。网站索引操作继续留在原对话；正式发送前先核对 T1 审阅和本轮输入清单，不能仅用 HEAD 假定网站已有未提交 T2 材料。

```text
请在 formal math 项目调用 Lean Blueprint，审阅 T2「局部时间轨道与点态运动方程」的陈述和依赖。必要时调用 Math Brainstorm 探索路线；本次先返回独立审阅报告，不修改正式 Lean 库。陈述稳定后另进入 Lean Proof 完整证明起草。

基准仓库 https://github.com/zhuanxv-G/MolecularDynamicsFormalization，分支 chapter01-kinetic-energy-nonneg，固定提交54b75a14aaa968522903d82eef947ffdc7bbf165。Lean v4.34.0，mathlib5ed2965256430c3649e86755f9576b54eca72435；实际环境若不同请记录完整版本和差异，不能宣称索引匹配或正式验收通过。

T1 的 ParticleCoordinates.lean 已有13条完整证明，不按旧 T1 准备规格重做。正式实现前核对 T1 独立审阅及负责人语义签核是否影响正质量、坐标数、矩阵 inverse 依赖。

必须取得本轮另行提供的四份 T2 文档和探针原始输出，它们目前不在这个 Git 提交中：T2_SPEC.zh-CN.md、T2_API_CHECK.zh-CN.md、T2_INPUTS_AND_ACCEPTANCE.zh-CN.md，以及本任务指令。缺失则列明缺少的输入，不按文件名假装读过。教材原页为印刷18–19/PDF41–42，印刷25–26/PDF48–49；补充印刷24/PDF47确认p=Mq̇与固定M的一阶系统。

本批采用n=N_c、PhaseSpace=Position×Momentum、固定对角正质量μ、开放配置域Q和含t₀的开时间区间I。一般力场f(q,p)=(M⁻¹p,F(q))；解谓词是曲线位置留在Q并满足IsIntegralCurveOn（其内部用HasDerivWithinAt）。仅在I开且t∈I时换成HasDerivAt。保守力关系F=-gradient U在Q另列，梯度语义需U可微，局部存在唯一性可用F局部Lipschitz或C¹充分条件；由U的C²推F的C¹须落实具体固定版本API。位置二阶导数求导本身不需要质量正性；将M⁻¹F变回Mq̈=F需要正质量的逆关系。

请逐项审T2-L0/S1/B1/B2/B3/B4/E1：矩阵连续线性包装与两侧逆；解谓词与q̇=M⁻¹p、ṗ=F(q)等价；从解推出p=M deriv q；用邻域内deriv q=M⁻¹p与链式法则推出真实二阶导数；再推出NBodyEquationAt；逆向从q,v,a的两条HasDerivAt与Mq̈=F(q)构造p=Mv。禁止把目标的质量–加速度关系预塞正向假设。仅给某点NBodyEquationAt不能构造曲线或证明存在唯一性。

请检查自由粒子q(t)=q₀+(t-t₀)v₀、p=Mv₀、U=0/F=0；不混同速度和动量。闭区间端点/最大存在区间/全局延拓/Flow/能量守恒/Hamiltonian一致性/Theorem1.1均不进入本批。

返回T2_REVIEW.zh-CN.md：实际读取的提交及每个附加输入SHA256、Lean/mathlib/工具版本、逐ID接受/修订/依赖缺口、准确Lean结论类型与全部假设、3–5组API的实际完整声明名/模块/类型、局部存在唯一性路线及尚未证明的前提、建议证明顺序、实际运行日志与退出码、负责人待签核项。技能选择不等于技能实际参与，请记录实际调用；类型通过不等于完整证明。禁止sorry/admit/新增项目公理/unsafe绕过证明；未完成陈述放文档，不加入正式库。
```

本轮已通过三份独立检查：五组声明类型、库实例及八个微分/坐标适配示例、五个候选定义与七个目标命题类型。首次类型类超时和一次短诊断失败均保留。固定实例处理见API报告，不通过提高心跳掩盖未知数学依赖。共享实际HEAD后来由索引对话变为052eea2，仅knowledge资料变化；请核对自己的Git副本，不混同仓库、任务工作区、索引版本。

## 陈述稳定后：Lean Proof 可复制指令（后续阶段使用）

```text
请在T2_REVIEW.zh-CN.md已经逐项审阅、且T1审阅没有未解决依赖变化的基准上调用Lean Proof，起草T2第一批完整证明。先报告实际Git提交、所读本轮附加输入SHA256、Lean/mathlib和认证检查工具版本；如果输入或版本不符，先记录差异，不更新正式库。

返回独立T2_DRAFT.lean（T2Draft命名空间，导入现有MolecularDynamicsFormalization，不覆盖正式源文件）、T2_PROOF_REPORT.zh-CN.md及未经删改的检查日志。实现顺序：T2-L0的质量/逆质量连续线性包装及两侧逆；T2-S1解谓词与分量方程等价；T2-B1动量等于质量乘真实速度；T2-B2用开区间邻域等式与链式法则得到真实二阶导数；T2-B3映到NBodyEquationAt。随后处理T2-B4逆向桥接和T2-E1自由粒子初值样例。

固定mathlib直接推断ContinuousSMul在Position/PhaseSpace别名上曾超时；本地已证明可用NormedSpace.toIsBoundedSMul和IsBoundedSMul.continuousSMul提供局部实例。请核对所给成功探针，保持欧氏空间和现有乘积范数，不添加新的空间/正则性假设来绕过接口。Matrix.mulVec返回普通函数，必须使用已检查的欧氏连续线性包装及坐标桥接。

禁止sorry/admit/新增项目公理/unsafe绕过证明；禁止把NBodyEquationAt质量–加速度结论或完整二阶解预塞正向定理假设。局部解不定义成全局Flow；不证明Hamiltonian一致性、守恒、最大存在区间、延拓或Theorem1.1。存在唯一性只返回依赖路线和缺口，除非另批获准实施。

每条证明记录准确前提/结论、使用的本地固定库完整声明、实际类型检查命令/退出码以及#print axioms输出。环境没有lake或不能导入完整项目时如实标未验证，网站认证单文件通过不能替代本地正式验收。未完成目标只写文档并留下第一条具体动作，不加入占位证明。禁止自行提交、推送、合并、重置或修改共享handoff/knowledge/T1文件。本地会另行集成、运行check.ps1、核对CI和负责人语义签核。
```

网站后续顺序：原索引对话先收尾真实检索/版本或固定源码输入路径；收尾T1独立审阅，再发送第一段T2陈述任务；陈述稳定后发送第二段证明起草任务。本轮没有执行任何T2网站调用，不能写“MathCopilot已参与T2”。
