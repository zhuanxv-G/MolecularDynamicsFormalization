import MolecularDynamics.Chapter06.BrownianGibbsComplexResolvent

/-! Actual bounded two-sided resolvent sets of the original unbounded Gibbs generator. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- The genuine complex resolvent set of the whole original closed generator, defined by actual bounded graph inverses. -/
def textbookBrownianGibbsGeneratorComplexResolventSet : Set ℂ :=
  {ℓ | ∃ R : Gibbs U β →L[ℂ] Gibbs U β,
    (∀ x, (R x, ℓ • R x - x) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph) ∧
    (∀ x y, (x, y) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph →
      R (ℓ • x - y) = x)}

include hm hβ in
/-- The actual compact resolvent already constructed is a genuine whole-generator inverse at one. -/
theorem textbookBrownianGibbsGeneratorComplexResolventSet_one :
    (1 : ℂ) ∈ textbookBrownianGibbsGeneratorComplexResolventSet m hm U hU hPU β hβ := by
  refine ⟨textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ, ?_, ?_⟩
  · intro x
    simpa only [one_smul] using textbookBrownianGibbsComplexResolvent_mem_graph m hm U hU hPU β hβ x
  · intro x y hxy
    simpa only [one_smul] using textbookBrownianGibbsComplexResolvent_inverse_graph m hm U hU hPU β hβ x y hxy

