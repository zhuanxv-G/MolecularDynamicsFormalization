# T_json_review_MD-1.5.1-FlowInverse

单目标：MD-1.5.1-FlowInverse。模板A，来自`claude-notes/03_MathCopilot任务模板.md`。

## 上传 / @引用

- 教材完整PDF：`formal math/Leimkuhler2015b_Molecular Dynamics_With Deterministic and Stochastic Numerical Methods(1).pdf`。
- 原文条目：印刷 p.26 / PDF p.49；上下文页：PDF 48–49（印刷25–26）。PDF页号从1起算。
- `blueprint/ch01/ch01_source.json`（下面也内嵌本条）。

正式库基线commit：`1b1cbae1bcb27177963a43018fb2c2ba7eb00cb6`。草稿以以下内容哈希锁定；网站不负责推送/改仓库。

```json
{
  "source_entry_sha256": "06763b993229b5b38845e23b63eb2ada6998e9c06565145ad521876f78a4a41a",
  "signature_sha256": "0612c669694cac25394cc94c88490c2844c0ae68af39ec6306d4ab0952450ee4",
  "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
  "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
}
```

本条当前JSON尚未approved，先完成模板A。若A有修复，Codex整合后用新任务版本重生成B/C；只读审计C必须使用approved JSON和当前哈希，不审旧稿。

## 任务正文

你是独立审校员。只依据所附 PDF 原文，审校下列 JSON 条目：MD-1.5.1-FlowInverse。
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

用户保存到`blueprint/ch01/mathcopilot_results/T_json_review_MD-1.5.1-FlowInverse.json`或`.md`。
在模板规定的JSON字段之外，原样添加下列任务名和input_fingerprint；不输出未经检查的PASS。

```json
{
  "task_name": "T_json_review_MD-1.5.1-FlowInverse",
  "input_fingerprint": {
    "source_entry_sha256": "06763b993229b5b38845e23b63eb2ada6998e9c06565145ad521876f78a4a41a",
    "signature_sha256": "0612c669694cac25394cc94c88490c2844c0ae68af39ec6306d4ab0952450ee4",
    "prelude_sha256": "77f7600591b5bbe5133d47340ffafa94447f28291277f092cbe8a9efeb4ef811",
    "project_dependency_inventory_sha256": "81d34f68a0c13c2fc08fd07383a6dd11a6dc0ee4ab026b99edc674389211fe25"
  }
}
```

## 本条JSON输入

```json
{
  "source_id": "MD-1.5.1-FlowInverse",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "The classical systems treated here can be solved forward or backward in time. Observe that $\\mathcal{F}_{-t}\\mathcal{F}_t=\\operatorname{Id}$ (the identity map), thus the flow map is invertible and, indeed, the family of flow maps defined for different values of $t$ form an Abelian group under the operation of composition ($\\mathcal{F}_t\\mathcal{F}_s=\\mathcal{F}_s\\mathcal{F}_t=\\mathcal{F}_{t+s}$).",
  "proof_latex": null,
  "proof_note": "原文用Observe that直接断言；没有独立证明。随后Hamiltonian守恒属于另一个结论，不纳入本条。",
  "context_notation": [
    "式(1.5)：$\\dot{\\boldsymbol{z}}=\\boldsymbol{f}(\\boldsymbol{z})$，$\\boldsymbol{z}(0)=\\boldsymbol{\\xi}$；$m$维空间及flow map定义$\\mathcal{F}_t(\\boldsymbol{\\xi})=\\boldsymbol{z}(t)$：§1.5.1印刷p.26/PDF49。",
    "正文明确继承前小节存在唯一性前提；势能下界、固定正定质量、能量限制下位置紧性：§1.5印刷p.25–26/PDF48–49。",
    "IsGlobalMechanicalFlowOn只假设逐初值全实时间ODE解、ψ 0 z=z和状态域S不变；不把反演、群律或双射藏进假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch01.flow_inverse",
  "reusable_proofs": [
    "MolecularDynamics.globalMechanicalFlow_inverse",
    "MolecularDynamics.globalMechanicalFlow_add",
    "MolecularDynamics.globalMechanicalFlow_commute",
    "MolecularDynamics.globalMechanicalFlow_bijOn"
  ],
  "extra_assumptions": [
    "hψ: 显式全实时间解及S不变，落实正文双向可解和flow map前提；本条不证明全局流存在。",
    "hreg: F在Q为C¹，用于ODE唯一性，落实正文继承的存在唯一性前提。",
    "_hm: 正固定质量，使对象限于原文分子Hamiltonian系统。"
  ],
  "statement_scope": "完整反演/可逆/Abelian群律段；恒等元ψ0由flow定义，结论覆盖双向反演、双射和加法/交换律。",
  "review_status": "DRAFT",
  "repair_log": []
}
```
