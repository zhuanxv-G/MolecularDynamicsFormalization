# BATCH01 第8章原文与陈述审校

## MD-8.1-CanonicalCorrelation
```json
{
  "source_id": "MD-8.1-CanonicalCorrelation",
  "kind": "definition",
  "label": null,
  "section": "8.1",
  "printed_page": "329–330",
  "pdf_page": "350–351",
  "statement_latex": "Av_β(φ)=∫φρ_β/∫ρ_β, ρ_β=exp(-βH); C_β(τ)=∫ A(z)·B(F^H_τ(z))ρ_β dω / ∫ A(z)·B(z)ρ_β dω. Thus C(0)=1.",
  "statement_verbatim": "Chapter 8\nExtended Variable Methods\nIn the previous chapter we described numerical methods for solving the equations\nof Langevin dynamics, a system of stochastic differential equations that sample the\ncanonical ensemble. The methods allow us to compute averages of the form\nAvˇ.\b.q; p// D\nR\nD \b.q; p/\u0005ˇ.q; p/d!\nR\nD \u0005ˇ.q; p/d!\n;\nwhere \u0005ˇ D exp.\u0003ˇH/, and H is the system Hamiltonian. In this chapter we\nextend the range of systems that can be used to accomplish this task using methods\nbased on the incorporation of auxiliary variables. We also consider schemes for\nsampling alternative thermodynamic ensembles, for example those deﬁned by\nconstant number of atoms N, pressure P and temperature T. In some of the methods,\nbased on purely deterministic models, the ergodic property may be compromised, so\nan important issue is to design schemes that restore this. We will focus on methods\nthat introduce random processes in direct contact with the auxiliary variables.\nBesides canonical or conﬁgurational sampling, another common purpose of\nmolecular simulation is the calculation of a dynamical (time-dependent) quantity\nsuch as the rearrangement of a molecular group over time or a diffusion rate. The\nonly dynamical calculations that make sense in the context of molecular modelling,\nwhere trajectories are chaotic, are those that involve some sort of average. We\nconsider this average in a thermodynamic sense and assume that the calculation can\nbe formulated as the determination of the canonically weighted correlation between\ntwo quantities evaluated at different times, for example\nCˇ.\u0002/ D\nR\nD A.z/ \u0002 B.F H\n\u0002 .z//\u0005ˇd!\nR\nD A.z/ \u0002 B.z/\u0005ˇd!\n:\n© Springer International Publishing Switzerland 2015\nB. Leimkuhler, C. Matthews, Molecular Dynamics, Interdisciplinary Applied\nMathematics 39, DOI 10.1007/978-3-319-16375-8_8\n329\n\n330\n8\nExtended Variable Methods\nF H\nt represents the ﬂow map of Hamiltonian dynamics. Thus C.0/ D 1. At large \u0002,\nif the system is “mixing,” and loses memory of its starting point, hence\nAvˇ\n\nA.z/ \u0002 B.F H\n\u0002 .z//\n\u000b\n\u0007 Avˇ ŒA.z/\t \u0002 Avˇ ŒB.z/\t\nis approximately independent of \u0002. Thus the correlation should approximately\nvanish at large time, provided the scalar product of the average of A and the aver-\nage B vanishes. Computing an autocorrelation function Cˇ.\u0002/ normally involves\nperforming a stationary thermodynamic calculation in which the observable itself\ndepends on a Hamiltonian dynamics calculation.\nThere is no reason for taking the averages solely with respect to \u0005ˇ. We could\nin effect assume any prior distribution for the initial conditions. Our choice of\nGibbs statistics in deﬁning autocorrelation is made for purely practical reasons—\nit simpliﬁes the study of the problem by allowing us to bring to bear the common\ntechniques of thermodynamic sampling. In some cases, the Gibbs weight is ignored\nand the calculation is performed as an average two point correlation along a single\ntrajectory. In some cases this calculation is performed using a single thermostatted\nmolecular dynamics trajectory. Such a calculation is only justiﬁed when the\nthermostat is “weakly coupled” to the physical system. In this setup, the key to\naccurately computing averaged dynamics of molecular systems is to use thermostat\ntechniques that minimally perturb the physical dynamics. We will brieﬂy discuss\nhow this may be achieved while maintaining the ergodic property.\n8.1\nDynamics-Based Thermostat Techniques\nDeterministic trajectories can sometimes be used to sample the canonical measure.\nA very simple technique of this type is Hamiltonian dynamics itself.\nLet a Hamiltonian H.q; p/ be given and let L be its Liouvillian\nL D rpH \u0002 rq \u0003 rqH \u0002 rp:\nRecall from Chap. 5 that, as the dynamics automatically preserves functions of H,\nthe Liouvillian satisﬁes L'.H/ D 0. We also know that for Hamiltonian dynamics\nL is skew-adjoint, i.e., L\u0004 D \u0003L which implies that L\u0004 .H/ D 0. Hence any\ndensity which is a function of H will be preserved, and this includes the canonical\none .H/ D exp.\u0003ˇH/.\nIf we select a set of points at random from the canonical distribution, then\ninitiate trajectories of Hamiltonian dynamics from each of these points, the points\nwill remain Gibbs-distributed over time. If the paths themselves are ergodic on the\nsurfaces of constant energy H D E then the collection of paths may provide a usable\nsampling of the canonical distribution. Such a sampling technique relies on having\nthe means of choosing initial points from the canonical distribution; as this is the\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 350,
      "printed_page": 329,
      "text": "Chapter 8\nExtended Variable Methods\nIn the previous chapter we described numerical methods for solving the equations\nof Langevin dynamics, a system of stochastic differential equations that sample the\ncanonical ensemble. The methods allow us to compute averages of the form\nAvˇ.\b.q; p// D\nR\nD \b.q; p/\u0005ˇ.q; p/d!\nR\nD \u0005ˇ.q; p/d!\n;\nwhere \u0005ˇ D exp.\u0003ˇH/, and H is the system Hamiltonian. In this chapter we\nextend the range of systems that can be used to accomplish this task using methods\nbased on the incorporation of auxiliary variables. We also consider schemes for\nsampling alternative thermodynamic ensembles, for example those deﬁned by\nconstant number of atoms N, pressure P and temperature T. In some of the methods,\nbased on purely deterministic models, the ergodic property may be compromised, so\nan important issue is to design schemes that restore this. We will focus on methods\nthat introduce random processes in direct contact with the auxiliary variables.\nBesides canonical or conﬁgurational sampling, another common purpose of\nmolecular simulation is the calculation of a dynamical (time-dependent) quantity\nsuch as the rearrangement of a molecular group over time or a diffusion rate. The\nonly dynamical calculations that make sense in the context of molecular modelling,\nwhere trajectories are chaotic, are those that involve some sort of average. We\nconsider this average in a thermodynamic sense and assume that the calculation can\nbe formulated as the determination of the canonically weighted correlation between\ntwo quantities evaluated at different times, for example\nCˇ.\u0002/ D\nR\nD A.z/ \u0002 B.F H\n\u0002 .z//\u0005ˇd!\nR\nD A.z/ \u0002 B.z/\u0005ˇd!\n:\n© Springer International Publishing Switzerland 2015\nB. Leimkuhler, C. Matthews, Molecular Dynamics, Interdisciplinary Applied\nMathematics 39, DOI 10.1007/978-3-319-16375-8_8\n329\n"
    },
    {
      "pdf_page": 351,
      "printed_page": 330,
      "text": "330\n8\nExtended Variable Methods\nF H\nt represents the ﬂow map of Hamiltonian dynamics. Thus C.0/ D 1. At large \u0002,\nif the system is “mixing,” and loses memory of its starting point, hence\nAvˇ\n\nA.z/ \u0002 B.F H\n\u0002 .z//\n\u000b\n\u0007 Avˇ ŒA.z/\t \u0002 Avˇ ŒB.z/\t\nis approximately independent of \u0002. Thus the correlation should approximately\nvanish at large time, provided the scalar product of the average of A and the aver-\nage B vanishes. Computing an autocorrelation function Cˇ.\u0002/ normally involves\nperforming a stationary thermodynamic calculation in which the observable itself\ndepends on a Hamiltonian dynamics calculation.\nThere is no reason for taking the averages solely with respect to \u0005ˇ. We could\nin effect assume any prior distribution for the initial conditions. Our choice of\nGibbs statistics in deﬁning autocorrelation is made for purely practical reasons—\nit simpliﬁes the study of the problem by allowing us to bring to bear the common\ntechniques of thermodynamic sampling. In some cases, the Gibbs weight is ignored\nand the calculation is performed as an average two point correlation along a single\ntrajectory. In some cases this calculation is performed using a single thermostatted\nmolecular dynamics trajectory. Such a calculation is only justiﬁed when the\nthermostat is “weakly coupled” to the physical system. In this setup, the key to\naccurately computing averaged dynamics of molecular systems is to use thermostat\ntechniques that minimally perturb the physical dynamics. We will brieﬂy discuss\nhow this may be achieved while maintaining the ergodic property.\n8.1\nDynamics-Based Thermostat Techniques\nDeterministic trajectories can sometimes be used to sample the canonical measure.\nA very simple technique of this type is Hamiltonian dynamics itself.\nLet a Hamiltonian H.q; p/ be given and let L be its Liouvillian\nL D rpH \u0002 rq \u0003 rqH \u0002 rp:\nRecall from Chap. 5 that, as the dynamics automatically preserves functions of H,\nthe Liouvillian satisﬁes L'.H/ D 0. We also know that for Hamiltonian dynamics\nL is skew-adjoint, i.e., L\u0004 D \u0003L which implies that L\u0004 .H/ D 0. Hence any\ndensity which is a function of H will be preserved, and this includes the canonical\none .H/ D exp.\u0003ˇH/.\nIf we select a set of points at random from the canonical distribution, then\ninitiate trajectories of Hamiltonian dynamics from each of these points, the points\nwill remain Gibbs-distributed over time. If the paths themselves are ergodic on the\nsurfaces of constant energy H D E then the collection of paths may provide a usable\nsampling of the canonical distribution. Such a sampling technique relies on having\nthe means of choosing initial points from the canonical distribution; as this is the\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "相关分母非零才有C(0)=1；向量观测的点积由标量乘积表示，其余分量情形未展开。"
  ],
  "issues": [],
  "statement_scope": "规范平均、标量相关函数及零时归一；混合时的大时间极限定性说明另列。",
  "lean_decl": "MD.Ch08.Vec",
  "lean_declarations": [
    "MD.Ch08.Vec",
    "MD.Ch08.Phase",
    "MD.Ch08.dot",
    "MD.Ch08.gradient",
    "MD.Ch08.gibbsWeight",
    "MD.Ch08.canonicalAverage",
    "MD.Ch08.probabilityDensity",
    "MD.Ch08.correlation",
    "MD.Ch08.correlation_zero"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev Vec (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := Vec n × Vec n
def dot (v w : Vec n) : ℝ := ∑ i, v i * w i
def gradient (U : Vec n → ℝ) (q : Vec n) : Vec n := fun i ↦ fderiv ℝ U q (Pi.single i 1)
def gibbsWeight {E : Type*} (H : E → ℝ) (β : ℝ) (z : E) : ℝ := Real.exp (-β * H z)
def canonicalAverage {E : Type*} [MeasurableSpace E] (μ : Measure E)
    (ρ g : E → ℝ) : ℝ := (∫ z, g z * ρ z ∂μ) / ∫ z, ρ z ∂μ
def probabilityDensity {E : Type*} [MeasurableSpace E] (μ : Measure E) (ρ : E → ℝ) : Prop :=
  (∀ z, 0 ≤ ρ z) ∧ Integrable ρ μ ∧ ∫ z, ρ z ∂μ = 1
def correlation {E : Type*} [MeasurableSpace E] (μ : Measure E) (ρ A B : E → ℝ)
    (flow : ℝ → E → E) (t : ℝ) : ℝ :=
  (∫ z, A z * B (flow t z) * ρ z ∂μ) / ∫ z, A z * B z * ρ z ∂μ
theorem correlation_zero {E : Type*} [MeasurableSpace E] (μ : Measure E)
    (ρ A B : E → ℝ) (flow : ℝ → E → E) (h0 : flow 0 = id)
    (hden : (∫ z, A z * B z * ρ z ∂μ) ≠ 0) : correlation μ ρ A B flow 0 = 1 := by
  simp [correlation, h0, hden]
```

