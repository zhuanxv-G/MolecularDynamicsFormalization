# BATCH14 第8章原文与陈述审校

## MD-8.8.1-PistonThermostatWeightPrinted
```json
{
  "source_id": "MD-8.8.1-PistonThermostatWeightPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8.1",
  "printed_page": "381",
  "pdf_page": "402",
  "statement_latex": "The book prints ρ₂=exp(−β[pᵀM⁻¹p+μ_Tξ²/2])ψ₂(q,η,V) for ṗ=−ξp, ξ̇=(pᵀM⁻¹p−N_dk_BT)/μ_T.",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n381\n8.8.1\nEquations of Motion for the NHL Piston\nIn the framework of [199], rewriting the equations of motion for the physical\nvariables q and p, the dynamics takes the form\nPq D M\u00021p C \u000fq;\nPp D \u0003rU.q/ \u0003 \u000fp \u0003 \u0012p;\nPV D \u000fV;\nwith auxiliary variables \u000f and \u0012 governed by additional dynamical equations of\nmotion\nP\u0012 D hT\ndef\nD .pTM\u00021p \u0003 NdkBT/=\u0006T;\nP\u000f D hP\ndef\nD .V˘.q; p; V/ \u0003 PV C kBT/=\u0006P;\nwhere\n˘.q; p; V/\ndef\nD 1\nV\n\b\npTM\u00021p \u0003 q \u0002 rU.q/ \u0003 V @\n@V U.q/\n\t\n;\nis the expression for the pressure.\nNow let us examine the distribution conserved by the dynamics. First, we observe\n\u00051 D '1.pTM\u00021p=2 C U.q// \u0004 .V; \u0012; \u000f/\nis stationary for the Liouvillian operator for the vector ﬁeld .p; \u0003rU; 0; 0; 0/.\nThe function can be chosen as any smooth function that integrates out with\nrespect to V; \u0012; \u000f over Œ0; 1\t \u0004 R \u0004 R. We already know from our discussion of\nNosé-Hoover that Pp D \u0003\u0012p; P\u0012 D .pTM\u00021p \u0003 NdkBT/=\u0006T will have as stationary\nstates functions of the form\n\u00052 D exp.\u0003ˇŒpTM\u00021p C \u0006T\u00122=2\t/ 2.q; \u000f; V/:\nFinally the remaining terms Pq D \u000fq, Pp D \u0003\u000fp, PV D \u000fV, P\u000f D .V˘.q; p; V/ \u0003 PV C\nkBT/=\u0006P give rise to the Liouvillian\nL\u0004\u0005 D \u0003\u000frq \u0002.q\u0005/C\u000frp \u0002.p\u0005/\u0003\u000f @\n@V .V\u0005/\u0003 @\n@\u000fŒ\u0005.V˘.q; p; V/\u0003PV CkBT/=\u0006P\t:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 402,
      "printed_page": 381,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n381\n8.8.1\nEquations of Motion for the NHL Piston\nIn the framework of [199], rewriting the equations of motion for the physical\nvariables q and p, the dynamics takes the form\nPq D M\u00021p C \u000fq;\nPp D \u0003rU.q/ \u0003 \u000fp \u0003 \u0012p;\nPV D \u000fV;\nwith auxiliary variables \u000f and \u0012 governed by additional dynamical equations of\nmotion\nP\u0012 D hT\ndef\nD .pTM\u00021p \u0003 NdkBT/=\u0006T;\nP\u000f D hP\ndef\nD .V˘.q; p; V/ \u0003 PV C kBT/=\u0006P;\nwhere\n˘.q; p; V/\ndef\nD 1\nV\n\b\npTM\u00021p \u0003 q \u0002 rU.q/ \u0003 V @\n@V U.q/\n\t\n;\nis the expression for the pressure.\nNow let us examine the distribution conserved by the dynamics. First, we observe\n\u00051 D '1.pTM\u00021p=2 C U.q// \u0004 .V; \u0012; \u000f/\nis stationary for the Liouvillian operator for the vector ﬁeld .p; \u0003rU; 0; 0; 0/.\nThe function can be chosen as any smooth function that integrates out with\nrespect to V; \u0012; \u000f over Œ0; 1\t \u0004 R \u0004 R. We already know from our discussion of\nNosé-Hoover that Pp D \u0003\u0012p; P\u0012 D .pTM\u00021p \u0003 NdkBT/=\u0006T will have as stationary\nstates functions of the form\n\u00052 D exp.\u0003ˇŒpTM\u00021p C \u0006T\u00122=2\t/ 2.q; \u000f; V/:\nFinally the remaining terms Pq D \u000fq, Pp D \u0003\u000fp, PV D \u000fV, P\u000f D .V˘.q; p; V/ \u0003 PV C\nkBT/=\u0006P give rise to the Liouvillian\nL\u0004\u0005 D \u0003\u000frq \u0002.q\u0005/C\u000frp \u0002.p\u0005/\u0003\u000f @\n@V .V\u0005/\u0003 @\n@\u000fŒ\u0005.V˘.q; p; V/\u0003PV CkBT/=\u0006P\t:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "仅取ψ₂=1的局部权重等式；任意冻结变量乘子和可归一概率还需额外资格，列覆盖缺口。"
  ],
  "issues": [
    "已目视核对原页PDF402：ρ₂动能项缺1/2；所印反馈仍为pᵀM⁻¹p−N_dk_BT。原印权重保留，工作修正采用标准动能的一半。"
  ],
  "statement_scope": "原印/修正权重及ψ₂=1时的实际子场驻定目标。",
  "lean_decl": "MD.Ch08.pistonThermostatPart",
  "lean_declarations": [
    "MD.Ch08.pistonThermostatPart",
    "MD.Ch08.pistonRho2Printed",
    "MD.Ch08.pistonRho2_corrected",
    "MD.Ch08.pistonRho2_stationary_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pistonThermostatPart (invm : Vec n) (θ QT : ℝ) (z : PistonState n) : PistonState n :=
  ((0,fun i ↦ -z.2 1*z.1.2 i),![0,(kineticTwice invm z.1.2-n*θ)/QT,0])
def pistonRho2Printed (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2+QT*(z.2 1)^2/2))
def pistonRho2_corrected (invm : Vec n) (β QT : ℝ) (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+QT*(z.2 1)^2/2))
theorem pistonRho2_stationary_corrected (invm : Vec n) (β QT : ℝ)
    (hm : ∀ i, 0 < invm i) (hβ : 0 < β) (hQT : 0 < QT) (z : PistonState n) :
    textbookDivergence (fun x ↦ pistonRho2_corrected invm β QT x •
      pistonThermostatPart invm β⁻¹ QT x) z=0 := by
  sorry
```

