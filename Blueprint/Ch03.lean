import MolecularDynamics.Chapter03.ReviewProofs
import MolecularDynamics.Chapter02.ReviewProofs
import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.ActualFlowVariations
import MolecularDynamics.Chapter02.LiouvilleVolume
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter01.Lagrangian
import Mathlib.Tactic

open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter02Review MolecularDynamics.Chapter03Review
open scoped BigOperators Topology ContDiff InnerProductSpace Matrix.Norms.L2Operator
noncomputable section
namespace MD.Ch03
variable {n Nc : ℕ}
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {R : Type*} [Ring R] [Algebra ℝ R]

/-- source_id: MD-3-ModifiedConstruction · unnumbered_claim · §3 · 印刷p.97 / PDFp.119
[EXTRA] 近恒等、光滑、阶r≥1用smoothSymplecticData实际定义表达：开放凸D、紧凸B⊆D、H及(h,z)↦G_h(z)无限可微、G₀=id、逐h辛、实际原始ODE流和局部阶。
[EXTRA] 按任意有限截断匹配解释“in an approximate sense”；不将形式无限级数当实际收敛解，不将finiteMatching结论作前提。 -/
theorem modifiedConstruction :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G := by
  sorry

/-- source_id: MD-3.1-AdjointEulerOscillator · definition · §3.1 · 印刷p.98 / PDFp.120 -/
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)

/-- source_id: MD-3.1-ShadowHamiltonian · (3.1) · §3.1 · 印刷p.98 / PDFp.120 -/
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2

/-- source_id: MD-3.1-EnergyFailure · unnumbered_claim · §3.1 · 印刷p.98 / PDFp.120 -/
theorem oscillatorEnergyFailure :
    ∃ Ω h : ℝ, 0 < Ω ∧ h ≠ 0 ∧ ∃ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z := by
  refine ⟨1, 1, by norm_num, by norm_num, (1,0), ?_⟩
  exact MolecularDynamics.Chapter03Review.oscillatorEnergyFailure_proved

/-- source_id: MD-3.1-ShadowInvariant · unnumbered_claim · §3.1 · 印刷p.99 / PDFp.121 -/
theorem oscillatorShadowInvariant :
  ∀ Ω h z, oscillatorShadow Ω h (oscillatorAdjointEuler Ω h z)=oscillatorShadow Ω h z := by
  exact MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved

/-- source_id: MD-3.1-ShadowEllipses · unnumbered_claim · §3.1 · 印刷p.99 / PDFp.121
[EXTRA] 显式Ω>0、|hΩ|<2，排除退化与不稳定步长；线性等价给出振子二次型标准形。
[NEEDS_HUMAN] 一般a,b,ε椭圆旋转与振子特例之间仍需完整统一；不以特例冒充全部结论。 -/
theorem shadowEllipses :
    (∀ a b : ℝ, a ≠ 0 → b ≠ 0 →
      ∃ δ > 0, ∃ θ A B : ℝ → ℝ,
        Tendsto A (𝓝 0) (𝓝 |a|) ∧ Tendsto B (𝓝 0) (𝓝 |b|) ∧
        (∀ ε ∈ Ioo (-δ) δ, 0 < A ε ∧ 0 < B ε ∧ ∀ x y : ℝ,
          x^2/a^2+y^2/b^2+ε*x*y =
            (Real.cos (θ ε)*x+Real.sin (θ ε)*y)^2/(A ε)^2+
            (-Real.sin (θ ε)*x+Real.cos (θ ε)*y)^2/(B ε)^2)) ∧
    (∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
      (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
      ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z,
        oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2) := by
  sorry

/-- source_id: MD-3.1-EulerGrowth · unnumbered_claim · §3.1 · 印刷p.100 / PDFp.122
[EXTRA] Ω≠0、固定h≠0且初始能量>0，排除平衡点和零步长。 -/
theorem eulerOscillatorGrowth :
  ∀ Ω h : ℝ, Ω ≠ 0 → h ≠ 0 → ∀ z : ℝ × ℝ, 0 < oscillatorEnergy Ω z →
    Tendsto (fun ν : ℕ => oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z)) atTop atTop := by
  intro Ω h hΩ hh z hz
  have hfactor : 1 < 1+h^2*Ω^2 := by
    have hp := mul_pos (sq_pos_of_ne_zero hh) (sq_pos_of_ne_zero hΩ)
    linarith
  have hstep : ∀ w, oscillatorEnergy Ω (oscillatorEuler Ω h w) =
      (1+h^2*Ω^2)*oscillatorEnergy Ω w := by
    intro w
    simp only [oscillatorEnergy, oscillatorEuler]
    ring
  have hiter : ∀ ν : ℕ, oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z) =
      (1+h^2*Ω^2)^ν*oscillatorEnergy Ω z := by
    intro ν
    induction ν with
    | zero => simp
    | succ ν ih =>
      rw [Function.iterate_succ_apply', hstep, ih, pow_succ]
      ring
  simpa only [hiter] using
    (tendsto_pow_atTop_atTop_of_one_lt hfactor).atTop_mul_const hz

/-- source_id: MD-3.1-FormalHamiltonian · definition · §3.1 · 印刷p.100 / PDFp.122 -/
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)

/-- source_id: MD-3.1-FormalHamiltonianField · definition · §3.1 · 印刷p.100 / PDFp.122 -/
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (z : SymplecticCoordinates n)
    (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)

/-- source_id: MD-3.2-LieDerivative · definition · §3.2 · 印刷p.100 / PDFp.122 -/
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)

/-- source_id: MD-3.2-ObservableDerivative · (3.2) · §3.2 · 印刷p.100–101 / PDFp.122–123 -/
theorem observableDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption

/-- source_id: MD-3.2-ObservableSecondDerivative · unnumbered_claim · §3.2 · 印刷p.101 / PDFp.123
[EXTRA] f全域C¹、φ全域C²，显式化原文smooth及第二次求导资格。 -/
theorem observableSecondDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ)
    (hγ : ∀ t, HasDerivAt γ (f (γ t)) t) (t : ℝ) :
    HasDerivAt (fun u => deriv (fun v => φ (γ v)) u)
      (textbookLieDerivative f (textbookLieDerivative f φ) (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative_second <;> assumption

/-- source_id: MD-3.2-OperatorExponential · definition · §3.2 · 印刷p.101 / PDFp.123 -/
noncomputable def formalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)

/-- source_id: MD-3.2-FormalObservable · definition · §3.2 · 印刷p.101 / PDFp.123 -/
def formalObservable {n : ℕ} (f : Q n → Q n) (φ : Q n → ℝ) (z : Q n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => ((textbookLieDerivative f)^[j] φ) z/(Nat.factorial j : ℝ))

/-- source_id: MD-3.2-FiniteLieTaylor · unnumbered_claim · §3.2 · 印刷p.101 / PDFp.123
[EXTRA] [EXTRA]有限阶k+1统一局部余项是原文形式展开的额外严格有限解释，原文未明写常数C与δ。
[EXTRA] [EXTRA]f与φ取全域C∞并给定实际ODE解；不预设无限级数收敛。
[NEEDS_HUMAN] 是否将额外有限余项定理作为原文的忠实严格化，由导师/网站裁定；本地不进入证明。 -/
theorem lieTaylor :
  ∀ (n k : ℕ) (f : Q n → Q n) (φ : Q n → ℝ) (γ : ℝ → Q n),
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ φ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∃ C > 0, ∃ δ > 0, ∀ t ∈ Ioo (-δ) δ,
      |φ (γ t)-∑ j ∈ Finset.range (k+1), t^j/(Nat.factorial j:ℝ)*
        ((textbookLieDerivative f)^[j] φ) (γ 0)| ≤ C*|t|^(k+1) := by
  sorry

/-- source_id: MD-3.2-FlowCoordinates · unnumbered_claim · §3.2 · 印刷p.101 / PDFp.123
[EXTRA] 有限截断阶k+1真实余项是额外严格化，原文没有此显式不等式；f全域C∞。
[NEEDS_HUMAN] 形式exp作用于坐标的等式无实际收敛主张；严格化为有限Taylor余项是否超出原文需裁定。 -/
theorem flowCoordinates :
    ∀ (n k : ℕ) (f : Q n → Q n) (D : Set (Q n))
      (Φ : ℝ → Q n → Q n) (η : ℝ),
      ContDiff ℝ ⊤ f → actualFlow f D Φ η →
      ∀ ζ ∈ D, ∀ i : Fin n, ∃ C > 0, ∃ δ > 0, δ ≤ η ∧
        ∀ t ∈ Ioo (-δ) δ,
          |Φ t ζ i - ∑ j ∈ Finset.range (k+1),
            t^j * PowerSeries.coeff j (formalObservable f (fun z => z i) ζ)|
            ≤ C * |t|^(k+1) := by
  sorry

/-- source_id: MD-3.2-PoissonBracket · definition · §3.2 · 印刷p.102 / PDFp.124 -/
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)

