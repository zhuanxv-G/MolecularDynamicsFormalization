# T2 固定版本 API 检查

状态：本轮五组核心接口及其直接辅助声明、小型导数/矩阵适配、候选定义和目标类型检查已通过。两个失败尝试保留；没有完成 T2 目标证明或正式工程构建。

## 1. 固定版本、命令与证据

- 数学输入源码基准：`54b75a14aaa968522903d82eef947ffdc7bbf165`；并行索引对话后来提交 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f`，只改 knowledge。正式 Lean、Scratch、版本和验收脚本的两提交差异为空。
- `lean-toolchain`：`leanprover/lean4:v4.34.0`；实际二进制 `Lean (version 4.34.0, x86_64-w64-windows-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)`；Lake `5.0.0-src+293d5d0`。
- mathlib manifest与checkout：`5ed2965256430c3649e86755f9576b54eca72435`；tracked 工作树干净。
- 原始探针源、log、result.json：工作区上层 `tmp/t2-preparation/`。`run_probe.py` 保存精确命令、工作目录、源码/输出SHA256、起止时间和退出状态；PATH仅在子进程前置已安装固定bin，不升级、不网络下载。
- 精确调用形式：`C:/Users/ustc/.elan/toolchains/leanprover--lean4---v4.34.0/bin/lake.exe env lean C:/Users/ustc/Desktop/formal math/tmp/t2-preparation/<探针>.lean`；cwd是正式工程。Python运行器命令为 `python -X utf8 ../tmp/t2-preparation/run_probe.py <探针>.lean`。
- 本轮没有修改共享 `Scratch.lean` 或正式 `.lean`；没有用旧T1构建结果冒充本轮T2检查。

## 2. 五组核心接口与适用条件

| 组 | 主要完整声明名及直接辅助 | 本地来源模块 | 实际用途和限制 |
| --- | --- | --- | --- |
| K1 | `IsIntegralCurveOn`、`HasDerivWithinAt.hasDerivAt`；`IsIntegralCurveAt`、`IsIntegralCurveOn.isIntegralCurveAt`、`isIntegralCurveAt_iff_exists_pos` | `Mathlib.Analysis.ODE.Basic`、`Mathlib.Analysis.Calculus.Deriv.Basic` | 区间内导数；额外输入 `I∈𝓝 t` 才能变双侧导数。开集内可用，闭区间端点不自动适用 |
| K2 | `HasFDerivAt.comp_hasDerivAt` 配合 `ContinuousLinearMap.fst/snd`；`HasDerivAt.prodMk` | `Mathlib.Analysis.Calculus.Deriv.Comp`、`Mathlib.Topology.Algebra.Module.ContinuousLinearMap.PiProd`、`Mathlib.Analysis.Calculus.Deriv.Prod` | 分量投影与合并。直接使用连续线性投影的链式法则；没有依赖猜测的 `HasDerivAt.fst/snd` 名称 |
| K3 | `Matrix.toEuclideanLin`、`LinearMap.toContinuousLinearMap`、`ContinuousLinearMap.hasFDerivAt` | `Mathlib.Analysis.InnerProductSpace.PiL2`、`Mathlib.Topology.Algebra.Module.FiniteDimension`、`Mathlib.Analysis.Calculus.FDeriv.Linear` | 从欧氏线性映射到连续线性映射；finite-dimensional域、ℝ完备等条件由实际类型实例提供；已验证两种矩阵作用的坐标等式 |
| K4 | `HasDerivAt.congr_of_eventuallyEq`、`HasDerivAt.deriv` | `Mathlib.Analysis.Calculus.Deriv.Basic` | 以邻域等式转移导数。需 `deriv q =ᶠ[𝓝 t] V∘p`，单点值等式不够 |
| K5 | `ContDiffAt.exists_eventually_eq_hasDerivAt`、`ContDiffAt.exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀`；`IsPicardLindelof.exists_eq_forall_mem_Icc_hasDerivWithinAt`、`ODE_solution_unique_of_mem_Ioo` | `Mathlib.Analysis.ODE.ExistUnique`，假设结构在 `Mathlib.Analysis.ODE.PicardLindelof` | C¹场/完备空间给局部存在，唯一性另外要求公共Lipschitz常数与两条曲线的域成员。只定位/类型核对，没有证明机械场满足前提 |

API声明检查共18个直接相关声明，属于上述五组接口与辅助；不是18个教材定理或证明成果。完整原样类型输出在第5节。

## 3. 实际运行表及失败处理

| 源文件 | 开始时间（+08:00） | 实际秒数 | Lean/运行器状态 | 实际结果 |
| --- | --- | --- | --- | --- |
| `Probe01_APIs.lean` | 2026-10-02T15:57:07.783167+08:00 | 491.203 | 124 | 未通过：未知pp.width，ContinuousSMul类型类20000心跳超时；124为运行器超时标记，非正常Lean退出 |
| `Probe01b_API_Types.lean` | 2026-10-02T16:10:07.917473+08:00 | 21.094 | 0 | 通过：18个声明原样输出；无错误/警告 |
| `Probe02a_Instances.lean` | 2026-10-02T16:10:08.165743+08:00 | 22.25 | 1 | 未通过：NormedSpace可推断，ContinuousSMul在1000心跳短诊断下失败 |
| `Probe02b_Adapters.lean` | 2026-10-02T16:14:50.545121+08:00 | 20.782 | 0 | 通过：5个候选定义和8个完整微分/坐标适配示例；2条letI写法提示，无错误 |
| `Probe03_TargetTypes.lean` | 2026-10-02T16:18:02.678215+08:00 | 20.391 | 0 | 通过：同样5个候选定义及7个Prop目标定义；无错误/警告；目标没有证明 |

首次探针运行器设置300秒等待超时，但Windows收集子进程输出使实际经过491.203秒；本报告按真实墙钟计入，不宣称300秒内结束。之后拆开声明类型检查和1000心跳短诊断，不盲目抬高预算重试。

短诊断确认问题出在 `ContinuousSMul` 搜索，不是缺少 `NormedSpace` 或数学假设。直接提供库已证明的 `IsBoundedSMul`，再调用库的连续性实例，Probe02b通过。Probe03采用普通局部证明绑定消除letI写法提示，同样通过：

```lean
local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

