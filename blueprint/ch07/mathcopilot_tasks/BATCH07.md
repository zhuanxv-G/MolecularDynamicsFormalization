# BATCH07 第7章原文与陈述审校

## MD-7.4.1-ABOHarmonic
```json
{
  "source_id": "MD-7.4.1-ABOHarmonic",
  "kind": "unnumbered_claim",
  "label": "Example 7.1 / (7.12)",
  "section": "7.4.1",
  "printed_page": "275–276",
  "pdf_page": "296–297",
  "statement_latex": "Example 7.1 Consider the scheme coded $[ABO]$.\nIn the case of the one-dimensional harmonic oscillator, we have $U'(q)=\\Omega^2q$, yielding the compact form of one iteration as\n\\[\\binom{q_{n+1}}{p_{n+1}}=\\begin{bmatrix}1&h/m\\\\-\\Omega^2he^{-h\\gamma}&(1-\\Omega^2h^2/m)e^{-h\\gamma}\\end{bmatrix}\\binom{q_n}{p_n}+\\binom0{\\zeta m^{1/2}R_n}.\\tag{7.12}\\]\nTaking expectations of (7.12) and then taking the limit as $n\\to\\infty$, we see immediately that\n$\\langle q\\rangle_h^{[ABO]}=\\langle p\\rangle_h^{[ABO]}=0$, as $\\mathbb E(R_n)=0$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 296,
      "printed_page": 275,
      "text": "7.4\nError Results for Harmonic Problems\n275\nAssuming that the discretization schemes preserve the ergodic property of\nLangevin dynamics, taking the expectation of these equations and considering the\nlimit as n goes to inﬁnity allows us to compute the invariant average of the schemes,\nand thus to evaluate the perfect sampling bias introduced by the discretization.\n7.4.1\nInvariant Averages for Schemes Using the A, B and O\nSplitting\nThe analysis of schemes using the splitting strategy coded with the A, B and O\npieces is particularly simple, as we use a new random number for each stochastic\nupdate meaning that the random numbers and state variables are not correlated\nbetween steps. Hence we have\nE.\u0006n;iqn/ D E.\u0006n;ipn/ D 0;\nfor any i and n. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then\nconsidering the limit n ! 1 we obtain a closed, linear system of equations\nhq2ih D 2\n11hq2ih C 2\n12hp2ih C 2 11 12hqpih C N\u000611;\nhp2ih D 2\n21hq2ih C 2\n22hp2ih C 2 21 22hqpih C N\u000622;\nhqpih D 11 21hq2ih C 12 22hp2ih C . 11 22 C 12 21/hqpih C N\u000612;\n(7.11)\nwhere we have constants\nN\u000611 D E.\u00062\nn;1/;\nN\u000612 D E.\u0006n;1\u0006n;2/;\nN\u000622 D E.\u00062\nn;2/:\nWe can solve this linear system to ﬁnd the invariant averages computed by the\nchosen discretization scheme for the harmonic oscillator with Hamiltonian (7.6).\nExample 7.1 Consider the scheme coded \u0002ABO\u0003, where\n\u0002ABO\u0003\nqnC1 D qn C hM\u00021pn\npnC1=2 D pn \u0003 hrU.qnC1/\npnC1 D e\u0002h\npnC1=2 C \u0018M1=2Rn\n"
    },
    {
      "pdf_page": 297,
      "printed_page": 276,
      "text": "276\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwith \u0018 D\n\nkBT\n\u0004\n1 \u0003 e\u00022\nh\u0005\u000b1=2, and Rn a vector of unit normal random numbers.\nWe can write this update scheme succinctly as\nqnC1 D qn C hM\u00021pn;\npnC1 D e\u0002h\npn \u0003 he\u0002h\nrU.qn C hM\u00021pn/ C \u0018M1=2Rn:\nIn the case of the one-dimensional harmonic oscillator, we have U0.q/ D ˝2q,\nyielding the compact form of one iteration as\n\u0002 qnC1\npnC1\n\u0003\nD\n\u0002\n1\nh=m\n\u0003˝2he\u0002h\n .1 \u0003 ˝2h2=m/e\u0002h\n\u0003 \u0002 qn\npn\n\u0003\nC\n\u0002\n0\n\u0018m1=2Rn\n\u0003\n:\n(7.12)\nTaking expectations of (7.12) and then taking the limit as n ! 1, we see\nimmediately that\nhqi\u0002ABO\u0003\nh\nD hpi\u0002ABO\u0003\nh\nD 0;\nas E.Rn/ D 0. Plugging the values for ij into (7.11), with\nN\u000611 D N\u000612 D 0;\nN\u000622 D m\u00182;\nwe can solve to ﬁnd the exact value of the method’s stationary averages. For\nexample, the relative increase in the variance of position is computed for the \u0002ABO\u0003\nscheme as\nhq2i\u0002ABO\u0003\nh\nhq2i\nD\neh\nm.1 C e\u0002h\n/2\n2m.1 C e\u0002h\n/ \u0003 h2˝2e\u0002h\nD 1 C \nh=2 C .˝2 C \n2m/h2=.4m/ C O.h3/:\nHence we can see that the \u0002ABO\u0003 scheme gives a ﬁrst-order error in the variance\nof q. For signiﬁcantly small friction (relative to h), the leading order term will be\ndominated by the term at order h2, potentially giving us greater accuracy than we\nwould expect from a ﬁrst order scheme.\nHowever, we see that the error grows exponentially as \n gets large. We can\nexplain this by returning to the deﬁnition of the scheme, which has an O step\n(stochastic ﬂuctuation) immediately preceding the only A step (drift), wiping out\nall force information for inﬁnite friction. In practice, playing with the friction\ncoefﬁcient can affect the rate at which averages converge towards the invariant\naverage.\nFrom the work in Chap.3, we may expect that performing the integration\nsteps symmetrically (by using a Strang splitting) could provide desirable higher\norder behavior. Computing the coefﬁcients in (7.11) for the each of the symmetric\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aboHarmonic",
  "lean_declarations": [
    "MD.Ch07.aboHarmonic",
    "MD.Ch07.aboStationaryMean"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aboHarmonic (m Ω γ θ h R : ℝ) (x : ℝ × ℝ) : ℝ × ℝ :=
  linearUpdate 1 (h/m) (-Ω^2*h*Real.exp (-h*γ)) ((1-Ω^2*h^2/m)*Real.exp (-h*γ)) x
    (0, Real.sqrt (θ*(1-Real.exp (-2*γ*h)))*Real.sqrt m*R)

theorem aboStationaryMean (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : Integrable (fun x ↦ x.1) μ) (hp : Integrable (fun x ↦ x.2) μ)
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    (∫ x, x.1 ∂μ) = 0 ∧ (∫ x, x.2 ∂μ) = 0 := by
  sorry
```

