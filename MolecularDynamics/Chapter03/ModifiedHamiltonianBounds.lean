import MolecularDynamics.Chapter03.LiePoisson
import Mathlib.Order.Interval.Finset.Nat

/-!
# Uniform bounds for an actual finite modified Hamiltonian

Printed114--115/PDF136--137, equation (3.11) and Theorem3.1's proof.
The finite truncation is literal.  Compactness and actual C¹ derivatives
produce constants uniform in the small step size, rather than supplied bounds.
The numerical method's high-order matching remains a separate dependency.
-/

open Set Filter
open scoped BigOperators Topology

namespace MolecularDynamics

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- The actual finite Hamiltonian H+Σ_{j=r}^k h^j H_j. -/
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z

theorem contDiffOn_textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ContDiffOn ℝ 1 (textbookTruncatedHamiltonian H Hj r k h) D := by
  exact hH.add (ContDiffOn.sum fun j hj => ContDiffOn.const_smul (h ^ j) (hHj j hj))

omit [NormedSpace ℝ E] in
private theorem exists_pos_bound_finite_compact {F : Type*} [NormedAddCommGroup F]
    (s : Finset ℕ) (B : Set E) (hB : IsCompact B) (g : ℕ → E → F)
    (hg : ∀ i ∈ s, ContinuousOn (g i) B) :
    ∃ M : ℝ, 0 < M ∧ ∀ i ∈ s, ∀ z ∈ B, ‖g i z‖ ≤ M := by
  classical
  revert hg
  induction s using Finset.induction_on with
  | empty =>
    intro hg
    exact ⟨1, zero_lt_one, by simp⟩
  | insert i s _ ih =>
    intro hg
    obtain ⟨M, hMp, hMb⟩ := ih (fun j hj => hg j (Finset.mem_insert_of_mem hj))
    obtain ⟨A, hA⟩ := hB.bddAbove_image ((hg i (Finset.mem_insert_self i s)).norm)
    refine ⟨max A M, lt_of_lt_of_le hMp (le_max_right _ _), ?_⟩
    intro j hj z hz
    rcases Finset.mem_insert.mp hj with rfl | hjs
    · exact (hA ⟨z, hz, rfl⟩).trans (le_max_left _ _)
    · exact (hMb j hjs z hz).trans (le_max_right _ _)

/-- The actual compact C¹ derivative yields a positive Lipschitz constant
on the convex set; it is not supplied as an extra smoothness premise. -/
theorem exists_compact_C1_lipschitz_constant (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (H : E → ℝ) (hH : ContDiffOn ℝ 1 H D) :
    ∃ L : ℝ, 0 < L ∧ ∀ u ∈ B, ∀ v ∈ B, ‖H v - H u‖ ≤ L * ‖v - u‖ := by
  obtain ⟨A, hA⟩ := hB.bddAbove_image
    (((hH.continuousOn_fderiv_of_isOpen hD (by rfl)).mono hBD).norm)
  let L := max A 1
  refine ⟨L, lt_of_lt_of_le zero_lt_one (le_max_right _ _), ?_⟩
  intro u hu v hv
  exact hconv.norm_image_sub_le_of_norm_fderiv_le
    (fun z hz => (hH.differentiableOn_one z (hBD hz)).differentiableAt
      (hD.mem_nhds (hBD hz)))
    (fun z hz => (hA ⟨z, hz, rfl⟩).trans (le_max_left _ _)) hu hv

omit [NormedSpace ℝ E] in
/-- The full truncation remainder has a positive bound uniform in h and z. -/
theorem exists_uniform_textbookTruncatedHamiltonian_remainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r := by
  obtain ⟨M, hMp, hMb⟩ := exists_pos_bound_finite_compact (Finset.Icc r k) B hB Hj hHj
  refine ⟨1 + ((Finset.Icc r k).card : ℝ) * M, by positivity, ?_⟩
  intro h hh z hz
  have hpow : ∀ j ∈ Finset.Icc r k, h ^ j ≤ h ^ r := by
    intro j hj
    obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le (Finset.mem_Icc.mp hj).1
    rw [pow_add]
    exact mul_le_of_le_one_right (pow_nonneg hh.1 r) (pow_le_one₀ hh.1 hh.2)
  have heq : textbookTruncatedHamiltonian H Hj r k h z - H z =
      ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z := by
    simp [textbookTruncatedHamiltonian]
  rw [heq]
  calc
    ‖∑ j ∈ Finset.Icc r k, h ^ j * Hj j z‖ ≤
        ∑ j ∈ Finset.Icc r k, ‖h ^ j * Hj j z‖ := norm_sum_le _ _
    _ ≤ ∑ j ∈ Finset.Icc r k, h ^ r * M := by
      apply Finset.sum_le_sum
      intro j hj
      rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hh.1 j)]
      exact mul_le_mul (hpow j hj) (hMb j hj z hz) (norm_nonneg _) (pow_nonneg hh.1 r)
    _ = ((Finset.Icc r k).card : ℝ) * M * h ^ r := by
      simp only [Finset.sum_const, nsmul_eq_mul]
      ring
    _ ≤ (1 + ((Finset.Icc r k).card : ℝ) * M) * h ^ r := by
      nlinarith [pow_nonneg hh.1 r]

