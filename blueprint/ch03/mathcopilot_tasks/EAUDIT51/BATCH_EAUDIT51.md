# EAUDIT51：第3章§3.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.3-HamiltonianLieAdditivity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "103",
  "pdf_page": "125",
  "statement_latex": "As the relation\n\\[\\mathcal L_H\\phi=\\{\\phi,H\\}\\]\nis linear in $H$, we may write, for Hamiltonians $H_1,H_2$,\n\\[\\mathcal L_{H_1+H_2}=\\mathcal L_{H_1}+\\mathcal L_{H_2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "对任意观测量F的算子相等；$\\mathcal L_H$记号见p.102/PDF124。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianLieAdditivity",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianLieDerivative_add"
  ],
  "extra_assumptions": [
    "H₁,H₂在z可微；原文smooth资格显式化。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:04:52.365030",
      "before_sha256": "9228a127923180eb8f5b977b24f54085c61f136d177f3b50ed412d9365dab0f9",
      "after_sha256": "e41cf985c69ad717d99e38912feee119fc29b457f2cf466275ccc0f366a328af",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonianLieAdditivity (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_add <;> assumption
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
### 实际依赖 MD.Ch03.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3-FormalSplitting",
  "kind": "definition",
  "label": null,
  "section": "3.3",
  "printed_page": "103",
  "pdf_page": "125",
  "statement_latex": "The flow map of the system with Hamiltonian $H=H_1+H_2$ is\n\\[\\mathcal F_t=e^{t(\\mathcal L_{H_1}+\\mathcal L_{H_2})}.\\]\nOn the other hand, the splitting method based on a composition of flows on $H_1$ and $H_2$ is\n\\[\\mathcal G_h=e^{h\\mathcal L_{H_1}}e^{h\\mathcal L_{H_2}}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A,B分别表示$\\mathcal L_{H_1},\\mathcal L_{H_2}$；形式指数，不能由此假设实际级数收敛。",
    "状态映射与观测量pullback组合顺序相反；实际Hamiltonian匹配条目另待审。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalSplitting",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L_H1、B=L_H2；仅形式系数，不宣称解析收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:04:52.365030",
      "before_sha256": "278d323a5d006fb46ffac9594eb0af0791938822807fbb389d90c5ef5c8c1a11",
      "after_sha256": "78577d410fe7edd5f4a01128d42575a072f0b98616ca00f524e6e4b517d4ed14",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B

def formalExactSplit {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential (A+B)

def hamiltonianSplittingObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun k ↦ ∑ i ∈ Finset.range (k+1),
    ((textbookLieDerivative (textbookHamiltonianVectorField A))^[i]
      ((textbookLieDerivative (textbookHamiltonianVectorField B))^[k-i] φ)) z /
      ((Nat.factorial i : ℝ)*(Nat.factorial (k-i) : ℝ)))

def hamiltonianExactObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j ↦
    ((textbookLieDerivative (textbookHamiltonianVectorField (fun x ↦ A x+B x)))^[j] φ) z /
      (Nat.factorial j : ℝ))
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
### 实际依赖 MD.Ch03.formalExactSplit
```lean
def formalExactSplit {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential (A+B)
```
### 实际依赖 MD.Ch03.formalSplitting
```lean
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B
```
### 实际依赖 MD.Ch03.hamiltonianExactObservable
```lean
def hamiltonianExactObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j ↦
    ((textbookLieDerivative (textbookHamiltonianVectorField (fun x ↦ A x+B x)))^[j] φ) z /
      (Nat.factorial j : ℝ))
```
### 实际依赖 MD.Ch03.hamiltonianSplittingObservable
```lean
def hamiltonianSplittingObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun k ↦ ∑ i ∈ Finset.range (k+1),
    ((textbookLieDerivative (textbookHamiltonianVectorField A))^[i]
      ((textbookLieDerivative (textbookHamiltonianVectorField B))^[k-i] φ)) z /
      ((Nat.factorial i : ℝ)*(Nat.factorial (k-i) : ℝ)))
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
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
### 实际依赖 MD.Ch03.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3-ExactExponentialCubic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "103",
  "pdf_page": "125",
  "statement_latex": "Expanding these out using the exponential series we have\n\\[\\begin{aligned}e^{h(A+B)}&=\\mathrm{Id}+h(A+B)+\\frac{h^2}{2}(A+B)^2+\\frac{h^3}{6}(A+B)^3+O(h^4)\\\\\n&=\\mathrm{Id}+h(A+B)+\\frac{h^2}{2}(AB+BA+A^2+B^2)\\\\\n&\\quad+\\frac{h^3}{6}(A^3+A^2B+AB^2+ABA+B^2A+BA^2+BAB+B^3)+O(h^4),\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$R$为任意实结合环代数；不添加AB=BA；$O(h^4)$按形式系数次数≥4解释，不宣称实际范数余项。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.exactExponentialCubic",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorExponential_coeff"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:04:52.365030",
      "before_sha256": "4d7170803a39c9a5a4f762f7a286e094be2b29786e9623d7aefced4b9f0dd03c",
      "after_sha256": "e65aabfb736f2eb460a748ad9e9cffea07eb5ef60a37c92b8115bee23e491463",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem exactExponentialCubic (A B : R) :
    (∀ j < 4, PowerSeries.coeff j (textbookFormalOperatorExponential (A+B)) =
      (1/(j.factorial : ℝ)) • (A+B)^j) ∧
    ((A+B)^2 = A*B+B*A+A^2+B^2) ∧
    ((A+B)^3 = A^3+A^2*B+A*B^2+A*B*A+B^2*A+B*A^2+B*A*B+B^3) := by
  refine ⟨fun j _ => textbookFormalOperatorExponential_coeff (A+B) j, ?_, ?_⟩
  · noncomm_ring
  · noncomm_ring
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3-DifferenceCommutator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "104",
  "pdf_page": "126",
  "statement_latex": "So the difference is\n\\[e^{hA}e^{hB}-e^{h(A+B)}=\\frac{h^2}{2}[A,B]+O(h^3),\\]\nwhere $[A,B]=AB-BA$ is the commutator of $A$ and $B$.\nFor a splitting method, we have, replacing $A$ by $\\mathcal L_{H_1}$ and $B$ by $\\mathcal L_{H_2}$,\n\\[e^{h\\mathcal L_{H_1}}e^{h\\mathcal L_{H_2}}-e^{h\\mathcal L_H}=\\frac{h^2}{2}[\\mathcal L_{H_1},\\mathcal L_{H_2}]+O(h^3).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$[A,B]=AB-BA$定义合并旧CH03-032；Hamiltonian算子是同一形式代数恒等式的实例；H=H₁+H₂及Lie加法见p.103/PDF125。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.differenceCommutator",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorDifference_coeff_two"
  ],
  "extra_assumptions": [
    "[EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:04:52.365030",
      "before_sha256": "4900ca0b64dc0c57f28fd88769cd8108b0a8f1ccf3f3b960fb298d8d1825c32a",
      "after_sha256": "5f854aba91b319dd5c7e87f4fcbab3a3863d6b9bf4910f6a7b59855bda86c328",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT40_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:36:10.671141",
      "before_sha256": "5f854aba91b319dd5c7e87f4fcbab3a3863d6b9bf4910f6a7b59855bda86c328",
      "after_sha256": "9c13b9b1aee97bbf925dbb24272a4c59287591532cf092534e042a6508933fe5",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT40/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem differenceCommutator (A B : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1/2 : ℝ) • (A*B-B*A) := by
  sorry

theorem differenceCommutator_coeff2 (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_two <;> assumption

theorem differenceCommutator_hamiltonian (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ∞ A) (_hB : ContDiff ℝ ∞ B) (_hφ : ContDiff ℝ ∞ φ)
    (z : SymplecticCoordinates n) :
    let S := hamiltonianSplittingObservable A B φ z-hamiltonianExactObservable A B φ z
    PowerSeries.coeff 0 S = 0 ∧ PowerSeries.coeff 1 S = 0 ∧
    PowerSeries.coeff 2 S = (1/2 : ℝ)*
      (textbookLieDerivative (textbookHamiltonianVectorField A)
        (textbookLieDerivative (textbookHamiltonianVectorField B) φ) z -
       textbookLieDerivative (textbookHamiltonianVectorField B)
        (textbookLieDerivative (textbookHamiltonianVectorField A) φ) z) := by
  sorry
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
### 实际依赖 MD.Ch03.hamiltonianExactObservable
```lean
def hamiltonianExactObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j ↦
    ((textbookLieDerivative (textbookHamiltonianVectorField (fun x ↦ A x+B x)))^[j] φ) z /
      (Nat.factorial j : ℝ))
