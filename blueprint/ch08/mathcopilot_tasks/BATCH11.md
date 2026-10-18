# BATCH11 第8章原文与陈述审校

## MD-8.6.4-SINThreeLevelPotential
```json
{
  "source_id": "MD-8.6.4-SINThreeLevelPotential",
  "kind": "definition",
  "label": null,
  "section": "8.6.4",
  "printed_page": "373",
  "pdf_page": "394",
  "statement_latex": "U_Total=U_bonds+U_s.r.+U_l.r.; h_outer and h_mid are integer multiples of the next smaller stepsizes.",
  "statement_verbatim": "8.7\nGeneralized Langevin Dynamics\n373\n8.6.4\nNumerical Example\nLet us brieﬂy summarize the numerical experiments of [220] using the SIN(R)\nmethod to simulate a system of 512 ﬂexible water molecules using a fully ﬂexible\nmolecular model [294] and the smooth particle-mesh Ewald method (SPME)\n[123] (see Appendix A) to compute electrostatic forces. Initial simulations were\nconducted without a fast-slow force decomposition to demonstrate the effectiveness\nof the method as a thermostatting scheme. This technique was shown to allow\naccurate computation of the OH, HH and OO radial distribution functions when\nsuitably small timesteps were used.\nAs explained in Chap.4, the resonances in multiple timestepping restrict the\nsize of the large (outer) stepsize usable in simulation. In the case of fully ﬂexible\nwater the maximum outer stepsize that can be used for stable RESPA simulation is\ntypically found to be less than 5 fs [245, 329]. A multiple timestepping method for\nthe SPME method can be based on the decomposition\nUTotal D Ubonds C Us:r: C Ul:r:\nwhere Ubonds includes length and angle bonds, Us:r: includes all other short-ranged\ncomponents, and Ul:r: incorporates both the “reciprocal space part” from Particle\nMesh Ewald summation (normally calculated using 3D FFT) as well as longer-\nranged screened Coulombic pair terms within the simulation cell. Then a nested\nmultiple timestepping hierarchy can be used with stepsizes hinner, hmid and houter,\neach larger stepsize being an integer multiple of the next smaller. There is no\ndifﬁculty with adapting the SIN(R) scheme (which was presented for a two-level\nsetup) to this multi-level hierarchical timestepping framework.\nThe article [220] provides more detail of the SPME parameters and a detailed\nanalysis of the numerical performance. We merely mention here that with hinner D\n0:5 fs and hmid D 3 fs, it was possible to use outer stepsizes of up to 99 fs for\nstable integration and accurate resolution of all three radial distribution functions,\nwith no evidence of resonances. The short-range cutoff in the reported simulations\nwas around 8Å. High efﬁciency improvements would be anticipated in simulations\nwith a large simulation cell. These methods could be valuable in more complex\napplications, including systems with mixed quantum and classical simulation\ndomains, and in the setting of high performance computing architectures, e.g. GPU\nsystems.\n8.7\nGeneralized Langevin Dynamics\nWe have already encountered Generalized Langevin dynamics in Chap.6, where it\nappeared as an intermediate stage in the derivation of Langevin dynamics. In some\ncases, the properties of the heat bath and the resulting memory kernel are important\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 394,
      "printed_page": 373,
      "text": "8.7\nGeneralized Langevin Dynamics\n373\n8.6.4\nNumerical Example\nLet us brieﬂy summarize the numerical experiments of [220] using the SIN(R)\nmethod to simulate a system of 512 ﬂexible water molecules using a fully ﬂexible\nmolecular model [294] and the smooth particle-mesh Ewald method (SPME)\n[123] (see Appendix A) to compute electrostatic forces. Initial simulations were\nconducted without a fast-slow force decomposition to demonstrate the effectiveness\nof the method as a thermostatting scheme. This technique was shown to allow\naccurate computation of the OH, HH and OO radial distribution functions when\nsuitably small timesteps were used.\nAs explained in Chap.4, the resonances in multiple timestepping restrict the\nsize of the large (outer) stepsize usable in simulation. In the case of fully ﬂexible\nwater the maximum outer stepsize that can be used for stable RESPA simulation is\ntypically found to be less than 5 fs [245, 329]. A multiple timestepping method for\nthe SPME method can be based on the decomposition\nUTotal D Ubonds C Us:r: C Ul:r:\nwhere Ubonds includes length and angle bonds, Us:r: includes all other short-ranged\ncomponents, and Ul:r: incorporates both the “reciprocal space part” from Particle\nMesh Ewald summation (normally calculated using 3D FFT) as well as longer-\nranged screened Coulombic pair terms within the simulation cell. Then a nested\nmultiple timestepping hierarchy can be used with stepsizes hinner, hmid and houter,\neach larger stepsize being an integer multiple of the next smaller. There is no\ndifﬁculty with adapting the SIN(R) scheme (which was presented for a two-level\nsetup) to this multi-level hierarchical timestepping framework.\nThe article [220] provides more detail of the SPME parameters and a detailed\nanalysis of the numerical performance. We merely mention here that with hinner D\n0:5 fs and hmid D 3 fs, it was possible to use outer stepsizes of up to 99 fs for\nstable integration and accurate resolution of all three radial distribution functions,\nwith no evidence of resonances. The short-range cutoff in the reported simulations\nwas around 8Å. High efﬁciency improvements would be anticipated in simulations\nwith a large simulation cell. These methods could be valuable in more complex\napplications, including systems with mixed quantum and classical simulation\ndomains, and in the setting of high performance computing architectures, e.g. GPU\nsystems.\n8.7\nGeneralized Langevin Dynamics\nWe have already encountered Generalized Langevin dynamics in Chap.6, where it\nappeared as an intermediate stage in the derivation of Langevin dynamics. In some\ncases, the properties of the heat bath and the resulting memory kernel are important\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "仅保留势的三项分解和整数时标嵌套；SPME实现、99fs稳定性及水分子径向分布等属于数值观察，逐项排除。"
  ],
  "issues": [],
  "statement_scope": "三层势与步长嵌套的定义。",
  "lean_decl": "MD.Ch08.threeLevelPotential",
  "lean_declarations": [
    "MD.Ch08.threeLevelPotential",
    "MD.Ch08.nestedTimeSteps"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def threeLevelPotential (bond short long : Vec n → ℝ) : Vec n → ℝ := bond+short+long
def nestedTimeSteps (inner middle outer : ℝ) : Prop :=
  0 < inner ∧ ∃ r s : ℕ, 0 < r ∧ 0 < s ∧ middle=r*inner ∧ outer=s*middle
```

