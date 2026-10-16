import MolecularDynamics.Chapter05.ReviewProofs
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
import Mathlib.Analysis.Calculus.ParametricIntegral
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.Calculus.LineDeriv.IntegrationByParts
import Mathlib.Analysis.Calculus.Taylor
import Mathlib.Analysis.SpecialFunctions.Gamma.Basic
import MolecularDynamics.Chapter01.ReviewDefinitions
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter05Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator
noncomputable section
namespace MD.Ch05
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- source_id: MD-5.1-LieDerivative · definition · §5.1 · 印刷p.180 / PDFp.201 -/
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)

/-- source_id: MD-5.1-TrajectoryChain · unnumbered_claim · §5.1 · 印刷p.180 / PDFp.201
[EXTRA] [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。 -/
theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption

/-- source_id: MD-5.1-ActualFlow · definition · §5.1 · 印刷p.180 / PDFp.201
[EXTRA] [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。 -/
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

/-- source_id: MD-5.1-ObservablePullback · definition · §5.1 · 印刷p.180–181 / PDFp.201–202 -/
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)

/-- source_id: MD-5.1-FlowFieldTransport · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。 
[EXTRA] 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。 -/
theorem flowFieldTransport :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z) := by
  sorry

theorem flowFieldTransport_observable (n : ℕ)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hΦ : ContDiff ℝ 2 (Function.uncurry Φ))
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) (_hg : ContDiff ℝ 1 g) (t : ℝ)
    (z : MolecularDynamics.Chapter05Review.E n) :
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z)) ∧
    (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z))=
      (fderiv ℝ g (Φ t z)) (f (Φ t z)) ∧
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
  sorry

/-- source_id: MD-5.1-PullbackPDE · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。 -/
theorem pullbackPDE :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => MolecularDynamics.Chapter05Review.pullback Φ g s z) (MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z) t := by
  sorry

/-- source_id: MD-5.1-SteadyFirstIntegral · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。 -/
theorem steadyFirstIntegral :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → Differentiable ℝ g → ((∀ z,MolecularDynamics.Chapter05Review.lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z) := by
  intro n f Φ g hflow hg
  constructor
  · intro hz t z
    have ht : ∀ s : ℝ,HasDerivAt (fun u => g (Φ u z)) 0 s := by
      intro s
      have hc := (hg (Φ s z)).hasFDerivAt.comp_hasDerivAt s (hflow.2.2 s z)
      change HasDerivAt (fun u => g (Φ u z)) (MolecularDynamics.Chapter05Review.lie f g (Φ s z)) s at hc
      rw [hz] at hc
      exact hc
    have hh := is_const_of_deriv_eq_zero (fun s => (ht s).differentiableAt) (fun s => (ht s).deriv)
    simpa only [hflow.1] using hh t 0
  · intro hh z
    have hd := (hg (Φ 0 z)).hasFDerivAt.comp_hasDerivAt 0 (hflow.2.2 0 z)
    have heq : (fun s => g (Φ s z))=(fun _ : ℝ => g z) := funext (fun s => hh s z)
    simp only [Function.comp_def] at hd
    rw [heq] at hd
    simpa only [MolecularDynamics.Chapter05Review.lie,hflow.1] using
      hd.unique (hasDerivAt_const 0 (g z))

/-- source_id: MD-5.1-CoordinatePullback · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202 -/
theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i := by
  apply MolecularDynamics.Chapter05Review.coordinatePullback_proved <;> assumption

/-- source_id: MD-5.1-SolutionOperator · definition · §5.1 · 印刷p.181 / PDFp.202 
[EXTRA] 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。 -/
def solutionOperator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.pullback Φ g t

theorem solutionOperator_initial {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (hf : MolecularDynamics.Chapter05Review.flow f Φ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) :
    solutionOperator f Φ hf 0 g=g := by
  sorry

/-- source_id: MD-5.1-CoordinateLie · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202 -/
theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i := by
  intro n f z i
  change (fderiv ℝ (fun x : MolecularDynamics.Chapter05Review.E n => x i) z) (f z)=f z i
  change (fderiv ℝ (PiLp.proj 2 (fun _ : Fin n => ℝ) i : MolecularDynamics.Chapter05Review.E n →L[ℝ] ℝ) z) (f z)=f z i
  rw [ContinuousLinearMap.fderiv]
  rfl

/-- source_id: MD-5.1-LiePullbackCommutes · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。 -/
theorem liePullbackCommutes : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
  sorry

/-- source_id: MD-5.2.1-DensityOn · definition · §5.2.1 · 印刷p.182 / PDFp.203
[EXTRA] [EXTRA]域外值不影响受限积分；NullMeasurableSet表达Lebesgue完备化可测域，AEMeasurable表达受限Lebesgue可测函数；非负且可积对应有限非负积分。 -/
def densityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D

/-- source_id: MD-5.2.1-ProbabilityDensityOn · definition · §5.2.1 · 印刷p.182 / PDFp.203 -/
def probabilityDensityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1

/-- source_id: MD-5.2.1-DensityOnNormalization · unnumbered_claim · §5.2.1 · 印刷p.182 / PDFp.203 -/
theorem densityOnNormalization : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityOn D ρ → 0 < (∫ z in D,ρ z) →
    probabilityDensityOn D (fun z => ρ z/(∫ x in D,ρ x)) := by
  intro n D ρ hd hp
  refine ⟨⟨hd.1,hd.2.1.div_const _,?_,hd.2.2.2.div_const _⟩,?_⟩
  · intro z hz
    exact div_nonneg (hd.2.2.1 z hz) hp.le
  · rw [integral_div,div_self hp.ne']

/-- source_id: MD-5.2.1-DensityProbability · definition · §5.2.1 · 印刷p.182 / PDFp.203 -/
def densityProbability {n : ℕ} (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) : ℝ :=
  ∫ z in A,ρ z

/-- source_id: MD-5.2.1-DensityMeasureOn · definition · §5.2.1 · 印刷p.182 / PDFp.203
[EXTRA] [EXTRA]实际受限Lebesgue测度的withDensity实现；概率归一化需要上条完整条件，不限制一般概率测度都必须有密度。 -/
def densityMeasureOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))

/-- source_id: MD-5.2.1-LebesgueClosure · unnumbered_claim · §5.2.1 · 印刷p.182 / PDFp.203 -/
theorem lebesgueClosure : ∀ n (s : Set (MolecularDynamics.Chapter05Review.E n)) (A : ℕ → Set (MolecularDynamics.Chapter05Review.E n)),
  (IsOpen s → NullMeasurableSet s volume) ∧ (IsClosed s → NullMeasurableSet s volume) ∧
  ((∀ k,NullMeasurableSet (A k) volume) →
    NullMeasurableSet (⋃ k,A k) volume ∧ NullMeasurableSet (⋂ k,A k) volume) := by
  intro n s A
  refine ⟨fun h => h.measurableSet.nullMeasurableSet,fun h => h.measurableSet.nullMeasurableSet,?_⟩
  intro h
  exact ⟨NullMeasurableSet.iUnion h,NullMeasurableSet.iInter h⟩

/-- source_id: MD-5.2.1-BorelSigma · definition · §5.2.1 · 印刷p.182 / PDFp.203 -/
def borelSigma (n : ℕ) : MeasurableSpace (MolecularDynamics.Chapter05Review.E n) := borel (MolecularDynamics.Chapter05Review.E n)

/-- source_id: MD-5.2.1-DensityProbabilityBounds · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204
[EXTRA] 原上下文的A⊆D和Lebesgue可测A明确写入，不把“µ已是概率测度”代替密度归一化所需证明。 -/
theorem densityProbabilityBounds : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  probabilityDensityOn D ρ → A ⊆ D → NullMeasurableSet A volume →
    0 ≤ densityProbability ρ A ∧ densityProbability ρ A ≤ 1 := by
  intro n D A ρ hp hAD hA
  have hnD : 0 ≤ᵐ[volume.restrict D] ρ := by
    filter_upwards [ae_restrict_mem₀ hp.1.1] with z hz
    exact hp.1.2.2.1 z hz
  have hnA : 0 ≤ᵐ[volume.restrict A] ρ := by
    filter_upwards [ae_restrict_mem₀ hA] with z hz
    exact hp.1.2.2.1 z (hAD hz)
  refine ⟨setIntegral_nonneg_of_ae_restrict hnA,?_⟩
  change (∫ z in A,ρ z) ≤ 1
  rw [← hp.2]
  exact setIntegral_mono_set hp.1.2.2.2 hnD (Filter.Eventually.of_forall hAD)

/-- source_id: MD-5.2.1-DomainL2 · definition · §5.2.1 · 印刷p.183 / PDFp.204
[EXTRA] [EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。 -/
@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)

/-- source_id: MD-5.2.1-L2Norm · definition · §5.2.1 · 印刷p.183 / PDFp.204 -/
def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖

/-- source_id: MD-5.2.1-L2Inner · definition · §5.2.1 · 印刷p.183 / PDFp.204 -/
def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z

/-- source_id: MD-5.2.1-L2NormSquare · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204 -/
theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g := by
  intro n D g
  change ‖g‖^2=∫ z in D,g z*g z
  simpa only [MeasureTheory.L2.inner_def,Real.inner_apply] using (real_inner_self_eq_norm_sq g).symm

/-- source_id: MD-5.2.1-L2Complete · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204
[EXTRA] [EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。 -/
theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu

/-- source_id: MD-5.2.1-L2SymmetricBilinear · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204 -/
theorem domainL2SymmetricBilinear : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f := by
  intro n D f g h a b
  have hi : ∀ u v : domainL2 n D,domainL2Inner u v=inner ℝ u v := by
    intro u v
    simp only [domainL2Inner,MeasureTheory.L2.inner_def,Real.inner_apply]
  simp only [hi,inner_add_left,inner_smul_left,real_inner_comm]
  simp

/-- source_id: MD-5.2.1-CompactL2 · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204 -/
theorem compactL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume := by
  intro n g hg hs
  exact hg.memLp_of_hasCompactSupport hs

/-- source_id: MD-5.2.1-DensityAverageOn · definition · §5.2.1 · 印刷p.184 / PDFp.205 -/
def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)

/-- source_id: MD-5.2.1-ClosedSupport · definition · §5.2.1 · 印刷p.183 / PDFp.204 -/
def closedSupport {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) : Set (MolecularDynamics.Chapter05Review.E n) := tsupport f

/-- source_id: MD-5.2.1-GaussianL2 · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204 -/
theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume := by
  intro n a ha
  have hc : Continuous (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) := by fun_prop
  rw [memLp_two_iff_integrable_sq hc.aestronglyMeasurable]
  have hi := GaussianFourier.integrable_cexp_neg_sum_mul_add (ι := Fin n) (b := fun i => ((2*a i : ℝ) : ℂ))
    (by intro i; simpa using (mul_pos (by norm_num : (0 : ℝ)<2) (ha i))) (fun _ => (0 : ℂ))
  have hr : Integrable (fun v : Fin n → ℝ => Real.exp (-(∑ i,(2*a i)*(v i)^2))) volume := by
    have hreal := hi.re
    change Integrable (fun v : Fin n → ℝ => (Complex.exp (-(∑ i,((2*a i : ℝ) : ℂ)*(v i : ℂ)^2)+(∑ i,(0 : ℂ)*(v i : ℂ)))).re) volume at hreal
    simpa only [zero_mul,Finset.sum_const_zero,add_zero,← Complex.ofReal_pow,← Complex.ofReal_mul,
      ← Complex.ofReal_sum,← Complex.ofReal_neg,Complex.exp_ofReal_re] using hreal
  have he : Integrable (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,(2*a i)*(z i)^2))) volume := by
    rw [← (PiLp.volume_preserving_toLp (Fin n)).integrable_comp_emb (MeasurableEquiv.toLp 2 _).measurableEmbedding]
    exact hr
  convert he using 1
  funext z
  rw [← Real.exp_nat_mul]
  congr 1
  simp only [mul_assoc,← Finset.mul_sum]
  ring

/-- source_id: MD-5.2.1-FiniteJumpL2 · unnumbered_claim · §5.2.1 · 印刷p.183 / PDFp.204
[EXTRA] [EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。 -/
theorem finiteJumpL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ) (S : Set (MolecularDynamics.Chapter05Review.E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume := by
  intro n g S hS hs hc hb
  have hm : Measurable g := hc.measurable_of_countable_compl (by simpa only [compl_compl] using hS.countable)
  have hl : ∀ z,∃ C > 0,∀ᶠ x in 𝓝 z,|g x| ≤ C := by
    intro z
    by_cases hz : z ∈ S
    · obtain ⟨C,hC,U,hU,hbU⟩ := hb z hz
      exact ⟨C,hC,Filter.mem_of_superset hU hbU⟩
    · have hcont := hc.continuousAt (hS.isClosed.isOpen_compl.mem_nhds hz)
      refine ⟨|g z|+1,by positivity,?_⟩
      exact (hcont.abs.eventually_lt_const (lt_add_one _)).mono (fun _ h => h.le)
  have hbound : ∃ C > 0,∀ x ∈ tsupport g,|g x| ≤ C := by
    apply hs.induction_on (p := fun A => ∃ C > 0,∀ x ∈ A,|g x| ≤ C)
    · exact ⟨1,by norm_num,by simp⟩
    · intro A B hAB hB
      obtain ⟨C,hC,hCB⟩ := hB
      exact ⟨C,hC,fun x hx => hCB x (hAB hx)⟩
    · intro A B hA hB
      obtain ⟨C,hC,hCA⟩ := hA
      obtain ⟨D,hD,hDB⟩ := hB
      refine ⟨max C D,lt_of_lt_of_le hC (le_max_left _ _),?_⟩
      intro x hx
      rcases hx with hx|hx
      · exact (hCA x hx).trans (le_max_left _ _)
      · exact (hDB x hx).trans (le_max_right _ _)
    · intro z hz
      obtain ⟨C,hC,hCL⟩ := hl z
      exact ⟨{x | |g x| ≤ C},mem_nhdsWithin_of_mem_nhds hCL,C,hC,fun _ hx => hx⟩
  obtain ⟨C,hC,hBC⟩ := hbound
  apply hs.memLp_of_bound hm.aestronglyMeasurable C
  filter_upwards [] with x
  by_cases hx : x ∈ tsupport g
  · simpa only [Real.norm_eq_abs] using hBC x hx
  · rw [image_eq_zero_of_notMem_tsupport hx,norm_zero]
    exact hC.le

/-- source_id: MD-5.2.1-NormalizedAverageFormula · unnumbered_claim · §5.2.1 · 印刷p.184 / PDFp.205 -/
theorem normalizedAverageFormula : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x))) := by
  intro n D ρ g
  simp only [densityAverageOn,← mul_div_assoc,integral_div]

