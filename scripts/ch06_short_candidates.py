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
'BathConvolutionIBP':'''intro Q P Ω t hQ hP ht
  have hPc : Continuous P := hQ.continuous_deriv_one.congr hP
  have hd : ∀ s : ℝ, HasDerivAt (fun u : ℝ ↦ Real.cos (Ω*(t-u))*Q u)
      (Ω*Real.sin (Ω*(t-s))*Q s+Real.cos (Ω*(t-s))*P s) s := by
    intro s
    have hc : HasDerivAt (fun u : ℝ ↦ Real.cos (Ω*(t-u)))
        (Ω*Real.sin (Ω*(t-s))) s := by
      convert (((hasDerivAt_const s t).sub (hasDerivAt_id s)).const_mul Ω).cos using 1 <;> ring
    simpa only [hP] using hc.mul (hQ.differentiable_one s).hasDerivAt
  have hi : IntervalIntegrable (fun s : ℝ ↦ Ω*Real.sin (Ω*(t-s))*Q s) volume 0 t :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  have hj : IntervalIntegrable (fun s : ℝ ↦ Real.cos (Ω*(t-s))*P s) volume 0 t :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  have he := intervalIntegral.integral_eq_sub_of_hasDerivAt (fun s _ ↦ hd s) (hi.add hj)
  rw [intervalIntegral.integral_add hi hj] at he
  simp only [sub_self, mul_zero, Real.cos_zero, one_mul, sub_zero] at he
  linarith''',
}

proofs.update({
'ZeroNoise':'''intro a f ρ x
  constructor
  · simp [MolecularDynamics.Chapter06Review.scalarGenerator]
  · simp [MolecularDynamics.Chapter06Review.scalarForward]''',
'DiffusionTrace':'''intro n r B H
  rw [Matrix.trace_mul_cycle B.transpose H B, Matrix.trace_mul_cycle B B.transpose H]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Finset.mul_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro k hk
  ring''',
'FiniteEvolutionRecurrence':'''intro k matrix initial n
  simp only [MolecularDynamics.Chapter06Review.finiteEvolution, pow_succ]
  exact (Matrix.vecMul_vecMul initial (matrix^n) matrix).symm''',
'StochasticEntryBound':'''intro k matrix h i j
  rw [← h.2 i]
  exact Finset.single_le_sum (fun k _ ↦ h.1 i k) (Finset.mem_univ j)''',
'ExampleStochastic':'''constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [finiteChainExample]
  · intro i
    fin_cases i <;> norm_num [finiteChainExample, Fin.sum_univ_succ]''',
})

proofs['ExampleNotIrreducible']='''have hz : ∀ n : ℕ,
      (finiteChainExample^n) (1 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (3 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (4 : Fin 5) 0=0 := by
    intro n
    induction n with
    | zero => norm_num
    | succ n ih =>
      rw [pow_succ']
      norm_num [Matrix.mul_apply, Fin.sum_univ_succ, finiteChainExample,
        ih.1, ih.2.1, ih.2.2]
  intro h
  obtain ⟨n,hn⟩ := h (1 : Fin 5) (0 : Fin 5)
  rw [(hz n).1] at hn
  linarith'''

proofs['KernelDuality']='''intro D _ K μ t f hμ hK hf hi
  letI : IsProbabilityMeasure μ := hμ
  letI : IsMarkovKernel (K t) := hK
  unfold MolecularDynamics.Chapter06Review.kernelEvolution MolecularDynamics.Chapter06Review.kernelAverage at *
  rw [Measure.comp_eq_comp_const_apply]
  apply Kernel.integral_comp
  simpa only [← Measure.comp_eq_comp_const_apply] using hi'''