## MD-8.7-GeneralizedLangevin
```json
{
  "source_id": "MD-8.7-GeneralizedLangevin",
  "kind": "definition",
  "label": null,
  "section": "8.7",
  "printed_page": "374",
  "pdf_page": "395",
  "statement_latex": "dq=M⁻¹pdt, dp=−∇U(q)dt−∫₀ᵗΓ(t−s)p(s)ds dt+dB, q(0)=q₀,p(0)=p₀. Γ is the memory kernel and B is colored noise. (8.57)–(8.58).",
  "statement_verbatim": "374\n8\nExtended Variable Methods\nand have to be modelled as part of the simulation process. Our presentation of this\ntopic follows that of [19] and earlier works [69, 85, 204, 276] which treat the non-\nMarkovian Generalized Langevin equation as a Markov system in an extended phase\nspace.\nThe equations of Generalized Langevin dynamics are normally written in the\nform\ndq D M\u00021pdt;\n(8.57)\ndp D \u0003rU.q/dt \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt C dB;\n(8.58)\nsubject to initial conditions q.0/ D q0, p.0/ D p0. Here \u0010 .t/ D .\nij.t// is a Nc \u0004 Nc\nmatrix-valued function of t which we refer to as the “memory kernel”. The term\nFd D \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt\nrepresents a drag force acting on the system due to the interaction with the particles\nof the bath. dB is the increment of the colored-noise (non-Gaussian) stochastic\nprocess. Often this increment is treated formally as an impulse R.t/dt, where R\nis referred to as a “random force,” which calls to mind the origin of the stochastic\nterm as the model for interaction with a large (but ﬁnite) heat bath. We use this\nlanguage for consistency with the literature. The driving forces are correlated in a\nway that is described by the ﬂuctuation-dissipation theorem [202, 402]. This states\nthat at temperature T the components of the random forces satisfy\nhRi.t C s/Rj.t/i D kBT \nij.s/ıij;\ns \b 0:\n(8.59)\nHere, ıij is the Kronecker delta, and kB is Boltzmann’s constant.\nNumerical methods for treating (8.57)–(8.58) include calculation of the drag\nforce Fd which requires a convolution of the momenta with \u0010 .t/ and therefore\nstorage of some portion of the time-history of p. Typically we will compute a\ndiscrete sequence of p0; p1; : : : ; and so it will be necessary to store a collection\nof, say ` > 0, previous momentum vectors. This may be somewhat demanding in a\nlarge scale simulation setting. Moreover, computing R requires the generation of a\nsequence of random numbers with prescribed correlation, as speciﬁed in Eq. (8.59).\nBoth these issues may be addressed sensibly using the technique of Prony series and\nan extended variable representation\nIn the remainder of this discussion, for the purpose of simpliﬁed presentation, we\nconﬁne ourselves to the simple case of a scalar memory kernel, writing\n\u0010 .t/ D \n.t/I:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 395,
      "printed_page": 374,
      "text": "374\n8\nExtended Variable Methods\nand have to be modelled as part of the simulation process. Our presentation of this\ntopic follows that of [19] and earlier works [69, 85, 204, 276] which treat the non-\nMarkovian Generalized Langevin equation as a Markov system in an extended phase\nspace.\nThe equations of Generalized Langevin dynamics are normally written in the\nform\ndq D M\u00021pdt;\n(8.57)\ndp D \u0003rU.q/dt \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt C dB;\n(8.58)\nsubject to initial conditions q.0/ D q0, p.0/ D p0. Here \u0010 .t/ D .\nij.t// is a Nc \u0004 Nc\nmatrix-valued function of t which we refer to as the “memory kernel”. The term\nFd D \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt\nrepresents a drag force acting on the system due to the interaction with the particles\nof the bath. dB is the increment of the colored-noise (non-Gaussian) stochastic\nprocess. Often this increment is treated formally as an impulse R.t/dt, where R\nis referred to as a “random force,” which calls to mind the origin of the stochastic\nterm as the model for interaction with a large (but ﬁnite) heat bath. We use this\nlanguage for consistency with the literature. The driving forces are correlated in a\nway that is described by the ﬂuctuation-dissipation theorem [202, 402]. This states\nthat at temperature T the components of the random forces satisfy\nhRi.t C s/Rj.t/i D kBT \nij.s/ıij;\ns \b 0:\n(8.59)\nHere, ıij is the Kronecker delta, and kB is Boltzmann’s constant.\nNumerical methods for treating (8.57)–(8.58) include calculation of the drag\nforce Fd which requires a convolution of the momenta with \u0010 .t/ and therefore\nstorage of some portion of the time-history of p. Typically we will compute a\ndiscrete sequence of p0; p1; : : : ; and so it will be necessary to store a collection\nof, say ` > 0, previous momentum vectors. This may be somewhat demanding in a\nlarge scale simulation setting. Moreover, computing R requires the generation of a\nsequence of random numbers with prescribed correlation, as speciﬁed in Eq. (8.59).\nBoth these issues may be addressed sensibly using the technique of Prony series and\nan extended variable representation\nIn the remainder of this discussion, for the purpose of simpliﬁed presentation, we\nconﬁne ourselves to the simple case of a scalar memory kernel, writing\n\u0010 .t/ D \n.t/I:\n"
    }
  ],
  "numbered_equations": [
    "8.57",
    "8.58"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。",
    "本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。"
  ],
  "issues": [],
  "statement_scope": "连续矩阵记忆核下的卷积及GLE积分解类定义。",
  "lean_decl": "MD.Ch08.memoryDrag",
  "lean_declarations": [
    "MD.Ch08.memoryDrag",
    "MD.Ch08.generalizedLangevin"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def memoryDrag (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (p : ℝ → Vec n) (t : ℝ) : Vec n :=
  -∫ s in (0 : ℝ)..t, Γ (t-s) *ᵥ p s
def generalizedLangevin (P : Measure Ω) (invm : Vec n) (U : Vec n → ℝ)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (B : ℝ → Ω → Vec n)
    (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  IsProbabilityMeasure P ∧ (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧ ContinuousOn Γ (Ici 0) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ B t sample) (Ici 0)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ B s sample) inferInstance] (X t)) ∧
  ∀ t, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable
      (fun s ↦ -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s) volume 0 t) ∧
    ∀ᵐ sample ∂P,
      (X t sample).1=x0.1+∫ s in (0 : ℝ)..t, (fun i ↦ invm i*(X s sample).2 i) ∧
      (X t sample).2=x0.2+(∫ s in (0 : ℝ)..t,
        -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s)+B t sample-B 0 sample
