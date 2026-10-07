# T2 陈述与依赖独立审阅

批次：`T2-statements-20261002-readonly`。本报告是 `/lean-blueprint` 的只读使用记录：只审阅 T2 的对象、量词、假设、结论、API 与依赖图，不生成 Lean skeleton，不起草证明，不修改正式源码。

## 1. 总结结论

- 20 个冻结输入区块完整取得并逐块校验。20/20 的附件原始正文都与区块声明的原文件字节数和 SHA256 完全一致。
- 五个候选定义的类型和语义均可接受。
- 七个 ID 中，`T2-S1`、`T2-B1`、`T2-B2`、`T2-B4`、`T2-E1` 接受；`T2-L0` 需要把已探针通过的两个坐标桥接显式列入该 ID 的声明包；`T2-B3` 需要区分“只依赖给定 `hFU` 的代数核心”和“势能在相应点真实可微的教材梯度应用”。
- 当前候选都是曾经类型通过的 `Prop` 描述，不是定理，也没有证明。上述接受只表示陈述契约可进入后续负责人复核，不表示证明完成。
- T1 的 13 条现有证明已经通过上一批独立审阅，未发现会改变 T2 坐标数、质量正性或矩阵 inverse 依赖的阻断项。负责人语义签核仍须单独登记。

## 2. 输入、换行与逐块 SHA 状态

附件实际路径：`/workspace/.mathcopilot/attachments/fcf5b4dd-3966-4fda-b4b4-0c27bbf52196/01-paste-1.txt`。

| 层级 | 字节数 | SHA256 | 结论 |
| --- | ---: | --- | --- |
| 附件原始字节 | 93795 | `00dd541e8dfd87e318a4115679fe954dc91917e24cb6806ab82671ecc794ec5c` | 与本批给定值完全一致 |
| 整体 CRLF→LF 后的传输文本 | 92847 | `166744dc5db793392f29f541d903778f93ed3ac013e1951203b07fb67c94a1e9` | 与本批给定值完全一致；只证明传输文本一致 |

附件中共有 948 个 CRLF，且没有裸 CR。整体 LF 哈希不能替代各区块的原文件哈希。以下逐块校验排除了包裹区块标记自身的换行：

