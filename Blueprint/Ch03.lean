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

end MD.Ch03
