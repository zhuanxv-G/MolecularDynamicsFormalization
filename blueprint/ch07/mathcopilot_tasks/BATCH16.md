# BATCH16 第7章原文与陈述审校

## MD-7.9.3-SuperconvergenceScope
```json
{
  "source_id": "MD-7.9.3-SuperconvergenceScope",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.3",
  "printed_page": "306",
  "pdf_page": "327",
  "statement_latex": "Thus we expect that the $[BAOAB]$ scheme recovers $O(h^4)$ configurational averages in the limit of infinite friction.\nIts conjugate method, the $[OABAO]$ scheme, has the property\n\\[\\int_{\\mathcal Q}f_{2,0,[OABAO]}(q,p)\\rho_\\beta(q,p)d\\omega_q=0,\\]\nimplying that we obtain high-order averages for functions purely of the momenta in the limit of infinite friction.\nIt is important to note that this superconvergence property is only present in the limit of large time, i.e. this is an attribute of the invariant distribution of the discretization schemes $\\widehat\\rho$. As such, there are no bonuses to the weak or strong order of the superconvergent schemes.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 327,
      "printed_page": 306,
      "text": "306\n7\nNumerical Methods for Stochastic Molecular Dynamics\nThus we expect that the \u0002BAOAB\u0003 scheme recovers O.h4/ conﬁgurational averages\nin the limit of inﬁnite friction. This scheme requires no extra force evaluations, and\nthis particular feature appears to simply be a serendipitous result of the form of the\ncorrection function.\nThis is a property common to no other Langevin splitting scheme that we are\naware of. Though curiously its conjugate method, the \u0002OABAO\u0003 scheme, has the\nproperty\nZ\nQ\nf2;0;\u0002OABAO\u0003.q; p/\u0005ˇ.q; p/d!q D 0;\nimplying that we obtain high-order averages for functions purely of the momenta\nin the limit of inﬁnite friction. However, as the momenta are always Gaussian\ndistributed in canonical sampling, we are far more interested in functions of position\nto high accuracy (and sampling exp.\u0003ˇU.q// rather than the Gaussian-distributed\nmomenta).\nIt is important to note that this superconvergence property is only present in\nthe limit of large time, i.e. this is an attribute of the invariant distribution of the\ndiscretization schemes O\u0005. As such, there are no bonuses to the weak or strong order\nof the superconvergent schemes, though equally there is no added cost to using the\nmethods.\nAll of the symmetric splitting schemes discussed are very easy to implement\nrelative to other popular Langevin integrators, as many codes already implement\nthe standard velocity Verlet \u0002BAB\u0003 style integration. An exact Ornstein-Uhlenbeck\nsolve can be added where it is required in the scheme in order to effectively integrate\nLangevin dynamics: then setting \n D 0 reduces the integrator to a standard Verlet\nscheme, integrating deterministic Newtonian dynamics.\n7.10\nThe Limit Method\nWe now consider schemes in the limit \n ! 1, where the exact solution of the\nvector OU process reduces to redrawing momenta from the canonical distribution,\nso pnC1 D pkBTM1=2R, where R is a vector of i.i.d. normal random numbers.\nAlternatively, we could consider the limit of the particle mass going to 0, although\nthis requires a reformulation of Langevin dynamics (7.4) so that the friction is\nproportional to the velocity instead of the momentum [233]. Whichever limit\nis taken, we would expect the ultimate result to be the same. (Here we have\nreintroduced the masses in order to present the method, since they may be useful\nscaling parameters in simulation.)\nThe ﬁrst order schemes of the form \u0002XYZ\u0003, as well as schemes such as\n\u0002XOYOX\u0003 are not consistent in this overdamped limit: the errors in computed\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。",
    "四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.oabaoPositionCancellation",
  "lean_declarations": [
    "MD.Ch07.oabaoPositionCancellation",
    "MD.Ch07.superconvergence_fromBound"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem oabaoPositionCancellation (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U)
    (hweight : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hgrad : ∀ i, Integrable (fun q ↦ (hessianU U q i i-β*gradient U q i^2)*Real.exp (-β*U q)) volume)
    (hboundary : ∀ q i, Filter.Tendsto
      (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, highFrictionOABAO U β q ∂positionGibbs U β) = 0 := by
  sorry
theorem superconvergence_fromBound (A : ℝ → ℝ) (exact : ℝ)
    (hA : Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact-h^2*(0 : ℝ)) (fun h ↦ h^4)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact) (fun h ↦ h^4) := by
  simpa using hA
```

