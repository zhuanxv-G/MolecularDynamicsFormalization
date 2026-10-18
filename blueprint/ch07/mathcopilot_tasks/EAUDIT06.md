# EAUDIT06 第7章修改后陈述复审

## MD-7.8.1-OverdampedFirstOrderCaution
```json
{
  "source_id": "MD-7.8.1-OverdampedFirstOrderCaution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.1",
  "printed_page": "295",
  "pdf_page": "316",
  "statement_latex": "When considering the limit of infinite friction in the $[XYZ]$ schemes we obtain an inconsistent discretization. Hence these first-order schemes will be unsuitable for the integration of overdamped Langevin dynamics.\nThis is not always the case for first order schemes, however. For example the scheme denoted $[AOAB]$ is consistent with the dynamics, and may be used for integrating the overdamped ($\\gamma=\\infty$) Langevin equation.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 316,
      "printed_page": 295,
      "text": "7.8\nFirst Order Schemes\n295\nappear. However, if we instead set # D #2.q/, then\nh#2.q/f1.q; p/i D ˙ˇ\n2\n˝\n.\nU.q/ \u0003 c/#2.q/ ˙ pTM\u00021rU.q/#2.q/\n˛\nD ˙\nˇ\n2 h.U.q/ \u0003 hU.q/i/#2.q/i ;\nin which case our correction becomes O.\n/. This is potentially disastrous if we\nchoose the friction to be large (consider \n\u0005 h\u00021), as the error introduced\nthrough discretization will dominate the true average to be sampled. Examining\nthe algorithms themselves this is unsurprising, as although we have integrated\nthe Ornstein-Uhlenbeck process exactly, when considering the limit of inﬁnite\nfriction in the \u0002XYZ\u0003 schemes we obtain an inconsistent discretization. Hence these\nﬁrst-order schemes will be unsuitable for the integration of overdamped Langevin\ndynamics.\nThis is not always the case for ﬁrst order schemes, however. For example the\nscheme denoted \u0002AOAB\u0003 is consistent with the dynamics, and may be used for\nintegrating the overdamped (\n D 1) Langevin equation.\n7.8.2\nNumerical Experiment\nLet us consider testing the computed ﬁrst order corrections on a one dimensional\nexample. Let M D ˇ D 1 and deﬁne the biased double-well potential as\nU.q/ D .q2 \u0003 1/2 C q=2:\nWe shall consider computing the average of a speciﬁc observable #.q; p/, and\nestimating the error due to discretization using the correction functions given\nin (7.25), where we choose the observable\n#.q; p/ D p2 \u0003 qU0.q/ C 2qp;\nh#i D 0:\nThe low dimensionality of the problem and the simplicity of the observable and\npotential energy function make resolving the perfect sampling bias to leading order\nan easy task, allowing us to give a good estimate (to order h2) of the discretization\nerror. In Fig. 7.4 we plot the results of h#ih computed via numerical experiment,\nusing each of the six ﬁrst order schemes at either \n D 1 or \n D 2, and compare\nthem to our ﬁrst order prediction\nh#ih \u0007 h#i C hhf1#i:\nThe numerical experiment at each timestep is averaged from 16 independent\nexperiments, each running over a time interval of 108. The results match our\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。",
    "29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。"
  ],
  "issues": [],
  "statement_scope": "固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。",
  "lean_decl": "MD.Ch07.aoab",
  "lean_declarations": [
    "MD.Ch07.aoab",
    "MD.Ch07.aoabInfiniteFriction",
    "MD.Ch07.aoabFrictionLimit"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "原文精确摘录恢复完整“Examining …”句；另登记六种XYZ不一致性和AOAB带有效时间尺度的一致性义务，不能将aoabFrictionLimit重命名即视为已完成。",
      "actual_scope": "固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：固定h>0及固定噪声的AOAB逐路径大摩擦单步极限，带正质量；六种XYZ不一致性及有效时标一致性未覆盖。"
  ]
}
```
```lean
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
    Filter.Tendsto (fun γ : ℝ ↦ aoab m U γ θ h R x) Filter.atTop (𝓝 (aoabInfiniteFriction m U θ h R x)) := by
  sorry
```

