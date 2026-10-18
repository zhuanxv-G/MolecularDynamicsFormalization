# BATCH06 第8章原文与陈述审校

## MD-8.4.1-NHLGenerator
```json
{
  "source_id": "MD-8.4.1-NHLGenerator",
  "kind": "definition",
  "label": null,
  "section": "8.4.1",
  "printed_page": "348",
  "pdf_page": "369",
  "statement_latex": "L_NHL f=M⁻¹p·∇qf-∇U·∇pf-ξp·∇pf+[μ⁻¹(pᵀM⁻¹p-N_dk_BT)-γξ]∂ξf+k_BTγμ⁻¹∂ξ²f.",
  "statement_verbatim": "348\n8\nExtended Variable Methods\nDeﬁne polynomials \u0014.x/ D PNc\u00021\njD0 ˛jxj, \u0007.x/ D PNc\u00021\njD0 ˇjxj, then, for each j, we\nhave\n\u0014.\u0013j/Oqj C \u0013j\u0007.\u0013j/Opj D 0;\n\u0013j\u0014.\u0013j/Opj \u0003 \u0013j\u0007.\u0013j/Oqj D 0;\nmultiplying the ﬁrst equation by Oqj and the second by Opj and adding, we obtain\nŒOq2\nj C \u0013jOp2\nj \t\u0014.\u0013j/ D 0:\nThe ﬁrst factor is nonzero by the condition of being in D and the positive\ndeﬁniteness of A, thus we must have \u0014.\u0013j/ D 0 for all Nc distinct \u0013j. But as\n\u0014 has degree Nc \u0003 1, this is a contradiction. Thus the collection must be linearly\nindependent.\nDemonstrating the Hörmander condition is sufﬁcient for Assumption 1(ii) in\nSect. 6.4.4. Assumption 1(i) can be veriﬁed by proving that solutions are able to\naccess an open set around any point y 2 D \u0004 R. We omit the proof of Assumption\n1(i) for Nosé-Hoover-Langevin dynamics as it is follows the same structure as the\nproof of Lemma 6.1 for Langevin dynamics. The details of the proof can be found\nin [283], with examples for more general SDEs given in [256, 257].\nThe ﬁnal requirement for geometric ergodicity (speciﬁed in Assumption 2 in\nSect. 6.4.4) requires a function \b W D \u0004 R ! .0; 1/ such that\nL\b \t \u0003˛\b C ı;\nfor positive constants ˛ and ı and where L is the generator of the stochastic process.\nSuch a function is called a Lyapunov function.\nThe generator for Nosé-Hoover-Langevin dynamics (8.27)–(8.29), acting on a\nsuitable test function f.q; p; \u0012/ is\nLNHLfD M\u00021p \u0002 rqf \u0003 rU.q/ \u0002 rpf \u0003 \u0012p \u0002 rp C \u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b @f\n@\u0012\n\u0003 \n\u0012 @f\n@\u0012 C kBT\n\u0006\u00021 @2f\n@\u00122 :\nIf we consider M D I for simplicity, a Lyapunov function is given in [283] as\n\b.q; p; \u0012/ D 1\n2kpk2 C U.q/ C \u0006\n2 .\u0012 \u0003 a/2;\nwhere a is a constant. As our potential is smooth, it is reasonable to make the\nassumption that\n1 < Umin \t U.q/ \t Umax < 1;\n8q 2 Q;\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 369,
      "printed_page": 348,
      "text": "348\n8\nExtended Variable Methods\nDeﬁne polynomials \u0014.x/ D PNc\u00021\njD0 ˛jxj, \u0007.x/ D PNc\u00021\njD0 ˇjxj, then, for each j, we\nhave\n\u0014.\u0013j/Oqj C \u0013j\u0007.\u0013j/Opj D 0;\n\u0013j\u0014.\u0013j/Opj \u0003 \u0013j\u0007.\u0013j/Oqj D 0;\nmultiplying the ﬁrst equation by Oqj and the second by Opj and adding, we obtain\nŒOq2\nj C \u0013jOp2\nj \t\u0014.\u0013j/ D 0:\nThe ﬁrst factor is nonzero by the condition of being in D and the positive\ndeﬁniteness of A, thus we must have \u0014.\u0013j/ D 0 for all Nc distinct \u0013j. But as\n\u0014 has degree Nc \u0003 1, this is a contradiction. Thus the collection must be linearly\nindependent.\nDemonstrating the Hörmander condition is sufﬁcient for Assumption 1(ii) in\nSect. 6.4.4. Assumption 1(i) can be veriﬁed by proving that solutions are able to\naccess an open set around any point y 2 D \u0004 R. We omit the proof of Assumption\n1(i) for Nosé-Hoover-Langevin dynamics as it is follows the same structure as the\nproof of Lemma 6.1 for Langevin dynamics. The details of the proof can be found\nin [283], with examples for more general SDEs given in [256, 257].\nThe ﬁnal requirement for geometric ergodicity (speciﬁed in Assumption 2 in\nSect. 6.4.4) requires a function \b W D \u0004 R ! .0; 1/ such that\nL\b \t \u0003˛\b C ı;\nfor positive constants ˛ and ı and where L is the generator of the stochastic process.\nSuch a function is called a Lyapunov function.\nThe generator for Nosé-Hoover-Langevin dynamics (8.27)–(8.29), acting on a\nsuitable test function f.q; p; \u0012/ is\nLNHLfD M\u00021p \u0002 rqf \u0003 rU.q/ \u0002 rpf \u0003 \u0012p \u0002 rp C \u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b @f\n@\u0012\n\u0003 \n\u0012 @f\n@\u0012 C kBT\n\u0006\u00021 @2f\n@\u00122 :\nIf we consider M D I for simplicity, a Lyapunov function is given in [283] as\n\b.q; p; \u0012/ D 1\n2kpk2 C U.q/ C \u0006\n2 .\u0012 \u0003 a/2;\nwhere a is a constant. As our potential is smooth, it is reasonable to make the\nassumption that\n1 < Umin \t U.q/ \t Umax < 1;\n8q 2 Q;\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "采用实际一阶、二阶Fréchet导数；原文省略f的-ξp·∇p理解为作用于f；Q,β,γ须正。"
  ],
  "issues": [],
  "statement_scope": "实际加性扩散的Fréchet形式生成元、Lyapunov候选及漂移界性质的定义。",
  "lean_decl": "MD.Ch08.additiveGenerator",
  "lean_declarations": [
    "MD.Ch08.additiveGenerator",
    "MD.Ch08.nhlGenerator",
    "MD.Ch08.nhlLyapunov",
    "MD.Ch08.geometricDriftBound"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def additiveGenerator {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (B : E) (f : E → ℝ) (z : E) : ℝ :=
  fderiv ℝ f z (F z) + fderiv ℝ (fun x ↦ fderiv ℝ f x B) z B / 2
def nhlGenerator (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (f : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  additiveGenerator (nhlDrift invm U β Q γ) (0, Real.sqrt (2*γ/(β*Q))) f z
def nhlLyapunov (U : Vec n → ℝ) (Q a : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∑ i, z.1.2 i^2)/2 + U z.1.1 + Q*(z.2-a)^2/2
def geometricDriftBound {E : Type*} (L : (E → ℝ) → E → ℝ) (V : E → ℝ) : Prop :=
  (∀ z, 0 < V z) ∧ ∃ α δ : ℝ, 0 < α ∧ 0 < δ ∧ ∀ z, L V z ≤ -α*V z+δ
```

