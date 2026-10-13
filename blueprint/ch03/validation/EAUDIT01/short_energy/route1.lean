import MolecularDynamics.Chapter03.ReviewProofs
import Mathlib.Tactic
open Set Filter MolecularDynamics MolecularDynamics.Chapter03Review
open scoped Topology
namespace MD.Ch03EAUDIT
theorem oscillatorEnergyFailure : ∀ Ω h : ℝ, 0 < Ω → h ≠ 0 →
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
    (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2)) ∧
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)=oscillatorEnergy Ω z ↔
    Ω*(z.1+h*z.2)=z.2 ∨ Ω*(z.1+h*z.2)=-z.2) ∧
  (∃ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z) := by
  intro Ω h hΩ hh
  have hh2 : 0 < h^2 := sq_pos_of_ne_zero hh
  have hΩ2 : 0 < Ω^2 := sq_pos_of_ne_zero hΩ.ne'
  have hc : h^2*Ω^2/2 ≠ 0 := (div_pos (mul_pos hh2 hΩ2) (by norm_num : (0 : ℝ)<2)).ne'
  have hdelta : ∀ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
        (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2) := by
    intro z
    simp only [oscillatorEnergy,oscillatorAdjointEuler]
    ring
  refine ⟨hdelta,?_,?_⟩
  · intro z
    rw [← sub_eq_zero,hdelta z,mul_eq_zero]
    simp only [hc,false_or]
    have he : Ω^2*(z.1+h*z.2)^2=(Ω*(z.1+h*z.2))^2 := by ring
    rw [he,sub_eq_zero]
    exact sq_eq_sq_iff_eq_or_eq_neg
  · refine ⟨(1,0),?_⟩
    intro heq
    have hd := hdelta (1,0)
    rw [heq,sub_self] at hd
    norm_num at hd
    have hp : 0 < h^2*Ω^2/2*Ω^2 := mul_pos (div_pos (mul_pos hh2 hΩ2) (by norm_num)) hΩ2
    linarith
end MD.Ch03EAUDIT
