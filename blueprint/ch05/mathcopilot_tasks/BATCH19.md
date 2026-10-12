# BATCH19 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.4.1-HarmonicFlow
```json
{
  "source_id": "MD-5.4.1-HarmonicFlow",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198–199",
  "pdf_page": "219–220",
  "statement_latex": "As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.harmonicFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def harmonicFlow (Ω t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]
```

### MD-5.4.1-HarmonicErgodic
```json
{
  "source_id": "MD-5.4.1-HarmonicErgodic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.harmonicErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem harmonicErgodic : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microErgodic (harmonicEnergy Ω) c (harmonicFlow Ω)
```

### MD-5.4.1-TwoOscillatorEnergy
```json
{
  "source_id": "MD-5.4.1-TwoOscillatorEnergy",
  "kind": "definition",
  "label": "Example 5.4",
  "section": "5.4.1",
  "printed_page": "198–199",
  "pdf_page": "219–220",
  "statement_latex": "Example 5.4 (2D Harmonic System) Consider a two-dimensional harmonic system, i.e. the system with Hamiltonian\n\\[H=p_1^2/2+p_2^2/2+\\Omega_1^2q_1^2/2+\\Omega_2^2q_2^2/2,\\]\nwhere $\\Omega_1$ and $\\Omega_2$ are two nonzero parameters. Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1=p_1^2/2+\\Omega_1^2q_1^2/2$ and $H_2=p_2^2/2+\\Omega_2^2q_2^2/2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : MolecularDynamics.Chapter05Review.E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2
```

### MD-5.4.1-TwoOscillatorFlow
```json
{
  "source_id": "MD-5.4.1-TwoOscillatorFlow",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198–199",
  "pdf_page": "219–220",
  "statement_latex": "Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1$ and $H_2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E 4) : MolecularDynamics.Chapter05Review.E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]
```

### MD-5.4.1-TwoOscillatorTori
```json
{
  "source_id": "MD-5.4.1-TwoOscillatorTori",
  "kind": "unnumbered_claim",
  "label": "Example 5.4",
  "section": "5.4.1",
  "printed_page": "199",
  "pdf_page": "220",
  "statement_latex": "For any $E_1,E_2>0$, the set of points satisfying $H_1=E_1,H_2=E_2$ is a two-dimensional torus. If the frequencies $\\Omega_1$ and $\\Omega_2$ are not rationally related (i.e. $\\Omega_1/\\Omega_2$ is an irrational number), then for any $E_1,E_2$ the torus will eventually be filled in by any trajectory. On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.twoOscillatorTori",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem twoOscillatorTori : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {z : MolecularDynamics.Chapter05Review.E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1 × Metric.sphere (0 : MolecularDynamics.Chapter05Review.E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬MolecularDynamics.Chapter05Review.setErgodic (MolecularDynamics.Chapter05Review.microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω))
```

### MD-5.4.1-Mixing
```json
{
  "source_id": "MD-5.4.1-Mixing",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "199",
  "pdf_page": "220",
  "statement_latex": "An even stronger property than the ergodic property is the concept of a mixing system. For a mixing system, the finite time density $\\rho(z;t)$ converges, in the weak sense, to the invariant distribution $\\rho_\\infty(z)$, as $t\\to\\infty$. That is, we have, for all test functions $\\phi$ in some chosen space\n\\[\\lim_{t\\to\\infty}\\langle\\phi,\\rho(\\cdot;t)\\rangle=\\langle\\phi,\\rho_\\infty\\rangle.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.weakMixing",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def weakMixing {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ r φ : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ))
```

### MD-5.4.1-KAMPersistence
```json
{
  "source_id": "MD-5.4.1-KAMPersistence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "200",
  "pdf_page": "221",
  "statement_latex": "The energy surface is three-dimensional (represented as the zero-set of a single constraint in four-dimensional space), but apparently it bifurcates into a collection of isolated components (bounded by two-dimensional closed surfaces). These are none other than the tori predicted by the KAM theory [386].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.kam",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem kam :
  ∀ n (H0 : MolecularDynamics.Chapter05Review.E n → ℝ) (P : MolecularDynamics.Chapter05Review.Phase n → ℝ) (I0 : MolecularDynamics.Chapter05Review.E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → MolecularDynamics.Chapter05Review.periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → MolecularDynamics.Chapter05Review.diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=MolecularDynamics.Chapter05Review.hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1)
```

### MD-5.4.1-AnisotropicPotential
```json
{
  "source_id": "MD-5.4.1-AnisotropicPotential",
  "kind": "definition",
  "label": "Example 5.6",
  "section": "5.4.1",
  "printed_page": "201",
  "pdf_page": "222",
  "statement_latex": "Example 5.6 (Anisotropic Oscillator) The anisotropic oscillator was used in Chap. 1 to illustrate the concept of a chaotic dynamical system.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际第1章既有各向异性弹簧能量在零速度的势；引用正式定义，不改第1章文件。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.anisotropicPotential",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def anisotropicPotential (κ l ε : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0
```

