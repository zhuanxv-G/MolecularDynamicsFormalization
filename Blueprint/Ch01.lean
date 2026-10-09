import MolecularDynamics.Chapter01.NormalModes
import MolecularDynamics.Chapter01.EquilibriumLinearization
import MolecularDynamics.Chapter01.HarmonicTorus
import MolecularDynamics.Chapter01.HarmonicActionAngle
import MolecularDynamics.Chapter01.KeplerPolarDynamics
import MolecularDynamics.Chapter01.PolarCoordinates
import MolecularDynamics.Chapter01.Kepler
import MolecularDynamics.Chapter01.RealRecoveryFlow
import MolecularDynamics.Chapter01.ScalarIntegrability
import MolecularDynamics.Chapter01.FirstIntegralQuadrature
import MolecularDynamics.Chapter01.FirstIntegralGraph
import MolecularDynamics.Chapter01.FirstIntegrals
import MolecularDynamics.Chapter01.MatrixFlow
import MolecularDynamics.Chapter01.BasisMatrix
import MolecularDynamics.Chapter01.ComplexSpectralFlow
import MolecularDynamics.Chapter01.LocalExistence
import MolecularDynamics.Chapter01.Hamiltonian
import MolecularDynamics.Chapter01.GeneralizedCoordinates
import MolecularDynamics.Chapter01.ScalarLocalIVP
import MolecularDynamics.Chapter01.HarmonicOscillator
import MolecularDynamics.Chapter01.MomentumConservation
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
open MeasureTheory

open MolecularDynamics.Chapter01Review Filter
open scoped BigOperators Topology Matrix.Norms.L2Operator

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

/- BEGIN FULL SECTION 1.2 -/

/-- source_id: MD-1.2-NewtonCompact · definition · printed p.18 / PDF p.41
[EXTRA] 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。

-/
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)

/-- source_id: MD-1.2-DegreesFreedom · definition · printed p.18 / PDF p.41
[EXTRA] 在可微约束C局部正则层中以导数核维数表示；无约束取零约束。

-/
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)

/-- source_id: MD-1.2-ConstraintDimension · unnumbered_claim · printed p.18 / PDF p.41
[EXTRA] 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。

-/
theorem constraintdimension :
  ∀ (n r : ℕ) (C : Position n → Position r) (q : Position n),
    DifferentiableAt ℝ C q → Function.Surjective (fderiv ℝ C q) →
    degreesOfFreedom C q + r = n := by
  intro n r C q _ hs
  have hrange : LinearMap.range (fderiv ℝ C q).toLinearMap = ⊤ :=
    LinearMap.range_eq_top.mpr hs
  have h := (fderiv ℝ C q).toLinearMap.finrank_range_add_finrank_ker
  rw [hrange] at h
  simpa [degreesOfFreedom, Position, finrank_euclideanSpace, Nat.add_comm] using h

/-- source_id: MD-1.2-TotalEnergy · definition · printed p.18 / PDF p.41


-/
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q

/-- source_id: MD-1.2-PairCancellation · unnumbered_claim · printed p.19 / PDF p.42
[EXTRA] Fi i=0，内部两体力反对称；无外力。

-/
theorem paircancellation :
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0 := by
  intro N F _ hanti
  have h : (∑ i, ∑ j, F i j) = -(∑ i, ∑ j, F i j) := by
    calc
      (∑ i, ∑ j, F i j) = ∑ j, ∑ i, F i j := Finset.sum_comm
      _ = ∑ j, ∑ i, -F j i := by
        apply Finset.sum_congr rfl
        intro j _
        apply Finset.sum_congr rfl
        intro i _
        exact hanti i j
      _ = -(∑ j, ∑ i, F j i) := by simp only [Finset.sum_neg_distrib]
  have hcoord (k : Fin 3) : (∑ i, ∑ j, F i j) k = 0 := by
    have hk := congrArg (fun v : V3 => v k) h
    simp only [PiLp.neg_apply] at hk
    linarith
  ext k
  exact hcoord k

/-- source_id: MD-1.2-MomentumConservation · unnumbered_claim · printed p.19 / PDF p.42
[EXTRA] 开放连通时间区间；净力为零来自前文内部力消去，此桥接显式采用净力条件。

