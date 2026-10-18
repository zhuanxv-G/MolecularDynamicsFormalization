# BATCH07 第8章原文与陈述审校

## MD-8.4.4-VelocityRescaling
```json
{
  "source_id": "MD-8.4.4-VelocityRescaling",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.4.4",
  "printed_page": "355",
  "pdf_page": "376",
  "statement_latex": "dq=pdt, dp=-∇Udt-Ψ(K)pdt+√(2k_BTΦ(K))p dW; Ψ=(2K-(1+N_d)k_BT)Φ-2k_BTKΦ′. Φ(K)=γ_VR/(2K).",
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
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Φ在K>0光滑正，KΦ在0附近有界且多项式增长；原始Φ在K=0奇异，未声称全空间光滑扩散或遍历性。"
  ],
  "issues": [],
  "statement_scope": "实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。",
  "lean_decl": "MD.Ch08.rescalingPsi",
  "lean_declarations": [
    "MD.Ch08.rescalingPsi",
    "MD.Ch08.rescalingDrift",
    "MD.Ch08.rescalingNoise",
    "MD.Ch08.originalRescalingPhi",
    "MD.Ch08.rescalingAdmissible",
    "MD.Ch08.rescalingPsi_original"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def rescalingPsi (Φ : ℝ → ℝ) (θ K : ℝ) : ℝ :=
  (2*K-((n:ℝ)+1)*θ)*Φ K-2*θ*K*deriv Φ K
def rescalingDrift (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (z.2, fun i ↦ -gradient U z.1 i-rescalingPsi (n:=n) Φ θ ((∑ j, z.2 j^2)/2)*z.2 i)
def rescalingNoise (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (0, fun i ↦ Real.sqrt (2*θ*Φ ((∑ j, z.2 j^2)/2))*z.2 i)
def originalRescalingPhi (γ K : ℝ) : ℝ := γ/(2*K)
def rescalingAdmissible (Φ : ℝ → ℝ) : Prop :=
  ContDiffOn ℝ ∞ Φ (Ioi 0) ∧ (∀ K, 0 < K → 0 < Φ K) ∧
  (∃ C ε : ℝ, 0 < ε ∧ ∀ K, 0 < K → K < ε → |K*Φ K| ≤ C) ∧
  ∃ C : ℝ, ∃ m : ℕ, ∀ K, 1 ≤ K → |Φ K| ≤ C*K^m
theorem rescalingPsi_original (γ θ K : ℝ) (hK : K ≠ 0) :
    rescalingPsi (n:=n) (originalRescalingPhi γ) θ K =
      (1-((n:ℝ)-1)*θ/(2*K))*γ := by
  sorry
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
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。"
  ],
  "issues": [],
  "statement_scope": "支撑避开零动量的测试函数弱驻定目标；零动量边界与半群不变性未覆盖。",
  "lean_decl": "MD.Ch08.rescalingStationary",
  "lean_declarations": [
    "MD.Ch08.rescalingStationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ Function.support f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry
```

