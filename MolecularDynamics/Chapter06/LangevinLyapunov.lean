import MolecularDynamics.Chapter06.LangevinGlobalRandomSolution
import Mathlib.Analysis.Calculus.Deriv.Pow

/-! Actual Hamiltonian-power Lyapunov calculus on printed253--254/PDF274--275. -/

open Set Filter MeasureTheory
open scoped Topology ContDiff BigOperators

namespace MolecularDynamics

/-- The literal unit-mass mechanical Hamiltonian used in the Lyapunov proof. -/
noncomputable def textbookLangevinHamiltonian {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ)
    (z : textbookLangevinPhase Nc) : ℝ := (∑ i, z.2 i ^ 2) / 2 + U z.1

/-- The actual Hamiltonian power Lyapunov candidate; the textbook exponent is positive. -/
noncomputable def textbookLangevinHamiltonianPower {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (l : ℕ)
    (z : textbookLangevinPhase Nc) : ℝ := textbookLangevinHamiltonian U z ^ l

/-- Literal directional first and second derivatives of the Langevin differential expression. -/
noncomputable def textbookLangevinDifferentialOperator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ : ℝ) (f : textbookLangevinPhase Nc → ℝ)
    (z : textbookLangevinPhase Nc) : ℝ :=
  deriv (fun t : ℝ ↦ f (z + t • textbookLangevinDrift U γ z)) 0 +
    σ ^ 2 / 2 * ∑ i : Fin Nc,
      deriv (deriv (fun t : ℝ ↦ f (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0

private theorem scalar_H2_first (p : ℝ) :
    HasDerivAt (fun s : ℝ ↦ (s ^ 2 / 2 + 2) ^ 2) (2 * (p ^ 2 / 2 + 2) * p) p := by
  convert! (((hasDerivAt_id p).pow 2).div_const 2 |>.add_const 2).pow 2 using 1
  simp only [Pi.pow_apply, id_eq]
  ring

private theorem scalar_H2_second (p : ℝ) :
    HasDerivAt (fun s : ℝ ↦ 2 * (s ^ 2 / 2 + 2) * s) (3 * p ^ 2 + 4) p := by
  convert! ((((hasDerivAt_id p).pow 2).div_const 2 |>.add_const 2).const_mul 2).mul
    (hasDerivAt_id p) using 1
  simp only [Pi.pow_apply, id_eq]
  ring

/-- A genuine derivative counterexample to the printed intermediate Laplacian bound: Nc=1, l=2, smooth periodic U=2, p=4. -/
theorem textbookLangevinLyapunov_printed_laplacian_bound_counterexample :
    deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 = 52 ∧
      ¬ deriv (deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2)) 4 ≤
        (2 : ℝ) * (2 + 1 - 1) * (4 ^ 2 / 2 + 2) ^ (2 - 1 : ℕ) := by
  have he : deriv (fun p : ℝ ↦ (p ^ 2 / 2 + 2) ^ 2) =
      fun p : ℝ ↦ 2 * (p ^ 2 / 2 + 2) * p := funext (fun p ↦ (scalar_H2_first p).deriv)
  rw [he, (scalar_H2_second 4).deriv]
  norm_num

/-- The actual momentum-direction Hamiltonian curve is a genuine quadratic polynomial. -/
theorem textbookLangevinHamiltonian_momentum_shift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (z : textbookLangevinPhase Nc) (j : Fin Nc) (t : ℝ) :
    textbookLangevinHamiltonian U (z + t • ((0 : Fin Nc → ℝ), Pi.single j 1)) =
      textbookLangevinHamiltonian U z + z.2 j * t + t ^ 2 / 2 := by
  classical
  have hterms (i : Fin Nc) : (z.2 i + t * (Pi.single j (1 : ℝ) : Fin Nc → ℝ) i) ^ 2 =
      z.2 i ^ 2 + if i = j then 2 * z.2 j * t + t ^ 2 else 0 := by
    by_cases h : i = j
    · subst i
      simp only [Pi.single_eq_same, mul_one, ite_true]
      ring
    · simp [h]
  have hs : (∑ i, (z.2 i + t * (Pi.single j (1 : ℝ) : Fin Nc → ℝ) i) ^ 2) =
      (∑ i, z.2 i ^ 2) + (2 * z.2 j * t + t ^ 2) := by
    simp_rw [hterms]
    rw [Finset.sum_add_distrib]
    simp
  change (∑ i, (z.2 i + t * (Pi.single j (1 : ℝ) : Fin Nc → ℝ) i) ^ 2) / 2 + U (z.1 + t • 0) = _
  rw [hs]
  simp only [smul_zero, add_zero]
  dsimp [textbookLangevinHamiltonian]
  ring

/-- The genuine lower potential bound gives the actual positive Hamiltonian used in the Lyapunov proof. -/
theorem textbookLangevinHamiltonian_lower {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (z : textbookLangevinPhase Nc) :
    1 ≤ textbookLangevinHamiltonian U z := by
  have hs : 0 ≤ ∑ i : Fin Nc, z.2 i ^ 2 := Finset.sum_nonneg (fun _ _ ↦ sq_nonneg _)
  dsimp [textbookLangevinHamiltonian]
  linarith [hU z.1]

/-- Every actual Hamiltonian power is positive under the textbook's lower energy normalization. -/
theorem textbookLangevinHamiltonianPower_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (z : textbookLangevinPhase Nc) :
    0 < textbookLangevinHamiltonianPower U l z :=
  pow_pos (lt_of_lt_of_le zero_lt_one (textbookLangevinHamiltonian_lower U hU z)) l

private theorem power_absorption (l : ℕ) (hl : 1 ≤ l) (A ε : ℝ) (hA : 0 ≤ A) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ H : ℝ, 0 ≤ H → A * H ^ (l - 1) ≤ ε * H ^ l + C := by
  let M : ℝ := max 1 (A / ε)
  have hM : 0 ≤ M := le_trans zero_le_one (le_max_left _ _)
  have hAM : A ≤ ε * M := by
    have hd : A / ε ≤ M := le_max_right _ _
    simpa only [mul_comm] using (div_le_iff₀ hε).mp hd
  let C : ℝ := A * M ^ (l - 1) + 1
  have hC : 0 < C := by dsimp [C]; positivity
  refine ⟨C, hC, fun H hH ↦ ?_⟩
  by_cases h : M ≤ H
  · have hAH : A ≤ ε * H := hAM.trans (mul_le_mul_of_nonneg_left h hε.le)
    calc
      _ ≤ (ε * H) * H ^ (l - 1) := mul_le_mul_of_nonneg_right hAH (pow_nonneg hH _)
      _ = ε * (H ^ (l - 1) * H) := by ring
      _ = ε * H ^ l := by rw [← pow_succ, Nat.sub_add_cancel hl]
      _ ≤ ε * H ^ l + C := le_add_of_nonneg_right hC.le
  · have hpow : H ^ (l - 1) ≤ M ^ (l - 1) := pow_le_pow_left₀ hH (le_of_lt (lt_of_not_ge h)) _
    have hb := mul_le_mul_of_nonneg_left hpow hA
    have hp : 0 ≤ ε * H ^ l := mul_nonneg hε.le (pow_nonneg hH _)
    dsimp [C]
    linarith

private theorem quadratic_hasDerivAt (H v s : ℝ) :
    HasDerivAt (fun t : ℝ ↦ H + v * t + t ^ 2 / 2) (v + s) s := by
  convert! ((hasDerivAt_const s H).add ((hasDerivAt_id s).const_mul v)).add
    (((hasDerivAt_id s).pow 2).div_const 2) using 1
  simp only [id_eq]
  ring

private theorem quadratic_pow_first (H v : ℝ) (l : ℕ) (s : ℝ) :
    HasDerivAt (fun t : ℝ ↦ (H + v * t + t ^ 2 / 2) ^ l)
      ((l : ℝ) * (H + v * s + s ^ 2 / 2) ^ (l - 1) * (v + s)) s :=
  (quadratic_hasDerivAt H v s).pow l

private theorem quadratic_pow_second (H v : ℝ) (l : ℕ) (hl : 1 ≤ l) (s : ℝ) :
    HasDerivAt (fun t : ℝ ↦ (l : ℝ) * (H + v * t + t ^ 2 / 2) ^ (l - 1) * (v + t))
      ((l : ℝ) * ((l : ℝ) - 1) * (H + v * s + s ^ 2 / 2) ^ (l - 2) * (v + s) ^ 2 +
        (l : ℝ) * (H + v * s + s ^ 2 / 2) ^ (l - 1)) s := by
  have he : (l - 1) - 1 = l - 2 := by omega
  have hc : ((l - 1 : ℕ) : ℝ) = (l : ℝ) - 1 := by rw [Nat.cast_sub hl, Nat.cast_one]
  convert! (((quadratic_hasDerivAt H v s).pow (l - 1)).const_mul (l : ℝ)).mul
    ((hasDerivAt_id s).const_add v) using 1
  simp only [he, hc, Pi.pow_apply, id_eq]
  ring

private theorem quadratic_pow_second_deriv_zero (H v : ℝ) (l : ℕ) (hl : 1 ≤ l) :
    deriv (deriv (fun t : ℝ ↦ (H + v * t + t ^ 2 / 2) ^ l)) 0 =
      (l : ℝ) * ((l : ℝ) - 1) * H ^ (l - 2) * v ^ 2 + (l : ℝ) * H ^ (l - 1) := by
  have he : deriv (fun t : ℝ ↦ (H + v * t + t ^ 2 / 2) ^ l) =
      fun t : ℝ ↦ (l : ℝ) * (H + v * t + t ^ 2 / 2) ^ (l - 1) * (v + t) :=
    funext (fun t ↦ (quadratic_pow_first H v l t).deriv)
  rw [he, (quadratic_pow_second H v l hl 0).deriv]
  simp

/-- Genuine twice-differentiation of the actual momentum-direction Hamiltonian power curve. -/
theorem textbookLangevinHamiltonianPower_momentum_second {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) (i : Fin Nc) :
    deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0 =
        (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (z.2 i) ^ 2 +
          (l : ℝ) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  have he : (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1))) =
      fun t : ℝ ↦ (textbookLangevinHamiltonian U z + z.2 i * t + t ^ 2 / 2) ^ l := by
    funext t
    simp only [textbookLangevinHamiltonianPower, textbookLangevinHamiltonian_momentum_shift]
  rw [he]
  exact quadratic_pow_second_deriv_zero _ _ l hl

/-- The actual finite-coordinate momentum Laplacian of H^l, with the true factor two available for its bound. -/
theorem textbookLangevinHamiltonianPower_momentum_laplacian {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) =
      (l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) * (∑ i, z.2 i ^ 2) +
        (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1) := by
  simp_rw [textbookLangevinHamiltonianPower_momentum_second U l hl z]
  rw [Finset.sum_add_distrib, ← Finset.mul_sum]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  ring

/-- The actual momentum Laplacian satisfies the corrected bound with coefficient 2l(l-1)+Nc*l. -/
theorem textbookLangevinHamiltonianPower_momentum_laplacian_bound {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1) := by
  rw [textbookLangevinHamiltonianPower_momentum_laplacian U l hl z]
  by_cases h1 : l = 1
  · subst l
    norm_num
  · have h2 : 2 ≤ l := by omega
    let H := textbookLangevinHamiltonian U z
    have hH : 0 ≤ H := le_trans zero_le_one (textbookLangevinHamiltonian_lower U hU z)
    have hS : (∑ i, z.2 i ^ 2) ≤ 2 * H := by
      dsimp [H, textbookLangevinHamiltonian]
      linarith [hU z.1]
    have hm : 0 ≤ (l : ℝ) - 1 := sub_nonneg.mpr (by exact_mod_cast hl)
    have hcoef : 0 ≤ (l : ℝ) * ((l : ℝ) - 1) * H ^ (l - 2) := by positivity
    have hb := mul_le_mul_of_nonneg_left hS hcoef
    have hexp : l - 2 + 1 = l - 1 := by omega
    have hp : H ^ (l - 2) * H = H ^ (l - 1) := by rw [← pow_succ, hexp]
    change (l : ℝ) * ((l : ℝ) - 1) * H ^ (l - 2) * (∑ i, z.2 i ^ 2) +
      (Nc : ℝ) * l * H ^ (l - 1) ≤ (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * H ^ (l - 1)
    calc
      _ ≤ (l : ℝ) * ((l : ℝ) - 1) * H ^ (l - 2) * (2 * H) + (Nc : ℝ) * l * H ^ (l - 1) :=
        add_le_add hb le_rfl
      _ = 2 * (l : ℝ) * ((l : ℝ) - 1) * (H ^ (l - 2) * H) + (Nc : ℝ) * l * H ^ (l - 1) := by ring
      _ = _ := by rw [hp]; ring

private theorem clm_eval_pi {Nc : ℕ} (L : (Fin Nc → ℝ) →L[ℝ] ℝ) (p : Fin Nc → ℝ) :
    L p = ∑ i, p i * L (Pi.single i 1) := by
  classical
  calc
    L p = L (∑ i, Pi.single i (p i)) := congrArg L (Finset.univ_sum_single p).symm
    _ = ∑ i, L (Pi.single i (p i)) := map_sum L _ _
    _ = _ := by
      apply Finset.sum_congr rfl
      intro i _
      have he : Pi.single i (p i) = p i • (Pi.single i (1 : ℝ) : Fin Nc → ℝ) := by
        ext j
        by_cases h : j = i
        · subst j
          simp
        · simp [h]
      rw [he, map_smul]
      rfl

private theorem linear_square_derivative (a b : ℝ) :
    HasDerivAt (fun t : ℝ ↦ (a + t * b) ^ 2) (2 * a * b) 0 := by
  convert! ((hasDerivAt_const (0 : ℝ) a).add ((hasDerivAt_id (0 : ℝ)).mul_const b)).pow 2 using 1
  simp only [Pi.add_apply, id_eq, zero_mul, add_zero]
  ring

/-- The true Hamiltonian derivative along the actual Langevin drift is exactly the frictional dissipation. -/
theorem textbookLangevinHamiltonian_drift_hasDerivAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ : ℝ) (z : textbookLangevinPhase Nc) :
    HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonian U (z + t • textbookLangevinDrift U γ z))
      (-γ * ∑ i, z.2 i ^ 2) 0 := by
  let F := textbookPotentialForce U z.1 - γ • z.2
  have hK : HasDerivAt (fun t : ℝ ↦ (∑ i : Fin Nc, (z.2 i + t * F i) ^ 2) / 2)
      (∑ i, z.2 i * F i) 0 := by
    have hd := (HasDerivAt.fun_sum (u := Finset.univ)
      (fun i _ ↦ linear_square_derivative (z.2 i) (F i))).div_const 2
    have he : (∑ i : Fin Nc, 2 * z.2 i * F i) / 2 = ∑ i, z.2 i * F i := by
      rw [Finset.sum_div]
      apply Finset.sum_congr rfl
      intro i _
      ring
    rw [he] at hd
    exact hd
  have hq : HasDerivAt (fun t : ℝ ↦ z.1 + t • z.2) z.2 0 := by
    convert! ((hasDerivAt_id (0 : ℝ)).smul_const z.2).const_add z.1 using 1
    simp only [one_smul]
  have hdu : HasFDerivAt U (fderiv ℝ U z.1) (z.1 + (0 : ℝ) • z.2) := by
    simpa using (hU z.1).hasFDerivAt
  have hP : HasDerivAt (fun t : ℝ ↦ U (z.1 + t • z.2)) (fderiv ℝ U z.1 z.2) 0 :=
    hdu.comp_hasDerivAt 0 hq
  have he : (∑ i, z.2 i * F i) + fderiv ℝ U z.1 z.2 = -γ * ∑ i, z.2 i ^ 2 := by
    rw [clm_eval_pi, ← Finset.sum_add_distrib, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    dsimp [F, textbookPotentialForce]
    ring
  have hd := hK.add hP
  rw [he] at hd
  exact hd

/-- The actual drift derivative of every Hamiltonian power follows by the genuine chain rule. -/
theorem textbookLangevinHamiltonianPower_drift_hasDerivAt {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ : ℝ) (l : ℕ) (z : textbookLangevinPhase Nc) :
    HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z + t • textbookLangevinDrift U γ z))
      (-γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2)) 0 := by
  have hd := (textbookLangevinHamiltonian_drift_hasDerivAt U hU γ z).pow l
  convert! hd using 1
  simp only [zero_smul, add_zero]
  ring