## MD-8.1-HamiltonianStationary
```json
{
  "source_id": "MD-8.1-HamiltonianStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1",
  "printed_page": "330",
  "pdf_page": "351",
  "statement_latex": "The Liouvillian satisfies Lφ(H)=0; L is skew-adjoint. Hence any density which is a function of H will be preserved, including exp(-βH).",
  "statement_verbatim": "330\n8\nExtended Variable Methods\nF H\nt represents the ﬂow map of Hamiltonian dynamics. Thus C.0/ D 1. At large \u0002,\nif the system is “mixing,” and loses memory of its starting point, hence\nAvˇ\n\nA.z/ \u0002 B.F H\n\u0002 .z//\n\u000b\n\u0007 Avˇ ŒA.z/\t \u0002 Avˇ ŒB.z/\t\nis approximately independent of \u0002. Thus the correlation should approximately\nvanish at large time, provided the scalar product of the average of A and the aver-\nage B vanishes. Computing an autocorrelation function Cˇ.\u0002/ normally involves\nperforming a stationary thermodynamic calculation in which the observable itself\ndepends on a Hamiltonian dynamics calculation.\nThere is no reason for taking the averages solely with respect to \u0005ˇ. We could\nin effect assume any prior distribution for the initial conditions. Our choice of\nGibbs statistics in deﬁning autocorrelation is made for purely practical reasons—\nit simpliﬁes the study of the problem by allowing us to bring to bear the common\ntechniques of thermodynamic sampling. In some cases, the Gibbs weight is ignored\nand the calculation is performed as an average two point correlation along a single\ntrajectory. In some cases this calculation is performed using a single thermostatted\nmolecular dynamics trajectory. Such a calculation is only justiﬁed when the\nthermostat is “weakly coupled” to the physical system. In this setup, the key to\naccurately computing averaged dynamics of molecular systems is to use thermostat\ntechniques that minimally perturb the physical dynamics. We will brieﬂy discuss\nhow this may be achieved while maintaining the ergodic property.\n8.1\nDynamics-Based Thermostat Techniques\nDeterministic trajectories can sometimes be used to sample the canonical measure.\nA very simple technique of this type is Hamiltonian dynamics itself.\nLet a Hamiltonian H.q; p/ be given and let L be its Liouvillian\nL D rpH \u0002 rq \u0003 rqH \u0002 rp:\nRecall from Chap. 5 that, as the dynamics automatically preserves functions of H,\nthe Liouvillian satisﬁes L'.H/ D 0. We also know that for Hamiltonian dynamics\nL is skew-adjoint, i.e., L\u0004 D \u0003L which implies that L\u0004 .H/ D 0. Hence any\ndensity which is a function of H will be preserved, and this includes the canonical\none .H/ D exp.\u0003ˇH/.\nIf we select a set of points at random from the canonical distribution, then\ninitiate trajectories of Hamiltonian dynamics from each of these points, the points\nwill remain Gibbs-distributed over time. If the paths themselves are ergodic on the\nsurfaces of constant energy H D E then the collection of paths may provide a usable\nsampling of the canonical distribution. Such a sampling technique relies on having\nthe means of choosing initial points from the canonical distribution; as this is the\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 351,
      "printed_page": 330,
      "text": "330\n8\nExtended Variable Methods\nF H\nt represents the ﬂow map of Hamiltonian dynamics. Thus C.0/ D 1. At large \u0002,\nif the system is “mixing,” and loses memory of its starting point, hence\nAvˇ\n\nA.z/ \u0002 B.F H\n\u0002 .z//\n\u000b\n\u0007 Avˇ ŒA.z/\t \u0002 Avˇ ŒB.z/\t\nis approximately independent of \u0002. Thus the correlation should approximately\nvanish at large time, provided the scalar product of the average of A and the aver-\nage B vanishes. Computing an autocorrelation function Cˇ.\u0002/ normally involves\nperforming a stationary thermodynamic calculation in which the observable itself\ndepends on a Hamiltonian dynamics calculation.\nThere is no reason for taking the averages solely with respect to \u0005ˇ. We could\nin effect assume any prior distribution for the initial conditions. Our choice of\nGibbs statistics in deﬁning autocorrelation is made for purely practical reasons—\nit simpliﬁes the study of the problem by allowing us to bring to bear the common\ntechniques of thermodynamic sampling. In some cases, the Gibbs weight is ignored\nand the calculation is performed as an average two point correlation along a single\ntrajectory. In some cases this calculation is performed using a single thermostatted\nmolecular dynamics trajectory. Such a calculation is only justiﬁed when the\nthermostat is “weakly coupled” to the physical system. In this setup, the key to\naccurately computing averaged dynamics of molecular systems is to use thermostat\ntechniques that minimally perturb the physical dynamics. We will brieﬂy discuss\nhow this may be achieved while maintaining the ergodic property.\n8.1\nDynamics-Based Thermostat Techniques\nDeterministic trajectories can sometimes be used to sample the canonical measure.\nA very simple technique of this type is Hamiltonian dynamics itself.\nLet a Hamiltonian H.q; p/ be given and let L be its Liouvillian\nL D rpH \u0002 rq \u0003 rqH \u0002 rp:\nRecall from Chap. 5 that, as the dynamics automatically preserves functions of H,\nthe Liouvillian satisﬁes L'.H/ D 0. We also know that for Hamiltonian dynamics\nL is skew-adjoint, i.e., L\u0004 D \u0003L which implies that L\u0004 .H/ D 0. Hence any\ndensity which is a function of H will be preserved, and this includes the canonical\none .H/ D exp.\u0003ˇH/.\nIf we select a set of points at random from the canonical distribution, then\ninitiate trajectories of Hamiltonian dynamics from each of these points, the points\nwill remain Gibbs-distributed over time. If the paths themselves are ergodic on the\nsurfaces of constant energy H D E then the collection of paths may provide a usable\nsampling of the canonical distribution. Such a sampling technique relies on having\nthe means of choosing initial points from the canonical distribution; as this is the\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "只桥接光滑Hamiltonian的Gibbs权重驻定方程；一般φ(H)、算子偏斜伴随及流的保测性未由本条覆盖。"
  ],
  "issues": [],
  "statement_scope": "光滑Hamiltonian Gibbs权重的Liouville驻定方程；其余三项列覆盖缺口。",
  "lean_decl": "MD.Ch08.hamiltonianField",
  "lean_declarations": [
    "MD.Ch08.hamiltonianField",
    "MD.Ch08.hamiltonianGibbsStationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": [
    "textbookHamiltonianGibbsWeight_stationary"
  ]
}
```
```lean
def hamiltonianField (invm : Vec n) (U : Vec n → ℝ) (z : Phase n) : Phase n :=
  (fun i ↦ invm i * z.2 i, fun i ↦ - gradient U z.1 i)
theorem hamiltonianGibbsStationary (H : SymplecticCoordinates n → ℝ)
    (β : ℝ) (hH : ContDiff ℝ 2 H) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H)
      (textbookHamiltonianGibbsWeight H β) := by
  exact textbookHamiltonianGibbsWeight_stationary hH β
```

