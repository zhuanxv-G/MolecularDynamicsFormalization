import MolecularDynamics.Chapter06.LangevinC2ObservableTaylor

/-! Actual first and second Taylor expectation coefficients of the original
Langevin process, and the C2 differential-expression identification. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

private def c2Gen_coord {N : ℕ} (v : textbookLangevinPhase N) : Fin N ⊕ Fin N → ℝ :=
  Sum.elim v.1 v.2

private def c2Gen_basis {N : ℕ} : Fin N ⊕ Fin N → textbookLangevinPhase N :=
  Sum.elim (fun i ↦ (Pi.single i 1, 0)) (fun i ↦ (0, Pi.single i 1))

private theorem c2Gen_expand {N : ℕ} (v : textbookLangevinPhase N) :
    v = ∑ a : Fin N ⊕ Fin N, c2Gen_coord v a • c2Gen_basis a := by
  have he : (∑ a : Fin N ⊕ Fin N, c2Gen_coord v a • c2Gen_basis a) =
      (∑ i : Fin N, v.1 i • (Pi.single i 1, (0 : Fin N → ℝ))) +
        (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), Pi.single i 1)) := by
    rw [Fintype.sum_sum_type]
    rfl
  rw [he]
  apply Prod.ext
  · change v.1 = (LinearMap.fst ℝ (Fin N → ℝ) (Fin N → ℝ))
      ((∑ i : Fin N, v.1 i • (Pi.single i 1, (0 : Fin N → ℝ))) +
        (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), Pi.single i 1)))
    rw [map_add, map_sum, map_sum]
    simp only [map_smul, LinearMap.fst_apply, smul_zero, Finset.sum_const_zero, add_zero]
    exact pi_eq_sum_univ' v.1
  · change v.2 = (LinearMap.snd ℝ (Fin N → ℝ) (Fin N → ℝ))
      ((∑ i : Fin N, v.1 i • (Pi.single i 1, (0 : Fin N → ℝ))) +
        (∑ i : Fin N, v.2 i • ((0 : Fin N → ℝ), Pi.single i 1)))
    rw [map_add, map_sum, map_sum]
    simp only [map_smul, LinearMap.snd_apply, smul_zero, Finset.sum_const_zero, zero_add]
    exact pi_eq_sum_univ' v.2

private theorem c2Gen_linear_expand {N : ℕ}
    (A : textbookLangevinPhase N →L[ℝ] ℝ) (v : textbookLangevinPhase N) :
    A v = ∑ a : Fin N ⊕ Fin N, A (c2Gen_basis a) * c2Gen_coord v a := by
  calc
    _ = A (∑ a : Fin N ⊕ Fin N, c2Gen_coord v a • c2Gen_basis a) :=
      congrArg A (c2Gen_expand v)
    _ = _ := by simp only [map_sum, map_smul, smul_eq_mul, mul_comm]

private theorem c2Gen_bilinear_expand {N : ℕ}
    (H : textbookLangevinPhase N →L[ℝ] textbookLangevinPhase N →L[ℝ] ℝ)
    (v : textbookLangevinPhase N) :
    H v v = ∑ a : Fin N ⊕ Fin N, ∑ b : Fin N ⊕ Fin N,
      H (c2Gen_basis a) (c2Gen_basis b) * (c2Gen_coord v a * c2Gen_coord v b) := by
  calc
    _ = ∑ a : Fin N ⊕ Fin N, H (c2Gen_basis a) v * c2Gen_coord v a :=
      c2Gen_linear_expand ((ContinuousLinearMap.apply ℝ ℝ v).comp H) v
    _ = ∑ a : Fin N ⊕ Fin N,
        (∑ b : Fin N ⊕ Fin N, H (c2Gen_basis a) (c2Gen_basis b) * c2Gen_coord v b) *
          c2Gen_coord v a := by
      apply Finset.sum_congr rfl
      intro a _
      rw [c2Gen_linear_expand (H (c2Gen_basis a)) v]
    _ = _ := by
      apply Finset.sum_congr rfl
      intro a _
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro b _
      ring

private def c2Gen_cov {N : ℕ} (σ : ℝ) : (Fin N ⊕ Fin N) → (Fin N ⊕ Fin N) → ℝ
  | .inr i, .inr j => σ ^ 2 * if i = j then 1 else 0
  | _, _ => 0

