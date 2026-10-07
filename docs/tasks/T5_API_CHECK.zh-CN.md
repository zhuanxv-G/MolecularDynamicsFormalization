# T5 固定版本 API 与小型探针检查

2026-10-02本轮准备已验证：四候选定义、六待证Prop类型；29个库声明检查及一个非严格谓词定义打印；六个拓扑小适配；六个边界命名小引理与一个连续性example。五份最终采用探针均退出0且无警告，原始失败和被替代成功保留。一般T5目标/正式集成尚未实施。接口或样例数不代表教材证明进度。

## 固定输入与运行方法

Lean `leanprover/lean4:v4.34.0`；mathlib `5ed2965256430c3649e86755f9576b54eca72435`。源码基准HEAD `121a9d02ad15500c630e505b363d5f04106d617f`。进入正式工程运行：

```powershell
& 'C:/Users/ustc/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe' -X utf8 '../tmp/t5-preparation-20261002/run_probe.py' 'Probe01_TargetTypes.lean'
```

底层命令为固定toolchain的 `lake.exe env lean <探针绝对路径>`；其余四份同样替换末尾文件名。已有result/log不覆盖，新重跑必须取新attempt名。180秒超时仅清理已知该探针PID树；本批没有发生超时。每次command/cwd/时间/退出码/源码与输出SHA/runner SHA均在同名result.json。

## 全部尝试

| 探针stem（隔离T5目录内） | 退出码 | 秒数 | 最终采用 | 原因或检查范围 |
| --- | ---: | ---: | --- | --- |
| api-topology/Probe00_StrictNamesAbsent | 1 | 26.141 | 否 | 故意负测试：两个严格谓词Unknown identifier；不是通过 |
| api-topology/Probe01_API | 0 | 39.984 | 是 | 3组23声明完整类型，无错误/警告 |
| api-topology/Probe02_Adapters | 0 | 10.453 | 是 | 4拓扑适配，无错误/警告 |
| Probe01_TargetTypes | 0 | 10.594 | 是 | 四定义/六目标类型；目标未证明 |
| Probe02_Boundaries | 1 | 10.954 | 否 | 失败：dist_pos.mp已给≠，误加ne_of_gt；宽simp留下0≤R；错误声明出现sorryAx，不采用 |
| Probe02b_Boundaries | 0 | 10.906 | 否 | 六小引理通过；一个<;>风格提示；由02c替代 |
| Probe02c_Boundaries | 0 | 11.375 | 是 | 六命名边界小引理+quartic连续性；零错误/警告 |
| Probe03_KeyAPI | 1 | 8.469 | 否 | 窄imports缺MetricSpace/Defs，导致dist_pos及MetricSpace无法解析；不采用 |
| Probe03b_KeyAPI | 0 | 8.25 | 是 | 补正import；6声明+IsMinFilter定义；两个直接库适配 |

本批只采用保存的退出0/无警告最终版本。失败文件未使用占位关键字；Lean对错误声明产生sorryAx的输出不是可接受证明。日志保存原字节，不清洗失败或提示。PROBE_AUDIT.json逐次重核原始输入和输出哈希，manifest补充字节数和所有文件SHA。

## 关键声明与实际条件

| 用途 | 声明 / 固定模块 | 必须保留的条件 |
| --- | --- | --- |
| 一致严格下界 | IsCompact.exists_forall_le' / Mathlib.Topology.Order.Compact | K紧、ContinuousOn、点态严格差；接口不需Nonempty，ℝ的NoMaxOrder成立 |
| 极小点取得 | IsCompact.exists_isMinOn / 同模块 | 必须K.Nonempty；结果分开给x∈K和IsMinOn |
| 相对半径基 | Metric.mem_nhdsWithin_iff / Mathlib.Topology.MetricSpace.Pseudo.Defs | 球∩相对集合；用于去心域Q\{q₀} |
| 非严格极小 | IsLocalMinOn / Mathlib.Topology.Order.LocalExtr；IsMinFilter / Mathlib.Order.Filter.Extr | ≤事件，不能当strict；固定库strict名字不存在 |
| 距离与不等 | dist_pos / Mathlib.Topology.MetricSpace.Defs | 实际MetricSpace；仅导入Pseudo/ProperSpace不保证此类可见 |
| 球面紧 | isCompact_sphere / Mathlib.Topology.MetricSpace.ProperSpace | ProperSpace，不需要非空 |
| 有限维proper | FiniteDimensional.proper_real / Mathlib.Analysis.Normed.Module.FiniteDimension | 实有限维范数空间；Position n任意n已实例化 |
| 域内球 | Metric.isOpen_iff、IsOpen.mem_nhds | Q开+q₀∈Q；只有相对strict不能省掉域邻域证据 |
| 内球面 | Metric.sphere_subset_ball、Metric.ne_of_mem_sphere | r<R及r≠0；球面距离顺序dist q q₀ |
| 内闭球 | Metric.closedBall_subset_ball | r<R；可确保closedBall q₀ r⊆Q |
| 球面非空 | NormedSpace.sphere_nonempty / Mathlib.Analysis.Normed.Module.RCLike.Real | NontrivialTopology；结果Nonempty↔0≤r，不能套到n=0 |
| 连续限制/差 | ContinuousOn.mono、ContinuousOn.sub、continuousOn_const | 先sphere⊆Q再限制；差值U−U(q₀)连续 |

