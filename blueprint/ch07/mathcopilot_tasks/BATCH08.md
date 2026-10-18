# BATCH08 第7章原文与陈述审校

## MD-7.4.2-BBKStarMomentSystemPrinted
```json
{
  "source_id": "MD-7.4.2-BBKStarMomentSystemPrinted",
  "kind": "definition",
  "label": null,
  "section": "7.4.2",
  "printed_page": "278–279",
  "pdf_page": "299–300",
  "statement_latex": "Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives\n\\[Q=\\psi_{11}^2Q+\\psi_{12}^2P+2\\psi_{11}\\psi_{12}C+2\\psi_{12}\\kappa_1 2\\psi_{12}\\kappa_1\\kappa_3+\\kappa_1^2,\\]\n\\[P=\\psi_{21}^2Q+\\psi_{22}^2P+2\\psi_{21}\\psi_{22}C+2\\psi_{22}\\kappa_2 2\\psi_{22}\\kappa_2\\kappa_3+\\kappa_2^2+\\kappa_3^2,\\]\n\\[C=\\psi_{11}\\psi_{21}Q+\\psi_{12}\\psi_{22}P+(\\psi_{11}\\psi_{22}+\\psi_{12}\\psi_{21})C+\\kappa_1\\kappa_2+\\psi_{12}\\kappa_2\\kappa_3+\\psi_{22}\\kappa_1\\kappa_3.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。"
  ],
  "issues": [
    "已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarMomentSystemPrinted",
  "lean_declarations": [
    "MD.Ch07.bbkStarMomentSystemPrinted",
    "MD.Ch07.bbkStarMomentSystemPrinted_corrected",
    "MD.Ch07.bbkStarExtraFactor_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num
```

## MD-7.4.2-BBKStarStationary
```json
{
  "source_id": "MD-7.4.2-BBKStarStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.2",
  "printed_page": "279",
  "pdf_page": "300",
  "statement_latex": "Finally, solving the simultaneous equations gives the stationary observed averages as\n\\[\\langle q^2\\rangle_h^{\\rm BBK*}=\\frac{k_BT}{\\Omega^2}(1-\\frac{\\Omega^2h^2}{4m})^{-1},\\qquad\n\\langle p^2\\rangle_h^{\\rm BBK*}=k_BTm(1+\\frac{\\gamma h}2)^{-1},\\qquad\n\\langle qp\\rangle_h^{\\rm BBK*}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。"
  ],
  "issues": [],
  "statement_scope": "给定正确矩方程的代数求解及全部三矩值；未证明BBK*长期收敛。",
  "lean_decl": "MD.Ch07.bbkStarStationaryAlgebra",
  "lean_declarations": [
    "MD.Ch07.bbkStarStationaryAlgebra"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry
```

## MD-7.5-PerturbedHamiltonian
```json
{
  "source_id": "MD-7.5-PerturbedHamiltonian",
  "kind": "definition",
  "label": "(7.13)",
  "section": "7.5",
  "printed_page": "279",
  "pdf_page": "300",
  "statement_latex": "We consider sampling canonically the Hamiltonian\n\\[H(q,p)=p^2/2+q^2/2+\\epsilon q^4/4,\\tag{7.13}\\]\nusing Langevin dynamics, where $q,p\\in\\mathbb R$, with a small nonlinearity parameter $\\epsilon>0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。",
    "分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.perturbedPotential",
  "lean_declarations": [
    "MD.Ch07.perturbedPotential",
    "MD.Ch07.perturbedHamiltonian",
    "MD.Ch07.perturbedGibbs",
    "MD.Ch07.perturbedStep",
    "MD.Ch07.perturbedStationary"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def perturbedPotential (ε q : ℝ) : ℝ := q^2/2+ε*q^4/4
def perturbedHamiltonian (ε : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/2+perturbedPotential ε x.1
def perturbedGibbs (ε : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-perturbedHamiltonian ε x)
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def perturbedStep (s : Fin 4) (ε γ h R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let m : V 1 := fun _ ↦ 1
  let U : V 1 → ℝ := fun q ↦ perturbedPotential ε (q 0)
  scalarLift (if s = 0 then aboba m U γ 1 h (fun _ ↦ R)
    else if s = 1 then baoab m U γ 1 h (fun _ ↦ R)
    else if s = 2 then obabo m U γ 1 h (fun _ ↦ R) (fun _ ↦ S)
    else oabao m U γ 1 h (fun _ ↦ R) (fun _ ↦ S))
def perturbedStationary (s : Fin 4) (ε γ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ perturbedStep s ε γ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ
```

