import MolecularDynamics.Chapter01.Hamiltonian

/-!
# Fixed-mass Lagrangian and Euler--Lagrange trajectories

Leimkuhler--Matthews, Section 1.3, printed pages 22--23 / PDF pages 45--46.
Velocity and position slices have genuine Frechet gradients. The trajectory
predicate requires actual time derivatives, and the mechanical equivalence
uses positive fixed coordinate masses with a differentiable potential.
-/

open Set Filter
open scoped Topology InnerProductSpace

namespace MolecularDynamics

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

/-- The fixed diagonal mass Lagrangian, kinetic energy minus potential. -/
noncomputable def massLagrangian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) : ℝ :=
  nBodyKineticEnergy m v - U q

theorem nBodyKineticEnergy_eq_inner {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) : nBodyKineticEnergy m v = inner ℝ v (massOperator m v) / 2 := by
  rw [EuclideanSpace.inner_eq_star_dotProduct]
  simp only [star_trivial, dotProduct, Finset.sum_div, massOperator_coordinate]
  unfold nBodyKineticEnergy
  apply Finset.sum_congr rfl
  intro i _
  ring

theorem hasFDerivAt_velocityKinetic_term {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) (i : Fin n) :
    HasFDerivAt (fun x : Velocity n => m i * (x i) ^ 2 / 2)
      ((m i * v i) • EuclideanSpace.proj (𝕜 := ℝ) i) v := by
  have hi : HasFDerivAt (fun x : Velocity n => x i)
      (EuclideanSpace.proj (𝕜 := ℝ) i) v :=
    (EuclideanSpace.proj (𝕜 := ℝ) i).hasFDerivAt
  convert (hi.mul hi).mul_const (m i / 2) using 1
  · ext x
    simp only [Pi.mul_apply]
    ring
  · ext x
    simp only [smul_apply, add_apply, smul_eq_mul, EuclideanSpace.coe_proj]
    ring

theorem hasGradientAt_nBodyKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (v : Velocity n) : HasGradientAt (nBodyKineticEnergy m) (massOperator m v) v := by
  rw [hasGradientAt_iff_hasFDerivAt]
  have hsum : HasFDerivAt (nBodyKineticEnergy m)
      (∑ i : Fin n, (m i * v i) • EuclideanSpace.proj (𝕜 := ℝ) i) v :=
    HasFDerivAt.fun_sum (fun i _ => hasFDerivAt_velocityKinetic_term m v i)
  have hdual := coordinateDualRepresentation (massOperator m v)
  simp only [massOperator_coordinate] at hdual
  rw [hdual] at hsum
  exact hsum

theorem hasGradientAt_massLagrangian_velocity {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) :
    HasGradientAt (fun w => massLagrangian m U q w) (massOperator m v) v := by
  rw [hasGradientAt_iff_hasFDerivAt]
  exact (hasGradientAt_nBodyKineticEnergy m v).hasFDerivAt.sub_const (U q)

theorem hasGradientAt_massLagrangian_position {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun x => massLagrangian m U x v) (-gradient U q) q := by
  rw [hasGradientAt_iff_hasFDerivAt, map_neg]
  exact hU.hasGradientAt.hasFDerivAt.const_sub (nBodyKineticEnergy m v)

/-- Actual Euler--Lagrange time derivatives for a position curve in Q. -/
def IsEulerLagrangeTrajectoryOn {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (fun s => gradient (fun v => massLagrangian m U (q s) v) (deriv q s))
      (gradient (fun x => massLagrangian m U x (deriv q t)) (q t)) t

theorem mechanicalSolution_eulerLagrange {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) (hm : ∀ i, 0 < m i)
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q) :
    IsEulerLagrangeTrajectoryOn m U Q I (fun t => (γ t).1) := by
  refine ⟨hγ.1, ?_⟩
  intro t ht
  have hparts := ((isMechanicalSolutionOn_iff_components m (fun q => -gradient U q)
    Q I γ hI).mp hγ).2 t ht
  refine ⟨by simpa only [hparts.1.deriv] using hparts.1, ?_⟩
  rw [(hasGradientAt_massLagrangian_position m U (γ t).1
    (deriv (fun s => (γ s).1) t) (hU _ (hγ.1 t ht))).gradient]
  apply hparts.2.congr_of_eventuallyEq
  filter_upwards [hI.mem_nhds ht] with s hs
  rw [(hasGradientAt_massLagrangian_velocity m U (γ s).1
    (deriv (fun u => (γ u).1) s)).gradient]
  exact (momentum_eq_mass_deriv_position m (fun q => -gradient U q) Q I γ hm hI hγ s hs).symm

theorem eulerLagrange_to_mechanicalSolution {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (q : ℝ → Position n) (hm : ∀ i, 0 < m i)
    (hq : IsEulerLagrangeTrajectoryOn m U Q I q)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsMechanicalSolutionOn m (fun x => -gradient U x) Q I
      (fun t => (q t, massOperator m (deriv q t))) := by
  refine ⟨hq.1, ?_⟩
  intro t ht
  have hp := (hq.2 t ht).2
  have hfun : (fun s => gradient (fun v => massLagrangian m U (q s) v) (deriv q s)) =
      (fun s => massOperator m (deriv q s)) := by
    funext s
    exact (hasGradientAt_massLagrangian_velocity m U (q s) (deriv q s)).gradient
  rw [hfun, (hasGradientAt_massLagrangian_position m U (q t) (deriv q t)
    (hU _ (hq.1 t ht))).gradient] at hp
  simpa only [mechanicalVectorField, velocityOperator_massOperator m hm] using
    ((hq.2 t ht).1.prodMk hp).hasDerivWithinAt


end MolecularDynamics
