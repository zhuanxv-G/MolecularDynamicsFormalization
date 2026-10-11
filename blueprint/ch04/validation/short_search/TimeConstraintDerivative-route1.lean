import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Calculus.Deriv.Slope
import Mathlib.Analysis.SpecialFunctions.Trigonometric.ArctanDeriv
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
namespace MD.Ch04More
set_option maxHeartbeats 400000
theorem timeConstraintDerivative :
  ∀ n l (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0 := by
  intro n l g q t v hg hq hz
  have hd := hg.hasFDerivAt.comp_hasDerivAt t (hq.prodMk (hasDerivAt_id t))
  have hzero : HasDerivAt (fun s => g (q s) s) (0 : Fin l → ℝ) t :=
    (hasDerivAt_const t (0 : Fin l → ℝ)).congr_of_eventuallyEq hz.symm
  exact hd.unique hzero
end MD.Ch04More
