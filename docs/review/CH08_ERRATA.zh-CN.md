# 第8章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews《Molecular Dynamics》（2015），第8章正文印刷329–399页/PDF350–420页（Exercises之前）。
网站首轮103条已登记；原文忠实、修正版语义正确及证明完成是三种不同结论。以下条目包括公式疑误、证明缺口和域澄清，不能把记录条数当作已确认的原书错误数。
所有公式类疑点已目视核对原页；新增的PDF358–359正号耦合、PDF364漏dt均确实见于原页。

## 1. MD-8.1.1-NHFirstIntegralPrinted

- source_id：MD-8.1.1-NHFirstIntegralPrinted；印刷页 333 / PDF页 354。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> ds/dt=ξ. I_NH=H+μξ²/2+N_dβ⁻¹ ln s is conserved.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。
- 反例或理由：局部诊断：n=β=Q=invm₀=1，U=0，在p=1、ξ=1、s=2时原印导数I′=−1/2。亦可满足全实时间前提：取p′=−ξp、ξ′=p²−1在p>0上的非平凡周期轨道（第一积分p²/2−log p+ξ²/2），令s=C−log p，C足够大使s>0，q′=p。此时s′=ξ且I′并非恒零。
- 原文版 Lean 名称及状态：`MD.Ch08.nhIntegral`：定义；`MD.Ch08.nhIntegralPrinted`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.nhIntegral_corrected`：未证 第一积分候选、原印s导数与修正s导数各自对应的沿解零导数目标；原印版不证。
- 待人工核查点：[ERRATUM?] 保留Printed字面版并禁止将其视为已成立定理；推荐s′=sξ。另一种改法是保留s′=ξ而将(n/β)log s改成(n/β)s。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。nhIntegral逐项忠实于(8.8)。nhIntegralPrinted的hs忠实于原印s′=ξ，结论忠实于所印守恒声称；不因原书错误判忠实签名FAIL。但原印命题通常不成立：沿NH解，I′=(n/β)ξ(1/s−1)。nhIntegral_corrected只将hs改为s′=sξ，保持s>0、正参数、U∈C²和全实时间解量词，其零导数结论正确。
- 原文版分项：原印忠实性PASS；s′=ξ与log s守恒不相容，数学真值待导师
- 修正版分项：原送审s′=sξ的_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 2. MD-8.1.2.1-NoseHamiltoniansPrinted

- source_id：MD-8.1.2.1-NoseHamiltoniansPrinted；印刷页 334 / PDF页 355。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> H_N= p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+(N_d+1)k_BT ln s; H_NP=s[H_N-E_N]=s[p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+N_d k_BT ln s-E_N].

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。
- 反例或理由：n=1，invm₀=β=Q=1，U=0，q=p=0，π=EN=0，s=exp(1)>0：npHamiltonian=exp(1)，s*(noseHamiltonian−EN)=2 exp(1)。一般左右之差为−s log(s)/β。
- 原文版 Lean 名称及状态：`MD.Ch08.noseHamiltonian`：定义；`MD.Ch08.npHamiltonian`：定义；`MD.Ch08.nosePoincarePrinted`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.nosePoincare_corrected`：已证 两个原印Hamiltonian定义、所印等式目标及减去对数差项后的代数修正。
- 待人工核查点：[ERRATUM?] 保留Printed原文；修正版减去log s/β合理。若要坚持H_NP=s(H_N−E_N)，须另定义对数系数为n/β的H_N，不能与先前(n+1)/β版本混称。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。noseHamiltonian的对数系数(n+1)/β与原页第一式一致；npHamiltonian的n/β与(8.9)展开一致。nosePoincarePrinted忠实保留两个原印公式间不相容的等号。nosePoincare_corrected显式减去log s/β，代数正确；其无正参数/正s假设是Lean总函数上的代数恒等式，不代表物理域扩展。
- 原文版分项：两个原印H_N的对数系数不一致；Printed忠实性PASS
- 修正版分项：原送审显式减log s/β的代数修正版PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 3. MD-8.1.2.1-NPEquations

- source_id：MD-8.1.2.1-NPEquations；印刷页 334 / PDF页 355。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> q̇=M⁻¹p̃/s, p̃̇=sF, ṡ=sp_s/μ, ṗ_s=p̃ᵀM⁻¹p̃/s²-N_d k_BT-ΔH_N.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：[ERRATUM?] ΔH_N采用(8.9)展开中的N_d版本，与前一定义(N_d+1)版本不同，须明确区分。；已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。
- 反例或理由：在固定EN下，先前(n+1)/β版H_N−EN与代码delta相差log s/β；s=exp(1)、β=1时差为1，π′随之相差−1。
- 原文版 Lean 名称及状态：`MD.Ch08.npValidDomain`：定义；`MD.Ch08.npField`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.npDeltaN_corrected`：定义 NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。
- 待人工核查点：[ERRATUM?] 给delta命名为H_N^(n)−E_N，保留原页定义并与原印H_N^(n+1)区分。明确本def未证明是Hamilton方程。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。四个分量形式逐项匹配(8.10)–(8.13)，s为z.2.1、π为z.2.2，力为−∇U。有效域β,Q,s>0与对角逆质量已说明，但没有在总函数def中强制。delta明确取(8.9)展开的n/β版本；原页却把ΔH_N定义成先前H_N−H_N⁰，若沿用(n+1)/β版本就不同。因此这是合理而已披露的展开式选择，仍需人工解决原书同名歧义，不判签名FAIL。
- 原文版分项：四个分量形式匹配；n/β与(n+1)/β同名歧义待导师
- 修正版分项：原送审n/β展开选择合理；本轮命名delta与有效域谓词待复审
- 当前状态：待复审 / EAUDIT01。

## 4. MD-8.2.1-Examples81and82

- source_id：MD-8.2.1-Examples81and82；印刷页 337–338 / PDF页 358–359。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> Example 8.1 Φ=-ξ(0,p), g=μ⁻¹(p·∇pH-N_d k_BT). Example 8.2 Φ=ξG(z), g=μ⁻¹[∇H-k_BT∇]·G. Configurational choice G=(∇qK,0).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF358–359：例8.2确实印为正号耦合与正反馈，驻定声称有符号疑误，不是转录错误。；[ERRATUM?] 例8.2正号耦合与所印正反馈不能保持所列高斯Gibbs权；额外generalizedFeedback_stationary签名错误，见本次审校反例。
- 反例或理由：n=1，J=0，H(x)=x²/2，G(x)=1，β=Q=1，均满足全部光滑性及正性前提。代码给F(x,ξ)=(ξ,x)，ρ=exp[−(x²+ξ²)/2]。在(x,ξ)=(1,1)，div(ρF)=−2 exp(−1)≠0。
- 原文版 Lean 名称及状态：`MD.Ch08.generalizedFeedback`：定义；`MD.Ch08.configurationalFeedback`：定义；`MD.Ch08.generalizedFeedback_stationaryPrinted`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.generalizedFeedback_stationary_corrected`：未证 原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。
- 待人工核查点：[ERRATUM?] 忠实原文的两个反馈def可保留并标Printed/literal；正确驻定版应取Φ=−ξG，或保留Φ=+ξG而改g=(div G/β−DH[G])/Q。构型反馈若配正号耦合也须相应反号。例8.1的负号耦合与正反馈不受影响。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：FAIL。generalizedFeedback和configurationalFeedback逐项忠实转写例8.2与构型公式；但与正号耦合Φ=+ξG及高斯exp[−β(H+Qξ²/2)]组合时，generalizedFeedback_stationary是错误命题，不能因有sorry而忽略其签名问题。令A=βDH[G]−div G，驻定条件变成ξA+βQξg=2ξA，而不是0。原书例8.2的正号组合本身也有数学疑误，须NEEDS_HUMAN；额外驻定定理没有Printed/literal标识，故该签名判FAIL。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：待复审 / EAUDIT01。

## 5. MD-8.4-AdditiveThermostatSDE

