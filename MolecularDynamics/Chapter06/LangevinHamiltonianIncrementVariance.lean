import MolecularDynamics.Chapter06.LangevinHamiltonianIncrementMoments

/-! Actual second variation of the original periodic Hamiltonian increment. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- The original momentum linear part of the actual Hamiltonian increment. -/
def textbookLangevinPeriodicMomentumLinearIncrement (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) : ℝ :=
  ∑ i : Fin N, x.2 i * ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i)

/-- The actual Hamiltonian increment after subtracting its original momentum linear part. -/
def textbookLangevinPeriodicHamiltonianIncrementResidual (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) : ℝ :=
  textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample -
    textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample

include hB hU hp in
/-- The actual momentum linear Hamiltonian increment belongs to L² without a moment premise. -/
theorem textbookLangevinPeriodicMomentumLinearIncrement_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N) :
    MemLp (textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x) 2 P := by
  change MemLp (fun sample ↦ ∑ i : Fin N, x.2 i * ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i)) 2 P
  exact
    memLp_finsetSum Finset.univ (fun i _ ↦
      (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
        B P hB U hU hp L hF γ σ hγ T hT x i).const_mul (x.2 i))

include hB hU hp in
/-- The actual linear Hamiltonian increment's second moment derivative is
σ² times the original physical momentum energy, from actual coordinate covariance. -/
theorem textbookLangevinPeriodicMomentumLinearIncrement_second_moment_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample ^ 2 ∂P) / T)
      (𝓝[>] 0) (𝓝 (σ ^ 2 * ∑ i : Fin N, x.2 i ^ 2)) := by
  let Δ := fun (t : ℝ) (i : Fin N) (sample : Ω) ↦
    (textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B t sample).2 i - x.2 i
  let E := fun (t : ℝ) (i j : Fin N) ↦
    (x.2 i * x.2 j) * ((∫ sample, Δ t i sample * Δ t j sample ∂P) / t)
  let C := fun (i j : Fin N) ↦ (x.2 i * x.2 j) * (σ ^ 2 * (if i = j then 1 else 0))
  have hE (i j : Fin N) : Tendsto (fun t ↦ E t i j) (𝓝[>] 0) (𝓝 (C i j)) := by
    exact (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_div_time_tendsto
      B P hB U hU hp L hF γ σ hγ x i j).const_mul (x.2 i * x.2 j)
  have hsum := tendsto_finsetSum Finset.univ (fun i _ ↦
    tendsto_finsetSum Finset.univ (fun j _ ↦ hE i j))
  have hC (i : Fin N) : (∑ j : Fin N, C i j) = σ ^ 2 * x.2 i ^ 2 := by
    rw [Finset.sum_eq_single i]
    · dsimp only [C]
      simp only [ite_true, mul_one]
      ring
    · intro j _ hj
      simp only [C, ite_eq_right_iff, mul_eq_zero]
      simp [Ne.symm hj]
    · intro hn
      exact False.elim (hn (Finset.mem_univ i))
  have hCsum : (∑ i : Fin N, ∑ j : Fin N, C i j) = σ ^ 2 * ∑ i : Fin N, x.2 i ^ 2 := by
    simp_rw [hC]
    exact (Finset.mul_sum _ _ _).symm
  rw [hCsum] at hsum
  have he (t : ℝ) (ht : 0 ≤ t) :
      (∫ sample, textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample ^ 2 ∂P) / t =
        ∑ i : Fin N, ∑ j : Fin N, E t i j := by
    have hpI (i j : Fin N) : Integrable (fun sample ↦
        (x.2 i * x.2 j) * (Δ t i sample * Δ t j sample)) P :=
      (textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_integrable
        B P hB U hU hp L hF γ σ hγ t ht x i j).const_mul _
    have hin (i : Fin N) : Integrable (fun sample ↦
        ∑ j : Fin N, (x.2 i * x.2 j) * (Δ t i sample * Δ t j sample)) P :=
      integrable_finsetSum Finset.univ (fun j _ ↦ hpI i j)
    have hiter (i : Fin N) : (∫ sample,
        ∑ j : Fin N, (x.2 i * x.2 j) * (Δ t i sample * Δ t j sample) ∂P) =
        ∑ j : Fin N, (x.2 i * x.2 j) * (∫ sample, Δ t i sample * Δ t j sample ∂P) := by
      rw [integral_finsetSum Finset.univ (fun j _ ↦ hpI i j)]
      simp_rw [integral_const_mul]
    have hfun : (fun sample ↦ textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample ^ 2) =
        (fun sample ↦ ∑ i : Fin N, ∑ j : Fin N, (x.2 i * x.2 j) * (Δ t i sample * Δ t j sample)) := by
      funext sample
      dsimp only [textbookLangevinPeriodicMomentumLinearIncrement, Δ]
      rw [pow_two, Finset.sum_mul]
      simp_rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _
      apply Finset.sum_congr rfl
      intro j _
      ring
    rw [hfun, integral_finsetSum Finset.univ (fun i _ ↦ hin i)]
    simp_rw [hiter]
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro i _
    rw [Finset.sum_div]
    apply Finset.sum_congr rfl
    intro j _
    dsimp only [E]
    ring
  apply hsum.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  exact (he t ht.le).symm

