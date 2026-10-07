# T5：严格局部极小的球面正势能屏障规格

状态：2026-10-02，本地准备。四个候选定义和六个待证 Prop 类型已用固定版本检查；小型拓扑适配和样例另见 API 报告。下列一般目标尚未证明，也未进入正式库或送 MathCopilot。T5 是任务批次编号，不是第五章；本批对应第一章 Theorem 1.1 的一个静态证明环节。

例如 U(x)=x⁴ 在 0 严格极小。在距离 0 等于 r>0 的一维球面上，U 恰等于 r⁴，因此可取势能差 δ(r)=r⁴。这说明 δ 随半径变化，且不需要 Hessian 正定。根目录临时探针实际证明了这个实数样例；尚未证明一般 n 维目标。

## 原页和本批边界

- 教材源为工作区 Leimkuhler2015b PDF，461页，SHA256 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。本轮重新提取、140 DPI 渲染并实际查看印刷30–34 / 从1起算PDF53–57，核心印刷32/PDF55。
- 原文 strong local minimum 的实际公式：∃R>0，0<‖q−q₀‖<R ⇒ U(q₀)<U(q)。这里称严格局部极小，不解释成强凸性、正定 Hessian 或二次增长。
- Theorem 1.1 假设 smooth U，结论 `(q₀,0)` 稳定。原页仅说明近初值轨道不能远走，没有给出球面最小值/统一差/介值与延拓的完整证明。紧性和以下屏障链是形式化补充。
- 印刷33/PDF56的 Hessian 段提供充分条件，随后进入§1.6；本批不替换原严格极小假设，不纳入线性化、晶格或周期边界。
- 本批只处理位置势能。质量、Hamiltonian、时间轨道、ODE、守恒、动量界和全局延拓不进入核心假设；与 T2-L0/B3 或 T3 完整证明无依赖。静态 Hamiltonian 球面排除可后续由 K≥0 接线，但不是本批第六项一般目标。

## 配置域与候选定义

工程 `Position n := EuclideanSpace ℝ (Fin n)`，n 是配置坐标数。U 用 ambient 总函数表示，只在 Q 中作物理解释。相对严格极小要求 q₀∈Q；任意相对域中的真空极小不能自动推出全方向球面屏障。

固定 mathlib 没有 `IsStrictLocalMin`/`IsStrictLocalMinOn`；存在的 `IsLocalMin`/`IsLocalMinOn` 使用 ≤。下列是隔离目录 `T5Preparation` 的候选名字，不是正式库已有定义。使用实际 MetricSpace，使 q≠q₀ 与 0<dist q q₀ 等价；不无条件扩展到伪度量空间。

```lean
import MolecularDynamics.Notation
import Mathlib.Topology.Order.Compact
import Mathlib.Analysis.Normed.Module.FiniteDimension

open Set Filter Metric
open scoped Topology

namespace T5Preparation

def StrictPotentialMinRadius {E : Type*} [MetricSpace E]
    (U : E → ℝ) (Q : Set E) (q₀ : E) (R : ℝ) : Prop :=
  0 < R ∧ ∀ q ∈ Q, q ≠ q₀ → dist q q₀ < R → U q₀ < U q

def IsStrictPotentialMinOn {E : Type*} [MetricSpace E]
    (U : E → ℝ) (Q : Set E) (q₀ : E) : Prop :=
  q₀ ∈ Q ∧ ∃ R : ℝ, StrictPotentialMinRadius U Q q₀ R

def IsStrictPotentialMin {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) : Prop :=
  ∃ R : ℝ, 0 < R ∧ ∀ q, 0 < dist q q₀ → dist q q₀ < R → U q₀ < U q

def HasSpherePotentialBarrier {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) (r δ : ℝ) : Prop :=
  0 < δ ∧ ∀ q ∈ sphere q₀ r, U q₀ + δ ≤ U q

end T5Preparation
```

`StrictPotentialMinRadius` 只展开去心开球内的点态严格不等式，不含待证明的一致 δ。`HasSpherePotentialBarrier` 是目标结论的记号，不可把它作为核心目标的输入。

## 五项规格 ID

