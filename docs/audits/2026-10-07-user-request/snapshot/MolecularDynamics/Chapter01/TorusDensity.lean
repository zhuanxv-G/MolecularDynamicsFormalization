import MolecularDynamics.Chapter01.HarmonicTorus
import Mathlib.Topology.Instances.AddCircle.Real

open Set
open scoped Topology
namespace MolecularDynamics

theorem harmonicTorusRotation_two_dense_zero (Ω₀ Ω₁ : ℝ) (hΩ₀ : Ω₀ ≠ 0)
    (hirr : Irrational (Ω₁ / Ω₀)) :
    DenseRange (fun t : ℝ => harmonicTorusRotation ![Ω₀, Ω₁] t (0 : HarmonicTorus 2)) := by
  intro θ
  let x := (θ 0).toReal
  let a := -Ω₁ * (2 * Real.pi) / Ω₀
  have hpi : (2 : ℝ) * Real.pi ≠ 0 := mul_ne_zero (by norm_num) Real.pi_ne_zero
  have ha : a / (2 * Real.pi) = -(Ω₁ / Ω₀) := by
    dsimp [a]
    field_simp
  have hd : DenseRange (fun k : ℤ => k • (a : Real.Angle)) := by
    apply AddCircle.denseRange_zsmul_coe_iff.mpr
    rw [ha]
    exact hirr.neg
  let c : Real.Angle := ((Ω₁ * x / Ω₀ : ℝ) : Real.Angle)
  have hsurj : Function.Surjective (fun y : Real.Angle => c + y) := by
    intro y
    exact ⟨y - c, by abel⟩
  have hcont : Continuous (fun y : Real.Angle => c + y) := by fun_prop
  have hshift : DenseRange (fun k : ℤ => c + k • (a : Real.Angle)) :=
    hsurj.denseRange.comp hd hcont
  have hf : Continuous (fun y : Real.Angle => ![θ 0, y]) := by
    apply continuous_pi
    intro j
    fin_cases j
    · exact continuous_const
    · exact continuous_id
  have hsample : ∀ k : ℤ, harmonicTorusRotation ![Ω₀, Ω₁]
      ((-x + (k : ℝ) * (2 * Real.pi)) / Ω₀) (0 : HarmonicTorus 2) =
      ![θ 0, c + k • (a : Real.Angle)] := by
    intro k
    have hfirst : -(Ω₀ * ((-x + (k : ℝ) * (2 * Real.pi)) / Ω₀)) =
        x - (k : ℝ) * (2 * Real.pi) := by field_simp; ring
    have hsecond : -(Ω₁ * ((-x + (k : ℝ) * (2 * Real.pi)) / Ω₀)) =
        Ω₁ * x / Ω₀ + (k : ℝ) * a := by dsimp [a]; field_simp; ring
    funext j
    fin_cases j
    · change (0 : Real.Angle) - (↑(Ω₀ * ((-x + (k : ℝ) * (2 * Real.pi)) / Ω₀)) : Real.Angle) = θ 0
      rw [zero_sub, ← Real.Angle.coe_neg, hfirst, Real.Angle.coe_sub,
        Real.Angle.intCast_mul_eq_zsmul, Real.Angle.coe_two_pi, smul_zero, sub_zero]
      exact Real.Angle.coe_toReal (θ 0)
    · change (0 : Real.Angle) - (↑(Ω₁ * ((-x + (k : ℝ) * (2 * Real.pi)) / Ω₀)) : Real.Angle) = c + k • (a : Real.Angle)
      rw [zero_sub, ← Real.Angle.coe_neg, hsecond, Real.Angle.coe_add, Real.Angle.intCast_mul_eq_zsmul]
  have hmem : ![θ 0, θ 1] ∈ closure (range (fun t : ℝ =>
      harmonicTorusRotation ![Ω₀, Ω₁] t (0 : HarmonicTorus 2))) :=
      map_mem_closure (f := fun y : Real.Angle => ![θ 0, y])
        (s := range (fun k : ℤ => c + k • (a : Real.Angle)))
        (x := θ 1) hf (hshift (θ 1)) (by
    rintro y ⟨k, rfl⟩
    exact ⟨(-x + (k : ℝ) * (2 * Real.pi)) / Ω₀, hsample k⟩)
  have heq : ![θ 0, θ 1] = θ := by ext j; fin_cases j <;> rfl
  rw [heq] at hmem
  exact hmem

