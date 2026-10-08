import MolecularDynamics.Chapter02.ReviewDefinitions

/-! Unproved, nonvacuous Chapter 2 review propositions. These definitions
record mathematical obligations and are never counted as proofs. -/
open Set Filter MeasureTheory Matrix
open scoped BigOperators Topology
noncomputable section
namespace MolecularDynamics.Chapter02Review

def odeSecondDerivative_statement : Prop :=
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t
def taylor2Order_statement : Prop :=
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2
def verletOrder_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError (verlet m F) (τ / ν) γ ν ≤ C * (τ / ν)^2
def firstVariation_statement : Prop :=
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    HasDerivAt (fun ε => action L a b (variation q η ε))
      (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) 0
def taylorRemainder_statement : Prop :=
  ∀ n (k : ℕ) (g : Q n → ℝ) z, ContDiff ℝ (k+1) g →
    ∃ C > 0, ∃ δ > 0, ∀ u : Q n, ‖u‖ < δ →
      |g (z+u) - ∑ j ∈ Finset.range (k+1),
        (iteratedFDeriv ℝ j g z (fun _ => u)) / (Nat.factorial j : ℝ)| ≤ C * ‖u‖^(k+1)
def firstVariationParts_statement : Prop :=
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    η a = 0 → η b = 0 →
    (∫ t in a..b, (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
      -(∫ t in a..b, (deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t))
def hamiltonPrinciple_statement : Prop :=
  ∀ n (L : Q n → Q n → ℝ) (q : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q →
    (stationaryAction L a b q ↔ ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x => L x (deriv q t)) (q t)) t)
def stationaryNotMinimum_statement : Prop :=
  ∃ (L : Q 1 → Q 1 → ℝ) (q : ℝ → Q 1),
    ContDiff ℝ 2 (Function.uncurry L) ∧ ContDiff ℝ 2 q ∧ stationaryAction L 0 1 q ∧
    ∀ δ > 0, ∃ η : ℝ → Q 1, ContDiff ℝ 2 η ∧ η 0 = 0 ∧ η 1 = 0 ∧
      (∀ t ∈ Icc (0 : ℝ) 1, ‖η t‖ < δ) ∧ action L 0 1 (fun t => q t + η t) < action L 0 1 q
def discreteActionDerivative_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i
def discreteStationaryVerlet_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν,
    positiveMass m → Differentiable ℝ U → h ≠ 0 →
    (discreteStationary (mechanicalL m U) q h ν ↔
      ∀ k, 0 < k → k < ν → stormerRelation m (fun x => -grad U x) h (q (k-1)) (q k) (q (k+1)))
def velocityVerletStormer_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h (a b c : Z n),
    b = velocityVerlet m F h a → c = velocityVerlet m F h b →
    stormerRelation m F h a.1 b.1 c.1
def errorDifference_statement : Prop :=
  ∀ n (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) h k,
    γ ((k+1 : ℕ)*h) = F h (γ (k*h)) →
    oneStepIterate G h (γ 0) (k+1) - γ ((k+1 : ℕ)*h) =
      G h (oneStepIterate G h (γ 0) k) - F h (γ (k*h))
def scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))
def verletExpansion_statement : Prop :=
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4)
def exactExpansion_statement : Prop :=
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4)
def verletDefectExpansion_statement : Prop :=
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1+
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1)) (fun h : ℝ => h^4)
def verletDefectPrinted_statement : Prop :=
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4)
def verletConsistency_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) (Φ : ℝ → Z n → Z n) (K : Set (Z n)) δ,
    positiveMass m → ContDiff ℝ 3 F → IsCompact K → 0 < δ →
    ContinuousOn (Function.uncurry Φ) (Icc (-δ) δ ×ˢ K) →
    (∀ z ∈ K, Φ 0 z = z ∧ solution (mechanicalField m F) (fun t => Φ t z) (-δ) δ) →
    ∃ C > 0, ∀ h ∈ Icc 0 δ, ∀ z ∈ K, ‖verlet m F h z-Φ h z‖ ≤ C*h^3
def verletStability_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖
def firstIntegralPreserved_statement : Prop :=
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a)
def centralAngularMomentum_statement : Prop :=
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1
def integralMeanValue_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b = (fderiv ℝ I c) (a-b)
def integralLipschitz_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) → |I a-I b| ≤ B*‖a-b‖
def integralError_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/L)*Real.exp (L*k*h)*h^p
def integralErrorPrinted_statement : Prop :=
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/(2*L))*Real.exp (L*k*h)*h^p
def flowC1 {n : ℕ} (f : Q n → Q n) (Φ : ℝ × Q n → Q n) (τ : ℝ) : Prop :=
  ContDiff ℝ 1 f ∧ ContDiff ℝ 1 Φ ∧ (∀ z, Φ (0,z) = z) ∧
    ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (f (Φ (t,z))) t
