# BATCH04 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.2.1-SplitHamiltonian
```json
{
  "source_id": "MD-4.2.1-SplitHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "4.2.1",
  "printed_page": "145",
  "pdf_page": "167",
  "statement_latex": "In many molecular dynamics applications, the system may be decomposed as $H(q,p)=p^TM^{-1}p/2+U_S(q)+U_F(q)$ where $U_S$ is a “soft” potential, in which the natural motion would be relatively slow, whereas $U_F$ is a much stronger term which would give rise to relatively rapid motion.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "质量对角，US/UF实际势函数；软/强的定性比较不当数值假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.splitHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def splitHamiltonian {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.dot z.2 (MolecularDynamics.Chapter04Review.invMass m z.2)/2+US z.1+UF z.1
```

### MD-4.2.1-FastVerlet
```json
{
  "source_id": "MD-4.2.1-FastVerlet",
  "kind": "definition",
  "label": null,
  "section": "4.2.1",
  "printed_page": "145",
  "pdf_page": "167",
  "statement_latex": "Let $\\mathcal G_h^F$ denote the map associated to the Verlet method for the system without $U_S$, using a stepsize $h$:\n\\[\\mathcal G_h^F=\\mathrm e^{\\frac h2L_{U_F}}\\mathrm e^{hL_K}\\mathrm e^{\\frac h2L_{U_F}},\\]\nwhere $L_K$ is the Lie-derivative corresponding to the kinetic energy component of the Hamiltonian $(K=p^TM^{-1}p/2)$.",
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
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def fastVerlet {n : ℕ} (m : Fin n → ℝ) (UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n :=
  Chapter02Review.verlet m (fun q => -MolecularDynamics.Chapter04Review.grad UF q) h
```

### MD-4.2.1-RESPA
```json
{
  "source_id": "MD-4.2.1-RESPA",
  "kind": "definition",
  "label": "(4.2)",
  "section": "4.2.1",
  "printed_page": "145",
  "pdf_page": "167",
  "statement_latex": "Now consider the map constructed by taking $r$ steps using $\\mathcal G_{F,h/r}$ and composing this with kicks from the soft force:\n\\[\\mathcal G_h^{\\mathrm{MTS}}=\\mathrm e^{\\frac h2L_{U_S}}[\\mathcal G_{h/r}^F]^r\\mathrm e^{\\frac h2L_{U_S}}.\\]\nReversible RESPA Algorithm\n\\[P:=p-(h/2)\\nabla U_S(q),\\quad Q:=q;\\]\nRepeat $r$ times:\n\\[P:=P-(h/2)\\nabla U_F(Q)/r,\\quad Q:=Q+hM^{-1}P/r,\\quad P:=P-(h/2)\\nabla U_F(Q)/r;\\tag{4.2}\\]\n\\[P:=P-(h/2)\\nabla U_S(Q).\\]",
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
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def respa {n : ℕ} (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) (r : ℕ) (h : ℝ) (z : MolecularDynamics.Chapter04Review.Z n) : MolecularDynamics.Chapter04Review.Z n :=
  MolecularDynamics.Chapter04Review.kick US (h/2) ((MolecularDynamics.Chapter04Review.fastVerlet m UF (h/r))^[r] (MolecularDynamics.Chapter04Review.kick US (h/2) z))
```

### MD-4.2.1-RESPAStructure
```json
{
  "source_id": "MD-4.2.1-RESPAStructure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "145",
  "pdf_page": "167",
  "statement_latex": "Because $U_F$ requires small timesteps, we think of separating the calculation of a timestep, typically in a symmetric form.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Jacobian辛性与反步恒等式，没有把任一结论作假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.respaStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本段Reversible名称及p149明确辛性合并成实际保结构声明：正质量、US/UF C²、r>0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem respaStructure :
  ∀ n (m : Fin n → ℝ) (US UF : MolecularDynamics.Chapter04Review.Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    MolecularDynamics.Chapter04Review.symplecticMap (MolecularDynamics.Chapter04Review.respa m US UF r h) ∧ ∀ z, MolecularDynamics.Chapter04Review.respa m US UF r (-h) (MolecularDynamics.Chapter04Review.respa m US UF r h z)=z
```

### MD-4.2.1-SlowMatrix
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
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

### MD-4.2.1-FastMatrix
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
    "Ω>0为模型频率；它是精确快振子旋转矩阵，非单个Verlet矩阵。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```

### MD-4.2.1-ImpulseMatrix
```json
{
  "source_id": "MD-4.2.1-ImpulseMatrix",
  "kind": "definition",
  "label": null,
  "section": "4.2.1",
  "printed_page": "146",
  "pdf_page": "168",
  "statement_latex": "In the limit of small inner step, we solve the system with Hamiltonian $H_F=p^2/2+\\Omega^2q^2/2$ exactly, meanwhile punctuating with impulses from $U_S$, thus the MTS flow map approximation, which is linear in this case, can be written in the form of a matrix-vector multiply\n\\[\\begin{bmatrix}Q\\\\P\\end{bmatrix}=W_h\\begin{bmatrix}q\\\\p\\end{bmatrix},\\qquad W_h=S_{h/2}F_hS_{h/2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "这是理想精确内步的impulse模型；不以它替代有限r的RESPA矩阵。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.impulseMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```

### MD-4.2.1-ImpulseDet
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
    "Ω≠0保证所写Fh分母资格；真实S,F,W三个det=1。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem impulseDet :
  ∀ Ω h : ℝ, Ω ≠ 0 →
  (MolecularDynamics.Chapter04Review.slowMatrix h).det=1 ∧ (MolecularDynamics.Chapter04Review.fastMatrix Ω h).det=1 ∧ (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).det=1
```