-/
theorem momentumconservation :
  ∀ {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c := by
  exact @MolecularDynamics.totalMomentumCoordinate_const_on_Ioo

/-- source_id: MD-1.2-HarmonicSolution · unnumbered_claim · printed p.19–20 / PDF p.42–43
[EXTRA] Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。

-/
theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    ∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2 := by
  exact ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z, fun _ => rfl⟩

/-- source_id: MD-1.2-ScalarMechanical · definition · printed p.20 / PDF p.43


-/
def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, HasDerivAt z ((z t).2, -deriv U (z t).1) t

/-- source_id: MD-1.2-ScalarQuadrature · unnumbered_claim · printed p.20 / PDF p.43
[EXTRA] U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。

-/
theorem scalar_quadrature (U : ℝ → ℝ) (hU : ContDiff ℝ ∞ U)
    (ξ η : ℝ) (hη : η ≠ 0) :
    ∃ δ > 0, ∃ ε > 0, ∃ V X : ℝ → ℝ → ℝ → ℝ,
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => V z.1 z.2.1 z.2.2)
        {z | |z.1-ξ| < δ ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => X z.1 z.2.1 z.2.2)
        {z | |z.1| < ε ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      (∀ ζ κ, |ζ-ξ| < δ → |κ-η| < δ → V ζ ζ κ = κ ∧ X 0 ζ κ = ζ) ∧
      (∀ x ζ κ, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ →
        scalarPotentialEnergy U (x,V x ζ κ) = scalarPotentialEnergy U (ζ,κ)) ∧
      (∀ x ζ κ v, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ → |v-η| < δ →
        scalarPotentialEnergy U (x,v) = scalarPotentialEnergy U (ζ,κ) → v = V x ζ κ) ∧
      ∀ t ζ κ, |t| < ε → |ζ-ξ| < δ → |κ-η| < δ →
        HasDerivAt (fun s => X s ζ κ) (V (X t ζ κ) ζ κ) t ∧
        HasDerivAt (fun s => V (X s ζ κ) ζ κ) (-deriv U (X t ζ κ)) t ∧
        separableTimePrimitive (fun x => V x ζ κ) ζ (X t ζ κ) = t := by
  sorry

/-- source_id: MD-1.2-UniformLJSystem · Example 1.5 · printed p.21 / PDF p.44


-/
def uniformLJSystem {N : ℕ} (m ε σ : ℝ) (q v : Fin N → V3) : ℝ :=
  (∑ i, m * ‖v i‖^2 / 2) + uniformLJEnergy ε σ q

/-- source_id: MD-1.2-RadialLJForceLiteral · unnumbered_claim · printed p.21 / PDF p.44
[EXTRA] 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。
[ERRATUM?] 首个等式缺负号；所印次行实际为势的正梯度，不同于此前Newton负梯度。
-/
theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  sorry

/-- source_id: MD-1.2-LJCoordinateScaling · unnumbered_claim · printed p.21 / PDF p.44
[EXTRA] σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。

-/
theorem lj_coordinate_scaling (Q : ℝ → V3) (σ t : ℝ) (v a : V3)
    (hσ : 0 < σ) (hv : HasDerivAt Q v t) (ha : HasDerivAt (deriv Q) a t) :
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
    HasDerivAt (fun s => σ • deriv Q s) (σ • a) t ∧
    ∀ r s : V3, ‖σ • r - σ • s‖ = σ * ‖r-s‖ := by
  refine ⟨hv.const_smul σ, ha.const_smul σ, ?_⟩
  intro r s
  rw [← smul_sub, norm_smul, Real.norm_eq_abs, abs_of_pos hσ]

/-- source_id: MD-1.2-LJTimeScaling · unnumbered_claim · printed p.21–22 / PDF p.44–45
[EXTRA] m,ε,σ,α正；真实C2非碰撞轨迹。

-/
theorem ljtimescaling :
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    (((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)) ∧
    α⁻¹ = σ * Real.sqrt (m / ε) := by
  sorry

/- END FULL SECTION 1.2 -/

/- BEGIN FULL SECTION 1.3 -/

/-- source_id: MD-1.3-Lagrangian · definition · printed p.22 / PDF p.45


-/
def fixedMassLagrangian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := nBodyKineticEnergy m v - U q

/-- source_id: MD-1.3-GeneralizedCoordinates · unnumbered_claim · printed p.23 / PDF p.46
[EXTRA] 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。

-/
theorem generalized_coordinates {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t ∧
    massLagrangian m U (Φ (q t)) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ (q t)) := by
  exact ⟨hasDerivAt_coordinateChange Φ J q V t hΦ hq,
    massLagrangian_coordinateChange m U Φ J (q t) V⟩

/-- source_id: MD-1.3-GeneralizedMassRegular · unnumbered_claim · printed p.23 / PDF p.46
[EXTRA] 正粒子质量；full rank为Jacobian列单射，符合n≥k。

-/
theorem generalizedmassregular :
  ∀ {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec),
    IsUnit (generalizedMassMatrix m J) := by
  exact @MolecularDynamics.generalizedMassMatrix_isUnit

/- END FULL SECTION 1.3 -/

/- BEGIN FULL SECTION 1.4 -/

/-- source_id: MD-1.4-ConvexLegendre · definition · printed p.24 / PDF p.47
[EXTRA] 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。
[ERRATUM?] 原文给任意凸g却称共轭R值；g=0,η≠0时上确界+∞。Blueprint保留sup定义并显式扩展值域，须导师裁定是否接受。
-/
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- source_id: MD-1.4-HamiltonEquations · definition · printed p.24 / PDF p.47


-/
def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t, HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t

/-- source_id: MD-1.4-HamiltonFixedMass · unnumbered_claim · printed p.24 / PDF p.47
[EXTRA] 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。

-/
theorem hamilton_fixed_mass {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun v => variableMassHamiltonian (fun _ => M) U q v)
      (matrixAction M⁻¹ p) p ∧
    HasGradientAt (fun x => variableMassHamiltonian (fun _ => M) U x p)
      (gradient U q) q := by
  sorry

/-- source_id: MD-1.4-HamiltonLagrangeEquivalence · unnumbered_claim · printed p.25 / PDF p.48
[EXTRA] 一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。

-/
theorem hamiltonlagrangeequivalence :
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t) := by
  sorry

/-- source_id: MD-1.4-PhaseSpace · definition · printed p.25 / PDF p.48
[EXTRA] 采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。

-/
def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}

/- END FULL SECTION 1.4 -/

/- BEGIN FULL SECTION 1.5 -/

/-- source_id: MD-1.5-LocalExistUnique · unnumbered_claim · printed p.25 / PDF p.48
[EXTRA] generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。

-/
theorem local_exist_unique {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (hQ : IsOpen Q) (t₀ : ℝ) (z₀ : PhaseSpace n) (hz : z₀.1 ∈ Q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∃ ε γ, IsLocalMechanicalIVP m (fun q => -gradient U q) Q t₀ z₀ ε γ) ∧
    ∀ I γ η, IsOpen I → t₀ ∈ I →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I η →
      γ t₀ = z₀ → η t₀ = z₀ → γ =ᶠ[𝓝 t₀] η := by
  constructor
  · exact exists_localMechanicalIVP_open_of_force_contDiffAt m _ Q hQ t₀ z₀ hz (hreg _ hz)
  · intro I γ η hI ht hγ hη hi hj
    exact mechanicalSolution_eventually_unique_of_contDiffAt m _ Q I t₀ γ η z₀ hI ht hγ hη hi hj
      (mechanicalVectorField_contDiffAt m _ z₀ (hreg _ hz))

/-- source_id: MD-1.5-EnergySurface · definition · printed p.25 / PDF p.48


-/
def energySurface {n : ℕ} (H : PhaseSpace n → ℝ) (E : ℝ) := {z | H z = E}

/-- source_id: MD-1.5-EnergyBounds · unnumbered_claim · printed p.25 / PDF p.48
[EXTRA] U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。

-/
theorem energy_bounds {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : ∀ q, Umin ≤ U q) :
    (∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ →
      inner ℝ p (matrixAction M⁻¹ p) / 2 = E₀ - U q ∧
      inner ℝ p (matrixAction M⁻¹ p) / 2 ≤ E₀ - Umin ∧ Umin ≤ U q ∧ U q ≤ E₀) ∧
    ∃ R : ℝ, ∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ → ‖p‖ ≤ R := by
  sorry

/-- source_id: MD-1.5-UniformLevelsCompact · unnumbered_claim · printed p.26 / PDF p.49
[EXTRA] U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。

-/
theorem uniform_levels_compact {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : Continuous U) (hlower : ∀ q, Umin ≤ U q)
    (hlevels : ∃ R : ℝ, ∀ α ∈ Icc Umin E₀, ∀ q, U q = α → ‖q‖ ≤ R) :
    IsCompact {z : PhaseSpace n | variableMassHamiltonian (fun _ => M) U z.1 z.2 = E₀} := by
  sorry

/-- source_id: MD-1.5-CompactContinuation · unnumbered_claim · printed p.25–26 / PDF p.48–49
[EXTRA] 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。

-/
theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry

/-- source_id: MD-1.5-Nonconfining · unnumbered_claim · printed p.26 / PDF p.49


-/
theorem nonconfining :
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1} := by
  intro h
  obtain ⟨R,hR⟩ := h.exists_norm_le
  let q : Position 2 := WithLp.toLp 2 ![1,|R|+1]
  have hb : ‖q‖ ≤ R := hR q (by simp [q])
  have hv : |R|+1 ≤ ‖q‖ := by
    simpa [q, abs_of_nonneg (by positivity : 0 ≤ |R|+1)] using PiLp.norm_apply_le q (1 : Fin 2)
  have := le_abs_self R
  linarith

