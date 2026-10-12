# BATCH15 第5章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-5.3.2-HarmonicQuadraturePrinted
```json
{
  "source_id": "MD-5.3.2-HarmonicQuadraturePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.2",
  "printed_page": "193",
  "pdf_page": "214",
  "statement_latex": "Parameterizing the surface by $q$, we have $p=\\sqrt{2E-\\Omega^2q^2}$, then\n\\[\\mu(\\Sigma_E)=4\\int_0^{\\sqrt{2E}}\\frac{\\sqrt{1+p_q^2}}{\\sqrt{H_p^2+H_q^2}}dq\n=4\\int_0^{\\sqrt{2E}/\\Omega}\\frac1{\\sqrt{2E-\\Omega^2q^2}}dq=2\\pi/\\Omega.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.harmonicQuadraturePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Ω>0及E>0，保存两个不同实际积分上界；端点导数用实平方根总化表达，不提升为已识别曲面面积。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem harmonicQuadraturePrinted : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  (4*(∫ q in (0 : ℝ)..Real.sqrt (2*c),
    Real.sqrt (1+(Ω^2*q/Real.sqrt (2*c-Ω^2*q^2))^2)/Real.sqrt (2*c-Ω^2*q^2+Ω^4*q^2)))=
  4*(∫ q in (0 : ℝ)..Real.sqrt (2*c)/Ω,1/Real.sqrt (2*c-Ω^2*q^2))
```

### MD-5.3.2-HarmonicPartition
```json
{
  "source_id": "MD-5.3.2-HarmonicPartition",
  "kind": "unnumbered_claim",
  "label": "Example 5.1",
  "section": "5.3.2",
  "printed_page": "193",
  "pdf_page": "214",
  "statement_latex": "$\\mu(\\Sigma_E)=4\\int_0^{\\sqrt{2E}/\\Omega}\\frac1{\\sqrt{2E-\\Omega^2q^2}}dq=2\\pi/\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.harmonicPartition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正频率和正能量；是真实Hausdorff加权测度的分区函数，不把参数积分写成定义冒充面积识别。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem harmonicPartition : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  MolecularDynamics.Chapter05Review.microPartition (harmonicEnergy Ω) c=2*Real.pi/Ω
```

### MD-5.3.2-IdealGasEnergy
```json
{
  "source_id": "MD-5.3.2-IdealGasEnergy",
  "kind": "definition",
  "label": "Example 5.2",
  "section": "5.3.2",
  "printed_page": "193–194",
  "pdf_page": "214–215",
  "statement_latex": "Example 5.2 Consider a system of $N$ non-interacting particles of mass $m$ moving in periodic boundary conditions within a box of volume $V$. The Hamiltonian is\n\\[H=\\frac1{2m}\\sum_{i=1}^N\\|p_i\\|^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "前三N个分量是位置，后三N个分量是动量；每粒子的三维平方范数展开成真实3N项。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.idealGasEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def idealGasEnergy (N : ℕ) (m : ℝ) (z : MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  (∑ i : Fin (3*N),(z (Fin.natAdd (3*N) i))^2)/(2*m)
```

### MD-5.3.2-IdealGasPositionDomain
```json
{
  "source_id": "MD-5.3.2-IdealGasPositionDomain",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "193–194",
  "pdf_page": "214–215",
  "statement_latex": "$Z_E=V^N\\int_S(m/r)d\\sigma$, where $S$ is the $3N-1$ dimensional sphere in $3N$ dimensions of radius $r=\\sqrt{2mE}$, and $d\\sigma$ is the surface area element on this sphere. $V^N$ is the contribution due to integration over positions.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.idealGasPositionDomain",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}
```

### MD-5.3.2-IdealGasPartition
```json
{
  "source_id": "MD-5.3.2-IdealGasPartition",
  "kind": "unnumbered_claim",
  "label": "Example 5.2",
  "section": "5.3.2",
  "printed_page": "193–194",
  "pdf_page": "214–215",
  "statement_latex": "Thus we have\n\\[Z_E=V^N\\frac{m}{\\sqrt{2mE}}A(S)\n=V^N\\frac{\\sqrt m}{\\sqrt{2E}}\\frac{3N\\pi^{3N/2}(2mE)^{(3N-1)/2}}{\\Gamma(3N/2+1)}\n=V^N\\frac{(2\\pi mE)^{3N/2}}{E\\Gamma(3N/2)}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.idealGasPartition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem idealGasPartition : ∀ (N : ℕ) (m c L : ℝ),0 < N → 0 < m → 0 < c → 0 < L →
  ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal=
    (L^3)^N*Real.rpow (2*Real.pi*m*c) ((3*N : ℝ)/2)/(c*Real.Gamma ((3*N : ℝ)/2))
```

