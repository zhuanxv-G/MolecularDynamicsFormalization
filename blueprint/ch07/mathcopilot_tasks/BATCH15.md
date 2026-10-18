# BATCH15 第7章原文与陈述审校

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
    "修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。"
  ],
  "issues": [
    "已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.ouKernelPrinted",
  "lean_declarations": [
    "MD.Ch07.ouKernelPrinted",
    "MD.Ch07.ouKernelPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
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
```

## MD-7.9.2-OUHermiteIdentities
```json
{
  "source_id": "MD-7.9.2-OUHermiteIdentities",
  "kind": "unnumbered_claim",
  "label": "(7.33)–(7.34)",
  "section": "7.9.2",
  "printed_page": "302",
  "pdf_page": "323",
  "statement_latex": "\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta\\nabla^3U:p\\otimes p\\otimes p)=-3\\rho_\\beta\\nabla^3U:p\\otimes p\\otimes p+\\tfrac{6\\rho_\\beta}{\\beta}p^T\\nabla_q\\Delta_qU,\\]\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta p^T\\nabla_q\\Delta_qU)=-\\rho_\\beta p^T\\nabla_q\\Delta_qU,\\]\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta p^T(\\nabla^2U)\\nabla U)=-\\rho_\\beta p^T(\\nabla^2U)\\nabla U.\\]\n\\[w\\rho_\\beta=\\tfrac\\beta{24}\\overline{\\mathcal L}_O^\\dagger([6p^T(\\nabla^2U)\\nabla U-\\tfrac13\\nabla^3U:p\\otimes p\\otimes p-\\tfrac2\\beta p^T\\nabla_q\\Delta_qU]\\rho_\\beta).\\tag{7.33}\\]\n\\[\\mathcal L_H^\\dagger(\\rho_\\beta\\nu)=-p^T\\nabla\\nu\\rho_\\beta=\\overline{\\mathcal L}_O^\\dagger([p^T\\nabla\\nu+\\mu(q)]\\rho_\\beta).\\tag{7.34}\\]",
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
    "OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.laplacian",
  "lean_declarations": [
    "MD.Ch07.laplacian",
    "MD.Ch07.pGradLaplacian",
    "MD.Ch07.hermitePrimitive",
    "MD.Ch07.ouHermiteIdentities"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def laplacian (U : V n → ℝ) (q : V n) : ℝ := ∑ i, hessianU U q i i
def pGradLaplacian (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, x.2 i*gradient (laplacian U) x.1 i
def hermitePrimitive (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  6*hessianGrad U x-(1/3)*cubicThird U x-2/β*pGradLaplacian U x
theorem ouHermiteIdentities (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    let O := phaseO (fun _ ↦ 1) 1 β
    O (ρ*cubicThird U) = (fun x ↦ -3*ρ x*cubicThird U x+6*ρ x/β*pGradLaplacian U x) ∧
    O (ρ*pGradLaplacian U) = -(ρ*pGradLaplacian U) ∧
    O (ρ*hessianGrad U) = -(ρ*hessianGrad U) ∧
    (fun x ↦ -symmetricRHS false U β x*ρ x) = (fun x ↦ β/24*O (hermitePrimitive U β*ρ) x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry
```

## MD-7.9.2-FirstReciprocalCorrection
```json
{
  "source_id": "MD-7.9.2-FirstReciprocalCorrection",
  "kind": "unnumbered_claim",
  "label": "(7.35)–(7.36)",
  "section": "7.9.2",
  "printed_page": "303–304",
  "pdf_page": "324–325",
  "statement_latex": "\\[f_{2,1,[OABAO]}=-\\tfrac\\beta{24}(6p^T(\\nabla^2U)\\nabla U-\\tfrac13\\nabla^3U:p\\otimes p\\otimes p-\\tfrac2\\beta p^T\\nabla_q\\Delta_qU)-p^T\\nabla\\nu-\\mu.\\]\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,2,[OABAO]})=-\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,1,[OABAO]}).\\tag{7.35}\\]\n\\[\\int_{\\mathcal P}\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,2,[OABAO]})d\\omega_p=0,\\qquad\n\\int_{\\mathcal P}\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,1,[OABAO]})d\\omega_p=\\overline\\pi\\mathcal L_H^\\dagger f_{2,1,[OABAO]}=0,\\tag{7.36}\\]\nwhere $(\\overline\\pi f)(q)=\\int_{\\mathcal P}f(q,p)\\rho_\\beta d\\omega_p$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 324,
      "printed_page": 303,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n303\nfor some function of position \u0006.q/. Plugging (7.33) and (7.34) into the PDE (7.32)\ngives\nNL\u0004\nO\n\u0004\n\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005\nD \u0003w.q; p/\u0005ˇ \u0003 L\u0004\nH\n\u0004\n\u0005ˇ\u0003\n\u0005\n;\nD \u0003 ˇ\n24\nNL\u0004\nO\n\b\u0002\n6pT \u0004\nr2U\n\u0005\nrU \u0003 1\n3r3U W p ˝ p ˝ p\n\u0003 2\nˇ pTrq\u0016qU\n\u0003\n\u0005ˇ\n\t\n\u0003 NL\u0004\nO\n\u0004\npTr\u0003 C \u0006\n\u000b\n\u0005ˇ\n\u0005\n;\nand hence\nf2;1;\u0002OABAO\u0003 D \u0003 ˇ\n24\n\b\n6pT \u0004\nr2U\n\u0005\nrU \u0003 1\n3r3U W p ˝ p ˝ p \u0003 2\nˇ pTrq\u0016qU\n\t\n\u0003 pTr\u0003 \u0003 \u0006:\nAt this point, we might consider abandoning the prospect of determining the leading\norder correction altogether, as we now have two arbitrary functions of position \u0003.q/\nand \u0006.q/ creeping into our solution. However, the form of \u0003.q/ is determined by\nconsidering the next order PDE at \"2:\nNL\u0004\nO\n\u0004\u0005ˇf2;2;\u0002OABAO\u0003\n\u0005 D \u0003L\u0004\nH\n\u0004\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005 :\n(7.35)\nWe are spared solving this equation by virtue of a solvability condition. Integrating\nthe left hand side of (7.35) with respect to the momenta, we ﬁnd\nZ\nP\nNL\u0004\nO\n\u0004\n\u0005ˇf2;2;\u0002OABAO\u0003\n\u0005\nd!p D 0;\nby simple computation. Hence we also require the average of the right-hand side\nof (7.35) to be zero with respect to the momentum, or\nZ\nP\nL\u0004\nH\n\u0004\n\u0005ˇf2;1;\u0002OABAO\u0003\n\u0005\nd!p D N\u0014L\u0004\nHf2;1;\u0002OABAO\u0003 D 0;\n(7.36)\nwhere N\u0014 is the averaging operator\n. N\u0014f/ .q/ D\nZ\nP\nf.q; p/\u0005ˇd!p:\n"
    },
    {
      "pdf_page": 325,
      "printed_page": 304,
      "text": "304\n7\nNumerical Methods for Stochastic Molecular Dynamics\nHence by rewriting the correction function as\nf2;1;\u0002OABAO\u0003 D ˇ\n24\n\b\n3L\u0004\nAjrUj2 \u0003 1\n3\n\u0006\nL\u0004\nA\n\u00073\nU \u0003 2\nˇ L\u0004\nA\u0016qU\n\t\nC L\u0004\nA\u0003 \u0003 \u0006;\nwe have\nN\u0014L\u0004\nHf2;1;\u0002OABAO\u0003 D ˇ\n24\n\b\n3MjrUj2 \u0003 1\n3NU \u0003 2\nˇ M\u0016qU\n\t\nC M\u0003;\nwhere we abbreviate\nM .q/D N\u0014L\u0004\nHL\u0004\nA .q/D N\u0014\n\u0006\n.L\u0004\nA/2 C L\u0004\nBL\u0004\nA\n\u0007\n .q/ D 1\nˇ \u0016q .q/ \u0003 rU \u0002 rq .q/;\nN .q/ D N\u0014L\u0004\nH.L\u0004\nA/3 .q/ D N\u0014\n\u0006\n.L\u0004\nA/4 C L\u0004\nB.L\u0004\nA/3\u0007\n .q/ D 3\nˇ M\n\u0004\n\u0016q .q/\n\u0005\n:\nThus we have\nN\u0014L\u0004\nH\u0005ˇf2;1;\u0002OABAO\u0003 D ˇ\n8 M\n\b\njrUj2 \u0003 1\nˇ \u0016qU\n\t\nC M\u0003;\nand hence by (7.36) we ﬁnally obtain\n\u0003.q/ D 1\n8\n\u0004\n\u0016qU \u0003 ˇjrUj2\u0005\n;\nwhere it is easily veriﬁed that h\u0003i D 0. This gives us our leading order solution\nf2;0;\u0002OABAO\u0003 D 1\n8\n\u0004\n\u0016qU \u0003 ˇjrUj2\u0005\n:\nApplying the same procedure for the \u0002OBABO\u0003 scheme yields\nf2;0;\u0002OBABO\u0003 D 1\n8\n\u0004\nˇjrUj2 \u0003 2\u0010qU C c\n\u0005\n;\nwhere c D h\u0016Ui is a constant chosen to ensure zero average. We can relate these\nschemes to their conjugate schemes with centralized OU update via Lemma 7.1 and\nEq. (7.30), to give\nf2;0;\u0002ABOBA\u0003 D 1\n8\n\u0004\nˇpTr2U.q/p \u0003 2\u0016qU C c\n\u0005\n;\nf2;0;\u0002BAOAB\u0003 D 1\n8\n\u0004\n\u0016U \u0003 ˇpTr2U.q/p\n\u0005\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。"
  ],
  "issues": [
    "已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.firstReciprocalCorrection",
  "lean_declarations": [
    "MD.Ch07.firstReciprocalCorrection",
    "MD.Ch07.momentumAverage",
    "MD.Ch07.momentumAveragePrinted_corrected",
    "MD.Ch07.momentumAveragePrinted",
    "MD.Ch07.firstReciprocalCorrection_pde"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted_corrected (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  momentumAverage β f q

def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*gibbsWeight (fun _ ↦ 1) U β (q,p)
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry
```

## MD-7.9.2-OverdampedSolvabilityOperators
```json
{
  "source_id": "MD-7.9.2-OverdampedSolvabilityOperators",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.2",
  "printed_page": "304",
  "pdf_page": "325",
  "statement_latex": "We abbreviate\n\\[\\mathcal M\\psi(q)=\\overline\\pi\\mathcal L_H^\\dagger\\mathcal L_A^\\dagger\\psi(q)\n=\\overline\\pi((\\mathcal L_A^\\dagger)^2+\\mathcal L_B^\\dagger\\mathcal L_A^\\dagger)\\psi(q)\n=\\beta^{-1}\\Delta_q\\psi(q)-\\nabla U\\cdot\\nabla_q\\psi(q),\\]\n\\[\\mathcal N\\psi(q)=\\overline\\pi\\mathcal L_H^\\dagger(\\mathcal L_A^\\dagger)^3\\psi(q)\n=\\overline\\pi((\\mathcal L_A^\\dagger)^4+\\mathcal L_B^\\dagger(\\mathcal L_A^\\dagger)^3)\\psi(q)\n=\\tfrac3\\beta\\mathcal M(\\Delta_q\\psi(q)).\\]\nThus we have\n\\[\\overline\\pi\\mathcal L_H^\\dagger\\rho_\\beta f_{2,1,[OABAO]}=\\tfrac\\beta8\\mathcal M(|\\nabla U|^2-\\beta^{-1}\\Delta_qU)+\\mathcal M\\nu,\\]\nand hence by (7.36) we finally obtain $\\nu(q)=\\tfrac18(\\Delta_qU-\\beta|\\nabla U|^2)$, where $\\langle\\nu\\rangle=0$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 325,
      "printed_page": 304,
      "text": "304\n7\nNumerical Methods for Stochastic Molecular Dynamics\nHence by rewriting the correction function as\nf2;1;\u0002OABAO\u0003 D ˇ\n24\n\b\n3L\u0004\nAjrUj2 \u0003 1\n3\n\u0006\nL\u0004\nA\n\u00073\nU \u0003 2\nˇ L\u0004\nA\u0016qU\n\t\nC L\u0004\nA\u0003 \u0003 \u0006;\nwe have\nN\u0014L\u0004\nHf2;1;\u0002OABAO\u0003 D ˇ\n24\n\b\n3MjrUj2 \u0003 1\n3NU \u0003 2\nˇ M\u0016qU\n\t\nC M\u0003;\nwhere we abbreviate\nM .q/D N\u0014L\u0004\nHL\u0004\nA .q/D N\u0014\n\u0006\n.L\u0004\nA/2 C L\u0004\nBL\u0004\nA\n\u0007\n .q/ D 1\nˇ \u0016q .q/ \u0003 rU \u0002 rq .q/;\nN .q/ D N\u0014L\u0004\nH.L\u0004\nA/3 .q/ D N\u0014\n\u0006\n.L\u0004\nA/4 C L\u0004\nB.L\u0004\nA/3\u0007\n .q/ D 3\nˇ M\n\u0004\n\u0016q .q/\n\u0005\n:\nThus we have\nN\u0014L\u0004\nH\u0005ˇf2;1;\u0002OABAO\u0003 D ˇ\n8 M\n\b\njrUj2 \u0003 1\nˇ \u0016qU\n\t\nC M\u0003;\nand hence by (7.36) we ﬁnally obtain\n\u0003.q/ D 1\n8\n\u0004\n\u0016qU \u0003 ˇjrUj2\u0005\n;\nwhere it is easily veriﬁed that h\u0003i D 0. This gives us our leading order solution\nf2;0;\u0002OABAO\u0003 D 1\n8\n\u0004\n\u0016qU \u0003 ˇjrUj2\u0005\n:\nApplying the same procedure for the \u0002OBABO\u0003 scheme yields\nf2;0;\u0002OBABO\u0003 D 1\n8\n\u0004\nˇjrUj2 \u0003 2\u0010qU C c\n\u0005\n;\nwhere c D h\u0016Ui is a constant chosen to ensure zero average. We can relate these\nschemes to their conjugate schemes with centralized OU update via Lemma 7.1 and\nEq. (7.30), to give\nf2;0;\u0002ABOBA\u0003 D 1\n8\n\u0004\nˇpTr2U.q/p \u0003 2\u0016qU C c\n\u0005\n;\nf2;0;\u0002BAOAB\u0003 D 1\n8\n\u0004\n\u0016U \u0003 ˇpTr2U.q/p\n\u0005\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。",
    "只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。"
  ],
  "issues": [],
  "statement_scope": "M,N及ν全部显式公式和ν代数识别；平均算符等价与可解性未证明。",
  "lean_decl": "MD.Ch07.overdampedM",
  "lean_declarations": [
    "MD.Ch07.overdampedM",
    "MD.Ch07.overdampedN",
    "MD.Ch07.highFrictionOABAO",
    "MD.Ch07.overdampedSolvability_choice"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def overdampedM (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  β⁻¹*laplacian ψ q-(∑ i, gradient U q i*gradient ψ q i)
def overdampedN (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  3/β*overdampedM U (laplacian ψ) β q
def highFrictionOABAO (U : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  (laplacian U q-β*gradNormSq U q)/8
theorem overdampedSolvability_choice (U : V n → ℝ) (β : ℝ) (hβ : β ≠ 0) :
    ∀ q, highFrictionOABAO U β q =
      -β/8*(gradNormSq U q-β⁻¹*laplacian U q) := by
  intro q
  dsimp [highFrictionOABAO]
  field_simp
  <;> ring
```

## MD-7.9.2-HighFrictionCorrectionTable
```json
{
  "source_id": "MD-7.9.2-HighFrictionCorrectionTable",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.2",
  "printed_page": "304–305",
  "pdf_page": "325–326",
  "statement_latex": "\\[f_{2,0,[OABAO]}=\\tfrac18(\\Delta_qU-\\beta|\\nabla U|^2),\\]\n\\[f_{2,0,[OBABO]}=\\tfrac18(\\beta|\\nabla U|^2-2\\Delta_qU+c),\\]\nwhere $c=\\langle\\Delta U\\rangle$ is a constant chosen to ensure zero average.\n\\[f_{2,0,[ABOBA]}=\\tfrac18(\\beta p^T\\nabla^2U(q)p-2\\Delta_qU+c),\\]\n\\[f_{2,0,[BAOAB]}=\\tfrac18(\\Delta U-\\beta p^T\\nabla^2U(q)p).\\]\n\\[\\langle\\vartheta\\rangle_h=\\langle\\vartheta\\rangle+h^2\\langle\\vartheta f_{2,0}\\rangle+O(\\epsilon h^2+h^4).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 325,
      "printed_page": 304,
      "text": "304\n7\nNumerical Methods for Stochastic Molecular Dynamics\nHence by rewriting the correction function as\nf2;1;\u0002OABAO\u0003 D ˇ\n24\n\b\n3L\u0004\nAjrUj2 \u0003 1\n3\n\u0006\nL\u0004\nA\n\u00073\nU \u0003 2\nˇ L\u0004\nA\u0016qU\n\t\nC L\u0004\nA\u0003 \u0003 \u0006;\nwe have\nN\u0014L\u0004\nHf2;1;\u0002OABAO\u0003 D ˇ\n24\n\b\n3MjrUj2 \u0003 1\n3NU \u0003 2\nˇ M\u0016qU\n\t\nC M\u0003;\nwhere we abbreviate\nM .q/D N\u0014L\u0004\nHL\u0004\nA .q/D N\u0014\n\u0006\n.L\u0004\nA/2 C L\u0004\nBL\u0004\nA\n\u0007\n .q/ D 1\nˇ \u0016q .q/ \u0003 rU \u0002 rq .q/;\nN .q/ D N\u0014L\u0004\nH.L\u0004\nA/3 .q/ D N\u0014\n\u0006\n.L\u0004\nA/4 C L\u0004\nB.L\u0004\nA/3\u0007\n .q/ D 3\nˇ M\n\u0004\n\u0016q .q/\n\u0005\n:\nThus we have\nN\u0014L\u0004\nH\u0005ˇf2;1;\u0002OABAO\u0003 D ˇ\n8 M\n\b\njrUj2 \u0003 1\nˇ \u0016qU\n\t\nC M\u0003;\nand hence by (7.36) we ﬁnally obtain\n\u0003.q/ D 1\n8\n\u0004\n\u0016qU \u0003 ˇjrUj2\u0005\n;\nwhere it is easily veriﬁed that h\u0003i D 0. This gives us our leading order solution\nf2;0;\u0002OABAO\u0003 D 1\n8\n\u0004\n\u0016qU \u0003 ˇjrUj2\u0005\n:\nApplying the same procedure for the \u0002OBABO\u0003 scheme yields\nf2;0;\u0002OBABO\u0003 D 1\n8\n\u0004\nˇjrUj2 \u0003 2\u0010qU C c\n\u0005\n;\nwhere c D h\u0016Ui is a constant chosen to ensure zero average. We can relate these\nschemes to their conjugate schemes with centralized OU update via Lemma 7.1 and\nEq. (7.30), to give\nf2;0;\u0002ABOBA\u0003 D 1\n8\n\u0004\nˇpTr2U.q/p \u0003 2\u0016qU C c\n\u0005\n;\nf2;0;\u0002BAOAB\u0003 D 1\n8\n\u0004\n\u0016U \u0003 ˇpTr2U.q/p\n\u0005\n:\n"
    },
    {
      "pdf_page": 326,
      "printed_page": 305,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n305\nOwing to our ansatz, we would expect that the computed average of some\nobservable has behavior like\nh#ih D h#i C h2h#f2;0i C O.\"h2 C h4/:\nAt sufﬁciently small values of \" (and hence, large values of the friction coefﬁcient\n\n) we would expect that the O.h2/ remainder will not be visible to us in our\nexperiments, and we will be able to correct our average to O.h4/. The symmetric\ndiscretization schemes we have considered here will all be consistent in the\noverdamped (\n ! 1) limit, and we would expect the correction function for the\ncorresponding limiting schemes to be given by f2;0.\n7.9.3\nSuperconvergence of the \u0002BAOAB\u0003 Scheme\nIn the regime of sufﬁciently large \n and small h, our doubly-asymptotic ansatz for\nthe leading order correction to a function #.q; p/ is\nh#i D h#ih \u0003 h2h#f2;0i C O\n\bh2\n\n C h4\n\t\n;\n(7.37)\nwhere f2;0 is method-dependent.The \u0002BAOAB\u0003 scheme has leading order correction\nf2;0;\u0002BAOAB\u0003.q; p/ D 1\n8\n\u0004\n\u0016U \u0003 ˇpTr2U.q/p\n\u0005\n;\nwhich has the interesting property that its marginal average with respect to\nmomentum is zero:\nN\u0014f2;0;\u0002BAOAB\u0003 D\nZ\nP\nf2;0;\u0002BAOAB\u0003.q; p/\u0005ˇ.q; p/d!p D 0:\nThis is a very favorable quality for conﬁgurational sampling, where we consider\naverages of functions solely of position, as we can split up the integral such that\nh#.q/f2;0;\u0002BAOAB\u0003i D\nZ\nD\n#.q/f2;0;\u0002BAOAB\u0003\u0005ˇd!;\nD\nZ\nQ\n#.q/\nZ\nP\nf2;0;\u0002BAOAB\u0003\u0005ˇd!pd!q;\nD 0:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。",
    "候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.highFrictionCorrection",
  "lean_declarations": [
    "MD.Ch07.highFrictionCorrection",
    "MD.Ch07.doublyAsymptoticAverage",
    "MD.Ch07.highFrictionCorrection_conjugacy"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def highFrictionCorrection (s : Fin 4) (U : V n → ℝ) (β c : ℝ) (x : Phase n) : ℝ :=
  if s = 0 then highFrictionOABAO U β x.1
  else if s = 1 then (β*gradNormSq U x.1-2*laplacian U x.1+c)/8
  else if s = 2 then (β*hessianQuadratic U x-2*laplacian U x.1+c)/8
  else (laplacian U x.1-β*hessianQuadratic U x)/8
def doublyAsymptoticAverage (A : ℝ → ℝ → ℝ) (exact correction : ℝ) : Prop :=
  Asymptotics.IsBigO positivePairLimit
    (fun z ↦ A z.1 z.2-exact-z.2^2*correction) (fun z ↦ z.1*z.2^2+z.2^4)
theorem highFrictionCorrection_conjugacy (U : V n → ℝ) (β c : ℝ) :
    conjugateCorrections U β (highFrictionCorrection 2 U β c) (highFrictionCorrection 1 U β c)
      (highFrictionCorrection 3 U β c) (highFrictionCorrection 0 U β c) := by
  constructor <;> funext x <;>
    norm_num [conjugateCorrections,highFrictionCorrection,highFrictionOABAO,conjugateCorrectionChange]
    <;> ring
```

## MD-7.9.3-BAOABMarginalCancellation
```json
{
  "source_id": "MD-7.9.3-BAOABMarginalCancellation",
  "kind": "unnumbered_claim",
  "label": "(7.37)",
  "section": "7.9.3",
  "printed_page": "305",
  "pdf_page": "326",
  "statement_latex": "\\[\\langle\\vartheta\\rangle=\\langle\\vartheta\\rangle_h-h^2\\langle\\vartheta f_{2,0}\\rangle+O(h^2/\\gamma+h^4).\\tag{7.37}\\]\nThe $[BAOAB]$ scheme has leading order correction\n\\[f_{2,0,[BAOAB]}(q,p)=\\tfrac18(\\Delta U-\\beta p^T\\nabla^2U(q)p),\\]\nwhich has the interesting property that its marginal average with respect to momentum is zero:\n\\[\\overline\\pi f_{2,0,[BAOAB]}=\\int_{\\mathcal P}f_{2,0,[BAOAB]}(q,p)\\rho_\\beta(q,p)d\\omega_p=0.\\]\n\\[\\langle\\vartheta(q)f_{2,0,[BAOAB]}\\rangle=\\int_{\\mathcal Q}\\vartheta(q)\\int_{\\mathcal P}f_{2,0,[BAOAB]}\\rho_\\beta d\\omega_p d\\omega_q=0.\\]",
  "proof_latex": null,
  "proof_outline": "Integrate first over the Gaussian momenta; the quadratic Gaussian moment contracts the Hessian to β⁻¹ΔU. Then use Fubini.",
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 326,
      "printed_page": 305,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n305\nOwing to our ansatz, we would expect that the computed average of some\nobservable has behavior like\nh#ih D h#i C h2h#f2;0i C O.\"h2 C h4/:\nAt sufﬁciently small values of \" (and hence, large values of the friction coefﬁcient\n\n) we would expect that the O.h2/ remainder will not be visible to us in our\nexperiments, and we will be able to correct our average to O.h4/. The symmetric\ndiscretization schemes we have considered here will all be consistent in the\noverdamped (\n ! 1) limit, and we would expect the correction function for the\ncorresponding limiting schemes to be given by f2;0.\n7.9.3\nSuperconvergence of the \u0002BAOAB\u0003 Scheme\nIn the regime of sufﬁciently large \n and small h, our doubly-asymptotic ansatz for\nthe leading order correction to a function #.q; p/ is\nh#i D h#ih \u0003 h2h#f2;0i C O\n\bh2\n\n C h4\n\t\n;\n(7.37)\nwhere f2;0 is method-dependent.The \u0002BAOAB\u0003 scheme has leading order correction\nf2;0;\u0002BAOAB\u0003.q; p/ D 1\n8\n\u0004\n\u0016U \u0003 ˇpTr2U.q/p\n\u0005\n;\nwhich has the interesting property that its marginal average with respect to\nmomentum is zero:\nN\u0014f2;0;\u0002BAOAB\u0003 D\nZ\nP\nf2;0;\u0002BAOAB\u0003.q; p/\u0005ˇ.q; p/d!p D 0:\nThis is a very favorable quality for conﬁgurational sampling, where we consider\naverages of functions solely of position, as we can split up the integral such that\nh#.q/f2;0;\u0002BAOAB\u0003i D\nZ\nD\n#.q/f2;0;\u0002BAOAB\u0003\u0005ˇd!;\nD\nZ\nQ\n#.q/\nZ\nP\nf2;0;\u0002BAOAB\u0003\u0005ˇd!pd!q;\nD 0:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.baoabMarginalCancellation",
  "lean_declarations": [
    "MD.Ch07.baoabMarginalCancellation",
    "MD.Ch07.baoabConfigurationalCancellation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```