## MD-8.4.5-ThermostatEfficiency
```json
{
  "source_id": "MD-8.4.5-ThermostatEfficiency",
  "kind": "definition",
  "label": null,
  "section": "8.4.5",
  "printed_page": "356–357",
  "pdf_page": "377–378",
  "statement_latex": "efficiency = rate of convergence to equilibrium / rate of growth of perturbation of dynamics. Table 8.1 gives analytic lowest-order estimates; NHL has initially quadratic error.",
  "statement_verbatim": "356\n8\nExtended Variable Methods\n8.4.5\nThe Efﬁciency of a Thermostat and “Gentle”\nThermostats\nTo understand the reason for this fundamental, qualitative difference between\nNosé-Hoover-Langevin and Langevin dynamics, and to compare it with Velocity\nRescaling, one may study a quantity that relates the rate of convergence to\nequilibrium to the rate of growth of the error in the autocorrelation function. In\n[225], this precise quantity is introduced and termed the efﬁciency of the thermostat:\nefﬁciency D\nrate of convergence to equilibrium\nrate of growth of perturbation of dynamics:\nThe rate of convergence to equilibrium is quite difﬁcult to calculate in general, as it\nwould typically relate to the spectral gap of the diffusion. In light of the observations\nof Fig. 8.3, one may choose to estimate this in terms of the rate of convergence of\nthe average kinetic energy to the target temperature.\nThe rate of accumulation of error due to the thermostat is also difﬁcult to\nquantify analytically, since it requires calculation of the error in an autocorrelation\nfunction over a time interval which may not be short compared to the simulation\nstepsize, particularly for slow-relaxing systems. Again, an estimate is obtainable\nby considering the rate of error accumulation at short times (obtained by Taylor\nexpansion of the exact and approximate autocorrelation functions). The result of\nthese two estimates is then an analytical estimate for the efﬁciency that relates\nvarious schemes for various values of the parameters involved.\nAn interesting observation is that, while for both Langevin dynamics and\nVelocity Rescaling the error accumulation is linear in time, the same is not true\nfor Nosé-Hoover-Langevin: the error in NHL increases initially in proportion to t2;\nthe instantaneous diffusion rate is inherited from the system to which it is applied.\nThis means that, while NHL cannot be used to model imposed target diffusion rates,\nits inﬂuence on dynamics within the setting of molecular dynamics thermostatting\nis also very slight: it is a gentle thermostat. The Velocity Rescaling method is\nalso gentle in another sense: the rate of growth of error is small. Estimating the\nefﬁciency for both Langevin and Velocity Rescaling is similar—we ﬁnd the ratio of\nthe estimated rate of convergence of kinetic energy to the estimated rate of linear\nerror growth in the velocity autocorrelation function. For Nosé-Hoover-Langevin,\nwhich has quadratic-in-time error growth, we determine the characteristic time\nuntil convergence (the reciprocal of the exponential rate of convergence) and from\nthis determine how much perturbation accumulates in the velocity autocorrelation\nfunction.\nIn Table 8.1 we show the comparison of the relevant estimates of the above\nquantities, including the efﬁciency, for different choices of thermostat.\n\n8.5\nNon-Newtonian Dynamics-Based Iterations for Molecular Sampling\n357\nTable 8.1 Estimated rates of convergence, perturbation growth, and efﬁciency for different\nmethods\nError (to lowest\nThermostat\nConvergence rate\norder in t)\nEfﬁciency\nLangevin\n\n\nt\n\n 1\nVelocity Rescaling\n4\nAvˇfK2˚.K/g\nTNdkB\n2\nNd AvˇfK˚.K/g t\nO .Nd/\nVR with ˚.K/ D \nVR\n2K\n\nVR\n\nVR\nNd t\n\n Nd\nNHL\nq\nNdkBT\n\u0006\nkBT\n2\u0006 t2\n\n 2Nd\n(at critical damping)\n8.5\nNon-Newtonian Dynamics-Based Iterations\nfor Molecular Sampling\nGiven that we can decompose the stochastic dynamics into deterministic part and\nstochastic process, and approximately or exactly solve the parts, it is common\nto iterate the maps for each building block sequentially in such a way that the\ncalculation approximates the dynamics of the system. This is, very likely, an\nunnecessary restriction on the sampling strategy. The crucial things that effect the\nultimate success of the method are that the parts themselves preserve the measure\n(or approximately so), the stages are volume preserving, and that the stochastic\nprocesses are sufﬁciently strongly coupled so that the overall iteration is ergodic.\nThere is essentially no need to use maps based on Newtonian deterministic\ndynamics. There are many alternative dynamics models which leave invariant the\ncanonical measure, going well beyond those considered so far. To illustrate this\nwith one intriguing example, we explore here the stochastic dynamical system in\n2Nc C 1 variables deﬁned by\ndq D \u0012M\u00021pdt;\n(8.33)\ndp D \u0003\npdt C \u0007M1=2dW;\n(8.34)\nd\u0012 D \u0003Œ.M\u00021p/ \u0002 rU.q/=\u0006 C \n0\u0012\tdt C \u00070dZ;\n(8.35)\nwhere W is a vector of Nc Wiener processes, Z is a scalar Wiener process and \u0007 D\np2kBT\n, and \u00070 D\np\n2kBT\n0=\u0006 this system preserves the augmented distribution\nwith density\nQ\u0005.q; p; \u0012/ D e\u0002ˇ.pTM\u00021p=2CU.q/C\u0006\u00122=2/:\nFor this system, it is possible to show that the Hörmander condition holds. Setting all\nparameters to 1 and taking M D I (without loss of generality in this demonstration)\nwe write our SDE in the form d' D D C PNcC1\niD1 YidWi, where ' is the vector of all\nphase variables, Yi D eNcCi, for i D 1; : : : ; Nc C 1, is the i C Ncth basis function in\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 377,
      "printed_page": 356,
      "text": "356\n8\nExtended Variable Methods\n8.4.5\nThe Efﬁciency of a Thermostat and “Gentle”\nThermostats\nTo understand the reason for this fundamental, qualitative difference between\nNosé-Hoover-Langevin and Langevin dynamics, and to compare it with Velocity\nRescaling, one may study a quantity that relates the rate of convergence to\nequilibrium to the rate of growth of the error in the autocorrelation function. In\n[225], this precise quantity is introduced and termed the efﬁciency of the thermostat:\nefﬁciency D\nrate of convergence to equilibrium\nrate of growth of perturbation of dynamics:\nThe rate of convergence to equilibrium is quite difﬁcult to calculate in general, as it\nwould typically relate to the spectral gap of the diffusion. In light of the observations\nof Fig. 8.3, one may choose to estimate this in terms of the rate of convergence of\nthe average kinetic energy to the target temperature.\nThe rate of accumulation of error due to the thermostat is also difﬁcult to\nquantify analytically, since it requires calculation of the error in an autocorrelation\nfunction over a time interval which may not be short compared to the simulation\nstepsize, particularly for slow-relaxing systems. Again, an estimate is obtainable\nby considering the rate of error accumulation at short times (obtained by Taylor\nexpansion of the exact and approximate autocorrelation functions). The result of\nthese two estimates is then an analytical estimate for the efﬁciency that relates\nvarious schemes for various values of the parameters involved.\nAn interesting observation is that, while for both Langevin dynamics and\nVelocity Rescaling the error accumulation is linear in time, the same is not true\nfor Nosé-Hoover-Langevin: the error in NHL increases initially in proportion to t2;\nthe instantaneous diffusion rate is inherited from the system to which it is applied.\nThis means that, while NHL cannot be used to model imposed target diffusion rates,\nits inﬂuence on dynamics within the setting of molecular dynamics thermostatting\nis also very slight: it is a gentle thermostat. The Velocity Rescaling method is\nalso gentle in another sense: the rate of growth of error is small. Estimating the\nefﬁciency for both Langevin and Velocity Rescaling is similar—we ﬁnd the ratio of\nthe estimated rate of convergence of kinetic energy to the estimated rate of linear\nerror growth in the velocity autocorrelation function. For Nosé-Hoover-Langevin,\nwhich has quadratic-in-time error growth, we determine the characteristic time\nuntil convergence (the reciprocal of the exponential rate of convergence) and from\nthis determine how much perturbation accumulates in the velocity autocorrelation\nfunction.\nIn Table 8.1 we show the comparison of the relevant estimates of the above\nquantities, including the efﬁciency, for different choices of thermostat.\n"
    },
    {
      "pdf_page": 378,
      "printed_page": 357,
      "text": "8.5\nNon-Newtonian Dynamics-Based Iterations for Molecular Sampling\n357\nTable 8.1 Estimated rates of convergence, perturbation growth, and efﬁciency for different\nmethods\nError (to lowest\nThermostat\nConvergence rate\norder in t)\nEfﬁciency\nLangevin\n\n\nt\n\n 1\nVelocity Rescaling\n4\nAvˇfK2˚.K/g\nTNdkB\n2\nNd AvˇfK˚.K/g t\nO .Nd/\nVR with ˚.K/ D \nVR\n2K\n\nVR\n\nVR\nNd t\n\n Nd\nNHL\nq\nNdkBT\n\u0006\nkBT\n2\u0006 t2\n\n 2Nd\n(at critical damping)\n8.5\nNon-Newtonian Dynamics-Based Iterations\nfor Molecular Sampling\nGiven that we can decompose the stochastic dynamics into deterministic part and\nstochastic process, and approximately or exactly solve the parts, it is common\nto iterate the maps for each building block sequentially in such a way that the\ncalculation approximates the dynamics of the system. This is, very likely, an\nunnecessary restriction on the sampling strategy. The crucial things that effect the\nultimate success of the method are that the parts themselves preserve the measure\n(or approximately so), the stages are volume preserving, and that the stochastic\nprocesses are sufﬁciently strongly coupled so that the overall iteration is ergodic.\nThere is essentially no need to use maps based on Newtonian deterministic\ndynamics. There are many alternative dynamics models which leave invariant the\ncanonical measure, going well beyond those considered so far. To illustrate this\nwith one intriguing example, we explore here the stochastic dynamical system in\n2Nc C 1 variables deﬁned by\ndq D \u0012M\u00021pdt;\n(8.33)\ndp D \u0003\npdt C \u0007M1=2dW;\n(8.34)\nd\u0012 D \u0003Œ.M\u00021p/ \u0002 rU.q/=\u0006 C \n0\u0012\tdt C \u00070dZ;\n(8.35)\nwhere W is a vector of Nc Wiener processes, Z is a scalar Wiener process and \u0007 D\np2kBT\n, and \u00070 D\np\n2kBT\n0=\u0006 this system preserves the augmented distribution\nwith density\nQ\u0005.q; p; \u0012/ D e\u0002ˇ.pTM\u00021p=2CU.q/C\u0006\u00122=2/:\nFor this system, it is possible to show that the Hörmander condition holds. Setting all\nparameters to 1 and taking M D I (without loss of generality in this demonstration)\nwe write our SDE in the form d' D D C PNcC1\niD1 YidWi, where ' is the vector of all\nphase variables, Yi D eNcCi, for i D 1; : : : ; Nc C 1, is the i C Ncth basis function in\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。",
    "γ>0、θ,Q>0、N>0用于物理解释；一般VR的O(N)给出确切渐近性质定义，没有声称任意Φ族满足它。"
  ],
  "issues": [],
  "statement_scope": "效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的O(N)含义；外引估计定理未证，经验曲线排除。",
  "lean_decl": "MD.Ch08.thermostatEfficiency",
  "lean_declarations": [
    "MD.Ch08.thermostatEfficiency",
    "MD.Ch08.langevinErrorEstimate",
    "MD.Ch08.rescalingRateEstimate",
    "MD.Ch08.rescalingErrorEstimate",
    "MD.Ch08.nhlRateEstimate",
    "MD.Ch08.nhlErrorEstimate",
    "MD.Ch08.langevinRateEstimate",
    "MD.Ch08.langevinEfficiencyEstimate",
    "MD.Ch08.originalRescalingRateEstimate",
    "MD.Ch08.originalRescalingErrorEstimate",
    "MD.Ch08.originalRescalingEfficiencyEstimate",
    "MD.Ch08.nhlCriticalEfficiencyEstimate",
    "MD.Ch08.rescalingEfficiencyOrder"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2

def langevinRateEstimate (γ : ℝ) : ℝ := γ
def langevinEfficiencyEstimate : ℝ := 1
def originalRescalingRateEstimate (γVR : ℝ) : ℝ := γVR
def originalRescalingErrorEstimate (N : ℕ) (γVR t : ℝ) : ℝ := γVR/(N:ℝ)*t
def originalRescalingEfficiencyEstimate (N : ℕ) : ℝ := N
def nhlCriticalEfficiencyEstimate (N : ℕ) : ℝ := 2*N
def rescalingEfficiencyOrder (efficiency : ℕ → ℝ) : Prop :=
  efficiency =O[atTop] (fun N : ℕ ↦ (N : ℝ))
```