- source_id：MD-8.4-AdditiveThermostatSDE；印刷页 342–343 / PDF页 363–364。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> dq=M⁻¹pdt; dp=-∇Udt-Φ(ξ,z)-Γpdt+√(2k_BT)M^{1/2}Γ^{1/2}dW; dξ=gdt-Γ̂ξdt+√(2k_BT)M̂^{1/2}Γ̂^{1/2}dŴ. All Wiener coordinates are independent.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF364：(8.23)的−Φ项确实漏dt；漂移解释补dt。矩阵不交换时原平方根噪声与驻定协方差未必相容。；[ERRATUM?]原书矩阵噪声的对称性不足以保证Gibbs相容。；现有声明只是未组装的定义组件。
- 反例或理由：组件间无逻辑绑定：取n=1、invm=1，而在独立fluctuationDissipation中取M=2、Γ=1、β=1、B=2，则该资格成立，但漂移使用质量1，协方差使用质量2。当前定义没有条件排除此不相容组合。此例说明参数连接缺失，并非声称某个未出现的定理为假。
- 原文版 Lean 名称及状态：`MD.Ch08.independentWiener`：定义；`MD.Ch08.additiveSDE`：定义；`MD.Ch08.stochasticThermostatDrift`：定义；`MD.Ch08.fluctuationDissipation`：定义；`MD.Ch08.thermostatBlockNoise`：定义；`MD.Ch08.stochasticThermostatSolution`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。 常噪声积分SDE模板与正对角物理质量的统一恒温器解规格；同一n+k维独立Wiener、分块噪声、两组协方差和漂移质量已绑定。未含一般非对角物理质量、存在唯一性或不变律。
- 待人工核查点：只修JSON范围可保留现有组件；如要完成原模型，另定义统一解谓词，绑定对角逆质量或直接用一般M⁻¹，构造分块B和共同n+k维独立W，并分别加入两组明确的协方差匹配条件。保留原文并注明(8.23)的dt疑误和矩阵相容疑误。本次不修改工程。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：FAIL。FAIL源于完整模型对象与参数关联缺失，非sorry。independentWiener本身正确地要求概率测度、逐坐标标准Brownian及全路径独立；additiveSDE本身是确定初值、连续路径、自然噪声历史可测、可积漂移和非负时刻积分方程的合理模板。stochasticThermostatDrift符号正确；原书(8.23)的-Φ项漏写dt确实印在原页，statement_latex忠实保留，不能把它误判为转录漏字。作为漂移定义加入dt解释是合理勘误，须注明。四个组件没有共同量化和连接成具体两组SDE；额外的一般M协方差谓词也未与对角漂移连接，故不能认证所称完整模型。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：待复审 / EAUDIT01。

## 6. MD-8.4-OUStationarityPrinted

- source_id：MD-8.4-OUStationarityPrinted；印刷页 343–344 / PDF页 364–365。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> The OU momentum process with drift -Γp and noise √(2k_BT) M^{1/2}Γ^{1/2} preserves exp(-βpᵀM⁻¹p/2). The displayed diffusion term is β⁻¹Tr(Γ^{1/2}M^{1/2}[βM⁻¹ppᵀM⁻¹-M⁻¹]M^{1/2}Γ^{1/2})ρ̄=-drift.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。；[ERRATUM?]保留原所印等式及β=2反例；修正版的BBᵀ=(2/β)ΓM为明确额外资格，在对称情形蕴含交换性。
- 反例或理由：原印式取β=2、M=Γ=1、p=0，ρ=1，drift=1，而所印diffusion=-1/2，故diffusion≠-drift。另取M=diag(1,4)、Γ=[[1,1/2],[1/2,1]]、β=1；两者正定，原噪声给BBᵀ=2M^{1/2}ΓM^{1/2}=[[2,2],[2,8]]，所需ΓM+MΓ=[[2,5/2],[5/2,8]]，不相等。
- 原文版 Lean 名称及状态：`MD.Ch08.ouFokkerPlanck`：定义；`MD.Ch08.diffusionPrinted`：未证；`MD.Ch08.diffusionPrinted_counterexample`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.ouStationarity_corrected`：未证 协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。
- 待人工核查点：原文与diffusionPrinted保留并加[ERRATUM?]；正确扩散表达式在提出Hessian中的β后去掉外部β⁻¹，或保留外部β⁻¹并在方括号恢复β²和β。矩阵结论明确补交换/协方差条件；修正版与反例继续分别陈列。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。逐声明：ouFokkerPlanck PASS，采用正div(ρΓp)对应漂移-Γp，扩散项为½ΣC_ij∂_i∂_jρ；ouStationarity_corrected PASS，β>0、M正定、Γ半正定与BBᵀ=(2/β)ΓM使M、Γ交换，Gaussian协方差M/β满足Lyapunov方程，结论是∀p局部Fokker–Planck算子为零。diffusionPrinted是原错误等式M=Γ=1,p=0的忠实标量实例，忠实性PASS、原书真值NEEDS_HUMAN。diffusionPrinted_counterexample PASS。没有把局部算子恒零升级为全局过程存在或唯一不变律；没有因sorry判FAIL。整条因原书疑误NEEDS_HUMAN。
- 原文版分项：diffusionPrinted忠实性PASS；原印β因子和矩阵相容性待导师
- 修正版分项：原送审ouStationarity_corrected及标量反例PASS；仅局部算子恒零
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 7. MD-8.4-Proposition82

- source_id：MD-8.4-Proposition82；印刷页 344–345 / PDF页 365–366。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> If the Lie algebra generated by F and G in (8.25) spans R^m, then the Hörmander condition holds for (8.25)–(8.26).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。；[ERRATUM?]σ=0反例；Printed仅作忠实记录，corrected在σ≠0下通过。
- 反例或理由：n=1，F(z)=1，G(z)=0，g(z)=0，γ=σ=0。原物理Lie点值张成ℝ，但提升种子只有常场(1,0)及零场，所有括号为零，任一点张成维数1<2。
- 原文版 Lean 名称及状态：`MD.Ch08.proposition82Printed`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.proposition82_corrected`：已证 所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。
- 待人工核查点：保留proposition82Printed并注明[ERRATUM?]；使用proposition82_corrected作为有效结论，明确[EXTRA]C∞与σ≠0，并说明这里的Hörmander定义包含漂移。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。Printed忠实性PASS、原命题数学资格NEEDS_HUMAN；corrected PASS。n任意，F/G/g均C∞，γ任意实数，w是ℝⁿ×ℝ中的任意点，hspan在w.1点要求{F,G}的Lie点值张成全空间，结论在同一提升点w要求{b₀,b₁}张成全空间。原文“spans ℝᵐ”以点态方式表达，适用于相应点。σ≠0时可从b₁得到垂直方向，从[b₀,b₁]得到G的水平提升，再通过光滑系数组合得到F的水平提升；迭代括号的点值张成保留全部方向。改正的前提不是假定目标结论，也未引入无关遍历性结论。
- 原文版分项：Printed忠实性PASS；σ=0使原结论失效
- 修正版分项：原送审C∞且σ≠0的_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 8. MD-8.4.1-NHL

