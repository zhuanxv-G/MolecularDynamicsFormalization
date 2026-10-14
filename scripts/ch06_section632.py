"""OU exact law keeps the printed missing square-root and complete corrected marginal separate."""
from ch06_data import add,copied,proposition,D,NS
from ch06_section63 import strict_statement
add('OUProcess','6.3.2',234,[51],r'''For now we will examine the special case of a scalar equation
\[dX=-\gamma Xdt+\sigma dW;\tag{6.19}\]
where $\gamma>0$ and $\sigma$ are constants. We term Eq. (6.19) the Ornstein-Uhlenbeck SDE.''',
'''def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0''',kind='definition',label='(6.19)',extra=['[EXTRA]原显式γ>0保留在真实严格L²积分方程的资格中，不将分布式解作方程前提。'])
add('OUIntegratingFactor','6.3.2',234,[52],r'''Multiply both sides of (6.19) by the integrating factor $\exp(\gamma t)$, and observe that
\[d(\exp(\gamma t)X)=\exp(\gamma t)(dX+\gamma Xdt);\]
thus (6.19) becomes
\[d(\exp(\gamma t)X)=\sigma\exp(\gamma t)dW(t).\]
We then integrate both sides to obtain
\[\exp(\gamma t)X(t)=X(0)+\sigma\int_0^t\exp(\gamma s)dW(s).\]
Multiplying by $e^{-\gamma t}$ gives
\[X(t)=e^{-\gamma t}X(0)+\sigma e^{-\gamma t}\int_0^t\exp(\gamma s)dW(s).\]''',strict_statement('ouIntegratingFactor_statement','ouIntegratingFactor'),extra=['[EXTRA]实际PreBrownian、严格OU与严格确定性Ito积分见证、γ>0和t≥0；完整求值，不以解公式作假设。'],missing='缺严格OU方程与现成确定积分构造的完整变常数/唯一性桥接；不恢复长证明。')
add('OUVarianceIntegral','6.3.2',235,[53],r'''Using Proposition 6.3, we know that for a Wiener process $W(t)$, $Y(t)\stackrel{\rm def}=\int_0^t\exp(\gamma s)dW(s)$ is a Gaussian random variable with mean zero and variance
\[\operatorname{Var}\{Y(t)\}=\int_0^t e^{2\gamma s}ds=\frac{e^{2\gamma t}-1}{2\gamma}.\]''',
'''theorem ouVarianceIntegral : ∀ (γ T : ℝ), 0 < γ → 0 ≤ T →
  (∫ s in (0 : ℝ)..T, Real.exp (2*γ*s))=(Real.exp (2*γ*T)-1)/(2*γ) := by
  sorry''',extra=['[EXTRA]γ>0使分母非零；随机变量完整Gaussian law在Prop6.3和OULawCorrect保留。'],missing='待指数函数实际区间积分短桥。')
add('OULawPrinted','6.3.2',235,[53],r'''The solution with equivalent distribution is therefore
\[X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}}(1-e^{-2\gamma t})\widehat Y(t).\]
where $\widehat Y(t)$ should be interpreted as random process which at every time $t$ evaluates to a normal random variable ($\widehat Y(t)\sim N(0,1)$). This is what we mean by the exact distributional solution of the Ornstein-Uhlenbeck SDE with prescribed initial value $X(0)$.''',
'''theorem ouLawPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 →
  0 < γ → 0 ≤ T → HasLaw (X T)
    (gaussianReal (Real.exp (-γ*T)*x0)
      ((σ*Real.sqrt ((2*γ)⁻¹)*(1-Real.exp (-2*γ*T)))^2).toNNReal) P := by
  sorry''',verdict='NEEDS_HUMAN',issues=['原页根号只覆盖(2γ)⁻¹，(1−e⁻²γt)漏在根号内；方差因此被错误平方。单时分布等价不确定整个过程耦合。'],missing='不证明印刷漏根号分布；完整更正单时law另列，不将独立边际当同一OU过程。')
add('OULawCorrect','6.3.2',235,[53],r'''The solution with equivalent distribution is therefore
\[X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}}(1-e^{-2\gamma t})\widehat Y(t).\]''',strict_statement('ouLaw_statement','ouLawCorrect'),extra=['[EXTRA]修正标准差σ√((1−e⁻²γt)/(2γ))，完整真实单时Gaussian法则；均值e⁻γtx0、方差σ²(1−e⁻²γt)/(2γ)，不预置law结论。'],missing='缺严格OU变常数与积分法则的完整桥接；Prop6.3现成单独结果不等于本条。')
add('OUGibbsLimit','6.3.2',235,[54],r'''Let $\sigma=\sqrt{2\gamma k_BT m}$; then for large $t$ the exponentials of the form $e^{-\gamma t}$ tend to zero, and we have
\[X(t)\approx\sqrt{k_BT m}\widehat Y(t);\]
 in which case $X(t)$ is drawn from the probability density
\[\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).\]''',proposition('ouGibbsLimit_statement','ouGibbsLimit'),extra=['[EXTRA]θ=kBT>0,m>0,γ>0；完整弱收敛，全部有界连续检验函数；不只证明均值/方差参数极限。'],missing='待Gaussian law参数连续性与指数极限完整短桥；现成一般Gaussian连续性可复用，保留未核桥接。')
add('MomentumOU','6.3.2',235,[55],r'''For a system with $N_c$ configurational variables we may write
\[dp_i=-\gamma p_i dt+\sqrt{2\gamma k_BT m_i}\,dW_i;\tag{6.20}\]
where $W_1(t),W_2(t),\ldots,W_{N_c}(t)$ represent $N_c$ independent Wiener processes, or, in vectorial notation, denoting $W=[W_1,W_2,\ldots,W_{N_c}]^T$, we have
\[dp=-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{6.21}\]''',copied(D,'momentumOU').replace(NS+'ouProcess','strictOUProcess').replace(': Prop :=',': Prop :=\n  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧',1),kind='definition',label='(6.20)–(6.21)',extra=['[EXTRA]全部正对角质量mi、γ>0、θ=kBT>0和真实各坐标严格积分关系；独立多维W资格另给，不把单位质量桥接当一般质量已证。'])
add('GibbsGaussianDensity','6.3.2',235,[54],r'''in which case $X(t)$ is drawn from the probability density
\[\rho_\infty(u)=\frac1{\sqrt{2\pi m k_BT}}\exp\left(-\frac1{k_BT}\frac{u^2}{2m}\right).\]''',
'''def gibbsGaussianDensity (θ m u : ℝ) : ℝ :=
  Real.exp (-(u^2/(2*m))/θ)/Real.sqrt (2*Real.pi*m*θ)''',kind='definition',context=['θ=kBT>0,m>0；原规范化密度实际公式，仅定义不计积分归一化已证。'])