## MD-8.5-SLS
```json
{
  "source_id": "MD-8.5-SLS",
  "kind": "definition",
  "label": null,
  "section": "8.5",
  "printed_page": "357–358",
  "pdf_page": "378–379",
  "statement_latex": "dq=ξM⁻¹pdt, dp=-γpdt+σM^{1/2}dW, dξ=-[(M⁻¹p)·∇U/μ+γ′ξ]dt+σ′dZ; σ=√(2k_BTγ), σ′=√(2k_BTγ′/μ).",
  "statement_verbatim": "8.5\nNon-Newtonian Dynamics-Based Iterations for Molecular Sampling\n357\nTable 8.1 Estimated rates of convergence, perturbation growth, and efﬁciency for different\nmethods\nError (to lowest\nThermostat\nConvergence rate\norder in t)\nEfﬁciency\nLangevin\n\n\nt\n\n 1\nVelocity Rescaling\n4\nAvˇfK2˚.K/g\nTNdkB\n2\nNd AvˇfK˚.K/g t\nO .Nd/\nVR with ˚.K/ D \nVR\n2K\n\nVR\n\nVR\nNd t\n\n Nd\nNHL\nq\nNdkBT\n\u0006\nkBT\n2\u0006 t2\n\n 2Nd\n(at critical damping)\n8.5\nNon-Newtonian Dynamics-Based Iterations\nfor Molecular Sampling\nGiven that we can decompose the stochastic dynamics into deterministic part and\nstochastic process, and approximately or exactly solve the parts, it is common\nto iterate the maps for each building block sequentially in such a way that the\ncalculation approximates the dynamics of the system. This is, very likely, an\nunnecessary restriction on the sampling strategy. The crucial things that effect the\nultimate success of the method are that the parts themselves preserve the measure\n(or approximately so), the stages are volume preserving, and that the stochastic\nprocesses are sufﬁciently strongly coupled so that the overall iteration is ergodic.\nThere is essentially no need to use maps based on Newtonian deterministic\ndynamics. There are many alternative dynamics models which leave invariant the\ncanonical measure, going well beyond those considered so far. To illustrate this\nwith one intriguing example, we explore here the stochastic dynamical system in\n2Nc C 1 variables deﬁned by\ndq D \u0012M\u00021pdt;\n(8.33)\ndp D \u0003\npdt C \u0007M1=2dW;\n(8.34)\nd\u0012 D \u0003Œ.M\u00021p/ \u0002 rU.q/=\u0006 C \n0\u0012\tdt C \u00070dZ;\n(8.35)\nwhere W is a vector of Nc Wiener processes, Z is a scalar Wiener process and \u0007 D\np2kBT\n, and \u00070 D\np\n2kBT\n0=\u0006 this system preserves the augmented distribution\nwith density\nQ\u0005.q; p; \u0012/ D e\u0002ˇ.pTM\u00021p=2CU.q/C\u0006\u00122=2/:\nFor this system, it is possible to show that the Hörmander condition holds. Setting all\nparameters to 1 and taking M D I (without loss of generality in this demonstration)\nwe write our SDE in the form d' D D C PNcC1\niD1 YidWi, where ' is the vector of all\nphase variables, Yi D eNcCi, for i D 1; : : : ; Nc C 1, is the i C Ncth basis function in\n\n358\n8\nExtended Variable Methods\nR2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”\nD D\n2\n4\n\u0012p\n\u0003p\n\u0003p \u0002 rU \u0003 \u0012\n3\n5 :\nThen we calculate directly\nD0 D ŒD; YNcC1\t D\n2\n4\np\n0\n1\n3\n5 ;\nand from this we see that ŒD0; Yi\t D ei for i D 1; 2; : : : ; Nc. Thus all the basis\nvectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander\ndecomposition; as we know, this is the key step in the proof of ergodicity. Thus\nthe method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even\nthough it is not based on a Newtonian model. Leaving the stochastic term off the\nﬁnal equation (i.e. in \u0012) is easily shown to destroy the ergodicity property (the\nHörmander condition is then violated).\nNow consider the splitting into deterministic and OU parts. The deterministic\npart\nPq D \u0012M\u00021p;\nPp D 0;\nP\u0012 D \u0003.M\u00021p/ \u0002 rU.q/=\u0006;\n(8.36)\npreserves volume and the function U.q/ C \u0006\u00122=2 and hence also the distribution\nwith density Q\u0005A.q; \u0012/ D e\u0002ˇ.U.q/C\u0006\u00122=2/. By the same token the OU processes\ncollectively preserve Q\u0005B.p; \u0012/ D e\u0002ˇ.pTM\u00021p=2C\u0006\u00122=2/. In combination the full\ndynamics preserves the extended canonical measure. If we iterate the two parts\n(assuming the deterministic part is solved exactly) the distribution will converge\nto the exact canonical distribution, due to especially to incorporation of Nc C1 noise\nprocesses.\nThe OU process deﬁning the ﬂuctuations in p is completely decoupled from q\nand \u0012, so it is perhaps most natural to think of the iteration as a random walk on\nthe reduced space .q; \u0012/ where the directions are generated by an auxiliary OU\nprocess. Then the algorithm proceeds as follows: (1) choose a random direction\np using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; \u0012/\nin the direction p. We refer to this procedure as stochastic line sampling (SLS), for\nthe following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the\nstraight line: q D q0 C \u000fM\u00021p, where \u000f is a scalar function of time. Inserting\nthis coordinate change in (8.36) we see that the equations reduce to P\u000f D \u0012,\nP\u0012 D \u0003@=@\u000fU.q0 C \u000fM\u00021p/. This is a one-degree of freedom system and hence\nis theoretically exactly solvable in quadratures, although the complexity of the force\nwill render this impractical in calculations, and, as mentioned above, an additional\nstochastic process must be incorporated to drive \u0012.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 378,
      "printed_page": 357,
      "text": "8.5\nNon-Newtonian Dynamics-Based Iterations for Molecular Sampling\n357\nTable 8.1 Estimated rates of convergence, perturbation growth, and efﬁciency for different\nmethods\nError (to lowest\nThermostat\nConvergence rate\norder in t)\nEfﬁciency\nLangevin\n\n\nt\n\n 1\nVelocity Rescaling\n4\nAvˇfK2˚.K/g\nTNdkB\n2\nNd AvˇfK˚.K/g t\nO .Nd/\nVR with ˚.K/ D \nVR\n2K\n\nVR\n\nVR\nNd t\n\n Nd\nNHL\nq\nNdkBT\n\u0006\nkBT\n2\u0006 t2\n\n 2Nd\n(at critical damping)\n8.5\nNon-Newtonian Dynamics-Based Iterations\nfor Molecular Sampling\nGiven that we can decompose the stochastic dynamics into deterministic part and\nstochastic process, and approximately or exactly solve the parts, it is common\nto iterate the maps for each building block sequentially in such a way that the\ncalculation approximates the dynamics of the system. This is, very likely, an\nunnecessary restriction on the sampling strategy. The crucial things that effect the\nultimate success of the method are that the parts themselves preserve the measure\n(or approximately so), the stages are volume preserving, and that the stochastic\nprocesses are sufﬁciently strongly coupled so that the overall iteration is ergodic.\nThere is essentially no need to use maps based on Newtonian deterministic\ndynamics. There are many alternative dynamics models which leave invariant the\ncanonical measure, going well beyond those considered so far. To illustrate this\nwith one intriguing example, we explore here the stochastic dynamical system in\n2Nc C 1 variables deﬁned by\ndq D \u0012M\u00021pdt;\n(8.33)\ndp D \u0003\npdt C \u0007M1=2dW;\n(8.34)\nd\u0012 D \u0003Œ.M\u00021p/ \u0002 rU.q/=\u0006 C \n0\u0012\tdt C \u00070dZ;\n(8.35)\nwhere W is a vector of Nc Wiener processes, Z is a scalar Wiener process and \u0007 D\np2kBT\n, and \u00070 D\np\n2kBT\n0=\u0006 this system preserves the augmented distribution\nwith density\nQ\u0005.q; p; \u0012/ D e\u0002ˇ.pTM\u00021p=2CU.q/C\u0006\u00122=2/:\nFor this system, it is possible to show that the Hörmander condition holds. Setting all\nparameters to 1 and taking M D I (without loss of generality in this demonstration)\nwe write our SDE in the form d' D D C PNcC1\niD1 YidWi, where ' is the vector of all\nphase variables, Yi D eNcCi, for i D 1; : : : ; Nc C 1, is the i C Ncth basis function in\n"
    },
    {
      "pdf_page": 379,
      "printed_page": 358,
      "text": "358\n8\nExtended Variable Methods\nR2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”\nD D\n2\n4\n\u0012p\n\u0003p\n\u0003p \u0002 rU \u0003 \u0012\n3\n5 :\nThen we calculate directly\nD0 D ŒD; YNcC1\t D\n2\n4\np\n0\n1\n3\n5 ;\nand from this we see that ŒD0; Yi\t D ei for i D 1; 2; : : : ; Nc. Thus all the basis\nvectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander\ndecomposition; as we know, this is the key step in the proof of ergodicity. Thus\nthe method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even\nthough it is not based on a Newtonian model. Leaving the stochastic term off the\nﬁnal equation (i.e. in \u0012) is easily shown to destroy the ergodicity property (the\nHörmander condition is then violated).\nNow consider the splitting into deterministic and OU parts. The deterministic\npart\nPq D \u0012M\u00021p;\nPp D 0;\nP\u0012 D \u0003.M\u00021p/ \u0002 rU.q/=\u0006;\n(8.36)\npreserves volume and the function U.q/ C \u0006\u00122=2 and hence also the distribution\nwith density Q\u0005A.q; \u0012/ D e\u0002ˇ.U.q/C\u0006\u00122=2/. By the same token the OU processes\ncollectively preserve Q\u0005B.p; \u0012/ D e\u0002ˇ.pTM\u00021p=2C\u0006\u00122=2/. In combination the full\ndynamics preserves the extended canonical measure. If we iterate the two parts\n(assuming the deterministic part is solved exactly) the distribution will converge\nto the exact canonical distribution, due to especially to incorporation of Nc C1 noise\nprocesses.\nThe OU process deﬁning the ﬂuctuations in p is completely decoupled from q\nand \u0012, so it is perhaps most natural to think of the iteration as a random walk on\nthe reduced space .q; \u0012/ where the directions are generated by an auxiliary OU\nprocess. Then the algorithm proceeds as follows: (1) choose a random direction\np using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; \u0012/\nin the direction p. We refer to this procedure as stochastic line sampling (SLS), for\nthe following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the\nstraight line: q D q0 C \u000fM\u00021p, where \u000f is a scalar function of time. Inserting\nthis coordinate change in (8.36) we see that the equations reduce to P\u000f D \u0012,\nP\u0012 D \u0003@=@\u000fU.q0 C \u000fM\u00021p/. This is a one-degree of freedom system and hence\nis theoretically exactly solvable in quadratures, although the complexity of the force\nwill render this impractical in calculations, and, as mentioned above, an additional\nstochastic process must be incorporated to drive \u0012.\n"
    }
  ],
  "numbered_equations": [
    "8.33",
    "8.34",
    "8.35",
    "8.36"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "全部n+1个Wiener坐标独立，Q、质量、温度及两摩擦参数正；总漂移和常噪声用实际积分方程解释。"
  ],
  "issues": [],
  "statement_scope": "完整SLS加性SDE积分解规格、噪声方向与确定性子场定义。",
  "lean_decl": "MD.Ch08.slsDrift",
  "lean_declarations": [
    "MD.Ch08.slsDrift",
    "MD.Ch08.slsNoise",
    "MD.Ch08.isSLSSolution",
    "MD.Ch08.slsDeterministic"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def slsDrift (invm : Vec n) (U : Vec n → ℝ) (Q γ γb : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, fun i ↦ -γ*z.1.2 i),
   -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q-γb*z.2)
def slsNoise (invm : Vec n) (β Q γ γb : ℝ) (j : Fin (n+1)) : Phase n × ℝ :=
  if hj : j.val < n then
    ((0, Pi.single ⟨j.val,hj⟩ (Real.sqrt (2*γ/(β*invm ⟨j.val,hj⟩)))), 0)
  else ((0,0), Real.sqrt (2*γb/(β*Q)))
def isSLSSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ γb : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec (n+1))
    (X : ℝ → Ω → Phase n × ℝ) (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧ 0 < γb ∧
  additiveSDE P (n+1) W X x0 (slsDrift invm U Q γ γb) (slsNoise invm β Q γ γb)
def slsDeterministic (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, 0), -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
```

