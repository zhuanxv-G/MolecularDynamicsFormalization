# 第8章原书疑误与双版本审阅单

教材：Leimkuhler–Matthews《Molecular Dynamics》（2015），第8章正文印刷329–399页/PDF350–420页，止于Exercises之前。
按条目计：27项原书表述疑误、1项原证明核查、3项域/覆盖说明，共31项记录；相同原书矛盾涉及不同条目时分列，不等于31个独立排印错误。导师尚未最终裁定。
复审10条：2 PASS / 0 FAIL / 8 NEEDS_HUMAN；8条按修正版/限定声明认可与原印疑误分流。NP四分量的n版解释获认可，但npField逐声明仍保留指代NEEDS_HUMAN。
32号实读8个关键原页图像，详见closeout32/PDF_VISUAL_CHECKS.json；其余公式页保留31号已核对证据，不冒称本轮重看。

## 1. MD-8.1.1-NHFirstIntegralPrinted

- source_id：MD-8.1.1-NHFirstIntegralPrinted；印刷页 333 / PDF页 354。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> ds/dt=ξ. I_NH=H+μξ²/2+N_dβ⁻¹ ln s is conserved.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页354。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。
- 反例或理由：局部诊断：n=β=Q=invm₀=1，U=0，在p=1、ξ=1、s=2时原印导数I′=−1/2。亦可满足全实时间前提：取p′=−ξp、ξ′=p²−1在p>0上的非平凡周期轨道（第一积分p²/2−log p+ξ²/2），令s=C−log p，C足够大使s>0，q′=p。此时s′=ξ且I′并非恒零。
- 原文版 Lean 名称及状态：`MD.Ch08.nhIntegral`：定义；`MD.Ch08.nhIntegralPrinted`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.nhIntegral_corrected`：未证
- 修正或补充前提：s>0；原文版不证明，修正版另列；两版均保留原文H形式。
- 待人工核查点：[ERRATUM?] 保留Printed字面版并禁止将其视为已成立定理；推荐s′=sξ。另一种改法是保留s′=ξ而将(n/β)log s改成(n/β)s。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：原印忠实性PASS；s′=ξ与log s守恒不相容，数学真值待导师
- 修正版分项：原送审s′=sξ的_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 2. MD-8.1.2.1-NoseHamiltoniansPrinted

- source_id：MD-8.1.2.1-NoseHamiltoniansPrinted；印刷页 334 / PDF页 355。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> H_N= p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+(N_d+1)k_BT ln s; H_NP=s[H_N-E_N]=s[p̃ᵀM⁻¹p̃/(2s²)+π²/(2μ)+U(q)+N_d k_BT ln s-E_N].

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页355。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。
- 反例或理由：n=1，invm₀=β=Q=1，U=0，q=p=0，π=EN=0，s=exp(1)>0：npHamiltonian=exp(1)，s*(noseHamiltonian−EN)=2 exp(1)。一般左右之差为−s log(s)/β。
- 原文版 Lean 名称及状态：`MD.Ch08.noseHamiltonian`：定义；`MD.Ch08.npHamiltonian`：定义；`MD.Ch08.nosePoincarePrinted`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.nosePoincare_corrected`：已证
- 修正或补充前提：物理定义域s>0、β,Q及质量正；总函数在此域外不作物理解释。
- 待人工核查点：[ERRATUM?] 保留Printed原文；修正版减去log s/β合理。若要坚持H_NP=s(H_N−E_N)，须另定义对数系数为n/β的H_N，不能与先前(n+1)/β版本混称。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：两个原印H_N的对数系数不一致；Printed忠实性PASS
- 修正版分项：原送审显式减log s/β的代数修正版PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 3. MD-8.1.2.1-NPEquations

- source_id：MD-8.1.2.1-NPEquations；印刷页 334 / PDF页 355。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> q̇=M⁻¹p̃/s, p̃̇=sF, ṡ=sp_s/μ, ṗ_s=p̃ᵀM⁻¹p̃/s²-N_d k_BT-ΔH_N.

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页355。
- 问题所在：[ERRATUM?] 原页H_N在(N_d+1)与N_d系数之间不一致，须人工确认；修正版按(8.9)展开选择n版。；已目视核对原页PDF355：上方H_N用(n+1)/β，(8.9)展开用n/β，末行ΔH_N仍引用同名H_N；指代矛盾未消除。n版仅为依(8.9)展开采用的修正选择。
- 反例或理由：非数值反例而是两种原印解释之差：H_N^(n+1)−H_N^(n)=β⁻¹log s。若初始常量各自匹配，则两版ΔH之差为β⁻¹log(s/s₀)，通常不为零；不能仅凭末行H_N符号断言是n版。
- 原文版 Lean 名称及状态：`MD.Ch08.npValidDomain`：定义；`MD.Ch08.npField`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.npDeltaN_corrected`：定义
- 修正或补充前提：[EXTRA] M⁻¹=diag(invm)，N_d=n，β⁻¹=k_BT，Q=μ，状态z=((q,p̃),(s,p_s))。；[EXTRA] npValidDomain单列所有invm_i>0及β,Q,s>0；npField自身为总函数，未把该资格作为参数或合取条件。；[ERRATUM?] npDeltaN_corrected选择(8.9)展开中的n/β版本；与上方原印(n+1)/β版H_N区分。应用时EN应取该n版能量在初值处的值；声明并未绑定初值。；gradient用fderiv定义，未假设U可微；欲解释为经典力场须另加适当可微性。未证明Hamilton方程。；[EXTRA] 使用npField作为经典NP方程必须另带npValidDomain invm β Q z、U可微及EN=H_N^(n)(z₀)；这些条件没有被npField总函数自动强制。原页ΔH_N指代冲突未消除。
- 待人工核查点：保留原印全部文字；明确n版为修正选择；应用npField时另具npValidDomain、U可微及EN=H_N^(n)(z₀)。不要将原页指代冲突写为已目视排除。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：NEEDS_HUMAN。逐一展开Vec=Fin n→ℝ、Phase=Vec n×Vec n、gradient与kineticTwice。npDeltaN_corrected依次为p̃ᵀdiag(invm)p̃/(2s²)、p_s²/(2Q)、U(q)、(n/β)log s及−EN，修正选择合理。npValidDomain全部四组正性条件完整。npField返回((q̇,p̃̇),(ṡ,ṗ_s))，四分量与(8.10)–(8.13)在所列字典及n版delta下相符；符号、分母和括号正确。定义总域允许β,Q,s=0，不能自动声称有效物理域。原页delta指代矛盾未消除，故总体NEEDS_HUMAN，并非由sorry或缺少Hamilton证明判FAIL。
- 原文版分项：原印ΔH_N指代冲突未消除，待导师
- 修正版分项：npDeltaN_corrected及npValidDomain网站PASS；npField在n版修正解释下分量正确，但网站逐声明仍保留NEEDS_HUMAN的指代限定
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 4. MD-8.2.1-Examples81and82

- source_id：MD-8.2.1-Examples81and82；印刷页 337–338 / PDF页 358–359。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> Example 8.1 Φ=-ξ(0,p), g=μ⁻¹(p·∇pH-N_d k_BT). Example 8.2 Φ=ξG(z), g=μ⁻¹[∇H-k_BT∇]·G. Configurational choice G=(∇qK,0).

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页358–359。
- 问题所在：[ERRATUM?] 原印例8.2的Φ=+ξG与正反馈一般不保持所列高斯Gibbs密度；Printed忠实保留该声称。负号耦合corrected为合理修正。；已目视核对原页PDF358：例8.2印为Φ=+ξG及正反馈；Printed仅保留原印疑误，不得被其他条目作为有效数学定理依赖；corrected采用−ξG。
- 反例或理由：Printed数学声称的精确反例：n=1，J=0，H(x)=x²/2，G(x)=1，β=Q=1，均满足全部光滑性、正性和反对称前提。F(x,ξ)=(ξ,x)，ρ=exp(−(x²+ξ²)/2)，div(ρF)=−2xξρ；在(1,1)为−2exp(−1)≠0。此反例不改变Printed的字面忠实性PASS。
- 原文版 Lean 名称及状态：`MD.Ch08.generalizedFeedback`：定义；`MD.Ch08.configurationalFeedback`：定义；`MD.Ch08.generalizedFeedback_stationaryPrinted`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.generalizedFeedback_stationary_corrected`：未证
- 修正或补充前提：β⁻¹=k_BT，Q=μ；一般G定义中的n是相空间维数，不能将此处n一律解释为物理自由度数。；generalizedFeedback和configurationalFeedback为原式总函数；经典导数解释需相应可微性。；[EXTRA] 两个驻定定理假设常矩阵J反对称、H为C³、G为C²、β,Q>0，结论为所有点的div(ρF)=0；不是全局流不变概率测度或遍历性。；Example8.1的物理系统、构型完整场及其独立驻定定理未在本条四声明中单列。；[ERRATUM?] Printed仅供原文忠实记录，不作为任何其他条目的有效定理依赖；实际局部驻定采用负号耦合_corrected。
- 待人工核查点：保留Printed及原文，标注原书疑误并避免将其作为有效数学定理依赖；corrected可保留。另一等价修法是在保留+ξG时将反馈整体反号。构型反馈亦须与耦合符号配套。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：FAIL
- 网站复审结论：NEEDS_HUMAN。generalizedFeedback为(DH[G]−div G/β)/Q，与原印括号算子完全相符；configurationalFeedback为(∇U·∇K−ΔK/β)/Q，亦忠实。两个定理所有参数和前提相同：任意n、常反对称J、C³实函数H、C²向量场G、正β,Q，密度ρ=exp(−β(H+Qξ²/2))，完整结论为∀(z,ξ),div(ρF)=0。Printed取+ξG，与原印隐含驻定声称忠实，按任务判字面PASS，但数学内容有原书符号疑误。corrected仅取−ξG，成立：Hamilton项加权散度为零，−ξG项贡献ρξ(βDH[G]−div G)，ξ方向贡献其负值，逐点相消。无须归一化或增长条件即可作此局部结论；也未据此声称全局采样。
- 原文版分项：Printed字面忠实性PASS；+ξG驻定声称为原书符号疑误，禁止作为有效定理依赖
- 修正版分项：−ξG的_corrected局部驻定签名网站PASS
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 5. MD-8.4-AdditiveThermostatSDE

