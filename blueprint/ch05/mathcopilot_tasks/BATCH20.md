# BATCH20 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.4.1-AnisotropicAxisPrinted
```json
{
  "source_id": "MD-5.4.1-AnisotropicAxisPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "201",
  "pdf_page": "222",
  "statement_latex": "Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\\le x\\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\\dot x=0$, $\\dot y=[2(E_0-U(x,0))]^{1/2}$. The set $y=0$, $\\dot y=0$ is invariant under the differential equations of the perturbed central force problem, since the force acts in the radial direction; our choice of initial conditions ensures that trajectories explore the larger $H=E_0$ energy surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.anisotropicAxisPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem anisotropicAxisPrinted : ∀ (κ l ε : ℝ) (z : ℝ → MolecularDynamics.Chapter05Review.Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0
```

### MD-5.4.1-TwoOscillatorEnergyDecomposition
```json
{
  "source_id": "MD-5.4.1-TwoOscillatorEnergyDecomposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "199",
  "pdf_page": "220",
  "statement_latex": "On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorEnergyDecomposition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]包括c_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem twoOscillatorEnergyDecomposition : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : MolecularDynamics.Chapter05Review.E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i)
```

### MD-5.4.1-CurveImageDimension
```json
{
  "source_id": "MD-5.4.1-CurveImageDimension",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "202",
  "pdf_page": "223",
  "statement_latex": "The segment of initial conditions, a one-dimensional object, when transformed by the smooth map defined by solving initial value problems, should result, again, in a one-dimensional object, i.e. a curve. Yet it appears also to provide a dense covering of a two-dimensional region in the position projection.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.curveImageDimension",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem curveImageDimension : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (γ : ℝ → MolecularDynamics.Chapter05Review.E n),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ ⊤ (Function.uncurry Φ) → ContDiff ℝ ⊤ γ →
  (∀ s,deriv γ s ≠ 0) → ∀ t,
  ContDiff ℝ ⊤ (fun s => Φ t (γ s)) ∧ (∀ s,deriv (fun r => Φ t (γ r)) s ≠ 0)
```

### MD-5.4.1-PendulumPotential
```json
{
  "source_id": "MD-5.4.1-PendulumPotential",
  "kind": "definition",
  "label": "Example 5.5",
  "section": "5.4.1",
  "printed_page": "200",
  "pdf_page": "221",
  "statement_latex": "Example 5.5 (Double Pendulum) To explore some of the issues related to ergodicity, let us return to the double pendulum considered in Chap. 3.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本条为第5章引用对象的本地定义；不改变已完成第3章文件。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.pendulumPotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : MolecularDynamics.Chapter05Review.E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2
```

### MD-5.4.1-PendulumRegionPrinted
```json
{
  "source_id": "MD-5.4.1-PendulumRegionPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "200",
  "pdf_page": "221",
  "statement_latex": "For given positive values of the coefficients, the region swept out in the plane by trajectories can be seen to be a union of intersections of pairs of disks centered at the origin and $(0,-2)$, with radii $r_1,r_2$ respectively, which themselves represent a point on an ellipse in the first quadrant. Determining the boundary of this region analytically is difficult but it is easy to find it numerically. For the special case $k_1=k_2=2$, $l_1=l_2=1$, and $E=4$ that the projected region covered by positions at this energy is the interior of the level set $U=E$ shown as a dark oval curve in the three panels of Fig. 5.4.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.pendulumRegionPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem pendulumRegionPrinted : ∀ k₁ k₂ l₁ l₂ c : ℝ,
  0 < k₁ → 0 < k₂ → 0 < l₁ → 0 < l₂ → 0 < c →
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ p : MolecularDynamics.Chapter05Review.E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c}=
  {q : MolecularDynamics.Chapter05Review.E 2 | ∃ r₁ > 0,∃ r₂ > 0,
    k₁/2*(r₁-l₁)^2+k₂/2*(r₂-l₂)^2=c ∧
    Real.sqrt ((q 0)^2+(q 1)^2) ≤ r₁ ∧ Real.sqrt ((q 0)^2+(q 1+2)^2) ≤ r₂}
```

### MD-5.4.1-AnisotropicInitialCurve
```json
{
  "source_id": "MD-5.4.1-AnisotropicInitialCurve",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "201",
  "pdf_page": "222",
  "statement_latex": "Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\\le x\\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\\dot x=0$, $\\dot y=[2(E_0-U(x,0))]^{1/2}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际位置及动量随x参数化，单位质量；区间Icc(105/100)(115/100)与根号非负资格在使用条目保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.anisotropicInitialCurve",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def anisotropicInitialCurve (κ l ε c x : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![0,Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))])
```

### MD-5.4.1-AnisotropicInitialEnergy
```json
{
  "source_id": "MD-5.4.1-AnisotropicInitialEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "201",
  "pdf_page": "222",
  "statement_latex": "For each point $(x,0)$ taken from this set select the initial velocities as $\\dot x=0$, $\\dot y=[2(E_0-U(x,0))]^{1/2}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.anisotropicInitialEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem anisotropicInitialEnergy : ∀ κ l ε c x : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := anisotropicInitialCurve κ l ε c x
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c
```

### MD-5.4.1-InitialSegmentPrinted
```json
{
  "source_id": "MD-5.4.1-InitialSegmentPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "201",
  "pdf_page": "222",
  "statement_latex": "The set of initial conditions forms a line segment in the four-dimensional phase space.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.initialSegmentPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem initialSegmentPrinted : ∀ κ l ε c : ℝ,
  (∀ x ∈ Icc (105/100 : ℝ) (115/100),0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])) →
  ∃ a b : MolecularDynamics.Chapter05Review.Phase 2,anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)=segment ℝ a b
```

