import MolecularDynamics.Chapter06.BrownianSecondVariation
import Mathlib.Analysis.Calculus.FDeriv.Measurable
import Mathlib.Analysis.Calculus.ParametricIntegral

/-! Actual first and second spatial derivatives under the genuine Wiener path
law. The original observable is C2; its expectation regularity is derived. -/

open Set Filter Metric MeasureTheory
open scoped Topology ContDiff NNReal

namespace MolecularDynamics
noncomputable section
variable {N : ℕ} (m : Fin N → ℝ) (hm : ∀ i, 0 < m i)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
  (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
private theorem uniform_endpoint_lipschitz (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ≥0, ∀ t ∈ Icc 0 T, LipschitzWith C
      (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
        textbookBrownianPathEndpoint m hm U hU hp β hβ T hT z.1 t z.2) := by
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let N : ℝ := ‖textbookBrownianSDENoise m β‖
  let K : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hN : 0 ≤ N := norm_nonneg _
  have hK : 0 < K := by dsimp [K]; linarith
  let A : ℝ := 2 * (L * N / K * (Real.exp (K * T) - 1) + N)
  have hA : 0 ≤ A := by
    have : 0 ≤ Real.exp (K * T) - 1 :=
      sub_nonneg.mpr (Real.one_le_exp_iff.mpr (mul_nonneg hK.le hT))
    dsimp [A]
    positivity
  let C : ℝ := Real.exp (K * T) + A
  have hC : 0 ≤ C := add_nonneg (Real.exp_pos _).le hA
  refine ⟨⟨C, hC⟩, fun t ht ↦ LipschitzWith.of_dist_le_mul (fun z w ↦ ?_)⟩
  let q := textbookBrownianPathSolution m hm U hU hp β hβ T hT z.1 z.2
  let r := textbookBrownianPathSolution m hm U hU hp β hβ T hT w.1 w.2
  have hq := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT z.1 z.2
  have hr := textbookBrownianPathSolution_integralSolution m hm U hU hp β hβ T hT w.1 w.2
  have hnoise (s : ℝ) : ‖(textbookLangevinPathNoise T hT z.2 s - textbookLangevinPathNoise T hT z.2 0) -
      (textbookLangevinPathNoise T hT w.2 s - textbookLangevinPathNoise T hT w.2 0)‖ ≤ 2 * dist z.2 w.2 := by
    rw [textbookLangevinPathNoise_zero, textbookLangevinPathNoise_zero, sub_zero, sub_zero]
    let ξ := projIcc 0 T hT s
    let ζ : Icc 0 T := ⟨0, le_rfl, hT⟩
    have he : textbookLangevinPathNoise T hT z.2 s - textbookLangevinPathNoise T hT w.2 s =
        (z.2 ξ - w.2 ξ) - (z.2 ζ - w.2 ζ) := by
      dsimp [textbookLangevinPathNoise, ξ, ζ]
      abel
    have hb (u : Icc 0 T) : ‖z.2 u - w.2 u‖ ≤ dist z.2 w.2 := by
      simpa only [dist_eq_norm] using ContinuousMap.dist_apply_le_dist (f := z.2) (g := w.2) u
    rw [he]
    exact (norm_sub_le _ _).trans ((add_le_add (hb ξ) (hb ζ)).trans_eq (by ring))
  have hb := textbookBrownianIntegralSolution_dist_le m U hU hp β T (2 * dist z.2 w.2) hT
    z.1 w.1 (textbookLangevinPathNoise T hT z.2) (textbookLangevinPathNoise T hT w.2)
    q r hq hr (fun s _ ↦ hnoise s) t ht
  change dist (q t) (r t) ≤
    gronwallBound (dist z.1 w.1) K (L * N * (2 * dist z.2 w.2)) t + N * (2 * dist z.2 w.2) at hb
  rw [gronwallBound_of_K_ne_0 hK.ne'] at hb
  have hxt : Real.exp (K * t) ≤ Real.exp (K * T) :=
    Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hK.le)
  have hz : dist z.1 w.1 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_left _ _
  have hw : dist z.2 w.2 ≤ dist z w := by rw [Prod.dist_eq]; exact le_max_right _ _
  have hat : 2 * (L * N / K * (Real.exp (K * t) - 1) + N) ≤ A := by
    have hcoef : 0 ≤ L * N / K := by positivity
    have hmul := mul_le_mul_of_nonneg_left (sub_le_sub_right hxt 1) hcoef
    dsimp [A]
    linarith
  change dist (q t) (r t) ≤ C * dist z w
  calc
    _ ≤ Real.exp (K * t) * dist z.1 w.1 +
        (2 * (L * N / K * (Real.exp (K * t) - 1) + N)) * dist z.2 w.2 := by
      convert hb using 1
      ring
    _ ≤ Real.exp (K * T) * dist z.1 w.1 + A * dist z.2 w.2 :=
      add_le_add (mul_le_mul_of_nonneg_right hxt (dist_nonneg))
        (mul_le_mul_of_nonneg_right hat (dist_nonneg))
    _ ≤ Real.exp (K * T) * dist z w + A * dist z w :=
      add_le_add (mul_le_mul_of_nonneg_left hz (Real.exp_pos _).le)
        (mul_le_mul_of_nonneg_left hw hA)
    _ = C * dist z w := by dsimp [C]; ring

theorem textbookBrownianPathJacobian_joint_norm_sub_bound (T : ℝ) (hT : 0 ≤ T) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ (z w : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.1 z.2 t -
        textbookBrownianPathJacobian m hm U hU hp β hβ T hT w.1 w.2 t‖ ≤ C * dist z w := by
  obtain ⟨M, hM⟩ := textbookBrownianSDEDrift_fderiv_lipschitz m U hU hp
  let L : ℝ := textbookBrownianDriftLipschitzConstant m U hU hp
  let K : ℝ := 1 + L
  have hL : 0 ≤ L := (textbookBrownianDriftLipschitzConstant m U hU hp).property
  have hK : 0 < K := by dsimp [K]; linarith
  let E : ℝ := Real.exp (K * T)
  obtain ⟨Q, hQ⟩ := uniform_endpoint_lipschitz m hm U hU hp β hβ T hT
  let C : ℝ := (M : ℝ) * Q * E / K * E
  have hC : 0 ≤ C := by dsimp [C]; positivity
  refine ⟨C, hC, fun z w t ht ↦ ?_⟩
  let qx := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT z.1 s z.2
  let qy := fun s ↦ textbookBrownianPathEndpoint m hm U hU hp β hβ T hT w.1 s w.2
  let Jx := textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.1 z.2
  let Jy := textbookBrownianPathJacobian m hm U hU hp β hβ T hT w.1 w.2
  obtain ⟨hJx0, hJx⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT z.1 z.2
  obtain ⟨hJy0, hJy⟩ := textbookBrownianPathJacobian_spec m hm U hU hp β hβ T hT w.1 w.2
  let A := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (qx s)
  let B := fun s ↦ fderiv ℝ (textbookBrownianSDEDrift m U) (qy s)
  let D := fun s ↦ Jx s - Jy s
  let D' := fun s ↦ (A s).comp (Jx s) - (B s).comp (Jy s)
  have hD0 : D 0 = 0 := by dsimp [D, Jx, Jy]; rw [hJx0, hJy0, sub_self]
  have hxc : ContinuousOn Jx (Icc 0 T) := fun s hs ↦ (hJx s hs).continuousAt.continuousWithinAt
  have hyc : ContinuousOn Jy (Icc 0 T) := fun s hs ↦ (hJy s hs).continuousAt.continuousWithinAt
  have hd (s : ℝ) (hs : s ∈ Ico 0 T) : HasDerivWithinAt D (D' s) (Ici s) s := by
    have hh := (hJx s (Ico_subset_Icc_self hs)).sub (hJy s (Ico_subset_Icc_self hs))
    simpa only [D, D', Jx, Jy, A, B, qx, qy, Pi.sub_def] using hh.hasDerivWithinAt
  have hqdiff (s : ℝ) (hs : s ∈ Icc 0 T) : ‖qx s - qy s‖ ≤ (Q : ℝ) * dist z w := by
    have hh := (hQ s hs).dist_le_mul z w
    simpa only [qx, qy, dist_eq_norm] using hh
  have hJyb (s : ℝ) (hs : s ∈ Icc 0 T) : ‖Jy s‖ ≤ E := by
    have hh := textbookBrownianPathJacobian_norm_le m hm U hU hp β hβ T hT w.1 w.2 s hs
    exact hh.trans (Real.exp_le_exp.mpr (calc
      L * s ≤ K * s := mul_le_mul_of_nonneg_right (by dsimp [K]; linarith) hs.1
      _ ≤ K * T := mul_le_mul_of_nonneg_left hs.2 hK.le))
  have hb (s : ℝ) (hs : s ∈ Ico 0 T) :
      ‖D' s‖ ≤ K * ‖D s‖ + (M : ℝ) * Q * E * dist z w := by
    have hsT := Ico_subset_Icc_self hs
    have hAB : ‖A s - B s‖ ≤ (M : ℝ) * Q * dist z w := by
      calc
        _ ≤ (M : ℝ) * ‖qx s - qy s‖ := hM.norm_sub_le _ _
        _ ≤ (M : ℝ) * ((Q : ℝ) * dist z w) := mul_le_mul_of_nonneg_left (hqdiff s hsT) M.property
        _ = (M : ℝ) * Q * dist z w := by ring
    have hDb : ‖A s‖ ≤ L :=
      norm_fderiv_le_of_lipschitz ℝ (textbookBrownianDriftLipschitzConstant_spec m U hU hp)
    have he : D' s = (A s).comp (D s) + (A s - B s).comp (Jy s) := by
      dsimp [D', D]
      rw [ContinuousLinearMap.comp_sub, ContinuousLinearMap.sub_comp]
      abel
    rw [he]
    calc
      _ ≤ ‖(A s).comp (D s)‖ + ‖(A s - B s).comp (Jy s)‖ := norm_add_le _ _
      _ ≤ L * ‖D s‖ + ((M : ℝ) * Q * dist z w) * E :=
        add_le_add ((ContinuousLinearMap.opNorm_comp_le _ _).trans
          (mul_le_mul_of_nonneg_right hDb (norm_nonneg _)))
          ((ContinuousLinearMap.opNorm_comp_le _ _).trans
            (mul_le_mul hAB (hJyb s hsT) (norm_nonneg _) (by positivity)))
      _ ≤ K * ‖D s‖ + ((M : ℝ) * Q * dist z w) * E :=
        add_le_add (mul_le_mul_of_nonneg_right (by dsimp [K]; linarith) (norm_nonneg _)) le_rfl
      _ = K * ‖D s‖ + (M : ℝ) * Q * E * dist z w := by ring
  have hh := norm_le_gronwallBound_of_norm_deriv_right_le (hxc.sub hyc) hd
    (show ‖D 0‖ ≤ 0 by rw [hD0, norm_zero]) hb t ht
  rw [sub_zero, gronwallBound_of_K_ne_0 hK.ne'] at hh
  have heT : Real.exp (K * t) - 1 ≤ E :=
    (sub_le_self _ zero_le_one).trans
      (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 hK.le))
  have hn : 0 ≤ (M : ℝ) * Q * E * dist z w / K := by positivity
  calc
    _ ≤ (M : ℝ) * Q * E * dist z w / K * (Real.exp (K * t) - 1) := by
      simpa only [D, Jx, Jy, Pi.sub_apply, zero_mul, zero_add] using hh
    _ ≤ (M : ℝ) * Q * E * dist z w / K * E := mul_le_mul_of_nonneg_left heT hn
    _ = C * dist z w := by dsimp [C]; ring

/-- The true first variation is continuous jointly in the actual initial state and noise. -/
theorem textbookBrownianPathJacobian_joint_continuous (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.1 z.2 t) := by
  obtain ⟨C, hC, hb⟩ := textbookBrownianPathJacobian_joint_norm_sub_bound m hm U hU hp β hβ T hT
  have hl : LipschitzWith ⟨C, hC⟩
      (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
        textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.1 z.2 t) :=
    LipschitzWith.of_dist_le_mul (fun z w ↦ by rw [dist_eq_norm]; exact hb z w t ht)
  exact hl.continuous

/-- The actual Jacobian is Borel measurable in its original initial state and whole noise path. -/
theorem textbookBrownianPathJacobian_joint_measurable (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.1 z.2 t) :=
  (textbookBrownianPathJacobian_joint_continuous m hm U hU hp β hβ T hT t ht).measurable

/-- The genuine second variation is measurable, by differentiating the true jointly continuous Jacobian. -/
theorem textbookBrownianPathSecondVariation_joint_measurable (T : ℝ) (hT : 0 ≤ T)
    (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT z.1 z.2 t) := by
  let : NormedAddCommGroup ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
    ContinuousLinearMap.toNormedAddCommGroup
  let : NormedSpace ℝ ((Fin N → ℝ) →L[ℝ] (Fin N → ℝ)) :=
    ContinuousLinearMap.toNormedSpace
  let g := fun W : C(Icc 0 T, Fin N → ℝ) ↦
    fun x : Fin N → ℝ ↦ textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t
  have hcJ := textbookBrownianPathJacobian_joint_continuous m hm U hU hp β hβ T hT t ht
  have hcSwap : Continuous (fun z : C(Icc 0 T, Fin N → ℝ) × (Fin N → ℝ) ↦ (z.2, z.1)) :=
    continuous_snd.prodMk continuous_fst
  have hc : Continuous g.uncurry := by
    change Continuous (fun z : C(Icc 0 T, Fin N → ℝ) × (Fin N → ℝ) ↦
      textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.2 z.1 t)
    exact Continuous.comp (g := fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      textbookBrownianPathJacobian m hm U hU hp β hβ T hT z.1 z.2 t)
      (f := fun z : C(Icc 0 T, Fin N → ℝ) × (Fin N → ℝ) ↦ (z.2, z.1)) hcJ hcSwap
  have hd := (measurable_fderiv_with_param ℝ hc).comp
    (measurable_snd.prodMk measurable_fst)
  have he : (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      fderiv ℝ (g z.2) z.1) =
      (fun z ↦ textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT z.1 z.2 t) :=
    funext (fun z ↦ (textbookBrownianPathJacobian_hasFDerivAt_initial
      m hm U hU hp β hβ T hT z.1 z.2 t ht).fderiv)
  change Measurable (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦ fderiv ℝ (g z.2) z.1) at hd
  rw [he] at hd
  exact hd


/-- The original C2 observable transported along the true original path has this actual first derivative. -/
def textbookBrownianC2PathFirstDerivative (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) :
    (Fin N → ℝ) →L[ℝ] ℝ :=
  (fderiv ℝ f (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).comp
    (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t)

/-- The literal second derivative includes both the original observable Hessian and the genuine second variation. -/
def textbookBrownianC2PathSecondDerivative (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) :
    (Fin N → ℝ) →L[ℝ] ((Fin N → ℝ) →L[ℝ] ℝ) :=
  (ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ
    (fderiv ℝ f (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W))).comp
      (textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t) +
  ((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ).flip
    (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t)).comp
      ((fderiv ℝ (fderiv ℝ f) (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).comp
        (textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t))

theorem textbookBrownianC2PathObservable_hasFDerivAt (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    HasFDerivAt (fun y ↦ f (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT y t W))
      (textbookBrownianC2PathFirstDerivative m hm U hU hp β hβ T hT f x W t) x :=
  ((hf.differentiable (by norm_num) (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).hasFDerivAt).comp x
    (textbookBrownianPathEndpoint_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht)

theorem textbookBrownianC2PathFirstDerivative_hasFDerivAt (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f)
    (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    HasFDerivAt (fun y ↦ textbookBrownianC2PathFirstDerivative m hm U hU hp β hβ T hT f y W t)
      (textbookBrownianC2PathSecondDerivative m hm U hU hp β hβ T hT f x W t) x := by
  have hf1 : ContDiff ℝ 1 (fderiv ℝ f) := hf.fderiv_right (by norm_num)
  have hd := ((hf1.differentiable (by norm_num) (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)).hasFDerivAt).comp x
    (textbookBrownianPathEndpoint_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht)
  exact hd.clm_comp (textbookBrownianPathJacobian_hasFDerivAt_initial m hm U hU hp β hβ T hT x W t ht)

theorem textbookBrownianC2PathFirstDerivative_joint_continuous (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      textbookBrownianC2PathFirstDerivative m hm U hU hp β hβ T hT f z.1 z.2 t) := by
  have hq := textbookBrownianPathEndpoint_joint_continuous m hm U hU hp β hβ T hT t ht
  have hj := textbookBrownianPathJacobian_joint_continuous m hm U hU hp β hβ T hT t ht
  exact ((hf.continuous_fderiv (by norm_num)).comp hq).clm_comp hj

theorem textbookBrownianC2PathSecondDerivative_initial_continuous (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f)
    (W : C(Icc 0 T, Fin N → ℝ)) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Continuous (fun x ↦ textbookBrownianC2PathSecondDerivative m hm U hU hp β hβ T hT f x W t) := by
  have hq := textbookBrownianPathEndpoint_initialState_continuous m hm U hU hp β hβ T hT t ht W
  have hj := textbookBrownianPathJacobian_initial_continuous m hm U hU hp β hβ T hT W t ht
  have hk := textbookBrownianPathSecondVariation_initial_continuous m hm U hU hp β hβ T hT W t ht
  have hd := (hf.continuous_fderiv (by norm_num)).comp hq
  have hf1 : ContDiff ℝ 1 (fderiv ℝ f) := hf.fderiv_right (by norm_num)
  have hdd := (hf1.continuous_fderiv (by norm_num)).comp hq
  unfold textbookBrownianC2PathSecondDerivative
  exact ((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ).continuous.comp hd).clm_comp hk |>.add
    (((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ).flip.continuous.comp hj).clm_comp
      (hdd.clm_comp hj))

theorem textbookBrownianC2PathSecondDerivative_joint_measurable (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (t : ℝ) (ht : t ∈ Icc 0 T) :
    Measurable (fun z : (Fin N → ℝ) × C(Icc 0 T, Fin N → ℝ) ↦
      textbookBrownianC2PathSecondDerivative m hm U hU hp β hβ T hT f z.1 z.2 t) := by
  have hq := textbookBrownianPathEndpoint_joint_continuous m hm U hU hp β hβ T hT t ht
  have hj := textbookBrownianPathJacobian_joint_continuous m hm U hU hp β hβ T hT t ht
  have hk := textbookBrownianPathSecondVariation_joint_measurable m hm U hU hp β hβ T hT t ht
  have hd := (hf.continuous_fderiv (by norm_num)).comp hq
  have hf1 : ContDiff ℝ 1 (fderiv ℝ f) := hf.fderiv_right (by norm_num)
  have hdd := (hf1.continuous_fderiv (by norm_num)).comp hq
  have ha := (ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ).continuous.comp hd
  have hb := ((ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ).flip.continuous.comp hj).clm_comp
    (hdd.clm_comp hj)
  have hfirst := (isBoundedBilinearMap_comp).continuous.measurable.comp
    (ha.measurable.prodMk hk)
  exact hfirst.add hb.measurable

private theorem observable_derivative_periodic {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (g : (Fin N → ℝ) → E)
    (hg : ∀ x (n : Fin N → ℤ), g (x + fun i ↦ (n i : ℝ)) = g x)
    (x : Fin N → ℝ) (n : Fin N → ℤ) :
    fderiv ℝ g (x + fun i ↦ (n i : ℝ)) = fderiv ℝ g x := by
  let c : Fin N → ℝ := fun i ↦ (n i : ℝ)
  have he : (fun z ↦ g (z + c)) = g := funext (fun z ↦ hg z n)
  rw [← fderiv_comp_add_right (𝕜 := ℝ) (f := g) (x := x) c, he]

private theorem observable_periodic_bound {E : Type*} [NormedAddCommGroup E]
    (g : (Fin N → ℝ) → E) (hc : Continuous g)
    (hg : ∀ x (n : Fin N → ℤ), g (x + fun i ↦ (n i : ℝ)) = g x) :
    ∃ M : ℝ, 0 ≤ M ∧ ∀ x, ‖g x‖ ≤ M := by
  obtain ⟨M, hb⟩ := isCompact_Icc.exists_bound_of_continuousOn
    (hc.continuousOn : ContinuousOn g (Icc (0 : Fin N → ℝ) 1))
  have h0 : (0 : Fin N → ℝ) ∈ Icc 0 1 := ⟨le_rfl, fun _ ↦ zero_le_one⟩
  refine ⟨M, (norm_nonneg _).trans (hb 0 h0), fun x ↦ ?_⟩
  let a : Fin N → ℝ := fun i ↦ Int.fract (x i)
  let n : Fin N → ℤ := fun i ↦ Int.floor (x i)
  have ha : a ∈ Icc (0 : Fin N → ℝ) 1 :=
    ⟨fun i ↦ Int.fract_nonneg (x i), fun i ↦ (Int.fract_lt_one (x i)).le⟩
  have he : a + (fun i ↦ (n i : ℝ)) = x := funext (fun i ↦ Int.fract_add_floor (x i))
  have hh := hg a n
  rw [he] at hh
  rw [hh]
  exact hb a ha

/-- The three literal jets of an original C2 periodic observable have derived global bounds. -/
theorem textbookUnitPeriodicC2Observable_curried_derivative_bounds
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f) :
    ∃ A B C : ℝ, 0 ≤ A ∧ 0 ≤ B ∧ 0 ≤ C ∧ ∀ x,
      ‖f x‖ ≤ A ∧ ‖fderiv ℝ f x‖ ≤ B ∧ ‖fderiv ℝ (fderiv ℝ f) x‖ ≤ C := by
  have hf1 : ContDiff ℝ 1 (fderiv ℝ f) := hf.fderiv_right (by norm_num)
  have hp1 := observable_derivative_periodic f hpf
  have hp2 := observable_derivative_periodic (fderiv ℝ f) hp1
  obtain ⟨A, hA, ha⟩ := observable_periodic_bound f hf.continuous hpf
  obtain ⟨B, hB, hb⟩ := observable_periodic_bound (fderiv ℝ f) (hf.continuous_fderiv (by norm_num)) hp1
  obtain ⟨C, hC, hc⟩ := observable_periodic_bound (fderiv ℝ (fderiv ℝ f))
    (hf1.continuous_fderiv (by norm_num)) hp2
  exact ⟨A, B, C, hA, hB, hC, fun x ↦ ⟨ha x, hb x, hc x⟩⟩

/-- The actual two observable derivatives are bounded independently of the initial state and the continuous noise. -/
theorem textbookBrownianC2PathDerivative_uniform_bounds (T : ℝ) (hT : 0 ≤ T)
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f) :
    ∃ C D : ℝ, 0 ≤ C ∧ 0 ≤ D ∧ ∀ (x : Fin N → ℝ) (W : C(Icc 0 T, Fin N → ℝ))
      (t : ℝ), t ∈ Icc 0 T →
      ‖textbookBrownianC2PathFirstDerivative m hm U hU hp β hβ T hT f x W t‖ ≤ C ∧
      ‖textbookBrownianC2PathSecondDerivative m hm U hU hp β hβ T hT f x W t‖ ≤ D := by
  obtain ⟨A, B, H, hA, hB, hH, hfbound⟩ := textbookUnitPeriodicC2Observable_curried_derivative_bounds f hf hpf
  obtain ⟨K, hK, hk⟩ := textbookBrownianPathSecondVariation_norm_bound m hm U hU hp β hβ T hT
  let J : ℝ := Real.exp ((textbookBrownianDriftLipschitzConstant m U hU hp : ℝ) * T)
  have hJ : 0 ≤ J := (Real.exp_pos _).le
  refine ⟨B * J, B * K + J * (H * J), mul_nonneg hB hJ,
    add_nonneg (mul_nonneg hB hK) (mul_nonneg hJ (mul_nonneg hH hJ)), fun x W t ht ↦ ?_⟩
  let q := textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W
  let j := textbookBrownianPathJacobian m hm U hU hp β hβ T hT x W t
  let k := textbookBrownianPathSecondVariation m hm U hU hp β hβ T hT x W t
  have hj : ‖j‖ ≤ J := (textbookBrownianPathJacobian_norm_le m hm U hU hp β hβ T hT x W t ht).trans
    (Real.exp_le_exp.mpr (mul_le_mul_of_nonneg_left ht.2 (textbookBrownianDriftLipschitzConstant m U hU hp).property))
  have hk' : ‖k‖ ≤ K := hk x W t ht
  have hd : ‖fderiv ℝ f q‖ ≤ B := (hfbound q).2.1
  have hh : ‖fderiv ℝ (fderiv ℝ f) q‖ ≤ H := (hfbound q).2.2
  have hl : ‖ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ (fderiv ℝ f q)‖ ≤ B := by
    apply ContinuousLinearMap.opNorm_le_bound _ hB
    intro a
    change ‖(fderiv ℝ f q).comp a‖ ≤ B * ‖a‖
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (mul_le_mul_of_nonneg_right hd (norm_nonneg _))
  have hr : ‖(ContinuousLinearMap.compL ℝ (Fin N → ℝ) (Fin N → ℝ) ℝ).flip j‖ ≤ J := by
    apply ContinuousLinearMap.opNorm_le_bound _ hJ
    intro a
    change ‖a.comp j‖ ≤ J * ‖a‖
    exact (ContinuousLinearMap.opNorm_comp_le _ _).trans
      (by simpa only [mul_comm] using mul_le_mul_of_nonneg_left hj (norm_nonneg a))
  constructor
  · exact (ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hd hj (norm_nonneg _) hB)
  · unfold textbookBrownianC2PathSecondDerivative
    exact (norm_add_le _ _).trans (add_le_add
      ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hl hk' (norm_nonneg _) hB))
      ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hr
        ((ContinuousLinearMap.opNorm_comp_le _ _).trans (mul_le_mul hh hj (norm_nonneg _) hH))
        (norm_nonneg _) hJ)))


private theorem actual_finite_expectation_contDiff_two
    (T : ℝ) (hT : 0 ≤ T) (f : (Fin N → ℝ) → ℝ)
    (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f)
    (t : ℝ) (ht : t ∈ Icc 0 T)
    (μ : Measure C(Icc 0 T, Fin N → ℝ)) [IsFiniteMeasure μ] :
    ContDiff ℝ 2 (fun x ↦ ∫ W, f (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W) ∂μ) := by
  obtain ⟨A, B, C, hA, hB, hC, hb⟩ := textbookUnitPeriodicC2Observable_curried_derivative_bounds f hf hpf
  obtain ⟨D, H, hD, hH, hd⟩ := textbookBrownianC2PathDerivative_uniform_bounds m hm U hU hp β hβ T hT f hf hpf
  let F := fun x W ↦ f (textbookBrownianPathEndpoint m hm U hU hp β hβ T hT x t W)
  let G := fun x W ↦ textbookBrownianC2PathFirstDerivative m hm U hU hp β hβ T hT f x W t
  let K := fun x W ↦ textbookBrownianC2PathSecondDerivative m hm U hU hp β hβ T hT f x W t
  have hFc (x : Fin N → ℝ) : Continuous (F x) :=
    hf.continuous.comp (textbookBrownianPathEndpoint_continuous m hm U hU hp β hβ T hT x t ht)
  have hGc (x : Fin N → ℝ) : Continuous (G x) :=
    (textbookBrownianC2PathFirstDerivative_joint_continuous m hm U hU hp β hβ T hT f hf t ht).comp
      (continuous_const.prodMk continuous_id)
  have hKm (x : Fin N → ℝ) : AEStronglyMeasurable (K x) μ :=
    ((textbookBrownianC2PathSecondDerivative_joint_measurable m hm U hU hp β hβ T hT f hf t ht).comp
      (measurable_const.prodMk measurable_id)).stronglyMeasurable.aestronglyMeasurable
  have hFi (x : Fin N → ℝ) : Integrable (F x) μ :=
    (integrable_const A).mono' (hFc x).aestronglyMeasurable
      (Eventually.of_forall (fun W ↦ (hb _).1))
  have hGi (x : Fin N → ℝ) : Integrable (G x) μ :=
    (integrable_const D).mono' (hGc x).aestronglyMeasurable
      (Eventually.of_forall (fun W ↦ (hd x W t ht).1))
  have hFd (x : Fin N → ℝ) :
      HasFDerivAt (fun y ↦ ∫ W, F y W ∂μ) (∫ W, G x W ∂μ) x := by
    apply hasFDerivAt_integral_of_dominated_of_fderiv_le (F' := G) (s := univ)
      (bound := fun _ ↦ D) (by simp)
      (Eventually.of_forall (fun y ↦ (hFc y).aestronglyMeasurable)) (hFi x)
      (hGc x).aestronglyMeasurable
    · exact Eventually.of_forall (fun W y _ ↦ (hd y W t ht).1)
    · exact integrable_const D
    · exact Eventually.of_forall (fun W y _ ↦
        textbookBrownianC2PathObservable_hasFDerivAt m hm U hU hp β hβ T hT f hf y W t ht)
  have hGd (x : Fin N → ℝ) :
      HasFDerivAt (fun y ↦ ∫ W, G y W ∂μ) (∫ W, K x W ∂μ) x := by
    apply hasFDerivAt_integral_of_dominated_of_fderiv_le (F' := K) (s := univ)
      (bound := fun _ ↦ H) (by simp)
      (Eventually.of_forall (fun y ↦ (hGc y).aestronglyMeasurable)) (hGi x) (hKm x)
    · exact Eventually.of_forall (fun W y _ ↦ (hd y W t ht).2)
    · exact integrable_const H
    · exact Eventually.of_forall (fun W y _ ↦
        textbookBrownianC2PathFirstDerivative_hasFDerivAt m hm U hU hp β hβ T hT f hf y W t ht)
  have hKc : Continuous (fun x ↦ ∫ W, K x W ∂μ) :=
    continuous_of_dominated hKm
      (fun x ↦ Eventually.of_forall (fun W ↦ (hd x W t ht).2)) (integrable_const H)
      (Eventually.of_forall (fun W ↦
        textbookBrownianC2PathSecondDerivative_initial_continuous m hm U hU hp β hβ T hT f hf W t ht))
  have hg1 : ContDiff ℝ 1 (fun x ↦ ∫ W, G x W ∂μ) :=
    contDiff_one_iff_hasFDerivAt.mpr ⟨_, hKc, hGd⟩
  exact contDiff_succ_iff_hasFDerivAt.mpr ⟨_, hg1, hFd⟩

variable {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)

include hB in
/-- The expectation of the same original global solution preserves the original C2 observable regularity. -/
theorem textbookBrownianGlobalRandomConfiguration_C2expectation_contDiff_two
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f) (t : ℝ≥0) :
    ContDiff ℝ 2 (fun x ↦
      ∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hp β hβ x B t sample) ∂P) := by
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  let μ := P.map (textbookWienerVectorContinuousPath B (t : ℝ))
  have he : (fun x ↦ ∫ sample, f (textbookBrownianGlobalRandomConfiguration m hm U hU hp β hβ x B t sample) ∂P) =
      (fun x ↦ ∫ W, f (textbookBrownianPathEndpoint m hm U hU hp β hβ t t.property x t W) ∂μ) := by
    funext x
    have hc : Continuous (fun W : C(Icc 0 (t : ℝ), Fin N → ℝ) ↦
        f (textbookBrownianPathEndpoint m hm U hU hp β hβ t t.property x t W)) :=
      hf.continuous.comp (textbookBrownianPathEndpoint_continuous m hm U hU hp β hβ t t.property x t ⟨t.property, le_rfl⟩)
    calc
      _ = ∫ sample, f (textbookBrownianPathEndpoint m hm U hU hp β hβ t t.property x t
          (textbookWienerVectorContinuousPath B (t : ℝ) sample)) ∂P := by
        apply integral_congr_ae
        filter_upwards [textbookBrownianGlobalRandomConfiguration_history_path_ae m hm U hU hp β hβ B P hB x]
          with sample hs
        exact congrArg f (hs t t.property t ⟨t.property, le_rfl⟩)
      _ = _ := (integral_map (textbookWienerVectorContinuousPath_aemeasurable B P hB (t : ℝ))
        hc.aestronglyMeasurable).symm
  rw [he]
  exact actual_finite_expectation_contDiff_two m hm U hU hp β hβ t t.property f hf hpf t
    ⟨t.property, le_rfl⟩ μ

include hB in
/-- The actual torus probability operator, lifted along the original real initial state, preserves C2. -/
theorem textbookBrownianTorusProbabilityOperator_preserves_C2
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f) (t : ℝ≥0) :
    ContDiff ℝ 2 (fun x : Fin N → ℝ ↦
      textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t
        (textbookConfigurationContinuousObservable f hf.continuous hpf)
        (textbookConfigurationTorusProjection x)) := by
  let F := textbookConfigurationContinuousObservable f hf.continuous hpf
  have ht := textbookBrownianTorusContinuousTransition_fixed_horizon m hm U hU hp β hβ B P hB
    (t : ℝ) t.property F ⟨t, t.property, le_rfl⟩
  change textbookBrownianTorusContinuousTransition m hm U hU hp β hβ B P hB t F =
    ∫ W, textbookBrownianTorusObservablePathFlow m hm U hU hp β hβ (t : ℝ) t.property F
      (⟨(t : ℝ), t.property, le_rfl⟩ : Icc 0 (t : ℝ)) W
      ∂P.map (textbookWienerVectorContinuousPath B (t : ℝ)) at ht
  have he : (fun x : Fin N → ℝ ↦
      textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F
        (textbookConfigurationTorusProjection x)) =
      (fun x ↦ ∫ W, f (textbookBrownianPathEndpoint m hm U hU hp β hβ t t.property x t W)
        ∂P.map (textbookWienerVectorContinuousPath B (t : ℝ))) := by
    funext x
    change textbookBrownianTorusContinuousTransition m hm U hU hp β hβ B P hB t F
      (textbookConfigurationTorusProjection x) = _
    rw [ht, ContinuousMap.integral_apply
      (textbookBrownianTorusObservablePathFlow_integrable m hm U hU hp β hβ B P hB
        (t : ℝ) t.property F ⟨t, t.property, le_rfl⟩
)]
    apply integral_congr_ae
    exact Eventually.of_forall (fun W ↦ by
      change F (textbookBrownianTorusPathEndpoint m hm U hU hp β hβ t t.property
        (textbookConfigurationTorusProjection x) t W) = _
      rw [textbookBrownianTorusPathEndpoint_lift m hm U hU hp β hβ t t.property x t ⟨t.property, le_rfl⟩ W]
      exact textbookConfigurationTorusObservable_lift f hpf _)
  change ContDiff ℝ 2 (fun x : Fin N → ℝ ↦
      textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F
        (textbookConfigurationTorusProjection x))
  rw [he]
  have : IsProbabilityMeasure P := hB.gaussian.isProbabilityMeasure
  exact actual_finite_expectation_contDiff_two m hm U hU hp β hβ t t.property f hf hpf t
    ⟨t.property, le_rfl⟩ (P.map (textbookWienerVectorContinuousPath B (t : ℝ)))


include hB in
/-- The same actual probability operator preserves the whole original C2 torus subspace. -/
theorem textbookBrownianTorusProbabilityOperator_preserves_C2_space
    (F : C(UnitAddTorus (Fin N), ℝ)) (hF : F ∈ textbookC2TorusRealSpace N) (t : ℝ≥0) :
    textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F ∈ textbookC2TorusRealSpace N := by
  let g : (Fin N → ℝ) → ℝ := fun x ↦ F (textbookConfigurationTorusProjection x)
  have hg : ContDiff ℝ 2 g := hF
  have hpg : textbookUnitPeriodicPotential g := by
    intro q n
    change F (textbookConfigurationTorusProjection (q + fun i ↦ (n i : ℝ))) =
      F (textbookConfigurationTorusProjection q)
    rw [textbookConfigurationTorusProjection_integer_translate]
  have he : textbookConfigurationContinuousObservable g hg.continuous hpg = F := by
    ext X
    change F (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative X)) = F X
    rw [textbookConfigurationTorusRepresentative_projects]
  change ContDiff ℝ 2 (fun x : Fin N → ℝ ↦
    textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F (textbookConfigurationTorusProjection x))
  rw [← he]
  exact textbookBrownianTorusProbabilityOperator_preserves_C2 m hm U hU hp β hβ B P hB g hg hpg t

include hB in
/-- Each genuine evolved C2 probability image lies in the same actual closed Gibbs generator domain. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2evolved_mem_closed_domain
    (F : C(UnitAddTorus (Fin N), ℝ)) (hF : F ∈ textbookC2TorusRealSpace N) (t : ℝ≥0) :
    textbookBrownianProbabilityGibbsL2Image U hU hp β m hm hβ B P hB t F ∈
      (textbookBrownianGibbsClosedOperator m U hU hp β).domain := by
  apply textbookBrownianGibbsC2Domain_le_closed_domain m U hU hp β hβ.ne'
  apply Submodule.mem_map.mpr
  refine ⟨textbookBrownianTorusProbabilityOperator m hm U hU hp β hβ B P hB t F,
    textbookBrownianTorusProbabilityOperator_preserves_C2_space m hm U hU hp β hβ B P hB F hF t, ?_⟩
  rfl

end
end MolecularDynamics