import MolecularDynamics.Chapter06.WienerVectorContinuousPath
import Mathlib.MeasureTheory.Constructions.Polish.Basic

/-! Actual future Wiener increments and independence from the entire vector history.
These are necessary probability-law dependencies of Theorem 6.2 (printed 252 / PDF 273).
The time shift is deterministic; no stopping-time or Langevin conditional law is asserted. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology NNReal ENNReal

namespace MolecularDynamics

/-- The literal future increments of the original finite-dimensional Wiener process. -/
noncomputable def textbookWienerVectorFuture {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (S : ℝ≥0) (t : ℝ≥0) (ω : Ω) : Fin Nc → ℝ :=
  B (S + t) ω - B S ω

/-- All coordinates of the actual future process are jointly Gaussian. -/
theorem textbookWienerVectorFuture_gaussian {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) :
    IsGaussianProcess (fun z : (_ : Fin Nc) × ℝ≥0 ↦
      fun ω ↦ textbookWienerVectorFuture B S z.2 ω z.1) P := by
  classical
  apply hB.gaussian.of_isGaussianProcess
  intro z
  refine ⟨{⟨z.1, S + z.2⟩, ⟨z.1, S⟩},
    { toFun := fun v ↦ v ⟨⟨z.1, S + z.2⟩, by simp⟩ - v ⟨⟨z.1, S⟩, by simp⟩
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

/-- The original future process has the full standard vector Wiener law, including continuity. -/
theorem textbookWienerVectorFuture_isWiener {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) : textbookIsWienerVector (textbookWienerVectorFuture B S) P where
  gaussian := textbookWienerVectorFuture_gaussian B P hB S
  mean i t := (textbookWienerVector_coordinate B P hB i).shift S |>.integral_eval t
  covariance i j s t := by
    by_cases hij : i = j
    · subst j
      simpa [textbookWienerVectorFuture] using
        ((textbookWienerVector_coordinate B P hB i).shift S).covariance_eval s t
    · have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
      change cov[fun ω ↦ B (S + s) ω i - B S ω i,
        fun ω ↦ B (S + t) ω j - B S ω j; P] = _
      rw [covariance_fun_sub_fun_sub]
      · simp [hB.covariance, hij]
      all_goals first
        | exact (hB.gaussian.hasGaussianLaw_eval ⟨i, S + s⟩).memLp_two
        | exact (hB.gaussian.hasGaussianLaw_eval ⟨i, S⟩).memLp_two
        | exact (hB.gaussian.hasGaussianLaw_eval ⟨j, S + t⟩).memLp_two
        | exact (hB.gaussian.hasGaussianLaw_eval ⟨j, S⟩).memLp_two
  cont := by
    filter_upwards [hB.cont] with ω hc
    exact (hc.comp (continuous_const.add continuous_id)).sub continuous_const

/-- Every actual future endpoint has independent centered coordinates of variance t. -/
theorem textbookWienerVectorFuture_hasLaw_eval {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S t : ℝ≥0) :
    HasLaw (textbookWienerVectorFuture B S t) (Measure.pi (fun _ : Fin Nc ↦ gaussianReal 0 t)) P := by
  have hf := textbookWienerVectorFuture_isWiener B P hB S
  have hi := (textbookWienerVector_coordinates_independent _ P hf).comp
    (fun _ f ↦ f t) (fun _ ↦ measurable_pi_apply t)
  exact hi.hasLaw_pi (fun i ↦ (textbookWienerVector_coordinate _ P hf i).hasLaw_eval t)

/-- The actual covariance of every future coordinate with every past coordinate is zero. -/
theorem textbookWienerVectorFuture_covariance_history {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S t u : ℝ≥0) (hu : u ≤ S) (i j : Fin Nc) :
    cov[fun ω ↦ textbookWienerVectorFuture B S t ω i, fun ω ↦ B u ω j; P] = 0 := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  change cov[fun ω ↦ B (S + t) ω i - B S ω i, fun ω ↦ B u ω j; P] = 0
  rw [covariance_fun_sub_left]
  · rw [hB.covariance, hB.covariance, min_eq_right (hu.trans (le_add_right le_rfl)),
      min_eq_right hu]
    simp
  all_goals first
    | exact (hB.gaussian.hasGaussianLaw_eval ⟨i, S + t⟩).memLp_two
    | exact (hB.gaussian.hasGaussianLaw_eval ⟨i, S⟩).memLp_two
    | exact (hB.gaussian.hasGaussianLaw_eval ⟨j, u⟩).memLp_two

/-- Whole future increments are independent of the whole vector history up to deterministic S. -/
theorem textbookWienerVectorFuture_independent_history {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) :
    IndepFun (fun ω t ↦ textbookWienerVectorFuture B S t ω)
      (fun ω (u : Iic S) ↦ B u ω) P := by
  classical
  let X : ((_ : Fin Nc) × ℝ≥0) → Ω → ℝ := fun z ω ↦ textbookWienerVectorFuture B S z.2 ω z.1
  let Y : ((_ : Fin Nc) × Iic S) → Ω → ℝ := fun z ω ↦ B z.2 ω z.1
  have hg : IsGaussianProcess (Sum.elim X Y) P := by
    apply hB.gaussian.of_isGaussianProcess
    rintro (⟨i, t⟩ | ⟨i, u⟩)
    · refine ⟨{⟨i, S + t⟩, ⟨i, S⟩},
        { toFun := fun v ↦ v ⟨⟨i, S + t⟩, by simp⟩ - v ⟨⟨i, S⟩, by simp⟩
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
    · refine ⟨{⟨i, (u : ℝ≥0)⟩},
        { toFun := fun v ↦ v ⟨⟨i, (u : ℝ≥0)⟩, by simp⟩
          map_add' := by intros; rfl
          map_smul' := by intros; rfl }, ?_⟩
      intro ω
      rfl
  have hi := hg.indepFun_of_covariance_eq_zero
    (fun z ↦ (hB.gaussian.aemeasurable ⟨z.1, S + z.2⟩).sub
      (hB.gaussian.aemeasurable ⟨z.1, S⟩))
    (fun z ↦ hB.gaussian.aemeasurable ⟨z.1, (z.2 : ℝ≥0)⟩)
    (fun z w ↦ textbookWienerVectorFuture_covariance_history B P hB S z.2 w.2 w.2.2 z.1 w.1)
  exact hi.comp (φ := fun f t i ↦ f ⟨i, t⟩) (ψ := fun f u i ↦ f ⟨i, u⟩) (by fun_prop) (by fun_prop)

/-- All actual countable vector samples have the same law across standard Wiener models. -/
theorem textbookWienerVectorSamples_law_eq {Nc : ℕ} {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (C : ℝ≥0 → Ω' → (Fin Nc → ℝ)) (Q : Measure Ω') (hC : textbookIsWienerVector C Q)
    (t : ℕ → ℝ≥0) :
    P.map (fun ω n ↦ B (t n) ω) = Q.map (fun ω n ↦ C (t n) ω) := by
  have mb (i : Fin Nc) : AEMeasurable (fun ω n ↦ B (t n) ω i) P :=
    .of_eval (fun n ↦ hB.gaussian.aemeasurable ⟨i, t n⟩)
  have mc (i : Fin Nc) : AEMeasurable (fun ω n ↦ C (t n) ω i) Q :=
    .of_eval (fun n ↦ hC.gaussian.aemeasurable ⟨i, t n⟩)
  have ib : iIndepFun (fun (i : Fin Nc) ω n ↦ B (t n) ω i) P :=
    (textbookWienerVector_coordinates_independent B P hB).comp
      (fun _ f n ↦ f (t n)) (by fun_prop)
  have ic : iIndepFun (fun (i : Fin Nc) ω n ↦ C (t n) ω i) Q :=
    (textbookWienerVector_coordinates_independent C Q hC).comp
      (fun _ f n ↦ f (t n)) (by fun_prop)
  have he : P.map (fun ω i n ↦ B (t n) ω i) = Q.map (fun ω i n ↦ C (t n) ω i) := by
    rw [ib.map_fun_eq_pi_map mb, ic.map_fun_eq_pi_map mc]
    congr 1
    funext i
    exact textbookWienerSamples_law_eq _ P (textbookWienerVector_coordinate B P hB i).toIsPreBrownianReal
      _ Q (textbookWienerVector_coordinate C Q hC i).toIsPreBrownianReal t
  let f : (Fin Nc → ℕ → ℝ) → (ℕ → Fin Nc → ℝ) := fun z n i ↦ z i n
  have mf : Measurable f := by fun_prop
  have h := congrArg (Measure.map f) he
  rw [AEMeasurable.map_map_of_aemeasurable mf.aemeasurable (.of_eval mb),
    AEMeasurable.map_map_of_aemeasurable mf.aemeasurable (.of_eval mc)] at h
  exact h

/-- Future increments have the original vector Wiener law at all countably many sampled times. -/
theorem textbookWienerVectorFuture_samples_law {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) (t : ℕ → ℝ≥0) :
    P.map (fun ω n ↦ textbookWienerVectorFuture B S (t n) ω) = P.map (fun ω n ↦ B (t n) ω) :=
  textbookWienerVectorSamples_law_eq _ P (textbookWienerVectorFuture_isWiener B P hB S) B P hB t

private theorem continuousPath_comap {Nc : ℕ} (T : ℝ) :
    (ContinuousMap.measurableSpace : MeasurableSpace C(Icc 0 T, Fin Nc → ℝ)) =
      MeasurableSpace.comap (fun f : C(Icc 0 T, Fin Nc → ℝ) ↦ fun t ↦ f t) MeasurableSpace.pi := by
  rw [ContinuousMap.measurableSpace_eq_iSup_comap_eval]
  simp only [MeasurableSpace.pi, MeasurableSpace.comap_iSup, MeasurableSpace.comap_comp,
    Function.comp_def]

/-- The Borel law of actual continuous interval Wiener paths is determined by the standard vector law. -/
theorem textbookWienerVectorContinuousPath_law_eq {Nc : ℕ} {Ω Ω' : Type*}
    [MeasurableSpace Ω] [MeasurableSpace Ω']
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (C : ℝ≥0 → Ω' → (Fin Nc → ℝ)) (Q : Measure Ω') (hC : textbookIsWienerVector C Q)
    (T : ℝ) (hT : 0 ≤ T) :
    P.map (textbookWienerVectorContinuousPath B T) = Q.map (textbookWienerVectorContinuousPath C T) := by
  let : Nonempty (Icc (0 : ℝ) T) := ⟨⟨0, le_rfl, hT⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ) T)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  let e : C(Icc 0 T, Fin Nc → ℝ) → (ℕ → Fin Nc → ℝ) := fun f n ↦ f (u n)
  have ce : Continuous e := by fun_prop
  have ie : Function.Injective e := by
    intro f g he
    apply ContinuousMap.ext
    intro t
    exact hu.induction_on t (isClosed_eq f.continuous g.continuous) (fun n ↦ congrFun he n)
  have me : MeasurableEmbedding e := ce.measurableEmbedding ie
  apply me.map_injective
  have mb := textbookWienerVectorContinuousPath_aemeasurable B P hB T
  have mc := textbookWienerVectorContinuousPath_aemeasurable C Q hC T
  rw [AEMeasurable.map_map_of_aemeasurable me.measurable.aemeasurable mb,
    AEMeasurable.map_map_of_aemeasurable me.measurable.aemeasurable mc]
  let t : ℕ → ℝ≥0 := fun n ↦ ⟨(u n).1, (u n).2.1⟩
  have eb : (e ∘ textbookWienerVectorContinuousPath B T) =ᵐ[P] (fun ω n ↦ B (t n) ω) := by
    filter_upwards [hB.cont] with ω hc
    exact funext (fun n ↦ textbookWienerVectorContinuousPath_eval B T ω hc (u n))
  have ec : (e ∘ textbookWienerVectorContinuousPath C T) =ᵐ[Q] (fun ω n ↦ C (t n) ω) := by
    filter_upwards [hC.cont] with ω hc
    exact funext (fun n ↦ textbookWienerVectorContinuousPath_eval C T ω hc (u n))
  rw [Measure.map_congr eb, Measure.map_congr ec]
  exact textbookWienerVectorSamples_law_eq B P hB C Q hC t

/-- Future increments have the original continuous-path Borel law on every nonnegative finite horizon. -/
theorem textbookWienerVectorFuture_continuousPath_law {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (S : ℝ≥0) (T : ℝ) (hT : 0 ≤ T) :
    P.map (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T) =
      P.map (textbookWienerVectorContinuousPath B T) :=
  textbookWienerVectorContinuousPath_law_eq _ P (textbookWienerVectorFuture_isWiener B P hB S) B P hB T hT
/-- The true continuous future path and true continuous history are independent random variables. -/
theorem textbookWienerVectorFuture_continuousPath_independent_history {Nc : ℕ} {Ω : Type*}
    [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω)
    (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    IndepFun (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T)
      (textbookWienerVectorContinuousPath B S) P := by
  let r : (ℝ≥0 → Fin Nc → ℝ) → (Icc 0 T → Fin Nc → ℝ) := fun f t ↦ f ⟨t.1, t.2.1⟩
  let q : (Iic S → Fin Nc → ℝ) → (Icc (0 : ℝ) S → Fin Nc → ℝ) :=
    fun f t ↦ f ⟨⟨t.1, t.2.1⟩, by exact_mod_cast t.2.2⟩
  have hi := (textbookWienerVectorFuture_independent_history B P hB S).comp
    (φ := r) (ψ := q) (by fun_prop) (by fun_prop)
  have hf := textbookWienerVectorFuture_isWiener B P hB S
  have ef : (r ∘ fun ω t ↦ textbookWienerVectorFuture B S t ω) =ᵐ[P]
      (fun ω t ↦ textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T ω t) := by
    filter_upwards [hf.cont] with ω hc
    exact funext (fun t ↦ (textbookWienerVectorContinuousPath_eval _ T ω hc t).symm)
  have eh : (q ∘ fun ω u ↦ B u ω) =ᵐ[P]
      (fun ω t ↦ textbookWienerVectorContinuousPath B S ω t) := by
    filter_upwards [hB.cont] with ω hc
    exact funext (fun t ↦ (textbookWienerVectorContinuousPath_eval B S ω hc t).symm)
  have h := hi.congr ef eh
  rw [IndepFun_iff_Indep] at h ⊢
  simpa only [continuousPath_comap, MeasurableSpace.comap_comp, Function.comp_def] using h
end MolecularDynamics