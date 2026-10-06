import MolecularDynamics.Chapter06.LangevinNoiseHigherMoments

/-! True physical Hamiltonian power drift for the same actual original Langevin transition kernel. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem energy_power_dominated (V W a A S : ℝ) (l : ℕ)
    (hV : 0 ≤ V) (hW : 0 ≤ W) (ha : 0 ≤ a) (hA : 0 ≤ A) (hS : 0 ≤ S)
    (h : V ≤ a * W + A + (3 / 2 : ℝ) * S) :
    V ^ l ≤ 2 ^ (l - 1) * a ^ l * W ^ l +
      (2 ^ (l - 1)) ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * S ^ l) := by
  have hAS : 0 ≤ A + (3 / 2 : ℝ) * S := by positivity
  have hC : 0 ≤ (2 : ℝ) ^ (l - 1) := by positivity
  calc
    _ ≤ (a * W + (A + (3 / 2 : ℝ) * S)) ^ l := pow_le_pow_left₀ hV (by linarith) l
    _ ≤ 2 ^ (l - 1) * ((a * W) ^ l + (A + (3 / 2 : ℝ) * S) ^ l) :=
      add_pow_le (mul_nonneg ha hW) hAS l
    _ ≤ 2 ^ (l - 1) * ((a * W) ^ l +
        2 ^ (l - 1) * (A ^ l + ((3 / 2 : ℝ) * S) ^ l)) :=
      mul_le_mul_of_nonneg_left (add_le_add le_rfl
        (add_pow_le hA (by positivity) l)) hC
    _ = _ := by rw [mul_pow, mul_pow]; ring

private theorem half_power_coefficient (a : ℝ) (ha : 0 ≤ a) (haSmall : a ≤ 1 / 4)
    (l : ℕ) (hl : 1 ≤ l) :
    2 ^ (l - 1) * a ^ l ≤ (1 / 2 : ℝ) := by
  cases l with
  | zero => omega
  | succ n =>
    have h2a : 2 * a ≤ (1 : ℝ) := by linarith
    have hp : (2 * a) ^ n ≤ 1 := pow_le_one₀ (by positivity) h2a
    calc
      _ = (2 * a) ^ n * a := by simp only [Nat.succ_sub_one, pow_succ, mul_pow]; ring
      _ ≤ 1 * a := mul_le_mul_of_nonneg_right hp ha
      _ ≤ _ := by linarith

/-- A genuine pathwise physical Hamiltonian bound holds for the same all-time process, uniformly in its initial state, with a true force and potential remainder. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_path_bound_ae
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ A : ℝ, 0 ≤ A ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ T : ℝ, 0 ≤ T →
      textbookLangevinPeriodicHamiltonianPower U 1
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ≤
        3 * Real.exp (-γ * T) ^ 2 * textbookLangevinPeriodicHamiltonianPower U 1 x + A +
        (3 / 2 : ℝ) * (∑ i : Fin N,
          textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) := by
  obtain ⟨M, _, hM⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_bound_ae
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨Q, hQ0, hQ⟩ := textbookUnitPeriodicPotential_bound U hU.continuous hp
  let A := 3 * (N : ℝ) * (M / γ) ^ 2 / 2 + Q
  have hA : 0 ≤ A := by dsimp only [A]; positivity
  refine ⟨A, hA, fun x ↦ ?_⟩
  filter_upwards [hM x] with sample hs
  intro T hT
  let Y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample
  have hkin := hs T hT
  have hU0 : 0 ≤ U (textbookLangevinPeriodicRepresentative x.1) := le_trans (by norm_num) (hLower _)
  have hUQ : U (textbookLangevinPeriodicRepresentative Y.1) ≤ Q :=
    (le_abs_self _).trans (by simpa only [Real.norm_eq_abs] using hQ _)
  simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower,
    textbookLangevinHamiltonian, pow_one]
  calc
    _ ≤ (3 * Real.exp (-γ * T) ^ 2 * (∑ i : Fin N, x.2 i ^ 2) +
        3 * (N : ℝ) * (M / γ) ^ 2 +
        3 * (∑ i : Fin N, textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2)) / 2 + Q :=
      add_le_add (div_le_div_of_nonneg_right hkin (by norm_num)) hUQ
    _ = 3 * Real.exp (-γ * T) ^ 2 * ((∑ i : Fin N, x.2 i ^ 2) / 2) + A +
        (3 / 2 : ℝ) * (∑ i : Fin N, textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) := by
      dsimp only [A]
      ring
    _ ≤ _ := add_le_add (add_le_add
      (mul_le_mul_of_nonneg_left (le_add_of_nonneg_right hU0) (by positivity)) le_rfl) le_rfl


