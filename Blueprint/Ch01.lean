import MolecularDynamics.Chapter01.ReviewProofs
import MolecularDynamics.Chapter01.EuclideanStability
import MolecularDynamics.Chapter01.EnergyConservation
import MolecularDynamics.Chapter01.Lagrangian
import MolecularDynamics.Chapter01.LegendreTransform
import MolecularDynamics.Chapter01.GlobalFlow

/-!
Chapter 1 pilot: draft signatures for independent semantic review.
Existing formal-library sources and signatures are preserved.
The dimension n denotes N_c (3N for three-dimensional atomic coordinates).
The formal fixed diagonal model also supports the line case N_c = N.
No signature is frozen until the matching MathCopilot audit passes.
-/

open Set MolecularDynamics
open scoped ContDiff InnerProductSpace

noncomputable section
set_option autoImplicit false
namespace MD.Ch01

open MolecularDynamics.Chapter01Review Filter
open scoped BigOperators Topology

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

/-- Actual twice differentiable position curves satisfying M q̈ = -∇U.
The derivatives are genuine HasDerivAt witnesses, not total-derivative equations alone. -/
def IsNewtonTrajectoryOn {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
    massOperator m (deriv (deriv q) t) = -gradient U (q t)

/-- Matrix action for the configuration-dependent mass model on printed p.24. -/
noncomputable def matrixAction {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (v : Position n) : Position n := Matrix.toEuclideanLin A v

noncomputable def variableMassLagrangian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := inner ℝ v (matrixAction (M q) v) / 2 - U q

noncomputable def variableMassHamiltonian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : ℝ := inner ℝ p (matrixAction (M q)⁻¹ p) / 2 + U q

/-- source_id: MD-1.5.3-Thm1.1 · Theorem 1.1 · printed p.32 / PDF p.55
Original: A strong local minimum of a smooth potential yields a stable equilibrium.
[EXTRA] hm: positive fixed diagonal masses, inherited from p.25 positive definiteness.
[EXTRA] hQ: open position domain for local ODEs and the minimum neighborhood.
[EXTRA] hstrict includes q₀ ∈ Q, the implicit domain qualification.
hU is the original smoothness hypothesis, not an extra C1-force assumption.
The Euclidean predicate retains positive ε/δ, all nearby initial states, future
existence, and a bounded real supremum strictly below ε for every future solution.
The theorem sentence and proof discussion are on p.32 only; p.31 is background. -/
theorem theorem_1_1 {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n)) := by
  exact strictPotentialMin_futureStableEuclidean_of_smooth m U Q q₀ hm hQ hU hstrict

/-- source_id: MD-1.2-EnergyConservation · unnumbered claim · printed p.19 / PDF p.42
Original: Along Newtonian solutions the total energy is conserved and its derivative vanishes.
[EXTRA] hm: positive fixed diagonal masses for the auxiliary phase-space rewriting.
[EXTRA] hU: a differentiable potential makes the chain-rule computation meaningful.
[EXTRA] open connected time interval: comparisons are inside the solution interval.
The conclusion uses the position-velocity energy of (1.4), not only its momentum form.
The coordinate model admits arbitrary diagonal masses; physical 3D atom masses
are obtained by repeating each particle mass three times (semantic audit pending). -/
theorem energy_conservation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (q : ℝ → Position n)
    (hm : ∀ i, 0 < m i) (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x)
    (hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q) :
    (∀ t ∈ Ioo a b, HasDerivAt
      (fun s => nBodyTotalEnergy m U (q s) (deriv q s)) 0 t) ∧
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b,
      nBodyTotalEnergy m U (q s) (deriv q s) =
      nBodyTotalEnergy m U (q t) (deriv q t) := by
  have hγ : IsMechanicalSolutionOn m (fun x => -gradient U x) Q (Ioo a b)
      (fun t => (q t, massOperator m (deriv q t))) := by
    apply newtonTrajectory_to_mechanicalSolution m (fun x => -gradient U x) Q
      (Ioo a b) q (deriv q) (deriv (deriv q)) hm hq.1
    intro t ht
    refine ⟨(hq.2 t ht).1, (hq.2 t ht).2.1, ?_⟩
    ext i
    exact congrArg (fun v : Position n => v i) ((hq.2 t ht).2.2)
  constructor
  · intro t ht
    simpa only [massHamiltonian_massOperator] using
      mechanical_energy_hasDerivAt_zero m (fun x => -gradient U x) U Q (Ioo a b)
        (fun t => (q t, massOperator m (deriv q t))) hm isOpen_Ioo hγ hU
        (fun _ _ => rfl) t ht
  · intro s hs t ht
    simpa only [massHamiltonian_massOperator] using
      mechanical_energy_const_on_Ioo m (fun x => -gradient U x) U Q a b
        (fun t => (q t, massOperator m (deriv q t))) hm hγ hU
        (fun _ _ => rfl) s t hs ht

/-- source_id: MD-1.3-NewtonEulerLagrange · unnumbered claim · printed p.23 / PDF p.46
Original: The Newton equations can be expressed as the Euler-Lagrange equations.
[EXTRA] hm: positive fixed diagonal masses used by the phase-space equivalence.
[EXTRA] hI: an open time domain turns within derivatives into two-sided derivatives.
[EXTRA] hU: differentiability makes ∂L/∂q a genuine gradient.
Both directions are present; the predicate enforces every coordinate equation.
The Lagrangian here is the fixed-mass L on p.22, before generalized coordinates. -/
theorem newton_iff_euler_lagrange {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q := by
  constructor
  · intro hq
    have hγ : IsMechanicalSolutionOn m (fun x => -gradient U x) Q I
        (fun t => (q t, massOperator m (deriv q t))) := by
      apply newtonTrajectory_to_mechanicalSolution m (fun x => -gradient U x) Q I
        q (deriv q) (deriv (deriv q)) hm hq.1
      intro t ht
      refine ⟨(hq.2 t ht).1, (hq.2 t ht).2.1, ?_⟩
      ext i
      exact congrArg (fun v : Position n => v i) ((hq.2 t ht).2.2)
    exact mechanicalSolution_eulerLagrange m U Q I _ hm hI hγ hU
  · intro hq
    have hγ := eulerLagrange_to_mechanicalSolution m U Q I q hm hq hU
    refine ⟨hq.1, ?_⟩
    intro t ht
    refine ⟨(hq.2 t ht).1, ?_, ?_⟩
    · have hacc := hasDerivAt_deriv_position m (fun x => -gradient U x) Q I
        (fun t => (q t, massOperator m (deriv q t))) hI hγ t ht
      simpa only [hacc.deriv] using hacc
    · have hnewton := solution_nBodyEquationAt m (fun x => -gradient U x) U Q I
        (fun t => (q t, massOperator m (deriv q t))) hm hI hγ (fun _ _ => rfl) t ht
      ext i
      exact congrFun hnewton.1 i

/-- source_id: MD-1.4-LegendreHamiltonian · unnumbered claim · printed p.24 / PDF p.47
Original: The Legendre supremum is attained precisely at M(q)⁻¹p and yields H(q,p).
[ERRATUM?] The literal invertibility premise alone does not imply a bounded objective:
M = -1, U = 0, p = 0 gives v²/2. Convexity/positive definiteness may be inherited
from the abstract convex Legendre definition and the mechanical mass model on p.23;
independent audit must settle the intended premise. It has not been silently added.
The full configuration-dependent matrix M(q) is retained. The fixed positive
diagonal library theorem cannot establish this signature. This draft is unproved.
The conjuncts keep boundedness, supremum, exact maximizing velocity, momentum
gradient, and the energy identity after the inverse-velocity substitution. -/
theorem hamiltonian_legendre_transform {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry

/-- source_id: MD-1.5.1-FlowInverse · unnumbered claim · printed p.26 / PDF p.49
Original: Two-sided flow maps are inverse and form an Abelian composition group.
[EXTRA] hψ: actual all-real-time solutions, identity initial value and S-invariance;
these make the textbook's two-sided flow assumption explicit, not the group laws.
[EXTRA] hreg: C1 force for uniqueness, inherited from the preceding IVP discussion.
[EXTRA] _hm: positive fixed masses qualify the molecular Hamiltonian model.
The force is specifically -gradient U, as in the source Hamiltonian setting.
Quantification is on the invariant state domain S; no claim of global existence
for arbitrary forces or initial points outside S. Both inverses, bijectivity,
identity, addition and commutation clauses are included. -/
theorem flow_inverse {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n)
    (_hm : ∀ i, 0 < m i)
    (hψ : IsGlobalMechanicalFlowOn m (fun q => -gradient U q) Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∀ z ∈ S, ψ 0 z = z) ∧
    (∀ t : ℝ, ∀ z ∈ S, ψ (-t) (ψ t z) = z ∧ ψ t (ψ (-t) z) = z) ∧
    (∀ t : ℝ, BijOn (ψ t) S S) ∧
    ∀ s t : ℝ, ∀ z ∈ S,
      ψ t (ψ s z) = ψ s (ψ t z) ∧ ψ t (ψ s z) = ψ (t + s) z := by
  refine ⟨fun z hz => (hψ.1 z hz).2, ?_, ?_, ?_⟩
  · intro t z hz
    exact ⟨globalMechanicalFlow_inverse hψ hreg hz t,
      by simpa only [neg_neg] using globalMechanicalFlow_inverse hψ hreg hz (-t)⟩
  · intro t
    exact globalMechanicalFlow_bijOn hψ hreg t
  · intro s t z hz
    exact ⟨globalMechanicalFlow_commute hψ hreg hz s t,
      (globalMechanicalFlow_add hψ hreg hz s t).symm⟩

/- BEGIN FULL SECTION 1.1 -/

/-- source_id: MD-1.1-Schrodinger · definition · printed p.5 / PDF p.28
[EXTRA] Lean质量及Planck常数以正参数给定；定义采用总导数算子，仅定义满足方程的关系，不声明存在解。

-/
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q

/-- source_id: MD-1.1-NewtonModel · definition · printed p.6 / PDF p.29
[EXTRA] n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。

-/
def newtonInitialValueModel {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) (t₀ : ℝ)
    (q₀ v₀ : Position n) : Prop :=
  IsNewtonTrajectoryOn m U Q I q ∧ q t₀ = q₀ ∧ HasDerivAt q v₀ t₀

/-- source_id: MD-1.1-HardSphere · definition · printed p.7 / PDF p.30
[EXTRA] 只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。

-/
def hardSphereModel (R₁ R₂ m₁ m₂ : ℝ) (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  0 < R₁ ∧ 0 < R₂ ∧ 0 < m₁ ∧ 0 < m₂ ∧ R₁ + R₂ ≤ dist q₁ q₂ ∧
  (dist q₁ q₂ = R₁ + R₂ →
    m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
    m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 = m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2)

/-- source_id: MD-1.1.1-Multibody · definition · printed p.8 / PDF p.31
[EXTRA] 按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。

-/
def multibodyPotential {N : ℕ} (U₂ : Fin N → Fin N → V3 → V3 → ℝ)
    (U₃ : Fin N → Fin N → Fin N → V3 → V3 → V3 → ℝ)
    (U₄ : Fin N → Fin N → Fin N → Fin N → V3 → V3 → V3 → V3 → ℝ)
    (q : Fin N → V3) : ℝ :=
  (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, ∑ l ∈ Finset.Ioi k,
    U₄ i j k l (q i) (q j) (q k) (q l))

/-- source_id: MD-1.1.1-Morse · definition · printed p.8 / PDF p.31


-/
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2

/-- source_id: MD-1.1.1-MorseMinimum · unnumbered_claim · printed p.8 / PDF p.31
[EXTRA] D,a,rₑ正；well depth解释为无穷远极限减最小值。

-/
theorem morse_minimum :
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D) := by
  sorry

/-- source_id: MD-1.1.1-LengthBond · definition · printed p.9 / PDF p.32


-/
def lengthBond (k r₀ r : ℝ) := k / 2 * (r-r₀)^2

/-- source_id: MD-1.1.1-Dispersion · definition · printed p.10 / PDF p.33


-/
def dispersionPotential (K r : ℝ) := -K / r^6

/-- source_id: MD-1.1.1-Buckingham · definition · printed p.10 / PDF p.33


-/
def buckinghamPotential (A B C r : ℝ) := A * Real.exp (-B*r) - C/r^6

/-- source_id: MD-1.1.1-LennardJones · definition · printed p.10 / PDF p.33


-/
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)

/-- source_id: MD-1.1.1-LJRepulsion · unnumbered_claim · printed p.11 / PDF p.34


-/
theorem lj_repulsion :
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop := by
  sorry

/-- source_id: MD-1.1.1-HeterogeneousLJ · definition · printed p.11 / PDF p.34


-/
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))

