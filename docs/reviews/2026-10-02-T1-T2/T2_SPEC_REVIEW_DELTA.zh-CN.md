# T2 陈述审阅后的修订草案

状态：**九份 MathCopilot 原报告已本地收取并核对，候选陈述待负责人语义签核**。本文件补充冻结的 `docs/tasks/T2_SPEC.zh-CN.md`，不修改原送审输入，不是正式 Lean 定理，也不是 T2 证明。

## 来源和适用范围

- MathCopilot 原件已保存于 `docs/tasks/T1_mathcopilot_return_git/`（七份）和 `docs/tasks/T2_mathcopilot_statement_return/`（两份）；收件方法、字节哈希和检查边界见 `MATHCOPILOT_RETURN_INTAKE.zh-CN.md`。T1 固定对象的只读审阅接受 11 个 ID/13 条既有定理，未发现影响 T2 坐标、正质量或 inverse 依赖的阻断项。T2 完整报告和逐 ID 台账均已读取：S1/B1/B2/B4/E1 接受，L0/B3 要求以下修订；报告自述的 20/20 输入区块原文件长度与 SHA256 匹配是网站审阅结果，本地没有重演该远端附件检验。
- 教材印刷 18–19/PDF 41–42 给固定对角质量的 `Mq̈=F(q)=-∇U(q)` 与粒子坐标质量重复；印刷 24/PDF 47 给 `p=M(q)q̇`、固定质量时的 `q̇=M⁻¹p, ṗ=F(q)`。本项目此批只处理固定 `M`。精确开时间域和势能可微性是形式化时显式补充的条件。
- 以下候选采用原规格的五个定义、`Position`/`Velocity`/`Momentum`/`PhaseSpace` 类型和 `NBodyEquationAt`。完整类型在隔离探针 `../tmp/t2-resume-20261002/Probe04_ReviewDelta.lean` 中，以固定 Lean v4.34.0/mathlib 运行 `lake env lean` 退出 0，且无诊断。该检查只保证类型可表达。

## T2-L0：把两种坐标作用写进声明包

保留原 `massInverseGoal`：在 `∀ i, 0 < μ i` 下同时得到 `massOperator μ (velocityOperator μ p)=p` 与 `velocityOperator μ (massOperator μ v)=v`。另增两个**不要求正质量**的目标：

```lean
def massOperatorCoordinatesGoal {n : ℕ} (μ : CoordinateMasses n) : Prop :=
  ∀ (v : Velocity n) (i : Fin n),
    massOperator μ v i = (diagonalMassMatrix μ).mulVec v i

def velocityOperatorCoordinatesGoal {n : ℕ} (μ : CoordinateMasses n) : Prop :=
  ∀ (p : Momentum n) (i : Fin n),
    velocityOperator μ p i = ((diagonalMassMatrix μ)⁻¹).mulVec p i
```

这使欧氏连续线性包装与原 T1 矩阵定理的连接成为可见依赖；坐标等式适用于任意质量。即使矩阵奇异，第二条仍说明**所定义的逆矩阵作用**的坐标，不能据此推断它是速度恢复算子。恢复速度的两侧逆仍依赖原 L0 的正质量前提。既有 `Probe02b_Adapters.lean` 曾以小型 `rfl` 例子检查坐标写法；本次仅重查目标类型，未证明一般量化命题。

## T2-B3：代数桥接与教材梯度解释分层

代数核心保留原 `nBodyBridgeGoal` 的前提和结论，仅将角色命名清楚：

```lean
def nBodyBridgeAlgebraicGoal {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ i, 0 < μ i) → IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    (∀ q ∈ Q, F q = -gradient U q) →
    ∀ t ∈ I, NBodyEquationAt μ F U (γ t).1
      (deriv (deriv (fun s => (γ s).1)) t)
```

`hFU` 是输入的模型关系，不从任意 `F` 推出；它足以把 `Mq̈=F` 代入现有点态谓词。纯代数核心本身不声称 `U` 可微。要把式中的 `gradient U` 解释为教材意义的势能真梯度，另列应用层前提，**不改动**原核心：

```lean
def nBodyBridgeDifferentiableAtGoal {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (U : PotentialEnergy n) (Q : Set (Position n))
    (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ i, 0 < μ i) → IsOpen I → IsMechanicalSolutionOn μ F Q I γ →
    (∀ q ∈ Q, DifferentiableAt ℝ U q) →
    (∀ q ∈ Q, F q = -gradient U q) →
    ∀ t ∈ I, NBodyEquationAt μ F U (γ t).1
      (deriv (deriv (fun s => (γ s).1)) t)
```

未来局部 ODE 阶段可选 `IsOpen Q` 与 `DifferentiableOn ℝ U Q` 作为应用层表达；其完整目标类型也在同一探针中通过。上述可微性只是语义条件，不能当成 `F` 局部 Lipschitz、局部存在唯一性或全局流的证明。B3 仍必须由 B2 的**邻域等式**得到真实二阶导数，再由 L0 正质量逆关系得到 `Mq̈=F`；不得把该结论预置在正向假设中。

## 其他 ID 保留的边界

| ID | 当前陈述处理 |
| --- | --- |
| S1、B1 | 原目标类型不变；S1 不添加质量正性或 `F` 连续性。 |
| B2 | 原目标类型不变；无正质量前提，需利用开集邻域内 `deriv q=V∘p`，单点等式不足以求导。 |
| B4 | 原目标类型不变；输入已是各点双侧 `HasDerivAt`，不额外加入 `IsOpen I`。 |
| E1 | 原目标类型不变；只说 `F=0` 的第一阶局部 IVP。定义中未携带 `U`，不能写成 `U=0`、二阶方程或能量守恒的 Lean 证明。 |

九份原报告及 T2 两份报告自报 SHA256 已核对；本候选与 T2 完整报告的逐 ID 限制一致。修订进入正式规格前仍须负责人签核教材语义、L0 声明包和 B3 分层选择。T2 七个目标的完整 Lean 证明、正式构建和 CI 均未进行。
