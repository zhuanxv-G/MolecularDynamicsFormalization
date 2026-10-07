import MolecularDynamics.Chapter06.LangevinHarrisOscillation
import Mathlib.Analysis.SpecificLimits.Normed

/-! Genuine weighted skeleton convergence and invariant-law uniqueness dependencies for original Theorem 6.2. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem invariantKernel_integral_of_integrable {N : ℕ}
    (K : Kernel (textbookLangevinPeriodicPhase N) (textbookLangevinPeriodicPhase N)) [IsMarkovKernel K]
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : K ∘ₘ (μ : Measure (textbookLangevinPeriodicPhase N)) = μ)
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : Integrable f (μ : Measure (textbookLangevinPeriodicPhase N))) :
    (∫ x, ∫ y, f y ∂K x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
      ∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N)) := by
  have hc : Integrable f ((K ∘ₖ Kernel.const Unit (μ : Measure (textbookLangevinPeriodicPhase N))) ()) := by
    rw [← Measure.comp_eq_comp_const_apply, hInv]
    exact hf
  have he := Kernel.integral_comp hc
  rw [← Measure.comp_eq_comp_const_apply, hInv] at he
  exact he.symm

private theorem actualHamiltonianPower_one_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hLower : ∀ q, 1 ≤ U q) (l : ℕ)
    (x : textbookLangevinPeriodicPhase N) :
    1 ≤ textbookLangevinPeriodicHamiltonianPower U l x := by
  have hkin : 0 ≤ ∑ i : Fin N, x.2 i ^ 2 := Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)
  have hH : 1 ≤ (∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1) := by
    linarith [hLower (textbookLangevinPeriodicRepresentative x.1)]
  change 1 ≤ ((∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1)) ^ l
  simpa only [one_pow] using pow_le_pow_left₀ (by norm_num : (0 : ℝ) ≤ 1) hH l

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
private theorem actualSkeleton_oscillation_iterate
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (τ : ℝ≥0) (l : ℕ) (hl : 1 ≤ l)
    (β a : ℝ) (ha : 0 ≤ a)
    (hstep : ∀ (g : textbookLangevinPeriodicPhase N → ℝ) (A : ℝ), Measurable g → 0 ≤ A →
      textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β g A →
      (∀ x, Integrable g (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x)) ∧
        Measurable (fun x ↦ ∫ y, g y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ∧
        textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
          (fun x ↦ ∫ y, g y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) (a * A))
    (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ) (hf : Measurable f) (hC : 0 ≤ C)
    (hosc : textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C) :
    (∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
      Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x)) ∧
    ∀ n : ℕ, Measurable (fun x ↦ ∫ y, f y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) ∧
      textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
        (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x)
        (a ^ n * C) := by
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ
  let V := textbookLangevinPeriodicHamiltonianPower U l
  let F := fun (n : ℕ) (x : textbookLangevinPeriodicPhase N) ↦ ∫ y, f y ∂K ((n : ℝ≥0) * τ) x
  have hfK (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) : Integrable f (K T x) := by
    have : IsMarkovKernel (K T) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
    let μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) := ⟨K T x, inferInstance⟩
    exact textbookLangevinWeightedOscillationBound_integrable V β f C hf hosc μ
      (textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ hγ T x l hl)
  have hFm (n : ℕ) : Measurable (F n) := hf.stronglyMeasurable.integral_kernel.measurable
  have hF0 (x : textbookLangevinPeriodicPhase N) : F 0 x = f x := by
    dsimp only [F, K]
    rw [Nat.cast_zero, zero_mul, textbookLangevinPeriodicTransitionKernel_zero B P hB U hU hp L hF γ σ,
      Kernel.id_apply, integral_dirac]
  have hFsucc (n : ℕ) (x : textbookLangevinPeriodicPhase N) :
      F (n + 1) x = ∫ y, F n y ∂K τ x := by
    let S : ℝ≥0 := (n : ℝ≥0) * τ
    have : IsMarkovKernel (K S) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
    have : IsMarkovKernel (K τ) := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ τ
    have ht : ((n + 1 : ℕ) : ℝ≥0) * τ = S + τ := by dsimp only [S]; push_cast; ring
    have hCK : K (S + τ) = K S ∘ₖ K τ := by
      rw [add_comm S τ]
      exact textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ τ S
    have hi : Integrable f ((K S ∘ₖ K τ) x) := by rw [← hCK]; exact hfK (S + τ) x
    change (∫ y, f y ∂K (((n + 1 : ℕ) : ℝ≥0) * τ) x) = _
    rw [ht, hCK]
    exact Kernel.integral_comp hi
  refine ⟨hfK, fun n ↦ ⟨hFm n, ?_⟩⟩
  change textbookLangevinWeightedOscillationBound V β (F n) (a ^ n * C)
  induction n with
  | zero =>
      intro x y
      rw [hF0 x, hF0 y, pow_zero, one_mul]
      exact hosc x y
  | succ n hn =>
      have hh := hstep (F n) (a ^ n * C) (hFm n) (mul_nonneg (pow_nonneg ha n) hC) hn
      intro x y
      rw [hFsucc n x, hFsucc n y]
      calc
        _ ≤ (a * (a ^ n * C)) * (2 + β * (V x + V y)) := hh.2.2 x y
        _ = _ := by rw [pow_succ]; ring

