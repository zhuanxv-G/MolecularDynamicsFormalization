import MolecularDynamics.Chapter01.Hamiltonian
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Topology.Order.IntermediateValue

open Set
open scoped InnerProductSpace

namespace MolecularDynamics

/-- Energy has zero derivative along an existing conservative mechanical solution. -/
theorem mechanical_energy_hasDerivAt_zero {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hγ : IsMechanicalSolutionOn m F Q I γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (t : ℝ) (ht : t ∈ I) :
    HasDerivAt (fun s => massHamiltonian m U (γ s)) 0 t := by
  have hparts := ((isMechanicalSolutionOn_iff_components m F Q I γ hI).1 hγ).2 t ht
  have hq := hparts.1
  have hp := hparts.2
  have hdK : HasDerivAt (fun s => momentumKineticEnergy m (γ s).2)
      (inner ℝ (coordinateVelocity m (γ t).2) (F (γ t).1)) t := by
    simpa [Function.comp_def, InnerProductSpace.toDual_apply_apply] using
      ((hasGradientAt_momentumKineticEnergy m (γ t).2).hasFDerivAt.comp_hasDerivAt t hp)
  have hdU : HasDerivAt (fun s => U (γ s).1)
      (inner ℝ (gradient U (γ t).1) (velocityOperator m (γ t).2)) t := by
    simpa [Function.comp_def, InnerProductSpace.toDual_apply_apply] using
      ((hU (γ t).1 (hγ.1 t ht)).hasGradientAt.hasFDerivAt.comp_hasDerivAt t hq)
  have hzero : inner ℝ (coordinateVelocity m (γ t).2) (F (γ t).1) +
      inner ℝ (gradient U (γ t).1) (velocityOperator m (γ t).2) = 0 := by
    rw [coordinateVelocity_eq_velocityOperator m hm, hF (γ t).1 (hγ.1 t ht)]
    rw [inner_neg_right, real_inner_comm (gradient U (γ t).1) (velocityOperator m (γ t).2)]
    ring
  have hd := hdK.add hdU
  rw [hzero] at hd
  have hfun : (fun s => massHamiltonian m U (γ s)) =
      (fun s => momentumKineticEnergy m (γ s).2) +
      (fun s => U (γ s).1) := by
    funext s
    rfl
  rw [hfun]
  exact hd

/-- On an open connected time interval, the mechanical energy is constant. -/
theorem mechanical_energy_const_on_Ioo {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (γ : ℝ → PhaseSpace n)
    (hm : ∀ i, 0 < m i)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    massHamiltonian m U (γ s) = massHamiltonian m U (γ t) := by
  let E : ℝ → ℝ := fun x => massHamiltonian m U (γ x)
  have hderiv : ∀ x ∈ Ioo a b, HasDerivAt E 0 x := by
    intro x hx
    exact mechanical_energy_hasDerivAt_zero m F U Q (Ioo a b) γ hm isOpen_Ioo
      hγ hU hF x hx
  have hdiff : DifferentiableOn ℝ E (Ioo a b) := by
    intro x hx
    exact (hderiv x hx).differentiableAt.differentiableWithinAt
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo hdiff
    (fun x hx => (hderiv x hx).deriv) hs ht


end MolecularDynamics