## MD-7.10-MomentumRedrawLimit
```json
{
  "source_id": "MD-7.10-MomentumRedrawLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.10",
  "printed_page": "306",
  "pdf_page": "327",
  "statement_latex": "We now consider schemes in the limit $\\gamma\\to\\infty$, where the exact solution of the vector OU process reduces to redrawing momenta from the canonical distribution, so $p_{n+1}=\\sqrt{k_BT}M^{1/2}R$, where $R$ is a vector of i.i.d. normal random numbers.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 327,
      "printed_page": 306,
      "text": "306\n7\nNumerical Methods for Stochastic Molecular Dynamics\nThus we expect that the \u0002BAOAB\u0003 scheme recovers O.h4/ conﬁgurational averages\nin the limit of inﬁnite friction. This scheme requires no extra force evaluations, and\nthis particular feature appears to simply be a serendipitous result of the form of the\ncorrection function.\nThis is a property common to no other Langevin splitting scheme that we are\naware of. Though curiously its conjugate method, the \u0002OABAO\u0003 scheme, has the\nproperty\nZ\nQ\nf2;0;\u0002OABAO\u0003.q; p/\u0005ˇ.q; p/d!q D 0;\nimplying that we obtain high-order averages for functions purely of the momenta\nin the limit of inﬁnite friction. However, as the momenta are always Gaussian\ndistributed in canonical sampling, we are far more interested in functions of position\nto high accuracy (and sampling exp.\u0003ˇU.q// rather than the Gaussian-distributed\nmomenta).\nIt is important to note that this superconvergence property is only present in\nthe limit of large time, i.e. this is an attribute of the invariant distribution of the\ndiscretization schemes O\u0005. As such, there are no bonuses to the weak or strong order\nof the superconvergent schemes, though equally there is no added cost to using the\nmethods.\nAll of the symmetric splitting schemes discussed are very easy to implement\nrelative to other popular Langevin integrators, as many codes already implement\nthe standard velocity Verlet \u0002BAB\u0003 style integration. An exact Ornstein-Uhlenbeck\nsolve can be added where it is required in the scheme in order to effectively integrate\nLangevin dynamics: then setting \n D 0 reduces the integrator to a standard Verlet\nscheme, integrating deterministic Newtonian dynamics.\n7.10\nThe Limit Method\nWe now consider schemes in the limit \n ! 1, where the exact solution of the\nvector OU process reduces to redrawing momenta from the canonical distribution,\nso pnC1 D pkBTM1=2R, where R is a vector of i.i.d. normal random numbers.\nAlternatively, we could consider the limit of the particle mass going to 0, although\nthis requires a reformulation of Langevin dynamics (7.4) so that the friction is\nproportional to the velocity instead of the momentum [233]. Whichever limit\nis taken, we would expect the ultimate result to be the same. (Here we have\nreintroduced the masses in order to present the method, since they may be useful\nscaling parameters in simulation.)\nThe ﬁrst order schemes of the form \u0002XYZ\u0003, as well as schemes such as\n\u0002XOYOX\u0003 are not consistent in this overdamped limit: the errors in computed\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.redrawMomentum",
  "lean_declarations": [
    "MD.Ch07.redrawMomentum",
    "MD.Ch07.redrawStep",
    "MD.Ch07.momentumRedrawLimit"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry
```

