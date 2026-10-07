import MolecularDynamics.Chapter01.KeplerQuadrature
import MolecularDynamics.Chapter01.HarmonicOscillator
import Mathlib.Analysis.SpecialFunctions.Sqrt

/-! Printed30/PDF53: actual harmonic action-angle representation, ODE equivalence and flow conjugacy.
Positive frequency/action is explicit; angles and inverse charts are local or lifted to real angles. -/

open Set
namespace MolecularDynamics

noncomputable def harmonicActionAmplitude (Ω J : ℝ) : ℝ := Real.sqrt (2 * J / Ω)
noncomputable def harmonicActionPosition (Ω J θ : ℝ) : ℝ :=
  harmonicActionAmplitude Ω J * Real.cos θ
noncomputable def harmonicActionVelocity (Ω J θ : ℝ) : ℝ :=
  Ω * harmonicActionAmplitude Ω J * Real.sin θ
noncomputable def harmonicScalarEnergy (Ω x v : ℝ) : ℝ := v ^ 2 / 2 + Ω ^ 2 * x ^ 2 / 2

theorem harmonicActionAmplitude_pos (Ω J : ℝ) (hΩ : 0 < Ω) (hJ : 0 < J) :
    0 < harmonicActionAmplitude Ω J := by
  exact Real.sqrt_pos.mpr (div_pos (mul_pos (by norm_num) hJ) hΩ)

theorem harmonicActionVelocity_formula (Ω J θ : ℝ) (hΩ : 0 < Ω) :
    harmonicActionVelocity Ω J θ = Real.sqrt (2 * J * Ω) * Real.sin θ := by
  have heq : 2 * J * Ω = Ω ^ 2 * (2 * J / Ω) := by
    field_simp [ne_of_gt hΩ]
  unfold harmonicActionVelocity harmonicActionAmplitude
  rw [heq, Real.sqrt_mul (sq_nonneg Ω), Real.sqrt_sq (le_of_lt hΩ)]

theorem harmonicAction_energy (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J) :
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω := by
  have hs : (harmonicActionAmplitude Ω J) ^ 2 = 2 * J / Ω :=
    Real.sq_sqrt (div_nonneg (mul_nonneg (by norm_num) hJ) (le_of_lt hΩ))
  unfold harmonicScalarEnergy harmonicActionPosition harmonicActionVelocity
  calc
    _ = Ω ^ 2 * harmonicActionAmplitude Ω J ^ 2 *
        (Real.cos θ ^ 2 + Real.sin θ ^ 2) / 2 := by ring
    _ = J * Ω := by rw [Real.cos_sq_add_sin_sq, hs]; field_simp

theorem harmonicActionAmplitude_hasDerivAt (Ω : ℝ) (J : ℝ → ℝ) (d t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) :
    HasDerivAt (fun u => harmonicActionAmplitude Ω (J u))
      (d / (Ω * harmonicActionAmplitude Ω (J t))) t := by
  have hx : 0 < 2 * J t / Ω := div_pos (mul_pos (by norm_num) hJ) hΩ
  have h := ((hd.const_mul 2).div_const Ω).sqrt (ne_of_gt hx)
  convert h using 1 <;> dsimp [harmonicActionAmplitude]
  field_simp

theorem harmonicAction_hasDerivAt_components (Ω : ℝ) (J θ : ℝ → ℝ) (d ω t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ ω t) :
    HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
      (d / (Ω * harmonicActionAmplitude Ω (J t)) * Real.cos (θ t) -
        harmonicActionAmplitude Ω (J t) * Real.sin (θ t) * ω) t ∧
    HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
      (Ω * (d / (Ω * harmonicActionAmplitude Ω (J t)) * Real.sin (θ t) +
        harmonicActionAmplitude Ω (J t) * Real.cos (θ t) * ω)) t := by
  have ha := harmonicActionAmplitude_hasDerivAt Ω J d t hΩ hJ hd
  obtain ⟨hx, hv⟩ := polarCoordinates_hasDerivAt_components
    (fun u => harmonicActionAmplitude Ω (J u)) θ
    (d / (Ω * harmonicActionAmplitude Ω (J t))) ω t ha hθ
  have hxc : harmonicActionAmplitude Ω (J t) * ω * Real.sin (θ t) =
      harmonicActionAmplitude Ω (J t) * Real.sin (θ t) * ω := by ring
  have hvc : harmonicActionAmplitude Ω (J t) * ω * Real.cos (θ t) =
      harmonicActionAmplitude Ω (J t) * Real.cos (θ t) * ω := by ring
  rw [hxc] at hx
  rw [hvc] at hv
  refine ⟨hx, ?_⟩
  simpa only [harmonicActionVelocity, mul_assoc] using hv.const_mul Ω

