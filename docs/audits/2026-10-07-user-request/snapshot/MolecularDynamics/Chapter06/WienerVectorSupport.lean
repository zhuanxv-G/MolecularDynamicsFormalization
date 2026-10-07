import MolecularDynamics.Chapter06.WienerPathSupport
import Mathlib.Analysis.Normed.Group.Constructions

/-! The actual standard vector Wiener law and its necessary continuous-control support. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology NNReal ENNReal

namespace MolecularDynamics

/-- Standard finite-dimensional Wiener law: centered joint Gaussian, isotropic covariance,
and almost surely continuous paths. Coordinate independence is proved from these fields. -/
structure textbookIsWienerVector {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) : Prop where
  gaussian : IsGaussianProcess (fun z : (_ : Fin Nc) × ℝ≥0 ↦ fun ω ↦ B z.2 ω z.1) P
  mean : ∀ i t, P[fun ω ↦ B t ω i] = 0
  covariance : ∀ i j s t, cov[fun ω ↦ B s ω i, fun ω ↦ B t ω j; P] =
    if i = j then ((min s t : ℝ≥0) : ℝ) else 0
  cont : ∀ᵐ ω ∂P, Continuous (fun t ↦ B t ω)

/-- Each actual coordinate has the genuine scalar Brownian law and continuous paths. -/
theorem textbookWienerVector_coordinate {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (i : Fin Nc) : IsBrownianReal (fun t ω ↦ B t ω i) P where
  toIsPreBrownianReal :=
    (hB.gaussian.comp_right (fun t ↦ ⟨i, t⟩)).isPreBrownianReal_of_covariance
      (hB.mean i) (by
        intro s t hst
        simpa [Function.comp_def, min_eq_left hst] using hB.covariance i i s t)
  cont := by
    filter_upwards [hB.cont] with ω hc
    exact (continuous_apply i).comp hc

/-- Actual whole coordinate paths are independent, by joint Gaussianity and actual zero cross covariance. -/
theorem textbookWienerVector_coordinates_independent {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    iIndepFun (fun (i : Fin Nc) ω t ↦ B t ω i) P := by
  apply hB.gaussian.iIndepFun_of_covariance_eq_zero
  · intro i t
    exact hB.gaussian.aemeasurable ⟨i, t⟩
  · intro i j hij s t
    simpa [hij] using hB.covariance i j s t

/-- The actual vector Wiener process starts at zero almost surely. -/
theorem textbookWienerVector_zero_ae {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    ∀ᵐ ω ∂P, B 0 ω = 0 := by
  have hz : ∀ᵐ ω ∂P, ∀ i : Fin Nc, B 0 ω i = 0 :=
    ae_all_iff.mpr (fun i ↦ (textbookWienerVector_coordinate B P hB i).eval_zero_ae_eq_zero)
  filter_upwards [hz] with ω hω
  exact funext hω

/-- The actual whole vector path tube uses the norm of the finite-coordinate phase model. -/
def textbookWienerVectorControlTube {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ≥0) (R : ℝ≥0 → (Fin Nc → ℝ)) (ε : ℝ) : Set Ω :=
  {ω | ∀ t ∈ Icc 0 T, ‖B t ω - R t‖ ≤ ε}

/-- The literal finite-coordinate norm tube equals the intersection of its real coordinate tubes. -/
theorem textbookWienerVectorControlTube_eq_iInter {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ≥0) (R : ℝ≥0 → (Fin Nc → ℝ))
    (ε : ℝ) (hε : 0 ≤ ε) :
    textbookWienerVectorControlTube B T R ε =
      ⋂ i : Fin Nc, textbookWienerControlTube (fun t ω ↦ B t ω i) T (fun t ↦ R t i) ε := by
  ext ω
  simp only [textbookWienerVectorControlTube, textbookWienerControlTube, mem_ofPred_eq, mem_iInter]
  constructor
  · intro h i t ht
    have hi := (norm_le_pi_norm (B t ω - R t) i).trans (h t ht)
    simpa only [Pi.sub_apply, Real.norm_eq_abs] using hi
  · intro h t ht
    apply (pi_norm_le_iff_of_nonneg hε).mpr
    intro i
    simpa only [Pi.sub_apply, Real.norm_eq_abs] using h i t ht

/-- Actual continuous vector controls have null-measurable entire-path tubes. -/
theorem textbookWienerVectorControlTube_nullMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (hT : 0 < T) (R : ℝ≥0 → (Fin Nc → ℝ))
    (hR : ContinuousOn R (Icc 0 T)) (ε : ℝ) (hε : 0 ≤ ε) :
    NullMeasurableSet (textbookWienerVectorControlTube B T R ε) P := by
  rw [textbookWienerVectorControlTube_eq_iInter B T R ε hε]
  apply NullMeasurableSet.iInter
  intro i
  have hr : ContinuousOn (fun t ↦ R t i) (Icc 0 T) := by
    intro t ht
    exact (continuous_apply i).continuousAt.comp_continuousWithinAt (hR t ht)
  exact textbookWienerControlTube_nullMeasurable _ P (textbookWienerVector_coordinate B P hB i) T hT _ hr ε

/-- Genuine whole-coordinate independence gives the true finite product of control-tube probabilities. -/
theorem textbookWienerVectorControlTube_measure_prod {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (hT : 0 < T) (R : ℝ≥0 → (Fin Nc → ℝ))
    (hR : ContinuousOn R (Icc 0 T)) (ε : ℝ) (hε : 0 ≤ ε) :
    P (textbookWienerVectorControlTube B T R ε) =
      ∏ i : Fin Nc, P (textbookWienerControlTube (fun t ω ↦ B t ω i) T (fun t ↦ R t i) ε) := by
  let : Nonempty (Icc (0 : ℝ≥0) 1) := ⟨⟨0, by simp⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ≥0) 1)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  let E : Fin Nc → Set (ℝ≥0 → ℝ) := fun i ↦ {z | ∀ k, |z (T * u k) - R (T * u k) i| ≤ ε}
  have hE (i : Fin Nc) : MeasurableSet (E i) := by
    unfold E
    simp only [ofPred_forall]
    apply MeasurableSet.iInter
    intro k
    exact measurableSet_le ((measurable_pi_apply (T * u k)).sub_const _).norm measurable_const
  let A : Fin Nc → Set Ω := fun i ↦ (fun ω t ↦ B t ω i) ⁻¹' E i
  have he := (textbookWienerVector_coordinates_independent B P hB).meas_iInter
    (s := A) (fun i ↦ ⟨E i, hE i, rfl⟩)
  have ha (i : Fin Nc) : A i =ᵐ[P]
      textbookWienerControlTube (fun t ω ↦ B t ω i) T (fun t ↦ R t i) ε := by
    have hr : ContinuousOn (fun t ↦ R t i) (Icc 0 T) := by
      intro t ht
      exact (continuous_apply i).continuousAt.comp_continuousWithinAt (hR t ht)
    exact textbookWienerControlTube_ae_samples _ P (textbookWienerVector_coordinate B P hB i)
      T hT _ hr u hu ε
  have hall : (⋂ i, A i) =ᵐ[P] textbookWienerVectorControlTube B T R ε := by
    rw [textbookWienerVectorControlTube_eq_iInter B T R ε hε]
    have hh : ∀ᵐ ω ∂P, ∀ i, ω ∈ A i ↔
        ω ∈ textbookWienerControlTube (fun t ω ↦ B t ω i) T (fun t ↦ R t i) ε :=
      ae_all_iff.mpr (fun i ↦ (ha i).mono (fun _ h ↦ eq_iff_iff.mp h))
    filter_upwards [hh] with ω hω
    simp only [mem_iInter]
    exact propext (forall_congr' hω)
  calc
    _ = P (⋂ i, A i) := (measure_congr hall).symm
    _ = ∏ i : Fin Nc, P (A i) := he
    _ = _ := Finset.prod_congr rfl (fun i _ ↦ measure_congr (ha i))

/-- Every continuous vector control from zero has positive entire Wiener-tube probability at every prescribed time. -/
theorem textbookWienerVectorControlTube_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ≥0) (hT : 0 < T) (R : ℝ≥0 → (Fin Nc → ℝ))
    (hR : ContinuousOn R (Icc 0 T)) (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorControlTube B T R ε) := by
  rw [textbookWienerVectorControlTube_measure_prod B P hB T hT R hR ε hε.le]
  apply pos_iff_ne_zero.mpr
  apply Finset.prod_ne_zero_iff.mpr
  intro i _
  have hr : ContinuousOn (fun t ↦ R t i) (Icc 0 T) := by
    intro t ht
    exact (continuous_apply i).continuousAt.comp_continuousWithinAt (hR t ht)
  have hz : R 0 i = 0 := by rw [hR0]; rfl
  exact (textbookWienerControlTube_pos _ P (textbookWienerVector_coordinate B P hB i)
    T hT _ hr hz ε hε).ne'


/-- The actual nonnegative real-time Wiener path tube, in the time convention of the Langevin equation. -/
def textbookWienerVectorRealControlTube {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (R : ℝ → (Fin Nc → ℝ)) (ε : ℝ) : Set Ω :=
  {ω | ∀ t ∈ Icc 0 T, ‖B t.toNNReal ω - R t‖ ≤ ε}

/-- Actual nonnegative real-time and NNReal-time tubes are literally equal. -/
theorem textbookWienerVectorRealControlTube_eq {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (hT : 0 ≤ T)
    (R : ℝ → (Fin Nc → ℝ)) (ε : ℝ) :
    textbookWienerVectorRealControlTube B T R ε =
      textbookWienerVectorControlTube B T.toNNReal (fun s ↦ R (s : ℝ)) ε := by
  ext ω
  constructor
  · intro h s hs
    have hsT : (s : ℝ) ≤ T := by
      calc
        _ ≤ (T.toNNReal : ℝ) := NNReal.coe_le_coe.mpr hs.2
        _ = T := Real.coe_toNNReal T hT
    simpa only [Real.toNNReal_coe] using h (s : ℝ) ⟨s.property, hsT⟩
  · intro h t ht
    have hn : t.toNNReal ∈ Icc 0 T.toNNReal := ⟨by positivity, Real.toNNReal_mono ht.2⟩
    simpa only [Real.coe_toNNReal t ht.1] using h t.toNNReal hn

/-- Actual real-time tubes around continuous controls are null-measurable. -/
theorem textbookWienerVectorRealControlTube_nullMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (ε : ℝ) (hε : 0 ≤ ε) : NullMeasurableSet (textbookWienerVectorRealControlTube B T R ε) P := by
  rw [textbookWienerVectorRealControlTube_eq B T hT.le R ε]
  have hr : Continuous (fun s : ℝ≥0 ↦ R (s : ℝ)) := by fun_prop
  exact textbookWienerVectorControlTube_nullMeasurable B P hB _ (Real.toNNReal_pos.mpr hT)
    _ hr.continuousOn ε hε

/-- At each prescribed positive real time, actual continuous controls from zero have positive vector Wiener-tube probability. -/
theorem textbookWienerVectorRealControlTube_pos {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε) := by
  rw [textbookWienerVectorRealControlTube_eq B T hT.le R ε]
  have hr : Continuous (fun s : ℝ≥0 ↦ R (s : ℝ)) := by fun_prop
  exact textbookWienerVectorControlTube_pos B P hB _ (Real.toNNReal_pos.mpr hT)
    _ hr.continuousOn (by simpa only [NNReal.coe_zero] using hR0) ε hε

end MolecularDynamics
