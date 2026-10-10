# BATCH21 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.6.3-SymplecticNotReversible
```json
{
  "source_id": "MD-3.6.3-SymplecticNotReversible",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条保留单位质量谐振子Symplectic Euler相对于机械R的反例；辛性已有第2章SymplecticEuler证明；trapezoidal相邻条目单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.symplecticNotReversible",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticNotReversible :
  ∃ (h : ℝ) (z : Z 1),
    canonicalReversal (textbookSymplecticEuler (fun _ : Fin 1 => 1) (fun q => q 0^2/2) h
      (canonicalReversal (textbookSymplecticEuler (fun _ => 1) (fun q => q 0^2/2) h (pack z)))) ≠ pack z
```

### MD-3.6.3-TrapezoidalRelation
```json
{
  "source_id": "MD-3.6.3-TrapezoidalRelation",
  "kind": "definition",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原页只举Trapezoidal Rule名称，没有印出更新式；[EXTRA]补标准定义Z=z+h(f(z)+f(Z))/2作为后条对象，非本页逐字新增公式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.trapezoidalRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "补梯形法标准隐式关系作为审阅上下文。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)
```

### MD-3.6.3-TrapezoidalProperties
```json
{
  "source_id": "MD-3.6.3-TrapezoidalProperties",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条保留梯形关系在正确反转下可逆及一个真实Hamiltonian非辛步解反例；Symplectic Euler相邻反例单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.trapezoidalProperties",
  "reusable_proofs": [],
  "extra_assumptions": [
    "完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem trapezoidalProperties :
  (∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) h z w,
    linearInvolution R → (∀ x, f (R x)=-R (f x)) → trapezoidalRelation f h z w →
    trapezoidalRelation f h (R w) (R z)) ∧
  ∃ (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ),
    ContDiff ℝ ⊤ H ∧ ContDiff ℝ 1 (G h) ∧
    (∀ z, G h z=z+(h/2) • (textbookHamiltonianVectorField H z+textbookHamiltonianVectorField H (G h z))) ∧
    ¬ IsTextbookSymplecticMap (G h)
```

### MD-3.6.3-HamiltonianSpectrum
```json
{
  "source_id": "MD-3.6.3-HamiltonianSpectrum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "For example, consider a linear Hamiltonian system $\\mathrm dz/\\mathrm dt=JAz$, with $A$ a symmetric matrix. If $\\lambda$ is an eigenvalue of $JA$ then $JAu=\\lambda u$ for some eigenvector $u\\ne0$. Because the matrix $JA$ is real, we know that $\\overline\\lambda$ will also be an eigenvalue. At the same time, we know that since $\\lambda$ is an eigenvalue of $JA$ it is also an eigenvalue of its transpose $(JA)^T=A^TJ^T=-AJ$, thus\n\\[-AJu=\\lambda u\\]\nmultiplying by $J$ and setting $v=Ju$ we have\n\\[-JAv=\\lambda v\\]\nimplying that $-\\lambda$ (and hence also $-\\overline\\lambda$) is an eigenvalue of $JA$. Real eigenvalues of $JA$ are paired with their negatives. If the imaginary part is nonzero, the eigenvalues occur in quadruplets $\\{\\pm\\lambda,\\pm\\overline\\lambda\\}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "同一u一般不是转置特征向量；四元素集合可重复，不声称总有4个互异值。"
    }
  ],
  "lean_decl": "MD.Ch03.hamiltonianSpectrum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ), A.transpose=A → ∀ ζ,
    complexEigenvalue (textbookJ n*A) ζ → complexEigenvalue (textbookJ n*A) (-ζ) ∧
      complexEigenvalue (textbookJ n*A) (star ζ)
```