private theorem c2Gen_cov_sum {N : ℕ}
    (H : textbookLangevinPhase N →L[ℝ] textbookLangevinPhase N →L[ℝ] ℝ) (σ : ℝ) :
    (∑ a : Fin N ⊕ Fin N, ∑ b : Fin N ⊕ Fin N,
      H (c2Gen_basis a) (c2Gen_basis b) * c2Gen_cov σ a b) =
      σ ^ 2 * ∑ i : Fin N, H (0, Pi.single i 1) (0, Pi.single i 1) := by
  classical
  simp [Fintype.sum_sum_type, c2Gen_basis, c2Gen_cov, mul_ite, Finset.mul_sum, mul_comm]

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB hU hp in
private theorem c2Gen_coordinate_memLp
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (a : Fin N ⊕ Fin N) :
    MemLp (fun sample ↦ c2Gen_coord
      (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a) 2 P := by
  cases a with
  | inl i =>
    exact textbookLangevinPeriodicConfigurationLift_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x i
  | inr i =>
    exact textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_coordinate_memLp
      B P hB U hU hp L hF γ σ hγ T hT x i

include hB hU hp in
private theorem c2Gen_coordinate_mean_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (a : Fin N ⊕ Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample, c2Gen_coord
      (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a ∂P) / T)
      (𝓝[>] 0) (𝓝 (c2Gen_coord (textbookLangevinDrift U γ
        (textbookLangevinPeriodicRepresentative x.1, x.2)) a)) := by
  cases a with
  | inl i =>
    exact textbookLangevinPeriodicConfigurationLift_increment_mean_div_time_tendsto
      B P hB U hU hp L hF γ σ hγ x i
  | inr i =>
    exact textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_mean_div_time_tendsto
      B P hB U hU hp L hF γ σ hγ x i

include hB hU hp in
private theorem c2Gen_coordinate_second_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) (a b : Fin N ⊕ Fin N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a *
      c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) b ∂P) / T)
      (𝓝[>] 0) (𝓝 (c2Gen_cov σ a b)) := by
  cases a with
  | inl i =>
    cases b with
    | inl j =>
      exact textbookLangevinPeriodicConfigurationLift_increment_second_product_div_time_tendsto_zero
        B P hB U hU hp L hF γ σ hγ x i j
    | inr j =>
      exact textbookLangevinPeriodicConfigurationLift_momentum_increment_product_div_time_tendsto_zero
        B P hB U hU hp L hF γ σ hγ x i j
  | inr i =>
    cases b with
    | inl j =>
      change Tendsto (fun T : ℝ ↦ (∫ sample,
        ((textbookLangevinPeriodicGlobalRandomPhase U L hF γ σ x B T sample).2 i - x.2 i) *
        (textbookLangevinPeriodicConfigurationLift B U L hF γ σ T x sample j -
          textbookLangevinPeriodicRepresentative x.1 j) ∂P) / T) (𝓝[>] 0) (𝓝 0)
      simpa only [mul_comm] using
        textbookLangevinPeriodicConfigurationLift_momentum_increment_product_div_time_tendsto_zero
          B P hB U hU hp L hF γ σ hγ x j i
    | inr j =>
      exact textbookLangevinPeriodicGlobalRandomPhase_momentum_increment_second_product_div_time_tendsto
        B P hB U hU hp L hF γ σ hγ x i j

include hB hU hp in
/-- Each actual linear Taylor coefficient has the original drift expectation
limit, derived from the genuine configuration and momentum coordinate means. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_linear_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N)
    (A : textbookLangevinPhase N →L[ℝ] ℝ) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) ∂P) / T)
      (𝓝[>] 0) (𝓝 (A (textbookLangevinDrift U γ
        (textbookLangevinPeriodicRepresentative x.1, x.2)))) := by
  rw [c2Gen_linear_expand A (textbookLangevinDrift U γ
    (textbookLangevinPeriodicRepresentative x.1, x.2))]
  have hs := tendsto_finsetSum Finset.univ (fun a _ ↦
    (c2Gen_coordinate_mean_limit B P hB U hU hp L hF γ σ hγ x a).const_mul (A (c2Gen_basis a)))
  apply hs.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi (a : Fin N ⊕ Fin N) : Integrable (fun sample ↦ A (c2Gen_basis a) *
      c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) a) P :=
    ((c2Gen_coordinate_memLp B P hB U hU hp L hF γ σ hγ t ht0.le x a).integrable
      (by norm_num)).const_mul _
  symm
  have hfun : (fun sample ↦ A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)) =
      (fun sample ↦ ∑ a : Fin N ⊕ Fin N, A (c2Gen_basis a) *
        c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) a) :=
    funext (fun sample ↦ c2Gen_linear_expand A _)
  rw [hfun]
  rw [integral_finsetSum Finset.univ (fun a _ ↦ hi a), Finset.sum_div]
  simp only [integral_const_mul, mul_div_assoc]

