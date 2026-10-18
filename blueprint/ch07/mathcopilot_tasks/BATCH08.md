# BATCH08 第7章原文与陈述审校

## MD-7.4.2-BBKStarMomentSystemPrinted
```json
{
  "source_id": "MD-7.4.2-BBKStarMomentSystemPrinted",
  "kind": "definition",
  "label": null,
  "section": "7.4.2",
  "printed_page": "278–279",
  "pdf_page": "299–300",
  "statement_latex": "Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives\n\\[Q=\\psi_{11}^2Q+\\psi_{12}^2P+2\\psi_{11}\\psi_{12}C+2\\psi_{12}\\kappa_1 2\\psi_{12}\\kappa_1\\kappa_3+\\kappa_1^2,\\]\n\\[P=\\psi_{21}^2Q+\\psi_{22}^2P+2\\psi_{21}\\psi_{22}C+2\\psi_{22}\\kappa_2 2\\psi_{22}\\kappa_2\\kappa_3+\\kappa_2^2+\\kappa_3^2,\\]\n\\[C=\\psi_{11}\\psi_{21}Q+\\psi_{12}\\psi_{22}P+(\\psi_{11}\\psi_{22}+\\psi_{12}\\psi_{21})C+\\kappa_1\\kappa_2+\\psi_{12}\\kappa_2\\kappa_3+\\psi_{22}\\kappa_1\\kappa_3.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 299,
      "printed_page": 278,
      "text": "278\n7\nNumerical Methods for Stochastic Molecular Dynamics\nnumbers between iterations to give a small computational saving. We can see that\nonly one vector of random numbers is generated per iteration, with the new vector of\nrandom numbers being used in the following iteration. This gives some correlation\nbetween steps that complicates our analysis a little.\nIf we wish to ﬁnd the perfect sampling bias in the case of the one-dimensional\nharmonic oscillator, we can apply this technique to ﬁnd the invariant averages under\nthis scheme. We have\n\f BBK* D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK*\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C RnC1\n\u0007\n3\n5 D\n\u0002\n\n1Rn\n\n2Rn C \n3RnC1\n\u0003\n;\nusing the notation in (7.7). Taking expectations of the resulting equations, we can\ncompute the values of the constants in (7.8)–(7.10) and solve to ﬁnd the long-\ntime averages. Care must be taken however, as unlike the schemes using the ABO\nsplitting we must include some correlation between steps. Denoting the entries of\n\f BBK* by ij we have\nE.\u0006n;2pn/ D E ..\n2Rn C \n3RnC1/ . 21qn\u00021 C 22pn\u00021 C \n2Rn\u00021 C \n3Rn// ;\nD \n2\n3:\nThis additional quantity will slightly change the expectation of (7.9) compared to the\nstandard BBK method, and hence the overall averages of the scheme. Additionally\nit is easily shown that\nE.\u0006n;1qn/ D E.\u0006n;2qn/ D 0;\nE.\u0006n;1pn/ D \n1\n3;\nwith\nE.\u00062\nn;1/ D \n2\n1;\nE.\u0006n;1\u0006n;2/ D \n1\n2;\nE.\u00062\nn;2/ D \n2\n2 C \n2\n3:\nThus taking expectations of (7.8)–(7.10) and substituting in the constants gives\nhq2iBBK*\nh\nD 2\n11hq2iBBK*\nh\nC 2\n12hp2iBBK*\nh\nC 2 11 12hqpiBBK*\nh\nC 2 12\n12 12\n1\n3\nC \n2\n1;\nhp2iBBK*\nh\nD 2\n21hq2iBBK*\nh\nC 2\n22hp2iBBK*\nh\nC 2 21 22hqpiBBK*\nh\nC 2 22\n22 22\n2\n3\nC \n2\n2 C \n2\n3;\n"
    },
    {
      "pdf_page": 300,
      "printed_page": 279,
      "text": "7.5\nErrors in Conﬁgurational Quantities for the Perturbed Harmonic Oscillator\n279\nhqpiBBK*\nh\nD 11 21hq2iBBK*\nh\nC 12 22hp2iBBK*\nh\nC . 11 22 C 12 21/hqpiBBK*\nh\nC \n1\n2 C 12\n2\n3 C 22\n1\n3:\nFinally, solving the simultaneous equations gives the stationary observed aver-\nages as\nhq2iBBK*\nh\nD kBT\n˝2\n\b\n1 \u0003 ˝2h2\n4m\n\t\u00021\n;\nhp2iBBK*\nh\nD kBTm\n\b\n1 C \nh\n2\n\t\u00021\n;\nhqpiBBK*\nh\nD 0:\nFor more general methods requiring multiple correlated random numbers, a\nfurther history than just one step is required to evaluate the expectation correctly.\n7.5\nErrors in Conﬁgurational Quantities for the Perturbed\nHarmonic Oscillator\nWe can consider applying the analysis of Sect. 7.4 to a more complicated example,\nhowever in general for nonlinear systems we cannot adopt the same strategy by\ntaking expectations of the update equations, as we do not end up with a closed\nsystem of linear equations to solve (the force term now involves terms of higher\norders). However, if the nonlinear terms in the force are preceded by a small\nconstant, we can truncate the equations to provide an approximation to the invariant\nbehavior. We consider sampling canonically the Hamiltonian\nH.q; p/ D p2=2 C q2=2 C \"q4=4;\n(7.13)\nusing Langevin dynamics, where q; p 2 R, with a small nonlinearity parameter\n\" > 0. As the canonical momentum distribution is always Gaussian (and hence\ntrivial to sample), we will be far more concerned with the behavior of the (more\ninteresting) distribution of position. The system can be thought of as the harmonic\noscillator with a small nonlinear perturbation term, so the canonical conﬁgurational\ndistribution will remain “close” to a Gaussian in some sense (this potential energy\nfunction is equivalent to an unforced Dufﬁng Oscillator with no damping). In the\nlimit as \" ! 0, we would expect the averages to converge to the results of Table 7.1.\nWe consider estimating the value of hq2ih by truncating the equations governing\nthe evolution of the averages in powers of \" (to ensure closure of the resulting\nsimultaneous equations). We examine the expected behavior of the average in the\ncase of the four second-order schemes listed in Table 7.1, although we may conduct\nthis analysis for any similar scheme.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。"
  ],
  "issues": [
    "已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarMomentSystemPrinted",
  "lean_declarations": [
    "MD.Ch07.bbkStarMomentSystemPrinted",
    "MD.Ch07.bbkStarMomentSystemPrinted_corrected",
    "MD.Ch07.bbkStarExtraFactor_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num
```

