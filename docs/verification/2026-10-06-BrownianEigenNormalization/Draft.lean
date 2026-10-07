import MolecularDynamics.Chapter06.BrownianGibbsComplexSpectrum

/-! Ordered entire original Gibbs eigenbases with the literal textbook constant first vector. -/

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

private abbrev oneVector : Gibbs U β :=
  textbookPeriodicSmoothEmbedding U hU hPU β (textbookPeriodicSmoothConstant Nc 1)
private abbrev oldBasis (hNc : 0 < Nc) :=
  textbookBrownianGibbsOrderedNatEigenbasis m hm U hU hPU β hβ hNc
private abbrev enumeration (hNc : 0 < Nc) :=
  textbookBrownianGibbsOrderedEigenEnumeration m hm U hU hPU β hβ hNc

/-- The actual sign of the chosen first real eigenvector, measured against the original normalized constant. -/
def textbookBrownianGibbsOrderedEigenPhase (hNc : 0 < Nc) : ℝ :=
  ⟪oneVector U hU hPU β, oldBasis m hm U hU hPU β hβ hNc 0⟫_ℝ

include hm hβ in
private theorem first_eq_phase_one (hNc : 0 < Nc) :
    oldBasis m hm U hU hPU β hβ hNc 0 =
      textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc • oneVector U hU hPU β := by
  have hg := textbookBrownianGibbsOrderedNatEigenbasis_mem_graph m hm U hU hPU β hβ hNc 0
  rw [textbookBrownianGibbsOrderedEigenEnumeration_zero, zero_smul] at hg
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp hg
  change (a : Gibbs U β) = oldBasis m hm U hU hPU β hβ hNc 0 at ha
  change textbookBrownianGibbsClosedOperator m U hU hPU β a = 0 at hAa
  have h := textbookBrownianGibbsClosedOperator_kernel_constant m hm U hU hPU β hβ a hAa
  rw [ha] at h
  exact h

include hm hβ in
/-- The actual sign has square one, derived from the genuine normalized zero eigenspace. -/
theorem textbookBrownianGibbsOrderedEigenPhase_mul_self (hNc : 0 < Nc) :
    textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc *
      textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc = 1 := by
  have hn : ⟪oldBasis m hm U hU hPU β hβ hNc 0,
      oldBasis m hm U hU hPU β hβ hNc 0⟫_ℝ = 1 := by
    rw [real_inner_self_eq_norm_sq, (oldBasis m hm U hU hPU β hβ hNc).orthonormal.norm_eq_one]
    norm_num
  rw [first_eq_phase_one m hm U hU hPU β hβ hNc,
    real_inner_smul_left, real_inner_smul_right, real_inner_self_eq_norm_sq,
    textbookPeriodicSmoothEmbedding_one_norm] at hn
  simpa only [one_pow, mul_one] using hn

private theorem normalized_orthonormal (hNc : 0 < Nc) :
    Orthonormal ℝ (fun n : ℕ ↦ textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc •
      oldBasis m hm U hU hPU β hβ hNc n) := by
  classical
  rw [orthonormal_iff_ite]
  intro i j
  rw [real_inner_smul_left, real_inner_smul_right,
    orthonormal_iff_ite.mp (oldBasis m hm U hU hPU β hβ hNc).orthonormal]
  split_ifs
  · simpa only [mul_one] using textbookBrownianGibbsOrderedEigenPhase_mul_self m hm U hU hPU β hβ hNc
  · ring

/-- The entire real Gibbs eigenbasis has the original ordered values and multiplicities and a derived common sign making the first vector exactly one. -/
def textbookBrownianGibbsNormalizedOrderedEigenbasis (hNc : 0 < Nc) : HilbertBasis ℕ ℝ (Gibbs U β) := by
  let b := oldBasis m hm U hU hPU β hβ hNc
  let r := textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc
  let v := fun n : ℕ ↦ r • b n
  have hr : r * r = 1 := textbookBrownianGibbsOrderedEigenPhase_mul_self m hm U hU hPU β hβ hNc
  have hs : Submodule.span ℝ (Set.range b) ≤ Submodule.span ℝ (Set.range v) := by
    apply Submodule.span_le.mpr
    rintro _ ⟨n, rfl⟩
    have he : r • v n = b n := by
      change r • (r • b n) = b n
      rw [smul_smul, hr, one_smul]
    rw [← he]
    exact (Submodule.span ℝ (Set.range v)).smul_mem r (Submodule.subset_span ⟨n, rfl⟩)
  exact HilbertBasis.mk (normalized_orthonormal m hm U hU hPU β hβ hNc)
    (b.dense_span.ge.trans (Submodule.topologicalClosure_mono hs))

