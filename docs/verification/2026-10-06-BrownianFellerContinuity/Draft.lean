import MolecularDynamics.Chapter06.BrownianTransitionSemigroup
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.Topology.Order.ProjIcc

/-! Uniform-norm zero-time continuity of the genuine original Brownian torus
expectation semigroup. No identification with the Gibbs spectral evolution is assumed. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

private theorem uniform_endpoint_lipschitz (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ≥0, ∀ t ∈ Icc 0 T, LipschitzWith C
      (fun z : (Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ) ↦
        textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1 t z.2) := by
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hPU
  let N : ℝ := ‖textbookBrownianSDENoise m β‖
  let K : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hPU).property
  have hN : 0 ≤ N := norm_nonneg _
  have hK : 0 < K := by dsimp [K]; linarith
  let A : ℝ := 2 * (L * N / K * (Real.exp (K * T) - 1) + N)
  have hA : 0 ≤ A := by
    have : 0 ≤ Real.exp (K * T) - 1 :=
      sub_nonneg.mpr (Real.one_le_exp_iff.mpr (mul_nonneg hK.le hT))
    dsimp [A]
    positivity
  let C : ℝ := Real.exp (K * T) + A
  have hC : 0 ≤ C := add_nonneg (Real.exp_pos _).le hA
  refine ⟨⟨C, hC⟩, fun t ht ↦ LipschitzWith.of_dist_le_mul (fun z w ↦ ?_)⟩
  let q := textbookBrownianPathSolution m hm U hU hPU β hβ T hT z.1 z.2
  let r := textbookBrownianPathSolution m hm U hU hPU β hβ T hT w.1 w.2
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT z.1 z.2
  have hr := textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT w.1 w.2
  have hnoise (s : ℝ) : ‖(textbookLangevinPathNoise T hT z.2 s - textbookLangevinPathNoise T hT z.2 0) -
      (textbookLangevinPathNoise T hT w.2 s - textbookLangevinPathNoise T hT w.2 0)‖ ≤ 2 * dist z.2 w.2 := by
    rw [textbookLangevinPathNoise_zero, textbookLangevinPathNoise_zero, sub_zero, sub_zero]
    let ξ := projIcc 0 T hT s
    let ζ : Icc 0 T := ⟨0, le_rfl, hT⟩
    have he : textbookLangevinPathNoise T hT z.2 s - textbookLangevinPathNoise T hT w.2 s =
        (z.2 ξ - w.2 ξ) - (z.2 ζ - w.2 ζ) := by
      dsimp [textbookLangevinPathNoise, ξ, ζ]
      abel
    have hb (u : Icc 0 T) : ‖z.2 u - w.2 u‖ ≤ dist z.2 w.2 := by
      simpa only [dist_eq_norm] using ContinuousMap.dist_apply_le_dist (f := z.2) (g := w.2) u
    rw [he]
    exact (norm_sub_le _ _).trans ((add_le_add (hb ξ) (hb ζ)).trans_eq (by ring))
  have hb := textbookBrownianIntegralSolution_dist_le m U hU hPU β T (2 * dist z.2 w.2) hT
    z.1 w.1 (textbookLangevinPathNoise T hT z.2) (textbookLangevinPathNoise T hT w.2)
    q r hq hr (fun s _ ↦ hnoise s) t ht
  change dist (q t) (r t) ≤
    gronwallBound (dist z.1 w.1) K (L * N * (2 * dist z.2 w.2)) t + N * (2 * dist z.2 w.2) at hb
  rw [gronwallBound_of_K_ne_0 hK.ne'] at hb
  have hxt : Real.exp (K * t) ≤ Real.exp (K * T) :=
    Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hK.le)
  have hz : dist z.1 w.1 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_left _ _
  have hw : dist z.2 w.2 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_right _ _
  have hat : 2 * (L * N / K * (Real.exp (K * t) - 1) + N) ≤ A := by
    have hcoef : 0 ≤ L * N / K := by positivity
    have hmul := mul_le_mul_of_nonneg_left (sub_le_sub_right hxt 1) hcoef
    dsimp [A]
    linarith
  change dist (q t) (r t) ≤ C * dist z w
  calc
    _ ≤ Real.exp (K * t) * dist z.1 w.1 +
        (2 * (L * N / K * (Real.exp (K * t) - 1) + N)) * dist z.2 w.2 := by
      convert hb using 1
      ring
    _ ≤ Real.exp (K * T) * dist z.1 w.1 + A * dist z.2 w.2 :=
      add_le_add (mul_le_mul_of_nonneg_right hxt (dist_nonneg))
        (mul_le_mul_of_nonneg_right hat (dist_nonneg))
    _ ≤ Real.exp (K * T) * dist z w + A * dist z w :=
      add_le_add (mul_le_mul_of_nonneg_left hz (Real.exp_pos _).le)
        (mul_le_mul_of_nonneg_left hw hA)
    _ = C * dist z w := by dsimp [C]; ring

