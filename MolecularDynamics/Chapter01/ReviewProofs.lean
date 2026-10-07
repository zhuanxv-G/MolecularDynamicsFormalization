import MolecularDynamics.Chapter01.Statements
import MolecularDynamics.Chapter01.MomentumBounds

open Set
open scoped BigOperators
open scoped Matrix.Norms.L2Operator
noncomputable section
namespace MolecularDynamics.Chapter01Review

theorem matrixExponentialSeries_hasSum {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A) := by
  exact NormedSpace.exp_series_hasSum_exp' (𝕂 := ℝ) A

theorem lennardJones_lowerBound (ε σ r : ℝ) (hε : 0 ≤ ε) :
    -ε ≤ lennardJonesPotential ε σ r := by
  have h : lennardJonesPotential ε σ r + ε = ε*(2*(σ/r)^6-1)^2 := by
    unfold lennardJonesPotential
    ring
  have hp := mul_nonneg hε (sq_nonneg (2*(σ/r)^6-1))
  linarith

theorem trimerPotential_lowerBound (q : Fin 3 → V3) :
    -3 ≤ uniformLJEnergy 1 1 q := by
  have h0 : Finset.Ioi (0 : Fin 3) = {1,2} := by decide
  have h1 : Finset.Ioi (1 : Fin 3) = {2} := by decide
  have h2 : Finset.Ioi (2 : Fin 3) = ∅ := by decide
  unfold uniformLJEnergy
  simp only [Fin.sum_univ_three, h0,h1,h2,Finset.sum_singleton,Finset.sum_empty]
  rw [Finset.sum_pair (show (1 : Fin 3) ≠ 2 from by decide)]
  have ha := lennardJones_lowerBound 1 1 (pairDistance (q 0) (q 1)) (by norm_num)
  have hb := lennardJones_lowerBound 1 1 (pairDistance (q 0) (q 2)) (by norm_num)
  have hc := lennardJones_lowerBound 1 1 (pairDistance (q 1) (q 2)) (by norm_num)
  linarith

theorem trimerLowerBound_proved : trimerLowerBound_statement := by
  intro q v _
  have hK : 0 ≤ ∑ i : Fin 3, ‖v i‖^2/2 :=
    Finset.sum_nonneg (fun i _ => div_nonneg (sq_nonneg _) (by norm_num))
  linarith [trimerPotential_lowerBound q]

theorem isoscelesEnergyBound_proved : isoscelesEnergyBound_statement := by
  intro x y v w E h
  dsimp [isoscelesEnergy] at h
  nlinarith [sq_nonneg v,sq_nonneg w]

theorem kineticEnergyBound_proved : kineticEnergyBound_statement := by
  intro n m U q p E Umin hU hE
  change momentumKineticEnergy m p + U q = E at hE
  linarith

theorem positionEnergyBound_proved : positionEnergyBound_statement := by
  intro n m U q p E Umin hm hU hE
  change momentumKineticEnergy m p + U q = E at hE
  exact ⟨hU,by linarith [momentumKineticEnergy_nonneg m p hm]⟩

theorem minimumGradientZero_proved : minimumGradientZero_statement := by
  intro n U q _ hmin
  apply (inner_self_eq_zero (𝕜 := ℝ)).mp
  rw [inner_gradient_left,hmin.fderiv_eq_zero]
  simp

theorem mechanicalEquilibrium_iff {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q p : Position n) (hm : ∀ i, 0 < m i) :
    IsMechanicalEquilibrium m (fun x => -gradient U x) (q,p) ↔ p=0 ∧ gradient U q=0 := by
  change (velocityOperator m p,-gradient U q) = (0,0) ↔ _
  constructor
  · intro h
    have hv := congrArg Prod.fst h
    have hg := congrArg Prod.snd h
    change velocityOperator m p = 0 at hv
    change -gradient U q = 0 at hg
    have hp := congrArg (massOperator m) hv
    rw [massOperator_velocityOperator m hm,map_zero] at hp
    exact ⟨hp,neg_eq_zero.mp hg⟩
  · rintro ⟨rfl,hg⟩
    simp [hg]

end MolecularDynamics.Chapter01Review