## MD-7.8.2-BiasedDoubleWellExact
```json
{
  "source_id": "MD-7.8.2-BiasedDoubleWellExact",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.2",
  "printed_page": "295–297",
  "pdf_page": "316–318",
  "statement_latex": "Let $M=\\beta=1$ and define the biased double-well potential as\n\\[U(q)=(q^2-1)^2+q/2.\\]\nWe choose the observable\n\\[\\vartheta(q,p)=p^2-qU'(q)+2qp,\\qquad\\langle\\vartheta\\rangle=0.\\]\nThe first order correction term for the $[BOA]$ scheme is given by the formula\n\\[\\langle\\vartheta f_{1,[BOA]}\\rangle=\\frac\\beta2\\int_{\\mathcal D}(p^2-qU'(q)+2qp)(pU'(q)+\\gamma U(q)-c)\\rho_\\beta d\\omega\n=\\frac1\\beta+\\frac\\gamma2\\langle U\\rangle-\\frac{\\gamma\\beta}{2}\\langle qUU'\\rangle=\\frac{2-\\gamma}{2\\beta}.\\]\nHence for the critical value of $\\gamma=2$, the leading order correction will be zero, giving\n\\[\\langle\\vartheta\\rangle_h^{[BOA]}=\\langle\\vartheta\\rangle+O(h^2).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 316,
      "printed_page": 295,
      "text": "7.8\nFirst Order Schemes\n295\nappear. However, if we instead set # D #2.q/, then\nh#2.q/f1.q; p/i D ˙ˇ\n2\n˝\n.\nU.q/ \u0003 c/#2.q/ ˙ pTM\u00021rU.q/#2.q/\n˛\nD ˙\nˇ\n2 h.U.q/ \u0003 hU.q/i/#2.q/i ;\nin which case our correction becomes O.\n/. This is potentially disastrous if we\nchoose the friction to be large (consider \n\u0005 h\u00021), as the error introduced\nthrough discretization will dominate the true average to be sampled. Examining\nthe algorithms themselves this is unsurprising, as although we have integrated\nthe Ornstein-Uhlenbeck process exactly, when considering the limit of inﬁnite\nfriction in the \u0002XYZ\u0003 schemes we obtain an inconsistent discretization. Hence these\nﬁrst-order schemes will be unsuitable for the integration of overdamped Langevin\ndynamics.\nThis is not always the case for ﬁrst order schemes, however. For example the\nscheme denoted \u0002AOAB\u0003 is consistent with the dynamics, and may be used for\nintegrating the overdamped (\n D 1) Langevin equation.\n7.8.2\nNumerical Experiment\nLet us consider testing the computed ﬁrst order corrections on a one dimensional\nexample. Let M D ˇ D 1 and deﬁne the biased double-well potential as\nU.q/ D .q2 \u0003 1/2 C q=2:\nWe shall consider computing the average of a speciﬁc observable #.q; p/, and\nestimating the error due to discretization using the correction functions given\nin (7.25), where we choose the observable\n#.q; p/ D p2 \u0003 qU0.q/ C 2qp;\nh#i D 0:\nThe low dimensionality of the problem and the simplicity of the observable and\npotential energy function make resolving the perfect sampling bias to leading order\nan easy task, allowing us to give a good estimate (to order h2) of the discretization\nerror. In Fig. 7.4 we plot the results of h#ih computed via numerical experiment,\nusing each of the six ﬁrst order schemes at either \n D 1 or \n D 2, and compare\nthem to our ﬁrst order prediction\nh#ih \u0007 h#i C hhf1#i:\nThe numerical experiment at each timestep is averaged from 16 independent\nexperiments, each running over a time interval of 108. The results match our\n"
    },
    {
      "pdf_page": 317,
      "printed_page": 296,
      "text": "296\n7\nNumerical Methods for Stochastic Molecular Dynamics\n100\n10-1\n10-2\n10-3\n100\n10-1\n10-2\n10-3\nAbsolute error\nTimestep\n0.05\n0.1\n0.2\nAbsolute error\nTimestep\n0.05\n0.1\n0.2\nTimestep\n0.05\n0.1\n0.2\nTimestep\n0.05\n0.1\n0.2\nObserved average\n-0.6\n-0.4\n-0.2\n0\n0.2\n0.4\n0.6\nObserved average\n-0.6\n-0.4\n-0.2\n0\n0.2\n0.4\n0.6\nABO\nBAO\nOBA\nOAB\nAOB\nBOA\nSecond-order line\nFirst-order lines\n=1\n=1\n=2\n=2\nFig. 7.4 We plot the absolute error in the computed value of h#ih (left) and the observed value of\nh#ih (right) as symbols, while our prediction computed using (7.25) is plotted as a solid line. For\n\n D 1 we ﬁnd ﬁrst order behavior (as expected), but for \n D 2 two methods exhibit higher order\nbehavior. This is a special case for this observable that can be understood through our analysis\nprediction extremely well, though at large stepsize there is evidence of higher order\nbehavior O.h2/ having an effect on the computed average, evident by the divergence\naway from our prediction line.\nThe \u0002AOB\u0003 and \u0002BOA\u0003 schemes also demonstrate a surprising second order\nbehavior for the experiments at \n D 2, that we would not necessarily expect. This\nis due to a felicitous choice of our observable, where the leading order correction\ncan be shown to be zero. The fact that both of these schemes share this property is\nunsurprising, as f1;\u0002AOB\u0003 D \u0003f1;\u0002BOA\u0003, although for a general observable we would\nnot expect second order averages for these methods. We could similarly construct\nspecial cases for other observables that would give higher order behavior for other\nschemes.\nThe ﬁrst order correction term for the \u0002BOA\u0003 scheme is given by the formula\nh#f1;\u0002BOA\u0003i D ˇ\n2\nZ\nD\n\u0004\np2 \u0003 qU0.q/ C 2qp\n\u0005\u0004\npU0.q/ C \nU.q/ \u0003 c\n\u0005\n\u0005ˇd!;\nD 1\nˇ C \n2 hUi \u0003 \nˇ\n2 hqUU0i;\nD .2 \u0003 \n/\n2ˇ\n:\n"
    },
    {
      "pdf_page": 318,
      "printed_page": 297,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n297\nHence for the critical value of \n D 2, the leading order correction will be zero,\ngiving\nh#i\u0002BOA\u0003\nh\nD h#i C O.h2/:\nThis is exactly the behavior we see in Fig. 7.4.\n7.9\nError Expansion for Symmetric Langevin Methods\nOf particular interest for sampling the canonical distribution are symmetric\nLangevin methods. We believe these are likely to be the most useful class of\nmethods for practitioners, as by symmetrizing the expansion the odd order terms\nin (7.16) vanish identically using the Jacobi identity in the BCH expansions. This\nimplies that a symmetric scheme gives a second order error in computed averages.\nMany symmetric methods can be constructed that require only one evaluation of the\nforce per iteration (effectively making them as inexpensive as a ﬁrst order method).\nIn order to simplify the algebra, we will use M D I throughout this section,\nwhich will not alter the major results and amounts to a linear change of variables.\nWe shall consider general symmetric schemes of the form \u0002XYZYX\u0003, and perform\na similar analysis to the previous section. The terms appearing in the expansions\nwill be signiﬁcantly more complex than those encountered in ﬁrst order methods.\nWe make use of the following proposition for symmetric compositions:\nProposition 7.1 Let L\u0004\nX, L\u0004\nY and L\u0004\nZ be general operators to which BCH can be\napplied, then deﬁning\neh OL\u0004 D e\nh\n2 L\u0004\nXe\nh\n2 L\u0004\nYehL\u0004\nZe\nh\n2 L\u0004\nYe\nh\n2 L\u0004\nX;\n(7.26)\ngives\nOL\u0004 D L\u0004\n0 C h2L\u0004\n2 C O.h4/;\nwhere\nL\u0004\n0 DL\u0004\nX C L\u0004\nY C L\u0004\nZ;\nL\u0004\n2 D 1\n12\n\u0006\nŒL\u0004\nZ; L\u0004\nZ; L\u0004\nY\t C ŒL\u0004\nY C L\u0004\nZ; L\u0004\nY C L\u0004\nZ; L\u0004\nX\t\n\u0007\n\u0003 1\n24\n\u0006\nŒL\u0004\nY; L\u0004\nY; L\u0004\nZ\t C ŒL\u0004\nX; L\u0004\nX; L\u0004\nY C L\u0004\nZ\t\n\u0007\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "保留数值例中的精确数学积分和解析消项；原文虽起初β=1，推导中保留β，本条正β形式需同样积分分部理论。",
    "中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。",
    "29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。"
  ],
  "issues": [],
  "statement_scope": "双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。",
  "lean_decl": "MD.Ch07.biasedDoubleWell",
  "lean_declarations": [
    "MD.Ch07.biasedDoubleWell",
    "MD.Ch07.doubleWellObservable",
    "MD.Ch07.doubleWellGibbs",
    "MD.Ch07.doubleWellBOACorrection",
    "MD.Ch07.doubleWellExact",
    "MD.Ch07.doubleWellCritical",
    "MD.Ch07.doubleWellCritical_integral"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "明确标[EXTRA]任意β>0推广；将γ=2时实际积分为零列为与doubleWellExact相连的推论，并把O(h²)余项及中间积分等式登记为未形式化，不能用ring恒等式代替。",
      "actual_scope": "双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：双阱Gibbs的两个精确积分及γ=2时第二积分消项；推广到任意β>0；真实算法O(h²)和中间积分推导未覆盖。"
  ]
}
```
```lean
def biasedDoubleWell (q : ℝ) : ℝ := (q^2-1)^2+q/2
def doubleWellObservable (x : ℝ × ℝ) : ℝ := x.2^2-x.1*deriv biasedDoubleWell x.1+2*x.1*x.2
def doubleWellGibbs (β : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-β*(x.2^2/2+biasedDoubleWell x.1))
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def doubleWellBOACorrection (β γ : ℝ) (x : ℝ × ℝ) : ℝ :=
  β/2*(x.2*deriv biasedDoubleWell x.1+γ*biasedDoubleWell x.1-
    γ*(∫ y, biasedDoubleWell y.1 ∂doubleWellGibbs β))
theorem doubleWellExact (β γ : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x ∂doubleWellGibbs β) = 0 ∧
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β γ x ∂doubleWellGibbs β) = (2-γ)/(2*β) := by
  sorry
theorem doubleWellCritical (β : ℝ) : (2-(2 : ℝ))/(2*β) = 0 := by ring

theorem doubleWellCritical_integral (β : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β 2 x ∂doubleWellGibbs β) = 0 := by
  simpa using (doubleWellExact β 2 hβ).2
```

