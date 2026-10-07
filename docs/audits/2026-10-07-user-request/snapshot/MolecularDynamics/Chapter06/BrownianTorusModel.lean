import MolecularDynamics.Chapter06.BrownianMarkovModel
import MolecularDynamics.Chapter06.BrownianHilbertCore

/-! The actual original-mass Brownian configuration process on the same unit torus
as the Gibbs spectral model. Its endpoint is independent of the chosen lift.
Stochastic-generator and spectral-evolution identification remain separate. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

private theorem projection_add {Nc : ℕ} (x y : Fin Nc → ℝ) :
    textbookConfigurationTorusProjection (x + y) =
      textbookConfigurationTorusProjection x + textbookConfigurationTorusProjection y := by
  ext i
  exact AddCircle.coe_add (1 : ℝ) (x i) (y i)

private theorem projection_integer_add {Nc : ℕ} (x : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    textbookConfigurationTorusProjection (x + fun i ↦ (n i : ℝ)) =
      textbookConfigurationTorusProjection x := by
  ext i
  have hz : ((n i : ℝ) : UnitAddCircle) = 0 :=
    (AddCircle.coe_eq_zero_iff (1 : ℝ)).mpr ⟨n i, by simp⟩
  change ((x i + (n i : ℝ) : ℝ) : UnitAddCircle) = (x i : UnitAddCircle)
  rw [AddCircle.coe_add, hz, add_zero]

private theorem projection_continuous (Nc : ℕ) :
    Continuous (textbookConfigurationTorusProjection (Nc := Nc)) :=
  (textbookConfigurationTorusProjection_isOpenQuotientMap Nc).continuous

private theorem representative_integer_difference {Nc : ℕ} (x : Fin Nc → ℝ) :
    ∃ n : Fin Nc → ℤ, textbookConfigurationTorusRepresentative
      (textbookConfigurationTorusProjection x) = x + fun i ↦ (n i : ℝ) := by
  classical
  let Q := textbookConfigurationTorusProjection x
  let r := textbookConfigurationTorusRepresentative Q
  have h (i : Fin Nc) : ∃ n : ℤ, (n : ℝ) = r i - x i := by
    have hz : ((r i - x i : ℝ) : UnitAddCircle) = 0 := by
      rw [AddCircle.coe_sub]
      have he := congrFun (textbookConfigurationTorusRepresentative_projects Q) i
      change (r i : UnitAddCircle) = (x i : UnitAddCircle) at he
      rw [he, sub_self]
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp hz
    exact ⟨n, by simpa only [zsmul_eq_mul, mul_one] using hn⟩
  choose n hn using h
  refine ⟨n, ?_⟩
  ext i
  change r i = x i + (n i : ℝ)
  rw [hn i]
  ring

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

include hU hPU in
/-- Actual integral solutions translate by the original integer lattice. -/
theorem textbookBrownianIntegralSolution_integerShift (T : ℝ) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (n : Fin Nc → ℤ)
    (h : textbookBrownianIntegralSolution m U β T x W q) :
    textbookBrownianIntegralSolution m U β T (x + fun i ↦ (n i : ℝ))
      W (fun t ↦ q t + fun i ↦ (n i : ℝ)) := by
  refine ⟨h.1.fun_add continuousOn_const, h.2.1, fun t ht ↦ ?_⟩
  have hint : (∫ s in 0..t, textbookBrownianSDEDrift m U (q s + fun i ↦ (n i : ℝ))) =
      ∫ s in 0..t, textbookBrownianSDEDrift m U (q s) :=
    intervalIntegral.integral_congr (fun s _ ↦ textbookBrownianSDEDrift_periodic m U hU hPU (q s) n)
  change q t + (fun i ↦ (n i : ℝ)) = _
  rw [hint, h.2.2 t ht]
  abel

/-- Uniqueness proves exact integer equivariance of the genuine selected endpoint. -/
theorem textbookBrownianPathEndpoint_integerShift (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (n : Fin Nc → ℤ) (W : C(Icc 0 T, Fin Nc → ℝ))
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT (x + fun i ↦ (n i : ℝ)) t W =
      textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x t W + fun i ↦ (n i : ℝ) := by
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT x W
  have hs := textbookBrownianIntegralSolution_integerShift m U hU hPU β T x _ _ n hq
  exact textbookBrownianIntegralSolution_unique m U hU hPU β T hT _ _ _ _
    (textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT
      (x + fun i ↦ (n i : ℝ)) W) hs t ht

/-- The original inverse-mass drift on the actual unit torus. -/
def textbookBrownianTorusDrift (Q : UnitAddTorus (Fin Nc)) : Fin Nc → ℝ :=
  textbookBrownianSDEDrift m U (textbookConfigurationTorusRepresentative Q)

include hU hPU in
/-- The true torus drift agrees with the original drift at every real representative. -/
theorem textbookBrownianTorusDrift_lift (q : Fin Nc → ℝ) :
    textbookBrownianTorusDrift m U (textbookConfigurationTorusProjection q) =
      textbookBrownianSDEDrift m U q := by
  ext i
  exact textbookConfigurationTorusObservable_lift (fun x ↦ textbookBrownianSDEDrift m U x i)
    (fun x n ↦ congrFun (textbookBrownianSDEDrift_periodic m U hU hPU x n) i) q

include hU hPU in
/-- The actual periodic drift is continuous despite the jumps of a chosen fundamental-domain representative. -/
theorem textbookBrownianTorusDrift_continuous :
    Continuous (textbookBrownianTorusDrift m U) := by
  apply (textbookConfigurationTorusProjection_isOpenQuotientMap Nc).isQuotientMap.continuous_iff.mpr
  have he : textbookBrownianTorusDrift m U ∘ textbookConfigurationTorusProjection =
      textbookBrownianSDEDrift m U := funext (textbookBrownianTorusDrift_lift m U hU hPU)
  rw [he]
  obtain ⟨L, hL⟩ := textbookBrownianSDEDrift_lipschitz m U hU hPU
  exact hL.continuous

/-- The literal original Brownian integral equation on the genuine configuration torus. -/
def textbookBrownianTorusIntegralSolution (T : ℝ) (X : UnitAddTorus (Fin Nc))
    (W : ℝ → (Fin Nc → ℝ)) (Q : ℝ → UnitAddTorus (Fin Nc)) : Prop :=
  ContinuousOn Q (Icc 0 T) ∧ ContinuousOn W (Icc 0 T) ∧
    ∀ t ∈ Icc 0 T, Q t = X + textbookConfigurationTorusProjection
      ((∫ s in 0..t, textbookBrownianTorusDrift m U (Q s)) +
        textbookBrownianSDENoise m β (W t - W 0))

include hU hPU in
/-- Every actual original real integral solution projects to the true periodic integral equation. -/
theorem textbookBrownianIntegralSolution_torusProjection (T : ℝ) (x : Fin Nc → ℝ)
    (W q : ℝ → (Fin Nc → ℝ)) (h : textbookBrownianIntegralSolution m U β T x W q) :
    textbookBrownianTorusIntegralSolution m U β T (textbookConfigurationTorusProjection x) W
      (fun t ↦ textbookConfigurationTorusProjection (q t)) := by
  refine ⟨(projection_continuous Nc).comp_continuousOn h.1, h.2.1, fun t ht ↦ ?_⟩
  have hint : (∫ s in 0..t, textbookBrownianTorusDrift m U
      (textbookConfigurationTorusProjection (q s))) =
        ∫ s in 0..t, textbookBrownianSDEDrift m U (q s) :=
    intervalIntegral.integral_congr (fun s _ ↦ textbookBrownianTorusDrift_lift m U hU hPU (q s))
  change textbookConfigurationTorusProjection (q t) = _
  rw [hint, h.2.2 t ht, add_assoc, projection_add]

/-- The genuine torus endpoint obtained by projecting the actual real solution. -/
def textbookBrownianTorusPathEndpoint (T : ℝ) (hT : 0 ≤ T)
    (X : UnitAddTorus (Fin Nc)) (t : ℝ) (W : C(Icc 0 T, Fin Nc → ℝ)) : UnitAddTorus (Fin Nc) :=
  textbookConfigurationTorusProjection (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT
    (textbookConfigurationTorusRepresentative X) t W)

/-- The actual torus endpoint is independent of every chosen real initial lift. -/
theorem textbookBrownianTorusPathEndpoint_lift (T : ℝ) (hT : 0 ≤ T)
    (x : Fin Nc → ℝ) (t : ℝ) (ht : t ∈ Icc 0 T) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT
      (textbookConfigurationTorusProjection x) t W =
      textbookConfigurationTorusProjection (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT x t W) := by
  obtain ⟨n, hn⟩ := representative_integer_difference x
  unfold textbookBrownianTorusPathEndpoint
  rw [hn, textbookBrownianPathEndpoint_integerShift m hm U hU hPU β hβ T hT x n W t ht,
    projection_integer_add]

/-- Joint endpoint continuity descends through the actual open quotient map. -/
theorem textbookBrownianTorusPathEndpoint_joint_continuous (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun z : UnitAddTorus (Fin Nc) × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2) := by
  have hq : IsOpenQuotientMap (Prod.map
      (textbookConfigurationTorusProjection (Nc := Nc))
      (id : C(Icc 0 T, Fin Nc → ℝ) → C(Icc 0 T, Fin Nc → ℝ))) :=
    (textbookConfigurationTorusProjection_isOpenQuotientMap Nc).prodMap IsOpenQuotientMap.id
  apply hq.isQuotientMap.continuous_iff.mpr
  change Continuous (fun z : (Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ) ↦
    textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT
      (textbookConfigurationTorusProjection z.1) t z.2)
  have he : (fun z : (Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT
        (textbookConfigurationTorusProjection z.1) t z.2) =
      (fun z ↦ textbookConfigurationTorusProjection
        (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2)) :=
    funext (fun z ↦ textbookBrownianTorusPathEndpoint_lift m hm U hU hPU β hβ T hT z.1 t ht z.2)
  rw [he]
  exact (projection_continuous Nc).comp
    (textbookBrownianPathEndpoint_joint_continuous m hm U hU hPU β hβ T hT t ht)

/-- The true torus endpoint is jointly Borel measurable, not assumed measurable. -/
theorem textbookBrownianTorusPathEndpoint_joint_measurable (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : UnitAddTorus (Fin Nc) × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2) :=
  (textbookBrownianTorusPathEndpoint_joint_continuous m hm U hU hPU β hβ T hT t ht).measurable

/-- At every initial torus position the actual endpoint is a measurable function of the true driving path. -/
theorem textbookBrownianTorusPathEndpoint_measurable (T : ℝ) (hT : 0 ≤ T)
    (X : UnitAddTorus (Fin Nc)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT X t) :=
  (projection_continuous Nc).measurable.comp
    (textbookBrownianPathEndpoint_measurable m hm U hU hPU β hβ T hT
      (textbookConfigurationTorusRepresentative X) t ht)

/-- One actual all-time Brownian configuration on the same unit torus as the Gibbs model. -/
def textbookBrownianTorusGlobalRandomConfiguration {Ω : Type*}
    (X : UnitAddTorus (Fin Nc)) (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (t : ℝ) (sample : Ω) :
    UnitAddTorus (Fin Nc) :=
  textbookConfigurationTorusProjection (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
    (textbookConfigurationTorusRepresentative X) B t sample)
/-- On one full-measure set the same global torus process solves every finite original periodic integral equation. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_integralSolution_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) :
    ∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
      textbookBrownianTorusIntegralSolution m U β T X (fun t ↦ B t.toNNReal sample)
        (fun t ↦ textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB
    (textbookConfigurationTorusRepresentative X)] with sample hs
  intro T hT
  have h := textbookBrownianIntegralSolution_torusProjection m U hU hPU β T
    (textbookConfigurationTorusRepresentative X) _ _ (hs T hT)
  rw [textbookConfigurationTorusRepresentative_projects] at h
  exact h

/-- The actual torus process starts at the specified torus position on every sample. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_initial {Ω : Type*}
    (X : UnitAddTorus (Fin Nc)) (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (sample : Ω) :
    textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B 0 sample = X := by
  unfold textbookBrownianTorusGlobalRandomConfiguration
  rw [textbookBrownianGlobalRandomConfiguration_initial, textbookConfigurationTorusRepresentative_projects]

/-- The same actual torus process has a.e.-measurable evaluations at every nonnegative time. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_endpoint_aemeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) (t : ℝ) (ht : 0 ≤ t) :
    AEMeasurable (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t) P :=
  (projection_continuous Nc).measurable.comp_aemeasurable
    (textbookBrownianGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB
      (textbookConfigurationTorusRepresentative X) t ht)

/-- Almost surely the same actual torus process is continuous on all nonnegative times. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_continuousOn_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) :
    ∀ᵐ sample ∂P, ContinuousOn
      (fun t ↦ textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t sample) (Ici 0) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_continuousOn_ae m hm U hU hPU β hβ B P hB
    (textbookConfigurationTorusRepresentative X)] with sample hc
  exact (projection_continuous Nc).comp_continuousOn hc

/-- The actual torus process is genuinely adapted to the completed Wiener history. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_adapted {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) :
    Adapted (textbookWienerVectorCompletedFiltration B P hB)
      (fun S : ℝ≥0 ↦ textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B S) :=
  fun S ↦ (projection_continuous Nc).measurable.comp
    (textbookBrownianGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB
      (textbookConfigurationTorusRepresentative X) S)

/-- The actual periodic endpoint restarts with the same genuine future Wiener path, independently of the current lift. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_future_restart_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) :
    ∀ᵐ sample ∂P, ∀ S : ℝ≥0, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B (S + t) sample =
        textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT
          (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B S sample) t
          (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_future_restart_ae m hm U hU hPU β hβ B P hB
    (textbookConfigurationTorusRepresentative X)] with sample hr
  intro S T hT t ht
  calc
    _ = textbookConfigurationTorusProjection (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT
        (textbookBrownianGlobalRandomConfiguration m hm U hU hPU β hβ
          (textbookConfigurationTorusRepresentative X) B S sample) t
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T sample)) :=
      congrArg textbookConfigurationTorusProjection (hr S T hT t ht)
    _ = _ := (textbookBrownianTorusPathEndpoint_lift m hm U hU hPU β hβ T hT _ t ht _).symm