```
### 实际依赖 MD.Ch03.hamiltonianSplittingObservable
```lean
def hamiltonianSplittingObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun k ↦ ∑ i ∈ Finset.range (k+1),
    ((textbookLieDerivative (textbookHamiltonianVectorField A))^[i]
      ((textbookLieDerivative (textbookHamiltonianVectorField B))^[k-i] φ)) z /
      ((Nat.factorial i : ℝ)*(Nat.factorial (k-i) : ℝ)))
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
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
### 实际依赖 MD.Ch03.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3-DifferenceCubic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "104",
  "pdf_page": "126",
  "statement_latex": "\\[e^{hA}e^{hB}-e^{h(A+B)}=\\frac{h^2}{2}(AB-BA)+\\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页差值展示式的三次系数；二次系数见DifferenceCommutator，不省略整个差式的另一子句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.differenceCubic",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalOperatorDifference_coeff_three"
  ],
  "extra_assumptions": [
    "[EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:04:52.365030",
      "before_sha256": "44337cc431d89a0f2b37d6726ee5296e7ca3e32d5ecc05a3232fc630b814cae4",
      "after_sha256": "b397765fcccf71c5a35f7247f0b46248386591d514f3e0644904c2a283726041",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem differenceCubic (A B : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1/2 : ℝ) • (A*B-B*A) ∧
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  sorry

theorem differenceCubic_coeff3 (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_three <;> assumption
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3-LeadingModifiedExponential",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "105",
  "pdf_page": "127",
  "statement_latex": "Because of this, we may interpret the first term in the expansion of the error as itself being derived from a Hamiltonian. This is a crucial observation which suggests an alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:\n\\[e^{hA}e^{hB}=e^{h(A+B+hR)},\\]\nfor some operator $R$. Expanding out the right hand side gives\n\\[\\begin{aligned}e^{h(A+B+hR)}&=\\mathrm{Id}+h(A+B+hR)+\\frac{h^2}{2}(A+B+hR)^2+\\cdots\\\\\n&=\\mathrm{Id}+hA+hB+h^2R+\\frac{h^2}{2}\\bigl(A^2+AB+BA+B^2+h^2R^2+h(A+B)R+hR(A+B)\\bigr)+\\cdots.\\end{aligned}\\]\nComparing this to our expansion for $e^{hA}e^{hB}$, for agreement to $O(h^2)$ we must have\n\\[\\frac12(2AB+A^2+B^2)=R+\\frac12(A^2+AB+BA+B^2)=O(h),\\]\nor\n\\[R=AB-\\frac12(AB+BA)=\\frac12[A,B]+O(h),\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A、B 为非交换算子，[A,B]=AB−BA；R 可随 h 变化。Lean 只核对形式变量 h 的次数 0、1、2，取 R 的首项 R₀=(AB−BA)/2；不形式化原页全部印刷等式或无限级数收敛。",
    "保留原页比较式的连续两个等号及末尾 O(h)，不静默改成系数之差。原页括号内含 h²R² 和两个 h 交叉项，整体受 h²/2 乘子作用。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p.105/PDF127比较式似应为二次系数之差（第二项前负号）；展示h³交叉项似缺1/2。最终R₀式与既有匹配一致。"
    }
  ],
  "lean_decl": "MD.Ch03.leadingModifiedExponential",
  "reusable_proofs": [
    "MolecularDynamics.textbookFormalModifiedExponential_matches_product"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT06_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:04:52.365030",
      "before_sha256": "c899a170045791e031c109d355f6e7287a44d2939fe963ab560ebad35f633b0d",
      "after_sha256": "30a8f70b4e1b05e1f003c77b0661bd116f3694badbb141300d99958b4c179ebc",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH06_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT06/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem leadingModifiedExponential (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
  sorry
```
### 实际依赖 MolecularDynamics.modifiedGenerator
```lean
private noncomputable def modifiedGenerator (A B C : R) : PowerSeries R :=
  PowerSeries.C (A + B) * PowerSeries.X + PowerSeries.C C * PowerSeries.X ^ 2

omit [Algebra ℝ R] in
```
### 实际依赖 MolecularDynamics.textbookFormalModifiedExponential
```lean
noncomputable def textbookFormalModifiedExponential (A B C : R) : PowerSeries R :=
  textbookFormalZeroConstantExponential
    ⟨modifiedGenerator A B C, modifiedGenerator_zero A B C⟩

omit [Algebra ℝ R] in
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```
### 实际依赖 MolecularDynamics.textbookFormalZeroConstantExponential
```lean
noncomputable def textbookFormalZeroConstantExponential
    (P : {P : PowerSeries R // PowerSeries.constantCoeff P = 0}) : PowerSeries R :=
  PowerSeries.mk (fun j => ∑ n ∈ Finset.range (j + 1),
    (1 / (n.factorial : ℝ)) • PowerSeries.coeff j (P.val ^ n))
```

## 原文JSON
```json
{
  "source_id": "MD-3.3-CommutingFlows",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "If $H_1$ and $H_2$ Poisson-commute, i.e.\n\\[\\{H_1,H_2\\}=0,\\]\nthen there is no error in splitting.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页固定Hamiltonians及对应真实局部流；不假设两个流本身已相等。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.commutingFlows",
  "reusable_proofs": [],
  "extra_assumptions": [
    "光滑Hamiltonian、开放域及三个真实局部流；|h|<η/2保证复合时间在所给流的定义区间。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT40_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:36:10.671141",
      "before_sha256": "143afd104188e5996c3f44516fbf0fb38d9931aa6e0ac01f7f333a587d749143",
      "after_sha256": "4f7b3e13606370fb84460b7f3fabbddff8e4a8ab980f4e74468af7814518b7da",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH06_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT40/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem commutingFlows :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ Ψ Χ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ∞ A D → ContDiffOn ℝ ∞ B D →
    (∀ z ∈ D, textbookPoissonBracket A B z=0) →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    actualFlow (textbookHamiltonianVectorField (fun z => A z+B z)) D Χ η →
    ∀ z ∈ D, ∀ h ∈ Ioo (-η/2) (η/2), Φ h (Ψ h z)=Χ h z := by
  sorry
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
### 实际依赖 MolecularDynamics.Chapter03Review.actualFlow
```lean
def actualFlow {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (D : Set E) (Φ : ℝ → E → E) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ D, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
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
### 实际依赖 MD.Ch03.textbookPoissonBracket
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```
