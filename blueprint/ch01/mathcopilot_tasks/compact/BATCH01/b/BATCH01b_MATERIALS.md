# BATCH01b 精简审校材料

本批只做原文审校A与只读语义审计C；模板B取消。Lean4.34.0 / Mathlib v4.34.0。
以下原文JSON、Lean签名及依赖定义从冻结输入逐字截取；没有改写定义或假设。
这是供审阅的摘录，不是独立Lean工程；未提供定理证明体，不能据此审计证明或公理。
标准Mathlib运算/微积分符号按该固定版本解释，关键ODE定义另附。

## PDF页码映射

| 附件页 | 原PDF页 | 印刷页 |
|---|---|---|
| 1 | 41 | 18 |
| 2 | 42 | 19 |
| 3 | 45 | 22 |
| 4 | 46 | 23 |
| 5 | 47 | 24 |

## 审校规则

A：逐条打开原页，核对statement_latex、proof_latex、proof_discussion_latex、页码和context_notation。不得把转述当原文，不静默修正原书，不补造原文证明；null表示无独立完整证明。corrected_json需保留完整条目及source_id；证据指出原PDF页和具体短语/公式。
C：以A核对后的原文比对实际定义展开、对象/域、量词、假设和全部结论；逐条判断[EXTRA]是否合理、[ERRATUM?]是否需导师判断。禁止以True、P→P、结论作假设、替换对象通过审计。sorry与签名语义分开判断；只读，不修改工程或写证明；给出具体理由、反例和建议。所需上下文/定义缺失时标NEEDS_HUMAN并列缺项，不能按名称猜测或跳过。
本材料未附本地PASS结果，不得假定本地结论正确。

## 本批完整原文条目与Lean签名

### MD-1.2-EnergyConservation

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
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

声明全名：`MD.Ch01.energy_conservation`；原位置：Blueprint/Ch01.lean。

```lean
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
      nBodyTotalEnergy m U (q t) (deriv q t)
```

### MD-1.3-NewtonEulerLagrange

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
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```

声明全名：`MD.Ch01.newton_iff_euler_lagrange`；原位置：Blueprint/Ch01.lean。

```lean
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
    IsNewtonTrajectoryOn m U Q I q ↔ IsEulerLagrangeTrajectoryOn m U Q I q
```

## 实际依赖定义（逐字摘录）

原Blueprint处于namespace MD.Ch01，open Set MolecularDynamics MeasureTheory MolecularDynamics.Chapter01Review Filter；open scoped ContDiff InnerProductSpace BigOperators Topology Matrix.Norms.L2Operator。n表示配置坐标数N_c；三维原子模型中N_c=3N。
每段的namespace和文件路径仅说明原上下文，定义体保持原样。

### MolecularDynamics.CoordinateMasses

原文件：MolecularDynamics/Chapter01/NBody.lean:19。

```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```

### MolecularDynamics.IsEulerLagrangeTrajectoryOn

原文件：MolecularDynamics/Chapter01/Lagrangian.lean:75。

```lean
def IsEulerLagrangeTrajectoryOn {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (fun s => gradient (fun v => massLagrangian m U (q s) v) (deriv q s))
      (gradient (fun x => massLagrangian m U x (deriv q t)) (q t)) t
```

### MD.Ch01.IsNewtonTrajectoryOn

原文件：Blueprint/Ch01.lean:54。

```lean
def IsNewtonTrajectoryOn {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
    massOperator m (deriv (deriv q) t) = -gradient U (q t)
```

### MolecularDynamics.MassMatrix

原文件：MolecularDynamics/Notation.lean:18。

```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```

### MolecularDynamics.Momentum

原文件：MolecularDynamics/Notation.lean:15。

```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics.Position

原文件：MolecularDynamics/Notation.lean:13。

```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics.PotentialEnergy

原文件：MolecularDynamics/Notation.lean:21。

```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```

### MolecularDynamics.Velocity

原文件：MolecularDynamics/Notation.lean:14。

```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics.diagonalMassMatrix

原文件：MolecularDynamics/Chapter01/NBody.lean:22。

```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```

### MolecularDynamics.massLagrangian

原文件：MolecularDynamics/Chapter01/Lagrangian.lean:22。

```lean
noncomputable def massLagrangian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) : ℝ :=
  nBodyKineticEnergy m v - U q
```

### MolecularDynamics.massOperator

原文件：MolecularDynamics/Chapter01/LocalTrajectories.lean:18。

```lean
noncomputable def massOperator {n : ℕ} (μ : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)).toContinuousLinearMap
```

### MolecularDynamics.nBodyKineticEnergy

原文件：MolecularDynamics/Chapter01/NBody.lean:38。

```lean
noncomputable def nBodyKineticEnergy {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) : ℝ :=
  ∑ i, masses i * (velocity i) ^ 2 / 2
```

### MolecularDynamics.nBodyTotalEnergy

原文件：MolecularDynamics/Chapter01/NBody.lean:53。

```lean
noncomputable def nBodyTotalEnergy {n : ℕ} (masses : CoordinateMasses n)
    (potential : PotentialEnergy n) (position : Position n) (velocity : Velocity n) : ℝ :=
  nBodyKineticEnergy masses velocity + potential position
```

## 返回格式

仅输出一个JSON数组；每个source_id恰好一次。

```json
[{"source_id":"本批ID","json_review":{"status":"APPROVED|CORRECTED|NEEDS_HUMAN","issue_codes":[],"corrected_json":null,"issues":[],"evidence":[]},"audit":{"lean_decl":"完整声明名","verdict":"PASS|FAIL|NEEDS_HUMAN","explanation":"逐项理由","counterexample":null,"suggested_fix":null}}]
```
