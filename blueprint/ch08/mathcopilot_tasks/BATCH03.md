# BATCH03 第8章原文与陈述审校

## MD-8.1.2.1-NPShadowDensity
```json
{
  "source_id": "MD-8.1.2.1-NPShadowDensity",
  "kind": "definition",
  "label": null,
  "section": "8.1.2.1",
  "printed_page": "335",
  "pdf_page": "356",
  "statement_latex": "H̃_h=H_NP+h²H_[2]+O(h⁴); ρ̃=ρ_βζ(q,p,h)+O(h⁴). Canonical averages are approximated by (ν+1)⁻¹Σg_nζ_n⁻¹+O(h⁴).",
  "statement_verbatim": "8.1\nDynamics-Based Thermostat Techniques\n335\nThe relation between (8.10)–(8.13) and (8.2)–(8.4) becomes evident through the\nsubstitution p D Qp=s and \u0012 D ps=\u0006. Then (8.10)–(8.11) are seen to be the same\nas the corresponding equations in the Nosé-Hoover method, and the ﬁnal pair of\nequations become\nd\ndts D s\u0012;\nd\ndt\u0012 D 1\n\u0006\n\u0004\npTM\u00021p \u0003 NdkBT \u0003 \u0016HN\n\u0005\n:\nThe only difference between the last equation and (8.4) lies in the perturbation\n\u0006\u00021\u0016HN, which is zero along the exact solution. Under discretization, however,\nwe do not expect \u0016HN to vanish, so trajectories obtained from Nosé-Poincaré and\nNosé-Hoover will differ considerably over long time simulations.\nA beneﬁt of respecting the symplectic structure lies in the prospect of using\nbackward error analysis to analyze the behavior of the method. As shown in [40] it\nis possible to work out the terms of the perturbative expansion of the Nosé-Poincaré\nHamiltonian, i.e. to calculate the expansion\nQHh D HNP C h2HŒ2\t C O.h4/\nfor a second order, symmetric, symplectic numerical method. Then one may\ndetermine the effective distribution associated to the symplectic discretization\nmethod by “integrating out” the microcanonical density with respect to the auxiliary\nvariable and its conjugate momentum. One obtains in this way\nQ\u0005 .q; p/ D \u0005ˇ.q; p/\u0018.q; p; h/ C O\n\u0004\nh4\u0005\n:\nAn explicit formula for \u0018 is given in [40] for several symplectic methods. During\nsimulation, one may calculate the factor \u0018 and use this quantity to adjust averages.\nFor example, if we wish to calculate the average of a function g.q; p/, we may\nperform the calculation using \u0003 steps of the Nosé-Poincaré method with the given\nsymplectic, time-reversible, second order integrator, calculate gn and \u0018n at each\ntimestep, and approximate the canonical average from\nhgi D\n1\n\u0003 C 1\n\u0003\nX\nnD0\ngn\u0018\u00021\nn\nC O.h4/:\nFor further details, refer to [40]. Technically, a similar calculation can be carried out\nfor the Nosé-Hoover formulation, but the calculations are more involved.\nA good symplectic integrator for Nosé-Poincaré has been given by Nosé [287].\nFor further discussion and numerical experiments using this idea, see [94] (which\nalso considers stochastic methods).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 356,
      "printed_page": 335,
      "text": "8.1\nDynamics-Based Thermostat Techniques\n335\nThe relation between (8.10)–(8.13) and (8.2)–(8.4) becomes evident through the\nsubstitution p D Qp=s and \u0012 D ps=\u0006. Then (8.10)–(8.11) are seen to be the same\nas the corresponding equations in the Nosé-Hoover method, and the ﬁnal pair of\nequations become\nd\ndts D s\u0012;\nd\ndt\u0012 D 1\n\u0006\n\u0004\npTM\u00021p \u0003 NdkBT \u0003 \u0016HN\n\u0005\n:\nThe only difference between the last equation and (8.4) lies in the perturbation\n\u0006\u00021\u0016HN, which is zero along the exact solution. Under discretization, however,\nwe do not expect \u0016HN to vanish, so trajectories obtained from Nosé-Poincaré and\nNosé-Hoover will differ considerably over long time simulations.\nA beneﬁt of respecting the symplectic structure lies in the prospect of using\nbackward error analysis to analyze the behavior of the method. As shown in [40] it\nis possible to work out the terms of the perturbative expansion of the Nosé-Poincaré\nHamiltonian, i.e. to calculate the expansion\nQHh D HNP C h2HŒ2\t C O.h4/\nfor a second order, symmetric, symplectic numerical method. Then one may\ndetermine the effective distribution associated to the symplectic discretization\nmethod by “integrating out” the microcanonical density with respect to the auxiliary\nvariable and its conjugate momentum. One obtains in this way\nQ\u0005 .q; p/ D \u0005ˇ.q; p/\u0018.q; p; h/ C O\n\u0004\nh4\u0005\n:\nAn explicit formula for \u0018 is given in [40] for several symplectic methods. During\nsimulation, one may calculate the factor \u0018 and use this quantity to adjust averages.\nFor example, if we wish to calculate the average of a function g.q; p/, we may\nperform the calculation using \u0003 steps of the Nosé-Poincaré method with the given\nsymplectic, time-reversible, second order integrator, calculate gn and \u0018n at each\ntimestep, and approximate the canonical average from\nhgi D\n1\n\u0003 C 1\n\u0003\nX\nnD0\ngn\u0018\u00021\nn\nC O.h4/:\nFor further details, refer to [40]. Technically, a similar calculation can be carried out\nfor the Nosé-Hoover formulation, but the calculations are more involved.\nA good symplectic integrator for Nosé-Poincaré has been given by Nosé [287].\nFor further discussion and numerical experiments using this idea, see [94] (which\nalso considers stochastic methods).\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "[EXTRA]仅给O(h⁴)余项与有限重加权公式的精确定义；存在修正Hamiltonian/密度和采样误差定理未覆盖，列入缺口。"
  ],
  "issues": [],
  "statement_scope": "三条公式的定义及渐近条件；不声称已构造ζ或证明有限样本等于精确平均。",
  "lean_decl": "MD.Ch08.fourthOrderRemainder",
  "lean_declarations": [
    "MD.Ch08.fourthOrderRemainder",
    "MD.Ch08.correctedFiniteAverage",
    "MD.Ch08.npShadowAnsatz",
    "MD.Ch08.npDensityAnsatz"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def fourthOrderRemainder (r : ℝ → ℝ) : Prop :=
  ∃ C ε : ℝ, 0 < C ∧ 0 < ε ∧ ∀ h, |h| < ε → |r h| ≤ C*|h|^4
def correctedFiniteAverage (g ζ : ℕ → ℝ) (N : ℕ) : ℝ :=
  (∑ k ∈ Finset.range (N+1), g k / ζ k) / ((N : ℝ)+1)
def npShadowAnsatz (H H2 : Phase n → ℝ) (Htilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ Htilde h z-H z-h^2*H2 z)
def npDensityAnsatz (ρ : Phase n → ℝ) (ζ ρtilde : ℝ → Phase n → ℝ) : Prop :=
  ∀ z, fourthOrderRemainder (fun h ↦ ρtilde h z-ρ z*ζ h z)
```