proofs['LieBracketProperties']='''intro n u v w a b hu hv hw
  have hb : ∀ (u v : (Fin n → ℝ) → (Fin n → ℝ)),
      MolecularDynamics.Chapter06Review.lieBracket u v=VectorField.lieBracket ℝ u v :=
    fun u v ↦ rfl
  simp_rw [hb]
  refine ⟨?_,?_,?_,?_⟩
  · funext x
    rw [VectorField.lieBracket_add_left ((hu x).const_smul a) ((hv x).const_smul b),
      VectorField.lieBracket_const_smul_left (hu x),
      VectorField.lieBracket_const_smul_left (hv x)]
  · funext x
    rw [VectorField.lieBracket_add_right ((hv x).const_smul a) ((hw x).const_smul b),
      VectorField.lieBracket_const_smul_right (hv x),
      VectorField.lieBracket_const_smul_right (hw x)]
  · funext x
    exact VectorField.lieBracket_swap
  · exact VectorField.lieBracket_self'''

proofs['FPDriftAdjoint']='''intro a ρ φ ha hρ hφ hc
  have hg : ContDiff ℝ 1 (fun x ↦ a x*ρ x) := ha.mul hρ
  have hi1 : Integrable (fun x ↦ (a x*ρ x)*deriv φ x) :=
    (hg.continuous.mul hφ.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.mul_left
  have hi2 : Integrable (fun x ↦ deriv (fun z ↦ a z*ρ z) x*φ x) :=
    (hg.continuous_deriv_one.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have hi3 : Integrable (fun x ↦ (a x*ρ x)*φ x) :=
    (hg.continuous.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have he := MeasureTheory.integral_mul_deriv_eq_deriv_mul_of_integrable
    (u := fun x ↦ a x*ρ x) (v := φ)
    (fun x _ ↦ (hg.differentiable_one x).hasDerivAt)
    (fun x _ ↦ (hφ.differentiable_one x).hasDerivAt) hi1 hi2 hi3
  simpa only [Pi.mul_apply, mul_comm, mul_left_comm, mul_assoc, mul_neg, integral_neg] using he'''

proofs['FPAdjointCompact']='''intro a b ρ φ ha hb hρ hφ hc
  have ha1 : ContDiff ℝ 1 a := ha.of_le (by norm_num)
  have hρ1 : ContDiff ℝ 1 ρ := hρ.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hh1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have hh2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  have hdiff : (∫ x, (b x^2*ρ x)*deriv (deriv φ) x)=
      (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [hh1, hh2, neg_neg]
    congr 1
    funext x
    ring
  have hD := fpDriftAdjoint a ρ φ ha1 hρ1 hφ1 hc
  have hiA : Integrable (fun x ↦ a x*deriv φ x*ρ x) :=
    ((ha.continuous.mul hφ1.continuous_deriv_one).mul hρ.continuous).integrable_of_hasCompactSupport hc.deriv.mul_left.mul_right
  have hiB : Integrable (fun x ↦ (b x^2*ρ x)*deriv (deriv φ) x) :=
    (hG.continuous.mul hφ.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.deriv.mul_left
  have hiC : Integrable (fun x ↦ φ x*(-deriv (fun z ↦ a z*ρ z) x)) :=
    (hφ.continuous.mul (ha1.mul hρ1).continuous_deriv_one.neg).integrable_of_hasCompactSupport hc.mul_right
  have hiE : Integrable (fun x ↦ φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) :=
    (hφ.continuous.mul hG.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.mul_right
  have hleft : (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
      (∫ x, a x*deriv φ x*ρ x)+(1/2 : ℝ)*(∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
    rw [← integral_const_mul, ← integral_add hiA (hiB.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarGenerator]
    ring
  have hright : (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x)=
      (∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x))+
        (1/2 : ℝ)*(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [← integral_const_mul, ← integral_add hiC (hiE.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarForward]
    ring
  rw [hleft, hright, hD, hdiff]'''

