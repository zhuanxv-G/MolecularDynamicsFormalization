import MolecularDynamics.Chapter03.ModifiedHamiltonianBounds
import MolecularDynamics.Chapter02.OneStepConvergence

/-!
# Actual finite energy drift

Printed115--116/PDF137--138: the actual numerical iterates telescope.
Conservation is derived from the genuine modified Hamiltonian ODE, and
compact C¹ bounds control drift by the sum of actual endpoint defects.
The final rate is explicitly conditional on a uniform flow defect;
constructing that defect for the numerical method remains separate.
-/

open Set
open scoped BigOperators

namespace MolecularDynamics

/-- The exact energy change of the actual one-step iterates is their
finite sum of successive energy changes, including n=0. -/
theorem oneStep_energy_telescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀ := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    ring

private theorem energy_drift_le_endpoint_defects {E : Type*} [NormedAddCommGroup E]
    (K : E → ℝ) (G : ℝ → E → E) (F : E → E) (h : ℝ) (z₀ : E)
    (B : Set E) (L : ℝ)
    (hLip : ∀ u ∈ B, ∀ v ∈ B, ‖K v - K u‖ ≤ L * ‖v - u‖)
    (hF : ∀ z ∈ B, F z ∈ B) (hcons : ∀ z ∈ B, K (F z) = K z)
    (n : ℕ) (hnum : ∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) :
    ‖K (oneStepIterate G h z₀ n) - K z₀‖ ≤
      L * ∑ i ∈ Finset.range n,
        ‖G h (oneStepIterate G h z₀ i) - F (oneStepIterate G h z₀ i)‖ := by
  calc
    ‖K (oneStepIterate G h z₀ n) - K z₀‖ =
        ‖∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
          K (oneStepIterate G h z₀ i))‖ :=
      congrArg norm (oneStep_energy_telescoping K G h z₀ n).symm
    _ ≤ ∑ i ∈ Finset.range n, ‖K (oneStepIterate G h z₀ (i + 1)) -
        K (oneStepIterate G h z₀ i)‖ := norm_sum_le _ _
    _ ≤ ∑ i ∈ Finset.range n, L *
        ‖G h (oneStepIterate G h z₀ i) - F (oneStepIterate G h z₀ i)‖ := by
      apply Finset.sum_le_sum
      intro i hi
      have hin : i < n := Finset.mem_range.mp hi
      have hiB := hnum i (by omega)
      have hnextB : G h (oneStepIterate G h z₀ i) ∈ B := by
        simpa only [oneStepIterate_succ] using hnum (i + 1) (by omega)
      rw [oneStepIterate_succ, ← hcons _ hiB]
      exact hLip _ (hF _ hiB) _ hnextB
    _ = L * ∑ i ∈ Finset.range n,
        ‖G h (oneStepIterate G h z₀ i) - F (oneStepIterate G h z₀ i)‖ :=
      (Finset.mul_sum _ _ _).symm

section Hamiltonian

variable {Nc : ℕ}

