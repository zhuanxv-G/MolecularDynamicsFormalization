# EAUDIT05 第7章修改后陈述复审

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
    "实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。",
    "29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。"
  ],
  "issues": [],
  "statement_scope": "所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。",
  "lean_decl": "MD.Ch07.commutatorPermutationRelations",
  "lean_declarations": [
    "MD.Ch07.commutatorPermutationRelations"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "保留现有交换子定理；另列(7.23)的待形式化义务，明确同一线性方程、核条件和统一零均值，再给出四个修正函数的关系。只修正JSON中的覆盖说明，本次不改工程。",
      "actual_scope": "所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。",
    "29号覆盖限定：所列七个抽象交换子关系；(7.23)四个零均值解的关系未覆盖，需要同一方程、核唯一性与域。"
  ]
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
    "覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。",
    "29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。"
  ],
  "issues": [],
  "statement_scope": "所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。",
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
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "把缺失等式登记为独立Lean覆盖义务，或将已形式化范围准确写为五个已列结论；不可把现有定理称为全部原文公式的形式化。",
      "actual_scope": "所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：所列五个Gibbs权微分恒等式；未覆盖本段交换子等式及其他OU中间式。"
  ]
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

## MD-7.8.1-FirstCorrectionTablePrinted
```json
{
  "source_id": "MD-7.8.1-FirstCorrectionTablePrinted",
  "kind": "unnumbered_claim",
  "label": "(7.25a)–(7.25d)",
  "section": "7.8.1",
  "printed_page": "293–294",
  "pdf_page": "314–315",
  "statement_latex": "In summary, we find that\n\\[f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25a}\\]\n\\[f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25b}\\]\n\\[f_{1,[AOB]}(q,p)=-\\frac\\beta2(\\gamma U(q)+p^TM^{-1}\\nabla U(q)-c),\\tag{7.25c}\\]\n\\[f_{1,[BOA]}(q,p)=\\frac\\beta2(\\gamma U(q)+p^TM^{-1}\\nabla U(q)-c),\\tag{7.25d}\\]\nwhere the constant $c$ is chosen to ensure each correction function has average 0, giving $c=\\gamma\\langle U(q)\\rangle$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 314,
      "printed_page": 293,
      "text": "7.8\nFirst Order Schemes\n293\nThis is particularly useful as\nŒL\u0004\nA; L\u0004\nB\t\u0005ˇ D\n\u0006\nL\u0004\nAL\u0004\nB \u0003 L\u0004\nBL\u0004\nA\n\u0007\n\u0005ˇ D \u0003\n\u0006\nL\u0004\nA C L\u0004\nB\n\u0007 \u0004\ng.q; p/\u0005ˇ\n\u0005\nD\n\u0006\nL\u0004\nO \u0003 L\u0004\nLD\n\u0007 \u0004\ng.q; p/\u0005ˇ\n\u0005\n:\nNow notice that for a function .q/ purely of position, we have\nL\u0004\nLD\n\u0004\n .q/\u0005ˇ\n\u0005\nD \u0003\n\u0004\npTM\u00021r .q/\n\u0005\n\u0005ˇ.q; p/;\nand hence we can compute\nL\u0004\nO\n\u0004\ng.q; p/\u0005ˇ\n\u0005\nD \n\u0005ˇ\n\u0004\n\u0003p \u0002 rpg.q; p/ C ˇ\u00021rp \u0002 Mrpg.q; p/\n\u0005\n;\nD \u0003\ng.q; p/\u0005ˇ;\nD \nˇL\u0004\nLD\n\u0004\nU.q/\u0005ˇ\n\u0005\n:\nThis means that\nL\u0004\n1;\u0002ABO\u0003\u0005ˇ D \u00031\n2ŒL\u0004\nA; L\u0004\nB\t\u0005ˇ D \u00031\n2L\u0004\nLD\n\u0004\nŒ\nˇU.q/ \u0003 g.q; p/\t \u0005ˇ\n\u0005\n:\nHence, we can combine this equation with (7.21) to yield\nL\u0004\nLDf1;\u0002ABO\u0003\u0005ˇ D 1\n2L\u0004\nLD\n\u0004\nŒ\nˇU.q/ \u0003 g.q; p/\t \u0005ˇ\n\u0005\n;\nwith the general solution\nf1;\u0002ABO\u0003 D ˇ\n2\n\u0004\n\nU.q/ \u0003 pTM\u00021rU.q/ \u0003 c\n\u0005\n;\nwhere c D \nhU.q/i is a constant, chosen to ensure that the average of the correction\nfunction is zero. This solution gives the leading order correction for the three related\nschemes in (7.23).\nFor the ﬁnal two schemes, we can compute the correction function through the\nuse of (7.24). Our previous work has computed the second term on the right hand\nside already, so we are left with the initial term. However, its expression reduces\nquite easily, as\nŒL\u0004\nA \u0003 L\u0004\nB; L\u0004\nO\t\u0005ˇ D \u0003L\u0004\nO\n\u0006\nL\u0004\nA \u0003 L\u0004\nB\n\u0007\n\u0005ˇ;\nD \u00032L\u0004\nO\n\u0004\ng.q; p/\u0005ˇ\n\u0005\n;\nD \u00032\nˇL\u0004\nLD\n\u0004\nU.q/\u0005ˇ\n\u0005\n:\n"
    },
    {
      "pdf_page": 315,
      "printed_page": 294,
      "text": "294\n7\nNumerical Methods for Stochastic Molecular Dynamics\nAnd hence we have\nL\u0004\nLD\n\u0004\nf1;\u0002AOB\u0003\u0005ˇ\n\u0005\nD L\u0004\nLD\n\u0004\nf1;\u0002ABO\u0003\u0005ˇ\n\u0005\n\u0003 \nˇL\u0004\nLD\n\u0004\nU.q/\u0005ˇ\n\u0005\n;\ngiving the general solution\nf1;\u0002AOB\u0003 D \u0003ˇ\n2\n\u0004\n\nU.q/ C pTM\u00021rU.q/ \u0003 c\n\u0005\n;\nfor the same choice of c.\nHence using the symmetry in the commutators we are able to solve for the leading\norder corrections for each of the schemes of the form \u0002XYZ\u0003. In summary, we ﬁnd\nthat\nf1;\u0002ABO\u0003.q; p/ D f1;\u0002OAB\u0003.q; p/ D ˇ\n2\n\u0004\n\nU.q/ \u0003 pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25a)\nf1;\u0002OBA\u0003.q; p/ D f1;\u0002BAO\u0003.q; p/ D \u0003ˇ\n2\n\u0004\n\nU.q/ \u0003 pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25b)\nf1;\u0002AOB\u0003.q; p/ D \u0003ˇ\n2\n\u0004\n\nU.q/ C pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25c)\nf1;\u0002BOA\u0003.q; p/ D ˇ\n2\n\u0004\n\nU.q/ C pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25d)\nwhere the constant c is chosen to ensure each correction function has average 0,\ngiving c D \nhU.q/i. If required, we may continue this procedure in order to ﬁnd\ncorrection functions for higher orders, though the added complexity means that we\ncannot always solve to ﬁnd an explicit solution.\nThe results of our analysis suggest that to leading order the error scales linearly\nwith the reciprocal temperature ˇ, but more importantly a non-constant term appears\nwhich is of order \n. As our correction is of the form h#f1i we can see that if # D\n#1.p/ then this O.\n/ term will not trouble us, as\nh#1.p/f1.q; p/i D ˙ˇ\n2\n˝\n.\nU.q/ \u0003 c/#1.p/ ˙ pTM\u00021rU.q/#1.p/\n˛\nD ˙ˇ\n2\n˝\npTM\u00021rU.q/#1.p/\n˛\n;\nwhere the sign depends on the particular scheme used (which governs the form of\nf1). Thus in the case of a function of pure momentum the order \n term does not\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。",
    "29号覆盖限定：恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。",
    "PDF314–315已目视核对原页：(7.25c)括号内为+v；旧负号是转录错误，撤销原书疑误。"
  ],
  "issues": [],
  "statement_scope": "恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。",
  "lean_decl": "MD.Ch07.firstCorrectionTablePrinted",
  "lean_declarations": [
    "MD.Ch07.firstCorrectionTablePrinted",
    "MD.Ch07.firstCorrectionTablePrinted_corrected",
    "MD.Ch07.firstCorrection_sign_counterexample",
    "MD.Ch07.phaseComm",
    "MD.Ch07.firstCorrectionRHS",
    "MD.Ch07.firstCorrectionTable_pde"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "在JSON中将(7.25c)恢复正号，删除原书印负号的issues；把现有_corrected登记为恢复转写而非数学勘误。以后修订工程时修复Printed分支并另列中心化义务；本次仅报告。",
      "actual_scope": "恢复原页正号后的六个候选函数与六个PDE；常数仍任意，零均值选择义务独立登记。旧corrected名称只作兼容。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": []
}
```
```lean
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 then -β/2*(γ*U x.1-v-c)
  else if s = 4 then -β/2*(γ*U x.1+v-c)
  else β/2*(γ*U x.1+v-c)
def firstCorrectionTablePrinted_corrected (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  if s = 4 then -β/2*(γ*U x.1+(∑ i, x.2 i/m i*gradient U x.1 i)-c)
  else firstCorrectionTablePrinted s m U β γ c x
theorem firstCorrection_sign_counterexample :
    (-(1 : ℝ)/2*(1-1-0)) ≠ -(1 : ℝ)/2*(1+1-0) := by norm_num
def phaseComm (A B : (Phase n → ℝ) → Phase n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := A (B ρ)-B (A ρ)
def firstCorrectionRHS (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  let A := aForward m
  let B := bForward U
  let O := phaseO m γ β
  let ops := if s = 0 then (A,B,O) else if s = 1 then (O,A,B)
    else if s = 2 then (O,B,A) else if s = 3 then (B,A,O)
    else if s = 4 then (A,O,B) else (B,O,A)
  fun x ↦ (1/2)*(phaseComm ops.1 ops.2.1 ρ x+phaseComm ops.1 ops.2.2 ρ x+phaseComm ops.2.1 ops.2.2 ρ x)
theorem firstCorrectionTable_pde (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    phaseLD m U γ β (fun x ↦ firstCorrectionTablePrinted_corrected s m U β γ c x*gibbsWeight m U β x) =
      firstCorrectionRHS s m U β γ (gibbsWeight m U β) := by
  sorry
```