private theorem hamVariance_real_residual_bound {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (M : ℝ≥0) (hU : LipschitzWith M U)
    (z y : textbookLangevinPhase N) :
    ‖textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z -
      (∑ i : Fin N, z.2 i * y.2 i)‖ ≤
      (M : ℝ) * ‖y.1‖ + ((N : ℝ) / 2) * ‖y‖ ^ 2 := by
  have hp : ‖y.2‖ ≤ ‖y‖ := by rw [Prod.norm_def]; exact le_max_right _ _
  have hsq (i : Fin N) : y.2 i ^ 2 ≤ ‖y‖ ^ 2 := by
    have hh := pow_le_pow_left₀ (norm_nonneg (y.2 i)) ((norm_le_pi_norm _ i).trans hp) 2
    simpa only [Real.norm_eq_abs, sq_abs] using hh
  have henergy : (∑ i : Fin N, y.2 i ^ 2) ≤ (N : ℝ) * ‖y‖ ^ 2 := by
    calc
      _ ≤ ∑ _i : Fin N, ‖y‖ ^ 2 := Finset.sum_le_sum (fun i _ ↦ hsq i)
      _ = _ := by simp
  have he0 : 0 ≤ (∑ i : Fin N, y.2 i ^ 2) / 2 :=
    div_nonneg (Finset.sum_nonneg (fun i _ ↦ sq_nonneg _)) (by norm_num)
  have hpot : ‖U (z.1 + y.1) - U z.1‖ ≤ (M : ℝ) * ‖y.1‖ := by
    have hh := hU.dist_le_mul (z.1 + y.1) z.1
    simpa only [dist_eq_norm, add_sub_cancel_left] using hh
  have he : textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z -
        (∑ i : Fin N, z.2 i * y.2 i) =
      (∑ i : Fin N, y.2 i ^ 2) / 2 + (U (z.1 + y.1) - U z.1) := by
    simp only [textbookLangevinHamiltonian, Prod.fst_add, Prod.snd_add, Pi.add_apply]
    have heq : (∑ i : Fin N, (z.2 i + y.2 i) ^ 2) =
        (∑ i : Fin N, z.2 i ^ 2) + 2 * (∑ i : Fin N, z.2 i * y.2 i) +
          (∑ i : Fin N, y.2 i ^ 2) := by
      simp_rw [show ∀ i : Fin N, (z.2 i + y.2 i) ^ 2 =
        z.2 i ^ 2 + 2 * (z.2 i * y.2 i) + y.2 i ^ 2 by intro i; ring]
      rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.mul_sum]
    rw [heq]
    ring
  rw [he]
  calc
    _ ≤ ‖(∑ i : Fin N, y.2 i ^ 2) / 2‖ + ‖U (z.1 + y.1) - U z.1‖ := norm_add_le _ _
    _ ≤ ((N : ℝ) * ‖y‖ ^ 2) / 2 + (M : ℝ) * ‖y.1‖ := by
      rw [Real.norm_of_nonneg he0]
      exact add_le_add (div_le_div_of_nonneg_right henergy (by norm_num)) hpot
    _ = _ := by ring