## MD-8.1-ExtendedDensity
```json
{
  "source_id": "MD-8.1-ExtendedDensity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1",
  "printed_page": "331",
  "pdf_page": "352",
  "statement_latex": "ρ̃(q,p,ξ)=ρ_β(q,p)ρ̂(ξ). Then ∫g(q,p)ρ̃ ∝ ∫g(q,p)ρ_β.",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n331\npurpose of the sampling strategy itself, the method of sampling by Hamiltonian\ntrajectories seems less than robust.\nAlternative families of methods exist which are based on extending the phase\nspace of the system in such a way as to (a) disturb the conserved quantity H D\nE, while (b) nonetheless preserving the phase space distribution. In general these\nmethods involve introducing additional variables \u0002 D .\u00121; \u00122; : : : ; \u0012k/ and additional\nequations of motion to drive them. The combined system is carefully designed to\npreserve an extended invariant distribution\nQ\u0005.q; p; \u0002/ D \u0005ˇ.q; p/ \u0004 O\u0005.\u0002/;\n(8.1)\nwhere the auxiliary density O\u0005 has a simple form (typically, a multivariate Gaussian).\nThen it follows that\nZ Z Z\ng.q; p/ Q\u0005.q; p; \u0002/d!qd!pdk\u0002 /\nZ Z\ng.q; p/\u0005ˇ.q; p/d!qd!p:\nAssuming ergodicity of the coupled system it is then possible to calculate averages\nwith respect to the Gibbs-Boltzmann measure by direct averaging along trajectories\nof the extended system.\nThe assumption of ergodicity is a major one (just as difﬁcult to demonstrate\nas would be the corresponding assumption for a Hamiltonian system); indeed\nit is likely that it fails generically, and there are certainly known cases where\nthermodynamic averages computed using deterministic thermostats are incorrect.\nHowever, deterministic methods are nonetheless often used in molecular simulation,\nsuggesting that, for the systems involved, averages can be recovered with sufﬁcient\naccuracy starting from most points of phase space.\n8.1.1\nNosé Dynamics: A Deterministic Thermostat\nThe simplest scheme of this type is the Nosé-Hoover method [182, 284–286]. There\nis just one auxiliary variable \u0012 and the extended system takes the form\ndq\ndt D M\u00021p;\n(8.2)\ndp\ndt D \u0003rU.q/ \u0003 \u0012p;\n(8.3)\n\u0006d\u0012\ndt D pTM\u00021p \u0003 Ndˇ\u00021:\n(8.4)\nWe have deliberately written Nd. The number of degrees of freedom in the last\nequation must be used so that the equation is in balance at thermal equilibrium.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 352,
      "printed_page": 331,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n331\npurpose of the sampling strategy itself, the method of sampling by Hamiltonian\ntrajectories seems less than robust.\nAlternative families of methods exist which are based on extending the phase\nspace of the system in such a way as to (a) disturb the conserved quantity H D\nE, while (b) nonetheless preserving the phase space distribution. In general these\nmethods involve introducing additional variables \u0002 D .\u00121; \u00122; : : : ; \u0012k/ and additional\nequations of motion to drive them. The combined system is carefully designed to\npreserve an extended invariant distribution\nQ\u0005.q; p; \u0002/ D \u0005ˇ.q; p/ \u0004 O\u0005.\u0002/;\n(8.1)\nwhere the auxiliary density O\u0005 has a simple form (typically, a multivariate Gaussian).\nThen it follows that\nZ Z Z\ng.q; p/ Q\u0005.q; p; \u0002/d!qd!pdk\u0002 /\nZ Z\ng.q; p/\u0005ˇ.q; p/d!qd!p:\nAssuming ergodicity of the coupled system it is then possible to calculate averages\nwith respect to the Gibbs-Boltzmann measure by direct averaging along trajectories\nof the extended system.\nThe assumption of ergodicity is a major one (just as difﬁcult to demonstrate\nas would be the corresponding assumption for a Hamiltonian system); indeed\nit is likely that it fails generically, and there are certainly known cases where\nthermodynamic averages computed using deterministic thermostats are incorrect.\nHowever, deterministic methods are nonetheless often used in molecular simulation,\nsuggesting that, for the systems involved, averages can be recovered with sufﬁcient\naccuracy starting from most points of phase space.\n8.1.1\nNosé Dynamics: A Deterministic Thermostat\nThe simplest scheme of this type is the Nosé-Hoover method [182, 284–286]. There\nis just one auxiliary variable \u0012 and the extended system takes the form\ndq\ndt D M\u00021p;\n(8.2)\ndp\ndt D \u0003rU.q/ \u0003 \u0012p;\n(8.3)\n\u0006d\u0012\ndt D pTM\u00021p \u0003 Ndˇ\u00021:\n(8.4)\nWe have deliberately written Nd. The number of degrees of freedom in the last\nequation must be used so that the equation is in balance at thermal equilibrium.\n"
    }
  ],
  "numbered_equations": [
    "8.1"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "辅助密度归一、乘积积分可积；使用有限/σ有限测度条件。"
  ],
  "issues": [],
  "statement_scope": "乘积权定义及辅助因子积分为1时的边缘积分等式；不额外证明概率正性或一般流不变性。",
  "lean_decl": "MD.Ch08.extendedDensity",
  "lean_declarations": [
    "MD.Ch08.extendedDensity",
    "MD.Ch08.extendedAverage"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def extendedDensity {E B : Type*} (ρ : E → ℝ) (a : B → ℝ) (z : E × B) : ℝ := ρ z.1 * a z.2
theorem extendedAverage {E B : Type*} [MeasurableSpace E] [MeasurableSpace B]
    (μ : Measure E) (ν : Measure B) [SFinite μ] [SFinite ν]
    (ρ g : E → ℝ) (a : B → ℝ) (ha : ∫ y, a y ∂ν = 1)
    (hi : Integrable (fun z : E × B ↦ g z.1 * extendedDensity ρ a z) (μ.prod ν)) :
    (∫ z, g z.1 * extendedDensity ρ a z ∂μ.prod ν) = ∫ x, g x * ρ x ∂μ := by
  calc
    _ = (∫ x, g x * ρ x ∂μ) * ∫ y, a y ∂ν := by
      simpa only [extendedDensity, mul_assoc] using
        (integral_prod_mul (μ:=μ) (ν:=ν) (fun x ↦ g x * ρ x) a)
    _ = _ := by rw [ha, mul_one]
```

