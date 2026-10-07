import MolecularDynamics.Chapter06.LangevinCanonicalKernelPairingShift

/-! Common compact supports for actual periodic smooth approximation, followed
by genuine reference integral continuity and kernel continuous test invariance. -/
open Set Filter MeasureTheory Metric ContinuousLinearMap Function
open scoped Topology ContDiff NNReal ENNReal BigOperators Convolution Pointwise
namespace MolecularDynamics
noncomputable section
local instance compactTestUnitCircleMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance compactTestUnitCircleHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance compactTestUnitCircleProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The actual common compact momentum enlargement by the projected real unit
ball, with the genuine compact position torus. -/
def textbookLangevinPeriodicSmoothApproximationSupportRegion {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) : Set (textbookLangevinPeriodicPhase N) :=
  (univ : Set (UnitAddTorus (Fin N))) ×ˢ
    ((Prod.snd '' tsupport F) + Prod.snd '' closedBall (0 : textbookLangevinPhase N) 1)

/-- The common support region is genuinely compact, including dimension zero. -/
theorem textbookLangevinPeriodicSmoothApproximationSupportRegion_isCompact {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hsF : HasCompactSupport F) :
    IsCompact (textbookLangevinPeriodicSmoothApproximationSupportRegion F) :=
  isCompact_univ.prod ((hsF.isCompact.image continuous_snd).add
    ((isCompact_closedBall (0 : textbookLangevinPhase N) 1).image continuous_snd))

/-- The true original test support is contained in the actual enlargement. -/
theorem textbookLangevinPeriodicSmoothApproximationSupportRegion_contains {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) :
    tsupport F ⊆ textbookLangevinPeriodicSmoothApproximationSupportRegion F := by
  intro x hx
  refine ⟨mem_univ _, ⟨x.2, ⟨x, hx, rfl⟩, 0, ?_, add_zero _⟩⟩
  exact ⟨0, by simp, rfl⟩

/-- All actual normalized smoothings with radius at most one have support in
the same proved compact enlargement; no uniform support bound is assumed. -/
theorem textbookLangevinPeriodicSmoothApproximation_support_uniform {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hsF : HasCompactSupport F)
    (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ ≤ 1) :
    tsupport (textbookLangevinPeriodicSmoothApproximation F δ hδ) ⊆
      textbookLangevinPeriodicSmoothApproximationSupportRegion F := by
  have hK := textbookLangevinPeriodicSmoothApproximationSupportRegion_isCompact F hsF
  apply closure_minimal _ hK.isClosed
  intro x hx
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  let φ : ContDiffBump (0 : textbookLangevinPhase N) := ⟨δ / 2, δ, half_pos hδ, half_lt_self hδ⟩
  have hz : z ∈ support
      (φ.normed (Measure.addHaar : Measure (textbookLangevinPhase N)) ⋆[lsmul ℝ ℝ,
        (Measure.addHaar : Measure (textbookLangevinPhase N))] (F ∘ textbookLangevinPeriodicProjection)) := by
    change _ ≠ 0
    have he := textbookLangevinPeriodicSmoothApproximation_lift F δ hδ z
    change textbookLangevinPeriodicSmoothApproximation F δ hδ (textbookLangevinPeriodicProjection z) =
      (φ.normed (Measure.addHaar : Measure (textbookLangevinPhase N)) ⋆[lsmul ℝ ℝ,
        (Measure.addHaar : Measure (textbookLangevinPhase N))] (F ∘ textbookLangevinPeriodicProjection)) z at he
    rw [← he]
    exact hx
  obtain ⟨a, ha, b, hb, hab⟩ := support_convolution_subset (lsmul ℝ ℝ) hz
  have ha1 : a ∈ closedBall (0 : textbookLangevinPhase N) 1 := by
    rw [φ.support_normed_eq] at ha
    exact (ball_subset_closedBall ha |> fun h ↦ closedBall_subset_closedBall hδ1 h)
  refine ⟨mem_univ _, ⟨b.2, ⟨textbookLangevinPeriodicProjection b, subset_closure hb, rfl⟩,
    a.2, ⟨a, ha1, rfl⟩, ?_⟩⟩
  change b.2 + a.2 = z.2
  rw [← hab]
  simp only [Prod.snd_add, add_comm]