- source_id：MD-8.4.1-NHL；印刷页 345–346 / PDF页 366–367。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> dq=M⁻¹pdt, dp=-∇Udt-ξpdt, dξ=μ⁻¹[pᵀM⁻¹p-N_dk_BT]dt-γξdt+√(2k_BTγμ⁻¹)dW. Quadratic specialization: U=qᵀAq/2, M=I.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p不产生单位质量方程；正确方向相反并须同步变换势。；[ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。
- 反例或理由：范围差异：若M⁻¹=[[1,1/2],[1/2,1]]，q̇₁=p₁+p₂/2，不可能用任何固定invm₁使invm₁p₁对所有p相等。原书重缩放：取一维M=4，q̃=q/2、p̃=2p，则q̃̇=p/8=p̃/16，而非p̃。
- 原文版 Lean 名称及状态：`MD.Ch08.nhlDrift`：定义；`MD.Ch08.isNHLSolution`：定义；`MD.Ch08.harmonicPotential`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。 仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。
- 待人工核查点：将JSON范围限制为现有正对角质量、无约束模型，并明确尚无二次专门化声明；若要宣称全模型，需一般矩阵质量及参数关联。原书重缩放保留[ERRATUM?]，可另陈列正确变换q̃=M^{1/2}q,p̃=M^{-1/2}p及变换后的势；不改原文。本次不修改工程。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：FAIL。FAIL限于其“全SDE/二次专门化”覆盖声明；三个对象的自身公式正确。nhlDrift展开为((diag(invm)p,-∇U-ξp),(Σinvm_i p_i²-n/β)/Q-γξ)。isNHLSolution明确invm_i,β,Q,γ均正，噪声只作用于ξ且幅度sqrt(2γ/(βQ))，对应μ=Q、k_BT=1/β及无约束N_d=n的正对角质量特例。harmonicPotential(A,q)=qᵀAq/2对任意实矩阵有定义；仅A对称时梯度等于Aq。当前声明没有一般M对象，也没有以invm=1和A正定把SDE专门化为(8.30)–(8.32)的规格。原书重缩放另列NEEDS_HUMAN，不把原书错误归咎于Lean公式。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：待复审 / EAUDIT02。

## 9. MD-8.4.1-Proposition83

- source_id：MD-8.4.1-Proposition83；印刷页 347–348 / PDF页 368–369。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> If A is symmetric positive definite with distinct eigenvalues, the 2N_c vectors C₁,D₁,...,C_Nc,D_Nc are linearly independent on D=R^{2Nc}\⋃V_k.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：[ERRATUM?]原证明下标、模态标量式及第二组系数消去需核对；命题与Lean签名正确。
- 反例或理由：PASS（签名与正确命题一致；原证明疑误另在json_review中NEEDS_HUMAN）。A.PosDef在实域提供对称正定，hdist是全部n个本征值的单射性。z∈D严格要求每一模态(q̂_i,p̂_i)不同时为零。Family的Fin n⊕Fin n族是C₁..C_n和D₁..D_n，和书中交错顺序仅差排列。结论LinearIndependent ℝ同时消去两组任意实系数，并非仅证明其中一组。每个模态的两列系数矩阵行列式为-λ_i(p̂_i²+λ_i q̂_i²)，由λ_i>0和域条件非零，继而两个次数<n的多项式在n个不同本征值上为零，均恒零。因此项目结论合理且完整；不能照抄书中未处理第二组系数的论证来替代这一检查。
- 原文版 Lean 名称及状态：`MD.Ch08.proposition83`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。 指定模态域内的2n个实际线性场值线性无关；不扩大到例外零模态。
- 待人工核查点：Lean声明无需改动。原证明文字原样保留并加[ERRATUM?]；若另写勘误，令π(x)=Σα_kx^k、σ(x)=Σβ_kx^k，由定义得到π(λ_i)p̂_i+λ_iσ(λ_i)q̂_i=0及λ_iπ(λ_i)q̂_i-λ_iσ(λ_i)p̂_i=0；先解出π(λ_i)=σ(λ_i)=0，再分别用根数论证两组系数全零。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：PASS。PASS（签名与正确命题一致；原证明疑误另在json_review中NEEDS_HUMAN）。A.PosDef在实域提供对称正定，hdist是全部n个本征值的单射性。z∈D严格要求每一模态(q̂_i,p̂_i)不同时为零。Family的Fin n⊕Fin n族是C₁..C_n和D₁..D_n，和书中交错顺序仅差排列。结论LinearIndependent ℝ同时消去两组任意实系数，并非仅证明其中一组。每个模态的两列系数矩阵行列式为-λ_i(p̂_i²+λ_i q̂_i²)，由λ_i>0和域条件非零，继而两个次数<n的多项式在n个不同本征值上为零，均恒零。因此项目结论合理且完整；不能照抄书中未处理第二组系数的论证来替代这一检查。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：网站PASS（首轮声明未变）。

修正证明路线：令π(x)=Σα_kx^k、σ(x)=Σβ_kx^k，由原定义得到π(λ_i)p̂_i+λ_iσ(λ_i)q̂_i=0、λ_iπ(λ_i)q̂_i−λ_iσ(λ_i)p̂_i=0。正定性和域条件使二元系数矩阵可逆，故π、σ在全部n个不同本征值上同时为零；两者次数<n，分别消去两组系数。命题签名无须修改，证明仍未完成。

## 10. MD-8.4.1-Theorem81

- source_id：MD-8.4.1-Theorem81；印刷页 346–348 / PDF页 367–369。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> If A is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on D×R.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。；[ERRATUM?]字面版含σ=0反例；物理上下文的参数资格与字面版分开。原质量重缩放与所引证明的局部排印/推导疑误亦应保留。
- 反例或理由：n=1，A=[1]，Q=θ=γ=1，σ=0，w=((q,p),ξ)=((1,0),0)。正定、谱单射及D条件成立，但种子仅有漂移((0,-1),-1)和零噪声。单一场与自身括号为零，点值张成最多一维，达不到三维。
- 原文版 Lean 名称及状态：`MD.Ch08.theorem81Printed`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.theorem81_corrected`：已证 所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。
- 待人工核查点：Printed保留并标[ERRATUM?]；实际使用corrected。注明正Q/θ/γ是物理[EXTRA]，σ非零是当前括号条件的必要资格；需要还原(8.29)物理噪声时另外绑定σ²=2γθ/Q。保留原上下文疑误，不据其声称全局遍历性。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。逐声明：theorem81Printed按所印定理字面保留正定、不同本征值、D×ℝ及任意Q,θ,γ,σ，字面对应PASS，但未限定参数的数学真值NEEDS_HUMAN。theorem81_corrected PASS：A正定、谱单射、Q,θ,γ正、σ非零，w.1∈D；结论是同一点w的实际迭代Lie括号张成全空间。D29/D30及textbookNHLDrift展开为((p,-Aq-ξp),Q⁻¹(Σp_i²-nθ)-γξ)，噪声是(0,σ)。负号G与书中正G生成同一个Lie代数。结论强度限于包含漂移的Hörmander点态条件，不是解存在、转移核光滑、可达性或几何遍历性。corrected将σ视为独立非零参数是有效的更一般括号结论，物理NHL需再作σ=sqrt(2γθ/Q)专门化。
- 原文版分项：Printed忠实性PASS；缺非零噪声资格
- 修正版分项：原送审正参数与σ≠0的_corrected点态括号结论PASS，非全局遍历性
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 11. MD-8.4.1-LyapunovRatePrinted

- source_id：MD-8.4.1-LyapunovRatePrinted；印刷页 349 / PDF页 370。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。；{"codes": ["ERRATUM_LYAPUNOV_RATE"], "detail": "lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书α=min(2a,γμ)及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为min(2a,γ)合理且正确：ξ能量的系数是Q/2，故须α≤γ；结合平方不等式及U≤Umax得所写δ。修正版没有额外宣称几何遍历。", "suggested_fix": "原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，α=min(2a,γ)。"}
- 反例或理由：P²=0,U=Umax=2,ξ=10,Q=4,θ=γ=1,a=2,N=8；aγQ=Nθ=8。Printed α=4，左端−383，右端−479，故−383≤−479为假。
- 原文版 Lean 名称及状态：`MD.Ch08.lyapunovAlphaPrinted`：定义；`MD.Ch08.lyapunovRatePrinted`：未证；`MD.Ch08.lyapunovRate_counterexample`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.lyapunovAlpha_corrected`：定义；`MD.Ch08.lyapunovRate_corrected`：未证 所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。
- 待人工核查点：原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，α=min(2a,γ)。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书α=min(2a,γμ)及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为min(2a,γ)合理且正确：ξ能量的系数是Q/2，故须α≤γ；结合平方不等式及U≤Umax得所写δ。修正版没有额外宣称几何遍历。
- 原文版分项：Printed忠实性PASS；min(2a,γμ)一般不正确
- 修正版分项：原送审min(2a,γ)修正版及反例PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 12. MD-8.4.3-PreEquilibriumMeans

- source_id：MD-8.4.3-PreEquilibriumMeans；印刷页 354–355 / PDF页 375–376。
- 类别：域或覆盖说明
- 原文引文及公式（对应原页全文保存在原文JSON）：

> θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：{"codes": ["MISSING_MOMENT_INTEGRABILITY", "MISSING_DENSITY_EVOLUTION_SPEC"], "detail": "两积分的变量、2K=kineticTwice invm p及ξ权重与原页一致，preEquilibriumDensity仅要求每个t≥0非负可积归一。该条件不保证两项加权函数可积，因而Lean总化Bochner积分未必代表原文有限分布平均；还没有限定ρ满足原文明说的NHL Fokker–Planck演化。局部稳定性/闭合方程缺口已披露，但不应将上述资格定义称为完整的预平衡密度资格。", "suggested_fix": "增加每个t≥0的Integrable (kineticTwice invm z.1.2*ρ t z)与Integrable (z.2*ρ t z)，并明确正质量。若保留pre-equilibrium命名，应添加FP演化规格；否则声明仅定义任意随时间概率密度的形式积分，并明确演化未覆盖。"}
- 反例或理由：n=1,invm=1：取ρ(q,p,ξ)为q的标准高斯密度乘p与ξ各自的标准Cauchy密度（各t相同）。它满足preEquilibriumDensity，但p²ρ及ξρ均不可积，有限均值不存在；Lean积分在不可积时总化为0。
- 原文版 Lean 名称及状态：`MD.Ch08.meanKineticTwice`：定义；`MD.Ch08.meanBath`：定义；`MD.Ch08.preEquilibriumDensity`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。 任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。
- 待人工核查点：增加每个t≥0的Integrable (kineticTwice invm z.1.2*ρ t z)与Integrable (z.2*ρ t z)，并明确正质量。若保留pre-equilibrium命名，应添加FP演化规格；否则声明仅定义任意随时间概率密度的形式积分，并明确演化未覆盖。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：FAIL。两积分的变量、2K=kineticTwice invm p及ξ权重与原页一致，preEquilibriumDensity仅要求每个t≥0非负可积归一。该条件不保证两项加权函数可积，因而Lean总化Bochner积分未必代表原文有限分布平均；还没有限定ρ满足原文明说的NHL Fokker–Planck演化。局部稳定性/闭合方程缺口已披露，但不应将上述资格定义称为完整的预平衡密度资格。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：待复审 / EAUDIT02。

## 13. MD-8.4.4-RescalingStationary

- source_id：MD-8.4.4-RescalingStationary；印刷页 355 / PDF页 376。
- 类别：域或覆盖说明
- 原文引文及公式（对应原页全文保存在原文JSON）：

> With these definitions, the method preserves the canonical probability density ρ_β. The book does not prove ergodicity.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：{"codes": ["SUPPORT_NOT_SEPARATED_FROM_ZERO", "SINGULAR_BOUNDARY_CONTROL_MISSING"], "detail": "Itô二阶项确实冻结rescalingNoise Φ θ z，不含噪声导数，正确；C²势、正θ,Z和归一密度亦正确。但havoid量化Function.support f，即f≠0的集合，而HasCompactSupport约束的是其闭包；这不保证闭包与p=0分离。JSON所称“支撑远离K=0”比实际前提强。Admissible不控制Φ′在0附近的增长，因此不能直接用避开奇点的紧支撑分部积分论证覆盖所有给定测试函数。本项FAIL指所宣称的域/边界规格不足，并非已提供该Lean等式的数值反例。", "suggested_fix": "将havoid改为∀z∈tsupport f,z.2≠0，或明确存在ε>0使f的支撑上K≥ε。若希望包含接触p=0的测试函数，应另设边界、噪声正则性及生成元可积性条件并论证；不能静默扩大弱驻定范围。"}
- 反例或理由：n=1，f(q,p)=χ(q)η(p)exp(−1/p²)（p≠0），f(q,0)=0，其中χ、η为光滑紧支撑截断且η在0附近等于1。它满足hf,hc,havoid，但support闭包包含p=0，任意ε>0都有非零f且|p|<ε。允许的Φ(K)=(2+sin(exp(1/K²)))/K（K>0）满足Admissible的大小限制，却有无控制的Φ′；说明现有前提不能声称已排除奇异边界。
- 原文版 Lean 名称及状态：`MD.Ch08.rescalingStationary`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。 闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。
- 待人工核查点：将havoid改为∀z∈tsupport f,z.2≠0，或明确存在ε>0使f的支撑上K≥ε。若希望包含接触p=0的测试函数，应另设边界、噪声正则性及生成元可积性条件并论证；不能静默扩大弱驻定范围。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：FAIL。Itô二阶项确实冻结rescalingNoise Φ θ z，不含噪声导数，正确；C²势、正θ,Z和归一密度亦正确。但havoid量化Function.support f，即f≠0的集合，而HasCompactSupport约束的是其闭包；这不保证闭包与p=0分离。JSON所称“支撑远离K=0”比实际前提强。Admissible不控制Φ′在0附近的增长，因此不能直接用避开奇点的紧支撑分部积分论证覆盖所有给定测试函数。本项FAIL指所宣称的域/边界规格不足，并非已提供该Lean等式的数值反例。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：待复审 / EAUDIT02。

## 14. MD-8.5-SLSBracketPrinted

- source_id：MD-8.5-SLSBracketPrinted；印刷页 358 / PDF页 379。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> D=(ξp,-p,-p·∇U-ξ), D′=[D,Y_{Nc+1}]=(p,0,1), [D′,Y_i]=e_i.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。；{"codes": ["ERRATUM_LIE_BRACKET_SIGN"], "detail": "slsBracketPrinted逐字对应原书(p,0,1)，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按VectorField.lieBracket V W=DW·V−DV·W，常向量Yξ给[D,Yξ]=−∂ξD=(−p,0,1)，故_corrected签名正确。反向括号会整体变为(p,0,−1)，不能仅靠约定得到原书(p,0,1)。二次括号的整体符号不影响张成。", "suggested_fix": "保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为−p。"}
- 反例或理由：n=1,U=0,p=1时[D,Yξ]=((−1,0),1)，而Printed右端为((1,0),1)。
- 原文版 Lean 名称及状态：`MD.Ch08.slsBathNoise`：定义；`MD.Ch08.slsBracketPrinted`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.slsBracket_corrected`：未证 第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。
- 待人工核查点：保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为−p。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。slsBracketPrinted逐字对应原书(p,0,1)，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按VectorField.lieBracket V W=DW·V−DV·W，常向量Yξ给[D,Yξ]=−∂ξD=(−p,0,1)，故_corrected签名正确。反向括号会整体变为(p,0,−1)，不能仅靠约定得到原书(p,0,1)。二次括号的整体符号不影响张成。
- 原文版分项：Printed忠实性PASS；括号首分量符号不一致
- 修正版分项：原送审−p首分量_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 15. MD-8.5-SLSLeapfrog

- source_id：MD-8.5-SLSLeapfrog；印刷页 358–359 / PDF页 379–380。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> q=q₀+ηM⁻¹p; η̇=ξ, ξ̇=-∂ηU(q₀+ηM⁻¹p). Leapfrog: ξ_{1/2}=ξ-h(M⁻¹p)·∇U(q)/(2μ), q′=q+hξ_{1/2}M⁻¹p, ξ′=ξ_{1/2}-h(M⁻¹p)·∇U(q′)/(2μ).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：原书PDF379末段确实印作 ξ̇=−∂ηU，未带μ⁻¹；PDF380的两次kick及逐坐标场则都含μ⁻¹。statement_latex忠实保留了这个不一致。；已目视核对原页PDF379：η约化式的ξ导数漏μ⁻¹，新增Printed与恢复1/Q的_corrected；Q>0、正质量与U可微为物理域。分裂映射原有定义未改。
- 反例或理由：取一维M=1、p=1、U(q)=q、μ=2，由(8.36)有ξ̇=−1/2，而印出的η约化式给−1。
- 原文版 Lean 名称及状态：`MD.Ch08.slsBathKick`：定义；`MD.Ch08.slsDriftStep`：定义；`MD.Ch08.slsLeapfrog`：定义；`MD.Ch08.slsCoordinateField`：定义；`MD.Ch08.slsReducedPrinted`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.slsReduced_corrected`：定义 原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。
- 待人工核查点：原印约化式保持不动，补[ERRATUM?]说明μ⁻¹疑漏；若另设修正版，应写ξ̇=−μ⁻¹∂ηU。算法定义不需修改。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。Vec n=Fin n→ℝ，Phase n=(q,p)，z.2=ξ，invm为对角逆质量，Q对应原书μ。slsBathKick对任意n、invm、U、Q、h、z只更新ξ；slsDriftStep只更新q且保留p、ξ。函数复合从右往左执行，slsLeapfrog精确给出半kick、全drift、半kick，第二次梯度在新q处。slsCoordinateField只激活所选i的q分量，并给出−invm_i p_i ∂iU/Q。四个定义均忠实对应算法；未把有疑误的η约化方程作为已证结论。 半kick、drift、半kick和逐坐标场：PASS。 [EXTRA] Q≠0、正质量及U可微是物理解释的域；Lean定义作总函数，不据此声称Q=0时有物理意义。 覆盖边界：无η约化方程定理、体积/面积保持定理、二阶稳态误差或OU随机步骤定理。
- 原文版分项：原送审四个算法/坐标场定义PASS；原书η约化漏μ⁻¹待导师
- 修正版分项：本轮另列η约化Printed与1/Q修正版，待复审
- 当前状态：待复审 / EAUDIT03。

## 16. MD-8.6-IsokineticDivergencePrinted

- source_id：MD-8.6-IsokineticDivergencePrinted；印刷页 362–363 / PDF页 383–384。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> ρ=e^{-w(q,p)}Φ(K(p)); div f_iso=(N_c-1)pᵀM⁻¹F/(pᵀM⁻¹p), w=(N_c-1)U/K.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。；PDF383确实印正号div f=(Nc−1)λ，PDF384随后仍用正号的∇w·f等式并给w=(Nc−1)U/K；原文逐字内容应保留。；已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。
- 反例或理由：n=2、invm=(1,1)、F(q)=(1,0)、p=(1,0)：K=1、λ=1，真实相空间散度为−1，原印右端为+1。
- 原文版 Lean 名称及状态：`MD.Ch08.isoAnsatz`：定义；`MD.Ch08.isoDivergencePrinted`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.isoDivergence_corrected`：未证 一般光滑力的原印/符号修正散度目标及权重ansatz；w方程和概率不变另列缺口。
- 待人工核查点：保留isoDivergencePrinted并标[ERRATUM?]；修正版负号正确。PDF384的∇w·f等式也应在勘误说明中相应改负号，不应把正的w表达式改成负的。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。isoAnsatz对任意实函数w、Φ给exp(−w)Φ(K)，是权重表达式而非已归一概率密度。isoDivergencePrinted以任意n、invm、C¹力场F和K≠0为前提，完整保留原印正号：字面忠实PASS，数学疑误NEEDS_HUMAN。isoDivergence_corrected使用完全相同的对象和前提，仅改为−(n−1)λ，数学陈述PASS。textbookDivergence是fderiv的迹，不是负散度约定；λ对p为−1次齐次，故div_p(F−λp)=−nλ−p·∇pλ=−(n−1)λ。 isoAnsatz：PASS；isoDivergencePrinted：忠实PASS/数学NEEDS_HUMAN；isoDivergence_corrected：PASS。 [EXTRA] C¹和K≠0支持实际散度的定义与局部微分；Φ的正性、光滑性未由裸权重定义保证，未据此推出概率不变性。 w方程、不变曲面测度和归一化均不在当前完整结论中。
- 原文版分项：Printed忠实性PASS；原印散度正号有误
- 修正版分项：原送审负号_corrected签名PASS；w本身保留正号
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 17. MD-8.6.1-SINWeightPrinted

- source_id：MD-8.6.1-SINWeightPrinted；印刷页 365 / PDF页 386。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。；PDF386确实印w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2)，未含μ₂；statement_latex忠实，不能静默把原印式改成修正式。
- 反例或理由：取Q1=1、Q2=2、θ=1、U=0、z=(0,0,√2,1)、γ=0。原印ρ=e^(−1/2)，有div(ρb)=ρ/2≠0；补上Q2后的通量散度为0。
- 原文版 Lean 名称及状态：`MD.Ch08.sinWeightPrinted`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinWeight_corrected`：定义；`MD.Ch08.sinWeight_stationary_corrected`：未证 原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。
- 待人工核查点：原印权重保留并标[ERRATUM?]缺热浴质量μ₂；修正版和其局部驻定签名可保留。须另证曲面测度、边缘Gibbs及含OU情形。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。sinWeightPrinted是原印exp(−w)，没有把w和密度混淆。sinWeight_corrected把二次项改成Q2 ξ₂²/2，合理且正确。sinWeight_stationary_corrected量化C²势U、Q1,Q2,θ>0和K(z)=θ，在γ=0且F=−U′时断言div(ρb)(z)=0；这是环境空间通量散度在壳面处的逐点等式，不是曲面测度不变性或包含OU的完整Fokker–Planck定理。沿b有K̇=0；div b=−pF/K+Q1ξ₁²ξ₂/K−ξ₂，而b·∇logρ=(pF−ξ₂(Q1ξ₁²−θ))/K，两者相加为ξ₂(θ/K−1)，壳面上为0。 sinWeightPrinted：忠实PASS/一般质量数学NEEDS_HUMAN；sinWeight_corrected、sinWeight_stationary_corrected：PASS。 正约束保证分母非零；C²假设略强但不构成偷换。 印刷式在μ₂=1时消除此项疑误，但原节并未把μ₂固定为1。
- 原文版分项：Printed忠实性PASS；原印二次项缺μ₂
- 修正版分项：原送审补Q2的权重与壳面局部驻定签名PASS，非曲面测度不变性
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 18. MD-8.6.2-SINProjectedBracketsPrinted

- source_id：MD-8.6.2-SINProjectedBracketsPrinted；印刷页 367 / PDF页 388。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> u₀=Πf, u₁=Π[f,g], u₂=Π[f,[f,g]], u₃=Π[f,[f,[f,g]]]. The displayed equations (8.48)–(8.53) give their components, with D=2p²+ξ₁².

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。；PDF388逐式核对：(8.48)为u0；(8.49)ξ₁分量前确无共同σ；(8.50)印u1却重复u0展开式；(8.51)印u2却是首交换子的投影。(8.52)的p分量确为−σa而非−σξ₁²a，故Lean忠实保留了原印式，不应替书改系数。；已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
- 反例或理由：q=0,p=1,ξ₁=1,ξ₂=0时u0投影=[1,0,0]，而实际首括号投影=[0,−σ/3,2σ/3]；不能把(8.50)中重复的u0当作u1。另在p=0,q≠0、ξ₁≠0处，(8.49)的第三分量为ξ₁(1−1)=0，整个u1为零；因此原页“(8.53)平行于u1”的论证也不能直接作为非零向量论据。
- 原文版 Lean 名称及状态：`MD.Ch08.bracket4`：定义；`MD.Ch08.sinBracket`：定义；`MD.Ch08.projectFirstThree`：定义；`MD.Ch08.sinD`：定义；`MD.Ch08.sinU0Printed`：定义；`MD.Ch08.sinU1Printed`：定义；`MD.Ch08.sinU2Printed`：定义；`MD.Ch08.sinU1DerivativePrinted`：定义；`MD.Ch08.sinU2LongPrinted`：定义；`MD.Ch08.sinU2Long_at_p0`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinProjected_corrected`：定义 原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。
- 待人工核查点：保留所有Printed定义，并给(8.49)–(8.53)加[ERRATUM?]。修正版应以sinProjected_corrected的真实四维括号为准；不得仅改下标就宣称长式已校正。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。bracket4采用Dg·f−Df·g；sinBracket的0=f、1=[f,g]、k+2=[f,sinBracket(k+1)]递归及projectFirstThree均正确。sinU0Printed是(8.48)展开式；sinU1Printed重复它，忠实于(8.50)；sinU2Printed忠实于(8.51)；sinU1DerivativePrinted的d=∂ξ₂λ且第三分量未乘σ，忠实于(8.49)。sinProjected_corrected先在完整四维计算再投影，对j:Fin 4给出真实迭代括号的定义，无冒充显式公式等式。sinU2LongPrinted逐项对应(8.52)，sinU2Long_at_p0对所有σ、γ、z只假设p=0，得到[0,σξ₁²q/D²,0]，即(8.53)，在Lean总除法约定下也成立。 真实括号与投影定义：PASS；所有Printed表达式的字面忠实性：PASS。 sinU2Long_at_p0：内部代数特化PASS；它没有断言Printed长式等于真实二重括号。 原页“any pair”也应人工复核：p=0时首括号投影为0，并非任意一对均独立。 [EXTRA] θ>0且K=θ时D=2θ>0，裸Printed定义对零分母的总化不代表物理延拓。
- 原文版分项：Printed各表达式忠实性PASS；(8.49)–(8.53)疑误待导师
- 修正版分项：原送审完整四维真实括号再投影定义PASS，长式未声称等于真实括号
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 19. MD-8.6.2-SINThirdBracketPrinted

- source_id：MD-8.6.2-SINThirdBracketPrinted；印刷页 368 / PDF页 389。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> The third projected commutator is displayed in (8.54), with polynomial η in (8.55); its p=0 specialization is printed as u₃=-2σq∂q-σq(-γ+ξ₂)∂p in (8.56).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。；PDF389的(8.54)q分量分母为D²，(8.55)的13项多项式逐项与sinEtaPrinted一致；(8.56)原印q分量为−2σq，确无ξ₁²分母。
- 反例或理由：取σ=1、q=1、p=0、ξ₁=2、γ=ξ₂=1。(8.54)给[−1/2,0,0]，(8.56)给[−2,0,0]，而sinU3Zero_corrected与(8.54)相符。
- 原文版 Lean 名称及状态：`MD.Ch08.sinEtaPrinted`：定义；`MD.Ch08.sinU3Printed`：定义；`MD.Ch08.sinU3ZeroPrinted`：定义；`MD.Ch08.sinU3Zero_specialize`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinU3Zero_corrected`：定义 原印三重交换子候选及p=0内部代数核对；真实三重交换子等式列覆盖缺口。
- 待人工核查点：保留原印两式并标[ERRATUM?]内部不一致；注明_corrected是“对(8.54)的p=0代数特化修正”，不能命名或描述为已经验证的真实三重交换子公式。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。sinEtaPrinted完整保留γ²、ξ₁幂次及各交叉项；sinU3Printed的三个分量完整对应(8.54)。sinU3ZeroPrinted忠实于(8.56)；sinU3Zero_corrected仅修正从(8.54)出发的p=0内部代数特化，q分量为−2σq/ξ₁²，p分量仍为−σq(−γ+ξ₂)。sinU3Zero_specialize量化任意σ、γ、z，假设p=0和ξ₁≠0，断言Printed长式等于上述内部修正版，陈述正确。该修正版没有宣称已校正真实三重括号；scope的这一限制必不可少。 sinEtaPrinted、sinU3Printed、sinU3ZeroPrinted：忠实PASS；sinU3Zero_corrected及sinU3Zero_specialize：在明确的内部代数意义下PASS。 ξ₁≠0是约去幂次所需的有效前提；无θ、γ、σ正性需求。 原印长式是否等于真实三重括号未由本条签名断言或证明。
- 原文版分项：Printed忠实性PASS；(8.54)/(8.56)内部不一致
- 修正版分项：原送审_corrected及specialize在内部代数特化意义下PASS，非真实三重括号校正
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 20. MD-8.6.2-SINBracketRank

- source_id：MD-8.6.2-SINBracketRank；印刷页 366–368 / PDF页 387–389。
- 类别：域或覆盖说明
- 原文引文及公式（对应原页全文保存在原文JSON）：

> For θ>0, γ>0, on p²+ξ₁²/2=θ with ξ₁≠0 and outside M₀, the fields f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]] span the three-dimensional tangent space of the isokinetic cylinder.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：PDF387–389列出的五个场和M0吻合。原页先说明运动限制在ξ₁>0或ξ₁<0半空间；statement_latex应显式带上这一域，避免把“除M0外”误读为包含ξ₁=0的整个圆柱。
- 反例或理由：若删掉ξ₁≠0：取θ=γ=1、z=(0,1,0,0)，它在K=1且不在M0，但ξ₁=0是不变面，所有这些场的ξ₁分量为0，只能张成切空间的至多二维部分。此反例针对遗漏域的摘要，不针对现有Lean定理。
- 原文版 Lean 名称及状态：`MD.Ch08.sinBracket_tangentSpan`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：沿用原有明确资格的有效子结论；文字/证明修正说明见下，不构建大型理论。 例外直线外的有限括号张成目标；非完整遍历性定理。
- 待人工核查点：在statement_latex显式加入θ,γ>0、K=θ及ξ₁≠0；保留现有Lean全部前提，不将半柱结论扩大到ξ₁=0边界。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：PASS。sinBracket_tangentSpan假设θ>0、γ>0、K(z)=θ、ξ₁≠0及z∉M0。左侧是噪声g与j=0,1,2,3四个真实sinBracket值的实线性张成；右侧是实际K微分的核，即三维切空间。它没有使用Printed错式作定义。γ、θ正使σ非零，ξ₁≠0排除不受噪声横向驱动的边界；在p≠0时f的q分量与首括号的非零p分量提供两个独立投影，在p=0且不在M0时q≠0，f及真实三重括号提供两个独立投影，连同g张成三维。该签名正确；sorry不使签名FAIL。 sinBracket_tangentSpan：PASS，完整结论是子模等式，而非只给出向量数目或rank下界。 [EXTRA] 正参数和非零ξ₁已列在extra_assumptions；其作用须在摘要可见。 未声称已从括号条件推出密度光滑、可达性或遍历性。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：网站PASS（首轮声明未变）。

