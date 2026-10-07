import MolecularDynamics.Chapter01.ReviewDefinitions
import MolecularDynamics.Chapter01.GeneralizedCoordinates
import MolecularDynamics.Chapter01.KeplerReconstruction
import MolecularDynamics.Chapter01.GlobalFlow
import MolecularDynamics.Chapter01.ScalarIntegrability
import Mathlib.Dynamics.Ergodic.Ergodic

/-! Unproved Chapter 1 propositions. A `def ... : Prop` records a statement,
not a proof. Literal questionable textbook claims are deliberately retained. -/
open Set Filter MeasureTheory
open scoped BigOperators Topology ContDiff
attribute [local instance] Matrix.normedAddCommGroup Matrix.normedSpace
noncomputable section
namespace MolecularDynamics.Chapter01Review
local instance (n : ℕ) : ContinuousSMul ℝ (PhaseSpace n) :=
  IsBoundedSMul.continuousSMul

def morseMinimum_statement : Prop :=
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D)
def lennardJonesSingularity_statement : Prop :=
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop
def coulombForceSign_statement : Prop :=
  ∀ C Qᵢ Qⱼ dielectric r : ℝ, 0 < C → 0 < dielectric → 0 < r →
    -deriv (coulombPotential C Qᵢ Qⱼ dielectric) r = C*Qᵢ*Qⱼ/(dielectric*r^2) ∧
    (0 < -deriv (coulombPotential C Qᵢ Qⱼ dielectric) r ↔ 0 < Qᵢ*Qⱼ) ∧
    (-deriv (coulombPotential C Qᵢ Qⱼ dielectric) r < 0 ↔ Qᵢ*Qⱼ < 0)
def constraintDimension_statement : Prop :=
  ∀ (n r : ℕ) (C : Position n → Position r) (q : Position n),
    DifferentiableAt ℝ C q → Function.Surjective (fderiv ℝ C q) →
    degreesOfFreedom C q + r = n
def pairForceCancellation_statement : Prop :=
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0
def forceGradient_statement {n : ℕ} (U : PotentialEnergy n) (F : Force n) : Prop :=
  ∀ q, F q = -gradient U q
def scalarGlobalPatching_statement : Prop :=
  ∀ (U : ℝ → ℝ) (a b : ℝ) (z : ℝ → ℝ × ℝ),
    ContDiff ℝ ∞ U → (∀ t ∈ Ioo a b,
      HasDerivAt z (scalarPotentialVectorField U (z t)) t) →
    ∃ (J : ℝ → Set ℝ) (X V : ℝ → ℝ → ℝ),
      (∀ s ∈ Ioo a b, IsOpen (J s) ∧ s ∈ J s ∧ J s ⊆ Ioo a b) ∧
      (∀ s ∈ Ioo a b, ∀ t ∈ J s, z t = (X s t,V s t)) ∧
      (∀ s ∈ Ioo a b, ∀ r ∈ Ioo a b, ∀ t ∈ J s ∩ J r,
        X s t = X r t ∧ V s t = V r t) ∧
      ∀ s ∈ Ioo a b, ∀ t ∈ J s,
        HasDerivAt (X s) (V s t) t ∧ HasDerivAt (V s) (-deriv U (X s t)) t
def radialPairForce_statement : Prop :=
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x : V3 => φ ‖x-r‖) q = (deriv φ ‖q-r‖ / ‖q-r‖) • (q-r)

def action {n : ℕ} (L : Position n → Velocity n → ℝ) (a b : ℝ)
    (q : ℝ → Position n) := ∫ t in a..b, L (q t) (deriv q t)
