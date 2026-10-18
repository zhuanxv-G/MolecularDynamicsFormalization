# BATCH10 第8章原文与陈述审校

## MD-8.6.2-SINBracketRank
```json
{
  "source_id": "MD-8.6.2-SINBracketRank",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.2",
  "printed_page": "366–368",
  "pdf_page": "387–389",
  "statement_latex": "The fields f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]] span the three-dimensional tangent space of the isokinetic cylinder except on M₀.",
  "statement_verbatim": "366\n8\nExtended Variable Methods\n8.6.2\nErgodicity\nFollowing the discussion in [220], let us show ergodicity for the stochastic isokinetic\nharmonic oscillator:\ndq D pdt\ndp D Œ\u0003q \u0003 \u0013p\tdt\nd\u00121 D Œ\u0003\u0013\u00121 \u0003 \u00122\u00121\tdt\nd\u00122 D Œ\u00122\n1 \u0003 kBT \u0003 \n\u00122\tdt C \u0007dW\n(8.45)\nwith \u0013 D \u0002qp\u0002\u00122\u00122\n1=2\np2C\u00122\n1=2\nand \u0007 D p2\nkBT. We have taken the coupling coefﬁcients\n\u00061; \u00062 both one for simplicity as their particular values (as long as nonzero) have\nno bearing on the ergodic property.\nThe constraint, p2 C \u00122\n1=2 D const, deﬁnes a three-dimensional manifold M, a\ngeneralized cylinder. \u00121 D 0 is an invariant manifold of the isokinetic equations,\nwith solutions therefore conﬁned for all time to one or the other half-space (\u00121 < 0\nor \u00121 > 0). It is enough to sample one or the other of the two half spaces. To show\nthat the solutions do so, we need to demonstrate that an appropriate Hörmander\ncondition holds. Deﬁne f and g as the vector ﬁelds\nf D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00122\u00121/@\u00121 C\n\n.\u00122\n1 \u0003 kBT/ \u0003 \n\u00122\n\u000b\n@\u00122;\n(8.46)\nand\ng D \u0007@\u00122:\n(8.47)\nWe will show that the dimension of the ideal spanned by the iterated commutators\nof the vector ﬁelds f and g is three, i.e. that it spans the tangent space to M at any\npoint. For this purpose, we use the collection of vectors\nf; g; Œf; g\t; Œf; Œf; g\t\t; Œf; Œf; Œf; g\t\t\t:\nWe will see that these provide a basis at every point excluding the one-dimensional\nset deﬁned by the union M0 of the two lines `C, `\u0002 deﬁned by\nq D 0;\np D 0;\n\u00121 D ˙\nq\n2\u0006\u00021\n1 kBT;\nand arbitrary \u00122. [Note: the choice \u00121 D ˙\nq\n2\u0006\u00021\n1 kBT is made so that the isokinetic\nconstraint is satisﬁed. In [220] this value was incorrectly deﬁned.] The vectors f and\ng are linearly independent except on M0.\n\n8.6\nIsokinetic Methods and Integration with Very Large Timestep\n367\nThe proof requires calculation of the vector ﬁelds\nu0 D ˘ f;\nu1 D ˘ Œf; g\t ;\nu2 D ˘ Œf; Œf; g\t\t;\nu3 D ˘ Œf; Œf; Œf; g\t\t\t;\nwhere ˘ is the projector onto the ﬁrst three components. Because g D \u0007e4,\nit is enough to show that any pair from among these four vectors are linearly\nindependent, except possibly on M0. Note that projection can only be performed\nafter the full calculation of the relevant commutator. Because the commutators\nquickly become quite messy, we used a symbolic computing package to assist in\nthese calculations.\nThe ﬁrst two vectors are:\nu0 D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00121\u00122/@\u00121;\n(8.48)\nand\nu1 D \u0007p @\u0013\n@\u00122\n@p C \u00121\n\b\n1 C @\u0013\n@\u00122\n\t\n@\u00121:\n(8.49)\nAfter expanding the derivatives of \u0013 we have\nu1 D p@q C \u00122\n1\n\b\u0003q C p\u00122\nD\n\t\n@p \u0003 2\u00121p\n\b\u0003q C p\u00122\nD\n\t\n@\u00121;\n(8.50)\nand\nu2 D \u0003\u0007.\u00122\n1p=D/@p C .2\u0007\u00121p2=D/@\u00121;\n(8.51)\nwhere D D 2p2 C \u00122\n1.\nIf q ¤ 0 and p ¤ 0, then clearly u1 and u2 are linearly independent. However, if\np D 0 then u2 D 0. We proceed to compute the commutator Œf; Œf; g\t\t. Projecting to\nthe ﬁrst three components results in\nu2 D \u0007\n\b\u00122\n1p\nD\n\t\n@q \u0003 \u0007\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@p C 2\u0007\u00121p\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@\u00121:\n(8.52)\nAgain, we substitute p D 0 and ﬁnd that\nu2jpD0 D .\u0007\u00122\n1q=D2/@p:\n(8.53)\nUnfortunately, this is parallel to u1 (for p D 0), and hence yet one more commutator\nis required in this case.\n\n368\n8\nExtended Variable Methods\nWe calculate Œf; Œf; Œf; g\t\t\t and project onto the space spanned by the ﬁrst three\ncomponents to ﬁnd\nu3 D \u0007\n\b2\np3 \u0003 4p3\u00122 C 4p2q C \u00122\n1p\u00122 C \n\u00122\n1p \u0003 2\u00122\n1q\nD2\n\t\n@q\n\u0003 \u0007\u00122\n1\n\u0006 \u000f\nD3\n\u0007\n@p C 2\u0007\u00121p\n\u0006 \u000f\nD3\n\u0007\n@\u00121:\n(8.54)\nwith\n\u000f D 4p5\n2 \u0003 8p5\u00122\n1 \u0003 4\u00122\n1p3 C 4p3\n2\u00122\n1 \u0003 4p3\u00124\n1\n\u0003 2\n\u00122\n1p2q C 4p2q\u00122\u00122\n1 \u0003 4\u00122\n1q2p \u0003 2\u00124\n1p C p\n2\u00124\n1 \u0003 q\n\u00124\n1 C \u00124\n1\u00122q:\n(8.55)\nAlong p D 0, u3 becomes\nu3jpD0 D \u00032\u0007q@q \u0003 \u0007\n\b\u0003q\n\u00124\n1 C \u00124\n1\u00122q\n\u00124\n1\n\t\n@p\nD \u00032\u0007q@q \u0003 \u0007q.\u0003\n C \u00122/@p:\n(8.56)\nTogether with u0 we obtain a linearly independent set as long as q ¤ 0.\nIf p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly\nindependent. If q ¤ 0 then u3 and u0 are linearly independent. From these we\nestablish that the Hörmander condition holds everywhere except on a space of co-\ndimension 2 (that is except on the one-dimensional set M0).\nIn this case, it is possible to complete the proof by introducing a Lyapunov\nfunction \b to demonstrate the necessary contractivity in the \u00122 direction. The\ngenerator of this system is\nLisok D p @\n@q C\n\nF \u0003 .p2=\u0017/F\n\u000b @\n@p \u0003 p\u00121F\n\u0017\n@\n@\u00121\nC LN C LO\nwith \u0017 D p2 C \u00122\n1=2,\nLN D 1\n2\n\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC Œ\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nand\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 387,
      "printed_page": 366,
      "text": "366\n8\nExtended Variable Methods\n8.6.2\nErgodicity\nFollowing the discussion in [220], let us show ergodicity for the stochastic isokinetic\nharmonic oscillator:\ndq D pdt\ndp D Œ\u0003q \u0003 \u0013p\tdt\nd\u00121 D Œ\u0003\u0013\u00121 \u0003 \u00122\u00121\tdt\nd\u00122 D Œ\u00122\n1 \u0003 kBT \u0003 \n\u00122\tdt C \u0007dW\n(8.45)\nwith \u0013 D \u0002qp\u0002\u00122\u00122\n1=2\np2C\u00122\n1=2\nand \u0007 D p2\nkBT. We have taken the coupling coefﬁcients\n\u00061; \u00062 both one for simplicity as their particular values (as long as nonzero) have\nno bearing on the ergodic property.\nThe constraint, p2 C \u00122\n1=2 D const, deﬁnes a three-dimensional manifold M, a\ngeneralized cylinder. \u00121 D 0 is an invariant manifold of the isokinetic equations,\nwith solutions therefore conﬁned for all time to one or the other half-space (\u00121 < 0\nor \u00121 > 0). It is enough to sample one or the other of the two half spaces. To show\nthat the solutions do so, we need to demonstrate that an appropriate Hörmander\ncondition holds. Deﬁne f and g as the vector ﬁelds\nf D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00122\u00121/@\u00121 C\n\n.\u00122\n1 \u0003 kBT/ \u0003 \n\u00122\n\u000b\n@\u00122;\n(8.46)\nand\ng D \u0007@\u00122:\n(8.47)\nWe will show that the dimension of the ideal spanned by the iterated commutators\nof the vector ﬁelds f and g is three, i.e. that it spans the tangent space to M at any\npoint. For this purpose, we use the collection of vectors\nf; g; Œf; g\t; Œf; Œf; g\t\t; Œf; Œf; Œf; g\t\t\t:\nWe will see that these provide a basis at every point excluding the one-dimensional\nset deﬁned by the union M0 of the two lines `C, `\u0002 deﬁned by\nq D 0;\np D 0;\n\u00121 D ˙\nq\n2\u0006\u00021\n1 kBT;\nand arbitrary \u00122. [Note: the choice \u00121 D ˙\nq\n2\u0006\u00021\n1 kBT is made so that the isokinetic\nconstraint is satisﬁed. In [220] this value was incorrectly deﬁned.] The vectors f and\ng are linearly independent except on M0.\n"
    },
    {
      "pdf_page": 388,
      "printed_page": 367,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n367\nThe proof requires calculation of the vector ﬁelds\nu0 D ˘ f;\nu1 D ˘ Œf; g\t ;\nu2 D ˘ Œf; Œf; g\t\t;\nu3 D ˘ Œf; Œf; Œf; g\t\t\t;\nwhere ˘ is the projector onto the ﬁrst three components. Because g D \u0007e4,\nit is enough to show that any pair from among these four vectors are linearly\nindependent, except possibly on M0. Note that projection can only be performed\nafter the full calculation of the relevant commutator. Because the commutators\nquickly become quite messy, we used a symbolic computing package to assist in\nthese calculations.\nThe ﬁrst two vectors are:\nu0 D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00121\u00122/@\u00121;\n(8.48)\nand\nu1 D \u0007p @\u0013\n@\u00122\n@p C \u00121\n\b\n1 C @\u0013\n@\u00122\n\t\n@\u00121:\n(8.49)\nAfter expanding the derivatives of \u0013 we have\nu1 D p@q C \u00122\n1\n\b\u0003q C p\u00122\nD\n\t\n@p \u0003 2\u00121p\n\b\u0003q C p\u00122\nD\n\t\n@\u00121;\n(8.50)\nand\nu2 D \u0003\u0007.\u00122\n1p=D/@p C .2\u0007\u00121p2=D/@\u00121;\n(8.51)\nwhere D D 2p2 C \u00122\n1.\nIf q ¤ 0 and p ¤ 0, then clearly u1 and u2 are linearly independent. However, if\np D 0 then u2 D 0. We proceed to compute the commutator Œf; Œf; g\t\t. Projecting to\nthe ﬁrst three components results in\nu2 D \u0007\n\b\u00122\n1p\nD\n\t\n@q \u0003 \u0007\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@p C 2\u0007\u00121p\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@\u00121:\n(8.52)\nAgain, we substitute p D 0 and ﬁnd that\nu2jpD0 D .\u0007\u00122\n1q=D2/@p:\n(8.53)\nUnfortunately, this is parallel to u1 (for p D 0), and hence yet one more commutator\nis required in this case.\n"
    },
    {
      "pdf_page": 389,
      "printed_page": 368,
      "text": "368\n8\nExtended Variable Methods\nWe calculate Œf; Œf; Œf; g\t\t\t and project onto the space spanned by the ﬁrst three\ncomponents to ﬁnd\nu3 D \u0007\n\b2\np3 \u0003 4p3\u00122 C 4p2q C \u00122\n1p\u00122 C \n\u00122\n1p \u0003 2\u00122\n1q\nD2\n\t\n@q\n\u0003 \u0007\u00122\n1\n\u0006 \u000f\nD3\n\u0007\n@p C 2\u0007\u00121p\n\u0006 \u000f\nD3\n\u0007\n@\u00121:\n(8.54)\nwith\n\u000f D 4p5\n2 \u0003 8p5\u00122\n1 \u0003 4\u00122\n1p3 C 4p3\n2\u00122\n1 \u0003 4p3\u00124\n1\n\u0003 2\n\u00122\n1p2q C 4p2q\u00122\u00122\n1 \u0003 4\u00122\n1q2p \u0003 2\u00124\n1p C p\n2\u00124\n1 \u0003 q\n\u00124\n1 C \u00124\n1\u00122q:\n(8.55)\nAlong p D 0, u3 becomes\nu3jpD0 D \u00032\u0007q@q \u0003 \u0007\n\b\u0003q\n\u00124\n1 C \u00124\n1\u00122q\n\u00124\n1\n\t\n@p\nD \u00032\u0007q@q \u0003 \u0007q.\u0003\n C \u00122/@p:\n(8.56)\nTogether with u0 we obtain a linearly independent set as long as q ¤ 0.\nIf p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly\nindependent. If q ¤ 0 then u3 and u0 are linearly independent. From these we\nestablish that the Hörmander condition holds everywhere except on a space of co-\ndimension 2 (that is except on the one-dimensional set M0).\nIn this case, it is possible to complete the proof by introducing a Lyapunov\nfunction \b to demonstrate the necessary contractivity in the \u00122 direction. The\ngenerator of this system is\nLisok D p @\n@q C\n\nF \u0003 .p2=\u0017/F\n\u000b @\n@p \u0003 p\u00121F\n\u0017\n@\n@\u00121\nC LN C LO\nwith \u0017 D p2 C \u00122\n1=2,\nLN D 1\n2\n\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC Œ\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nand\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "θ,γ正，ξ₁≠0且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。"
  ],
  "issues": [],
  "statement_scope": "例外直线外的有限括号张成目标；非完整遍历性定理。",
  "lean_decl": "MD.Ch08.sinBracket_tangentSpan",
  "lean_declarations": [
    "MD.Ch08.sinBracket_tangentSpan"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem sinBracket_tangentSpan (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (z : Vec 4) (hz : sinConstraint 1 z=θ) (hξ : z 2 ≠ 0)
    (hout : z ∉ sinExceptional θ) :
    Submodule.span ℝ ({sinHarmonicG θ γ} ∪
      Set.range (fun j : Fin 4 ↦ sinBracket θ γ j z)) =
      LinearMap.ker (fderiv ℝ (sinConstraint 1) z).toLinearMap := by
  sorry
```