## MD-8.1.1-NoseHoover
```json
{
  "source_id": "MD-8.1.1-NoseHoover",
  "kind": "definition",
  "label": null,
  "section": "8.1.1",
  "printed_page": "331",
  "pdf_page": "352",
  "statement_latex": "q̇=M⁻¹p, ṗ=-∇U(q)-ξp, μξ̇=pᵀM⁻¹p-N_dβ⁻¹.",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n331\npurpose of the sampling strategy itself, the method of sampling by Hamiltonian\ntrajectories seems less than robust.\nAlternative families of methods exist which are based on extending the phase\nspace of the system in such a way as to (a) disturb the conserved quantity H D\nE, while (b) nonetheless preserving the phase space distribution. In general these\nmethods involve introducing additional variables \u0002 D .\u00121; \u00122; : : : ; \u0012k/ and additional\nequations of motion to drive them. The combined system is carefully designed to\npreserve an extended invariant distribution\nQ\u0005.q; p; \u0002/ D \u0005ˇ.q; p/ \u0004 O\u0005.\u0002/;\n(8.1)\nwhere the auxiliary density O\u0005 has a simple form (typically, a multivariate Gaussian).\nThen it follows that\nZ Z Z\ng.q; p/ Q\u0005.q; p; \u0002/d!qd!pdk\u0002 /\nZ Z\ng.q; p/\u0005ˇ.q; p/d!qd!p:\nAssuming ergodicity of the coupled system it is then possible to calculate averages\nwith respect to the Gibbs-Boltzmann measure by direct averaging along trajectories\nof the extended system.\nThe assumption of ergodicity is a major one (just as difﬁcult to demonstrate\nas would be the corresponding assumption for a Hamiltonian system); indeed\nit is likely that it fails generically, and there are certainly known cases where\nthermodynamic averages computed using deterministic thermostats are incorrect.\nHowever, deterministic methods are nonetheless often used in molecular simulation,\nsuggesting that, for the systems involved, averages can be recovered with sufﬁcient\naccuracy starting from most points of phase space.\n8.1.1\nNosé Dynamics: A Deterministic Thermostat\nThe simplest scheme of this type is the Nosé-Hoover method [182, 284–286]. There\nis just one auxiliary variable \u0012 and the extended system takes the form\ndq\ndt D M\u00021p;\n(8.2)\ndp\ndt D \u0003rU.q/ \u0003 \u0012p;\n(8.3)\n\u0006d\u0012\ndt D pTM\u00021p \u0003 Ndˇ\u00021:\n(8.4)\nWe have deliberately written Nd. The number of degrees of freedom in the last\nequation must be used so that the equation is in balance at thermal equilibrium.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 352,
      "printed_page": 331,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n331\npurpose of the sampling strategy itself, the method of sampling by Hamiltonian\ntrajectories seems less than robust.\nAlternative families of methods exist which are based on extending the phase\nspace of the system in such a way as to (a) disturb the conserved quantity H D\nE, while (b) nonetheless preserving the phase space distribution. In general these\nmethods involve introducing additional variables \u0002 D .\u00121; \u00122; : : : ; \u0012k/ and additional\nequations of motion to drive them. The combined system is carefully designed to\npreserve an extended invariant distribution\nQ\u0005.q; p; \u0002/ D \u0005ˇ.q; p/ \u0004 O\u0005.\u0002/;\n(8.1)\nwhere the auxiliary density O\u0005 has a simple form (typically, a multivariate Gaussian).\nThen it follows that\nZ Z Z\ng.q; p/ Q\u0005.q; p; \u0002/d!qd!pdk\u0002 /\nZ Z\ng.q; p/\u0005ˇ.q; p/d!qd!p:\nAssuming ergodicity of the coupled system it is then possible to calculate averages\nwith respect to the Gibbs-Boltzmann measure by direct averaging along trajectories\nof the extended system.\nThe assumption of ergodicity is a major one (just as difﬁcult to demonstrate\nas would be the corresponding assumption for a Hamiltonian system); indeed\nit is likely that it fails generically, and there are certainly known cases where\nthermodynamic averages computed using deterministic thermostats are incorrect.\nHowever, deterministic methods are nonetheless often used in molecular simulation,\nsuggesting that, for the systems involved, averages can be recovered with sufﬁcient\naccuracy starting from most points of phase space.\n8.1.1\nNosé Dynamics: A Deterministic Thermostat\nThe simplest scheme of this type is the Nosé-Hoover method [182, 284–286]. There\nis just one auxiliary variable \u0012 and the extended system takes the form\ndq\ndt D M\u00021p;\n(8.2)\ndp\ndt D \u0003rU.q/ \u0003 \u0012p;\n(8.3)\n\u0006d\u0012\ndt D pTM\u00021p \u0003 Ndˇ\u00021:\n(8.4)\nWe have deliberately written Nd. The number of degrees of freedom in the last\nequation must be used so that the equation is in balance at thermal equilibrium.\n"
    }
  ],
  "numbered_equations": [
    "8.2",
    "8.3",
    "8.4"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "μ记为Q且Q>0，β>0，正质量，热浴变量ξ∈ℝ；总函数nhField配合资格谓词使用。"
  ],
  "issues": [],
  "statement_scope": "正参数资格、动能平方和、NH实际向量场及全实时间ODE规格。",
  "lean_decl": "MD.Ch08.thermostatParameters",
  "lean_declarations": [
    "MD.Ch08.thermostatParameters",
    "MD.Ch08.kineticTwice",
    "MD.Ch08.nhField",
    "MD.Ch08.isNHSolution"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def thermostatParameters (invm : Vec n) (β Q : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < β ∧ 0 < Q
def kineticTwice (invm p : Vec n) : ℝ := ∑ i, invm i * p i ^ 2
def nhField (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ invm i * z.1.2 i, fun i ↦ -gradient U z.1.1 i - z.2 * z.1.2 i),
   (kineticTwice invm z.1.2 - (n : ℝ)/β)/Q)
def isNHSolution (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (z : ℝ → Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ ∀ t, HasDerivAt z (nhField invm U β Q (z t)) t
```