theorem harmonicTorusRotation_two_dense (Ω₀ Ω₁ : ℝ) (hΩ₀ : Ω₀ ≠ 0)
    (hirr : Irrational (Ω₁ / Ω₀)) (θ : HarmonicTorus 2) :
    DenseRange (fun t : ℝ => harmonicTorusRotation ![Ω₀, Ω₁] t θ) := by
  have hd := harmonicTorusRotation_two_dense_zero Ω₀ Ω₁ hΩ₀ hirr
  have hsurj : Function.Surjective (fun η : HarmonicTorus 2 => θ + η) := by
    intro η
    exact ⟨η - θ, by abel⟩
  have hcont : Continuous (fun η : HarmonicTorus 2 => θ + η) := by fun_prop
  have h := hsurj.denseRange.comp hd hcont
  have heq : (fun η : HarmonicTorus 2 => θ + η) ∘
      (fun t => harmonicTorusRotation ![Ω₀, Ω₁] t (0 : HarmonicTorus 2)) =
      (fun t => harmonicTorusRotation ![Ω₀, Ω₁] t θ) := by
    funext t j
    simp [harmonicTorusRotation, sub_eq_add_neg]
  rw [heq] at h
  exact h

theorem harmonicTorusPhase_two_dense_fixedEnergy (Ω₀ Ω₁ J₀ J₁ : ℝ)
    (hΩ₀ : 0 < Ω₀) (hΩ₁ : 0 < Ω₁) (hJ₀ : 0 < J₀) (hJ₁ : 0 < J₁)
    (hirr : Irrational (Ω₁ / Ω₀)) (θ : HarmonicTorus 2) :
    ∀ z : PhaseSpace 2, (∀ j, harmonicScalarEnergy (![Ω₀, Ω₁] j) (z.1 j) (z.2 j) =
      ![J₀, J₁] j * ![Ω₀, Ω₁] j) →
      z ∈ closure (range (fun t => harmonicTorusPhase ![Ω₀, Ω₁] ![J₀, J₁]
        (harmonicTorusRotation ![Ω₀, Ω₁] t θ))) := by
  intro z hz
  have hΩ : ∀ j : Fin 2, 0 < ![Ω₀, Ω₁] j := by intro j; fin_cases j <;> assumption
  have hJ : ∀ j : Fin 2, 0 < ![J₀, J₁] j := by intro j; fin_cases j <;> assumption
  have hrange := harmonicTorusPhase_image_fixedEnergy ![Ω₀, Ω₁] ![J₀, J₁] hΩ hJ
  obtain ⟨η, rfl⟩ : z ∈ range (harmonicTorusPhase ![Ω₀, Ω₁] ![J₀, J₁]) := by
    rw [hrange]
    exact hz
  exact map_mem_closure (harmonicTorusPhase_continuous ![Ω₀, Ω₁] ![J₀, J₁])
    (harmonicTorusRotation_two_dense Ω₀ Ω₁ (ne_of_gt hΩ₀) hirr θ η)
    (by rintro _ ⟨t, rfl⟩; exact ⟨t, rfl⟩)

noncomputable def harmonicTorusThreeResonance (θ : HarmonicTorus 3) : Real.Angle := θ 2 - θ 0 - θ 1

