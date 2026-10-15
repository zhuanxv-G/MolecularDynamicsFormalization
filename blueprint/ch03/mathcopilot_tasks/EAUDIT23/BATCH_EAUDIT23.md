# EAUDIT23：第3章§3.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.1-EnergyFailure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "98",
  "pdf_page": "120",
  "statement_latex": "If $H(q,p)=E$ then, for typical steps, we cannot expect $H(Q,P)=E$. (Just insert the formulas for $Q$ and $P$ into the Hamiltonian and check that the value is not the same as $H(q,p)$.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页$H(q,p)=(p^2+\\Omega^2q^2)/2$，$Q=q+hp$、$P=p-h\\Omega^2Q$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorEnergyFailure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01对每个Ω>0和h≠0保存完整ΔH恒等、能量不变的两条例外直线和一般不守恒见证；精确代数为原typical的形式化展开，不回填成教材原句。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "5f6068c438af8569c7ba973c03dec88acd8dab0e9cb1bf64f20b1a6e6881bab2",
      "after_sha256": "012a48046338e20207ba2cd777537101126d46184cce744ab302bea136db60df",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "fa7d079b49802d64f1efbc27c6b0a90cbbf1090b9fc48cc0576829b45ebf4aa1",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    },
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:58:31.766295",
      "before_sha256": "71b108627374ed058b96f1420fa82f3fcdc13fedb4f3ae3693759c23476698b8",
      "after_sha256": "cea8e17dddfd2efa7b0a0ee6a7736bdecfd83922e5b159524ff407826a6b657b",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem oscillatorEnergyFailure : ∀ Ω h : ℝ, 0 < Ω → h ≠ 0 →
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
    (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2)) ∧
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)=oscillatorEnergy Ω z ↔
    Ω*(z.1+h*z.2)=z.2 ∨ Ω*(z.1+h*z.2)=-z.2) ∧
  (∃ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z) := by
  intro Ω h hΩ hh
  have hh2 : 0 < h^2 := sq_pos_of_ne_zero hh
  have hΩ2 : 0 < Ω^2 := sq_pos_of_ne_zero hΩ.ne'
  have hc : h^2*Ω^2/2 ≠ 0 := (div_pos (mul_pos hh2 hΩ2) (by norm_num : (0 : ℝ)<2)).ne'
  have hdelta : ∀ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
        (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2) := by
    intro z
    simp only [oscillatorEnergy,oscillatorAdjointEuler]
    ring
  refine ⟨hdelta,?_,?_⟩
  · intro z
    rw [← sub_eq_zero,hdelta z,mul_eq_zero]
    simp only [hc,false_or]
    have he : Ω^2*(z.1+h*z.2)^2=(Ω*(z.1+h*z.2))^2 := by ring
    rw [he,sub_eq_zero]
    exact sq_eq_sq_iff_eq_or_eq_neg
  · refine ⟨(1,0),?_⟩
    intro heq
    have hd := hdelta (1,0)
    rw [heq,sub_self] at hd
    norm_num at hd
    rcases hd with hzero | hzero
    · exact hh hzero
    · exact hΩ.ne' hzero
