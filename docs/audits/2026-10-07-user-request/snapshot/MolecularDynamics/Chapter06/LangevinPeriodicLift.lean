import MolecularDynamics.Chapter06.LangevinPeriodicProjection
import MolecularDynamics.Chapter06.LangevinPeriodicForce
import Mathlib.MeasureTheory.Group.AddCircle

/-! Actual lifted periodic force and actual integral-solution lift for Lemma6.1. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics

/-- Genuine real representatives of a unit-torus position. -/
noncomputable def textbookLangevinPeriodicRepresentative {Nc : ℕ}
    (Q : UnitAddTorus (Fin Nc)) : Fin Nc → ℝ := fun i ↦ Quotient.out (Q i)

/-- The genuine representatives project to the given position. -/
theorem textbookLangevinPeriodicRepresentative_projects {Nc : ℕ} (Q : UnitAddTorus (Fin Nc)) :
    (fun i ↦ (textbookLangevinPeriodicRepresentative Q i : UnitAddCircle)) = Q := by
  ext i
  exact Quotient.out_eq' (Q i)

/-- The actual force on the periodic position space, defined from the lifted potential. -/
noncomputable def textbookLangevinPeriodicForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (Q : UnitAddTorus (Fin Nc)) : Fin Nc → ℝ :=
  textbookPotentialForce U (textbookLangevinPeriodicRepresentative Q)

/-- True potential periodicity makes the force independent of representatives and equal to every real lift. -/
theorem textbookLangevinPeriodicForce_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (q : Fin Nc → ℝ) :
    textbookLangevinPeriodicForce U (fun i ↦ (q i : UnitAddCircle)) = textbookPotentialForce U q := by
  let Q : UnitAddTorus (Fin Nc) := fun i ↦ (q i : UnitAddCircle)
  let r := textbookLangevinPeriodicRepresentative Q
  have h (i : Fin Nc) : ∃ n : ℤ, (n : ℝ) = r i - q i := by
    have hz : ((r i - q i : ℝ) : UnitAddCircle) = 0 := by
      rw [AddCircle.coe_sub]
      have he := congrFun (textbookLangevinPeriodicRepresentative_projects Q) i
      change (r i : UnitAddCircle) = (q i : UnitAddCircle) at he
      rw [he, sub_self]
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp hz
    exact ⟨n, by simpa only [zsmul_eq_mul, mul_one] using hn⟩
  choose n hn using h
  have he : q + (fun i ↦ (n i : ℝ)) = r := by
    ext i
    change q i + (n i : ℝ) = r i
    rw [hn i]
    ring
  have hf := textbookUnitPeriodicPotential_force U hU hP q n
  rw [he] at hf
  exact hf

/-- The actual periodic Langevin integral equations, with no assumed real path lift. -/
def textbookLangevinPeriodicIntegralSolution {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ)
    (γ σ T : ℝ) (x : textbookLangevinPeriodicPhase Nc) (W : ℝ → (Fin Nc → ℝ))
    (q : ℝ → UnitAddTorus (Fin Nc)) (p : ℝ → (Fin Nc → ℝ)) : Prop :=
  ContinuousOn p (Icc 0 T) ∧ ContinuousOn W (Icc 0 T) ∧ W 0 = 0 ∧
    (∀ t ∈ Icc 0 T, q t = x.1 + fun i ↦ ((∫ s in 0..t, p s) i : UnitAddCircle)) ∧
    (∀ t ∈ Icc 0 T, p t = x.2 +
      (∫ s in 0..t, textbookLangevinPeriodicForce U (q s) - γ • p s) + σ • W t)

/-- The real position lift is actually constructed from the momentum integral and the initial representative. -/
noncomputable def textbookLangevinPeriodicPositionLift {Nc : ℕ}
    (x : textbookLangevinPeriodicPhase Nc) (p : ℝ → (Fin Nc → ℝ)) (t : ℝ) : Fin Nc → ℝ :=
  textbookLangevinPeriodicRepresentative x.1 + ∫ s in 0..t, p s

/-- The actually constructed integral lift projects to the given periodic position at every specified time. -/
theorem textbookLangevinPeriodicPositionLift_projects {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ T : ℝ) (x : textbookLangevinPeriodicPhase Nc)
    (W : ℝ → (Fin Nc → ℝ)) (q : ℝ → UnitAddTorus (Fin Nc)) (p : ℝ → (Fin Nc → ℝ))
    (hSol : textbookLangevinPeriodicIntegralSolution U γ σ T x W q p) (t : ℝ) (ht : t ∈ Icc 0 T) :
    (fun i ↦ (textbookLangevinPeriodicPositionLift x p t i : UnitAddCircle)) = q t := by
  rw [hSol.2.2.2.1 t ht]
  ext i
  change ((textbookLangevinPeriodicRepresentative x.1 i + (∫ s in 0..t, p s) i : ℝ) : UnitAddCircle) = _
  rw [AddCircle.coe_add]
  exact congrArg (fun z : UnitAddCircle ↦ z + ((∫ s in 0..t, p s) i : UnitAddCircle))
    (congrFun (textbookLangevinPeriodicRepresentative_projects x.1) i)

