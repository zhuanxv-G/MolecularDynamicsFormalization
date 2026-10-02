import MolecularDynamics.Chapter01.ParticleCoordinates

/-!
# Local trajectories for a fixed diagonal mass matrix

Leimkuhler--Matthews, printed pages 18--19 and 24--26 (PDF pages 41--42 and
47--49). The first results connect the continuous linear mass operators with
the coordinate matrices of Section 1.2. Positive masses are needed only when
the inverse matrix is used to recover a velocity or momentum.
-/

open Set Filter
open scoped Topology

namespace MolecularDynamics

/-- Multiplication by the fixed diagonal mass matrix, as a continuous linear map. -/
noncomputable def massOperator {n : ℕ} (μ : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)).toContinuousLinearMap

/-- Action of the total matrix inverse. It recovers velocity only under an
explicit invertibility hypothesis, such as positive coordinate masses. -/
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap

/-- Coordinate link between the continuous linear operator and the mass matrix. -/
theorem massOperator_apply {n : ℕ} (μ : CoordinateMasses n)
    (v : Velocity n) (i : Fin n) :
    massOperator μ v i = (diagonalMassMatrix μ).mulVec v i := by
  rfl

/-- The total inverse matrix has this coordinate action even if a mass vanishes. -/
theorem velocityOperator_apply {n : ℕ} (μ : CoordinateMasses n)
    (p : Momentum n) (i : Fin n) :
    velocityOperator μ p i = ((diagonalMassMatrix μ)⁻¹).mulVec p i := by
  rfl

/-- Positive coordinate masses make mass multiplication a left inverse of
the velocity operator. -/
theorem massOperator_velocityOperator {n : ℕ} (μ : CoordinateMasses n)
    (hμ : ∀ i, 0 < μ i) (p : Momentum n) :
    massOperator μ (velocityOperator μ p) = p := by
  ext i
  change (diagonalMassMatrix μ).mulVec
    (((diagonalMassMatrix μ)⁻¹).mulVec p) i = p i
  rw [Matrix.mulVec_mulVec, diagonalMassMatrix_mul_inv μ hμ, Matrix.one_mulVec]

/-- Positive coordinate masses make the velocity operator a left inverse of
mass multiplication. -/
theorem velocityOperator_massOperator {n : ℕ} (μ : CoordinateMasses n)
    (hμ : ∀ i, 0 < μ i) (v : Velocity n) :
    velocityOperator μ (massOperator μ v) = v := by
  ext i
  change ((diagonalMassMatrix μ)⁻¹).mulVec
    ((diagonalMassMatrix μ).mulVec v) i = v i
  exact diagonalMassMatrix_inv_mulVec μ hμ v i

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

local instance (n : ℕ) : ContinuousSMul ℝ (PhaseSpace n) := by
  have : IsBoundedSMul ℝ (PhaseSpace n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

/-- The fixed-mass first-order mechanical field, with no conservative-force assumption. -/
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)

/-- A mechanical curve stays in Q and satisfies the ODE within the time set I. -/
def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I