theorem harmonicAction_derivative_coefficients_iff (Ω A d ω θ : ℝ)
    (hΩ : 0 < Ω) (hA : 0 < A) :
    (d / (Ω * A) * Real.cos θ - A * Real.sin θ * ω = Ω * A * Real.sin θ ∧
      Ω * (d / (Ω * A) * Real.sin θ + A * Real.cos θ * ω) =
        -(Ω ^ 2) * (A * Real.cos θ)) ↔ d = 0 ∧ ω = -Ω := by
  constructor
  · rintro ⟨hx, hv⟩
    have hv' : d / (Ω * A) * Real.sin θ + A * Real.cos θ * ω =
        -Ω * A * Real.cos θ := by
      apply (mul_left_cancel₀ (ne_of_gt hΩ))
      calc
        _ = -(Ω ^ 2) * (A * Real.cos θ) := hv
        _ = _ := by ring
    have hc := Real.cos_sq_add_sin_sq θ
    have hsum : d / (Ω * A) = 0 := by
      calc
        _ = (d / (Ω * A) * Real.cos θ - A * Real.sin θ * ω) * Real.cos θ +
            (d / (Ω * A) * Real.sin θ + A * Real.cos θ * ω) * Real.sin θ := by
              calc
                _ = d / (Ω * A) * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by rw [hc]; ring
                _ = _ := by ring
        _ = 0 := by rw [hx, hv']; ring
    have hd : d = 0 := (div_eq_zero_iff).mp hsum |>.resolve_right
      (mul_ne_zero (ne_of_gt hΩ) (ne_of_gt hA))
    have hw : A * ω = -Ω * A := by
      calc
        _ = -(d / (Ω * A) * Real.cos θ - A * Real.sin θ * ω) * Real.sin θ +
            (d / (Ω * A) * Real.sin θ + A * Real.cos θ * ω) * Real.cos θ := by
              calc
                _ = A * ω * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by rw [hc]; ring
                _ = _ := by ring
        _ = -Ω * A := by
          rw [hx, hv']
          calc
            _ = -Ω * A * (Real.cos θ ^ 2 + Real.sin θ ^ 2) := by ring
            _ = _ := by rw [hc]; ring
    exact ⟨hd, by nlinarith⟩
  · rintro ⟨rfl, rfl⟩
    simp only [zero_div, zero_mul, zero_sub, zero_add]
    constructor <;> ring

theorem harmonicAction_ode_iff (Ω : ℝ) (J θ : ℝ → ℝ) (d ω t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ ω t) :
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ ω = -Ω := by
  obtain ⟨hx, hv⟩ := harmonicAction_hasDerivAt_components Ω J θ d ω t hΩ hJ hd hθ
  have hc := harmonicAction_derivative_coefficients_iff Ω
    (harmonicActionAmplitude Ω (J t)) d ω (θ t) hΩ (harmonicActionAmplitude_pos Ω (J t) hΩ hJ)
  constructor
  · rintro ⟨hx', hv'⟩
    exact hc.mp ⟨hx.unique hx', hv.unique hv'⟩
  · intro heq
    obtain ⟨hx', hv'⟩ := hc.mpr heq
    rw [hx'] at hx
    rw [hv'] at hv
    exact ⟨hx, hv⟩

theorem harmonicAction_explicit_solution (Ω J θ₀ t₀ : ℝ) (hΩ : 0 < Ω) (hJ : 0 < J) :
    ∀ t : ℝ,
      HasDerivAt (fun u => harmonicActionPosition Ω J (θ₀ - Ω * (u - t₀)))
        (harmonicActionVelocity Ω J (θ₀ - Ω * (t - t₀))) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω J (θ₀ - Ω * (u - t₀)))
        (-(Ω ^ 2) * harmonicActionPosition Ω J (θ₀ - Ω * (t - t₀))) t := by
  intro t
  have hθ : HasDerivAt (fun u => θ₀ - Ω * (u - t₀)) (-Ω) t := by
    have h := (((hasDerivAt_id t).sub_const t₀).const_mul Ω).const_sub θ₀
    rw [mul_one] at h
    exact h
  exact (harmonicAction_ode_iff Ω (fun _ => J) (fun u => θ₀ - Ω * (u - t₀))
    0 (-Ω) t hΩ hJ (hasDerivAt_const t J) hθ).mpr ⟨rfl, rfl⟩

theorem exists_harmonicAction_representation (Ω x v : ℝ) (hΩ : 0 < Ω)
    (hz : x ≠ 0 ∨ v ≠ 0) :
    ∃ J θ : ℝ, 0 < J ∧ harmonicActionPosition Ω J θ = x ∧
      harmonicActionVelocity Ω J θ = v := by
  let c : ℂ := ⟨x, v / Ω⟩
  have hc : c ≠ 0 := by
    intro h
    have hx : x = 0 := congrArg Complex.re h
    have hv : v / Ω = 0 := congrArg Complex.im h
    rcases hz with hn | hn
    · exact hn hx
    · exact hn ((div_eq_zero_iff).mp hv |>.resolve_right (ne_of_gt hΩ))
  let A := ‖c‖
  have hA : 0 < A := norm_pos_iff.mpr hc
  let J := Ω * A ^ 2 / 2
  have hJ : 0 < J := div_pos (mul_pos hΩ (sq_pos_of_pos hA)) (by norm_num)
  have hroot : harmonicActionAmplitude Ω J = A := by
    unfold harmonicActionAmplitude
    have heq : 2 * J / Ω = A ^ 2 := by dsimp [J]; field_simp
    rw [heq, Real.sqrt_sq (le_of_lt hA)]
  refine ⟨J, Complex.arg c, hJ, ?_, ?_⟩
  · unfold harmonicActionPosition
    rw [hroot]
    exact Complex.norm_mul_cos_arg c
  · unfold harmonicActionVelocity
    rw [hroot, mul_assoc, Complex.norm_mul_sin_arg c]
    change Ω * (v / Ω) = v
    field_simp

theorem harmonicAction_time_formula (Ω a b : ℝ) (J θ : ℝ → ℝ)
    (hΩ : 0 < Ω) (hJ : ∀ t ∈ Ioo a b, 0 < J t)
    (hreg : ∀ t ∈ Ioo a b, DifferentiableAt ℝ J t ∧ DifferentiableAt ℝ θ t)
    (hODE : ∀ t ∈ Ioo a b,
      HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    J t = J s ∧ θ t = θ s - Ω * (t - s) := by
  have heq : ∀ u ∈ Ioo a b, deriv J u = 0 ∧ deriv θ u = -Ω := by
    intro u hu
    exact (harmonicAction_ode_iff Ω J θ (deriv J u) (deriv θ u) u hΩ (hJ u hu)
      (hreg u hu).1.hasDerivAt (hreg u hu).2.hasDerivAt).mp (hODE u hu)
  have hangle : ∀ u ∈ Ioo a b, HasDerivAt (fun u => θ u + Ω * u) 0 u := by
    intro u hu
    have h := (hreg u hu).2.hasDerivAt.add ((hasDerivAt_id u).const_mul Ω)
    rw [(heq u hu).2, mul_one, neg_add_cancel] at h
    exact h
  have hconst := isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hreg u hu).1.differentiableWithinAt) (fun u hu => (heq u hu).1) ht hs
  have hθconst := isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hangle u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hangle u hu).deriv) ht hs
  exact ⟨hconst, by linarith⟩