- source_id：MD-8.4-AdditiveThermostatSDE；印刷页 342–343 / PDF页 363–364。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> dq=M⁻¹pdt; dp=-∇Udt-Φ(ξ,z)-Γpdt+√(2k_BT)M^{1/2}Γ^{1/2}dW; dξ=gdt-Γ̂ξdt+√(2k_BT)M̂^{1/2}Γ̂^{1/2}dŴ. All Wiener coordinates are independent.

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页363–364。
- 问题所在：[ERRATUM?] 原印(8.23)的−Φ缺dt。；[ERRATUM?] 原印矩阵对称性不足以保证实噪声及Gibbs相容；当前Lean是半正定、交换资格下的限制模型。；已目视核对原页PDF364：(8.23)的−Φ缺dt；矩阵仅对称不足以保证所印噪声与目标Gibbs协方差相容。当前模型已组装，是对角物理质量、交换涨落耗散特例。
- 反例或理由：原书矩阵条件不足的精确例：β=1，M=diag(1,4)，Γ=[[2,1],[1,2]]，二者均对称正定。原印B=√2 M^{1/2}Γ^{1/2}给BBᵀ=2M^{1/2}ΓM^{1/2}=[[4,4],[4,16]]，而目标协方差M要求ΓM+MΓ=[[4,5],[5,16]]，两者不等。这里未用数值近似或计算软件；直接矩阵乘法。现有Lean资格会排除此非交换例，不能把它当成Lean资格的反例。
- 原文版 Lean 名称及状态：`MD.Ch08.independentWiener`：定义；`MD.Ch08.additiveSDE`：定义；`MD.Ch08.stochasticThermostatDrift`：定义；`MD.Ch08.fluctuationDissipation`：定义；`MD.Ch08.thermostatBlockNoise`：定义；`MD.Ch08.stochasticThermostatSolution`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：已组装的对角物理质量、交换涨落耗散特例：同一n+k维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。
- 修正或补充前提：[EXTRA] M⁻¹=diag(invm)，所有invm_i>0，N_c=N_d=n；U为C¹。β⁻¹=k_BT。；[EXTRA] stochasticThermostatSolution已用同一n+k维独立Wiener过程、thermostatBlockNoise和实际漂移组装完整积分解规格。物理质量明确绑定diag(invm⁻¹)，热浴质量为Mhat，两组使用同β。；[EXTRA] fluctuationDissipation要求β>0、M正定、Γ半正定及BBᵀ=(2/β)ΓM。实对称矩阵下由左右对称性强制ΓM=MΓ，属于明确限制后的充分相容条件。热浴同理。；[ERRATUM?] 原印−Φ未附dt；漂移按−Φdt解释。原印对称性条件不足以保证矩阵平方根噪声的Gibbs相容性。；未要求或证明确定性Φ,g部分保权；未构造矩阵平方根，未证明完整解存在、唯一、不变分布或遍历性。；[EXTRA] additiveSDE要求几乎处处全实时间连续；每个t≥0的X t对W在[0,t]历史可测，漂移在[0,t]几乎处处可积，且逐个t的积分方程几乎处处成立；x0固定而非随机。；[EXTRA] 对一般矩阵的匹配应为BBᵀ=(ΓM+MΓᵀ)/β并须协方差可实现；当前采用BBᵀ=(2/β)ΓM，在实对称条件下限制为ΓM=MΓ的充分特例，不扩充Lean模型。
- 待人工核查点：更新过时JSON备注；保留原印并标缺dt及矩阵相容疑误。将Lean描述为已组装的对角物理质量、交换涨落耗散特例。若以后扩展一般OU资格，可采用BBᵀ=(ΓM+MΓᵀ)/β并要求可实现的半正定协方差；本次不修改Lean。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：FAIL
- 网站复审结论：NEEDS_HUMAN。independentWiener对每个Fin k坐标要求IsBrownianReal，并对整个路径随机变量iIndepFun，P为概率测度，故跨组独立性由统一n+k坐标给出。additiveSDE的对象E、固定x0、常因子B、几乎处处连续、自然噪声历史可测、t≥0逐时可积及积分恒等式全部明确；不是存在性定理。stochasticThermostatDrift在(q,p,ξ)上恰为(diag(invm)p,−∇U−Φ−Γp,g−Γhatξ)，把原书缺失dt解释为漂移。thermostatBlockNoise前n列只作用p，后k列只作用ξ，q噪声为零。stochasticThermostatSolution已将该漂移、分块噪声、同一个独立W、同β两组资格及实际对角物理质量绑定，旧未组装/未绑定指控不成立。fluctuationDissipation为充分但较强的交换情形，不能冒充原印仅对称的一般模型。没有确定性保权前提，因而不能从该解谓词推出Gibbs不变性；声明本身未作此结论，故不是签名错误。原书dt和矩阵条件疑误总体保留NEEDS_HUMAN。
- 原文版分项：原印缺dt及矩阵噪声相容疑误待导师
- 修正版分项：已组装的对角物理质量、交换涨落耗散特例网站PASS；不代表一般矩阵模型
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 6. MD-8.4-OUStationarityPrinted

- source_id：MD-8.4-OUStationarityPrinted；印刷页 343–344 / PDF页 364–365。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> The OU momentum process with drift -Γp and noise √(2k_BT) M^{1/2}Γ^{1/2} preserves exp(-βpᵀM⁻¹p/2). The displayed diffusion term is β⁻¹Tr(Γ^{1/2}M^{1/2}[βM⁻¹ppᵀM⁻¹-M⁻¹]M^{1/2}Γ^{1/2})ρ̄=-drift.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页364–365。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。；[ERRATUM?]保留原所印等式及β=2反例；修正版的BBᵀ=(2/β)ΓM为明确额外资格，在对称情形蕴含交换性。
- 反例或理由：原印式取β=2、M=Γ=1、p=0，ρ=1，drift=1，而所印diffusion=-1/2，故diffusion≠-drift。另取M=diag(1,4)、Γ=[[1,1/2],[1/2,1]]、β=1；两者正定，原噪声给BBᵀ=2M^{1/2}ΓM^{1/2}=[[2,2],[2,8]]，所需ΓM+MΓ=[[2,5/2],[5/2,8]]，不相等。
- 原文版 Lean 名称及状态：`MD.Ch08.ouFokkerPlanck`：定义；`MD.Ch08.diffusionPrinted`：未证；`MD.Ch08.diffusionPrinted_counterexample`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.ouStationarity_corrected`：未证
- 修正或补充前提：Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。
- 待人工核查点：原文与diffusionPrinted保留并加[ERRATUM?]；正确扩散表达式在提出Hessian中的β后去掉外部β⁻¹，或保留外部β⁻¹并在方括号恢复β²和β。矩阵结论明确补交换/协方差条件；修正版与反例继续分别陈列。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：diffusionPrinted忠实性PASS；原印β因子和矩阵相容性待导师
- 修正版分项：原送审ouStationarity_corrected及标量反例PASS；仅局部算子恒零
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 7. MD-8.4-Proposition82

- source_id：MD-8.4-Proposition82；印刷页 344–345 / PDF页 365–366。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> If the Lie algebra generated by F and G in (8.25) spans R^m, then the Hörmander condition holds for (8.25)–(8.26).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页365–366。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。；[ERRATUM?]σ=0反例；Printed仅作忠实记录，corrected在σ≠0下通过。
- 反例或理由：n=1，F(z)=1，G(z)=0，g(z)=0，γ=σ=0。原物理Lie点值张成ℝ，但提升种子只有常场(1,0)及零场，所有括号为零，任一点张成维数1<2。
- 原文版 Lean 名称及状态：`MD.Ch08.proposition82Printed`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.proposition82_corrected`：已证
- 修正或补充前提：Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- 待人工核查点：保留proposition82Printed并注明[ERRATUM?]；使用proposition82_corrected作为有效结论，明确[EXTRA]C∞与σ≠0，并说明这里的Hörmander定义包含漂移。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；σ=0使原结论失效
- 修正版分项：原送审C∞且σ≠0的_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 8. MD-8.4.1-NHL

