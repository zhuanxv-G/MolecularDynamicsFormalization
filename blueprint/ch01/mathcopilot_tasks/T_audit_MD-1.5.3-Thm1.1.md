# T_audit_MD-1.5.3-Thm1.1

单目标：MD-1.5.3-Thm1.1。模板C，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.32 / PDF p.55；上下文页：PDF 41、48、54–55（印刷18、25、31–32）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。
- `Blueprint/Ch01.lean`，目标声明 `MD.Ch01.theorem_1_1`（下面内嵌片段）。
- 以下相关定义文件（可以合并上传，必须点开检查，不能仅凭定义名推断）：
  - `MolecularDynamics/Notation.lean`
  - `MolecularDynamics/Chapter01/PotentialBarriers.lean`
  - `MolecularDynamics/Chapter01/Equilibrium.lean`
  - `MolecularDynamics/Chapter01/EuclideanStability.lean`
  - `MolecularDynamics/Chapter01/PhaseMetric.lean`
  - `MolecularDynamics/Chapter01/LocalTrajectories.lean`
- `blueprint/ch01/dependency_inventory.json`：正式库传递导入文件和哈希；若不能读取依赖，明确标未验证。

正式库基线commit：`1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。

```json
{
  "source_entry_sha256": "15c882d153436a4622fba98867b6fada60a25b60c46ed413654ae763c1a28a12",
  "signature_sha256": "05ed1f54ee881d97a6b9acb5ecb6908b9eb7b5aed6f08b62e4b073d8db1e2e44",
  "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
  "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
}
```

本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；只读审计C必须使用approved JSON和当前哈希，不审旧稿。

## 任务正文

只读审计，不修改任何文件。审计条目：MD-1.5.3-Thm1.1 与对应 Lean 声明 MD.Ch01.theorem_1_1。
证据优先级：PDF 原文 > approved JSON > 当前 Lean 声明。
逐条检查：
1. 对象与范围（维数、定义域、时间区间、局部/全局）；
2. 量词顺序与依赖（谁依赖谁）；
3. 假设与隐含前提：每个 Lean 假设是否原文有；[EXTRA] 是否合理必要；
4. 每个结论子句是否都在，唯一性等是否遗漏；
5. 层次是否混淆（逐点/几乎处处、存在/唯一等）；
6. 是否被平凡化、加强或减弱；所用项目定义（点开定义）是否与书中概念一致；
7. 尽量给出最小反例（例如 U(x)=x⁴、谐振子）说明问题。
每条输出：
{ "source_id": ..., "lean_decl": ...,
  "verdict": "PASS|TOO_WEAK|TOO_STRONG|MISSING_CLAUSE|EXTRA_ASSUMPTION|WRONG_OBJECT|WRONG_QUANTIFIER|WRONG_LEVEL|POSSIBLE_ERRATUM",
  "explanation": "...", "counterexample": "...或null", "suggested_fix": "...或null" }

注意：审计包含本条全部结论子句和[EXTRA]/[ERRATUM?]。缺上下文或无法检查Lean时明确记未验证；不得假报fresh Check。

## 返回件约定

用户保存到`blueprint/ch01/mathcopilot_results/T_audit_MD-1.5.3-Thm1.1.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_audit_MD-1.5.3-Thm1.1",
  "input_fingerprint": {
    "source_entry_sha256": "15c882d153436a4622fba98867b6fada60a25b60c46ed413654ae763c1a28a12",
    "signature_sha256": "05ed1f54ee881d97a6b9acb5ecb6908b9eb7b5aed6f08b62e4b073d8db1e2e44",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

## 本条JSON输入

```json
{
  "source_id": "MD-1.5.3-Thm1.1",
  "kind": "theorem",
  "label": "Theorem 1.1",
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "If $\\boldsymbol{q}^*$ is a strong local minimum of smooth potential $U$ then $\\boldsymbol{z}^*=(\\boldsymbol{q}^*,0)$ is stable.",
  "proof_latex": null,
  "proof_note": "原文只有以下证明思路并指向[216]，无完整证明；不把思路冒充原文证明。",
  "proof_discussion_latex": "The proof of this theorem relies on showing that if trajectories are started from a point sufficiently close to $\\boldsymbol{z}^*$ they cannot wander away to infinity. Although the result holds in greater generality, it is easy to show under assumptions of local smoothness of $U$ (which we are normally happy to make in molecular dynamics). For more discussion see the text [216].",
  "context_notation": [
    "$\\boldsymbol{z}=(\\boldsymbol{q},\\boldsymbol{p})$，相空间位置与动量：§1.4印刷p.25/PDF48；$H(\\boldsymbol{q},\\boldsymbol{p})=\\boldsymbol{p}^TM^{-1}\\boldsymbol{p}/2+U(\\boldsymbol{q})$：§1.5.3印刷p.32/PDF55。",
    "平衡点$f(\\boldsymbol{z}^*)=0$：§1.5.3印刷p.31/PDF54；同节假设平衡点附近$f$连续可微。",
    "强局部极小：存在$\\epsilon>0$，$0<\\|\\boldsymbol{q}-\\boldsymbol{q}^*\\|<\\epsilon\\Rightarrow U(\\boldsymbol{q})>U(\\boldsymbol{q}^*)$，印刷p.32/PDF55。",
    "稳定：for all $\\epsilon$, there exists $\\delta$ such that, for all $\\boldsymbol{z}_0$ with $\\|\\boldsymbol{z}_0-\\boldsymbol{z}^*\\|<\\delta$, $\\sup_{t\\geq0}\\|\\mathcal{F}_t(\\boldsymbol{z}_0)-\\boldsymbol{z}^*\\|<\\epsilon$，印刷p.32/PDF55；按正容差解释，正文量词省略$\\epsilon,\\delta>0$。",
    "$\\boldsymbol{M}$固定正定质量矩阵：§1.2印刷p.18/PDF41的对角质量及§1.5印刷p.25/PDF48的正定前提。"
  ],
  "issues": [
    {
      "code": "PAGE_SPAN_CORRECTION",
      "status": "local_verified",
      "detail": "用户范围31–32/54–55是背景跨度；定理与证明思路均仅32/55。"
    }
  ],
  "lean_decl": "MD.Ch01.theorem_1_1",
  "reusable_proofs": [
    "MolecularDynamics.strictPotentialMin_futureStableEuclidean_of_smooth"
  ],
  "extra_assumptions": [
    "hm: 每个固定对角质量正；来自§1.5正定背景，定理句未重复。",
    "hQ: 势能位置域Q开放；局部ODE和极小值邻域须位于定义域。",
    "hstrict包含q₀∈Q；补出原文默认的定义域资格。"
  ],
  "statement_scope": "只摘录定理句；稳定/强极小定义作为context_notation，Hartman–Grobman陈述不在试点。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "LOCAL_DRAFT",
      "reason": "对照原页及PDF字体记录统一数学斜体E和粗体质量矩阵M；没有改写原文措辞。",
      "before_sha256": "ed167f52115e5ea9d0bd16168460ee67544284d8bb650c47f93b7aacde4503e0",
      "after_sha256": "15c882d153436a4622fba98867b6fada60a25b60c46ed413654ae763c1a28a12"
    }
  ]
}
```

## 当前Blueprint片段

```lean
import MolecularDynamics.Chapter01.EuclideanStability
import MolecularDynamics.Chapter01.EnergyConservation
import MolecularDynamics.Chapter01.Lagrangian
import MolecularDynamics.Chapter01.LegendreTransform
import MolecularDynamics.Chapter01.GlobalFlow

/-!
Chapter 1 pilot: draft signatures for independent semantic review.
Existing formal-library sources and signatures are preserved.
The dimension n denotes N_c (3N for three-dimensional atomic coordinates).
The formal fixed diagonal model also supports the line case N_c = N.
No signature is frozen until the matching MathCopilot audit passes.
-/

open Set MolecularDynamics
open scoped ContDiff InnerProductSpace

namespace MD.Ch01

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

/-- Actual twice differentiable position curves satisfying M q̈ = -∇U.
The derivatives are genuine HasDerivAt witnesses, not total-derivative equations alone. -/
def IsNewtonTrajectoryOn {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
    massOperator m (deriv (deriv q) t) = -gradient U (q t)

/-- Matrix action for the configuration-dependent mass model on printed p.24. -/
noncomputable def matrixAction {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (v : Position n) : Position n := Matrix.toEuclideanLin A v

noncomputable def variableMassLagrangian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := inner ℝ v (matrixAction (M q) v) / 2 - U q

noncomputable def variableMassHamiltonian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : ℝ := inner ℝ p (matrixAction (M q)⁻¹ p) / 2 + U q


/-- source_id: MD-1.5.3-Thm1.1 · Theorem 1.1 · printed p.32 / PDF p.55
Original: A strong local minimum of a smooth potential yields a stable equilibrium.
[EXTRA] hm: positive fixed diagonal masses, inherited from p.25 positive definiteness.
[EXTRA] hQ: open position domain for local ODEs and the minimum neighborhood.
[EXTRA] hstrict includes q₀ ∈ Q, the implicit domain qualification.
hU is the original smoothness hypothesis, not an extra C1-force assumption.
The Euclidean predicate retains positive ε/δ, all nearby initial states, future
existence, and a bounded real supremum strictly below ε for every future solution.
The theorem sentence and proof discussion are on p.32 only; p.31 is background. -/
theorem theorem_1_1 {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ ∞ U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStableEuclidean m (fun q => -gradient U q) Q
      (q₀, (0 : Momentum n)) := by
  exact strictPotentialMin_futureStableEuclidean_of_smooth m U Q q₀ hm hQ hU hstrict
end MD.Ch01
```