| # | 冻结区块 | 原文件 bytes | 原文件 SHA256 | 原文件换行 | 逐字节结果 |
| ---: | --- | ---: | --- | --- | --- |
| 1 | `MolecularDynamicsFormalization/docs/tasks/T2_SPEC.zh-CN.md` | 17229 | `ae02b5e952608d47a84e4b5be233f5a4e7bb4bd8dc121c2e7565447dc38f6e34` | CRLF | 通过 |
| 2 | `MolecularDynamicsFormalization/docs/tasks/T2_API_CHECK.zh-CN.md` | 13892 | `397bace1248bf92f39a5447a081a3feacda72ad8840a28ada228516c4527ad8e` | CRLF | 通过 |
| 3 | `MolecularDynamicsFormalization/docs/tasks/T2_INPUTS_AND_ACCEPTANCE.zh-CN.md` | 7000 | `5b70df1c6d9df891f02db4f5e2bfcb32a7573e9563a67a3da917f79b585f3671` | CRLF | 通过 |
| 4 | `tmp/t2-preparation/ORIGINAL_PAGES.zh-CN.md` | 2604 | `4d71abfca3d457b0f96d9361c574b4082561582ff9da420b40f4ed5c1fff4439` | LF | 通过 |
| 5 | `tmp/t2-preparation/T2_INPUT_MANIFEST.csv` | 7839 | `2f90e636288d54e0b739124b65309f815c812818a2be9d4508179070e2b7a5c6` | CRLF | 通过 |
| 6 | `tmp/t2-preparation/Probe01_APIs.lean` | 2314 | `08c873790a15774be792bf20205f7610bad2149a3b4bb794089be34fe2666e0f` | LF | 通过 |
| 7 | `tmp/t2-preparation/Probe01_APIs.log` | 8327 | `0d6be1cffe44acde93198ee0d46e5c0515a9831f77442516bd6801d9bd8b8de5` | CRLF | 通过 |
| 8 | `tmp/t2-preparation/Probe01_APIs.result.json` | 709 | `12ae5820a2d4450491b783fcb6b7c275b8f60fd6aa82ba3ad96b72aaa1fd7d58` | CRLF | 通过 |
| 9 | `tmp/t2-preparation/Probe01b_API_Types.lean` | 841 | `df990387cbab20309c3d23478e9a28f8a94b68d281994e8b43e2cdc99d4236f8` | LF | 通过 |
| 10 | `tmp/t2-preparation/Probe01b_API_Types.log` | 5505 | `c6a356758f88916e350152cf32d7f208a4a9c6fe99c165d25cfd717ba958a791` | CRLF | 通过 |
| 11 | `tmp/t2-preparation/Probe01b_API_Types.result.json` | 712 | `f7cda1a75e90f32f02937046ad8939f96879ce8e8e2e6ec645c48f5bf1bfcc71` | CRLF | 通过 |
| 12 | `tmp/t2-preparation/Probe02a_Instances.lean` | 434 | `d8fd56a1e7dbaae7c999a1dd2e752b221da7be691316b0c052d9a6e64175986f` | LF | 通过 |
| 13 | `tmp/t2-preparation/Probe02a_Instances.log` | 2266 | `d7135fa202a5cec2842b64af28423e0f808e829d642f4673f9b8284edda221d4` | CRLF | 通过 |
| 14 | `tmp/t2-preparation/Probe02a_Instances.result.json` | 711 | `e3b5d1c82344824dd415bf1745f9ab48699030c143d4c4cc9f43c5a321a2cac3` | CRLF | 通过 |
| 15 | `tmp/t2-preparation/Probe02b_Adapters.lean` | 3411 | `11ba492fe3a407c27f207a08c4d99e29c01875f3950692a743917a7d28096625` | LF | 通过 |
| 16 | `tmp/t2-preparation/Probe02b_Adapters.log` | 1248 | `7f75f99685eac64c94d1cc8c68f383e9c475f96a7a972caf2fd5439eaec15c93` | CRLF | 通过 |
| 17 | `tmp/t2-preparation/Probe02b_Adapters.result.json` | 711 | `b4be86731768247f48cf6b64964284e5dfba51fe0f1f3586c519a127446ae38a` | CRLF | 通过 |
| 18 | `tmp/t2-preparation/Probe03_TargetTypes.lean` | 4537 | `b36eac8c065c20b8659fbc4ea8244ebd8ec68d8f50c88f4d207e1167a8b06f15` | CRLF | 通过 |
| 19 | `tmp/t2-preparation/Probe03_TargetTypes.log` | 2848 | `8cedb16a990277382103fd272cb2269d45a7d9655e8dd1df9600774a7eb608f2` | CRLF | 通过 |
| 20 | `tmp/t2-preparation/Probe03_TargetTypes.result.json` | 713 | `781c200c8e4e06d40e0516025025d8c2133b4733a6df203f92488afe54d6356a` | CRLF | 通过 |

其中 15 个 CRLF 区块若被粘贴层统一为 LF，其原文件字节数和 SHA256 会改变；5 个 LF 区块不受正文换行转换影响。本轮能够对 20 个原始正文逐字节通过，是因为当前附件保留了各区块原始换行，而不是因为整体 LF 哈希能够证明这些原文件。

历史 `T2_MATHCOPILOT_PROMPT.zh-CN.md` 是清单中的第 21 个文件，但本批有意未发送；本报告只执行附件首部的新指令，没有执行该历史文件可能包含的证明起草内容。

## 3. 仓库、固定对象、环境与教材