/-- source_id: MD-1.5.1-FlowMap · definition · printed p.26 / PDF p.49


-/
def flowMap {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ ξ, F 0 ξ = ξ) ∧ ∀ ξ t, HasDerivAt (fun s => F s ξ) (f (F t ξ)) t

/-- source_id: MD-1.5.1-FlowEnergy · unnumbered_claim · printed p.26 / PDF p.49
[EXTRA] H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。

-/
theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ := by
  intro ξ t
  have hd (s : ℝ) : HasDerivAt (fun u => H (F u ξ)) 0 s := by
    let z := F s ξ
    let A := fderiv ℝ H z
    have hA : HasFDerivAt H A z := (hH z).hasFDerivAt
    have hq := hA.comp z.1 ((hasFDerivAt_id (𝕜 := ℝ) z.1).prodMk (hasFDerivAt_const (𝕜 := ℝ) z.2 z.1))
    have hp := hA.comp z.2 ((hasFDerivAt_const (𝕜 := ℝ) z.1 z.2).prodMk (hasFDerivAt_id (𝕜 := ℝ) z.2))
    simp only [Function.comp_def, id_eq] at hq hp
    let gq := gradient (fun q => H (q,z.2)) z.1
    let gp := gradient (fun p => H (z.1,p)) z.2
    have eqQ (v : Position n) : A (v,0) = inner ℝ gq v := by
      rw [inner_gradient_left, hq.fderiv]
      rfl
    have eqP (v : Position n) : A (0,v) = inner ℝ gp v := by
      rw [inner_gradient_left, hp.fderiv]
      rfl
    have hz : A (symplecticGradient H z) = 0 := by
      change A (gp,-gq) = 0
      have he : (gp,-gq) = (gp,0)+(0,-gq) := by simp
      rw [he, map_add, eqQ, eqP, inner_neg_right, real_inner_comm gq gp]
      ring
    have hh := hA.comp_hasDerivAt s ((hF ξ).2 s)
    have he : A (symplecticGradient H (F s ξ)) = 0 := hz
    rw [he] at hh
    simpa only [Function.comp_def] using hh
  have hc := is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
  simpa [(hF ξ).1] using hc

/-- source_id: MD-1.5.1-HarmonicPhaseFlow · definition · printed p.27 / PDF p.50


-/
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)

/-- source_id: MD-1.5.1-SpectralSolution · unnumbered_claim · printed p.27 / PDF p.50
[EXTRA] 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。

-/
theorem spectralsolution :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E] {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ),
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i := by
  exact @MolecularDynamics.complexExponentialFlow_eigenbasis

/-- source_id: MD-1.5.1-BasisCoefficients · unnumbered_claim · printed p.27 / PDF p.50
[EXTRA] RCLike域包含实/复两种；真实有限基。

-/
theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  exact ⟨basisColumnMatrix_isUnit b, basisColumnMatrix_mulVec_repr b z,
    basisColumnMatrix_inverse_coefficients b z⟩

/-- source_id: MD-1.5.1-MatrixExponentialSolution · unnumbered_claim · printed p.27 / PDF p.50


-/
theorem matrixexponentialsolution :
  ∀ {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z),
    γ = fun t => matrixExponentialFlow A (t - t₀) z := by
  exact @MolecularDynamics.matrixExponentialFlow_unique

/-- source_id: MD-1.5.1-MatrixExpSeries · unnumbered_claim · printed p.27–28 / PDF p.50–51


-/
theorem matrix_exp_series {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A) := by
  exact MolecularDynamics.Chapter01Review.matrixExponentialSeries_hasSum A

/-- source_id: MD-1.5.2-FirstIntegral · definition · printed p.28 / PDF p.51


-/
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I

/-- source_id: MD-1.5.2-FirstIntegralCriterion · unnumbered_claim · printed p.28 / PDF p.51
[EXTRA] 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral_gradient_criterion。

-/
theorem firstintegralcriterion :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x),
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0 := by
  exact @MolecularDynamics.isFirstIntegralOn_iff_differential

/-- source_id: MD-1.5.2-PlanarGraphReduction · unnumbered_claim · printed p.28 / PDF p.51
[EXTRA] 对y偏导非零，真实strict导数，局部时间窗；原文省略隐函数非退化条件。

-/
theorem planargraphreduction :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0),
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t) := by
  exact @MolecularDynamics.planarFirstIntegral_localGraph_reduction

/-- source_id: MD-1.5.2-PlanarQuadrature · unnumbered_claim · printed p.28 / PDF p.51
[EXTRA] 正则第一积分图及非转向速度非零；真实C2、局部积分逆。

-/
theorem planarquadrature :
  ∀ (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0),
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (f (γ t₀)).1 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1,
        g (separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (γ t).1 = t - t₀) := by
  exact @MolecularDynamics.planarFirstIntegral_nonturning_quadrature

