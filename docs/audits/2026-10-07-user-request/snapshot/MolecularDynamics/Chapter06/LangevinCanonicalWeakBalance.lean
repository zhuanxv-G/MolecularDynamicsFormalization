import MolecularDynamics.Chapter06.LangevinCanonicalPositionIBP
import MolecularDynamics.Chapter06.LangevinC2OperatorSupport

/-! Full-phase weak canonical balance for the original smooth unit-periodic
unit-mass Langevin operator on genuine compact phase tests. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ZeroAtInfty BigOperators
namespace MolecularDynamics
noncomputable section

local instance weakCanonicalUnitAddCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance weakCanonicalUnitAddCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance weakCanonicalUnitAddCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private theorem weak_projection_shift {N : ℕ} (z : textbookLangevinPhase N)
    (n : Fin N → ℤ) :
    textbookLangevinPeriodicProjection (z + ((fun i ↦ (n i : ℝ)), 0)) =
      textbookLangevinPeriodicProjection z := by
  apply Prod.ext
  · funext i
    change ((z.1 i + (n i : ℝ) : ℝ) : UnitAddCircle) = (z.1 i : UnitAddCircle)
    have hn : ((n i : ℝ) : UnitAddCircle) = 0 :=
      (AddCircle.coe_eq_zero_iff (1 : ℝ)).mpr ⟨n i, by simp [zsmul_eq_mul]⟩
    rw [AddCircle.coe_add, hn, add_zero]
  · exact add_zero _

private theorem weak_derivative_shift {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (z : textbookLangevinPhase N)
    (n : Fin N → ℤ) :
    fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) (z + ((fun i ↦ (n i : ℝ)), 0)) =
      fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z := by
  have he : (fun w ↦ (F ∘ textbookLangevinPeriodicProjection)
      (w + ((fun i ↦ (n i : ℝ)), 0))) = F ∘ textbookLangevinPeriodicProjection :=
    funext (fun w ↦ congrArg F (weak_projection_shift w n))
  rw [← fderiv_comp_add_right ((fun i ↦ (n i : ℝ)), 0), he]

