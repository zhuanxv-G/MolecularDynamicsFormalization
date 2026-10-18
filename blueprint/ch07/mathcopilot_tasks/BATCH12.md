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

## MD-7.8-FirstOrderOperator
```json
{
  "source_id": "MD-7.8-FirstOrderOperator",
  "kind": "unnumbered_claim",
  "label": "(7.20)–(7.21)",
  "section": "7.8",
  "printed_page": "291",
  "pdf_page": "312",
  "statement_latex": "By composing the semigroup operators\n\\[\\exp(h\\widehat{\\mathcal L}_{[XYZ]}^\\dagger)=\\exp(h\\mathcal L_Z^\\dagger)\\exp(h\\mathcal L_Y^\\dagger)\\exp(h\\mathcal L_X^\\dagger),\\]\nand computing the terms in the BCH expansion, we have\n\\[\\widehat{\\mathcal L}_{[XYZ]}^\\dagger=\\mathcal L_{LD}^\\dagger+h\\mathcal L_{1,[XYZ]}^\\dagger+O(h^2),\\]\nwhere\n\\[\\mathcal L_{1,[XYZ]}^\\dagger=-\\frac12([\\mathcal L_X^\\dagger,\\mathcal L_Y^\\dagger]+[\\mathcal L_X^\\dagger,\\mathcal L_Z^\\dagger]+[\\mathcal L_Y^\\dagger,\\mathcal L_Z^\\dagger]).\\tag{7.20}\\]\nThe first order correction function for this scheme is then given by the particular solution to the PDE,\n\\[\\mathcal L_{LD}^\\dagger(f_{1,[XYZ]}\\rho_\\beta)=-\\mathcal L_{1,[XYZ]}^\\dagger\\rho_\\beta.\\tag{7.21}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "前向组合采用Z,Y,X顺序；正式级数系数推论覆盖所有六个排列，L0为三者和。修正方程为必要形式方程，可解性独立。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.firstOrderOperator",
  "lean_declarations": [
    "MD.Ch07.firstOrderOperator",
    "MD.Ch07.firstOrderOperator_coefficient",
    "MD.Ch07.correctionEquation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def firstOrderOperator {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : R :=
  (-1/2 : ℝ) • (comm X Y+comm X Z+comm Y Z)
theorem firstOrderOperator_coefficient {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) = firstOrderOperator X Y Z := by
  sorry
def correctionEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L L1 : Module.End ℝ E) (ρ ρf : E) : Prop := L ρf = -L1 ρ
```

## MD-7.8-HomogeneousNormalization
```json
{
  "source_id": "MD-7.8-HomogeneousNormalization",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8",
  "printed_page": "291",
  "pdf_page": "312",
  "statement_latex": "The general solution of (7.21) will consist of the sum of the homogeneous solution $f_{1,[XYZ]}^{[HS]}(q,p)$ and particular solution $f_{1,[XYZ]}^{[PS]}(q,p)$ in the usual way. However, since $\\mathcal L_{LD}^\\dagger\\vartheta=0$ has as its only solution $\\vartheta\\propto\\rho_\\beta$, the homogeneous solution of (7.21) is $f_{1,[XYZ]}^{[HS]}(q,p)=c$, for some constant $c$. Our assumption that $\\langle f_{1,[XYZ]}\\rangle=0$ means that $c=-\\langle f_{1,[XYZ]}^{[PS]}\\rangle$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "核恰为ρ的一维空间是明确前提；不把Langevin核唯一性当作已证明。第二条为实际概率归一化的中心化恒等式。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.homogeneousNormalization",
  "lean_declarations": [
    "MD.Ch07.homogeneousNormalization",
    "MD.Ch07.centeredParticular"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem homogeneousNormalization {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ u v rhs : E)
    (hker : ∀ w, L w = 0 → ∃ c : ℝ, w = c • ρ)
    (hu : L u = rhs) (hv : L v = rhs) : ∃ c : ℝ, u = v+c • ρ := by
  obtain ⟨c,hc⟩ := hker (u-v) (by rw [map_sub,hu,hv,sub_self])
  exact ⟨c,by rw [← hc]; abel⟩
theorem centeredParticular (μ : Measure Ω) [IsProbabilityMeasure μ] (f : Ω → ℝ)
    (hf : Integrable f μ) : (∫ x, f x-(∫ y, f y ∂μ) ∂μ) = 0 := by
  rw [integral_sub hf (integrable_const _)]
  simp
```

