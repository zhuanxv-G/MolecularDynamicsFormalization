import MolecularDynamics.Chapter06.BrownianResolventRealSpectrum

/-! Actual bounded two-sided resolvent sets of the original unbounded Gibbs generator. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- The genuine real resolvent set of the whole original closed generator, defined by actual bounded graph inverses. -/
def textbookBrownianGibbsGeneratorRealResolventSet : Set ℝ :=
  {ℓ | ∃ R : Gibbs U β →L[ℝ] Gibbs U β,
    (∀ x, (R x, ℓ • R x - x) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) ∧
    (∀ x y, (x, y) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph →
      R (ℓ • x - y) = x)}

include hm hβ in
/-- The actual compact resolvent already constructed is a genuine whole-generator inverse at one. -/
theorem textbookBrownianGibbsGeneratorRealResolventSet_one :
    (1 : ℝ) ∈ textbookBrownianGibbsGeneratorRealResolventSet m U hU hPU β := by
  refine ⟨textbookBrownianGibbsResolvent m U hU hPU β hm hβ, ?_, ?_⟩
  · intro x
    simpa only [one_smul] using textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x
  · intro x y hxy
    simpa only [one_smul] using textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ x y hxy

include hm hβ in
/-- Exact equivalence between a bounded two-sided graph inverse of the whole generator and the actual bounded resolvent bridge. -/
theorem textbookBrownianGibbsGeneratorRealResolventSet_iff_isUnit (ℓ : ℝ) :
    ℓ ∈ textbookBrownianGibbsGeneratorRealResolventSet m U hU hPU β ↔
      IsUnit ((1 : Gibbs U β →L[ℝ] Gibbs U β) +
        (ℓ - 1) • textbookBrownianGibbsResolvent m U hU hPU β hm hβ) := by
  let R := textbookBrownianGibbsResolvent m U hU hPU β hm hβ
  constructor
  · rintro ⟨B, hBgraph, hBinv⟩
    have hRB (x : Gibbs U β) : R x - (ℓ - 1) • R (B x) = B x := by
      have h := textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ
        (B x) (ℓ • B x - x) (hBgraph x)
      change R (B x - (ℓ • B x - x)) = B x at h
      rw [map_sub, map_sub, map_smul] at h
      calc
        R x - (ℓ - 1) • R (B x) = R (B x) - (ℓ • R (B x) - R x) := by module
        _ = B x := h
    have hBR (x : Gibbs U β) : B x + (ℓ - 1) • B (R x) = R x := by
      have h := hBinv (R x) (R x - x)
        (textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x)
      have he : ℓ • R x - (R x - x) = x + (ℓ - 1) • R x := by module
      rw [he, map_add, map_smul] at h
      exact h
    let K : Gibbs U β →L[ℝ] Gibbs U β := 1 - (ℓ - 1) • B
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
    let K : Gibbs U β →L[ℝ] Gibbs U β := ↑hF.unit⁻¹
    have hFK (x : Gibbs U β) : K x + (ℓ - 1) • R (K x) = x := by
      have h := congrArg (fun L : Gibbs U β →L[ℝ] Gibbs U β ↦ L x) hF.mul_val_inv
      change K x + (ℓ - 1) • R (K x) = x at h
      exact h
    have hKF (x : Gibbs U β) : K (x + (ℓ - 1) • R x) = x := by
      have h := congrArg (fun L : Gibbs U β →L[ℝ] Gibbs U β ↦ L x) hF.val_inv_mul
      change K (x + (ℓ - 1) • R x) = x at h
      exact h
    refine ⟨R.comp K, ?_, ?_⟩
    · intro x
      change (R (K x), ℓ • R (K x) - x) ∈
        (textbookBrownianGibbsClosedOperator m U hU hPU β).graph
      have he : ℓ • R (K x) - x = R (K x) - K x := by
        calc
          ℓ • R (K x) - x = ℓ • R (K x) - (K x + (ℓ - 1) • R (K x)) :=
            congrArg (fun z : Gibbs U β ↦ ℓ • R (K x) - z) (hFK x).symm
          _ = R (K x) - K x := by module
      rw [he]
      exact textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ (K x)
    · intro x y hxy
      change R (K (ℓ • x - y)) = x
      have hR : R (x - y) = x :=
        textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ x y hxy
      have he : ℓ • x - y = (x - y) + (ℓ - 1) • R (x - y) := by
        rw [hR]
        module
      rw [he, hKF, hR]