/-- The true descended constant directional derivative of the actual real lift,
using a genuine measurable configuration representative. -/
def textbookLangevinPeriodicDirectionalDerivative {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (v : textbookLangevinPhase N)
    (x : textbookLangevinPeriodicPhase N) : ℝ :=
  fderiv ℝ (F ∘ textbookLangevinPeriodicProjection)
    (textbookConfigurationTorusRepresentative x.1, x.2) v

/-- Integer periodicity makes the actual derivative independent of every
real representative; no derivative descent is assumed. -/
theorem textbookLangevinPeriodicDirectionalDerivative_lift {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (v z : textbookLangevinPhase N) :
    textbookLangevinPeriodicDirectionalDerivative F v (textbookLangevinPeriodicProjection z) =
      fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z v := by
  let Q := textbookConfigurationTorusProjection z.1
  let r := textbookConfigurationTorusRepresentative Q
  have hi (i : Fin N) : ∃ n : ℤ, (n : ℝ) = r i - z.1 i := by
    have hz : ((r i - z.1 i : ℝ) : UnitAddCircle) = 0 := by
      rw [AddCircle.coe_sub]
      have he := congrFun (textbookConfigurationTorusRepresentative_projects Q) i
      change (r i : UnitAddCircle) = (z.1 i : UnitAddCircle) at he
      rw [he, sub_self]
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp hz
    exact ⟨n, by simpa only [zsmul_eq_mul, mul_one] using hn⟩
  choose n hn using hi
  have he : z + ((fun i ↦ (n i : ℝ)), 0) = (r, z.2) := by
    apply Prod.ext
    · funext i
      change z.1 i + (n i : ℝ) = r i
      rw [hn i]
      ring
    · exact add_zero _
  have hd := weak_derivative_shift F z n
  rw [he] at hd
  exact congrArg (fun A : textbookLangevinPhase N →L[ℝ] ℝ ↦ A v) hd

/-- A smooth actual periodic lift gives a smooth lift of its actual
descended derivative. -/
theorem textbookLangevinPeriodicDirectionalDerivative_lift_contDiff {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (v : textbookLangevinPhase N) :
    ContDiff ℝ ∞ (textbookLangevinPeriodicDirectionalDerivative F v ∘ textbookLangevinPeriodicProjection) := by
  have he : textbookLangevinPeriodicDirectionalDerivative F v ∘ textbookLangevinPeriodicProjection =
      fun z ↦ fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z v :=
    funext (fun z ↦ textbookLangevinPeriodicDirectionalDerivative_lift F v z)
  rw [he]
  exact (hG.fderiv_right (by simp)).clm_apply contDiff_const

/-- Continuity descends through the actual open quotient, without requiring
a continuous choice of real representatives. -/
theorem textbookLangevinPeriodicDirectionalDerivative_continuous {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (v : textbookLangevinPhase N) :
    Continuous (textbookLangevinPeriodicDirectionalDerivative F v) :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr
    (textbookLangevinPeriodicDirectionalDerivative_lift_contDiff F hG v).continuous

/-- The genuine descended derivative cannot gain topological support
outside the original actual phase test. -/
theorem textbookLangevinPeriodicDirectionalDerivative_tsupport_subset {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (v : textbookLangevinPhase N) :
    tsupport (textbookLangevinPeriodicDirectionalDerivative F v) ⊆ tsupport F := by
  apply closure_minimal _ isClosed_closure
  intro x hx
  by_contra hxs
  let z : textbookLangevinPhase N := (textbookConfigurationTorusRepresentative x.1, x.2)
  have hz : textbookLangevinPeriodicProjection z = x := by
    apply Prod.ext
    · exact textbookConfigurationTorusRepresentative_projects x.1
    · rfl
  have hg : z ∉ tsupport (F ∘ textbookLangevinPeriodicProjection) := by
    intro hzg
    have h := tsupport_comp_subset_preimage F
      (textbookLangevinPeriodicProjection_continuous N) hzg
    change textbookLangevinPeriodicProjection z ∈ tsupport F at h
    rw [hz] at h
    exact hxs h
  have hd : fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z = 0 := by
    by_contra h
    exact hg (support_fderiv_subset ℝ h)
  have hzero : textbookLangevinPeriodicDirectionalDerivative F v x = 0 := by
    change fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z v = 0
    rw [hd]
    rfl
  exact hx hzero

/-- Genuine compact phase support is preserved by actual differentiation. -/
theorem textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hs : HasCompactSupport F)
    (v : textbookLangevinPhase N) :
    HasCompactSupport (textbookLangevinPeriodicDirectionalDerivative F v) :=
  hs.of_isClosed_subset isClosed_closure
    (textbookLangevinPeriodicDirectionalDerivative_tsupport_subset F v)

private theorem weak_slice_compact {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hs : HasCompactSupport F)
    (Q : UnitAddTorus (Fin N)) :
    HasCompactSupport (fun p : Fin N → ℝ ↦ F (Q, p)) := by
  have hK : IsCompact (Prod.snd '' tsupport F) := hs.isCompact.image continuous_snd
  apply hK.of_isClosed_subset isClosed_closure
  apply closure_minimal _ hK.isClosed
  intro p hp
  exact ⟨(Q, p), subset_closure hp, rfl⟩

private theorem weak_slice_q_derivative {N : ℕ}
    (g : textbookLangevinPhase N → ℝ) (hg : ContDiff ℝ ∞ g)
    (q p v : Fin N → ℝ) :
    fderiv ℝ (fun y ↦ g (y, p)) q v = fderiv ℝ g (q, p) (v, 0) := by
  have hi : HasFDerivAt (fun y : Fin N → ℝ ↦ (y, p))
      ((ContinuousLinearMap.id ℝ (Fin N → ℝ)).prod 0) q := by
    simpa only [id_eq] using! (hasFDerivAt_id (𝕜 := ℝ) q).prodMk (hasFDerivAt_const p q)
  have h : HasFDerivAt (fun y ↦ g (y, p))
      ((fderiv ℝ g (q, p)).comp ((ContinuousLinearMap.id ℝ (Fin N → ℝ)).prod 0)) q := by
    simpa only [Function.comp_def] using! (hg.differentiable (by simp) (q, p)).hasFDerivAt.comp q hi
  rw [h.fderiv]
  rfl

private theorem weak_slice_p_derivative {N : ℕ}
    (g : textbookLangevinPhase N → ℝ) (hg : ContDiff ℝ ∞ g)
    (q p v : Fin N → ℝ) :
    fderiv ℝ (fun y ↦ g (q, y)) p v = fderiv ℝ g (q, p) (0, v) := by
  have hi : HasFDerivAt (fun y : Fin N → ℝ ↦ (q, y))
      ((0 : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)).prod (ContinuousLinearMap.id ℝ (Fin N → ℝ))) p := by
    simpa only [id_eq] using! (hasFDerivAt_const q p).prodMk (hasFDerivAt_id (𝕜 := ℝ) p)
  have h : HasFDerivAt (fun y ↦ g (q, y))
      ((fderiv ℝ g (q, p)).comp
        ((0 : (Fin N → ℝ) →L[ℝ] (Fin N → ℝ)).prod (ContinuousLinearMap.id ℝ (Fin N → ℝ)))) p := by
    simpa only [Function.comp_def] using! (hg.differentiable (by simp) (q, p)).hasFDerivAt.comp p hi
  rw [h.fderiv]
  rfl

private theorem weak_rep {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (Q : UnitAddTorus (Fin N)) (p : Fin N → ℝ) :
    (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) = F (Q, p) := by
  change F (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative Q), p) = _
  rw [textbookConfigurationTorusRepresentative_projects]

private theorem weak_p_partial {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (Q : UnitAddTorus (Fin N)) (p v : Fin N → ℝ) :
    fderiv ℝ (fun y ↦ F (Q, y)) p v =
      textbookLangevinPeriodicDirectionalDerivative F (0, v) (Q, p) := by
  have he : (fun y ↦ F (Q, y)) =
      fun y ↦ (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, y) :=
    funext (fun y ↦ (weak_rep F Q y).symm)
  rw [he]
  exact weak_slice_p_derivative _ hG _ p v

private theorem weak_U_partial_continuous {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (i : Fin N) :
    Continuous (fun x : textbookLangevinPeriodicPhase N ↦
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1) := by
  apply (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr
  have he : (fun x : textbookLangevinPeriodicPhase N ↦
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1) ∘
        textbookLangevinPeriodicProjection = fun z ↦ textbookConfigurationPartial U i z.1 := by
    funext z
    exact textbookConfigurationTorusObservable_lift _ (textbookConfigurationPartial_periodic U hU hp i) z.1
  rw [he]
  exact (textbookConfigurationPartial_contDiff U hU i).continuous.comp continuous_fst

/-- True joint Fubini and the actual configurational Gibbs integration by
parts give the full-phase position transport identity for every genuine
compact smooth phase test, without separability of the test. -/
theorem textbookLangevinCanonicalMeasure_position_integrationByParts {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (i : Fin N) :
    (∫ x, x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
      β * ∫ x, x.2 i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  have hcP : Continuous (fun x : textbookLangevinPeriodicPhase N ↦ x.2 i) :=
    (continuous_apply i).comp continuous_snd
  have hi1 : Integrable (fun x ↦ x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (hcP.mul (textbookLangevinPeriodicDirectionalDerivative_continuous F hG _)).integrable_of_hasCompactSupport
      (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _).mul_left
  have hi2 : Integrable (fun x ↦ x.2 i *
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((hcP.mul (weak_U_partial_continuous U hU hp i)).mul hFc).integrable_of_hasCompactSupport hs.mul_left
  have he (p : Fin N → ℝ) :
      (∫ Q, p i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) (Q, p)
        ∂textbookConfigurationTorusGibbsMeasure U β) =
      β * ∫ Q, p i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p)
        ∂textbookConfigurationTorusGibbsMeasure U β := by
    let f := fun q : Fin N → ℝ ↦ (F ∘ textbookLangevinPeriodicProjection) (q, p)
    have hf : ContDiff ℝ ∞ f := hG.comp (contDiff_id.prodMk contDiff_const)
    have hpf : textbookUnitPeriodicPotential f := by
      intro q n
      simpa only [f, Function.comp_apply, Prod.mk_add_mk, add_zero] using congrArg F (weak_projection_shift (q, p) n)
    have hb := textbookConfigurationTorusGibbsMeasure_integrationByParts U f hU hf hp hpf β i
    have hL : textbookConfigurationTorusObservable (textbookConfigurationPartial f i) =
        fun Q ↦ textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) (Q, p) := by
      funext Q
      exact weak_slice_q_derivative _ hG _ p _
    have hR : textbookConfigurationTorusObservable (fun q ↦ textbookConfigurationPartial U i q * f q) =
        fun Q ↦ textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p) := by
      funext Q
      change textbookConfigurationPartial U i (textbookConfigurationTorusRepresentative Q) *
        (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) = _
      rw [weak_rep]
      rfl
    rw [hL, hR] at hb
    rw [integral_const_mul, hb]
    rw [show (fun Q ↦ p i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p)) =
      (fun Q ↦ p i * (textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p))) by
        funext Q; ring, integral_const_mul]
    ring
  change (∫ x, x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x
      ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)) = _
  rw [integral_prod_symm _ hi1]
  change _ = β * ∫ x, x.2 i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x
    ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)
  rw [integral_prod_symm _ hi2]
  simp_rw [he, integral_const_mul]

/-- The same actual joint canonical probability satisfies the force-weighted
momentum integration by parts; all joint integrability is derived from
actual smoothness and compact phase support. -/
theorem textbookLangevinCanonicalMeasure_momentum_integrationByParts {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (i : Fin N) :
    (∫ x, textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
      β * ∫ x, x.2 i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hFc : Continuous F :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  have hcP : Continuous (fun x : textbookLangevinPeriodicPhase N ↦ x.2 i) :=
    (continuous_apply i).comp continuous_snd
  have hi1 : Integrable (fun x ↦ textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((weak_U_partial_continuous U hU hp i).mul
      (textbookLangevinPeriodicDirectionalDerivative_continuous F hG _)).integrable_of_hasCompactSupport
        (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _).mul_left
  have hi2 : Integrable (fun x ↦ x.2 i *
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((hcP.mul (weak_U_partial_continuous U hU hp i)).mul hFc).integrable_of_hasCompactSupport hs.mul_left
  have he (Q : UnitAddTorus (Fin N)) :
      (∫ p, textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q *
        textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) (Q, p)
        ∂textbookLangevinCanonicalMomentumMeasure N β hβ) =
      β * ∫ p, p i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p)
        ∂textbookLangevinCanonicalMomentumMeasure N β hβ := by
    have hf : ContDiff ℝ ∞ (fun p : Fin N → ℝ ↦ F (Q, p)) := by
      have heF : (fun p ↦ F (Q, p)) =
        fun p ↦ (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) :=
          funext (fun p ↦ (weak_rep F Q p).symm)
      rw [heF]
      exact hG.comp (contDiff_const.prodMk contDiff_id)
    have hb := textbookLangevinCanonicalMomentumMeasure_integrationByParts N β hβ (fun p ↦ F (Q, p))
      (hf.of_le (by simp)) (weak_slice_compact F hs Q) i
    simp_rw [weak_p_partial F hG Q] at hb
    rw [integral_const_mul, hb]
    have heR : (fun p ↦ p i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p)) =
        (fun p ↦ textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * (p i * F (Q, p))) := by
      funext p
      ring
    rw [heR, integral_const_mul]
    ring
  change (∫ x, textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
      textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
      ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)) = _
  rw [integral_prod _ hi1]
  change _ = β * ∫ x, x.2 i * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x
    ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)
  rw [integral_prod _ hi2]
  simp_rw [he, integral_const_mul]

/-- Genuine compact momentum slices and true joint Fubini extend the
Gaussian weak Ornstein-Uhlenbeck cancellation to every smooth compact
phase test under the actual full canonical probability. -/
theorem textbookLangevinCanonicalMeasure_ou_weak_balance {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x, γ * ∑ i : Fin N, (β⁻¹ *
      textbookLangevinPeriodicDirectionalDerivative
        (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)) (0, Pi.single i 1) x -
      x.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  let D (i : Fin N) := textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)
  have hD (i : Fin N) := textbookLangevinPeriodicDirectionalDerivative_lift_contDiff F hG (0, Pi.single i 1)
  have hsD (i : Fin N) := textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs (0, Pi.single i 1)
  have hi (i : Fin N) : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
      β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (0, Pi.single i 1) x -
        x.2 i * D i x) (textbookLangevinCanonicalMeasure U β hβ) := by
    have hi1 : Integrable (fun x ↦ β⁻¹ *
        textbookLangevinPeriodicDirectionalDerivative (D i) (0, Pi.single i 1) x)
        (textbookLangevinCanonicalMeasure U β hβ) :=
      (textbookLangevinPeriodicDirectionalDerivative_continuous (D i) (hD i) _).const_mul β⁻¹
        |>.integrable_of_hasCompactSupport
          (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport (D i) (hsD i) _).mul_left
    have hi2 : Integrable (fun x : textbookLangevinPeriodicPhase N ↦ x.2 i * D i x)
        (textbookLangevinCanonicalMeasure U β hβ) :=
      (((continuous_apply i).comp continuous_snd).mul
        (textbookLangevinPeriodicDirectionalDerivative_continuous F hG _)).integrable_of_hasCompactSupport (hsD i).mul_left
    simpa only [Pi.sub_apply] using! hi1.sub hi2
  have hiO : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
      γ * ∑ i : Fin N, (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (0, Pi.single i 1) x -
        x.2 i * D i x)) (textbookLangevinCanonicalMeasure U β hβ) :=
    (integrable_finsetSum Finset.univ (fun i _ ↦ hi i)).const_mul γ
  have he (Q : UnitAddTorus (Fin N)) :
      (∫ p, γ * ∑ i : Fin N,
        (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (0, Pi.single i 1) (Q, p) -
          p i * D i (Q, p)) ∂textbookLangevinCanonicalMomentumMeasure N β hβ) = 0 := by
    have hf : ContDiff ℝ ∞ (fun p : Fin N → ℝ ↦ F (Q, p)) := by
      have heF : (fun p ↦ F (Q, p)) =
        fun p ↦ (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) :=
          funext (fun p ↦ (weak_rep F Q p).symm)
      rw [heF]
      exact hG.comp (contDiff_const.prodMk contDiff_id)
    have hb := textbookLangevinCanonicalMomentumMeasure_ou_weak_balance N β γ hβ
      (fun p ↦ F (Q, p)) (hf.of_le (by simp)) (weak_slice_compact F hs Q)
    unfold textbookLangevinMomentumOrnsteinUhlenbeckOperator at hb
    simp_rw [weak_p_partial F hG Q] at hb
    change (∫ p, γ * ∑ i : Fin N,
      (β⁻¹ * fderiv ℝ (fun q ↦ D i (Q, q)) p (Pi.single i 1) -
        p i * D i (Q, p)) ∂textbookLangevinCanonicalMomentumMeasure N β hβ) = 0 at hb
    simp_rw [weak_p_partial (D _) (hD _) Q] at hb
    exact hb
  change (∫ x, γ * ∑ i : Fin N,
    (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative (D i) (0, Pi.single i 1) x - x.2 i * D i x)
      ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)) = 0
  rw [integral_prod _ hiO]
  simp_rw [he]
  exact integral_zero _ _

