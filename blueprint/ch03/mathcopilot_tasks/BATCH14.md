# BATCH14 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.4-AnalyticDefect
```json
{
  "source_id": "MD-3.4-AnalyticDefect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "116",
  "pdf_page": "138",
  "statement_latex": "It is possible to prove (see discussions in [164, 227] for more detail), that for many standard classes of numerical methods, there are real, positive constants $C,D$ such that\n\\[\\|\\mathcal G_h(\\cdot)-\\mathcal F_h^{(k)}(\\cdot)\\|\\le Ch[D(k+1)h]^{k+1},\\]\ngiving a precise bound on the magnitude of the difference between the time $h$ evolution under the truncated perturbed Hamiltonian and the numerical method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal F_h^{(k)}$ is the actual truncated Hamiltonian flow, not a formal series."
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "many standard classes的精确方法类及解析邻域条件原文未给。"
    }
  ],
  "lean_decl": "MD.Ch03.analyticBEA",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原文many standard classes未明说正则性；显式H和联合步映射解析、原有smoothSymplecticData及紧域；全阶系数构造与指数截断仍为结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem analyticBEA :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r → AnalyticOnNhd ℝ H D →
    AnalyticOnNhd ℝ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-1:ℝ) 1 ×ˢ D) →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, AnalyticOnNhd ℝ (Hj j) D) ∧
    ∃ C > 0, ∃ A > 0, ∃ δ > 0,
      (∀ k ≥ r, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, A*((k+1:ℕ):ℝ)*h ≤ 1 → ∀ z ∈ B,
          truncatedFlow H Hj r k h z (Γ h z) ∧ (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧
          ‖G h z-Γ h z h‖ ≤ C*h*(A*((k+1:ℕ):ℝ)*h)^(k+1)) ∧
      ∃ γ > 0, ∃ κ : ℝ → ℕ, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, r ≤ κ h ∧
          ∀ z ∈ B, truncatedFlow H Hj r (κ h) h z (Γ h z) ∧
            ‖G h z-Γ h z h‖ ≤ C*h*Real.exp (-γ/h)
```

### MD-3.4-OptimalTruncation
```json
{
  "source_id": "MD-3.4-OptimalTruncation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "116",
  "pdf_page": "138",
  "statement_latex": "If $h$ is small, then for $k$ sufficiently small the quantity in brackets is less than one and the difference from the truncated approximation decreases in magnitude with increasing $k$. As soon as $k$ satisfies\n\\[k+1>\\frac1{Dh}\\]\nthe power grows monotonically without bound. We can minimize the difference between $\\mathcal G_h$ and $\\mathcal F_h^{(k)}$ by choosing\n\\[k=\\frac1{Dh\\mathrm e}-1,\\]\nin which case,\n\\[\\|\\mathcal G_h(\\cdot)-\\mathcal F_h^{(k)}(\\cdot)\\|<Ch\\mathrm e^{-\\gamma/h},\\qquad\\gamma=\\frac1{D\\mathrm e}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Lean k表示原文k+1的整数近似floor(1/(D e h))；本条只给括号幂的整数界，完整实际流指数缺陷在AnalyticDefect。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "连续最优k未必整数；Lean整数界不冒充原文全部连续最小化结论。"
    }
  ],
  "lean_decl": "MD.Ch03.optimalTruncation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "D>0；足够小正h；取整后允许独立正C吸收误差。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem optimalTruncation :
  ∀ A > 0, ∃ δ > 0, ∃ C > 0, ∀ h ∈ Ioo 0 δ,
    let k := Nat.floor (1/(A*Real.exp 1*h))
    0 < k ∧ (A*(k:ℝ)*h)^k ≤ C*Real.exp (-(1/(A*Real.exp 1))/h)
```

### MD-3.4-ExponentialFlat
```json
{
  "source_id": "MD-3.4-ExponentialFlat",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "116",
  "pdf_page": "138",
  "statement_latex": "This bound tends to zero extremely rapidly (more rapidly than any power of $h$) as $h\\to0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "上式$Ch\\exp(-\\gamma/h)$；对$\\exp(-\\gamma/h)/h^k$的极限给每个固定自然数k的更强标量结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.exponentialFlat",
  "reusable_proofs": [],
  "extra_assumptions": [
    "γ>0、h→0⁺；不声称只有C∞就有指数缺陷。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem exponentialFlat :
  ∀ γ > 0, ∀ k : ℕ, Tendsto (fun h : ℝ => Real.exp (-γ/h)/h^k) (𝓝[>] 0) (𝓝 0)
```