noncomputable def harmonicActionState (Ω J θ : ℝ) : PhaseSpace 1 :=
  (WithLp.toLp 2 ![harmonicActionPosition Ω J θ], WithLp.toLp 2 ![harmonicActionVelocity Ω J θ])

theorem harmonicAction_harmonicFlow (Ω J θ t : ℝ) (hΩ : 0 < Ω) :
    harmonicFlow Ω t (harmonicActionState Ω J θ) = harmonicActionState Ω J (θ - Ω * t) := by
  apply Prod.ext
  · ext i
    fin_cases i
    change Real.cos (Ω * t) * (harmonicActionAmplitude Ω J * Real.cos θ) +
        (Real.sin (Ω * t) / Ω) * (Ω * harmonicActionAmplitude Ω J * Real.sin θ) =
      harmonicActionAmplitude Ω J * Real.cos (θ - Ω * t)
    rw [Real.cos_sub]
    field_simp [ne_of_gt hΩ]
  · ext i
    fin_cases i
    change (-Ω * Real.sin (Ω * t)) * (harmonicActionAmplitude Ω J * Real.cos θ) +
        Real.cos (Ω * t) * (Ω * harmonicActionAmplitude Ω J * Real.sin θ) =
      Ω * harmonicActionAmplitude Ω J * Real.sin (θ - Ω * t)
    rw [Real.sin_sub]
    ring

end MolecularDynamics
