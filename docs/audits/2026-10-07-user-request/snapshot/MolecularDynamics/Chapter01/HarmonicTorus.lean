import MolecularDynamics.Chapter01.HarmonicActionAngle
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Angle
import Mathlib.Topology.Instances.AddCircle.DenseSubgroup

open Set
open scoped Topology
namespace MolecularDynamics

abbrev HarmonicTorus (n : ℕ) := Fin n → Real.Angle

noncomputable def harmonicTorusRotation {n : ℕ} (Ω : Fin n → ℝ) (t : ℝ)
    (θ : HarmonicTorus n) : HarmonicTorus n := fun j => θ j - (Ω j * t : ℝ)

theorem harmonicTorusRotation_continuous {n : ℕ} (Ω : Fin n → ℝ) :
    Continuous (fun x : ℝ × HarmonicTorus n => harmonicTorusRotation Ω x.1 x.2) := by
  apply continuous_pi
  intro j
  exact ((continuous_apply j).comp continuous_snd).sub
    (Real.Angle.continuous_coe.comp (continuous_const.mul continuous_fst))

theorem harmonicTorusRotation_add {n : ℕ} (Ω : Fin n → ℝ) (s t : ℝ) (θ : HarmonicTorus n) :
    harmonicTorusRotation Ω (t + s) θ = harmonicTorusRotation Ω t (harmonicTorusRotation Ω s θ) := by
  funext j
  simp [harmonicTorusRotation, mul_add, sub_eq_add_neg, add_comm, add_assoc]

noncomputable def harmonicTorusFlow {n : ℕ} (Ω : Fin n → ℝ) : Flow ℝ (HarmonicTorus n) where
  toFun := harmonicTorusRotation Ω
  cont' := harmonicTorusRotation_continuous Ω
  map_add' t s θ := harmonicTorusRotation_add Ω s t θ
  map_zero' θ := by ext j; simp [harmonicTorusRotation]

theorem harmonicTorusRotation_periodic_iff {n : ℕ} (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n) :
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, (Ω j * T : Real.Angle) = 0 := by
  constructor
  · intro h j
    have hj := congrFun (h 0) j
    simpa [harmonicTorusRotation] using hj
  · intro h t
    funext j
    simp [harmonicTorusRotation, mul_add, h j]

theorem harmonicTorusRotation_periodic_iff_integer {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n) :
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T := by
  rw [harmonicTorusRotation_periodic_iff]
  simp only [Real.Angle.coe_eq_zero_iff, zsmul_eq_mul]

theorem harmonicTorusRotation_integerFrequencies_periodic {n : ℕ}
    (ν : ℝ) (k : Fin n → ℤ) (hν : ν ≠ 0) (θ : HarmonicTorus n) :
    Function.Periodic (fun t => harmonicTorusRotation (fun j => (k j : ℝ) * ν) t θ)
      (2 * Real.pi / ν) := by
  apply (harmonicTorusRotation_periodic_iff_integer _ _ _).mpr
  intro j
  refine ⟨k j, ?_⟩
  field_simp

noncomputable def harmonicTorusPhase {n : ℕ} (Ω J : Fin n → ℝ)
    (θ : HarmonicTorus n) : PhaseSpace n :=
  (WithLp.toLp 2 (fun j => harmonicActionAmplitude (Ω j) (J j) * (θ j).cos),
    WithLp.toLp 2 (fun j => Ω j * harmonicActionAmplitude (Ω j) (J j) * (θ j).sin))

theorem harmonicTorusPhase_continuous {n : ℕ} (Ω J : Fin n → ℝ) :
    Continuous (harmonicTorusPhase Ω J) := by
  unfold harmonicTorusPhase
  apply Continuous.prodMk
  · apply (PiLp.continuous_toLp 2 (fun _ : Fin n => ℝ)).comp
    apply continuous_pi
    intro j
    exact continuous_const.mul (Real.Angle.continuous_cos.comp (continuous_apply j))
  · apply (PiLp.continuous_toLp 2 (fun _ : Fin n => ℝ)).comp
    apply continuous_pi
    intro j
    exact continuous_const.mul (Real.Angle.continuous_sin.comp (continuous_apply j))

theorem harmonicTorusPhase_realAngles {n : ℕ} (Ω J θ : Fin n → ℝ) (j : Fin n) :
    (harmonicTorusPhase Ω J (fun i => (θ i : Real.Angle))).1 j =
      harmonicActionPosition (Ω j) (J j) (θ j) ∧
    (harmonicTorusPhase Ω J (fun i => (θ i : Real.Angle))).2 j =
      harmonicActionVelocity (Ω j) (J j) (θ j) := by
  simp [harmonicTorusPhase, harmonicActionPosition, harmonicActionVelocity]

theorem harmonicTorusPhase_energy {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 ≤ J j) (θ : HarmonicTorus n) (j : Fin n) :
    harmonicScalarEnergy (Ω j) ((harmonicTorusPhase Ω J θ).1 j)
      ((harmonicTorusPhase Ω J θ).2 j) = J j * Ω j := by
  have he := harmonicAction_energy (Ω j) (J j) (θ j).toReal (hΩ j) (hJ j)
  simpa only [harmonicTorusPhase, harmonicActionPosition, harmonicActionVelocity, Real.Angle.cos_toReal,
    Real.Angle.sin_toReal] using he

