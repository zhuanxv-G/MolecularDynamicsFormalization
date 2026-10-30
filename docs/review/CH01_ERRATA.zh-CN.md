# 第1章原书疑误与双版本审阅单

教材：B. Leimkuhler 与 C. Matthews，Molecular Dynamics: With Deterministic and Stochastic Numerical Methods，Springer，2015，第1章正文。
页码以工作区原PDF的1起始物理页为准：本章这些页面PDF页＝印刷页＋23。本文完整摘录对应句/式，附问题、理由和工作修正版，可单独交给核查人；不是已获作者或导师批准的正式勘误。
Lean 4.34.0 / Mathlib固定修订5ed2965256430c3649e86755f9576b54eca72435。sorry表示尚未完成证明；编译通过只验证类型和已写证明。所有命名属于MD.Ch01；原文版占位不能作为修正版证明依据。
定义或定性叙述没有可伪造的证明义务：原公式定义/已证局部数学子句保留，完整经验句只作逐字文献记录；一般假字面定理保留sorry，不证。默认选项仅是本次并列展示的工作版本，全部须导师确认。

## 1. MD-1.1.1-LJRepulsion

- source\_id：MD-1.1.1-LJRepulsion；印刷页 10–11 / PDF页 33–34。
- 原文引文（逐字）：

> Because of the strongly repulsive character of short-ranged soft walls in molecular dynamics, i.e., the fact that $`\varphi_{\mathrm{LJ}}`$ tends rapidly to positive infinity as $`r\to0`$, the atoms remain well separated in long simulations. The singularity at $`r=0`$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.

- 问题所在：有限能量的精确轨道和长时间数值模拟的经验频率是不同命题；缺算法、步长、时间窗和概率模型。
- 反例或理由：数值积分器若跨越势垒，势在0附近发散不能单独保证离散轨迹无碰撞；rarely无概率空间无法判定。
- 原文版 Lean 名称及状态：`MD.Ch01.lj_repulsion`；原文定义/已证数学子句保留；经验或文字歧义未当作已证命题。
- 修正版 Lean 名称、改动内容、证明状态：保留已证单侧极限；把可严格陈述的内容写成任意有限能级对应正距离屏障，不声称数值模拟rarely的概率。；`MD.Ch01.lj_repulsion_corrected`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“保留已证单侧极限；把可严格陈述的内容写成任意有限能级对应正距离屏障，不声称数值模拟rarely的概率。”是否可作为勘误。
- 导师选项：定性登记 / 指定数学模型；我们默认采用“定性登记”，待确认。
- 说明：已证原数学子句`lj_repulsion`仅为LJ单侧极限；原句的long simulations / rarely仍未数学化，不报告为已证明。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.lj_repulsion_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

## 2. MD-1.2-RadialLJForceLiteral

- source\_id：MD-1.2-RadialLJForceLiteral；印刷页 21 / PDF页 44。
- 原文引文（逐字）：

> The equations of motion are, for $`i=1,2,\ldots,N`$, using the chain rule,

$$
m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j) =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](\boldsymbol q_i-\boldsymbol q_j).
$$



- 问题所在：Newton力为−∇U；印刷式把径向势梯度当成力，两个等号均反号。
- 反例或理由：N=2、m=ε=σ=1，q₀=0、q₁=e₁。φ′(1)=−24，真实F₀=−24e₁，原书右端却为+24e₁。
- 原文版 Lean 名称及状态：`MD.Ch01.radial_lj_force_literal`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：第一式补负梯度负号，第二式外系数由−24ε/σ改为+24ε/σ；其余对象和量词不变。；`MD.Ch01.radial_lj_force_literal_corrected`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“第一式补负梯度负号，第二式外系数由−24ε/σ改为+24ε/σ；其余对象和量词不变。”是否可作为勘误。
- 导师选项：按负梯度符号勘误 / 仅保留原文疑误；我们默认采用“按负梯度符号勘误”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.radial_lj_force_literal_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 3. MD-1.4-ConvexLegendre

- source\_id：MD-1.4-ConvexLegendre；印刷页 24 / PDF页 47。
- 原文引文（逐字）：

> Abstractly, a Legendre transformation of a given convex function $`g=g(\boldsymbol\xi):\mathbb R^m\to\mathbb R`$ is a new function $`\widetilde g=\widetilde g(\boldsymbol\eta):\mathbb R^m\to\mathbb R`$ defined by