include hB hU hp in
/-- Each actual bilinear second Taylor coefficient has the genuine original
momentum-noise trace limit, from actual qq/qp/pp covariance rather than an assumption. -/
theorem textbookLangevinPeriodicRealPhaseIncrement_bilinear_mean_div_time_tendsto
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N)
    (H : textbookLangevinPhase N →L[ℝ] textbookLangevinPhase N →L[ℝ] ℝ) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      H (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) ∂P) / T)
      (𝓝[>] 0) (𝓝 (σ ^ 2 * ∑ i : Fin N, H (0, Pi.single i 1) (0, Pi.single i 1))) := by
  have hs := tendsto_finsetSum Finset.univ (fun a _ ↦
    tendsto_finsetSum Finset.univ (fun b _ ↦
      (c2Gen_coordinate_second_limit B P hB U hU hp L hF γ σ hγ x a b).const_mul
        (H (c2Gen_basis a) (c2Gen_basis b))))
  rw [c2Gen_cov_sum H σ] at hs
  apply hs.congr'
  filter_upwards [self_mem_nhdsWithin] with t ht
  have ht0 : 0 < t := ht
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi (a b : Fin N ⊕ Fin N) : Integrable (fun sample ↦
      H (c2Gen_basis a) (c2Gen_basis b) *
        (c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) a *
          c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) b)) P :=
    ((c2Gen_coordinate_memLp B P hB U hU hp L hF γ σ hγ t ht0.le x a).integrable_mul
      (c2Gen_coordinate_memLp B P hB U hU hp L hF γ σ hγ t ht0.le x b)).const_mul _
  symm
  have hfun : (fun sample ↦
      H (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)) =
      (fun sample ↦ ∑ a : Fin N ⊕ Fin N, ∑ b : Fin N ⊕ Fin N,
        H (c2Gen_basis a) (c2Gen_basis b) *
          (c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) a *
            c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) b)) :=
    funext (fun sample ↦ c2Gen_bilinear_expand H _)
  rw [hfun]
  rw [integral_finsetSum Finset.univ (fun a _ ↦
    integrable_finsetSum Finset.univ (fun b _ ↦ hi a b)), Finset.sum_div]
  apply Finset.sum_congr rfl
  intro a _
  rw [integral_finsetSum Finset.univ (fun b _ ↦ hi a b), Finset.sum_div]
  simp only [integral_const_mul, mul_div_assoc]


/-- The original directional Langevin expression on a true C2 test function is
exactly its Frechet drift term plus the actual momentum Hessian trace. -/
theorem textbookLangevinDifferentialOperator_C2_frechet
    (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f) (z : textbookLangevinPhase N) :
    textbookLangevinDifferentialOperator U γ σ f z =
      fderiv ℝ f z (textbookLangevinDrift U γ z) +
        σ ^ 2 / 2 * ∑ i : Fin N,
          iteratedFDeriv ℝ 2 f z (fun _ ↦ ((0 : Fin N → ℝ), Pi.single i 1)) := by
  have hfirst : deriv (fun t : ℝ ↦ f (z + t • textbookLangevinDrift U γ z)) 0 =
      fderiv ℝ f z (textbookLangevinDrift U γ z) := by
    simpa only [zero_smul, add_zero] using
      (hf.differentiable (by norm_num) (z + (0 : ℝ) • textbookLangevinDrift U γ z)).deriv_comp_add_smul
  have hsecond (i : Fin N) :
      deriv (deriv (fun t : ℝ ↦ f (z + t • ((0 : Fin N → ℝ), Pi.single i 1)))) 0 =
        iteratedFDeriv ℝ 2 f z (fun _ ↦ ((0 : Fin N → ℝ), Pi.single i 1)) := by
    let v : textbookLangevinPhase N := (0, Pi.single i 1)
    have he : deriv (fun t : ℝ ↦ f (z + t • v)) =
        (fun t : ℝ ↦ iteratedFDeriv ℝ 1 f (z + t • v) (fun _ ↦ v)) := by
      funext t
      rw [(hf.differentiable (by norm_num) (z + t • v)).deriv_comp_add_smul,
        iteratedFDeriv_one_apply]
    change deriv (deriv (fun t : ℝ ↦ f (z + t • v))) 0 = _
    rw [he]
    simpa only [zero_smul, add_zero, v] using
      (hf.contDiffAt : ContDiffAt ℝ (1 + 1) f (z + (0 : ℝ) • v)).deriv_fderiv_add_smul
  unfold textbookLangevinDifferentialOperator
  rw [hfirst]
  simp_rw [hsecond]

