import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff
noncomputable section
namespace MD.Ch03ShortMore
set_option maxHeartbeats 400000
theorem reversedTrajectory :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
  intro n R f γ hR hrev hγ t
  simpa only [Function.comp_apply, neg_one_smul, map_neg, hrev, neg_neg] using
    R.hasFDerivAt.comp_hasDerivAt t ((hγ (-t)).comp_hasDerivAt t (hasDerivAt_neg t))
end MD.Ch03ShortMore
