# EAUDIT10：第3章§3.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncatedHamiltonian",
  "kind": "definition",
  "label": "(3.11)",
  "section": "3.4",
  "printed_page": "114",
  "pdf_page": "136",
  "statement_latex": "Define\n\\[\\bar H_k\\stackrel{\\mathrm{def}}=H+h^rH_r+h^{r+1}H_{r+1}+\\cdots+h^kH_k.\\tag{3.11}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文(3.10)为形式H̃_h=H+h^rH_r+h^{r+1}H_{r+1}+⋯；(3.11)是实际有限函数，不需无限级数收敛；r≤k。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.676992",
      "before_sha256": "ac4cc14d0f3a7c31bf0608816c81e86092d62a37f6dd5edd0524a4444420d804",
      "after_sha256": "62b57599139fffe1e32197b160f02d47d03aa2c17c7f429a489867e2e80f7244",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```
### 实际依赖 MD.Ch03.truncatedHamiltonian
```lean
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncationSmooth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "114",
  "pdf_page": "136",
  "statement_latex": "Suppose the Hamiltonian $H$ and modified Hamiltonian $\\bar H_k$ are smooth functions globally defined on a convex, compact subset $\\mathcal B$ of $\\mathbb R^{2N_c}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "旧CH03-070是(3.11)有限函数光滑性的证明辅助；实际 finite sum 不假设和已光滑。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncationSmooth",
  "reusable_proofs": [
    "MolecularDynamics.contDiffOn_textbookTruncatedHamiltonian"
  ],
  "extra_assumptions": [
    "各系数在开放环境D为C¹；这里只证明所需C¹子结论，原文smooth假设本身不作为新断言。",
    "[EXTRA] 光滑假设与结论均提升C∞，覆盖原文光滑截断；原正式有限和定理可按阶数参数实例化，保留原证明小修。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "c5968caaa61cbd3da857e25e2571167bbdce6eaea4c2f048e10380aa58df121e",
      "after_sha256": "e0c016dbc982bf2d223688830463850e8b4b6301c53c860e92b480e848983c94",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT10_PROOF_REPAIR",
      "reason": "TruncationSmooth: existing lemma fixes C1; one failed instantiation, C∞ left sorry; old C1 proof retained"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem truncationSmooth (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ ⊤ H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ ⊤ (Hj j) D) :
    ContDiffOn ℝ ⊤ (textbookTruncatedHamiltonian H Hj r k h) D := by
  sorry

theorem truncationSmooth_C1 (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ContDiffOn ℝ 1 (textbookTruncatedHamiltonian H Hj r k h) D := by
  apply MolecularDynamics.contDiffOn_textbookTruncatedHamiltonian <;> assumption
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-Thm3.1",
  "kind": "theorem",
  "label": "Theorem 3.1",
  "section": "3.4",
  "printed_page": "114–116",
  "pdf_page": "136–138",
  "statement_latex": "Theorem 3.1. Suppose the Hamiltonian $H$ and modified Hamiltonian $\\bar H_k$ are smooth functions globally defined on a convex, compact subset $\\mathcal B$ of $\\mathbb R^{2N_c}$ and suppose that the exact solution and numerical approximations (for $h$ sufficiently small) are confined to $\\mathcal B$. Then, we have asymptotically for $h\\to0$ that\n\\[H(\\boldsymbol z_n)=H(\\boldsymbol z_0)+O(h^r),\\]\nfor $n=0,1,\\ldots,\\nu$ where $\\tau=\\nu h=O(h^{-k+r})$.",
  "proof_latex": "Proof First observe that due to smoothness and the assumptions on $\\mathcal B$, we have a global Lipschitz constant\n\\[|H(\\boldsymbol u)-H(\\boldsymbol v)|\\le L\\|\\boldsymbol u-\\boldsymbol v\\|\\]\nfor all $\\boldsymbol u,\\boldsymbol v\\in\\mathcal B$.\nDenote by $\\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\\bar H_k$,\n\\[\\mathcal F_h^{(k)}\\stackrel{\\mathrm{def}}=\\exp(h\\mathcal L_{\\bar H_k}).\\]\nBy construction, we have\n\\[\\boldsymbol z_{n+1}=\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n\\]\nwhere $\\|\\boldsymbol\\eta_n\\|\\le Ch^{k+1}$.\nSince $\\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have\n\\[\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))=\\widetilde H_k(\\boldsymbol z_n).\\]\nNow\n\\[\\begin{aligned}\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\boldsymbol z_{n+1})-\\bar H_k(\\boldsymbol z_n)\\\\\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))\\\\\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n)-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)).\\end{aligned}\\]\nHence\n\\[|\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)|\\le L\\sum_{n=0}^{\\nu-1}\\|\\boldsymbol\\eta_n\\|\\le L\\nu h^{k+1}.\\]\nWe have $\\nu=\\tau/h$, thus\n\\[|\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)|\\le L\\tau h^k.\\]\nNext observe that\n\\[H=\\bar H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\\cdots-h^kH_{(k)}=\\bar H_k+O(h^r).\\]\nTherefore\n\\[|H(\\boldsymbol z_\\nu)-H(\\boldsymbol z_0)|\\le L\\nu h^{k+1}+O(h^r),\\]\nso that, as long as $\\nu\\le C_2h^{-k+r-1}$, we have\n\\[|H(\\boldsymbol z_\\nu)-H(\\boldsymbol z_0)|\\le O(h^r).\\quad\\square\\]",
  "proof_note": "完整原书证明按PDF136–138跨页拼接；保留bar/tilde混用、L沿用及缺陷常数C省略，不静默修订原书。",
  "proof_discussion_latex": null,
  "context_notation": [
    "(3.11)来自前面的modified Hamiltonian构造；逐阶匹配不能作为“已经构造成功”的无证假设。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "给定H̃_k与存在一组构造系数的量词对应、截断轨道留B及所有n≤ν的长时间范围需审；任意n和T的量化包含原文每个n≤ν。"
    },
    {
      "code": "NEEDS_HUMAN",
      "detail": "证明先对H取L，后对H̃_k沿用L，并在Lνh^(k+1)中省略缺陷常数C；本地辅助桥接显式给实际截断族统一L和C，但原文不改。"
    }
  ],
  "lean_decl": "MD.Ch03.theorem31",
  "reusable_proofs": [],
  "extra_assumptions": [
    "smoothSymplecticData显式添加原方法r阶/近恒等辛/joint C∞、开放凸环境D、紧凸B⊆D、真实原流；r>0。",
    "本签名保留完整构造H_j与finiteMatching为结论，k≥r固定；数值迭代和截断ODE留B，常数可依赖k,T而非所有k统一。",
    "[EXTRA] 将构造与能量估计分开：Hj及实际有限匹配由FiniteMatchingConstruction/ArbitraryFiniteTruncation提供；本条不再要求从B每点出发的全部截断短轨迹留B，保留原数值轨道约束和正确长时间量词。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "a6a879c9ef297ec33385f17a496ebf8861d18a51802066f8ef8f84e8c424e4d3",
      "after_sha256": "29c7f4b1996157935493c5258bb576d6e694f5ab737b2c666cb6881be0562620",
      "changed_fields": [
        "statement_latex",
        "proof_latex",
        "proof_note"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem theorem31 (n r k : ℕ)
    (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (_hr : 0 < r) (_hrk : r ≤ k) (_hD : IsOpen D) (_hconvD : Convex ℝ D)
    (_hB : IsCompact B) (_hconvB : Convex ℝ B) (_hBD : B ⊆ D)
    (_hH : ContDiffOn ℝ ⊤ H D) (_hHj : ∀ j, ContDiffOn ℝ ⊤ (Hj j) D)
    (_hmatching : finiteMatching H Hj r k D B G) :
    ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
      (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
      (ν:ℝ)*h*h^(k-r) ≤ T →
      ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r := by
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
### 实际依赖 MolecularDynamics.Chapter03Review.finiteMatching
```lean
def finiteMatching {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ∃ δ > 0, ∃ A > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
    ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
      (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧ ‖G h z-Γ h z h‖ ≤ A*h^(k+1)
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
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
  "source_id": "MD-3.4-TruncatedFlow",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Denote by $\\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\\bar H_k$,\n\\[\\mathcal F_h^{(k)}\\stackrel{\\mathrm{def}}=\\exp(h\\mathcal L_{\\bar H_k}).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际γ(0)=z、γ满足J∇H̄_k的ODE，F_h^(k)(z)=γ(h)；本关系不把exp记号当解存在证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "61bc37dfdeb03870c8fc7f61ab9fc701efc3f54d9c44fba5ec5f3bb35643bae4",
      "after_sha256": "b360292fa328eec110a161a42f4fa24865bdd6c5b20559284362201a16111c8e",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
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
  "source_id": "MD-3.4-TruncatedConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Since $\\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have\n\\[\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))=\\widetilde H_k(\\boldsymbol z_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "K=H̃_k代入签名的H；本条对任意真实Hamiltonian曲线成立，不预设守恒结论。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedConservation",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonian_energy_const_on_Icc"
  ],
  "extra_assumptions": [
    "沿γ对K的可微性与真实ODE在闭区间明示，包含端点；构造γ属于另项。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "910d3c00c0119303a9656df473b9bbdf972e8f6f89527f2a5c62521f793aa8bf",
      "after_sha256": "349a8a6c3b7cf3802975d5e2a398d74bef960103ecf3cdb6becf1d3cb9534613",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem truncatedConservation (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-3.4-EnergyTelescoping",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Now\n\\[\\begin{aligned}\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\boldsymbol z_{n+1})-\\bar H_k(\\boldsymbol z_n)\\\\\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))\\\\\n&=\\sum_{n=0}^{\\nu-1}\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n)-\\bar H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "第一行是任意K的真实迭代有限和恒等式；第二、三行由同页独立TruncatedConservation与FiniteMatchingConstruction代入，并非本条额外假设能量守恒。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.energyTelescoping",
  "reusable_proofs": [
    "MolecularDynamics.oneStep_energy_telescoping"
  ],
  "extra_assumptions": [
    "[EXTRA] 保留已证首行望远镜恒等式；补给定守恒截断步F、真实差η=数值步−F的完整三行等式，不以待证能量差为前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "de20b055edb615e0a109296cd43aa689beb65c85269bb2f60b9283eee92db62d",
      "after_sha256": "ea1214c8822564237ccdc8bb6d84befa5db0cdaccaf54fe75f4d60fcaf4f64e0",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem energyTelescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀ := by
  apply MolecularDynamics.oneStep_energy_telescoping <;> assumption

theorem energyTelescoping_complete (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h : ℝ) (z₀ : E) (n : ℕ)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i)) :
    let z := oneStepIterate G h z₀
    let η := fun i ↦ z (i+1)-F (z i)
    K (z n)-K z₀ = ∑ i ∈ Finset.range n, (K (z (i+1))-K (z i)) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (z i))) =
      ∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i))) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i)))) =
      ∑ i ∈ Finset.range n, (K (F (z i)+η i)-K (F (z i))) := by
  sorry
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-UniformTruncatedLipschitz",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Hence\n\\[|\\bar H_k(\\boldsymbol z_\\nu)-\\bar H_k(\\boldsymbol z_0)|\\le L\\sum_{n=0}^{\\nu-1}\\|\\boldsymbol\\eta_n\\|\\le L\\nu h^{k+1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "此行所用实际H̃_k的统一L；原文先对H取L然后沿用到H̃_k，需要补本条严格辅助；整段漂移界见PhysicalEnergyDrift。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。",
    "原书未说明将缺陷常数C吸收到L，严格界应为LAνh^(k+1)，重选L须明确；不静默修改原文。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.uniformTruncatedLipschitz",
  "reusable_proofs": [
    "MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz"
  ],
  "extra_assumptions": [
    "开放D、紧凸B⊆D及H和有限H_j在D C¹；0≤h≤1；L由有限系数导数界推出。",
    "[EXTRA] 保留统一截断Lipschitz定理，补原完整能量差≤LΣ‖η‖≤LAνh^(k+1)链；A为原文缺陷常数重命名，F为所给守恒截断一步。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "63854e9ea6b83ac0cb9b96cbacde956d45e2f08d89c8a80700feeec4eac73719",
      "after_sha256": "d28ff4e99d21bee1e44c341cacc438d81dc369254daa45acfa0d683728ee9614",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem uniformTruncatedLipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖ := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz <;> assumption

theorem uniformTruncatedLipschitz_chain (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h L A : ℝ) (k n : ℕ) (z₀ : E)
    (_hh : 0 ≤ h) (_hL : 0 ≤ L) (_hA : 0 ≤ A)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i))
    (_hlip : ∀ i < n,
      |K (oneStepIterate G h z₀ (i+1))-K (F (oneStepIterate G h z₀ i))| ≤
        L*‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖)
    (_hdefect : ∀ i < n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ≤ A*h^(k+1)) :
    |K (oneStepIterate G h z₀ n)-K z₀| ≤
      L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ∧
    (L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖) ≤
      L*A*(n:ℝ)*h^(k+1) := by
  sorry
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

## 原文JSON
```json
{
  "source_id": "MD-3.4-TruncationRemainder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Next observe that\n\\[H=\\bar H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\\cdots-h^kH_{(k)}=\\bar H_k+O(h^r).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定r,k；实际有限式(3.11)，非无穷级数；绝对值即ℝ范数。",
    "原书(3.11)用bar H_k表示有限截断；PDF137局部与tilde H_k混用，疑为排版/记号疑误，需明确按同一截断函数解释，保留原印记号。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncationRemainder",
  "reusable_proofs": [
    "MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder"
  ],
  "extra_assumptions": [
    "各有限系数在紧B连续；0≤h≤1；统一正C由紧性推出，未供应所需余项界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:19:30.682664",
      "before_sha256": "7eaf7fad1a97fd4946b4e6c23d6291c90cbd917439269f43fa35be083f89919d",
      "after_sha256": "77a8ad31e894ddfc8294ef150eef0226e49503b43775bbdb3a92a0a90cd2eb97",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem truncationRemainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder <;> assumption
```
### 实际依赖 MolecularDynamics.textbookTruncatedHamiltonian
```lean
noncomputable def textbookTruncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```
