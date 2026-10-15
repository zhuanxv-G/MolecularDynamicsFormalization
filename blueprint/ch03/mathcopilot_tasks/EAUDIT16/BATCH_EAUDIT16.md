# EAUDIT16：第3章§3.6.3网站修复复审

## 原文JSON
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
    "原文一般线性辛矩阵的谱结论由本签名表达；指数流公式 F_t(z)=exp(tJA)z 及其谱实例未在本签名中表达，需另给线性流公式与 exp(tJA) 辛性的桥接结果。ζ≠0明确，不假设逆谱。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.symplecticSpectrum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留一般辛矩阵谱结论；补对称K的实际线性Hamiltonian流exp(tJK)、ODE、辛矩阵及对应倒数/共轭谱实例。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:26:38.547668",
      "before_sha256": "78788a1ddee2177e27ade859ac5e8c4d0b5dc1a4f50b8c66664c016b063a2d54",
      "after_sha256": "24ff475a9a78ae0aad41188db416d31bea71ca3d93c8e450ead2dac40c40bb97",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ),
    A.transpose*textbookJ n*A=textbookJ n → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ) := by
  sorry

theorem symplecticSpectrum_linearHamiltonian (n : ℕ)
    (K : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ) (_hK : K.IsSymm) :
    let A := textbookJ n*K
    let Φ := fun t : ℝ ↦ NormedSpace.exp (t • A)
    (∀ z, Φ 0 *ᵥ z=z) ∧
    (∀ t z, HasDerivAt (fun s ↦ Φ s *ᵥ z) (A *ᵥ (Φ t *ᵥ z)) t) ∧
    (∀ ζ, complexEigenvalue A ζ → complexEigenvalue A (-ζ) ∧
      complexEigenvalue A (star ζ) ∧ complexEigenvalue A (-star ζ)) ∧
    (∀ t, (Φ t)ᵀ*textbookJ n*Φ t=textbookJ n) ∧
    (∀ t ζ, complexEigenvalue (Φ t) ζ →
      ζ ≠ 0 ∧ complexEigenvalue (Φ t) ζ⁻¹ ∧ complexEigenvalue (Φ t) (star ζ)) := by
  sorry
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.Chapter03Review.complexEigenvalue
```lean
def complexEigenvalue {ι : Type*} [Fintype ι] [DecidableEq ι] (A : Matrix ι ι ℝ) (ζ : ℂ) : Prop :=
  ∃ v : ι → ℂ, v ≠ 0 ∧ (A.map (fun x => (x : ℂ))).mulVec v = ζ • v
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```

## 原文JSON
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
    "数值effective order的附加断言另列ConjugateOrderPrinted，不靠有限共轭恒等式声称已证。",
    "实际签名将空间限制为实赋范空间并将χ限制为homeomorphism；原文迭代代数恒等式只需可逆映射。"
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
    "χ明确为equivalence，以使原文χ⁻¹有定义；原文homomorphism的用词待审。",
    "[EXTRA] 纯迭代恒等式推广到任意类型及真实Equiv，不附拓扑/范数；原Homeomorph已证版本保留辅助，用于拓扑轨道结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT16_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:26:38.547668",
      "before_sha256": "f5fb862f044bcc6a0492a630be97ff47b66ee9d4cd2f76ef2c9bc7f68037d77a",
      "after_sha256": "14d4fe0adadf403bedc1831d5f841e392a7b3d385352a97f4eb4878c3564007f",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT16/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem conjugateIterates {α : Type*} (χ : α ≃ α) (A B : α → α)
    (_hA : A = χ.symm ∘ B ∘ χ) (n : ℕ) :
    A^[n] = χ.symm ∘ (B^[n]) ∘ χ := by
  sorry

theorem conjugateIterates_homeomorph (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption
```
### 实际依赖 MolecularDynamics.textbookConjugateMap
```lean
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```