## MD-7.10-OBABOOverdampedEuler
```json
{
  "source_id": "MD-7.10-OBABOOverdampedEuler",
  "kind": "unnumbered_claim",
  "label": "(7.38)–(7.39)",
  "section": "7.10",
  "printed_page": "307",
  "pdf_page": "328",
  "statement_latex": "For the method denoted $[OBABO]$, we have the limiting scheme\n\\[p_{n+1/2}=\\sqrt{k_BT}M^{1/2}R_n,\\quad \\widehat p_{n+1/2}=p_{n+1/2}-(h/2)\\nabla U(q_n),\\]\n\\[q_{n+1}=q_n+hM^{-1}\\widehat p_{n+1/2},\\quad\n\\widehat p_{n+1}=\\widehat p_{n+1/2}-(h/2)\\nabla U(q_{n+1}),\\quad p_{n+1}=\\sqrt{k_BT}M^{1/2}R_{n+1/2}.\\]\n\\[q_{n+1}=q_n-\\tfrac{h^2}{2}M^{-1}\\nabla U(q_n)+h\\sqrt{k_BT}M^{-1/2}R_n.\\tag{7.38}\\]\nDenoting $\\tau=h^2/2$, the update scheme (7.38) becomes the Euler-Maruyama scheme\n\\[q_{n+1}=q_n-\\tau M^{-1}\\nabla U(q_n)+\\sqrt{2\\tau k_BT}M^{-1/2}R_n.\\tag{7.39}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 328,
      "printed_page": 307,
      "text": "7.10\nThe Limit Method\n307\nobservable averages diverge and we do not recover correct sampling in the limit\nof zero stepsize.\nThe symmetric schemes considered in the previous section are consistent\nhowever, each with their own limiting schemes corresponding to taking the limit\nof inﬁnite friction in their update equations. As the momenta are continually\nredrawn from a normal distribution, we focus on the evolution of the conﬁgurations\nthemselves. For the method denoted \u0002OBABO\u0003, we have the limiting scheme\npnC1=2 D\np\nkBTM1=2Rn;\nOpnC1=2 D pnC1=2 \u0003 .h=2/rU.qn/;\nqnC1 D qn C hM\u00021OpnC1=2;\nOpnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/;\npnC1 D\np\nkBTM1=2RnC1=2;\nwhere Rn and RnC1=2 are independent normal random vectors with mean zero and\nunit variance. It is clear that if our only desire is to make use of the position data q,\nthen the ﬁnal two steps are redundant in this algorithm, as we update the momentum\nvector only to redraw it at the beginning of the next iteration. Any information about\nthe initial momentum vector pn is unused in the scheme, making it simple to rewrite\nsolely in terms of the position vector, giving us\nqnC1 D qn \u0003 h2\n2 M\u00021rU.qn/ C h\np\nkBTM\u00021=2Rn:\n(7.38)\nDenoting \u0002 D h2=2, the update scheme (7.38) becomes the Euler-Maruyama\nscheme\nqnC1 D qn \u0003 \u0002M\u00021rU.qn/ C\np\n2\u0002kBTM\u00021=2Rn;\n(7.39)\nwhich is known to give an error in long-time averages O.\u0002/ D O.h2/, just as our\nanalysis suggests.\nIf we instead consider the \u0002BAOAB\u0003 scheme we ﬁnd that unlike the \u0002OBABO\u0003\nscheme we no longer have redundant steps:\npnC1=2 D pn \u0003 .h=2/rU.qn/;\nqnC1=2 D qn C .h=2/M\u00021pnC1=2;\nOpnC1=2 D\np\nkBTM1=2Rn;\nqnC1 D qnC1=2 C .h=2/M\u00021OpnC1=2;\npnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.obaboInfinite",
  "lean_declarations": [
    "MD.Ch07.obaboInfinite",
    "MD.Ch07.overdampedEulerH",
    "MD.Ch07.overdampedEuler",
    "MD.Ch07.obaboInfinite_position",
    "MD.Ch07.overdampedEuler_rescale"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def obaboInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  redrawStep m θ S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ redrawStep m θ R
def overdampedEulerH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-h^2/2/m i*gradient U q i+h/m i*redrawMomentum m θ R i
def overdampedEuler (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*R i
theorem obaboInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) (x : Phase n) :
    (obaboInfinite m U θ h R S x).1 = overdampedEulerH m U θ h R x.1 := by
  funext i
  dsimp [obaboInfinite,redrawStep,kickStep,driftStep,overdampedEulerH,Function.comp_def]
  ring
theorem overdampedEuler_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    overdampedEulerH m U θ h R q = overdampedEuler m U θ (h^2/2) R q := by
  sorry
```