$$
\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),
$$



- 问题所在：凸性不能保证共轭函数每一点有限；实数sSup在无上界时的总化值不能充当真实上确界。
- 反例或理由：一维g(x)=0、η=1时supₓ x=+∞，不存在实数上确界。
- 原文版 Lean 名称及状态：`MD.Ch01.legendreTransform_literal`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：新增原书“任意凸函数的变换处处实值”的literal陈述；默认EReal扩展实数，并给有界时实值备选。；`MD.Ch01.legendreTransform_corrected`：定义已完成，无定理证明义务；`MD.Ch01.legendreTransform_corrected_b`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“新增原书“任意凸函数的变换处处实值”的literal陈述；默认EReal扩展实数，并给有界时实值备选。”是否可作为勘误。
- 导师选项：EReal推广 / 实值加有界性；我们默认采用“EReal推广”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.legendreTransform_corrected`=PASS；`MD.Ch01.legendreTransform_corrected_b`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 4. MD-1.5.2-TorusDense

- source\_id：MD-1.5.2-TorusDense；印刷页 30 / PDF页 53。
- 原文引文（逐字）：

> in the latter case the paths do not “close up” but instead we see the curve gradually fills in the surface of the torus.

- 问题所在：高维准周期运动可能只在真子环面稠密；无正周期不等于全维无共振。
- 反例或理由：三维频率(1,√2,1+√2)无公共正周期，却满足θ₃−θ₁−θ₂常数，轨道局限于二维子环面。
- 原文版 Lean 名称及状态：`MD.Ch01.torusdense_literal`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：另补原句“非周期即充满整个环面”的literal；修正版显式全整数无共振，原有带资格陈述不变。；`MD.Ch01.torusdense_corrected`：sorry；缺一般d维Kronecker稠密定理；不建设大型理论。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“另补原句“非周期即充满整个环面”的literal；修正版显式全整数无共振，原有带资格陈述不变。”是否可作为勘误。
- 导师选项：全维加无共振 / 子环面版本；我们默认采用“全维加无共振”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.torusdense_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 5. MD-1.5.2-LocalActionAngleReduction

- source\_id：MD-1.5.2-LocalActionAngleReduction；印刷页 30 / PDF页 53。
- 原文引文（逐字）：

> More generally, one finds occasional examples of nonlinear systems which possess as many independent first integrals as degrees of freedom (satisfying a certain “involution” condition); such systems may be reduced via a coordinate transformation to action-angle variables, i.e. they exhibit tori motion.

- 问题所在：独立对合第一积分只给局部正则结构；非紧共同水平集未必为环面。IsConnected含非空。
- 反例或理由：自由粒子H=p，水平集{p=c}≅ℝ，不紧，不同胚于圆S¹。
- 原文版 Lean 名称及状态：`MD.Ch01.local_action_angle_reduction_literal`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：原书无紧性资格的环面推断另记literal；默认紧、连通、非空、正则共同水平集，保留局部正则坐标与全局环面结论。；`MD.Ch01.local_action_angle_reduction_corrected`：sorry；缺一般Liouville–Arnold与局部辛坐标理论；不建设大型理论。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“原书无紧性资格的环面推断另记literal；默认紧、连通、非空、正则共同水平集，保留局部正则坐标与全局环面结论。”是否可作为勘误。
- 导师选项：批准明确资格 / 保留字面疑误待定；我们默认采用“批准明确资格”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.local_action_angle_reduction_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 6. MD-1.5.3-HartmanGrobmanLiteral

- source\_id：MD-1.5.3-HartmanGrobmanLiteral；印刷页 31–32 / PDF页 54–55。
- 原文引文（逐字）：

> then one can infer that the solutions of the nonlinear and linear systems are in fact topologically conjugate: if $`\boldsymbol z`$ is the solution of the nonlinear system and $`\delta\boldsymbol z`$ is the solution of the linear system, then there is a smooth, invertible map $`\boldsymbol\Phi`$ of $`\mathbb R^m`$ defined in a neighborhood of the origin such that

$$
\boldsymbol z(t)=\boldsymbol z^*+\boldsymbol\Phi(\delta\boldsymbol z(t)).
$$


> This is referred to as the Hartman-Grobman theorem (for more discussion see [177], where this result is referred to as the “Linearization Theorem”; a proof may be found in [362]).

- 问题所在：C¹双曲系统的一般Hartman–Grobman结论为拓扑共轭，不保证C∞线性化。
- 反例或理由：一维f(x)=x+x|x|为C¹但非C²的双曲向量场。若有C∞微分同胚线性化，其推前公式将使f光滑，矛盾；即使f光滑，共振仍可阻碍光滑线性化。
- 原文版 Lean 名称及状态：`MD.Ch01.hartmangrobmanliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：C∞可逆坐标替换改为连续互逆局部同胚；保留零点、邻域与留域期间共轭公式。；`MD.Ch01.hartmangrobmanliteral_corrected`：sorry；缺一般Hartman–Grobman局部拓扑共轭；不建设大型理论。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“C∞可逆坐标替换改为连续互逆局部同胚；保留零点、邻域与留域期间共轭公式。”是否可作为勘误。
- 导师选项：同胚勘误 / 光滑加条件；我们默认采用“同胚勘误”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.hartmangrobmanliteral_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 7. MD-1.5.3-HyperbolicStabilityTransfer

