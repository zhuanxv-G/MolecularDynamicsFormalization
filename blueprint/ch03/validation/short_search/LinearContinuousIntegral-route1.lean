import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03ShortMore
set_option maxHeartbeats 400000
theorem linearContinuousIntegral :
    ∀ (n : ℕ) (b : Fin n → ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
      (∀ z, ∑ i, b i*f z i = 0) →
      (∀ t, HasDerivAt γ (f (γ t)) t) →
      ∀ t, (∑ i, b i*γ t i) = ∑ i, b i*γ 0 i := by
  intro n b f γ hbf hγ t
  have hd : ∀ s, HasDerivAt (fun t => ∑ i, b i*γ t i) 0 s := by
    intro s
    simpa only [hbf] using HasDerivAt.fun_sum
      (u := Finset.univ) (fun i _ => ((hasDerivAt_pi.mp (hγ s)) i).const_mul (b i))
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
end MD.Ch03ShortMore