def liouville_statement : Prop :=
  ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ,
    0 ≤ τ → flowC1 f Φ τ → (∀ z, divergence f z = 0) →
    ∀ t ∈ Icc 0 τ, ∀ S : Set (Q n), MeasurableSet S → volume ((fun z => Φ (t,z)) '' S) = volume S
def hamiltonianVolume_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → volume ((fun z => Φ (t,z)) '' S) = volume S
def volumeChange_statement : Prop :=
  ∀ n (Φ : Q n → Q n) (S : Set (Q n)), ContDiff ℝ 1 Φ → Function.Injective Φ → MeasurableSet S →
    volume (Φ '' S) = ∫⁻ z in S, ENNReal.ofReal |(textbookCoordinateJacobian Φ z).det| ∂volume
def flowVariational_statement : Prop :=
  ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ, ∀ z,
      HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) z)
        (textbookCoordinateJacobian f (Φ (t,z)) * textbookCoordinateJacobian (fun y => Φ (t,y)) z) t
def determinantExponential_statement : Prop :=
  ∀ n (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    Continuous A → (∀ s, HasDerivAt W (A s * W s) s) →
    (W t).det = (W 0).det * Real.exp (∫ s in (0 : ℝ)..t, (A s).trace)
def flowDet_statement : Prop :=
  ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ,
    flowC1 f Φ τ → (∀ z, divergence f z = 0) → ∀ t ∈ Icc 0 τ, ∀ z,
      (textbookCoordinateJacobian (fun y => Φ (t,y)) z).det = 1
def linearDivergence_statement : Prop :=
  ∀ n (S : Matrix (Fin n) (Fin n) ℝ) z, divergence S.mulVec z = S.trace
def linearEulerVolume_statement : Prop :=
  ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T → volume ((linearEuler S h).mulVec '' T) = volume T) ↔
      |(linearEuler S h).det| = 1
def eulerVolumeCounterexample_statement : Prop :=
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1
def asymmetricDet_statement : Prop :=
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))
def asymmetricArea_statement : Prop :=
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    ∀ z, (textbookCoordinateJacobian Ψ z).det = 1
def pullbackMatrix_statement : Prop :=
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v)
def hamiltonianVariational_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, ∀ z, HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,z)) * textbookJacobian (fun y => Φ (t,y)) z) t
def hamiltonianSymplectic_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t,z))
def hamiltonianDet_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det = 1
def globalSymplecticGroup_statement : Prop :=
  ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n), IsTextbookSymplecticMap Φ → Function.Bijective Φ
def wedgeSelf_statement : Prop :=
  ∀ n (α : SymplecticCoordinates n →ₗ[ℝ] ℝ) u v, textbookWedgeOneForms α α u v = 0
def verletComposition_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z)
def verletSymplectic_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h)
def methodLocalOrder {E : Type*} [NormedAddCommGroup E]
    (G F : ℝ → E → E) (r : ℕ) : Prop :=
  ∀ z, ∃ C > 0, ∃ δ > 0, ∀ h : ℝ, |h| < δ → ‖G h z-F h z‖ ≤ C*|h|^(r+1)
def symmetricEvenOrder_statement : Prop :=
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ⊤ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r
def compositionOrder_statement : Prop :=
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s)
def implicitLocal_statement : Prop :=
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n), ContDiff ℝ 1 g → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ U V : Set (Q n), IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g x ∈ V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ 1 inv V ∧
        (∀ y ∈ V, inv y ∈ U ∧ g (inv y) = y) ∧ (∀ y ∈ U, inv (g y) = y)