- 实际工作目录：`/workspace/MolecularDynamicsFormalization`。
- remote：`https://github.com/zhuanxv-G/MolecularDynamicsFormalization.git`。
- 实际分支：`chapter01-kinetic-energy-nonneg`。
- 实际 HEAD：`bdcd1ecd710db5fbd6b8698e9ee3d3e05d535045`。
- 指令所述后续本地 HEAD `121a9d02ad15500c630e505b363d5f04106d617f` 不在当前对象库中；没有据此假装读取。
- 数学输入对象 `54b75a14aaa968522903d82eef947ffdc7bbf165` 与目录固定对象 `052eea2edd51fd806edf6a9dacbb6cc3353fc82f` 均可读；二者在 `MolecularDynamics/`、顶层 Lean 导入、`Scratch.lean`、工具链、manifest 和脚本范围内无差异。
- 固定对象的 `lean-toolchain` 为 `leanprover/lean4:v4.34.0`，manifest 的 mathlib revision 为 `5ed2965256430c3649e86755f9576b54eca72435`。附件中的历史探针另记录 Lean commit `293d5d0c0c3f3dded4688b3ccd6a33939ac5102b`。本轮没有启动 Lean，因此这些是固定配置和历史运行证据，不是新的运行时版本查询。
- 本轮开始时 tracked diff 为空；只有上一批 T1 的七个审阅文件未跟踪。本报告不修改或覆盖它们。

实际教材文件 `/workspace/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf` 为 11701675 字节、461 页，SHA256 为 `1939a22e5e96ebd2b58b8e91fe2c796f5390b402f267390f473b271c35d2f036`。本轮直接读取了 PDF 41–42、47–49 的文本层，确认：

- (1.3) 为固定对角质量矩阵下的 `M q̈ = F(q) = -∇U(q)`；`n` 应对应环境坐标数 `N_c`，不是约束自由度 `N_d`。
- 固定质量时的一阶形式为 `q̇=M⁻¹p`、`ṗ=F=-∂U/∂q`。
- §1.5 只概述典型系统的存在唯一性及额外全局条件，没有给出本批采用的精确开放配置域、开时间区间或全部局部 Lipschitz 假设。

本轮未生成或读取新的页面图像，所以不声称完成了新的图像级公式复核。

## 4. T1 对 T2 的实际影响

上一批网站 T1 审阅实际读取了固定对象 `052eea2...`，结论为 11 个 ID、13 条定理全部接受且无阻断缺陷。对 T2 的影响如下：

1. `n` 继续表示 `N_c`；粒子到坐标质量的展开和 `d=3` 排列不变。
2. `hμ : ∀ i, 0 < μ i` 是 T2 使用质量矩阵两侧 inverse 的统一物理入口。T1 的 P3–P5 已提供两侧矩阵逆与 `mulVec` 恢复，不允许无条件解释奇异矩阵 inverse。
3. T1 的动能等式不提供轨道、导数、ODE、势能可微性或守恒；T2 必须独立建立这些对象和桥接。
4. T1 负责人最终语义签核在现有 T1 报告中仍标为 `pending`。用户已确认 T1 完成且无阻断依赖，因此它不阻塞本次陈述审阅，但本报告不把负责人签核改写为已完成。

## 5. 五个候选定义

| 定义 | 审阅 | 精确语义与边界 |
| --- | --- | --- |
| `massOperator μ : Velocity n →L[ℝ] Momentum n` | 接受 | 由 `Matrix.toEuclideanLin (diagonalMassMatrix μ)` 再转连续线性映射；定义本身不需要质量正性。 |
| `velocityOperator μ : Momentum n →L[ℝ] Velocity n` | 接受 | 使用矩阵 inverse 的总操作；只有把它解释为真实逆映射的定理才必须带 `hμ`。 |
| `mechanicalVectorField μ F z = (velocityOperator μ z.2, F z.1)` | 接受 | 固定质量的一阶自治机械场；没有引入势能或保守力假设。 |
| `IsMechanicalSolutionOn μ F Q I γ` | 接受 | 同时要求 `q(t)∈Q` 与 `IsIntegralCurveOn`；内部导数是 `HasDerivWithinAt`。定义允许一般集合 `I`，不在定义层伪装成全局解。 |
| `IsLocalMechanicalIVP μ F Q t₀ z₀ ε γ` | 接受 | `0<ε`、`γ t₀=z₀`，并在对称开区间 `Ioo (t₀-ε) (t₀+ε)` 上为解。由 `0<ε` 可知 `t₀` 在区间内部，初值的配置域成员可由解谓词和初值等式推出。 |

