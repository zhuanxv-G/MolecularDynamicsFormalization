"""Bounded elementary routes; no coarea, Birkhoff, KAM or measure transport construction."""
proofs={
'FlowFieldTransport':'''intro n f Φ hflow hreg t z
  have hs : ContDiff ℝ 2 (Φ t) := by
    simpa only [Function.comp_def,Function.uncurry_apply_pair] using
      hreg.comp (contDiff_const.prodMk contDiff_id : ContDiff ℝ 2 (fun x : E n => (t,x)))
  have hd := (hs.differentiable (by norm_num) z).hasFDerivAt.comp_hasDerivAt 0 (hflow.2.2 0 z)
  simp only [hflow.1] at hd
  have heq : (fun s : ℝ => Φ t (Φ s z))=(fun s => Φ (s+t) z) := by
    funext s
    rw [← hflow.2.1 t s z,add_comm t s]
  rw [heq] at hd
  have ht : HasDerivAt (fun s : ℝ => Φ (s+t) z) (f (Φ t z)) 0 := by
    simpa using (hflow.2.2 t z).comp 0 ((hasDerivAt_id 0).add_const t)
  exact hd.unique ht''',
'SteadyFirstIntegral':'''intro n f Φ g hflow hg
  constructor
  · intro hz t z
    have ht : ∀ s : ℝ,HasDerivAt (fun u => g (Φ u z)) 0 s := by
      intro s
      have hc := (hg (Φ s z)).hasFDerivAt.comp_hasDerivAt s (hflow.2.2 s z)
      change HasDerivAt (fun u => g (Φ u z)) (MolecularDynamics.Chapter05Review.lie f g (Φ s z)) s at hc
      rw [hz] at hc
      exact hc
    have hh := is_const_of_deriv_eq_zero (fun s => (ht s).differentiableAt) (fun s => (ht s).deriv)
    simpa only [hflow.1] using hh t 0
  · intro hh z
    have hd := (hg (Φ 0 z)).hasFDerivAt.comp_hasDerivAt 0 (hflow.2.2 0 z)
    have heq : (fun s => g (Φ s z))=(fun _ : ℝ => g z) := funext (fun s => hh s z)
    rw [heq] at hd
    simpa only [MolecularDynamics.Chapter05Review.lie,hflow.1] using
      hd.unique (hasDerivAt_const 0 (g z))''',
'PullbackPDE':'''intro n f Φ g hflow hreg hg t z
  have hs : ContDiff ℝ 2 (Φ t) := by
    simpa only [Function.comp_def,Function.uncurry_apply_pair] using
      hreg.comp (contDiff_const.prodMk contDiff_id : ContDiff ℝ 2 (fun x : E n => (t,x)))
  have hchain := (hg.differentiable_one (Φ t z)).hasFDerivAt.comp_hasDerivAt t (hflow.2.2 t z)
  have hcomp := (hg.differentiable_one (Φ t z)).hasFDerivAt.comp z
    (hs.differentiable (by norm_num) z).hasFDerivAt
  have heq : MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
    change ((fderiv ℝ (g ∘ Φ t) z) (f z))=(fderiv ℝ g (Φ t z)) (f (Φ t z))
    rw [hcomp.fderiv]
    change (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z))=(fderiv ℝ g (Φ t z)) (f (Φ t z))
    rw [flowFieldTransport n f Φ hflow hreg t z]
  rw [heq]
  exact hchain'''
}
proofs['LiePullbackCommutes']='''intro n f Φ g hflow hreg hg t z
  have hs : ContDiff ℝ 2 (Φ t) := by
    simpa only [Function.comp_def,Function.uncurry_apply_pair] using
      hreg.comp (contDiff_const.prodMk contDiff_id : ContDiff ℝ 2 (fun x : E n => (t,x)))
  have hcomp := (hg.differentiable_one (Φ t z)).hasFDerivAt.comp z
    (hs.differentiable (by norm_num) z).hasFDerivAt
  change ((fderiv ℝ (g ∘ Φ t) z) (f z))=(fderiv ℝ g (Φ t z)) (f (Φ t z))
  rw [hcomp.fderiv]
  change (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z))=(fderiv ℝ g (Φ t z)) (f (Φ t z))
  rw [flowFieldTransport n f Φ hflow hreg t z]'''
proofs['DiracEvaluates']='''intro n φ
  simp [MolecularDynamics.Chapter05Review.diracMeasure,MolecularDynamics.Chapter05Review.diracAction]'''
proofs['LieCoordinates']='''intro n f g z
  unfold MolecularDynamics.Chapter05Review.lie
  have h := congrArg (fderiv ℝ g z) ((EuclideanSpace.basisFun (Fin n) ℝ).toBasis.sum_repr (f z)).symm
  simpa only [map_sum,map_smul,smul_eq_mul] using h'''
proofs['LiouvilleProductCoordinates']='''intro n f ρ z hf hρ
  rw [liouvilleProduct n f ρ z hf hρ,divergenceCoordinates n f z hf,lieCoordinates n f ρ z]
  rw [Finset.sum_add_distrib,← Finset.mul_sum]
  ring'''
proofs['DivergenceCoordinates']='''intro n f z hf
  unfold MolecularDynamics.Chapter05Review.divergence
  rw [LinearMap.trace_eq_matrix_trace ℝ (EuclideanSpace.basisFun (Fin n) ℝ).toBasis]
  change (∑ i,((fderiv ℝ f z) (EuclideanSpace.basisFun (Fin n) ℝ i)) i)=_
  apply Finset.sum_congr rfl
  intro i hi
  have hc := (PiLp.proj 2 (fun _ : Fin n => ℝ) i).hasFDerivAt.comp z hf.hasFDerivAt
  change HasFDerivAt (fun x => f x i) _ z at hc
  rw [hc.fderiv]
  rfl'''
proofs['MassDerivative']='''intro n ρ A t hA hint hloc
  obtain ⟨δ,hδ,b,hb,hlocal⟩ := hloc
  have ht : t ∈ Ioo (t-δ) (t+δ) := ⟨by linarith,by linarith⟩
  have hm : AEStronglyMeasurable (fun z => deriv (fun u => ρ u z) t) (volume.restrict A) := by
    apply aestronglyMeasurable_of_tendsto_ae (𝓝[≠] (0 : ℝ))
      (f := fun h z => h⁻¹*(ρ (t+h) z-ρ t z))
    · intro h
      exact ((hint (t+h)).aestronglyMeasurable.sub (hint t).aestronglyMeasurable).const_mul _
    · filter_upwards [ae_restrict_mem hA] with z hz
      simpa only [smul_eq_mul] using (hlocal t ht z hz).1.tendsto_slope_zero
  have he := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume.restrict A) (F := ρ) (F' := fun s z => deriv (fun u => ρ u z) s)
    (bound := b) (Ioo_mem_nhds (by linarith) (by linarith))
    (Filter.Eventually.of_forall (fun s => (hint s).aestronglyMeasurable)) (hint t) hm
    ((ae_restrict_mem hA).mono (fun z hz s hs => by
      simpa only [Real.norm_eq_abs] using (hlocal s hs z hz).2)) hb
    ((ae_restrict_mem hA).mono (fun z hz s hs => (hlocal s hs z hz).1))
  simpa only [MolecularDynamics.Chapter05Review.massFraction] using he.2'''
