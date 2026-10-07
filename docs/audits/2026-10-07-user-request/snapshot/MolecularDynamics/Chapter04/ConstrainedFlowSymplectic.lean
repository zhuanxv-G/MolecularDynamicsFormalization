import MolecularDynamics.Chapter04.ConstrainedReactionRegularity
import MolecularDynamics.Chapter02.ActualFlowVariations

/-!
# Genuine constrained-flow preservation of the restricted two-form

Printed154--155/PDF176--177.  The true initial constraints, actual reduced
ODE and constructed reaction give tangency of the actual parameter chart.
Real mixed differentiation and the actual momentum-projection cancellation
then show that the pulled-back standard form is constant in time.
-/

open Set Filter Matrix
open scoped BigOperators Topology

namespace MolecularDynamics

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

private theorem flowChart_hasFDerivAt {Nc : ℕ} (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x) :
    HasFDerivAt (textbookCotangentChart q p)
      (ContinuousLinearMap.pi (Sum.elim
        (fun i => (ContinuousLinearMap.proj i).comp (fderiv ℝ q x))
        (fun i => (ContinuousLinearMap.proj i).comp (fderiv ℝ p x)))) x := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact (hasFDerivAt_apply i (q x)).comp x hq.hasFDerivAt
  · exact (hasFDerivAt_apply i (p x)).comp x hp.hasFDerivAt

private theorem flowChart_fderiv_apply {Nc : ℕ} (q p : E → Fin Nc → ℝ) (x u : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x) :
    (fderiv ℝ (textbookCotangentChart q p) x) u =
      Sum.elim ((fderiv ℝ q x) u) ((fderiv ℝ p x) u) := by
  rw [(flowChart_hasFDerivAt q p x hq hp).fderiv]
  ext (i | i) <;> rfl