`Matrix.toEuclideanLin` 只产生线性映射，继续调用 `LinearMap.toContinuousLinearMap` 是必要的。附件探针通过局部、库内已证明的 `ContinuousSMul` 实例解决了类型类搜索超时；它不是新的数学假设。

## 6. 七个 ID 的完整候选契约

下面保留 Probe03 已类型通过的量词顺序。代码块只是待证明命题的陈述记录，不是 Lean 源码、不含证明。

### T2-L0 — 修订声明包

候选根命题：

```lean
massInverseGoal {n} (μ : CoordinateMasses n) : Prop :=
  (∀ i, 0 < μ i) →
    (∀ p : Momentum n, massOperator μ (velocityOperator μ p) = p) ∧
    (∀ v : Velocity n, velocityOperator μ (massOperator μ v) = v)
```

该根命题接受：正质量只用于两侧逆，量词覆盖全部动量和速度。修订点不在根结论，而在 ID 完整性：规格还要求显式保存 `massOperator μ v` 与 `(diagonalMassMatrix μ).mulVec v` 的坐标等式，以及 `velocityOperator μ p` 与 `((diagonalMassMatrix μ)⁻¹).mulVec p` 的坐标等式。它们已在适配探针中以 `rfl` 类型通过，但未出现在 `massInverseGoal`。后续应作为 L0 的两个辅助声明登记，不能只留在探针或把它们视为根命题自动包含的内容。

### T2-S1 — 接受

```lean
componentsGoal {n} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  IsOpen I →
    (IsMechanicalSolutionOn μ F Q I γ ↔
      (∀ t ∈ I, (γ t).1 ∈ Q) ∧
      ∀ t ∈ I,
        HasDerivAt (fun s => (γ s).1) (velocityOperator μ (γ t).2) t ∧
        HasDerivAt (fun s => (γ s).2) (F (γ t).1) t)
```

`IsOpen I` 精确用于把 `HasDerivWithinAt` 转为双侧 `HasDerivAt`。不需要质量正性、`F` 连续或 `Q` 开放。反向分量合成也没有额外隐藏假设。

### T2-B1 — 接受

```lean
momentumGoal {n} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ i, 0 < μ i) → IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    ∀ t ∈ I, (γ t).2 = massOperator μ (deriv (fun s => (γ s).1) t)
```

量词和前提足够且没有把 `p=Mq̇` 预塞进解定义。`hμ` 只用于 L0 的 inverse；`IsOpen I` 用于取得真实双侧导数。

### T2-B2 — 接受

```lean
secondDerivativeGoal {n} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    ∀ t ∈ I, HasDerivAt (deriv (fun s => (γ s).1))
      (velocityOperator μ (F (γ t).1)) t
```

该陈述正确地不要求正质量：它只对固定连续线性映射 `velocityOperator μ` 求导。依赖必须是开集邻域上 `deriv q = velocityOperator μ ∘ p` 的 eventually equality；单点 `deriv q t = ...` 不足以推出该二阶导数。

### T2-B3 — 修订为两层语义

当前候选：

```lean
nBodyBridgeGoal {n} (μ : CoordinateMasses n) (F : Force n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ i, 0 < μ i) → IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    (∀ q ∈ Q, F q = -gradient U q) →
    ∀ t ∈ I, NBodyEquationAt μ F U (γ t).1
      (deriv (deriv (fun s => (γ s).1)) t)
```

此命题作为**代数核心**是准确的：`NBodyEquationAt` 本身使用总定义的 `gradient`，而 `hFU` 直接给出第二个合取项，因此证明该命题不需要再对 `U` 求导。但是若把它称为教材意义下“力来自可微势能的梯度”，当前前提不足。

