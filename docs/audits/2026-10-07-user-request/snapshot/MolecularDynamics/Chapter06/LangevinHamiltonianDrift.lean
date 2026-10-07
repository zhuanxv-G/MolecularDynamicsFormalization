import MolecularDynamics.Chapter06.LangevinNoiseMoments
import MolecularDynamics.Chapter06.LangevinPeriodicLyapunov
import MolecularDynamics.Chapter06.LangevinTransitionKernel

/-! Physical Hamiltonian drift dependencies for the same actual Langevin process. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private theorem triple_square (a b c : ℝ) :
    (a + b + c) ^ 2 ≤ 3 * a ^ 2 + 3 * b ^ 2 + 3 * c ^ 2 := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (a - c), sq_nonneg (b - c)]

private theorem coordinate_square_bound {N : ℕ} (v : Fin N → ℝ)
    (M : ℝ) (hM : 0 ≤ M) (hv : ‖v‖ ≤ M) (i : Fin N) :
    v i ^ 2 ≤ M ^ 2 := by
  have hs : ‖v i‖ ^ 2 ≤ M ^ 2 :=
    (sq_le_sq₀ (norm_nonneg _) hM).mpr ((norm_le_pi_norm v i).trans hv)
  simpa only [Real.norm_eq_abs, sq_abs] using hs

/-- The genuine coordinate square sum keeps the damped physical initial kinetic energy, instead of replacing it by a sup norm. -/
theorem textbookLangevinMomentum_sum_squares_le {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (γ σ T : ℝ) (hγ : 0 < γ) (x : textbookLangevinPhase N)
    (W q p : ℝ → (Fin N → ℝ))
    (h : textbookLangevinIntegralSolution U γ σ T x W q p)
    (M : ℝ) (hM0 : 0 ≤ M) (hM : ∀ z, ‖textbookPotentialForce U z‖ ≤ M)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    (∑ i : Fin N, p t i ^ 2) ≤
      3 * Real.exp (-γ * t) ^ 2 * (∑ i : Fin N, x.2 i ^ 2) +
      3 * (N : ℝ) * (M / γ) ^ 2 +
      3 * (∑ i : Fin N, textbookLangevinDampedNoise γ σ W t i ^ 2) := by
  let F := ∫ s in 0..t, Real.exp (-γ * (t - s)) • textbookPotentialForce U (q s)
  have hF : ‖F‖ ≤ M / γ :=
    textbookLangevinMomentum_force_convolution_uniform_bound U hU γ t M hγ ht.1 hM0 hM q
      (h.1.mono (Icc_subset_Icc le_rfl ht.2))
  have he := textbookLangevinMomentum_duhamel U hU γ σ T x W q p h t ht
  change p t = Real.exp (-γ * t) • x.2 + F + textbookLangevinDampedNoise γ σ W t at he
  calc
    _ ≤ ∑ i : Fin N, (3 * Real.exp (-γ * t) ^ 2 * x.2 i ^ 2 +
        3 * (M / γ) ^ 2 + 3 * textbookLangevinDampedNoise γ σ W t i ^ 2) := by
      apply Finset.sum_le_sum
      intro i _
      have hc := coordinate_square_bound F (M / γ) (div_nonneg hM0 hγ.le) hF i
      have hi := triple_square (Real.exp (-γ * t) * x.2 i) (F i)
        (textbookLangevinDampedNoise γ σ W t i)
      rw [he]
      simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
      nlinarith
    _ = _ := by
      simp only [Finset.sum_add_distrib, Finset.mul_sum,
        Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
      ring

/-- One genuine global force constant bounds the physical momentum square sum of the same all-time periodic process on a common full-measure set. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_bound_ae
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x : textbookLangevinPeriodicPhase N, ∀ᵐ sample ∂P,
      ∀ T : ℝ, 0 ≤ T →
      (∑ i : Fin N, (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i ^ 2) ≤
        3 * Real.exp (-γ * T) ^ 2 * (∑ i : Fin N, x.2 i ^ 2) +
        3 * (N : ℝ) * (M / γ) ^ 2 +
        3 * (∑ i : Fin N, textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2) := by
  obtain ⟨M, hM0, hM⟩ := textbookUnitPeriodicPotential_force_bound U hU hp
  refine ⟨M, hM0, fun x ↦ ?_⟩
  filter_upwards [textbookLangevinGlobalRandomPhase_integralSolution_ae B P hB U
    (hU.of_le (by simp)) L hF γ σ (textbookLangevinPeriodicRepresentative x.1, x.2)] with sample hs
  intro T hT
  exact textbookLangevinMomentum_sum_squares_le U (hU.of_le (by simp)) γ σ T hγ
    (textbookLangevinPeriodicRepresentative x.1, x.2) _ _ _ (hs T hT) M hM0 hM T ⟨hT, le_rfl⟩

/-- The physical coordinate square sum of the same true process is integrable, without a supplied moment hypothesis. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ ∑ i : Fin N,
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i ^ 2) P := by
  have hv : MemLp (fun sample ↦
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2) 2 P :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_memLp B P hB U hU hp L hF γ σ T hγ hT x
  have hm : AEMeasurable (fun sample ↦
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2) P :=
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T hT).snd
  apply integrable_finsetSum Finset.univ
  intro i _
  have hi : MemLp (fun sample ↦
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i) 2 P :=
    hv.norm.mono' (hm.eval i).aestronglyMeasurable
      (Eventually.of_forall (fun sample ↦ norm_le_pi_norm _ i))
  exact hi.integrable_sq


/-- The genuine physical Hamiltonian of the same periodic process is integrable at every fixed nonnegative time. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨Q, hQ0, hQ⟩ := textbookUnitPeriodicPotential_bound U hU.continuous hp
  let Y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T
  have hk : Integrable (fun sample ↦ ∑ i : Fin N, (Y sample).2 i ^ 2) P :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_integrable B P hB U hU hp L hF γ σ T hγ hT x
  have hm : AEStronglyMeasurable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U 1 (Y sample)) P :=
    ((textbookLangevinPeriodicHamiltonianPower_continuous U hU hp 1).measurable.comp_aemeasurable
      (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
        (hU.of_le (by simp)) L hF γ σ x T hT)).aestronglyMeasurable
  have hd : Integrable (fun sample ↦ (∑ i : Fin N, (Y sample).2 i ^ 2) / 2 + Q) P :=
    (hk.div_const 2).add (integrable_const Q)
  apply hd.mono hm
  apply Eventually.of_forall
  intro sample
  have hk0 : 0 ≤ (∑ i : Fin N, (Y sample).2 i ^ 2) / 2 :=
    div_nonneg (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) (by norm_num)
  simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower,
    textbookLangevinHamiltonian, pow_one]
  rw [Real.norm_of_nonneg (add_nonneg hk0 hQ0)]
  calc
    _ ≤ ‖(∑ i : Fin N, (Y sample).2 i ^ 2) / 2‖ +
        ‖U (textbookLangevinPeriodicRepresentative (Y sample).1)‖ := norm_add_le _ _
    _ ≤ _ := by
      rw [Real.norm_of_nonneg hk0]
      exact add_le_add le_rfl (hQ _)

