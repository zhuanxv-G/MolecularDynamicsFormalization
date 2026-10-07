import MolecularDynamics.Chapter06.BrownianGibbsPoincare

/-! Actual Hilbert variance and closed-domain coercivity for the original Gibbs Brownian generator. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The genuine continuous torus observable of any full original smooth periodic lift. -/
def textbookPeriodicSmoothContinuous {Nc : ℕ} (f : textbookPeriodicSmoothSpace Nc) :
    C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨textbookConfigurationTorusObservable (f : (Fin Nc → ℝ) → ℝ), by
    have hf : ContDiff ℝ ∞ (f : (Fin Nc → ℝ) → ℝ) := f.prop.1
    have hp : textbookUnitPeriodicPotential (f : (Fin Nc → ℝ) → ℝ) := f.prop.2
    exact textbookConfigurationTorusObservable_continuous _ hf.continuous hp⟩

/-- The genuine continuous smooth observable returns the original full Euclidean lift. -/
theorem textbookPeriodicSmoothContinuous_lift {Nc : ℕ} (f : textbookPeriodicSmoothSpace Nc)
    (q : Fin Nc → ℝ) :
    textbookPeriodicSmoothContinuous f (textbookConfigurationTorusProjection q) = (f : (Fin Nc → ℝ) → ℝ) q := by
  exact textbookConfigurationTorusObservable_lift (f : (Fin Nc → ℝ) → ℝ) f.prop.2 q

/-- Actual constant smooth lifts give exactly the original constant continuous torus observables. -/
theorem textbookPeriodicSmoothContinuous_const (Nc : ℕ) (c : ℝ) :
    textbookPeriodicSmoothContinuous (textbookPeriodicSmoothConstant Nc c) =
      ContinuousMap.const (UnitAddTorus (Fin Nc)) c := by
  ext Q
  rfl

