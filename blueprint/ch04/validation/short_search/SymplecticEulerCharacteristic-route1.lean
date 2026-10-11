import MolecularDynamics.Chapter04.Statements
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Short
set_option maxHeartbeats 400000
theorem symplecticEulerCharacteristic :
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1 := by
  intro Ω h rho
  simp [MolecularDynamics.Chapter04Review.symplecticEulerMatrix, Matrix.det_fin_two]
  push_cast
  ring
end MD.Ch04Short
