# BATCH01 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4-LinearField
```json
{
  "source_id": "MD-4-LinearField",
  "kind": "definition",
  "label": "(4.1)",
  "section": "4",
  "printed_page": "139",
  "pdf_page": "161",
  "statement_latex": "Let us recall the method of studying the asymptotic numerical stability of a linear system\n\\[\\dot z=Az,\\tag{4.1}\\]\nwhere $z\\in\\mathbb R^m,A\\in\\mathbb R^{m\\times m}$, when solved by a numerical method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文generic conditions下才作特征分解；非半单Jordan边界不能只依据特征值。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.linearField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "复线性扩张用于随后的标量测试；原实矩阵实例嵌入ℂ。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def linearField {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (z : Fin n → ℂ) := A *ᵥ z
```

### MD-4-EulerFactor
```json
{
  "source_id": "MD-4-EulerFactor",
  "kind": "definition",
  "label": null,
  "section": "4",
  "printed_page": "139",
  "pdf_page": "161",
  "statement_latex": "Here $\\lambda\\in\\mathbb C$, hence $u$ may in general be complex. Then one applies the numerical method directly to the scalar equation. For example Euler’s method yields\n\\[u_{n+1}=(1+h\\lambda)u_n.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "标量连续方程u′=λu，h实数；迭代因子1+hλ。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.eulerFactor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def eulerFactor (h : ℝ) (rho : ℂ) : ℂ := 1 + (h : ℂ) * rho
```

### MD-4-ScalarEulerStable
```json
{
  "source_id": "MD-4-ScalarEulerStable",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "139",
  "pdf_page": "161",
  "statement_latex": "The iteration is stable if $|u_n|$ remains bounded as $n\\to\\infty$, implying the following condition for asymptotic stability:\n\\[|1+h\\lambda|\\le1.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.scalarEulerStable",
  "reusable_proofs": [],
  "extra_assumptions": [
    "scalarStable明确定义为因子各次幂一致有界；非零初值下等价于迭代有界，零初值例外。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem scalarEulerStable :
  ∀ h rho, MolecularDynamics.Chapter04Review.scalarStable (MolecularDynamics.Chapter04Review.eulerFactor h rho) ↔ ‖MolecularDynamics.Chapter04Review.eulerFactor h rho‖ ≤ 1
```

### MD-4-EulerRegion
```json
{
  "source_id": "MD-4-EulerRegion",
  "kind": "definition",
  "label": null,
  "section": "4",
  "printed_page": "139",
  "pdf_page": "161",
  "statement_latex": "This defines the “stability region” for Euler’s method as a disk in the complex $h\\lambda$-plane centered around $-1$ of radius $1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "自变量z=hλ，集合{z:ℂ|‖1+z‖≤1}。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.eulerStabilityRegion",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def eulerStabilityRegion : Set ℂ := {z | ‖1+z‖ ≤ 1}
```

### MD-4-OscillatorMatrix
```json
{
  "source_id": "MD-4-OscillatorMatrix",
  "kind": "definition",
  "label": null,
  "section": "4",
  "printed_page": "139",
  "pdf_page": "161",
  "statement_latex": "If we consider applying this technique to the harmonic oscillator $\\dot q=p;\\dot p=-\\Omega^2q$, then the matrix $A$ is\n\\[A=\\begin{bmatrix}0&I\\\\-\\Omega^2&0\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.oscillatorMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "一个自由度，I=1；按标量频率实例解释。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def oscillatorMatrix (Ω : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![0,1; -Ω^2,0]
```

### MD-4-EulerImaginaryGrowth
```json
{
  "source_id": "MD-4-EulerImaginaryGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "The eigenvalues are $\\pm i\\omega$. The stability condition always fails to hold and, for Euler’s method, $z_n$ grows exponentially rapidly away from the equilibrium point.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原页从Ω改用ω；矩阵的完整±iΩ谱另列，不由增长结论替代。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.eulerImaginaryGrowth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem eulerImaginaryGrowth :
  ∀ h Ω : ℝ, h ≠ 0 → Ω ≠ 0 → ∀ z : ℂ, z ≠ 0 →
    Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.eulerFactor h (Complex.I*Ω))^k*z‖) atTop atTop
```

### MD-4-SymplecticEulerMatrix
```json
{
  "source_id": "MD-4-SymplecticEulerMatrix",
  "kind": "definition",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "The timestep map is defined by\n\\[Q=q+hP,\\qquad P=p-h\\Omega^2q.\\]\nSolving for $Q,P$ this yields\n\\[\\begin{bmatrix}Q\\\\P\\end{bmatrix}=\\begin{bmatrix}1-h^2\\Omega^2&h\\\\-h\\Omega^2&1\\end{bmatrix}\\begin{bmatrix}q\\\\p\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "动量先更新，位置使用P。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.symplecticEulerMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```

### MD-4-SymplecticEulerCharacteristic
```json
{
  "source_id": "MD-4-SymplecticEulerCharacteristic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "The eigenvalues of the matrix are easily found, they are\n\\[\\lambda_{1,2}=1-\\frac{h^2\\Omega^2}{2}\\pm\\frac12\\sqrt{h^4\\Omega^4-4h^2\\Omega^2}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.symplecticEulerCharacteristic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerCharacteristic :
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1
```

