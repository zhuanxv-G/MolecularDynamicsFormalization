# BATCH05 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.2.1-Lagrangian
```json
{
  "source_id": "MD-2.2.1-Lagrangian",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "60",
  "pdf_page": "82",
  "statement_latex": "Recall from Chap. 1 that the Lagrangian for the N-body system is defined by\n\\[L(\\boldsymbol q,\\boldsymbol v)\\stackrel{\\rm def}{=}\\frac{\\boldsymbol v^TM\\boldsymbol v}{2}-U(\\boldsymbol q),\\]\nwhere $M$ is the mass matrix and the potential energy function $U$ is, for simplicity, taken to be smooth ($C^2$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "M为固定对角质量矩阵；bp_mechanicalL坐标求和给出同一动能。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_mechanicalL",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_mechanicalL {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (q v : Q n) : ℝ :=
  (∑ i, m i * v i ^ 2) / 2 - U q
```

### MD-2.2.1-Admissible
```json
{
  "source_id": "MD-2.2.1-Admissible",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "60",
  "pdf_page": "82",
  "statement_latex": "We consider the collection of all twice continuously differentiable curves in the configuration space which start from a certain point $\\boldsymbol Q$ and end at another given point $\\boldsymbol Q'$. We may think of any such curve as being represented by a parameterization $\\boldsymbol q(t)$, $t\\in[\\alpha,\\beta]$ with $\\boldsymbol q(\\alpha)=\\boldsymbol Q$ and $\\boldsymbol q(\\beta)=\\boldsymbol Q'$, where the components of $\\boldsymbol q(t)$ are $C^\\infty$ functions. Denote by $G=G(\\boldsymbol Q,\\boldsymbol Q',\\alpha,\\beta)$ the class of smooth parameterized curves such that $\\boldsymbol q(\\alpha)=\\boldsymbol Q$, $\\boldsymbol q(\\beta)=\\boldsymbol Q'$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "REGULARITY_AMBIGUITY",
      "status": "NEEDS_HUMAN",
      "detail": "原页先说twice continuously differentiable，后说C∞/smooth；按后一明确C∞登记，不能用旧CSV的C1转述。"
    }
  ],
  "lean_decl": "MD.Ch02.admissibleSmooth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "全实线C∞延拓强于只在[α,β]光滑的局部资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def admissibleSmooth {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  ContDiff ℝ ∞ q ∧ q a = x ∧ q b = y
```

### MD-2.2.1-Action
```json
{
  "source_id": "MD-2.2.1-Action",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "60",
  "pdf_page": "82",
  "statement_latex": "Then the classical action (or, simply, action) of the Lagrangian $L$ is defined for any $\\Gamma\\in G$ by\n\\[\\mathcal A_L(\\Gamma)\\stackrel{\\rm def}{=}\\int_\\alpha^\\beta L(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\,dt.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q为Γ的参数曲线；α<β，光滑资格见同页G。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_action",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
```

### MD-2.2.1-Variation
```json
{
  "source_id": "MD-2.2.1-Variation",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "61",
  "pdf_page": "83",
  "statement_latex": "Given $\\Gamma$ in $G$ with parameterization $\\boldsymbol q(t)$, $t\\in[\\alpha,\\beta]$, we consider the curve $\\Gamma^\\epsilon$ with parameterization $\\boldsymbol q^\\epsilon$ defined by\n\\[\\boldsymbol q^\\epsilon(t)=\\boldsymbol q(t)+\\epsilon\\boldsymbol\\eta(t),\\qquad t\\in[\\alpha,\\beta],\\tag{2.3}\\]\nwhere $\\boldsymbol\\eta(t)$ satisfies $\\boldsymbol\\eta(\\alpha)=\\boldsymbol\\eta(\\beta)=\\boldsymbol0$. Thus $\\boldsymbol\\eta$ is a $C^\\infty$ parameterized curve linking $\\boldsymbol0$ to $\\boldsymbol0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "η的C∞及零端点是可用变分资格；函数体定义q+εη本身不宣称这些资格自动成立。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_variation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
```

### MD-2.2.1-FirstVariation
```json
{
  "source_id": "MD-2.2.1-FirstVariation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.1",
  "printed_page": "61",
  "pdf_page": "83",
  "statement_latex": "Using a Taylor series expansion of the Lagrangian, we have\n\\[\\mathcal A_L(\\Gamma^\\epsilon)-\\mathcal A_L(\\Gamma)=\\int_\\alpha^\\beta[L(\\boldsymbol q(t)+\\epsilon\\boldsymbol\\eta(t),\\dot{\\boldsymbol q}(t)+\\epsilon\\dot{\\boldsymbol\\eta}(t))-L(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))]\\,dt,\\]\n\\[=\\int_\\alpha^\\beta\\left[\\epsilon\\left(\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\boldsymbol\\eta(t)+\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\dot{\\boldsymbol\\eta}(t)\\right)+O(\\epsilon^2)\\right]\\,dt.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.firstVariation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "α<β；L、q、η C²以保证实际导数和紧时间窗余项资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem firstVariation :
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    HasDerivAt (fun ε => action L a b (variation q η ε))
      (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) 0 ∧
    Asymptotics.IsBigO (𝓝 0)
      (fun ε : ℝ => action L a b (variation q η ε)-action L a b q-
        ε*(∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)))
      (fun ε : ℝ => ε^2)
```