private theorem weak_linear_basis {N : ℕ}
    (A : textbookLangevinPhase N →L[ℝ] ℝ) (q p : Fin N → ℝ) :
    A (q, p) =
      (∑ i : Fin N, q i * A (Pi.single i 1, 0)) +
      ∑ i : Fin N, p i * A (0, Pi.single i 1) := by
  classical
  have hq : (∑ i : Fin N, q i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) = (q, 0) := by
    apply Prod.ext
    · rw [Prod.fst_sum]
      change (∑ i : Fin N, q i • Pi.single i 1) = q
      exact (pi_eq_sum_univ' q).symm
    · rw [Prod.snd_sum]
      simp
  have hp : (∑ i : Fin N, p i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ))) = (0, p) := by
    apply Prod.ext
    · rw [Prod.fst_sum]
      simp
    · rw [Prod.snd_sum]
      change (∑ i : Fin N, p i • Pi.single i 1) = p
      exact (pi_eq_sum_univ' p).symm
  have he : (q, p) = (∑ i : Fin N, q i • ((Pi.single i 1 : Fin N → ℝ), (0 : Fin N → ℝ))) +
      ∑ i : Fin N, p i • ((0 : Fin N → ℝ), (Pi.single i 1 : Fin N → ℝ)) := by
    rw [hq, hp]
    simp only [Prod.mk_add_mk, add_zero, zero_add]
  rw [he, map_add, map_sum, map_sum]
  simp only [map_smul, smul_eq_mul]

private theorem weak_D_twice {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (v z : textbookLangevinPhase N) :
    textbookLangevinPeriodicDirectionalDerivative (textbookLangevinPeriodicDirectionalDerivative F v) v
        (textbookLangevinPeriodicProjection z) =
      iteratedFDeriv ℝ 2 (F ∘ textbookLangevinPeriodicProjection) z (fun _ ↦ v) := by
  rw [textbookLangevinPeriodicDirectionalDerivative_lift]
  have he : textbookLangevinPeriodicDirectionalDerivative F v ∘ textbookLangevinPeriodicProjection =
      fun y ↦ fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) y v :=
    funext (fun y ↦ textbookLangevinPeriodicDirectionalDerivative_lift F v y)
  rw [he, iteratedFDeriv_two_apply]
  have hDG : ContDiff ℝ ∞ (fderiv ℝ (F ∘ textbookLangevinPeriodicProjection)) := hG.fderiv_right (by simp)
  rw [fderiv_clm_apply (hDG.differentiable (by simp) z) (differentiableAt_const v)]
  simp

/-- The original actual periodic Langevin differential expression splits
exactly into Hamiltonian position-force transport and physical momentum OU
terms. The split is derived from true first and second derivatives. -/
theorem textbookLangevinPeriodicDifferentialOperator_canonical_split {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (_hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (x : textbookLangevinPeriodicPhase N) :
    textbookLangevinPeriodicDifferentialOperator U γ σ F x =
      (∑ i : Fin N, (x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x -
        textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
          textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)) +
      γ * ∑ i : Fin N, (β⁻¹ *
        textbookLangevinPeriodicDirectionalDerivative
          (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)) (0, Pi.single i 1) x -
        x.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x) := by
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  rw [textbookLangevinPeriodicDifferentialOperator_C2_lift U hU hp γ σ F (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)),
    textbookLangevinDifferentialOperator_C2_frechet U γ σ _ (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp))]
  simp_rw [weak_D_twice F hG, textbookLangevinPeriodicDirectionalDerivative_lift]
  have heU (i : Fin N) :
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i)
          (textbookLangevinPeriodicProjection z).1 = textbookConfigurationPartial U i z.1 :=
    textbookConfigurationTorusObservable_lift _ (textbookConfigurationPartial_periodic U hU hp i) z.1
  simp_rw [heU]
  have heσ : σ ^ 2 / 2 = γ * β⁻¹ := by rw [hσ]; ring
  rw [heσ]
  change fderiv ℝ (F ∘ textbookLangevinPeriodicProjection) z
      (z.2, textbookPotentialForce U z.1 - γ • z.2) + _ = _
  rw [weak_linear_basis]
  dsimp only [textbookLangevinPeriodicProjection]
  simp only [textbookPotentialForce, textbookConfigurationPartial, Pi.sub_apply, Pi.smul_apply, smul_eq_mul]
  simp only [sub_mul, neg_mul, mul_assoc, Finset.sum_sub_distrib,
    Finset.sum_neg_distrib, ← Finset.mul_sum]
  ring