def leastAction_statement : Prop :=
  ∀ (n : ℕ) (L : Position n → Velocity n → ℝ) (q : ℝ → Position n) (a b : ℝ),
    a < b → ContDiff ℝ 2 q → ContDiff ℝ 2 (Function.uncurry L) →
    ((∀ η : ℝ → Position n, ContDiff ℝ 2 η → η a = 0 → η b = 0 →
      HasDerivAt (fun ε : ℝ => action L a b (fun t => q t + ε • η t)) 0 0) ↔
    ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => gradient (L (q s)) (deriv q s))
        (gradient (fun x => L x (deriv q t)) (q t)) t)

def quadraticL {n : ℕ} (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : Position n) :=
  inner ℝ v ((M q).toEuclideanLin v)/2-U q
def quadraticH {n : ℕ} (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) :=
  inner ℝ p ((M q)⁻¹.toEuclideanLin p)/2+U q
def legendreMaximizer_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p v : Position n), (M q).PosDef →
    (inner ℝ p v - quadraticL M U q v = quadraticH M U q p ↔
      v = (M q)⁻¹.toEuclideanLin p)
def generalizedMomentum_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : Position n), (M q).PosDef →
    gradient (quadraticL M U q) v = (M q).toEuclideanLin v
def generalizedHamiltonian_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n), (M q).PosDef →
    quadraticH M U q p =
      inner ℝ p ((M q)⁻¹.toEuclideanLin p)/2+U q
def generalizedLegendreSup_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n), (M q).PosDef →
    sSup (range (fun v => inner ℝ p v - quadraticL M U q v)) = quadraticH M U q p
def generalLegendreEquivalence_statement : Prop :=
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t)
def finiteEnergyPhaseSpace {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}
def phaseDimension_statement : Prop := ∀ N : ℕ, Module.finrank ℝ (PhaseSpace (3*N)) = 6*N
def kineticEnergyBound_statement : Prop :=
  ∀ (n : ℕ) (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q p : Position n) (E Umin : ℝ),
    Umin ≤ U q → massHamiltonian m U (q,p) = E →
    momentumKineticEnergy m p ≤ E-Umin
def positionEnergyBound_statement : Prop :=
  ∀ (n : ℕ) (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q p : Position n) (E Umin : ℝ),
    (∀ i, 0 < m i) → Umin ≤ U q → massHamiltonian m U (q,p) = E →
    Umin ≤ U q ∧ U q ≤ E
def uniformLevelsCompact_statement : Prop :=
  ∀ (n : ℕ) (m : CoordinateMasses n) (U : PotentialEnergy n) (E Umin : ℝ),
    (∀ i, 0 < m i) → Continuous U → (∀ q, Umin ≤ U q) →
    (∃ R : ℝ, ∀ α ∈ Icc Umin E, ∀ q, U q = α → ‖q‖ ≤ R) →
    IsCompact (energySurface (massHamiltonian m U) E)
def nonconfiningExample_statement : Prop :=
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1}

def keplerQuadratureGlobal_statement : Prop :=
  ∀ (a b : ℝ) (r v : ℝ → ℝ) (ℓ : ℝ),
    (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t) →
    ∃ E : ℝ, (∀ t ∈ Ioo a b, keplerRadialEnergy ℓ (r t) (v t) = E) ∧
    ∀ s ∈ Ioo a b, v s ≠ 0 → ∃ δ > 0,
      Ioo (s-δ) (s+δ) ⊆ Ioo a b ∧
      ∀ t ∈ Ioo (s-δ) (s+δ),
        (∫ x in r s..r t, (Real.sign (v s) *
          Real.sqrt (2*E+2/x-ℓ^2/x^2))⁻¹) = t-s
def keplerFullReconstruction_statement : Prop :=
  ∀ (a b t₀ : ℝ) (r v : ℝ → ℝ) (ℓ θ₀ : ℝ), t₀ ∈ Ioo a b →
    (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
      HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t) →
    let θ := fun t => θ₀ + ∫ s in t₀..t, ℓ/(r s)^2
    ∃ q p : ℝ → Position 2,
      (∀ t ∈ Ioo a b, q t = WithLp.toLp 2 ![r t*Real.cos (θ t),r t*Real.sin (θ t)]) ∧
      (∀ t ∈ Ioo a b, HasDerivAt q (p t) t ∧
        HasDerivAt p (keplerForce (q t)) t)
