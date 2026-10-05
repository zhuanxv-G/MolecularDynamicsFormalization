import MolecularDynamics.Chapter08.ThermostatSpan
import Mathlib.Analysis.ODE.ExistUnique
import Mathlib.Analysis.Normed.Group.Bounded

/-! Printed346/PDF367: zero eigenmode submanifolds are invariant along actual NHL paths.
Only the actual q/p equations and continuity of the auxiliary path are needed.
-/

open Matrix Set
open scoped NNReal

namespace MolecularDynamics

private noncomputable def thermostatModeOperator (ν ξ : ℝ) : (ℝ × ℝ) →L[ℝ] (ℝ × ℝ) :=
  (ContinuousLinearMap.snd ℝ ℝ ℝ).prod
    ((-ν) • ContinuousLinearMap.fst ℝ ℝ ℝ - ξ • ContinuousLinearMap.snd ℝ ℝ ℝ)

private theorem thermostatModeOperator_continuous (ν : ℝ) :
    Continuous (thermostatModeOperator ν) := by
  let Z : (ℝ × ℝ) →L[ℝ] (ℝ × ℝ) :=
    (0 : (ℝ × ℝ) →L[ℝ] ℝ).prod (ContinuousLinearMap.snd ℝ ℝ ℝ)
  have he : thermostatModeOperator ν = fun ξ ↦ thermostatModeOperator ν 0 - ξ • Z := by
    funext ξ
    apply ContinuousLinearMap.ext
    intro v
    apply Prod.ext
    · change v.2 = v.2 - ξ * 0
      ring
    · change (-ν) * v.1 - ξ * v.2 = ((-ν) * v.1 - 0 * v.2) - ξ * v.2
      ring
  rw [he]
  exact continuous_const.sub (continuous_id.smul continuous_const)

private theorem thermostatMode_zero_on_Icc (ν : ℝ) (ξ : ℝ → ℝ) {a b : ℝ}
    (hξ : ContinuousOn ξ (Icc a b)) (m : ℝ → ℝ × ℝ)
    (hm : ContinuousOn m (Icc a b))
    (hODE : ∀ t ∈ Ico a b, HasDerivWithinAt m (thermostatModeOperator ν (ξ t) (m t)) (Ici t) t)
    (ha : m a = 0) : EqOn m 0 (Icc a b) := by
  have hop : ContinuousOn (fun t ↦ thermostatModeOperator ν (ξ t)) (Icc a b) :=
    (thermostatModeOperator_continuous ν).comp_continuousOn hξ
  have hc := isCompact_Icc.image_of_continuousOn hop
  obtain ⟨R, hR⟩ := hc.isBounded.subset_closedBall (0 : (ℝ × ℝ) →L[ℝ] (ℝ × ℝ))
  let K : ℝ≥0 := ⟨max R 0, le_max_right _ _⟩
  have hK (t : ℝ) (ht : t ∈ Ico a b) :
      LipschitzOnWith K (thermostatModeOperator ν (ξ t)) Set.univ := by
    have hr : ‖thermostatModeOperator ν (ξ t)‖ ≤ R := by
      simpa only [Metric.mem_closedBall, dist_zero_right] using hR ⟨t, ⟨ht.1, ht.2.le⟩, rfl⟩
    apply LipschitzOnWith.of_dist_le_mul
    intro x _ y _
    rw [dist_eq_norm, ← map_sub]
    exact ((thermostatModeOperator ν (ξ t)).le_opNorm (x - y)).trans
      (mul_le_mul_of_nonneg_right (hr.trans (le_max_left _ _)) (norm_nonneg _))
  exact ODE_solution_unique_of_mem_Icc_right (v := fun t ↦ thermostatModeOperator ν (ξ t))
    (s := fun _ ↦ Set.univ) (K := K) hK hm hODE (fun _ _ ↦ Set.mem_univ _)
    continuousOn_const (fun t _ ↦ by
      change HasDerivWithinAt (fun _ : ℝ ↦ (0 : ℝ × ℝ))
        (thermostatModeOperator ν (ξ t) 0) (Ici t) t
      rw [map_zero]
      exact (hasDerivAt_const t (0 : ℝ × ℝ)).hasDerivWithinAt)
    (fun _ _ ↦ Set.mem_univ _) ha

