import MolecularDynamics.Chapter01.EquilibriumLinearization
import Mathlib.Analysis.Calculus.FDeriv.Symmetric

open Set Filter
open scoped Topology InnerProductSpace
namespace MolecularDynamics

/-- C² potential Hessians are symmetric in the exact second-Frechet sense used by the textbook. -/
theorem potential_hessian_symmetric {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (U : E → ℝ) (x : E) (hU : ContDiffAt ℝ 2 U x) :
    IsSymmSndFDerivAt ℝ U x := by
  exact hU.isSymmSndFDerivAt (by norm_num)

theorem potential_hessian_symmetric_apply {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℝ E] (U : E → ℝ) (x v w : E)
    (hU : ContDiffAt ℝ 2 U x) :
    fderiv ℝ (fderiv ℝ U) x v w = fderiv ℝ (fderiv ℝ U) x w v := by
  exact (potential_hessian_symmetric U x hU) v w

/-- The conservative mechanical linearization has the exact force block `-D(gradient U)`.
The Hessian symmetry is recorded separately and is not assumed by the block derivative. -/
theorem conservative_linearization_hessian_data {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (z₀ : PhaseSpace n)
    (hU : ContDiffAt ℝ 2 U z₀.1) :
    IsSymmSndFDerivAt ℝ U z₀.1 ∧
      HasFDerivAt (mechanicalVectorField m (fun q => -gradient U q))
        (mechanicalLinearization m (-fderiv ℝ (gradient U) z₀.1)) z₀ := by
  exact ⟨potential_hessian_symmetric U z₀.1 hU,
    conservative_mechanical_linearization m U z₀ hU⟩

end MolecularDynamics
#print axioms MolecularDynamics.potential_hessian_symmetric
#print axioms MolecularDynamics.potential_hessian_symmetric_apply
#print axioms MolecularDynamics.conservative_linearization_hessian_data
