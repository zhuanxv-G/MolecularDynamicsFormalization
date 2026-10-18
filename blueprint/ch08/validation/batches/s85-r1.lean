import MolecularDynamics.Chapter06.ReviewDefinitions
import MolecularDynamics.Chapter08.StationaryDensityFlow
import MolecularDynamics.Chapter08.ThermostatHormander
import MolecularDynamics.Chapter08.ThermostatModeInvariant
import Mathlib.Tactic

open Set Filter MeasureTheory ProbabilityTheory MolecularDynamics
open scoped BigOperators Topology ContDiff ENNReal NNReal Matrix
noncomputable section
namespace MD.Ch08
variable {Ω : Type*} [MeasurableSpace Ω]
variable {n : ℕ}

/-- source_id: MD-8.1-CanonicalCorrelation · 印刷p.329–330 / PDFp.350–351
[EXTRA] 相关分母非零才有C(0)=1；向量观测的点积由标量乘积表示，其余分量情形未展开。 -/
abbrev Vec (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := Vec n × Vec n
def dot (v w : Vec n) : ℝ := ∑ i, v i * w i
def gradient (U : Vec n → ℝ) (q : Vec n) : Vec n := fun i ↦ fderiv ℝ U q (Pi.single i 1)
def gibbsWeight {E : Type*} (H : E → ℝ) (β : ℝ) (z : E) : ℝ := Real.exp (-β * H z)
def canonicalAverage {E : Type*} [MeasurableSpace E] (μ : Measure E)
    (ρ g : E → ℝ) : ℝ := (∫ z, g z * ρ z ∂μ) / ∫ z, ρ z ∂μ
def probabilityDensity {E : Type*} [MeasurableSpace E] (μ : Measure E) (ρ : E → ℝ) : Prop :=
  (∀ z, 0 ≤ ρ z) ∧ Integrable ρ μ ∧ ∫ z, ρ z ∂μ = 1
def correlation {E : Type*} [MeasurableSpace E] (μ : Measure E) (ρ A B : E → ℝ)
    (flow : ℝ → E → E) (t : ℝ) : ℝ :=
  (∫ z, A z * B (flow t z) * ρ z ∂μ) / ∫ z, A z * B z * ρ z ∂μ
theorem correlation_zero {E : Type*} [MeasurableSpace E] (μ : Measure E)
    (ρ A B : E → ℝ) (flow : ℝ → E → E) (h0 : flow 0 = id)
    (hden : (∫ z, A z * B z * ρ z ∂μ) ≠ 0) : correlation μ ρ A B flow 0 = 1 := by
  simp [correlation, h0, hden]

/-- source_id: MD-8.1-HamiltonianStationary · 印刷p.330 / PDFp.351
[EXTRA] 只桥接光滑Hamiltonian的Gibbs权重驻定方程；一般φ(H)、算子偏斜伴随及流的保测性未由本条覆盖。 -/
def hamiltonianField (invm : Vec n) (U : Vec n → ℝ) (z : Phase n) : Phase n :=
  (fun i ↦ invm i * z.2 i, fun i ↦ - gradient U z.1 i)
theorem hamiltonianGibbsStationary (H : SymplecticCoordinates n → ℝ)
    (β : ℝ) (hH : ContDiff ℝ 2 H) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H)
      (textbookHamiltonianGibbsWeight H β) := by
  exact textbookHamiltonianGibbsWeight_stationary hH β

/-- source_id: MD-8.1-ExtendedDensity · 印刷p.331 / PDFp.352
[EXTRA] 辅助密度归一、乘积积分可积；使用有限/σ有限测度条件。 -/
def extendedDensity {E B : Type*} (ρ : E → ℝ) (a : B → ℝ) (z : E × B) : ℝ := ρ z.1 * a z.2
theorem extendedAverage {E B : Type*} [MeasurableSpace E] [MeasurableSpace B]
    (μ : Measure E) (ν : Measure B) [SFinite μ] [SFinite ν]
    (ρ g : E → ℝ) (a : B → ℝ) (ha : ∫ y, a y ∂ν = 1)
    (hi : Integrable (fun z : E × B ↦ g z.1 * extendedDensity ρ a z) (μ.prod ν)) :
    (∫ z, g z.1 * extendedDensity ρ a z ∂μ.prod ν) = ∫ x, g x * ρ x ∂μ := by
  calc
    _ = (∫ x, g x * ρ x ∂μ) * ∫ y, a y ∂ν := by
      simpa only [extendedDensity, mul_assoc] using
        (integral_prod_mul (μ:=μ) (ν:=ν) (fun x ↦ g x * ρ x) a)
    _ = _ := by rw [ha, mul_one]

/-- source_id: MD-8.1.1-NoseHoover · 印刷p.331 / PDFp.352
[EXTRA] μ记为Q且Q>0，β>0，正质量，热浴变量ξ∈ℝ；总函数nhField配合资格谓词使用。 -/
def thermostatParameters (invm : Vec n) (β Q : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q
def kineticTwice (invm p : Vec n) : ℝ := ∑ i, invm i * p i ^ 2
def nhField (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ invm i * z.1.2 i, fun i ↦ -gradient U z.1.1 i - z.2 * z.1.2 i),
   (kineticTwice invm z.1.2 - (n : ℝ)/β)/Q)