## MD-8.8.1-PistonReducedPDE
```json
{
  "source_id": "MD-8.8.1-PistonReducedPDE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8.1",
  "printed_page": "382",
  "pdf_page": "403",
  "statement_latex": "−q·∇qψ+p·∇pψ−ψ−V∂Vψ+(βVΠ−βPV+1)ψ=0, solved by ψ∝exp(−β(H+PV)). (8.74).",
  "statement_verbatim": "382\n8\nExtended Variable Methods\nIf \u0005 has the form \u0005 D exp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .q; p; V; \u0012/ then eliminate \u000f, reducing\nL\u0004\u0005 D 0 to\n\u0003rq \u0002 .q / C rp \u0002 .p / \u0003 @\n@V .V / C ˇ.V˘.q; p; V/ \u0003 PV C kBT/ D 0:\nThis results in\n\u0003 q \u0002 rq C p \u0002 rp \u0003 \u0003 V @ \n@V C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/ D 0:\n(8.74)\nA solution (the desired one) is given by\n / exp.\u0003ˇ.H C PV//;\nwhere substituting into (8.74) gives\nh\nˇq \u0002 rU.q/ \u0003 ˇp \u0002 M\u00021p \u0003 1 C ˇV @U\n@V\nCˇPV C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/\ni\n D 0;\nwhich is quickly checked to be true, and hence the dynamics preserves \u0005 D\nexp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .\nIt is difﬁcult to see how their could be other solutions , but we know from\nthe Nosé-Hoover case that this must be possible. We improve the robustness of\nthe method by introducing Ornstein-Uhlenbeck type stochastic processes in the two\nauxiliary variables \u0012 and \u000f, yielding the system\nPq D M\u00021p C \u000fq;\n(8.75)\nPp D F.q/ \u0003 \u000fp \u0003 \u0012p;\n(8.76)\nPV D \u000fV;\n(8.77)\nd\u0012 D ŒhT \u0003 \nT\u0012\t dt C\np\n2kBT\nT=\u0006TdWT;\n(8.78)\nd\u000f D ŒhP \u0003 \nP\u000f\t dt C\np\n2kBT\nP=\u0006PdWP;\n(8.79)\nwhere \nT; \nP \b 0 are two parameters governing the strength of the noise.\n8.8.2\nDiscretization of the NHL Piston\nObservations in Chap. 7 and our experience with the Nosé-Hoover-Langevinmethod\nlead us to propose splitting methods to separate the Ornstein-Uhlenbeck processes\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 403,
      "printed_page": 382,
      "text": "382\n8\nExtended Variable Methods\nIf \u0005 has the form \u0005 D exp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .q; p; V; \u0012/ then eliminate \u000f, reducing\nL\u0004\u0005 D 0 to\n\u0003rq \u0002 .q / C rp \u0002 .p / \u0003 @\n@V .V / C ˇ.V˘.q; p; V/ \u0003 PV C kBT/ D 0:\nThis results in\n\u0003 q \u0002 rq C p \u0002 rp \u0003 \u0003 V @ \n@V C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/ D 0:\n(8.74)\nA solution (the desired one) is given by\n / exp.\u0003ˇ.H C PV//;\nwhere substituting into (8.74) gives\nh\nˇq \u0002 rU.q/ \u0003 ˇp \u0002 M\u00021p \u0003 1 C ˇV @U\n@V\nCˇPV C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/\ni\n D 0;\nwhich is quickly checked to be true, and hence the dynamics preserves \u0005 D\nexp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .\nIt is difﬁcult to see how their could be other solutions , but we know from\nthe Nosé-Hoover case that this must be possible. We improve the robustness of\nthe method by introducing Ornstein-Uhlenbeck type stochastic processes in the two\nauxiliary variables \u0012 and \u000f, yielding the system\nPq D M\u00021p C \u000fq;\n(8.75)\nPp D F.q/ \u0003 \u000fp \u0003 \u0012p;\n(8.76)\nPV D \u000fV;\n(8.77)\nd\u0012 D ŒhT \u0003 \nT\u0012\t dt C\np\n2kBT\nT=\u0006TdWT;\n(8.78)\nd\u000f D ŒhP \u0003 \nP\u000f\t dt C\np\n2kBT\nP=\u0006PdWP;\n(8.79)\nwhere \nT; \nP \b 0 are two parameters governing the strength of the noise.\n8.8.2\nDiscretization of the NHL Piston\nObservations in Chap. 7 and our experience with the Nosé-Hoover-Langevinmethod\nlead us to propose splitting methods to separate the Ornstein-Uhlenbeck processes\n"
    }
  ],
  "numbered_equations": [
    "8.74"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只核对所印局部微分方程；正V消去压力分母，概率归一、边界通量与遍历性未覆盖。"
  ],
  "issues": [],
  "statement_scope": "完整(8.74)及Boltzmann权代入目标。",
  "lean_decl": "MD.Ch08.pistonReducedOperator",
  "lean_declarations": [
    "MD.Ch08.pistonReducedOperator",
    "MD.Ch08.pistonReduced_boltzmann"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pistonReducedOperator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (ψ : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  -fderiv ℝ ψ z ((z.1.1,0),0)+fderiv ℝ ψ z ((0,z.1.2),0)-ψ z-
  z.2*fderiv ℝ ψ z ((0,0),1)+
    (β*z.2*pistonPressure invm U z.1.1 z.1.2 z.2-β*P*z.2+1)*ψ z
theorem pistonReduced_boltzmann (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (z : Phase n × ℝ) (hV : 0 < z.2) :
    pistonReducedOperator invm U β P
      (fun x ↦ Real.exp (-β*(kineticTwice invm x.1.2/2+U (x.1.1,x.2)+P*x.2))) z=0 := by
  sorry
```

