# EAUDIT01 第8章修改后陈述复审

## MD-8.1.2.1-NPEquations
```json
{
  "source_id": "MD-8.1.2.1-NPEquations",
  "kind": "definition",
  "label": null,
  "section": "8.1.2.1",
  "printed_page": "334",
  "pdf_page": "355",
  "statement_latex": "q̇=M⁻¹p̃/s, p̃̇=sF, ṡ=sp_s/μ, ṗ_s=p̃ᵀM⁻¹p̃/s²-N_d k_BT-ΔH_N.",
  "statement_verbatim": "334\n8\nExtended Variable Methods\n8.1.2.1\nNosé-Poincaré Dynamics: A Symplectic Approach\nAs we have seen in earlier chapters, there is a strong foundation for using symplectic\nintegrators, for example the existence of perturbative backward error expansions\nwhich are relatively easily calculated, it is desirable to work within this class. On\nthe other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian\nsystem. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-\nbased extension of the physical system whose projected trajectories are actually\nequivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This\nextended Hamiltonian system can then be discretized using a symplectic method.\nNosé’s original proposal involved using the dynamics of the Hamiltonian\nHN D 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C .Nd C 1/kBT ln s\nto deﬁne an extension which can be used for canonical sampling. The dynamics\nfor constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will\npreserve the canonical measure \u0005ˇ. However, the scaling of kinetic energy induces\na time transformation, which is inconvenient for molecular modelling purposes. The\nNosé-Poincaré method introduces an explicit unraveling of the time transformation.\nOne works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:\nHNP D sŒHN \u0003 EN\t D s\n\u0002 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C NdkBT ln s \u0003 EN\n\u0003\n;\n(8.9)\nwhere EN is a constant equal to the initial Nosé energy of the system. Trajectories of\nthis system unfold on a timescale which is in some sense commensurate with that of\nHamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic\nintegrators, conferring a possible stability advantage. Symplectic integrators for this\nsystem are compared in [41].\nThe equations of motion associated to (8.9) are\nd\ndtq D M\u00021Qp=s;\n(8.10)\nd\ndt Qp D sF;\n(8.11)\nd\ndts D sps=\u0006;\n(8.12)\nd\ndtps D QpTM\u00021Qp\ns2\n\u0003 NdkBT \u0003 \u0016HN;\n(8.13)\nwhere \u0016HN D HN \u0003 H0\nN (H0\nN represents the value of the Nosé Hamiltonian at the\ninitial point).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 355,
      "printed_page": 334,
      "text": "334\n8\nExtended Variable Methods\n8.1.2.1\nNosé-Poincaré Dynamics: A Symplectic Approach\nAs we have seen in earlier chapters, there is a strong foundation for using symplectic\nintegrators, for example the existence of perturbative backward error expansions\nwhich are relatively easily calculated, it is desirable to work within this class. On\nthe other hand, as we have mentioned, Nosé-Hoover dynamics is not a Hamiltonian\nsystem. The Nosé-Poincaré method resolves this issue by providing a Hamiltonian-\nbased extension of the physical system whose projected trajectories are actually\nequivalent to Nosé-Hoover trajectories, in the absence of numerical errors. This\nextended Hamiltonian system can then be discretized using a symplectic method.\nNosé’s original proposal involved using the dynamics of the Hamiltonian\nHN D 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C .Nd C 1/kBT ln s\nto deﬁne an extension which can be used for canonical sampling. The dynamics\nfor constant Nosé extended energy, when reduced to the .q; p D Qp=s/ plane will\npreserve the canonical measure \u0005ˇ. However, the scaling of kinetic energy induces\na time transformation, which is inconvenient for molecular modelling purposes. The\nNosé-Poincaré method introduces an explicit unraveling of the time transformation.\nOne works with the modiﬁed Nosé-Poincaré (NP) Hamiltonian [41, 102]:\nHNP D sŒHN \u0003 EN\t D s\n\u0002 1\n2s2 QpTM\u00021Qp C \u00142\n2\u0006 C U.q/ C NdkBT ln s \u0003 EN\n\u0003\n;\n(8.9)\nwhere EN is a constant equal to the initial Nosé energy of the system. Trajectories of\nthis system unfold on a timescale which is in some sense commensurate with that of\nHamiltonian dynamics. The NP Hamiltonian system can be treated with symplectic\nintegrators, conferring a possible stability advantage. Symplectic integrators for this\nsystem are compared in [41].\nThe equations of motion associated to (8.9) are\nd\ndtq D M\u00021Qp=s;\n(8.10)\nd\ndt Qp D sF;\n(8.11)\nd\ndts D sps=\u0006;\n(8.12)\nd\ndtps D QpTM\u00021Qp\ns2\n\u0003 NdkBT \u0003 \u0016HN;\n(8.13)\nwhere \u0016HN D HN \u0003 H0\nN (H0\nN represents the value of the Nosé Hamiltonian at the\ninitial point).\n"
    }
  ],
  "numbered_equations": [
    "8.10",
    "8.11",
    "8.12",
    "8.13"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。",
  "context_notation": [],
  "extra_assumptions": [
    "ΔH采用(8.9)展开内的N_d版本；β,Q>0及s>0为有效域；尚未桥接实际Hamiltonian梯度。",
    "已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。",
    "[EXTRA] npValidDomain明确列有效物理域；使用npField作NP方程时必须另具此资格，总函数自身不强制。"
  ],
  "issues": [
    "[ERRATUM?] ΔH_N采用(8.9)展开中的N_d版本，与前一定义(N_d+1)版本不同，须明确区分。",
    "已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。"
  ],
  "statement_scope": "NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。",
  "lean_decl": "MD.Ch08.npField",
  "lean_declarations": [
    "MD.Ch08.npDeltaN_corrected",
    "MD.Ch08.npValidDomain",
    "MD.Ch08.npField"
  ],
  "source_page_verification": "本次R1审校：已比对R1_PAGES.pdf附件第12页的页面图像及文字层；以页面数学排版为准。",
  "repair_log": [
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "NEEDS_HUMAN",
      "issue_codes": [
        "IRRELEVANT_TRANSCRIPTION_NOTE",
        "STALE_VERIFICATION_REFERENCE",
        "SOURCE_MATHEMATICAL_ERRATUM"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    },
    {
      "instruction": 31,
      "stage": "human_triage",
      "change": "已目视核对原页PDF355：delta取H_N^(n)−E_N，不能与上式(n+1)/β版本混同。；[EXTRA] npValidDomain明确列有效物理域；使用npField作NP方程时必须另具此资格，总函数自身不强制。",
      "suggested_fix": "[ERRATUM?] 给delta命名为H_N^(n)−E_N，保留原页定义并与原印H_N^(n+1)区分。明确本def未证明是Hamilton方程。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "NP四漂移分量、n/β版本的命名能量差及正质量、β,Q,s>0有效域谓词；npField仍为总函数，未证明Hamilton方程。"
  ]
}
```
```lean
/- 修正版采用(8.9)展开中的n/β版本，区别于前文(n+1)/β的同名H_N。 -/
def npDeltaN_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : ℝ :=
  kineticTwice invm z.1.2/(2*z.2.1^2) + z.2.2^2/(2*Q) + U z.1.1 +
    (n : ℝ)/β*Real.log z.2.1 - EN

def npValidDomain (invm : Vec n) (β Q : ℝ) (z : Phase n × (ℝ × ℝ)) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q ∧ 0 < z.2.1

def npField (invm : Vec n) (U : Vec n → ℝ) (β Q EN : ℝ)
    (z : Phase n × (ℝ × ℝ)) : Phase n × (ℝ × ℝ) :=
  let s := z.2.1
  let π := z.2.2
  let delta := npDeltaN_corrected invm U β Q EN z
  ((fun i ↦ invm i*z.1.2 i/s, fun i ↦ -s*gradient U z.1.1 i),
   (s*π/Q, kineticTwice invm z.1.2/s^2-(n : ℝ)/β-delta))
```