## MD-7.4.1-ABOVariance
```json
{
  "source_id": "MD-7.4.1-ABOVariance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.1",
  "printed_page": "276",
  "pdf_page": "297",
  "statement_latex": "For example, the relative increase in the variance of position is computed for the $[ABO]$ scheme as\n\\[\\frac{\\langle q^2\\rangle_h^{[ABO]}}{\\langle q^2\\rangle}=\\frac{e^{h\\gamma}m(1+e^{-h\\gamma})^2}{2m(1+e^{-h\\gamma})-h^2\\Omega^2e^{-h\\gamma}}\n=1+\\gamma h/2+(\\Omega^2+\\gamma^2m)h^2/(4m)+O(h^3).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 297,
      "printed_page": 276,
      "text": "276\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwith \u0018 D\n\nkBT\n\u0004\n1 \u0003 e\u00022\nh\u0005\u000b1=2, and Rn a vector of unit normal random numbers.\nWe can write this update scheme succinctly as\nqnC1 D qn C hM\u00021pn;\npnC1 D e\u0002h\npn \u0003 he\u0002h\nrU.qn C hM\u00021pn/ C \u0018M1=2Rn:\nIn the case of the one-dimensional harmonic oscillator, we have U0.q/ D ˝2q,\nyielding the compact form of one iteration as\n\u0002 qnC1\npnC1\n\u0003\nD\n\u0002\n1\nh=m\n\u0003˝2he\u0002h\n .1 \u0003 ˝2h2=m/e\u0002h\n\u0003 \u0002 qn\npn\n\u0003\nC\n\u0002\n0\n\u0018m1=2Rn\n\u0003\n:\n(7.12)\nTaking expectations of (7.12) and then taking the limit as n ! 1, we see\nimmediately that\nhqi\u0002ABO\u0003\nh\nD hpi\u0002ABO\u0003\nh\nD 0;\nas E.Rn/ D 0. Plugging the values for ij into (7.11), with\nN\u000611 D N\u000612 D 0;\nN\u000622 D m\u00182;\nwe can solve to ﬁnd the exact value of the method’s stationary averages. For\nexample, the relative increase in the variance of position is computed for the \u0002ABO\u0003\nscheme as\nhq2i\u0002ABO\u0003\nh\nhq2i\nD\neh\nm.1 C e\u0002h\n/2\n2m.1 C e\u0002h\n/ \u0003 h2˝2e\u0002h\nD 1 C \nh=2 C .˝2 C \n2m/h2=.4m/ C O.h3/:\nHence we can see that the \u0002ABO\u0003 scheme gives a ﬁrst-order error in the variance\nof q. For signiﬁcantly small friction (relative to h), the leading order term will be\ndominated by the term at order h2, potentially giving us greater accuracy than we\nwould expect from a ﬁrst order scheme.\nHowever, we see that the error grows exponentially as \n gets large. We can\nexplain this by returning to the deﬁnition of the scheme, which has an O step\n(stochastic ﬂuctuation) immediately preceding the only A step (drift), wiping out\nall force information for inﬁnite friction. In practice, playing with the friction\ncoefﬁcient can affect the rate at which averages converge towards the invariant\naverage.\nFrom the work in Chap.3, we may expect that performing the integration\nsteps symmetrically (by using a Strang splitting) could provide desirable higher\norder behavior. Computing the coefﬁcients in (7.11) for the each of the symmetric\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aboVarianceRatio",
  "lean_declarations": [
    "MD.Ch07.aboVarianceRatio",
    "MD.Ch07.aboVarianceRatio_expansion",
    "MD.Ch07.aboStationaryVariance"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aboVarianceRatio (m Ω γ h : ℝ) : ℝ :=
  Real.exp (h*γ)*m*(1+Real.exp (-h*γ))^2 /
    (2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))

theorem aboVarianceRatio_expansion (m Ω γ : ℝ) (hm : 0 < m) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ aboVarianceRatio m Ω γ h - (1+γ*h/2+(Ω^2+γ^2*m)*h^2/(4*m)))
      (fun h ↦ h^3) := by
  sorry

theorem aboStationaryVariance (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hden : 0 < 2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ / (θ/Ω^2) = aboVarianceRatio m Ω γ h := by
  sorry
```

