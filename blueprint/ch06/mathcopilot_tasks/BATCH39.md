# BATCH39 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.4-LangevinNoiseBracket
```json
{
  "source_id": "MD-6.4.4-LangevinNoiseBracket",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "For $i=1,\\ldots,N_c$, using the fact that $b_i$ is a constant vector field and so its Jacobian matrix vanishes,\n\\[[b_0,b_i]=-\\begin{bmatrix}0&I\\\\-U''(q)&-\\gamma I\\end{bmatrix}b_i\n=-\\sigma\\begin{bmatrix}e_i\\\\-\\gamma e_i\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinNoiseBracket",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinDrift_noise_bracket"
  ],
  "extra_assumptions": [
    "[EXTRA]真实C²势的Fréchet Jacobian、全部噪声坐标；σ任意，非零条件在独立性条明确。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinNoiseBracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1)
```

### MD-6.4.4-LangevinBracketIndependent
```json
{
  "source_id": "MD-6.4.4-LangevinBracketIndependent",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "These $N_c$ vectors, taken together with the original $b_i$, clearly provide a linearly independent set of $2N_c$ vectors.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinBracketIndependent",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinBracketFamily_linearIndependent"
  ],
  "extra_assumptions": [
    "[EXTRA]真实Fin Nc⊕Fin Nc的全部2Nc向量族、σ≠0；不以维数计数代替独立性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinBracketIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ)
```

### MD-6.4.4-LangevinHormander
```json
{
  "source_id": "MD-6.4.4-LangevinHormander",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "We have verified Hörmander's condition. Thus Assumption 1(ii) holds in the case of Langevin dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinHormander",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevin_hormander_physicalNoise"
  ],
  "extra_assumptions": [
    "[EXTRA]完整物理σ=√(2γθ)、γ/θ>0、C∞ U的实际噪声及括号span；本桥只证rank，转移密度存在另条未证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinHormander {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z
```

### MD-6.4.4-LangevinTransitionDensity
```json
{
  "source_id": "MD-6.4.4-LangevinTransitionDensity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "Thus Assumption 1(ii) holds in the case of Langevin dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinTransitionDensity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]具体实际单位周期Langevin、C∞势、正γ/β，全部点初值的正时间连续转移密度及真实平坦相空间测度表示；没有从含drift的任意原Definition6.1断言一般parabolic密度定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinTransitionDensity :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n
```

### MD-6.4.4-Lemma61Printed
```json
{
  "source_id": "MD-6.4.4-Lemma61Printed",
  "kind": "unnumbered_claim",
  "label": "Lemma 6.1",
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "Lemma 6.1 For all $t>0$ and all open $C\\subset D$, we have that\n\\[\\Pr(X(t)\\in C\\mid X(0)=X_0)>0,\\quad\\forall X_0\\in D,\\]\nwhere $X(t)=(q(t),p(t))^T$ is a solution to Langevin dynamics (6.47).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "字面all open C包括空集，概率为0；需Nonempty。原(6.47)单位质量，旧清单一般质量扩展须另标技术范围。"
    }
  ],
  "lean_decl": "MD.Ch06.lemma61Printed",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lemma61Printed :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (γ β : ℝ) (x0 : MolecularDynamics.Chapter06Review.Phase n) (X : ℝ → Ω → MolecularDynamics.Chapter06Review.Phase n),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  0 < γ → 0 < β → MolecularDynamics.Chapter06Review.langevinMassSDE P (fun t sample ↦ B t.toNNReal sample) X m U γ β⁻¹ x0 →
  (∀ t : ℝ, 0 ≤ t → AEMeasurable (X t) P) →
  ∀ t : ℝ, 0 < t → ∀ C : Set (MolecularDynamics.Chapter06Review.Phase n), IsOpen C → 0 < P {sample | X t sample ∈ C}
```

### MD-6.4.4-Lemma61Nonempty
```json
{
  "source_id": "MD-6.4.4-Lemma61Nonempty",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "\\[\\Pr(X(t)\\in C\\mid X(0)=X_0)>0,\\quad\\forall X_0\\in D.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.lemma61Nonempty",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos"
  ],
  "extra_assumptions": [
    "[EXTRA]补非空目标；桥接实际单位周期相空间、原单位质量、真实Wiener/实际完整Langevin核，σ≠0。原一般质量扩大版不计已证。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lemma61Nonempty {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C
```

### MD-6.4.4-ControlPath
```json
{
  "source_id": "MD-6.4.4-ControlPath",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "Consider the ODE\n\\[\\frac{d^2q}{dt^2}+\\nabla U(q)+\\gamma\\frac{dq}{dt}=\\sigma\\frac{dR}{dt}.\\tag{6.49}\\]\nChoose $q$ to be a $C^\\infty$ path such that for a given $t>0$,\n\\[(q(0),\\dot q(0))^T=X_0;\\quad(q(t),\\dot q(t))^T=y.\\]\nTaking $R(0)=0$, we can obtain a $C^\\infty$ function $dR/dt$ by substitution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.controlPath",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinControlledEndpoint"
  ],
  "extra_assumptions": [
    "[EXTRA]完整实际任意位置/速度端点、q/p/R全光滑、R0=0及真实全时ODE；σ≠0，未冒充随机正概率。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem controlPath {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t
```

### MD-6.4.4-ControlEndpointStable
```json
{
  "source_id": "MD-6.4.4-ControlEndpointStable",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "256",
  "pdf_page": "277",
  "statement_latex": "For any $\\delta>0$, there exists a sufficiently small $\\varepsilon>0$ such that if a realization of the Wiener process $W$ remains close to our solution $R$,\n\\[\\sup_{0\\le s\\le t}\\|W(s)-R(s)\\|\\le\\varepsilon,\\tag{6.50}\\]\nthen $X(t)\\in B_\\delta(y)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.controlEndpointStable",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinControlledEndpoint_stable"
  ],
  "extra_assumptions": [
    "[EXTRA]实际完整受控积分方程和原平滑势局部cutoff稳定性，全部端点/δ/ε；未假设全局Lipschitz势，原环面投影由上一真实核桥接。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem controlEndpointStable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ
```