## MD-8.8.1-PistonStationaryWeight
```json
{
  "source_id": "MD-8.8.1-PistonStationaryWeight",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.8.1",
  "printed_page": "382",
  "pdf_page": "403",
  "statement_latex": "Adding the two independent OU thermostats to ξ,η preserves the candidate weight exp[−β(H+PV+μ_Tξ²/2+μ_Pη²/2)].",
  "statement_verbatim": "382\n8\nExtended Variable Methods\nIf \u0005 has the form \u0005 D exp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .q; p; V; \u0012/ then eliminate \u000f, reducing\nL\u0004\u0005 D 0 to\n\u0003rq \u0002 .q / C rp \u0002 .p / \u0003 @\n@V .V / C ˇ.V˘.q; p; V/ \u0003 PV C kBT/ D 0:\nThis results in\n\u0003 q \u0002 rq C p \u0002 rp \u0003 \u0003 V @ \n@V C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/ D 0:\n(8.74)\nA solution (the desired one) is given by\n / exp.\u0003ˇ.H C PV//;\nwhere substituting into (8.74) gives\nh\nˇq \u0002 rU.q/ \u0003 ˇp \u0002 M\u00021p \u0003 1 C ˇV @U\n@V\nCˇPV C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/\ni\n D 0;\nwhich is quickly checked to be true, and hence the dynamics preserves \u0005 D\nexp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .\nIt is difﬁcult to see how their could be other solutions , but we know from\nthe Nosé-Hoover case that this must be possible. We improve the robustness of\nthe method by introducing Ornstein-Uhlenbeck type stochastic processes in the two\nauxiliary variables \u0012 and \u000f, yielding the system\nPq D M\u00021p C \u000fq;\n(8.75)\nPp D F.q/ \u0003 \u000fp \u0003 \u0012p;\n(8.76)\nPV D \u000fV;\n(8.77)\nd\u0012 D ŒhT \u0003 \nT\u0012\t dt C\np\n2kBT\nT=\u0006TdWT;\n(8.78)\nd\u000f D ŒhP \u0003 \nP\u000f\t dt C\np\n2kBT\nP=\u0006PdWP;\n(8.79)\nwhere \nT; \nP \b 0 are two parameters governing the strength of the noise.\n8.8.2\nDiscretization of the NHL Piston\nObservations in Chap. 7 and our experience with the Nosé-Hoover-Langevinmethod\nlead us to propose splitting methods to separate the Ornstein-Uhlenbeck processes\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 403,
      "printed_page": 382,
      "text": "382\n8\nExtended Variable Methods\nIf \u0005 has the form \u0005 D exp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .q; p; V; \u0012/ then eliminate \u000f, reducing\nL\u0004\u0005 D 0 to\n\u0003rq \u0002 .q / C rp \u0002 .p / \u0003 @\n@V .V / C ˇ.V˘.q; p; V/ \u0003 PV C kBT/ D 0:\nThis results in\n\u0003 q \u0002 rq C p \u0002 rp \u0003 \u0003 V @ \n@V C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/ D 0:\n(8.74)\nA solution (the desired one) is given by\n / exp.\u0003ˇ.H C PV//;\nwhere substituting into (8.74) gives\nh\nˇq \u0002 rU.q/ \u0003 ˇp \u0002 M\u00021p \u0003 1 C ˇV @U\n@V\nCˇPV C .ˇV˘.q; p; V/ \u0003 ˇPV C 1/\ni\n D 0;\nwhich is quickly checked to be true, and hence the dynamics preserves \u0005 D\nexp.\u0003ˇ\u0006P\u000f2=2/ \u0004 .\nIt is difﬁcult to see how their could be other solutions , but we know from\nthe Nosé-Hoover case that this must be possible. We improve the robustness of\nthe method by introducing Ornstein-Uhlenbeck type stochastic processes in the two\nauxiliary variables \u0012 and \u000f, yielding the system\nPq D M\u00021p C \u000fq;\n(8.75)\nPp D F.q/ \u0003 \u000fp \u0003 \u0012p;\n(8.76)\nPV D \u000fV;\n(8.77)\nd\u0012 D ŒhT \u0003 \nT\u0012\t dt C\np\n2kBT\nT=\u0006TdWT;\n(8.78)\nd\u000f D ŒhP \u0003 \nP\u000f\t dt C\np\n2kBT\nP=\u0006PdWP;\n(8.79)\nwhere \nT; \nP \b 0 are two parameters governing the strength of the noise.\n8.8.2\nDiscretization of the NHL Piston\nObservations in Chap. 7 and our experience with the Nosé-Hoover-Langevinmethod\nlead us to propose splitting methods to separate the Ornstein-Uhlenbeck processes\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述正V内的真实Fokker–Planck微分表达式为零；候选正权重并不自动可积/归一。",
    "盒边界/体积边界的通量、Markov半群不变概率及唯一遍历性需要NPT理论，明确列缺口。"
  ],
  "issues": [],
  "statement_scope": "候选权重与实际局部前向算子的驻定目标。",
  "lean_decl": "MD.Ch08.pistonWeight",
  "lean_declarations": [
    "MD.Ch08.pistonWeight",
    "MD.Ch08.pistonForward",
    "MD.Ch08.pistonWeight_stationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def pistonWeight (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP : ℝ)
    (z : PistonState n) : ℝ :=
  Real.exp (-β*(kineticTwice invm z.1.2/2+U (z.1.1,z.2 0)+P*z.2 0+
    QT*(z.2 1)^2/2+QP*(z.2 2)^2/2))
def pistonForward (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP γT γP : ℝ)
    (ρ : PistonState n → ℝ) (z : PistonState n) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • pistonDrift invm U θ P QT QP γT γP x) z+
    (∑ j : Fin 2, fderiv ℝ (fun x ↦ fderiv ℝ ρ x (pistonNoise θ QT QP γT γP j))
      z (pistonNoise θ QT QP γT γP j))/2
theorem pistonWeight_stationary (invm : Vec n) (U : Vec n × ℝ → ℝ)
    (β P QT QP γT γP : ℝ) (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U)
    (hβ : 0 < β) (hQT : 0 < QT) (hQP : 0 < QP) (hγT : 0 ≤ γT) (hγP : 0 ≤ γP)
    (z : PistonState n) (hV : 0 < z.2 0) :
    pistonForward invm U β⁻¹ P QT QP γT γP (pistonWeight invm U β P QT QP) z=0 := by
  sorry
```