/-- Actual smooth compact approximation can be chosen with a single genuine
compact support region for every requested positive uniform error. -/
theorem textbookLangevinPeriodicPhase_exists_smooth_compact_uniform_approx_in_common_support {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hF : Continuous F) (hsF : HasCompactSupport F)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ G : textbookLangevinPeriodicPhase N → ℝ, HasCompactSupport G ∧
      ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection) ∧
      tsupport G ⊆ textbookLangevinPeriodicSmoothApproximationSupportRegion F ∧
      ∀ x, dist (G x) (F x) < ε := by
  have hu : UniformContinuous (F ∘ textbookLangevinPeriodicProjection) :=
    (hF.uniformContinuous_of_tendsto_cocompact hsF.is_zero_at_infty).comp
      (textbookLangevinPeriodicProjection_uniformContinuous N)
  obtain ⟨r, hr, hb⟩ := Metric.uniformContinuous_iff.mp hu (ε / 2) (half_pos hε)
  let δ : ℝ := min r 1
  have hδ : 0 < δ := lt_min hr zero_lt_one
  have hδr : δ ≤ r := min_le_left _ _
  have hδ1 : δ ≤ 1 := min_le_right _ _
  refine ⟨textbookLangevinPeriodicSmoothApproximation F δ hδ,
    textbookLangevinPeriodicSmoothApproximation_hasCompactSupport F hsF δ hδ,
    textbookLangevinPeriodicSmoothApproximation_lift_contDiff F hF δ hδ,
    textbookLangevinPeriodicSmoothApproximation_support_uniform F hsF δ hδ hδ1, ?_⟩
  intro x
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  rw [textbookLangevinPeriodicSmoothApproximation_lift]
  let φ : ContDiffBump (0 : textbookLangevinPhase N) := ⟨δ / 2, δ, half_pos hδ, half_lt_self hδ⟩
  have he : dist ((φ.normed (Measure.addHaar : Measure (textbookLangevinPhase N)) ⋆[lsmul ℝ ℝ,
      (Measure.addHaar : Measure (textbookLangevinPhase N))] (F ∘ textbookLangevinPeriodicProjection)) z)
      ((F ∘ textbookLangevinPeriodicProjection) z) ≤ ε / 2 :=
    φ.dist_normed_convolution_le
      (hF.comp (textbookLangevinPeriodicProjection_continuous N)).aestronglyMeasurable
      (fun y hy ↦ (hb (hy.trans_le hδr)).le)
  exact he.trans_lt (half_lt_self hε)

private theorem compactTest_locallyIntegrable_shift {N : ℕ}
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : LocallyIntegrable f ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
    (a : textbookLangevinPeriodicPhase N) :
    LocallyIntegrable (fun x ↦ f (x + a))
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  apply locallyIntegrable_iff.mpr
  intro K hK
  have hmp := textbookLangevinPeriodicReferenceMeasure_shift_measurePreserving a
  have he : MeasurableEmbedding (fun x : textbookLangevinPeriodicPhase N ↦ x + a) :=
    (Homeomorph.addRight a).measurableEmbedding
  exact (hmp.integrableOn_image he).mp
    (hf.integrableOn_isCompact (hK.image (continuous_id.add continuous_const)))

/-- Genuine canonical L2 representatives remain reference locally integrable
after any phase translation, by the actual reference preserving homeomorphism. -/
theorem textbookLangevinCanonicalL2_unweighted_shift_locallyIntegrable {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ))
    (a : textbookLangevinPeriodicPhase N) :
    LocallyIntegrable (fun x ↦ f (x + a))
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
  compactTest_locallyIntegrable_shift f
    (textbookLangevinCanonicalL2_unweighted_locallyIntegrable U hU hp β hβ f) a

private theorem compactTest_pairing_error {N : ℕ}
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : LocallyIntegrable f ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
    (K : Set (textbookLangevinPeriodicPhase N)) (hK : IsCompact K)
    (F G : textbookLangevinPeriodicPhase N → ℝ) (hF : Continuous F) (hG : Continuous G)
    (hFs : tsupport F ⊆ K) (hGs : tsupport G ⊆ K)
    (ε : ℝ) (hε : ∀ x, dist (F x) (G x) ≤ ε) :
    ‖(∫ x, f x * F x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) -
      (∫ x, f x * G x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))‖ ≤
      ε * ∫ x in K, ‖f x‖
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  have hsF : HasCompactSupport F := hK.of_isClosed_subset (isClosed_tsupport _) hFs
  have hsG : HasCompactSupport G := hK.of_isClosed_subset (isClosed_tsupport _) hGs
  have hiF : Integrable (fun x ↦ f x * F x)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
    simpa only [smul_eq_mul, mul_comm] using hf.integrable_smul_left_of_hasCompactSupport hF hsF
  have hiG : Integrable (fun x ↦ f x * G x)
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
    simpa only [smul_eq_mul, mul_comm] using hf.integrable_smul_left_of_hasCompactSupport hG hsG
  let H : textbookLangevinPeriodicPhase N → ℝ := K.indicator (fun x ↦ ‖f x‖)
  have hiH : Integrable H
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    (integrable_indicator_iff hK.measurableSet).mpr (hf.integrableOn_isCompact hK).norm
  have hb (x : textbookLangevinPeriodicPhase N) : ‖f x * F x - f x * G x‖ ≤ ε * H x := by
    by_cases hx : x ∈ K
    · calc
        _ = ‖f x‖ * dist (F x) (G x) := by rw [← mul_sub, norm_mul, dist_eq_norm_sub]
        _ ≤ ‖f x‖ * ε := mul_le_mul_of_nonneg_left (hε x) (norm_nonneg _)
        _ = ε * H x := by simp only [H, indicator_of_mem hx]; ring
    · have hzF : F x = 0 := image_eq_zero_of_notMem_tsupport (fun hy ↦ hx (hFs hy))
      have hzG : G x = 0 := image_eq_zero_of_notMem_tsupport (fun hy ↦ hx (hGs hy))
      simp only [hzF, hzG, mul_zero, sub_self, norm_zero, H, indicator_of_notMem hx, le_refl]
  rw [← integral_sub hiF hiG]
  calc
    _ ≤ ∫ x, ‖f x * F x - f x * G x‖
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
      norm_integral_le_integral_norm _
    _ ≤ ∫ x, ε * H x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
      integral_mono_ae (hiF.sub hiG).norm (hiH.const_mul ε) (Eventually.of_forall hb)
    _ = _ := by rw [integral_const_mul, integral_indicator hK.measurableSet]

