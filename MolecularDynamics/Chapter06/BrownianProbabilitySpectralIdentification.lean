import MolecularDynamics.Chapter06.BrownianC2Expectation
import MolecularDynamics.Chapter06.BrownianSpectralDecay
import Mathlib.Analysis.InnerProductSpace.Calculus
import Mathlib.Analysis.ODE.Gronwall

/-! Identification of the same original probability evolution with the actual
Gibbs spectral evolution, using true C2 preservation and closed-graph coefficients. -/

open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal InnerProductSpace LinearPMap

namespace MolecularDynamics
noncomputable section

private theorem actual_coefficient_right_ODE_eq_exp (a : ℝ → ℝ) (r T : ℝ) (hT : 0 ≤ T)
    (hc : ContinuousOn a (Icc 0 T))
    (hd : ∀ s ∈ Ico 0 T, HasDerivWithinAt a (r * a s) (Ici s) s) :
    a T = Real.exp (r * T) * a 0 := by
  let v : ℝ → ℝ := fun s ↦ Real.exp (r * s) * a 0
  have hv : Continuous v := by fun_prop
  have hdv (s : ℝ) : HasDerivAt v (r * v s) s := by
    have hh := (((hasDerivAt_id s).const_mul r).exp).mul_const (a 0)
    simpa only [v, id_eq, mul_one, mul_assoc, mul_left_comm, mul_comm] using hh
  have hdsub (s : ℝ) (hs : s ∈ Ico 0 T) :
      HasDerivWithinAt (fun r ↦ a r - v r) (r * a s - r * v s) (Ici s) s :=
    (hd s hs).sub (hdv s).hasDerivWithinAt
  have hzero : a 0 - v 0 = 0 := by simp [v]
  have hbound (s : ℝ) (_ : s ∈ Ico 0 T) :
      ‖r * a s - r * v s‖ ≤ ‖r‖ * ‖a s - v s‖ := by
    rw [← mul_sub, norm_mul]
  have hh := eq_zero_of_abs_deriv_le_mul_abs_self_of_eq_zero_right
    (hc.sub hv.continuousOn) hdsub hzero hbound T ⟨hT, le_rfl⟩
  exact sub_eq_zero.mp hh

variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
  {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f)

include hB hf hpf in
/-- The genuine evolved probability value and its true time derivative form a pair in the actual closed Gibbs graph. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2evolved_closed_graph (s : ℝ≥0) :
    (textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB s
        (textbookConfigurationContinuousObservable f hf.continuous hpf),
      textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB s
        (textbookBrownianC2ContinuousGeneratorImage m U hU hp β f hf hpf)) ∈
      (textbookBrownianGibbsClosedOperator m U hU hp β).graph := by
  let J := textbookGibbsContinuousToLp U hU hp β
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  let S := textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB s F
  let g : (Fin N → ℝ) → ℝ := fun q ↦ S (textbookConfigurationTorusProjection q)
  have hg : ContDiff ℝ 2 g :=
    textbookBrownianTorusProbabilityOperator_preserves_C2 m hm U hU hp β hβ B P hB f hf hpf s
  have hpg : textbookUnitPeriodicPotential g := by
    intro q n
    change S (textbookConfigurationTorusProjection (q + fun i ↦ (n i : ℝ))) =
      S (textbookConfigurationTorusProjection q)
    rw [textbookConfigurationTorusProjection_integer_translate]
  have heS : textbookConfigurationContinuousObservable g hg.continuous hpg = S := by
    ext X
    change S (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative X)) = S X
    rw [textbookConfigurationTorusRepresentative_projects]
  have hnew := textbookBrownianTorusProbabilityOperator_C2original_generator_tendsto
    m hm U hU hp β hβ B P hB g hg hpg
  rw [heS] at hnew
  have hold := textbookBrownianTorusProbabilityOperator_C2evolved_generator_tendsto
    m hm U hU hp β hβ B P hB f hf hpf s
  have heG : textbookBrownianC2ContinuousGeneratorImage m U hU hp β g hg hpg =
      textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB s
        (textbookBrownianC2ContinuousGeneratorImage m U hU hp β f hf hpf) :=
    tendsto_nhds_unique hnew hold
  have heJ : textbookBrownianC2GibbsL2GeneratorImage m U hU hp β g hg hpg =
      J (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB s
        (textbookBrownianC2ContinuousGeneratorImage m U hU hp β f hf hpf)) := by
    unfold textbookBrownianC2GibbsL2GeneratorImage
    rw [← textbookGibbsContinuousToLp_original_observable U hU hp β
      (textbookBrownianGenerator m U β g) (textbookBrownianC2Generator_continuous m U β g hU hg)
      (textbookBrownianC2Generator_periodic m U β g hp hpg)]
    change J (textbookBrownianC2ContinuousGeneratorImage m U hU hp β g hg hpg) = _
    rw [heG]
  have hgraph := textbookBrownianGibbsClosedOperator_C2graph m U hU hp β hβ.ne' g hg hpg
  rw [← textbookGibbsContinuousToLp_original_observable U hU hp β g hg.continuous hpg, heS, heJ] at hgraph
  exact hgraph