/-- The actual periodic integral solution has a genuine real Langevin integral lift, proved from its equations. -/
theorem textbookLangevinPeriodicIntegralSolution_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase Nc)
    (W : ℝ → (Fin Nc → ℝ)) (q : ℝ → UnitAddTorus (Fin Nc)) (p : ℝ → (Fin Nc → ℝ))
    (hSol : textbookLangevinPeriodicIntegralSolution U γ σ T x W q p) :
    textbookLangevinIntegralSolution U γ σ T (textbookLangevinPeriodicRepresentative x.1, x.2)
      W (textbookLangevinPeriodicPositionLift x p) p := by
  have hpint : IntegrableOn p (uIcc 0 T) volume := by
    apply ContinuousOn.integrableOn_compact isCompact_uIcc
    simpa only [uIcc_of_le hT] using hSol.1
  have hqc : ContinuousOn (textbookLangevinPeriodicPositionLift x p) (Icc 0 T) := by
    unfold textbookLangevinPeriodicPositionLift
    apply continuousOn_const.add
    simpa only [uIcc_of_le hT] using intervalIntegral.continuousOn_primitive_interval hpint
  refine ⟨hqc, hSol.1, hSol.2.1, hSol.2.2.1, fun _ _ ↦ rfl, ?_⟩
  intro t ht
  have he : (∫ s in 0..t, textbookPotentialForce U (textbookLangevinPeriodicPositionLift x p s) - γ • p s) =
      (∫ s in 0..t, textbookLangevinPeriodicForce U (q s) - γ • p s) := by
    apply intervalIntegral.integral_congr
    intro s hs
    have hsT : s ∈ Icc 0 T := by
      rw [uIcc_of_le ht.1] at hs
      exact ⟨hs.1, hs.2.trans ht.2⟩
    change textbookPotentialForce U (textbookLangevinPeriodicPositionLift x p s) - γ • p s =
      textbookLangevinPeriodicForce U (q s) - γ • p s
    rw [← textbookLangevinPeriodicForce_lift U hU hP,
      textbookLangevinPeriodicPositionLift_projects U γ σ T x W q p hSol s hsT]
  rw [he]
  exact hSol.2.2.2.2 t ht

/-- Actual periodic integral solutions hit every nonempty open periodic phase target with positive probability; the real lift is constructed, not assumed. -/
theorem textbookLangevinPeriodicEndpoint_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ T : ℝ) (hσ : σ ≠ 0) (hT : 0 < T) (x : textbookLangevinPeriodicPhase Nc)
    (q : ℝ → Ω → UnitAddTorus (Fin Nc)) (p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinPeriodicIntegralSolution U γ σ T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (C : Set (textbookLangevinPeriodicPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
      0 < P {sample | (q T sample, p T sample) ∈ C} := by
  refine ⟨hEnd.nullMeasurableSet_preimage hC.measurableSet, ?_⟩
  obtain ⟨hD, hDN⟩ := textbookLangevinPeriodicProjection_open_preimage C hC hCN
  obtain ⟨y, hy⟩ := hDN
  obtain ⟨δ, hδ, hball⟩ := Metric.mem_nhds_iff.mp (hD.mem_nhds hy)
  let xr : textbookLangevinPhase Nc := (textbookLangevinPeriodicRepresentative x.1, x.2)
  obtain ⟨ε, hε, hs⟩ := textbookLangevinControlledEndpoint_stable U hU γ σ T δ hσ hT hδ xr y
  let R := textbookLangevinControlPath U γ σ T xr y
  have hr : Continuous R := (textbookLangevinControlPath_contDiff U hU γ σ T xr y).continuous
  have hz : R 0 = 0 := by simp [R, textbookLangevinControlPath]
  have hp := textbookWienerVectorRealControlTube_pos B P hB T hT R hr hz ε hε
  apply lt_of_lt_of_le hp
  apply measure_mono_ae
  filter_upwards [hSol] with sample hsample
  intro htube
  let pr := fun t ↦ p t sample
  let qr := textbookLangevinPeriodicPositionLift x pr
  have hlift := textbookLangevinPeriodicIntegralSolution_lift U hU hP γ σ T hT.le x
    (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) pr hsample
  have hend := hs (fun t ↦ B t.toNNReal sample) qr pr hlift htube
  have hc := hball hend
  change textbookLangevinPeriodicProjection (qr T, pr T) ∈ C at hc
  have he : textbookLangevinPeriodicProjection (qr T, pr T) = (q T sample, p T sample) := by
    apply Prod.ext
    · exact textbookLangevinPeriodicPositionLift_projects U γ σ T x
        (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) pr hsample T ⟨hT.le, le_rfl⟩
    · rfl
  rw [he] at hc
  exact hc


/-- The actual periodic integral solution with the original physical noise hits every nonempty open target. -/
theorem textbookLangevinPeriodicEndpoint_physicalNoise_open_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ β T : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (hT : 0 < T) (x : textbookLangevinPeriodicPhase Nc)
    (q : ℝ → Ω → UnitAddTorus (Fin Nc)) (p : ℝ → Ω → (Fin Nc → ℝ))
    (hSol : ∀ᵐ sample ∂P, textbookLangevinPeriodicIntegralSolution U γ (Real.sqrt (2 * γ * β⁻¹)) T x
      (fun t ↦ B t.toNNReal sample) (fun t ↦ q t sample) (fun t ↦ p t sample))
    (hEnd : AEMeasurable (fun sample ↦ (q T sample, p T sample)) P)
    (C : Set (textbookLangevinPeriodicPhase Nc)) (hC : IsOpen C) (hCN : C.Nonempty) :
    NullMeasurableSet {sample | (q T sample, p T sample) ∈ C} P ∧
      0 < P {sample | (q T sample, p T sample) ∈ C} := by
  apply textbookLangevinPeriodicEndpoint_open_pos B P hB U hU hP γ _ T _ hT x q p hSol hEnd C hC hCN
  exact ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))

end MolecularDynamics
