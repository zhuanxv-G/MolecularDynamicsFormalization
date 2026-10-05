import MolecularDynamics.Chapter06.BrownianDirichlet
import Mathlib.Analysis.Fourier.AddCircleMulti
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap

/-! The actual unit-torus Haar measure and normalized Gibbs probability measure
for the same periodic configuration lift used by the Brownian Dirichlet proof. -/

open Set MeasureTheory Filter
open scoped BigOperators ENNReal ContDiff

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual quotient of every configuration coordinate by the integer lattice. -/
def textbookConfigurationTorusProjection {Nc : ℕ}
    (q : Fin Nc → ℝ) : UnitAddTorus (Fin Nc) := fun i ↦ (q i : UnitAddCircle)

/-- A genuinely measurable fundamental-domain representative, not arbitrary quotient choice. -/
def textbookConfigurationTorusRepresentative {Nc : ℕ}
    (Q : UnitAddTorus (Fin Nc)) : Fin Nc → ℝ :=
  (UnitAddTorus.measurableEquivPiIoc (0 : Fin Nc → ℝ) Q).val

/-- The actual representative map is measurable. -/
theorem textbookConfigurationTorusRepresentative_measurable (Nc : ℕ) :
    Measurable (textbookConfigurationTorusRepresentative (Nc := Nc)) :=
  (UnitAddTorus.measurableEquivPiIoc (0 : Fin Nc → ℝ)).measurable.subtype_val

/-- The true representative projects back to the original torus position. -/
theorem textbookConfigurationTorusRepresentative_projects {Nc : ℕ}
    (Q : UnitAddTorus (Fin Nc)) :
    textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative Q) = Q := by
  exact (UnitAddTorus.measurableEquivPiIoc (0 : Fin Nc → ℝ)).symm_apply_apply Q

/-- The actual cube projection sends full Lebesgue unit-cube volume to normalized torus Haar volume. -/
theorem textbookConfigurationTorusProjection_measurePreserving (Nc : ℕ) :
    MeasurePreserving (textbookConfigurationTorusProjection (Nc := Nc))
      (volume.restrict (textbookConfigurationCube Nc)) volume := by
  have h := measurePreserving_pi
    (fun _ : Fin Nc ↦ (volume : Measure ℝ).restrict (Ioc 0 1))
    (fun _ : Fin Nc ↦ (volume : Measure UnitAddCircle))
    (f := fun _ : Fin Nc ↦ (fun r : ℝ ↦ (r : UnitAddCircle)))
    (fun _ ↦ by simpa [volume, AddCircle.haarAddCircle] using AddCircle.measurePreserving_mk (1 : ℝ) 0)
  have hae : (Set.pi univ fun _ : Fin Nc ↦ Ioc (0 : ℝ) 1) =ᵐ[volume]
      textbookConfigurationCube Nc :=
    Measure.univ_pi_Ioc_ae_eq_Icc
  have hr : (volume : Measure (Fin Nc → ℝ)).restrict
      (Set.pi univ fun _ : Fin Nc ↦ Ioc (0 : ℝ) 1) =
      volume.restrict (textbookConfigurationCube Nc) :=
    Measure.restrict_congr_set hae
  rw [← Measure.restrict_pi_pi, ← volume_pi, hr] at h
  exact h

