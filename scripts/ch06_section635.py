"""All-mass overdamped limit and the actual density/generator obligations."""
from ch06_data import add,copied,proposition,D,NS,RECORDS
from ch06_section63 import strict_statement
def qualify_generator_expectation(record):
 code=record['code'].replace('ContDiff ℝ 2 φ →','ContDiff ℝ 1 a → ContDiff ℝ 1 b → ContDiff ℝ 2 φ →',1)
 anchor='  ∀ t : ℝ, 0 < t → HasDerivAt'
 assert anchor in code
 code=code.replace(anchor,'''  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) →
  Measurable (Function.uncurry X) →
  (∀ T : ℝ, 0 ≤ T → Integrable
    (fun w : ℝ × Ω ↦ |MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X w.1 w.2)|)
    ((volume.restrict (Icc 0 T)).prod P)) →
  ∀ t : ℝ, 0 < t → HasDerivAt''',1)
 record['code']=code
 record['extra_assumptions'].append('[EXTRA]自然Wiener历史适应、联合可测X、C¹a/b及Lφ在每个有限时间×样本上的绝对可积资格，保证实际Fubini；有符号期望连续不自动蕴含此资格。')
add('OverdampedLimit','6.3.4',240,[65],r'''This is also sometimes referred to as Brownian dynamics or Smoluchowski dynamics. The transition from Langevin to Brownian dynamics is typically referred to as the “Kramers to Smoluchowski limit.”''',
'''theorem overdampedLimit : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → (Fin n → ℝ)) (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ))
    (X : ℝ → ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ))) (q : ℝ → Ω → (Fin n → ℝ)),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  textbookUnitPeriodicPotential U → 0 < β →
  (∀ γ : ℝ, 0 < γ → MolecularDynamics.Chapter06Review.langevinMassSDE P
    (fun t sample ↦ B t.toNNReal sample) (X γ) m U γ β⁻¹ x0) →
  MolecularDynamics.Chapter06Review.brownianMassSDE P (fun t sample ↦ B t.toNNReal sample) q m U 1 β⁻¹ x0.1 →
  ∀ T : ℝ, 0 < T → ∀ f : (Fin n → ℝ) → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun γ : ℝ ↦ ∫ sample, f (X γ (γ*T) sample).1 ∂P) atTop
      (𝓝 (∫ sample, f (q T sample) ∂P)) := by
  sorry''',extra=['[EXTRA]全部正对角质量、正β、光滑周期U，原热浴路径模型；高γ需按γT观察，完整任意有界连续检验弱极限，没有把极限本身作前提。'],missing='缺一般正质量Kramers–Smoluchowski极限理论；不恢复封存长证明，不建设大型理论。')
add('ScalarGenerator','6.3.5',240,[67],r'''where $\mathcal L$ is a linear operator, called the generator of the stochastic process, defined by
\[\mathcal L=a(x)\frac d{dx}+\tfrac12 b^2(x)\frac{d^2}{dx^2}.\tag{6.38}\]''',copied(D,'scalarGenerator'),kind='definition',label='(6.38)',context=['真实一、二阶导数及1/2系数，C²资格在应用定理给出。'])
add('GeneratorExpectation','6.3.5',240,[66],r'''Then, taking the expectation of the Itô-Doeblin formula (6.17) we find
\[\mathbb E\{d\phi(X)\}=\mathbb E\{\phi'(X)a(X)\}dt+\tfrac12\mathbb E\{\phi''(X)b(X)^2\}dt
=\mathbb E\{(\mathcal L\phi)(X)\}dt.\tag{6.37}\]''',strict_statement('generatorExpectation_statement','generatorExpectation'),label='(6.37)',extra=['[EXTRA]真实严格SDE、C²φ、适应平方可积资格、Lφ实际可积且时间期望连续；完整期望时间导数，不只定义L。'],missing='缺Ito链式法则与期望求导/鞅零均值完整桥接。')
add('PolynomialSmooth','6.3.6',241,[68],r'''For future reference we define the space of functions which are $C^\infty$ smooth and satisfy the polynomial growth restriction by $C_P^\infty$:
\[C_P^\infty=\{\phi\in C^\infty\mid\exists r\in\mathbb N:\phi(x)=O(|x|^r),\ x\to\pm\infty\}.\]''',copied(D,'polynomialSmooth'),kind='definition',context=['真实函数值的多项式增长；不擅自增加所有阶导数也有多项式增长。全域(1+|x|)^r界等价于尾部O加连续紧集界。'])
add('DensityExpectation','6.3.6',241,[68],r'''For any $\phi\in C_P^\infty$, the expectation with respect to $\rho(x,t)$ is well defined and we have
\[\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.\]''',
'''theorem densityExpectation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (X : Ω → ℝ) (ρ φ : ℝ → ℝ),
  HasLaw X (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) P →
  (∀ x, 0 ≤ ρ x) → Measurable ρ → MolecularDynamics.Chapter06Review.polynomialSmooth φ →
  (∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x, ρ x ≤ C*Real.exp (-c*|x|)) →
  Integrable (fun sample ↦ φ (X sample)) P ∧
    (∫ sample, φ (X sample) ∂P)=(∫ x, φ x*ρ x) := by
  sorry''',extra=['[EXTRA]真实非负可测density与全局指数尾界；完整可积与积分law等式，不预置这些结论。'],missing='缺多项式乘指数尾积分及withDensity实积分的完整打包桥接。')
add('ScalarForward','6.3.6',242,[72],r'''As this holds for any function $\phi$ in the appropriate space, we may obtain an equation for the time evolution of $\rho$:
\[\frac{\partial\rho}{\partial t}=-\frac\partial{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).\tag{6.39}\]''',copied(D,'scalarForward'),kind='definition',label='(6.39)',context=['完整正号diffusion伴随算子；PDE从law推导另条，不计定义已证PDE。'])
add('FPDriftAdjoint','6.3.6','241–242',[69],r'''First, we find
\[\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{+\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx
=-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.\]''',proposition('fpDriftAdjoint_statement','fpDriftAdjoint'),extra=['[EXTRA]当前完整紧支撑C¹检验桥接；原指数尾和多项式检验的全域版本在FPPolynomialAdjoint保留，不将紧支撑特例计为原全部检验已证。'],missing='待实际一维IBP短桥；无结论作前提。')
add('FPDiffusionPrinted','6.3.6',242,[70],r'''Using two integrations by parts gives
\[\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=-\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho(x,t))_{xx}dx.\]''',
'''theorem fpDiffusionPrinted : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    -(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['原页两次IBP后仍打印负号；正确应正号，且(6.39)最终算子已经使用正号。'],missing='不证明错误负号；正号完整伴随式另批保留。')

qualify_generator_expectation(next(r for r in RECORDS if r["source_id"].endswith("-GeneratorExpectation")))
