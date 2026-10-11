# BATCH02 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4-PRKThreshold
```json
{
  "source_id": "MD-4-PRKThreshold",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "Among explicit symplectic Partitioned Runge-Kutta methods this is the maximum stability threshold [74].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "原文[74]的方法类限制需要审，未访问引用文献。"
    }
  ],
  "lean_decl": "MD.Ch04.prkThreshold",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem prkThreshold :
  ∀ s (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (G : ℝ → ℝ → Matrix (Fin 2) (Fin 2) ℝ), 0 < s →
    (∑ i,b i)=1 → (∑ i,c i)=1 →
    (∀ i j, b i*B i j+c j*A j i=b i*c j) →
    (∀ i j, i ≤ j → A i j=0) → (∀ i j, i < j → B i j=0) →
    (∀ Ω h z, ∃ q p, MolecularDynamics.Chapter04Review.prkOscillatorRelation A B b c Ω h z (G Ω h *ᵥ z) q p) →
    (∀ Ω h, MolecularDynamics.Chapter04Review.matrixStable (G Ω h) → |h*Ω| ≤ 2)
```

### MD-4-VerletStability
```json
{
  "source_id": "MD-4-VerletStability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "141",
  "pdf_page": "163",
  "statement_latex": "For example, applying the Verlet method to the harmonic oscillator with frequency $\\Omega$ we find that the origin is stable (and the numerical solution stays bounded for all time) provided $h\\Omega\\le2$ (the same condition as for stability of Symplectic Euler).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "Verlet的hΩ=2矩阵也有Jordan增长，不能以谱模1推出所有轨道有界。"
    }
  ],
  "lean_decl": "MD.Ch04.verletStability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真正幂有界版本0<|hΩ|<2；原文≤2字面版另列待审。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletStability :
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h)
```

### MD-4-SymplecticEulerBoundaryPrinted
```json
{
  "source_id": "MD-4-SymplecticEulerBoundaryPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "if $h\\Omega\\le2$ the integrator is stable.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原≤2声明的端点反例；不证明FAIL。"
    }
  ],
  "lean_decl": "MD.Ch04.symplecticEulerBoundaryPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)
```

### MD-4-VerletBoundaryPrinted
```json
{
  "source_id": "MD-4-VerletBoundaryPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "141",
  "pdf_page": "163",
  "statement_latex": "the numerical solution stays bounded for all time) provided $h\\Omega\\le2$",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原≤2端点不保证幂有界，单列原文不静默替换。"
    }
  ],
  "lean_decl": "MD.Ch04.verletBoundaryPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletBoundaryPrinted :
    ∀ Ω h : ℝ, 0 < Ω → 0 < h → h*Ω ≤ 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.verletMatrix Ω h)
```

### MD-4-OscillatorSpectrum
```json
{
  "source_id": "MD-4-OscillatorSpectrum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "The eigenvalues are $\\pm i\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整真实复特征值与±iΩ，包含Ω=0；原文ω与Ω记号不同。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.oscillatorSpectrum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem oscillatorSpectrum :
    ∀ Ω : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.oscillatorMatrix Ω).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ζ=Complex.I*Ω ∨ ζ= -Complex.I*Ω
```

### MD-4-SymplecticEulerRoots
```json
{
  "source_id": "MD-4-SymplecticEulerRoots",
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
  "lean_decl": "MD.Ch04.symplecticEulerRoots",
  "reusable_proofs": [],
  "extra_assumptions": [
    "以任意复平方根d²=判别式表达±，避免未指定复sqrt分支；不是仅特征多项式断言。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ,
      (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h).map Complex.ofReal *ᵥ v = ζ • v) ↔
      ∃ d : ℂ, d^2=(h^4*Ω^4-4*h^2*Ω^2 : ℝ) ∧
        (ζ=1-(h^2*Ω^2 : ℝ)/2+d/2 ∨ ζ=1-(h^2*Ω^2 : ℝ)/2-d/2)
```

### MD-4-SymplecticEulerUnitRoots
```json
{
  "source_id": "MD-4-SymplecticEulerUnitRoots",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "Then we observe that for $h^2\\Omega^2\\le4$, they are complex and their squared magnitude is\n\\[|\\lambda_{1,2}|^2=\\left(1-\\frac{h^2\\Omega^2}{2}\\right)^2+\\frac14(4h^2\\Omega^2-h^4\\Omega^4)=1,\\]\nthus both eigenvalues lie on the unit circle in the complex plane as long as $h\\Omega\\le2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "采用原先明确的平方条件≤4；hΩ≤2没有负步长下界，原通常h,Ω≥0。包含重根边界但不声称幂有界。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.symplecticEulerUnitRoots",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerUnitRoots :
    ∀ Ω h : ℝ, ∀ ζ : ℂ, h^2*Ω^2 ≤ 4 →
      ζ^2-(2-h^2*Ω^2 : ℝ)*ζ+1=0 → ‖ζ‖=1
```

### MD-4-SymplecticEulerStability
```json
{
  "source_id": "MD-4-SymplecticEulerStability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4",
  "printed_page": "140",
  "pdf_page": "162",
  "statement_latex": "This is the so-called linear stability condition of the Symplectic Euler method: if $h\\Omega\\le2$ the integrator is stable. When $h\\Omega>2$, the eigenvalues of the discretization method are both real, with one strictly inside and one strictly outside the unit circle. This implies that the method will exhibit exponentially growing solutions. We say that the stability threshold of the Symplectic Euler method is $2/\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "≤2端点有单位圆谱但通常Jordan线性增长；幂有界不能包含端点。"
    }
  ],
  "lean_decl": "MD.Ch04.symplecticEulerStability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正确的幂有界资格改为0<|hΩ|<2；原≤2字面版独立保留，未声称已审核修复。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem symplecticEulerStability :
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → MolecularDynamics.Chapter04Review.matrixStable (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.symplecticEulerMatrix Ω h))
```