## MD-8.8.2-PistonIntegrator
```json
{
  "source_id": "MD-8.8.2-PistonIntegrator",
  "kind": "definition",
  "label": null,
  "section": "8.8.2",
  "printed_page": "383",
  "pdf_page": "404",
  "statement_latex": "The printed algorithm interleaves feedback half-updates, exponentially damped momentum kicks, exponential position/volume drifts, feedback recomputation and final independent OU steps. ψ(α,t)=(e^{αt}−1)/α, extended by t at α=0.",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n383\nand solve the latter exactly. It is not technically necessary to require symmetry of\nthe way that stochastic and deterministic terms are interleaved if the only purpose\nis equilibrium sampling, although symmetry is required within any splitting method\nused for the deterministic part in order to gain even order (in our case an O.h2/\nerror) in short time approximation and in the accuracy of computed thermodynamic\nquantities.\nIn the case of (8.75)–(8.79) this suggests\n\u0012 :D \u0012 C .\u0016t=2/hT;\n\u000f :D \u000f C .\u0016t=2/hP;\np :D e\u0002.\u0012C\u000f/\u0016t=2p C .\u0003\u0012 \u0003 \u000f; \u0016t=2/F.q/;\nq :D e\u000f\u0016tq C .\u000f; \u0016t/M\u00021p;\np :D e\u0002.\u0012C\u000f/\u0016t=2p C .\u0003\u0012 \u0003 \u000f; \u0016t=2/F.q/;\nV :D e\u000f\u0016tV;\nhT :D hT.p/;\nhP :D hP.q; p; V/;\n\u0012 :D \u0012 C .\u0016t=2/hT;\n\u000f :D \u000f C .\u0016t=2/hP;\n\u0012 :D e\u0002\nT\u0016t\u0012 C\np\nˇ\u00021.1 \u0003 e\u00022\nT\u0016t/=\u0006TR\u0012;\n\u000f :D e\u0002\nP\u0016t\u000f C\np\nˇ\u00021.1 \u0003 e\u00022\nP\u0016t/=\u0006PR\u000f;\nwhere\n .˛; t/\ndef\nD\n\f e˛t\u00021\n˛\n˛ ¤ 0\nt\n˛ D 0 ;\nand R\u0012, R\u000f are two scalar i.i.d. N.0; 1/ random numbers. Periodic boundary\nconditions are enforced whenever q or V is updated, to ensure that the system\nremains inside the cube with side length V1=3.\nWe perform an experiment with the given discretization for 64 atoms in a 3D\nperiodic box using a pairwise Lennard-Jones potential. We set P D 0:5, kBT D 0:1\nand \u0006P D \u0006T D 5, with all particle masses set to one and h D 0:001. As plotted in\nFig. 8.6, we initialize the particles in a cubic formation within a 5 \u0004 5 \u0004 5 periodic\nbox (so V.0/ D 125). As we run the simulation, V decreases and the pressure is\nincreased.\nWe set \nT D \nP D \n and compare simulations using three values of \n. Choosing\n\n D 0 removes any stochastic terms from the simulation, reducing the dynamics to\na similar form to the Nosé-Hoover thermostat. The distribution of the pressure ˘,\nplotted in Fig. 8.7 (centered on the target pressure P), is well sampled under all three\nchoices of the friction \n. However, as in the NVT experiment in Fig. 8.2, without\nany stochastic terms in the equations of motion the system exhibits a pronounced\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 404,
      "printed_page": 383,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n383\nand solve the latter exactly. It is not technically necessary to require symmetry of\nthe way that stochastic and deterministic terms are interleaved if the only purpose\nis equilibrium sampling, although symmetry is required within any splitting method\nused for the deterministic part in order to gain even order (in our case an O.h2/\nerror) in short time approximation and in the accuracy of computed thermodynamic\nquantities.\nIn the case of (8.75)–(8.79) this suggests\n\u0012 :D \u0012 C .\u0016t=2/hT;\n\u000f :D \u000f C .\u0016t=2/hP;\np :D e\u0002.\u0012C\u000f/\u0016t=2p C .\u0003\u0012 \u0003 \u000f; \u0016t=2/F.q/;\nq :D e\u000f\u0016tq C .\u000f; \u0016t/M\u00021p;\np :D e\u0002.\u0012C\u000f/\u0016t=2p C .\u0003\u0012 \u0003 \u000f; \u0016t=2/F.q/;\nV :D e\u000f\u0016tV;\nhT :D hT.p/;\nhP :D hP.q; p; V/;\n\u0012 :D \u0012 C .\u0016t=2/hT;\n\u000f :D \u000f C .\u0016t=2/hP;\n\u0012 :D e\u0002\nT\u0016t\u0012 C\np\nˇ\u00021.1 \u0003 e\u00022\nT\u0016t/=\u0006TR\u0012;\n\u000f :D e\u0002\nP\u0016t\u000f C\np\nˇ\u00021.1 \u0003 e\u00022\nP\u0016t/=\u0006PR\u000f;\nwhere\n .˛; t/\ndef\nD\n\f e˛t\u00021\n˛\n˛ ¤ 0\nt\n˛ D 0 ;\nand R\u0012, R\u000f are two scalar i.i.d. N.0; 1/ random numbers. Periodic boundary\nconditions are enforced whenever q or V is updated, to ensure that the system\nremains inside the cube with side length V1=3.\nWe perform an experiment with the given discretization for 64 atoms in a 3D\nperiodic box using a pairwise Lennard-Jones potential. We set P D 0:5, kBT D 0:1\nand \u0006P D \u0006T D 5, with all particle masses set to one and h D 0:001. As plotted in\nFig. 8.6, we initialize the particles in a cubic formation within a 5 \u0004 5 \u0004 5 periodic\nbox (so V.0/ D 125). As we run the simulation, V decreases and the pressure is\nincreased.\nWe set \nT D \nP D \n and compare simulations using three values of \n. Choosing\n\n D 0 removes any stochastic terms from the simulation, reducing the dynamics to\na similar form to the Nosé-Hoover thermostat. The distribution of the pressure ˘,\nplotted in Fig. 8.7 (centered on the target pressure P), is well sampled under all three\nchoices of the friction \n. However, as in the NVT experiment in Fig. 8.2, without\nany stochastic terms in the equations of motion the system exhibits a pronounced\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "正β、QT、QP、质量、体积及h≥0是物理有效域；R取独立标准二维正态且跨步独立，参照independentWiener/standardNormalSequence所列资格。",
    "零指数分支按原页连续延拓；周期位置在每次q/V更新后按当前盒长映射。只定义完整算法，不证明二阶、可逆或不变分布精度。"
  ],
  "issues": [],
  "statement_scope": "完整分步算法、周期映射及OU保持V和指数体积正性的短结论。",
  "lean_decl": "MD.Ch08.expIntegrated",
  "lean_declarations": [
    "MD.Ch08.expIntegrated",
    "MD.Ch08.pistonWrap",
    "MD.Ch08.pistonMomentumKick",
    "MD.Ch08.pistonFeedback",
    "MD.Ch08.pistonOU",
    "MD.Ch08.pistonIntegrator",
    "MD.Ch08.pistonOU_volume",
    "MD.Ch08.pistonVolume_positive"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def expIntegrated (a t : ℝ) : ℝ := if a=0 then t else (Real.exp (a*t)-1)/a
def pistonWrap (V : ℝ) (q : Vec n) : Vec n := fun i ↦
  volumeScale V*(q i/volumeScale V+1/2-(Int.floor (q i/volumeScale V+1/2) : ℝ)-1/2)
def pistonMomentumKick (U : Vec n × ℝ → ℝ) (h : ℝ) (z : PistonState n) : PistonState n :=
  ((z.1.1,fun i ↦ Real.exp (-(z.2 1+z.2 2)*h)*z.1.2 i-
    expIntegrated (-(z.2 1+z.2 2)) h*gradient (fun q ↦ U (q,z.2 0)) z.1.1 i),z.2)
def pistonFeedback (invm : Vec n) (U : Vec n × ℝ → ℝ) (θ P QT QP h : ℝ)
    (z : PistonState n) : PistonState n :=
  let f := pistonDrift invm U θ P QT QP 0 0 z
  (z.1,![z.2 0,z.2 1+h*f.2 1,z.2 2+h*f.2 2])
def pistonOU (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) : PistonState n :=
  (z.1,![z.2 0,Real.exp (-γT*h)*z.2 1+Real.sqrt ((1-Real.exp (-2*γT*h))/(β*QT))*R 0,
    Real.exp (-γP*h)*z.2 2+Real.sqrt ((1-Real.exp (-2*γP*h))/(β*QP))*R 1])
def pistonIntegrator (invm : Vec n) (U : Vec n × ℝ → ℝ) (β P QT QP γT γP h : ℝ)
    (R : Vec 2) (z : PistonState n) : PistonState n :=
  let a := pistonFeedback invm U β⁻¹ P QT QP (h/2) z
  let b := pistonMomentumKick U (h/2) a
  let q := pistonWrap (b.2 0) (fun i ↦ Real.exp (b.2 2*h)*b.1.1 i+
    expIntegrated (b.2 2) h*invm i*b.1.2 i)
  let c := pistonMomentumKick U (h/2) ((q,b.1.2),b.2)
  let V := Real.exp (c.2 2*h)*c.2 0
  let d : PistonState n := ((pistonWrap V c.1.1,c.1.2),![V,c.2 1,c.2 2])
  pistonOU β QT QP γT γP h R (pistonFeedback invm U β⁻¹ P QT QP (h/2) d)
theorem pistonOU_volume (β QT QP γT γP h : ℝ) (R : Vec 2) (z : PistonState n) :
    (pistonOU β QT QP γT γP h R z).2 0=z.2 0 := rfl
theorem pistonVolume_positive (V η h : ℝ) (hV : 0 < V) : 0 < Real.exp (η*h)*V :=
  mul_pos (Real.exp_pos _) hV
```