/-- The actual zero-eigenmode submanifold V_i in the textbook. -/
def textbookNHLZeroMode {Nc : ℕ} {A : Matrix (Fin Nc) (Fin Nc) ℝ}
    (hA : A.IsHermitian) (i : Fin Nc) : Set (textbookThermostatPhase Nc) :=
  {z | textbookThermostatEigenCoordinates hA z.1 i = 0 ∧
    textbookThermostatEigenCoordinates hA z.2 i = 0}

theorem textbookThermostatModeDomain_eq_compl_zeroModes {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian) :
    textbookThermostatModeDomain hA = (⋃ i, textbookNHLZeroMode hA i)ᶜ := by
  ext z
  simp only [textbookThermostatModeDomain, textbookNHLZeroMode, Set.mem_ofPred_eq,
    Set.mem_compl_iff, Set.mem_iUnion, not_exists, not_and_or]

/-- Full-time invariance on any compact interval, proved by actual mode ODE uniqueness. -/
theorem textbookNHL_zeroMode_invariant {Nc : ℕ} {A : Matrix (Fin Nc) (Fin Nc) ℝ}
    (hA : A.IsHermitian) (i : Fin Nc) {a b : ℝ}
    (q p : ℝ → Fin Nc → ℝ) (ξ : ℝ → ℝ)
    (hcq : ContinuousOn q (Icc a b)) (hcp : ContinuousOn p (Icc a b))
    (hξ : ContinuousOn ξ (Icc a b))
    (hq : ∀ t ∈ Ico a b, HasDerivWithinAt q (p t) (Ici t) t)
    (hp : ∀ t ∈ Ico a b, HasDerivWithinAt p (-(A *ᵥ q t) - ξ t • p t) (Ici t) t)
    (hzero : (q a, p a) ∈ textbookNHLZeroMode hA i) :
    ∀ t ∈ Icc a b, (q t, p t) ∈ textbookNHLZeroMode hA i := by
  let L : (Fin Nc → ℝ) →L[ℝ] ℝ :=
    (ContinuousLinearMap.proj i).comp
      (LinearMap.toContinuousLinearMap (textbookThermostatEigenCoordinates hA))
  let m : ℝ → ℝ × ℝ := fun t ↦ (L (q t), L (p t))
  have hm : ContinuousOn m (Icc a b) :=
    (L.continuous.comp_continuousOn hcq).prodMk (L.continuous.comp_continuousOn hcp)
  have hODE (t : ℝ) (ht : t ∈ Ico a b) :
      HasDerivWithinAt m (thermostatModeOperator (hA.eigenvalues i) (ξ t) (m t)) (Ici t) t := by
    have hQ := L.hasFDerivAt.comp_hasDerivWithinAt t (hq t ht)
    have hP := L.hasFDerivAt.comp_hasDerivWithinAt t (hp t ht)
    have hmap : L (-(A *ᵥ q t) - ξ t • p t) =
        (-hA.eigenvalues i) * L (q t) - ξ t * L (p t) := by
      rw [map_sub, map_neg, map_smul]
      change -(textbookThermostatEigenCoordinates hA (A *ᵥ q t) i) -
        ξ t * textbookThermostatEigenCoordinates hA (p t) i = _
      rw [textbookThermostatEigenCoordinates_intertwine]
      change -(hA.eigenvalues i * textbookThermostatEigenCoordinates hA (q t) i) -
        ξ t * textbookThermostatEigenCoordinates hA (p t) i =
        (-hA.eigenvalues i) * textbookThermostatEigenCoordinates hA (q t) i -
          ξ t * textbookThermostatEigenCoordinates hA (p t) i
      ring
    rw [hmap] at hP
    change HasDerivWithinAt m
      (L (p t), (-hA.eigenvalues i) * L (q t) - ξ t * L (p t)) (Ici t) t
    simpa only [m, Function.comp_apply] using hQ.prodMk hP
  have ha : m a = 0 := Prod.ext hzero.1 hzero.2
  have heq := thermostatMode_zero_on_Icc (hA.eigenvalues i) ξ hξ m hm hODE ha
  intro t ht
  have he := heq ht
  exact ⟨congrArg Prod.fst he, congrArg Prod.snd he⟩

end MolecularDynamics