- source\_id：MD-1.5.3-HyperbolicStabilityTransfer；印刷页 32 / PDF页 55。
- 原文引文（逐字）：

> The Hartman-Grobman theorem clearly implies that the stability of a given hyperbolic equilibrium point $`\boldsymbol z^*`$ of a nonlinear system can be inferred from the stability of the origin for the linearization of the system around $`\boldsymbol z^*`$.

- 问题所在：结论本身是标准推论，但原证明链不能依赖原书过强的光滑共轭。
- 反例或理由：拓扑同胚在平衡点邻域的连续性及逆连续性已足以传递ε/δ稳定性；不需要C∞共轭。
- 原文版 Lean 名称及状态：`MD.Ch01.hyperbolicstabilitytransfer`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：显式独立登记以拓扑共轭为依据的稳定性转移，不调用光滑literal。；`MD.Ch01.hyperbolicstabilitytransfer_corrected`：sorry；缺一般拓扑共轭及留域稳定性转移桥接；不依赖literal。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“显式独立登记以拓扑共轭为依据的稳定性转移，不调用光滑literal。”是否可作为勘误。
- 导师选项：采用拓扑共轭推论 / 等待导师核对；我们默认采用“采用拓扑共轭推论”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=PASS；修正版：`MD.Ch01.hyperbolicstabilitytransfer_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 8. MD-1.6-RegularLatticeMinimizerLiteral

- source\_id：MD-1.6-RegularLatticeMinimizerLiteral；印刷页 34 / PDF页 57。
- 原文引文（逐字）：

> An obvious benefit of using periodic boundary conditions is that, with a uniform pair potential, the energy minimizers are points of a regular lattice; with confining potentials this is unlikely to be the case.

- 问题所在：任意uniform pair potential不保证晶格最小；还缺排序、盒域和势的凸性等资格。
- 反例或理由：φ≡0时所有配置都是最小，包括不等间距；原字面量化还接受重合配置。修正版严格凸正间距排除这些反例。
- 原文版 Lean 名称及状态：`MD.Ch01.regularlatticeminimizerliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：改为一维周期有序粒子的正间距和L固定、严格凸最近邻势；Jensen给等间距最小且仅等间距等号。；`MD.Ch01.regularlatticeminimizerliteral_corrected`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“改为一维周期有序粒子的正间距和L固定、严格凸最近邻势；Jensen给等间距最小且仅等间距等号。”是否可作为勘误。
- 导师选项：批准严格凸正间距版本 / 保留字面疑误；我们默认采用“批准严格凸正间距版本”，待确认。
- Lean反例：`MD.Ch01.regularlatticeminimizerliteral_counterexample`（已证）。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.regularlatticeminimizerliteral_corrected`=PASS；反例：`MD.Ch01.regularlatticeminimizerliteral_counterexample`=PASS。PASS仅指网站签名语义审校，证明状态另列。

## 9. MD-1.6.1-MinimumGradientZero

- source\_id：MD-1.6.1-MinimumGradientZero；印刷页 36–37 / PDF页 59–60。
- 原文引文（逐字）：

> Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where

$$
\nabla U=0,
$$


> which gives in general a nonlinear system of $`N_c`$ equations in $`N_c`$ unknowns to be solved for the position vector $`\boldsymbol q^*`$ associated to mechanical equilibrium.

- 问题所在：约束边界极小一般不能推出全梯度为零；原上下文若含边界须区分可行方向。
- 反例或理由：U(x)=x在闭半轴[0,∞)的0为约束最小，但U′(0)=1。现有Lean用IsLocalMin，已限制为内点意义。
- 原文版 Lean 名称及状态：`MD.Ch01.minimumgradientzero`；原文定义/已证数学子句保留；经验或文字歧义未当作已证命题。
- 修正版 Lean 名称、改动内容、证明状态：显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。；`MD.Ch01.minimumgradientzero_corrected`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。”是否可作为勘误。
- 导师选项：无约束内点版本 / 另立约束可行方向版本；我们默认采用“无约束内点版本”，待确认。
- 网站复审结论：原文版忠实性=原文引文保留；现有Lean为限定解释，非无条件原句；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.minimumgradientzero_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

## 10. MD-1.6.1-MinimumHessianLiteral

- source\_id：MD-1.6.1-MinimumHessianLiteral；印刷页 37 / PDF页 60。
- 原文引文（逐字）：

> At the minimum of the potential energy, $`U''`$ is a positive definite symmetric matrix.

- 问题所在：局部极小只能推出Hessian半正定，严格极小也不能保证非退化。
- 反例或理由：U(x)=x⁴在0严格极小，但U″(0)=0；Lean反例核验局部极小与零二阶导。
- 原文版 Lean 名称及状态：`MD.Ch01.minimumhessianliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：正定改为半正定；仍保留Hessian对称性及所有非零方向。；`MD.Ch01.minimumhessianliteral_corrected`：sorry；缺一般C²二阶必要条件及Hessian对称/双线性形式桥接；原文不证。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“正定改为半正定；仍保留Hessian对称性及所有非零方向。”是否可作为勘误。
- 导师选项：半正定勘误 / 增加Hessian非退化后保留正定；我们默认采用“半正定勘误”，待确认。
- Lean反例：`MD.Ch01.minimumhessianliteral_counterexample`（已证）。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.minimumhessianliteral_corrected`=PASS；反例：`MD.Ch01.minimumhessianliteral_counterexample`=PASS。PASS仅指网站签名语义审校，证明状态另列。

## 11. MD-1.7-ConstantRotationLiteral

- source\_id：MD-1.7-ConstantRotationLiteral；印刷页 39 / PDF页 62。
- 原文引文（逐字）：

> This means that the system will translate and rotate at a constant rate in time.

- 问题所在：守恒的是角动量，转动惯量或半径可变时角速度可变。
- 反例或理由：r(t)=√(1+t²)、θ(t)=arctan t、ℓ=1，r²θ′=1而θ′(0)=1、θ′(1)=1/2。
- 原文版 Lean 名称及状态：`MD.Ch01.constantrotationliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。；`MD.Ch01.constantrotationliteral_corrected_a`：已证；`MD.Ch01.constantrotationliteral_corrected_b`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。”是否可作为勘误。
- 导师选项：恒定半径下恒角速 / 角动量守恒与变角速；我们默认采用“角动量守恒与变角速”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.constantrotationliteral_corrected_a`=PASS；`MD.Ch01.constantrotationliteral_corrected_b`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 12. MD-1.7-TrimerEscapeLiteral

- source\_id：MD-1.7-TrimerEscapeLiteral；印刷页 40 / PDF页 63。
- 原文引文（逐字）：

> (When $`E\gt 0`$, the bodies eventually escape to infinity; $`E\lt -3`$ is not attainable.)

- 问题所在：总能量正并不直接推出每个粒子相对固定原点趋于无穷；系统分离与逐粒子逃逸不同。
- 反例或理由：对称共线运动q₁=−q₂、q₃=0中，第三粒子因对称力抵消可始终静止；向外大初速产生正能量。候选系统分离命题仍需独立散射论核查。
- 原文版 Lean 名称及状态：`MD.Ch01.trimerescapeliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。；`MD.Ch01.trimerescapeliteral_corrected`：sorry；缺全局三体散射/分离理论；候选修正也尚未经导师确认。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。”是否可作为勘误。
- 导师选项：逐粒子原句登记错误 / 另立系统分离命题待审；我们默认采用“另立系统分离命题待审”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.trimerescapeliteral_corrected`=NEEDS\_HUMAN；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 13. MD-1.7.1-TransitivityErgodicityLiteral

- source\_id：MD-1.7.1-TransitivityErgodicityLiteral；印刷页 42 / PDF页 65。
- 原文引文（逐字）：

> We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.

- 问题所在：拓扑传递依赖拓扑，遍历性依赖选定不变测度；一般不能直接等价。
- 反例或理由：原签名允许零测度：任意流对零测度均遍历，恒等流在ℝ上不拓扑传递。非零概率反例可取恒等流和单点Dirac测度。
- 原文版 Lean 名称及状态：`MD.Ch01.transitivityergodicityliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。 补C¹向量场资格，确保完整经典流的局部唯一性和流律。；`MD.Ch01.transitivityergodicityliteral_corrected`：sorry；缺由连续时间遍历性到满支撑正向拓扑传递的测度理论桥接。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。 补C¹向量场资格，确保完整经典流的局部唯一性和流律。”是否可作为勘误。
- 导师选项：仅保留疑误 / 另立满支撑测度下的单向结果；我们默认采用“另立满支撑测度下的单向结果”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.transitivityergodicityliteral_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 14. MD-1.7.2-FlowJacobianLiteral