/-- The actual endpoint is jointly continuous in the real initial state, whole driving path, and time. -/
theorem textbookBrownianPathEndpoint_joint_time_continuous (T : ℝ) (hT : 0 ≤ T) :
    Continuous (fun z : ((Fin Nc → ℝ) × C(Icc 0 T, Fin Nc → ℝ)) × Icc 0 T ↦
      textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1.1 z.2 z.1.2) := by
  obtain ⟨C, hC⟩ := uniform_endpoint_lipschitz m hm U hU hPU β hβ T hT
  apply continuous_prod_of_continuous_lipschitzWith _ C
  · intro z
    exact continuousOn_iff_continuous_domRestrict.mp
      (textbookBrownianPathSolution_integralSolution m hm U hU hPU β hβ T hT z.1 z.2).1
  · intro t
    exact hC t t.property

/-- The same actual torus endpoint is jointly continuous in initial state, whole driving path, and time. -/
theorem textbookBrownianTorusPathEndpoint_joint_time_continuous (T : ℝ) (hT : 0 ≤ T) :
    Continuous (fun z : UnitAddTorus (Fin Nc) × (C(Icc 0 T, Fin Nc → ℝ) × Icc 0 T) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT z.1 z.2.2 z.2.1) := by
  have hq : IsOpenQuotientMap (Prod.map
      (textbookConfigurationTorusProjection (Nc := Nc))
      (id : (C(Icc 0 T, Fin Nc → ℝ) × Icc 0 T) → (C(Icc 0 T, Fin Nc → ℝ) × Icc 0 T))) :=
    (textbookConfigurationTorusProjection_isOpenQuotientMap Nc).prodMap IsOpenQuotientMap.id
  apply hq.isQuotientMap.continuous_iff.mpr
  change Continuous (fun z : (Fin Nc → ℝ) × (C(Icc 0 T, Fin Nc → ℝ) × Icc 0 T) ↦
    textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT
      (textbookConfigurationTorusProjection z.1) z.2.2 z.2.1)
  have he : (fun z : (Fin Nc → ℝ) × (C(Icc 0 T, Fin Nc → ℝ) × Icc 0 T) ↦
      textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT
        (textbookConfigurationTorusProjection z.1) z.2.2 z.2.1) =
      fun z ↦ textbookConfigurationTorusProjection
        (textbookBrownianPathEndpoint m hm U hU hPU β hβ T hT z.1 z.2.2 z.2.1) :=
    funext (fun z ↦ textbookBrownianTorusPathEndpoint_lift m hm U hU hPU β hβ T hT z.1 z.2.2 z.2.2.property z.2.1)
  rw [he]
  exact (textbookConfigurationTorusProjection_isOpenQuotientMap Nc).continuous.comp
    ((textbookBrownianPathEndpoint_joint_time_continuous m hm U hU hPU β hβ T hT).comp
      ((continuous_fst.prodMk continuous_snd.fst).prodMk continuous_snd.snd))