/-- The same smooth-domain Hilbert embedding is the actual continuous-to-L² map, proved via genuine AE equality. -/
theorem textbookPeriodicSmoothEmbedding_eq_continuousToLp {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookPeriodicSmoothEmbedding U hU hPU β f =
      textbookGibbsContinuousToLp U hU hPU β (textbookPeriodicSmoothContinuous f) := by
  apply Lp.ext
  filter_upwards [textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f
      f.prop.1.continuous f.prop.2,
    textbookGibbsContinuousToLp_ae_eq U hU hPU β (textbookPeriodicSmoothContinuous f)]
      with Q hLift hContinuous
  exact hLift.trans hContinuous.symm

/-- The actual original smooth-domain constant-one vector has true Hilbert norm one. -/
theorem textbookPeriodicSmoothEmbedding_one_norm {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    ‖textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)‖ = 1 :=
  textbookConfigurationGibbsL2Observable_one_norm U hU hPU β

/-- The actual smooth-vector pairing with constant one equals its genuine Gibbs mean. -/
theorem textbookPeriodicSmoothEmbedding_inner_one {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
      textbookPeriodicSmoothEmbedding U hU hPU β f⟫_ℝ =
        textbookGibbsMean U β (textbookPeriodicSmoothContinuous f) := by
  rw [textbookPeriodicSmoothEmbedding_eq_continuousToLp U hU hPU β f,
    textbookPeriodicSmoothEmbedding_eq_continuousToLp U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
    textbookPeriodicSmoothContinuous_const]
  exact textbookGibbsContinuousToLp_inner_one U hU hPU β (textbookPeriodicSmoothContinuous f)

/-- True full smooth-domain variance is the actual Hilbert norm squared minus the actual constant-mode pairing squared. -/
theorem textbookPeriodicSmoothEmbedding_variance {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookGibbsVariance U β (textbookPeriodicSmoothContinuous f) =
      ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ ^ 2 -
        ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
          textbookPeriodicSmoothEmbedding U hU hPU β f⟫_ℝ ^ 2 := by
  rw [textbookPeriodicSmoothEmbedding_inner_one,
    textbookPeriodicSmoothEmbedding_eq_continuousToLp,
    textbookGibbsContinuousToLp_norm_sq U hU hPU β]
  exact textbookGibbsVariance_eq_sub U hU hPU β (textbookPeriodicSmoothContinuous f)

/-- The derived coercivity rate times its actual Poincare constant is exactly inverse temperature. -/
theorem textbookBrownianGibbsCoercivityRate_mul_constant {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookBrownianGibbsCoercivityRate m U hU hPU β * textbookGibbsPoincareConstant m U hU hPU β =
      β⁻¹ := by
  have hC := textbookGibbsPoincareConstant_pos m U hU hPU β
  unfold textbookBrownianGibbsCoercivityRate
  rw [mul_inv_rev]
  calc
    _ = β⁻¹ * ((textbookGibbsPoincareConstant m U hU hPU β)⁻¹ *
        textbookGibbsPoincareConstant m U hU hPU β) := by ring
    _ = _ := by rw [inv_mul_cancel₀ (ne_of_gt hC), mul_one]

/-- The original full smooth Hilbert domain has actual quantitative coercivity modulo its true constant mode. -/
theorem textbookBrownianGibbsDomainOperator_coercive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : textbookBrownianGibbsSmoothDomain U hU hPU β) :
    textbookBrownianGibbsCoercivityRate m U hU hPU β *
      (‖(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))‖ ^ 2 -
        ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
          (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ ^ 2) ≤
      -⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
        textbookBrownianGibbsDomainOperator m U hU hPU β x⟫_ℝ := by
  obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).surjective x
  rw [textbookPeriodicSmoothEmbeddingEquiv_coe,
    ← textbookPeriodicSmoothEmbedding_variance U hU hPU β f]
  have hLift : (fun q : Fin Nc → ℝ ↦
      textbookPeriodicSmoothContinuous f (textbookConfigurationTorusProjection q)) =
      (f : (Fin Nc → ℝ) → ℝ) := by
    funext q
    exact textbookPeriodicSmoothContinuous_lift f q
  have hg : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
      textbookPeriodicSmoothContinuous f (textbookConfigurationTorusProjection q)) := by
    rw [hLift]
    exact f.prop.1
  have hv := textbookGibbsVariance_poincare m hm U hU hPU β (textbookPeriodicSmoothContinuous f) hg
  rw [hLift] at hv
  have hr := textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ
  have he : ⟪textbookPeriodicSmoothEmbedding U hU hPU β f,
      textbookBrownianGibbsDomainOperator m U hU hPU β
        (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β f)⟫_ℝ =
      -β⁻¹ * textbookTorusGibbsGradientEnergy m U β (f : (Fin Nc → ℝ) → ℝ) := by
    exact textbookBrownianGibbsDomainOperator_dirichlet m U hU hPU β (ne_of_gt hβ) f f
  calc
    _ ≤ textbookBrownianGibbsCoercivityRate m U hU hPU β *
        (textbookGibbsPoincareConstant m U hU hPU β *
          textbookTorusGibbsGradientEnergy m U β (f : (Fin Nc → ℝ) → ℝ)) :=
      mul_le_mul_of_nonneg_left hv hr.le
    _ = β⁻¹ * textbookTorusGibbsGradientEnergy m U β (f : (Fin Nc → ℝ) → ℝ) := by
      rw [← mul_assoc, textbookBrownianGibbsCoercivityRate_mul_constant]
    _ = _ := by rw [he]; ring

set_option maxHeartbeats 800000 in
/-- The genuine graph closure retains the quantitative original-model coercivity on its entire actual domain. -/
theorem textbookBrownianGibbsClosedOperator_coercive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain) :
    textbookBrownianGibbsCoercivityRate m U hU hPU β *
      (‖(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))‖ ^ 2 -
        ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
          (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ ^ 2) ≤
      -⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
        textbookBrownianGibbsClosedOperator m U hU hPU β x⟫_ℝ := by
  let H : Type := Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)
  let one : H := textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
  let κ := textbookBrownianGibbsCoercivityRate m U hU hPU β
  let C : Set (H × H) := {z | κ * (‖z.1‖ ^ 2 - ⟪one, z.1⟫_ℝ ^ 2) ≤ -⟪z.1, z.2⟫_ℝ}
  change ((x : H), textbookBrownianGibbsClosedOperator m U hU hPU β x) ∈ C
  have hnorm : Continuous (fun z : H × H ↦ ‖z.1‖ ^ 2) := continuous_fst.norm.pow 2
  have hmean : Continuous (fun z : H × H ↦ ⟪one, z.1⟫_ℝ ^ 2) :=
    (continuous_const.inner continuous_fst).pow 2
  have hlhs : Continuous (fun z : H × H ↦ κ * (‖z.1‖ ^ 2 - ⟪one, z.1⟫_ℝ ^ 2)) :=
    continuous_const.mul (hnorm.sub hmean)
  have hrhs : Continuous (fun z : H × H ↦ -⟪z.1, z.2⟫_ℝ) :=
    (continuous_fst.inner continuous_snd).neg
  have hclosed : IsClosed C := isClosed_le hlhs hrhs
  have hsub : ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph : Set (H × H)) ⊆ C := by
    intro z hz
    rcases (LinearPMap.mem_graph_iff' _).mp hz with ⟨a, rfl⟩
    change κ * (‖(a : H)‖ ^ 2 - ⟪one, (a : H)⟫_ℝ ^ 2) ≤
      -⟪(a : H), textbookBrownianGibbsPartialOperator m U hU hPU β a⟫_ℝ
    exact textbookBrownianGibbsDomainOperator_coercive m hm U hU hPU β hβ a
  have hx : ((x : H), textbookBrownianGibbsClosedOperator m U hU hPU β x) ∈
      closure ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph : Set (H × H)) := by
    change ((x : H), textbookBrownianGibbsClosedOperator m U hU hPU β x) ∈
      (textbookBrownianGibbsPartialOperator m U hU hPU β).graph.topologicalClosure
    rw [textbookBrownianGibbsClosedOperator_graph m U hU hPU β (ne_of_gt hβ)]
    exact LinearPMap.mem_graph _ x
  have hc : closure ((textbookBrownianGibbsPartialOperator m U hU hPU β).graph :
      Set (H × H)) ⊆ C := closure_minimal hsub hclosed
  exact hc hx