## MD-7.4.2-BBKStarStationary
```json
{
  "source_id": "MD-7.4.2-BBKStarStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.2",
  "printed_page": "279",
  "pdf_page": "300",
  "statement_latex": "Finally, solving the simultaneous equations gives the stationary observed averages as\n\\[\\langle q^2\\rangle_h^{\\rm BBK*}=\\frac{k_BT}{\\Omega^2}(1-\\frac{\\Omega^2h^2}{4m})^{-1},\\qquad\n\\langle p^2\\rangle_h^{\\rm BBK*}=k_BTm(1+\\frac{\\gamma h}2)^{-1},\\qquad\n\\langle qp\\rangle_h^{\\rm BBK*}=0.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 300,
      "printed_page": 279,
      "text": "7.5\nErrors in Conﬁgurational Quantities for the Perturbed Harmonic Oscillator\n279\nhqpiBBK*\nh\nD 11 21hq2iBBK*\nh\nC 12 22hp2iBBK*\nh\nC . 11 22 C 12 21/hqpiBBK*\nh\nC \n1\n2 C 12\n2\n3 C 22\n1\n3:\nFinally, solving the simultaneous equations gives the stationary observed aver-\nages as\nhq2iBBK*\nh\nD kBT\n˝2\n\b\n1 \u0003 ˝2h2\n4m\n\t\u00021\n;\nhp2iBBK*\nh\nD kBTm\n\b\n1 C \nh\n2\n\t\u00021\n;\nhqpiBBK*\nh\nD 0:\nFor more general methods requiring multiple correlated random numbers, a\nfurther history than just one step is required to evaluate the expectation correctly.\n7.5\nErrors in Conﬁgurational Quantities for the Perturbed\nHarmonic Oscillator\nWe can consider applying the analysis of Sect. 7.4 to a more complicated example,\nhowever in general for nonlinear systems we cannot adopt the same strategy by\ntaking expectations of the update equations, as we do not end up with a closed\nsystem of linear equations to solve (the force term now involves terms of higher\norders). However, if the nonlinear terms in the force are preceded by a small\nconstant, we can truncate the equations to provide an approximation to the invariant\nbehavior. We consider sampling canonically the Hamiltonian\nH.q; p/ D p2=2 C q2=2 C \"q4=4;\n(7.13)\nusing Langevin dynamics, where q; p 2 R, with a small nonlinearity parameter\n\" > 0. As the canonical momentum distribution is always Gaussian (and hence\ntrivial to sample), we will be far more concerned with the behavior of the (more\ninteresting) distribution of position. The system can be thought of as the harmonic\noscillator with a small nonlinear perturbation term, so the canonical conﬁgurational\ndistribution will remain “close” to a Gaussian in some sense (this potential energy\nfunction is equivalent to an unforced Dufﬁng Oscillator with no damping). In the\nlimit as \" ! 0, we would expect the averages to converge to the results of Table 7.1.\nWe consider estimating the value of hq2ih by truncating the equations governing\nthe evolution of the averages in powers of \" (to ensure closure of the resulting\nsimultaneous equations). We examine the expected behavior of the average in the\ncase of the four second-order schemes listed in Table 7.1, although we may conduct\nthis analysis for any similar scheme.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。"
  ],
  "issues": [],
  "statement_scope": "给定正确矩方程的代数求解及全部三矩值；未证明BBK*长期收敛。",
  "lean_decl": "MD.Ch07.bbkStarStationaryAlgebra",
  "lean_declarations": [
    "MD.Ch07.bbkStarStationaryAlgebra"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry
```