## MD-7.8.1-CommutatorPermutationRelations
```json
{
  "source_id": "MD-7.8.1-CommutatorPermutationRelations",
  "kind": "unnumbered_claim",
  "label": "(7.22)–(7.24)",
  "section": "7.8.1",
  "printed_page": "292",
  "pdf_page": "313",
  "statement_latex": "\\[([\\mathcal L_O^\\dagger,\\mathcal L_A^\\dagger]+[\\mathcal L_O^\\dagger,\\mathcal L_B^\\dagger])\\rho_\\beta=[\\mathcal L_O^\\dagger,\\mathcal L_A^\\dagger+\\mathcal L_B^\\dagger]\\rho_\\beta=0.\\]\n\\[\\mathcal L_{1,[ABO]}^\\dagger\\rho_\\beta=\\mathcal L_{1,[OAB]}^\\dagger\\rho_\\beta=-\\mathcal L_{1,[OBA]}^\\dagger\\rho_\\beta=-\\mathcal L_{1,[BAO]}^\\dagger\\rho_\\beta=-\\frac12[\\mathcal L_A^\\dagger,\\mathcal L_B^\\dagger]\\rho_\\beta.\\tag{7.22}\\]\n\\[f_{1,[ABO]}=f_{1,[OAB]}=-f_{1,[OBA]}=-f_{1,[BAO]}.\\tag{7.23}\\]\n\\[\\mathcal L_{1,[AOB]}^\\dagger\\rho_\\beta=-\\mathcal L_{1,[BOA]}^\\dagger\\rho_\\beta=-\\frac12[\\mathcal L_A^\\dagger-\\mathcal L_B^\\dagger,\\mathcal L_O^\\dagger]\\rho_\\beta+\\mathcal L_{1,[ABO]}^\\dagger\\rho_\\beta.\\tag{7.24}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。"
  ],
  "issues": [],
  "statement_scope": "首式及(7.22),(7.24)全部算符作用关系；(7.23)需归一解唯一性桥，未另作Lean定理。",
  "lean_decl": "MD.Ch07.commutatorPermutationRelations",
  "lean_declarations": [
    "MD.Ch07.commutatorPermutationRelations"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem commutatorPermutationRelations {E : Type*} [AddCommGroup E] [Module ℝ E]
    (A B O : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (A+B) ρ = 0) :
    (comm O A+comm O B) ρ = 0 ∧
    firstOrderOperator A B O ρ = firstOrderOperator O A B ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator O B A ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator B A O ρ ∧
    firstOrderOperator A B O ρ = (-1/2 : ℝ) • comm A B ρ ∧
    firstOrderOperator A O B ρ = -firstOrderOperator B O A ρ ∧
    firstOrderOperator A O B ρ = (-1/2 : ℝ) • comm (A-B) O ρ+firstOrderOperator A B O ρ := by
  sorry
```

## MD-7.8.1-GibbsDerivativeIdentities
```json
{
  "source_id": "MD-7.8.1-GibbsDerivativeIdentities",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.1",
  "printed_page": "292–293",
  "pdf_page": "313–314",
  "statement_latex": "If we define the function $g(q,p)$ as $g(q,p)=\\beta p^TM^{-1}\\nabla U(q)$, then through simple computation we have\n\\[\\mathcal L_A^\\dagger\\rho_\\beta=-\\mathcal L_B^\\dagger\\rho_\\beta=g(q,p)\\rho_\\beta.\\]\n\\[[\\mathcal L_A^\\dagger,\\mathcal L_B^\\dagger]\\rho_\\beta=-(\\mathcal L_A^\\dagger+\\mathcal L_B^\\dagger)(g\\rho_\\beta)=(\\mathcal L_O^\\dagger-\\mathcal L_{LD}^\\dagger)(g\\rho_\\beta).\\]\nFor a function $\\psi(q)$ purely of position, we have\n\\[\\mathcal L_{LD}^\\dagger(\\psi(q)\\rho_\\beta)=-(p^TM^{-1}\\nabla\\psi(q))\\rho_\\beta(q,p),\\]\nand hence we can compute\n\\[\\mathcal L_O^\\dagger(g(q,p)\\rho_\\beta)=\\gamma\\rho_\\beta(-p\\cdot\\nabla_pg+\\beta^{-1}\\nabla_p\\cdot M\\nabla_pg)\n=-\\gamma g\\rho_\\beta=\\gamma\\beta\\mathcal L_{LD}^\\dagger(U(q)\\rho_\\beta).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "ρ为未归一Gibbs权，所有微分等式对常数归一化同样成立；实际概率还要正有限配分积分。所有质量正、β>0、光滑资格明示。",
    "覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.mechanicalHamiltonian",
  "lean_declarations": [
    "MD.Ch07.mechanicalHamiltonian",
    "MD.Ch07.gibbsWeight",
    "MD.Ch07.gFunction",
    "MD.Ch07.phaseO",
    "MD.Ch07.phaseLD",
    "MD.Ch07.gibbsDerivativeIdentities"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def mechanicalHamiltonian (m : V n) (U : V n → ℝ) (x : Phase n) : ℝ :=
  (∑ i, x.2 i^2/(2*m i))+U x.1
def gibbsWeight (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  Real.exp (-β*mechanicalHamiltonian m U x)
def gFunction (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*∑ i, x.2 i/m i*gradient U x.1 i
def phaseO (m : V n) (γ β : ℝ) (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ouForward m γ β⁻¹ (fun p ↦ ρ (x.1,p)) x.2
def phaseLD (m : V n) (U : V n → ℝ) (γ β : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  aForward m ρ+bForward U ρ+phaseO m γ β ρ
theorem gibbsDerivativeIdentities (m : V n) (U ψ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) (hψ : ContDiff ℝ ⊤ ψ) :
    let ρ := gibbsWeight m U β
    let g := gFunction m U β
    aForward m ρ = g*ρ ∧ bForward U ρ = -(g*ρ) ∧
    phaseLD m U γ β (fun x ↦ ψ x.1*ρ x) =
      (fun x ↦ -(∑ i, x.2 i/m i*gradient ψ x.1 i)*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ -γ*g x*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ γ*β*phaseLD m U γ β (fun y ↦ U y.1*ρ y) x) := by
  sorry
```