## MD-7.4.1-Table71
```json
{
  "source_id": "MD-7.4.1-Table71",
  "kind": "unnumbered_claim",
  "label": "Table 7.1",
  "section": "7.4.1",
  "printed_page": "277",
  "pdf_page": "298",
  "statement_latex": "Table 7.1 The expected long-time computed average using the given second-order Langevin dynamics discretization scheme\n\\[\\begin{array}{c|ccc}\n\\text{Scheme}&\\langle q^2\\rangle_h/\\langle q^2\\rangle&\\langle p^2\\rangle_h/\\langle p^2\\rangle&\\langle qp\\rangle\\\\\n[ABOBA]&1&[1-h^2\\Omega^2/(4m)]^{-1}&0\\\\\n[OBABO]&[1-h^2\\Omega^2/(4m)]^{-1}&1&0\\\\\n[BAOAB]&1&1-h^2\\Omega^2/(4m)&0\\\\\n[OABAO]&1-h^2\\Omega^2/(4m)&1&0\n\\end{array}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 298,
      "printed_page": 277,
      "text": "7.4\nError Results for Harmonic Problems\n277\nTable 7.1 The expected long-time computed average using the given second-order Langevin\ndynamics discretization scheme\nScheme\nhq2ih=hq2i\nhp2ih=hp2i\nhqpi\n\u0002ABOBA\u0003\n1\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n0\n\u0002OBABO\u0003\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n1\n0\n\u0002BAOAB\u0003\n1\n1 \u0002 h2˝2=.4m/\n0\n\u0002OABAO\u0003\n1 \u0002 h2˝2=.4m/\n1\n0\nschemes, we are able to compute the exact expected average by solving the linear\nequations. The results are summarized in Table 7.1, where we have not considered\nthe \u0002AOBOA\u0003 and \u0002BOAOB\u0003 schemes due to their inconsistency at large friction\n(this does not preclude the analysis, but limits each those method’s usefulness in\nsimulation). Similar analysis can be conducted for more complicated composition\nschemes involving multiple force evaluations.\nThe mentioned splitting schemes give a second-order error in the computed\naverages, but surprisingly each gives an exact result for computed averages of either\nposition or momentum. The exactness property is not born out of the symmetry of\nthe method, but rather of the speciﬁc order of terms and choice of splitting “building\nblocks”. Even non-symmetric ﬁrst-order schemes can exhibit similar qualities. For\nexample, analysis shows that the schemes denoted \u0002AOAB\u0003 or \u0002BAOA\u0003 both exhibit\na ﬁrst order error in the covariance hqpih D O.h/, however they give exact results\nfor both hq2ih and hp2ih.\n7.4.2\nMore General Schemes\nWe can conduct a similar analysis for any integrator that we can express in the\nform (7.7), simply by plugging in the relevant constants and solving a linear\nequation. The difﬁculty lies when random numbers are reused, leading to correlation\nbetween steps. This requires careful treatment to compute the expectation.\nExample 7.2 Consider the variant of the BBK integrator that recycles the random\nnumber between steps:\nBrünger-Brooks-Karplus with post-step re-use of random number (BBK*)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2RnC1\t=.1 C h\n=2/,\nwhere Rn is a vector of normal random numbers with zero mean and unit variance.\nIn some systems, it can be computationally expensive to generate normal random\nnumbers for each degree of freedom, hence algorithms may re-use the random\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。",
    "4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。",
    "只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.scalarLift",
  "lean_declarations": [
    "MD.Ch07.scalarLift",
    "MD.Ch07.symmetricHarmonicStep",
    "MD.Ch07.symmetricInvariant",
    "MD.Ch07.table71"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def scalarLift (F : Phase 1 → Phase 1) (x : ℝ × ℝ) : ℝ × ℝ :=
  let y := F ((fun _ ↦ x.1),(fun _ ↦ x.2))
  (y.1 0,y.2 0)

def symmetricHarmonicStep (scheme : Fin 4) (m Ω γ θ h : ℝ) (R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if scheme = 0 then aboba masses U γ θ h (fun _ ↦ R)
    else if scheme = 1 then obabo masses U γ θ h (fun _ ↦ R) (fun _ ↦ S)
    else if scheme = 2 then baoab masses U γ θ h (fun _ ↦ R)
    else oabao masses U γ θ h (fun _ ↦ R) (fun _ ↦ S))

def symmetricInvariant (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ symmetricHarmonicStep scheme m Ω γ θ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

theorem table71 (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hinv : symmetricInvariant scheme m Ω γ θ h μ) :
    momentQ μ/(θ/Ω^2) = (if scheme = 1 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 3 then 1-h^2*Ω^2/(4*m) else 1) ∧
    momentP μ/(θ*m) = (if scheme = 0 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 2 then 1-h^2*Ω^2/(4*m) else 1) ∧ momentQP μ = 0 := by
  sorry
```