/-- source_id: MD-1.5.2-ScalarFirstIntegral · unnumbered_claim · printed p.28 / PDF p.51
[EXTRA] U C2；原文integrable的quadrature结论复用§1.2条目，不等同于全局闭式轨道。

-/
theorem scalarfirstintegral :
  ∀ (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U),
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U) := by
  exact @MolecularDynamics.scalarPotentialEnergy_isFirstIntegral

/-- source_id: MD-1.5.1-RealSpectralSolution · unnumbered_claim · printed p.27 / PDF p.50


-/
theorem realspectralsolution :
  ∀ {m : ℕ}
    (A : Matrix (Fin m) (Fin m) ℝ)
    (b : Module.Basis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))) (ν : Fin m → ℂ)
    (hb : ∀ j, Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℂ) (A.map Complex.ofReal)
      (b j) = ν j • b j)
    (z : EuclideanSpace ℂ (Fin m)) (hz : ∀ j, (z j).im = 0) (t : ℝ) (i : Fin m),
    ((∑ j, (b.repr z j * Complex.exp (ν j * (t : ℂ))) • b j) i).im = 0 := by
  exact @MolecularDynamics.realMatrix_complexSpectral_sum_isReal

/-- source_id: MD-1.5.2-KeplerEnergy · definition · printed p.29 / PDF p.52


-/
def planarKeplerEnergy (x y v w : ℝ) : ℝ :=
  v^2/2 + w^2/2 - 1/Real.sqrt (x^2+y^2)

/-- source_id: MD-1.5.2-KeplerConservedEnergy · unnumbered_claim · printed p.29 / PDF p.52
[EXTRA] 真实机械轨迹、非碰撞开放时间区间；n=2对应平面。

-/
theorem keplerconservedenergy :
  ∀ {n : ℕ} (a b : ℝ) (γ : ℝ → PhaseSpace n)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position n | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t) := by
  exact @MolecularDynamics.kepler_energy_const_on_Ioo

/-- source_id: MD-1.5.2-KeplerAngularMomentum · unnumbered_claim · printed p.29 / PDF p.52


-/
theorem keplerangularmomentum :
  ∀ (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) := by
  exact @MolecularDynamics.kepler_planarAngularMomentum_const_on_Ioo

/-- source_id: MD-1.5.2-KeplerMomentum · unnumbered_claim · printed p.29 / PDF p.52
[EXTRA] q≠0；单位质量。

-/
theorem keplermomentum :
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0 := by
  intro q hq
  simp [keplerForce, smul_eq_zero, hq, norm_ne_zero_iff.mpr hq]

/-- source_id: MD-1.5.2-PolarCoordinates · definition · printed p.29 / PDF p.52


-/
def polarCoordinates (r θ : ℝ) : Position 2 := WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ]

/-- source_id: MD-1.5.2-KeplerPolarLagrangian · unnumbered_claim · printed p.29 / PDF p.52


-/
theorem keplerpolarlagrangian :
  ∀ (r θ v omega : ℝ),
    ((v * Real.cos θ - r * omega * Real.sin θ) ^ 2 +
      (v * Real.sin θ + r * omega * Real.cos θ) ^ 2) / 2 + 1 / r =
    v ^ 2 / 2 + r ^ 2 * omega ^ 2 / 2 + 1 / r := by
  exact @MolecularDynamics.keplerPolarLagrangian_identity

/-- source_id: MD-1.5.2-KeplerPolarODE · unnumbered_claim · printed p.29 / PDF p.52


-/
theorem keplerpolarode :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ),
    IsKeplerPolarEulerLagrangeOn I r θ v omega ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (omega t) t ∧
        HasDerivAt v (r t * omega t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * omega u) 0 t := by
  exact @MolecularDynamics.keplerPolar_eulerLagrange_iff

/-- source_id: MD-1.5.2-PolarAngularIdentity · unnumbered_claim · printed p.29 / PDF p.52


-/
theorem polarangularidentity :
  ∀ (r θ v omega : ℝ),
    (r * Real.cos θ) * (v * Real.sin θ + r * omega * Real.cos θ) -
      (r * Real.sin θ) * (v * Real.cos θ - r * omega * Real.sin θ) = r ^ 2 * omega := by
  exact @MolecularDynamics.polarAngularMomentum_identity

/-- source_id: MD-1.5.2-KeplerRadialReduction · unnumbered_claim · printed p.29 / PDF p.52
[EXTRA] r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。

-/
theorem keplerradialreduction :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v omega) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * omega t = l),
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t := by
  exact @MolecularDynamics.keplerPolar_radial_reduction

/-- source_id: MD-1.5.2-KeplerRadialEnergy · definition · printed p.30 / PDF p.53


-/
def radialKeplerEnergy (ℓ r v : ℝ) : ℝ := v^2/2-1/r+ℓ^2/(2*r^2)

/-- source_id: MD-1.5.2-KeplerFullSolution · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] 完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。

-/
theorem kepler_full_solution (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z) :
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = polarCoordinates (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = ((polarCoordinates (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀]) := by
  sorry

/-- source_id: MD-1.5.2-ActionAngleCoordinates · definition · printed p.30 / PDF p.53


-/
def oscillatorActionAngle (Ω I θ : ℝ) : ℝ × ℝ :=
  (Real.sqrt (2*I/Ω)*Real.cos θ, Real.sqrt (2*I*Ω)*Real.sin θ)

/-- source_id: MD-1.5.2-ActionEnergy · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] Ω>0，I≥0；harmonicActionVelocity_formula保证v的sqrt(2IΩ)形式一致。

-/
theorem actionenergy :
  ∀ (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J),
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω := by
  exact @MolecularDynamics.harmonicAction_energy

/-- source_id: MD-1.5.2-ActionODE · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] Ω,I正；真实I′、θ′，非退化局部角坐标。

-/
theorem actionode :
  ∀ (Ω : ℝ) (J θ : ℝ → ℝ) (d omega t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ omega t),
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ omega = -Ω := by
  exact @MolecularDynamics.harmonicAction_ode_iff

/-- source_id: MD-1.5.2-ActionSolution · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] 连通开放时间窗含起始s；正action及Ω，真实坐标解。