## MD-8.5-SLSBracketPrinted
```json
{
  "source_id": "MD-8.5-SLSBracketPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.5",
  "printed_page": "358",
  "pdf_page": "379",
  "statement_latex": "D=(ξp,-p,-p·∇U-ξ), D′=[D,Y_{Nc+1}]=(p,0,1), [D′,Y_i]=e_i.",
  "statement_verbatim": "358\n8\nExtended Variable Methods\nR2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”\nD D\n2\n4\n\u0012p\n\u0003p\n\u0003p \u0002 rU \u0003 \u0012\n3\n5 :\nThen we calculate directly\nD0 D ŒD; YNcC1\t D\n2\n4\np\n0\n1\n3\n5 ;\nand from this we see that ŒD0; Yi\t D ei for i D 1; 2; : : : ; Nc. Thus all the basis\nvectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander\ndecomposition; as we know, this is the key step in the proof of ergodicity. Thus\nthe method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even\nthough it is not based on a Newtonian model. Leaving the stochastic term off the\nﬁnal equation (i.e. in \u0012) is easily shown to destroy the ergodicity property (the\nHörmander condition is then violated).\nNow consider the splitting into deterministic and OU parts. The deterministic\npart\nPq D \u0012M\u00021p;\nPp D 0;\nP\u0012 D \u0003.M\u00021p/ \u0002 rU.q/=\u0006;\n(8.36)\npreserves volume and the function U.q/ C \u0006\u00122=2 and hence also the distribution\nwith density Q\u0005A.q; \u0012/ D e\u0002ˇ.U.q/C\u0006\u00122=2/. By the same token the OU processes\ncollectively preserve Q\u0005B.p; \u0012/ D e\u0002ˇ.pTM\u00021p=2C\u0006\u00122=2/. In combination the full\ndynamics preserves the extended canonical measure. If we iterate the two parts\n(assuming the deterministic part is solved exactly) the distribution will converge\nto the exact canonical distribution, due to especially to incorporation of Nc C1 noise\nprocesses.\nThe OU process deﬁning the ﬂuctuations in p is completely decoupled from q\nand \u0012, so it is perhaps most natural to think of the iteration as a random walk on\nthe reduced space .q; \u0012/ where the directions are generated by an auxiliary OU\nprocess. Then the algorithm proceeds as follows: (1) choose a random direction\np using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; \u0012/\nin the direction p. We refer to this procedure as stochastic line sampling (SLS), for\nthe following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the\nstraight line: q D q0 C \u000fM\u00021p, where \u000f is a scalar function of time. Inserting\nthis coordinate change in (8.36) we see that the equations reduce to P\u000f D \u0012,\nP\u0012 D \u0003@=@\u000fU.q0 C \u000fM\u00021p/. This is a one-degree of freedom system and hence\nis theoretically exactly solvable in quadratures, although the complexity of the force\nwill render this impractical in calculations, and, as mentioned above, an additional\nstochastic process must be incorporated to drive \u0012.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 379,
      "printed_page": 358,
      "text": "358\n8\nExtended Variable Methods\nR2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”\nD D\n2\n4\n\u0012p\n\u0003p\n\u0003p \u0002 rU \u0003 \u0012\n3\n5 :\nThen we calculate directly\nD0 D ŒD; YNcC1\t D\n2\n4\np\n0\n1\n3\n5 ;\nand from this we see that ŒD0; Yi\t D ei for i D 1; 2; : : : ; Nc. Thus all the basis\nvectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander\ndecomposition; as we know, this is the key step in the proof of ergodicity. Thus\nthe method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even\nthough it is not based on a Newtonian model. Leaving the stochastic term off the\nﬁnal equation (i.e. in \u0012) is easily shown to destroy the ergodicity property (the\nHörmander condition is then violated).\nNow consider the splitting into deterministic and OU parts. The deterministic\npart\nPq D \u0012M\u00021p;\nPp D 0;\nP\u0012 D \u0003.M\u00021p/ \u0002 rU.q/=\u0006;\n(8.36)\npreserves volume and the function U.q/ C \u0006\u00122=2 and hence also the distribution\nwith density Q\u0005A.q; \u0012/ D e\u0002ˇ.U.q/C\u0006\u00122=2/. By the same token the OU processes\ncollectively preserve Q\u0005B.p; \u0012/ D e\u0002ˇ.pTM\u00021p=2C\u0006\u00122=2/. In combination the full\ndynamics preserves the extended canonical measure. If we iterate the two parts\n(assuming the deterministic part is solved exactly) the distribution will converge\nto the exact canonical distribution, due to especially to incorporation of Nc C1 noise\nprocesses.\nThe OU process deﬁning the ﬂuctuations in p is completely decoupled from q\nand \u0012, so it is perhaps most natural to think of the iteration as a random walk on\nthe reduced space .q; \u0012/ where the directions are generated by an auxiliary OU\nprocess. Then the algorithm proceeds as follows: (1) choose a random direction\np using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; \u0012/\nin the direction p. We refer to this procedure as stochastic line sampling (SLS), for\nthe following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the\nstraight line: q D q0 C \u000fM\u00021p, where \u000f is a scalar function of time. Inserting\nthis coordinate change in (8.36) we see that the equations reduce to P\u000f D \u0012,\nP\u0012 D \u0003@=@\u000fU.q0 C \u000fM\u00021p/. This is a one-degree of freedom system and hence\nis theoretically exactly solvable in quadratures, although the complexity of the force\nwill render this impractical in calculations, and, as mentioned above, an additional\nstochastic process must be incorporated to drive \u0012.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只纠正第一括号；二次括号的整体符号不影响生成空间张成。"
  ],
  "issues": [
    "已目视核对原页PDF379：沿用Proposition8.2所用括号约定[D,Y]=DY·D-DD·Y，q分量应为-p；整体反号也不能同时保留热浴分量+1。"
  ],
  "statement_scope": "第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。",
  "lean_decl": "MD.Ch08.slsBathNoise",
  "lean_declarations": [
    "MD.Ch08.slsBathNoise",
    "MD.Ch08.slsBracketPrinted",
    "MD.Ch08.slsBracket_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def slsBathNoise : Phase n × ℝ → Phase n × ℝ := fun _ ↦ ((0,0),1)
theorem slsBracketPrinted (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((z.1.2,0),1) := by
  sorry
theorem slsBracket_corrected (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((-z.1.2,0),1) := by
  sorry
```

