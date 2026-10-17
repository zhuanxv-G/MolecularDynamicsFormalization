"""Actual kernel duality and full complex generator eigenmode evolution."""
from ch06_data import add,copied,proposition,D,NS,RECORDS
add('KernelEvolution','6.4.5',257,[124],r'''Given a collection of phase space points distributed according to the density $\rho_0(q,p)$, its evolution under Langevin dynamics after a time $t$ will be described by
\[\rho(q,p,t)=e^{t\mathcal L_{LD}^*}\rho_0(q,p).\]''',copied(D,'kernelEvolution'),kind='definition',extra=['[EXTRA]真实Markov kernel应用初始measure的compProd边缘，形式exp解释为实际演化，非无资格幂级数。'])
add('KernelAverage','6.4.5',258,[124,125],r'''The average of a function $\varphi$ with respect to the distribution at time $t$ is equivalent to the average of the forward propagation of $\varphi$ with respect to the initial distribution.''',copied(D,'kernelAverage'),kind='definition',extra=['[EXTRA]真实核积分的backward检验函数传播，可积资格在Duality定理明确。'])
add('DensityEvolutionMeaning','6.4.5','257–258',[124],r'''More precisely this relation should be interpreted in the variational sense, so that for any suitable test function $\varphi$, e.g. $\varphi\in C^\infty$,
\[\int_D\varphi\rho(q,p,t)d\omega=\int_D\varphi e^{t\mathcal L_{LD}^*}\rho_0(q,p)d\omega.\]''','''def densityEvolutionMeaning {n : ℕ} (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (ρ0 : textbookLangevinPeriodicPhase n → ℝ) (ρ : ℝ≥0 → textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ0 x) ∧ Integrable ρ0 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, ρ0 x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  ∀ t, (∀ x, 0 ≤ ρ t x) ∧ Integrable (ρ t) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
    MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ0 x))) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (ρ t x))''',kind='definition',extra=['[EXTRA]真实初始概率density、全部时刻density及实际kernel measure等式的语义定义；未假设每个任意SDE必存在平滑density，未计存在性已证。'])
