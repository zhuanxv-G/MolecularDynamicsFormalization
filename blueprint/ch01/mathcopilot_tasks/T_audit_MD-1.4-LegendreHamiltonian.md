# T_audit_MD-1.4-LegendreHamiltonian

单目标：MD-1.4-LegendreHamiltonian。模板C，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.24 / PDF p.47；上下文页：PDF 45–47（印刷22–24）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。
- `Blueprint/Ch01.lean`，目标声明 `MD.Ch01.hamiltonian_legendre_transform`（下面内嵌片段）。
- 以下相关定义文件（可以合并上传，必须点开检查，不能仅凭定义名推断）：
  - `MolecularDynamics/Notation.lean`
  - `MolecularDynamics/Chapter01/LegendreTransform.lean`
  - `MolecularDynamics/Chapter01/Lagrangian.lean`
- `blueprint/ch01/dependency_inventory.json`：正式库传递导入文件和哈希；若不能读取依赖，明确标未验证。

正式库基线commit：`1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。

```json
{
  "source_entry_sha256": "90466e97aa683c26b7f6b28282787edd8e31694292a61eae92dec3b5e0a55a00",
  "signature_sha256": "2b468a3414ce493fbfab95cfca2a8569d174f3299324481d7e9a79a3444c27b5",
  "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
  "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
}
```

本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；只读审计C必须使用approved JSON和当前哈希，不审旧稿。

## 任务正文

只读审计，不修改任何文件。审计条目：MD-1.4-LegendreHamiltonian 与对应 Lean 声明 MD.Ch01.hamiltonian_legendre_transform。
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

用户保存到`blueprint/ch01/mathcopilot_results/T_audit_MD-1.4-LegendreHamiltonian.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_audit_MD-1.4-LegendreHamiltonian",
  "input_fingerprint": {
    "source_entry_sha256": "90466e97aa683c26b7f6b28282787edd8e31694292a61eae92dec3b5e0a55a00",
    "signature_sha256": "2b468a3414ce493fbfab95cfca2a8569d174f3299324481d7e9a79a3444c27b5",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

## 本条JSON输入

```json
{
  "source_id": "MD-1.4-LegendreHamiltonian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "If $\\boldsymbol{M}(\\boldsymbol{q})$ is invertible, the supremum is achieved precisely when\n\\[\\boldsymbol{v}=\\boldsymbol{M}^{-1}(\\boldsymbol{q})\\boldsymbol{p},\\]\nwhich gives the standard definition of the momentum vector $\\boldsymbol{p}$ in terms of velocities,\n\\[\\boldsymbol{p}=\\frac{\\partial L}{\\partial\\dot{\\boldsymbol{q}}}=\\boldsymbol{M}(\\boldsymbol{q})\\dot{\\boldsymbol{q}},\\]\nand, with $\\boldsymbol{v}=\\boldsymbol{M}^{-1}(\\boldsymbol{q})\\boldsymbol{p}$, the Legendre transformation results in a new function\n\\[H(\\boldsymbol{q},\\boldsymbol{p})\\stackrel{\\mathrm{def}}{=}\\boldsymbol{p}^TM(\\boldsymbol{q})^{-1}\\boldsymbol{p}/2+U(\\boldsymbol{q}).\\]\nThis is precisely the energy function, written in terms of positions and momenta.",
  "proof_latex": "In the case of the Lagrangian $L(\\boldsymbol{q},\\boldsymbol{v})=\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2-U(\\boldsymbol{q})$ (which we have seen is the formulation of a mechanical system in generalized coordinates) we find\n\\[\\sup_{\\boldsymbol{v}}(\\boldsymbol{p}^T\\boldsymbol{v}-(\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2-U(\\boldsymbol{q})))=\\sup_{\\boldsymbol{v}}(\\boldsymbol{p}^T\\boldsymbol{v}-\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2)+U(\\boldsymbol{q}).\\]",
  "proof_note": "仅有上述代数推导；原文没有证明“可逆即达到上确界”或唯一性。",
  "context_notation": [
    "同页Legendre定义：凸函数$g(\\boldsymbol{\\xi}):\\mathbb{R}^m\\to\\mathbb{R}$，$\\widetilde g(\\boldsymbol{\\eta})=\\sup_{\\boldsymbol{\\xi}}(\\boldsymbol{\\eta}^T\\boldsymbol{\\xi}-g(\\boldsymbol{\\xi}))$；印刷p.24/PDF47。",
    "配置相关质量矩阵来自$\\Phi^{\\prime}(\\boldsymbol{Q})^TM\\Phi^{\\prime}(\\boldsymbol{Q})$，变化规则及满秩前提：§1.3印刷p.23/PDF46。因此对称/正定可能是继承的背景，不是“可逆”本身的推论，需独立审计裁决。",
    "$\\boldsymbol{q},\\boldsymbol{v},\\boldsymbol{p}\\in\\mathbb{R}^{N_c}$，$H$为位置和动量中的能量，§1.4印刷p.24/PDF47。"
  ],
  "issues": [
    {
      "code": "POSSIBLE_ERRATUM",
      "status": "NEEDS_HUMAN",
      "detail": "若只假设可逆，M=-1、p=0、U=0时目标=v²/2无上界；须确认同页凸性及p.23机械质量背景是否应并入假设。当前保留字面可逆陈述并标ERRATUM?，未静默加正定。"
    },
    {
      "code": "REUSE_SCOPE_GAP",
      "status": "open",
      "detail": "现有定理仅固定正对角m；本条保留任意配置相关M(q)、上界、sup、精确达到条件、动量偏导和能量对应，不能直接调用旧定理覆盖。"
    }
  ],
  "lean_decl": "MD.Ch01.hamiltonian_legendre_transform",
  "reusable_proofs": [
    "MolecularDynamics.massHamiltonian_eq_legendre_sup",
    "MolecularDynamics.legendre_objective_eq_massHamiltonian_iff"
  ],
  "extra_assumptions": [],
  "statement_scope": "从“If M(q) is invertible”到“written in terms of positions and momenta.”；前一计算为proof_latex，前置抽象定义为context_notation；Hamilton方程属于下一条。",
  "review_status": "NEEDS_HUMAN",
  "repair_log": [
    {
      "stage": "LOCAL_DRAFT",
      "reason": "对照原页及PDF字体记录统一数学斜体E和粗体质量矩阵M；没有改写原文措辞。",
      "before_sha256": "134f84e19b17bad810cdb8cdd0308bbcefb36fe2b17b2402605eae163c911a15",
      "after_sha256": "90466e97aa683c26b7f6b28282787edd8e31694292a61eae92dec3b5e0a55a00"
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


/-- source_id: MD-1.4-LegendreHamiltonian · unnumbered claim · printed p.24 / PDF p.47
Original: The Legendre supremum is attained precisely at M(q)⁻¹p and yields H(q,p).
[ERRATUM?] The literal invertibility premise alone does not imply a bounded objective:
M = -1, U = 0, p = 0 gives v²/2. Convexity/positive definiteness may be inherited
from the abstract convex Legendre definition and the mechanical mass model on p.23;
independent audit must settle the intended premise. It has not been silently added.
The full configuration-dependent matrix M(q) is retained. The fixed positive
diagonal library theorem cannot establish this signature. This draft is unproved.
The conjuncts keep boundedness, supremum, exact maximizing velocity, momentum
gradient, and the energy identity after the inverse-velocity substitution. -/
theorem hamiltonian_legendre_transform {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry
end MD.Ch01
```