/-- source_id: MD-3.2-PoissonCoordinates · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124 -/
theorem poissonCoordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1)) := by
  apply MolecularDynamics.textbookPoissonBracket_coordinates <;> assumption

/-- source_id: MD-3.2-PoissonBilinearity · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124
[EXTRA] 原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。 -/
theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z) := by
  exact ⟨MolecularDynamics.textbookPoissonBracket_linear_right F G H α β z hG hH,
    MolecularDynamics.textbookPoissonBracket_linear_left F H G α β z hF hG⟩

/-- source_id: MD-3.2-PoissonSkew · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124 -/
theorem poissonSkew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z := by
  apply MolecularDynamics.textbookPoissonBracket_skew <;> assumption

/-- source_id: MD-3.2-PoissonSelf · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124 -/
theorem poissonSelf (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_self <;> assumption

/-- source_id: MD-3.2-PoissonJacobi · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124
[EXTRA] 显式各函数在z为C²；真实二阶导数对称性支持Jacobi。 -/
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_jacobi <;> assumption

/-- source_id: MD-3.2-HamiltonianObservableDerivative · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124
[EXTRA] smooth只需在γ(t)可微；ODE真实导数明示。 -/
theorem hamiltonianObservableDerivative
    (F H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (t : ℝ) (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) t := by
  exact MolecularDynamics.hasDerivAt_textbookLieDerivative
    (textbookHamiltonianVectorField H) F γ t hF hγ

/-- source_id: MD-3.2-HamiltonianLie · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124 -/
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H := by
  apply MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson <;> assumption

/-- source_id: MD-3.2-HamiltonianCoordinateDerivative · unnumbered_claim · §3.2 · 印刷p.102 / PDFp.124 -/
theorem hamiltonianCoordinateDerivative
    (H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (i : Fin Nc) (t : ℝ)
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => γ u (Sum.inl i))
      (textbookPoissonBracket (fun z => z (Sum.inl i)) H (γ t)) t := by
  exact hamiltonianObservableDerivative (fun z => z (Sum.inl i)) H γ t
    (differentiableAt_pi.mp differentiableAt_id (Sum.inl i)) hγ

/-- source_id: MD-3.3-HamiltonianLieAdditivity · unnumbered_claim · §3.3 · 印刷p.103 / PDFp.125
[EXTRA] H₁,H₂在z可微；原文smooth资格显式化。 -/
theorem hamiltonianLieAdditivity (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_add <;> assumption

/-- source_id: MD-3.3-FormalSplitting · definition · §3.3 · 印刷p.103 / PDFp.125 -/
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B

/-- source_id: MD-3.3-ExactExponentialCubic · unnumbered_claim · §3.3 · 印刷p.103 / PDFp.125 -/
theorem exactExponentialCubic (A B : R) :
    (∀ j < 4, PowerSeries.coeff j (textbookFormalOperatorExponential (A+B)) =
      (1/(j.factorial : ℝ)) • (A+B)^j) ∧
    ((A+B)^2 = A*B+B*A+A^2+B^2) ∧
    ((A+B)^3 = A^3+A^2*B+A*B^2+A*B*A+B^2*A+B*A^2+B*A*B+B^3) := by
  refine ⟨fun j _ => textbookFormalOperatorExponential_coeff (A+B) j, ?_, ?_⟩
  · noncomm_ring
  · noncomm_ring

/-- source_id: MD-3.3-ProductExponentialCubic · unnumbered_claim · §3.3 · 印刷p.104 / PDFp.126 -/
theorem productExponentialCubic (A B : R) :
    PowerSeries.coeff 0 (formalSplitting A B)=1 ∧
    PowerSeries.coeff 1 (formalSplitting A B)=A+B ∧
    PowerSeries.coeff 2 (formalSplitting A B)=
      (1/2:ℝ) • A^2+A*B+(1/2:ℝ) • B^2 ∧
    PowerSeries.coeff 3 (formalSplitting A B)=
      (1/6:ℝ) • A^3+(1/2:ℝ) • (A^2*B)+(1/2:ℝ) • (A*B^2)+(1/6:ℝ) • B^3 := by
  exact ⟨textbookFormalOperatorProduct_coeff_zero A B,
    textbookFormalOperatorProduct_coeff_one A B,
    textbookFormalOperatorProduct_coeff_two A B,
    textbookFormalOperatorProduct_coeff_three A B⟩

/-- source_id: MD-3.3-DifferenceCommutator · unnumbered_claim · §3.3 · 印刷p.104 / PDFp.126 -/
theorem differenceCommutator (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_two <;> assumption

/-- source_id: MD-3.3-DifferenceCubic · unnumbered_claim · §3.3 · 印刷p.104 / PDFp.126 -/
theorem differenceCubic (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_three <;> assumption

/-- source_id: MD-3.3-HamiltonianCommutator · unnumbered_claim · §3.3 · 印刷p.104–105 / PDFp.126–127
[EXTRA] F,H₁,H₂在z为C²；原文smooth资格显式化。 -/
theorem hamiltonianCommutator
    (F H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiffAt ℝ 2 F z) (hH₁ : ContDiffAt ℝ 2 H₁ z)
    (hH₂ : ContDiffAt ℝ 2 H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField H₁)
        (textbookLieDerivative (textbookHamiltonianVectorField H₂) F) z -
      textbookLieDerivative (textbookHamiltonianVectorField H₂)
        (textbookLieDerivative (textbookHamiltonianVectorField H₁) F) z =
      textbookLieDerivative (textbookHamiltonianVectorField
        (textbookPoissonBracket H₂ H₁)) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_commutator <;> assumption

/-- source_id: MD-3.3-HamiltonianCommutatorPrinted · unnumbered_claim · §3.3 · 印刷p.105 / PDFp.127
[EXTRA] F,H₁,H₂取C²，原文smooth资格明示。
[ERRATUM?] p.105/PDF127相邻两式的Hamiltonian Poisson括号顺序相反；本条保留印刷{H₁,H₂}。 -/
theorem leadingShadowPrinted :
  ∀ (n : ℕ) (A B F : SymplecticCoordinates n → ℝ), ContDiff ℝ 2 A →
    ContDiff ℝ 2 B → ContDiff ℝ 2 F → ∀ z,
    hamiltonianLie A (hamiltonianLie B F) z-hamiltonianLie B (hamiltonianLie A F) z=
      hamiltonianLie (textbookPoissonBracket A B) F z := by
  sorry

/-- source_id: MD-3.3-LeadingModifiedExponential · unnumbered_claim · §3.3 · 印刷p.105 / PDFp.127
[ERRATUM?] p.105/PDF127比较式似应为二次系数之差（第二项前负号）；展示h³交叉项似缺1/2。最终R₀式与既有匹配一致。 -/
theorem leadingModifiedExponential (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
  sorry

/-- source_id: MD-3.3-LeadingShadowHamiltonian · unnumbered_claim · §3.3 · 印刷p.105 / PDFp.127
[EXTRA] D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。
[ERRATUM?] 与同页印刷交换子和状态/pullback组合约定一起核对，不能静默换号。 -/
theorem leadingShadowHamiltonian :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3 := by
  sorry

/-- source_id: MD-3.3-BCH4 · unnumbered_claim · §3.3 · 印刷p.106 / PDFp.128 -/
theorem bch4 :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j < 5,
    PowerSeries.coeff j (formalLog (formalSplitting A B))=PowerSeries.coeff j (bchLog4 A B) := by
  sorry

/-- source_id: MD-3.3-BCHHamiltonian · definition · §3.3 · 印刷p.106 / PDFp.128 -/
def bchHamiltonian3 {n : ℕ} (A B : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  A z+B z+h/2*textbookPoissonBracket A B z+
    h^2/12*(textbookPoissonBracket A (textbookPoissonBracket A B) z-
      textbookPoissonBracket B (textbookPoissonBracket A B) z)-
    h^3/24*textbookPoissonBracket B (textbookPoissonBracket A (textbookPoissonBracket A B)) z

/-- source_id: MD-3.3-BCHHamiltonianMatching · unnumbered_claim · §3.3 · 印刷p.106 / PDFp.128
[EXTRA] 实际匹配按截断至h³、端点误差O(h⁵)表达；D开放、K紧、光滑Hamiltonian与真实局部流明示。
[NEEDS_HUMAN] 需确定原书组合顺序和有限截断的实际余项阶；未把匹配结论当假设。 -/
theorem bchHamiltonianMatching :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    matchesHamiltonian (bchHamiltonian3 A B) (fun h => Φ h ∘ Ψ h) K 4 := by
  sorry

/-- source_id: MD-3.3-CommutingFlows · unnumbered_claim · §3.3 · 印刷p.106 / PDFp.128
[EXTRA] 光滑Hamiltonian、开放域及三个真实局部流；|h|<η/2保证复合时间在所给流的定义区间。 -/
theorem commutingFlows :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ Ψ Χ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    (∀ z ∈ D, textbookPoissonBracket A B z=0) →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    actualFlow (textbookHamiltonianVectorField (fun z => A z+B z)) D Χ η →
    ∀ z ∈ D, ∀ h ∈ Ioo (-η/2) (η/2), Φ h (Ψ h z)=Χ h z := by
  sorry

/-- source_id: MD-3.3.1-SymplecticEulerShadow · definition · §3.3.1 · 印刷p.106 / PDFp.128
[EXTRA] M取固定对角质量矩阵，与第1章机械模型一致；不包括任意非对角M。 -/
def symplecticEulerShadow3 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z-h/2*(∑ i, invMass m z.2 i*grad U z.1 i)+
    h^2/12*((shadowTerms m U z).1+(shadowTerms m U z).2.1)-h^3/12*(shadowTerms m U z).2.2

/-- source_id: MD-3.3.1-SymplecticEulerShadowMatching · unnumbered_claim · §3.3.1 · 印刷p.106 / PDFp.128
[EXTRA] 正对角质量、U全域C∞、紧初值集B；截断h³的实际局部流端点O(h⁵)为额外严格化。
[NEEDS_HUMAN] 原文只写Hamiltonian O(h⁴)，实际端点O(h⁵)解释与数值坐标顺序待审。 -/
theorem symplecticEulerShadowMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (fun h z => symplecticEulerShadow3 m U h (unpack z))
      (textbookSymplecticEuler m U) B 4 := by
  sorry

/-- source_id: MD-3.3.2-VerletMaps · (3.3) · §3.3.2 · 印刷p.107 / PDFp.129
[EXTRA] 固定对角质量M，保持第1章对象；无非对角质量一般化。 -/
def verletMaps {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    (SymplecticCoordinates n → SymplecticCoordinates n) ×
      (SymplecticCoordinates n → SymplecticCoordinates n) :=
  (positionVerlet m (textbookPotentialForce U) h,
    coordinateVerlet m (textbookPotentialForce U) h)

/-- source_id: MD-3.3.2-VerletHamiltonianParts · definition · §3.3.2 · 印刷p.107 / PDFp.129 -/
def verletHamiltonianParts {n : ℕ} (T U : SymplecticCoordinates n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z => U z/2), T, (fun z => U z/2)]

/-- source_id: MD-3.3.2-VerletStructure · unnumbered_claim · §3.3.2 · 印刷p.107 / PDFp.129
[EXTRA] U全域C²以保障真实梯度kick为辛映射；原文光滑Hamiltonian假设显式化。 -/
theorem verletStructure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) ∧
      IsTextbookSymplecticMap (positionVerlet m (textbookPotentialForce U) h)) ∧
    (∀ h z, coordinateVerlet m (textbookPotentialForce U) (-h)
      (coordinateVerlet m (textbookPotentialForce U) h z)=z) ∧
    (∀ h z, positionVerlet m (textbookPotentialForce U) (-h)
      (positionVerlet m (textbookPotentialForce U) h z)=z) := by
  exact MolecularDynamics.Chapter03Review.verletVariants_proved

/-- source_id: MD-3.3.2-VerletModifiedHamiltonian · definition · §3.3.2 · 印刷p.107 / PDFp.129 -/
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)

/-- source_id: MD-3.3.2-VerletModifiedMatching · unnumbered_claim · §3.3.2 · 印刷p.107 / PDFp.129
[EXTRA] 正对角质量、U全域C∞、紧初值B；完整印刷h⁴截断实际O(h⁶)端点匹配为额外严格化。
[NEEDS_HUMAN] 与速度/位置Verlet的组合次序共同核对h²,h⁴系数；原文Hamiltonian O(h⁶)与实际匹配阶也需裁定。 -/
theorem verletModifiedMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (verletModifiedH (fun z => quadraticKinetic m (unpack z).2) (fun z => U (unpack z).1))
      (coordinateVerlet m (textbookPotentialForce U)) B 5 := by
  sorry

/-- source_id: MD-3.3.2-ModifiedEven · unnumbered_claim · §3.3.2 · 印刷p.107–108 / PDFp.129–130 -/
theorem modifiedEven :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j : ℕ,
    PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0 := by
  sorry

/-- source_id: MD-3.3.2-Strang · definition · §3.3.2 · 印刷p.108 / PDFp.130
[ERRATUM?] p.108/PDF130第一展开把Z_[2]配t²、Z_[3]配t³，而下一展开(3.5)按总指数幂2、3排列；保留原页不静默纠正索引。 -/
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)

/-- source_id: MD-3.3.2-DifferentLogsCommute · (3.4)–(3.5) · §3.3.2 · 印刷p.108 / PDFp.130
[ERRATUM?] p.108/PDF130 “Z_s commutes with Z_t” 对一般非交换X,Y可疑；应由反步关系单独推导奇性。 -/
theorem differentLogsCommute :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R) (s t : ℝ),
    commutator (formalLog (formalStrang (s • A) (s • B))) (formalLog (formalStrang (t • A) (t • B)))=0 := by
  sorry

/-- source_id: MD-3.3.2-StrangInverse · unnumbered_claim · §3.3.2 · 印刷p.108 / PDFp.130 -/
theorem strangInverse :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), formalStrang A B * formalStrang (-A) (-B)=1 := by
  sorry

/-- source_id: MD-3.3.2-StrangCubic · (3.6)–(3.7) · §3.3.2 · 印刷p.108 / PDFp.130 -/
theorem strangCubic :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B) := by
  intro R _ _ A B
  norm_num [formalLog, formalStrang, textbookFormalOperatorExponential,
    PowerSeries.coeff_mk, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Nat.factorial_succ, pow_succ, Finset.sum_Icc_succ_top, MolecularDynamics.Chapter03Review.commutator,
    mul_add, add_mul, mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
    smul_add, smul_sub, smul_smul]
  simp only [mul_assoc]
  module