omit [MeasurableSpace Ω] in
include hU hp in
/-- The actual residual after the momentum linear increment has a derived
squared bound by genuine real position second and full phase fourth powers. -/
theorem textbookLangevinPeriodicHamiltonianIncrementResidual_square_bound :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ T (x : textbookLangevinPeriodicPhase N) sample,
      textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ^ 2 ≤
        2 * M ^ 2 *
          ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample -
            textbookLangevinPeriodicRepresentative x.1‖ ^ 2 +
        ((N : ℝ) ^ 2 / 2) *
          ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample‖ ^ 4 := by
  obtain ⟨M, hM, hbM⟩ := textbookUnitPeriodicC2Observable_iteratedFDeriv_bound U (hU.of_le (by simp)) hp 1 (by norm_num)
  let Mn : ℝ≥0 := ⟨M, hM⟩
  have hLip : LipschitzWith Mn U := by
    apply lipschitzWith_of_nnnorm_fderiv_le (hU.differentiable (by simp))
    intro q
    have hh : ‖fderiv ℝ U q‖ ≤ M := by simpa only [norm_iteratedFDeriv_one] using hbM q
    exact_mod_cast hh
  refine ⟨M, hM, fun T x sample ↦ ?_⟩
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let y := textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample
  have heH : textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample =
      textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z := by
    change textbookLangevinPeriodicHamiltonianPower U 1
      (textbookLangevinPeriodicProjection (textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample)) -
        textbookLangevinPeriodicHamiltonianPower U 1 x = _
    rw [textbookLangevinPeriodicHamiltonianPower_lift U hp 1]
    simp only [textbookLangevinHamiltonianPower, textbookLangevinPeriodicHamiltonianPower, pow_one]
    have hz : z + y = textbookLangevinGlobalRandomPhase U L hF γ σ z B T sample := by
      dsimp only [z, y, textbookLangevinPeriodicRealPhaseIncrement]
      abel
    rw [hz]
  have heR : textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample =
      textbookLangevinHamiltonian U (z + y) - textbookLangevinHamiltonian U z -
        (∑ i : Fin N, z.2 i * y.2 i) := by
    unfold textbookLangevinPeriodicHamiltonianIncrementResidual
    rw [heH]
    rfl
  have hh := hamVariance_real_residual_bound U Mn hLip z y
  rw [← heR] at hh
  have hs := pow_le_pow_left₀ (norm_nonneg _) hh 2
  have hd := sq_nonneg ((M : ℝ) * ‖y.1‖ - ((N : ℝ) / 2) * ‖y‖ ^ 2)
  have hb : textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ^ 2 ≤
      2 * M ^ 2 * ‖y.1‖ ^ 2 + ((N : ℝ) ^ 2 / 2) * ‖y‖ ^ 4 := by
    simp only [Real.norm_eq_abs, sq_abs] at hs
    change _ ≤ ((M : ℝ) * ‖y.1‖ + ((N : ℝ) / 2) * ‖y‖ ^ 2) ^ 2 at hs
    nlinarith
  exact hb