theorem harmonicTorusPhase_image_fixedEnergy {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) :
    Set.range (harmonicTorusPhase Ω J) =
      {z : PhaseSpace n | ∀ j, harmonicScalarEnergy (Ω j) (z.1 j) (z.2 j) = J j * Ω j} := by
  ext z
  constructor
  · rintro ⟨θ, rfl⟩ j
    exact harmonicTorusPhase_energy Ω J hΩ (fun j => le_of_lt (hJ j)) θ j
  · intro hz
    have hrep : ∀ j, ∃ θ : ℝ, harmonicActionPosition (Ω j) (J j) θ = z.1 j ∧
        harmonicActionVelocity (Ω j) (J j) θ = z.2 j := by
      intro j
      have hn : z.1 j ≠ 0 ∨ z.2 j ≠ 0 := by
        by_contra hc
        push Not at hc
        have hzero : harmonicScalarEnergy (Ω j) (z.1 j) (z.2 j) = 0 := by
          simp [harmonicScalarEnergy, hc.1, hc.2]
        have hej := hz j
        rw [hzero] at hej
        have hp := mul_pos (hJ j) (hΩ j)
        linarith
      obtain ⟨K, θ, hK, hx, hv⟩ := exists_harmonicAction_representation (Ω j) (z.1 j) (z.2 j) (hΩ j) hn
      have he := harmonicAction_energy (Ω j) K θ (hΩ j) (le_of_lt hK)
      rw [hx, hv, hz j] at he
      have hKJ : K = J j := by nlinarith [hΩ j]
      subst K
      exact ⟨θ, hx, hv⟩
    choose θ hx hv using hrep
    refine ⟨fun j => (θ j : Real.Angle), ?_⟩
    apply Prod.ext
    · ext j
      rw [(harmonicTorusPhase_realAngles Ω J θ j).1, hx j]
    · ext j
      rw [(harmonicTorusPhase_realAngles Ω J θ j).2, hv j]

theorem harmonicTorusPhase_rotation_coordinates {n : ℕ} (Ω J : Fin n → ℝ)
    (θ : HarmonicTorus n) (t : ℝ) (j : Fin n) :
    (harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ)).1 j =
      harmonicActionPosition (Ω j) (J j) ((θ j).toReal - Ω j * t) ∧
    (harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ)).2 j =
      harmonicActionVelocity (Ω j) (J j) ((θ j).toReal - Ω j * t) := by
  have ha : harmonicTorusRotation Ω t θ j = (((θ j).toReal - Ω j * t : ℝ) : Real.Angle) := by
    simp [harmonicTorusRotation]
  change harmonicActionAmplitude (Ω j) (J j) * (harmonicTorusRotation Ω t θ j).cos = _ ∧
    Ω j * harmonicActionAmplitude (Ω j) (J j) * (harmonicTorusRotation Ω t θ j).sin = _
  rw [ha]
  simp only [Real.Angle.cos_coe, Real.Angle.sin_coe, harmonicActionPosition, harmonicActionVelocity, and_self]

noncomputable def decoupledHarmonicForce {n : ℕ} (Ω : Fin n → ℝ) (q : Position n) : Position n :=
  WithLp.toLp 2 (fun j => -(Ω j ^ 2) * q j)

theorem harmonicTorusPhase_rotation_isMechanical {n : ℕ} (Ω J : Fin n → ℝ)
    (hΩ : ∀ j, 0 < Ω j) (hJ : ∀ j, 0 < J j) (θ : HarmonicTorus n) :
    IsMechanicalSolutionOn (fun _ => (1 : ℝ)) (decoupledHarmonicForce Ω) univ univ
      (fun t => harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ)) := by
  have heq : (fun t => harmonicTorusPhase Ω J (harmonicTorusRotation Ω t θ)) =
      (fun t => (WithLp.toLp 2 (fun j => harmonicActionPosition (Ω j) (J j) ((θ j).toReal - Ω j * t)),
        WithLp.toLp 2 (fun j => harmonicActionVelocity (Ω j) (J j) ((θ j).toReal - Ω j * t)))) := by
    funext t
    apply Prod.ext
    · ext j
      exact (harmonicTorusPhase_rotation_coordinates Ω J θ t j).1
    · ext j
      exact (harmonicTorusPhase_rotation_coordinates Ω J θ t j).2
  rw [heq, isMechanicalSolutionOn_iff_components _ _ _ _ _ isOpen_univ]
  refine ⟨fun _ _ => mem_univ _, ?_⟩
  intro t ht
  have hs : ∀ j, HasDerivAt
      (fun u => harmonicActionPosition (Ω j) (J j) ((θ j).toReal - Ω j * u))
        (harmonicActionVelocity (Ω j) (J j) ((θ j).toReal - Ω j * t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity (Ω j) (J j) ((θ j).toReal - Ω j * u))
        (-(Ω j ^ 2) * harmonicActionPosition (Ω j) (J j) ((θ j).toReal - Ω j * t)) t := by
    intro j
    simpa only [sub_zero] using harmonicAction_explicit_solution (Ω j) (J j) (θ j).toReal 0 (hΩ j) (hJ j) t
  have hq := (PiLp.hasFDerivAt_toLp (𝕜 := ℝ) 2 _).comp_hasDerivAt t
    (hasDerivAt_pi.mpr (fun j => (hs j).1))
  have hp := (PiLp.hasFDerivAt_toLp (𝕜 := ℝ) 2 _).comp_hasDerivAt t
    (hasDerivAt_pi.mpr (fun j => (hs j).2))
  rw [velocityOperator_unit]
  exact ⟨hq, hp⟩

end MolecularDynamics
