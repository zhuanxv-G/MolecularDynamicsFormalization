import MolecularDynamics.Chapter06.ReviewDefinitions
import MolecularDynamics.Chapter07.FormalOperatorFunctionalCalculus
import MolecularDynamics.Chapter07.InvariantDistributionSwap
import Mathlib.Tactic
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.Analysis.SpecialFunctions.Artanh

open Set Filter MeasureTheory ProbabilityTheory MolecularDynamics
open scoped BigOperators Topology ContDiff ENNReal NNReal Matrix
noncomputable section
namespace MD.Ch07
variable {Ω : Type*} [MeasurableSpace Ω]
variable {n : ℕ}

/-- source_id: MD-7.1-Bias · 印刷p.263 / PDFp.284
[EXTRA] 将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。
[EXTRA] 实际覆盖范围：仅覆盖 bias 所列对象、量词、前提和结论。范围说明：实数 exact、computed 的绝对差与本段 bias 的含义及印刷266页公式一致。原段的概述没有被错误提升为所有算法的普遍定理；由后文具体化绝对误差的范围已显式披露。 -/
def bias (exact computed : ℝ) : ℝ := |exact - computed|

/-- source_id: MD-7.2-ScalarSDE · 印刷p.264 / PDFp.285
[EXTRA] 明确概率空间与标准连续Wiener过程；Itô积分采用第6章网格左和L²定义，扩散项适应自然历史且时间平方可积。
[EXTRA] X的初值、几乎处处路径连续性和积分方程在第6章定义体中全部保留；未声称一般弱解与本L²表示等价。
[EXTRA] 实际覆盖范围：仅覆盖 scalarSDE 所列对象、量词、前提和结论。范围说明：P、标量W、标量X、自治a,b及确定初值x0均明确。D2—D6保留初值、非负时间路径连续性、漂移路径可积、自然历史适应及扩散平方可积，并以均匀左和的L²极限表示Itô方程。这是已披露的确定初值、自然滤过及L²解范围，并非所有弱解的等价定义；未声称其一般等价性。 -/
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
[EXTRA] 步长h>0用于数值解释；单步映射本身为总函数；跨步独立正态资格另由standardNormalSequence明确给出。
[EXTRA] 实际覆盖范围：仅覆盖 eulerMaruyamaStep, standardNormalSequence, eulerMaruyama 所列对象、量词、前提和结论。范围说明：单步系数为h*a(x)与b(x)*sqrt(h)*R，无遗漏或符号错误。递归0步为x0，第k+1步使用R k。standardNormalSequence分别要求概率测度、跨步独立及每步N(0,1)；步长为总函数参数，h>0的数值使用限制已列明。 -/
def eulerMaruyamaStep (a b : ℝ → ℝ) (h x R : ℝ) : ℝ :=
  x + h * a x + b x * Real.sqrt h * R

def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (gaussianReal 0 1) P

def eulerMaruyama (a b : ℝ → ℝ) (h x0 : ℝ) (R : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | k+1 => fun sample ↦ eulerMaruyamaStep a b h (eulerMaruyama a b h x0 R k sample) (R k sample)

/-- source_id: MD-7.2-SDEIncrement · 印刷p.264 / PDFp.285
[EXTRA] 区间Itô积分用两个从0开始的L²积分值之差表示；t,h非负，漂移在整个区间可积；不另造未规定的随机积分。
[EXTRA] 实际覆盖范围：仅覆盖 sdeIncrement 所列对象、量词、前提和结论。范围说明：固定t,h≥0及scalarSDE假设，结论第一分量给出t+h的从零Itô积分资格；t处同样资格由hX定义取得。第二分量的随机增量是这两个从零积分代表之差，漂移积分用区间可加性相减，等价于所引增量式。ha在hX中已蕴含但无害；这是固定t,h的几乎处处等式，并非声称一个公共零集外对所有时刻成立。 -/
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
[EXTRA] α>0且各网格误差的α次矩可积时具有误差解释；有限非空网格的sSup表示最大值；Real.rpow为实指数幂。
[EXTRA] 实际覆盖范围：仅覆盖 strongError 所列对象、量词、前提和结论。范围说明：k取range(N+1)，包含0和N；非空有限集合的sSup确为最大值。实指数α与1/α、绝对差及期望的位置都对应原式。定义是总化公式；α>0、概率测度与矩可积的适用资格在extra_assumptions中说明，不应将不可积时Lean的总化积分解释为误差。 -/
def strongError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (h α : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = (∫ sample, |Xh k sample - X (k*h) sample| ^ α ∂P) ^ (1/α)}

/-- source_id: MD-7.2-MeanErrorExpectation · 印刷p.264 / PDFp.285
[EXTRA] 期望可积；不以数值方法的收敛为假设重新宣布同一收敛，只给使收敛传递成立的定量不等式。
[EXTRA] 实际覆盖范围：仅覆盖 meanErrorExpectation, meanSquareError 所列对象、量词、前提和结论。范围说明：在X、Y均可积的前提下给出期望差绝对值≤绝对误差期望，足以传递α=1收敛；meanSquareError为二阶矩平方根，与α=2强误差的均方根惯例一致。没有把期望收敛误称为L¹收敛的逆命题。 -/
theorem meanErrorExpectation (P : Measure Ω) (X Y : Ω → ℝ)
    (hX : Integrable X P) (hY : Integrable Y P) :
    |(∫ sample, X sample ∂P) - ∫ sample, Y sample ∂P| ≤
      ∫ sample, |X sample - Y sample| ∂P := by
  rw [← integral_sub hX hY]
  simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun sample ↦ X sample - Y sample)

def meanSquareError (P : Measure Ω) (X Y : Ω → ℝ) : ℝ :=
  Real.sqrt (∫ sample, (X sample - Y sample)^2 ∂P)

/-- source_id: MD-7.2-StrongOrder · 印刷p.264 / PDFp.285
[EXTRA] 显式h=T/N趋零及统一常数的量词；正α、r和时间；有限矩资格作为方法适用条件不隐去。
[EXTRA] 实际覆盖范围：仅覆盖 hasStrongOrder 所列对象、量词、前提和结论。范围说明：α,r>0，P为概率测度；对每个T>0存在正C和正N0，对所有N≥N0统一控制h=T/N的全部网格误差，并要求α次矩可积。C不依赖N，严格小于号保留。h=T/N的渐近量词及r>0均已明示，忠实于数值收敛阶的通常正阶范围。 -/
def hasStrongOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (α r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < α ∧ 0 < r ∧
  ∀ T : ℝ, 0 < T → ∃ C : ℝ, 0 < C ∧ ∃ N0 : ℕ, 0 < N0 ∧
    ∀ N : ℕ, N0 ≤ N →
      (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ |Xh (T/N) k sample - X (k*(T/N)) sample|^α) P) ∧
      strongError P (Xh (T/N)) X (T/N) α N < C * (T/N)^r

/-- source_id: MD-7.2-WeakError · 印刷p.265 / PDFp.286
[EXTRA] 测试函数类明确量化；D允许依赖测试函数；积分只有在可积时解释为期望，后续误差定理显式要求可积。
[EXTRA] 实际覆盖范围：仅覆盖 weakError, hasWeakOrder 所列对象、量词、前提和结论。范围说明：weakError为0…N各期望差绝对值的最大值。hasWeakOrder先对测试函数再对T量化，再选择D,N0，故D可依赖f,T而不依赖N；每个测试函数两侧均要求可积。不是对整个无界函数类使用同一常数；此解释已显式披露。 -/
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
[EXTRA] 反向用两点分布上交换X、Y的反例表达；同分布但耦合强误差不为零。
[EXTRA] 29号覆盖限定：仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。
[EXTRA] 实际覆盖范围：仅覆盖α=1、Lipschitz测试类且有相应矩条件的定量蕴涵；一般强弱阶关系需测试类与矩条件，原书措辞待裁定。 -/
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
  let P : Measure ℝ := (1/2 : ℝ≥0) • Measure.dirac (-1)+(1/2 : ℝ≥0) • Measure.dirac 1
  have hi (f : ℝ → ℝ) (a : ℝ) : Integrable f ((1/2 : ℝ≥0) • Measure.dirac a) :=
    (integrable_dirac (by simp)).smul_measure_nnreal
  refine ⟨P,id,Neg.neg,?_,?_,?_⟩
  · constructor
    simp only [P,Measure.add_apply,Measure.smul_apply,Measure.dirac_apply_of_mem (Set.mem_univ _),ENNReal.smul_def,smul_eq_mul,mul_one]
    exact_mod_cast (by norm_num : (1/2 : ℝ≥0)+(1/2 : ℝ≥0) = 1)
  · intro f
    dsimp [P]
    rw [integral_add_measure (hi _ _) (hi _ _),integral_add_measure (hi _ _) (hi _ _)]
    simp [integral_smul_nnreal_measure,add_comm]
  · dsimp [P]
    rw [integral_add_measure (hi _ _) (hi _ _)]
    norm_num [integral_smul_nnreal_measure]

/-- source_id: MD-7.2-CanonicalAverage · 印刷p.266 / PDFp.287
[EXTRA] 该公式先保留显式Z参数；只有probabilityDensity成立才称概率密度。正有限配分积分及其归一化见修正版，不把原页倒数疑误带入默认定义。
[EXTRA] 实际覆盖范围：仅覆盖 densityWithPartition, canonicalAverage, probabilityDensity 所列对象、量词、前提和结论。范围说明：一般可测空间D和基准测度ν抽象了相空间及其积分域。densityWithPartition用Z⁻¹ exp(−βH)，canonicalAverage积分f乘密度；probabilityDensity另外检查非负、可积与归一化。Z被保持为显式参数，本条没有沿用下一条印刷错误推出归一化。 -/
def densityWithPartition {D : Type*} (H : D → ℝ) (β Z : ℝ) (x : D) : ℝ :=
  Z⁻¹ * Real.exp (-β * H x)

def canonicalAverage {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z : ℝ) : ℝ := ∫ x, f x * densityWithPartition H β Z x ∂ν

def probabilityDensity {D : Type*} [MeasurableSpace D] (ν : Measure D) (ρ : D → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ x) ∧ Integrable ρ ν ∧ (∫ x, ρ x ∂ν) = 1

/-- source_id: MD-7.2-PartitionPrinted · 印刷p.266 / PDFp.287
[EXTRA] 原文版严格保留倒数关系；修正版取Z_can=配分积分，并补正性、可积性。
[EXTRA] 反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。
[EXTRA] 29号覆盖限定：原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。
[EXTRA] 实际覆盖范围：原文Z⁻¹与配分积分的字面断言及反例独立保留；修正版取Z为积分且正有限，已证概率密度归一化。
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
[EXTRA] computed代表步长h下的不变平均，按原文忽略有限采样误差；正确Z和密度概率资格见CanonicalAverage及修正版。
[EXTRA] 实际覆盖范围：仅覆盖 observableBias, bias_nonnegative 所列对象、量词、前提和结论。范围说明：observableBias把精确canonicalAverage与computed作绝对差，bias_nonnegative对全部实参数成立。computed按明示约定代表步长h的完美采样平均；没有将有限样本统计误差合入。h没有独立参数是因为已被computed吸收，未声称已构造长期平均。 -/
def observableBias {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z computed : ℝ) : ℝ :=
  bias (canonicalAverage ν H f β Z) computed

theorem bias_nonnegative (exact computed : ℝ) : 0 ≤ bias exact computed := abs_nonneg _

