import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03ShortMore
set_option maxHeartbeats 400000
theorem equalComponentFirstIntegral :
    ∃ I : ℝ × ℝ → ℝ, (∀ z, I z = z.1-z.2) ∧
      ∀ (f : ℝ × ℝ → ℝ) (u v : ℝ → ℝ),
        (∀ t, HasDerivAt u (f (u t,v t)) t) →
        (∀ t, HasDerivAt v (f (u t,v t)) t) →
        ∀ t, I (u t,v t) = I (u 0,v 0) := by
  refine ⟨(fun z => z.1-z.2), (fun _ => rfl), ?_⟩
  intro f u v hu hv t
  have hd : ∀ s, HasDerivAt (fun t => u t-v t) 0 s := by
    intro s
    simpa using (hu s).sub (hv s)
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
end MD.Ch03ShortMore
