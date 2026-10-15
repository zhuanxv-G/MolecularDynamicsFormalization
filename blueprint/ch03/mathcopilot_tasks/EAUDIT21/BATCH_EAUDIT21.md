# EAUDIT21：第3章§3.4网站修复复审

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
    "系数在D上C∞，主结论C∞暂sorry；原C¹结论的既有证明作为独立辅助重查。",
    "[EXTRA] C∞主结论暂sorry，原C¹辅助已证；纠正旧元数据对证明能力的过度描述。"
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
    },
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:39:27.285258",
      "before_sha256": "e0c016dbc982bf2d223688830463850e8b4b6301c53c860e92b480e848983c94",
      "after_sha256": "738688aff517f5e4a6051c65f4e4dc7de660689a0f2d87fbd1eec3f3f06a3564",
      "changed_fields": [
        "extra_assumptions"
      ],
      "annotation_corrections": {
        "extra_assumptions": {
          "before": [
            "各系数在开放环境D为C¹；这里只证明所需C¹子结论，原文smooth假设本身不作为新断言。",
            "[EXTRA] 光滑假设与结论均提升C∞，覆盖原文光滑截断；原正式有限和定理可按阶数参数实例化，保留原证明小修。"
          ],
          "after": [
            "系数在D上C∞，主结论C∞暂sorry；原C¹结论的既有证明作为独立辅助重查。",
            "[EXTRA] C∞主结论暂sorry，原C¹辅助已证；纠正旧元数据对证明能力的过度描述。"
          ]
        }
      },
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
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
    "(3.11)来自前面的modified Hamiltonian构造；逐阶匹配不能作为“已经构造成功”的无证假设。",
    "原证明中的统一L及缺陷常数由UniformTruncatedLipschitz/PhysicalEnergyDrift显式列出；旧疑点注释保留在repair_log，当前定理不要求全部截断轨迹留B。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.theorem31",
  "reusable_proofs": [],
  "extra_assumptions": [
    "r>0,k≥r；开放凸D、紧凸B⊆D，H和Hj在D上C∞；给定相邻构造条目产出的真实有限匹配。",
    "[EXTRA] 本条是给定已构造Hj及finiteMatching后的能量定理；系数存在性与匹配构造明确由FiniteMatchingConstruction及ArbitraryFiniteTruncation承担，数值轨道约束不变。"
  ],
  "statement_scope": "Theorem3.1中给定有限截断匹配后的能量估计；构造Hj及全截断存在性由MD-3.4-FiniteMatchingConstruction、MD-3.4-ArbitraryFiniteTruncation覆盖，原文保留。",
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
    },
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:39:27.285258",
      "before_sha256": "29c7f4b1996157935493c5258bb576d6e694f5ab737b2c666cb6881be0562620",
      "after_sha256": "e6d0d5ef09b648d668973450949dac8fdaeaaa14492fc428795e951903b162b1",
      "changed_fields": [
        "extra_assumptions",
        "issues",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {
        "extra_assumptions": {
          "before": [
            "smoothSymplecticData显式添加原方法r阶/近恒等辛/joint C∞、开放凸环境D、紧凸B⊆D、真实原流；r>0。",
            "本签名保留完整构造H_j与finiteMatching为结论，k≥r固定；数值迭代和截断ODE留B，常数可依赖k,T而非所有k统一。",
            "[EXTRA] 将构造与能量估计分开：Hj及实际有限匹配由FiniteMatchingConstruction/ArbitraryFiniteTruncation提供；本条不再要求从B每点出发的全部截断短轨迹留B，保留原数值轨道约束和正确长时间量词。"
          ],
          "after": [
            "r>0,k≥r；开放凸D、紧凸B⊆D，H和Hj在D上C∞；给定相邻构造条目产出的真实有限匹配。",
            "[EXTRA] 本条是给定已构造Hj及finiteMatching后的能量定理；系数存在性与匹配构造明确由FiniteMatchingConstruction及ArbitraryFiniteTruncation承担，数值轨道约束不变。"
          ]
        },
        "issues": {
          "before": [
            {
              "code": "NEEDS_HUMAN",
              "detail": "给定H̃_k与存在一组构造系数的量词对应、截断轨道留B及所有n≤ν的长时间范围需审；任意n和T的量化包含原文每个n≤ν。"
            },
            {
              "code": "NEEDS_HUMAN",
              "detail": "证明先对H取L，后对H̃_k沿用L，并在Lνh^(k+1)中省略缺陷常数C；本地辅助桥接显式给实际截断族统一L和C，但原文不改。"
            }
          ],
          "after": []
        },
        "context_notation": {
          "before": [
            "(3.11)来自前面的modified Hamiltonian构造；逐阶匹配不能作为“已经构造成功”的无证假设。"
          ],
          "after": [
            "(3.11)来自前面的modified Hamiltonian构造；逐阶匹配不能作为“已经构造成功”的无证假设。",
            "原证明中的统一L及缺陷常数由UniformTruncatedLipschitz/PhysicalEnergyDrift显式列出；旧疑点注释保留在repair_log，当前定理不要求全部截断轨迹留B。"
          ]
        }
      },
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
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
