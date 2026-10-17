# BATCH20 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.3.3-BathHamiltonian
```json
{
  "source_id": "MD-6.3.3-BathHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "236",
  "pdf_page": "257",
  "statement_latex": "We assume as in [138] that we are given a system of $k$ coupled oscillators (a “heat bath”) in contact with a distinguished particle. The Hamiltonian is\n\\[H=\\frac{P^2}{2}+\\sum_{i=1}^k\\frac{p_i^2}{2\\mu_i}+U(Q)+\\frac1{2k}\\sum_{i=1}^k(q_i-Q)^2\\]\nwhere $Q$ and $P$ represent the position and momentum of the distinguished particle and $\\{q_i,p_i\\}$ are the positions and momenta of the particles of the bath, $\\mu_i$ giving the mass of the $i$th light particle.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "重粒子质量1；全部轻粒子质量μi>0，k>0；真实k项耦合Hamiltonian。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.bathHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]显式k>0及全部μi>0，避免零质量/零热浴大小的总化除法冒充物理模型。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bathHamiltonian {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (U : ℝ → ℝ) (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k) : ℝ :=
  P^2/2 + (∑ i, (p i)^2/(2*μ i)) + U Q + (∑ i, (q i-Q)^2)/(2*k)
```

### MD-6.3.3-BathHamiltonEquations
```json
{
  "source_id": "MD-6.3.3-BathHamiltonEquations",
  "kind": "unnumbered_claim",
  "label": "(6.22)–(6.25)",
  "section": "6.3.3",
  "printed_page": "236",
  "pdf_page": "257",
  "statement_latex": "The equations of motion for the combined system are\n\\[\\dot Q=P;\\tag{6.22}\\quad\\dot P=-U'(Q)-k^{-1}\\sum_{i=1}^k(Q-q_i);\\tag{6.23}\\]\nwhere, for $i=1,2,\\ldots,k$,\n\\[\\dot q_i=p_i/\\mu_i;\\tag{6.24}\\quad\\dot p_i=(Q-q_i)/k.\\tag{6.25}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathHamiltonEquations",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Hamiltonian全部偏导、正质量、k>0和U沿Q可微；全部四组等式，不只定义方程。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathHamiltonEquations :
  ∀ {k : ℕ} (μ : MolecularDynamics.Chapter06Review.V k) (U : ℝ → ℝ)
    (Q P : ℝ) (q p : MolecularDynamics.Chapter06Review.V k), 0 < k → (∀ i, 0 < μ i) → DifferentiableAt ℝ U Q →
  deriv (fun z ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q z q p) P = P ∧
  -deriv (fun z ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U z P q p) Q = -deriv U Q-(∑ i : Fin k, (Q - q i))/(k : ℝ) ∧
  (∀ i, fderiv ℝ (fun v ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q P q v) p (Pi.single i 1) = p i/μ i) ∧
  (∀ i, -fderiv ℝ (fun v ↦ MolecularDynamics.Chapter06Review.bathHamiltonian μ U Q P v p) q (Pi.single i 1) = (Q-q i)/(k : ℝ))
```

### MD-6.3.3-BathFrequency
```json
{
  "source_id": "MD-6.3.3-BathFrequency",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "where $\\Omega_i=k^{-1/2}\\mu_i^{-1/2}$ is the frequency of the $i$th oscillator.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "k>0,μi>0，(√(kμi))⁻¹等价于原正参数乘积。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.bathFrequency",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]k>0和全部μi>0已编码为真实参数资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bathFrequency {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (i : Fin k) : ℝ := (Real.sqrt ((k : ℝ)*μ i))⁻¹
```

### MD-6.3.3-BathOscillatorSolution
```json
{
  "source_id": "MD-6.3.3-BathOscillatorSolution",
  "kind": "unnumbered_claim",
  "label": "(6.26)",
  "section": "6.3.3",
  "printed_page": "236–237",
  "pdf_page": "257–258",
  "statement_latex": "Because the system (6.24)–(6.25) is linear, we may solve it analytically for $\\{q_i,p_i\\}$; this yields:\n\\[q_i(t)=\\cos(\\Omega_i t)q_i(0)+\\Omega_i^{-1}\\sin(\\Omega_i t)p_i(0)/\\mu_i+k^{-1}\\mu_i^{-1}\\int_0^t\\Omega_i^{-1}\\sin(\\Omega_i(t-s))Q(s)ds.\\tag{6.26}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathOscillatorSolution",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际二阶受迫振子ODE、C²q、连续Q及t≥0；显式全部k>0、正μ、原初始动量p0与真实初始化q′0=p0/μ，Ω实际计算为(kμ)⁻¹/²；保留原k⁻¹μ⁻¹卷积系数，不以解公式作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathOscillatorSolution : ∀ (Q q : ℝ → ℝ) (k : ℕ) (μ p0 t : ℝ),
  0 < k → 0 < μ → ContDiff ℝ 2 q → Continuous Q → 0 ≤ t →
  (deriv q 0=p0/μ) →
  (∀ s ∈ Icc 0 t, deriv (deriv q) s=(Q s-q s)/((k : ℝ)*μ)) →
  let Ω : ℝ := (Real.sqrt ((k : ℝ)*μ))⁻¹
  q t=Real.cos (Ω*t)*q 0+Ω⁻¹*Real.sin (Ω*t)*p0/μ+
    (k : ℝ)⁻¹*μ⁻¹*(∫ s in 0..t, Ω⁻¹*Real.sin (Ω*(t-s))*Q s)
```

