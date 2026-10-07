import MolecularDynamics.Chapter06.LangevinCanonicalHilbertGraph

/-! Genuine canonical coordinate weak derivative testing and closability.
These supply the necessary derivative stage for the original weighted H1 norm.
The full H1 domain, norm density and Poisson solvability are not asserted. -/
open Set Filter MeasureTheory
open scoped Topology ContDiff NNReal ENNReal BigOperators InnerProductSpace
namespace MolecularDynamics
noncomputable section

local instance coordinateUnitAddCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance coordinateUnitAddCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance coordinateUnitAddCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual position and momentum coordinate directions in the original phase lift. -/
def textbookLangevinCanonicalCoordinateDirection {N : ℕ} (j : Fin N ⊕ Fin N) : textbookLangevinPhase N :=
  match j with
  | Sum.inl i => (Pi.single i 1, 0)
  | Sum.inr i => (0, Pi.single i 1)

/-- The negative logarithmic derivative of the same original canonical weight. -/
def textbookLangevinCanonicalCoordinateLogSlope {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (j : Fin N ⊕ Fin N)
    (x : textbookLangevinPeriodicPhase N) : ℝ :=
  match j with
  | Sum.inl i => β * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1
  | Sum.inr i => β * x.2 i

private theorem coordinate_projection_shift {N : ℕ} (z : textbookLangevinPhase N)
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

private theorem coordinate_rep {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (Q : UnitAddTorus (Fin N)) (p : Fin N → ℝ) :
    (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) = F (Q, p) := by
  change F (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative Q), p) = _
  rw [textbookConfigurationTorusRepresentative_projects]

private theorem coordinate_slice_q_derivative {N : ℕ}
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

private theorem coordinate_F_continuous {N : ℕ} (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) : Continuous F :=
  (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hF.continuous

private theorem coordinate_U_partial_continuous {N : ℕ} (U : (Fin N → ℝ) → ℝ)
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

/-- Unweighted position IBP for arbitrary genuine compact smooth phase tests,
derived by configurational Gibbs slices and actual joint Fubini. -/
theorem textbookLangevinCanonicalMeasure_unweighted_position_integrationByParts {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (i : Fin N) :
    (∫ x, textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
      β * ∫ x, textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookConfigurationTorusGibbsMeasure U β) :=
    textbookConfigurationTorusGibbsMeasure_isProbabilityMeasure U hU hp β
  have : IsProbabilityMeasure (textbookLangevinCanonicalMomentumMeasure N β hβ) :=
    textbookLangevinCanonicalMomentumMeasure_isProbabilityMeasure N β hβ
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hFc := coordinate_F_continuous F hF
  have hi1 : Integrable (textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0))
      (textbookLangevinCanonicalMeasure U β hβ) :=
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF _).integrable_of_hasCompactSupport
      (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _)
  have hi2 : Integrable (fun x : textbookLangevinPeriodicPhase N ↦
      textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((coordinate_U_partial_continuous U hU hp i).mul hFc).integrable_of_hasCompactSupport hs.mul_left
  have he (p : Fin N → ℝ) :
      (∫ Q, textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) (Q, p)
        ∂textbookConfigurationTorusGibbsMeasure U β) =
      β * ∫ Q, textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p)
        ∂textbookConfigurationTorusGibbsMeasure U β := by
    let f := fun q : Fin N → ℝ ↦ (F ∘ textbookLangevinPeriodicProjection) (q, p)
    have hf : ContDiff ℝ ∞ f := hF.comp (contDiff_id.prodMk contDiff_const)
    have hpf : textbookUnitPeriodicPotential f := by
      intro q n
      simpa only [f, Function.comp_apply, Prod.mk_add_mk, add_zero] using congrArg F (coordinate_projection_shift (q, p) n)
    have hb := textbookConfigurationTorusGibbsMeasure_integrationByParts U f hU hf hp hpf β i
    have hL : textbookConfigurationTorusObservable (textbookConfigurationPartial f i) =
        fun Q ↦ textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) (Q, p) := by
      funext Q
      exact coordinate_slice_q_derivative _ hF _ p _
    have hR : textbookConfigurationTorusObservable (fun q ↦ textbookConfigurationPartial U i q * f q) =
        fun Q ↦ textbookConfigurationTorusObservable (textbookConfigurationPartial U i) Q * F (Q, p) := by
      funext Q
      change textbookConfigurationPartial U i (textbookConfigurationTorusRepresentative Q) *
        (F ∘ textbookLangevinPeriodicProjection) (textbookConfigurationTorusRepresentative Q, p) = _
      rw [coordinate_rep]
      rfl
    rw [hL, hR] at hb
    exact hb
  change (∫ x, textbookLangevinPeriodicDirectionalDerivative F (Pi.single i 1, 0) x
      ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)) = _
  rw [integral_prod_symm _ hi1]
  change _ = β * ∫ x, textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x
    ∂(textbookConfigurationTorusGibbsMeasure U β).prod (textbookLangevinCanonicalMomentumMeasure N β hβ)
  rw [integral_prod_symm _ hi2]
  simp_rw [he, integral_const_mul]

