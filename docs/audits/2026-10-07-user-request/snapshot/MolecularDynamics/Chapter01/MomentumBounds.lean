import MolecularDynamics.Chapter01.EnergyConservation

/-!
# Energy bounds for momentum and compact phase sets

Leimkuhler--Matthews, printed pages 25--26 (PDF pages 48--49).
The fixed positive diagonal mass model gives an explicit bound using any
positive upper bound for the coordinate masses. Compactness here is static;
it does not itself construct or extend an ODE solution.
-/

open Set Metric

set_option synthInstance.maxHeartbeats 2000
set_option maxHeartbeats 100000

namespace MolecularDynamics

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

theorem momentumKineticEnergy_nonneg {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (hm : ∀ i, 0 < m i) :
    0 ≤ momentumKineticEnergy m p := by
  exact Finset.sum_nonneg fun i _ =>
    div_nonneg (sq_nonneg _) (mul_pos (by norm_num) (hm i)).le

/-- An upper mass bound controls the Euclidean momentum norm by kinetic energy. -/
theorem momentum_norm_sq_le {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (M : ℝ) (hm : ∀ i, 0 < m i)
    (hM : ∀ i, m i ≤ M) :
    ‖p‖ ^ 2 ≤ 2 * M * momentumKineticEnergy m p := by
  rw [EuclideanSpace.real_norm_sq_eq]
  unfold momentumKineticEnergy
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i _
  have hnonneg : 0 ≤ (p i) ^ 2 / (2 * m i) :=
    div_nonneg (sq_nonneg _) (mul_pos (by norm_num) (hm i)).le
  calc
    (p i) ^ 2 = (2 * m i) * ((p i) ^ 2 / (2 * m i)) := by
      field_simp [ne_of_gt (hm i)]
    _ ≤ (2 * M) * ((p i) ^ 2 / (2 * m i)) :=
      mul_le_mul_of_nonneg_right (by linarith [hM i]) hnonneg

/-- Potential bounded below and total energy bounded above bound momentum. -/
theorem momentum_norm_le_of_energy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) (M c E : ℝ)
    (hm : ∀ i, 0 < m i) (hMpos : 0 < M) (hM : ∀ i, m i ≤ M)
    (hU : c ≤ U z.1) (hE : massHamiltonian m U z ≤ E) :
    ‖z.2‖ ≤ Real.sqrt (2 * M * (E - c)) := by
  apply Real.le_sqrt_of_sq_le
  have hkin : momentumKineticEnergy m z.2 ≤ E - c := by
    change momentumKineticEnergy m z.2 + U z.1 ≤ E at hE
    linarith
  exact (momentum_norm_sq_le m z.2 M hm hM).trans
    (mul_le_mul_of_nonneg_left hkin (by positivity))

/-- A strictly small kinetic budget gives a strictly small momentum norm. -/
theorem momentum_norm_lt_of_kineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) (M r : ℝ) (hm : ∀ i, 0 < m i)
    (hMpos : 0 < M) (hM : ∀ i, m i ≤ M) (hr : 0 < r)
    (hK : momentumKineticEnergy m p < r ^ 2 / (2 * M)) :
    ‖p‖ < r := by
  apply (sq_lt_sq₀ (norm_nonneg p) hr.le).1
  have hbudget := (lt_div_iff₀ (by positivity : 0 < 2 * M)).1 hK
  have hbound := momentum_norm_sq_le m p M hm hM
  nlinarith

/-- Continuous potential on a compact position set makes the corresponding
energy sublevel in phase space compact. The position set is an explicit input. -/
theorem isCompact_phaseEnergySublevel {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (K : Set (Position n)) (E : ℝ)
    (hm : ∀ i, 0 < m i) (hK : IsCompact K) (hU : ContinuousOn U K) :
    IsCompact {z : PhaseSpace n | z.1 ∈ K ∧ massHamiltonian m U z ≤ E} := by
  obtain ⟨c, hc⟩ := hK.bddBelow_image hU
  let M : ℝ := 1 + ∑ i, |m i|
  have hMpos : 0 < M := by
    dsimp [M]
    positivity
  have hM : ∀ i, m i ≤ M := by
    intro i
    have hsum : |m i| ≤ ∑ j, |m j| :=
      Finset.single_le_sum (fun j _ => abs_nonneg (m j)) (Finset.mem_univ i)
    dsimp [M]
    linarith [le_abs_self (m i)]
  let R := Real.sqrt (2 * M * (E - c))
  have hcontK : Continuous (momentumKineticEnergy m) := by
    exact continuous_iff_continuousAt.mpr fun p =>
      (hasGradientAt_momentumKineticEnergy m p).differentiableAt.continuousAt
  have hcontH : ContinuousOn (massHamiltonian m U)
      ((Prod.fst : PhaseSpace n → Position n) ⁻¹' K) := by
    change ContinuousOn (fun z : PhaseSpace n => momentumKineticEnergy m z.2 + U z.1) _
    exact (hcontK.comp continuous_snd).continuousOn.add
      (hU.comp continuous_fst.continuousOn fun _ hz => hz)
  have hclosed : IsClosed {z : PhaseSpace n | z.1 ∈ K ∧ massHamiltonian m U z ≤ E} := by
    exact hcontH.preimage_isClosed_of_isClosed (hK.isClosed.preimage continuous_fst)
      isClosed_Iic
  apply (hK.prod (isCompact_closedBall (0 : Momentum n) R)).of_isClosed_subset hclosed
  intro z hz
  refine ⟨hz.1, ?_⟩
  rw [mem_closedBall, dist_zero_right]
  exact momentum_norm_le_of_energy m U z M c E hm hMpos hM
    (hc (mem_image_of_mem U hz.1)) hz.2

end MolecularDynamics
