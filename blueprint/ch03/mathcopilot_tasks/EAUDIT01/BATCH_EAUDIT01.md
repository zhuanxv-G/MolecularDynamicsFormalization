# EAUDIT01：第3章§3–3.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3-ModifiedConstruction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3",
  "printed_page": "97",
  "pdf_page": "119",
  "statement_latex": "We can express the fundamental consequence as follows: not only are Hamiltonian flow maps symplectic, but also near-identity symplectic maps are (in an approximate sense) Hamiltonian flow maps [31]. The fact leads to the existence of a modified (perturbed) Hamiltonian from which the discrete trajectory may be derived (as snapshots of continuous trajectories). In some cases we may derive this perturbed Hamiltonian as an expansion in powers of the stepsize.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "The starting point is that symplectic integrators are symplectic maps that are “near to the identity” since they depend on a parameter (the stepsize $h$) which can be chosen as small as needed, and, if consistent, in the limit $h\\to0$, such a map must tend to the identity map."
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.modifiedConstruction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "近恒等、光滑、阶r≥1用smoothSymplecticData实际定义表达：开放凸D、紧凸B⊆D、H及(h,z)↦G_h(z)无限可微、G₀=id、逐h辛、实际原始ODE流和局部阶。",
    "按任意有限截断匹配解释“in an approximate sense”；不将形式无限级数当实际收敛解，不将finiteMatching结论作前提。",
    "[EXTRA] EAUDIT01补原首句Hamiltonian流辛性为独立完整结论，与原近恒等辛映射修正Hamiltonian有限匹配合取；两个真实项目命题全部量词展开供审校，未把流辛性作构造前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "6172396c1a8ccaf362e87370db94fbb7b43d3654feaa980c0b88a4a3fd23e237",
      "after_sha256": "6172396c1a8ccaf362e87370db94fbb7b43d3654feaa980c0b88a4a3fd23e237",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH01_result.json",
      "raw_sha256": "120deaa07feab89b86e0bb7ae296ba4fadc1614604f7bb1e18866e1acb26bb97",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem modifiedConstruction :
  MolecularDynamics.Chapter02Review.hamiltonianSymplectic_statement ∧
  MolecularDynamics.Chapter03Review.modifiedConstruction_statement
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
### 实际依赖 MolecularDynamics.Chapter02Review.hamiltonianSymplectic_statement
```lean
def hamiltonianSymplectic_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t,z))
```
### 实际依赖 MolecularDynamics.Chapter03Review.modifiedConstruction_statement
```lean
def modifiedConstruction_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G
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
### 实际依赖 MolecularDynamics.Chapter03Review.actualFlowNearCompact
```lean
def actualFlowNearCompact {n : ℕ} (f : SymplecticCoordinates n → SymplecticCoordinates n)
    (D B : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (η : ℝ) : Prop :=
  0 < η ∧ ∀ z ∈ B, Φ 0 z=z ∧ ∀ t ∈ Ioo (-η) η,
    Φ t z ∈ D ∧ HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter03Review.finiteMatching
```lean
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.hamiltonianSymplectic_statement
```lean
def hamiltonianSymplectic_statement : Prop :=
  ∀ n (H : SymplecticCoordinates n → ℝ) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z) = z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z)) (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t,z))
```
### 实际依赖 MolecularDynamics.Chapter03Review.localOrder
```lean
def localOrder {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G Φ : ℝ → E → E) (B : Set E) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
    ‖G h z-Φ h z‖ ≤ C*|h|^(r+1)
```
### 实际依赖 MolecularDynamics.Chapter03Review.modifiedConstruction_statement
```lean
def modifiedConstruction_statement : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G
```
### 实际依赖 MolecularDynamics.Chapter03Review.smoothSymplecticData
```lean
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ⊤ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r
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
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```
### 实际依赖 MD.Ch03.truncatedFlow
```lean
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