## 21. MD-8.6.2-SINLyapunov

- source_id：MD-8.6.2-SINLyapunov；印刷页 368–369 / PDF页 389–390。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> For φ=ξ₂²/2, L_isok φ=(ξ₁²-β⁻¹)ξ₂-γξ₂²+σ²/2, and the isokinetic constraint bounds ξ₁. The negative tail drift supports the ergodicity argument with further assumptions.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：PDF390生成元计算与statement_latex吻合；但原书随后给−γξ₂²+Kξ₂+σ²/2作为全局上界，未对ξ₂正负分情况。原文须保留并注明此上界疑误。仅在ξ₂方向的负漂移也不能单独推出非紧q方向的遍历性。；原文从局部负漂移到遍历性的论证需要额外全局条件；现有Lean没有此结论。；已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。
- 反例或理由：θ=γ=1、σ²/2=1、ξ₁=0、p=1、ξ₂=−R(R>0)：真实Lφ=−R²+R+1；取常见界常数K=1，原印右侧为−R²−R+1，不能作为上界。一般固定有符号K也无法同时覆盖系数ξ₁²−θ在[−θ,θ]的两个端点及ξ₂的两侧尾部。
- 原文版 Lean 名称及状态：`MD.Ch08.sinGenerator`：定义；`MD.Ch08.sinGenerator_lyapunov`：未证；`MD.Ch08.sinConstraint_bathBound`：已证；`MD.Ch08.sinLyapunovTailPrinted`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinLyapunovTail_corrected`：未证，传递依赖未证 局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。
- 待人工核查点：保留原页有符号式并标[ERRATUM?]；独立修正版可用Lφ≤−γξ₂²+θ|ξ₂|+γθ。遍历性需另核实配置紧性、可达性及Markov过程条件；当前Lean局部计算不需修改。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。additiveGenerator= Df(z)[b(z)]+D(Df(·)[B])(z)[B]/2；sinGenerator用单位热浴质量的sinDrift和第四坐标噪声B。sinGenerator_lyapunov对θ,γ>0、任意F和K(z)≠0断言L(ξ₂²/2)=(ξ₁²−θ)ξ₂−γξ₂²+γθ，正确；无需F可微，因为被求导的测试函数仅依赖ξ₂。sinConstraint_bathBound对任意θ和满足K=θ的z给ξ₁²≤2θ，正确。两个定理均未断言原印有符号尾界或遍历性。 sinGenerator、sinGenerator_lyapunov、sinConstraint_bathBound：PASS。 [EXTRA] hθ,hγ保证扩散平方为2γθ；hK排除物理奇点，未用它替代完整约束面结论。 原文正开集候选测度、周期边界及收缩性论证未被当作已形式化的遍历定理。
- 原文版分项：原送审局部生成元与约束界签名PASS；原页有符号尾项待导师
- 修正版分项：本轮新增绝对值尾界修正版待复审；依赖未证生成元恒等式
- 当前状态：待复审 / EAUDIT03。

## 22. MD-8.6.3-SINForceExactPrinted

- source_id：MD-8.6.3-SINForceExactPrinted；印刷页 372 / PDF页 393。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> ṗ=F−p²F/Λ, ξ̇₁=pξ₁F/Λ. The printed solution is p(h)=(p(0)+(F/m)s(h))/ṡ(h), ξ₁(h)=ξ₁(0)/ṡ(h), with s(t)=b⁻¹/²sinh(t√b)+(a/b)(cosh(t√b)−1), a=Fp(0)/Λ, b=F²/Λ.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。；[ERRATUM?] 保留Printed，给ξ₁负号版添加[ERRATUM?]；保留m=1的[EXTRA]，不要把工作修正版回填为原文。
- 反例或理由：取Q1=2、z=(0,1,1,0)、F=1，则Λ=2、s′(0)=1、s″(0)=1/2。候选ξ₁′(0)=−1/2，Printed场给+1/2；负号校正版给−1/2。
- 原文版 Lean 名称及状态：`MD.Ch08.sinForceAux`：定义；`MD.Ch08.sinForceFlow`：定义；`MD.Ch08.sinForceODEPrinted`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinForceODE_corrected`：定义；`MD.Ch08.sinForceFlow_solution_corrected`：未证 原印子场、显式候选与校正ODE的局部导数目标。
- 待人工核查点：保留Printed，给ξ₁负号版添加[ERRATUM?]；保留m=1的[EXTRA]，不要把工作修正版回填为原文。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。Printed正号ODE忠实于原页；sinForceAux在b≠0为所印双曲函数，b=0分支为解析延拓；sinForceFlow以m=1省去F/m，属于已披露[EXTRA]，不得称一般质量字面解。corrected定义为负号sinForceField。导数定理对任意Q1,F,z,t，在Q1>0、Λ(z)>0和s′(t)≠0下声明完整四维HasDerivAt，数学正确：校正场保持Λ，候选在0时返回z，其他q、ξ₂不动。没有全局流或误差阶结论。原印正号与显式候选冲突，须人工确认勘误。
- 原文版分项：Printed正号ODE忠实性PASS；与候选导数冲突
- 修正版分项：原送审负号_corrected及局部解签名PASS；限m=1与非零分母
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 23. MD-8.7-GeneralizedLangevin