proofs['HamiltonianPowerMomentumDerivative']='''intro n U l z hl
  let S : ℝ := ∑ i, z.2 i^2
  have he : ∀ t : ℝ, textbookLangevinHamiltonian U (z.1,(1+t) • z.2)=
      (1+t)^2*S/2+U z.1 := by
    intro t
    simp only [textbookLangevinHamiltonian, Pi.smul_apply, smul_eq_mul, mul_pow,
      ← Finset.mul_sum]
    rfl
  have hd : HasDerivAt (fun t : ℝ ↦ ((1+t)^2*S/2+U z.1)^l)
      ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S) 0 := by
    convert! (((((hasDerivAt_id (0 : ℝ)).const_add 1).pow 2).mul_const S).div_const 2 |>.add_const (U z.1)).pow l using 1 <;>
      simp [textbookLangevinHamiltonian, S] <;> ring
  constructor
  · simpa only [textbookLangevinHamiltonianPower, he] using hd
  · change (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*S=
      2*(l : ℝ)*textbookLangevinHamiltonian U z^l-
        2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1
    rw [show textbookLangevinHamiltonian U z^l=
      textbookLangevinHamiltonian U z^(l-1)*textbookLangevinHamiltonian U z by
      rw [← pow_succ, Nat.sub_add_cancel hl]]
    dsimp [textbookLangevinHamiltonian, S]
    ring'''

proofs['LyapunovYoungBounds']='''intro l n Umax hl hU
  have hlpos : (0 : ℝ) < l := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hl)
  let A1 : ℝ := (l : ℝ)*((l : ℝ)+(n : ℝ)-1)
  let A2 : ℝ := 2*(l : ℝ)*Umax
  let A3 : ℝ := 2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l
  let A : ℝ := max 0 (max A1 (max A2 A3))
  let ε : ℝ := (l : ℝ)/2
  have hε : 0 < ε := by dsimp [ε]; positivity
  have hA : 0 ≤ A := le_max_left _ _
  let M : ℝ := max 1 (A/ε)
  have hM : 0 ≤ M := le_trans zero_le_one (le_max_left _ _)
  have hAM : A ≤ ε*M := by
    have hd : A/ε ≤ M := le_max_right _ _
    simpa only [mul_comm] using (div_le_iff₀ hε).mp hd
  let C : ℝ := A*M^(l-1)+1
  have hC : 0 < C := by dsimp [C]; positivity
  have hbound : ∀ H : ℝ, 1 ≤ H → A*H^(l-1) ≤ ε*H^l+C := by
    intro H hH
    have hH0 : 0 ≤ H := le_trans zero_le_one hH
    by_cases h : M ≤ H
    · have hAH := hAM.trans (mul_le_mul_of_nonneg_left h hε.le)
      calc
        _ ≤ (ε*H)*H^(l-1) := mul_le_mul_of_nonneg_right hAH (pow_nonneg hH0 _)
        _ = ε*(H^(l-1)*H) := by ring
        _ = ε*H^l := by rw [← pow_succ, Nat.sub_add_cancel hl]
        _ ≤ ε*H^l+C := le_add_of_nonneg_right hC.le
    · have hpow := pow_le_pow_left₀ hH0 (le_of_lt (lt_of_not_ge h)) (l-1)
      have hb := mul_le_mul_of_nonneg_left hpow hA
      have hp : 0 ≤ ε*H^l := mul_nonneg hε.le (pow_nonneg hH0 _)
      dsimp [C]
      linarith
  have h1 : A1 ≤ A := (le_max_left _ _).trans (le_max_right _ _)
  have h2 : A2 ≤ A := (le_max_left _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  have h3 : A3 ≤ A := (le_max_right _ _).trans ((le_max_right _ _).trans (le_max_right _ _))
  refine ⟨C,C,hC,hC,fun H hH ↦ ?_⟩
  have hp : 0 ≤ H^(l-1) := pow_nonneg (le_trans zero_le_one hH) _
  exact ⟨(mul_le_mul_of_nonneg_right h1 hp).trans (hbound H hH),
    (mul_le_mul_of_nonneg_right h2 hp).trans (hbound H hH),
    (mul_le_mul_of_nonneg_right h3 hp).trans (hbound H hH)⟩'''