## MD-8.4.1-LyapunovCalculation
```json
{
  "source_id": "MD-8.4.1-LyapunovCalculation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.4.1",
  "printed_page": "348–349",
  "pdf_page": "369–370",
  "statement_latex": "For M=I, φ=‖p‖²/2+U+μ(ξ-a)²/2, Lφ=-a‖p‖²-γμξ(ξ-a)-N_dk_BT(ξ-a)+k_BTγ.",
  "statement_verbatim": "348\n8\nExtended Variable Methods\nDeﬁne polynomials \u0014.x/ D PNc\u00021\njD0 ˛jxj, \u0007.x/ D PNc\u00021\njD0 ˇjxj, then, for each j, we\nhave\n\u0014.\u0013j/Oqj C \u0013j\u0007.\u0013j/Opj D 0;\n\u0013j\u0014.\u0013j/Opj \u0003 \u0013j\u0007.\u0013j/Oqj D 0;\nmultiplying the ﬁrst equation by Oqj and the second by Opj and adding, we obtain\nŒOq2\nj C \u0013jOp2\nj \t\u0014.\u0013j/ D 0:\nThe ﬁrst factor is nonzero by the condition of being in D and the positive\ndeﬁniteness of A, thus we must have \u0014.\u0013j/ D 0 for all Nc distinct \u0013j. But as\n\u0014 has degree Nc \u0003 1, this is a contradiction. Thus the collection must be linearly\nindependent.\nDemonstrating the Hörmander condition is sufﬁcient for Assumption 1(ii) in\nSect. 6.4.4. Assumption 1(i) can be veriﬁed by proving that solutions are able to\naccess an open set around any point y 2 D \u0004 R. We omit the proof of Assumption\n1(i) for Nosé-Hoover-Langevin dynamics as it is follows the same structure as the\nproof of Lemma 6.1 for Langevin dynamics. The details of the proof can be found\nin [283], with examples for more general SDEs given in [256, 257].\nThe ﬁnal requirement for geometric ergodicity (speciﬁed in Assumption 2 in\nSect. 6.4.4) requires a function \b W D \u0004 R ! .0; 1/ such that\nL\b \t \u0003˛\b C ı;\nfor positive constants ˛ and ı and where L is the generator of the stochastic process.\nSuch a function is called a Lyapunov function.\nThe generator for Nosé-Hoover-Langevin dynamics (8.27)–(8.29), acting on a\nsuitable test function f.q; p; \u0012/ is\nLNHLfD M\u00021p \u0002 rqf \u0003 rU.q/ \u0002 rpf \u0003 \u0012p \u0002 rp C \u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b @f\n@\u0012\n\u0003 \n\u0012 @f\n@\u0012 C kBT\n\u0006\u00021 @2f\n@\u00122 :\nIf we consider M D I for simplicity, a Lyapunov function is given in [283] as\n\b.q; p; \u0012/ D 1\n2kpk2 C U.q/ C \u0006\n2 .\u0012 \u0003 a/2;\nwhere a is a constant. As our potential is smooth, it is reasonable to make the\nassumption that\n1 < Umin \t U.q/ \t Umax < 1;\n8q 2 Q;\n\n8.4\nErgodic Stochastic-Dynamic Thermostats\n349\nfor some constants Umin and Umax. Hence \b is strictly positive over the entire space,\nand we can compute that\nLNHL\b D p \u0002 rU.q/ \u0003 rU.q/ \u0002 p \u0003 \u0012kpk2 C\n\nkpk2 \u0003 NdkBT\n\u000b\n.\u0012 \u0003 a/\n\u0003 \n\u0006\u0012.\u0012 \u0003 a/ C kBT\n;\n\t \u0003akpk2 \u0003 \n\u0006\u00122 C .a\n\u0006 \u0003 NdkBT/ \u0012 C aNdkBT C kBT\n:\nChoosing a so that a\n\u0006 \u0003 NdkBT D 0, we obtain\nLNHL\b D \u0003akpk2 \u0003 \n\u0006\u00122 \u0003 \n\u0006a2 C \n\u0006a2 C aNdkBT C kBT\n:\nUsing \u0003\u00122 \u0003 a2 \t \u0003.\u0012 \u0003 a/2=2 gives\nLNHL\b \t \u00032a1\n2kpk2 \u0003 \n\u00061\n2.\u0012 \u0003 a/2 C \n\u0006a2 C aNdkBT C kBT\n:\nNow choosing\n˛ D min .2a; \n\u0006/ ;\nwe have\nLNHL\b \t \u0003˛\b C ˛U.q/ C \n\u0006a2 C aNdkBT C kBT\n;\n\t \u0003˛\b C ı;\nfor constants ˛ and ı as required, where\nı D ˛Umax C \n\u0006a2 C aNdkBT C kBT\n:\nThis gives the necessary Lyapunov condition for the Nosé-Hoover-Langevin equa-\ntions, and hence the dynamics are geometrically ergodic. Solution trajectories will\nsample the extended canonical distribution, and it remains to compute solutions\nusing an appropriate discretization scheme.\n8.4.2\nNumerical Integration of the Nosé-Hoover-Langevin\nEquations\nMany older schemes for Nosé-Hoover and Langevin dynamics make use of\ncomputational shortcuts to (for example) reduce the number of computed random\nvalues per iteration, reduce the data storage needed for an algorithm or replace\nfunctions that are costly to evaluate (e.g. exponential or trigonometric functions)\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 369,
      "printed_page": 348,
      "text": "348\n8\nExtended Variable Methods\nDeﬁne polynomials \u0014.x/ D PNc\u00021\njD0 ˛jxj, \u0007.x/ D PNc\u00021\njD0 ˇjxj, then, for each j, we\nhave\n\u0014.\u0013j/Oqj C \u0013j\u0007.\u0013j/Opj D 0;\n\u0013j\u0014.\u0013j/Opj \u0003 \u0013j\u0007.\u0013j/Oqj D 0;\nmultiplying the ﬁrst equation by Oqj and the second by Opj and adding, we obtain\nŒOq2\nj C \u0013jOp2\nj \t\u0014.\u0013j/ D 0:\nThe ﬁrst factor is nonzero by the condition of being in D and the positive\ndeﬁniteness of A, thus we must have \u0014.\u0013j/ D 0 for all Nc distinct \u0013j. But as\n\u0014 has degree Nc \u0003 1, this is a contradiction. Thus the collection must be linearly\nindependent.\nDemonstrating the Hörmander condition is sufﬁcient for Assumption 1(ii) in\nSect. 6.4.4. Assumption 1(i) can be veriﬁed by proving that solutions are able to\naccess an open set around any point y 2 D \u0004 R. We omit the proof of Assumption\n1(i) for Nosé-Hoover-Langevin dynamics as it is follows the same structure as the\nproof of Lemma 6.1 for Langevin dynamics. The details of the proof can be found\nin [283], with examples for more general SDEs given in [256, 257].\nThe ﬁnal requirement for geometric ergodicity (speciﬁed in Assumption 2 in\nSect. 6.4.4) requires a function \b W D \u0004 R ! .0; 1/ such that\nL\b \t \u0003˛\b C ı;\nfor positive constants ˛ and ı and where L is the generator of the stochastic process.\nSuch a function is called a Lyapunov function.\nThe generator for Nosé-Hoover-Langevin dynamics (8.27)–(8.29), acting on a\nsuitable test function f.q; p; \u0012/ is\nLNHLfD M\u00021p \u0002 rqf \u0003 rU.q/ \u0002 rpf \u0003 \u0012p \u0002 rp C \u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b @f\n@\u0012\n\u0003 \n\u0012 @f\n@\u0012 C kBT\n\u0006\u00021 @2f\n@\u00122 :\nIf we consider M D I for simplicity, a Lyapunov function is given in [283] as\n\b.q; p; \u0012/ D 1\n2kpk2 C U.q/ C \u0006\n2 .\u0012 \u0003 a/2;\nwhere a is a constant. As our potential is smooth, it is reasonable to make the\nassumption that\n1 < Umin \t U.q/ \t Umax < 1;\n8q 2 Q;\n"
    },
    {
      "pdf_page": 370,
      "printed_page": 349,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n349\nfor some constants Umin and Umax. Hence \b is strictly positive over the entire space,\nand we can compute that\nLNHL\b D p \u0002 rU.q/ \u0003 rU.q/ \u0002 p \u0003 \u0012kpk2 C\n\nkpk2 \u0003 NdkBT\n\u000b\n.\u0012 \u0003 a/\n\u0003 \n\u0006\u0012.\u0012 \u0003 a/ C kBT\n;\n\t \u0003akpk2 \u0003 \n\u0006\u00122 C .a\n\u0006 \u0003 NdkBT/ \u0012 C aNdkBT C kBT\n:\nChoosing a so that a\n\u0006 \u0003 NdkBT D 0, we obtain\nLNHL\b D \u0003akpk2 \u0003 \n\u0006\u00122 \u0003 \n\u0006a2 C \n\u0006a2 C aNdkBT C kBT\n:\nUsing \u0003\u00122 \u0003 a2 \t \u0003.\u0012 \u0003 a/2=2 gives\nLNHL\b \t \u00032a1\n2kpk2 \u0003 \n\u00061\n2.\u0012 \u0003 a/2 C \n\u0006a2 C aNdkBT C kBT\n:\nNow choosing\n˛ D min .2a; \n\u0006/ ;\nwe have\nLNHL\b \t \u0003˛\b C ˛U.q/ C \n\u0006a2 C aNdkBT C kBT\n;\n\t \u0003˛\b C ı;\nfor constants ˛ and ı as required, where\nı D ˛Umax C \n\u0006a2 C aNdkBT C kBT\n:\nThis gives the necessary Lyapunov condition for the Nosé-Hoover-Langevin equa-\ntions, and hence the dynamics are geometrically ergodic. Solution trajectories will\nsample the extended canonical distribution, and it remains to compute solutions\nusing an appropriate discretization scheme.\n8.4.2\nNumerical Integration of the Nosé-Hoover-Langevin\nEquations\nMany older schemes for Nosé-Hoover and Langevin dynamics make use of\ncomputational shortcuts to (for example) reduce the number of computed random\nvalues per iteration, reduce the data storage needed for an algorithm or replace\nfunctions that are costly to evaluate (e.g. exponential or trigonometric functions)\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "U下界>1且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需C²。"
  ],
  "issues": [],
  "statement_scope": "实际NHL生成元作用于平移二次能量的目标及标量平方不等式；未据此证明遍历。",
  "lean_decl": "MD.Ch08.nhlLyapunovExpression",
  "lean_declarations": [
    "MD.Ch08.nhlLyapunovExpression",
    "MD.Ch08.nhlLyapunov_calculation",
    "MD.Ch08.shiftedSquare_bound"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhlLyapunovExpression (P2 U ξ Q θ γ a N : ℝ) : ℝ :=
  -a*P2-γ*Q*ξ*(ξ-a)-N*θ*(ξ-a)+θ*γ
theorem nhlLyapunov_calculation (U : Vec n → ℝ) (β Q γ a : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (hQ : 0 < Q) (hγ : 0 < γ)
    (z : Phase n × ℝ) :
    nhlGenerator (fun _ ↦ 1) U β Q γ (nhlLyapunov U Q a) z =
      nhlLyapunovExpression (∑ i, z.1.2 i^2) (U z.1.1) z.2 Q (1/β) γ a n := by
  sorry
theorem shiftedSquare_bound (ξ a : ℝ) : -ξ^2-a^2 ≤ -(ξ-a)^2/2 := by
  nlinarith [sq_nonneg (ξ+a)]
```