## MD-7.10-BAOABLimitMethod
```json
{
  "source_id": "MD-7.10-BAOABLimitMethod",
  "kind": "unnumbered_claim",
  "label": "(7.40)",
  "section": "7.10",
  "printed_page": "307–308",
  "pdf_page": "328–329",
  "statement_latex": "\\[p_{n+1/2}=p_n-(h/2)\\nabla U(q_n),\\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\]\n\\[\\widehat p_{n+1/2}=\\sqrt{k_BT}M^{1/2}R_n,\\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\\widehat p_{n+1/2},\\quad\np_{n+1}=\\widehat p_{n+1/2}-(h/2)\\nabla U(q_{n+1}).\\]\nExpressing this as an update solely for the configurations, we obtain\n\\[q_{n+1}=q_n-\\tfrac{h^2}{2}M^{-1}\\nabla U(q_n)+\\tfrac h2\\sqrt{k_BT}M^{-1/2}(R_n+R_{n-1}),\\]\nand substituting $\\tau=h^2/2$ gives the BAOAB Limit Method (Leimkuhler-Matthews method)\n\\[q_{n+1}=q_n-\\tau M^{-1}\\nabla U(q_n)+\\sqrt{2\\tau k_BT}M^{-1/2}\\left(\\tfrac{R_n+R_{n-1}}2\\right).\\tag{7.40}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 328,
      "printed_page": 307,
      "text": "7.10\nThe Limit Method\n307\nobservable averages diverge and we do not recover correct sampling in the limit\nof zero stepsize.\nThe symmetric schemes considered in the previous section are consistent\nhowever, each with their own limiting schemes corresponding to taking the limit\nof inﬁnite friction in their update equations. As the momenta are continually\nredrawn from a normal distribution, we focus on the evolution of the conﬁgurations\nthemselves. For the method denoted \u0002OBABO\u0003, we have the limiting scheme\npnC1=2 D\np\nkBTM1=2Rn;\nOpnC1=2 D pnC1=2 \u0003 .h=2/rU.qn/;\nqnC1 D qn C hM\u00021OpnC1=2;\nOpnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/;\npnC1 D\np\nkBTM1=2RnC1=2;\nwhere Rn and RnC1=2 are independent normal random vectors with mean zero and\nunit variance. It is clear that if our only desire is to make use of the position data q,\nthen the ﬁnal two steps are redundant in this algorithm, as we update the momentum\nvector only to redraw it at the beginning of the next iteration. Any information about\nthe initial momentum vector pn is unused in the scheme, making it simple to rewrite\nsolely in terms of the position vector, giving us\nqnC1 D qn \u0003 h2\n2 M\u00021rU.qn/ C h\np\nkBTM\u00021=2Rn:\n(7.38)\nDenoting \u0002 D h2=2, the update scheme (7.38) becomes the Euler-Maruyama\nscheme\nqnC1 D qn \u0003 \u0002M\u00021rU.qn/ C\np\n2\u0002kBTM\u00021=2Rn;\n(7.39)\nwhich is known to give an error in long-time averages O.\u0002/ D O.h2/, just as our\nanalysis suggests.\nIf we instead consider the \u0002BAOAB\u0003 scheme we ﬁnd that unlike the \u0002OBABO\u0003\nscheme we no longer have redundant steps:\npnC1=2 D pn \u0003 .h=2/rU.qn/;\nqnC1=2 D qn C .h=2/M\u00021pnC1=2;\nOpnC1=2 D\np\nkBTM1=2Rn;\nqnC1 D qnC1=2 C .h=2/M\u00021OpnC1=2;\npnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/;\n"
    },
    {
      "pdf_page": 329,
      "printed_page": 308,
      "text": "308\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere Rnis an independent normal random vector with mean zero and unit variance.\nExpressing this as an update solely for the conﬁgurations, we obtain\nqnC1 D qn \u0003 h2\n2 M\u00021rU.qn/ C h\n2\np\nkBTM\u00021=2 .Rn C Rn\u00021/ ;\nand substituting \u0002 D h2=2 gives the BAOAB Limit Method (Leimkuhler-Matthews\nmethod) [221]\nqnC1 D qn \u0003 \u0002M\u00021rU.qn/ C\np\n2\u0002kBTM\u00021=2\n\bRn C Rn\u00021\n2\n\t\n:\n(7.40)\nAs we are in the overdamped regime, we would expect that this scheme should\nhave an O.h4/ D O.\u00022/ error in conﬁgurational averages, while inheriting the\nother properties of the \u0002BAOAB\u0003 scheme for the harmonic and perturbed harmonic\nmodels considered in Sects. 7.4 and 7.5. Moreover, since we completely remove the\nsecond order term in the Langevin dynamics conﬁgurational density expansion, we\nexpect to observe this behavior across all values of h and \u0002. This is quite a surprising\nresult, given the qualitative similarity between Eqs. (7.39) and (7.40).\nThe beneﬁt of (7.40) over the Euler-Maruyama scheme is that we can get second\norder accuracy in averages with only a single evaluation of the force at each\ntimestep. However, our analysis presented here is only for the inﬁnite time case.\nFor averages computed in ﬁnite time, work in [224] has shown that (7.40) does\nindeed give a ﬁrst order error, albeit one that vanishes exponentially fast in time as\nthe simulation progresses. Hence for suitably long simulations, the observed error\nwill be O.h2/.\nWe can think of the noise process in (7.40) as corresponding to a colored noise\nwhich has characteristics that directly depend on the stepsize, although the noise\ndecorrelates in just a couple of timesteps. This is therefore no longer a Markov\nprocess, however it can be reformulated as such if one considers the appropriate\nextended space (or keeping the momenta pn).\n7.11\nApplying the Schemes to a Biomolecule\nNumerical analysis of a scheme should always be supported (and informed by)\nthorough numerical testing. Often salient features of a discretization method can be\nmissed because of a shallow scope of experimentation. Our goal will be to evaluate\nthe efﬁcacy of the numerical schemes for Langevin dynamics presented thus far. We\nshall look at the invariant (long-time) averages resulting from computations using\nthe four symmetric Langevin integrators that we derived using our splitting, for\nwhich results for the harmonic oscillator are detailed in (7.15), and for which a more\ngeneral error analysis was considered in Sect. 7.9.2. Additionally we will compare\ntheir results to the performance of the standard SPV and BBK schemes considered\nin Sect. 7.3.2.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。",
    "完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.baoabInfinite",
  "lean_declarations": [
    "MD.Ch07.baoabInfinite",
    "MD.Ch07.lmStepH",
    "MD.Ch07.lmStep",
    "MD.Ch07.baoabInfinite_position"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def baoabInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ redrawStep m θ R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def lmStepH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-h^2/(2*m i)*gradient U q i+h/(2*m i)*(redrawMomentum m θ R i+redrawMomentum m θ S i)
def lmStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*((R i+S i)/2)
theorem baoabInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) :
    (baoabInfinite m U θ h R (q,fun i ↦ redrawMomentum m θ S i-h/2*gradient U q i)).1 =
      lmStepH m U θ h R S q := by
  funext i
  dsimp [baoabInfinite,lmStepH,kickStep,driftStep,redrawStep,Function.comp_def]
  ring
```