## MD-7.5-PerturbedHamiltonian
```json
{
  "source_id": "MD-7.5-PerturbedHamiltonian",
  "kind": "definition",
  "label": "(7.13)",
  "section": "7.5",
  "printed_page": "279",
  "pdf_page": "300",
  "statement_latex": "We consider sampling canonically the Hamiltonian\n\\[H(q,p)=p^2/2+q^2/2+\\epsilon q^4/4,\\tag{7.13}\\]\nusing Langevin dynamics, where $q,p\\in\\mathbb R$, with a small nonlinearity parameter $\\epsilon>0$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 300,
      "printed_page": 279,
      "text": "7.5\nErrors in Conﬁgurational Quantities for the Perturbed Harmonic Oscillator\n279\nhqpiBBK*\nh\nD 11 21hq2iBBK*\nh\nC 12 22hp2iBBK*\nh\nC . 11 22 C 12 21/hqpiBBK*\nh\nC \n1\n2 C 12\n2\n3 C 22\n1\n3:\nFinally, solving the simultaneous equations gives the stationary observed aver-\nages as\nhq2iBBK*\nh\nD kBT\n˝2\n\b\n1 \u0003 ˝2h2\n4m\n\t\u00021\n;\nhp2iBBK*\nh\nD kBTm\n\b\n1 C \nh\n2\n\t\u00021\n;\nhqpiBBK*\nh\nD 0:\nFor more general methods requiring multiple correlated random numbers, a\nfurther history than just one step is required to evaluate the expectation correctly.\n7.5\nErrors in Conﬁgurational Quantities for the Perturbed\nHarmonic Oscillator\nWe can consider applying the analysis of Sect. 7.4 to a more complicated example,\nhowever in general for nonlinear systems we cannot adopt the same strategy by\ntaking expectations of the update equations, as we do not end up with a closed\nsystem of linear equations to solve (the force term now involves terms of higher\norders). However, if the nonlinear terms in the force are preceded by a small\nconstant, we can truncate the equations to provide an approximation to the invariant\nbehavior. We consider sampling canonically the Hamiltonian\nH.q; p/ D p2=2 C q2=2 C \"q4=4;\n(7.13)\nusing Langevin dynamics, where q; p 2 R, with a small nonlinearity parameter\n\" > 0. As the canonical momentum distribution is always Gaussian (and hence\ntrivial to sample), we will be far more concerned with the behavior of the (more\ninteresting) distribution of position. The system can be thought of as the harmonic\noscillator with a small nonlinear perturbation term, so the canonical conﬁgurational\ndistribution will remain “close” to a Gaussian in some sense (this potential energy\nfunction is equivalent to an unforced Dufﬁng Oscillator with no damping). In the\nlimit as \" ! 0, we would expect the averages to converge to the results of Table 7.1.\nWe consider estimating the value of hq2ih by truncating the equations governing\nthe evolution of the averages in powers of \" (to ensure closure of the resulting\nsimultaneous equations). We examine the expected behavior of the average in the\ncase of the four second-order schemes listed in Table 7.1, although we may conduct\nthis analysis for any similar scheme.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。",
    "分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.perturbedPotential",
  "lean_declarations": [
    "MD.Ch07.perturbedPotential",
    "MD.Ch07.perturbedHamiltonian",
    "MD.Ch07.perturbedGibbs",
    "MD.Ch07.perturbedStep",
    "MD.Ch07.perturbedStationary"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def perturbedPotential (ε q : ℝ) : ℝ := q^2/2+ε*q^4/4
def perturbedHamiltonian (ε : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/2+perturbedPotential ε x.1
def perturbedGibbs (ε : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-perturbedHamiltonian ε x)
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def perturbedStep (s : Fin 4) (ε γ h R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let m : V 1 := fun _ ↦ 1
  let U : V 1 → ℝ := fun q ↦ perturbedPotential ε (q 0)
  scalarLift (if s = 0 then aboba m U γ 1 h (fun _ ↦ R)
    else if s = 1 then baoab m U γ 1 h (fun _ ↦ R)
    else if s = 2 then obabo m U γ 1 h (fun _ ↦ R) (fun _ ↦ S)
    else oabao m U γ 1 h (fun _ ↦ R) (fun _ ↦ S))
def perturbedStationary (s : Fin 4) (ε γ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ perturbedStep s ε γ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ
```