## MD-8.6.2-SINLyapunov
```json
{
  "source_id": "MD-8.6.2-SINLyapunov",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.2",
  "printed_page": "368–369",
  "pdf_page": "389–390",
  "statement_latex": "For φ=ξ₂²/2, L_isok φ=(ξ₁²-β⁻¹)ξ₂-γξ₂²+σ²/2, and the isokinetic constraint bounds ξ₁. The negative tail drift supports the ergodicity argument with further assumptions.",
  "statement_verbatim": "368\n8\nExtended Variable Methods\nWe calculate Œf; Œf; Œf; g\t\t\t and project onto the space spanned by the ﬁrst three\ncomponents to ﬁnd\nu3 D \u0007\n\b2\np3 \u0003 4p3\u00122 C 4p2q C \u00122\n1p\u00122 C \n\u00122\n1p \u0003 2\u00122\n1q\nD2\n\t\n@q\n\u0003 \u0007\u00122\n1\n\u0006 \u000f\nD3\n\u0007\n@p C 2\u0007\u00121p\n\u0006 \u000f\nD3\n\u0007\n@\u00121:\n(8.54)\nwith\n\u000f D 4p5\n2 \u0003 8p5\u00122\n1 \u0003 4\u00122\n1p3 C 4p3\n2\u00122\n1 \u0003 4p3\u00124\n1\n\u0003 2\n\u00122\n1p2q C 4p2q\u00122\u00122\n1 \u0003 4\u00122\n1q2p \u0003 2\u00124\n1p C p\n2\u00124\n1 \u0003 q\n\u00124\n1 C \u00124\n1\u00122q:\n(8.55)\nAlong p D 0, u3 becomes\nu3jpD0 D \u00032\u0007q@q \u0003 \u0007\n\b\u0003q\n\u00124\n1 C \u00124\n1\u00122q\n\u00124\n1\n\t\n@p\nD \u00032\u0007q@q \u0003 \u0007q.\u0003\n C \u00122/@p:\n(8.56)\nTogether with u0 we obtain a linearly independent set as long as q ¤ 0.\nIf p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly\nindependent. If q ¤ 0 then u3 and u0 are linearly independent. From these we\nestablish that the Hörmander condition holds everywhere except on a space of co-\ndimension 2 (that is except on the one-dimensional set M0).\nIn this case, it is possible to complete the proof by introducing a Lyapunov\nfunction \b to demonstrate the necessary contractivity in the \u00122 direction. The\ngenerator of this system is\nLisok D p @\n@q C\n\nF \u0003 .p2=\u0017/F\n\u000b @\n@p \u0003 p\u00121F\n\u0017\n@\n@\u00121\nC LN C LO\nwith \u0017 D p2 C \u00122\n1=2,\nLN D 1\n2\n\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC Œ\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nand\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n\n8.6\nIsokinetic Methods and Integration with Very Large Timestep\n369\nLet us apply the operator Lisok to \b\ndef\nD \u00122\n2=2. As this is only a function of \u00122, many\nterms vanish and we are left with\nLisok\b D LN\b C LO\b;\nLN\b D Œ\u00122\n1 \u0003 ˇ\u00021\t\u00122;\nand\nLO\b D \u0003\n\u00122\n2 C \u00072\n2 :\nBecause \u00121 is uniformly bounded due to the isokinetic constraint, we have\nLisok\b \t \u0003\n\u00122\n2 C K\u00122 C \u00072\n2 :\nFor j\u00122j sufﬁciently large this term is negative. This contractivity, together with\nassumptions of boundedness of conﬁgurations (the use of periodic boundary\nconditions) and the isokinetic constraints on p and \u00121, as well as the existence\nof a candidate measure which is positive on open sets, will ultimately ensure the\nergodicity of the system, relying on arguments similar to those in [256, 257].\n8.6.3\nMultiple Timestepping Using the Stochastic Isokinetic\nFormulation\nThe numerical integration of the equations of the stochastic isokinetic system can be\nperformed using splitting, in a style that should by now be familiar, with the proviso\nthat the isokinetic condition itself should be satisﬁed exactly (i.e. to rounding error).\nMolecular sampling using Langevin dynamics and other methods involves\nintegration over the inﬁnite cylinder TNc\u0004RNc. The power of the isokinetic method is\nthat it allows us to reformulate the conﬁgurational sampling problem as integration\non a compact manifold. The fact that we also slightly extend the domain by\nintroducing auxiliary variables is more than offset by the stabilizing effect of the\nisokinetic constraints. One approach would be to introduce an isokinetic constraint\non the entire system, but in practice it is found that no great crime is committed\nin conﬁgurational sampling by constraining each degree of freedom (together with\nassociated auxiliary variables).\nTo develop a multiple timestepping method, we begin by supposing that the\npotential energy function and therefore the force can be decomposed into fast and\nslow terms, thus U.q/ D US.q/ C UF.q/ and the force acting on the jth degree\nof freedom is Fj D FS\nj C FF\nj . Because the SIN(R) method is based on a non-\nHamiltonian formulation, we do not obtain a symplectic integrator (in the absence\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 389,
      "printed_page": 368,
      "text": "368\n8\nExtended Variable Methods\nWe calculate Œf; Œf; Œf; g\t\t\t and project onto the space spanned by the ﬁrst three\ncomponents to ﬁnd\nu3 D \u0007\n\b2\np3 \u0003 4p3\u00122 C 4p2q C \u00122\n1p\u00122 C \n\u00122\n1p \u0003 2\u00122\n1q\nD2\n\t\n@q\n\u0003 \u0007\u00122\n1\n\u0006 \u000f\nD3\n\u0007\n@p C 2\u0007\u00121p\n\u0006 \u000f\nD3\n\u0007\n@\u00121:\n(8.54)\nwith\n\u000f D 4p5\n2 \u0003 8p5\u00122\n1 \u0003 4\u00122\n1p3 C 4p3\n2\u00122\n1 \u0003 4p3\u00124\n1\n\u0003 2\n\u00122\n1p2q C 4p2q\u00122\u00122\n1 \u0003 4\u00122\n1q2p \u0003 2\u00124\n1p C p\n2\u00124\n1 \u0003 q\n\u00124\n1 C \u00124\n1\u00122q:\n(8.55)\nAlong p D 0, u3 becomes\nu3jpD0 D \u00032\u0007q@q \u0003 \u0007\n\b\u0003q\n\u00124\n1 C \u00124\n1\u00122q\n\u00124\n1\n\t\n@p\nD \u00032\u0007q@q \u0003 \u0007q.\u0003\n C \u00122/@p:\n(8.56)\nTogether with u0 we obtain a linearly independent set as long as q ¤ 0.\nIf p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly\nindependent. If q ¤ 0 then u3 and u0 are linearly independent. From these we\nestablish that the Hörmander condition holds everywhere except on a space of co-\ndimension 2 (that is except on the one-dimensional set M0).\nIn this case, it is possible to complete the proof by introducing a Lyapunov\nfunction \b to demonstrate the necessary contractivity in the \u00122 direction. The\ngenerator of this system is\nLisok D p @\n@q C\n\nF \u0003 .p2=\u0017/F\n\u000b @\n@p \u0003 p\u00121F\n\u0017\n@\n@\u00121\nC LN C LO\nwith \u0017 D p2 C \u00122\n1=2,\nLN D 1\n2\n\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC Œ\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nand\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n"
    },
    {
      "pdf_page": 390,
      "printed_page": 369,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n369\nLet us apply the operator Lisok to \b\ndef\nD \u00122\n2=2. As this is only a function of \u00122, many\nterms vanish and we are left with\nLisok\b D LN\b C LO\b;\nLN\b D Œ\u00122\n1 \u0003 ˇ\u00021\t\u00122;\nand\nLO\b D \u0003\n\u00122\n2 C \u00072\n2 :\nBecause \u00121 is uniformly bounded due to the isokinetic constraint, we have\nLisok\b \t \u0003\n\u00122\n2 C K\u00122 C \u00072\n2 :\nFor j\u00122j sufﬁciently large this term is negative. This contractivity, together with\nassumptions of boundedness of conﬁgurations (the use of periodic boundary\nconditions) and the isokinetic constraints on p and \u00121, as well as the existence\nof a candidate measure which is positive on open sets, will ultimately ensure the\nergodicity of the system, relying on arguments similar to those in [256, 257].\n8.6.3\nMultiple Timestepping Using the Stochastic Isokinetic\nFormulation\nThe numerical integration of the equations of the stochastic isokinetic system can be\nperformed using splitting, in a style that should by now be familiar, with the proviso\nthat the isokinetic condition itself should be satisﬁed exactly (i.e. to rounding error).\nMolecular sampling using Langevin dynamics and other methods involves\nintegration over the inﬁnite cylinder TNc\u0004RNc. The power of the isokinetic method is\nthat it allows us to reformulate the conﬁgurational sampling problem as integration\non a compact manifold. The fact that we also slightly extend the domain by\nintroducing auxiliary variables is more than offset by the stabilizing effect of the\nisokinetic constraints. One approach would be to introduce an isokinetic constraint\non the entire system, but in practice it is found that no great crime is committed\nin conﬁgurational sampling by constraining each degree of freedom (together with\nassociated auxiliary variables).\nTo develop a multiple timestepping method, we begin by supposing that the\npotential energy function and therefore the force can be decomposed into fast and\nslow terms, thus U.q/ D US.q/ C UF.q/ and the force acting on the jth degree\nof freedom is Fj D FS\nj C FF\nj . Because the SIN(R) method is based on a non-\nHamiltonian formulation, we do not obtain a symplectic integrator (in the absence\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "仅生成元作用和约束界；原文有符号ξ₂的Kξ₂上界须区分尾部方向，严谨负漂移应使用K|ξ₂|并要求γ>0。",
    "紧性、正密度、小集与Markov半群遍历定理均列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "真实局部生成元Lyapunov计算及热浴变量界；不包含由此推出遍历性的充分性。",
  "lean_decl": "MD.Ch08.sinGenerator",
  "lean_declarations": [
    "MD.Ch08.sinGenerator",
    "MD.Ch08.sinGenerator_lyapunov",
    "MD.Ch08.sinConstraint_bathBound"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinGenerator (θ γ : ℝ) (F : ℝ → ℝ) (f : Vec 4 → ℝ) (z : Vec 4) : ℝ :=
  additiveGenerator (sinDrift 1 1 θ γ F) (sinHarmonicG θ γ) f z
theorem sinGenerator_lyapunov (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hK : sinConstraint 1 z ≠ 0) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z =
      (z 2^2-θ)*z 3-γ*z 3^2+γ*θ := by
  sorry
theorem sinConstraint_bathBound (θ : ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    z 2^2 ≤ 2*θ := by
  dsimp [sinConstraint] at hz
  nlinarith [sq_nonneg (z 1)]
```

