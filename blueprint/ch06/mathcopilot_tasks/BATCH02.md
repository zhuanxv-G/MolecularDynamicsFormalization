# BATCH02 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.1.2-Entropy
```json
{
  "source_id": "MD-6.1.2-Entropy",
  "kind": "definition",
  "label": "(6.1)",
  "section": "6.1.2",
  "printed_page": "214",
  "pdf_page": "235",
  "statement_latex": "In terms of a microcanonical system, the entropy is enshrined in the famous formula that appears on Boltzmann's tombstone:\n\\[S=k_B\\ln Z.\\tag{6.1}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "kB约1.38×10⁻²³ J/K为物理常量记号；Z>0时log具有熵解释；热力学第二定律为物理建模原则，非本条Lean结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.entropy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)
```

### MD-6.1.2-IndependentPartition
```json
{
  "source_id": "MD-6.1.2-IndependentPartition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "215",
  "pdf_page": "236",
  "statement_latex": "We denote by $Z(E_A,E_B)$ the total number of states the system can occupy with systems A and B having energies $E_A$ and $E_B$, respectively. We make use of our assumption that the two systems do not exchange particles so that the total number of states the combined system can be found in depends solely on the energies of the two independent systems, i.e.,\n\\[Z(E_A,E_B)=Z_A(E_A)\\times Z_B(E_B).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.independentPartition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]独立、分别固定能量的真实加权能量面测度乘积；不将固定总能量partition的卷积偷换为乘积。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem independentPartition :
  ∀ {n m : ℕ} (HA : Chapter05Review.E n → ℝ)
    (HB : Chapter05Review.E m → ℝ) (EA EB : ℝ),
  Chapter05Review.regularEnergy HA EA → Chapter05Review.regularEnergy HB EB →
  let μA := Chapter05Review.microRaw HA EA
  let μB := Chapter05Review.microRaw HB EB
  (μA.prod μB) univ = μA univ * μB univ
```

### MD-6.1.2-EntropyAdditivity
```json
{
  "source_id": "MD-6.1.2-EntropyAdditivity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "215",
  "pdf_page": "236",
  "statement_latex": "Taking logarithms and replacing the value for $E_B$ by $E-E_A$, we have\n\\[\\ln Z(E_A,E-E_A)=\\ln Z_A(E_A)+\\ln Z_B(E-E_A).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.entropyAdditivity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]两个正实数partition；结论同时保留乘kB的熵加法，kB=1包含所印log式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem entropyAdditivity :
  ∀ (kB ZA ZB : ℝ), 0 < ZA → 0 < ZB →
  kB*Real.log (ZA*ZB) = kB*Real.log ZA+kB*Real.log ZB
```

### MD-6.1.2-EntropyEquilibrium
```json
{
  "source_id": "MD-6.1.2-EntropyEquilibrium",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "215",
  "pdf_page": "236",
  "statement_latex": "This value of $E_A$ occurs where\n\\[\\frac{d}{dE_A}\\ln Z(E_A,E-E_A)=0,\\]\nor equivalently where\n\\[\\frac{d}{dE_A}S_A=\\frac{d}{dE_B}S_B,\\]\nwhere we have used Boltzmann's relation to express this in terms of the entropy.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.entropyEquilibrium",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]固定总能量；两个熵函数在相应能量可微，内点局部最大为前提；实际导数相等为结论，不假设平衡导数关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem entropyEquilibrium :
  ∀ (SA SB : ℝ → ℝ) (E e : ℝ),
  DifferentiableAt ℝ SA e → DifferentiableAt ℝ SB (E-e) →
  IsLocalMax (fun x ↦ SA x+SB (E-x)) e → deriv SA e = deriv SB (E-e)
```

### MD-6.1.2-Temperature
```json
{
  "source_id": "MD-6.1.2-Temperature",
  "kind": "definition",
  "label": null,
  "section": "6.1.2",
  "printed_page": "215",
  "pdf_page": "236",
  "statement_latex": "The temperature of a system $T$, is defined as\n\\[\\frac1T:=\\frac{\\partial S}{\\partial E}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "inverseTemperature S E=deriv S E；temperature取其倒数；实际导数非零才得到倒数解释。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.temperature",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (MolecularDynamics.Chapter06Review.inverseTemperature S E)⁻¹
```

### MD-6.1.2-InverseThermal
```json
{
  "source_id": "MD-6.1.2-InverseThermal",
  "kind": "definition",
  "label": "(6.2)",
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "giving, when the system is in thermal equilibrium,\n\\[\\frac{d}{dE_A}\\ln Z_A(E_A)=\\frac{d}{dE_B}\\ln Z_B(E_B)=\\frac1{k_BT}=: \\beta.\\tag{6.2}\\]\nWe shall refer to the quantity $\\beta$ as the system's inverse or reciprocal temperature.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "β=(kBT)⁻¹定义；等温平衡关系的导数等式另见EntropyEquilibrium与LogTemperature，不以定义计为关系已证。",
    "物理解释要求kB>0,T>0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch06.inverseThermal",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹
```

### MD-6.1.2-BathTaylor
```json
{
  "source_id": "MD-6.1.2-BathTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "216",
  "pdf_page": "237",
  "statement_latex": "Since $Z_B(E-s)=\\exp(S_B(E-s)/k_B)$, and $s\\ll E$, we (naively) apply the mean value theorem to $S_B$ to obtain\n\\[S_B(E-s)=S_B(E)-S'_B(\\xi)s,\\]\nand from $S'_B(\\xi)=1/T$, we obtain\n\\[Z_B(E-s)\\propto\\exp(-\\beta s).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "[ERRATUM?]原书脚注3承认热浴推导不精确；S′(ξ)=1/T通常只能作为大热浴近似，完整精确Boltzmann因子保留字面NEEDS_HUMAN。"
    }
  ],
  "lean_decl": "MD.Ch06.bathBoltzmannPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]熵C²、正热浴能量及kB；β以原页固定温度关系表示，不假设所需中间点导数恒定。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem bathBoltzmannPrinted : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  ContDiff ℝ 2 S → 0 < energy → 0 < kB → deriv S energy = kB * β →
  (∀ s : ℝ, 0 < s → ∃ ξ ∈ Icc (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s) ∧
  (∀ s ∈ Icc (0 : ℝ) energy,
    Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s))
```

### MD-6.1.2-LogTemperature
```json
{
  "source_id": "MD-6.1.2-LogTemperature",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.1.2",
  "printed_page": "215–216",
  "pdf_page": "236–237",
  "statement_latex": "The temperature of a system $T$, is defined as $1/T:=\\partial S/\\partial E$, giving, when the system is in thermal equilibrium,\n\\[\\frac{d}{dE_A}\\ln Z_A(E_A)=\\frac{d}{dE_B}\\ln Z_B(E_B)=\\frac1{k_BT}=: \\beta.\\tag{6.2}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.logTemperature",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]partition在该能量可微且正；本条保留温度与log partition的实际微分关系，系统之间平衡关系由EntropyEquilibrium保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem logTemperature : ∀ (kB : ℝ) (Z : ℝ → ℝ) (energy : ℝ),
  DifferentiableAt ℝ Z energy → 0 < Z energy →
  deriv (fun e ↦ Real.log (Z e)) energy = deriv Z energy / Z energy ∧
  MolecularDynamics.Chapter06Review.inverseTemperature
    (MolecularDynamics.Chapter06Review.entropy kB Z) energy = kB * deriv Z energy / Z energy
```