- source_id：MD-8.4.1-NHL；印刷页 345–346 / PDF页 366–367。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> dq=M⁻¹pdt, dp=-∇Udt-ξpdt, dξ=μ⁻¹[pᵀM⁻¹p-N_dk_BT]dt-γξdt+√(2k_BTγμ⁻¹)dW. Quadratic specialization: U=qᵀAq/2, M=I.

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页366–367。
- 问题所在：已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p不产生单位质量方程；正确方向相反并须同步变换势。；[ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。；已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p方向有误。正确为q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p，势变为Ũ(q̃)=U(M⁻¹ᐟ²q̃)；若U(q)=qᵀAq/2，则Ã=M⁻¹ᐟ²AM⁻¹ᐟ²。
- 反例或理由：原印重缩放的一维精确反例：M=4，则q̃=q/2、p̃=2p，原方程q̇=p/4给q̃̇=p/8=p̃/16，而非p̃。正确取q̃=2q、p̃=p/2即有q̃̇=p̃。一般正确变换后Ũ(q̃)=U(M⁻¹ᐟ²q̃)，二次势矩阵Ã=M⁻¹ᐟ²AM⁻¹ᐟ²。
- 原文版 Lean 名称及状态：`MD.Ch08.nhlDrift`：定义；`MD.Ch08.isNHLSolution`：定义；`MD.Ch08.harmonicPotential`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。
- 修正或补充前提：[EXTRA] M⁻¹=diag(invm)，N_d=n；invm_i,β,Q,γ均正；β⁻¹=k_BT，Q=μ。一般非对角物理质量未覆盖。；isNHLSolution采用一个实Wiener坐标，噪声只作用ξ，幅度sqrt(2γ/(βQ))；解的可测、连续、可积与固定初值规格由additiveSDE给出。；harmonicPotential对任意实方阵A定义qᵀAq/2；没有在该def中要求A对称正定，也未把isNHLSolution绑定到该二次势或M=I。；不含原页定理8.1、特征值互异、D的模态排除及Hörmander/遍历性结论；不得由本条声明推断这些性质。；[ERRATUM?] 原印质量重缩放方向有误，保留原文，正确方向须同步变换势。；[ERRATUM?] 正确重缩放为q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p；Ũ(q̃)=U(M⁻¹ᐟ²q̃)，二次势矩阵变为M⁻¹ᐟ²AM⁻¹ᐟ²。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。
- 待人工核查点：保留原文重缩放并判人工处理；报告正确方向及变换后的势。维持当前声明的正对角质量范围，不把harmonicPotential的def说成已经完成(8.30)–(8.32)的正定二次特化或证明定理8.1。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：FAIL
- 网站复审结论：NEEDS_HUMAN。展开nhField可得nhlDrift=((invm·p,−∇U−ξp),(∑ invm_i p_i²−n/β)/Q−γξ)，故三个漂移分量对应(8.27)–(8.29)。isNHLSolution在任意带可测空间Ω上量化概率测度P、单坐标W、状态过程X及固定x0，要求全部逆质量、β,Q、γ正；常噪声向量的物理Phase分量为0，热浴分量sqrt(2γ/(βQ))，与原印根号覆盖范围完全一致。additiveSDE的完整积分解前提已核对，不声称存在、不变性或遍历性。harmonicPotential对任意A只定义二次函数；只有A对称时梯度才是Aq，不能凭def推断正定或定理8.1。原页D用于后续Hörmander结论，本条未形式化它，不应将此归为一般NHL漂移错误。当前明确缩小范围的三个声明本身可PASS，原书重缩放疑误使条目总体NEEDS_HUMAN。
- 原文版分项：原印质量重缩放方向疑误待导师
- 修正版分项：正对角质量NHL漂移及单噪声积分解规格网站PASS；harmonicPotential仅定义函数，不含(8.30)–(8.32)特化或定理8.1
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 9. MD-8.4.1-Proposition83

- source_id：MD-8.4.1-Proposition83；印刷页 347–348 / PDF页 368–369。
- 类别：原证明核查
- 原文引文及公式（原书全文另逐字保留）：

> If A is symmetric positive definite with distinct eigenvalues, the 2N_c vectors C₁,D₁,...,C_Nc,D_Nc are linearly independent on D=R^{2Nc}\⋃V_k.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页368–369。本轮不虚称重新目视。
- 问题所在：[ERRATUM?]原证明下标、模态标量式及第二组系数消去需核对；命题与Lean签名正确。
- 反例或理由：PASS（签名与正确命题一致；原证明疑误另在json_review中NEEDS_HUMAN）。A.PosDef在实域提供对称正定，hdist是全部n个本征值的单射性。z∈D严格要求每一模态(q̂_i,p̂_i)不同时为零。Family的Fin n⊕Fin n族是C₁..C_n和D₁..D_n，和书中交错顺序仅差排列。结论LinearIndependent ℝ同时消去两组任意实系数，并非仅证明其中一组。每个模态的两列系数矩阵行列式为-λ_i(p̂_i²+λ_i q̂_i²)，由λ_i>0和域条件非零，继而两个次数<n的多项式在n个不同本征值上为零，均恒零。因此项目结论合理且完整；不能照抄书中未处理第二组系数的论证来替代这一检查。
- 原文版 Lean 名称及状态：`MD.Ch08.proposition83`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：指定模态域内的2n个实际线性场值线性无关；不扩大到例外零模态。
- 修正或补充前提：D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。
- 待人工核查点：Lean声明无需改动。原证明文字原样保留并加[ERRATUM?]；若另写勘误，令π(x)=Σα_kx^k、σ(x)=Σβ_kx^k，由定义得到π(λ_i)p̂_i+λ_iσ(λ_i)q̂_i=0及λ_iπ(λ_i)q̂_i-λ_iσ(λ_i)p̂_i=0；先解出π(λ_i)=σ(λ_i)=0，再分别用根数论证两组系数全零。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：PASS
- 网站复审结论：本条未参加32号对应复审；原首轮PASS意见保留。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：网站PASS（首轮声明未变）。

修正证明路线：令π(x)=Σα_kx^k、σ(x)=Σβ_kx^k，从π(λ_i)p̂_i+λ_iσ(λ_i)q̂_i=0、λ_iπ(λ_i)q̂_i−λ_iσ(λ_i)p̂_i=0及正定/域条件推出π、σ在n个不同本征值上同时为零；次数<n，分别消去两组系数。声明无须修改，完整证明尚未完成。

## 10. MD-8.4.1-Theorem81

- source_id：MD-8.4.1-Theorem81；印刷页 346–348 / PDF页 367–369。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> If A is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on D×R.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页367–369。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。；[ERRATUM?]字面版含σ=0反例；物理上下文的参数资格与字面版分开。原质量重缩放与所引证明的局部排印/推导疑误亦应保留。
- 反例或理由：n=1，A=[1]，Q=θ=γ=1，σ=0，w=((q,p),ξ)=((1,0),0)。正定、谱单射及D条件成立，但种子仅有漂移((0,-1),-1)和零噪声。单一场与自身括号为零，点值张成最多一维，达不到三维。
- 原文版 Lean 名称及状态：`MD.Ch08.theorem81Printed`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.theorem81_corrected`：已证
- 修正或补充前提：D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。；[EXTRA]θ=k_BT，Q=μ；corrected的Q,θ,γ>0是物理资格，括号结论本身只额外需要σ≠0。σ在此是独立实参数，未声明满足NHL涨落耗散幅度。；[EXTRA] 当前_corrected为σ独立非零的括号结论；如解释为物理NHL，还须σ²=2γθ/Q。未推到全局遍历性。
- 待人工核查点：Printed保留并标[ERRATUM?]；实际使用corrected。注明正Q/θ/γ是物理[EXTRA]，σ非零是当前括号条件的必要资格；需要还原(8.29)物理噪声时另外绑定σ²=2γθ/Q。保留原上下文疑误，不据其声称全局遍历性。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；缺非零噪声资格
- 修正版分项：原送审正参数与σ≠0的_corrected点态括号结论PASS，非全局遍历性
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 11. MD-8.4.1-LyapunovRatePrinted

- source_id：MD-8.4.1-LyapunovRatePrinted；印刷页 349 / PDF页 370。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页370。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。；{"codes": ["ERRATUM_LYAPUNOV_RATE"], "detail": "lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书α=min(2a,γμ)及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为min(2a,γ)合理且正确：ξ能量的系数是Q/2，故须α≤γ；结合平方不等式及U≤Umax得所写δ。修正版没有额外宣称几何遍历。", "suggested_fix": "原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，α=min(2a,γ)。"}
- 反例或理由：P²=0,U=Umax=2,ξ=10,Q=4,θ=γ=1,a=2,N=8；aγQ=Nθ=8。Printed α=4，左端−383，右端−479，故−383≤−479为假。
- 原文版 Lean 名称及状态：`MD.Ch08.lyapunovAlphaPrinted`：定义；`MD.Ch08.lyapunovRatePrinted`：未证；`MD.Ch08.lyapunovRate_counterexample`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.lyapunovAlpha_corrected`：定义；`MD.Ch08.lyapunovRate_corrected`：未证
- 修正或补充前提：修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。
- 待人工核查点：原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，α=min(2a,γ)。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；min(2a,γμ)一般不正确
- 修正版分项：原送审min(2a,γ)修正版及反例PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 12. MD-8.4.3-PreEquilibriumMeans

- source_id：MD-8.4.3-PreEquilibriumMeans；印刷页 354–355 / PDF页 375–376。
- 类别：域或覆盖说明
- 原文引文及公式（原书全文另逐字保留）：

> θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页375–376。本轮不虚称重新目视。
- 问题所在：[RESOLVED] 旧issues中的MISSING_MOMENT_INTEGRABILITY与当前摘录不符：两项Integrable及正逆质量均已补入；不能沿用旧缺失判定。；[COVERAGE_GAP] 原页明确要求ρ按扩展NHL系统的Fokker–Planck方程演化；当前定义未表达该演化，已按statement_scope缩限为任意随时间概率密度的有限平均，不将其称作完整预平衡动力学形式化。
- 反例或理由：逐一审查meanKineticTwice、meanBath、preEquilibriumDensity：任意n，状态z=((q,p),ξ)，标准体积积分，动能权重∑invmᵢpᵢ²与浴权重ξ均忠实。均值def对任意实数t总化；资格def仅对t≥0要求概率密度、正逆质量和两项矩可积。已在范围内明确未形式化原页NHL Fokker–Planck演化及稳定性，因此不将定义误称完整动力学资格。旧issues是元数据过期，当前声明无该缺陷。未编译或补证明。
- 原文版 Lean 名称及状态：`MD.Ch08.meanKineticTwice`：定义；`MD.Ch08.meanBath`：定义；`MD.Ch08.preEquilibriumDensity`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。
- 修正或补充前提：[EXTRA] preEquilibriumDensity要求所有逆质量严格为正，且对每个t≥0，ρ t逐点非负、可积、积分为1，两项加权函数均Integrable。正质量与有限矩资格均已在当前Lean定义中出现。；meanKineticTwice和meanBath本身是任意实数t上的总化积分定义；仅在上述资格及t≥0下解释为有限平均。；preEquilibriumDensity为历史名称：不要求NHL Fokker–Planck演化；本条范围仅为两平均的定义与资格。闭合动力学和局部稳定性不在所列Lean声明中。
- 待人工核查点：采用corrected_json清理已解决的矩可积性旧报告，保留Fokker–Planck演化的覆盖缺口；当前摘录Lean无需修改。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：FAIL
- 网站复审结论：PASS。逐一审查meanKineticTwice、meanBath、preEquilibriumDensity：任意n，状态z=((q,p),ξ)，标准体积积分，动能权重∑invmᵢpᵢ²与浴权重ξ均忠实。均值def对任意实数t总化；资格def仅对t≥0要求概率密度、正逆质量和两项矩可积。已在范围内明确未形式化原页NHL Fokker–Planck演化及稳定性，因此不将定义误称完整动力学资格。旧issues是元数据过期，当前声明无该缺陷。未编译或补证明。
- 原文版分项：原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS
- 修正版分项：当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定
- 当前状态：网站复审PASS（Lean未改）。

## 13. MD-8.4.4-RescalingStationary

- source_id：MD-8.4.4-RescalingStationary；印刷页 355 / PDF页 376。
- 类别：域或覆盖说明
- 原文引文及公式（原书全文另逐字保留）：

> With these definitions, the method preserves the canonical probability density ρ_β. The book does not prove ergodicity.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页376。本轮不虚称重新目视。
- 问题所在：[RESOLVED] 旧issues及extra_assumptions中“havoid只量化Function.support f/尚未实现tsupport”的描述已过期；当前完整Lean与依赖规格均明确使用tsupport f。；[COVERAGE_GAP] 零动量边界、全局随机过程及半群不变性尚未形式化；此项是明确披露的覆盖限制，不是当前远离边界的弱驻定声明错误。
- 反例或理由：审查rescalingPsi、Drift、Noise、Admissible及完整rescalingStationary类型：M=I、n=N_d、θ=k_BT，Ψ及漂移/扩散系数符号与因子正确；单个噪声给出秩一扩散。二阶项冻结噪声为正确Itô项。C²势、Φ在K>0的光滑正性与增长条件、正θ,Z、概率归一、C∞紧支撑及tsupport避零前提齐全。结论仅为∫Lfρβ=0；紧闭包支撑避零已修复旧报告的问题，Φ在K=0任意的总化值不妨碍该限定范围。完整不变性和遍历性缺口已明确。sorry不影响本次签名判定，未编译或补证明。
- 原文版 Lean 名称及状态：`MD.Ch08.rescalingStationary`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。
- 修正或补充前提：[EXTRA] hU要求U为C²；θ,Z>0且hρ完整要求正则概率密度归一与可积。Φ仅在K>0上光滑、正，另有KΦ在0附近有界及Φ无穷远至多多项式增长的原页条件。；[EXTRA] f为C∞紧支撑测试函数；当前havoid已对闭包支撑tsupport f量化，要求其中每点p≠0。有限维紧性确保非空闭包支撑与p=0分离，K在该支撑上具有严格正下界。；二阶项中rescalingNoise Φ θ z对内层变量x保持固定，得到Itô Hessian项的一半，不包含噪声方向的导数。；结论仅为∫Lf·ρβ=0的局部弱驻定目标；未断言随机解存在、零动量边界控制、Markov半群不变性或遍历性。
- 待人工核查点：采用corrected_json移除Function.support与tsupport混淆的过期FAIL报告；保持弱驻定范围与全局随机过程覆盖缺口，当前Lean无需修改。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：FAIL
- 网站复审结论：PASS。审查rescalingPsi、Drift、Noise、Admissible及完整rescalingStationary类型：M=I、n=N_d、θ=k_BT，Ψ及漂移/扩散系数符号与因子正确；单个噪声给出秩一扩散。二阶项冻结噪声为正确Itô项。C²势、Φ在K>0的光滑正性与增长条件、正θ,Z、概率归一、C∞紧支撑及tsupport避零前提齐全。结论仅为∫Lfρβ=0；紧闭包支撑避零已修复旧报告的问题，Φ在K=0任意的总化值不妨碍该限定范围。完整不变性和遍历性缺口已明确。sorry不影响本次签名判定，未编译或补证明。
- 原文版分项：原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS
- 修正版分项：当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定
- 当前状态：网站复审PASS（Lean未改）。

## 14. MD-8.5-SLSBracketPrinted

- source_id：MD-8.5-SLSBracketPrinted；印刷页 358 / PDF页 379。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> D=(ξp,-p,-p·∇U-ξ), D′=[D,Y_{Nc+1}]=(p,0,1), [D′,Y_i]=e_i.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页379。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。；{"codes": ["ERRATUM_LIE_BRACKET_SIGN"], "detail": "slsBracketPrinted逐字对应原书(p,0,1)，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按VectorField.lieBracket V W=DW·V−DV·W，常向量Yξ给[D,Yξ]=−∂ξD=(−p,0,1)，故_corrected签名正确。反向括号会整体变为(p,0,−1)，不能仅靠约定得到原书(p,0,1)。二次括号的整体符号不影响张成。", "suggested_fix": "保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为−p。"}
- 反例或理由：n=1,U=0,p=1时[D,Yξ]=((−1,0),1)，而Printed右端为((1,0),1)。
- 原文版 Lean 名称及状态：`MD.Ch08.slsBathNoise`：定义；`MD.Ch08.slsBracketPrinted`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.slsBracket_corrected`：未证
- 修正或补充前提：只纠正第一括号；二次括号的整体符号不影响生成空间张成。
- 待人工核查点：保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为−p。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；括号首分量符号不一致
- 修正版分项：原送审−p首分量_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 15. MD-8.5-SLSLeapfrog

- source_id：MD-8.5-SLSLeapfrog；印刷页 358–359 / PDF页 379–380。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> q=q₀+ηM⁻¹p; η̇=ξ, ξ̇=-∂ηU(q₀+ηM⁻¹p). Leapfrog: ξ_{1/2}=ξ-h(M⁻¹p)·∇U(q)/(2μ), q′=q+hξ_{1/2}M⁻¹p, ξ′=ξ_{1/2}-h(M⁻¹p)·∇U(q′)/(2μ).

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页379–380。
- 问题所在：[ERRATUM?][SOURCE_MISSING_MU_IN_REDUCTION] 原页η约化式缺μ⁻¹，和(8.36)及两次kick不一致。原文及statement_latex保持不动，勘误须人工确认。；[DOMAIN_CLARIFICATION] Q>0、正质量及可微性只是物理解释域说明，没有作为Lean def的前提；不把总函数误读为所有参数上的经典动力学定理。；已目视核对原页PDF379：η约化式确实漏μ⁻¹，一般μ下应为ξ̇=−μ⁻¹∂ηU；原印与Printed保留，_corrected恢复1/Q。
- 反例或理由：针对把原印η约化式当作一般μ下(8.36)的等价式：取n=1，invm=1，p=1，q₀=0，U(q)=q²/2，Q=μ=2，η=1。原印给ξ̇=−1，而(8.36)及_corrected给ξ̇=−1/2。此为原书不一致的解析例子，不是Printed字面忠实性或_corrected版的反例。
- 原文版 Lean 名称及状态：`MD.Ch08.slsBathKick`：定义；`MD.Ch08.slsDriftStep`：定义；`MD.Ch08.slsLeapfrog`：定义；`MD.Ch08.slsCoordinateField`：定义；`MD.Ch08.slsReducedPrinted`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.slsReduced_corrected`：定义
- 修正或补充前提：[ERRATUM?] 原页379的η约化式确实印为ξ̇=−∂ηU，漏写了同页(8.36)及下一页kick公式中的μ⁻¹；Printed版逐字保留，_corrected版单独恢复1/Q。；本条仅定义半kick–drift–半kick、逐坐标场及两种约化场；OU耦合、体积保持、二阶不变分布误差、精确求积与坐标变换定理均未形式化。；[EXTRA] 物理域与总化导数/除法的区别见context_notation；这些限制不是现有def的Lean参数前提。；[EXTRA] 物理解释另需Q=μ>0、各invm_i>0及U可微；现有def不强制这些资格。
- 待人工核查点：原文及Printed保持不动，在元数据明确[ERRATUM?]：一般μ下应为ξ̇=−μ⁻¹∂ηU。保留独立_corrected并交人工确认原书勘误；算法定义无需修改。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：NEEDS_HUMAN。六个def逐一审查均通过：slsBathKick、slsDriftStep、slsLeapfrog、slsCoordinateField对应原页算法，p始终固定；slsReducedPrinted忠实保留原印漏因子式，slsReduced_corrected恢复1/Q，符合(8.36)的方向导数。物理解释以Q>0、正对角逆质量及相关可微性为域，def本身为全域总函数，无物理域或误差结论的量词断言。原印版忠实性PASS、修正版合理性PASS、算法定义PASS；条目总体NEEDS_HUMAN仅因原书μ⁻¹遗漏待人工确认，不是这些Lean定义FAIL。
- 原文版分项：Printed忠实性PASS；一般μ下约化式漏μ⁻¹待导师
- 修正版分项：算法定义及恢复1/Q的_corrected网站PASS
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 16. MD-8.6-IsokineticDivergencePrinted

- source_id：MD-8.6-IsokineticDivergencePrinted；印刷页 362–363 / PDF页 383–384。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> ρ=e^{-w(q,p)}Φ(K(p)); div f_iso=(N_c-1)pᵀM⁻¹F/(pᵀM⁻¹p), w=(N_c-1)U/K.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页383–384。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。；PDF383确实印正号div f=(Nc−1)λ，PDF384随后仍用正号的∇w·f等式并给w=(Nc−1)U/K；原文逐字内容应保留。；已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。
- 反例或理由：n=2、invm=(1,1)、F(q)=(1,0)、p=(1,0)：K=1、λ=1，真实相空间散度为−1，原印右端为+1。
- 原文版 Lean 名称及状态：`MD.Ch08.isoAnsatz`：定义；`MD.Ch08.isoDivergencePrinted`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.isoDivergence_corrected`：未证
- 修正或补充前提：Φ为正光滑非零函数时称权重；使用K≠0域上的实际散度。；已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。
- 待人工核查点：保留isoDivergencePrinted并标[ERRATUM?]；修正版负号正确。PDF384的∇w·f等式也应在勘误说明中相应改负号，不应把正的w表达式改成负的。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；原印散度正号有误
- 修正版分项：原送审负号_corrected签名PASS；w本身保留正号
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 17. MD-8.6.1-SINWeightPrinted

- source_id：MD-8.6.1-SINWeightPrinted；印刷页 365 / PDF页 386。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页386。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。；PDF386确实印w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2)，未含μ₂；statement_latex忠实，不能静默把原印式改成修正式。
- 反例或理由：取Q1=1、Q2=2、θ=1、U=0、z=(0,0,√2,1)、γ=0。原印ρ=e^(−1/2)，有div(ρb)=ρ/2≠0；补上Q2后的通量散度为0。
- 原文版 Lean 名称及状态：`MD.Ch08.sinWeightPrinted`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinWeight_corrected`：定义；`MD.Ch08.sinWeight_stationary_corrected`：未证
- 修正或补充前提：仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
- 待人工核查点：原印权重保留并标[ERRATUM?]缺热浴质量μ₂；修正版和其局部驻定签名可保留。须另证曲面测度、边缘Gibbs及含OU情形。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；原印二次项缺μ₂
- 修正版分项：原送审补Q2的权重与壳面局部驻定签名PASS，非曲面测度不变性
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 18. MD-8.6.2-SINProjectedBracketsPrinted

- source_id：MD-8.6.2-SINProjectedBracketsPrinted；印刷页 367 / PDF页 388。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> u₀=Πf, u₁=Π[f,g], u₂=Π[f,[f,g]], u₃=Π[f,[f,[f,g]]]. The displayed equations (8.48)–(8.53) give their components, with D=2p²+ξ₁².

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页388。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。；PDF388逐式核对：(8.48)为u0；(8.49)ξ₁分量前确无共同σ；(8.50)印u1却重复u0展开式；(8.51)印u2却是首交换子的投影。(8.52)的p分量确为−σa而非−σξ₁²a，故Lean忠实保留了原印式，不应替书改系数。；已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
- 反例或理由：q=0,p=1,ξ₁=1,ξ₂=0时u0投影=[1,0,0]，而实际首括号投影=[0,−σ/3,2σ/3]；不能把(8.50)中重复的u0当作u1。另在p=0,q≠0、ξ₁≠0处，(8.49)的第三分量为ξ₁(1−1)=0，整个u1为零；因此原页“(8.53)平行于u1”的论证也不能直接作为非零向量论据。
- 原文版 Lean 名称及状态：`MD.Ch08.bracket4`：定义；`MD.Ch08.sinBracket`：定义；`MD.Ch08.projectFirstThree`：定义；`MD.Ch08.sinD`：定义；`MD.Ch08.sinU0Printed`：定义；`MD.Ch08.sinU1Printed`：定义；`MD.Ch08.sinU2Printed`：定义；`MD.Ch08.sinU1DerivativePrinted`：定义；`MD.Ch08.sinU2LongPrinted`：定义；`MD.Ch08.sinU2Long_at_p0`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinProjected_corrected`：定义
- 修正或补充前提：总化分式只在θ>0的约束面D=2θ>0使用；实际交换子先在四维完整计算再投影。；本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。；已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
- 待人工核查点：保留所有Printed定义，并给(8.49)–(8.53)加[ERRATUM?]。修正版应以sinProjected_corrected的真实四维括号为准；不得仅改下标就宣称长式已校正。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed各表达式忠实性PASS；(8.49)–(8.53)疑误待导师
- 修正版分项：原送审完整四维真实括号再投影定义PASS，长式未声称等于真实括号
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 19. MD-8.6.2-SINThirdBracketPrinted

- source_id：MD-8.6.2-SINThirdBracketPrinted；印刷页 368 / PDF页 389。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> The third projected commutator is displayed in (8.54), with polynomial η in (8.55); its p=0 specialization is printed as u₃=-2σq∂q-σq(-γ+ξ₂)∂p in (8.56).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页389。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。；PDF389的(8.54)q分量分母为D²，(8.55)的13项多项式逐项与sinEtaPrinted一致；(8.56)原印q分量为−2σq，确无ξ₁²分母。
- 反例或理由：取σ=1、q=1、p=0、ξ₁=2、γ=ξ₂=1。(8.54)给[−1/2,0,0]，(8.56)给[−2,0,0]，而sinU3Zero_corrected与(8.54)相符。
- 原文版 Lean 名称及状态：`MD.Ch08.sinEtaPrinted`：定义；`MD.Ch08.sinU3Printed`：定义；`MD.Ch08.sinU3ZeroPrinted`：定义；`MD.Ch08.sinU3Zero_specialize`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinU3Zero_corrected`：定义
- 修正或补充前提：ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。；_corrected只修正(8.54)在p=0的内部代数特化，不能据此声称Printed长式等于真实三重括号。
- 待人工核查点：保留原印两式并标[ERRATUM?]内部不一致；注明_corrected是“对(8.54)的p=0代数特化修正”，不能命名或描述为已经验证的真实三重交换子公式。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；(8.54)/(8.56)内部不一致
- 修正版分项：原送审_corrected及specialize在内部代数特化意义下PASS，非真实三重括号校正
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 20. MD-8.6.2-SINBracketRank

- source_id：MD-8.6.2-SINBracketRank；印刷页 366–368 / PDF页 387–389。
- 类别：域或覆盖说明
- 原文引文及公式（原书全文另逐字保留）：

> For θ>0, γ>0, on p²+ξ₁²/2=θ with ξ₁≠0 and outside M₀, the fields f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]] span the three-dimensional tangent space of the isokinetic cylinder.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页387–389。本轮不虚称重新目视。
- 问题所在：PDF387–389列出的五个场和M0吻合。原页先说明运动限制在ξ₁>0或ξ₁<0半空间；statement_latex应显式带上这一域，避免把“除M0外”误读为包含ξ₁=0的整个圆柱。
- 反例或理由：若删掉ξ₁≠0：取θ=γ=1、z=(0,1,0,0)，它在K=1且不在M0，但ξ₁=0是不变面，所有这些场的ξ₁分量为0，只能张成切空间的至多二维部分。此反例针对遗漏域的摘要，不针对现有Lean定理。
- 原文版 Lean 名称及状态：`MD.Ch08.sinBracket_tangentSpan`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：例外直线外的有限括号张成目标；非完整遍历性定理。
- 修正或补充前提：θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
- 待人工核查点：在statement_latex显式加入θ,γ>0、K=θ及ξ₁≠0；保留现有Lean全部前提，不将半柱结论扩大到ξ₁=0边界。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：PASS
- 网站复审结论：本条未参加32号对应复审；原首轮PASS意见保留。
- 原文版分项：见原网站逐项意见；不凭整组状态推定原印真值
- 修正版分项：未单列修正版则不推定分项PASS
- 当前状态：网站PASS（首轮声明未变）。