/-- source_id: MD-5.2.2-MassFraction · definition · §5.2.2 · 印刷p.184 / PDFp.205 -/
def massFraction {n : ℕ} (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) := ∫ z in A,ρ t z

/-- source_id: MD-5.2.2-MassDerivative · unnumbered_claim · §5.2.2 · 印刷p.184 / PDFp.205
[EXTRA] [EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。 
[EXTRA] 保留已证的一阶积分交换，补紧空间域和联合C∞密度下质量函数C∞结论；紧域给各阶局部支配的充分资格，非结论前提。 -/
theorem massDerivative :
  ∀ n (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) t,
  MeasurableSet A → (∀ s,IntegrableOn (ρ s) A) →
  (∃ δ > 0, ∃ b : MolecularDynamics.Chapter05Review.E n → ℝ, IntegrableOn b A ∧
    (∀ s ∈ Ioo (t-δ) (t+δ), ∀ z ∈ A, HasDerivAt (fun u => ρ u z) (deriv (fun u => ρ u z) s) s ∧
      |deriv (fun u => ρ u z) s| ≤ b z)) →
  HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A) (∫ z in A,deriv (fun u => ρ u z) t) t := by
  intro n ρ A t hA hint hloc
  obtain ⟨δ,hδ,b,hb,hlocal⟩ := hloc
  have ht : t ∈ Ioo (t-δ) (t+δ) := ⟨by linarith,by linarith⟩
  have hm : AEStronglyMeasurable (fun z => deriv (fun u => ρ u z) t) (volume.restrict A) := by
    apply aestronglyMeasurable_of_tendsto_ae (𝓝[≠] (0 : ℝ))
      (f := fun h z => h⁻¹*(ρ (t+h) z-ρ t z))
    · intro h
      exact ((hint (t+h)).aestronglyMeasurable.sub (hint t).aestronglyMeasurable).const_mul _
    · filter_upwards [ae_restrict_mem hA] with z hz
      simpa only [smul_eq_mul] using (hlocal t ht z hz).1.tendsto_slope_zero
  have he := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume.restrict A) (F := ρ) (F' := fun s z => deriv (fun u => ρ u z) s)
    (bound := b) (Ioo_mem_nhds (by linarith) (by linarith))
    (Filter.Eventually.of_forall (fun s => (hint s).aestronglyMeasurable)) (hint t) hm
    ((ae_restrict_mem hA).mono (fun z hz s hs => by
      simpa only [Real.norm_eq_abs] using (hlocal s hs z hz).2)) hb
    ((ae_restrict_mem hA).mono (fun z hz s hs => (hlocal s hs z hz).1))
  simpa only [MolecularDynamics.Chapter05Review.massFraction] using! he.2

theorem massDerivative_smooth (n : ℕ)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ)
    (A : Set (MolecularDynamics.Chapter05Review.E n))
    (_hA : MeasurableSet A) (_hc : IsCompact A)
    (_hρ : ContDiff ℝ ∞ (Function.uncurry ρ)) :
    ContDiff ℝ ∞ (MolecularDynamics.Chapter05Review.massFraction ρ A) := by
  sorry

/-- source_id: MD-5.2.2-OutwardNormal · definition · §5.2.2 · 印刷p.184 / PDFp.205
[EXTRA] [EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。 -/
def outwardNormalFor {n : ℕ} (A : Set (MolecularDynamics.Chapter05Review.E n)) (ν : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set (MolecularDynamics.Chapter05Review.E n),∃ r : MolecularDynamics.Chapter05Review.E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ MolecularDynamics.Chapter05Review.grad r z ≠ 0 ∧
    ν z=‖MolecularDynamics.Chapter05Review.grad r z‖⁻¹ • MolecularDynamics.Chapter05Review.grad r z

/-- source_id: MD-5.2.2-GeneralFluxBalance · unnumbered_claim · §5.2.2 · 印刷p.184 / PDFp.205
[EXTRA] [EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。 -/
theorem generalFluxBalance : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ν f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
  (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)))) t ∧
    (∫ z in A,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1)) := by
  sorry

/-- source_id: MD-5.2.2-Divergence · definition · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian展示式中散度符号的真实导数迹辅助定义；完整M_f w=−div(wf)由MD-5.2.2-Liouvillian承担。 -/
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap

/-- source_id: MD-5.2.2-Liouvillian · definition · §5.2.2 · 印刷p.185 / PDFp.206 -/
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z

/-- source_id: MD-5.2.2-LiouvilleEquation · unnumbered_claim · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。 -/
theorem liouvilleEquation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry

/-- source_id: MD-5.2.2-LiouvilleProduct · unnumbered_claim · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 -/
theorem liouvilleProduct :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z = -ρ z*MolecularDynamics.Chapter05Review.divergence f z-MolecularDynamics.Chapter05Review.lie f ρ z := by
  intro n f ρ z hf hρ
  have hd := hρ.hasFDerivAt.smul hf.hasFDerivAt
  change HasFDerivAt (fun x => ρ x • f x)
    (ρ z • fderiv ℝ f z+(fderiv ℝ ρ z).smulRight (f z)) z at hd
  unfold MolecularDynamics.Chapter05Review.liouvillian MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.lie
  rw [hd.fderiv]
  change -(LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
    (ρ z • (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z).toLinearMap.smulRight (f z))) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-
      (fderiv ℝ ρ z) (f z)
  simp only [map_add,map_smul,LinearMap.trace_smulRight,smul_eq_mul]
  change -(ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z) (f z)) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-(fderiv ℝ ρ z) (f z)
  ring

