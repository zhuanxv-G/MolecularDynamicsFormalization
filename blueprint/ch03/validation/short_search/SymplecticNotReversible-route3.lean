import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter Matrix MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology
noncomputable section
namespace MD.Ch03Counter
set_option maxHeartbeats 400000
theorem symplecticNotReversible :
  ∃ (h : ℝ) (z : Z 1),
    canonicalReversal (textbookSymplecticEuler (fun _ : Fin 1 => 1) (fun q => q 0^2/2) h
      (canonicalReversal (textbookSymplecticEuler (fun _ => 1) (fun q => q 0^2/2) h (pack z)))) ≠ pack z := by
  have hf : ∀ q : Q 1, textbookPotentialForce (fun x : Q 1 => x 0^2/2) q = fun i => -q i := by
    intro q
    have hp : HasFDerivAt (fun x : Q 1 => x 0) (ContinuousLinearMap.proj (0 : Fin 1)) q :=
      hasFDerivAt_apply 0 q
    have hd := (hp.pow 2).const_mul (1/2 : ℝ)
    funext i
    fin_cases i
    have heq : (fun x : Q 1 => x 0^2/2) = fun x => (1/2 : ℝ)*x 0^2 := by funext x; ring
    rw [textbookPotentialForce, heq, hd.fderiv]
    simp
  refine ⟨1, ((fun _ => 1), (fun _ => 0)), ?_⟩
  intro he
  have hc := congrFun he (Sum.inr (0 : Fin 1))
  norm_num [textbookSymplecticEuler, Function.comp_apply, textbookMomentumKick,
    textbookPositionDrift, textbookPositionProjection, canonicalReversal, pack, hf] at hc
end MD.Ch03Counter