include hB in
/-- True Chapman–Kolmogorov integrals of the actual kernel iterate the derived strict weighted oscillation factor to a^n for all measurable unbounded weighted observables. -/
theorem textbookLangevinPeriodicDensityClause_hamiltonian_weighted_skeleton_contraction
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
              textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C →
              (∀ (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N),
                Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x)) ∧
              ∀ n : ℕ, Measurable (fun x ↦ ∫ y, f y
                ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) ∧
                textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
                  (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x)
                  (a ^ n * C) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicDensityClause_hamiltonian_weighted_one_step_contraction
    B P hB U hU hp hLower L hF γ σ hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hstep⟩ := hd ρ hρ
  exact ⟨β, hβ, a, ha, ha1, fun f C hf hC hosc ↦
    actualSkeleton_oscillation_iterate B P hB U hU hp L hF γ σ hLower hγ τ l hl β a ha.le hstep f C hf hC hosc⟩

include hB in
/-- The same actual skeleton expectations approach every genuine full-time invariant law with the derived a^n weighted bound; the target invariant-law moment is derived, not assumed. -/
theorem textbookLangevinPeriodicDensityClause_hamiltonian_weighted_skeleton_geometric_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
              (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
                (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
              ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
                textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C →
                ∀ (n : ℕ) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    (a ^ n * C) * (2 + β * (textbookLangevinPeriodicHamiltonianPower U l x +
                      ∫ y, textbookLangevinPeriodicHamiltonianPower U l y
                        ∂(μ : Measure (textbookLangevinPeriodicPhase N)))) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicDensityClause_hamiltonian_weighted_skeleton_contraction
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hi⟩ := hd ρ hρ
  refine ⟨β, hβ, a, ha, ha1, fun μ hμ f C hf hC hosc n x ↦ ?_⟩
  let V := textbookLangevinPeriodicHamiltonianPower U l
  have hVμ : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ
      hLower hγ μ hμ l hl).1
  have hfμ := textbookLangevinWeightedOscillationBound_integrable V β f C hf hosc μ hVμ
  have hiF := hi f C hf hC hosc
  let δ : ProbabilityMeasure (textbookLangevinPeriodicPhase N) := ⟨Measure.dirac x, inferInstance⟩
  have hVδ : Integrable V (δ : Measure (textbookLangevinPeriodicPhase N)) := by
    change Integrable V (Measure.dirac x)
    exact integrable_dirac (by finiteness)
  have hh := textbookLangevinWeightedOscillationBound_integral_difference V β
    (fun z ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) z)
    (a ^ n * C) (hiF.2 n).1 (hiF.2 n).2 δ μ hVδ hVμ
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
  have he := invariantKernel_integral_of_integrable
    (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) μ (hμ _) f hfμ
  have hδeq : (δ : Measure (textbookLangevinPeriodicPhase N)) = Measure.dirac x := rfl
  rw [hδeq, integral_dirac, integral_dirac] at hh
  rw [he] at hh
  exact hh

