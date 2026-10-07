import MolecularDynamics.Chapter06.BrownianGeneratorRealSpectrum

/-! Finite spectral levels and cofinite escape for the actual original Gibbs generator. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

include hm hβ in
/-- Only finitely many actual whole-generator basis modes have resolvent weight above any fixed positive threshold. -/
theorem textbookBrownianGibbsEigenbasis_finite_resolvent_levels (ε : ℝ) (hε : 0 < ε) :
    {j : textbookBrownianGibbsEigenIndex m U hU hPU β | ε ≤ (1 - j.1)⁻¹}.Finite := by
  classical
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  let R := textbookBrownianGibbsResolvent m U hU hPU β hm hβ
  let S : Set (textbookBrownianGibbsEigenIndex m U hU hPU β) := {j | ε ≤ (1 - j.1)⁻¹}
  obtain ⟨K, hK, hRK⟩ :=
    (textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ).image_closedBall_subset_compact 1
  have hmem (j : textbookBrownianGibbsEigenIndex m U hU hPU β) : R (b j) ∈ K := by
    apply hRK
    refine ⟨b j, ?_, rfl⟩
    rw [Metric.mem_closedBall, dist_zero_right, b.orthonormal.norm_eq_one]
  have hsep (j k : S) (hjk : j ≠ k) : ε ≤ dist (R (b j)) (R (b k)) := by
    have hne : (j : textbookBrownianGibbsEigenIndex m U hU hPU β) ≠ k := by
      intro h
      exact hjk (Subtype.ext h)
    have hℓ := textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j
    have hr : 0 < (1 - j.val.1)⁻¹ := inv_pos.mpr (by linarith)
    have hii : ⟪b j, b j⟫_ℝ = 1 := by
      rw [real_inner_self_eq_norm_sq, b.orthonormal.norm_eq_one]
      norm_num
    have he : ⟪b j, R (b j) - R (b k)⟫_ℝ = (1 - j.val.1)⁻¹ := by
      rw [inner_sub_right,
        textbookBrownianGibbsResolvent_coefficient m hm U hU hPU β hβ,
        textbookBrownianGibbsResolvent_coefficient m hm U hU hPU β hβ,
        hii, b.orthonormal.inner_eq_zero hne, mul_one, mul_zero, sub_zero]
    have hn := norm_inner_le_norm (𝕜 := ℝ) (b j) (R (b j) - R (b k))
    rw [he, Real.norm_eq_abs, abs_of_pos hr, b.orthonormal.norm_eq_one, one_mul] at hn
    rw [dist_eq_norm]
    exact j.prop.trans hn
  obtain ⟨t, _, ht, hcover⟩ := Metric.finite_approx_of_totallyBounded hK.totallyBounded
    (ε / 3) (by positivity)
  have hex (j : S) : ∃ z : t, dist (R (b j)) z < ε / 3 := by
    obtain ⟨z, hz⟩ := Set.mem_iUnion.mp (hcover (hmem j))
    obtain ⟨hz, hball⟩ := Set.mem_iUnion.mp hz
    exact ⟨⟨z, hz⟩, Metric.mem_ball.mp hball⟩
  choose center hcenter using hex
  have hi : Function.Injective center := by
    intro j k h
    by_contra hne
    have hj := hcenter j
    have hk := hcenter k
    rw [← h] at hk
    have hd := dist_triangle (R (b j)) (center j) (R (b k))
    rw [dist_comm (center j : Gibbs U β)] at hd
    have hs := hsep j k hne
    linarith
  let : Finite t := ht.to_subtype
  let : Finite S := Finite.of_injective center hi
  exact Set.finite_coe_iff.mp inferInstance

include hm hβ in
/-- The actual compact-resolvent weights tend to zero along the cofinite filter of the genuine full eigenbasis. -/
theorem textbookBrownianGibbsEigenbasis_resolvent_weights_tendsto :
    Tendsto (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ (1 - j.1)⁻¹)
      cofinite (𝓝 0) := by
  rw [Metric.tendsto_nhds]
  intro ε hε
  have hf := textbookBrownianGibbsEigenbasis_finite_resolvent_levels m hm U hU hPU β hβ ε hε
  filter_upwards [hf.compl_mem_cofinite] with j hj
  have hn := textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j
  have hr : 0 < (1 - j.1)⁻¹ := inv_pos.mpr (by linarith)
  simpa only [dist_zero_right, Real.norm_eq_abs, abs_of_pos hr, Set.mem_compl_iff,
    Set.mem_ofPred_eq, not_le] using hj