proofs['GaussianL2']='''intro n a ha
  have hc : Continuous (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) := by fun_prop
  rw [memLp_two_iff_integrable_sq hc.aestronglyMeasurable]
  have hi := integrable_cexp_neg_sum_mul_add (ι := Fin n) (b := fun i => ((2*a i : ℝ) : ℂ))
    (by intro i; simpa using (mul_pos (by norm_num : (0 : ℝ)<2) (ha i))) (fun _ => (0 : ℂ))
  have hr : Integrable (fun v : Fin n → ℝ => Real.exp (-(∑ i,(2*a i)*(v i)^2))) volume := by
    simpa only [zero_mul,Finset.sum_const_zero,add_zero,← Complex.ofReal_pow,← Complex.ofReal_mul,
      ← Complex.ofReal_sum,← Complex.ofReal_neg,Complex.exp_ofReal,Complex.ofReal_re] using hi.re
  have he : Integrable (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,(2*a i)*(z i)^2))) volume := by
    rw [← (PiLp.volume_preserving_toLp (Fin n)).integrable_comp_emb (MeasurableEquiv.toLp 2 _).measurableEmbedding]
    exact hr
  convert he using 1
  funext z
  rw [← Real.exp_nat_mul]
  congr 1
  simp only [mul_assoc,← Finset.mul_sum]
  ring'''
proofs['FiniteJumpL2']='''intro n g S hS hs hc hb
  have hm : Measurable g := hc.measurable_of_countable_compl (by simpa only [compl_compl] using hS.countable)
  have hl : ∀ z,∃ C > 0,∀ᶠ x in 𝓝 z,|g x| ≤ C := by
    intro z
    by_cases hz : z ∈ S
    · obtain ⟨C,hC,U,hU,hbU⟩ := hb z hz
      exact ⟨C,hC,Filter.mem_of_superset hU hbU⟩
    · have hcont := hc.continuousAt (hS.isClosed.isOpen_compl.mem_nhds hz)
      refine ⟨|g z|+1,by positivity,?_⟩
      exact (hcont.abs.eventually_lt_const (lt_add_one _)).mono (fun _ h => h.le)
  have hbound : ∃ C > 0,∀ x ∈ tsupport g,|g x| ≤ C := by
    apply hs.induction_on (p := fun A => ∃ C > 0,∀ x ∈ A,|g x| ≤ C)
    · exact ⟨1,by norm_num,by simp⟩
    · intro A B hAB hB
      obtain ⟨C,hC,hCB⟩ := hB
      exact ⟨C,hC,fun x hx => hCB x (hAB hx)⟩
    · intro A B hA hB
      obtain ⟨C,hC,hCA⟩ := hA
      obtain ⟨D,hD,hDB⟩ := hB
      refine ⟨max C D,lt_of_lt_of_le hC (le_max_left _ _),?_⟩
      intro x hx
      rcases hx with hx|hx
      · exact (hCA x hx).trans (le_max_left _ _)
      · exact (hDB x hx).trans (le_max_right _ _)
    · intro z hz
      obtain ⟨C,hC,hCL⟩ := hl z
      exact ⟨{x | |g x| ≤ C},mem_nhdsWithin_of_mem_nhds hCL,C,hC,fun _ hx => hx⟩
  obtain ⟨C,hC,hBC⟩ := hbound
  apply hs.memLp_of_bound hm.aestronglyMeasurable C
  filter_upwards [] with x
  by_cases hx : x ∈ tsupport g
  · simpa only [Real.norm_eq_abs] using hBC x hx
  · rw [image_eq_zero_of_notMem_tsupport hx,norm_zero]
    exact hC.le'''
proofs['LiouvilleProduct']='''intro n f ρ z hf hρ
  have hd := hρ.hasFDerivAt.smul hf.hasFDerivAt
  unfold MolecularDynamics.Chapter05Review.liouvillian MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.lie
  rw [hd.fderiv]
  change -(LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
    (ρ z • (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z).toLinearMap.smulRight (f z))) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-
      (fderiv ℝ ρ z) (f z)
  simp only [map_add,map_smul,LinearMap.trace_smulRight,smul_eq_mul]
  ring'''
proofs['HamiltonianSkewExpression']='''intro n f u hf hu hdiv z
  rw [liouvilleProduct n f u z (hf z) (hu z),hdiv z]
  ring'''
proofs['RegularDistributionLinearity']='''intro n f hf hb
  obtain ⟨C,hC⟩ := hb
  have hi : ∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,
      Integrable (fun z => f z*φ z) volume := by
    intro φ
    apply Integrable.mono' (φ.integrable.norm.mul_const C)
    · exact hf.continuous.measurable.aestronglyMeasurable.mul φ.continuous.measurable.aestronglyMeasurable
    · filter_upwards [] with z
      simpa only [norm_mul,Real.norm_eq_abs,mul_comm] using mul_le_mul_of_nonneg_right (hC z) (abs_nonneg (φ z))
  refine ⟨hi,?_⟩
  intro φ ψ a b
  simp only [MolecularDynamics.Chapter05Review.regularDistribution,SchwartzMap.add_apply,SchwartzMap.smul_apply,smul_eq_mul]
  simp_rw [mul_add,← mul_assoc,mul_comm (f _) a,mul_comm (f _) b]
  rw [integral_add ((hi φ).const_mul a) ((hi ψ).const_mul b),integral_const_mul,integral_const_mul]'''