include hB in
/-- For the original observables |f|≤H^l, one true constant M independent of f, n and the initial phase gives the same actual skeleton's original H^l geometric error bound. -/
theorem textbookLangevinPeriodicDensityClause_original_observable_skeleton_geometric_bound
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
              (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
                (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
              ∃ M : ℝ, 0 < M ∧ ∀ f : textbookLangevinPeriodicPhase N → ℝ, Measurable f →
                (∀ x, |f x| ≤ textbookLangevinPeriodicHamiltonianPower U l x) →
                ∀ (n : ℕ) (x : textbookLangevinPeriodicPhase N),
                  ‖(∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) x) -
                      ∫ y, f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ ≤
                    M * a ^ n * textbookLangevinPeriodicHamiltonianPower U l x := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicDensityClause_hamiltonian_weighted_skeleton_geometric_bound
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR, hd⟩ := h l hl
  refine ⟨D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hg⟩ := hd ρ hρ
  refine ⟨a, ha, ha1, fun μ hμ ↦ ?_⟩
  let V := textbookLangevinPeriodicHamiltonianPower U l
  let A := ∫ y, V y ∂(μ : Measure (textbookLangevinPeriodicPhase N))
  have hA : 0 ≤ A := integral_nonneg (fun x ↦ (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le)
  let M := 2 * β⁻¹ + 1 + A
  have hβinv : 0 ≤ β⁻¹ := inv_nonneg.mpr hβ.le
  have hM : 0 < M := by
    dsimp only [M]
    linarith [mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hβinv]
  have hweight (S : ℝ) : β⁻¹ * (2 + β * S) = 2 * β⁻¹ + S := by
    field_simp [hβ.ne']
  refine ⟨M, hM, fun f hf hdom n x ↦ ?_⟩
  have hosc : textbookLangevinWeightedOscillationBound V β f β⁻¹ := by
    intro y z
    have hh : ‖f y - f z‖ ≤ V y + V z :=
      (norm_sub_le _ _).trans (add_le_add
        (by simpa only [Real.norm_eq_abs] using hdom y) (by simpa only [Real.norm_eq_abs] using hdom z))
    rw [hweight]
    exact hh.trans (le_add_of_nonneg_left (mul_nonneg (by norm_num) hβinv))
  have hh := hg μ hμ f β⁻¹ hf hβinv hosc n x
  have hx1 := actualHamiltonianPower_one_le U hLower l x
  have hm : 2 * β⁻¹ + V x + A ≤ M * V x := by
    have hnonneg : 0 ≤ 2 * β⁻¹ + A := add_nonneg (mul_nonneg (by norm_num) hβinv) hA
    have hs := mul_le_mul_of_nonneg_left hx1 hnonneg
    dsimp only [M]
    nlinarith
  calc
    _ ≤ (a ^ n * β⁻¹) * (2 + β * (V x + A)) := hh
    _ = a ^ n * (2 * β⁻¹ + V x + A) := by rw [mul_assoc, hweight]; ring
    _ ≤ a ^ n * (M * V x) := mul_le_mul_of_nonneg_left hm (pow_nonneg ha.le n)
    _ = _ := by ring

include hB in
/-- The real strict skeleton contraction forces any two genuine full-time invariant probability laws of the same actual original Langevin kernel to agree. No uniqueness conclusion is assumed. -/
theorem textbookLangevinPeriodicDensityClause_invariant_unique
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
      ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
        textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
          {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U 1 z ≤ R} ρ →
        ∀ μ ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
          (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) →
          (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (ν : Measure (textbookLangevinPeriodicPhase N)) = ν) → μ = ν := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicDensityClause_hamiltonian_weighted_skeleton_contraction
    B P hB U hU hp L hF γ σ hLower hγ hσ
  obtain ⟨D, R, hD, hR, hd⟩ := h 1 le_rfl
  refine ⟨τ, hτ, D, R, hD, hR, fun ρ hρ μ ν hμ hν ↦ ?_⟩
  obtain ⟨β, hβ, a, ha, ha1, hi⟩ := hd ρ hρ
  let V := textbookLangevinPeriodicHamiltonianPower U 1
  have hVμ : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ
      hLower hγ μ hμ 1 le_rfl).1
  have hVν : Integrable V (ν : Measure (textbookLangevinPeriodicPhase N)) :=
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ
      hLower hγ ν hν 1 le_rfl).1
  apply (ProbabilityMeasure.toFiniteMeasure_isEmbedding (textbookLangevinPeriodicPhase N)).injective
  apply FiniteMeasure.ext_of_forall_integral_eq
  intro f
  change (∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
    ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))
  have hosc : textbookLangevinWeightedOscillationBound V β f ‖f‖ := by
    intro x y
    have hh : ‖f x - f y‖ ≤ ‖f‖ + ‖f‖ := (norm_sub_le _ _).trans
      (add_le_add (f.norm_coe_le_norm x) (f.norm_coe_le_norm y))
    have hS : 0 ≤ V x + V y := add_nonneg
      (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 x).le
      (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 y).le
    have hn := mul_nonneg (norm_nonneg f) (mul_nonneg hβ.le hS)
    nlinarith
  have hifμ := textbookLangevinWeightedOscillationBound_integrable V β f ‖f‖ f.continuous.measurable hosc μ hVμ
  have hifν := textbookLangevinWeightedOscillationBound_integrable V β f ‖f‖ f.continuous.measurable hosc ν hVν
  have hiF := hi f ‖f‖ f.continuous.measurable (norm_nonneg f) hosc
  have hbound (n : ℕ) :
      ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
          ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ ≤
        a ^ n * ‖f‖ * (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N)))) := by
    have hh := textbookLangevinWeightedOscillationBound_integral_difference V β
      (fun z ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ) z)
      (a ^ n * ‖f‖) (hiF.2 n).1 (hiF.2 n).2 μ ν hVμ hVν
    have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) :=
      textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ _
    have hIμ := invariantKernel_integral_of_integrable
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) μ (hμ _) f hifμ
    have hIν := invariantKernel_integral_of_integrable
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ ((n : ℝ≥0) * τ)) ν (hν _) f hifν
    rw [hIμ, hIν] at hh
    exact hh
  have hzlim : Tendsto (fun n : ℕ ↦ a ^ n * ‖f‖ *
      (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N))))) atTop (𝓝 0) := by
    simpa only [zero_mul] using
      ((tendsto_pow_atTop_nhds_zero_of_lt_one ha.le ha1).mul_const ‖f‖).mul_const
        (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N))))
  have hz : ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
      ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ ≤ 0 :=
    le_of_tendsto_of_tendsto tendsto_const_nhds hzlim (Eventually.of_forall hbound)
  exact sub_eq_zero.mp (norm_eq_zero.mp (le_antisymm hz (norm_nonneg _)))

include hB in
/-- The already constructed genuine actual all-time invariant probability is unique under the original density clause on the actual derived energy set; neither existence nor uniqueness is put into assumptions. -/
theorem textbookLangevinPeriodicDensityClause_invariant_existsUnique
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
      ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
        textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
          {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U 1 z ≤ R} ρ →
        ∃! μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∀ T : ℝ≥0,
          textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
            (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨τ, hτ, D, R, hD, hR, hu⟩ := textbookLangevinPeriodicDensityClause_invariant_unique
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, D, R, hD, hR, fun ρ hρ ↦ ?_⟩
  obtain ⟨μ, hμ⟩ := textbookLangevinPeriodicTransitionKernel_invariant_exists
    B P hB U hU hp L hF γ σ hLower hγ
  exact ⟨μ, hμ, fun ν hν ↦ hu ρ hρ ν μ hν hμ⟩

end
end MolecularDynamics
