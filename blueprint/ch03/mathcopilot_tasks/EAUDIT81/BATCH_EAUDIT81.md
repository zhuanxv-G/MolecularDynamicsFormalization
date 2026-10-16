# EAUDIT81：第3章§3.6.3网站修复复审

## 原文JSON
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
    "完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT46_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:40:10.328476",
      "before_sha256": "b98434709f81240dc75df83f4385bf50bb833c39adb7244062c4d491138a5bc2",
      "after_sha256": "252c8cd527e8af5fc1aed7a06632d2b9b244c645c745768a2e31208efd77ec21",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT46/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem trapezoidalProperties :
  (∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) h z w,
    linearInvolution R → (∀ x, f (R x)=-R (f x)) → trapezoidalRelation f h z w →
    trapezoidalRelation f h (R w) (R z)) ∧
  ∃ (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ),
    ContDiff ℝ ∞ H ∧ ContDiff ℝ 1 (G h) ∧
    (∀ z, G h z=z+(h/2) • (textbookHamiltonianVectorField H z+textbookHamiltonianVectorField H (G h z))) ∧
    ¬ IsTextbookSymplecticMap (G h) := by
  sorry
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticMap
```lean
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch03.linearInvolution
```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
### 实际依赖 MD.Ch03.trapezoidalRelation
```lean
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)
```

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