## MD-7.4.1-NonsymmetricExactMoments
```json
{
  "source_id": "MD-7.4.1-NonsymmetricExactMoments",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.1",
  "printed_page": "277",
  "pdf_page": "298",
  "statement_latex": "For example, analysis shows that the schemes denoted $[AOAB]$ or $[BAOA]$ both exhibit a first order error in the covariance $\\langle qp\\rangle_h=O(h)$, however they give exact results for both $\\langle q^2\\rangle_h$ and $\\langle p^2\\rangle_h$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 298,
      "printed_page": 277,
      "text": "7.4\nError Results for Harmonic Problems\n277\nTable 7.1 The expected long-time computed average using the given second-order Langevin\ndynamics discretization scheme\nScheme\nhq2ih=hq2i\nhp2ih=hp2i\nhqpi\n\u0002ABOBA\u0003\n1\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n0\n\u0002OBABO\u0003\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n1\n0\n\u0002BAOAB\u0003\n1\n1 \u0002 h2˝2=.4m/\n0\n\u0002OABAO\u0003\n1 \u0002 h2˝2=.4m/\n1\n0\nschemes, we are able to compute the exact expected average by solving the linear\nequations. The results are summarized in Table 7.1, where we have not considered\nthe \u0002AOBOA\u0003 and \u0002BOAOB\u0003 schemes due to their inconsistency at large friction\n(this does not preclude the analysis, but limits each those method’s usefulness in\nsimulation). Similar analysis can be conducted for more complicated composition\nschemes involving multiple force evaluations.\nThe mentioned splitting schemes give a second-order error in the computed\naverages, but surprisingly each gives an exact result for computed averages of either\nposition or momentum. The exactness property is not born out of the symmetry of\nthe method, but rather of the speciﬁc order of terms and choice of splitting “building\nblocks”. Even non-symmetric ﬁrst-order schemes can exhibit similar qualities. For\nexample, analysis shows that the schemes denoted \u0002AOAB\u0003 or \u0002BAOA\u0003 both exhibit\na ﬁrst order error in the covariance hqpih D O.h/, however they give exact results\nfor both hq2ih and hp2ih.\n7.4.2\nMore General Schemes\nWe can conduct a similar analysis for any integrator that we can express in the\nform (7.7), simply by plugging in the relevant constants and solving a linear\nequation. The difﬁculty lies when random numbers are reused, leading to correlation\nbetween steps. This requires careful treatment to compute the expectation.\nExample 7.2 Consider the variant of the BBK integrator that recycles the random\nnumber between steps:\nBrünger-Brooks-Karplus with post-step re-use of random number (BBK*)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2RnC1\t=.1 C h\n=2/,\nwhere Rn is a vector of normal random numbers with zero mean and unit variance.\nIn some systems, it can be computationally expensive to generate normal random\nnumbers for each degree of freedom, hence algorithms may re-use the random\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。",
    "本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "两个非对称算法精确位置/动量二阶矩；协方差阶数暂缺。",
  "lean_decl": "MD.Ch07.nonsymmetricHarmonicStep",
  "lean_declarations": [
    "MD.Ch07.nonsymmetricHarmonicStep",
    "MD.Ch07.nonsymmetricExactMoments"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m := by
  sorry
```