def torusDense_statement : Prop :=
  ∀ (n : ℕ) (Ω : Fin n → ℝ),
    (∀ k : Fin n → ℤ, (∑ i, (k i : ℝ)*Ω i) = 0 → ∀ i, k i = 0) →
    ∀ θ : HarmonicTorus n, DenseRange (fun t : ℝ => harmonicTorusRotation Ω t θ)
def symplecticGradient {d : ℕ} (H : PhaseSpace d → ℝ) (z : PhaseSpace d) : PhaseSpace d :=
  (gradient (fun p => H (z.1,p)) z.2, -gradient (fun q => H (q,z.2)) z.1)
def poissonBracket {d : ℕ} (H K : PhaseSpace d → ℝ) (z : PhaseSpace d) :=
  fderiv ℝ H z (symplecticGradient K z)
def canonicalBilinear {d : ℕ} (u v : PhaseSpace d) :=
  inner ℝ u.1 v.2 - inner ℝ u.2 v.1
def localActionAngle {d : ℕ} (I : Fin d → PhaseSpace d → ℝ)
    (S : Set (PhaseSpace d)) : Prop :=
  ∀ z ∈ S, ∃ (U V : Set (PhaseSpace d)) (φ ψ : PhaseSpace d → PhaseSpace d)
    (Ω : Fin d → Position d → Position d),
    IsOpen U ∧ IsOpen V ∧ z ∈ U ∧ ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
    MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
    (∀ w ∈ U, ∀ u v, canonicalBilinear (fderiv ℝ φ w u) (fderiv ℝ φ w v) =
      canonicalBilinear u v) ∧
    ∀ w ∈ U, ∀ i, fderiv ℝ φ w (symplecticGradient (I i) w) = (0,Ω i (φ w).1)
def liouvilleArnold_statement : Prop :=
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
        ∀ t, e ⟨γ t, (hγ t).1⟩ = harmonicTorusRotation Ω t (e ⟨γ 0, (hγ 0).1⟩)

def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
def isFlowOf {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ x, F 0 x = x) ∧ ∀ x t, HasDerivAt (fun s => F s x) (f (F t x)) t
def stable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, dist x z < δ →
    ∃ B : ℝ, B < ε ∧ ∀ t ≥ 0, dist (F t x) z ≤ B
def hartmanGrobmanLiteral_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x)
def hyperbolicStabilityTransfer_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0)
def positiveHessianQuadraticMinimum_statement : Prop :=
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    IsStrictPotentialMin (fun z : PhaseSpace n =>
      inner ℝ z.2 (M⁻¹.toEuclideanLin z.2)/2 + inner ℝ z.1 (K.toEuclideanLin z.1)/2) 0
def positiveHessianMinimum_statement : Prop :=
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    gradient U q = 0 →
    (∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v)) →
    IsStrictPotentialMin U q
def unorderedPairCount_statement : Prop :=
  ∀ N : ℕ, (Finset.univ.filter (fun p : Fin N × Fin N => p.1 < p.2)).card = N*(N-1)/2
def periodicMomentum_statement : Prop :=
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ) (q : Fin (N+1) → ℝ),
    DifferentiableAt ℝ (boxPeriodicNearestNeighborPotentialEnergy φ L) q →
    fderiv ℝ (boxPeriodicNearestNeighborPotentialEnergy φ L) q (fun _ => 1) = 0
def regularLatticeMinimizer_statement : Prop :=
  ∀ (N : ℕ) (φ : ℝ → ℝ) (L : ℝ), 0 < L →
    ∀ x : Fin (N+1) → ℝ,
    (∀ y : Fin (N+1) → ℝ, boxPeriodicNearestNeighborPotentialEnergy φ L x ≤
      boxPeriodicNearestNeighborPotentialEnergy φ L y) →
    ∃ a : ℝ, regularLattice a (L/(N+1)) x