- source\_id：MD-1.7.2-FlowJacobianLiteral；印刷页 44 / PDF页 67。
- 原文引文（逐字）：

> Let a dynamical system $`\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)`$ be given in $`\mathbb R^m`$ with flow map $`F_t:\mathbb R^m\to\mathbb R^m`$ which we assume to be continuously differentiable. Let $`\boldsymbol z(t,\boldsymbol\xi)`$ represent the solution of initial value problem

$$
\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi.
$$


> We then compute the $`m\times m`$ Jacobian matrix of $`F_t(\boldsymbol z(t,\boldsymbol\xi))`$:

$$
\boldsymbol W(t)=F_t'(\boldsymbol z(t,\boldsymbol\xi))=\frac{\partial F_t}{\partial\boldsymbol z}(\boldsymbol z(t,\boldsymbol\xi)).
$$



- 问题所在：对初值求导的Jacobian应在初值取值；把演化后位置再次代入是复合了不同取值点。
- 反例或理由：全局sin向量场的流，ξ=π/2、t=log2时DF\_t(ξ)=4/5，DF\_t(F\_tξ)=10/17。
- 原文版 Lean 名称及状态：`MD.Ch01.variationalMatrixLiteral`；原文定义/已证数学子句保留；经验或文字歧义未当作已证命题。
- 修正版 Lean 名称、改动内容、证明状态：DF\_t取值点从F\_t(ξ)改为初值ξ。；`MD.Ch01.variationalMatrixLiteral_corrected`：定义已完成，无定理证明义务。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“DF\_t取值点从F\_t(ξ)改为初值ξ。”是否可作为勘误。
- 导师选项：批准另立 / 保留字面疑误；我们默认采用“批准另立”，待确认。
- 定义项说明：原`variationalMatrixLiteral`保持原取值点，是精确定义；后续两条原文定理保留sorry。定义不需要也没有伪造sorry证明。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.variationalMatrixLiteral_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 15. MD-1.7.2-VariationalEquationLiteral

