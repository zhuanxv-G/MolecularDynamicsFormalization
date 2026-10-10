# BATCH24 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.7.1-HardCorePotential
```json
{
  "source_id": "MD-3.7.1-HardCorePotential",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "Splitting methods are suggested by considering a formal hard-sphere Hamiltonian\n\\[H_{\\mathrm{h.s.}}=p^TM^{-1}p/2+U(q)+U_{\\mathrm{h.s.}},\\]\nwhere $U_{\\mathrm{h.s.}}$ is assumed to be infinite for overlapping configurations (some $\\|q_i-q_j\\|\\le\\sigma_i+\\sigma_j$) and zero otherwise.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p133括号印刷≤与p132接触等号允许冲突；不静默改成<。"
    }
  ],
  "lean_decl": "MD.Ch03.hardCorePotential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  @ite ENNReal (q ∈ hardCoreDomain σ) (Classical.propDecidable _) 0 ⊤
```

### MD-3.7.1-PrimitiveSplitting
```json
{
  "source_id": "MD-3.7.1-PrimitiveSplitting",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "One approach is to consider the splitting $H=H_{\\mathrm{free}}+U$, evolving $H_{\\mathrm{free}}$ for fixed intervals punctuated by impulses derived from the smooth potential $U$. In [40, 184] this algorithm is termed the “Primitive Splitting Algorithm” and can be described by the three steps:\n\\[P:=p-\\frac h2\\nabla U(q),\\qquad(Q,P):=\\mathcal G_h^{\\mathrm{free}}(q,P),\\qquad P:=P-\\frac h2\\nabla U(Q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Gfree给定真实自由硬球演化，数学复合而非求根/并行算法实现；不由定义证明Gfree存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.primitiveSplitting",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def primitiveSplitting {n : ℕ} (U : Q n → ℝ)
    (Gfree : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ) :=
  textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ Gfree h ∘ textbookMomentumKick (textbookPotentialForce U) (h/2)
```

### MD-3.7.1-PrimitiveOrder
```json
{
  "source_id": "MD-3.7.1-PrimitiveOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.1",
  "printed_page": "133–134",
  "pdf_page": "155–156",
  "statement_latex": "Even with this symmetric form (“kick”, “drift”, “kick”) where “drift” now involves the solution of the system $H_{\\mathrm{free}}$, it was shown in [184] that energy accumulates rapidly. Assuming a finite number of collisions on a fixed interval, the error behaves as $O(h)$. In long simulations the energy error grows without bound.\nIn general, because an error of size $O(h)$ occurs in each collision and there are a finite number of collisions in a fixed time interval, the total error is also $O(h)$, i.e. first order.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "时间对齐误差度量、有限单接触资格及长期energy无界的量化均需审。"
    }
  ],
  "lean_decl": "MD.Ch03.primitiveOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量、C∞势/接触函数、有限横截隔离单接触、真实freeCollisionFlow；采用O(h)单调时间对齐以比较跳跃动量，不假设结论误差界。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem primitiveOrder :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (Gfree : ℝ → Z n → Z n)
    (q p : ℝ → Q n) τ events,
    positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ g → 0 < τ →
    finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events → freeCollisionFlow m g Gfree →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 1
```

### MD-3.7.1-ObstacleReflection
```json
{
  "source_id": "MD-3.7.1-ObstacleReflection",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "134",
  "pdf_page": "156",
  "statement_latex": "The coefficient $\\alpha$ is chosen so that the kinetic energy is conserved through collision, thus\n\\[\\alpha=-2\\frac{u_\\perp\\cdot\\overline P}{u_\\perp\\cdot u_\\perp}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "质量=1，u=qc非零；本定义是p+αu的实际函数，能量性质关联ElasticEnergy。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.obstacleReflection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
```