/-- source_id: MD-3.3.3-YoshidaComposition · definition · §3.3.3 · 印刷p.109 / PDFp.131 -/
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)

/-- source_id: MD-3.3.3-YoshidaCoefficients · definition · §3.3.3 · 印刷p.109 / PDFp.131 -/
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))

/-- source_id: MD-3.3.3-YoshidaCancellation · unnumbered_claim · §3.3.3 · 印刷p.109 / PDFp.131
[EXTRA] 显式s≥1，并保留中间系数τ₁<0作为根公式的数学推论。 -/
theorem yoshidaCancellation :
  ∀ s : ℕ, 1 ≤ s → let ab := yoshidaCoefficients s
    2*ab.1+ab.2=1 ∧ 2*ab.1^(2*s+1)+ab.2^(2*s+1)=0 ∧ ab.2 < 0 := by
  intro s hs
  let κ := yoshidaRoot s
  have hκ0 : 0 < κ := Real.rpow_pos_of_pos (by norm_num) _
  have hN : 1 < ((2*s+1 : ℕ) : ℝ) := by exact_mod_cast (show 1 < 2*s+1 by omega)
  have hκ2 : κ < 2 := by
    change Real.rpow 2 (1/((2*s+1 : ℕ):ℝ)) < 2
    calc
      _ < Real.rpow 2 1 := Real.rpow_lt_rpow_of_exponent_lt (by norm_num)
        ((div_lt_one (by positivity)).2 hN)
      _ = 2 := Real.rpow_one 2
  have hκpow : κ^(2*s+1)=2 := by
    simpa [κ, yoshidaRoot, one_div] using
      (Real.rpow_inv_natCast_pow (x := (2:ℝ)) (n := 2*s+1) (by norm_num) (by omega))
  have hd : 0 < 2-κ := sub_pos.mpr hκ2
  have hd0 : 2-κ ≠ 0 := ne_of_gt hd
  have ho : Odd (2*s+1) := ⟨s, by omega⟩
  change 2*(1/(2-κ))+(-κ/(2-κ))=1 ∧
    2*(1/(2-κ))^(2*s+1)+(-κ/(2-κ))^(2*s+1)=0 ∧ -κ/(2-κ)<0
  refine ⟨?_, ?_, div_neg_of_neg_of_pos (neg_neg_of_pos hκ0) hd⟩
  · field_simp
    ring
  · rw [neg_div, ho.neg_pow, div_pow, div_pow, one_pow, hκpow]
    ring