- source\_id：MD-1.7.2-VariationalEquationLiteral；印刷页 44–45 / PDF页 67–68。
- 原文引文（逐字）：

> Differentiating $`\boldsymbol W(t)`$ with respect to $`t`$ and using the differential equation and the chain rule, we have

$$
\frac{\mathrm d}{\mathrm dt}\boldsymbol W(t)=\boldsymbol f'(\boldsymbol z(t,\boldsymbol\xi))\boldsymbol W(t).\tag{1.10}
$$


> The system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $`\mathrm d\boldsymbol z/\mathrm dt=\boldsymbol f(\boldsymbol z)`$.

- 问题所在：原W的取值点多复合一次F\_t，时间微分产生额外链式项，不满足标准变分方程。
- 反例或理由：同一全局sin流、ξ=π/2、t=log2：原W=10/17，W′=−198/289，但f′(F\_tξ)W=−102/289。
- 原文版 Lean 名称及状态：`MD.Ch01.variationalequationliteral`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：采用W(t)=DF\_t(ξ)，保留C¹向量场及真实流资格。；`MD.Ch01.variationalequationliteral_corrected`：sorry；缺一般非线性流对初值的可微依赖及参数/时间微分交换；常系数定理范围不足。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“采用W(t)=DF\_t(ξ)，保留C¹向量场及真实流资格。”是否可作为勘误。
- 导师选项：批准另立 / 保留字面疑误；我们默认采用“批准另立”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.variationalequationliteral_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 16. MD-1.7.2-NearbyTrajectoryLiteral