def minimumGradientZero_statement : Prop :=
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0
def minimumHessianLiteral_statement : Prop :=
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v)
def imaginarySpectrum_statement : Prop :=
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2,-K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y → a = 0
def normalModeComplex_statement : Prop :=
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t
def centralPairGradient_statement : Prop :=
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r
def cross3 (u v : V3) : V3 := WithLp.toLp 2
  ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
def totalAngularMomentum_statement : Prop :=
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t
def centerOfMassMotion_statement : Prop :=
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i))
def rotationLiteral_statement : Prop :=
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq
def isoscelesEnergyBound_statement : Prop :=
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E
def flowErgodic {n : ℕ} (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) : Prop :=
  (∀ t, MeasurePreserving (F t) μ μ) ∧
  ∀ S : Set (Position n), MeasurableSet S →
    (∀ t, F t ⁻¹' S = S) → μ S = 0 ∨ μ Sᶜ = 0
def transitivityErgodicityLiteral_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ)

def variationalEquation_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → ContDiff ℝ 1 (Function.uncurry F) → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => fderiv ℝ (F s) ξ)
      ((fderiv ℝ f (F t ξ)).comp (fderiv ℝ (F t) ξ)) t
def variationalEquationLiteral_statement : Prop :=
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t
def flowFirstOrder_statement : Prop :=
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-fderiv ℝ (F t) ξ (x-ξ)) =o[𝓝 ξ] (fun x => x-ξ)
def singularEllipsoid_statement : Prop :=
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ), IsUnit A →
    singularValues A σ →
    ∃ O : Matrix (Fin n) (Fin n) ℝ, O.transpose*O=1 ∧
      (A.toEuclideanLin '' {v : Position n | ‖v‖=1}) =
        {x : Position n | ∑ i, ((O.transpose.toEuclideanLin x) i / σ i)^2 = 1}
def positiveLyapunovGrowth_statement : Prop :=
  ∀ σ : ℝ → ℝ, (∀ t > 0, 0 < σ t) → 0 < lyapunovExponent σ →
    ∃ c > 0, ∀ T : ℝ, ∃ t > T, Real.exp (c*t) < σ t



def ljCollisionAvoidance_statement : Prop :=
  ∀ (N : ℕ) (ε σ E : ℝ), 0 < ε → 0 < σ → ∃ δ > 0,
    ∀ q : Fin N → V3, (∀ i j, i ≠ j → q i ≠ q j) →
      uniformLJEnergy ε σ q ≤ E → ∀ i j, i ≠ j → δ ≤ pairDistance (q i) (q j)
def ljCoordinateScaling_statement : Prop :=
  ∀ (Q : ℝ → V3) (σ t : ℝ) (v a : V3),
    HasDerivAt Q v t → HasDerivAt (deriv Q) a t →
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
      HasDerivAt (fun s => σ • deriv Q s) (σ • a) t
def ljForce {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) (i : Fin N) : V3 :=
  ∑ j ∈ Finset.univ.erase i,
    (-deriv (lennardJonesPotential ε σ) (pairDistance (q i) (q j)) /
      pairDistance (q i) (q j)) • (q i-q j)
def ljTimeScaling_statement : Prop :=
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    ((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)
def keplerMomentumNotConserved_statement : Prop :=
  ∀ q : Position 2, q ≠ 0 → keplerForce q ≠ 0
abbrev actionAnglePair := ℝ × Real.Angle
def trimerMinimum_statement : Prop :=
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6))
def trimerLowerBound_statement : Prop :=
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
def trimerSaddle_statement : Prop :=
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0
def trimerEscapeLiteral_statement : Prop :=
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => pairDistance (q t i) (q t j)) atTop atTop


end MolecularDynamics.Chapter01Review