## 21. MD-8.6.2-SINLyapunov

- source_id：MD-8.6.2-SINLyapunov；印刷页 368–369 / PDF页 389–390。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> For φ=ξ₂²/2, L_isok φ=(ξ₁²-β⁻¹)ξ₂-γξ₂²+σ²/2, and the isokinetic constraint bounds ξ₁. The negative tail drift supports the ergodicity argument with further assumptions.

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页389–390。
- 问题所在：[ERRATUM?][SOURCE_LYAPUNOV_SIGNED_BOUND] 原页390以ξ₁有界推出固定有符号Kξ₂全局上界，未区分ξ₂正负。需保留原文并由人工确认勘误；绝对值修正版正确。；[SOURCE_ERGODICITY_GAP] 原页还提出周期/有界配置、约束及候选测度在开集上为正等全局条件，并援引其他论证；当前局部Lean声明没有遍历性结论，不能将其当作完整遍历性证明。；已目视核对原页PDF390：原印有符号Kξ₂界不能统一控制正负两侧。单位质量Q1=Q2=1、σ²=2γθ下修正版为−γξ₂²+θ|ξ₂|+γθ；仅为局部生成元和约束界，不推出遍历性。
- 反例或理由：针对原书固定有符号线性上界：令θ=γ=1，Λ=1。若ξ₁²=2、p=0，正ξ₂尾部要求C≥1；若ξ₁=0、p=1，负ξ₂尾部要求C≤−1，所以无同一个C统一控制所有约束状态及两个尾部。例如取C=1，z=(0,1,0,−1)，Lφ=1而−γξ₂²+Cξ₂+γθ=−1，上界不成立。Printed仅存表达式，修正绝对值界无此问题。
- 原文版 Lean 名称及状态：`MD.Ch08.sinGenerator`：定义；`MD.Ch08.sinGenerator_lyapunov`：未证；`MD.Ch08.sinConstraint_bathBound`：已证；`MD.Ch08.sinLyapunovTailPrinted`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinLyapunovTail_corrected`：未证
- 修正或补充前提：[EXTRA] sinGenerator_lyapunov要求θ>0、γ>0与Λ≠0；sinLyapunovTail_corrected要求Λ=θ，因θ>0自动排除Λ=0。；sinConstraint_bathBound允许任意θ，但约束等式本身蕴含θ≥0及ξ₁²≤2θ；无需漏加θ>0。；[ERRATUM?] 原页的固定有符号Kξ₂项不能统一支配两侧尾部；Printed仅存原印表达式，不断言其为上界；修正版为−γξ₂²+θ|ξ₂|+γθ。；仅覆盖生成元恒等式与约束界；局部计算尚有sorry，此项不据此判签名FAIL。未形式化遍历性的全局条件或充分性。；[EXTRA] 当前生成元固定单位质量Q1=Q2=1，并使用σ²=2γθ；常数γθ来自σ²/2。局部生成元和约束界不等于全局遍历性。
- 待人工核查点：保留原页有符号式并标[ERRATUM?]；使用已列_corrected的θ|ξ₂|界。明确单位质量和噪声关系；人工核实原书勘误及其全局遍历性推理，不将当前局部生成元陈述升级为遍历性定理。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：NEEDS_HUMAN。五项声明及全部依赖定义逐一审查：单位Q1,Q2及σ²=2γθ下，sinGenerator和Lyapunov恒等式正确；hθ,hγ,hK与结论对象完整。sinConstraint_bathBound由p²+ξ₁²/2=θ得到ξ₁²≤2θ，允许θ为任意实数没有遗漏。Printed只保存有符号尾项表达式，字面忠实性PASS；_corrected在Λ=θ、θ,γ>0下给双侧有效界，陈述正确PASS，不包含遍历性结论。总体NEEDS_HUMAN源于原书固定有符号尾项上界疑误及全局遍历性论证尚需核实；不因恒等式sorry或依赖该恒等式的修正版而判签名FAIL。未编译或补证明。
- 原文版分项：Printed表达式忠实性PASS；有符号尾界疑误待导师
- 修正版分项：单位质量、σ²=2γθ下生成元与绝对值尾界签名网站PASS，非遍历性
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 22. MD-8.6.3-SINForceExactPrinted

- source_id：MD-8.6.3-SINForceExactPrinted；印刷页 372 / PDF页 393。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> ṗ=F−p²F/Λ, ξ̇₁=pξ₁F/Λ. The printed solution is p(h)=(p(0)+(F/m)s(h))/ṡ(h), ξ₁(h)=ξ₁(0)/ṡ(h), with s(t)=b⁻¹/²sinh(t√b)+(a/b)(cosh(t√b)−1), a=Fp(0)/Λ, b=F²/Λ.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页393。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。；[ERRATUM?] 保留Printed，给ξ₁负号版添加[ERRATUM?]；保留m=1的[EXTRA]，不要把工作修正版回填为原文。
- 反例或理由：取Q1=2、z=(0,1,1,0)、F=1，则Λ=2、s′(0)=1、s″(0)=1/2。候选ξ₁′(0)=−1/2，Printed场给+1/2；负号校正版给−1/2。
- 原文版 Lean 名称及状态：`MD.Ch08.sinForceAux`：定义；`MD.Ch08.sinForceFlow`：定义；`MD.Ch08.sinForceODEPrinted`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.sinForceODE_corrected`：定义；`MD.Ch08.sinForceFlow_solution_corrected`：未证
- 修正或补充前提：质量按本节假设取1；Q₁、Λ正，排除ṡ=0；F=0用b=0的解析延拓，避免总化除法假装极限。；只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。
- 待人工核查点：保留Printed，给ξ₁负号版添加[ERRATUM?]；保留m=1的[EXTRA]，不要把工作修正版回填为原文。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed正号ODE忠实性PASS；与候选导数冲突
- 修正版分项：原送审负号_corrected及局部解签名PASS；限m=1与非零分母
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 23. MD-8.7-GeneralizedLangevin