## MD-7.10-ColoredNoiseAndExtension
```json
{
  "source_id": "MD-7.10-ColoredNoiseAndExtension",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.10",
  "printed_page": "308",
  "pdf_page": "329",
  "statement_latex": "We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $p_n$).",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 329,
      "printed_page": 308,
      "text": "308\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere Rnis an independent normal random vector with mean zero and unit variance.\nExpressing this as an update solely for the conﬁgurations, we obtain\nqnC1 D qn \u0003 h2\n2 M\u00021rU.qn/ C h\n2\np\nkBTM\u00021=2 .Rn C Rn\u00021/ ;\nand substituting \u0002 D h2=2 gives the BAOAB Limit Method (Leimkuhler-Matthews\nmethod) [221]\nqnC1 D qn \u0003 \u0002M\u00021rU.qn/ C\np\n2\u0002kBTM\u00021=2\n\bRn C Rn\u00021\n2\n\t\n:\n(7.40)\nAs we are in the overdamped regime, we would expect that this scheme should\nhave an O.h4/ D O.\u00022/ error in conﬁgurational averages, while inheriting the\nother properties of the \u0002BAOAB\u0003 scheme for the harmonic and perturbed harmonic\nmodels considered in Sects. 7.4 and 7.5. Moreover, since we completely remove the\nsecond order term in the Langevin dynamics conﬁgurational density expansion, we\nexpect to observe this behavior across all values of h and \u0002. This is quite a surprising\nresult, given the qualitative similarity between Eqs. (7.39) and (7.40).\nThe beneﬁt of (7.40) over the Euler-Maruyama scheme is that we can get second\norder accuracy in averages with only a single evaluation of the force at each\ntimestep. However, our analysis presented here is only for the inﬁnite time case.\nFor averages computed in ﬁnite time, work in [224] has shown that (7.40) does\nindeed give a ﬁrst order error, albeit one that vanishes exponentially fast in time as\nthe simulation progresses. Hence for suitably long simulations, the observed error\nwill be O.h2/.\nWe can think of the noise process in (7.40) as corresponding to a colored noise\nwhich has characteristics that directly depend on the stepsize, although the noise\ndecorrelates in just a couple of timesteps. This is therefore no longer a Markov\nprocess, however it can be reformulated as such if one considers the appropriate\nextended space (or keeping the momenta pn).\n7.11\nApplying the Schemes to a Biomolecule\nNumerical analysis of a scheme should always be supported (and informed by)\nthorough numerical testing. Often salient features of a discretization method can be\nmissed because of a shallow scope of experimentation. Our goal will be to evaluate\nthe efﬁcacy of the numerical schemes for Langevin dynamics presented thus far. We\nshall look at the invariant (long-time) averages resulting from computations using\nthe four symmetric Langevin integrators that we derived using our splitting, for\nwhich results for the harmonic oscillator are detailed in (7.15), and for which a more\ngeneral error analysis was considered in Sect. 7.9.2. Additionally we will compare\ntheir results to the performance of the standard SPV and BBK schemes considered\nin Sect. 7.3.2.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "MA(1)噪声以相邻两独立Gaussian平均定义；定义扩展状态(q,R旧)的完整一步映射。非Markov性的普遍表述依赖具体势和初值，未把任意位置过程都判非Markov；扩展Markov核与半群律仍是覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.coloredNoise",
  "lean_declarations": [
    "MD.Ch07.coloredNoise",
    "MD.Ch07.coloredNoise_covariance",
    "MD.Ch07.lmExtendedStep"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)
```