/-- Actual modified Hamiltonian ODE data and compact C¹ regularity yield
uniform energy control by actual numerical/flow endpoint distances.
No conservation or local accuracy estimate is supplied. -/
theorem textbook_energy_drift_le_actual_defects
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
            γ h (oneStepIterate G h z₀ i) h‖ := by
  obtain ⟨C, hCp, hC⟩ := exists_uniform_textbookTruncatedHamiltonian_remainder
    H Hj r k B hB (fun j hj => ((hHj j hj).continuousOn).mono hBD)
  obtain ⟨L, hLp, hL⟩ := exists_uniform_textbookTruncatedHamiltonian_lipschitz
    H Hj r k D B hD hB hconv hBD hH hHj
  refine ⟨C, hCp, L, hLp, ?_⟩
  intro h hh z₀ n hnum
  let K := textbookTruncatedHamiltonian H Hj r k h
  have hK : ContDiffOn ℝ 1 K D :=
    contDiffOn_textbookTruncatedHamiltonian H Hj r k h D hH hHj
  have hcons : ∀ z ∈ B, K (γ h z h) = K z := by
    intro z hz
    have hc := textbookHamiltonian_energy_const_on_Icc K (γ h z) h
      (fun t ht => (hK.differentiableOn_one _ (hBD (hγB h hh z hz t ht))).differentiableAt
        (hD.mem_nhds (hBD (hγB h hh z hz t ht)))) (hγ h hh z hz)
    simpa only [hγ₀ h hh z hz] using hc h ⟨hh.1, le_rfl⟩
  have hmiddle := energy_drift_le_endpoint_defects K G (fun z => γ h z h) h z₀ B L
    (hL h hh) (fun z hz => hγB h hh z hz h ⟨hh.1, le_rfl⟩) hcons n hnum
  have hend : ‖H (oneStepIterate G h z₀ n) - K (oneStepIterate G h z₀ n)‖ ≤ C * h ^ r := by
    rw [norm_sub_rev]
    exact hC h hh _ (hnum n le_rfl)
  have hstart : ‖K z₀ - H z₀‖ ≤ C * h ^ r := by
    exact hC h hh z₀ (by simpa only [oneStepIterate_zero] using hnum 0 (Nat.zero_le n))
  have heq : H (oneStepIterate G h z₀ n) - H z₀ =
      (H (oneStepIterate G h z₀ n) - K (oneStepIterate G h z₀ n) +
        (K (oneStepIterate G h z₀ n) - K z₀)) + (K z₀ - H z₀) := by ring
  rw [heq]
  calc
    ‖_‖ ≤ (‖H (oneStepIterate G h z₀ n) - K (oneStepIterate G h z₀ n)‖ +
        ‖K (oneStepIterate G h z₀ n) - K z₀‖) + ‖K z₀ - H z₀‖ :=
      (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ (C * h ^ r + L * ∑ i ∈ Finset.range n,
        ‖G h (oneStepIterate G h z₀ i) - γ h (oneStepIterate G h z₀ i) h‖) + C * h ^ r :=
      add_le_add (add_le_add hend hmiddle) hstart
    _ = _ := by ring

/-- The textbook long-time scale uses a positive power, avoiding ambiguity
about negative natural exponents. -/
theorem energy_step_count_power_factor (r k n : ℕ) (hrk : r ≤ k) (h : ℝ) :
    (n : ℝ) * h ^ (k + 1) = ((n : ℝ) * h * h ^ (k - r)) * h ^ r := by
  have he : k + 1 = 1 + (k - r) + r := by omega
  rw [he, pow_add, pow_add, pow_one]
  ring

/-- Conditional rate once actual numerical/modified-flow matching is proved.
The preceding defect-sum theorem does not require this matching condition. -/
theorem textbook_energy_drift_rate_of_flow_defect
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (hrk : r ≤ k) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t)
    (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T)
    (hdefect : ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z - γ h z h‖ ≤ A * h ^ (k + 1)) :
    ∃ M : ℝ, 0 < M ∧ ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
      (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
      (n : ℝ) * h * h ^ (k - r) ≤ T →
      ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ M * h ^ r := by
  obtain ⟨C, hCp, L, hLp, hbound⟩ := textbook_energy_drift_le_actual_defects
    H Hj r k D B hD hB hconv hBD hH hHj G γ hγ₀ hγB hγ
  let M := 1 + 2 * C + L * A * T
  refine ⟨M, by dsimp [M]; positivity, ?_⟩
  intro h hh z₀ n hnum hscale
  have hsum : ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
      γ h (oneStepIterate G h z₀ i) h‖ ≤ (n : ℝ) * A * h ^ (k + 1) := by
    calc
      _ ≤ ∑ _i ∈ Finset.range n, A * h ^ (k + 1) := by
        apply Finset.sum_le_sum
        intro i hi
        exact hdefect h hh _ (hnum i (Nat.le_of_lt (Finset.mem_range.mp hi)))
      _ = _ := by simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]; ring
  have hscale' : (n : ℝ) * h ^ (k + 1) ≤ T * h ^ r := by
    rw [energy_step_count_power_factor r k n hrk h]
    exact mul_le_mul_of_nonneg_right hscale (pow_nonneg hh.1.le r)
  calc
    _ ≤ 2 * C * h ^ r + L * ∑ i ∈ Finset.range n,
        ‖G h (oneStepIterate G h z₀ i) - γ h (oneStepIterate G h z₀ i) h‖ :=
      hbound h ⟨hh.1.le, hh.2⟩ z₀ n hnum
    _ ≤ 2 * C * h ^ r + L * ((n : ℝ) * A * h ^ (k + 1)) :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_left hsum hLp.le)
    _ = 2 * C * h ^ r + (L * A) * ((n : ℝ) * h ^ (k + 1)) := by ring
    _ ≤ 2 * C * h ^ r + (L * A) * (T * h ^ r) :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_left hscale' (mul_nonneg hLp.le hA))
    _ ≤ M * h ^ r := by dsimp [M]; nlinarith [pow_nonneg hh.1.le r]

end Hamiltonian

end MolecularDynamics
