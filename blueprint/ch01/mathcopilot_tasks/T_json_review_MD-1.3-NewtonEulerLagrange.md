# T_json_review_MD-1.3-NewtonEulerLagrange

单目标：MD-1.3-NewtonEulerLagrange。模板A，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.23 / PDF p.46；上下文页：PDF 41、45–46（印刷18、22–23）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。

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

你是独立审校员。只依据所附 PDF 原文，审校下列 JSON 条目：MD-1.3-NewtonEulerLagrange。
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

用户保存到`blueprint/ch01/mathcopilot_results/T_json_review_MD-1.3-NewtonEulerLagrange.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_json_review_MD-1.3-NewtonEulerLagrange",
  "input_fingerprint": {
    "source_entry_sha256": "1a2246dbfd6de1a5d68c368c83933fd807672cc490097359d2afea3f40aaf4e8",
    "signature_sha256": "27fd7e1251d62b07011dfeab02b981ad825d1b4c505a630e04a75d5f5eabaf9f",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

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
