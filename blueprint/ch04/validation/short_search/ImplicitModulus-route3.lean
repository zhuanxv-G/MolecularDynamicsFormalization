import MolecularDynamics.Chapter04.Statements
import Mathlib.LinearAlgebra.Matrix.ToLinearEquiv
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04Short
set_option maxHeartbeats 400000
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
  intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by simp
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr
end MD.Ch04Short