/-- The full original Langevin differential expression has zero actual
canonical expectation on every genuinely compact smooth phase test.
Position-force and OU cancellations use proved joint integrability and
true Fubini, with no invariant-law or weak-balance hypothesis. -/
theorem textbookLangevinCanonicalMeasure_weak_balance {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x, textbookLangevinPeriodicDifferentialOperator U γ σ F x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  let H (i : Fin N) := fun x : textbookLangevinPeriodicPhase N ↦
    x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x -
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
        textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
  let O := fun x : textbookLangevinPeriodicPhase N ↦ γ * ∑ i : Fin N,
    (β⁻¹ * textbookLangevinPeriodicDirectionalDerivative
      (textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1)) (0, Pi.single i 1) x -
    x.2 i * textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)
  have hiH (i : Fin N) : Integrable (H i) (textbookLangevinCanonicalMeasure U β hβ) := by
    have hi1 : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
        x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x)
        (textbookLangevinCanonicalMeasure U β hβ) :=
      (((continuous_apply i).comp continuous_snd).mul
        (textbookLangevinPeriodicDirectionalDerivative_continuous F hG _)).integrable_of_hasCompactSupport
          (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _).mul_left
    have hi2 : Integrable (fun x ↦
        textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
          textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)
        (textbookLangevinCanonicalMeasure U β hβ) :=
      ((weak_U_partial_continuous U hU hp i).mul
        (textbookLangevinPeriodicDirectionalDerivative_continuous F hG _)).integrable_of_hasCompactSupport
          (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _).mul_left
    exact hi1.sub hi2
  have hzH (i : Fin N) : (∫ x, H i x ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
    have hc1 := (((continuous_apply i).comp continuous_snd).mul
      (textbookLangevinPeriodicDirectionalDerivative_continuous F hG (Pi.single i 1, 0)))
    have hc2 := (weak_U_partial_continuous U hU hp i).mul
      (textbookLangevinPeriodicDirectionalDerivative_continuous F hG (0, Pi.single i 1))
    have hi1 : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
        x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x)
        (textbookLangevinCanonicalMeasure U β hβ) := by
      simpa only [Function.comp_apply, Pi.mul_apply] using!
        hc1.integrable_of_hasCompactSupport
          (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _).mul_left
    have hi2 : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
        textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
          textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x)
        (textbookLangevinCanonicalMeasure U β hβ) := by
      simpa only [Pi.mul_apply] using! hc2.integrable_of_hasCompactSupport
        (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _).mul_left
    change (∫ x, x.2 i * textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x -
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 *
        textbookLangevinPeriodicDirectionalDerivative F (0, Pi.single i 1) x
        ∂textbookLangevinCanonicalMeasure U β hβ) = 0
    rw [integral_sub hi1 hi2,
      textbookLangevinCanonicalMeasure_position_integrationByParts U hU hp β hβ F hG hs i,
      textbookLangevinCanonicalMeasure_momentum_integrationByParts U hU hp β hβ F hG hs i, sub_self]
  have hiHS : Integrable (fun x ↦ ∑ i : Fin N, H i x) (textbookLangevinCanonicalMeasure U β hβ) :=
    integrable_finsetSum Finset.univ (fun i _ ↦ hiH i)
  have hiL : Integrable (textbookLangevinPeriodicDifferentialOperator U γ σ F)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (textbookLangevinPeriodicDifferentialOperator_C2_continuous U hU hp γ σ F (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp))).integrable_of_hasCompactSupport
      (textbookLangevinPeriodicDifferentialOperator_compactC2_hasCompactSupport U γ σ F (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs)
  have heL (x) : textbookLangevinPeriodicDifferentialOperator U γ σ F x = (∑ i : Fin N, H i x) + O x :=
    textbookLangevinPeriodicDifferentialOperator_canonical_split U hU hp β γ σ hβ hσ F hG x
  have hiO : Integrable O (textbookLangevinCanonicalMeasure U β hβ) := by
    apply (hiL.sub hiHS).congr
    filter_upwards [] with x
    change textbookLangevinPeriodicDifferentialOperator U γ σ F x - (∑ i : Fin N, H i x) = O x
    rw [heL]
    ring
  have hzO : (∫ x, O x ∂textbookLangevinCanonicalMeasure U β hβ) = 0 :=
    textbookLangevinCanonicalMeasure_ou_weak_balance U hU hp β γ hβ F hG hs
  calc
    _ = ∫ x, (∑ i : Fin N, H i x) + O x ∂textbookLangevinCanonicalMeasure U β hβ :=
      integral_congr_ae (Eventually.of_forall heL)
    _ = (∑ i : Fin N, ∫ x, H i x ∂textbookLangevinCanonicalMeasure U β hβ) +
        ∫ x, O x ∂textbookLangevinCanonicalMeasure U β hβ := by
      rw [integral_add hiHS hiO, integral_finsetSum _ (fun i _ ↦ hiH i)]
    _ = 0 := by simp_rw [hzH, hzO]; simp

/-- The original positive physical noise supplies the fluctuation-dissipation
relation for the actual full canonical weak balance. This is infinitesimal
balance, not an assertion of transition-kernel Gibbs invariance. -/
theorem textbookLangevinCanonicalMeasure_physical_weak_balance {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x, textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹)) F x
      ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  apply textbookLangevinCanonicalMeasure_weak_balance U hU hp β γ _ hβ _ F hG hs
  simpa only [div_eq_mul_inv] using
    Real.sq_sqrt (mul_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hγ.le) (inv_nonneg.mpr hβ.le))

/-- The actual closed C0 generator, on each genuine compact smooth phase
test in its proved domain, has zero actual canonical expectation.
No graph-core or transition-invariance conclusion is included. -/
theorem textbookLangevinCanonicalMeasure_C0_generator_weak_balance
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (F : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F) :
    (∫ x,
      (textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ
        ⟨textbookLangevinPeriodicCompactC2Observable F (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs,
          textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hF γ σ hγ F
            (hG.of_le (show (2 : ℕ∞ω) ≤ (∞ : ℕ∞ω) by simp)) hs⟩) x ∂textbookLangevinCanonicalMeasure U β hβ) = 0 := by
  rw [textbookLangevinPeriodicC0Generator_compactC2_apply]
  exact textbookLangevinCanonicalMeasure_weak_balance U hU hp β γ σ hβ hσ F hG hs

end
end MolecularDynamics