private theorem physical_power_as_first_power {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (l : ℕ) (z : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicHamiltonianPower U l z =
      textbookLangevinPeriodicHamiltonianPower U 1 z ^ l := by
  simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower, pow_one]

/-- Each genuine original H^l has a true finite-time process expectation drift; the remainder is derived from the actual noise law. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_expectation_bound
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (l : ℕ) (hl : 1 ≤ l) :
    ∃ D : ℝ, 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
      (∫ sample, textbookLangevinPeriodicHamiltonianPower U l
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ∂P) ≤
      2 ^ (l - 1) * (3 * Real.exp (-γ * T) ^ 2) ^ l *
        textbookLangevinPeriodicHamiltonianPower U l x + D := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨A, hA0, hA⟩ := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_path_bound_ae
    B P hB U hU hp hLower L hF γ σ hγ
  let C : ℝ := 2 ^ (l - 1)
  let a : ℝ := 3 * Real.exp (-γ * T) ^ 2
  let S := fun sample ↦ ∑ i : Fin N,
    textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2
  let J := fun sample ↦ S sample ^ l
  have hJ : Integrable J P := textbookLangevinDampedNoise_physical_energy_power_integrable
    B P hB γ σ T hγ.le hT l hl
  have hJ0 : 0 ≤ ∫ sample, J sample ∂P :=
    integral_nonneg (fun sample ↦ pow_nonneg (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) l)
  let D : ℝ := C ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * ∫ sample, J sample ∂P) + 1
  have hD : 0 < D := by dsimp only [D]; positivity
  refine ⟨D, hD, fun x ↦ ?_⟩
  let Y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T
  have hE : Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U l (Y sample)) P :=
    textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_integrable B P hB U hU hp hLower L hF γ σ T hγ hT x l hl
  have hR : Integrable (fun sample ↦ A ^ l + (3 / 2 : ℝ) ^ l * J sample) P :=
    (integrable_const (A ^ l)).add (hJ.const_mul ((3 / 2 : ℝ) ^ l))
  have hd : Integrable (fun sample ↦ C * a ^ l * textbookLangevinPeriodicHamiltonianPower U l x +
      C ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * J sample)) P :=
    (integrable_const _).add (hR.const_mul (C ^ 2))
  have hb : ∀ᵐ sample ∂P, textbookLangevinPeriodicHamiltonianPower U l (Y sample) ≤
      C * a ^ l * textbookLangevinPeriodicHamiltonianPower U l x +
        C ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * J sample) := by
    filter_upwards [hA x] with sample hs
    have hS0 : 0 ≤ S sample := Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)
    have hp := energy_power_dominated
      (textbookLangevinPeriodicHamiltonianPower U 1 (Y sample))
      (textbookLangevinPeriodicHamiltonianPower U 1 x) a A (S sample) l
      (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 (Y sample)).le
      (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 x).le
      (by dsimp only [a]; positivity) hA0 hS0 (hs T hT)
    simpa only [← physical_power_as_first_power, C, J] using hp
  calc
    _ ≤ ∫ sample, C * a ^ l * textbookLangevinPeriodicHamiltonianPower U l x +
        C ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * J sample) ∂P :=
      integral_mono_ae hE hd hb
    _ = C * a ^ l * textbookLangevinPeriodicHamiltonianPower U l x +
        C ^ 2 * (A ^ l + (3 / 2 : ℝ) ^ l * ∫ sample, J sample ∂P) := by
      rw [integral_add (integrable_const _) (hR.const_mul (C ^ 2)), integral_const_mul (C ^ 2),
        integral_add (integrable_const (A ^ l)) (hJ.const_mul ((3 / 2 : ℝ) ^ l)), integral_const_mul ((3 / 2 : ℝ) ^ l)]
      simp
    _ ≤ _ := by dsimp only [D, C, a]; linarith

/-- The actual original kernel power expectation is exactly the same genuine all-time process expectation. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_expectation
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) (l : ℕ) :
    (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) =
    ∫ sample, textbookLangevinPeriodicHamiltonianPower U l
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ∂P := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact integral_map
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)
    (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l).aestronglyMeasurable

