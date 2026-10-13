"""Fifth batch: Proposition 6.1, full weighted flux and temperature obligations."""
from ch06_data import add,copied,proposition,D,NS
C='MolecularDynamics/Chapter06/CanonicalTemperature.lean'
I='MolecularDynamics/Chapter06/CanonicalIntegrationByParts.lean'
add('CanonicalAverageOne','6.1.4','218–220',[17],r'''The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.''',copied(C,'textbookCanonicalAverage_one','canonicalAverageOne'),kind='extra_claim',extra=['[EXTRA]标准归一化概率平均的实际检验Avβ(1)=1；保留旧CH06-017，独立于错误的式(6.4)重复归一化字面定义。'],prior=['MolecularDynamics.textbookCanonicalAverage_one'])
add('Equipartition','6.1.5',221,[18],r'''Then, as we integrate by parts to obtain
\[\operatorname{Av}_\beta(p^2)=m\beta^{-1},\]
which means that $T=\operatorname{Av}_\beta\left(\frac{p^2}{mk_B}\right)$.
If we consider a $N_c=N$ degree of freedom system with kinetic energy $K=\sum_{i=1}^N p_i^2/(2m_i)$ and potential energy $U(q_1,q_2,\ldots,q_N)$, then we may decompose the unnormalized canonical distribution as
\[\exp(-\beta[K(p)+U(q)])=\exp(-\beta K(p))\exp(-\beta U(q))
=\exp(-\beta U(q))\prod_{i=1}^{N_c}\exp\left(-\beta\frac{p_i^2}{2m_i}\right).\]
Then we again find, by the integration argument given above, that $\operatorname{Av}_\beta(m_i^{-1}k_B^{-1}p_i^2)=T$.
\[\operatorname{Av}_\beta(2K)=Nk_BT.\]''',proposition('equipartition_statement'),extra=['[EXTRA]标准归一化真实全空间密度、正β及全部正质量；可积且正配置partition；β⁻¹=kBT，完整逐坐标和总动能两项保留。'],missing='现成单位质量Gaussian测度未打包任意质量的真实Phase积分归一化二阶矩；缺完整桥接，保留sorry。')
add('ConfigurationalTemperature','6.1.5',222,[19],r'''For example, Rugh suggested the formula
\[\frac{\operatorname{Av}_\beta(\|\nabla U\|^2)}{\operatorname{Av}_\beta(\Delta U)}=k_BT.\tag{6.5}\]''',proposition('configTemperature_statement'),label='(6.5)',extra=['[EXTRA]C²实际U、正β、真实梯度和二阶导数、各加权导数可积及严格正分母；不是将比值等式作前提。'],missing='缺一般配置空间加权IBP及具体G=∇U的完整包装；Prop6.1一般向量场桥接不直接等于本条，保留sorry。')
add('Proposition61','6.1.5',222,[20],r'''Proposition 6.1. Let $H$ be a Hamiltonian defined on the phase space $\mathbb R^{2N}$ and suppose $G:\mathbb R^{2N}\to\mathbb R^{2N}$ is a smooth ($C^1$) vector field with the following properties:
\[0<|\operatorname{Av}_\beta(G\cdot\nabla H)|<\infty,\quad
0<\operatorname{Av}_\beta(\nabla\cdot G)<\infty,\quad |Ge^{-\beta H}|<\infty.\]
Then
\[k_BT=\frac{\operatorname{Av}_\beta(G\cdot\nabla H)}{\operatorname{Av}_\beta(\nabla\cdot G)}.\]''',copied(I,'proposition_6_1','proposition61'),kind='proposition',label='Proposition 6.1',extra=['[EXTRA]正kB,T、实际C¹ H,G、Gibbs及两个加权可观测量可积，分母严格正；原|Ge⁻βH|<∞解释为统一有界C≥0，不采用仅逐点有限的空洞条件。'],prior=['MolecularDynamics.proposition_6_1'],proof=r'''The proof relies on a $2N$-dimensional version of integration by parts. Let $B_R$ be the $2N$-dimensional ball centred at the origin, of radius $R$, and let $\Gamma_R$ be its boundary, the $2N-1$-dimensional sphere. Then, for any smooth scalar field $g$ defined on $B_R$, we have
\[\int_{B_R}G\cdot\nabla g\,d\omega=\int_{\Gamma_R}(Gg)\cdot\hat n\,d\Gamma-\int_{B_R}(\nabla\cdot G)g\,d\omega.\tag{6.6}\]
where $d\omega=d\omega_1\ldots d\omega_N$ is the standard measure of Lebesgue integration in $\mathbb R^{2N}$, and $d\Gamma$ is the surface area element of the hypersphere, and $\hat n$ represents the outward normal of the sphere. Replace $g$ by $\rho_\beta=\exp(-\beta H)$, it follows that
\[\left|\int_{\Gamma_R}(G\rho_\beta)\cdot\hat n\,d\Gamma\right|\leq\max_{\Gamma_R}|G\rho_\beta|\sigma_R\]
where $\sigma_R$ is the surface area of the hypersphere. Divide (6.6) by the volume $v_R$ of $B_R$. Then, for large $R$, since the ratio of surface area to volume is proportional to $R^{-1}$, we have
\[\frac{\int_{B_R}G\cdot\nabla\rho_\beta d\omega}{v_R}\approx\frac{-\int_{B_R}(\nabla\cdot G)\rho_\beta d\omega}{v_R}.\]
Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.''',proof_note='原书完整球边界证明已保留；按体积除法只能给出平均残项，不直接证明所需未缩放IBP。正式库以真实双截断和DCT证明同一结论。')
add('WeightedFluxZero','6.1.5',222,[21],r'''The proof relies on a $2N$-dimensional version of integration by parts.
Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.''',copied(I,'textbookCanonicalWeightedFlux_integral_divergence_eq_zero','weightedFluxZero'),kind='extra_claim',extra=['[EXTRA]真实全空间、原有统一加权场界及可积性，导出实际div(ρG)积分零，不把边界通量消失作假设。'],prior=['MolecularDynamics.textbookCanonicalWeightedFlux_integral_divergence_eq_zero'])
add('CanonicalDivergenceIdentity','6.1.5',222,[21],r'''Since $\nabla\rho_\beta=-\beta\nabla H\rho_\beta$, we obtain, in the limit $R\to\infty$, the desired result.''',copied(I,'textbookCanonicalAverage_divergence_eq_beta_lieDerivative','canonicalDivergenceIdentity'),kind='extra_claim',extra=['[EXTRA]同一真实全空间、实际权重可积及统一有界场；导出Avβ(divG)=βAvβ(G·∇H)，不假设IBP结论。'],prior=['MolecularDynamics.textbookCanonicalAverage_divergence_eq_beta_lieDerivative'])
add('TemperatureChoiceDerivatives','6.1.5',223,[22],r'''Observe that, defining $G=(0,p)^T$ yields the kinetic temperature observable $k_BT=\operatorname{Av}_\beta(p^TM^{-1}p)/N_c$, whereas $G=(\nabla U(q),0)^T$ gives the configurational temperature observable (6.5).
An even simpler configuration-dependent choice is derived from $G=(q,0)^T$, corresponding to
\[k_BT=\frac{\operatorname{Av}_\beta(q\cdot\nabla U)}{N_c}.\]''',proposition('temperatureChoices_statement','temperatureChoiceDerivatives'),kind='extra_claim',extra=['[EXTRA]保存三个原实际向量场的真实方向导数/分子计算；完整动能、配置温度和virial平均公式分别在Equipartition、ConfigurationalTemperature、VirialTemperature保留，不将分子计算计为完整温度公式。'],missing='待实际Fréchet有限和导数、正对角质量及坐标基计算；缺现成完整桥接保留sorry。')
add('PeriodicBoundaryCancellation','6.1.5','223–224',[23],r'''If $G$ and $H$ are both periodic in $q$ and $G$ is smooth, then everything works since the outward pointing normal will be in opposite directions on each side of the simulation cell, and the boundary term will cancel.''',copied('MolecularDynamics/Chapter06/BrownianDirichlet.lean','textbookConfigurationCube_integral_divergence_eq_zero','periodicBoundaryCancellation'),extra=['[EXTRA]正式现成单位周期配置cube的真实光滑向量场散度积分；F为实际各分量，可以对固定p取F=Gρ；无穷动量方向仍需原尾部资格，不计所有p积分可积性已证。'],prior=['MolecularDynamics.textbookConfigurationCube_integral_divergence_eq_zero'])