## MD-8.2.1-Examples81and82
```json
{
  "source_id": "MD-8.2.1-Examples81and82",
  "kind": "unnumbered_claim",
  "label": "Examples 8.1, 8.2",
  "section": "8.2.1",
  "printed_page": "337–338",
  "pdf_page": "358–359",
  "statement_latex": "Example 8.1 Φ=-ξ(0,p), g=μ⁻¹(p·∇pH-N_d k_BT). Example 8.2 Φ=ξG(z), g=μ⁻¹[∇H-k_BT∇]·G. Configurational choice G=(∇qK,0).",
  "statement_verbatim": "8.2\nMore General Deterministic Thermostats\n337\nWe divide this into four parts: L\u0004\u0005 D W1 C W2 C W3 C W4, where\nW1 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/; W2 D \u0003\u0005rz \u0002 .JrzH C ˚/;\nW3 D \u0003.r\u0002\u0005/ \u0002 g;\nW4 D \u0003\u0005r\u0002 \u0002 g:\nWe seek perturbations of Hamiltonian dynamics with separable equilibria, i.e., such\nthat \u0005 D \u0005ˇ.H.z// O\u0005.\u0002/ is a stationary solution.\nTaking this as an ansatz, the ﬁrst term can be simpliﬁed as follows:\nW1 D \u0003 O\u0005.\u0002/\u00050\nˇ.H/rzH \u0002 .JrzH C ˚/\nD ˇ O\u0005.\u0002/\u0005ˇ.H/rzH \u0002 ˚ D ˇ\u0005rzH \u0002 ˚\nas J is skew-symmetric.\nUsing the volume preservation of Hamiltonian systems, the second term satisﬁes\nW2 D \u0003\u0005rz \u0002 .JrzH C ˚/ D \u0003\u0005rz \u0002 ˚;\nhence\nW1 C W2 D \u0003\u0005Œrz \u0003 ˇrzH\t \u0002 ˚:\nThere are many possibilities for the distribution of \u0002, of course, but we will\nassume this is Gaussian for simplicity: O\u0005.\u0002/\nD\nexp\n\u0004\n\u0003ˇ Pm\niD1 \u0006i\u00122\ni =2\n\u0005\nD\nexp.\u0003ˇ\u0002T\u0007\u00021\u0002=2/ to get\nW3 D \u0003.r\u0002\u0005/ \u0002 g.\u0002; z/ D ˇ\u0005\u0002T\u0007\u00021g:\nFinally, for an equilibrium solution we must have W1 C W2 C W3 C W4 D 0, so\n\u0003Œrz \u0003 ˇrzH\t \u0002 ˚ C ˇ\u0002T\u0007\u00021g \u0003 r\u0002 \u0002 g D 0:\nThis equation is the fundamental one for deterministic thermostats.\nExample 8.1 To recover Nosé-Hoover, assume an even dimensional phase space,\nz D .q; p/, Nd degrees of freedom, and \u0012 2 R,\n˚ D \u0003\u0012\n\u0002 0\np\n\u0003\n;\ng.z/ D \u0006\u00021.p \u0002 rpH \u0003 NdkBT/:\nExample 8.2 Slightly more generally, let\n˚ D \u0012G.z/;\ng.\u0012; z/ D g.z/ D \u0006\u00021ŒrzH \u0003 kBTrz\t \u0002 G.z/:\n\n338\n8\nExtended Variable Methods\nThis is a slightly generalized form of the technique suggested by Bulgac and\nKusnezov [58].\nAssuming \u0005 goes to zero sufﬁciently rapidly at inﬁnity, we have\nZ\nrz \u0002 G.z/\u0005d! D \u0003\nZ\n.rz\u0005/ \u0002 G.z/d! D ˇ\nZ\nrzH \u0002 G.z/\u0005d!;\nusing integration by parts, therefore, since ˇ\u00021 D kBT,\nT D k\u00021\nB\nhrzH \u0002 Gi\nhr \u0002 Gi ;\nwhich gives formulas for temperature in terms of phase space averages (compare\nChap. 6, Proposition 6.1).\nSuppose we let K be a scalar valued function of position, and set\nG.z/ D\n\u0002 rqK.q/\n0\n\u0003\nthen we arrive at\ng.z/ D \u0006\u00021ŒrqU \u0003 kBTrq\t \u0002 rqK.q/:\nThis is an example of a “conﬁgurational thermostat” [193, 211, 319].\nA useful fact about thermostats is the following:\nProposition 8.1 (Thermostats are Additive) Suppose we are given two ther-\nmostats,\nPz D JrH C ˚1.\u0002; z/;\nP\u0002 D g1.\u0002; z/;\nwith stationary density O\u00051.\u0002/\u0005ˇ, and another\nPz D JrH C ˚2.\u0003; z/;\nP\u0003 D g2.\u0003; z/;\nwith stationary density O\u00052.\u0003/\u0005ˇ, then\nPz D JrH C ˚1.\u0002; z/ C ˚2.\u0003; z/;\nP\u0002 D g1.\u0002; z/;\nP\u0003 D g2.\u0003; z/\nis another thermostat and has stationary density Q\u0005 D O\u00051.\u0002/ O\u00052.\u0003/\u0005ˇ.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 358,
      "printed_page": 337,
      "text": "8.2\nMore General Deterministic Thermostats\n337\nWe divide this into four parts: L\u0004\u0005 D W1 C W2 C W3 C W4, where\nW1 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/; W2 D \u0003\u0005rz \u0002 .JrzH C ˚/;\nW3 D \u0003.r\u0002\u0005/ \u0002 g;\nW4 D \u0003\u0005r\u0002 \u0002 g:\nWe seek perturbations of Hamiltonian dynamics with separable equilibria, i.e., such\nthat \u0005 D \u0005ˇ.H.z// O\u0005.\u0002/ is a stationary solution.\nTaking this as an ansatz, the ﬁrst term can be simpliﬁed as follows:\nW1 D \u0003 O\u0005.\u0002/\u00050\nˇ.H/rzH \u0002 .JrzH C ˚/\nD ˇ O\u0005.\u0002/\u0005ˇ.H/rzH \u0002 ˚ D ˇ\u0005rzH \u0002 ˚\nas J is skew-symmetric.\nUsing the volume preservation of Hamiltonian systems, the second term satisﬁes\nW2 D \u0003\u0005rz \u0002 .JrzH C ˚/ D \u0003\u0005rz \u0002 ˚;\nhence\nW1 C W2 D \u0003\u0005Œrz \u0003 ˇrzH\t \u0002 ˚:\nThere are many possibilities for the distribution of \u0002, of course, but we will\nassume this is Gaussian for simplicity: O\u0005.\u0002/\nD\nexp\n\u0004\n\u0003ˇ Pm\niD1 \u0006i\u00122\ni =2\n\u0005\nD\nexp.\u0003ˇ\u0002T\u0007\u00021\u0002=2/ to get\nW3 D \u0003.r\u0002\u0005/ \u0002 g.\u0002; z/ D ˇ\u0005\u0002T\u0007\u00021g:\nFinally, for an equilibrium solution we must have W1 C W2 C W3 C W4 D 0, so\n\u0003Œrz \u0003 ˇrzH\t \u0002 ˚ C ˇ\u0002T\u0007\u00021g \u0003 r\u0002 \u0002 g D 0:\nThis equation is the fundamental one for deterministic thermostats.\nExample 8.1 To recover Nosé-Hoover, assume an even dimensional phase space,\nz D .q; p/, Nd degrees of freedom, and \u0012 2 R,\n˚ D \u0003\u0012\n\u0002 0\np\n\u0003\n;\ng.z/ D \u0006\u00021.p \u0002 rpH \u0003 NdkBT/:\nExample 8.2 Slightly more generally, let\n˚ D \u0012G.z/;\ng.\u0012; z/ D g.z/ D \u0006\u00021ŒrzH \u0003 kBTrz\t \u0002 G.z/:\n"
    },
    {
      "pdf_page": 359,
      "printed_page": 338,
      "text": "338\n8\nExtended Variable Methods\nThis is a slightly generalized form of the technique suggested by Bulgac and\nKusnezov [58].\nAssuming \u0005 goes to zero sufﬁciently rapidly at inﬁnity, we have\nZ\nrz \u0002 G.z/\u0005d! D \u0003\nZ\n.rz\u0005/ \u0002 G.z/d! D ˇ\nZ\nrzH \u0002 G.z/\u0005d!;\nusing integration by parts, therefore, since ˇ\u00021 D kBT,\nT D k\u00021\nB\nhrzH \u0002 Gi\nhr \u0002 Gi ;\nwhich gives formulas for temperature in terms of phase space averages (compare\nChap. 6, Proposition 6.1).\nSuppose we let K be a scalar valued function of position, and set\nG.z/ D\n\u0002 rqK.q/\n0\n\u0003\nthen we arrive at\ng.z/ D \u0006\u00021ŒrqU \u0003 kBTrq\t \u0002 rqK.q/:\nThis is an example of a “conﬁgurational thermostat” [193, 211, 319].\nA useful fact about thermostats is the following:\nProposition 8.1 (Thermostats are Additive) Suppose we are given two ther-\nmostats,\nPz D JrH C ˚1.\u0002; z/;\nP\u0002 D g1.\u0002; z/;\nwith stationary density O\u00051.\u0002/\u0005ˇ, and another\nPz D JrH C ˚2.\u0003; z/;\nP\u0003 D g2.\u0003; z/;\nwith stationary density O\u00052.\u0003/\u0005ˇ, then\nPz D JrH C ˚1.\u0002; z/ C ˚2.\u0003; z/;\nP\u0002 D g1.\u0002; z/;\nP\u0003 D g2.\u0003; z/\nis another thermostat and has stationary density Q\u0005 D O\u00051.\u0002/ O\u00052.\u0003/\u0005ˇ.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。",
  "context_notation": [],
  "extra_assumptions": [
    "Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。",
    "generalizedFeedback/configurationalFeedback忠实保留原式；corrected将Φ改为−ξG。构型反馈在正号耦合下同样须反号。"
  ],
  "issues": [
    "已目视核对原页PDF358–359：例8.2确实印为正号耦合与正反馈，驻定声称有符号疑误，不是转录错误。",
    "[ERRATUM?] 例8.2正号耦合与所印正反馈不能保持所列高斯Gibbs权；额外generalizedFeedback_stationary签名错误，见本次审校反例。"
  ],
  "statement_scope": "原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。",
  "lean_decl": "MD.Ch08.generalizedFeedback",
  "lean_declarations": [
    "MD.Ch08.generalizedFeedback",
    "MD.Ch08.configurationalFeedback",
    "MD.Ch08.generalizedFeedback_stationaryPrinted",
    "MD.Ch08.generalizedFeedback_stationary_corrected"
  ],
  "source_page_verification": "本次R1审校：已比对R1_PAGES.pdf附件第19,20页的页面图像及文字层；以页面数学排版为准。",
  "repair_log": [
    {
      "instruction": 31,
      "website_verdict": "FAIL",
      "suggested_fix": "[ERRATUM?] 忠实原文的两个反馈def可保留并标Printed/literal；正确驻定版应取Φ=−ξG，或保留Φ=+ξG而改g=(div G/β−DH[G])/Q。构型反馈若配正号耦合也须相应反号。例8.1的负号耦合与正反馈不受影响。",
      "change": "generalizedFeedback/configurationalFeedback忠实保留原式；corrected将Φ改为−ξG。构型反馈在正号耦合下同样须反号。"
    },
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "NEEDS_HUMAN",
      "issue_codes": [
        "IRRELEVANT_TRANSCRIPTION_NOTE",
        "STALE_VERIFICATION_REFERENCE",
        "SOURCE_MATHEMATICAL_ERRATUM",
        "FALSE_STATIONARITY_SIGNATURE"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "原印一般G与构型反馈、正号组合Printed驻定声称，以及负号耦合的局部驻定修正版；不含全局过程不变性。"
  ]
}
```
```lean
def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
/-- 原文正号组合的驻定声称；原书疑误，保留字面版，不作为有效定理。 -/
theorem generalizedFeedback_stationaryPrinted (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry

/-- 修正版：仅将耦合改为负号，反馈保留原式；原文例8.2另存。 -/
theorem generalizedFeedback_stationary_corrected (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 - z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry
```

