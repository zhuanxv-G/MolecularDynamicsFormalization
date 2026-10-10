# BATCH03 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.2-LieDerivative
```json
{
  "source_id": "MD-3.2-LieDerivative",
  "kind": "definition",
  "label": null,
  "section": "3.2",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "The right hand side suggests a shorthand notation. If we define the Lie derivative $\\mathcal L_f$ by\n\\[\\mathcal L_f\\phi=f\\cdot\\nabla\\phi,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Let $\\phi(\\boldsymbol z)$ be an arbitrary smooth, scalar-valued function of the phase variables (assumed to lie in $\\mathbb R^m$). $f$为ODE向量场；Fréchet导数对f的作用等于坐标点积。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.textbookLieDerivative",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

### MD-3.2-ObservableDerivative
```json
{
  "source_id": "MD-3.2-ObservableDerivative",
  "kind": "unnumbered_claim",
  "label": "(3.2)",
  "section": "3.2",
  "printed_page": "100–101",
  "pdf_page": "122–123",
  "statement_latex": "At any point $\\boldsymbol z=\\boldsymbol\\zeta$ in phase space assume that there is a unique solution $\\boldsymbol z(t;\\boldsymbol\\zeta)$ such that $\\dot{\\boldsymbol z}(t)=f(\\boldsymbol z(t))$, $\\boldsymbol z(0)=\\boldsymbol\\zeta$ that is globally defined for all $t$. Now differentiate $\\phi(t)=\\phi(\\boldsymbol z(t))$ with respect to time, using the chain rule, to see how $\\phi(\\boldsymbol z(t))$ is changing as $t$ is varied:\n\\[\\left.\\frac{\\mathrm d}{\\mathrm dt}\\phi\\right|_{t=0}=\\left[\\sum_{i=1}^m\\frac{\\partial\\phi}{\\partial z_i}\\dot z_i\\right]_{\\boldsymbol z=\\boldsymbol\\zeta}=\\nabla\\phi(\\boldsymbol\\zeta)\\cdot f(\\boldsymbol\\zeta).\\]\nand note that the origin of time is irrelevant, then the equation for the evolution of $\\phi$ could be written\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\phi=(\\mathcal L_f\\phi)(\\boldsymbol z).\\tag{3.2}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\gamma$为原文给定实际解；$\\mathcal L_f$见p.100/PDF122。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.observableDerivative",
  "reusable_proofs": [
    "MolecularDynamics.hasDerivAt_textbookLieDerivative"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem observableDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t
```

### MD-3.2-ObservableSecondDerivative
```json
{
  "source_id": "MD-3.2-ObservableSecondDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "101",
  "pdf_page": "123",
  "statement_latex": "Similarly,\n\\[\\frac{\\mathrm d^2}{\\mathrm dt^2}\\phi(\\boldsymbol z(t))=(\\mathcal L_f^2\\phi)(\\boldsymbol z(t)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\dot\\gamma=f(\\gamma)$；$\\mathcal L_f^2$为两次算子作用，不是函数值平方。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.observableSecondDerivative",
  "reusable_proofs": [
    "MolecularDynamics.hasDerivAt_textbookLieDerivative_second"
  ],
  "extra_assumptions": [
    "f全域C¹、φ全域C²，显式化原文smooth及第二次求导资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem observableSecondDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ)
    (hγ : ∀ t, HasDerivAt γ (f (γ t)) t) (t : ℝ) :
    HasDerivAt (fun u => deriv (fun v => φ (γ v)) u)
      (textbookLieDerivative f (textbookLieDerivative f φ) (γ t)) t
```

### MD-3.2-OperatorExponential
```json
{
  "source_id": "MD-3.2-OperatorExponential",
  "kind": "definition",
  "label": null,
  "section": "3.2",
  "printed_page": "101",
  "pdf_page": "123",
  "statement_latex": "By analogy with the derivation of the matrix exponential, it is tempting to express the exponential as a series expansion in powers of $t$:\n\\[e^{t\\mathcal L_f}=\\mathrm{Id}+t\\mathcal L_f+\\frac{t^2}{2}\\mathcal L_f^2+\\cdots.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A代表原文$\\mathcal L_f$所在的实结合非交换代数；原文同页明确“we ignore the convergence issue here and treat the operator exponential as a formal series expansion”。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalOperatorExponential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def formalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

### MD-3.2-FormalObservable
```json
{
  "source_id": "MD-3.2-FormalObservable",
  "kind": "definition",
  "label": null,
  "section": "3.2",
  "printed_page": "101",
  "pdf_page": "123",
  "statement_latex": "The Taylor series expansion of $\\phi(\\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as\n\\[\\begin{aligned}\\phi(\\boldsymbol z(t))&=\\phi(\\boldsymbol z(0))+t\\left.\\frac{\\mathrm d}{\\mathrm dt}\\phi(\\boldsymbol z(t))\\right|_{t=0}+\\frac{t^2}{2}\\left.\\frac{\\mathrm d^2}{\\mathrm dt^2}\\phi(\\boldsymbol z(t))\\right|_{t=0}+\\cdots\\\\\n&=\\phi(\\boldsymbol z(0))+t(\\mathcal L_f\\phi)(\\boldsymbol z(0))+\\frac{t^2}{2}(\\mathcal L_f^2\\phi)(\\boldsymbol z(0))+\\cdots\\\\\n&=(e^{t\\mathcal L_f}\\phi)(\\boldsymbol z(0)).\\end{aligned}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "However, as $\\mathcal L_f$ is a first order operator, this series involves high order mixed partial derivatives, and the convergence of the expansion has to be considered in connection with its application to given initial data, that is, we should consider the expansion\n\\[e^{t\\mathcal L_f}\\phi=\\phi+t\\mathcal L_f\\phi+\\frac{t^2}{2}\\mathcal L_f^2\\phi+\\cdots\\]\nthen the primary issue is the boundedness of the terms with respect to functions $\\phi$ of a certain space of functions; we ignore the convergence issue here and treat the operator exponential as a formal series expansion.",
  "context_notation": [
    "时间展开按形式系数定义，不宣称smooth函数等于无限Taylor级数；实际有限余项另条。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalObservable",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def formalObservable {n : ℕ} (f : Q n → Q n) (φ : Q n → ℝ) (z : Q n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => ((textbookLieDerivative f)^[j] φ) z/(Nat.factorial j : ℝ))
```

### MD-3.2-FiniteLieTaylor
```json
{
  "source_id": "MD-3.2-FiniteLieTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "101",
  "pdf_page": "123",
  "statement_latex": "The Taylor series expansion of $\\phi(\\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as\n\\[\\phi(\\boldsymbol z(t))=\\phi(\\boldsymbol z(0))+t(\\mathcal L_f\\phi)(\\boldsymbol z(0))+\\frac{t^2}{2}(\\mathcal L_f^2\\phi)(\\boldsymbol z(0))+\\cdots.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "与FormalObservable同一展示公式，旧清单有限Taylor余项解释单列；原文没有明写余项不等式。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "是否将额外有限余项定理作为原文的忠实严格化，由导师/网站裁定；本地不进入证明。"
    }
  ],
  "lean_decl": "MD.Ch03.lieTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]有限阶k+1统一局部余项是原文形式展开的额外严格有限解释，原文未明写常数C与δ。",
    "[EXTRA]f与φ取全域C∞并给定实际ODE解；不预设无限级数收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lieTaylor :
  ∀ (n k : ℕ) (f : Q n → Q n) (φ : Q n → ℝ) (γ : ℝ → Q n),
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ φ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∃ C > 0, ∃ δ > 0, ∀ t ∈ Ioo (-δ) δ,
      |φ (γ t)-∑ j ∈ Finset.range (k+1), t^j/(Nat.factorial j:ℝ)*
        ((textbookLieDerivative f)^[j] φ) (γ 0)| ≤ C*|t|^(k+1)
```

### MD-3.2-FlowCoordinates
```json
{
  "source_id": "MD-3.2-FlowCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.2",
  "printed_page": "101",
  "pdf_page": "123",
  "statement_latex": "This gives a concise formula for the evolution of any function of the phase variables, including, in particular, any solution component $z_i$. Thus the flow map for the system can be represented by $\\exp(t\\mathcal L_f)$. When one writes $\\mathcal F_t=\\exp(t\\mathcal L_f)$, what is actually meant is that the individual components satisfy\n\\[z_i(t,\\boldsymbol\\zeta)=[\\mathcal F_t(\\boldsymbol\\zeta)]_i=\\left.(\\exp(t\\mathcal L_f)z_i)\\right|_{\\boldsymbol z=\\boldsymbol\\zeta}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文同页将exp按形式解释；坐标ζ的每个实际流分量的有限Taylor展开，不声称形式级数实际收敛。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "形式exp作用于坐标的等式无实际收敛主张；严格化为有限Taylor余项是否超出原文需裁定。"
    }
  ],
  "lean_decl": "MD.Ch03.flowCoordinates",
  "reusable_proofs": [],
  "extra_assumptions": [
    "有限截断阶k+1真实余项是额外严格化，原文没有此显式不等式；f全域C∞。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem flowCoordinates :
    ∀ (n k : ℕ) (f : Q n → Q n) (D : Set (Q n))
      (Φ : ℝ → Q n → Q n) (η : ℝ),
      ContDiff ℝ ⊤ f → actualFlow f D Φ η →
      ∀ ζ ∈ D, ∀ i : Fin n, ∃ C > 0, ∃ δ > 0, δ ≤ η ∧
        ∀ t ∈ Ioo (-δ) δ,
          |Φ t ζ i - ∑ j ∈ Finset.range (k+1),
            t^j * PowerSeries.coeff j (formalObservable f (fun z => z i) ζ)|
            ≤ C * |t|^(k+1)
```

### MD-3.2-PoissonBracket
```json
{
  "source_id": "MD-3.2-PoissonBracket",
  "kind": "definition",
  "label": null,
  "section": "3.2",
  "printed_page": "102",
  "pdf_page": "124",
  "statement_latex": "Another common notation for performing computations involving Hamiltonian systems is the Poisson bracket which is defined for two smooth scalar-valued functions $g_1$ and $g_2$ of the phase variables $(\\boldsymbol q,\\boldsymbol p)$ of a Hamiltonian system in $\\mathbb R^m$ by\n\\[\\{g_1,g_2\\}=\\sum_{i=1}^N\\left(\\frac{\\partial g_1}{\\partial q_i}\\frac{\\partial g_2}{\\partial p_i}-\\frac{\\partial g_2}{\\partial q_i}\\frac{\\partial g_1}{\\partial p_i}\\right)=\\nabla g_1^T J\\nabla g_2,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$J=\\begin{bmatrix}0&I\\\\-I&0\\end{bmatrix}$；$I$为$N\\times N$单位阵；本文n/Nc为配置坐标数，环境相空间维2n。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.textbookPoissonBracket",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```

