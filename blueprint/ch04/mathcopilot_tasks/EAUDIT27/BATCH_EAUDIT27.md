# EAUDIT27：第4章§4.2.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-FastVerlet",
  "kind": "definition",
  "label": null,
  "section": "4.2.1",
  "printed_page": "145",
  "pdf_page": "167",
  "statement_latex": "Let $\\mathcal G_h^F$ denote the map associated to the Verlet method for the system without $U_S$, using a stepsize $h$:\n\\[\\mathcal G_h^F=\\mathrm e^{\\frac h2\\mathcal L_{U_F}}\\mathrm e^{h\\mathcal L_K}\\mathrm e^{\\frac h2\\mathcal L_{U_F}},\\]\nwhere $\\mathcal L_K$ is the Lie-derivative corresponding to the kinetic energy component of the Hamiltonian $(K=p^TM^{-1}p/2)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Lie指数按实际势kick与质量drift作用解释；复用第2章实际数学映射。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.fastVerlet",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "b650daedd4e8a64420815333f2ec08bd2cc004af0b0ee92eaa2407e77f4bc4df",
      "after_sha256": "78e3a52528abea0780653f3fe43744081c79023c26298cf734df932a11e2b113",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch04.fastVerlet
```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-RESPA",
  "kind": "definition",
  "label": "(4.2)",
  "section": "4.2.1",
  "printed_page": "145",
  "pdf_page": "167",
  "statement_latex": "Now consider the map constructed by taking $r$ steps using $\\mathcal G_{F,h/r}$ and composing this with kicks from the soft force:\n\\[\\mathcal G_h^{\\mathrm{MTS}}=\\mathrm e^{\\frac h2\\mathcal L_{U_S}}[\\mathcal G_{h/r}^F]^r\\mathrm e^{\\frac h2\\mathcal L_{U_S}}.\\]\nReversible RESPA Algorithm\n\\[P:=p-(h/2)\\nabla U_S(q),\\quad Q:=q;\\]\nRepeat $r$ times:\n\\[P:=P-(h/2)\\nabla U_F(Q)/r,\\quad Q:=Q+hM^{-1}P/r,\\quad P:=P-(h/2)\\nabla U_F(Q)/r;\\tag{4.2}\\]\n\\[P:=P-(h/2)\\nabla U_S(Q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.respa",
  "reusable_proofs": [],
  "extra_assumptions": [
    "r为正自然数，实际r次函数迭代；不把形式算子等式当实际ODE流。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "68eee220ede28012b4bf51e6ead5d6bf17c8665741e9410577b6d82ddbba7873",
      "after_sha256": "61724ed42dff3da9f32d92d453cb7e10ff520f064f4d4c92bfac3b372b40ad62",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastVerlet
```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  Chapter02Review.verlet m (fun q => -grad UF q) h
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.kick
```lean
def kick {n : ℕ} (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n := (z.1,z.2-h • grad U z.1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch04.fastVerlet
```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.kick
```lean
def kick {n : ℕ} (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n := (z.1,z.2-h • grad U z.1)
```
### 实际依赖 MD.Ch04.respa
```lean
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-SlowMatrix",
  "kind": "definition",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "with\n\\[S_h=\\begin{bmatrix}1&0\\\\-h&1\\end{bmatrix};\\qquad F_h=\\begin{bmatrix}\\cos(\\Omega h)&\\Omega^{-1}\\sin(\\Omega h)\\\\-\\Omega\\sin(\\Omega h)&\\cos(\\Omega h)\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "US(q)=q²/2的真实kick矩阵，质量1。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.slowMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 本条明确只承担S_h；同一展示中的F_h由MD-4.2.1-FastMatrix承担，原合引文字保留。"
  ],
  "statement_scope": "仅S_h定义；合引中的F_h由MD-4.2.1-FastMatrix承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "5d10e7c1c1ec99a25e3abe5885fbf510fcea9054fcc879d5cc88a5777ef553f2",
      "after_sha256": "2ee051eb7659df714893d3f590dbed3b529d219880d65e6d162eba6692c2d227",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-FastMatrix",
  "kind": "definition",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "with\n\\[S_h=\\begin{bmatrix}1&0\\\\-h&1\\end{bmatrix};\\qquad F_h=\\begin{bmatrix}\\cos(\\Omega h)&\\Omega^{-1}\\sin(\\Omega h)\\\\-\\Omega\\sin(\\Omega h)&\\cos(\\Omega h)\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.fastMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。",
    "[EXTRA] F_h使用原Ω≫1模型的非零频率域，防止除零总化；S_h由SlowMatrix承担，原展示不删。"
  ],
  "statement_scope": "仅非零频率模型中的F_h定义；S_h由MD-4.2.1-SlowMatrix承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "afc49ec7fdd8bb114672cf74875cd202f8d967da0073661c7d1b2c5304346f6b",
      "after_sha256": "4e49be059b0436f3b6e2877e3ba0ee81e01943e4a3c9ff7ab1cd1300c4ecded9",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ImpulseDet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "Both of these matrices have unit determinant for any $h$, so the product of the eigenvalues of $W_h$ is $1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "有限实矩阵行列式；复谱根乘积来自其特征多项式，不假设谱结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.impulseDet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。",
    "[EXTRA] 保留三项行列式证明；补复特征多项式的完整首一二次分解及两根乘积1，重根以两个因子计重，非任取两个单根。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "44eb50f944a538752edff6ad2d7119bebf669ef89fb8f1e5f31ccba4b5d14f68",
      "after_sha256": "e588ff57b7592980cc6becfac8c253992e2122844f8aaee720099dda7f8eacc1",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH04_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem impulseDet :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 ∧ (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 ∧ (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=1 := by
  intro Ω h hΩ
  simp only [MolecularDynamics.Chapter04Review.impulseMatrix, Matrix.det_mul]
  have hs : (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hs2 : (MolecularDynamics.Chapter04Review.slowMatrix (h/2)).det=1 := by
    simp [MolecularDynamics.Chapter04Review.slowMatrix, Matrix.det_fin_two]
  have hf : (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 := by
    simp [MolecularDynamics.Chapter04Review.fastMatrix, Matrix.det_fin_two]
    field_simp
    nlinarith [Real.sin_sq_add_cos_sq (Ω*h)]
  exact ⟨hs,hf,by rw [hs2,hf]; norm_num⟩

theorem impulseDet_eigenvalueProduct (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ, a*b=1 ∧ ∀ ζ : ℂ,
      (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
          (ζ-a)*(ζ-b) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ImpulseTrace",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "On the other hand, a short calculation shows that\n\\[\\lambda_1+\\lambda_2=\\operatorname{Tr}(W_h)=2\\cos(h\\Omega)-\\frac h\\Omega\\sin(h\\Omega).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.168（印刷p.146）：状态列向量为(q,p)ᵀ；Ω≫1是模型背景。此处代数结论适用于任意Ω>0，不需要定量大频率门槛。",
    "S_h=[[1,0],[-h,1]]；F_h=[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]；W_h=S_{h/2}F_hS_{h/2}，快子系统在内步趋零时采用精确流，不是一次Verlet更新。",
    "λ₁、λ₂是W_h的两个复特征根，按代数重数计；det(W_h)=1，μ(h)=Tr(W_h)=2cos(hΩ)−(h/Ω)sin(hΩ)。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.impulseTrace",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。",
    "[EXTRA] 保留trace计算，并用同一个完整二次分解绑定按代数重数的两个根及根和，不重复任取同一简单根。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "cf1f047392b7ba20eeef414c6bcd14b46509c99ebd7bf932e5d952f01070b1d3",
      "after_sha256": "155d1ecf82203360f6e2f6de6d2d1d568e35ea85bd45ba4e9c0b4c922861427f",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem impulseTrace :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) := by
  intro Ω h hΩ
  simp [MolecularDynamics.Chapter04Review.impulseMatrix, MolecularDynamics.Chapter04Review.slowMatrix,
    MolecularDynamics.Chapter04Review.fastMatrix, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two]
  rw [mul_comm h Ω]
  ring

theorem impulseTrace_eigenvalueSum (Ω h : ℝ) (_hΩ : Ω ≠ 0) :
    ∃ a b : ℂ,
      a+b=(2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω) : ℝ) ∧
      (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
        (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=(ζ-a)*(ζ-b)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ResonancePower",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "For example, at $h=\\pi/\\Omega$, we have\n\\[F_h=-I\\Rightarrow W_h=-S_{h/2}^2=-\\begin{bmatrix}1&0\\\\-h&1\\end{bmatrix},\\]\nso that\n\\[W_h^n=(-1)^n\\begin{bmatrix}1&0\\\\-nh&1\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.168（印刷p.146）：状态列向量为(q,p)ᵀ；Ω≫1是模型背景。此处代数结论适用于任意Ω>0，不需要定量大频率门槛。",
    "S_h=[[1,0],[-h,1]]；F_h=[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]；W_h=S_{h/2}F_hS_{h/2}，快子系统在内步趋零时采用精确流，不是一次Verlet更新。",
    "λ₁、λ₂是W_h的两个复特征根，按代数重数计；det(W_h)=1，μ(h)=Tr(W_h)=2cos(hΩ)−(h/Ω)sin(hΩ)。",
    "本条固定h=π/Ω，n为非负整数迭代次数；I为2×2单位矩阵。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonancePower",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0；所有自然数k，不止图中有限迭代。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT04_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:53:50.635472",
      "before_sha256": "ef8f2f36dc159ff851cec6c00d53ea582e0988f2fecc20097ea14b85b2f2565f",
      "after_sha256": "7b98a8d05e4aef0b61cb8238da272a3f5f0b9e0e3e8640ca8681b9fbd523c81d",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT04/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem resonancePower :
  ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1] := by
  intro Ω hΩ k
  have hne : Ω ≠ 0 := ne_of_gt hΩ
  have ha : Ω*(Real.pi/Ω)=Real.pi := by field_simp
  have hm : MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω)= -!![1,0; -(Real.pi/Ω),1] := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [MolecularDynamics.Chapter04Review.impulseMatrix,MolecularDynamics.Chapter04Review.slowMatrix,MolecularDynamics.Chapter04Review.fastMatrix,Matrix.mul_apply,Fin.sum_univ_two,ha] <;> ring
  induction k with
  | zero =>
    ext i j
    fin_cases i <;> fin_cases j <;> norm_num
  | succ k hk =>
    rw [pow_succ,hk,hm,pow_succ]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.mul_apply,Fin.sum_univ_two,Pi.smul_apply,smul_eq_mul,Nat.cast_add,Nat.cast_one] <;> ring
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ResonanceTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "We can see this by expanding $\\mu(h)=2\\cos(h\\Omega)-\\frac h\\Omega\\sin(h\\Omega)$ in a Taylor expansion around $h=\\pi/\\Omega$:\n\\[\\mu(h)=-2+\\varepsilon,\\qquad\\varepsilon=\\frac\\pi\\Omega(h-\\pi/\\Omega).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.168（印刷p.146）：状态列向量为(q,p)ᵀ；Ω≫1是模型背景。此处代数结论适用于任意Ω>0，不需要定量大频率门槛。",
    "S_h=[[1,0],[-h,1]]；F_h=[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]；W_h=S_{h/2}F_hS_{h/2}，快子系统在内步趋零时采用精确流，不是一次Verlet更新。",
    "λ₁、λ₂是W_h的两个复特征根，按代数重数计；det(W_h)=1，μ(h)=Tr(W_h)=2cos(hΩ)−(h/Ω)sin(hΩ)。",
    "h₀=π/Ω；ε=(π/Ω)(h−h₀)。原展示μ(h)=−2+ε是截断的一阶Taylor写法，非精确恒等式；同页随后λ+λ⁻¹=−2+ε+O(ε²)明确保留余项。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:54:42.701512",
      "before_sha256": "c0737d6d1cdec4190a0dc4c275ae97292cecac54d570df8cfbbfdd848ef1061f",
      "after_sha256": "576f876d207a2e3123fedebef6e77f31aed99e0a6789af8e42067ca469fb4fee",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
