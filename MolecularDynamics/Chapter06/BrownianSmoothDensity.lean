import MolecularDynamics.Chapter06.BrownianSmoothDomain
import Mathlib.MeasureTheory.Function.ContinuousMapDense
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

/-! Density of the actual full smooth periodic domain in the same genuine Gibbs L² space. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators

namespace MolecularDynamics

/-- Every genuine torus Fourier character has a smooth Euclidean lift. -/
theorem textbookTorusFourier_lift_contDiff {Nc : ℕ} (n : Fin Nc → ℤ) :
    ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
      UnitAddTorus.mFourier n (textbookConfigurationTorusProjection q)) := by
  change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
    ∏ i, fourier (n i) (q i : UnitAddCircle))
  simp only [fourier_coe_apply, Complex.ofReal_one, div_one]
  apply contDiff_prod
  intro i _
  exact (Complex.contDiff_exp (𝕜 := ℝ)).comp
    ((contDiff_const.mul (Complex.ofRealCLM.contDiff.comp (contDiff_apply ℝ ℝ i))))

/-- Actual complex continuous torus functions whose real Euclidean lifts are smooth. -/
def textbookSmoothTorusComplexSpace (Nc : ℕ) :
    Submodule ℂ C(UnitAddTorus (Fin Nc), ℂ) where
  carrier := {f | ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
    f (textbookConfigurationTorusProjection q))}
  zero_mem' := by
    change ContDiff ℝ ∞ (fun _ : Fin Nc → ℝ ↦ (0 : ℂ))
    exact contDiff_const
  add_mem' := by
    intro f g hf hg
    change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ f (textbookConfigurationTorusProjection q)) at hf
    change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ g (textbookConfigurationTorusProjection q)) at hg
    change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
      f (textbookConfigurationTorusProjection q) + g (textbookConfigurationTorusProjection q))
    exact hf.add hg
  smul_mem' := by
    intro c f hf
    change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ f (textbookConfigurationTorusProjection q)) at hf
    change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ c • f (textbookConfigurationTorusProjection q))
    exact hf.const_smul c

/-- The full Fourier span is contained in the actual smooth-lift space. -/
theorem textbookFourierSpan_le_smoothTorusComplex (Nc : ℕ) :
    Submodule.span ℂ (range (UnitAddTorus.mFourier (d := Fin Nc))) ≤
      textbookSmoothTorusComplexSpace Nc := by
  apply Submodule.span_le.mpr
  rintro _ ⟨n, rfl⟩
  exact textbookTorusFourier_lift_contDiff n

/-- Genuine Fourier density gives density of all smooth complex lifts, without truncating the model. -/
theorem textbookSmoothTorusComplexSpace_dense (Nc : ℕ) :
    Dense (textbookSmoothTorusComplexSpace Nc :
      Set C(UnitAddTorus (Fin Nc), ℂ)) := by
  have hd : Dense (Submodule.span ℂ
      (range (UnitAddTorus.mFourier (d := Fin Nc))) :
        Set C(UnitAddTorus (Fin Nc), ℂ)) :=
    Submodule.dense_iff_topologicalClosure_eq_top.mpr
      UnitAddTorus.span_mFourier_closure_eq_top
  exact hd.mono (textbookFourierSpan_le_smoothTorusComplex Nc)

/-- Real parts of actual continuous complex torus functions, as a genuine continuous linear map. -/
noncomputable def textbookTorusContinuousRealPart (Nc : ℕ) :
    C(UnitAddTorus (Fin Nc), ℂ) →L[ℝ] C(UnitAddTorus (Fin Nc), ℝ) :=
  ContinuousLinearMap.compLeftContinuous ℝ (UnitAddTorus (Fin Nc)) Complex.reCLM

/-- The real-part map is truly onto, with complexification as an actual right inverse. -/
theorem textbookTorusContinuousRealPart_surjective (Nc : ℕ) :
    Function.Surjective (textbookTorusContinuousRealPart Nc) := by
  intro f
  refine ⟨ContinuousLinearMap.compLeftContinuous ℝ (UnitAddTorus (Fin Nc)) Complex.ofRealCLM f, ?_⟩
  ext Q
  exact Complex.ofReal_re (f Q)

/-- All real continuous torus functions with smooth Euclidean lift form a genuinely dense set. -/
theorem textbookSmoothTorusReal_dense (Nc : ℕ) :
    Dense {f : C(UnitAddTorus (Fin Nc), ℝ) |
      ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
        f (textbookConfigurationTorusProjection q))} := by
  apply (textbookTorusContinuousRealPart_surjective Nc).denseRange.dense_of_mapsTo
    (textbookTorusContinuousRealPart Nc).continuous
    (textbookSmoothTorusComplexSpace_dense Nc)
  intro f hf
  change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ f (textbookConfigurationTorusProjection q)) at hf
  change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ (f (textbookConfigurationTorusProjection q)).re)
  exact Complex.reCLM.contDiff.comp hf

