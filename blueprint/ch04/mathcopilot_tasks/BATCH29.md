# BATCH29 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4.2-DLMPrintedSystem
```json
{
  "source_id": "MD-4.4.2-DLMPrintedSystem",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "DLM Rigid Body Molecular Dynamics Step\n1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:\n\\[p^k:=p^k+\\tfrac h2 F_k;\\quad\\pi^k:=\\pi^k+\\tfrac h2\\tau_k.\\]\n2. “Drift”: step forward a whole step in positions\n\\[q^k:=q^k+hp^k.\\]\n3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps\n\\[\\Theta:=\\Theta^x(\\tfrac h2\\pi_1^k/I_1);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^y(\\tfrac h2\\pi_2^k/I_2);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^z(h\\pi_3^k/I_3);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^y(\\tfrac h2\\pi_2^k/I_2);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^x(\\tfrac h2\\pi_1^k/I_1);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T.\\]\n4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $F_k$ and torques $\\tau_k$ evaluated at the current $q,\\Theta$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整任意N及耦合势；末kick由更新后的全部位置和方向重新求力/力矩，不把它们冻结在旧状态。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "完整原表的缺质量drift与正角spin疑点保持；编译定义不代表正确辛性。"
    }
  ],
  "lean_decl": "MD.Ch04.dlmPrintedSystem",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)
```

### MD-4.4.2-SystemDriftSpinCommute
```json
{
  "source_id": "MD-4.4.2-SystemDriftSpinCommute",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "as the updates Drift/Spin are decoupled, the order they are performed is not important.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "任意N的真实全状态两个函数复合相等；只有drift/spin互换，不交换依赖耦合势的kick。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.systemDriftSpinCommute",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem systemDriftSpinCommute : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V) h (z : rigidSystemState N),
    rigidSystemDriftPrinted h (rigidSystemSpinPrinted I h z)=
      rigidSystemSpinPrinted I h (rigidSystemDriftPrinted h z)
```

### MD-4.4.2-RigidSystemSymplectic
```json
{
  "source_id": "MD-4.4.2-RigidSystemSymplectic",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173–174",
  "pdf_page": "195–196",
  "statement_latex": "the combined scheme is a symplectic method in the generalized sense of constrained dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)
```

### MD-4.4.2-DLMPrintedSystemStructure
```json
{
  "source_id": "MD-4.4.2-DLMPrintedSystemStructure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173–174",
  "pdf_page": "195–196",
  "statement_latex": "The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.dlmPrintedSystemStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem dlmPrintedSystemStructure : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h)
```