## MD-7.5-PerturbedErrorExpansion
```json
{
  "source_id": "MD-7.5-PerturbedErrorExpansion",
  "kind": "unnumbered_claim",
  "label": "(7.14)",
  "section": "7.5",
  "printed_page": "280",
  "pdf_page": "301",
  "statement_latex": "We find that truncating the update equations to $O(\\epsilon^3)$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:\n\\[\\langle q^2\\rangle_h^{[ABOBA]}-\\langle q^2\\rangle=\\frac{3h^2\\epsilon[48\\epsilon-4+3\\gamma^2(9\\epsilon-1)]}{12\\gamma^2+16}+O(\\epsilon h^4+\\epsilon^3h^2),\\]\n\\[\\langle q^2\\rangle_h^{[BAOAB]}-\\langle q^2\\rangle=-\\frac{9h^2\\epsilon^2}{6\\gamma^2+8}-\\frac{3h^4\\epsilon^2[6\\gamma^4+19\\gamma^2+16]}{8(3\\gamma^2+4)^2}+O(\\epsilon^2h^6+\\epsilon^3h^2),\\]\n\\[\\langle q^2\\rangle_h^{[OBABO]}-\\langle q^2\\rangle=h^2\\left(\\frac14+\\frac{\\epsilon[144\\epsilon+81\\epsilon\\gamma^2-9\\gamma^2-12]}{12\\gamma^2+16}\\right)+O(h^4+\\epsilon^3h^2),\\]\n\\[\\langle q^2\\rangle_h^{[OABAO]}-\\langle q^2\\rangle=-h^2\\left(\\frac14+\\frac{18\\epsilon^2}{12\\gamma^2+16}\\right)+O(h^4+\\epsilon^3h^2).\\tag{7.14}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 301,
      "printed_page": 280,
      "text": "280\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWe ﬁnd that truncating the update equations to O.\"3/ is sufﬁcient to explicitly\nresolve the leading order behavior of the error for these discretization schemes, and\nwe give the differences between observed numerical averages and exact averages\nbelow:\nhq2i\u0002ABOBA\u0003\nh\n\u0003 hq2i D 3h2\"\n\n48\" \u0003 4 C 3\n2.9\" \u0003 1/\n\u000b\n12\n2 C 16\nC O.\"h4 C \"3h2/;\nhq2i\u0002BAOAB\u0003\nh\n\u0003 hq2i D \u0003 9h2\"2\n6\n2 C 8 \u0003 3h4\"2 \n6\n4 C 19\n2 C 16\u000b\n8 .3\n2 C 4/2\nC O.\"2h6 C \"3h2/;\nhq2i\u0002OBABO\u0003\nh\n\u0003 hq2i D h2\n \n1\n4 C \"\n\n144\" C 81\"\n2 \u0003 9\n2 \u0003 12\n\u000b\n12\n2 C 16\n!\nC O.h4 C \"3h2/;\nhq2i\u0002OABAO\u0003\nh\n\u0003 hq2i D \u0003h2\n\b1\n4 C\n18\"2\n12\n2 C 16\n\t\nC O.h4 C \"3h2/:\n(7.14)\nThe behavior of the methods can thus be summarized as\nˇˇˇhq2i\u0002ABOBA\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\u0004\n\"h2\u0005\n;\nˇˇˇhq2i\u0002BAOAB\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\b \"2h2\n1 C \n2 C \"2h4\n\t\n;\nˇˇˇhq2i\u0002OBABO\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\u0004\nh2\u0005\n;\nˇˇˇhq2i\u0002OABAO\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\u0004\nh2\u0005\n:\n(7.15)\nWe would expect that both the \u0002ABOBA\u0003 and \u0002BAOAB\u0003 schemes would have a\nleading error term proportional to \", given that it was shown in Table 7.1 that in the\npure harmonic case (at \" D 0) these methods give perfect sampling. The twofold\nsurprising result though, is that (a) the leading error of the \u0002BAOAB\u0003 scheme has\nbehavior proportional to \"2, while (b) the leading order term of the \u0002BAOAB\u0003\nscheme is annihilated for large \n.\nIt would seem that by ordering the A, B and O update terms favourably in an\nalgorithm we are able to achieve signiﬁcant sampling improvements on systems\nthat are “nearly harmonic”, at no extra cost (in terms of force evaluations).\nTo illustrate this numerically, we use each of the four given second order methods\nto compute the absolute error in hq2ih using the one dimensional perturbed harmonic\noscillator with Hamiltonian given in (7.13) at a range of timesteps h 2 Œ0:1; 2\t and\nnonlinearity parameters \" 2 Œ0:0001; 1\t. We choose ˇ D \n D 1 for all experiments,\nand run the schemes using each parameter set for a ﬁxed time window of length 108.\nThe results are shown in Fig. 7.3, and qualitatively agree with the results of (7.15).\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。",
    "实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.perturbedLeading",
  "lean_declarations": [
    "MD.Ch07.perturbedLeading",
    "MD.Ch07.perturbedRemainder",
    "MD.Ch07.positivePairLimit",
    "MD.Ch07.perturbedErrorExpansion"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def perturbedLeading (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then 3*h^2*ε*(48*ε-4+3*γ^2*(9*ε-1))/(12*γ^2+16)
  else if s = 1 then -9*h^2*ε^2/(6*γ^2+8)-3*h^4*ε^2*(6*γ^4+19*γ^2+16)/(8*(3*γ^2+4)^2)
  else if s = 2 then h^2*(1/4+ε*(144*ε+81*ε*γ^2-9*γ^2-12)/(12*γ^2+16))
  else -h^2*(1/4+18*ε^2/(12*γ^2+16))
def perturbedRemainder (s : Fin 4) (ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^4+ε^3*h^2
  else if s = 1 then ε^2*h^6+ε^3*h^2 else h^4+ε^3*h^2
def positivePairLimit : Filter (ℝ × ℝ) :=
  𝓝[Set.Ioi (0 : ℝ) ×ˢ Set.Ioi (0 : ℝ)] (0,0)
theorem perturbedErrorExpansion (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)-perturbedLeading s γ z.1 z.2)
      (fun z ↦ perturbedRemainder s z.1 z.2) := by
  sorry
```