/-- source_id: MD-7.3-VectorOU · 印刷p.267 / PDFp.288
[EXTRA] 显式标准多维Wiener及整个坐标路径独立，正质量、温度与非负摩擦；各坐标用真实Itô积分方程。
[EXTRA] 实际覆盖范围：仅覆盖 V, Phase, vectorWiener, momentumOU 所列对象、量词、前提和结论。范围说明：V n为Fin n→ℝ，Phase为位置动量对。vectorWiener的D20含联合高斯、零均值、min(s,t)对角协方差、路径连续，并额外要求坐标路径独立；momentumOU逐坐标系数−γp和sqrt(2γθm_i)一致。确定初值、正对角质量、θ=k_BT>0、γ≥0及自然滤过L²解范围均显式可见。 -/
abbrev V (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := V n × V n

def vectorWiener (P : Measure Ω) (W : ℝ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  iIndepFun (fun i sample t ↦ W t sample i) P

def momentumOU (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  ∀ i, scalarSDE P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i)
    (fun x ↦ -γ*x) (fun _ ↦ Real.sqrt (2*γ*θ*m i)) (p0 i)

/-- source_id: MD-7.3-OUIntegratingFactor · 印刷p.267 / PDFp.288
[EXTRA] 把随机微分乘积法则陈述为从0到t的确定性加权Itô积分等式；有限时间和L²解资格由momentumOU明确。
[EXTRA] 实际覆盖范围：仅覆盖 ouIntegratingFactor 所列对象、量词、前提和结论。范围说明：固定t≥0，逐坐标的加权积分 integrand=exp(γs)sqrt(2γθm_i)，终值=exp(γt)p_i(t)−p0_i，与乘积法则及从0积分一致。hp包含正确的OU方程与确定初值；没有用积分因子等式本身充当假设。 -/
theorem ouIntegratingFactor (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t : ℝ) (ht : 0 ≤ t) : ∀ i,
    MolecularDynamics.Chapter06Review.isItoIntegral P (fun s sample ↦ W s sample i)
      (fun s _ ↦ Real.exp (γ*s)*Real.sqrt (2*γ*θ*m i)) t
      (fun sample ↦ Real.exp (γ*t)*p t sample i-p0 i) := by
  sorry

/-- source_id: MD-7.3-OUExactUpdate · 印刷p.268 / PDFp.289
[EXTRA] 等式解释为存在与过去动量独立的标准正态向量的随机表示；不是沿用同一Z表示所有时刻。
[EXTRA] 独立性要求使用W自然历史的适应解，见scalarSDE；θ=k_BT，M正对角。
[EXTRA] 29号覆盖限定：只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。
[EXTRA] 实际覆盖范围：只覆盖正确(7.3)和转移随机表示；原页前导乘数exp(−γt)应为exp(−γ(t+h))，文字笔误不影响(7.3)。
[ERRATUM?] 已目视核对原页PDF289：前导乘数印作exp(−γt)，应为exp(−γ(t+h))；(7.3)与当前更新公式正确，不改。 -/
def ouMomentum (m : V n) (γ θ h : ℝ) (p R : V n) : V n :=
  fun i ↦ Real.exp (-γ*h)*p i + Real.sqrt (θ*(1-Real.exp (-2*γ*h))) * Real.sqrt (m i) * R i

theorem ouTransitionLaw (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t h : ℝ) (ht : 0 ≤ t) (hh : 0 < h) :
    ∃ Z : Ω → V n, HasLaw Z (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P ∧
      IndepFun (p t) Z P ∧ ∀ᵐ sample ∂P,
        p (t+h) sample = ouMomentum m γ θ h (p t sample) (Z sample) := by
  sorry

/-- source_id: MD-7.3-OUPhaseIteration · 印刷p.268 / PDFp.289
[EXTRA] 独立标准正态的完整概率资格由vectorNormalSequence规定；ouStep只是总化单步函数。
[EXTRA] 实际覆盖范围：仅覆盖 ouStep, vectorNormalSequence 所列对象、量词、前提和结论。范围说明：ouStep保持q不变，p分量完全复用ouMomentum。vectorNormalSequence规定跨步独立及每步乘积标准正态分布，涵盖分量独立；总化单步映射本身没有伪称任意R都具有正态分布。 -/
def ouStep (m : V n) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  (x.1, ouMomentum m γ θ h x.2 R)

def vectorNormalSequence (P : Measure Ω) (R : ℕ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P

/-- source_id: MD-7.3-OUForward · 印刷p.268 / PDFp.289
[EXTRA] partial为真实单坐标导数；给出前向表达式与后向生成元在紧支撑C²测试函数上的伴随恒等式。
[EXTRA] 仅p变量，q是固定参数；未声称已构造OU Markov半群的强生成元域。
[EXTRA] 实际覆盖范围：仅覆盖 coordDerivative, ouForward, ouBackward, ouForward_adjoint 所列对象、量词、前提和结论。范围说明：ouForward第一项是γ∑∂_i(p_i f)，第二项γθ∑m_i∂²_i f；ouBackward漂移为−γ∑p_i∂_i f，扩散符号相同。真实偏导D23已核对。两紧支撑C²函数上的积分伴随关系边界项为0，签名正确；q固定参数，未声称半群的完整强生成元域。 -/
def coordDerivative (f : V n → ℝ) (x : V n) (i : Fin n) : ℝ :=
  deriv (fun z ↦ f (Function.update x i z)) (x i)

def ouForward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  γ * (∑ i, coordDerivative (fun x ↦ x i*f x) p i) +
    γ*θ * ∑ i, m i * coordDerivative (fun x ↦ coordDerivative f x i) p i

def ouBackward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  -γ * (∑ i, p i * coordDerivative f p i) +
    γ*θ * ∑ i, m i * coordDerivative (fun x ↦ coordDerivative f x i) p i

theorem ouForward_adjoint (m : V n) (γ θ : ℝ) (f g : V n → ℝ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) :
    (∫ p, f p * ouBackward m γ θ g p) = ∫ p, ouForward m γ θ f p * g p := by
  sorry

/-- source_id: MD-7.3-OUGaussianInvariant · 印刷p.268 / PDFp.289
[EXTRA] γ=0允许恒等更新，仍保留Gaussian不变性；不把此时的不变性说成遍历采样收敛。
[EXTRA] 实际覆盖范围：仅覆盖 ouGaussianInvariant 所列对象、量词、前提和结论。范围说明：输入分布是独立的p~⊗N(0,θm_i)与R~⊗N(0,1)，映射逐坐标线性组合的方差为exp(−2γh)θm_i+θ(1−exp(−2γh))m_i=θm_i，输出仍为独立高斯。m>0、θ>0、γ,h≥0保证全部方差合法；γ=0或h=0只表示不变性，不包含遍历收敛断言。 -/
theorem ouGaussianInvariant (m : V n) (γ θ h : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : 0 ≤ γ) (hθ : 0 < θ) (hh : 0 ≤ h) :
    Measure.map (fun x : V n × V n ↦ ouMomentum m γ θ h x.1 x.2)
      ((Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩)).prod
        (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) =
      Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩) := by
  sorry

/-- source_id: MD-7.3.1-Langevin · 印刷p.268 / PDFp.289
[EXTRA] 用真实坐标偏导与完整位置/动量积分方程表达；常扩散的Itô项即W增量乘系数；显式状态适应W自然历史、漂移可积。
[EXTRA] 实际覆盖范围：仅覆盖 gradient, langevin 所列对象、量词、前提和结论。范围说明：langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p_i/m_i，动量漂移−∂_iU−γp_i，噪声sqrt(2γθm_i)(W_i(t)−W_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。 -/
def gradient (U : V n → ℝ) (q : V n) : V n := fun i ↦ coordDerivative U q i

def langevin (P : Measure Ω) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (U : V n → ℝ) (m : V n) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → ∀ i,
    IntervalIntegrable (fun s ↦ (X s sample).2 i / m i) volume 0 t ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i - γ*(X s sample).2 i) volume 0 t ∧
    (X t sample).1 i = x0.1 i + (∫ s in 0..t, (X s sample).2 i / m i) ∧
    (X t sample).2 i = x0.2 i + (∫ s in 0..t, -gradient U (X s sample).1 i - γ*(X s sample).2 i) +
      Real.sqrt (2*γ*θ*m i) * (W t sample i - W 0 sample i)

/-- source_id: MD-7.3.1-HamiltonianGibbs · 印刷p.269 / PDFp.290
[EXTRA] F为已存在的实际Hamiltonian流的固定时刻映射；显式体积保持与能量保持，结论为实际加权测度不变性。
[EXTRA] 本文未重证明一般Hamiltonian流存在；若需归一化为概率，须另补配分积分正有限。
[EXTRA] 实际覆盖范围：仅覆盖 hamiltonianGibbs 所列对象、量词、前提和结论。范围说明：对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。 -/
theorem hamiltonianGibbs {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (F : D → D) (H : D → ℝ) (β : ℝ)
    (hF : Measurable F) (hv : MeasurePreserving F ν ν)
    (hH : ∀ x, H (F x) = H x) (hweight : Measurable (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) :
    Measure.map F (ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) =
      ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x))) := by
  sorry

/-- source_id: MD-7.3.1-ABOPieces · 印刷p.269–270 / PDFp.290–291
[EXTRA] M为正对角质量；σ=√(2γk_BT)；OU单步及独立正态资格已在OUPhaseIteration写全。
[EXTRA] 仅最后短定理证明漂移相加；A/B确定性精确流与O分布精确性各自另列，不用漂移恒等式替代。
[EXTRA] 实际覆盖范围：仅覆盖 driftStep, kickStep, aField, bField, oDrift, splittingDrift 所列对象、量词、前提和结论。范围说明：aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。 -/
def driftStep (m : V n) (h : ℝ) (x : Phase n) : Phase n :=
  (fun i ↦ x.1 i + h * x.2 i / m i, x.2)

def kickStep (U : V n → ℝ) (h : ℝ) (x : Phase n) : Phase n :=
  (x.1, fun i ↦ x.2 i - h * gradient U x.1 i)

def aField (m : V n) (x : Phase n) : Phase n := (fun i ↦ x.2 i / m i, 0)
def bField (U : V n → ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -gradient U x.1 i)
def oDrift (γ : ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -γ*x.2 i)

theorem splittingDrift (m : V n) (U : V n → ℝ) (γ : ℝ) (x : Phase n) :
    aField m x + bField U x + oDrift γ x =
      (fun i ↦ x.2 i / m i, fun i ↦ -gradient U x.1 i - γ*x.2 i) := by
  ext i <;> simp [aField, bField, oDrift] <;> ring

/-- source_id: MD-7.3.1-ABExactFlows · 印刷p.270 / PDFp.291
[EXTRA] 逐坐标A位置/B动量真实时间导数；另一个分量由更新定义恒定；O精确性引用OUTransitionLaw未证陈述，不冒称全部已证。
[EXTRA] 实际覆盖范围：仅覆盖 driftStep_derivative, kickStep_derivative 所列对象、量词、前提和结论。范围说明：driftStep_derivative和kickStep_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。 -/
theorem driftStep_derivative (m : V n) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (driftStep m s x).1 i) (x.2 i / m i) t := by
  simpa [driftStep, mul_div_assoc] using ((hasDerivAt_id t).mul_const (x.2 i / m i)).const_add (x.1 i)

theorem kickStep_derivative (U : V n → ℝ) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (kickStep U s x).2 i) (-gradient U x.1 i) t := by
  sorry

/-- source_id: MD-7.3.1-ABForward · 印刷p.270 / PDFp.291
[EXTRA] 以真实偏导定义所印微分表达式；形式伴随解释要求足够光滑及边界通量消失，未声称一般强算子域。
[EXTRA] 实际覆盖范围：仅覆盖 aForward, bForward 所列对象、量词、前提和结论。范围说明：aForward为−∑(p_i/m_i)∂_{q_i}f，bForward为+∑∂_{q_i}U ∂_{p_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。 -/
def aForward (m : V n) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  -∑ i, x.2 i / m i * coordDerivative (fun q ↦ f (q,x.2)) x.1 i
def bForward (U : V n → ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, gradient U x.1 i * coordDerivative (fun p ↦ f (x.1,p)) x.2 i

/-- source_id: MD-7.3.1-ABOBABO · 印刷p.270 / PDFp.291
[EXTRA] 字母从左到右执行，函数复合从右到左；随机变量独立资格由vectorNormalSequence约束。
[EXTRA] 实际覆盖范围：仅覆盖 abo, babo 所列对象、量词、前提和结论。范围说明：从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。 -/
def abo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U h ∘ driftStep m h
def babo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2)

/-- source_id: MD-7.3.1-WordConvention · 印刷p.270 / PDFp.291
[EXTRA] 每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。
[EXTRA] 29号覆盖限定：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。
[EXTRA] PDF291已目视核对：原书九字母OABOAOBAO、四次O(h/4)、4N_c均正确；撤销转录造成的假疑误。
[EXTRA] 实际覆盖范围：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。 -/
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 3) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘
  ouStep m γ θ (h/4) (R 1) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

/-- 恢复原页的兼容名称；原书此处没有计数勘误。 -/
def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n := oabaobaoPrinted m U γ θ h R

theorem oabaobaoCount : (["O","A","B","O","A","O","B","A","O"] : List String).count "O" = 4 := by decide

/-- source_id: MD-7.3.1-SixSchemes · 印刷p.271 / PDFp.292
[EXTRA] BABO已定义于ABOBABO；其余5个完整复合依次对应所列中间步。
[EXTRA] R与S为同一步两次O的独立标准正态向量；跨步也独立，用vectorNormalSequence提供资格。
[EXTRA] 原文最后“single evaluation”使用跨步缓存；实现成本不列为待证数学命题。
[EXTRA] 实际覆盖范围：仅覆盖 abao, aboba, baoab, oabao, obabo 所列对象、量词、前提和结论。范围说明：逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。 -/
def abao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2)
def aboba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U (h/2) ∘ ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m (h/2)
def baoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def oabao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ (h/2) R
def obabo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ ouStep m γ θ (h/2) R

