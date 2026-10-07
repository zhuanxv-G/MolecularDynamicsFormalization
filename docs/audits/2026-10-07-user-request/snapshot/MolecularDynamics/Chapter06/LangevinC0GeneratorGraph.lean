import MolecularDynamics.Chapter06.LangevinC0StrongContinuity
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Topology.Algebra.Module.LinearPMap
import Mathlib.Analysis.Calculus.TangentCone.Real

/-! The genuine closed generator of the same original C0 semigroup.
The graph is the right norm derivative, not a chosen closed extension. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (hγ : 0 < γ)

local notation "E" => C₀(textbookLangevinPeriodicPhase N, ℝ)
local notation "S" => textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ

private theorem genC0_orbit_continuous (f : E) :
    Continuous (fun t : ℝ ↦ S t.toNNReal f) :=
  (textbookLangevinPeriodicC0Transition_strong_continuous B P hB U hU hp L hF γ σ hγ f).comp
    continuous_real_toNNReal

private theorem genC0_contract (T : ℝ≥0) (f : E) : ‖S T f‖ ≤ ‖f‖ :=
  ((S T).le_opNorm f).trans
    ((mul_le_mul_of_nonneg_right
      (textbookLangevinPeriodicC0Transition_norm_le B P hB U hU hp L hF γ σ hγ T)
      (norm_nonneg f)).trans_eq (one_mul _))

private def genC0_integralLinear (T : ℝ≥0) : E →ₗ[ℝ] E where
  toFun g := ∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g
  map_add' f g := by
    simp only [map_add]
    exact intervalIntegral.integral_add
      ((genC0_orbit_continuous B P hB U hU hp L hF γ σ hγ f).intervalIntegrable _ _)
      ((genC0_orbit_continuous B P hB U hU hp L hF γ σ hγ g).intervalIntegrable _ _)
  map_smul' r f := by
    simp only [map_smul]
    exact intervalIntegral.integral_smul r _

private def genC0_integral (T : ℝ≥0) : E →L[ℝ] E :=
  (genC0_integralLinear B P hB U hU hp L hF γ σ hγ T).mkContinuous T (fun f ↦ by
    change ‖∫ s : ℝ in 0..(T : ℝ), S s.toNNReal f‖ ≤ (T : ℝ) * ‖f‖
    have hh := intervalIntegral.norm_integral_le_of_norm_le_const
      (a := (0 : ℝ)) (b := (T : ℝ))
      (fun s _ ↦ genC0_contract B P hB U hU hp L hF γ σ hγ s.toNNReal f)
    simpa [mul_comm] using hh)

/-- The literal right norm-derivative graph of the same original transition.
No closedness, test-function domain or graph-core premise is supplied. -/
def textbookLangevinPeriodicC0GeneratorGraph : Submodule ℝ (E × E) where
  carrier := {fg | HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal fg.1) fg.2 (Ici 0) 0}
  zero_mem' := by
    change HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal (0 : E)) 0 (Ici 0) 0
    simpa only [map_zero] using
      (hasDerivWithinAt_const (x := (0 : ℝ)) (s := Ici 0) (c := (0 : E)))
  add_mem' {a b} ha hb := by
    change HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal (a.1 + b.1)) (a.2 + b.2) (Ici 0) 0
    simpa only [map_add, Pi.add_apply] using! ha.add hb
  smul_mem' r a ha := by
    change HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal (r • a.1)) (r • a.2) (Ici 0) 0
    simpa only [map_smul, Pi.smul_apply] using! ha.const_smul r

/-- The true right norm derivative is unique, so this linear relation is a graph. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_unique (f g k : E)
    (hg : (f, g) ∈ textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ)
    (hk : (f, k) ∈ textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ) :
    g = k := by
  change HasDerivWithinAt _ g (Ici 0) 0 at hg
  change HasDerivWithinAt _ k (Ici 0) 0 at hk
  exact (hg.derivWithin (uniqueDiffWithinAt_Ici 0)).symm.trans
    (hk.derivWithin (uniqueDiffWithinAt_Ici 0))

/-- Actual Chapman-Kolmogorov propagates the derivative to every right time. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_orbit_right_derivative (f g : E)
    (hg : (f, g) ∈ textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ)
    (t : ℝ) (ht : 0 ≤ t) :
    HasDerivWithinAt (fun s : ℝ ↦ S s.toNNReal f) (S t.toNNReal g) (Ici t) t := by
  change HasDerivWithinAt (fun s : ℝ ↦ S s.toNNReal f) g (Ici 0) 0 at hg
  have hcl := (S t.toNNReal).hasFDerivAt.comp_hasDerivWithinAt 0 hg
  have hshift := hcl.scomp_of_eq t ((hasDerivAt_id t).sub_const t).hasDerivWithinAt
    (show MapsTo (fun s : ℝ ↦ s - t) (Ici t) (Ici 0) from
      fun s hs ↦ by
        change 0 ≤ s - t
        exact sub_nonneg.mpr hs) (by simp)
  have hd : HasDerivWithinAt (fun s : ℝ ↦ S t.toNNReal (S (s - t).toNNReal f))
      (S t.toNNReal g) (Ici t) t := by
    simpa only [Function.comp_apply, one_smul, id_eq] using! hshift
  apply hd.congr_of_mem _ (mem_Ici.mpr le_rfl)
  intro s hs
  have he : t.toNNReal + (s - t).toNNReal = s.toNNReal := by
    apply NNReal.eq
    simp only [NNReal.coe_add, Real.coe_toNNReal t ht,
      Real.coe_toNNReal (s - t) (sub_nonneg.mpr hs), Real.coe_toNNReal s (ht.trans hs)]
    ring
  rw [← he, textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ,
    ContinuousLinearMap.comp_apply]

