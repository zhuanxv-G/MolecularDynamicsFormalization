"""Third batch: actual entropy variation and general-mass partition obligations."""
from ch06_data import add,copied,proposition,D,NS
P='MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean'
add('EntropyFirstVariation','6.1.3','217–218',[10],r'''The first equation reduces to
\[-(1+\ln\rho)-\lambda-\beta H=0\]
yielding $\rho=e^{-1-\lambda}e^{-\beta H}$.''',proposition('entropyFirstVariation_statement'),kind='extra_claim',extra=['[EXTRA]实际正连续密度、可积熵/能量及光滑紧支变分；保存对V的实际HasDerivAt积分表达式，不把Euler–Lagrange结论作前提。','[EXTRA]省略与ρ无关的λ+βĒ常数不影响本条导数；完整含常数V另见ConstrainedEntropyModel。'],missing='缺熵泛函沿紧支变分的微分积分交换；无现成桥接保留sorry，不展开大型变分理论。')
add('EntropyVariation','6.1.3','217–218',[10],r'''The first equation reduces to
\[-(1+\ln\rho)-\lambda-\beta H=0\]
yielding
\[\rho=e^{-1-\lambda}e^{-\beta H}.\]
The normalization condition determines the parameter $\lambda$, whereas $\beta$ and hence the temperature arises from the choice of average energy.''',proposition('entropyVariation_statement'),extra=['[EXTRA]在每个光滑紧支实际密度方向的内点局部极值、正连续可积密度；不假设变分导数零或点态EL结论。'],missing='缺上一条泛函导数以及变分基本引理的真实包装；不以待证EL作假设。')
add('CanonicalDensity','6.1.3',218,[11],r'''This defines the phase space density of the canonical ensemble which we refer to as the Gibbs-Boltzmann density:
\[\rho_\beta=Z_{\rm can}^{-1}e^{-\beta H(q,p)}.\tag{6.3}\]
where the parameter $\beta=1/(k_BT)$. The quantity $Z_{\rm can}$ is a normalizing constant so that this is a probability density.
\[Z_{\rm can}=\int_D e^{-\beta H(q,p)}d\omega.\]''',copied(D,'canonicalDensity'),kind='definition',label='(6.3)',context=['实际积分分母，没有独立给定Z；正有限可积条件下才为概率密度，归一化定理另列；NVT为固定N,V,T记号。'])
add('MassHamiltonian','6.1.3',218,[12],r'''If we have a standard molecular Hamiltonian $H(q,p)=p^TM^{-1}p/2+U(q)$ with $N_c=Nd$ degrees of freedom''',copied(D,'massHamiltonian'),kind='definition',context=['M为正对角质量矩阵，m_i>0；本条保留每坐标m_i，不以单位质量代替。'])
add('PartitionMass','6.1.3',218,[12],r'''then the integral separates
\[Z_{\rm can}=\int_D e^{-\beta H(q,p)}d\omega
=\int_{\mathbb R^{N_c}}e^{-\beta p^TM^{-1}p/2}d\omega_p\times\int_Q e^{-\beta U(q)}d\omega_q.\]''',proposition('partitionMass_statement'),extra=['[EXTRA]此条取Q=全配置实空间；正β、任意正对角质量和配置权重可积；一般Q用下一条独立保存。'],missing='现有正式公式只覆盖单位质量/周期模型；一般质量Gaussian乘积积分无现成完整桥接，保留sorry。')
add('PartitionDomain','6.1.3',218,[12],r'''where $Q$ is the accessible position domain, $d\omega_p=dp_1dp_2\cdots dp_{N_c}$ and $d\omega_q=dq_1dq_2\cdots dq_{N_c}$.''',
'''theorem partitionDomain : ∀ {n : ℕ}
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [SigmaFinite μ]
    (m : MolecularDynamics.Chapter06Review.V n)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) μ →
  (∫ x : MolecularDynamics.Chapter06Review.Phase n,
    Real.exp (-β*MolecularDynamics.Chapter06Review.massHamiltonian m U x)
    ∂μ.prod (volume : Measure (MolecularDynamics.Chapter06Review.V n))) =
  (∫ q, Real.exp (-β*U q) ∂μ) * ∏ i, Real.sqrt (2*Real.pi*m i/β) := by
  sorry''',extra=['[EXTRA]配置测度μ为sigma-finite，原Q对应μ=volume.restrict Q；真实乘积测度及一般正质量，不将有限域换为torus。'],missing='待一般质量Gaussian有限积及实际Fubini分离；无现成完整桥接保留sorry。')
add('FiniteDomainPrinted','6.1.3',218,[13],r'''If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.''',
'''theorem finiteDomainPrinted : ∀ {n : ℕ} (Q : Set (MolecularDynamics.Chapter06Review.V n))
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β : ℝ),
  MeasurableSet Q → (volume : Measure (MolecularDynamics.Chapter06Review.V n)) Q < ⊤ →
  ContDiffOn ℝ ∞ U Q → 0 < β → IntegrableOn (fun q ↦ Real.exp (-β*U q)) Q := by
  sorry''',verdict='NEEDS_HUMAN',issues=['[ERRATUM?]仅有限体积、Q内部光滑不足以排除趋向边界的U→−∞；需要下界、紧域上的连续性或权重可积性。'],explanation='字面资格保留，不从内部光滑偷推有界，也不假设目标可积性。真实周期特例另列。',missing='有限域的边界/下界条件需补齐；不证明当前字面断言。')
add('PeriodicPartitionBridge','6.1.3',218,[12],r'''then the integral separates
\[Z_{\rm can}=\int_{\mathbb R^{N_c}}e^{-\beta p^TM^{-1}p/2}d\omega_p\times\int_Q e^{-\beta U(q)}d\omega_q.\]''',copied(P,'textbookLangevinCanonicalPartition_formula','periodicPartitionBridge'),kind='extra_claim',extra=['[EXTRA]仅独立特例：单位质量、单位周期torus、实际Haar配置测度与光滑周期U；完整一般质量/Q的两条义务仍保留，不将特例计为完整原结论已证。'],prior=['MolecularDynamics.textbookLangevinCanonicalPartition_formula'])
