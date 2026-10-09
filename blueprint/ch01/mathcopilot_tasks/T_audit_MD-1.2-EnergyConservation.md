# T_audit_MD-1.2-EnergyConservation

单目标：MD-1.2-EnergyConservation。模板C，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.19 / PDF p.42；上下文页：PDF 41–42（印刷18–19）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。
- `Blueprint/Ch01.lean`，目标声明 `MD.Ch01.energy_conservation`（下面内嵌片段）。
- 以下相关定义文件（可以合并上传，必须点开检查，不能仅凭定义名推断）：
  - `MolecularDynamics/Notation.lean`
  - `MolecularDynamics/Chapter01/NBody.lean`
  - `MolecularDynamics/Chapter01/ParticleCoordinates.lean`
  - `MolecularDynamics/Chapter01/LocalTrajectories.lean`
  - `MolecularDynamics/Chapter01/EnergyConservation.lean`
  - `MolecularDynamics/Chapter01/Hamiltonian.lean`
- `blueprint/ch01/dependency_inventory.json`：正式库传递导入文件和哈希；若不能读取依赖，明确标未验证。

正式库基线commit：`1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。

```json
{
  "source_entry_sha256": "602eec4ec54600d2453b232c7f51b0ab138de3d3f56be31e060fb6e6d0aed2c5",
  "signature_sha256": "f127edcebe32563ae5ff4f88df5cda69ff6ede9ecfe10bed2ee5a4dd7dc9051e",
  "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
  "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
}
```

本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；只读审计C必须使用approved JSON和当前哈希，不审旧稿。

## 任务正文

只读审计，不修改任何文件。审计条目：MD-1.2-EnergyConservation 与对应 Lean 声明 MD.Ch01.energy_conservation。
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

用户保存到`blueprint/ch01/mathcopilot_results/T_audit_MD-1.2-EnergyConservation.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_audit_MD-1.2-EnergyConservation",
  "input_fingerprint": {
    "source_entry_sha256": "602eec4ec54600d2453b232c7f51b0ab138de3d3f56be31e060fb6e6d0aed2c5",
    "signature_sha256": "f127edcebe32563ae5ff4f88df5cda69ff6ede9ecfe10bed2ee5a4dd7dc9051e",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

## 本条JSON输入

```json
{
  "source_id": "MD-1.2-EnergyConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19",
  "pdf_page": "42",
  "statement_latex": "Along the solutions of (1.3), the energy is conserved, since its derivative vanishes:",
  "proof_latex": "\\[\\frac{\\mathrm{d}}{\\mathrm{d}t}E=\\sum_{j=1}^{N}m_j\\dot{\\boldsymbol{q}}_j\\cdot\\ddot{\\boldsymbol{q}}_j+\\sum_{j=1}^{N}\\frac{\\partial U}{\\partial\\boldsymbol{q}_j}\\cdot\\dot{\\boldsymbol{q}}_j=\\sum_{j=1}^{N}\\left(m_j\\ddot{\\boldsymbol{q}}_j+\\frac{\\partial U}{\\partial\\boldsymbol{q}_j}\\right)\\cdot\\dot{\\boldsymbol{q}}_j=0.\\]",
  "proof_note": "原文紧接陈述给出完整导数计算；PDF字体记录确认能量函数为数学斜体E。",
  "context_notation": [
    "式(1.3)：$\\boldsymbol{M}\\frac{\\mathrm{d}^2}{\\mathrm{d}t^2}\\boldsymbol{q}=\\boldsymbol{F}(\\boldsymbol{q})=-\\nabla U(\\boldsymbol{q})$；$\\boldsymbol{M}=\\operatorname{diag}(m_1,m_1,m_1,\\ldots,m_N,m_N,m_N)$，§1.2印刷p.18/PDF41。",
    "式(1.4)：$E(\\boldsymbol{q}_1,\\ldots,\\boldsymbol{q}_N,\\dot{\\boldsymbol{q}}_1,\\ldots,\\dot{\\boldsymbol{q}}_N)=\\sum_{j=1}^{N}m_j\\|\\dot{\\boldsymbol{q}}_j\\|^2/2+U(\\boldsymbol{q}_1,\\ldots,\\boldsymbol{q}_N)$，§1.2印刷p.18/PDF41。",
    "粒子向量可按坐标展平；三维时n=N_c=3N，直线运动时n=N；本地固定对角质量公式覆盖两者，不约束不同坐标质量相等，需审计确认这种推广。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch01.energy_conservation",
  "reusable_proofs": [
    "MolecularDynamics.mechanical_energy_hasDerivAt_zero",
    "MolecularDynamics.mechanical_energy_const_on_Ioo",
    "MolecularDynamics.massHamiltonian_massOperator",
    "MolecularDynamics.newtonTrajectory_to_mechanicalSolution"
  ],
  "extra_assumptions": [
    "hm: 固定对角质量正；牛顿相空间重写使用逆质量。",
    "hU: U在Q每点可微；保证原文链式法则有意义。",
    "时间取开连通区间Ioo a b；能量比较仅对s,t属于该区间，不作越过解存在区间的结论。"
  ],
  "statement_scope": "p.19首句及紧接的导数计算；后续总动量守恒是另一条，未摘录。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "LOCAL_DRAFT",
      "reason": "对照原页及PDF字体记录统一数学斜体E和粗体质量矩阵M；没有改写原文措辞。",
      "before_sha256": "7f312da1537b6dbc8de851fa3386482fce4bb6e0cd4da388f067e5bc8e71c458",
      "after_sha256": "602eec4ec54600d2453b232c7f51b0ab138de3d3f56be31e060fb6e6d0aed2c5"
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


/-- source_id: MD-1.2-EnergyConservation · unnumbered claim · printed p.19 / PDF p.42
Original: Along Newtonian solutions the total energy is conserved and its derivative vanishes.
[EXTRA] hm: positive fixed diagonal masses for the auxiliary phase-space rewriting.
[EXTRA] hU: a differentiable potential makes the chain-rule computation meaningful.
[EXTRA] open connected time interval: comparisons are inside the solution interval.
The conclusion uses the position-velocity energy of (1.4), not only its momentum form.
The coordinate model admits arbitrary diagonal masses; physical 3D atom masses
are obtained by repeating each particle mass three times (semantic audit pending). -/
theorem energy_conservation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b : ℝ) (q : ℝ → Position n)
    (hm : ∀ i, 0 < m i) (hU : ∀ x ∈ Q, DifferentiableAt ℝ U x)
    (hq : IsNewtonTrajectoryOn m U Q (Ioo a b) q) :
    (∀ t ∈ Ioo a b, HasDerivAt
      (fun s => nBodyTotalEnergy m U (q s) (deriv q s)) 0 t) ∧
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b,
      nBodyTotalEnergy m U (q s) (deriv q s) =
      nBodyTotalEnergy m U (q t) (deriv q t) := by
  have hγ : IsMechanicalSolutionOn m (fun x => -gradient U x) Q (Ioo a b)
      (fun t => (q t, massOperator m (deriv q t))) := by
    apply newtonTrajectory_to_mechanicalSolution m (fun x => -gradient U x) Q
      (Ioo a b) q (deriv q) (deriv (deriv q)) hm hq.1
    intro t ht
    refine ⟨(hq.2 t ht).1, (hq.2 t ht).2.1, ?_⟩
    ext i
    exact congrArg (fun v : Position n => v i) ((hq.2 t ht).2.2)
  constructor
  · intro t ht
    simpa only [massHamiltonian_massOperator] using
      mechanical_energy_hasDerivAt_zero m (fun x => -gradient U x) U Q (Ioo a b)
        (fun t => (q t, massOperator m (deriv q t))) hm isOpen_Ioo hγ hU
        (fun _ _ => rfl) t ht
  · intro s hs t ht
    simpa only [massHamiltonian_massOperator] using
      mechanical_energy_const_on_Ioo m (fun x => -gradient U x) U Q a b
        (fun t => (q t, massOperator m (deriv q t))) hm hγ hU
        (fun _ _ => rfl) s t hs ht
end MD.Ch01
```
