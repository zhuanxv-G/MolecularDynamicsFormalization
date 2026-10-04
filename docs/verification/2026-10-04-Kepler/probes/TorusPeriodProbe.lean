import MolecularDynamics.Chapter01.TorusDensity

namespace MolecularDynamics

theorem harmonicTorusRotation_two_positivePeriod_iff_rational (Ω₀ Ω₁ : ℝ) (hΩ₀ : 0 < Ω₀)
    (θ : HarmonicTorus 2) :
    (∃ T : ℝ, 0 < T ∧ Function.Periodic (fun t => harmonicTorusRotation ![Ω₀, Ω₁] t θ) T) ↔
      ∃ q : ℚ, (q : ℝ) = Ω₁ / Ω₀ := by
  constructor
  · rintro ⟨T, hT, hp⟩
    have hc := (harmonicTorusRotation_periodic_iff_integer ![Ω₀, Ω₁] T θ).mp hp
    obtain ⟨k₀, hk₀⟩ := hc 0
    obtain ⟨k₁, hk₁⟩ := hc 1
    change (k₀ : ℝ) * (2 * Real.pi) = Ω₀ * T at hk₀
    change (k₁ : ℝ) * (2 * Real.pi) = Ω₁ * T at hk₁
    have hkn : (k₀ : ℝ) ≠ 0 := by
      intro hz
      rw [hz, zero_mul] at hk₀
      have hp := mul_pos hΩ₀ hT
      linarith
    have hpi : (2 : ℝ) * Real.pi ≠ 0 := mul_ne_zero (by norm_num) Real.pi_ne_zero
    have hr : Ω₁ / Ω₀ = (k₁ : ℝ) / (k₀ : ℝ) := by
      calc
        _ = (Ω₁ * T) / (Ω₀ * T) := by field_simp [ne_of_gt hΩ₀, ne_of_gt hT]
        _ = ((k₁ : ℝ) * (2 * Real.pi)) / ((k₀ : ℝ) * (2 * Real.pi)) := by rw [hk₀, hk₁]
        _ = _ := by field_simp
    refine ⟨(k₁ : ℚ) / (k₀ : ℚ), ?_⟩
    push_cast
    exact hr.symm
  · rintro ⟨q, hq⟩
    have hden : 0 < (q.den : ℝ) := by exact_mod_cast q.pos
    let T := (2 * Real.pi) * (q.den : ℝ) / Ω₀
    have hT : 0 < T := div_pos (mul_pos (mul_pos (by norm_num) Real.pi_pos) hden) hΩ₀
    refine ⟨T, hT, (harmonicTorusRotation_periodic_iff_integer ![Ω₀, Ω₁] T θ).mpr ?_⟩
    intro j
    fin_cases j
    · refine ⟨(q.den : ℤ), ?_⟩
      change ((q.den : ℤ) : ℝ) * (2 * Real.pi) = Ω₀ * T
      dsimp [T]
      push_cast
      field_simp [ne_of_gt hΩ₀]
    · refine ⟨q.num, ?_⟩
      change (q.num : ℝ) * (2 * Real.pi) = Ω₁ * T
      have hnum : (q.num : ℝ) = (Ω₁ / Ω₀) * (q.den : ℝ) := by
        rw [← hq, Rat.cast_def]
        field_simp
      rw [hnum]
      dsimp [T]
      field_simp [ne_of_gt hΩ₀]

theorem harmonicTorusRotation_two_irrational_no_positivePeriod (Ω₀ Ω₁ : ℝ) (hΩ₀ : 0 < Ω₀)
    (hirr : Irrational (Ω₁ / Ω₀)) (θ : HarmonicTorus 2) :
    ¬ ∃ T : ℝ, 0 < T ∧ Function.Periodic (fun t => harmonicTorusRotation ![Ω₀, Ω₁] t θ) T := by
  intro hp
  exact hirr ((harmonicTorusRotation_two_positivePeriod_iff_rational Ω₀ Ω₁ hΩ₀ θ).mp hp)

theorem harmonicTorusPhase_periodic_of_rotation_periodic {n : ℕ} (Ω J : Fin n → ℝ)
    (θ : HarmonicTorus n) (T : ℝ)
    (hp : Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) :
    Function.Periodic (fun t => harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ)) T := by
  intro t
  exact congrArg (harmonicTorusPhase Ω J) (hp t)

theorem harmonicTorusPhase_periodic_iff_rotation_periodic {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) (θ : HarmonicTorus n) (T : ℝ) :
    Function.Periodic (fun t => harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ)) T ↔
      Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T := by
  constructor
  · intro hp t
    exact harmonicTorusPhase_injective Ω J hΩ hJ (hp t)
  · exact harmonicTorusPhase_periodic_of_rotation_periodic Ω J θ T

theorem harmonicTorusPhase_two_positivePeriod_iff_rational (Ω₀ Ω₁ J₀ J₁ : ℝ)
    (hΩ₀ : 0 < Ω₀) (hΩ₁ : 0 < Ω₁) (hJ₀ : 0 < J₀) (hJ₁ : 0 < J₁)
    (θ : HarmonicTorus 2) :
    (∃ T : ℝ, 0 < T ∧ Function.Periodic
      (fun t => harmonicTorusPhase ![Ω₀, Ω₁] ![J₀, J₁] (harmonicTorusRotation ![Ω₀, Ω₁] t θ)) T) ↔
      ∃ q : ℚ, (q : ℝ) = Ω₁ / Ω₀ := by
  have hΩ : ∀ j : Fin 2, 0 < ![Ω₀, Ω₁] j := by intro j; fin_cases j <;> assumption
  have hJ : ∀ j : Fin 2, 0 < ![J₀, J₁] j := by intro j; fin_cases j <;> assumption
  simp_rw [harmonicTorusPhase_periodic_iff_rotation_periodic ![Ω₀, Ω₁] ![J₀, J₁] hΩ hJ θ]
  exact harmonicTorusRotation_two_positivePeriod_iff_rational Ω₀ Ω₁ hΩ₀ θ

theorem harmonicTorusPhase_two_irrational_no_positivePeriod (Ω₀ Ω₁ J₀ J₁ : ℝ)
    (hΩ₀ : 0 < Ω₀) (hΩ₁ : 0 < Ω₁) (hJ₀ : 0 < J₀) (hJ₁ : 0 < J₁)
    (hirr : Irrational (Ω₁ / Ω₀)) (θ : HarmonicTorus 2) :
    ¬ ∃ T : ℝ, 0 < T ∧ Function.Periodic
      (fun t => harmonicTorusPhase ![Ω₀, Ω₁] ![J₀, J₁] (harmonicTorusRotation ![Ω₀, Ω₁] t θ)) T := by
  intro hp
  exact hirr ((harmonicTorusPhase_two_positivePeriod_iff_rational Ω₀ Ω₁ J₀ J₁ hΩ₀ hΩ₁ hJ₀ hJ₁ θ).mp hp)

#print axioms harmonicTorusRotation_two_positivePeriod_iff_rational
#print axioms harmonicTorusRotation_two_irrational_no_positivePeriod
#print axioms harmonicTorusPhase_periodic_of_rotation_periodic
#print axioms harmonicTorusPhase_periodic_iff_rotation_periodic
#print axioms harmonicTorusPhase_two_positivePeriod_iff_rational
#print axioms harmonicTorusPhase_two_irrational_no_positivePeriod
end MolecularDynamics