include hm hβ in
/-- Exact equivalence between a bounded two-sided graph inverse of the whole generator and the actual bounded resolvent bridge. -/
theorem textbookBrownianGibbsGeneratorComplexResolventSet_iff_isUnit (ℓ : ℂ) :
    ℓ ∈ textbookBrownianGibbsGeneratorComplexResolventSet m hm U hU hPU β hβ ↔
      IsUnit ((1 : Gibbs U β →L[ℂ] Gibbs U β) +
        (ℓ - 1) • textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  let R := textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ
  constructor
  · rintro ⟨B, hBgraph, hBinv⟩
    have hRB (x : Gibbs U β) : R x - (ℓ - 1) • R (B x) = B x := by
      have h := textbookBrownianGibbsComplexResolvent_inverse_graph m hm U hU hPU β hβ
        (B x) (ℓ • B x - x) (hBgraph x)
      change R (B x - (ℓ • B x - x)) = B x at h
      rw [map_sub, map_sub, map_smul] at h
      calc
        R x - (ℓ - 1) • R (B x) = R (B x) - (ℓ • R (B x) - R x) := by module
        _ = B x := h
    have hBR (x : Gibbs U β) : B x + (ℓ - 1) • B (R x) = R x := by
      have h := hBinv (R x) (R x - x)
        (textbookBrownianGibbsComplexResolvent_mem_graph m hm U hU hPU β hβ x)
      have he : ℓ • R x - (R x - x) = x + (ℓ - 1) • R x := by module
      rw [he, map_add, map_smul] at h
      exact h
    let K : Gibbs U β →L[ℂ] Gibbs U β := 1 - (ℓ - 1) • B
    apply isUnit_iff_exists.mpr
    refine ⟨K, ?_, ?_⟩
    · apply ContinuousLinearMap.ext
      intro x
      change (x - (ℓ - 1) • B x) + (ℓ - 1) • R (x - (ℓ - 1) • B x) = x
      rw [map_sub, map_smul, hRB]
      module
    · apply ContinuousLinearMap.ext
      intro x
      change (x + (ℓ - 1) • R x) - (ℓ - 1) • B (x + (ℓ - 1) • R x) = x
      rw [map_add, map_smul, hBR]
      module
  · intro hF
    let K : Gibbs U β →L[ℂ] Gibbs U β := ↑hF.unit⁻¹
    have hFK (x : Gibbs U β) : K x + (ℓ - 1) • R (K x) = x := by
      have h := congrArg (fun L : Gibbs U β →L[ℂ] Gibbs U β ↦ L x) hF.mul_val_inv
      change K x + (ℓ - 1) • R (K x) = x at h
      exact h
    have hKF (x : Gibbs U β) : K (x + (ℓ - 1) • R x) = x := by
      have h := congrArg (fun L : Gibbs U β →L[ℂ] Gibbs U β ↦ L x) hF.val_inv_mul
      change K (x + (ℓ - 1) • R x) = x at h
      exact h
    refine ⟨R.comp K, ?_, ?_⟩
    · intro x
      change (R (K x), ℓ • R (K x) - x) ∈
        (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph
      have he : ℓ • R (K x) - x = R (K x) - K x := by
        calc
          ℓ • R (K x) - x = ℓ • R (K x) - (K x + (ℓ - 1) • R (K x)) :=
            congrArg (fun z : Gibbs U β ↦ ℓ • R (K x) - z) (hFK x).symm
          _ = R (K x) - K x := by module
      rw [he]
      exact textbookBrownianGibbsComplexResolvent_mem_graph m hm U hU hPU β hβ (K x)
    · intro x y hxy
      change R (K (ℓ • x - y)) = x
      have hR : R (x - y) = x :=
        textbookBrownianGibbsComplexResolvent_inverse_graph m hm U hU hPU β hβ x y hxy
      have he : ℓ • x - y = (x - y) + (ℓ - 1) • R (x - y) := by
        rw [hR]
        module
      rw [he, hKF, hR]

include hm hβ in
/-- At every complex shift other than one, the whole-generator graph inverse exists exactly at the transformed bounded resolvent value. -/
theorem textbookBrownianGibbsGeneratorComplexResolventSet_iff_resolventSet
    (ℓ : ℂ) (hℓ : ℓ ≠ 1) :
    ℓ ∈ textbookBrownianGibbsGeneratorComplexResolventSet m hm U hU hPU β hβ ↔
      (1 - ℓ)⁻¹ ∈ resolventSet ℂ (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  let R := textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ
  have hd : 1 - ℓ ≠ 0 := sub_ne_zero.mpr (Ne.symm hℓ)
  have he : (1 : Gibbs U β →L[ℂ] Gibbs U β) + (ℓ - 1) • R =
      (algebraMap ℂ (Gibbs U β →L[ℂ] Gibbs U β)) (1 - ℓ) *
        ((algebraMap ℂ (Gibbs U β →L[ℂ] Gibbs U β)) ((1 - ℓ)⁻¹) - R) := by
    apply ContinuousLinearMap.ext
    intro x
    change x + (ℓ - 1) • R x = (1 - ℓ) • ((1 - ℓ)⁻¹ • x - R x)
    rw [smul_sub, smul_smul]
    simp only [mul_inv_cancel₀ hd, one_smul]
    module
  rw [textbookBrownianGibbsGeneratorComplexResolventSet_iff_isUnit m hm U hU hPU β hβ,
    spectrum.mem_resolventSet_iff]
  change IsUnit (1 + (ℓ - 1) • R) ↔
    IsUnit ((algebraMap ℂ (Gibbs U β →L[ℂ] Gibbs U β)) ((1 - ℓ)⁻¹) - R)
  rw [he]
  exact (IsUnit.map (algebraMap ℂ (Gibbs U β →L[ℂ] Gibbs U β))
    (IsUnit.mk0 (1 - ℓ) hd)).mul_left_iff

/-- The complex spectrum of the whole original unbounded generator is the complement of its actual bounded graph resolvent set. -/
def textbookBrownianGibbsGeneratorComplexSpectrum : Set ℂ :=
  (textbookBrownianGibbsGeneratorComplexResolventSet m hm U hU hPU β hβ)ᶜ

include hm hβ in
/-- Exact whole complex spectral correspondence for the original generator and its genuine compact resolvent. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_iff_resolventSpectrum
    (ℓ : ℂ) (hℓ : ℓ ≠ 1) :
    ℓ ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ ↔
      (1 - ℓ)⁻¹ ∈ spectrum ℂ (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) :=
  not_congr (textbookBrownianGibbsGeneratorComplexResolventSet_iff_resolventSet
    m hm U hU hPU β hβ ℓ hℓ)


private abbrev cb := textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ

private theorem mode_nonzero (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    cb m hm U hU hPU β hβ j ≠ 0 := by
  intro hz
  have hn := (cb m hm U hU hPU β hβ).orthonormal.norm_eq_one j
  rw [hz, norm_zero] at hn
  norm_num at hn

private theorem nonzero_coefficient (x : Gibbs U β) (hx : x ≠ 0) :
    ∃ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
      ⟪cb m hm U hU hPU β hβ j, x⟫_ℂ ≠ 0 := by
  let b := cb m hm U hU hPU β hβ
  by_contra! h
  apply hx
  apply b.repr.injective
  apply Subtype.ext
  funext j
  rw [b.repr_apply_apply, b.repr_apply_apply, inner_zero_right]
  exact h j

/-- Every nonzero point of the entire actual complex compact-resolvent spectrum is a genuine eigenvalue, and conversely. -/
theorem textbookBrownianGibbsComplexResolvent_eigenvalue_iff_spectrum (r : ℂ) (hr : r ≠ 0) :
    Module.End.HasEigenvalue (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ).toLinearMap r ↔
      r ∈ spectrum ℂ (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) :=
  (textbookBrownianGibbsComplexResolvent_isCompact m hm U hU hPU β hβ).hasEigenvalue_iff_mem_spectrum hr

/-- Genuine complex eigenvalues of the actual original generator are precisely the original real complete-basis eigenvalues embedded in the complex numbers. -/
theorem textbookBrownianGibbsComplexOperator_eigenvalue_iff_mode (z : ℂ) :
    (∃ x : Gibbs U β, x ≠ 0 ∧
      (x, z • x) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph) ↔
      ∃ j : textbookBrownianGibbsEigenIndex m U hU hPU β, (j.1 : ℂ) = z := by
  constructor
  · rintro ⟨x, hx0, hx⟩
    obtain ⟨j, hj⟩ := nonzero_coefficient m hm U hU hPU β hβ x hx0
    have hc := (textbookBrownianGibbsComplexOperator_graph_iff_coefficients
      m hm U hU hPU β hβ x (z • x)).mp hx j
    rw [inner_smul_right] at hc
    exact ⟨j, (mul_right_cancel₀ hj hc).symm⟩
  · rintro ⟨j, hj⟩
    refine ⟨cb m hm U hU hPU β hβ j, mode_nonzero m hm U hU hPU β hβ j, ?_⟩
    rw [← hj]
    exact textbookBrownianGibbsComplexEigenbasis_mem_graph m hm U hU hPU β hβ j

/-- Every actual bounded complex resolvent eigenvalue is exactly an actual inverse-shifted original mode, with no spectral-completeness assumption. -/
theorem textbookBrownianGibbsComplexResolvent_eigenvalue_iff_mode (r : ℂ) :
    Module.End.HasEigenvalue (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ).toLinearMap r ↔
      ∃ j : textbookBrownianGibbsEigenIndex m U hU hPU β, (((1 - j.1)⁻¹ : ℝ) : ℂ) = r := by
  classical
  let b := cb m hm U hU hPU β hβ
  let R := textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ
  constructor
  · intro he
    obtain ⟨x, hx, hx0⟩ := he.exists_hasEigenvector
    have hRx : R x = r • x := by
      simp only [Module.End.mem_genEigenspace_one] at hx
      exact hx
    obtain ⟨j, hj⟩ := nonzero_coefficient m hm U hU hPU β hβ x hx0
    have hc := textbookBrownianGibbsComplexResolvent_coefficient m hm U hU hPU β hβ x j
    rw [hRx, inner_smul_right] at hc
    exact ⟨j, (mul_right_cancel₀ hj hc).symm⟩
  · rintro ⟨j, hj⟩
    have hR : R (b j) = r • b j := by
      apply b.repr.injective
      apply Subtype.ext
      funext i
      rw [b.repr_apply_apply, b.repr_apply_apply,
        textbookBrownianGibbsComplexResolvent_coefficient, inner_smul_right,
        orthonormal_iff_ite.mp b.orthonormal]
      by_cases h : i = j
      · subst i
        simp [hj]
      · simp [h]
    apply Module.End.hasEigenvalue_of_hasEigenvector (x := b j)
    apply Module.End.hasEigenvector_iff.mpr
    refine ⟨?_, mode_nonzero m hm U hU hPU β hβ j⟩
    simp only [Module.End.mem_genEigenspace_one]
    exact hR

/-- The entire complex spectrum of the actual original unbounded generator is exactly the original real mode-value range, via the actual compact Fredholm theorem and true graph-resolvent transform. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_iff_mode (z : ℂ) :
    z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ ↔
      ∃ j : textbookBrownianGibbsEigenIndex m U hU hPU β, (j.1 : ℂ) = z := by
  by_cases hz : z = 1
  · subst z
    constructor
    · intro h
      exact False.elim (h (textbookBrownianGibbsGeneratorComplexResolventSet_one m hm U hU hPU β hβ))
    · rintro ⟨j, hj⟩
      have he : j.1 = 1 := by exact_mod_cast hj
      have hn := textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j
      linarith
  · rw [textbookBrownianGibbsGeneratorComplexSpectrum_iff_resolventSpectrum
      m hm U hU hPU β hβ z hz,
      ← textbookBrownianGibbsComplexResolvent_eigenvalue_iff_spectrum m hm U hU hPU β hβ
        (1 - z)⁻¹ (inv_ne_zero (sub_ne_zero.mpr (Ne.symm hz))),
      textbookBrownianGibbsComplexResolvent_eigenvalue_iff_mode]
    constructor
    · rintro ⟨j, hj⟩
      have hi : (1 - (j.1 : ℂ))⁻¹ = (1 - z)⁻¹ := by
        simpa only [Complex.ofReal_inv, Complex.ofReal_sub, Complex.ofReal_one] using hj
      have he := inv_injective hi
      refine ⟨j, ?_⟩
      linear_combination -he
    · rintro ⟨j, hj⟩
      refine ⟨j, ?_⟩
      push_cast
      rw [hj]

/-- Every point of the whole actual complex spectrum is a genuine original generator eigenvalue; the converse also holds. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_iff_eigen_graph (z : ℂ) :
    z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ ↔
      ∃ x : Gibbs U β, x ≠ 0 ∧
        (x, z • x) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph := by
  rw [textbookBrownianGibbsGeneratorComplexSpectrum_iff_mode,
    textbookBrownianGibbsComplexOperator_eigenvalue_iff_mode]

/-- Exact equality of the entire complex spectrum with the embedded entire original real spectrum, for the actual same-Gibbs generators. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image :
    textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ =
      Complex.ofReal '' textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β := by
  ext z
  rw [textbookBrownianGibbsGeneratorComplexSpectrum_iff_mode]
  constructor
  · rintro ⟨j, hj⟩
    refine ⟨j.1, ?_, hj⟩
    rw [textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range m hm U hU hPU β hβ]
    exact ⟨j, rfl⟩
  · rintro ⟨r, hr, hz⟩
    rw [textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range m hm U hU hPU β hβ] at hr
    obtain ⟨j, hj⟩ := hr
    exact ⟨j, (congrArg Complex.ofReal hj).trans hz⟩

/-- The entire actual complex spectrum has zero imaginary part. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_im_zero (z : ℂ)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) : z.im = 0 := by
  obtain ⟨j, hj⟩ := (textbookBrownianGibbsGeneratorComplexSpectrum_iff_mode m hm U hU hPU β hβ z).mp hz
  rw [← hj, Complex.ofReal_im]

/-- The entire actual complex spectrum lies on the original nonpositive real half-line. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_nonpos (z : ℂ)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) : z.re ≤ 0 := by
  obtain ⟨j, hj⟩ := (textbookBrownianGibbsGeneratorComplexSpectrum_iff_mode m hm U hU hPU β hβ z).mp hz
  rw [← hj, Complex.ofReal_re]
  exact textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j

/-- Every nonzero value of the entire actual complex spectrum satisfies the original derived Gibbs coercivity gap. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_gap (z : ℂ) (hz0 : z ≠ 0)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) :
    z.re ≤ -textbookBrownianGibbsCoercivityRate m U hU hPU β := by
  obtain ⟨j, hj⟩ := (textbookBrownianGibbsGeneratorComplexSpectrum_iff_mode m hm U hU hPU β hβ z).mp hz
  have hj0 : j.1 ≠ 0 := by
    intro h0
    apply hz0
    rw [← hj, h0, Complex.ofReal_zero]
  rw [← hj, Complex.ofReal_re]
  exact textbookBrownianGibbsEigenbasis_eigenvalue_gap m hm U hU hPU β hβ j hj0

/-- The original normalized equilibrium mode supplies a genuine zero value in the whole actual complex spectrum. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_zero :
    (0 : ℂ) ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ := by
  rw [textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image]
  exact ⟨0, textbookBrownianGibbsGeneratorRealSpectrum_zero m hm U hU hPU β hβ, Complex.ofReal_zero⟩

/-- The entire actual complex spectrum is genuinely countable, with no enumerability hypothesis. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_countable :
    (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable := by
  rw [textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image]
  exact (textbookBrownianGibbsGeneratorRealSpectrum_countable m hm U hU hPU β hβ).image Complex.ofReal

/-- Every real lower spectral level contains only finitely many values of the actual whole complex spectrum. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_finite_levels (a : ℝ) :
    {z : ℂ | z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ ∧ a ≤ z.re}.Finite := by
  have hf := textbookBrownianGibbsGeneratorRealSpectrum_finite_levels m hm U hU hPU β hβ a
  refine (hf.image Complex.ofReal).subset ?_
  rintro z ⟨hz, hza⟩
  rw [textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image] at hz
  obtain ⟨r, hr, hrz⟩ := hz
  refine ⟨r, ⟨hr, ?_⟩, hrz⟩
  simpa only [← hrz, Complex.ofReal_re] using hza

/-- The entire actual complex spectrum is a closed subset of the complex plane, so no finite accumulation can escape it. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_isClosed :
    IsClosed (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) := by
  have he : textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ =
      {z : ℂ | z.im = 0} ∩ Complex.re ⁻¹' textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β := by
    ext z
    constructor
    · intro hz
      refine ⟨textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz, ?_⟩
      rw [textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image] at hz
      obtain ⟨r, hr, hrz⟩ := hz
      change z.re ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β
      rw [← hrz, Complex.ofReal_re]
      exact hr
    · rintro ⟨hI, hR⟩
      rw [textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image]
      refine ⟨z.re, hR, ?_⟩
      change z.im = 0 at hI
      apply Complex.ext
      · exact Complex.ofReal_re z.re
      · rw [Complex.ofReal_im]
        exact hI.symm
  rw [he]
  exact (isClosed_eq Complex.continuous_im continuous_const).inter
    ((textbookBrownianGibbsGeneratorRealSpectrum_isClosed m hm U hU hPU β hβ).preimage Complex.continuous_re)

/-- Every point of the actual entire complex spectrum is isolated in the complex plane, proved from actual finite spectral levels. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_isolated (z : ℂ)
    (hz : z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ) :
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ = {z} := by
  let S := textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ
  let F : Set ℂ := {w | w ∈ S ∧ z.re - 1 ≤ w.re}
  have hf : F.Finite := textbookBrownianGibbsGeneratorComplexSpectrum_finite_levels m hm U hU hPU β hβ (z.re - 1)
  let N : Set ℂ := Complex.re ⁻¹' Set.Ioi (z.re - 1) ∩ (F \ {z})ᶜ
  have hN : IsOpen N :=
    (isOpen_Ioi.preimage Complex.continuous_re).inter (hf.sdiff (t := {z})).isClosed.isOpen_compl
  have hzN : z ∈ N := by
    refine ⟨?_, ?_⟩
    · change z.re - 1 < z.re
      linarith
    · rintro ⟨_, hne⟩
      exact hne (Set.mem_singleton z)
  refine ⟨N, hN, hzN, ?_⟩
  ext w
  constructor
  · rintro ⟨hwN, hwS⟩
    change (z.re - 1 < w.re) ∧ w ∉ F \ {z} at hwN
    by_contra hw
    exact hwN.2 ⟨⟨hwS, hwN.1.le⟩, hw⟩
  · intro hw
    have he : w = z := Set.mem_singleton_iff.mp hw
    subst w
    exact ⟨hzN, hz⟩
include hm hβ in
/-- Every actual bounded graph inverse of a complex shift of the original generator is compact, by factoring it through the true compact inverse at one. -/
theorem textbookBrownianGibbsGeneratorComplexResolvent_isCompact (ℓ : ℂ)
    (B : Gibbs U β →L[ℂ] Gibbs U β)
    (hB : ∀ x, (B x, ℓ • B x - x) ∈
      (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph) : IsCompactOperator B := by
  let R := textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ
  let K : Gibbs U β →L[ℂ] Gibbs U β := 1 - (ℓ - 1) • B
  have he : B = R.comp K := by
    apply ContinuousLinearMap.ext
    intro x
    change B x = R (x - (ℓ - 1) • B x)
    have hi : x - (ℓ - 1) • B x = B x - (ℓ • B x - x) := by module
    rw [hi]
    exact (textbookBrownianGibbsComplexResolvent_inverse_graph m hm U hU hPU β hβ
      (B x) (ℓ • B x - x) (hB x)).symm
  rw [he]
  exact (textbookBrownianGibbsComplexResolvent_isCompact m hm U hU hPU β hβ).comp_clm K

end
end MolecularDynamics