/-- Every normalized ordered vector is the actual old ordered eigenvector multiplied by the proved sign. -/
theorem textbookBrownianGibbsNormalizedOrderedEigenbasis_apply (hNc : 0 < Nc) (n : ℕ) :
    textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n =
      textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc •
        oldBasis m hm U hU hPU β hβ hNc n := by
  simp only [textbookBrownianGibbsNormalizedOrderedEigenbasis, HilbertBasis.coe_mk]

include hm hβ in
/-- The literal first original normalized ordered eigenfunction is the original constant one vector, with its phase fixed. -/
theorem textbookBrownianGibbsNormalizedOrderedEigenbasis_zero (hNc : 0 < Nc) :
    textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc 0 =
      oneVector U hU hPU β := by
  rw [textbookBrownianGibbsNormalizedOrderedEigenbasis_apply,
    first_eq_phase_one m hm U hU hPU β hβ hNc, smul_smul,
    textbookBrownianGibbsOrderedEigenPhase_mul_self, one_smul]

include hm hβ in
/-- The actual first eigenfunction has a representative equal to the literal textbook constant one almost everywhere. -/
theorem textbookBrownianGibbsNormalizedOrderedEigenbasis_zero_ae (hNc : 0 < Nc) :
    (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc 0 :
      UnitAddTorus (Fin Nc) → ℝ) =ᵐ[textbookConfigurationTorusGibbsMeasure U β] fun _ ↦ 1 := by
  rw [textbookBrownianGibbsNormalizedOrderedEigenbasis_zero]
  exact textbookPeriodicSmoothEmbedding_one_ae_eq U hU hPU β

/-- The phase-normalized ordered basis retains the actual original generator graph and its exact ordered eigenvalues. -/
theorem textbookBrownianGibbsNormalizedOrderedEigenbasis_mem_graph (hNc : 0 < Nc) (n : ℕ) :
    (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n,
      (enumeration m hm U hU hPU β hβ hNc n).1 •
        textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n) ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  let r := textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc
  have h := (textbookBrownianGibbsClosedOperator m U hU hPU β).graph.smul_mem r
    (textbookBrownianGibbsOrderedNatEigenbasis_mem_graph m hm U hU hPU β hβ hNc n)
  change (r • oldBasis m hm U hU hPU β hβ hNc n,
      r • ((enumeration m hm U hU hPU β hβ hNc n).1 • oldBasis m hm U hU hPU β hβ hNc n)) ∈
        (textbookBrownianGibbsClosedOperator m U hU hPU β).graph at h
  rw [smul_comm r (enumeration m hm U hU hPU β hβ hNc n).1
    (oldBasis m hm U hU hPU β hβ hNc n)] at h
  rw [textbookBrownianGibbsNormalizedOrderedEigenbasis_apply]
  exact h

/-- Every entire real Gibbs vector is reconstructed by the actual complete phase-normalized ordered basis. -/
theorem textbookBrownianGibbsNormalizedOrderedEigenbasis_hasSum (hNc : 0 < Nc) (x : Gibbs U β) :
    HasSum (fun n : ℕ ↦ ⟪textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ •
      textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n) x := by
  simpa only [HilbertBasis.repr_apply_apply] using
    (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc).hasSum_repr x

