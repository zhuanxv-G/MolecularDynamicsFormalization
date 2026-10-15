# EAUDIT26：第3章§3.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.3.2-VerletHamiltonianParts",
  "kind": "definition",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "We can think of the velocity Verlet method as being defined by a splitting into three parts:\n\\[H(q,p)=H_1+H_2+H_3,\\qquad H_1=\\frac12U(q),\\qquad H_2=\\frac12p^TM^{-1}p,\\qquad H_3=\\frac12U(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "T=½pᵀM⁻¹p；三部分按U/2,T,U/2顺序，不交换。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletHamiltonianParts",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 绑定真实正对角质量、T(p)=pᵀM⁻¹p/2及U(q)，补H1+H2+H3=H；移除任意相空间函数替代机械分解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:15:22.765671",
      "before_sha256": "78fcba90628d00f3daa0fd01a2804143faf452a12ab4e517bd96e4777ad92d9a",
      "after_sha256": "d6a1a8146863fda52b629b7aee29662851ddc0d3f410b0b956bfb29e86f1f946",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def verletHamiltonianParts {n : ℕ} (m : Fin n → ℝ)
    (_hm : positiveMass m) (U : Q n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z ↦ U (unpack z).1/2),
    (fun z ↦ quadraticKinetic m (unpack z).2), (fun z ↦ U (unpack z).1/2)]

theorem verletHamiltonianParts_sum {n : ℕ} (m : Fin n → ℝ)
    (hm : positiveMass m) (U : Q n → ℝ) (z : SymplecticCoordinates n) :
    (∑ i : Fin 3, verletHamiltonianParts m hm U i z) =
      quadraticKinetic m (unpack z).2+U (unpack z).1 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.Chapter03Review.quadraticKinetic
```lean
def quadraticKinetic {n : ℕ} (m : Fin n → ℝ) (p : Q n) : ℝ := (∑ i, p i^2/m i)/2
```
### 实际依赖 MolecularDynamics.Chapter02Review.unpack
```lean
def unpack {n : ℕ} (z : SymplecticCoordinates n) : Z n := (z ∘ Sum.inl, z ∘ Sum.inr)
```
### 实际依赖 MD.Ch03.verletHamiltonianParts
```lean
def verletHamiltonianParts {n : ℕ} (m : Fin n → ℝ)
    (_hm : positiveMass m) (U : Q n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z ↦ U (unpack z).1/2),
    (fun z ↦ quadraticKinetic m (unpack z).2), (fun z ↦ U (unpack z).1/2)]
```

## 原文JSON
```json
{
  "source_id": "MD-3.3.2-VerletModifiedHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH lemma gives\n\\[\\begin{aligned}\\widetilde H_h={}&T+U+\\frac{h^2}{12}\\left(\\{T,\\{T,U\\}\\}-\\frac12\\{U,\\{U,T\\}\\}\\right)\\\\\n&+\\frac{h^4}{120}\\left(-\\frac16\\{T,\\{T,\\{T,\\{T,U\\}\\}\\}\\}+\\frac13\\{U,\\{T,\\{T,\\{T,U\\}\\}\\}\\}-\\frac14\\{U,\\{U,\\{T,\\{T,U\\}\\}\\}\\}+\\{T,\\{T,\\{U,\\{U,T\\}\\}\\}\\}\\right)+O(h^6).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只定义到h⁴的印刷有限函数；h²/h⁴系数实际匹配另条；一般T,U暂未假定机械T。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletModifiedH",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 本条仅保留展示式到h⁴的有限多项式；一般可分离T(p),U(q)的完整形式系数及O(h⁶)匹配由MD-3.3.2-VerletModifiedMatching补全，原展示式及余项原文不删。"
  ],
  "statement_scope": "展示式中到h⁴的有限多项式辅助定义；BCH系数匹配及Hamiltonian O(h⁶)余项范围由MD-3.3.2-VerletModifiedMatching承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:15:22.765671",
      "before_sha256": "8c4ae90750d51f811616403fd6e9f730eaf406471d67fb6fcf0b8f3d325b3f28",
      "after_sha256": "c82e85855f8da74ffa53fbf4c1785a3e227007a8fd8a32da21ebf050df911878",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)
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
### 实际依赖 MD.Ch03.textbookPoissonBracket
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
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

## 原文JSON
```json
{
  "source_id": "MD-3.3.2-VerletModifiedMatching",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107",
  "pdf_page": "129",
  "statement_latex": "In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH lemma gives",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整印刷h²,h⁴展开见同页VerletModifiedHamiltonian；本条不静默换成另一种Verlet或改h²系数。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "与速度/位置Verlet的组合次序共同核对h²,h⁴系数；原文Hamiltonian O(h⁶)与实际匹配阶也需裁定。"
    }
  ],
  "lean_decl": "MD.Ch03.verletModifiedMatching",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正对角质量、U全域C∞、紧初值B；完整印刷h⁴截断实际O(h⁶)端点匹配为额外严格化。",
    "[EXTRA] 保留已列机械特例，新增一般分离T(p),U(q)、真实局部子流、h⁴系数及所有截断匹配；Hamiltonian余项从h⁶起（奇项零），对应端点O(h⁷)，不混同两个余项。新结论暂sorry，未裁定印刷系数是否正确。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:15:22.765671",
      "before_sha256": "42b5a580bd6a41b2ecb6ac6bf3879597e7ac2cfa3e2b9324b67bf300762b9ed9",
      "after_sha256": "73b7f9ae7ac0d6ad3aee77c79dac138ae121348051e4f3b5fed4a9d3495bff37",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletModifiedMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ⊤ U → IsCompact B →
    matchesHamiltonian (verletModifiedH (fun z => quadraticKinetic m (unpack z).2) (fun z => U (unpack z).1))
      (coordinateVerlet m (textbookPotentialForce U)) B 5 := by
  sorry