private theorem flow_symplectic_map_pullback {Nc : ℕ}
    (Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (hΨ : IsTextbookSymplecticMap Ψ)
    (Z : E → SymplecticCoordinates Nc) (x u v : E) (hZ : DifferentiableAt ℝ Z x) :
    textbookSymplecticForm Nc ((fderiv ℝ (Ψ ∘ Z) x) u) ((fderiv ℝ (Ψ ∘ Z) x) v) =
      textbookSymplecticForm Nc ((fderiv ℝ Z x) u) ((fderiv ℝ Z x) v) := by
  rw [fderiv_comp x (hΨ.1.differentiable_one _) hZ]
  exact (isTextbookSymplecticMap_iff_preserves_form Ψ).mp hΨ |>.2 (Z x)
    ((fderiv ℝ Z x) u) ((fderiv ℝ Z x) v)

/-- The actual potential force and varying finite constraint reaction cancel
in the momentum part of the genuine restricted form derivative. -/
theorem textbookConstrainedAcceleration_pullback_zero {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (ρ : Fin Mc → E → ℝ) (q : E → Fin Nc → ℝ) (x u v : E)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hq : DifferentiableAt ℝ q x) (hρ : ∀ j, DifferentiableAt ℝ (ρ j) x)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) :
    ∑ i : Fin Nc,
      ((fderiv ℝ q x) u i * (fderiv ℝ
        (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) v i -
        (fderiv ℝ (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) u i * (fderiv ℝ q x) v i) = 0 := by
  let F : E → Fin Nc → ℝ := fun y => textbookPotentialForce U (q y)
  let A := textbookMultiConstrainedMomentum Finset.univ γ ρ q F
  have hF : DifferentiableAt ℝ F x :=
    ((contDiff_textbookPotentialForce U hU).differentiable_one (q x)).comp x hq
  have hA := differentiableAt_textbookMultiConstrainedMomentum Finset.univ γ ρ q F x
    hq hF (fun j _ => hγ j) (fun j _ => hρ j)
  have hproj := textbookMultiConstrainedMomentum_preserves_pullback Finset.univ γ ρ q x
    hq (fun j _ => hγ j) (fun j _ => hρ j) (fun j _ => hconstraint j) F hF u v
  have hzero : DifferentiableAt ℝ (fun _ : E => (0 : Fin Nc → ℝ)) x := differentiableAt_const _
  have hcomp : textbookCotangentChart q F =
      textbookMomentumKick (textbookPotentialForce U) 1 ∘
        textbookCotangentChart q (fun _ : E => (0 : Fin Nc → ℝ)) := by
    funext y i
    rcases i with i | i
    · rfl
    · simp [textbookCotangentChart, textbookMomentumKick, textbookPositionProjection, F]
  have hkick := flow_symplectic_map_pullback _ (textbookPotentialKick_isSymplectic U 1 hU)
    (textbookCotangentChart q (fun _ : E => (0 : Fin Nc → ℝ))) x u v
    (flowChart_hasFDerivAt q _ x hq hzero).differentiableAt
  rw [← hcomp] at hkick
  have hform := hproj.trans hkick
  rw [flowChart_fderiv_apply q A x u hq hA, flowChart_fderiv_apply q A x v hq hA,
    flowChart_fderiv_apply q (fun _ : E => (0 : Fin Nc → ℝ)) x u hq hzero,
    flowChart_fderiv_apply q (fun _ : E => (0 : Fin Nc → ℝ)) x v hq hzero,
    textbookSymplecticForm_coordinates, textbookSymplecticForm_coordinates] at hform
  simpa only [Sum.elim_inl, Sum.elim_inr, fderiv_const_apply, _root_.zero_apply, A, F,
    Pi.zero_apply, mul_zero, zero_mul, sub_zero, Finset.sum_const_zero] using hform

private theorem flow_fderiv_fst_apply {Nc : ℕ}
    (Z : E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (x u : E) (hZ : DifferentiableAt ℝ Z x) :
    ((fderiv ℝ Z x) u).1 = (fderiv ℝ (fun y => (Z y).1) x) u := by
  rw [hZ.hasFDerivAt.fst.fderiv]
  rfl

private theorem flow_fderiv_snd_apply {Nc : ℕ}
    (Z : E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (x u : E) (hZ : DifferentiableAt ℝ Z x) :
    ((fderiv ℝ Z x) u).2 = (fderiv ℝ (fun y => (Z y).2) x) u := by
  rw [hZ.hasFDerivAt.snd.fderiv]
  rfl

private theorem flow_curve_deriv_fst {Nc : ℕ}
    (Z : ℝ → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (Z' : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (t : ℝ) (hZ : HasDerivAt Z Z' t) : HasDerivAt (fun s => (Z s).1) Z'.1 t := by
  simpa only [Function.comp_def, ContinuousLinearMap.coe_fst'] using
    (ContinuousLinearMap.fst ℝ (Fin Nc → ℝ) (Fin Nc → ℝ)).hasFDerivAt.comp_hasDerivAt t hZ

private theorem flow_curve_deriv_snd {Nc : ℕ}
    (Z : ℝ → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (Z' : (Fin Nc → ℝ) × (Fin Nc → ℝ))
    (t : ℝ) (hZ : HasDerivAt Z Z' t) : HasDerivAt (fun s => (Z s).2) Z'.2 t := by
  simpa only [Function.comp_def, ContinuousLinearMap.coe_snd'] using
    (ContinuousLinearMap.snd ℝ (Fin Nc → ℝ) (Fin Nc → ℝ)).hasFDerivAt.comp_hasDerivAt t hZ

private theorem flow_massRate_fderiv {Nc : ℕ} (m : Fin Nc → ℝ) (p : E → Fin Nc → ℝ)
    (x u : E) (hp : DifferentiableAt ℝ p x) :
    (fderiv ℝ (fun y => textbookInverseMassMatrix m *ᵥ p y) x) u =
      textbookInverseMassMatrix m *ᵥ ((fderiv ℝ p x) u) := by
  let L := (textbookInverseMassMatrix m).toLin'.toContinuousLinearMap
  have hd := L.hasFDerivAt.comp x hp.hasFDerivAt
  change HasFDerivAt (fun y => textbookInverseMassMatrix m *ᵥ p y)
    (L.comp (fderiv ℝ p x)) x at hd
  rw [hd.fderiv]
  rfl

/-- The actual constrained solution family preserves the pulled-back standard
form on every pair of initial-chart parameter directions, on the entire
closed solution interval.  Retained constraints and variation ODEs are derived. -/
theorem textbookConstrainedFlow_pullback_constant_of_jointC2 {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (Φ : ℝ × E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hdet : ∀ t ∈ Icc 0 τ, ∀ y, (textbookConstraintGram m γ (Φ (t, y)).1).det ≠ 0)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ y, HasDerivAt (fun s => Φ (s, y))
      (textbookConstrainedPhaseVectorField m γ U (Φ (t, y))) t)
    (hpos₀ : ∀ y j, γ j (Φ (0, y)).1 = 0)
    (hhidden₀ : ∀ y j, (fderiv ℝ (γ j) (Φ (0, y)).1)
      (textbookInverseMassMatrix m *ᵥ (Φ (0, y)).2) = 0) (x u v : E) :
    ∀ t ∈ Icc 0 τ,
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) v) =
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) v) := by
  have hγ2 (j : Fin Mc) : ContDiff ℝ 2 (γ j) := (hγ j).of_le (by norm_num)
  have hslice (s : ℝ) : ContDiff ℝ 2 (fun y => Φ (s, y)) := by
    simpa only [Function.comp_def, id_eq] using hΦ.comp (contDiff_const.prodMk contDiff_id)
  have hslice1 (s : ℝ) : ContDiff ℝ 1 (fun y => Φ (s, y)) :=
    (hslice s).of_le (by norm_num)
  have hsd (s : ℝ) : Differentiable ℝ (fun y => Φ (s, y)) :=
    (hslice s).differentiable (by norm_num)
  have hqd (s : ℝ) : Differentiable ℝ (fun y => (Φ (s, y)).1) :=
    fun y => (hsd s y).hasFDerivAt.fst.differentiableAt
  have hpd (s : ℝ) : Differentiable ℝ (fun y => (Φ (s, y)).2) :=
    fun y => (hsd s y).hasFDerivAt.snd.differentiableAt
  have hstay (y : E) := textbookConstrainedODE_cotangent_invariant m γ (textbookPotentialForce U)
    (fun s => (Φ (s, y)).1) (fun s => (Φ (s, y)).2) τ hγ2
    (fun s hs => hdet s hs y)
    (fun s hs => (flow_curve_deriv_fst _ _ s (hODE s hs y)).hasDerivWithinAt)
    (fun s hs => (flow_curve_deriv_snd _ _ s (hODE s hs y)).hasDerivWithinAt)
    (hpos₀ y) (hhidden₀ y)
  let ω : ℝ → ℝ := fun s => ∑ i : Fin Nc,
    ((textbookSolutionVariation Φ s x u).1 i * (textbookSolutionVariation Φ s x v).2 i -
      (textbookSolutionVariation Φ s x u).2 i * (textbookSolutionVariation Φ s x v).1 i)
  have hωd (t : ℝ) (ht : t ∈ Icc 0 τ) : HasDerivAt ω 0 t := by
    let Q : E → Fin Nc → ℝ := fun y => (Φ (t, y)).1
    let P : E → Fin Nc → ℝ := fun y => (Φ (t, y)).2
    let R : E → (Fin Nc → ℝ) × (Fin Nc → ℝ) :=
      fun y => textbookConstrainedPhaseVectorField m γ U (Φ (t, y))
    let ρ : Fin Mc → E → ℝ := fun j y =>
      textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U) (Q y) (P y) j
    have hfield := (contDiffAt_textbookConstrainedPhaseVectorField m γ U (Φ (t, x))
      hU hγ (hdet t ht x)).differentiableAt (by norm_num)
    have hR := hfield.hasFDerivAt.comp x (hsd t x).hasFDerivAt
    have hRd : DifferentiableAt ℝ R x := hR.differentiableAt
    have hRq (w : E) : ((fderiv ℝ R x) w).1 =
        textbookInverseMassMatrix m *ᵥ ((fderiv ℝ P x) w) := by
      rw [flow_fderiv_fst_apply R x w hRd]
      exact flow_massRate_fderiv m P x w (hpd t x)
    have hRp : (fun y => (R y).2) =
        textbookMultiConstrainedMomentum Finset.univ γ ρ Q
          (fun y => textbookPotentialForce U (Q y)) := by
      funext y i
      simp [R, ρ, Q, P, textbookConstrainedPhaseVectorField, textbookMultiConstrainedMomentum,
        textbookConstraintJacobian, Matrix.mulVec, dotProduct, Finset.sum_apply, mul_comm]
    have hQ1 : ContDiffAt ℝ 1 Q x := by
      simpa only [Function.comp_def] using contDiffAt_fst.comp x
        (hslice1 t).contDiffAt
    have hP1 : ContDiffAt ℝ 1 P x := by
      simpa only [Function.comp_def] using contDiffAt_snd.comp x
        (hslice1 t).contDiffAt
    have hrho := contDiffAt_textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U)
      Q P x hγ (contDiff_textbookPotentialForce U hU) hQ1 hP1 (hdet t ht x)
    have hcancel := textbookConstrainedAcceleration_pullback_zero γ U ρ Q x u v hU hγ2
      (hqd t x) (fun j => (contDiffAt_pi.mp hrho j).differentiableAt (by norm_num))
      (fun j => Filter.Eventually.of_forall fun y => (hstay y t ht j).1)
    rw [← hRp] at hcancel
    have hv (w : E) : HasDerivAt (fun s => textbookSolutionVariation Φ s x w)
        ((fderiv ℝ R x) w) t := by
      have h := textbookSolutionVariation_hasDerivAt Φ (textbookConstrainedPhaseVectorField m γ U)
        hΦ t x w hfield (Filter.Eventually.of_forall (hODE t ht))
      have heq : (fderiv ℝ R x) w = (fderiv ℝ (textbookConstrainedPhaseVectorField m γ U)
          (Φ (t, x))) (textbookSolutionVariation Φ t x w) := by
        change (fderiv ℝ (textbookConstrainedPhaseVectorField m γ U ∘
          fun y => Φ (t, y)) x) w = _
        rw [hR.fderiv]
        rfl
      rw [← heq] at h
      exact h
    have hduq := flow_curve_deriv_fst _ _ t (hv u)
    have hdvq := flow_curve_deriv_fst _ _ t (hv v)
    have hdup := flow_curve_deriv_snd _ _ t (hv u)
    have hdvp := flow_curve_deriv_snd _ _ t (hv v)
    have hd := HasDerivAt.fun_sum (u := Finset.univ) fun i _ =>
      ((hasDerivAt_pi.mp hduq i).fun_mul (hasDerivAt_pi.mp hdvp i)).fun_sub
        ((hasDerivAt_pi.mp hdup i).fun_mul (hasDerivAt_pi.mp hdvq i))
    have hqu (w : E) : (textbookSolutionVariation Φ t x w).1 = (fderiv ℝ Q x) w :=
      flow_fderiv_fst_apply (fun y => Φ (t, y)) x w (hsd t x)
    have hpu (w : E) : (textbookSolutionVariation Φ t x w).2 = (fderiv ℝ P x) w :=
      flow_fderiv_snd_apply (fun y => Φ (t, y)) x w (hsd t x)
    have hz : (∑ i : Fin Nc,
        (((fderiv ℝ R x) u).1 i * (textbookSolutionVariation Φ t x v).2 i +
          (textbookSolutionVariation Φ t x u).1 i * ((fderiv ℝ R x) v).2 i -
          (((fderiv ℝ R x) u).2 i * (textbookSolutionVariation Φ t x v).1 i +
            (textbookSolutionVariation Φ t x u).2 i * ((fderiv ℝ R x) v).1 i))) = 0 := by
      simp only [hqu, hpu, hRq, textbookInverseMassMatrix, Matrix.mulVec_diagonal]
      calc
        _ = ∑ i : Fin Nc, ((fderiv ℝ Q x) u i * ((fderiv ℝ R x) v).2 i -
            ((fderiv ℝ R x) u).2 i * (fderiv ℝ Q x) v i) := by
          apply Finset.sum_congr rfl
          intro i _
          ring
        _ = 0 := by
          simpa only [flow_fderiv_snd_apply R x u hRd, flow_fderiv_snd_apply R x v hRd] using hcancel
    simpa only [hz] using hd
  have hωconst : ∀ t ∈ Icc 0 τ, ω t = ω 0 := by
    apply constant_of_has_deriv_right_zero
      (fun t ht => (hωd t ht).hasDerivWithinAt.continuousWithinAt)
    intro t ht
    exact (hωd t (mem_Icc_of_Ico ht)).hasDerivWithinAt.mono_of_mem_nhdsWithin
      (Icc_mem_nhdsGE_of_mem ht)
  have hωeq (s : ℝ) : ω s = textbookSymplecticForm Nc
      ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (s, y)).1) (fun y => (Φ (s, y)).2)) x) u)
      ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (s, y)).1) (fun y => (Φ (s, y)).2)) x) v) := by
    rw [flowChart_fderiv_apply _ _ x u (hqd s x) (hpd s x),
      flowChart_fderiv_apply _ _ x v (hqd s x) (hpd s x), textbookSymplecticForm_coordinates]
    simp only [ω, textbookSolutionVariation, Sum.elim_inl, Sum.elim_inr,
      flow_fderiv_fst_apply (fun y => Φ (s, y)) x u (hsd s x),
      flow_fderiv_fst_apply (fun y => Φ (s, y)) x v (hsd s x),
      flow_fderiv_snd_apply (fun y => Φ (s, y)) x u (hsd s x),
      flow_fderiv_snd_apply (fun y => Φ (s, y)) x v (hsd s x)]
  intro t ht
  rw [← hωeq t, ← hωeq 0]
  exact hωconst t ht