include hB hU hp in
/-- The actual Hamiltonian residual belongs to L² near zero, from genuine
Hamiltonian and momentum linear increment moments. -/
theorem textbookLangevinPeriodicHamiltonianIncrementResidual_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    MemLp (textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x) 2 P := by
  have ha : AEStronglyMeasurable (textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x) P :=
    (textbookLangevinPeriodicGlobalRandomPhase_hamiltonian_increment_integrable
      B P hB U hU hp L hF γ σ hγ T hT x).aestronglyMeasurable
  have hi := textbookLangevinPeriodicHamiltonianIncrement_integer_power_integrable
    B P hB U hU hp L hF γ σ hγ T hT hT1 x 2
  have hH : MemLp (textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x) 2 P :=
    (memLp_two_iff_integrable_sq ha).mpr hi
  change MemLp (fun sample ↦ textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample -
    textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample) 2 P
  exact hH.sub (textbookLangevinPeriodicMomentumLinearIncrement_memLp
    B P hB U hU hp L hF γ σ hγ T hT x)

include hB hU hp in
/-- The actual Hamiltonian residual squared expectation divided by time tends
to zero, from original position second and real phase fourth moments. -/
theorem textbookLangevinPeriodicHamiltonianIncrementResidual_square_div_time_tendsto_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ^ 2 ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  obtain ⟨M, _hM, hb⟩ := textbookLangevinPeriodicHamiltonianIncrementResidual_square_bound B U hU hp L hF γ σ
  have hq := textbookLangevinPeriodicConfigurationLift_increment_norm_square_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x
  have hph := textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x
  have hlim := (hq.const_mul (2 * M ^ 2)).add (hph.const_mul ((N : ℝ) ^ 2 / 2))
  apply squeeze_zero' _ _ (by simpa only [mul_zero, zero_add] using hlim)
  · filter_upwards [self_mem_nhdsWithin] with t ht
    exact div_nonneg (integral_nonneg (fun _ ↦ sq_nonneg _)) ht.le
  · filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    have hi := (textbookLangevinPeriodicHamiltonianIncrementResidual_memLp
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x).integrable_sq
    have hqi := textbookLangevinPeriodicConfigurationLift_increment_norm_square_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le x
    have hpi := textbookLangevinPeriodicRealPhaseIncrement_norm_fourth_integrable
      B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x
    have hu := (hqi.const_mul (2 * M ^ 2)).add (hpi.const_mul ((N : ℝ) ^ 2 / 2))
    have he := integral_mono_ae hi hu (Eventually.of_forall (fun sample ↦ hb t x sample))
    simp only [Pi.add_apply] at he
    rw [integral_add
      (f := fun sample ↦ 2 * M ^ 2 * ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
        textbookLangevinPeriodicRepresentative x.1‖ ^ 2)
      (g := fun sample ↦ ((N : ℝ) ^ 2 / 2) * ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 4)
      (hqi.const_mul _) (hpi.const_mul _), integral_const_mul, integral_const_mul] at he
    calc
      _ ≤ (2 * M ^ 2 * (∫ sample, ‖textbookLangevinPeriodicConfigurationLift B U L hF γ σ t x sample -
          textbookLangevinPeriodicRepresentative x.1‖ ^ 2 ∂P) +
          ((N : ℝ) ^ 2 / 2) * (∫ sample, ‖textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample‖ ^ 4 ∂P)) / t :=
        div_le_div_of_nonneg_right he ht0.le
      _ = _ := by ring