- source_id：MD-8.7-GeneralizedLangevin；印刷页 374 / PDF页 395。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> dq=M⁻¹pdt, dp=−∇U(q)dt−∫₀ᵗΓ(t−s)p(s)ds dt+dB, q(0)=q₀,p(0)=p₀. Γ is the memory kernel and B is colored noise. (8.57)–(8.58).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页395。本轮不虚称重新目视。
- 问题所在：[ERRATUM?] 保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。；已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
- 反例或理由：平稳Gaussian OU过程具有指数时间相关，故有色噪声可以是Gaussian；有色性不蕴含非Gaussian。
- 原文版 Lean 名称及状态：`MD.Ch08.memoryDrag`：定义；`MD.Ch08.generalizedLangevin`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：连续矩阵记忆核下的卷积及GLE积分解类定义。
- 修正或补充前提：B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。；本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。；[EXTRA] generalizedLangevin仅为给定B的方程规格；未在此谓词约束有色性、非Gaussian性或涨落耗散关系。；已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。；[EXTRA] generalizedLangevin仅为给定加性驱动B的积分方程，噪声分布、有色性及FD未在本定义内强制，由另条规格给出。
- 待人工核查点：保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：原送审给定B的积分方程规格可接受；有色/非Gaussian同义说法待导师
- 修正版分项：本轮文字修正：有色Gaussian可以存在；不新增分布或FD结论
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 24. MD-8.7-GLEFluctuationDissipationPrinted