private theorem coordinate_slope_continuous {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (j : Fin N ⊕ Fin N) :
    Continuous (textbookLangevinCanonicalCoordinateLogSlope U β j) := by
  cases j with
  | inl i => exact continuous_const.mul (coordinate_U_partial_continuous U hU hp i)
  | inr i => exact continuous_const.mul ((continuous_apply i).comp continuous_snd)

/-- The actual canonical coordinate logarithmic slopes give the true joint IBP
for both position and momentum coordinates, including the empty dimension. -/
theorem textbookLangevinCanonicalMeasure_coordinate_integrationByParts {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) :
    (∫ x, textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j) x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
    ∫ x, textbookLangevinCanonicalCoordinateLogSlope U β j x * F x
      ∂textbookLangevinCanonicalMeasure U β hβ := by
  cases j with
  | inl i =>
    simp only [textbookLangevinCanonicalCoordinateDirection, textbookLangevinCanonicalCoordinateLogSlope]
    rw [show (fun x : textbookLangevinPeriodicPhase N ↦
        β * textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x) =
      (fun x ↦ β * (textbookConfigurationTorusObservable (textbookConfigurationPartial U i) x.1 * F x)) by
        funext x; ring, integral_const_mul]
    exact textbookLangevinCanonicalMeasure_unweighted_position_integrationByParts U hU hp β hβ F hF hs i
  | inr i =>
    simp only [textbookLangevinCanonicalCoordinateDirection, textbookLangevinCanonicalCoordinateLogSlope]
    rw [show (fun x : textbookLangevinPeriodicPhase N ↦ β * x.2 i * F x) =
      (fun x ↦ β * (x.2 i * F x)) by funext x; ring, integral_const_mul]
    exact textbookLangevinCanonicalMeasure_unweighted_momentum_integrationByParts U hU hp β hβ F hF hs i

/-- The actual weighted transpose expression of one coordinate derivative. -/
def textbookLangevinCanonicalCoordinateAdjointTestExpression {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ) (x : textbookLangevinPeriodicPhase N) : ℝ :=
  -textbookLangevinPeriodicDirectionalDerivative G (textbookLangevinCanonicalCoordinateDirection j) x +
    textbookLangevinCanonicalCoordinateLogSlope U β j x * G x

/-- Actual product differentiation and actual canonical coordinate IBP give
the genuine weighted transpose pairing for arbitrary compact smooth tests. -/
theorem textbookLangevinCanonicalMeasure_coordinate_weighted_pairing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (F G : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection))
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection))
    (hsF : HasCompactSupport F) (hsG : HasCompactSupport G) :
    (∫ x, textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j) x * G x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
    ∫ x, F x * textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G x
      ∂textbookLangevinCanonicalMeasure U β hβ := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  let v := textbookLangevinCanonicalCoordinateDirection j
  let s := textbookLangevinCanonicalCoordinateLogSlope U β j
  have hFG : ContDiff ℝ ∞ ((fun x ↦ F x * G x) ∘ textbookLangevinPeriodicProjection) := by
    simpa only [Function.comp_apply] using! hF.mul hG
  have h1 : Integrable (fun x ↦ F x * textbookLangevinPeriodicDirectionalDerivative G v x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((coordinate_F_continuous F hF).mul (textbookLangevinPeriodicDirectionalDerivative_continuous G hG v)).integrable_of_hasCompactSupport hsF.mul_right
  have h2 : Integrable (fun x ↦ G x * textbookLangevinPeriodicDirectionalDerivative F v x)
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((coordinate_F_continuous G hG).mul (textbookLangevinPeriodicDirectionalDerivative_continuous F hF v)).integrable_of_hasCompactSupport hsG.mul_right
  have h3 : Integrable (fun x ↦ s x * (F x * G x))
      (textbookLangevinCanonicalMeasure U β hβ) :=
    ((coordinate_slope_continuous U hU hp β j).mul
      ((coordinate_F_continuous F hF).mul (coordinate_F_continuous G hG))).integrable_of_hasCompactSupport hsF.mul_right.mul_left
  have he := textbookLangevinCanonicalMeasure_coordinate_integrationByParts U hU hp β hβ
    (fun x ↦ F x * G x) hFG hsF.mul_right j
  change (∫ x, textbookLangevinPeriodicDirectionalDerivative (fun y ↦ F y * G y) v x
      ∂textbookLangevinCanonicalMeasure U β hβ) =
    ∫ x, s x * (F x * G x) ∂textbookLangevinCanonicalMeasure U β hβ at he
  simp_rw [textbookLangevinPeriodicDirectionalDerivative_mul F G hF hG] at he
  rw [integral_add h1 h2] at he
  calc
    _ = ∫ x, G x * textbookLangevinPeriodicDirectionalDerivative F v x
        ∂textbookLangevinCanonicalMeasure U β hβ := by
      apply integral_congr_ae
      exact Filter.Eventually.of_forall (fun x ↦ mul_comm _ _)
    _ = (∫ x, s x * (F x * G x) ∂textbookLangevinCanonicalMeasure U β hβ) -
        ∫ x, F x * textbookLangevinPeriodicDirectionalDerivative G v x
          ∂textbookLangevinCanonicalMeasure U β hβ := by linarith [he]
    _ = _ := by
      rw [← integral_sub h3 h1]
      apply integral_congr_ae
      filter_upwards [] with x
      simp only [textbookLangevinCanonicalCoordinateAdjointTestExpression]
      change s x * (F x * G x) - F x * textbookLangevinPeriodicDirectionalDerivative G v x =
        F x * (-textbookLangevinPeriodicDirectionalDerivative G v x + s x * G x)
      ring

private theorem coordinate_D_memLp {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (F : textbookLangevinPeriodicPhase N → ℝ)
    (hF : ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport F)
    (j : Fin N ⊕ Fin N) :
    MemLp (textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j))
      2 (textbookLangevinCanonicalMeasure U β hβ) :=
  textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ _
    (textbookLangevinPeriodicDirectionalDerivative_continuous F hF _)
    (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport F hs _)

/-- The literal transpose test lies in the same actual canonical Hilbert space. -/
theorem textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hs : HasCompactSupport G) :
    MemLp (textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G) 2
      (textbookLangevinCanonicalMeasure U β hβ) := by
  apply textbookLangevinCanonicalMeasure_compact_memLp_two U hU hp β hβ _
  · exact (textbookLangevinPeriodicDirectionalDerivative_continuous G hG _).neg.add
      ((coordinate_slope_continuous U hU hp β j).mul (coordinate_F_continuous G hG))
  · exact (textbookLangevinPeriodicDirectionalDerivative_hasCompactSupport G hs _).neg.add hs.mul_left

