import MolecularDynamics.Chapter06.LangevinCanonicalConjugation
import Mathlib.Analysis.Calculus.BumpFunction.Convolution
import Mathlib.Analysis.Calculus.ContDiff.Convolution
import Mathlib.MeasureTheory.Function.ContinuousMapDense
import Mathlib.MeasureTheory.Function.L2Space

/-! Actual compact smooth periodic phase tests are dense for the original
canonical L2 law. This is Hilbert density, not a generator graph-core theorem. -/
open Set Filter MeasureTheory Metric ContinuousLinearMap Function
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty BigOperators Convolution Pointwise
namespace MolecularDynamics
noncomputable section

private def phase_smooth_kernel {N : ℕ} (δ : ℝ) (hδ : 0 < δ) : textbookLangevinPhase N → ℝ :=
  (⟨δ / 2, δ, half_pos hδ, half_lt_self hδ⟩ : ContDiffBump (0 : textbookLangevinPhase N)).normed
    (Measure.addHaar : Measure (textbookLangevinPhase N))

private theorem phase_kernel_compact {N : ℕ} (δ : ℝ) (hδ : 0 < δ) :
    HasCompactSupport (phase_smooth_kernel (N := N) δ hδ) :=
  (⟨δ / 2, δ, half_pos hδ, half_lt_self hδ⟩ : ContDiffBump (0 : textbookLangevinPhase N)).hasCompactSupport_normed (μ := Measure.addHaar)

private theorem phase_kernel_smooth {N : ℕ} (δ : ℝ) (hδ : 0 < δ) :
    ContDiff ℝ ∞ (phase_smooth_kernel (N := N) δ hδ) :=
  (⟨δ / 2, δ, half_pos hδ, half_lt_self hδ⟩ : ContDiffBump (0 : textbookLangevinPhase N)).contDiff_normed (μ := Measure.addHaar)

private theorem phase_projection_shift {N : ℕ} (z : textbookLangevinPhase N) (n : Fin N → ℤ) :
    textbookLangevinPeriodicProjection (z + ((fun i ↦ (n i : ℝ)), 0)) =
      textbookLangevinPeriodicProjection z := by
  apply Prod.ext
  · funext i
    change ((z.1 i + (n i : ℝ) : ℝ) : UnitAddCircle) = (z.1 i : UnitAddCircle)
    have hn : ((n i : ℝ) : UnitAddCircle) = 0 :=
      (AddCircle.coe_eq_zero_iff (1 : ℝ)).mpr ⟨n i, by simp [zsmul_eq_mul]⟩
    rw [AddCircle.coe_add, hn, add_zero]
  · exact add_zero _