/-- source_id: MD-5.2.2-LieCoordinates · unnumbered_claim · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。 -/
theorem lieCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  MolecularDynamics.Chapter05Review.lie f g z=∑ i,f z i*(fderiv ℝ g z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f g z
  unfold MolecularDynamics.Chapter05Review.lie
  have h := congrArg (fderiv ℝ g z) ((EuclideanSpace.basisFun (Fin n) ℝ).toBasis.sum_repr (f z)).symm
  simpa only [map_sum,map_smul,smul_eq_mul,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis] using h

/-- source_id: MD-5.2.2-DivergenceCoordinates · unnumbered_claim · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 -/
theorem divergenceCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) z,
  DifferentiableAt ℝ f z → MolecularDynamics.Chapter05Review.divergence f z=
    ∑ i,(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f z hf
  unfold MolecularDynamics.Chapter05Review.divergence
  rw [LinearMap.trace_eq_matrix_trace ℝ (EuclideanSpace.basisFun (Fin n) ℝ).toBasis]
  simp only [Matrix.trace,Matrix.diag,LinearMap.toMatrix_apply,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis]
  apply Finset.sum_congr rfl
  intro i hi
  have hc := (PiLp.proj 2 (fun _ : Fin n => ℝ) i).hasFDerivAt.comp z hf.hasFDerivAt
  change HasFDerivAt (fun x => f x i) _ z at hc
  rw [hc.fderiv]
  rfl

/-- source_id: MD-5.2.2-LiouvilleProductCoordinates · unnumbered_claim · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。 
[EXTRA] 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。 -/
theorem liouvilleProductCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z=-(∑ i : Fin n,(ρ z*(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+
    f z i*(fderiv ℝ ρ z) (EuclideanSpace.basisFun (Fin n) ℝ i))) := by
  intro n f ρ z hf hρ
  rw [liouvilleProduct n f ρ z hf hρ,divergenceCoordinates n f z hf,lieCoordinates n f ρ z]
  rw [Finset.sum_add_distrib,← Finset.mul_sum]
  ring

theorem liouvilleProductCoordinates_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (-(∑ i : Fin n,(ρ t z*(fderiv ℝ (fun x ↦ f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+f z i*(fderiv ℝ (ρ t) z) (EuclideanSpace.basisFun (Fin n) ℝ i)))) t := by
  sorry

/-- source_id: MD-5.2.2-RectangularDomain · definition · §5.2.2 · 印刷p.184 / PDFp.205
[EXTRA] [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。 -/
def rectangularDomain {n : ℕ} (a b : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.rectangle a b

/-- source_id: MD-5.2.2-FaceFlux · definition · §5.2.2 · 印刷p.184 / PDFp.205
[EXTRA] [EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 -/
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))

/-- source_id: MD-5.2.2-BoxFluxBalance · unnumbered_claim · §5.2.2 · 印刷p.184 / PDFp.205
[EXTRA] [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。 -/
theorem fluxBalance :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,MolecularDynamics.Chapter05Review.probabilityDensity (ρ t)) →
  (∀ t,MolecularDynamics.Chapter05Review.densityMeasure (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i)) := by
  sorry

/-- source_id: MD-5.2.2-BoundaryTerm · definition · §5.2.2 · 印刷p.185 / PDFp.206 -/
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))

/-- source_id: MD-5.2.2-TruncatedIntegrationByParts · unnumbered_claim · §5.2.2 · 印刷p.185 / PDFp.206
[EXTRA] [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。 -/
theorem truncatedIntegrationByParts : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := MolecularDynamics.Chapter05Review.rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*MolecularDynamics.Chapter05Review.lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry

/-- source_id: MD-5.2.2-RapidAdjoint · unnumbered_claim · §5.2.2 · 印刷p.185–186 / PDFp.206–207
[EXTRA] [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。 -/
theorem rapidAdjoint : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry

/-- source_id: MD-5.2.2-CompactAdjoint · unnumbered_claim · §5.2.2 · 印刷p.185–186 / PDFp.206–207
[EXTRA] [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。 -/
theorem liouvillianAdjoint :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry

/-- source_id: MD-5.2.2-MeasurePropagator · definition · §5.2.2 · 印刷p.186 / PDFp.207 
[EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。 -/
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ

def measurePropagator_general {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ

theorem measurePropagator_density_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry

/-- source_id: MD-5.2.3-HamiltonianDivergence · unnumbered_claim · §5.2.3 · 印刷p.186 / PDFp.207
[EXTRA] [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。 -/
theorem hamiltonianDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption

/-- source_id: MD-5.2.3-HamiltonianSkewExpression · unnumbered_claim · §5.2.3 · 印刷p.186 / PDFp.207
[EXTRA] [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。 -/
theorem hamiltonianSkewExpression :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  ∀ z,MolecularDynamics.Chapter05Review.liouvillian f u z= -MolecularDynamics.Chapter05Review.lie f u z := by
  intro n f u hf hu hdiv z
  rw [liouvilleProduct n f u z (hf z) (hu z),hdiv z]
  ring

/-- source_id: MD-5.2.3-HamiltonianDensityPropagation · unnumbered_claim · §5.2.3 · 印刷p.187 / PDFp.208
[EXTRA] [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。 -/
theorem hamiltonianDensityPropagation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D ρ) := by
  sorry

/-- source_id: MD-5.2.3-MechanicalLiouvillian · definition · §5.2.3 · 印刷p.187 / PDFp.208 -/
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)

/-- source_id: MD-5.2.3-MechanicalLiouvillianIdentity · unnumbered_claim · §5.2.3 · 印刷p.187 / PDFp.208
[EXTRA] [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。 -/
theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : MolecularDynamics.Chapter05Review.Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) (MolecularDynamics.Chapter05Review.hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    MolecularDynamics.Chapter05Review.mechanicalLiouvillian m (fun q => -gradient U q) u z := by
  sorry

/-- source_id: MD-5.3.1-TestSpace · definition · §5.3.1 · 印刷p.188 / PDFp.209 
[EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。 -/
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}

/-- source_id: MD-5.3.1-SchwartzSpace · definition · §5.3.1 · 印刷p.188 / PDFp.209
[EXTRA] [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。 -/
def schwartzTestSpace (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ

/-- source_id: MD-5.3.1-GeneralizedFunction · definition · §5.3.1 · 印刷p.188 / PDFp.209 -/
def generalizedFunction (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ

/-- source_id: MD-5.3.1-SchwartzFunctional · definition · §5.3.1 · 印刷p.188 / PDFp.209
[EXTRA] [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。 -/
def schwartzFunctional (n : ℕ) := (MolecularDynamics.Chapter05Review.schwartzSpace n) →ₗ[ℝ] ℝ

/-- source_id: MD-5.3.1-RegularDistribution · definition · §5.3.1 · 印刷p.188 / PDFp.209 -/
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z

/-- source_id: MD-5.3.1-RegularDistributionLinearity · unnumbered_claim · §5.3.1 · 印刷p.188 / PDFp.209
[EXTRA] [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。 
[EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。 -/
theorem regularDistributionLinearity : ∀ n (f : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ ∞ f → (∃ C : ℝ,∀ z,|f z| ≤ C) →
  (∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,Integrable (fun z => f z*φ z) volume) ∧
  (∀ (φ ψ : MolecularDynamics.Chapter05Review.schwartzSpace n) (a b : ℝ),
    MolecularDynamics.Chapter05Review.regularDistribution f (a • φ+b • ψ)=a*MolecularDynamics.Chapter05Review.regularDistribution f φ+b*MolecularDynamics.Chapter05Review.regularDistribution f ψ) := by
  intro n f hf hb
  obtain ⟨C,hC⟩ := hb
  have hi : ∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,
      Integrable (fun z => f z*φ z) volume := by
    intro φ
    apply Integrable.mono' (φ.integrable.norm.mul_const C)
    · exact hf.continuous.measurable.aestronglyMeasurable.mul φ.continuous.measurable.aestronglyMeasurable
    · filter_upwards [] with z
      simpa only [norm_mul,Real.norm_eq_abs,mul_comm] using mul_le_mul_of_nonneg_right (hC z) (abs_nonneg (φ z))
  refine ⟨hi,?_⟩
  intro φ ψ a b
  simp only [MolecularDynamics.Chapter05Review.regularDistribution,SchwartzMap.add_apply,SchwartzMap.smul_apply,smul_eq_mul]
  simp_rw [mul_add,← mul_assoc,mul_comm (f _) a,mul_comm (f _) b]
  simp_rw [mul_assoc]
  rw [integral_add ((hi φ).const_mul a) ((hi ψ).const_mul b),integral_const_mul,integral_const_mul]

/-- source_id: MD-5.3.1-DiracAction · definition · §5.3.1 · 印刷p.189 / PDFp.210 -/
def diracAction {n : ℕ} (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := φ 0

/-- source_id: MD-5.3.1-DiracMeasure · definition · §5.3.1 · 印刷p.189 / PDFp.210 -/
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0

/-- source_id: MD-5.3.1-DiracApproximation · unnumbered_claim · §5.3.1 · 印刷p.189 / PDFp.210
[EXTRA] [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。 -/
theorem diracApproximation :
  ∀ n (r : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ ε > 0,Continuous (r ε)) →
  (∀ ε > 0,MolecularDynamics.Chapter05Review.probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro n r hr hp hs φ hφ
  apply Metric.tendsto_nhds.mpr
  intro e he
  obtain ⟨δ,hδ,hφδ⟩ := Metric.continuousAt_iff.mp hφ.continuousAt (e/2) (by positivity)
  obtain ⟨η,hη,hsη⟩ := hs δ hδ
  filter_upwards [Ioo_mem_nhdsGT hη] with ε hε
  have hd := (hp ε hε.1).1
  have hmass := (hp ε hε.1).2
  have hb : ∀ z,‖(φ z-φ 0)*r ε z‖ ≤ (e/2)*r ε z := by
    intro z
    by_cases hz : r ε z=0
    · simp [hz]
    · have hzball := hsη ε hε (show z ∈ Function.support (r ε) from hz)
      have heφ := hφδ (by simpa only [Metric.mem_ball] using hzball)
      simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hd.2.1 z),Real.dist_eq] using
        mul_le_mul_of_nonneg_right heφ.le (hd.2.1 z)
  have hdiff : Integrable (fun z => (φ z-φ 0)*r ε z) volume := by
    apply Integrable.mono' (hd.2.2.const_mul (e/2))
    · exact ((hφ.sub continuous_const).mul (hr ε hε.1)).measurable.aestronglyMeasurable
    · exact ae_of_all _ hb
  have hpr : Integrable (fun z => φ z*r ε z) volume := by
    convert hdiff.add (hd.2.2.const_mul (φ 0)) using 1
    funext z
    change φ z*r ε z=(φ z-φ 0)*r ε z+φ 0*r ε z
    ring
  have hi : (∫ z,(φ z-φ 0)*r ε z)=(∫ z,φ z*r ε z)-φ 0 := by
    simp_rw [sub_mul]
    rw [integral_sub hpr (hd.2.2.const_mul (φ 0)),integral_const_mul,hmass,mul_one]
  have hle := norm_integral_le_of_norm_le (hd.2.2.const_mul (e/2)) (ae_of_all _ hb)
  rw [integral_const_mul,hmass,mul_one,hi] at hle
  rw [dist_eq_norm]
  exact hle.trans_lt (by linarith)

/-- source_id: MD-5.3.1-GaussianDelta · definition · §5.3.1 · 印刷p.189 / PDFp.210 -/
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)

/-- source_id: MD-5.3.1-DiracEvaluates · unnumbered_claim · §5.3.1 · 印刷p.189 / PDFp.210 -/
theorem diracEvaluates : ∀ n (φ : MolecularDynamics.Chapter05Review.schwartzSpace n),
  (∫ z,φ z ∂(MolecularDynamics.Chapter05Review.diracMeasure n))=MolecularDynamics.Chapter05Review.diracAction φ := by
  intro n φ
  simp [MolecularDynamics.Chapter05Review.diracMeasure,MolecularDynamics.Chapter05Review.diracAction]

/-- source_id: MD-5.3.1-GaussianDeltaProbability · unnumbered_claim · §5.3.1 · 印刷p.189 / PDFp.210
[EXTRA] [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。 -/
theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ MolecularDynamics.Chapter05Review.gaussianDelta ε x) ∧ Integrable (MolecularDynamics.Chapter05Review.gaussianDelta ε) volume ∧
  (∫ x,MolecularDynamics.Chapter05Review.gaussianDelta ε x)=1 := by
  intro ε hε
  have he0 : ε ≠ 0 := ne_of_gt hε
  have hcoef : 0 < (1 : ℝ)/(2*ε) := by positivity
  have heq : MolecularDynamics.Chapter05Review.gaussianDelta ε=
      (fun x : ℝ => Real.exp (-(1/(2*ε))*x^2)/Real.sqrt (2*Real.pi*ε)) := by
    funext x
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    congr 2
    ring
  rw [heq]
  refine ⟨fun x => by positivity,?_,?_⟩
  · exact (integrable_exp_neg_mul_sq hcoef).div_const _
  · rw [integral_div,integral_gaussian]
    have hp0 : 0 ≤ 2*Real.pi*ε := by positivity
    have hratio : Real.pi/(1/(2*ε))=2*Real.pi*ε := by field_simp
    rw [hratio,div_self (ne_of_gt (Real.sqrt_pos.2 (by positivity)))]

/-- source_id: MD-5.3.1-GaussianDeltaWeak · unnumbered_claim · §5.3.1 · 印刷p.189 / PDFp.210
[EXTRA] [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。 -/
theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro φ hφ hb
  have hg := gaussianDeltaProbability 1 (by norm_num)
  obtain ⟨C,hC,hBC⟩ := hb.exists_pos_norm_le
  have ht : Tendsto (fun ε : ℝ => ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (𝓝[>] 0) (𝓝 (φ 0)) := by
    have hc := tendsto_integral_filter_of_dominated_convergence
      (fun x : ℝ => C*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (F:=fun ε x => φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (f:=fun x => φ 0*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (Filter.Eventually.of_forall (fun ε => by
        apply Continuous.aestronglyMeasurable
        unfold MolecularDynamics.Chapter05Review.gaussianDelta
        fun_prop))
      (Filter.Eventually.of_forall (fun ε => ae_of_all _ (fun x => by
        simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hg.1 x)] using
          mul_le_mul_of_nonneg_right (hBC (φ (Real.sqrt ε*x)) (mem_range_self _)) (hg.1 x))))
      (hg.2.1.const_mul C) (ae_of_all _ (fun x => by
        have hs : Tendsto (fun ε : ℝ => Real.sqrt ε*x) (𝓝[>] 0) (𝓝 0) := by
          simpa using! ((Real.continuous_sqrt.tendsto 0).mono_left inf_le_left).mul_const x
        exact (hφ.tendsto 0 |>.comp hs).mul_const _))
    simpa only [integral_const_mul,hg.2.2,mul_one] using hc
  apply tendsto_congr' _ |>.2 ht
  filter_upwards [self_mem_nhdsWithin] with ε hε
  have hεpos : 0 < ε := hε
  have hspos : 0 < Real.sqrt ε := Real.sqrt_pos.2 hεpos
  have hs0 : Real.sqrt ε ≠ 0 := ne_of_gt hspos
  have hpoint (x : ℝ) : Real.sqrt ε*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)=
      MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    rw [mul_pow,Real.sq_sqrt hεpos.le]
    have hexp : -(ε*x^2)/(2*ε)= -x^2/2 := by field_simp
    rw [hexp,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
    simp only [mul_one]
    field_simp
  calc
    (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=
      Real.sqrt ε*(∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)) := by
        change (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=Real.sqrt ε*(∫ x,(fun y => φ y*MolecularDynamics.Chapter05Review.gaussianDelta ε y) (Real.sqrt ε*x))
        have hchange : (∫ x : ℝ,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x))=
            (Real.sqrt ε)⁻¹*(∫ x : ℝ,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) := by
          simpa only [smul_eq_mul,abs_of_pos (inv_pos.mpr hspos)] using!
            (Measure.integral_comp_mul_left (fun x : ℝ => φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (Real.sqrt ε))
        rw [hchange]
        field_simp
    _ = ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
      rw [←integral_const_mul]
      apply integral_congr_ae
      filter_upwards [] with x
      rw [←hpoint]
      ring

/-- source_id: MD-5.3.2-WeakStationary · definition · §5.3.2 · 印刷p.189–190 / PDFp.210–211
[EXTRA] [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。 
[EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。 -/
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0

/-- source_id: MD-5.3.2-EnsembleAverage · definition · §5.3.2 · 印刷p.190 / PDFp.211 -/
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ

/-- source_id: MD-5.3.2-ConvergenceHeuristic · unnumbered_claim · §5.3.2 · 印刷p.190 / PDFp.211
[EXTRA] [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。 -/
theorem convergenceHeuristic : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → MolecularDynamics.Chapter05Review.flow f Φ → (∀ t,Φ t '' D=D) →
  (∀ t,MeasurePreserving (Φ t) volume volume) →
  ContDiff ℝ 1 (Function.uncurry ρ) → ContDiff ℝ ⊤ φ → HasCompactSupport φ →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0) →
    ∃ L : ℝ,Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L) := by
  sorry

/-- source_id: MD-5.3.2-HamiltonianEnergyIntegral · unnumbered_claim · §5.3.2 · 印刷p.190 / PDFp.211 
[EXTRA] 补真实Hamiltonian场的−div(u f)=−L_f u及实际解上能量恒定，H为C²、u为C¹、合法闭区间轨道；保留已证L_fH=0，不把散度零/能量守恒当假设。 -/
theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0 := by
  rw [MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson]
  exact MolecularDynamics.textbookPoissonBracket_self H z

theorem hamiltonianEnergyIntegral_full (k : ℕ)
    (H u : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (_hH : ContDiff ℝ 2 H) (_hu : ContDiff ℝ 1 u)
    (z : MolecularDynamics.SymplecticCoordinates k)
    (γ : ℝ → MolecularDynamics.SymplecticCoordinates k) (a b : ℝ) (_hab : a ≤ b)
    (_hγ : ∀ t ∈ Icc a b,HasDerivWithinAt γ
      (MolecularDynamics.textbookHamiltonianVectorField H (γ t)) (Icc a b) t) :
    -(LinearMap.trace ℝ (MolecularDynamics.SymplecticCoordinates k)
      (fderiv ℝ (fun x ↦ u x • MolecularDynamics.textbookHamiltonianVectorField H x) z).toLinearMap)=
        -MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) u z ∧
    (∀ t ∈ Icc a b,H (γ t)=H (γ a)) := by
  sorry

/-- source_id: MD-5.3.2-EnergyDensityInvariant · unnumbered_claim · §5.3.2 · 印刷p.190 / PDFp.211
[EXTRA] [EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。 -/
theorem energyDensityInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    Φ (r : ℝ → ℝ), MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,MolecularDynamics.Chapter05Review.lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ H) → ∀ t,
    MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H))=MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H) := by
  sorry

/-- source_id: MD-5.3.2-ShellWeight · definition · §5.3.2 · 印刷p.190 / PDFp.211 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅归一化密度公式中的未归一化指数权因子；完整Z与ρ由MD-5.3.2-ShellPartition及MD-5.3.2-ShellDensity承担。 -/
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))

/-- source_id: MD-5.3.2-ShellPartition · definition · §5.3.2 · 印刷p.190–191 / PDFp.211–212 -/
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z

/-- source_id: MD-5.3.2-ShellDensity · definition · §5.3.2 · 印刷p.190–191 / PDFp.211–212 -/
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε

/-- source_id: MD-5.3.2-EnergySurface · definition · §5.3.2 · 印刷p.191 / PDFp.212 -/
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}

/-- source_id: MD-5.3.2-SurfaceMeasure · definition · §5.3.2 · 印刷p.191 / PDFp.212
[EXTRA] [EXTRA]采用实际规范化Hausdorff超面积受限于等值集合；其与光滑曲面的Gram图公式识别另条且未证。 -/
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)

/-- source_id: MD-5.3.2-MicroRaw · definition · §5.3.2 · 印刷p.191 / PDFp.212 -/
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))

/-- source_id: MD-5.3.2-ShellWeakPrinted · unnumbered_claim · §5.3.2 · 印刷p.191 / PDFp.212
[EXTRA] [EXTRA]此处记录全相空间版本D=ℝ^m，微正则测度定义给出分布配对目标；其他约束需重定义相应曲面。 -/
theorem shellWeakPrinted :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → ∀ φ : MolecularDynamics.Chapter05Review.testSpace n,
    Tendsto (fun ε => (MolecularDynamics.Chapter05Review.shellPartition H c ε)⁻¹*(∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry

/-- source_id: MD-5.3.2-ShellWeakLimitCorrected · unnumbered_claim · §5.3.2 · 印刷p.191 / PDFp.212
[EXTRA] [EXTRA]独立修正版：不再对已归一化ρ_ε重复除Zε；可达非空正则能量、C²、紧带及小ε权可积/分母正，全部明示。采用D=ℝ^m；不覆盖附加其他守恒约束的情形。 
[EXTRA] 恢复原smooth的C∞资格（∞），不把Cω误作C∞；旧证明重查，必要时按≤3次规则记录占位。 -/
theorem shellWeakLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → (∃ z,H z=c) →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (MolecularDynamics.Chapter05Review.shellWeight H c ε) volume ∧ 0 < MolecularDynamics.Chapter05Review.shellPartition H c ε)) →
  ∀ φ : MD.Ch05.testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*MolecularDynamics.Chapter05Review.shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microAverage H c φ.1)) := by
  sorry

/-- source_id: MD-5.3.2-SurfaceAreaFormula · unnumbered_claim · §5.3.2 · 印刷p.191 / PDFp.212
[EXTRA] [EXTRA]单射C¹浸入及实际Gram矩阵；书中的图须避免重复覆盖和退化，不能把任意光滑映射当无重数面积参数化。 -/
theorem surfaceAreaFormula :
  ∀ d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E (d+1)) (U : Set (MolecularDynamics.Chapter05Review.E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((MolecularDynamics.Chapter05Review.hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ)) := by
  sorry

/-- source_id: MD-5.3.2-NormalField · definition · §5.3.2 · 印刷p.192 / PDFp.213 -/
def normalField {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := ‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹ • MolecularDynamics.Chapter05Review.grad H z

/-- source_id: MD-5.3.2-NormalEnergyTaylor · unnumbered_claim · §5.3.2 · 印刷p.192 / PDFp.213
[EXTRA] [EXTRA]本条写正向实际C²局部Taylor余项O(ξ²)，原ΔE参数与反向ξ展开另条；非零梯度用于局部逆坐标，未以正向式替代所有结论。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅正向法线Taylor子引理；以ΔE为变量的逆存在及O(ΔE²)结论由MD-5.3.2-NormalInverseTaylor承担。 -/
theorem normalEnergyTaylor :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • MolecularDynamics.Chapter05Review.normalField H z)-H z-s*‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*s^2 := by
  sorry

/-- source_id: MD-5.3.2-NormalInverseTaylor · unnumbered_claim · §5.3.2 · 印刷p.192 / PDFp.213
[EXTRA] [EXTRA]实际C²和非零梯度，ξ由真实局部能量方程得到；保留反向ξ及以ΔE计的正向余项两个结论，不只证明O(ξ²)。 -/
theorem normalInverseTaylor : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.grad H z ≠ 0 → ∃ C > 0,∃ δ > 0,
  ∀ e : ℝ,|e| < δ → ∃ ξ : ℝ,
    H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)=H z+e ∧
    |ξ-e/‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ C*e^2 ∧
    |H (z+ξ • MolecularDynamics.Chapter05Review.normalField H z)-H z-‖MolecularDynamics.Chapter05Review.grad H z‖*ξ| ≤ C*e^2 := by
  sorry

/-- source_id: MD-5.3.2-PatchShellVolume · unnumbered_claim · §5.3.2 · 印刷p.192–193 / PDFp.213–214
[EXTRA] [EXTRA]实际紧可测正则曲面片M及薄法线管；原“clearly”体积式实际还需法线管Jacobian=1+O(ξ)，不是一般曲面的精确体积等式；最终O(ΔE)误差保留。 -/
theorem patchShellVolume : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (M : Set (MolecularDynamics.Chapter05Review.E n)),
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  IsCompact M → MeasurableSet M → M ⊆ MolecularDynamics.Chapter05Review.energySurface H c →
  ∃ C > 0,∃ δ > 0,∀ e ∈ Ioo 0 δ,
    |(volume {x | ∃ z ∈ M,∃ s ∈ Ico (0 : ℝ) δ,
        x=z+s • MolecularDynamics.Chapter05Review.normalField H z ∧ H x-H z ≤ e}).toReal/e-
        ((MolecularDynamics.Chapter05Review.microRaw H c) M).toReal| ≤ C*e := by
  sorry

/-- source_id: MD-5.3.2-WholeShellVolumeLimit · unnumbered_claim · §5.3.2 · 印刷p.192–193 / PDFp.213–214
[EXTRA] [EXTRA]整个正则紧能量面的壳层极限特例，原任意紧曲面片及O(ΔE)结论另条保留，不用特例替换原全结论。 -/
theorem shellVolumeLimit :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (MolecularDynamics.Chapter05Review.microPartition H c)) := by
  sorry

/-- source_id: MD-5.3.2-MicroRawInvariant · unnumbered_claim · §5.3.2 · 印刷p.193 / PDFp.214
[EXTRA] [EXTRA]原正文调用的实际全流、体积与能量保持先验明确写出；需要推出的是曲面加权raw测度保持，未把该结论作前提。 -/
theorem microRawInvariant : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microRaw H c) (MolecularDynamics.Chapter05Review.microRaw H c) ∧
    ∀ M,MeasurableSet M → (MolecularDynamics.Chapter05Review.microRaw H c) (Φ t '' M)=(MolecularDynamics.Chapter05Review.microRaw H c) M := by
  sorry

/-- source_id: MD-5.3.2-MicroInvariant · unnumbered_claim · §5.3.2 · 印刷p.193 / PDFp.214
[EXTRA] [EXTRA]归一化measure版本另列；原始未归一化µ的不变及集合像等式由上一完整条目保留，不能只凭归一化定义编译称全部已证。 -/
theorem microInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  ContDiff ℝ 2 H → MolecularDynamics.Chapter05Review.regularEnergy H c → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.microMeasure H c) := by
  sorry

/-- source_id: MD-5.3.2-MicroPartition · definition · §5.3.2 · 印刷p.193 / PDFp.214 -/
def microPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := ((MolecularDynamics.Chapter05Review.microRaw H c) univ).toReal

/-- source_id: MD-5.3.2-ShellPointValuePrinted · notation · §5.3.2 · 印刷p.191 / PDFp.212
[EXTRA] [EXTRA]Lean仅提供良类型的测试函数配对记号，不把配对记号的编译当原印刷等式的证明；完整正确弱极限另条，重复Z版本也保留。 -/
def shellWeakPairing {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.microAverage H c φ

/-- source_id: MD-5.3.2-HarmonicEnergy · Example 5.1 · §5.3.2 · 印刷p.193 / PDFp.214 
[EXTRA] 补非零频率、正能量下能量面椭圆的完整等价式；质量为单位，原定义与坐标顺序保留。 -/
def harmonicEnergy (Ω : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) := (z 1)^2/2+Ω^2*(z 0)^2/2

theorem harmonicEnergy_ellipse (Ω c : ℝ) (_hΩ : Ω ≠ 0) (_hc : 0 < c)
    (z : MolecularDynamics.Chapter05Review.E 2) :
    harmonicEnergy Ω z=c ↔
      (z 0/(Real.sqrt (2*c)/|Ω|))^2+(z 1/Real.sqrt (2*c))^2=1 := by
  sorry

/-- source_id: MD-5.3.2-HarmonicQuadraturePrinted · unnumbered_claim · §5.3.2 · 印刷p.193 / PDFp.214
[EXTRA] [EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。 -/
theorem harmonicQuadraturePrinted : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c),
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) := by
  sorry

/-- source_id: MD-5.3.2-HarmonicPartition · Example 5.1 · §5.3.2 · 印刷p.193 / PDFp.214
[EXTRA] [EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。 
[EXTRA] 保留真实曲面微正则质量终值，补其与正确参数积分的等式及该积分的终值；不更改原印首积分疑误。 -/
theorem harmonicPartition : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω := by
  sorry

theorem harmonicPartition_quadrature (Ω c : ℝ) (_hΩ : 0 < Ω) (_hc : 0 < c) :
    MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=
      4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2)) ∧
    4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2))=2*Real.pi/Ω := by
  sorry

/-- source_id: MD-5.3.2-IdealGasEnergy · Example 5.2 · §5.3.2 · 印刷p.193–194 / PDFp.214–215 -/
def idealGasEnergy (N : ℕ) (m : ℝ) (z : MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  (∑ i : Fin (3*N),(z (Fin.natAdd (3*N) i))^2)/(2*m)

/-- source_id: MD-5.3.2-IdealGasPositionDomain · definition · §5.3.2 · 印刷p.193–194 / PDFp.214–215
[EXTRA] [EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。 -/
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}

/-- source_id: MD-5.3.2-IdealGasPartition · Example 5.2 · §5.3.2 · 印刷p.193–194 / PDFp.214–215
[EXTRA] [EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。 
[EXTRA] 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。 -/
theorem idealGasPartition : ∀ (N : ℕ) (m c L : ℝ),0 < N → 0 < m → 0 < c → 0 < L →
  ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal=
    (L^3)^N*Real.rpow (2*Real.pi*m*c) ((3*N : ℝ)/2)/(c*Real.Gamma ((3*N : ℝ)/2)) := by
  sorry

theorem idealGasPartition_factors (N : ℕ) (m c L : ℝ)
    (_hN : 0 < N) (_hm : 0 < m) (_hc : 0 < c) (_hL : 0 < L) :
    let S := Metric.sphere (0 : MolecularDynamics.Chapter05Review.E (3*N)) (Real.sqrt (2*m*c))
    let A := (MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1) S).toReal
    let Z := ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal
    Z=(L^3)^N*(∫ p in S,m/Real.sqrt (2*m*c)
      ∂(MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1))) ∧
    Z=(L^3)^N*(m/Real.sqrt (2*m*c))*A ∧
    Z=(L^3)^N*(Real.sqrt m/Real.sqrt (2*c))*
      ((3*N : ℝ)*Real.rpow Real.pi ((3*N : ℝ)/2)*Real.rpow (2*m*c) (((3*N : ℝ)-1)/2)/
      Real.Gamma ((3*N : ℝ)/2+1)) := by
  sorry

/-- source_id: MD-5.3.3-MicroMeasure · definition · §5.3.3 · 印刷p.194 / PDFp.215
[EXTRA] [EXTRA]总raw质量正且有限是使用概率意义的必要资格；定义用实际ENNReal标量归一化，不把无穷总质量逆值0解释成概率测度。 -/
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c

/-- source_id: MD-5.3.3-MicroProbability · unnumbered_claim · §5.3.3 · 印刷p.195 / PDFp.216
[EXTRA] [EXTRA]原H光滑背景及正有限总质量明示；ΣE总概率1也保留，不仅证明ambient univ质量1。 -/
theorem microProbability : ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  ContDiff ℝ 1 H → 0 < (MolecularDynamics.Chapter05Review.microRaw H c) univ → (MolecularDynamics.Chapter05Review.microRaw H c) univ < (⊤ : ENNReal) →
  (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 ∧
    (MolecularDynamics.Chapter05Review.microMeasure H c) (MolecularDynamics.Chapter05Review.energySurface H c)=1 ∧
    ∀ A : Set (MolecularDynamics.Chapter05Review.E n),0 ≤ (MolecularDynamics.Chapter05Review.microMeasure H c) A ∧ (MolecularDynamics.Chapter05Review.microMeasure H c) A ≤ 1 := by
  intro n H c hH hpos hfin
  let σ := MolecularDynamics.Chapter05Review.energySurface H c
  have hσ : MeasurableSet σ := by
    exact (isClosed_eq hH.continuous continuous_const).measurableSet
  have hzero : (MolecularDynamics.Chapter05Review.microRaw H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microRaw
    apply withDensity_absolutelyContinuous
    unfold MolecularDynamics.Chapter05Review.surfaceMeasure
    rw [Measure.restrict_apply hσ.compl]
    simp [σ]
  have hu : (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,smul_eq_mul]
    exact ENNReal.inv_mul_cancel (ne_of_gt hpos) (ne_of_lt hfin)
  have hz : (MolecularDynamics.Chapter05Review.microMeasure H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,hzero,smul_zero]
  refine ⟨hu,?_,?_⟩
  · have hh := measure_add_measure_compl hσ (μ:=MolecularDynamics.Chapter05Review.microMeasure H c)
    simpa only [hz,add_zero,hu] using hh
  · intro A
    exact ⟨bot_le,(measure_mono (subset_univ A)).trans_eq hu⟩

/-- source_id: MD-5.3.3-LowerDimensionNull · unnumbered_claim · §5.3.3 · 印刷p.195 / PDFp.216
[EXTRA] [EXTRA]低维光滑参数化的紧像、正则C¹能量面，维数严格小于能量面；未将任意“拓扑低维集合”自动视为零测。 
[EXTRA] 保留紧面子引理，新增无需全能量面紧性的可数紧参数块零测推广，以及正则水平集局部同胚于开ℝ^(n−1)的维数结论（相空间n=2N_d）。环境Lebesgue零测也在本批同列。 -/
theorem lowerDimensionNull :
  ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : Set (MolecularDynamics.Chapter05Review.E d)), d+1 < n → ContDiff ℝ 1 H → MolecularDynamics.Chapter05Review.regularEnergy H c →
    ContDiff ℝ 1 g → IsCompact K →
    g '' K ⊆ MolecularDynamics.Chapter05Review.energySurface H c → (MolecularDynamics.Chapter05Review.microMeasure H c) (g '' K)=0 := by
  sorry

theorem lowerDimensionNull_countable (n d : ℕ)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ)
    (g : ℕ → MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n)
    (K : ℕ → Set (MolecularDynamics.Chapter05Review.E d)) (_hd : d+1 < n)
    (_hH : ContDiff ℝ 1 H)
    (_hreg : ∀ z,MolecularDynamics.Chapter05Review.energySurface H c z →
      MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (_hblocks : ∀ k,ContDiff ℝ 1 (g k) ∧ IsCompact (K k) ∧
      g k '' K k ⊆ MolecularDynamics.Chapter05Review.energySurface H c) :
    (MolecularDynamics.Chapter05Review.microMeasure H c) (⋃ k,g k '' K k)=0 ∧
      volume (⋃ k,g k '' K k)=0 := by
  sorry

theorem lowerDimensionNull_level_dimension (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 1 H)
    (c : ℝ) (_hreg : ∀ z,H z=c → MolecularDynamics.Chapter05Review.grad H z ≠ 0) :
    ∀ z,H z=c → ∃ U : Set (MolecularDynamics.Chapter05Review.E n),
      IsOpen U ∧ z ∈ U ∧ ∃ V : Set (MolecularDynamics.Chapter05Review.E (n-1)),
      IsOpen V ∧ Nonempty (V ≃ₜ ↥(MolecularDynamics.Chapter05Review.energySurface H c ∩ U)) := by
  sorry

/-- source_id: MD-5.3.3-MicroAverage · definition · §5.3.3 · 印刷p.195 / PDFp.216 
[EXTRA] 补曲面限制逆梯度积分等式，并以真实对称薄壳积分比极限表达归一化δ配对；紧正则能量带控制尾部，不把δ当普通Lebesgue函数或同测度重命名。 -/
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g

theorem microAverage_surface_and_delta_limit (n : ℕ) (_hn : 0 < n)
    (H : MolecularDynamics.Chapter05Review.E n → ℝ) (_hH : ContDiff ℝ 2 H)
    (c : ℝ) (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hband : ∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧
      ∀ z,|H z-c| ≤ δ → MolecularDynamics.Chapter05Review.grad H z ≠ 0)
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hφ : ContDiff ℝ ∞ φ)
    (_hc : HasCompactSupport φ) :
    microAverage H c φ=(MolecularDynamics.Chapter05Review.microPartition H c)⁻¹*
      (∫ z in MolecularDynamics.Chapter05Review.energySurface H c,
        φ z/‖MolecularDynamics.Chapter05Review.grad H z‖
        ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))) ∧
    Tendsto (fun ε : ℝ ↦
      (∫ z in {z | |H z-c| < ε},φ z)/
      (volume {z | |H z-c| < ε}).toReal) (𝓝[>] 0) (𝓝 (microAverage H c φ)) := by
  sorry

/-- source_id: MD-5.3.3-AmbientLowerDimensionNull · unnumbered_claim · §5.3.3 · 印刷p.195 / PDFp.216
[EXTRA] [EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。 -/
theorem ambientLowerDimensionNull : ∀ n d (g : MolecularDynamics.Chapter05Review.E d → MolecularDynamics.Chapter05Review.E n) (K : Set (MolecularDynamics.Chapter05Review.E d)),
  d < n → ContDiff ℝ 1 g → IsCompact K → volume (g '' K)=0 := by
  sorry

/-- source_id: MD-5.4-TimeAverage · definition · §5.4 · 印刷p.195 / PDFp.216 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅式(5.9)有限截断平均因子；无限时间极限存在谓词由MD-5.4-HasTimeAverage承担。 -/
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))

/-- source_id: MD-5.4-HasTimeAverage · definition · §5.4 · 印刷p.195 / PDFp.216 -/
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)

/-- source_id: MD-5.4-ConservedAverage · unnumbered_claim · §5.4 · 印刷p.196–197 / PDFp.217–218
[EXTRA] [EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅守恒观测量的有限平均辅助恒等式；第一积分及任意函数复合的无限平均由MD-5.4-ConservedInfiniteAverage承担。 -/
theorem conservedAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ)
    (h : ∀ t,g (z t)=a) (T : ℝ) (hT : T ≠ 0) : MolecularDynamics.Chapter05Review.timeAverage z g T=a := by
  apply MolecularDynamics.Chapter05Review.conservedAverage_proved <;> assumption

/-- source_id: MD-5.4-ConservedInfiniteAverage · unnumbered_claim · §5.4 · 印刷p.196–197 / PDFp.217–218 -/
theorem conservedInfiniteAverage {X : Type*} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  MolecularDynamics.Chapter05Review.hasTimeAverage z I (I (z 0)) ∧
    MolecularDynamics.Chapter05Review.hasTimeAverage z (r ∘ I) (r (I (z 0))) := by
  have hm (g : X → ℝ) (hg : ∀ t,g (z t)=g (z 0)) :
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) := by
    apply tendsto_congr' _ |>.2 tendsto_const_nhds
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    exact MolecularDynamics.Chapter05Review.conservedAverage_proved z g (g (z 0)) hg T (ne_of_gt hT)
  exact ⟨hm I hI,hm (r ∘ I) (fun t => by simp only [Function.comp_apply,hI])⟩