proofs['CompactAdjoint']='''intro n f u v hf hu hv huS hvS
  let e (i : Fin n) := EuclideanSpace.basisFun (Fin n) ℝ i
  let a (i : Fin n) (z : MolecularDynamics.Chapter05Review.E n) := u z*f z i
  have ha (i : Fin n) : ContDiff ℝ 1 (a i) := by dsimp [a]; fun_prop
  have hs (i : Fin n) : HasCompactSupport (a i) := huS.mul_right
  have hc (i : Fin n) : Continuous (fun z => fderiv ℝ (a i) z (e i)) :=
    ((ha i).continuous_fderiv (by norm_num)).clm_apply continuous_const
  have hvd (i : Fin n) : Continuous (fun z => fderiv ℝ v z (e i)) :=
    (hv.continuous_fderiv (by norm_num)).clm_apply continuous_const
  have hleft (i : Fin n) : Integrable (fun z => a i z*fderiv ℝ v z (e i)) volume :=
    ((ha i).continuous.mul (hvd i)).integrable_of_hasCompactSupport ((hs i).mul_right)
  have hright (i : Fin n) : Integrable (fun z => fderiv ℝ (a i) z (e i)*v z) volume :=
    ((hc i).mul hv.continuous).integrable_of_hasCompactSupport
      (((hs i).fderiv_apply (𝕜:=ℝ) (e i)).mul_right)
  have hip (i : Fin n) : (∫ z,a i z*fderiv ℝ v z (e i)) =
      -(∫ z,fderiv ℝ (a i) z (e i)*v z) := by
    apply integral_mul_fderiv_eq_neg_fderiv_mul_of_integrable
    · exact hright i
    · exact hleft i
    · exact ((ha i).continuous.mul hv.continuous).integrable_of_hasCompactSupport ((hs i).mul_right)
    · intro z hz; exact ((ha i).differentiable (by norm_num)) z
    · intro z hz; exact (hv.differentiable (by norm_num)) z
  have hl (z) : u z*MolecularDynamics.Chapter05Review.lie f v z =
      ∑ i : Fin n,a i z*fderiv ℝ v z (e i) := by
    rw [lieCoordinates,Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    dsimp [a,e]; ring
  have hr (z) : MolecularDynamics.Chapter05Review.liouvillian f u z*v z =
      -(∑ i : Fin n,fderiv ℝ (a i) z (e i)*v z) := by
    unfold MolecularDynamics.Chapter05Review.liouvillian
    rw [divergenceCoordinates n (fun x => u x • f x) z
      (((hu.differentiable (by norm_num)) z).smul ((hf.differentiable (by norm_num)) z))]
    simp only [PiLp.smul_apply,smul_eq_mul]
    dsimp [a,e]
    rw [neg_mul,Finset.sum_mul]
  simp_rw [hl,hr]
  rw [integral_finsetSum Finset.univ (fun i hi => hleft i),integral_neg,
    integral_finsetSum Finset.univ (fun i hi => hright i)]
  simp_rw [hip]
  rw [Finset.sum_neg_distrib]'''
proofs['MechanicalLiouvillianIdentity']='''intro n m U hm hU u hu z
  have hd := HasFDerivAt.fun_sum (u:=Finset.univ) (fun (i : Fin n) hi =>
    ((PiLp.proj (2 : ENNReal) (fun _ : Fin n => ℝ) i).hasFDerivAt.pow 2).div_const (2*m i))
  have hp : gradient (fun p : MolecularDynamics.Chapter05Review.E n =>
      (∑ i,(p i)^2/(2*m i))+U z.1) z.2 =
      WithLp.toLp 2 (fun i => z.2 i/m i) := by
    apply (InnerProductSpace.toDual ℝ (MolecularDynamics.Chapter05Review.E n)).injective
    rw [toDual_gradient,(hd.add_const (U z.1)).fderiv]
    ext v
    simp only [ContinuousLinearMap.sum_apply,ContinuousLinearMap.smul_apply,
      ContinuousLinearMap.coe_smul',smul_eq_mul,PiLp.proj_apply,
      InnerProductSpace.toDual_apply_apply,PiLp.inner_apply,RCLike.conj_to_real,
      WithLp.toLp_apply]
    apply Finset.sum_congr rfl
    intro i hi
    have hm0 : m i ≠ 0 := ne_of_gt (hm i)
    field_simp
    ring
  have hq : gradient (fun q : MolecularDynamics.Chapter05Review.E n =>
      (∑ i,(z.2 i)^2/(2*m i))+U q) z.1=gradient U z.1 := by
    unfold gradient
    rw [fderiv_const_add]
  unfold MolecularDynamics.Chapter05Review.mechanicalLiouvillian MolecularDynamics.Chapter05Review.hamiltonianField
  rw [hp,hq]'''
proofs['GaussianDeltaProbability']='''intro ε hε
  have he0 : ε ≠ 0 := ne_of_gt hε
  have hcoef : 0 < (1 : ℝ)/(2*ε) := by positivity
  have heq : MolecularDynamics.Chapter05Review.gaussianDelta ε=
      (fun x : ℝ => Real.exp (-(1/(2*ε))*x^2)/Real.sqrt (2*Real.pi*ε)) := by
    funext x
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    congr 2
    ring
  rw [heq]
  refine ⟨fun x => by positivity,?_,?_⟩
  · exact (integrable_exp_neg_mul_sq hcoef).div_const _
  · rw [integral_div,integral_gaussian]
    have hp0 : 0 ≤ 2*Real.pi*ε := by positivity
    have hratio : Real.pi/(1/(2*ε))=2*Real.pi*ε := by field_simp; ring
    rw [hratio,div_self (ne_of_gt (Real.sqrt_pos.2 (by positivity)))]'''
proofs['MicroProbability']='''intro n H c hH hpos hfin
  let σ := MolecularDynamics.Chapter05Review.energySurface H c
  have hσ : MeasurableSet σ := by
    exact (isClosed_eq hH.continuous continuous_const).measurableSet
  have hzero : (MolecularDynamics.Chapter05Review.microRaw H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microRaw MolecularDynamics.Chapter05Review.surfaceMeasure
    rw [Measure.withDensity_apply _ hσ.compl]
    simp [σ]
  have hu : (MolecularDynamics.Chapter05Review.microMeasure H c) univ=1 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,smul_eq_mul]
    exact ENNReal.inv_mul_cancel (ne_of_gt hpos) (ne_of_lt hfin)
  have hz : (MolecularDynamics.Chapter05Review.microMeasure H c) σᶜ=0 := by
    unfold MolecularDynamics.Chapter05Review.microMeasure
    rw [Measure.smul_apply,hzero,smul_zero]
  refine ⟨hu,?_,?_⟩
  · have hh := measure_add_measure_compl hσ (μ:=MolecularDynamics.Chapter05Review.microMeasure H c)
    simpa only [hz,add_zero,hu] using hh
  · intro A
    exact ⟨bot_le,(measure_mono (subset_univ A)).trans_eq hu⟩'''
proofs['ConservedInfiniteAverage']='''intro X z I r hI
  have hm (g : X → ℝ) (hg : ∀ t,g (z t)=g (z 0)) :
      MolecularDynamics.Chapter05Review.hasTimeAverage z g (g (z 0)) := by
    apply tendsto_congr' _ |>.2 tendsto_const_nhds
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    exact MolecularDynamics.Chapter05Review.conservedAverage_proved z g (g (z 0)) hg T (ne_of_gt hT)
  exact ⟨hm I hI,hm (r ∘ I) (fun t => by simp only [Function.comp_apply,hI])⟩'''
