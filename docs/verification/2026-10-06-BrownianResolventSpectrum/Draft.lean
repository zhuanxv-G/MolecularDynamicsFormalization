import MolecularDynamics.Chapter06.BrownianGibbsResolvent
import Mathlib.Analysis.InnerProductSpace.Spectrum

/-! Actual compact original Gibbs resolvent spectral properties and generator correspondence. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics

noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- Symmetry of the actual whole original Gibbs resolvent, from the true original generator graph. -/
theorem textbookBrownianGibbsResolvent_isSymmetric :
    (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap.IsSymmetric := by
  intro x y
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x)
  obtain ⟨b, hb, hAb⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ y)
  have h := textbookBrownianGibbsClosedOperator_formalAdjoint m U hU hPU β hβ.ne' a b
  rw [ha, hb, hAa, hAb, inner_sub_left, inner_sub_right] at h
  change ⟪textbookBrownianGibbsResolvent m U hU hPU β hm hβ x, y⟫_ℝ =
    ⟪x, textbookBrownianGibbsResolvent m U hU hPU β hm hβ y⟫_ℝ
  linarith

/-- The true compact original Gibbs resolvent is actually selfadjoint as a bounded Hilbert operator. -/
theorem textbookBrownianGibbsResolvent_isSelfAdjoint :
    IsSelfAdjoint (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr
    (textbookBrownianGibbsResolvent_isSymmetric m hm U hU hPU β hβ)

/-- The genuine whole original Gibbs resolvent has no zero kernel. -/
theorem textbookBrownianGibbsResolvent_injective :
    Function.Injective (textbookBrownianGibbsResolvent m U hU hPU β hm hβ) := by
  apply LinearMap.ker_eq_bot.mp
  apply bot_unique
  intro x hx
  have hx0 : textbookBrownianGibbsResolvent m U hU hPU β hm hβ x = 0 := hx
  have hg := textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x
  rw [hx0, zero_sub] at hg
  have hz := LinearPMap.graph_fst_eq_zero_snd _ hg rfl
  have hzero : x = 0 := neg_eq_zero.mp hz
  simpa using hzero

/-- The actual resolvent quadratic form controls its true image norm squared. -/
theorem textbookBrownianGibbsResolvent_quadratic_lower
    (x : Gibbs U β) :
    ‖textbookBrownianGibbsResolvent m U hU hPU β hm hβ x‖ ^ 2 ≤
      ⟪textbookBrownianGibbsResolvent m U hU hPU β hm hβ x, x⟫_ℝ := by
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x)
  have h := textbookBrownianGibbsClosedOperator_nonpos m U hU hPU β hm hβ a
  rw [ha, hAa, inner_sub_right, real_inner_self_eq_norm_sq] at h
  linarith

/-- Every genuine nonzero original Gibbs vector has a strictly positive actual resolvent form. -/
theorem textbookBrownianGibbsResolvent_strict_positive
    (x : Gibbs U β) (hx : x ≠ 0) :
    0 < ⟪textbookBrownianGibbsResolvent m U hU hPU β hm hβ x, x⟫_ℝ := by
  have hRx : textbookBrownianGibbsResolvent m U hU hPU β hm hβ x ≠ 0 := by
    intro h
    exact hx ((textbookBrownianGibbsResolvent_injective m hm U hU hPU β hβ)
      (h.trans (map_zero _).symm))
  exact (pow_pos (norm_pos_iff.mpr hRx) 2).trans_le
    (textbookBrownianGibbsResolvent_quadratic_lower m hm U hU hPU β hβ x)