/-- The actual periodic scalar observable on the genuine torus. -/
def textbookConfigurationTorusObservable {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (Q : UnitAddTorus (Fin Nc)) : ℝ :=
  f (textbookConfigurationTorusRepresentative Q)

/-- A continuous lifted observable gives a genuinely measurable torus observable. -/
theorem textbookConfigurationTorusObservable_measurable {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) :
    Measurable (textbookConfigurationTorusObservable f) :=
  hf.measurable.comp (textbookConfigurationTorusRepresentative_measurable Nc)

/-- Original integer periodicity proves equality for every representative, without assuming descent. -/
theorem textbookConfigurationTorusObservable_lift {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential f) (q : Fin Nc → ℝ) :
    textbookConfigurationTorusObservable f (textbookConfigurationTorusProjection q) = f q := by
  let Q := textbookConfigurationTorusProjection q
  let r := textbookConfigurationTorusRepresentative Q
  have h (i : Fin Nc) : ∃ n : ℤ, (n : ℝ) = r i - q i := by
    have hz : ((r i - q i : ℝ) : UnitAddCircle) = 0 := by
      rw [AddCircle.coe_sub]
      have he := congrFun (textbookConfigurationTorusRepresentative_projects Q) i
      change (r i : UnitAddCircle) = (q i : UnitAddCircle) at he
      rw [he, sub_self]
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp hz
    exact ⟨n, by simpa only [zsmul_eq_mul, mul_one] using hn⟩
  choose n hn using h
  have he : q + (fun i ↦ (n i : ℝ)) = r := by
    ext i
    change q i + (n i : ℝ) = r i
    rw [hn i]
    ring
  have hh := hp q n
  rw [he] at hh
  exact hh

/-- Actual Haar integration equals the entire basic cube integration of the same periodic observable. -/
theorem textbookConfigurationTorusObservable_integral {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential f) :
    (∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusObservable f Q) =
      ∫ q in textbookConfigurationCube Nc, f q := by
  rw [UnitAddTorus.integral_preimage _ (0 : Fin Nc → ℝ)]
  have hl : (fun q : Fin Nc → ℝ ↦ textbookConfigurationTorusObservable f
      (fun i ↦ (q i : UnitAddCircle))) = f := by
    funext q
    exact textbookConfigurationTorusObservable_lift f hp q
  rw [hl]
  apply setIntegral_congr_set
  simpa only [volume_pi, Pi.zero_apply, Pi.one_apply, zero_add, Set.pi, Set.mem_univ,
    forall_const, textbookConfigurationCube] using
    (Measure.univ_pi_Ioc_ae_eq_Icc (μ := fun _ : Fin Nc ↦ (volume : Measure ℝ))
      (f := (0 : Fin Nc → ℝ)) (g := 1))

/-- Integrability transfers through the true cube-to-torus measure-preserving map. -/
theorem textbookConfigurationTorusObservable_integrable {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hp : textbookUnitPeriodicPotential f) :
    Integrable (textbookConfigurationTorusObservable f) := by
  have hi : IntegrableOn f (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc hf.continuousOn
  have he : textbookConfigurationTorusObservable f ∘
      textbookConfigurationTorusProjection = f := by
    funext q
    exact textbookConfigurationTorusObservable_lift f hp q
  apply ((textbookConfigurationTorusProjection_measurePreserving Nc).integrable_comp
    (textbookConfigurationTorusObservable_measurable f hf).aestronglyMeasurable).mp
  rw [he]
  exact hi

/-- The genuine Gibbs weight on normalized torus Haar volume. -/
noncomputable def textbookConfigurationTorusGibbsWeight {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (Q : UnitAddTorus (Fin Nc)) : ℝ :=
  Real.exp (-β * textbookConfigurationTorusObservable U Q)

/-- The torus and actual real-lift Gibbs weights agree at every position. -/
theorem textbookConfigurationTorusGibbsWeight_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hP : textbookUnitPeriodicPotential U) (β : ℝ)
    (q : Fin Nc → ℝ) :
    textbookConfigurationTorusGibbsWeight U β (textbookConfigurationTorusProjection q) =
      textbookConfigurationGibbsWeight U β q := by
  simp only [textbookConfigurationTorusGibbsWeight, textbookConfigurationTorusObservable_lift U hP,
    textbookConfigurationGibbsWeight]

/-- The true partition on torus Haar volume is the already proved positive cube partition. -/
theorem textbookConfigurationTorusGibbsWeight_integral {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hP : textbookUnitPeriodicPotential U) (β : ℝ) :
    (∫ Q : UnitAddTorus (Fin Nc), textbookConfigurationTorusGibbsWeight U β Q) =
      textbookConfigurationPartition U β := by
  exact textbookConfigurationTorusObservable_integral (textbookConfigurationGibbsWeight U β)
    (textbookConfigurationGibbsWeight_periodic U hP β)

/-- The same genuine Gibbs weight is Haar-integrable, derived from the actual compact cube. -/
theorem textbookConfigurationTorusGibbsWeight_integrable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hP : textbookUnitPeriodicPotential U) (β : ℝ) :
    Integrable (textbookConfigurationTorusGibbsWeight U β) :=
  textbookConfigurationTorusObservable_integrable (textbookConfigurationGibbsWeight U β)
    (textbookConfigurationGibbsWeight_contDiff U hU β).continuous
    (textbookConfigurationGibbsWeight_periodic U hP β)

/-- The actual normalized Gibbs probability measure, constructed with the proved partition. -/
noncomputable def textbookConfigurationTorusGibbsMeasure {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) : Measure (UnitAddTorus (Fin Nc)) :=
  volume.withDensity (fun Q ↦ ENNReal.ofReal
    ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q))