/-- source_id: MD-5.4-DoubleWellEnergy · Example 5.3 · §5.4 · 印刷p.196 / PDFp.217 
[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅双阱势与能量公式定义；非负及强制性由MD-5.4-DoubleWellCoercivity承担。 -/
def doubleWellEnergy (z : MolecularDynamics.Chapter05Review.E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2

/-- source_id: MD-5.4-DoubleWellCoercivity · unnumbered_claim · §5.4 · 印刷p.196 / PDFp.217
[EXTRA] [EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。 -/
theorem doubleWellCoercivity : (∀ z : MolecularDynamics.Chapter05Review.E 2,0 ≤ doubleWellEnergy z) ∧
  ∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} := by
  constructor
  · intro z
    unfold doubleWellEnergy
    positivity
  · intro c
    have hc : Continuous (doubleWellEnergy) := by unfold doubleWellEnergy; fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|+4)).of_isClosed_subset hclosed
    intro z hz
    have he : (z 1)^2/2+(1-(z 0)^2)^2 ≤ c := hz
    have hpos : 0 ≤ c := by nlinarith [sq_nonneg (z 1),sq_nonneg (1-(z 0)^2)]
    have hq : (z 0)^2 ≤ (c+3)/2 := by
      nlinarith [sq_nonneg (z 1),sq_nonneg ((z 0)^2-2)]
    have hp : (z 1)^2 ≤ 2*c := by nlinarith [sq_nonneg (1-(z 0)^2)]
    have hnorm : ‖z‖^2=(z 0)^2+(z 1)^2 := by
      rw [EuclideanSpace.norm_sq_eq]
      simp [Fin.sum_univ_two,Real.norm_eq_abs]
    rw [Metric.mem_closedBall,dist_zero_right,abs_of_nonneg hpos]
    nlinarith [norm_nonneg z]

