# BATCH12 第7章原文与陈述审校

## MD-7.7.3-ObservableCorrectionExpansion
```json
{
  "source_id": "MD-7.7.3-ObservableCorrectionExpansion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.3",
  "printed_page": "290",
  "pdf_page": "311",
  "statement_latex": "For some observable $\\vartheta(q,p)$, we have that\n\\[\\langle\\vartheta\\rangle_h=\\int_{\\mathcal D}\\vartheta(q,p)\\widehat\\rho(q,p)d\\omega\n=\\int_{\\mathcal D}\\vartheta(q,p)\\rho_\\beta(q,p)(1+hf_1(q,p)+h^2f_2(q,p)+\\cdots)d\\omega\n=\\langle\\vartheta\\rangle+h\\langle\\vartheta f_1\\rangle+h^2\\langle\\vartheta f_2\\rangle+\\cdots.\\]",
  "proof_latex": "Distribute the product and use linearity of integration at each finite order.",
  "proof_note": "按所列原页转录原书证明。",
  "context_notation": [],
  "extra_assumptions": [
    "完整覆盖0–2阶有限截断积分；无限级数交换与实际误差余项仍需支配收敛及弱展开理论，明确不声称已证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.observableCorrectionExpansion",
  "lean_declarations": [
    "MD.Ch07.observableCorrectionExpansion"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem observableCorrectionExpansion (ν : Measure Ω) (φ ρ f1 f2 : Ω → ℝ) (h : ℝ)
    (h0 : Integrable (fun x ↦ φ x*ρ x) ν)
    (h1 : Integrable (fun x ↦ φ x*ρ x*f1 x) ν)
    (h2 : Integrable (fun x ↦ φ x*ρ x*f2 x) ν) :
    (∫ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) ∂ν) =
      (∫ x, φ x*ρ x ∂ν)+h*(∫ x, φ x*ρ x*f1 x ∂ν)+h^2*(∫ x, φ x*ρ x*f2 x ∂ν) := by
  have heq : ∀ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) =
      (φ x*ρ x+h*(φ x*ρ x*f1 x))+h^2*(φ x*ρ x*f2 x) := by intro x; ring
  simp_rw [heq]
  have hout := integral_add (h0.add (h1.const_mul h)) (h2.const_mul (h^2))
  have hin := integral_add h0 (h1.const_mul h)
  simp only [Pi.add_apply] at hout hin
  rw [hout, hin, integral_const_mul, integral_const_mul]
```

## MD-7.7.3-PerturbativeSolvabilityCaution
```json
{
  "source_id": "MD-7.7.3-PerturbativeSolvabilityCaution",
  "kind": "definition",
  "label": null,
  "section": "7.7.3",
  "printed_page": "290",
  "pdf_page": "311",
  "statement_latex": "It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $\\mathcal L_{LD}^\\dagger$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。",
    "不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "可解性目标与原书未证明的预期已登记；指数稳定和全局半群存在不作为已获定理。",
  "lean_decl": "MD.Ch07.correctionSolvable",
  "lean_declarations": [
    "MD.Ch07.correctionSolvable"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def correctionSolvable {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (rhs : E) : Prop := ∃ u : E, L u = rhs
```