## MD-8.6.3-SINForceSplitting
```json
{
  "source_id": "MD-8.6.3-SINForceSplitting",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.3",
  "printed_page": "370–371",
  "pdf_page": "391–392",
  "statement_latex": "U=U_S+U_F and F=F_S+F_F. The generators split into kinetic, isokinetic fast force, isokinetic slow force, Nosé and OU terms; each preserves Λ=p²+μ₁ξ₁²/2.",
  "statement_verbatim": "370\n8\nExtended Variable Methods\nof stochastic perturbation). Unlike for r-RESPA, the splitting needs to be performed\nat the level of the differential equations. We suppress the index of the degree of\nfreedom, takes its mass to be one for simplicity of presentation, and write the\nequations of motion for the variables associated to a single physical degree of\nfreedom in the form\ndq D pdt;\ndp D Fdt \u0003\n \np.FF C FS/ \u0003 1\n2\u00061\u00122\n1\u00122\n\u0017\n!\npdt;\nd\u00121 D \u0003\n \np.FF C FS/ \u0003 1\n2\u00061\u00122\n1\u00122\n\u0017\n!\n\u00121dt \u0003 \u00122\u00121dt;\nd\u00122 D \u0006\u00021\n2 .\u00061\u00122\n1 \u0003 ˇ\u00021/dt \u0003 \n\u00122dt C \u0007dW;\nwhere \u0017 D p2 C 1\n2\u00061\u00122\n1. \u0017 D ˇ\u00021 is constant of motion.\nBecause of the form of the coupling, we observe that this vector ﬁeld can be addi-\ntively decomposed based on the various terms in the stochastic isokinetic equations,\nincluding the fast-slow splitting of the forces, into the following generators:\nKinetic part:\nLK D p @\n@q;\nisokinetic Fast force:\nLF D \nFF \u0003 .p2=\u0017/FF\u000b @\n@p \u0003 p\u00121FF\n\u0017\n@\n@\u00121\n;\nisokinetic Slow force:\nLS D\n\nFS \u0003 .p2=\u0017/FS\u000b @\n@p \u0003 p\u00121FS\n\u0017\n@\n@\u00121\n;\nisokinetic Nosé terms:\nLN D 1\n2\n\u00061\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00061\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC \u0006\u00021\n2 Œ\u00061\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nOrnstein-Uhlenbeck term:\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n\n8.6\nIsokinetic Methods and Integration with Very Large Timestep\n371\nIt is straightforward to show that each of the terms of the corresponding vector\nﬁeld splitting preserves the ﬁrst integral \u0017 D constant. For example\nLF\u0017 D \nFF \u0003 .p2=\u0017/FF\u000b @\u0017\n@p \u0003 p\u00121FF\n\u0017\n@\u0017\n@\u00121\nD\n\nFF \u0003 .p2=\u0017/FF\u000b\n.2p/ \u0003 p\u00121FF\n\u0017\n.\u00061\u00121/\nD pFF \n2 \u0003 \u0017\u00021.2p2 C \u00061\u00122\n1/\u000b\nD 2pFF \n1 \u0003 \u0017\u00021\u0017\n\u000b\nD 0:\nThe proof for the other terms is similar.\nThe given decomposition can be used to construct a variety of algorithms,\nfor example the following which we term the Stochastic Isokinetic Nosé-Hoover\nRESPA algorithm.\nSIN(R) Algorithm\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\nPropagate p, \u00121 by exp \n.Qh=2/LF C .h=2/LS\n\u000b,\n.Qh D h=r/:\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nRepeat r \u0003 2 times:\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate \u00122 by exp\n\n.Qh/LO\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate p, \u00121 by exp \n.Qh=2/LF\n\u000b.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF C .h=2/LS\n\u000b\n.\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 391,
      "printed_page": 370,
      "text": "370\n8\nExtended Variable Methods\nof stochastic perturbation). Unlike for r-RESPA, the splitting needs to be performed\nat the level of the differential equations. We suppress the index of the degree of\nfreedom, takes its mass to be one for simplicity of presentation, and write the\nequations of motion for the variables associated to a single physical degree of\nfreedom in the form\ndq D pdt;\ndp D Fdt \u0003\n \np.FF C FS/ \u0003 1\n2\u00061\u00122\n1\u00122\n\u0017\n!\npdt;\nd\u00121 D \u0003\n \np.FF C FS/ \u0003 1\n2\u00061\u00122\n1\u00122\n\u0017\n!\n\u00121dt \u0003 \u00122\u00121dt;\nd\u00122 D \u0006\u00021\n2 .\u00061\u00122\n1 \u0003 ˇ\u00021/dt \u0003 \n\u00122dt C \u0007dW;\nwhere \u0017 D p2 C 1\n2\u00061\u00122\n1. \u0017 D ˇ\u00021 is constant of motion.\nBecause of the form of the coupling, we observe that this vector ﬁeld can be addi-\ntively decomposed based on the various terms in the stochastic isokinetic equations,\nincluding the fast-slow splitting of the forces, into the following generators:\nKinetic part:\nLK D p @\n@q;\nisokinetic Fast force:\nLF D \nFF \u0003 .p2=\u0017/FF\u000b @\n@p \u0003 p\u00121FF\n\u0017\n@\n@\u00121\n;\nisokinetic Slow force:\nLS D\n\nFS \u0003 .p2=\u0017/FS\u000b @\n@p \u0003 p\u00121FS\n\u0017\n@\n@\u00121\n;\nisokinetic Nosé terms:\nLN D 1\n2\n\u00061\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00061\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC \u0006\u00021\n2 Œ\u00061\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nOrnstein-Uhlenbeck term:\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n"
    },
    {
      "pdf_page": 392,
      "printed_page": 371,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n371\nIt is straightforward to show that each of the terms of the corresponding vector\nﬁeld splitting preserves the ﬁrst integral \u0017 D constant. For example\nLF\u0017 D \nFF \u0003 .p2=\u0017/FF\u000b @\u0017\n@p \u0003 p\u00121FF\n\u0017\n@\u0017\n@\u00121\nD\n\nFF \u0003 .p2=\u0017/FF\u000b\n.2p/ \u0003 p\u00121FF\n\u0017\n.\u00061\u00121/\nD pFF \n2 \u0003 \u0017\u00021.2p2 C \u00061\u00122\n1/\u000b\nD 2pFF \n1 \u0003 \u0017\u00021\u0017\n\u000b\nD 0:\nThe proof for the other terms is similar.\nThe given decomposition can be used to construct a variety of algorithms,\nfor example the following which we term the Stochastic Isokinetic Nosé-Hoover\nRESPA algorithm.\nSIN(R) Algorithm\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\nPropagate p, \u00121 by exp \n.Qh=2/LF C .h=2/LS\n\u000b,\n.Qh D h=r/:\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nRepeat r \u0003 2 times:\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate \u00122 by exp\n\n.Qh/LO\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate p, \u00121 by exp \n.Qh=2/LF\n\u000b.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF C .h=2/LS\n\u000b\n.\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Q₁,Q₂,θ>0且Λ=θ为物理域，总化场保留作辅助；本条含完整漂移和分解及力子场瞬时约束平衡，其他子场的流存在/保约束列缺口。"
  ],
  "issues": [],
  "statement_scope": "五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。",
  "lean_decl": "MD.Ch08.sinKField",
  "lean_declarations": [
    "MD.Ch08.sinKField",
    "MD.Ch08.sinForceField",
    "MD.Ch08.sinNField",
    "MD.Ch08.sinOField",
    "MD.Ch08.sinSplit_fields",
    "MD.Ch08.sinForce_constraintBalance"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinKField (z : Vec 4) : Vec 4 := ![z 1,0,0,0]
def sinForceField (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,-z 1*z 2*F/sinConstraint Q1 z,0]
def sinNField (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,(Q1*z 2^2-θ)/Q2]
def sinOField (γ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,-γ*z 3]
theorem sinSplit_fields (Q1 Q2 θ γ : ℝ) (FF FS : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    sinDrift Q1 Q2 θ γ (fun q ↦ FF q+FS q) z =
      sinKField z+sinForceField Q1 (FF (z 0)) z+
      sinForceField Q1 (FS (z 0)) z+sinNField Q1 Q2 θ z+sinOField γ z := by
  ext i; fin_cases i <;> simp [sinDrift,sinMultiplier,sinKField,sinForceField,sinNField,sinOField]
    <;> field_simp <;> ring
theorem sinForce_constraintBalance (Q1 F : ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinForceField Q1 F z) 1+Q1*z 2*(sinForceField Q1 F z) 2=0 := by
  change 2*z 1*(F-z 1^2*F/sinConstraint Q1 z)+
    Q1*z 2*(-z 1*z 2*F/sinConstraint Q1 z)=0
  generalize hd : sinConstraint Q1 z = lam at *
  field_simp [hK]
  rw [← hd]
  dsimp [sinConstraint]
  ring
```