### MD-3.6.3-SymplecticSpectrum
```json
{
  "source_id": "MD-3.6.3-SymplecticSpectrum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "The flow map is\n\\[\\mathcal F_t(z)=\\mathrm e^{tJA}z\\]\nand the exponential matrix will inherit a related structure within the spectrum: $\\lambda$ an eigenvalue of $\\exp(tJA)$ implies that $\\overline\\lambda$, $1/\\lambda$ and $1/\\overline\\lambda$ are all eigenvalues of $\\exp(tJA)$. This eigenvalue structure is generic for linear symplectic maps in general.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文一般线性辛矩阵的谱结论直接表达；指数流实例来自线性流为辛的性质；ζ≠0明确，不假设逆谱。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.symplecticSpectrum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ),
    A.transpose*textbookJ n*A=textbookJ n → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ)
```

### MD-3.6.3-ReversibleSpectrum
```json
{
  "source_id": "MD-3.6.3-ReversibleSpectrum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131",
  "pdf_page": "153",
  "statement_latex": "Suppose now we have a linear time-reversible map $\\phi(z)=Tz$, then\n\\[T^{-1}=RTR.\\]\nGiven an eigenvalue, eigenvector pair $(\\lambda,u)$ of $T$, let $u=Rv$, so that $Ru=R^2v=v$, then\n\\[T^{-1}v=RTRv=RTu=\\lambda Ru=\\lambda v.\\]\nThus $\\lambda$ is an eigenvalue of $T^{-1}$ which, in turn, implies that $1/\\lambda$ is an eigenvalue of $T$. The matrix being real implies that the conjugates of $\\lambda$ and $1/\\lambda$ are also eigenvalues, thus we have the same eigenvalue quadruplets as for a linear symplectic map.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.reversibleSpectrum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "T可逆、R²=I明确；真实complexEigenvalue，非零性作为结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem reversibleSpectrum :
  ∀ (n : ℕ) (A R : Matrix (Fin n) (Fin n) ℝ), IsUnit A.det → R*R=1 →
    A⁻¹=R*A*R → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ)
```

### MD-3.6.3-ConjugateIterates
```json
{
  "source_id": "MD-3.6.3-ConjugateIterates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "131–132",
  "pdf_page": "153–154",
  "statement_latex": "Recall that a pair of maps $\\Phi$ and $\\Psi$ are said to be conjugate if there is a homomorphism $\\chi$ such that\n\\[\\Phi=\\chi^{-1}\\Psi\\chi.\\]\nIn such a case the iterates of the two maps will also be conjugate",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "数值effective order的附加断言另列ConjugateOrderPrinted，不靠有限共轭恒等式声称已证。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原文homomorphism至少需可逆；连续渐近运输还需homeomorphism。"
    }
  ],
  "lean_decl": "MD.Ch03.conjugateIterates",
  "reusable_proofs": [
    "MolecularDynamics.textbook_conjugate_iterates"
  ],
  "extra_assumptions": [
    "χ明确为equivalence，以使原文χ⁻¹有定义；原文homomorphism的用词待审。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n])
```

### MD-3.6.3-ConjugateOrderPrinted
```json
{
  "source_id": "MD-3.6.3-ConjugateOrderPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.3",
  "printed_page": "132",
  "pdf_page": "154",
  "statement_latex": "and, if they are numerical methods, they will have similar stability properties and performance (e.g. the same effective order).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "homeomorphism可用平方根改变误差阶；原文缺定量正则性，不能由迭代共轭冒充已证同有效阶。"
    }
  ],
  "lean_decl": "MD.Ch03.conjugateOrderPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "将“same effective order”按同一局部误差幂阶和真实共轭参考流解释；χ至少homeomorphism、紧初值域、r>0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem conjugateOrderPrinted :
    ∀ (n r : ℕ) (χ : Q n ≃ₜ Q n) (G Φ : ℝ → Q n → Q n) (B : Set (Q n)),
      0 < r → IsCompact B → MolecularDynamics.Chapter03Review.localOrder G Φ B r →
      MolecularDynamics.Chapter03Review.localOrder
        (fun h z => χ (G h (χ.symm z))) (fun h z => χ (Φ h (χ.symm z))) (χ '' B) r
```