/-- source_id: MD-1.1.2-Coulomb · definition · printed p.12 / PDF p.35


-/
def coulombPotential (C Qᵢ Qⱼ dielectric r : ℝ) := C*Qᵢ*Qⱼ/(dielectric*r)

/-- source_id: MD-1.1.2-Cutoff · definition · printed p.12 / PDF p.35


-/
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  ContDiff ℝ 1 φ ∧ ∀ r, r_cut < r → φ r = 0

/-- source_id: MD-1.1.2-Yukawa · definition · printed p.12 / PDF p.35

[ERRATUM?] 原文κ称Debye length，但e^{-κr}的量纲通常对应逆长度；本定义保留字面公式。
-/
def yukawaScreened (C Qᵢ Qⱼ dielectric κ r : ℝ) : ℝ :=
  C * Qᵢ * Qⱼ / (dielectric * r) * Real.exp (-κ * r)

/-- source_id: MD-1.1.2-AngleBond · definition · printed p.13 / PDF p.36


-/
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2

/-- source_id: MD-1.1.2-Dihedral · definition · printed p.13 / PDF p.36


-/
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))

/-- source_id: MD-1.1.2-GayBerne · Example 1.2 · printed p.16–17 / PDF p.39–40


-/
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)

/- END FULL SECTION 1.1 -/

end MD.Ch01