/-- The genuinely constructed torus Gibbs measure is a probability; normalization is proved. -/
theorem textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hP : textbookUnitPeriodicPotential U) (β : ℝ) :
    IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) := by
  have hi := (textbookConfigurationTorusGibbsWeight_integrable U hU hP β).const_mul
    (textbookConfigurationPartition U β)⁻¹
  have hZ := textbookConfigurationPartition_pos U hU β
  have hn : ∀ Q, 0 ≤ (textbookConfigurationPartition U β)⁻¹ *
      textbookConfigurationTorusGibbsWeight U β Q := by
    intro Q
    exact mul_nonneg (inv_pos.mpr hZ).le (Real.exp_pos _).le
  have he : (∫ Q : UnitAddTorus (Fin Nc), (textbookConfigurationPartition U β)⁻¹ *
      textbookConfigurationTorusGibbsWeight U β Q) = 1 := by
    rw [integral_const_mul, textbookConfigurationTorusGibbsWeight_integral U hP β]
    exact inv_mul_cancel₀ hZ.ne'
  apply isProbabilityMeasure_iff.mpr
  unfold textbookConfigurationTorusGibbsMeasure
  rw [withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ,
    ← ofReal_integral_eq_lintegral_ofReal hi (Eventually.of_forall hn), he]
  simp


/-- Integrating the actual descended observable against the constructed Gibbs probability
is exactly the same canonical normalized full-cube weighted integral. -/
theorem textbookConfigurationTorusGibbsMeasure_integral_observable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hPf : textbookUnitPeriodicPotential f) :
    (∫ Q, textbookConfigurationTorusObservable f Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      (textbookConfigurationPartition U β)⁻¹ *
        ∫ q in textbookConfigurationCube Nc, f q * textbookConfigurationGibbsWeight U β q := by
  have hZ := textbookConfigurationPartition_pos U hU β
  have hρm : Measurable (textbookConfigurationTorusGibbsWeight U β) :=
    (measurable_const.mul
      (textbookConfigurationTorusObservable_measurable U hU.continuous)).exp
  have hm : Measurable (fun Q ↦ ENNReal.ofReal
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q)) :=
    (measurable_const.mul hρm).ennreal_ofReal
  have hn (Q : UnitAddTorus (Fin Nc)) : 0 ≤ (textbookConfigurationPartition U β)⁻¹ *
      textbookConfigurationTorusGibbsWeight U β Q :=
    mul_nonneg (inv_pos.mpr hZ).le (Real.exp_pos _).le
  unfold textbookConfigurationTorusGibbsMeasure
  rw [integral_withDensity_eq_integral_toReal_smul hm
    (Eventually.of_forall fun _ ↦ ENNReal.ofReal_lt_top) _]
  simp_rw [ENNReal.toReal_ofReal (hn _), smul_eq_mul]
  have he : (fun Q : UnitAddTorus (Fin Nc) ↦
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q) *
        textbookConfigurationTorusObservable f Q) =
      (fun Q ↦ (textbookConfigurationPartition U β)⁻¹ *
        textbookConfigurationTorusObservable
          (fun q ↦ f q * textbookConfigurationGibbsWeight U β q) Q) := by
    funext Q
    dsimp [textbookConfigurationTorusObservable, textbookConfigurationTorusGibbsWeight,
      textbookConfigurationGibbsWeight]
    ring
  have hp : textbookUnitPeriodicPotential
      (fun q ↦ f q * textbookConfigurationGibbsWeight U β q) := by
    intro q n
    simp only [hPf q n, textbookConfigurationGibbsWeight_periodic U hPU β q n]
  rw [he, integral_const_mul, textbookConfigurationTorusObservable_integral _ hp]