local instance (n : ℕ) : ContinuousSMul ℝ (PhaseSpace n) := by
  have : IsBoundedSMul ℝ (PhaseSpace n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul
```

支持模块为 `Mathlib.Analysis.Normed.Module.Basic`、`Mathlib.Topology.MetricSpace.Algebra`。该局部适配不新增公理、不改变NormedSpace、范数或质量条件；正式集成仍应局部使用并重新验证。

八个成功适配示例分别是：相空间fst导数、snd导数、开放区间within→at、两分量合成导数、邻域等式转移到deriv q、质量矩阵坐标等式、逆质量矩阵坐标等式、逆质量连续线性作用的导数。它们是必要接口探针，不是S1双向等价或B3完整桥接证明。

## 4. 局部ODE依赖和未验证范围

`IsIntegralCurveOn` 用 `HasDerivWithinAt`，`IsIntegralCurveAt` 用初始时刻邻域中的HasDerivAt，`IsIntegralCurve`才在全部实时间要求导数。ambient曲线的区间外取值不能作为全局存在证据。

C¹接口前提是 `ContDiffAt ℝ 1 f z₀`，并有 `[CompleteSpace E]`；开区间版本给α、初值和ε>0。eventually版本给附近初值/时间的解，不自动给群律、长期存在或唯一性。Q内停留需由初值和连续性缩短时间，尚未证明。

`IsPicardLindelof` 有四个实际字段：闭球上统一Lipschitz、时间连续、场范数界、小时间乘积界 `L * max (tmax-t₀) (t₀-tmin) ≤ a-r`。本轮只读声明，没有构造机械场的这组证据。

`ODE_solution_unique_of_mem_Ioo` 对公共开区间要求同一常数K的LipschitzOnWith、初始时刻在内部、两条曲线满足导数和空间域成员、相同初值；结论EqOn该开区间。F仅局部Lipschitz到公共小邻域/小时间的构造仍待落实，不以全局Lipschitz悄悄收窄教材。

由Q上C²势能推出C¹的负梯度、再得到机械场C¹/局部Lipschitz的具体固定库证明未检查；本轮不宣称这些接口已经构成完整存在唯一性证明。T2-L0/S1/B1–B4/E1目标均待证明；自由粒子只通过数学陈述核对和目标类型检查；正式构建/CI/网站审阅/负责人签核均未运行或完成。

## 5. API声明的完整实际类型输出

下列块原样取自成功的 `Probe01b_API_Types.log`，没有省略类型前提。原始文件和source/result哈希保留在上层证据目录。

```text
def IsIntegralCurveOn.{u_1} : {E : Type u_1} →
  [inst : NormedAddCommGroup E] → [NormedSpace ℝ E] → (ℝ → E) → (ℝ → E → E) → Set ℝ → Prop :=
fun {E} [NormedAddCommGroup E] [NormedSpace ℝ E] γ v s => ∀ t ∈ s, HasDerivWithinAt γ (v t (γ t)) s t
IsIntegralCurveAt.{u_1} {E : Type u_1} [NormedAddCommGroup E] [NormedSpace ℝ E] (γ : ℝ → E) (v : ℝ → E → E) (t₀ : ℝ) :
  Prop
HasDerivWithinAt.hasDerivAt.{u, v} {𝕜 : Type u} [NontriviallyNormedField 𝕜] {F : Type v} [NormedAddCommGroup F]
  [NormedSpace 𝕜 F] {f : 𝕜 → F} {f' : F} {x : 𝕜} {s : Set 𝕜} (h : HasDerivWithinAt f f' s x) (hs : s ∈ 𝓝 x) :
  HasDerivAt f f' x
IsIntegralCurveOn.isIntegralCurveAt.{u_1} {E : Type u_1} [NormedAddCommGroup E] [NormedSpace ℝ E] {γ : ℝ → E}
  {v : ℝ → E → E} {s : Set ℝ} {t₀ : ℝ} (h : IsIntegralCurveOn γ v s) (hs : s ∈ 𝓝 t₀) : IsIntegralCurveAt γ v t₀
isIntegralCurveAt_iff_exists_pos.{u_1} {E : Type u_1} [NormedAddCommGroup E] [NormedSpace ℝ E] {γ : ℝ → E}
  {v : ℝ → E → E} {t₀ : ℝ} : IsIntegralCurveAt γ v t₀ ↔ ∃ ε > 0, IsIntegralCurveOn γ v (Metric.ball t₀ ε)
HasDerivAt.prodMk.{u, v, w} {𝕜 : Type u} [NontriviallyNormedField 𝕜] {F : Type v} [NormedAddCommGroup F]
  [NormedSpace 𝕜 F] {f₁ : 𝕜 → F} {f₁' : F} {x : 𝕜} {G : Type w} [NormedAddCommGroup G] [NormedSpace 𝕜 G] {f₂ : 𝕜 → G}
  {f₂' : G} (hf₁ : HasDerivAt f₁ f₁' x) (hf₂ : HasDerivAt f₂ f₂' x) : HasDerivAt (fun x => (f₁ x, f₂ x)) (f₁', f₂') x
ContinuousLinearMap.fst.{u_1, u_2, u_3} (R : Type u_1) [Semiring R] (M₁ : Type u_2) [TopologicalSpace M₁]
  [AddCommMonoid M₁] [Module R M₁] (M₂ : Type u_3) [TopologicalSpace M₂] [AddCommMonoid M₂] [Module R M₂] :
  M₁ × M₂ →L[R] M₁
ContinuousLinearMap.snd.{u_1, u_2, u_3} (R : Type u_1) [Semiring R] (M₁ : Type u_2) [TopologicalSpace M₁]
  [AddCommMonoid M₁] [Module R M₁] (M₂ : Type u_3) [TopologicalSpace M₂] [AddCommMonoid M₂] [Module R M₂] :
  M₁ × M₂ →L[R] M₂
HasFDerivAt.comp_hasDerivAt.{u, v, w} {𝕜 : Type u} [NontriviallyNormedField 𝕜] {F : Type v} [NormedAddCommGroup F]
  [NormedSpace 𝕜 F] {E : Type w} [NormedAddCommGroup E] [NormedSpace 𝕜 E] {f : 𝕜 → F} {f' : F} (x : 𝕜) {l : F → E}
  {l' : F →L[𝕜] E} (hl : HasFDerivAt l l' (f x)) (hf : HasDerivAt f f' x) : HasDerivAt (l ∘ f) (l' f') x
Matrix.toEuclideanLin.{u_3, u_7, u_8} {𝕜 : Type u_3} [RCLike 𝕜] {m : Type u_7} {n : Type u_8} [Fintype n]
  [DecidableEq n] : Matrix m n 𝕜 ≃ₗ[𝕜] EuclideanSpace 𝕜 n →ₗ[𝕜] EuclideanSpace 𝕜 m
LinearMap.toContinuousLinearMap.{u, v, x} {𝕜 : Type u} [hnorm : NontriviallyNormedField 𝕜] {E : Type v} [AddCommGroup E]
  [Module 𝕜 E] [TopologicalSpace E] [IsTopologicalAddGroup E] [ContinuousSMul 𝕜 E] {F' : Type x} [AddCommGroup F']
  [Module 𝕜 F'] [TopologicalSpace F'] [IsTopologicalAddGroup F'] [ContinuousSMul 𝕜 F'] [CompleteSpace 𝕜] [T2Space E]
  [FiniteDimensional 𝕜 E] : (E →ₗ[𝕜] F') ≃ₗ[𝕜] E →L[𝕜] F'
ContinuousLinearMap.hasFDerivAt.{u_1, u_2, u_3} {𝕜 : Type u_1} [NontriviallyNormedField 𝕜] {E : Type u_2}
  [AddCommGroup E] [Module 𝕜 E] [TopologicalSpace E] {F : Type u_3} [AddCommGroup F] [Module 𝕜 F] [TopologicalSpace F]
  (f : E →L[𝕜] F) {x : E} : HasFDerivAt (⇑f) f x
HasDerivAt.deriv.{u, v} {𝕜 : Type u} [NontriviallyNormedField 𝕜] {F : Type v} [NormedAddCommGroup F] [NormedSpace 𝕜 F]
  {f : 𝕜 → F} {f' : F} {x : 𝕜} (h : HasDerivAt f f' x) : deriv f x = f'
HasDerivAt.congr_of_eventuallyEq.{u, v} {𝕜 : Type u} [NontriviallyNormedField 𝕜] {F : Type v} [NormedAddCommGroup F]
  [NormedSpace 𝕜 F] {f f₁ : 𝕜 → F} {f' : F} {x : 𝕜} (h : HasDerivAt f f' x) (h₁ : f₁ =ᶠ[𝓝 x] f) : HasDerivAt f₁ f' x
ContDiffAt.exists_eventually_eq_hasDerivAt.{u_1} {E : Type u_1} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [CompleteSpace E] {f : E → E} {x₀ : E} (hf : ContDiffAt ℝ 1 f x₀) (t₀ : ℝ) :
  ∃ α, ∀ᶠ (xt : E × ℝ) in 𝓝 x₀ ×ˢ 𝓝 t₀, α xt.1 t₀ = xt.1 ∧ HasDerivAt (α xt.1) (f (α xt.1 xt.2)) xt.2
ContDiffAt.exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀.{u_1} {E : Type u_1} [NormedAddCommGroup E]
  [NormedSpace ℝ E] [CompleteSpace E] {f : E → E} {x₀ : E} (hf : ContDiffAt ℝ 1 f x₀) (t₀ : ℝ) :
  ∃ α, α t₀ = x₀ ∧ ∃ ε > 0, ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), HasDerivAt α (f (α t)) t
IsPicardLindelof.exists_eq_forall_mem_Icc_hasDerivWithinAt.{u_1} {E : Type u_1} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [CompleteSpace E] {f : ℝ → E → E} {tmin tmax : ℝ} {t₀ : ↑(Icc tmin tmax)} {x₀ x : E} {a r L K : NNReal}
  (hf : IsPicardLindelof f t₀ x₀ a r L K) (hx : x ∈ Metric.closedBall x₀ ↑r) :
  ∃ α, α ↑t₀ = x ∧ ∀ t ∈ Icc tmin tmax, HasDerivWithinAt α (f t (α t)) (Icc tmin tmax) t
ODE_solution_unique_of_mem_Ioo.{u_1} {E : Type u_1} [NormedAddCommGroup E] [NormedSpace ℝ E] {v : ℝ → E → E}
  {s : ℝ → Set E} {K : NNReal} {f g : ℝ → E} {a b t₀ : ℝ} (hv : ∀ t ∈ Ioo a b, LipschitzOnWith K (v t) (s t))
  (ht : t₀ ∈ Ioo a b) (hf : ∀ t ∈ Ioo a b, HasDerivAt f (v t (f t)) t ∧ f t ∈ s t)
  (hg : ∀ t ∈ Ioo a b, HasDerivAt g (v t (g t)) t ∧ g t ∈ s t) (heq : f t₀ = g t₀) : EqOn f g (Ioo a b)
```

## 6. 成功源/输出哈希

| 检查 | 源SHA256 | 原始输出SHA256 |
| --- | --- | --- |
| Probe01b_API_Types | `df990387cbab20309c3d23478e9a28f8a94b68d281994e8b43e2cdc99d4236f8` | `c6a356758f88916e350152cf32d7f208a4a9c6fe99c165d25cfd717ba958a791` |
| Probe02b_Adapters | `11ba492fe3a407c27f207a08c4d99e29c01875f3950692a743917a7d28096625` | `7f75f99685eac64c94d1cc8c68f383e9c475f96a7a972caf2fd5439eaec15c93` |
| Probe03_TargetTypes | `b36eac8c065c20b8659fbc4ea8244ebd8ec68d8f50c88f4d207e1167a8b06f15` | `8cedb16a990277382103fd272cb2269d45a7d9655e8dd1df9600774a7eb608f2` |