## MD-8.4.1-LyapunovRatePrinted
```json
{
  "source_id": "MD-8.4.1-LyapunovRatePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.4.1",
  "printed_page": "349",
  "pdf_page": "370",
  "statement_latex": "Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.",
  "statement_verbatim": "8.4\nErgodic Stochastic-Dynamic Thermostats\n349\nfor some constants Umin and Umax. Hence \b is strictly positive over the entire space,\nand we can compute that\nLNHL\b D p \u0002 rU.q/ \u0003 rU.q/ \u0002 p \u0003 \u0012kpk2 C\n\nkpk2 \u0003 NdkBT\n\u000b\n.\u0012 \u0003 a/\n\u0003 \n\u0006\u0012.\u0012 \u0003 a/ C kBT\n;\n\t \u0003akpk2 \u0003 \n\u0006\u00122 C .a\n\u0006 \u0003 NdkBT/ \u0012 C aNdkBT C kBT\n:\nChoosing a so that a\n\u0006 \u0003 NdkBT D 0, we obtain\nLNHL\b D \u0003akpk2 \u0003 \n\u0006\u00122 \u0003 \n\u0006a2 C \n\u0006a2 C aNdkBT C kBT\n:\nUsing \u0003\u00122 \u0003 a2 \t \u0003.\u0012 \u0003 a/2=2 gives\nLNHL\b \t \u00032a1\n2kpk2 \u0003 \n\u00061\n2.\u0012 \u0003 a/2 C \n\u0006a2 C aNdkBT C kBT\n:\nNow choosing\n˛ D min .2a; \n\u0006/ ;\nwe have\nLNHL\b \t \u0003˛\b C ˛U.q/ C \n\u0006a2 C aNdkBT C kBT\n;\n\t \u0003˛\b C ı;\nfor constants ˛ and ı as required, where\nı D ˛Umax C \n\u0006a2 C aNdkBT C kBT\n:\nThis gives the necessary Lyapunov condition for the Nosé-Hoover-Langevin equa-\ntions, and hence the dynamics are geometrically ergodic. Solution trajectories will\nsample the extended canonical distribution, and it remains to compute solutions\nusing an appropriate discretization scheme.\n8.4.2\nNumerical Integration of the Nosé-Hoover-Langevin\nEquations\nMany older schemes for Nosé-Hoover and Langevin dynamics make use of\ncomputational shortcuts to (for example) reduce the number of computed random\nvalues per iteration, reduce the data storage needed for an algorithm or replace\nfunctions that are costly to evaluate (e.g. exponential or trigonometric functions)\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 370,
      "printed_page": 349,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n349\nfor some constants Umin and Umax. Hence \b is strictly positive over the entire space,\nand we can compute that\nLNHL\b D p \u0002 rU.q/ \u0003 rU.q/ \u0002 p \u0003 \u0012kpk2 C\n\nkpk2 \u0003 NdkBT\n\u000b\n.\u0012 \u0003 a/\n\u0003 \n\u0006\u0012.\u0012 \u0003 a/ C kBT\n;\n\t \u0003akpk2 \u0003 \n\u0006\u00122 C .a\n\u0006 \u0003 NdkBT/ \u0012 C aNdkBT C kBT\n:\nChoosing a so that a\n\u0006 \u0003 NdkBT D 0, we obtain\nLNHL\b D \u0003akpk2 \u0003 \n\u0006\u00122 \u0003 \n\u0006a2 C \n\u0006a2 C aNdkBT C kBT\n:\nUsing \u0003\u00122 \u0003 a2 \t \u0003.\u0012 \u0003 a/2=2 gives\nLNHL\b \t \u00032a1\n2kpk2 \u0003 \n\u00061\n2.\u0012 \u0003 a/2 C \n\u0006a2 C aNdkBT C kBT\n:\nNow choosing\n˛ D min .2a; \n\u0006/ ;\nwe have\nLNHL\b \t \u0003˛\b C ˛U.q/ C \n\u0006a2 C aNdkBT C kBT\n;\n\t \u0003˛\b C ı;\nfor constants ˛ and ı as required, where\nı D ˛Umax C \n\u0006a2 C aNdkBT C kBT\n:\nThis gives the necessary Lyapunov condition for the Nosé-Hoover-Langevin equa-\ntions, and hence the dynamics are geometrically ergodic. Solution trajectories will\nsample the extended canonical distribution, and it remains to compute solutions\nusing an appropriate discretization scheme.\n8.4.2\nNumerical Integration of the Nosé-Hoover-Langevin\nEquations\nMany older schemes for Nosé-Hoover and Langevin dynamics make use of\ncomputational shortcuts to (for example) reduce the number of computed random\nvalues per iteration, reduce the data storage needed for an algorithm or replace\nfunctions that are costly to evaluate (e.g. exponential or trigonometric functions)\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。"
  ],
  "issues": [
    "已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。"
  ],
  "statement_scope": "所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。",
  "lean_decl": "MD.Ch08.lyapunovAlphaPrinted",
  "lean_declarations": [
    "MD.Ch08.lyapunovAlphaPrinted",
    "MD.Ch08.lyapunovAlpha_corrected",
    "MD.Ch08.lyapunovRatePrinted",
    "MD.Ch08.lyapunovRate_counterexample",
    "MD.Ch08.lyapunovRate_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def lyapunovAlphaPrinted (a γ Q : ℝ) : ℝ := min (2*a) (γ*Q)
def lyapunovAlpha_corrected (a γ : ℝ) : ℝ := min (2*a) γ
theorem lyapunovRatePrinted (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlphaPrinted a γ Q * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlphaPrinted a γ Q*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
theorem lyapunovRate_counterexample :
    ¬ (nhlLyapunovExpression 0 2 10 4 1 1 2 8 ≤
      -lyapunovAlphaPrinted 2 1 4 * ((0:ℝ)/2+2+4*(10-2)^2/2) +
      (lyapunovAlphaPrinted 2 1 4*2+1*4*2^2+2*8*1+1*1)) := by
  norm_num [nhlLyapunovExpression, lyapunovAlphaPrinted]
theorem lyapunovRate_corrected (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlpha_corrected a γ * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlpha_corrected a γ*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
```

