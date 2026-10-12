"""Mixing correlations keep the normalization factor and the printed defect."""
from ch05_data import add,proposition,NS
add('MixingMemoryLoss','5.5',205,[],r'''We assume $\beta(z)\stackrel{\rm def}{=}\rho(z;0)/\rho_E(z)$ is bounded on $\Sigma_E$, and moreover $\operatorname{Av}_{H=E}(\beta)=1$ (i.e., the initial density is a probability density on the energy surface), and that the system is mixing. Then the integral (5.10) is well defined and we may view it as a two-point correlation function of $\phi$ and $\beta$. By the mixing property it must converge to $\int_{\Sigma_E}\phi(z)\rho_Ed\omega$, thus the average value of $\phi$ is ultimately independent of the initial conditions. We have
\[\lim_{t\to\infty}\int_{\Sigma_E}\phi(\mathcal F_t(z))(\beta(z)-1)\rho_Ed\omega=0.\]''',f'''theorem mixingMemoryLoss : ∀ n (μ : Measure ({NS}E n)) Φ (β φ : {NS}E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0) := by
  sorry''',extra=['[EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。'],missing='待有限测度有界连续函数可积、MeasurePreserving积分不变与Tendsto差短桥。')
add('MixingCorrelationPrinted','5.5',205,[71],r'''More generally, in a mixing system, if $a$ and $b$ are two arbitrary functions of the phase variables, then
\[\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\operatorname{Av}_{H=E}(b).\]''',proposition('mixingCorrelationPrinted_statement').replace(NS+'mixing μ Φ','weakMixing μ Φ'),verdict='NEEDS_HUMAN',explanation='[ERRATUM?]相关函数已含任意归一化k，印刷极限遗漏k；保留字面目标，不静默设k=1。原任意函数需可积/有界资格，否则甚至积分未定义。',extra=['[EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。'],missing='原遗漏k待裁定，不证明；正确极限另条。')
add('MixingCorrelation','5.5',205,[71],r'''$\lim_{t\to\infty}C_{ab}(t)=\operatorname{Av}_{H=E}(a)\operatorname{Av}_{H=E}(b)$.''',proposition('mixingCorrelation_statement').replace('IsProbabilityMeasure μ →','IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →',1),extra=['[EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。'],missing='待有界函数加正偏移的概率密度分解与弱mixing短桥；不建设连续遍历理论。')
add('CenteredCorrelation','5.5',205,[71],r'''So if either property has mean zero, then the absolute value of the autocorrelation function decays with time to zero.''',f'''theorem centeredCorrelation : ∀ n (μ : Measure ({NS}E n)) (Φ : ℝ → {NS}E n → {NS}E n)
    (a b : {NS}E n → ℝ) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  ({NS}average μ a=0 ∨ {NS}average μ b=0) →
  Tendsto (fun t => |k*(∫ z,a (Φ t z)*b z ∂μ)|) atTop (𝓝 0) := by
  sorry''',extra=['[EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。'],missing='依赖当前混合相关短桥，未有独立已核证明时保留sorry。')
