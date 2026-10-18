# BATCH11 第7章原文与陈述审校

## MD-7.7.2-ScalarForwardOperators
```json
{
  "source_id": "MD-7.7.2-ScalarForwardOperators",
  "kind": "definition",
  "label": null,
  "section": "7.7.2",
  "printed_page": "288",
  "pdf_page": "309",
  "statement_latex": "In this one dimensional example, we substitute\n\\[Z=\\mathcal L_A^\\dagger=-p\\frac\\partial{\\partial q},\\quad Y=\\mathcal L_B^\\dagger=U'(q)\\frac\\partial{\\partial p},\\quad\nX=\\mathcal L_O^\\dagger=\\gamma\\left({\\rm Id}+p\\frac\\partial{\\partial p}\\right)+\\frac{\\sigma^2}{2}\\frac{\\partial^2}{\\partial p^2},\\]\nwhere $\\sigma=\\sqrt{2\\gamma k_BT}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "所有偏导都是实际deriv，单位质量、θ=k_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.Density1",
  "lean_declarations": [
    "MD.Ch07.Density1",
    "MD.Ch07.dq",
    "MD.Ch07.dp",
    "MD.Ch07.opA",
    "MD.Ch07.opB",
    "MD.Ch07.opO",
    "MD.Ch07.opLD",
    "MD.Ch07.opComm"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev Density1 := (ℝ × ℝ) → ℝ
def dq (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun q ↦ f (q,x.2)) x.1
def dp (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun p ↦ f (x.1,p)) x.2
def opA (f : Density1) (x : ℝ × ℝ) : ℝ := -x.2*dq f x
def opB (U : ℝ → ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := deriv U x.1*dp f x
def opO (γ θ : ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := γ*(f x+x.2*dp f x)+γ*θ*dp (dp f) x
def opLD (U : ℝ → ℝ) (γ θ : ℝ) (f : Density1) : Density1 := opA f+opB U f+opO γ θ f
def opComm (A B : Density1 → Density1) (f : Density1) : Density1 := A (B f)-B (A f)
```

## MD-7.7.2-CommutatorAB
```json
{
  "source_id": "MD-7.7.2-CommutatorAB",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.2",
  "printed_page": "288",
  "pdf_page": "309",
  "statement_latex": "\\[[\\mathcal L_A^\\dagger,\\mathcal L_B^\\dagger]\\rho=-p\\frac\\partial{\\partial q}\\left(U'(q)\\frac{\\partial\\rho}{\\partial p}\\right)-U'(q)\\frac\\partial{\\partial p}\\left(-p\\frac{\\partial\\rho}{\\partial q}\\right)\n=-pU''(q)\\rho_p-pU'(q)\\rho_{pq}+U'(q)\\rho_q+U'(q)p\\rho_{qp}.\\]\nAs this is the commutator of two 1st order differential operators, the mixed partial term vanishes, leaving\n\\[[\\mathcal L_A^\\dagger,\\mathcal L_B^\\dagger]\\rho=-pU''(q)\\rho_p+U'(q)\\rho_q.\\]",
  "proof_latex": "Expand both product derivatives and cancel the mixed partials using equality of mixed partials.",
  "proof_note": "按所列原页转录原书证明。",
  "context_notation": [],
  "extra_assumptions": [],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.commutatorAB",
  "lean_declarations": [
    "MD.Ch07.commutatorAB"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry
```

## MD-7.7.2-CommutatorsAOBO
```json
{
  "source_id": "MD-7.7.2-CommutatorsAOBO",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.2",
  "printed_page": "289",
  "pdf_page": "310",
  "statement_latex": "Similar computations give\n\\[[\\mathcal L_A^\\dagger,\\mathcal L_O^\\dagger]\\rho=\\gamma p\\rho_q+\\sigma^2\\rho_{qp},\\qquad\n[\\mathcal L_B^\\dagger,\\mathcal L_O^\\dagger]\\rho=\\gamma U'(q)\\rho_p.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.commutatorsAOBO",
  "lean_declarations": [
    "MD.Ch07.commutatorsAOBO"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry
```