/-- Every genuine resolvent eigenvalue lies in (0,1], proved on the actual Gibbs space. -/
theorem textbookBrownianGibbsResolvent_eigenvalue_bounds
    (r : ℝ) (x : Gibbs U β) (hx : x ≠ 0)
    (he : textbookBrownianGibbsResolvent m U hU hPU β hm hβ x = r • x) :
    0 < r ∧ r ≤ 1 := by
  have hp := textbookBrownianGibbsResolvent_strict_positive m hm U hU hPU β hβ x hx
  rw [he, real_inner_smul_left, real_inner_self_eq_norm_sq] at hp
  have hs : 0 < ‖x‖ ^ 2 := pow_pos (norm_pos_iff.mpr hx) 2
  have hr : 0 < r := (mul_pos_iff_of_pos_right hs).mp hp
  have hn := textbookBrownianGibbsResolvent_norm m U hU hPU β hm hβ x
  rw [he, norm_smul, Real.norm_eq_abs, abs_of_pos hr] at hn
  exact ⟨hr, (by nlinarith [norm_pos_iff.mpr hx])⟩

/-- Actual nonzero resolvent eigenspace vectors belong to the original closed generator graph. -/
theorem textbookBrownianGibbsResolvent_eigen_mem_graph
    (r : ℝ) (hr : r ≠ 0) (x : Gibbs U β)
    (he : textbookBrownianGibbsResolvent m U hU hPU β hm hβ x = r • x) :
    (x, (1 - r⁻¹) • x) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  have hg := textbookBrownianGibbsResolvent_mem_graph m U hU hPU β hm hβ x
  rw [he] at hg
  have hs := (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.smul_mem r⁻¹ hg
  simpa only [Prod.smul_mk, smul_sub, smul_smul, inv_mul_cancel₀ hr,
    one_smul, sub_smul] using hs

include hm hβ in
/-- An actual nonzero generator eigenvector has a nonpositive real eigenvalue. -/
theorem textbookBrownianGibbsClosedOperator_eigen_graph_nonpos
    (ℓ : ℝ) (x : Gibbs U β) (hx : x ≠ 0)
    (hg : (x, ℓ • x) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    ℓ ≤ 0 := by
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp hg
  have h := textbookBrownianGibbsClosedOperator_nonpos m U hU hPU β hm hβ a
  rw [ha, hAa, real_inner_smul_right, real_inner_self_eq_norm_sq] at h
  have hs : 0 < ‖x‖ ^ 2 := pow_pos (norm_pos_iff.mpr hx) 2
  nlinarith

/-- The true closed generator eigenrelation implies the actual resolvent eigenrelation. -/
theorem textbookBrownianGibbsClosedOperator_eigen_graph_resolvent
    (ℓ : ℝ) (hℓ : ℓ ≠ 1) (x : Gibbs U β)
    (hg : (x, ℓ • x) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph) :
    textbookBrownianGibbsResolvent m U hU hPU β hm hβ x = (1 - ℓ)⁻¹ • x := by
  have h := textbookBrownianGibbsResolvent_inverse_graph m U hU hPU β hm hβ x (ℓ • x) hg
  have hd : 1 - ℓ ≠ 0 := sub_ne_zero.mpr (Ne.symm hℓ)
  have hsub : x - ℓ • x = (1 - ℓ) • x := by rw [sub_smul, one_smul]
  rw [hsub, map_smul] at h
  have he := congrArg (fun z : Gibbs U β ↦ (1 - ℓ)⁻¹ • z) h
  simpa only [smul_smul, inv_mul_cancel₀ hd, one_smul] using he

/-- The genuine eigenspace of the original unbounded generator, defined by its actual whole closed graph. -/
def textbookBrownianGibbsClosedEigenspace (ℓ : ℝ) : Submodule ℝ (Gibbs U β) :=
  (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.comap
    ((LinearMap.id : Gibbs U β →ₗ[ℝ] Gibbs U β).prod
      (ℓ • (LinearMap.id : Gibbs U β →ₗ[ℝ] Gibbs U β)))

/-- Membership means the actual original closed-domain eigenrelation. -/
theorem textbookBrownianGibbsClosedEigenspace_mem_iff (ℓ : ℝ) (x : Gibbs U β) :
    x ∈ textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ ↔
      (x, ℓ • x) ∈ (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := Iff.rfl

include hm hβ in
/-- The original generator has no eigenvectors at the positive shift 1. -/
theorem textbookBrownianGibbsClosedEigenspace_one_eq_bot :
    textbookBrownianGibbsClosedEigenspace m U hU hPU β 1 = ⊥ := by
  apply bot_unique
  intro x hx
  have hg := (textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β 1 x).mp hx
  have hz : x = 0 := by
    by_contra hn
    have h := textbookBrownianGibbsClosedOperator_eigen_graph_nonpos m hm U hU hPU β hβ 1 x hn hg
    norm_num at h
  simpa using hz

/-- Exact whole eigenspace correspondence between the actual generator and its true resolvent. -/
theorem textbookBrownianGibbsClosedEigenspace_eq_resolvent
    (ℓ : ℝ) (hℓ : ℓ ≠ 1) :
    textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ =
      Module.End.eigenspace
        (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap (1 - ℓ)⁻¹ := by
  ext x
  rw [textbookBrownianGibbsClosedEigenspace_mem_iff, Module.End.mem_eigenspace_iff]
  constructor
  · exact textbookBrownianGibbsClosedOperator_eigen_graph_resolvent m hm U hU hPU β hβ ℓ hℓ x
  · intro he
    have hd : 1 - ℓ ≠ 0 := sub_ne_zero.mpr (Ne.symm hℓ)
    have hg := textbookBrownianGibbsResolvent_eigen_mem_graph m hm U hU hPU β hβ
      (1 - ℓ)⁻¹ (inv_ne_zero hd) x he
    have hs : 1 - ((1 - ℓ)⁻¹)⁻¹ = ℓ := by rw [inv_inv]; ring
    rwa [hs] at hg

/-- Injectivity removes the zero eigenspace of the true resolvent. -/
theorem textbookBrownianGibbsResolvent_eigenspace_zero :
    Module.End.eigenspace (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap 0 = ⊥ := by
  apply bot_unique
  intro x hx
  rw [Module.End.mem_eigenspace_iff, zero_smul] at hx
  have hz : x = 0 := (textbookBrownianGibbsResolvent_injective m hm U hU hPU β hβ)
    (hx.trans (map_zero _).symm)
  simpa using hz

include hm hβ in
/-- Every eigenspace of the actual original generator is finite-dimensional. -/
theorem textbookBrownianGibbsClosedEigenspace_finiteDimensional (ℓ : ℝ) :
    FiniteDimensional ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ) := by
  by_cases hℓ : ℓ = 1
  · rw [hℓ, textbookBrownianGibbsClosedEigenspace_one_eq_bot m hm U hU hPU β hβ]
    infer_instance
  · rw [textbookBrownianGibbsClosedEigenspace_eq_resolvent m hm U hU hPU β hβ ℓ hℓ]
    exact ContinuousLinearMap.finite_dimensional_eigenspace
      (textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ)
      (1 - ℓ)⁻¹ (inv_ne_zero (sub_ne_zero.mpr (Ne.symm hℓ)))

/-- All genuine resolvent eigenspaces together are dense in the entire original Gibbs Hilbert space. -/
theorem textbookBrownianGibbsResolvent_eigenspaces_dense :
    (⨆ r : ℝ, Module.End.eigenspace
      (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap r).topologicalClosure = ⊤ := by
  let K : Submodule ℝ (Gibbs U β) := ⨆ r : ℝ, Module.End.eigenspace
    (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap r
  let : IsClosed (K.topologicalClosure : Set (Gibbs U β)) := K.isClosed_topologicalClosure
  let : CompleteSpace K.topologicalClosure := IsClosed.completeSpace_coe
  apply Submodule.orthogonal_eq_bot_iff.mp
  rw [Submodule.orthogonal_closure]
  exact ContinuousLinearMap.orthogonalComplement_iSup_eigenspaces_eq_bot
    (textbookBrownianGibbsResolvent_isCompact m U hU hPU β hm hβ)
    (textbookBrownianGibbsResolvent_isSymmetric m hm U hU hPU β hβ)

include hm hβ in
/-- The genuine eigenvectors of the original unbounded generator span densely the whole actual Gibbs space. -/
theorem textbookBrownianGibbsClosedEigenspaces_dense :
    (⨆ ℓ : ℝ, textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ).topologicalClosure = ⊤ := by
  have hle : (⨆ r : ℝ, Module.End.eigenspace
      (textbookBrownianGibbsResolvent m U hU hPU β hm hβ).toLinearMap r) ≤
      ⨆ ℓ : ℝ, textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ := by
    apply iSup_le
    intro r x hx
    by_cases hr : r = 0
    · rw [hr, textbookBrownianGibbsResolvent_eigenspace_zero m hm U hU hPU β hβ] at hx
      have hz : x = 0 := hx
      rw [hz]
      exact Submodule.zero_mem _
    · apply (le_iSup (fun ℓ : ℝ ↦ textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ) (1 - r⁻¹))
      apply (textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β (1 - r⁻¹) x).mpr
      exact textbookBrownianGibbsResolvent_eigen_mem_graph m hm U hU hPU β hβ r hr x
        (Module.End.mem_eigenspace_iff.mp hx)
  apply top_unique
  rw [← textbookBrownianGibbsResolvent_eigenspaces_dense m hm U hU hPU β hβ]
  exact Submodule.topologicalClosure_mono hle


include hβ in
/-- Distinct actual generator eigenspaces are orthogonal in the original Gibbs inner product. -/
theorem textbookBrownianGibbsClosedEigenspaces_orthogonal :
    OrthogonalFamily ℝ
      (fun ℓ : ℝ ↦ textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ)
      (fun ℓ ↦ (textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ).subtypeₗᵢ) := by
  intro ℓ k hne x y
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    ((textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β ℓ x).mp x.prop)
  obtain ⟨b, hb, hAb⟩ := (LinearPMap.mem_graph_iff _).mp
    ((textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β k y).mp y.prop)
  have h := textbookBrownianGibbsClosedOperator_formalAdjoint m U hU hPU β hβ.ne' a b
  rw [ha, hb, hAa, hAb, real_inner_smul_left, real_inner_smul_right] at h
  by_contra hn
  exact hne (mul_right_cancel₀ hn h)

/-- The basis index records the true generator eigenvalue and a finite basis index in its actual eigenspace. -/
abbrev textbookBrownianGibbsEigenIndex :=
  Σ ℓ : ℝ, Fin (Module.finrank ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ))

private def local_eigenbasis (ℓ : ℝ) :
    OrthonormalBasis (Fin (Module.finrank ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ)))
      ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ) := by
  let : FiniteDimensional ℝ (textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ) :=
    textbookBrownianGibbsClosedEigenspace_finiteDimensional m hm U hU hPU β hβ ℓ
  exact stdOrthonormalBasis ℝ _

private def eigenfamily (j : textbookBrownianGibbsEigenIndex m U hU hPU β) : Gibbs U β :=
  (local_eigenbasis m hm U hU hPU β hβ j.1 j.2 : Gibbs U β)

private theorem eigenfamily_orthonormal :
    Orthonormal ℝ (eigenfamily m hm U hU hPU β hβ) := by
  have h := OrthogonalFamily.orthonormal_sigma_orthonormal
    (textbookBrownianGibbsClosedEigenspaces_orthogonal m U hU hPU β hβ)
    (v_family := fun ℓ ↦ ⇑(local_eigenbasis m hm U hU hPU β hβ ℓ))
    (fun ℓ ↦ (local_eigenbasis m hm U hU hPU β hβ ℓ).orthonormal)
  exact h

private theorem eigenfamily_dense :
    (Submodule.span ℝ (Set.range (eigenfamily m hm U hU hPU β hβ))).topologicalClosure = ⊤ := by
  have hle : (⨆ ℓ : ℝ, textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ) ≤
      Submodule.span ℝ (Set.range (eigenfamily m hm U hU hPU β hβ)) := by
    apply iSup_le
    intro ℓ
    let V := textbookBrownianGibbsClosedEigenspace m U hU hPU β ℓ
    let b := local_eigenbasis m hm U hU hPU β hβ ℓ
    have hb : Submodule.span ℝ (Set.range (fun k ↦ (b k : Gibbs U β))) = V := by
      have hsp : Submodule.span ℝ (Set.range b) = ⊤ := b.toBasis.span_eq
      have h := (Submodule.span_val_image_eq_iff V (Set.range b)).mpr hsp
      simpa only [← Set.range_comp, Function.comp_def] using h
    change V ≤ Submodule.span ℝ (Set.range (eigenfamily m hm U hU hPU β hβ))
    rw [← hb]
    apply Submodule.span_mono
    rintro x ⟨k, rfl⟩
    exact ⟨⟨ℓ, k⟩, rfl⟩
  apply top_unique
  rw [← textbookBrownianGibbsClosedEigenspaces_dense m hm U hU hPU β hβ]
  exact Submodule.topologicalClosure_mono hle

/-- A genuine Hilbert eigenbasis of the entire original Gibbs space, constructed from actual finite eigenspaces. -/
def textbookBrownianGibbsEigenbasis :
    HilbertBasis (textbookBrownianGibbsEigenIndex m U hU hPU β) ℝ (Gibbs U β) :=
  HilbertBasis.mk (eigenfamily_orthonormal m hm U hU hPU β hβ)
    (by rw [eigenfamily_dense m hm U hU hPU β hβ])

/-- Every vector of the entire Hilbert eigenbasis lies in the actual original generator closed graph. -/
theorem textbookBrownianGibbsEigenbasis_mem_graph
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j,
      j.1 • textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j) ∈
        (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  apply (textbookBrownianGibbsClosedEigenspace_mem_iff m U hU hPU β j.1 _).mp
  simpa only [textbookBrownianGibbsEigenbasis, HilbertBasis.coe_mk, eigenfamily] using
    (local_eigenbasis m hm U hU hPU β hβ j.1 j.2).prop

private theorem eigenbasis_ne_zero (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j ≠ 0 := by
  have hn := (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).orthonormal.1 j
  intro h
  rw [h, norm_zero] at hn
  norm_num at hn

include hm hβ in
/-- All actual Hilbert eigenbasis eigenvalues of the original generator are nonpositive. -/
theorem textbookBrownianGibbsEigenbasis_eigenvalue_nonpos
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) : j.1 ≤ 0 :=
  textbookBrownianGibbsClosedOperator_eigen_graph_nonpos m hm U hU hPU β hβ
    j.1 _ (eigenbasis_ne_zero m hm U hU hPU β hβ j)
    (textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ j)

include hm hβ in
/-- Every nonzero eigenvalue in the genuine full Hilbert eigenbasis has the derived negative separation. -/
theorem textbookBrownianGibbsEigenbasis_eigenvalue_gap
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) (hj : j.1 ≠ 0) :
    j.1 ≤ -textbookBrownianGibbsCoercivityRate m U hU hPU β := by
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsEigenbasis_mem_graph m hm U hU hPU β hβ j)
  apply textbookBrownianGibbsClosedOperator_real_eigenvalue_bound m hm U hU hPU β hβ a
  · rw [ha]
    exact eigenbasis_ne_zero m hm U hU hPU β hβ j
  · exact hj
  · rw [ha]
    exact hAa

/-- Actual unconditional eigenfunction expansion of every vector in the entire original Gibbs Hilbert space. -/
theorem textbookBrownianGibbsEigenbasis_hasSum (x : Gibbs U β) :
    HasSum (fun j ↦ ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ •
      textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j) x := by
  simpa only [HilbertBasis.repr_apply_apply] using
    (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).hasSum_repr x

/-- True Parseval identity for the whole original generator Hilbert eigenbasis. -/
theorem textbookBrownianGibbsEigenbasis_parseval (x : Gibbs U β) :
    ∑' j, ⟪textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j, x⟫_ℝ ^ 2 = ‖x‖ ^ 2 := by
  simpa only [pow_two, real_inner_comm, real_inner_self_eq_norm_sq] using
    (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).tsum_inner_mul_inner x x

end
end MolecularDynamics