- source\_id：MD-1.7.2-NearbyTrajectoryLiteral；印刷页 45 / PDF页 68。
- 原文引文（逐字）：

> If we have two solutions started from nearby initial conditions $`\boldsymbol\xi,\hat{\boldsymbol\xi}`$, then their difference is approximated by the solution of the variational equations

$$
\boldsymbol z(t,\hat{\boldsymbol\xi})-\boldsymbol z(t,\boldsymbol\xi)\approx\boldsymbol W(t)(\hat{\boldsymbol\xi}-\boldsymbol\xi).
$$



- 问题所在：错误取值点的导数通常与真实DF\_t(ξ)不同，差额线性项不是小o。
- 反例或理由：同一sin流在指定点的两个导数4/5和10/17不相等；其差乘初值扰动保留一阶项。
- 原文版 Lean 名称及状态：`MD.Ch01.nearby_trajectory_literal`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：线性化在初值ξ处取DF\_t，固定t的余项为o(扰动)。；`MD.Ch01.nearby_trajectory_literal_corrected`：已证。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“线性化在初值ξ处取DF\_t，固定t的余项为o(扰动)。”是否可作为勘误。
- 导师选项：批准另立 / 保留字面疑误；我们默认采用“批准另立”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.nearby_trajectory_literal_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 17. MD-1.1.2-Yukawa

- source\_id：MD-1.1.2-Yukawa；印刷页 12 / PDF页 35。
- 原文引文（逐字）：

> More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $`\kappa`$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:

$$
\varphi_{ij}^{\mathrm{screened}}(r_{ij})=\frac{CQ_iQ_j}{\epsilon r_{ij}}e^{-\kappa r_{ij}}.
$$



- 问题所在：原文称κ为长度，但无量纲指数−κr通常要求κ为逆长度。Lean实数类型不携带量纲，此疑点必须文字核查。
- 反例或理由：长度单位L乘长度单位L得到L²，不能作为无量纲指数；κ=1/ℓ时两个修正版逐点一致。
- 原文版 Lean 名称及状态：`MD.Ch01.yukawaScreened`；原文定义/已证数学子句保留；经验或文字歧义未当作已证命题。
- 修正版 Lean 名称、改动内容、证明状态：a保留−κr但把κ解释为逆屏蔽长度；b若保留Debye length称谓则用−r/ℓ。正参数为物理域补充。；`MD.Ch01.yukawaScreened_corrected_a`：定义已完成，无定理证明义务；`MD.Ch01.yukawaScreened_corrected_b`：定义已完成，无定理证明义务。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“a保留−κr但把κ解释为逆屏蔽长度；b若保留Debye length称谓则用−r/ℓ。正参数为物理域补充。”是否可作为勘误。
- 导师选项：保留指数并改称逆长度 / 保留长度称谓并改指数；我们默认采用“保留指数并改称逆长度”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.yukawaScreened_corrected_a`=PASS；`MD.Ch01.yukawaScreened_corrected_b`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

## 18. MD-1.4-LegendreHamiltonian

- source\_id：MD-1.4-LegendreHamiltonian；印刷页 24 / PDF页 47。
- 原文引文（逐字）：

> If $`\boldsymbol{M}(\boldsymbol{q})`$ is invertible, the supremum is achieved precisely when

$$
\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p},
$$


> which gives the standard definition of the momentum vector $`\boldsymbol{p}`$ in terms of velocities,

$$
\boldsymbol{p}=\frac{\partial L}{\partial\dot{\boldsymbol{q}}}=\boldsymbol{M}(\boldsymbol{q})\dot{\boldsymbol{q}},
$$


> and, with $`\boldsymbol{v}=\boldsymbol{M}^{-1}(\boldsymbol{q})\boldsymbol{p}`$, the Legendre transformation results in a new function

$$
H(\boldsymbol{q},\boldsymbol{p})\stackrel{\mathrm{def}}{=}\boldsymbol{p}^TM(\boldsymbol{q})^{-1}\boldsymbol{p}/2+U(\boldsymbol{q}).
$$


> This is precisely the energy function, written in terms of positions and momenta.

- 问题所在：任意可逆矩阵不足以保证凹二次目标有最大值；需继承机械质量的对称正定背景。
- 反例或理由：一维M=−1、p=U=0时待取sup的目标为v²/2，无上界。
- 原文版 Lean 名称及状态：`MD.Ch01.hamiltonian_legendre_transform_literal`；sorry，不证。
- 修正版 Lean 名称、改动内容、证明状态：新增仅可逆的原文字面版；修正版继承正定质量背景并保留上界、精确上确界、唯一达到点、动量梯度与能量全部结论。；`MD.Ch01.hamiltonian_legendre_transform_corrected`：sorry；缺一般配置相关正定矩阵Legendre上确界及梯度桥接；不恢复大型理论。。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“新增仅可逆的原文字面版；修正版继承正定质量背景并保留上界、精确上确界、唯一达到点、动量梯度与能量全部结论。”是否可作为勘误。
- 导师选项：继承机械质量正定背景 / 只保留字面疑误；我们默认采用“继承机械质量正定背景”，待确认。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.hamiltonian_legendre_transform_corrected`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。PASS仅指网站签名语义审校，证明状态另列。