## 原文JSON
```json
{
  "source_id": "MD-3.1-EnergyFailure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "98",
  "pdf_page": "120",
  "statement_latex": "If $H(q,p)=E$ then, for typical steps, we cannot expect $H(Q,P)=E$. (Just insert the formulas for $Q$ and $P$ into the Hamiltonian and check that the value is not the same as $H(q,p)$.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页$H(q,p)=(p^2+\\Omega^2q^2)/2$，$Q=q+hp$、$P=p-h\\Omega^2Q$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorEnergyFailure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01对每个Ω>0和h≠0保存完整ΔH恒等、能量不变的两条例外直线和一般不守恒见证；精确代数为原typical的形式化展开，不回填成教材原句。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "5f6068c438af8569c7ba973c03dec88acd8dab0e9cb1bf64f20b1a6e6881bab2",
      "after_sha256": "012a48046338e20207ba2cd777537101126d46184cce744ab302bea136db60df",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "fa7d079b49802d64f1efbc27c6b0a90cbbf1090b9fc48cc0576829b45ebf4aa1",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem oscillatorEnergyFailure : ∀ Ω h : ℝ, 0 < Ω → h ≠ 0 →
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
    (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2)) ∧
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)=oscillatorEnergy Ω z ↔
    Ω*(z.1+h*z.2)=z.2 ∨ Ω*(z.1+h*z.2)=-z.2) ∧
  (∃ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z)
```
### 实际依赖 MD.Ch03.oscillatorAdjointEuler
```lean
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```
### 实际依赖 MolecularDynamics.Chapter03Review.oscillatorEnergy
```lean
def oscillatorEnergy (Ω : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+Ω^2*z.1^2)/2
```

## 原文JSON
```json
{
  "source_id": "MD-3.1-FormalHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "Now consider the more general Hamiltonian setting. Let $\\mathcal G_h$ be a $r$th order symplectic integrator, $r\\ge1$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $\\widetilde H_h$. If the method order is $r$, we may expect this Hamiltonian to be a $\\mathcal O(h^r)$ approximation of $H$, thus we posit an expansion of the form\n\\[\\widetilde H_h=H+h^rH^{(r)}+h^{r+1}H^{(r+1)}+\\cdots\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$r\\ge1$；$H^{(j)}$为待确定光滑系数函数；h为形式变量而不是级数收敛参数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01显式1≤r，排除r=0遗漏Hr0的错义；仍是真实逐系数形式级数，不声称无限收敛或实际流嵌入。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "ca771d4563a622a4c41f1add5b9cc9d9029446d7e8bec19a53618f87e570a69b",
      "after_sha256": "64e44a52a3f4c2dadfda13578b39209fb04146a64084673d21e2ad6c1ea470d0",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "fa7d079b49802d64f1efbc27c6b0a90cbbf1090b9fc48cc0576829b45ebf4aa1",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch03.formalHamiltonian
```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```

## 原文JSON
```json
{
  "source_id": "MD-3.1-FormalHamiltonianField",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "To determine the terms $H^{(r)},H^{(r+1)},\\ldots$, we write the differential equations on $\\widetilde H_h$:\n\\[\\dot{\\boldsymbol z}=J\\nabla H+h^rJ\\nabla H^{(r)}+h^{r+1}J\\nabla H^{(r+1)}+\\cdots\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The solution of this system can be expanded in powers of $h$ and equated term-by-term with the expansion of $\\mathcal G_h$ in powers of $h$. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.",
  "context_notation": [
    "$r\\ge1$；形式Hamiltonian见同页上段；每个系数取真实$J\\nabla H^{(j)}$，不把无穷级数当收敛ODE。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalHamiltonianField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01显式1≤r及H和全部Hj全域C∞，保证真实Fréchet梯度；原平滑逐阶形式展开资格，不预置匹配结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "499fdc69f73f2adcbb1551a9b6790607f6bc23e0023102940c11e0dc45a5693e",
      "after_sha256": "11c21a46ebecac5db66cef3ba4755b7cce8daf2c183dcd6a627542af0a315c0b",
      "changed_fields": [
        "statement_latex",
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "fa7d079b49802d64f1efbc27c6b0a90cbbf1090b9fc48cc0576829b45ebf4aa1",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (_hH : ContDiff ℝ ∞ H) (_hHj : ∀ j, ContDiff ℝ ∞ (Hj j))
    (z : SymplecticCoordinates n) (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
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
### 实际依赖 MD.Ch03.formalHamiltonianField
```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (_hH : ContDiff ℝ ∞ H) (_hHj : ∀ j, ContDiff ℝ ∞ (Hj j))
    (z : SymplecticCoordinates n) (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
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