## MD-8.6.3-SINRAlgorithm
```json
{
  "source_id": "MD-8.6.3-SINRAlgorithm",
  "kind": "definition",
  "label": null,
  "section": "8.6.3",
  "printed_page": "371",
  "pdf_page": "392",
  "statement_latex": "The SIN(R) algorithm uses h̃=h/r, r−2 repeated inner blocks, outer Nosé half-steps, combined fast/slow force half-steps and independent OU substeps.",
  "statement_verbatim": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n371\nIt is straightforward to show that each of the terms of the corresponding vector\nﬁeld splitting preserves the ﬁrst integral \u0017 D constant. For example\nLF\u0017 D \nFF \u0003 .p2=\u0017/FF\u000b @\u0017\n@p \u0003 p\u00121FF\n\u0017\n@\u0017\n@\u00121\nD\n\nFF \u0003 .p2=\u0017/FF\u000b\n.2p/ \u0003 p\u00121FF\n\u0017\n.\u00061\u00121/\nD pFF \n2 \u0003 \u0017\u00021.2p2 C \u00061\u00122\n1/\u000b\nD 2pFF \n1 \u0003 \u0017\u00021\u0017\n\u000b\nD 0:\nThe proof for the other terms is similar.\nThe given decomposition can be used to construct a variety of algorithms,\nfor example the following which we term the Stochastic Isokinetic Nosé-Hoover\nRESPA algorithm.\nSIN(R) Algorithm\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\nPropagate p, \u00121 by exp \n.Qh=2/LF C .h=2/LS\n\u000b,\n.Qh D h=r/:\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nRepeat r \u0003 2 times:\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate \u00122 by exp\n\n.Qh/LO\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate p, \u00121 by exp \n.Qh=2/LF\n\u000b.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF C .h=2/LS\n\u000b\n.\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 392,
      "printed_page": 371,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n371\nIt is straightforward to show that each of the terms of the corresponding vector\nﬁeld splitting preserves the ﬁrst integral \u0017 D constant. For example\nLF\u0017 D \nFF \u0003 .p2=\u0017/FF\u000b @\u0017\n@p \u0003 p\u00121FF\n\u0017\n@\u0017\n@\u00121\nD\n\nFF \u0003 .p2=\u0017/FF\u000b\n.2p/ \u0003 p\u00121FF\n\u0017\n.\u00061\u00121/\nD pFF \n2 \u0003 \u0017\u00021.2p2 C \u00061\u00122\n1/\u000b\nD 2pFF \n1 \u0003 \u0017\u00021\u0017\n\u000b\nD 0:\nThe proof for the other terms is similar.\nThe given decomposition can be used to construct a variety of algorithms,\nfor example the following which we term the Stochastic Isokinetic Nosé-Hoover\nRESPA algorithm.\nSIN(R) Algorithm\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\nPropagate p, \u00121 by exp \n.Qh=2/LF C .h=2/LS\n\u000b,\n.Qh D h=r/:\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nRepeat r \u0003 2 times:\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate \u00122 by exp\n\n.Qh/LO\n\u000b\n.\nPropagate q by exp\n\n.Qh=2/LK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF\n\u000b\n.\nPropagate p, \u00121 by exp \n.Qh=2/LF\n\u000b.\nPropagate \u00122 by exp\n\nQhLO\n\u000b\n.\nPropagate q by exp\n\nQhLK\n\u000b\n.\nPropagate p, \u00121 by exp\n\n.Qh=2/LF C .h=2/LS\n\u000b\n.\nPropagate p, \u00121, \u00122 by exp Œ.h=2/LN\t.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "算法有效域h>0、r≥2；一组中多个场表示同一次合并传播，并非擅自换为两个非交换流。每次OU用独立标准正态新噪声。",
    "这里只记录精确阶段表，具体随机核实现、保约束及全局误差/阶数列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "原印算法的阶段顺序与步长；不声称构造了各非线性子流。",
  "lean_decl": "MD.Ch08.SINStage",
  "lean_declarations": [
    "MD.Ch08.SINStage",
    "MD.Ch08.sinRStages"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
inductive SINStage where
  | kinetic | fast | slow | nose | ou
  deriving DecidableEq
def sinRStages (h : ℝ) (r : ℕ) : List (List (SINStage × ℝ)) :=
  let a := h/(r:ℝ)
  [[(.nose,h/2)],[(.fast,a/2),(.slow,h/2)],[(.kinetic,a)],[(.ou,a)],[(.fast,a/2)]] ++
  List.flatten (List.replicate (r-2)
    [[(.fast,a/2)],[(.kinetic,a/2)],[(.ou,a)],[(.kinetic,a/2)],[(.fast,a/2)]]) ++
  [[(.fast,a/2)],[(.ou,a)],[(.kinetic,a)],[(.fast,a/2),(.slow,h/2)],[(.nose,h/2)]]
```

