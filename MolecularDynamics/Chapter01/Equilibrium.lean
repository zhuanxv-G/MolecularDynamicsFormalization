import MolecularDynamics.Chapter01.PotentialBarriers
import MolecularDynamics.Chapter01.Hamiltonian
import Mathlib.Analysis.Calculus.LocalExtr.Basic

open Set
open scoped InnerProductSpace

namespace MolecularDynamics

/-- A phase point at which the fixed-mass mechanical vector field vanishes. -/
def IsMechanicalEquilibrium {n : ℕ} (m : CoordinateMasses n)
    (F : Force n) (z₀ : PhaseSpace n) : Prop :=
  mechanicalVectorField m F z₀ = 0

/-- A strict potential minimum in an open domain gives the equilibrium state with zero momentum. -/
theorem strictPotentialMin_mechanicalEquilibrium {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hQ : IsOpen Q) (hstrict : IsStrictPotentialMinOn U Q q₀)
    (_hU : DifferentiableAt ℝ U q₀)
    (hF : F q₀ = -gradient U q₀) :
    IsMechanicalEquilibrium m F (q₀, 0) := by
  have hminOn : IsLocalMinOn U Q q₀ := strictOn_isLocalMinOn U Q q₀ hstrict
  have hmin : IsLocalMin U q₀ := hminOn.isLocalMin (hQ.mem_nhds hstrict.1)
  have hfderiv : fderiv ℝ U q₀ = 0 := hmin.fderiv_eq_zero
  have hgrad : gradient U q₀ = 0 := by
    apply (inner_self_eq_zero (𝕜 := ℝ)).mp
    rw [inner_gradient_left, hfderiv]
    simp
  change (velocityOperator m (0 : Momentum n), F q₀) = 0
  rw [hF, hgrad]
  simp

end MolecularDynamics