/-- The genuine coordinate derivative test graph in the original canonical L2,
with actual AE representatives of the test and its true coordinate derivative. -/
def textbookLangevinCanonicalCoordinateHilbertTestGraph {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    Set (Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) ×
      Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) :=
  {p | ∃ F : textbookLangevinPeriodicPhase N → ℝ,
    HasCompactSupport F ∧ ContDiff ℝ ∞ (F ∘ textbookLangevinPeriodicProjection) ∧
    p.1 =ᵐ[textbookLangevinCanonicalMeasure U β hβ] F ∧
    p.2 =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
      textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j)}

/-- The actual coordinate test domain is dense by the proved same-measure smooth density. -/
theorem textbookLangevinCanonicalCoordinateHilbertTestGraph_domain_dense {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N) :
    Dense {f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) |
      ∃ g, (f, g) ∈ textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j} := by
  apply (textbookLangevinCanonicalL2_dense_smooth_compact U hU hp β hβ).mono
  rintro f ⟨F, hf, hs, hF⟩
  have hg := coordinate_D_memLp U hU hp β hβ F hF hs j
  exact ⟨hg.toLp _, F, hs, hF, hf, hg.coeFn_toLp⟩

/-- True coordinate transpose testing persists on the actual graph closure
by Hilbert pairing continuity, without assuming any Sobolev closed domain. -/
theorem textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_pairing {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (f g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hfg : (f, g) ∈ closure (textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j))
    (G : textbookLangevinPeriodicPhase N → ℝ)
    (hG : ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection)) (hsG : HasCompactSupport G) :
    ⟪g, textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (coordinate_F_continuous G hG) hsG⟫_ℝ =
    ⟪f, (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _⟫_ℝ := by
  let H := Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)
  let v : H := textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
    (coordinate_F_continuous G hG) hsG
  let w : H := (textbookLangevinCanonicalCoordinateAdjointTestExpression_memLp_two U hU hp β hβ j G hG hsG).toLp _
  let Z : Set (H × H) := {p | ⟪p.2, v⟫_ℝ = ⟪p.1, w⟫_ℝ}
  have hZ : IsClosed Z := isClosed_eq (by fun_prop) (by fun_prop)
  have hsub : textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j ⊆ Z := by
    rintro p ⟨F, hsF, hF, hf, hg⟩
    have hv : v =ᵐ[textbookLangevinCanonicalMeasure U β hβ] G :=
      textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G _ hsG
    have hw : w =ᵐ[textbookLangevinCanonicalMeasure U β hβ]
        textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G :=
      MemLp.coeFn_toLp _
    change ⟪p.2, v⟫_ℝ = ⟪p.1, w⟫_ℝ
    rw [L2.inner_def, L2.inner_def]
    calc
      _ = ∫ x, textbookLangevinPeriodicDirectionalDerivative F (textbookLangevinCanonicalCoordinateDirection j) x * G x
          ∂textbookLangevinCanonicalMeasure U β hβ := by
        apply integral_congr_ae
        filter_upwards [hg, hv] with x hx hy
        rw [hx, hy, Real.inner_apply]
      _ = ∫ x, F x * textbookLangevinCanonicalCoordinateAdjointTestExpression U β j G x
          ∂textbookLangevinCanonicalMeasure U β hβ :=
        textbookLangevinCanonicalMeasure_coordinate_weighted_pairing U hU hp β hβ j F G hF hG hsF hsG
      _ = _ := by
        apply integral_congr_ae
        filter_upwards [hf, hw] with x hx hy
        rw [hx, hy, Real.inner_apply]
  exact (closure_minimal hsub hZ) hfg

/-- Every genuine coordinate derivative graph is closable in the actual canonical
Hilbert space: a zero test-function limit has only the zero derivative limit. -/
theorem textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_zero_vertical {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (j : Fin N ⊕ Fin N)
    (g : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (hg : (0, g) ∈ closure (textbookLangevinCanonicalCoordinateHilbertTestGraph U β hβ j)) : g = 0 := by
  apply (textbookLangevinCanonicalL2_dense_smooth_compact U hU hp β hβ).eq_zero_of_inner_left ℝ
  rintro v ⟨G, hv, hsG, hG⟩
  have he : v = textbookLangevinCanonicalL2CompactObservable U hU hp β hβ G
      (coordinate_F_continuous G hG) hsG := by
    apply Lp.ext
    exact hv.trans (textbookLangevinCanonicalL2CompactObservable_ae_eq U hU hp β hβ G _ hsG).symm
  rw [he]
  simpa using textbookLangevinCanonicalCoordinateHilbertTestGraph_closure_pairing U hU hp β hβ j
    0 g hg G hG hsG

end
end MolecularDynamics
