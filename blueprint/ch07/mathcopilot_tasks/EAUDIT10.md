# EAUDIT10 第7章修改后陈述复审

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
    "完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。",
    "29号覆盖限定：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。"
  ],
  "issues": [],
  "statement_scope": "带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。",
  "lean_decl": "MD.Ch07.baoabInfinite",
  "lean_declarations": [
    "MD.Ch07.baoabInfinite",
    "MD.Ch07.lmStepH",
    "MD.Ch07.lmStep",
    "MD.Ch07.baoabInfinite_position",
    "MD.Ch07.lmStepH_rescale"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "增加双噪声LM的重标度等式签名，保留显式尾kick初值关系；不要求补证明。",
      "actual_scope": "带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": []
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

theorem lmStepH_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    lmStepH m U θ h R S q = lmStep m U θ (h^2/2) R S q := by
  sorry
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
    "MA(1)噪声以相邻两独立Gaussian平均定义；定义扩展状态(q,R旧)的完整一步映射。非Markov性的普遍表述依赖具体势和初值，未把任意位置过程都判非Markov；扩展Markov核与半群律仍是覆盖缺口。",
    "29号覆盖限定：邻接噪声定义与协方差、扩展状态映射及可测Markov核定义；过程相对过去的新噪声独立性/Markov定理未覆盖，位置非Markov不作全称断言。",
    "邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。"
  ],
  "issues": [],
  "statement_scope": "邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。",
  "lean_decl": "MD.Ch07.coloredNoise",
  "lean_declarations": [
    "MD.Ch07.coloredNoise",
    "MD.Ch07.coloredNoise_covariance",
    "MD.Ch07.lmExtendedStep",
    "MD.Ch07.lmExtendedKernel",
    "MD.Ch07.lmExtendedChain",
    "MD.Ch07.lmExtendedChain_markov"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "把协方差标[EXTRA]；加入合适可测性、每步独立新Gaussian输入和扩展过程的Markov声明；对位置非Markov表述限定参数和初始分布。",
      "actual_scope": "邻接噪声定义与协方差、扩展状态映射及可测Markov核定义；过程相对过去的新噪声独立性/Markov定理未覆盖，位置非Markov不作全称断言。",
      "signature_changed": true
    },
    {
      "instruction": 29,
      "supplement": "补过程Markov条件分布或H/O解资格连接",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "一般位置过程非Markov需额外非退化参数与初态；此处未作无条件断言。",
    "29号覆盖限定：邻接噪声定义与协方差、扩展状态映射及可测Markov核定义；过程相对过去的新噪声独立性/Markov定理未覆盖，位置非Markov不作全称断言。"
  ]
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

def lmExtendedKernel (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦
      lmExtendedStep m U θ τ z.2 z.1)) : Kernel (V n × V n) (V n × V n) :=
  (Kernel.id.prod (Kernel.const (V n × V n) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)))).map
    (fun z ↦ lmExtendedStep m U θ τ z.2 z.1)

def lmExtendedChain (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n) : ℕ → Ω → V n × V n
  | 0 => X0
  | k+1 => fun sample ↦ lmExtendedStep m U θ τ (R k sample)
      (lmExtendedChain m U θ τ R X0 k sample)

/-- 每次新噪声独立于初始状态及所有先前噪声；集合积分式给出扩展过程的Markov条件分布。 -/
theorem lmExtendedChain_markov (P : Measure Ω) (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (hτ : 0 < τ)
    (hR : vectorNormalSequence P R) (hX0 : Measurable X0)
    (hfresh : ∀ k, IndepFun (R k)
      (fun sample ↦ (X0 sample,fun j : Fin k ↦ R j sample)) P)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦ lmExtendedStep m U θ τ z.2 z.1)) :
    let X := lmExtendedChain m U θ τ R X0
    ∀ k (A : Set (V n × V n)) (hA : MeasurableSet A) (B : Set Ω),
    MeasurableSet[⨆ j : Fin (k+1), MeasurableSpace.comap (X j) inferInstance] B →
    P (B ∩ (X (k+1)) ⁻¹' A) =
      ∫⁻ sample in B, lmExtendedKernel m U θ τ hstep (X k sample) A ∂P := by
  sorry
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
    "原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。",
    "29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。"
  ],
  "issues": [
    "已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。"
  ],
  "statement_scope": "瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。",
  "lean_decl": "MD.Ch07.lmTransientErrorBound",
  "lean_declarations": [
    "MD.Ch07.lmTransientErrorBound",
    "MD.Ch07.limitAccuracyPrinted",
    "MD.Ch07.limitAccuracyPrinted_corrected",
    "MD.Ch07.limitAccuracy_rescale",
    "MD.Ch07.limitAccuracyInfiniteTime_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "NEEDS_HUMAN",
      "suggested_fix": "保留原印h²并标疑误；修正版明确先取无限时间。补LM误差对象与界的适用条件，说明有限T和联合T(h)极限；恢复原句或标摘述。",
      "actual_scope": "瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。"
  ]
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

def limitAccuracyInfiniteTime_corrected (error : ℝ → ℝ → ℝ) (longtime : ℝ → ℝ) : Prop :=
  (∀ h, 0 < h → Tendsto (fun T ↦ error (h^2/2) T) atTop (𝓝 (longtime h))) ∧
  limitAccuracyPrinted_corrected longtime
```