-/
theorem actionsolution :
  ∀ (Ω a b : ℝ) (J θ : ℝ → ℝ)
    (hΩ : 0 < Ω) (hJ : ∀ t ∈ Ioo a b, 0 < J t)
    (hreg : ∀ t ∈ Ioo a b, DifferentiableAt ℝ J t ∧ DifferentiableAt ℝ θ t)
    (hODE : ∀ t ∈ Ioo a b,
      HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    J t = J s ∧ θ t = θ s - Ω * (t - s) := by
  exact @MolecularDynamics.harmonicAction_time_formula

/-- source_id: MD-1.5.2-HarmonicTorus · definition · printed p.30 / PDF p.53


-/
def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)

/-- source_id: MD-1.5.2-TorusPeriod · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] 给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。

-/
theorem torusperiod :
  ∀ {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n),
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T := by
  exact @MolecularDynamics.harmonicTorusRotation_periodic_iff_integer

/-- source_id: MD-1.5.2-TorusDense · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] 高维全整数关系无共振；仅成对频率比无理不足，此为原文quasi-periodic intended meaning的数学资格。
[ERRATUM?] 原文用ratio of frequencies描述高维填满环面，未区分准周期子环面与全维整数无共振；须导师明确。
-/
theorem torusdense :
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ) := by
  sorry

/-- source_id: MD-1.5.2-LocalActionAngleReduction · unnumbered_claim · printed p.30 / PDF p.53
[EXTRA] 全部积分C∞且Poisson括号两两零；正则共同能量层紧、连通；满秩=独立。
[ERRATUM?] local canonical action-angle与全局torus motion不同；本条只保留局部规约，原文最后tori motion需额外紧共同能量层假设。
-/
theorem local_action_angle_reduction :
  ∀ (d : ℕ) (I : Fin d → PhaseSpace d → ℝ) (c : Fin d → ℝ),
    (∀ i, ContDiff ℝ ∞ (I i)) →
    (∀ i j z, poissonBracket (I i) (I j) z = 0) →
    let S := {z : PhaseSpace d | ∀ i, I i z = c i}
    IsCompact S → IsConnected S →
    (∀ z ∈ S, Function.Surjective
      (fun v : PhaseSpace d => fun i => fderiv ℝ (I i) z v)) →
    localActionAngle I S ∧ ∃ e : S ≃ₜ HarmonicTorus d,
      ∀ i, ∃ Ω : Fin d → ℝ, ∀ (γ : ℝ → PhaseSpace d)
        (hγ : ∀ t, γ t ∈ S ∧ HasDerivAt γ (symplecticGradient (I i) (γ t)) t),
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩) := by
  sorry

/-- source_id: MD-1.5.3-Equilibrium · definition · printed p.31 / PDF p.54


-/
def equilibriumDefinition {n : ℕ} (f : Position n → Position n) (z : Position n) : Prop := f z = 0

/-- source_id: MD-1.5.3-ConstantEquilibrium · unnumbered_claim · printed p.31 / PDF p.54


-/
theorem constantequilibrium :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] (f : E → E) (z₀ : E) (t : ℝ),
    HasDerivAt (fun _ : ℝ => z₀) (f z₀) t ↔ f z₀ = 0 := by
  exact @MolecularDynamics.equilibrium_constant_ode_iff

/-- source_id: MD-1.5.3-EquilibriumLinearization · unnumbered_claim · printed p.31 / PDF p.54


-/
theorem equilibriumlinearization :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0),
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h) := by
  exact @MolecularDynamics.equilibrium_linearized_IVP

/-- source_id: MD-1.5.3-Hyperbolic · definition · printed p.31–32 / PDF p.54–55


-/
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0

/-- source_id: MD-1.5.3-HartmanGrobmanLiteral · unnumbered_claim · printed p.31–32 / PDF p.54–55
[EXTRA] C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。
[ERRATUM?] 原文smooth invertible强于常见Hartman–Grobman的homeomorphism，C1仅双曲不保证光滑共轭。
-/
theorem hartmangrobmanliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry

/-- source_id: MD-1.5.3-LyapunovStability · definition · printed p.32 / PDF p.55
[EXTRA] ε,δ正按Lyapunov容差惯例；有界性避免Lean实数总sup的未界伪结论。

-/
def lyapunovStable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, ‖x-z‖ < δ →
    BddAbove (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) ∧
    sSup (range (fun t : Set.Ici (0 : ℝ) => ‖F t x-z‖)) < ε

/-- source_id: MD-1.5.3-HyperbolicStabilityTransfer · unnumbered_claim · printed p.32 / PDF p.55
[EXTRA] C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。

-/
theorem hyperbolicstabilitytransfer :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry

/-- source_id: MD-1.5.3-HamiltonEquilibrium · unnumbered_claim · printed p.32 / PDF p.55
[EXTRA] 一般常M正定、U可微；heq为原文Hamilton平衡的两梯度定义。

-/
theorem hamilton_equilibrium {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q)
    (heq : gradient (fun v => variableMassHamiltonian (fun _ => M) U q v) p = 0 ∧
      gradient (fun x => variableMassHamiltonian (fun _ => M) U x p) q = 0) :
    p = 0 ∧ gradient U q = 0 := by
  sorry

/-- source_id: MD-1.5.3-StrongLocalMinimum · definition · printed p.32 / PDF p.55


-/
def strongLocalMinimum {n : ℕ} (U : PotentialEnergy n) (qstar : Position n) : Prop :=
  ∃ ε > 0, ∀ q, 0 < ‖q-qstar‖ → ‖q-qstar‖ < ε → U qstar < U q

/-- source_id: MD-1.5.3-LinearizedHamiltonian · definition · printed p.32 / PDF p.55


