import MolecularDynamics.Chapter06.BrownianTorusModel
import Mathlib.Probability.Kernel.Composition.MeasureComp
import Mathlib.Probability.Kernel.Composition.IntegralCompProd
import Mathlib.Topology.ContinuousMap.Compact

/-! The original Brownian torus probability semigroup and its actual continuous-observable
expectations. Identification with the Gibbs spectral evolution remains a separate gap. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

private theorem completion_map_aemeasurable {Ω X : Type*} [MeasurableSpace Ω]
    [MeasurableSpace X] (P : Measure Ω) (f : Ω → X) (hf : AEMeasurable f P) :
    @Measure.map (NullMeasurableSpace Ω P) X inferInstance inferInstance f P.completion =
      P.map f := by
  ext s hs
  rw [Measure.map_apply hf.nullMeasurable.measurable' hs,
    Measure.map_apply_of_aemeasurable hf hs]
  rfl

variable {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)

/-- The actual torus endpoint begins at the stated initial configuration for every continuous noise path. -/
theorem textbookBrownianTorusPathEndpoint_initial (T : ℝ) (hT : 0 ≤ T)
    (x : UnitAddTorus (Fin Nc)) (W : C(Icc 0 T, Fin Nc → ℝ)) :
    textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T hT x 0 W = x := by
  unfold textbookBrownianTorusPathEndpoint
  rw [textbookBrownianPathEndpoint_initial]
  exact textbookConfigurationTorusRepresentative_projects x