/-- source_id: MD-7.3.1-ConjugateIteration · 印刷p.272 / PDFp.293
[EXTRA] compositionIterate是任意确定性映射的真实复合恒等式；实际随机迭代应在扩展噪声序列空间中使用更新映射，不能把固定R重复使用当独立重抽样。
[EXTRA] 对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。
[EXTRA] 29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。
[EXTRA] 实际覆盖范围：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。 -/
theorem compositionIterate {D : Type*} (S T : D → D) (k : ℕ) :
    (S ∘ T)^[k+1] = S ∘ (T ∘ S)^[k] ∘ T := by
  funext x
  induction k with
  | zero => rfl
  | succ k ih =>
    simp only [Function.iterate_succ_apply', Function.comp_apply] at *
    rw [ih]

def oaba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R

def conjugateNoiseS (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (z : Phase n × ℕ) : Phase n × ℕ :=
  ((kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h (R z.2)) z.1,z.2+1)

def conjugateNoiseT (m : V n) (U : V n → ℝ) (h : ℝ)
    (z : Phase n × ℕ) : Phase n × ℕ :=
  ((driftStep m (h/2) ∘ kickStep U (h/2)) z.1,z.2)

theorem oaba_baoab_noiseShift (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (k : ℕ) :
    (fun z : Phase n × ℕ ↦ (oaba m U γ θ h (R z.2) z.1,z.2+1))^[k+1] =
      conjugateNoiseT m U h ∘
      (fun z : Phase n × ℕ ↦ (baoab m U γ θ h (R z.2) z.1,z.2+1))^[k] ∘
      conjugateNoiseS m U γ θ h R := by
  sorry

/-- source_id: MD-7.3.2-SPVPrinted · 印刷p.272 / PDFp.293
[EXTRA] γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。
[EXTRA] 29号覆盖限定：Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。
[EXTRA] 实际覆盖范围：Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。
[ERRATUM?] 已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。 -/
def spvPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U x.1 i
  driftStep m (h/2) (qhalf,pnew)

def spvPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U qhalf i
  driftStep m (h/2) (qhalf,pnew)

/-- 两个总化映射的物理适用域；γ=0另需定义η=h，此处不含该延拓。 -/
def spvQualification (m : V n) (γ θ h : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ 0 ≤ h

/-- source_id: MD-7.3.2-SPVLargeFriction · 印刷p.272–273 / PDFp.293–294
[EXTRA] 只表达明确的η极限；采样不一致的定性判断缺统一模型、时标与测试函数量化，不作为已证结论。
[EXTRA] 29号覆盖限定：固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。
[EXTRA] 实际覆盖范围：固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。 -/
theorem spvEtaLimit (h : ℝ) (hh : 0 < h) :
    Tendsto (fun γ : ℝ ↦ (1-Real.exp (-h*γ))/γ) atTop (𝓝 0) := by
  sorry

/-- source_id: MD-7.3.2-BBK · 印刷p.273 / PDFp.294
[EXTRA] h>0、γ≥0、θ>0、m_i>0时分母非零及噪声方差有效；不同R′耦合方案分别处理，不把独立与重用噪声混为一谈。
[EXTRA] 实际覆盖范围：仅覆盖 bbk, bbkSameNoise 所列对象、量词、前提和结论。范围说明：bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。 -/
def bbk (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) (x : Phase n) : Phase n :=
  let ph := fun i ↦ (1-h*γ/2)*x.2 i - (h/2)*gradient U x.1 i +
    (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*R i
  let q := (driftStep m h (x.1,ph)).1
  (q, fun i ↦ (ph i-(h/2)*gradient U q i + (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*S i)/(1+h*γ/2))

def bbkSameNoise (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) := bbk m U γ θ h R R

/-- source_id: MD-7.4-HarmonicHamiltonian · 印刷p.273 / PDFp.294
[EXTRA] 正m、正θ、Ω≠0时为可归一化的正则谐振子Gibbs分布；θ=k_BT。
[EXTRA] 实际覆盖范围：仅覆盖 harmonicHamiltonian, harmonicLaw 所列对象、量词、前提和结论。范围说明：harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。 -/
def harmonicHamiltonian (m Ω : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/(2*m)+Ω^2*x.1^2/2
def harmonicLaw (m Ω θ : ℝ) : Measure (ℝ × ℝ) :=
  (gaussianReal 0 (Real.toNNReal (θ/Ω^2))).prod (gaussianReal 0 (Real.toNNReal (θ*m)))

/-- source_id: MD-7.4-HarmonicMoments · 印刷p.273–274 / PDFp.294–295
[EXTRA] harmonicLaw给出实际正态乘积，未把所需各矩值作为假设；与Hamiltonian的密度识别另列覆盖缺口。
[EXTRA] 实际覆盖范围：仅覆盖 harmonicMoments 所列对象、量词、前提和结论。范围说明：五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。 -/
theorem harmonicMoments (m Ω θ : ℝ) (hm : 0 < m) (hΩ : Ω ≠ 0) (hθ : 0 < θ) :
    (∫ x, x.1 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, x.2 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, Ω^2*x.1^2 ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.2^2/m ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.1*x.2 ∂harmonicLaw m Ω θ) = 0 := by
  sorry

/-- source_id: MD-7.4-LinearIteration · 印刷p.274 / PDFp.295
[EXTRA] 具体2×2矩阵用四个真实系数，噪声不假定自动独立；后续陈述分别补独立或相关结构。
[EXTRA] 实际覆盖范围：仅覆盖 linearUpdate, momentQ, momentP, momentQP 所列对象、量词、前提和结论。范围说明：linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。 -/
def linearUpdate (a b c d : ℝ) (x noise : ℝ × ℝ) : ℝ × ℝ :=
  (a*x.1+b*x.2+noise.1,c*x.1+d*x.2+noise.2)
def momentQ (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1^2 ∂μ
def momentP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.2^2 ∂μ
def momentQP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1*x.2 ∂μ

/-- source_id: MD-7.4-BBKLinearForm · 印刷p.274 / PDFp.295
[EXTRA] 完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。
[EXTRA] 实际覆盖范围：仅覆盖 bbkMatrix, bbkNoise 所列对象、量词、前提和结论。范围说明：bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra_assumptions 已明确此缺口。 -/
def bbkMatrix (m Ω γ h : ℝ) : ℝ × ℝ × ℝ × ℝ :=
  (1-h^2*Ω^2/(2*m), h/m*(1-γ*h/2),
    h*Ω^2/(2*m)*((h^2*Ω^2-4*m)/(2+γ*h)),
    (2-γ*h)*(2*m-h^2*Ω^2)/(2*m*(2+γ*h)))
def bbkNoise (m Ω γ θ h R S : ℝ) : ℝ × ℝ :=
  (Real.sqrt (θ*γ*h^3/(2*m))*R,
    Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*((1-h^2*Ω^2/(2*m))*R+S))

/-- source_id: MD-7.4-QuadraticProducts · 印刷p.274 / PDFp.295
[EXTRA] 实际覆盖范围：仅覆盖 quadraticProducts 所列对象、量词、前提和结论。范围说明：对全部八个任意实数，三个合取项分别展开 q_new²、p_new²、q_new p_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。 -/
theorem quadraticProducts (a b c d q p r s : ℝ) :
    (linearUpdate a b c d (q,p) (r,s)).1^2 =
      a^2*q^2+b^2*p^2+r^2+2*a*b*q*p+2*a*r*q+2*b*r*p ∧
    (linearUpdate a b c d (q,p) (r,s)).2^2 =
      c^2*q^2+d^2*p^2+s^2+2*c*d*q*p+2*c*s*q+2*d*s*p ∧
    (linearUpdate a b c d (q,p) (r,s)).1*(linearUpdate a b c d (q,p) (r,s)).2 =
      a*c*q^2+b*d*p^2+r*s+(a*d+b*c)*q*p+(a*s+c*r)*q+(d*r+b*s)*p := by
  dsimp [linearUpdate]
  constructor
  · ring
  constructor <;> ring

/-- source_id: MD-7.4.1-StationaryMomentSystem · 印刷p.275 / PDFp.296
[EXTRA] 使用独立乘积μ.prodη及实际推前不变性，不把所求矩方程当作该定理假设；所有坐标L²、噪声中心化明示。
[EXTRA] 只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。
[EXTRA] 实际覆盖范围：仅覆盖 momentSystem, invariantLinearLaw, stationaryMomentSystem 所列对象、量词、前提和结论。范围说明：momentSystem 三式与(7.11)一致，噪声矩的参数次序 u,v,w 对应 qq,qp,pp。invariantLinearLaw 用独立乘积 μ.prodη 及实际推前不变性；四个坐标 L²、噪声均值零足够确保各乘积可积及状态噪声混合项消失。结论是已有平稳分布的矩方程；不是从任意初始状态收敛到平稳的定理，此差别已披露。 -/
def momentSystem (a b c d u v w Q P C : ℝ) : Prop :=
  Q = a^2*Q+b^2*P+2*a*b*C+u ∧
  P = c^2*Q+d^2*P+2*c*d*C+w ∧
  C = a*c*Q+b*d*P+(a*d+b*c)*C+v

def invariantLinearLaw (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ IsProbabilityMeasure η ∧
  Measure.map (fun z ↦ linearUpdate a b c d z.1 z.2) (μ.prod η) = μ

theorem stationaryMomentSystem (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ)
    (hinv : invariantLinearLaw μ η a b c d)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hr : MemLp (fun x ↦ x.1) 2 η) (hs : MemLp (fun x ↦ x.2) 2 η)
    (hmean : (∫ x, x.1 ∂η) = 0 ∧ (∫ x, x.2 ∂η) = 0) :
    momentSystem a b c d (momentQ η) (momentQP η) (momentP η)
      (momentQ μ) (momentP μ) (momentQP μ) := by
  sorry

/-- source_id: MD-7.4.1-ABOHarmonic · 印刷p.275–276 / PDFp.296–297
[EXTRA] 原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。
[EXTRA] 实际覆盖范围：仅覆盖 aboHarmonic, aboStationaryMean 所列对象、量词、前提和结论。范围说明：aboHarmonic 的矩阵和动量噪声与(7.12)一致。aboStationaryMean 在正 m,h,γ、Ω≠0 和坐标可积的实际不变概率分布下给出两个均值零；不要求 θ>0 仍不损害该均值结论。hinv 中 z.1 为状态、z.2 为标准正态噪声，顺序正确。只替代原文已取到的平稳极限，不证明趋平稳。 -/
def aboHarmonic (m Ω γ θ h R : ℝ) (x : ℝ × ℝ) : ℝ × ℝ :=
  linearUpdate 1 (h/m) (-Ω^2*h*Real.exp (-h*γ)) ((1-Ω^2*h^2/m)*Real.exp (-h*γ)) x
    (0, Real.sqrt (θ*(1-Real.exp (-2*γ*h)))*Real.sqrt m*R)

theorem aboStationaryMean (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : Integrable (fun x ↦ x.1) μ) (hp : Integrable (fun x ↦ x.2) μ)
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    (∫ x, x.1 ∂μ) = 0 ∧ (∫ x, x.2 ∂μ) = 0 := by
  sorry

/-- source_id: MD-7.4.1-ABOVariance · 印刷p.276 / PDFp.297
[EXTRA] 完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。
[EXTRA] 实际覆盖范围：仅覆盖 aboVarianceRatio, aboVarianceRatio_expansion, aboStationaryVariance 所列对象、量词、前提和结论。范围说明：有理式的 exp(hγ)、(1+exp(-hγ))² 及分母完全一致；IsBigO 在 h→0 的双侧邻域表达三阶余项，m>0 保证零点附近分母非零。实际平稳方差结论有正参数、L²、不变推前及正稳定分母，不循环假设目标比值。 -/
def aboVarianceRatio (m Ω γ h : ℝ) : ℝ :=
  Real.exp (h*γ)*m*(1+Real.exp (-h*γ))^2 /
    (2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))

theorem aboVarianceRatio_expansion (m Ω γ : ℝ) (hm : 0 < m) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ aboVarianceRatio m Ω γ h - (1+γ*h/2+(Ω^2+γ^2*m)*h^2/(4*m)))
      (fun h ↦ h^3) := by
  sorry

theorem aboStationaryVariance (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hden : 0 < 2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ / (θ/Ω^2) = aboVarianceRatio m Ω γ h := by
  sorry

/-- source_id: MD-7.4.1-Table71 · 印刷p.277 / PDFp.298
[EXTRA] 表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。
[EXTRA] 4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。
[EXTRA] 只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。
[EXTRA] 实际覆盖范围：仅覆盖 scalarLift, symmetricHarmonicStep, symmetricInvariant, table71 所列对象、量词、前提和结论。范围说明：Fin 4 的方案0,1,2,3依次为 ABOBA,OBABO,BAOAB,OABAO。依赖中各复合从右向左执行，两个 O/2 子步使用独立 R,S。h²Ω²<4m 保证表内正因子；三项结论逐行覆盖表7.1的两个比值与零混合矩。hinv 是实际概率推前不变性及 L²，并未假设表内矩值。 -/
def scalarLift (F : Phase 1 → Phase 1) (x : ℝ × ℝ) : ℝ × ℝ :=
  let y := F ((fun _ ↦ x.1),(fun _ ↦ x.2))
  (y.1 0,y.2 0)

def symmetricHarmonicStep (scheme : Fin 4) (m Ω γ θ h : ℝ) (R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if scheme = 0 then aboba masses U γ θ h (fun _ ↦ R)
    else if scheme = 1 then obabo masses U γ θ h (fun _ ↦ R) (fun _ ↦ S)
    else if scheme = 2 then baoab masses U γ θ h (fun _ ↦ R)
    else oabao masses U γ θ h (fun _ ↦ R) (fun _ ↦ S))

def symmetricInvariant (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ symmetricHarmonicStep scheme m Ω γ θ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

theorem table71 (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hinv : symmetricInvariant scheme m Ω γ θ h μ) :
    momentQ μ/(θ/Ω^2) = (if scheme = 1 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 3 then 1-h^2*Ω^2/(4*m) else 1) ∧
    momentP μ/(θ*m) = (if scheme = 0 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 2 then 1-h^2*Ω^2/(4*m) else 1) ∧ momentQP μ = 0 := by
  sorry

/-- source_id: MD-7.4.1-NonsymmetricExactMoments · 印刷p.277 / PDFp.298
[EXTRA] AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。
[EXTRA] 本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。
[EXTRA] 29号覆盖限定：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。
[EXTRA] 实际覆盖范围：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。 -/
def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m ∧
    (∫ x, x.1*x.2 ∂μ) = (if flip then -θ*h/2 else θ*h/2) := by
  sorry

theorem nonsymmetricMixedMoment_order (θ : ℝ) (flip : Bool) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ if flip then -θ*h/2 else θ*h/2) (fun h : ℝ ↦ h) := by
  sorry

/-- source_id: MD-7.4.2-BBKStar · 印刷p.277–278 / PDFp.298–299
[EXTRA] R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。
[EXTRA] 实际覆盖范围：仅覆盖 bbkStarTrajectory, bbkStarNoise 所列对象、量词、前提和结论。范围说明：递归基点为 x0；第 k 次更新用 R k 与 R(k+1)，精确实现上一步末尾噪声在下一步开头重用。bbkStarNoise 记录 (κ1R,κ2R+κ3S)。R 是任意序列的确定性输入，此定义不宣称其本身具有标准正态或 iid 性；随机解释需要 JSON 已列出的 iid 假设。 -/
def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)

/-- source_id: MD-7.4.2-BBKStarCorrelations · 印刷p.278 / PDFp.299
[EXTRA] Qold/Pold代表吸收R_{n-1}后仍独立于未来R_n,R_{n+1}的旧状态组合；不把当前p与R_n假设独立。
[EXTRA] 所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。
[EXTRA] 实际覆盖范围：仅覆盖 bbkStarCorrelations 所列对象、量词、前提和结论。范围说明：七个相关矩逐项与原页相同。标准正态边缘、R与S独立、旧状态二元组与未来噪声二元组独立，以及旧状态 L² 足够。q=aQold+bPold 不含 R；p=cQold+dPold+κ3R 含当前噪声，因而保留了所需 κ1κ3 和 κ2κ3。该局部模型未自动证明由完整历史产生的旧状态满足这些资格。 -/
theorem bbkStarCorrelations (P : Measure Ω) [IsProbabilityMeasure P]
    (R S Qold Pold : Ω → ℝ) (a b c d κ1 κ2 κ3 : ℝ)
    (hR : HasLaw R (gaussianReal 0 1) P) (hS : HasLaw S (gaussianReal 0 1) P)
    (hind : IndepFun (fun sample ↦ (Qold sample,Pold sample)) (fun sample ↦ (R sample,S sample)) P)
    (hRS : IndepFun R S P) (hq : MemLp Qold 2 P) (hp : MemLp Pold 2 P) :
    let q := fun sample ↦ a*Qold sample+b*Pold sample
    let p := fun sample ↦ c*Qold sample+d*Pold sample+κ3*R sample
    let u := fun sample ↦ κ1*R sample
    let v := fun sample ↦ κ2*R sample+κ3*S sample
    (∫ sample, v sample*p sample ∂P) = κ2*κ3 ∧
    (∫ sample, u sample*q sample ∂P) = 0 ∧
    (∫ sample, v sample*q sample ∂P) = 0 ∧
    (∫ sample, u sample*p sample ∂P) = κ1*κ3 ∧
    (∫ sample, (u sample)^2 ∂P) = κ1^2 ∧
    (∫ sample, u sample*v sample ∂P) = κ1*κ2 ∧
    (∫ sample, (v sample)^2 ∂P) = κ2^2+κ3^2 := by
  sorry

/-- source_id: MD-7.4.2-BBKStarMomentSystemPrinted · 印刷p.278–279 / PDFp.299–300
[EXTRA] PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。
[EXTRA] 29号覆盖限定：保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。
[EXTRA] 实际覆盖范围：保留三条原印矩方程及修正系数；原页混合矩重复ψ因子已目视确认，未从相关噪声过程重新证明整组矩方程。
[ERRATUM?] 已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。 -/
def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num

/-- source_id: MD-7.4.2-BBKStarStationary · 印刷p.279 / PDFp.300
[EXTRA] 只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。
[EXTRA] 实际覆盖范围：仅覆盖 bbkStarStationaryAlgebra 所列对象、量词、前提和结论。范围说明：hsys 明确采用 corrected 方程；四个矩阵投影与三项 κ 系数均与 bbkMatrix/bbkNoise 一致。正参数及 h²Ω²<4m 排除退化分母，结论与原页三个平稳观测值相符。该声明只求解代数方程组，未从跨步相关的实际平稳分布导出 hsys；JSON 已如实披露，不能据此宣称 BBK* 分布理论已完成。 -/
theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry

/-- source_id: MD-7.5-PerturbedHamiltonian · 印刷p.279 / PDFp.300
[EXTRA] 后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。
[EXTRA] 分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。
[EXTRA] 实际覆盖范围：仅覆盖 perturbedPotential, perturbedHamiltonian, perturbedGibbs, perturbedStep, perturbedStationary 所列对象、量词、前提和结论。范围说明：势、Hamiltonian 与(7.13)完全一致。perturbedGibbs 是单位温度归一权密度的定义；ε>0 时的可积性和归一性不是该定义自身的定理。方案顺序0,1,2,3为 ABOBA,BAOAB,OBABO,OABAO，和后两条一致；perturbedStationary 正确使用独立两份标准正态及 L² 不变概率分布。 -/
def perturbedPotential (ε q : ℝ) : ℝ := q^2/2+ε*q^4/4
def perturbedHamiltonian (ε : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/2+perturbedPotential ε x.1
def perturbedGibbs (ε : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-perturbedHamiltonian ε x)
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def perturbedStep (s : Fin 4) (ε γ h R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let m : V 1 := fun _ ↦ 1
  let U : V 1 → ℝ := fun q ↦ perturbedPotential ε (q 0)
  scalarLift (if s = 0 then aboba m U γ 1 h (fun _ ↦ R)
    else if s = 1 then baoab m U γ 1 h (fun _ ↦ R)
    else if s = 2 then obabo m U γ 1 h (fun _ ↦ R) (fun _ ↦ S)
    else oabao m U γ 1 h (fun _ ↦ R) (fun _ ↦ S))
def perturbedStationary (s : Fin 4) (ε γ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ perturbedStep s ε γ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

/-- source_id: MD-7.5-PerturbedErrorExpansion · 印刷p.280 / PDFp.301
[EXTRA] 原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。
[EXTRA] 实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。
[EXTRA] 29号覆盖限定：(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。
[EXTRA] 实际覆盖范围：(7.14)作为待证严格双参数渐近目标；不变测度选择、矩与统一余项资格不足，原书此处是形式展开而非已证严格估计。 -/
def perturbedLeading (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then 3*h^2*ε*(48*ε-4+3*γ^2*(9*ε-1))/(12*γ^2+16)
  else if s = 1 then -9*h^2*ε^2/(6*γ^2+8)-3*h^4*ε^2*(6*γ^4+19*γ^2+16)/(8*(3*γ^2+4)^2)
  else if s = 2 then h^2*(1/4+ε*(144*ε+81*ε*γ^2-9*γ^2-12)/(12*γ^2+16))
  else -h^2*(1/4+18*ε^2/(12*γ^2+16))
def perturbedRemainder (s : Fin 4) (ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^4+ε^3*h^2
  else if s = 1 then ε^2*h^6+ε^3*h^2 else h^4+ε^3*h^2
def positivePairLimit : Filter (ℝ × ℝ) :=
  𝓝[Set.Ioi (0 : ℝ) ×ˢ Set.Ioi (0 : ℝ)] (0,0)
theorem perturbedErrorExpansion (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)-perturbedLeading s γ z.1 z.2)
      (fun z ↦ perturbedRemainder s z.1 z.2) := by
  sorry

/-- source_id: MD-7.5-PerturbedErrorOrders · 印刷p.280 / PDFp.301
[EXTRA] 29号覆盖限定：固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。
[EXTRA] 实际覆盖范围：固定γ>0时(7.14)的余项足以推出(7.15)阶；γ一致常数或整个误差在γ→∞消失另需控制ε³h²项，不将固定γ和一致γ结论混淆。 -/
def perturbedErrorScale (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^2 else if s = 1 then ε^2*h^2/(1+γ^2)+ε^2*h^4 else h^2
theorem perturbedErrorOrders (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ |momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)|)
      (fun z ↦ perturbedErrorScale s γ z.1 z.2) := by
  sorry
theorem baoabLeading_largeFriction (ε h : ℝ) :
    Filter.Tendsto (fun γ : ℝ ↦ -9*h^2*ε^2/(6*γ^2+8)) Filter.atTop (𝓝 0) := by
  sorry

/-- source_id: MD-7.6-GibbsComposition · 印刷p.282 / PDFp.303
[EXTRA] 只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。
[EXTRA] 29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。
[EXTRA] 实际覆盖范围：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。 -/
theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]

/-- source_id: MD-7.6-DivergenceFreeInvariant · 印刷p.282 / PDFp.303
[EXTRA] 微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。
[EXTRA] 不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。
[EXTRA] 29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。
[EXTRA] 实际覆盖范围：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。 -/
def lieField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  (fderiv ℝ ρ x) (f x)
def divergenceField (f : V n → V n) (x : V n) : ℝ :=
  ∑ i, coordDerivative (fun y ↦ f y i) x i
def forwardField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  -∑ i, coordDerivative (fun y ↦ f y i*ρ y) x i
theorem divergenceFreeInvariant (f : V n → V n) (ρ : V n → ℝ)
    (hf : ContDiff ℝ 1 f) (hρ : ContDiff ℝ 1 ρ)
    (hdiv : ∀ x, divergenceField f x = 0) : ∀ x, forwardField f ρ x = -lieField f ρ x := by
  sorry
theorem firstIntegral_density (f : V n → V n) (I : V n → ℝ) (g : ℝ → ℝ)
    (hI : Differentiable ℝ I) (hg : Differentiable ℝ g)
    (hfirst : ∀ x, lieField f I x = 0) : ∀ x, lieField f (g ∘ I) x = 0 := by
  intro x
  rw [lieField, fderiv_comp x (hg (I x)) (hI x)]
  simp only [ContinuousLinearMap.comp_apply]
  change (fderiv ℝ g (I x)) (lieField f I x) = 0
  rw [hfirst x, map_zero]

/-- source_id: MD-7.6-GeMarsdenRestriction · 印刷p.282 / PDFp.303
[EXTRA] 原文引用的Ge–Marsden定理未列非可积性、局部性及精确流的全部技术条件；仅定义其非可积性和结论形式，未把geMarsdenConclusion宣称为真。
[EXTRA] 辛映射体积保持和Ge–Marsden结论均列入本条覆盖缺口，不能把该定义当成定理已证。
[EXTRA] 29号覆盖限定：只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。
[EXTRA] 实际覆盖范围：只定义全部光滑第一积分全局依赖H、任意时间重参数和辛保能蕴涵目标；未连结精确哈密顿流、非退化时间变换及定理适用域，未声明Ge–Marsden定理已形式化。 -/
def onlyEnergyIntegrals (H : V n → ℝ) (f : V n → V n) : Prop :=
  ∀ I : V n → ℝ, ContDiff ℝ ⊤ I → (∀ x, lieField f I x = 0) →
    ∃ g : ℝ → ℝ, I = g ∘ H
def timeReparametrizes {E : Type*} (G flow : ℝ → E → E) : Prop :=
  ∃ τ : ℝ → E → ℝ, ∀ h x, G h x = flow (τ h x) x
def geMarsdenConclusion {k : ℕ}
    (H : MolecularDynamics.SymplecticCoordinates k → ℝ)
    (G flow : ℝ → MolecularDynamics.SymplecticCoordinates k → MolecularDynamics.SymplecticCoordinates k) : Prop :=
  MolecularDynamics.Chapter02Review.symplecticIntegrator G →
  (∀ h x, H (G h x) = H x) → timeReparametrizes G flow

/-- source_id: MD-7.6-JSplitting · 印刷p.282–283 / PDFp.303–304
[EXTRA] Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。
[EXTRA] 体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。
[EXTRA] 29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。
[EXTRA] 实际覆盖范围：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。 -/
def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]

theorem jField_finiteDecomposition {K : ℕ} (J : Fin K → Matrix (Fin n) (Fin n) ℝ)
    (H : V n → ℝ) (hJ : ∀ k i j, J k i j = -J k j i) :
    jField (∑ k, J k) H = fun x ↦ ∑ k, jField (J k) H x := by
  sorry

/-- source_id: MD-7.6-CoordinateJSplitting · 印刷p.283 / PDFp.304
[EXTRA] 完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。
[EXTRA] 29号覆盖限定：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。
[EXTRA] 实际覆盖范围：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。 -/
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)

def coordinateJQualification (m : V n) (U : V n → ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 U

theorem frozenPotential_deriv (m : V n) (U : V n → ℝ)
    (hq : coordinateJQualification m U) (q : V n) (i : Fin n) :
    deriv (frozenPotential U q i) (q i) = gradient U q i := rfl

/-- source_id: MD-7.7-ModifiedGenerator · 印刷p.284 / PDFp.305
[EXTRA] 只取形式幂级数系数；O(h⁴)在此意为0–3阶系数相等，不宣称无界算符级数收敛，也不声称是另一SDE的生成元。
[EXTRA] 实际覆盖范围：仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。 -/
def formalModifiedGenerator {R : Type*} [Ring R] [Algebra ℝ R]
    (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun k ↦ PowerSeries.coeff (k+1) (MolecularDynamics.textbookFormalOperatorLogarithm S))
def formalGeneratorExpansion {R : Type*} [Ring R] [Algebra ℝ R]
    (L : PowerSeries R) (L0 L1 L2 L3 : R) : Prop :=
  PowerSeries.coeff 0 L = L0 ∧ PowerSeries.coeff 1 L = L1 ∧
  PowerSeries.coeff 2 L = L2 ∧ PowerSeries.coeff 3 L = L3

/-- source_id: MD-7.7-InvariantDensityExpansion · 印刷p.284 / PDFp.305
[EXTRA] 系数零质量不等于任意h的截断密度非负；概率密度仍须非负、可积且归一。余项质量也为零或完整级数可交换积分时才推出精确总质量一致。
[EXTRA] 此处证明所有形式系数的质量约束；未把有限截断表达式假称实际不变概率。
[EXTRA] 实际覆盖范围：仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。 -/
def densityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => ρ
  | k+1 => fun x ↦ ρ x*f (k+1) x
def centeredCorrections (μ : Measure Ω) (f : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ k, 0 < k → Integrable (f k) μ ∧ (∫ x, f k x ∂μ) = 0
def computedAverage (ν : Measure Ω) (φ ρhat : Ω → ℝ) : ℝ := ∫ x, φ x*ρhat x ∂ν
theorem densityExpansion_zeroMass (ν : Measure Ω) (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ)
    (hρ : Integrable ρ ν)
    (hf : ∀ k, 0 < k → Integrable (fun x ↦ ρ x*f k x) ν ∧ (∫ x, ρ x*f k x ∂ν) = 0) :
    ∀ k, (∫ x, densityExpansion ρ f k x ∂ν) = if k = 0 then ∫ x, ρ x ∂ν else 0 := by
  intro k
  cases k with
  | zero => simp [densityExpansion]
  | succ k => simpa [densityExpansion] using (hf (k+1) (Nat.zero_lt_succ k)).2

/-- source_id: MD-7.7.1-ExactABOPropagators · 印刷p.285 / PDFp.306
[EXTRA] O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。
[EXTRA] 半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。
[EXTRA] 实际覆盖范围：仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。 -/
def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)

/-- source_id: MD-7.7.1-OperatorOrderReversal · 印刷p.285 / PDFp.306
[EXTRA] 覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。
[EXTRA] 伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。
[EXTRA] 29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。
[EXTRA] 实际覆盖范围：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。 -/
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))

theorem fourStage_duality {E : Type*} [AddCommGroup E] [Module ℝ E]
    (pair : E → E → ℝ) (A B C D a b c d : Module.End ℝ E)
    (hA : ∀ x y, pair (A x) y = pair x (a y))
    (hB : ∀ x y, pair (B x) y = pair x (b y))
    (hC : ∀ x y, pair (C x) y = pair x (c y))
    (hD : ∀ x y, pair (D x) y = pair x (d y)) (x y : E) :
    pair (A (B (C (D x)))) y = pair x (d (c (b (a y)))) := by
  rw [hA,hB,hC,hD]

/-- source_id: MD-7.7.1-StationaryModifiedPDE · 印刷p.285–286 / PDFp.306–307
[EXTRA] 真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。
[EXTRA] Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。
[EXTRA] 29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。
[EXTRA] 实际覆盖范围：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。 -/
def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0

/-- source_id: MD-7.7.1-TwoOperatorBCH · 印刷p.286 / PDFp.307
[EXTRA] 任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。
[EXTRA] 实际覆盖范围：仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。 -/
def comm {R : Type*} [Ring R] (X Y : R) : R := X*Y-Y*X
def twoStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential X * MolecularDynamics.textbookFormalOperatorExponential Y
theorem twoOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (twoStage X Y)) = X+Y ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (twoStage X Y)) = (1/2 : ℝ) • comm X Y ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (twoStage X Y)) =
      (1/12 : ℝ) • (comm X (comm X Y)+comm Y (comm Y X)) := by
  sorry

/-- source_id: MD-7.7.1-TaylorRemainder · 印刷p.286–287 / PDFp.307–308
[EXTRA] 只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。
[EXTRA] 29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。
[EXTRA] 实际覆盖范围：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。 -/
theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry

theorem propagatedObservable_remainder {E : Type*} (P : ℝ → (E → ℝ) → E → ℝ)
    (φ : E → ℝ) (z : E) (k : ℕ)
    (htime : ContDiff ℝ (k+1) (fun t ↦ P t φ z)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ P h φ z-∑ j ∈ Finset.range (k+1),
        h^j/(Nat.factorial j : ℝ)*iteratedDeriv j (fun t ↦ P t φ z) 0)
      (fun h ↦ h^(k+1)) := taylorRemainder_bound _ k htime

/-- source_id: MD-7.7.2-ThreeOperatorBCH · 印刷p.287 / PDFp.308
[EXTRA] 完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。
[EXTRA] 实际覆盖范围：仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。 -/
def threeStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential Z *
    MolecularDynamics.textbookFormalOperatorExponential Y * MolecularDynamics.textbookFormalOperatorExponential X
theorem threeOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (threeStage X Y Z)) = X+Y+Z ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/2 : ℝ) • (comm Z Y+comm Z X+comm Y X) ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/4 : ℝ) • comm Z (comm Y X)+(1/12 : ℝ) •
        (comm Y (comm Y X)+comm X (comm X Y)+comm Z (comm Z Y)+
          comm Z (comm Z X)+comm (Y+X) (comm (Y+X) Z)) := by
  sorry

/-- source_id: MD-7.7.2-ScalarForwardOperators · 印刷p.288 / PDFp.309
[EXTRA] 所有偏导都是实际deriv，单位质量、θ=k_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。
[EXTRA] 实际覆盖范围：仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。 -/
abbrev Density1 := (ℝ × ℝ) → ℝ
def dq (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun q ↦ f (q,x.2)) x.1
def dp (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun p ↦ f (x.1,p)) x.2
def opA (f : Density1) (x : ℝ × ℝ) : ℝ := -x.2*dq f x
def opB (U : ℝ → ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := deriv U x.1*dp f x
def opO (γ θ : ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := γ*(f x+x.2*dp f x)+γ*θ*dp (dp f) x
def opLD (U : ℝ → ℝ) (γ θ : ℝ) (f : Density1) : Density1 := opA f+opB U f+opO γ θ f
def opComm (A B : Density1 → Density1) (f : Density1) : Density1 := A (B f)-B (A f)

/-- source_id: MD-7.7.2-CommutatorAB · 印刷p.288 / PDFp.309
[EXTRA] 实际覆盖范围：仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。 -/
theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry

/-- source_id: MD-7.7.2-CommutatorsAOBO · 印刷p.289 / PDFp.310
[EXTRA] 实际覆盖范围：仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。 -/
theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry

/-- source_id: MD-7.7.2-OBAModifiedOperator · 印刷p.288–289 / PDFp.309–310
[EXTRA] 只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。
[EXTRA] 29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。
[EXTRA] 实际覆盖范围：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。 -/
def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring

/-- source_id: MD-7.7.2-SpectralQualification · 印刷p.289 / PDFp.310
[EXTRA] 只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
[EXTRA] 29号覆盖限定：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。
[EXTRA] 实际覆盖范围：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。
[ERRATUM?] 已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。 -/
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)

def spectralConclusionPrinted {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop := printedSpectralConclusion L ρ

def spectralConclusionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧
  (∀ v : E, L v = 0 → v ∈ Submodule.span ℂ ({ρ} : Set E)) ∧
  ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    FiniteDimensional ℂ (Module.End.eigenspace L eigen) ∧ (eigen = 0 ∨ eigen.re < 0)

/-- source_id: MD-7.7.3-PerturbationCoefficientEquation · 印刷p.289–290 / PDFp.310–311
[EXTRA] 在真实线性作用的形式系数卷积上推导0阶和1阶必要方程；并未由这些必要方程证明原离散链存在不变分布。
[EXTRA] 实际覆盖范围：仅覆盖 actionCoefficient, perturbationCoefficientEquation 所列对象、量词、前提和结论。范围说明：actionCoefficient取j=0,…,k的线性作用卷积Lj(ρ(k−j))；k=0仅L0ρ0，k=1为L0ρ1+L1ρ0。定理以这两个系数为0为前提准确给出两条结论。实例化ρ0=ρβ、ρ1=ρβf1、L0=LLD†、L1=一阶扰动即为原式。假设与必要条件没有偷换为不变密度存在性，也未假定各系数算子可交换。 -/
def actionCoefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E) (k : ℕ) : E :=
  ∑ j ∈ Finset.range (k+1), L j (ρ (k-j))
theorem perturbationCoefficientEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (h0 : actionCoefficient L ρ 0 = 0) (h1 : actionCoefficient L ρ 1 = 0) :
    L 0 (ρ 0) = 0 ∧ L 0 (ρ 1)+L 1 (ρ 0) = 0 := by
  constructor
  · simpa [actionCoefficient] using h0
  · simpa [actionCoefficient, Finset.sum_range_succ] using h1

/-- source_id: MD-7.7.3-ObservableCorrectionExpansion · 印刷p.290 / PDFp.311
[EXTRA] 完整覆盖0–2阶有限截断积分；无限级数交换与实际误差余项仍需支配收敛及弱展开理论，明确不声称已证。
[EXTRA] 实际覆盖范围：仅覆盖 observableCorrectionExpansion 所列对象、量词、前提和结论。范围说明：observableCorrectionExpansion针对任意实h和三项分别可积的φρ、φρf1、φρf2，给出完整0–2阶截断积分线性性等式。乘法顺序因实标量交换而无差别；不需概率性或fk零均值。它不证明无限求和交换积分或实际h误差；extra_assumptions已清楚限定有限形式阶数，在这一明确范围内签名PASS。 -/
theorem observableCorrectionExpansion (ν : Measure Ω) (φ ρ f1 f2 : Ω → ℝ) (h : ℝ)
    (h0 : Integrable (fun x ↦ φ x*ρ x) ν)
    (h1 : Integrable (fun x ↦ φ x*ρ x*f1 x) ν)
    (h2 : Integrable (fun x ↦ φ x*ρ x*f2 x) ν) :
    (∫ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) ∂ν) =
      (∫ x, φ x*ρ x ∂ν)+h*(∫ x, φ x*ρ x*f1 x ∂ν)+h^2*(∫ x, φ x*ρ x*f2 x ∂ν) := by
  have heq : ∀ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) =
      (φ x*ρ x+h*(φ x*ρ x*f1 x))+h^2*(φ x*ρ x*f2 x) := by intro x; ring
  simp_rw [heq]
  have hout := integral_add (h0.add (h1.const_mul h)) (h2.const_mul (h^2))
  have hin := integral_add h0 (h1.const_mul h)
  simp only [Pi.add_apply] at hout hin
  rw [hout, hin, integral_const_mul, integral_const_mul]

