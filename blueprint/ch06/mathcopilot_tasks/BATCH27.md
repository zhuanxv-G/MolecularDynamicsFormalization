# BATCH27 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.7-VectorIto
```json
{
  "source_id": "MD-6.3.7-VectorIto",
  "kind": "unnumbered_claim",
  "label": "(6.40)–(6.41)",
  "section": "6.3.7",
  "printed_page": "243",
  "pdf_page": "264",
  "statement_latex": "If $\\phi$ is a scalar valued function of $\\mathbb R^m$, and $Z(t)$ is the solution of the SDE system\n\\[dZ=a(Z)dt+B dW;\\tag{6.39}\\]\nwhere $a$ is a function in $\\mathbb R^m$ and $B$ is a constant matrix, then we have\n\\[d\\phi(Z(t))=\\nabla\\phi\\cdot[adt+B dW]+\\tfrac12dW^TB^T\\phi''B dW;\\tag{6.40}\\]\n\\[d\\phi(Z(t))=\\nabla\\phi\\cdot[adt+B dW]+\\tfrac12\\operatorname{Tr}(B^T\\phi''B)dt.\\tag{6.41}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.vectorIto",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]按本节实际常矩阵B范围；真实全部坐标严格Ito积分与Hessian/trace完整校正，未缩成仅漂移定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem vectorIto : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (φ : (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 → ContDiff ℝ 2 φ →
  (∀ j, MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P (fun t sample ↦ W t sample j)
    (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j))) →
  ∀ T : ℝ, 0 ≤ T → ∃ integrals : Fin r → Ω → ℝ,
    (∀ j, strictItoIntegral P (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T (integrals j)) ∧
    (∀ᵐ sample ∂P, φ (X T sample)-φ x0-
      (∫ s in 0..T, MolecularDynamics.Chapter06Review.vectorGenerator a B φ (X s sample))=∑ j, integrals j sample)
```

### MD-6.3.7-VectorForward
```json
{
  "source_id": "MD-6.3.7-VectorForward",
  "kind": "definition",
  "label": null,
  "section": "6.3.7",
  "printed_page": "243",
  "pdf_page": "264",
  "statement_latex": "In the multivariate case, the density is a function of the vector describing a state of the system $z$ and $t$, and is governed by the partial differential equation\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\nabla\\cdot(a(z)\\rho(z))+\\tfrac12\\operatorname{Tr}(B^T\\rho''B).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原本节常矩阵B实际完整负散度+正1/2二阶扩散；PDE从真实law推出另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.vectorForward",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def vectorForward {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x
```

### MD-6.3.7-DiffusionTrace
```json
{
  "source_id": "MD-6.3.7-DiffusionTrace",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.7",
  "printed_page": "243",
  "pdf_page": "264",
  "statement_latex": "The second order “diffusion” term in this expression may be expanded as\n\\[\\operatorname{Tr}(B^T\\rho''B)=\\sum_{i=1}^m\\sum_{j=1}^m(BB^T)_{ij}\\frac{\\partial^2\\rho}{\\partial z_i\\partial z_j}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.diffusionTrace",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem diffusionTrace :
  ∀ {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ)
    (H : Matrix (Fin n) (Fin n) ℝ),
  Matrix.trace (B.transpose*H*B)=∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j*H i j
```

### MD-6.3.7-VectorFPEquation
```json
{
  "source_id": "MD-6.3.7-VectorFPEquation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.7",
  "printed_page": "243",
  "pdf_page": "264",
  "statement_latex": "In the multivariate case, the density is a function of the vector describing a state of the system $z$ and $t$, and is governed by the partial differential equation\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\nabla\\cdot(a(z)\\rho(z))+\\tfrac12\\operatorname{Tr}(B^T\\rho''B).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.vectorFPEquation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实多维Wiener、严格SDE、完整非负密度law、光滑和局部尾部求导资格；没有将弱PDE结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem vectorFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (ρ : ℝ → (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ k : ℕ, ∀ x, ‖a x‖ ≤ C*(1+‖x‖)^k) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x
```