| ID | 范围与结论 | 核心前提 | 状态 |
| --- | --- | --- | --- |
| T5-D1 | 正半径定义↔去心相对邻域事件；全空间↔univ；严格⇒非严格 | 度量空间；相对版保留中心在Q | 三个目标类型通过；一般桥接未证明 |
| T5-C1 | 紧集上的处处严格差⇒一致 δ>0 | K紧、U在K连续、∀q∈K,c<U(q) | 一个目标类型通过；一般证明未实施 |
| T5-S1 | 固定合法半径的球面势能屏障 | 严格半径R、0<r<R、sphere⊆Q、球面连续 | 一个目标类型通过；一般证明未实施 |
| T5-O1 | 开配置域内每个足够小正半径有屏障 | Q开、U在Q连续、相对严格极小 | 一个目标类型通过；一般证明未实施 |
| T5-E1 | x⁴、常数势能、零维与失败边界 | 各例分别列条件 | 六个命名小引理及连续性样例通过；其余反例仅数学核对 |

准确候选类型如下。`def ...Goal : Prop` 只登记陈述，编译不构成该 Prop 的证明。三个 D1 目标 + C1/S1/O1 = 六个目标类型。

```lean
namespace T5Preparation

open MolecularDynamics

def StrictOnPuncturedGoal (n : ℕ) : Prop :=
  ∀ (U : Position n → ℝ) (Q : Set (Position n)) (q₀ : Position n),
    IsStrictPotentialMinOn U Q q₀ ↔
      q₀ ∈ Q ∧ ∀ᶠ q in 𝓝[Q \ {q₀}] q₀, U q₀ < U q

def StrictUnivGoal (n : ℕ) : Prop :=
  ∀ (U : Position n → ℝ) (q₀ : Position n),
    IsStrictPotentialMin U q₀ ↔ IsStrictPotentialMinOn U univ q₀

def StrictToLocalMinGoal (n : ℕ) : Prop :=
  ∀ (U : Position n → ℝ) (Q : Set (Position n)) (q₀ : Position n),
    IsStrictPotentialMinOn U Q q₀ → IsLocalMinOn U Q q₀

def CompactPositiveGapGoal (E : Type*) [TopologicalSpace E] : Prop :=
  ∀ (U : E → ℝ) (K : Set E) (c : ℝ), IsCompact K → ContinuousOn U K →
    (∀ q ∈ K, c < U q) → ∃ δ : ℝ, 0 < δ ∧ ∀ q ∈ K, c + δ ≤ U q

def FixedSphereBarrierGoal (n : ℕ) : Prop :=
  ∀ (U : Position n → ℝ) (Q : Set (Position n)) (q₀ : Position n) (R r : ℝ),
    StrictPotentialMinRadius U Q q₀ R → 0 < r → r < R →
    sphere q₀ r ⊆ Q → ContinuousOn U (sphere q₀ r) →
    ∃ δ : ℝ, HasSpherePotentialBarrier U q₀ r δ

def OpenDomainBarrierGoal (n : ℕ) : Prop :=
  ∀ (U : Position n → ℝ) (Q : Set (Position n)) (q₀ : Position n),
    IsOpen Q → ContinuousOn U Q → IsStrictPotentialMinOn U Q q₀ →
    ∃ R : ℝ, 0 < R ∧ ball q₀ R ⊆ Q ∧
      ∀ r : ℝ, 0 < r → r < R → ∃ δ : ℝ, HasSpherePotentialBarrier U q₀ r δ

#check StrictOnPuncturedGoal
#check StrictUnivGoal
#check StrictToLocalMinGoal
#check CompactPositiveGapGoal
#check FixedSphereBarrierGoal
#check OpenDomainBarrierGoal

end T5Preparation
```

## 证明路线与最小假设

T5-D1：用 `Metric.mem_nhdsWithin_iff` 将去心事件变成 ∃R>0 的球包含关系，分解 Q\{q₀} 成员；用 dist_pos 将不等于中心与正距离互换。严格推出非严格时分 q=q₀/不等两支。反向不成立：常数势能在0是非严格局部极小，却不严格；这个区别已由实数探针检查。

T5-C1：`IsCompact.exists_forall_le'` 在固定库直接产生 a'>c 且 ∀q∈K,a'≤U(q)。令 δ=a'−c，实数线性运算得到目标。接口本身已分空集/非空集，所以 C1 不需要 K.Nonempty；若改走 `exists_isMinOn`，取得极小点那一步才需要非空。无需有限维、中心在K、全局连续或导数。