theorem verletModifiedMatching_general (n : ℕ) (T U : Q n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (η : ℝ) (_hT : ContDiff ℝ ⊤ T) (_hU : ContDiff ℝ ⊤ U)
    (_hD : IsOpen D) (_hB : IsCompact B) (_hBD : B ⊆ D)
    (_hΦ : actualFlow (textbookHamiltonianVectorField (fun z ↦ T (unpack z).2)) D Φ η)
    (_hΨ : actualFlow (textbookHamiltonianVectorField (fun z ↦ U (unpack z).1)) D Ψ η) :
    let Tp := fun z : SymplecticCoordinates n ↦ T (unpack z).2
    let Uq := fun z : SymplecticCoordinates n ↦ U (unpack z).1
    let G := fun h ↦ Ψ (h/2) ∘ Φ h ∘ Ψ (h/2)
    matchesHamiltonian (verletModifiedH Tp Uq) G B 6 ∧
    (∃ Hj : ℕ → SymplecticCoordinates n → ℝ,
      (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      (∀ z ∈ D, Hj 0 z = Tp z+Uq z) ∧
      (∀ z ∈ D, Hj 2 z =
        (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq) z-
          textbookPoissonBracket Uq (textbookPoissonBracket Uq Tp) z/2)/12) ∧
      (∀ z ∈ D, Hj 4 z =
        (-textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/6+
          textbookPoissonBracket Uq (textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/3-
          textbookPoissonBracket Uq (textbookPoissonBracket Uq (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/4+
          textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Uq (textbookPoissonBracket Uq Tp))) z)/120) ∧
      (∀ j z, Hj (2*j+1) z = 0) ∧
      ∀ k ≥ 6, matchesHamiltonian (fun h z ↦ ∑ j ∈ Finset.range k, h^j*Hj j z) G B k) := by
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
### 实际依赖 MolecularDynamics.Chapter03Review.actualFlow
```lean
def actualFlow {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (D : Set E) (Φ : ℝ → E → E) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ D, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.Chapter03Review.matchesHamiltonian
```lean
def matchesHamiltonian {n : ℕ} (K : ℝ → SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (B : Set (SymplecticCoordinates n)) (p : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧ solution (textbookHamiltonianVectorField (K h)) (Γ h z) 0 h ∧
      ‖G h z-Γ h z h‖ ≤ C*h^(p+1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.Chapter03Review.quadraticKinetic
```lean
def quadraticKinetic {n : ℕ} (m : Fin n → ℝ) (p : Q n) : ℝ := (∑ i, p i^2/m i)/2
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
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

## 原文JSON
```json
{
  "source_id": "MD-3.3.2-ModifiedEven",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.2",
  "printed_page": "107–108",
  "pdf_page": "129–130",
  "statement_latex": "The extra power of $h$ in the leading perturbation reflects the fact that this method is 2nd order accurate, rather than first order, as Symplectic Euler. Note that only even order terms $(h^2,h^4,\\ldots)$ appear in the perturbative expansion; this is a consequence of the symmetry of the method.\nSetting $s=-t$, the left hand side of (3.4) collapses to the identity. Hence the surviving even-powered terms in the expansion on the right hand side of (3.5) must be zero. If the even order terms vanish, then the effect of composing linear operators symmetrically is to keep only odd order terms in the exponent, giving the symmetric BCH formula\n\\[\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(t(X+Y)+t^3\\widetilde Z_{[3]}+\\cdots).\\tag{3.6}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "formalLog奇次⇔除以形式变量h后的modifiedHamiltonian为偶次；原文证明中使用不同步长log交换的额外断言另列ERRATUM，结论不靠该假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.modifiedEven",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补一阶log系数A+B并保留全部偶次零，表达至少二阶及Hamiltonian偶性/log奇性；不沿用不同步长log交换的错误推理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:15:22.765671",
      "before_sha256": "fa8f8d23dbb14fc9d12a2908f7068e957cffa558addcea4105f968be08199849",
      "after_sha256": "de2a692cd0a6dc7c25592b63a8d366765dd2fddd97b909cf059c1a37a5fbaed1",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem modifiedEven :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧ ∀ j : ℕ,
    PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter03Review.formalLog
```lean
def formalLog {R : Type*} [Ring R] [Algebra ℝ R] (P : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun n => ∑ j ∈ Finset.Icc 1 n,
    ((-1 : ℝ)^(j+1)/(j:ℝ)) • PowerSeries.coeff n ((P-1)^j))
```
### 实际依赖 MD.Ch03.formalStrang
```lean
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3.2-Strang",
  "kind": "definition",
  "label": null,
  "section": "3.3.2",
  "printed_page": "108",
  "pdf_page": "130",
  "statement_latex": "For Hamiltonians $X$ and $Y$, consider symmetrizing a composition of exponentials (a Strang splitting), such that\n\\[\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(tZ_t)=\\exp(t\\widetilde Z_{[1]}+t^2\\widetilde Z_{[2]}+t^3\\widetilde Z_{[3]}+t^4\\widetilde Z_{[4]}+\\cdots).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本定义为左端真实形式乘积；PDF130右端为exp(t widetilde Z_[1]+t² widetilde Z_[2]+t³ widetilde Z_[3]+⋯)，没有共同外层t。各Z_[j]按指数总幂编号，与(3.5)一致；不假设不同步长log交换。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p.108/PDF130第一展开把Z_[2]配t²、Z_[3]配t³，而下一展开(3.5)按总指数幂2、3排列；保留原页不静默纠正索引。"
    }
  ],
  "lean_decl": "MD.Ch03.formalStrang",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:15:22.765671",
      "before_sha256": "1f2639c516fa471bc20fa64aa12a6a5685559514017929bbba58be018a4c19a5",
      "after_sha256": "4bb2a1a9bfe4b9cb679de8b0da239ba84a2bbd21fd3c827347026bbfe8283b55",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
```
### 实际依赖 MD.Ch03.formalStrang
```lean
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.3.2-StrangCubic",
  "kind": "unnumbered_claim",
  "label": "(3.6)–(3.7)",
  "section": "3.3.2",
  "printed_page": "108",
  "pdf_page": "130",
  "statement_latex": "\\[\\exp(\\tfrac t2X)\\exp(tY)\\exp(\\tfrac t2X)=\\exp(t(X+Y)+t^3\\widetilde Z_{[3]}+\\cdots),\\tag{3.6}\\]\nwhere\n\\[\\widetilde Z_{[3]}=\\frac1{12}[Y,[Y,X]]-\\frac1{24}[X,[X,Y]].\\tag{3.7}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$X,Y$为非交换形式生成元；[A,B]=AB−BA；签名直接为真实formalLog三次系数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.strangCubic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补一次系数和全部偶次零，连同原三次公式覆盖完整奇次展开；原已证三次系数保留辅助并重查，新合取暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:15:22.765671",
      "before_sha256": "fb259abd48b9ce38baba28d9424a29f9960572f5a64657fcdbf8028dae246d07",
      "after_sha256": "4d11be381b7c40a6d24acdbcbba354ab3bc3a066dba50c25ea2791f50d172d09",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH09_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem strangCubic :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧
    (∀ j : ℕ, PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0) ∧
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B) := by
  sorry

theorem strangCubic_coeff3 :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B) := by
  intro R _ _ A B
  norm_num [formalLog, formalStrang, textbookFormalOperatorExponential,
    PowerSeries.coeff_mk, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Nat.factorial_succ, pow_succ, Finset.sum_Icc_succ_top, MolecularDynamics.Chapter03Review.commutator,
    mul_add, add_mul, mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
    smul_add, smul_sub, smul_smul]
  simp only [mul_assoc]
  module
```
### 实际依赖 MolecularDynamics.Chapter03Review.commutator
```lean
def commutator {R : Type*} [Ring R] (A B : R) : R := A*B-B*A
```
### 实际依赖 MolecularDynamics.Chapter03Review.commutator
```lean
def commutator {R : Type*} [Ring R] (A B : R) : R := A*B-B*A
```
### 实际依赖 MolecularDynamics.Chapter03Review.formalLog
```lean
def formalLog {R : Type*} [Ring R] [Algebra ℝ R] (P : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun n => ∑ j ∈ Finset.Icc 1 n,
    ((-1 : ℝ)^(j+1)/(j:ℝ)) • PowerSeries.coeff n ((P-1)^j))
```
### 实际依赖 MD.Ch03.formalStrang
```lean
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)
```
### 实际依赖 MolecularDynamics.textbookFormalOperatorExponential
```lean
noncomputable def textbookFormalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```