/-- source_id: MD-5.4-DoubleWellDisconnected · Example 5.3 · §5.4 · 印刷p.196 / PDFp.217 -/
theorem doubleWellDisconnected : ∀ c ∈ Ioo (0 : ℝ) 1,
  ¬IsPreconnected (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by
  intro c hc hS
  let a : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![-1,Real.sqrt (2*c)]
  let b : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![1,Real.sqrt (2*c)]
  have hsqrt : (Real.sqrt (2*c))^2=2*c := Real.sq_sqrt (by linarith [hc.1])
  have ha : a ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(-1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hb : b ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    change (Real.sqrt (2*c))^2/2+(1-(1 : ℝ)^2)^2=c
    rw [hsqrt];ring
  have hq : ContinuousOn (fun z : MolecularDynamics.Chapter05Review.E 2 => z 0)
      (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by fun_prop
  have hzero : (0 : ℝ) ∈ Icc (a 0) (b 0) := by norm_num [a,b]
  obtain ⟨z,hz,hz0⟩ := hS.intermediate_value ha hb hq hzero
  change doubleWellEnergy z=c at hz
  unfold doubleWellEnergy at hz
  change z 0=0 at hz0
  rw [hz0] at hz
  nlinarith [sq_nonneg (z 1),hc.2]

/-- source_id: MD-5.4-DoubleWellBasin · unnumbered_claim · §5.4 · 印刷p.196 / PDFp.217
[EXTRA] [EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。 
[EXTRA] 保留左右阱不变性，补全局C∞紧支撑观测量的明确见证：它在两个分离能量分支上分别为0/1，时间平均与真实对称微正则空间平均1/2不等；不把平均不等作前提，也不把不连续全局indicator冒充原光滑观测量。 -/
theorem doubleWellBasin : ∀ (z : ℝ → MolecularDynamics.Chapter05Review.E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0) := by
  intro z c hz hc hE t
  let q (s : ℝ) := (z s) 0
  have hq : Continuous q := by dsimp [q]; fun_prop
  have hn (s : ℝ) : q s ≠ 0 := by
    intro heq
    have hh := hE s
    unfold doubleWellEnergy at hh
    change (z s) 0=0 at heq
    rw [heq] at hh
    nlinarith [sq_nonneg ((z s) 1),hc.2]
  by_cases h0 : 0 < q 0
  · left
    refine ⟨h0,?_⟩
    by_contra ht
    have hneg : q t < 0 := lt_of_le_of_ne (le_of_not_gt ht) (hn t)
    obtain ⟨s,hs⟩ := intermediate_value_univ t 0 hq (show (0 : ℝ) ∈ Icc (q t) (q 0) from ⟨hneg.le,h0.le⟩)
    exact hn s hs
  · right
    have hneg : q 0 < 0 := lt_of_le_of_ne (le_of_not_gt h0) (hn 0)
    refine ⟨hneg,?_⟩
    by_contra ht
    have hpos : 0 < q t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm (hn t))
    obtain ⟨s,hs⟩ := intermediate_value_univ 0 t hq (show (0 : ℝ) ∈ Icc (q 0) (q t) from ⟨hneg.le,hpos.le⟩)
    exact hn s hs

theorem doubleWellBasin_average_witness (c : ℝ) (_hc : c ∈ Ioo (0 : ℝ) 1)
    (z : ℝ → MolecularDynamics.Chapter05Review.E 2) (_hz : Continuous z)
    (_hE : ∀ t,doubleWellEnergy (z t)=c) :
    ∃ g : MolecularDynamics.Chapter05Review.E 2 → ℝ,ContDiff ℝ ∞ g ∧ HasCompactSupport g ∧
      (∀ x,doubleWellEnergy x=c → g x=if 0 < x 0 then (1 : ℝ) else 0) ∧
      MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g=1/2 ∧
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) ∧
      g (z 0) ≠ MolecularDynamics.Chapter05Review.microAverage doubleWellEnergy c g := by
  sorry

/-- source_id: MD-5.4.1-UniformMicroErgodic · Definition 5.1 · §5.4.1 · 印刷p.197 / PDFp.218
[EXTRA] [EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ_E零测资格。 -/
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ⊤ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)

/-- source_id: MD-5.4.1-MicroErgodicStandard · definition · §5.4.1 · 印刷p.197 / PDFp.218
[EXTRA] [EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。 -/
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)

/-- source_id: MD-5.4.1-FlowInvariant · definition · §5.4.1 · 印刷p.197–198 / PDFp.218–219
[EXTRA] [EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。 -/
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A

/-- source_id: MD-5.4.1-SetErgodic · definition · §5.4.1 · 印刷p.197–198 / PDFp.218–219
[EXTRA] [EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。 -/
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1

/-- source_id: MD-5.4.1-InvariantIndicator · unnumbered_claim · §5.4.1 · 印刷p.198 / PDFp.219
[EXTRA] [EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。 -/
theorem invariantIndicator {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0 := by
  apply MolecularDynamics.Chapter05Review.invariantIndicator_proved <;> assumption

/-- source_id: MD-5.4.1-InvariantIndicatorAverage · unnumbered_claim · §5.4.1 · 印刷p.198 / PDFp.219 -/
theorem invariantIndicatorAverage {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (hA : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) :
  MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) (Aᶜ.indicator (fun _ => (1 : ℝ))) 0 := by
  sorry

/-- source_id: MD-5.4.1-ErgodicTimeEquivalence · unnumbered_claim · §5.4.1 · 印刷p.198 / PDFp.219
[EXTRA] [EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。 -/
theorem ergodicTimeAverage :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

/-- source_id: MD-5.4.1-NonergodicSet · unnumbered_claim · §5.4.1 · 印刷p.198 / PDFp.219 -/
theorem nonergodicSet :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (¬MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
    ∃ A : Set (MolecularDynamics.Chapter05Review.E n),MeasurableSet A ∧ MolecularDynamics.Chapter05Review.flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1) := by
  sorry

/-- source_id: MD-5.4.1-HarmonicFlow · definition · §5.4.1 · 印刷p.198–199 / PDFp.219–220
[EXTRA] [EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。 -/
def harmonicFlow (Ω t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]

/-- source_id: MD-5.4.1-HarmonicErgodic · unnumbered_claim · §5.4.1 · 印刷p.198 / PDFp.219
[EXTRA] [EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。 -/
theorem harmonicErgodic : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microErgodic (harmonicEnergy Ω) c (harmonicFlow Ω) := by
  sorry

/-- source_id: MD-5.4.1-TwoOscillatorEnergy · Example 5.4 · §5.4.1 · 印刷p.198–199 / PDFp.219–220 -/
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2

/-- source_id: MD-5.4.1-TwoOscillatorFlow · definition · §5.4.1 · 印刷p.198–199 / PDFp.219–220
[EXTRA] [EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。 -/
def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E 4) : MolecularDynamics.Chapter05Review.E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]

/-- source_id: MD-5.4.1-TwoOscillatorTori · Example 5.4 · §5.4.1 · 印刷p.199 / PDFp.220
[EXTRA] [EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。 -/
theorem twoOscillatorTori : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {z : MolecularDynamics.Chapter05Review.E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1 × Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬MolecularDynamics.Chapter05Review.setErgodic (MolecularDynamics.Chapter05Review.microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω)) := by
  sorry

/-- source_id: MD-5.4.1-Mixing · definition · §5.4.1 · 印刷p.199 / PDFp.220
[EXTRA] [EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。 -/
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))

/-- source_id: MD-5.4.1-KAMPersistence · unnumbered_claim · §5.4.1 · 印刷p.200 / PDFp.221
[EXTRA] [EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。 -/
theorem kam :
  ∀ n (H0 : MolecularDynamics.Chapter05Review.E n → ℝ) (P : MolecularDynamics.Chapter05Review.Phase n → ℝ) (I0 : MolecularDynamics.Chapter05Review.E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → MolecularDynamics.Chapter05Review.periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → MolecularDynamics.Chapter05Review.diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=MolecularDynamics.Chapter05Review.hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1) := by
  sorry

/-- source_id: MD-5.4.1-AnisotropicPotential · Example 5.6 · §5.4.1 · 印刷p.201 / PDFp.222 -/
def anisotropicPotential (κ l ε : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0

/-- source_id: MD-5.4.1-AnisotropicAxisPrinted · unnumbered_claim · §5.4.1 · 印刷p.201 / PDFp.222
[EXTRA] [EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。 -/
theorem anisotropicAxisPrinted : ∀ (κ l ε : ℝ) (z : ℝ → MolecularDynamics.Chapter05Review.Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0 := by
  sorry

/-- source_id: MD-5.4.1-TwoOscillatorEnergyDecomposition · unnumbered_claim · §5.4.1 · 印刷p.199 / PDFp.220
[EXTRA] [EXTRA]包括c_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。 -/
theorem twoOscillatorEnergyDecomposition : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
  sorry

/-- source_id: MD-5.4.1-CurveImageDimension · unnumbered_claim · §5.4.1 · 印刷p.202 / PDFp.223
[EXTRA] [EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。 -/
theorem curveImageDimension : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (γ : ℝ → MolecularDynamics.Chapter05Review.E n),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ ⊤ (Function.uncurry Φ) → ContDiff ℝ ⊤ γ →
  (∀ s,deriv γ s ≠ 0) → ∀ t,
  ContDiff ℝ ⊤ (fun s => Φ t (γ s)) ∧ (∀ s,deriv (fun r => Φ t (γ r)) s ≠ 0) := by
  sorry

/-- source_id: MD-5.4.1-PendulumPotential · Example 5.5 · §5.4.1 · 印刷p.200 / PDFp.221
[EXTRA] [EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。 -/
def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : MolecularDynamics.Chapter05Review.E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2

/-- source_id: MD-5.4.1-PendulumRegionPrinted · unnumbered_claim · §5.4.1 · 印刷p.200 / PDFp.221
[EXTRA] [EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。 -/
theorem pendulumRegionPrinted : ∀ k₁ k₂ l₁ l₂ c : ℝ,
  0 < k₁ → 0 < k₂ → 0 < l₁ → 0 < l₂ → 0 < c →
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c}=
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ r₁ > 0,∃ r₂ > 0,
    k₁/2*(r₁-l₁)^2+k₂/2*(r₂-l₂)^2=c ∧
    Real.sqrt ((q 0)^2+(q 1)^2) ≤ r₁ ∧ Real.sqrt ((q 0)^2+(q 1+2)^2) ≤ r₂} := by
  sorry

/-- source_id: MD-5.4.1-AnisotropicInitialCurve · definition · §5.4.1 · 印刷p.201 / PDFp.222 -/
def anisotropicInitialCurve (κ l ε c x : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![0,Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))])

/-- source_id: MD-5.4.1-AnisotropicInitialEnergy · unnumbered_claim · §5.4.1 · 印刷p.201 / PDFp.222
[EXTRA] [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。 -/
theorem anisotropicInitialEnergy : ∀ κ l ε c x : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := anisotropicInitialCurve κ l ε c x
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry

/-- source_id: MD-5.4.1-InitialSegmentPrinted · unnumbered_claim · §5.4.1 · 印刷p.201 / PDFp.222
[EXTRA] [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。 -/
theorem initialSegmentPrinted : ∀ κ l ε c : ℝ,
  (∀ x ∈ Icc (105/100 : ℝ) (115/100),0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])) →
  ∃ a b : MolecularDynamics.Chapter05Review.Phase 2,anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)=segment ℝ a b := by
  sorry

/-- source_id: MD-5.4.1-CircleInitialPoints · definition · §5.4.1 · 印刷p.202 / PDFp.223 -/
def circleInitialPoints (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])

/-- source_id: MD-5.4.1-CircleInitialLaw · definition · §5.4.1 · 印刷p.202 / PDFp.223
[EXTRA] [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。 -/
def circleInitialLaw (κ l ε c x : ℝ) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (circleInitialPoints κ l ε c x)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))

/-- source_id: MD-5.4.1-CircleInitialEnergy · unnumbered_claim · §5.4.1 · 印刷p.202 / PDFp.223
[EXTRA] [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。 -/
theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry

/-- source_id: MD-5.5-Correlation · definition · §5.5 · 印刷p.203 / PDFp.224 -/
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)

/-- source_id: MD-5.5-CorrelationPullback · unnumbered_claim · §5.5 · 印刷p.204 / PDFp.225 -/
theorem correlationPullback {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t :
    MolecularDynamics.Chapter05Review.correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ) := by
  apply MolecularDynamics.Chapter05Review.correlationPullback_proved <;> assumption

/-- source_id: MD-5.5-CorrelationTimePrinted · unnumbered_claim · §5.5 · 印刷p.204 / PDFp.225
[EXTRA] [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。 -/
theorem correlationTimePrinted : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
  sorry

/-- source_id: MD-5.5-CorrelationTimeAE · unnumbered_claim · §5.5 · 印刷p.204 / PDFp.225
[EXTRA] [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。 -/
theorem correlationTime :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh

/-- source_id: MD-5.5-VelocityCorrelation · definition · §5.5 · 印刷p.204 / PDFp.225 -/
def velocityCorrelation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (v : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (t : ℝ) := MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 t/MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 0

/-- source_id: MD-5.5-PositionTransition · definition · §5.5 · 印刷p.204 / PDFp.225 -/
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (t : ℝ) :=
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)

/-- source_id: MD-5.5-TransitionProbability · definition · §5.5 · 印刷p.204 / PDFp.225
[EXTRA] [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。 -/
def transitionProbability {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (A B : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal

/-- source_id: MD-5.5-MeasureDuality · unnumbered_claim · §5.5 · 印刷p.205 / PDFp.226
[EXTRA] [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。 -/
theorem measureDuality :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (φ : MolecularDynamics.Chapter05Review.E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) →
    MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) φ=MolecularDynamics.Chapter05Review.average μ (MolecularDynamics.Chapter05Review.pullback Φ φ t) := by
  intro n μ Φ φ t hm hi
  exact integral_map hm.aemeasurable hi.aestronglyMeasurable

/-- source_id: MD-5.5-MixingMemoryLoss · unnumbered_claim · §5.5 · 印刷p.205 / PDFp.226
[EXTRA] [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。 -/
theorem mixingMemoryLoss : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (β φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0) := by
  intro n μ Φ β φ hμ hm hβ hβbound hβpos hβmass hφ hb hΦ
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hi : Integrable φ μ := Integrable.mono' (integrable_const C)
    hφ.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (φ z) (mem_range_self z)))
  have he (t : ℝ) : (∫ z,φ (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ φ := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable φ (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact hi.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have hp (t : ℝ) : Integrable (fun z => φ (Φ t z)*β z) μ :=
    hβ.bdd_mul (hφ.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hB (φ (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : (∫ z,φ (Φ t z)*(β z-1) ∂μ)=
      (∫ z,φ (Φ t z)*β z ∂μ)-MolecularDynamics.Chapter05Review.average μ φ := by
    simp_rw [mul_sub,mul_one]
    have hip : Integrable (fun z => φ (Φ t z)) μ := by
      simpa only [Function.comp_def] using (hΦ t).integrable_comp_of_integrable hi
    rw [integral_sub (hp t) hip,he]
  simp_rw [heq]
  simpa only [sub_self] using (hm β φ hβ hβpos hβmass hφ hb).sub (tendsto_const_nhds : Tendsto (fun _ : ℝ => MolecularDynamics.Chapter05Review.average μ φ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ)))

/-- source_id: MD-5.5-MixingCorrelationPrinted · unnumbered_claim · §5.5 · 印刷p.205 / PDFp.226
[EXTRA] [EXTRA]明确概率测度及有界连续函数；k任意，字面版不改最终右侧。 -/
theorem mixingCorrelationPrinted :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → weakMixing μ Φ → Continuous a → Continuous b →
    Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
    Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  sorry

/-- source_id: MD-5.5-MixingCorrelation · unnumbered_claim · §5.5 · 印刷p.205 / PDFp.226
[EXTRA] [EXTRA]独立修正版右侧保留k，实际AC概率初值的弱mixing条件及有界连续a/b；原参考微正则分布的不变资格明确为MeasurePreserving，保障各时积分可积和常数项不变。未以目标相关极限作假设。 -/
theorem mixingCorrelation :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k, IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b)) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hbb.exists_pos_norm_le
  obtain ⟨R,hR,hA⟩ := hba.exists_pos_norm_le
  have ib : Integrable b μ := Integrable.mono' (integrable_const C)
    hb.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (b z) (mem_range_self z)))
  have ia : Integrable a μ := Integrable.mono' (integrable_const R)
    ha.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hA (a z) (mem_range_self z)))
  have ibound : |∫ z,b z ∂μ| ≤ C := by
    simpa only [Real.norm_eq_abs,probReal_univ,mul_one] using
      norm_integral_le_of_norm_le_const (ae_of_all μ (fun z => hB (b z) (mem_range_self z)))
  let D := C+1
  let M := (∫ z,b z ∂μ)+D
  have hM : 0 < M := by dsimp [M,D];linarith [neg_le_of_abs_le ibound]
  let r (z) := (b z+D)/M
  have ir : Integrable r μ := (ib.add (integrable_const D)).div_const M
  have rpos (z) : 0 ≤ r z := by
    have hx : |b z| ≤ C := by simpa only [Real.norm_eq_abs] using hB (b z) (mem_range_self z)
    dsimp [r,D]
    apply div_nonneg _ hM.le
    linarith [neg_le_of_abs_le hx]
  have rmass : (∫ z,r z ∂μ)=1 := by
    dsimp [r]
    rw [integral_div,integral_add ib (integrable_const D)]
    simp [integral_const,M,ne_of_gt hM]
  have ht := hm r a ir rpos rmass ha hba
  have iap (t : ℝ) : Integrable (fun z => a (Φ t z)) μ :=
    (hΦ t).integrable_comp_of_integrable ia
  have ie (t : ℝ) : (∫ z,a (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ a := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable a (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact ia.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have ipr (t : ℝ) : Integrable (fun z => a (Φ t z)*r z) μ :=
    ir.bdd_mul (ha.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hA (a (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : M*(∫ z,a (Φ t z)*r z ∂μ)-D*MolecularDynamics.Chapter05Review.average μ a=
      (∫ z,a (Φ t z)*b z ∂μ) := by
    rw [←ie t,←integral_const_mul,←integral_const_mul,
      ←integral_sub ((ipr t).const_mul M) ((iap t).const_mul D)]
    apply integral_congr_ae
    filter_upwards [] with z
    dsimp [r]
    field_simp [ne_of_gt hM] <;> ring
  have hh := (ht.const_mul M).sub (tendsto_const_nhds : Tendsto
    (fun _ : ℝ => D*MolecularDynamics.Chapter05Review.average μ a) atTop
    (𝓝 (D*MolecularDynamics.Chapter05Review.average μ a)))
  simp_rw [heq] at hh
  convert hh.const_mul k using 1
  unfold MolecularDynamics.Chapter05Review.average
  dsimp [M]
  ring

/-- source_id: MD-5.5-CenteredCorrelation · unnumbered_claim · §5.5 · 印刷p.205 / PDFp.226
[EXTRA] [EXTRA]概率测度/有界连续资格，k仍保留；由实际混合相关式推导的绝对值结论，不只保留未中心化极限。 -/
theorem centeredCorrelation : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → ℝ) k,IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) → weakMixing μ Φ →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  (MolecularDynamics.Chapter05Review.average μ a=0 ∨ MolecularDynamics.Chapter05Review.average μ b=0) →
  Tendsto (fun t => |k*(∫ z,a (Φ t z)*b z ∂μ)|) atTop (𝓝 0) := by
  intro n μ Φ a b k hμ hΦ hm ha hb hba hbb hzero
  have ht := mixingCorrelation n μ Φ a b k hμ hΦ hm ha hb hba hbb
  have hl : k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b=0 := by
    rcases hzero with h | h <;> rw [h] <;> ring
  rw [hl] at ht
  simpa only [abs_zero] using ht.abs

/-- source_id: MD-5.6-DiscreteAveragePrinted · definition · §5.6 · 印刷p.206 / PDFp.227 -/
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)

/-- source_id: MD-5.6-DiscreteAverage · definition · §5.6 · 印刷p.206 / PDFp.227
[EXTRA] [EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。 -/
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)

/-- source_id: MD-5.6-DiscretePropagator · definition · §5.6 · 印刷p.206 / PDFp.227 -/
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (μ : Measure X) := Measure.map G μ

/-- source_id: MD-5.6-ModifiedField · definition · §5.6 · 印刷p.206 / PDFp.227 -/
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z

/-- source_id: MD-5.6-ModifiedLiouvillian · unnumbered_claim · §5.6 · 印刷p.206 / PDFp.227
[EXTRA] [EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。 -/
theorem modifiedLiouvillian :
  ∀ n (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=MolecularDynamics.Chapter05Review.liouvillian f u z+h^r*MolecularDynamics.Chapter05Review.liouvillian fr u z := by
  intro n f fr u h r hf hfr hu z
  have hx : DifferentiableAt ℝ (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z :=
    (hf z).add ((hfr z).const_smul (h^r))
  rw [liouvilleProduct n _ u z hx (hu z),liouvilleProduct n f u z (hf z) (hu z),
    liouvilleProduct n fr u z (hfr z) (hu z)]
  have hd : MolecularDynamics.Chapter05Review.divergence (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z=
      MolecularDynamics.Chapter05Review.divergence f z+(h^r)*MolecularDynamics.Chapter05Review.divergence fr z := by
    unfold MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.modifiedField
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      (fderiv ℝ (f+(h^r) • fr) z).toLinearMap=_
    rw [((hf z).hasFDerivAt.add ((hfr z).hasFDerivAt.const_smul (h^r))).fderiv]
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      ((fderiv ℝ f z).toLinearMap+(h^r) • (fderiv ℝ fr z).toLinearMap)=_
    simp only [map_add,map_smul,smul_eq_mul]
  have hl : MolecularDynamics.Chapter05Review.lie (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=
      MolecularDynamics.Chapter05Review.lie f u z+(h^r)*MolecularDynamics.Chapter05Review.lie fr u z := by
    simp [MolecularDynamics.Chapter05Review.lie,MolecularDynamics.Chapter05Review.modifiedField,
      map_add,map_smul,smul_eq_mul]
  rw [hd,hl]
  ring

/-- source_id: MD-5.6-ForwardEuler · definition · §5.6 · 印刷p.206–207 / PDFp.227–228 -/
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]

/-- source_id: MD-5.6-ForwardComponentsPrinted · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。 -/
theorem forwardComponentsPrinted : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 0|) atTop atTop ∧
  Tendsto (fun k : ℕ => |(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z 1|) atTop atTop := by
  sorry

/-- source_id: MD-5.6-ForwardEnergyGrowth · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。 -/
theorem forwardEnergyGrowth : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 1)^2=
    (1+h^2)^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.forwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.forwardEuler h x 1)^2=(1+h^2)*((x 0)^2+(x 1)^2) := by
    simp [MolecularDynamics.Chapter05Review.forwardEuler]
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

/-- source_id: MD-5.6-EulerInvariant · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。 -/
theorem eulerInvariant :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2 := by
  intro h hh μ hμ hΦ
  letI := hμ
  have heq : ∀ᵐ z ∂μ,z=(0 : MolecularDynamics.Chapter05Review.E 2) := by
    filter_upwards [hΦ.conservative.ae_frequently_mem_of_mem_nhds] with z hz
    by_contra hn
    have hs : 0 < (z 0)^2+(z 1)^2 := by
      have hs' : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hn) _
      rw [EuclideanSpace.norm_sq_eq] at hs'
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hs'
    have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
    have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
    have hret := hz (Metric.ball 0 (‖z‖+1))
      (Metric.isOpen_ball.mem_nhds (by simp [Metric.mem_ball,dist_zero_right]))
    obtain ⟨k,hk,hlarge⟩ := (hret.and_eventually
      (ht.eventually (eventually_ge_atTop ((‖z‖+1)^2+1)))).exists
    have hen : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
        (1+h^2)^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
    rw [←hen] at hlarge
    rw [Metric.mem_ball,dist_zero_right] at hk
    nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),norm_nonneg z]
  have hm : Measure.map (fun z : MolecularDynamics.Chapter05Review.E 2 => z) μ =
      Measure.map (fun _ : MolecularDynamics.Chapter05Review.E 2 => (0 : MolecularDynamics.Chapter05Review.E 2)) μ := Measure.map_congr heq
  simpa [MolecularDynamics.Chapter05Review.diracMeasure,Measure.map_id,Measure.map_const] using hm

/-- source_id: MD-5.6-BackwardEuler · definition · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。 -/
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]

/-- source_id: MD-5.6-BackwardEnergyDecay · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]真实有限步平方范数代数恒等式另列；全轨道趋原点及测度弱极限另保留。 -/
theorem backwardEnergyDecay : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) 1)^2=
    (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.backwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.backwardEuler h x 1)^2=(1+h^2)⁻¹*((x 0)^2+(x 1)^2) := by
    have hd : 1+h^2 ≠ 0 := ne_of_gt (by positivity)
    simp [MolecularDynamics.Chapter05Review.backwardEuler]
    field_simp
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

/-- source_id: MD-5.6-BackwardEulerLimit · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]h≠0及实际任意初始概率测度；全轨道收缩与对每个有界连续测试函数的弱趋Dirac两个结论，非普通密度逐点收敛。 -/
theorem backwardEulerLimit :
  ∀ h : ℝ,h ≠ 0 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0)) := by
  intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      simp only [Function.comp_apply]
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd

/-- source_id: MD-5.6-SymplecticEuler · definition · §5.6 · 印刷p.207 / PDFp.228 -/
def symplecticEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]

/-- source_id: MD-5.6-SymplecticEulerShadow · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]完整实际二次修正能量的一步保持恒等式；正定椭圆资格及所有n保持另条，不以一步式称全部椭圆结论已证。 -/
theorem symplecticEulerShadow : symplecticEulerShadow_statement := by
  apply MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved <;> assumption

/-- source_id: MD-5.6-SymplecticEulerEllipse · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]稳定条件|h|<2；原不加资格的椭圆说法在|h|≥2失败。本条保留正定/紧性和所有迭代保持；0能量是退化点。 -/
theorem symplecticEulerEllipse : ∀ h : ℝ,|h| < 2 →
  (∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 → 0 < MolecularDynamics.Chapter05Review.shadowOscillator h z) ∧
  (∀ c : ℝ,IsCompact {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c}) ∧
  (∀ z : MolecularDynamics.Chapter05Review.E 2,∀ k : ℕ,MolecularDynamics.Chapter05Review.shadowOscillator h ((MolecularDynamics.Chapter05Review.symplecticEuler h)^[k] z)=
    MolecularDynamics.Chapter05Review.shadowOscillator h z) := by
  intro h hh
  let d := 2-|h|
  have hd : 0 < d := by dsimp [d];linarith
  have lower (z : MolecularDynamics.Chapter05Review.E 2) :
      d*((z 0)^2+(z 1)^2) ≤ 4*MolecularDynamics.Chapter05Review.shadowOscillator h z := by
    unfold MolecularDynamics.Chapter05Review.shadowOscillator
    dsimp [d]
    by_cases hp : 0 ≤ h
    · rw [abs_of_nonneg hp]
      nlinarith [mul_nonneg hp (sq_nonneg (z 0-z 1))]
    · rw [abs_of_neg (lt_of_not_ge hp)]
      nlinarith [mul_nonneg (neg_nonneg.mpr (le_of_lt (lt_of_not_ge hp))) (sq_nonneg (z 0+z 1))]
  have normeq (z : MolecularDynamics.Chapter05Review.E 2) : ‖z‖^2=(z 0)^2+(z 1)^2 := by
    rw [EuclideanSpace.norm_sq_eq]
    simp [Fin.sum_univ_two,Real.norm_eq_abs]
  refine ⟨?_,?_,?_⟩
  · intro z hz
    have hnorm : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    have hl := lower z
    rw [←normeq] at hl
    nlinarith [mul_pos hd hnorm]
  · intro c
    have hc : Continuous (MolecularDynamics.Chapter05Review.shadowOscillator h) := by
      unfold MolecularDynamics.Chapter05Review.shadowOscillator;fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|/d+1)).of_isClosed_subset hclosed
    intro z hz
    have hl := lower z
    rw [←normeq] at hl
    change MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c at hz
    have hle : ‖z‖^2 ≤ 4*|c|/d := (le_div_iff₀ hd).mpr (by nlinarith [le_abs_self c])
    have hB : 0 ≤ 4*|c|/d := by positivity
    rw [Metric.mem_closedBall,dist_zero_right]
    nlinarith [norm_nonneg z]
  · intro z k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply',MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved,ih]

/-- source_id: MD-5.6-SymplecticEulerDensity · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]真实离散映射MeasurePreserving、不变二次能量、实际概率密度r∘Htilde；完整弱Liouville稳态及非吸引另条，所有r都可归一不能自动推出。 -/
theorem symplecticEulerDensity :
  ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h) →
    MeasurePreserving (MolecularDynamics.Chapter05Review.symplecticEuler h) (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h))
      (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ MolecularDynamics.Chapter05Review.shadowOscillator h)) := by
  sorry