def newtonQuadratic_statement : Prop :=
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2
def frozenNewton_statement : Prop :=
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 ≤ ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖
def symplecticEulerConjugacy_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h
def rk4Order_statement : Prop :=
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ, compactTrajectory f γ τ → globalOrder (rk4 f) γ τ 4
def explicitRKNotSymplectic_statement : Prop :=
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ¬ (∀ i j, b i*A i j+b j*A j i = b i*b j)
def explicitRKUniversal_statement : Prop :=
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ⊤ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G
def rkSymplectic_statement : Prop :=
  ∀ n s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ)
    (H : SymplecticCoordinates n → ℝ) (h : ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
    ContDiff ℝ 2 H → ContDiff ℝ 1 G → (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
    (∀ i j, b i*A i j+b j*A j i = b i*b j) →
    (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
      G z = z+h • ∑ i, b i • stages z i) → IsTextbookSymplecticMap G
def legendreValue : ℕ → ℝ → ℝ
  | 0, _ => 1
  | 1, x => x
  | k+2, x => (((2*(k:ℝ)+3)*x*legendreValue (k+1) x)-((k:ℝ)+1)*legendreValue k x)/((k:ℝ)+2)
def lagrangeBasis {s : ℕ} (c : Fin s → ℝ) (j : Fin s) (t : ℝ) : ℝ :=
  ∏ k ∈ Finset.univ.erase j, (t-c k)/(c j-c k)
def gaussRK_statement : Prop :=
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ methodLocalOrder G F (2*s)
def midpointProperties_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    ContDiff ℝ 4 H → ContDiff ℝ 1 (Function.uncurry G) →
    (∀ h z, G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z))) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (textbookHamiltonianVectorField H (F t z)) t) →
    (∀ h, IsTextbookSymplecticMap (G h)) ∧ methodLocalOrder G F 2
def partitionedReduction_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z w,
    positiveMass m → Differentiable ℝ U →
    ((∃ p, partitionedVerletRelation (fun z : Z n => (∑ i, z.2 i^2/m i)/2+U z.1) h z w p) ↔
      w = verlet m (fun q => -grad U q) h z)
def generalSymplectic_statement : Prop :=
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n) h,
    ContDiff ℝ 2 H → ContDiff ℝ 1 G →
    (∀ z, generalSymplecticEulerRelation H h (unpack z) (unpack (G z))) → IsTextbookSymplecticMap G
def generalizedVerletSymplectic_statement : Prop :=
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (p : SymplecticCoordinates n → Q n) h, ContDiff ℝ 2 H → ContDiff ℝ 1 G → ContDiff ℝ 1 p →
    (∀ z, partitionedVerletRelation H h (unpack z) (unpack (G z)) (p z)) → IsTextbookSymplecticMap G
def newmarkReduction_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkMassCorrected m F (1/2) 0 h z w ↔ w = verlet m F h z
def newmarkPrintedReduction_statement : Prop :=
  ∀ n (F : Q n → Q n) h z w, newmarkRelation (fun _ => (1 : ℝ)) F (1/2) 0 h z w ↔
    w = verlet (fun _ => 1) F h z
def newmarkNoDamping_statement : Prop :=
  ∀ (G : Q 2 → Q 2) Ω β h,
    ContDiff ℝ 1 G → (∀ z,
      G z 1 = z 1-h/2*Ω^2*(z 0+G z 0) ∧
      G z 0 = z 0+h*z 1-h^2*((1/2-β)*Ω^2*z 0+β*Ω^2*G z 0)) →
    1+h^2*β*Ω^2 ≠ 0 → ∀ z, (textbookCoordinateJacobian G z).det = 1
def newmarkNotSymplectic_statement : Prop :=
  ∃ (U : Q 1 → ℝ) (β h : ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1),
    ContDiff ℝ 3 U ∧ β ≠ 0 ∧ h ≠ 0 ∧ ContDiff ℝ 1 G ∧
    (∀ z, newmarkMassCorrected (fun _ => 1) (textbookPotentialForce U) (1/2) β h
      (unpack z) (unpack (G z))) ∧ ¬ IsTextbookSymplecticMap G
def takahashiForce_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q - (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q))
def takahashiForceCorrected_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q + (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q))
def takahashiOrder_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
    ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
      solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
      ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        oneStepMaxError (fun h => textbookProcessedMethod χ
          (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
          (τ/ν) γ ν ≤ C*(τ/ν)^4
def kineticPotentialComposition_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z)
def localFlowC1 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (D Ω : Set E) (Φ : ℝ × E → E) (τ : ℝ) : Prop :=
  IsOpen D ∧ IsOpen Ω ∧ Ω ⊆ D ∧ ContDiffOn ℝ 1 f D ∧
    ContDiffOn ℝ 1 Φ (Icc 0 τ ×ˢ Ω) ∧
    (∀ z ∈ Ω, Φ (0,z) = z) ∧
    ∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, Φ (t,z) ∈ D ∧
      HasDerivWithinAt (fun s => Φ (s,z)) (f (Φ (t,z))) (Icc 0 τ) t
def localLiouville_statement : Prop :=
  ∀ n (f : Q n → Q n) D Ω (Φ : ℝ × Q n → Q n) τ,
    0 < τ → localFlowC1 f D Ω Φ τ → (∀ z ∈ D, divergence f z = 0) →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) z)
        (textbookCoordinateJacobian f (Φ (t,z))*textbookCoordinateJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookCoordinateJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S)
def localHamiltonianStructures_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S)
end MolecularDynamics.Chapter02Review
