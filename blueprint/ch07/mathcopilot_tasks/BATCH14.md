# BATCH14 第7章原文与陈述审校

## MD-7.9.1-OYZYOInhomogeneity
```json
{
  "source_id": "MD-7.9.1-OYZYOInhomogeneity",
  "kind": "unnumbered_claim",
  "label": "(7.29)",
  "section": "7.9.1",
  "printed_page": "298–299",
  "pdf_page": "319–320",
  "statement_latex": "For methods $[OYZYO]$, substituting $\\mathcal L_X^\\dagger=\\mathcal L_O^\\dagger$, $\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger=\\mathcal L_A^\\dagger+\\mathcal L_B^\\dagger=\\mathcal L_H^\\dagger$ simplifies the computation to\n\\[\\mathcal L_{2,[OYZYO]}^\\dagger\\rho_\\beta=\\frac1{12}[\\mathcal L_Z^\\dagger,\\mathcal L_Z^\\dagger,\\mathcal L_Y^\\dagger]\\rho_\\beta-\\frac1{24}[\\mathcal L_Y^\\dagger,\\mathcal L_Y^\\dagger,\\mathcal L_Z^\\dagger]\\rho_\\beta.\\tag{7.29}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 319,
      "printed_page": 298,
      "text": "298\n7\nNumerical Methods for Stochastic Molecular Dynamics\nFor a scheme \u0002XYZYX\u0003, we assume that each of the X, Y and Z characters in\nthe string are distinct, and correspond to one of the A, B or O pieces of our splitting\nstrategy. Thus we have L\u0004\n0 D L\u0004\nLD.\nEvidently, the scheme’s associated Fokker-Planck operator OL\u0004 no longer has a\nleading order term that is linear in the stepsize, so it makes sense to revise our\nassumption on the form of the scheme’s corresponding invariant measure, and\nreplace it with a series with solely even order terms. If we suppose that the odd\norder correction functions are zero, then we are left with\nO\u0005 D \u0005ˇ.1 C h2f2 C h4f4 C : : :/;\n(7.27)\nwhere each hfii D 0 as usual. Thus the stationarity equation OL\u0004 O\u0005 D 0 becomes\n\u0006\nL\u0004\nLD C h2L\u0004\n2 C : : :\n\u0007 \u0004\n\u0005ˇ C h2\u0005ˇf2 C : : :\n\u0005\nD 0:\nThe equation is satisﬁed at zeroth order, and equating the second order terms we\nobtain\nL\u0004\nLD\n\u0004\u0005ˇf2\n\u0005 D \u0003L\u0004\n2\u0005ˇ:\n(7.28)\nThe procedure then follows just as in the case of the ﬁrst order schemes. The\nform of the right-hand side L\u0004\n2\u0005ˇ will be dependent on the choice of the update\nscheme, and can be computed using the BCH formula using Proposition 7.1. More\ncomplicated symmetric schemes involving more than ﬁve stages can be utilized,\nbut these schemes may require more than one force evaluation per iteration, while\nincreasing the complexity of the PDE to solve.\nThe condition on the existence of such a solution requires us to use the Fredholm\nalternative, which requires us to verify that the inhomogeneous term L\u0004\n2\u0005ˇ integrates\nto zero.\n7.9.1\nCalculation of the Inhomogeneous Term\nThe computation of the right hand side in (7.28) is required in order to solve the\ncorresponding partial differential equation and obtain the leading order correction\nfunction for our symmetric scheme \u0002XYZYX\u0003. From the form of the L\u0004\n2 operator in\nProposition 7.1, we can see that our life is made considerably easier if we initially\nconsider methods \u0002OYZYO\u0003, which substitutes\nL\u0004\nX D L\u0004\nO;\nL\u0004\nY C L\u0004\nZ D L\u0004\nA C L\u0004\nB D L\u0004\nH;\n"
    },
    {
      "pdf_page": 320,
      "printed_page": 299,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n299\nsimplifying the computation to\nL\u0004\n2;\u0002OYZYO\u0003\u0005ˇ D 1\n12\nh\nL\u0004\nZ; L\u0004\nZ; L\u0004\nY\ni\n\u0005ˇ \u0003 1\n24ŒL\u0004\nY; L\u0004\nY; L\u0004\nZ\t\u0005ˇ:\n(7.29)\nThe inhomogeneity for the schemes \u0002OABAO\u0003 and \u0002OBABO\u0003 is hence a combina-\ntion of the two commutator terms\nh\nL\u0004\nA; L\u0004\nA; L\u0004\nB\ni\n\u0005ˇ D\n\u0004\n2ˇpT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nh\nL\u0004\nB; L\u0004\nB; L\u0004\nA\ni\n\u0005ˇ D \u0003 \u00042ˇpT \u0004r2U\u0005 rU\u0005 \u0005ˇ;\ngiving overall equations to solve\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OABAO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OABAO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n6pT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OBABO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OBABO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n2r3U W p ˝ p ˝ p \u0003 6pT \u0004\nr2U\n\u0005\nrU\n\u0005\n\u0005ˇ:\nWe can see immediately that the Fredholm alternative holds in both cases, as both\nequations have right-hand sides that are of odd order in p, and hence will average\nto 0.\nIf we instead consider schemes which use a central Ornstein-Uhlenbeck update,\nthen the inhomogeneous term becomes signiﬁcantly more complex, as we no\nlonger have a signiﬁcant number of cancellations in L\u0004\n2\u0005ˇ. Instead, we shall avoid\ncomputing the right-hand side for these schemes altogether, in favor of utilizing the\nfollowing lemma [223]:\nLemma 7.1 Consider two numerical schemes with associated operators governing\nthe evolution of measure ST and T S, with unique associated invariant distributions\nO\u0005ST and O\u0005TS respectively, such that\nST O\u0005ST D O\u0005ST;\nT S O\u0005TS D O\u0005TS:\nUnder suitable ergodicity assumptions (such that in the long-time limit, all distribu-\ntions converge to the invariant distribution), we have\nO\u0005ST D S O\u0005TS;\nand\nO\u0005TS D T O\u0005ST:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.oyzyoInhomogeneity",
  "lean_declarations": [
    "MD.Ch07.oyzyoInhomogeneity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry
```