- source_id：MD-8.7-GeneralizedLangevin；印刷页 374 / PDF页 395。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> dq=M⁻¹pdt, dp=−∇U(q)dt−∫₀ᵗΓ(t−s)p(s)ds dt+dB, q(0)=q₀,p(0)=p₀. Γ is the memory kernel and B is colored noise. (8.57)–(8.58).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：[ERRATUM?] 保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。；已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
- 反例或理由：平稳Gaussian OU过程具有指数时间相关，故有色噪声可以是Gaussian；有色性不蕴含非Gaussian。
- 原文版 Lean 名称及状态：`MD.Ch08.memoryDrag`：定义；`MD.Ch08.generalizedLangevin`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：有色噪声可以是Gaussian；有色性与非Gaussian性不互相蕴含。本条仅给定加性驱动的积分方程。 连续矩阵记忆核下的卷积及GLE积分解类定义。
- 待人工核查点：保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。memoryDrag对矩阵核Γ和动量p取负区间卷积；generalizedLangevin在任意概率空间Ω上，以正逆质量、C¹势、非负时间连续核及a.s.连续路径为[EXTRA]强解资格。对每个t≥0要求自然B历史可测性、漂移可积性和a.s.两条积分等式；t=0推出X0=x0，动量增量B(t)−B(0)正确，未将B当作Brownian。定义没有FD或有色性资格，也不要求非Gaussian，因而只应视为给定B的方程规格。原页将colored-noise与non-Gaussian并列，容易误导，原书疑误保留。
- 原文版分项：原送审给定B的积分方程规格可接受；有色/非Gaussian同义说法待导师
- 修正版分项：本轮文字修正：有色Gaussian可以存在；不新增分布或FD结论
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 24. MD-8.7-GLEFluctuationDissipationPrinted

