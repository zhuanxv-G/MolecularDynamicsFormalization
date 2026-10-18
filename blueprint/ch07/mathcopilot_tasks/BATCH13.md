# BATCH13 第7章原文与陈述审校

## MD-7.8.1-FirstCorrectionTablePrinted
```json
{
  "source_id": "MD-7.8.1-FirstCorrectionTablePrinted",
  "kind": "unnumbered_claim",
  "label": "(7.25a)–(7.25d)",
  "section": "7.8.1",
  "printed_page": "293–294",
  "pdf_page": "314–315",
  "statement_latex": "In summary, we find that\n\\[f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25a}\\]\n\\[f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25b}\\]\n\\[f_{1,[AOB]}(q,p)=-\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25c}\\]\n\\[f_{1,[BOA]}(q,p)=\\frac\\beta2(\\gamma U(q)+p^TM^{-1}\\nabla U(q)-c),\\tag{7.25d}\\]\nwhere the constant $c$ is chosen to ensure each correction function has average 0, giving $c=\\gamma\\langle U(q)\\rangle$.",
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
    "六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。"
  ],
  "issues": [
    "已目视核对PDF315／印刷294：(7.25c)中动量梯度项印为负号，与同页上一段推导给出的正号及f_AOB=-f_BOA矛盾；修正为括号内正号。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
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
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 ∨ s = 4 then -β/2*(γ*U x.1-v-c)
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

## MD-7.8.1-PositionMomentumCorrections
```json
{
  "source_id": "MD-7.8.1-PositionMomentumCorrections",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.1",
  "printed_page": "294–295",
  "pdf_page": "315–316",
  "statement_latex": "If $\\vartheta=\\vartheta_1(p)$ then this $O(\\gamma)$ term will not trouble us, as\n\\[\\langle\\vartheta_1(p)f_1(q,p)\\rangle=\\pm\\frac\\beta2\\langle(\\gamma U(q)-c)\\vartheta_1(p)\\pm p^TM^{-1}\\nabla U(q)\\vartheta_1(p)\\rangle\n=\\pm\\frac\\beta2\\langle p^TM^{-1}\\nabla U(q)\\vartheta_1(p)\\rangle.\\]\nHowever, if we instead set $\\vartheta=\\vartheta_2(q)$, then\n\\[\\langle\\vartheta_2(q)f_1(q,p)\\rangle=\\pm\\frac{\\gamma\\beta}{2}\\langle(U(q)-\\langle U(q)\\rangle)\\vartheta_2(q)\\rangle.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 315,
      "printed_page": 294,
      "text": "294\n7\nNumerical Methods for Stochastic Molecular Dynamics\nAnd hence we have\nL\u0004\nLD\n\u0004\nf1;\u0002AOB\u0003\u0005ˇ\n\u0005\nD L\u0004\nLD\n\u0004\nf1;\u0002ABO\u0003\u0005ˇ\n\u0005\n\u0003 \nˇL\u0004\nLD\n\u0004\nU.q/\u0005ˇ\n\u0005\n;\ngiving the general solution\nf1;\u0002AOB\u0003 D \u0003ˇ\n2\n\u0004\n\nU.q/ C pTM\u00021rU.q/ \u0003 c\n\u0005\n;\nfor the same choice of c.\nHence using the symmetry in the commutators we are able to solve for the leading\norder corrections for each of the schemes of the form \u0002XYZ\u0003. In summary, we ﬁnd\nthat\nf1;\u0002ABO\u0003.q; p/ D f1;\u0002OAB\u0003.q; p/ D ˇ\n2\n\u0004\n\nU.q/ \u0003 pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25a)\nf1;\u0002OBA\u0003.q; p/ D f1;\u0002BAO\u0003.q; p/ D \u0003ˇ\n2\n\u0004\n\nU.q/ \u0003 pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25b)\nf1;\u0002AOB\u0003.q; p/ D \u0003ˇ\n2\n\u0004\n\nU.q/ C pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25c)\nf1;\u0002BOA\u0003.q; p/ D ˇ\n2\n\u0004\n\nU.q/ C pTM\u00021rU.q/ \u0003 c\n\u0005\n;\n(7.25d)\nwhere the constant c is chosen to ensure each correction function has average 0,\ngiving c D \nhU.q/i. If required, we may continue this procedure in order to ﬁnd\ncorrection functions for higher orders, though the added complexity means that we\ncannot always solve to ﬁnd an explicit solution.\nThe results of our analysis suggest that to leading order the error scales linearly\nwith the reciprocal temperature ˇ, but more importantly a non-constant term appears\nwhich is of order \n. As our correction is of the form h#f1i we can see that if # D\n#1.p/ then this O.\n/ term will not trouble us, as\nh#1.p/f1.q; p/i D ˙ˇ\n2\n˝\n.\nU.q/ \u0003 c/#1.p/ ˙ pTM\u00021rU.q/#1.p/\n˛\nD ˙ˇ\n2\n˝\npTM\u00021rU.q/#1.p/\n˛\n;\nwhere the sign depends on the particular scheme used (which governs the form of\nf1). Thus in the case of a function of pure momentum the order \n term does not\n"
    },
    {
      "pdf_page": 316,
      "printed_page": 295,
      "text": "7.8\nFirst Order Schemes\n295\nappear. However, if we instead set # D #2.q/, then\nh#2.q/f1.q; p/i D ˙ˇ\n2\n˝\n.\nU.q/ \u0003 c/#2.q/ ˙ pTM\u00021rU.q/#2.q/\n˛\nD ˙\nˇ\n2 h.U.q/ \u0003 hU.q/i/#2.q/i ;\nin which case our correction becomes O.\n/. This is potentially disastrous if we\nchoose the friction to be large (consider \n\u0005 h\u00021), as the error introduced\nthrough discretization will dominate the true average to be sampled. Examining\nthe algorithms themselves this is unsurprising, as although we have integrated\nthe Ornstein-Uhlenbeck process exactly, when considering the limit of inﬁnite\nfriction in the \u0002XYZ\u0003 schemes we obtain an inconsistent discretization. Hence these\nﬁrst-order schemes will be unsuitable for the integration of overdamped Langevin\ndynamics.\nThis is not always the case for ﬁrst order schemes, however. For example the\nscheme denoted \u0002AOAB\u0003 is consistent with the dynamics, and may be used for\nintegrating the overdamped (\n D 1) Langevin equation.\n7.8.2\nNumerical Experiment\nLet us consider testing the computed ﬁrst order corrections on a one dimensional\nexample. Let M D ˇ D 1 and deﬁne the biased double-well potential as\nU.q/ D .q2 \u0003 1/2 C q=2:\nWe shall consider computing the average of a speciﬁc observable #.q; p/, and\nestimating the error due to discretization using the correction functions given\nin (7.25), where we choose the observable\n#.q; p/ D p2 \u0003 qU0.q/ C 2qp;\nh#i D 0:\nThe low dimensionality of the problem and the simplicity of the observable and\npotential energy function make resolving the perfect sampling bias to leading order\nan easy task, allowing us to give a good estimate (to order h2) of the discretization\nerror. In Fig. 7.4 we plot the results of h#ih computed via numerical experiment,\nusing each of the six ﬁrst order schemes at either \n D 1 or \n D 2, and compare\nthem to our ﬁrst order prediction\nh#ih \u0007 h#i C hhf1#i:\nThe numerical experiment at each timestep is averaged from 16 independent\nexperiments, each running over a time interval of 108. The results match our\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "产品Gibbs实际含位置概率及独立中心Gaussian动量；所有显示期望需可积，未把待求修正值作为假设。",
    "六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.positionGibbs",
  "lean_declarations": [
    "MD.Ch07.positionGibbs",
    "MD.Ch07.momentumGibbs",
    "MD.Ch07.productGibbs",
    "MD.Ch07.positionMomentumCorrections"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def positionGibbs (U : V n → ℝ) (β : ℝ) : Measure (V n) :=
  volume.withDensity (fun q ↦ ENNReal.ofReal (Real.exp (-β*U q)/(∫ y, Real.exp (-β*U y))))
def momentumGibbs (m : V n) (β : ℝ) : Measure (V n) := Measure.pi (fun i ↦ gaussianReal 0 (Real.toNNReal (m i/β)))
def productGibbs (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  (positionGibbs U β).prod (momentumGibbs m β)
theorem positionMomentumCorrections (m : V n) (U ψ χ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hU : Integrable U (positionGibbs U β))
    (hψ : Integrable ψ (positionGibbs U β)) (hχ : Integrable χ (momentumGibbs m β))
    (hgrad : ∀ i, Integrable (fun q ↦ gradient U q i) (positionGibbs U β))
    (hint : ∀ s : Fin 6,
      Integrable (fun x ↦ ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β) ∧
      Integrable (fun x ↦ χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β)) :
    ∀ s : Fin 6, let sign : ℝ := if s = 0 ∨ s = 1 ∨ s = 5 then 1 else -1
    let vsign : ℝ := if s = 0 ∨ s = 1 ∨ s = 4 then -1 else 1
    (∫ x, ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      sign*γ*β/2*∫ q, (U q-(∫ y, U y ∂positionGibbs U β))*ψ q ∂positionGibbs U β ∧
    (∫ x, χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      vsign*β/2*∫ x, (∑ i, x.2 i/m i*gradient U x.1 i)*χ x.2 ∂productGibbs m U β := by
  sorry
```

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
    "覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aoab",
  "lean_declarations": [
    "MD.Ch07.aoab",
    "MD.Ch07.aoabInfiniteFriction",
    "MD.Ch07.aoabFrictionLimit"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
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
    "中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.biasedDoubleWell",
  "lean_declarations": [
    "MD.Ch07.biasedDoubleWell",
    "MD.Ch07.doubleWellObservable",
    "MD.Ch07.doubleWellGibbs",
    "MD.Ch07.doubleWellBOACorrection",
    "MD.Ch07.doubleWellExact",
    "MD.Ch07.doubleWellCritical"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
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
```

## MD-7.9-Proposition71
```json
{
  "source_id": "MD-7.9-Proposition71",
  "kind": "proposition",
  "label": "Proposition 7.1 / (7.26)",
  "section": "7.9",
  "printed_page": "297",
  "pdf_page": "318",
  "statement_latex": "Proposition 7.1 Let $\\mathcal L_X^\\dagger$, $\\mathcal L_Y^\\dagger$ and $\\mathcal L_Z^\\dagger$ be general operators to which BCH can be applied, then defining\n\\[e^{h\\widehat{\\mathcal L}^\\dagger}=e^{\\frac h2\\mathcal L_X^\\dagger}e^{\\frac h2\\mathcal L_Y^\\dagger}e^{h\\mathcal L_Z^\\dagger}e^{\\frac h2\\mathcal L_Y^\\dagger}e^{\\frac h2\\mathcal L_X^\\dagger},\\tag{7.26}\\]\ngives $\\widehat{\\mathcal L}^\\dagger=\\mathcal L_0^\\dagger+h^2\\mathcal L_2^\\dagger+O(h^4)$, where\n\\[\\mathcal L_0^\\dagger=\\mathcal L_X^\\dagger+\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger,\\]\n\\[\\mathcal L_2^\\dagger=\\frac1{12}([\\mathcal L_Z^\\dagger,\\mathcal L_Z^\\dagger,\\mathcal L_Y^\\dagger]+[\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger,\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger,\\mathcal L_X^\\dagger])\n-\\frac1{24}([\\mathcal L_Y^\\dagger,\\mathcal L_Y^\\dagger,\\mathcal L_Z^\\dagger]+[\\mathcal L_X^\\dagger,\\mathcal L_X^\\dagger,\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger]).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 318,
      "printed_page": 297,
      "text": "7.9\nError Expansion for Symmetric Langevin Methods\n297\nHence for the critical value of \n D 2, the leading order correction will be zero,\ngiving\nh#i\u0002BOA\u0003\nh\nD h#i C O.h2/:\nThis is exactly the behavior we see in Fig. 7.4.\n7.9\nError Expansion for Symmetric Langevin Methods\nOf particular interest for sampling the canonical distribution are symmetric\nLangevin methods. We believe these are likely to be the most useful class of\nmethods for practitioners, as by symmetrizing the expansion the odd order terms\nin (7.16) vanish identically using the Jacobi identity in the BCH expansions. This\nimplies that a symmetric scheme gives a second order error in computed averages.\nMany symmetric methods can be constructed that require only one evaluation of the\nforce per iteration (effectively making them as inexpensive as a ﬁrst order method).\nIn order to simplify the algebra, we will use M D I throughout this section,\nwhich will not alter the major results and amounts to a linear change of variables.\nWe shall consider general symmetric schemes of the form \u0002XYZYX\u0003, and perform\na similar analysis to the previous section. The terms appearing in the expansions\nwill be signiﬁcantly more complex than those encountered in ﬁrst order methods.\nWe make use of the following proposition for symmetric compositions:\nProposition 7.1 Let L\u0004\nX, L\u0004\nY and L\u0004\nZ be general operators to which BCH can be\napplied, then deﬁning\neh OL\u0004 D e\nh\n2 L\u0004\nXe\nh\n2 L\u0004\nYehL\u0004\nZe\nh\n2 L\u0004\nYe\nh\n2 L\u0004\nX;\n(7.26)\ngives\nOL\u0004 D L\u0004\n0 C h2L\u0004\n2 C O.h4/;\nwhere\nL\u0004\n0 DL\u0004\nX C L\u0004\nY C L\u0004\nZ;\nL\u0004\n2 D 1\n12\n\u0006\nŒL\u0004\nZ; L\u0004\nZ; L\u0004\nY\t C ŒL\u0004\nY C L\u0004\nZ; L\u0004\nY C L\u0004\nZ; L\u0004\nX\t\n\u0007\n\u0003 1\n24\n\u0006\nŒL\u0004\nY; L\u0004\nY; L\u0004\nZ\t C ŒL\u0004\nX; L\u0004\nX; L\u0004\nY C L\u0004\nZ\t\n\u0007\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.proposition71",
  "lean_declarations": [
    "MD.Ch07.proposition71",
    "MD.Ch07.symmetricOddCorrections"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": [
    "MolecularDynamics.textbookSymmetricOperatorCorrection",
    "MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71"
  ]
}
```
```lean
theorem proposition71 {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    ∃ Q : PowerSeries R, MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z =
      PowerSeries.C (X+Y+Z)+
      PowerSeries.C (MolecularDynamics.textbookSymmetricOperatorCorrection X Y Z)*PowerSeries.X^2+
      PowerSeries.X^4*Q := MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71 X Y Z
theorem symmetricOddCorrections {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) (k : ℕ) :
    PowerSeries.coeff (2*k+1) (MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z) = 0 :=
  MolecularDynamics.textbookSymmetricModifiedGenerator_odd_coeff_zero X Y Z k
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
    "系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.evenDensityExpansion",
  "lean_declarations": [
    "MD.Ch07.evenDensityExpansion",
    "MD.Ch07.evenPerturbationEquation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
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