## MD-7.9.1-TripleCommutatorPrinted
```json
{
  "source_id": "MD-7.9.1-TripleCommutatorPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.1",
  "printed_page": "299",
  "pdf_page": "320",
  "statement_latex": "\\[[\\mathcal L_A^\\dagger,\\mathcal L_A^\\dagger,\\mathcal L_B^\\dagger]\\rho_\\beta=(2\\beta p^T(\\nabla^2U)\\nabla U-\\nabla^3U:p\\otimes p\\otimes p)\\rho_\\beta,\\]\n\\[[\\mathcal L_B^\\dagger,\\mathcal L_B^\\dagger,\\mathcal L_A^\\dagger]\\rho_\\beta=-(2\\beta p^T(\\nabla^2U)\\nabla U)\\rho_\\beta.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 320,
      "printed_page": 299,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n299\nsimplifying the computation to\nL\u0004\n2;\u0002OYZYO\u0003\u0005ˇ D 1\n12\nh\nL\u0004\nZ; L\u0004\nZ; L\u0004\nY\ni\n\u0005ˇ \u0003 1\n24ŒL\u0004\nY; L\u0004\nY; L\u0004\nZ\t\u0005ˇ:\n(7.29)\nThe inhomogeneity for the schemes \u0002OABAO\u0003 and \u0002OBABO\u0003 is hence a combina-\ntion of the two commutator terms\nh\nL\u0004\nA; L\u0004\nA; L\u0004\nB\ni\n\u0005ˇ D\n\u0004\n2ˇpT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nh\nL\u0004\nB; L\u0004\nB; L\u0004\nA\ni\n\u0005ˇ D \u0003 \u00042ˇpT \u0004r2U\u0005 rU\u0005 \u0005ˇ;\ngiving overall equations to solve\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OABAO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OABAO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n6pT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OBABO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OBABO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n2r3U W p ˝ p ˝ p \u0003 6pT \u0004\nr2U\n\u0005\nrU\n\u0005\n\u0005ˇ:\nWe can see immediately that the Fredholm alternative holds in both cases, as both\nequations have right-hand sides that are of odd order in p, and hence will average\nto 0.\nIf we instead consider schemes which use a central Ornstein-Uhlenbeck update,\nthen the inhomogeneous term becomes signiﬁcantly more complex, as we no\nlonger have a signiﬁcant number of cancellations in L\u0004\n2\u0005ˇ. Instead, we shall avoid\ncomputing the right-hand side for these schemes altogether, in favor of utilizing the\nfollowing lemma [223]:\nLemma 7.1 Consider two numerical schemes with associated operators governing\nthe evolution of measure ST and T S, with unique associated invariant distributions\nO\u0005ST and O\u0005TS respectively, such that\nST O\u0005ST D O\u0005ST;\nT S O\u0005TS D O\u0005TS:\nUnder suitable ergodicity assumptions (such that in the long-time limit, all distribu-\ntions converge to the invariant distribution), we have\nO\u0005ST D S O\u0005TS;\nand\nO\u0005TS D T O\u0005ST:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。"
  ],
  "issues": [
    "已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.hessianU",
  "lean_declarations": [
    "MD.Ch07.hessianU",
    "MD.Ch07.thirdU",
    "MD.Ch07.hessianGrad",
    "MD.Ch07.cubicThird",
    "MD.Ch07.tripleCommutatorPrinted",
    "MD.Ch07.tripleCommutatorPrinted_corrected",
    "MD.Ch07.tripleCommutator_corrected",
    "MD.Ch07.tripleCommutator_factor_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def hessianU (U : V n → ℝ) (q : V n) (i j : Fin n) : ℝ := coordDerivative (fun y ↦ gradient U y j) q i
def thirdU (U : V n → ℝ) (q : V n) (i j k : Fin n) : ℝ := coordDerivative (fun y ↦ hessianU U y j k) q i
def hessianGrad (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*gradient U x.1 j
def cubicThird (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, ∑ k, thirdU U x.1 i j k*x.2 i*x.2 j*x.2 k
def tripleCommutatorPrinted (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  (2*β*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
def tripleCommutatorPrinted_corrected (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*(2*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
theorem tripleCommutator_corrected (U : V n → ℝ) (β : ℝ) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    let m : V n := fun _ ↦ 1
    let ρ := gibbsWeight m U β
    phaseComm (aForward m) (phaseComm (aForward m) (bForward U)) ρ = tripleCommutatorPrinted_corrected U β ∧
    phaseComm (bForward U) (phaseComm (bForward U) (aForward m)) ρ =
      (fun x ↦ -2*β*hessianGrad U x*ρ x) := by
  sorry
theorem tripleCommutator_factor_counterexample : (2*(2 : ℝ)*0-1) ≠ 2*(2*0-1) := by norm_num
```

