import MolecularDynamics.Chapter01.LocalTrajectories
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Topology.Order.IntermediateValue

open Set

namespace MolecularDynamics

/-- The component of total particle momentum in spatial direction `a`. -/
def totalMomentumCoordinate {N d : ℕ} (p : Momentum (N * d)) (a : Fin d) : ℝ :=
  ∑ i : Fin N, p (particleCoordinateEquiv N d (i, a))

/-- Newton's law gives zero derivative of each total-momentum component when
the corresponding sum of forces vanishes along the configuration domain. -/
theorem totalMomentumCoordinate_hasDerivAt_zero {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (I : Set ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn m F Q I γ)
    (hFsum : ∀ q ∈ Q, ∀ a : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, a)) = 0)
    (a : Fin d) (t : ℝ) (ht : t ∈ I) :
    HasDerivAt (fun s => totalMomentumCoordinate (γ s).2 a) 0 t := by
  have hp := ((isMechanicalSolutionOn_iff_components m F Q I γ hI).1 hγ).2 t ht |>.2
  have hcoords : ∀ i : Fin N,
      HasDerivAt (fun s => (γ s).2 (particleCoordinateEquiv N d (i, a)))
        (F (γ t).1 (particleCoordinateEquiv N d (i, a))) t := by
    intro i
    have hproj : HasFDerivAt
        (fun p : Momentum (N * d) => p (particleCoordinateEquiv N d (i, a)))
        (EuclideanSpace.proj (𝕜 := ℝ) (particleCoordinateEquiv N d (i, a)))
        (γ t).2 :=
      (EuclideanSpace.proj (𝕜 := ℝ) (particleCoordinateEquiv N d (i, a))).hasFDerivAt
    simpa [Function.comp_def] using hproj.comp_hasDerivAt t hp
  have hsum : HasDerivAt
      (fun s => ∑ i : Fin N, (γ s).2 (particleCoordinateEquiv N d (i, a)))
      (∑ i : Fin N, F (γ t).1 (particleCoordinateEquiv N d (i, a))) t := by
    exact HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hcoords i)
  rw [hFsum (γ t).1 (hγ.1 t ht) a] at hsum
  simpa only [totalMomentumCoordinate] using hsum

/-- Every component of total particle momentum is constant on a connected
open interval, provided the total force vanishes there. -/
theorem totalMomentumCoordinate_const_on_Ioo {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c := by
  let P : ℝ → ℝ := fun x => totalMomentumCoordinate (γ x).2 c
  have hderiv : ∀ x ∈ Ioo a b, HasDerivAt P 0 x := by
    intro x hx
    exact totalMomentumCoordinate_hasDerivAt_zero m F Q (Ioo a b) γ
      isOpen_Ioo hγ hFsum c x hx
  have hdiff : DifferentiableOn ℝ P (Ioo a b) := by
    intro x hx
    exact (hderiv x hx).differentiableAt.differentiableWithinAt
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo hdiff
    (fun x hx => (hderiv x hx).deriv) hs ht


end MolecularDynamics