-/
def linearizedHamiltonian {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (δq δp : Position n) : ℝ :=
  inner ℝ δp (matrixAction M⁻¹ δp)/2 + inner ℝ δq (fderiv ℝ (gradient U) qstar δq)/2

/-- source_id: MD-1.5.3-PositiveHessianQuadratic · unnumbered_claim · printed p.33 / PDF p.56
[EXTRA] M正定，K=U″对称正定；一般矩阵。

-/
theorem positivehessianquadratic :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    IsStrictPotentialMin (fun z : PhaseSpace n =>
      inner ℝ z.2 (M⁻¹.toEuclideanLin z.2)/2 + inner ℝ z.1 (K.toEuclideanLin z.1)/2) 0 := by
  intro n M K hM hK
  have hn (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosSemidef) (v : Position n) :
      0 ≤ inner ℝ v (A.toEuclideanLin v) := by
    change 0 ≤ inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    simpa using ha.dotProduct_mulVec_nonneg (x := WithLp.ofLp v)
  have hp (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosDef) (v : Position n) (hv : v ≠ 0) :
      0 < inner ℝ v (A.toEuclideanLin v) := by
    change 0 < inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    have hv' : WithLp.ofLp v ≠ 0 := by simpa using hv
    simpa using ha.dotProduct_mulVec_pos hv'
  refine ⟨1,by norm_num,?_⟩
  intro z hz _
  have hzn : z ≠ 0 := dist_pos.mp hz
  have hq := hn K hK.posSemidef z.1
  have hpp := hn M⁻¹ hM.inv.posSemidef z.2
  have hz0 : inner ℝ ((0:PhaseSpace n).2) (M⁻¹.toEuclideanLin (0:PhaseSpace n).2)/2 +
      inner ℝ ((0:PhaseSpace n).1) (K.toEuclideanLin (0:PhaseSpace n).1)/2 = 0 := by
    change inner ℝ (0:Position n) (M⁻¹.toEuclideanLin 0)/2 + inner ℝ (0:Position n) (K.toEuclideanLin 0)/2 = 0
    simp
  dsimp only
  rw [hz0]
  by_cases hqz : z.1 = 0
  · have hpz : z.2 ≠ 0 := by
      intro h; exact hzn (Prod.ext hqz h)
    nlinarith [hp M⁻¹ hM.inv z.2 hpz]
  · nlinarith [hp K hK z.1 hqz]

/-- source_id: MD-1.5.3-PositiveHessianMinimum · unnumbered_claim · printed p.33 / PDF p.56
[EXTRA] C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。

-/
theorem positive_hessian_minimum {n : ℕ} (U : PotentialEnergy n) (q : Position n)
    (hU : ContDiff ℝ 2 U) (hq : gradient U q = 0)
    (B : Module.Basis (Fin n) ℝ (Position n)) (freq : Fin n → ℝ)
    (hdistinct : Function.Injective freq) (hpos : ∀ i, 0 < freq i)
    (heig : ∀ i, fderiv ℝ (gradient U) q (B i) = freq i • B i) :
    IsStrictPotentialMin U q := by
  sorry

/- END FULL SECTION 1.5 -/

/- BEGIN FULL SECTION 1.6 -/

/-- source_id: MD-1.6-UniformPairLattice · definition · printed p.33 / PDF p.56


-/
def latticePairPotential {N : ℕ} (φ : ℝ → ℝ) (x : Fin N → ℝ) : ℝ :=
  ∑ i, ∑ j ∈ Finset.Ioi i, φ |x i-x j|

/-- source_id: MD-1.6-UnorderedPairCount · unnumbered_claim · printed p.33 / PDF p.56


-/
theorem unorderedpaircount :
  ∀ N : ℕ, (Finset.univ.filter (fun p : Fin N × Fin N => p.1 < p.2)).card = N*(N-1)/2 := by
  intro N
  simpa [Nat.choose_two_right] using Finset.card_product_filter_lt (s := (Finset.univ : Finset (Fin N)))

/-- source_id: MD-1.6-NearestNeighbor · definition · printed p.33 / PDF p.56


-/
def nearestNeighborModel {N : ℕ} (φ : ℝ → ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  ∑ i : Fin N, φ |x i.succ-x i.castSucc|

/-- source_id: MD-1.6-WalledChain · definition · printed p.33 / PDF p.56


-/
def walledChainModel {N : ℕ} (φ φc : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  φc |x 0| + φc |L-x (Fin.last N)| + nearestNeighborModel φ x

/-- source_id: MD-1.6-PeriodicChain · definition · printed p.33 / PDF p.56


-/
def periodicChainModel {N : ℕ} (φ : ℝ → ℝ) (L : ℝ) (x : Fin (N+1) → ℝ) : ℝ :=
  nearestNeighborModel φ x + φ |L+x 0-x (Fin.last N)|

/-- source_id: MD-1.6-PeriodicBoundary · definition · printed p.34 / PDF p.57


-/
def periodicBoundary (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L

/-- source_id: MD-1.6-PeriodicTranslationMomentum · unnumbered_claim · printed p.34 / PDF p.57
[EXTRA] 一维周期链真实Newton导数、正质量、势沿轨迹可微及开连通时间域。

-/
theorem periodic_translation_momentum :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ),
    let U := boxPeriodicNearestNeighborPotentialEnergy φ L
    (∀ q c, U (fun i => q i+c) = U q) ∧
    (∀ q, DifferentiableAt ℝ U q → fderiv ℝ U q (fun _ => 1) = 0) ∧
    ∀ (m : Fin (N+1) → ℝ) (q v : ℝ → Fin (N+1) → ℝ) (I : Set ℝ),
      IsOpen I → IsPreconnected I → (∀ i, 0 < m i) →
      (∀ t ∈ I, DifferentiableAt ℝ U (q t)) →
      (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t ∧
        HasDerivAt (fun s => m i*v s i) (-fderiv ℝ U (q t) (Pi.single i 1)) t) →
      (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i*v s i) 0 t) ∧
      ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i*v a i) = ∑ i, m i*v b i := by
  sorry

/-- source_id: MD-1.6-RegularLattice · definition · printed p.34 / PDF p.57


-/
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ

/-- source_id: MD-1.6-RegularLatticeMinimizerLiteral · unnumbered_claim · printed p.34 / PDF p.57

[ERRATUM?] 对任意uniform φ断言规则格点极小不成立：φ=0时任何非均匀位置都最小；还缺势凸性、排斥、顺序/域资格。
-/
theorem regularlatticeminimizerliteral :
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x := by
  sorry

/-- source_id: MD-1.6-PeriodicImages · definition · printed p.35 / PDF p.58


-/
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])

/-- source_id: MD-1.6-MinimumImage · definition · printed p.35 / PDF p.58


-/
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖

/-- source_id: MD-1.6-RhombicLattice · definition · printed p.35 / PDF p.58


-/
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}

/-- source_id: MD-1.6-HexagonalLattice · unnumbered_claim · printed p.35 / PDF p.58


