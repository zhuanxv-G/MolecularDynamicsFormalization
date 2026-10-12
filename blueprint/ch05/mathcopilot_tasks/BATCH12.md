# BATCH12 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.2-WeakStationary
```json
{
  "source_id": "MD-5.3.2-WeakStationary",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "189–190",
  "pdf_page": "210–211",
  "statement_latex": "We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of $\\mathcal L_f^*\\rho=0$. However, this requires a little care. Instead we will define the stationary solution in terms of integrals against test functions. This suggests that the condition for the invariant probability density function $\\rho_\\infty$ should be $\\int_D\\phi\\mathcal L_f^*\\rho_\\infty d\\omega=0$, for all suitable functions $\\phi\\in C_0^\\infty(\\mathbb R^m)$. We say that $\\mathcal L_f^*\\rho_\\infty=0$, in the weak or variational sense.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.weakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weakStationary {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : MolecularDynamics.Chapter05Review.testSpace n, Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧ (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

### MD-5.3.2-EnsembleAverage
```json
{
  "source_id": "MD-5.3.2-EnsembleAverage",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "Let $\\phi$ be a $C^\\infty$ function of the phase variables with compact support and define the time $t$ average by\n\\[\\bar\\phi(t)=\\frac{\\int_D\\phi(q,p)\\rho(q,p;t)d\\omega}{\\int_D\\rho(q,p;t)d\\omega}.\\tag{5.6}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "一般域D上的实际系综平均；不是沿单轨道的时间平均。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.ensembleAverageOn",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ
```

### MD-5.3.2-ConvergenceHeuristic
```json
{
  "source_id": "MD-5.3.2-ConvergenceHeuristic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "As the flow is Hamiltonian, $\\int_D\\rho(q,p;t)d\\omega=\\int_D\\rho(q,p;0)d\\omega$. Thus the condition for $\\bar\\phi$ to converge is just that $\\int_D\\phi(q,p)\\frac{\\partial\\rho}{\\partial t}(q,p;t)d\\omega\\to0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.convergenceHeuristic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem convergenceHeuristic : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → MolecularDynamics.Chapter05Review.flow f Φ → (∀ t,Φ t '' D=D) →
  (∀ t,MeasurePreserving (Φ t) volume volume) →
  ContDiff ℝ 1 (Function.uncurry ρ) → ContDiff ℝ ⊤ φ → HasCompactSupport φ →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0) →
    ∃ L : ℝ,Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L)
```

### MD-5.3.2-HamiltonianEnergyIntegral
```json
{
  "source_id": "MD-5.3.2-HamiltonianEnergyIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "In the case of a Hamiltonian system, we know that $\\mathcal L_f^*=-\\mathcal L_f$, and, moreover, $\\mathcal L_fH=0$, so that $H$ is a first integral.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.hamiltonianEnergyIntegral",
  "reusable_proofs": [
    "MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson",
    "MolecularDynamics.textbookPoissonBracket_self"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianEnergyIntegral {Nc : ℕ} (H : MolecularDynamics.SymplecticCoordinates Nc → ℝ) (z : MolecularDynamics.SymplecticCoordinates Nc) :
  MolecularDynamics.textbookLieDerivative (MolecularDynamics.textbookHamiltonianVectorField H) H z=0
```

### MD-5.3.2-EnergyDensityInvariant
```json
{
  "source_id": "MD-5.3.2-EnergyDensityInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "Any probability distribution whose density is a smooth function of $H$ will also be an invariant distribution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.energyDensityInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]给定真实流、真实能量第一积分和既有体积保持先验；明确r∘H为实际归一化概率密度，不声称任意r∘H都可积。原Hamiltonian触发的能量和体积先验分别登记，不把密度测度不变结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem energyDensityInvariant :
  ∀ n (H : MolecularDynamics.Chapter05Review.E n → ℝ) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    Φ (r : ℝ → ℝ), MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,MolecularDynamics.Chapter05Review.lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    MolecularDynamics.Chapter05Review.probabilityDensity (r ∘ H) → ∀ t,
    MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H))=MolecularDynamics.Chapter05Review.densityMeasure (r ∘ H)
```

### MD-5.3.2-ShellWeight
```json
{
  "source_id": "MD-5.3.2-ShellWeight",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190",
  "pdf_page": "211",
  "statement_latex": "In particular, consider the density $\\rho_\\varepsilon(q,p)=Z_\\varepsilon^{-1}e^{-(H(q,p)-E)^2/(2\\varepsilon)}$, where $\\varepsilon$ is an arbitrary small positive constant and $E$ is an accessible energy level.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实能量壳指数权；ε>0/可达能量和可积归一化资格为后续使用条件。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.shellWeight",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shellWeight {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := Real.exp (-(H z-c)^2/(2*ε))
```

### MD-5.3.2-ShellPartition
```json
{
  "source_id": "MD-5.3.2-ShellPartition",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190–191",
  "pdf_page": "211–212",
  "statement_latex": "We assume that $H$ tends to infinity sufficiently rapidly as $\\|z\\|\\to\\infty$ so that the exponential decays sufficiently rapidly (and thus the total integral exists) and take $Z_\\varepsilon$ to be a normalization factor that insures that we have, for each $\\varepsilon$, a well defined probability density function.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际全相空间权的积分；非零有限分母不是由定义编译自动保证。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.shellPartition",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shellPartition {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) := ∫ z,MolecularDynamics.Chapter05Review.shellWeight H c ε z
```

### MD-5.3.2-ShellDensity
```json
{
  "source_id": "MD-5.3.2-ShellDensity",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "190–191",
  "pdf_page": "211–212",
  "statement_latex": "$\\rho_\\varepsilon(q,p)=Z_\\varepsilon^{-1}e^{-(H(q,p)-E)^2/(2\\varepsilon)}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "已除一次Zε；后面的(5.8)若再除一次必须单列字面疑误，不能静默替换。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.shellDensity",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def shellDensity {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c ε : ℝ) (z : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.shellWeight H c ε z/MolecularDynamics.Chapter05Review.shellPartition H c ε
```

