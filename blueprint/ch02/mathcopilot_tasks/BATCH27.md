# BATCH27 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.5.1-RK
```json
{
  "source_id": "MD-2.5.1-RK",
  "kind": "definition",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "The family of Runge-Kutta methods for solving $\\dot{\\boldsymbol z}=f(\\boldsymbol z)$ is defined by\n\\[\\boldsymbol Z=\\boldsymbol z+h\\sum_{i=1}^s b_i\\boldsymbol F_i,\\]\nwhere the vectors $\\boldsymbol F_i$, $i=1,\\ldots,s$, are computed by solving the system\n\\[\\boldsymbol F_i=f\\left(\\boldsymbol z+h\\sum_{j=1}^s a_{ij}\\boldsymbol F_j\\right),\\qquad i=1,\\ldots,s.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "s有限阶段；给实际关系，不宣称任意隐式系统可解。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_rungeKuttaRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
```

### MD-2.5.1-RK4
```json
{
  "source_id": "MD-2.5.1-RK4",
  "kind": "definition",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "An example of a popular 4th order explicit method is the choice of matrix $A$ with coefficients $a_{ij}=0$ except $a_{21}=1/2$, $a_{32}=1/2$ and $a_{43}=1$, and $b_1=1/6$, $b_2=1/3$, $b_3=1/3$, $b_4=1/6$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "展开实际四阶段给出同一A/b权重；4阶陈述单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_rk4",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)
```

### MD-2.5.1-RK4Order
```json
{
  "source_id": "MD-2.5.1-RK4Order",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "An example of a popular 4th order explicit method",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "完整系数与映射见同页RK4条目，非任意方法；有限时间窗全局4阶。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.rk4Order",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]compactTrajectory实际C⁶向量场与紧窗实际轨迹；高阶资格强于原文简写。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rk4Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ, compactTrajectory f γ τ → globalOrder (rk4 f) γ τ 4
```

### MD-2.5.1-ExplicitRK
```json
{
  "source_id": "MD-2.5.1-ExplicitRK",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "This method is not symplectic, and in fact impossible to find symplectic explicit methods within the Runge-Kutta family.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.explicitRK",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem explicitRK :
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ⊤ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G
```

### MD-2.5.1-RKSymplectic
```json
{
  "source_id": "MD-2.5.1-RKSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89–90",
  "pdf_page": "111–112",
  "statement_latex": "Let us emphasize that, while a typical RK method is not symplectic, some implicit Runge-Kutta methods are symplectic. The precise condition that must be satisfied [325] is\n\\[b_i a_{ij}+b_j a_{ji}=b_i b_j,\\qquad i=1,\\ldots,s,\\quad j=1,\\ldots,s.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "“precise condition”按针对所有光滑Hamilton模型的判别表达；一般可约RK的必要性仍有疑点。"
  ],
  "issues": [
    {
      "code": "NECESSITY_QUALIFICATION",
      "status": "NEEDS_HUMAN",
      "detail": "原句precise condition需不可约/非退化资格；完整普适iff已保留，冗余RK必要性不能默认为真。"
    }
  ],
  "lean_decl": "MD.Ch02.rkSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "H C²；真实阶段函数与完整步G C¹且确实满足RK关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem rkSymplectic : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) ↔
    (∀ n (H : SymplecticCoordinates n → ℝ) (h : ℝ)
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G)
```

### MD-2.5.1-GaussFamily
```json
{
  "source_id": "MD-2.5.1-GaussFamily",
  "kind": "unnumbered_claim",
  "label": "Example 2.7 (family)",
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "The Gauss-Legendre family of Runge-Kutta (GLRK) methods correspond to approximating the vector field at the Gauss points, i.e. the zeros of the orthogonal polynomials that arise in Gaussian quadrature. As these points are symmetrically distributed the GLRK schemes are symmetric, hence have even order.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.gaussFamily",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Legendre根节点、Lagrange积分系数；s>0，节点单射，C∞向量场和实际光滑G；真实唯一阶段及真实流资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem gaussFamily :
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ (∃ r : ℕ, 0 < r ∧ Even r ∧ methodLocalOrder G F r)
```

### MD-2.5.1-Midpoint
```json
{
  "source_id": "MD-2.5.1-Midpoint",
  "kind": "definition",
  "label": null,
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "The simplest such method is the implicit midpoint rule:\n\\[\\boldsymbol Z=\\boldsymbol z+h\\boldsymbol F_1,\\qquad\\boldsymbol F_1=f\\left(\\boldsymbol z+\\frac h2\\boldsymbol F_1\\right),\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "消去实际F₁得到Z=z+hf((z+Z)/2)；只是隐式关系。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_midpointRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_midpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop :=
  w = z + h • f ((1/2 : ℝ) • (z+w))
```

### MD-2.5.1-MidpointProperties
```json
{
  "source_id": "MD-2.5.1-MidpointProperties",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "which has order 2.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "来自GLRK辛RK上下文，保留二阶与辛性两个结论；实际中点关系见同页。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.midpointProperties",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem midpointProperties :
  ∀ n (H : SymplecticCoordinates n → ℝ) (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    ContDiff ℝ 4 H → ContDiff ℝ 1 (Function.uncurry G) →
    (∀ h z, G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z))) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (textbookHamiltonianVectorField H (F t z)) t) →
    (∀ h, IsTextbookSymplecticMap (G h)) ∧ methodLocalOrder G F 2
```

