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

/-- source_id: MD-2-HamiltonianODE · definition · §2 · 印刷p.53 / PDFp.75
[EXTRA] 原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。 -/
def hamiltonianODE {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t

/-- source_id: MD-2-Hamiltonian · definition · §2 · 印刷p.53 / PDFp.75
[EXTRA] 固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。 -/
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n) :
    PhaseSpace n → ℝ := massHamiltonian m U

/-- source_id: MD-2-CanonicalJ · definition · §2 · 印刷p.53 / PDFp.75 -/
def canonicalJ (n : ℕ) : Matrix (Sum (Fin n) (Fin n)) (Sum (Fin n) (Fin n)) ℝ :=
  textbookJ n

/-- source_id: MD-2-Euler · definition · §2 · 印刷p.54 / PDFp.76 -/
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z

/-- source_id: MD-2-OneStep · definition · §2 · 印刷p.54 / PDFp.76 -/
def numericalTrajectory {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (n : ℕ) : E :=
  (G h)^[n] ζ

/-- source_id: MD-2.1-Convergence · definition · §2.1 · 印刷p.55 / PDFp.77
[EXTRA] 按固定时间窗网格h=τ/ν表达任意精度；τ>0在具体定理中明示。 -/
def convergence {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)

/-- source_id: MD-2.1-Order · definition · §2.1 · 印刷p.55 / PDFp.77
[EXTRA] 自然数阶r；ν₀>0避免零除；K选择严格正不损失误差上界。 -/
def order {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ K > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ K * (τ / ν)^r

/-- source_id: MD-2.1-Error · definition · §2.1 · 印刷p.56 / PDFp.78 -/
def maximumError {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G : ℝ → E → E) (γ : ℝ → E) (h : ℝ) (ν : ℕ) : ℝ :=
  oneStepMaxError G h γ ν

/-- source_id: MD-2.1-Thm2.1 · Theorem 2.1 · §2.1 · 印刷p.56 / PDFp.78
[EXTRA] 时间长度τ≥0显式化；f以环境全函数表示，只在开放D上要求C¹。 -/
theorem theorem_2_1 {m : ℕ} (D : Set (Position m))
    (hDb : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t)
    (_hunique : ∀ η : ℝ → Position m, η 0 = γ 0 → MapsTo η (Icc 0 τ) D →
      (∀ t ∈ Icc 0 τ, HasDerivWithinAt η (f (η t)) (Icc 0 τ) t) →
      ∀ t ∈ Icc 0 τ, η t = γ t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ)) := by
  exact MolecularDynamics.theorem_2_1_euler D hDb hD f hf γ hτ hγD hγ

/-- source_id: MD-2.1.2-SecondDerivative · unnumbered_claim · §2.1.2 · 印刷p.59 / PDFp.81
[EXTRA] 解γ取C²；原文连续求两次时间导数的正则性显式化。 -/
theorem odeSecondDerivative :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t := by
  intro n f γ hf hγ hode t
  have heq : deriv γ = fun s => f (γ s) := funext (fun s => (hode s).deriv)
  rw [heq]
  exact ((hf.differentiable (by norm_num)).differentiableAt.hasFDerivAt).comp_hasDerivAt t (hode t)

/-- source_id: MD-2.1.2-Taylor2 · Example 2.1 (map) · §2.1.2 · 印刷p.59 / PDFp.81 -/
def taylorSecond {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)

/-- source_id: MD-2.1.2-Taylor2Order · Example 2.1 (order) · §2.1.2 · 印刷p.59 / PDFp.81
[EXTRA] compactTrajectory要求f全域C⁶及实际解在固定紧时间窗连续；强于二阶所需，标[EXTRA]，仍需证明局部误差及稳定留域。 -/
theorem taylor2Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2 := by
  sorry

end MD.Ch02
