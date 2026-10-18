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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 309,
      "printed_page": 288,
      "text": "288\n7\nNumerical Methods for Stochastic Molecular Dynamics\nexpansion of the SDE method. The series expansion is therefore not particularly\ninformative on its own, but only in relation to its action on some particular\ndistribution.\nA simple ﬁrst order example of a Langevin dynamics integrator is the method\nobtained by composing one of the Symplectic Euler variants with an Ornstein-\nUhlenbeck step. To get a feel for how the expansion goes, let us work out its terms\nfor such a splitting scheme in the case of a one degree of freedom model with unit\nmass: H D p2=2 CU.q/. To be explicit, let us say our numerical method ﬁrst solves\nexactly the OU process, then evaluates the impulse due to the force \u0003U0.q/ and\nlastly drifts in position space according to the momentum. This method is denoted in\nour notation as \u0002OBA\u0003, where the evolution of measure in one step can be computed\nby writing\nexp.h OL\u0004\n\u0002OBA\u0003/ D exp.hL\u0004\nA/ exp.hL\u0004\nB/ exp.hL\u0004\nO/:\nIn this one dimensional example, we substitute\nZ D L\u0004\nA D \u0003p @\n@q;\nY D L\u0004\nB D U0.q/ @\n@p;\nX D L\u0004\nO D \n\b\nId C p @\n@p\n\t\nC \u00072\n2\n@2\n@p2 ;\ninto (7.18), where \u0007 D p2\nkBT. This gives us an expansion for the Kolmogorov\noperator for our discretized map\nOL\u0004\n\u0002OBA\u0003 D S D L\u0004\nA C L\u0004\nB C L\u0004\nO C h\n2\n\u0006\nŒL\u0004\nA; L\u0004\nB\t C ŒL\u0004\nA; L\u0004\nO\t C ŒL\u0004\nB; L\u0004\nO\t\n\u0007\nC : : :\nIt is clear that even writing out the O.h2/ terms considerably increases the\ncomplexity of the right hand side.\nThe commutators are best considered in relation to their action on a function (or\nrather, their action on a density) \u0005.q; p/. For example, we may compute directly\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003p @\n@q\n\b\nU0.q/@\u0005\n@p\n\t\n\u0003 U0.q/ @\n@p\n\b\n\u0003p@\u0005\n@q\n\t\nD \u0003p.U0.q/\u0005p/q C U0.q/.p\u0005q/p;\nD \u0003pU00.q/\u0005p \u0003 pU0.q/\u0005pq C U0.q/\u0005q C U0.q/p\u0005qp:\nAs this is the commutator of two 1st order differential operators, the mixed partial\nterm vanishes, leaving\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003pU00.q/\u0005p C U0.q/\u0005q:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_latex": null,
  "proof_outline": "Expand both product derivatives and cancel the mixed partials using equality of mixed partials.",
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 309,
      "printed_page": 288,
      "text": "288\n7\nNumerical Methods for Stochastic Molecular Dynamics\nexpansion of the SDE method. The series expansion is therefore not particularly\ninformative on its own, but only in relation to its action on some particular\ndistribution.\nA simple ﬁrst order example of a Langevin dynamics integrator is the method\nobtained by composing one of the Symplectic Euler variants with an Ornstein-\nUhlenbeck step. To get a feel for how the expansion goes, let us work out its terms\nfor such a splitting scheme in the case of a one degree of freedom model with unit\nmass: H D p2=2 CU.q/. To be explicit, let us say our numerical method ﬁrst solves\nexactly the OU process, then evaluates the impulse due to the force \u0003U0.q/ and\nlastly drifts in position space according to the momentum. This method is denoted in\nour notation as \u0002OBA\u0003, where the evolution of measure in one step can be computed\nby writing\nexp.h OL\u0004\n\u0002OBA\u0003/ D exp.hL\u0004\nA/ exp.hL\u0004\nB/ exp.hL\u0004\nO/:\nIn this one dimensional example, we substitute\nZ D L\u0004\nA D \u0003p @\n@q;\nY D L\u0004\nB D U0.q/ @\n@p;\nX D L\u0004\nO D \n\b\nId C p @\n@p\n\t\nC \u00072\n2\n@2\n@p2 ;\ninto (7.18), where \u0007 D p2\nkBT. This gives us an expansion for the Kolmogorov\noperator for our discretized map\nOL\u0004\n\u0002OBA\u0003 D S D L\u0004\nA C L\u0004\nB C L\u0004\nO C h\n2\n\u0006\nŒL\u0004\nA; L\u0004\nB\t C ŒL\u0004\nA; L\u0004\nO\t C ŒL\u0004\nB; L\u0004\nO\t\n\u0007\nC : : :\nIt is clear that even writing out the O.h2/ terms considerably increases the\ncomplexity of the right hand side.\nThe commutators are best considered in relation to their action on a function (or\nrather, their action on a density) \u0005.q; p/. For example, we may compute directly\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003p @\n@q\n\b\nU0.q/@\u0005\n@p\n\t\n\u0003 U0.q/ @\n@p\n\b\n\u0003p@\u0005\n@q\n\t\nD \u0003p.U0.q/\u0005p/q C U0.q/.p\u0005q/p;\nD \u0003pU00.q/\u0005p \u0003 pU0.q/\u0005pq C U0.q/\u0005q C U0.q/p\u0005qp:\nAs this is the commutator of two 1st order differential operators, the mixed partial\nterm vanishes, leaving\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003pU00.q/\u0005p C U0.q/\u0005q:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 310,
      "printed_page": 289,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n289\nSimilar computations give\nŒL\u0004\nA; L\u0004\nO\t\u0005 D \np\u0005q C \u00072\u0005qp;\nŒL\u0004\nB; L\u0004\nO\t\u0005 D \nU0.q/\u0005p:\nTo ﬁrst order, the discretization map corresponding to scheme \u0002OBA\u0003 alters the\nphase space density at each step as if it were solving the time dependent PDE\n\u0005t D OL\u0004\u0005;\nwhere\nOL\u0004\u0005DL\u0004\nLD\u0005 C h\n2\n\n\u0003pU00.q/\u0005p C U0.q/\u0005qC\np\u0005q C \u00072\u0005qp C \nU0.q/\u0005p\n\u000b\nC O.h2/:\nThe validity of this sort of expansion, even for small h, should be considered\ncarefully. Deﬁning\nL\u0004\nLD D L\u0004\nA C L\u0004\nB C L\u0004\nO\nas the Kolmogorov operator for Langevin dynamics, the assumption of validity\nbecomes more credible as we ﬁnd that the operator L\u0004\nLD has a compact resolvent and\ntherefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous\nchapter. It will have one zero eigenvalue corresponding to the invariant density \u0005ˇ\nand all the remaining eigenvalues lie in the negative half plane. Of course it is not\njust this operator whose properties are important, but also all the other operators\narising in the expansion, and bounding these in relation to L\u0004\nLD is not a simple task\n(particularly for higher orders).\n7.7.3\nPerturbation Technique\nSuppose we are able to derive a series expansion for OL\u0004 of the form\nOL\u0004 D L\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/;\nfor some perturbation operators L\u0004\ni . We assume that the invariant density has a\nsimilar expansion in powers of the stepsize, of the form given in (7.17). Inserting\nthis ansatz into the stationary Fokker-Planck equation\nOL\u0004 O\u0005 D 0;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 309,
      "printed_page": 288,
      "text": "288\n7\nNumerical Methods for Stochastic Molecular Dynamics\nexpansion of the SDE method. The series expansion is therefore not particularly\ninformative on its own, but only in relation to its action on some particular\ndistribution.\nA simple ﬁrst order example of a Langevin dynamics integrator is the method\nobtained by composing one of the Symplectic Euler variants with an Ornstein-\nUhlenbeck step. To get a feel for how the expansion goes, let us work out its terms\nfor such a splitting scheme in the case of a one degree of freedom model with unit\nmass: H D p2=2 CU.q/. To be explicit, let us say our numerical method ﬁrst solves\nexactly the OU process, then evaluates the impulse due to the force \u0003U0.q/ and\nlastly drifts in position space according to the momentum. This method is denoted in\nour notation as \u0002OBA\u0003, where the evolution of measure in one step can be computed\nby writing\nexp.h OL\u0004\n\u0002OBA\u0003/ D exp.hL\u0004\nA/ exp.hL\u0004\nB/ exp.hL\u0004\nO/:\nIn this one dimensional example, we substitute\nZ D L\u0004\nA D \u0003p @\n@q;\nY D L\u0004\nB D U0.q/ @\n@p;\nX D L\u0004\nO D \n\b\nId C p @\n@p\n\t\nC \u00072\n2\n@2\n@p2 ;\ninto (7.18), where \u0007 D p2\nkBT. This gives us an expansion for the Kolmogorov\noperator for our discretized map\nOL\u0004\n\u0002OBA\u0003 D S D L\u0004\nA C L\u0004\nB C L\u0004\nO C h\n2\n\u0006\nŒL\u0004\nA; L\u0004\nB\t C ŒL\u0004\nA; L\u0004\nO\t C ŒL\u0004\nB; L\u0004\nO\t\n\u0007\nC : : :\nIt is clear that even writing out the O.h2/ terms considerably increases the\ncomplexity of the right hand side.\nThe commutators are best considered in relation to their action on a function (or\nrather, their action on a density) \u0005.q; p/. For example, we may compute directly\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003p @\n@q\n\b\nU0.q/@\u0005\n@p\n\t\n\u0003 U0.q/ @\n@p\n\b\n\u0003p@\u0005\n@q\n\t\nD \u0003p.U0.q/\u0005p/q C U0.q/.p\u0005q/p;\nD \u0003pU00.q/\u0005p \u0003 pU0.q/\u0005pq C U0.q/\u0005q C U0.q/p\u0005qp:\nAs this is the commutator of two 1st order differential operators, the mixed partial\nterm vanishes, leaving\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003pU00.q/\u0005p C U0.q/\u0005q:\n"
    },
    {
      "pdf_page": 310,
      "printed_page": 289,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n289\nSimilar computations give\nŒL\u0004\nA; L\u0004\nO\t\u0005 D \np\u0005q C \u00072\u0005qp;\nŒL\u0004\nB; L\u0004\nO\t\u0005 D \nU0.q/\u0005p:\nTo ﬁrst order, the discretization map corresponding to scheme \u0002OBA\u0003 alters the\nphase space density at each step as if it were solving the time dependent PDE\n\u0005t D OL\u0004\u0005;\nwhere\nOL\u0004\u0005DL\u0004\nLD\u0005 C h\n2\n\n\u0003pU00.q/\u0005p C U0.q/\u0005qC\np\u0005q C \u00072\u0005qp C \nU0.q/\u0005p\n\u000b\nC O.h2/:\nThe validity of this sort of expansion, even for small h, should be considered\ncarefully. Deﬁning\nL\u0004\nLD D L\u0004\nA C L\u0004\nB C L\u0004\nO\nas the Kolmogorov operator for Langevin dynamics, the assumption of validity\nbecomes more credible as we ﬁnd that the operator L\u0004\nLD has a compact resolvent and\ntherefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous\nchapter. It will have one zero eigenvalue corresponding to the invariant density \u0005ˇ\nand all the remaining eigenvalues lie in the negative half plane. Of course it is not\njust this operator whose properties are important, but also all the other operators\narising in the expansion, and bounding these in relation to L\u0004\nLD is not a simple task\n(particularly for higher orders).\n7.7.3\nPerturbation Technique\nSuppose we are able to derive a series expansion for OL\u0004 of the form\nOL\u0004 D L\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/;\nfor some perturbation operators L\u0004\ni . We assume that the invariant density has a\nsimilar expansion in powers of the stepsize, of the form given in (7.17). Inserting\nthis ansatz into the stationary Fokker-Planck equation\nOL\u0004 O\u0005 D 0;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 310,
      "printed_page": 289,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n289\nSimilar computations give\nŒL\u0004\nA; L\u0004\nO\t\u0005 D \np\u0005q C \u00072\u0005qp;\nŒL\u0004\nB; L\u0004\nO\t\u0005 D \nU0.q/\u0005p:\nTo ﬁrst order, the discretization map corresponding to scheme \u0002OBA\u0003 alters the\nphase space density at each step as if it were solving the time dependent PDE\n\u0005t D OL\u0004\u0005;\nwhere\nOL\u0004\u0005DL\u0004\nLD\u0005 C h\n2\n\n\u0003pU00.q/\u0005p C U0.q/\u0005qC\np\u0005q C \u00072\u0005qp C \nU0.q/\u0005p\n\u000b\nC O.h2/:\nThe validity of this sort of expansion, even for small h, should be considered\ncarefully. Deﬁning\nL\u0004\nLD D L\u0004\nA C L\u0004\nB C L\u0004\nO\nas the Kolmogorov operator for Langevin dynamics, the assumption of validity\nbecomes more credible as we ﬁnd that the operator L\u0004\nLD has a compact resolvent and\ntherefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous\nchapter. It will have one zero eigenvalue corresponding to the invariant density \u0005ˇ\nand all the remaining eigenvalues lie in the negative half plane. Of course it is not\njust this operator whose properties are important, but also all the other operators\narising in the expansion, and bounding these in relation to L\u0004\nLD is not a simple task\n(particularly for higher orders).\n7.7.3\nPerturbation Technique\nSuppose we are able to derive a series expansion for OL\u0004 of the form\nOL\u0004 D L\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/;\nfor some perturbation operators L\u0004\ni . We assume that the invariant density has a\nsimilar expansion in powers of the stepsize, of the form given in (7.17). Inserting\nthis ansatz into the stationary Fokker-Planck equation\nOL\u0004 O\u0005 D 0;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
    "MD.Ch07.printedSpectralConclusion",
    "MD.Ch07.spectralConclusionPrinted",
    "MD.Ch07.spectralConclusionPrinted_corrected"
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

def spectralConclusionPrinted {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop := printedSpectralConclusion L ρ

def spectralConclusionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    FiniteDimensional ℂ (Module.End.eigenspace L eigen) ∧ (eigen = 0 ∨ eigen.re < 0)
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
  "proof_latex": null,
  "proof_outline": "Insert the two formal series into the stationary equation and combine like powers of h.",
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 310,
      "printed_page": 289,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n289\nSimilar computations give\nŒL\u0004\nA; L\u0004\nO\t\u0005 D \np\u0005q C \u00072\u0005qp;\nŒL\u0004\nB; L\u0004\nO\t\u0005 D \nU0.q/\u0005p:\nTo ﬁrst order, the discretization map corresponding to scheme \u0002OBA\u0003 alters the\nphase space density at each step as if it were solving the time dependent PDE\n\u0005t D OL\u0004\u0005;\nwhere\nOL\u0004\u0005DL\u0004\nLD\u0005 C h\n2\n\n\u0003pU00.q/\u0005p C U0.q/\u0005qC\np\u0005q C \u00072\u0005qp C \nU0.q/\u0005p\n\u000b\nC O.h2/:\nThe validity of this sort of expansion, even for small h, should be considered\ncarefully. Deﬁning\nL\u0004\nLD D L\u0004\nA C L\u0004\nB C L\u0004\nO\nas the Kolmogorov operator for Langevin dynamics, the assumption of validity\nbecomes more credible as we ﬁnd that the operator L\u0004\nLD has a compact resolvent and\ntherefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous\nchapter. It will have one zero eigenvalue corresponding to the invariant density \u0005ˇ\nand all the remaining eigenvalues lie in the negative half plane. Of course it is not\njust this operator whose properties are important, but also all the other operators\narising in the expansion, and bounding these in relation to L\u0004\nLD is not a simple task\n(particularly for higher orders).\n7.7.3\nPerturbation Technique\nSuppose we are able to derive a series expansion for OL\u0004 of the form\nOL\u0004 D L\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/;\nfor some perturbation operators L\u0004\ni . We assume that the invariant density has a\nsimilar expansion in powers of the stepsize, of the form given in (7.17). Inserting\nthis ansatz into the stationary Fokker-Planck equation\nOL\u0004 O\u0005 D 0;\n"
    },
    {
      "pdf_page": 311,
      "printed_page": 290,
      "text": "290\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwe obtain\n\u0006\nL\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/\n\u0007 \u0004\n\u0005ˇŒ1 C hf1 C h2f2 C O.h3/\t\n\u0005\nD 0:\nCombining like powers, we have at zero’th order, the equation\nL\u0004\nLD\u0005ˇ D 0;\nwhich we know to hold since Langevin dynamics preserves the canonical ensemble.\nAt ﬁrst order we obtain\nL\u0004\nLD.\u0005ˇf1/ C L\u0004\n1\u0005ˇ D 0:\n(7.19)\nIf L\u0004\n1 is known, we can calculate its action on \u0005ˇ, giving an inhomogeneity for\nthe above partial differential equation. It will be difﬁcult to solve the perturbation\nequation (7.19) in general, although its linearity and the fact that L\u0004\nLD (with our\nassumptions) has a compact resolvent (and therefore a discrete spectrum) together\nimply that if the perturbation can be bounded, then it should be possible to solve for\nthe correction function. We expect that this solution should be stable with respect\nto perturbation (and exponentially attracting). This also implies global existence\n(for all positive time) of the semigroup deﬁning the solution of the time-dependent\nproblem. We do not provide such a rigorous result here but simply plunge ahead,\nin the best tradition of applied mathematics, to obtain a perturbative expansion;\nveriﬁcation of our results must therefore be obtained by numerical experiment, a\nposteriori.\nThe leading order errors can be computed in simulation by exploiting the speciﬁc\nform of our ansatz for the invariant measure associated to the discretized dynamics.\nFor some observable #.q; p/, we have that\nh#ih D\nZ\nD\n#.q; p/ O\u0005.q; p/d!;\nD\nZ\nD\n#.q; p/\u0005ˇ.q; p/.1 C hf1.q; p/ C h2f2.q; p/ C : : :/d!;\nD\nZ\nD\n#.q; p/\u0005ˇ.q; p/d! C h\nZ\nD\n#.q; p/f1.q; p/\u0005ˇ.q; p/d! C : : : ;\nD h#i C hh#f1i C h2h#f2i C : : : :\nHence by obtaining the correction functions fi, we are able to apply a modiﬁcation\nto our computed expectation in order to recover the true canonical average.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
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