include hB hU hp in
private theorem c2Gen_linear_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (A : textbookLangevinPhase N →L[ℝ] ℝ) :
    Integrable (fun sample ↦
      A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)) P := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hi (a : Fin N ⊕ Fin N) : Integrable (fun sample ↦ A (c2Gen_basis a) *
      c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a) P :=
    ((c2Gen_coordinate_memLp B P hB U hU hp L hF γ σ hγ T hT x a).integrable
      (by norm_num)).const_mul _
  apply (integrable_finsetSum Finset.univ (fun a _ ↦ hi a)).congr
  exact Eventually.of_forall (fun sample ↦ (c2Gen_linear_expand A _).symm)

include hB hU hp in
private theorem c2Gen_bilinear_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (H : textbookLangevinPhase N →L[ℝ] textbookLangevinPhase N →L[ℝ] ℝ) :
    Integrable (fun sample ↦
      H (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)) P := by
  have hi (a b : Fin N ⊕ Fin N) : Integrable (fun sample ↦
      H (c2Gen_basis a) (c2Gen_basis b) *
        (c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) a *
          c2Gen_coord (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) b)) P :=
    ((c2Gen_coordinate_memLp B P hB U hU hp L hF γ σ hγ T hT x a).integrable_mul
      (c2Gen_coordinate_memLp B P hB U hU hp L hF γ σ hγ T hT x b)).const_mul _
  apply (integrable_finsetSum Finset.univ (fun a _ ↦
    integrable_finsetSum Finset.univ (fun b _ ↦ hi a b))).congr
  exact Eventually.of_forall (fun sample ↦ (c2Gen_bilinear_expand H _).symm)

variable (f : textbookLangevinPhase N → ℝ) (hf : ContDiff ℝ 2 f)
  (M : ℝ) (hM : 0 ≤ M) (hH : ∀ z, ‖iteratedFDeriv ℝ 2 f z‖ ≤ M)