def isNHSolution (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (z : ℝ → Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ ∀ t, HasDerivAt z (nhField invm U β Q (z t)) t

/-- source_id: MD-8.1.1-NHDensitySplit · 印刷p.332 / PDFp.353
[EXTRA] 指数为未归一权重；若称概率密度还要求有限正配分积分并归一化。 -/
def nhWeight (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β * (kineticTwice invm z.1.2 / 2 + U z.1.1 + Q*z.2^2/2))
def nhBathField (invm : Vec n) (β Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((0, fun i ↦ -z.2 * z.1.2 i), (kineticTwice invm z.1.2 - (n : ℝ)/β)/Q)
theorem nhField_split (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q z = (hamiltonianField invm U z.1, (0 : ℝ)) + nhBathField invm β Q z := by
  ext <;> simp [nhField, hamiltonianField, nhBathField, sub_eq_add_neg]
theorem nhWeight_stationary (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhField invm U β Q) (nhWeight invm U β Q) := by
  sorry

/-- source_id: MD-8.1.1-NHFirstIntegralPrinted · 印刷p.333 / PDFp.354
[EXTRA] s>0；原文版不证明，修正版另列；两版均保留原文H形式。
[ERRATUM?] 已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。 -/
def nhIntegral (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) (s : ℝ) : ℝ :=
  kineticTwice invm z.1.2 / 2 + U z.1.1 + Q*z.2^2/2 + (n : ℝ)/β*Real.log s
theorem nhIntegralPrinted (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U)
    (z : ℝ → Phase n × ℝ) (s : ℝ → ℝ) (hz : isNHSolution invm U β Q z)
    (hs : ∀ t, HasDerivAt s (z t).2 t) (hpos : ∀ t, 0 < s t) :
    ∀ t, HasDerivAt (fun r ↦ nhIntegral invm U β Q (z r) (s r)) 0 t := by
  sorry
theorem nhIntegral_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U)
    (z : ℝ → Phase n × ℝ) (s : ℝ → ℝ) (hz : isNHSolution invm U β Q z)
    (hs : ∀ t, HasDerivAt s (s t * (z t).2) t) (hpos : ∀ t, 0 < s t) :
    ∀ t, HasDerivAt (fun r ↦ nhIntegral invm U β Q (z r) (s r)) 0 t := by
  sorry

/-- source_id: MD-8.1.2-NHReversal · 印刷p.333 / PDFp.354 -/
def nhReversal (z : Phase n × ℝ) : Phase n × ℝ := ((z.1.1, -z.1.2), -z.2)
theorem nhReversal_involutive : Function.Involutive (nhReversal (n:=n)) := by
  intro z; ext <;> simp [nhReversal]
theorem nhReversal_field (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q (nhReversal z) =
    ((fun i ↦ -(nhField invm U β Q z).1.1 i, (nhField invm U β Q z).1.2), (nhField invm U β Q z).2) := by
  ext <;> simp [nhField, nhReversal, kineticTwice] <;> ring

/-- source_id: MD-8.1.2-NHTimestep · 印刷p.333 / PDFp.354
[EXTRA] c在ξ=0处取连续延拓t；系数Taylor级数与二阶全局误差未由单步定义证明。 -/
def dampedCoefficient (t ξ : ℝ) : ℝ := if ξ = 0 then t else (1-Real.exp (-t*ξ))/ξ
def nhDrift (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i + h*invm i*z.1.2 i, z.1.2), z.2)
def nhKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i - dampedCoefficient h z.2*gradient U z.1.1 i), z.2)
def nhFeedback (invm : Vec n) (β Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2 + h/Q*(kineticTwice invm z.1.2 - (n : ℝ)/β))
def nhStep (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  nhDrift invm (h/2) ∘ nhKick U (h/2) ∘ nhFeedback invm β Q h ∘ nhKick U (h/2) ∘ nhDrift invm (h/2)
theorem dampedCoefficient_zero (t : ℝ) : dampedCoefficient t 0 = t := by simp [dampedCoefficient]

/-- source_id: MD-8.1.2-NHTimestepReversible · 印刷p.333 / PDFp.354
[EXTRA] 逆映射以负步长映射及LeftInverse表达；不假设算法可逆作为结论的前提。 -/
theorem nhStep_reversible (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    nhReversal ∘ nhStep invm U β Q h ∘ nhReversal = nhStep invm U β Q (-h) := by
  sorry
theorem nhStep_inverse (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    Function.LeftInverse (nhStep invm U β Q (-h)) (nhStep invm U β Q h) := by
  sorry

/-- source_id: MD-8.1.2.1-NoseHamiltoniansPrinted · 印刷p.334 / PDFp.355
[EXTRA] 物理定义域s>0、β,Q及质量正；总函数在此域外不作物理解释。
[ERRATUM?] 已目视核对原页PDF355：H_N先用(N_d+1)，(8.9)展开却用N_d；同名H_N等号不一致。工作修正显式减去β⁻¹ln s。 -/
def noseHamiltonian (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (q p : Vec n) (s π : ℝ) : ℝ :=
  kineticTwice invm p / (2*s^2) + π^2/(2*Q) + U q + ((n : ℝ)+1)/β*Real.log s
def npHamiltonian (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (q p : Vec n) (s π : ℝ) : ℝ :=
  s*(kineticTwice invm p/(2*s^2) + π^2/(2*Q) + U q + (n : ℝ)/β*Real.log s - EN)
theorem nosePoincarePrinted (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (hp : thermostatParameters invm β Q) (q p : Vec n) (s π : ℝ) (hs : 0 < s) :
    npHamiltonian invm U β Q EN q p s π = s*(noseHamiltonian invm U β Q q p s π-EN) := by
  sorry
theorem nosePoincare_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (q p : Vec n) (s π : ℝ) :
    npHamiltonian invm U β Q EN q p s π = s*(noseHamiltonian invm U β Q q p s π-Real.log s/β-EN) := by
  unfold npHamiltonian noseHamiltonian
  ring

/-- source_id: MD-8.1.2.1-NPEquations · 印刷p.334 / PDFp.355
[EXTRA] ΔH采用(8.9)展开内的N_d版本；β,Q>0及s>0为有效域；尚未桥接实际Hamiltonian梯度。 -/
def npField (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : Phase n × (ℝ × ℝ) :=
  let s := z.2.1
  let π := z.2.2
  let delta := kineticTwice invm z.1.2/(2*s^2) + π^2/(2*Q) + U z.1.1 + (n : ℝ)/β*Real.log s - EN
  ((fun i ↦ invm i*z.1.2 i/s, fun i ↦ -s*gradient U z.1.1 i),
   (s*π/Q, kineticTwice invm z.1.2/s^2-(n : ℝ)/β-delta))

/-- source_id: MD-8.1.2.1-NPtoNH · 印刷p.335 / PDFp.356
[EXTRA] 明确零能量面及s>0；零能量守恒本身未假作普遍结论。 -/
def npProjection (z : Phase n × (ℝ × ℝ)) (Q : ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i/z.2.1), z.2.2/Q)
theorem npProjection_equations (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (hp : thermostatParameters invm β Q) (z : ℝ → Phase n × (ℝ × ℝ))
    (hz : ∀ t, HasDerivAt z (npField invm U β Q EN (z t)) t)
    (hs : ∀ t, 0 < (z t).2.1)
    (henergy : ∀ t, npHamiltonian invm U β Q EN (z t).1.1 (z t).1.2 (z t).2.1 (z t).2.2 = 0) :
    isNHSolution invm U β Q (fun t ↦ npProjection (z t) Q) := by
  sorry

/-- source_id: MD-8.1.2.1-NPShadowDensity · 印刷p.335 / PDFp.356
[EXTRA] [EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。 -/
def fourthOrderRemainder (r : ℝ → ℝ) : Prop :=
  ∃ C ε : ℝ, 0 < C ∧ 0 < ε ∧ ∀ h, |h| < ε → |r h| ≤ C*|h|^4
def correctedFiniteAverage (g ζ : ℕ → ℝ) (N : ℕ) : ℝ :=
  (∑ k ∈ Finset.range (N+1), g k / ζ k) / ((N : ℝ)+1)
def npShadowAnsatz (H H2 : Phase n → ℝ) (Htilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ Htilde h z-H z-h^2*H2 z)
def npDensityAnsatz (ρ : Phase n → ℝ) (ζ ρtilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ ρtilde h z-ρ z*ζ h z)

/-- source_id: MD-8.2-GeneralThermostat · 印刷p.336 / PDFp.357
[EXTRA] J为常矩阵，Jᵀ=-J；z、ξ为实向量，光滑资格在结论中给出。 -/
def generalThermostat {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (z : Vec n × Vec k) : Vec n × Vec k := (J *ᵥ gradient H z.1 + Φ z, g z)
def skewMatrix (J : Matrix (Fin n) (Fin n) ℝ) : Prop := J.transpose = -J

/-- source_id: MD-8.2.1-ContinuityProductRule · 印刷p.336–337 / PDFp.357–358
[EXTRA] 覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。 -/
def continuityRHS {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • F x) z
theorem continuity_productRule {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k)
    (hF : DifferentiableAt ℝ F z) (hρ : DifferentiableAt ℝ ρ z) :
    continuityRHS F ρ z = -(fderiv ℝ ρ z (F z)) - ρ z*textbookDivergence F z := by
  rw [continuityRHS, textbookDivergence_density hρ hF]; ring

/-- source_id: MD-8.2.1-ThermostatCriterion · 印刷p.337 / PDFp.358
[EXTRA] 原文μ_i在指数中是热质量，统一写Q_i；矩阵μ⁻¹的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。 -/
def thermalWeight {k : ℕ} (H : Vec n → ℝ) (Q : Vec k) (β : ℝ)
    (z : Vec n × Vec k) : ℝ := Real.exp (-β*(H z.1 + (∑ i, Q i*z.2 i^2)/2))
theorem thermostatCriterion {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (Q : Vec k) (β : ℝ) (hβ : 0 < β) (hQ : ∀ i, 0 < Q i) (hJ : skewMatrix J)
    (hH : ContDiff ℝ 2 H) (hΦ : ContDiff ℝ 1 Φ) (hg : ContDiff ℝ 1 g) :
    textbookLiouvilleStationary (generalThermostat J H Φ g) (thermalWeight H Q β) ↔
    ∀ z, -(textbookDivergence (fun x ↦ Φ (x,z.2)) z.1) +
      β*fderiv ℝ H z.1 (Φ z) + β*(∑ i, Q i*z.2 i*g z i) -
      textbookDivergence (fun y ↦ g (z.1,y)) z.2 = 0 := by
  sorry

/-- source_id: MD-8.2.1-Examples81and82 · 印刷p.337–338 / PDFp.358–359
[EXTRA] Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。 -/
def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
theorem generalizedFeedback_stationary (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry

/-- source_id: MD-8.2.1-TemperatureIdentity · 印刷p.338 / PDFp.359
[EXTRA] 以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求k_B>0、分母非零。 -/
theorem temperatureIdentity (H : Vec n → ℝ) (G : Vec n → Vec n) (β : ℝ)
    (hH : ContDiff ℝ 2 H) (hG : ContDiff ℝ 1 G) (hcompact : HasCompactSupport G)
    (hβ : 0 < β) :
    (∫ z, textbookDivergence G z * gibbsWeight H β z) =
      β * ∫ z, fderiv ℝ H z (G z) * gibbsWeight H β z := by
  sorry
def phaseTemperature (kB numerator denominator : ℝ) : ℝ := numerator/(kB*denominator)

/-- source_id: MD-8.2.1-Proposition81 · 印刷p.338–339 / PDFp.359–360
[EXTRA] 两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。 -/
theorem proposition81 {H : SymplecticCoordinates n → ℝ} (hH : ContDiff ℝ 2 H) (β c : ℝ)
    {φ₁ φ₂ : SymplecticCoordinates n × ℝ → SymplecticCoordinates n}
    {g₁ g₂ : SymplecticCoordinates n × ℝ → ℝ} {a b : ℝ → ℝ}
    (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (hs₁ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₁ g₁)
      (fun w ↦ a w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (hs₂ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₂ g₂)
      (fun w ↦ b w.2 * textbookHamiltonianGibbsDensity H β c w.1)) :
    textbookLiouvilleStationary
      (textbookCombinedThermostatField (textbookHamiltonianVectorField H) φ₁ φ₂ g₁ g₂)
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) := by
  exact textbookThermostats_additive_proposition81 hH β c hφ₁ hφ₂ hg₁ hg₂ ha hb hs₁ hs₂

/-- source_id: MD-8.2.2-NHChains · 印刷p.339–340 / PDFp.360–361
[EXTRA] 链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。 -/
def nhChainField (k : ℕ) (invm : Vec n) (U : Vec n → ℝ) (β : ℝ)
    (Q : Fin k → ℝ) (z : Phase n × (Fin k → ℝ)) : Phase n × (Fin k → ℝ) :=
  ((fun i ↦ invm i*z.1.2 i,
    fun i ↦ -gradient U z.1.1 i - (if hk : 0 < k then z.2 ⟨0,hk⟩ else 0)*z.1.2 i),
   fun j ↦ (if hj : j.val = 0 then (kineticTwice invm z.1.2-(n : ℝ)/β)/Q j
     else (Q ⟨j.val-1,by omega⟩ * z.2 ⟨j.val-1,by omega⟩ ^2 - 1/β)/Q j) -
     (if hj : j.val+1 < k then z.2 j * z.2 ⟨j.val+1,hj⟩ else 0))
theorem nhChain_stationary (k : ℕ) (hk : 0 < k) (invm : Vec n) (U : Vec n → ℝ)
    (β : ℝ) (Q : Fin k → ℝ) (hβ : 0 < β) (hQ : ∀ j, 0 < Q j)
    (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhChainField k invm U β Q)
      (fun z ↦ Real.exp (-β*(kineticTwice invm z.1.2/2+U z.1.1+(∑ j, Q j*z.2 j^2)/2))) := by
  sorry

/-- source_id: MD-8.3-ArrheniusRate · 印刷p.342 / PDFp.363
[EXTRA] A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。 -/
def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le

/-- source_id: MD-8.4-AdditiveThermostatSDE · 印刷p.342–343 / PDFp.363–364
[EXTRA] 加性噪声用独立Wiener路径增量的精确积分方程；漂移可积、路径连续且适应自然历史。完整矩阵噪声给因子B和涨落耗散资格，物理/热浴两组坐标共同独立。 -/
def independentWiener (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, IsBrownianReal (fun t sample ↦ W t sample j) P) ∧
    iIndepFun (fun j sample ↦ fun t : ℝ ↦ W t sample j) P
def additiveSDE {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [MeasurableSpace E]
    (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k)
    (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : Fin k → E) : Prop :=
  independentWiener P k W ∧ (∀ᵐ sample ∂P, Continuous (fun t ↦ X t sample)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ t : ℝ, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 t) ∧
    ∀ᵐ sample ∂P, X t sample = x0 + (∫ s in 0..t, a (X s sample)) +
      ∑ j, (W t sample j-W 0 sample j) • B j
def stochasticThermostatDrift {k : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ : Matrix (Fin n) (Fin n) ℝ) (Γhat : Matrix (Fin k) (Fin k) ℝ)
    (z : Phase n × Vec k) : Phase n × Vec k :=
  ((fun i ↦ invm i*z.1.2 i, fun i ↦ -gradient U z.1.1 i-Φ z i-(Γ *ᵥ z.1.2) i),
   g z - Γhat *ᵥ z.2)
def fluctuationDissipation (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ) : Prop :=
  0 < β ∧ M.PosDef ∧ Γ.PosSemidef ∧ B*B.transpose = (2/β) • (Γ*M)

/-- source_id: MD-8.4-OUStationarityPrinted · 印刷p.343–344 / PDFp.364–365
[EXTRA] Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。
[ERRATUM?] 已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。 -/
def ouFokkerPlanck (A C : Matrix (Fin n) (Fin n) ℝ) (ρ : Vec n → ℝ) (p : Vec n) : ℝ :=
  textbookDivergence (fun x ↦ ρ x • (A *ᵥ x)) p +
    (∑ i, ∑ j, C i j * fderiv ℝ (fun x ↦ gradient ρ x j) p (Pi.single i 1))/2
theorem ouStationarity_corrected (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ)
    (hf : fluctuationDissipation M Γ B β) :
    ∀ p, ouFokkerPlanck Γ (B*B.transpose)
      (fun x ↦ Real.exp (-β * dot x (M⁻¹ *ᵥ x)/2)) p = 0 := by
  sorry
theorem diffusionPrinted (β : ℝ) (hβ : 0 < β) : (1/β)*(-1) = -(1 : ℝ) := by
  sorry
theorem diffusionPrinted_counterexample : ¬ ((1/(2:ℝ))*(-1) = -(1:ℝ)) := by norm_num

/-- source_id: MD-8.4-LiftedThermostat · 印刷p.344–345 / PDFp.365–366
[EXTRA] 真实Wiener、适应性和可积性由additiveSDE给出；σ≠0在Hörmander结论中单列。 -/
def liftedThermostat (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec n × ℝ)
    (x0 : Vec n × ℝ) : Prop :=
  additiveSDE P 1 W X x0 (textbookThermostatDrift F G g γ)
    (fun _ ↦ (0, σ))

/-- source_id: MD-8.4-Proposition82 · 印刷p.344–345 / PDFp.365–366
[EXTRA] Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
[ERRATUM?] 已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。 -/
theorem proposition82Printed (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g)
    (w : Vec n × ℝ) (hspan : textbookHormanderAt {F,G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  sorry
theorem proposition82_corrected (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g)
    (hσ : σ ≠ 0) (w : Vec n × ℝ) (hspan : textbookHormanderAt {F,G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  exact textbookThermostatHormanderLift F G g γ σ hF hG hg hσ w hspan

/-- source_id: MD-8.4.1-NHL · 印刷p.345–346 / PDFp.366–367
[EXTRA] Q>0、β>0、γ>0及单独立Wiener；二次系统A对称正定、M=I；高维无约束自由度n。 -/
def nhlDrift (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (nhField invm U β Q z).1 |> fun physical ↦ (physical, (nhField invm U β Q z).2-γ*z.2)
def isNHLSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Phase n × ℝ)
    (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧
    additiveSDE P 1 W X x0 (nhlDrift invm U β Q γ)
      (fun _ ↦ (0, Real.sqrt (2*γ/(β*Q))))
def harmonicPotential (A : Matrix (Fin n) (Fin n) ℝ) (q : Vec n) : ℝ := dot q (A *ᵥ q)/2

/-- source_id: MD-8.4.1-Lemma81 · 印刷p.347 / PDFp.368
[EXTRA] Lean索引k=0对应原文k=1；完整实际线性场、导数括号与End括号约定均摘录；生成子代数在相反括号下相同。 -/
theorem lemma81 (A : Matrix (Fin n) (Fin n) ℝ) (k : ℕ) :
    textbookThermostatC A k ∈ textbookThermostatLieSpan A ∧
    textbookThermostatD A k ∈ textbookThermostatLieSpan A := by
  exact textbookThermostat_C_D_mem_lieSpan A k

/-- source_id: MD-8.4.1-Proposition83 · 印刷p.347–348 / PDFp.368–369
[EXTRA] D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。 -/
theorem proposition83 (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase n)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    LinearIndependent ℝ (textbookThermostatFamily A z) := by
  exact textbookThermostatFamily_linearIndependent A hA hdist z hz

/-- source_id: MD-8.4.1-Theorem81 · 印刷p.346–348 / PDFp.367–369
[EXTRA] D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
[ERRATUM?] 已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。 -/
theorem theorem81Printed (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  sorry
theorem theorem81_corrected (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ) (hQ : 0 < Q)
    (hθ : 0 < θ) (hγ : 0 < γ) (hσ : σ ≠ 0)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  exact textbookNHL_hormander A hA hdist Q θ γ σ hσ w hw

/-- source_id: MD-8.4.1-ZeroModeInvariant · 印刷p.346 / PDFp.367
[EXTRA] 任意紧时间区间上的实际模态ODE；连续随机热浴路径可逐路径应用，不额外声称SDE解存在。 -/
theorem modeDomain_complement {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian) :
    textbookThermostatModeDomain hA = (⋃ i, textbookNHLZeroMode hA i)ᶜ :=
  textbookThermostatModeDomain_eq_compl_zeroModes hA
theorem zeroMode_invariant {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian)
    (i : Fin n) {a b : ℝ} (q p : ℝ → Vec n) (ξ : ℝ → ℝ)
    (hcq : ContinuousOn q (Icc a b)) (hcp : ContinuousOn p (Icc a b))
    (hξ : ContinuousOn ξ (Icc a b))
    (hq : ∀ t ∈ Ico a b, HasDerivWithinAt q (p t) (Ici t) t)
    (hp : ∀ t ∈ Ico a b, HasDerivWithinAt p (-(A *ᵥ q t)-ξ t • p t) (Ici t) t)
    (hzero : (q a,p a) ∈ textbookNHLZeroMode hA i) :
    ∀ t ∈ Icc a b, (q t,p t) ∈ textbookNHLZeroMode hA i := by
  exact textbookNHL_zeroMode_invariant hA i q p ξ hcq hcp hξ hq hp hzero

/-- source_id: MD-8.4.1-NHLGenerator · 印刷p.348 / PDFp.369
[EXTRA] 采用实际一阶、二阶Fréchet导数；原文省略f的-ξp·∇p理解为作用于f；Q,β,γ须正。 -/
def additiveGenerator {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (B : E) (f : E → ℝ) (z : E) : ℝ :=
  fderiv ℝ f z (F z) + fderiv ℝ (fun x ↦ fderiv ℝ f x B) z B / 2
def nhlGenerator (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (f : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  additiveGenerator (nhlDrift invm U β Q γ) (0, Real.sqrt (2*γ/(β*Q))) f z
def nhlLyapunov (U : Vec n → ℝ) (Q a : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∑ i, z.1.2 i^2)/2 + U z.1.1 + Q*(z.2-a)^2/2
def geometricDriftBound {E : Type*} (L : (E → ℝ) → E → ℝ) (V : E → ℝ) : Prop :=
  (∀ z, 0 < V z) ∧ ∃ α δ : ℝ, 0 < α ∧ 0 < δ ∧ ∀ z, L V z ≤ -α*V z+δ

/-- source_id: MD-8.4.1-LyapunovCalculation · 印刷p.348–349 / PDFp.369–370
[EXTRA] U下界>1且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需C²。 -/
def nhlLyapunovExpression (P2 U ξ Q θ γ a N : ℝ) : ℝ :=
  -a*P2-γ*Q*ξ*(ξ-a)-N*θ*(ξ-a)+θ*γ
theorem nhlLyapunov_calculation (U : Vec n → ℝ) (β Q γ a : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (hQ : 0 < Q) (hγ : 0 < γ)
    (z : Phase n × ℝ) :
    nhlGenerator (fun _ ↦ 1) U β Q γ (nhlLyapunov U Q a) z =
      nhlLyapunovExpression (∑ i, z.1.2 i^2) (U z.1.1) z.2 Q (1/β) γ a n := by
  sorry
theorem shiftedSquare_bound (ξ a : ℝ) : -ξ^2-a^2 ≤ -(ξ-a)^2/2 := by
  nlinarith [sq_nonneg (ξ+a)]

/-- source_id: MD-8.4.1-LyapunovRatePrinted · 印刷p.349 / PDFp.370
[EXTRA] 修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。
[ERRATUM?] 已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。 -/
def lyapunovAlphaPrinted (a γ Q : ℝ) : ℝ := min (2*a) (γ*Q)
def lyapunovAlpha_corrected (a γ : ℝ) : ℝ := min (2*a) γ
theorem lyapunovRatePrinted (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlphaPrinted a γ Q * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlphaPrinted a γ Q*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
theorem lyapunovRate_counterexample :
    ¬ (nhlLyapunovExpression 0 2 10 4 1 1 2 8 ≤
      -lyapunovAlphaPrinted 2 1 4 * ((0:ℝ)/2+2+4*(10-2)^2/2) +
      (lyapunovAlphaPrinted 2 1 4*2+1*4*2^2+2*8*1+1*1)) := by
  norm_num [nhlLyapunovExpression, lyapunovAlphaPrinted]
theorem lyapunovRate_corrected (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlpha_corrected a γ * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlpha_corrected a γ*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry

/-- source_id: MD-8.4.2-NHLTimestep · 印刷p.350 / PDFp.371
[EXTRA] R_n独立标准正态；h≥0、β,Q>0、γ≥0用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。 -/
def nhlOU (β Q γ h R : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, Real.exp (-γ*h)*z.2 + Real.sqrt ((1-Real.exp (-2*γ*h))/(β*Q))*R)
def forceKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i-h*gradient U z.1.1 i), z.2)
def bathDamping (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i), z.2)
def nhlStep (invm : Vec n) (U : Vec n → ℝ) (β Q γ h R : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  forceKick U (h/2) ∘ nhDrift invm (h/2) ∘ nhFeedback invm β Q (h/2) ∘ bathDamping (h/2) ∘
  nhlOU β Q γ h R ∘ bathDamping (h/2) ∘ nhFeedback invm β Q (h/2) ∘ nhDrift invm (h/2) ∘ forceKick U (h/2)
def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧ ∀ k, HasLaw (R k) (gaussianReal 0 1) P

/-- source_id: MD-8.4.1-NHLWeakStationary · 印刷p.345–346 / PDFp.366–367
[EXTRA] 只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。 -/
def weakStationaryNHL (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (ρ : Phase n × ℝ → ℝ) : Prop :=
  probabilityDensity volume ρ ∧ ∀ f : Phase n × ℝ → ℝ,
    ContDiff ℝ ∞ f → HasCompactSupport f →
    (∫ z, nhlGenerator invm U β Q γ f z * ρ z) = 0
theorem nhlWeakStationary (invm : Vec n) (U : Vec n → ℝ) (β Q γ Z : ℝ)
    (hp : thermostatParameters invm β Q) (hγ : 0 < γ) (hZ : 0 < Z)
    (hU : ContDiff ℝ 2 U) (hi : Integrable (nhWeight invm U β Q))
    (hpart : ∫ z, nhWeight invm U β Q z = Z) :
    weakStationaryNHL invm U β Q γ (fun z ↦ nhWeight invm U β Q z/Z) := by
  sorry

/-- source_id: MD-8.4.3-PreEquilibriumMeans · 印刷p.354–355 / PDFp.375–376
[EXTRA] ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。 -/
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  ∀ t, 0 ≤ t → probabilityDensity volume (ρ t)

/-- source_id: MD-8.4.4-VelocityRescaling · 印刷p.355 / PDFp.376
[EXTRA] Φ在K>0光滑正，KΦ在0附近有界且多项式增长；原始Φ在K=0奇异，未声称全空间光滑扩散或遍历性。 -/
def rescalingPsi (Φ : ℝ → ℝ) (θ K : ℝ) : ℝ :=
  (2*K-((n:ℝ)+1)*θ)*Φ K-2*θ*K*deriv Φ K
def rescalingDrift (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (z.2, fun i ↦ -gradient U z.1 i-rescalingPsi (n:=n) Φ θ ((∑ j, z.2 j^2)/2)*z.2 i)
def rescalingNoise (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (0, fun i ↦ Real.sqrt (2*θ*Φ ((∑ j, z.2 j^2)/2))*z.2 i)
def originalRescalingPhi (γ K : ℝ) : ℝ := γ/(2*K)
def rescalingAdmissible (Φ : ℝ → ℝ) : Prop :=
  ContDiffOn ℝ ∞ Φ (Ioi 0) ∧ (∀ K, 0 < K → 0 < Φ K) ∧
  (∃ C ε : ℝ, 0 < ε ∧ ∀ K, 0 < K → K < ε → |K*Φ K| ≤ C) ∧
  ∃ C : ℝ, ∃ m : ℕ, ∀ K, 1 ≤ K → |Φ K| ≤ C*K^m
theorem rescalingPsi_original (γ θ K : ℝ) (hK : K ≠ 0) :
    rescalingPsi (n:=n) (originalRescalingPhi γ) θ K =
      (1-((n:ℝ)-1)*θ/(2*K))*γ := by
  sorry

/-- source_id: MD-8.4.4-RescalingStationary · 印刷p.355 / PDFp.376
[EXTRA] 测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。 -/
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ Function.support f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry

/-- source_id: MD-8.4.5-ThermostatEfficiency · 印刷p.356–357 / PDFp.377–378
[EXTRA] 表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。 -/
def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2

/-- source_id: MD-8.5-SLS · 印刷p.357–358 / PDFp.378–379
[EXTRA] 全部n+1个Wiener坐标独立，Q、质量、温度及两摩擦参数正；总漂移和常噪声用实际积分方程解释。 -/
def slsDrift (invm : Vec n) (U : Vec n → ℝ) (Q γ γb : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, fun i ↦ -γ*z.1.2 i),
   -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q-γb*z.2)
def slsNoise (invm : Vec n) (β Q γ γb : ℝ) (j : Fin (n+1)) : Phase n × ℝ :=
  if hj : j.val < n then
    ((0, Pi.single ⟨j.val,hj⟩ (Real.sqrt (2*γ/(β*invm ⟨j.val,hj⟩)))), 0)
  else ((0,0), Real.sqrt (2*γb/(β*Q)))
def isSLSSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ γb : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec (n+1))
    (X : ℝ → Ω → Phase n × ℝ) (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧ 0 < γb ∧
  additiveSDE P (n+1) W X x0 (slsDrift invm U Q γ γb) (slsNoise invm β Q γ γb)
def slsDeterministic (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, 0), -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)

/-- source_id: MD-8.5-SLSBracketPrinted · 印刷p.358 / PDFp.379
[EXTRA] 只纠正第一括号；二次括号的整体符号不影响生成空间张成。
[ERRATUM?] 已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。 -/
def slsBathNoise : Phase n × ℝ → Phase n × ℝ := fun _ ↦ ((0,0),1)
theorem slsBracketPrinted (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((z.1.2,0),1) := by
  sorry
theorem slsBracket_corrected (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((-z.1.2,0),1) := by
  sorry

/-- source_id: MD-8.5-SLSHormander · 印刷p.357–358 / PDFp.378–379
[EXTRA] 单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。 -/
theorem slsHormander (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    textbookHormanderAt
      (insert (slsDrift (fun _ ↦ 1) U 1 1 1)
        (Set.range (fun j : Fin (n+1) ↦ fun _ : Phase n × ℝ ↦ slsNoise (fun _ ↦ 1) 2 1 1 1 j))) z := by
  sorry

/-- source_id: MD-8.5-SLSConservation · 印刷p.358 / PDFp.379
[EXTRA] 完整权重含p高斯项，确定性p固定；只保留驻定及零散度，完整SDE概率不变和离散迭代收敛列缺口。 -/
theorem slsDeterministic_stationary (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (slsDeterministic invm U Q) (nhWeight invm U β Q) := by
  sorry
theorem slsDeterministic_divergence (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (hU : ContDiff ℝ 2 U) (z : Phase n × ℝ) :
    textbookDivergence (slsDeterministic invm U Q) z = 0 := by
  sorry

/-- source_id: MD-8.5-SLSLeapfrog · 印刷p.358–359 / PDFp.379–380
[EXTRA] 原文η约化方程漏μ⁻¹，算法保留Q⁻¹；本条覆盖原页算法及逐坐标场，不声称二阶不变分布误差或精确求积实现。 -/
def slsBathKick (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2-h*dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
def slsDriftStep (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i+h*z.2*invm i*z.1.2 i,z.1.2),z.2)
def slsLeapfrog (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  slsBathKick invm U Q (h/2) ∘ slsDriftStep invm h ∘ slsBathKick invm U Q (h/2)
def slsCoordinateField (i : Fin n) (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((Pi.single i (z.2*invm i*z.1.2 i),0), -invm i*z.1.2 i*gradient U z.1.1 i/Q)

end MD.Ch08

#print axioms MD.Ch08.Vec
#print axioms MD.Ch08.Phase
#print axioms MD.Ch08.dot
#print axioms MD.Ch08.gradient
#print axioms MD.Ch08.gibbsWeight
#print axioms MD.Ch08.canonicalAverage
#print axioms MD.Ch08.probabilityDensity
#print axioms MD.Ch08.correlation
#print axioms MD.Ch08.correlation_zero
#print axioms MD.Ch08.hamiltonianField
#print axioms MD.Ch08.hamiltonianGibbsStationary
#print axioms MD.Ch08.extendedDensity
#print axioms MD.Ch08.extendedAverage
#print axioms MD.Ch08.thermostatParameters
#print axioms MD.Ch08.kineticTwice
#print axioms MD.Ch08.nhField
#print axioms MD.Ch08.isNHSolution
#print axioms MD.Ch08.nhWeight
#print axioms MD.Ch08.nhBathField
#print axioms MD.Ch08.nhField_split
#print axioms MD.Ch08.nhWeight_stationary
#print axioms MD.Ch08.nhIntegral
#print axioms MD.Ch08.nhIntegralPrinted
#print axioms MD.Ch08.nhIntegral_corrected
#print axioms MD.Ch08.nhReversal
#print axioms MD.Ch08.nhReversal_involutive
#print axioms MD.Ch08.nhReversal_field
#print axioms MD.Ch08.dampedCoefficient
#print axioms MD.Ch08.nhDrift
#print axioms MD.Ch08.nhKick
#print axioms MD.Ch08.nhFeedback
#print axioms MD.Ch08.nhStep
#print axioms MD.Ch08.dampedCoefficient_zero
#print axioms MD.Ch08.nhStep_reversible
#print axioms MD.Ch08.nhStep_inverse
#print axioms MD.Ch08.noseHamiltonian
#print axioms MD.Ch08.npHamiltonian
#print axioms MD.Ch08.nosePoincarePrinted
#print axioms MD.Ch08.nosePoincare_corrected
#print axioms MD.Ch08.npField
#print axioms MD.Ch08.npProjection
#print axioms MD.Ch08.npProjection_equations
#print axioms MD.Ch08.fourthOrderRemainder
#print axioms MD.Ch08.correctedFiniteAverage
#print axioms MD.Ch08.npShadowAnsatz
#print axioms MD.Ch08.npDensityAnsatz
#print axioms MD.Ch08.generalThermostat
#print axioms MD.Ch08.skewMatrix
#print axioms MD.Ch08.continuityRHS
#print axioms MD.Ch08.continuity_productRule
#print axioms MD.Ch08.thermalWeight
#print axioms MD.Ch08.thermostatCriterion
#print axioms MD.Ch08.generalizedFeedback
#print axioms MD.Ch08.configurationalFeedback
#print axioms MD.Ch08.generalizedFeedback_stationary
#print axioms MD.Ch08.temperatureIdentity
#print axioms MD.Ch08.phaseTemperature
#print axioms MD.Ch08.proposition81
#print axioms MD.Ch08.nhChainField
#print axioms MD.Ch08.nhChain_stationary
#print axioms MD.Ch08.arrheniusRate
#print axioms MD.Ch08.arrheniusRate_nonneg
#print axioms MD.Ch08.independentWiener
#print axioms MD.Ch08.additiveSDE
#print axioms MD.Ch08.stochasticThermostatDrift
#print axioms MD.Ch08.fluctuationDissipation
#print axioms MD.Ch08.ouFokkerPlanck
#print axioms MD.Ch08.ouStationarity_corrected
#print axioms MD.Ch08.diffusionPrinted
#print axioms MD.Ch08.diffusionPrinted_counterexample
#print axioms MD.Ch08.liftedThermostat
#print axioms MD.Ch08.proposition82Printed
#print axioms MD.Ch08.proposition82_corrected
#print axioms MD.Ch08.nhlDrift
#print axioms MD.Ch08.isNHLSolution
#print axioms MD.Ch08.harmonicPotential
#print axioms MD.Ch08.lemma81
#print axioms MD.Ch08.proposition83
#print axioms MD.Ch08.theorem81Printed
#print axioms MD.Ch08.theorem81_corrected
#print axioms MD.Ch08.modeDomain_complement
#print axioms MD.Ch08.zeroMode_invariant
#print axioms MD.Ch08.additiveGenerator
#print axioms MD.Ch08.nhlGenerator
#print axioms MD.Ch08.nhlLyapunov
#print axioms MD.Ch08.geometricDriftBound
#print axioms MD.Ch08.nhlLyapunovExpression
#print axioms MD.Ch08.nhlLyapunov_calculation
#print axioms MD.Ch08.shiftedSquare_bound
#print axioms MD.Ch08.lyapunovAlphaPrinted
#print axioms MD.Ch08.lyapunovAlpha_corrected
#print axioms MD.Ch08.lyapunovRatePrinted
#print axioms MD.Ch08.lyapunovRate_counterexample
#print axioms MD.Ch08.lyapunovRate_corrected
#print axioms MD.Ch08.nhlOU
#print axioms MD.Ch08.forceKick
#print axioms MD.Ch08.bathDamping
#print axioms MD.Ch08.nhlStep
#print axioms MD.Ch08.standardNormalSequence
#print axioms MD.Ch08.weakStationaryNHL
#print axioms MD.Ch08.nhlWeakStationary
#print axioms MD.Ch08.meanKineticTwice
#print axioms MD.Ch08.meanBath
#print axioms MD.Ch08.preEquilibriumDensity
#print axioms MD.Ch08.rescalingPsi
#print axioms MD.Ch08.rescalingDrift
#print axioms MD.Ch08.rescalingNoise
#print axioms MD.Ch08.originalRescalingPhi
#print axioms MD.Ch08.rescalingAdmissible
#print axioms MD.Ch08.rescalingPsi_original
#print axioms MD.Ch08.rescalingStationary
#print axioms MD.Ch08.thermostatEfficiency
#print axioms MD.Ch08.langevinErrorEstimate
#print axioms MD.Ch08.rescalingRateEstimate
#print axioms MD.Ch08.rescalingErrorEstimate
#print axioms MD.Ch08.nhlRateEstimate
#print axioms MD.Ch08.nhlErrorEstimate
#print axioms MD.Ch08.slsDrift
#print axioms MD.Ch08.slsNoise
#print axioms MD.Ch08.isSLSSolution
#print axioms MD.Ch08.slsDeterministic
#print axioms MD.Ch08.slsBathNoise
#print axioms MD.Ch08.slsBracketPrinted
#print axioms MD.Ch08.slsBracket_corrected
#print axioms MD.Ch08.slsHormander
#print axioms MD.Ch08.slsDeterministic_stationary
#print axioms MD.Ch08.slsDeterministic_divergence
#print axioms MD.Ch08.slsBathKick
#print axioms MD.Ch08.slsDriftStep
#print axioms MD.Ch08.slsLeapfrog
#print axioms MD.Ch08.slsCoordinateField
