"""Actual tube law, complete ergodic claims, true weighted H1 and Prop6.4 gaps."""
from ch06_data import add,copied,proposition,NS
add('WienerControlTube','6.4.4',256,[116],r'''The event (6.50) is shown in [349] to have positive probability for any $\varepsilon>0$, and hence the required property is shown for any open set.''',copied('MolecularDynamics/Chapter06/WienerVectorSupport.lean','textbookWienerVectorRealControlTube_pos','wienerControlTube'),prior=['MolecularDynamics.textbookWienerVectorRealControlTube_pos'],extra=['[EXTRA]完整实际标准多维Wiener法则、真实连续控制R0=0、T/ε>0及sup管道事件；非仅某单时Gaussian边际。'])
add('LangevinCanonicalStationary','6.4.4',256,[117],r'''Langevin dynamics is geometrically ergodic with respect to the canonical distribution
\[\rho_\beta(q,p)=\exp(-\beta H(q,p)),\]
where it is easily checked that
\[\mathcal L_{LD}^*\rho_\beta=0.\]''',copied('MolecularDynamics/Chapter06/LangevinCanonicalPartition.lean','textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero','langevinCanonicalStationary'),prior=['MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero'],extra=['[EXTRA]实际归一canonical density（原式缺Z为未归一权重，常数不影响微分式）、全部相空间点及物理噪声；这里只证stationary differential expression，真实invariance/ergodicity在下一条。'])
erg=proposition('langevinErgodicity_statement','langevinGeometricErgodicity')
start=erg.index('  ∀ x : textbookLangevinPeriodicPhase n,')
erg=erg[:start]+'''  (∀ ν : Measure (textbookLangevinPeriodicPhase n), IsProbabilityMeasure ν →
    MolecularDynamics.Chapter06Review.invariantKernel
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) ν →
    ν=textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ l : ℕ, 1 ≤ l → ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧
    ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Measurable f → (∀ y, |f y| ≤ (1+‖y.2‖^2)^l) → ∀ t : ℝ≥0,
      |MolecularDynamics.Chapter06Review.kernelAverage
        (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) f t x
        -(∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
        C*(1+‖x.2‖^2)^l*Real.exp (-lambdaParam*(t : ℝ)) := by
  sorry'''
add('LangevinGeometricErgodicity','6.4.4',256,[118],r'''Hence Langevin dynamics is geometrically ergodic with respect to the canonical distribution.''',erg,extra=['[EXTRA]实际单位周期Langevin完整Gibbs不变/唯一概率及任意l≥1全部可测加权可积观测量的统一指数估计，常数在x/f/t之外；有界周期U使H^l与(1+‖p‖²)^l等价，没有弱化为紧支函数。'],missing='缺实际transition density、Harris/minorization及canonical invariance完整桥接；保留sorry，不恢复Thm6.2封存长证明。')
avg=proposition('langevinTimeAverage_statement','langevinTimeAverage')
avg=avg.replace('Continuous f → HasCompactSupport f →','''Measurable f →
    (∃ l : ℕ, ∃ C : ℝ, 0 ≤ C ∧ ∀ y, |f y| ≤ C*(1+‖y.2‖^2)^l) →''')
add('LangevinTimeAverage','6.4.4',256,[118],r'''Hence averages along solutions to (6.47) will converge to the spatial average with respect to $\rho_\beta$. Thus, Langevin dynamics is a useful tool for sampling the canonical distribution, as we may sample $\rho_\beta$ by computing solutions to the SDE.''',avg,extra=['[EXTRA]实际同一全时随机周期Langevin轨迹，任意点初始状态、全部可测多项式动量增长观测量、几乎处处时间均值；不把初始density的ensemble衰减当轨迹时间均值。'],missing='缺实际canonical唯一不变/遍历及weighted观测量强大数桥接；不建设大型理论。')
add('WeightedH1','6.4.4',256,[119],r'''We denote by $H^1(\mu)$ the space of functions $f(q,p)$ defined on $D=\mathbb T^{N_c}\times\mathbb R^{N_c}$ with bounded norm
\[\|f\|_{H^1(\mu)}^2\stackrel{\mathrm{def}}=\|f\|_{L^2(\mu)}^2+\|\nabla_qf\|_{L^2(\mu)}^2+\|\nabla_pf\|_{L^2(\mu)}^2.\]''','''def weightedH1 {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) : Type :=
  textbookLangevinCanonicalWeakH1 U hU hp β hβ''',kind='definition',extra=['[EXTRA]实际Gibbs加权弱导数闭图及AE商的完整Hilbert H1；不是smooth jet子集，函数/导数投影和范数下一条明确。'])
add('WeightedH1Norm','6.4.4',257,[120],r'''\[\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega);\qquad
\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.\]''',copied('MolecularDynamics/Chapter06/LangevinCanonicalWeakH1.lean','textbookLangevinCanonicalWeakH1_norm_sq','weightedH1Norm'),prior=['MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq'],extra=['[EXTRA]实际全部位置/动量弱导数的L²范数平方和；真实函数/弱导数投影定义随compact依赖闭包给出。'])
add('Proposition64Printed','6.4.4',257,[121],r'''Proposition 6.4 Let $U$ be $C^\infty$ on the position domain $Q=\mathbb T^{N_c}$ and suppose $g\in H^1(\mu)$ satisfies
\[\int_D g\,d\rho_\beta=0,\]
where $\rho_\beta$ is the canonical measure, then the Poisson equation
\[\mathcal L_{LD}^*\varphi=g\]
has a solution $\varphi\in H^1(\mu)$ which is unique up to addition of a constant multiple of the Gibbs density.''',proposition('proposition64_statement','proposition64Printed'),label='Proposition 6.4',verdict='NEEDS_HUMAN',issues=['印刷flat forward PDE与Gibbs加权mean-zero/adjoint pairing混用；测度及density-vs-relative-density选择待导师，原式完整保留。'],missing='无现成整条桥接；不恢复封存Prop6.4长证明，保留sorry。')
add('Proposition64Relative','6.4.4',257,[121],r'''\[\mathcal L_{LD}^*\varphi=g.\] The solution is unique up to addition of a constant multiple of the Gibbs density.''',proposition('proposition64Relative_statement','proposition64Relative'),extra=['[EXTRA]明确相对Gibbs密度坐标，实际加权Hilbert闭算子adjoint图与完整H1、加权零均值、解存在/唯一模常数；与印刷flat-density Gibbs倍数版分列，非静默纠错。'],missing='缺实际加权adjoint域、compact resolvent与rough kernel；无现成整条桥接保留sorry，封存不恢复。')