API_TOPOLOGY_REPORT和API_TOPOLOGY_INPUTS保留分工的23声明及12库源码输入；API_EXTRA_INPUTS补充root核对的4模块。两份清单的原始字节SHA须结合固定mathlib HEAD核验。严格名字除故意负探针外，也有全固定mathlib源码rg无命中记录。

## 实际小适配与边界证明

拓扑分工四适配：Position n球面紧；非空球面势能差取得极小点（成员证据保留）；小球面处于大开球且不等中心；Q开且中心在Q则有内球。root另有两个直接库适配：紧集连续函数的a'>c一致下界、去心相对域的球邻域基。尚未用它们证明六个一般Goal。

边界分工由root实际检查：Position 0正半径sphere=∅且δ=1；实数quartic在0严格极小、每个r>0有δ=r⁴屏障；常数势能在0非严格局部极小且非strict。另检查quartic连续。没有编译r=R反例、非紧/不连续反例、quartic二阶导数或Position 1坐标等距桥接。

以下为三个命名拓扑小引理和六个边界小引理的原始公理输出；均只含Lean标准逻辑公理propext/Classical.choice/Quot.sound，无项目新增公理。三个anonymous拓扑example和连续性example有编译证据，但未单独#print axioms。

```text
'T5TopologyPreparation.sphere_in_small_ball' depends on axioms: [propext, Classical.choice, Quot.sound]
'T5Preparation.compact_strict_lower_adapter' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
'T5Preparation.punctured_basis_adapter' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
'T5Preparation.zero_dimensional_sphere_empty' depends on axioms: [propext, Classical.choice, Quot.sound]
'T5Preparation.zero_dimensional_barrier' depends on axioms: [propext, Classical.choice, Quot.sound]
'T5Preparation.quartic_strict_min' depends on axioms: [propext, Classical.choice, Quot.sound]
'T5Preparation.quartic_sphere_barrier' depends on axioms: [propext, Classical.choice, Quot.sound]
'T5Preparation.constant_local_min' depends on axioms: [propext, Classical.choice, Quot.sound]
'T5Preparation.constant_not_strict' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## 完整实际API类型输出

Probe01_API的23个声明：

```text
@IsLocalMin.{u_1,
    u_2} : {α : Type u_1} → {β : Type u_2} → [TopologicalSpace.{u_1} α] → [Preorder.{u_2} β] → (α → β) → α → Prop
@IsLocalMinOn.{u_1,
    u_2} : {α : Type u_1} →
  {β : Type u_2} → [TopologicalSpace.{u_1} α] → [Preorder.{u_2} β] → (α → β) → Set.{u_1} α → α → Prop
@IsMinOn.{u_1, u_2} : {α : Type u_1} → {β : Type u_2} → [Preorder.{u_2} β] → (α → β) → Set.{u_1} α → α → Prop
@isMinOn_iff.{u_1,
    u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : Preorder.{u_2} β] {f : α → β} {s : Set.{u_1} α} {a : α},
  IsMinOn.{u_1, u_2} f s a ↔ ∀ (x : α), Membership.mem.{u_1, u_1} s x → LE.le.{u_2} (f a) (f x)
@IsLocalMinOn.isLocalMin.{u_1,
    u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : TopologicalSpace.{u_1} α] [inst_1 : Preorder.{u_2} β] {f : α → β}
  {s : Set.{u_1} α} {a : α},
  IsLocalMinOn.{u_1, u_2} f s a → Membership.mem.{u_1, u_1} (nhds.{u_1} a) s → IsLocalMin.{u_1, u_2} f a