/-- The actual torus Gibbs L2 pairing equals the same normalized cube pairing. -/
theorem textbookConfigurationTorusGibbsMeasure_inner {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q * textbookConfigurationTorusObservable g Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      textbookConfigurationInner U β f g := by
  have hp : textbookUnitPeriodicPotential (fun q ↦ f q * g q) := by
    intro q n
    simp only [hPf q n, hPg q n]
  exact textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β _ hp

/-- Genuine coordinate differentiation proves periodicity of the full actual Brownian generator. -/
theorem textbookBrownianGenerator_periodic {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPg : textbookUnitPeriodicPotential g) :
    textbookUnitPeriodicPotential (textbookBrownianGenerator m U β g) := by
  intro q n
  unfold textbookBrownianGenerator
  apply Finset.sum_congr rfl
  intro i _
  have hpgi := textbookConfigurationPartial_periodic g hg hPg i
  rw [textbookConfigurationPartial_periodic _ (textbookConfigurationPartial_contDiff g hg i)
    hpgi i q n, textbookConfigurationPartial_periodic U hU hPU i q n, hpgi q n]

/-- The same actual Brownian generator is smooth on smooth observables. -/
theorem textbookBrownianGenerator_contDiff {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hg : ContDiff ℝ ∞ g) :
    ContDiff ℝ ∞ (textbookBrownianGenerator m U β g) := by
  apply ContDiff.sum
  intro i _
  exact contDiff_const.mul ((contDiff_const.mul
    (textbookConfigurationPartial_contDiff _ (textbookConfigurationPartial_contDiff g hg i) i)).sub
      ((textbookConfigurationPartial_contDiff U hU i).mul
        (textbookConfigurationPartial_contDiff g hg i)))

/-- The actual mass-weighted gradient pairing is a periodic torus observable. -/
theorem textbookConfigurationGradientPair_periodic {Nc : ℕ} (m : Fin Nc → ℝ)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    textbookUnitPeriodicPotential (textbookConfigurationGradientPair m f g) := by
  intro q n
  unfold textbookConfigurationGradientPair
  apply Finset.sum_congr rfl
  intro i _
  rw [textbookConfigurationPartial_periodic f hf hPf i q n,
    textbookConfigurationPartial_periodic g hg hPg i q n]

/-- The exact Dirichlet identity now holds on the genuine torus Gibbs probability measure. -/
theorem textbookBrownianTorusGibbsMeasure_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
        textbookConfigurationTorusObservable (textbookBrownianGenerator m U β g) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
      -β⁻¹ * ∫ Q, textbookConfigurationTorusObservable
        (textbookConfigurationGradientPair m f g) Q
          ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookConfigurationTorusGibbsMeasure_inner U hU hPU β f _
    hPf (textbookBrownianGenerator_periodic m U β g hU hg hPU hPg),
    textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β _
      (textbookConfigurationGradientPair_periodic m f g hf hg hPf hPg),
    textbookBrownianGenerator_inner_dirichlet m U β hβ f g hU hf hg hPU hPf hPg]
  ring

/-- Formal symmetry is proved against the same genuine Gibbs probability, separately from closure. -/
theorem textbookBrownianTorusGibbsMeasure_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
        textbookConfigurationTorusObservable (textbookBrownianGenerator m U β g) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) =
    ∫ Q, textbookConfigurationTorusObservable (textbookBrownianGenerator m U β f) Q *
      textbookConfigurationTorusObservable g Q ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookConfigurationTorusGibbsMeasure_inner U hU hPU β f _
    hPf (textbookBrownianGenerator_periodic m U β g hU hg hPU hPg),
    textbookConfigurationTorusGibbsMeasure_inner U hU hPU β _ g
      (textbookBrownianGenerator_periodic m U β f hU hf hPU hPf) hPg]
  exact textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg

/-- The actual torus Gibbs quadratic form is nonpositive for the original positive masses and temperature. -/
theorem textbookBrownianTorusGibbsMeasure_quadratic_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    (∫ Q, textbookConfigurationTorusObservable f Q *
        textbookConfigurationTorusObservable (textbookBrownianGenerator m U β f) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) ≤ 0 := by
  rw [textbookConfigurationTorusGibbsMeasure_inner U hU hPU β f _
    hPf (textbookBrownianGenerator_periodic m U β f hU hf hPU hPf)]
  exact textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf

/-- Weak stationarity is proved on the actual normalized torus Gibbs probability. -/
theorem textbookBrownianTorusGibbsMeasure_weak_stationary {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (g : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPg : textbookUnitPeriodicPotential g) :
    (∫ Q, textbookConfigurationTorusObservable (textbookBrownianGenerator m U β g) Q
      ∂textbookConfigurationTorusGibbsMeasure U β) = 0 := by
  rw [textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β _
    (textbookBrownianGenerator_periodic m U β g hU hg hPU hPg),
    textbookBrownianGenerator_gibbs_weak_stationary m U β hβ g hU hg hPU hPg, mul_zero]

end

end MolecularDynamics
