# BATCH22 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.5-Correlation
```json
{
  "source_id": "MD-5.5-Correlation",
  "kind": "definition",
  "label": null,
  "section": "5.5",
  "printed_page": "203",
  "pdf_page": "224",
  "statement_latex": "Let $a$ and $b$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $a$ and $b$ (on the surface of energy $E$) by\n\\[C_{ab}(\\tau)\\stackrel{\\rm def}{=}k\\operatorname{Av}_{H=E}(a(\\mathcal F_t(z))\\cdot b(z))\n=kZ_E^{-1}\\int_{\\Sigma_E}a(\\mathcal F_t(z))\\cdot b(z)\\delta[H-E]d\\omega,\\]\nwhere $k$ is a normalization constant that is often incorporated to ensure that $C_{ab}(0)=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实向量内积与µ积分；原左τ右t记号保留、Lean用单个lag参数；k只在零lag非零时能归一。δ积分解释为真实微正则测度配对。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.correlation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

### MD-5.5-CorrelationPullback
```json
{
  "source_id": "MD-5.5-CorrelationPullback",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "Using the notation developed earlier for the propagator, this has the alternative formulation\n\\[C_{ab}(t)=k\\operatorname{Av}_{H=E}\\left[b(z)\\cdot(e^{t\\mathcal L}a)(z)\\right].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.correlationPullback",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.correlationPullback_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem correlationPullback {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t :
    MolecularDynamics.Chapter05Review.correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

### MD-5.5-CorrelationTimePrinted
```json
{
  "source_id": "MD-5.5-CorrelationTimePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:\n\\[C_{a,b}(t)=k\\lim_{T\\to\\infty}\\frac1T\\int_0^T a(z(s+t))\\cdot b(z(s))ds.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.correlationTimePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem correlationTimePrinted : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t))
```

### MD-5.5-CorrelationTimeAE
```json
{
  "source_id": "MD-5.5-CorrelationTimeAE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "$C_{a,b}(t)=k\\lim_{T\\to\\infty}T^{-1}\\int_0^T a(z(s+t))\\cdot b(z(s))ds$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.correlationTime",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem correlationTime :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t))
```

### MD-5.5-VelocityCorrelation
```json
{
  "source_id": "MD-5.5-VelocityCorrelation",
  "kind": "definition",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "The velocity autocorrelation function is often written in the shorthand notation\n\\[C_{v,v}(t)\\stackrel{\\rm def}{=}\\frac{\\langle v(t)\\cdot v(0)\\rangle}{\\langle v(0)\\cdot v(0)\\rangle},\\]\nwhere the averaging may be assumed to be against the microcanonical measure, if otherwise unspecified.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实vector dot相关函数除零lag；分母非零资格另需，0总化除法不赋予归一化意义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.velocityCorrelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def velocityCorrelation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (v : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (t : ℝ) := MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 t/MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 0
```

### MD-5.5-PositionTransition
```json
{
  "source_id": "MD-5.5-PositionTransition",
  "kind": "definition",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "Now let $A$ and $B$ be subsets of configuration space (i.e. subsets in the position space) of nonzero measure, and define $T_{AB}(\\tau)\\stackrel{\\rm def}{=}C_{1_B,1_A}(\\tau)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "π是实际位置投影，配置集合在相空间上的逆像；真实指标乘积平均，不把状态点概率误作首次到达时间。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.positionTransition",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (t : ℝ) :=
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)
```

### MD-5.5-TransitionProbability
```json
{
  "source_id": "MD-5.5-TransitionProbability",
  "kind": "definition",
  "label": null,
  "section": "5.5",
  "printed_page": "204",
  "pdf_page": "225",
  "statement_latex": "Dividing $T_{AB}$ by the measure of the set $A$, we obtain the probability for a trajectory to make this transition in the given time, which we may write as\n\\[\\operatorname{Pr}_\\tau(A\\to B)=\\frac{\\langle1_B(z(\\tau))1_A(z(0))\\rangle}{\\langle1_A(z(0))\\rangle},\\]\nwhere the averaging is assumed to be with respect to the microcanonical distribution at given energy $E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.transitionProbability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def transitionProbability {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (A B : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal
```

### MD-5.5-MeasureDuality
```json
{
  "source_id": "MD-5.5-MeasureDuality",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.5",
  "printed_page": "205",
  "pdf_page": "226",
  "statement_latex": "\\[\\int_{\\Sigma_E}\\phi(z)\\rho(z;t)d\\omega\n=\\int_{\\Sigma_E}\\phi(z)e^{t\\mathcal L^*}\\rho(z,0)d\\omega\n=\\int_{\\Sigma_E}[e^{t\\mathcal L}\\phi(z)]\\rho(z,0)d\\omega\n=\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))\\rho(z;0)d\\omega\n=\\int_{\\Sigma_E}\\phi(\\mathcal F_t(z))\\frac{\\rho(z;0)}{\\rho_E(z)}\\rho_E(z)d\\omega.\\tag{5.10}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.measureDuality",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem measureDuality :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (φ : MolecularDynamics.Chapter05Review.E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) →
    MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) φ=MolecularDynamics.Chapter05Review.average μ (MolecularDynamics.Chapter05Review.pullback Φ φ t)
```

