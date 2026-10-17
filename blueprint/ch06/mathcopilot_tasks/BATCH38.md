# BATCH38 第6章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
用代码写入JSON对象(batch,input_sha256,items)，哈希按本PASTE开头逐项原样回显；items中每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-6.4.4-HamiltonianPowerGenerator
```json
{
  "source_id": "MD-6.4.4-HamiltonianPowerGenerator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253–254",
  "pdf_page": "274–275",
  "statement_latex": "Computing the generator of Langevin dynamics as\n\\[\\mathcal L_{LD}f=p\\cdot\\nabla_qf-\\nabla U(q)\\cdot\\nabla_pf-\\gamma p\\cdot\\nabla_pf+\\gamma k_BT\\Delta_pf,\\]\nwe can see that $\\mathcal L_H\\varphi=0$. Hence\n\\[\\mathcal L_{LD}\\varphi=-\\gamma p\\cdot\\nabla_p\\varphi+\\gamma k_BT\\Delta_p\\varphi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.hamiltonianPowerGenerator",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinHamiltonianPower_differentialOperator"
  ],
  "extra_assumptions": [
    "[EXTRA]实际全坐标一二阶导数与完整H^l，现成通用σ算子取σ=√(2γkBT)使σ²/2=γkBT；不是给定目标导数再改写。物理热参数代入在下一完整Lyapunov桥接实际出现。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem hamiltonianPowerGenerator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U) (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z =
      -γ * l * textbookLangevinHamiltonian U z ^ (l - 1) * (∑ i, z.2 i ^ 2) +
        σ ^ 2 / 2 * ((l : ℝ) * ((l : ℝ) - 1) * textbookLangevinHamiltonian U z ^ (l - 2) *
          (∑ i, z.2 i ^ 2) + (Nc : ℝ) * l * textbookLangevinHamiltonian U z ^ (l - 1))
```

### MD-6.4.4-LaplacianBoundCorrect
```json
{
  "source_id": "MD-6.4.4-LaplacianBoundCorrect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "\\[\\Delta_p\\varphi=l(l-1)H^{l-2}\\|p\\|^2+N_clH^{l-1}\\le l(l+N_c-1)H^{l-1}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.laplacianBoundCorrect",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound"
  ],
  "extra_assumptions": [
    "[EXTRA]修正上界系数为2l(l−1)+Nc l；原错误l(l+Nc−1)另列NEEDS，未静默更换JSON原句。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem laplacianBoundCorrect {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPhase Nc) :
    (∑ i : Fin Nc, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z + t • ((0 : Fin Nc → ℝ), Pi.single i 1)))) 0) ≤
      (2 * (l : ℝ) * ((l : ℝ) - 1) + (Nc : ℝ) * l) * textbookLangevinHamiltonian U z ^ (l - 1)
```

### MD-6.4.4-LyapunovYoungBounds
```json
{
  "source_id": "MD-6.4.4-LyapunovYoungBounds",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253",
  "pdf_page": "274",
  "statement_latex": "As $H^l$ grows faster than $H^{l-1}$, for any fixed $l$ we are able to find positive constants $c$ and $d$ such that\n\\[l(l+N_c-1)H^{l-1}\\le\\tfrac l2H^l+c;\\qquad 2lH^{l-1}U(q)<2lH^{l-1}U_{\\max}\\le\\tfrac l2H^l+d.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "原中间严格U上界需要Umax选严格外界；原错误Laplacian系数不能由这些正确标量估计证明。"
    }
  ],
  "lean_decl": "MD.Ch06.lyapunovYoungBounds",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整同时覆盖原两个标量界与修正系数界，常数可依赖l/n/Umax但不依赖H；H≥1来自已归一物理势。原U(q)<Umax一环需选择严格外界，本条没有从≤假推出<。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "采用非严格上界，并列原有效标量界和正确Laplacian系数所需界；若另选严格外上界才可写原严格号。",
      "corrected_decl": "MD.Ch06.lyapunovYoungBounds_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lyapunovYoungBounds : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c)
```