/-- The genuine derivative graph is exactly the actual integrated orbit identity.
This equivalence, proved by the one-sided FTC, will yield closedness. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_integrated_iff (f g : E) :
    (f, g) ∈ textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ ↔
      ∀ T : ℝ≥0, (∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g) = S T f - f := by
  constructor
  · intro hg T
    have hc := genC0_orbit_continuous B P hB U hU hp L hF γ σ hγ
    have he := intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le T.property
      (hc f).continuousOn
      (fun t ht ↦ (textbookLangevinPeriodicC0GeneratorGraph_orbit_right_derivative
        B P hB U hU hp L hF γ σ hγ f g hg t ht.1.le).mono Ioi_subset_Ici_self)
      ((hc g).intervalIntegrable _ _)
    have hT : (T : ℝ).toNNReal = T := Real.toNNReal_coe
    change (∫ s : ℝ in 0..(T : ℝ), S s.toNNReal g) = S (T : ℝ).toNNReal f - S (0 : ℝ).toNNReal f at he
    rw [hT, Real.toNNReal_zero, textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.id_apply] at he
    exact he
  · intro h
    change HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal f) g (Ici 0) 0
    have hd := ((genC0_orbit_continuous B P hB U hU hp L hF γ σ hγ g).integral_hasStrictDerivAt
      0 0).hasDerivAt.add_const f
    have hd' : HasDerivWithinAt
        (fun t : ℝ ↦ (∫ s : ℝ in 0..t, S s.toNNReal g) + f) g (Ici 0) 0 := by
      simpa only [Real.toNNReal_zero,
        textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
        ContinuousLinearMap.id_apply] using hd.hasDerivWithinAt
    apply hd'.congr_of_mem _ (mem_Ici.mpr le_rfl)
    intro t ht
    have he := h ⟨t, ht⟩
    have htNN : t.toNNReal = ⟨t, ht⟩ := Real.toNNReal_of_nonneg ht
    rw [htNN]
    exact eq_add_of_sub_eq he.symm

/-- The actual generator graph is closed in the product sup norm topology. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_isClosed :
    IsClosed (textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ : Set (E × E)) := by
  have he : (textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ : Set (E × E)) =
      ⋂ T : ℝ≥0, {fg : E × E | genC0_integral B P hB U hU hp L hF γ σ hγ T fg.2 = S T fg.1 - fg.1} := by
    ext fg
    simp only [mem_iInter, mem_ofPred_eq]
    exact textbookLangevinPeriodicC0GeneratorGraph_integrated_iff B P hB U hU hp L hF γ σ hγ fg.1 fg.2
  rw [he]
  apply isClosed_iInter
  intro T
  exact isClosed_eq
    ((genC0_integral B P hB U hU hp L hF γ σ hγ T).continuous.comp continuous_snd)
    (((S T).continuous.comp continuous_fst).sub continuous_fst)

/-- The actual generator is the partially defined linear operator determined by
the genuine right norm derivative graph, with its derived domain. -/
def textbookLangevinPeriodicC0Generator : E →ₗ.[ℝ] E :=
  (textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ).toLinearPMap

/-- The operator's graph is exactly the proved original derivative graph. -/
theorem textbookLangevinPeriodicC0Generator_graph :
    (textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ).graph =
      textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ := by
  apply Submodule.toLinearPMap_graph_eq
  intro fg hfg hf
  have hz : (fg.1, 0) ∈ textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ := by
    rw [hf]
    exact (textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ).zero_mem
  exact textbookLangevinPeriodicC0GeneratorGraph_unique B P hB U hU hp L hF γ σ hγ fg.1 fg.2 0 hfg hz

/-- Closedness is proved for the actual generator, without assuming a graph core
or identifying compact C2 tests with its domain. -/
theorem textbookLangevinPeriodicC0Generator_isClosed :
    (textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ).IsClosed := by
  rw [LinearPMap.IsClosed, textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ]
  exact textbookLangevinPeriodicC0GeneratorGraph_isClosed B P hB U hU hp L hF γ σ hγ