## MD-8.4-AdditiveThermostatSDE
```json
{
  "source_id": "MD-8.4-AdditiveThermostatSDE",
  "kind": "definition",
  "label": null,
  "section": "8.4",
  "printed_page": "342–343",
  "pdf_page": "363–364",
  "statement_latex": "dq=M⁻¹pdt; dp=-∇Udt-Φ(ξ,z)-Γpdt+√(2k_BT)M^{1/2}Γ^{1/2}dW; dξ=gdt-Γ̂ξdt+√(2k_BT)M̂^{1/2}Γ̂^{1/2}dŴ. All Wiener coordinates are independent.",
  "statement_verbatim": "342\n8\nExtended Variable Methods\notherwise there is little clear advantage and a potentially signiﬁcant price to be\npaid, since HMC methods only work by rejecting steps. For reading on Hybrid\nMonte Carlo methods, the reader should consult [110, 188] and other references\nmentioned in Appendix C.\n•\nKinetic Monte-Carlo (KMC) methods are a broad family of multiscale sampling\nmethods which use a local sampling mechanism to explore basins while invoking\nan Arrenhius law to estimate the rates or timescales for transitions between\nbasins (we can think of basins as neighborhoods of potential energy minima).\nThe Arrenhius law relates the rate constant k associated to a particular state-\nto-state transition to the exponential of the of the “activation energy” which is\ndeﬁned as the difference \u0010E between the energy at a local minimum and that at\nthe energy barrier between the states\nk \u0005 Ae\u0002\u0010E=kBT\nIn a KMC method, it is typically assumed that various possible state-to-state\ntransitions from a given state are well modelled by the Arrenhius law and then\nmolecular dynamics is used to calculate the prefactor A and energy difference \u0010E\nin order to understand the timescales and relative probabilities of different rare\nevents. A Markov state model can be developed to help understand the global\ndynamics and simplify the model as a whole. For references on many interesting\napproaches to this important topic, the reader is referred to [36, 42, 137, 149, 391].\n•\nAndersen Thermostat. Of particular interest is the simple and useful Andersen\nthermostat [11]. This method works by selecting atoms at random and randomly\nperturbing their momenta in a way consistent with prescribed thermodynamic\nconditions. It has been rigorously proven to sample the canonical distribution\n[114].\n8.4\nErgodic Stochastic-Dynamic Thermostats\nIn this section, we consider the combination of stochastic perturbation with a\ndeterministic thermostat. Methods constructed in this way can be ergodic for\nthe canonical distribution while also providing ﬂexibility in way equilibrium is\nachieved. We distinguish in (6.16) between multiplicative noise, where B D B.z/\nvaries with z and additive noise, where B is constant. In our treatment of this topic\nwe will only consider additive noise. The presence of multiplicative noise may\ncomplicate discretization. As we shall see, the reliance on additive noise improves\nthe performance of discretization schemes.\nTo give this some speciﬁcity for molecular dynamics, we write the stochastic\ndynamical model as\ndq D M\u00021pdt;\n(8.22)\n\n8.4\nErgodic Stochastic-Dynamic Thermostats\n343\ndp D \u0003rU.q/dt \u0003 ˚.\u0002; z/ \u0003 \u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW;\n(8.23)\nd\u0002 D g.\u0002; q; p/dt \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW:\n(8.24)\nHere \u0010 ; O\u0010\nare symmetric, square matrices of appropriate dimension, W is a\nvector of Nc Wiener processes, and OW is a vector of m Wiener processes, all\nindependent of each other. We assume that the deterministic thermostat represented\nby the ˚ and g terms preserves the extended distribution O\u0005.\u0002/\u0005ˇ, where O\u0005.\u0002/ D\nexp\n\u0006\n\u0003ˇ\u0002T OM\n\u00021\u0002=2\n\u0007\n. The matrix OM is symmetric and positive deﬁnite; one could\ntake it to be diagonal.\nThe additivity property of thermostats mentioned above holds also for stochastic\nthermostats, since the Fokker-Planck equation is constructed from linear operations\non the vector ﬁelds involved, thus it is enough to require that the newly introduced\nterms satisfy appropriate ﬂuctuation-dissipation relationships so that they are\ncompatible with the extended Gibbs distribution of the deterministic part. That is,\nwe require\ndp D \u0003\u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW\nto preserve the distribution with density N\u0005 D exp\n\u0004\n\u0003ˇpTM\u00021p=2\n\u0005\n, and\nd\u0002 D \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW\nto preserve O\u0005. These two problems are essentially the same. Considering the former,\nthe stationary Fokker-Planck equation reads\nrp \u0002 .\u0010 p N\u0005/\n„\nƒ‚\n…\ndrift\nC ˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2r2\np N\u0005M1=2\u0010 1=2\u0007\n„\nƒ‚\n…\ndiffusion\nD 0:\nThe drift term here equates to\nTr.\u0010 / N\u0005 C .\u0003ˇ/pT\u0010 M\u00021p N\u0005:\nFor the diffusion term, we calculate\nr N\u0005 D \u0003ˇ N\u0005M\u00021p;\nthus\nr2 N\u0005 D N\u0005Œˇ2M\u00021ppTM\u00021 \u0003 ˇM\u00021\t;\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 363,
      "printed_page": 342,
      "text": "342\n8\nExtended Variable Methods\notherwise there is little clear advantage and a potentially signiﬁcant price to be\npaid, since HMC methods only work by rejecting steps. For reading on Hybrid\nMonte Carlo methods, the reader should consult [110, 188] and other references\nmentioned in Appendix C.\n•\nKinetic Monte-Carlo (KMC) methods are a broad family of multiscale sampling\nmethods which use a local sampling mechanism to explore basins while invoking\nan Arrenhius law to estimate the rates or timescales for transitions between\nbasins (we can think of basins as neighborhoods of potential energy minima).\nThe Arrenhius law relates the rate constant k associated to a particular state-\nto-state transition to the exponential of the of the “activation energy” which is\ndeﬁned as the difference \u0010E between the energy at a local minimum and that at\nthe energy barrier between the states\nk \u0005 Ae\u0002\u0010E=kBT\nIn a KMC method, it is typically assumed that various possible state-to-state\ntransitions from a given state are well modelled by the Arrenhius law and then\nmolecular dynamics is used to calculate the prefactor A and energy difference \u0010E\nin order to understand the timescales and relative probabilities of different rare\nevents. A Markov state model can be developed to help understand the global\ndynamics and simplify the model as a whole. For references on many interesting\napproaches to this important topic, the reader is referred to [36, 42, 137, 149, 391].\n•\nAndersen Thermostat. Of particular interest is the simple and useful Andersen\nthermostat [11]. This method works by selecting atoms at random and randomly\nperturbing their momenta in a way consistent with prescribed thermodynamic\nconditions. It has been rigorously proven to sample the canonical distribution\n[114].\n8.4\nErgodic Stochastic-Dynamic Thermostats\nIn this section, we consider the combination of stochastic perturbation with a\ndeterministic thermostat. Methods constructed in this way can be ergodic for\nthe canonical distribution while also providing ﬂexibility in way equilibrium is\nachieved. We distinguish in (6.16) between multiplicative noise, where B D B.z/\nvaries with z and additive noise, where B is constant. In our treatment of this topic\nwe will only consider additive noise. The presence of multiplicative noise may\ncomplicate discretization. As we shall see, the reliance on additive noise improves\nthe performance of discretization schemes.\nTo give this some speciﬁcity for molecular dynamics, we write the stochastic\ndynamical model as\ndq D M\u00021pdt;\n(8.22)\n"
    },
    {
      "pdf_page": 364,
      "printed_page": 343,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n343\ndp D \u0003rU.q/dt \u0003 ˚.\u0002; z/ \u0003 \u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW;\n(8.23)\nd\u0002 D g.\u0002; q; p/dt \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW:\n(8.24)\nHere \u0010 ; O\u0010\nare symmetric, square matrices of appropriate dimension, W is a\nvector of Nc Wiener processes, and OW is a vector of m Wiener processes, all\nindependent of each other. We assume that the deterministic thermostat represented\nby the ˚ and g terms preserves the extended distribution O\u0005.\u0002/\u0005ˇ, where O\u0005.\u0002/ D\nexp\n\u0006\n\u0003ˇ\u0002T OM\n\u00021\u0002=2\n\u0007\n. The matrix OM is symmetric and positive deﬁnite; one could\ntake it to be diagonal.\nThe additivity property of thermostats mentioned above holds also for stochastic\nthermostats, since the Fokker-Planck equation is constructed from linear operations\non the vector ﬁelds involved, thus it is enough to require that the newly introduced\nterms satisfy appropriate ﬂuctuation-dissipation relationships so that they are\ncompatible with the extended Gibbs distribution of the deterministic part. That is,\nwe require\ndp D \u0003\u0010 pdt C\np\n2kBTM1=2\u0010 1=2dW\nto preserve the distribution with density N\u0005 D exp\n\u0004\n\u0003ˇpTM\u00021p=2\n\u0005\n, and\nd\u0002 D \u0003 O\u0010 \u0002dt C\np\n2kBT OM\n1=2 O\u0010\n1=2d OW\nto preserve O\u0005. These two problems are essentially the same. Considering the former,\nthe stationary Fokker-Planck equation reads\nrp \u0002 .\u0010 p N\u0005/\n„\nƒ‚\n…\ndrift\nC ˇ\u00021Tr\n\u0006\n\u0010 1=2M1=2r2\np N\u0005M1=2\u0010 1=2\u0007\n„\nƒ‚\n…\ndiffusion\nD 0:\nThe drift term here equates to\nTr.\u0010 / N\u0005 C .\u0003ˇ/pT\u0010 M\u00021p N\u0005:\nFor the diffusion term, we calculate\nr N\u0005 D \u0003ˇ N\u0005M\u00021p;\nthus\nr2 N\u0005 D N\u0005Œˇ2M\u00021ppTM\u00021 \u0003 ˇM\u00021\t;\n"
    }
  ],
  "numbered_equations": [
    "8.22",
    "8.23",
    "8.24"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "加性噪声用独立Wiener路径增量的精确积分方程；漂移可积、路径连续且适应自然历史。完整矩阵噪声给因子B和涨落耗散资格，物理/热浴两组坐标共同独立。",
    "[EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。",
    "[EXTRA]漂移采用M⁻¹=diag(invm)的正对角、无约束特例；现有定义尚未把独立的M参数绑定到invm。",
    "[ERRATUM?]原矩阵平方根噪声须补半正定性及协方差相容条件。fluctuationDissipation规定BBᵀ=(2/β)ΓM，对称M、Γ下还强制ΓM=MΓ，是明确限制后的修正资格。",
    "完整两组SDE需要一个统一的n+k维独立Wiener向量、分块噪声因子、对应漂移及两组协方差约束；本条尚无这项组装声明。"
  ],
  "issues": [
    "已目视核对原页PDF364：(8.23)的−Φ项确实漏dt；漂移解释补dt。矩阵不交换时原平方根噪声与驻定协方差未必相容。",
    "[ERRATUM?]原书矩阵噪声的对称性不足以保证Gibbs相容。",
    "现有声明只是未组装的定义组件。"
  ],
  "statement_scope": "常噪声积分SDE模板与正对角物理质量的统一恒温器解规格；同一n+k维独立Wiener、分块噪声、两组协方差和漂移质量已绑定。未含一般非对角物理质量、存在唯一性或不变律。",
  "lean_decl": "MD.Ch08.independentWiener",
  "lean_declarations": [
    "MD.Ch08.independentWiener",
    "MD.Ch08.additiveSDE",
    "MD.Ch08.stochasticThermostatDrift",
    "MD.Ch08.fluctuationDissipation",
    "MD.Ch08.thermostatBlockNoise",
    "MD.Ch08.stochasticThermostatSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 31,
      "website_verdict": "FAIL",
      "suggested_fix": "只修JSON范围可保留现有组件；如要完成原模型，另定义统一解谓词，绑定对角逆质量或直接用一般M⁻¹，构造分块B和共同n+k维独立W，并分别加入两组明确的协方差匹配条件。保留原文并注明(8.23)的dt疑误和矩阵相容疑误。本次不修改工程。",
      "change": "[EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。"
    },
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "NEEDS_HUMAN",
      "issue_codes": [
        "SDE_MODEL_NOT_ASSEMBLED",
        "MASS_PARAMETER_LINK_MISSING",
        "ERRATUM_MATRIX_NOISE_COMPATIBILITY"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "[EXTRA] 正逆质量、C¹势；物理质量固定为diag(invm⁻¹)，Mhat为热浴协方差质量；两组涨落耗散均绑定同一β及实际阻尼。未构造矩阵平方根，未证明确定性热浴保权或完整过程不变性。",
    "完整两组SDE需要一个统一的n+k维独立Wiener向量、分块噪声因子、对应漂移及两组协方差约束；本条尚无这项组装声明。"
  ]
}
```
```lean
def independentWiener (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, IsBrownianReal (fun t sample ↦ W t sample j) P) ∧
    iIndepFun (fun j sample ↦ fun t : ℝ ↦ W t sample j) P
def additiveSDE {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [MeasurableSpace E]
    (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k)
    (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : Fin k → E) : Prop :=
  independentWiener P k W ∧ (∀ᵐ sample ∂P, Continuous (fun t ↦ X t sample)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ t : ℝ, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 t) ∧
    ∀ᵐ sample ∂P, X t sample = x0 + (∫ s in 0..t, a (X s sample)) +
      ∑ j, (W t sample j-W 0 sample j) • B j
def stochasticThermostatDrift {k : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ : Matrix (Fin n) (Fin n) ℝ) (Γhat : Matrix (Fin k) (Fin k) ℝ)
    (z : Phase n × Vec k) : Phase n × Vec k :=
  ((fun i ↦ invm i*z.1.2 i, fun i ↦ -gradient U z.1.1 i-Φ z i-(Γ *ᵥ z.1.2) i),
   g z - Γhat *ᵥ z.2)
def fluctuationDissipation (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ) : Prop :=
  0 < β ∧ M.PosDef ∧ Γ.PosSemidef ∧ B*B.transpose = (2/β) • (Γ*M)

/-- 两组噪声共用一个n+k维独立Wiener过程，分块只作用于p和ξ。 -/
def thermostatBlockNoise {k : ℕ}
    (B : Matrix (Fin n) (Fin n) ℝ) (Bhat : Matrix (Fin k) (Fin k) ℝ)
    (j : Fin (n+k)) : Phase n × Vec k :=
  if hj : j.val < n then
    ((0,fun i ↦ B i ⟨j.val,hj⟩),0)
  else ((0,0),fun i ↦ Bhat i ⟨j.val-n,by omega⟩)

/-- 正对角物理质量特例的统一积分解规格；两组协方差与实际漂移使用同一质量。
不含一般非对角物理质量，也不声称由此已证明存在、唯一或不变分布。 -/
def stochasticThermostatSolution {k : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → Vec (n+k)) (X : ℝ → Ω → Phase n × Vec k)
    (x0 : Phase n × Vec k) (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ B : Matrix (Fin n) (Fin n) ℝ)
    (Mhat Γhat Bhat : Matrix (Fin k) (Fin k) ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧
  fluctuationDissipation (Matrix.diagonal (fun i ↦ (invm i)⁻¹)) Γ B β ∧
  fluctuationDissipation Mhat Γhat Bhat β ∧
  additiveSDE P (n+k) W X x0 (stochasticThermostatDrift invm U Φ g Γ Γhat)
    (thermostatBlockNoise B Bhat)
```