/-- The same true kernel has a genuine finite-time physical H^l expectation drift, derived without a moment or drift assumption. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_expectation_bound
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (T : ℝ≥0) (l : ℕ) (hl : 1 ≤ l) :
    ∃ D : ℝ, 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
      (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
      2 ^ (l - 1) * (3 * Real.exp (-γ * T) ^ 2) ^ l *
        textbookLangevinPeriodicHamiltonianPower U l x + D := by
  obtain ⟨D, hD, h⟩ := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_power_expectation_bound
    B P hB U hU hp hLower L hF γ σ T hγ T.property l hl
  refine ⟨D, hD, fun x ↦ ?_⟩
  rw [textbookLangevinPeriodicTransitionKernel_hamiltonian_power_actual_expectation B P hB U hU hp L hF γ σ T x l]
  exact h x

/-- One derived positive time threshold works for all required powers l and all larger kernel times; each finite remainder is uniform over initial phase. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_large_time_drift
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ (l : ℕ), 1 ≤ l → ∀ T : ℝ≥0, τ ≤ T →
      ∃ D : ℝ, 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
        (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
          ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
          (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D := by
  let t : ℝ := Real.log 6 / γ
  have ht : 0 < t := div_pos (Real.log_pos (by norm_num)) hγ
  let τ : ℝ≥0 := ⟨t, ht.le⟩
  have he : γ * (τ : ℝ) = Real.log 6 := by
    change γ * (Real.log 6 / γ) = _
    field_simp
  refine ⟨τ, ht, fun l hl T hT ↦ ?_⟩
  have hprod : Real.log 6 ≤ γ * (T : ℝ) := by
    rw [← he]
    exact mul_le_mul_of_nonneg_left hT hγ.le
  have hexp : Real.exp (-γ * (T : ℝ)) ≤ (1 / 6 : ℝ) := by
    calc
      _ ≤ Real.exp (-Real.log 6) := Real.exp_le_exp.mpr (by linarith)
      _ = _ := by rw [Real.exp_neg, Real.exp_log (by norm_num)]; norm_num
  let a : ℝ := 3 * Real.exp (-γ * (T : ℝ)) ^ 2
  have ha0 : 0 ≤ a := by dsimp only [a]; positivity
  have haSmall : a ≤ 1 / 4 := by
    have hs : Real.exp (-γ * (T : ℝ)) ^ 2 ≤ (1 / 6 : ℝ) ^ 2 :=
      (sq_le_sq₀ (Real.exp_pos _).le (by norm_num)).mpr hexp
    dsimp only [a]
    nlinarith
  have hc := half_power_coefficient a ha0 haSmall l hl
  obtain ⟨D, hD, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_expectation_bound
    B P hB U hU hp hLower L hF γ σ hγ T l hl
  refine ⟨D, hD, fun x ↦ ?_⟩
  exact (h x).trans (add_le_add
    (mul_le_mul_of_nonneg_right hc (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le) le_rfl)

/-- The same actual positive skeleton time can be used for every original Hamiltonian power, with derived finite constants for each l. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_common_skeleton_drift
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ (l : ℕ), 1 ≤ l →
      ∃ D : ℝ, 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
        (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
          ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
          (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_large_time_drift
    B P hB U hU hp hLower L hF γ σ hγ
  exact ⟨τ, hτ, fun l hl ↦ h l hl τ le_rfl⟩

/-- The original positive proper H^l and actual kernel drift are assembled on one common derived skeleton time, as necessary input for the remaining Harris argument. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_lyapunov
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ (l : ℕ), 1 ≤ l →
      Continuous (textbookLangevinPeriodicHamiltonianPower U l) ∧
      (∀ x, 0 < textbookLangevinPeriodicHamiltonianPower U l x) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase N)) atTop ∧
      ∃ D : ℝ, 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
        (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
          ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
          (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_common_skeleton_drift
    B P hB U hU hp hLower L hF γ σ hγ
  exact ⟨τ, hτ, fun l hl ↦
    ⟨textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l,
      textbookLangevinPeriodicHamiltonianPower_pos U hLower l,
      textbookLangevinPeriodicHamiltonianPower_tendsto_atTop U hU hp hLower l hl,
      h l hl⟩⟩

end
end MolecularDynamics