/-- source_id: MD-3.3.3-YoshidaUnique · unnumbered_claim · §3.3.3 · 印刷p.109 / PDFp.131 -/
theorem yoshidaUnique :
  ∀ s : ℕ, 1 ≤ s → ∀ a b : ℝ,
    (2*a+b=1 ∧ 2*a^(2*s+1)+b^(2*s+1)=0) ↔ (a,b)=yoshidaCoefficients s := by
  intro s hs a b
  let κ := yoshidaRoot s
  have hN : 1 < ((2*s+1 : ℕ) : ℝ) := by exact_mod_cast (show 1 < 2*s+1 by omega)
  have hκ2 : κ < 2 := by
    change Real.rpow 2 (1/((2*s+1 : ℕ):ℝ)) < 2
    calc
      _ < Real.rpow 2 1 := Real.rpow_lt_rpow_of_exponent_lt (by norm_num)
        ((div_lt_one (by positivity)).2 hN)
      _ = 2 := Real.rpow_one 2
  have hd0 : 2-κ ≠ 0 := ne_of_gt (sub_pos.mpr hκ2)
  have hκpow : κ^(2*s+1)=2 := by
    simpa [κ, yoshidaRoot, one_div] using
      (Real.rpow_inv_natCast_pow (x := (2:ℝ)) (n := 2*s+1) (by norm_num) (by omega))
  have ho : Odd (2*s+1) := ⟨s, by omega⟩
  constructor
  · rintro ⟨hab, hp⟩
    have heq : (-b)^(2*s+1)=(κ*a)^(2*s+1) := by
      rw [ho.neg_pow, mul_pow, hκpow]
      linarith
    have hrel : -b=κ*a := ho.pow_injective heq
    have ha : a=1/(2-κ) := by
      apply (eq_div_iff hd0).2
      nlinarith
    have hb : b=-κ/(2-κ) := by
      calc
        b = -κ*a := by nlinarith
        _ = -κ/(2-κ) := by rw [ha]; ring
    change (a,b)=(1/(2-κ),-κ/(2-κ))
    exact Prod.ext ha hb
  · intro heq
    change (a,b)=(1/(2-κ),-κ/(2-κ)) at heq
    rcases Prod.mk.inj heq with ⟨rfl,rfl⟩
    exact ⟨(yoshidaCancellation s hs).1, (yoshidaCancellation s hs).2.1⟩

/-- source_id: MD-3.3.3-YoshidaRaiseOrder · unnumbered_claim · §3.3.3 · 印刷p.109 / PDFp.131
[EXTRA] 给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。 -/
theorem yoshidaRaiseOrder :
  ∀ (n s : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    1 ≤ s → ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η →
    (∀ h z, G (-h) (G h z)=z) → localOrder G Φ B (2*s) →
    localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ B (2*s+2) := by
  sorry

/-- source_id: MD-3.3.3-Yoshida4 · Example 3.1 / (3.8) · §3.3.3 · 印刷p.109–110 / PDFp.131–132
[EXTRA] M为固定对角质量；不假设正反步骤的实际无限时域流存在。 -/
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h

/-- source_id: MD-3.3.3-Yoshida4Structure · unnumbered_claim · §3.3.3 · 印刷p.110 / PDFp.132
[EXTRA] U全域C²；真实kick/drift及三次回文复合。 -/
theorem yoshida4Structure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (yoshida4 m U h)) ∧ (∀ h z, yoshida4 m U (-h) (yoshida4 m U h z)=z) := by
  exact MolecularDynamics.Chapter03Review.yoshida4Structure_proved

/-- source_id: MD-3.3.3-GeneralSplitting · definition · §3.3.3 · 印刷p.111 / PDFp.133 -/
def generalSplitting {E : Type*} (T U : ℝ → E → E) (coeff : List (ℝ × ℝ)) (h : ℝ) : E → E :=
  coeff.foldr (fun ab acc => T (ab.1*h) ∘ U (ab.2*h) ∘ acc) id

/-- source_id: MD-3.3.4-TakahashiPotential · definition · §3.3.4 · 印刷p.112 / PDFp.134
[EXTRA] M为固定对角质量矩阵，原第1章机械模型。 -/
def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h

/-- source_id: MD-3.3.4-PotentialDoubleBracket · unnumbered_claim · §3.3.4 · 印刷p.112 / PDFp.134
[EXTRA] 正对角质量、U全域C²，显式化真实二次Poisson括号的微分资格。 -/
theorem potentialDoubleBracket :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ 2 U → ∀ z : Z n,
    (∑ i, grad U z.1 i*invMass m (grad U z.1) i)=
      textbookPoissonBracket (fun x => U (unpack x).1)
        (textbookPoissonBracket (fun x => U (unpack x).1) (fun x => quadraticKinetic m (unpack x).2)) (pack z) := by
  sorry

/-- source_id: MD-3.3.4-TakahashiShadow · definition · §3.3.4 · 印刷p.112 / PDFp.134 -/
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)

/-- source_id: MD-3.3.4-TakahashiProcessor · (3.9) · §3.3.4 · 印刷p.113 / PDFp.135 -/
def takahashiProcessor {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n :=
  (z.1-(h^2/12) • invMass m (grad U z.1), z.2+(h^2/12) • hessianAction U z.1 (invMass m z.2))

/-- source_id: MD-3.3.4-ProcessorEnergyPrinted · unnumbered_claim · §3.3.4 · 印刷p.113 / PDFp.135
[EXTRA] 正对角质量、U全域C⁴、紧初值集B；展示O(h⁴)按小h统一实际余项解释。
[ERRATUM?] 第一行“T + h²/12(...)”似应为“H + h²/12(...)”；原文逐字保留，未改变正式库。 -/
theorem processorEnergyPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (Z n)),
      positiveMass m → ContDiff ℝ 4 U → IsCompact B →
      ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
        (|mechanicalEnergy m U (takahashiProcessor m U h z) -
          (quadraticKinetic m z.2+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1))|
          ≤ C*h^4) ∧
        (|mechanicalEnergy m U (takahashiProcessor m U h z)-takahashiShadow2 m U h z|
          ≤ C*h^4) := by
  sorry

