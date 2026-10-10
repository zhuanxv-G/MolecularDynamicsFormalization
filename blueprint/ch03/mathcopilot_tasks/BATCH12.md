# BATCH12 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.4-ModifiedField
```json
{
  "source_id": "MD-3.4-ModifiedField",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "113",
  "pdf_page": "135",
  "statement_latex": "Assume a smooth differential equation system\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=f(\\boldsymbol z)\\]\nwith flow map $\\mathcal F_t$, and a one-step method $\\mathcal G_h$. We obtain, typically by matching of terms from Taylor expansion, a “modified differential equation” as a series expansion\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=\\widetilde f_h(\\boldsymbol z)=f(\\boldsymbol z)+h^rf_r(\\boldsymbol z)+h^{r+1}f_{r+1}(\\boldsymbol z)+\\cdots,\\]\nwhere $r$ is the classical order of accuracy of the method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "r≥1；h为形式变量、f_j为系数向量场；实际匹配存在性单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def formalField {n : ℕ} (f : Q n → Q n) (fj : ℕ → Q n → Q n) (r : ℕ)
    (z : Q n) (i : Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then f z i else if r ≤ j then fj j z i else 0)
```

### MD-3.4-LeadingModifiedField
```json
{
  "source_id": "MD-3.4-LeadingModifiedField",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "113",
  "pdf_page": "135",
  "statement_latex": "In fact, it is straightforward to show that if numerical method satisfies\n\\[\\mathcal G_h(\\boldsymbol z)-\\mathcal F_h(\\boldsymbol z)=h^{r+1}\\Gamma_{r+1}(\\boldsymbol z)+O(h^{r+2}),\\]\ni.e. $h^{r+1}\\Gamma_{r+1}$ is the leading term in the local error expansion, then we have\n\\[f_r(\\boldsymbol z)=\\Gamma_{r+1}(\\boldsymbol z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal F$为原实际流；极限h^−(r+1)(G_h−F_h)给原文Γ系数，不把modified flow的匹配作前提。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.leadingModifiedField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "r>0、全域C∞的f及(h,z)↦G_h、开放D与紧B及真实双向局部流；局部r阶条件。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem leadingModifiedField :
  ∀ (n r : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    0 < r → ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η → localOrder G Φ B r →
    ∃ fr : Q n → Q n, ContDiffOn ℝ ⊤ fr D ∧
      (∀ z ∈ B, Tendsto (fun h => (h^(r+1))⁻¹ • (G h z-Φ h z)) (𝓝[≠] 0) (𝓝 (fr z))) ∧
      ∃ Γ : ℝ → Q n → ℝ → Q n, ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z ∈ B,
        Γ h z 0=z ∧ solution (fun x => f x+h^r • fr x) (Γ h z) 0 h ∧
          ‖G h z-Γ h z h‖ ≤ C*h^(r+2)
```