/-- The literal Langevin differential expression on the actual Hamiltonian power. -/
theorem textbookLangevinHamiltonianPower_differentialOperator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z =
      -γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2) +
        σ ^ 2 / 2 * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) *
          (∑ i, z.2 i ^ 2) + (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1)) := by
  unfold textbookLangevinDifferentialOperator
  rw [(textbookLangevinHamiltonianPower_drift_hasDerivAt U hU γ l z).deriv,
    textbookLangevinHamiltonianPower_momentum_laplacian U l hl z]

private theorem power_operator_upper {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (hL : ∀ q, 1 ≤ U q) (M : ℝ) (hB : ∀ q, U q ≤ M)
    (γ σ : ℝ) (hγ : 0 < γ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z ≤
      -2 * γ * l * textbookLangevinHamiltonian U z ^ l +
        (2 * γ * l * M + σ ^ 2 / 2 * (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l)) *
          textbookLangevinHamiltonian U z ^ (l - 1) := by
  let H := textbookLangevinHamiltonian U z
  have hH : 0 ≤ H := le_trans zero_le_one (textbookLangevinHamiltonian_lower U hL z)
  have hS : (∑ i, z.2 i ^ 2) = 2 * (H - U z.1) := by
    dsimp [H, textbookLangevinHamiltonian]
    ring
  have hHP : H ^ (l - 1) * H = H ^ l := by rw [← pow_succ, Nat.sub_add_cancel hl]
  have hd : -γ * l * H ^ (l - 1) * (∑ i, z.2 i ^ 2) =
      -2 * γ * l * H ^ l + 2 * γ * l * U z.1 * H ^ (l - 1) := by
    calc
      _ = -2 * γ * l * (H ^ (l - 1) * H) + 2 * γ * l * U z.1 * H ^ (l - 1) := by rw [hS]; ring
      _ = _ := by rw [hHP]
  have hb := mul_le_mul_of_nonneg_left
    (textbookLangevinHamiltonianPower_momentum_laplacian_bound U hL l hl z)
    (by positivity : 0 ≤ σ ^ 2 / 2)
  have hu := mul_le_mul_of_nonneg_left (hB z.1)
    (by positivity : 0 ≤ 2 * γ * l * H ^ (l - 1))
  unfold textbookLangevinDifferentialOperator
  rw [(textbookLangevinHamiltonianPower_drift_hasDerivAt U hU γ l z).deriv]
  change -γ * l * H ^ (l - 1) * (∑ i, z.2 i ^ 2) + _ ≤ _
  rw [hd]
  change _ ≤ -2 * γ * l * H ^ l + _
  dsimp only [H] at hu
  nlinarith [hb, hu]

/-- The genuine normalized smooth periodic potential yields the actual H^l Lyapunov drift inequality.
The diffusion coefficient is the true σ²/2; no Markov-generator identification is assumed here. -/
theorem textbookLangevinHamiltonianPower_periodic_lyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ σ : ℝ) (hγ : 0 < γ) (l : ℕ) (hl : 1 ≤ l) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPhase Nc,
      textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z ≤
        -(γ * l) * textbookLangevinHamiltonianPower U l z + δ := by
  obtain ⟨M, hM, hB⟩ := textbookUnitPeriodicPotential_bound U hU.continuous hP
  have hBound (q) : U q ≤ M := (le_abs_self (U q)).trans (by simpa only [Real.norm_eq_abs] using hB q)
  let A : ℝ := 2 * γ * l * M + σ ^ 2 / 2 * (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l)
  have hlR : (1 : ℝ) ≤ l := by exact_mod_cast hl
  have hε : 0 < γ * l := mul_pos hγ (lt_of_lt_of_le zero_lt_one hlR)
  have hA : 0 ≤ A := by dsimp [A]; positivity
  obtain ⟨δ, hδ, hAbs⟩ := power_absorption l hl A (γ * l) hA hε
  refine ⟨δ, hδ, fun z ↦ ?_⟩
  have hH : 0 ≤ textbookLangevinHamiltonian U z :=
    le_trans zero_le_one (textbookLangevinHamiltonian_lower U hL z)
  have hb := power_operator_upper U (hU.differentiable (by simp)) hL M hBound γ σ hγ l hl z
  have ha := hAbs (textbookLangevinHamiltonian U z) hH
  change _ ≤ -(γ * l) * textbookLangevinHamiltonian U z ^ l + δ
  dsimp [A] at ha
  nlinarith [hb, ha]

/-- The true Hamiltonian power is smooth, rather than supplying regularity as a conclusion hypothesis. -/
theorem textbookLangevinHamiltonianPower_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (l : ℕ) :
    ContDiff ℝ ∞ (textbookLangevinHamiltonianPower U l) := by
  unfold textbookLangevinHamiltonianPower textbookLangevinHamiltonian
  fun_prop

/-- The actual positive Hamiltonian power controls the unbounded momentum norm. -/
theorem textbookLangevinHamiltonianPower_momentum_coercive {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hL : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    ‖z.2‖ ^ 2 ≤ 2 * textbookLangevinHamiltonianPower U l z := by
  let S : ℝ := ∑ i, z.2 i ^ 2
  have hS : 0 ≤ S := Finset.sum_nonneg (fun _ _ ↦ sq_nonneg _)
  have hn : ‖z.2‖ ≤ Real.sqrt S := by
    apply (pi_norm_le_iff_of_nonneg (Real.sqrt_nonneg S)).mpr
    intro i
    have hi : z.2 i ^ 2 ≤ S := Finset.single_le_sum (fun j _ ↦ sq_nonneg (z.2 j)) (Finset.mem_univ i)
    rw [Real.norm_eq_abs]
    nlinarith [Real.sq_sqrt hS, abs_nonneg (z.2 i), sq_abs (z.2 i), Real.sqrt_nonneg S]
  have hnS : ‖z.2‖ ^ 2 ≤ S := by nlinarith [norm_nonneg z.2, Real.sq_sqrt hS, Real.sqrt_nonneg S]
  have hH := textbookLangevinHamiltonian_lower U hL z
  have hpow : textbookLangevinHamiltonian U z ≤ textbookLangevinHamiltonian U z ^ l := by
    simpa only [pow_one] using pow_le_pow_right₀ hH hl
  dsimp [S, textbookLangevinHamiltonian, textbookLangevinHamiltonianPower] at *
  linarith [hL z.1]

end MolecularDynamics