include hm hβ in
/-- At every real shift other than one, the whole-generator graph inverse exists exactly at the transformed bounded resolvent value. -/
theorem textbookBrownianGibbsGeneratorRealResolventSet_iff_resolventSet
    (ℓ : ℝ) (hℓ : ℓ ≠ 1) :
    ℓ ∈ textbookBrownianGibbsGeneratorRealResolventSet m U hU hPU β ↔
      (1 - ℓ)⁻¹ ∈ resolventSet ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) := by
  let R := textbookBrownianGibbsResolvent m U hU hPU β hm hβ
  have hd : 1 - ℓ ≠ 0 := sub_ne_zero.mpr (Ne.symm hℓ)
  have he : (1 : Gibbs U β →L[ℝ] Gibbs U β) + (ℓ - 1) • R =
      (algebraMap ℝ (Gibbs U β →L[ℝ] Gibbs U β)) (1 - ℓ) *
        ((algebraMap ℝ (Gibbs U β →L[ℝ] Gibbs U β)) ((1 - ℓ)⁻¹) - R) := by
    apply ContinuousLinearMap.ext
    intro x
    change x + (ℓ - 1) • R x = (1 - ℓ) • ((1 - ℓ)⁻¹ • x - R x)
    rw [smul_sub, smul_smul]
    simp only [mul_inv_cancel₀ hd, one_smul]
    module
  rw [textbookBrownianGibbsGeneratorRealResolventSet_iff_isUnit m hm U hU hPU β hβ,
    spectrum.mem_resolventSet_iff]
  change IsUnit (1 + (ℓ - 1) • R) ↔
    IsUnit ((algebraMap ℝ (Gibbs U β →L[ℝ] Gibbs U β)) ((1 - ℓ)⁻¹) - R)
  rw [he]
  exact (IsUnit.map (algebraMap ℝ (Gibbs U β →L[ℝ] Gibbs U β))
    (IsUnit.mk0 (1 - ℓ) hd)).mul_left_iff

/-- The real spectrum of the whole original unbounded generator is the complement of its actual bounded graph resolvent set. -/
def textbookBrownianGibbsGeneratorRealSpectrum : Set ℝ :=
  (textbookBrownianGibbsGeneratorRealResolventSet m U hU hPU β)ᶜ

include hm hβ in
/-- Exact whole real spectral correspondence for the original generator and its genuine compact resolvent. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_iff_resolventSpectrum
    (ℓ : ℝ) (hℓ : ℓ ≠ 1) :
    ℓ ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β ↔
      (1 - ℓ)⁻¹ ∈ spectrum ℝ (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) :=
  not_congr (textbookBrownianGibbsGeneratorRealResolventSet_iff_resolventSet
    m hm U hU hPU β hβ ℓ hℓ)

