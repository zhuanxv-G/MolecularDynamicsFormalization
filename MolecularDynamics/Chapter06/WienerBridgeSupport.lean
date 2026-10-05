import MolecularDynamics.Chapter06.WienerDeterministicLaw
import Mathlib.Probability.BrownianMotion.Basic

/-! Actual Brownian bridge and independent endpoint, necessary for the tube support in Lemma6.1. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology NNReal ENNReal

namespace MolecularDynamics

/-- The genuine real Brownian bridge, defined from the original process. -/
noncomputable def textbookBrownianBridge {Ω : Type*} (B : ℝ≥0 → Ω → ℝ) (T s : ℝ≥0) (ω : Ω) : ℝ :=
  B s ω - (s : ℝ) / T * B T ω

/-- The actual bridge vanishes at its terminal time. -/
theorem textbookBrownianBridge_terminal {Ω : Type*} (B : ℝ≥0 → Ω → ℝ)
    (T : ℝ≥0) (hT : T ≠ 0) (ω : Ω) : textbookBrownianBridge B T T ω = 0 := by
  simp [textbookBrownianBridge, hT]

/-- The actual bridge and endpoint are jointly Gaussian, from true finite linear combinations. -/
theorem textbookBrownianBridge_jointGaussian {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P) (T : ℝ≥0) :
    IsGaussianProcess (Sum.elim
      (fun (s : Iic T) ω ↦ textbookBrownianBridge B T s ω)
      (fun (_ : Unit) ω ↦ B T ω)) P := by
  classical
  apply hB.isGaussianProcess.of_isGaussianProcess
  rintro (s | u)
  · refine ⟨{s.1, T},
      { toFun := fun z ↦ z ⟨s.1, by simp⟩ - (s.1 : ℝ) / T * z ⟨T, by simp⟩
        map_add' := ?_
        map_smul' := ?_ }, ?_⟩
    · intro z w
      simp only [Pi.add_apply]
      ring
    · intro c z
      simp only [Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
      ring
    · intro ω
      rfl
  · exact ⟨{T},
      { toFun := fun z ↦ z ⟨T, by simp⟩
        map_add' := by intros; simp
        map_smul' := by intros; simp }, by intros; rfl⟩

/-- Actual covariance cancellation makes each bridge value uncorrelated with the endpoint. -/
theorem textbookBrownianBridge_covariance_terminal {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (T : ℝ≥0) (hT : T ≠ 0) (s : Iic T) :
    cov[textbookBrownianBridge B T s, B T; P] = 0 := by
  have : IsProbabilityMeasure P := hB.isGaussianProcess.isProbabilityMeasure
  unfold textbookBrownianBridge
  rw [covariance_fun_sub_left, covariance_const_mul_left, hB.covariance_eval,
    hB.covariance_eval, min_eq_left s.2, min_self]
  · field_simp
    ring
  · exact (hB.isGaussianProcess.hasGaussianLaw_eval s).memLp_two
  · exact ((hB.isGaussianProcess.hasGaussianLaw_eval T).memLp_two).const_mul _
  · exact (hB.isGaussianProcess.hasGaussianLaw_eval T).memLp_two

/-- The true entire bridge process is independent of its real endpoint. -/
theorem textbookBrownianBridge_indep_terminal {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (T : ℝ≥0) (hT : T ≠ 0) :
    IndepFun (fun ω (s : Iic T) ↦ textbookBrownianBridge B T s ω) (B T) P := by
  have hg := textbookBrownianBridge_jointGaussian B P hB T
  have hi := hg.indepFun_of_covariance_eq_zero
    (fun s ↦ (hB.aemeasurable s).sub ((hB.aemeasurable T).const_mul _))
    (fun _ ↦ hB.aemeasurable T)
    (fun s _ ↦ textbookBrownianBridge_covariance_terminal B P hB T hT s)
  exact hi.comp measurable_id (measurable_pi_apply ())

/-- Genuine Brownian paths give genuine continuous bridges. -/
theorem textbookBrownianBridge_continuous {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P) (T : ℝ≥0) :
    ∀ᵐ ω ∂P, Continuous (fun s ↦ textbookBrownianBridge B T s ω) := by
  filter_upwards [hB.cont] with ω hω
  unfold textbookBrownianBridge
  fun_prop

/-- Every positive-width real endpoint interval has actual positive probability. -/
theorem textbookBrownian_endpoint_ball_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (T : ℝ≥0) (hT : T ≠ 0) (a ε : ℝ) (hε : 0 < ε) :
    0 < P {ω | B T ω ∈ Metric.ball a ε} := by
  have he := (hB.hasLaw_eval T).measure_eq
    (p := fun z ↦ z ∈ Metric.ball a ε) measurableSet_ball
  rw [he]
  apply pos_iff_ne_zero.mpr
  intro hz
  have hv := gaussianReal_absolutelyContinuous' 0 hT hz
  have hpos : 0 < (volume : Measure ℝ) (Metric.ball a ε) := by
    rw [Real.ball_eq_Ioo, Real.volume_Ioo, ENNReal.ofReal_pos]
    linarith
  exact hpos.ne' hv

/-- A countable sample tube is an actual event, to be upgraded by path continuity and dense samples. -/
def textbookBrownianBridgeSampleTube {Ω : Type*} (B : ℝ≥0 → Ω → ℝ) (T : ℝ≥0)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) : Set Ω :=
  {ω | ∀ k, |textbookBrownianBridge B T (T * u k) ω| ≤ ε}

/-- The countable tube is truly null-measurable, even for the original AE-measurable process. -/
theorem textbookBrownianBridgeSampleTube_nullMeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (T : ℝ≥0) (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) :
    NullMeasurableSet (textbookBrownianBridgeSampleTube B T u ε) P := by
  unfold textbookBrownianBridgeSampleTube
  simp only [ofPred_forall]
  apply NullMeasurableSet.iInter
  intro k
  exact nullMeasurableSet_le
    (((hB.aemeasurable (T * u k)).sub ((hB.aemeasurable T).const_mul _)).norm) aemeasurable_const

/-- Actual continuity gives a positive-probability bridge tube at every sufficiently short positive time. -/
theorem textbookBrownianBridgeSampleTube_short_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (hε : 0 < ε) :
    ∃ η : ℝ≥0, 0 < η ∧ ∀ T ∈ Ioc 0 η,
      0 < P (textbookBrownianBridgeSampleTube B T u ε) := by
  have : IsProbabilityMeasure P := hB.isGaussianProcess.isProbabilityMeasure
  let S : ℝ≥0 → Set Ω := fun η ↦ {ω | ∀ t ≤ η, |B t ω| ≤ ε / 3}
  have hcover : ∀ᵐ ω ∂P, ω ∈ ⋃ n : ℕ, S ((n + 1 : ℝ≥0)⁻¹) := by
    filter_upwards [hB.cont, hB.eval_zero_ae_eq_zero] with ω hc hz
    obtain ⟨δ, hδ, hδB⟩ := Metric.continuousAt_iff.mp (hc.continuousAt (x := 0))
      (ε / 3) (by positivity)
    obtain ⟨n, hn⟩ := exists_nat_one_div_lt hδ
    let η : ℝ≥0 := (n + 1 : ℝ≥0)⁻¹
    have hηδ : (η : ℝ) < δ := by simpa [η, one_div] using hn
    apply mem_iUnion.mpr
    refine ⟨n, ?_⟩
    intro t ht
    have hdist : dist t 0 < δ := by
      change |(t : ℝ) - 0| < δ
      rw [sub_zero]
      apply abs_lt.mpr
      have hle := NNReal.coe_le_coe.mpr ht
      exact ⟨(neg_lt_zero.mpr hδ).trans_le (NNReal.coe_nonneg t), hle.trans_lt hηδ⟩
    have hb := hδB hdist
    exact (by simpa [Real.dist_eq, hz] using hb : |B t ω| < ε / 3).le
  have hnonzero : P (⋃ n : ℕ, S ((n + 1 : ℝ≥0)⁻¹)) ≠ 0 :=
    frequently_ae_iff.mp hcover.frequently
  obtain ⟨n, hn⟩ := exists_measure_pos_of_not_measure_iUnion_null hnonzero
  let η : ℝ≥0 := (n + 1 : ℝ≥0)⁻¹
  have hη : 0 < η := by dsimp [η]; positivity
  refine ⟨η, hη, ?_⟩
  intro T hT
  apply lt_of_lt_of_le hn
  apply measure_mono
  intro ω hω k
  have hu : (u k : ℝ) ≤ 1 := by exact_mod_cast (u k).2.2
  have hu0 : 0 ≤ (u k : ℝ) := (u k).1.property
  have htime : T * (u k : ℝ≥0) ≤ T := by
    simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ T)
  have he : ((T * (u k : ℝ≥0) : ℝ≥0) : ℝ) / T = (u k : ℝ) := by
    have ht : (T : ℝ) ≠ 0 := by exact_mod_cast hT.1.ne'
    simp only [NNReal.coe_mul]
    field_simp
  change |B (T * (u k : ℝ≥0)) ω - _ * B T ω| ≤ ε
  rw [he]
  have hBs := hω _ (htime.trans hT.2)
  have hBt := hω T hT.2
  have hmul : |(u k : ℝ) * B T ω| ≤ ε / 3 := by
    rw [abs_mul, abs_of_nonneg hu0]
    calc
      _ ≤ 1 * |B T ω| := mul_le_mul_of_nonneg_right hu (abs_nonneg _)
      _ ≤ ε / 3 := by simpa using hBt
  calc
    _ ≤ |B (T * (u k : ℝ≥0)) ω| + |(u k : ℝ) * B T ω| := abs_sub _ _
    _ ≤ ε / 3 + ε / 3 := add_le_add hBs hmul
    _ ≤ ε := by linarith

/-- In particular an actual positive bridge-tube time exists. -/
theorem textbookBrownianBridgeSampleTube_exists_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (hε : 0 < ε) :
    ∃ T : ℝ≥0, 0 < T ∧ 0 < P (textbookBrownianBridgeSampleTube B T u ε) := by
  obtain ⟨η, hη, hp⟩ := textbookBrownianBridgeSampleTube_short_pos B P hB u ε hε
  exact ⟨η, hη, hp η ⟨hη, le_rfl⟩⟩

/-- With genuinely dense samples, actual sample continuity upgrades the tube to the entire time interval. -/
theorem textbookBrownianBridgeSampleTube_ae_full {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (T : ℝ≥0) (hT : T ≠ 0) (u : ℕ → Icc (0 : ℝ≥0) 1) (hu : DenseRange u) (ε : ℝ) :
    ∀ᵐ ω ∂P, ω ∈ textbookBrownianBridgeSampleTube B T u ε ↔
      ∀ s ∈ Icc 0 T, |textbookBrownianBridge B T s ω| ≤ ε := by
  filter_upwards [textbookBrownianBridge_continuous B P hB T] with ω hc
  constructor
  · intro hω s hs
    have hTpos : 0 < T := pos_of_ne_zero hT
    let v : Icc (0 : ℝ≥0) 1 := ⟨s / T, by positivity, (div_le_one hTpos).mpr hs.2⟩
    have hh : Continuous (fun v : Icc (0 : ℝ≥0) 1 ↦ |textbookBrownianBridge B T (T * v) ω|) := by
      exact (hc.comp (continuous_const.mul continuous_subtype_val)).abs
    have hb : |textbookBrownianBridge B T (T * (v : ℝ≥0)) ω| ≤ ε :=
      hu.induction_on v (isClosed_le hh continuous_const) hω
    have he : T * (v : ℝ≥0) = s := by dsimp [v]; field_simp
    simpa only [he] using hb
  · intro hω k
    apply hω
    refine ⟨by positivity, ?_⟩
    simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ T)

/-- Actual endpoint/bridge independence gives the literal product probability for their two tube events. -/
theorem textbookBrownianBridgeSampleTube_inter_ball {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsPreBrownianReal B P)
    (T : ℝ≥0) (hT : T ≠ 0) (u : ℕ → Icc (0 : ℝ≥0) 1) (ε a δ : ℝ) :
    P (textbookBrownianBridgeSampleTube B T u ε ∩ {ω | B T ω ∈ Metric.ball a δ}) =
      P (textbookBrownianBridgeSampleTube B T u ε) * P {ω | B T ω ∈ Metric.ball a δ} := by
  let j : ℕ → Iic T := fun k ↦ ⟨T * u k, by
    simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ T)⟩
  let E : Set (Iic T → ℝ) := {z | ∀ k, |z (j k)| ≤ ε}
  have hE : MeasurableSet E := by
    unfold E
    simp only [ofPred_forall]
    apply MeasurableSet.iInter
    intro k
    exact measurableSet_le (measurable_pi_apply (j k)).norm measurable_const
  have hi := (textbookBrownianBridge_indep_terminal B P hB T hT).measure_inter_preimage_eq_mul
    E (Metric.ball a δ) hE measurableSet_ball
  exact hi

/-- At all sufficiently short positive times, the actual bridge tube and every endpoint ball jointly have positive probability. -/
theorem textbookBrownianBridgeSampleTube_short_joint_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (u : ℕ → Icc (0 : ℝ≥0) 1) (ε : ℝ) (hε : 0 < ε) :
    ∃ η : ℝ≥0, 0 < η ∧ ∀ T ∈ Ioc 0 η, ∀ a δ : ℝ, 0 < δ →
      0 < P (textbookBrownianBridgeSampleTube B T u ε ∩ {ω | B T ω ∈ Metric.ball a δ}) := by
  obtain ⟨η, hη, hp⟩ := textbookBrownianBridgeSampleTube_short_pos B P hB u ε hε
  refine ⟨η, hη, ?_⟩
  intro T hT a δ hδ
  rw [textbookBrownianBridgeSampleTube_inter_ball B P hB.toIsPreBrownianReal T hT.1.ne' u ε a δ]
  exact pos_iff_ne_zero.mpr (mul_ne_zero (hp T hT).ne'
    (textbookBrownian_endpoint_ball_pos B P hB.toIsPreBrownianReal T hT.1.ne' a δ hδ).ne')

private theorem continuous_sampled_interval_iff (f : ℝ≥0 → ℝ) (hf : Continuous f)
    (T : ℝ≥0) (hT : 0 < T) (u : ℕ → Icc (0 : ℝ≥0) 1) (hu : DenseRange u) (ε : ℝ) :
    (∀ k, |f (T * u k)| ≤ ε) ↔ ∀ s ∈ Icc 0 T, |f s| ≤ ε := by
  constructor
  · intro h s hs
    let v : Icc (0 : ℝ≥0) 1 := ⟨s / T, by positivity, (div_le_one hT).mpr hs.2⟩
    have hc : Continuous (fun v : Icc (0 : ℝ≥0) 1 ↦ |f (T * v)|) :=
      (hf.comp (continuous_const.mul continuous_subtype_val)).abs
    have hb : |f (T * (v : ℝ≥0))| ≤ ε := hu.induction_on v (isClosed_le hc continuous_const) h
    have he : T * (v : ℝ≥0) = s := by dsimp [v]; field_simp
    simpa only [he] using hb
  · intro h k
    apply h
    refine ⟨by positivity, ?_⟩
    simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ T)

/-- The genuine entire-path tube around a prescribed line from zero to a. -/
def textbookWienerLinearTube {Ω : Type*} (B : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (a ε : ℝ) : Set Ω :=
  {ω | ∀ s ∈ Icc 0 T, |B s ω - (s : ℝ) / T * a| ≤ ε}

/-- Actual path continuity and dense samples prove null-measurability of the entire linear tube. -/
theorem textbookWienerLinearTube_nullMeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (T : ℝ≥0) (hT : 0 < T) (a ε : ℝ) :
    NullMeasurableSet (textbookWienerLinearTube B T a ε) P := by
  let : Nonempty (Icc (0 : ℝ≥0) 1) := ⟨⟨0, by simp⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ≥0) 1)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  let E : Set Ω := {ω | ∀ k, |B (T * u k) ω - ((T * u k : ℝ≥0) : ℝ) / T * a| ≤ ε}
  have hE : NullMeasurableSet E P := by
    unfold E
    simp only [ofPred_forall]
    apply NullMeasurableSet.iInter
    intro k
    exact nullMeasurableSet_le ((hB.aemeasurable (T * u k)).sub_const _).norm aemeasurable_const
  apply hE.congr
  filter_upwards [hB.cont] with ω hc
  apply propext
  have hh : Continuous (fun s : ℝ≥0 ↦ B s ω - (s : ℝ) / T * a) := by fun_prop
  exact continuous_sampled_interval_iff _ hh T hT u hu ε

/-- Actual short-time entire-path support around every prescribed line follows from bridge independence. -/
theorem textbookWienerLinearTube_short_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ η : ℝ≥0, 0 < η ∧ ∀ T ∈ Ioc 0 η, ∀ a : ℝ,
      0 < P (textbookWienerLinearTube B T a ε) := by
  let : Nonempty (Icc (0 : ℝ≥0) 1) := ⟨⟨0, by simp⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ≥0) 1)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  obtain ⟨η, hη, hj⟩ := textbookBrownianBridgeSampleTube_short_joint_pos B P hB u (ε / 2) (by positivity)
  refine ⟨η, hη, ?_⟩
  intro T hT a
  have hp := hj T hT a (ε / 2) (by positivity)
  apply lt_of_lt_of_le hp
  apply measure_mono_ae
  filter_upwards [textbookBrownianBridgeSampleTube_ae_full B P hB T hT.1.ne' u hu (ε / 2)] with ω hfull
  intro hω s hs
  have hb := hfull.mp hω.1 s hs
  have ha := hω.2
  change |B T ω - a| < ε / 2 at ha
  have hTs : (s : ℝ) ≤ T := by exact_mod_cast hs.2
  have hTr : 0 < (T : ℝ) := by exact_mod_cast hT.1
  have hc0 : 0 ≤ (s : ℝ) / T := div_nonneg s.property hTr.le
  have hc1 : (s : ℝ) / T ≤ 1 := (div_le_one hTr).mpr hTs
  have he : B s ω - (s : ℝ) / T * a =
      textbookBrownianBridge B T s ω + (s : ℝ) / T * (B T ω - a) := by
    unfold textbookBrownianBridge
    ring
  rw [he]
  calc
    _ ≤ |textbookBrownianBridge B T s ω| + |(s : ℝ) / T * (B T ω - a)| := by
      simpa only [Real.norm_eq_abs] using
        norm_add_le (textbookBrownianBridge B T s ω) ((s : ℝ) / T * (B T ω - a))
    _ ≤ ε / 2 + ε / 2 := by
      apply add_le_add hb
      rw [abs_mul, abs_of_nonneg hc0]
      calc
        _ ≤ 1 * |B T ω - a| := mul_le_mul_of_nonneg_right hc1 (abs_nonneg _)
        _ ≤ ε / 2 := by simpa using ha.le
    _ = ε := by ring

end MolecularDynamics