## MD-8.6.3-SINNoseSubsplitting
```json
{
  "source_id": "MD-8.6.3-SINNoseSubsplitting",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.3",
  "printed_page": "372",
  "pdf_page": "393",
  "statement_latex": "L_N=L_N^(1)+L_N^(2). The first term acts on p,ξ₁, the second has μ₂⁻¹(μ₁ξ₁²-β⁻¹)∂ξ₂.",
  "statement_verbatim": "372\n8\nExtended Variable Methods\nWe stress that the implementation of this method is in fact quite straightforward,\ndespite its apparent complexity. The following details regarding the implementation\nare discussed in [220]:\n•\nFor the integration of the Nosé terms, it is recommended to use a further splitting:\nLN D L.1/\nN C L.2/\nN ;\nwhere\nL.1/\nN D 1\n2\n\u00061\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00061\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\n;\nand\nL.2/\nN D \u0006\u00021\n2 Œ\u00061\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n:\nMoreover a Yoshida/Suzuki type higher order decomposition is used to obtain\nmore accuracy in this component.\n•\nThe term exp ŒhLF\t (like similar terms) is completely integrable. Note that in\ngeneral this reduces to solving\nPp D F \u0003 p2F=\u0017;\nP\u00121 D p\u00121F=\u0017;\nwith F a constant.\nThe solution in a timestep h is\np.h/ D p.0/ C .F=m/s.h/\nPs.h/\n;\n\u00121.h/ D \u00121.0/\nPs.h/ ;\nwhere\ns.t/ D b\u00021=2 sinh.t\np\nb/ C a\nb.cosh.t\np\nb/ \u0003 1/\nwith a D Fp.0/=\u0017 and b D F2=\u0017, \u0017 D ˇ\u00021.\nCare must be taken in the evaluation of s and Ps for a; b close to zero.\nNote that other decompositions are possible [220].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 393,
      "printed_page": 372,
      "text": "372\n8\nExtended Variable Methods\nWe stress that the implementation of this method is in fact quite straightforward,\ndespite its apparent complexity. The following details regarding the implementation\nare discussed in [220]:\n•\nFor the integration of the Nosé terms, it is recommended to use a further splitting:\nLN D L.1/\nN C L.2/\nN ;\nwhere\nL.1/\nN D 1\n2\n\u00061\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00061\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\n;\nand\nL.2/\nN D \u0006\u00021\n2 Œ\u00061\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n:\nMoreover a Yoshida/Suzuki type higher order decomposition is used to obtain\nmore accuracy in this component.\n•\nThe term exp ŒhLF\t (like similar terms) is completely integrable. Note that in\ngeneral this reduces to solving\nPp D F \u0003 p2F=\u0017;\nP\u00121 D p\u00121F=\u0017;\nwith F a constant.\nThe solution in a timestep h is\np.h/ D p.0/ C .F=m/s.h/\nPs.h/\n;\n\u00121.h/ D \u00121.0/\nPs.h/ ;\nwhere\ns.t/ D b\u00021=2 sinh.t\np\nb/ C a\nb.cosh.t\np\nb/ \u0003 1/\nwith a D Fp.0/=\u0017 and b D F2=\u0017, \u0017 D ˇ\u00021.\nCare must be taken in the evaluation of s and Ps for a; b close to zero.\nNote that other decompositions are possible [220].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "正质量、温度及Λ>0作为物理资格；高阶Yoshida/Suzuki组合的系数和误差阶未在原页给出，列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "Nosé场的两项分解恒等式。",
  "lean_decl": "MD.Ch08.sinN1Field",
  "lean_declarations": [
    "MD.Ch08.sinN1Field",
    "MD.Ch08.sinN2Field",
    "MD.Ch08.sinN_split"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinN1Field (Q1 : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,0]
def sinN2Field (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,(Q1*z 2^2-θ)/Q2]
theorem sinN_split (Q1 Q2 θ : ℝ) (z : Vec 4) :
    sinNField Q1 Q2 θ z=sinN1Field Q1 z+sinN2Field Q1 Q2 θ z := by
  ext i; fin_cases i <;> simp [sinNField,sinN1Field,sinN2Field]
```