include hm hβ in
/-- Every point of the entire real spectrum of the original unbounded generator is a genuine eigenvalue, and conversely. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_iff_eigenspace (ℓ : ℝ) :
    ℓ ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β ↔
      textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ ≠ ⊥ := by
  by_cases hℓ : ℓ = 1
  · rw [hℓ, textbookBrownianGibbsClosedEigenspace_one_eq_bot m hm U hU hPU β hβ]
    change ¬(1 : ℝ) ∈ textbookBrownianGibbsGeneratorRealResolventSet m U hU hPU β ↔ ⊥ ≠ ⊥
    simp only [textbookBrownianGibbsGeneratorRealResolventSet_one m hm U hU hPU β hβ,
      not_true_eq_false, ne_eq]
  · rw [textbookBrownianGibbsGeneratorRealSpectrum_iff_resolventSpectrum
      m hm U hU hPU β hβ ℓ hℓ,
      ← textbookBrownianGibbsResolvent_eigenvalue_iff_real_spectrum
        m hm U hU hPU β hβ (1 - ℓ)⁻¹ (inv_ne_zero (sub_ne_zero.mpr (Ne.symm hℓ))),
      Module.End.hasEigenvalue_iff,
      textbookBrownianGibbsClosedEigenspace_eq_resolvent m hm U hU hPU β hβ ℓ hℓ]

include hm hβ in
/-- The entire actual unbounded-generator real spectrum is nonpositive. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_nonpos (ℓ : ℝ)
    (hs : ℓ ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β) : ℓ ≤ 0 := by
  obtain ⟨x, hx, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot
    ((textbookBrownianGibbsGeneratorRealSpectrum_iff_eigenspace m hm U hU hPU β hβ ℓ).mp hs)
  exact textbookBrownianGibbsClosedOperator_eigen_graph_nonpos m hm U hU hPU β hβ ℓ x hx0
    ((textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β ℓ x).mp hx)

include hm hβ in
/-- Every nonzero value in the whole actual generator real spectrum obeys the derived Gibbs coercivity gap. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_gap (ℓ : ℝ) (hℓ : ℓ ≠ 0)
    (hs : ℓ ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β) :
    ℓ ≤ -textbookBrownianGibbsCoercivityRate m U hU hPU β := by
  obtain ⟨x, hx, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot
    ((textbookBrownianGibbsGeneratorRealSpectrum_iff_eigenspace m hm U hU hPU β hβ ℓ).mp hs)
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    ((textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β ℓ x).mp hx)
  change (a : Gibbs U β) = x at ha
  change textbookBrownianGibbsClosedOperator m U hU hPU β a = ℓ • x at hAa
  apply textbookBrownianGibbsClosedOperator_real_eigenvalue_bound m hm U hU hPU β hβ a
  · rw [ha]
    exact hx0
  · exact hℓ
  · rw [ha]
    exact hAa

include hm hβ in
/-- Zero is a genuine spectral value of the original unbounded generator, supplied by the actual normalized constant mode. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_zero :
    (0 : ℝ) ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β := by
  apply (textbookBrownianGibbsGeneratorRealSpectrum_iff_resolventSpectrum
    m hm U hU hPU β hβ 0 (by norm_num)).mpr
  simpa only [sub_zero, inv_one] using
    textbookBrownianGibbsResolvent_one_mem_real_spectrum m hm U hU hPU β hβ

include hm hβ in
/-- Every actual bounded graph inverse of a real shift of the original generator is compact, by factoring it through the true compact inverse at one. -/
theorem textbookBrownianGibbsGeneratorRealResolvent_isCompact (ℓ : ℝ)
    (B : Gibbs U β →L[ℝ] Gibbs U β)
    (hB : ∀ x, (B x, ℓ • B x - x) ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) : IsCompactOperator B := by
  let R := textbookBrownianGibbsResolvent m U hU hPU β hm hβ
  let K : Gibbs U β →L[ℝ] Gibbs U β := 1 - (ℓ - 1) • B
  have he : B = R.comp K := by
    apply ContinuousLinearMap.ext
    intro x
    change B x = R (x - (ℓ - 1) • B x)
    have hi : x - (ℓ - 1) • B x = B x - (ℓ • B x - x) := by module
    rw [hi]
    exact (textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ
      (B x) (ℓ • B x - x) (hB x)).symm
  rw [he]
  exact (textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ).comp_clm K

end
end MolecularDynamics