/-- source_id: MD-5.6-VerletShadow2 · definition · §5.6 · 印刷p.208 / PDFp.229 -/
def verletShadow2 {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ) (h : ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  let v : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 fun i => z.2 i/m i
  (∑ i,z.2 i^2/m i)/2+U z.1+h^2/24*
    (2*(fderiv ℝ (fderiv ℝ U) z.1) v v-∑ i,(MolecularDynamics.Chapter05Review.grad U z.1 i)^2/m i)

/-- source_id: MD-5.6-Theorem51 · Theorem 5.1 · §5.6 · 印刷p.208–209 / PDFp.229–230
[EXTRA] [EXTRA]实际C∞和regularEnergy含梯度非零及raw总质量有限正；补统一紧能量带与其上分母不为零，量化完整O(ε²)平均差。不只陈述分母下界，不将校正关系作前提。 -/
theorem theorem51 :
  ∀ n (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ g → ContDiff ℝ ⊤ w →
    MolecularDynamics.Chapter05Review.regularEnergy H c → (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
  sorry

/-- source_id: MD-5.6-PerturbationDisplacement · definition · §5.6 · 印刷p.209 / PDFp.230 -/
def perturbationDisplacement {n : ℕ} (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  (ε*η z/inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)) • w z

/-- source_id: MD-5.6-PerturbationCorrection · definition · §5.6 · 印刷p.209 / PDFp.230 -/
def perturbationCorrection {n : ℕ} (H η g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := MolecularDynamics.Chapter05Review.perturbationDisplacement H η w ε
  MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence (fun z => g z • u z))-
    MolecularDynamics.Chapter05Review.microAverage Hε c g*MolecularDynamics.Chapter05Review.microAverage Hε c (MolecularDynamics.Chapter05Review.divergence u)

/-- source_id: MD-5.6-DenominatorBound · unnumbered_claim · §5.6 · 印刷p.209 / PDFp.230
[EXTRA] [EXTRA]单独保留紧集上实际连续绝对分母的正下界，是完整定理的基础后果，不替代完整校正关系。 -/
theorem denominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c))
    (hc : ContinuousOn (fun z => |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)|) (MolecularDynamics.Chapter05Review.energySurface H c))
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.denominatorBound_proved <;> assumption