## MD-7.5-PerturbedErrorOrders
```json
{
  "source_id": "MD-7.5-PerturbedErrorOrders",
  "kind": "unnumbered_claim",
  "label": "(7.15)",
  "section": "7.5",
  "printed_page": "280",
  "pdf_page": "301",
  "statement_latex": "The behavior of the methods can thus be summarized as\n\\[|\\langle q^2\\rangle_h^{[ABOBA]}-\\langle q^2\\rangle|=O(\\epsilon h^2),\\qquad\n|\\langle q^2\\rangle_h^{[BAOAB]}-\\langle q^2\\rangle|=O\\left(\\frac{\\epsilon^2h^2}{1+\\gamma^2}+\\epsilon^2h^4\\right),\\]\n\\[|\\langle q^2\\rangle_h^{[OBABO]}-\\langle q^2\\rangle|=O(h^2),\\qquad\n|\\langle q^2\\rangle_h^{[OABAO]}-\\langle q^2\\rangle|=O(h^2).\\tag{7.15}\\]\nThe twofold surprising result though, is that (a) the leading error of the $[BAOAB]$ scheme has behavior proportional to $\\epsilon^2$, while (b) the leading order term of the $[BAOAB]$ scheme is annihilated for large $\\gamma$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 301,
      "printed_page": 280,
      "text": "280\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWe ﬁnd that truncating the update equations to O.\"3/ is sufﬁcient to explicitly\nresolve the leading order behavior of the error for these discretization schemes, and\nwe give the differences between observed numerical averages and exact averages\nbelow:\nhq2i\u0002ABOBA\u0003\nh\n\u0003 hq2i D 3h2\"\n\n48\" \u0003 4 C 3\n2.9\" \u0003 1/\n\u000b\n12\n2 C 16\nC O.\"h4 C \"3h2/;\nhq2i\u0002BAOAB\u0003\nh\n\u0003 hq2i D \u0003 9h2\"2\n6\n2 C 8 \u0003 3h4\"2 \n6\n4 C 19\n2 C 16\u000b\n8 .3\n2 C 4/2\nC O.\"2h6 C \"3h2/;\nhq2i\u0002OBABO\u0003\nh\n\u0003 hq2i D h2\n \n1\n4 C \"\n\n144\" C 81\"\n2 \u0003 9\n2 \u0003 12\n\u000b\n12\n2 C 16\n!\nC O.h4 C \"3h2/;\nhq2i\u0002OABAO\u0003\nh\n\u0003 hq2i D \u0003h2\n\b1\n4 C\n18\"2\n12\n2 C 16\n\t\nC O.h4 C \"3h2/:\n(7.14)\nThe behavior of the methods can thus be summarized as\nˇˇˇhq2i\u0002ABOBA\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\u0004\n\"h2\u0005\n;\nˇˇˇhq2i\u0002BAOAB\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\b \"2h2\n1 C \n2 C \"2h4\n\t\n;\nˇˇˇhq2i\u0002OBABO\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\u0004\nh2\u0005\n;\nˇˇˇhq2i\u0002OABAO\u0003\nh\n\u0003 hq2i\nˇˇˇ D O\n\u0004\nh2\u0005\n:\n(7.15)\nWe would expect that both the \u0002ABOBA\u0003 and \u0002BAOAB\u0003 schemes would have a\nleading error term proportional to \", given that it was shown in Table 7.1 that in the\npure harmonic case (at \" D 0) these methods give perfect sampling. The twofold\nsurprising result though, is that (a) the leading error of the \u0002BAOAB\u0003 scheme has\nbehavior proportional to \"2, while (b) the leading order term of the \u0002BAOAB\u0003\nscheme is annihilated for large \n.\nIt would seem that by ordering the A, B and O update terms favourably in an\nalgorithm we are able to achieve signiﬁcant sampling improvements on systems\nthat are “nearly harmonic”, at no extra cost (in terms of force evaluations).\nTo illustrate this numerically, we use each of the four given second order methods\nto compute the absolute error in hq2ih using the one dimensional perturbed harmonic\noscillator with Hamiltonian given in (7.13) at a range of timesteps h 2 Œ0:1; 2\t and\nnonlinearity parameters \" 2 Œ0:0001; 1\t. We choose ˇ D \n D 1 for all experiments,\nand run the schemes using each parameter set for a ﬁxed time window of length 108.\nThe results are shown in Fig. 7.3, and qualitatively agree with the results of (7.15).\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "双参数正向极限已明确；γ固定的常数不等于γ一致误差界。原书(7.14)的ε³h²余项不足以单独推出BAOAB的ε²h²+ε²h⁴界，需要额外结构；保留为待证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.perturbedErrorScale",
  "lean_declarations": [
    "MD.Ch07.perturbedErrorScale",
    "MD.Ch07.perturbedErrorOrders",
    "MD.Ch07.baoabLeading_largeFriction"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def perturbedErrorScale (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^2 else if s = 1 then ε^2*h^2/(1+γ^2)+ε^2*h^4 else h^2
theorem perturbedErrorOrders (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ᶠ z in positivePairLimit, perturbedStationary s z.1 γ z.2 (μ z.1 z.2)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ |momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)|)
      (fun z ↦ perturbedErrorScale s γ z.1 z.2) := by
  sorry
theorem baoabLeading_largeFriction (ε h : ℝ) :
    Filter.Tendsto (fun γ : ℝ ↦ -9*h^2*ε^2/(6*γ^2+8)) Filter.atTop (𝓝 0) := by
  sorry
```

