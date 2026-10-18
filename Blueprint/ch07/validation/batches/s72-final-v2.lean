import MolecularDynamics.Chapter06.ReviewDefinitions
import MolecularDynamics.Chapter07.FormalOperatorFunctionalCalculus
import MolecularDynamics.Chapter07.InvariantDistributionSwap
import Mathlib.Tactic

open Set Filter MeasureTheory ProbabilityTheory MolecularDynamics
open scoped BigOperators Topology ContDiff ENNReal NNReal
noncomputable section
namespace MD.Ch07
variable {Ω : Type*} [MeasurableSpace Ω]
variable {n : ℕ}

/-- source_id: MD-7.1-Bias · 印刷p.263 / PDFp.284
[EXTRA] 将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。 -/
def bias (exact computed : ℝ) : ℝ := |exact - computed|

/-- source_id: MD-7.2-ScalarSDE · 印刷p.264 / PDFp.285
[EXTRA] 明确概率空间与标准连续Wiener过程；Itô积分采用第6章网格左和L²定义，扩散项适应自然历史且时间平方可积。
[EXTRA] X的初值、几乎处处路径连续性和积分方程在第6章定义体中全部保留；未声称一般弱解与本L²表示等价。 -/
def scalarSDE (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ IsBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ T : ℝ, 0 ≤ T → ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W
    (fun t sample ↦ b (X t sample)) ∧
  MolecularDynamics.Chapter06Review.scalarSDE P W X
    (fun x _ ↦ a x) (fun x _ ↦ b x) x0

/-- source_id: MD-7.2-EulerMaruyama · 印刷p.264 / PDFp.285
[EXTRA] 步长h>0用于数值解释；单步映射本身为总函数；跨步独立正态资格另由standardNormalSequence明确给出。 -/
def eulerMaruyamaStep (a b : ℝ → ℝ) (h x R : ℝ) : ℝ :=
  x + h * a x + b x * Real.sqrt h * R

def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (gaussianReal 0 1) P

def eulerMaruyama (a b : ℝ → ℝ) (h x0 : ℝ) (R : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | k+1 => fun sample ↦ eulerMaruyamaStep a b h (eulerMaruyama a b h x0 R k sample) (R k sample)

/-- source_id: MD-7.2-SDEIncrement · 印刷p.264 / PDFp.285
[EXTRA] 区间Itô积分用两个从0开始的L²积分值之差表示；t,h非负，漂移在整个区间可积；不另造未规定的随机积分。 -/
theorem sdeIncrement (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 t h : ℝ) (ht : 0 ≤ t) (hh : 0 ≤ h)
    (hX : scalarSDE P W X a b x0)
    (ha : ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 (t+h)) :
    MolecularDynamics.Chapter06Review.isItoIntegral P W (fun s sample ↦ b (X s sample)) (t+h)
      (fun sample ↦ X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) ∧
    ∀ᵐ sample ∂P, X (t+h) sample - X t sample =
      (∫ s in t..(t+h), a (X s sample)) +
      ((X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) -
       (X t sample - x0 - ∫ s in 0..t, a (X s sample))) := by
  sorry

/-- source_id: MD-7.2-StrongError · 印刷p.264 / PDFp.285
[EXTRA] α>0且各网格误差的α次矩可积时具有误差解释；有限非空网格的sSup表示最大值；Real.rpow为实指数幂。 -/
def strongError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (h α : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = (∫ sample, |Xh k sample - X (k*h) sample| ^ α ∂P) ^ (1/α)}

/-- source_id: MD-7.2-MeanErrorExpectation · 印刷p.264 / PDFp.285
[EXTRA] 期望可积；不以数值方法的收敛为假设重新宣布同一收敛，只给使收敛传递成立的定量不等式。 -/
theorem meanErrorExpectation (P : Measure Ω) (X Y : Ω → ℝ)
    (hX : Integrable X P) (hY : Integrable Y P) :
    |(∫ sample, X sample ∂P) - ∫ sample, Y sample ∂P| ≤
      ∫ sample, |X sample - Y sample| ∂P := by
  rw [← integral_sub hX hY]
  simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun sample ↦ X sample - Y sample)

def meanSquareError (P : Measure Ω) (X Y : Ω → ℝ) : ℝ :=
  Real.sqrt (∫ sample, (X sample - Y sample)^2 ∂P)

/-- source_id: MD-7.2-StrongOrder · 印刷p.264 / PDFp.285
[EXTRA] 显式h=T/N趋零及统一常数的量词；正α、r和时间；有限矩资格作为方法适用条件不隐去。 -/
def hasStrongOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (α r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < α ∧ 0 < r ∧
  ∀ T : ℝ, 0 < T → ∃ C : ℝ, 0 < C ∧ ∃ N0 : ℕ, 0 < N0 ∧
    ∀ N : ℕ, N0 ≤ N →
      (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ |Xh (T/N) k sample - X (k*(T/N)) sample|^α) P) ∧
      strongError P (Xh (T/N)) X (T/N) α N < C * (T/N)^r

/-- source_id: MD-7.2-WeakError · 印刷p.265 / PDFp.286
[EXTRA] 测试函数类明确量化；D允许依赖测试函数；积分只有在可积时解释为期望，后续误差定理显式要求可积。 -/
def weakError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (f : ℝ → ℝ) (h : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = |(∫ sample, f (Xh k sample) ∂P) - ∫ sample, f (X (k*h) sample) ∂P|}

def hasWeakOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (tests : Set (ℝ → ℝ)) (r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < r ∧ ∀ f ∈ tests, ∀ T : ℝ, 0 < T →
    ∃ D : ℝ, 0 < D ∧ ∃ N0 : ℕ, 0 < N0 ∧
      ∀ N : ℕ, N0 ≤ N →
        (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ f (Xh (T/N) k sample)) P ∧
          Integrable (fun sample ↦ f (X (k*(T/N)) sample)) P) ∧
        weakError P (Xh (T/N)) X f (T/N) N < D*(T/N)^r

/-- source_id: MD-7.2-StrongWeakComparison · 印刷p.265 / PDFp.286
[EXTRA] 正向结论明确限制为全局Lipschitz可观测量及可积误差；对一般无界测试函数需额外矩条件，列为覆盖缺口。
[EXTRA] 反向用两点分布上交换X、Y的反例表达；同分布但耦合强误差不为零。 -/
theorem strongWeakLipschitz (P : Measure Ω) (X Y : Ω → ℝ)
    (f : ℝ → ℝ) (L : ℝ) (hL : 0 ≤ L)
    (hf : ∀ x y, |f x - f y| ≤ L * |x-y|)
    (hfx : Integrable (fun sample ↦ f (X sample)) P)
    (hfy : Integrable (fun sample ↦ f (Y sample)) P)
    (hxy : Integrable (fun sample ↦ |X sample-Y sample|) P) :
    |(∫ sample, f (X sample) ∂P) - ∫ sample, f (Y sample) ∂P| ≤
      L * ∫ sample, |X sample-Y sample| ∂P := by
  calc
    _ ≤ ∫ sample, |f (X sample)-f (Y sample)| ∂P :=
      meanErrorExpectation P _ _ hfx hfy
    _ ≤ ∫ sample, L * |X sample-Y sample| ∂P :=
      integral_mono (hfx.sub hfy).abs (hxy.const_mul L) (fun sample ↦ hf _ _)
    _ = _ := integral_const_mul _ _

theorem weakDoesNotImplyStrong : ∃ (P : Measure ℝ) (X Y : ℝ → ℝ),
    IsProbabilityMeasure P ∧
    (∀ f : ℝ → ℝ, (∫ sample, f (X sample) ∂P) = ∫ sample, f (Y sample) ∂P) ∧
    0 < ∫ sample, |X sample-Y sample| ∂P := by
  sorry

/-- source_id: MD-7.2-CanonicalAverage · 印刷p.266 / PDFp.287
[EXTRA] 该公式先保留显式Z参数；只有probabilityDensity成立才称概率密度。正有限配分积分及其归一化见修正版，不把原页倒数疑误带入默认定义。 -/
def densityWithPartition {D : Type*} (H : D → ℝ) (β Z : ℝ) (x : D) : ℝ :=
  Z⁻¹ * Real.exp (-β * H x)

def canonicalAverage {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z : ℝ) : ℝ := ∫ x, f x * densityWithPartition H β Z x ∂ν

def probabilityDensity {D : Type*} [MeasurableSpace D] (ν : Measure D) (ρ : D → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ x) ∧ Integrable ρ ν ∧ (∫ x, ρ x ∂ν) = 1

/-- source_id: MD-7.2-PartitionPrinted · 印刷p.266 / PDFp.287
[EXTRA] 原文版严格保留倒数关系；修正版取Z_can=配分积分，并补正性、可积性。
[EXTRA] 反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。
[ERRATUM?] 已目视核对原页PDF287／印刷266：原书确为Z_can^{-1}=积分，和紧接的归一化断言不相容；不是转录错误。 -/
theorem partitionPrinted {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β Z : ℝ) (hZ : 0 < Z)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hPrinted : Z⁻¹ = ∫ x, Real.exp (-β*H x) ∂ν) :
    (∫ x, densityWithPartition H β Z x ∂ν) = 1 := by
  sorry