## MD-7.5-PerturbedErrorExpansion
```json
{
  "source_id": "MD-7.5-PerturbedErrorExpansion",
  "kind": "unnumbered_claim",
  "label": "(7.14)",
  "section": "7.5",
  "printed_page": "280",
  "pdf_page": "301",
  "statement_latex": "We find that truncating the update equations to $O(\\epsilon^3)$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:\n\\[\\langle q^2\\rangle_h^{[ABOBA]}-\\langle q^2\\rangle=\\frac{3h^2\\epsilon[48\\epsilon-4+3\\gamma^2(9\\epsilon-1)]}{12\\gamma^2+16}+O(\\epsilon h^4+\\epsilon^3h^2),\\]\n\\[\\langle q^2\\rangle_h^{[BAOAB]}-\\langle q^2\\rangle=-\\frac{9h^2\\epsilon^2}{6\\gamma^2+8}-\\frac{3h^4\\epsilon^2[6\\gamma^4+19\\gamma^2+16]}{8(3\\gamma^2+4)^2}+O(\\epsilon^2h^6+\\epsilon^3h^2),\\]\n\\[\\langle q^2\\rangle_h^{[OBABO]}-\\langle q^2\\rangle=h^2\\left(\\frac14+\\frac{\\epsilon[144\\epsilon+81\\epsilon\\gamma^2-9\\gamma^2-12]}{12\\gamma^2+16}\\right)+O(h^4+\\epsilon^3h^2),\\]\n\\[\\langle q^2\\rangle_h^{[OABAO]}-\\langle q^2\\rangle=-h^2\\left(\\frac14+\\frac{18\\epsilon^2}{12\\gamma^2+16}\\right)+O(h^4+\\epsilon^3h^2).\\tag{7.14}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。",
    "实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.perturbedLeading",
  "lean_declarations": [
    "MD.Ch07.perturbedLeading",
    "MD.Ch07.perturbedRemainder",
    "MD.Ch07.positivePairLimit",
    "MD.Ch07.perturbedErrorExpansion"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def perturbedLeading (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then 3*h^2*ε*(48*ε-4+3*γ^2*(9*ε-1))/(12*γ^2+16)
  else if s = 1 then -9*h^2*ε^2/(6*γ^2+8)-3*h^4*ε^2*(6*γ^4+19*γ^2+16)/(8*(3*γ^2+4)^2)
  else if s = 2 then h^2*(1/4+ε*(144*ε+81*ε*γ^2-9*γ^2-12)/(12*γ^2+16))
  else -h^2*(1/4+18*ε^2/(12*γ^2+16))
def perturbedRemainder (s : Fin 4) (ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^4+ε^3*h^2
  else if s = 1 then ε^2*h^6+ε^3*h^2 else h^4+ε^3*h^2
def positivePairLimit : Filter (ℝ × ℝ) :=
  𝓝[Set.Ioi (0 : ℝ) ×ˢ Set.Ioi (0 : ℝ)] (0,0)
theorem perturbedErrorExpansion (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)-perturbedLeading s γ z.1 z.2)
      (fun z ↦ perturbedRemainder s z.1 z.2) := by
  sorry
```

## MD-7.5-PerturbedErrorOrders
```json
{
  "source_id": "MD-7.5-PerturbedErrorOrders",
  "kind": "unnumbered_claim",
  "label": "(7.15)",
  "section": "7.5",
  "printed_page": "280",
  "pdf_page": "301",
  "statement_latex": "The behavior of the methods can thus be summarized as\n\\[|\\langle q^2\\rangle_h^{[ABOBA]}-\\langle q^2\\rangle|=O(\\epsilon h^2),\\qquad\n|\\langle q^2\\rangle_h^{[BAOAB]}-\\langle q^2\\rangle|=O\\left(\\frac{\\epsilon^2h^2}{1+\\gamma^2}+\\epsilon^2h^4\\right),\\]\n\\[|\\langle q^2\\rangle_h^{[OBABO]}-\\langle q^2\\rangle|=O(h^2),\\qquad\n|\\langle q^2\\rangle_h^{[OABAO]}-\\langle q^2\\rangle|=O(h^2).\\tag{7.15}\\]\nThe twofold surprising result though, is that (a) the leading error of the $[BAOAB]$ scheme has behavior proportional to $\\epsilon^2$, while (b) the leading order term of the $[BAOAB]$ scheme is annihilated for large $\\gamma$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "双参数正向极限已明确；γ固定的常数不等于γ一致误差界。原书(7.14)的ε³h²余项不足以单独推出BAOAB的ε²h²+ε²h⁴界，需要额外结构；保留为待证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.perturbedErrorScale",
  "lean_declarations": [
    "MD.Ch07.perturbedErrorScale",
    "MD.Ch07.perturbedErrorOrders",
    "MD.Ch07.baoabLeading_largeFriction"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def perturbedErrorScale (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^2 else if s = 1 then ε^2*h^2/(1+γ^2)+ε^2*h^4 else h^2
theorem perturbedErrorOrders (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ |momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)|)
      (fun z ↦ perturbedErrorScale s γ z.1 z.2) := by
  sorry
theorem baoabLeading_largeFriction (ε h : ℝ) :
    Filter.Tendsto (fun γ : ℝ ↦ -9*h^2*ε^2/(6*γ^2+8)) Filter.atTop (𝓝 0) := by
  sorry
```