## MD-7.4.2-BBKStar
```json
{
  "source_id": "MD-7.4.2-BBKStar",
  "kind": "definition",
  "label": "Example 7.2",
  "section": "7.4.2",
  "printed_page": "277–278",
  "pdf_page": "298–299",
  "statement_latex": "Example 7.2 Consider the variant of the BBK integrator that recycles the random number between steps:\nBrünger-Brooks-Karplus with post-step re-use of random number (BBK*)\n\\[p_{n+1/2}=(1-h\\gamma/2)p_n-(h/2)\\nabla U(q_n)+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R_n,\\]\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\qquad\np_{n+1}=[p_{n+1/2}-(h/2)\\nabla U(q_{n+1})+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R_{n+1}]/(1+h\\gamma/2),\\]\nwhere $R_n$ is a vector of normal random numbers with zero mean and unit variance.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 298,
      "printed_page": 277,
      "text": "7.4\nError Results for Harmonic Problems\n277\nTable 7.1 The expected long-time computed average using the given second-order Langevin\ndynamics discretization scheme\nScheme\nhq2ih=hq2i\nhp2ih=hp2i\nhqpi\n\u0002ABOBA\u0003\n1\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n0\n\u0002OBABO\u0003\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n1\n0\n\u0002BAOAB\u0003\n1\n1 \u0002 h2˝2=.4m/\n0\n\u0002OABAO\u0003\n1 \u0002 h2˝2=.4m/\n1\n0\nschemes, we are able to compute the exact expected average by solving the linear\nequations. The results are summarized in Table 7.1, where we have not considered\nthe \u0002AOBOA\u0003 and \u0002BOAOB\u0003 schemes due to their inconsistency at large friction\n(this does not preclude the analysis, but limits each those method’s usefulness in\nsimulation). Similar analysis can be conducted for more complicated composition\nschemes involving multiple force evaluations.\nThe mentioned splitting schemes give a second-order error in the computed\naverages, but surprisingly each gives an exact result for computed averages of either\nposition or momentum. The exactness property is not born out of the symmetry of\nthe method, but rather of the speciﬁc order of terms and choice of splitting “building\nblocks”. Even non-symmetric ﬁrst-order schemes can exhibit similar qualities. For\nexample, analysis shows that the schemes denoted \u0002AOAB\u0003 or \u0002BAOA\u0003 both exhibit\na ﬁrst order error in the covariance hqpih D O.h/, however they give exact results\nfor both hq2ih and hp2ih.\n7.4.2\nMore General Schemes\nWe can conduct a similar analysis for any integrator that we can express in the\nform (7.7), simply by plugging in the relevant constants and solving a linear\nequation. The difﬁculty lies when random numbers are reused, leading to correlation\nbetween steps. This requires careful treatment to compute the expectation.\nExample 7.2 Consider the variant of the BBK integrator that recycles the random\nnumber between steps:\nBrünger-Brooks-Karplus with post-step re-use of random number (BBK*)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2RnC1\t=.1 C h\n=2/,\nwhere Rn is a vector of normal random numbers with zero mean and unit variance.\nIn some systems, it can be computationally expensive to generate normal random\nnumbers for each degree of freedom, hence algorithms may re-use the random\n"
    },
    {
      "pdf_page": 299,
      "printed_page": 278,
      "text": "278\n7\nNumerical Methods for Stochastic Molecular Dynamics\nnumbers between iterations to give a small computational saving. We can see that\nonly one vector of random numbers is generated per iteration, with the new vector of\nrandom numbers being used in the following iteration. This gives some correlation\nbetween steps that complicates our analysis a little.\nIf we wish to ﬁnd the perfect sampling bias in the case of the one-dimensional\nharmonic oscillator, we can apply this technique to ﬁnd the invariant averages under\nthis scheme. We have\n\f BBK* D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK*\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C RnC1\n\u0007\n3\n5 D\n\u0002\n\n1Rn\n\n2Rn C \n3RnC1\n\u0003\n;\nusing the notation in (7.7). Taking expectations of the resulting equations, we can\ncompute the values of the constants in (7.8)–(7.10) and solve to ﬁnd the long-\ntime averages. Care must be taken however, as unlike the schemes using the ABO\nsplitting we must include some correlation between steps. Denoting the entries of\n\f BBK* by ij we have\nE.\u0006n;2pn/ D E ..\n2Rn C \n3RnC1/ . 21qn\u00021 C 22pn\u00021 C \n2Rn\u00021 C \n3Rn// ;\nD \n2\n3:\nThis additional quantity will slightly change the expectation of (7.9) compared to the\nstandard BBK method, and hence the overall averages of the scheme. Additionally\nit is easily shown that\nE.\u0006n;1qn/ D E.\u0006n;2qn/ D 0;\nE.\u0006n;1pn/ D \n1\n3;\nwith\nE.\u00062\nn;1/ D \n2\n1;\nE.\u0006n;1\u0006n;2/ D \n1\n2;\nE.\u00062\nn;2/ D \n2\n2 C \n2\n3:\nThus taking expectations of (7.8)–(7.10) and substituting in the constants gives\nhq2iBBK*\nh\nD 2\n11hq2iBBK*\nh\nC 2\n12hp2iBBK*\nh\nC 2 11 12hqpiBBK*\nh\nC 2 12\n12 12\n1\n3\nC \n2\n1;\nhp2iBBK*\nh\nD 2\n21hq2iBBK*\nh\nC 2\n22hp2iBBK*\nh\nC 2 21 22hqpiBBK*\nh\nC 2 22\n22 22\n2\n3\nC \n2\n2 C \n2\n3;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarTrajectory",
  "lean_declarations": [
    "MD.Ch07.bbkStarTrajectory",
    "MD.Ch07.bbkStarNoise"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)
```