## MD-8.8.3-ParrinelloRahman
```json
{
  "source_id": "MD-8.8.3-ParrinelloRahman",
  "kind": "definition",
  "label": null,
  "section": "8.8.3",
  "printed_page": "385",
  "pdf_page": "406",
  "statement_latex": "For cell matrix h=[a b c], V=det(h)=a·(b×c), qᵢ=hq̄ᵢ, G=hᵀh, L=(1/2)Σmᵢq̄̇ᵢᵀGq̄̇ᵢ−Ū(q̄)+(μ/2)Tr(ḣᵀḣ)−PV.",
  "statement_verbatim": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n385\n“breathing” mode. We would expect these ﬂuctuations to be especially long-lived in\nthe case of large values of \u0006. Decreasing the values of \u0006 will increase the frequency\nof the oscillations; if the frequency of the periodic motion is too high then the overall\nstability of the simulation will become threatened (a smaller timestep h may be\nrequired).\nChoosing \n D 0:1 or \n D 1 removes this artiﬁcial oscillatory behavior, with\nthe larger choice of \n giving faster dissipation of the periodic oscillation. Figure 8.7\ndemonstrates that when setting \n D 1 the temperature and volume rapidly stabilize\nand give small, random ﬂuctuations compared to the non-stochastic case. For some\nalternatives and more in-depth discussion of constant temperature and pressure\nstrategies, including numerical experiments, refer to [128, 194, 199, 238, 252].\n8.8.3\nAnisotropic Simulation Cell: The Method\nof Parrinello and Rahman\nNot all molecules are naturally simulated in a cubic unit cell and indeed the system\nmay undergo dramatic changes of shape during simulation. Parrinello and Rahman\n[296] explained how to extend the method of Andersen to allow for a system\nconﬁned to a cell with dimensions that are allowed to vary during simulation. Three\nvectors a, b and c deﬁne the sides of the simulation cell. Let h be the 3 \u0004 3 matrix\nwith these vectors as columns, then its volume is V D det.h/ D a \u0002 .b \u0004 c/, where\na, b, c and h are viewed as time-dependent variables.\nAny position vector may be decomposed into coordinates deﬁned by the matrix\nh, thus\nqi D hNqi D \u0012ia C \u000fib C \u0018ic;\n0 \t \u0012i; \u000fi; \u0018i \t 1:\nIntroducing the metric tensor G D hTh, the Lagrangian describing the system then\nbecomes\nL D 1\n2\nN\nX\niD1\nmiPNqT\ni GPNqi \u0003 NU.Nq/ C 1\n2\u0006Tr.Ph\nT Ph/ \u0003 PV;\nwhere \u0006 is an artiﬁcial “mass” parameter which can be adjusted to alter the tightness\nof the coupling of the barostat to the physical variables.\nThis system can then be coupled to a thermostat as in the Andersen or Hoover\nformulation [266].\nThe method works well as long as there are internal molecular structures that\nprevent a degeneracy (one cell dimension collapsing) as might happen, for example,\nif the scheme were applied to a simple liquid such as Lennard-Jonesium.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 406,
      "printed_page": 385,
      "text": "8.8\nConstant Temperature and Pressure Molecular Dynamics\n385\n“breathing” mode. We would expect these ﬂuctuations to be especially long-lived in\nthe case of large values of \u0006. Decreasing the values of \u0006 will increase the frequency\nof the oscillations; if the frequency of the periodic motion is too high then the overall\nstability of the simulation will become threatened (a smaller timestep h may be\nrequired).\nChoosing \n D 0:1 or \n D 1 removes this artiﬁcial oscillatory behavior, with\nthe larger choice of \n giving faster dissipation of the periodic oscillation. Figure 8.7\ndemonstrates that when setting \n D 1 the temperature and volume rapidly stabilize\nand give small, random ﬂuctuations compared to the non-stochastic case. For some\nalternatives and more in-depth discussion of constant temperature and pressure\nstrategies, including numerical experiments, refer to [128, 194, 199, 238, 252].\n8.8.3\nAnisotropic Simulation Cell: The Method\nof Parrinello and Rahman\nNot all molecules are naturally simulated in a cubic unit cell and indeed the system\nmay undergo dramatic changes of shape during simulation. Parrinello and Rahman\n[296] explained how to extend the method of Andersen to allow for a system\nconﬁned to a cell with dimensions that are allowed to vary during simulation. Three\nvectors a, b and c deﬁne the sides of the simulation cell. Let h be the 3 \u0004 3 matrix\nwith these vectors as columns, then its volume is V D det.h/ D a \u0002 .b \u0004 c/, where\na, b, c and h are viewed as time-dependent variables.\nAny position vector may be decomposed into coordinates deﬁned by the matrix\nh, thus\nqi D hNqi D \u0012ia C \u000fib C \u0018ic;\n0 \t \u0012i; \u000fi; \u0018i \t 1:\nIntroducing the metric tensor G D hTh, the Lagrangian describing the system then\nbecomes\nL D 1\n2\nN\nX\niD1\nmiPNqT\ni GPNqi \u0003 NU.Nq/ C 1\n2\u0006Tr.Ph\nT Ph/ \u0003 PV;\nwhere \u0006 is an artiﬁcial “mass” parameter which can be adjusted to alter the tightness\nof the coupling of the barostat to the physical variables.\nThis system can then be coupled to a thermostat as in the Andersen or Hoover\nformulation [266].\nThe method works well as long as there are internal molecular structures that\nprevent a degeneracy (one cell dimension collapsing) as might happen, for example,\nif the scheme were applied to a simple liquid such as Lennard-Jonesium.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "选定正定向非退化盒det(h)>0及正质量；U为缩放坐标势，必要时由实际h映射后势复合而得。",
    "拉氏方程、与热浴耦合和防止盒塌缩均未在原页给完整条件，列覆盖缺口，不把内部结构的经验稳定性当定理。"
  ],
  "issues": [],
  "statement_scope": "各向异性盒的体积/位置/度量/Lagrangian及标量三重积恒等式。",
  "lean_decl": "MD.Ch08.cellVolume",
  "lean_declarations": [
    "MD.Ch08.cellVolume",
    "MD.Ch08.cellMetric",
    "MD.Ch08.cellPosition",
    "MD.Ch08.cross3",
    "MD.Ch08.cellVolume_triple",
    "MD.Ch08.parrinelloRahmanLagrangian",
    "MD.Ch08.cellQualification"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def cellVolume (h : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := Matrix.det h
def cellMetric (h : Matrix (Fin 3) (Fin 3) ℝ) : Matrix (Fin 3) (Fin 3) ℝ := h.transpose*h
def cellPosition (h : Matrix (Fin 3) (Fin 3) ℝ) (qbar : Vec 3) : Vec 3 := h *ᵥ qbar
def cross3 (a b : Vec 3) : Vec 3 := ![a 1*b 2-a 2*b 1,a 2*b 0-a 0*b 2,a 0*b 1-a 1*b 0]
theorem cellVolume_triple (h : Matrix (Fin 3) (Fin 3) ℝ) :
    cellVolume h=dot (fun i ↦ h i 0) (cross3 (fun i ↦ h i 1) (fun i ↦ h i 2)) := by
  simp [cellVolume,Matrix.det_fin_three,dot,Fin.sum_univ_succ,cross3]
  ring
def parrinelloRahmanLagrangian {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → Vec 3) → ℝ)
    (Q P : ℝ) (h hdot : Matrix (Fin 3) (Fin 3) ℝ) (qbar vbar : Fin N → Vec 3) : ℝ :=
  (∑ i, m i/2*dot (vbar i) (cellMetric h *ᵥ vbar i))-U qbar+
    Q/2*Matrix.trace (hdot.transpose*hdot)-P*cellVolume h
def cellQualification {N : ℕ} (m : Fin N → ℝ) (Q : ℝ)
    (h : Matrix (Fin 3) (Fin 3) ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < Q ∧ 0 < Matrix.det h
```

