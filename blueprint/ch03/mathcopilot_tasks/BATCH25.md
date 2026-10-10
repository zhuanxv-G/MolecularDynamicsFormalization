# BATCH25 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.7.2-CollisionQuadraticPath
```json
{
  "source_id": "MD-3.7.2-CollisionQuadraticPath",
  "kind": "definition",
  "label": "(3.18)",
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "The idea is to make use of the quadratic\n\\[Q(t)=q+tM^{-1}p-\\frac{t^2}{2}M^{-1}\\nabla U(q)\\tag{3.18}\\]\nwhich represents the position vector obtained from a Verlet step of size $t$. Note that this defines quadratic paths for all particles in the system.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=−grad U代入一般Force函数；t²/2实际有限多项式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionQuadraticPath",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def collisionQuadraticPath {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) (t : ℝ) : Q n :=
  z.1+t • invMass m z.2+(t^2/2) • invMass m (F z.1)
```

### MD-3.7.2-CollisionTimeRelation
```json
{
  "source_id": "MD-3.7.2-CollisionTimeRelation",
  "kind": "definition",
  "label": "(3.19)",
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "It is then possible to calculate the collision times by solving equations\n\\[\\|Q_i(t)-Q_j(t)\\|=\\sigma_i+\\sigma_j,\\qquad i\\ne j.\\tag{3.19}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "a=Qi,b=Qj,radius=σi+σj；关系列出所有正候选根；下一次最小根与横截资格由方法声明单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionTimeRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def collisionTimeRelation {d : ℕ} (a b : ℝ → Position d) (radius t : ℝ) : Prop := 0 < t ∧ ‖a t-b t‖=radius
```

### MD-3.7.2-CollisionQuartic
```json
{
  "source_id": "MD-3.7.2-CollisionQuartic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "If the Verlet method is used, then it turns out that the insertion of (3.18) into (3.19) results in a quartic polynomial that must be solved for each particle pair.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "a=qᵢ−qⱼ,b=vᵢ−vⱼ,c=(M⁻¹Fᵢ−M⁻¹Fⱼ)/2；完整四次系数及norm等价，不假设其根存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionQuartic",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.collisionQuartic_proved"
  ],
  "extra_assumptions": [
    "radius≥0保证平方不引入负半径伪根；四次最高系数可退化，degree≤4。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem collisionQuartic :
  ∀ (d : ℕ) (a b c : Position d) (R t : ℝ), 0 ≤ R →
    (‖a+t • b+t^2 • c‖=R ↔
      inner ℝ c c*t^4+2*inner ℝ b c*t^3+(inner ℝ b b+2*inner ℝ a c)*t^2+
        2*inner ℝ a b*t+inner ℝ a a-R^2=0)
```

### MD-3.7.2-CollisionalVerletRelation
```json
{
  "source_id": "MD-3.7.2-CollisionalVerletRelation",
  "kind": "definition",
  "label": null,
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "Collisional Verlet Algorithm (CVA) [Single Step]\n[computes $h$ (the timestep) and $(Q,P)$ given a starting point $(q,p)$]\nCalculate $\\tau_c$ the time of next collision from the Verlet paths (quadratics) of (3.18) using collision conditions (3.19).\nIf $\\tau_c<h_{\\max}$, then\n\\[h:=\\tau_c,\\qquad(Q,P):=R_c\\mathcal G_h^{\\mathrm{Verlet}}(q,p)\\]\nelse\n\\[h:=h_{\\max},\\qquad(Q,P):=\\mathcal G_h^{\\mathrm{Verlet}}(q,p).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际方法关系保持严格tc<hmax；tc=hmax时原算法不反射，随后顺序/资格疑点保留。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "tc=hmax边界时原伪代码不反射，之后的二阶陈述排除此边界，不能冒充一般结果。"
    }
  ],
  "lean_decl": "MD.Ch03.collisionalVerletRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "tc>0,hmax>0明示；tc必须是下一接触时刻，求根实现不是数学定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def collisionalVerletRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z
```

### MD-3.7.2-CollisionalVerletOrder
```json
{
  "source_id": "MD-3.7.2-CollisionalVerletOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.2",
  "printed_page": "135",
  "pdf_page": "157",
  "statement_latex": "A step can then be taken to the first point of subsequent collision, with positions updated using the quadratic and momenta adjusted according to the Verlet map combined with $R_c$. In this way, all steps taken are Verlet steps so the order of accuracy is two. Effectively, this is a Verlet method with variable timestep chosen to match collision times.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "同时间全相空间误差与时间对齐、tc=hmax边界、隔离接触资格需裁定。"
    }
  ],
  "lean_decl": "MD.Ch03.collisionalVerletOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量、C∞势/接触函数、有限横截隔离事件、最小正接触根；自适应累计真实时间及O(hmax²)单调时间对齐；所有内部接触严格早于hmax，排除伪代码未反射的相等边界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem collisionalVerletOrder :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (tc : Z n → ℝ) (Rc : Z n → Z n) (G : ℝ → Z n → Z n),
    positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ g → 0 < τ →
    finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events →
    (∀ z, admissibleCollisionState m g z → 0 < tc z ∧
      g (collisionQuadraticPath m (fun x => -grad U x) z (tc z))=0 ∧
      ∀ t ∈ Ioo 0 (tc z), 0 < g (collisionQuadraticPath m (fun x => -grad U x) z t)) →
    (∀ z, Rc z=(z.1,z.2+(-2*(∑ i, grad g z.1 i*z.2 i/m i)/
      (∑ i, grad g z.1 i^2/m i)) • grad g z.1)) →
    (∀ h > 0, ∀ z, collisionalVerletRelation m (fun x => -grad U x) Rc (tc z) h (min (tc z) h) z (G h z)) →
    ∃ C > 0, ∃ δ > 0, ∀ hmax ∈ Ioo 0 δ, ∀ times : ℕ → ℝ,
      times 0=0 → (∀ j, times (j+1)=times j+min (tc (oneStepIterate G hmax (q 0,p 0) j)) hmax) →
      (∀ j, times j < τ → admissibleCollisionState m g (oneStepIterate G hmax (q 0,p 0) j) ∧
        tc (oneStepIterate G hmax (q 0,p 0) j) ≠ hmax) →
      ∃ θ : ℝ ≃o ℝ, θ 0=0 ∧ θ τ=τ ∧ (∀ t ∈ Icc 0 τ, |θ t-t| ≤ C*hmax^2) ∧
        ∀ j, times j ≤ τ →
          ‖oneStepIterate G hmax (q 0,p 0) j-(q (θ (times j)),p (θ (times j)))‖ ≤ C*hmax^2
```