private theorem phase_convolution_periodic {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (k : textbookLangevinPhase N → ℝ)
    (p : Fin N → ℝ) :
    textbookUnitPeriodicPotential (fun q ↦
      (k ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
        (F ∘ textbookLangevinPeriodicProjection)) (q, p)) := by
  intro q n
  change (k ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
    (F ∘ textbookLangevinPeriodicProjection)) (q + (fun i ↦ (n i : ℝ)), p) =
    (k ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
      (F ∘ textbookLangevinPeriodicProjection)) (q, p)
  rw [convolution_def, convolution_def]
  apply integral_congr_ae
  filter_upwards [] with y
  have he : ((q + (fun i ↦ (n i : ℝ)), p) : textbookLangevinPhase N) - y =
      ((q, p) - y) + ((fun i ↦ (n i : ℝ)), 0) := by
    apply Prod.ext
    · funext i
      simp only [Prod.fst_sub, Prod.fst_add, Pi.sub_apply, Pi.add_apply]
      ring
    · simp
  simp only [Function.comp_apply]
  rw [he, phase_projection_shift]

/-- A true normalized compact real-phase convolution descends to the
original phase quotient, retaining actual integer periodicity. -/
def textbookLangevinPeriodicSmoothApproximation {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (δ : ℝ) (hδ : 0 < δ)
    (x : textbookLangevinPeriodicPhase N) : ℝ :=
  textbookConfigurationTorusObservable (fun q ↦
    (phase_smooth_kernel δ hδ ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
      (F ∘ textbookLangevinPeriodicProjection)) (q, x.2)) x.1

/-- The descended smoothing is exactly the same real convolution at every
representative, derived from genuine periodicity without a continuity assumption. -/
theorem textbookLangevinPeriodicSmoothApproximation_lift {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (δ : ℝ) (hδ : 0 < δ) (z : textbookLangevinPhase N) :
    textbookLangevinPeriodicSmoothApproximation F δ hδ (textbookLangevinPeriodicProjection z) =
      (phase_smooth_kernel δ hδ ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
        (F ∘ textbookLangevinPeriodicProjection)) z :=
  textbookConfigurationTorusObservable_lift _
    (phase_convolution_periodic F (phase_smooth_kernel δ hδ) z.2) z.1

/-- The true compact smooth kernel makes the original continuous phase
observable's actual real lift smooth; no smooth approximation is assumed. -/
theorem textbookLangevinPeriodicSmoothApproximation_lift_contDiff {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hF : Continuous F) (δ : ℝ) (hδ : 0 < δ) :
    ContDiff ℝ ∞ (textbookLangevinPeriodicSmoothApproximation F δ hδ ∘ textbookLangevinPeriodicProjection) := by
  have he : textbookLangevinPeriodicSmoothApproximation F δ hδ ∘ textbookLangevinPeriodicProjection =
      phase_smooth_kernel δ hδ ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
        (F ∘ textbookLangevinPeriodicProjection) :=
    funext (textbookLangevinPeriodicSmoothApproximation_lift F δ hδ)
  rw [he]
  exact (phase_kernel_compact δ hδ).contDiff_convolution_left (lsmul ℝ ℝ)
    (phase_kernel_smooth δ hδ) (hF.comp (textbookLangevinPeriodicProjection_continuous N)).locallyIntegrable

/-- Actual momentum support remains in a genuine compact sum of the
original momentum support and the real compact kernel support.
Position compactness is the true torus compactness, not a compact real lift. -/
theorem textbookLangevinPeriodicSmoothApproximation_hasCompactSupport {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hs : HasCompactSupport F) (δ : ℝ) (hδ : 0 < δ) :
    HasCompactSupport (textbookLangevinPeriodicSmoothApproximation F δ hδ) := by
  let A := Prod.snd '' tsupport F
  let B := Prod.snd '' tsupport (phase_smooth_kernel (N := N) δ hδ)
  have hA : IsCompact A := hs.isCompact.image continuous_snd
  have hB : IsCompact B := (phase_kernel_compact δ hδ).isCompact.image continuous_snd
  have hK : IsCompact ((univ : Set (UnitAddTorus (Fin N))) ×ˢ (A + B)) :=
    isCompact_univ.prod (hA.add hB)
  apply hK.of_isClosed_subset isClosed_closure
  apply closure_minimal _ hK.isClosed
  intro x hx
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  have hz : z ∈ support
      (phase_smooth_kernel δ hδ ⋆[lsmul ℝ ℝ, (Measure.addHaar : Measure (textbookLangevinPhase N))]
        (F ∘ textbookLangevinPeriodicProjection)) := by
    change _ ≠ 0
    rw [← textbookLangevinPeriodicSmoothApproximation_lift F δ hδ z]
    exact hx
  obtain ⟨a, ha, b, hb, hab⟩ :=
    support_convolution_subset (lsmul ℝ ℝ) hz
  refine ⟨mem_univ _, ?_⟩
  refine ⟨b.2, ⟨textbookLangevinPeriodicProjection b, subset_closure hb, rfl⟩,
    a.2, ⟨a, subset_closure ha, rfl⟩, ?_⟩
  change b.2 + a.2 = z.2
  rw [← hab]
  simp only [Prod.snd_add, add_comm]

/-- Every genuine continuous compact phase observable is approximated
uniformly by actual smooth compact periodic phase tests, using normalized
convolution and the proved uniformly continuous original projection. -/
theorem textbookLangevinPeriodicPhase_exists_smooth_compact_uniform_approx {N : ℕ}
    (F : textbookLangevinPeriodicPhase N → ℝ) (hF : Continuous F) (hs : HasCompactSupport F)
    (ε : ℝ) (hε : 0 < ε) :
    ∃ G : textbookLangevinPeriodicPhase N → ℝ, HasCompactSupport G ∧
      ContDiff ℝ ∞ (G ∘ textbookLangevinPeriodicProjection) ∧ ∀ x, dist (G x) (F x) < ε := by
  have hu : UniformContinuous (F ∘ textbookLangevinPeriodicProjection) :=
    (hF.uniformContinuous_of_tendsto_cocompact hs.is_zero_at_infty).comp
      (textbookLangevinPeriodicProjection_uniformContinuous N)
  obtain ⟨δ, hδ, hb⟩ := Metric.uniformContinuous_iff.mp hu (ε / 2) (half_pos hε)
  refine ⟨textbookLangevinPeriodicSmoothApproximation F δ hδ,
    textbookLangevinPeriodicSmoothApproximation_hasCompactSupport F hs δ hδ,
    textbookLangevinPeriodicSmoothApproximation_lift_contDiff F hF δ hδ, ?_⟩
  intro x
  obtain ⟨z, rfl⟩ := textbookLangevinPeriodicProjection_surjective N x
  rw [textbookLangevinPeriodicSmoothApproximation_lift]
  let φ : ContDiffBump (0 : textbookLangevinPhase N) := ⟨δ / 2, δ, half_pos hδ, half_lt_self hδ⟩
  have he : dist ((φ.normed (Measure.addHaar : Measure (textbookLangevinPhase N)) ⋆[lsmul ℝ ℝ,
      (Measure.addHaar : Measure (textbookLangevinPhase N))] (F ∘ textbookLangevinPeriodicProjection)) z)
      ((F ∘ textbookLangevinPeriodicProjection) z) ≤ ε / 2 :=
    φ.dist_normed_convolution_le
      (hF.comp (textbookLangevinPeriodicProjection_continuous N)).aestronglyMeasurable
      (fun y hy ↦ (hb hy).le)
  exact he.trans_lt (half_lt_self hε)

/-- Every actual canonical L2 function has genuine compact smooth phase
approximations for the same original measure. No smooth-core density premise
or replacement measure is introduced. -/
theorem textbookLangevinCanonicalMeasure_memLp_two_smooth_compact_approx {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinPeriodicPhase N → ℝ)
    (hf : MemLp f 2 (textbookLangevinCanonicalMeasure U β hβ)) (ε : ℝ) (hε : 0 < ε) :
    ∃ g : textbookLangevinPeriodicPhase N → ℝ, HasCompactSupport g ∧
      ContDiff ℝ ∞ (g ∘ textbookLangevinPeriodicProjection) ∧
      eLpNorm (f - g) 2 (textbookLangevinCanonicalMeasure U β hβ) ≤ ENNReal.ofReal ε := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  have hhalf : 0 < ε / 2 := half_pos hε
  obtain ⟨v, hvs, hvd, hvc, -⟩ := hf.exists_hasCompactSupport_eLpNorm_sub_le
    (by norm_num) (ENNReal.ofReal_pos.mpr hhalf).ne'
  obtain ⟨g, hgs, hgd, hdist⟩ := textbookLangevinPeriodicPhase_exists_smooth_compact_uniform_approx v hvc hvs (ε / 2) hhalf
  have hgc : Continuous g :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hgd.continuous
  have hbound : eLpNorm (v - g) 2 (textbookLangevinCanonicalMeasure U β hβ) ≤ ENNReal.ofReal (ε / 2) := by
    have he := eLpNorm_le_of_ae_bound (p := (2 : ℝ≥0∞)) (μ := textbookLangevinCanonicalMeasure U β hβ)
      (hvc.sub hgc).aestronglyMeasurable
      (Eventually.of_forall (fun x ↦ by simpa only [Pi.sub_apply, ← dist_eq_norm_sub, dist_comm] using (hdist x).le))
    simpa using he
  refine ⟨g, hgs, hgd, ?_⟩
  have he : f - g = (f - v) + (v - g) := by ext x; simp
  rw [he]
  exact (eLpNorm_add_le (by norm_num : (1 : ℝ≥0∞) ≤ 2)).trans
    ((add_le_add hvd hbound).trans_eq (by rw [← ENNReal.ofReal_add hhalf.le hhalf.le, add_halves]))

/-- The original canonical Hilbert L2 space has the genuine smooth compact
phase test class as a dense set. This is not density in a generator graph norm. -/
theorem textbookLangevinCanonicalL2_dense_smooth_compact {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) :
    Dense {f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ) |
      ∃ g : textbookLangevinPeriodicPhase N → ℝ, f =ᵐ[textbookLangevinCanonicalMeasure U β hβ] g ∧
        HasCompactSupport g ∧ ContDiff ℝ ∞ (g ∘ textbookLangevinPeriodicProjection)} := by
  have : IsProbabilityMeasure (textbookLangevinCanonicalMeasure U β hβ) :=
    textbookLangevinCanonicalMeasure_isProbabilityMeasure U hU hp β hβ
  intro f
  refine (mem_closure_iff_nhds_basis Metric.nhds_basis_closedBall).2 fun ε hε ↦ ?_
  obtain ⟨g, hgs, hgd, hnorm⟩ := textbookLangevinCanonicalMeasure_memLp_two_smooth_compact_approx
    U hU hp β hβ f (Lp.memLp f) ε hε
  have hgc : Continuous g :=
    (textbookLangevinPeriodicProjection_isOpenQuotientMap N).isQuotientMap.continuous_iff.mpr hgd.continuous
  have hg : MemLp g 2 (textbookLangevinCanonicalMeasure U β hβ) := hgc.memLp_of_hasCompactSupport hgs
  refine ⟨hg.toLp g, ⟨g, hg.coeFn_toLp, hgs, hgd⟩, ?_⟩
  rw [Metric.mem_closedBall, dist_comm, Lp.dist_def,
    ← ENNReal.le_ofReal_iff_toReal_le ((Lp.memLp f).sub (Lp.memLp (hg.toLp g))).eLpNorm_ne_top hε.le]
  convert! hnorm using 1
  apply eLpNorm_congr_ae
  filter_upwards [hg.coeFn_toLp] with x hx
  simp only [Pi.sub_apply, hx]

end
end MolecularDynamics
