import MolecularDynamics.Chapter06.WienerBridgeSupport
import Mathlib.MeasureTheory.Constructions.Projective

/-! Actual countable sample laws, necessary to transfer short tubes to independent Brownian segments. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology NNReal ENNReal

namespace MolecularDynamics

/-- Genuine finite samples have the actual projective Brownian law, even when sample times repeat. -/
theorem textbookWienerSamples_finiteLaw {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (t : ℕ → ℝ≥0) (I : Finset ℕ) :
    P.map (fun ω (i : I) ↦ B (t i) ω) =
      (BrownianReal.projectiveFamily (I.image t)).map
        (fun z (i : I) ↦ z ⟨t i, Finset.mem_image.mpr ⟨i, i.2, rfl⟩⟩) := by
  classical
  let J := I.image t
  let f : (J → ℝ) → (I → ℝ) := fun z i ↦ z ⟨t i, Finset.mem_image.mpr ⟨i, i.2, rfl⟩⟩
  have mf : Measurable f := by fun_prop
  have hl := (hasLaw_map mf.aemeasurable).comp (hB.hasLaw J)
  exact hl.map_eq

/-- Actual finite projection uniqueness gives equality of the entire countable sample law. -/
theorem textbookWienerSamples_law_eq {Ω Ω' : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (C : ℝ≥0 → Ω' → ℝ) (Q : Measure Ω') (hC : IsPreBrownianReal C Q) (t : ℕ → ℝ≥0) :
    P.map (fun ω n ↦ B (t n) ω) = Q.map (fun ω n ↦ C (t n) ω) := by
  have : IsProbabilityMeasure P := hB.isGaussianProcess.isProbabilityMeasure
  have : IsProbabilityMeasure Q := hC.isGaussianProcess.isProbabilityMeasure
  let μ := P.map (fun ω n ↦ B (t n) ω)
  let ν := Q.map (fun ω n ↦ C (t n) ω)
  let laws : (I : Finset ℕ) → Measure (I → ℝ) := fun I ↦ μ.map I.restrict
  have : ∀ I, IsFiniteMeasure (laws I) := fun I ↦ inferInstance
  have mb : AEMeasurable (fun ω n ↦ B (t n) ω) P := .of_eval (fun _ ↦ hB.aemeasurable _)
  have mc : AEMeasurable (fun ω n ↦ C (t n) ω) Q := .of_eval (fun _ ↦ hC.aemeasurable _)
  apply IsProjectiveLimit.unique (P := laws)
  · intro I
    rfl
  · intro I
    have mr : Measurable (I.restrict : (ℕ → ℝ) → (I → ℝ)) :=
      .of_eval (fun i ↦ measurable_pi_apply i.1)
    dsimp [laws, μ, ν]
    rw [AEMeasurable.map_map_of_aemeasurable mr.aemeasurable mc,
      AEMeasurable.map_map_of_aemeasurable mr.aemeasurable mb]
    change Q.map (fun ω (i : I) ↦ C (t i) ω) = P.map (fun ω (i : I) ↦ B (t i) ω)
    rw [textbookWienerSamples_finiteLaw C Q hC t I, textbookWienerSamples_finiteLaw B P hB t I]

/-- Genuine continuous paths make the entire linear tube AE equal to its countably sampled event. -/
theorem textbookWienerLinearTube_ae_samples {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (T : ℝ≥0) (hT : 0 < T) (u : ℕ → Icc (0 : ℝ≥0) 1) (hu : DenseRange u) (a ε : ℝ) :
    {ω | ∀ k, |B (T * u k) ω - ((T * u k : ℝ≥0) : ℝ) / T * a| ≤ ε} =ᵐ[P]
      textbookWienerLinearTube B T a ε := by
  filter_upwards [hB.cont] with ω hc
  apply propext
  constructor
  · intro h s hs
    let v : Icc (0 : ℝ≥0) 1 := ⟨s / T, by positivity, (div_le_one hT).mpr hs.2⟩
    have hh : Continuous (fun v : Icc (0 : ℝ≥0) 1 ↦
        |B (T * v) ω - ((T * v : ℝ≥0) : ℝ) / T * a|) := by fun_prop
    have hb : |B (T * (v : ℝ≥0)) ω - ((T * v : ℝ≥0) : ℝ) / T * a| ≤ ε :=
      hu.induction_on v (isClosed_le hh continuous_const) h
    have he : T * (v : ℝ≥0) = s := by dsimp [v]; field_simp
    simpa only [he] using hb
  · intro h k
    apply h
    refine ⟨by positivity, ?_⟩
    simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ T)

/-- Actual Brownian laws and continuity imply equal entire linear-tube probabilities, across probability spaces. -/
theorem textbookWienerLinearTube_measure_eq {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (C : ℝ≥0 → Ω' → ℝ) (Q : Measure Ω') (hC : IsBrownianReal C Q)
    (T : ℝ≥0) (hT : 0 < T) (a ε : ℝ) :
    P (textbookWienerLinearTube B T a ε) = Q (textbookWienerLinearTube C T a ε) := by
  let : Nonempty (Icc (0 : ℝ≥0) 1) := ⟨⟨0, by simp⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ≥0) 1)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  let t : ℕ → ℝ≥0 := fun k ↦ T * u k
  let E : Set (ℕ → ℝ) := {z | ∀ k, |z k - (t k : ℝ) / T * a| ≤ ε}
  have hE : MeasurableSet E := by
    unfold E
    simp only [ofPred_forall]
    apply MeasurableSet.iInter
    intro k
    exact measurableSet_le ((measurable_pi_apply k).sub_const _).norm measurable_const
  have mb : AEMeasurable (fun ω k ↦ B (t k) ω) P := .of_eval (fun _ ↦ hB.aemeasurable _)
  have mc : AEMeasurable (fun ω k ↦ C (t k) ω) Q := .of_eval (fun _ ↦ hC.aemeasurable _)
  have hb := textbookWienerLinearTube_ae_samples B P hB T hT u hu a ε
  have hc := textbookWienerLinearTube_ae_samples C Q hC T hT u hu a ε
  calc
    _ = P ((fun ω k ↦ B (t k) ω) ⁻¹' E) := (measure_congr hb).symm
    _ = (P.map (fun ω k ↦ B (t k) ω)) E := (Measure.map_apply_of_aemeasurable mb hE).symm
    _ = (Q.map (fun ω k ↦ C (t k) ω)) E := by
      rw [textbookWienerSamples_law_eq B P hB.toIsPreBrownianReal C Q hC.toIsPreBrownianReal t]
    _ = Q ((fun ω k ↦ C (t k) ω) ⁻¹' E) := Measure.map_apply_of_aemeasurable mc hE
    _ = Q (textbookWienerLinearTube C T a ε) := measure_congr hc

/-- The genuine short-time support radius applies uniformly to every shifted Brownian segment. -/
theorem textbookWienerLinearTube_shift_short_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P) (ε : ℝ) (hε : 0 < ε) :
    ∃ η : ℝ≥0, 0 < η ∧ ∀ s : ℝ≥0, ∀ T ∈ Ioc 0 η, ∀ a : ℝ,
      0 < P (textbookWienerLinearTube (fun t ω ↦ B (s + t) ω - B s ω) T a ε) := by
  obtain ⟨η, hη, hp⟩ := textbookWienerLinearTube_short_pos B P hB ε hε
  refine ⟨η, hη, ?_⟩
  intro s T hT a
  rw [← textbookWienerLinearTube_measure_eq B P hB _ P (hB.shift s) T hT.1 a ε]
  exact hp T hT a

/-- The actual Brownian increment process on the i-th interval of length h. -/
noncomputable def textbookWienerSegment {Ω : Type*} (B : ℝ≥0 → Ω → ℝ)
    (h : ℝ≥0) (i : ℕ) (s : ℝ≥0) (ω : Ω) : ℝ := B (h * i + s) ω - B (h * i) ω

/-- Real finite linear combinations prove joint Gaussianity of all the original segment paths. -/
theorem textbookWienerSegments_jointGaussian {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P) (h : ℝ≥0) (K : ℕ) :
    IsGaussianProcess (fun z : (_ : Fin K) × Icc (0 : ℝ≥0) h ↦
      textbookWienerSegment B h z.1 z.2) P := by
  classical
  apply hB.isGaussianProcess.of_isGaussianProcess
  intro z
  refine ⟨{h * (z.1 : ℕ) + z.2, h * (z.1 : ℕ)},
    { toFun := fun v ↦ v ⟨h * (z.1 : ℕ) + z.2, by simp⟩ - v ⟨h * (z.1 : ℕ), by simp⟩
      map_add' := ?_
      map_smul' := ?_ }, ?_⟩
  · intro v w
    simp only [Pi.add_apply]
    ring
  · intro c v
    simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring
  · intro ω
    rfl

/-- The true entire increment paths on distinct nonoverlapping intervals are independent. -/
theorem textbookWienerSegments_independent {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P) (h : ℝ≥0) (K : ℕ) :
    iIndepFun (fun (i : Fin K) ω (s : Icc (0 : ℝ≥0) h) ↦ textbookWienerSegment B h i s ω) P := by
  have : IsProbabilityMeasure P := hB.isGaussianProcess.isProbabilityMeasure
  have hcov (i j : Fin K) (hij : i < j) (s t : Icc (0 : ℝ≥0) h) :
      cov[textbookWienerSegment B h i s, textbookWienerSegment B h j t; P] = 0 := by
    have hij1 : ((i : ℕ) + 1 : ℝ≥0) ≤ (j : ℕ) := by
      exact_mod_cast (Nat.succ_le_of_lt (Fin.lt_def.mp hij))
    have ha : h * (i : ℕ) + s ≤ h * (j : ℕ) := by
      calc
        _ ≤ h * (i : ℕ) + h := add_le_add (le_refl _) s.2.2
        _ = h * ((i : ℕ) + 1 : ℝ≥0) := by ring
        _ ≤ h * (j : ℕ) := mul_le_mul_of_nonneg_left hij1 (by positivity)
    have hb : h * (i : ℕ) ≤ h * (j : ℕ) := by
      exact le_trans (le_add_of_nonneg_right s.2.1) ha
    have hjt : h * (j : ℕ) ≤ h * (j : ℕ) + t := le_add_of_nonneg_right t.2.1
    unfold textbookWienerSegment
    rw [covariance_fun_sub_fun_sub, hB.covariance_eval, hB.covariance_eval,
      hB.covariance_eval, hB.covariance_eval, min_eq_left (ha.trans hjt), min_eq_left ha,
      min_eq_left (hb.trans hjt), min_eq_left hb]
    · ring
    all_goals exact (hB.isGaussianProcess.hasGaussianLaw_eval _).memLp_two
  apply (textbookWienerSegments_jointGaussian B P hB h K).iIndepFun_of_covariance_eq_zero
  · intro i s
    exact (hB.aemeasurable _).sub (hB.aemeasurable _)
  · intro i j hij s t
    rcases lt_or_gt_of_ne hij with hlt | hgt
    · exact hcov i j hlt s t
    · rw [covariance_comm]
      exact hcov j i hgt t s

/-- Genuine countable Brownian laws identify the bridge/endpoint joint-tube probability across spaces. -/
theorem textbookBrownianBridgeJointTube_measure_eq {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (C : ℝ≥0 → Ω' → ℝ) (Q : Measure Ω') (hC : IsPreBrownianReal C Q)
    (T : ℝ≥0) (u : ℕ → Icc (0 : ℝ≥0) 1) (ε a δ : ℝ) :
    P (textbookBrownianBridgeSampleTube B T u ε ∩ {ω | B T ω ∈ Metric.ball a δ}) =
      Q (textbookBrownianBridgeSampleTube C T u ε ∩ {ω | C T ω ∈ Metric.ball a δ}) := by
  let t : ℕ → ℝ≥0 := fun n ↦ if n = 0 then T else T * u (n - 1)
  let E : Set (ℕ → ℝ) := {z | (∀ k, |z (k + 1) - ((T * u k : ℝ≥0) : ℝ) / T * z 0| ≤ ε) ∧
    z 0 ∈ Metric.ball a δ}
  have hE : MeasurableSet E := by
    unfold E
    simp only [ofPred_and, ofPred_forall]
    apply MeasurableSet.inter
    · apply MeasurableSet.iInter
      intro k
      exact measurableSet_le
        ((measurable_pi_apply (k + 1)).sub ((measurable_pi_apply 0).const_mul _)).norm measurable_const
    · exact measurableSet_ball.preimage (measurable_pi_apply 0)
  have mb : AEMeasurable (fun ω k ↦ B (t k) ω) P := .of_eval (fun _ ↦ hB.aemeasurable _)
  have mc : AEMeasurable (fun ω k ↦ C (t k) ω) Q := .of_eval (fun _ ↦ hC.aemeasurable _)
  have heB : (fun ω k ↦ B (t k) ω) ⁻¹' E =
      textbookBrownianBridgeSampleTube B T u ε ∩ {ω | B T ω ∈ Metric.ball a δ} := by
    ext ω
    simp [E, t, textbookBrownianBridgeSampleTube, textbookBrownianBridge]
  have heC : (fun ω k ↦ C (t k) ω) ⁻¹' E =
      textbookBrownianBridgeSampleTube C T u ε ∩ {ω | C T ω ∈ Metric.ball a δ} := by
    ext ω
    simp [E, t, textbookBrownianBridgeSampleTube, textbookBrownianBridge]
  calc
    _ = P ((fun ω k ↦ B (t k) ω) ⁻¹' E) := by rw [heB]
    _ = (P.map (fun ω k ↦ B (t k) ω)) E := (Measure.map_apply_of_aemeasurable mb hE).symm
    _ = (Q.map (fun ω k ↦ C (t k) ω)) E := by rw [textbookWienerSamples_law_eq B P hB C Q hC t]
    _ = Q ((fun ω k ↦ C (t k) ω) ⁻¹' E) := Measure.map_apply_of_aemeasurable mc hE
    _ = Q (textbookBrownianBridgeSampleTube C T u ε ∩ {ω | C T ω ∈ Metric.ball a δ}) := by rw [heC]

/-- A single true short-time radius works on all shifts, independent of the required endpoint-ball width. -/
theorem textbookBrownianBridgeJointTube_shift_short_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (hε : 0 < ε) :
    ∃ η : ℝ≥0, 0 < η ∧ ∀ s : ℝ≥0, ∀ T ∈ Ioc 0 η, ∀ a δ : ℝ, 0 < δ →
      0 < P (textbookBrownianBridgeSampleTube (fun t ω ↦ B (s + t) ω - B s ω) T u ε ∩
        {ω | B (s + T) ω - B s ω ∈ Metric.ball a δ}) := by
  obtain ⟨η, hη, hp⟩ := textbookBrownianBridgeSampleTube_short_joint_pos B P hB u ε hε
  refine ⟨η, hη, ?_⟩
  intro s T hT a δ hδ
  rw [← textbookBrownianBridgeJointTube_measure_eq B P hB.toIsPreBrownianReal _ P
    (hB.shift s).toIsPreBrownianReal T u ε a δ]
  exact hp T hT a δ hδ

/-- The actual finite joint bridge/endpoint event on the original Brownian segments. -/
def textbookWienerSegmentJointEvent {Ω : Type*} (B : ℝ≥0 → Ω → ℝ) (h : ℝ≥0) (K : ℕ)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (a δ : Fin K → ℝ) : Set Ω :=
  {ω | ∀ i : Fin K, ω ∈ textbookBrownianBridgeSampleTube (textbookWienerSegment B h i) h u ε ∧
    textbookWienerSegment B h i h ω ∈ Metric.ball (a i) (δ i)}

/-- The finite segment joint event is truly null-measurable for the original process. -/
theorem textbookWienerSegmentJointEvent_nullMeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (h : ℝ≥0) (K : ℕ) (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (a δ : Fin K → ℝ) :
    NullMeasurableSet (textbookWienerSegmentJointEvent B h K u ε a δ) P := by
  unfold textbookWienerSegmentJointEvent
  simp only [ofPred_forall, ofPred_and]
  apply NullMeasurableSet.iInter
  intro i
  apply NullMeasurableSet.inter
  · exact textbookBrownianBridgeSampleTube_nullMeasurable _ P (hB.shift (h * (i : ℕ))) h u ε
  · exact ((hB.aemeasurable _).sub (hB.aemeasurable _)).nullMeasurableSet_preimage measurableSet_ball

/-- True whole-segment independence yields the actual finite product probability, rather than a positivity premise. -/
theorem textbookWienerSegmentJointEvent_measure_prod {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (h : ℝ≥0) (K : ℕ) (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (a δ : Fin K → ℝ) :
    P (textbookWienerSegmentJointEvent B h K u ε a δ) =
      ∏ i : Fin K, P (textbookBrownianBridgeSampleTube (textbookWienerSegment B h i) h u ε ∩
        {ω | textbookWienerSegment B h i h ω ∈ Metric.ball (a i) (δ i)}) := by
  let j : ℕ → Icc (0 : ℝ≥0) h := fun k ↦ ⟨h * u k, by positivity,
    by simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ h)⟩
  let v : Icc (0 : ℝ≥0) h := ⟨h, by positivity, le_rfl⟩
  let E : Fin K → Set (Icc (0 : ℝ≥0) h → ℝ) := fun i ↦
    {z | (∀ k, |z (j k) - ((h * u k : ℝ≥0) : ℝ) / h * z v| ≤ ε) ∧
      z v ∈ Metric.ball (a i) (δ i)}
  have hE (i : Fin K) : MeasurableSet (E i) := by
    unfold E
    simp only [ofPred_and, ofPred_forall]
    apply MeasurableSet.inter
    · apply MeasurableSet.iInter
      intro k
      exact measurableSet_le
        ((measurable_pi_apply (j k)).sub ((measurable_pi_apply v).const_mul _)).norm measurable_const
    · exact measurableSet_ball.preimage (measurable_pi_apply v)
  let A : Fin K → Set Ω := fun i ↦
    (fun ω (s : Icc (0 : ℝ≥0) h) ↦ textbookWienerSegment B h i s ω) ⁻¹' E i
  have he := (textbookWienerSegments_independent B P hB h K).meas_iInter
    (s := A) (fun i ↦ ⟨E i, hE i, rfl⟩)
  have heA (i : Fin K) : A i =
      textbookBrownianBridgeSampleTube (textbookWienerSegment B h i) h u ε ∩
        {ω | textbookWienerSegment B h i h ω ∈ Metric.ball (a i) (δ i)} := by
    rfl
  have heAll : (⋂ i, A i) = textbookWienerSegmentJointEvent B h K u ε a δ := by
    ext ω
    simp only [mem_iInter, heA, mem_inter_iff, textbookWienerSegmentJointEvent, mem_ofPred_eq]
  rw [heAll] at he
  simpa only [heA] using he

/-- Every finite family of actual short Brownian bridge/endpoint requirements has positive joint probability. -/
theorem textbookWienerSegmentJointEvent_short_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (hε : 0 < ε) :
    ∃ η : ℝ≥0, 0 < η ∧ ∀ h ∈ Ioc 0 η, ∀ K : ℕ, ∀ a δ : Fin K → ℝ,
      (∀ i, 0 < δ i) → 0 < P (textbookWienerSegmentJointEvent B h K u ε a δ) := by
  obtain ⟨η, hη, hp⟩ := textbookBrownianBridgeJointTube_shift_short_pos B P hB u ε hε
  refine ⟨η, hη, ?_⟩
  intro h hh K a δ hδ
  rw [textbookWienerSegmentJointEvent_measure_prod B P hB.toIsPreBrownianReal h K u ε a δ]
  apply pos_iff_ne_zero.mpr
  apply Finset.prod_ne_zero_iff.mpr
  intro i _
  exact (hp (h * (i : ℕ)) h hh (a i) (δ i) (hδ i)).ne'

end MolecularDynamics