proofs['InvariantIndicatorAverage']='''unfold MolecularDynamics.Chapter05Review.hasTimeAverage
  have heq : MolecularDynamics.Chapter05Review.timeAverage (fun t => Φ t z)
      (Aᶜ.indicator (fun _ => (1 : ℝ)))=(fun _ : ℝ => 0) := by
    funext T
    simp [MolecularDynamics.Chapter05Review.timeAverage,
      MolecularDynamics.Chapter05Review.invariantIndicator_proved Φ A hA z hz]
  rw [heq]
  exact tendsto_const_nhds'''
proofs['NonergodicSet']='''intro n μ Φ hμ
  letI := hμ
  unfold MolecularDynamics.Chapter05Review.setErgodic
  push_neg
  constructor
  · rintro ⟨A,hA,hΦ,hzero,hone⟩
    exact ⟨A,hA,hΦ,lt_of_le_of_ne bot_le (Ne.symm hzero),
      lt_of_le_of_ne ((measure_mono (subset_univ A)).trans_eq measure_univ) hone⟩
  · rintro ⟨A,hA,hΦ,hpos,hlt⟩
    exact ⟨A,hA,hΦ,ne_of_gt hpos,ne_of_lt hlt⟩'''
proofs['GradientTransverse']='''intro n H c hn z hz
  exact inner_self_ne_zero.mpr (hn z hz)'''
proofs['MeasureDuality']='''intro n μ Φ φ t hm hi
  exact integral_map hm.aemeasurable hi.aestronglyMeasurable'''
proofs['CorrelationTimeAE']='''intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh'''
proofs['CenteredCorrelation']='''intro n μ Φ a b k hμ hΦ hm ha hb hba hbb hzero
  have ht := mixingCorrelation n μ Φ a b k hμ hΦ hm ha hb hba hbb
  have hl : k*MolecularDynamics.Chapter05Review.average μ a*MolecularDynamics.Chapter05Review.average μ b=0 := by
    rcases hzero with h | h <;> rw [h] <;> ring
  rw [hl] at ht
  simpa only [abs_zero] using ht.abs'''
proofs['TwoOscillatorEnergyDecomposition']='''intro Ω E z
  constructor
  · intro h
    refine ⟨fun i => twoOscillatorEnergy Ω i z,?_,h,fun i => rfl⟩
    intro i
    unfold twoOscillatorEnergy
    positivity
  · rintro ⟨c,hc,hE,heq⟩
    simpa only [heq] using hE'''
proofs['AnisotropicInitialEnergy']='''intro κ l ε c x hx
  let U := anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])
  change (0^2+(Real.sqrt (2*(c-U)))^2)/2+U=c
  rw [Real.sq_sqrt (by dsimp [U];linarith)]
  ring'''
proofs['CircleInitialEnergy']='''intro κ l ε c x θ hx
  let U := anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])
  let R := Real.sqrt (2*(c-U))
  change ((R*Real.cos θ)^2+(R*Real.sin θ)^2)/2+U=c
  have ht : (R*Real.cos θ)^2+(R*Real.sin θ)^2=R^2 := by
    calc
      _=R^2*((Real.sin θ)^2+(Real.cos θ)^2) := by ring
      _=R^2 := by rw [Real.sin_sq_add_cos_sq,mul_one]
  rw [ht]
  dsimp [R]
  rw [Real.sq_sqrt (by dsimp [U];linarith)]
  ring'''
proofs['DiracApproximation']='''intro n r hr hp hs φ hφ
  apply Metric.tendsto_nhds.mpr
  intro e he
  obtain ⟨δ,hδ,hφδ⟩ := Metric.continuousAt_iff.mp hφ.continuousAt (e/2) (by positivity)
  obtain ⟨η,hη,hsη⟩ := hs δ hδ
  filter_upwards [Ioo_mem_nhdsGT hη] with ε hε
  have hd := (hp ε hε.1).1
  have hmass := (hp ε hε.1).2
  have hb : ∀ z,‖(φ z-φ 0)*r ε z‖ ≤ (e/2)*r ε z := by
    intro z
    by_cases hz : r ε z=0
    · simp [hz]
    · have hzball := hsη ε hε (show z ∈ Function.support (r ε) from hz)
      have heφ := hφδ (by simpa only [Metric.mem_ball] using hzball)
      simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hd.2.1 z),Real.dist_eq] using
        mul_le_mul_of_nonneg_right heφ.le (hd.2.1 z)
  have hdiff : Integrable (fun z => (φ z-φ 0)*r ε z) volume := by
    apply Integrable.mono' (hd.2.2.const_mul (e/2))
    · exact ((hφ.sub continuous_const).mul (hr ε hε.1)).measurable.aestronglyMeasurable
    · exact ae_of_all _ hb
  have hpr : Integrable (fun z => φ z*r ε z) volume := by
    convert hdiff.add (hd.2.2.const_mul (φ 0)) using 1
    funext z; ring
  have hi : (∫ z,(φ z-φ 0)*r ε z)=(∫ z,φ z*r ε z)-φ 0 := by
    simp_rw [sub_mul]
    rw [integral_sub hpr (hd.2.2.const_mul (φ 0)),integral_const_mul,hmass,mul_one]
  have hle := norm_integral_le_of_norm_le (hd.2.2.const_mul (e/2)) (ae_of_all _ hb)
  rw [integral_const_mul,hmass,mul_one,hi] at hle
  rw [dist_eq_norm]
  exact hle.trans_lt (by linarith)'''
proofs['GaussianDeltaWeak']='''intro φ hφ hb
  have hg := gaussianDeltaProbability 1 (by norm_num)
  obtain ⟨C,hC,hBC⟩ := hb.exists_pos_norm_le
  have ht : Tendsto (fun ε : ℝ => ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (𝓝[>] 0) (𝓝 (φ 0)) := by
    have hc := tendsto_integral_filter_of_dominated_convergence
      (fun x : ℝ => C*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (F:=fun ε x => φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (f:=fun x => φ 0*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (Filter.Eventually.of_forall (fun ε => by
        apply Continuous.aestronglyMeasurable
        unfold MolecularDynamics.Chapter05Review.gaussianDelta
        fun_prop))
      (Filter.Eventually.of_forall (fun ε => ae_of_all _ (fun x => by
        simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hg.1 x)] using
          mul_le_mul_of_nonneg_right (hBC (φ (Real.sqrt ε*x)) (mem_range_self _)) (hg.1 x))))
      (hg.2.1.const_mul C) (ae_of_all _ (fun x => by
        have hs : Tendsto (fun ε : ℝ => Real.sqrt ε*x) (𝓝[>] 0) (𝓝 0) := by
          simpa using ((Real.continuous_sqrt.tendsto 0).mono_left inf_le_left).mul_const x
        exact (hφ.tendsto 0 |>.comp hs).mul_const _))
    simpa only [integral_const_mul,hg.2.2,mul_one] using hc
  apply tendsto_congr' _ |>.2 ht
  filter_upwards [self_mem_nhdsWithin] with ε hε
  have hεpos : 0 < ε := hε
  have hspos : 0 < Real.sqrt ε := Real.sqrt_pos.2 hεpos
  have hs0 : Real.sqrt ε ≠ 0 := ne_of_gt hspos
  have hpoint (x : ℝ) : Real.sqrt ε*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)=
      MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    rw [mul_pow,Real.sq_sqrt hεpos.le]
    have hexp : -(ε*x^2)/(2*ε)= -x^2/2 := by field_simp; ring
    rw [hexp,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
    simp only [mul_one]
    field_simp
  calc
    (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=
      Real.sqrt ε*(∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)) := by
        rw [Measure.integral_comp_mul_left]
        simp [smul_eq_mul,abs_of_pos (inv_pos.mpr hspos),hs0]
    _ = ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
      rw [←integral_const_mul]
      apply integral_congr_ae
      filter_upwards [] with x
      rw [←hpoint]
      ring'''