add('KernelDuality','6.4.5',258,[125],r'''Due to the properties of the inner product, we may interpret the right hand side as
\[\int_D(e^{t\mathcal L_{LD}}\varphi)(q,p)\rho_0(q,p)d\omega.\]''',proposition('kernelDuality_statement','kernelDuality'),extra=['[EXTRA]全部实际可测可积检验、真实Markov kernel及初始概率measure；非仅Brownian谱模型配对。'],missing='待Mathlib integral_comp/compProd的直接短桥。')
add('SmoothTestL2Printed','6.4.5',258,[126],r'''Since all the eigenvalues lie to the left of a vertical line in the left half plane, for any $\varphi$ in $C^\infty$ we have
\[\int_D\varphi\rho(q,p,t)d\omega=\operatorname{Av}_\beta(\varphi)+\alpha e^{t\lambda_1}\int_D\varphi\rho^{(1)}d\omega.\]
The latter integral is bounded since both $\varphi$ and $\rho^{(1)}$ are in $L^2$.''','''theorem smoothTestL2Printed : ∀ {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ),
  ContDiff ℝ ∞ (f ∘ textbookLangevinPeriodicProjection) →
  MemLp f 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['环面×无界动量上C∞不自动L²；常数1已不在flat L²，指数增长函数也可能不在Gibbs L²。需适当weighted空间/增长资格。'],missing='不证明错误自动可积断言；下面完整衰减保留真实L²检验资格。')
add('ComplexInitialDensity','6.4.5',258,[126],r'''Assume that $\lambda_1,\rho^{(1)}$ is some eigenvalue, eigenfunction pair with $\operatorname{Re}(\lambda_1)<0$ and take the initial distribution to be
\[\rho_0=\rho_{eq}+\alpha\rho^{(1)},\qquad\alpha\in\mathbb R.\]''','''def complexInitialDensity {n : ℕ}
    (ρeq ρ1 : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) (α : ℝ) : Prop :=
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (ρeq x).im=0 ∧ 0 ≤ (ρeq x).re) ∧
  Integrable (fun x ↦ (ρeq x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1 ∧
  (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
    (ρeq x+(α : ℂ)*ρ1 x).im=0 ∧ 0 ≤ (ρeq x+(α : ℂ)*ρ1 x).re) ∧
  Integrable (fun x ↦ (ρeq x+(α : ℂ)*ρ1 x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) ∧
  (∫ x, (ρeq x+(α : ℂ)*ρ1 x).re ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n)=1''',kind='definition',extra=['[EXTRA]明确真实初始概率的实性/非负/积分1，原单复模式不自动是概率；保留复Lp空间与复本征值，未缩成实负λ玩具。复共轭成对构造可另建，但原单模式需这些资格。'])
add('ComplexEigenmodeDecay','6.4.5',258,[126],r'''\[\rho(q,p,t)=e^{t\mathcal L_{LD}^*}\rho_0
=e^{t\mathcal L_{LD}^*}\rho_{eq}+\alpha e^{t\mathcal L_{LD}^*}\rho^{(1)}
=\rho_{eq}+\alpha e^{t\lambda_1}\rho^{(1)}.\]
Since $\operatorname{Re}(\lambda_1)<0$, this converges exponentially to the desired average.''','''theorem complexEigenmodeDecay : ∀ {n : ℕ},
  let E := Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)
  ∀ (S : ℝ≥0 → E →L[ℂ] E) (A : E →ₗ.[ℂ] E) (ρeq ρ1 : E) (α : ℝ) (ev : ℂ),
    S 0=ContinuousLinearMap.id ℂ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
    (∀ v, Continuous (fun t : ℝ≥0 ↦ S t v)) →
    (∀ v w, (v,w) ∈ A.graph → HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal v) w (Ici 0) 0) →
    (ρeq,0) ∈ A.graph → (ρ1,ev • ρ1) ∈ A.graph → ev.re < 0 →
    complexInitialDensity ρeq ρ1 α →
    (∀ t : ℝ≥0, S t (ρeq+(α : ℂ) • ρ1)=ρeq+((α : ℂ)*Complex.exp ((t : ℂ)*ev)) • ρ1) ∧
    ∀ f : E, ∀ t : ℝ≥0,
      ‖⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ-⟪f,ρeq⟫_ℂ‖ ≤
        |α| * ‖f‖*‖ρ1‖*Real.exp (ev.re*(t : ℝ)) := by
  sorry''',extra=['[EXTRA]完整复λ/Reλ<0及原α∈ℝ，真实flat Lp² initial probability资格；实际C0 semigroup/0处generator图关系、stationary/eigenvector为前提，完整全时exp模式及所有L²检验CS衰减为结论，没有把全时模式演化作假设。S需识别为实际Langevin前向传播，下一条登记，不冒充已识别。'],missing='缺复C0生成元本征模式的现成完整桥接及实际Langevin forward semigroup识别；不建设大型谱/半群理论。')
add('LangevinForwardSemigroupMeaning','6.4.5','257–258',[124,126],r'''\[\rho(q,p,t)=e^{t\mathcal L_{LD}^*}\rho_0(q,p).\]''','''def langevinForwardSemigroupMeaning {n : ℕ}
    (K : ℝ≥0 → Kernel (textbookLangevinPeriodicPhase n) (textbookLangevinPeriodicPhase n))
    (S : ℝ≥0 → Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →L[ℂ]
      Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n)) : Prop :=
  ∀ v : Lp ℂ 2 (MolecularDynamics.Chapter06Review.flatPhaseMeasure n),
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n, (v x).im=0 ∧ 0 ≤ (v x).re) →
    Integrable (fun x ↦ (v x).re) (MolecularDynamics.Chapter06Review.flatPhaseMeasure n) →
    ∀ t, MolecularDynamics.Chapter06Review.kernelEvolution K
      ((MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal (v x).re)) t =
      (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun x ↦ ENNReal.ofReal ((S t v x).re))''',kind='definition',extra=['[EXTRA]对所有真实非负实初始density的actual kernel/complex Lp²传播关联定义；不凭空把任意线性S命名Langevin，原forward identification仍未证。'])

# Structural identification is a premise about the physical forward semigroup,
# not the desired evolution of this eigenmode. Keep its definition before use.
mode=next(r for r in RECORDS if r['source_id'].endswith('-ComplexEigenmodeDecay'))
meaning=next(r for r in RECORDS if r['source_id'].endswith('-LangevinForwardSemigroupMeaning'))
RECORDS.remove(meaning);RECORDS.insert(RECORDS.index(mode),meaning)
mode['code']=mode['code'].replace('theorem complexEigenmodeDecay : ∀ {n : ℕ},','''theorem complexEigenmodeDecay : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) (U : (Fin n → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (β γ : ℝ)
    (hβ : 0 < β) (_hγ : 0 < γ), textbookIsWienerVector B P →''',1)
mode['code']=mode['code'].replace('    S 0=ContinuousLinearMap.id ℂ E →','''    langevinForwardSemigroupMeaning
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) S →
    (∀ᵐ x ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n,
      ρeq x=(textbookLangevinCanonicalDensity U β x : ℂ)) →
    S 0=ContinuousLinearMap.id ℂ E →''',1)
mode['code']=mode['code'].replace('    ∀ f : E, ∀ t : ℝ≥0,','''    (∀ f : E, ∀ t : ℝ≥0,
      ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ=⟪f,ρeq⟫_ℂ+
        ((α : ℂ)*Complex.exp ((t : ℂ)*ev))*⟪f,ρ1⟫_ℂ) ∧
    (∀ f : E, ∀ t : ℝ≥0,''',1)
mode['code']=mode['code'].replace('Real.exp (ev.re*(t : ℝ)) := by','''Real.exp (ev.re*(t : ℝ))) ∧
    ∀ f : E, Tendsto (fun t : ℝ≥0 ↦ ⟪f,S t (ρeq+(α : ℂ) • ρ1)⟫_ℂ)
      atTop (𝓝 ⟪f,ρeq⟫_ℂ) := by''',1)
mode['code']=mode['code'].replace('(ρ1,ev • ρ1) ∈ A.graph → ev.re < 0 →', '(ρ1,ev • ρ1) ∈ A.graph → ρ1 ≠ 0 → ev.re < 0 →',1)
mode['extra_assumptions'].append('[EXTRA]S与原实际周期Langevin核在全部非负可积初始密度上的关联及rhoeq与真实归一Gibbs density的AE识别均显式编码；模式演化、平均恒等、CS界及极限全部为结论，仍未计forward semigroup的存在/识别已证。')
