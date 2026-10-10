# BATCH23 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.7-HardCoreDomain
```json
{
  "source_id": "MD-3.7-HardCoreDomain",
  "kind": "definition",
  "label": null,
  "section": "3.7",
  "printed_page": "132",
  "pdf_page": "154",
  "statement_latex": "We assume, as usual a Hamiltonian $H=p^TM^{-1}p/2+U(q)$ but we add the inequality constraint $\\|q_i-q_j\\|\\ge\\sigma_i+\\sigma_j$ where $\\sigma_i$, $i=1,\\ldots,N$ is a core radius. The condition $\\|q_i-q_j\\|=\\sigma_i+\\sigma_j$, some $i,j$ defines the constraint surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "i≠j明确；接触等号允许，不当重叠。σ作为半径通常非负。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hardCoreDomain",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
```

### MD-3.7-ElasticReflection
```json
{
  "source_id": "MD-3.7-ElasticReflection",
  "kind": "definition",
  "label": null,
  "section": "3.7",
  "printed_page": "132",
  "pdf_page": "154",
  "statement_latex": "When the particles are not touching, they move along Newtonian paths defined by the standard equations of motion. At impact, they exchange momentum and energy according to the rules of elastic collision. Specifically, at the point of contact, the momentum vectors of the two spheres are adjusted according to the rule:\n\\[p:=p+\\alpha u_\\perp\\]\nwhere $u_\\perp$ is normal to the constraint surface and $\\alpha$ is a parameter chosen to maintain the conservation of energy.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "在完整配置动量空间写一般质量法向反射；不把定义当K守恒证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.elasticReflection",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]选取质量度量反射α=−2Σuᵢpᵢ/mᵢ ÷ Σuᵢ²/mᵢ，具体α原书在障碍特例p134给出；正质量/非零法向是后条守恒资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def elasticReflection {n : ℕ} (m : Fin n → ℝ) (u p : Position n) : Position n := p+elasticCoefficient m u p • u
```

### MD-3.7-ElasticEnergy
```json
{
  "source_id": "MD-3.7-ElasticEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7",
  "printed_page": "132",
  "pdf_page": "154",
  "statement_latex": "where $u_\\perp$ is normal to the constraint surface and $\\alpha$ is a parameter chosen to maintain the conservation of energy.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.elasticEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量、u≠0，α取前条实际质量度量反射值；碰撞时位置不变，K守恒即总能量守恒。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem elasticEnergy :
  ∀ (n : ℕ) (m : Fin n → ℝ) (u p : Position n), positiveMass m → u ≠ 0 →
    kinetic m (elasticReflection m u p)=kinetic m p ∧
      (∑ i, u i*elasticReflection m u p i/m i)=-(∑ i, u i*p i/m i)
```

### MD-3.7-CollisionComposition
```json
{
  "source_id": "MD-3.7-CollisionComposition",
  "kind": "definition",
  "label": null,
  "section": "3.7",
  "printed_page": "132–133",
  "pdf_page": "154–155",
  "statement_latex": "Let $R_c$ denote the action of the collision operator on the vector of positions and momenta. Then we can write the evolution formally as\n\\[\\mathcal F_\\tau^{\\mathrm{h.s.}}(q,p)=\\mathcal G_{\\Delta\\tau_r}\\circ R_c\\circ\\mathcal G_{\\Delta\\tau_{r-1}}\\cdots\\circ R_c\\circ\\mathcal G_{\\Delta\\tau_0}\\]\nwhere $\\Delta\\tau_1,\\Delta\\tau_2,\\ldots,\\Delta\\tau_{r-1}$ are the times between collisions, $\\Delta\\tau_0$ is the time until the first collision, and $\\Delta\\tau_r$ is the time between the last collision and $\\tau$. Here $\\mathcal G_t$ is the flow map of the smooth system (Hamiltonian $H$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "有限事件序列，实际右到左流/反射复合；不宣称任意多重或无限碰撞解存在唯一。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionComposition",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def collisionComposition {E : Type*} (G : ℝ → E → E) (Rc : E → E) (times : List ℝ) : E → E :=
  match times with
  | [] => id
  | [t] => G t
  | t::u::ts => G t ∘ Rc ∘ collisionComposition G Rc (u::ts)
termination_by times.length
```

### MD-3.7-CollisionRegularity
```json
{
  "source_id": "MD-3.7-CollisionRegularity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "The trajectory is thus piecewise smooth with continuous configurational path and momenta exhibiting finite jump discontinuities.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionRegularity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "有限严格递增隔离时刻、相邻实际光滑ODE段、碰撞接触处位置匹配和真实法向动量跳跃；不把拼接后连续或光滑结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem collisionRegularity :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) (g : Q n → ℝ)
    (times : ℕ → ℝ) (segments : ℕ → ℝ → Z n) ν,
    positiveMass m → ContDiff ℝ ⊤ F → concatenatedCollisionSegments m F g times segments ν →
    ContinuousOn (fun t => (gluedCollision times segments ν t).1) (Icc (times 0) (times (ν+1))) ∧
    (∀ j ≤ ν, ∀ t ∈ Ioo (times j) (times (j+1)),
      ContDiffAt ℝ ⊤ (fun t => (gluedCollision times segments ν t).2) t) ∧
    (∀ j < ν, Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[<] (times (j+1))) (𝓝 ((segments j (times (j+1))).2)) ∧
      Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[>] (times (j+1))) (𝓝 ((segments (j+1) (times (j+1))).2)))
```