建议后续把状态拆开：

1. 保留当前候选，但命名或文档明确为 `hFU` 驱动的代数桥接。
2. 另给教材语义应用层，除当前前提外明确要求 `∀ q ∈ Q, DifferentiableAt ℝ U q`，或者在 `IsOpen Q` 下使用等价的 `DifferentiableOn ℝ U Q`。该可微性不是代数证明所需，而是 `gradient U q` 真正表示势能梯度的语义条件。

不得从任意 `F` 推出 `hFU`，也不得把 B3 报告成存在唯一性、轨道构造或守恒定理。

### T2-B4 — 接受

```lean
newtonToFirstOrderGoal {n} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ)
    (q v a : ℝ → Position n) : Prop :=
  (∀ i, 0 < μ i) → (∀ t ∈ I, q t ∈ Q) →
    (∀ t ∈ I, HasDerivAt q (v t) t ∧ HasDerivAt v (a t) t ∧
      (diagonalMassMatrix μ).mulVec (a t) = F (q t)) →
    IsMechanicalSolutionOn μ F Q I
      (fun t => (q t, massOperator μ (v t)))
```

该类型直接给双侧 `HasDerivAt`，所以不需要 `IsOpen I`；增加该前提会是不必要收窄。两条导数证据把 `v`、`a` 绑定为真实速度与加速度，矩阵等式给动力学输入。仅给点态 `NBodyEquationAt` 或全定义的 `deriv` 值不能替代这些证据。

`Position`、`Velocity` 在当前项目中是定义相等的透明别名，因此 `(q v a : ℝ → Position n)` 类型正确。为提升文档语义，后续声明可分别把 `v` 标为 `Velocity n`，并明确 `a` 是配置切空间中的加速度；这不要求新增数学对象，也不是阻断修改。

### T2-E1 — 接受，但严格限定范围

```lean
freeParticleGoal {n} (μ : CoordinateMasses n)
    (q₀ : Position n) (v₀ : Velocity n) (t₀ ε : ℝ) : Prop :=
  (∀ i, 0 < μ i) → 0 < ε →
    IsLocalMechanicalIVP μ (fun _ => 0) Set.univ t₀
      (q₀, massOperator μ v₀) ε
      (fun t => (q₀ + (t - t₀) • v₀, massOperator μ v₀))
```

该目标精确表示 `F=0` 的一阶局部 IVP。`0<ε` 使 `t₀` 位于开区间内部；`Q=univ` 使域成员自动成立；`hμ` 用于速度与动量的 inverse。类型中没有 `U`，因此不得把 `U=0`、`-gradient U=0`、二阶 Newton 方程或能量守恒报告成 E1 的已包含结论。

## 7. 依赖蓝图

这不是证明脚本，而是声明之间必须保持的有根依赖关系：

```text
T1: diagonalMassMatrix inverse / mulVec 接口
  + Matrix.toEuclideanLin → LinearMap.toContinuousLinearMap
  └── L0: massOperator/velocityOperator 坐标桥接与两侧 inverse

IsIntegralCurveOn + 开集内 within→at + 连续线性 fst/snd
  └── S1: 解谓词的分量等价
      ├── S1 + L0 ──> B1: p = B (deriv q)
      └── S1 + 邻域 eventually equality + velocityOperator 线性导数
          └── B2: deriv q 的真实导数
              └── B2 + L0 + hμ + hFU
                  └── B3a: NBodyEquationAt 代数核心
                      └── 势能点态可微性
                          └── B3b: 教材梯度语义应用

L0 + 两条 HasDerivAt + M a = F(q)
  └── B4: 二阶轨迹数据到一阶机械解

五个定义 + L0 + F=0 + ε>0
  └── E1: 自由粒子局部 IVP
```

B1 与 B2 在 S1 后可独立推进；B3 必须等待 B2、L0 与 B3 分层陈述定稿。B4 不依赖 B2/B3，E1 不依赖势能层。局部存在唯一性不在这七个 ID 的根依赖图中。