## MD-8.4.2-NHLTimestep
```json
{
  "source_id": "MD-8.4.2-NHLTimestep",
  "kind": "definition",
  "label": null,
  "section": "8.4.2",
  "printed_page": "350",
  "pdf_page": "371",
  "statement_latex": "The symmetric NHL splitting uses kick, drift, feedback, damping, exact OU, damping, feedback, drift, kick. ζ=√(k_BTμ⁻¹(1-e^{-2γh})).",
  "statement_verbatim": "350\n8\nExtended Variable Methods\nby an approximate series expansion. In modern computer architectures, the number\nof force evaluations is responsible for the overwhelming majority of the time spent\nper iteration.\nWe can apply the splitting approach considered in Chap. 7 to integrate equations\n(8.27)–(8.29). One suitable choice of algorithm that we shall use in the following\nsubsection is\npnC1=2 D pn \u0003 .h=2/rU.qn/;\nqnC1=2 D qn C .h=2/M\u00021pnC1=2;\n\u0012nC1=2 D \u0012n C .h=2/\u0006\u00021 h\npT\nnC1=2M\u00021pnC1=2 \u0003 NdkBT\ni\n;\nQpnC1=2 D e\u0002.h=2/\u0012nC1=2pnC1=2;\nO\u0012nC1=2 D e\u0002\nh\u0012nC1=2 C \u0018Rn;\nOpnC1=2 D e\u0002.h=2/O\u0012nC1=2 QpnC1=2;\n\u0012nC1 D O\u0012nC1=2 C .h=2/\u0006\u00021 h\nOpT\nnC1=2M\u00021OpnC1=2 \u0003 NdkBT\ni\n;\nqnC1 D qnC1=2 C .h=2/M\u00021OpnC1=2;\npnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/;\nwhere \u0018 D\np\nkBT\u0006\u00021.1 \u0003 exp.\u00032\nh// and Rn is a normal random number with\nunit variance and zero mean.\nThis numerical method requires only one evaluation of the force per timestep. It\nalso reduces to a Nosé-Hoover integrator when \n D 0, and as it solves the Ornstein-\nUhlenbeck process exactly, it is stable under the large (or inﬁnite) limit of friction.\n8.4.3\nNumerical Comparison of Dynamics\nWe shall compare the long-time averages evaluated by computing solution trajec-\ntories for Nosé-Hoover, Langevin and Nosé-Hoover-Langevin dynamics. We will\nlook at the impact that the choice of dynamics (and associated parameters) has on\nthe rate of convergence of averages in time, as well as the perturbation introduced\ninto dynamical quantities (such as autocorrelation functions).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 371,
      "printed_page": 350,
      "text": "350\n8\nExtended Variable Methods\nby an approximate series expansion. In modern computer architectures, the number\nof force evaluations is responsible for the overwhelming majority of the time spent\nper iteration.\nWe can apply the splitting approach considered in Chap. 7 to integrate equations\n(8.27)–(8.29). One suitable choice of algorithm that we shall use in the following\nsubsection is\npnC1=2 D pn \u0003 .h=2/rU.qn/;\nqnC1=2 D qn C .h=2/M\u00021pnC1=2;\n\u0012nC1=2 D \u0012n C .h=2/\u0006\u00021 h\npT\nnC1=2M\u00021pnC1=2 \u0003 NdkBT\ni\n;\nQpnC1=2 D e\u0002.h=2/\u0012nC1=2pnC1=2;\nO\u0012nC1=2 D e\u0002\nh\u0012nC1=2 C \u0018Rn;\nOpnC1=2 D e\u0002.h=2/O\u0012nC1=2 QpnC1=2;\n\u0012nC1 D O\u0012nC1=2 C .h=2/\u0006\u00021 h\nOpT\nnC1=2M\u00021OpnC1=2 \u0003 NdkBT\ni\n;\nqnC1 D qnC1=2 C .h=2/M\u00021OpnC1=2;\npnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/;\nwhere \u0018 D\np\nkBT\u0006\u00021.1 \u0003 exp.\u00032\nh// and Rn is a normal random number with\nunit variance and zero mean.\nThis numerical method requires only one evaluation of the force per timestep. It\nalso reduces to a Nosé-Hoover integrator when \n D 0, and as it solves the Ornstein-\nUhlenbeck process exactly, it is stable under the large (or inﬁnite) limit of friction.\n8.4.3\nNumerical Comparison of Dynamics\nWe shall compare the long-time averages evaluated by computing solution trajec-\ntories for Nosé-Hoover, Langevin and Nosé-Hoover-Langevin dynamics. We will\nlook at the impact that the choice of dynamics (and associated parameters) has on\nthe rate of convergence of averages in time, as well as the perturbation introduced\ninto dynamical quantities (such as autocorrelation functions).\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "R_n独立标准正态；h≥0、β,Q>0、γ≥0用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。"
  ],
  "issues": [],
  "statement_scope": "实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。",
  "lean_decl": "MD.Ch08.nhlOU",
  "lean_declarations": [
    "MD.Ch08.nhlOU",
    "MD.Ch08.forceKick",
    "MD.Ch08.bathDamping",
    "MD.Ch08.nhlStep",
    "MD.Ch08.standardNormalSequence"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhlOU (β Q γ h R : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, Real.exp (-γ*h)*z.2 + Real.sqrt ((1-Real.exp (-2*γ*h))/(β*Q))*R)
def forceKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i-h*gradient U z.1.1 i), z.2)
def bathDamping (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i), z.2)
def nhlStep (invm : Vec n) (U : Vec n → ℝ) (β Q γ h R : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  forceKick U (h/2) ∘ nhDrift invm (h/2) ∘ nhFeedback invm β Q (h/2) ∘ bathDamping (h/2) ∘
  nhlOU β Q γ h R ∘ bathDamping (h/2) ∘ nhFeedback invm β Q (h/2) ∘ nhDrift invm (h/2) ∘ forceKick U (h/2)
def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧ ∀ k, HasLaw (R k) (gaussianReal 0 1) P
```

