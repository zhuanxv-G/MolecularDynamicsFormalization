# EAUDIT50：第3章§3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.2-ObservableDerivative",
  "kind": "unnumbered_claim",
  "label": "(3.2)",
  "section": "3.2",
  "printed_page": "100–101",
  "pdf_page": "122–123",
  "statement_latex": "At any point $\\boldsymbol z=\\boldsymbol\\zeta$ in phase space assume that there is a unique solution $\\boldsymbol z(t,\\boldsymbol\\zeta)$ such that $\\dot{\\boldsymbol z}(t)=f(\\boldsymbol z(t))$, $\\boldsymbol z(0)=\\boldsymbol\\zeta$ that is globally defined for all $t$. Now differentiate $\\hat\\phi(t)=\\phi(\\boldsymbol z(t))$ with respect to time, using the chain rule, to see how $\\phi(\\boldsymbol z(t))$ is changing as $t$ is varied:\n\\[\\left.\\frac{\\mathrm d}{\\mathrm dt}\\hat\\phi\\right|_{t=0}=\\left[\\sum_{i=1}^m\\frac{\\partial\\phi}{\\partial z_i}\\dot z_i\\right]_{\\boldsymbol z=\\boldsymbol\\zeta}=\\nabla\\phi(\\boldsymbol\\zeta)\\cdot f(\\boldsymbol\\zeta).\\]\nand note that the origin of time is irrelevant, then the equation for the evolution of $\\phi$ could be written\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\hat\\phi=(\\mathcal L_f\\phi)(\\boldsymbol z).\\tag{3.2}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\gamma$为原文给定实际解，$\\gamma(0)=\\boldsymbol\\zeta$；原文区分相空间函数$\\phi(\\boldsymbol z)$与沿解的时间函数$\\hat\\phi(t)=\\phi(\\gamma(t))$。$\\mathcal L_f$见p.100/PDF122；$\\phi$的smooth资格来自§3.2首句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.observableDerivative",
  "reusable_proofs": [
    "MolecularDynamics.hasDerivAt_textbookLieDerivative"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:00:38.885629",
      "before_sha256": "9263b3d3713575ec5f2b6cd1ac08189cd7a7a470423bdbd7e38c19f10f2d2a2a",
      "after_sha256": "0528eed059b961e9959be751cbe512695df5867e114552b13ff63cd704e7286a",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem observableDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption
```
### 实际依赖 MD.Ch03.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonBracket",
  "kind": "definition",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Another common notation for performing computations involving Hamiltonian systems is the Poisson bracket which is defined for two smooth scalar-valued functions $g_1$ and $g_2$ of the phase variables $(\\boldsymbol q,\\boldsymbol p)$ of a Hamiltonian system in $\\mathbb R^m$ by\n\\[\\{g_1,g_2\\}=\\sum_{i=1}^{N_c}\\left(\\frac{\\partial g_1}{\\partial q_i}\\frac{\\partial g_2}{\\partial p_i}-\\frac{\\partial g_2}{\\partial q_i}\\frac{\\partial g_1}{\\partial p_i}\\right)=\\nabla g_1^T J\\nabla g_2,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$J=\\begin{bmatrix}0&I\\\\-I&0\\end{bmatrix}$；原文$I$为$N_c\\times N_c$单位阵，$N_c$为配置坐标数；本文Lean的n/Nc对应$N_c$，环境相空间维数为$2N_c$，$\\mathrm{Sum.inl}$标记位置坐标、$\\mathrm{Sum.inr}$标记动量坐标。$g_1,g_2$为原文规定的smooth scalar-valued函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.textbookPoissonBracket",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:00:38.885629",
      "before_sha256": "fd076d744c50da6b1465325ee8568f0a20b2ccfb2467c73058adcc6a2563c44c",
      "after_sha256": "de78b8d813c4f2d045ce8adf0fa049f6724b55c612bf7841f733588d7f303e49",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
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

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "\\[\\{g_1,g_2\\}=\\sum_{i=1}^{N_c}\\left(\\frac{\\partial g_1}{\\partial q_i}\\frac{\\partial g_2}{\\partial p_i}-\\frac{\\partial g_2}{\\partial q_i}\\frac{\\partial g_1}{\\partial p_i}\\right)=\\nabla g_1^T J\\nabla g_2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$N_c$为构型坐标数；$g_1,g_2$为同页smooth scalar-valued函数；$J=\\begin{bmatrix}0&I\\\\-I&0\\end{bmatrix}$，$I$为$N_c\\times N_c$单位矩阵；坐标偏导在Lean中解释为Fréchet导数作用于对应单位基向量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonCoordinates",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_coordinates"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:00:38.885629",
      "before_sha256": "b4751a08838295fb2f626b564fe0c8e2acbbc814b8c18a747c9373b8ca4c3107",
      "after_sha256": "dce1f98c9887952245426d64bafdb6f5e0c8e1b51ab259ee9a8184eff3bfc7bd",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem poissonCoordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1)) := by
  apply MolecularDynamics.textbookPoissonBracket_coordinates <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonBilinearity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):\nBilinearity $\\{g_1,\\alpha g_2+\\beta g_3\\}=\\alpha\\{g_1,g_2\\}+\\beta\\{g_1,g_3\\}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables).",
  "context_notation": [
    "$\\alpha,\\beta\\in\\mathbb R$；Poisson定义见同页；第一变量线性由下一条反对称性推出。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonBilinearity",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_linear_right",
    "MolecularDynamics.textbookPoissonBracket_linear_left"
  ],
  "extra_assumptions": [
    "原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:00:38.885629",
      "before_sha256": "732dfa03e2fb1942ccaf468c0baae3d57468d3bb29e5678cb3d17320bf84ea91",
      "after_sha256": "22d12b4d82eee7935dd08d5e22ff7ebb17cdf2edd68a717bc3df3545d2660d1d",
      "changed_fields": [
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z) := by
  exact ⟨MolecularDynamics.textbookPoissonBracket_linear_right F G H α β z hG hH,
    MolecularDynamics.textbookPoissonBracket_linear_left F H G α β z hF hG⟩
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

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonSkew",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Skew symmetry $\\{g_1,g_2\\}=-\\{g_2,g_1\\}$",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables).",
  "context_notation": [
    "$J$为同页规范辛矩阵；不要求J另有任意自定义参数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonSkew",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_skew"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:00:38.885629",
      "before_sha256": "e9b9960d13bbebbe33bc681fcab620c3b02637f083f082253e1b415eba810d7b",
      "after_sha256": "89d10d08ee38671bde7c43194f251db0a5792f5582fba3fc8cfcdaaebedf5d5c",
      "changed_fields": [
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem poissonSkew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z := by
  apply MolecularDynamics.textbookPoissonBracket_skew <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonSelf",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "and this implies $\\{g_1,g_1\\}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables).",
  "context_notation": [
    "由同页Skew symmetry；实数域特征不为2。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonSelf",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_self"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:00:38.885629",
      "before_sha256": "a0f35ae7a7075fd6ab1ab5c9636c5a252b4e1decc0f59f5dde4895692763292f",
      "after_sha256": "6a5a4acb138560d45b910ed500ca6295b3e276a9281becefeec0a5c5136caed5",
      "changed_fields": [
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem poissonSelf (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_self <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-3.2-PoissonJacobi",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Jacobi identity $\\{g_1,\\{g_2,g_3\\}\\}+\\{g_3,\\{g_1,g_2\\}\\}+\\{g_2,\\{g_3,g_1\\}\\}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables).",
  "context_notation": [
    "同页三个smooth scalar-valued函数；非任意未微分函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.poissonJacobi",
  "reusable_proofs": [
    "MolecularDynamics.textbookPoissonBracket_jacobi"
  ],
  "extra_assumptions": [
    "显式各函数在z为C²；真实二阶导数对称性支持Jacobi。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:02:37.900044",
      "before_sha256": "70289abb3d895c372ff744518fe38678ee326dd4396b2647b1685a0edcfbf2c9",
      "after_sha256": "996f564fa082861f17c3a50e458a2297cfea38032d62143405ab989d207ddf69",
      "changed_fields": [
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_jacobi <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-3.2-HamiltonianLie",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:\n\\[\\mathcal L_{J\\nabla H}F\\equiv \\{F,H\\}.\\]\nFor a Hamiltonian flow, we typically simplify notation by writing $\\mathcal L_H$ in place of $\\mathcal L_{J\\nabla H}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal L_H=\\mathcal L_{J\\nabla H}$仅记号，旧CH03-025合并于此；实际hamiltonianLie定义亦为此。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hamiltonianLie_eq_poisson",
  "reusable_proofs": [
    "MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:02:37.900044",
      "before_sha256": "8d24aa7536a3f2c36fde213183769450fbd9dc5f6f9dbbbddc3526d7aa0f1f5c",
      "after_sha256": "3ddcce4fe1e389b22c6e22054f21996ad44b2ab89e7ff924c3a9be78bfdeaec9",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H := by
  apply MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson <;> assumption
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
### 实际依赖 MD.Ch03.textbookLieDerivative
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```
### 实际依赖 MD.Ch03.textbookPoissonBracket
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```