include hm hβ in
/-- There are only finitely many genuine generator eigenbasis modes above each real lower level, including multiplicity. -/
theorem textbookBrownianGibbsEigenbasis_finite_generator_levels (a : ℝ) :
    {j : textbookBrownianGibbsEigenIndex m U hU hPU β | a ≤ j.1}.Finite := by
  have hc : 0 < 2 + |a| := by positivity
  apply (textbookBrownianGibbsEigenbasis_finite_resolvent_levels
    m hm U hU hPU β hβ (2 + |a|)⁻¹ (inv_pos.mpr hc)).subset
  intro j hj
  change a ≤ j.1 at hj
  change (2 + |a|)⁻¹ ≤ (1 - j.1)⁻¹
  have hn := textbookBrownianGibbsEigenbasis_eigenvalue_nonpos m hm U hU hPU β hβ j
  have hp : 0 < 1 - j.1 := by linarith
  apply (inv_le_inv₀ hc hp).mpr
  have ha := neg_abs_le a
  linarith

include hm hβ in
/-- The actual full generator basis eigenvalues escape to minus infinity along the cofinite filter; this also permits finite-dimensional Nc=0. -/
theorem textbookBrownianGibbsEigenbasis_eigenvalues_tendsto_atBot :
    Tendsto (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ j.1) cofinite atBot := by
  rw [Filter.tendsto_atBot]
  intro a
  have hf := textbookBrownianGibbsEigenbasis_finite_generator_levels m hm U hU hPU β hβ a
  filter_upwards [hf.compl_mem_cofinite] with j hj
  change ¬a ≤ j.1 at hj
  exact le_of_lt (not_le.mp hj)

include hm hβ in
/-- Countability of the genuine entire eigenbasis index follows from its finite spectral levels, with no countability assumption. -/
theorem textbookBrownianGibbsEigenIndex_countable :
    Countable (textbookBrownianGibbsEigenIndex m U hU hPU β) := by
  have he : (Set.univ : Set (textbookBrownianGibbsEigenIndex m U hU hPU β)) =
      ⋃ n : ℕ, {j : textbookBrownianGibbsEigenIndex m U hU hPU β | -(n : ℝ) ≤ j.1} := by
    ext j
    simp only [Set.mem_univ, Set.mem_iUnion, Set.mem_ofPred_eq, true_iff]
    obtain ⟨n, hn⟩ := exists_nat_gt (-j.1)
    exact ⟨n, by linarith⟩
  rw [← Set.countable_univ_iff, he]
  exact Set.countable_iUnion fun n ↦
    (textbookBrownianGibbsEigenbasis_finite_generator_levels m hm U hU hPU β hβ (-(n : ℝ))).countable

include hm hβ in
/-- The whole actual original-generator real spectrum is exactly the eigenvalue range of its genuine complete Hilbert basis. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range :
    textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β =
      Set.range (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ j.1) := by
  classical
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  ext ℓ
  constructor
  · intro hs
    obtain ⟨x, hx, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot
      ((textbookBrownianGibbsGeneratorRealSpectrum_iff_eigenspace m hm U hU hPU β hβ ℓ).mp hs)
    have hg := (textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β ℓ x).mp hx
    have hex : ∃ j, ⟪b j, x⟫_ℝ ≠ 0 := by
      by_contra! hc
      apply hx0
      apply b.repr.injective
      apply lp.ext
      funext j
      simp only [HilbertBasis.repr_apply_apply, hc j, inner_zero_right]
    obtain ⟨j, hj⟩ := hex
    have h := textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hPU β hβ x (ℓ • x) hg j
    rw [real_inner_smul_right] at h
    exact ⟨j, (mul_right_cancel₀ hj h).symm⟩
  · rintro ⟨j, rfl⟩
    apply (textbookBrownianGibbsGeneratorRealSpectrum_iff_eigenspace m hm U hU hPU β hβ j.1).mpr
    apply (textbookBrownianGibbsClosedEigenspace m U hU hPU β j.1).ne_bot_iff.mpr
    refine ⟨b j, ?_, ?_⟩
    · exact (textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β j.1 _).mpr
        (textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ j)
    · intro he
      have hn := b.orthonormal.norm_eq_one j
      rw [he, norm_zero] at hn
      norm_num at hn