/-- source_id: MD-5.6-SmoothDenominatorBound · unnumbered_claim · §5.6 · 印刷p.209 / PDFp.230
[EXTRA] [EXTRA]由C² H、连续w自动得到实际连续分母和紧性下界；正式已证特殊后果，不当完整微正则扰动定理。 -/
theorem smoothDenominatorBound {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c
    (hK : IsCompact (MolecularDynamics.Chapter05Review.energySurface H c)) (hH : ContDiff ℝ 2 H) (hw : Continuous w)
    (hn : ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) :
    ∃ a > 0,∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,a ≤ |inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z)| := by
  apply MolecularDynamics.Chapter05Review.smoothDenominatorBound_proved <;> assumption

/-- source_id: MD-5.6-ZeroPerturbation · unnumbered_claim · §5.6 · 印刷p.209 / PDFp.230
[EXTRA] [EXTRA]η恒0时实际校正函数为0的直接后果；不将零扰动特例冒充任意η的平均误差定理。 -/
theorem zeroPerturbation {n : ℕ} (H g : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c ε :
    MolecularDynamics.Chapter05Review.perturbationCorrection H (fun _ => 0) g w c ε=0 := by
  apply MolecularDynamics.Chapter05Review.zeroPerturbation_proved <;> assumption

/-- source_id: MD-5.6-GradientTransverse · unnumbered_claim · §5.6 · 印刷p.209 / PDFp.230
[EXTRA] [EXTRA]正则能量面grad H非零，实际平方范数保证横截；不是任意能量处的无条件结论。 -/
theorem gradientTransverse :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) c,
  (∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,MolecularDynamics.Chapter05Review.grad H z ≠ 0) →
    ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,inner ℝ (MolecularDynamics.Chapter05Review.grad H z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0 := by
  intro n H c hn z hz
  exact inner_self_ne_zero.mpr (hn z hz)

/-- source_id: MD-5.6-DynamicalCorrection · unnumbered_claim · §5.6 · 印刷p.209 / PDFp.230
[EXTRA] [EXTRA]固定lag的真实光滑pullback观测量及统一紧正则能量带；H参数改变时flow本身改变所导致的额外误差未自动忽略。本条完整平均校正关系不以结论为前提。 -/
theorem dynamicalCorrection :
  ∀ n d (H η : MolecularDynamics.Chapter05Review.E n → ℝ) (w : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) c t,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ w →
    ContDiff ℝ ⊤ a → ContDiff ℝ ⊤ b → ContDiff ℝ ⊤ (Φ t) → MolecularDynamics.Chapter05Review.regularEnergy H c →
    (∃ δ > 0, ∃ K : Set (MolecularDynamics.Chapter05Review.E n), IsCompact K ∧ MolecularDynamics.Chapter05Review.energySurface H c ⊆ K ∧
      (∀ z ∈ K,inner ℝ (w z) (MolecularDynamics.Chapter05Review.grad H z) ≠ 0) ∧
      ∀ ε ∈ Ioo (-δ) δ,MolecularDynamics.Chapter05Review.regularEnergy (fun z => H z+ε*η z) c ∧
        MolecularDynamics.Chapter05Review.energySurface (fun z => H z+ε*η z) c ⊆ K) →
    let g := fun z => inner ℝ (a (Φ t z)) (b z)
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |MolecularDynamics.Chapter05Review.microAverage H c g-MolecularDynamics.Chapter05Review.microAverage (fun z => H z+ε*η z) c g-
        MolecularDynamics.Chapter05Review.perturbationCorrection H η g w c ε| ≤ C*ε^2 := by
  sorry

/-- source_id: MD-5.6-ForwardNormDivergence · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]独立修正为实际范数发散，不覆盖原两分量字面版；h≠0及非原点。 -/
theorem forwardNormDivergence : ∀ h : ℝ,h ≠ 0 → ∀ z : MolecularDynamics.Chapter05Review.E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖) atTop atTop := by
  intro h hh z hz
  have hs : 0 < (z 0)^2+(z 1)^2 := by
    have hn : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    rw [EuclideanSpace.norm_sq_eq] at hn
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hn
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
      (1+h^2)^k*((z 0)^2+(z 1)^2) := by
    rw [EuclideanSpace.norm_sq_eq]
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
  apply tendsto_atTop.2
  intro b
  filter_upwards [ht.eventually (eventually_ge_atTop ((max b 0)^2+1))] with k hk
  rw [←he] at hk
  nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),le_max_left b 0,le_max_right b 0]

/-- source_id: MD-5.6-WeakStationary · definition · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。 -/
def weakStationaryModel {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  MolecularDynamics.Chapter05Review.weakStationary f μ

/-- source_id: MD-5.6-WeakAttractor · definition · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。 -/
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))

/-- source_id: MD-5.6-EulerLogField · definition · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。 -/
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]

/-- source_id: MD-5.6-EulerLogFlow · definition · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。 -/
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]

/-- source_id: MD-5.6-EulerLogCorrespondence · unnumbered_claim · §5.6 · 印刷p.206–207 / PDFp.227–228
[EXTRA] [EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。 -/
theorem eulerLogCorrespondence : ∀ h : ℝ,0 < h →
  (∀ z,eulerLogFlow false h h z=MolecularDynamics.Chapter05Review.forwardEuler h z ∧
    eulerLogFlow true h h z=MolecularDynamics.Chapter05Review.backwardEuler h z) ∧
  (∀ backward z t,HasDerivAt (fun s => eulerLogFlow backward h s z)
    (eulerLogField backward h (eulerLogFlow backward h t z)) t) := by
  intro h hh
  have hn : h ≠ 0 := ne_of_gt hh
  have hp : 0 < 1+h^2 := by positivity
  have hs : Real.sqrt (1+h^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hp)
  have he : Real.exp (Real.log (1+h^2)/2)=Real.sqrt (1+h^2) := by
    have he2 : (Real.exp (Real.log (1+h^2)/2))^2=1+h^2 := by
      rw [pow_two,←Real.exp_add]
      convert Real.exp_log hp using 1 <;> congr 1 <;> ring
    nlinarith [Real.exp_pos (Real.log (1+h^2)/2),Real.sqrt_nonneg (1+h^2),Real.sq_sqrt hp.le]
  have hbh : Real.arctan h/h*h=Real.arctan h := by field_simp [hn]
  have haf : (Real.log (1+h^2)/(2*h))*h=Real.log (1+h^2)/2 := by field_simp [hn] <;> ring
  have hab : (-(Real.log (1+h^2))/(2*h))*h= -(Real.log (1+h^2)/2) := by field_simp [hn] <;> ring
  constructor
  · intro z
    constructor <;> ext i <;> fin_cases i <;>
      simp [eulerLogFlow,MolecularDynamics.Chapter05Review.forwardEuler,
        MolecularDynamics.Chapter05Review.backwardEuler,hbh,haf,hab,Real.exp_neg,
        he,Real.cos_arctan,Real.sin_arctan]
    all_goals field_simp [hs] <;> simp only [Real.sq_sqrt hp.le] <;> ring
  · intro backward z t
    let a := (if backward then (-1 : ℝ) else 1)*Real.log (1+h^2)/(2*h)
    let b := Real.arctan h/h
    have ha := ((hasDerivAt_id t).const_mul a).exp
    have hc := ((hasDerivAt_id t).const_mul b).cos
    have hs := ((hasDerivAt_id t).const_mul b).sin
    have hq := ha.mul ((hc.const_mul (z 0)).add (hs.const_mul (z 1)))
    have hp := ha.mul ((hc.const_mul (z 1)).sub (hs.const_mul (z 0)))
    have hv : HasDerivAt (fun s : ℝ => ![Real.exp (a*s)*(z 0*Real.cos (b*s)+z 1*Real.sin (b*s)),
        Real.exp (a*s)*(z 1*Real.cos (b*s)-z 0*Real.sin (b*s))])
        ![a*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))+
            b*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t))),
          a*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t)))-
            b*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))] t := by
      apply hasDerivAt_pi.mpr
      intro i
      fin_cases i
      · convert hq using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
      · convert hp using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
    convert (PiLp.hasFDerivAt_toLp (𝕜:=ℝ) 2 _).comp_hasDerivAt t hv using 1
    · funext s
      ext i
      fin_cases i <;> simp [eulerLogFlow,a,b]
    · ext i
      fin_cases i <;> simp [eulerLogField,eulerLogFlow,a,b] <;> ring