/-- source_id: MD-7.7.3-PerturbativeSolvabilityCaution · 印刷p.290 / PDFp.311
[EXTRA] 原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。
[EXTRA] 不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。
[EXTRA] 29号覆盖限定：仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。
[EXTRA] 实际覆盖范围：仅rhs属于线性映射值域的目标定义；没有ρf结构、零质量相容性、闭生成元域或半群/谱隙，原文预期不作定理。 -/
def correctionSolvable {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (rhs : E) : Prop := ∃ u : E, L u = rhs

/-- source_id: MD-7.8-FirstOrderOperator · 印刷p.291 / PDFp.312
[EXTRA] 前向组合采用Z,Y,X顺序；正式级数系数推论覆盖所有六个排列，L0为三者和。修正方程为必要形式方程，可解性独立。
[EXTRA] 实际覆盖范围：仅覆盖 firstOrderOperator, firstOrderOperator_coefficient, correctionEquation 所列对象、量词、前提和结论。范围说明：C：firstOrderOperator 对任意实代数（允许非交换环）准确给出(7.20)。threeStage=exp Z*exp Y*exp X，log的二阶系数为−([X,Y]+[X,Z]+[Y,Z])/2，firstOrderOperator_coefficient的次序与符号正确。correctionEquation在任意实模上线性地表达L(ρf)=−L1ρ；ρf是独立输入的乘积密度对象，未冒充可解性定理。没有引入算符收敛断言；这属于已登记的形式级数解释。sorry不参与本次判定。 -/
def firstOrderOperator {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : R :=
  (-1/2 : ℝ) • (comm X Y+comm X Z+comm Y Z)
theorem firstOrderOperator_coefficient {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) = firstOrderOperator X Y Z := by
  sorry
def correctionEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L L1 : Module.End ℝ E) (ρ ρf : E) : Prop := L ρf = -L1 ρ

/-- source_id: MD-7.8-HomogeneousNormalization · 印刷p.291 / PDFp.312
[EXTRA] 核恰为ρ的一维空间是明确前提；不把Langevin核唯一性当作已证明。第二条为实际概率归一化的中心化恒等式。
[EXTRA] 实际覆盖范围：仅覆盖 homogeneousNormalization, centeredParticular 所列对象、量词、前提和结论。范围说明：C：homogeneousNormalization在任意实模上从L(u−v)=0推出u=v+cρ，完全符合密度层面的通解差；不把未证明的Langevin核唯一性藏入结论。centeredParticular表达∫(f−∫f)=0，概率质量1和可积性均明确。由Gibbs权严格正可将密度差还原成修正函数相差常数；本条采用抽象密度表述及独立中心化恒等式的范围已明示，签名无错误。 -/
theorem homogeneousNormalization {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ u v rhs : E)
    (hker : ∀ w, L w = 0 → ∃ c : ℝ, w = c • ρ)
    (hu : L u = rhs) (hv : L v = rhs) : ∃ c : ℝ, u = v+c • ρ := by
  obtain ⟨c,hc⟩ := hker (u-v) (by rw [map_sub,hu,hv,sub_self])
  exact ⟨c,by rw [← hc]; abel⟩
theorem centeredParticular (μ : Measure Ω) [IsProbabilityMeasure μ] (f : Ω → ℝ)
    (hf : Integrable f μ) : (∫ x, f x-(∫ y, f y ∂μ) ∂μ) = 0 := by
  rw [integral_sub hf (integrable_const _)]
  simp

/-- source_id: MD-7.8.1-CommutatorPermutationRelations · 印刷p.292 / PDFp.313
[EXTRA] 实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。
[EXTRA] 29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。
[EXTRA] 实际覆盖范围：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。 -/
theorem commutatorPermutationRelations {E : Type*} [AddCommGroup E] [Module ℝ E]
    (A B O : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (A+B) ρ = 0) :
    (comm O A+comm O B) ρ = 0 ∧
    firstOrderOperator A B O ρ = firstOrderOperator O A B ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator O B A ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator B A O ρ ∧
    firstOrderOperator A B O ρ = (-1/2 : ℝ) • comm A B ρ ∧
    firstOrderOperator A O B ρ = -firstOrderOperator B O A ρ ∧
    firstOrderOperator A O B ρ = (-1/2 : ℝ) • comm (A-B) O ρ+firstOrderOperator A B O ρ := by
  sorry

/-- source_id: MD-7.8.1-GibbsDerivativeIdentities · 印刷p.292–293 / PDFp.313–314
[EXTRA] ρ为未归一Gibbs权，所有微分等式对常数归一化同样成立；实际概率还要正有限配分积分。所有质量正、β>0、光滑资格明示。
[EXTRA] 覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。
[EXTRA] 29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。
[EXTRA] 实际覆盖范围：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。 -/
def mechanicalHamiltonian (m : V n) (U : V n → ℝ) (x : Phase n) : ℝ :=
  (∑ i, x.2 i^2/(2*m i))+U x.1
def gibbsWeight (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  Real.exp (-β*mechanicalHamiltonian m U x)
def gFunction (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*∑ i, x.2 i/m i*gradient U x.1 i
def phaseO (m : V n) (γ β : ℝ) (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ouForward m γ β⁻¹ (fun p ↦ ρ (x.1,p)) x.2
def phaseLD (m : V n) (U : V n → ℝ) (γ β : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  aForward m ρ+bForward U ρ+phaseO m γ β ρ
theorem gibbsDerivativeIdentities (m : V n) (U ψ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) (hψ : ContDiff ℝ ⊤ ψ) :
    let ρ := gibbsWeight m U β
    let g := gFunction m U β
    aForward m ρ = g*ρ ∧ bForward U ρ = -(g*ρ) ∧
    phaseLD m U γ β (fun x ↦ ψ x.1*ρ x) =
      (fun x ↦ -(∑ i, x.2 i/m i*gradient ψ x.1 i)*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ -γ*g x*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ γ*β*phaseLD m U γ β (fun y ↦ U y.1*ρ y) x) := by
  sorry

/-- source_id: MD-7.8.1-FirstCorrectionTablePrinted · 印刷p.293–294 / PDFp.314–315
[EXTRA] 六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。
[EXTRA] 29号覆盖限定：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。
[EXTRA] PDF314–315已目视核对原页：(7.25c)括号内为+v；旧负号是转录错误，撤销原书疑误。
[EXTRA] 实际覆盖范围：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。 -/
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 then -β/2*(γ*U x.1-v-c)
  else if s = 4 then -β/2*(γ*U x.1+v-c)
  else β/2*(γ*U x.1+v-c)
def firstCorrectionTablePrinted_corrected (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  if s = 4 then -β/2*(γ*U x.1+(∑ i, x.2 i/m i*gradient U x.1 i)-c)
  else firstCorrectionTablePrinted s m U β γ c x
theorem firstCorrection_sign_counterexample :
    (-(1 : ℝ)/2*(1-1-0)) ≠ -(1 : ℝ)/2*(1+1-0) := by norm_num
def phaseComm (A B : (Phase n → ℝ) → Phase n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := A (B ρ)-B (A ρ)
def firstCorrectionRHS (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  let A := aForward m
  let B := bForward U
  let O := phaseO m γ β
  let ops := if s = 0 then (A,B,O) else if s = 1 then (O,A,B)
    else if s = 2 then (O,B,A) else if s = 3 then (B,A,O)
    else if s = 4 then (A,O,B) else (B,O,A)
  fun x ↦ (1/2)*(phaseComm ops.1 ops.2.1 ρ x+phaseComm ops.1 ops.2.2 ρ x+phaseComm ops.2.1 ops.2.2 ρ x)
theorem firstCorrectionTable_pde (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    phaseLD m U γ β (fun x ↦ firstCorrectionTablePrinted_corrected s m U β γ c x*gibbsWeight m U β x) =
      firstCorrectionRHS s m U β γ (gibbsWeight m U β) := by
  sorry

/-- source_id: MD-7.8.1-PositionMomentumCorrections · 印刷p.294–295 / PDFp.315–316
[EXTRA] 产品Gibbs实际含位置概率及独立中心Gaussian动量；所有显示期望需可积，未把待求修正值作为假设。
[EXTRA] 六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。
[EXTRA] 实际覆盖范围：仅覆盖 positionGibbs, momentumGibbs, productGibbs, positionMomentumCorrections 所列对象、量词、前提和结论。范围说明：C：positionGibbs是真实归一位置权；hprob明确保证其质量1而不依赖未经说明的配分函数资格。momentumGibbs为方差m_i/β的独立中心高斯，正质量及正β排除非物理退化。productGibbs保留(q,p)次序。U、ψ、χ、各梯度及所有六种加权修正期望可积均有明示前提；动量均值零消去位置观测的v项，独立性与c=γ〈U〉消去动量观测的γ项。所有s、两条积分结论与符号正确。无大摩擦统一余项的虚假结论。 -/
def positionGibbs (U : V n → ℝ) (β : ℝ) : Measure (V n) :=
  volume.withDensity (fun q ↦ ENNReal.ofReal (Real.exp (-β*U q)/(∫ y, Real.exp (-β*U y))))
def momentumGibbs (m : V n) (β : ℝ) : Measure (V n) := Measure.pi (fun i ↦ gaussianReal 0 (Real.toNNReal (m i/β)))
def productGibbs (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  (positionGibbs U β).prod (momentumGibbs m β)
theorem positionMomentumCorrections (m : V n) (U ψ χ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hU : Integrable U (positionGibbs U β))
    (hψ : Integrable ψ (positionGibbs U β)) (hχ : Integrable χ (momentumGibbs m β))
    (hgrad : ∀ i, Integrable (fun q ↦ gradient U q i) (positionGibbs U β))
    (hint : ∀ s : Fin 6,
      Integrable (fun x ↦ ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β) ∧
      Integrable (fun x ↦ χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β)) :
    ∀ s : Fin 6, let sign : ℝ := if s = 0 ∨ s = 1 ∨ s = 5 then 1 else -1
    let vsign : ℝ := if s = 0 ∨ s = 1 ∨ s = 4 then -1 else 1
    (∫ x, ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      sign*γ*β/2*∫ q, (U q-(∫ y, U y ∂positionGibbs U β))*ψ q ∂positionGibbs U β ∧
    (∫ x, χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      vsign*β/2*∫ x, (∑ i, x.2 i/m i*gradient U x.1 i)*χ x.2 ∂productGibbs m U β := by
  sorry

/-- source_id: MD-7.8.1-OverdampedFirstOrderCaution · 印刷p.295 / PDFp.316
[EXTRA] 覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。
[EXTRA] 29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。
[EXTRA] 实际覆盖范围：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。 -/
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
    Filter.Tendsto (fun γ : ℝ ↦ aoab m U γ θ h R x) Filter.atTop (𝓝 (aoabInfiniteFriction m U θ h R x)) := by
  sorry

/-- source_id: MD-7.8.2-BiasedDoubleWellExact · 印刷p.295–297 / PDFp.316–318
[EXTRA] 保留数值例中的精确数学积分和解析消项；原文虽起初β=1，推导中保留β，本条正β形式需同样积分分部理论。
[EXTRA] 中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。
[EXTRA] 29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。
[EXTRA] 实际覆盖范围：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。 -/
def biasedDoubleWell (q : ℝ) : ℝ := (q^2-1)^2+q/2
def doubleWellObservable (x : ℝ × ℝ) : ℝ := x.2^2-x.1*deriv biasedDoubleWell x.1+2*x.1*x.2
def doubleWellGibbs (β : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-β*(x.2^2/2+biasedDoubleWell x.1))
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def doubleWellBOACorrection (β γ : ℝ) (x : ℝ × ℝ) : ℝ :=
  β/2*(x.2*deriv biasedDoubleWell x.1+γ*biasedDoubleWell x.1-
    γ*(∫ y, biasedDoubleWell y.1 ∂doubleWellGibbs β))
theorem doubleWellExact (β γ : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x ∂doubleWellGibbs β) = 0 ∧
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β γ x ∂doubleWellGibbs β) = (2-γ)/(2*β) := by
  sorry
theorem doubleWellCritical (β : ℝ) : (2-(2 : ℝ))/(2*β) = 0 := by ring

theorem doubleWellCritical_integral (β : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β 2 x ∂doubleWellGibbs β) = 0 := by
  simpa using (doubleWellExact β 2 hβ).2

/-- source_id: MD-7.9-Proposition71 · 印刷p.297 / PDFp.318
[EXTRA] 桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。
[EXTRA] 实际覆盖范围：仅覆盖 proposition71, symmetricOddCorrections 所列对象、量词、前提和结论。范围说明：C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。 -/
theorem proposition71 {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    ∃ Q : PowerSeries R, MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z =
      PowerSeries.C (X+Y+Z)+
      PowerSeries.C (MolecularDynamics.textbookSymmetricOperatorCorrection X Y Z)*PowerSeries.X^2+
      PowerSeries.X^4*Q := MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71 X Y Z
theorem symmetricOddCorrections {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) (k : ℕ) :
    PowerSeries.coeff (2*k+1) (MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z) = 0 :=
  MolecularDynamics.textbookSymmetricModifiedGenerator_odd_coeff_zero X Y Z k

/-- source_id: MD-7.9-EvenDensityPerturbation · 印刷p.298 / PDFp.319
[EXTRA] 系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。
[EXTRA] 29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。
[EXTRA] 实际覆盖范围：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。 -/
def evenDensityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) (k : ℕ) : Ω → ℝ :=
  if k = 0 then ρ else if Even k then fun x ↦ ρ x*f k x else 0
theorem evenPerturbationEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (hL1 : L 1 = 0) (hρ1 : ρ 1 = 0) (h2 : actionCoefficient L ρ 2 = 0) :
    L 0 (ρ 2) = -L 2 (ρ 0) := by
  have he : L 0 (ρ 2)+L 2 (ρ 0) = 0 := by
    simpa [actionCoefficient,Finset.sum_range_succ,hL1,hρ1] using h2
  exact eq_neg_of_add_eq_zero_left he

/-- source_id: MD-7.9.1-OYZYOInhomogeneity · 印刷p.298–299 / PDFp.319–320
[EXTRA] 实际覆盖范围：仅覆盖 oyzyoInhomogeneity 所列对象、量词、前提和结论。范围说明：C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。 -/
theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry

/-- source_id: MD-7.9.1-TripleCommutatorPrinted · 印刷p.299 / PDFp.320
[EXTRA] M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。
[EXTRA] 29号覆盖限定：字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。
[EXTRA] 实际覆盖范围：字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。
[ERRATUM?] 已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。 -/
def hessianU (U : V n → ℝ) (q : V n) (i j : Fin n) : ℝ := coordDerivative (fun y ↦ gradient U y j) q i
def thirdU (U : V n → ℝ) (q : V n) (i j k : Fin n) : ℝ := coordDerivative (fun y ↦ hessianU U y j k) q i
def hessianGrad (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*gradient U x.1 j
def cubicThird (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, ∑ k, thirdU U x.1 i j k*x.2 i*x.2 j*x.2 k
def tripleCommutatorPrinted (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  (2*β*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
def tripleCommutatorPrinted_corrected (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*(2*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
theorem tripleCommutator_corrected (U : V n → ℝ) (β : ℝ) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    let m : V n := fun _ ↦ 1
    let ρ := gibbsWeight m U β
    phaseComm (aForward m) (phaseComm (aForward m) (bForward U)) ρ = tripleCommutatorPrinted_corrected U β ∧
    phaseComm (bForward U) (phaseComm (bForward U) (aForward m)) ρ =
      (fun x ↦ -2*β*hessianGrad U x*ρ x) := by
  sorry
theorem tripleCommutator_factor_counterexample : (2*(2 : ℝ)*0-1) ≠ 2*(2*0-1) := by norm_num

/-- source_id: MD-7.9.1-SymmetricRHS · 印刷p.299 / PDFp.320
[EXTRA] 右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。
[EXTRA] 29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。
[EXTRA] 实际覆盖范围：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。 -/
def symmetricRHS (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/24*(if flip then 2*cubicThird U x-6*hessianGrad U x else 6*hessianGrad U x-cubicThird U x)
theorem symmetricRHS_odd (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) :
    symmetricRHS flip U β (x.1,-x.2) = -symmetricRHS flip U β x := by
  have hG : hessianGrad U (x.1,-x.2) = -hessianGrad U x := by
    simp [hessianGrad,Finset.sum_neg_distrib]
  have hT : cubicThird U (x.1,-x.2) = -cubicThird U x := by
    simp [cubicThird,Finset.sum_neg_distrib]
  cases flip <;> simp [symmetricRHS,hG,hT] <;> ring
theorem symmetricRHS_zeroMean (flip : Bool) (U : V n → ℝ) (β : ℝ)
    (hint : Integrable (symmetricRHS flip U β) (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, symmetricRHS flip U β x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry

/-- source_id: MD-7.9.1-Lemma71 · 印刷p.299–300 / PDFp.320–321
[EXTRA] 真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。
[EXTRA] 实际覆盖范围：仅覆盖 lemma71 所列对象、量词、前提和结论。范围说明：C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。 -/
theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS

/-- source_id: MD-7.9.1-ConjugateSymmetricCorrections · 印刷p.300–301 / PDFp.321–322
[EXTRA] Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。
[EXTRA] 29号覆盖限定：两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。
[EXTRA] 实际覆盖范围：两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。
[ERRATUM?] 已目视核对PDF321：所印传播子展开末项为(h²/2)L_LD，按exp的二阶展开应为(h²/8)(L_LD)²；该项作用ρβ为零，不改变后续修正关系。 -/
def gradNormSq (U : V n → ℝ) (q : V n) : ℝ := ∑ i, gradient U q i^2
def hessianQuadratic (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*x.2 j
def conjugateCorrectionChange (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/8*(gradNormSq U x.1-hessianQuadratic U x)
def conjugateCorrections (U : V n → ℝ) (β : ℝ) (fABOBA fOBABO fBAOAB fOABAO : Phase n → ℝ) : Prop :=
  fABOBA = fOBABO-conjugateCorrectionChange U β ∧ fBAOAB = fOABAO+conjugateCorrectionChange U β
theorem conjugateCorrection_coefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (p : ℕ → E) (q2 : E)
    (hL : L0 (p 0) = 0) (hp : p 1 = 0)
    (htransfer : q2 = p 2+(1/2 : ℝ) • L0 (p 1)+
      (1/4 : ℝ) • L1 (p 0)+(1/8 : ℝ) • (L0*L0) (p 0)) :
    q2 = p 2+(1/4 : ℝ) • L1 (p 0) := by
  simpa [hp,hL,Module.End.mul_apply] using htransfer

def conjugateExpansionPrinted {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/2) • L0

def conjugateExpansionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/8) • (L0*L0)

/-- source_id: MD-7.9.2-ReciprocalFrictionExpansion · 印刷p.301–302 / PDFp.322–323
[EXTRA] ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。
[EXTRA] 29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。
[EXTRA] 实际覆盖范围：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。 -/
def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0

/-- source_id: MD-7.9.2-OUKernelQualification · 印刷p.302 / PDFp.323
[EXTRA] 修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。
[EXTRA] 29号覆盖限定：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。
[EXTRA] 实际覆盖范围：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。
[ERRATUM?] 已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。 -/
def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry

theorem ouKernelCentered_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hi : Integrable f (productGibbs (fun _ ↦ 1) U β))
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0)
    (hmean : ∫ x, f x ∂productGibbs (fun _ ↦ 1) U β = 0) :
    ∃ ν : V n → ℝ, (∀ q p, f (q,p)=ν q) ∧
      Integrable ν (positionGibbs U β) ∧ (∫ q, ν q ∂positionGibbs U β)=0 := by
  sorry

/-- source_id: MD-7.9.2-OUHermiteIdentities · 印刷p.302 / PDFp.323
[EXTRA] OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。
[EXTRA] 29号覆盖限定：所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。
[EXTRA] 实际覆盖范围：所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。 -/
def laplacian (U : V n → ℝ) (q : V n) : ℝ := ∑ i, hessianU U q i i
def pGradLaplacian (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, x.2 i*gradient (laplacian U) x.1 i
def hermitePrimitive (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  6*hessianGrad U x-(1/3)*cubicThird U x-2/β*pGradLaplacian U x
theorem ouHermiteIdentities (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    let O := phaseO (fun _ ↦ 1) 1 β
    O (ρ*cubicThird U) = (fun x ↦ -3*ρ x*cubicThird U x+6*ρ x/β*pGradLaplacian U x) ∧
    O (ρ*pGradLaplacian U) = -(ρ*pGradLaplacian U) ∧
    O (ρ*hessianGrad U) = -(ρ*hessianGrad U) ∧
    (fun x ↦ -symmetricRHS false U β x*ρ x) = (fun x ↦ β/24*O (hermitePrimitive U β*ρ) x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      (fun x ↦ -(∑ i, x.2 i*gradient ν x.1 i)*ρ x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry

/-- source_id: MD-7.9.2-FirstReciprocalCorrection · 印刷p.303–304 / PDFp.324–325
[EXTRA] 给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
[EXTRA] 29号覆盖限定：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。
[EXTRA] 实际覆盖范围：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。
[ERRATUM?] 已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。 -/
def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted_corrected (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  momentumAverage β f q

def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*(gibbsWeight (fun _ ↦ 1) U β (q,p)/
    (∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x))
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry

def conjugatedPhaseH (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  phaseH U (gibbsWeight (fun _ ↦ 1) U β*f) x/gibbsWeight (fun _ ↦ 1) U β x

def jointGibbsQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ Integrable (gibbsWeight (fun _ ↦ 1) U β) volume ∧
  0 < ∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x

/-- source_id: MD-7.9.2-OverdampedSolvabilityOperators · 印刷p.304 / PDFp.325
[EXTRA] M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。
[EXTRA] 只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。
[EXTRA] 29号覆盖限定：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。
[EXTRA] 实际覆盖范围：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。 -/
def overdampedM (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  β⁻¹*laplacian ψ q-(∑ i, gradient U q i*gradient ψ q i)
def overdampedN (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  3/β*overdampedM U (laplacian ψ) β q
def highFrictionOABAO (U : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  (laplacian U q-β*gradNormSq U q)/8
theorem overdampedSolvability_choice (U : V n → ℝ) (β : ℝ) (hβ : β ≠ 0) :
    ∀ q, highFrictionOABAO U β q =
      -β/8*(gradNormSq U q-β⁻¹*laplacian U q) := by
  intro q
  dsimp [highFrictionOABAO]
  field_simp
  <;> ring

/-- source_id: MD-7.9.2-HighFrictionCorrectionTable · 印刷p.304–305 / PDFp.325–326
[EXTRA] 算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。
[EXTRA] 候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。
[EXTRA] 29号覆盖限定：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。
[EXTRA] 实际覆盖范围：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。 -/
def highFrictionCorrection (s : Fin 4) (U : V n → ℝ) (β c : ℝ) (x : Phase n) : ℝ :=
  if s = 0 then highFrictionOABAO U β x.1
  else if s = 1 then (β*gradNormSq U x.1-2*laplacian U x.1+c)/8
  else if s = 2 then (β*hessianQuadratic U x-2*laplacian U x.1+c)/8
  else (laplacian U x.1-β*hessianQuadratic U x)/8
def doublyAsymptoticAverage (A : ℝ → ℝ → ℝ) (exact correction : ℝ) : Prop :=
  Asymptotics.IsBigO positivePairLimit
    (fun z ↦ A z.1 z.2-exact-z.2^2*correction) (fun z ↦ z.1*z.2^2+z.2^4)
theorem highFrictionCorrection_conjugacy (U : V n → ℝ) (β c : ℝ) :
    conjugateCorrections U β (highFrictionCorrection 2 U β c) (highFrictionCorrection 1 U β c)
      (highFrictionCorrection 3 U β c) (highFrictionCorrection 0 U β c) := by
  constructor <;> funext x <;>
    norm_num [conjugateCorrections,highFrictionCorrection,highFrictionOABAO,conjugateCorrectionChange]
    <;> ring

def highFrictionMeanLaplacian (U : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, laplacian U q ∂positionGibbs U β

def highFrictionCenteredQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧
  Integrable (laplacian U) (positionGibbs U β) ∧
  ∀ s : Fin 4, Integrable (highFrictionCorrection s U β (highFrictionMeanLaplacian U β))
    (productGibbs (fun _ ↦ 1) U β) ∧
    (∫ x, highFrictionCorrection s U β (highFrictionMeanLaplacian U β) x
      ∂productGibbs (fun _ ↦ 1) U β) = 0

/-- source_id: MD-7.9.3-BAOABMarginalCancellation · 印刷p.305 / PDFp.326
[EXTRA] 归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。
[EXTRA] 29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。
[EXTRA] 实际覆盖范围：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。 -/
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry

/-- source_id: MD-7.9.3-SuperconvergenceScope · 印刷p.306 / PDFp.327
[EXTRA] 显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。
[EXTRA] 四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。
[EXTRA] 29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。
[EXTRA] 实际覆盖范围：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。 -/
theorem oabaoPositionCancellation (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U)
    (hweight : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hgrad : ∀ i, Integrable (fun q ↦ (hessianU U q i i-β*gradient U q i^2)*Real.exp (-β*U q)) volume)
    (hboundary : ∀ q i, Filter.Tendsto
      (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, highFrictionOABAO U β q ∂positionGibbs U β) = 0 := by
  sorry
theorem superconvergence_fromBound (A : ℝ → ℝ) (exact : ℝ)
    (hA : Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact-h^2*(0 : ℝ)) (fun h ↦ h^4)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact) (fun h ↦ h^4) := by
  simpa using hA

theorem oabaoMomentumCancellation (U χ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hf : Integrable (highFrictionOABAO U β) (positionGibbs U β))
    (hχ : Integrable χ (momentumGibbs (fun _ ↦ 1) β))
    (hc : ∫ q, highFrictionOABAO U β q ∂positionGibbs U β = 0) :
    (∫ x, χ x.2*highFrictionOABAO U β x.1 ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry

/-- source_id: MD-7.10-MomentumRedrawLimit · 印刷p.306 / PDFp.327
[EXTRA] 固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。
[EXTRA] 29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。
[EXTRA] 实际覆盖范围：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。 -/
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry

theorem redrawMomentum_law (P : Measure Ω) (m : V n) (θ : ℝ) (R : Ω → V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ)
    (hR : HasLaw R (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ redrawMomentum m θ (R sample)) (momentumGibbs m θ⁻¹) P := by
  sorry

/-- source_id: MD-7.10-OBABOOverdampedEuler · 印刷p.307 / PDFp.328
[EXTRA] 完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。
[EXTRA] 实际覆盖范围：仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite_position, overdampedEuler_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。 -/
def obaboInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  redrawStep m θ S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ redrawStep m θ R
def overdampedEulerH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-h^2/2/m i*gradient U q i+h/m i*redrawMomentum m θ R i
def overdampedEuler (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*R i
theorem obaboInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) (x : Phase n) :
    (obaboInfinite m U θ h R S x).1 = overdampedEulerH m U θ h R x.1 := by
  funext i
  dsimp [obaboInfinite,redrawStep,kickStep,driftStep,overdampedEulerH,Function.comp_def]
  ring
theorem overdampedEuler_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    overdampedEulerH m U θ h R q = overdampedEuler m U θ (h^2/2) R q := by
  sorry

/-- source_id: MD-7.10-BAOABLimitMethod · 印刷p.307–308 / PDFp.328–329
[EXTRA] 消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。
[EXTRA] 完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。
[EXTRA] 29号覆盖限定：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。
[EXTRA] 实际覆盖范围：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。 -/
def baoabInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ redrawStep m θ R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def lmStepH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-h^2/(2*m i)*gradient U q i+h/(2*m i)*(redrawMomentum m θ R i+redrawMomentum m θ S i)
def lmStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*((R i+S i)/2)
theorem baoabInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) :
    (baoabInfinite m U θ h R (q,fun i ↦ redrawMomentum m θ S i-h/2*gradient U q i)).1 =
      lmStepH m U θ h R S q := by
  funext i
  dsimp [baoabInfinite,lmStepH,kickStep,driftStep,redrawStep,Function.comp_def]
  ring

theorem lmStepH_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    lmStepH m U θ h R S q = lmStep m U θ (h^2/2) R S q := by
  sorry

/-- source_id: MD-7.10-ColoredNoiseAndExtension · 印刷p.308 / PDFp.329
[EXTRA] MA(1)噪声以相邻两独立Gaussian平均定义；定义扩展状态(q,R旧)的完整一步映射。非Markov性的普遍表述依赖具体势和初值，未把任意位置过程都判非Markov；扩展Markov核与半群律仍是覆盖缺口。
[EXTRA] 29号覆盖限定：邻接噪声定义与协方差、扩展状态映射及可测Markov核定义；过程相对过去的新噪声独立性/Markov定理未覆盖，位置非Markov不作全称断言。
[EXTRA] 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。
[EXTRA] 实际覆盖范围：邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。 -/
def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)

def lmExtendedKernel (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦
      lmExtendedStep m U θ τ z.2 z.1)) : Kernel (V n × V n) (V n × V n) :=
  (Kernel.id.prod (Kernel.const (V n × V n) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)))).map
    (fun z ↦ lmExtendedStep m U θ τ z.2 z.1)

def lmExtendedChain (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n) : ℕ → Ω → V n × V n
  | 0 => X0
  | k+1 => fun sample ↦ lmExtendedStep m U θ τ (R k sample)
      (lmExtendedChain m U θ τ R X0 k sample)

/-- 每次新噪声独立于初始状态及所有先前噪声；集合积分式给出扩展过程的Markov条件分布。 -/
theorem lmExtendedChain_markov (P : Measure Ω) (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (hτ : 0 < τ)
    (hR : vectorNormalSequence P R) (hX0 : Measurable X0)
    (hfresh : ∀ k, IndepFun (R k)
      (fun sample ↦ (X0 sample,fun j : Fin k ↦ R j sample)) P)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦ lmExtendedStep m U θ τ z.2 z.1)) :
    let X := lmExtendedChain m U θ τ R X0
    ∀ k (A : Set (V n × V n)) (hA : MeasurableSet A) (B : Set Ω),
    MeasurableSet[⨆ j : Fin (k+1), MeasurableSpace.comap (X j) inferInstance] B →
    P (B ∩ (X (k+1)) ⁻¹' A) =
      ∫⁻ sample in B, lmExtendedKernel m U θ τ hstep (X k sample) A ∂P := by
  sorry

/-- source_id: MD-7.10-LimitMethodAccuracy · 印刷p.308 / PDFp.329
[EXTRA] 用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。
[EXTRA] 原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。
[EXTRA] 29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
[EXTRA] 实际覆盖范围：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
[ERRATUM?] 已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。 -/
def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
def limitAccuracyPrinted (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^2)

def limitAccuracyPrinted_corrected (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^4)

theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring

def limitAccuracyInfiniteTime_corrected (error : ℝ → ℝ → ℝ) (longtime : ℝ → ℝ) : Prop :=
  (∀ h, 0 < h → Tendsto (fun T ↦ error (h^2/2) T) atTop (𝓝 (longtime h))) ∧
  limitAccuracyPrinted_corrected longtime

/-- source_id: MD-7.9.3-ZeroFrictionVerlet · 印刷p.306 / PDFp.327
[EXTRA] OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。
[EXTRA] 实际覆盖范围：仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。 -/
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  funext x
  have ha : driftStep m (h/2) (driftStep m (h/2) (kickStep U (h/2) x)) =
      driftStep m h (kickStep U (h/2) x) := by
    ext i <;> dsimp [driftStep] <;> ring
  simp only [baoab,Function.comp_apply,zeroFrictionOU]
  rw [ha]

/-- source_id: MD-7.11.1-TemperatureObservables · 印刷p.310 / PDFp.331
[EXTRA] 无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。
[EXTRA] 构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。
[EXTRA] 实际覆盖范围：仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p_i²/m_i及configuration观测∑q_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。 -/
def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry

/-- source_id: MD-7.11.1-VelocityAutocorrelationDefinition · 印刷p.310 / PDFp.331
[EXTRA] 原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。
[EXTRA] 已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。
[EXTRA] 实际覆盖范围：仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。 -/
def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]

/-- source_id: MD-7.12-ConstrainedLangevin · 印刷p.317 / PDFp.338
[EXTRA] 实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。
[EXTRA] 定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
[EXTRA] 29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。
[EXTRA] 实际覆盖范围：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。 -/
def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (multiplier : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*multiplier j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))

/-- 限制到单位质量、常正交投影的线性约束修正版；未声称一般非线性情形。 -/
def constrainedLangevin_corrected {l : ℕ} (P : Measure Ω) (C : Matrix (Fin l) (Fin n) ℝ)
    (proj : Matrix (Fin n) (Fin n) ℝ) (U : V n → ℝ) (γ θ : ℝ)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 U ∧
  proj*proj=proj ∧ proj.transpose=proj ∧ C*proj=0 ∧
  (∀ v : V n, C *ᵥ v=0 → proj *ᵥ v=v) ∧
  C *ᵥ x0.1=0 ∧ C *ᵥ x0.2=0 ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    C *ᵥ (X t sample).1=0 ∧ C *ᵥ (X t sample).2=0 ∧
    (∀ i, (X t sample).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i) ∧
    ∀ i, (X t sample).2 i=x0.2 i+
      (∫ s in (0 : ℝ)..t, -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i)+
      Real.sqrt (2*γ*θ)*(proj *ᵥ (W t sample-W 0 sample)) i

/-- source_id: MD-7.12-ConstrainedCanonicalErgodicity · 印刷p.317 / PDFp.338
[EXTRA] δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。
[EXTRA] 实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。
[EXTRA] 29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。
[EXTRA] 实际覆盖范围：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。 -/
def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))

def constrainedCanonicalQualification {l : ℕ} (ν : Measure (Phase n))
    (m : V n) (g : V n → V l) (U : V n → ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ContDiff ℝ 2 g ∧ constrainedReference ν m g ∧
  Integrable (gibbsWeight m U β) ν ∧ (0 < ∫ x, gibbsWeight m U β x ∂ν)

/-- source_id: MD-7.12-ConstrainedHOSplitting · 印刷p.318 / PDFp.339
[EXTRA] Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。
[EXTRA] 每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。
[EXTRA] 29号覆盖限定：H/O总化漂移、O扩散，以及两段各自受约束积分解规格；组合仍为代数辅助，未构造随机核及两次独立噪声组合。
[EXTRA] H/O漂移与O扩散、各段约束保持的积分解规格、满足这些规格的H/O随机映射组合；两次O用乘积概率空间的独立样本。未构造这些解的存在性或一般非线性投影漂移理论。
[EXTRA] 实际覆盖范围：H/O漂移与O扩散、各段约束保持的积分解规格、满足这些规格的H/O随机映射组合；两次O用乘积概率空间的独立样本。未构造这些解的存在性或一般非线性投影漂移理论。 -/
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)

def constrainedONoise (m : V n) (γ θ : ℝ) (j : Fin n) : Phase n :=
  (0,fun i ↦ if i=j then Real.sqrt (2*γ*θ*m i) else 0)

def constrainedHIntegralStep {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (X : ℝ → Phase n) (Λ : ℝ → V l) (x0 : Phase n) (T : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 g ∧ ContDiff ℝ 1 U ∧ 0 ≤ T ∧
  ContinuousOn X (Icc 0 T) ∧ X 0=x0 ∧
  (∀ t ∈ Icc 0 T, X t ∈ cotangentConstraint m g) ∧
  ∀ i, IntervalIntegrable (fun t ↦ (X t).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun t ↦ -gradient U (X t).1 i-
      constraintReaction g (X t).1 (Λ t) i) volume 0 T ∧
    ∀ t ∈ Icc 0 T,
      (X t).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s).2 i/m i ∧
      (X t).2 i=x0.2 i+∫ s in (0 : ℝ)..t,
        -gradient U (X s).1 i-constraintReaction g (X s).1 (Λ s) i

/-- O乘子冲量允许含随机部分；不把它限为有限变差的λdt。 -/
def constrainedOIntegralStep {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (reactionImpulse : ℝ → Ω → V n) (x0 : Phase n) (T : ℝ) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧ 0 ≤ T ∧
  (∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P, X t sample ∈ cotangentConstraint m g) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Icc 0 T) ∧
    X 0 sample=x0 ∧ reactionImpulse 0 sample=0) ∧
  (∀ sample i, IntervalIntegrable (fun t ↦ -γ*(X t sample).2 i) volume 0 T) ∧
  (∀ sample t, ∃ impulseCoeff : V l, reactionImpulse t sample=constraintReaction g x0.1 impulseCoeff) ∧
  (∀ t ∈ Icc 0 T, Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
      (reactionImpulse t)) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1 ∧ ∀ i,
      (X t sample).2 i=x0.2 i+(∫ s in (0 : ℝ)..t, -γ*(X s sample).2 i)-
        reactionImpulse t sample i+Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

def constrainedHMapQualification {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (H : ℝ → Phase n → Phase n) : Prop :=
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ Λ : ℝ → V l,
    constrainedHIntegralStep m U g (fun t ↦ H t x) Λ x T

def constrainedOMapQualification {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (O : ℝ → Ω → Phase n → Phase n) : Prop :=
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ reaction : ℝ → Ω → V n,
    constrainedOIntegralStep P m g γ θ W (fun t sample ↦ O t sample x) reaction x T

/-- 两次O使用乘积概率空间上的独立样本；H/O都须满足各自受约束解规格。 -/
def constrainedHOQualifiedComposition {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) :
    Ω × Ω → Phase n → Phase n :=
  fun sample x ↦ O (h/2) sample.2 (H h (O (h/2) sample.1 x))

/-- source_id: MD-7.12-MEVMEAlgorithm · 印刷p.318–319 / PDFp.339–340
[EXTRA] 完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。
[EXTRA] 实际覆盖范围：仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。 -/
def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (multiplier : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (multiplier μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ multipliera multiplierb multiplierc multiplierd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa multipliera ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph multiplierb multiplierc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 multiplierd

/-- source_id: MD-7.12-MidpointStabilityPrinted · 印刷p.319 / PDFp.340
[EXTRA] 原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。
[EXTRA] 实际覆盖范围：仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted_corrected, midpointStability_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
[ERRATUM?] 已目视核对PDF340／印刷319：所印γh<4保留为原书给出的限制。它保证中点OU放大因子为正；OU线性绝对稳定性本身对γh≥0均成立。原文没有写充要关系，不能把本条当作已确认的原书错误。完整耦合Verlet仍有独立步长限制。 -/
def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (multiplier : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor
  · apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
  · apply (div_le_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]

/-- source_id: MD-7.12.1-ConstrainedABOSplitting · 印刷p.319–320 / PDFp.340–341
[EXTRA] Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。
[EXTRA] 正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。
[EXTRA] 实际覆盖范围：仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。 -/
def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 multiplier i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ multiplier : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (multiplier t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g

/-- source_id: MD-7.12.1-ConstrainedBAOABAlgorithm · 印刷p.320 / PDFp.341
[EXTRA] 完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。
[EXTRA] 实际覆盖范围：仅覆盖 constrainedBAOABRelation, constrainedBAOAB_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。 -/
def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2

/-- source_id: MD-7.12.1-ApproximateGeodesicOrder · 印刷p.320 / PDFp.341
[EXTRA] 用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。
[EXTRA] 29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。
[EXTRA] 实际覆盖范围：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。 -/
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2

/-- source_id: MD-7.13-FastSlowHarmonicModel · 印刷p.323 / PDFp.344
[EXTRA] 单位质量、实际标准Wiener、状态适应、正β及完整积分方程由langevin定义体保留；Ω≫1在定量结论中分别改成明确不等式。
[EXTRA] 实际覆盖范围：仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。 -/
abbrev Mat2 := Matrix (Fin 2) (Fin 2) ℝ
def fastPotential (Ω q : ℝ) : ℝ := Ω^2*q^2/2
def slowPotential (q : ℝ) : ℝ := q^2/2
def fastMatrix (Ω γ : ℝ) : Mat2 := !![0,1;-Ω^2,-γ]
def slowMatrix (h : ℝ) : Mat2 := !![1,0;-h,1]
def fastLangevin (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β : ℝ) (x0 : Phase 1) : Prop :=
  0 < frequency ∧ 0 < β ∧ langevin P W X (fun q ↦ fastPotential frequency (q 0)) (fun _ ↦ 1) γ β⁻¹ x0

/-- source_id: MD-7.13-ExactFastGaussianLaw · 印刷p.323–324 / PDFp.344–345
[EXTRA] 陈述真实过程的转移分布，不将强解等于一组新独立R假设成结论。Bt只需给定平方根因子；正半定矩阵平方根存在性未另证明。
[EXTRA] 实际覆盖范围：仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。 -/
def fastExponential (Ω γ t : ℝ) : Mat2 := NormedSpace.exp (t • fastMatrix Ω γ)
def fastCovariance (Ω γ β t : ℝ) : Mat2 := fun i j ↦ 2*γ/β*∫ s in (0 : ℝ)..t,
  (fastExponential Ω γ (t-s)* (!![0,0;0,1] : Mat2)*(fastExponential Ω γ (t-s))ᵀ) i j
theorem exactFastGaussianLaw (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β t : ℝ) (x0 : Phase 1) (B : Mat2)
    (hX : fastLangevin P W X frequency γ β x0) (ht : 0 ≤ t)
    (hB : B*Bᵀ = fastCovariance frequency γ β t) :
    HasLaw (fun sample ↦ (![ (X t sample).1 0, (X t sample).2 0] : Fin 2 → ℝ))
      (Measure.map (fun R : Fin 2 → ℝ ↦
        fastExponential frequency γ t *ᵥ (![x0.1 0,x0.2 0] : Fin 2 → ℝ)+B*ᵥ R)
        (Measure.pi (fun _ : Fin 2 ↦ gaussianReal 0 1))) P := by
  sorry

/-- source_id: MD-7.13-MultipleTimestepUpdate · 印刷p.324 / PDFp.345
[EXTRA] Rn为每步独立标准二维Gaussian；稳定分布分析仍要求真实独立序列及有限协方差，不能只以更新定义宣称存在平稳解。
[EXTRA] 实际覆盖范围：仅覆盖 multipleX, multipleY, multipleStep, multipleStep_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。 -/
def multipleX (Ω γ h : ℝ) : Mat2 := slowMatrix h*fastExponential Ω γ h
def multipleY (h : ℝ) (B : Mat2) : Mat2 := slowMatrix h*B
def multipleStep (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) : Fin 2 → ℝ :=
  multipleX Ω γ h *ᵥ z+multipleY h B *ᵥ R
theorem multipleStep_composition (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) :
    multipleStep Ω γ h B R z = slowMatrix h *ᵥ (fastExponential Ω γ h *ᵥ z+B*ᵥ R) := by
  simp [multipleStep,multipleX,multipleY,Matrix.mulVec_add,Matrix.mulVec_mulVec]

/-- source_id: MD-7.13-DeterminantTrace · 印刷p.324 / PDFp.345
[EXTRA] η允许纯虚数；显式排除临界η=0，避免除零假公式。临界阻尼应取连续极限，另列覆盖缺口。
[EXTRA] 实际覆盖范围：仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。 -/
def traceFormula (γ h : ℝ) (η : ℂ) : ℂ :=
  (η-(h : ℂ))/η*Complex.exp ((η-(γ : ℂ))*(h : ℂ)/2)+
  (η+(h : ℂ))/η*Complex.exp ((-η-(γ : ℂ))*(h : ℂ)/2)
theorem determinantTrace (Ω γ h : ℝ) (η : ℂ) (hη : η^2 = (γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    Matrix.det (multipleX Ω γ h) = Real.exp (-γ*h) ∧
    ((Matrix.trace (multipleX Ω γ h) : ℝ) : ℂ) = traceFormula γ h η := by
  sorry

/-- source_id: MD-7.13-SpectralRadiusStability · 印刷p.324 / PDFp.345
[EXTRA] 只陈述谱半径≤1的确定性边界资格；有非退化随机驱动时平稳二阶矩一般要求严格谱半径<1，等号并不自动给随机长期稳定。
[EXTRA] 正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。
[EXTRA] 29号覆盖限定：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。
[EXTRA] 实际覆盖范围：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。 -/
def characteristicUnitDisk (X : Mat2) : Prop :=
  ∀ z : ℂ, z^2-((Matrix.trace X : ℝ) : ℂ)*z+((Matrix.det X : ℝ) : ℂ) = 0 → ‖z‖ ≤ 1
theorem spectralRadiusStability (X : Mat2) (hd : 0 < Matrix.det X) (hd1 : Matrix.det X < 1) :
    characteristicUnitDisk X ↔ |Matrix.trace X| ≤ 1+Matrix.det X := by
  sorry
def hyperbolicStability (γ h : ℝ) (η : ℂ) : Prop :=
  ‖Complex.cosh (η*(h : ℂ)/2)+(h : ℂ)/η*Complex.sinh (-η*(h : ℂ)/2)‖ ≤ Real.cosh (γ*h/2)

theorem multipleX_spectral_hyperbolic (Ω γ h : ℝ) (η : ℂ)
    (hγ : 0 < γ) (hh : 0 < h)
    (hη : η^2=(γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    characteristicUnitDisk (multipleX Ω γ h) ↔ hyperbolicStability γ h η := by
  sorry

/-- source_id: MD-7.13-HyperbolicPhaseTransform · 印刷p.324 / PDFp.345
[EXTRA] 实η版本必须补|h/η|<1，γ>0本身不足；复η需选择sqrt/artanh分支，原文未说明。只覆盖明确实域上的等式，不把所有γ>0都纳入。
[EXTRA] 29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。
[EXTRA] 实际覆盖范围：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。 -/
def hyperbolicPhase (η h : ℝ) : ℝ :=
  Real.cosh (η*h/2-Real.artanh (h/η))*Real.sqrt (1-h^2/η^2)
theorem hyperbolicPhase_identity (η h : ℝ) (hη : η ≠ 0) (hr : |h/η| < 1) :
    hyperbolicPhase η h = Real.cosh (η*h/2)-h/η*Real.sinh (η*h/2) := by
  have hh : h/η ∈ Set.Ioo (-1 : ℝ) 1 := abs_lt.mp hr
  have hs : Real.sqrt (1-(h/η)^2) ≠ 0 := by
    apply ne_of_gt
    apply Real.sqrt_pos.2
    have hsq : (h/η)^2 < 1 := (sq_lt_one_iff_abs_lt_one (h/η)).2 hr
    linarith
  simp only [hyperbolicPhase,Real.cosh_sub,Real.cosh_artanh hh,Real.sinh_artanh hh]
  rw [← div_pow]
  calc
    _ = (Real.cosh (η*h/2)-(h/η)*Real.sinh (η*h/2))/Real.sqrt (1-(h/η)^2)*Real.sqrt (1-(h/η)^2) := by ring
    _ = _ := div_mul_cancel₀ _ hs

/-- source_id: MD-7.13-UnderdampedPhasePrinted · 印刷p.325 / PDFp.346
[EXTRA] 原文版与修正版分别定义，原文版不证明；直接用幅相恒等式绕过复函数分支。η̂=√(4Ω²-γ²)>0需要明确欠阻尼条件。
[EXTRA] 29号覆盖限定：字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。
[EXTRA] 实际覆盖范围：字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。
[ERRATUM?] 已目视核对PDF346／印刷325：从η=iη̂化为实余弦时应使用+arctan(h/η̂)，所印-atanh(h/η̂)的函数与符号均不符。修正版从cos(a)-r sin(a)的标准幅相恒等式得到。 -/
def underdampedPhasePrinted (η h : ℝ) : ℝ :=
  Real.cos (η*h/2-Real.artanh (h/η))*Real.sqrt (1+h^2/η^2)
def underdampedPhasePrinted_corrected (η h : ℝ) : ℝ :=
  Real.sqrt (1+(h/η)^2)*Real.cos (η*h/2+Real.arctan (h/η))
theorem underdampedPhase_identity (a r : ℝ) :
    Real.cos a-r*Real.sin a = Real.sqrt (1+r^2)*Real.cos (a+Real.arctan r) := by
  rw [Real.cos_add,Real.cos_arctan,Real.sin_arctan]
  have hs : Real.sqrt (1+r^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by positivity))
  field_simp
  <;> ring

/-- source_id: MD-7.13-StabilityEnvelope · 印刷p.325 / PDFp.346
[EXTRA] “所有步长”指对每个h满足该条件；一次h的包络条件不能声称自动覆盖所有h。仍仅为谱模不超过1的充分条件，严格随机平稳性另需严格不等式。
[EXTRA] 实际覆盖范围：仅覆盖 stabilityEnvelope, stabilityEnvelope_sufficient, stabilityEnvelope_iff 所列对象、量词、前提和结论。范围说明：sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用|cos|≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。 -/
def stabilityEnvelope (η γ h : ℝ) : Prop := Real.sqrt (1+h^2/η^2) ≤ Real.cosh (γ*h/2)
theorem stabilityEnvelope_sufficient (η γ h : ℝ) (he : stabilityEnvelope η γ h) :
    |underdampedPhasePrinted_corrected η h| ≤ Real.cosh (γ*h/2) := by
  dsimp [underdampedPhasePrinted_corrected]
  calc
    _ ≤ Real.sqrt (1+(h/η)^2)*1 := by
      rw [abs_mul,abs_of_nonneg (Real.sqrt_nonneg _)]
      exact mul_le_mul_of_nonneg_left (Real.abs_cos_le_one _) (Real.sqrt_nonneg _)
    _ = Real.sqrt (1+h^2/η^2) := by rw [div_pow,mul_one]
    _ ≤ _ := he
theorem stabilityEnvelope_iff (η γ h : ℝ) (hη : 0 < η) (hγ : 0 ≤ γ) (hh : 0 ≤ h) :
    stabilityEnvelope η γ h ↔ h/η ≤ Real.sinh (γ*h/2) := by
  sorry

/-- source_id: MD-7.13-FrictionThresholdPrinted · 印刷p.325 / PDFp.346
[EXTRA] 保留原精确根式，它本身与有理化修正版相同；疑误在后续比较方向/系数。欠阻尼上界γ<2Ω显式，不把该范围内的代数条件推广到任意大γ。
[EXTRA] 所有h包络由sinh x≥x推出，严格稳定与随机矩界仍需另证。反例给出有理平方数值，完整根式代入识别未另证明。
[EXTRA] 29号覆盖限定：字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。
[EXTRA] 实际覆盖范围：字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。
[ERRATUM?] 已目视核对PDF346：最后链式下界√2/Ω不成立。将精确阈值有理化得√(2/(Ω²+√(Ω⁴-1)))，大Ω时约1/Ω；√2/Ω可作更保守的充分选择而非精确阈值下界。Ω²=5/4时精确阈值平方=1，小于2/Ω²=8/5。 -/
def frictionThresholdPrinted (Ω : ℝ) : ℝ := Ω*Real.sqrt (2-2*Real.sqrt (1-Ω⁻¹^4))
def frictionThresholdPrinted_corrected (Ω : ℝ) : ℝ := Real.sqrt (2/(Ω^2+Real.sqrt (Ω^4-1)))
def frictionBoundPrinted (Ω γ : ℝ) : Prop :=
  frictionThresholdPrinted Ω ≤ γ ∧ Real.sqrt 2/Ω ≤ frictionThresholdPrinted Ω

def frictionBoundPrinted_corrected (Ω γ : ℝ) : Prop :=
  0 < γ ∧ γ < 2*Ω ∧ 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2

theorem frictionThreshold_rationalized (Ω : ℝ) (hΩ : 1 ≤ Ω) :
    frictionThresholdPrinted Ω = frictionThresholdPrinted_corrected Ω := by
  sorry
theorem frictionThreshold_allSteps (Ω γ : ℝ) (hΩ : 1 ≤ Ω) (hγ : 0 < γ) (hu : γ < 2*Ω)
    (hb : 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2) :
    ∀ h, 0 ≤ h → stabilityEnvelope (Real.sqrt (4*Ω^2-γ^2)) γ h := by
  sorry
theorem frictionThreshold_asymptotic :
    Filter.Tendsto (fun Ω : ℝ ↦ Ω*frictionThresholdPrinted_corrected Ω) Filter.atTop (𝓝 1) := by
  sorry
theorem frictionThreshold_squared_counterexample : (1 : ℝ) < 2/(5/4 : ℝ) := by norm_num

/-- source_id: MD-7.1-ConfigurationalSampling · 印刷p.262 / PDFp.283
[EXTRA] 原文省略归一常数；positionGibbs定义体保留实际配分积分。可积性与概率归一资格单列，不把未归一指数直接视为概率密度。
[EXTRA] 实际覆盖范围：仅覆盖 configurationalSamplingAverage, configurationalSamplingQualified 所列对象、量词、前提和结论。范围说明：positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。 -/
def configurationalSamplingAverage (U φ : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, φ q ∂positionGibbs U β

def configurationalSamplingQualified (U φ : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧ Integrable φ (positionGibbs U β)

/-- source_id: MD-7.1-HamiltonianSamplingObstruction · 印刷p.262 / PDFp.283
[EXTRA] 本条只证明保能流的能量子水平集不变；结合非平凡概率质量可形成遍历性障碍。能量壳上的遍历性不能由原句否定。
[EXTRA] 原句未指定Liouvillian定义域、函数空间与参考概率。谱隙缺失和多个平稳解的完整算子陈述列为覆盖缺口，不把子水平集恒等式标作整段谱理论的证明。
[EXTRA] 29号覆盖限定：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。
[EXTRA] 实际覆盖范围：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。 -/
def energyConservingFlow (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧ ∀ t x, H (F t x) = H x

theorem energySublevel_invariant (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n)
    (hf : energyConservingFlow H F) (a t : ℝ) :
    (F t) ⁻¹' {x | H x ≤ a} = {x | H x ≤ a} := by
  ext x
  change H (F t x) ≤ a ↔ H x ≤ a
  rw [hf.2.2 t x]

def energyObstructionQualified (μ : Measure (Phase n)) (H : Phase n → ℝ)
    (F : ℝ → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure μ ∧ energyConservingFlow H F ∧
    (∀ t, MeasurePreserving (F t) μ μ) ∧
    ∃ a, MeasurableSet {x | H x ≤ a} ∧ 0 < μ {x | H x ≤ a} ∧ μ {x | H x ≤ a} < 1

end MD.Ch07