private theorem hamVariance_product_cauchy {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (f g : Ω → ℝ) (hf : MemLp f 2 P) (hg : MemLp g 2 P) :
    ‖∫ sample, f sample * g sample ∂P‖ ≤
      Real.sqrt (∫ sample, f sample ^ 2 ∂P) * Real.sqrt (∫ sample, g sample ^ 2 ∂P) := by
  have hpq : (2 : ℝ).HolderConjugate 2 :=
    Real.holderConjugate_iff.mpr (by norm_num)
  have hh := integral_mul_norm_le_Lp_mul_Lq hpq
    (show MemLp f (ENNReal.ofReal 2) P by simpa using hf)
    (show MemLp g (ENNReal.ofReal 2) P by simpa using hg)
  have hs : (∫ sample, ‖f sample‖ * ‖g sample‖ ∂P) ≤
      Real.sqrt (∫ sample, f sample ^ 2 ∂P) * Real.sqrt (∫ sample, g sample ^ 2 ∂P) := by
    simpa only [Real.rpow_two, ← Real.sqrt_eq_rpow, Real.norm_eq_abs, sq_abs] using hh
  calc
    _ ≤ ∫ sample, ‖f sample * g sample‖ ∂P := norm_integral_le_integral_norm _
    _ = ∫ sample, ‖f sample‖ * ‖g sample‖ ∂P := by simp only [norm_mul]
    _ ≤ _ := hs


private theorem hamVariance_product_div_time_bound {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (f g : Ω → ℝ) (hf : MemLp f 2 P) (hg : MemLp g 2 P)
    (t : ℝ) (ht : 0 < t) :
    ‖(∫ sample, f sample * g sample ∂P) / t‖ ≤
      Real.sqrt ((∫ sample, f sample ^ 2 ∂P) / t) *
        Real.sqrt ((∫ sample, g sample ^ 2 ∂P) / t) := by
  let F := fun sample ↦ f sample / Real.sqrt t
  let G := fun sample ↦ g sample / Real.sqrt t
  have hF : MemLp F 2 P := by
    simpa only [F, div_eq_mul_inv, mul_comm] using hf.const_mul (Real.sqrt t)⁻¹
  have hG : MemLp G 2 P := by
    simpa only [G, div_eq_mul_inv, mul_comm] using hg.const_mul (Real.sqrt t)⁻¹
  have he : (fun sample ↦ F sample * G sample) = (fun sample ↦ (f sample * g sample) / t) := by
    funext sample
    dsimp only [F, G]
    rw [div_mul_div_comm, ← pow_two, Real.sq_sqrt ht.le]
  have hFs : (∫ sample, F sample ^ 2 ∂P) = (∫ sample, f sample ^ 2 ∂P) / t := by
    dsimp only [F]
    simp_rw [div_pow]
    rw [integral_div, Real.sq_sqrt ht.le]
  have hGs : (∫ sample, G sample ^ 2 ∂P) = (∫ sample, g sample ^ 2 ∂P) / t := by
    dsimp only [G]
    simp_rw [div_pow]
    rw [integral_div, Real.sq_sqrt ht.le]
  have hh := hamVariance_product_cauchy P F G hF hG
  rw [he, integral_div, hFs, hGs] at hh
  exact hh

include hB hU hp in
private theorem hamVariance_linear_residual_cross_div_time_zero
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample *
        textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ∂P) / T)
      (𝓝[>] 0) (𝓝 0) := by
  have hl := textbookLangevinPeriodicMomentumLinearIncrement_second_moment_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x
  have hr := textbookLangevinPeriodicHamiltonianIncrementResidual_square_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x
  have hlim : Tendsto (fun T : ℝ ↦
      Real.sqrt ((∫ sample, textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample ^ 2 ∂P) / T) *
      Real.sqrt ((∫ sample, textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ^ 2 ∂P) / T))
      (𝓝[>] 0) (𝓝 0) := by
    simpa only [Real.sqrt_zero, mul_zero] using hl.sqrt.mul hr.sqrt
  have hb : ∀ᶠ t in 𝓝[>] (0 : ℝ),
      ‖(∫ sample, textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample *
        textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample ∂P) / t‖ ≤
      Real.sqrt ((∫ sample, textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample ^ 2 ∂P) / t) *
      Real.sqrt ((∫ sample, textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample ^ 2 ∂P) / t) := by
    filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
    have ht0 : 0 < t := ht
    have ht1' : t < 1 := ht1
    exact hamVariance_product_div_time_bound P _ _
      (textbookLangevinPeriodicMomentumLinearIncrement_memLp B P hB U hU hp L hF γ σ hγ t ht0.le x)
      (textbookLangevinPeriodicHamiltonianIncrementResidual_memLp B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x)
      t ht0
  exact squeeze_zero_norm' hb hlim