/-- The true physical momentum second moment follows by integrating the actual pathwise bound under the original Wiener law. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_secondMoment_bound
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ (x : textbookLangevinPeriodicPhase N) (T : ℝ), 0 ≤ T →
      (∫ sample, (∑ i : Fin N,
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i ^ 2) ∂P) ≤
        3 * Real.exp (-γ * T) ^ 2 * (∑ i : Fin N, x.2 i ^ 2) +
        3 * (N : ℝ) * (M / γ) ^ 2 +
        3 * (N : ℝ) * (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, hM0, hM⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_bound_ae
    B P hB U hU hp L hF γ σ hγ
  refine ⟨M, hM0, fun x T hT ↦ ?_⟩
  let K := 3 * Real.exp (-γ * T) ^ 2 * (∑ i : Fin N, x.2 i ^ 2) +
    3 * (N : ℝ) * (M / γ) ^ 2
  let J := fun sample ↦ ∑ i : Fin N,
    textbookLangevinDampedNoise γ σ (fun s ↦ B s.toNNReal sample) T i ^ 2
  have hj : Integrable J P := textbookLangevinDampedNoise_sum_square_integrable B P hB γ σ T hγ.le hT
  have hd : Integrable (fun sample ↦ K + 3 * J sample) P :=
    (integrable_const K).add (hj.const_mul 3)
  calc
    _ ≤ ∫ sample, K + 3 * J sample ∂P :=
      integral_mono_ae
        (textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_integrable B P hB U hU hp L hF γ σ T hγ hT x)
        hd ((hM x).mono (fun _ h ↦ h T hT))
    _ = K + 3 * ∫ sample, J sample ∂P := by
      rw [integral_add (integrable_const K) (hj.const_mul 3), integral_const_mul]
      simp
    _ ≤ K + 3 * ((N : ℝ) * (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3)) :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_left
        (textbookLangevinDampedNoise_sum_secondMoment_bound B P hB γ σ T hγ.le hT) (by norm_num))
    _ = _ := by dsimp only [K]; ring