/-- The actual original evolution has its full textbook ordered exponential expansion with the first basis vector exactly one. No SDE-law identification is assumed. -/
theorem textbookBrownianGibbsSpectralEvolution_normalized_ordered_hasSum
    (hNc : 0 < Nc) (t : NNReal) (x : Gibbs U β) :
    HasSum (fun n : ℕ ↦
      (Real.exp ((enumeration m hm U hU hPU β hβ hNc n).1 * (t : ℝ)) *
        ⟪textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ) •
        textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n)
      (textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x) := by
  have h := textbookBrownianGibbsSpectralEvolution_ordered_hasSum m hm U hU hPU β hβ hNc t x
  apply h.congr_fun
  intro n
  rw [textbookBrownianGibbsNormalizedOrderedEigenbasis_apply, real_inner_smul_left, smul_smul]
  congr 1
  let r := textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc
  have hr : r * r = 1 := textbookBrownianGibbsOrderedEigenPhase_mul_self m hm U hU hPU β hβ hNc
  let a := Real.exp ((enumeration m hm U hU hPU β hβ hNc n).1 * (t : ℝ))
  let c := ⟪oldBasis m hm U hU hPU β hβ hNc n, x⟫_ℝ
  change (a * (r * c)) * r = a * c
  calc
    (a * (r * c)) * r = a * c * (r * r) := by ring
    _ = a * c := by rw [hr, mul_one]

/-- Literal phase-normalized textbook ordered series equality for the true entire Gibbs Hilbert evolution. -/
theorem textbookBrownianGibbsSpectralEvolution_normalized_ordered_tsum
    (hNc : 0 < Nc) (t : NNReal) (x : Gibbs U β) :
    textbookBrownianGibbsSpectralEvolution m hm U hU hPU β hβ t x =
      ∑' n : ℕ,
        (Real.exp ((enumeration m hm U hU hPU β hβ hNc n).1 * (t : ℝ)) *
          ⟪textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n, x⟫_ℝ) •
          textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n :=
  (textbookBrownianGibbsSpectralEvolution_normalized_ordered_hasSum m hm U hU hPU β hβ hNc t x).tsum_eq.symm

private theorem normalized_complex_orthonormal (hNc : 0 < Nc) :
    Orthonormal ℂ (fun n : ℕ ↦ textbookBrownianGibbsL2Complexify U β
      (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n)) := by
  classical
  rw [orthonormal_iff_ite]
  intro i j
  rw [textbookBrownianGibbsL2Complexify_inner,
    orthonormal_iff_ite.mp (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc).orthonormal]
  split_ifs <;> simp

/-- The same complete normalized original real modes form an entire ordered complex Gibbs Hilbert basis, with every actual multiplicity. -/
def textbookBrownianGibbsNormalizedComplexOrderedEigenbasis (hNc : 0 < Nc) :
    HilbertBasis ℕ ℂ (GibbsComplex U β) := by
  let b := textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ
  let e := enumeration m hm U hU hPU β hβ hNc
  let J := textbookBrownianGibbsL2Complexify U β
  let r := textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc
  let v := fun n : ℕ ↦ J (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n)
  have hr : r * r = 1 := textbookBrownianGibbsOrderedEigenPhase_mul_self m hm U hU hPU β hβ hNc
  have hv (n : ℕ) : (r : ℂ) • v n = b (e n) := by
    rw [← Complex.coe_algebraMap, algebraMap_smul]
    change r • J (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n) = b (e n)
    rw [← map_smul, textbookBrownianGibbsNormalizedOrderedEigenbasis_apply,
      smul_smul, hr, one_smul, textbookBrownianGibbsOrderedNatEigenbasis_apply,
      textbookBrownianGibbsComplexEigenbasis_apply]
  have hs : Submodule.span ℂ (Set.range b) ≤ Submodule.span ℂ (Set.range v) := by
    apply Submodule.span_le.mpr
    rintro _ ⟨j, rfl⟩
    obtain ⟨n, rfl⟩ := e.surjective j
    rw [← hv]
    exact (Submodule.span ℂ (Set.range v)).smul_mem (r : ℂ) (Submodule.subset_span ⟨n, rfl⟩)
  exact HilbertBasis.mk (normalized_complex_orthonormal m hm U hU hPU β hβ hNc)
    (b.dense_span.ge.trans (Submodule.topologicalClosure_mono hs))

/-- Each actual normalized complex vector is literally the complex embedding of the phase-normalized original real eigenfunction. -/
theorem textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_apply (hNc : 0 < Nc) (n : ℕ) :
    textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc n =
      textbookBrownianGibbsL2Complexify U β
        (textbookBrownianGibbsNormalizedOrderedEigenbasis m hm U hU hPU β hβ hNc n) := by
  simp only [textbookBrownianGibbsNormalizedComplexOrderedEigenbasis, HilbertBasis.coe_mk]