```
### 实际依赖 MD.Ch03.oscillatorAdjointEuler
```lean
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```
### 实际依赖 MolecularDynamics.Chapter03Review.oscillatorEnergy
```lean
def oscillatorEnergy (Ω : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+Ω^2*z.1^2)/2
```

## 原文JSON
```json
{
  "source_id": "MD-3.1-ShadowInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.1",
  "printed_page": "99",
  "pdf_page": "121",
  "statement_latex": "This means that $\\widetilde H$ is a conserved quantity of the numerical method.",
  "proof_latex": "\\[\\begin{aligned}\\widetilde H(Q,P)&=\\frac{P^2}{2}+\\frac{h\\Omega^2PQ}{2}+\\frac{\\Omega^2Q^2}{2}\\\\\n&=\\frac12p^2-\\frac{h\\Omega^2}{2}pQ+\\frac{\\Omega^2Q^2}{2}\\\\&=\\widetilde H(q,p)\\end{aligned}\\]",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\widetilde H$及adjoint symplectic Euler见p.98/PDF120。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.oscillatorShadowInvariant",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:58:31.766295",
      "before_sha256": "2e781606b2ebef1a0f83af82798cd881bb280b5b99c4b3d548a103186c42b513",
      "after_sha256": "186143b50098def60b559a79f0a2997d384cbd774899a6a7cb43799adcdc1f36",
      "changed_fields": [
        "proof_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem oscillatorShadowInvariant :
  ∀ Ω h z, oscillatorShadow Ω h (oscillatorAdjointEuler Ω h z)=oscillatorShadow Ω h z := by
  exact MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved
```
### 实际依赖 MD.Ch03.oscillatorAdjointEuler
```lean
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```
### 实际依赖 MD.Ch03.oscillatorShadow
```lean
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2
```

## 原文JSON
```json
{
  "source_id": "MD-3.1-FormalHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "Now consider the more general Hamiltonian setting. Let $\\mathcal G_h$ be a $r$th order symplectic integrator, $r\\ge1$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $\\widetilde H_h$. If the method order is $r$, we may expect this Hamiltonian to be a $\\mathcal O(h^r)$ approximation of $H$, thus we posit an expansion of the form\n\\[\\widetilde H_h=H+h^rH^{(r)}+h^{r+1}H^{(r+1)}+\\cdots\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$r\\ge1$；$H^{(j)}$为待确定光滑系数函数；h为形式变量而不是级数收敛参数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01显式1≤r，排除r=0遗漏Hr0的错义；仍是真实逐系数形式级数，不声称无限收敛或实际流嵌入。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "ca771d4563a622a4c41f1add5b9cc9d9029446d7e8bec19a53618f87e570a69b",
      "after_sha256": "64e44a52a3f4c2dadfda13578b39209fb04146a64084673d21e2ad6c1ea470d0",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "fa7d079b49802d64f1efbc27c6b0a90cbbf1090b9fc48cc0576829b45ebf4aa1",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    },
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:58:31.766295",
      "before_sha256": "f1f8a5abb21e18f586cdb493f352c7f43fd4f2101a54577cef7e74680968b003",
      "after_sha256": "4b705fd2fad20c010d69fe1acd8aa53df22754dbdcd266cf8584382651850598",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch03.formalHamiltonian
```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```

## 原文JSON
```json
{
  "source_id": "MD-3.1-FormalHamiltonianField",
  "kind": "definition",
  "label": null,
  "section": "3.1",
  "printed_page": "100",
  "pdf_page": "122",
  "statement_latex": "To determine the terms $H^{(r)},H^{(r+1)},\\ldots$, we write the differential equations on $\\widetilde H_h$:\n\\[\\dot{\\boldsymbol z}=J\\nabla H+h^rJ\\nabla H^{(r)}+h^{r+1}J\\nabla H^{(r+1)}+\\cdots\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": "The solution of this system can be expanded in powers of $h$ and equated term-by-term with the expansion of $\\mathcal G_h$ in powers of $h$. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.",
  "context_notation": [
    "$r\\ge1$；形式Hamiltonian见同页上段；每个系数取真实$J\\nabla H^{(j)}$，不把无穷级数当收敛ODE。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.formalHamiltonianField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01显式1≤r及H和全部Hj全域C∞，保证真实Fréchet梯度；原平滑逐阶形式展开资格，不预置匹配结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T20:57:11.855696",
      "before_sha256": "499fdc69f73f2adcbb1551a9b6790607f6bc23e0023102940c11e0dc45a5693e",
      "after_sha256": "11c21a46ebecac5db66cef3ba4755b7cce8daf2c183dcd6a627542af0a315c0b",
      "changed_fields": [
        "statement_latex",
        "proof_discussion_latex"
      ],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "fa7d079b49802d64f1efbc27c6b0a90cbbf1090b9fc48cc0576829b45ebf4aa1",
      "reason": "原页119/120/122视觉核对后合并A的标点/记号修订；按绑定FAIL补齐四条全部结论/阶数/真实导数资格，不采用未批准数学勘误。"
    },
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:58:31.766295",
      "before_sha256": "0ee630659e74c9e812042afeb21dc240fd0958a67204eb9ac4293333f512245b",
      "after_sha256": "e93ac93962326b0ee617bb23e8ab3f11d341278b576d031c57da4158896ddb13",
      "changed_fields": [],
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (_hH : ContDiff ℝ ∞ H) (_hHj : ∀ j, ContDiff ℝ ∞ (Hj j))
    (z : SymplecticCoordinates n) (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch03.formalHamiltonianField
```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (_hH : ContDiff ℝ ∞ H) (_hHj : ∀ j, ContDiff ℝ ∞ (Hj j))
    (z : SymplecticCoordinates n) (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