## 19. MD-1.4-PhaseSpace

- source\_id：MD-1.4-PhaseSpace；印刷页 25 / PDF页 48。
- 原文引文（逐字）：

> The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $`\mathbb R^3`$ is described by coordinates and positions, i.e., by a point in $`\mathbb R^{6N}`$.

- 问题所在：后句重复位置，疑为positions/momenta文字笔误；前句定义及R^{6N}支持位置×动量解释。
- 反例或理由：N粒子各有3N位置与3N动量坐标，合计6N；两个位置词不能说明第二半坐标的物理含义。
- 原文版 Lean 名称及状态：`MD.Ch01.finiteEnergyPhaseDomain`；原文定义/已证数学子句保留；经验或文字歧义未当作已证命题。
- 修正版 Lean 名称、改动内容、证明状态：有限能量位置×动量定义保留；把后句coordinates and positions按前句解释为位置与动量，并显式核验6N维。；`MD.Ch01.finiteEnergyPhaseDomain_corrected`：定义已完成，无定理证明义务。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“有限能量位置×动量定义保留；把后句coordinates and positions按前句解释为位置与动量，并显式核验6N维。”是否可作为勘误。
- 导师选项：依前句读作位置与动量 / 保留原词待核；我们默认采用“依前句读作位置与动量”，待确认。
- 网站复审结论：原文版忠实性=原文引文保留；现有Lean为限定解释，非无条件原句；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.finiteEnergyPhaseDomain_corrected`=PASS；`MD.Ch01.finiteEnergyPhaseDomain_corrected_dimension`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

## 20. MD-1.7-IsoscelesCoordinates

- source\_id：MD-1.7-IsoscelesCoordinates；印刷页 39 / PDF页 62。
- 原文引文（逐字）：

> Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,

$$
\boldsymbol q_1=\begin{bmatrix}x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\\2y/3\\0\end{bmatrix},
$$



- 问题所在：零平动、零角动量不强迫任意三角形等腰；必须额外选择对称初态及证明对称性保持。
- 反例或理由：取一个不等边三角形，平移使质心为零，并令全部初速度为零。总动量和角动量均为零，但三角形仍不等边。
- 原文版 Lean 名称及状态：`MD.Ch01.isoscelesCoordinates`；原文定义/已证数学子句保留；经验或文字歧义未当作已证命题。
- 修正版 Lean 名称、改动内容、证明状态：把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。；`MD.Ch01.isoscelesCoordinates_corrected`：定义已完成，无定理证明义务。
- 待人工核查点：请确认所摘句的上下文是否已提供所缺资格，核对反例是否落入作者意图；重点审查“把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。”是否可作为勘误。
- 导师选项：明确选择等腰对称子模型 / 另审一般约化资格；我们默认采用“明确选择等腰对称子模型”，待确认。
- 同页上下文原文（PDF62，排版换行合并，fi字形规范化）：

> By a judicious choice of initial conditions, the center of mass can be kept at the origin and the net rotation removed. This corresponds to a symmetric configuration which is termed the isosceles three body problem (i.e., at all times the atoms are the vertices of an isosceles triangle).

- 同页上下文另请核对：在提出等腰坐标前，书中由去掉平动/旋转自由度过渡到对称配置；公式本身正确，疑点在此前过渡，不是矩阵三行数值。
- 网站复审结论：原文版忠实性=PASS；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.isoscelesCoordinates_corrected`=PASS；`MD.Ch01.isoscelesCoordinates_corrected_center`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

