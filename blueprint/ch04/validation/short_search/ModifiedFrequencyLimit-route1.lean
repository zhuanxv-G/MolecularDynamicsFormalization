import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.SpecialFunctions.Trigonometric.ArctanDeriv
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04More
set_option maxHeartbeats 400000
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω) := by
  intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num
  simpa [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv,mul_comm] using hd.tendsto_slope_zero
end MD.Ch04More