- source_id：MD-8.7-GLEFluctuationDissipationPrinted；印刷页 374 / PDF页 395。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> ⟨Rᵢ(t+s)Rⱼ(t)⟩=k_BT γᵢⱼ(s)δᵢⱼ, s≥0. Γ(t)=γ(t)I in the scalar-kernel specialization. (8.59).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页395。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。；[ERRATUM?] 保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。
- 反例或理由：θ=1，Γ(s)=exp(−s)·[[1,1/2],[1/2,1]]可由相关平稳Gaussian OU实现；交叉协方差为exp(−s)/2，Printed的δ却强制为0。
- 原文版 Lean 名称及状态：`MD.Ch08.randomForceQualification`：定义；`MD.Ch08.gleFDPrinted`：定义；`MD.Ch08.scalarMemoryMatrix`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.gleFD_corrected`：定义
- 修正或补充前提：修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- 待人工核查点：保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed的δ忠实于原页；一般矩阵解释有疑
- 修正版分项：原送审去δ的矩阵协方差目标PASS；可实现性另需正定资格
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 25. MD-8.7.1-PronyOUStationarity

- source_id：MD-8.7.1-PronyOUStationarity；印刷页 376 / PDF页 397。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> dRᵢₖ=−Rᵢₖdt/τₖ+√(2θcₖ)dWᵢₖ/τₖ；原印E[Rᵢₖ(t)]=0、E[Rᵢₖ(t+s)Rᵢₖ(t)]=(θcₖ/τₖ)exp(−s/τₖ)，t,s≥0；Rᵢ=Σ_{k∈Fin K}Rᵢₖ（书中k=1,…,kmax，K=kmax）。[EXTRA] 两个Lean相关式均补平稳初态及独立性，不是无条件原印结论。

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页397。
- 问题所在：[ERRATUM?] 原页(8.66)断言零均值及与t无关的二阶矩，页内未声明初始律；仅由(8.65)不能推出。原印原句必须保留，是否上下文已默认平稳解释需人工确认。；[EXTRA] stationaryPronyOU补充了正参数、平稳Gaussian初态、与整条W独立、路径连续及各非负时刻L²资格；应显式标记其为修正版前提。pronyOU_covariance和_corrected签名相同，前者也已经是带补充资格的版本，不能当作无条件原印断言。；已目视核对原页PDF397：(8.66)印出s≥0但未说明平稳初态。修正版另加[EXTRA]初态N(0,θc/τ)且与整条W独立；t,s≥0；有限和用k∈Fin K，不宣称跨模式总协方差。
- 反例或理由：{"scope": "反驳无平稳初态资格的原印一般断言，不反驳Lean修正版。", "example": "取c=τ=θ=1，标准Brownian W，R(0)=0，R(t)=√2∫₀ᵗ exp(−(t−u))dW(u)。这是(8.65)的解，但t=0,s=0时E[R(0)²]=0，原印右端为1。一般二阶矩为exp(−s)(1−exp(−2t))。", "validation": "解析反例；未作数值实验。"}
- 原文版 Lean 名称及状态：`MD.Ch08.stationaryPronyOU`：定义；`MD.Ch08.pronyOU_covariance`：未证；`MD.Ch08.totalPronyRandomForce`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.pronyOU_covariance_corrected`：未证
- 修正或补充前提：[EXTRA] θ代表k_BT，c、τ、θ严格为正；W为一个实Brownian坐标（Vec 1）。；[EXTRA] R(0)具有N(0,θc/τ)律且与整条W独立；非负时间路径几乎处处连续，各非负时刻R(t)属于L²；积分方程逐个非负时刻几乎处处成立。；[EXTRA] 这里没有对多个模式的W作联合独立假设；totalPronyRandomForce仅为有限和定义，不声称总协方差公式。；[EXTRA] t,s≥0；totalPronyRandomForce的求和为k∈Fin K（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。
- 待人工核查点：保留(8.66)原句并显式[ERRATUM?]；修正说明补入平稳初态及独立性。给两条covariance签名均标明带[EXTRA]资格版本；补齐摘要中的s≥0及求和上下限；不修改Lean、不补证明。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：NEEDS_HUMAN。{"overall": "NEEDS_HUMAN仅针对原书缺省平稳初态及其解释；所列修正版签名在数学上合理，不因sorry判FAIL。", "objects_and_domains": "Ω为任意可测空间，P为Measure Ω；independentWiener在hR内保证P为概率测度。W:ℝ→Ω→(Fin 1→ℝ)，R:ℝ→Ω→ℝ，c、τ、θ为实数且均严格正。只对t≥0、s≥0作结论，不断言负时间驻定。", "declarations": [{"lean_decl": "MD.Ch08.stationaryPronyOU", "verdict": "PASS", "explanation": "一维Brownian、方差θc/τ的中心Gaussian初态、初态与整条W独立、非负时间连续与L²、积分OU方程齐全。漂移−R/τ及噪声√(2θc)/τ与(8.65)吻合；Gaussian第二参数为方差且因正参数toNNReal不截断。此定义是补充资格，不是原印逐字前提。"}, {"lean_decl": "MD.Ch08.pronyOU_covariance", "verdict": "PASS", "explanation": "全称量化P,W,R,c,τ,θ及非负t,s；hR已包含全部平稳资格。完整结论同时给出E R(t)=0及E[R(t+s)R(t)]=(θc/τ)e^(−s/τ)，不是只给单边不等式或仅s=0。该陈述数学正确；没有Printed/literal标识，不要求它保留无资格的错误断言。"}, {"lean_decl": "MD.Ch08.totalPronyRandomForce", "verdict": "PASS", "explanation": "任意自然数K与R:Fin K→ℝ→Ω→ℝ，在任意t、sample逐点有限求和。Fin K对应原书1至kmax的K个模式的重编号，K=0为自然空和扩展；未偷加独立性或总协方差结论。"}, {"lean_decl": "MD.Ch08.pronyOU_covariance_corrected", "verdict": "PASS", "explanation": "与前一定理完全相同的量词、hR、时间域及完整二联结论；通过引用前一定理复用补充资格，并非另行证明更强无条件断言。"}]}
- 原文版分项：原印无初态资格的(8.66)待导师
- 修正版分项：pronyOU_covariance及_corrected均为[EXTRA]平稳初态版本，签名网站PASS；非无条件原印定理
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 26. MD-8.8-AndersenHamiltonianPrinted