@Metric.eventually_nhds_iff_ball.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {p : α → Prop},
  (∀ᶠ (y : α) in nhds.{u_1} x, p y) ↔
    ∃ ε, GT.gt.{0} ε 0 ∧ ∀ (y : α), Membership.mem.{u_1, u_1} (Metric.ball.{u_1} x ε) y → p y
@Metric.mem_nhds_iff.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {s : Set.{u_1} α},
  Membership.mem.{u_1, u_1} (nhds.{u_1} x) s ↔ ∃ ε, GT.gt.{0} ε 0 ∧ Metric.ball.{u_1} x ε ⊆ s
@Metric.isOpen_iff.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {s : Set.{u_1} α},
  IsOpen.{u_1} s ↔ ∀ (x : α), Membership.mem.{u_1, u_1} s x → ∃ ε, GT.gt.{0} ε 0 ∧ Metric.ball.{u_1} x ε ⊆ s
@Metric.isOpen_ball.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {ε : ℝ},
  IsOpen.{u_1} (Metric.ball.{u_1} x ε)
FiniteDimensional.proper.{u_1,
  u_2} : ∀ (𝕜 : Type u_1) [inst : NontriviallyNormedField.{u_1} 𝕜] (E : Type u_2) [inst_1 : NormedAddCommGroup.{u_2} E]
  [inst_2 : NormedSpace.{u_1, u_2} 𝕜 E] [LocallyCompactSpace.{u_1} 𝕜] [FiniteDimensional.{u_1, u_2} 𝕜 E],
  ProperSpace.{u_2} E
FiniteDimensional.proper_real.{u_1} : ∀ (E : Type u_1) [inst : NormedAddCommGroup.{u_1} E]
  [inst_1 : NormedSpace.{0, u_1} ℝ E] [FiniteDimensional.{0, u_1} ℝ E], ProperSpace.{u_1} E
@isCompact_sphere.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] [ProperSpace.{u_1} α] (x : α) (r : ℝ),
  IsCompact.{u_1} (Metric.sphere.{u_1} x r)
@IsCompact.exists_isMinOn.{u_1,
    u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : LinearOrder.{u_1} α] [inst_1 : TopologicalSpace.{u_1} α]
  [inst_2 : TopologicalSpace.{u_2} β] [ClosedIicTopology.{u_1} α] {s : Set.{u_2} β},
  IsCompact.{u_2} s →
    Set.Nonempty.{u_2} s →
      ∀ {f : β → α}, ContinuousOn.{u_2, u_1} f s → ∃ x, Membership.mem.{u_2, u_2} s x ∧ IsMinOn.{u_2, u_1} f s x
@ContinuousOn.sub.{u_1,
    u_2} : ∀ {G : Type u_1} {X : Type u_2} [inst : TopologicalSpace.{u_2} X] [inst_1 : TopologicalSpace.{u_1} G]
  [inst_2 : Sub.{u_1} G] [ContinuousSub.{u_1} G] {f g : X → G} {s : Set.{u_2} X},
  ContinuousOn.{u_2, u_1} f s →
    ContinuousOn.{u_2, u_1} g s → ContinuousOn.{u_2, u_1} (HSub.hSub.{max u_1 u_2, max u_1 u_2, max u_1 u_2} f g) s
@continuousOn_const.{u_1,
    u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : TopologicalSpace.{u_1} α] [inst_1 : TopologicalSpace.{u_2} β]
  {s : Set.{u_1} α} {c : β}, ContinuousOn.{u_1, u_2} (fun x => c) s
@ContinuousOn.mono.{u_1,
    u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : TopologicalSpace.{u_1} α] [inst_1 : TopologicalSpace.{u_2} β]
  {f : α → β} {s t : Set.{u_1} α}, ContinuousOn.{u_1, u_2} f s → t ⊆ s → ContinuousOn.{u_1, u_2} f t
@Metric.mem_sphere.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x y : α} {ε : ℝ},
  Membership.mem.{u_1, u_1} (Metric.sphere.{u_1} x ε) y ↔ Eq.{1} (Dist.dist.{u_1} y x) ε
@Metric.sphere_subset_ball.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {r R : ℝ},
  LT.lt.{0} r R → Metric.sphere.{u_1} x r ⊆ Metric.ball.{u_1} x R
@Metric.ne_of_mem_sphere.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x y : α} {ε : ℝ},
  Membership.mem.{u_1, u_1} (Metric.sphere.{u_1} x ε) y → Ne.{1} ε 0 → Ne.{u_1 + 1} y x
