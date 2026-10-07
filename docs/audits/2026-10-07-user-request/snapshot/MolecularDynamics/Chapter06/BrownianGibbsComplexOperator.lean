import MolecularDynamics.Chapter06.BrownianGibbsComplexification

/-! Genuine complexification of the entire original Gibbs generator graph.
The graph is proved equivalent to the original real graphs of the actual real and imaginary parts. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)
private abbrev GibbsComplex {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private abbrev cb := textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ
private abbrev rb := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ

/-- The actual complex coordinate is exactly the original real and imaginary Hilbert coordinates. -/
theorem textbookBrownianGibbsComplexEigenbasis_coefficient_re_im
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) (z : GibbsComplex U β) :
    ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ =
      (⟪rb m hm U hU hPU β hβ j, textbookBrownianGibbsL2RealPart U β z⟫_ℝ : ℂ) +
      Complex.I * (⟪rb m hm U hU hPU β hβ j, textbookBrownianGibbsL2ImagPart U β z⟫_ℝ : ℂ) := by
  rw [textbookBrownianGibbsComplexEigenbasis_apply]
  conv_lhs => rw [← textbookBrownianGibbsL2Complexify_decomposition U β z]
  rw [inner_add_right, inner_smul_right,
    textbookBrownianGibbsL2Complexify_inner, textbookBrownianGibbsL2Complexify_inner]