## MD-8.1.1-NHDensitySplit
```json
{
  "source_id": "MD-8.1.1-NHDensitySplit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1.1",
  "printed_page": "332",
  "pdf_page": "353",
  "statement_latex": "ρ̃=ρ_β exp(-βμξ²/2); f=f₁+f₂, L_f†=L_f₁†+L_f₂†; f₂ preserves ρ̃.",
  "statement_verbatim": "332\n8\nExtended Variable Methods\nThe equation for the variable \u0012 represents a negative feedback loop which acts\nto control the value of \u0012 (and hence to regulate the kinetic energy). When the\ntemperature of the system, measured as the average kinetic energy per degree of\nfreedom, is high compared to the “target temperature” ˇ\u00021, the control equation\nwill insure that \u0012 increases, eventually becoming positive. This will damp (cool)\nthe physical variables; eventually the kinetic energy will fall below the target value,\nand \u0012 will become negative. By ﬂuctuating in this way, \u0012 typically maintains the\ntime-averaged kinetic energy of the system at very near Ndˇ\u00021=2.\nThe parameter \u00060 is arbitrary and can be used to improve the performance of the\nmethod in practical calculations.\nThis method preserves an extended measure with density of the form\nQ\u0005.q; p; \u0012/ D \u0005ˇ.q; p/ \u0004 e\u0002ˇ\u0006\u00122=2:\n(8.5)\nThat is, one can show that L\u0004\nf Q\u0005 D 0, where f is the full vector ﬁeld associated to the\nNosé-Hoover system.\nObserve that we can split f into two parts: f D f 1 C f 2, where\nf 1 D\n2\n4\nM\u00021p\n\u0003rU.q/\n0\n3\n5 ;\nf 2 D\n2\n4\n0\n\u0003\u0012p\n\u0006\u00021.pTM\u00021p \u0003 Ndˇ\u00021/\n3\n5 :\nThe Liouvillian1 follows a similar decomposition:\nL\u0004\nf D L\u0004\nf1 C L\u0004\nf2:\nSince the ﬁrst part (which is simply Hamiltonian dynamics) preserves the extended\nGibbs measure Q\u0005, it is evidently enough to show that the system\ndp\ndt D \u0003\u0012p;\n(8.6)\n\u0006d\u0012\ndt D pTM\u00021p \u0003 Ndˇ\u00021;\n(8.7)\npreserves Q\u0005 as well. The Liouvillian L\u0004\nf 2 associated to this system is deﬁned by\nL\u0004\nf2\b D rp \u0002 .\u0012p\b/ \u0003 @\n@\u0012 .\u0006\u00021ŒpTM\u00021p \u0003 Ndˇ\u00021\t\b/:\nIt is left as an exercise to demonstrate that, with this deﬁnition and (8.5), L\u0004\nf2 Q\u0005ˇ D 0.\n1Technically, “Liouville’s equation” refers to the continuity equation in the setting of a volume\npreserving ﬂow. Here we use the term “Liouvillian” to refer to the operator whose action on a\ndensity gives the right hand side of the general continuity equation.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 353,
      "printed_page": 332,
      "text": "332\n8\nExtended Variable Methods\nThe equation for the variable \u0012 represents a negative feedback loop which acts\nto control the value of \u0012 (and hence to regulate the kinetic energy). When the\ntemperature of the system, measured as the average kinetic energy per degree of\nfreedom, is high compared to the “target temperature” ˇ\u00021, the control equation\nwill insure that \u0012 increases, eventually becoming positive. This will damp (cool)\nthe physical variables; eventually the kinetic energy will fall below the target value,\nand \u0012 will become negative. By ﬂuctuating in this way, \u0012 typically maintains the\ntime-averaged kinetic energy of the system at very near Ndˇ\u00021=2.\nThe parameter \u00060 is arbitrary and can be used to improve the performance of the\nmethod in practical calculations.\nThis method preserves an extended measure with density of the form\nQ\u0005.q; p; \u0012/ D \u0005ˇ.q; p/ \u0004 e\u0002ˇ\u0006\u00122=2:\n(8.5)\nThat is, one can show that L\u0004\nf Q\u0005 D 0, where f is the full vector ﬁeld associated to the\nNosé-Hoover system.\nObserve that we can split f into two parts: f D f 1 C f 2, where\nf 1 D\n2\n4\nM\u00021p\n\u0003rU.q/\n0\n3\n5 ;\nf 2 D\n2\n4\n0\n\u0003\u0012p\n\u0006\u00021.pTM\u00021p \u0003 Ndˇ\u00021/\n3\n5 :\nThe Liouvillian1 follows a similar decomposition:\nL\u0004\nf D L\u0004\nf1 C L\u0004\nf2:\nSince the ﬁrst part (which is simply Hamiltonian dynamics) preserves the extended\nGibbs measure Q\u0005, it is evidently enough to show that the system\ndp\ndt D \u0003\u0012p;\n(8.6)\n\u0006d\u0012\ndt D pTM\u00021p \u0003 Ndˇ\u00021;\n(8.7)\npreserves Q\u0005 as well. The Liouvillian L\u0004\nf 2 associated to this system is deﬁned by\nL\u0004\nf2\b D rp \u0002 .\u0012p\b/ \u0003 @\n@\u0012 .\u0006\u00021ŒpTM\u00021p \u0003 Ndˇ\u00021\t\b/:\nIt is left as an exercise to demonstrate that, with this deﬁnition and (8.5), L\u0004\nf2 Q\u0005ˇ D 0.\n1Technically, “Liouville’s equation” refers to the continuity equation in the setting of a volume\npreserving ﬂow. Here we use the term “Liouvillian” to refer to the operator whose action on a\ndensity gives the right hand side of the general continuity equation.\n"
    }
  ],
  "numbered_equations": [
    "8.5",
    "8.6",
    "8.7"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "指数为未归一权重；若称概率密度还要求有限正配分积分并归一化。"
  ],
  "issues": [],
  "statement_scope": "权重、分裂及完整场驻定；伴随算子分裂可由散度线性导出但未另作声明。",
  "lean_decl": "MD.Ch08.nhWeight",
  "lean_declarations": [
    "MD.Ch08.nhWeight",
    "MD.Ch08.nhBathField",
    "MD.Ch08.nhField_split",
    "MD.Ch08.nhWeight_stationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhWeight (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β * (kineticTwice invm z.1.2 / 2 + U z.1.1 + Q*z.2^2/2))
def nhBathField (invm : Vec n) (β Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((0, fun i ↦ -z.2 * z.1.2 i), (kineticTwice invm z.1.2 - (n : ℝ)/β)/Q)
theorem nhField_split (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) :
  nhField invm U β Q z = (hamiltonianField invm U z.1, (0 : ℝ)) + nhBathField invm β Q z := by
  ext <;> simp [nhField, hamiltonianField, nhBathField, sub_eq_add_neg]
theorem nhWeight_stationary (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhField invm U β Q) (nhWeight invm U β Q) := by
  sorry
```