## MD-8.9-TotalMomentum
```json
{
  "source_id": "MD-8.9-TotalMomentum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.9",
  "printed_page": "386",
  "pdf_page": "407",
  "statement_latex": "With central conservative forces ΣᵢFᵢ=0, Nosé dynamics gives d p_tot/dt=−ξ p_tot. Zero total momentum is formally invariant.",
  "statement_verbatim": "386\n8\nExtended Variable Methods\n8.9\nMomentum-Conserving Thermostats and the Dissipative\nParticle Dynamics (DPD) Method\nIn many applications, it is important to preserve the total momentum while\ncalculating canonical thermodynamic averages, i.e. one works in an ensemble that\nis restricted by the additional momentum constraint. Momentum conservation plays\na key role in capturing long-ranged hydrodynamic interactions in coarse-grained\nmodels of complex ﬂuids [8]. Standard Langevin and Nosé dynamics methods fail\nto preserve the momentum. This is quite obvious in the case of Langevin dynamics.\nIn Nosé dynamics we have the following differential equation for the momenta:\ndp\ndt D \u0003rU.q/ \u0003 \u0012p:\nAssuming central forces, we have PN\niD1 rqiU D 0, thus we obtain the following\nequation for the total momentum vector ptot:\nN\nX\niD1\ndpi\ndt D dptot\ndt\nD \u0003\u0012ptot:\nIf the total momentum is chosen to be zero, then it will formally remain zero\nalong trajectories (see [78, 254] for a discussion on the affect this has on canonical\nsampling). However, in practice, a small numerical artifact may be introduced.\nMoreover, under numerical discretization, bias due to ﬁnite stepsize may be present\nallowing a build up of total momentum in long simulations.\nAn interesting potential consequence of the lack of momentum conservation is\nthe so-called “ﬂying ice cube” problem [172], whereby the system acquires a large\ntotal momentum but the internal momenta due to interactions among the particles\nbecomes small.\nIt is desirable to construct formulations and numerical methods which exactly\n(i.e. up to rounding error) preserve the total momentum from step to step. One\nobvious approach to this problem is to simply project the momenta onto the linear\nmomentum constraint at the end of each step (or after some number of steps).\nSuch a projection introduces potential issues in terms of convergence order and\nwould certainly complicate the analyses presented thus far in this book. Moreover,\nthe optimal choice of projection is unclear and it is easy to deﬁne poor schemes\n(for example, modifying always the momentum of just the ﬁrst particle in order\nto balance all the remaining components) which are likely to introduce artifacts\n(bias) in simulation. For this reason, there is interest in “building in” momentum\nconservation into the equations of motion (and indeed the integrator). Ideally this\nshould be done in a localized and homogeneous way so that momentum is not\ntransferred by a nonphysical mechanism between distant particles.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 407,
      "printed_page": 386,
      "text": "386\n8\nExtended Variable Methods\n8.9\nMomentum-Conserving Thermostats and the Dissipative\nParticle Dynamics (DPD) Method\nIn many applications, it is important to preserve the total momentum while\ncalculating canonical thermodynamic averages, i.e. one works in an ensemble that\nis restricted by the additional momentum constraint. Momentum conservation plays\na key role in capturing long-ranged hydrodynamic interactions in coarse-grained\nmodels of complex ﬂuids [8]. Standard Langevin and Nosé dynamics methods fail\nto preserve the momentum. This is quite obvious in the case of Langevin dynamics.\nIn Nosé dynamics we have the following differential equation for the momenta:\ndp\ndt D \u0003rU.q/ \u0003 \u0012p:\nAssuming central forces, we have PN\niD1 rqiU D 0, thus we obtain the following\nequation for the total momentum vector ptot:\nN\nX\niD1\ndpi\ndt D dptot\ndt\nD \u0003\u0012ptot:\nIf the total momentum is chosen to be zero, then it will formally remain zero\nalong trajectories (see [78, 254] for a discussion on the affect this has on canonical\nsampling). However, in practice, a small numerical artifact may be introduced.\nMoreover, under numerical discretization, bias due to ﬁnite stepsize may be present\nallowing a build up of total momentum in long simulations.\nAn interesting potential consequence of the lack of momentum conservation is\nthe so-called “ﬂying ice cube” problem [172], whereby the system acquires a large\ntotal momentum but the internal momenta due to interactions among the particles\nbecomes small.\nIt is desirable to construct formulations and numerical methods which exactly\n(i.e. up to rounding error) preserve the total momentum from step to step. One\nobvious approach to this problem is to simply project the momenta onto the linear\nmomentum constraint at the end of each step (or after some number of steps).\nSuch a projection introduces potential issues in terms of convergence order and\nwould certainly complicate the analyses presented thus far in this book. Moreover,\nthe optimal choice of projection is unclear and it is easy to deﬁne poor schemes\n(for example, modifying always the momentum of just the ﬁrst particle in order\nto balance all the remaining components) which are likely to introduce artifacts\n(bias) in simulation. For this reason, there is interest in “building in” momentum\nconservation into the equations of motion (and indeed the integrator). Ideally this\nshould be done in a localized and homogeneous way so that momentum is not\ntransferred by a nonphysical mechanism between distant particles.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只证明瞬时总力恒等式；沿连续轨道的零动量不变需要ODE唯一性，有限精度“飞冰块”属经验现象，列缺口。"
  ],
  "issues": [],
  "statement_scope": "总动量定义和Nosé瞬时总力/零总动量时总力为零。",
  "lean_decl": "MD.Ch08.ParticleConfig",
  "lean_declarations": [
    "MD.Ch08.ParticleConfig",
    "MD.Ch08.ParticlePhase",
    "MD.Ch08.totalMomentum",
    "MD.Ch08.noseTotalForce",
    "MD.Ch08.noseTotalForce_zero"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev ParticleConfig (N d : ℕ) := Fin N → Vec d
abbrev ParticlePhase (N d : ℕ) := ParticleConfig N d × ParticleConfig N d
def totalMomentum {N d : ℕ} (p : ParticleConfig N d) : Vec d := ∑ i, p i
theorem noseTotalForce {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) :
    totalMomentum (fun i ↦ F i-ξ • p i) = -ξ • totalMomentum p := by
  simp only [totalMomentum,Finset.sum_sub_distrib,← Finset.smul_sum] at *
  rw [hF]; simp
theorem noseTotalForce_zero {N d : ℕ} (F p : ParticleConfig N d) (ξ : ℝ)
    (hF : totalMomentum F=0) (hp : totalMomentum p=0) :
    totalMomentum (fun i ↦ F i-ξ • p i)=0 := by rw [noseTotalForce F p ξ hF,hp,smul_zero]
```