- source_id：MD-8.7-GLEFluctuationDissipationPrinted；印刷页 374 / PDF页 395。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> ⟨Rᵢ(t+s)Rⱼ(t)⟩=k_BT γᵢⱼ(s)δᵢⱼ, s≥0. Γ(t)=γ(t)I in the scalar-kernel specialization. (8.59).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。；[ERRATUM?] 保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。
- 反例或理由：θ=1，Γ(s)=exp(−s)·[[1,1/2],[1/2,1]]可由相关平稳Gaussian OU实现；交叉协方差为exp(−s)/2，Printed的δ却强制为0。
- 原文版 Lean 名称及状态：`MD.Ch08.randomForceQualification`：定义；`MD.Ch08.gleFDPrinted`：定义；`MD.Ch08.scalarMemoryMatrix`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.gleFD_corrected`：定义 Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。
- 待人工核查点：保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。P、R、矩阵Γ及θ全称作为定义参数。randomForceQualification含概率性、所有t≥0各坐标L²及零均值。gleFDPrinted对所有t,s≥0及i,j使用if i=j then θΓij(s) else 0，忠实编码原印δij；gleFD_corrected去掉δ，作为单位质量一般矩阵协方差目标合理，但不声称任意Γ存在实现。scalarMemoryMatrix为γ(t)I，因此两版本在标量核特化相同。θ>0及零均值、L²均为明确资格，不是原文额外定理。
- 原文版分项：Printed的δ忠实于原页；一般矩阵解释有疑
- 修正版分项：原送审去δ的矩阵协方差目标PASS；可实现性另需正定资格
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 25. MD-8.7.1-PronyOUStationarity

- source_id：MD-8.7.1-PronyOUStationarity；印刷页 376 / PDF页 397。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> dRᵢₖ=−Rᵢₖdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ; E Rᵢₖ=0 and E[Rᵢₖ(t+s)Rᵢₖ(t)]=(k_BT cₖ/τₖ)e^(−s/τₖ). Rᵢ=ΣₖRᵢₖ. (8.65)–(8.67).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：[ERRATUM?] 保留原印相关式并加[ERRATUM?]，明确它在平稳初态下成立；保留已写入Lean的Gaussian初态及独立性。；[ERRATUM?] 原页(8.66)省略平稳初态；Lean补入的初始Gaussian律及其与W独立是必要资格。；已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。
- 反例或理由：令c=τ=θ=1、R0=0，则在t=s=0时E[R0²]=0，所印(8.66)右端为1。一般确定零初态协方差为θc/τ·exp(−s/τ)(1−exp(−2t/τ))。
- 原文版 Lean 名称及状态：`MD.Ch08.stationaryPronyOU`：定义；`MD.Ch08.pronyOU_covariance`：未证；`MD.Ch08.totalPronyRandomForce`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.pronyOU_covariance_corrected`：未证，传递依赖未证 单个Prony OU的完整资格及平稳均值/协方差目标、总随机力定义。
- 待人工核查点：保留原印相关式并加[ERRATUM?]，明确它在平稳初态下成立；保留已写入Lean的Gaussian初态及独立性。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。stationaryPronyOU明确含概率及标准Wiener资格、cτθ>0、R0~N(0,θc/τ)、R0与整条W独立、非负时间a.s.连续及各时刻L²，并以积分方程表示噪声系数sqrt(2θc)/τ。covariance在这些假设及t,s≥0下给出零均值和θc/τ·exp(−s/τ)，正确。totalPronyRandomForce只定义有限和，不证明跨模式独立或总协方差。原页未写平稳初态，原印无条件均值与相关性断言需人工确认；所加初态属于必要[EXTRA]，不是照录原文前提。
- 原文版分项：原印无初态的相关式待导师；原送审已补平稳初态的签名PASS
- 修正版分项：本轮增加同一有效结论的_corrected独立名称，待复审；非总随机力协方差
- 当前状态：待复审 / EAUDIT03。