/-- source_id: MD-3.3.4-TakahashiEffectiveOrder · unnumbered_claim · §3.3.4 · 印刷p.113 / PDFp.135
[EXTRA] 正对角质量、U全域C∞、实际有限时间解连续；处理器χ要求全局homeomorphism，强于原文局部坐标展开。
[NEEDS_HUMAN] 全局χ是否过强，以及可选局部处理器和其作用方向，需导师判断。 -/
theorem takahashiEffectiveOrder :
    ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
      ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
        solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
        ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
          oneStepMaxError (fun h => textbookProcessedMethod χ
            (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
            (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
  sorry

/-- source_id: MD-3.4-ModifiedField · definition · §3.4 · 印刷p.113 / PDFp.135 -/
def formalField {n : ℕ} (f : Q n → Q n) (fj : ℕ → Q n → Q n) (r : ℕ)
    (z : Q n) (i : Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then f z i else if r ≤ j then fj j z i else 0)

/-- source_id: MD-3.4-LeadingModifiedField · unnumbered_claim · §3.4 · 印刷p.113 / PDFp.135
[EXTRA] r>0、全域C∞的f及(h,z)↦G_h、开放D与紧B及真实双向局部流；局部r阶条件。 -/
theorem leadingModifiedField :
  ∀ (n r : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    0 < r → ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η → localOrder G Φ B r →
    ∃ fr : Q n → Q n, ContDiffOn ℝ ⊤ fr D ∧
      (∀ z ∈ B, Tendsto (fun h => (h^(r+1))⁻¹ • (G h z-Φ h z)) (𝓝[≠] 0) (𝓝 (fr z))) ∧
      ∃ Γ : ℝ → Q n → ℝ → Q n, ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z ∈ B,
        Γ h z 0=z ∧ solution (fun x => f x+h^r • fr x) (Γ h z) 0 h ∧
          ‖G h z-Γ h z h‖ ≤ C*h^(r+2) := by
  sorry

/-- source_id: MD-3.4-TruncatedHamiltonian · (3.11) · §3.4 · 印刷p.114 / PDFp.136 -/
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z

/-- source_id: MD-3.4-TruncationSmooth · unnumbered_claim · §3.4 · 印刷p.114 / PDFp.136
[EXTRA] 各系数在开放环境D为C¹；这里只证明所需C¹子结论，原文smooth假设本身不作为新断言。 -/
theorem truncationSmooth (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ContDiffOn ℝ 1 (textbookTruncatedHamiltonian H Hj r k h) D := by
  apply MolecularDynamics.contDiffOn_textbookTruncatedHamiltonian <;> assumption

/-- source_id: MD-3.4-Thm3.1 · Theorem 3.1 · §3.4 · 印刷p.114–116 / PDFp.136–138
[EXTRA] smoothSymplecticData显式添加原方法r阶/近恒等辛/joint C∞、开放凸环境D、紧凸B⊆D、真实原流；r>0。
[EXTRA] 本签名保留完整构造H_j与finiteMatching为结论，k≥r固定；数值迭代和截断ODE留B，常数可依赖k,T而非所有k统一。
[NEEDS_HUMAN] 给定H̃_k与存在一组构造系数的量词对应、截断轨道留B及所有n≤ν的长时间范围需审；任意n和T的量化包含原文每个n≤ν。
[NEEDS_HUMAN] 证明先对H取L，后对H̃_k沿用L，并在Lνh^(k+1)中省略缺陷常数C；本地辅助桥接显式给实际截断族统一L和C，但原文不改。 -/
theorem theorem31 :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
    ∀ k ≥ r, finiteMatching H Hj r k D B G ∧
      ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
        (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
        (∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
          ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
            (∀ t ∈ Icc 0 h, Γ h z t ∈ B)) →
        (ν:ℝ)*h*h^(k-r) ≤ T → ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r := by
  sorry

/-- source_id: MD-3.4-CompactLipschitz · unnumbered_claim · §3.4 · 印刷p.114 / PDFp.136
[EXTRA] 显式开放环境D及B⊆D、H在D为C¹；L由真实导数紧集界推出，未作假设。 -/
theorem compactLipschitz (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (H : E → ℝ) (hH : ContDiffOn ℝ 1 H D) :
    ∃ L : ℝ, 0 < L ∧ ∀ u ∈ B, ∀ v ∈ B, ‖H v - H u‖ ≤ L * ‖v - u‖ := by
  apply MolecularDynamics.exists_compact_C1_lipschitz_constant <;> assumption

/-- source_id: MD-3.4-TruncatedFlow · definition · §3.4 · 印刷p.115 / PDFp.137 -/
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h

/-- source_id: MD-3.4-FiniteMatchingConstruction · unnumbered_claim · §3.4 · 印刷p.115 / PDFp.137
[EXTRA] smoothSymplecticData与原书构造上下文相同；保留任意k的真实finiteMatching为结论，不当作前提。 -/
theorem finiteMatchingConstruction :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G := by
  sorry

/-- source_id: MD-3.4-TruncatedConservation · unnumbered_claim · §3.4 · 印刷p.115 / PDFp.137
[EXTRA] 沿γ对K的可微性与真实ODE在闭区间明示，包含端点；构造γ属于另项。 -/
theorem truncatedConservation (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption

/-- source_id: MD-3.4-EnergyTelescoping · unnumbered_claim · §3.4 · 印刷p.115 / PDFp.137 -/
theorem energyTelescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀ := by
  apply MolecularDynamics.oneStep_energy_telescoping <;> assumption

/-- source_id: MD-3.4-UniformTruncatedLipschitz · unnumbered_claim · §3.4 · 印刷p.115 / PDFp.137
[EXTRA] 开放D、紧凸B⊆D及H和有限H_j在D C¹；0≤h≤1；L由有限系数导数界推出。 -/
theorem uniformTruncatedLipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖ := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz <;> assumption

/-- source_id: MD-3.4-TruncationRemainder · unnumbered_claim · §3.4 · 印刷p.115 / PDFp.137
[EXTRA] 各有限系数在紧B连续；0≤h≤1；统一正C由紧性推出，未供应所需余项界。 -/
theorem truncationRemainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder <;> assumption

/-- source_id: MD-3.4-PhysicalEnergyDrift · unnumbered_claim · §3.4 · 印刷p.115 / PDFp.137
[EXTRA] 开放D、紧凸B⊆D及有限C¹系数；给定真实截断ODE族γ及其留B、γ(h,z,0)=z，未假设γ的能量守恒或误差界。 -/
theorem physicalEnergyDrift
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
            γ h (oneStepIterate G h z₀ i) h‖ := by
  apply MolecularDynamics.textbook_energy_drift_le_actual_defects <;> assumption

/-- source_id: MD-3.4-PolynomialEnergyRate · unnumbered_claim · §3.4 · 印刷p.116 / PDFp.138
[EXTRA] [EXTRA]hdefect是假设明确给出的实际一步O(h^(k+1))端点界，源自原书“By construction”尚未形式化的先验；不是本条能量结论。
[EXTRA] D/B及C¹、实际截断ODE留B、r≤k、A,T≥0、0<h≤1、数值轨道留B；长时间条件νhh^(k−r)≤T。 -/
theorem polynomialEnergyRate
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (hrk : r ≤ k) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t)
    (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T)
    (hdefect : ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z - γ h z h‖ ≤ A * h ^ (k + 1)) :
    ∃ M : ℝ, 0 < M ∧ ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
      (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
      (n : ℝ) * h * h ^ (k - r) ≤ T →
      ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ M * h ^ r := by
  exact MolecularDynamics.textbook_energy_drift_rate_of_flow_defect
    H Hj r k hrk D B hD hB hconv hBD hH hHj G γ hγ₀ hγB hγ A T hA hT hdefect

/-- source_id: MD-3.4-StepCountPower · unnumbered_claim · §3.4 · 印刷p.116 / PDFp.138
[EXTRA] 自然数r≤k使k−r没有截断损失；不将此代数辅助冒充完整能量定理。 -/
theorem stepCountPower (r k n : ℕ) (hrk : r ≤ k) (h : ℝ) :
    (n : ℝ) * h ^ (k + 1) = ((n : ℝ) * h * h ^ (k - r)) * h ^ r := by
  apply MolecularDynamics.energy_step_count_power_factor <;> assumption

/-- source_id: MD-3.4-ArbitraryFiniteTruncation · unnumbered_claim · §3.4 · 印刷p.116 / PDFp.138
[EXTRA] smoothSymplecticData保持全部Hamiltonian/近恒等辛/compact条件；完整∀k匹配作为结论，没有把它当作前提。 -/
theorem arbitraryFiniteTruncation :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G := by
  sorry

/-- source_id: MD-3.4-AnalyticDefect · unnumbered_claim · §3.4 · 印刷p.116 / PDFp.138
[EXTRA] 原文many standard classes未明说正则性；显式H和联合步映射解析、原有smoothSymplecticData及紧域；全阶系数构造与指数截断仍为结论。
[NEEDS_HUMAN] many standard classes的精确方法类及解析邻域条件原文未给。 -/
theorem analyticBEA :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r → AnalyticOnNhd ℝ H D →
    AnalyticOnNhd ℝ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-1:ℝ) 1 ×ˢ D) →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, AnalyticOnNhd ℝ (Hj j) D) ∧
    ∃ C > 0, ∃ A > 0, ∃ δ > 0,
      (∀ k ≥ r, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, A*((k+1:ℕ):ℝ)*h ≤ 1 → ∀ z ∈ B,
          truncatedFlow H Hj r k h z (Γ h z) ∧ (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧
          ‖G h z-Γ h z h‖ ≤ C*h*(A*((k+1:ℕ):ℝ)*h)^(k+1)) ∧
      ∃ γ > 0, ∃ κ : ℝ → ℕ, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, r ≤ κ h ∧
          ∀ z ∈ B, truncatedFlow H Hj r (κ h) h z (Γ h z) ∧
            ‖G h z-Γ h z h‖ ≤ C*h*Real.exp (-γ/h) := by
  sorry

/-- source_id: MD-3.4-OptimalTruncation · unnumbered_claim · §3.4 · 印刷p.116 / PDFp.138
[EXTRA] D>0；足够小正h；取整后允许独立正C吸收误差。
[NEEDS_HUMAN] 连续最优k未必整数；Lean整数界不冒充原文全部连续最小化结论。 -/
theorem optimalTruncation :
  ∀ A > 0, ∃ δ > 0, ∃ C > 0, ∀ h ∈ Ioo 0 δ,
    let k := Nat.floor (1/(A*Real.exp 1*h))
    0 < k ∧ (A*(k:ℝ)*h)^k ≤ C*Real.exp (-(1/(A*Real.exp 1))/h) := by
  sorry

/-- source_id: MD-3.4-ExponentialFlat · unnumbered_claim · §3.4 · 印刷p.116 / PDFp.138
[EXTRA] γ>0、h→0⁺；不声称只有C∞就有指数缺陷。 -/
theorem exponentialFlat :
  ∀ γ > 0, ∀ k : ℕ, Tendsto (fun h : ℝ => Real.exp (-γ/h)/h^k) (𝓝[>] 0) (𝓝 0) := by
  intro γ hγ k
  have ht : Tendsto (fun h : ℝ => γ / h) (𝓝[>] 0) atTop := by
    simpa only [div_eq_mul_inv] using tendsto_inv_nhdsGT_zero.const_mul_atTop hγ
  have hp := ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero k).comp ht).div_const (γ^k)
  convert hp using 1
  · ext h
    by_cases hh : h = 0
    · subst h; cases k <;> simp
    · have hg : γ ≠ 0 := ne_of_gt hγ
      simp only [Function.comp_apply, div_pow, neg_div]
      field_simp
  · simp

/-- source_id: MD-3.4-ScalarVerletShadow4 · definition · §3.4 · 印刷p.117 / PDFp.139
[NEEDS_HUMAN] O(h⁶)的实际修正匹配另为未完成理论；有限函数与余项分开。 -/
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)

/-- source_id: MD-3.4-CommutingEnergy · unnumbered_claim · §3.4 · 印刷p.117 / PDFp.139
[EXTRA] H在开放D为C¹、实际K-Hamiltonian流存在正η且全轨道H守恒。
[NEEDS_HUMAN] 离散快照守恒不直接推出连续修正流守恒。 -/
theorem commutingEnergy :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 H D → IsOpen D → actualFlow (textbookHamiltonianVectorField K) D Φ η →
    (∀ z ∈ D, ∀ t ∈ Ioo (-η) η, H (Φ t z)=H z) → ∀ z ∈ D, textbookPoissonBracket H K z=0 := by
  sorry

/-- source_id: MD-3.4-CommutingEnergySymmetry · unnumbered_claim · §3.4 · 印刷p.118 / PDFp.140
[EXTRA] 开放D、K为C¹、实际H流存在正η。 -/
theorem commutingEnergySymmetry :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 K D → IsOpen D → actualFlow (textbookHamiltonianVectorField H) D Φ η →
    (∀ z ∈ D, MolecularDynamics.textbookPoissonBracket H K z=0) →
      (∀ z ∈ D, MolecularDynamics.textbookPoissonBracket K H z=0) ∧ ∀ z ∈ D, ∀ t ∈ Ioo (-η) η, K (Φ t z)=K z := by
  intro n H K D Φ η hK hD hflow hzero
  have hskew : ∀ z ∈ D, MolecularDynamics.textbookPoissonBracket K H z = 0 := by
    intro z hz
    rw [MolecularDynamics.textbookPoissonBracket_skew, hzero z hz, neg_zero]
  refine ⟨hskew, ?_⟩
  intro z hz t ht
  have hη := hflow.1
  have htraj := hflow.2 z hz
  have hd : ∀ s ∈ Ioo (-η) η, HasDerivAt (fun u => K (Φ u z)) 0 s := by
    intro s hs
    have hks : DifferentiableAt ℝ K (Φ s z) :=
      (hK.differentiableOn (by norm_num)).differentiableAt (hD.mem_nhds (htraj.2 s hs).1)
    simpa only [textbookLieDerivative_hamiltonian_eq_poisson,
      hskew _ (htraj.2 s hs).1] using
      hasDerivAt_textbookLieDerivative (textbookHamiltonianVectorField H) K
        (fun u => Φ u z) s hks (htraj.2 s hs).2
  have heq := isOpen_Ioo.is_const_of_deriv_eq_zero (convex_Ioo (-η) η).isPreconnected
    (fun s hs => (hd s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hd s hs).deriv) ht (show (0:ℝ) ∈ Ioo (-η) η by constructor <;> linarith)
  simpa only [htraj.1] using heq

/-- source_id: MD-3.4-EnergySymplecticNoGo · unnumbered_claim · §3.4 · 印刷p.118 / PDFp.140
[EXTRA] [EXTRA]noExtraIntegrals明确所有光滑第一积分是H的函数；开放D、全光滑实际流与近恒等辛方法；该强资格原文未列。
[NEEDS_HUMAN] 原文practical排他陈述缺精确非可积性/无额外第一积分等假设。 -/
theorem energySymplecticNoGo :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ H D → noExtraIntegrals H D →
    actualFlow (textbookHamiltonianVectorField H) D Φ η →
    ContDiff ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2) →
    (∀ z ∈ D, G 0 z=z) → (∀ h ∈ Ioo (-η) η, IsTextbookSymplecticMap (G h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, H (G h z)=H z) →
    ∃ δ > 0, ∃ τ : ℝ → ℝ → ℝ, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ D, G h z=Φ (τ h (H z)) z := by
  sorry

/-- source_id: MD-3.5-EqualComponentIntegral · unnumbered_claim · §3.5 · 印刷p.122 / PDFp.144
[EXTRA] 真实轨道导数资格显式，采用全实时间轨道版本，不宣称任意f都全时间有解。 -/
theorem equalComponentFirstIntegral :
    ∃ I : ℝ × ℝ → ℝ, (∀ z, I z = z.1-z.2) ∧
      ∀ (f : ℝ × ℝ → ℝ) (u v : ℝ → ℝ),
        (∀ t, HasDerivAt u (f (u t,v t)) t) →
        (∀ t, HasDerivAt v (f (u t,v t)) t) →
        ∀ t, I (u t,v t) = I (u 0,v 0) := by
  refine ⟨(fun z => z.1-z.2), (fun _ => rfl), ?_⟩
  intro f u v hu hv t
  have hd : ∀ s, HasDerivAt (fun t => u t-v t) 0 s := by
    intro s
    simpa using (hu s).fun_sub (hv s)
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0

/-- source_id: MD-3.5-EqualEulerIntegral · unnumbered_claim · §3.5 · 印刷p.123 / PDFp.145 -/
theorem equalEulerIntegral :
  ∀ (f : ℝ × ℝ → ℝ) h z, equalComponentIntegral (z.1+h*f z,z.2+h*f z)=equalComponentIntegral z := by
  exact MolecularDynamics.Chapter03Review.equalEulerIntegral_proved

/-- source_id: MD-3.5-LinearEulerIntegral · unnumbered_claim · §3.5 · 印刷p.123 / PDFp.145 -/
theorem linearEulerIntegral :
  ∀ (n : ℕ) (b : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, b (f z)=0) →
    ∀ (h : ℝ) z, b (z+h • f z)=b z := by
  exact MolecularDynamics.Chapter03Review.linearEulerIntegral_proved

/-- source_id: MD-3.5-LinearRKIntegral · unnumbered_claim · §3.5 · 印刷p.123 / PDFp.145
[EXTRA] 明确选择任意有限阶段Runge–Kutta关系；所有阶段满足原场线性第一积分资格。 -/
theorem linearRKIntegral :
  ∀ (n s : ℕ) (ℓ : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, ℓ (f z)=0) →
    ∀ (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
      rungeKuttaRelation f A b h z w F → ℓ w=ℓ z := by
  exact MolecularDynamics.Chapter03Review.linearRKIntegral_proved

/-- source_id: MD-3.5-VerletOscillatorEnergy · unnumbered_claim · §3.5 · 印刷p.123 / PDFp.145
[EXTRA] Ω>0，固定ρ∈(0,2)，|hΩ|≤ρ；排除不稳定及阈值步长。 -/
theorem verletOscillatorEnergy :
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2 := by
  intro Ω ρ hΩ hρ hρ2 z
  let A : ℝ := 1-ρ^2/4
  have hA : 0 < A := by dsimp [A]; nlinarith
  let E0 : ℝ := (z.2 0)^2+Ω^2*(z.1 0)^2
  refine ⟨Ω^2*E0/(4*A), by dsimp [E0]; positivity, ?_⟩
  intro h hh ν
  have hh2 : h^2*Ω^2 ≤ ρ^2 := by
    have hp := abs_le.mp hh
    nlinarith
  have hcoeff : A ≤ 1-h^2*Ω^2/4 := by dsimp [A]; linarith
  let K : Z 1 → ℝ := fun w => (w.2 0)^2+Ω^2*(1-h^2*Ω^2/4)*(w.1 0)^2
  have hstep : ∀ w, K (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0) h w) = K w := by
    intro w
    simp only [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]
    ring
  have hi : K (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν) = K z := by
    induction ν with
    | zero => rfl
    | succ ν ih => rw [oneStepIterate_succ, hstep, ih]
  have hupper : K z ≤ E0 := by
    dsimp [K, E0]
    nlinarith [mul_nonneg (sq_nonneg h) (mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sq_nonneg Ω) (sq_nonneg (z.1 0))))]
  have hlower : ∀ w, Ω^2*A*(w.1 0)^2 ≤ K w := by
    intro w
    dsimp [K]
    nlinarith [sq_nonneg (w.2 0), mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sub_nonneg.mpr hcoeff) (sq_nonneg (w.1 0)))]
  let w := oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν
  have hden : 0 < Ω^2*A := mul_pos (sq_pos_of_pos hΩ) hA
  have hw : (w.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower w
    change K w=K z at hi
    nlinarith
  have hz : (z.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower z
    nlinarith
  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    rw [mul_div_assoc]
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (w.1 0), sq_nonneg (z.1 0)]
  have heq : mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z =
      (h^2*Ω^4/8)*((w.1 0)^2-(z.1 0)^2) := by
    norm_num [mechanicalEnergy, quadraticKinetic, Fin.sum_univ_one]
    change K w=K z at hi
    dsimp [K] at hi
    nlinarith
  change |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
    mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ _
  rw [heq, abs_mul, abs_of_nonneg (show 0 ≤ h^2*Ω^4/8 by positivity)]
  calc
    _ ≤ (h^2*Ω^4/8)*(2*E0/(Ω^2*A)) := mul_le_mul_of_nonneg_left habs (by positivity)
    _ = Ω^2*E0/(4*A)*h^2 := by
      have hg : Ω ≠ 0 := ne_of_gt hΩ
      have ha : A ≠ 0 := ne_of_gt hA
      field_simp
      ring

/-- source_id: MD-3.5-MomentumProjection · definition · §3.5 · 印刷p.123 / PDFp.145 -/
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)

