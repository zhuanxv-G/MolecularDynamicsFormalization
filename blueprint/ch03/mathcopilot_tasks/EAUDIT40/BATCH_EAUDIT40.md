# EAUDIT40：第3章§3.3网站修复复审

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
