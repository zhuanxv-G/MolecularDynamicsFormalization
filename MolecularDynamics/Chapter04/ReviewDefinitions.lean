import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan
import Mathlib.Basic.Complex.Basic
import MolecularDynamics.Chapter02.ReviewDefinitions
import MolecularDynamics.Chapter04.CotangentProjectionRegularity
import MolecularDynamics.Chapter04.ConstrainedReactionRegularity
import MolecularDynamics.Chapter04.ConstrainedFlowSymplectic

/-! Chapter 4 mathematical definitions and algorithm relations.
Relations record all updates but do not assert existence of implicit branches.
Printed inconsistencies are kept separately from mass-consistent formulas. -/
open Set Matrix
open scoped BigOperators Topology Matrix.Norms.Elementwise
noncomputable section
namespace MolecularDynamics.Chapter04Review
abbrev Q (n : ℕ) := Fin n → ℝ
abbrev Z (n : ℕ) := Q n × Q n
abbrev V := Fin 3 → ℝ
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
def symplecticMap {n : ℕ} (G : Z n → Z n) : Prop :=
  ∀ z u v, phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v) = phaseForm u v
def linearField {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (z : Fin n → ℂ) := A *ᵥ z
def eulerFactor (h : ℝ) (rho : ℂ) : ℂ := 1 + (h : ℂ) * rho
def eulerStabilityRegion : Set ℂ := {z | ‖1+z‖ ≤ 1}
def scalarStable (a : ℂ) : Prop := ∃ C : ℝ, ∀ k : ℕ, ‖a^k‖ ≤ C
def matrixStable (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ C : ℝ, ∀ k : ℕ, ∀ v : Fin 2 → ℝ, ‖A^k *ᵥ v‖ ≤ C*‖v‖
def oscillatorMatrix (Ω : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![0,1; -Ω^2,0]
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
def verletMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2/2,h; -h*Ω^2*(1-h^2*Ω^2/4),1-h^2*Ω^2/2]
def eigenvalueOutside (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ rho : ℂ, 1 < ‖rho‖ ∧ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (A.map Complex.ofReal) *ᵥ v = rho • v
def printedImplicitRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z znew : Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
def actualMidpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z znew : Q n) : Prop :=
  znew=z+h • f ((1/2 : ℝ) • (z+znew))
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
def modifiedFrequency (Ω h : ℝ) : ℝ := 2*Real.arctan (h*Ω/2)/h
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (h : ℝ) (z mid out : Z n) : Prop :=
  mid.1=z.1+(h/2) • invMass m mid.2 ∧ mid.2=z.2-(h/2) • grad U mid.1 ∧
  out.1=mid.1+(h/2) • invMass m mid.2 ∧ out.2=mid.2-(h/2) • grad U mid.1
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : Q n → ℝ) (z : Z n) : ℝ :=
  dot z.2 (invMass m z.2)/2+US z.1+UF z.1
def kick {n : ℕ} (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n := (z.1,z.2-h • grad U z.1)
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  Chapter02Review.verlet m (fun q => -grad UF q) h
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : Q n → ℝ) (r : ℕ) (h : ℝ) (z : Z n) : Z n :=
  kick US (h/2) ((fastVerlet m UF (h/r))^[r] (kick US (h/2) z))
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
def mollifiedAverage {n : ℕ} (m : Fin n → ℝ) (UF : Q n → ℝ)
    (K : ℕ) (w : ℕ → ℝ) (δ : ℝ) (q : Q n) : Q n :=
  (1/(K+1 : ℝ)) • ∑ i ∈ Finset.range (K+1), w i • ((fastVerlet m UF δ)^[i] (q,0)).1
def mollifiedPotential {n : ℕ} (US : Q n → ℝ) (A : Q n → Q n) := US ∘ A
def holonomicRelation {n l : ℕ} (g : Q n → ℝ → Q l) (q : ℝ → Q n) : Prop :=
  ∀ t, g (q t) t=0
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) : Set (Z n) :=
  {z | z.1 ∈ constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ invMass m z.2=0}
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (q p : ℝ → Q n) (rho : ℝ → Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ constraintSet g
def restrictedForm {n : ℕ} (chart : Z n → Z n) (z u v : Z n) : ℝ :=
  phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)