## MD-7.7.2-OBAModifiedOperator
```json
{
  "source_id": "MD-7.7.2-OBAModifiedOperator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.2",
  "printed_page": "288–289",
  "pdf_page": "309–310",
  "statement_latex": "\\[\\exp(h\\widehat{\\mathcal L}_{[OBA]}^\\dagger)=\\exp(h\\mathcal L_A^\\dagger)\\exp(h\\mathcal L_B^\\dagger)\\exp(h\\mathcal L_O^\\dagger).\\]\n\\[\\widehat{\\mathcal L}_{[OBA]}^\\dagger\\rho=\\mathcal L_{LD}^\\dagger\\rho+\\frac h2[-pU''(q)\\rho_p+U'(q)\\rho_q+\\gamma p\\rho_q+\\sigma^2\\rho_{qp}+\\gamma U'(q)\\rho_p]+O(h^2).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.obaFirstCorrection",
  "lean_declarations": [
    "MD.Ch07.obaFirstCorrection",
    "MD.Ch07.obaFirstCorrection_commutators"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring
```

## MD-7.7.2-SpectralQualification
```json
{
  "source_id": "MD-7.7.2-SpectralQualification",
  "kind": "definition",
  "label": null,
  "section": "7.7.2",
  "printed_page": "289",
  "pdf_page": "310",
  "statement_latex": "The assumption of validity becomes more credible as we find that the operator $\\mathcal L_{LD}^\\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\\rho_\\beta$ and all the remaining eigenvalues lie in the negative half plane.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。"
  ],
  "issues": [
    "已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。"
  ],
  "statement_scope": "原文谱断言已登记，Lean定义其点谱目标；尚缺无界算符对象和完整限定定理。",
  "lean_decl": "MD.Ch07.simpleEigenvalue",
  "lean_declarations": [
    "MD.Ch07.simpleEigenvalue",
    "MD.Ch07.printedSpectralConclusion"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)
```

## MD-7.7.3-PerturbationCoefficientEquation
```json
{
  "source_id": "MD-7.7.3-PerturbationCoefficientEquation",
  "kind": "unnumbered_claim",
  "label": "(7.19)",
  "section": "7.7.3",
  "printed_page": "289–290",
  "pdf_page": "310–311",
  "statement_latex": "Inserting this ansatz into the stationary Fokker-Planck equation $\\widehat{\\mathcal L}^\\dagger\\widehat\\rho=0$, we obtain\n\\[(\\mathcal L_{LD}^\\dagger+h\\mathcal L_1^\\dagger+h^2\\mathcal L_2^\\dagger+O(h^3))(\\rho_\\beta[1+hf_1+h^2f_2+O(h^3)])=0.\\]\nCombining like powers, we have at zero’th order, the equation $\\mathcal L_{LD}^\\dagger\\rho_\\beta=0$.\nAt first order we obtain\n\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_1)+\\mathcal L_1^\\dagger\\rho_\\beta=0.\\tag{7.19}\\]",
  "proof_latex": "Insert the two formal series into the stationary equation and combine like powers of h.",
  "proof_note": "按所列原页转录原书证明。",
  "context_notation": [],
  "extra_assumptions": [
    "在真实线性作用的形式系数卷积上推导0阶和1阶必要方程；并未由这些必要方程证明原离散链存在不变分布。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.actionCoefficient",
  "lean_declarations": [
    "MD.Ch07.actionCoefficient",
    "MD.Ch07.perturbationCoefficientEquation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def actionCoefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E) (k : ℕ) : E :=
  ∑ j ∈ Finset.range (k+1), L j (ρ (k-j))
theorem perturbationCoefficientEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (h0 : actionCoefficient L ρ 0 = 0) (h1 : actionCoefficient L ρ 1 = 0) :
    L 0 (ρ 0) = 0 ∧ L 0 (ρ 1)+L 1 (ρ 0) = 0 := by
  constructor
  · simpa [actionCoefficient] using h0
  · simpa [actionCoefficient, Finset.sum_range_succ] using h1
```