/-- source_id: MD-3.5-ProjectionConstraint · (3.12) · §3.5 · 印刷p.123 / PDFp.145 -/
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E

/-- source_id: MD-3.5-ProjectionFactor · (3.13) · §3.5 · 印刷p.124 / PDFp.146 -/
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)

/-- source_id: MD-3.5-ProjectionEnergy · unnumbered_claim · §3.5 · 印刷p.124 / PDFp.146
[EXTRA] K>0且U≤E显式给出，禁止由自由度数目推算。 -/
theorem projectionEnergy :
  ∀ E K U : ℝ, 0 < K → U ≤ E → projectionConstraint E K U (projectionFactor E K U) := by
  exact MolecularDynamics.Chapter03Review.projectionEnergy_proved

/-- source_id: MD-3.5-KineticZero · unnumbered_claim · §3.5 · 印刷p.124 / PDFp.146
[EXTRA] 正质量。 -/
theorem kineticZero :
  ∀ (n : ℕ) (m : Fin n → ℝ) (p : Position n), positiveMass m → (kinetic m p=0 ↔ p=0) := by
  exact MolecularDynamics.Chapter03Review.kineticZero_proved

/-- source_id: MD-3.5-EnergyProjectionRelation · definition · §3.5 · 印刷p.124 / PDFp.146 -/
def energyProjectionRelation {n : ℕ} (H : Z n → ℝ) (E : ℝ) (z : Z n) : Prop := H z=E