## MD-8.4.1-NHLWeakStationary
```json
{
  "source_id": "MD-8.4.1-NHLWeakStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.4.1",
  "printed_page": "345–346",
  "pdf_page": "366–367",
  "statement_latex": "The NHL method preserves the extended canonical distribution ρ_β exp(-βμξ²/2), by adding an OU thermostat in ξ.",
  "statement_verbatim": "8.4\nErgodic Stochastic-Dynamic Thermostats\n345\nThis means that we have built one of our two vectors. The second follows as a linear\ncombination of the others:\nQF D b0 \u0003 \u0012 QG \u0003 .g \u0003 \n\u0012/\u0007\u00021b1:\nut\nThe fact that the Hörmander condition holds is, as we know from Chap. 6, only\npart of the story. However based on known results for Langevin dynamics, we\nconjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U\nis sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.\nperiodic boundary conditions are employed. However we stress that each possible\nmethod will ultimately need to be carefully and systematically checked to verify the\nergodic properties.\n8.4.1\nNosé-Hoover-Langevin: An Ergodic Weakly Coupled\nThermostat\nThe Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the\n“chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian\ndistribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The\nmethod was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the\nconﬁrmation of the Hörmander condition), for a problem with harmonic internal\ninteractions, was given in [226] and we roughly follow the treatment from this paper.\nThe Nosé-Hoover-Langevin equations are\ndq D M\u00021pdt;\n(8.27)\ndp D \u0003rU.q/dt \u0003 \u0012pdt;\n(8.28)\nd\u0012 D \u0006\u00021ŒpTM\u00021p \u0003 NdkBT\tdt \u0003 \n\u0012dt C\np\n2kBT\n\u0006\u00021dW;\n(8.29)\nwhere .q; p/ 2 D with \u0012 2 R. Let us emphasize that the principal features of this\nthermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates\na single Wiener process, (3) it has two free parameters \n and \u0006.\nLet us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a\nthermostat. We observe that we have already shown that the Nosé-Hoover method\npreserves the extended canonical distribution \u0005ˇ exp.\u0003ˇ\u0006\u00122=2/. Therefore, by the\nadditivity property, all that is needed is to show that the additional part\nd\u0012 D \u0003\n\u0012dt C\np\n2kBT\n\u0006\u00021dW\n\n346\n8\nExtended Variable Methods\npreserves O\u0005.\u0012/ D exp.\u0003ˇ\u0006\u00122=2/. However, this is obvious from our earlier\ninvestigations of Ornstein-Uhlenbeck equations.\nIn order to show that this thermostat is ergodic, we need to demonstrate that\nthe assumptions presented in Sect. 6.4.4 are valid. Assumption 1(ii) requires us to\nverify that a Hörmander condition (see Deﬁnition 6.1) holds for the Nosé-Hoover-\nLangevin system. Because of the complexity of the high order commutators, we\nwill work here with the assumption of a quadratic potential in the physical model.\nIn some sense this is the most difﬁcult case for a thermostat, but paradoxically, the\nassumption facilitates the mathematical analysis. We will assume throughout the\nfollowing that Nd D Nc, i.e. that there are no constraints in the system. Our potential\nwill therefore be assumed to be\nU.q/ D 1\n2qTAq;\nfor A a symmetric, positive deﬁnite Nc \u0004 Nc matrix, with\nrU.q/ D Aq:\nWe will further assume M D I. If this is not the case, then one may introduce the\nrescaling Qq D M\u00021=2q; Qp D M1=2p in order to rewrite the system in a form that does\nnot involve M. Thus the system under study is\ndq D pdt;\n(8.30)\ndp D \u0003Aqdt \u0003 \u0012pdt;\n(8.31)\nd\u0012 D \u0006\u00021Œkpk2 \u0003 NdkBT\tdt \u0003 \n\u0012dt C \u0007dW:\n(8.32)\nLet u1; u2; : : : ; uNc be the eigenvectors of A with \u00131; : : : ; \u0013Nc the corresponding\neigenvalues. Observe that if q0 \u0002uk D p0 \u0002uk D 0, then, using (8.30)–(8.31), we have\nat this point\nuk \u0002 p D 0;\nuk \u0002 Œ\u0003Aq \u0003 \u0012p\t D \u0003\u0013kuk \u0002 q D 0;\nwhich implies that Vk D f.q; p/juk \u0002 q D 0; uk \u0002 p D 0g is an invariant submanifold.\nTherefore we must require that uk \u0002 q and uk \u0002 p do not simultaneously vanish, that\nis, .q; p/ 2 D D R2Nc n SNc\nkD1 Vk.\nTheorem 8.1 If A is symmetric positive deﬁnite and has distinct eigenvalues, then\n(8.30)–(8.32) satisﬁes the Hörmander condition on D \u0004 R.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 366,
      "printed_page": 345,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n345\nThis means that we have built one of our two vectors. The second follows as a linear\ncombination of the others:\nQF D b0 \u0003 \u0012 QG \u0003 .g \u0003 \n\u0012/\u0007\u00021b1:\nut\nThe fact that the Hörmander condition holds is, as we know from Chap. 6, only\npart of the story. However based on known results for Langevin dynamics, we\nconjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U\nis sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.\nperiodic boundary conditions are employed. However we stress that each possible\nmethod will ultimately need to be carefully and systematically checked to verify the\nergodic properties.\n8.4.1\nNosé-Hoover-Langevin: An Ergodic Weakly Coupled\nThermostat\nThe Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the\n“chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian\ndistribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The\nmethod was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the\nconﬁrmation of the Hörmander condition), for a problem with harmonic internal\ninteractions, was given in [226] and we roughly follow the treatment from this paper.\nThe Nosé-Hoover-Langevin equations are\ndq D M\u00021pdt;\n(8.27)\ndp D \u0003rU.q/dt \u0003 \u0012pdt;\n(8.28)\nd\u0012 D \u0006\u00021ŒpTM\u00021p \u0003 NdkBT\tdt \u0003 \n\u0012dt C\np\n2kBT\n\u0006\u00021dW;\n(8.29)\nwhere .q; p/ 2 D with \u0012 2 R. Let us emphasize that the principal features of this\nthermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates\na single Wiener process, (3) it has two free parameters \n and \u0006.\nLet us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a\nthermostat. We observe that we have already shown that the Nosé-Hoover method\npreserves the extended canonical distribution \u0005ˇ exp.\u0003ˇ\u0006\u00122=2/. Therefore, by the\nadditivity property, all that is needed is to show that the additional part\nd\u0012 D \u0003\n\u0012dt C\np\n2kBT\n\u0006\u00021dW\n"
    },
    {
      "pdf_page": 367,
      "printed_page": 346,
      "text": "346\n8\nExtended Variable Methods\npreserves O\u0005.\u0012/ D exp.\u0003ˇ\u0006\u00122=2/. However, this is obvious from our earlier\ninvestigations of Ornstein-Uhlenbeck equations.\nIn order to show that this thermostat is ergodic, we need to demonstrate that\nthe assumptions presented in Sect. 6.4.4 are valid. Assumption 1(ii) requires us to\nverify that a Hörmander condition (see Deﬁnition 6.1) holds for the Nosé-Hoover-\nLangevin system. Because of the complexity of the high order commutators, we\nwill work here with the assumption of a quadratic potential in the physical model.\nIn some sense this is the most difﬁcult case for a thermostat, but paradoxically, the\nassumption facilitates the mathematical analysis. We will assume throughout the\nfollowing that Nd D Nc, i.e. that there are no constraints in the system. Our potential\nwill therefore be assumed to be\nU.q/ D 1\n2qTAq;\nfor A a symmetric, positive deﬁnite Nc \u0004 Nc matrix, with\nrU.q/ D Aq:\nWe will further assume M D I. If this is not the case, then one may introduce the\nrescaling Qq D M\u00021=2q; Qp D M1=2p in order to rewrite the system in a form that does\nnot involve M. Thus the system under study is\ndq D pdt;\n(8.30)\ndp D \u0003Aqdt \u0003 \u0012pdt;\n(8.31)\nd\u0012 D \u0006\u00021Œkpk2 \u0003 NdkBT\tdt \u0003 \n\u0012dt C \u0007dW:\n(8.32)\nLet u1; u2; : : : ; uNc be the eigenvectors of A with \u00131; : : : ; \u0013Nc the corresponding\neigenvalues. Observe that if q0 \u0002uk D p0 \u0002uk D 0, then, using (8.30)–(8.31), we have\nat this point\nuk \u0002 p D 0;\nuk \u0002 Œ\u0003Aq \u0003 \u0012p\t D \u0003\u0013kuk \u0002 q D 0;\nwhich implies that Vk D f.q; p/juk \u0002 q D 0; uk \u0002 p D 0g is an invariant submanifold.\nTherefore we must require that uk \u0002 q and uk \u0002 p do not simultaneously vanish, that\nis, .q; p/ 2 D D R2Nc n SNc\nkD1 Vk.\nTheorem 8.1 If A is symmetric positive deﬁnite and has distinct eigenvalues, then\n(8.30)–(8.32) satisﬁes the Hörmander condition on D \u0004 R.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。",
  "lean_decl": "MD.Ch08.weakStationaryNHL",
  "lean_declarations": [
    "MD.Ch08.weakStationaryNHL",
    "MD.Ch08.nhlWeakStationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def weakStationaryNHL (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (ρ : Phase n × ℝ → ℝ) : Prop :=
  probabilityDensity volume ρ ∧ ∀ f : Phase n × ℝ → ℝ,
    ContDiff ℝ ∞ f → HasCompactSupport f →
    (∫ z, nhlGenerator invm U β Q γ f z * ρ z) = 0
theorem nhlWeakStationary (invm : Vec n) (U : Vec n → ℝ) (β Q γ Z : ℝ)
    (hp : thermostatParameters invm β Q) (hγ : 0 < γ) (hZ : 0 < Z)
    (hU : ContDiff ℝ 2 U) (hi : Integrable (nhWeight invm U β Q))
    (hpart : ∫ z, nhWeight invm U β Q z = Z) :
    weakStationaryNHL invm U β Q γ (fun z ↦ nhWeight invm U β Q z/Z) := by
  sorry
```