proofs['NormalEnergyTaylor']='''intro n H z hH hn
  let g (s : ℝ) := H (z+s • MolecularDynamics.Chapter05Review.normalField H z)
  have hg : ContDiff ℝ 2 g := by dsimp [g]; fun_prop
  have hcurve : HasDerivAt (fun s : ℝ => z+s • MolecularDynamics.Chapter05Review.normalField H z)
      (MolecularDynamics.Chapter05Review.normalField H z) 0 := by
    convert ((hasDerivAt_id 0).smul_const (MolecularDynamics.Chapter05Review.normalField H z)).const_add z using 1
  have hgd : HasDerivAt g ((fderiv ℝ H z) (MolecularDynamics.Chapter05Review.normalField H z)) 0 := by
    simpa only [g,zero_smul,add_zero] using!
      ((hH.differentiable (by norm_num)) z).hasFDerivAt.comp_hasDerivAt 0 hcurve
  have hcoeff : (fderiv ℝ H z) (MolecularDynamics.Chapter05Review.normalField H z)=
      ‖MolecularDynamics.Chapter05Review.grad H z‖ := by
    have hnorm : ‖gradient H z‖ ≠ 0 := norm_ne_zero_iff.mpr hn
    unfold MolecularDynamics.Chapter05Review.normalField MolecularDynamics.Chapter05Review.grad
    rw [←toDual_gradient]
    simp only [InnerProductSpace.toDual_apply_apply,inner_smul_right,real_inner_self_eq_norm_sq]
    field_simp
  have hderiv : deriv g 0=‖MolecularDynamics.Chapter05Review.grad H z‖ := hgd.deriv.trans hcoeff
  obtain ⟨C,hC⟩ := (taylor_isLittleO_univ (x₀:=0) (n:=2) hg).isBigO.bound
  obtain ⟨δ,hδ,hbound⟩ := Metric.eventually_nhds_iff.mp hC
  let A : ℝ := deriv (deriv g) 0/2
  have ht (s : ℝ) : taylorWithinEval g 2 univ 0 s=g 0+deriv g 0*s+A*s^2 := by
    simp [taylorWithinEval_succ,taylor_within_zero_eval,iteratedDerivWithin_univ,
      iteratedDeriv_succ,iteratedDeriv_zero,smul_eq_mul,A]
    ring
  refine ⟨|C|+|A|+1,by positivity,δ,hδ,?_⟩
  intro s hs
  have hb := hbound (by simpa only [Real.dist_eq,sub_zero] using hs)
  have hb' : |g s-taylorWithinEval g 2 univ 0 s| ≤ C*s^2 := by
    simpa only [Real.norm_eq_abs,sub_zero,abs_sq] using hb
  change |g s-g 0-s*‖MolecularDynamics.Chapter05Review.grad H z‖| ≤ (|C|+|A|+1)*s^2
  calc
    |g s-g 0-s*‖MolecularDynamics.Chapter05Review.grad H z‖|=
        |(g s-taylorWithinEval g 2 univ 0 s)+A*s^2| := by rw [ht,hderiv];congr 1;ring
    _ ≤ |g s-taylorWithinEval g 2 univ 0 s|+|A*s^2| := abs_add _ _
    _ ≤ C*s^2+|A|*s^2 := by rw [abs_mul,abs_sq];exact add_le_add_right hb' _
    _ ≤ (|C|+|A|+1)*s^2 := by nlinarith [le_abs_self C,sq_nonneg s]'''
proofs['ForwardEnergyGrowth']='''intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.forwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.forwardEuler h x 1)^2=(1+h^2)*((x 0)^2+(x 1)^2) := by
    simp [MolecularDynamics.Chapter05Review.forwardEuler]
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring'''
proofs['BackwardEnergyDecay']='''intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.backwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.backwardEuler h x 1)^2=(1+h^2)⁻¹*((x 0)^2+(x 1)^2) := by
    have hd : 1+h^2 ≠ 0 := ne_of_gt (by positivity)
    simp [MolecularDynamics.Chapter05Review.backwardEuler]
    field_simp
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring'''
proofs['SymplecticEulerEllipse']='''intro h hh
  let d := 2-|h|
  have hd : 0 < d := by dsimp [d];linarith
  have lower (z : MolecularDynamics.Chapter05Review.E 2) :
      d*((z 0)^2+(z 1)^2) ≤ 4*MolecularDynamics.Chapter05Review.shadowOscillator h z := by
    unfold MolecularDynamics.Chapter05Review.shadowOscillator
    dsimp [d]
    by_cases hp : 0 ≤ h
    · rw [abs_of_nonneg hp]
      nlinarith [mul_nonneg hp (sq_nonneg (z 0-z 1))]
    · rw [abs_of_neg (lt_of_not_ge hp)]
      nlinarith [mul_nonneg (neg_nonneg.mpr (le_of_lt (lt_of_not_ge hp))) (sq_nonneg (z 0+z 1))]
  have normeq (z : MolecularDynamics.Chapter05Review.E 2) : ‖z‖^2=(z 0)^2+(z 1)^2 := by
    rw [EuclideanSpace.norm_sq_eq]
    simp [Fin.sum_univ_two,Real.norm_eq_abs]
  refine ⟨?_,?_,?_⟩
  · intro z hz
    have hnorm : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    have hl := lower z
    rw [←normeq] at hl
    nlinarith [mul_pos hd hnorm]
  · intro c
    have hc : Continuous (MolecularDynamics.Chapter05Review.shadowOscillator h) := by
      unfold MolecularDynamics.Chapter05Review.shadowOscillator;fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | MolecularDynamics.Chapter05Review.shadowOscillator h z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|/d+1)).of_isClosed_subset hclosed
    intro z hz
    have hl := lower z
    rw [←normeq] at hl
    have hle : ‖z‖^2 ≤ 4*|c|/d := (le_div_iff₀ hd).mpr (by nlinarith [le_abs_self c])
    have hB : 0 ≤ 4*|c|/d := by positivity
    rw [Metric.mem_closedBall,dist_zero_right]
    nlinarith [norm_nonneg z]
  · intro z k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply',MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved,ih]'''