@Metric.sphere_eq_empty_of_subsingleton.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {ε : ℝ}
  [Subsingleton.{u_1 + 1} α], Ne.{1} ε 0 → Eq.{u_1 + 1} (Metric.sphere.{u_1} x ε) EmptyCollection.emptyCollection.{u_1}
@Metric.sphere_eq_empty_of_neg.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {ε : ℝ},
  LT.lt.{0} ε 0 → Eq.{u_1 + 1} (Metric.sphere.{u_1} x ε) EmptyCollection.emptyCollection.{u_1}
@NormedSpace.sphere_nonempty.{u_1} : ∀ {E : Type u_1} [inst : SeminormedAddCommGroup.{u_1} E] [NormedSpace.{0, u_1} ℝ E]
  [NontrivialTopology.{u_1} E] {x : E} {r : ℝ}, Set.Nonempty.{u_1} (Metric.sphere.{u_1} x r) ↔ LE.le.{0} 0 r
@eventually_nhdsWithin_iff.{u_1} : ∀ {α : Type u_1} [inst : TopologicalSpace.{u_1} α] {a : α} {s : Set.{u_1} α}
  {p : α → Prop},
  (∀ᶠ (x : α) in nhdsWithin.{u_1} a s, p x) ↔ ∀ᶠ (x : α) in nhds.{u_1} a, Membership.mem.{u_1, u_1} s x → p x
```

Probe03b的6个声明、IsMinFilter定义及公理输出：

```text
@IsCompact.exists_forall_le'.{u_1,
    u_2} : ∀ {α : Type u_1} {β : Type u_2} [inst : LinearOrder.{u_1} α] [inst_1 : TopologicalSpace.{u_1} α]
  [inst_2 : TopologicalSpace.{u_2} β] [ClosedIicTopology.{u_1} α] [NoMaxOrder.{u_1} α] {f : β → α} {s : Set.{u_2} β},
  IsCompact.{u_2} s →
    ContinuousOn.{u_2, u_1} f s →
      ∀ {a : α},
        (∀ (b : β), Membership.mem.{u_2, u_2} s b → LT.lt.{u_1} a (f b)) →
          ∃ a', LT.lt.{u_1} a a' ∧ ∀ (b : β), Membership.mem.{u_2, u_2} s b → LE.le.{u_1} a' (f b)
@Metric.mem_nhdsWithin_iff.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {s t : Set.{u_1} α},
  Membership.mem.{u_1, u_1} (nhdsWithin.{u_1} x t) s ↔
    ∃ ε, GT.gt.{0} ε 0 ∧ Inter.inter.{u_1} (Metric.ball.{u_1} x ε) t ⊆ s
@dist_pos.{u_1} : ∀ {γ : Type u_1} [inst : MetricSpace.{u_1} γ] {x y : γ},
  LT.lt.{0} 0 (Dist.dist.{u_1} x y) ↔ Ne.{u_1 + 1} x y
@IsOpen.mem_nhds.{u_1} : ∀ {X : Type u_1} [inst : TopologicalSpace.{u_1} X] {x : X} {s : Set.{u_1} X},
  IsOpen.{u_1} s → Membership.mem.{u_1, u_1} s x → Membership.mem.{u_1, u_1} (nhds.{u_1} x) s
@Metric.closedBall_subset_ball.{u_1} : ∀ {α : Type u_1} [inst : PseudoMetricSpace.{u_1} α] {x : α} {ε₁ ε₂ : ℝ},
  LT.lt.{0} ε₁ ε₂ → Metric.closedBall.{u_1} x ε₁ ⊆ Metric.ball.{u_1} x ε₂
@IsMinFilter.{u_1, u_2} : {α : Type u_1} → {β : Type u_2} → [Preorder.{u_2} β] → (α → β) → Filter.{u_1} α → α → Prop
def IsMinFilter.{u, v} : {α : Type u} → {β : Type v} → [Preorder.{v} β] → (α → β) → Filter.{u} α → α → Prop :=
fun {α} {β} [Preorder.{v} β] f l a => ∀ᶠ (x : α) in l, LE.le.{v} (f a) (f x)
'T5Preparation.compact_strict_lower_adapter' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
'T5Preparation.punctured_basis_adapter' depends on axioms: [propext, Classical.choice.{u}, Quot.sound.{u}]
```

## 尚未完成

T5-D1/C1/S1/O1一般完整证明，正式源码集成及其构建，MathCopilot独立审阅、负责人教材语义签核，真实轨道/沿解守恒/动量控制/延拓和Theorem1.1。正式源码未改，本轮未重跑check.ps1或远端CI；旧T1构建不能充当T5验收。