## 21. MD-1.6-PeriodicImages

- source\_id：MD-1.6-PeriodicImages；印刷页 35 / PDF页 58。
- 原文引文（逐字）：

> periodic boundary conditions involve an extended potential energy of the form

$$
U^{\mathrm{pbc}}(\boldsymbol q)=\sum_{klm}\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{ij}(\boldsymbol q_i,\boldsymbol q_j+k\boldsymbol v_1+l\boldsymbol v_2+m\boldsymbol v_3),
$$


> where $`k,l,m`$ run over $`-1,0,1`$ (in case interactions are restricted to the simulation cell and its immediate neighboring copies), and $`\boldsymbol v_i^T=(L\boldsymbol e_i^T,L\boldsymbol e_i^T,\ldots,L\boldsymbol e_i^T)`$, $`i=1,2,3`$, where $`\boldsymbol e_i`$ is the $`i`$th Euclidean basis vector in $`\mathbb R^3`$.

- 问题所在：原页vᵢ按全构型重复块定义，属于ℝ^{3N}，却直接与单粒子的三维qⱼ相加，类型前后矛盾。
- 反例或理由：N=2时v₁为六维而qⱼ为三维，二者之和未定义。Lean采用每个粒子的三维块L eᵢ解释。
- 原文版 Lean 名称及状态：全构型字面加法没有良类型Lean声明；原式及定义逐字保留于JSON和本文。
- 修正版 Lean 名称、改动内容、证明状态：MD.Ch01.periodicImageEnergy：定义完成；按粒子取三维块枚举27个近邻镜像，未改求和范围。
- 待人工核查点：确认vᵢ究竟指三维平移，还是全构型向量的第j个三维块。
- 导师选项：改记三维vᵢ=L eᵢ / 保留全构型vᵢ但显式取第j块；默认按粒子三维块解释，待导师确认。
- 网站复审结论：原文版忠实性=原文引文保留；现有Lean为限定解释，非无条件原句；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.periodicImageEnergy`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

## 22. MD-1.6.1-RealNormalMode

- source\_id：MD-1.6.1-RealNormalMode；印刷页 37 / PDF页 60。
- 原文引文（逐字）：

> or recast in real form as ($`\alpha,\beta`$ real coefficients):

$$
\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].
$$



- 问题所在：前式允许任意复系数a,b，后式α,β为实；不能把任意复值解都原样“改写”为实值解。
- 反例或理由：A=[[0,−1],[1,0]]，Ω=1，ξ=(1,−i)，a=1,b=0时z(0)不是实向量。实解族可取a=(β−iα)/2、b=(β+iα)/2，故b=共轭a；也可取复解的实部。Ω=0退化时不把该系数关系声称为无条件必要条件。
- 原文版 Lean 名称及状态：MD.Ch01.realnormalmode：已有实公式的ODE验证已证；未把任意复系数与实系数两族无条件等同，原句歧义保留。
- 修正版 Lean 名称、改动内容、证明状态：MD.Ch01.realnormalmode：限定为实解公式，已证；没有另建复实全族等价定理。
- 待人工核查点：确认recast仅指实值物理解，或是否意为取复解的实/虚部；系数约束应写在哪里。
- 导师选项：明确限制实值解并给共轭系数 / 明确取任意复解的实部；默认前者，待导师确认。
- 网站复审结论：原文版忠实性=原文引文保留；现有Lean为限定解释，非无条件原句；原书数学/范围=NEEDS\_HUMAN；修正版：`MD.Ch01.realnormalmode`=PASS；反例：数学反例/理由由网站讨论，未单列Lean反例审计。现有Lean数学子句/定义或限定解释=PASS，不能扩展到原书无条件原句。PASS仅指网站签名语义审校，证明状态另列。