/-- On one common full-measure set the actual torus process equals its construction from every true finite noise history. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_history_path_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) :
    ∀ᵐ sample ∂P, ∀ T : ℝ, ∀ hT : 0 ≤ T, ∀ t ∈ Icc 0 T,
      textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t sample =
        textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT X t
          (textbookWienerVectorContinuousPath B T sample) := by
  filter_upwards [textbookBrownianGlobalRandomConfiguration_history_path_ae m hm U hU hPU β hβ B P hB
    (textbookConfigurationTorusRepresentative X)] with sample hs
  intro T hT t ht
  exact congrArg textbookConfigurationTorusProjection (hs T hT t ht)

/-- The original zero-start Wiener law gives the literal periodic physical equation for all nonnegative times. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_original_equation_ae {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) :
    ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t →
      textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t sample =
        X + textbookConfigurationTorusProjection
          ((∫ s in 0..t, textbookBrownianTorusDrift m U
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B s sample)) +
              textbookBrownianSDENoise m β (B t.toNNReal sample)) := by
  filter_upwards [textbookBrownianTorusGlobalRandomConfiguration_integralSolution_ae m hm U hU hPU β hβ B P hB X,
    textbookWienerVector_zero_ae B P hB] with sample hs hz
  intro t ht
  simpa only [Real.toNNReal_zero, hz, sub_zero] using (hs t ht).2.2 t ⟨ht, le_rfl⟩