proofs['BackwardEulerLimit']='''intro h hh
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have hc : Continuous (MolecularDynamics.Chapter05Review.backwardEuler h) := by
    unfold MolecularDynamics.Chapter05Review.backwardEuler
    fun_prop
  have hz (z : MolecularDynamics.Chapter05Review.E 2) :
      Tendsto (fun k : ℕ => (MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z) atTop (𝓝 0) := by
    apply tendsto_zero_iff_norm_tendsto_zero.mpr
    have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z‖^2=
        (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using backwardEnergyDecay h z k
    have hs : Tendsto (fun k : ℕ => (1+h^2)⁻¹^k*((z 0)^2+(z 1)^2)) atTop (𝓝 0) := by
      simpa only [zero_mul] using (tendsto_pow_atTop_nhds_zero_of_lt_one
        (inv_nonneg.mpr (by positivity : 0 ≤ 1+h^2)) ((inv_lt_one₀ (by positivity)).mpr hp)).mul_const ((z 0)^2+(z 1)^2)
    convert (Real.continuous_sqrt.tendsto 0).comp hs using 1
    · funext k
      rw [←he,Real.sqrt_sq (norm_nonneg _)]
    · simp
  refine ⟨hz,?_⟩
  intro μ hμ φ hφ hb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hd := tendsto_integral_filter_of_dominated_convergence
    (μ:=μ) (fun _ : MolecularDynamics.Chapter05Review.E 2 => C)
    (F:=fun k z => φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z))
    (f:=fun _ => φ 0)
    (Eventually.of_forall (fun k => (hφ.comp (hc.iterate k)).measurable.aestronglyMeasurable))
    (Eventually.of_forall (fun k => ae_of_all μ (fun z => hB (φ ((MolecularDynamics.Chapter05Review.backwardEuler h)^[k] z)) (mem_range_self _))))
    (integrable_const C) (ae_of_all μ (fun z => (hφ.tendsto 0).comp (hz z)))
  simpa using hd'''
proofs['ForwardNormDivergence']='''intro h hh z hz
  have hs : 0 < (z 0)^2+(z 1)^2 := by
    have hn : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hz) _
    rw [EuclideanSpace.norm_sq_eq] at hn
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hn
  have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
  have he (k : ℕ) : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
      (1+h^2)^k*((z 0)^2+(z 1)^2) := by
    rw [EuclideanSpace.norm_sq_eq]
    simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
  have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
  apply tendsto_atTop.2
  intro b
  filter_upwards [ht.eventually (eventually_ge_atTop ((max b 0)^2+1))] with k hk
  rw [←he] at hk
  nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),le_max_left b 0,le_max_right b 0]'''
proofs['EulerInvariant']='''intro h hh μ hμ hΦ
  letI := hμ
  have heq : ∀ᵐ z ∂μ,z=(0 : MolecularDynamics.Chapter05Review.E 2) := by
    filter_upwards [hΦ.conservative.ae_frequently_mem_of_mem_nhds] with z hz
    by_contra hn
    have hs : 0 < (z 0)^2+(z 1)^2 := by
      have hs' : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hn) _
      rw [EuclideanSpace.norm_sq_eq] at hs'
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hs'
    have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
    have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
    have hret := hz (Metric.ball 0 (‖z‖+1))
      (isOpen_ball.mem_nhds (by simp [Metric.mem_ball,dist_zero_right]))
    obtain ⟨k,hk,hlarge⟩ := (hret.and_eventually
      (ht.eventually (eventually_ge_atTop ((‖z‖+1)^2+1)))).exists
    have hen : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
        (1+h^2)^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
    rw [←hen] at hlarge
    rw [Metric.mem_ball,dist_zero_right] at hk
    nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),norm_nonneg z]
  have hm := Measure.map_congr heq
  simpa [MolecularDynamics.Chapter05Review.diracMeasure] using hm'''
proofs['SymplecticEulerDensity']='''intro h hh r hr
  let M : Matrix (Fin 2) (Fin 2) ℝ := !![1-h^2,h;-h,1]
  have heq : (M.toEuclideanLin : MolecularDynamics.Chapter05Review.E 2 → MolecularDynamics.Chapter05Review.E 2)=
      MolecularDynamics.Chapter05Review.symplecticEuler h := by
    funext z
    ext i
    fin_cases i <;>
      simp [M,Matrix.toEuclideanLin,Matrix.toLpLin_apply,Matrix.mulVec,Fin.sum_univ_two,
        MolecularDynamics.Chapter05Review.symplecticEuler] <;> ring
  have hd : LinearMap.det M.toEuclideanLin=1 := by
    rw [←LinearMap.det_toMatrix (EuclideanSpace.basisFun (Fin 2) ℝ).toBasis,
      Matrix.toEuclideanLin_eq_toLin_orthonormal,LinearMap.toMatrix_toLin]
    simp [M,Matrix.det_fin_two]
    ring
  have hmap := map_linearMap_addHaar_eq_smul_addHaar
    (f:=M.toEuclideanLin) (volume : Measure (MolecularDynamics.Chapter05Review.E 2))
    (show LinearMap.det M.toEuclideanLin ≠ 0 from by rw [hd];norm_num)
  rw [heq] at hmap
  have hc : Continuous (MolecularDynamics.Chapter05Review.symplecticEuler h) := by
    unfold MolecularDynamics.Chapter05Review.symplecticEuler;fun_prop
  have hf : MeasurePreserving (MolecularDynamics.Chapter05Review.symplecticEuler h)
      (volume : Measure (MolecularDynamics.Chapter05Review.E 2)) volume :=
    ⟨hc.measurable,by simpa only [hd,inv_one,abs_one,ENNReal.ofReal_one,one_smul] using hmap⟩
  refine ⟨hf.measurable,?_⟩
  ext A hA
  rw [Measure.map_apply hf.measurable hA]
  unfold MolecularDynamics.Chapter05Review.densityMeasure
  rw [withDensity_apply _ (hA.preimage hf.measurable),withDensity_apply _ hA]
  simpa only [Function.comp_apply,MolecularDynamics.Chapter05Review.symplecticEulerShadow_proved] using
    hf.setLIntegral_comp_preimage hA hr.1.1.ennreal_ofReal'''
