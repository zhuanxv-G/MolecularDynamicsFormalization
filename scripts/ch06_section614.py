"""Fourth batch: original confinement examples and complete average normalization."""
from ch06_data import add,copied,proposition,D,NS,EXCLUDED
P='MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean'
C='MolecularDynamics/Chapter06/CanonicalTemperature.lean'
add('ConfiningPartition','6.1.3','218–220',[14],r'''Typically one assumes that (i) $U$ is smooth except on a low-dimensional set of singular points, (ii) $U$ is bounded below, and (iii) $U$ grows sufficiently rapidly as $q\to\infty$, in the case of an infinite domain.
This ensures that
\[\int_\Omega\exp(-\beta U(q))d\omega_q<\infty.\]''',proposition('confiningPartition_statement'),extra=['[EXTRA]无奇点的连续全空间充分条件：U(q)≥c‖q‖ᵖ−C，其中c,p,β>0；把“足够快”明确量化，不将任意增长都视为足够。'],missing='缺任意实p>0的径向尾部可积估计包装；不是周期紧域桥接能涵盖的一般结论，保留sorry。')
add('LennardJonesNonintegrable','6.1.3',219,[],r'''For example a collection of atoms on the infinite domain interacting in Lennard-Jones potentials does not satisfy the third condition, and it does not have a well defined canonical partition function.
For simplicity, just take the case of a one degree-of-freedom system with $H=p^2/2+q^{-12}-q^{-6}$, $q>0$.''',
'''theorem lennardJonesNonintegrable : ∀ β : ℝ, 0 < β →
  ¬ IntegrableOn (fun q : ℝ ↦ Real.exp (-β*(q⁻¹^12-q⁻¹^6))) (Ioi 0) := by
  sorry''',extra=['[EXTRA]精确取原一自由度例子的q>0配置权重；动量Gaussian有限因子不会修复配置尾部发散。'],missing='需q→∞时权重→1以及无穷半轴不可积的实际尾部比较；无现成完整桥接，保留sorry。')
add('LennardJonesConfinement','6.1.3',219,[],r'''In order to use a one-degree-of-freedom model on an infinite domain in the canonical setting, we would need to incorporate a restraining potential, slightly modifying for example the Lennard-Jones potential to $U(q)=q^{-12}-q^{-6}+\epsilon q^2$ (Fig. 6.2).''',
'''theorem lennardJonesConfinement : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ,
  ∀ q : ℝ, ε*q^2- C ≤ q⁻¹^12-q⁻¹^6+ε*q^2 := by
  sorry''',extra=['[EXTRA]ε>0；保存完整势能公式，并给出足以控制无穷尾部的二次下界；q=0处总逆元记号不替代原q>0模型，不计奇点积分已证。'],missing='待y²−y≥−1/4的短代数下界；配置积分完整有限性依赖一般尾部估计，另条ConfiningPartition保留。')
add('PeriodicWeightIntegrable','6.1.3',218,[13],r'''If $U$ is smooth and the domain $Q$ is finite, then clearly both integrals are well defined, so the normalization is sensible.''',
'''theorem periodicWeightIntegrable {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Integrable (textbookLangevinPeriodicGibbsWeight U β)
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  exact MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable U hU hp β hβ''',kind='extra_claim',extra=['[EXTRA]独立单位质量/单位torus、光滑周期U特例；配置Haar×动量Lebesgue采用正式flatPhaseMeasure的实际定义，避免隐式不同测度。'],prior=['MolecularDynamics.textbookLangevinPeriodicGibbsWeight_integrable'])
add('PeriodicPartitionPositive','6.1.3',218,[13],r'''In order for the density in (6.3) to be normalizable, it is necessary that the quantity $Z_{\rm can}$ ... be finite, i.e., that the integral converge.''',copied(P,'textbookLangevinCanonicalPartition_pos','periodicPartitionPositive'),kind='extra_claim',extra=['[EXTRA]正式库现成真实周期、单位质量、正β特例；正finite partition由已证可积性和严格正权重推出，未假设所需归一化结论。'],prior=['MolecularDynamics.textbookLangevinCanonicalPartition_pos'])
add('PolynomialObservable','6.1.4',220,[15],r'''In the case of periodic boundary conditions we will assume that, for any observable of interest,
\[|\phi(q,p)|=O(\|p\|^\alpha),\qquad p\to\infty,\]
for some positive constant $\alpha$.''',copied(D,'polynomialObservable'),kind='definition',extra=['[EXTRA]q在实际紧torus上；用一致C(1+‖p‖)^r、C≥0及自然数r表达至多多项式增长，实α可取更大整数；不证明每个可观测量自动满足增长界。'])
add('CanonicalAveragePrinted','6.1.4',220,[16],r'''Under assumptions on the potential energy as discussed above, and with $\phi$ continuous and allowed to grow at most polynomially fast at infinity, we may proceed to define averages with respect to the canonical density $\rho_\beta$, namely
\[\operatorname{Av}_\beta(\phi)=Z_{\rm can}^{-1}\int_D\phi(q,p)\rho_\beta(q,p)d\omega.\tag{6.4}\]''',copied(D,'canonicalAveragePrinted'),kind='definition',label='(6.4)',verdict='NEEDS_HUMAN',issues=['[ERRATUM?]式(6.3)的ρβ已含Zcan⁻¹，式(6.4)再乘一次导致Avβ(1)=Zcan⁻¹，而后文p.221使用标准归一化平均。'],explanation='完整字面定义保留；重复归一化疑点尚未裁定，不把该定义计为标准概率平均。标准版独立记录。',missing='式(6.4)重复Z⁻¹待人工审校；字面定义不作新证明。')
add('CanonicalAverage','6.1.4','220–221',[16],r'''We will denote the average with respect to the canonical probability density by $\operatorname{Av}_\beta$. Using (6.4), we can compute the average of the function $p^2$ as
\[\operatorname{Av}_\beta(p^2)=\int_{-\infty}^{\infty}\int_{-\infty}^{\infty}p^2\rho_\beta dqdp.\]''',copied(C,'textbookCanonicalAverage','canonicalAverage'),kind='definition',extra=['[EXTRA][ERRATUM?]按p.221的实际用法与概率平均标准定义去掉式(6.4)对已归一ρ的第二次Z⁻¹；原字面版仍保留NEEDS_HUMAN。'],context=['实际未归一权重的积分乘真实partition倒数；定义不计可积性或归一化已证。'])
EXCLUDED += [dict(printed_page='219',pdf_page='240',reason='图6.2的100个粒子、L=20周期模拟、红色双阱粒子轨道及虚实密度曲线是数值/定性说明；完整Lennard-Jones势、尾部发散与εq²束缚公式另列，不省略数学内容。')]
