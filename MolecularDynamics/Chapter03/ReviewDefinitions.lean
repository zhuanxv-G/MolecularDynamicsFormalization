import MolecularDynamics.Chapter02.ReviewDefinitions
import MolecularDynamics.Chapter03.FormalOperatorSeries
import MolecularDynamics.Chapter03.ModifiedEnergyDrift
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-! Chapter 3 definitions. Formal coefficients, finite functions and actual
flows are distinct objects. Collision relations assume finite isolated events. -/
open Set Filter Matrix MeasureTheory
open scoped BigOperators Topology
noncomputable section
namespace MolecularDynamics.Chapter03Review
open MolecularDynamics.Chapter02Review

def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
def oscillatorEnergy (Ω : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+Ω^2*z.1^2)/2
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2
def oscillatorEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ := (z.1+h*z.2,z.2-h*Ω^2*z.1)
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
def formalField {n : ℕ} (f : Q n → Q n) (fj : ℕ → Q n → Q n) (r : ℕ)
    (z : Q n) (i : Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then f z i else if r ≤ j then fj j z i else 0)
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n)
    (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
def hamiltonianLie {n : ℕ} (H φ : SymplecticCoordinates n → ℝ) : SymplecticCoordinates n → ℝ :=
  textbookLieDerivative (textbookHamiltonianVectorField H) φ
def formalObservable {n : ℕ} (f : Q n → Q n) (φ : Q n → ℝ) (z : Q n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => ((textbookLieDerivative f)^[j] φ) z/(Nat.factorial j : ℝ))
def commutator {R : Type*} [Ring R] (A B : R) : R := A*B-B*A
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
def formalLog {R : Type*} [Ring R] [Algebra ℝ R] (P : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun n => ∑ j ∈ Finset.Icc 1 n,
    ((-1 : ℝ)^(j+1)/(j:ℝ)) • PowerSeries.coeff n ((P-1)^j))
def bchLog4 {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  PowerSeries.mk (fun n => if n=1 then A+B else if n=2 then (1/2 : ℝ) • commutator A B else
    if n=3 then (1/12 : ℝ) • (commutator A (commutator A B)-commutator B (commutator A B)) else
    if n=4 then -(1/24 : ℝ) • commutator B (commutator A (commutator A B)) else 0)
def bchHamiltonian3 {n : ℕ} (A B : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  A z+B z+h/2*textbookPoissonBracket A B z+
    h^2/12*(textbookPoissonBracket A (textbookPoissonBracket A B) z-
      textbookPoissonBracket B (textbookPoissonBracket A B) z)-
    h^3/24*textbookPoissonBracket B (textbookPoissonBracket A (textbookPoissonBracket A B)) z
def quadraticKinetic {n : ℕ} (m : Fin n → ℝ) (p : Q n) : ℝ := (∑ i, p i^2/m i)/2
def mechanicalEnergy {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n) : ℝ := quadraticKinetic m z.2+U z.1
def hessianAction {n : ℕ} (U : Q n → ℝ) (q v : Q n) : Q n := (fderiv ℝ (grad U) q) v
def shadowTerms {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n) : ℝ × ℝ × ℝ :=
  let v := invMass m z.2
  ((∑ i, v i * hessianAction U z.1 v i),
    (∑ i, grad U z.1 i * invMass m (grad U z.1) i),
    (∑ i, invMass m (grad U z.1) i * hessianAction U z.1 v i))
def symplecticEulerShadow3 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z-h/2*(∑ i, invMass m z.2 i*grad U z.1 i)+
    h^2/12*((shadowTerms m U z).1+(shadowTerms m U z).2.1)-h^3/12*(shadowTerms m U z).2.2
def positionVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookPositionDrift m (h/2) ∘ textbookMomentumKick F h ∘ textbookPositionDrift m (h/2)
def verletHamiltonianParts {n : ℕ} (T U : SymplecticCoordinates n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z => U z/2), T, (fun z => U z/2)]
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
def yoshidaRoot (s : ℕ) : ℝ := Real.rpow 2 (1/((2*s+1 : ℕ):ℝ))
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
def generalSplitting {E : Type*} (T U : ℝ → E → E) (coeff : List (ℝ × ℝ)) (h : ℝ) : E → E :=
  coeff.foldr (fun ab acc => T (ab.1*h) ∘ U (ab.2*h) ∘ acc) id
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)
def takahashiProcessor {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n :=
  (z.1-(h^2/12) • invMass m (grad U z.1), z.2+(h^2/12) • hessianAction U z.1 (invMass m z.2))
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)
def equalComponentIntegral (z : ℝ × ℝ) : ℝ := z.1-z.2
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)
def energyProjectionRelation {n : ℕ} (H : Z n → ℝ) (E : ℝ) (z : Z n) : Prop := H z=E
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
def reversedField {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (z : Q n) : Q n :=
  -(R.transpose.mulVec (f (R.mulVec z)))
def correctedReversedField {n : ℕ} (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (z : Q n) : Q n := -R (f (R z))
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
def canonicalReversal {n : ℕ} (z : SymplecticCoordinates n) : SymplecticCoordinates n := Sum.elim
  (fun i => z (Sum.inl i)) (fun i => -z (Sum.inr i))
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
def transportedField {n : ℕ} (A : Q n ≃L[ℝ] Q n) (f : Q n → Q n) (z : Q n) : Q n := A (f (A.symm z))
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)
def complexEigenvalue {ι : Type*} [Fintype ι] [DecidableEq ι] (A : Matrix ι ι ℝ) (ζ : ℂ) : Prop :=
  ∃ v : ι → ℂ, v ≠ 0 ∧ (A.map (fun x => (x : ℂ))).mulVec v = ζ • v
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
def kinetic {n : ℕ} (m : Fin n → ℝ) (p : Position n) : ℝ := (∑ i, p i^2/m i)/2
def elasticCoefficient {n : ℕ} (m : Fin n → ℝ) (u p : Position n) : ℝ :=
  -2*(∑ i, u i*p i/m i)/(∑ i, u i^2/m i)
def elasticReflection {n : ℕ} (m : Fin n → ℝ) (u p : Position n) : Position n := p+elasticCoefficient m u p • u
def collisionComposition {E : Type*} (G : ℝ → E → E) (Rc : E → E) (times : List ℝ) : E → E :=
  match times with
  | [] => id
  | [t] => G t
  | t::u::ts => G t ∘ Rc ∘ collisionComposition G Rc (u::ts)
termination_by times.length
def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  @ite ENNReal (q ∈ hardCoreDomain σ) (Classical.propDecidable _) 0 ⊤
def primitiveSplitting {n : ℕ} (U : Q n → ℝ)
    (Gfree : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ) :=
  textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ Gfree h ∘ textbookMomentumKick (textbookPotentialForce U) (h/2)
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
def collisionQuadraticPath {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) (t : ℝ) : Q n :=
  z.1+t • invMass m z.2+(t^2/2) • invMass m (F z.1)
def collisionTimeRelation {d : ℕ} (a b : ℝ → Position d) (radius t : ℝ) : Prop := 0 < t ∧ ‖a t-b t‖=radius
def collisionalVerletRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z
def pairForceDecoupling (φ α β : ℝ → ℝ) (contact : ℝ) : Prop :=
  (∀ r, φ r=α r+β r) ∧ deriv α contact=0
def modifiedCollisionProjection {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ) (h : ℝ)
    (z w : SymplecticCoordinates n) : Prop :=
  textbookTruncatedHamiltonian H Hj r k h w=textbookTruncatedHamiltonian H Hj r k h z
end MolecularDynamics.Chapter03Review
