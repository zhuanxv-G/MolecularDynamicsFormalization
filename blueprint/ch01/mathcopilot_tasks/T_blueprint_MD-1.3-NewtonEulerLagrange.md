# T_blueprint_MD-1.3-NewtonEulerLagrange

单目标：MD-1.3-NewtonEulerLagrange。模板B，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.23 / PDF p.46；上下文页：PDF 41、45–46（印刷18、22–23）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。
- `Blueprint/Ch01.lean`，目标声明 `MD.Ch01.newton_iff_euler_lagrange`（下面内嵌片段）。

正式库基线commit：`1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。

```json
{
  "source_entry_sha256": "1a2246dbfd6de1a5d68c368c83933fd807672cc490097359d2afea3f40aaf4e8",
  "signature_sha256": "27fd7e1251d62b07011dfeab02b981ad825d1b4c505a630e04a75d5f5eabaf9f",
  "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
  "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
}
```

本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；只读审计C必须使用approved JSON和当前哈希，不审旧稿。

## 任务正文

$lean-blueprint
只处理 ch01_source.json 中的条目：MD-1.3-NewtonEulerLagrange，写入 Blueprint/Ch01.lean，不做证明（证明一律 by sorry）。
要求：
- 保持对象、量词顺序、全部假设、边界和全部结论子句；
- 每条声明上方注释 source_id 与印刷页/PDF页；
- 优先复用 Mathlib 与项目已有定义（MolecularDynamics 命名空间）；
- 原文未写但形式化必需的技术假设标 [EXTRA] 并说明理由；
- 禁止 True、P → P、把结论写进假设、新增 axiom；
- 疑似勘误不要静默改写，标 [ERRATUM?] 并报告；
最后报告：遗漏条目、fresh Check 结果、风险点。

独立给出完整签名；将候选放在输出里，不覆盖现有源码。不要拿本地版本作为忠实性的依据。

## 返回件约定

用户保存到`blueprint/ch01/mathcopilot_results/T_blueprint_MD-1.3-NewtonEulerLagrange.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_blueprint_MD-1.3-NewtonEulerLagrange",
  "input_fingerprint": {
    "source_entry_sha256": "1a2246dbfd6de1a5d68c368c83933fd807672cc490097359d2afea3f40aaf4e8",
    "signature_sha256": "27fd7e1251d62b07011dfeab02b981ad825d1b4c505a630e04a75d5f5eabaf9f",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

模板B返回JSON需包含`source_id`、`lean_decl`、`lean_statement`（完整Lean陈述字符串）、`extra_assumptions`、`risks`、`fresh_check`（命令/版本/实际结果或not_run）。

## 本条JSON输入

```json
{
  "source_id": "MD-1.3-NewtonEulerLagrange",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.3",
  "printed_page": "23",
  "pdf_page": "46",
  "statement_latex": "The equations of motion may be expressed in terms of the Lagrangian as:\n\\[\\frac{\\mathrm{d}}{\\mathrm{d}t}\\frac{\\partial L}{\\partial\\dot{\\boldsymbol{q}}}=\\frac{\\partial L}{\\partial\\boldsymbol{q}}.\\]\n(Note that this must be interpreted in general as a set of $N_c=3N$ equations, one for each atomic coordinate.)",
  "proof_latex": null,
  "proof_note": "原文给出运动方程的等价表达，没有独立证明；下一段开始讨论坐标变换，不纳入本条。",
  "context_notation": [
    "$L\\stackrel{\\mathrm{def}}{=}\\dot{\\boldsymbol{q}}^TM\\dot{\\boldsymbol{q}}/2-U(\\boldsymbol{q})$，固定对角质量系统(1.3)的Lagrangian：§1.3印刷p.22/PDF45。",
    "式(1.3)与坐标数$N_c$：§1.2印刷p.18/PDF41；$\\boldsymbol{p}=\\boldsymbol{M}\\dot{\\boldsymbol{q}}$为用于复用证明的辅助相空间记号：§1.4印刷p.24/PDF47。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch01.newton_iff_euler_lagrange",
  "reusable_proofs": [
    "MolecularDynamics.mechanicalSolution_eulerLagrange",
    "MolecularDynamics.eulerLagrange_to_mechanicalSolution",
    "MolecularDynamics.newtonTrajectory_to_mechanicalSolution",
    "MolecularDynamics.hasDerivAt_deriv_position",
    "MolecularDynamics.solution_nBodyEquationAt"
  ],
  "extra_assumptions": [
    "hm: 每个固定对角质量正；用于从相空间方程回到牛顿方程。",
    "hI: 时间域开放；把within导数还原为原文双侧时间导数。",
    "hU: U在Q可微；保证位置偏导是实际导数。"
  ],
  "statement_scope": "p.23首句、展示方程及完整括号说明；以真正牛顿二阶轨迹谓词给出双向等价，不仅保留旧单向定理。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "LOCAL_DRAFT",
      "reason": "对照原页及PDF字体记录统一数学斜体E和粗体质量矩阵M；没有改写原文措辞。",
      "before_sha256": "f1b2f920de30a049706acea0983e0b77c579ba964de2bef6732506baf3824aea",
      "after_sha256": "1a2246dbfd6de1a5d68c368c83933fd807672cc490097359d2afea3f40aaf4e8"
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


/-- source_id: MD-1.3-NewtonEulerLagrange · unnumbered claim · printed p.23 / PDF p.46
Original: The Newton equations can be expressed as the Euler-Lagrange equations.
[EXTRA] hm: positive fixed diagonal masses used by the phase-space equivalence.
[EXTRA] hI: an open time domain turns within derivatives into two-sided derivatives.
[EXTRA] hU: differentiability makes ∂L/∂q a genuine gradient.
Both directions are present; the predicate enforces every coordinate equation.
The Lagrangian here is the fixed-mass L on p.22, before generalized coordinates. -/
theorem newton_iff_euler_lagrange {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (hm : ∀ i, 0 < m i) (hI : IsOpen I)
    (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x) :
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q := by
  constructor
  · intro hq
    have hγ : IsMechanicalSolutionOn m (fun x => -gradient U x) Q I
        (fun t => (q t, massOperator m (deriv q t))) := by
      apply newtonTrajectory_to_mechanicalSolution m (fun x => -gradient U x) Q I
        q (deriv q) (deriv (deriv q)) hm hq.1
      intro t ht
      refine ⟨(hq.2 t ht).1, (hq.2 t ht).2.1, ?_⟩
      ext i
      exact congrArg (fun v : Position n => v i) ((hq.2 t ht).2.2)
    exact mechanicalSolution_eulerLagrange m U Q I _ hm hI hγ hU
  · intro hq
    have hγ := eulerLagrange_to_mechanicalSolution m U Q I q hm hq hU
    refine ⟨hq.1, ?_⟩
    intro t ht
    refine ⟨(hq.2 t ht).1, ?_, ?_⟩
    · have hacc := hasDerivAt_deriv_position m (fun x => -gradient U x) Q I
        (fun t => (q t, massOperator m (deriv q t))) hI hγ t ht
      simpa only [hacc.deriv] using hacc
    · have hnewton := solution_nBodyEquationAt m (fun x => -gradient U x) U Q I
        (fun t => (q t, massOperator m (deriv q t))) hm hI hγ (fun _ _ => rfl) t ht
      ext i
      exact congrFun hnewton.1 i
end MD.Ch01
```