omit [NormedSpace ℝ E] in
/-- The original O(h^r) is an actual right-hand asymptotic remainder along
any specified points staying in the compact set. -/
theorem textbookTruncatedHamiltonian_difference_isBigO
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B)
    (z : ℝ → E) (hz : ∀ h ∈ Icc (0 : ℝ) 1, z h ∈ B) :
    Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
      (fun h => textbookTruncatedHamiltonian H Hj r k h (z h) - H (z h))
      (fun h : ℝ => h ^ r) := by
  obtain ⟨C, _, hC⟩ := exists_uniform_textbookTruncatedHamiltonian_remainder H Hj r k B hB hHj
  apply Asymptotics.IsBigO.of_bound C
  filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < 1 by norm_num)] with h hh
  simpa only [Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hh.1.le r)] using
    hC h ⟨hh.1.le, hh.2.le⟩ (z h) (hz h ⟨hh.1.le, hh.2.le⟩)

/-- One Lipschitz constant works for the entire actual truncated family
0≤h≤1, including all endpoints. -/
theorem exists_uniform_textbookTruncatedHamiltonian_lipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖ := by
  obtain ⟨L₀, hL₀p, hL₀⟩ := exists_compact_C1_lipschitz_constant D B hD hB hconv hBD H hH
  have hfd : ∀ j ∈ Finset.Icc r k, ContinuousOn (fderiv ℝ (Hj j)) B := by
    intro j hj
    exact ((hHj j hj).continuousOn_fderiv_of_isOpen hD (by rfl)).mono hBD
  obtain ⟨M, hMp, hMb⟩ := exists_pos_bound_finite_compact (Finset.Icc r k) B hB
    (fun j => fderiv ℝ (Hj j)) hfd
  have hcoef : ∀ j ∈ Finset.Icc r k, ∀ u ∈ B, ∀ v ∈ B,
      ‖Hj j v - Hj j u‖ ≤ M * ‖v - u‖ := by
    intro j hj u hu v hv
    exact hconv.norm_image_sub_le_of_norm_fderiv_le
      (fun z hz => ((hHj j hj).differentiableOn_one z (hBD hz)).differentiableAt
        (hD.mem_nhds (hBD hz))) (hMb j hj) hu hv
  refine ⟨L₀ + ((Finset.Icc r k).card : ℝ) * M, by positivity, ?_⟩
  intro h hh u hu v hv
  have heq : textbookTruncatedHamiltonian H Hj r k h v -
      textbookTruncatedHamiltonian H Hj r k h u = H v - H u +
      ∑ j ∈ Finset.Icc r k, h ^ j * (Hj j v - Hj j u) := by
    simp only [textbookTruncatedHamiltonian, mul_sub, Finset.sum_sub_distrib]
    ring
  rw [heq]
  calc
    ‖H v - H u + ∑ j ∈ Finset.Icc r k, h ^ j * (Hj j v - Hj j u)‖ ≤
        ‖H v - H u‖ + ‖∑ j ∈ Finset.Icc r k, h ^ j * (Hj j v - Hj j u)‖ := norm_add_le _ _
    _ ≤ L₀ * ‖v - u‖ + ∑ j ∈ Finset.Icc r k, ‖h ^ j * (Hj j v - Hj j u)‖ :=
      add_le_add (hL₀ u hu v hv) (norm_sum_le _ _)
    _ ≤ L₀ * ‖v - u‖ + ∑ j ∈ Finset.Icc r k, M * ‖v - u‖ := by
      apply add_le_add_right
      apply Finset.sum_le_sum
      intro j hj
      rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hh.1 j)]
      simpa only [one_mul] using mul_le_mul (pow_le_one₀ hh.1 hh.2)
        (hcoef j hj u hu v hv) (norm_nonneg _) (show (0 : ℝ) ≤ 1 by norm_num)
    _ = (L₀ + ((Finset.Icc r k).card : ℝ) * M) * ‖v - u‖ := by
      simp only [Finset.sum_const, nsmul_eq_mul]
      ring

end MolecularDynamics