## MD-8.4.3-PreEquilibriumMeans
```json
{
  "source_id": "MD-8.4.3-PreEquilibriumMeans",
  "kind": "definition",
  "label": null,
  "section": "8.4.3",
  "printed_page": "354–355",
  "pdf_page": "375–376",
  "statement_latex": "θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.",
  "statement_verbatim": "354\n8\nExtended Variable Methods\n0\nTime\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\n0\nTime\nVelocity auto-correlation\n0\n0.02\n0.04\n0.06\n0.08\n0.10\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\nNosé-Hoover & Nosé-Hoover-Langevin\nLangevin\nFig. 8.4 The computed velocity auto-correlation functions are plotted for Nosé-Hoover and Nosé-\nHoover-Langevin dynamics (left), where we overlay plots from simulations using all possible\nparameter sets where \n 2 f0; 0:05; 0:5; 5; 50g and \u0006 2 f20; 2; 0:2; 0:02g. We additionally plot the\nsame result for Langevin dynamics (right), overlaying curves for \n 2 f0:05; 0:1; 0:2; : : : ; 51:2g,\nwhere high to low friction is plotted from red to blue respectively. The salient qualitative features\nof the results remain qualitatively unchanged when using different values of the parameters for the\nNosé-Hoover thermostats (see inset) whereas the Langevin thermostat has a much harsher effect\non the dynamics, with signiﬁcant differences as the friction is increased\nIt may seem that the difference between Nosé-Hoover-Langevin and Langevin\ndynamics is a technical one that essentially hinges on choice of parameters. Both\nmethods are ergodic and it may appear that by simply choosing a small value\nof friction in Langevin dynamics, we can match the behavior of Nosé-Hoover-\nLangevin to any desired accuracy. However, this is most deﬁnitely not the case, as a\ncareful analysis of Figs. 8.3 and 8.4 reveals. If an accurate velocity autocorrelation\nfunction is required, then the friction parameter in Langevin dynamics needs to be\nchosen very small (much less than \n D 0:1), see Fig. 8.4. But if the friction is\nchosen in this way, the convergence to canonical equilibrium is drastically impaired\n(Figs. 8.2 and 8.3). By contrast it is relatively easy to ﬁnd parameter choices\nfor Nosé-Hoover-Langevin which provide quite rapid convergence of canonical\naverages while preserving the accuracy of autocorrelation functions.\nThe convergence to equilibrium for Nosé-Hoover-Langevin is difﬁcult to cal-\nculate analytically. The only existing analysis is that of [225] which restricts\nconsideration to the convergence of the kinetic energy. It turns out that one may\nobtain a nonlinear system in terms of the following two variables:\nN\u000e.t/ D\nZ\nD\u0003R\n2K\u0005.q; p; \u0012; t/d!d\u0012;\n\n8.4\nErgodic Stochastic-Dynamic Thermostats\n355\nwhere K is the kinetic energy, and the mean auxiliary variable \u0012\nN\u0012.t/ D\nZ\nD\u0003R\n\u0012\u0005.q; p; \u0012; t/d!d\u0012:\n\u0005 that appears here is the normalized pre-equilibrium density which evolves\naccording to the Fokker-Planck equation of the extended Nosé-Hoover-Langevin\nsystem.\nIt is then possible to perform a local stability analysis to characterize the\nconvergence to equilibrium of N\u000e and N\u0012 to the equilibrium .NdkBT; 0/. Although\nthe analysis makes certain stringent assumptions they are veriﬁed in [225] for a\nLennard-Jones molecular system.\n8.4.4\nVelocity Rescaling\nAn alternative stochastic-dynamical method for thermostatting molecular dynamics\nis the stochastic velocity rescaling method proposed by Bussi and collaborators [60,\n63] and somewhat generalized in [225]. The equations are (for the case M D I,\nconsidered for simplicity):\ndq D pdt\ndp D \u0003rU.q/ dt \u0003 \f.K/p dt C\np\n2kBT˚.K/pdW;\nwhere W.t/ is a single Wiener process, ˚ is an arbitrary smooth positive function\nand \f is deﬁned by\n\f.K/\ndef\nD .2K \u0003 .1 C Nd/kBT/˚.K/ \u0003 2kBTK d˚\ndK :\nWith these deﬁnitions, the method preserves the canonical probability density \u0005ˇ.\nWe do not prove the ergodicity of the method here, but expect that it would follow\nby an analysis similar to that given above for Nosé-Hoover-Langevin.\nThe original proposal of Bussi et al. had\n˚.K/ D \nVR\n2K ;\nso that\n\f.K/ D .1 \u0003 .Nd \u0003 1/kBT=2K/ \nVR;\nwhere \nVR is a positive constant.\nFor the more general case, the required conditions on ˚ are as follows:\nK˚.K/ is bounded as K ! 0;\n˚.K/ grows at most polynomially as K ! 1:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 375,
      "printed_page": 354,
      "text": "354\n8\nExtended Variable Methods\n0\nTime\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\n0\nTime\nVelocity auto-correlation\n0\n0.02\n0.04\n0.06\n0.08\n0.10\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\nNosé-Hoover & Nosé-Hoover-Langevin\nLangevin\nFig. 8.4 The computed velocity auto-correlation functions are plotted for Nosé-Hoover and Nosé-\nHoover-Langevin dynamics (left), where we overlay plots from simulations using all possible\nparameter sets where \n 2 f0; 0:05; 0:5; 5; 50g and \u0006 2 f20; 2; 0:2; 0:02g. We additionally plot the\nsame result for Langevin dynamics (right), overlaying curves for \n 2 f0:05; 0:1; 0:2; : : : ; 51:2g,\nwhere high to low friction is plotted from red to blue respectively. The salient qualitative features\nof the results remain qualitatively unchanged when using different values of the parameters for the\nNosé-Hoover thermostats (see inset) whereas the Langevin thermostat has a much harsher effect\non the dynamics, with signiﬁcant differences as the friction is increased\nIt may seem that the difference between Nosé-Hoover-Langevin and Langevin\ndynamics is a technical one that essentially hinges on choice of parameters. Both\nmethods are ergodic and it may appear that by simply choosing a small value\nof friction in Langevin dynamics, we can match the behavior of Nosé-Hoover-\nLangevin to any desired accuracy. However, this is most deﬁnitely not the case, as a\ncareful analysis of Figs. 8.3 and 8.4 reveals. If an accurate velocity autocorrelation\nfunction is required, then the friction parameter in Langevin dynamics needs to be\nchosen very small (much less than \n D 0:1), see Fig. 8.4. But if the friction is\nchosen in this way, the convergence to canonical equilibrium is drastically impaired\n(Figs. 8.2 and 8.3). By contrast it is relatively easy to ﬁnd parameter choices\nfor Nosé-Hoover-Langevin which provide quite rapid convergence of canonical\naverages while preserving the accuracy of autocorrelation functions.\nThe convergence to equilibrium for Nosé-Hoover-Langevin is difﬁcult to cal-\nculate analytically. The only existing analysis is that of [225] which restricts\nconsideration to the convergence of the kinetic energy. It turns out that one may\nobtain a nonlinear system in terms of the following two variables:\nN\u000e.t/ D\nZ\nD\u0003R\n2K\u0005.q; p; \u0012; t/d!d\u0012;\n"
    },
    {
      "pdf_page": 376,
      "printed_page": 355,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n355\nwhere K is the kinetic energy, and the mean auxiliary variable \u0012\nN\u0012.t/ D\nZ\nD\u0003R\n\u0012\u0005.q; p; \u0012; t/d!d\u0012:\n\u0005 that appears here is the normalized pre-equilibrium density which evolves\naccording to the Fokker-Planck equation of the extended Nosé-Hoover-Langevin\nsystem.\nIt is then possible to perform a local stability analysis to characterize the\nconvergence to equilibrium of N\u000e and N\u0012 to the equilibrium .NdkBT; 0/. Although\nthe analysis makes certain stringent assumptions they are veriﬁed in [225] for a\nLennard-Jones molecular system.\n8.4.4\nVelocity Rescaling\nAn alternative stochastic-dynamical method for thermostatting molecular dynamics\nis the stochastic velocity rescaling method proposed by Bussi and collaborators [60,\n63] and somewhat generalized in [225]. The equations are (for the case M D I,\nconsidered for simplicity):\ndq D pdt\ndp D \u0003rU.q/ dt \u0003 \f.K/p dt C\np\n2kBT˚.K/pdW;\nwhere W.t/ is a single Wiener process, ˚ is an arbitrary smooth positive function\nand \f is deﬁned by\n\f.K/\ndef\nD .2K \u0003 .1 C Nd/kBT/˚.K/ \u0003 2kBTK d˚\ndK :\nWith these deﬁnitions, the method preserves the canonical probability density \u0005ˇ.\nWe do not prove the ergodicity of the method here, but expect that it would follow\nby an analysis similar to that given above for Nosé-Hoover-Langevin.\nThe original proposal of Bussi et al. had\n˚.K/ D \nVR\n2K ;\nso that\n\f.K/ D .1 \u0003 .Nd \u0003 1/kBT=2K/ \nVR;\nwhere \nVR is a positive constant.\nFor the more general case, the required conditions on ˚ are as follows:\nK˚.K/ is bounded as K ! 0;\n˚.K/ grows at most polynomially as K ! 1:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "两项瞬时分布平均及随时间非负归一密度的资格；局部稳定性和闭合方程未覆盖。",
  "lean_decl": "MD.Ch08.meanKineticTwice",
  "lean_declarations": [
    "MD.Ch08.meanKineticTwice",
    "MD.Ch08.meanBath",
    "MD.Ch08.preEquilibriumDensity"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  ∀ t, 0 ≤ t → probabilityDensity volume (ρ t)
```
