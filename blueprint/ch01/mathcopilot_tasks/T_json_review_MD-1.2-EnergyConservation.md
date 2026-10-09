# T_json_review_MD-1.2-EnergyConservation

单目标：MD-1.2-EnergyConservation。模板A，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.19 / PDF p.42；上下文页：PDF 41–42（印刷18–19）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。

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

你是独立审校员。只依据所附 PDF 原文，审校下列 JSON 条目：MD-1.2-EnergyConservation。
对每条：
1. 在 PDF 中定位原文（类型、编号、标题、页码跨度）；
2. 逐字核对 statement_latex 与 proof_latex：对象、类型、量词顺序、全部假设、边界条件、子项；
3. 核对公式、上下标、符号；是否漏句、重复、跨页截断、把证明混入陈述；
4. 主动尝试用 PDF 证据反驳该 JSON。
只输出 JSON：
{ "source_id": ..., "status": "PASS|REPAIRED|NEEDS_HUMAN",
  "issue_codes": [SYMBOL_ERROR|MISSING_CLAUSE|WRONG_OBJECT|WRONG_QUANTIFIER|CROSS_PAGE_GAP|DUPLICATE],
  "corrected_json": {...}, "issues": [...], "evidence": [{"page":..,"text":".."}] }
规则：source_id 不可改；只依据 PDF，不凭记忆；不确定标 NEEDS_HUMAN；不做 Lean 翻译。

## 返回件约定

用户保存到`blueprint/ch01/mathcopilot_results/T_json_review_MD-1.2-EnergyConservation.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_json_review_MD-1.2-EnergyConservation",
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