/-- The actual driving path transports a continuous observable to a continuous observable of the initial torus state. -/
def textbookBrownianTorusObservablePathFlow (T : ℝ) (hT : 0 ≤ T)
    (f : C(UnitAddTorus (Fin Nc), ℝ))
    (t : Icc 0 T) (W : C(Icc 0 T, Fin Nc → ℝ)) : C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨fun x ↦ f (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT x t W),
    f.continuous.comp ((textbookBrownianTorusPathEndpoint_joint_continuous
      m hm U hU hPU β hβ T hT t t.property).comp (continuous_id.prodMk continuous_const))⟩

/-- The true observable path flow is jointly continuous in time and noise in the uniform norm. -/
theorem textbookBrownianTorusObservablePathFlow_joint_continuous (T : ℝ) (hT : 0 ≤ T)
    (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    Continuous (fun z : Icc 0 T × C(Icc 0 T, Fin Nc → ℝ) ↦
      textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f z.1 z.2) := by
  apply ContinuousMap.continuous_of_continuous_uncurry
  exact f.continuous.comp
    ((textbookBrownianTorusPathEndpoint_joint_time_continuous m hm U hU hPU β hβ T hT).comp
      (continuous_snd.prodMk (continuous_fst.snd.prodMk continuous_fst.fst)))

/-- Each actual observable flow at zero time is the original observable for every driving path. -/
theorem textbookBrownianTorusObservablePathFlow_initial (T : ℝ) (hT : 0 ≤ T)
    (f : C(UnitAddTorus (Fin Nc), ℝ)) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f ⟨0, le_rfl, hT⟩ W = f := by
  ext x
  exact congrArg f (textbookBrownianTorusPathEndpoint_initial m hm U hU hPU β hβ T hT x W)

/-- The genuine path flow is uniformly bounded by the original observable norm, independent of path and time. -/
theorem textbookBrownianTorusObservablePathFlow_norm_le (T : ℝ) (hT : 0 ≤ T)
    (f : C(UnitAddTorus (Fin Nc), ℝ))
    (t : Icc 0 T) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    ‖textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f t W‖ ≤ ‖f‖ := by
  apply (ContinuousMap.norm_le _ (norm_nonneg f)).mpr
  intro x
  exact f.norm_coe_le_norm _

variable {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The actual observable flow is genuinely Bochner integrable under the true Wiener path law. -/
theorem textbookBrownianTorusObservablePathFlow_integrable (T : ℝ) (hT : 0 ≤ T)
    (f : C(UnitAddTorus (Fin Nc), ℝ)) (t : Icc 0 T) :
    Integrable (textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f t)
      (P.map (textbookWienerVectorContinuousPath B T)) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have hc : Continuous (textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f t) :=
    (textbookBrownianTorusObservablePathFlow_joint_continuous m hm U hU hPU β hβ T hT f).comp
      (continuous_const.prodMk continuous_id)
  exact (integrable_const ‖f‖).mono' hc.aestronglyMeasurable
    (Eventually.of_forall (textbookBrownianTorusObservablePathFlow_norm_le m hm U hU hPU β hβ T hT f t))

include hB in
/-- The true fixed-horizon Wiener Bochner expectation is exactly the same actual probability transition. -/
theorem textbookBrownianTorusContinuousTransition_fixed_horizon
    (T : ℝ) (hT : 0 ≤ T) (f : C(UnitAddTorus (Fin Nc), ℝ)) (t : Icc 0 T) :
    textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB ⟨t, t.property.1⟩ f =
      ∫ W, textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f t W
        ∂P.map (textbookWienerVectorContinuousPath B T) := by
  have hi := textbookBrownianTorusObservablePathFlow_integrable m hm U hU hPU β hβ B P hB T hT f t
  ext x
  let n : ℝ≥0 := ⟨t, t.property.1⟩
  have hp := textbookBrownianTorusTransitionExpectation_actual_probability
    m hm U hU hPU β hβ B P hB n f x
  have hmW : Continuous (fun W : C(Icc 0 T, Fin Nc → ℝ) ↦
      f (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT x t W)) :=
    f.continuous.comp
      ((textbookBrownianTorusPathEndpoint_joint_continuous m hm U hU hPU β hβ T hT t t.property).comp
        (continuous_const.prodMk continuous_id))
  calc
    _ = ∫ sample, f (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω)
        m hm U hU hPU β hβ x B (n : ℝ) sample) ∂P := hp
    _ = ∫ sample, f (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT x t
        (textbookWienerVectorContinuousPath B T sample)) ∂P := by
      apply integral_congr_ae
      filter_upwards [textbookBrownianTorusGlobalRandomConfiguration_history_path_ae m hm U hU hPU β hβ B P hB x]
        with sample hs
      exact congrArg f (hs T hT t t.property)
    _ = ∫ W, f (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT x t W)
        ∂P.map (textbookWienerVectorContinuousPath B T) :=
      (integral_map (textbookWienerVectorContinuousPath_aemeasurable B P hB T) hmW.aestronglyMeasurable).symm
    _ = _ := (ContinuousMap.integral_apply hi x).symm

include hB in
/-- The genuine Wiener Bochner expectation is continuous in time in the actual uniform observable norm. -/
theorem textbookBrownianTorusContinuousTransition_horizon_continuous
    (T : ℝ) (hT : 0 ≤ T) (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    Continuous (fun t : Icc 0 T ↦
      textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB ⟨t, t.property.1⟩ f) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have he : (fun t : Icc 0 T ↦
      textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB ⟨t, t.property.1⟩ f) =
      fun t ↦ ∫ W, textbookBrownianTorusObservablePathFlow m hm U hU hPU β hβ T hT f t W
        ∂P.map (textbookWienerVectorContinuousPath B T) :=
    funext (textbookBrownianTorusContinuousTransition_fixed_horizon m hm U hU hPU β hβ B P hB T hT f)
  rw [he]
  apply continuous_of_dominated (bound := fun _ ↦ ‖f‖)
  · intro t
    exact (textbookBrownianTorusObservablePathFlow_integrable m hm U hU hPU β hβ B P hB T hT f t).aestronglyMeasurable
  · intro t
    exact Eventually.of_forall (textbookBrownianTorusObservablePathFlow_norm_le m hm U hU hPU β hβ T hT f t)
  · exact integrable_const _
  · exact Eventually.of_forall (fun W ↦
      (textbookBrownianTorusObservablePathFlow_joint_continuous m hm U hU hPU β hβ T hT f).comp
        (continuous_id.prodMk continuous_const))

include hB in
/-- The actual probability transition is strongly continuous on the entire nonnegative time domain in the uniform norm. -/
theorem textbookBrownianTorusContinuousTransition_time_continuous
    (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    Continuous (fun t : ℝ≥0 ↦ textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB t f) := by
  apply continuous_iff_continuousAt.mpr
  intro t
  let T : ℝ := t + 1
  have hT : 0 ≤ T := add_nonneg t.property zero_le_one
  have htT : (t : ℝ) < T := by dsimp [T]; linarith
  have hc := (textbookBrownianTorusContinuousTransition_horizon_continuous
    m hm U hU hPU β hβ B P hB T hT f).comp
      ((continuous_projIcc (a := (0 : ℝ)) (b := T) (h := hT)).comp NNReal.continuous_coe)
  have he : (fun s : ℝ≥0 ↦
      textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB s f) =ᶠ[𝓝 t]
      fun s ↦ textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB
        ⟨(projIcc 0 T hT (s : ℝ) : ℝ), (projIcc 0 T hT (s : ℝ)).property.1⟩ f := by
    filter_upwards [((NNReal.continuous_coe).continuousAt.tendsto.eventually (gt_mem_nhds htT))] with s hs
    have hp : (projIcc 0 T hT (s : ℝ) : ℝ) = s := by
      change max 0 (min T (s : ℝ)) = (s : ℝ)
      exact (congrArg (max (0 : ℝ)) (min_eq_right hs.le)).trans (max_eq_right s.property)
    exact congrArg (fun v : ℝ≥0 ↦ textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB v f)
      (NNReal.eq hp.symm)
  exact hc.continuousAt.congr_of_eventuallyEq he

include hB in
/-- The genuine original Brownian probability semigroup has its true C0 limit, in the whole uniform norm. -/
theorem textbookBrownianTorusContinuousTransition_c0
    (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    Tendsto (fun t : ℝ≥0 ↦ textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB t f)
      (𝓝 0) (𝓝 f) := by
  simpa only [textbookBrownianTorusContinuousTransition_zero m hm U hU hPU β hβ B P hB f] using
    (textbookBrownianTorusContinuousTransition_time_continuous m hm U hU hPU β hβ B P hB f).tendsto 0

private def probabilityTransitionLinear (T : ℝ≥0) :
    C(UnitAddTorus (Fin Nc), ℝ) →ₗ[ℝ] C(UnitAddTorus (Fin Nc), ℝ) where
  toFun := textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T
  map_add' := textbookBrownianTorusContinuousTransition_map_add m hm U hU hPU β hβ B P hB T
  map_smul' := textbookBrownianTorusContinuousTransition_map_smul m hm U hU hPU β hβ B P hB T

/-- The same actual probability expectation is a bounded linear operator on the entire continuous-observable space. -/
def textbookBrownianTorusProbabilityOperator (T : ℝ≥0) :
    C(UnitAddTorus (Fin Nc), ℝ) →L[ℝ] C(UnitAddTorus (Fin Nc), ℝ) :=
  (probabilityTransitionLinear m hm U hU hPU β hβ B P hB T).mkContinuous 1
    (fun f ↦ by
      change ‖textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f‖ ≤ 1 * ‖f‖
      exact (textbookBrownianTorusContinuousTransition_norm_le m hm U hU hPU β hβ B P hB T f).trans_eq (one_mul ‖f‖).symm)

/-- The bounded probability operator is exactly the same actual transition expectation at every initial torus state. -/
theorem textbookBrownianTorusProbabilityOperator_apply
    (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) (x : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T f x =
      textbookBrownianTorusTransitionExpectation m hm U hU hPU β hβ B P T f x := rfl

/-- The actual probability operator has true operator norm at most one. -/
theorem textbookBrownianTorusProbabilityOperator_norm_le_one (T : ℝ≥0) :
    ‖textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T‖ ≤ 1 := by
  apply ContinuousLinearMap.opNorm_le_bound _ zero_le_one
  intro f
  change ‖textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f‖ ≤ 1 * ‖f‖
  exact (textbookBrownianTorusContinuousTransition_norm_le m hm U hU hPU β hβ B P hB T f).trans_eq (one_mul ‖f‖).symm

/-- The genuine probability operator begins at the full-space identity. -/
theorem textbookBrownianTorusProbabilityOperator_zero :
    textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB 0 = ContinuousLinearMap.id ℝ _ := by
  ext f x
  exact congrArg (fun g : C(UnitAddTorus (Fin Nc), ℝ) ↦ g x)
    (textbookBrownianTorusContinuousTransition_zero m hm U hU hPU β hβ B P hB f)

/-- The actual bounded probability operators obey the true semigroup composition law. -/
theorem textbookBrownianTorusProbabilityOperator_add (S T : ℝ≥0) :
    textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB (S + T) =
      (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB S).comp
        (textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB T) := by
  ext f x
  exact congrArg (fun g : C(UnitAddTorus (Fin Nc), ℝ) ↦ g x)
    (textbookBrownianTorusContinuousTransition_add m hm U hU hPU β hβ B P hB S T f)

/-- The actual bounded probability semigroup has the true full-space C0 limit in the uniform norm. -/
theorem textbookBrownianTorusProbabilityOperator_c0 (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    Tendsto (fun t : ℝ≥0 ↦ textbookBrownianTorusProbabilityOperator m hm U hU hPU β hβ B P hB t f)
      (𝓝 0) (𝓝 f) :=
  textbookBrownianTorusContinuousTransition_c0 m hm U hU hPU β hβ B P hB f

end
end MolecularDynamics