## MD-8.2-GeneralThermostat
```json
{
  "source_id": "MD-8.2-GeneralThermostat",
  "kind": "definition",
  "label": null,
  "section": "8.2",
  "printed_page": "336",
  "pdf_page": "357",
  "statement_latex": "ż=J∇H, J constant skew-symmetric; ż=J∇H+Φ(ξ,z), ξ̇=g(ξ,z).",
  "statement_verbatim": "336\n8\nExtended Variable Methods\n8.2\nMore General Deterministic Thermostats\nWe have now seen that it is possible to construct stochastic differential equations\nthat preserve the Gibbs distribution or to design deterministic perturbations of\nHamiltonian dynamics, in an extended phase space, that do the same thing.\nThe latter class of methods are not rigorously ergodic, but the dynamics based\nthermostatting technique adds a great deal of ﬂexibility. For example it is easy to\ncontrol the ensemble using dynamic perturbations introduced only in some special\nphase space directions. In this section, we show how to design distributional controls\nwhich blend deterministic dynamics with restricted stochastic perturbations, with,\nin some cases, provable ergodicity. We will present the methods of this section in\nsome generality.\nLet a system be provided with Hamiltonian (energy) function H D H.z/, z 2 Rm,\nand microcanonical dynamics\nPz D JrH;\n(8.14)\nwhere J is skew symmetric. In principle, J need not be constant, as long as it satisﬁes\ncertain constraints, but as the extra generality is not needed for our current purposes,\nwe restrict the case J constant. We describe dynamical and stochastic-dynamical\ntechniques for computing averages with respect to a smooth density, for simplicity\nthe Gibbsian one, \u0005ˇ / exp.\u0003ˇH/.\nWe ﬁrst consider methods that are based on perturbation of the conservative\nsystem (8.14), i.e.\nPz D JrH C ˚.\u0002; z/;\n(8.15)\nwhere \u0002 2 Rm is controlled by the dynamical system\nd\u0002\ndt D g.\u0002; z/:\n8.2.1\nContinuity Equation\nGiven a deterministic thermostatting method, the density will evolve under the\ncontinuity equation,\n@\u0005\n@t D \u0003rz \u0002 Œ\u0005.JrzH C ˚/\t \u0003 r\u0002 \u0002 .\u0005g.\u0002; z// DW L\u0004\u0005:\nWe have, using product rule,\nL\u0004\u0005 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/ \u0003 \u0005rz \u0002 .JrzH C ˚/ \u0003 .r\u0002\u0005/ \u0002 g \u0003 \u0005r\u0002 \u0002 g:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 357,
      "printed_page": 336,
      "text": "336\n8\nExtended Variable Methods\n8.2\nMore General Deterministic Thermostats\nWe have now seen that it is possible to construct stochastic differential equations\nthat preserve the Gibbs distribution or to design deterministic perturbations of\nHamiltonian dynamics, in an extended phase space, that do the same thing.\nThe latter class of methods are not rigorously ergodic, but the dynamics based\nthermostatting technique adds a great deal of ﬂexibility. For example it is easy to\ncontrol the ensemble using dynamic perturbations introduced only in some special\nphase space directions. In this section, we show how to design distributional controls\nwhich blend deterministic dynamics with restricted stochastic perturbations, with,\nin some cases, provable ergodicity. We will present the methods of this section in\nsome generality.\nLet a system be provided with Hamiltonian (energy) function H D H.z/, z 2 Rm,\nand microcanonical dynamics\nPz D JrH;\n(8.14)\nwhere J is skew symmetric. In principle, J need not be constant, as long as it satisﬁes\ncertain constraints, but as the extra generality is not needed for our current purposes,\nwe restrict the case J constant. We describe dynamical and stochastic-dynamical\ntechniques for computing averages with respect to a smooth density, for simplicity\nthe Gibbsian one, \u0005ˇ / exp.\u0003ˇH/.\nWe ﬁrst consider methods that are based on perturbation of the conservative\nsystem (8.14), i.e.\nPz D JrH C ˚.\u0002; z/;\n(8.15)\nwhere \u0002 2 Rm is controlled by the dynamical system\nd\u0002\ndt D g.\u0002; z/:\n8.2.1\nContinuity Equation\nGiven a deterministic thermostatting method, the density will evolve under the\ncontinuity equation,\n@\u0005\n@t D \u0003rz \u0002 Œ\u0005.JrzH C ˚/\t \u0003 r\u0002 \u0002 .\u0005g.\u0002; z// DW L\u0004\u0005:\nWe have, using product rule,\nL\u0004\u0005 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/ \u0003 \u0005rz \u0002 .JrzH C ˚/ \u0003 .r\u0002\u0005/ \u0002 g \u0003 \u0005r\u0002 \u0002 g:\n"
    }
  ],
  "numbered_equations": [
    "8.14",
    "8.15"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "J为常矩阵，Jᵀ=-J；z、ξ为实向量，光滑资格在结论中给出。"
  ],
  "issues": [],
  "statement_scope": "常矩阵一般热浴场及矩阵反对称资格的定义；不声称已证驻定或采样。",
  "lean_decl": "MD.Ch08.generalThermostat",
  "lean_declarations": [
    "MD.Ch08.generalThermostat",
    "MD.Ch08.skewMatrix"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def generalThermostat {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (z : Vec n × Vec k) : Vec n × Vec k := (J *ᵥ gradient H z.1 + Φ z, g z)
def skewMatrix (J : Matrix (Fin n) (Fin n) ℝ) : Prop := J.transpose = -J
```