### MD-3.7.1-PrimitiveDefect
```json
{
  "source_id": "MD-3.7.1-PrimitiveDefect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.1",
  "printed_page": "134",
  "pdf_page": "156",
  "statement_latex": "We next calculate the change in energy in a single step by inserting $Q$ and $P$ into the Hamiltonian and expanding around the point of collision $q_c$, obtaining\n\\[\\Delta H\\stackrel{\\mathrm{def}}=H(Q,P)-H(q,p)=-(h-2\\tau_c)\\frac{q_c^T\\overline P}{q_c^Tq_c}q_c^T\\nabla U(q_c)+O(h^2).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "书中P̄与签名初始pbar的差异及通过O(h²)吸收的正则性需要独立审校。"
    }
  ],
  "lean_decl": "MD.Ch03.primitiveDefect",
  "reusable_proofs": [],
  "extra_assumptions": [
    "C³势、固定非零qc、真实初末碰撞步族和0<tc(h)<h；O(h²)以小正h的一致界表示。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem primitiveDefect :
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ),
    ContDiff ℝ 3 U → qc ≠ 0 →
    (∀ h > 0, 0 < tc h ∧ tc h < h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))+
        (h-2*tc h)*(inner ℝ qc pbar/inner ℝ qc qc)*inner ℝ qc (gradient U qc)| ≤ C*h^2
```

### MD-3.7.1-CollisionDefectZero
```json
{
  "source_id": "MD-3.7.1-CollisionDefectZero",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.1",
  "printed_page": "134",
  "pdf_page": "156",
  "statement_latex": "• the collision occurs at the middle of the timestep, $\\tau_c=h/2$,\n• the directional derivative of $U$ along the collision vector $(u_\\perp=q_c)$ vanishes, or\n• the momentum vector is orthogonal to the collision vector at the point of contact.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只给上式线性系数在这三个条件下为0，保留O(h²)，不由零系数推出三阶；no collision/end-step两条另见EndImpactThirdOrderPrinted。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionDefectZero",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.collisionDefectZero_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem collisionDefectZero :
  ∀ h tc a b c : ℝ, (h=2*tc ∨ a=0 ∨ c=0) → (h-2*tc)*(a/b)*c=0
```

### MD-3.7.1-EndImpactThirdOrderPrinted
```json
{
  "source_id": "MD-3.7.1-EndImpactThirdOrderPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.1",
  "printed_page": "134",
  "pdf_page": "156",
  "statement_latex": "In cases (i) and (ii) it is clear that the error accumulating in a single step will be third order in the stepsize, since the Verlet method has local error of order three (since it is a second order method).\n• there is no collision\n• the collision occurs at the end of a timestep",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留(ii)tc=h、原primitive末端反射及最后half-kick的真实步族；无碰撞的Verlet局部三阶在第2章已另述。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原文end-step豁免与同页−(h−2tc)线性项冲突；具体单位障碍反例见审计。"
    }
  ],
  "lean_decl": "MD.Ch03.endImpactThirdOrderPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem endImpactThirdOrderPrinted :
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ),
    ContDiff ℝ 3 U → qc ≠ 0 →
    (∀ h > 0, tc h = h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))| ≤ C*h^3
```

### MD-3.7.1-FreeHardSphereHamiltonian
```json
{
  "source_id": "MD-3.7.1-FreeHardSphereHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "The hard sphere system described by\n\\[H_{\\mathrm{free}}=p^TM^{-1}p/2+U_{\\mathrm{h.s.}}\\]\nconsists of purely ballistic (straight line) motion punctuated by momentum jumps.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "位置不接触时自由ODE为q′=M⁻¹p,p′=0；事件复合与真实动量反射在CollisionComposition/CollisionRegularity/ElasticEnergy保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.freeHardSphereHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量下用WithTop ℝ保留有限动能和+∞障碍；沿用p132接触允许的边界，p133≤疑点仍由HardCorePotential保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def freeHardSphereHamiltonian {N d : ℕ} (m σ : Fin N → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  @ite (WithTop ℝ) (q ∈ MolecularDynamics.Chapter03Review.hardCoreDomain σ)
    (Classical.propDecidable _) ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ) ⊤
```