/-- Actual orthogonality to the true constant mode gives strict closed-domain coercivity with derived positive rate. -/
theorem textbookBrownianGibbsClosedOperator_orthogonal_coercive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain)
    (hx : ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
      (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ = 0) :
    textbookBrownianGibbsCoercivityRate m U hU hPU β *
      ‖(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))‖ ^ 2 ≤
        -⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
          textbookBrownianGibbsClosedOperator m U hU hPU β x⟫_ℝ := by
  have h := textbookBrownianGibbsClosedOperator_coercive m hm U hU hPU β hβ x
  simp only [hx, zero_pow two_ne_zero, sub_zero] at h
  exact h

/-- Orthogonal removal of the actual normalized constant mode has exactly the true Hilbert variance norm. -/
theorem textbookGibbsConstantProjection_norm_sq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    ‖x - ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
        x⟫_ℝ • textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)‖ ^ 2 =
      ‖x‖ ^ 2 -
        ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1), x⟫_ℝ ^ 2 := by
  let e := textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
  have he : ‖e‖ = 1 := textbookPeriodicSmoothEmbedding_one_norm U hU hPU β
  change ‖x - ⟪e, x⟫_ℝ • e‖ ^ 2 = ‖x‖ ^ 2 - ⟪e, x⟫_ℝ ^ 2
  rw [norm_sub_sq_real, real_inner_smul_right, real_inner_comm x e, norm_smul, he]
  simp only [mul_one, Real.norm_eq_abs, sq_abs]
  ring

