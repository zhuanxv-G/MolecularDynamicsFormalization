import MolecularDynamics.Chapter06.LangevinFutureLaw
import MolecularDynamics.Chapter06.LangevinPeriodicLyapunov

/-! Necessary joint initial-state/noise-path measurability for the actual Markov model
in Theorem 6.2 (printed 252 / PDF 273). All dependence bounds follow from actual integral solutions. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- Actual compensated solutions driven by the same noise depend exponentially on their initial states. -/
theorem textbookLangevinNoiseCompensated_initial_dist_le {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x y : textbookLangevinPhase Nc) (W q p qr pr : ℝ → (Fin Nc → ℝ))
    (hx : textbookLangevinIntegralSolution U γ σ T x W q p)
    (hy : textbookLangevinIntegralSolution U γ σ T y W qr pr) (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (textbookLangevinNoiseCompensated σ W q p t)
      (textbookLangevinNoiseCompensated σ W qr pr t) ≤
        dist x y * Real.exp ((1 + (L : ℝ) + ‖γ‖) * t) := by
  have h := dist_le_of_trajectories_ODE
    (fun s ↦ textbookLangevinDrivenField_lipschitz U L hF γ σ W s)
    (textbookLangevinNoiseCompensated_continuousOn U γ σ T x W q p hx)
    (textbookLangevinNoiseCompensated_hasDerivWithinAt U hU γ σ T x W q p hx)
    (textbookLangevinNoiseCompensated_continuousOn U γ σ T y W qr pr hy)
    (textbookLangevinNoiseCompensated_hasDerivWithinAt U hU γ σ T y W qr pr hy)
    (by rw [textbookLangevinNoiseCompensated_initial U γ σ T hT x W q p hx,
      textbookLangevinNoiseCompensated_initial U γ σ T hT y W qr pr hy]) t ht
  simpa only [sub_zero, NNReal.coe_add, NNReal.coe_one, coe_nnnorm] using h

/-- Undoing the same noise compensation gives the exponential initial-state bound in real phase coordinates. -/
theorem textbookLangevinIntegralSolution_initial_dist_le {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (x y : textbookLangevinPhase Nc) (W q p qr pr : ℝ → (Fin Nc → ℝ))
    (hx : textbookLangevinIntegralSolution U γ σ T x W q p)
    (hy : textbookLangevinIntegralSolution U γ σ T y W qr pr) (t : ℝ) (ht : t ∈ Icc 0 T) :
    dist (q t, p t) (qr t, pr t) ≤ dist x y * Real.exp ((1 + (L : ℝ) + ‖γ‖) * t) := by
  have h := textbookLangevinNoiseCompensated_initial_dist_le U hU L hF γ σ T hT x y W q p qr pr hx hy t ht
  have he : textbookLangevinNoiseCompensated σ W q p t -
      textbookLangevinNoiseCompensated σ W qr pr t = (q t, p t) - (qr t, pr t) := by
    apply Prod.ext
    · rfl
    · change p t - σ • W t - (pr t - σ • W t) = p t - pr t
      abel
  simpa only [dist_eq_norm, he] using h

/-- Actual chosen endpoints are Lipschitz in the initial state, uniformly over the entire driving path. -/
theorem textbookLangevinPathEndpoint_initial_lipschitz {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    LipschitzWith ⟨Real.exp ((1 + (L : ℝ) + ‖γ‖) * t), (Real.exp_pos _).le⟩
      (fun x ↦ textbookLangevinPathEndpoint U L hF γ σ T hT x t W) := by
  apply LipschitzWith.of_dist_le_mul
  intro x y
  let a := textbookLangevinPathSolution U L hF γ σ T hT x W
  let b := textbookLangevinPathSolution U L hF γ σ T hT y W
  have h := textbookLangevinIntegralSolution_initial_dist_le U hU L hF γ σ T hT x y
    (textbookLangevinPathNoise T hT W) a.1 a.2 b.1 b.2
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x W)
    (textbookLangevinPathSolution_integralSolution U L hF γ σ T hT y W) t ht
  change dist (a.1 t, a.2 t) (b.1 t, b.2 t) ≤ Real.exp ((1 + (L : ℝ) + ‖γ‖) * t) * dist x y
  exact h.trans_eq (mul_comm _ _)

/-- Actual endpoint selection is jointly continuous in the initial phase and the uniform noise path. -/
theorem textbookLangevinPathEndpoint_joint_continuous {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun z : textbookLangevinPhase Nc × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookLangevinPathEndpoint U L hF γ σ T hT z.1 t z.2) :=
  continuous_prod_of_continuous_lipschitzWith _
    ⟨Real.exp ((1 + (L : ℝ) + ‖γ‖) * t), (Real.exp_pos _).le⟩
    (fun x ↦ textbookLangevinPathEndpoint_continuous U hU L hF γ σ T hT x t ht)
    (fun W ↦ textbookLangevinPathEndpoint_initial_lipschitz U hU L hF γ σ T hT t ht W)

set_option maxHeartbeats 800000 in
/-- Joint initial/noise Borel measurability follows from the actual endpoint dependence proof. -/
theorem textbookLangevinPathEndpoint_joint_measurable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : textbookLangevinPhase Nc × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookLangevinPathEndpoint U L hF γ σ T hT z.1 t z.2) :=
  (textbookLangevinPathEndpoint_joint_continuous U hU L hF γ σ T hT t ht).measurable

/-- A genuinely AE-measurable random initial state gives a measurable actual Wiener-driven endpoint. -/
theorem textbookLangevinRandomInitial_endpoint_aemeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (L : ℝ≥0)
    (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (X : Ω → textbookLangevinPhase Nc) (hX : AEMeasurable X P) (t : ℝ) (ht : t ∈ Icc 0 T) :
    AEMeasurable (fun sample ↦ textbookLangevinPathEndpoint U L hF γ σ T hT (X sample) t
      (textbookWienerVectorContinuousPath B T sample)) P :=
  by
    have hp : AEMeasurable (fun sample ↦ (X sample, textbookWienerVectorContinuousPath B T sample)) P :=
      hX.prodMk (textbookWienerVectorContinuousPath_aemeasurable B P hB T)
    have hm := (textbookLangevinPathEndpoint_joint_measurable U hU L hF γ σ T hT t ht).comp_aemeasurable hp
    exact hm

/-- The actual periodic endpoint is jointly continuous, by descent through the genuine phase quotient. -/
theorem textbookLangevinPeriodicPathEndpoint_joint_continuous {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun z : textbookLangevinPeriodicPhase Nc × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT z.1 t z.2) := by
  have hq : IsOpenQuotientMap (Prod.map
      (textbookLangevinPeriodicProjection : textbookLangevinPhase Nc → textbookLangevinPeriodicPhase Nc)
      (id : C(Icc 0 T, Fin Nc → ℝ) → C(Icc 0 T, Fin Nc → ℝ))) :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap Nc).prodMap IsOpenQuotientMap.id
  apply hq.isQuotientMap.continuous_iff.mpr
  change Continuous (fun z : textbookLangevinPhase Nc × C(Icc 0 T, Fin Nc → ℝ) ↦
    textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT (textbookLangevinPeriodicProjection z.1) t z.2)
  have he : (fun z : textbookLangevinPhase Nc × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT (textbookLangevinPeriodicProjection z.1) t z.2) =
      (fun z ↦ textbookLangevinPeriodicProjection (textbookLangevinPathEndpoint U L hF γ σ T hT z.1 t z.2)) :=
    funext (fun z ↦ textbookLangevinPeriodicPathEndpoint_lift U hU hP L hF γ σ T hT z.1 z.2 t ht)
  rw [he]
  exact (textbookLangevinPeriodicProjection_continuous Nc).comp
    (textbookLangevinPathEndpoint_joint_continuous U (hU.of_le (by simp)) L hF γ σ T hT t ht)

set_option maxHeartbeats 800000 in
/-- Actual periodic joint Borel measurability follows from quotient descent, without measurable representatives. -/
theorem textbookLangevinPeriodicPathEndpoint_joint_measurable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : textbookLangevinPeriodicPhase Nc × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT z.1 t z.2) :=
  (textbookLangevinPeriodicPathEndpoint_joint_continuous U hU hP L hF γ σ T hT t ht).measurable

/-- A genuinely measurable random periodic initial state has a measurable actual endpoint. -/
theorem textbookLangevinPeriodicRandomInitial_endpoint_aemeasurable {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (U : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ T : ℝ) (hT : 0 ≤ T)
    (X : Ω → textbookLangevinPeriodicPhase Nc) (hX : AEMeasurable X P) (t : ℝ) (ht : t ∈ Icc 0 T) :
    AEMeasurable (fun sample ↦ textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT (X sample) t
      (textbookWienerVectorContinuousPath B T sample)) P :=
  by
    have hp : AEMeasurable (fun sample ↦ (X sample, textbookWienerVectorContinuousPath B T sample)) P :=
      hX.prodMk (textbookWienerVectorContinuousPath_aemeasurable B P hB T)
    have hm := (textbookLangevinPeriodicPathEndpoint_joint_measurable U hU hP L hF γ σ T hT t ht).comp_aemeasurable hp
    exact hm
end MolecularDynamics