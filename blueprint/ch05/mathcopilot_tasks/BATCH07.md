# BATCH07 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.2.2-LieCoordinates
```json
{
  "source_id": "MD-5.2.2-LieCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "$\\mathcal L_fv=\\sum_i f_i\\frac{\\partial v}{\\partial z_i}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.lieCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lieCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  MolecularDynamics.Chapter05Review.lie f g z=∑ i,f z i*(fderiv ℝ g z) (EuclideanSpace.basisFun (Fin n) ℝ i)
```

### MD-5.2.2-DivergenceCoordinates
```json
{
  "source_id": "MD-5.2.2-DivergenceCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "$\\frac{\\partial\\rho}{\\partial t}=-\\sum_i\\left(\\rho\\frac{\\partial f_i}{\\partial z_i}+f_i\\frac{\\partial\\rho}{\\partial z_i}\\right)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.divergenceCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem divergenceCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) z,
  DifferentiableAt ℝ f z → MolecularDynamics.Chapter05Review.divergence f z=
    ∑ i,(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)
```

### MD-5.2.2-LiouvilleProductCoordinates
```json
{
  "source_id": "MD-5.2.2-LiouvilleProductCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "An alternative form for the continuity equation is:\n\\[\\frac{\\partial\\rho}{\\partial t}=-\\sum_i\\left(\\rho\\frac{\\partial f_i}{\\partial z_i}+f_i\\frac{\\partial\\rho}{\\partial z_i}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.liouvilleProductCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem liouvilleProductCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z=-(∑ i : Fin n,(ρ z*(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+
    f z i*(fderiv ℝ ρ z) (EuclideanSpace.basisFun (Fin n) ℝ i)))
```

### MD-5.2.2-RectangularDomain
```json
{
  "source_id": "MD-5.2.2-RectangularDomain",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "Let $A$ be a suitable region of volume $V$ within the phase space (say a rectangular $m$-dimensional box).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.rectangularDomain",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def rectangularDomain {n : ℕ} (a b : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.rectangle a b
```

### MD-5.2.2-FaceFlux
```json
{
  "source_id": "MD-5.2.2-FaceFlux",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "$\\frac{d\\vartheta}{dt}=-\\int_{\\partial A}f\\cdot n\\,\\rho(z;t)\\,d\\sigma$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.faceFlux",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```

### MD-5.2.2-BoxFluxBalance
```json
{
  "source_id": "MD-5.2.2-BoxFluxBalance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "184",
  "pdf_page": "205",
  "statement_latex": "Using the divergence theorem, we may rewrite the latter quantity as a volume integral:\n\\[\\frac{d\\vartheta}{dt}=-\\int_A\\nabla\\cdot(f(z)\\rho(z;t))\\,d\\omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.fluxBalance",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fluxBalance :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,MolecularDynamics.Chapter05Review.probabilityDensity (ρ t)) →
  (∀ t,MolecularDynamics.Chapter05Review.densityMeasure (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i))
```

### MD-5.2.2-BoundaryTerm
```json
{
  "source_id": "MD-5.2.2-BoundaryTerm",
  "kind": "definition",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "where the term $B=\\sum_i\\int_{\\partial A_\\ell}uf_iv\\nu_i\\,d\\sigma$, is a surface integral over the boundary of $A_\\ell$, where $\\nu_i$ is the $i$th component of the unit outward normal to the surface $\\partial A_\\ell$ bounding the region $A_\\ell$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "各面实际面积积分及上下法向符号；不以虚构的未定边界项符号替代。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.boxBoundaryTerm",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```

### MD-5.2.2-TruncatedIntegrationByParts
```json
{
  "source_id": "MD-5.2.2-TruncatedIntegrationByParts",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.2.2",
  "printed_page": "185",
  "pdf_page": "206",
  "statement_latex": "We truncate the domain to a large box $A_\\ell$ with edge of length $2\\ell$ centered at the origin, approximating the inner product by:\n\\[\\langle u,\\mathcal L_fv\\rangle\\approx\\int_{A_\\ell}u\\mathcal L_fv\\,d\\omega=\\int_{A_\\ell}u\\sum_i f_i\\frac{\\partial v}{\\partial z_i}\\,d\\omega.\\]\nSplitting this sum up, we treat each term by integration by parts\n\\[\\int_{A_\\ell}u\\sum_i f_i\\frac{\\partial v}{\\partial z_i}\\,d\\omega=\\sum_i\\int_{A_\\ell}uf_i\\frac{\\partial v}{\\partial z_i}\\,d\\omega\\tag{5.4}\\]\n\\[=B-\\sum_i\\int_{A_\\ell}v\\frac{\\partial}{\\partial z_i}(uf_i)\\,d\\omega.\\tag{5.5}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.truncatedIntegrationByParts",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem truncatedIntegrationByParts : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := MolecularDynamics.Chapter05Review.rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*MolecularDynamics.Chapter05Review.lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,MolecularDynamics.Chapter05Review.liouvillian f u z*v z)
```

