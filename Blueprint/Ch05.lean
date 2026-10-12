import MolecularDynamics.Chapter05.ReviewProofs
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter05Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator
noncomputable section
namespace MD.Ch05
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- source_id: MD-5.1-LieDerivative · definition · §5.1 · 印刷p.180 / PDFp.201 -/
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)

/-- source_id: MD-5.1-TrajectoryChain · unnumbered_claim · §5.1 · 印刷p.180 / PDFp.201
[EXTRA] [EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。 -/
theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption

/-- source_id: MD-5.1-ActualFlow · definition · §5.1 · 印刷p.180 / PDFp.201
[EXTRA] [EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。 -/
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

/-- source_id: MD-5.1-ObservablePullback · definition · §5.1 · 印刷p.180–181 / PDFp.201–202 -/
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)

/-- source_id: MD-5.1-FlowFieldTransport · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。 -/
theorem flowFieldTransport :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z) := by
  sorry

/-- source_id: MD-5.1-PullbackPDE · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。 -/
theorem pullbackPDE :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => MolecularDynamics.Chapter05Review.pullback Φ g s z) (MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z) t := by
  sorry

/-- source_id: MD-5.1-SteadyFirstIntegral · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。 -/
theorem steadyFirstIntegral :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → Differentiable ℝ g → ((∀ z,MolecularDynamics.Chapter05Review.lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z) := by
  intro n f Φ g hflow hg
  constructor
  · intro hz t z
    have ht : ∀ s : ℝ,HasDerivAt (fun u => g (Φ u z)) 0 s := by
      intro s
      have hc := (hg (Φ s z)).hasFDerivAt.comp_hasDerivAt s (hflow.2.2 s z)
      change HasDerivAt (fun u => g (Φ u z)) (MolecularDynamics.Chapter05Review.lie f g (Φ s z)) s at hc
      rw [hz] at hc
      exact hc
    have hh := is_const_of_deriv_eq_zero (fun s => (ht s).differentiableAt) (fun s => (ht s).deriv)
    simpa only [hflow.1] using hh t 0
  · intro hh z
    have hd := (hg (Φ 0 z)).hasFDerivAt.comp_hasDerivAt 0 (hflow.2.2 0 z)
    have heq : (fun s => g (Φ s z))=(fun _ : ℝ => g z) := funext (fun s => hh s z)
    simp only [Function.comp_def] at hd
    rw [heq] at hd
    simpa only [MolecularDynamics.Chapter05Review.lie,hflow.1] using
      hd.unique (hasDerivAt_const 0 (g z))

/-- source_id: MD-5.1-CoordinatePullback · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202 -/
theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i := by
  apply MolecularDynamics.Chapter05Review.coordinatePullback_proved <;> assumption

/-- source_id: MD-5.1-SolutionOperator · definition · §5.1 · 印刷p.181 / PDFp.202 -/
def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := MolecularDynamics.Chapter05Review.pullback Φ g t

/-- source_id: MD-5.1-CoordinateLie · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202 -/
theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i := by
  intro n f z i
  change (fderiv ℝ (fun x : MolecularDynamics.Chapter05Review.E n => x i) z) (f z)=f z i
  change (fderiv ℝ (PiLp.proj 2 (fun _ : Fin n => ℝ) i : MolecularDynamics.Chapter05Review.E n →L[ℝ] ℝ) z) (f z)=f z i
  rw [ContinuousLinearMap.fderiv]
  rfl

/-- source_id: MD-5.1-LiePullbackCommutes · unnumbered_claim · §5.1 · 印刷p.181 / PDFp.202
[EXTRA] [EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。 -/
theorem liePullbackCommutes : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
  sorry

end MD.Ch05