## MD-7.9.1-SymmetricRHS
```json
{
  "source_id": "MD-7.9.1-SymmetricRHS",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.1",
  "printed_page": "299",
  "pdf_page": "320",
  "statement_latex": "\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_{2,[OABAO]})=\\frac\\beta{24}(6p^T(\\nabla^2U)\\nabla U-\\nabla^3U:p\\otimes p\\otimes p)\\rho_\\beta,\\]\n\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_{2,[OBABO]})=\\frac\\beta{24}(2\\nabla^3U:p\\otimes p\\otimes p-6p^T(\\nabla^2U)\\nabla U)\\rho_\\beta.\\]\nWe can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $p$, and hence will average to 0.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 320,
      "printed_page": 299,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n299\nsimplifying the computation to\nL\u0004\n2;\u0002OYZYO\u0003\u0005ˇ D 1\n12\nh\nL\u0004\nZ; L\u0004\nZ; L\u0004\nY\ni\n\u0005ˇ \u0003 1\n24ŒL\u0004\nY; L\u0004\nY; L\u0004\nZ\t\u0005ˇ:\n(7.29)\nThe inhomogeneity for the schemes \u0002OABAO\u0003 and \u0002OBABO\u0003 is hence a combina-\ntion of the two commutator terms\nh\nL\u0004\nA; L\u0004\nA; L\u0004\nB\ni\n\u0005ˇ D\n\u0004\n2ˇpT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nh\nL\u0004\nB; L\u0004\nB; L\u0004\nA\ni\n\u0005ˇ D \u0003 \u00042ˇpT \u0004r2U\u0005 rU\u0005 \u0005ˇ;\ngiving overall equations to solve\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OABAO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OABAO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n6pT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OBABO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OBABO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n2r3U W p ˝ p ˝ p \u0003 6pT \u0004\nr2U\n\u0005\nrU\n\u0005\n\u0005ˇ:\nWe can see immediately that the Fredholm alternative holds in both cases, as both\nequations have right-hand sides that are of odd order in p, and hence will average\nto 0.\nIf we instead consider schemes which use a central Ornstein-Uhlenbeck update,\nthen the inhomogeneous term becomes signiﬁcantly more complex, as we no\nlonger have a signiﬁcant number of cancellations in L\u0004\n2\u0005ˇ. Instead, we shall avoid\ncomputing the right-hand side for these schemes altogether, in favor of utilizing the\nfollowing lemma [223]:\nLemma 7.1 Consider two numerical schemes with associated operators governing\nthe evolution of measure ST and T S, with unique associated invariant distributions\nO\u0005ST and O\u0005TS respectively, such that\nST O\u0005ST D O\u0005ST;\nT S O\u0005TS D O\u0005TS:\nUnder suitable ergodicity assumptions (such that in the long-time limit, all distribu-\ntions converge to the invariant distribution), we have\nO\u0005ST D S O\u0005TS;\nand\nO\u0005TS D T O\u0005ST:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.symmetricRHS",
  "lean_declarations": [
    "MD.Ch07.symmetricRHS",
    "MD.Ch07.symmetricRHS_odd",
    "MD.Ch07.symmetricRHS_zeroMean"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def symmetricRHS (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/24*(if flip then 2*cubicThird U x-6*hessianGrad U x else 6*hessianGrad U x-cubicThird U x)
theorem symmetricRHS_odd (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) :
    symmetricRHS flip U β (x.1,-x.2) = -symmetricRHS flip U β x := by
  have hG : hessianGrad U (x.1,-x.2) = -hessianGrad U x := by
    simp [hessianGrad,Finset.sum_neg_distrib]
  have hT : cubicThird U (x.1,-x.2) = -cubicThird U x := by
    simp [cubicThird,Finset.sum_neg_distrib]
  cases flip <;> simp [symmetricRHS,hG,hT] <;> ring
theorem symmetricRHS_zeroMean (flip : Bool) (U : V n → ℝ) (β : ℝ)
    (hint : Integrable (symmetricRHS flip U β) (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, symmetricRHS flip U β x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

## MD-7.9.1-Lemma71
```json
{
  "source_id": "MD-7.9.1-Lemma71",
  "kind": "lemma",
  "label": "Lemma 7.1",
  "section": "7.9.1",
  "printed_page": "299–300",
  "pdf_page": "320–321",
  "statement_latex": "Lemma 7.1 Consider two numerical schemes with associated operators governing the evolution of measure $ST$ and $TS$, with unique associated invariant distributions $\\widehat\\rho_{ST}$ and $\\widehat\\rho_{TS}$ respectively, such that\n\\[ST\\widehat\\rho_{ST}=\\widehat\\rho_{ST},\\qquad TS\\widehat\\rho_{TS}=\\widehat\\rho_{TS}.\\]\nUnder suitable ergodicity assumptions (such that in the long-time limit, all distributions converge to the invariant distribution), we have\n\\[\\widehat\\rho_{ST}=S\\widehat\\rho_{TS},\\qquad\\widehat\\rho_{TS}=T\\widehat\\rho_{ST}.\\]",
  "proof_latex": "If we assume that $\\lim_{n\\to\\infty}(ST)^n\\rho=\\widehat\\rho_{ST}$, for any initial distribution $\\rho$, then we have\n$\\widehat\\rho_{ST}=\\lim_{n\\to\\infty}(ST)^n\\widehat\\rho_{ST}=\\lim_{n\\to\\infty}S(TS)^{n-1}T\\widehat\\rho_{ST}=S\\widehat\\rho_{TS}$.\nA similar statement holds for $\\widehat\\rho_{ST}$.",
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 320,
      "printed_page": 299,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n299\nsimplifying the computation to\nL\u0004\n2;\u0002OYZYO\u0003\u0005ˇ D 1\n12\nh\nL\u0004\nZ; L\u0004\nZ; L\u0004\nY\ni\n\u0005ˇ \u0003 1\n24ŒL\u0004\nY; L\u0004\nY; L\u0004\nZ\t\u0005ˇ:\n(7.29)\nThe inhomogeneity for the schemes \u0002OABAO\u0003 and \u0002OBABO\u0003 is hence a combina-\ntion of the two commutator terms\nh\nL\u0004\nA; L\u0004\nA; L\u0004\nB\ni\n\u0005ˇ D\n\u0004\n2ˇpT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nh\nL\u0004\nB; L\u0004\nB; L\u0004\nA\ni\n\u0005ˇ D \u0003 \u00042ˇpT \u0004r2U\u0005 rU\u0005 \u0005ˇ;\ngiving overall equations to solve\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OABAO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OABAO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n6pT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n\u0005ˇ;\nL\u0004\nLD\n\u0004\n\u0005ˇf2;\u0002OBABO\u0003\n\u0005\nD \u0003L\u0004\n2;\u0002OBABO\u0003\u0005ˇ\nD ˇ\n24\n\u0004\n2r3U W p ˝ p ˝ p \u0003 6pT \u0004\nr2U\n\u0005\nrU\n\u0005\n\u0005ˇ:\nWe can see immediately that the Fredholm alternative holds in both cases, as both\nequations have right-hand sides that are of odd order in p, and hence will average\nto 0.\nIf we instead consider schemes which use a central Ornstein-Uhlenbeck update,\nthen the inhomogeneous term becomes signiﬁcantly more complex, as we no\nlonger have a signiﬁcant number of cancellations in L\u0004\n2\u0005ˇ. Instead, we shall avoid\ncomputing the right-hand side for these schemes altogether, in favor of utilizing the\nfollowing lemma [223]:\nLemma 7.1 Consider two numerical schemes with associated operators governing\nthe evolution of measure ST and T S, with unique associated invariant distributions\nO\u0005ST and O\u0005TS respectively, such that\nST O\u0005ST D O\u0005ST;\nT S O\u0005TS D O\u0005TS:\nUnder suitable ergodicity assumptions (such that in the long-time limit, all distribu-\ntions converge to the invariant distribution), we have\nO\u0005ST D S O\u0005TS;\nand\nO\u0005TS D T O\u0005ST:\n"
    },
    {
      "pdf_page": 321,
      "printed_page": 300,
      "text": "300\n7\nNumerical Methods for Stochastic Molecular Dynamics\nProof The proof is very simple, and follows almost directly from our ergodicity\nassumption. If we assume that\nlim\nn!1 .ST /n \u0005 D O\u0005ST;\nfor any initial distribution \u0005, then we have\nO\u0005ST D lim\nn!1 .ST /n O\u0005ST D lim\nn!1 S .T S/n\u00021 T O\u0005ST D S O\u0005TS:\nA similar statement holds for O\u0005ST.\n\u0002\nIf we return to our scheme \u0002OYZYO\u0003, which has a simple inhomogeneity, then\nwe can relate its invariant distribution to invariant distributions of schemes with a\ncentral OU update by writing its evolution operator as\neh OL\u0004\n\u0002OYZYO\u0003 D e.h=2/L\u0004\nOe.h=2/L\u0004\nYe.h=2/L\u0004\nZ\n„\nƒ‚\n…\nS\ne.h=2/L\u0004\nZe.h=2/L\u0004\nYe.h=2/L\u0004\nO\n„\nƒ‚\n…\nT\nD ST :\nBy applying Lemma 7.1, we can equate the invariant distributions directly as\nO\u0005\u0002ZYOYZ\u0003 D exp..h=2/L\u0004\nZ/ exp..h=2/L\u0004\nY/ exp..h=2/L\u0004\nO/ O\u0005\u0002OYZYO\u0003:\nRewriting our ansatz (7.27) in place of the distributions, and expanding the\nexponential series gives\n\u0005ˇ\n\u0004\n1 C h2f2;\u0002ZYOYZ\u0003 C : : :\n\u0005\nD\n\b\nIdCh\n2L\u0004\nLDCh2\n4 L\u0004\n1;\u0002OYZ\u0003 C h2\n2 L\u0004\nLD C : : :\n\t \u0004\n\u0005ˇ\n\u0004\n1 C h2f2;\u0002OYZYO\u0003 C : : :\n\u0005\u0005\n;\nand hence equating powers we have\nf2;\u0002ZYOYZ\u0003\u0005ˇ D f2;\u0002OYZYO\u0003\u0005ˇ C 1\n4L\u0004\n1;\u0002OYZ\u0003\u0005ˇ:\nBy virtue of (7.20), we have\nL\u0004\n1;\u0002OAB\u0003\u0005ˇ D 1\n2L\u0004\nH\n\u0004\ng\u0005ˇ\n\u0005\nL\u0004\n1;\u0002OBA\u0003\u0005ˇ D \u00031\n2L\u0004\nH\n\u0004\ng\u0005ˇ\n\u0005\n;\nwhere recall g.q; p/\u0005ˇ D L\u0004\nA\u0005ˇ D ˇpTM\u00021rU.q/\u0005ˇ. Computing\nL\u0004\nH\n\u0004\ng\u0005ˇ\n\u0005\nD ˇ\n\u0004\njrU.q/j2 \u0003 pTr2U.q/p\n\u0005\n\u0005ˇ;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.lemma71",
  "lean_declarations": [
    "MD.Ch07.lemma71"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": [
    "MolecularDynamics.textbookUniqueInvariantProbability",
    "MolecularDynamics.textbookInvariantDistributionSwap"
  ]
}
```
```lean
theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS
```

## MD-7.9.1-ConjugateSymmetricCorrections
```json
{
  "source_id": "MD-7.9.1-ConjugateSymmetricCorrections",
  "kind": "unnumbered_claim",
  "label": "(7.30a)–(7.30b)",
  "section": "7.9.1",
  "printed_page": "300–301",
  "pdf_page": "321–322",
  "statement_latex": "\\[\\widehat\\rho_{[ZYOYZ]}=\\exp((h/2)\\mathcal L_Z^\\dagger)\\exp((h/2)\\mathcal L_Y^\\dagger)\\exp((h/2)\\mathcal L_O^\\dagger)\\widehat\\rho_{[OYZYO]}.\\]\n\\[f_{2,[ZYOYZ]}\\rho_\\beta=f_{2,[OYZYO]}\\rho_\\beta+\\tfrac14\\mathcal L_{1,[OYZ]}^\\dagger\\rho_\\beta.\\]\n\\[\\mathcal L_{1,[OAB]}^\\dagger\\rho_\\beta=\\tfrac12\\mathcal L_H^\\dagger(g\\rho_\\beta),\\qquad\n\\mathcal L_{1,[OBA]}^\\dagger\\rho_\\beta=-\\tfrac12\\mathcal L_H^\\dagger(g\\rho_\\beta),\\]\n\\[\\mathcal L_H^\\dagger(g\\rho_\\beta)=\\beta(|\\nabla U|^2-p^T\\nabla^2Up)\\rho_\\beta,\\]\n\\[f_{2,[ABOBA]}=f_{2,[OBABO]}-\\tfrac\\beta8(|\\nabla U|^2-p^T\\nabla^2Up),\\tag{7.30a}\\]\n\\[f_{2,[BAOAB]}=f_{2,[OABAO]}+\\tfrac\\beta8(|\\nabla U|^2-p^T\\nabla^2Up).\\tag{7.30b}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 321,
      "printed_page": 300,
      "text": "300\n7\nNumerical Methods for Stochastic Molecular Dynamics\nProof The proof is very simple, and follows almost directly from our ergodicity\nassumption. If we assume that\nlim\nn!1 .ST /n \u0005 D O\u0005ST;\nfor any initial distribution \u0005, then we have\nO\u0005ST D lim\nn!1 .ST /n O\u0005ST D lim\nn!1 S .T S/n\u00021 T O\u0005ST D S O\u0005TS:\nA similar statement holds for O\u0005ST.\n\u0002\nIf we return to our scheme \u0002OYZYO\u0003, which has a simple inhomogeneity, then\nwe can relate its invariant distribution to invariant distributions of schemes with a\ncentral OU update by writing its evolution operator as\neh OL\u0004\n\u0002OYZYO\u0003 D e.h=2/L\u0004\nOe.h=2/L\u0004\nYe.h=2/L\u0004\nZ\n„\nƒ‚\n…\nS\ne.h=2/L\u0004\nZe.h=2/L\u0004\nYe.h=2/L\u0004\nO\n„\nƒ‚\n…\nT\nD ST :\nBy applying Lemma 7.1, we can equate the invariant distributions directly as\nO\u0005\u0002ZYOYZ\u0003 D exp..h=2/L\u0004\nZ/ exp..h=2/L\u0004\nY/ exp..h=2/L\u0004\nO/ O\u0005\u0002OYZYO\u0003:\nRewriting our ansatz (7.27) in place of the distributions, and expanding the\nexponential series gives\n\u0005ˇ\n\u0004\n1 C h2f2;\u0002ZYOYZ\u0003 C : : :\n\u0005\nD\n\b\nIdCh\n2L\u0004\nLDCh2\n4 L\u0004\n1;\u0002OYZ\u0003 C h2\n2 L\u0004\nLD C : : :\n\t \u0004\n\u0005ˇ\n\u0004\n1 C h2f2;\u0002OYZYO\u0003 C : : :\n\u0005\u0005\n;\nand hence equating powers we have\nf2;\u0002ZYOYZ\u0003\u0005ˇ D f2;\u0002OYZYO\u0003\u0005ˇ C 1\n4L\u0004\n1;\u0002OYZ\u0003\u0005ˇ:\nBy virtue of (7.20), we have\nL\u0004\n1;\u0002OAB\u0003\u0005ˇ D 1\n2L\u0004\nH\n\u0004\ng\u0005ˇ\n\u0005\nL\u0004\n1;\u0002OBA\u0003\u0005ˇ D \u00031\n2L\u0004\nH\n\u0004\ng\u0005ˇ\n\u0005\n;\nwhere recall g.q; p/\u0005ˇ D L\u0004\nA\u0005ˇ D ˇpTM\u00021rU.q/\u0005ˇ. Computing\nL\u0004\nH\n\u0004\ng\u0005ˇ\n\u0005\nD ˇ\n\u0004\njrU.q/j2 \u0003 pTr2U.q/p\n\u0005\n\u0005ˇ;\n"
    },
    {
      "pdf_page": 322,
      "printed_page": 301,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n301\nthe correction for the schemes with a central O update can be expressed as\nf2;\u0002ABOBA\u0003 D f2;\u0002OBABO\u0003 \u0003 ˇ\n8\n\u0004\njrU.q/j2 \u0003 pTr2Up\n\u0005\n;\n(7.30a)\nf2;\u0002BAOAB\u0003 D f2;\u0002OABAO\u0003 C ˇ\n8\n\u0004jrU.q/j2 \u0003 pTr2Up\u0005 :\n(7.30b)\nThus we need only compute the solutions to the simpler PDE (7.29), in order to\nrelate the solutions of the conjugate schemes with centralized OU update. However,\nalthough this simpliﬁes our task greatly, ﬁnding the general solution to (7.29) is still\nvery challenging, and obtaining a closed form expression for the correction function\nis nontrivial.\n7.9.2\nExpansion in Powers of \u0011\u00021\nAlthough we do not give the general analytical solution to the partial differential\nequation of\n(7.28) for each of the four symmetric Langevin schemes we are\nconsidering, we can easily ﬁnd a solution in an important limiting case: the high\nfriction regime. We consider expanding f2 into a series involving the reciprocal\nfriction \" D 1=\n, and assume that for large friction our ansatz remains sensible.\nWe will denote\nf2.q; p/ D f2;0.q; p/ C \"f2;1.q; p/ C \"2f2;2.q; p/ C : : :\n(7.31)\nwith each hf2;ii D 0. Dividing by the friction in (7.28) we obtain\n\u0006\nNL\u0004\nO C \"L\u0004\nH\n\u0007 \u0004\nf2\u0005ˇ\n\u0005\nD \u0003\"L\u0004\n2\u0005ˇ;\nwhere NL\u0004\nO is independent of the friction\nNL\u0004\nO# D \"L\u0004\nO# D rp \u0002 .p#/ C 1\nˇ \u0016p#:\nFrom our earlier computation in (7.29), we can write\nL\u0004\n2;\u0002OABAO\u0003\u0005ˇ D w.q; p/\u0005ˇ;\nfor w.q; p/ independent of the friction\nw.q; p/ D \u0003 ˇ\n24\n\u0004\n6pT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。"
  ],
  "issues": [
    "已目视核对PDF321：所印传播子展开末项为(h²/2)L_LD，按exp的二阶展开应为(h²/8)(L_LD)²；该项作用ρβ为零，不改变后续修正关系。"
  ],
  "statement_scope": "形式传递系数的消项及(7.30)全部目标；未证明从具体分裂映射导出这些系数。",
  "lean_decl": "MD.Ch07.gradNormSq",
  "lean_declarations": [
    "MD.Ch07.gradNormSq",
    "MD.Ch07.hessianQuadratic",
    "MD.Ch07.conjugateCorrectionChange",
    "MD.Ch07.conjugateCorrections",
    "MD.Ch07.conjugateCorrection_coefficient",
    "MD.Ch07.conjugateExpansionPrinted",
    "MD.Ch07.conjugateExpansionPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def gradNormSq (U : V n → ℝ) (q : V n) : ℝ := ∑ i, gradient U q i^2
def hessianQuadratic (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*x.2 j
def conjugateCorrectionChange (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/8*(gradNormSq U x.1-hessianQuadratic U x)
def conjugateCorrections (U : V n → ℝ) (β : ℝ) (fABOBA fOBABO fBAOAB fOABAO : Phase n → ℝ) : Prop :=
  fABOBA = fOBABO-conjugateCorrectionChange U β ∧ fBAOAB = fOABAO+conjugateCorrectionChange U β
theorem conjugateCorrection_coefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (p : ℕ → E) (q2 : E)
    (hL : L0 (p 0) = 0) (hp : p 1 = 0)
    (htransfer : q2 = p 2+(1/2 : ℝ) • L0 (p 1)+
      (1/4 : ℝ) • L1 (p 0)+(1/8 : ℝ) • (L0*L0) (p 0)) :
    q2 = p 2+(1/4 : ℝ) • L1 (p 0) := by
  simpa [hp,hL,Module.End.mul_apply] using htransfer

def conjugateExpansionPrinted {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/2) • L0

def conjugateExpansionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/8) • (L0*L0)
```

## MD-7.9.2-ReciprocalFrictionExpansion
```json
{
  "source_id": "MD-7.9.2-ReciprocalFrictionExpansion",
  "kind": "definition",
  "label": "(7.31) / (7.32)",
  "section": "7.9.2",
  "printed_page": "301–302",
  "pdf_page": "322–323",
  "statement_latex": "We will denote\n\\[f_2(q,p)=f_{2,0}(q,p)+\\epsilon f_{2,1}(q,p)+\\epsilon^2f_{2,2}(q,p)+\\cdots,\\tag{7.31}\\]\nwith each $\\langle f_{2,i}\\rangle=0$. Dividing by the friction in (7.28) we obtain\n\\[(\\overline{\\mathcal L}_O^\\dagger+\\epsilon\\mathcal L_H^\\dagger)(f_2\\rho_\\beta)=-\\epsilon\\mathcal L_2^\\dagger\\rho_\\beta,\\]\nwhere $\\overline{\\mathcal L}_O^\\dagger\\vartheta=\\epsilon\\mathcal L_O^\\dagger\\vartheta=\\nabla_p\\cdot(p\\vartheta)+\\beta^{-1}\\Delta_p\\vartheta$.\n\\[w(q,p)=-\\tfrac\\beta{24}(6p^T(\\nabla^2U)\\nabla U-\\nabla^3U:p\\otimes p\\otimes p).\\]\nEquating powers gives\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,0})=0,\\quad\n\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,0})+\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,1})=-w\\rho_\\beta,\\tag{7.32}\\]\n\\[\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,1})+\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,2})=0,\\quad\n\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,2})+\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,3})=0.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 322,
      "printed_page": 301,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n301\nthe correction for the schemes with a central O update can be expressed as\nf2;\u0002ABOBA\u0003 D f2;\u0002OBABO\u0003 \u0003 ˇ\n8\n\u0004\njrU.q/j2 \u0003 pTr2Up\n\u0005\n;\n(7.30a)\nf2;\u0002BAOAB\u0003 D f2;\u0002OABAO\u0003 C ˇ\n8\n\u0004jrU.q/j2 \u0003 pTr2Up\u0005 :\n(7.30b)\nThus we need only compute the solutions to the simpler PDE (7.29), in order to\nrelate the solutions of the conjugate schemes with centralized OU update. However,\nalthough this simpliﬁes our task greatly, ﬁnding the general solution to (7.29) is still\nvery challenging, and obtaining a closed form expression for the correction function\nis nontrivial.\n7.9.2\nExpansion in Powers of \u0011\u00021\nAlthough we do not give the general analytical solution to the partial differential\nequation of\n(7.28) for each of the four symmetric Langevin schemes we are\nconsidering, we can easily ﬁnd a solution in an important limiting case: the high\nfriction regime. We consider expanding f2 into a series involving the reciprocal\nfriction \" D 1=\n, and assume that for large friction our ansatz remains sensible.\nWe will denote\nf2.q; p/ D f2;0.q; p/ C \"f2;1.q; p/ C \"2f2;2.q; p/ C : : :\n(7.31)\nwith each hf2;ii D 0. Dividing by the friction in (7.28) we obtain\n\u0006\nNL\u0004\nO C \"L\u0004\nH\n\u0007 \u0004\nf2\u0005ˇ\n\u0005\nD \u0003\"L\u0004\n2\u0005ˇ;\nwhere NL\u0004\nO is independent of the friction\nNL\u0004\nO# D \"L\u0004\nO# D rp \u0002 .p#/ C 1\nˇ \u0016p#:\nFrom our earlier computation in (7.29), we can write\nL\u0004\n2;\u0002OABAO\u0003\u0005ˇ D w.q; p/\u0005ˇ;\nfor w.q; p/ independent of the friction\nw.q; p/ D \u0003 ˇ\n24\n\u0004\n6pT \u0004\nr2U\n\u0005\nrU \u0003 r3U W p ˝ p ˝ p\n\u0005\n:\n"
    },
    {
      "pdf_page": 323,
      "printed_page": 302,
      "text": "302\n7\nNumerical Methods for Stochastic Molecular Dynamics\nHence we have\n\u0006\nNL\u0004\nO C \"L\u0004\nH\n\u0007 \u0004\n\u0005ˇ.f2;0;\u0002OABAO\u0003.q; p/ C \"f2;1;\u0002OABAO\u0003.q; p/C : : :/\n\u0005\nD \u0003 \"w.q; p/\u0005ˇ;\nand equating powers of the reciprocal friction \" gives us a sequence of equations to\nsolve\nOrder 1:\nNL\u0004\nO\n\u0004\n\u0005ˇf2;0;\u0002OABAO\u0003\n\u0005\nD 0;\nOrder \":\nL\u0004\nH\n\u0004\n\u0005ˇf2;0;\u0002OABAO\u0003\n\u0005\nC NL\u0004\nO\n\u0004\n\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005\nD \u0003w.q; p/\u0005ˇ;\nOrder \"2:\nL\u0004\nH\n\u0004\n\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005\nC NL\u0004\nO\n\u0004\n\u0005ˇf2;2;\u0002OABAO\u0003\n\u0005\nD 0;\nOrder \"3:\nL\u0004\nH\n\u0004\n\u0005ˇf2;2;\u0002OABAO\u0003\n\u0005\nC NL\u0004\nO\n\u0004\n\u0005ˇf2;3;\u0002OABAO\u0003\n\u0005\nD 0;\n:::\nThe ﬁrst equation at order one tells us that f2;0;\u0002OABAO\u0003.q; p/ must be a function of\nposition only, as the kernel of NL\u0004\nO is the set of functions that are constant with respect\nto p. Hence we shall denote\nf2;0;\u0002OABAO\u0003.q; p/ D \u0003.q/;\nwhere we our goal is now to explicitly ﬁnd \u0003.q/. Unfortunately, \u0003.q/ is not explicitly\ndetermined at this point, we only know that it is a function of position only such that\nh\u0003i D 0. This function will be determined as we solve the higher order equations.\nIn order to determine \u0003.q/, we will have to solve the next PDE at order \",\nNL\u0004\nO\n\u0004\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005 C L\u0004\nH\n\u0004\u0005ˇf2;0;\u0002OABAO\u0003\n\u0005 D \u0003w.q; p/\u0005ˇ;\n(7.32)\nwhere we will make use of the formulas\nNL\u0004\nO\n\u0004\n\u0005ˇr3U W p ˝ p ˝ p\n\u0005\nD \u00033\u0005ˇr3U W p ˝ p ˝ p C 6\u0005ˇ\nˇ pTrq\u0016qU;\nNL\u0004\nO\n\u0004\n\u0005ˇpTrq\u0016qU\n\u0005\nD \u0003\u0005ˇpTrq\u0016qU;\nNL\u0004\nO\n\u0004\n\u0005ˇpT \u0004\nr2U\n\u0005\nrU\n\u0005\nD \u0003\u0005ˇpT \u0004\nr2U\n\u0005\nrU;\nto write\nw.q; p/\u0005ˇ D ˇ\n24\nNL\u0004\nO\n\b\u0002\n6pT \u0004r2U\u0005 rU \u0003 1\n3r3U W p ˝ p ˝ p \u0003 2\nˇ pTrq\u0016qU\n\u0003\n\u0005ˇ\n\t\n:\n(7.33)\nAdditionally, for \u0003.q/ we have the identity\nL\u0004\nH\n\u0004\n\u0005ˇ\u0003\n\u0005\nD \u0003pTr\u0003\u0005ˇ D NL\u0004\nO\n\u0004\npTr\u0003 C \u0006.q/\n\u000b\n\u0005ˇ\n\u0005\n;\n(7.34)\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.phaseH",
  "lean_declarations": [
    "MD.Ch07.phaseH",
    "MD.Ch07.reciprocalHierarchy"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0
```
