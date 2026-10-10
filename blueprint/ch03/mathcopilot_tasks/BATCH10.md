# BATCH10 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.3.3-YoshidaComposition
```json
{
  "source_id": "MD-3.3.3-YoshidaComposition",
  "kind": "definition",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "We now consider iterating this scheme three times, first using a step of $\\tau_0h$, followed by a step of $\\tau_1h$, and finally another step with stepsize $\\tau_0h$ (where $\\tau_0h+\\tau_1h+\\tau_0h=h$). The overall effect on the system is given by a product of exponentials, as\n\\[\\exp(\\tau_0h\\widehat{\\mathcal L}_{\\tau_0h})\\exp(\\tau_1h\\widehat{\\mathcal L}_{\\tau_1h})\\exp(\\tau_0h\\widehat{\\mathcal L}_{\\tau_0h})=\\exp(hZ_h).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$a=\\tau_0,b=\\tau_1$；2a+b=1在系数结论中明示；允许中间负步长，不裁掉反向步。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaCompose",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```

### MD-3.3.3-YoshidaCoefficients
```json
{
  "source_id": "MD-3.3.3-YoshidaCoefficients",
  "kind": "definition",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "We have free reign over constants $\\tau_0$ and $\\tau_1$ as long as $2\\tau_0+\\tau_1=1$. Hence we have an opportunity to annihilate the perturbation operator at order $h^{2s}$ by choosing $2\\tau_0^{2s+1}+\\tau_1^{2s+1}=0$ as well. Solving simultaneously, there exists a unique real solution\n\\[\\tau_0=\\frac1{2-\\kappa},\\qquad\\tau_1=-\\frac\\kappa{2-\\kappa},\\qquad\\kappa^{2s+1}=2,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$s\\ge1$；$\\kappa=2^{1/(2s+1)}$为正实根，真实Real.rpow；方程成立和唯一性分别另条完整结论，不因定义而假定。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaCoefficients",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```

### MD-3.3.3-YoshidaCancellation
```json
{
  "source_id": "MD-3.3.3-YoshidaCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "We have free reign over constants $\\tau_0$ and $\\tau_1$ as long as $2\\tau_0+\\tau_1=1$. Hence we have an opportunity to annihilate the perturbation operator at order $h^{2s}$ by choosing $2\\tau_0^{2s+1}+\\tau_1^{2s+1}=0$ as well.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "系数与κ正实根见同页YoshidaCoefficients；s≥1排除s=0退化分母。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaCancellation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "显式s≥1，并保留中间系数τ₁<0作为根公式的数学推论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem yoshidaCancellation :
  ∀ s : ℕ, 1 ≤ s → let ab := yoshidaCoefficients s
    2*ab.1+ab.2=1 ∧ 2*ab.1^(2*s+1)+ab.2^(2*s+1)=0 ∧ ab.2 < 0
```

### MD-3.3.3-YoshidaUnique
```json
{
  "source_id": "MD-3.3.3-YoshidaUnique",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "Solving simultaneously, there exists a unique real solution\n\\[\\tau_0=\\frac1{2-\\kappa},\\qquad\\tau_1=-\\frac\\kappa{2-\\kappa},\\qquad\\kappa^{2s+1}=2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$s\\ge1$；两个原方程见同页YoshidaCancellation；κ为正实根。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaUnique",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem yoshidaUnique :
  ∀ s : ℕ, 1 ≤ s → ∀ a b : ℝ,
    (2*a+b=1 ∧ 2*a^(2*s+1)+b^(2*s+1)=0) ↔ (a,b)=yoshidaCoefficients s
```

### MD-3.3.3-YoshidaRaiseOrder
```json
{
  "source_id": "MD-3.3.3-YoshidaRaiseOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "109",
  "pdf_page": "131",
  "statement_latex": "giving us a scheme of order $2s+2$. We can then proceed recursively, as this new order $2s+2$ scheme can be composed similarly to wipe out successive higher order terms.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原方法对称且阶2s≥2，真实三步复合及系数同页；保留负时间步。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshidaRaiseOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem yoshidaRaiseOrder :
  ∀ (n s : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    1 ≤ s → ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η →
    (∀ h z, G (-h) (G h z)=z) → localOrder G Φ B (2*s) →
    localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ B (2*s+2)
```

