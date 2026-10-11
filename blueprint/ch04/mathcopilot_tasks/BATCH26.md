# BATCH26 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4.2-PrintedSpinAxis
```json
{
  "source_id": "MD-4.4.2-PrintedSpinAxis",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "$\\pi^k:=\\Theta\\pi^k;\\quad\\Theta^k:=\\Theta^k\\Theta^T$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "高倍率原页确认：π为列向量左乘R，Θ右乘Rᵀ；与正式库spinAxis的定义一致。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p174正角列动量Rπ的导数符号与(4.41)π×ω相反；保留原算法，不证明其精确子流。"
    }
  ],
  "lean_decl": "MD.Ch04.printedSpinAxis",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-11",
      "reason": "原页高倍率复核纠正预备转录：列动量Rπ、方向ΘRᵀ与正式库一致；第二及第三拆分均缺下标。原记录归档，正角与π×ω子流符号疑点仍待审。",
      "before": "blueprint/ch04/validation/transcription-repair-20261011/BEFORE.json",
      "visual_sha256": {
        "blueprint/ch04/source_pages/p195-split-detail.png": "2187e0fc326143559f3ee751a3d628e8168e8376ed833d5b4d440bb1cf5039b0",
        "blueprint/ch04/source_pages/p196-spin-detail.png": "103c0a22caee08e216a7a749055fb24cd007afd063c43f0139555845b335c501"
      }
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def printedSpinAxis (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (h : ℝ) (s : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  let R := MolecularDynamics.Chapter04Review.axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)
```

### MD-4.4.2-PrintedSpinStep
```json
{
  "source_id": "MD-4.4.2-PrintedSpinStep",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "“Spin”: update the rotational state of the kth rigid body by the sequence of steps\n\\[\\Theta:=\\Theta^x(\\tfrac h2\\pi_1^k/I_1);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^y(\\tfrac h2\\pi_2^k/I_2);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^z(h\\pi_3^k/I_3);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^y(\\tfrac h2\\pi_2^k/I_2);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^x(\\tfrac h2\\pi_1^k/I_1);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实五轴算法映射；保留字面旋转/动量符号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.printedSpinStep",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-11",
      "reason": "原页高倍率复核纠正预备转录：列动量Rπ、方向ΘRᵀ与正式库一致；第二及第三拆分均缺下标。原记录归档，正角与π×ω子流符号疑点仍待审。",
      "before": "blueprint/ch04/validation/transcription-repair-20261011/BEFORE.json",
      "visual_sha256": {
        "blueprint/ch04/source_pages/p195-split-detail.png": "2187e0fc326143559f3ee751a3d628e8168e8376ed833d5b4d440bb1cf5039b0",
        "blueprint/ch04/source_pages/p196-spin-detail.png": "103c0a22caee08e216a7a749055fb24cd007afd063c43f0139555845b335c501"
      }
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def printedSpinStep (I : MolecularDynamics.Chapter04Review.V) (h : ℝ) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 → MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)
```

