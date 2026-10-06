import MolecularDynamics.Chapter06.LangevinTransitionSemigroup
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.Topology.ContinuousMap.Bounded.Normed
import Mathlib.MeasureTheory.Measure.Portmanteau
import Mathlib.Topology.Semicontinuity.Basic

/-! Weak Feller continuity of the same actual periodic Langevin transition.
This supplies a genuine kernel regularity dependency of Theorem 6.2.
It does not assume or prove a transition density or minorization. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- The true expectation of a bounded continuous test under the actual Langevin transition law. -/
def textbookLangevinPeriodicTransitionExpectation (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) (x : textbookLangevinPeriodicPhase N) : ℝ :=
  ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x

include hB in
/-- The true transition expectation is the actual endpoint integral against the genuine Wiener path law. -/
theorem textbookLangevinPeriodicTransitionExpectation_wiener_path (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f x =
      ∫ W, f (textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property x T W)
        ∂P.map (textbookWienerVectorContinuousPath B T) := by
  unfold textbookLangevinPeriodicTransitionExpectation
  rw [textbookLangevinPeriodicTransitionKernel_apply B P hB U hU hp L hF γ σ T x]
  have mE : Measurable (textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property x T) :=
    (textbookLangevinPeriodicPathEndpoint_joint_continuous U hU hp L hF γ σ T T.property T
      ⟨T.property, le_rfl⟩).comp (continuous_const.prodMk continuous_id) |>.measurable
  exact integral_map mE.aemeasurable f.continuous.aestronglyMeasurable

include hB in
/-- The same transition expectation is literally the expectation of the original all-time Langevin process. -/
theorem textbookLangevinPeriodicTransitionExpectation_actual_process (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f x =
      ∫ sample, f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ∂P := by
  unfold textbookLangevinPeriodicTransitionExpectation
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact integral_map
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property) f.continuous.aestronglyMeasurable

include hB in
/-- Actual joint endpoint continuity and true dominated integration give weak Feller test continuity, even though momentum space is noncompact. -/
theorem textbookLangevinPeriodicTransitionExpectation_continuous (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    Continuous (textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let μ := P.map (textbookWienerVectorContinuousPath B T)
  have hE := textbookLangevinPeriodicPathEndpoint_joint_continuous U hU hp L hF γ σ T T.property T
    ⟨T.property, le_rfl⟩
  have he : textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f =
      fun x ↦ ∫ W, f (textbookLangevinPeriodicPathEndpoint U L hF γ σ T T.property x T W) ∂μ :=
    funext (textbookLangevinPeriodicTransitionExpectation_wiener_path B P hB U hU hp L hF γ σ T f)
  rw [he]
  apply continuous_of_dominated (bound := fun _ ↦ ‖f‖)
  · intro x
    exact (f.continuous.comp (hE.comp (continuous_const.prodMk continuous_id))).aestronglyMeasurable
  · intro x
    exact Eventually.of_forall fun W ↦ f.norm_coe_le_norm _
  · exact integrable_const _
  · exact Eventually.of_forall fun W ↦
      f.continuous.comp (hE.comp (continuous_id.prodMk continuous_const))

include hB in
/-- The actual probability expectation has a genuine uniform bound by the original test norm. -/
theorem textbookLangevinPeriodicTransitionExpectation_norm_le (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) (x : textbookLangevinPeriodicPhase N) :
    ‖textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f x‖ ≤ ‖f‖ := by
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  exact (norm_integral_le_of_norm_le_const (Eventually.of_forall f.norm_coe_le_norm)).trans_eq (by simp)

/-- The actual transition, packaged on the bounded continuous functions of the original noncompact phase space. -/
def textbookLangevinPeriodicBoundedTransition (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ :=
  BoundedContinuousFunction.ofNormedAddCommGroup
    (textbookLangevinPeriodicTransitionExpectation B P U hU hp L hF γ σ T f)
    (textbookLangevinPeriodicTransitionExpectation_continuous B P hB U hU hp L hF γ σ T f)
    ‖f‖ (textbookLangevinPeriodicTransitionExpectation_norm_le B P hB U hU hp L hF γ σ T f)

/-- The same packaged transition is exactly the actual kernel integral at every initial phase. -/
theorem textbookLangevinPeriodicBoundedTransition_apply (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f x =
      ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x := rfl

/-- The true transition contracts the bounded continuous uniform norm. -/
theorem textbookLangevinPeriodicBoundedTransition_norm_le (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    ‖textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f‖ ≤ ‖f‖ :=
  (BoundedContinuousFunction.norm_le (norm_nonneg f)).mpr
    (textbookLangevinPeriodicTransitionExpectation_norm_le B P hB U hU hp L hF γ σ T f)

/-- The actual bounded continuous transition is the identity at zero time. -/
theorem textbookLangevinPeriodicBoundedTransition_zero (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ 0 f = f := by
  ext x
  rw [textbookLangevinPeriodicBoundedTransition_apply,
    textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ, Kernel.id_apply]
  exact integral_dirac _ _

/-- Genuine Chapman–Kolmogorov integration gives the actual bounded-test expectation semigroup law. -/
theorem textbookLangevinPeriodicBoundedTransition_add (S T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) :
    textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ (S + T) f =
      textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ S
        (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
  ext x
  change (∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ (S + T) x) = _
  rw [textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ S T]
  apply Kernel.integral_comp
  exact (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable
    (Eventually.of_forall f.norm_coe_le_norm)

/-- Actual transition expectations preserve nonnegativity. -/
theorem textbookLangevinPeriodicBoundedTransition_nonnegative (T : ℝ≥0)
    (f : BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ) (hf : ∀ x, 0 ≤ f x)
    (x : textbookLangevinPeriodicPhase N) :
    0 ≤ textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T f x :=
  integral_nonneg hf

/-- True probability transitions preserve every constant observable. -/
theorem textbookLangevinPeriodicBoundedTransition_const (T : ℝ≥0) (c : ℝ) :
    textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ T
      (BoundedContinuousFunction.const _ c) = BoundedContinuousFunction.const _ c := by
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  ext x
  change (∫ _, c ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) = c
  simp

/-- The same original actual transition law, as a genuine probability measure with its weak topology. -/
def textbookLangevinPeriodicTransitionProbability (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) :
    ProbabilityMeasure (textbookLangevinPeriodicPhase N) := by
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  exact ⟨textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x, inferInstance⟩

/-- The actual transition laws depend continuously on the true initial phase in the genuine weak topology. -/
theorem textbookLangevinPeriodicTransitionProbability_continuous (T : ℝ≥0) :
    Continuous (textbookLangevinPeriodicTransitionProbability B P hB U hU hp L hF γ σ T) := by
  apply ProbabilityMeasure.continuous_iff_forall_continuous_integral.mpr
  intro f
  exact textbookLangevinPeriodicTransitionExpectation_continuous B P hB U hU hp L hF γ σ T f

include hB in
/-- Original periodic smoothness derives force regularity and the same actual weak Feller probability family; regularity is not a separate model hypothesis. -/
theorem textbookLangevinPeriodicTransitionProbability_weakFeller_of_periodic :
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)), ∀ T : ℝ≥0,
      Continuous (textbookLangevinPeriodicTransitionProbability B P hB U hU hp L hF γ σ T) := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hp
  exact ⟨L, hF, fun T ↦ textbookLangevinPeriodicTransitionProbability_continuous B P hB U hU hp L hF γ σ T⟩


include hB in
/-- A nonempty open target has strictly positive probability under this exact original transition law. -/
theorem textbookLangevinPeriodicTransitionKernel_open_pos (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  let Z := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B
  have hs := textbookLangevinPeriodicGlobalRandomPhase_integralSolution_ae B P hB U hU hp L hF γ σ x
  have hm := textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
    (hU.of_le (by simp)) L hF γ σ x T T.property
  have he : AEMeasurable (fun sample ↦ ((Z T sample).1, (Z T sample).2)) P := by
    simpa only [Prod.mk.eta] using hm
  have ha := textbookLangevinPeriodicEndpoint_open_pos B P hB U hU hp γ σ T hσ hT x
    (fun t sample ↦ (Z t sample).1) (fun t sample ↦ (Z t sample).2)
    (hs.mono fun sample hh ↦ hh T T.property) he C hC hCN
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x,
    Measure.map_apply_of_aemeasurable hm hC.measurableSet]
  exact ha.2

include hB in
/-- Open-target probabilities of the actual kernel are lower semicontinuous by genuine weak convergence, without assuming a density. -/
theorem textbookLangevinPeriodicTransitionKernel_open_lowerSemicontinuous (T : ℝ≥0)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) :
    LowerSemicontinuous (fun x ↦ textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C) := by
  intro x
  apply lowerSemicontinuousAt_iff_le_liminf.mpr
  exact ProbabilityMeasure.le_liminf_measure_open_of_tendsto
    (textbookLangevinPeriodicTransitionProbability_continuous B P hB U hU hp L hF γ σ T).continuousAt hC

include hB in
/-- Every compact set of original initial states has a uniform positive probability of hitting a fixed nonempty open target at a fixed positive time. This is weaker than measure minorization. -/
theorem textbookLangevinPeriodicTransitionKernel_compact_open_uniform_pos
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (hσ : σ ≠ 0)
    (K C : Set (textbookLangevinPeriodicPhase N)) (hK : IsCompact K) (hC : IsOpen C) (hCN : C.Nonempty) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ x ∈ K,
      ENNReal.ofReal ε ≤ textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  by_cases hKN : K.Nonempty
  · have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
    obtain ⟨x, hx, hmin⟩ := LowerSemicontinuousOn.exists_isMinOn hKN hK
      ((textbookLangevinPeriodicTransitionKernel_open_lowerSemicontinuous B P hB U hU hp L hF γ σ T C hC).semicontinuousOn K)
    have hpos := textbookLangevinPeriodicTransitionKernel_open_pos B P hB U hU hp L hF γ σ T hT hσ x C hC hCN
    have hfinite : textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C ≠ (⊤ : ℝ≥0∞) :=
      measure_ne_top _ _
    refine ⟨(textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C).toReal,
      ENNReal.toReal_pos hpos.ne' hfinite, ?_⟩
    intro y hy
    rw [ENNReal.ofReal_toReal hfinite]
    exact hmin hy
  · refine ⟨1, zero_lt_one, ?_⟩
    intro x hx
    exact (hKN ⟨x, hx⟩).elim

include hB in
/-- The actual textbook Hamiltonian-power Lyapunov sublevels have the same genuine compact-uniform open hitting bound. -/
theorem textbookLangevinPeriodicTransitionKernel_energy_sublevel_open_uniform_pos
    (hLower : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) (R : ℝ)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (hσ : σ ≠ 0)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ x : textbookLangevinPeriodicPhase N,
      textbookLangevinPeriodicHamiltonianPower U l x ≤ R →
        ENNReal.ofReal ε ≤ textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  exact textbookLangevinPeriodicTransitionKernel_compact_open_uniform_pos B P hB U hU hp L hF γ σ
    T hT hσ _ C (textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower l hl R) hC hCN


include hB in
/-- The exact common-time, common-interior-point quantifiers of original Assumption 1(i) hold for the same actual kernel on every compact set with nonempty interior. -/
theorem textbookLangevinPeriodicTransitionKernel_assumption1i
    (hσ : σ ≠ 0) (C : Set (textbookLangevinPeriodicPhase N))
    (hC : IsCompact C) (hCi : (interior C).Nonempty) :
    ∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ T : ℝ≥0, (0 : ℝ) < T ∧
      ∀ x ∈ C, 0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x (Metric.ball y δ) := by
  obtain ⟨y, hy⟩ := hCi
  refine ⟨y, hy, fun δ hδ ↦ ⟨1, by norm_num, ?_⟩⟩
  obtain ⟨ε, hε, hb⟩ := textbookLangevinPeriodicTransitionKernel_compact_open_uniform_pos B P hB U hU hp L hF γ σ
    1 (by norm_num) hσ C (Metric.ball y δ) hC Metric.isOpen_ball ⟨y, Metric.mem_ball_self hδ⟩
  intro x hx
  exact lt_of_lt_of_le (ENNReal.ofReal_pos.mpr hε) (hb x hx)

include hU hp in
/-- The genuine original energy sublevel has nonempty interior whenever its threshold exceeds the energy at the specified zero phase. -/
theorem textbookLangevinPeriodicHamiltonianPower_sublevel_interior_nonempty (l : ℕ) (R : ℝ)
    (hR : textbookLangevinPeriodicHamiltonianPower U l
      ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R) :
    (interior {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}).Nonempty := by
  let y : textbookLangevinPeriodicPhase N := (0, 0)
  refine ⟨y, mem_interior_iff_mem_nhds.mpr ?_⟩
  have ho : IsOpen {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z < R} :=
    isOpen_lt (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l) continuous_const
  apply Filter.mem_of_superset (ho.mem_nhds hR)
  intro z hz
  exact (show textbookLangevinPeriodicHamiltonianPower U l z < R from hz).le

include hB in
/-- The original positive-friction, positive-temperature physical Langevin model satisfies Assumption 1(i) on its true energy sublevel; density clause 1(ii) is a separate obligation. -/
theorem textbookLangevinPeriodicTransitionKernel_physical_energy_assumption1i
    (hLower : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) (R : ℝ)
    (hR : textbookLangevinPeriodicHamiltonianPower U l
      ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R)
    (β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) :
    let C := {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}
    ∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ T : ℝ≥0, (0 : ℝ) < T ∧ ∀ x ∈ C,
      0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
        (Real.sqrt (2 * γ * β⁻¹)) T x (Metric.ball y δ) := by
  apply textbookLangevinPeriodicTransitionKernel_assumption1i B P hB U hU hp L hF γ
    (Real.sqrt (2 * γ * β⁻¹))
  · exact ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))
  · exact textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower l hl R
  · exact textbookLangevinPeriodicHamiltonianPower_sublevel_interior_nonempty U hU hp l R hR

end
end MolecularDynamics