### MD-2.2.1-TaylorPrinted
```json
{
  "source_id": "MD-2.2.1-TaylorPrinted",
  "kind": "unnumbered_claim",
  "label": "Footnote 3",
  "section": "2.2.1",
  "printed_page": "61",
  "pdf_page": "83",
  "statement_latex": "In the multidimensional setting, Taylor’s theorem states that given a $C^{k+1}$ function $f:\\mathbb R^m\\to\\mathbb R$ and a point $\\boldsymbol z_0$, we have\n\\[f(\\boldsymbol z)-f(\\boldsymbol z_0)=\\nabla f(\\boldsymbol z_0)\\cdot(\\boldsymbol z-\\boldsymbol z_0)+f^{(2)}\\langle\\boldsymbol z-\\boldsymbol z_0,\\boldsymbol z-\\boldsymbol z_0\\rangle+f^{(3)}\\langle\\boldsymbol z-\\boldsymbol z_0,\\boldsymbol z-\\boldsymbol z_0,\\boldsymbol z-\\boldsymbol z_0\\rangle+\\ldots f^{(k)}\\langle\\boldsymbol z-\\boldsymbol z_0,\\boldsymbol z-\\boldsymbol z_0,\\ldots,\\boldsymbol z-\\boldsymbol z_0\\rangle+O(\\|\\boldsymbol z-\\boldsymbol z_0\\|^{k+1})\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原脚注f^(2)明确为Hessian，f^(3)为三阶偏导张量，故不含1/j!不是缩放记号。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原脚注二阶及以后漏1/j!；f(x)=x²在0的k=2展开会给2x²，余项差为-x²而非O(x³)。"
    }
  ],
  "lean_decl": "MD.Ch02.taylorPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem taylorPrinted : ∀ n (k : ℕ) (f : Q n → ℝ) z₀,
    1 ≤ k → ContDiff ℝ (k+1) f →
    Asymptotics.IsBigO (𝓝 0)
      (fun u => f (z₀+u)-f z₀-∑ j ∈ Finset.range k,
        iteratedFDeriv ℝ (j+1) f z₀ (fun _ => u))
      (fun u : Q n => ‖u‖^(k+1))
```

### MD-2.2.1-StationaryAction
```json
{
  "source_id": "MD-2.2.1-StationaryAction",
  "kind": "definition",
  "label": null,
  "section": "2.2.1",
  "printed_page": "61–62",
  "pdf_page": "83–84",
  "statement_latex": "Hamilton’s principle states that the natural motion of the system described by the Lagrangian $L$ is a stationary point of the classical action which implies that the $O(\\epsilon)$ term above should vanish for any smooth variation $\\boldsymbol\\eta(t)$ with $\\boldsymbol\\eta(\\alpha)=\\boldsymbol\\eta(\\beta)=\\boldsymbol0$, i.e.,\n\\[I=\\int_\\alpha^\\beta\\left[\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\boldsymbol\\eta(t)+\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\dot{\\boldsymbol\\eta}(t)\\right]dt=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.stationarySmoothAction",
  "reusable_proofs": [],
  "extra_assumptions": [
    "驻值以真实一阶变分导数为零定义；展开式相等由FirstVariation条目承担。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0
```

### MD-2.2.1-Parts
```json
{
  "source_id": "MD-2.2.1-Parts",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.2.1",
  "printed_page": "62",
  "pdf_page": "84",
  "statement_latex": "We use integration by parts to remove the differentiation of $\\boldsymbol\\eta$, thus (in light of the boundary conditions on $\\boldsymbol\\eta(t)$),\n\\[I=\\int_\\alpha^\\beta\\left[\\frac{\\partial L}{\\partial\\boldsymbol q}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))-\\frac{\\mathrm d}{\\mathrm dt}\\frac{\\partial L}{\\partial\\dot{\\boldsymbol q}}(\\boldsymbol q(t),\\dot{\\boldsymbol q}(t))\\right]\\boldsymbol\\eta(t)\\,dt=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "I=0来自驻值前提；本条只证明分部积分恒等式，零结论由驻值展开传入。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.firstVariationParts",
  "reusable_proofs": [],
  "extra_assumptions": [
    "α<β；L及曲线C²；η端点为0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem firstVariationParts :
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    η a = 0 → η b = 0 →
    (∫ t in a..b, (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
      -(∫ t in a..b, (deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t))
```

