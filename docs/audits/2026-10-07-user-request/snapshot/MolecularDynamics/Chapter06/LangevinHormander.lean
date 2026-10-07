import MolecularDynamics.Chapter08.HormanderClosure
import MolecularDynamics.Chapter02.SymplecticEuler
import Mathlib.LinearAlgebra.LinearIndependent.Defs
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-! The explicitly proved Langevin Hörmander claim on printed255/PDF276. -/

open scoped BigOperators ContDiff

namespace MolecularDynamics

abbrev textbookLangevinPhase (Nc : ℕ) := (Fin Nc → ℝ) × (Fin Nc → ℝ)

/-- The actual drift in (6.47), using the actual negative potential gradient. -/
noncomputable def textbookLangevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

/-- The original constant noise in the ith momentum direction. -/
def textbookLangevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)

def textbookLangevinSeed {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (γ σ : ℝ) :
    Set (textbookLangevinPhase Nc → textbookLangevinPhase Nc) :=
  {textbookLangevinDrift U γ} ∪ Set.range (textbookLangevinNoise Nc σ)

/-- The actual coordinate negative gradient of a smooth potential is smooth. -/
theorem textbookLangevinForce_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) :
    ContDiff ℝ ∞ (textbookPotentialForce U) := by
  apply contDiff_pi.mpr
  intro i
  exact ((hU.fderiv_right (m := ∞) (by simp)).clm_apply
    (contDiff_const (c := Pi.single i 1))).neg

theorem textbookLangevinSeed_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ : ℝ) :
    ∀ V ∈ textbookLangevinSeed U γ σ, ContDiff ℝ ∞ V := by
  intro V hV
  change V = textbookLangevinDrift U γ ∨ ∃ i, textbookLangevinNoise Nc σ i = V at hV
  rcases hV with rfl | hV
  ·
    have hγ : ContDiff ℝ ∞ (fun z : textbookLangevinPhase Nc ↦ γ • z.2) := by
      simpa only [Pi.smul_def'] using (contDiff_snd.const_smul γ :
        ContDiff ℝ ∞ (γ • (Prod.snd : textbookLangevinPhase Nc → (Fin Nc → ℝ))))
    exact contDiff_snd.prodMk
      (((textbookLangevinForce_contDiff U hU).comp contDiff_fst).sub hγ)
  · rcases hV with ⟨i, rfl⟩
    exact contDiff_const

/-- The literal b0-bi bracket is computed from actual Frechet derivatives. -/
theorem textbookLangevinDrift_noise_bracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) := by
  have hf := (((contDiff_textbookPotentialForce U hU).differentiable_one z.1).hasFDerivAt.comp
    z hasFDerivAt_fst)
  have hp := hasFDerivAt_snd (𝕜 := ℝ) (p := z)
  have hd := hp.prodMk (hf.sub (hp.const_smul γ))
  simp only [Function.comp_apply, Pi.sub_apply, Pi.smul_apply] at hd
  have hn := hasFDerivAt_const (𝕜 := ℝ) ((0 : Fin Nc → ℝ), σ • Pi.single i 1) z
  change fderiv ℝ (fun _ : textbookLangevinPhase Nc ↦ (0, σ • Pi.single i 1)) z
      (textbookLangevinDrift U γ z) -
    fderiv ℝ (fun w : textbookLangevinPhase Nc ↦
      (w.2, textbookPotentialForce U w.1 - γ • w.2)) z (0, σ • Pi.single i 1) = _
  rw [hn.fderiv, hd.fderiv]
  simp [ContinuousLinearMap.prod_apply, ContinuousLinearMap.comp_apply,
    neg_smul, smul_smul, mul_comm]

/-- The actual 2Nc family of noise values and first brackets. -/
def textbookLangevinBracketFamily (Nc : ℕ) (γ σ : ℝ) :
    Fin Nc ⊕ Fin Nc → textbookLangevinPhase Nc :=
  Sum.elim (fun i ↦ (0, σ • Pi.single i 1))
    (fun i ↦ (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1))

/-- The literal noise/bracket family is linearly independent without any Hessian restriction. -/
theorem textbookLangevinBracketFamily_linearIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ) := by
  classical
  rw [Fintype.linearIndependent_iff]
  intro c hc
  have hr (i : Fin Nc) : c (Sum.inr i) = 0 := by
    have h : c (Sum.inr i) * (-σ) = 0 := by
      have he := congrArg (((LinearMap.proj i).comp
        (LinearMap.fst ℝ (Fin Nc → ℝ) (Fin Nc → ℝ))) : textbookLangevinPhase Nc → ℝ) hc
      simp only [map_sum, map_smul, map_zero] at he
      simpa [Fintype.sum_sum_type, textbookLangevinBracketFamily,
        LinearMap.comp_apply, LinearMap.fst_apply, LinearMap.proj_apply, Pi.single_apply,
        smul_eq_mul, mul_comm] using he
    exact (mul_eq_zero.mp h).resolve_right (neg_ne_zero.mpr hσ)
  have hl (i : Fin Nc) : c (Sum.inl i) = 0 := by
    have h : c (Sum.inl i) * σ = 0 := by
      have he := congrArg (((LinearMap.proj i).comp
        (LinearMap.snd ℝ (Fin Nc → ℝ) (Fin Nc → ℝ))) : textbookLangevinPhase Nc → ℝ) hc
      simp only [map_sum, map_smul, map_zero] at he
      simpa [Fintype.sum_sum_type, textbookLangevinBracketFamily,
        LinearMap.comp_apply, LinearMap.snd_apply, LinearMap.proj_apply, Pi.single_apply,
        smul_eq_mul, hr] using he
    exact (mul_eq_zero.mp h).resolve_right hσ
  intro i
  cases i with
  | inl i => exact hl i
  | inr i => exact hr i