/-- Integer coordinate translations really leave the original quotient projection unchanged. -/
theorem textbookConfigurationTorusProjection_integer_translate {Nc : ℕ}
    (q : Fin Nc → ℝ) (n : Fin Nc → ℤ) :
    textbookConfigurationTorusProjection (q + fun i ↦ (n i : ℝ)) =
      textbookConfigurationTorusProjection q := by
  ext i
  change ((q i + (n i : ℝ) : ℝ) : UnitAddCircle) = (q i : UnitAddCircle)
  rw [AddCircle.coe_add]
  have hn : (((n i : ℝ) : UnitAddCircle)) = 0 :=
    (AddCircle.coe_eq_zero_iff (1 : ℝ)).mpr
      ⟨n i, by simp [zsmul_eq_mul]⟩
  rw [hn, add_zero]

/-- Every actual smooth-lift real torus function defines a member of the full periodic smooth space. -/
def textbookSmoothTorusRealLift {Nc : ℕ} (f : C(UnitAddTorus (Fin Nc), ℝ))
    (hf : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
      f (textbookConfigurationTorusProjection q))) : textbookPeriodicSmoothSpace Nc :=
  ⟨fun q ↦ f (textbookConfigurationTorusProjection q), hf,
    by
      intro q n
      change f (textbookConfigurationTorusProjection (q + fun i ↦ (n i : ℝ))) =
        f (textbookConfigurationTorusProjection q)
      rw [textbookConfigurationTorusProjection_integer_translate]⟩

/-- The actual lift descends to the same original torus function, using the genuine representative. -/
theorem textbookSmoothTorusRealLift_observable {Nc : ℕ} (f : C(UnitAddTorus (Fin Nc), ℝ))
    (hf : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
      f (textbookConfigurationTorusProjection q))) :
    textbookConfigurationTorusObservable (textbookSmoothTorusRealLift f hf) = f := by
  funext Q
  change f (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative Q)) = f Q
  rw [textbookConfigurationTorusRepresentative_projects]

/-- The actual continuous-function map into the same Gibbs L²; finite mass is derived. -/
noncomputable def textbookGibbsContinuousToLp {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    C(UnitAddTorus (Fin Nc), ℝ) →L[ℝ] Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  exact ContinuousMap.toLp 2 (textbookConfigurationTorusGibbsMeasure U β) ℝ

/-- The actual continuous-to-L² map represents the same continuous function almost everywhere. -/
theorem textbookGibbsContinuousToLp_ae_eq {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : C(UnitAddTorus (Fin Nc), ℝ)) :
    (textbookGibbsContinuousToLp U hU hPU β f : UnitAddTorus (Fin Nc) → ℝ)
      =ᵐ[textbookConfigurationTorusGibbsMeasure U β] f := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  exact ContinuousMap.coeFn_toLp (textbookConfigurationTorusGibbsMeasure U β) f

/-- Continuous real functions truly have dense range in the same actual Gibbs L². -/
theorem textbookGibbsContinuousToLp_denseRange {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    DenseRange (textbookGibbsContinuousToLp U hU hPU β) := by
  have := textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hPU β
  exact ContinuousMap.toLp_denseRange ℝ (textbookConfigurationTorusGibbsMeasure U β) ℝ
    (by norm_num)

/-- The same actual continuous L² vector is the full smooth-domain embedding of its real lift. -/
theorem textbookSmoothTorusRealLift_toLp {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : C(UnitAddTorus (Fin Nc), ℝ))
    (hf : ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦
      f (textbookConfigurationTorusProjection q))) :
    textbookGibbsContinuousToLp U hU hPU β f =
      textbookPeriodicSmoothEmbedding U hU hPU β (textbookSmoothTorusRealLift f hf) := by
  apply Lp.ext
  filter_upwards [textbookGibbsContinuousToLp_ae_eq U hU hPU β f,
    textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β (textbookSmoothTorusRealLift f hf)
      (textbookSmoothTorusRealLift f hf).prop.1.continuous
      (textbookSmoothTorusRealLift f hf).prop.2] with Q hC hE
  exact hC.trans ((congrFun (textbookSmoothTorusRealLift_observable f hf) Q).symm.trans hE.symm)

/-- The genuine full smooth periodic domain is dense in the actual Gibbs Hilbert space. -/
theorem textbookBrownianGibbsSmoothDomain_dense {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Dense (textbookBrownianGibbsSmoothDomain U hU hPU β :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))) := by
  apply (textbookGibbsContinuousToLp_denseRange U hU hPU β).dense_of_mapsTo
    (textbookGibbsContinuousToLp U hU hPU β).continuous (textbookSmoothTorusReal_dense Nc)
  intro f hf
  change ContDiff ℝ ∞ (fun q : Fin Nc → ℝ ↦ f (textbookConfigurationTorusProjection q)) at hf
  change ∃ g, textbookPeriodicSmoothEmbedding U hU hPU β g =
    textbookGibbsContinuousToLp U hU hPU β f
  exact ⟨textbookSmoothTorusRealLift f hf, (textbookSmoothTorusRealLift_toLp U hU hPU β f hf).symm⟩

/-- The actual smooth Hilbert domain has full topological closure, with no density premise. -/
theorem textbookBrownianGibbsSmoothDomain_closure_eq_top {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (textbookBrownianGibbsSmoothDomain U hU hPU β).topologicalClosure = ⊤ :=
  Submodule.dense_iff_topologicalClosure_eq_top.mp
    (textbookBrownianGibbsSmoothDomain_dense U hU hPU β)

end MolecularDynamics