```

## MD-8.7-GLEFluctuationDissipationPrinted
```json
{
  "source_id": "MD-8.7-GLEFluctuationDissipationPrinted",
  "kind": "definition",
  "label": null,
  "section": "8.7",
  "printed_page": "374",
  "pdf_page": "395",
  "statement_latex": "⟨Rᵢ(t+s)Rⱼ(t)⟩=k_BT γᵢⱼ(s)δᵢⱼ, s≥0. Γ(t)=γ(t)I in the scalar-kernel specialization. (8.59).",
  "statement_verbatim": "374\n8\nExtended Variable Methods\nand have to be modelled as part of the simulation process. Our presentation of this\ntopic follows that of [19] and earlier works [69, 85, 204, 276] which treat the non-\nMarkovian Generalized Langevin equation as a Markov system in an extended phase\nspace.\nThe equations of Generalized Langevin dynamics are normally written in the\nform\ndq D M\u00021pdt;\n(8.57)\ndp D \u0003rU.q/dt \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt C dB;\n(8.58)\nsubject to initial conditions q.0/ D q0, p.0/ D p0. Here \u0010 .t/ D .\nij.t// is a Nc \u0004 Nc\nmatrix-valued function of t which we refer to as the “memory kernel”. The term\nFd D \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt\nrepresents a drag force acting on the system due to the interaction with the particles\nof the bath. dB is the increment of the colored-noise (non-Gaussian) stochastic\nprocess. Often this increment is treated formally as an impulse R.t/dt, where R\nis referred to as a “random force,” which calls to mind the origin of the stochastic\nterm as the model for interaction with a large (but ﬁnite) heat bath. We use this\nlanguage for consistency with the literature. The driving forces are correlated in a\nway that is described by the ﬂuctuation-dissipation theorem [202, 402]. This states\nthat at temperature T the components of the random forces satisfy\nhRi.t C s/Rj.t/i D kBT \nij.s/ıij;\ns \b 0:\n(8.59)\nHere, ıij is the Kronecker delta, and kB is Boltzmann’s constant.\nNumerical methods for treating (8.57)–(8.58) include calculation of the drag\nforce Fd which requires a convolution of the momenta with \u0010 .t/ and therefore\nstorage of some portion of the time-history of p. Typically we will compute a\ndiscrete sequence of p0; p1; : : : ; and so it will be necessary to store a collection\nof, say ` > 0, previous momentum vectors. This may be somewhat demanding in a\nlarge scale simulation setting. Moreover, computing R requires the generation of a\nsequence of random numbers with prescribed correlation, as speciﬁed in Eq. (8.59).\nBoth these issues may be addressed sensibly using the technique of Prony series and\nan extended variable representation\nIn the remainder of this discussion, for the purpose of simpliﬁed presentation, we\nconﬁne ourselves to the simple case of a scalar memory kernel, writing\n\u0010 .t/ D \n.t/I:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 395,
      "printed_page": 374,
      "text": "374\n8\nExtended Variable Methods\nand have to be modelled as part of the simulation process. Our presentation of this\ntopic follows that of [19] and earlier works [69, 85, 204, 276] which treat the non-\nMarkovian Generalized Langevin equation as a Markov system in an extended phase\nspace.\nThe equations of Generalized Langevin dynamics are normally written in the\nform\ndq D M\u00021pdt;\n(8.57)\ndp D \u0003rU.q/dt \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt C dB;\n(8.58)\nsubject to initial conditions q.0/ D q0, p.0/ D p0. Here \u0010 .t/ D .\nij.t// is a Nc \u0004 Nc\nmatrix-valued function of t which we refer to as the “memory kernel”. The term\nFd D \u0003\nt\nZ\n0\n\u0010 .t \u0003 s/p.s/dsdt\nrepresents a drag force acting on the system due to the interaction with the particles\nof the bath. dB is the increment of the colored-noise (non-Gaussian) stochastic\nprocess. Often this increment is treated formally as an impulse R.t/dt, where R\nis referred to as a “random force,” which calls to mind the origin of the stochastic\nterm as the model for interaction with a large (but ﬁnite) heat bath. We use this\nlanguage for consistency with the literature. The driving forces are correlated in a\nway that is described by the ﬂuctuation-dissipation theorem [202, 402]. This states\nthat at temperature T the components of the random forces satisfy\nhRi.t C s/Rj.t/i D kBT \nij.s/ıij;\ns \b 0:\n(8.59)\nHere, ıij is the Kronecker delta, and kB is Boltzmann’s constant.\nNumerical methods for treating (8.57)–(8.58) include calculation of the drag\nforce Fd which requires a convolution of the momenta with \u0010 .t/ and therefore\nstorage of some portion of the time-history of p. Typically we will compute a\ndiscrete sequence of p0; p1; : : : ; and so it will be necessary to store a collection\nof, say ` > 0, previous momentum vectors. This may be somewhat demanding in a\nlarge scale simulation setting. Moreover, computing R requires the generation of a\nsequence of random numbers with prescribed correlation, as speciﬁed in Eq. (8.59).\nBoth these issues may be addressed sensibly using the technique of Prony series and\nan extended variable representation\nIn the remainder of this discussion, for the purpose of simpliﬁed presentation, we\nconﬁne ourselves to the simple case of a scalar memory kernel, writing\n\u0010 .t/ D \n.t/I:\n"
    }
  ],
  "numbered_equations": [
    "8.59"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。"
  ],
  "issues": [
    "已目视核对原页PDF395：一般矩阵核后额外乘δᵢⱼ会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。"
  ],
  "statement_scope": "Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。",
  "lean_decl": "MD.Ch08.randomForceQualification",
  "lean_declarations": [
    "MD.Ch08.randomForceQualification",
    "MD.Ch08.gleFDPrinted",
    "MD.Ch08.gleFD_corrected",
    "MD.Ch08.scalarMemoryMatrix"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def randomForceQualification (P : Measure Ω) (R : ℝ → Ω → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ ∀ t, 0 ≤ t → ∀ i, MemLp (fun sample ↦ R t sample i) 2 P ∧
    (∫ sample, R t sample i ∂P)=0
def gleFDPrinted (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=if i=j then θ*Γ s i j else 0
def gleFD_corrected (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=θ*Γ s i j
def scalarMemoryMatrix (γ : ℝ → ℝ) (t : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal (fun _ ↦ γ t)
```

## MD-8.7-PronyKernel
```json
{
  "source_id": "MD-8.7-PronyKernel",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.7",
  "printed_page": "375",
  "pdf_page": "396",
  "statement_latex": "γ(t)=Σₖ(cₖ/τₖ)exp(−t/τₖ), t≥0. (8.60).",
  "statement_verbatim": "8.7\nGeneralized Langevin Dynamics\n375\nFor systems in which the memory kernel decays fairly rapidly, it is not unreasonable\nto consider its approximation by a linear combination of exponential functions, a so-\ncalled Prony series:\n\n.t/ D\nkmax\nX\nkD1\nck\n\u0002k\nexp\n\u0002\n\u0003 t\n\u0002k\n\u0003\n;\nt \b 0:\n(8.60)\nThe properties of the system in the limit \u0002k ! 0 are studied in [293].\nThe use of this representation for the memory kernel allows us to replace\nthe history-dependent equations (8.57)–(8.58) by a Markovian system in a larger\ndimensional space, by introducing k additional degrees of freedom per physical\ndegree of freedom. This method obviously increases storage requirements, and,\nin large systems, it may be signiﬁcant. However, the evolution of these additional\nvariables is elementary and the overall computational cost low.\n8.7.1\nUsing an Extended Variable Representation\nWe introduce a set of extended variables whose evolution is described by standard\nBrownian motions using Ornstein-Uhlenbeck (OU) processes. For this treatment,\nlet the particle positions and momenta be enumerated as .qi; pi/, i D 1; : : : ; Nc and\ndeﬁne the extended variable, \u000fi;k.t/, associated with the kth term in the Prony series\nin interaction with the ith physical variable by\n\u000fi;k.t/ D \u0003\nt\nZ\n0\nck\n\u0002k\nexp\n\u0002\n\u0003.t \u0003 s/\n\u0002k\n\u0003\npi.s/ds:\n(8.61)\nEquations (8.57)–(8.58) can then be rewritten in the form\ndqi D m\u00021\ni pidt\n(8.62)\ndpi D Fidt C\nkmax\nX\nkD1\n\u000fi;kdt C Ridt:\n(8.63)\nWe note that \u000fi;k is the solution of an ODE of the form\nd\u000fi;k D \u0003 1\n\u0002k\n\u000fi;k.t/dt \u0003 ck\n\u0002k\npidt:\n(8.64)\nWe have thus resolved the convolution integral.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 396,
      "printed_page": 375,
      "text": "8.7\nGeneralized Langevin Dynamics\n375\nFor systems in which the memory kernel decays fairly rapidly, it is not unreasonable\nto consider its approximation by a linear combination of exponential functions, a so-\ncalled Prony series:\n\n.t/ D\nkmax\nX\nkD1\nck\n\u0002k\nexp\n\u0002\n\u0003 t\n\u0002k\n\u0003\n;\nt \b 0:\n(8.60)\nThe properties of the system in the limit \u0002k ! 0 are studied in [293].\nThe use of this representation for the memory kernel allows us to replace\nthe history-dependent equations (8.57)–(8.58) by a Markovian system in a larger\ndimensional space, by introducing k additional degrees of freedom per physical\ndegree of freedom. This method obviously increases storage requirements, and,\nin large systems, it may be signiﬁcant. However, the evolution of these additional\nvariables is elementary and the overall computational cost low.\n8.7.1\nUsing an Extended Variable Representation\nWe introduce a set of extended variables whose evolution is described by standard\nBrownian motions using Ornstein-Uhlenbeck (OU) processes. For this treatment,\nlet the particle positions and momenta be enumerated as .qi; pi/, i D 1; : : : ; Nc and\ndeﬁne the extended variable, \u000fi;k.t/, associated with the kth term in the Prony series\nin interaction with the ith physical variable by\n\u000fi;k.t/ D \u0003\nt\nZ\n0\nck\n\u0002k\nexp\n\u0002\n\u0003.t \u0003 s/\n\u0002k\n\u0003\npi.s/ds:\n(8.61)\nEquations (8.57)–(8.58) can then be rewritten in the form\ndqi D m\u00021\ni pidt\n(8.62)\ndpi D Fidt C\nkmax\nX\nkD1\n\u000fi;kdt C Ridt:\n(8.63)\nWe note that \u000fi;k is the solution of an ODE of the form\nd\u000fi;k D \u0003 1\n\u0002k\n\u000fi;k.t/dt \u0003 ck\n\u0002k\npidt:\n(8.64)\nWe have thus resolved the convolution integral.\n"
    }
  ],
  "numbered_equations": [
    "8.60"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "正cₖ、τₖ为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。"
  ],
  "issues": [],
  "statement_scope": "正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。",
  "lean_decl": "MD.Ch08.pronyKernel",
  "lean_declarations": [
    "MD.Ch08.pronyKernel",
    "MD.Ch08.pronyQualification",
    "MD.Ch08.pronyKernel_nonneg"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pronyKernel {K : ℕ} (c τ : Fin K → ℝ) (t : ℝ) : ℝ :=
  ∑ k, c k/τ k*Real.exp (-t/τ k)
def pronyQualification {K : ℕ} (c τ : Fin K → ℝ) : Prop :=
  ∀ k, 0 < c k ∧ 0 < τ k
theorem pronyKernel_nonneg {K : ℕ} (c τ : Fin K → ℝ)
    (h : pronyQualification c τ) (t : ℝ) : 0 ≤ pronyKernel c τ t := by
  apply Finset.sum_nonneg
  intro k hk
  exact mul_nonneg (le_of_lt (div_pos (h k).1 (h k).2)) (le_of_lt (Real.exp_pos _))
```

## MD-8.7.1-PronyMemoryODE
```json
{
  "source_id": "MD-8.7.1-PronyMemoryODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.7.1",
  "printed_page": "375",
  "pdf_page": "396",
  "statement_latex": "ηᵢₖ(t)=−∫₀ᵗ(cₖ/τₖ)exp(−(t−s)/τₖ)pᵢ(s)ds, dηᵢₖ=−ηᵢₖdt/τₖ−cₖpᵢdt/τₖ. Equations (8.61)–(8.64) remove the convolution history.",
  "statement_verbatim": "8.7\nGeneralized Langevin Dynamics\n375\nFor systems in which the memory kernel decays fairly rapidly, it is not unreasonable\nto consider its approximation by a linear combination of exponential functions, a so-\ncalled Prony series:\n\n.t/ D\nkmax\nX\nkD1\nck\n\u0002k\nexp\n\u0002\n\u0003 t\n\u0002k\n\u0003\n;\nt \b 0:\n(8.60)\nThe properties of the system in the limit \u0002k ! 0 are studied in [293].\nThe use of this representation for the memory kernel allows us to replace\nthe history-dependent equations (8.57)–(8.58) by a Markovian system in a larger\ndimensional space, by introducing k additional degrees of freedom per physical\ndegree of freedom. This method obviously increases storage requirements, and,\nin large systems, it may be signiﬁcant. However, the evolution of these additional\nvariables is elementary and the overall computational cost low.\n8.7.1\nUsing an Extended Variable Representation\nWe introduce a set of extended variables whose evolution is described by standard\nBrownian motions using Ornstein-Uhlenbeck (OU) processes. For this treatment,\nlet the particle positions and momenta be enumerated as .qi; pi/, i D 1; : : : ; Nc and\ndeﬁne the extended variable, \u000fi;k.t/, associated with the kth term in the Prony series\nin interaction with the ith physical variable by\n\u000fi;k.t/ D \u0003\nt\nZ\n0\nck\n\u0002k\nexp\n\u0002\n\u0003.t \u0003 s/\n\u0002k\n\u0003\npi.s/ds:\n(8.61)\nEquations (8.57)–(8.58) can then be rewritten in the form\ndqi D m\u00021\ni pidt\n(8.62)\ndpi D Fidt C\nkmax\nX\nkD1\n\u000fi;kdt C Ridt:\n(8.63)\nWe note that \u000fi;k is the solution of an ODE of the form\nd\u000fi;k D \u0003 1\n\u0002k\n\u000fi;k.t/dt \u0003 ck\n\u0002k\npidt:\n(8.64)\nWe have thus resolved the convolution integral.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 396,
      "printed_page": 375,
      "text": "8.7\nGeneralized Langevin Dynamics\n375\nFor systems in which the memory kernel decays fairly rapidly, it is not unreasonable\nto consider its approximation by a linear combination of exponential functions, a so-\ncalled Prony series:\n\n.t/ D\nkmax\nX\nkD1\nck\n\u0002k\nexp\n\u0002\n\u0003 t\n\u0002k\n\u0003\n;\nt \b 0:\n(8.60)\nThe properties of the system in the limit \u0002k ! 0 are studied in [293].\nThe use of this representation for the memory kernel allows us to replace\nthe history-dependent equations (8.57)–(8.58) by a Markovian system in a larger\ndimensional space, by introducing k additional degrees of freedom per physical\ndegree of freedom. This method obviously increases storage requirements, and,\nin large systems, it may be signiﬁcant. However, the evolution of these additional\nvariables is elementary and the overall computational cost low.\n8.7.1\nUsing an Extended Variable Representation\nWe introduce a set of extended variables whose evolution is described by standard\nBrownian motions using Ornstein-Uhlenbeck (OU) processes. For this treatment,\nlet the particle positions and momenta be enumerated as .qi; pi/, i D 1; : : : ; Nc and\ndeﬁne the extended variable, \u000fi;k.t/, associated with the kth term in the Prony series\nin interaction with the ith physical variable by\n\u000fi;k.t/ D \u0003\nt\nZ\n0\nck\n\u0002k\nexp\n\u0002\n\u0003.t \u0003 s/\n\u0002k\n\u0003\npi.s/ds:\n(8.61)\nEquations (8.57)–(8.58) can then be rewritten in the form\ndqi D m\u00021\ni pidt\n(8.62)\ndpi D Fidt C\nkmax\nX\nkD1\n\u000fi;kdt C Ridt:\n(8.63)\nWe note that \u000fi;k is the solution of an ODE of the form\nd\u000fi;k D \u0003 1\n\u0002k\n\u000fi;k.t/dt \u0003 ck\n\u0002k\npidt:\n(8.64)\nWe have thus resolved the convolution integral.\n"
    }
  ],
  "numbered_equations": [
    "8.61",
    "8.62",
    "8.63",
    "8.64"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "p连续、τ正保证有限区间卷积合法；仅消去有限Prony历史，未声称无限Prony极限或解分布等价。"
  ],
  "issues": [],
  "statement_scope": "卷积辅助定义、微分关系和有限和等式；与扩展随机解的完整等价列缺口。",
  "lean_decl": "MD.Ch08.pronyMemory",
  "lean_declarations": [
    "MD.Ch08.pronyMemory",
    "MD.Ch08.pronyMemory_derivative",
    "MD.Ch08.pronyMomentumDrift",
    "MD.Ch08.pronyMemory_sum"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pronyMemory (c τ : ℝ) (p : ℝ → ℝ) (t : ℝ) : ℝ :=
  -∫ s in (0 : ℝ)..t, c/τ*Real.exp (-(t-s)/τ)*p s
theorem pronyMemory_derivative (c τ : ℝ) (hτ : 0 < τ)
    (p : ℝ → ℝ) (hp : Continuous p) (t : ℝ) :
    HasDerivAt (pronyMemory c τ p) (-pronyMemory c τ p t/τ-c/τ*p t) t := by
  sorry
def pronyMomentumDrift {K : ℕ} (F : Vec n) (η : Fin K → Vec n) (R : Vec n) : Vec n :=
  F+(∑ k, η k)+R
theorem pronyMemory_sum {K : ℕ} (c τ : Fin K → ℝ) (p : ℝ → Vec n)
    (hq : pronyQualification c τ) (hp : Continuous p) (t : ℝ) :
    (∑ k, fun i ↦ pronyMemory (c k) (τ k) (fun s ↦ p s i) t) =
      memoryDrag (scalarMemoryMatrix (n:=n) (pronyKernel c τ)) p t := by
  sorry
```

## MD-8.7.1-PronyOUStationarity
```json
{
  "source_id": "MD-8.7.1-PronyOUStationarity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.7.1",
  "printed_page": "376",
  "pdf_page": "397",
  "statement_latex": "dRᵢₖ=−Rᵢₖdt/τₖ+√(2k_BT cₖ)dWᵢₖ/τₖ; E Rᵢₖ=0 and E[Rᵢₖ(t+s)Rᵢₖ(t)]=(k_BT cₖ/τₖ)e^(−s/τₖ). Rᵢ=ΣₖRᵢₖ. (8.65)–(8.67).",
  "statement_verbatim": "376\n8\nExtended Variable Methods\nTo calculate the random forces associated to the kth term of the expansion, we\nnote that these can be viewed as the solution of a linear SDE, speciﬁcally\ndRi;k D \u0003 1\n\u0002k\nRi;k.t/dt C 1\n\u0002k\np\n2kBTckdWi;k.t/\n(8.65)\nwhere Wi;k is a standard Wiener process. The random force is seen to be deﬁned as\nthe solution of an Ornstein-Uhlenbeck process induced by the Prony representation.\nIt is easily shown that Ri;k.t/ has zero mean and autocorrelation deﬁned by\nhRi;k.t C s/Ri;k.t/i D kBTck\n\u0002k\nexp\n\u0002\n\u0003 1\n\u0002k\ns\n\u0003\n;\ns \b 0\n(8.66)\nThe total random force is then obtained by summation\nRi D\nkmax\nX\nkD1\nRi;k:\n(8.67)\nObserve that both random and drag forces are incorporated via summation of the\ncomponents \u000fi;k and Ri;k deﬁned by linear equations, respectively the ODE (8.64)\nand SDE (8.65). It is therefore possible to replace these components by their sum\n\u0007i;k D \u000fi;k C Ri;k\nwhich may be evolved by a single SDE. The equations therefore become\ndqi D m\u00021\ni pidt;\n(8.68)\ndpi D Fidt C\nkmax\nX\nkD1\n\u0007i;kdt;\n(8.69)\nd\u0007i;k D \u0003 1\n\u0002k\n\u0007i;kdt \u0003 ck\n\u0002k\npidt C 1\n\u0002k\np\n2kBTckdWi;k:\n(8.70)\nThe relation between the Prony series representation and Langevin dynamics can be\nseen in an informal sense by multiplying the equation for \u0007i;k equation by \u0002k, and\nconsidering \u0002k ! 0, giving\n\u0007i;kdt D \u0003ckpidt C\np\n2kBTckdWi;k;\nwhich results in\ndpi D Fidt \u0003\n kmax\nX\nkD1\nck\n!\npidt C\np\n2kBT\n`\nX\nkD1\npckdWi;k:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 397,
      "printed_page": 376,
      "text": "376\n8\nExtended Variable Methods\nTo calculate the random forces associated to the kth term of the expansion, we\nnote that these can be viewed as the solution of a linear SDE, speciﬁcally\ndRi;k D \u0003 1\n\u0002k\nRi;k.t/dt C 1\n\u0002k\np\n2kBTckdWi;k.t/\n(8.65)\nwhere Wi;k is a standard Wiener process. The random force is seen to be deﬁned as\nthe solution of an Ornstein-Uhlenbeck process induced by the Prony representation.\nIt is easily shown that Ri;k.t/ has zero mean and autocorrelation deﬁned by\nhRi;k.t C s/Ri;k.t/i D kBTck\n\u0002k\nexp\n\u0002\n\u0003 1\n\u0002k\ns\n\u0003\n;\ns \b 0\n(8.66)\nThe total random force is then obtained by summation\nRi D\nkmax\nX\nkD1\nRi;k:\n(8.67)\nObserve that both random and drag forces are incorporated via summation of the\ncomponents \u000fi;k and Ri;k deﬁned by linear equations, respectively the ODE (8.64)\nand SDE (8.65). It is therefore possible to replace these components by their sum\n\u0007i;k D \u000fi;k C Ri;k\nwhich may be evolved by a single SDE. The equations therefore become\ndqi D m\u00021\ni pidt;\n(8.68)\ndpi D Fidt C\nkmax\nX\nkD1\n\u0007i;kdt;\n(8.69)\nd\u0007i;k D \u0003 1\n\u0002k\n\u0007i;kdt \u0003 ck\n\u0002k\npidt C 1\n\u0002k\np\n2kBTckdWi;k:\n(8.70)\nThe relation between the Prony series representation and Langevin dynamics can be\nseen in an informal sense by multiplying the equation for \u0007i;k equation by \u0002k, and\nconsidering \u0002k ! 0, giving\n\u0007i;kdt D \u0003ckpidt C\np\n2kBTckdWi;k;\nwhich results in\ndpi D Fidt \u0003\n kmax\nX\nkD1\nck\n!\npidt C\np\n2kBT\n`\nX\nkD1\npckdWi;k:\n"
    }
  ],
  "numbered_equations": [
    "8.65",
    "8.66",
    "8.67"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "为(8.66)补平稳Gaussian初态及其与未来整条W独立；确定初态OU一般没有所印不依赖t的协方差。多分量实际实现使用独立W坐标。"
  ],
  "issues": [],
  "statement_scope": "单个Prony OU的完整资格及平稳均值/协方差目标、总随机力定义。",
  "lean_decl": "MD.Ch08.stationaryPronyOU",
  "lean_declarations": [
    "MD.Ch08.stationaryPronyOU",
    "MD.Ch08.pronyOU_covariance",
    "MD.Ch08.totalPronyRandomForce"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def stationaryPronyOU (P : Measure Ω) (W : ℝ → Ω → Vec 1) (R : ℝ → Ω → ℝ)
    (c τ θ : ℝ) : Prop :=
  independentWiener P 1 W ∧ 0 < c ∧ 0 < τ ∧ 0 < θ ∧
  HasLaw (R 0) (gaussianReal 0 (Real.toNNReal (θ*c/τ))) P ∧
  IndepFun (R 0) (fun sample t ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ R t sample) (Ici 0)) ∧
  (∀ t, 0 ≤ t → MemLp (R t) 2 P) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    R t sample=R 0 sample+(∫ s in (0 : ℝ)..t, -R s sample/τ)+
      Real.sqrt (2*θ*c)/τ*(W t sample 0-W 0 sample 0)
theorem pronyOU_covariance (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := by
  sorry
def totalPronyRandomForce {K : ℕ} (R : Fin K → ℝ → Ω → ℝ) (t : ℝ) (sample : Ω) : ℝ :=
  ∑ k, R k t sample
```
