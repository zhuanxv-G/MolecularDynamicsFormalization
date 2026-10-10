# BATCH19 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.6.2-FlowReversal
```json
{
  "source_id": "MD-3.6.2-FlowReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "129",
  "pdf_page": "151",
  "statement_latex": "From this we see that if we start from a point $z_0$ and integrate forward in time (i.e apply $\\mathcal F_t$) then apply the involution $R$, we get the exact same result as if we start from $\\widetilde z(0)=Rz_0$ and integrate backward in time (i.e. apply $\\mathcal F_{-t}$). In sum, since $z_0$ is an arbitrary point,\n\\[\\mathcal F_{-t}(Rz)=R\\mathcal F_t(z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.flowReversal",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem flowReversal :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z)
```

### MD-3.6.2-FlowReversalIdentity
```json
{
  "source_id": "MD-3.6.2-FlowReversalIdentity",
  "kind": "unnumbered_claim",
  "label": "(3.14)",
  "section": "3.6.2",
  "printed_page": "129",
  "pdf_page": "151",
  "statement_latex": "For the flow map, $\\mathcal F_{-t}=\\mathcal F_t^{-1}$ so we can recast the identity as\n\\[R\\circ\\mathcal F_t\\circ R\\circ\\mathcal F_t=\\mathrm{Id},\\tag{3.14}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.flowReversalIdentity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正确R反转、C¹场、实际全时间流、群性质；不供应结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem flowReversalIdentity :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z
```

### MD-3.6.2-ReversibleMethod
```json
{
  "source_id": "MD-3.6.2-ReversibleMethod",
  "kind": "definition",
  "label": "(3.15)",
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "It does not automatically follow that a symmetric numerical method is time-reversible, i.e. satisfies a relation inspired by (3.14), namely\n\\[R\\circ\\mathcal G_h\\circ R\\circ\\mathcal G_h=\\mathrm{Id}.\\tag{3.15}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.reversibleMethod",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z
```

### MD-3.6.2-SymmetricMethod
```json
{
  "source_id": "MD-3.6.2-SymmetricMethod",
  "kind": "definition",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "Recall from the previous chapter that a numerical method $\\mathcal G_h$ was said to be symmetric if it satisfied\n\\[\\mathcal G_{-h}=\\mathcal G_h^{-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "equivalence给实际逆映射；与固定R的可逆性分开。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.symmetricMethod",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
```

### MD-3.6.2-AffineInvariant
```json
{
  "source_id": "MD-3.6.2-AffineInvariant",
  "kind": "definition",
  "label": "Definition 3.1",
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "Definition 3.1 (Affine Invariance) Let\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=f(\\boldsymbol z)\\tag{3.16}\\]\nbe a given ordinary differential equation. The transformation $\\widetilde{\\boldsymbol z}=A\\boldsymbol z$, where $A$ is a non-singular square matrix, results in the modified differential equation\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=Af(A^{-1}\\widetilde{\\boldsymbol z}).\\tag{3.17}\\]\nLet $z_0,z_1,\\ldots$ be a sequence of points obtained by application of the numerical method $\\mathcal G_h$ to (3.16). If the same method, when applied to (3.17) produces the set of points $Az_0,Az_1,\\ldots$, then we say that the numerical method is invariant with respect to the transformation $\\widetilde{\\boldsymbol z}=Az$. An affine invariant method is one which is invariant under any such transformation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A为连续线性等价；原定义未含平移，保留该范围；transportedField给真正A f A⁻¹。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "(3.17)左端印刷z而不是z̃；保留原文，语义按前后说明的变换坐标。"
    }
  ],
  "lean_decl": "MD.Ch03.affineInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```

### MD-3.6.2-SymmetricAffineReversible
```json
{
  "source_id": "MD-3.6.2-SymmetricAffineReversible",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "If a differential equation is time-reversible with respect to the involution $R$, and we apply a method which is affine invariant and symmetric, then the method will be time-reversible (3.15).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "一般方法需要G_{−f}(h)=G_f(−h)，否则原文蕴含式条件不全。"
    }
  ],
  "lean_decl": "MD.Ch03.symmetricAffineReversible",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]G_{−f}(h)=G_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symmetricAffineReversible :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ g h z, G (fun x => -g x) h z=G g (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f)
```

### MD-3.6.2-RKAffine
```json
{
  "source_id": "MD-3.6.2-RKAffine",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条仅保留Runge–Kutta实际阶段关系在线性等价下的运输；PRK与对称可逆推论为相邻条目，合起来覆盖原句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.rkAffine",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.rkAffine_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rkAffine :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i))
```

### MD-3.6.2-PartitionedAffinePrinted
```json
{
  "source_id": "MD-3.6.2-PartitionedAffinePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.2",
  "printed_page": "130",
  "pdf_page": "152",
  "statement_latex": "All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "PRK一般只对保持分区的分块线性变换等变；任意混合变换的全称可疑。"
    }
  ],
  "lean_decl": "MD.Ch03.partitionedAffinePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem partitionedAffinePrinted :
  ∀ (n s : ℕ) (L : Z n ≃L[ℝ] Z n) (f : Z n → Z n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) h z w F,
    partitionedRKRelation f Aq Ap bq bp h z w F →
      partitionedRKRelation (fun x => L (f (L.symm x))) Aq Ap bq bp h (L z) (L w) (fun i => L (F i))
```