/-- The true time law of the same all-time torus configuration process. -/
def textbookBrownianTorusGlobalTimeLaw {Ω : Type*} [MeasurableSpace Ω]
    (X : UnitAddTorus (Fin Nc)) (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (t : ℝ) :
    Measure (UnitAddTorus (Fin Nc)) :=
  P.map (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t)

/-- At each nonnegative time the actual torus law is a genuine probability measure. -/
theorem textbookBrownianTorusGlobalTimeLaw_isProbabilityMeasure {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) (t : ℝ) (ht : 0 ≤ t) :
    IsProbabilityMeasure (textbookBrownianTorusGlobalTimeLaw m hm U hU hPU β hβ X B P t) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hf := textbookBrownianTorusGlobalRandomConfiguration_endpoint_aemeasurable
    m hm U hU hPU β hβ B P hB X t ht
  refine ⟨?_⟩
  rw [textbookBrownianTorusGlobalTimeLaw, Measure.map_apply_of_aemeasurable hf MeasurableSet.univ,
    preimage_univ, measure_univ]

/-- The genuine torus time law gives the actual endpoint event probability. -/
theorem textbookBrownianTorusGlobalTimeLaw_apply {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (X : UnitAddTorus (Fin Nc)) (t : ℝ) (ht : 0 ≤ t)
    (S : Set (UnitAddTorus (Fin Nc))) (hS : MeasurableSet S) :
    textbookBrownianTorusGlobalTimeLaw m hm U hU hPU β hβ X B P t S =
      P {sample | textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ X B t sample ∈ S} :=
  Measure.map_apply_of_aemeasurable
    (textbookBrownianTorusGlobalRandomConfiguration_endpoint_aemeasurable m hm U hU hPU β hβ B P hB X t ht) hS

/-- The actual transition kernel integrates the original Brownian endpoint against the genuine Wiener path law. -/
def textbookBrownianTorusTransitionKernel {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (T : ℝ≥0) :
    Kernel (UnitAddTorus (Fin Nc)) (UnitAddTorus (Fin Nc)) :=
  (Kernel.deterministic
    (fun z : UnitAddTorus (Fin Nc) × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T T.property z.1 T z.2)
    (textbookBrownianTorusPathEndpoint_joint_measurable m hm U hU hPU β hβ
      T T.property T ⟨T.property, le_rfl⟩)) ∘ₖ
      (Kernel.id ×ₖ Kernel.const (UnitAddTorus (Fin Nc)) (P.map (textbookWienerVectorContinuousPath B T)))

/-- The genuine Wiener law makes the actual Brownian transition kernel a probability kernel. -/
theorem textbookBrownianTorusTransitionKernel_isMarkov {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) :
    IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookBrownianTorusTransitionKernel
  infer_instance

/-- Each genuine transition measure is literally the endpoint pushforward of the true continuous Wiener path law. -/
theorem textbookBrownianTorusTransitionKernel_apply {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (x : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x =
      (P.map (textbookWienerVectorContinuousPath B T)).map
        (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T T.property x T) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  unfold textbookBrownianTorusTransitionKernel
  rw [Kernel.deterministic_comp_eq_map, Kernel.map_apply, Kernel.prod_apply,
    Kernel.id_apply, Kernel.const_apply, Measure.dirac_prod, Measure.map_map]
  all_goals first
    | exact textbookBrownianTorusPathEndpoint_joint_measurable m hm U hU hPU β hβ
        T T.property T ⟨T.property, le_rfl⟩
    | exact measurable_prodMk_left
    | rfl

/-- The transition measure is the actual time law of the same single global Wiener-driven Brownian process. -/
theorem textbookBrownianTorusTransitionKernel_global_law {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (x : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x =
      textbookBrownianTorusGlobalTimeLaw m hm U hU hPU β hβ x B P T := by
  rw [textbookBrownianTorusTransitionKernel_apply m hm U hU hPU β hβ B P hB T x,
    AEMeasurable.map_map_of_aemeasurable
      (textbookBrownianTorusPathEndpoint_measurable m hm U hU hPU β hβ T T.property x T
        ⟨T.property, le_rfl⟩).aemeasurable
      (textbookWienerVectorContinuousPath_aemeasurable B P hB T)]
  apply Measure.map_congr
  filter_upwards [textbookBrownianTorusGlobalRandomConfiguration_history_path_ae m hm U hU hPU β hβ B P hB x]
    with sample hs
  exact (hs T T.property T ⟨T.property, le_rfl⟩).symm

/-- The actual Brownian transition laws are independent of the realization of the genuine standard Wiener process. -/
theorem textbookBrownianTorusTransitionKernel_wiener_law_invariant {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (C : ℝ≥0 → Ω' → (Fin Nc → ℝ)) (Q : Measure Ω') (hC : textbookIsWienerVector C Q)
    (T : ℝ≥0) :
    textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T =
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ C Q T := by
  unfold textbookBrownianTorusTransitionKernel
  rw [textbookWienerVectorContinuousPath_law_eq B P hB C Q hC T T.property]



/-- For every actual real initial representative the torus transition law is the true projection of the original lift law. -/
theorem textbookBrownianTorusTransitionKernel_projection {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (x : Fin Nc → ℝ) :
    textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T
      (textbookConfigurationTorusProjection x) =
      (textbookBrownianTransitionKernel m hm U hU hPU β hβ B P T x).map
        textbookConfigurationTorusProjection := by
  rw [textbookBrownianTorusTransitionKernel_apply m hm U hU hPU β hβ B P hB T,
    textbookBrownianTransitionKernel_apply m hm U hU hPU β hβ B P hB T,
    Measure.map_map (projection_continuous Nc).measurable
      (textbookBrownianPathEndpoint_measurable m hm U hU hPU β hβ T T.property x T ⟨T.property, le_rfl⟩)]
  apply Measure.map_congr
  exact Filter.Eventually.of_forall (fun W ↦
    textbookBrownianTorusPathEndpoint_lift m hm U hU hPU β hβ T T.property x T ⟨T.property, le_rfl⟩ W)

private theorem completedTorusBrownian_endpoint_joint_law
    {A H X W : Type*} [MeasurableSpace A] [MeasurableSpace H]
    [MeasurableSpace X] [MeasurableSpace W]
    (Q : Measure A) [IsProbabilityMeasure Q] (μ : Measure W) [SFinite μ]
    (Hobs : A → H) (mh : Measurable Hobs) (F : A → W) (mf : Measurable F)
    (e : H → X) (me : Measurable e) (E : X × W → X) (mE : Measurable E)
    (Y : A → X) (κ : Kernel X X) [IsMarkovKernel κ]
    (hj : Q.map (fun sample ↦ (Hobs sample, F sample)) = (Q.map Hobs).prod μ)
    (hr : Y =ᵐ[Q] fun sample ↦ E (e (Hobs sample), F sample))
    (hκ : ∀ x, κ x = μ.map (fun w ↦ E (x, w))) :
    Q.map (fun sample ↦ (Hobs sample, Y sample)) = (Q.map Hobs) ⊗ₘ κ.comap e me := by
  let G : H × W → H × X := fun z ↦ (z.1, E (e z.1, z.2))
  have mG : Measurable G :=
    measurable_fst.prodMk (mE.comp ((me.comp measurable_fst).prodMk measurable_snd))
  have hmap : Q.map (fun sample ↦ (Hobs sample, Y sample)) =
      (Q.map (fun sample ↦ (Hobs sample, F sample))).map G := by
    rw [Measure.map_map mG (mh.prodMk mf)]
    apply Measure.map_congr
    filter_upwards [hr] with sample hs using Prod.ext rfl hs
  rw [hmap, hj]
  ext a ha
  rw [Measure.map_apply mG ha, Measure.prod_apply (mG ha), Measure.compProd_apply ha]
  apply lintegral_congr
  intro h
  have mef : Measurable (fun w : W ↦ E (e h, w)) :=
    mE.comp (measurable_const.prodMk measurable_id)
  rw [Kernel.comap_apply, hκ, Measure.map_apply mef (ha.preimage measurable_prodMk_left)]
  rfl






/-- The same actual torus configuration and the entire completed Wiener past have their true transition disintegration. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_completed_history_transition_joint_law
    {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : UnitAddTorus (Fin Nc)) (S T : ℝ≥0) :
    @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
      (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B ((S : ℝ) + T) sample)) P.completion =
    (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ
      (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T).comap
        (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
          textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample)
        (textbookBrownianTorusGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  have mf : @Measurable (NullMeasurableSpace Ω P) C(Icc (0 : ℝ) T, Fin Nc → ℝ) _ _
      (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) :=
    (textbookWienerVectorContinuousPath_aemeasurable _ P
      (textbookWienerVectorFuture_isWiener B P hB S) T).nullMeasurable.measurable'
  apply completedTorusBrownian_endpoint_joint_law P.completion
    (P.map (textbookWienerVectorContinuousPath B T))
    (textbookWienerVectorCompletedHistoryObservation B P hB S)
    (textbookWienerVectorCompletedHistoryObservation_measurable B P hB S)
    _ mf _ (textbookBrownianTorusGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S)
    (fun z : UnitAddTorus (Fin Nc) × C(Icc (0 : ℝ) T, Fin Nc → ℝ) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T T.property z.1 T z.2)
    (textbookBrownianTorusPathEndpoint_joint_measurable m hm U hU hPU β hβ
      T T.property T ⟨T.property, le_rfl⟩)
  · exact textbookWienerVectorFuture_completed_history_product_law B P hB S T
  · rw [Measure.ae_completion]
    filter_upwards [textbookBrownianTorusGlobalRandomConfiguration_future_restart_ae m hm U hU hPU β hβ B P hB x]
      with sample hs
    exact hs S T T.property T ⟨T.property, le_rfl⟩
  · exact textbookBrownianTorusTransitionKernel_apply m hm U hU hPU β hβ B P hB T

/-- Given the actual completed Wiener past, the same actual future-state law depends only on the current state. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_condDistrib_completed_history
    {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (x : UnitAddTorus (Fin Nc)) (S T : ℝ≥0) :
    letI : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
    letI : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
    ∀ᵐ sample ∂P.completion,
      @condDistrib (NullMeasurableSpace Ω P)
        (textbookWienerVectorCompletedHistorySpace B P hB S) (UnitAddTorus (Fin Nc))
        inferInstance inferInstance inferInstance inferInstance inferInstance
        (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B ((S : ℝ) + T))
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S sample) =
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T
        (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  have mh := textbookWienerVectorCompletedHistoryObservation_measurable B P hB S
  have my := (textbookBrownianTorusGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x).measurable
    (i := S + T)
  let κ : Kernel (textbookWienerVectorCompletedHistorySpace B P hB S) (UnitAddTorus (Fin Nc)) :=
    (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T).comap
      (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
        textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample)
      (textbookBrownianTorusGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S)
  have : IsMarkovKernel κ := by
    refine ⟨fun sample ↦ ⟨?_⟩⟩
    change (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T
      (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B S sample)) univ = 1
    exact measure_univ
  have hj : @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (fun sample ↦ (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
        textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B ((S : ℝ) + T) sample)) P.completion =
      (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ κ :=
    textbookBrownianTorusGlobalRandomConfiguration_completed_history_transition_joint_law m hm U hU hPU β hβ B P hB x S T
  have hc := condDistrib_ae_eq_of_measure_eq_compProd (κ := κ)
    mh.aemeasurable my.aemeasurable hj
  exact ae_of_ae_map mh.aemeasurable hc



end
end MolecularDynamics