## 26. MD-8.8-AndersenHamiltonianPrinted

- source_id：MD-8.8-AndersenHamiltonianPrinted；印刷页 380 / PDF页 401。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> Ĥ=Σᵢ|p̄ᵢ|²/(2mᵢV^{2/3})+Ū(q̄;V)+p_V²/(2μ_V)+PV, and ρ_NPT=√(β/(2πμ_V))∫exp(−βĤ)dp_V. (8.73).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。；[ERRATUM?] 保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意Z>0。
- 反例或理由：固定其余状态基础能量A时，Printed积分严格等于exp(−βA)。例如A=0时为1，而取正配分常数Z=2的归一权应为1/2；两者相差Z因子。
- 原文版 Lean 名称及状态：`MD.Ch08.andersenHamiltonian`：定义；`MD.Ch08.andersenMarginalPrinted`：定义；`MD.Ch08.andersenGaussian_marginal`：未证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.andersenMarginal_corrected`：定义 活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。
- 待人工核查点：保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意Z>0。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。Hamiltonian对象z=((qbar,pbar),V),pV的嵌套投影正确，包含Σpbar_i²/(2m_i V^(2/3))、U(V^(1/3)qbar)、pV²/(2QV)、PV。Printed定义忠实于原印平方根系数及实pV的Lebesgue积分。Gaussian_marginal在QV,β,V>0下给未归一权重，点态积分消元正确；m正性并非该高斯消元恒等式必要条件。corrected除以独立参数Z，作为权重公式合理，但定义无Z>0或Z等于配分积分条件，不能单凭名称称归一概率。原印把该未归一权重称ρ_NPT，与前页Z_NPT⁻¹相差因子，保留并交人工确认。
- 原文版分项：Printed忠实性PASS；相对归一NPT密度缺配分因子
- 修正版分项：原送审Gaussian消元及除Z权重合理；正有限配分积分未保证，不宣称概率归一
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 27. MD-8.8.1-PistonHamiltonianSubfield

- source_id：MD-8.8.1-PistonHamiltonianSubfield；印刷页 381 / PDF页 402。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> ρ₁=φ₁(pᵀM⁻¹p/2+U(q))ψ(V,ξ,η) is stationary for the Hamiltonian part.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：保留原页文字；在issues显式标[ERRATUM?]：原印p应为M⁻¹p（或注明单位质量约定）。给现有Hamiltonian子场标为合理修正，不将其与原印向量场混同。；已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。
- 反例或理由：取n=1、invm=2、U(q,V)=q²/2、φ(s)=s、ψ=1。原印子场(p,−q)下div(ρF)=−pq，在p=q=1为−1；Lean修正子场(2p,−q)下为0。
- 原文版 Lean 名称及状态：`MD.Ch08.pistonHamiltonianPart`：定义；`MD.Ch08.pistonHamiltonianWeight_stationary`：未证；`MD.Ch08.pistonHamiltonianPartPrinted`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.pistonHamiltonianPart_corrected`：定义 原印p子场、M⁻¹p修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。
- 待人工核查点：保留原页文字；在issues显式标[ERRATUM?]：原印p应为M⁻¹p（或注明单位质量约定）。给现有Hamiltonian子场标为合理修正，不将其与原印向量场混同。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。pistonHamiltonianPart实际使用(M⁻¹p,−∇qU,0)，权重使用K/2+U及任意C¹冻结变量乘子；U为C²、φ与ψ为C¹，结论为任意z处真实通量散度为零，对任意逆质量参数该恒等式成立，无需概率资格。但是原页在文字中把向量场印为(p,−∇U,0,0,0)，不是Lean中的M⁻¹p。原JSON只称Hamiltonian part，未揭示这个原印与合理修正的差别，不能将修正默认为逐字忠实。
- 原文版分项：原书印为p，旧Lean采用M⁻¹p的合理修正，不能混称忠实
- 修正版分项：旧修正场及其局部驻定数学签名获认可；本轮新增Printed/修正版名称待复审
- 当前状态：待复审 / EAUDIT04。

## 28. MD-8.8.1-PistonThermostatWeightPrinted

- source_id：MD-8.8.1-PistonThermostatWeightPrinted；印刷页 381 / PDF页 402。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> The book prints ρ₂=exp(−β[pᵀM⁻¹p+μ_Tξ²/2])ψ₂(q,η,V) for ṗ=−ξp, ξ̇=(pᵀM⁻¹p−N_dk_BT)/μ_T.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。；保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。
- 反例或理由：取n=1、invm=β=QT=1、p=ξ=1、ψ₂=1。原印ρ=exp(−p²−ξ²/2)，div(ρF)=ρ≠0；一般残差是βξKρ。修正ρ=exp(−(p²+ξ²)/2)的散度为0。
- 原文版 Lean 名称及状态：`MD.Ch08.pistonThermostatPart`：定义；`MD.Ch08.pistonRho2Printed`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.pistonRho2_corrected`：定义；`MD.Ch08.pistonRho2_stationary_corrected`：未证 原印/修正权重及ψ₂=1时的实际子场驻定目标。
- 待人工核查点：保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。pistonThermostatPart在p上为−ξp、ξ上为(K−nθ)/QT，其他坐标冻结。pistonRho2Printed忠实保留原页动能项缺少1/2；pistonRho2_corrected恢复K/2。stationary_corrected量化所有正逆质量、β、QT和任意z，并把θ设为β⁻¹，结论div(ρF)=0正确。ψ₂=1的覆盖缩减在extra_assumptions已明示，不要求补任意冻结乘子或归一性。原印驻定断言数学错误仍须人工确认勘误；Printed定义自身忠实，修正版签名正确。
- 原文版分项：Printed忠实性PASS；原印动能缺1/2
- 修正版分项：原送审恢复1/2的_corrected及局部驻定签名PASS，ψ₂=1
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 29. MD-8.9.1-DPDMassOrderPrinted

- source_id：MD-8.9.1-DPDMassOrderPrinted；印刷页 389 / PDF页 410。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> For dp=−∇Udt−Δ(q)pdt+Σ(q)dW, the book gives Δ=M⁻¹ΣΣᵀ/(2k_BT).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。；保留Printed等式；[ERRATUM?]记录一般质量情形改为ΣΣᵀM⁻¹/(2kBT)，标注等质量或交换条件下两者相同。
- 反例或理由：M⁻¹=diag(1,1/2)，C=BBᵀ=[[1,−1],[−1,1]]（B=(1,−1)ᵀ）。M⁻¹C=[[1,−1],[−1/2,1/2]]，CM⁻¹=[[1,−1/2],[−1,1/2]]。原印Γ使ΓM+MΓᵀ的非对角元为−5/(4θ)，而C/θ为−1/θ，故不满足所需动量协方差θM的OU平衡。
- 原文版 Lean 名称及状态：`MD.Ch08.dpdMatrixFDPrinted`：定义；`MD.Ch08.dpdMassOrder_counterexample`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.dpdMatrixFD_corrected`：定义 原印/校正的质量矩阵次序及具体代数反例。
- 待人工核查点：保留Printed等式；[ERRATUM?]记录一般质量情形改为ΣΣᵀM⁻¹/(2kBT)，标注等质量或交换条件下两者相同。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。dpdMatrixFDPrinted保留原印左乘M⁻¹，dpdMatrixFD_corrected将其放在右侧；两者只定义矩阵等式，无正定性或θ>0前提并不使定义失真，物理解释须使用标出的资格。dpdMassOrder_counterexample量化的是两个明确2×2矩阵的不交换性，(0,1)元已足以区分。对于成对DPD的对称阻尼核A=BBᵀ/(2θ)，作用于速度M⁻¹p的耗散给Γ=AM⁻¹，修正合理。原印关系对一般不等质量不成立，需保留并人工确认；此处没有声称该右乘关系是所有可能非对称OU阻尼的唯一驻定条件。
- 原文版分项：Printed忠实性PASS；一般不等质量的乘法次序错误
- 修正版分项：原送审右乘M⁻¹修正版与不交换反例PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 30. MD-8.9.2-DPDPairGeneratorPrinted

