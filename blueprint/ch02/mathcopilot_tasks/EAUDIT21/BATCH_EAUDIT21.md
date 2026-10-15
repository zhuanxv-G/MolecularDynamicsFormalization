# EAUDIT21：第2章§2.5.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.5.2-GeneralSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.2",
  "printed_page": "91",
  "pdf_page": "113",
  "statement_latex": "To see that it is symplectic, we first note that this is a symmetric composition of the form\n\\[\\mathcal K_h=\\mathcal G_{h/2}^{\\dagger}\\circ\\mathcal G_{h/2},\\]\nso it is enough to show that this basic method is symplectic.",
  "proof_latex": "Taking differentials of (2.30) defining $\\mathcal G_h$ and then wedge products and summing, we have\n\\[\\sum_i dQ_i\\wedge dP_i=\\sum_i dq_i\\wedge dP_i+h\\sum_i\\sum_j H_{p_iq_j}dq_j\\wedge dP_i+h\\sum_i\\sum_j H_{p_ip_j}dP_j\\wedge dP_i.\\]\nThe last term on the right vanishes by equality of mixed partials and the antisymmetry of the wedge product. On the other hand, using (2.29), we obtain, by similar means,\n\\[\\sum_i dq_i\\wedge dP_i=\\sum_i dq_i\\wedge dp_i-h\\sum_i\\sum_j H_{q_ip_j}dq_i\\wedge dP_j.\\]\nRelabelling the indices in the sum and using our previous work results in\n\\[\\sum_i dQ_i\\wedge dP_i=\\sum_i dq_i\\wedge dp_i,\\]\nimplying that the method is symplectic.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.generalSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "H C²，真实C¹完整求解映射，逐点满足实际隐式关系。",
    "[EXTRA] 本条承担基本隐式辛Euler的辛性；同一原句的伴随半步复合、三步关系与对称性由MD-2.5.2-GeneralVerletSymplectic补全，原文不删。"
  ],
  "statement_scope": "基本隐式辛Euler的辛性子结论；所引原句的半步伴随复合、三步对应及对称辛性归MD-2.5.2-GeneralVerletSymplectic。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:29:29.340383",
      "before_sha256": "05543a12c6101687f9590ea88b7506409638990c85368ef8f6e705f7d075bf28",
      "after_sha256": "f3a57be1c092b4a56a8a5cd3424a8e73be28fd40492797d5014917efbdc2a252",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH29_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem generalSymplectic :
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n) h,
    ContDiff ℝ 2 H → ContDiff ℝ 1 G →
    (∀ z, generalSymplecticEulerRelation H h (unpack z) (unpack (G z))) → IsTextbookSymplecticMap G
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
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.generalSymplecticEulerRelation
```lean
def generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2
```
### 实际依赖 MolecularDynamics.Chapter02Review.partialP
```lean
def partialP {n : ℕ} (H : Z n → ℝ) (q p : Q n) : Q n :=
  fun i => (fderiv ℝ (fun x => H (q,x)) p) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.partialQ
```lean
def partialQ {n : ℕ} (H : Z n → ℝ) (q p : Q n) : Q n :=
  fun i => (fderiv ℝ (fun x => H (x,p)) q) (Pi.single i 1)
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
### 实际依赖 MolecularDynamics.Chapter02Review.unpack
```lean
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
```

## 原文JSON
```json
{
  "source_id": "MD-2.5.2-GeneralVerletSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.2",
  "printed_page": "91",
  "pdf_page": "113",
  "statement_latex": "To see that it is symplectic, we first note that this is a symmetric composition",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整原文主语是(2.26)–(2.28)；GeneralSymplectic条目保存全部原书证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.generalVerletSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "H C²，实际C¹中间动量和完整求解映射，满足三步隐式关系。",
    "[EXTRA] 以真实可逆且C¹的基本求解族构造伴随半步复合V，补三步关系、V自伴随及辛性；仅δ小步长要求真实Euler关系，全球可逆族明确为条件性[EXTRA]，不宣称一般隐式方程必有全球解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:29:29.340383",
      "before_sha256": "42e856af9e9a513a842f5e7e88c9558e4a0ed972aba84d83675d7451cbd4b497",
      "after_sha256": "d136e9e03d24de80a9f1487c1473fa3a16b4cdfb52a61ba9b32bfb73007a847c",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH29_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem generalVerletSymplectic
    (n : ℕ) (H : Z n → ℝ) (G : ℝ → Equiv.Perm (SymplecticCoordinates n))
    (δ : ℝ) (_hδ : 0 < δ) (_hH : ContDiff ℝ 2 H)
    (_hG : ∀ h ∈ Ioo (-δ) δ, ContDiff ℝ 1 (G h))
    (_hInv : ∀ h ∈ Ioo (-δ) δ, ContDiff ℝ 1 (G h).symm)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z,
      generalSymplecticEulerRelation H h (unpack z) (unpack (G h z))) :
    let V : ℝ → Equiv.Perm (SymplecticCoordinates n) :=
      fun h ↦ (G (h/2)).trans (textbookAdjointMethod G (h/2))
    (∀ h, (V h : SymplecticCoordinates n → SymplecticCoordinates n) =
      textbookAdjointMethod G (h/2) ∘ G (h/2)) ∧
    textbookAdjointMethod V = V ∧
    (∀ h ∈ Ioo (-δ) δ, IsTextbookSymplecticMap (V h) ∧
      ∀ z, partitionedVerletRelation H h (unpack z) (unpack (V h z))
        (unpack (G (h/2) z)).2)
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
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.generalSymplecticEulerRelation
```lean
def generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2
```
### 实际依赖 MolecularDynamics.Chapter02Review.partialP
```lean
def partialP {n : ℕ} (H : Z n → ℝ) (q p : Q n) : Q n :=
  fun i => (fderiv ℝ (fun x => H (q,x)) p) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.partialQ
```lean
def partialQ {n : ℕ} (H : Z n → ℝ) (q p : Q n) : Q n :=
  fun i => (fderiv ℝ (fun x => H (x,p)) q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.partitionedVerletRelation
```lean
def partitionedVerletRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) (p : Q n) : Prop :=
  p = z.2 - (h/2) • partialQ H z.1 p ∧
  w.1 = z.1 + (h/2) • (partialP H z.1 p + partialP H w.1 p) ∧
  w.2 = p - (h/2) • partialQ H w.1 p
```
### 实际依赖 MolecularDynamics.textbookAdjointMethod
```lean
noncomputable def textbookAdjointMethod {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
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
### 实际依赖 MolecularDynamics.Chapter02Review.unpack
```lean
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
```
