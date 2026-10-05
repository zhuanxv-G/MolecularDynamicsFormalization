import MolecularDynamics.Chapter06.BrownianTorusGibbs
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.MeasureTheory.Function.LpSpace.ContinuousFunctions

/-! Genuine Gibbs weighted L2 observables and the actual Brownian smooth-test images
needed for Theorem 6.1, printed 250–251 / PDF 271–272.
No closed self-adjoint realization or spectral gap is assumed or claimed. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace RealInnerProductSpace

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)


/-- The same coordinate quotient is an actual open quotient map. -/
theorem textbookConfigurationTorusProjection_isOpenQuotientMap (Nc : ℕ) :
    IsOpenQuotientMap (textbookConfigurationTorusProjection (Nc := Nc)) := by
  exact IsOpenQuotientMap.piMap fun _ : Fin Nc ↦
    (QuotientAddGroup.isOpenQuotientMap_mk :
      IsOpenQuotientMap (fun r : ℝ ↦ (r : UnitAddCircle)))

/-- Actual real continuity and periodicity imply continuity on the genuine torus,
although the chosen measurable representative itself has boundary jumps. -/
theorem textbookConfigurationTorusObservable_continuous {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hp : textbookUnitPeriodicPotential f) :
    Continuous (textbookConfigurationTorusObservable f) := by
  apply (textbookConfigurationTorusProjection_isOpenQuotientMap Nc).isQuotientMap.continuous_iff.mpr
  have he : textbookConfigurationTorusObservable f ∘ textbookConfigurationTorusProjection = f := by
    funext q
    exact textbookConfigurationTorusObservable_lift f hp q
  rw [he]
  exact hf