proofs['ModifiedLiouvillian']='''intro n f fr u h r hf hfr hu z
  have hx : DifferentiableAt ℝ (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z :=
    (hf z).add ((hfr z).const_smul (h^r))
  rw [liouvilleProduct n _ u z hx (hu z),liouvilleProduct n f u z (hf z) (hu z),
    liouvilleProduct n fr u z (hfr z) (hu z)]
  have hd : MolecularDynamics.Chapter05Review.divergence (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z=
      MolecularDynamics.Chapter05Review.divergence f z+(h^r)*MolecularDynamics.Chapter05Review.divergence fr z := by
    unfold MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.modifiedField
    rw [((hf z).hasFDerivAt.add ((hfr z).hasFDerivAt.const_smul (h^r))).fderiv]
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      ((fderiv ℝ f z).toLinearMap+(h^r) • (fderiv ℝ fr z).toLinearMap)=_
    simp only [map_add,map_smul,smul_eq_mul]
  have hl : MolecularDynamics.Chapter05Review.lie (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=
      MolecularDynamics.Chapter05Review.lie f u z+(h^r)*MolecularDynamics.Chapter05Review.lie fr u z := by
    simp [MolecularDynamics.Chapter05Review.lie,MolecularDynamics.Chapter05Review.modifiedField,
      map_add,map_smul,smul_eq_mul]
  rw [hd,hl]
  ring'''
proofs['DoubleWellCoercivity']='''constructor
  · intro z
    unfold doubleWellEnergy
    positivity
  · intro c
    have hc : Continuous (doubleWellEnergy) := by unfold doubleWellEnergy; fun_prop
    have hclosed : IsClosed {z : MolecularDynamics.Chapter05Review.E 2 | doubleWellEnergy z ≤ c} :=
      isClosed_le hc continuous_const
    apply (isCompact_closedBall (0 : MolecularDynamics.Chapter05Review.E 2) (4*|c|+4)).of_isClosed_subset hclosed
    intro z hz
    have he : (z 1)^2/2+(1-(z 0)^2)^2 ≤ c := hz
    have hpos : 0 ≤ c := by nlinarith [sq_nonneg (z 1),sq_nonneg (1-(z 0)^2)]
    have hq : (z 0)^2 ≤ (c+3)/2 := by
      nlinarith [sq_nonneg (z 1),sq_nonneg ((z 0)^2-2)]
    have hp : (z 1)^2 ≤ 2*c := by nlinarith [sq_nonneg (1-(z 0)^2)]
    have hnorm : ‖z‖^2=(z 0)^2+(z 1)^2 := by
      rw [EuclideanSpace.norm_sq_eq]
      simp [Fin.sum_univ_two,Real.norm_eq_abs]
    rw [Metric.mem_closedBall,dist_zero_right,abs_of_nonneg hpos]
    nlinarith [norm_nonneg z]'''
proofs['CurveImageDimension']='''intro n f Φ γ hflow hΦ hγ hγn t
  have hs (t : ℝ) : ContDiff ℝ ⊤ (Φ t) := by
    simpa only [Function.comp_def,Function.uncurry_apply_pair] using!
      hΦ.comp (contDiff_const.prodMk contDiff_id : ContDiff ℝ ⊤ (fun x : MolecularDynamics.Chapter05Review.E n => (t,x)))
  refine ⟨(hs t).comp hγ,?_⟩
  intro s hzero
  have hback : (fun r : ℝ => Φ (-t) (Φ t (γ r)))=γ := by
    funext r
    rw [←hflow.2.1,neg_add_cancel,hflow.1]
  have himg := ((hs t).differentiable (by simp) (γ s)).hasFDerivAt.comp_hasDerivAt s
    ((hγ.differentiable (by simp)) s).hasDerivAt
  have hb := ((hs (-t)).differentiable (by simp) (Φ t (γ s))).hasFDerivAt.comp_hasDerivAt s himg
  have hderiv : (fderiv ℝ (Φ t) (γ s)) (deriv γ s)=0 := by
    exact himg.deriv.symm.trans hzero
  rw [hderiv,map_zero,hback] at hb
  exact hγn s hb.deriv'''
proofs['DoubleWellBasin']='''intro z c hz hc hE t
  let q (s : ℝ) := (z s) 0
  have hq : Continuous q := by dsimp [q]; fun_prop
  have hn (s : ℝ) : q s ≠ 0 := by
    intro heq
    have hh := hE s
    unfold doubleWellEnergy at hh
    change (z s) 0=0 at heq
    rw [heq] at hh
    nlinarith [sq_nonneg ((z s) 1),hc.2]
  by_cases h0 : 0 < q 0
  · left
    refine ⟨h0,?_⟩
    by_contra ht
    have hneg : q t < 0 := lt_of_le_of_ne (le_of_not_gt ht) (hn t)
    obtain ⟨s,hs⟩ := intermediate_value_univ t 0 hq (show (0 : ℝ) ∈ Icc (q t) (q 0) from ⟨hneg.le,h0.le⟩)
    exact hn s hs
  · right
    have hneg : q 0 < 0 := lt_of_le_of_ne (le_of_not_gt h0) (hn 0)
    refine ⟨hneg,?_⟩
    by_contra ht
    have hpos : 0 < q t := lt_of_le_of_ne (le_of_not_gt ht) (Ne.symm (hn t))
    obtain ⟨s,hs⟩ := intermediate_value_univ 0 t hq (show (0 : ℝ) ∈ Icc (q 0) (q t) from ⟨hneg.le,hpos.le⟩)
    exact hn s hs'''
proofs['DoubleWellDisconnected']='''intro c hc hS
  let a : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![-1,Real.sqrt (2*c)]
  let b : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![1,Real.sqrt (2*c)]
  have hsqrt : (Real.sqrt (2*c))^2=2*c := Real.sq_sqrt (by positivity)
  have ha : a ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    simp [MolecularDynamics.Chapter05Review.energySurface,doubleWellEnergy,a,hsqrt] <;> ring
  have hb : b ∈ MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c := by
    simp [MolecularDynamics.Chapter05Review.energySurface,doubleWellEnergy,b,hsqrt] <;> ring
  have hq : ContinuousOn (fun z : MolecularDynamics.Chapter05Review.E 2 => z 0)
      (MolecularDynamics.Chapter05Review.energySurface doubleWellEnergy c) := by fun_prop
  have hzero : (0 : ℝ) ∈ Icc (a 0) (b 0) := by norm_num [a,b]
  obtain ⟨z,hz,hz0⟩ := hS.intermediate_value ha hb hq hzero
  change doubleWellEnergy z=c at hz
  unfold doubleWellEnergy at hz
  rw [hz0] at hz
  nlinarith [sq_nonneg (z 1),hc.2]'''
