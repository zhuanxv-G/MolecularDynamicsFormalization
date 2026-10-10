# BATCH26 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.7.3-PairForceDecoupling
```json
{
  "source_id": "MD-3.7.3-PairForceDecoupling",
  "kind": "definition",
  "label": null,
  "section": "3.7.3",
  "printed_page": "136",
  "pdf_page": "158",
  "statement_latex": "This can be achieved in systems of spheres with pair potentials $\\varphi_{ij}$ only by writing $\\varphi_{ij}=\\alpha_{ij}+\\beta_{ij}$ where the derivative of the second term is chosen to vanish at the point of contact between the spheres, i.e. $\\alpha'_{ij}(\\sigma_i+\\sigma_j)=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "“second term”与α′接触为0不一致；不静默改为β′。"
    }
  ],
  "lean_decl": "MD.Ch03.pairForceDecoupling",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def pairForceDecoupling (φ α β : ℝ → ℝ) (contact : ℝ) : Prop :=
  (∀ r, φ r=α r+β r) ∧ deriv α contact=0
```

### MD-3.7.3-DecoupledOrder
```json
{
  "source_id": "MD-3.7.3-DecoupledOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.3",
  "printed_page": "136",
  "pdf_page": "158",
  "statement_latex": "The idea is to exploit the observation that impulsive forces (“kicks”) can be supplied without reducing the order of accuracy as long as these have a vanishing component in the direction of the collision vector $u_\\perp$, that is if $F_\\perp=-\\nabla U(q_c)\\cdot u_\\perp=0$.\nIf this decomposition is used, then it is possible to build a 2nd order accurate hybrid method that uses only the first part $\\alpha$ to define the quadratic Verlet paths for the collision detection scheme, whereas $\\beta$ is introduced as a standard “kick” at collision points.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "结合PairForceDecoupling，哪个势负责零法向kick需导师判定。"
    }
  ],
  "lean_decl": "MD.Ch03.decoupledOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "以U表示真正kick势并要求它在接触法向导数0；另一V用于碰撞子流；正质量、有限横截隔离事件与时间对齐误差。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem decoupledOrder :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U V g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (Gfree : ℝ → Z n → Z n), positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ V →
    ContDiff ℝ ⊤ g → 0 < τ →
    (∀ x, g x=0 → ∑ i, grad g x i*invMass m (grad U x) i=0) →
    finiteCollisionTrajectory m (fun x => -grad U x-grad V x) g q p 0 τ events →
    (∀ z, 0 ≤ g z.1 → ∀ T > 0, ∃ ev, Gfree 0 z=z ∧
      finiteCollisionTrajectory m (fun x => -grad V x) g
        (fun t => (Gfree t z).1) (fun t => (Gfree t z).2) 0 T ev) →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 2
```

### MD-3.7.3-ModifiedCollisionProjection
```json
{
  "source_id": "MD-3.7.3-ModifiedCollisionProjection",
  "kind": "definition",
  "label": null,
  "section": "3.7.3",
  "printed_page": "136",
  "pdf_page": "158",
  "statement_latex": "In particular, one may use the backward error analysis to obtain a modified Hamiltonian $\\widetilde H_h$ corresponding to the Verlet method with stepsize $h$, then to project during collisions not onto the energy surface, but onto the modified energy surface, so that\n\\[\\widetilde H_h=\\mathrm{const}.\\]\n(In practice, a low order approximation of $\\widetilde H_h$ is used, such as the truncation to terms of order four or six in the stepsize.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原书实际使用有限截断；关系只要求起点终点有同一截断值，不证明投影存在/唯一、不供应BEA或统计准确。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.modifiedCollisionProjection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def modifiedCollisionProjection {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ) (h : ℝ)
    (z w : SymplecticCoordinates n) : Prop :=
  textbookTruncatedHamiltonian H Hj r k h w=textbookTruncatedHamiltonian H Hj r k h z
```