include hm hβ in
/-- Every part of the entire actual real spectrum above a finite lower bound is finite. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_finite_levels (a : ℝ) :
    {ℓ : ℝ | ℓ ∈ textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β ∧ a ≤ ℓ}.Finite := by
  have hf := textbookBrownianGibbsEigenbasis_finite_generator_levels m hm U hU hPU β hβ a
  apply (hf.image (fun j ↦ j.1)).subset
  intro ℓ hℓ
  obtain ⟨j, hj⟩ := (textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range
    m hm U hU hPU β hβ).symm ▸ hℓ.1
  refine ⟨j, ?_, hj⟩
  change a ≤ j.1
  change j.1 = ℓ at hj
  rw [hj]
  exact hℓ.2

include hm hβ in
/-- The whole actual original-generator real spectrum is countable, proved from compactness rather than assumed. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_countable :
    (textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β).Countable := by
  let : Countable (textbookBrownianGibbsEigenIndex m U hU hPU β) :=
    textbookBrownianGibbsEigenIndex_countable m hm U hU hPU β hβ
  rw [textbookBrownianGibbsGeneratorRealSpectrum_eq_eigenbasis_range m hm U hU hPU β hβ]
  exact Set.countable_range _

include hm hβ in
/-- Every point of the actual whole real generator spectrum is isolated in the ordinary real topology. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_isDiscrete :
    IsDiscrete (textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β) := by
  apply isDiscrete_iff_forall_mem_exists_isOpen.mpr
  intro ℓ hℓ
  let S := textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β
  let F : Set ℝ := {r | r ∈ S ∧ ℓ - 1 ≤ r}
  have hf : F.Finite :=
    textbookBrownianGibbsGeneratorRealSpectrum_finite_levels m hm U hU hPU β hβ (ℓ - 1)
  refine ⟨Set.Ioi (ℓ - 1) ∩ (F \ {ℓ})ᶜ,
    isOpen_Ioi.inter (hf.sdiff (t := {ℓ})).isClosed.isOpen_compl, ?_⟩
  ext r
  constructor
  · rintro ⟨⟨hr, hn⟩, hrs⟩
    apply Set.mem_singleton_iff.mpr
    by_contra hne
    apply hn
    refine ⟨⟨hrs, le_of_lt hr⟩, ?_⟩
    simpa only [Set.mem_singleton_iff] using hne
  · intro hr
    have her : r = ℓ := Set.mem_singleton_iff.mp hr
    subst r
    refine ⟨⟨by change ℓ - 1 < ℓ; linarith, ?_⟩, hℓ⟩
    rintro ⟨_, hn⟩
    exact hn (Set.mem_singleton ℓ)

include hm hβ in
/-- The actual whole real generator spectrum is closed, so its proven discreteness has no finite accumulation point outside the spectrum either. -/
theorem textbookBrownianGibbsGeneratorRealSpectrum_isClosed :
    IsClosed (textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β) := by
  rw [← isOpen_compl_iff]
  apply isOpen_iff_mem_nhds.mpr
  intro ℓ hℓ
  let S := textbookBrownianGibbsGeneratorRealSpectrum m U hU hPU β
  let F : Set ℝ := {r | r ∈ S ∧ ℓ - 1 ≤ r}
  have hf : F.Finite :=
    textbookBrownianGibbsGeneratorRealSpectrum_finite_levels m hm U hU hPU β hβ (ℓ - 1)
  have hnot : ℓ ∈ Fᶜ := by
    rintro ⟨hs, _⟩
    exact hℓ hs
  have hnhds : Set.Ioi (ℓ - 1) ∩ Fᶜ ∈ 𝓝 ℓ :=
    (isOpen_Ioi.inter hf.isClosed.isOpen_compl).mem_nhds
      ⟨by change ℓ - 1 < ℓ; linarith, hnot⟩
  apply Filter.mem_of_superset hnhds
  rintro r ⟨hr, hn⟩ hs
  exact hn ⟨hs, le_of_lt hr⟩

end
end MolecularDynamics