### MD-6.3.3-BathConvolutionIBP
```json
{
  "source_id": "MD-6.3.3-BathConvolutionIBP",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "Integrating by parts, we have\n\\[\\int_0^t\\Omega_i\\sin(\\Omega_i(t-s))Q(s)ds=[\\cos(\\Omega_i(t-s))Q(s)]_0^t-\\int_0^t\\cos(\\Omega_i(t-s))P(s)ds\n=Q(t)-\\cos(\\Omega_i t)Q(0)-\\int_0^t\\cos(\\Omega_i(t-s))P(s)ds.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathConvolutionIBP",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实C¹ Q和Q′=P；完整实际卷积IBP，不以通量结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathConvolutionIBP :
  ∀ (Q P : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 1 Q → (∀ s, deriv Q s=P s) → 0 ≤ t →
  (∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s) = Q t-Real.cos (Ω*t)*Q 0 -
    ∫ s in 0..t, Real.cos (Ω*(t-s))*P s
```

### MD-6.3.3-BathForce
```json
{
  "source_id": "MD-6.3.3-BathForce",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "where we define\n\\[f(t)=-k^{-1}\\sum_{i=1}^k[\\cos(\\Omega_i t)q_i(0)+\\Omega_i^{-1}\\sin(\\Omega_i t)p_i(0)/\\mu_i-\\cos(\\Omega_i t)Q(0)].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.bathForce",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]按(6.23)推导得到正k⁻¹实际合力；原页负号与+f项冲突，字面版本另列；不宣称更正已由网站裁定。",
    "[EXTRA]k>0和全部μi>0已编码，排除非物理逆质量/频率总化值。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bathForce {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)

/-- 修正版，对应原文 MD-6.3.3-BathForcePrinted；改动：选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。 -/
def bathForcePrinted_corrected {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*(q0 i-Q0) +
    (MolecularDynamics.Chapter06Review.bathFrequency μ i)⁻¹ * Real.sin (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)*p0 i/μ i)
```

### MD-6.3.3-BathForcePrinted
```json
{
  "source_id": "MD-6.3.3-BathForcePrinted",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "where we define\n\\[f(t)=-k^{-1}\\sum_{i=1}^k[\\cos(\\Omega_i t)q_i(0)+\\Omega_i^{-1}\\sin(\\Omega_i t)p_i(0)/\\mu_i-\\cos(\\Omega_i t)Q(0)].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷f含负k⁻¹，而(6.29)写+f；从(6.23)代入振子解得到正k⁻¹合力。"
    }
  ],
  "lean_decl": "MD.Ch06.bathForcePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]保持原物理k>0与全部μi>0资格；字面符号仍待裁定。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "选择正的初值合力f，使(6.29)保留+f；等价选项是保留原f并将(6.29)改为−f。",
      "corrected_decl": "MD.Ch06.bathForcePrinted_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bathForcePrinted {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (q0 p0 : MolecularDynamics.Chapter06Review.V k) (Q0 t : ℝ) : ℝ := -MolecularDynamics.Chapter06Review.bathForce μ q0 p0 Q0 t
```

### MD-6.3.3-MemoryKernel
```json
{
  "source_id": "MD-6.3.3-MemoryKernel",
  "kind": "definition",
  "label": null,
  "section": "6.3.3",
  "printed_page": "237",
  "pdf_page": "258",
  "statement_latex": "\\[\\psi(t)=k^{-1}\\sum_{i=1}^k\\cos(\\Omega_i(t)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实有限k项记忆核；不将有限核当作Dirac δ。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.memoryKernel",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际k>0与全部μi>0参数资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-16",
      "action": "local_original_page_transcription",
      "reason": "PDF258/259视觉核对原记忆核为psi，不是eta；仅原文符号转录更正，Lean定义未变。",
      "evidence": "source_transcription_fixes.json; PDF258/259",
      "website": "待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def memoryKernel {k : ℕ} (_hk : 0 < k) (μ : MolecularDynamics.Chapter06Review.V k) (_hμ : ∀ i, 0 < μ i) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, Real.cos (MolecularDynamics.Chapter06Review.bathFrequency μ i*t)
```