def tangentPhase {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (z v : Z n) : Prop :=
  ∀ j, (fderiv ℝ (g j) z.1) v.1=0 ∧
    (fderiv ℝ (fun x : Z n => (fderiv ℝ (g j) x.1) (invMass m x.2)) z) v=0
def restrictedSymplectic {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (G : Z n → Z n) : Prop :=
  ∀ z ∈ cotangentSet m g, ∀ u v, tangentPhase m g z u → tangentPhase m g z v →
    phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=phaseForm u v
def positionEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (rho : Q l) : Prop :=
  out.2=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m out.2 ∧ out.1 ∈ constraintSet g
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base η)⁻¹ *ᵥ projectionResidual m g q base η
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base 0)⁻¹ *ᵥ projectionResidual m g q base η
def componentConstraintStep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q Qnow : Q n) (j : Fin l) : Q n :=
  Qnow-(g j Qnow / dot (grad (g j) Qnow) (invMass m (grad (g j) q))) •
    invMass m (grad (g j) q)
def componentSweep {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q Qnow : Q n) : Q n :=
  (List.finRange l).foldl (fun Qcur j => componentConstraintStep m g q Qcur j) Qnow
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (pbar : Q n) (rho μ : Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m pbar ∧ out.1 ∈ constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ cotangentSet m g
def shakePositionPrinted {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (a b c : Q n) (rho : Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • invMass m (F b)-h^2 • ((textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ constraintSet g
def shakePositionRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (a b c : Q n) (rho : Q l) : Prop :=
  c-(2 : ℝ) • b+a=h^2 • invMass m (F b-(textbookConstraintJacobian g b)ᵀ *ᵥ rho) ∧
  c ∈ constraintSet g
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho rhonew : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ cotangentSet m g
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : Q n) (rho : Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • invMass m newHalf ∧ qnew ∈ constraintSet g
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ cotangentSet m g
def momentumProjector {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (q : Q n) :=
  (1 : Matrix (Fin n) (Fin n) ℝ)-(textbookConstraintJacobian g q)ᵀ *
    (textbookConstraintGram m g q)⁻¹ * textbookConstraintJacobian g q * textbookInverseMassMatrix m
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q p : ℝ → Q n) (rho : ℝ → Q l) (I : Set ℝ) : Prop :=
  constrainedSolution m (fun _ => 0) g q p rho I
def mShakeIteration {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (k : ℕ) := (newtonConstraint m g q base)^[k] 0
def settleRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Prop := projectionResidual m g q base η=0
def lincsInverse {l : ℕ} (C : Matrix (Fin l) (Fin l) ℝ) (k : ℕ) := ∑ j ∈ Finset.range (k+1), C^j
def totalMass {N : ℕ} (m : Fin N → ℝ) : ℝ := ∑ i, m i
def centerMass {N : ℕ} (m : Fin N → ℝ) (q : Fin N → V) : V :=
  (totalMass m)⁻¹ • ∑ i, m i • q i
def relativePositions {N : ℕ} (m : Fin N → ℝ) (q : Fin N → V) : Fin N → V :=
  fun i => q i-centerMass m q
def outer (v : V) : Mat3 := fun i j => v i*v j
def secondMoment {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 := ∑ i, m i • outer (δ i)
def rotationKinetic (R dΘ : Mat3) : ℝ := (dΘ*R*dΘᵀ).trace/2
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 :=
  ∑ i, m i • (dot (δ i) (δ i) • (1 : Mat3)-outer (δ i))
def rotationalEnergy (T : Mat3) (ω : V) : ℝ := dot ω (T *ᵥ ω)/2
def rigidHamiltonian (M : ℝ) (R : Mat3) (U : V → Mat3 → ℝ) (q p : V) (Θ mom : Mat3) : ℝ :=
  dot p p/(2*M)+(mom*R⁻¹*momᵀ).trace/2+U q Θ
def matrixGrad (U : Mat3 → ℝ) (Θ : Mat3) : Mat3 :=
  fun i j => (fderiv ℝ U Θ) (Pi.single i (Pi.single j 1))
def rigidMatrixRelation (M : ℝ) (R : Mat3) (U : V → Mat3 → ℝ)
    (q p : ℝ → V) (Θ mom Λ : ℝ → Mat3) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → V) : V :=
  ∑ i, m i • cross3 (δ i) (v i)
def bodyMomentum (Θ : Mat3) (l : V) : V := Θᵀ *ᵥ l
def eulerRigidField (T : Mat3) (π : V) : V := cross3 π (T⁻¹ *ᵥ π)
def freeRigidSolution (T : Mat3) (π : ℝ → V) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (eulerRigidField T (π t)) I t
def rigidPoissonMatrix (π : V) : Mat3 := skewMatrix π
def axisRotation (i : Fin 3) (φ : ℝ) : Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
def spinAxis (I : V) (i : Fin 3) (h : ℝ) (s : V × Mat3) : V × Mat3 :=
  let R := axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)
def spinStep (I : V) (h : ℝ) : V × Mat3 → V × Mat3 :=
  spinAxis I 0 (h/2) ∘ spinAxis I 1 (h/2) ∘ spinAxis I 2 h ∘
    spinAxis I 1 (h/2) ∘ spinAxis I 0 (h/2)
def rigidForce (U : V → Mat3 → ℝ) (q : V) (Θ : Mat3) := -grad (fun x => U x Θ) q
def matrixRot (A : Mat3) : V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
def rigidTorque (U : V → Mat3 → ℝ) (q : V) (Θ : Mat3) := -matrixRot (Θᵀ*matrixGrad (U q) Θ)
abbrev RBState := (V × V) × (V × Mat3)
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
def rigidSpin (I : V) (h : ℝ) (z : RBState) : RBState := (z.1,spinStep I h z.2)
def dlmMassConsistent (M : ℝ) (I : V) (U : V → Mat3 → ℝ) (h : ℝ) : RBState → RBState :=
  rigidKick U (h/2) ∘ rigidSpin I h ∘ rigidDrift M h ∘ rigidKick U (h/2)
def dlmPrinted (I : V) (U : V → Mat3 → ℝ) (h : ℝ) := dlmMassConsistent 1 I U h
def rbForm (z u v : RBState) : ℝ :=
  let ξ := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*u.2.2)
  let η := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*v.2.2)
  phaseForm u.1 v.1+dot ξ v.2.1-dot η u.2.1+dot z.2.1 (cross3 ξ η)
def rbTangent (z v : RBState) : Prop := z.2.2ᵀ*v.2.2+v.2.2ᵀ*z.2.2=0
def rbSymplectic (G : RBState → RBState) : Prop :=
  ∀ z, z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 → ∀ u v, rbTangent z u → rbTangent z v →
    rbForm (G z) ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=rbForm z u v
def prkOscillatorRelation {s : ℕ} (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (Ω h : ℝ) (z out : Fin 2 → ℝ) (q p : Fin s → ℝ) : Prop :=
  (∀ i, q i=z 0+h*∑ j,A i j*p j) ∧
  (∀ i, p i=z 1-h*Ω^2*∑ j,B i j*q j) ∧
  out 0=z 0+h*∑ i,b i*p i ∧ out 1=z 1-h*Ω^2*∑ i,c i*q i
end MolecularDynamics.Chapter04Review
