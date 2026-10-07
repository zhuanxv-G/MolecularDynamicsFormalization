import MolecularDynamics.Chapter06.BrownianHilbertCore
import Mathlib.Algebra.Module.Submodule.Equiv

/-! Actual smooth periodic core domain and its same-model Brownian linear operator.
This constructs the domain; density, closure, and self-adjointness remain separate. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace

namespace MolecularDynamics

/-- The actual coordinate Frechet partial is additive on smooth real functions. -/
theorem textbookConfigurationPartial_add {Nc : ℕ}
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (i : Fin Nc) :
    textbookConfigurationPartial (f + g) i =
      textbookConfigurationPartial f i + textbookConfigurationPartial g i := by
  funext q
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).add
    ((hg.differentiable (by simp) q).hasFDerivAt)
  unfold textbookConfigurationPartial
  rw [h.fderiv]
  rfl

/-- The actual coordinate Frechet partial is homogeneous under the real scalar action. -/
theorem textbookConfigurationPartial_smul {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (c : ℝ) (i : Fin Nc) :
    textbookConfigurationPartial (c • f) i = c • textbookConfigurationPartial f i := by
  funext q
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).const_smul c
  unfold textbookConfigurationPartial
  rw [h.fderiv]
  rfl

/-- Additivity of the literal original mass-weighted Brownian generator. -/
theorem textbookBrownianGenerator_add {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g) :
    textbookBrownianGenerator m U β (f + g) =
      textbookBrownianGenerator m U β f + textbookBrownianGenerator m U β g := by
  funext q
  unfold textbookBrownianGenerator
  simp only [Pi.add_apply, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  simp_rw [textbookConfigurationPartial_add f g hf hg i]
  rw [textbookConfigurationPartial_add _ _
    (textbookConfigurationPartial_contDiff f hf i)
    (textbookConfigurationPartial_contDiff g hg i)]
  simp only [Pi.add_apply]
  ring

/-- Homogeneity of the literal original Brownian generator for every actual coordinate mass. -/
theorem textbookBrownianGenerator_smul {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (c : ℝ) :
    textbookBrownianGenerator m U β (c • f) =
      c • textbookBrownianGenerator m U β f := by
  funext q
  unfold textbookBrownianGenerator
  simp only [Pi.smul_apply, smul_eq_mul, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i _
  simp_rw [textbookConfigurationPartial_smul f hf c i]
  rw [textbookConfigurationPartial_smul _ (textbookConfigurationPartial_contDiff f hf i)]
  simp only [Pi.smul_apply, smul_eq_mul]
  ring

/-- The genuine space of all smooth integer-periodic real lifts, not a finite Fourier truncation. -/
def textbookPeriodicSmoothSpace (Nc : ℕ) : Submodule ℝ ((Fin Nc → ℝ) → ℝ) where
  carrier := {f | ContDiff ℝ ∞ f ∧ textbookUnitPeriodicPotential f}
  zero_mem' := ⟨contDiff_const, by intro q n; rfl⟩
  add_mem' := by
    intro f g hf hg
    refine ⟨hf.1.add hg.1, ?_⟩
    intro q n
    change f (q + fun i ↦ (n i : ℝ)) + g (q + fun i ↦ (n i : ℝ)) = f q + g q
    rw [hf.2 q n, hg.2 q n]
  smul_mem' := by
    intro c f hf
    refine ⟨hf.1.const_smul c, ?_⟩
    intro q n
    change c * f (q + fun i ↦ (n i : ℝ)) = c * f q
    rw [hf.2 q n]

/-- Membership really is the original smoothness plus full integer-lattice periodicity. -/
theorem textbookPeriodicSmoothSpace_mem {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ) :
    f ∈ textbookPeriodicSmoothSpace Nc ↔
      ContDiff ℝ ∞ f ∧ textbookUnitPeriodicPotential f :=
  Iff.rfl

/-- The actual Brownian generator is a linear endomorphism of the genuine smooth periodic space. -/
noncomputable def textbookBrownianSmoothGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookPeriodicSmoothSpace Nc →ₗ[ℝ] textbookPeriodicSmoothSpace Nc where
  toFun f := ⟨textbookBrownianGenerator m U β f,
    textbookBrownianGenerator_contDiff m U β f hU f.prop.1,
    textbookBrownianGenerator_periodic m U β f hU f.prop.1 hPU f.prop.2⟩
  map_add' := by
    intro f g
    apply Subtype.ext
    exact textbookBrownianGenerator_add m U β f g f.prop.1 g.prop.1
  map_smul' := by
    intro c f
    apply Subtype.ext
    exact textbookBrownianGenerator_smul m U β f f.prop.1 c

/-- The actual smooth-space generator is the literal original differential expression. -/
theorem textbookBrownianSmoothGenerator_apply {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (f : textbookPeriodicSmoothSpace Nc) :
    (textbookBrownianSmoothGenerator m U hU hPU β f : (Fin Nc → ℝ) → ℝ) =
      textbookBrownianGenerator m U β f :=
  rfl


/-- The same genuine weighted Hilbert embedding is linear on the actual smooth periodic space. -/
noncomputable def textbookPeriodicSmoothEmbedding {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookPeriodicSmoothSpace Nc →ₗ[ℝ] Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) where
  toFun f := textbookConfigurationGibbsL2Observable U hU hPU β f f.prop.1.continuous f.prop.2
  map_add' := by
    intro f g
    apply Lp.ext
    filter_upwards [textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β (f + g)
        (f + g).prop.1.continuous (f + g).prop.2,
      textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f f.prop.1.continuous f.prop.2,
      textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β g g.prop.1.continuous g.prop.2,
      Lp.coeFn_add (textbookConfigurationGibbsL2Observable U hU hPU β f f.prop.1.continuous f.prop.2)
        (textbookConfigurationGibbsL2Observable U hU hPU β g g.prop.1.continuous g.prop.2)]
      with Q hfg hf hg hs
    exact hfg.trans ((show textbookConfigurationTorusObservable
      ((f : (Fin Nc → ℝ) → ℝ) + (g : (Fin Nc → ℝ) → ℝ)) Q =
        textbookConfigurationTorusObservable f Q + textbookConfigurationTorusObservable g Q from rfl).trans
      ((congrArg₂ (fun a b : ℝ ↦ a + b) hf hg).symm.trans hs.symm))
  map_smul' := by
    intro c f
    apply Lp.ext
    filter_upwards [textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β (c • f)
        (c • f).prop.1.continuous (c • f).prop.2,
      textbookConfigurationGibbsL2Observable_ae_eq U hU hPU β f f.prop.1.continuous f.prop.2,
      Lp.coeFn_smul c (textbookConfigurationGibbsL2Observable U hU hPU β f f.prop.1.continuous f.prop.2)]
      with Q hcf hf hs
    exact hcf.trans ((show textbookConfigurationTorusObservable
      (c • (f : (Fin Nc → ℝ) → ℝ)) Q =
        c • textbookConfigurationTorusObservable f Q from rfl).trans
      ((congrArg (fun a : ℝ ↦ c • a) hf).symm.trans hs.symm))

/-- Injectivity of the actual linear Hilbert embedding follows from the already proved full support. -/
theorem textbookPeriodicSmoothEmbedding_injective {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Function.Injective (textbookPeriodicSmoothEmbedding U hU hPU β) := by
  intro f g he
  apply Subtype.ext
  exact textbookConfigurationGibbsL2Observable_injective U hU hPU β f g
    f.prop.1.continuous g.prop.1.continuous f.prop.2 g.prop.2 he

/-- The actual smooth domain in the genuine Gibbs Hilbert space. Density is not assumed. -/
noncomputable def textbookBrownianGibbsSmoothDomain {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Submodule ℝ (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :=
  (textbookPeriodicSmoothEmbedding U hU hPU β).range

/-- Actual unique identification of the smooth periodic lift space with its Hilbert domain. -/
noncomputable def textbookPeriodicSmoothEmbeddingEquiv {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookPeriodicSmoothSpace Nc ≃ₗ[ℝ] textbookBrownianGibbsSmoothDomain U hU hPU β :=
  LinearEquiv.ofInjective (textbookPeriodicSmoothEmbedding U hU hPU β)
    (textbookPeriodicSmoothEmbedding_injective U hU hPU β)

/-- The actual domain equivalence has precisely the same embedded Hilbert vector. -/
theorem textbookPeriodicSmoothEmbeddingEquiv_coe {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β f :
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) =
      textbookPeriodicSmoothEmbedding U hU hPU β f :=
  rfl

/-- Every actual Hilbert domain vector has its true same-model unique smooth lift. -/
theorem textbookPeriodicSmoothEmbeddingEquiv_symm_coe {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (x : textbookBrownianGibbsSmoothDomain U hU hPU β) :
    textbookPeriodicSmoothEmbedding U hU hPU β
      ((textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).symm x) =
      (x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)) :=
  LinearEquiv.ofInjective_symm_apply _ x

/-- The actual linear Brownian operator on its actual smooth Hilbert domain.
Its construction uses proved injectivity, and imposes no boundedness or closure conclusion. -/
noncomputable def textbookBrownianGibbsDomainOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookBrownianGibbsSmoothDomain U hU hPU β →ₗ[ℝ]
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β) :=
  (textbookPeriodicSmoothEmbedding U hU hPU β).comp
    ((textbookBrownianSmoothGenerator m U hU hPU β).comp
      (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).symm.toLinearMap)

/-- The actual Hilbert-domain operator agrees with the literal original generator on every smooth lift. -/
theorem textbookBrownianGibbsDomainOperator_apply_equiv {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookBrownianGibbsDomainOperator m U hU hPU β
      (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β f) =
      textbookBrownianGibbsL2Image m U hU hPU β f f.prop.1 f.prop.2 := by
  unfold textbookBrownianGibbsDomainOperator
  simp only [LinearMap.comp_apply, LinearEquiv.coe_toLinearMap, LinearEquiv.symm_apply_apply]
  rfl

/-- Genuine domain Dirichlet identity in the same Gibbs Hilbert space. -/
theorem textbookBrownianGibbsDomainOperator_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (f g : textbookPeriodicSmoothSpace Nc) :
    ⟪(textbookPeriodicSmoothEmbeddingEquiv U hU hPU β f :
        Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
      textbookBrownianGibbsDomainOperator m U hU hPU β
        (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β g)⟫_ℝ =
      -β⁻¹ * ∫ Q, textbookConfigurationTorusObservable
        (textbookConfigurationGradientPair m f g) Q
          ∂textbookConfigurationTorusGibbsMeasure U β := by
  rw [textbookPeriodicSmoothEmbeddingEquiv_coe, textbookBrownianGibbsDomainOperator_apply_equiv]
  exact textbookBrownianGibbsL2Image_dirichlet m U hU hPU β hβ f g
    f.prop.1 g.prop.1 f.prop.2 g.prop.2

/-- The constructed actual Hilbert-domain operator is symmetric on every pair of domain vectors. -/
theorem textbookBrownianGibbsDomainOperator_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (x y : textbookBrownianGibbsSmoothDomain U hU hPU β) :
    ⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
      textbookBrownianGibbsDomainOperator m U hU hPU β y⟫_ℝ =
    ⟪textbookBrownianGibbsDomainOperator m U hU hPU β x,
      (y : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))⟫_ℝ := by
  obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).surjective x
  obtain ⟨g, rfl⟩ := (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).surjective y
  rw [textbookPeriodicSmoothEmbeddingEquiv_coe, textbookPeriodicSmoothEmbeddingEquiv_coe,
    textbookBrownianGibbsDomainOperator_apply_equiv, textbookBrownianGibbsDomainOperator_apply_equiv]
  exact textbookBrownianGibbsL2Image_symmetric m U hU hPU β hβ f g
    f.prop.1 g.prop.1 f.prop.2 g.prop.2

/-- Actual nonpositive quadratic form on every vector of the constructed Hilbert domain. -/
theorem textbookBrownianGibbsDomainOperator_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    (x : textbookBrownianGibbsSmoothDomain U hU hPU β) :
    ⟪(x : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)),
      textbookBrownianGibbsDomainOperator m U hU hPU β x⟫_ℝ ≤ 0 := by
  obtain ⟨f, rfl⟩ := (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).surjective x
  rw [textbookPeriodicSmoothEmbeddingEquiv_coe, textbookBrownianGibbsDomainOperator_apply_equiv]
  exact textbookBrownianGibbsL2Image_quadratic_nonpos m hm U hU hPU β hβ f
    f.prop.1 f.prop.2

/-- Constants really belong to the complete smooth periodic lift space. -/
def textbookPeriodicSmoothConstant (Nc : ℕ) (c : ℝ) : textbookPeriodicSmoothSpace Nc :=
  ⟨fun _ ↦ c, contDiff_const, by intro _ _; rfl⟩

/-- The actual domain operator has a constant zero mode in its actual domain. -/
theorem textbookBrownianGibbsDomainOperator_const {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β c : ℝ) :
    textbookBrownianGibbsDomainOperator m U hU hPU β
      (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc c)) = 0 := by
  rw [textbookBrownianGibbsDomainOperator_apply_equiv]
  exact textbookBrownianGibbsL2Image_const m U hU hPU β c

/-- The constant-one domain vector has actual ambient Hilbert norm one, so the zero mode is nontrivial. -/
theorem textbookBrownianGibbsSmoothDomain_one_norm {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    ‖(textbookPeriodicSmoothEmbeddingEquiv U hU hPU β (textbookPeriodicSmoothConstant Nc 1) :
      Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))‖ = 1 := by
  rw [textbookPeriodicSmoothEmbeddingEquiv_coe]
  exact textbookConfigurationGibbsL2Observable_one_norm U hU hPU β

end MolecularDynamics