## MD-8.6.3-SINForceExactPrinted
```json
{
  "source_id": "MD-8.6.3-SINForceExactPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.3",
  "printed_page": "372",
  "pdf_page": "393",
  "statement_latex": "ṗ=F−p²F/Λ, ξ̇₁=pξ₁F/Λ. The printed solution is p(h)=(p(0)+(F/m)s(h))/ṡ(h), ξ₁(h)=ξ₁(0)/ṡ(h), with s(t)=b⁻¹/²sinh(t√b)+(a/b)(cosh(t√b)−1), a=Fp(0)/Λ, b=F²/Λ.",
  "statement_verbatim": "372\n8\nExtended Variable Methods\nWe stress that the implementation of this method is in fact quite straightforward,\ndespite its apparent complexity. The following details regarding the implementation\nare discussed in [220]:\n•\nFor the integration of the Nosé terms, it is recommended to use a further splitting:\nLN D L.1/\nN C L.2/\nN ;\nwhere\nL.1/\nN D 1\n2\n\u00061\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00061\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\n;\nand\nL.2/\nN D \u0006\u00021\n2 Œ\u00061\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n:\nMoreover a Yoshida/Suzuki type higher order decomposition is used to obtain\nmore accuracy in this component.\n•\nThe term exp ŒhLF\t (like similar terms) is completely integrable. Note that in\ngeneral this reduces to solving\nPp D F \u0003 p2F=\u0017;\nP\u00121 D p\u00121F=\u0017;\nwith F a constant.\nThe solution in a timestep h is\np.h/ D p.0/ C .F=m/s.h/\nPs.h/\n;\n\u00121.h/ D \u00121.0/\nPs.h/ ;\nwhere\ns.t/ D b\u00021=2 sinh.t\np\nb/ C a\nb.cosh.t\np\nb/ \u0003 1/\nwith a D Fp.0/=\u0017 and b D F2=\u0017, \u0017 D ˇ\u00021.\nCare must be taken in the evaluation of s and Ps for a; b close to zero.\nNote that other decompositions are possible [220].\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 393,
      "printed_page": 372,
      "text": "372\n8\nExtended Variable Methods\nWe stress that the implementation of this method is in fact quite straightforward,\ndespite its apparent complexity. The following details regarding the implementation\nare discussed in [220]:\n•\nFor the integration of the Nosé terms, it is recommended to use a further splitting:\nLN D L.1/\nN C L.2/\nN ;\nwhere\nL.1/\nN D 1\n2\n\u00061\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00061\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\n;\nand\nL.2/\nN D \u0006\u00021\n2 Œ\u00061\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n:\nMoreover a Yoshida/Suzuki type higher order decomposition is used to obtain\nmore accuracy in this component.\n•\nThe term exp ŒhLF\t (like similar terms) is completely integrable. Note that in\ngeneral this reduces to solving\nPp D F \u0003 p2F=\u0017;\nP\u00121 D p\u00121F=\u0017;\nwith F a constant.\nThe solution in a timestep h is\np.h/ D p.0/ C .F=m/s.h/\nPs.h/\n;\n\u00121.h/ D \u00121.0/\nPs.h/ ;\nwhere\ns.t/ D b\u00021=2 sinh.t\np\nb/ C a\nb.cosh.t\np\nb/ \u0003 1/\nwith a D Fp.0/=\u0017 and b D F2=\u0017, \u0017 D ˇ\u00021.\nCare must be taken in the evaluation of s and Ps for a; b close to zero.\nNote that other decompositions are possible [220].\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "质量按本节假设取1；Q₁、Λ正，排除ṡ=0；F=0用b=0的解析延拓，避免总化除法假装极限。",
    "只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。"
  ],
  "issues": [
    "已目视核对原页PDF393：所印ξ̇₁为正号，与前页力子场及ξ₁(h)=ξ₁(0)/ṡ(h)的负号导数冲突。保留原印和负号工作修正版。"
  ],
  "statement_scope": "原印子场、显式候选与校正ODE的局部导数目标。",
  "lean_decl": "MD.Ch08.sinForceAux",
  "lean_declarations": [
    "MD.Ch08.sinForceAux",
    "MD.Ch08.sinForceFlow",
    "MD.Ch08.sinForceODEPrinted",
    "MD.Ch08.sinForceODE_corrected",
    "MD.Ch08.sinForceFlow_solution_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinForceAux (a b t : ℝ) : ℝ :=
  if b=0 then t+a*t^2/2 else Real.sinh (t*Real.sqrt b)/Real.sqrt b+a/b*(Real.cosh (t*Real.sqrt b)-1)
def sinForceFlow (Q1 F t : ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinConstraint Q1 z
  let s := sinForceAux (F*z 1/lam) (F^2/lam)
  ![z 0,(z 1+F*s t)/deriv s t,z 2/deriv s t,z 3]
def sinForceODEPrinted (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,z 1*z 2*F/sinConstraint Q1 z,0]
def sinForceODE_corrected (Q1 F : ℝ) : Vec 4 → Vec 4 := sinForceField Q1 F
theorem sinForceFlow_solution_corrected (Q1 F : ℝ) (z : Vec 4)
    (hQ1 : 0 < Q1) (hK : 0 < sinConstraint Q1 z) (t : ℝ)
    (hden : deriv (sinForceAux (F*z 1/sinConstraint Q1 z) (F^2/sinConstraint Q1 z)) t ≠ 0) :
    HasDerivAt (fun s ↦ sinForceFlow Q1 F s z)
      (sinForceField Q1 F (sinForceFlow Q1 F t z)) t := by
  sorry
```