-/
theorem hexagonal_lattice_two_bases (a : ℝ) :
    rhombicLattice a a (2*Real.pi/3) = rhombicLattice a a (Real.pi/3) := by
  ext x
  have hc : Real.cos (2*Real.pi/3) = -(1/2:ℝ) := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hs : Real.sin (2*Real.pi/3) = Real.sqrt 3/2 := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  constructor
  · rintro ⟨k,l,rfl⟩
    refine ⟨k-l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
  · rintro ⟨k,l,rfl⟩
    refine ⟨k+l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring

/-- source_id: MD-1.6-UnitCell · definition · printed p.35 / PDF p.58


-/
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}

/-- source_id: MD-1.6-FCCStacking · definition · printed p.36 / PDF p.59
[EXTRA] 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。

-/
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}

/-- source_id: MD-1.6-HCPStacking · definition · printed p.36 / PDF p.59
[EXTRA] 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。

-/
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}

/-- source_id: MD-1.6.1-MinimumGradientZero · unnumbered_claim · printed p.36–37 / PDF p.59–60
[EXTRA] 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。
[ERRATUM?] 不限定内点及可微时，Regardless of boundary的全梯度零过强；显式[EXTRA]内点解释。
-/
theorem minimumgradientzero :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved

/-- source_id: MD-1.6.1-ForceLinearization · unnumbered_claim · printed p.37 / PDF p.60
[EXTRA] 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。

-/
theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar) := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  constructor
  · change HasFDerivAt (fun z : PhaseSpace n => (B z.2, -gradient U z.1)) _ (qstar,0)
    have hn : HasFDerivAt (fun q => -gradient U q) (-fderiv ℝ (gradient U) qstar) qstar :=
      hg.hasFDerivAt.neg
    have h₂ := hn.comp (qstar,0)
      ((ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    have h₁ := B.hasFDerivAt.comp (qstar,0)
      ((ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    exact h₁.prodMk h₂
  · have h := hasFDerivAt_iff_isLittleO.mp hg.hasFDerivAt
    simpa only [heq, sub_zero] using h

/-- source_id: MD-1.6.1-MinimumHessianLiteral · unnumbered_claim · printed p.37 / PDF p.60

[ERRATUM?] 局部极小Hessian仅半正定；U(x)=x^4在0为严格极小但二阶导数0。
-/
theorem minimumhessianliteral :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

/-- source_id: MD-1.6.1-ImaginarySpectrum · unnumbered_claim · printed p.37 / PDF p.60
[EXTRA] M和Hessian K正定；复谱实虚向量编码。

-/
theorem imaginary_spectrum :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2, -K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y →
      a = 0 ∧ 0 < b^2 ∧ A x = -b • y ∧ A (-y) = -b • x := by
  sorry

/-- source_id: MD-1.6.1-ComplexNormalMode · unnumbered_claim · printed p.37 / PDF p.60


-/
theorem complexnormalmode :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t := by
  sorry

/-- source_id: MD-1.6.1-RealNormalMode · unnumbered_claim · printed p.37 / PDF p.60


-/
theorem realnormalmode :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ),
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t := by
  exact @MolecularDynamics.hasDerivAt_realNormalMode

/- END FULL SECTION 1.6 -/

/- BEGIN FULL SECTION 1.7 -/

/-- source_id: MD-1.7-PlanarTrimerModel · Example 1.8 (Planar Lennard-Jones Trimer) · printed p.38 / PDF p.61


-/
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖

/-- source_id: MD-1.7-CentralPairPotential · definition · printed p.38 / PDF p.61


-/
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2

/-- source_id: MD-1.7-CentralPairGradient · unnumbered_claim · printed p.38 / PDF p.61
[EXTRA] 势在非碰撞距离可微；partial为欧氏梯度。

-/
theorem centralpairgradient :
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r := by
  intro φ q r hqr hφ
  have hn : ‖q-r‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr hqr)
  have h₁ := (((hasFDerivAt_id q).sub_const r).norm_sq).sqrt (pow_ne_zero 2 hn)
  have h₂ := (((hasFDerivAt_const q r).sub (hasFDerivAt_id r)).norm_sq).sqrt (pow_ne_zero 2 hn)
  simp only [Real.sqrt_sq_eq_abs, abs_norm] at h₁ h₂
  have g₁ := hφ.hasDerivAt.comp_hasFDerivAt q h₁
  have g₂ := hφ.hasDerivAt.comp_hasFDerivAt r h₂
  apply ext_inner_right ℝ
  intro v
  simp only [Function.comp_def, id_eq, Pi.sub_apply] at g₁ g₂
  rw [inner_gradient_left, inner_neg_left, inner_gradient_left, g₁.fderiv, g₂.fderiv]
  simp [ContinuousLinearMap.comp_apply, innerSL_apply_apply, inner_neg_right]
  ring

/-- source_id: MD-1.7-CentralMomentum · unnumbered_claim · printed p.39 / PDF p.62
[EXTRA] 逐对作用反对称推出净力零；真实Newton解和连通时间区间。

-/
theorem centralmomentum :
  ∀ {N d : ℕ}
    (m : CoordinateMasses (N * d)) (F : Force (N * d))
    (Q : Set (Position (N * d))) (a b : ℝ)
    (γ : ℝ → PhaseSpace (N * d))
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hFsum : ∀ q ∈ Q, ∀ c : Fin d,
      ∑ i : Fin N, F q (particleCoordinateEquiv N d (i, c)) = 0)
    (c : Fin d) (s t : ℝ)
    (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    totalMomentumCoordinate (γ s).2 c = totalMomentumCoordinate (γ t).2 c := by
  exact @MolecularDynamics.totalMomentumCoordinate_const_on_Ioo

/-- source_id: MD-1.7-CentralAngularMomentum · unnumbered_claim · printed p.39 / PDF p.62
[EXTRA] 真实位置和动量导数；反对称内力和沿位移方向中心力。

-/
theorem centralangularmomentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t := by
  sorry

/-- source_id: MD-1.7-CenterOfMassMotion · unnumbered_claim · printed p.39 / PDF p.62
[EXTRA] 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。

-/
theorem centerofmassmotion :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i)) := by
  sorry

/-- source_id: MD-1.7-ConstantRotationLiteral · unnumbered_claim · printed p.39 / PDF p.62

