# EAUDIT52：第3章§3.3.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.3.1-SymplecticEulerShadowMatching",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.1",
  "printed_page": "106",
  "pdf_page": "128",
  "statement_latex": "The BCH expansion gives the perturbed Hamiltonian",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页展示式逐字保存在SymplecticEulerShadow；数值symplectic Euler采用第2章坐标约定。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "原文只写Hamiltonian O(h⁴)，实际端点O(h⁵)解释与数值坐标顺序待审。"
    }
  ],
  "lean_decl": "MD.Ch03.symplecticEulerShadowMatching",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C∞、紧初值集B；截断h³的实际局部流端点O(h⁵)为额外严格化。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT41_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:36:50.397597",
      "before_sha256": "e0de91710efc9ccff65cd35bc2835c4a6bf79e46972f5bd964defd1a1edfe62d",
      "after_sha256": "5aa56fbb27920459630cde305d462a9c2c093f8a5d8f8d41b88bb88a85a6f348",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT41/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticEulerShadowMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ∞ U → IsCompact B →
    matchesHamiltonian (fun h z => symplecticEulerShadow3 m U h (unpack z))
      (textbookSymplecticEuler m U) B 4 := by
  sorry
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
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter03Review.hessianAction
```lean
def hessianAction {n : ℕ} (U : Q n → ℝ) (q v : Q n) : Q n := (fderiv ℝ (grad U) q) v
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter03Review.matchesHamiltonian
```lean
def matchesHamiltonian {n : ℕ} (K : ℝ → SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (B : Set (SymplecticCoordinates n)) (p : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧ solution (textbookHamiltonianVectorField (K h)) (Γ h z) 0 h ∧
      ‖G h z-Γ h z h‖ ≤ C*h^(p+1)
```
### 实际依赖 MolecularDynamics.Chapter03Review.mechanicalEnergy
```lean
def mechanicalEnergy {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n) : ℝ := quadraticKinetic m z.2+U z.1
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.Chapter03Review.quadraticKinetic
```lean
def quadraticKinetic {n : ℕ} (m : Fin n → ℝ) (p : Q n) : ℝ := (∑ i, p i^2/m i)/2
```
### 实际依赖 MolecularDynamics.Chapter03Review.shadowTerms
```lean
def shadowTerms {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n) : ℝ × ℝ × ℝ :=
  let v := invMass m z.2
  ((∑ i, v i * hessianAction U z.1 v i),
    (∑ i, grad U z.1 i * invMass m (grad U z.1) i),
    (∑ i, invMass m (grad U z.1) i * hessianAction U z.1 v i))
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
```
### 实际依赖 MD.Ch03.symplecticEulerShadow3
```lean
def symplecticEulerShadow3 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z-h/2*(∑ i, invMass m z.2 i*grad U z.1 i)+
    h^2/12*((shadowTerms m U z).1+(shadowTerms m U z).2.1)-h^3/12*(shadowTerms m U z).2.2
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
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookSymplecticEuler
```lean
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.unpack
```lean
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
```