include hB hf hpf in
/-- Every genuine coefficient of the original probability evolution satisfies the actual generator eigenvalue ODE. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2coefficient_hasDeriv_right
    (j : textbookBrownianGibbsEigenIndex m U hU hp β) (s : ℝ) (hs : 0 ≤ s) :
    HasDerivWithinAt
      (fun t : ℝ ↦ ⟪textbookBrownianGibbsEigenbasis m hm U hU hp β hβ j,
        textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t.toNNReal
          (textbookConfigurationContinuousObservable f hf.continuous hpf)⟫_ℝ)
      (j.1 * ⟪textbookBrownianGibbsEigenbasis m hm U hU hp β hβ j,
        textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB s.toNNReal
          (textbookConfigurationContinuousObservable f hf.continuous hpf)⟫_ℝ) (Ioi s) s := by
  have hd := (innerSL ℝ (textbookBrownianGibbsEigenbasis m hm U hU hp β hβ j)).hasFDerivAt.comp_hasDerivWithinAt s
    (textbookBrownianProbabilityGibbsL2Image_C2hasDeriv_right m hm U hU hp β hβ B P hB f hf hpf s hs)
  have he := textbookBrownianGibbsClosedOperator_graph_coefficient m hm U hU hp β hβ _ _
    (textbookBrownianProbabilityGibbsL2Image_C2evolved_closed_graph m hm U hU hp β hβ B P hB f hf hpf s.toNNReal) j
  exact hd.congr_deriv he

include hB hf hpf in
/-- The original probability coefficients are the genuine exponential spectral coefficients, derived from the actual ODE. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2coefficient_eq_spectral
    (t : ℝ≥0) (j : textbookBrownianGibbsEigenIndex m U hU hp β) :
    ⟪textbookBrownianGibbsEigenbasis m hm U hU hp β hβ j,
      textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t
        (textbookConfigurationContinuousObservable f hf.continuous hpf)⟫_ℝ =
      textbookBrownianGibbsEvolutionWeight m U hU hp β t j *
      ⟪textbookBrownianGibbsEigenbasis m hm U hU hp β hβ j,
        textbookConfigurationGibbsL2Observable U hU hp β f hf.continuous hpf⟫_ℝ := by
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  let u : ℝ → Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) := fun s ↦
    textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB s.toNNReal F
  let a : ℝ → ℝ := fun s ↦ ⟪textbookBrownianGibbsEigenbasis m hm U hU hp β hβ j, u s⟫_ℝ
  have hu : Continuous u := textbookBrownianProbabilityGibbsL2Image_real_time_continuous U hU hp β m hm hβ B P hB F
  have ha : Continuous a := continuous_const.inner hu
  have hd (s : ℝ) (hs : s ∈ Ico 0 (t : ℝ)) : HasDerivWithinAt a (j.1 * a s) (Ici s) s :=
    (textbookBrownianProbabilityGibbsL2Image_C2coefficient_hasDeriv_right
      m hm U hU hp β hβ B P hB f hf hpf j s hs.1).Ici_of_Ioi
  have hh := actual_coefficient_right_ODE_eq_exp a j.1 t t.property ha.continuousOn hd
  have he0 : u 0 = textbookConfigurationGibbsL2Observable U hU hp β f hf.continuous hpf := by
    change textbookGibbsContinuousToLp U hU hp β
      (textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB (0 : ℝ).toNNReal F) = _
    rw [Real.toNNReal_zero, textbookBrownianTorusProbabilityOperator_zero]
    exact textbookGibbsContinuousToLp_original_observable U hU hp β f hf.continuous hpf
  simpa only [a, u, F, Real.toNNReal_coe, he0, textbookBrownianGibbsEvolutionWeight] using hh