## MD-7.6-GibbsComposition
```json
{
  "source_id": "MD-7.6-GibbsComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.6",
  "printed_page": "282",
  "pdf_page": "303",
  "statement_latex": "The flows of each of these systems individually preserves the Gibbs distribution: denoting the Fokker-Planck operators associated to these flows by $\\mathcal L_H^\\dagger$ and $\\mathcal L_O^\\dagger$ we have\n\\[\\mathcal L_H^\\dagger\\rho_\\beta=0,\\qquad\\mathcal L_O^\\dagger\\rho_\\beta=0,\\]\nand hence\n\\[\\exp(t\\mathcal L_H^\\dagger)\\rho_\\beta=\\exp(t\\mathcal L_O^\\dagger)\\rho_\\beta=\\rho_\\beta.\\]\nFor a scheme $[HO]$, we have\n\\[\\exp(h\\mathcal L_O^\\dagger)[\\exp(h\\mathcal L_H^\\dagger)\\rho_\\beta]=\\exp(h\\mathcal L_O^\\dagger)\\rho_\\beta=\\rho_\\beta.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 303,
      "printed_page": 282,
      "text": "282\n7\nNumerical Methods for Stochastic Molecular Dynamics\ndeterministic Hamiltonian system taken ﬁrst, followed by the Ornstein-Uhlenbeck\nequation for p. The ﬂows of each of these systems individually preserves the Gibbs\ndistribution: denoting the Fokker-Planck operators associated to these ﬂows by L\u0004\nH\nand L\u0004\nO we have\nL\u0004\nH\u0005ˇ D 0;\nL\u0004\nO\u0005ˇ D 0;\nand hence\nexp.tL\u0004\nH/\u0005ˇ D exp.tL\u0004\nO/\u0005ˇ D \u0005ˇ:\nWe can consider the propagation of measure resulting from a numerical discretiza-\ntion deﬁned by the composition of these two pieces. For a scheme \u0002HO\u0003, we have\nthe distribution ﬁrst propagated under Hamiltonian dynamics, and then the momenta\nare evolved as the solution to the Ornstein-Uhlenbeck process, which clearly will\npreserve the Gibbs measure\nexp.hL\u0004\nO/\n\u0006\nexp.hL\u0004\nH/\u0005ˇ\n\u0007\nD exp.hL\u0004\nO/\u0005ˇ D \u0005ˇ:\nThe problem with this “method” is of course that it requires the exact ﬂow map\nof the Hamiltonian system. However, this requirement can be relaxed. Given any\ndivergence free vector ﬁeld f, we have\n\u0003r \u0002 .f\u0005/ D \u0003f \u0002 r\u0005;\nthus\nL\u0004\nf \u0005 D \u0003Lf\u0005:\nIf Lf preserves a ﬁrst integral I, then Lf preserves any distribution which is a\nfunction of I. It follows that any energy-preserving, divergence free vector ﬁeld\nwill always preserve the Gibbs distribution.\nAll symplectic methods preserve the volume, but for a system with no ﬁrst\nintegrals except the energy, it is known from a theorem of Ge and Marsden [400]\nthat a symplectic method cannot preserve the system energy exactly (unless the\nsymplectic method is itself a time-reparameterization of the exact solution). The\noptions for volume preserving non-symplectic discretization methods that conserve\nenergy exactly are limited (standard form schemes that rely on calculation of the\nvector ﬁeld at a few points cannot achieve this [380]).\nA class of methods that do provide the necessary features can be found in the\nwork of Feng Kang [133], referred to as J-splitting by McLachlan and Quispel [261].\nLet J be the skew-symmetric canonical symplectic structure matrix. The idea is to\nconsider a splitting of J into a ﬁnite number K of skew-symmetric matrices Ji,\ni D 1; : : : ; K. This induces a splitting of the Hamiltonian vector ﬁeld into K vector\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。"
  ],
  "issues": [],
  "statement_scope": "传播子共同固定点的组合推论；前两条生成元及半群识别未新增证明。",
  "lean_decl": "MD.Ch07.gibbsComposition",
  "lean_declarations": [
    "MD.Ch07.gibbsComposition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]
```