### MD-6.4.4-LangevinLyapunov
```json
{
  "source_id": "MD-6.4.4-LangevinLyapunov",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "253–254",
  "pdf_page": "274–275",
  "statement_latex": "giving\n\\[\\mathcal L_{LD}\\varphi\\le-2\\gamma l\\varphi+2\\gamma lH^{l-1}U(q)+\\gamma k_BT l(l+N_c-1)H^{l-1}\n\\le-\\gamma l\\varphi+\\gamma k_BT c+\\gamma d\n=-\\alpha\\varphi+\\delta,\\]\nsatisfying Assumption 2. The purpose of using the $l$ exponent in the Lyapunov function is to ensure that we can apply the theorem to a wide enough class of observables, as (6.48) is only valid for functions $f$ with magnitude less than or equal to the Lyapunov function.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinLyapunov",
  "reusable_proofs": [
    "MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov"
  ],
  "extra_assumptions": [
    "[EXTRA]实际单位质量周期模型、归一U≥1、γ/β>0及l≥1；完整正性/紧子水平集/无穷远proper/正δ全域线性恢复界，采用真实更正系数2。原证明计算的错系数仍按原句保留；不是整个Thm6.2或canonical invariance桥接。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem langevinLyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ
```

### MD-6.4.4-LieBracket
```json
{
  "source_id": "MD-6.4.4-LieBracket",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "254",
  "pdf_page": "275",
  "statement_latex": "The Lie bracket of a pair of vector fields $u(z),v(z)$ is another vector field\n\\[[u,v]=v'u-u'v;\\]\nwhere $u'$ is the Jacobian matrix of the vector field $u$. In coordinates, if we let $w=[u,v]$, then the coordinates of $w$ are\n\\[w_i=\\sum_{j=1}^m\\left(u_j\\frac{\\partial v_i}{\\partial z_j}-v_j\\frac{\\partial u_i}{\\partial z_j}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.lieBracket",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Fréchet导数括号，具体性质/迭代均要求适当可微字段；其通用辅助函数的非可微总化值不作经典Jacobian解释。有限坐标式由真实fderiv在basis上取分量。",
    "[EXTRA]实际字段仅需原开域内C¹，输出点属于D，非可微/域外的总化fderiv值不作为经典Jacobian。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def lieBracket {n : ℕ} (D : Set (Fin n → ℝ)) (_hD : IsOpen D)
    (u v : (Fin n → ℝ) → (Fin n → ℝ)) (_hu : ContDiffOn ℝ 1 u D)
    (_hv : ContDiffOn ℝ 1 v D) (x : D) : (Fin n → ℝ) :=
  MolecularDynamics.Chapter06Review.lieBracket u v x
```

### MD-6.4.4-LieBracketProperties
```json
{
  "source_id": "MD-6.4.4-LieBracketProperties",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "6.4.4",
  "printed_page": "254",
  "pdf_page": "275",
  "statement_latex": "The Lie bracket is bilinear and skew symmetric, and the Lie bracket of any vector field with itself is zero.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.lieBracketProperties",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]全部双槽线性、skew及自身零明确，真实全域可微资格；不只保存某一固定字段或单槽例子。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lieBracketProperties : ∀ {n : ℕ} (u v w : (Fin n → ℝ) → (Fin n → ℝ)) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (MolecularDynamics.Chapter06Review.lieBracket (fun x ↦ a • u x+b • v x) w =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u w x+b • MolecularDynamics.Chapter06Review.lieBracket v w x) ∧
  (MolecularDynamics.Chapter06Review.lieBracket u (fun x ↦ a • v x+b • w x) =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u v x+b • MolecularDynamics.Chapter06Review.lieBracket u w x) ∧
  MolecularDynamics.Chapter06Review.lieBracket u v = -MolecularDynamics.Chapter06Review.lieBracket v u ∧
  MolecularDynamics.Chapter06Review.lieBracket u u=0
```

