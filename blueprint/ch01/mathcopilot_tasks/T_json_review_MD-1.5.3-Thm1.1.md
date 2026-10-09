# T_json_review_MD-1.5.3-Thm1.1

单目标：MD-1.5.3-Thm1.1。模板A，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.32 / PDF p.55；上下文页：PDF 41、48、54–55（印刷18、25、31–32）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。

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

你是独立审校员。只依据所附 PDF 原文，审校下列 JSON 条目：MD-1.5.3-Thm1.1。
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

用户保存到`blueprint/ch01/mathcopilot_results/T_json_review_MD-1.5.3-Thm1.1.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_json_review_MD-1.5.3-Thm1.1",
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