## MD-7.10-LimitMethodAccuracy
```json
{
  "source_id": "MD-7.10-LimitMethodAccuracy",
  "kind": "definition",
  "label": null,
  "section": "7.10",
  "printed_page": "308",
  "pdf_page": "329",
  "statement_latex": "We would expect that this scheme should have an $O(h^4)=O(\\tau^2)$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $O(h^2)$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 329,
      "printed_page": 308,
      "text": "308\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere Rnis an independent normal random vector with mean zero and unit variance.\nExpressing this as an update solely for the conﬁgurations, we obtain\nqnC1 D qn \u0003 h2\n2 M\u00021rU.qn/ C h\n2\np\nkBTM\u00021=2 .Rn C Rn\u00021/ ;\nand substituting \u0002 D h2=2 gives the BAOAB Limit Method (Leimkuhler-Matthews\nmethod) [221]\nqnC1 D qn \u0003 \u0002M\u00021rU.qn/ C\np\n2\u0002kBTM\u00021=2\n\bRn C Rn\u00021\n2\n\t\n:\n(7.40)\nAs we are in the overdamped regime, we would expect that this scheme should\nhave an O.h4/ D O.\u00022/ error in conﬁgurational averages, while inheriting the\nother properties of the \u0002BAOAB\u0003 scheme for the harmonic and perturbed harmonic\nmodels considered in Sects. 7.4 and 7.5. Moreover, since we completely remove the\nsecond order term in the Langevin dynamics conﬁgurational density expansion, we\nexpect to observe this behavior across all values of h and \u0002. This is quite a surprising\nresult, given the qualitative similarity between Eqs. (7.39) and (7.40).\nThe beneﬁt of (7.40) over the Euler-Maruyama scheme is that we can get second\norder accuracy in averages with only a single evaluation of the force at each\ntimestep. However, our analysis presented here is only for the inﬁnite time case.\nFor averages computed in ﬁnite time, work in [224] has shown that (7.40) does\nindeed give a ﬁrst order error, albeit one that vanishes exponentially fast in time as\nthe simulation progresses. Hence for suitably long simulations, the observed error\nwill be O.h2/.\nWe can think of the noise process in (7.40) as corresponding to a colored noise\nwhich has characteristics that directly depend on the stepsize, although the noise\ndecorrelates in just a couple of timesteps. This is therefore no longer a Markov\nprocess, however it can be reformulated as such if one considers the appropriate\nextended space (or keeping the momenta pn).\n7.11\nApplying the Schemes to a Biomolecule\nNumerical analysis of a scheme should always be supported (and informed by)\nthorough numerical testing. Often salient features of a discretization method can be\nmissed because of a shallow scope of experimentation. Our goal will be to evaluate\nthe efﬁcacy of the numerical schemes for Langevin dynamics presented thus far. We\nshall look at the invariant (long-time) averages resulting from computations using\nthe four symmetric Langevin integrators that we derived using our splitting, for\nwhich results for the harmonic oscillator are detailed in (7.15), and for which a more\ngeneral error analysis was considered in Sect. 7.9.2. Additionally we will compare\ntheir results to the performance of the standard SPV and BBK schemes considered\nin Sect. 7.3.2.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。",
    "原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。"
  ],
  "issues": [
    "已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。"
  ],
  "statement_scope": "误差界目标和步长幂次转换；尚缺LM算法到该界的完整定理。",
  "lean_decl": "MD.Ch07.lmTransientErrorBound",
  "lean_declarations": [
    "MD.Ch07.lmTransientErrorBound",
    "MD.Ch07.limitAccuracyPrinted",
    "MD.Ch07.limitAccuracyPrinted_corrected",
    "MD.Ch07.limitAccuracy_rescale"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
def limitAccuracyPrinted (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^2)

def limitAccuracyPrinted_corrected (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^4)

theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring
```
