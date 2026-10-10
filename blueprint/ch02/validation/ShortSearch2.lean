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
namespace MD.Ch02.ShortSearch
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 2000 in
theorem discreteActionDerivative :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem discreteStationaryVerlet :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν,
    positiveMass m → Differentiable ℝ U → h ≠ 0 →
    (discreteStationary (mechanicalL m U) q h ν ↔
      ∀ k, 0 < k → k < ν → stormerRelation m (fun x => -grad U x) h (q (k-1)) (q k) (q (k+1))) := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖ := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem asymmetricDet :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z) =
        !![(1/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) : ℝ),
          h*deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0));
          h*deriv (fun u => g u (z 1)) (Ψ z 0)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)),
          1+h*deriv (g (Ψ z 0)) (z 1)+h^2*deriv (fun u => g u (z 1)) (Ψ z 0)*
            deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))] ∧
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem asymmetricArea :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T) := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem kickDifferential : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    ContDiff ℝ 2 U → ∀ ξ : SymplecticCoordinates n, ∀ i : Fin n,
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inl i) =
        ξ (Sum.inl i)+h*(m i)⁻¹*((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) ∧
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) =
        ξ (Sum.inr i)-h*((fderiv ℝ (grad U) (z ∘ Sum.inl)) (ξ ∘ Sum.inl)) i := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem compositionOrder :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem frozenNewton :
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 ≤ ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖ := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem partitionedReduction :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z w,
    positiveMass m → Differentiable ℝ U →
    ((∃ p, partitionedVerletRelation (fun z : Z n => (∑ i, z.2 i^2/m i)/2+U z.1) h z w p) ↔
      w = verlet m (fun q => -grad U q) h z) := by
  intros
  aesop

set_option maxHeartbeats 2000 in
theorem newmarkDamping :
  ∀ (G : Q 2 → Q 2) Ω β h,
    ContDiff ℝ 1 G → (∀ z,
      G z 1 = z 1-h/2*Ω^2*(z 0+G z 0) ∧
      G z 0 = z 0+h*z 1-h^2*((1/2-β)*Ω^2*z 0+β*Ω^2*G z 0)) →
    1+h^2*β*Ω^2 ≠ 0 → ∀ z, (textbookCoordinateJacobian G z).det = 1 := by
  intros
  aesop

end MD.Ch02.ShortSearch