/-- source_id: MD-3.5-NoHamiltonianAttractor · unnumbered_claim · §3.5 · 印刷p.126 / PDFp.148
[EXTRA] 明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。 -/
theorem noHamiltonianAttractor :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (orbit B : Set (SymplecticCoordinates n)), ContDiff ℝ 2 H →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (textbookHamiltonianVectorField H (Φ t z)) t) →
    IsCompact orbit → orbit.Nonempty → volume orbit=0 → IsOpen B → 0 < volume B → volume B < ⊤ →
    ¬ (∀ z ∈ B, Tendsto (fun t => Metric.infDist (Φ t z) orbit) atTop (𝓝 0)) := by
  sorry

/-- source_id: MD-3.5-LinearContinuousIntegral · unnumbered_claim · §3.5 · 印刷p.123 / PDFp.145
[EXTRA] 真实全时间轨道导数资格显式；不宣称任意f有全时间解。 -/
theorem linearContinuousIntegral :
    ∀ (n : ℕ) (b : Fin n → ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
      (∀ z, ∑ i, b i*f z i = 0) →
      (∀ t, HasDerivAt γ (f (γ t)) t) →
      ∀ t, (∑ i, b i*γ t i) = ∑ i, b i*γ 0 i := by
  intro n b f γ hbf hγ t
  have hd : ∀ s, HasDerivAt (fun t => ∑ i, b i*γ t i) 0 s := by
    intro s
    simpa only [hbf] using HasDerivAt.fun_sum
      (u := Finset.univ) (fun i _ => ((hasDerivAt_pi.mp (hγ s)) i).const_mul (b i))
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0

/-- source_id: MD-3.6-HamiltonianFlowStructures · unnumbered_claim · §3.6 · 印刷p.127–128 / PDFp.149–150
[EXTRA] 原场在开放域C¹，真实局部流、反步与局部定义域资格显式。 -/
theorem hamiltonianFlowStructures :
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S) := by
  sorry

/-- source_id: MD-3.6-VolumeNotSymplectic · unnumbered_claim · §3.6 · 印刷p.128 / PDFp.150 -/
theorem volumeNotSymplectic :
  ∃ G : SymplecticCoordinates 2 → SymplecticCoordinates 2,
    ContDiff ℝ 1 G ∧ (∀ z, (textbookJacobian G z).det=1) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry

/-- source_id: MD-3.6.1-LinearInvolution · definition · §3.6.1 · 印刷p.128 / PDFp.150 -/
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)

/-- source_id: MD-3.6.1-ReversedFieldPrinted · definition · §3.6.1 · 印刷p.128 / PDFp.150
[ERRATUM?] 一般线性involution的时间反转应−R⁻¹f(Rz)=−Rf(Rz)，不是−Rᵀ；机械R对称时两者相同。 -/
def reversedField {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (z : Q n) : Q n :=
  -(R.transpose.mulVec (f (R.mulVec z)))

/-- source_id: MD-3.6.1-MomentumReversal · definition · §3.6.1 · 印刷p.128 / PDFp.150 -/
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)

/-- source_id: MD-3.6.1-MechanicalReversal · unnumbered_claim · §3.6.1 · 印刷p.128 / PDFp.150
[ERRATUM?] p128右端列向量符号与−Rf(Rz)实际计算不符；原文不静默更改。 -/
theorem mechanicalReversalPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n),
      (-momentumReversal (mechanicalField m (fun q => -grad U q) (momentumReversal z)) =
        (-invMass m z.2, grad U z.1)) ∧
      ((-invMass m z.2, grad U z.1) = mechanicalField m (fun q => -grad U q) z) ∧
      mechanicalField m (fun q => -grad U q) (momentumReversal z) =
        -momentumReversal (mechanicalField m (fun q => -grad U q) z) := by
  sorry

/-- source_id: MD-3.6.1-ReversedTrajectoryPrinted · unnumbered_claim · §3.6.1 · 印刷p.128–129 / PDFp.150–151
[ERRATUM?] p128的Rᵀ字面反转与p129的R链式法则不能一般同时成立；具体二维反例见本地审计。 -/
theorem reversedTrajectoryPrinted :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (reversedField R f (R.mulVec (γ (-t)))) t := by
  sorry

/-- source_id: MD-3.6.1-ReversedTrajectory · unnumbered_claim · §3.6.1 · 印刷p.129 / PDFp.151
[EXTRA] [EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。 -/
theorem reversedTrajectory :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
  sorry

/-- source_id: MD-3.6.2-FlowReversal · unnumbered_claim · §3.6.2 · 印刷p.129 / PDFp.151
[EXTRA] 正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。 -/
theorem flowReversal :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z) := by
  sorry

/-- source_id: MD-3.6.2-FlowReversalIdentity · (3.14) · §3.6.2 · 印刷p.129 / PDFp.151
[EXTRA] 正确R反转、C¹场、实际全时间流、群性质；不供应结论。 -/
theorem flowReversalIdentity :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z := by
  sorry

/-- source_id: MD-3.6.2-ReversibleMethod · (3.15) · §3.6.2 · 印刷p.130 / PDFp.152 -/
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z

/-- source_id: MD-3.6.2-SymmetricMethod · definition · §3.6.2 · 印刷p.130 / PDFp.152 -/
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm

/-- source_id: MD-3.6.2-AffineInvariant · Definition 3.1 · §3.6.2 · 印刷p.130 / PDFp.152
[ERRATUM?] (3.17)左端印刷z而不是z̃；保留原文，语义按前后说明的变换坐标。 -/
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)

