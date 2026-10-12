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
import json,re
from pathlib import Path
extra=Path(__file__).with_name('ch05_elementary_candidates.json')
if extra.exists():proofs.update(json.loads(extra.read_text(encoding='utf-8')))
proofs={k:re.sub(r'(?<![\w.])E n','MolecularDynamics.Chapter05Review.E n',v) for k,v in proofs.items()}
