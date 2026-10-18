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
  "proof_latex": null,
  "proof_outline": "Distribute the product and use linearity of integration at each finite order.",
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 311,
      "printed_page": 290,
      "text": "290\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwe obtain\n\u0006\nL\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/\n\u0007 \u0004\n\u0005ˇŒ1 C hf1 C h2f2 C O.h3/\t\n\u0005\nD 0:\nCombining like powers, we have at zero’th order, the equation\nL\u0004\nLD\u0005ˇ D 0;\nwhich we know to hold since Langevin dynamics preserves the canonical ensemble.\nAt ﬁrst order we obtain\nL\u0004\nLD.\u0005ˇf1/ C L\u0004\n1\u0005ˇ D 0:\n(7.19)\nIf L\u0004\n1 is known, we can calculate its action on \u0005ˇ, giving an inhomogeneity for\nthe above partial differential equation. It will be difﬁcult to solve the perturbation\nequation (7.19) in general, although its linearity and the fact that L\u0004\nLD (with our\nassumptions) has a compact resolvent (and therefore a discrete spectrum) together\nimply that if the perturbation can be bounded, then it should be possible to solve for\nthe correction function. We expect that this solution should be stable with respect\nto perturbation (and exponentially attracting). This also implies global existence\n(for all positive time) of the semigroup deﬁning the solution of the time-dependent\nproblem. We do not provide such a rigorous result here but simply plunge ahead,\nin the best tradition of applied mathematics, to obtain a perturbative expansion;\nveriﬁcation of our results must therefore be obtained by numerical experiment, a\nposteriori.\nThe leading order errors can be computed in simulation by exploiting the speciﬁc\nform of our ansatz for the invariant measure associated to the discretized dynamics.\nFor some observable #.q; p/, we have that\nh#ih D\nZ\nD\n#.q; p/ O\u0005.q; p/d!;\nD\nZ\nD\n#.q; p/\u0005ˇ.q; p/.1 C hf1.q; p/ C h2f2.q; p/ C : : :/d!;\nD\nZ\nD\n#.q; p/\u0005ˇ.q; p/d! C h\nZ\nD\n#.q; p/f1.q; p/\u0005ˇ.q; p/d! C : : : ;\nD h#i C hh#f1i C h2h#f2i C : : : :\nHence by obtaining the correction functions fi, we are able to apply a modiﬁcation\nto our computed expectation in order to recover the true canonical average.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 311,
      "printed_page": 290,
      "text": "290\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwe obtain\n\u0006\nL\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/\n\u0007 \u0004\n\u0005ˇŒ1 C hf1 C h2f2 C O.h3/\t\n\u0005\nD 0:\nCombining like powers, we have at zero’th order, the equation\nL\u0004\nLD\u0005ˇ D 0;\nwhich we know to hold since Langevin dynamics preserves the canonical ensemble.\nAt ﬁrst order we obtain\nL\u0004\nLD.\u0005ˇf1/ C L\u0004\n1\u0005ˇ D 0:\n(7.19)\nIf L\u0004\n1 is known, we can calculate its action on \u0005ˇ, giving an inhomogeneity for\nthe above partial differential equation. It will be difﬁcult to solve the perturbation\nequation (7.19) in general, although its linearity and the fact that L\u0004\nLD (with our\nassumptions) has a compact resolvent (and therefore a discrete spectrum) together\nimply that if the perturbation can be bounded, then it should be possible to solve for\nthe correction function. We expect that this solution should be stable with respect\nto perturbation (and exponentially attracting). This also implies global existence\n(for all positive time) of the semigroup deﬁning the solution of the time-dependent\nproblem. We do not provide such a rigorous result here but simply plunge ahead,\nin the best tradition of applied mathematics, to obtain a perturbative expansion;\nveriﬁcation of our results must therefore be obtained by numerical experiment, a\nposteriori.\nThe leading order errors can be computed in simulation by exploiting the speciﬁc\nform of our ansatz for the invariant measure associated to the discretized dynamics.\nFor some observable #.q; p/, we have that\nh#ih D\nZ\nD\n#.q; p/ O\u0005.q; p/d!;\nD\nZ\nD\n#.q; p/\u0005ˇ.q; p/.1 C hf1.q; p/ C h2f2.q; p/ C : : :/d!;\nD\nZ\nD\n#.q; p/\u0005ˇ.q; p/d! C h\nZ\nD\n#.q; p/f1.q; p/\u0005ˇ.q; p/d! C : : : ;\nD h#i C hh#f1i C h2h#f2i C : : : :\nHence by obtaining the correction functions fi, we are able to apply a modiﬁcation\nto our computed expectation in order to recover the true canonical average.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 312,
      "printed_page": 291,
      "text": "7.8\nFirst Order Schemes\n291\n7.8\nFirst Order Schemes\nLet us consider a scheme of the form \u0002XYZ\u0003, where each letter in the string is\ndistinct and corresponds to one of the A, B or O Langevin splitting pieces (giving six\npossible schemes). Given the simple structure of the scheme, we expect to recover a\nﬁrst order error in our invariant (long-time) averages. By composing the semigroup\noperators\nexp.hL\u0004\n\u0002XYZ\u0003/ D exp.hL\u0004\nZ/ exp.hL\u0004\nY/ exp.hL\u0004\nX/;\nand computing the terms in the BCH expansion, we have\nOL\u0004\n\u0002XYZ\u0003 D L\u0004\nLD C hL\u0004\n1;\u0002XYZ\u0003 C O.h2/;\nwhere\nL\u0004\n1;\u0002XYZ\u0003 D \u00031\n2\n\u0006\nŒL\u0004\nX; L\u0004\nY\t C ŒL\u0004\nX; L\u0004\nZ\t C ŒL\u0004\nY; L\u0004\nZ\t\n\u0007\n:\n(7.20)\nThe ﬁrst order correction function for this scheme is then given by the particular\nsolution to the PDE,\nL\u0004\nLD\n\u0004\nf1;\u0002XYZ\u0003\u0005ˇ\n\u0005\nD \u0003L\u0004\n1;\u0002XYZ\u0003\u0005ˇ:\n(7.21)\nThe general solution of (7.21) will consist of the sum of the homogeneous solution\nf ŒHS\t\n1;\u0002XYZ\u0003.q; p/ and particular solution f ŒPS\t\n1;\u0002XYZ\u0003.q; p/ in the usual way. However, since\nL\u0004\nLD# D 0 has as its only solution # / \u0005ˇ, the homogeneous solution of (7.21) is\nf ŒHS\t\n1;\u0002XYZ\u0003.q; p/ D c;\nfor some constant c. Our assumption that hf1;\u0002XYZ\u0003i D 0 means that c D \u0003hf ŒPS\t\n1;\u0002XYZ\u0003i,\nand hence we only require a particular solution f ŒPS\t\n1;\u0002XYZ\u0003.q; p/.\nThus for any ﬁrst order scheme our line of attack will be to compute the\nperturbation operator L\u0004\n1, plug it into the right hand side and solve the PDE to ﬁnd\nthe suitable correction function. It turns out that this is not so difﬁcult at leading\norder, for simple ﬁrst order schemes such as this. However at higher orders the\ncomplexity of the terms often limits our progress.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 312,
      "printed_page": 291,
      "text": "7.8\nFirst Order Schemes\n291\n7.8\nFirst Order Schemes\nLet us consider a scheme of the form \u0002XYZ\u0003, where each letter in the string is\ndistinct and corresponds to one of the A, B or O Langevin splitting pieces (giving six\npossible schemes). Given the simple structure of the scheme, we expect to recover a\nﬁrst order error in our invariant (long-time) averages. By composing the semigroup\noperators\nexp.hL\u0004\n\u0002XYZ\u0003/ D exp.hL\u0004\nZ/ exp.hL\u0004\nY/ exp.hL\u0004\nX/;\nand computing the terms in the BCH expansion, we have\nOL\u0004\n\u0002XYZ\u0003 D L\u0004\nLD C hL\u0004\n1;\u0002XYZ\u0003 C O.h2/;\nwhere\nL\u0004\n1;\u0002XYZ\u0003 D \u00031\n2\n\u0006\nŒL\u0004\nX; L\u0004\nY\t C ŒL\u0004\nX; L\u0004\nZ\t C ŒL\u0004\nY; L\u0004\nZ\t\n\u0007\n:\n(7.20)\nThe ﬁrst order correction function for this scheme is then given by the particular\nsolution to the PDE,\nL\u0004\nLD\n\u0004\nf1;\u0002XYZ\u0003\u0005ˇ\n\u0005\nD \u0003L\u0004\n1;\u0002XYZ\u0003\u0005ˇ:\n(7.21)\nThe general solution of (7.21) will consist of the sum of the homogeneous solution\nf ŒHS\t\n1;\u0002XYZ\u0003.q; p/ and particular solution f ŒPS\t\n1;\u0002XYZ\u0003.q; p/ in the usual way. However, since\nL\u0004\nLD# D 0 has as its only solution # / \u0005ˇ, the homogeneous solution of (7.21) is\nf ŒHS\t\n1;\u0002XYZ\u0003.q; p/ D c;\nfor some constant c. Our assumption that hf1;\u0002XYZ\u0003i D 0 means that c D \u0003hf ŒPS\t\n1;\u0002XYZ\u0003i,\nand hence we only require a particular solution f ŒPS\t\n1;\u0002XYZ\u0003.q; p/.\nThus for any ﬁrst order scheme our line of attack will be to compute the\nperturbation operator L\u0004\n1, plug it into the right hand side and solve the PDE to ﬁnd\nthe suitable correction function. It turns out that this is not so difﬁcult at leading\norder, for simple ﬁrst order schemes such as this. However at higher orders the\ncomplexity of the terms often limits our progress.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 313,
      "printed_page": 292,
      "text": "292\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.8.1\nComputing the Correction Functions f1.q; p/\nAt this point we may plow ahead and compute the PDE for each corresponding\nscheme, but a more efﬁcient route is offered by working with the structure of the\ninhomogeneity in (7.21). We may make use of the identity\n\u0006\nŒL\u0004\nO; L\u0004\nA\t C ŒL\u0004\nO; L\u0004\nB\t\n\u0007\n\u0005ˇ D\n\u0006\nŒL\u0004\nO; L\u0004\nA C L\u0004\nB\t\n\u0007\n\u0005ˇ D 0;\nas of course L\u0004\nH D L\u0004\nA C L\u0004\nB is the Liouvillian of our Hamiltonian system,\nwhich preserves any function of the energy. Thus, by the skew-symmetry of the\ncommutator (ŒP; Q\t D \u0003ŒQ; P\t) we can relate four of the six methods as\nL\u0004\n1;\u0002ABO\u0003\u0005ˇ D L\u0004\n1;\u0002OAB\u0003\u0005ˇ D \u0003L\u0004\n1;\u0002OBA\u0003\u0005ˇ D \u0003L\u0004\n1;\u0002BAO\u0003\u0005ˇ D \u00031\n2ŒL\u0004\nA; L\u0004\nB\t\u0005ˇ;\n(7.22)\nby virtue of (7.20). Hence the leading order correction functions of the schemes are\nrelated through\nf1;\u0002ABO\u0003 D f1;\u0002OAB\u0003 D \u0003f1;\u0002OBA\u0003 D \u0003f1;\u0002BAO\u0003:\n(7.23)\nThe remaining two permutations of the possible \u0002XYZ\u0003 schemes have a similar\nrelationship, with\nL\u0004\n1;\u0002AOB\u0003\u0005ˇ D \u0003L\u0004\n1;\u0002BOA\u0003\u0005ˇ D \u00031\n2ŒL\u0004\nA \u0003 L\u0004\nB; L\u0004\nO\t\u0005ˇ C L\u0004\n1;\u0002ABO\u0003\u0005ˇ:\n(7.24)\nThis reduces our workload as we can ﬁnd the leading order behavior for all six\nmethods by computing the solution to two PDEs. This is not necessarily trivial, but\nit turns out that the structure of the equations is simple enough that we can ﬁnd exact\nsolutions. We work now to compute the right-hand side of the governing PDE given\nin (7.21).\nIn order to solve (7.21) for the \u0002ABO\u0003 scheme, we need to compute the right\nhand side of (7.22). First, note that if we deﬁne the function g.q; p/ as\ng.q; p/ D ˇpTM\u00021rU.q/;\nthen through simple computation we have\nL\u0004\nA\u0005ˇ D \u0003L\u0004\nB\u0005ˇ D g.q; p/\u0005ˇ:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 313,
      "printed_page": 292,
      "text": "292\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.8.1\nComputing the Correction Functions f1.q; p/\nAt this point we may plow ahead and compute the PDE for each corresponding\nscheme, but a more efﬁcient route is offered by working with the structure of the\ninhomogeneity in (7.21). We may make use of the identity\n\u0006\nŒL\u0004\nO; L\u0004\nA\t C ŒL\u0004\nO; L\u0004\nB\t\n\u0007\n\u0005ˇ D\n\u0006\nŒL\u0004\nO; L\u0004\nA C L\u0004\nB\t\n\u0007\n\u0005ˇ D 0;\nas of course L\u0004\nH D L\u0004\nA C L\u0004\nB is the Liouvillian of our Hamiltonian system,\nwhich preserves any function of the energy. Thus, by the skew-symmetry of the\ncommutator (ŒP; Q\t D \u0003ŒQ; P\t) we can relate four of the six methods as\nL\u0004\n1;\u0002ABO\u0003\u0005ˇ D L\u0004\n1;\u0002OAB\u0003\u0005ˇ D \u0003L\u0004\n1;\u0002OBA\u0003\u0005ˇ D \u0003L\u0004\n1;\u0002BAO\u0003\u0005ˇ D \u00031\n2ŒL\u0004\nA; L\u0004\nB\t\u0005ˇ;\n(7.22)\nby virtue of (7.20). Hence the leading order correction functions of the schemes are\nrelated through\nf1;\u0002ABO\u0003 D f1;\u0002OAB\u0003 D \u0003f1;\u0002OBA\u0003 D \u0003f1;\u0002BAO\u0003:\n(7.23)\nThe remaining two permutations of the possible \u0002XYZ\u0003 schemes have a similar\nrelationship, with\nL\u0004\n1;\u0002AOB\u0003\u0005ˇ D \u0003L\u0004\n1;\u0002BOA\u0003\u0005ˇ D \u00031\n2ŒL\u0004\nA \u0003 L\u0004\nB; L\u0004\nO\t\u0005ˇ C L\u0004\n1;\u0002ABO\u0003\u0005ˇ:\n(7.24)\nThis reduces our workload as we can ﬁnd the leading order behavior for all six\nmethods by computing the solution to two PDEs. This is not necessarily trivial, but\nit turns out that the structure of the equations is simple enough that we can ﬁnd exact\nsolutions. We work now to compute the right-hand side of the governing PDE given\nin (7.21).\nIn order to solve (7.21) for the \u0002ABO\u0003 scheme, we need to compute the right\nhand side of (7.22). First, note that if we deﬁne the function g.q; p/ as\ng.q; p/ D ˇpTM\u00021rU.q/;\nthen through simple computation we have\nL\u0004\nA\u0005ˇ D \u0003L\u0004\nB\u0005ˇ D g.q; p/\u0005ˇ:\n"
    },
    {
      "pdf_page": 314,
      "printed_page": 293,
      "text": "7.8\nFirst Order Schemes\n293\nThis is particularly useful as\nŒL\u0004\nA; L\u0004\nB\t\u0005ˇ D\n\u0006\nL\u0004\nAL\u0004\nB \u0003 L\u0004\nBL\u0004\nA\n\u0007\n\u0005ˇ D \u0003\n\u0006\nL\u0004\nA C L\u0004\nB\n\u0007 \u0004\ng.q; p/\u0005ˇ\n\u0005\nD\n\u0006\nL\u0004\nO \u0003 L\u0004\nLD\n\u0007 \u0004\ng.q; p/\u0005ˇ\n\u0005\n:\nNow notice that for a function .q/ purely of position, we have\nL\u0004\nLD\n\u0004\n .q/\u0005ˇ\n\u0005\nD \u0003\n\u0004\npTM\u00021r .q/\n\u0005\n\u0005ˇ.q; p/;\nand hence we can compute\nL\u0004\nO\n\u0004\ng.q; p/\u0005ˇ\n\u0005\nD \n\u0005ˇ\n\u0004\n\u0003p \u0002 rpg.q; p/ C ˇ\u00021rp \u0002 Mrpg.q; p/\n\u0005\n;\nD \u0003\ng.q; p/\u0005ˇ;\nD \nˇL\u0004\nLD\n\u0004\nU.q/\u0005ˇ\n\u0005\n:\nThis means that\nL\u0004\n1;\u0002ABO\u0003\u0005ˇ D \u00031\n2ŒL\u0004\nA; L\u0004\nB\t\u0005ˇ D \u00031\n2L\u0004\nLD\n\u0004\nŒ\nˇU.q/ \u0003 g.q; p/\t \u0005ˇ\n\u0005\n:\nHence, we can combine this equation with (7.21) to yield\nL\u0004\nLDf1;\u0002ABO\u0003\u0005ˇ D 1\n2L\u0004\nLD\n\u0004\nŒ\nˇU.q/ \u0003 g.q; p/\t \u0005ˇ\n\u0005\n;\nwith the general solution\nf1;\u0002ABO\u0003 D ˇ\n2\n\u0004\n\nU.q/ \u0003 pTM\u00021rU.q/ \u0003 c\n\u0005\n;\nwhere c D \nhU.q/i is a constant, chosen to ensure that the average of the correction\nfunction is zero. This solution gives the leading order correction for the three related\nschemes in (7.23).\nFor the ﬁnal two schemes, we can compute the correction function through the\nuse of (7.24). Our previous work has computed the second term on the right hand\nside already, so we are left with the initial term. However, its expression reduces\nquite easily, as\nŒL\u0004\nA \u0003 L\u0004\nB; L\u0004\nO\t\u0005ˇ D \u0003L\u0004\nO\n\u0006\nL\u0004\nA \u0003 L\u0004\nB\n\u0007\n\u0005ˇ;\nD \u00032L\u0004\nO\n\u0004\ng.q; p/\u0005ˇ\n\u0005\n;\nD \u00032\nˇL\u0004\nLD\n\u0004\nU.q/\u0005ˇ\n\u0005\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