theorem partitionPrinted_counterexample :
    (2 : ℝ)⁻¹ * (2 : ℝ)⁻¹ ≠ 1 := by norm_num

theorem partitionPrinted_corrected {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hZ : 0 < ∫ x, Real.exp (-β*H x) ∂ν) :
    probabilityDensity ν (densityWithPartition H β (∫ x, Real.exp (-β*H x) ∂ν)) := by
  refine ⟨fun x ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ)) (le_of_lt (Real.exp_pos _)),
    hi.const_mul _, ?_⟩
  simp only [densityWithPartition, integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)

/-- source_id: MD-7.2-AverageNotationBias · 印刷p.266 / PDFp.287
[EXTRA] computed代表步长h下的不变平均，按原文忽略有限采样误差；正确Z和密度概率资格见CanonicalAverage及修正版。 -/
def observableBias {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z computed : ℝ) : ℝ :=
  bias (canonicalAverage ν H f β Z) computed

theorem bias_nonnegative (exact computed : ℝ) : 0 ≤ bias exact computed := abs_nonneg _

end MD.Ch07

#print axioms MD.Ch07.bias
#print axioms MD.Ch07.scalarSDE
#print axioms MD.Ch07.eulerMaruyamaStep
#print axioms MD.Ch07.standardNormalSequence
#print axioms MD.Ch07.eulerMaruyama
#print axioms MD.Ch07.sdeIncrement
#print axioms MD.Ch07.strongError
#print axioms MD.Ch07.meanErrorExpectation
#print axioms MD.Ch07.meanSquareError
#print axioms MD.Ch07.hasStrongOrder
#print axioms MD.Ch07.weakError
#print axioms MD.Ch07.hasWeakOrder
#print axioms MD.Ch07.strongWeakLipschitz
#print axioms MD.Ch07.weakDoesNotImplyStrong
#print axioms MD.Ch07.densityWithPartition
#print axioms MD.Ch07.canonicalAverage
#print axioms MD.Ch07.probabilityDensity
#print axioms MD.Ch07.partitionPrinted
#print axioms MD.Ch07.partitionPrinted_counterexample
#print axioms MD.Ch07.partitionPrinted_corrected
#print axioms MD.Ch07.observableBias
#print axioms MD.Ch07.bias_nonnegative
