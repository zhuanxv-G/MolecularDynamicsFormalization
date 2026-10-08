import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import MolecularDynamics.Chapter02.CompositionMethods
import MolecularDynamics.Chapter02.ProcessedMethods
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.OneStepConvergence
import MolecularDynamics.Chapter03.LiePoisson

/-! Chapter 2 review definitions. Relations for implicit methods do not
assert existence or uniqueness of a solver. All arithmetic is over the reals. -/
open Set Filter Matrix
open scoped BigOperators Topology
noncomputable section
namespace MolecularDynamics.Chapter02Review
abbrev Q (n : ℕ) := Fin n → ℝ
abbrev Z (n : ℕ) := Q n × Q n
abbrev exactAndNumericalMaps (n : ℕ) := (ℝ → Q n → Q n) × (ℝ → Q n → Q n)
def meshTime (h : ℝ) (n : ℕ) : ℝ := n * h
def nodeError {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (h : ℝ) (k : ℕ) : ℝ :=
  ‖oneStepIterate G h (γ 0) k - γ (meshTime h k)‖
def convergentMethod {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)
def globalOrder {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ C * (τ / ν) ^ r
def taylor2 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)
def admissibleCurve {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  ContDiff ℝ 2 q ∧ q a = x ∧ q b = y
def action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
def variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
def stationaryAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ 2 η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0
def variationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop := HasFDerivAt F A q
abbrev discretePath (n ν : ℕ) := Fin (ν + 1) → Q n
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
def mass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => m i * v i
def mechanicalL {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (q v : Q n) : ℝ :=
  (∑ i, m i * v i ^ 2) / 2 - U q
def discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)
def discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)
def replaceNode {n : ℕ} (q : ℕ → Q n) (k : ℕ) (x : Q n) : ℕ → Q n :=
  Function.update q k x
def discreteStationary {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k < ν →
    fderiv ℝ (fun x => discreteAction L (replaceNode q k x) h ν) (q k) = 0
def stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  c - (2 : ℝ) • b + a = h^2 • invMass m (F b)
def velocityVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vhalf := z.2 + (h/2) • invMass m (F z.1)
  let qnew := z.1 + h • vhalf
  (qnew, vhalf + (h/2) • invMass m (F qnew))
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
def leapfrog {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vnew := z.2 + h • invMass m (F z.1)
  (z.1 + h • vnew, vnew)
def leapfrogInitialize {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 - (h/2) • invMass m (F z.1)
def leapfrogReconstruct {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 + (h/2) • invMass m (F z.1)
def consistentOrder {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  ∃ K > 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t) - G h (γ t)‖ ≤ K * h ^ (p+1)
def stableMethod {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u - G h w‖ ≤ (1+h*L) * ‖u-w‖
def firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
def divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace
def linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S
def asymmetricEulerRelation (f g : ℝ → ℝ → ℝ) (h u v U V : ℝ) : Prop :=
  U = u + h*f U v ∧ V = v + h*g U v
abbrev oneForm (n : ℕ) := Q n → Q n →L[ℝ] ℝ
def differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g
def twoForm (n : ℕ) :=
  {A : Q n → Q n →L[ℝ] Q n →L[ℝ] ℝ // ∀ z u v, A z u v = -A z v u}
def pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)
def pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)
def preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v
def symplecticIntegrator {n : ℕ} (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∀ h, IsTextbookSymplecticMap (G h)
def backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
def harmonicAnharmonic (Ω : ℝ) (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
def newtonStep {n : ℕ} (g : Q n → Q n) (τ x : Q n) (A : Q n ≃L[ℝ] Q n) : Q n :=
  x - A.symm (g x - τ)
def rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
def rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)
def midpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop :=
  w = z + h • f ((1/2 : ℝ) • (z+w))
def gaussTwoCoefficients : Matrix (Fin 2) (Fin 2) ℝ :=
  !![(1/4 : ℝ), 1/4-Real.sqrt 3/6; 1/4+Real.sqrt 3/6, 1/4]
def partialQ {n : ℕ} (H : Z n → ℝ) (q p : Q n) : Q n :=
  fun i => (fderiv ℝ (fun x => H (x,p)) q) (Pi.single i 1)
def partialP {n : ℕ} (H : Z n → ℝ) (q p : Q n) : Q n :=
  fun i => (fderiv ℝ (fun x => H (q,x)) p) (Pi.single i 1)
def generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2
def partitionedVerletRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) (p : Q n) : Prop :=
  p = z.2 - (h/2) • partialQ H z.1 p ∧
  w.1 = z.1 + (h/2) • (partialP H z.1 p + partialP H w.1 p) ∧
  w.2 = p - (h/2) • partialQ H w.1 p
def newmarkRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (γ β h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 + (h*(1-γ)) • F z.1 + (h*γ) • F w.1 ∧
  w.1 = z.1 + h • invMass m z.2 + (h^2*(1/2-β)) • F z.1 + (h^2*β) • F w.1
def newmarkMassCorrected {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (γ β h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 + (h*(1-γ)) • F z.1 + (h*γ) • F w.1 ∧
  w.1 = z.1 + h • invMass m z.2 + (h^2*(1/2-β)) • invMass m (F z.1) +
    (h^2*β) • invMass m (F w.1)
def multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i
def pack {n : ℕ} (z : Z n) : SymplecticCoordinates n := Sum.elim z.1 z.2
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
def splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
def compactTrajectory {n : ℕ} (f : Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  0 < τ ∧ ContDiff ℝ 6 f ∧ solution f γ 0 τ ∧ ContinuousOn γ (Icc 0 τ)
def mechanicalField {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) : Z n :=
  (invMass m z.2, F z.1)
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
end MolecularDynamics.Chapter02Review