### MD-6.4.4-Definition61
```json
{
  "source_id": "MD-6.4.4-Definition61",
  "kind": "definition",
  "label": "Definition 6.1",
  "section": "6.4.4",
  "printed_page": "254",
  "pdf_page": "275",
  "statement_latex": "Definition 6.1 (Hörmander's Condition) Let $U\\subset\\mathbb R^m$ be open. The SDE (6.43) with $C^\\infty$ vector fields $b_0,b_1,\\ldots,b_r:U\\to\\mathbb R^m$ are said to satisfy Hörmander's condition at $z\\in U$ if the vector space spanned by the collection of iterated Lie brackets\n\\[b_0,b_1,\\ldots,b_r,[b_0,b_1],[b_0,b_2],\\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\\ldots\\]\n(evaluated at $z$) is $\\mathbb R^m$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "印刷定义将漂移b0直接纳入张成族；用于转移密度的抛物型Hörmander条件需区分仅由噪声及其与漂移括号生成的族。"
    }
  ],
  "lean_decl": "MD.Ch06.definition61",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Fin(S+1)完整包含原drift b0与全部噪声，实际无限次括号及实span；明确C∞字段资格。保留原定义含b0，不冒充一般parabolic噪声生成条件；具体Langevin rank另证。",
    "[EXTRA]原开域U和域内点完整保留；坐标字段全空间任意总化只用于函数表示，C∞仅要求在原开域，不要求全局光滑延拓。开域内真实fderiv/全部迭代括号是局部对象。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "date": "2026-10-17",
      "action": "directive22_printed_corrected_pair",
      "change": "用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。",
      "corrected_decl": "MD.Ch06.definition61_corrected",
      "website": "未提交；待网站审计"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def definition61 {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x

/-- 修正版，对应原文 MD-6.4.4-Definition61；改动：用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。 -/
def parabolicNoiseBracketLevels {m S : ℕ}
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) : ℕ → Set ((Fin m → ℝ) → (Fin m → ℝ))
  | 0 => Set.range (fun i : Fin S ↦ b i.succ)
  | k+1 => parabolicNoiseBracketLevels b k ∪
      {w | ∃ u ∈ parabolicNoiseBracketLevels b k, ∃ i : Fin (S+1),
        w=MolecularDynamics.Chapter06Review.lieBracket (b i) u}

def definition61_corrected {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧
    Submodule.span ℝ {v | ∃ k : ℕ, ∃ w ∈ parabolicNoiseBracketLevels b k, v=w x}=⊤

/-- 【原书疑误】保留原含漂移的张成条件，不能据此推出一般转移密度。 -/
def definition61Printed {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x
```

### MD-6.4.4-LangevinFields
```json
{
  "source_id": "MD-6.4.4-LangevinFields",
  "kind": "definition",
  "label": null,
  "section": "6.4.4",
  "printed_page": "255",
  "pdf_page": "276",
  "statement_latex": "For Langevin dynamics we have\n\\[b_0=\\begin{bmatrix}p\\\\-\\nabla U(q)-\\gamma p\\end{bmatrix};\\qquad b_i=\\sigma\\begin{bmatrix}0\\\\e_i\\end{bmatrix},\\quad i=1,\\ldots,N_c,\\]\nwhere $\\sigma=\\sqrt{2\\gamma k_BT}$ and $e_i$ is the $i$th coordinate unit vector in $\\mathbb R^{N_c}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch06.langevinDrift",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际全部2Nc相空间坐标的真实drift/noise，C∞势资格编码，通用σ在物理定理取√(2γkBT)；不把noise定义计作独立Wiener law或密度存在证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def langevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) (_hU : ContDiff ℝ ∞ U) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

def langevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)
```

