"""New bounded local routes only; no sealed Chapter 6 checkpoint is restored."""
proofs={
'BiasedWalkSum':'''intro Ω a b J dt x0 K sample
  induction K with
  | zero => simp [MolecularDynamics.Chapter06Review.biasedWalk]
  | succ K ih =>
    simp only [MolecularDynamics.Chapter06Review.biasedWalk, Finset.sum_range_succ]
    linarith [ih]''',
'CanonicalSamplingObstruction':'''intro n H energy z μ inst hH hz hpositive
  let S : Set (MolecularDynamics.Chapter06Review.V n) := {x | H x ≠ energy}
  have hS : MeasurableSet S := (isClosed_singleton.preimage hH).isOpen_compl.measurableSet
  let g : MolecularDynamics.Chapter06Review.V n → ℝ := S.indicator (fun _ ↦ 1)
  have hgi : Integrable g μ := (integrable_const (1 : ℝ)).indicator hS
  have hIntegral : (∫ x, g x ∂μ)=μ.real S := integral_indicator_one hS
  have hzero : ∀ t : ℝ, g (z t)=0 := by
    intro t
    apply Set.indicator_of_not_mem
    exact fun h ↦ h (hz t)
  refine ⟨g,hgi,?_,?_⟩
  · rw [hIntegral]
    exact ENNReal.toReal_pos hpositive.ne' (measure_ne_top μ S)
  · have hfun : MolecularDynamics.Chapter05Review.timeAverage z g=(fun _ : ℝ ↦ 0) := by
      funext T
      simp [MolecularDynamics.Chapter05Review.timeAverage,hzero]
    rw [hfun]
    exact tendsto_const_nhds''',
'EnergySupportObstruction':'''intro n H energy z μ hH hz hpositive
  constructor
  · intro t ht
    exact ht (hz t)
  · exact hpositive''',
'WalkRecurrence':'''intro Ω J dx n sample
  simp only [MolecularDynamics.Chapter06Review.randomWalk, Finset.sum_range_succ]
  ring''',
'WalkInitial':'''intro Ω J dx sample
  simp [MolecularDynamics.Chapter06Review.randomWalk]''',
'WienerIncrement':'''intro Ω inst P W hW s t
  have hl : HasLaw (fun sample ↦ W t sample-W s sample)
      (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P := by
    convert hW.hasLaw_sub t s using 1
    apply congrArg (gaussianReal 0)
    apply NNReal.coe_injective
    simp [Real.nndist_eq, Real.nnabs]
  refine ⟨hl, ?_⟩
  simpa only [Real.coe_toNNReal _ (abs_nonneg _)] using
    MolecularDynamics.textbookCenteredGaussian_secondMoment hl''',
'IndependentPartition':'''intro n m HA HB EA EB hA hB
  dsimp
  simp''',
'EntropyAdditivity':'''intro kB ZA ZB hA hB
  rw [Real.log_mul hA.ne' hB.ne']
  ring''',
'EntropyEquilibrium':'''intro SA SB energy e hSA hSB hmax
  have hi : HasDerivAt (fun x : ℝ ↦ energy-x) (-1) e :=
    (hasDerivAt_const e energy).sub (hasDerivAt_id e)
  have hd := hSA.hasDerivAt.add (hSB.hasDerivAt.comp e hi)
  have hz := hmax.hasDerivAt_eq_zero hd
  linarith''',
'LennardJonesConfinement':'''intro ε hε
  refine ⟨1/4, ?_⟩
  intro q
  have hsq := sq_nonneg (q⁻¹^6 - 1/2)
  have heq : q⁻¹^12 = (q⁻¹^6)^2 := by ring
  rw [heq]
  nlinarith''',
'VirialFieldNotPeriodic':'''intro n i q h
  have hi := congrFun h i
  simp at hi''',
'DensityNormalization':'''intro D inst ν H β hI hZ
  simp only [MolecularDynamics.Chapter06Review.canonicalDensity]
  rw [integral_div]
  exact div_self hZ.ne' ''',
'DensityPositive':'''intro D inst ν H β hZ x
  exact div_pos (Real.exp_pos _) hZ''',
'KineticWeightFactorization':'''intro n m q p U β
  unfold MolecularDynamics.Chapter06Review.massHamiltonian
  rw [mul_add, Real.exp_add, Finset.mul_sum, Real.exp_sum, mul_comm]
  congr 1
  apply Finset.prod_congr rfl
  intro i hi
  congr 1
  ring''',
'LogTemperature':'''intro kB Z energy hZ hpos
  have hd := hZ.hasDerivAt.log hpos.ne'
  constructor
  · exact hd.deriv
  · unfold MolecularDynamics.Chapter06Review.inverseTemperature
      MolecularDynamics.Chapter06Review.entropy
    rw [deriv_const_mul kB hd.differentiableAt, hd.deriv]
    ring''',
'BathMeanValue':'''intro S energy s hS hs
  have hlt : energy-s < energy := by linarith
  obtain ⟨ξ, hξ, hd⟩ := exists_deriv_eq_slope S hlt hS.continuous.continuousOn
    (hS.differentiable (by norm_num)).differentiableOn
  refine ⟨ξ, hξ, ?_⟩
  have hn : energy-(energy-s) ≠ 0 := by linarith
  have he := (eq_div_iff hn).mp hd
  nlinarith''',
'BoltzmannConstantSlope':'''intro S energy kB β hS hkB hder s
  let f : ℝ → ℝ := fun x ↦ S x - kB*β*x
  have hf : Differentiable ℝ f := hS.sub (differentiable_const.mul differentiable_id)
  have hzero : ∀ x, deriv f x = 0 := by
    intro x
    dsimp [f]
    rw [deriv_sub (hS x) (by fun_prop), hder x]
    simp
  have he := is_const_of_deriv_eq_zero hf hzero (energy-s) energy
  have heq : S (energy-s)/kB - S energy/kB = -β*s := by
    dsimp [f] at he
    rw [← sub_div]
    apply (div_eq_iff hkB.ne').mpr
    nlinarith
  rw [← Real.exp_sub, heq]''',
'BathTaylorEstimate':'''intro S energy hS
  have hlo := taylor_isLittleO_univ (x₀ := energy) hS
  have ht : Tendsto (fun s : ℝ ↦ energy-s) (𝓝 0) (𝓝 energy) := by
    simpa using (continuous_const.sub continuous_id).tendsto (0 : ℝ)
  have he := ht.eventually (hlo.bound (by norm_num : (0 : ℝ) < 1))
  obtain ⟨δ, hδ, hball⟩ := Metric.mem_nhds_iff.mp he
  refine ⟨|iteratedDeriv 2 S energy|/2+1, δ, by positivity, hδ, ?_⟩
  intro s hs
  have hr := hball (show s ∈ Metric.ball (0 : ℝ) δ by
    simpa [Metric.mem_ball, Real.dist_eq] using hs)
  have hbase : energy-s-energy = -s := by ring
  simp only [Real.norm_eq_abs, hbase, neg_sq, abs_sq, one_mul] at hr
  have hp : taylorWithinEval S 2 univ energy (energy-s) =
      S energy - deriv S energy*s + iteratedDeriv 2 S energy/2*s^2 := by
    norm_num [taylorWithinEval_succ, iteratedDerivWithin_univ, iteratedDeriv_one,
      smul_eq_mul]
    ring
  have hsum : S (energy-s)-S energy+deriv S energy*s =
      (S (energy-s)-taylorWithinEval S 2 univ energy (energy-s)) +
        iteratedDeriv 2 S energy/2*s^2 := by rw [hp]; ring
  rw [hsum]
  calc
    _ ≤ |S (energy-s)-taylorWithinEval S 2 univ energy (energy-s)| +
        |iteratedDeriv 2 S energy/2*s^2| := abs_add _ _
    _ ≤ s^2 + |iteratedDeriv 2 S energy/2*s^2| := add_le_add_right hr _
    _ = (|iteratedDeriv 2 S energy|/2+1)*s^2 := by
      rw [abs_mul, abs_div, abs_of_nonneg (sq_nonneg s)]
      norm_num
      ring''',
'OUVarianceIntegral':'''intro γ T hγ hT
  have hc : 2*γ ≠ 0 := mul_ne_zero (by norm_num) hγ.ne'
  have hd : ∀ x : ℝ, HasDerivAt (fun s : ℝ ↦ Real.exp (2*γ*s)/(2*γ))
      (Real.exp (2*γ*x)) x := by
    intro x
    simpa [hc] using
      ((Real.hasDerivAt_exp (2*γ*x)).comp x
        ((hasDerivAt_id x).const_mul (2*γ))).div_const (2*γ)
  have hi : IntervalIntegrable (fun s : ℝ ↦ Real.exp (2*γ*s)) volume 0 T :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ ↦ hd x) hi]
  simp only [mul_zero, Real.exp_zero]
  ring''',
}
