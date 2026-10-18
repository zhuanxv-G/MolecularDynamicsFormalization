# EAUDIT09 第7章修改后陈述复审

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
    "归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。",
    "29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。"
  ],
  "issues": [],
  "statement_scope": "Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。",
  "lean_decl": "MD.Ch07.baoabMarginalCancellation",
  "lean_declarations": [
    "MD.Ch07.baoabMarginalCancellation",
    "MD.Ch07.baoabConfigurationalCancellation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "增加正有限配分积分或概率资格，补列(7.37)的真实均值及双渐近目标；保留现有两个消项定理。",
      "actual_scope": "Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。"
  ]
}
```
```lean
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

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
    "四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。",
    "29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。"
  ],
  "issues": [],
  "statement_scope": "积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。",
  "lean_decl": "MD.Ch07.oabaoPositionCancellation",
  "lean_declarations": [
    "MD.Ch07.oabaoPositionCancellation",
    "MD.Ch07.superconvergence_fromBound",
    "MD.Ch07.oabaoMomentumCancellation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "补方法相关的不变平均、明确极限顺序及统一余项资格；补OABAO动量观测消项桥。把fromBound标为代数辅助结果。",
      "actual_scope": "积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。"
  ]
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

theorem oabaoMomentumCancellation (U χ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hf : Integrable (highFrictionOABAO U β) (positionGibbs U β))
    (hχ : Integrable χ (momentumGibbs (fun _ ↦ 1) β))
    (hc : ∫ q, highFrictionOABAO U β q ∂positionGibbs U β = 0) :
    (∫ x, χ x.2*highFrictionOABAO U β x.1 ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
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
    "固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。",
    "29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。"
  ],
  "issues": [],
  "statement_scope": "正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。",
  "lean_decl": "MD.Ch07.redrawMomentum",
  "lean_declarations": [
    "MD.Ch07.redrawMomentum",
    "MD.Ch07.redrawStep",
    "MD.Ch07.momentumRedrawLimit",
    "MD.Ch07.redrawMomentum_law"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "保留确定性极限定理，另列P上的标准独立Gaussian R、正质量和redrawMomentum的momentumGibbs分布等式，以及必要的分布极限目标。",
      "actual_scope": "正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。"
  ]
}
```
```lean
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry

theorem redrawMomentum_law (P : Measure Ω) (m : V n) (θ : ℝ) (R : Ω → V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ)
    (hR : HasLaw R (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ redrawMomentum m θ (R sample)) (momentumGibbs m θ⁻¹) P := by
  sorry
```