### MD-3.4-TruncatedHamiltonian
```json
{
  "source_id": "MD-3.4-TruncatedHamiltonian",
  "kind": "definition",
  "label": "(3.11)",
  "section": "3.4",
  "printed_page": "114",
  "pdf_page": "136",
  "statement_latex": "Define\n\\[\\widetilde H_k\\stackrel{\\mathrm{def}}=H+h^rH_r+h^{r+1}H_{r+1}+\\cdots+h^kH_k.\\tag{3.11}\\]",
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
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

### MD-3.4-TruncationSmooth
```json
{
  "source_id": "MD-3.4-TruncationSmooth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "114",
  "pdf_page": "136",
  "statement_latex": "Suppose the Hamiltonian $H$ and modified Hamiltonian $\\widetilde H_k$ are smooth functions globally defined on a convex, compact subset $\\mathcal B$ of $\\mathbb R^{2N_c}$.",
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
    "各系数在开放环境D为C¹；这里只证明所需C¹子结论，原文smooth假设本身不作为新断言。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem truncationSmooth (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ContDiffOn ℝ 1 (textbookTruncatedHamiltonian H Hj r k h) D
```

### MD-3.4-Thm3.1
```json
{
  "source_id": "MD-3.4-Thm3.1",
  "kind": "theorem",
  "label": "Theorem 3.1",
  "section": "3.4",
  "printed_page": "114–116",
  "pdf_page": "136–138",
  "statement_latex": "Theorem 3.1. Suppose the Hamiltonian $H$ and modified Hamiltonian $\\widetilde H_k$ are smooth functions globally defined on a convex, compact subset $\\mathcal B$ of $\\mathbb R^{2N_c}$ and suppose that the exact solution and numerical approximations (for $h$ sufficiently small) are confined to $\\mathcal B$. Then, we have asymptotically for $h\\to0$ that\n\\[H(\\boldsymbol z_n)=H(\\boldsymbol z_0)+O(h^r),\\]\nfor $n=0,1,\\ldots,\\nu$ where $\\tau=\\nu h=O(h^{-k+r})$.",
  "proof_latex": "Proof First observe that due to smoothness and the assumptions on $\\mathcal B$, we have a global Lipschitz constant\n\\[|H(\\boldsymbol u)-H(\\boldsymbol v)|\\le L\\|\\boldsymbol u-\\boldsymbol v\\|\\]\nfor all $\\boldsymbol u,\\boldsymbol v\\in\\mathcal B$.\nDenote by $\\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\\widetilde H_k$,\n\\[\\mathcal F_h^{(k)}\\stackrel{\\mathrm{def}}=\\exp(h\\mathcal L_{\\widetilde H_k}).\\]\nBy construction, we have\n\\[\\boldsymbol z_{n+1}=\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n\\]\nwhere $\\|\\boldsymbol\\eta_n\\|\\le Ch^{k+1}$.\nSince $\\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have\n\\[\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))=\\widetilde H_k(\\boldsymbol z_n).\\]\nNow\n\\[\\begin{aligned}\\widetilde H_k(\\boldsymbol z_\\nu)-\\widetilde H_k(\\boldsymbol z_0)\n&=\\sum_{n=0}^{\\nu-1}\\widetilde H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\boldsymbol z_n)\\\\\n&=\\sum_{n=0}^{\\nu-1}\\widetilde H_k(\\boldsymbol z_{n+1})-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n))\\\\\n&=\\sum_{n=0}^{\\nu-1}\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n)-\\widetilde H_k(\\mathcal F_h^{(k)}(\\boldsymbol z_n)).\\end{aligned}\\]\nHence\n\\[|\\widetilde H_k(\\boldsymbol z_\\nu)-\\widetilde H_k(\\boldsymbol z_0)|\\le L\\sum_{n=0}^{\\nu-1}\\|\\boldsymbol\\eta_n\\|\\le L\\nu h^{k+1}.\\]\nWe have $\\nu=\\tau/h$, thus\n\\[|\\widetilde H_k(\\boldsymbol z_\\nu)-\\widetilde H_k(\\boldsymbol z_0)|\\le L\\tau h^k.\\]\nNext observe that\n\\[H=\\widetilde H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\\cdots-h^kH_{(k)}=\\widetilde H_k+O(h^r).\\]\nTherefore\n\\[|H(\\boldsymbol z_\\nu)-H(\\boldsymbol z_0)|\\le L\\nu h^{k+1}+O(h^r),\\]\nso that, as long as $\\nu\\le C_2h^{-k+r-1}$, we have\n\\[|H(\\boldsymbol z_\\nu)-H(\\boldsymbol z_0)|\\le O(h^r).\\quad\\square\\]",
  "proof_note": "完整原书证明按PDF136–138跨页拼接；保留原文L及省略C的展示式，不静默修订其常数。",
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
    "本签名保留完整构造H_j与finiteMatching为结论，k≥r固定；数值迭代和截断ODE留B，常数可依赖k,T而非所有k统一。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem theorem31 :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
    ∀ k ≥ r, finiteMatching H Hj r k D B G ∧
      ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
        (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
        (∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
          ∀ z ∈ B, truncatedFlow H Hj r k h z (Γ h z) ∧
            (∀ t ∈ Icc 0 h, Γ h z t ∈ B)) →
        (ν:ℝ)*h*h^(k-r) ≤ T → ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r
```

### MD-3.4-CompactLipschitz
```json
{
  "source_id": "MD-3.4-CompactLipschitz",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "114",
  "pdf_page": "136",
  "statement_latex": "Proof First observe that due to smoothness and the assumptions on $\\mathcal B$, we have a global Lipschitz constant\n\\[|H(\\boldsymbol u)-H(\\boldsymbol v)|\\le L\\|\\boldsymbol u-\\boldsymbol v\\|\\]\nfor all $\\boldsymbol u,\\boldsymbol v\\in\\mathcal B$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "“global”指固定紧凸B上统一，不是整个无限相空间；H光滑原文资格。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.compactLipschitz",
  "reusable_proofs": [
    "MolecularDynamics.exists_compact_C1_lipschitz_constant"
  ],
  "extra_assumptions": [
    "显式开放环境D及B⊆D、H在D为C¹；L由真实导数紧集界推出，未作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem compactLipschitz (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (H : E → ℝ) (hH : ContDiffOn ℝ 1 H D) :
    ∃ L : ℝ, 0 < L ∧ ∀ u ∈ B, ∀ v ∈ B, ‖H v - H u‖ ≤ L * ‖v - u‖
```

### MD-3.4-TruncatedFlow
```json
{
  "source_id": "MD-3.4-TruncatedFlow",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "Denote by $\\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\\widetilde H_k$,\n\\[\\mathcal F_h^{(k)}\\stackrel{\\mathrm{def}}=\\exp(h\\mathcal L_{\\widetilde H_k}).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际γ(0)=z、γ满足J∇H̃_k的ODE，F_h^(k)(z)=γ(h)；本关系不把exp记号当解存在证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.truncatedFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

### MD-3.4-FiniteMatchingConstruction
```json
{
  "source_id": "MD-3.4-FiniteMatchingConstruction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "115",
  "pdf_page": "137",
  "statement_latex": "By construction, we have\n\\[\\boldsymbol z_{n+1}=\\mathcal F_h^{(k)}(\\boldsymbol z_n)+\\boldsymbol\\eta_n\\]\nwhere $\\|\\boldsymbol\\eta_n\\|\\le Ch^{k+1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实数值一步与截断Hamiltonian实际一步的差；construction完整存在性同MD-3-ModifiedConstruction，旧CH03-074以此处原文独立映射。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.finiteMatchingConstruction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "smoothSymplecticData与原书构造上下文相同；保留任意k的真实finiteMatching为结论，不当作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem finiteMatchingConstruction :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ⊤ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G
```