- source_id：MD-8.9.2-DPDPairGeneratorPrinted；印刷页 392 / PDF页 413。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> (8.100) prints L_Oij=[−γωᴰu+(σ²/2)(ωᴿ)² e·(∂pi−∂pj)] e·∂pi for each unordered pair i<j.

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。
- 反例或理由：符号反例：N=2,d=1,i=0,j=1,e=1，m_i=m_j=1，γ=wd=1，p_i=1,p_j=0；取 f(p)=p_i+p_j。原印算子作用于 f 得 −1（二阶项为0），修正版得0。固定总动量叶上的单对动力学必须湮灭总动量函数，故原印单对解释有误；这不否定有序双和(8.97)。
- 原文版 Lean 名称及状态：`MD.Ch08.pairDerivative`：定义；`MD.Ch08.dpdPairGeneratorPrinted`：定义。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.dpdPairGenerator_corrected`：定义 冻结配置下单对动量生成元的原式和守恒方向修正版。
- 待人工核查点：保留原文和 Printed 定义；显式标 [ERRATUM?] 指向最外层 ∂pi，另列 corrected 使用 D_ij= e·(∂pi−∂pj)。不得把 Printed 定义改成修正版后仍称逐字忠实。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。分别审校：pairDerivative 是沿 e 在 i 增、j 减的方向导数。dpdPairGeneratorPrinted 的漂移只沿 Pi.single i e，扩散为 (σ²wr²/2)D_ij∂i，忠实保留(8.100)的最外层 ∂pi；该原文版忠实性 PASS。dpdPairGenerator_corrected 将漂移和扩散的最外层都换为 D_ij，得到 −γwd u D_ij+(σ²wr²/2)D_ij²，符合独立单对守恒 SDE，修正版数学陈述 PASS。i,j、e及实参数在两定义中均无物理资格限制；单对物理解释须 i≠j、单位方向、正质量及涨落耗散条件，定义本身并未声称不变分布。原书紧随其后的单对保动量叶不变密度说法与原印算子冲突，需保留原式并人工确认勘误；不能因忠实原式存在疑误而判该 Printed 定义 FAIL。
- 原文版分项：Printed忠实性PASS；单对解释下最外层∂pi不保总动量
- 修正版分项：原送审改用Dij的_corrected签名PASS；不据此否定完整有序双和
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 31. MD-8.9.2-DPDPairOUUpdate

- source_id：MD-8.9.2-DPDPairOUUpdate；印刷页 393 / PDF页 414。
- 类别：原书疑误或证明核查
- 原文引文及公式（对应原页全文保存在原文JSON）：

> mred=mi mj/(mi+mj); mred du=Fdt−γωᴰu dt+σωᴿdW. a=γωᴰ/mred. u(t)=F/(a mred)+exp(−at)(u0−F/(a mred))+√[θ(1−exp(−2at))/mred]R. Δu=u(t)−u0; pi+=mred Δu e, pj−=mred Δu e. (8.103)–(8.107).

- 原页核对：已目视核对原页；页映射和图像哈希见closeout31/PDF_VISUAL_CHECKS.json。
- 问题所在：已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。
- 反例或理由：边界示例（不是正率域反例）：mr=F=θ=t=1，a=u=R=0。通常实数原式含 1/0 未定义；Lean 总化除法使 dpdPairOUPrinted 得0，而零率强迫 ODE 的终值及 corrected 值均为1。物理截断外若同时 F=0 则此强迫示例不适用，但原式零分母仍须分支约定。
- 原文版 Lean 名称及状态：`MD.Ch08.reducedMass8`：定义；`MD.Ch08.reducedMass8_pos`：已证；`MD.Ch08.dpdPairOUPrinted`：定义；`MD.Ch08.dpdPairOU_zeroRate`：已证；`MD.Ch08.dpdPairMomentumStep`：定义；`MD.Ch08.dpdPairMomentumStep_conserves`：已证。错误字面命题不证明。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.dpdPairOU_corrected`：定义 原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。
- 待人工核查点：保留 Printed，标 [ERRATUM?]/域限制 a>0；a=0 的适用场景使用已给 corrected，并明确 FDT 下噪声同时退化，不能把该分支用于任意独立的非零扩散零漂移 OU。
- 导师选项：默认保留原印供比对，采用独立修正版或明确限定解释；请导师确认作者是否另有隐含约定。
- 网站首轮结论：NEEDS_HUMAN。分别审校 reducedMass8、其正性定理、dpdPairOUPrinted、dpdPairOU_corrected、零率定理、dpdPairMomentumStep 及其守恒定理。约化质量 mi*mj/(mi+mj) 及正质量前提正确；Printed 完全忠实(8.104)。a≠0 时修正版将确定性项改写为 exp(−at)u+(F/mr)(1−exp(−at))/a，与原式相同；a=0 分支为 u+(F/mr)t，噪声根号退化为零，符合涨落耗散关联下的连续零率延拓。动量更新为 ±mr*du*e，总动量等式对任意 i,j,e,mr,du,p 都成立；不需要单位方向或质量正性。要解释为相对速度精确流还需不同粒子、单位方向及正质量；物理 OU 转移还需 mr,θ>0、a,t≥0 和独立标准正态 R。原印公式在零率没有通常实数意义，而本条已正确另设修正版；原书边界域约定应人工确认，Printed 忠实性和 corrected 数学正确性均 PASS。
- 原文版分项：Printed忠实性PASS；零率原式通常未定义
- 修正版分项：原送审正率改写与FDT噪声同时退化的零率_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项见下。

## 覆盖缺口

- MD-8.1.2.1-NPEquations：NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。
- MD-8.1.2.1-NPShadowDensity：三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。；[EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。
- MD-8.2-GeneralThermostat：常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。
- MD-8.2.1-Examples81and82：原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。
- MD-8.2.1-Proposition81：两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。；两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。
- MD-8.2.2-NHChains：任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。；链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
- MD-8.3-ArrheniusRate：Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。；A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。
- MD-8.4-AdditiveThermostatSDE：[EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。；完整两组SDE需要一个统一的n+k维独立Wiener向量、分块噪声因子、对应漂移及两组协方差约束；本条尚无这项组装声明。
- MD-8.4-Proposition82：所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。；Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- MD-8.4.1-NHL：仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。；[EXTRA]M⁻¹=diag(invm)，N_d=n；一般非对角M未覆盖。harmonicPotential本身未要求A对称正定，相关物理资格在应用时另加。
- MD-8.4.1-Theorem81：所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。
- MD-8.4.2-NHLTimestep：实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。
- MD-8.4.1-NHLWeakStationary：归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。
- MD-8.4.3-PreEquilibriumMeans：任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。；[EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。
- MD-8.4.4-RescalingStationary：闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。；二阶项冻结噪声方向，正确表示Itô Hessian；完整随机解、奇异边界与半群不变性未覆盖。
- MD-8.4.5-ThermostatEfficiency：效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的O(N)含义；外引估计定理未证，经验曲线排除。
- MD-8.5-SLSHormander：单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。
- MD-8.5-SLSLeapfrog：原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。；原文η约化方程漏μ⁻¹，算法保留Q⁻¹；本条覆盖原页算法及逐坐标场，不声称二阶不变分布误差或精确求积实现。
- MD-8.6-IsokineticProjector：实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。
- MD-8.6-IsokineticGibbsShell：动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。
- MD-8.6.1-SINWeightPrinted：原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。
- MD-8.6.2-SINHarmonic：谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。
- MD-8.6.2-SINProjectedBracketsPrinted：本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
- MD-8.6.2-SINThirdBracketPrinted：ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
- MD-8.6.2-SINBracketRank：θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
- MD-8.6.2-SINLyapunov：局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。；已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。
- MD-8.6.3-SINForceSplitting：五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。
- MD-8.6.3-SINRAlgorithm：原印算法的阶段顺序与步长；不声称构造了各非线性子流。
- MD-8.7-GLEFluctuationDissipationPrinted：Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。；修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- MD-8.7-PronyKernel：正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。；正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。
- MD-8.7.1-PronyOUStationarity：已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。
- MD-8.7.1-GeneralizedLangevinIntegrator：此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。
- MD-8.8-AndersenCoordinates：V>0用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。
- MD-8.8-AndersenHamiltonianPrinted：[EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。
- MD-8.8.1-PistonReducedPDE：只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。
- MD-8.9.1-DPDIntegralSystem：选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。
- MD-8.9.1-DPDMassOrderPrinted：M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- MD-8.9.2-DPDVelocityVerlet：尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。
- MD-8.9.2-DPDSplitGenerator：采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。
- MD-8.9.2-DPDPairGeneratorPrinted：本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
- MD-8.9.2-DPDPairOUUpdate：单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。
- MD-8.9.4-PairwiseNHLSDE：未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。
- MD-8.10-BerendsenRelaxation：只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。
