# EAUDIT55：第3章§3.3.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.3.4-TakahashiPotential",
  "kind": "definition",
  "label": null,
  "section": "3.3.4",
  "printed_page": "112",
  "pdf_page": "134",
  "statement_latex": "Recall the Takahashi-Imada method introduced in the last chapter,\n\\[\\widehat P:=p-(h/2)\\nabla\\widetilde U(q),\\qquad Q:=q+hM^{-1}\\widehat P,\\qquad P:=\\widehat P-(h/2)\\nabla\\widetilde U(Q),\\]\nwith modified potential energy function\n\\[\\widetilde U(q)=U(q)-\\frac{h^2}{24}\\nabla U(q)^TM^{-1}\\nabla U(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际takahashiPotential体为U−h²/24 ∑ᵢ(grad U)ᵢ²/mᵢ，实际kick-drift-kick梯度取整个修正势。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.takahashiImada",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M为固定对角质量矩阵，原第1章机械模型。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:17:19.170756",
      "before_sha256": "c89a86c0d02dad2ffd08b91db478d68d12883e1f78c0b21688e9f003f110ccea",
      "after_sha256": "638bd049b17c6bba138e9919358570a28031b086e4d3d94f0be219b536d09087",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MD.Ch03.takahashiImada
```lean
def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.takahashiPotential
```lean
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i
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

## 原文JSON
```json
{
  "source_id": "MD-3.3.4-TakahashiShadow",
  "kind": "definition",
  "label": null,
  "section": "3.3.4",
  "printed_page": "112",
  "pdf_page": "134",
  "statement_latex": "This is certainly not a coincidence. If we replace the potential $U$ by $\\widetilde U$ in the Verlet expansion, we have\n\\[\\begin{aligned}\\widetilde H_h&=T+\\widetilde U+\\frac{h^2}{12}\\left(\\{T,\\{T,\\widetilde U\\}\\}-\\frac12\\{\\widetilde U,\\{\\widetilde U,T\\}\\}\\right)+O(h^4)\\\\\n&=T+U-\\frac{h^2}{24}\\{U,\\{U,T\\}\\}+\\frac{h^2}{12}\\left(\\{T,\\{T,\\widetilde U\\}\\}-\\frac12\\{\\widetilde U,\\{\\widetilde U,T\\}\\}\\right)+O(h^4)\\\\\n&=H+\\frac{h^2}{12}\\left(\\{T,\\{T,\\widetilde U\\}\\}-\\{\\widetilde U,\\{\\widetilde U,T\\}\\}\\right)+O(h^4)\\\\\n&=H+\\frac{h^2}{12}\\left(p^TM^{-1}U''M^{-1}p-\\nabla U^TM^{-1}\\nabla U\\right)+O(h^4).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书同段推导完整存于statement_latex；有限函数定义不证明该推导或实际余项。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条存最后展示式到h²的有限函数；Poisson→梯度推导属前条待证明，不把定义称为已证实际匹配。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.takahashiShadow2",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留有限函数并补修正势代入原Verlet影子多项式后的O(h⁴)差界、真实TI步的Hamiltonian匹配（端点O(h⁵)）；正质量、C∞、紧集为显式充分资格，Poisson到梯度联系保留相邻PotentialDoubleBracket。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:17:19.170756",
      "before_sha256": "dcfd5e7f1caf83c12cb29cbe25d67c81ac825b9947060575b8f040cb2c6f80ee",
      "after_sha256": "c551aa627901f374cffb30244e196c6e6a606d0c2e9bf021ea0e86eb75f13ccd",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT44_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:38:48.594473",
      "before_sha256": "c551aa627901f374cffb30244e196c6e6a606d0c2e9bf021ea0e86eb75f13ccd",
      "after_sha256": "67eb4c9cbada92c3a3f2dd5c0de9bbf71aef7f3c322ef5de27f3d69fd5a169a9",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT44/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)

theorem takahashiShadow2_matching (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ)
    (_hm : positiveMass m) (_hU : ContDiff ℝ ∞ U) (B : Set (SymplecticCoordinates n))
    (_hB : IsCompact B) :
    matchesHamiltonian (fun h z ↦ takahashiShadow2 m U h (unpack z))
      (takahashiImada m U) B 4 ∧
    (∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
      |verletModifiedH (fun x ↦ quadraticKinetic m (unpack x).2)
        (fun x ↦ takahashiPotential m U h (unpack x).1) h z-
        takahashiShadow2 m U h (unpack z)| ≤ C*h^4) := by
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
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
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
### 实际依赖 MD.Ch03.takahashiImada
```lean
def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.takahashiPotential
```lean
def takahashiPotential {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (q : Q n) : ℝ :=
  U q - h^2/24 * ∑ i, (grad U q i)^2 / m i
```
### 实际依赖 MD.Ch03.takahashiShadow2
```lean
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)
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
### 实际依赖 MD.Ch03.textbookPoissonBracket
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
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
### 实际依赖 MolecularDynamics.Chapter02Review.unpack
```lean
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
```
### 实际依赖 MD.Ch03.verletModifiedH
```lean
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)
```