/-- The original Langevin fields and actual brackets span every phase vector. -/
theorem textbookLangevin_hormander {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ) (hσ : σ ≠ 0)
    (z : textbookLangevinPhase Nc) : textbookHormanderAt (textbookLangevinSeed U γ σ) z := by
  classical
  let seed := textbookLangevinSeed U γ σ
  let H := textbookBracketPointSpan seed z
  have hb0 : textbookIteratedBracket seed (textbookLangevinDrift U γ) :=
    textbookIteratedBracket.seed (by simp [seed, textbookLangevinSeed])
  have hb (i : Fin Nc) : textbookIteratedBracket seed (textbookLangevinNoise Nc σ i) :=
    textbookIteratedBracket.seed (by simp [seed, textbookLangevinSeed])
  have hn (i : Fin Nc) : (0, σ • Pi.single i 1) ∈ H :=
    Submodule.subset_span ⟨⟨textbookLangevinNoise Nc σ i, hb i⟩, rfl⟩
  have hbr (i : Fin Nc) : (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) ∈ H := by
    rw [← textbookLangevinDrift_noise_bracket U hU γ σ i z]
    exact Submodule.subset_span ⟨⟨_, textbookIteratedBracket.bracket hb0 (hb i)⟩, rfl⟩
  have hv (i : Fin Nc) : ((0 : Fin Nc → ℝ), Pi.single i 1) ∈ H := by
    simpa [smul_smul, hσ] using H.smul_mem σ⁻¹ (hn i)
  have hq (i : Fin Nc) : (Pi.single i 1, (0 : Fin Nc → ℝ)) ∈ H := by
    have hm := H.smul_mem (-σ⁻¹) (H.sub_mem (hbr i) (H.smul_mem γ (hn i)))
    have he : (-σ⁻¹) • ((-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) -
        γ • ((0 : Fin Nc → ℝ), σ • Pi.single i 1)) = (Pi.single i 1, (0 : Fin Nc → ℝ)) := by
      apply Prod.ext
      · simp [smul_smul, hσ]
      · simp [smul_smul, mul_comm]
    rw [he] at hm
    exact hm
  change H = ⊤
  apply top_unique
  intro w _
  have he : (∑ i : Fin Nc, w.1 i • (Pi.single i 1, (0 : Fin Nc → ℝ))) +
      (∑ i : Fin Nc, w.2 i • ((0 : Fin Nc → ℝ), Pi.single i 1)) = w := by
    apply Prod.ext
    · change (LinearMap.fst ℝ (Fin Nc → ℝ) (Fin Nc → ℝ))
        ((∑ i : Fin Nc, w.1 i • (Pi.single i 1, (0 : Fin Nc → ℝ))) +
          (∑ i : Fin Nc, w.2 i • ((0 : Fin Nc → ℝ), Pi.single i 1))) = w.1
      rw [map_add, map_sum, map_sum]
      simp only [map_smul, LinearMap.fst_apply, smul_zero]
      change (∑ i : Fin Nc, w.1 i • Pi.single i 1) + (∑ _ : Fin Nc, (0 : Fin Nc → ℝ)) = w.1
      simp only [Finset.sum_const_zero, add_zero]
      ext j
      simp [Finset.sum_apply, Pi.single_apply]
    · change (LinearMap.snd ℝ (Fin Nc → ℝ) (Fin Nc → ℝ))
        ((∑ i : Fin Nc, w.1 i • (Pi.single i 1, (0 : Fin Nc → ℝ))) +
          (∑ i : Fin Nc, w.2 i • ((0 : Fin Nc → ℝ), Pi.single i 1))) = w.2
      rw [map_add, map_sum, map_sum]
      simp only [map_smul, LinearMap.snd_apply, smul_zero]
      change (∑ _ : Fin Nc, (0 : Fin Nc → ℝ)) + (∑ i : Fin Nc, w.2 i • Pi.single i 1) = w.2
      simp only [Finset.sum_const_zero, zero_add]
      ext j
      simp [Finset.sum_apply, Pi.single_apply]
  rw [← he]
  exact H.add_mem (H.sum_mem (fun i _ ↦ H.smul_mem (w.1 i) (hq i)))
    (H.sum_mem (fun i _ ↦ H.smul_mem (w.2 i) (hv i)))

/-- The original physical noise is nonzero at positive temperature and friction. -/
theorem textbookLangevin_hormander_physicalNoise {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z := by
  apply textbookLangevin_hormander U (hU.of_le (by simp)) γ _ _ z
  exact ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) hθ))

end MolecularDynamics
