# EAUDIT55：第2章§2.2.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.2.2-DiscreteStationaryPrinted",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "63–64",
  "pdf_page": "85–86",
  "statement_latex": "Critical points of this function satisfy\n\\[\\nabla\\hat{\\mathcal A}=0,\\]\nwhere the gradient must be taken with respect to all configurational points on the path (and all coordinates). This condition leads to the equations\n\\[\\frac{\\partial\\hat{\\mathcal A}}{\\partial\\boldsymbol q_n}=0,\\qquad n=1,\\ldots,\\nu,\\]\nsince we think of the starting point $\\boldsymbol q_0$ as fixed.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原页n=1,…,ν包含右端点，后页说端点固定且只对1,…,ν-1求导。保留字面≤ν，不默改为<ν。"
    }
  ],
  "lean_decl": "MD.Ch02.printedDiscreteStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原印0<k≤ν范围和端点疑误；改用HasFDerivAt表达经典零导数，防止不可微处fderiv总化为零；内部节点版本已有独立DiscreteVerlet条目，不裁定端点勘误。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:02:34.602086",
      "before_sha256": "6bef9197c9207cc2703475072ff737bf33abc6ed2d626ebb466918ab916b7979",
      "after_sha256": "8db01bee76c768883e621c73bab2b697c3bad0d560fea82efbe7dd71593962f1",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    HasFDerivAt (fun x ↦ discreteAction L (replaceNode q k x) h ν) (0 : Q n →L[ℝ] ℝ) (q k)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.discreteAction
```lean
def discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)
```
### 实际依赖 MolecularDynamics.Chapter02Review.discreteVelocity
```lean
def discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)
```
### 实际依赖 MD.Ch02.printedDiscreteStationary
```lean
def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    HasFDerivAt (fun x ↦ discreteAction L (replaceNode q k x) h ν) (0 : Q n →L[ℝ] ℝ) (q k)
```
### 实际依赖 MolecularDynamics.Chapter02Review.replaceNode
```lean
def replaceNode {n : ℕ} (q : ℕ → Q n) (k : ℕ) (x : Q n) : ℕ → Q n :=
  Function.update q k x
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.2-DiscreteDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.2",
  "printed_page": "64",
  "pdf_page": "86",
  "statement_latex": "To calculate the derivative of $\\hat{\\mathcal A}$ with respect to $\\boldsymbol q_n$, $n=1,2,\\ldots,\\nu-1$, note that only a few terms of the discrete action involve this configurational point, thus\n\\[\\frac{\\partial\\hat{\\mathcal A}}{\\partial\\boldsymbol q_n}=\\frac{\\partial}{\\partial\\boldsymbol q_n}\\left[\\frac{1}{2h}\\left((\\boldsymbol q_n-\\boldsymbol q_{n-1})^TM(\\boldsymbol q_n-\\boldsymbol q_{n-1})+(\\boldsymbol q_{n+1}-\\boldsymbol q_n)^TM(\\boldsymbol q_{n+1}-\\boldsymbol q_n)\\right)-U(\\boldsymbol q_n)h\\right]=\\frac1h[M(\\boldsymbol q_n-\\boldsymbol q_{n-1})-M(\\boldsymbol q_{n+1}-\\boldsymbol q_n)]-\\nabla U(\\boldsymbol q_n)h,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.discreteActionDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [
    "固定正对角质量、实际U可微、h≠0；仅内部节点0<k<ν；沿p.60及p.63展示的-U作用量。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:02:34.602086",
      "before_sha256": "96a4006c27b45a2ac3b8c8a9d6c7d7acefc4296638a1c86acc290f9e707e7506",
      "after_sha256": "ad47b7dc3a89653b9fffce17494cb632dbda61b31ee2eabceac41ebd6f855010",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem discreteActionDerivative :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.discreteAction
```lean
def discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)
```
### 实际依赖 MolecularDynamics.Chapter02Review.discreteVelocity
```lean
def discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.mechanicalL
```lean
def mechanicalL {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (q v : Q n) : ℝ :=
  (∑ i, m i * v i ^ 2) / 2 - U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.Chapter02Review.replaceNode
```lean
def replaceNode {n : ℕ} (q : ℕ → Q n) (k : ℕ) (x : Q n) : ℕ → Q n :=
  Function.update q k x
```

## 原文JSON
```json
{
  "source_id": "MD-2.2.2-Stormer",
  "kind": "definition",
  "label": null,
  "section": "2.2.2",
  "printed_page": "64",
  "pdf_page": "86",
  "statement_latex": "The method (2.4) is commonly referred to as Störmer’s rule.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "式(2.4)在F(q_n)=−∇U(q_n)下写为$M(q_{n+1}-2q_n+q_{n-1})=h^2F(q_n)$；p.93/PDF115重述逆质量形式；从速度Verlet消去速度的说明及计算见p.65/PDF87。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_stormerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 直接使用原文质量乘法形式M(qₙ₊₁−2qₙ+qₙ₋₁)=h²F(qₙ)，避免零质量下逆质量总化造成对象不等价；仅更改Blueprint本条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:02:34.602086",
      "before_sha256": "a6ccd6a16abfc21ccb1521859c24bba19ebc006915784255943630537c3e40c0",
      "after_sha256": "c4775ec2c8c8173bc44b9271829aa6f24c114de764e52699bac73c68237f2a30",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  mass m (c - (2 : ℝ) • b + a) = h^2 • F b
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.bp_stormerRelation
```lean
def bp_stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  mass m (c - (2 : ℝ) • b + a) = h^2 • F b
```
### 实际依赖 MolecularDynamics.Chapter02Review.mass
```lean
def mass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => m i * v i
```
