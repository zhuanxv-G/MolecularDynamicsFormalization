import MolecularDynamics.Chapter03.Statements
import MolecularDynamics.Chapter02.ReviewProofs
import Mathlib.Tactic

open Set Filter Matrix
open scoped BigOperators Topology
noncomputable section
namespace MolecularDynamics.Chapter03Review
open MolecularDynamics.Chapter02Review

theorem oscillatorEnergyFailure_proved : oscillatorEnergyFailure_statement := by
  norm_num [oscillatorEnergyFailure_statement, oscillatorEnergy, oscillatorAdjointEuler]

theorem oscillatorShadowInvariant_proved : oscillatorShadowInvariant_statement := by
  intro Ω h z
  simp only [oscillatorAdjointEuler, oscillatorShadow]
  ring

theorem equalEulerIntegral_proved : equalEulerIntegral_statement := by
  intro f h z
  simp only [equalComponentIntegral]
  ring

theorem linearEulerIntegral_proved : linearEulerIntegral_statement := by
  intro n b f hf h z
  simp [hf]

theorem linearRKIntegral_proved : linearRKIntegral_statement := by
  intro n s ℓ f hf A b h z w F hRK
  rw [hRK.2]
  have hF : ∀ i, ℓ (F i)=0 := fun i => by rw [hRK.1 i]; exact hf _
  simp [map_sum, hF]

theorem projectionEnergy_proved : projectionEnergy_statement := by
  intro E K U hK hU
  have hx : 0 ≤ (E-U)/K := div_nonneg (sub_nonneg.mpr hU) hK.le
  unfold projectionConstraint projectionFactor
  rw [Real.sq_sqrt hx]
  field_simp
  ring

theorem mechanicalReversal_proved : mechanicalReversal_statement := by
  intro n m F z
  apply Prod.ext
  · ext i
    simp [mechanicalField, momentumReversal, invMass]
  · simp [mechanicalField, momentumReversal]

theorem collisionDefectZero_proved : collisionDefectZero_statement := by
  intro h tc a b c hc
  rcases hc with hc | hc | hc <;> simp [hc]

theorem coordinateVerlet_reverse {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ)
    (z : SymplecticCoordinates n) : coordinateVerlet m F (-h) (coordinateVerlet m F h z)=z := by
  simp only [coordinateVerlet, Function.comp_apply, neg_div]
  rw [textbookMomentumKick_neg_cancel, textbookPositionDrift_neg_cancel,
    textbookMomentumKick_neg_cancel]

theorem positionVerlet_reverse {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ)
    (z : SymplecticCoordinates n) : positionVerlet m F (-h) (positionVerlet m F h z)=z := by
  simp only [positionVerlet, Function.comp_apply, neg_div]
  rw [textbookPositionDrift_neg_cancel, textbookMomentumKick_neg_cancel,
    textbookPositionDrift_neg_cancel]

theorem verletVariants_proved : verletVariants_statement := by
  intro n m U hU
  refine ⟨?_, coordinateVerlet_reverse m (textbookPotentialForce U),
    positionVerlet_reverse m (textbookPotentialForce U)⟩
  intro h
  exact ⟨(textbookPotentialKick_isSymplectic U (h/2) hU).comp
    ((textbookPositionDrift_isSymplectic m h).comp (textbookPotentialKick_isSymplectic U (h/2) hU)),
    (textbookPositionDrift_isSymplectic m (h/2)).comp
    ((textbookPotentialKick_isSymplectic U h hU).comp (textbookPositionDrift_isSymplectic m (h/2)))⟩

theorem yoshidaPalindrome_reverse {E : Type*} (G : ℝ → E → E)
    (hG : ∀ h z, G (-h) (G h z)=z) (a b h : ℝ) (z : E) :
    yoshidaCompose G a b (-h) (yoshidaCompose G a b h z)=z := by
  simp only [yoshidaCompose, Function.comp_apply, mul_neg]
  rw [hG, hG, hG]

theorem yoshida4Structure_proved : yoshida4Structure_statement := by
  intro n m U hU
  have hs : ∀ h, IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) :=
    fun h => ((verletVariants_proved n m U hU).1 h).1
  refine ⟨?_, ?_⟩
  · intro h
    exact (hs ((yoshidaCoefficients 1).1*h)).comp
      ((hs ((yoshidaCoefficients 1).2*h)).comp (hs ((yoshidaCoefficients 1).1*h)))
  · exact yoshidaPalindrome_reverse _ (coordinateVerlet_reverse m (textbookPotentialForce U)) _ _

theorem rkAffine_proved : rkAffine_statement := by
  intro n s L f A b h z w F hRK
  constructor
  · intro i
    unfold transportedField
    simp only [← map_smul, ← map_sum, ← map_add, L.symm_apply_apply]
    exact congrArg L (hRK.1 i)
  · rw [hRK.2]
    simp only [map_add, map_smul, map_sum]

theorem collisionQuartic_proved : collisionQuartic_statement := by
  intro d a b c R t hR
  have hid : ‖a+t • b+t^2 • c‖^2=
      inner ℝ c c*t^4+2*inner ℝ b c*t^3+(inner ℝ b b+2*inner ℝ a c)*t^2+
        2*inner ℝ a b*t+inner ℝ a a := by
    rw [← real_inner_self_eq_norm_sq]
    simp only [inner_add_left, inner_add_right, real_inner_smul_left, real_inner_smul_right]
    rw [real_inner_comm b a, real_inner_comm c a, real_inner_comm c b]
    ring
  constructor
  · intro heq
    rw [← hid, heq]
    ring
  · intro heq
    have hs : ‖a+t • b+t^2 • c‖^2=R^2 := by rw [hid]; linarith
    nlinarith [norm_nonneg (a+t • b+t^2 • c)]

theorem kineticZero_proved : kineticZero_statement := by
  intro n m p hm
  constructor
  · intro hp
    have hs : ∑ i, p i^2/m i=0 := by unfold kinetic at hp; linarith
    have hi : ∀ i, p i^2/m i=0 := fun i =>
      (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => div_nonneg (sq_nonneg _) (hm i).le)).mp hs
        i (Finset.mem_univ i)
    ext i
    have hz := (div_eq_zero_iff).mp (hi i)
    rcases hz with hz | hz
    · simpa using (sq_eq_zero_iff.mp hz)
    · exact False.elim ((ne_of_gt (hm i)) hz)
  · intro hp
    simp [kinetic, hp]
end MolecularDynamics.Chapter03Review