omit [MeasurableSpace Ω] in
private theorem c2Gen_actual_taylor_decomp
    (T : ℝ) (x : textbookLangevinPeriodicPhase N) (sample : Ω) :
    f (textbookLangevinGlobalRandomPhase U L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample) -
        f (textbookLangevinPeriodicRepresentative x.1, x.2) =
      (fderiv ℝ f (textbookLangevinPeriodicRepresentative x.1, x.2)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample) +
      (2 : ℝ)⁻¹ * fderiv ℝ (fderiv ℝ f)
        (textbookLangevinPeriodicRepresentative x.1, x.2)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample)) +
      textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f T x sample := by
  unfold textbookLangevinPeriodicC2ObservableTaylorRemainder textbookLangevinC2ObservableTaylorRemainder
  rw [iteratedFDeriv_two_apply]
  have he : (textbookLangevinPeriodicRepresentative x.1, x.2) +
      textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ T x sample =
      textbookLangevinGlobalRandomPhase U L hF γ σ
        (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample := by
    unfold textbookLangevinPeriodicRealPhaseIncrement
    abel
  rw [he]
  ring

include hB hU hp hf hH in
/-- The actual increment of each C2 observable with globally bounded Hessian
is integrable near zero, proved from true Taylor coefficients and remainder. -/
theorem textbookLangevinGlobalRandomPhase_C2_observable_increment_integrable
    (hγ : 0 < γ) (T : ℝ) (hT : 0 ≤ T) (hT1 : T ≤ 1) (x : textbookLangevinPeriodicPhase N) :
    Integrable (fun sample ↦ f (textbookLangevinGlobalRandomPhase U L hF γ σ
      (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample) -
        f (textbookLangevinPeriodicRepresentative x.1, x.2)) P := by
  have hiA := c2Gen_linear_integrable B P hB U hU hp L hF γ σ hγ T hT x
    (fderiv ℝ f (textbookLangevinPeriodicRepresentative x.1, x.2))
  have hiH := c2Gen_bilinear_integrable B P hB U hU hp L hF γ σ hγ T hT x
    (fderiv ℝ (fderiv ℝ f) (textbookLangevinPeriodicRepresentative x.1, x.2))
  have hiR := textbookLangevinPeriodicC2ObservableTaylorRemainder_integrable
    B P hB U hU hp L hF γ σ f hf M hH hγ T hT hT1 x
  apply ((hiA.add (hiH.const_mul (2 : ℝ)⁻¹)).add hiR).congr
  exact Eventually.of_forall (fun sample ↦ (c2Gen_actual_taylor_decomp B U L hF γ σ f T x sample).symm)

include hB hU hp hf hM hH in
/-- The original differential expression is truly the actual pointwise
expectation generator on the explicit C2 globally bounded Hessian test class.
This proves no closed-generator-domain or density assertion. -/
theorem textbookLangevinGlobalRandomPhase_C2_actual_differentialOperator_limit
    (hγ : 0 < γ) (x : textbookLangevinPeriodicPhase N) :
    Tendsto (fun T : ℝ ↦ (∫ sample,
      f (textbookLangevinGlobalRandomPhase U L hF γ σ
        (textbookLangevinPeriodicRepresentative x.1, x.2) B T sample) -
          f (textbookLangevinPeriodicRepresentative x.1, x.2) ∂P) / T)
      (𝓝[>] 0) (𝓝 (textbookLangevinDifferentialOperator U γ σ f
        (textbookLangevinPeriodicRepresentative x.1, x.2))) := by
  let z : textbookLangevinPhase N := (textbookLangevinPeriodicRepresentative x.1, x.2)
  let A := fderiv ℝ f z
  let H := fderiv ℝ (fderiv ℝ f) z
  let R := textbookLangevinPeriodicC2ObservableTaylorRemainder B U L hF γ σ f
  have hl := textbookLangevinPeriodicRealPhaseIncrement_linear_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x A
  have hq := textbookLangevinPeriodicRealPhaseIncrement_bilinear_mean_div_time_tendsto
    B P hB U hU hp L hF γ σ hγ x H
  have hr := textbookLangevinPeriodicC2ObservableTaylorRemainder_mean_div_time_tendsto_zero
    B P hB U hU hp L hF γ σ f hf M hM hH hγ x
  have hs := (hl.add (hq.const_mul (2 : ℝ)⁻¹)).add hr
  have hvalue : (A (textbookLangevinDrift U γ z) +
      (2 : ℝ)⁻¹ * (σ ^ 2 * ∑ i : Fin N, H (0, Pi.single i 1) (0, Pi.single i 1))) + 0 =
      textbookLangevinDifferentialOperator U γ σ f z := by
    rw [textbookLangevinDifferentialOperator_C2_frechet U γ σ f hf z]
    simp only [iteratedFDeriv_two_apply]
    dsimp only [A, H]
    ring
  rw [hvalue] at hs
  apply hs.congr'
  filter_upwards [self_mem_nhdsWithin,
    nhdsWithin_le_nhds (Iio_mem_nhds (by norm_num : (0 : ℝ) < 1))] with t ht ht1
  have ht0 : 0 < t := ht
  have ht1' : t < 1 := ht1
  have hiA := c2Gen_linear_integrable B P hB U hU hp L hF γ σ hγ t ht0.le x A
  have hiH := c2Gen_bilinear_integrable B P hB U hU hp L hF γ σ hγ t ht0.le x H
  have hiR := textbookLangevinPeriodicC2ObservableTaylorRemainder_integrable
    B P hB U hU hp L hF γ σ f hf M hH hγ t ht0.le ht1'.le x
  have hfun : (fun sample ↦ f (textbookLangevinGlobalRandomPhase U L hF γ σ z B t sample) - f z) =
      (fun sample ↦ (A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) +
        (2 : ℝ)⁻¹ * H (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)
          (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)) + R t x sample) :=
    funext (fun sample ↦ c2Gen_actual_taylor_decomp B U L hF γ σ f t x sample)
  symm
  change (∫ sample, f (textbookLangevinGlobalRandomPhase U L hF γ σ z B t sample) - f z ∂P) / t = _
  rw [hfun, integral_add
    (f := fun sample ↦ A (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample) +
      (2 : ℝ)⁻¹ * H (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample)
        (textbookLangevinPeriodicRealPhaseIncrement B U L hF γ σ t x sample))
    (g := R t x) (hiA.add (hiH.const_mul (2 : ℝ)⁻¹)) hiR,
    integral_add hiA (hiH.const_mul (2 : ℝ)⁻¹), integral_const_mul]
  dsimp only [R]
  ring


end
end MolecularDynamics
