"""First eight steady-state records; source heuristics are not fabricated proofs."""
from ch05_data import add,copied,proposition,D,NS
add('WeakStationary','5.3.2','189–190',[39],r'''We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of $\mathcal L_f^*\rho=0$. However, this requires a little care. Instead we will define the stationary solution in terms of integrals against test functions. This suggests that the condition for the invariant probability density function $\rho_\infty$ should be $\int_D\phi\mathcal L_f^*\rho_\infty d\omega=0$, for all suitable functions $\phi\in C_0^\infty(\mathbb R^m)$. We say that $\mathcal L_f^*\rho_\infty=0$, in the weak or variational sense.''',copied(D,'weakStationary'),kind='definition',extra=['[EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。'])
add('EnsembleAverage','5.3.2',190,[40],r'''Let $\phi$ be a $C^\infty$ function of the phase variables with compact support and define the time $t$ average by
\[\bar\phi(t)=\frac{\int_D\phi(q,p)\rho(q,p;t)d\omega}{\int_D\rho(q,p;t)d\omega}.\tag{5.6}\]''',f'''def ensembleAverageOn {{n : ℕ}} (D : Set ({NS}E n)) (ρ : ℝ → {NS}E n → ℝ) (φ : {NS}E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ''',kind='definition',context=['一般域D上的实际系综平均；不是沿单轨道的时间平均。'])
add('ConvergenceHeuristic','5.3.2',190,[],r'''As the flow is Hamiltonian, $\int_D\rho(q,p;t)d\omega=\int_D\rho(q,p;0)d\omega$. Thus the condition for $\bar\phi$ to converge is just that $\int_D\phi(q,p)\frac{\partial\rho}{\partial t}(q,p;t)d\omega\to0$.''',f'''theorem convergenceHeuristic : ∀ n (D : Set ({NS}E n))
    (f : {NS}E n → {NS}E n) Φ (ρ : ℝ → {NS}E n → ℝ) (φ : {NS}E n → ℝ),
  NullMeasurableSet D volume → {NS}flow f Φ → (∀ t,Φ t '' D=D) →
  (∀ t,MeasurePreserving (Φ t) volume volume) →
  ContDiff ℝ 1 (Function.uncurry ρ) → ContDiff ℝ ⊤ φ → HasCompactSupport φ →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)={NS}measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0) →
    ∃ L : ℝ,Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L) := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]原文为推导弱稳态的启发，导数趋零一般不足以推出有界函数收敛，例如sin(log(1+t²))。当前陈述仍保存实际被流输运的密度积分与全部原结论；尚未构造满足完整动力学前提的密度反例，不能借抽象函数反例宣称这一签名FAIL。',extra=['[EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。'],missing='原收敛推断需要独立语义裁定及补充收敛资格；当前不证明。')
add('HamiltonianEnergyIntegral','5.3.2',190,[41],r'''In the case of a Hamiltonian system, we know that $\mathcal L_f^*=-\mathcal L_f$, and, moreover, $\mathcal L_fH=0$, so that $H$ is a first integral.''','''theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0 := by
  rw [MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson]
  exact MolecularDynamics.textbookPoissonBracket_self H z''',prior=['MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson','MolecularDynamics.textbookPoissonBracket_self'])
add('EnergyDensityInvariant','5.3.2',190,[42],r'''Any probability distribution whose density is a smooth function of $H$ will also be an invariant distribution.''',proposition('energyDensityInvariant_statement'),extra=['[EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。'],missing='待第一积分链式法则与实际Measure.map/withDensity桥接；不建设新的测度输运理论。')
add('ShellWeight','5.3.2',190,[43],r'''In particular, consider the density $\rho_\varepsilon(q,p)=Z_\varepsilon^{-1}e^{-(H(q,p)-E)^2/(2\varepsilon)}$, where $\varepsilon$ is an arbitrary small positive constant and $E$ is an accessible energy level.''',copied(D,'shellWeight'),kind='definition',context=['真实能量壳指数权；ε>0/可达能量和可积归一化资格为后续使用条件。'])
add('ShellPartition','5.3.2','190–191',[43],r'''We assume that $H$ tends to infinity sufficiently rapidly as $\|z\|\to\infty$ so that the exponential decays sufficiently rapidly (and thus the total integral exists) and take $Z_\varepsilon$ to be a normalization factor that insures that we have, for each $\varepsilon$, a well defined probability density function.''',copied(D,'shellPartition'),kind='definition',context=['实际全相空间权的积分；非零有限分母不是由定义编译自动保证。'])
add('ShellDensity','5.3.2','190–191',[43],r'''$\rho_\varepsilon(q,p)=Z_\varepsilon^{-1}e^{-(H(q,p)-E)^2/(2\varepsilon)}$.''',copied(D,'shellDensity'),kind='definition',context=['已除一次Zε；后面的(5.8)若再除一次必须单列字面疑误，不能静默替换。'])