## 8. 固定 API 组与缺口

以下声明来自附件中哈希通过、退出码 0 的固定版本输出；本轮没有重新查询 API。

| 组 | 已固定声明 | 对七个 ID 的作用 | 尚存缺口 |
| --- | --- | --- | --- |
| K1 | `IsIntegralCurveOn`; `HasDerivWithinAt.hasDerivAt`; `IsIntegralCurveOn.isIntegralCurveAt` | 解谓词及开集内双侧导数转换 | 闭区间端点版本不在本批；不得自动转 ambient `deriv` |
| K2 | `ContinuousLinearMap.fst/snd`; `HasFDerivAt.comp_hasDerivAt`; `HasDerivAt.prodMk` | S1 分量投影与合成，B4 构造相空间导数陈述 | 无陈述级阻断；正式集成仍需保留实际连续标量作用实例 |
| K3 | `Matrix.toEuclideanLin`; `LinearMap.toContinuousLinearMap`; `ContinuousLinearMap.hasFDerivAt` | L0 的欧氏矩阵包装及 B2/B4 的固定线性映射导数 | L0 两个坐标桥接尚未进入目标声明包 |
| K4 | `HasDerivAt.deriv`; `HasDerivAt.congr_of_eventuallyEq` | B1 读取导数值；B2 通过邻域等式取得真实二阶导数 | 必须建立 eventually equality，不能用单点等式替代 |
| K5 | `ContDiffAt.exists_*`; `IsPicardLindelof.exists_*`; `ODE_solution_unique_of_mem_Ioo` | 只为未来局部存在唯一性定位 | 机械场 C¹/局部 Lipschitz、Q 内停留、公共常数和时间缩短均未落实；不属于当前七个目标已完成依赖 |

历史探针状态必须区分：`Probe01_APIs` 超时并含类型类搜索失败；`Probe02a_Instances` 退出 1；后继 `Probe01b_API_Types`、`Probe02b_Adapters`、`Probe03_TargetTypes` 退出 0。成功后继只证明声明存在、适配示例与候选类型成立，不证明七个目标。

## 9. 建议的后续顺序与待签核项

本轮停止在陈述审阅。若以后另获授权，建议按依赖而非证明难度安排：

1. 负责人先确认 L0 是否把两个坐标桥接作为命名辅助声明纳入验收。
2. 负责人选择 B3 的两层命名和可微性表达：点态 `DifferentiableAt`，或开放 Q 上的 `DifferentiableOn`。
3. 冻结五个定义及 S1/B1/B2/B4/E1 的当前量词顺序。
4. 后续证明阶段才按 L0 → S1 → B1/B2 → B3 推进；B4、E1 可在 L0 后作为独立分支。
5. 局部存在唯一性、全局延拓、Flow、守恒、Hamiltonian 一致性与 Theorem 1.1 继续留在后续任务。

负责人待签核：L0 声明包、B3 分层、B4 的速度/加速度类型标注风格、E1 的严格范围、以及开放 Q/势能正则性留到哪一批实现。

## 10. 实际工作流与禁止事项记录

- 实际使用：Lean Blueprint，用于冻结语义契约、逐 ID 审阅和依赖 DAG。
- 未使用：Lean Proof、Math Brainstorm。
- 未运行：新的 Lean 类型检查、`lake build`、`Scratch.lean`、`scripts/check.ps1`、CI 或公理审计。
- 未进行：语义索引查询、重建、配置或修复。既有“索引指向无关测试库”的不匹配状态仍单列为未通过，不能以 ready 代替命中验证。
- 未创建：`T2_DRAFT.lean`、正式 Lean 模块、`sorry`、`admit` 或项目公理。
- 未修改：正式库、共享 Scratch、固定版本文件、knowledge、handoff 或既有文档。
- 未执行：Git checkout、pull、merge、reset、rebase、add、commit 或 push，也未向其他聊天发送消息。