## MD-8.2.1-ContinuityProductRule
```json
{
  "source_id": "MD-8.2.1-ContinuityProductRule",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.2.1",
  "printed_page": "336–337",
  "pdf_page": "357–358",
  "statement_latex": "∂tρ=-div_z[ρ(J∇H+Φ)]-div_ξ(ρg)=L†ρ; the product rule gives four terms W₁+W₂+W₃+W₄.",
  "statement_verbatim": "336\n8\nExtended Variable Methods\n8.2\nMore General Deterministic Thermostats\nWe have now seen that it is possible to construct stochastic differential equations\nthat preserve the Gibbs distribution or to design deterministic perturbations of\nHamiltonian dynamics, in an extended phase space, that do the same thing.\nThe latter class of methods are not rigorously ergodic, but the dynamics based\nthermostatting technique adds a great deal of ﬂexibility. For example it is easy to\ncontrol the ensemble using dynamic perturbations introduced only in some special\nphase space directions. In this section, we show how to design distributional controls\nwhich blend deterministic dynamics with restricted stochastic perturbations, with,\nin some cases, provable ergodicity. We will present the methods of this section in\nsome generality.\nLet a system be provided with Hamiltonian (energy) function H D H.z/, z 2 Rm,\nand microcanonical dynamics\nPz D JrH;\n(8.14)\nwhere J is skew symmetric. In principle, J need not be constant, as long as it satisﬁes\ncertain constraints, but as the extra generality is not needed for our current purposes,\nwe restrict the case J constant. We describe dynamical and stochastic-dynamical\ntechniques for computing averages with respect to a smooth density, for simplicity\nthe Gibbsian one, \u0005ˇ / exp.\u0003ˇH/.\nWe ﬁrst consider methods that are based on perturbation of the conservative\nsystem (8.14), i.e.\nPz D JrH C ˚.\u0002; z/;\n(8.15)\nwhere \u0002 2 Rm is controlled by the dynamical system\nd\u0002\ndt D g.\u0002; z/:\n8.2.1\nContinuity Equation\nGiven a deterministic thermostatting method, the density will evolve under the\ncontinuity equation,\n@\u0005\n@t D \u0003rz \u0002 Œ\u0005.JrzH C ˚/\t \u0003 r\u0002 \u0002 .\u0005g.\u0002; z// DW L\u0004\u0005:\nWe have, using product rule,\nL\u0004\u0005 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/ \u0003 \u0005rz \u0002 .JrzH C ˚/ \u0003 .r\u0002\u0005/ \u0002 g \u0003 \u0005r\u0002 \u0002 g:\n\n8.2\nMore General Deterministic Thermostats\n337\nWe divide this into four parts: L\u0004\u0005 D W1 C W2 C W3 C W4, where\nW1 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/; W2 D \u0003\u0005rz \u0002 .JrzH C ˚/;\nW3 D \u0003.r\u0002\u0005/ \u0002 g;\nW4 D \u0003\u0005r\u0002 \u0002 g:\nWe seek perturbations of Hamiltonian dynamics with separable equilibria, i.e., such\nthat \u0005 D \u0005ˇ.H.z// O\u0005.\u0002/ is a stationary solution.\nTaking this as an ansatz, the ﬁrst term can be simpliﬁed as follows:\nW1 D \u0003 O\u0005.\u0002/\u00050\nˇ.H/rzH \u0002 .JrzH C ˚/\nD ˇ O\u0005.\u0002/\u0005ˇ.H/rzH \u0002 ˚ D ˇ\u0005rzH \u0002 ˚\nas J is skew-symmetric.\nUsing the volume preservation of Hamiltonian systems, the second term satisﬁes\nW2 D \u0003\u0005rz \u0002 .JrzH C ˚/ D \u0003\u0005rz \u0002 ˚;\nhence\nW1 C W2 D \u0003\u0005Œrz \u0003 ˇrzH\t \u0002 ˚:\nThere are many possibilities for the distribution of \u0002, of course, but we will\nassume this is Gaussian for simplicity: O\u0005.\u0002/\nD\nexp\n\u0004\n\u0003ˇ Pm\niD1 \u0006i\u00122\ni =2\n\u0005\nD\nexp.\u0003ˇ\u0002T\u0007\u00021\u0002=2/ to get\nW3 D \u0003.r\u0002\u0005/ \u0002 g.\u0002; z/ D ˇ\u0005\u0002T\u0007\u00021g:\nFinally, for an equilibrium solution we must have W1 C W2 C W3 C W4 D 0, so\n\u0003Œrz \u0003 ˇrzH\t \u0002 ˚ C ˇ\u0002T\u0007\u00021g \u0003 r\u0002 \u0002 g D 0:\nThis equation is the fundamental one for deterministic thermostats.\nExample 8.1 To recover Nosé-Hoover, assume an even dimensional phase space,\nz D .q; p/, Nd degrees of freedom, and \u0012 2 R,\n˚ D \u0003\u0012\n\u0002 0\np\n\u0003\n;\ng.z/ D \u0006\u00021.p \u0002 rpH \u0003 NdkBT/:\nExample 8.2 Slightly more generally, let\n˚ D \u0012G.z/;\ng.\u0012; z/ D g.z/ D \u0006\u00021ŒrzH \u0003 kBTrz\t \u0002 G.z/:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 357,
      "printed_page": 336,
      "text": "336\n8\nExtended Variable Methods\n8.2\nMore General Deterministic Thermostats\nWe have now seen that it is possible to construct stochastic differential equations\nthat preserve the Gibbs distribution or to design deterministic perturbations of\nHamiltonian dynamics, in an extended phase space, that do the same thing.\nThe latter class of methods are not rigorously ergodic, but the dynamics based\nthermostatting technique adds a great deal of ﬂexibility. For example it is easy to\ncontrol the ensemble using dynamic perturbations introduced only in some special\nphase space directions. In this section, we show how to design distributional controls\nwhich blend deterministic dynamics with restricted stochastic perturbations, with,\nin some cases, provable ergodicity. We will present the methods of this section in\nsome generality.\nLet a system be provided with Hamiltonian (energy) function H D H.z/, z 2 Rm,\nand microcanonical dynamics\nPz D JrH;\n(8.14)\nwhere J is skew symmetric. In principle, J need not be constant, as long as it satisﬁes\ncertain constraints, but as the extra generality is not needed for our current purposes,\nwe restrict the case J constant. We describe dynamical and stochastic-dynamical\ntechniques for computing averages with respect to a smooth density, for simplicity\nthe Gibbsian one, \u0005ˇ / exp.\u0003ˇH/.\nWe ﬁrst consider methods that are based on perturbation of the conservative\nsystem (8.14), i.e.\nPz D JrH C ˚.\u0002; z/;\n(8.15)\nwhere \u0002 2 Rm is controlled by the dynamical system\nd\u0002\ndt D g.\u0002; z/:\n8.2.1\nContinuity Equation\nGiven a deterministic thermostatting method, the density will evolve under the\ncontinuity equation,\n@\u0005\n@t D \u0003rz \u0002 Œ\u0005.JrzH C ˚/\t \u0003 r\u0002 \u0002 .\u0005g.\u0002; z// DW L\u0004\u0005:\nWe have, using product rule,\nL\u0004\u0005 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/ \u0003 \u0005rz \u0002 .JrzH C ˚/ \u0003 .r\u0002\u0005/ \u0002 g \u0003 \u0005r\u0002 \u0002 g:\n"
    },
    {
      "pdf_page": 358,
      "printed_page": 337,
      "text": "8.2\nMore General Deterministic Thermostats\n337\nWe divide this into four parts: L\u0004\u0005 D W1 C W2 C W3 C W4, where\nW1 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/; W2 D \u0003\u0005rz \u0002 .JrzH C ˚/;\nW3 D \u0003.r\u0002\u0005/ \u0002 g;\nW4 D \u0003\u0005r\u0002 \u0002 g:\nWe seek perturbations of Hamiltonian dynamics with separable equilibria, i.e., such\nthat \u0005 D \u0005ˇ.H.z// O\u0005.\u0002/ is a stationary solution.\nTaking this as an ansatz, the ﬁrst term can be simpliﬁed as follows:\nW1 D \u0003 O\u0005.\u0002/\u00050\nˇ.H/rzH \u0002 .JrzH C ˚/\nD ˇ O\u0005.\u0002/\u0005ˇ.H/rzH \u0002 ˚ D ˇ\u0005rzH \u0002 ˚\nas J is skew-symmetric.\nUsing the volume preservation of Hamiltonian systems, the second term satisﬁes\nW2 D \u0003\u0005rz \u0002 .JrzH C ˚/ D \u0003\u0005rz \u0002 ˚;\nhence\nW1 C W2 D \u0003\u0005Œrz \u0003 ˇrzH\t \u0002 ˚:\nThere are many possibilities for the distribution of \u0002, of course, but we will\nassume this is Gaussian for simplicity: O\u0005.\u0002/\nD\nexp\n\u0004\n\u0003ˇ Pm\niD1 \u0006i\u00122\ni =2\n\u0005\nD\nexp.\u0003ˇ\u0002T\u0007\u00021\u0002=2/ to get\nW3 D \u0003.r\u0002\u0005/ \u0002 g.\u0002; z/ D ˇ\u0005\u0002T\u0007\u00021g:\nFinally, for an equilibrium solution we must have W1 C W2 C W3 C W4 D 0, so\n\u0003Œrz \u0003 ˇrzH\t \u0002 ˚ C ˇ\u0002T\u0007\u00021g \u0003 r\u0002 \u0002 g D 0:\nThis equation is the fundamental one for deterministic thermostats.\nExample 8.1 To recover Nosé-Hoover, assume an even dimensional phase space,\nz D .q; p/, Nd degrees of freedom, and \u0012 2 R,\n˚ D \u0003\u0012\n\u0002 0\np\n\u0003\n;\ng.z/ D \u0006\u00021.p \u0002 rpH \u0003 NdkBT/:\nExample 8.2 Slightly more generally, let\n˚ D \u0012G.z/;\ng.\u0012; z/ D g.z/ D \u0006\u00021ŒrzH \u0003 kBTrz\t \u0002 G.z/:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。"
  ],
  "issues": [],
  "statement_scope": "实际Fréchet散度的乘积展开；未声称连续性方程解的存在唯一性。",
  "lean_decl": "MD.Ch08.continuityRHS",
  "lean_declarations": [
    "MD.Ch08.continuityRHS",
    "MD.Ch08.continuity_productRule"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def continuityRHS {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • F x) z
theorem continuity_productRule {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k)
    (hF : DifferentiableAt ℝ F z) (hρ : DifferentiableAt ℝ ρ z) :
    continuityRHS F ρ z = -(fderiv ℝ ρ z (F z)) - ρ z*textbookDivergence F z := by
  rw [continuityRHS, textbookDivergence_density hρ hF]; ring
```

