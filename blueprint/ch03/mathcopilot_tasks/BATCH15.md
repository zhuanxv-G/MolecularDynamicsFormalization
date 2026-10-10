# BATCH15 第3章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-3.5-EqualComponentIntegral
```json
{
  "source_id": "MD-3.5-EqualComponentIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "122",
  "pdf_page": "144",
  "statement_latex": "Consider the following 2D example of a differential equation system\n\\[\\dot u=f(u,v),\\qquad\\dot v=f(u,v).\\]\nNotice that this system has a first integral\n\\[I(u,v)=u-v,\\]\nand consider the application of Euler's method:\n\\[u_{n+1}=u_n+hf(u_n,v_n),\\qquad v_{n+1}=v_n+hf(u_n,v_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Euler一步不变性在下一条；本条同时给真实I函数及连续轨道的first-integral结论，非只定义函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.equalComponentFirstIntegral",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实轨道导数资格显式，采用全实时间轨道版本，不宣称任意f都全时间有解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem equalComponentFirstIntegral :
    ∃ I : ℝ × ℝ → ℝ, (∀ z, I z = z.1-z.2) ∧
      ∀ (f : ℝ × ℝ → ℝ) (u v : ℝ → ℝ),
        (∀ t, HasDerivAt u (f (u t,v t)) t) →
        (∀ t, HasDerivAt v (f (u t,v t)) t) →
        ∀ t, I (u t,v t) = I (u 0,v 0)
```

### MD-3.5-EqualEulerIntegral
```json
{
  "source_id": "MD-3.5-EqualEulerIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "We see that\n\\[I(u_{n+1},v_{n+1})=u_{n+1}-v_{n+1}=u_n-v_n=I(u_n,v_n),\\]\nwhich means that Euler's method conserves this first integral.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页与PDF144的Euler更新及I=u−v。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.equalEulerIntegral",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.equalEulerIntegral_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem equalEulerIntegral :
  ∀ (f : ℝ × ℝ → ℝ) h z, equalComponentIntegral (z.1+h*f z,z.2+h*f z)=equalComponentIntegral z
```

### MD-3.5-LinearEulerIntegral
```json
{
  "source_id": "MD-3.5-LinearEulerIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "Generalizing this slightly, we could imagine a system of ODEs of the form\n\\[\\dot{\\boldsymbol z}=f(\\boldsymbol z),\\]\nsuch that, for some vector $\\boldsymbol b$,\n\\[\\boldsymbol b\\cdot f(\\boldsymbol z)\\equiv0,\\]\nthen $I(\\boldsymbol z)=\\boldsymbol b\\cdot\\boldsymbol z$ is a first integral. It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "精确实数一步Euler保持线性函数；连续ODE first integral由链式法则；不解释为机器浮点完全无误差。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.linearEulerIntegral",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.linearEulerIntegral_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem linearEulerIntegral :
  ∀ (n : ℕ) (b : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, b (f z)=0) →
    ∀ (h : ℝ) z, b (z+h • f z)=b z
```

### MD-3.5-LinearRKIntegral
```json
{
  "source_id": "MD-3.5-LinearRKIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文many other popular numerical methods的Runge–Kutta实例作为[EXTRA]证明辅助，不宣称原句明确列出RK；实际有限阶段方程用第2章定义。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.linearRKIntegral",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.linearRKIntegral_proved"
  ],
  "extra_assumptions": [
    "明确选择任意有限阶段Runge–Kutta关系；所有阶段满足原场线性第一积分资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem linearRKIntegral :
  ∀ (n s : ℕ) (ℓ : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, ℓ (f z)=0) →
    ∀ (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
      rungeKuttaRelation f A b h z w F → ℓ w=ℓ z
```

### MD-3.5-VerletOscillatorEnergy
```json
{
  "source_id": "MD-3.5-VerletOscillatorEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "In the case of Euler's method applied to the harmonic oscillator, the error in energy grows with time and without bound. In the case of Störmer-Verlet, the energy fluctuates but remains bounded for all time and at its worst is of size proportional to $h^2$, a numerical observation that is supported by the existence of the modified Hamiltonian.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Euler无界另为EulerGrowth；本条保留Verlet谐振子全时间能量界。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletOscillatorEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0，固定ρ∈(0,2)，|hΩ|≤ρ；排除不稳定及阈值步长。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletOscillatorEnergy :
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2
```

### MD-3.5-MomentumProjection
```json
{
  "source_id": "MD-3.5-MomentumProjection",
  "kind": "definition",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "We start by taking a timestep with any arbitrary (nonconserving) numerical method, say to an intermediate phase point $\\overline Q,\\overline P$, then we “fix it up” by scaling the momentum by an adjustment factor, defining\n\\[Q=\\overline Q,\\qquad P=\\gamma\\overline P,\\]\nselecting $\\gamma$ so that the energy in the result is a prescribed value $E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "γ选择由后面的constraint及factor定义，投影本身不证明可求解性。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.momentumProjection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)
```

### MD-3.5-ProjectionConstraint
```json
{
  "source_id": "MD-3.5-ProjectionConstraint",
  "kind": "definition",
  "label": "(3.12)",
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "This method is easy to implement: the equation that must be solved is\n\\[\\frac{\\gamma^2\\overline P^TM^{-1}\\overline P}{2}+U(\\overline Q)=E.\\tag{3.12}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "K=P̄ᵀM⁻¹P̄/2，U=U(Q̄)；γ约束。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.projectionConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E
```

### MD-3.5-ProjectionFactor
```json
{
  "source_id": "MD-3.5-ProjectionFactor",
  "kind": "definition",
  "label": "(3.13)",
  "section": "3.5",
  "printed_page": "124",
  "pdf_page": "146",
  "statement_latex": "and, since $\\overline Q$ is known, this gives\n\\[\\gamma=\\left(\\frac{E-\\overline U}{\\overline K}\\right)^{1/2},\\tag{3.13}\\]\nwhere $\\overline U=U(\\overline Q)$ and $\\overline K=\\overline P^TM^{-1}\\overline P/2$ are the potential and kinetic energies after a step of the original non-conserving scheme.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实平方根取非负分支；原文要求K>0、E−U≥0，定义的真实约束解另列ProjectionEnergy。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.projectionFactor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)
```

