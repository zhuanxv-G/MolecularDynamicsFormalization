# BATCH01 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.1-LieDerivative
```json
{
  "source_id": "MD-5.1-LieDerivative",
  "kind": "definition",
  "label": null,
  "section": "5.1",
  "printed_page": "180",
  "pdf_page": "201",
  "statement_latex": "In Chap. 3, we introduced the Lie derivative of a function $g$ of the phase variables with respect to a dynamical system $\\dot z=f(z)$:\n\\[\\mathcal L_fg=f\\cdot\\nabla g.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "相空间采用实际EuclideanSpace；fderiv是真实Fréchet导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.lie",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```

### MD-5.1-TrajectoryChain
```json
{
  "source_id": "MD-5.1-TrajectoryChain",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "180",
  "pdf_page": "201",
  "statement_latex": "This is obtained by differentiating a composite function $g(z(t))$ with respect to $t$, along a solution trajectory. That is, describing a trajectory in terms of the flow map by $z(t)=\\mathcal F_t(\\xi),t\\in\\mathbb R$, we have\n\\[\\frac d{dt}g(\\mathcal F_t(\\xi))=(\\mathcal L_fg)(\\mathcal F_t(\\xi)).\\]\nThe partial derivative of $\\widetilde g(z,t)$ with respect to $t$ is\n\\[\\frac{\\partial\\widetilde g}{\\partial t}(t,z)=\\nabla g(\\mathcal F_t(z))\\cdot\\frac d{dt}\\mathcal F_t(z)=\\nabla g(\\mathcal F_t(z))\\cdot f(\\mathcal F_t(z))=(\\mathcal L_fg)(\\mathcal F_t(z)).\\tag{5.1}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.trajectoryChain",
  "reusable_proofs": [
    "MolecularDynamics.hasDerivAt_textbookLieDerivative"
  ],
  "extra_assumptions": [
    "[EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t
```

### MD-5.1-ActualFlow
```json
{
  "source_id": "MD-5.1-ActualFlow",
  "kind": "definition",
  "label": null,
  "section": "5.1",
  "printed_page": "180",
  "pdf_page": "201",
  "statement_latex": "describing a trajectory in terms of the flow map by $z(t)=\\mathcal F_t(\\xi),t\\in\\mathbb R$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.flow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```

### MD-5.1-ObservablePullback
```json
{
  "source_id": "MD-5.1-ObservablePullback",
  "kind": "definition",
  "label": null,
  "section": "5.1",
  "printed_page": "180–181",
  "pdf_page": "201–202",
  "statement_latex": "Replacing $\\xi$ by $z$ (it is an arbitrary point), define a function $\\widetilde g(z,t)\\stackrel{\\rm def}{=}g(\\mathcal F_t(z))$.\nIt is intuitively appealing to define the solution of (5.2) by\n\\[\\widetilde g(z,t)=G_t\\widetilde g(z,0),\\qquad\\hbox{where }G_t=e^{t\\mathcal L_f}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Gt及exp(tLf)作为实际pullback的解算子记号；不伪造无界算子指数级数的收敛或存在证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.pullback",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```

### MD-5.1-FlowFieldTransport
```json
{
  "source_id": "MD-5.1-FlowFieldTransport",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "On the other hand, viewing $\\mathcal L_f$ as an operator on the phase variables only, we have\n\\[(\\mathcal L_f\\widetilde g)(z)=f(z)\\cdot\\nabla_z[g(\\mathcal F_t(z))]\n=f(z)\\cdot\\mathcal F_t'(z)^T\\nabla g(\\mathcal F_t(z))\n=\\mathcal F_t'(z)f(z)\\cdot\\nabla g(\\mathcal F_t(z))\n=f(\\mathcal F_t(z))\\cdot\\nabla g(\\mathcal F_t(z))\n=(\\mathcal L_fg)(\\mathcal F_t(z)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.flowFieldTransport",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem flowFieldTransport :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z)
```

### MD-5.1-PullbackPDE
```json
{
  "source_id": "MD-5.1-PullbackPDE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "This is the same as the right hand side of (5.1). This means that $\\widetilde g$ satisfies the equation\n\\[\\frac{\\partial\\widetilde g}{\\partial t}=\\mathcal L_f\\widetilde g.\\tag{5.2}\\]\nThis is a time-dependent, linear (hyperbolic) partial differential equation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.pullbackPDE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem pullbackPDE :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => MolecularDynamics.Chapter05Review.pullback Φ g s z) (MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z) t
```

### MD-5.1-SteadyFirstIntegral
```json
{
  "source_id": "MD-5.1-SteadyFirstIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "The steady state solutions of this equation (defined by $\\partial\\widetilde g/\\partial t=0$) are of the form $\\widetilde g(z,t)=\\varphi(z)$ where $\\varphi$ satisfies $\\mathcal L_f\\varphi(z)\\equiv0$. These are just the first integrals of the ordinary differential equation system $\\dot z=f(z)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.steadyFirstIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem steadyFirstIntegral :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → Differentiable ℝ g → ((∀ z,MolecularDynamics.Chapter05Review.lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z)
```

### MD-5.1-CoordinatePullback
```json
{
  "source_id": "MD-5.1-CoordinatePullback",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "The interpretation of the solution of the initial value problem in terms of the solution operator $G_t$ is given by\n\\[(e^{t\\mathcal L_f}\\partial_i)(z(0))=z_i(t).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "∂i(z)=zi是坐标投影，不是对坐标取偏导的算子；actual pullback等式，不计流存在证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.coordinatePullback",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.coordinatePullback_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i
```