T5-S1：Position n 有有限维实范数空间实例，从 `FiniteDimensional.proper_real` 得 ProperSpace；`isCompact_sphere` 给紧性。球面距离等于r；0<r给q≠q₀，r<R支持严格半径条件；sphere⊆Q让U不等式合法。调用C1便得 δ。只需球面上的 ContinuousOn；Q不必开，U不必在整个Q连续。正式证明可以推广到任意 Proper MetricSpace，但本批目标固定工程配置空间以减少接口分岔。

T5-O1：由Q开且q₀∈Q取得a>0、ball q₀ a⊆Q；严格极小取得b>0。选R=min(a,b)>0。每个0<r<R都有sphere q₀ r⊆ball q₀ R⊆Q，连续性限制到球面，然后用S1。该版本也保证每个r<R的closedBall q₀ r⊆Q，供未来局部延拓使用；这个额外包含关系不是已证明的新公开引理。Q开是便利充分条件，可进一步换成Q∈𝓝q₀或给定内球，不声称全局开放是必要条件。

## 半径、连续性与退化边界

1. 量词必须为 ∃R>0,∀r,0<r→r<R→∃δ>0,...。δ在r之后，通常依赖r。x⁴样例的r⁴随r→0趋零，不能交换成一个固定δ覆盖所有小r。
2. r严格小于R；不改成r≤R。反例 U(x)=x²(1−x²)，q₀=0，R=1：去心开球内为正，半径1球面取值0。这个局部反例已数学核对，未单独Lean验证。
3. 球面须在Q内。例如Q={q₀}时相对strict真空成立，却不包含非零维正半径全空间球面。不能省略S1的域包含前提。
4. 点点大于基准不足以产生一致正差，必须有紧性和适当连续性。非紧K=(0,1)、U(x)=x、c=0是缺紧性反例。紧K={0}∪{1/k:k≥1}、U(0)=1、U(1/k)=1/k、c=0是缺连续性反例；后者c不是U(0)，用于一般C1。这两例仅数学核对。
5. n=0时Position 0为单点；r>0的sphere为空。S1/O1仍成立，可取δ=1；不需要n>0。零维严格极小也真空成立，不能称非平凡物理稳定。探针实际检查了空球面与δ=1。
6. 若报告“取得球面极小值的位置”，须保留sphere.Nonempty。库 `NormedSpace.sphere_nonempty` 的实际条件包含 NontrivialTopology；不能把该条件省掉后宣称所有n成立。IsMinOn本身不包含中心属于集合，exists_isMinOn的成员证据须单独保存。

T5-E1的实际通过样例使用E=ℝ：quartic_strict_min、quartic_sphere_barrier、continuous_id.pow 4；常数势能非严格/非strict；Position 0空球面/屏障，共六命名小引理加一个连续性example。尚未做Position 1坐标等距转换。x⁴的U″(0)=0、无统一正二次下界是数学边界说明，未进行导数/Hessian Lean检查。

## 与教材稳定性剩余链条的区别

得到球面势能屏障后，K≥0可排除低能相点的位置在球面上。连续轨道从球内到球外必经球面，还须给定连通时间段上的能量守恒，才能证明在解的存在区间内不出球。初值低能需要H在(q₀,0)连续；动量小需要正质量二次动能下界与局部U≥U(q₀)。真实平衡需要可微内点极小推出梯度零。正向所有时间还需要局部适定与最大解紧困延拓，不把已有解的局部区间结论当全局流。

原页显示sup_{t≥0}距离<ε；对固定ε逐t距离<ε不自动给这个严格sup界。后续可先建立ε/2尺度的统一控制，再匹配教材量词。相空间现有Prod范数与教材范数须显式比较。以上均不属于已证明的T5准备成果。

## 复现与进入正式实施的条件

固定基准：分支 `chapter01-kinetic-energy-nonneg`，HEAD `121a9d02ad15500c630e505b363d5f04106d617f`；Lean `leanprover/lean4:v4.34.0`，mathlib `5ed2965256430c3649e86755f9576b54eca72435`。输入冻结于工作区 `tmp/t5-preparation-20261002/frozen-inputs/`，不要以其他对话后来修改的文件冒充本快照。

原页证据、完整API类型、每次探针的源/log/result及输入清单分别见另外三份T5文档和同名临时目录。后续先取得MathCopilot逐ID陈述/依赖审阅并核对返回原件，再安排一般证明。正式集成须重跑scripts/check.ps1、关键引理#print axioms并更新FORMALIZATION_MAP/ASSUMPTIONS/STATUS。机器编译与负责人教材语义签核分别记录。