/-- A genuine fixed-time physical Hamiltonian drift bound, with a finite remainder derived from the true potential, force and noise moments. -/
theorem textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_expectation_bound
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ T : ℝ) (hγ : 0 < γ) (hT : 0 ≤ T) :
    ∃ D : ℝ, 0 ≤ D ∧ ∀ x : textbookLangevinPeriodicPhase N,
      (∫ sample, textbookLangevinPeriodicHamiltonianPower U 1
        (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ∂P) ≤
      3 * Real.exp (-γ * T) ^ 2 * textbookLangevinPeriodicHamiltonianPower U 1 x + D := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  obtain ⟨M, _, hM⟩ := textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_secondMoment_bound
    B P hB U hU hp L hF γ σ hγ
  obtain ⟨Q, hQ0, hQ⟩ := textbookUnitPeriodicPotential_bound U hU.continuous hp
  let D := (3 * (N : ℝ) * (M / γ) ^ 2 +
    3 * (N : ℝ) * (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3)) / 2 + Q
  have hD : 0 ≤ D := by dsimp only [D]; positivity
  refine ⟨D, hD, fun x ↦ ?_⟩
  let Y := textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T
  have hk : Integrable (fun sample ↦ ∑ i : Fin N, (Y sample).2 i ^ 2) P :=
    textbookLangevinPeriodicGlobalRandomPhase_momentum_sum_squares_integrable B P hB U hU hp L hF γ σ T hγ hT x
  have he : Integrable (fun sample ↦ textbookLangevinPeriodicHamiltonianPower U 1 (Y sample)) P :=
    textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_integrable B P hB U hU hp L hF γ σ T hγ hT x
  have hd : Integrable (fun sample ↦ (∑ i : Fin N, (Y sample).2 i ^ 2) / 2 + Q) P :=
    (hk.div_const 2).add (integrable_const Q)
  have hU0 : 0 ≤ U (textbookLangevinPeriodicRepresentative x.1) := le_trans (by norm_num) (hLower _)
  calc
    _ ≤ ∫ sample, (∑ i : Fin N, (Y sample).2 i ^ 2) / 2 + Q ∂P := by
      apply integral_mono he hd
      intro sample
      simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower,
        textbookLangevinHamiltonian, pow_one]
      exact add_le_add le_rfl ((le_abs_self _).trans (hQ _))
    _ = (∫ sample, (∑ i : Fin N, (Y sample).2 i ^ 2) ∂P) / 2 + Q := by
      rw [integral_add (hk.div_const 2) (integrable_const Q), integral_div]
      simp
    _ ≤ (3 * Real.exp (-γ * T) ^ 2 * (∑ i : Fin N, x.2 i ^ 2) +
        3 * (N : ℝ) * (M / γ) ^ 2 +
        3 * (N : ℝ) * (2 * σ ^ 2 * T + σ ^ 2 * γ ^ 2 * T ^ 3)) / 2 + Q :=
      add_le_add (div_le_div_of_nonneg_right (hM x T hT) (by norm_num)) le_rfl
    _ = 3 * Real.exp (-γ * T) ^ 2 * ((∑ i : Fin N, x.2 i ^ 2) / 2) + D := by
      dsimp only [D]
      ring
    _ ≤ 3 * Real.exp (-γ * T) ^ 2 *
        ((∑ i : Fin N, x.2 i ^ 2) / 2 + U (textbookLangevinPeriodicRepresentative x.1)) + D :=
      add_le_add (mul_le_mul_of_nonneg_left (le_add_of_nonneg_right hU0) (by positivity)) le_rfl
    _ = _ := by
      simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinHamiltonianPower,
        textbookLangevinHamiltonian, pow_one]

/-- The genuine Hamiltonian is integrable under the actual transition law, derived from the same all-time process rather than assumed. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_integrable
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) :
    Integrable (textbookLangevinPeriodicHamiltonianPower U 1)
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact (integrable_map_measure
    (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp 1).aestronglyMeasurable
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)).mpr
    (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_integrable B P hB U hU hp L hF γ σ T hγ T.property x)