/-- The genuine complex-linear generator graph in the entire same-Gibbs complex Hilbert space. Its equivalence with the actual original real graph is proved below. -/
def textbookBrownianGibbsComplexGraph : Submodule ℂ (GibbsComplex U β × GibbsComplex U β) where
  carrier := {p | ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
    ⟪cb m hm U hU hPU β hβ j, p.2⟫_ℂ =
      (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, p.1⟫_ℂ}
  zero_mem' := by intro j; simp
  add_mem' := by
    intro p q hp hq j
    change ⟪cb m hm U hU hPU β hβ j, p.2 + q.2⟫_ℂ =
      (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, p.1 + q.1⟫_ℂ
    rw [inner_add_right, inner_add_right, hp j, hq j, mul_add]
  smul_mem' := by
    intro c p hp j
    change ⟪cb m hm U hU hPU β hβ j, c • p.2⟫_ℂ =
      (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, c • p.1⟫_ℂ
    rw [inner_smul_right, inner_smul_right, hp j]
    ring

/-- Exact entire complex graph membership in every actual eigenmode coefficient. -/
theorem textbookBrownianGibbsComplexGraph_iff_coefficients (z w : GibbsComplex U β) :
    (z, w) ∈ textbookBrownianGibbsComplexGraph m hm U hU hPU β hβ ↔
      ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
        ⟪cb m hm U hU hPU β hβ j, w⟫_ℂ =
          (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ := Iff.rfl

/-- The constructed whole complex graph is precisely the true original real graph in both actual real and imaginary components. -/
theorem textbookBrownianGibbsComplexGraph_iff_real_imag (z w : GibbsComplex U β) :
    (z, w) ∈ textbookBrownianGibbsComplexGraph m hm U hU hPU β hβ ↔
      (textbookBrownianGibbsL2RealPart U β z, textbookBrownianGibbsL2RealPart U β w) ∈
          (textbookBrownianGibbsClosedOperator m U hU hPU β).graph ∧
      (textbookBrownianGibbsL2ImagPart U β z, textbookBrownianGibbsL2ImagPart U β w) ∈
          (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  rw [textbookBrownianGibbsComplexGraph_iff_coefficients,
    textbookBrownianGibbsClosedOperator_graph_iff_coefficients m hm U hU hPU β hβ,
    textbookBrownianGibbsClosedOperator_graph_iff_coefficients m hm U hU hPU β hβ]
  constructor
  · intro h
    constructor
    · intro j
      have hj := h j
      rw [textbookBrownianGibbsComplexEigenbasis_coefficient_re_im,
        textbookBrownianGibbsComplexEigenbasis_coefficient_re_im] at hj
      have hr := congrArg Complex.re hj
      simpa using hr
    · intro j
      have hj := h j
      rw [textbookBrownianGibbsComplexEigenbasis_coefficient_re_im,
        textbookBrownianGibbsComplexEigenbasis_coefficient_re_im] at hj
      have hi := congrArg Complex.im hj
      simpa using hi
  · rintro ⟨hr, hi⟩ j
    rw [textbookBrownianGibbsComplexEigenbasis_coefficient_re_im,
      textbookBrownianGibbsComplexEigenbasis_coefficient_re_im, hr j, hi j]
    push_cast
    ring

/-- No nonzero entire complex vector can appear over zero in the genuine graph, by actual complete basis coefficients. -/
theorem textbookBrownianGibbsComplexGraph_vertical_zero
    (p : GibbsComplex U β × GibbsComplex U β)
    (hp : p ∈ textbookBrownianGibbsComplexGraph m hm U hU hPU β hβ) (h0 : p.1 = 0) :
    p.2 = 0 := by
  let b := cb m hm U hU hPU β hβ
  apply b.repr.injective
  apply Subtype.ext
  funext j
  change b.repr p.2 j = b.repr 0 j
  rw [b.repr_apply_apply, b.repr_apply_apply, inner_zero_right]
  have hj := hp j
  rw [h0, inner_zero_right, mul_zero] at hj
  exact hj

/-- The actual whole complex Gibbs generator is the partial complex-linear map of the genuine graph, with vertical uniqueness proved rather than assumed. -/
def textbookBrownianGibbsComplexOperator : GibbsComplex U β →ₗ.[ℂ] GibbsComplex U β :=
  (textbookBrownianGibbsComplexGraph m hm U hU hPU β hβ).toLinearPMap

/-- The actual partial complex operator's graph equals the genuine complexification graph. -/
theorem textbookBrownianGibbsComplexOperator_graph :
    (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph =
      textbookBrownianGibbsComplexGraph m hm U hU hPU β hβ :=
  Submodule.toLinearPMap_graph_eq _ (textbookBrownianGibbsComplexGraph_vertical_zero m hm U hU hPU β hβ)

/-- The actual whole complex operator has exactly the true complete eigenvalue-weighted graph coefficients. -/
theorem textbookBrownianGibbsComplexOperator_graph_iff_coefficients (z w : GibbsComplex U β) :
    (z, w) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph ↔
      ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
        ⟪cb m hm U hU hPU β hβ j, w⟫_ℂ =
          (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ := by
  rw [textbookBrownianGibbsComplexOperator_graph,
    textbookBrownianGibbsComplexGraph_iff_coefficients]

/-- The actual complex operator is genuinely the original real operator on actual real and imaginary components. -/
theorem textbookBrownianGibbsComplexOperator_graph_iff_real_imag (z w : GibbsComplex U β) :
    (z, w) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph ↔
      (textbookBrownianGibbsL2RealPart U β z, textbookBrownianGibbsL2RealPart U β w) ∈
          (textbookBrownianGibbsClosedOperator m U hU hPU β).graph ∧
      (textbookBrownianGibbsL2ImagPart U β z, textbookBrownianGibbsL2ImagPart U β w) ∈
          (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  rw [textbookBrownianGibbsComplexOperator_graph, textbookBrownianGibbsComplexGraph_iff_real_imag]

/-- The actual whole complexification graph is closed in the genuine original Gibbs Hilbert product. -/
theorem textbookBrownianGibbsComplexGraph_isClosed :
    IsClosed (textbookBrownianGibbsComplexGraph m hm U hU hPU β hβ :
      Set (GibbsComplex U β × GibbsComplex U β)) := by
  change IsClosed {p : GibbsComplex U β × GibbsComplex U β | ∀ j : textbookBrownianGibbsEigenIndex m U hU hPU β,
    ⟪cb m hm U hU hPU β hβ j, p.2⟫_ℂ = (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, p.1⟫_ℂ}
  simp only [Set.ofPred_forall]
  refine isClosed_iInter fun j ↦ isClosed_eq ?_ ?_
  · fun_prop
  · fun_prop

/-- The actual original complex Gibbs generator is genuinely closed on its whole true domain. -/
theorem textbookBrownianGibbsComplexOperator_isClosed :
    (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).IsClosed := by
  change IsClosed ((textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph :
    Set (GibbsComplex U β × GibbsComplex U β))
  rw [textbookBrownianGibbsComplexOperator_graph]
  exact textbookBrownianGibbsComplexGraph_isClosed m hm U hU hPU β hβ

/-- Every actual complete complex basis mode satisfies the true complex original generator graph at its original real eigenvalue. -/
theorem textbookBrownianGibbsComplexEigenbasis_mem_graph
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    (cb m hm U hU hPU β hβ j, (j.1 : ℂ) • cb m hm U hU hPU β hβ j) ∈
      (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph := by
  classical
  rw [textbookBrownianGibbsComplexOperator_graph_iff_coefficients]
  intro i
  rw [inner_smul_right, orthonormal_iff_ite.mp (cb m hm U hU hPU β hβ).orthonormal]
  by_cases h : i = j
  · subst i
    simp
  · simp [h]

/-- The actual entire complex generator domain is precisely its actual square-summable weighted complete-basis coefficients. -/
theorem textbookBrownianGibbsComplexOperator_domain_iff_coefficients (z : GibbsComplex U β) :
    z ∈ (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).domain ↔
      Memℓp (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦
        (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, z⟫_ℂ) 2 := by
  let A := textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ
  let b := cb m hm U hU hPU β hβ
  constructor
  · intro hz
    let a : A.domain := ⟨z, hz⟩
    let w := A a
    have hg : (z, w) ∈ A.graph := (LinearPMap.mem_graph_iff _).mpr ⟨a, rfl, rfl⟩
    have he : (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ (j.1 : ℂ) * ⟪b j, z⟫_ℂ) =
        fun j ↦ b.repr w j := by
      funext j
      rw [HilbertBasis.repr_apply_apply]
      exact ((textbookBrownianGibbsComplexOperator_graph_iff_coefficients
        m hm U hU hPU β hβ z w).mp hg j).symm
    rw [he]
    exact lp.memℓp (b.repr w)
  · intro hz
    let a : lp (fun _ : textbookBrownianGibbsEigenIndex m U hU hPU β ↦ ℂ) 2 :=
      ⟨fun j ↦ (j.1 : ℂ) * ⟪b j, z⟫_ℂ, hz⟩
    let w := b.repr.symm a
    have hc : ∀ j, ⟪b j, w⟫_ℂ = (j.1 : ℂ) * ⟪b j, z⟫_ℂ := by
      intro j
      rw [← HilbertBasis.repr_apply_apply]
      change b.repr (b.repr.symm a) j = _
      rw [b.repr.apply_symm_apply]
    have hg := (textbookBrownianGibbsComplexOperator_graph_iff_coefficients
      m hm U hU hPU β hβ z w).mpr hc
    exact LinearPMap.mem_domain_of_mem_graph hg

/-- Every actual complex generator output has precisely the original eigenvalue-weighted actual complex coordinates. -/
theorem textbookBrownianGibbsComplexOperator_apply_coefficient
    (z : (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).domain)
    (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    ⟪cb m hm U hU hPU β hβ j, textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ z⟫_ℂ =
      (j.1 : ℂ) * ⟪cb m hm U hU hPU β hβ j, (z : GibbsComplex U β)⟫_ℂ :=
  (textbookBrownianGibbsComplexOperator_graph_iff_coefficients m hm U hU hPU β hβ _ _).mp
    (LinearPMap.mem_graph _ z) j

/-- The genuine entire complex generator has a dense true domain, because it contains every mode of the actual complete complex Hilbert basis. -/
theorem textbookBrownianGibbsComplexOperator_dense :
    Dense ((textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).domain :
      Set (GibbsComplex U β)) := by
  let A := textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ
  let b := cb m hm U hU hPU β hβ
  have hs : Submodule.span ℂ (Set.range b) ≤ A.domain := by
    apply Submodule.span_le.mpr
    rintro _ ⟨j, rfl⟩
    exact LinearPMap.mem_domain_of_mem_graph
      (textbookBrownianGibbsComplexEigenbasis_mem_graph m hm U hU hPU β hβ j)
  apply Submodule.dense_iff_topologicalClosure_eq_top.mpr
  apply top_le_iff.mp
  rw [← b.dense_span]
  exact Submodule.topologicalClosure_mono hs

/-- The genuine original complex operator is its own formal adjoint on its whole true complex domain, by actual complete basis pairings. -/
theorem textbookBrownianGibbsComplexOperator_formalAdjoint :
    (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).IsFormalAdjoint
      (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  intro x y
  let A := textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ
  let b := cb m hm U hU hPU β hβ
  have hx := b.tsum_inner_mul_inner (A x) (y : GibbsComplex U β)
  have hy := b.tsum_inner_mul_inner (x : GibbsComplex U β) (A y)
  change ⟪A x, (y : GibbsComplex U β)⟫_ℂ = ⟪(x : GibbsComplex U β), A y⟫_ℂ
  rw [← hx, ← hy]
  congr 1
  funext j
  have hc := congrArg (starRingEnd ℂ)
    (textbookBrownianGibbsComplexOperator_apply_coefficient m hm U hU hPU β hβ x j)
  have hl : ⟪A x, b j⟫_ℂ = (j.1 : ℂ) * ⟪(x : GibbsComplex U β), b j⟫_ℂ := by
    simpa only [map_mul, inner_conj_symm, Complex.conj_ofReal] using hc
  rw [hl, textbookBrownianGibbsComplexOperator_apply_coefficient]
  ring

/-- The actual whole same-Gibbs complexification is truly self-adjoint, including equality of full adjoint domains. -/
theorem textbookBrownianGibbsComplexOperator_isSelfAdjoint :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  let A := textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ
  have hd := textbookBrownianGibbsComplexOperator_dense m hm U hU hPU β hβ
  have hf := LinearPMap.adjoint_isFormalAdjoint hd
  rw [LinearPMap.isSelfAdjoint_def]
  apply le_antisymm
  · apply LinearPMap.le_of_le_graph
    intro p hp
    obtain ⟨x, hx, hAx⟩ := (LinearPMap.mem_graph_iff _).mp hp
    change (x : GibbsComplex U β) = p.1 at hx
    change A.adjoint x = p.2 at hAx
    apply (textbookBrownianGibbsComplexOperator_graph_iff_coefficients
      m hm U hU hPU β hβ p.1 p.2).mpr
    intro j
    obtain ⟨y, hy, hAy⟩ := (LinearPMap.mem_graph_iff _).mp
      (textbookBrownianGibbsComplexEigenbasis_mem_graph m hm U hU hPU β hβ j)
    change (y : GibbsComplex U β) = cb m hm U hU hPU β hβ j at hy
    change A y = (j.1 : ℂ) • cb m hm U hU hPU β hβ j at hAy
    have h := hf.symm y x
    change ⟪A y, (x : GibbsComplex U β)⟫_ℂ =
      ⟪(y : GibbsComplex U β), A.adjoint x⟫_ℂ at h
    rw [hy, hAy, hx, hAx, inner_smul_left] at h
    simp only [Complex.conj_ofReal] at h
    exact h.symm
  · exact (textbookBrownianGibbsComplexOperator_formalAdjoint m hm U hU hPU β hβ).le_adjoint hd

end
end MolecularDynamics