- source_id：MD-8.8-AndersenHamiltonianPrinted；印刷页 380 / PDF页 401。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> Ĥ=Σᵢ|p̄ᵢ|²/(2mᵢV^{2/3})+Ū(q̄;V)+p_V²/(2μ_V)+PV, and ρ_NPT=√(β/(2πμ_V))∫exp(−βĤ)dp_V. (8.73).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页401。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。；[ERRATUM?] 保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意Z>0。
- 反例或理由：固定其余状态基础能量A时，Printed积分严格等于exp(−βA)。例如A=0时为1，而取正配分常数Z=2的归一权应为1/2；两者相差Z因子。
- 原文版 Lean 名称及状态：`MD.Ch08.andersenHamiltonian`：定义；`MD.Ch08.andersenMarginalPrinted`：定义；`MD.Ch08.andersenGaussian_marginal`：未证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.andersenMarginal_corrected`：定义
- 修正或补充前提：m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。；[EXTRA] andersenMarginal_corrected本身仅为除以Z的函数定义；要解释为概率密度须另证明Z等于正确域上正有限配分积分。；[EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。
- 待人工核查点：保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意Z>0。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；相对归一NPT密度缺配分因子
- 修正版分项：原送审Gaussian消元及除Z权重合理；正有限配分积分未保证，不宣称概率归一
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 27. MD-8.8.1-PistonHamiltonianSubfield

- source_id：MD-8.8.1-PistonHamiltonianSubfield；印刷页 381 / PDF页 402。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> ρ₁=φ₁(pᵀM⁻¹p/2+U(q))ψ(V,ξ,η) is stated to be stationary for the Liouvillian of the printed vector field (p,−∇U,0,0,0). [ERRATUM?] For general mass the Hamiltonian field should have first component M⁻¹p; the Lean stationarity target uses this corrected field.

- 原页核对：32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页402。
- 问题所在：[ERRATUM?] 原页先给q̇=M⁻¹p+ηq，随后驻定子场却明确印为(p,−∇U,0,0,0)。对于一般质量及所印能量，二者不一致；不可将原印首分量静默改为M⁻¹p。；[EXTRA] Lean只陈述全实坐标空间上的局部加权通量散度为零；φ、ψ可取有符号光滑权，未要求非负、归一化或V≥0上的可积性。因此不能解释为已构造概率平稳分布或全局保测流。；已目视核对原页PDF402：原印场为(p,−∇U,0,0,0)，一般质量的修正场为(M⁻¹p,−∇U,0,0,0)。原印p与本页q̇=M⁻¹p+ηq不一致，修正版仅给局部通量散度目标。
- 反例或理由：{"scope": "反驳一般质量下原印场的驻定声称，不反驳Printed定义的忠实性或Lean修正版。", "example": "取n=1，invm=1/2即m=2，U(q,V)=q²/2，φ(h)=exp(−h)，ψ(V,ξ,η)=exp(−V²−ξ²−η²)。H=p²/4+q²/2，原印F=(p,−q,0,0,0)散度零，但F·∇H=qp/2。因此div(φ(H)ψ F)=−(qp/2)exp(−H)ψ。在q=p=V=1、ξ=η=0时为−exp(−7/4)/2≠0；V位于正体积域内部。", "validation": "解析链式法则反例；ψ在[0,∞)×ℝ²上可积，归一化常数不影响非零结论。"}
- 原文版 Lean 名称及状态：`MD.Ch08.pistonHamiltonianPart`：定义；`MD.Ch08.pistonHamiltonianWeight_stationary`：未证；`MD.Ch08.pistonHamiltonianPartPrinted`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.pistonHamiltonianPart_corrected`：定义
- 修正或补充前提：[EXTRA] invm:Fin n→ℝ表示固定对角逆质量系数；Lean全称允许任意实系数，不要求正性，散度恒等式仍成立。；[EXTRA] U:(Vec n×ℝ)→ℝ为C²，φ:ℝ→ℝ和ψ:Vec 3→ℝ为C¹；U允许依赖作为冻结参数的V。；[EXTRA] 状态为((q,p),(V,ξ,η))，后三坐标在子场下全为零。Lean仅陈述局部通量散度零，不要求权非负、归一或可积，也不证明全局流或边界性质。；[ERRATUM?] 原印子场首分量p，仅单位质量等特殊情形与所印能量一致；修正版采用M⁻¹p。
- 待人工核查点：保留原印p场与Printed定义并显式[ERRATUM?]；人工确认是漏印M⁻¹还是单位质量约定。一般对角质量使用现有_corrected及stationary定理；明确权的局部驻定与概率分布的区别，并修正摘要和来源核对记录。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：NEEDS_HUMAN。{"overall": "原印场的一般质量疑误判NEEDS_HUMAN；Printed定义忠实、修正场及其散度恒等式签名PASS。未依据sorry否定签名。", "objects_and_domains": "n为任意自然数；Vec n=Fin n→ℝ，Phase n=Vec n×Vec n，PistonState n=Phase n×Vec 3。z任意，无V≥0限制；x.2 0是V，ξ、η为另外两冻结坐标。invm为常实对角系数；质量正性对恒等式不必要。", "declarations": [{"lean_decl": "MD.Ch08.pistonHamiltonianPart", "verdict": "PASS", "explanation": "场为((invm·p,−∇_q U(q,V)),0)，梯度按标准坐标方向fderiv定义，后三分量为零。与一般对角质量的Hamiltonian修正一致，但不能叫原印逐字场。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianWeight_stationary", "verdict": "PASS", "explanation": "对任意invm、C²的U、C¹的φ及ψ和任意z，全结论为div([φ(H)ψ]F)(z)=0，其中H=Σ invm_i p_i²/2+U(q,V)，div为完整状态空间上导数线性映射的trace。F自身散度为零，F·∇H=Σ(U_qi invm_i p_i−invm_i p_i U_qi)=0，ψ只依赖冻结坐标故沿场导数零。U依赖V不会引入额外通量项，因为V方向场分量恒为零。结论不要求质量正性或权可积，亦不推出概率归一化。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianPartPrinted", "verdict": "PASS", "explanation": "完整场((p,−∇_q U(q,V)),0)与原印(p,−∇U,0,0,0)逐分量一致；没有附带错误的驻定定理，故原印疑误不构成本定义忠实性的FAIL。"}, {"lean_decl": "MD.Ch08.pistonHamiltonianPart_corrected", "verdict": "PASS", "explanation": "定义展开即pistonHamiltonianPart invm U z，明确把首分量修正为对角M⁻¹p，其余力及冻结坐标正确。"}]}
- 原文版分项：Printed的p场忠实性PASS；一般质量下原驻定声称疑误待导师
- 修正版分项：M⁻¹p修正场及局部散度目标签名网站PASS；非概率平稳分布或全局保测流
- 当前状态：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。

## 28. MD-8.8.1-PistonThermostatWeightPrinted

- source_id：MD-8.8.1-PistonThermostatWeightPrinted；印刷页 381 / PDF页 402。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> The book prints ρ₂=exp(−β[pᵀM⁻¹p+μ_Tξ²/2])ψ₂(q,η,V) for ṗ=−ξp, ξ̇=(pᵀM⁻¹p−N_dk_BT)/μ_T.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页402。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。；保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。
- 反例或理由：取n=1、invm=β=QT=1、p=ξ=1、ψ₂=1。原印ρ=exp(−p²−ξ²/2)，div(ρF)=ρ≠0；一般残差是βξKρ。修正ρ=exp(−(p²+ξ²)/2)的散度为0。
- 原文版 Lean 名称及状态：`MD.Ch08.pistonThermostatPart`：定义；`MD.Ch08.pistonRho2Printed`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.pistonRho2_corrected`：定义；`MD.Ch08.pistonRho2_stationary_corrected`：未证
- 修正或补充前提：仅取ψ₂=1的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。
- 待人工核查点：保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；原印动能缺1/2
- 修正版分项：原送审恢复1/2的_corrected及局部驻定签名PASS，ψ₂=1
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 29. MD-8.9.1-DPDMassOrderPrinted

- source_id：MD-8.9.1-DPDMassOrderPrinted；印刷页 389 / PDF页 410。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> For dp=−∇Udt−Δ(q)pdt+Σ(q)dW, the book gives Δ=M⁻¹ΣΣᵀ/(2k_BT).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。；保留Printed等式；[ERRATUM?]记录一般质量情形改为ΣΣᵀM⁻¹/(2kBT)，标注等质量或交换条件下两者相同。
- 反例或理由：M⁻¹=diag(1,1/2)，C=BBᵀ=[[1,−1],[−1,1]]（B=(1,−1)ᵀ）。M⁻¹C=[[1,−1],[−1/2,1/2]]，CM⁻¹=[[1,−1/2],[−1,1/2]]。原印Γ使ΓM+MΓᵀ的非对角元为−5/(4θ)，而C/θ为−1/θ，故不满足所需动量协方差θM的OU平衡。
- 原文版 Lean 名称及状态：`MD.Ch08.dpdMatrixFDPrinted`：定义；`MD.Ch08.dpdMassOrder_counterexample`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.dpdMatrixFD_corrected`：定义
- 修正或补充前提：M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- 待人工核查点：保留Printed等式；[ERRATUM?]记录一般质量情形改为ΣΣᵀM⁻¹/(2kBT)，标注等质量或交换条件下两者相同。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；一般不等质量的乘法次序错误
- 修正版分项：原送审右乘M⁻¹修正版与不交换反例PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 30. MD-8.9.2-DPDPairGeneratorPrinted