/-- A solution on a nonempty symmetric open interval with a prescribed initial value.
This predicate does not assert existence or uniqueness for an arbitrary force. -/
def IsLocalMechanicalIVP {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (t₀ : ℝ) (z₀ : PhaseSpace n)
    (ε : ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  0 < ε ∧ γ t₀ = z₀ ∧
    IsMechanicalSolutionOn μ F Q (Ioo (t₀ - ε) (t₀ + ε)) γ

/-- Restrict an existing mechanical solution to a smaller time set. -/
theorem IsMechanicalSolutionOn.mono {n : ℕ} {μ : CoordinateMasses n}
    {F : Force n} {Q : Set (Position n)} {I J : Set ℝ} {γ : ℝ → PhaseSpace n}
    (hγ : IsMechanicalSolutionOn μ F Q I γ) (hJI : J ⊆ I) :
    IsMechanicalSolutionOn μ F Q J γ :=
  ⟨fun t ht => hγ.1 t (hJI ht), hγ.2.mono hJI⟩

/-- A mechanical solution is continuous on its given time domain. -/
theorem IsMechanicalSolutionOn.continuousOn {n : ℕ} {μ : CoordinateMasses n}
    {F : Force n} {Q : Set (Position n)} {I : Set ℝ} {γ : ℝ → PhaseSpace n}
    (hγ : IsMechanicalSolutionOn μ F Q I γ) : ContinuousOn γ I :=
  hγ.2.continuousOn

/-- The positive interval radius ensures the initial position belongs to Q. -/
theorem IsLocalMechanicalIVP.initial_mem {n : ℕ} {μ : CoordinateMasses n}
    {F : Force n} {Q : Set (Position n)} {t₀ ε : ℝ} {z₀ : PhaseSpace n}
    {γ : ℝ → PhaseSpace n} (hγ : IsLocalMechanicalIVP μ F Q t₀ z₀ ε γ) :
    z₀.1 ∈ Q := by
  have ht : t₀ ∈ Ioo (t₀ - ε) (t₀ + ε) := by
    constructor <;> linarith [hγ.1]
  simpa only [hγ.2.1] using hγ.2.2.1 t₀ ht

/-- On an open time domain the mechanical ODE is equivalent to its two derivatives. -/
theorem isMechanicalSolutionOn_iff_components {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n)
    (hI : IsOpen I) :
    IsMechanicalSolutionOn μ F Q I γ ↔
      (∀ t ∈ I, (γ t).1 ∈ Q) ∧ ∀ t ∈ I,
        HasDerivAt (fun s => (γ s).1) (velocityOperator μ (γ t).2) t ∧
        HasDerivAt (fun s => (γ s).2) (F (γ t).1) t := by
  constructor
  · rintro ⟨hQ, hγ⟩
    refine ⟨hQ, ?_⟩
    intro t ht
    have h := (hγ t ht).hasDerivAt (hI.mem_nhds ht)
    constructor
    · exact (ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt.comp_hasDerivAt t h
    · exact (ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt.comp_hasDerivAt t h
  · rintro ⟨hQ, hparts⟩
    refine ⟨hQ, ?_⟩
    intro t ht
    exact ((hparts t ht).1.prodMk (hparts t ht).2).hasDerivWithinAt

/-- Positive masses identify momentum with mass times the actual position derivative. -/
theorem momentum_eq_mass_deriv_position {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n)
    (hμ : ∀ i, 0 < μ i) (hI : IsOpen I) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (t : ℝ) (ht : t ∈ I) :
    (γ t).2 = massOperator μ (deriv (fun s => (γ s).1) t) := by
  have hq := ((isMechanicalSolutionOn_iff_components μ F Q I γ hI).1 hγ).2 t ht
  rw [hq.1.deriv, massOperator_velocityOperator μ hμ]

/-- Differentiate the position derivative using equality on a neighborhood in I.
The fixed inverse-matrix action is linear even for singular masses. -/
theorem hasDerivAt_deriv_position {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n)
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (t : ℝ) (ht : t ∈ I) :
    HasDerivAt (deriv (fun s => (γ s).1)) (velocityOperator μ (F (γ t).1)) t := by
  have hparts := ((isMechanicalSolutionOn_iff_components μ F Q I γ hI).1 hγ).2
  have hp := (velocityOperator μ).hasFDerivAt.comp_hasDerivAt t (hparts t ht).2
  apply hp.congr_of_eventuallyEq
  filter_upwards [hI.mem_nhds ht] with s hs
  exact (hparts s hs).1.deriv

/-- An existing first-order solution satisfies the pointwise Newton equation.
The relation to the total gradient is supplied as the force model hFU. -/
theorem solution_nBodyEquationAt {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) (hμ : ∀ i, 0 < μ i)
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (hFU : ∀ q ∈ Q, F q = -gradient U q) (t : ℝ) (ht : t ∈ I) :
    NBodyEquationAt μ F U (γ t).1 (deriv (deriv (fun s => (γ s).1)) t) := by
  refine ⟨?_, hFU (γ t).1 (hγ.1 t ht)⟩
  have hacc := hasDerivAt_deriv_position μ F Q I γ hI hγ t ht
  ext i
  change massOperator μ (deriv (deriv (fun s => (γ s).1)) t) i = F (γ t).1 i
  rw [hacc.deriv, massOperator_velocityOperator μ hμ]

/-- The textbook application explicitly requires a differentiable potential on Q. -/
theorem solution_nBodyEquationAt_of_differentiable {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) (hμ : ∀ i, 0 < μ i)
    (hI : IsOpen I) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (_hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hFU : ∀ q ∈ Q, F q = -gradient U q) (t : ℝ) (ht : t ∈ I) :
    NBodyEquationAt μ F U (γ t).1 (deriv (deriv (fun s => (γ s).1)) t) :=
  solution_nBodyEquationAt μ F U Q I γ hμ hI hγ hFU t ht

/-- With a differentiable potential, the force is the negative of a genuine gradient. -/
theorem solution_hasGradientAt_potential {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) (hγ : IsMechanicalSolutionOn μ F Q I γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hFU : ∀ q ∈ Q, F q = -gradient U q) (t : ℝ) (ht : t ∈ I) :
    HasGradientAt U (-F (γ t).1) (γ t).1 := by
  rw [hFU (γ t).1 (hγ.1 t ht), neg_neg]
  exact (hU (γ t).1 (hγ.1 t ht)).hasGradientAt

/-- Two actual curve derivatives and Newton's equation yield a first-order solution.
No openness of I is needed since the supplied derivatives are two-sided. -/
theorem newtonTrajectory_to_mechanicalSolution {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (v a : ℝ → Velocity n) (hμ : ∀ i, 0 < μ i)
    (hQ : ∀ t ∈ I, q t ∈ Q)
    (hqa : ∀ t ∈ I, HasDerivAt q (v t) t ∧ HasDerivAt v (a t) t ∧
      (diagonalMassMatrix μ).mulVec (a t) = F (q t)) :
    IsMechanicalSolutionOn μ F Q I (fun t => (q t, massOperator μ (v t))) := by
  refine ⟨hQ, ?_⟩
  intro t ht
  obtain ⟨hq, hv, hma⟩ := hqa t ht
  have hp := (massOperator μ).hasFDerivAt.comp_hasDerivAt t hv
  have hma' : massOperator μ (a t) = F (q t) := by
    ext i
    exact congrFun hma i
  rw [hma'] at hp
  simpa only [mechanicalVectorField, Function.comp_apply,
    velocityOperator_massOperator μ hμ] using
    (hq.prodMk hp).hasDerivWithinAt

/-- The free particle is an explicit local first-order initial-value solution. -/
theorem freeParticle_localIVP {n : ℕ} (μ : CoordinateMasses n)
    (q₀ : Position n) (v₀ : Velocity n) (t₀ ε : ℝ)
    (hμ : ∀ i, 0 < μ i) (hε : 0 < ε) :
    IsLocalMechanicalIVP μ (fun _ => 0) univ t₀ (q₀, massOperator μ v₀) ε
      (fun t => (q₀ + (t - t₀) • v₀, massOperator μ v₀)) := by
  refine ⟨hε, ?_, ?_⟩
  · simp
  · apply (isMechanicalSolutionOn_iff_components μ (fun _ => 0) univ
        (Ioo (t₀ - ε) (t₀ + ε)) _ isOpen_Ioo).2
    refine ⟨fun _ _ => mem_univ _, ?_⟩
    intro t _
    constructor
    · rw [velocityOperator_massOperator μ hμ]
      simpa using (((hasDerivAt_id t).sub_const t₀).smul_const v₀).const_add q₀
    · exact hasDerivAt_const t (massOperator μ v₀)

end MolecularDynamics
