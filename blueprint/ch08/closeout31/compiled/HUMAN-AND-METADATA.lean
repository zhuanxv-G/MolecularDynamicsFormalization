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
[SCOPE] 规范平均、标量相关函数及零时归一；混合时的大时间极限定性说明另列。
[EXTRA] 相关分母非零才有C(0)=1；向量观测的点积由标量乘积表示，其余分量情形未展开。
[EXTRA] [EXTRA/范围说明] 无需修改签名；将flow 0=id及分母非零也显式列入[EXTRA]，不要把标量特例说成已覆盖任意向量观测。 -/
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
[SCOPE] 光滑Hamiltonian Gibbs权重的Liouville驻定方程；其余三项列覆盖缺口。
[EXTRA] 只桥接光滑Hamiltonian的Gibbs权重驻定方程；一般φ(H)、算子偏斜伴随及流的保测性未由本条覆盖。
[EXTRA] [EXTRA/范围说明] 保留有限范围说明；若以后声称完整覆盖原文，应另列一般φ(H)、形式伴随及流不变性。 -/
def hamiltonianField (invm : Vec n) (U : Vec n → ℝ) (z : Phase n) : Phase n :=
  (fun i ↦ invm i * z.2 i, fun i ↦ - gradient U z.1 i)
theorem hamiltonianGibbsStationary (H : SymplecticCoordinates n → ℝ)
    (β : ℝ) (hH : ContDiff ℝ 2 H) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H)
      (textbookHamiltonianGibbsWeight H β) := by
  exact textbookHamiltonianGibbsWeight_stationary hH β

/-- source_id: MD-8.1-ExtendedDensity · 印刷p.331 / PDFp.352
[SCOPE] 乘积权定义及辅助因子积分为1时的边缘积分等式；不额外证明概率正性或一般流不变性。
[EXTRA] 辅助密度归一、乘积积分可积；使用有限/σ有限测度条件。
[EXTRA] [EXTRA/范围说明] 保留[EXTRA]辅助归一、可积、SFinite条件；不要据此声称已证明遍历性或采样正确。 -/
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
[SCOPE] 正参数资格、动能平方和、NH实际向量场及全实时间ODE规格。
[EXTRA] μ记为Q且Q>0，β>0，正质量，热浴变量ξ∈ℝ；总函数nhField配合资格谓词使用。
[EXTRA] [EXTRA/范围说明] 补充[EXTRA]采用对角质量、C¹经典解及全实时间解规格；局部解应用需另作区间版本。 -/
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
[SCOPE] 权重、分裂及完整场驻定；伴随算子分裂可由散度线性导出但未另作声明。
[EXTRA] 指数为未归一权重；若称概率密度还要求有限正配分积分并归一化。
[EXTRA] [EXTRA/范围说明] 可保留现有范围；把热浴单独驻定未单列也写入覆盖缺口。权重未归一。 -/
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
[SCOPE] 第一积分候选、原印s导数与修正s导数各自对应的沿解零导数目标；原印版不证。
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

/-- source_id: MD-8.1.2-NHReversal · 印刷p.333 / PDFp.354
[SCOPE] 反演为对合及向量场反演等式；不另称一般ODE流的全局反演定理。 -/
def nhReversal (z : Phase n × ℝ) : Phase n × ℝ := ((z.1.1, -z.1.2), -z.2)
theorem nhReversal_involutive : Function.Involutive (nhReversal (n:=n)) := by
  intro z; ext <;> simp [nhReversal]