## MD-7.4.2-BBKStarCorrelations
```json
{
  "source_id": "MD-7.4.2-BBKStarCorrelations",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.2",
  "printed_page": "278",
  "pdf_page": "299",
  "statement_latex": "Denoting the entries of $\\Psi^{\\rm BBK*}$ by $\\psi_{ij}$ we have\n\\[\\mathbb E(\\mu_{n,2}p_n)=\\mathbb E((\\kappa_2R_n+\\kappa_3R_{n+1})(\\psi_{21}q_{n-1}+\\psi_{22}p_{n-1}+\\kappa_2R_{n-1}+\\kappa_3R_n))=\\kappa_2\\kappa_3.\\]\nAdditionally it is easily shown that\n\\[\\mathbb E(\\mu_{n,1}q_n)=\\mathbb E(\\mu_{n,2}q_n)=0,\\quad \\mathbb E(\\mu_{n,1}p_n)=\\kappa_1\\kappa_3,\\]\nwith $\\mathbb E(\\mu_{n,1}^2)=\\kappa_1^2$, $\\mathbb E(\\mu_{n,1}\\mu_{n,2})=\\kappa_1\\kappa_2$, $\\mathbb E(\\mu_{n,2}^2)=\\kappa_2^2+\\kappa_3^2$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 299,
      "printed_page": 278,
      "text": "278\n7\nNumerical Methods for Stochastic Molecular Dynamics\nnumbers between iterations to give a small computational saving. We can see that\nonly one vector of random numbers is generated per iteration, with the new vector of\nrandom numbers being used in the following iteration. This gives some correlation\nbetween steps that complicates our analysis a little.\nIf we wish to ﬁnd the perfect sampling bias in the case of the one-dimensional\nharmonic oscillator, we can apply this technique to ﬁnd the invariant averages under\nthis scheme. We have\n\f BBK* D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK*\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C RnC1\n\u0007\n3\n5 D\n\u0002\n\n1Rn\n\n2Rn C \n3RnC1\n\u0003\n;\nusing the notation in (7.7). Taking expectations of the resulting equations, we can\ncompute the values of the constants in (7.8)–(7.10) and solve to ﬁnd the long-\ntime averages. Care must be taken however, as unlike the schemes using the ABO\nsplitting we must include some correlation between steps. Denoting the entries of\n\f BBK* by ij we have\nE.\u0006n;2pn/ D E ..\n2Rn C \n3RnC1/ . 21qn\u00021 C 22pn\u00021 C \n2Rn\u00021 C \n3Rn// ;\nD \n2\n3:\nThis additional quantity will slightly change the expectation of (7.9) compared to the\nstandard BBK method, and hence the overall averages of the scheme. Additionally\nit is easily shown that\nE.\u0006n;1qn/ D E.\u0006n;2qn/ D 0;\nE.\u0006n;1pn/ D \n1\n3;\nwith\nE.\u00062\nn;1/ D \n2\n1;\nE.\u0006n;1\u0006n;2/ D \n1\n2;\nE.\u00062\nn;2/ D \n2\n2 C \n2\n3:\nThus taking expectations of (7.8)–(7.10) and substituting in the constants gives\nhq2iBBK*\nh\nD 2\n11hq2iBBK*\nh\nC 2\n12hp2iBBK*\nh\nC 2 11 12hqpiBBK*\nh\nC 2 12\n12 12\n1\n3\nC \n2\n1;\nhp2iBBK*\nh\nD 2\n21hq2iBBK*\nh\nC 2\n22hp2iBBK*\nh\nC 2 21 22hqpiBBK*\nh\nC 2 22\n22 22\n2\n3\nC \n2\n2 C \n2\n3;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "Qold/Pold代表吸收R_{n-1}后仍独立于未来R_n,R_{n+1}的旧状态组合；不把当前p与R_n假设独立。",
    "所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarCorrelations",
  "lean_declarations": [
    "MD.Ch07.bbkStarCorrelations"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem bbkStarCorrelations (P : Measure Ω) [IsProbabilityMeasure P]
    (R S Qold Pold : Ω → ℝ) (a b c d κ1 κ2 κ3 : ℝ)
    (hR : HasLaw R (gaussianReal 0 1) P) (hS : HasLaw S (gaussianReal 0 1) P)
    (hind : IndepFun (fun sample ↦ (Qold sample,Pold sample)) (fun sample ↦ (R sample,S sample)) P)
    (hRS : IndepFun R S P) (hq : MemLp Qold 2 P) (hp : MemLp Pold 2 P) :
    let q := fun sample ↦ a*Qold sample+b*Pold sample
    let p := fun sample ↦ c*Qold sample+d*Pold sample+κ3*R sample
    let u := fun sample ↦ κ1*R sample
    let v := fun sample ↦ κ2*R sample+κ3*S sample
    (∫ sample, v sample*p sample ∂P) = κ2*κ3 ∧
    (∫ sample, u sample*q sample ∂P) = 0 ∧
    (∫ sample, v sample*q sample ∂P) = 0 ∧
    (∫ sample, u sample*p sample ∂P) = κ1*κ3 ∧
    (∫ sample, (u sample)^2 ∂P) = κ1^2 ∧
    (∫ sample, u sample*v sample ∂P) = κ1*κ2 ∧
    (∫ sample, (v sample)^2 ∂P) = κ2^2+κ3^2 := by
  sorry
```