include hm hβ in
/-- The first genuine complex eigenfunction is exactly the embedded original constant one. -/
theorem textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_zero (hNc : 0 < Nc) :
    textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc 0 =
      textbookBrownianGibbsL2Complexify U β (oneVector U hU hPU β) := by
  rw [textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_apply,
    textbookBrownianGibbsNormalizedOrderedEigenbasis_zero]

include hm hβ in
/-- Its actual representative is literally complex one almost everywhere for the original same Gibbs measure. -/
theorem textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_zero_ae (hNc : 0 < Nc) :
    (textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc 0 :
      UnitAddTorus (Fin Nc) → ℂ) =ᵐ[textbookConfigurationTorusGibbsMeasure U β] fun _ ↦ 1 := by
  rw [textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_zero]
  filter_upwards [textbookBrownianGibbsL2Complexify_ae U β (oneVector U hU hPU β),
    textbookPeriodicSmoothEmbedding_one_ae_eq U hU hPU β] with Q hJ hQ
  rw [hJ, hQ, Complex.ofReal_one]

private theorem complex_phase_apply (hNc : 0 < Nc) (n : ℕ) :
    textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc n =
      (textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc : ℂ) •
        textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ
          (enumeration m hm U hU hPU β hβ hNc n) := by
  rw [textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_apply,
    textbookBrownianGibbsNormalizedOrderedEigenbasis_apply, map_smul,
    ← algebraMap_smul ℂ, textbookBrownianGibbsOrderedNatEigenbasis_apply,
    textbookBrownianGibbsComplexEigenbasis_apply, Complex.coe_algebraMap]

/-- Every normalized ordered complex mode belongs to the true original complex generator graph at its exact original ordered eigenvalue. -/
theorem textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_mem_graph (hNc : 0 < Nc) (n : ℕ) :
    (textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc n,
      ((enumeration m hm U hU hPU β hβ hNc n).1 : ℂ) •
        textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc n) ∈
      (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph := by
  let r : ℂ := textbookBrownianGibbsOrderedEigenPhase m hm U hU hPU β hβ hNc
  have h := (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph.smul_mem r
    (textbookBrownianGibbsComplexEigenbasis_mem_graph m hm U hU hPU β hβ
      (enumeration m hm U hU hPU β hβ hNc n))
  let b := textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ
  let j := enumeration m hm U hU hPU β hβ hNc n
  change (r • b j, r • ((j.1 : ℂ) • b j)) ∈
    (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ).graph at h
  rw [smul_comm r (j.1 : ℂ) (b j)] at h
  rw [complex_phase_apply m hm U hU hPU β hβ hNc n]
  exact h

/-- Every entire complex Gibbs vector has an actual full expansion in the normalized ordered original eigenbasis. -/
theorem textbookBrownianGibbsNormalizedComplexOrderedEigenbasis_hasSum (hNc : 0 < Nc) (z : GibbsComplex U β) :
    HasSum (fun n : ℕ ↦
      ⟪textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc n, z⟫_ℂ •
        textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc n) z := by
  simpa only [HilbertBasis.repr_apply_apply] using
    (textbookBrownianGibbsNormalizedComplexOrderedEigenbasis m hm U hU hPU β hβ hNc).hasSum_repr z

/-- The entire actual complex spectrum is exactly the complex embedding of the true ordered original eigenvalue sequence, retaining the genuine multiplicities in the basis. -/
theorem textbookBrownianGibbsGeneratorComplexSpectrum_eq_ordered_sequence_range (hNc : 0 < Nc) :
    textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ =
      Set.range (fun n : ℕ ↦ ((enumeration m hm U hU hPU β hβ hNc n).1 : ℂ)) := by
  rw [textbookBrownianGibbsGeneratorComplexSpectrum_eq_real_image m hm U hU hPU β hβ,
    textbookBrownianGibbsGeneratorRealSpectrum_eq_ordered_sequence_range m hm U hU hPU β hβ hNc,
    ← Set.range_comp]
  simp only [Function.comp_def, enumeration]

end
end MolecularDynamics