include hB hf hpf in
/-- On every original C2 observable the same actual probability evolution equals the true closed-Gibbs spectral evolution. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2eq_spectral (t : ℝ≥0) :
    textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t
      (textbookConfigurationContinuousObservable f hf.continuous hpf) =
    textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
      (textbookConfigurationGibbsL2Observable U hU hp β f hf.continuous hpf) := by
  let b := textbookBrownianGibbsEigenbasis m hm U hU hp β hβ
  apply b.repr.injective
  ext j
  simp only [b.repr_apply_apply]
  rw [textbookBrownianProbabilityGibbsL2Image_C2coefficient_eq_spectral m hm U hU hp β hβ B P hB f hf hpf,
    textbookBrownianGibbsSpectralEvolution_coefficient]


include hB in
/-- Uniform density transports the proved original C2 probability identity to every actual continuous torus input. -/
theorem textbookBrownianProbabilityGibbsL2Image_eq_spectral (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F =
      textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t (textbookGibbsContinuousToLp U hU hp β F) := by
  let I := textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t
  let J := textbookGibbsContinuousToLp U hU hp β
  let T := textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
  let S : Set C(UnitAddTorus (Fin N), ℝ) := {F | I F = T (J F)}
  have hS : IsClosed S := isClosed_eq I.continuous (T.continuous.comp J.continuous)
  have hs : {G : C(UnitAddTorus (Fin N), ℝ) | ContDiff ℝ ∞ (fun q : Fin N → ℝ ↦
      G (textbookConfigurationTorusProjection q))} ⊆ S := by
    intro G hG
    let g : (Fin N → ℝ) → ℝ := fun q ↦ G (textbookConfigurationTorusProjection q)
    have hgInf : ContDiff ℝ ∞ g := hG
    have hg : ContDiff ℝ 2 g := hgInf.of_le (by simp)
    have hpg : textbookUnitPeriodicPotential g := by
      intro q n
      change G (textbookConfigurationTorusProjection (q + fun i ↦ (n i : ℝ))) =
        G (textbookConfigurationTorusProjection q)
      rw [textbookConfigurationTorusProjection_integer_translate]
    have heG : textbookConfigurationContinuousObservable g hg.continuous hpg = G := by
      ext X
      change G (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative X)) = G X
      rw [textbookConfigurationTorusRepresentative_projects]
    have hh := textbookBrownianProbabilityGibbsL2Image_C2eq_spectral m hm U hU hp β hβ B P hB g hg hpg t
    rw [← textbookGibbsContinuousToLp_original_observable U hU hp β g hg.continuous hpg, heG] at hh
    exact hh
  exact closure_minimal hs hS (textbookSmoothTorusReal_dense N F)

include hB in
/-- The actual continuous-input probability image satisfies the true Gibbs input-norm bound, derived from the proved spectral identity. -/
theorem textbookBrownianProbabilityGibbsL2Image_Gibbs_input_norm_le (t : ℝ≥0)
    (F : C(UnitAddTorus (Fin N), ℝ)) :
    ‖textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F‖ ≤
      ‖textbookGibbsContinuousToLp U hU hp β F‖ := by
  rw [textbookBrownianProbabilityGibbsL2Image_eq_spectral m hm U hU hp β hβ B P hB]
  exact textbookBrownianGibbsSpectralEvolution_norm m hm U hU hp β hβ t _

