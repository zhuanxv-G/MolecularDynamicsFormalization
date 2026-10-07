import MolecularDynamics.Chapter06.LangevinSmoothCutoff
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Analysis.Calculus.MeanValue

/-! Necessary actual global force estimates for a smooth unit-periodic Langevin potential. -/

open Set Filter
open scoped Topology ContDiff NNReal

namespace MolecularDynamics

/-- The genuine integer-lattice invariance of the lifted unit-torus potential. -/
def textbookUnitPeriodicPotential {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) : Prop :=
  ∀ q (n : Fin Nc → ℤ), U (q + fun i ↦ (n i : ℝ)) = U q

private theorem periodic_fderiv {Nc : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : (Fin Nc → ℝ) → E) (hf : Differentiable ℝ f)
    (hp : ∀ q (n : Fin Nc → ℤ), f (q + fun i ↦ (n i : ℝ)) = f q)
    (q : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    fderiv ℝ f (q + fun i ↦ (n i : ℝ)) = fderiv ℝ f q := by
  let c : Fin Nc → ℝ := fun i ↦ (n i : ℝ)
  have he : (fun z ↦ f (z + c)) = f := funext (fun z ↦ hp z n)
  have hd := (hf (q + c)).hasFDerivAt.comp q ((hasFDerivAt_id q).add_const c)
  have hh : HasFDerivAt f (fderiv ℝ f (q + c)) q := by
    simpa only [Function.comp_def, id_eq, ContinuousLinearMap.comp_id, he] using hd
  exact hh.fderiv.symm

private theorem periodic_bound {Nc : ℕ} {E : Type*} [NormedAddCommGroup E]
    (f : (Fin Nc → ℝ) → E) (hf : Continuous f)
    (hp : ∀ q (n : Fin Nc → ℤ), f (q + fun i ↦ (n i : ℝ)) = f q) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖f q‖ ≤ M := by
  obtain ⟨M, hM⟩ := isCompact_Icc.exists_bound_of_continuousOn
    (hf.continuousOn : ContinuousOn f (Icc (0 : Fin Nc → ℝ) 1))
  have h0 : (0 : Fin Nc → ℝ) ∈ Icc 0 1 := ⟨le_rfl, fun _ ↦ zero_le_one⟩
  refine ⟨M, (norm_nonneg (f 0)).trans (hM 0 h0), ?_⟩
  intro q
  let a : Fin Nc → ℝ := fun i ↦ Int.fract (q i)
  let n : Fin Nc → ℤ := fun i ↦ Int.floor (q i)
  have ha : a ∈ Icc (0 : Fin Nc → ℝ) 1 :=
    ⟨fun i ↦ Int.fract_nonneg (q i), fun i ↦ (Int.fract_lt_one (q i)).le⟩
  have he : a + (fun i ↦ (n i : ℝ)) = q := funext (fun i ↦ Int.fract_add_floor (q i))
  have hh := hp a n
  rw [he] at hh
  rw [hh]
  exact hM a ha

/-- The genuine compact fundamental cube gives an actual global bound for the periodic potential. -/
theorem textbookUnitPeriodicPotential_bound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Continuous U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖U q‖ ≤ M :=
  periodic_bound U hU hP

/-- Actual Frechet differentiation preserves the true lattice invariance of a smooth potential. -/
theorem textbookUnitPeriodicPotential_fderiv {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (q : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    fderiv ℝ U (q + fun i ↦ (n i : ℝ)) = fderiv ℝ U q :=
  periodic_fderiv U (hU.differentiable (by simp)) hP q n

/-- The actual negative coordinate gradient of the lifted potential is lattice-periodic. -/
theorem textbookUnitPeriodicPotential_force {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (q : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    textbookPotentialForce U (q + fun i ↦ (n i : ℝ)) = textbookPotentialForce U q := by
  ext i
  simp only [textbookPotentialForce]
  rw [textbookUnitPeriodicPotential_fderiv U hU hP q n]

/-- Actual second differentiation preserves the true lattice invariance of the force derivative. -/
theorem textbookUnitPeriodicPotential_force_fderiv {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (q : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    fderiv ℝ (textbookPotentialForce U) (q + fun i ↦ (n i : ℝ)) =
      fderiv ℝ (textbookPotentialForce U) q :=
  periodic_fderiv _ ((textbookLangevinForce_contDiff U hU).differentiable (by simp))
    (textbookUnitPeriodicPotential_force U hU hP) q n

/-- Every actual periodic smooth force is globally bounded by its true compact fundamental cube. -/
theorem textbookUnitPeriodicPotential_force_bound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖textbookPotentialForce U q‖ ≤ M :=
  periodic_bound _ (textbookLangevinForce_contDiff U hU).continuous
    (textbookUnitPeriodicPotential_force U hU hP)

/-- The actual periodic smooth force derivative has a genuine global operator norm bound. -/
theorem textbookUnitPeriodicPotential_force_derivative_bound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ q, ‖fderiv ℝ (textbookPotentialForce U) q‖ ≤ M :=
  periodic_bound _ ((textbookLangevinForce_contDiff U hU).continuous_fderiv (by simp))
    (textbookUnitPeriodicPotential_force_fderiv U hU hP)

/-- Genuine periodicity and smoothness imply global force Lipschitz continuity, rather than supplying it as a premise. -/
theorem textbookUnitPeriodicPotential_force_lipschitz {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) :
    ∃ L : ℝ≥0, LipschitzWith L (textbookPotentialForce U) := by
  obtain ⟨M, hM, hb⟩ := textbookUnitPeriodicPotential_force_derivative_bound U hU hP
  refine ⟨⟨M, hM⟩, ?_⟩
  apply lipschitzWith_of_nnnorm_fderiv_le ((textbookLangevinForce_contDiff U hU).differentiable (by simp))
  intro q
  exact NNReal.coe_le_coe.mp (hb q)

end MolecularDynamics
