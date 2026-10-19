# EAUDIT02 第8章修改后陈述复审

## MD-8.4.1-NHL
```json
{
  "source_id": "MD-8.4.1-NHL",
  "kind": "definition",
  "label": null,
  "section": "8.4.1",
  "printed_page": "345–346",
  "pdf_page": "366–367",
  "statement_latex": "dq=M⁻¹pdt, dp=-∇Udt-ξpdt, dξ=μ⁻¹[pᵀM⁻¹p-N_dk_BT]dt-γξdt+√(2k_BTγμ⁻¹)dW. Quadratic specialization: U=qᵀAq/2, M=I.",
  "statement_verbatim": "8.4\nErgodic Stochastic-Dynamic Thermostats\n345\nThis means that we have built one of our two vectors. The second follows as a linear\ncombination of the others:\nQF D b0 \u0003 \u0012 QG \u0003 .g \u0003 \n\u0012/\u0007\u00021b1:\nut\nThe fact that the Hörmander condition holds is, as we know from Chap. 6, only\npart of the story. However based on known results for Langevin dynamics, we\nconjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U\nis sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.\nperiodic boundary conditions are employed. However we stress that each possible\nmethod will ultimately need to be carefully and systematically checked to verify the\nergodic properties.\n8.4.1\nNosé-Hoover-Langevin: An Ergodic Weakly Coupled\nThermostat\nThe Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the\n“chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian\ndistribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The\nmethod was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the\nconﬁrmation of the Hörmander condition), for a problem with harmonic internal\ninteractions, was given in [226] and we roughly follow the treatment from this paper.\nThe Nosé-Hoover-Langevin equations are\ndq D M\u00021pdt;\n(8.27)\ndp D \u0003rU.q/dt \u0003 \u0012pdt;\n(8.28)\nd\u0012 D \u0006\u00021ŒpTM\u00021p \u0003 NdkBT\tdt \u0003 \n\u0012dt C\np\n2kBT\n\u0006\u00021dW;\n(8.29)\nwhere .q; p/ 2 D with \u0012 2 R. Let us emphasize that the principal features of this\nthermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates\na single Wiener process, (3) it has two free parameters \n and \u0006.\nLet us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a\nthermostat. We observe that we have already shown that the Nosé-Hoover method\npreserves the extended canonical distribution \u0005ˇ exp.\u0003ˇ\u0006\u00122=2/. Therefore, by the\nadditivity property, all that is needed is to show that the additional part\nd\u0012 D \u0003\n\u0012dt C\np\n2kBT\n\u0006\u00021dW\n\n346\n8\nExtended Variable Methods\npreserves O\u0005.\u0012/ D exp.\u0003ˇ\u0006\u00122=2/. However, this is obvious from our earlier\ninvestigations of Ornstein-Uhlenbeck equations.\nIn order to show that this thermostat is ergodic, we need to demonstrate that\nthe assumptions presented in Sect. 6.4.4 are valid. Assumption 1(ii) requires us to\nverify that a Hörmander condition (see Deﬁnition 6.1) holds for the Nosé-Hoover-\nLangevin system. Because of the complexity of the high order commutators, we\nwill work here with the assumption of a quadratic potential in the physical model.\nIn some sense this is the most difﬁcult case for a thermostat, but paradoxically, the\nassumption facilitates the mathematical analysis. We will assume throughout the\nfollowing that Nd D Nc, i.e. that there are no constraints in the system. Our potential\nwill therefore be assumed to be\nU.q/ D 1\n2qTAq;\nfor A a symmetric, positive deﬁnite Nc \u0004 Nc matrix, with\nrU.q/ D Aq:\nWe will further assume M D I. If this is not the case, then one may introduce the\nrescaling Qq D M\u00021=2q; Qp D M1=2p in order to rewrite the system in a form that does\nnot involve M. Thus the system under study is\ndq D pdt;\n(8.30)\ndp D \u0003Aqdt \u0003 \u0012pdt;\n(8.31)\nd\u0012 D \u0006\u00021Œkpk2 \u0003 NdkBT\tdt \u0003 \n\u0012dt C \u0007dW:\n(8.32)\nLet u1; u2; : : : ; uNc be the eigenvectors of A with \u00131; : : : ; \u0013Nc the corresponding\neigenvalues. Observe that if q0 \u0002uk D p0 \u0002uk D 0, then, using (8.30)–(8.31), we have\nat this point\nuk \u0002 p D 0;\nuk \u0002 Œ\u0003Aq \u0003 \u0012p\t D \u0003\u0013kuk \u0002 q D 0;\nwhich implies that Vk D f.q; p/juk \u0002 q D 0; uk \u0002 p D 0g is an invariant submanifold.\nTherefore we must require that uk \u0002 q and uk \u0002 p do not simultaneously vanish, that\nis, .q; p/ 2 D D R2Nc n SNc\nkD1 Vk.\nTheorem 8.1 If A is symmetric positive deﬁnite and has distinct eigenvalues, then\n(8.30)–(8.32) satisﬁes the Hörmander condition on D \u0004 R.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 366,
      "printed_page": 345,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n345\nThis means that we have built one of our two vectors. The second follows as a linear\ncombination of the others:\nQF D b0 \u0003 \u0012 QG \u0003 .g \u0003 \n\u0012/\u0007\u00021b1:\nut\nThe fact that the Hörmander condition holds is, as we know from Chap. 6, only\npart of the story. However based on known results for Langevin dynamics, we\nconjecture that ergodicity will hold if (i) the Hörmander condition holds, (ii) U\nis sufﬁciently smooth, and (iii) the conﬁgurational phase space is compact, e.g.\nperiodic boundary conditions are employed. However we stress that each possible\nmethod will ultimately need to be carefully and systematically checked to verify the\nergodic properties.\n8.4.1\nNosé-Hoover-Langevin: An Ergodic Weakly Coupled\nThermostat\nThe Nosé-Hoover-Langevin (NHL) method is based on a simple idea: replace the\n“chain” in the Nosé-Hoover Chain, whose sole purpose is to maintain a Gaussian\ndistribution in the auxiliary variable, by a stochastic Langevin-type thermostat. The\nmethod was ﬁrst proposed in [323]. The proof of ergodicity (more precisely the\nconﬁrmation of the Hörmander condition), for a problem with harmonic internal\ninteractions, was given in [226] and we roughly follow the treatment from this paper.\nThe Nosé-Hoover-Langevin equations are\ndq D M\u00021pdt;\n(8.27)\ndp D \u0003rU.q/dt \u0003 \u0012pdt;\n(8.28)\nd\u0012 D \u0006\u00021ŒpTM\u00021p \u0003 NdkBT\tdt \u0003 \n\u0012dt C\np\n2kBT\n\u0006\u00021dW;\n(8.29)\nwhere .q; p/ 2 D with \u0012 2 R. Let us emphasize that the principal features of this\nthermostat: (1) it is essentially Nosé-Hoover plus a perturbation, (2) it incorporates\na single Wiener process, (3) it has two free parameters \n and \u0006.\nLet us ﬁrst demonstrate that the Nosé-Hoover-Langevin method, is, in fact, a\nthermostat. We observe that we have already shown that the Nosé-Hoover method\npreserves the extended canonical distribution \u0005ˇ exp.\u0003ˇ\u0006\u00122=2/. Therefore, by the\nadditivity property, all that is needed is to show that the additional part\nd\u0012 D \u0003\n\u0012dt C\np\n2kBT\n\u0006\u00021dW\n"
    },
    {
      "pdf_page": 367,
      "printed_page": 346,
      "text": "346\n8\nExtended Variable Methods\npreserves O\u0005.\u0012/ D exp.\u0003ˇ\u0006\u00122=2/. However, this is obvious from our earlier\ninvestigations of Ornstein-Uhlenbeck equations.\nIn order to show that this thermostat is ergodic, we need to demonstrate that\nthe assumptions presented in Sect. 6.4.4 are valid. Assumption 1(ii) requires us to\nverify that a Hörmander condition (see Deﬁnition 6.1) holds for the Nosé-Hoover-\nLangevin system. Because of the complexity of the high order commutators, we\nwill work here with the assumption of a quadratic potential in the physical model.\nIn some sense this is the most difﬁcult case for a thermostat, but paradoxically, the\nassumption facilitates the mathematical analysis. We will assume throughout the\nfollowing that Nd D Nc, i.e. that there are no constraints in the system. Our potential\nwill therefore be assumed to be\nU.q/ D 1\n2qTAq;\nfor A a symmetric, positive deﬁnite Nc \u0004 Nc matrix, with\nrU.q/ D Aq:\nWe will further assume M D I. If this is not the case, then one may introduce the\nrescaling Qq D M\u00021=2q; Qp D M1=2p in order to rewrite the system in a form that does\nnot involve M. Thus the system under study is\ndq D pdt;\n(8.30)\ndp D \u0003Aqdt \u0003 \u0012pdt;\n(8.31)\nd\u0012 D \u0006\u00021Œkpk2 \u0003 NdkBT\tdt \u0003 \n\u0012dt C \u0007dW:\n(8.32)\nLet u1; u2; : : : ; uNc be the eigenvectors of A with \u00131; : : : ; \u0013Nc the corresponding\neigenvalues. Observe that if q0 \u0002uk D p0 \u0002uk D 0, then, using (8.30)–(8.31), we have\nat this point\nuk \u0002 p D 0;\nuk \u0002 Œ\u0003Aq \u0003 \u0012p\t D \u0003\u0013kuk \u0002 q D 0;\nwhich implies that Vk D f.q; p/juk \u0002 q D 0; uk \u0002 p D 0g is an invariant submanifold.\nTherefore we must require that uk \u0002 q and uk \u0002 p do not simultaneously vanish, that\nis, .q; p/ 2 D D R2Nc n SNc\nkD1 Vk.\nTheorem 8.1 If A is symmetric positive deﬁnite and has distinct eigenvalues, then\n(8.30)–(8.32) satisﬁes the Hörmander condition on D \u0004 R.\n"
    }
  ],
  "numbered_equations": [
    "8.27",
    "8.28",
    "8.29",
    "8.30",
    "8.31",
    "8.32"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Q>0、β>0、γ>0及单独立Wiener；二次系统A对称正定、M=I；高维无约束自由度n。",
    "[EXTRA/覆盖缺口] invm_i,β,Q,γ均正；不宣称覆盖一般M或已把isNHLSolution特化到正定二次势(8.30)–(8.32)。原印重缩放疑误另列。",
    "[EXTRA]M⁻¹=diag(invm)，N_d=n；一般非对角M未覆盖。harmonicPotential本身未要求A对称正定，相关物理资格在应用时另加。"
  ],
  "issues": [
    "已目视核对原页PDF367：原印q̃=M⁻¹ᐟ²q、p̃=M¹ᐟ²p不产生单位质量方程；正确方向相反并须同步变换势。",
    "[ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。"
  ],
  "statement_scope": "仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。",
  "lean_decl": "MD.Ch08.nhlDrift",
  "lean_declarations": [
    "MD.Ch08.nhlDrift",
    "MD.Ch08.isNHLSolution",
    "MD.Ch08.harmonicPotential"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 31,
      "website_verdict": "FAIL",
      "suggested_fix": "将JSON范围限制为现有正对角质量、无约束模型，并明确尚无二次专门化声明；若要宣称全模型，需一般矩阵质量及参数关联。原书重缩放保留[ERRATUM?]，可另陈列正确变换q̃=M^{1/2}q,p̃=M^{-1/2}p及变换后的势；不改原文。本次不修改工程。",
      "change": "[EXTRA/覆盖缺口] invm_i,β,Q,γ均正；不宣称覆盖一般M或已把isNHLSolution特化到正定二次势(8.30)–(8.32)。原印重缩放疑误另列。"
    },
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "NEEDS_HUMAN",
      "issue_codes": [
        "EXTRA_DIAGONAL_MASS_SCOPE",
        "ERRATUM_MASS_RESCALING"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "仅正对角质量、无约束Nd=n的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。",
    "[EXTRA]M⁻¹=diag(invm)，N_d=n；一般非对角M未覆盖。harmonicPotential本身未要求A对称正定，相关物理资格在应用时另加。"
  ]
}
```
```lean
def nhlDrift (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (nhField invm U β Q z).1 |> fun physical ↦ (physical, (nhField invm U β Q z).2-γ*z.2)
def isNHLSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Phase n × ℝ)
    (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧
    additiveSDE P 1 W X x0 (nhlDrift invm U β Q γ)
      (fun _ ↦ (0, Real.sqrt (2*γ/(β*Q))))
def harmonicPotential (A : Matrix (Fin n) (Fin n) ℝ) (q : Vec n) : ℝ := dot q (A *ᵥ q)/2
```