include hB in
/-- A genuine bounded operator on the entire original Gibbs L2 extends the same actual probability images. -/
theorem textbookBrownianGibbsProbabilityOperator_exists (t : ℝ≥0) :
    ∃ A : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →L[ℝ]
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      ‖A‖ ≤ 1 ∧ ∀ F : C(UnitAddTorus (Fin N), ℝ),
        A (textbookGibbsContinuousToLp U hU hp β F) =
          textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F := by
  refine ⟨textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t, ?_, ?_⟩
  · apply ContinuousLinearMap.opNorm_le_bound _ zero_le_one
    intro x
    simpa only [one_mul] using textbookBrownianGibbsSpectralEvolution_norm m hm U hU hp β hβ t x
  · intro F
    exact (textbookBrownianProbabilityGibbsL2Image_eq_spectral m hm U hU hp β hβ B P hB t F).symm

/-- The actual probability operator is selected from its proved whole-Gibbs bounded extension, rather than replacing the original probability construction. -/
def textbookBrownianGibbsProbabilityOperator (t : ℝ≥0) :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) →L[ℝ]
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  Classical.choose (textbookBrownianGibbsProbabilityOperator_exists m hm U hU hp β hβ B P hB t)

theorem textbookBrownianGibbsProbabilityOperator_spec (t : ℝ≥0) :
    ‖textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t‖ ≤ 1 ∧
      ∀ F : C(UnitAddTorus (Fin N), ℝ),
        textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t (textbookGibbsContinuousToLp U hU hp β F) =
          textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F :=
  Classical.choose_spec (textbookBrownianGibbsProbabilityOperator_exists m hm U hU hp β hβ B P hB t)

include hB in
/-- Density of the genuine continuous-observable inclusion identifies the entire actual probability extension with the original Gibbs spectral evolution. -/
theorem textbookBrownianGibbsProbabilityOperator_eq_spectral (t : ℝ≥0) :
    textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t =
      textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t := by
  let A := textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t
  let T := textbookBrownianGibbsSpectralEvolution m hm U hU hp β hβ t
  let J := textbookGibbsContinuousToLp U hU hp β
  have hc : IsClosed {x | A x = T x} := isClosed_eq A.continuous T.continuous
  have hs : range J ⊆ {x | A x = T x} := by
    rintro x ⟨F, rfl⟩
    exact (textbookBrownianGibbsProbabilityOperator_spec m hm U hU hp β hβ B P hB t).2 F |>.trans
      (textbookBrownianProbabilityGibbsL2Image_eq_spectral m hm U hU hp β hβ B P hB t F)
  apply ContinuousLinearMap.ext
  intro x
  exact closure_minimal hs hc (textbookGibbsContinuousToLp_denseRange U hU hp β x)


include hB in
theorem textbookBrownianGibbsProbabilityOperator_zero :
    textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB 0 =
      ContinuousLinearMap.id ℝ (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) := by
  rw [textbookBrownianGibbsProbabilityOperator_eq_spectral]
  exact textbookBrownianGibbsSpectralEvolution_zero m hm U hU hp β hβ

include hB in
/-- The actual whole-Gibbs probability extensions form the same true semigroup. -/
theorem textbookBrownianGibbsProbabilityOperator_add (s t : ℝ≥0) :
    textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB (s + t) =
      (textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB s).comp
        (textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t) := by
  simp only [textbookBrownianGibbsProbabilityOperator_eq_spectral]
  exact textbookBrownianGibbsSpectralEvolution_add m hm U hU hp β hβ s t

include hB in
/-- Strong continuity holds on the entire actual original Gibbs input space. -/
theorem textbookBrownianGibbsProbabilityOperator_continuous
    (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :
    Continuous (fun t : ℝ≥0 ↦ textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t x) := by
  simp only [textbookBrownianGibbsProbabilityOperator_eq_spectral]
  exact textbookBrownianGibbsSpectralEvolution_continuous m hm U hU hp β hβ x

include hB in
/-- The actual original probability semigroup is symmetric for the same original Gibbs pairing. -/
theorem textbookBrownianGibbsProbabilityOperator_isSymmetric (t : ℝ≥0) :
    (textbookBrownianGibbsProbabilityOperator m hm U hU hp β hβ B P hB t).toLinearMap.IsSymmetric := by
  rw [textbookBrownianGibbsProbabilityOperator_eq_spectral]
  exact textbookBrownianGibbsSpectralEvolution_isSymmetric m hm U hU hp β hβ t

end
end MolecularDynamics