theorem harmonicTorusThreeResonance_rotation (Ω₀ Ω₁ : ℝ) (θ : HarmonicTorus 3) (t : ℝ) :
    harmonicTorusThreeResonance (harmonicTorusRotation ![Ω₀, Ω₁, Ω₀ + Ω₁] t θ) =
      harmonicTorusThreeResonance θ := by
  change (θ 2 - (((Ω₀ + Ω₁) * t : ℝ) : Real.Angle)) -
    (θ 0 - ((Ω₀ * t : ℝ) : Real.Angle)) - (θ 1 - ((Ω₁ * t : ℝ) : Real.Angle)) = θ 2 - θ 0 - θ 1
  rw [add_mul, Real.Angle.coe_add]
  abel

theorem harmonicTorusRotation_three_resonant_not_dense (Ω₀ Ω₁ : ℝ) (θ : HarmonicTorus 3) :
    ¬ DenseRange (fun t : ℝ => harmonicTorusRotation ![Ω₀, Ω₁, Ω₀ + Ω₁] t θ) := by
  intro hd
  have hc : Continuous harmonicTorusThreeResonance :=
    ((continuous_apply 2).sub (continuous_apply 0)).sub (continuous_apply 1)
  have heq := hd.equalizer hc continuous_const
    (funext (fun t => harmonicTorusThreeResonance_rotation Ω₀ Ω₁ θ t))
  have hzero := congrFun heq (0 : HarmonicTorus 3)
  have hpi := congrFun heq ![0, 0, (Real.pi : Real.Angle)]
  have hz : (0 : Real.Angle) = harmonicTorusThreeResonance θ := by
    simpa [harmonicTorusThreeResonance] using hzero
  have hp : (Real.pi : Real.Angle) = harmonicTorusThreeResonance θ := by
    simpa [harmonicTorusThreeResonance] using hpi
  exact Real.Angle.pi_ne_zero (hp.trans hz.symm)

theorem harmonicTorusPhase_injective {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) :
    Function.Injective (harmonicTorusPhase Ω J) := by
  intro θ ψ heq
  funext j
  have hx := congrArg (fun z : PhaseSpace n => z.1 j) heq
  have hv := congrArg (fun z : PhaseSpace n => z.2 j) heq
  have hA := harmonicActionAmplitude_pos (Ω j) (J j) (hΩ j) (hJ j)
  have hc : (θ j).cos = (ψ j).cos := mul_left_cancel₀ (ne_of_gt hA) hx
  have hs : (θ j).sin = (ψ j).sin :=
    mul_left_cancel₀ (mul_ne_zero (ne_of_gt (hΩ j)) (ne_of_gt hA)) hv
  have he := Real.Angle.cos_sin_inj
    (show Real.cos (θ j).toReal = Real.cos (ψ j).toReal by simpa using hc)
    (show Real.sin (θ j).toReal = Real.sin (ψ j).toReal by simpa using hs)
  simpa only [Real.Angle.coe_toReal] using he

theorem harmonicTorusPhase_isClosedEmbedding {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) :
    Topology.IsClosedEmbedding (harmonicTorusPhase Ω J) := by
  let : Fact (0 < 2 * Real.pi) := ⟨mul_pos (by norm_num) Real.pi_pos⟩
  let : CompactSpace Real.Angle := inferInstanceAs (CompactSpace (AddCircle (2 * Real.pi)))
  exact (harmonicTorusPhase_continuous Ω J).isClosedEmbedding (harmonicTorusPhase_injective Ω J hΩ hJ)

theorem exists_harmonicTorusPhase_homeomorph {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) :
    ∃ h : HarmonicTorus n ≃ₜ {z : PhaseSpace n | ∀ j,
        harmonicScalarEnergy (Ω j) (z.1 j) (z.2 j) = J j * Ω j},
      ∀ θ, (h θ : PhaseSpace n) = harmonicTorusPhase Ω J θ := by
  let h := (harmonicTorusPhase_isClosedEmbedding Ω J hΩ hJ).isEmbedding.toHomeomorph.trans
    (Homeomorph.setCongr (harmonicTorusPhase_image_fixedEnergy Ω J hΩ hJ))
  exact ⟨h, fun _ => rfl⟩

end MolecularDynamics