[ERRATUM?] 角动量常数不推出角速度常数；中心运动r变时θ̇=ℓ/r²。例r(t)=sqrt(1+t²),θ(t)=arctan t,ℓ=1。
-/
theorem constantrotationliteral :
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  sorry

/-- source_id: MD-1.7-IsoscelesCoordinates · definition · printed p.39 / PDF p.62

[ERRATUM?] 同段“零平动/角动量→等腰”一般过强；这里只定义明确给定的对称配置，不把任意零动量当等腰。
-/
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

/-- source_id: MD-1.7-IsoscelesEnergyReduction · unnumbered_claim · printed p.39 / PDF p.62
[EXTRA] 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。

-/
theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w := by
  sorry

/-- source_id: MD-1.7-IsoscelesAccessibleRegion · unnumbered_claim · printed p.40 / PDF p.63


-/
theorem isoscelesaccessibleregion :
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E := by
  exact MolecularDynamics.Chapter01Review.isoscelesEnergyBound_proved

/-- source_id: MD-1.7-EquilateralTrimerMinimum · Example 1.8 (Planar Lennard-Jones Trimer) · printed p.38 / PDF p.61
[EXTRA] 单位LJ；非碰撞配置。

-/
theorem equilateraltrimerminimum :
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6)) := by
  sorry

/-- source_id: MD-1.7-TrimerEnergyLowerBound · unnumbered_claim · printed p.40 / PDF p.63


-/
theorem trimerenergylowerbound :
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q := by
  exact MolecularDynamics.Chapter01Review.trimerLowerBound_proved

/-- source_id: MD-1.7-CollinearTrimer · definition · printed p.40 / PDF p.63


-/
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)

/-- source_id: MD-1.7-TrimerSaddle · unnumbered_claim · printed p.40–41 / PDF p.63–64
[EXTRA] x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。

-/
theorem trimersaddle :
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0 := by
  sorry

/-- source_id: MD-1.7-TrimerEscapeLiteral · unnumbered_claim · printed p.40 / PDF p.63

[ERRATUM?] 保留原文每个body最终逃逸到∞的字面结论及前段质心固定、等腰、零角动量背景；正能量到散射的论证缺失，待导师裁定。
-/
theorem trimerescapeliteral :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop := by
  sorry

/-- source_id: MD-1.7.1-ChaosConditions · definition · printed p.41–42 / PDF p.64–65
[EXTRA] 敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。
[EXTRA] topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。

-/
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D

/-- source_id: MD-1.7.1-TransitivityErgodicityLiteral · unnumbered_claim · printed p.42 / PDF p.65
[EXTRA] 为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。
[ERRATUM?] 拓扑传递和给定测度遍历通常不等价；μ=0时identity流遍历为真而传递为假。非退化概率测度也需进一步限定。
-/
theorem transitivityergodicityliteral :
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ) := by
  sorry

/-- source_id: MD-1.7.1-AnisotropicOscillator · Example 1.9 (Anisotropic Oscillator) · printed p.42 / PDF p.65
[EXTRA] 定义在r=0用Lean总函数延拓，物理域r>0。

-/
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2

/-- source_id: MD-1.7.2-FlowJacobianLiteral · definition · printed p.44 / PDF p.67

[ERRATUM?] 标准变分矩阵应为DξFt(ξ)，原文把取值点写Ftξ；忠实保留字面定义，后续两条不静默改。
-/
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)

/-- source_id: MD-1.7.2-VariationalEquationLiteral · unnumbered_claim · printed p.44–45 / PDF p.67–68

[ERRATUM?] 前条字面W=D Ft(Ftξ)多出取值点移动链式项。局部标量f(z)=z²,Ftξ=ξ/(1-tξ)：W=(1-tξ)²/(1-2tξ)²；t=0的W′=2ξ相合，但t≠0一般不满足原式。
-/
theorem variationalequationliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t := by
  sorry

/-- source_id: MD-1.7.2-NearbyTrajectoryLiteral · unnumbered_claim · printed p.45 / PDF p.68
[EXTRA] ≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。
[ERRATUM?] 原文字面W在Ftξ而不是ξ；前条非线性流提供不同Jacobian的反例，不能用修正版flowFirstOrder_proof冒充。
-/
theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  sorry

/-- source_id: MD-1.7.2-SingularValues · definition · printed p.45 / PDF p.68
[EXTRA] 用存在正交特征基刻画谱关系；不是以要证明的椭球图像结论为假设。

-/
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)

/-- source_id: MD-1.7.2-SingularEllipsoid · unnumbered_claim · printed p.45 / PDF p.68
[EXTRA] regular=可逆；单位球面，正交主轴O及半轴σ；平移/半径可按线性缩放恢复。

-/
theorem singularellipsoid :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1} := by
  sorry

/-- source_id: MD-1.7.2-LyapunovExponents · definition · printed p.45 / PDF p.68
[EXTRA] 扩展实数EReal允许±∞，原文未保证极限有限；σ(t)>0在可逆流Jacobian背景，避免log0。

-/
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop

/-- source_id: MD-1.7.2-PositiveLyapunovGrowth · unnumbered_claim · printed p.45 / PDF p.68
[EXTRA] 依据limsup只能得到任意晚时间仍有指数放大，即无穷时间子列；不添加所有足够大t统一增长。

-/
theorem positivelyapunovgrowth :
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t := by
  intro σ hσ hpos
  obtain ⟨c,hc,hclim⟩ := EReal.exists_between_coe_real hpos
  refine ⟨c,EReal.coe_pos.mp hc,?_⟩
  intro T
  change (c : EReal) < Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop at hclim
  have hf := Filter.frequently_lt_of_lt_limsup (h := hclim)
  obtain ⟨t,htc,htt⟩ := (hf.and_eventually (eventually_gt_atTop (max T 0))).exists
  have ht : 0 < t := lt_of_le_of_lt (le_max_right T 0) htt
  refine ⟨t,lt_of_le_of_lt (le_max_left T 0) htt,?_⟩
  have hl : c < Real.log (σ t)/t := EReal.coe_lt_coe_iff.mp htc
  have he : c*t < Real.log (σ t) := (lt_div_iff₀ ht).mp hl
  exact (Real.exp_lt_exp.mpr he).trans_eq (Real.exp_log (hσ t ht))

/- END FULL SECTION 1.7 -/

end MD.Ch01