## MD-8.5-SLSHormander
```json
{
  "source_id": "MD-8.5-SLSHormander",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.5",
  "printed_page": "357–358",
  "pdf_page": "378–379",
  "statement_latex": "All basis vectors are in the Lie algebra generated by the drift and the N_c+1 noise directions, so Hörmander holds.",
  "statement_verbatim": "8.5\nNon-Newtonian Dynamics-Based Iterations for Molecular Sampling\n357\nTable 8.1 Estimated rates of convergence, perturbation growth, and efﬁciency for different\nmethods\nError (to lowest\nThermostat\nConvergence rate\norder in t)\nEfﬁciency\nLangevin\n\n\nt\n\n 1\nVelocity Rescaling\n4\nAvˇfK2˚.K/g\nTNdkB\n2\nNd AvˇfK˚.K/g t\nO .Nd/\nVR with ˚.K/ D \nVR\n2K\n\nVR\n\nVR\nNd t\n\n Nd\nNHL\nq\nNdkBT\n\u0006\nkBT\n2\u0006 t2\n\n 2Nd\n(at critical damping)\n8.5\nNon-Newtonian Dynamics-Based Iterations\nfor Molecular Sampling\nGiven that we can decompose the stochastic dynamics into deterministic part and\nstochastic process, and approximately or exactly solve the parts, it is common\nto iterate the maps for each building block sequentially in such a way that the\ncalculation approximates the dynamics of the system. This is, very likely, an\nunnecessary restriction on the sampling strategy. The crucial things that effect the\nultimate success of the method are that the parts themselves preserve the measure\n(or approximately so), the stages are volume preserving, and that the stochastic\nprocesses are sufﬁciently strongly coupled so that the overall iteration is ergodic.\nThere is essentially no need to use maps based on Newtonian deterministic\ndynamics. There are many alternative dynamics models which leave invariant the\ncanonical measure, going well beyond those considered so far. To illustrate this\nwith one intriguing example, we explore here the stochastic dynamical system in\n2Nc C 1 variables deﬁned by\ndq D \u0012M\u00021pdt;\n(8.33)\ndp D \u0003\npdt C \u0007M1=2dW;\n(8.34)\nd\u0012 D \u0003Œ.M\u00021p/ \u0002 rU.q/=\u0006 C \n0\u0012\tdt C \u00070dZ;\n(8.35)\nwhere W is a vector of Nc Wiener processes, Z is a scalar Wiener process and \u0007 D\np2kBT\n, and \u00070 D\np\n2kBT\n0=\u0006 this system preserves the augmented distribution\nwith density\nQ\u0005.q; p; \u0012/ D e\u0002ˇ.pTM\u00021p=2CU.q/C\u0006\u00122=2/:\nFor this system, it is possible to show that the Hörmander condition holds. Setting all\nparameters to 1 and taking M D I (without loss of generality in this demonstration)\nwe write our SDE in the form d' D D C PNcC1\niD1 YidWi, where ' is the vector of all\nphase variables, Yi D eNcCi, for i D 1; : : : ; Nc C 1, is the i C Ncth basis function in\n\n358\n8\nExtended Variable Methods\nR2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”\nD D\n2\n4\n\u0012p\n\u0003p\n\u0003p \u0002 rU \u0003 \u0012\n3\n5 :\nThen we calculate directly\nD0 D ŒD; YNcC1\t D\n2\n4\np\n0\n1\n3\n5 ;\nand from this we see that ŒD0; Yi\t D ei for i D 1; 2; : : : ; Nc. Thus all the basis\nvectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander\ndecomposition; as we know, this is the key step in the proof of ergodicity. Thus\nthe method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even\nthough it is not based on a Newtonian model. Leaving the stochastic term off the\nﬁnal equation (i.e. in \u0012) is easily shown to destroy the ergodicity property (the\nHörmander condition is then violated).\nNow consider the splitting into deterministic and OU parts. The deterministic\npart\nPq D \u0012M\u00021p;\nPp D 0;\nP\u0012 D \u0003.M\u00021p/ \u0002 rU.q/=\u0006;\n(8.36)\npreserves volume and the function U.q/ C \u0006\u00122=2 and hence also the distribution\nwith density Q\u0005A.q; \u0012/ D e\u0002ˇ.U.q/C\u0006\u00122=2/. By the same token the OU processes\ncollectively preserve Q\u0005B.p; \u0012/ D e\u0002ˇ.pTM\u00021p=2C\u0006\u00122=2/. In combination the full\ndynamics preserves the extended canonical measure. If we iterate the two parts\n(assuming the deterministic part is solved exactly) the distribution will converge\nto the exact canonical distribution, due to especially to incorporation of Nc C1 noise\nprocesses.\nThe OU process deﬁning the ﬂuctuations in p is completely decoupled from q\nand \u0012, so it is perhaps most natural to think of the iteration as a random walk on\nthe reduced space .q; \u0012/ where the directions are generated by an auxiliary OU\nprocess. Then the algorithm proceeds as follows: (1) choose a random direction\np using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; \u0012/\nin the direction p. We refer to this procedure as stochastic line sampling (SLS), for\nthe following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the\nstraight line: q D q0 C \u000fM\u00021p, where \u000f is a scalar function of time. Inserting\nthis coordinate change in (8.36) we see that the equations reduce to P\u000f D \u0012,\nP\u0012 D \u0003@=@\u000fU.q0 C \u000fM\u00021p/. This is a one-degree of freedom system and hence\nis theoretically exactly solvable in quadratures, although the complexity of the force\nwill render this impractical in calculations, and, as mentioned above, an additional\nstochastic process must be incorporated to drive \u0012.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 378,
      "printed_page": 357,
      "text": "8.5\nNon-Newtonian Dynamics-Based Iterations for Molecular Sampling\n357\nTable 8.1 Estimated rates of convergence, perturbation growth, and efﬁciency for different\nmethods\nError (to lowest\nThermostat\nConvergence rate\norder in t)\nEfﬁciency\nLangevin\n\n\nt\n\n 1\nVelocity Rescaling\n4\nAvˇfK2˚.K/g\nTNdkB\n2\nNd AvˇfK˚.K/g t\nO .Nd/\nVR with ˚.K/ D \nVR\n2K\n\nVR\n\nVR\nNd t\n\n Nd\nNHL\nq\nNdkBT\n\u0006\nkBT\n2\u0006 t2\n\n 2Nd\n(at critical damping)\n8.5\nNon-Newtonian Dynamics-Based Iterations\nfor Molecular Sampling\nGiven that we can decompose the stochastic dynamics into deterministic part and\nstochastic process, and approximately or exactly solve the parts, it is common\nto iterate the maps for each building block sequentially in such a way that the\ncalculation approximates the dynamics of the system. This is, very likely, an\nunnecessary restriction on the sampling strategy. The crucial things that effect the\nultimate success of the method are that the parts themselves preserve the measure\n(or approximately so), the stages are volume preserving, and that the stochastic\nprocesses are sufﬁciently strongly coupled so that the overall iteration is ergodic.\nThere is essentially no need to use maps based on Newtonian deterministic\ndynamics. There are many alternative dynamics models which leave invariant the\ncanonical measure, going well beyond those considered so far. To illustrate this\nwith one intriguing example, we explore here the stochastic dynamical system in\n2Nc C 1 variables deﬁned by\ndq D \u0012M\u00021pdt;\n(8.33)\ndp D \u0003\npdt C \u0007M1=2dW;\n(8.34)\nd\u0012 D \u0003Œ.M\u00021p/ \u0002 rU.q/=\u0006 C \n0\u0012\tdt C \u00070dZ;\n(8.35)\nwhere W is a vector of Nc Wiener processes, Z is a scalar Wiener process and \u0007 D\np2kBT\n, and \u00070 D\np\n2kBT\n0=\u0006 this system preserves the augmented distribution\nwith density\nQ\u0005.q; p; \u0012/ D e\u0002ˇ.pTM\u00021p=2CU.q/C\u0006\u00122=2/:\nFor this system, it is possible to show that the Hörmander condition holds. Setting all\nparameters to 1 and taking M D I (without loss of generality in this demonstration)\nwe write our SDE in the form d' D D C PNcC1\niD1 YidWi, where ' is the vector of all\nphase variables, Yi D eNcCi, for i D 1; : : : ; Nc C 1, is the i C Ncth basis function in\n"
    },
    {
      "pdf_page": 379,
      "printed_page": 358,
      "text": "358\n8\nExtended Variable Methods\nR2NcC1, the Wi are independent Wiener processes, and D is the “deterministic part:”\nD D\n2\n4\n\u0012p\n\u0003p\n\u0003p \u0002 rU \u0003 \u0012\n3\n5 :\nThen we calculate directly\nD0 D ŒD; YNcC1\t D\n2\n4\np\n0\n1\n3\n5 ;\nand from this we see that ŒD0; Yi\t D ei for i D 1; 2; : : : ; Nc. Thus all the basis\nvectors of R2NcC1 are found in the Lie algebra of the components of the Hörmander\ndecomposition; as we know, this is the key step in the proof of ergodicity. Thus\nthe method (8.33)–(8.35) is an alternative for molecular sampling dynamics, even\nthough it is not based on a Newtonian model. Leaving the stochastic term off the\nﬁnal equation (i.e. in \u0012) is easily shown to destroy the ergodicity property (the\nHörmander condition is then violated).\nNow consider the splitting into deterministic and OU parts. The deterministic\npart\nPq D \u0012M\u00021p;\nPp D 0;\nP\u0012 D \u0003.M\u00021p/ \u0002 rU.q/=\u0006;\n(8.36)\npreserves volume and the function U.q/ C \u0006\u00122=2 and hence also the distribution\nwith density Q\u0005A.q; \u0012/ D e\u0002ˇ.U.q/C\u0006\u00122=2/. By the same token the OU processes\ncollectively preserve Q\u0005B.p; \u0012/ D e\u0002ˇ.pTM\u00021p=2C\u0006\u00122=2/. In combination the full\ndynamics preserves the extended canonical measure. If we iterate the two parts\n(assuming the deterministic part is solved exactly) the distribution will converge\nto the exact canonical distribution, due to especially to incorporation of Nc C1 noise\nprocesses.\nThe OU process deﬁning the ﬂuctuations in p is completely decoupled from q\nand \u0012, so it is perhaps most natural to think of the iteration as a random walk on\nthe reduced space .q; \u0012/ where the directions are generated by an auxiliary OU\nprocess. Then the algorithm proceeds as follows: (1) choose a random direction\np using the OU process, and (2) sample the reduced (stochastic) dynamics for .q; \u0012/\nin the direction p. We refer to this procedure as stochastic line sampling (SLS), for\nthe following reason. With p ﬁxed in step (2), the motion of q is conﬁned to the\nstraight line: q D q0 C \u000fM\u00021p, where \u000f is a scalar function of time. Inserting\nthis coordinate change in (8.36) we see that the equations reduce to P\u000f D \u0012,\nP\u0012 D \u0003@=@\u000fU.q0 C \u000fM\u00021p/. This is a one-degree of freedom system and hence\nis theoretically exactly solvable in quadratures, although the complexity of the force\nwill render this impractical in calculations, and, as mentioned above, an additional\nstochastic process must be incorporated to drive \u0012.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。"
  ],
  "issues": [],
  "statement_scope": "单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。",
  "lean_decl": "MD.Ch08.slsHormander",
  "lean_declarations": [
    "MD.Ch08.slsHormander"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem slsHormander (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    textbookHormanderAt
      (insert (slsDrift (fun _ ↦ 1) U 1 1 1)
        (Set.range (fun j : Fin (n+1) ↦ fun _ : Phase n × ℝ ↦ slsNoise (fun _ ↦ 1) 2 1 1 1 j))) z := by
  sorry
```