## MD-7.9-EvenDensityPerturbation
```json
{
  "source_id": "MD-7.9-EvenDensityPerturbation",
  "kind": "unnumbered_claim",
  "label": "(7.27)–(7.28)",
  "section": "7.9",
  "printed_page": "298",
  "pdf_page": "319",
  "statement_latex": "If we suppose that the odd order correction functions are zero, then we are left with\n\\[\\widehat\\rho=\\rho_\\beta(1+h^2f_2+h^4f_4+\\cdots),\\tag{7.27}\\]\nwhere each $\\langle f_i\\rangle=0$ as usual. Equating the second order terms we obtain\n\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_2)=-\\mathcal L_2^\\dagger\\rho_\\beta.\\tag{7.28}\\]\nThe condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $\\mathcal L_2^\\dagger\\rho_\\beta$ integrates to zero.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 319,
      "printed_page": 298,
      "text": "298\n7\nNumerical Methods for Stochastic Molecular Dynamics\nFor a scheme \u0002XYZYX\u0003, we assume that each of the X, Y and Z characters in\nthe string are distinct, and correspond to one of the A, B or O pieces of our splitting\nstrategy. Thus we have L\u0004\n0 D L\u0004\nLD.\nEvidently, the scheme’s associated Fokker-Planck operator OL\u0004 no longer has a\nleading order term that is linear in the stepsize, so it makes sense to revise our\nassumption on the form of the scheme’s corresponding invariant measure, and\nreplace it with a series with solely even order terms. If we suppose that the odd\norder correction functions are zero, then we are left with\nO\u0005 D \u0005ˇ.1 C h2f2 C h4f4 C : : :/;\n(7.27)\nwhere each hfii D 0 as usual. Thus the stationarity equation OL\u0004 O\u0005 D 0 becomes\n\u0006\nL\u0004\nLD C h2L\u0004\n2 C : : :\n\u0007 \u0004\n\u0005ˇ C h2\u0005ˇf2 C : : :\n\u0005\nD 0:\nThe equation is satisﬁed at zeroth order, and equating the second order terms we\nobtain\nL\u0004\nLD\n\u0004\u0005ˇf2\n\u0005 D \u0003L\u0004\n2\u0005ˇ:\n(7.28)\nThe procedure then follows just as in the case of the ﬁrst order schemes. The\nform of the right-hand side L\u0004\n2\u0005ˇ will be dependent on the choice of the update\nscheme, and can be computed using the BCH formula using Proposition 7.1. More\ncomplicated symmetric schemes involving more than ﬁve stages can be utilized,\nbut these schemes may require more than one force evaluation per iteration, while\nincreasing the complexity of the PDE to solve.\nThe condition on the existence of such a solution requires us to use the Fredholm\nalternative, which requires us to verify that the inhomogeneous term L\u0004\n2\u0005ˇ integrates\nto zero.\n7.9.1\nCalculation of the Inhomogeneous Term\nThe computation of the right hand side in (7.28) is required in order to solve the\ncorresponding partial differential equation and obtain the leading order correction\nfunction for our symmetric scheme \u0002XYZYX\u0003. From the form of the L\u0004\n2 operator in\nProposition 7.1, we can see that our life is made considerably easier if we initially\nconsider methods \u0002OYZYO\u0003, which substitutes\nL\u0004\nX D L\u0004\nO;\nL\u0004\nY C L\u0004\nZ D L\u0004\nA C L\u0004\nB D L\u0004\nH;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。",
    "29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。"
  ],
  "issues": [],
  "statement_scope": "偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。",
  "lean_decl": "MD.Ch07.evenDensityExpansion",
  "lean_declarations": [
    "MD.Ch07.evenDensityExpansion",
    "MD.Ch07.evenPerturbationEquation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "保留抽象必要系数方程；单独登记零均值及Fredholm兼容性义务，并明确所需空间和域。此审校不增补证明。",
      "actual_scope": "偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。"
  ]
}
```
```lean
def evenDensityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) (k : ℕ) : Ω → ℝ :=
  if k = 0 then ρ else if Even k then fun x ↦ ρ x*f k x else 0
theorem evenPerturbationEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (hL1 : L 1 = 0) (hρ1 : ρ 1 = 0) (h2 : actionCoefficient L ρ 2 = 0) :
    L 0 (ρ 2) = -L 2 (ρ 0) := by
  have he : L 0 (ρ 2)+L 2 (ρ 0) = 0 := by
    simpa [actionCoefficient,Finset.sum_range_succ,hL1,hρ1] using h2
  exact eq_neg_of_add_eq_zero_left he
```
