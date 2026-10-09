# T_json_review_MD-1.4-LegendreHamiltonian

单目标：MD-1.4-LegendreHamiltonian。模板A，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.24 / PDF p.47；上下文页：PDF 45–47（印刷22–24）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。

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

你是独立审校员。只依据所附 PDF 原文，审校下列 JSON 条目：MD-1.4-LegendreHamiltonian。
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

用户保存到`blueprint/ch01/mathcopilot_results/T_json_review_MD-1.4-LegendreHamiltonian.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_json_review_MD-1.4-LegendreHamiltonian",
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
