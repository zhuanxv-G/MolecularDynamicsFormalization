import MolecularDynamics.Chapter06.LangevinCanonicalHilbertClosed

/-! The original canonical energy yields dissipativity on the actual closed
Hilbert realization, and a true positive-shift norm bound and injectivity.
Surjectivity, compact resolvent and Poisson solvability are not asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace LinearPMap
namespace MolecularDynamics
noncomputable section

/-- Real canonical energy gives nonpositive Hilbert pairing on the actual test graph. -/
theorem textbookLangevinCanonicalHilbertTestGraph_nonpos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (p : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hpG : p ∈ textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ) : ⟪p.1, p.2⟫_ℝ ≤ 0 := by
  obtain ⟨F, hs, hF, hf, hg⟩ := hpG
  have he : ⟪p.1, p.2⟫_ℝ =
      ∫ x, F x * textbookLangevinPeriodicDifferentialOperator U γ σ F x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
    rw [L2.inner_def]
    apply integral_congr_ae
    filter_upwards [hf, hg] with x hx hy
    rw [hx, hy, Real.inner_apply]
  rw [he, textbookLangevinCanonicalMeasure_energy U hU hp β γ σ hβ hσ F hF hs]
  have hc : 0 ≤ γ * β⁻¹ := by
    have h := hσ
    simp only [div_eq_mul_inv] at h
    nlinarith [sq_nonneg σ]
  have hΓ : 0 ≤ ∫ x, textbookLangevinPeriodicMomentumGradientSquare F x
      ∂textbookLangevinCanonicalMeasure U β hβ :=
    integral_nonneg (fun x ↦ Finset.sum_nonneg (fun i _ ↦ sq_nonneg _))
  exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hc) hΓ

/-- Genuine dissipativity persists on the true graph closure by continuity of inner product. -/
theorem textbookLangevinCanonicalHilbertTestGraph_closure_nonpos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (f g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hfg : (f, g) ∈ closure (textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ)) :
    ⟪f, g⟫_ℝ ≤ 0 := by
  let H := Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)
  let Z : Set (H × H) := {p | ⟪p.1, p.2⟫_ℝ ≤ 0}
  have hZ : IsClosed Z := isClosed_le (by fun_prop) (by fun_prop)
  have hsub : textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ ⊆ Z :=
    fun p hpG ↦ textbookLangevinCanonicalHilbertTestGraph_nonpos U hU hp β γ σ hβ hσ p hpG
  exact (closure_minimal hsub hZ) hfg

/-- Every actual element of the constructed closed Hilbert domain satisfies dissipativity,
derived from the real canonical energy instead of assuming a semigroup identification. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_nonpos {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain) :
    ⟪(f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)),
      textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f⟫_ℝ ≤ 0 := by
  have hfg := (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).mem_graph f
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hfg
  exact textbookLangevinCanonicalHilbertTestGraph_closure_nonpos U hU hp β γ σ hβ hσ f _ hfg

/-- Real dissipativity and the Hilbert Cauchy-Schwarz inequality yield the
actual positive-shift lower norm bound on the entire original graph closure. -/
theorem textbookLangevinCanonicalHilbertTestGraph_closure_shift_norm_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (f g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hfg : (f, g) ∈ closure (textbookLangevinCanonicalHilbertTestGraph U β γ σ hβ))
    (r : ℝ) (hr : 0 < r) : ‖f‖ ≤ ‖r • f - g‖ / r := by
  have hnonpos := textbookLangevinCanonicalHilbertTestGraph_closure_nonpos U hU hp β γ σ hβ hσ f g hfg
  have hi : r * ‖f‖ ^ 2 ≤ ⟪f, r • f - g⟫_ℝ := by
    rw [inner_sub_right, inner_smul_right, real_inner_self_eq_norm_sq]
    linarith
  have hcs := real_inner_le_norm f (r • f - g)
  have hlower : r * ‖f‖ ≤ ‖r • f - g‖ := by
    by_cases hf0 : f = 0
    · simp only [hf0, norm_zero, mul_zero]
      exact norm_nonneg _
    · have hn : 0 < ‖f‖ := norm_pos_iff.mpr hf0
      have he : ‖f‖ * (r * ‖f‖) ≤ ‖f‖ * ‖r • f - g‖ := by nlinarith [hi, hcs]
      exact le_of_mul_le_mul_left he hn
  exact (le_div_iff₀ hr).mpr (by simpa only [mul_comm] using hlower)

/-- Every positive shift of the true closed realization is injective on its
actual domain. This does not assert existence of a resolvent on the full Hilbert space. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_shift_injective {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β) (r : ℝ) (hr : 0 < r) :
    Function.Injective (fun f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain ↦
      r • (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) -
        textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f) := by
  let A := textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ
  intro f g heq
  have hfg := A.graph.sub_mem (A.mem_graph f) (A.mem_graph g)
  rw [textbookLangevinCanonicalHilbertClosedOperator_graph U hU hp β γ σ hβ hσ] at hfg
  have hb := textbookLangevinCanonicalHilbertTestGraph_closure_shift_norm_bound U hU hp β γ σ hβ hσ
    ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) - g) (A f - A g) hfg r hr
  have hz : r • ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) - g) - (A f - A g) = 0 := by
    calc
      _ = (r • (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) - A f) -
          (r • (g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) - A g) := by
        rw [smul_sub]
        abel
      _ = 0 := sub_eq_zero.mpr heq
  rw [hz, norm_zero, zero_div] at hb
  have hn : ‖(f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) - g‖ = 0 := by
    nlinarith [norm_nonneg ((f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) - g)]
  apply Subtype.ext
  exact sub_eq_zero.mp (norm_eq_zero.mp hn)

end
end MolecularDynamics