/-- Same-model torus observables belong to actual Gibbs L2; membership is derived
from torus compactness and the genuinely proved Gibbs probability normalization. -/
theorem textbookConfigurationTorusGibbsMeasure_memLp_two {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    MemLp (textbookConfigurationTorusObservable f) 2 (textbookConfigurationTorusGibbsMeasure U β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  exact ContinuousMap.memLp (textbookConfigurationTorusGibbsMeasure U β) ℝ
    ⟨textbookConfigurationTorusObservable f,
      textbookConfigurationTorusObservable_continuous f hf hPf⟩

/-- The literal observable embedded into the actual Gibbs weighted Hilbert L2 space. -/
noncomputable def textbookConfigurationGibbsL2Observable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  (textbookConfigurationTorusGibbsMeasure_memLp_two U hU hPU β f hf hPf).toLp
    (textbookConfigurationTorusObservable f)

/-- The Hilbert representative is the same original observable almost everywhere for the same measure. -/
theorem textbookConfigurationGibbsL2Observable_ae_eq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    (textbookConfigurationGibbsL2Observable U hU hPU β f hf hPf :
      UnitAddTorus (Fin Nc) → ℝ) =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
        textbookConfigurationTorusObservable f :=
  MemLp.coeFn_toLp _

/-- The genuine Hilbert inner product is exactly the previously proved canonical weighted pairing. -/
theorem textbookConfigurationGibbsL2Observable_inner {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hg : Continuous g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    ⟪textbookConfigurationGibbsL2Observable U hU hPU β f hf hPf,
      textbookConfigurationGibbsL2Observable U hU hPU β g hg hPg⟫_ℝ =
        textbookConfigurationInner U β f g := by
  rw [L2.inner_def]
  apply Eq.trans _ (textbookConfigurationTorusGibbsMeasure_inner U hU hPU β f g hPf hPg)
  apply integral_congr_ae
  filter_upwards [textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f hf hPf,
    textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β g hg hPg] with Q hff hgg
  rw [hff, hgg, Real.inner_apply]

/-- The actual weighted L2 norm squared equals the same canonical mean square. -/
theorem textbookConfigurationGibbsL2Observable_norm_sq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hPf : textbookUnitPeriodicPotential f) :
    ‖textbookConfigurationGibbsL2Observable U hU hPU β f hf hPf‖ ^ 2 =
      textbookConfigurationInner U β f f := by
  rw [← real_inner_self_eq_norm_sq,
    textbookConfigurationGibbsL2Observable_inner U hU hPU β f f hf hf hPf hPf]

/-- The actual same-model Brownian generator image belongs to the same Gibbs L2 space. -/
noncomputable def textbookBrownianGibbsL2Image {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  textbookConfigurationGibbsL2Observable U hU hPU β (textbookBrownianGenerator m U β f)
    (textbookBrownianGenerator_contDiff m U β f hU hf).continuous
    (textbookBrownianGenerator_periodic m U β f hU hf hPU hPf)

/-- The actual Hilbert image is almost everywhere the literal original Brownian generator. -/
theorem textbookBrownianGibbsL2Image_ae_eq {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    (textbookBrownianGibbsL2Image m U hU hPU β f hf hPf : UnitAddTorus (Fin Nc) → ℝ)
      =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
        textbookConfigurationTorusObservable (textbookBrownianGenerator m U β f) :=
  textbookConfigurationGibbsL2Observable_ae_eq _ _ _ _ _ _ _

/-- The actual Gibbs Hilbert inner product satisfies the complete Brownian Dirichlet identity. -/
theorem textbookBrownianGibbsL2Image_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    ⟪textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hPf,
      textbookBrownianGibbsL2Image m U hU hPU β g hg hPg⟫_ℝ =
        -β⁻¹ * ∫ Q, textbookConfigurationTorusObservable
          (textbookConfigurationGradientPair m f g) Q
            ∂textbookConfigurationTorusGibbsMeasure U β := by
  unfold textbookBrownianGibbsL2Image
  rw [textbookConfigurationGibbsL2Observable_inner,
    textbookConfigurationTorusGibbsMeasure_integral_observable U hU hPU β _
      (textbookConfigurationGradientPair_periodic m f g hf hg hPf hPg),
    textbookBrownianGenerator_inner_dirichlet m U β hβ f g hU hf hg hPU hPf hPg]
  ring

/-- Same-model Gibbs Hilbert formal symmetry on actual smooth periodic observables. -/
theorem textbookBrownianGibbsL2Image_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g) :
    ⟪textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hPf,
      textbookBrownianGibbsL2Image m U hU hPU β g hg hPg⟫_ℝ =
    ⟪textbookBrownianGibbsL2Image m U hU hPU β f hf hPf,
      textbookConfigurationGibbsL2Observable U hU hPU β g hg.continuous hPg⟫_ℝ := by
  unfold textbookBrownianGibbsL2Image
  rw [textbookConfigurationGibbsL2Observable_inner, textbookConfigurationGibbsL2Observable_inner]
  exact textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg

/-- Actual nonpositivity in the actual weighted Hilbert space, with all original positive masses. -/
theorem textbookBrownianGibbsL2Image_quadratic_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f) :
    ⟪textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hPf,
      textbookBrownianGibbsL2Image m U hU hPU β f hf hPf⟫_ℝ ≤ 0 := by
  unfold textbookBrownianGibbsL2Image
  rw [textbookConfigurationGibbsL2Observable_inner]
  exact textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf


/-- A real eigenvalue for an actual nonzero smooth-test Hilbert vector is nonpositive. -/
theorem textbookBrownianGibbsL2Image_real_eigenvalue_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hPf : textbookUnitPeriodicPotential f)
    (ℓ : ℝ)
    (hne : textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hPf ≠ 0)
    (heig : textbookBrownianGibbsL2Image m U hU hPU β f hf hPf =
      ℓ • textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hPf) :
    ℓ ≤ 0 := by
  have hn := textbookBrownianGibbsL2Image_quadratic_nonpos m hm U hU hPU β hβ f hf hPf
  rw [heig, real_inner_smul_right, real_inner_self_eq_norm_sq] at hn
  apply le_of_not_gt
  intro hℓ
  exact (not_lt_of_ge hn) (mul_pos hℓ (pow_pos (norm_pos_iff.mpr hne) 2))

/-- The actual constant observable is a zero mode of the same Hilbert generator image. -/
theorem textbookBrownianGibbsL2Image_const {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β c : ℝ) :
    textbookBrownianGibbsL2Image m U hU hPU β (fun _ ↦ c)
      contDiff_const (by intro _ _; rfl) = 0 := by
  apply Lp.ext
  filter_upwards [textbookBrownianGibbsL2Image_ae_eq m U hU hPU β (fun _ ↦ c)
      contDiff_const (by intro _ _; rfl),
    Lp.coeFn_zero ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)] with Q hQ hz
  rw [hQ, hz, textbookBrownianGenerator_const]
  rfl

