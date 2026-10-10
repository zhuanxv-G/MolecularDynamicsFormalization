import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator
noncomputable section
namespace MD.Ch02
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

def bp_rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i

def bp_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)

theorem rk4Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ, compactTrajectory f γ τ → globalOrder (rk4 f) γ τ 4 := by
  sorry

theorem explicitRK :
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ⊤ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry

theorem rkSymplectic : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) ↔
    (∀ n (H : SymplecticCoordinates n → ℝ) h
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G) := by
  sorry

theorem gaussFamily :
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ methodLocalOrder G F (2*s) := by
  sorry

def bp_midpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop :=
  w = z + h • f ((1/2 : ℝ) • (z+w))

theorem midpointProperties :
  ∀ n (H : SymplecticCoordinates n → ℝ) (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    ContDiff ℝ 4 H → ContDiff ℝ 1 (Function.uncurry G) →
    (∀ h z, G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z))) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (textbookHamiltonianVectorField H (F t z)) t) →
    (∀ h, IsTextbookSymplecticMap (G h)) ∧ methodLocalOrder G F 2 := by
  sorry

def gaussTwoData : Matrix (Fin 2) (Fin 2) ℝ × (Fin 2 → ℝ) :=
  (gaussTwoCoefficients, fun _ => 1/2)

def bp_partitionedVerletRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) (p : Q n) : Prop :=
  p = z.2 - (h/2) • partialQ H z.1 p ∧
  w.1 = z.1 + (h/2) • (partialP H z.1 p + partialP H w.1 p) ∧
  w.2 = p - (h/2) • partialQ H w.1 p

theorem partitionedReduction :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z w,
    positiveMass m → Differentiable ℝ U →
    ((∃ p, partitionedVerletRelation (fun z : Z n => (∑ i, z.2 i^2/m i)/2+U z.1) h z w p) ↔
      w = verlet m (fun q => -grad U q) h z) := by
  sorry

def bp_generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2

theorem generalSymplectic :
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n) h,
    ContDiff ℝ 2 H → ContDiff ℝ 1 G →
    (∀ z, generalSymplecticEulerRelation H h (unpack z) (unpack (G z))) → IsTextbookSymplecticMap G := by
  sorry

theorem generalVerletSymplectic :
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (p : SymplecticCoordinates n → Q n) h, ContDiff ℝ 2 H → ContDiff ℝ 1 G → ContDiff ℝ 1 p →
    (∀ z, partitionedVerletRelation H h (unpack z) (unpack (G z)) (p z)) → IsTextbookSymplecticMap G := by
  sorry

def bp_newmarkRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (γ β h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 + (h*(1-γ)) • F z.1 + (h*γ) • F w.1 ∧
  w.1 = z.1 + h • invMass m z.2 + (h^2*(1/2-β)) • F z.1 + (h^2*β) • F w.1

theorem newmarkReduction : ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkRelation m F (1/2) 0 h z w ↔ w=verlet m F h z := by
  sorry

theorem newmarkDamping :
  ∀ (G : Q 2 → Q 2) Ω β h,
    ContDiff ℝ 1 G → (∀ z,
      G z 1 = z 1-h/2*Ω^2*(z 0+G z 0) ∧
      G z 0 = z 0+h*z 1-h^2*((1/2-β)*Ω^2*z 0+β*Ω^2*G z 0)) →
    1+h^2*β*Ω^2 ≠ 0 → ∀ z, (textbookCoordinateJacobian G z).det = 1 := by
  sorry

theorem newmarkNotSymplectic :
  ∃ (U : Q 1 → ℝ) (β h : ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1),
    ContDiff ℝ 3 U ∧ β ≠ 0 ∧ h ≠ 0 ∧ ContDiff ℝ 1 G ∧
    (∀ z, newmarkMassCorrected (fun _ => 1) (textbookPotentialForce U) (1/2) β h
      (unpack z) (unpack (G z))) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry

def bp_multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j

def tiMethod {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h

theorem tiForce :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q - (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q)) := by
  sorry

theorem tiOrder :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
    ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
      solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
      ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        oneStepMaxError (fun h => textbookProcessedMethod χ
          (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
          (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
  sorry

def beeman {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (qPrev : Q n) (z : Z n) : Z n :=
  let a := invMass m (F z.1)
  let aPrev := invMass m (F qPrev)
  let q := z.1+h • invMass m z.2+(h^2/6) • ((4 : ℝ) • a-aPrev)
  let p := z.2+(h/6) • mass m ((2 : ℝ) • invMass m (F q)+(5 : ℝ) • a-aPrev)
  (q,p)

theorem beemanOrder : ∀ n (m : Fin n → ℝ) (F : Q n → Q n)
    (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 1 < ν₀ ∧ ∀ ν ≥ ν₀,
      ∀ z : ℕ → Z n, z 0=γ 0 → z 1=γ (τ/ν) →
        (∀ k, 1 ≤ k → z (k+1)=beeman m F (τ/ν) (z (k-1)).1 (z k)) →
        ∀ k ≤ ν, ‖z k-γ (k*(τ/ν))‖ ≤ C*(τ/ν)^3 := by
  sorry

theorem gaussTwoOrder : ∀ n (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → ContDiff ℝ 6 (Function.uncurry G) →
    (∀ h z, ∃ stages : Fin 2 → Q n,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) stages) →
    globalOrder G γ τ 4 := by
  sorry
end MD.Ch02