### MD-3.3.3-Yoshida4
```json
{
  "source_id": "MD-3.3.3-Yoshida4",
  "kind": "definition",
  "label": "Example 3.1 / (3.8)",
  "section": "3.3.3",
  "printed_page": "109–110",
  "pdf_page": "131–132",
  "statement_latex": "Example 3.1 Consider using velocity Verlet as the base second-order method to build a Yoshida fourth-order method from. As the scheme is second-order, we have $s=1$, and hence\n\\[\\tau_0=\\frac1{2-\\sqrt[3]2},\\qquad\\tau_1=-\\frac{\\sqrt[3]2}{2-\\sqrt[3]2}.\\]\nThe overall scheme is then three iterations of velocity Verlet, using stepsizes $\\tau_0h$, $\\tau_1h$ and $\\tau_0h$ respectively. We write this with subindices $\\alpha,\\beta$ to indicate the intermediate stages.\nYoshida fourth-order scheme (velocity Verlet):\n\\[\\begin{aligned}P_\\alpha&:=p-(\\tau_0h/2)\\nabla U(q),&Q_\\alpha&:=q+(\\tau_0h)M^{-1}P_\\alpha,\\\\\nP_\\alpha&:=P_\\alpha-(\\tau_0h/2)\\nabla U(Q_\\alpha),&P_\\beta&:=P_\\alpha-(\\tau_1h/2)\\nabla U(Q_\\alpha),\\\\\nQ_\\beta&:=Q_\\alpha+(\\tau_1h)M^{-1}P_\\beta,&P_\\beta&:=P_\\beta-(\\tau_1h/2)\\nabla U(Q_\\beta),\\\\\nP&:=P_\\beta-(\\tau_0h/2)\\nabla U(Q_\\beta),&Q&:=Q_\\beta+(\\tau_0h)M^{-1}P,\\\\\nP&:=P-(\\tau_0h/2)\\nabla U(Q).\\end{aligned}\\tag{3.8}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "三次速度Verlet与每次kick-drift-kick九阶段完全相同；算法名fourth-order，实际阶结论仍在YoshidaRaiseOrder且未证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshida4",
  "reusable_proofs": [],
  "extra_assumptions": [
    "M为固定对角质量；不假设正反步骤的实际无限时域流存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```

### MD-3.3.3-Yoshida4Structure
```json
{
  "source_id": "MD-3.3.3-Yoshida4Structure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.3.3",
  "printed_page": "110",
  "pdf_page": "132",
  "statement_latex": "Yoshida fourth-order scheme (velocity Verlet)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页九阶段(3.8)全文见Yoshida4；p.109/PDF131的对称三次辛复合；本条只列辛性和反步对称，不假冒已证4阶。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.yoshida4Structure",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.yoshida4Structure_proved"
  ],
  "extra_assumptions": [
    "U全域C²；真实kick/drift及三次回文复合。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem yoshida4Structure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (yoshida4 m U h)) ∧ (∀ h z, yoshida4 m U (-h) (yoshida4 m U h z)=z)
```

### MD-3.3.3-GeneralSplitting
```json
{
  "source_id": "MD-3.3.3-GeneralSplitting",
  "kind": "definition",
  "label": null,
  "section": "3.3.3",
  "printed_page": "111",
  "pdf_page": "133",
  "statement_latex": "We can view the Suzuki-Yoshida methods as one type of general composition scheme [260, 277, 326]:\n\\[\\mathcal F_h=\\exp(\\alpha_1h\\mathcal L_T)\\circ\\exp(\\beta_1h\\mathcal L_U)\\circ\\exp(\\alpha_2h\\mathcal L_T)\\circ\\exp(\\beta_2h\\mathcal L_U)\\circ\\cdots\\circ\\exp(\\alpha_kh\\mathcal L_T)\\circ\\exp(\\beta_kh\\mathcal L_U).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "有限有序列表(αᵢ,βᵢ)，foldr保持展示的复合次序；T,U参数为给定实际部分流，不由exp记号宣称存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.generalSplitting",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def generalSplitting {E : Type*} (T U : ℝ → E → E) (coeff : List (ℝ × ℝ)) (h : ℝ) : E → E :=
  coeff.foldr (fun ab acc => T (ab.1*h) ∘ U (ab.2*h) ∘ acc) id
```

