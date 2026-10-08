import MolecularDynamics.Chapter02.Statements
import Mathlib.Tactic

open Set Filter Matrix
open scoped BigOperators Topology
noncomputable section
namespace MolecularDynamics.Chapter02Review

theorem wedgeSelf_proved : wedgeSelf_statement := by
  intro n α u v
  simp only [textbookWedgeOneForms_apply]
  ring

theorem errorDifference_proved : errorDifference_statement := by
  intro n G F γ h k hk
  rw [oneStepIterate_succ, hk]

theorem verletSymplectic_proved : verletSymplectic_statement := by
  intro n m U h hU
  exact (textbookPotentialKick_isSymplectic U (h/2) hU).comp
    ((textbookPositionDrift_isSymplectic m h).comp
      (textbookPotentialKick_isSymplectic U (h/2) hU))

theorem velocityVerletStormer_proved : velocityVerletStormer_statement := by
  intro n m F h a b c hb hc
  subst c
  subst b
  ext i
  simp only [velocityVerlet, invMass, Pi.add_apply,
    Pi.sub_apply, Pi.smul_apply, smul_eq_mul]
  ring

theorem newmarkReduction_proved : newmarkReduction_statement := by
  intro n m F h z w
  constructor
  · intro hw
    rcases hw with ⟨hp,hq⟩
    apply Prod.ext
    · simpa [verlet, div_eq_mul_inv] using hq
    · rw [hp]
      have hq' : w.1 = (verlet m F h z).1 := by simpa [verlet, div_eq_mul_inv] using hq
      rw [hq']
      ext i
      simp [verlet]
      ring
  · intro hw
    subst w
    constructor
    · ext i
      simp [verlet]
      ring
    · simp [verlet, div_eq_mul_inv]

theorem explicitRKNotSymplectic_proved : explicitRKNotSymplectic_statement := by
  intro s A b hA hb hsym
  have hzero (i : Fin s) : b i = 0 := by
    have hi := hsym i i
    rw [hA i i le_rfl] at hi
    nlinarith
  have hsum : (∑ i, b i) = 0 := by simp [hzero]
  linarith

theorem eulerVolumeCounterexample_proved : eulerVolumeCounterexample_statement := by
  refine ⟨!![(0 : ℝ), 1; -1, 0], ?_, ?_⟩
  · simp [Matrix.trace, Matrix.diag, Fin.sum_univ_two]
  · intro h hh heq
    have hd : (linearEuler !![(0 : ℝ), 1; -1, 0] h).det = 1+h^2 := by
      simp [linearEuler, Matrix.det_fin_two]
      ring
    rw [hd] at heq
    have : h^2 = 0 := by linarith
    exact hh (sq_eq_zero_iff.mp this)

theorem kineticPotentialComposition_proved : kineticPotentialComposition_statement := by
  intro n m U h
  constructor
  · rfl
  · funext z
    exact (textbookAdjointSymplecticEuler_apply m U h z).symm

theorem coordinateVerlet_eq_pack {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ)
    (z : SymplecticCoordinates n) :
    coordinateVerlet m F h z = pack (verlet m F h (unpack z)) := by
  have hq : textbookPositionProjection n
      (textbookPositionDrift m h (textbookMomentumKick F (h/2) z)) =
      (verlet m F h (unpack z)).1 := by
    funext i
    simp [textbookPositionProjection, textbookPositionDrift, textbookMomentumKick,
      verlet, unpack, invMass, Function.comp_def]
    ring
  funext i
  rcases i with i | i
  · simp [coordinateVerlet, pack, verlet, unpack, invMass, textbookMomentumKick,
      textbookPositionDrift, textbookPositionProjection, Function.comp_def]
    ring
  · change z (Sum.inr i) + h/2 * F (textbookPositionProjection n z) i +
        h/2 * F (textbookPositionProjection n
          (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))) i = _
    rw [hq]
    simp [pack, verlet, unpack, textbookPositionProjection, Function.comp_def]
    ring

theorem verletComposition_proved : verletComposition_statement := by
  intro n m U h z
  constructor
  · exact coordinateVerlet_eq_pack m _ h z
  · rw [textbookAdjointSymplecticEuler_apply]
    have hd : textbookPositionDrift m (h/2)
        (textbookPositionDrift m (h/2) (textbookMomentumKick (textbookPotentialForce U) (h/2) z)) =
        textbookPositionDrift m h (textbookMomentumKick (textbookPotentialForce U) (h/2) z) := by
      funext i
      rcases i with i | i <;> simp [textbookPositionDrift]
      ring
    change textbookMomentumKick _ (h/2) _ = textbookMomentumKick _ (h/2) _
    exact congrArg (textbookMomentumKick (textbookPotentialForce U) (h/2)) hd.symm

end MolecularDynamics.Chapter02Review