/-- Every genuine zero vector of the actual closed generator is exactly its true constant-mode projection. -/
theorem textbookBrownianGibbsClosedOperator_kernel_constant {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain)
    (hx : textbookBrownianGibbsClosedOperator m U hU hPU β x = 0) :
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) =
      ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
        (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ •
          textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1) := by
  let H : Type := Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)
  let e : H := textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
  have h := textbookBrownianGibbsClosedOperator_coercive m hm U hU hPU β hβ x
  rw [hx, inner_zero_right, neg_zero] at h
  have he : ‖(x : H) - ⟪e, (x : H)⟫_ℝ • e‖ ^ 2 =
      ‖(x : H)‖ ^ 2 - ⟪e, (x : H)⟫_ℝ ^ 2 :=
    textbookGibbsConstantProjection_norm_sq U hU hPU β x
  change textbookBrownianGibbsCoercivityRate m U hU hPU β *
    (‖(x : H)‖ ^ 2 - ⟪e, (x : H)⟫_ℝ ^ 2) ≤ 0 at h
  rw [← he] at h
  have hr := textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ
  have hle : ‖(x : H) - ⟪e, (x : H)⟫_ℝ • e‖ ^ 2 ≤ 0 := by
    by_contra hn
    exact (not_lt_of_ge h) (mul_pos hr (lt_of_not_ge hn))
  have hz : ‖(x : H) - ⟪e, (x : H)⟫_ℝ • e‖ ^ 2 = 0 :=
    le_antisymm hle (sq_nonneg _)
  have hnorm : ‖(x : H) - ⟪e, (x : H)⟫_ℝ • e‖ = 0 := sq_eq_zero_iff.mp hz
  exact sub_eq_zero.mp (norm_eq_zero.mp hnorm)

/-- Formal symmetry against the actual constant zero mode forces every nonzero real eigenvalue to be orthogonal to it. -/
theorem textbookBrownianGibbsClosedOperator_eigenvalue_orthogonal {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : β ≠ 0) (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain)
    (ℓ : ℝ) (hℓ : ℓ ≠ 0)
    (heig : textbookBrownianGibbsClosedOperator m U hU hPU β x =
      ℓ • (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) :
    ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
      (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ = 0 := by
  let y := Submodule.inclusion (textbookBrownianGibbsPartialOperator_le_closed m U hU hPU β).1
    (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc 1))
  have hy : textbookBrownianGibbsClosedOperator m U hU hPU β y = 0 := by
    exact textbookBrownianGibbsClosedOperator_const m U hU hPU β 1
  have h := textbookBrownianGibbsClosedOperator_formalAdjoint m U hU hPU β hβ y x
  change ⟪textbookBrownianGibbsClosedOperator m U hU hPU β y,
      (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ =
      ⟪textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1),
        textbookBrownianGibbsClosedOperator m U hU hPU β x⟫_ℝ at h
  rw [hy, inner_zero_left, heig, real_inner_smul_right] at h
  exact (mul_eq_zero.mp h.symm).resolve_left hℓ

/-- Every nonzero real eigenvalue of the actual closed generator has the derived negative separation from zero. -/
theorem textbookBrownianGibbsClosedOperator_real_eigenvalue_bound {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : (textbookBrownianGibbsClosedOperator m U hU hPU β).domain)
    (hx : (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) ≠ 0)
    (ℓ : ℝ) (hℓ : ℓ ≠ 0)
    (heig : textbookBrownianGibbsClosedOperator m U hU hPU β x =
      ℓ • (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) :
    ℓ ≤ -textbookBrownianGibbsCoercivityRate m U hU hPU β := by
  have hm0 := textbookBrownianGibbsClosedOperator_eigenvalue_orthogonal m U hU hPU β
    (ne_of_gt hβ) x ℓ hℓ heig
  have h := textbookBrownianGibbsClosedOperator_orthogonal_coercive m hm U hU hPU β hβ x hm0
  rw [heig, real_inner_smul_right, real_inner_self_eq_norm_sq] at h
  have hs : 0 < ‖(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))‖ ^ 2 :=
    pow_pos (norm_pos_iff.mpr hx) 2
  by_contra hn
  have hp : 0 < textbookBrownianGibbsCoercivityRate m U hU hPU β + ℓ := by linarith
  have hc := mul_pos hp hs
  nlinarith

end

end MolecularDynamics
