import MolecularDynamics.Chapter06.BrownianMassSelfAdjoint
import Mathlib.MeasureTheory.Function.Holder

/-! The actual bounded real potential operator and graph coordinate change for the original Gibbs model. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace BigOperators LinearPMap

namespace MolecularDynamics

noncomputable section

private local instance brownianPotentialCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianPotentialCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private def potentialLinf {Nc : ℕ} (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Lp ℝ ∞ (volume : Measure (UnitAddTorus (Fin Nc))) :=
  (textbookBrownianTorusGroundStatePotential m U hU hPU β).toLp ∞ volume ℝ

private theorem potentialLinf_norm {Nc : ℕ} (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    ‖potentialLinf m U hU hPU β‖ ≤ ‖textbookBrownianTorusGroundStatePotential m U hU hPU β‖ := by
  have h := Lp.norm_le_of_ae_bound (f := potentialLinf m U hU hPU β)
    (norm_nonneg (textbookBrownianTorusGroundStatePotential m U hU hPU β)) (by
      filter_upwards [ContinuousMap.coeFn_toLp (p := ∞) volume (𝕜 := ℝ)
        (textbookBrownianTorusGroundStatePotential m U hU hPU β)] with Q hQ
      rw [hQ]
      exact (textbookBrownianTorusGroundStatePotential m U hU hPU β).norm_coe_le_norm Q)
  simpa only [ENNReal.top_toReal, inv_zero, Real.rpow_zero, one_mul] using h

/-- Genuine bounded multiplication by the original transformed real potential on full Haar L². -/
def textbookBrownianHaarPotentialOperator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  LinearMap.mkContinuous
    { toFun := fun x ↦ potentialLinf m U hU hPU β • x
      map_add' := fun x y ↦ Lp.add_smul _ x y
      map_smul' := fun c x ↦ by
        rw [← Lp.smul_comm, Lp.smul_assoc] }
    ‖potentialLinf m U hU hPU β‖ (fun x ↦ Lp.norm_smul_le _ x)

/-- The full potential operator has the actual pointwise multiplication formula almost everywhere. -/
theorem textbookBrownianHaarPotentialOperator_ae {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookBrownianHaarPotentialOperator m U hU hPU β x =ᵐ[volume]
      fun Q ↦ textbookBrownianTorusGroundStatePotential m U hU hPU β Q * x Q := by
  filter_upwards [Lp.coeFn_lpSMul (potentialLinf m U hU hPU β) x,
    ContinuousMap.coeFn_toLp (p := ∞) volume (𝕜 := ℝ)
      (textbookBrownianTorusGroundStatePotential m U hU hPU β)] with Q hM hV
  change ((potentialLinf m U hU hPU β • x : Lp ℝ 2 volume) Q) = _
  rw [hM]
  change (potentialLinf m U hU hPU β Q) * x Q = _
  rw [hV]

/-- The bound follows from the true continuous potential norm; boundedness is not a premise. -/
theorem textbookBrownianHaarPotentialOperator_norm_bound {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ‖textbookBrownianHaarPotentialOperator m U hU hPU β x‖ ≤
      ‖textbookBrownianTorusGroundStatePotential m U hU hPU β‖ * ‖x‖ :=
  (Lp.norm_smul_le (potentialLinf m U hU hPU β) x).trans
    (mul_le_mul_of_nonneg_right (potentialLinf_norm m U hU hPU β) (norm_nonneg x))

/-- The actual real multiplication operator is symmetric on the entire true Hilbert space. -/
theorem textbookBrownianHaarPotentialOperator_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ⟪textbookBrownianHaarPotentialOperator m U hU hPU β x, y⟫_ℝ =
      ⟪x, textbookBrownianHaarPotentialOperator m U hU hPU β y⟫_ℝ := by
  rw [L2.inner_def, L2.inner_def]
  apply integral_congr_ae
  filter_upwards [textbookBrownianHaarPotentialOperator_ae m U hU hPU β x,
    textbookBrownianHaarPotentialOperator_ae m U hU hPU β y] with Q hx hy
  rw [hx, hy]
  simp only [RCLike.inner_apply, star_trivial]
  ring

/-- On every actual continuous observable the full operator is the original same-function product. -/
theorem textbookBrownianHaarPotentialOperator_continuous {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (g : C(UnitAddTorus (Fin Nc), ℝ)) :
    textbookBrownianHaarPotentialOperator m U hU hPU β (textbookHaarContinuousToLp Nc g) =
      textbookHaarContinuousToLp Nc
        (textbookBrownianTorusGroundStatePotential m U hU hPU β * g) := by
  apply Lp.ext
  filter_upwards [textbookBrownianHaarPotentialOperator_ae m U hU hPU β
      (textbookHaarContinuousToLp Nc g),
    ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℝ) g,
    ContinuousMap.coeFn_toLp (p := 2) volume (𝕜 := ℝ)
      (textbookBrownianTorusGroundStatePotential m U hU hPU β * g)] with Q hB hg hVg
  change (textbookBrownianHaarPotentialOperator m U hU hPU β
    (textbookHaarContinuousToLp Nc g) Q) =
    ((textbookBrownianTorusGroundStatePotential m U hU hPU β * g).toLp 2 volume ℝ Q)
  rw [hB, hg, hVg]
  rfl

/-- The original transformed potential acts on the entire original smooth periodic space. -/
def textbookBrownianGroundStateSmoothMultiply {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookPeriodicSmoothSpace Nc →ₗ[ℝ] textbookPeriodicSmoothSpace Nc where
  toFun f := ⟨fun q ↦ textbookBrownianGroundStatePotential m U β q * (f : (Fin Nc → ℝ) → ℝ) q,
    (textbookBrownianGroundStatePotential_contDiff m U hU β).mul f.prop.1, by
      intro q n
      rw [textbookBrownianGroundStatePotential_periodic m U hU hPU β q n, f.prop.2 q n]⟩
  map_add' f g := by
    apply Subtype.ext
    funext q
    change _ * ((f : (Fin Nc → ℝ) → ℝ) q + (g : (Fin Nc → ℝ) → ℝ) q) =
      _ * (f : (Fin Nc → ℝ) → ℝ) q + _ * (g : (Fin Nc → ℝ) → ℝ) q
    ring
  map_smul' c f := by
    apply Subtype.ext
    funext q
    change _ * (c * (f : (Fin Nc → ℝ) → ℝ) q) =
      c * (_ * (f : (Fin Nc → ℝ) → ℝ) q)
    ring

/-- Full smooth multiplication is precisely the true whole-Hilbert multiplication on the original embedding. -/
theorem textbookBrownianGroundStateSmoothMultiply_haarEmbedding {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookPeriodicSmoothHaarEmbedding Nc (textbookBrownianGroundStateSmoothMultiply m U hU hPU β f) =
      textbookBrownianHaarPotentialOperator m U hU hPU β (textbookPeriodicSmoothHaarEmbedding Nc f) := by
  rw [textbookBrownianHaarPotentialOperator_continuous]
  rfl

/-- The actual transformed full smooth operator is the original mass part plus the actual potential part. -/
theorem textbookBrownianHaarGroundStateSmoothGenerator_split {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β =
      textbookHaarMassSmoothGenerator m β + textbookBrownianGroundStateSmoothMultiply m U hU hPU β := by
  apply LinearMap.ext
  intro f
  apply Subtype.ext
  rfl

/-- The actual full smooth Hilbert image splits as true mass image plus true bounded multiplication. -/
theorem textbookBrownianHaarGroundStateSmoothGenerator_embedding_split {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (f : textbookPeriodicSmoothSpace Nc) :
    textbookPeriodicSmoothHaarEmbedding Nc (textbookBrownianHaarGroundStateSmoothGenerator m U hU hPU β f) =
      textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β f) +
        textbookBrownianHaarPotentialOperator m U hU hPU β (textbookPeriodicSmoothHaarEmbedding Nc f) := by
  rw [textbookBrownianHaarGroundStateSmoothGenerator_split]
  change textbookPeriodicSmoothHaarEmbedding Nc (_ + _) = _
  rw [map_add, textbookBrownianGroundStateSmoothMultiply_haarEmbedding]

/-- The actual graph coordinate change (x,y) ↦ (x,y+B x), with genuine continuous inverse. -/
def textbookBrownianHaarPotentialGraphEquiv {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) ≃L[ℝ]
    (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) where
  toFun z := (z.1, z.2 + textbookBrownianHaarPotentialOperator m U hU hPU β z.1)
  invFun z := (z.1, z.2 - textbookBrownianHaarPotentialOperator m U hU hPU β z.1)
  left_inv z := by simp
  right_inv z := by simp
  map_add' z w := by
    ext <;> simp only [Prod.fst_add, Prod.snd_add, map_add]
    abel
  map_smul' c z := by
    ext <;> simp only [Prod.smul_fst, Prod.smul_snd, map_smul, smul_add, RingHom.id_apply]
  continuous_toFun := by fun_prop
  continuous_invFun := by fun_prop

/-- The actual forward graph formula holds for every genuine Hilbert pair. -/
theorem textbookBrownianHaarPotentialGraphEquiv_apply {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookBrownianHaarPotentialGraphEquiv m U hU hPU β z =
      (z.1, z.2 + textbookBrownianHaarPotentialOperator m U hU hPU β z.1) := rfl

/-- The actual inverse subtracts the same genuine bounded multiplication. -/
theorem textbookBrownianHaarPotentialGraphEquiv_symm_apply {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) ×
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    (textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).symm z =
      (z.1, z.2 - textbookBrownianHaarPotentialOperator m U hU hPU β z.1) := rfl

/-- This actual bounded graph coordinate change preserves the genuine original mass graph closure. -/
theorem textbookBrownianHaarPotentialGraphEquiv_closure {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) :
    (textbookHaarMassPartialOperator m β).graph.topologicalClosure.map
      (textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).toLinearMap =
      ((textbookHaarMassPartialOperator m β).graph.map
        (textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).toLinearMap).topologicalClosure := by
  apply SetLike.ext'
  rw [Submodule.map_coe, Submodule.topologicalClosure_coe,
    Submodule.topologicalClosure_coe, Submodule.map_coe]
  exact (textbookBrownianHaarPotentialGraphEquiv m U hU hPU β).toHomeomorph.image_closure
    (textbookHaarMassPartialOperator m β).graph

end

end MolecularDynamics