## MD-8.2.1-ThermostatCriterion
```json
{
  "source_id": "MD-8.2.1-ThermostatCriterion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.2.1",
  "printed_page": "337",
  "pdf_page": "358",
  "statement_latex": "- [∇z-β∇zH]·Φ + βξᵀμ⁻¹g - ∇ξ·g=0 is the fundamental equation for deterministic thermostats.",
  "statement_verbatim": "8.2\nMore General Deterministic Thermostats\n337\nWe divide this into four parts: L\u0004\u0005 D W1 C W2 C W3 C W4, where\nW1 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/; W2 D \u0003\u0005rz \u0002 .JrzH C ˚/;\nW3 D \u0003.r\u0002\u0005/ \u0002 g;\nW4 D \u0003\u0005r\u0002 \u0002 g:\nWe seek perturbations of Hamiltonian dynamics with separable equilibria, i.e., such\nthat \u0005 D \u0005ˇ.H.z// O\u0005.\u0002/ is a stationary solution.\nTaking this as an ansatz, the ﬁrst term can be simpliﬁed as follows:\nW1 D \u0003 O\u0005.\u0002/\u00050\nˇ.H/rzH \u0002 .JrzH C ˚/\nD ˇ O\u0005.\u0002/\u0005ˇ.H/rzH \u0002 ˚ D ˇ\u0005rzH \u0002 ˚\nas J is skew-symmetric.\nUsing the volume preservation of Hamiltonian systems, the second term satisﬁes\nW2 D \u0003\u0005rz \u0002 .JrzH C ˚/ D \u0003\u0005rz \u0002 ˚;\nhence\nW1 C W2 D \u0003\u0005Œrz \u0003 ˇrzH\t \u0002 ˚:\nThere are many possibilities for the distribution of \u0002, of course, but we will\nassume this is Gaussian for simplicity: O\u0005.\u0002/\nD\nexp\n\u0004\n\u0003ˇ Pm\niD1 \u0006i\u00122\ni =2\n\u0005\nD\nexp.\u0003ˇ\u0002T\u0007\u00021\u0002=2/ to get\nW3 D \u0003.r\u0002\u0005/ \u0002 g.\u0002; z/ D ˇ\u0005\u0002T\u0007\u00021g:\nFinally, for an equilibrium solution we must have W1 C W2 C W3 C W4 D 0, so\n\u0003Œrz \u0003 ˇrzH\t \u0002 ˚ C ˇ\u0002T\u0007\u00021g \u0003 r\u0002 \u0002 g D 0:\nThis equation is the fundamental one for deterministic thermostats.\nExample 8.1 To recover Nosé-Hoover, assume an even dimensional phase space,\nz D .q; p/, Nd degrees of freedom, and \u0012 2 R,\n˚ D \u0003\u0012\n\u0002 0\np\n\u0003\n;\ng.z/ D \u0006\u00021.p \u0002 rpH \u0003 NdkBT/:\nExample 8.2 Slightly more generally, let\n˚ D \u0012G.z/;\ng.\u0012; z/ D g.z/ D \u0006\u00021ŒrzH \u0003 kBTrz\t \u0002 G.z/:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 358,
      "printed_page": 337,
      "text": "8.2\nMore General Deterministic Thermostats\n337\nWe divide this into four parts: L\u0004\u0005 D W1 C W2 C W3 C W4, where\nW1 D \u0003.rz\u0005/ \u0002 .JrzH C ˚/; W2 D \u0003\u0005rz \u0002 .JrzH C ˚/;\nW3 D \u0003.r\u0002\u0005/ \u0002 g;\nW4 D \u0003\u0005r\u0002 \u0002 g:\nWe seek perturbations of Hamiltonian dynamics with separable equilibria, i.e., such\nthat \u0005 D \u0005ˇ.H.z// O\u0005.\u0002/ is a stationary solution.\nTaking this as an ansatz, the ﬁrst term can be simpliﬁed as follows:\nW1 D \u0003 O\u0005.\u0002/\u00050\nˇ.H/rzH \u0002 .JrzH C ˚/\nD ˇ O\u0005.\u0002/\u0005ˇ.H/rzH \u0002 ˚ D ˇ\u0005rzH \u0002 ˚\nas J is skew-symmetric.\nUsing the volume preservation of Hamiltonian systems, the second term satisﬁes\nW2 D \u0003\u0005rz \u0002 .JrzH C ˚/ D \u0003\u0005rz \u0002 ˚;\nhence\nW1 C W2 D \u0003\u0005Œrz \u0003 ˇrzH\t \u0002 ˚:\nThere are many possibilities for the distribution of \u0002, of course, but we will\nassume this is Gaussian for simplicity: O\u0005.\u0002/\nD\nexp\n\u0004\n\u0003ˇ Pm\niD1 \u0006i\u00122\ni =2\n\u0005\nD\nexp.\u0003ˇ\u0002T\u0007\u00021\u0002=2/ to get\nW3 D \u0003.r\u0002\u0005/ \u0002 g.\u0002; z/ D ˇ\u0005\u0002T\u0007\u00021g:\nFinally, for an equilibrium solution we must have W1 C W2 C W3 C W4 D 0, so\n\u0003Œrz \u0003 ˇrzH\t \u0002 ˚ C ˇ\u0002T\u0007\u00021g \u0003 r\u0002 \u0002 g D 0:\nThis equation is the fundamental one for deterministic thermostats.\nExample 8.1 To recover Nosé-Hoover, assume an even dimensional phase space,\nz D .q; p/, Nd degrees of freedom, and \u0012 2 R,\n˚ D \u0003\u0012\n\u0002 0\np\n\u0003\n;\ng.z/ D \u0006\u00021.p \u0002 rpH \u0003 NdkBT/:\nExample 8.2 Slightly more generally, let\n˚ D \u0012G.z/;\ng.\u0012; z/ D g.z/ D \u0006\u00021ŒrzH \u0003 kBTrz\t \u0002 G.z/:\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "原文μ_i在指数中是热质量，统一写Q_i；矩阵μ⁻¹的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。"
  ],
  "issues": [],
  "statement_scope": "给定正参数与光滑性后，局部Liouville驻定与所列标量散度条件的等价目标。",
  "lean_decl": "MD.Ch08.thermalWeight",
  "lean_declarations": [
    "MD.Ch08.thermalWeight",
    "MD.Ch08.thermostatCriterion"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def thermalWeight {k : ℕ} (H : Vec n → ℝ) (Q : Vec k) (β : ℝ)
    (z : Vec n × Vec k) : ℝ := Real.exp (-β*(H z.1 + (∑ i, Q i*z.2 i^2)/2))
theorem thermostatCriterion {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (Q : Vec k) (β : ℝ) (hβ : 0 < β) (hQ : ∀ i, 0 < Q i) (hJ : skewMatrix J)
    (hH : ContDiff ℝ 2 H) (hΦ : ContDiff ℝ 1 Φ) (hg : ContDiff ℝ 1 g) :
    textbookLiouvilleStationary (generalThermostat J H Φ g) (thermalWeight H Q β) ↔
    ∀ z, -(textbookDivergence (fun x ↦ Φ (x,z.2)) z.1) +
      β*fderiv ℝ H z.1 (Φ z) + β*(∑ i, Q i*z.2 i*g z i) -
      textbookDivergence (fun y ↦ g (z.1,y)) z.2 = 0 := by
  sorry
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
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。"
  ],
  "issues": [],
  "statement_scope": "单热浴一般G反馈及构型反馈公式、一般G的局部驻定目标；Example8.1由NH另条覆盖。",
  "lean_decl": "MD.Ch08.generalizedFeedback",
  "lean_declarations": [
    "MD.Ch08.generalizedFeedback",
    "MD.Ch08.configurationalFeedback",
    "MD.Ch08.generalizedFeedback_stationary"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
theorem generalizedFeedback_stationary (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry
```