/-- source_id: MD-5.6-ForwardWeakStationary · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。 -/
theorem forwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField false h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  ¬weakAttractor (eulerLogFlow false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
  sorry

/-- source_id: MD-5.6-BackwardWeakStationary · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。 -/
theorem backwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField true h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  weakAttractor (eulerLogFlow true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
  sorry

/-- source_id: MD-5.6-SymplecticWeakStationary · unnumbered_claim · §5.6 · 印刷p.207 / PDFp.228
[EXTRA] [EXTRA]稳定区|h|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。 -/
theorem symplecticWeakStationary : ∀ h : ℝ,|h| < 2 →
  let f := fun z : MolecularDynamics.Chapter05Review.E 2 => WithLp.toLp 2
    ![(gradient (MolecularDynamics.Chapter05Review.shadowOscillator h) z) 1,-(gradient (MolecularDynamics.Chapter05Review.shadowOscillator h) z) 0]
  ∀ Φ : ℝ → MolecularDynamics.Chapter05Review.E 2 → MolecularDynamics.Chapter05Review.E 2,MolecularDynamics.Chapter05Review.flow f Φ →
    (∀ r : ℝ → ℝ,MolecularDynamics.Chapter05Review.probabilityDensity (fun z => r (MolecularDynamics.Chapter05Review.shadowOscillator h z)) →
      weakStationary f (MolecularDynamics.Chapter05Review.densityMeasure (fun z => r (MolecularDynamics.Chapter05Review.shadowOscillator h z)))) ∧
    (∃ μ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ ∧ IsProbabilityMeasure ν ∧
      μ ≠ ν ∧ weakStationary f μ ∧ weakStationary f ν) ∧
    (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → weakStationary f μ → ¬weakAttractor Φ μ) := by
  sorry

end MD.Ch05

/- BEGIN WEBSITE REPAIR AXIOMS -/
#print axioms MD.Ch05.lie
#print axioms MD.Ch05.trajectoryChain
#print axioms MD.Ch05.flow
#print axioms MD.Ch05.pullback
#print axioms MD.Ch05.flowFieldTransport
#print axioms MD.Ch05.flowFieldTransport_observable
#print axioms MD.Ch05.pullbackPDE
#print axioms MD.Ch05.steadyFirstIntegral
#print axioms MD.Ch05.coordinatePullback
#print axioms MD.Ch05.solutionOperator
#print axioms MD.Ch05.solutionOperator_initial
#print axioms MD.Ch05.coordinateLie
#print axioms MD.Ch05.liePullbackCommutes
#print axioms MD.Ch05.densityOn
#print axioms MD.Ch05.probabilityDensityOn
#print axioms MD.Ch05.densityOnNormalization
#print axioms MD.Ch05.densityProbability
#print axioms MD.Ch05.densityMeasureOn
#print axioms MD.Ch05.lebesgueClosure
#print axioms MD.Ch05.borelSigma
#print axioms MD.Ch05.densityProbabilityBounds
#print axioms MD.Ch05.domainL2Norm
#print axioms MD.Ch05.domainL2Inner
#print axioms MD.Ch05.domainL2NormSquare
#print axioms MD.Ch05.domainL2Complete
#print axioms MD.Ch05.domainL2SymmetricBilinear
#print axioms MD.Ch05.compactL2
#print axioms MD.Ch05.densityAverageOn
#print axioms MD.Ch05.closedSupport
#print axioms MD.Ch05.gaussianL2
#print axioms MD.Ch05.finiteJumpL2
#print axioms MD.Ch05.normalizedAverageFormula
#print axioms MD.Ch05.massFraction
#print axioms MD.Ch05.massDerivative
#print axioms MD.Ch05.massDerivative_smooth
#print axioms MD.Ch05.outwardNormalFor
#print axioms MD.Ch05.generalFluxBalance
#print axioms MD.Ch05.divergence
#print axioms MD.Ch05.liouvillian
#print axioms MD.Ch05.liouvilleEquation
#print axioms MD.Ch05.liouvilleProduct
#print axioms MD.Ch05.lieCoordinates
#print axioms MD.Ch05.divergenceCoordinates
#print axioms MD.Ch05.liouvilleProductCoordinates
#print axioms MD.Ch05.liouvilleProductCoordinates_evolution
#print axioms MD.Ch05.rectangularDomain
#print axioms MD.Ch05.faceFlux
#print axioms MD.Ch05.fluxBalance
#print axioms MD.Ch05.boxBoundaryTerm
#print axioms MD.Ch05.truncatedIntegrationByParts
#print axioms MD.Ch05.rapidAdjoint
#print axioms MD.Ch05.liouvillianAdjoint
#print axioms MD.Ch05.measurePropagator
#print axioms MD.Ch05.measurePropagator_general
#print axioms MD.Ch05.measurePropagator_density_evolution
#print axioms MD.Ch05.hamiltonianDivergence
#print axioms MD.Ch05.hamiltonianSkewExpression
#print axioms MD.Ch05.hamiltonianDensityPropagation
#print axioms MD.Ch05.mechanicalLiouvillian
#print axioms MD.Ch05.mechanicalLiouvillianIdentity
#print axioms MD.Ch05.testSpace
#print axioms MD.Ch05.schwartzTestSpace
#print axioms MD.Ch05.generalizedFunction
#print axioms MD.Ch05.schwartzFunctional
#print axioms MD.Ch05.regularDistribution
#print axioms MD.Ch05.regularDistributionLinearity
#print axioms MD.Ch05.diracAction
#print axioms MD.Ch05.diracMeasure
#print axioms MD.Ch05.diracApproximation
#print axioms MD.Ch05.gaussianDelta
#print axioms MD.Ch05.diracEvaluates
#print axioms MD.Ch05.gaussianDeltaProbability
#print axioms MD.Ch05.gaussianDeltaWeak
#print axioms MD.Ch05.weakStationary
#print axioms MD.Ch05.ensembleAverageOn
#print axioms MD.Ch05.convergenceHeuristic
#print axioms MD.Ch05.hamiltonianEnergyIntegral
#print axioms MD.Ch05.hamiltonianEnergyIntegral_full
#print axioms MD.Ch05.energyDensityInvariant
#print axioms MD.Ch05.shellWeight
#print axioms MD.Ch05.shellPartition
#print axioms MD.Ch05.shellDensity
#print axioms MD.Ch05.energySurface
#print axioms MD.Ch05.surfaceMeasure
#print axioms MD.Ch05.microRaw
#print axioms MD.Ch05.shellWeakPrinted
#print axioms MD.Ch05.shellWeakLimit
#print axioms MD.Ch05.surfaceAreaFormula
#print axioms MD.Ch05.normalField
#print axioms MD.Ch05.normalEnergyTaylor
#print axioms MD.Ch05.normalInverseTaylor
#print axioms MD.Ch05.patchShellVolume
#print axioms MD.Ch05.shellVolumeLimit
#print axioms MD.Ch05.microRawInvariant
#print axioms MD.Ch05.microInvariant
#print axioms MD.Ch05.microPartition
#print axioms MD.Ch05.shellWeakPairing
#print axioms MD.Ch05.harmonicEnergy
#print axioms MD.Ch05.harmonicEnergy_ellipse
#print axioms MD.Ch05.harmonicQuadraturePrinted
#print axioms MD.Ch05.harmonicPartition
#print axioms MD.Ch05.harmonicPartition_quadrature
#print axioms MD.Ch05.idealGasEnergy
#print axioms MD.Ch05.idealGasPositionDomain
#print axioms MD.Ch05.idealGasPartition
#print axioms MD.Ch05.idealGasPartition_factors
#print axioms MD.Ch05.microMeasure
#print axioms MD.Ch05.microProbability
#print axioms MD.Ch05.lowerDimensionNull
#print axioms MD.Ch05.lowerDimensionNull_countable
#print axioms MD.Ch05.lowerDimensionNull_level_dimension
#print axioms MD.Ch05.microAverage
#print axioms MD.Ch05.microAverage_surface_and_delta_limit
#print axioms MD.Ch05.ambientLowerDimensionNull
#print axioms MD.Ch05.timeAverage
#print axioms MD.Ch05.hasTimeAverage
#print axioms MD.Ch05.conservedAverage
#print axioms MD.Ch05.conservedInfiniteAverage
#print axioms MD.Ch05.doubleWellEnergy
#print axioms MD.Ch05.doubleWellCoercivity
#print axioms MD.Ch05.doubleWellDisconnected
#print axioms MD.Ch05.doubleWellBasin
#print axioms MD.Ch05.doubleWellBasin_average_witness
#print axioms MD.Ch05.uniformMicroErgodic
#print axioms MD.Ch05.microErgodic
#print axioms MD.Ch05.flowInvariant
#print axioms MD.Ch05.setErgodic
#print axioms MD.Ch05.invariantIndicator
#print axioms MD.Ch05.invariantIndicatorAverage
#print axioms MD.Ch05.ergodicTimeAverage
#print axioms MD.Ch05.nonergodicSet
#print axioms MD.Ch05.harmonicFlow
#print axioms MD.Ch05.harmonicErgodic
#print axioms MD.Ch05.twoOscillatorEnergy
#print axioms MD.Ch05.twoOscillatorFlow
#print axioms MD.Ch05.twoOscillatorTori
#print axioms MD.Ch05.weakMixing
#print axioms MD.Ch05.kam
#print axioms MD.Ch05.anisotropicPotential
#print axioms MD.Ch05.anisotropicAxisPrinted
#print axioms MD.Ch05.twoOscillatorEnergyDecomposition
#print axioms MD.Ch05.curveImageDimension
#print axioms MD.Ch05.pendulumPotential
#print axioms MD.Ch05.pendulumRegionPrinted
#print axioms MD.Ch05.anisotropicInitialCurve
#print axioms MD.Ch05.anisotropicInitialEnergy
#print axioms MD.Ch05.initialSegmentPrinted
#print axioms MD.Ch05.circleInitialPoints
#print axioms MD.Ch05.circleInitialLaw
#print axioms MD.Ch05.circleInitialEnergy
#print axioms MD.Ch05.correlation
#print axioms MD.Ch05.correlationPullback
#print axioms MD.Ch05.correlationTimePrinted
#print axioms MD.Ch05.correlationTime
#print axioms MD.Ch05.velocityCorrelation
#print axioms MD.Ch05.positionTransition
#print axioms MD.Ch05.transitionProbability
#print axioms MD.Ch05.measureDuality
#print axioms MD.Ch05.mixingMemoryLoss
#print axioms MD.Ch05.mixingCorrelationPrinted
#print axioms MD.Ch05.mixingCorrelation
#print axioms MD.Ch05.centeredCorrelation
#print axioms MD.Ch05.discreteAveragePrinted
#print axioms MD.Ch05.discreteAverage
#print axioms MD.Ch05.discretePropagator
#print axioms MD.Ch05.modifiedField
#print axioms MD.Ch05.modifiedLiouvillian
#print axioms MD.Ch05.forwardEuler
#print axioms MD.Ch05.forwardComponentsPrinted
#print axioms MD.Ch05.forwardEnergyGrowth
#print axioms MD.Ch05.eulerInvariant
#print axioms MD.Ch05.backwardEuler
#print axioms MD.Ch05.backwardEnergyDecay
#print axioms MD.Ch05.backwardEulerLimit
#print axioms MD.Ch05.symplecticEuler
#print axioms MD.Ch05.symplecticEulerShadow
#print axioms MD.Ch05.symplecticEulerEllipse
#print axioms MD.Ch05.symplecticEulerDensity
#print axioms MD.Ch05.verletShadow2
#print axioms MD.Ch05.theorem51
#print axioms MD.Ch05.perturbationDisplacement
#print axioms MD.Ch05.perturbationCorrection
#print axioms MD.Ch05.denominatorBound
#print axioms MD.Ch05.smoothDenominatorBound
#print axioms MD.Ch05.zeroPerturbation
#print axioms MD.Ch05.gradientTransverse
#print axioms MD.Ch05.dynamicalCorrection
#print axioms MD.Ch05.forwardNormDivergence
#print axioms MD.Ch05.weakStationaryModel
#print axioms MD.Ch05.weakAttractor
#print axioms MD.Ch05.eulerLogField
#print axioms MD.Ch05.eulerLogFlow
#print axioms MD.Ch05.eulerLogCorrespondence
#print axioms MD.Ch05.forwardWeakStationary
#print axioms MD.Ch05.backwardWeakStationary
#print axioms MD.Ch05.symplecticWeakStationary
/- END WEBSITE REPAIR AXIOMS -/