/-- Every genuine time integral of an original orbit belongs to the derivative
graph; its derivative is the actual endpoint difference. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_time_integral (f : E) (T : ℝ≥0) :
    ((∫ s : ℝ in 0..(T : ℝ), S s.toNNReal f), S T f - f) ∈
      textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ := by
  let c : ℝ → E := fun s ↦ S s.toNNReal f
  have hc : Continuous c := genC0_orbit_continuous B P hB U hU hp L hF γ σ hγ f
  have hTop := (hc.integral_hasStrictDerivAt 0 (T : ℝ)).hasDerivAt.scomp_of_eq 0
    ((hasDerivAt_id 0).add_const (T : ℝ)) (by simp)
  have hBottom := (hc.integral_hasStrictDerivAt 0 0).hasDerivAt
  have hd : HasDerivWithinAt
      (fun s : ℝ ↦ (∫ v : ℝ in 0..s + (T : ℝ), c v) - ∫ v : ℝ in 0..s, c v)
      (S T f - f) (Ici 0) 0 := by
    simpa only [Function.comp_apply, zero_add, one_smul, c, Real.toNNReal_coe,
      Real.toNNReal_zero, textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.id_apply] using! (hTop.sub hBottom).hasDerivWithinAt
  have hd' : HasDerivWithinAt (fun s : ℝ ↦ ∫ v : ℝ in s..s + (T : ℝ), c v)
      (S T f - f) (Ici 0) 0 := by
    apply hd.congr_of_mem _ (mem_Ici.mpr le_rfl)
    intro s _
    have he := intervalIntegral.integral_add_adjacent_intervals
      (hc.intervalIntegrable (μ := volume) 0 s) (hc.intervalIntegrable (μ := volume) s (s + T))
    rw [← he]
    abel
  change HasDerivWithinAt
    (fun s : ℝ ↦ S s.toNNReal (∫ v : ℝ in 0..(T : ℝ), S v.toNNReal f))
    (S T f - f) (Ici 0) 0
  apply hd'.congr_of_mem _ (mem_Ici.mpr le_rfl)
  intro s hs
  rw [← (S s.toNNReal).intervalIntegral_comp_comm (hc.intervalIntegrable 0 T)]
  have he : (∫ v : ℝ in 0..(T : ℝ), S s.toNNReal (S v.toNNReal f)) =
      ∫ v : ℝ in 0..(T : ℝ), c (v + s) := by
    apply intervalIntegral.integral_congr_uIoo
    intro v hv
    have hv0 : 0 ≤ v := (le_min (le_refl (0 : ℝ)) T.property).trans hv.1.le
    have heTime : (v + s).toNNReal = s.toNNReal + v.toNNReal := by
      apply NNReal.eq
      simp only [NNReal.coe_add, Real.coe_toNNReal s hs, Real.coe_toNNReal v hv0,
        Real.coe_toNNReal (v + s) (add_nonneg hv0 hs)]
      ring
    dsimp [c]
    rw [heTime, textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.comp_apply]
  rw [he, intervalIntegral.integral_comp_add_right, zero_add, add_comm (T : ℝ) s]

/-- The actual generator domain is dense in the original C0 sup norm space.
Short-time orbit averages supply genuine domain elements converging to every
C0 function; density is derived, not assumed. -/
theorem textbookLangevinPeriodicC0Generator_domain_dense :
    Dense ((textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ).domain : Set E) := by
  intro f
  have hc := genC0_orbit_continuous B P hB U hU hp L hF γ σ hγ f
  have hd : HasDerivAt (fun t : ℝ ↦ ∫ s : ℝ in 0..t, S s.toNNReal f) f 0 := by
    simpa only [Real.toNNReal_zero,
      textbookLangevinPeriodicC0Transition_zero B P hB U hU hp L hF γ σ hγ,
      ContinuousLinearMap.id_apply] using! (hc.integral_hasStrictDerivAt 0 0).hasDerivAt
  have hLim : Tendsto (fun t : ℝ ↦ t⁻¹ • (∫ s : ℝ in 0..t, S s.toNNReal f))
      (𝓝[>] 0) (𝓝 f) := by
    have hh := (hasDerivWithinAt_iff_tendsto_slope'
      (s := Ioi (0 : ℝ)) (x := 0) (by simp : (0 : ℝ) ∉ Ioi 0)).mp hd.hasDerivWithinAt
    convert! hh using 1
    first | rfl | (ext t; simp [slope])
  apply mem_closure_of_tendsto hLim
  filter_upwards [self_mem_nhdsWithin] with t ht
  change t⁻¹ • (∫ s : ℝ in 0..t, S s.toNNReal f) ∈
    (textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ).map
      (LinearMap.fst ℝ E E)
  apply Submodule.mem_map.mpr
  refine ⟨t⁻¹ • ((∫ s : ℝ in 0..(t.toNNReal : ℝ), S s.toNNReal f), S t.toNNReal f - f), ?_, ?_⟩
  · exact (textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ).smul_mem t⁻¹
      (textbookLangevinPeriodicC0GeneratorGraph_time_integral B P hB U hU hp L hF γ σ hγ f t.toNNReal)
  · change t⁻¹ • (∫ s : ℝ in 0..(t.toNNReal : ℝ), S s.toNNReal f) =
      t⁻¹ • (∫ s : ℝ in 0..t, S s.toNNReal f)
    rw [Real.coe_toNNReal t ht.le]

end
end MolecularDynamics
