import MolecularDynamics.Chapter05.ReviewProofs
import Mathlib.MeasureTheory.Function.LpSpace.Indicator
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Tactic
open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter05Review
open scoped BigOperators Topology ContDiff InnerProductSpace ENNReal
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch05Short
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)

theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption

def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)

theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i := by
  apply MolecularDynamics.Chapter05Review.coordinatePullback_proved <;> assumption

def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := MolecularDynamics.Chapter05Review.pullback Φ g t

theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i := by
  intro n f z i
  change (fderiv ℝ (fun x : MolecularDynamics.Chapter05Review.E n => x i) z) (f z)=f z i
  change (fderiv ℝ (PiLp.proj 2 (fun _ : Fin n => ℝ) i : MolecularDynamics.Chapter05Review.E n →L[ℝ] ℝ) z) (f z)=f z i
  rw [ContinuousLinearMap.fderiv]
  rfl

end MD.Ch05Short
