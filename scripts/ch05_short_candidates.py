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
proofs['LiouvilleProduct']='''intro n f ρ z hf hρ
  have hd := hρ.hasFDerivAt.smul hf.hasFDerivAt
  unfold MolecularDynamics.Chapter05Review.liouvillian MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.lie
  rw [hd.fderiv]
  simp only [ContinuousLinearMap.toLinearMap_add,ContinuousLinearMap.toLinearMap_smul,
    LinearMap.trace_add,LinearMap.trace_smul,ContinuousLinearMap.toLinearMap_smulRight,
    LinearMap.trace_smulRight]
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
