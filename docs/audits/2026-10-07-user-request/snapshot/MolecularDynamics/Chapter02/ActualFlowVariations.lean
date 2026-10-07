import MolecularDynamics.Chapter02.HamiltonianVariational
import MolecularDynamics.Chapter02.SplittingError
import Mathlib.Analysis.Calculus.FDeriv.Congr

/-!
# Variations of genuine solution families

Printed79/PDF101 and154/PDF176.  The variation is the actual initial-parameter
derivative of a jointly C² family.  Its ODE follows from the real time ODE
and symmetry of the actual mixed second derivative.  No variational equation
is supplied.  Constructing this joint regularity from weaker data and global
solution existence are separate dependencies.
-/

open Set Matrix Filter
open scoped BigOperators Topology Matrix Matrix.Norms.Elementwise

namespace MolecularDynamics

section ActualVariation

variable {E V : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [NormedAddCommGroup V] [NormedSpace ℝ V]

/-- The genuine derivative in the initial parameter direction. -/
noncomputable def textbookSolutionVariation (Φ : ℝ × E → V) (t : ℝ) (x u : E) : V :=
  (fderiv ℝ (fun y => Φ (t, y)) x) u

set_option maxHeartbeats 800000 in
theorem textbookSolutionVariation_hasDerivAt (Φ : ℝ × E → V) (f : V → V)
    (hΦ : ContDiff ℝ 2 Φ) (t : ℝ) (x u : E)
    (hf : DifferentiableAt ℝ f (Φ (t, x)))
    (hODE : ∀ᶠ y in 𝓝 x, HasDerivAt (fun s => Φ (s, y)) (f (Φ (t, y))) t) :
    HasDerivAt (fun s => textbookSolutionVariation Φ s x u)
      ((fderiv ℝ f (Φ (t, x))) (textbookSolutionVariation Φ t x u)) t := by
  have hΦd := hΦ.differentiable (by norm_num)
  have hΦdd := (hΦ.fderiv_right (m := 1) (by norm_num)).differentiable_one
  have hslice (s : ℝ) := (hΦd (s, x)).hasFDerivAt.comp x
    ((hasFDerivAt_const s x).prodMk (hasFDerivAt_id x))
  have hvEq (s : ℝ) : textbookSolutionVariation Φ s x u =
      (fderiv ℝ Φ (s, x)) (0, u) := by
    unfold textbookSolutionVariation
    have hds := hslice s
    simp only [Function.comp_def] at hds
    rw [hds.fderiv]
    rfl
  have heq : (fun y => (fderiv ℝ Φ (t, y)) ((1, 0) : ℝ × E)) =ᶠ[𝓝 x]
      (fun y => f (Φ (t, y))) := by
    filter_upwards [hODE] with y hy
    have hd := (hΦd (t, y)).hasFDerivAt.comp_hasDerivAt t
      ((hasDerivAt_id t).prodMk (hasDerivAt_const t y))
    exact hd.unique hy
  have hβ := ((hΦdd (t, x)).hasFDerivAt.comp x
    ((hasFDerivAt_const t x).prodMk (hasFDerivAt_id x))).clm_apply
      (hasFDerivAt_const ((1, 0) : ℝ × E) x)
  have hrhs := hf.hasFDerivAt.comp x (hslice t)
  have hc := congrArg (fun L : E →L[ℝ] V => L u)
    (hβ.fderiv.symm.trans (heq.fderiv_eq.trans hrhs.fderiv))
  have hcross : (fderiv ℝ (fderiv ℝ Φ) (t, x)) (0, u) (1, 0) =
      (fderiv ℝ f (Φ (t, x))) ((fderiv ℝ Φ (t, x)) (0, u)) := by
    simpa using hc
  have hs : (fderiv ℝ (fderiv ℝ Φ) (t, x)) (1, 0) (0, u) =
      (fderiv ℝ (fderiv ℝ Φ) (t, x)) (0, u) (1, 0) :=
    hΦ.contDiffAt.isSymmSndFDerivAt (by norm_num) (1, 0) (0, u)
  have hd := ((hΦdd (t, x)).hasFDerivAt.comp_hasDerivAt t
    ((hasDerivAt_id t).prodMk (hasDerivAt_const t x))).clm_apply
      (hasDerivAt_const t ((0, u) : ℝ × E))
  have hd' : HasDerivAt (fun s => (fderiv ℝ Φ (s, x)) (0, u))
      ((fderiv ℝ (fderiv ℝ Φ) (t, x)) (1, 0) (0, u)) t := by
    simpa only [Function.comp_def, id_eq, map_zero, add_zero] using hd
  rw [hs, hcross] at hd'
  have heqV : (fun s => textbookSolutionVariation Φ s x u) =
      (fun s => (fderiv ℝ Φ (s, x)) (0, u)) := funext hvEq
  rw [heqV, hvEq]
  exact hd'

end ActualVariation

/-- The real Hamiltonian field derivative is J times the genuine Hessian. -/
theorem textbookHamiltonianVectorField_fderiv_mulVec {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z v : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (fderiv ℝ (textbookHamiltonianVectorField H) z) v =
      (textbookJ Nc * textbookHamiltonianHessian H z) *ᵥ v := by
  have hd := (hH.fderiv_right (m := 1) (by norm_num)).differentiableAt (by norm_num)
  have hF : HasFDerivAt (textbookHamiltonianVectorField H)
      (ContinuousLinearMap.pi fun i => ∑ j,
        textbookJ Nc i j • (fderiv ℝ (fderiv ℝ H) z).flip (Pi.single j 1)) z := by
    apply hasFDerivAt_pi.mpr
    intro i
    change HasFDerivAt (fun y => ∑ j, textbookJ Nc i j * (fderiv ℝ H y) (Pi.single j 1)) _ z
    simpa only [smul_eq_mul, ContinuousLinearMap.comp_zero, zero_add] using
      HasFDerivAt.fun_sum (u := Finset.univ) fun j _ =>
        (hd.hasFDerivAt.clm_apply (hasFDerivAt_const (Pi.single j 1) z)).fun_const_smul
          (textbookJ Nc i j)
  have hv : ∑ j, v j • Pi.single j 1 = v := by
    ext i
    simp [Finset.sum_apply, Pi.single_apply]
  have heval (j : Fin Nc ⊕ Fin Nc) :
      (fderiv ℝ (fderiv ℝ H) z) v (Pi.single j 1) =
        (textbookHamiltonianHessian H z *ᵥ v) j := by
    calc
      _ = (fderiv ℝ (fderiv ℝ H) z) (Pi.single j 1) v :=
        hH.isSymmSndFDerivAt (by norm_num) v (Pi.single j 1)
      _ = (fderiv ℝ (fderiv ℝ H) z) (Pi.single j 1) (∑ k, v k • Pi.single k 1) :=
        congrArg ((fderiv ℝ (fderiv ℝ H) z) (Pi.single j 1)) hv.symm
      _ = _ := by
        simp only [map_sum, map_smul, smul_eq_mul, textbookHamiltonianHessian,
          Matrix.mulVec, dotProduct, mul_comm]
  rw [hF.fderiv, ← Matrix.mulVec_mulVec]
  ext i
  simp only [ContinuousLinearMap.pi_apply, _root_.sum_apply,
    _root_.smul_apply, ContinuousLinearMap.flip_apply, smul_eq_mul,
    Matrix.mulVec, dotProduct, heval]

/-- The actual Jacobian curve satisfies the genuine Hamiltonian variational ODE. -/
theorem textbookHamiltonianFlowJacobian_hasDerivAt {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (t : ℝ) (z : SymplecticCoordinates Nc)
    (hODE : ∀ᶠ y in 𝓝 z, HasDerivAt (fun s => Φ (s, y))
      (textbookHamiltonianVectorField H (Φ (t, y))) t) :
    HasDerivAt (fun s => textbookJacobian (fun y => Φ (s, y)) z)
      (textbookJ Nc * textbookHamiltonianHessian H (Φ (t, z)) *
        textbookJacobian (fun y => Φ (t, y)) z) t := by
  have hf : DifferentiableAt ℝ (textbookHamiltonianVectorField H) (Φ (t, z)) := by
    exact ((contDiffOn_textbookHamiltonianVectorField Set.univ isOpen_univ H
      hH.contDiffOn).differentiableOn (by norm_num) _ (mem_univ _)).differentiableAt
        (univ_mem : Set.univ ∈ 𝓝 (Φ (t, z)))
  apply hasDerivAt_pi.mpr
  intro i
  apply hasDerivAt_pi.mpr
  intro j
  have hv := textbookSolutionVariation_hasDerivAt Φ (textbookHamiltonianVectorField H)
    hΦ t z (Pi.single j 1) hf hODE
  rw [textbookHamiltonianVectorField_fderiv_mulVec H (Φ (t, z))
    (textbookSolutionVariation Φ t z (Pi.single j 1)) hH.contDiffAt] at hv
  simpa only [textbookJacobian_entry, textbookSolutionVariation, Matrix.mul_apply,
    Matrix.mulVec, dotProduct] using hasDerivAt_pi.mp hv i

/-- The true C² joint solution family, with true initial identity, is symplectic
on the whole specified closed interval.  Its variational ODE is derived above. -/
theorem textbookHamiltonianFlow_isSymplectic_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply hamiltonian_flow_isSymplectic_of_variational_equation H (fun t z => Φ (t, z)) τ
  · intro t _
    have hΦ1 : ContDiff ℝ 1 Φ := hΦ.of_le (by norm_num)
    simpa only [Function.comp_def, id_eq] using
      hΦ1.comp (contDiff_const.prodMk contDiff_id)
  · intro t _ z
    exact hH.contDiffAt
  · intro z t ht
    exact (textbookHamiltonianFlowJacobian_hasDerivAt H hH Φ hΦ t z
      (Filter.Eventually.of_forall (hODE t ht))).hasDerivWithinAt
  · exact hinit

/-- The actual Jacobian determinant is one; set-volume transport still needs
the corresponding domain and inverse hypotheses. -/
theorem textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t, y)) z).det = 1 := by
  intro t ht z
  exact (textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit t ht).jacobian_det_eq_one z

end MolecularDynamics