- source_id：MD-8.9.2-DPDPairGeneratorPrinted；印刷页 392 / PDF页 413。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> (8.100) prints L_Oij=[−γωᴰu+(σ²/2)(ωᴿ)² e·(∂pi−∂pj)] e·∂pi for each unordered pair i<j.

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页413。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。
- 反例或理由：符号反例：N=2,d=1,i=0,j=1,e=1，m_i=m_j=1，γ=wd=1，p_i=1,p_j=0；取 f(p)=p_i+p_j。原印算子作用于 f 得 −1（二阶项为0），修正版得0。固定总动量叶上的单对动力学必须湮灭总动量函数，故原印单对解释有误；这不否定有序双和(8.97)。
- 原文版 Lean 名称及状态：`MD.Ch08.pairDerivative`：定义；`MD.Ch08.dpdPairGeneratorPrinted`：定义。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.dpdPairGenerator_corrected`：定义
- 修正或补充前提：本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
- 待人工核查点：保留原文和 Printed 定义；显式标 [ERRATUM?] 指向最外层 ∂pi，另列 corrected 使用 D_ij= e·(∂pi−∂pj)。不得把 Printed 定义改成修正版后仍称逐字忠实。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；单对解释下最外层∂pi不保总动量
- 修正版分项：原送审改用Dij的_corrected签名PASS；不据此否定完整有序双和
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 31. MD-8.9.2-DPDPairOUUpdate

- source_id：MD-8.9.2-DPDPairOUUpdate；印刷页 393 / PDF页 414。
- 类别：原书表述疑误待导师
- 原文引文及公式（原书全文另逐字保留）：

> mred=mi mj/(mi+mj); mred du=Fdt−γωᴰu dt+σωᴿdW. a=γωᴰ/mred. u(t)=F/(a mred)+exp(−at)(u0−F/(a mred))+√[θ(1−exp(−2at))/mred]R. Δu=u(t)−u0; pi+=mred Δu e, pj−=mred Δu e. (8.103)–(8.107).

- 原页核对：原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页414。本轮不虚称重新目视。
- 问题所在：已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。
- 反例或理由：边界示例（不是正率域反例）：mr=F=θ=t=1，a=u=R=0。通常实数原式含 1/0 未定义；Lean 总化除法使 dpdPairOUPrinted 得0，而零率强迫 ODE 的终值及 corrected 值均为1。物理截断外若同时 F=0 则此强迫示例不适用，但原式零分母仍须分支约定。
- 原文版 Lean 名称及状态：`MD.Ch08.reducedMass8`：定义；`MD.Ch08.reducedMass8_pos`：已证；`MD.Ch08.dpdPairOUPrinted`：定义；`MD.Ch08.dpdPairOU_zeroRate`：已证；`MD.Ch08.dpdPairMomentumStep`：定义；`MD.Ch08.dpdPairMomentumStep_conserves`：已证。Printed忠实性与数学真值分开，疑误原印命题不作为有效定理依赖。
- 修正版 Lean 名称、改动内容、证明状态：`MD.Ch08.dpdPairOU_corrected`：定义
- 修正或补充前提：原印转移律要求mr>0、a>0、θ>0、t≥0及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。；单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。；[EXTRA] 零率分支仅用于涨落耗散使噪声同时退化的情形；不用于任意独立非零扩散的零漂移OU。物理转移需正约化质量、正温度、a,t≥0及独立标准正态R。
- 待人工核查点：保留 Printed，标 [ERRATUM?]/域限制 a>0；a=0 的适用场景使用已给 corrected，并明确 FDT 下噪声同时退化，不能把该分支用于任意独立的非零扩散零漂移 OU。
- 导师选项：保留原印供比对，采用单列修正版或明确限定解释；确认原书是否另有约定。
- 网站首轮结论：NEEDS_HUMAN
- 网站复审结论：本条未参加32号对应复审；原首轮NEEDS_HUMAN意见保留。
- 原文版分项：Printed忠实性PASS；零率原式通常未定义
- 修正版分项：原送审正率改写与FDT噪声同时退化的零率_corrected签名PASS
- 当前状态：原书疑误待导师；原送审正确版本分项保留。

## 覆盖缺口

- MD-8.1.2.1-NPEquations：正对角逆质量、N_d=n下的NP四漂移分量；n/β版命名能量差修正；有效域另列。未绑定初始能量、未证明Hamilton梯度关系。；[ERRATUM?] npDeltaN_corrected选择(8.9)展开中的n/β版本；与上方原印(n+1)/β版H_N区分。应用时EN应取该n版能量在初值处的值；声明并未绑定初值。；gradient用fderiv定义，未假设U可微；欲解释为经典力场须另加适当可微性。未证明Hamilton方程。；[EXTRA] 使用npField作为经典NP方程必须另带npValidDomain invm β Q z、U可微及EN=H_N^(n)(z₀)；这些条件没有被npField总函数自动强制。原页ΔH_N指代冲突未消除。
- MD-8.1.2.1-NPShadowDensity：三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。；[EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。
- MD-8.2-GeneralThermostat：常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。
- MD-8.2.1-Examples81and82：原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。
- MD-8.2.1-Proposition81：两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。；两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。
- MD-8.2.2-NHChains：任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。；链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
- MD-8.3-ArrheniusRate：Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。；A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。
- MD-8.4-AdditiveThermostatSDE：已组装的对角物理质量、交换涨落耗散特例：同一n+k维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。；未要求或证明确定性Φ,g部分保权；未构造矩阵平方根，未证明完整解存在、唯一、不变分布或遍历性。
- MD-8.4-Proposition82：所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。；Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- MD-8.4.1-NHL：仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。；[EXTRA] M⁻¹=diag(invm)，N_d=n；invm_i,β,Q,γ均正；β⁻¹=k_BT，Q=μ。一般非对角物理质量未覆盖。；harmonicPotential对任意实方阵A定义qᵀAq/2；没有在该def中要求A对称正定，也未把isNHLSolution绑定到该二次势或M=I。；不含原页定理8.1、特征值互异、D的模态排除及Hörmander/遍历性结论；不得由本条声明推断这些性质。；[ERRATUM?] 正确重缩放为q̃=M¹ᐟ²q、p̃=M⁻¹ᐟ²p；Ũ(q̃)=U(M⁻¹ᐟ²q̃)，二次势矩阵变为M⁻¹ᐟ²AM⁻¹ᐟ²。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。
- MD-8.4.1-Theorem81：所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。
- MD-8.4.2-NHLTimestep：实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。；R_n独立标准正态；h≥0、β,Q>0、γ≥0用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。
- MD-8.4.1-NHLWeakStationary：归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。
- MD-8.4.3-PreEquilibriumMeans：任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。
- MD-8.4.4-VelocityRescaling：实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。
- MD-8.4.4-RescalingStationary：闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。
- MD-8.4.5-ThermostatEfficiency：γ>0、θ,Q>0、N>0用于物理解释；一般VR的O(N)给出确切渐近性质定义，没有声称任意Φ族满足它。
- MD-8.5-SLSHormander：单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。
- MD-8.5-SLSLeapfrog：原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。；本条仅定义半kick–drift–半kick、逐坐标场及两种约化场；OU耦合、体积保持、二阶不变分布误差、精确求积与坐标变换定理均未形式化。
- MD-8.6-IsokineticProjector：实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。
- MD-8.6-IsokineticGibbsShell：动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。
- MD-8.6.1-SINWeightPrinted：原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。
- MD-8.6.2-SINHarmonic：谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。
- MD-8.6.2-SINProjectedBracketsPrinted：本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
- MD-8.6.2-SINThirdBracketPrinted：ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
- MD-8.6.2-SINBracketRank：θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
- MD-8.6.2-SINLyapunov：局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。；仅覆盖生成元恒等式与约束界；局部计算尚有sorry，此项不据此判签名FAIL。未形式化遍历性的全局条件或充分性。
- MD-8.6.3-SINForceSplitting：五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。
- MD-8.6.3-SINRAlgorithm：原印算法的阶段顺序与步长；不声称构造了各非线性子流。
- MD-8.7-GLEFluctuationDissipationPrinted：修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- MD-8.7-PronyKernel：正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。
- MD-8.7.1-PronyOUStationarity：[EXTRA] 这里没有对多个模式的W作联合独立假设；totalPronyRandomForce仅为有限和定义，不声称总协方差公式。；[EXTRA] t,s≥0；totalPronyRandomForce的求和为k∈Fin K（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。
- MD-8.8-NPTDensity：三维N粒子时n=3N；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。
- MD-8.8-AndersenHamiltonianPrinted：[EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。
- MD-8.8.1-PistonReducedPDE：只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。
- MD-8.9.1-DPDIntegralSystem：选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。
- MD-8.9.1-DPDMassOrderPrinted：M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- MD-8.9.2-DPDVelocityVerlet：尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。
- MD-8.9.2-DPDSplitGenerator：采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。
- MD-8.9.2-DPDPairGeneratorPrinted：本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
- MD-8.9.2-DPDPairOUUpdate：单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。
- MD-8.9.4-PairwiseNHLSDE：未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。
- MD-8.9.4-PairwiseNHLGenerator：没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。
- MD-8.10-BerendsenRelaxation：只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。