/-- Physical positive mass and actual independent constraint gradients remove
the separate Gram inverse condition from the constrained-flow form theorem. -/
theorem textbookConstrainedFlow_pullback_constant_of_mass_and_independence {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (Φ : ℝ × E → (Fin Nc → ℝ) × (Fin Nc → ℝ)) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 3 (γ j))
    (hind : ∀ t ∈ Icc 0 τ, ∀ y,
      LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) (Φ (t, y)).1))
    (hODE : ∀ t ∈ Icc 0 τ, ∀ y, HasDerivAt (fun s => Φ (s, y))
      (textbookConstrainedPhaseVectorField m γ U (Φ (t, y))) t)
    (hpos₀ : ∀ y j, γ j (Φ (0, y)).1 = 0)
    (hhidden₀ : ∀ y j, (fderiv ℝ (γ j) (Φ (0, y)).1)
      (textbookInverseMassMatrix m *ᵥ (Φ (0, y)).2) = 0) (x u v : E) :
    ∀ t ∈ Icc 0 τ,
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (t, y)).1) (fun y => (Φ (t, y)).2)) x) v) =
      textbookSymplecticForm Nc
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) u)
        ((fderiv ℝ (textbookCotangentChart (fun y => (Φ (0, y)).1) (fun y => (Φ (0, y)).2)) x) v) :=
  textbookConstrainedFlow_pullback_constant_of_jointC2 m γ U Φ hΦ τ hU hγ
    (fun t ht y => textbookConstraintGram_det_ne_zero m γ (Φ (t, y)).1 hm (hind t ht y))
    hODE hpos₀ hhidden₀ x u v

end MolecularDynamics