/-- source_id: MD-3.6.2-SymmetricAffineReversible · unnumbered_claim · §3.6.2 · 印刷p.130 / PDFp.152
[EXTRA] [EXTRA]G_{−f}(h)=G_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。
[NEEDS_HUMAN] 一般方法需要G_{−f}(h)=G_f(−h)，否则原文蕴含式条件不全。 -/
theorem symmetricAffineReversible :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ g h z, G (fun x => -g x) h z=G g (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f) := by
  sorry

/-- source_id: MD-3.6.2-RKAffine · unnumbered_claim · §3.6.2 · 印刷p.130 / PDFp.152 -/
theorem rkAffine :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i)) := by
  exact MolecularDynamics.Chapter03Review.rkAffine_proved

/-- source_id: MD-3.6.2-PartitionedAffinePrinted · unnumbered_claim · §3.6.2 · 印刷p.130 / PDFp.152
[ERRATUM?] PRK一般只对保持分区的分块线性变换等变；任意混合变换的全称可疑。 -/
theorem partitionedAffinePrinted :
  ∀ (n s : ℕ) (L : Z n ≃L[ℝ] Z n) (f : Z n → Z n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) h z w F,
    partitionedRKRelation f Aq Ap bq bp h z w F →
      partitionedRKRelation (fun x => L (f (L.symm x))) Aq Ap bq bp h (L z) (L w) (fun i => L (F i)) := by
  sorry

/-- source_id: MD-3.6.2-PartitionedAffine · unnumbered_claim · §3.6.2 · 印刷p.130 / PDFp.152
[EXTRA] [EXTRA]正确限定为保持q,p分区的连续线性等价Lq,Lp；不同分区表格不要求混合线性等变。 -/
theorem partitionedAffine :
  ∀ (n s : ℕ) (Lq Lp : Q n ≃L[ℝ] Q n) (fq fp : Z n → Q n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) (h : ℝ) (z w : Z n) (Fq Fp : Fin s → Q n),
    (∀ i, Fq i=fq (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    (∀ i, Fp i=fp (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    w=(z.1+h • ∑ i, bq i • Fq i,z.2+h • ∑ i, bp i • Fp i) →
    (∀ i, Lq (Fq i)=Lq (fq (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (∀ i, Lp (Fp i)=Lp (fp (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (Lq w.1,Lp w.2)=(Lq z.1+h • ∑ i, bq i • Lq (Fq i),Lp z.2+h • ∑ i, bp i • Lp (Fp i)) := by
  intro n s Lq Lp fq fp Aq Ap bq bp h z w Fq Fp hq hp hw
  have tq : ∀ a : Fin s → ℝ,
      Lq.symm (Lq z.1+h • ∑ j, a j • Lq (Fq j)) = z.1+h • ∑ j, a j • Fq j := by
    intro a
    apply Lq.injective
    simp
  have tp : ∀ a : Fin s → ℝ,
      Lp.symm (Lp z.2+h • ∑ j, a j • Lp (Fp j)) = z.2+h • ∑ j, a j • Fp j := by
    intro a
    apply Lp.injective
    simp
  refine ⟨?_, ?_, ?_⟩
  · intro i
    rw [tq, tp]
    exact congrArg Lq (hq i)
  · intro i
    rw [tq, tp]
    exact congrArg Lp (hp i)
  · rw [hw]
    simp

/-- source_id: MD-3.6.3-SymplecticNotReversible · unnumbered_claim · §3.6.3 · 印刷p.131 / PDFp.153 -/
theorem symplecticNotReversible :
  ∃ (h : ℝ) (z : Z 1),
    canonicalReversal (textbookSymplecticEuler (fun _ : Fin 1 => 1) (fun q => q 0^2/2) h
      (canonicalReversal (textbookSymplecticEuler (fun _ => 1) (fun q => q 0^2/2) h (pack z)))) ≠ pack z := by
  sorry

/-- source_id: MD-3.6.3-TrapezoidalRelation · definition · §3.6.3 · 印刷p.131 / PDFp.153
[EXTRA] 补梯形法标准隐式关系作为审阅上下文。 -/
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)

/-- source_id: MD-3.6.3-TrapezoidalProperties · unnumbered_claim · §3.6.3 · 印刷p.131 / PDFp.153
[EXTRA] 完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。 -/
theorem trapezoidalProperties :
  (∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) h z w,
    linearInvolution R → (∀ x, f (R x)=-R (f x)) → trapezoidalRelation f h z w →
    trapezoidalRelation f h (R w) (R z)) ∧
  ∃ (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ),
    ContDiff ℝ ⊤ H ∧ ContDiff ℝ 1 (G h) ∧
    (∀ z, G h z=z+(h/2) • (textbookHamiltonianVectorField H z+textbookHamiltonianVectorField H (G h z))) ∧
    ¬ IsTextbookSymplecticMap (G h) := by
  sorry

/-- source_id: MD-3.6.3-HamiltonianSpectrum · unnumbered_claim · §3.6.3 · 印刷p.131 / PDFp.153
[ERRATUM?] 同一u一般不是转置特征向量；四元素集合可重复，不声称总有4个互异值。 -/
theorem hamiltonianSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ), A.transpose=A → ∀ ζ,
    complexEigenvalue (textbookJ n*A) ζ → complexEigenvalue (textbookJ n*A) (-ζ) ∧
      complexEigenvalue (textbookJ n*A) (star ζ) := by
  sorry

/-- source_id: MD-3.6.3-SymplecticSpectrum · unnumbered_claim · §3.6.3 · 印刷p.131 / PDFp.153 -/
theorem symplecticSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ),
    A.transpose*textbookJ n*A=textbookJ n → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ) := by
  sorry

/-- source_id: MD-3.6.3-ReversibleSpectrum · unnumbered_claim · §3.6.3 · 印刷p.131 / PDFp.153
[EXTRA] T可逆、R²=I明确；真实complexEigenvalue，非零性作为结论。 -/
theorem reversibleSpectrum :
  ∀ (n : ℕ) (A R : Matrix (Fin n) (Fin n) ℝ), IsUnit A.det → R*R=1 →
    A⁻¹=R*A*R → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ) := by
  sorry

/-- source_id: MD-3.6.3-ConjugateIterates · unnumbered_claim · §3.6.3 · 印刷p.131–132 / PDFp.153–154
[EXTRA] χ明确为equivalence，以使原文χ⁻¹有定义；原文homomorphism的用词待审。
[ERRATUM?] 原文homomorphism至少需可逆；连续渐近运输还需homeomorphism。 -/
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption

/-- source_id: MD-3.6.1-MechanicalReversalCorrect · unnumbered_claim · §3.6.1 · 印刷p.128 / PDFp.150
[EXTRA] [EXTRA]独立正确机械R反转结论；原书错误展示等式仍由MechanicalReversalPrinted保留，不静默更改它。 -/
theorem mechanicalReversalCorrect :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) z,
    mechanicalField m F (momentumReversal z)=-momentumReversal (mechanicalField m F z) := by
  exact MolecularDynamics.Chapter03Review.mechanicalReversal_proved

/-- source_id: MD-3.6.3-ConjugateOrderPrinted · unnumbered_claim · §3.6.3 · 印刷p.132 / PDFp.154
[EXTRA] 将“same effective order”按同一局部误差幂阶和真实共轭参考流解释；χ至少homeomorphism、紧初值域、r>0。
[NEEDS_HUMAN] homeomorphism可用平方根改变误差阶；原文缺定量正则性，不能由迭代共轭冒充已证同有效阶。 -/
theorem conjugateOrderPrinted :
    ∀ (n r : ℕ) (χ : Q n ≃ₜ Q n) (G Φ : ℝ → Q n → Q n) (B : Set (Q n)),
      0 < r → IsCompact B → MolecularDynamics.Chapter03Review.localOrder G Φ B r →
      MolecularDynamics.Chapter03Review.localOrder
        (fun h z => χ (G h (χ.symm z))) (fun h z => χ (Φ h (χ.symm z))) (χ '' B) r := by
  sorry

/-- source_id: MD-3.6.3-ReversibleVolumeFailure · unnumbered_claim · §3.6.3 · 印刷p.132 / PDFp.154 -/
theorem reversibleVolumeFailure :
  ∃ (n : ℕ) (R : Q n →L[ℝ] Q n) (G : Q n ≃ Q n), linearInvolution R ∧
    ContDiff ℝ 1 G ∧ ContDiff ℝ 1 G.symm ∧ (∀ z, R (G (R (G z)))=z) ∧
    ∃ z, |(textbookCoordinateJacobian G z).det| ≠ 1 := by
  sorry

end MD.Ch03