## MD-8.4.3-PreEquilibriumMeans
```json
{
  "source_id": "MD-8.4.3-PreEquilibriumMeans",
  "kind": "definition",
  "label": null,
  "section": "8.4.3",
  "printed_page": "354–355",
  "pdf_page": "375–376",
  "statement_latex": "θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.",
  "statement_verbatim": "354\n8\nExtended Variable Methods\n0\nTime\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\n0\nTime\nVelocity auto-correlation\n0\n0.02\n0.04\n0.06\n0.08\n0.10\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\nNosé-Hoover & Nosé-Hoover-Langevin\nLangevin\nFig. 8.4 The computed velocity auto-correlation functions are plotted for Nosé-Hoover and Nosé-\nHoover-Langevin dynamics (left), where we overlay plots from simulations using all possible\nparameter sets where \n 2 f0; 0:05; 0:5; 5; 50g and \u0006 2 f20; 2; 0:2; 0:02g. We additionally plot the\nsame result for Langevin dynamics (right), overlaying curves for \n 2 f0:05; 0:1; 0:2; : : : ; 51:2g,\nwhere high to low friction is plotted from red to blue respectively. The salient qualitative features\nof the results remain qualitatively unchanged when using different values of the parameters for the\nNosé-Hoover thermostats (see inset) whereas the Langevin thermostat has a much harsher effect\non the dynamics, with signiﬁcant differences as the friction is increased\nIt may seem that the difference between Nosé-Hoover-Langevin and Langevin\ndynamics is a technical one that essentially hinges on choice of parameters. Both\nmethods are ergodic and it may appear that by simply choosing a small value\nof friction in Langevin dynamics, we can match the behavior of Nosé-Hoover-\nLangevin to any desired accuracy. However, this is most deﬁnitely not the case, as a\ncareful analysis of Figs. 8.3 and 8.4 reveals. If an accurate velocity autocorrelation\nfunction is required, then the friction parameter in Langevin dynamics needs to be\nchosen very small (much less than \n D 0:1), see Fig. 8.4. But if the friction is\nchosen in this way, the convergence to canonical equilibrium is drastically impaired\n(Figs. 8.2 and 8.3). By contrast it is relatively easy to ﬁnd parameter choices\nfor Nosé-Hoover-Langevin which provide quite rapid convergence of canonical\naverages while preserving the accuracy of autocorrelation functions.\nThe convergence to equilibrium for Nosé-Hoover-Langevin is difﬁcult to cal-\nculate analytically. The only existing analysis is that of [225] which restricts\nconsideration to the convergence of the kinetic energy. It turns out that one may\nobtain a nonlinear system in terms of the following two variables:\nN\u000e.t/ D\nZ\nD\u0003R\n2K\u0005.q; p; \u0012; t/d!d\u0012;\n\n8.4\nErgodic Stochastic-Dynamic Thermostats\n355\nwhere K is the kinetic energy, and the mean auxiliary variable \u0012\nN\u0012.t/ D\nZ\nD\u0003R\n\u0012\u0005.q; p; \u0012; t/d!d\u0012:\n\u0005 that appears here is the normalized pre-equilibrium density which evolves\naccording to the Fokker-Planck equation of the extended Nosé-Hoover-Langevin\nsystem.\nIt is then possible to perform a local stability analysis to characterize the\nconvergence to equilibrium of N\u000e and N\u0012 to the equilibrium .NdkBT; 0/. Although\nthe analysis makes certain stringent assumptions they are veriﬁed in [225] for a\nLennard-Jones molecular system.\n8.4.4\nVelocity Rescaling\nAn alternative stochastic-dynamical method for thermostatting molecular dynamics\nis the stochastic velocity rescaling method proposed by Bussi and collaborators [60,\n63] and somewhat generalized in [225]. The equations are (for the case M D I,\nconsidered for simplicity):\ndq D pdt\ndp D \u0003rU.q/ dt \u0003 \f.K/p dt C\np\n2kBT˚.K/pdW;\nwhere W.t/ is a single Wiener process, ˚ is an arbitrary smooth positive function\nand \f is deﬁned by\n\f.K/\ndef\nD .2K \u0003 .1 C Nd/kBT/˚.K/ \u0003 2kBTK d˚\ndK :\nWith these deﬁnitions, the method preserves the canonical probability density \u0005ˇ.\nWe do not prove the ergodicity of the method here, but expect that it would follow\nby an analysis similar to that given above for Nosé-Hoover-Langevin.\nThe original proposal of Bussi et al. had\n˚.K/ D \nVR\n2K ;\nso that\n\f.K/ D .1 \u0003 .Nd \u0003 1/kBT=2K/ \nVR;\nwhere \nVR is a positive constant.\nFor the more general case, the required conditions on ˚ are as follows:\nK˚.K/ is bounded as K ! 0;\n˚.K/ grows at most polynomially as K ! 1:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 375,
      "printed_page": 354,
      "text": "354\n8\nExtended Variable Methods\n0\nTime\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\n0\nTime\nVelocity auto-correlation\n0\n0.02\n0.04\n0.06\n0.08\n0.10\n0.2\n0.4\n0.6\n0.8\n1.0\n1.2\nNosé-Hoover & Nosé-Hoover-Langevin\nLangevin\nFig. 8.4 The computed velocity auto-correlation functions are plotted for Nosé-Hoover and Nosé-\nHoover-Langevin dynamics (left), where we overlay plots from simulations using all possible\nparameter sets where \n 2 f0; 0:05; 0:5; 5; 50g and \u0006 2 f20; 2; 0:2; 0:02g. We additionally plot the\nsame result for Langevin dynamics (right), overlaying curves for \n 2 f0:05; 0:1; 0:2; : : : ; 51:2g,\nwhere high to low friction is plotted from red to blue respectively. The salient qualitative features\nof the results remain qualitatively unchanged when using different values of the parameters for the\nNosé-Hoover thermostats (see inset) whereas the Langevin thermostat has a much harsher effect\non the dynamics, with signiﬁcant differences as the friction is increased\nIt may seem that the difference between Nosé-Hoover-Langevin and Langevin\ndynamics is a technical one that essentially hinges on choice of parameters. Both\nmethods are ergodic and it may appear that by simply choosing a small value\nof friction in Langevin dynamics, we can match the behavior of Nosé-Hoover-\nLangevin to any desired accuracy. However, this is most deﬁnitely not the case, as a\ncareful analysis of Figs. 8.3 and 8.4 reveals. If an accurate velocity autocorrelation\nfunction is required, then the friction parameter in Langevin dynamics needs to be\nchosen very small (much less than \n D 0:1), see Fig. 8.4. But if the friction is\nchosen in this way, the convergence to canonical equilibrium is drastically impaired\n(Figs. 8.2 and 8.3). By contrast it is relatively easy to ﬁnd parameter choices\nfor Nosé-Hoover-Langevin which provide quite rapid convergence of canonical\naverages while preserving the accuracy of autocorrelation functions.\nThe convergence to equilibrium for Nosé-Hoover-Langevin is difﬁcult to cal-\nculate analytically. The only existing analysis is that of [225] which restricts\nconsideration to the convergence of the kinetic energy. It turns out that one may\nobtain a nonlinear system in terms of the following two variables:\nN\u000e.t/ D\nZ\nD\u0003R\n2K\u0005.q; p; \u0012; t/d!d\u0012;\n"
    },
    {
      "pdf_page": 376,
      "printed_page": 355,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n355\nwhere K is the kinetic energy, and the mean auxiliary variable \u0012\nN\u0012.t/ D\nZ\nD\u0003R\n\u0012\u0005.q; p; \u0012; t/d!d\u0012:\n\u0005 that appears here is the normalized pre-equilibrium density which evolves\naccording to the Fokker-Planck equation of the extended Nosé-Hoover-Langevin\nsystem.\nIt is then possible to perform a local stability analysis to characterize the\nconvergence to equilibrium of N\u000e and N\u0012 to the equilibrium .NdkBT; 0/. Although\nthe analysis makes certain stringent assumptions they are veriﬁed in [225] for a\nLennard-Jones molecular system.\n8.4.4\nVelocity Rescaling\nAn alternative stochastic-dynamical method for thermostatting molecular dynamics\nis the stochastic velocity rescaling method proposed by Bussi and collaborators [60,\n63] and somewhat generalized in [225]. The equations are (for the case M D I,\nconsidered for simplicity):\ndq D pdt\ndp D \u0003rU.q/ dt \u0003 \f.K/p dt C\np\n2kBT˚.K/pdW;\nwhere W.t/ is a single Wiener process, ˚ is an arbitrary smooth positive function\nand \f is deﬁned by\n\f.K/\ndef\nD .2K \u0003 .1 C Nd/kBT/˚.K/ \u0003 2kBTK d˚\ndK :\nWith these deﬁnitions, the method preserves the canonical probability density \u0005ˇ.\nWe do not prove the ergodicity of the method here, but expect that it would follow\nby an analysis similar to that given above for Nosé-Hoover-Langevin.\nThe original proposal of Bussi et al. had\n˚.K/ D \nVR\n2K ;\nso that\n\f.K/ D .1 \u0003 .Nd \u0003 1/kBT=2K/ \nVR;\nwhere \nVR is a positive constant.\nFor the more general case, the required conditions on ˚ are as follows:\nK˚.K/ is bounded as K ! 0;\n˚.K/ grows at most polynomially as K ! 1:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。",
  "context_notation": [],
  "extra_assumptions": [
    "ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。",
    "[EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。"
  ],
  "issues": [
    "{\"codes\": [\"MISSING_MOMENT_INTEGRABILITY\", \"MISSING_DENSITY_EVOLUTION_SPEC\"], \"detail\": \"两积分的变量、2K=kineticTwice invm p及ξ权重与原页一致，preEquilibriumDensity仅要求每个t≥0非负可积归一。该条件不保证两项加权函数可积，因而Lean总化Bochner积分未必代表原文有限分布平均；还没有限定ρ满足原文明说的NHL Fokker–Planck演化。局部稳定性/闭合方程缺口已披露，但不应将上述资格定义称为完整的预平衡密度资格。\", \"suggested_fix\": \"增加每个t≥0的Integrable (kineticTwice invm z.1.2*ρ t z)与Integrable (z.2*ρ t z)，并明确正质量。若保留pre-equilibrium命名，应添加FP演化规格；否则声明仅定义任意随时间概率密度的形式积分，并明确演化未覆盖。\"}"
  ],
  "statement_scope": "任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。",
  "lean_decl": "MD.Ch08.meanKineticTwice",
  "lean_declarations": [
    "MD.Ch08.meanKineticTwice",
    "MD.Ch08.meanBath",
    "MD.Ch08.preEquilibriumDensity"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 31,
      "website_verdict": "FAIL",
      "suggested_fix": "增加每个t≥0的Integrable (kineticTwice invm z.1.2*ρ t z)与Integrable (z.2*ρ t z)，并明确正质量。若保留pre-equilibrium命名，应添加FP演化规格；否则声明仅定义任意随时间概率密度的形式积分，并明确演化未覆盖。",
      "change": "[EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。"
    },
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "CORRECTED",
      "issue_codes": [
        "MISSING_MOMENT_INTEGRABILITY",
        "MISSING_DENSITY_EVOLUTION_SPEC"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。",
    "[EXTRA] 每个t≥0同时要求两项加权函数Integrable，故均值不是不可积时的总化积分。NHL Fokker–Planck演化未形式化，名称不代表完整预平衡动力学资格。"
  ]
}
```
```lean
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ∀ t, 0 ≤ t →
    probabilityDensity volume (ρ t) ∧
    Integrable (fun z : Phase n × ℝ ↦ kineticTwice invm z.1.2 * ρ t z) volume ∧
    Integrable (fun z : Phase n × ℝ ↦ z.2 * ρ t z) volume
```