variable {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The same actual torus probability transition family has its genuine zero-time identity. -/
theorem textbookBrownianTorusTransitionKernel_zero :
    textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P 0 = Kernel.id := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  ext x : 1
  rw [textbookBrownianTorusTransitionKernel_apply m hm U hU hPU β hβ B P hB 0 x,
    Kernel.id_apply]
  have he : textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ 0 (by simp) x 0 =
      (fun _ ↦ x) :=
    funext (textbookBrownianTorusPathEndpoint_initial m hm U hU hPU β hβ 0 (by simp) x)
  change (P.map (textbookWienerVectorContinuousPath B 0)).map
    (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ 0 (by simp) x 0) = Measure.dirac x
  rw [he, Measure.map_const, measure_univ, one_smul]

include hB in
/-- The actual future marginal equals the genuine transition kernel applied to the actual present law. -/
theorem textbookBrownianTorusGlobalRandomConfiguration_transition_marginal
    (x : UnitAddTorus (Fin Nc)) (S T : ℝ≥0) :
    P.map (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B ((S : ℝ) + T)) =
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T ∘ₘ
        P.map (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B S) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsProbabilityMeasure P.completion := ⟨by change P univ = 1; exact measure_univ⟩
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  let κ : Kernel (textbookWienerVectorCompletedHistorySpace B P hB S) (UnitAddTorus (Fin Nc)) :=
    (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T).comap
      (fun sample : textbookWienerVectorCompletedHistorySpace B P hB S ↦
        textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B S sample)
      (textbookBrownianTorusGlobalRandomConfiguration_adapted m hm U hU hPU β hβ B P hB x S)
  have : IsMarkovKernel κ := by
    refine ⟨fun sample ↦ ⟨?_⟩⟩
    change (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T
      (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B S sample)) univ = 1
    exact measure_univ
  have mH := textbookWienerVectorCompletedHistoryObservation_measurable B P hB S
  have mS := textbookBrownianTorusGlobalRandomConfiguration_endpoint_aemeasurable
    m hm U hU hPU β hβ B P hB x S S.property
  have mY := textbookBrownianTorusGlobalRandomConfiguration_endpoint_aemeasurable
    m hm U hU hPU β hβ B P hB x ((S : ℝ) + T) (add_nonneg S.property T.property)
  have hj := congrArg Measure.snd
    (textbookBrownianTorusGlobalRandomConfiguration_completed_history_transition_joint_law
      m hm U hU hPU β hβ B P hB x S T)
  change (@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance (fun sample ↦
    (textbookWienerVectorCompletedHistoryObservation B P hB S sample,
      textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B ((S : ℝ) + T) sample)) P.completion).snd =
      ((@Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
        (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion) ⊗ₘ κ).snd at hj
  rw [Measure.snd_map_prodMk mH mY.nullMeasurable.measurable', Measure.snd_compProd] at hj
  have he : @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
      (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B ((S : ℝ) + T)) P.completion =
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T ∘ₘ
        @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
          (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B S) P.completion := by
    calc
      _ = κ ∘ₘ @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
          (textbookWienerVectorCompletedHistoryObservation B P hB S) P.completion := hj
      _ = _ := by
        ext a ha
        rw [Measure.bind_apply ha (Kernel.aemeasurable _), Measure.bind_apply ha (Kernel.aemeasurable _),
          lintegral_map' (Kernel.measurable_coe _ ha).aemeasurable mH.aemeasurable,
          lintegral_map' (Kernel.measurable_coe _ ha).aemeasurable mS.nullMeasurable.measurable'.aemeasurable]
        rfl
  calc
    _ = @Measure.map (NullMeasurableSpace Ω P) _ inferInstance inferInstance
        (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B ((S : ℝ) + T))
        P.completion := (completion_map_aemeasurable P _ mY).symm
    _ = _ := he
    _ = _ := congrArg (fun μ : Measure (UnitAddTorus (Fin Nc)) ↦
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T ∘ₘ μ)
        (completion_map_aemeasurable P _ mS)

include hB in
/-- Genuine Chapman–Kolmogorov law of the same original torus Brownian transition family. -/
theorem textbookBrownianTorusTransitionKernel_add (S T : ℝ≥0) :
    textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P (S + T) =
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T ∘ₖ
        textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P S := by
  ext x : 1
  rw [textbookBrownianTorusTransitionKernel_global_law m hm U hU hPU β hβ B P hB (S + T) x,
    Kernel.comp_apply,
    textbookBrownianTorusTransitionKernel_global_law m hm U hU hPU β hβ B P hB S x]
  exact textbookBrownianTorusGlobalRandomConfiguration_transition_marginal
    m hm U hU hPU β hβ B P hB x S T

include hB in
/-- The original model gives a genuine probability-kernel semigroup, with all model regularity derived. -/
theorem textbookBrownianTorusTransitionKernel_semigroup :
    (∀ T, IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T)) ∧
      textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P 0 = Kernel.id ∧
      ∀ S T, textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P (S + T) =
        textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T ∘ₖ
          textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P S :=
  ⟨textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB,
    textbookBrownianTorusTransitionKernel_zero m hm U hU hPU β hβ B P hB,
    textbookBrownianTorusTransitionKernel_add m hm U hU hPU β hβ B P hB⟩

/-- The true probability expectation of a continuous configuration observable under the actual transition law. -/
def textbookBrownianTorusTransitionExpectation (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ))
    (x : UnitAddTorus (Fin Nc)) : ℝ :=
  ∫ y, f y ∂textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x

include hB in
/-- The same probability expectation is literally integration of the actual endpoint against Wiener path law. -/
theorem textbookBrownianTorusTransitionExpectation_wiener_path
    (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) (x : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusTransitionExpectation m hm U hU hPU β hβ B P T f x =
      ∫ W, f (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T T.property x T W)
        ∂P.map (textbookWienerVectorContinuousPath B T) := by
  unfold textbookBrownianTorusTransitionExpectation
  rw [textbookBrownianTorusTransitionKernel_apply m hm U hU hPU β hβ B P hB T x]
  exact integral_map
    (textbookBrownianTorusPathEndpoint_measurable m hm U hU hPU β hβ T T.property x T
      ⟨T.property, le_rfl⟩).aemeasurable f.continuous.aestronglyMeasurable

include hB in
/-- This is the probability expectation of the same actual global torus process, rather than a time average. -/
theorem textbookBrownianTorusTransitionExpectation_actual_probability
    (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) (x : UnitAddTorus (Fin Nc)) :
    textbookBrownianTorusTransitionExpectation m hm U hU hPU β hβ B P T f x =
      ∫ sample, f (textbookBrownianTorusGlobalRandomConfiguration (Ω := Ω) m hm U hU hPU β hβ x B T sample) ∂P := by
  unfold textbookBrownianTorusTransitionExpectation
  rw [textbookBrownianTorusTransitionKernel_global_law m hm U hU hPU β hβ B P hB T x]
  exact integral_map
    (textbookBrownianTorusGlobalRandomConfiguration_endpoint_aemeasurable
      m hm U hU hPU β hβ B P hB x T T.property) f.continuous.aestronglyMeasurable

include hB in
/-- The actual expectation of every continuous observable is continuous in the true torus initial state. -/
theorem textbookBrownianTorusTransitionExpectation_continuous
    (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    Continuous (textbookBrownianTorusTransitionExpectation m hm U hU hPU β hβ B P T f) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let μ := P.map (textbookWienerVectorContinuousPath B T)
  have hE := textbookBrownianTorusPathEndpoint_joint_continuous
    m hm U hU hPU β hβ T T.property T ⟨T.property, le_rfl⟩
  have he : textbookBrownianTorusTransitionExpectation m hm U hU hPU β hβ B P T f =
      fun x ↦ ∫ W, f (textbookBrownianTorusPathEndpoint m hm U hU hPU β hβ T T.property x T W) ∂μ :=
    funext (textbookBrownianTorusTransitionExpectation_wiener_path m hm U hU hPU β hβ B P hB T f)
  rw [he]
  apply continuous_of_dominated (bound := fun _ ↦ ‖f‖)
  · intro x
    exact (f.continuous.comp (hE.comp (continuous_const.prodMk continuous_id))).aestronglyMeasurable
  · intro x
    exact Eventually.of_forall (fun W ↦ f.norm_coe_le_norm _)
  · exact integrable_const _
  · exact Eventually.of_forall (fun W ↦
      f.continuous.comp (hE.comp (continuous_id.prodMk continuous_const)))

/-- The same genuine expectation, packaged as a continuous configuration observable. -/
def textbookBrownianTorusContinuousTransition (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    C(UnitAddTorus (Fin Nc), ℝ) :=
  ⟨textbookBrownianTorusTransitionExpectation m hm U hU hPU β hβ B P T f,
    textbookBrownianTorusTransitionExpectation_continuous m hm U hU hPU β hβ B P hB T f⟩

/-- The actual continuous-observable transition is exactly the identity at zero time. -/
theorem textbookBrownianTorusContinuousTransition_zero (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB 0 f = f := by
  ext x
  change (∫ y, f y ∂textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P 0 x) = f x
  rw [textbookBrownianTorusTransitionKernel_zero m hm U hU hPU β hβ B P hB, Kernel.id_apply]
  exact integral_dirac _ _

/-- The actual continuous-observable transition obeys the true expectation semigroup law. -/
theorem textbookBrownianTorusContinuousTransition_add
    (S T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB (S + T) f =
      textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB S
        (textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P S) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB S
  ext x
  change (∫ y, f y ∂textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P (S + T) x) = _
  rw [textbookBrownianTorusTransitionKernel_add m hm U hU hPU β hβ B P hB S T]
  apply Kernel.integral_comp
  exact (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable
    (Eventually.of_forall f.norm_coe_le_norm)

/-- Every genuine transition contracts the uniform norm of continuous configuration observables. -/
theorem textbookBrownianTorusContinuousTransition_norm_le
    (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    ‖textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f‖ ≤ ‖f‖ := by
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  apply (ContinuousMap.norm_le _ (norm_nonneg f)).mpr
  intro x
  change ‖∫ y, f y ∂textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x‖ ≤ ‖f‖
  simpa using norm_integral_le_of_norm_le_const
    (μ := textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x)
    (Eventually.of_forall f.norm_coe_le_norm)

/-- The genuine probability transition preserves positivity. -/
theorem textbookBrownianTorusContinuousTransition_nonneg
    (T : ℝ≥0) (f : C(UnitAddTorus (Fin Nc), ℝ)) (hf : ∀ x, 0 ≤ f x)
    (x : UnitAddTorus (Fin Nc)) :
    0 ≤ textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f x :=
  integral_nonneg hf

/-- Genuine probability transitions preserve every constant observable. -/
theorem textbookBrownianTorusContinuousTransition_const (T : ℝ≥0) (c : ℝ) :
    textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T
      (ContinuousMap.const _ c) = ContinuousMap.const _ c := by
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  ext x
  change (∫ _, c ∂textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x) = c
  simp

/-- The same actual transition is additive on continuous observables. -/
theorem textbookBrownianTorusContinuousTransition_map_add
    (T : ℝ≥0) (f g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T (f + g) =
      textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f +
        textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T g := by
  have : IsMarkovKernel (textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T) :=
    textbookBrownianTorusTransitionKernel_isMarkov m hm U hU hPU β hβ B P hB T
  ext x
  change (∫ y, f y + g y ∂textbookBrownianTorusTransitionKernel m hm U hU hPU β hβ B P T x) = _
  apply integral_add
  · exact (integrable_const ‖f‖).mono' f.continuous.aestronglyMeasurable
      (Eventually.of_forall f.norm_coe_le_norm)
  · exact (integrable_const ‖g‖).mono' g.continuous.aestronglyMeasurable
      (Eventually.of_forall g.norm_coe_le_norm)

/-- The same actual transition is homogeneous on continuous observables. -/
theorem textbookBrownianTorusContinuousTransition_map_smul
    (T : ℝ≥0) (c : ℝ) (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T (c • f) =
      c • textbookBrownianTorusContinuousTransition m hm U hU hPU β hβ B P hB T f := by
  ext x
  exact integral_smul c _

end
end MolecularDynamics