/-- The actual kernel Hamiltonian expectation is literally the genuine process expectation. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_actual_expectation
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (T : ℝ≥0) (x : textbookLangevinPeriodicPhase N) :
    (∫ y, textbookLangevinPeriodicHamiltonianPower U 1 y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) =
    ∫ sample, textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample) ∂P := by
  rw [textbookLangevinPeriodicTransitionKernel_global_law B P hB U hU hp L hF γ σ T x]
  exact integral_map
    (textbookLangevinPeriodicGlobalRandomPhase_endpoint_aemeasurable B P hB U
      (hU.of_le (by simp)) L hF γ σ x T T.property)
    (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp 1).aestronglyMeasurable

/-- The true original transition kernel satisfies the derived physical Hamiltonian expectation bound. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_expectation_bound
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (T : ℝ≥0) :
    ∃ D : ℝ, 0 ≤ D ∧ ∀ x : textbookLangevinPeriodicPhase N,
      (∫ y, textbookLangevinPeriodicHamiltonianPower U 1 y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
        3 * Real.exp (-γ * T) ^ 2 * textbookLangevinPeriodicHamiltonianPower U 1 x + D := by
  obtain ⟨D, hD, h⟩ := textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_expectation_bound
    B P hB U hU hp hLower L hF γ σ T hγ T.property
  refine ⟨D, hD, fun x ↦ ?_⟩
  rw [textbookLangevinPeriodicTransitionKernel_hamiltonian_actual_expectation B P hB U hU hp L hF γ σ T x]
  exact h x

/-- A positive real time is derived at which the same actual kernel contracts the physical Hamiltonian by at most one half, with one finite remainder for every initial phase. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_skeleton_drift
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ (T : ℝ≥0) (D : ℝ), 0 < T ∧ 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
      (∫ y, textbookLangevinPeriodicHamiltonianPower U 1 y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
        (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x + D := by
  let t : ℝ := Real.log 6 / γ
  have ht : 0 < t := div_pos (Real.log_pos (by norm_num)) hγ
  let T : ℝ≥0 := ⟨t, ht.le⟩
  have hexp : Real.exp (-γ * (T : ℝ)) = (1 / 6 : ℝ) := by
    have he : -γ * t = -Real.log 6 := by
      dsimp only [t]
      field_simp
    change Real.exp (-γ * t) = _
    rw [he, Real.exp_neg, Real.exp_log (by norm_num)]
    norm_num
  have hc : 3 * Real.exp (-γ * (T : ℝ)) ^ 2 ≤ (1 / 2 : ℝ) := by rw [hexp]; norm_num
  obtain ⟨D, hD, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_expectation_bound
    B P hB U hU hp hLower L hF γ σ hγ T
  refine ⟨T, D + 1, ht, by linarith, fun x ↦ ?_⟩
  calc
    _ ≤ 3 * Real.exp (-γ * (T : ℝ)) ^ 2 * textbookLangevinPeriodicHamiltonianPower U 1 x + D := h x
    _ ≤ (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x + D :=
      add_le_add (mul_le_mul_of_nonneg_right hc
        (textbookLangevinPeriodicHamiltonianPower_pos U hLower 1 x).le) le_rfl
    _ ≤ _ := by linarith

/-- The genuine positive proper Hamiltonian and the actual kernel skeleton drift are assembled, without assuming a density or a drift conclusion. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_skeleton_lyapunov
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) :
    Continuous (textbookLangevinPeriodicHamiltonianPower U 1) ∧
    (∀ x, 0 < textbookLangevinPeriodicHamiltonianPower U 1 x) ∧
    Tendsto (textbookLangevinPeriodicHamiltonianPower U 1) (cocompact (textbookLangevinPeriodicPhase N)) atTop ∧
    ∃ (T : ℝ≥0) (D : ℝ), 0 < T ∧ 0 < D ∧ ∀ x : textbookLangevinPeriodicPhase N,
      (∫ y, textbookLangevinPeriodicHamiltonianPower U 1 y
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
        (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U 1 x + D :=
  ⟨textbookLangevinPeriodicHamiltonianPower_continuous U hU hp 1,
    textbookLangevinPeriodicHamiltonianPower_pos U hLower 1,
    textbookLangevinPeriodicHamiltonianPower_tendsto_atTop U hU hp hLower 1 le_rfl,
    textbookLangevinPeriodicTransitionKernel_hamiltonian_skeleton_drift B P hB U hU hp hLower L hF γ σ hγ⟩

end
end MolecularDynamics