### MD-3.4-ScalarVerletShadow4
```json
{
  "source_id": "MD-3.4-ScalarVerletShadow4",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "117",
  "pdf_page": "139",
  "statement_latex": "The modified energy for the Verlet method for a single degree of freedom system with energy $H=p^2/2+U(q)$ is\n\\[\\widetilde H_h=H+\\frac{h^2}{24}(2p^2U''-(U')^2)\n+h^4\\left(\\frac1{720}p^4U''''-\\frac1{120}p^2U'U'''-\\frac1{240}(U')^2U''-\\frac1{60}p^2((U'')^2+U'U''')\\right)+O(h^6).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文脚注1；有限式只定义h⁴截断，O(h⁶)系数匹配和实际流余项不从定义证明，关联VerletModifiedMatching。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "O(h⁶)的实际修正匹配另为未完成理论；有限函数与余项分开。"
    }
  ],
  "lean_decl": "MD.Ch03.scalarVerletShadow4",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)
```

### MD-3.4-CommutingEnergy
```json
{
  "source_id": "MD-3.4-CommutingEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "117",
  "pdf_page": "139",
  "statement_latex": "Suppose that, somehow, $H$ were exactly conserved along the numerical solution, so\n\\[\\dot H=0\\Rightarrow\\{H,\\widetilde H_h\\}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "解释为由实际修正Hamiltonian流对全部初值守恒推出括号为零；离散快照守恒到连续修正流守恒不能无证混同。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "离散快照守恒不直接推出连续修正流守恒。"
    }
  ],
  "lean_decl": "MD.Ch03.commutingEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "H在开放D为C¹、实际K-Hamiltonian流存在正η且全轨道H守恒。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem commutingEnergy :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 H D → IsOpen D → actualFlow (textbookHamiltonianVectorField K) D Φ η →
    (∀ z ∈ D, ∀ t ∈ Ioo (-η) η, H (Φ t z)=H z) → ∀ z ∈ D, textbookPoissonBracket H K z=0
```

### MD-3.4-CommutingEnergySymmetry
```json
{
  "source_id": "MD-3.4-CommutingEnergySymmetry",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "118",
  "pdf_page": "140",
  "statement_latex": "Since $\\{g_1,g_2\\}=-\\{g_2,g_1\\}$, we have\n\\[\\{\\widetilde H_h,H\\}=0.\\]\nThis would imply that $\\widetilde H_h$ is actually, itself, a first integral of the molecular system.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "K=H̃_h是实际C¹函数；只给已经有{H,K}=0后的独立条件推论，不声称修正无穷级数收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.commutingEnergySymmetry",
  "reusable_proofs": [],
  "extra_assumptions": [
    "开放D、K为C¹、实际H流存在正η。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem commutingEnergySymmetry :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 K D → IsOpen D → actualFlow (textbookHamiltonianVectorField H) D Φ η →
    (∀ z ∈ D, MolecularDynamics.textbookPoissonBracket H K z=0) →
      (∀ z ∈ D, MolecularDynamics.textbookPoissonBracket K H z=0) ∧ ∀ z ∈ D, ∀ t ∈ Ioo (-η) η, K (Φ t z)=K z
```

### MD-3.4-EnergySymplecticNoGo
```json
{
  "source_id": "MD-3.4-EnergySymplecticNoGo",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.4",
  "printed_page": "118",
  "pdf_page": "140",
  "statement_latex": "This certainly seems unlikely to hold except in very special cases indeed, unless the numerical method happens to coincide with the exact solution (up to a time rescaling). Thus the properties of symplecticness and energy conservation for numerical methods are essentially mutually exclusive from a practical point of view. A more precise formulation of this result was first given by Ge and Marsden [400].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "原文practical排他陈述缺精确非可积性/无额外第一积分等假设。"
    }
  ],
  "lean_decl": "MD.Ch03.energySymplecticNoGo",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]noExtraIntegrals明确所有光滑第一积分是H的函数；开放D、全光滑实际流与近恒等辛方法；该强资格原文未列。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem energySymplecticNoGo :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ H D → noExtraIntegrals H D →
    actualFlow (textbookHamiltonianVectorField H) D Φ η →
    ContDiff ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2) →
    (∀ z ∈ D, G 0 z=z) → (∀ h ∈ Ioo (-η) η, IsTextbookSymplecticMap (G h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, H (G h z)=H z) →
    ∃ δ > 0, ∃ τ : ℝ → ℝ → ℝ, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ D, G h z=Φ (τ h (H z)) z
```