## MD-8.1.1-NHFirstIntegralPrinted
```json
{
  "source_id": "MD-8.1.1-NHFirstIntegralPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.1.1",
  "printed_page": "333",
  "pdf_page": "354",
  "statement_latex": "ds/dt=ξ. I_NH=H+μξ²/2+N_dβ⁻¹ ln s is conserved.",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 354,
      "printed_page": 333,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n333\nLet a further dynamical variable s be deﬁned by\nds\ndt D \u0012:\nThe extended Nosé-Hoover system then has a conserved quantity (see Exercise 2):\nINH.q; p; \u0012; s/ D H.q; p/ C \u0006\u00122\n2\nC Ndˇ\u00021 ln s:\n(8.8)\nThis integral can be used to monitor the performance of numerical methods.\n8.1.2\nNumerical Methods for Extended System Thermostats\nWe next describe some numerical procedures (based on the concept of splitting\nintroduced in Chaps. 2 and 3) which are appropriate for thermostats based on the\nincorporation of auxiliary variables.\nNosé-Hoover dynamics is not a Hamiltonian system, despite the presence of the\nmentioned ﬁrst integral. It is, however, time-reversible: changing the sign of p and\n\u0012 simultaneously in the equations of motion is equivalent to reversing the arrow of\ntime t ! \u0003t. For this reason, time-reversible numerical methods are often proposed\nfor Nosé-Hoover. A typical integrator is described below.\nTo simplify the notation and to use a format that might more closely match what\nwould be implemented in software, we write the algorithm for a single timestep of\nthe method in which positions, momenta and auxiliary variables are updated in situ.\nNosé-Hoover Timestep Map\nq :D q C .h=2/M\u00021p\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\n\u0012 :D \u0012 C h\u0006\u00021 \npTM\u00021p \u0003 NdkBT\n\u000b\np :D e\u0002h\u0012=2p \u0003 c.h=2; \u0012/rU.q/\nq :D q C .h=2/M\u00021p\nHere we have solved successively, the ﬁrst, second and third equations, sequen-\ntially, and then in reverse order to make a symmetric (and second order) integrator.\nThe auxiliary function involved c.t; \u0012/ D 1\u0002e\u0002t\u0012\n\u0012\nis easily evaluated from a few terms\nof its Maclaurin series expansion\nc.t; \u0012/ D t \u0003 t2\u0012=2 C : : :\nIt is easy to verify that this method is time-reversible. If we write the timestep map\nas .q; p; \u0012/ 7! Gh.q; p; \u0012/, then we may check that\nR ı Gh ı R D G \u00021\nh ;\nR.q; p; \u0012/ D .q; \u0003p; \u0003\u0012/:\n"
    }
  ],
  "numbered_equations": [
    "8.8"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "s>0；原文版不证明，修正版另列；两版均保留原文H形式。"
  ],
  "issues": [
    "已目视核对原页PDF354：上行ds/dt=ξ，与(8.8)的ln s不相容；改为ds/dt=sξ（亦见PDF356和Exercise2）。"
  ],
  "statement_scope": "第一积分候选、原印s导数与修正s导数各自对应的沿解零导数目标；原印版不证。",
  "lean_decl": "MD.Ch08.nhIntegral",
  "lean_declarations": [
    "MD.Ch08.nhIntegral",
    "MD.Ch08.nhIntegralPrinted",
    "MD.Ch08.nhIntegral_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nhIntegral (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ) (z : Phase n × ℝ) (s : ℝ) : ℝ :=
  kineticTwice invm z.1.2 / 2 + U z.1.1 + Q*z.2^2/2 + (n : ℝ)/β*Real.log s
theorem nhIntegralPrinted (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U)
    (z : ℝ → Phase n × ℝ) (s : ℝ → ℝ) (hz : isNHSolution invm U β Q z)
    (hs : ∀ t, HasDerivAt s (z t).2 t) (hpos : ∀ t, 0 < s t) :
    ∀ t, HasDerivAt (fun r ↦ nhIntegral invm U β Q (z r) (s r)) 0 t := by
  sorry
theorem nhIntegral_corrected (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U)
    (z : ℝ → Phase n × ℝ) (s : ℝ → ℝ) (hz : isNHSolution invm U β Q z)
    (hs : ∀ t, HasDerivAt s (s t * (z t).2) t) (hpos : ∀ t, 0 < s t) :
    ∀ t, HasDerivAt (fun r ↦ nhIntegral invm U β Q (z r) (s r)) 0 t := by
  sorry
```