proofs['MixingMemoryLoss']='''intro n μ Φ β φ hμ hm hβ hβbound hβpos hβmass hφ hb hΦ
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hi : Integrable φ μ := Integrable.mono' (integrable_const C)
    hφ.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (φ z) (mem_range_self z)))
  have he (t : ℝ) : (∫ z,φ (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ φ := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable φ (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact hi.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have hp (t : ℝ) : Integrable (fun z => φ (Φ t z)*β z) μ :=
    hβ.bdd_mul (hφ.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hB (φ (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : (∫ z,φ (Φ t z)*(β z-1) ∂μ)=
      (∫ z,φ (Φ t z)*β z ∂μ)-MolecularDynamics.Chapter05Review.average μ φ := by
    simp_rw [mul_sub,mul_one]
    rw [integral_sub (hp t) ((hΦ t).integrable_comp_of_integrable hi),he]
  simp_rw [heq]
  simpa only [sub_self] using (hm β φ hβ hβpos hβmass hφ hb).sub tendsto_const_nhds'''
proofs['MixingCorrelation']='''intro n μ Φ a b k hμ hΦ hm ha hb hba hbb
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hbb.exists_pos_norm_le
  obtain ⟨R,hR,hA⟩ := hba.exists_pos_norm_le
  have ib : Integrable b μ := Integrable.mono' (integrable_const C)
    hb.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (b z) (mem_range_self z)))
  have ia : Integrable a μ := Integrable.mono' (integrable_const R)
    ha.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hA (a z) (mem_range_self z)))
  have ibound : |∫ z,b z ∂μ| ≤ C := by
    simpa only [Real.norm_eq_abs,probReal_univ,mul_one] using
      norm_integral_le_of_norm_le_const (ae_of_all μ (fun z => hB (b z) (mem_range_self z)))
  let D := C+1
  let M := (∫ z,b z ∂μ)+D
  have hM : 0 < M := by dsimp [M,D];linarith [neg_le_of_abs_le ibound]
  let r (z) := (b z+D)/M
  have ir : Integrable r μ := (ib.add (integrable_const D)).div_const M
  have rpos (z) : 0 ≤ r z := by
    have hx : |b z| ≤ C := by simpa only [Real.norm_eq_abs] using hB (b z) (mem_range_self z)
    dsimp [r,D]
    apply div_nonneg _ hM.le
    linarith [neg_le_of_abs_le hx]
  have rmass : (∫ z,r z ∂μ)=1 := by
    dsimp [r]
    rw [integral_div,integral_add ib (integrable_const D)]
    simp [integral_const,M,ne_of_gt hM]
  have ht := hm r a ir rpos rmass ha hba
  have iap (t : ℝ) : Integrable (fun z => a (Φ t z)) μ :=
    (hΦ t).integrable_comp_of_integrable ia
  have ie (t : ℝ) : (∫ z,a (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ a := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable a (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact ia.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have ipr (t : ℝ) : Integrable (fun z => a (Φ t z)*r z) μ :=
    ir.bdd_mul (ha.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hA (a (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : M*(∫ z,a (Φ t z)*r z ∂μ)-D*MolecularDynamics.Chapter05Review.average μ a=
      (∫ z,a (Φ t z)*b z ∂μ) := by
    rw [←ie t,←integral_const_mul,←integral_const_mul,
      ←integral_sub ((ipr t).const_mul M) ((iap t).const_mul D)]
    apply integral_congr_ae
    filter_upwards [] with z
    dsimp [r]
    field_simp [ne_of_gt hM] <;> ring
  have hh := (ht.const_mul M).sub (tendsto_const_nhds : Tendsto
    (fun _ : ℝ => D*MolecularDynamics.Chapter05Review.average μ a) atTop
    (𝓝 (D*MolecularDynamics.Chapter05Review.average μ a)))
  simp_rw [heq] at hh
  convert hh.const_mul k using 1
  unfold MolecularDynamics.Chapter05Review.average
  dsimp [M]
  ring'''
proofs['EulerLogCorrespondence']='''intro h hh
  have hn : h ≠ 0 := ne_of_gt hh
  have hp : 0 < 1+h^2 := by positivity
  have hs : Real.sqrt (1+h^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hp)
  have he : Real.exp (Real.log (1+h^2)/2)=Real.sqrt (1+h^2) := by
    have he2 : (Real.exp (Real.log (1+h^2)/2))^2=1+h^2 := by
      rw [pow_two,←Real.exp_add]
      convert Real.exp_log hp using 1 <;> congr 1 <;> ring
    nlinarith [Real.exp_pos (Real.log (1+h^2)/2),Real.sqrt_nonneg (1+h^2),Real.sq_sqrt hp.le]
  have hbh : Real.arctan h/h*h=Real.arctan h := by field_simp [hn]
  have haf : (Real.log (1+h^2)/(2*h))*h=Real.log (1+h^2)/2 := by field_simp [hn];ring
  have hab : (-(Real.log (1+h^2))/(2*h))*h= -(Real.log (1+h^2)/2) := by field_simp [hn];ring
  constructor
  · intro z
    constructor <;> ext i <;> fin_cases i <;>
      simp [eulerLogFlow,MolecularDynamics.Chapter05Review.forwardEuler,
        MolecularDynamics.Chapter05Review.backwardEuler,hbh,haf,hab,Real.exp_neg,
        he,Real.cos_arctan,Real.sin_arctan]
    all_goals field_simp <;> nlinarith [Real.sq_sqrt hp.le]
  · intro backward z t
    let a := (if backward then (-1 : ℝ) else 1)*Real.log (1+h^2)/(2*h)
    let b := Real.arctan h/h
    have ha := ((hasDerivAt_id t).const_mul a).exp
    have hc := ((hasDerivAt_id t).const_mul b).cos
    have hs := ((hasDerivAt_id t).const_mul b).sin
    have hq := ha.mul ((hc.const_mul (z 0)).add (hs.const_mul (z 1)))
    have hp := ha.mul ((hc.const_mul (z 1)).sub (hs.const_mul (z 0)))
    have hv : HasDerivAt (fun s : ℝ => ![Real.exp (a*s)*(z 0*Real.cos (b*s)+z 1*Real.sin (b*s)),
        Real.exp (a*s)*(z 1*Real.cos (b*s)-z 0*Real.sin (b*s))])
        ![a*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))+
            b*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t))),
          a*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t)))-
            b*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))] t := by
      apply hasDerivAt_pi.mpr
      intro i
      fin_cases i
      · convert hq using 1 <;> simp [mul_comm] <;> ring
      · convert hp using 1 <;> simp [mul_comm] <;> ring
    convert (PiLp.hasFDerivAt_toLp (𝕜:=ℝ) 2 _).comp_hasDerivAt t hv using 1
    · funext s
      ext i
      fin_cases i <;> simp [eulerLogFlow,a,b]
    · ext i
      fin_cases i <;> simp [eulerLogField,eulerLogFlow,a,b] <;> ring'''
import json,re
from pathlib import Path
extra=Path(__file__).with_name('ch05_elementary_candidates.json')
if extra.exists():proofs.update(json.loads(extra.read_text(encoding='utf-8')))
proofs={k:re.sub(r'(?<![\w.])E n','MolecularDynamics.Chapter05Review.E n',v) for k,v in proofs.items()}