include hB hU hp in
/-- The actual original Hamiltonian increment has its genuine infinitesimal
second moment σ²∑p0_i², with no supplied generator or variance limit. -/
theorem textbookLangevinPeriodicHamiltonianIncrement_second_moment_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ T x sample ^ 2 ∂P) / T)
      (𝓝[>] 0) (𝓝 (σ ^ 2 * ∑ i : Fin N, x.2 i ^ 2)) := by
  have hl := textbookLangevinPeriodicMomentumLinearIncrement_second_moment_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x
  have hc := hamVariance_linear_residual_cross_div_time_zero B P hB U hU hp L hF γ σ hγ x
  have hr := textbookLangevinPeriodicHamiltonianIncrementResidual_square_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ hγ x
  have hlim := (hl.add (hc.const_mul 2)).add hr
  have hlim' : Tendsto (fun T : ℝ ↦
      ((∫ sample, textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample ^ 2 ∂P) / T +
      2 * ((∫ sample, textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ T x sample *
        textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ∂P) / T)) +
      (∫ sample, textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ T x sample ^ 2 ∂P) / T)
      (𝓝[>] 0) (𝓝 (σ ^ 2 * ∑ i : Fin N, x.2 i ^ 2)) := by
    simpa only [mul_zero, add_zero] using hlim
  apply hlim'.congr'
  filter_upwards [self_mem_nhdsWithin,
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have hL := textbookLangevinPeriodicMomentumLinearIncrement_memLp
    B P hB U hU hp L hF γ σ hγ t ht0.le x
  have hR := textbookLangevinPeriodicHamiltonianIncrementResidual_memLp
    B P hB U hU hp L hF γ σ hγ t ht0.le ht1'.le x
  have hli := hL.integrable_sq
  have hri := hR.integrable_sq
  have hci := hL.integrable_mul hR
  have he : (fun sample ↦ textbookLangevinPeriodicHamiltonianIncrement B U L hF γ σ t x sample ^ 2) =
      (fun sample ↦ textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample ^ 2 +
      2 * (textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample *
        textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample) +
      textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample ^ 2) := by
    funext sample
    dsimp only [textbookLangevinPeriodicHamiltonianIncrementResidual]
    ring
  rw [he, integral_add
    (f := fun sample ↦ textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample ^ 2 +
      2 * (textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample *
        textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample))
    (g := fun sample ↦ textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample ^ 2)
    (hli.add (hci.const_mul 2)) hri,
    integral_add
      (f := fun sample ↦ textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample ^ 2)
      (g := fun sample ↦ 2 * (textbookLangevinPeriodicMomentumLinearIncrement B U L hF γ σ t x sample *
        textbookLangevinPeriodicHamiltonianIncrementResidual B U L hF γ σ t x sample))
      hli (hci.const_mul 2), integral_const_mul]
  ring

include hB hU hp in
/-- With the original physical fluctuation-dissipation amplitude, the actual
Hamiltonian increment variance derivative equals 2γβ⁻¹∑p0_i². -/
theorem textbookLangevinPeriodicHamiltonianIncrement_physical_second_moment_div_time_tendsto
    (hγ : 0 < γ) (β : ℝ) (hβ : 0 < β) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      textbookLangevinPeriodicHamiltonianIncrement B U L hF γ (Real.sqrt (2 * γ * β⁻¹)) T x sample ^ 2 ∂P) / T)
      (𝓝[>] 0) (𝓝 ((2 * γ * β⁻¹) * ∑ i : Fin N, x.2 i ^ 2)) := by
  have hh := textbookLangevinPeriodicHamiltonianIncrement_second_moment_div_time_tendsto
    B P hB U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) hγ x
  have hs : Real.sqrt (2 * γ * β⁻¹) ^ 2 = 2 * γ * β⁻¹ :=
    Real.sq_sqrt (by positivity)
  rw [hs] at hh
  exact hh

end
end MolecularDynamics
