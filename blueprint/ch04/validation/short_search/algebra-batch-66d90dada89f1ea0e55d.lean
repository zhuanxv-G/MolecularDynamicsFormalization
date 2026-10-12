import MolecularDynamics.Chapter04.Statements
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter04Review
open scoped BigOperators Topology ContDiff Matrix.Norms.Elementwise
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch04ShortExactPlanarRotation
theorem exactPlanarRotation : ∀ (I π : MolecularDynamics.Chapter04Review.V) (i : Fin 3), 0 < I i →
  let γ := fun t : ℝ => MolecularDynamics.Chapter04Review.axisRotation i (-t*π i/I i) *ᵥ π
  γ 0=π ∧ (∀ t,γ t i=π i) ∧
    ∀ t,HasDerivAt γ (MolecularDynamics.Chapter04Review.cross3 (γ t) (Pi.single i (γ t i/I i))) t := by
  intro I π i hI
  dsimp only
  refine ⟨?_,?_,?_⟩
  · fin_cases i <;> ext j <;> fin_cases j <;>
      simp [axisRotation,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
  · intro t
    fin_cases i <;> simp [axisRotation,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
  · intro t
    have ha : HasDerivAt (fun s : ℝ => s*π i/I i) (π i/I i) t := by
      convert ((hasDerivAt_id t).mul_const (π i)).div_const (I i) using 1 <;> simp
    have hc := ha.cos
    have hs := ha.sin
    apply hasDerivAt_pi.mpr
    intro j
    fin_cases i <;> fin_cases j <;>
      simp [axisRotation,cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three,Pi.single_apply,
        neg_div,div_eq_mul_inv,neg_mul,Real.cos_neg,Real.sin_neg] at *
    all_goals solve
      | convert hasDerivAt_const t (π 0) using 1 <;> (try funext x) <;> ring
      | convert hasDerivAt_const t (π 1) using 1 <;> (try funext x) <;> ring
      | convert hasDerivAt_const t (π 2) using 1 <;> (try funext x) <;> ring
      | convert (hc.mul_const (π 0)).sub (hs.mul_const (π 2)) using 1 <;> (try funext x) <;> ring
      | convert (hc.mul_const (π 0)).add (hs.mul_const (π 1)) using 1 <;> (try funext x) <;> ring
      | convert (hc.mul_const (π 1)).add (hs.mul_const (π 2)) using 1 <;> (try funext x) <;> ring
      | convert (hc.mul_const (π 2)).add (hs.mul_const (π 0)) using 1 <;> (try funext x) <;> ring
      | convert (hc.mul_const (π 2)).sub (hs.mul_const (π 1)) using 1 <;> (try funext x) <;> ring
      | convert (hc.mul_const (π 1)).sub (hs.mul_const (π 0)) using 1 <;> (try funext x) <;> ring

end MD.Ch04ShortExactPlanarRotation