## MD-8.4.4-RescalingStationary
```json
{
  "source_id": "MD-8.4.4-RescalingStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.4.4",
  "printed_page": "355",
  "pdf_page": "376",
  "statement_latex": "With these definitions, the method preserves the canonical probability density ρ_β. The book does not prove ergodicity.",
  "statement_verbatim": "8.4\nErgodic Stochastic-Dynamic Thermostats\n355\nwhere K is the kinetic energy, and the mean auxiliary variable \u0012\nN\u0012.t/ D\nZ\nD\u0003R\n\u0012\u0005.q; p; \u0012; t/d!d\u0012:\n\u0005 that appears here is the normalized pre-equilibrium density which evolves\naccording to the Fokker-Planck equation of the extended Nosé-Hoover-Langevin\nsystem.\nIt is then possible to perform a local stability analysis to characterize the\nconvergence to equilibrium of N\u000e and N\u0012 to the equilibrium .NdkBT; 0/. Although\nthe analysis makes certain stringent assumptions they are veriﬁed in [225] for a\nLennard-Jones molecular system.\n8.4.4\nVelocity Rescaling\nAn alternative stochastic-dynamical method for thermostatting molecular dynamics\nis the stochastic velocity rescaling method proposed by Bussi and collaborators [60,\n63] and somewhat generalized in [225]. The equations are (for the case M D I,\nconsidered for simplicity):\ndq D pdt\ndp D \u0003rU.q/ dt \u0003 \f.K/p dt C\np\n2kBT˚.K/pdW;\nwhere W.t/ is a single Wiener process, ˚ is an arbitrary smooth positive function\nand \f is deﬁned by\n\f.K/\ndef\nD .2K \u0003 .1 C Nd/kBT/˚.K/ \u0003 2kBTK d˚\ndK :\nWith these deﬁnitions, the method preserves the canonical probability density \u0005ˇ.\nWe do not prove the ergodicity of the method here, but expect that it would follow\nby an analysis similar to that given above for Nosé-Hoover-Langevin.\nThe original proposal of Bussi et al. had\n˚.K/ D \nVR\n2K ;\nso that\n\f.K/ D .1 \u0003 .Nd \u0003 1/kBT=2K/ \nVR;\nwhere \nVR is a positive constant.\nFor the more general case, the required conditions on ˚ are as follows:\nK˚.K/ is bounded as K ! 0;\n˚.K/ grows at most polynomially as K ! 1:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 376,
      "printed_page": 355,
      "text": "8.4\nErgodic Stochastic-Dynamic Thermostats\n355\nwhere K is the kinetic energy, and the mean auxiliary variable \u0012\nN\u0012.t/ D\nZ\nD\u0003R\n\u0012\u0005.q; p; \u0012; t/d!d\u0012:\n\u0005 that appears here is the normalized pre-equilibrium density which evolves\naccording to the Fokker-Planck equation of the extended Nosé-Hoover-Langevin\nsystem.\nIt is then possible to perform a local stability analysis to characterize the\nconvergence to equilibrium of N\u000e and N\u0012 to the equilibrium .NdkBT; 0/. Although\nthe analysis makes certain stringent assumptions they are veriﬁed in [225] for a\nLennard-Jones molecular system.\n8.4.4\nVelocity Rescaling\nAn alternative stochastic-dynamical method for thermostatting molecular dynamics\nis the stochastic velocity rescaling method proposed by Bussi and collaborators [60,\n63] and somewhat generalized in [225]. The equations are (for the case M D I,\nconsidered for simplicity):\ndq D pdt\ndp D \u0003rU.q/ dt \u0003 \f.K/p dt C\np\n2kBT˚.K/pdW;\nwhere W.t/ is a single Wiener process, ˚ is an arbitrary smooth positive function\nand \f is deﬁned by\n\f.K/\ndef\nD .2K \u0003 .1 C Nd/kBT/˚.K/ \u0003 2kBTK d˚\ndK :\nWith these deﬁnitions, the method preserves the canonical probability density \u0005ˇ.\nWe do not prove the ergodicity of the method here, but expect that it would follow\nby an analysis similar to that given above for Nosé-Hoover-Langevin.\nThe original proposal of Bussi et al. had\n˚.K/ D \nVR\n2K ;\nso that\n\f.K/ D .1 \u0003 .Nd \u0003 1/kBT=2K/ \nVR;\nwhere \nVR is a positive constant.\nFor the more general case, the required conditions on ˚ are as follows:\nK˚.K/ is bounded as K ! 0;\n˚.K/ grows at most polynomially as K ! 1:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。",
  "context_notation": [],
  "extra_assumptions": [
    "测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。",
    "havoid现对tsupport f量化，与HasCompactSupport的闭包支撑一致；未扩大到闭包接触p=0的测试函数。",
    "应要求tsupport f避开p=0（或K有统一正下界），当前Lean havoid尚未实现这一条件。",
    "二阶项冻结噪声方向，正确表示Itô Hessian；完整随机解、奇异边界与半群不变性未覆盖。"
  ],
  "issues": [
    "{\"codes\": [\"SUPPORT_NOT_SEPARATED_FROM_ZERO\", \"SINGULAR_BOUNDARY_CONTROL_MISSING\"], \"detail\": \"Itô二阶项确实冻结rescalingNoise Φ θ z，不含噪声导数，正确；C²势、正θ,Z和归一密度亦正确。但havoid量化Function.support f，即f≠0的集合，而HasCompactSupport约束的是其闭包；这不保证闭包与p=0分离。JSON所称“支撑远离K=0”比实际前提强。Admissible不控制Φ′在0附近的增长，因此不能直接用避开奇点的紧支撑分部积分论证覆盖所有给定测试函数。本项FAIL指所宣称的域/边界规格不足，并非已提供该Lean等式的数值反例。\", \"suggested_fix\": \"将havoid改为∀z∈tsupport f,z.2≠0，或明确存在ε>0使f的支撑上K≥ε。若希望包含接触p=0的测试函数，应另设边界、噪声正则性及生成元可积性条件并论证；不能静默扩大弱驻定范围。\"}"
  ],
  "statement_scope": "闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。",
  "lean_decl": "MD.Ch08.rescalingStationary",
  "lean_declarations": [
    "MD.Ch08.rescalingStationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 31,
      "website_verdict": "FAIL",
      "suggested_fix": "将havoid改为∀z∈tsupport f,z.2≠0，或明确存在ε>0使f的支撑上K≥ε。若希望包含接触p=0的测试函数，应另设边界、噪声正则性及生成元可积性条件并论证；不能静默扩大弱驻定范围。",
      "change": "havoid现对tsupport f量化，与HasCompactSupport的闭包支撑一致；未扩大到闭包接触p=0的测试函数。"
    },
    {
      "instruction": 31,
      "stage": "json_review",
      "status": "CORRECTED",
      "issue_codes": [
        "SUPPORT_NOT_SEPARATED_FROM_ZERO",
        "SINGULAR_BOUNDARY_CONTROL_MISSING"
      ],
      "change": "合并经原页和现有签名核对的元数据更正；原页全文未改。"
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。",
    "二阶项冻结噪声方向，正确表示Itô Hessian；完整随机解、奇异边界与半群不变性未覆盖。"
  ]
}
```
```lean
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ tsupport f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry
```
