# EAUDIT07 第7章修改后陈述复审

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
    "右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。",
    "29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。"
  ],
  "issues": [],
  "statement_scope": "单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。",
  "lean_decl": "MD.Ch07.symmetricRHS",
  "lean_declarations": [
    "MD.Ch07.symmetricRHS",
    "MD.Ch07.symmetricRHS_odd",
    "MD.Ch07.symmetricRHS_zeroMean"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "补登记M=I和flip对应关系；将PDE右端识别、正有限配分函数桥、Fredholm空间及兼容/充分条件列为独立义务。保留原书文字并标[ERRATUM?]适用条件不足。",
      "actual_scope": "单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。"
  ]
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
    "ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。",
    "29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。"
  ],
  "issues": [],
  "statement_scope": "仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。",
  "lean_decl": "MD.Ch07.phaseH",
  "lean_declarations": [
    "MD.Ch07.phaseH",
    "MD.Ch07.reciprocalHierarchy"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "在不改摘录的前提下，补列形式级数及缩放方程的目标签名、β>0与γ>0资格、各阶Integrable及零均值的合取；或把statement_scope明确限为未中心化的形式层级。",
      "actual_scope": "仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。"
  ]
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

## MD-7.9.2-OUKernelQualification
```json
{
  "source_id": "MD-7.9.2-OUKernelQualification",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.2",
  "printed_page": "302",
  "pdf_page": "323",
  "statement_latex": "The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\\overline{\\mathcal L}_O^\\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\\nu(q)$, where $\\langle\\nu\\rangle=0$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 323,
      "printed_page": 302,
      "text": "302\n7\nNumerical Methods for Stochastic Molecular Dynamics\nHence we have\n\u0006\nNL\u0004\nO C \"L\u0004\nH\n\u0007 \u0004\n\u0005ˇ.f2;0;\u0002OABAO\u0003.q; p/ C \"f2;1;\u0002OABAO\u0003.q; p/C : : :/\n\u0005\nD \u0003 \"w.q; p/\u0005ˇ;\nand equating powers of the reciprocal friction \" gives us a sequence of equations to\nsolve\nOrder 1:\nNL\u0004\nO\n\u0004\n\u0005ˇf2;0;\u0002OABAO\u0003\n\u0005\nD 0;\nOrder \":\nL\u0004\nH\n\u0004\n\u0005ˇf2;0;\u0002OABAO\u0003\n\u0005\nC NL\u0004\nO\n\u0004\n\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005\nD \u0003w.q; p/\u0005ˇ;\nOrder \"2:\nL\u0004\nH\n\u0004\n\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005\nC NL\u0004\nO\n\u0004\n\u0005ˇf2;2;\u0002OABAO\u0003\n\u0005\nD 0;\nOrder \"3:\nL\u0004\nH\n\u0004\n\u0005ˇf2;2;\u0002OABAO\u0003\n\u0005\nC NL\u0004\nO\n\u0004\n\u0005ˇf2;3;\u0002OABAO\u0003\n\u0005\nD 0;\n:::\nThe ﬁrst equation at order one tells us that f2;0;\u0002OABAO\u0003.q; p/ must be a function of\nposition only, as the kernel of NL\u0004\nO is the set of functions that are constant with respect\nto p. Hence we shall denote\nf2;0;\u0002OABAO\u0003.q; p/ D \u0003.q/;\nwhere we our goal is now to explicitly ﬁnd \u0003.q/. Unfortunately, \u0003.q/ is not explicitly\ndetermined at this point, we only know that it is a function of position only such that\nh\u0003i D 0. This function will be determined as we solve the higher order equations.\nIn order to determine \u0003.q/, we will have to solve the next PDE at order \",\nNL\u0004\nO\n\u0004\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005 C L\u0004\nH\n\u0004\u0005ˇf2;0;\u0002OABAO\u0003\n\u0005 D \u0003w.q; p/\u0005ˇ;\n(7.32)\nwhere we will make use of the formulas\nNL\u0004\nO\n\u0004\n\u0005ˇr3U W p ˝ p ˝ p\n\u0005\nD \u00033\u0005ˇr3U W p ˝ p ˝ p C 6\u0005ˇ\nˇ pTrq\u0016qU;\nNL\u0004\nO\n\u0004\n\u0005ˇpTrq\u0016qU\n\u0005\nD \u0003\u0005ˇpTrq\u0016qU;\nNL\u0004\nO\n\u0004\n\u0005ˇpT \u0004\nr2U\n\u0005\nrU\n\u0005\nD \u0003\u0005ˇpT \u0004\nr2U\n\u0005\nrU;\nto write\nw.q; p/\u0005ˇ D ˇ\n24\nNL\u0004\nO\n\b\u0002\n6pT \u0004r2U\u0005 rU \u0003 1\n3r3U W p ˝ p ˝ p \u0003 2\nˇ pTrq\u0016qU\n\u0003\n\u0005ˇ\n\t\n:\n(7.33)\nAdditionally, for \u0003.q/ we have the identity\nL\u0004\nH\n\u0004\n\u0005ˇ\u0003\n\u0005\nD \u0003pTr\u0003\u0005ˇ D NL\u0004\nO\n\u0004\npTr\u0003 C \u0006.q/\n\u000b\n\u0005ˇ\n\u0005\n;\n(7.34)\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。",
    "29号覆盖限定：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。"
  ],
  "issues": [
    "已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。"
  ],
  "statement_scope": "原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。",
  "lean_decl": "MD.Ch07.ouKernelPrinted",
  "lean_declarations": [
    "MD.Ch07.ouKernelPrinted",
    "MD.Ch07.ouKernelPrinted_corrected",
    "MD.Ch07.ouKernelCentered_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "NEEDS_HUMAN",
      "suggested_fix": "原印保留并标[ERRATUM?]；修正版保留L²及共轭，另设归一测度下的中心化前提。逐字引文恢复原页句子或显式标为摘述。",
      "actual_scope": "原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": []
}
```
```lean
def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry

theorem ouKernelCentered_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hi : Integrable f (productGibbs (fun _ ↦ 1) U β))
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0)
    (hmean : ∫ x, f x ∂productGibbs (fun _ ↦ 1) U β = 0) :
    ∃ ν : V n → ℝ, (∀ q p, f (q,p)=ν q) ∧
      Integrable ν (positionGibbs U β) ∧ (∫ q, ν q ∂positionGibbs U β)=0 := by
  sorry
```
