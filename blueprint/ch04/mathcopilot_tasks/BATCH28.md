# BATCH28 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.4.2-DLMStructureFormal
```json
{
  "source_id": "MD-4.4.2-DLMStructureFormal",
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
  "lean_decl": "MD.Ch04.dlmStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]旧正式库单体质量一致对象单独保留；原任意N体耦合势的算法几何声明另列。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem dlmStructure :
  ∀ M (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h) ∧ ∀ z : MolecularDynamics.Chapter04Review.RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      MolecularDynamics.Chapter04Review.dlmMassConsistent M I U (-h) (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z)=z ∧
      (MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2ᵀ*(MolecularDynamics.Chapter04Review.dlmMassConsistent M I U h z).2.2=1
```

### MD-4.4.2-DLMPrintedStructure
```json
{
  "source_id": "MD-4.4.2-DLMPrintedStructure",
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
  "lean_decl": "MD.Ch04.dlmPrintedStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem dlmPrintedStructure : ∀ (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (dlmPrinted I U h)
```

### MD-4.4.2-RigidSystemState
```json
{
  "source_id": "MD-4.4.2-RigidSystemState",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "Procedures given below for rigid body $k$ are meant to be performed for all rigid bodies in the system.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemState",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整N体状态的透明类型别名：每体(q,p,π,Θ)；下列势U可耦合全部刚体，不限于单体或独立势。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
@[reducible] def rigidSystemState (N : ℕ) := Fin N → MolecularDynamics.Chapter04Review.RBState
```

### MD-4.4.2-RigidSystemForce
```json
{
  "source_id": "MD-4.4.2-RigidSystemForce",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "The relevant expressions are $F_k=-\\partial U/\\partial q^k$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实耦合势的第k个位置切片Fréchet梯度；其余坐标保持在当前完整状态。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemForce",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
```

### MD-4.4.2-RigidSystemTorque
```json
{
  "source_id": "MD-4.4.2-RigidSystemTorque",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "$\\tau_k=-\\operatorname{rot}(\\Theta^{kT}\\partial U/\\partial\\Theta^k)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实矩阵元素Fréchet偏导；rot(A)=skew⁻¹(A−Aᵀ)，没有额外1/2。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemTorque",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
```

### MD-4.4.2-RigidSystemKick
```json
{
  "source_id": "MD-4.4.2-RigidSystemKick",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "“Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:\n\\[p^k:=p^k+\\tfrac h2 F_k;\\quad\\pi^k:=\\pi^k+\\tfrac h2\\tau_k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "参数h表示本次kick长度；整体算法以h/2调用，全部力/力矩从同一当前状态同时计算。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemKick",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))
```

### MD-4.4.2-RigidSystemDriftPrinted
```json
{
  "source_id": "MD-4.4.2-RigidSystemDriftPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "“Drift”: step forward a whole step in positions\n\\[q^k:=q^k+hp^k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原字面缺1/Mk；完整N体版本保留原式，不静默补质量。"
    }
  ],
  "lean_decl": "MD.Ch04.rigidSystemDriftPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidSystemDriftPrinted {N : ℕ} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)
```

### MD-4.4.2-RigidSystemSpinPrinted
```json
{
  "source_id": "MD-4.4.2-RigidSystemSpinPrinted",
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
    "原表为列动量Rπ与方向ΘRᵀ，与正式库一致；每个子轴角使用当前已更新动量。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "正角Rπ与π×ω的子流符号疑点保留，不冒充已证精确刚体子流。"
    }
  ],
  "lean_decl": "MD.Ch04.rigidSystemSpinPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rigidSystemSpinPrinted {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)
```