## MD-8.2.1-TemperatureIdentity
```json
{
  "source_id": "MD-8.2.1-TemperatureIdentity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.2.1",
  "printed_page": "338",
  "pdf_page": "359",
  "statement_latex": "∫ divG ρ dω = -∫∇ρ·G dω = β∫∇H·G ρ dω. T=k_B⁻¹〈∇H·G〉/〈divG〉.",
  "statement_verbatim": "338\n8\nExtended Variable Methods\nThis is a slightly generalized form of the technique suggested by Bulgac and\nKusnezov [58].\nAssuming \u0005 goes to zero sufﬁciently rapidly at inﬁnity, we have\nZ\nrz \u0002 G.z/\u0005d! D \u0003\nZ\n.rz\u0005/ \u0002 G.z/d! D ˇ\nZ\nrzH \u0002 G.z/\u0005d!;\nusing integration by parts, therefore, since ˇ\u00021 D kBT,\nT D k\u00021\nB\nhrzH \u0002 Gi\nhr \u0002 Gi ;\nwhich gives formulas for temperature in terms of phase space averages (compare\nChap. 6, Proposition 6.1).\nSuppose we let K be a scalar valued function of position, and set\nG.z/ D\n\u0002 rqK.q/\n0\n\u0003\nthen we arrive at\ng.z/ D \u0006\u00021ŒrqU \u0003 kBTrq\t \u0002 rqK.q/:\nThis is an example of a “conﬁgurational thermostat” [193, 211, 319].\nA useful fact about thermostats is the following:\nProposition 8.1 (Thermostats are Additive) Suppose we are given two ther-\nmostats,\nPz D JrH C ˚1.\u0002; z/;\nP\u0002 D g1.\u0002; z/;\nwith stationary density O\u00051.\u0002/\u0005ˇ, and another\nPz D JrH C ˚2.\u0003; z/;\nP\u0003 D g2.\u0003; z/;\nwith stationary density O\u00052.\u0003/\u0005ˇ, then\nPz D JrH C ˚1.\u0002; z/ C ˚2.\u0003; z/;\nP\u0002 D g1.\u0002; z/;\nP\u0003 D g2.\u0003; z/\nis another thermostat and has stationary density Q\u0005 D O\u00051.\u0002/ O\u00052.\u0003/\u0005ˇ.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 359,
      "printed_page": 338,
      "text": "338\n8\nExtended Variable Methods\nThis is a slightly generalized form of the technique suggested by Bulgac and\nKusnezov [58].\nAssuming \u0005 goes to zero sufﬁciently rapidly at inﬁnity, we have\nZ\nrz \u0002 G.z/\u0005d! D \u0003\nZ\n.rz\u0005/ \u0002 G.z/d! D ˇ\nZ\nrzH \u0002 G.z/\u0005d!;\nusing integration by parts, therefore, since ˇ\u00021 D kBT,\nT D k\u00021\nB\nhrzH \u0002 Gi\nhr \u0002 Gi ;\nwhich gives formulas for temperature in terms of phase space averages (compare\nChap. 6, Proposition 6.1).\nSuppose we let K be a scalar valued function of position, and set\nG.z/ D\n\u0002 rqK.q/\n0\n\u0003\nthen we arrive at\ng.z/ D \u0006\u00021ŒrqU \u0003 kBTrq\t \u0002 rqK.q/:\nThis is an example of a “conﬁgurational thermostat” [193, 211, 319].\nA useful fact about thermostats is the following:\nProposition 8.1 (Thermostats are Additive) Suppose we are given two ther-\nmostats,\nPz D JrH C ˚1.\u0002; z/;\nP\u0002 D g1.\u0002; z/;\nwith stationary density O\u00051.\u0002/\u0005ˇ, and another\nPz D JrH C ˚2.\u0003; z/;\nP\u0003 D g2.\u0003; z/;\nwith stationary density O\u00052.\u0003/\u0005ˇ, then\nPz D JrH C ˚1.\u0002; z/ C ˚2.\u0003; z/;\nP\u0002 D g1.\u0002; z/;\nP\u0003 D g2.\u0003; z/\nis another thermostat and has stationary density Q\u0005 D O\u00051.\u0002/ O\u00052.\u0003/\u0005ˇ.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求k_B>0、分母非零。"
  ],
  "issues": [],
  "statement_scope": "紧支撑G的Gibbs积分分部目标及温度比值定义；一般边界衰减条件和比值推导未另证。",
  "lean_decl": "MD.Ch08.temperatureIdentity",
  "lean_declarations": [
    "MD.Ch08.temperatureIdentity",
    "MD.Ch08.phaseTemperature"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem temperatureIdentity (H : Vec n → ℝ) (G : Vec n → Vec n) (β : ℝ)
    (hH : ContDiff ℝ 2 H) (hG : ContDiff ℝ 1 G) (hcompact : HasCompactSupport G)
    (hβ : 0 < β) :
    (∫ z, textbookDivergence G z * gibbsWeight H β z) =
      β * ∫ z, fderiv ℝ H z (G z) * gibbsWeight H β z := by
  sorry
def phaseTemperature (kB numerator denominator : ℝ) : ℝ := numerator/(kB*denominator)
```