theorem nhReversal_field (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q (nhReversal z) =
    ((fun i ↦ -(nhField invm U β Q z).1.1 i, (nhField invm U β Q z).1.2), (nhField invm U β Q z).2) := by
  ext <;> simp [nhField, nhReversal, kineticTwice] <;> ring

/-- source_id: MD-8.1.2-NHTimestep · 印刷p.333 / PDFp.354
[SCOPE] 五段单步算法与c的可去奇点延拓；Taylor展开及二阶收敛列覆盖缺口。
[EXTRA] c在ξ=0处取连续延拓t；系数Taylor级数与二阶全局误差未由单步定义证明。
[EXTRA] [EXTRA/范围说明] 保留零点连续延拓[EXTRA]及Taylor/收敛阶覆盖缺口；有效物理域仍是正质量、β,Q。 -/
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
[SCOPE] 五段单步的反演等式及负步长左逆两个目标；未建立误差阶数。
[EXTRA] 逆映射以负步长映射及LeftInverse表达；不假设算法可逆作为结论的前提。 -/
theorem nhStep_reversible (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    nhReversal ∘ nhStep invm U β Q h ∘ nhReversal = nhStep invm U β Q (-h) := by
  sorry
theorem nhStep_inverse (invm : Vec n) (U : Vec n → ℝ) (β Q h : ℝ) :
    Function.LeftInverse (nhStep invm U β Q (-h)) (nhStep invm U β Q h) := by
  sorry

/-- source_id: MD-8.1.2.1-NoseHamiltoniansPrinted · 印刷p.334 / PDFp.355
[SCOPE] 两个原印Hamiltonian定义、所印等式目标及减去对数差项后的代数修正。
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
[SCOPE] NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。
[EXTRA] ΔH采用(8.9)展开内的N_d版本；β,Q>0及s>0为有效域；尚未桥接实际Hamiltonian梯度。
[EXTRA] 已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。
[EXTRA] [EXTRA] npValidDomain明确列有效物理域；使用npField作NP方程时必须另具此资格，总函数自身不强制。
[ERRATUM?] [ERRATUM?] ΔH_N采用(8.9)展开中的N_d版本，与前一定义(N_d+1)版本不同，须明确区分。
[ERRATUM?] 已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。 -/
/-- 修正版采用(8.9)展开中的n/β版本，区别于前文(n+1)/β的同名H_N。 -/
def npDeltaN_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : ℝ :=
  kineticTwice invm z.1.2/(2*z.2.1^2) + z.2.2^2/(2*Q) + U z.1.1 +
    (n : ℝ)/β*Real.log z.2.1 - EN

def npValidDomain (invm : Vec n) (β Q : ℝ) (z : Phase n × (ℝ × ℝ)) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q ∧ 0 < z.2.1

def npField (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : Phase n × (ℝ × ℝ) :=
  let s := z.2.1
  let π := z.2.2
  let delta := npDeltaN_corrected invm U β Q EN z
  ((fun i ↦ invm i*z.1.2 i/s, fun i ↦ -s*gradient U z.1.1 i),
   (s*π/Q, kineticTwice invm z.1.2/s^2-(n : ℝ)/β-delta))

/-- source_id: MD-8.1.2.1-NPtoNH · 印刷p.335 / PDFp.356
[SCOPE] 给定零能量NP解投影为NH解；NP零能量初值传播和非零能量修正列缺口。
[EXTRA] 明确零能量面及s>0；零能量守恒本身未假作普遍结论。
[EXTRA] [EXTRA/范围说明] 保留[EXTRA]全时零能量与s>0；标明这是采用第11条展开式定义的NP版本。原文“沿精确解消失”须理解为正确初始化的零能量解。 -/
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
[SCOPE] 三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。
[EXTRA] [EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。
[EXTRA] [EXTRA/范围说明] 补充[EXTRA]：这里Phase n是示意状态域，未桥接实际扩展NP域Phase n×(ℝ×ℝ)；仅逐点O(h⁴)，非一致估计。实际重加权需ζ_k≠0；有限样本统计误差不能并入单独O(h⁴)。 -/
def fourthOrderRemainder (r : ℝ → ℝ) : Prop :=
  ∃ C ε : ℝ, 0 < C ∧ 0 < ε ∧ ∀ h, |h| < ε → |r h| ≤ C*|h|^4
def correctedFiniteAverage (g ζ : ℕ → ℝ) (N : ℕ) : ℝ :=
  (∑ k ∈ Finset.range (N+1), g k / ζ k) / ((N : ℝ)+1)
def npShadowAnsatz (H H2 : Phase n → ℝ) (Htilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ Htilde h z-H z-h^2*H2 z)
def npDensityAnsatz (ρ : Phase n → ℝ) (ζ ρtilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ ρtilde h z-ρ z*ζ h z)

/-- source_id: MD-8.2-GeneralThermostat · 印刷p.336 / PDFp.357
[SCOPE] 常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。
[EXTRA] J为常矩阵，Jᵀ=-J；z、ξ为实向量，光滑资格在结论中给出。
[EXTRA] [EXTRA/范围说明] 补充[EXTRA]辅助维数k可独立于n；不要把任意J的总函数定义视为已满足Hamiltonian资格或已驻定。 -/
def generalThermostat {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (z : Vec n × Vec k) : Vec n × Vec k := (J *ᵥ gradient H z.1 + Φ z, g z)
def skewMatrix (J : Matrix (Fin n) (Fin n) ℝ) : Prop := J.transpose = -J

/-- source_id: MD-8.2.1-ContinuityProductRule · 印刷p.336–337 / PDFp.357–358
[SCOPE] 实际Fréchet散度的乘积展开；未声称连续性方程解的存在唯一性。
[EXTRA] 覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。
[EXTRA] [EXTRA/范围说明] 保留总散度展开的范围说明；四项分块恒等式和完整连续性方程不得算作本条已形式覆盖。 -/
def continuityRHS {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • F x) z
theorem continuity_productRule {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k)
    (hF : DifferentiableAt ℝ F z) (hρ : DifferentiableAt ℝ ρ z) :
    continuityRHS F ρ z = -(fderiv ℝ ρ z (F z)) - ρ z*textbookDivergence F z := by
  rw [continuityRHS, textbookDivergence_density hρ hF]; ring

/-- source_id: MD-8.2.1-ThermostatCriterion · 印刷p.337 / PDFp.358
[SCOPE] 给定正参数与光滑性后，局部Liouville驻定与所列标量散度条件的等价目标。
[EXTRA] 原文μ_i在指数中是热质量，统一写Q_i；矩阵μ⁻¹的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。
[EXTRA] [EXTRA/范围说明] 补充明确记号字典Q_i=原文标量μ_i，原文矩阵μ⁻¹=diag(Q_i)，矩阵μ=diag(1/Q_i)。若原书 intended μ=diag(μ_i)，则该矩阵记号需[ERRATUM?]人工确认。 -/
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
[SCOPE] 原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。
[EXTRA] Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。
[EXTRA] generalizedFeedback/configurationalFeedback忠实保留原式；corrected将Φ改为−ξG。构型反馈在正号耦合下同样须反号。
[ERRATUM?] 已目视核对原页PDF358–359：例8.2确实印为正号耦合与正反馈，驻定声称有符号疑误，不是转录错误。
[ERRATUM?] [ERRATUM?] 例8.2正号耦合与所印正反馈不能保持所列高斯Gibbs权；额外generalizedFeedback_stationary签名错误，见本次审校反例。 -/
def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
/-- 原文正号组合的驻定声称；原书疑误，保留字面版，不作为有效定理。 -/
theorem generalizedFeedback_stationaryPrinted (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry

/-- 修正版：仅将耦合改为负号，反馈保留原式；原文例8.2另存。 -/
theorem generalizedFeedback_stationary_corrected (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 - z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry

/-- source_id: MD-8.2.1-TemperatureIdentity · 印刷p.338 / PDFp.359
[SCOPE] 紧支撑G的Gibbs积分分部目标及温度比值定义；一般边界衰减条件和比值推导未另证。
[EXTRA] 以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求k_B>0、分母非零。
[EXTRA] [EXTRA/范围说明] 保留紧支撑替代衰减的[EXTRA]；若解释归一平均或推导T，须另外有有限正配分函数、kB>0、分母非零及β⁻¹=kB T。 -/
theorem temperatureIdentity (H : Vec n → ℝ) (G : Vec n → Vec n) (β : ℝ)
    (hH : ContDiff ℝ 2 H) (hG : ContDiff ℝ 1 G) (hcompact : HasCompactSupport G)
    (hβ : 0 < β) :
    (∫ z, textbookDivergence G z * gibbsWeight H β z) =
      β * ∫ z, fderiv ℝ H z (G z) * gibbsWeight H β z := by
  sorry
def phaseTemperature (kB numerator denominator : ℝ) : ℝ := numerator/(kB*denominator)

/-- source_id: MD-8.2.1-Proposition81 · 印刷p.338–339 / PDFp.359–360
[SCOPE] 两个标量热浴的局部Liouville驻定相加命题；不含多维热浴或全局流保测性。
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
[SCOPE] 任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。
[EXTRA] 链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
[EXTRA] [EXTRA] M⁻¹=diag(invm)，∀i,invm_i>0，N_d=n；U∈C²。仅形式化正对角质量、无约束情形。 -/
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
[SCOPE] Arrhenius指数速率公式定义及A≥0时非负性；不含亚稳跃迁率渐近定理或温度单调性。
[EXTRA] A≥0,k_B>0,T>0为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。 -/
def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le

/-- source_id: MD-8.4-AdditiveThermostatSDE · 印刷p.342–343 / PDFp.363–364
[SCOPE] 常噪声积分SDE模板与正对角物理质量的统一恒温器解规格；同一n+k维独立Wiener、分块噪声、两组协方差和漂移质量已绑定。未含一般非对角物理质量、存在唯一性或不变律。
[EXTRA] 加性噪声用独立Wiener路径增量的精确积分方程；漂移可积、路径连续且适应自然历史。完整矩阵噪声给因子B和涨落耗散资格，物理/热浴两组坐标共同独立。
[EXTRA] [EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。
[EXTRA] [EXTRA]漂移采用M⁻¹=diag(invm)的正对角、无约束特例；现有定义尚未把独立的M参数绑定到invm。
[EXTRA] [ERRATUM?]原矩阵平方根噪声须补半正定性及协方差相容条件。fluctuationDissipation规定BBᵀ=(2/β)ΓM，对称M、Γ下还强制ΓM=MΓ，是明确限制后的修正资格。
[EXTRA] 完整两组SDE需要一个统一的n+k维独立Wiener向量、分块噪声因子、对应漂移及两组协方差约束；本条尚无这项组装声明。
[ERRATUM?] 已目视核对原页PDF364：(8.23)的−Φ项确实漏dt；漂移解释补dt。矩阵不交换时原平方根噪声与驻定协方差未必相容。
[ERRATUM?] [ERRATUM?]原书矩阵噪声的对称性不足以保证Gibbs相容。
[ERRATUM?] 现有声明只是未组装的定义组件。 -/
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

/-- 两组噪声共用一个n+k维独立Wiener过程，分块只作用于p和ξ。 -/
def thermostatBlockNoise {k : ℕ}
    (B : Matrix (Fin n) (Fin n) ℝ) (Bhat : Matrix (Fin k) (Fin k) ℝ)
    (j : Fin (n+k)) : Phase n × Vec k :=
  if hj : j.val < n then
    ((0,fun i ↦ B i ⟨j.val,hj⟩),0)
  else ((0,0),fun i ↦ Bhat i ⟨j.val-n,by omega⟩)

/-- 正对角物理质量特例的统一积分解规格；两组协方差与实际漂移使用同一质量。
不含一般非对角物理质量，也不声称由此已证明存在、唯一或不变分布。 -/
def stochasticThermostatSolution {k : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → Vec (n+k)) (X : ℝ → Ω → Phase n × Vec k)
    (x0 : Phase n × Vec k) (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ B : Matrix (Fin n) (Fin n) ℝ)
    (Mhat Γhat Bhat : Matrix (Fin k) (Fin k) ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧
  fluctuationDissipation (Matrix.diagonal (fun i ↦ (invm i)⁻¹)) Γ B β ∧
  fluctuationDissipation Mhat Γhat Bhat β ∧
  additiveSDE P (n+k) W X x0 (stochasticThermostatDrift invm U Φ g Γ Γhat)
    (thermostatBlockNoise B Bhat)

/-- source_id: MD-8.4-OUStationarityPrinted · 印刷p.343–344 / PDFp.364–365
[SCOPE] 协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。
[EXTRA] Printed保留显示抵消式的M=Γ=1,p=0标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。
[ERRATUM?] 已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加ΓM=MΓ或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留β⁻¹，标量β=2,p=0已反例。
[ERRATUM?] [ERRATUM?]保留原所印等式及β=2反例；修正版的BBᵀ=(2/β)ΓM为明确额外资格，在对称情形蕴含交换性。 -/
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
[SCOPE] 一般单热浴提升场的实际加性Wiener积分解规格。
[EXTRA] 真实Wiener、适应性和可积性由additiveSDE给出；σ≠0在Hörmander结论中单列。 -/
def liftedThermostat (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec n × ℝ)
    (x0 : Vec n × ℝ) : Prop :=
  additiveSDE P 1 W X x0 (textbookThermostatDrift F G g γ)
    (fun _ ↦ (0, σ))

/-- source_id: MD-8.4-Proposition82 · 印刷p.344–345 / PDFp.365–366
[SCOPE] 所印及补σ≠0后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。
[EXTRA] Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
[ERRATUM?] 已目视核对原页PDF365–366：证明除以σ，定理需σ≠0；光滑向量场资格明确补足。
[ERRATUM?] [ERRATUM?]σ=0反例；Printed仅作忠实记录，corrected在σ≠0下通过。 -/
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
[SCOPE] 仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。
[EXTRA] Q>0、β>0、γ>0及单独立Wiener；二次系统A对称正定、M=I；高维无约束自由度n。
[EXTRA] [EXTRA/覆盖缺口] invm_i,β,Q,γ均正；不宣称覆盖一般M或已把isNHLSolution特化到正定二次势(8.30)–(8.32)。原印重缩放疑误另列。
[EXTRA] [EXTRA]M⁻¹=diag(invm)，N_d=n；一般非对角M未覆盖。harmonicPotential本身未要求A对称正定，相关物理资格在应用时另加。
[ERRATUM?] 已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p不产生单位质量方程；正确方向相反并须同步变换势。
[ERRATUM?] [ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。 -/
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
[SCOPE] 线性向量场C、D在实际Lie生成空间中的归属；Lean零起始索引对应原文正索引。
[EXTRA] Lean索引k=0对应原文k=1；完整实际线性场、导数括号与End括号约定均摘录；生成子代数在相反括号下相同。 -/
theorem lemma81 (A : Matrix (Fin n) (Fin n) ℝ) (k : ℕ) :
    textbookThermostatC A k ∈ textbookThermostatLieSpan A ∧
    textbookThermostatD A k ∈ textbookThermostatLieSpan A := by
  exact textbookThermostat_C_D_mem_lieSpan A k

/-- source_id: MD-8.4.1-Proposition83 · 印刷p.347–348 / PDFp.368–369
[SCOPE] 指定模态域内的2n个实际线性场值线性无关；不扩大到例外零模态。
[EXTRA] D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。
[ERRATUM?] [ERRATUM?]原证明下标、模态标量式及第二组系数消去需核对；命题与Lean签名正确。 -/
theorem proposition83 (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase n)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    LinearIndependent ℝ (textbookThermostatFamily A z) := by
  exact textbookThermostatFamily_linearIndependent A hA hdist z hz

/-- source_id: MD-8.4.1-Theorem81 · 印刷p.346–348 / PDFp.367–369
[SCOPE] 所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。
[EXTRA] D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
[EXTRA] [EXTRA]θ=k_BT，Q=μ；corrected的Q,θ,γ>0是物理资格，括号结论本身只额外需要σ≠0。σ在此是独立实参数，未声明满足NHL涨落耗散幅度。
[EXTRA] [EXTRA] 当前_corrected为σ独立非零的括号结论；如解释为物理NHL，还须σ²=2γθ/Q。未推到全局遍历性。
[ERRATUM?] 已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。
[ERRATUM?] [ERRATUM?]字面版含σ=0反例；物理上下文的参数资格与字面版分开。原质量重缩放与所引证明的局部排印/推导疑误亦应保留。 -/
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
[SCOPE] 模态域的补集表达及连续热浴路径驱动的模态ODE零模态不变。
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
[SCOPE] 实际加性扩散的Fréchet形式生成元、Lyapunov候选及漂移界性质的定义。
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
[SCOPE] 实际NHL生成元作用于平移二次能量的目标及标量平方不等式；未据此证明遍历。
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
[SCOPE] 所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。
[EXTRA] 修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。
[ERRATUM?] 已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。
[ERRATUM?] {"codes": ["ERRATUM_LYAPUNOV_RATE"], "detail": "lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书α=min(2a,γμ)及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为min(2a,γ)合理且正确：ξ能量的系数是Q/2，故须α≤γ；结合平方不等式及U≤Umax得所写δ。修正版没有额外宣称几何遍历。", "suggested_fix": "原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，α=min(2a,γ)。"} -/
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
[SCOPE] 实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。
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
[SCOPE] 归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。
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
[SCOPE] 任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。
[EXTRA] ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。
[EXTRA] [EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。
[ERRATUM?] {"codes": ["MISSING_MOMENT_INTEGRABILITY", "MISSING_DENSITY_EVOLUTION_SPEC"], "detail": "两积分的变量、2K=kineticTwice invm p及ξ权重与原页一致，preEquilibriumDensity仅要求每个t≥0非负可积归一。该条件不保证两项加权函数可积，因而Lean总化Bochner积分未必代表原文有限分布平均；还没有限定ρ满足原文明说的NHL Fokker–Planck演化。局部稳定性/闭合方程缺口已披露，但不应将上述资格定义称为完整的预平衡密度资格。", "suggested_fix": "增加每个t≥0的Integrable (kineticTwice invm z.1.2*ρ t z)与Integrable (z.2*ρ t z)，并明确正质量。若保留pre-equilibrium命名，应添加FP演化规格；否则声明仅定义任意随时间概率密度的形式积分，并明确演化未覆盖。"} -/
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ∀ t, 0 ≤ t →
    probabilityDensity volume (ρ t) ∧
    Integrable (fun z : Phase n × ℝ ↦ kineticTwice invm z.1.2 * ρ t z) volume ∧
    Integrable (fun z : Phase n × ℝ ↦ z.2 * ρ t z) volume

/-- source_id: MD-8.4.4-VelocityRescaling · 印刷p.355 / PDFp.376
[SCOPE] 实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。
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
[SCOPE] 闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。
[EXTRA] 测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。
[EXTRA] havoid现对tsupport f量化，与HasCompactSupport的闭包支撑一致；未扩大到闭包接触p=0的测试函数。
[EXTRA] 应要求tsupport f避开p=0（或K有统一正下界），当前Lean havoid尚未实现这一条件。
[EXTRA] 二阶项冻结噪声方向，正确表示Itô Hessian；完整随机解、奇异边界与半群不变性未覆盖。
[ERRATUM?] {"codes": ["SUPPORT_NOT_SEPARATED_FROM_ZERO", "SINGULAR_BOUNDARY_CONTROL_MISSING"], "detail": "Itô二阶项确实冻结rescalingNoise Φ θ z，不含噪声导数，正确；C²势、正θ,Z和归一密度亦正确。但havoid量化Function.support f，即f≠0的集合，而HasCompactSupport约束的是其闭包；这不保证闭包与p=0分离。JSON所称“支撑远离K=0”比实际前提强。Admissible不控制Φ′在0附近的增长，因此不能直接用避开奇点的紧支撑分部积分论证覆盖所有给定测试函数。本项FAIL指所宣称的域/边界规格不足，并非已提供该Lean等式的数值反例。", "suggested_fix": "将havoid改为∀z∈tsupport f,z.2≠0，或明确存在ε>0使f的支撑上K≥ε。若希望包含接触p=0的测试函数，应另设边界、噪声正则性及生成元可积性条件并论证；不能静默扩大弱驻定范围。"} -/
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ tsupport f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry

/-- source_id: MD-8.4.5-ThermostatEfficiency · 印刷p.356–357 / PDFp.377–378
[SCOPE] 效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的O(N)含义；外引估计定理未证，经验曲线排除。
[EXTRA] 表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。
[EXTRA] γ>0、θ,Q>0、N>0用于物理解释；一般VR的O(N)给出确切渐近性质定义，没有声称任意Φ族满足它。 -/
def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2

def langevinRateEstimate (γ : ℝ) : ℝ := γ
def langevinEfficiencyEstimate : ℝ := 1
def originalRescalingRateEstimate (γVR : ℝ) : ℝ := γVR
def originalRescalingErrorEstimate (N : ℕ) (γVR t : ℝ) : ℝ := γVR/(N:ℝ)*t
def originalRescalingEfficiencyEstimate (N : ℕ) : ℝ := N
def nhlCriticalEfficiencyEstimate (N : ℕ) : ℝ := 2*N
def rescalingEfficiencyOrder (efficiency : ℕ → ℝ) : Prop :=
  efficiency =O[atTop] (fun N : ℕ ↦ (N : ℝ))

/-- source_id: MD-8.5-SLS · 印刷p.357–358 / PDFp.378–379
[SCOPE] 完整SLS加性SDE积分解规格、噪声方向与确定性子场定义。
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
[SCOPE] 第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。
[EXTRA] 只纠正第一括号；二次括号的整体符号不影响生成空间张成。
[ERRATUM?] 已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。
[ERRATUM?] {"codes": ["ERRATUM_LIE_BRACKET_SIGN"], "detail": "slsBracketPrinted逐字对应原书(p,0,1)，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按VectorField.lieBracket V W=DW·V−DV·W，常向量Yξ给[D,Yξ]=−∂ξD=(−p,0,1)，故_corrected签名正确。反向括号会整体变为(p,0,−1)，不能仅靠约定得到原书(p,0,1)。二次括号的整体符号不影响张成。", "suggested_fix": "保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为−p。"} -/
def slsBathNoise : Phase n × ℝ → Phase n × ℝ := fun _ ↦ ((0,0),1)
theorem slsBracketPrinted (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((z.1.2,0),1) := by
  sorry
theorem slsBracket_corrected (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((-z.1.2,0),1) := by
  sorry

/-- source_id: MD-8.5-SLSHormander · 印刷p.357–358 / PDFp.378–379
[SCOPE] 单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。
[EXTRA] 单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。 -/
theorem slsHormander (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    textbookHormanderAt
      (insert (slsDrift (fun _ ↦ 1) U 1 1 1)
        (Set.range (fun j : Fin (n+1) ↦ fun _ : Phase n × ℝ ↦ slsNoise (fun _ ↦ 1) 2 1 1 1 j))) z := by
  sorry

/-- source_id: MD-8.5-SLSConservation · 印刷p.358 / PDFp.379
[SCOPE] 确定性SLS子场的局部驻定及零散度目标；完整SDE概率不变、独立第一积分未另证。
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
[SCOPE] 原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。
[EXTRA] 原文η约化方程漏μ⁻¹，算法保留Q⁻¹；本条覆盖原页算法及逐坐标场，不声称二阶不变分布误差或精确求积实现。
[EXTRA] 已目视核对原页PDF379：η约化式的ξ导数漏μ⁻¹，新增Printed与恢复1/Q的_corrected；Q>0、正质量与U可微为物理域。分裂映射原有定义未改。
[ERRATUM?] 原书PDF379末段确实印作 ξ̇=−∂ηU，未带μ⁻¹；PDF380的两次kick及逐坐标场则都含μ⁻¹。statement_latex忠实保留了这个不一致。
[ERRATUM?] 已目视核对原页PDF379：η约化式的ξ导数漏μ⁻¹，新增Printed与恢复1/Q的_corrected；Q>0、正质量与U可微为物理域。分裂映射原有定义未改。 -/
def slsBathKick (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2-h*dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
def slsDriftStep (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i+h*z.2*invm i*z.1.2 i,z.1.2),z.2)
def slsLeapfrog (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  slsBathKick invm U Q (h/2) ∘ slsDriftStep invm h ∘ slsBathKick invm U Q (h/2)
def slsCoordinateField (i : Fin n) (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((Pi.single i (z.2*invm i*z.1.2 i),0), -invm i*z.1.2 i*gradient U z.1.1 i/Q)

/-- 原印η约化方程，ξ导数未含μ⁻¹；保留原书字面式。 -/
def slsReducedPrinted (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1)

/-- 修正版：恢复热浴质量因子1/Q，对应(8.36)的η方向导数。 -/
def slsReduced_corrected (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (Q : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1/Q)

/-- source_id: MD-8.5-SLSDoubleWell · 印刷p.359 / PDFp.380
[SCOPE] 一维双阱势定义与非负性。
[EXTRA] 保留试验中的数学势函数；轨迹、直方图和采样优劣是经验观测，另列排除。 -/
def slsDoubleWell (q : ℝ) : ℝ := (q^2-1)^2
theorem slsDoubleWell_nonneg (q : ℝ) : 0 ≤ slsDoubleWell q := sq_nonneg _

/-- source_id: MD-8.6-IsokineticField · 印刷p.361–362 / PDFp.382–383
[SCOPE] 无约束向量场与瞬时动能导数的代数消去；沿解的完整第一积分列缺口。
[EXTRA] 正质量、K>0作为物理有效域；本条实际证明瞬时动能平衡，不将之扩大为全局解存在性。 -/
def isoMultiplier (invm p F : Vec n) : ℝ :=
  (∑ i, invm i*p i*F i)/kineticTwice invm p
def isoField (invm : Vec n) (F : Vec n → Vec n) (z : Phase n) : Phase n :=
  (fun i ↦ invm i*z.2 i, fun i ↦ F z.1 i-isoMultiplier invm z.2 (F z.1)*z.2 i)
theorem isoKinetic_balance (invm p F : Vec n) (hK : kineticTwice invm p ≠ 0) :
    (∑ i, invm i*p i*(F i-isoMultiplier invm p F*p i)) = 0 := by
  simp only [mul_sub, Finset.sum_sub_distrib]
  have hsum : (∑ i, invm i*p i*(isoMultiplier invm p F*p i)) =
      isoMultiplier invm p F*kineticTwice invm p := by
    simp only [kineticTwice, Finset.mul_sum]
    apply Finset.sum_congr rfl; intro i hi; ring
  rw [hsum, isoMultiplier, div_mul_cancel₀ _ hK, sub_self]

/-- source_id: MD-8.6-IsokineticProjector · 印刷p.362 / PDFp.383
[SCOPE] 实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。
[EXTRA] 分母K非零；范围为span(p)的完整线性映射子空间等式列覆盖缺口。 -/
def isoProjection (invm p : Vec n) (v : Vec n) : Vec n :=
  fun i ↦ p i*((∑ j, invm j*p j*v j)/kineticTwice invm p)
theorem isoProjection_self (invm p : Vec n) (hK : kineticTwice invm p ≠ 0) :
    isoProjection invm p p = p := by
  have hs : (∑ j, invm j*p j*p j) = kineticTwice invm p := by
    simp only [kineticTwice]; apply Finset.sum_congr rfl; intro i hi; ring
  ext i; simp [isoProjection, hs, hK]
theorem isoProjection_idempotent (invm p : Vec n) (hK : kineticTwice invm p ≠ 0)
    (v : Vec n) : isoProjection invm p (isoProjection invm p v) = isoProjection invm p v := by
  sorry

/-- source_id: MD-8.6-IsokineticDivergencePrinted · 印刷p.362–363 / PDFp.383–384
[SCOPE] 一般光滑力的原印/符号修正散度目标及权重ansatz；w方程和概率不变另列缺口。
[EXTRA] Φ为正光滑非零函数时称权重；使用K≠0域上的实际散度。
[EXTRA] 已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。
[ERRATUM?] 已目视核对原页PDF383–384：ṗ=F-λp的散度应为-(N_c-1)λ，所印正号与后续w=(N_c-1)U/K也冲突。
[ERRATUM?] PDF383确实印正号div f=(Nc−1)λ，PDF384随后仍用正号的∇w·f等式并给w=(Nc−1)U/K；原文逐字内容应保留。
[ERRATUM?] 已目视核对原页PDF383–384：散度与∇w·f等式须同时改负号，w=(n−1)U/K的正号保留。 -/
def isoAnsatz (w : Phase n → ℝ) (Φ : ℝ → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-w z)*Φ (kineticTwice invm z.2)
theorem isoDivergencePrinted (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = ((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry
theorem isoDivergence_corrected (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = -((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry

/-- source_id: MD-8.6-IsokineticGibbsShell · 印刷p.363 / PDFp.384
[SCOPE] 动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。
[EXTRA] δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。 -/
def isokineticShell (invm : Vec n) (K0 : ℝ) : Set (Phase n) := {z | kineticTwice invm z.2=K0}
def isoShellWeight (U : Vec n → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-((n:ℝ)-1)*U z.1/kineticTwice invm z.2)
theorem isoShell_gibbsFactor (U : Vec n → ℝ) (invm : Vec n) (β : ℝ)
    (hn : 1 < n) (hβ : 0 < β) (z : Phase n)
    (hz : z ∈ isokineticShell invm (((n:ℝ)-1)/β)) :
    isoShellWeight U invm z = Real.exp (-β*U z.1) := by
  have hnR : (1 : ℝ) < (n : ℝ) := by exact_mod_cast hn
  have hn' : (n:ℝ)-1 ≠ 0 := ne_of_gt (sub_pos.mpr hnR)
  change kineticTwice invm z.2 = ((n:ℝ)-1)/β at hz
  unfold isoShellWeight
  rw [hz]
  congr 1
  field_simp [hn', ne_of_gt hβ]
  <;> ring

/-- source_id: MD-8.6.1-StochasticIsokinetic · 印刷p.364–365 / PDFp.385–386
[SCOPE] 实际SIN漂移、正参数Wiener积分解和瞬时约束平衡；约束沿全路径保持未另证。
[EXTRA] 热浴变量ξ₁,ξ₂∈ℝ，各质量、温度、摩擦正；随机噪声只在ξ₂；约束正值排除奇点。 -/
def sinConstraint (Q1 : ℝ) (z : Vec 4) : ℝ := z 1^2+Q1*z 2^2/2
def sinMultiplier (Q1 : ℝ) (F : ℝ → ℝ) (z : Vec 4) : ℝ :=
  (z 1*F (z 0)-Q1*z 2^2*z 3/2)/sinConstraint Q1 z
def sinDrift (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinMultiplier Q1 F z
  ![z 1, F (z 0)-lam*z 1, -lam*z 2-z 3*z 2, (Q1*z 2^2-θ)/Q2-γ*z 3]
def isSINSolution (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  0 < Q1 ∧ 0 < Q2 ∧ 0 < θ ∧ 0 < γ ∧ sinConstraint Q1 x0=θ ∧
  additiveSDE P 1 W X x0 (sinDrift Q1 Q2 θ γ F)
    (fun _ ↦ ![0,0,0,Real.sqrt (2*γ*θ/Q2)])
theorem sinConstraint_balance (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinDrift Q1 Q2 θ γ F z) 1+Q1*z 2*(sinDrift Q1 Q2 θ γ F z) 2=0 := by
  have hden : 2*z 1^2+Q1*z 2^2 ≠ 0 := by
    intro h
    apply hK
    dsimp [sinConstraint]
    linarith
  simp [sinDrift, sinMultiplier, sinConstraint]
  field_simp [hden]
  <;> ring

/-- source_id: MD-8.6.1-SINWeightPrinted · 印刷p.365 / PDFp.386
[SCOPE] 原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。
[EXTRA] 仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
[ERRATUM?] 已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。
[ERRATUM?] PDF386确实印w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2)，未含μ₂；statement_latex忠实，不能静默把原印式改成修正式。 -/
def sinWeightPrinted (U : ℝ → ℝ) (Q1 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+z 3^2/2)/sinConstraint Q1 z)
def sinWeight_corrected (U : ℝ → ℝ) (Q1 Q2 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+Q2*z 3^2/2)/sinConstraint Q1 z)
theorem sinWeight_stationary_corrected (U : ℝ → ℝ) (Q1 Q2 θ : ℝ)
    (hU : ContDiff ℝ 2 U) (hQ1 : 0 < Q1) (hQ2 : 0 < Q2) (hθ : 0 < θ)
    (z : Vec 4) (hz : sinConstraint Q1 z=θ) :
    textbookDivergence
      (fun x ↦ sinWeight_corrected U Q1 Q2 x • sinDrift Q1 Q2 θ 0 (fun q ↦ -deriv U q) x) z = 0 := by
  sorry

/-- source_id: MD-8.6.2-SINHarmonic · 印刷p.366 / PDFp.387
[SCOPE] 谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。
[EXTRA] θ=k_BT>0、γ>0、标量Wiener由isSINSolution给全；零ξ₁面不变和两个半柱的轨道符号保持需要ODE唯一性，列覆盖缺口。 -/
def sinHarmonicF (θ γ : ℝ) : Vec 4 → Vec 4 := sinDrift 1 1 θ γ (fun q ↦ -q)
def sinHarmonicG (θ γ : ℝ) : Vec 4 := ![0,0,0,Real.sqrt (2*γ*θ)]
def isSINHarmonicSolution (θ γ : ℝ) (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  isSINSolution 1 1 θ γ (fun q ↦ -q) P W X x0
def sinExceptional (θ : ℝ) : Set (Vec 4) :=
  {z | z 0=0 ∧ z 1=0 ∧ z 2^2=2*θ}
def sinHalfCylinder (θ : ℝ) (positive : Bool) : Set (Vec 4) :=
  {z | sinConstraint 1 z=θ ∧ (if positive then 0 < z 2 else z 2 < 0)}
theorem sinHalfCylinder_disjoint (θ : ℝ) :
    Disjoint (sinHalfCylinder θ true) (sinHalfCylinder θ false) := by
  apply Set.disjoint_left.mpr
  intro z hpos hneg
  exact (not_lt_of_ge (le_of_lt hpos.2)) hneg.2

/-- source_id: MD-8.6.2-SINProjectedBracketsPrinted · 印刷p.367 / PDFp.388
[SCOPE] 原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。
[EXTRA] 总化分式只在θ>0的约束面D=2θ>0使用；实际交换子先在四维完整计算再投影。
[EXTRA] 本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
[EXTRA] 已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
[ERRATUM?] 已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。
[ERRATUM?] PDF388逐式核对：(8.48)为u0；(8.49)ξ₁分量前确无共同σ；(8.50)印u1却重复u0展开式；(8.51)印u2却是首交换子的投影。(8.52)的p分量确为−σa而非−σξ₁²a，故Lean忠实保留了原印式，不应替书改系数。
[ERRATUM?] 已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。 -/
def bracket4 (f g : Vec 4 → Vec 4) (z : Vec 4) : Vec 4 :=
  fderiv ℝ g z (f z)-fderiv ℝ f z (g z)
def sinBracket (θ γ : ℝ) : ℕ → Vec 4 → Vec 4
  | 0 => sinHarmonicF θ γ
  | 1 => bracket4 (sinHarmonicF θ γ) (fun _ ↦ sinHarmonicG θ γ)
  | k+2 => bracket4 (sinHarmonicF θ γ) (sinBracket θ γ (k+1))
def projectFirstThree (z : Vec 4) : Vec 3 := ![z 0,z 1,z 2]
def sinD (z : Vec 4) : ℝ := 2*z 1^2+z 2^2
def sinU0Printed (z : Vec 4) : Vec 3 :=
  ![z 1,z 2^2*(-z 0+z 1*z 3)/sinD z,-2*z 2*z 1*(-z 0+z 1*z 3)/sinD z]
def sinU1Printed (z : Vec 4) : Vec 3 := sinU0Printed z
def sinU2Printed (σ : ℝ) (z : Vec 4) : Vec 3 :=
  ![0,-σ*z 2^2*z 1/sinD z,2*σ*z 2*z 1^2/sinD z]
def sinU1DerivativePrinted (σ : ℝ) (z : Vec 4) : Vec 3 :=
  let d := fderiv ℝ (sinMultiplier 1 (fun q ↦ -q)) z (Pi.single 3 1)
  ![0,σ*z 1*d,z 2*(1+d)]
def sinProjected_corrected (θ γ : ℝ) (j : Fin 4) (z : Vec 4) : Vec 3 :=
  projectFirstThree (sinBracket θ γ j z)
def sinU2LongPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  let a := (2*γ*z 1^3+γ*z 2^2*z 1-z 2^2*z 0)/(sinD z)^2
  ![σ*z 2^2*z 1/sinD z,-σ*a,2*σ*z 2*z 1*a]
theorem sinU2Long_at_p0 (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) :
    sinU2LongPrinted σ γ z = ![0,σ*z 2^2*z 0/(sinD z)^2,0] := by
  ext i; fin_cases i <;> simp [sinU2LongPrinted,hp] <;> ring

/-- source_id: MD-8.6.2-SINThirdBracketPrinted · 印刷p.368 / PDFp.389
[SCOPE] 原印三重交换子候选及p=0内部代数核对；真实三重交换子等式列覆盖缺口。
[EXTRA] ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
[EXTRA] _corrected只修正(8.54)在p=0的内部代数特化，不能据此声称Printed长式等于真实三重括号。
[ERRATUM?] 已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。
[ERRATUM?] PDF389的(8.54)q分量分母为D²，(8.55)的13项多项式逐项与sinEtaPrinted一致；(8.56)原印q分量为−2σq，确无ξ₁²分母。 -/
def sinEtaPrinted (γ : ℝ) (z : Vec 4) : ℝ :=
  4*z 1^5*γ^2-8*z 1^5*z 2^2-4*z 2^2*z 1^3+4*z 1^3*γ^2*z 2^2-4*z 1^3*z 2^4-
  2*γ*z 2^2*z 1^2*z 0+4*z 1^2*z 0*z 3*z 2^2-4*z 2^2*z 0^2*z 1-
  2*z 2^4*z 1+z 1*γ^2*z 2^4-z 0*γ*z 2^4+z 2^4*z 3*z 0
def sinU3Printed (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![σ*(2*γ*z 1^3-4*z 1^3*z 3+4*z 1^2*z 0+z 2^2*z 1*z 3+γ*z 2^2*z 1-2*z 2^2*z 0)/(sinD z)^2,
    -σ*z 2^2*sinEtaPrinted γ z/(sinD z)^3,2*σ*z 2*z 1*sinEtaPrinted γ z/(sinD z)^3]
def sinU3ZeroPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0,-σ*z 0*(-γ+z 3),0]
def sinU3Zero_corrected (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0/z 2^2,-σ*z 0*(-γ+z 3),0]
theorem sinU3Zero_specialize (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) (hξ : z 2 ≠ 0) :
    sinU3Printed σ γ z = sinU3Zero_corrected σ γ z := by
  ext i; fin_cases i <;> simp [sinU3Printed,sinU3Zero_corrected,sinEtaPrinted,sinD,hp]
    <;> field_simp [hξ] <;> ring

/-- source_id: MD-8.6.2-SINBracketRank · 印刷p.366–368 / PDFp.387–389
[SCOPE] 例外直线外的有限括号张成目标；非完整遍历性定理。
[EXTRA] θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
[ERRATUM?] PDF387–389列出的五个场和M0吻合。原页先说明运动限制在ξ₁>0或ξ₁<0半空间；statement_latex应显式带上这一域，避免把“除M0外”误读为包含ξ₁=0的整个圆柱。 -/
theorem sinBracket_tangentSpan (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (z : Vec 4) (hz : sinConstraint 1 z=θ) (hξ : z 2 ≠ 0)
    (hout : z ∉ sinExceptional θ) :
    Submodule.span ℝ ({sinHarmonicG θ γ} ∪
      Set.range (fun j : Fin 4 ↦ sinBracket θ γ j z)) =
      LinearMap.ker (fderiv ℝ (sinConstraint 1) z).toLinearMap := by
  sorry

/-- source_id: MD-8.6.2-SINLyapunov · 印刷p.368–369 / PDFp.389–390
[SCOPE] 局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。
[EXTRA] 仅生成元作用和约束界；原文有符号ξ₂的Kξ₂上界须区分尾部方向，严谨负漂移应使用K|ξ₂|并要求γ>0。
[EXTRA] 紧性、正密度、小集与Markov半群遍历定理均列覆盖缺口。
[EXTRA] 已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。
[ERRATUM?] PDF390生成元计算与statement_latex吻合；但原书随后给−γξ₂²+Kξ₂+σ²/2作为全局上界，未对ξ₂正负分情况。原文须保留并注明此上界疑误。仅在ξ₂方向的负漂移也不能单独推出非紧q方向的遍历性。
[ERRATUM?] 原文从局部负漂移到遍历性的论证需要额外全局条件；现有Lean没有此结论。
[ERRATUM?] 已目视核对原页PDF390：有符号Cξ₂尾界不能统一控制两侧；工作修正版为−γξ₂²+θ|ξ₂|+γθ。它依赖尚未证明的局部生成元恒等式，不代表遍历性证明。 -/
def sinGenerator (θ γ : ℝ) (F : ℝ → ℝ) (f : Vec 4 → ℝ) (z : Vec 4) : ℝ :=
  additiveGenerator (sinDrift 1 1 θ γ F) (sinHarmonicG θ γ) f z
theorem sinGenerator_lyapunov (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hK : sinConstraint 1 z ≠ 0) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z =
      (z 2^2-θ)*z 3-γ*z 3^2+γ*θ := by
  sorry
theorem sinConstraint_bathBound (θ : ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    z 2^2 ≤ 2*θ := by
  dsimp [sinConstraint] at hz
  nlinarith [sq_nonneg (z 1)]

/-- 原页带有符号的线性尾项，只保留其表达式。 -/
def sinLyapunovTailPrinted (θ γ C : ℝ) (z : Vec 4) : ℝ :=
  -γ*z 3^2+C*z 3+γ*θ

/-- 修正版：对两侧尾部均适用的绝对值界。 -/
theorem sinLyapunovTail_corrected (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z ≤
      -γ*z 3^2+θ*|z 3|+γ*θ := by
  have hk : sinConstraint 1 z ≠ 0 := by rw [hz]; exact ne_of_gt hθ
  rw [sinGenerator_lyapunov θ γ hθ hγ F z hk]
  have hb := sinConstraint_bathBound θ z hz
  rcases le_total 0 (z 3) with h | h
  · rw [abs_of_nonneg h]
    nlinarith [mul_nonneg (sub_nonneg.mpr hb) h]
  · rw [abs_of_nonpos h]
    nlinarith [mul_nonneg (sq_nonneg (z 2)) (neg_nonneg.mpr h)]

/-- source_id: MD-8.6.3-SINForceSplitting · 印刷p.370–371 / PDFp.391–392
[SCOPE] 五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。
[EXTRA] Q₁,Q₂,θ>0且Λ=θ为物理域，总化场保留作辅助；本条含完整漂移和分解及力子场瞬时约束平衡，其他子场的流存在/保约束列缺口。 -/
def sinKField (z : Vec 4) : Vec 4 := ![z 1,0,0,0]
def sinForceField (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,-z 1*z 2*F/sinConstraint Q1 z,0]
def sinNField (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,(Q1*z 2^2-θ)/Q2]
def sinOField (γ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,-γ*z 3]
theorem sinSplit_fields (Q1 Q2 θ γ : ℝ) (FF FS : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    sinDrift Q1 Q2 θ γ (fun q ↦ FF q+FS q) z =
      sinKField z+sinForceField Q1 (FF (z 0)) z+
      sinForceField Q1 (FS (z 0)) z+sinNField Q1 Q2 θ z+sinOField γ z := by
  ext i; fin_cases i <;> simp [sinDrift,sinMultiplier,sinKField,sinForceField,sinNField,sinOField]
    <;> field_simp <;> ring
theorem sinForce_constraintBalance (Q1 F : ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinForceField Q1 F z) 1+Q1*z 2*(sinForceField Q1 F z) 2=0 := by
  change 2*z 1*(F-z 1^2*F/sinConstraint Q1 z)+
    Q1*z 2*(-z 1*z 2*F/sinConstraint Q1 z)=0
  generalize hd : sinConstraint Q1 z = lam at *
  field_simp [hK]
  rw [← hd]
  dsimp [sinConstraint]
  ring

/-- source_id: MD-8.6.3-SINRAlgorithm · 印刷p.371 / PDFp.392
[SCOPE] 原印算法的阶段顺序与步长；不声称构造了各非线性子流。
[EXTRA] 算法有效域h>0、r≥2；一组中多个场表示同一次合并传播，并非擅自换为两个非交换流。每次OU用独立标准正态新噪声。
[EXTRA] 这里只记录精确阶段表，具体随机核实现、保约束及全局误差/阶数列覆盖缺口。 -/
inductive SINStage where
  | kinetic | fast | slow | nose | ou
  deriving DecidableEq
def sinRStages (h : ℝ) (r : ℕ) : List (List (SINStage × ℝ)) :=
  let a := h/(r:ℝ)
  [[(.nose,h/2)],[(.fast,a/2),(.slow,h/2)],[(.kinetic,a)],[(.ou,a)],[(.fast,a/2)]] ++
  List.flatten (List.replicate (r-2)
    [[(.fast,a/2)],[(.kinetic,a/2)],[(.ou,a)],[(.kinetic,a/2)],[(.fast,a/2)]]) ++
  [[(.fast,a/2)],[(.ou,a)],[(.kinetic,a)],[(.fast,a/2),(.slow,h/2)],[(.nose,h/2)]]

/-- source_id: MD-8.6.3-SINNoseSubsplitting · 印刷p.372 / PDFp.393
[SCOPE] Nosé场的两项分解恒等式。
[EXTRA] 正质量、温度及Λ>0作为物理资格；高阶Yoshida/Suzuki组合的系数和误差阶未在原页给出，列覆盖缺口。 -/
def sinN1Field (Q1 : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,0]
def sinN2Field (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,(Q1*z 2^2-θ)/Q2]
theorem sinN_split (Q1 Q2 θ : ℝ) (z : Vec 4) :
    sinNField Q1 Q2 θ z=sinN1Field Q1 z+sinN2Field Q1 Q2 θ z := by
  ext i; fin_cases i <;> simp [sinNField,sinN1Field,sinN2Field]

/-- source_id: MD-8.6.3-SINForceExactPrinted · 印刷p.372 / PDFp.393
[SCOPE] 原印子场、显式候选与校正ODE的局部导数目标。
[EXTRA] 质量按本节假设取1；Q₁、Λ正，排除ṡ=0；F=0用b=0的解析延拓，避免总化除法假装极限。
[EXTRA] 只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。
[ERRATUM?] 已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。
[ERRATUM?] [ERRATUM?] 保留Printed，给ξ₁负号版添加[ERRATUM?]；保留m=1的[EXTRA]，不要把工作修正版回填为原文。 -/
def sinForceAux (a b t : ℝ) : ℝ :=
  if b=0 then t+a*t^2/2 else Real.sinh (t*Real.sqrt b)/Real.sqrt b+a/b*(Real.cosh (t*Real.sqrt b)-1)
def sinForceFlow (Q1 F t : ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinConstraint Q1 z
  let s := sinForceAux (F*z 1/lam) (F^2/lam)
  ![z 0,(z 1+F*s t)/deriv s t,z 2/deriv s t,z 3]
def sinForceODEPrinted (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,z 1*z 2*F/sinConstraint Q1 z,0]
def sinForceODE_corrected (Q1 F : ℝ) : Vec 4 → Vec 4 := sinForceField Q1 F
theorem sinForceFlow_solution_corrected (Q1 F : ℝ) (z : Vec 4)
    (hQ1 : 0 < Q1) (hK : 0 < sinConstraint Q1 z) (t : ℝ)
    (hden : deriv (sinForceAux (F*z 1/sinConstraint Q1 z) (F^2/sinConstraint Q1 z)) t ≠ 0) :
    HasDerivAt (fun s ↦ sinForceFlow Q1 F s z)
      (sinForceField Q1 F (sinForceFlow Q1 F t z)) t := by
  sorry

/-- source_id: MD-8.6.4-SINThreeLevelPotential · 印刷p.373 / PDFp.394
[SCOPE] 三层势与步长嵌套的定义。
[EXTRA] 仅保留势的三项分解和整数时标嵌套；SPME实现、99fs稳定性及水分子径向分布等属于数值观察，逐项排除。 -/
def threeLevelPotential (bond short long : Vec n → ℝ) : Vec n → ℝ := bond+short+long
def nestedTimeSteps (inner middle outer : ℝ) : Prop :=
  0 < inner ∧ ∃ r s : ℕ, 0 < r ∧ 0 < s ∧ middle=r*inner ∧ outer=s*middle

/-- source_id: MD-8.7-GeneralizedLangevin · 印刷p.374 / PDFp.395
[SCOPE] 连续矩阵记忆核下的卷积及GLE积分解类定义。
[EXTRA] B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。
[EXTRA] 本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。
[EXTRA] [EXTRA] generalizedLangevin仅为给定B的方程规格；未在此谓词约束有色性、非Gaussian性或涨落耗散关系。
[EXTRA] 已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
[EXTRA] [EXTRA] generalizedLangevin仅为给定加性驱动B的积分方程，噪声分布、有色性及FD未在本定义内强制，由另条规格给出。
[ERRATUM?] [ERRATUM?] 保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。
[ERRATUM?] 已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。 -/
def memoryDrag (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (p : ℝ → Vec n) (t : ℝ) : Vec n :=
  -∫ s in (0 : ℝ)..t, Γ (t-s) *ᵥ p s
def generalizedLangevin (P : Measure Ω) (invm : Vec n) (U : Vec n → ℝ)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (B : ℝ → Ω → Vec n)
    (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  IsProbabilityMeasure P ∧ (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧ ContinuousOn Γ (Ici 0) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ B t sample) (Ici 0)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ B s sample) inferInstance] (X t)) ∧
  ∀ t, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable
      (fun s ↦ -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s) volume 0 t) ∧
    ∀ᵐ sample ∂P,
      (X t sample).1=x0.1+∫ s in (0 : ℝ)..t, (fun i ↦ invm i*(X s sample).2 i) ∧
      (X t sample).2=x0.2+(∫ s in (0 : ℝ)..t,
        -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s)+B t sample-B 0 sample

/-- source_id: MD-8.7-GLEFluctuationDissipationPrinted · 印刷p.374 / PDFp.395
[SCOPE] Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。
[EXTRA] 修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
[ERRATUM?] 已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。
[ERRATUM?] [ERRATUM?] 保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。 -/
def randomForceQualification (P : Measure Ω) (R : ℝ → Ω → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ ∀ t, 0 ≤ t → ∀ i, MemLp (fun sample ↦ R t sample i) 2 P ∧
    (∫ sample, R t sample i ∂P)=0
def gleFDPrinted (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=if i=j then θ*Γ s i j else 0
def gleFD_corrected (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=θ*Γ s i j
def scalarMemoryMatrix (γ : ℝ → ℝ) (t : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal (fun _ ↦ γ t)

/-- source_id: MD-8.7-PronyKernel · 印刷p.375 / PDFp.396
[SCOPE] 正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。
[EXTRA] 正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。 -/
def pronyKernel {K : ℕ} (c τ : Fin K → ℝ) (t : ℝ) : ℝ :=
  ∑ k, c k/τ k*Real.exp (-t/τ k)
def pronyQualification {K : ℕ} (c τ : Fin K → ℝ) : Prop :=
  ∀ k, 0 < c k ∧ 0 < τ k
theorem pronyKernel_nonneg {K : ℕ} (c τ : Fin K → ℝ)
    (h : pronyQualification c τ) (t : ℝ) : 0 ≤ pronyKernel c τ t := by
  apply Finset.sum_nonneg
  intro k hk
  exact mul_nonneg (le_of_lt (div_pos (h k).1 (h k).2)) (le_of_lt (Real.exp_pos _))

/-- source_id: MD-8.7.1-PronyMemoryODE · 印刷p.375 / PDFp.396
[SCOPE] 卷积辅助定义、微分关系和有限和等式；与扩展随机解的完整等价列缺口。
[EXTRA] p连续、τ正保证有限区间卷积合法；仅消去有限Prony历史，未声称无限Prony极限或解分布等价。 -/
def pronyMemory (c τ : ℝ) (p : ℝ → ℝ) (t : ℝ) : ℝ :=
  -∫ s in (0 : ℝ)..t, c/τ*Real.exp (-(t-s)/τ)*p s
theorem pronyMemory_derivative (c τ : ℝ) (hτ : 0 < τ)
    (p : ℝ → ℝ) (hp : Continuous p) (t : ℝ) :
    HasDerivAt (pronyMemory c τ p) (-pronyMemory c τ p t/τ-c/τ*p t) t := by
  sorry
def pronyMomentumDrift {K : ℕ} (F : Vec n) (η : Fin K → Vec n) (R : Vec n) : Vec n :=
  F+(∑ k, η k)+R
theorem pronyMemory_sum {K : ℕ} (c τ : Fin K → ℝ) (p : ℝ → Vec n)
    (hq : pronyQualification c τ) (hp : Continuous p) (t : ℝ) :
    (∑ k, fun i ↦ pronyMemory (c k) (τ k) (fun s ↦ p s i) t) =
      memoryDrag (scalarMemoryMatrix (n:=n) (pronyKernel c τ)) p t := by
  sorry

/-- source_id: MD-8.7.1-PronyOUStationarity · 印刷p.376 / PDFp.397
[SCOPE] 单个Prony OU的完整资格及平稳均值/协方差目标、总随机力定义。
[EXTRA] 为(8.66)补平稳Gaussian初态及其与未来整条W独立；确定初态OU一般没有所印不依赖t的协方差。多分量实际实现使用独立W坐标。
[EXTRA] 已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。
[ERRATUM?] [ERRATUM?] 保留原印相关式并加[ERRATUM?]，明确它在平稳初态下成立；保留已写入Lean的Gaussian初态及独立性。
[ERRATUM?] [ERRATUM?] 原页(8.66)省略平稳初态；Lean补入的初始Gaussian律及其与W独立是必要资格。
[ERRATUM?] 已目视核对原页PDF397：(8.66)未声明平稳初态；保留原句，_corrected明确引用stationaryPronyOU的Gaussian初态和整条W独立性。总随机力只定义有限和，未证跨模式独立或总协方差。 -/
def stationaryPronyOU (P : Measure Ω) (W : ℝ → Ω → Vec 1) (R : ℝ → Ω → ℝ)
    (c τ θ : ℝ) : Prop :=
  independentWiener P 1 W ∧ 0 < c ∧ 0 < τ ∧ 0 < θ ∧
  HasLaw (R 0) (gaussianReal 0 (Real.toNNReal (θ*c/τ))) P ∧
  IndepFun (R 0) (fun sample t ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ R t sample) (Ici 0)) ∧
  (∀ t, 0 ≤ t → MemLp (R t) 2 P) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    R t sample=R 0 sample+(∫ s in (0 : ℝ)..t, -R s sample/τ)+
      Real.sqrt (2*θ*c)/τ*(W t sample 0-W 0 sample 0)
theorem pronyOU_covariance (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := by
  sorry
def totalPronyRandomForce {K : ℕ} (R : Fin K → ℝ → Ω → ℝ) (t : ℝ) (sample : Ω) : ℝ :=
  ∑ k, R k t sample

/-- 修正版显式使用已定义的平稳Gaussian初态及与W独立资格；原印未写该前提。 -/
theorem pronyOU_covariance_corrected (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := pronyOU_covariance P W R c τ θ hR t s ht hs

/-- source_id: MD-8.7.1-CombinedPronyVariable · 印刷p.376 / PDFp.397
[SCOPE] 有限维扩展SDE完整积分规格及σ=η+R的漂移恒等式。
[EXTRA] 额外变量取实数；正质量、c、τ、温度和独立标准向量Wiener写入解规格。e仅把有限噪声坐标编号为(k,i)。
[EXTRA] 本条实际是加性扩展SDE和漂移合并恒等式；Markov半群构造、解存在唯一及与非Markov GLE分布等价列缺口。 -/
abbrev GLEState (n K : ℕ) := Phase n × (Fin K → Vec n)
def gleDrift {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c τ : Fin K → ℝ)
    (z : GLEState n K) : GLEState n K :=
  ((fun i ↦ invm i*z.1.2 i,-gradient U z.1.1+∑ k, z.2 k),
   fun k i ↦ -z.2 k i/τ k-c k/τ k*z.1.2 i)
def gleNoise {K : ℕ} (c τ : Fin K → ℝ) (θ : ℝ)
    (e : Fin (K*n) ≃ Fin K × Fin n) (j : Fin (K*n)) : GLEState n K :=
  ((0,0),fun k i ↦ if (k,i)=e j then Real.sqrt (2*θ*c k)/τ k else 0)
def isExtendedGLESolution {K : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (c τ : Fin K → ℝ) (θ : ℝ) (e : Fin (K*n) ≃ Fin K × Fin n)
    (P : Measure Ω) (W : ℝ → Ω → Vec (K*n))
    (X : ℝ → Ω → GLEState n K) (x0 : GLEState n K) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ pronyQualification c τ ∧ ContDiff ℝ 1 U ∧
  additiveSDE P (K*n) W X x0 (gleDrift invm U c τ) (gleNoise c τ θ e)
theorem combinedProny_drift (η R c τ p : ℝ) :
    (-η/τ-c/τ*p)+(-R/τ)=-(η+R)/τ-c/τ*p := by ring

/-- source_id: MD-8.7.1-PronyLangevinLimit · 印刷p.376–377 / PDFp.397–398
[SCOPE] 有效摩擦定义、合并漂移和有限Gaussian求和分布，不是小记忆时间极限定理。
[EXTRA] 仅形式极限系数与真实有限个独立Gaussian线性组合；τ→0过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。 -/
def pronyEffectiveFriction {K : ℕ} (c : Fin K → ℝ) : ℝ := ∑ k, c k
theorem pronyLimit_drift {K : ℕ} (c : Fin K → ℝ) (F p : ℝ) :
    F-∑ k, c k*p=F-pronyEffectiveFriction c*p := by
  simp [pronyEffectiveFriction,Finset.sum_mul]
theorem independentGaussian_varianceSum {K : ℕ} (P : Measure Ω)
    (R : Ω → (Fin K → ℝ)) (c : Fin K → ℝ) (hc : ∀ k, 0 ≤ c k)
    (hR : HasLaw R (Measure.pi (fun _ : Fin K ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ ∑ k, Real.sqrt (c k)*R sample k)
      (gaussianReal 0 (Real.toNNReal (pronyEffectiveFriction c))) P := by
  sorry

/-- source_id: MD-8.7.1-GeneralizedLangevinIntegrator · 印刷p.377 / PDFp.398
[SCOPE] 四个实际更新及其全部噪声资格。
[EXTRA] h>0，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。
[EXTRA] 此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。 -/
def gleIntegrator {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c decay noise : Fin K → ℝ)
    (θ h : ℝ) (Z : Fin K → Vec n) (z : GLEState n K) : GLEState n K :=
  let ph := z.1.2+(h/2) • (-gradient U z.1.1+∑ k, z.2 k)
  let qn := z.1.1+(h • fun i ↦ invm i*ph i)
  let sn := fun k i ↦ decay k*z.2 k i-(1-decay k)*c k*ph i+
    noise k*Real.sqrt (2*θ*c k)*Z k i
  ((qn,ph+(h/2) • (-gradient U qn+∑ k, sn k)),sn)
def gleNormalSequence {K : ℕ} (P : Measure Ω) (Z : ℕ → Ω → Fin K → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun Z P ∧ ∀ j,
    HasLaw (Z j) (Measure.pi (fun _ : Fin K ↦ Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) P

/-- source_id: MD-8.7.1-GLEConsistentCoefficients · 印刷p.377 / PDFp.398
[SCOPE] 两项一致性渐近和所选单步系数的τ→0极限。
[EXTRA] h从正侧趋0、τ固定正；小记忆极限另固定h>0，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。 -/
def gleDecay (τ h : ℝ) : ℝ := Real.exp (-h/τ)
def gleNoiseCoefficient (τ h : ℝ) : ℝ := Real.sqrt ((1-gleDecay τ h)^2/h)
def gleCoefficientConsistency (τ : ℝ) (decay noise : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ decay h-(1-h/τ)) (fun h ↦ h^2) ∧
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ noise h-Real.sqrt h/τ) (fun h ↦ h)
theorem gleCoefficients_consistent (τ : ℝ) (hτ : 0 < τ) :
    gleCoefficientConsistency τ (gleDecay τ) (gleNoiseCoefficient τ) := by
  sorry
theorem gleCoefficient_smallMemory (h : ℝ) (hh : 0 < h) :
    Tendsto (fun τ ↦ (gleDecay τ h,gleNoiseCoefficient τ h))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 ((0 : ℝ),1/Real.sqrt h)) := by
  sorry

/-- source_id: MD-8.8-NPTThermodynamics · 印刷p.378 / PDFp.399
[SCOPE] 压力定义和给定非零温度/循环关系后的代数推论。
[EXTRA] E的熵、体积、粒子数参数固定顺序明示；Maxwell循环作为热力学可逆导数资格，并非从任意E无条件推出。 -/
def thermodynamicPressure (E : ℝ → ℝ → ℝ → ℝ) (S V N : ℝ) : ℝ :=
  -deriv (fun v ↦ E S v N) V
def maxwellCycle (dSdE dEdV dVdS : ℝ) : Prop := dSdE*dEdV*dVdS = -1
theorem maxwellPressureRelation (T P dVdS : ℝ) (hT : T ≠ 0)
    (hcycle : maxwellCycle (1/T) (-P) dVdS) : dVdS⁻¹=P/T := by
  have hprod : P*dVdS=T := by
    dsimp [maxwellCycle] at hcycle
    field_simp [hT] at hcycle
    linarith
  have hz : dVdS ≠ 0 := by
    intro hz; rw [hz,mul_zero] at hprod; exact hT hprod.symm
  apply (eq_div_iff hT).2
  rw [← hprod]
  field_simp [hz]

/-- source_id: MD-8.8-NPTBathTaylor · 印刷p.378 / PDFp.399
[SCOPE] 线性熵近似与明确的一阶小o余项目标。
[EXTRA] 固定粒子数参数，只对E,V的小扰动；显式Fréchet可微及热力学导数识别，不把原文≈当作精确等式。 -/
def nptBathLinear (S0 T P E V : ℝ) : ℝ := S0-(E+P*V)/T
theorem nptEntropy_firstOrder (S : ℝ × ℝ → ℝ) (E0 V0 T P : ℝ) (hT : 0 < T)
    (hS : DifferentiableAt ℝ S (E0,V0))
    (hderiv : ∀ v : ℝ × ℝ, fderiv ℝ S (E0,V0) v=v.1/T+(P/T)*v.2) :
    Asymptotics.IsLittleO (𝓝 (0 : ℝ × ℝ))
      (fun z ↦ S (E0-z.1,V0-z.2)-nptBathLinear (S (E0,V0)) T P z.1 z.2)
      (fun z : ℝ × ℝ ↦ ‖z‖) := by
  sorry

/-- source_id: MD-8.8-NPTDensity · 印刷p.378–379 / PDFp.399–400
[SCOPE] 正体积盒内NPT权重和有资格时的概率归一化。
[EXTRA] 三维N粒子时n=3N；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。 -/
def volumeScale (V : ℝ) : ℝ := Real.rpow V (1/3 : ℝ)
def nptBox (n : ℕ) : Set (Phase n × ℝ) :=
  {z | 0 < z.2 ∧ ∀ i, |z.1.1 i| ≤ volumeScale z.2/2}
def nptWeight (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β*(H z+P*z.2))
def nptDensity (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∫ y, nptWeight H β P y ∂volume.restrict (nptBox n))⁻¹*nptWeight H β P z
theorem nptDensity_normalizes (H : Phase n × ℝ → ℝ) (β P : ℝ) (hβ : 0 < β)
    (hi : Integrable (nptWeight H β P) (volume.restrict (nptBox n)))
    (hZ : 0 < ∫ z, nptWeight H β P z ∂volume.restrict (nptBox n)) :
    probabilityDensity (volume.restrict (nptBox n)) (nptDensity H β P) := by
  refine ⟨fun z ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ))
    (le_of_lt (Real.exp_pos _)),hi.const_mul _,?_⟩
  simp only [nptDensity,integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)

/-- source_id: MD-8.8-AndersenCoordinates · 印刷p.379–380 / PDFp.400–401
[SCOPE] 位置、速度、共轭动量的实际变换式与两个局部等式目标。
[EXTRA] V>0用于实分数幂的导数与乘法；质量物理解读取正，等式本身是坐标变换，不包含随体积变化的全局正则流或规范测度。 -/
def andersenPosition (V : ℝ) (qbar : Vec n) : Vec n := volumeScale V • qbar
def andersenVelocity (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  ((1/3 : ℝ)*Real.rpow V (-2/3 : ℝ)*Vdot) • qbar+volumeScale V • vbar
def andersenMomentum (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : Vec n :=
  fun i ↦ m i*((1/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i+
    Real.rpow V (2/3 : ℝ)*vbar i)
theorem andersenPosition_derivative (V : ℝ → ℝ) (qbar : ℝ → Vec n)
    (t Vdot : ℝ) (vbar : Vec n) (hV : 0 < V t)
    (hdV : HasDerivAt V Vdot t) (hdq : HasDerivAt qbar vbar t) :
    HasDerivAt (fun s ↦ andersenPosition (V s) (qbar s))
      (andersenVelocity (V t) Vdot (qbar t) vbar) t := by
  sorry
theorem andersenMomentum_velocity (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) :
    andersenMomentum m V Vdot qbar vbar =
      fun i ↦ m i*volumeScale V*andersenVelocity V Vdot qbar vbar i := by
  sorry

/-- source_id: MD-8.8-AndersenKineticEnergy · 印刷p.379 / PDFp.400
[SCOPE] 所印动能展开的逐标量坐标版本。
[EXTRA] 坐标逐分量求和就是三维点积展开，避免把Pi类型的最大范数误作物理Euclidean长度；V正。 -/
def andersenKinetic (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i*(andersenVelocity V Vdot qbar vbar i)^2/2
def andersenKineticExpanded (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n) : ℝ :=
  ∑ i, m i/2*((1/9 : ℝ)*Real.rpow V (-4/3 : ℝ)*Vdot^2*qbar i^2+
    (2/3 : ℝ)*Real.rpow V (-1/3 : ℝ)*Vdot*qbar i*vbar i+
    Real.rpow V (2/3 : ℝ)*vbar i^2)
theorem andersenKinetic_expansion (m : Vec n) (V Vdot : ℝ) (qbar vbar : Vec n)
    (hV : 0 < V) : andersenKinetic m V Vdot qbar vbar =
      andersenKineticExpanded m V Vdot qbar vbar := by
  sorry

/-- source_id: MD-8.8-AndersenHamiltonianPrinted · 印刷p.380 / PDFp.401
[SCOPE] 活塞Hamiltonian、原印/修正边缘权重和Gaussian积分目标。
[EXTRA] m,QV,V,β正为物理域；QV是活塞质量，pV取实数。仅高斯消元的点态权重式，不把它当成任意U下的归一概率或完整坐标Jacobian定理。
[EXTRA] [EXTRA] andersenMarginal_corrected本身仅为除以Z的函数定义；要解释为概率密度须另证明Z等于正确域上正有限配分积分。
[EXTRA] [EXTRA] andersenMarginal_corrected仅是除以参数Z的权重，不声称自动归一。若作概率密度，须在相同坐标和V>0域上可积，且Z为相同权重的正有限配分积分；任意Z>0不足。
[ERRATUM?] 已目视核对原页PDF401：边缘公式未写此前ρ_NPT定义中的Z_NPT⁻¹；字面右端给未归一Boltzmann权。修正版独立加入正配分常数，需导师确认作者是否在此省略归一因子。
[ERRATUM?] [ERRATUM?] 保留Printed并标[ERRATUM?]；corrected如作密度须另要求Z是相同坐标/域下的正有限配分积分，不能只要求任意Z>0。 -/
def andersenHamiltonian (m : Vec n) (U : Vec n → ℝ) (QV P : ℝ)
    (z : (Phase n × ℝ) × ℝ) : ℝ :=
  (∑ i, z.1.1.2 i^2/(2*m i*Real.rpow z.1.2 (2/3 : ℝ)))+
    U (andersenPosition z.1.2 z.1.1.1)+z.2^2/(2*QV)+P*z.1.2
def andersenMarginalPrinted (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (z : Phase n × ℝ) : ℝ :=
  Real.sqrt (β/(2*Real.pi*QV))*∫ pV, Real.exp (-β*andersenHamiltonian m U QV P (z,pV))
def andersenMarginal_corrected (m : Vec n) (U : Vec n → ℝ) (QV P β Z : ℝ)
    (z : Phase n × ℝ) : ℝ := andersenMarginalPrinted m U QV P β z/Z
theorem andersenGaussian_marginal (m : Vec n) (U : Vec n → ℝ) (QV P β : ℝ)
    (hQV : 0 < QV) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    andersenMarginalPrinted m U QV P β z =
      Real.exp (-β*((∑ i, z.1.2 i^2/(2*m i*Real.rpow z.2 (2/3 : ℝ)))+
        U (andersenPosition z.2 z.1.1)+P*z.2)) := by
  sorry

/-- source_id: MD-8.8.1-NHLPistonEquations · 印刷p.381–382 / PDFp.402–403
[SCOPE] 实际压力、反馈、漂移扩散和正体积NHL活塞积分解规格。
[EXTRA] z.2=(V,ξ,η)，V>0、热浴/活塞质量正、独立二维Wiener明确；所有辅助变量除V均为实数。
[EXTRA] 选择正体积域内的积分解类，不声明该类存在唯一或必然遍历；n=3N为物理情形。 -/
abbrev PistonState (n : ℕ) := Phase n × Vec 3
def pistonPressure (invm : Vec n) (U : Vec n × ℝ → ℝ) (q p : Vec n) (V : ℝ) : ℝ :=
  (kineticTwice invm p-dot q (gradient (fun x ↦ U (x,V)) q)-
    V*deriv (fun v ↦ U (q,v)) V)/V
def pistonDrift (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i+z.2 2*z.1.1 i,
    fun i ↦ -gradient (fun q ↦ U (q,z.2 0)) z.1.1 i-(z.2 2+z.2 1)*z.1.2 i),
   ![z.2 2*z.2 0,(kineticTwice invm z.1.2-n*θ)/QT-γT*z.2 1,
     (z.2 0*pistonPressure invm U z.1.1 z.1.2 (z.2 0)-P*z.2 0+θ)/QP-γP*z.2 2])
def pistonNoise (θ QT QP γT γP : ℝ) (j : Fin 2) : PistonState n :=
  ((0,0),if j=0 then ![0,Real.sqrt (2*θ*γT/QT),0] else ![0,0,Real.sqrt (2*θ*γP/QP)])
def isNHLPistonSolution (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (μ : Measure Ω) (W : ℝ → Ω → Vec 2) (X : ℝ → Ω → PistonState n)
    (x0 : PistonState n) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ 0 < QT ∧ 0 < QP ∧ 0 ≤ γT ∧ 0 ≤ γP ∧
  ContDiff ℝ 2 U ∧ 0 < x0.2 0 ∧ (∀ t, 0 ≤ t → ∀ᵐ sample ∂μ, 0 < (X t sample).2 0) ∧
  additiveSDE μ 2 W X x0 (pistonDrift invm U θ P QT QP γT γP) (pistonNoise θ QT QP γT γP)

/-- source_id: MD-8.8.1-PistonHamiltonianSubfield · 印刷p.381 / PDFp.402
[SCOPE] 原印p子场、M⁻¹p修正子场及修正子场光滑复合权的局部驻定目标；不把修正场说成逐字原印场。
[EXTRA] 只陈述实际通量散度为零；φ,ψ是权重而非自动概率密度，归一、可积和全局保测流不在本条。
[EXTRA] 已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。
[ERRATUM?] 保留原页文字；在issues显式标[ERRATUM?]：原印p应为M⁻¹p（或注明单位质量约定）。给现有Hamiltonian子场标为合理修正，不将其与原印向量场混同。
[ERRATUM?] 已目视核对原页PDF402：文字子场印为(p,−∇U,0,0,0)，一般质量应为(M⁻¹p,−∇U,0,0,0)或另限单位质量。旧pistonHamiltonianPart及其驻定目标属于合理修正，新增Printed与_corrected明确区分。 -/
def pistonHamiltonianPart (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((fun i ↦ invm i*z.1.2 i,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)
theorem pistonHamiltonianWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (φ : ℝ → ℝ) (ψ : Vec 3 → ℝ) (hU : ContDiff ℝ 2 U)
    (hφ : ContDiff ℝ 1 φ) (hψ : ContDiff ℝ 1 ψ) (z : PistonState n) :
    textbookDivergence (fun x : PistonState n ↦
      (φ (kineticTwice invm x.1.2/2+U (x.1.1,x.2 0))*ψ x.2) •
        pistonHamiltonianPart invm U x) z=0 := by
  sorry

/-- 原印Hamiltonian子场：第一分量为p，忠实保留其一般质量疑误。 -/
def pistonHamiltonianPartPrinted (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n :=
  ((z.1.2,-gradient (fun q ↦ U (q,z.2 0)) z.1.1),0)

/-- 修正版第一分量为M⁻¹p；现有驻定目标已采用此场。 -/
def pistonHamiltonianPart_corrected (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (z : PistonState n) : PistonState n := pistonHamiltonianPart invm U z

/-- source_id: MD-8.8.1-PistonThermostatWeightPrinted · 印刷p.381 / PDFp.402
[SCOPE] 原印/修正权重及ψ₂=1时的实际子场驻定目标。
[EXTRA] 仅取ψ₂=1的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。
[ERRATUM?] 已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。
[ERRATUM?] 保留Printed定义和原文；[ERRATUM?]记录动能系数缺1/2，继续将_corrected与原印版分开。 -/
def pistonThermostatPart (invm : Vec n) (θ QT : ℝ) (z : PistonState n) : PistonState n :=
  ((0,fun i ↦ -z.2 1*z.1.2 i),![0,(kineticTwice invm z.1.2-n*θ)/QT,0])
def pistonRho2Printed (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2+QT*(z.2 1)^2/2))
def pistonRho2_corrected (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+QT*(z.2 1)^2/2))
theorem pistonRho2_stationary_corrected (invm : Vec n) (β QT : ℝ)
    (hm : ∀ i, 0 < invm i) (hβ : 0 < β) (hQT : 0 < QT) (z : PistonState n) :
    textbookDivergence (fun x ↦ pistonRho2_corrected invm β QT x •
      pistonThermostatPart invm β⁻¹ QT x) z=0 := by
  sorry

/-- source_id: MD-8.8.1-PistonReducedPDE · 印刷p.382 / PDFp.403
[SCOPE] 完整(8.74)及Boltzmann权代入目标。
[EXTRA] 只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。 -/
def pistonReducedOperator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (ψ : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  -fderiv ℝ ψ z ((z.1.1,0),0)+fderiv ℝ ψ z ((0,z.1.2),0)-ψ z-
  z.2*fderiv ℝ ψ z ((0,0),1)+
    (β*z.2*pistonPressure invm U z.1.1 z.1.2 z.2-β*P*z.2+1)*ψ z
theorem pistonReduced_boltzmann (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    pistonReducedOperator invm U β P
      (fun x ↦ Real.exp (-β*(kineticTwice invm x.1.2/2+U (x.1.1,x.2)+P*x.2))) z=0 := by
  sorry

/-- source_id: MD-8.8.1-PistonStationaryWeight · 印刷p.382 / PDFp.403
[SCOPE] 候选权重与实际局部前向算子的驻定目标。
[EXTRA] 只陈述正V内的真实Fokker–Planck微分表达式为零；候选正权重并不自动可积/归一。
[EXTRA] 盒边界/体积边界的通量、Markov半群不变概率及唯一遍历性需要NPT理论，明确列缺口。 -/
def pistonWeight (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP : ℝ)
    (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+U (z.1.1,z.2 0)+P*z.2 0+
    QT*(z.2 1)^2/2+QP*(z.2 2)^2/2))
def pistonForward (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (ρ : PistonState n → ℝ) (z : PistonState n) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • pistonDrift invm U θ P QT QP γT γP x) z+
    (∑ j : Fin 2, fderiv ℝ (fun x ↦ fderiv ℝ ρ x (pistonNoise θ QT QP γT γP j))
      z (pistonNoise θ QT QP γT γP j))/2
theorem pistonWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (β P QT QP γT γP : ℝ) (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U)
    (hβ : 0 < β) (hQT : 0 < QT) (hQP : 0 < QP) (hγT : 0 ≤ γT) (hγP : 0 ≤ γP)
    (z : PistonState n) (hV : 0 < z.2 0) :
    pistonForward invm U β⁻¹ P QT QP γT γP (pistonWeight invm U β P QT QP) z=0 := by
  sorry

/-- source_id: MD-8.8.2-PistonIntegrator · 印刷p.383 / PDFp.404
[SCOPE] 完整分步算法、周期映射及OU保持V和指数体积正性的短结论。
[EXTRA] 正β、QT、QP、质量、体积及h≥0是物理有效域；R取独立标准二维正态且跨步独立，参照independentWiener/standardNormalSequence所列资格。
[EXTRA] 零指数分支按原页连续延拓；周期位置在每次q/V更新后按当前盒长映射。只定义完整算法，不证明二阶、可逆或不变分布精度。 -/
def expIntegrated (a t : ℝ) : ℝ := if a=0 then t else (Real.exp (a*t)-1)/a
def pistonWrap (V : ℝ) (q : Vec n) : Vec n := fun i ↦
  volumeScale V*(q i/volumeScale V+1/2-(Int.floor (q i/volumeScale V+1/2) : ℝ)-1/2)
def pistonMomentumKick (U : Vec n × ℝ → ℝ) (h : ℝ) (z : PistonState n) : PistonState n :=
  ((z.1.1,fun i ↦ Real.exp (-(z.2 1+z.2 2)*h)*z.1.2 i-
    expIntegrated (-(z.2 1+z.2 2)) h*gradient (fun q ↦ U (q,z.2 0)) z.1.1 i),z.2)
def pistonFeedback (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP h : ℝ)
    (z : PistonState n) : PistonState n :=
  let f := pistonDrift invm U θ P QT QP 0 0 z
  (z.1,![z.2 0,z.2 1+h*f.2 1,z.2 2+h*f.2 2])
def pistonOU (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) : PistonState n :=
  (z.1,![z.2 0,Real.exp (-γT*h)*z.2 1+Real.sqrt ((1-Real.exp (-2*γT*h))/(β*QT))*R 0,
    Real.exp (-γP*h)*z.2 2+Real.sqrt ((1-Real.exp (-2*γP*h))/(β*QP))*R 1])
def pistonIntegrator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP γT γP h : ℝ)
    (R : Vec 2) (z : PistonState n) : PistonState n :=
  let a := pistonFeedback invm U β⁻¹ P QT QP (h/2) z
  let b := pistonMomentumKick U (h/2) a
  let q := pistonWrap (b.2 0) (fun i ↦ Real.exp (b.2 2*h)*b.1.1 i+
    expIntegrated (b.2 2) h*invm i*b.1.2 i)
  let c := pistonMomentumKick U (h/2) ((q,b.1.2),b.2)
  let V := Real.exp (c.2 2*h)*c.2 0
  let d : PistonState n := ((pistonWrap V c.1.1,c.1.2),![V,c.2 1,c.2 2])
  pistonOU β QT QP γT γP h R (pistonFeedback invm U β⁻¹ P QT QP (h/2) d)
theorem pistonOU_volume (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) :
    (pistonOU β QT QP γT γP h R z).2 0=z.2 0 := rfl
theorem pistonVolume_positive (V η h : ℝ) (hV : 0 < V) : 0 < Real.exp (η*h)*V :=
  mul_pos (Real.exp_pos _) hV

/-- source_id: MD-8.8.3-ParrinelloRahman · 印刷p.385 / PDFp.406
[SCOPE] 各向异性盒的体积/位置/度量/Lagrangian及标量三重积恒等式。
[EXTRA] 选定正定向非退化盒det(h)>0及正质量；U为缩放坐标势，必要时由实际h映射后势复合而得。
[EXTRA] 拉氏方程、与热浴耦合和防止盒塌缩均未在原页给完整条件，列覆盖缺口，不把内部结构的经验稳定性当定理。 -/
def cellVolume (h : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := Matrix.det h
def cellMetric (h : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ := h.transpose*h
def cellPosition (h : Matrix (Fin 3) (Fin 3) ℝ) (qbar : Vec 3) : Vec 3 := h *ᵥ qbar
def cross3 (a b : Vec 3) : Vec 3 := ![a 1*b 2-a 2*b 1,a 2*b 0-a 0*b 2,a 0*b 1-a 1*b 0]
theorem cellVolume_triple (h : Matrix (Fin 3) (Fin 3) ℝ) :
    cellVolume h=dot (fun i ↦ h i 0) (cross3 (fun i ↦ h i 1) (fun i ↦ h i 2)) := by
  simp [cellVolume,Matrix.det_fin_three,dot,Fin.sum_univ_succ,cross3]
  ring
def parrinelloRahmanLagrangian {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → Vec 3) → ℝ)
    (Q P : ℝ) (h hdot : Matrix (Fin 3) (Fin 3) ℝ) (qbar vbar : Fin N → Vec 3) : ℝ :=
  (∑ i, m i/2*dot (vbar i) (cellMetric h *ᵥ vbar i))-U qbar+
    Q/2*Matrix.trace (hdot.transpose*hdot)-P*cellVolume h
def cellQualification {N : ℕ} (m : Fin N → ℝ) (Q : ℝ)
    (h : Matrix (Fin 3) (Fin 3) ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < Q ∧ 0 < Matrix.det h

/-- source_id: MD-8.9-TotalMomentum · 印刷p.386 / PDFp.407
[SCOPE] 总动量定义和Nosé瞬时总力/零总动量时总力为零。
[EXTRA] 只证明瞬时总力恒等式；沿连续轨道的零动量不变需要ODE唯一性，有限精度“飞冰块”属经验现象，列缺口。 -/
abbrev ParticleConfig (N d : ℕ) := Fin N → Vec d
abbrev ParticlePhase (N d : ℕ) := ParticleConfig N d × ParticleConfig N d
def totalMomentum {N d : ℕ} (p : ParticleConfig N d) : Vec d := ∑ i, p i
theorem noseTotalForce {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) :
    totalMomentum (fun i ↦ F i-ξ • p i) = -ξ • totalMomentum p := by
  simp only [totalMomentum,Finset.sum_sub_distrib,← Finset.smul_sum] at *
  rw [hF]; simp
theorem noseTotalForce_zero {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) (hp : totalMomentum p=0) :
    totalMomentum (fun i ↦ F i-ξ • p i)=0 := by rw [noseTotalForce F p ξ hF,hp,smul_zero]

/-- source_id: MD-8.9.1-DPDSoftPotential · 印刷p.387–388 / PDFp.408–409
[SCOPE] 软势、保守成对力/总力与光滑有效域的梯度目标；完整SDE见后条。
[EXTRA] d维Euclidean距离由坐标平方和开方，避免Pi最大范数；只在非碰撞且离开截断接缝的有效域声明梯度关系。N、d为物理正整数，mᵢ>0在动力学资格另列。 -/
def pairDistance {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : ℝ :=
  Real.sqrt (dot (q i-q j) (q i-q j))
def pairDirection {N d : ℕ} (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (pairDistance q i j)⁻¹ • (q i-q j)
def dpdSoftPotential (α rc r : ℝ) : ℝ := if r < rc then α*rc/2*(1-r/rc)^2 else 0
def dpdPairConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) (i j : Fin N) : Vec d :=
  if pairDistance q i j < rc then (α*(1-pairDistance q i j/rc)) • pairDirection q i j else 0
def dpdPotential {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ℝ :=
  ∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), dpdSoftPotential α rc (pairDistance q i j)
def dpdConservative {N d : ℕ} (α rc : ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairConservative α rc q i j
def particleGradient {N d : ℕ} (U : ParticleConfig N d → ℝ) (q : ParticleConfig N d) : ParticleConfig N d :=
  fun i a ↦ fderiv ℝ U q (Pi.single i (Pi.single a 1))
theorem dpdConservative_gradient {N d : ℕ} (α rc : ℝ) (hα : 0 ≤ α) (hrc : 0 < rc)
    (q : ParticleConfig N d) (hnocoll : ∀ i j, i ≠ j → 0 < pairDistance q i j)
    (hcut : ∀ i j, i ≠ j → pairDistance q i j ≠ rc) :
    dpdConservative α rc q = -particleGradient (dpdPotential α rc) q := by
  sorry

/-- source_id: MD-8.9.1-DPDPairForces · 印刷p.388 / PDFp.409
[SCOPE] 全部成对/总耗散力、软随机权与成对守恒扩散方向。
[EXTRA] 白噪声θᵢⱼ不作为逐点函数使用；随机力的实际意义是下一条无序对独立Wiener驱动、双方相反的扩散向量。总化r=0只作辅助，在动力学中要求非碰撞。 -/
def dpdWeightR (rc r : ℝ) : ℝ := if r < rc then 1-r/rc else 0
def relativeVelocity {N d : ℕ} (m : Fin N → ℝ) (p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (m i)⁻¹ • p i-(m j)⁻¹ • p j
def dpdPairDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) (i j : Fin N) : Vec d :=
  (-γ*wD (pairDistance q i j)*dot (pairDirection q i j) (relativeVelocity m p i j)) • pairDirection q i j
def dpdPairRandom {N d : ℕ} (σ : ℝ) (wR : ℝ → ℝ) (q : ParticleConfig N d)
    (i j : Fin N) (R : ℝ) : Vec d := (σ*wR (pairDistance q i j)*R) • pairDirection q i j
def dpdDissipative {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ParticleConfig N d :=
  fun i ↦ ∑ j ∈ Finset.univ.filter (fun j ↦ j ≠ i), dpdPairDissipative m γ wD q p i j
def pairImpulseVector {N d : ℕ} (i j : Fin N) (v : Vec d) : ParticleConfig N d :=
  Pi.single i v-Pi.single j v
def dpdNoise {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ) (wR : ℝ → ℝ)
    (q : ParticleConfig N d) (k : Fin K) : ParticlePhase N d :=
  (0,pairImpulseVector (pairs k).1 (pairs k).2
    ((σ*wR (pairDistance q (pairs k).1 (pairs k).2)) • pairDirection q (pairs k).1 (pairs k).2))

/-- source_id: MD-8.9.1-DPDPairWiener · 印刷p.388–389 / PDFp.409–410
[SCOPE] 对称噪声增量和对应所印δ协方差的积分版本。
[EXTRA] 只对无序对使用独立标准Wiener；Wᵢⱼ=Wⱼᵢ由同一坐标实现，不能把有序对全部设独立。Dirac白噪声公式通过有限时间增量协方差表达。 -/
def pairEnumeration {N K : ℕ} (pairs : Fin K → Fin N × Fin N) : Prop :=
  (∀ k, (pairs k).1 < (pairs k).2) ∧ Function.Injective pairs ∧
  ∀ i j, i < j → ∃ k, pairs k=(i,j)
def pairNoiseIncrement {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) (sample : Ω) : ℝ :=
  ∑ k, if pairs k=(i,j) ∨ pairs k=(j,i) then W t sample k-W s sample k else 0
theorem pairNoiseIncrement_symmetric {N K : ℕ} (pairs : Fin K → Fin N × Fin N)
    (W : ℝ → Ω → Vec K) (s t : ℝ) (i j : Fin N) :
    pairNoiseIncrement pairs W s t i j=pairNoiseIncrement pairs W s t j i := by
  sorry
theorem pairNoiseIncrement_covariance {N K : ℕ} (P : Measure Ω)
    (pairs : Fin K → Fin N × Fin N) (he : pairEnumeration pairs)
    (W : ℝ → Ω → Vec K) (hW : independentWiener P K W)
    (s t : ℝ) (hs : 0 ≤ s) (hst : s ≤ t) (i j k l : Fin N) (hij : i ≠ j) (hkl : k ≠ l) :
    (∫ sample, pairNoiseIncrement pairs W s t i j sample*pairNoiseIncrement pairs W s t k l sample ∂P)=
      if (i=k ∧ j=l) ∨ (i=l ∧ j=k) then t-s else 0 := by
  sorry

/-- source_id: MD-8.9.1-DPDIntegralSystem · 印刷p.389 / PDFp.410
[SCOPE] 配置依赖扩散的真实积分解规格及正质量/涨落耗散/无序噪声资格。
[EXTRA] 实际多维独立Wiener、共同自然历史适应、联合可测、路径连续、漂移可积、所有网格左和及积分代表L²均明示。
[EXTRA] 选择强L²、非碰撞解类；不声称与所有弱解等价，也不建立SDE存在唯一或Markov半群。 -/
def strictItoIntegral8 (P : Measure Ω) (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ k, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T k) 2 P) ∧ MemLp Y 2 P ∧
  Tendsto (fun k ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T k sample-Y sample)^2 ∂P)
    atTop (𝓝 0)
def multiplicativeSDE8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (P : Measure Ω) (r : ℕ)
    (W : ℝ → Ω → Vec r) (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : E → Fin r → E) : Prop :=
  independentWiener P r W ∧ Measurable (Function.uncurry X) ∧ (∀ j, Measurable (fun x ↦ B x j)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ T, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
    ∀ ell : E →L[ℝ] ℝ, ∃ Y : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral8 P (fun s sample ↦ W s sample j)
        (fun s sample ↦ ell (B (X s sample) j)) T (Y j)) ∧
      ∀ᵐ sample ∂P, ell (X T sample-x0-(∫ s in (0 : ℝ)..T, a (X s sample)))=∑ j, Y j sample
def dpdDrift {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),dpdConservative α rc z.1+dpdDissipative m γ wD z.1 z.2)
def isDPDSolution {N d K : ℕ} (m : Fin N → ℝ) (α rc γ σ θ : ℝ) (wD wR : ℝ → ℝ)
    (pairs : Fin K → Fin N × Fin N) (P : Measure Ω) (W : ℝ → Ω → Vec K)
    (X : ℝ → Ω → ParticlePhase N d) (x0 : ParticlePhase N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 ≤ α ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ r, wD r=(wR r)^2) ∧ σ^2=2*γ*θ ∧ pairEnumeration pairs ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1 i j) ∧
  multiplicativeSDE8 P K W X x0 (dpdDrift m α rc γ wD)
    (fun z ↦ dpdNoise pairs σ wR z.1)

/-- source_id: MD-8.9.1-DPDCanonicalLeaf · 印刷p.389 / PDFp.410
[SCOPE] 涨落耗散资格、动量约束叶及其可归一canonical测度定义。
[EXTRA] Dirac乘积解释为指定动量叶上的参考测度，未伪造Lebesgue密度；参考测度需另指定几何/周期体积。
[EXTRA] 只是权重与概率资格目标；DPD保持该测度、流体力学保持及高密度一维遍历性的大型定理均列缺口。 -/
def dpdFluctuationDissipation (γ σ θ : ℝ) (wD wR : ℝ → ℝ) : Prop :=
  0 ≤ γ ∧ 0 < θ ∧ σ^2=2*γ*θ ∧ ∀ r, wD r=(wR r)^2
def momentumLeaf {N d : ℕ} (π : Vec d) : Set (ParticlePhase N d) :=
  {z | totalMomentum z.2=π}
def particleHamiltonian {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (z : ParticlePhase N d) : ℝ := (∑ i, dot (z.2 i) (z.2 i)/(2*m i))+U z.1
def momentumCanonical {N d : ℕ} (ν : Measure (ParticlePhase N d)) (m : Fin N → ℝ)
    (U : ParticleConfig N d → ℝ) (β : ℝ) : Measure (ParticlePhase N d) :=
  ν.withDensity (fun z ↦ ENNReal.ofReal (Real.exp (-β*particleHamiltonian m U z)/
    (∫ x, Real.exp (-β*particleHamiltonian m U x) ∂ν)))
def momentumCanonicalQualification {N d : ℕ} (ν : Measure (ParticlePhase N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ν (momentumLeaf π)ᶜ=0 ∧
  Integrable (fun z ↦ Real.exp (-β*particleHamiltonian m U z)) ν ∧
  (0 < ∫ z, Real.exp (-β*particleHamiltonian m U z) ∂ν) ∧
  IsProbabilityMeasure (momentumCanonical ν m U β)

/-- source_id: MD-8.9.1-DPDMassOrderPrinted · 印刷p.389 / PDFp.410
[SCOPE] 原印/校正的质量矩阵次序及具体代数反例。
[EXTRA] M应正定、θ>0；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
[ERRATUM?] 已目视核对原页PDF410：对动量漂移−Δp、动量协方差k_BT M，应为Δ=ΣΣᵀM⁻¹/(2k_BT)；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。
[ERRATUM?] 保留Printed等式；[ERRATUM?]记录一般质量情形改为ΣΣᵀM⁻¹/(2kBT)，标注等质量或交换条件下两者相同。 -/
def dpdMatrixFDPrinted {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • (M⁻¹*(B*B.transpose))
def dpdMatrixFD_corrected {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • ((B*B.transpose)*M⁻¹)
theorem dpdMassOrder_counterexample :
    (!![1,0;0,(1/2 : ℝ)]) * (!![1,-1;-1,1]) ≠
      (!![1,-1;-1,1]) * (!![1,0;0,(1/2 : ℝ)]) := by
  intro h
  have hh := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ ↦ A 0 1) h
  norm_num [Matrix.mul_apply,Fin.sum_univ_two] at hh

/-- source_id: MD-8.9.2-DPDVelocityVerlet · 印刷p.389–391 / PDFp.410–412
[SCOPE] 三条更新式和新噪声在下一步复用的状态机制。
[EXTRA] 物理用法要求mᵢ>0、h≥0、无序对枚举、每步Rnew独立标准正态并与历史独立；本条确定性给定输入的扩展状态映射。
[EXTRA] 尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。 -/
def dpdRandomForce {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ)
    (wR : ℝ → ℝ) (q : ParticleConfig N d) (R : Vec K) : ParticleConfig N d :=
  ∑ k, R k • (dpdNoise pairs σ wR q k).2

def dpdVerlet {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ)
    (state : ParticlePhase N d × Vec K) (Rnew : Vec K) : ParticlePhase N d × Vec K :=
  let q := state.1.1
  let p := state.1.2
  let ph := p+(h/2) • dpdConservative α rc q+(h/2) • dpdDissipative m γ wD q p+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR q state.2
  let qn := fun i ↦ q i+(h/m i) • ph i
  let pn := ph+(h/2) • dpdConservative α rc qn+(h/2) • dpdDissipative m γ wD qn ph+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR qn Rnew
  ((qn,pn),Rnew)

theorem dpdVerlet_reuse {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ) (z : ParticlePhase N d × Vec K) (R : Vec K) :
    (dpdVerlet pairs m α rc γ σ h wD wR z R).2=R := rfl

/-- source_id: MD-8.9.2-DPDSplitGenerator · 印刷p.391 / PDFp.412
[SCOPE] 实际三个漂移、无序对扩散生成元和漂移分解恒等式。
[EXTRA] 采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。
[EXTRA] 光滑测试函数上的形式生成元定义不等同于已建立Markov半群，Fₜ=eᵗᴸ及其定义域列缺口。 -/
def dpdA {N d : ℕ} (m : Fin N → ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),0)
def dpdB {N d : ℕ} (α rc : ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  (0,dpdConservative α rc z.1)
def dpdO {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d := (0,dpdDissipative m γ wD z.1 z.2)
def firstOrder8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (f : E → ℝ) (z : E) : ℝ := fderiv ℝ f z (F z)
def dpdLO {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdO m γ wD) f z+
    (∑ k, fderiv ℝ (fun x ↦ fderiv ℝ f x) z (dpdNoise pairs σ wR z.1 k)
      (dpdNoise pairs σ wR z.1 k))/2
def dpdGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdA m) f z+firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
theorem dpdDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : dpdDrift m α rc γ wD z=dpdA m z+dpdB α rc z+dpdO m γ wD z := by
  ext <;> simp [dpdDrift,dpdA,dpdB,dpdO]

/-- source_id: MD-8.9.2-DPDPairGeneratorPrinted · 印刷p.392 / PDFp.413
[SCOPE] 冻结配置下单对动量生成元的原式和守恒方向修正版。
[EXTRA] 本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
[ERRATUM?] 已目视核对原页PDF413：单个无序对算子的最外层只对pᵢ求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为e·(∂pᵢ−∂pⱼ)。完整有序双和(8.97)另含反方向项，不能直接同样判错。 -/
def pairDerivative {N d : ℕ} (i j : Fin N) (e : Vec d)
    (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  fderiv ℝ f p (pairImpulseVector i j e)
def dpdPairGeneratorPrinted {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*fderiv ℝ f p (Pi.single i e)+
    σ^2*wr^2/2*pairDerivative i j e (fun x ↦ fderiv ℝ f x (Pi.single i e)) p
def dpdPairGenerator_corrected {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*pairDerivative i j e f p+
    σ^2*wr^2/2*pairDerivative i j e (pairDerivative i j e f) p

/-- source_id: MD-8.9.2-DPDSplittingCompositions · 印刷p.392–393 / PDFp.413–414
[SCOPE] 两种外层组合、固定顺序逐对执行及S形式生成元；实际OU单对步骤见后条。
[EXTRA] A/B/O/S为调用者指定的映射；只保留所印组合顺序。尚未实现BBK成对近似或其误差、全O/S流及生成元指数关系。
[EXTRA] 两次S同顺序的非交换成对乘积不能仅凭外层回文判为对称；不作该声称。 -/
def dpdShardlowComposition {E : Type*} (A B O : ℝ → E → E) (h : ℝ) : E → E :=
  O h ∘ B (h/2) ∘ A h ∘ B (h/2)
def dpdTrotterComposition {E : Type*} (A S : ℝ → E → E) (h : ℝ) : E → E :=
  S (h/2) ∘ A h ∘ S (h/2)
def sequentialPairComposition {E : Type*} (steps : List (E → E)) : E → E :=
  fun x ↦ steps.foldl (fun y F ↦ F y) x
def dpdSGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z

/-- source_id: MD-8.9.2-DPDPairOUUpdate · 印刷p.393 / PDFp.414
[SCOPE] 原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。
[EXTRA] 原印转移律要求mr>0、a>0、θ>0、t≥0及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。
[EXTRA] 单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。
[EXTRA] [EXTRA] 零率分支仅用于涨落耗散使噪声同时退化的情形；不用于任意独立非零扩散的零漂移OU。物理转移需正约化质量、正温度、a,t≥0及独立标准正态R。
[ERRATUM?] 已目视核对原页PDF414：原印F/(amred)须a>0；γ=0或截断外ωᴰ=0时需用积分系数连续延拓。修正版显式定义a=0为自由加速，噪声退化为零。 -/
def reducedMass8 (mi mj : ℝ) : ℝ := mi*mj/(mi+mj)
theorem reducedMass8_pos (mi mj : ℝ) (hi : 0 < mi) (hj : 0 < mj) : 0 < reducedMass8 mi mj :=
  div_pos (mul_pos hi hj) (add_pos hi hj)
def dpdPairOUPrinted (mr a F θ t u R : ℝ) : ℝ :=
  F/(a*mr)+Real.exp (-a*t)*(u-F/(a*mr))+Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
def dpdPairOU_corrected (mr a F θ t u R : ℝ) : ℝ :=
  Real.exp (-a*t)*u+(F/mr)*(if a=0 then t else (1-Real.exp (-a*t))/a)+
    Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
theorem dpdPairOU_zeroRate (mr F θ t u R : ℝ) :
    dpdPairOU_corrected mr 0 F θ t u R=u+(F/mr)*t := by simp [dpdPairOU_corrected]
def dpdPairMomentumStep {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : ParticleConfig N d := p+pairImpulseVector i j ((mr*du) • e)
theorem dpdPairMomentumStep_conserves {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : totalMomentum (dpdPairMomentumStep i j e mr du p)=totalMomentum p := by
  simp [dpdPairMomentumStep,pairImpulseVector,totalMomentum,Finset.sum_add_distrib,Finset.sum_sub_distrib]

/-- source_id: MD-8.9.3-PairwiseNoseHoover · 印刷p.394 / PDFp.415
[SCOPE] PNH场、反馈和正质量/正热浴质量的ODE规格。
[EXTRA] Q为原文μ，F̃ᴰ是γ=1的相对速度耗散；排除i=j，物理轨道另需非碰撞且ωᴰ≥0。
[EXTRA] 只落盘实际ODE规格；Galilean不变性、总动量沿轨道守恒、存在唯一性及遍历性列缺口。 -/
abbrev PNHLState (N d : ℕ) := ParticlePhase N d × ℝ
def pairwiseFeedback {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ℝ :=
  (∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), wD (pairDistance q i j)*
    ((dot (relativeVelocity m p i j) (pairDirection q i j))^2-θ/reducedMass8 (m i) (m j)))/Q
def pnhDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ (m i)⁻¹ • z.1.2 i),
    dpdConservative α rc z.1.1+z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),
   pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def isPNHSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (X : ℝ → PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧
  ∀ t, 0 ≤ t → HasDerivWithinAt X (pnhDrift m α rc θ Q wD (X t)) (Ici 0) t

/-- source_id: MD-8.9.3-PairwiseCanonicalWeight · 印刷p.394 / PDFp.415
[SCOPE] 动量约束下扩展Gibbs权、配分积分和概率密度资格。
[EXTRA] ν是需指定的动量叶参考测度；正有限配分积分和概率资格显式列出。
[EXTRA] 这里只定义权重及归一目标，不把任意支持在动量叶上的测度称为PNH不变测度。完整不变性和归一存在理论列缺口。 -/
def pairwiseWeight {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  Real.exp (-β*particleHamiltonian m U z.1)*Real.exp (-β*Q*z.2^2/2)
def pairwiseCanonicalDensity {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  pairwiseWeight m U β Q z/(∫ x, pairwiseWeight m U β Q x ∂ν)
def pairwiseCanonicalQualification {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ 0 < Q ∧ ν {z | totalMomentum z.1.2 ≠ π}=0 ∧
  Integrable (pairwiseWeight m U β Q) ν ∧ (0 < ∫ z, pairwiseWeight m U β Q z ∂ν) ∧
  probabilityDensity ν (pairwiseCanonicalDensity ν m U β Q)

/-- source_id: MD-8.9.4-PairwiseNHLSDE · 印刷p.395 / PDFp.416
[SCOPE] 带正质量资格、涨落耗散关系及真实独立标准Wiener的PNHL积分解规格。
[EXTRA] 实际一维标准Wiener由通用积分解规格明示；扩散仅作用ξ。
[EXTRA] 未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。 -/
def pnhlDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  ((pnhDrift m α rc θ Q wD z).1,pairwiseFeedback m θ Q wD z.1.1 z.1.2-γ*z.2)
def pnhlNoise {N d : ℕ} (σ : ℝ) (_ : Fin 1) : PNHLState N d := ((0,0),σ)
def isPNHLSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → PNHLState N d)
    (x0 : PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧ 0 ≤ γ ∧
  σ^2=2*γ*θ/Q ∧ (∀ r, 0 ≤ wD r) ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1.1 i j) ∧
  additiveSDE P 1 W X x0 (pnhlDrift m α rc θ Q γ wD) (pnhlNoise σ)

/-- source_id: MD-8.9.4-PairwiseNHLGenerator · 印刷p.395 / PDFp.416
[SCOPE] 五子场、形式生成元、漂移分解；扩展权的局部驻定目标。
[EXTRA] 驻定式只为非碰撞、离开截断界面的局部光滑目标；全局保测需边界、半群等理论。
[EXTRA] 没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。 -/
def pnhlA {N d : ℕ} (m : Fin N → ℝ) (z : PNHLState N d) : PNHLState N d := (dpdA m z.1,0)
def pnhlB {N d : ℕ} (α rc : ℝ) (z : PNHLState N d) : PNHLState N d := (dpdB α rc z.1,0)
def pnhlC {N d : ℕ} (m : Fin N → ℝ) (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((0,z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),0)
def pnhlD {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d := ((0,0),pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlO {N d : ℕ} (γ : ℝ) (z : PNHLState N d) : PNHLState N d := ((0,0),-γ*z.2)
def pnhlGenerator {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (f : PNHLState N d → ℝ) (z : PNHLState N d) : ℝ :=
  firstOrder8 (pnhlA m) f z+firstOrder8 (pnhlB α rc) f z+firstOrder8 (pnhlC m wD) f z+
    firstOrder8 (pnhlD m θ Q wD) f z+additiveGenerator (pnhlO γ) (pnhlNoise σ 0) f z
theorem pnhlDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : pnhlDrift m α rc θ Q γ wD z=
      pnhlA m z+pnhlB α rc z+pnhlC m wD z+pnhlD m θ Q wD z+pnhlO γ z := by
  ext <;> simp [pnhlDrift,pnhDrift,pnhlA,pnhlB,pnhlC,pnhlD,pnhlO,dpdA,dpdB,sub_eq_add_neg]
theorem pairwiseWeight_localStationary {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ)
    (hm : ∀ i, 0 < m i) (hrc : 0 < rc) (hθ : 0 < θ) (hQ : 0 < Q)
    (hγ : 0 ≤ γ) (hσ : σ^2=2*γ*θ/Q) (z : PNHLState N d)
    (hq : ∀ i j, i ≠ j → 0 < pairDistance z.1.1 i j)
    (hcut : ∀ i j, i ≠ j → pairDistance z.1.1 i j ≠ rc) :
    -textbookDivergence (fun x ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q x •
      pnhlDrift m α rc θ Q γ (fun r ↦ (dpdWeightR rc r)^2) x) z+
      σ^2/2*deriv (deriv (fun s ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q (z.1,s))) z.2=0 := by
  sorry

/-- source_id: MD-8.9.4-PNHLSplittingAlgorithms · 印刷p.396 / PDFp.417
[SCOPE] A/B/D/O实际更新、单对C更新和S/N的原印外层组合；全C指数与误差理论列缺口。
[EXTRA] O需θ,Q>0、γ,h≥0及R独立标准正态；A/B/D给实际子步。C仅给逐对精确更新，全C需有序逐对近似，未冒称精确全流。
[EXTRA] 两组合保留原印因子顺序；不证明全方法弱阶、不变分布误差或非对称方法更优的经验结论。 -/
def pnhlAStep {N d : ℕ} (m : Fin N → ℝ) (h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ z.1.1 i+(h/m i) • z.1.2 i),z.1.2),z.2)
def pnhlBStep {N d : ℕ} (α rc h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((z.1.1,z.1.2+h • dpdConservative α rc z.1.1),z.2)
def pnhlDStep {N d : ℕ} (m : Fin N → ℝ) (θ Q h : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (z.1,z.2+h*pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlOStep {N d : ℕ} (θ Q γ h R : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (z.1,Real.exp (-γ*h)*z.2+Real.sqrt (θ/Q*(1-Real.exp (-2*γ*h)))*R)
def pnhlPairCStep {N d : ℕ} (i j : Fin N) (m : Fin N → ℝ) (h : ℝ)
    (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  let mr := reducedMass8 (m i) (m j)
  let e := pairDirection z.1.1 i j
  let u := dot e (relativeVelocity m z.1.2 i j)
  let du := u*(Real.exp (-z.2*wD (pairDistance z.1.1 i j)*h/mr)-1)
  ((z.1.1,dpdPairMomentumStep i j e mr du z.1.2),z.2)
def pnhlSComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ B (h/2) ∘ A (h/2)
def pnhlNComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ A (h/2) ∘ B (h/2)

/-- source_id: MD-8.10-BerendsenRelaxation · 印刷p.396–397 / PDFp.417–418
[SCOPE] Berendsen温度方程的显式解、动量缩放、有效域和单次能量恒等式。
[EXTRA] 取单位粒子质量的Euclidean动量平方和；有效域显式要求非零动量及非负根号，避免将总化sqrt/division当作物理方法。
[EXTRA] 只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。 -/
def berendsenTemperature (θ T0 γ t : ℝ) : ℝ := θ+(T0-θ)*Real.exp (-γ*t)
theorem berendsenTemperature_derivative (θ T0 γ t : ℝ) :
    HasDerivAt (berendsenTemperature θ T0 γ) (γ*(θ-berendsenTemperature θ T0 γ t)) t := by
  convert (hasDerivAt_const t θ).add (((hasDerivAt_id t).const_mul (-γ)).exp.const_mul (T0-θ)) using 1
  · ext x
    dsimp [berendsenTemperature]
  · dsimp [berendsenTemperature]
    ring
def berendsenRadicand (nd θ γ h E : ℝ) : ℝ := 1+γ*h*(nd*θ/E-1)
def berendsenScale {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Vec n :=
  Real.sqrt (berendsenRadicand n θ γ h (dot p p)) • p
def berendsenScaleQualification {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Prop :=
  0 < n ∧ 0 < θ ∧ 0 < γ ∧ 0 ≤ h ∧ 0 < dot p p ∧ 0 ≤ berendsenRadicand n θ γ h (dot p p)
theorem dot_smul_same {n : ℕ} (c : ℝ) (p : Vec n) : dot (c • p) (c • p)=c^2*dot p p := by
  simp only [dot,Pi.smul_apply,smul_eq_mul,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  ring
theorem berendsenScale_energy {n : ℕ} (θ γ h : ℝ) (p : Vec n)
    (hq : berendsenScaleQualification θ γ h p) :
    dot (berendsenScale θ γ h p) (berendsenScale θ γ h p)=
      (1-γ*h)*dot p p+γ*h*n*θ := by
  rw [berendsenScale,dot_smul_same,Real.sq_sqrt hq.2.2.2.2.2]
  dsimp [berendsenRadicand]
  field_simp [ne_of_gt hq.2.2.2.2.1]
  <;> ring

/-- source_id: MD-8.10-CanonicalTotalMomentumGaussian · 印刷p.397–398 / PDFp.418–419
[SCOPE] 实际独立Gaussian动量假设下的一坐标总动量分布；非采样收敛定理。
[EXTRA] 结论明确以各粒子坐标的独立正则Gaussian分布为前提；不从“系统遍历”直接推出有限时刻分布。
[EXTRA] 原页比较直方图和轨迹属于经验试验，未转为普适数学断言。 -/
theorem totalMomentum_gaussian {N d : ℕ} (P : Measure Ω) [IsProbabilityMeasure P]
    (p : Ω → ParticleConfig N d) (m : Fin N → ℝ) (θ : ℝ)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (a : Fin d)
    (hind : iIndepFun (fun i sample ↦ p sample i a) P)
    (hlaw : ∀ i, HasLaw (fun sample ↦ p sample i a)
      (gaussianReal 0 (Real.toNNReal (m i*θ))) P) :
    HasLaw (fun sample ↦ totalMomentum (p sample) a)
      (gaussianReal 0 (Real.toNNReal ((∑ i, m i)*θ))) P := by
  sorry

/-- source_id: MD-8.10-NHLTotalMomentumSign · 印刷p.398 / PDFp.419
[SCOPE] 总动量标量ODE解目标、正指数因子及显式表达式的符号保持。
[EXTRA] 只对连续ξ及实际标量ODE声明解公式，正指数乘子的符号结论已证；从NHL粒子SDE推出总动量ODE仍需成对力抵消及积分方程桥接。
[EXTRA] 欧氏空间正负动量不变与特殊初值下遍历性的讨论不扩展为任意系统的遍历性反例。 -/
def nhlMomentumFactor (ξ : ℝ → ℝ) (t : ℝ) : ℝ := Real.exp (-(∫ s in (0 : ℝ)..t, ξ s))
theorem nhlMomentumFactor_pos (ξ : ℝ → ℝ) (t : ℝ) : 0 < nhlMomentumFactor ξ t := Real.exp_pos _
theorem nhlMomentum_sign (ξ : ℝ → ℝ) (P0 : ℝ) (t : ℝ) :
    (0 < nhlMomentumFactor ξ t*P0 ↔ 0 < P0) ∧
    (nhlMomentumFactor ξ t*P0 < 0 ↔ P0 < 0) := by
  constructor
  · exact mul_pos_iff_of_pos_left (nhlMomentumFactor_pos ξ t)
  · constructor
    · intro h
      by_contra hp
      have hp' : 0 ≤ P0 := le_of_not_gt hp
      have hn := mul_nonneg (le_of_lt (nhlMomentumFactor_pos ξ t)) hp'
      linarith
    · intro h
      exact mul_neg_of_pos_of_neg (nhlMomentumFactor_pos ξ t) h
theorem nhlTotalMomentum_odeSolution (ξ P : ℝ → ℝ) (hξ : Continuous ξ)
    (hP : ∀ t, HasDerivAt P (-ξ t*P t) t) (t : ℝ) :
    P t=nhlMomentumFactor ξ t*P 0 := by
  sorry

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
#print axioms MD.Ch08.npDeltaN_corrected
#print axioms MD.Ch08.npValidDomain
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
#print axioms MD.Ch08.generalizedFeedback_stationaryPrinted
#print axioms MD.Ch08.generalizedFeedback_stationary_corrected
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
#print axioms MD.Ch08.thermostatBlockNoise
#print axioms MD.Ch08.stochasticThermostatSolution
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
#print axioms MD.Ch08.langevinRateEstimate
#print axioms MD.Ch08.langevinEfficiencyEstimate
#print axioms MD.Ch08.originalRescalingRateEstimate
#print axioms MD.Ch08.originalRescalingErrorEstimate
#print axioms MD.Ch08.originalRescalingEfficiencyEstimate
#print axioms MD.Ch08.nhlCriticalEfficiencyEstimate
#print axioms MD.Ch08.rescalingEfficiencyOrder
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
#print axioms MD.Ch08.slsReducedPrinted
#print axioms MD.Ch08.slsReduced_corrected
#print axioms MD.Ch08.slsDoubleWell
#print axioms MD.Ch08.slsDoubleWell_nonneg
#print axioms MD.Ch08.isoMultiplier
#print axioms MD.Ch08.isoField
#print axioms MD.Ch08.isoKinetic_balance
#print axioms MD.Ch08.isoProjection
#print axioms MD.Ch08.isoProjection_self
#print axioms MD.Ch08.isoProjection_idempotent
#print axioms MD.Ch08.isoAnsatz
#print axioms MD.Ch08.isoDivergencePrinted
#print axioms MD.Ch08.isoDivergence_corrected
#print axioms MD.Ch08.isokineticShell
#print axioms MD.Ch08.isoShellWeight
#print axioms MD.Ch08.isoShell_gibbsFactor
#print axioms MD.Ch08.sinConstraint
#print axioms MD.Ch08.sinMultiplier
#print axioms MD.Ch08.sinDrift
#print axioms MD.Ch08.isSINSolution
#print axioms MD.Ch08.sinConstraint_balance
#print axioms MD.Ch08.sinWeightPrinted
#print axioms MD.Ch08.sinWeight_corrected
#print axioms MD.Ch08.sinWeight_stationary_corrected
#print axioms MD.Ch08.sinHarmonicF
#print axioms MD.Ch08.sinHarmonicG
#print axioms MD.Ch08.isSINHarmonicSolution
#print axioms MD.Ch08.sinExceptional
#print axioms MD.Ch08.sinHalfCylinder
#print axioms MD.Ch08.sinHalfCylinder_disjoint
#print axioms MD.Ch08.bracket4
#print axioms MD.Ch08.sinBracket
#print axioms MD.Ch08.projectFirstThree
#print axioms MD.Ch08.sinD
#print axioms MD.Ch08.sinU0Printed
#print axioms MD.Ch08.sinU1Printed
#print axioms MD.Ch08.sinU2Printed
#print axioms MD.Ch08.sinU1DerivativePrinted
#print axioms MD.Ch08.sinProjected_corrected
#print axioms MD.Ch08.sinU2LongPrinted
#print axioms MD.Ch08.sinU2Long_at_p0
#print axioms MD.Ch08.sinEtaPrinted
#print axioms MD.Ch08.sinU3Printed
#print axioms MD.Ch08.sinU3ZeroPrinted
#print axioms MD.Ch08.sinU3Zero_corrected
#print axioms MD.Ch08.sinU3Zero_specialize
#print axioms MD.Ch08.sinBracket_tangentSpan
#print axioms MD.Ch08.sinGenerator
#print axioms MD.Ch08.sinGenerator_lyapunov
#print axioms MD.Ch08.sinConstraint_bathBound
#print axioms MD.Ch08.sinLyapunovTailPrinted
#print axioms MD.Ch08.sinLyapunovTail_corrected
#print axioms MD.Ch08.sinKField
#print axioms MD.Ch08.sinForceField
#print axioms MD.Ch08.sinNField
#print axioms MD.Ch08.sinOField
#print axioms MD.Ch08.sinSplit_fields
#print axioms MD.Ch08.sinForce_constraintBalance
#print axioms MD.Ch08.sinRStages
#print axioms MD.Ch08.sinN1Field
#print axioms MD.Ch08.sinN2Field
#print axioms MD.Ch08.sinN_split
#print axioms MD.Ch08.sinForceAux
#print axioms MD.Ch08.sinForceFlow
#print axioms MD.Ch08.sinForceODEPrinted
#print axioms MD.Ch08.sinForceODE_corrected
#print axioms MD.Ch08.sinForceFlow_solution_corrected
#print axioms MD.Ch08.threeLevelPotential
#print axioms MD.Ch08.nestedTimeSteps
#print axioms MD.Ch08.memoryDrag
#print axioms MD.Ch08.generalizedLangevin
#print axioms MD.Ch08.randomForceQualification
#print axioms MD.Ch08.gleFDPrinted
#print axioms MD.Ch08.gleFD_corrected
#print axioms MD.Ch08.scalarMemoryMatrix
#print axioms MD.Ch08.pronyKernel
#print axioms MD.Ch08.pronyQualification
#print axioms MD.Ch08.pronyKernel_nonneg
#print axioms MD.Ch08.pronyMemory
#print axioms MD.Ch08.pronyMemory_derivative
#print axioms MD.Ch08.pronyMomentumDrift
#print axioms MD.Ch08.pronyMemory_sum
#print axioms MD.Ch08.stationaryPronyOU
#print axioms MD.Ch08.pronyOU_covariance
#print axioms MD.Ch08.totalPronyRandomForce
#print axioms MD.Ch08.pronyOU_covariance_corrected
#print axioms MD.Ch08.GLEState
#print axioms MD.Ch08.gleDrift
#print axioms MD.Ch08.gleNoise
#print axioms MD.Ch08.isExtendedGLESolution
#print axioms MD.Ch08.combinedProny_drift
#print axioms MD.Ch08.pronyEffectiveFriction
#print axioms MD.Ch08.pronyLimit_drift
#print axioms MD.Ch08.independentGaussian_varianceSum
#print axioms MD.Ch08.gleIntegrator
#print axioms MD.Ch08.gleNormalSequence
#print axioms MD.Ch08.gleDecay
#print axioms MD.Ch08.gleNoiseCoefficient
#print axioms MD.Ch08.gleCoefficientConsistency
#print axioms MD.Ch08.gleCoefficients_consistent
#print axioms MD.Ch08.gleCoefficient_smallMemory
#print axioms MD.Ch08.thermodynamicPressure
#print axioms MD.Ch08.maxwellCycle
#print axioms MD.Ch08.maxwellPressureRelation
#print axioms MD.Ch08.nptBathLinear
#print axioms MD.Ch08.nptEntropy_firstOrder
#print axioms MD.Ch08.volumeScale
#print axioms MD.Ch08.nptBox
#print axioms MD.Ch08.nptWeight
#print axioms MD.Ch08.nptDensity
#print axioms MD.Ch08.nptDensity_normalizes
#print axioms MD.Ch08.andersenPosition
#print axioms MD.Ch08.andersenVelocity
#print axioms MD.Ch08.andersenMomentum
#print axioms MD.Ch08.andersenPosition_derivative
#print axioms MD.Ch08.andersenMomentum_velocity
#print axioms MD.Ch08.andersenKinetic
#print axioms MD.Ch08.andersenKineticExpanded
#print axioms MD.Ch08.andersenKinetic_expansion
#print axioms MD.Ch08.andersenHamiltonian
#print axioms MD.Ch08.andersenMarginalPrinted
#print axioms MD.Ch08.andersenMarginal_corrected
#print axioms MD.Ch08.andersenGaussian_marginal
#print axioms MD.Ch08.PistonState
#print axioms MD.Ch08.pistonPressure
#print axioms MD.Ch08.pistonDrift
#print axioms MD.Ch08.pistonNoise
#print axioms MD.Ch08.isNHLPistonSolution
#print axioms MD.Ch08.pistonHamiltonianPart
#print axioms MD.Ch08.pistonHamiltonianWeight_stationary
#print axioms MD.Ch08.pistonHamiltonianPartPrinted
#print axioms MD.Ch08.pistonHamiltonianPart_corrected
#print axioms MD.Ch08.pistonThermostatPart
#print axioms MD.Ch08.pistonRho2Printed
#print axioms MD.Ch08.pistonRho2_corrected
#print axioms MD.Ch08.pistonRho2_stationary_corrected
#print axioms MD.Ch08.pistonReducedOperator
#print axioms MD.Ch08.pistonReduced_boltzmann
#print axioms MD.Ch08.pistonWeight
#print axioms MD.Ch08.pistonForward
#print axioms MD.Ch08.pistonWeight_stationary
#print axioms MD.Ch08.expIntegrated
#print axioms MD.Ch08.pistonWrap
#print axioms MD.Ch08.pistonMomentumKick
#print axioms MD.Ch08.pistonFeedback
#print axioms MD.Ch08.pistonOU
#print axioms MD.Ch08.pistonIntegrator
#print axioms MD.Ch08.pistonOU_volume
#print axioms MD.Ch08.pistonVolume_positive
#print axioms MD.Ch08.cellVolume
#print axioms MD.Ch08.cellMetric
#print axioms MD.Ch08.cellPosition
#print axioms MD.Ch08.cross3
#print axioms MD.Ch08.cellVolume_triple
#print axioms MD.Ch08.parrinelloRahmanLagrangian
#print axioms MD.Ch08.cellQualification
#print axioms MD.Ch08.ParticleConfig
#print axioms MD.Ch08.ParticlePhase
#print axioms MD.Ch08.totalMomentum
#print axioms MD.Ch08.noseTotalForce
#print axioms MD.Ch08.noseTotalForce_zero
#print axioms MD.Ch08.pairDistance
#print axioms MD.Ch08.pairDirection
#print axioms MD.Ch08.dpdSoftPotential
#print axioms MD.Ch08.dpdPairConservative
#print axioms MD.Ch08.dpdPotential
#print axioms MD.Ch08.dpdConservative
#print axioms MD.Ch08.particleGradient
#print axioms MD.Ch08.dpdConservative_gradient
#print axioms MD.Ch08.dpdWeightR
#print axioms MD.Ch08.relativeVelocity
#print axioms MD.Ch08.dpdPairDissipative
#print axioms MD.Ch08.dpdPairRandom
#print axioms MD.Ch08.dpdDissipative
#print axioms MD.Ch08.pairImpulseVector
#print axioms MD.Ch08.dpdNoise
#print axioms MD.Ch08.pairEnumeration
#print axioms MD.Ch08.pairNoiseIncrement
#print axioms MD.Ch08.pairNoiseIncrement_symmetric
#print axioms MD.Ch08.pairNoiseIncrement_covariance
#print axioms MD.Ch08.strictItoIntegral8
#print axioms MD.Ch08.multiplicativeSDE8
#print axioms MD.Ch08.dpdDrift
#print axioms MD.Ch08.isDPDSolution
#print axioms MD.Ch08.dpdFluctuationDissipation
#print axioms MD.Ch08.momentumLeaf
#print axioms MD.Ch08.particleHamiltonian
#print axioms MD.Ch08.momentumCanonical
#print axioms MD.Ch08.momentumCanonicalQualification
#print axioms MD.Ch08.dpdMatrixFDPrinted
#print axioms MD.Ch08.dpdMatrixFD_corrected
#print axioms MD.Ch08.dpdMassOrder_counterexample
#print axioms MD.Ch08.dpdRandomForce
#print axioms MD.Ch08.dpdVerlet
#print axioms MD.Ch08.dpdVerlet_reuse
#print axioms MD.Ch08.dpdA
#print axioms MD.Ch08.dpdB
#print axioms MD.Ch08.dpdO
#print axioms MD.Ch08.firstOrder8
#print axioms MD.Ch08.dpdLO
#print axioms MD.Ch08.dpdGenerator
#print axioms MD.Ch08.dpdDrift_split
#print axioms MD.Ch08.pairDerivative
#print axioms MD.Ch08.dpdPairGeneratorPrinted
#print axioms MD.Ch08.dpdPairGenerator_corrected
#print axioms MD.Ch08.dpdShardlowComposition
#print axioms MD.Ch08.dpdTrotterComposition
#print axioms MD.Ch08.sequentialPairComposition
#print axioms MD.Ch08.dpdSGenerator
#print axioms MD.Ch08.reducedMass8
#print axioms MD.Ch08.reducedMass8_pos
#print axioms MD.Ch08.dpdPairOUPrinted
#print axioms MD.Ch08.dpdPairOU_corrected
#print axioms MD.Ch08.dpdPairOU_zeroRate
#print axioms MD.Ch08.dpdPairMomentumStep
#print axioms MD.Ch08.dpdPairMomentumStep_conserves
#print axioms MD.Ch08.PNHLState
#print axioms MD.Ch08.pairwiseFeedback
#print axioms MD.Ch08.pnhDrift
#print axioms MD.Ch08.isPNHSolution
#print axioms MD.Ch08.pairwiseWeight
#print axioms MD.Ch08.pairwiseCanonicalDensity
#print axioms MD.Ch08.pairwiseCanonicalQualification
#print axioms MD.Ch08.pnhlDrift
#print axioms MD.Ch08.pnhlNoise
#print axioms MD.Ch08.isPNHLSolution
#print axioms MD.Ch08.pnhlA
#print axioms MD.Ch08.pnhlB
#print axioms MD.Ch08.pnhlC
#print axioms MD.Ch08.pnhlD
#print axioms MD.Ch08.pnhlO
#print axioms MD.Ch08.pnhlGenerator
#print axioms MD.Ch08.pnhlDrift_split
#print axioms MD.Ch08.pairwiseWeight_localStationary
#print axioms MD.Ch08.pnhlAStep
#print axioms MD.Ch08.pnhlBStep
#print axioms MD.Ch08.pnhlDStep
#print axioms MD.Ch08.pnhlOStep
#print axioms MD.Ch08.pnhlPairCStep
#print axioms MD.Ch08.pnhlSComposition
#print axioms MD.Ch08.pnhlNComposition
#print axioms MD.Ch08.berendsenTemperature
#print axioms MD.Ch08.berendsenTemperature_derivative
#print axioms MD.Ch08.berendsenRadicand
#print axioms MD.Ch08.berendsenScale
#print axioms MD.Ch08.berendsenScaleQualification
#print axioms MD.Ch08.dot_smul_same
#print axioms MD.Ch08.berendsenScale_energy
#print axioms MD.Ch08.totalMomentum_gaussian
#print axioms MD.Ch08.nhlMomentumFactor
#print axioms MD.Ch08.nhlMomentumFactor_pos
#print axioms MD.Ch08.nhlMomentum_sign
#print axioms MD.Ch08.nhlTotalMomentum_odeSolution