/-- Normalization proves that the actual constant-one Hilbert vector has norm one. -/
theorem textbookConfigurationGibbsL2Observable_one_norm {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    ‖textbookConfigurationGibbsL2Observable U hU hPU β (fun _ ↦ 1)
      continuous_const (by intro _ _; rfl)‖ = 1 := by
  have hsq := textbookConfigurationGibbsL2Observable_norm_sq U hU hPU β (fun _ ↦ 1)
    continuous_const (by intro _ _; rfl)
  have hi : textbookConfigurationInner U β (fun _ ↦ 1) (fun _ ↦ 1) = 1 := by
    unfold textbookConfigurationInner
    simp only [one_mul]
    exact inv_mul_cancel₀ (textbookConfigurationPartition_pos U hU β).ne'
  rw [hi] at hsq
  have hn := norm_nonneg (textbookConfigurationGibbsL2Observable U hU hPU β (fun _ ↦ 1)
    continuous_const (by intro _ _; rfl))
  nlinarith

/-- The zero eigenvalue has a genuine nonzero Hilbert vector in every configuration dimension. -/
theorem textbookConfigurationGibbsL2Observable_one_ne_zero {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookConfigurationGibbsL2Observable U hU hPU β (fun _ ↦ 1)
      continuous_const (by intro _ _; rfl) ≠ 0 := by
  intro hz
  have hn := textbookConfigurationGibbsL2Observable_one_norm U hU hPU β
  rw [hz, norm_zero] at hn
  exact zero_ne_one hn


/-- The genuine strictly positive Gibbs density proves the reverse absolute continuity,
rather than assuming support or a nondegenerate weighted norm. -/
theorem textbookConfigurationTorusHaar_absolutelyContinuous_gibbs {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (_hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (volume : Measure (UnitAddTorus (Fin Nc))) ≪ textbookConfigurationTorusGibbsMeasure U β := by
  have hZ := textbookConfigurationPartition_pos U hU β
  have hρm : Measurable (textbookConfigurationTorusGibbsWeight U β) :=
    (measurable_const.mul
      (textbookConfigurationTorusObservable_measurable U hU.continuous)).exp
  have hm : Measurable (fun Q ↦ ENNReal.ofReal
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q)) :=
    (measurable_const.mul hρm).ennreal_ofReal
  have hn (Q : UnitAddTorus (Fin Nc)) : ENNReal.ofReal
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q) ≠ 0 :=
    (ENNReal.ofReal_pos.mpr (mul_pos (inv_pos.mpr hZ) (Real.exp_pos _))).ne'
  intro s hs
  change (volume.withDensity (fun Q ↦ ENNReal.ofReal
    ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q))) s = 0 at hs
  have he := (withDensity_apply_eq_zero hm).mp hs
  have hu : {Q : UnitAddTorus (Fin Nc) | ENNReal.ofReal
      ((textbookConfigurationPartition U β)⁻¹ * textbookConfigurationTorusGibbsWeight U β Q) ≠ 0} = univ := by
    ext Q
    exact ⟨fun _ ↦ trivial, fun _ ↦ hn Q⟩
  simpa only [hu, univ_inter] using he

/-- The actual Gibbs probability gives positive measure to every nonempty open torus set. -/
theorem textbookConfigurationTorusGibbsMeasure_isOpenPosMeasure {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Measure.IsOpenPosMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
  (textbookConfigurationTorusHaar_absolutelyContinuous_gibbs U hU hPU β).isOpenPosMeasure

/-- The same actual Gibbs Hilbert embedding is injective on continuous periodic lifts;
pointwise domain identity follows from full support and is not assumed. -/
theorem textbookConfigurationGibbsL2Observable_injective {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : Continuous f) (hg : Continuous g)
    (hPf : textbookUnitPeriodicPotential f) (hPg : textbookUnitPeriodicPotential g)
    (heq : textbookConfigurationGibbsL2Observable U hU hPU β f hf hPf =
      textbookConfigurationGibbsL2Observable U hU hPU β g hg hPg) : f = g := by
  have := textbookConfigurationTorusGibbsMeasure_isOpenPosMeasure U hU hPU β
  have ha : textbookConfigurationTorusObservable f =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      textbookConfigurationTorusObservable g :=
    (textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f hf hPf).symm.trans
      (by rw [heq]; exact textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β g hg hPg)
  have hq : textbookConfigurationTorusObservable f = textbookConfigurationTorusObservable g :=
    ((textbookConfigurationTorusObservable_continuous f hf hPf).ae_eq_iff_eq
      (textbookConfigurationTorusGibbsMeasure U β)
      (textbookConfigurationTorusObservable_continuous g hg hPg)).mp ha
  funext q
  have hh := congrFun hq (textbookConfigurationTorusProjection q)
  simpa only [textbookConfigurationTorusObservable_lift f hPf,
    textbookConfigurationTorusObservable_lift g hPg] using hh

end

end MolecularDynamics