private theorem compactTest_pairing_translate {N : ℕ}
    (f G : textbookLangevinPeriodicPhase N → ℝ) (a : textbookLangevinPeriodicPhase N) :
    (∫ x, f x * G (x + a)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) =
      ∫ x, f (x + -a) * G x
        ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  have he := (textbookLangevinPeriodicReferenceMeasure_shift_measurePreserving a).integral_comp
    (Homeomorph.addRight a).measurableEmbedding (fun x ↦ f (x + -a) * G x)
  simpa only [add_neg_cancel_right] using he

/-- The actual kernel test pairing is invariant under genuine phase
translation for all continuous compact tests, via proved common supports and
honest local L1 integral error estimates from actual smooth approximation. -/
theorem textbookLangevinCanonicalHilbertClosedOperator_kernel_continuous_pairing_shift_invariant {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ σ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (hσ : σ ^ 2 = 2 * γ / β)
    (f : (textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ).domain)
    (hf : textbookLangevinCanonicalHilbertClosedOperator U β γ σ hβ f = 0)
    (F : textbookLangevinPeriodicPhase N → ℝ) (hF : Continuous F) (hsF : HasCompactSupport F)
    (a : textbookLangevinPeriodicPhase N) :
    (∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * F (x + a)
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) =
    ∫ x, (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x * F x
      ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) := by
  let f0 : textbookLangevinPeriodicPhase N → ℝ :=
    fun x ↦ (f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ)) x
  let K := textbookLangevinPeriodicSmoothApproximationSupportRegion F
  have hK : IsCompact K := textbookLangevinPeriodicSmoothApproximationSupportRegion_isCompact F hsF
  have hFs : tsupport F ⊆ K := textbookLangevinPeriodicSmoothApproximationSupportRegion_contains F
  have hl : LocallyIntegrable f0
      ((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))) :=
    textbookLangevinCanonicalL2_unweighted_locallyIntegrable U hU hp β hβ _
  have hls := compactTest_locallyIntegrable_shift f0 hl (-a)
  let A : ℝ := ∫ x in K, ‖f0 x‖
    ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))
  let B : ℝ := ∫ x in K, ‖f0 (x + -a)‖
    ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))
  have hA : 0 ≤ A := integral_nonneg (fun _ ↦ norm_nonneg _)
  have hB : 0 ≤ B := integral_nonneg (fun _ ↦ norm_nonneg _)
  apply eq_of_forall_dist_le
  intro ε hε
  let δ : ℝ := ε / (A + B + 1)
  have hD : 0 < A + B + 1 := by linarith
  have hδ : 0 < δ := div_pos hε hD
  obtain ⟨G, hsG, hG, hGs, he⟩ :=
    textbookLangevinPeriodicPhase_exists_smooth_compact_uniform_approx_in_common_support F hF hsF δ hδ
  have hcG : Continuous G :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hG.continuous
  have hGF (x) : dist (F x) (G x) ≤ δ := by rw [dist_comm]; exact (he x).le
  have e0 := compactTest_pairing_error f0 hl K hK F G hF hcG hFs hGs δ hGF
  have es := compactTest_pairing_error (fun x ↦ f0 (x + -a)) hls K hK F G hF hcG hFs hGs δ hGF
  have hGI := textbookLangevinCanonicalHilbertClosedOperator_kernel_pairing_shift_invariant
    U hU hp β γ σ hβ hγ hσ f hf G hG hsG a
  have htransF := compactTest_pairing_translate f0 F a
  have htransG := compactTest_pairing_translate f0 G a
  have heD : δ * (A + B + 1) = ε := div_mul_cancel₀ _ hD.ne'
  calc
    _ ≤ dist
        (∫ x, f0 x * F (x + a) ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
        (∫ x, f0 x * G (x + a) ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) +
      dist
        (∫ x, f0 x * G (x + a) ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ))))
        (∫ x, f0 x * F x ∂((volume : Measure (UnitAddTorus (Fin N))).prod (volume : Measure (Fin N → ℝ)))) :=
      dist_triangle _ _ _
    _ ≤ δ * B + δ * A := by
      apply add_le_add
      · rw [htransF, htransG, dist_eq_norm_sub]
        exact es
      · rw [hGI, dist_comm, dist_eq_norm_sub]
        exact e0
    _ ≤ ε := by nlinarith

end
end MolecularDynamics
