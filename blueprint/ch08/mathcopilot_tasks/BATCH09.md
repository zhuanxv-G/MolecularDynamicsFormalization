# BATCH09 第8章原文与陈述审校

## MD-8.6-IsokineticGibbsShell
```json
{
  "source_id": "MD-8.6-IsokineticGibbsShell",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6",
  "printed_page": "363",
  "pdf_page": "384",
  "statement_latex": "ρ=Z⁻¹exp(-(N_c-1)U/K)δ[K-K₀]; K₀=β⁻¹(N_c-1) gives the configurational Gibbs distribution.",
  "statement_verbatim": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n363\nThus the condition to have a stationary state of the form (8.39) is that\nrw \u0002 f iso D .Nc \u0003 1/pTM\u00021F\npTM\u00021p :\nA solution of this equation for w is easily found, it is\nw D .Nc \u0003 1/U.q/\nK.p/:\nThe invariant probability density, which is associated to a surface of constant kinetic\nenergy, can be written as a generalized function using the Dirac notation:\n\u0005.q; p/ D Z\u00021e\u0002.Nc\u00021/U.q/=K.p/ıŒK.p/ \u0003 K0\t:\nIf we work on the surface of constant kinetic energy K.p/ D K0\ndef\nD ˇ\u00021.Nc \u0003 1/, the\ninvariant density is of the form\n\u0005 / N\u0005ˇıŒK.p/ \u0003 kBT.Nc \u0003 1/\t\nwhich demonstrates that the isokinetic method, with this choice for the total kinetic\nenergy, leaves invariant the conﬁgurational Gibbs distribution. Ergodicity has not\nbeen demonstrated, so it is not possible to conclude that the invariant distribution is\nunique; as we have seen before, the incorporation of stochastic terms can allow the\nformulation of strong statements regarding the ergodicity and mixing properties.\n8.6.1\nA Stochastic, Isokinetic Method for Gibbs Sampling\nMinary et al. [271, 272] studied the isokinetic method as a means to control\nthe instability in multiple timestepping due to resonance. They suggested that\neach physical degree of freedom be coupled to its own NHC thermostat through\nan isokinetic constraint in a “massive” thermostatting approach. These massive\nthermostats introduced some complexity (each degree of freedom had an associated\nNosé-Hoover chain system as well as the constraint); obtaining an accurate solution\nfor this large system is involving. A potentially more serious problem is that,\nalthough Nosé-Hoover chains and the isokinetic method may in some cases appear\nto be “practically ergodic,” no proof of ergodicity exists. A recent article (by one\nof us, together with Margul and Tuckerman [220]) addressed these problems by\nreplacing the Nosé-Hoover chains with stochastic terms (of Ornstein-Uhlenbeck\ntype).\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 384,
      "printed_page": 363,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n363\nThus the condition to have a stationary state of the form (8.39) is that\nrw \u0002 f iso D .Nc \u0003 1/pTM\u00021F\npTM\u00021p :\nA solution of this equation for w is easily found, it is\nw D .Nc \u0003 1/U.q/\nK.p/:\nThe invariant probability density, which is associated to a surface of constant kinetic\nenergy, can be written as a generalized function using the Dirac notation:\n\u0005.q; p/ D Z\u00021e\u0002.Nc\u00021/U.q/=K.p/ıŒK.p/ \u0003 K0\t:\nIf we work on the surface of constant kinetic energy K.p/ D K0\ndef\nD ˇ\u00021.Nc \u0003 1/, the\ninvariant density is of the form\n\u0005 / N\u0005ˇıŒK.p/ \u0003 kBT.Nc \u0003 1/\t\nwhich demonstrates that the isokinetic method, with this choice for the total kinetic\nenergy, leaves invariant the conﬁgurational Gibbs distribution. Ergodicity has not\nbeen demonstrated, so it is not possible to conclude that the invariant distribution is\nunique; as we have seen before, the incorporation of stochastic terms can allow the\nformulation of strong statements regarding the ergodicity and mixing properties.\n8.6.1\nA Stochastic, Isokinetic Method for Gibbs Sampling\nMinary et al. [271, 272] studied the isokinetic method as a means to control\nthe instability in multiple timestepping due to resonance. They suggested that\neach physical degree of freedom be coupled to its own NHC thermostat through\nan isokinetic constraint in a “massive” thermostatting approach. These massive\nthermostats introduced some complexity (each degree of freedom had an associated\nNosé-Hoover chain system as well as the constraint); obtaining an accurate solution\nfor this large system is involving. A potentially more serious problem is that,\nalthough Nosé-Hoover chains and the isokinetic method may in some cases appear\nto be “practically ergodic,” no proof of ergodicity exists. A recent article (by one\nof us, together with Margul and Tuckerman [220]) addressed these problems by\nreplacing the Nosé-Hoover chains with stochastic terms (of Ornstein-Uhlenbeck\ntype).\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。",
  "lean_decl": "MD.Ch08.isokineticShell",
  "lean_declarations": [
    "MD.Ch08.isokineticShell",
    "MD.Ch08.isoShellWeight",
    "MD.Ch08.isoShell_gibbsFactor"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def isokineticShell (invm : Vec n) (K0 : ℝ) : Set (Phase n) := {z | kineticTwice invm z.2=K0}
def isoShellWeight (U : Vec n → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-((n:ℝ)-1)*U z.1/kineticTwice invm z.2)
theorem isoShell_gibbsFactor (U : Vec n → ℝ) (invm : Vec n) (β : ℝ)
    (hn : 1 < n) (hβ : 0 < β) (z : Phase n)
    (hz : z ∈ isokineticShell invm (((n:ℝ)-1)/β)) :
    isoShellWeight U invm z = Real.exp (-β*U z.1) := by
  have hnR : (1 : ℝ) < (n : ℝ) := by exact_mod_cast hn
  have hn' : (n:ℝ)-1 ≠ 0 := ne_of_gt (sub_pos.mpr hnR)
  change kineticTwice invm z.2 = ((n:ℝ)-1)/β at hz
  unfold isoShellWeight
  rw [hz]
  congr 1
  field_simp [hn', ne_of_gt hβ]
  <;> ring
```

## MD-8.6.1-StochasticIsokinetic
```json
{
  "source_id": "MD-8.6.1-StochasticIsokinetic",
  "kind": "definition",
  "label": null,
  "section": "8.6.1",
  "printed_page": "364–365",
  "pdf_page": "385–386",
  "statement_latex": "dq=pdt, dp=(F-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=μ₂⁻¹(μ₁ξ₁²-k_BT)dt-γξ₂dt+σdW; p²+μ₁ξ₁²/2=k_BT.",
  "statement_verbatim": "364\n8\nExtended Variable Methods\nWe ﬁrst demonstrate the idea of [220] by considering the following SDE with a\nsingle degree of freedom:\ndq D pdt;\n(8.40)\ndp D ŒF.q/ \u0003 \u0013p\t dt;\n(8.41)\nd\u00121 D \u0003\u0013\u00121dt \u0003 \u00122\u00121dt;\n(8.42)\nd\u00122 D \u0006\u00021\n2 .\u00061\u00122\n1 \u0003 kBT/dt \u0003 \n\u00122dt C \u0007dW;\n(8.43)\nwhere \u00121 and \u00122 are auxiliary variables, \u0007 D\np\n2\n=ˇ\u00062, \n is the friction constant,\n\u00061 and \u00062 are coupling coefﬁcients, and \u0013 is a Lagrange multiplier which is chosen\nto maintain the isokinetic relation involving p and \u00121:\np2 C 1\n2\u00061\u00122\n1 D kBT:\n(8.44)\nWe calculate the multiplier by differentiating the constraint to obtain\n2pPp C \u00061\u00121 P\u00121 D 0\nor, using the differential equations,\n2.pF.q/ \u0003 \u0013p2/ C \u00061\u00121.\u0003\u0013\u00121dt \u0003 \u00122\u00121/ D 0;\nthus\n\u0013 D pF.q/ \u0003 \u00061\u00122\n1\u00122=2\np2 C \u00061\u00122\n1=2\n:\nUpon reintroduction of this expression in (8.40)–(8.43) this allows us to write a\nclosed-form SDE system for q; p; \u00121; \u00122.\nWe follow an analogous procedure to that used to study the distribution in the\ncase of the standard isokinetic system, for the moment ignoring the stochastic terms.\nThis requires us to solve the equation\nrw \u0002 f D div.f/;\nwhere now f is the vector ﬁeld in (8.40)–(8.43) where we take \n D 0. The\ndivergence is\ndiv.f/ D \u0003 d\ndp.\u0013p/ \u0003 d\nd\u00121\n.\u0013\u00121/ \u0003 \u00122:\n\n8.6\nIsokinetic Methods and Integration with Very Large Timestep\n365\nLet \u000f1 D pF \u0003 \u00061\u00122\n1\u00122=2, \u000f2 D p2 C \u00061\u00122\n1=2, so \u0013 D \u000f1=\u000f2, then calculate\nd\ndp\u0013 D .\u000f2F \u0003 2\u000f1p/=\u000f2\n2;\nd\nd\u00121\n\u0013 D .\u0003\u00061\u00121\u00122\u000f2 \u0003 \u00061\u00121\u000f1/=\u000f2\n2;\nto see that\npd\u0013\ndp C \u00121\nd\u0013\nd\u00121\nD .pF \u0003 \u00061\u00122\n1\u00122/\u000f2 \u0003 .2p2 C \u00061\u00122\n1/\u000f1\n\u000f2\n2\nD 2\n\u0002\n\u0003 pF\n2\u000f2\nC \u0013 \u0003 \u0013\n\u0003\nD \u0003pF\n\u000f2\n;\nhence\ndiv.f/ D pF\n\u000f2\n\u0003 2\u0013 \u0003 \u00122\nD pF \u0003 2.pF \u0003 \u00061\u00122\n1\u00122=2/\np2 C \u00061\u00122\n1=2\n\u0003 \u00122\nD \u0003pF C \u00061\u00122\n1\u00122\np2 C \u00061\u00122\n1=2 \u0003 \u00122:\nWe ﬁnd that a solution of the equation rw \u0002 f D div.f/ is then given by\nw D\nU C 1\n2\u00122\n2\np2 C 1\n2\u00061\u00122\n1\n:\nIntegrating over the isokinetic surface p2 C 1\n2\u00061\u00122\n1 D ˇ\u00021, and with respect to the\nvariable \u00122, yields the Gibbs conﬁgurational density.\nThe exciting prospect here is that we now have a new variable \u00122 which\nhas, in equilibrium, a Gaussian distribution. The Ornstein-Uhlenbeck terms are\ntherefore compatible with this extended distribution and can be incorporated (as\nin Nosé-Hoover-Langevin) to provide ergodicity and control of the convergence to\nequilibrium.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 385,
      "printed_page": 364,
      "text": "364\n8\nExtended Variable Methods\nWe ﬁrst demonstrate the idea of [220] by considering the following SDE with a\nsingle degree of freedom:\ndq D pdt;\n(8.40)\ndp D ŒF.q/ \u0003 \u0013p\t dt;\n(8.41)\nd\u00121 D \u0003\u0013\u00121dt \u0003 \u00122\u00121dt;\n(8.42)\nd\u00122 D \u0006\u00021\n2 .\u00061\u00122\n1 \u0003 kBT/dt \u0003 \n\u00122dt C \u0007dW;\n(8.43)\nwhere \u00121 and \u00122 are auxiliary variables, \u0007 D\np\n2\n=ˇ\u00062, \n is the friction constant,\n\u00061 and \u00062 are coupling coefﬁcients, and \u0013 is a Lagrange multiplier which is chosen\nto maintain the isokinetic relation involving p and \u00121:\np2 C 1\n2\u00061\u00122\n1 D kBT:\n(8.44)\nWe calculate the multiplier by differentiating the constraint to obtain\n2pPp C \u00061\u00121 P\u00121 D 0\nor, using the differential equations,\n2.pF.q/ \u0003 \u0013p2/ C \u00061\u00121.\u0003\u0013\u00121dt \u0003 \u00122\u00121/ D 0;\nthus\n\u0013 D pF.q/ \u0003 \u00061\u00122\n1\u00122=2\np2 C \u00061\u00122\n1=2\n:\nUpon reintroduction of this expression in (8.40)–(8.43) this allows us to write a\nclosed-form SDE system for q; p; \u00121; \u00122.\nWe follow an analogous procedure to that used to study the distribution in the\ncase of the standard isokinetic system, for the moment ignoring the stochastic terms.\nThis requires us to solve the equation\nrw \u0002 f D div.f/;\nwhere now f is the vector ﬁeld in (8.40)–(8.43) where we take \n D 0. The\ndivergence is\ndiv.f/ D \u0003 d\ndp.\u0013p/ \u0003 d\nd\u00121\n.\u0013\u00121/ \u0003 \u00122:\n"
    },
    {
      "pdf_page": 386,
      "printed_page": 365,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n365\nLet \u000f1 D pF \u0003 \u00061\u00122\n1\u00122=2, \u000f2 D p2 C \u00061\u00122\n1=2, so \u0013 D \u000f1=\u000f2, then calculate\nd\ndp\u0013 D .\u000f2F \u0003 2\u000f1p/=\u000f2\n2;\nd\nd\u00121\n\u0013 D .\u0003\u00061\u00121\u00122\u000f2 \u0003 \u00061\u00121\u000f1/=\u000f2\n2;\nto see that\npd\u0013\ndp C \u00121\nd\u0013\nd\u00121\nD .pF \u0003 \u00061\u00122\n1\u00122/\u000f2 \u0003 .2p2 C \u00061\u00122\n1/\u000f1\n\u000f2\n2\nD 2\n\u0002\n\u0003 pF\n2\u000f2\nC \u0013 \u0003 \u0013\n\u0003\nD \u0003pF\n\u000f2\n;\nhence\ndiv.f/ D pF\n\u000f2\n\u0003 2\u0013 \u0003 \u00122\nD pF \u0003 2.pF \u0003 \u00061\u00122\n1\u00122=2/\np2 C \u00061\u00122\n1=2\n\u0003 \u00122\nD \u0003pF C \u00061\u00122\n1\u00122\np2 C \u00061\u00122\n1=2 \u0003 \u00122:\nWe ﬁnd that a solution of the equation rw \u0002 f D div.f/ is then given by\nw D\nU C 1\n2\u00122\n2\np2 C 1\n2\u00061\u00122\n1\n:\nIntegrating over the isokinetic surface p2 C 1\n2\u00061\u00122\n1 D ˇ\u00021, and with respect to the\nvariable \u00122, yields the Gibbs conﬁgurational density.\nThe exciting prospect here is that we now have a new variable \u00122 which\nhas, in equilibrium, a Gaussian distribution. The Ornstein-Uhlenbeck terms are\ntherefore compatible with this extended distribution and can be incorporated (as\nin Nosé-Hoover-Langevin) to provide ergodicity and control of the convergence to\nequilibrium.\n"
    }
  ],
  "numbered_equations": [
    "8.40",
    "8.41",
    "8.42",
    "8.43",
    "8.44"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "热浴变量ξ₁,ξ₂∈ℝ，各质量、温度、摩擦正；随机噪声只在ξ₂；约束正值排除奇点。"
  ],
  "issues": [],
  "statement_scope": "实际SIN漂移、正参数Wiener积分解和瞬时约束平衡；约束沿全路径保持未另证。",
  "lean_decl": "MD.Ch08.sinConstraint",
  "lean_declarations": [
    "MD.Ch08.sinConstraint",
    "MD.Ch08.sinMultiplier",
    "MD.Ch08.sinDrift",
    "MD.Ch08.isSINSolution",
    "MD.Ch08.sinConstraint_balance"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinConstraint (Q1 : ℝ) (z : Vec 4) : ℝ := z 1^2+Q1*z 2^2/2
def sinMultiplier (Q1 : ℝ) (F : ℝ → ℝ) (z : Vec 4) : ℝ :=
  (z 1*F (z 0)-Q1*z 2^2*z 3/2)/sinConstraint Q1 z
def sinDrift (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinMultiplier Q1 F z
  ![z 1, F (z 0)-lam*z 1, -lam*z 2-z 3*z 2, (Q1*z 2^2-θ)/Q2-γ*z 3]
def isSINSolution (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  0 < Q1 ∧ 0 < Q2 ∧ 0 < θ ∧ 0 < γ ∧ sinConstraint Q1 x0=θ ∧
  additiveSDE P 1 W X x0 (sinDrift Q1 Q2 θ γ F)
    (fun _ ↦ ![0,0,0,Real.sqrt (2*γ*θ/Q2)])
theorem sinConstraint_balance (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinDrift Q1 Q2 θ γ F z) 1+Q1*z 2*(sinDrift Q1 Q2 θ γ F z) 2=0 := by
  have hden : 2*z 1^2+Q1*z 2^2 ≠ 0 := by
    intro h
    apply hK
    dsimp [sinConstraint]
    linarith
  simp [sinDrift, sinMultiplier, sinConstraint]
  field_simp [hden]
  <;> ring
```

## MD-8.6.1-SINWeightPrinted
```json
{
  "source_id": "MD-8.6.1-SINWeightPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.1",
  "printed_page": "365",
  "pdf_page": "386",
  "statement_latex": "w=(U+ξ₂²/2)/(p²+μ₁ξ₁²/2); integration over the isokinetic surface gives the Gibbs configurational density.",
  "statement_verbatim": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n365\nLet \u000f1 D pF \u0003 \u00061\u00122\n1\u00122=2, \u000f2 D p2 C \u00061\u00122\n1=2, so \u0013 D \u000f1=\u000f2, then calculate\nd\ndp\u0013 D .\u000f2F \u0003 2\u000f1p/=\u000f2\n2;\nd\nd\u00121\n\u0013 D .\u0003\u00061\u00121\u00122\u000f2 \u0003 \u00061\u00121\u000f1/=\u000f2\n2;\nto see that\npd\u0013\ndp C \u00121\nd\u0013\nd\u00121\nD .pF \u0003 \u00061\u00122\n1\u00122/\u000f2 \u0003 .2p2 C \u00061\u00122\n1/\u000f1\n\u000f2\n2\nD 2\n\u0002\n\u0003 pF\n2\u000f2\nC \u0013 \u0003 \u0013\n\u0003\nD \u0003pF\n\u000f2\n;\nhence\ndiv.f/ D pF\n\u000f2\n\u0003 2\u0013 \u0003 \u00122\nD pF \u0003 2.pF \u0003 \u00061\u00122\n1\u00122=2/\np2 C \u00061\u00122\n1=2\n\u0003 \u00122\nD \u0003pF C \u00061\u00122\n1\u00122\np2 C \u00061\u00122\n1=2 \u0003 \u00122:\nWe ﬁnd that a solution of the equation rw \u0002 f D div.f/ is then given by\nw D\nU C 1\n2\u00122\n2\np2 C 1\n2\u00061\u00122\n1\n:\nIntegrating over the isokinetic surface p2 C 1\n2\u00061\u00122\n1 D ˇ\u00021, and with respect to the\nvariable \u00122, yields the Gibbs conﬁgurational density.\nThe exciting prospect here is that we now have a new variable \u00122 which\nhas, in equilibrium, a Gaussian distribution. The Ornstein-Uhlenbeck terms are\ntherefore compatible with this extended distribution and can be incorporated (as\nin Nosé-Hoover-Langevin) to provide ergodicity and control of the convergence to\nequilibrium.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 386,
      "printed_page": 365,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n365\nLet \u000f1 D pF \u0003 \u00061\u00122\n1\u00122=2, \u000f2 D p2 C \u00061\u00122\n1=2, so \u0013 D \u000f1=\u000f2, then calculate\nd\ndp\u0013 D .\u000f2F \u0003 2\u000f1p/=\u000f2\n2;\nd\nd\u00121\n\u0013 D .\u0003\u00061\u00121\u00122\u000f2 \u0003 \u00061\u00121\u000f1/=\u000f2\n2;\nto see that\npd\u0013\ndp C \u00121\nd\u0013\nd\u00121\nD .pF \u0003 \u00061\u00122\n1\u00122/\u000f2 \u0003 .2p2 C \u00061\u00122\n1/\u000f1\n\u000f2\n2\nD 2\n\u0002\n\u0003 pF\n2\u000f2\nC \u0013 \u0003 \u0013\n\u0003\nD \u0003pF\n\u000f2\n;\nhence\ndiv.f/ D pF\n\u000f2\n\u0003 2\u0013 \u0003 \u00122\nD pF \u0003 2.pF \u0003 \u00061\u00122\n1\u00122=2/\np2 C \u00061\u00122\n1=2\n\u0003 \u00122\nD \u0003pF C \u00061\u00122\n1\u00122\np2 C \u00061\u00122\n1=2 \u0003 \u00122:\nWe ﬁnd that a solution of the equation rw \u0002 f D div.f/ is then given by\nw D\nU C 1\n2\u00122\n2\np2 C 1\n2\u00061\u00122\n1\n:\nIntegrating over the isokinetic surface p2 C 1\n2\u00061\u00122\n1 D ˇ\u00021, and with respect to the\nvariable \u00122, yields the Gibbs conﬁgurational density.\nThe exciting prospect here is that we now have a new variable \u00122 which\nhas, in equilibrium, a Gaussian distribution. The Ornstein-Uhlenbeck terms are\ntherefore compatible with this extended distribution and can be incorporated (as\nin Nosé-Hoover-Langevin) to provide ergodicity and control of the convergence to\nequilibrium.\n"
    }
  ],
  "numbered_equations": [],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。"
  ],
  "issues": [
    "已目视核对原页PDF386：ξ₂方程含μ₂⁻¹，而w的ξ₂二次项缺μ₂；一般μ₂时应为μ₂ξ₂²/2。"
  ],
  "statement_scope": "原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。",
  "lean_decl": "MD.Ch08.sinWeightPrinted",
  "lean_declarations": [
    "MD.Ch08.sinWeightPrinted",
    "MD.Ch08.sinWeight_corrected",
    "MD.Ch08.sinWeight_stationary_corrected"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinWeightPrinted (U : ℝ → ℝ) (Q1 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+z 3^2/2)/sinConstraint Q1 z)
def sinWeight_corrected (U : ℝ → ℝ) (Q1 Q2 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+Q2*z 3^2/2)/sinConstraint Q1 z)
theorem sinWeight_stationary_corrected (U : ℝ → ℝ) (Q1 Q2 θ : ℝ)
    (hU : ContDiff ℝ 2 U) (hQ1 : 0 < Q1) (hQ2 : 0 < Q2) (hθ : 0 < θ)
    (z : Vec 4) (hz : sinConstraint Q1 z=θ) :
    textbookDivergence
      (fun x ↦ sinWeight_corrected U Q1 Q2 x • sinDrift Q1 Q2 θ 0 (fun q ↦ -deriv U q) x) z = 0 := by
  sorry
```

## MD-8.6.2-SINHarmonic
```json
{
  "source_id": "MD-8.6.2-SINHarmonic",
  "kind": "definition",
  "label": null,
  "section": "8.6.2",
  "printed_page": "366",
  "pdf_page": "387",
  "statement_latex": "For μ₁=μ₂=1, dq=pdt, dp=(-q-λp)dt, dξ₁=(-λξ₁-ξ₂ξ₁)dt, dξ₂=(ξ₁²-k_BT-γξ₂)dt+σdW, λ=(-qp-ξ₂ξ₁²/2)/(p²+ξ₁²/2), σ=√(2γk_BT). (8.45)–(8.47).",
  "statement_verbatim": "366\n8\nExtended Variable Methods\n8.6.2\nErgodicity\nFollowing the discussion in [220], let us show ergodicity for the stochastic isokinetic\nharmonic oscillator:\ndq D pdt\ndp D Œ\u0003q \u0003 \u0013p\tdt\nd\u00121 D Œ\u0003\u0013\u00121 \u0003 \u00122\u00121\tdt\nd\u00122 D Œ\u00122\n1 \u0003 kBT \u0003 \n\u00122\tdt C \u0007dW\n(8.45)\nwith \u0013 D \u0002qp\u0002\u00122\u00122\n1=2\np2C\u00122\n1=2\nand \u0007 D p2\nkBT. We have taken the coupling coefﬁcients\n\u00061; \u00062 both one for simplicity as their particular values (as long as nonzero) have\nno bearing on the ergodic property.\nThe constraint, p2 C \u00122\n1=2 D const, deﬁnes a three-dimensional manifold M, a\ngeneralized cylinder. \u00121 D 0 is an invariant manifold of the isokinetic equations,\nwith solutions therefore conﬁned for all time to one or the other half-space (\u00121 < 0\nor \u00121 > 0). It is enough to sample one or the other of the two half spaces. To show\nthat the solutions do so, we need to demonstrate that an appropriate Hörmander\ncondition holds. Deﬁne f and g as the vector ﬁelds\nf D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00122\u00121/@\u00121 C\n\n.\u00122\n1 \u0003 kBT/ \u0003 \n\u00122\n\u000b\n@\u00122;\n(8.46)\nand\ng D \u0007@\u00122:\n(8.47)\nWe will show that the dimension of the ideal spanned by the iterated commutators\nof the vector ﬁelds f and g is three, i.e. that it spans the tangent space to M at any\npoint. For this purpose, we use the collection of vectors\nf; g; Œf; g\t; Œf; Œf; g\t\t; Œf; Œf; Œf; g\t\t\t:\nWe will see that these provide a basis at every point excluding the one-dimensional\nset deﬁned by the union M0 of the two lines `C, `\u0002 deﬁned by\nq D 0;\np D 0;\n\u00121 D ˙\nq\n2\u0006\u00021\n1 kBT;\nand arbitrary \u00122. [Note: the choice \u00121 D ˙\nq\n2\u0006\u00021\n1 kBT is made so that the isokinetic\nconstraint is satisﬁed. In [220] this value was incorrectly deﬁned.] The vectors f and\ng are linearly independent except on M0.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 387,
      "printed_page": 366,
      "text": "366\n8\nExtended Variable Methods\n8.6.2\nErgodicity\nFollowing the discussion in [220], let us show ergodicity for the stochastic isokinetic\nharmonic oscillator:\ndq D pdt\ndp D Œ\u0003q \u0003 \u0013p\tdt\nd\u00121 D Œ\u0003\u0013\u00121 \u0003 \u00122\u00121\tdt\nd\u00122 D Œ\u00122\n1 \u0003 kBT \u0003 \n\u00122\tdt C \u0007dW\n(8.45)\nwith \u0013 D \u0002qp\u0002\u00122\u00122\n1=2\np2C\u00122\n1=2\nand \u0007 D p2\nkBT. We have taken the coupling coefﬁcients\n\u00061; \u00062 both one for simplicity as their particular values (as long as nonzero) have\nno bearing on the ergodic property.\nThe constraint, p2 C \u00122\n1=2 D const, deﬁnes a three-dimensional manifold M, a\ngeneralized cylinder. \u00121 D 0 is an invariant manifold of the isokinetic equations,\nwith solutions therefore conﬁned for all time to one or the other half-space (\u00121 < 0\nor \u00121 > 0). It is enough to sample one or the other of the two half spaces. To show\nthat the solutions do so, we need to demonstrate that an appropriate Hörmander\ncondition holds. Deﬁne f and g as the vector ﬁelds\nf D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00122\u00121/@\u00121 C\n\n.\u00122\n1 \u0003 kBT/ \u0003 \n\u00122\n\u000b\n@\u00122;\n(8.46)\nand\ng D \u0007@\u00122:\n(8.47)\nWe will show that the dimension of the ideal spanned by the iterated commutators\nof the vector ﬁelds f and g is three, i.e. that it spans the tangent space to M at any\npoint. For this purpose, we use the collection of vectors\nf; g; Œf; g\t; Œf; Œf; g\t\t; Œf; Œf; Œf; g\t\t\t:\nWe will see that these provide a basis at every point excluding the one-dimensional\nset deﬁned by the union M0 of the two lines `C, `\u0002 deﬁned by\nq D 0;\np D 0;\n\u00121 D ˙\nq\n2\u0006\u00021\n1 kBT;\nand arbitrary \u00122. [Note: the choice \u00121 D ˙\nq\n2\u0006\u00021\n1 kBT is made so that the isokinetic\nconstraint is satisﬁed. In [220] this value was incorrectly deﬁned.] The vectors f and\ng are linearly independent except on M0.\n"
    }
  ],
  "numbered_equations": [
    "8.45",
    "8.46",
    "8.47"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "θ=k_BT>0、γ>0、标量Wiener由isSINSolution给全；零ξ₁面不变和两个半柱的轨道符号保持需要ODE唯一性，列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。",
  "lean_decl": "MD.Ch08.sinHarmonicF",
  "lean_declarations": [
    "MD.Ch08.sinHarmonicF",
    "MD.Ch08.sinHarmonicG",
    "MD.Ch08.isSINHarmonicSolution",
    "MD.Ch08.sinExceptional",
    "MD.Ch08.sinHalfCylinder",
    "MD.Ch08.sinHalfCylinder_disjoint"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinHarmonicF (θ γ : ℝ) : Vec 4 → Vec 4 := sinDrift 1 1 θ γ (fun q ↦ -q)
def sinHarmonicG (θ γ : ℝ) : Vec 4 := ![0,0,0,Real.sqrt (2*γ*θ)]
def isSINHarmonicSolution (θ γ : ℝ) (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  isSINSolution 1 1 θ γ (fun q ↦ -q) P W X x0
def sinExceptional (θ : ℝ) : Set (Vec 4) :=
  {z | z 0=0 ∧ z 1=0 ∧ z 2^2=2*θ}
def sinHalfCylinder (θ : ℝ) (positive : Bool) : Set (Vec 4) :=
  {z | sinConstraint 1 z=θ ∧ (if positive then 0 < z 2 else z 2 < 0)}
theorem sinHalfCylinder_disjoint (θ : ℝ) :
    Disjoint (sinHalfCylinder θ true) (sinHalfCylinder θ false) := by
  apply Set.disjoint_left.mpr
  intro z hpos hneg
  exact (not_lt_of_ge (le_of_lt hpos.2)) hneg.2
```

## MD-8.6.2-SINProjectedBracketsPrinted
```json
{
  "source_id": "MD-8.6.2-SINProjectedBracketsPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.2",
  "printed_page": "367",
  "pdf_page": "388",
  "statement_latex": "u₀=Πf, u₁=Π[f,g], u₂=Π[f,[f,g]], u₃=Π[f,[f,[f,g]]]. The displayed equations (8.48)–(8.53) give their components, with D=2p²+ξ₁².",
  "statement_verbatim": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n367\nThe proof requires calculation of the vector ﬁelds\nu0 D ˘ f;\nu1 D ˘ Œf; g\t ;\nu2 D ˘ Œf; Œf; g\t\t;\nu3 D ˘ Œf; Œf; Œf; g\t\t\t;\nwhere ˘ is the projector onto the ﬁrst three components. Because g D \u0007e4,\nit is enough to show that any pair from among these four vectors are linearly\nindependent, except possibly on M0. Note that projection can only be performed\nafter the full calculation of the relevant commutator. Because the commutators\nquickly become quite messy, we used a symbolic computing package to assist in\nthese calculations.\nThe ﬁrst two vectors are:\nu0 D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00121\u00122/@\u00121;\n(8.48)\nand\nu1 D \u0007p @\u0013\n@\u00122\n@p C \u00121\n\b\n1 C @\u0013\n@\u00122\n\t\n@\u00121:\n(8.49)\nAfter expanding the derivatives of \u0013 we have\nu1 D p@q C \u00122\n1\n\b\u0003q C p\u00122\nD\n\t\n@p \u0003 2\u00121p\n\b\u0003q C p\u00122\nD\n\t\n@\u00121;\n(8.50)\nand\nu2 D \u0003\u0007.\u00122\n1p=D/@p C .2\u0007\u00121p2=D/@\u00121;\n(8.51)\nwhere D D 2p2 C \u00122\n1.\nIf q ¤ 0 and p ¤ 0, then clearly u1 and u2 are linearly independent. However, if\np D 0 then u2 D 0. We proceed to compute the commutator Œf; Œf; g\t\t. Projecting to\nthe ﬁrst three components results in\nu2 D \u0007\n\b\u00122\n1p\nD\n\t\n@q \u0003 \u0007\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@p C 2\u0007\u00121p\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@\u00121:\n(8.52)\nAgain, we substitute p D 0 and ﬁnd that\nu2jpD0 D .\u0007\u00122\n1q=D2/@p:\n(8.53)\nUnfortunately, this is parallel to u1 (for p D 0), and hence yet one more commutator\nis required in this case.\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 388,
      "printed_page": 367,
      "text": "8.6\nIsokinetic Methods and Integration with Very Large Timestep\n367\nThe proof requires calculation of the vector ﬁelds\nu0 D ˘ f;\nu1 D ˘ Œf; g\t ;\nu2 D ˘ Œf; Œf; g\t\t;\nu3 D ˘ Œf; Œf; Œf; g\t\t\t;\nwhere ˘ is the projector onto the ﬁrst three components. Because g D \u0007e4,\nit is enough to show that any pair from among these four vectors are linearly\nindependent, except possibly on M0. Note that projection can only be performed\nafter the full calculation of the relevant commutator. Because the commutators\nquickly become quite messy, we used a symbolic computing package to assist in\nthese calculations.\nThe ﬁrst two vectors are:\nu0 D p@q \u0003 .q C \u0013p/@p \u0003 .\u0013\u00121 C \u00121\u00122/@\u00121;\n(8.48)\nand\nu1 D \u0007p @\u0013\n@\u00122\n@p C \u00121\n\b\n1 C @\u0013\n@\u00122\n\t\n@\u00121:\n(8.49)\nAfter expanding the derivatives of \u0013 we have\nu1 D p@q C \u00122\n1\n\b\u0003q C p\u00122\nD\n\t\n@p \u0003 2\u00121p\n\b\u0003q C p\u00122\nD\n\t\n@\u00121;\n(8.50)\nand\nu2 D \u0003\u0007.\u00122\n1p=D/@p C .2\u0007\u00121p2=D/@\u00121;\n(8.51)\nwhere D D 2p2 C \u00122\n1.\nIf q ¤ 0 and p ¤ 0, then clearly u1 and u2 are linearly independent. However, if\np D 0 then u2 D 0. We proceed to compute the commutator Œf; Œf; g\t\t. Projecting to\nthe ﬁrst three components results in\nu2 D \u0007\n\b\u00122\n1p\nD\n\t\n@q \u0003 \u0007\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@p C 2\u0007\u00121p\n\b2\np3 C \n\u00122\n1p \u0003 \u00122\n1q\nD2\n\t\n@\u00121:\n(8.52)\nAgain, we substitute p D 0 and ﬁnd that\nu2jpD0 D .\u0007\u00122\n1q=D2/@p:\n(8.53)\nUnfortunately, this is parallel to u1 (for p D 0), and hence yet one more commutator\nis required in this case.\n"
    }
  ],
  "numbered_equations": [
    "8.48",
    "8.49",
    "8.50",
    "8.51",
    "8.52",
    "8.53"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "总化分式只在θ>0的约束面D=2θ>0使用；实际交换子先在四维完整计算再投影。",
    "本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。"
  ],
  "issues": [
    "已目视核对原页PDF388：(8.50)的u₁公式实际重写u₀，(8.51)的u₂公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。"
  ],
  "statement_scope": "原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。",
  "lean_decl": "MD.Ch08.bracket4",
  "lean_declarations": [
    "MD.Ch08.bracket4",
    "MD.Ch08.sinBracket",
    "MD.Ch08.projectFirstThree",
    "MD.Ch08.sinD",
    "MD.Ch08.sinU0Printed",
    "MD.Ch08.sinU1Printed",
    "MD.Ch08.sinU2Printed",
    "MD.Ch08.sinU1DerivativePrinted",
    "MD.Ch08.sinProjected_corrected",
    "MD.Ch08.sinU2LongPrinted",
    "MD.Ch08.sinU2Long_at_p0"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bracket4 (f g : Vec 4 → Vec 4) (z : Vec 4) : Vec 4 :=
  fderiv ℝ g z (f z)-fderiv ℝ f z (g z)
def sinBracket (θ γ : ℝ) : ℕ → Vec 4 → Vec 4
  | 0 => sinHarmonicF θ γ
  | 1 => bracket4 (sinHarmonicF θ γ) (fun _ ↦ sinHarmonicG θ γ)
  | k+2 => bracket4 (sinHarmonicF θ γ) (sinBracket θ γ (k+1))
def projectFirstThree (z : Vec 4) : Vec 3 := ![z 0,z 1,z 2]
def sinD (z : Vec 4) : ℝ := 2*z 1^2+z 2^2
def sinU0Printed (z : Vec 4) : Vec 3 :=
  ![z 1,z 2^2*(-z 0+z 1*z 3)/sinD z,-2*z 2*z 1*(-z 0+z 1*z 3)/sinD z]
def sinU1Printed (z : Vec 4) : Vec 3 := sinU0Printed z
def sinU2Printed (σ : ℝ) (z : Vec 4) : Vec 3 :=
  ![0,-σ*z 2^2*z 1/sinD z,2*σ*z 2*z 1^2/sinD z]
def sinU1DerivativePrinted (σ : ℝ) (z : Vec 4) : Vec 3 :=
  let d := fderiv ℝ (sinMultiplier 1 (fun q ↦ -q)) z (Pi.single 3 1)
  ![0,σ*z 1*d,z 2*(1+d)]
def sinProjected_corrected (θ γ : ℝ) (j : Fin 4) (z : Vec 4) : Vec 3 :=
  projectFirstThree (sinBracket θ γ j z)
def sinU2LongPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  let a := (2*γ*z 1^3+γ*z 2^2*z 1-z 2^2*z 0)/(sinD z)^2
  ![σ*z 2^2*z 1/sinD z,-σ*a,2*σ*z 2*z 1*a]
theorem sinU2Long_at_p0 (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) :
    sinU2LongPrinted σ γ z = ![0,σ*z 2^2*z 0/(sinD z)^2,0] := by
  ext i; fin_cases i <;> simp [sinU2LongPrinted,hp] <;> ring
```

## MD-8.6.2-SINThirdBracketPrinted
```json
{
  "source_id": "MD-8.6.2-SINThirdBracketPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "8.6.2",
  "printed_page": "368",
  "pdf_page": "389",
  "statement_latex": "The third projected commutator is displayed in (8.54), with polynomial η in (8.55); its p=0 specialization is printed as u₃=-2σq∂q-σq(-γ+ξ₂)∂p in (8.56).",
  "statement_verbatim": "368\n8\nExtended Variable Methods\nWe calculate Œf; Œf; Œf; g\t\t\t and project onto the space spanned by the ﬁrst three\ncomponents to ﬁnd\nu3 D \u0007\n\b2\np3 \u0003 4p3\u00122 C 4p2q C \u00122\n1p\u00122 C \n\u00122\n1p \u0003 2\u00122\n1q\nD2\n\t\n@q\n\u0003 \u0007\u00122\n1\n\u0006 \u000f\nD3\n\u0007\n@p C 2\u0007\u00121p\n\u0006 \u000f\nD3\n\u0007\n@\u00121:\n(8.54)\nwith\n\u000f D 4p5\n2 \u0003 8p5\u00122\n1 \u0003 4\u00122\n1p3 C 4p3\n2\u00122\n1 \u0003 4p3\u00124\n1\n\u0003 2\n\u00122\n1p2q C 4p2q\u00122\u00122\n1 \u0003 4\u00122\n1q2p \u0003 2\u00124\n1p C p\n2\u00124\n1 \u0003 q\n\u00124\n1 C \u00124\n1\u00122q:\n(8.55)\nAlong p D 0, u3 becomes\nu3jpD0 D \u00032\u0007q@q \u0003 \u0007\n\b\u0003q\n\u00124\n1 C \u00124\n1\u00122q\n\u00124\n1\n\t\n@p\nD \u00032\u0007q@q \u0003 \u0007q.\u0003\n C \u00122/@p:\n(8.56)\nTogether with u0 we obtain a linearly independent set as long as q ¤ 0.\nIf p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly\nindependent. If q ¤ 0 then u3 and u0 are linearly independent. From these we\nestablish that the Hörmander condition holds everywhere except on a space of co-\ndimension 2 (that is except on the one-dimensional set M0).\nIn this case, it is possible to complete the proof by introducing a Lyapunov\nfunction \b to demonstrate the necessary contractivity in the \u00122 direction. The\ngenerator of this system is\nLisok D p @\n@q C\n\nF \u0003 .p2=\u0017/F\n\u000b @\n@p \u0003 p\u00121F\n\u0017\n@\n@\u00121\nC LN C LO\nwith \u0017 D p2 C \u00122\n1=2,\nLN D 1\n2\n\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC Œ\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nand\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n",
  "verbatim_scope": "完整对应原页文字层，逐字保留；本条数学成分由statement_latex及statement_scope定位。",
  "proof_latex": null,
  "proof_note": "对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 389,
      "printed_page": 368,
      "text": "368\n8\nExtended Variable Methods\nWe calculate Œf; Œf; Œf; g\t\t\t and project onto the space spanned by the ﬁrst three\ncomponents to ﬁnd\nu3 D \u0007\n\b2\np3 \u0003 4p3\u00122 C 4p2q C \u00122\n1p\u00122 C \n\u00122\n1p \u0003 2\u00122\n1q\nD2\n\t\n@q\n\u0003 \u0007\u00122\n1\n\u0006 \u000f\nD3\n\u0007\n@p C 2\u0007\u00121p\n\u0006 \u000f\nD3\n\u0007\n@\u00121:\n(8.54)\nwith\n\u000f D 4p5\n2 \u0003 8p5\u00122\n1 \u0003 4\u00122\n1p3 C 4p3\n2\u00122\n1 \u0003 4p3\u00124\n1\n\u0003 2\n\u00122\n1p2q C 4p2q\u00122\u00122\n1 \u0003 4\u00122\n1q2p \u0003 2\u00124\n1p C p\n2\u00124\n1 \u0003 q\n\u00124\n1 C \u00124\n1\u00122q:\n(8.55)\nAlong p D 0, u3 becomes\nu3jpD0 D \u00032\u0007q@q \u0003 \u0007\n\b\u0003q\n\u00124\n1 C \u00124\n1\u00122q\n\u00124\n1\n\t\n@p\nD \u00032\u0007q@q \u0003 \u0007q.\u0003\n C \u00122/@p:\n(8.56)\nTogether with u0 we obtain a linearly independent set as long as q ¤ 0.\nIf p D 0 and q D 0 then we are on M0. If p ¤ 0 then u2 and u0 are linearly\nindependent. If q ¤ 0 then u3 and u0 are linearly independent. From these we\nestablish that the Hörmander condition holds everywhere except on a space of co-\ndimension 2 (that is except on the one-dimensional set M0).\nIn this case, it is possible to complete the proof by introducing a Lyapunov\nfunction \b to demonstrate the necessary contractivity in the \u00122 direction. The\ngenerator of this system is\nLisok D p @\n@q C\n\nF \u0003 .p2=\u0017/F\n\u000b @\n@p \u0003 p\u00121F\n\u0017\n@\n@\u00121\nC LN C LO\nwith \u0017 D p2 C \u00122\n1=2,\nLN D 1\n2\n\u00122\n1\u00122p\n\u0017\n@\n@p C 1\n2\n\u00123\n1\u00122\n\u0017\n@\n@\u00121\n\u0003 \u00122\u00121\n@\n@\u00121\nC Œ\u00122\n1 \u0003 ˇ\u00021\t @\n@\u00122\n;\nand\nLO D \u0003\n\u00122\n@\n@\u00122\nC \u00072\n2\n@2\n@\u00122\n2\n:\n"
    }
  ],
  "numbered_equations": [
    "8.54",
    "8.55",
    "8.56"
  ],
  "transcription_note": "文字层逐字保留；数学排版另行转写，原页中的特殊字形编码不静默替换。PDF420仅取Exercises之前。",
  "context_notation": [],
  "extra_assumptions": [
    "ξ₁≠0用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。"
  ],
  "issues": [
    "已目视核对原页PDF389：(8.54)q分量代p=0得到-2σq/ξ₁²，(8.56)遗漏ξ₁²分母；原印多项式的其他系数仍待独立微分核对。"
  ],
  "statement_scope": "原印三重交换子候选及p=0内部代数核对；真实三重交换子等式列覆盖缺口。",
  "lean_decl": "MD.Ch08.sinEtaPrinted",
  "lean_declarations": [
    "MD.Ch08.sinEtaPrinted",
    "MD.Ch08.sinU3Printed",
    "MD.Ch08.sinU3ZeroPrinted",
    "MD.Ch08.sinU3Zero_corrected",
    "MD.Ch08.sinU3Zero_specialize"
  ],
  "source_page_verification": "见source_page_checks.json，已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def sinEtaPrinted (γ : ℝ) (z : Vec 4) : ℝ :=
  4*z 1^5*γ^2-8*z 1^5*z 2^2-4*z 2^2*z 1^3+4*z 1^3*γ^2*z 2^2-4*z 1^3*z 2^4-
  2*γ*z 2^2*z 1^2*z 0+4*z 1^2*z 0*z 3*z 2^2-4*z 2^2*z 0^2*z 1-
  2*z 2^4*z 1+z 1*γ^2*z 2^4-z 0*γ*z 2^4+z 2^4*z 3*z 0
def sinU3Printed (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![σ*(2*γ*z 1^3-4*z 1^3*z 3+4*z 1^2*z 0+z 2^2*z 1*z 3+γ*z 2^2*z 1-2*z 2^2*z 0)/(sinD z)^2,
    -σ*z 2^2*sinEtaPrinted γ z/(sinD z)^3,2*σ*z 2*z 1*sinEtaPrinted γ z/(sinD z)^3]
def sinU3ZeroPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0,-σ*z 0*(-γ+z 3),0]
def sinU3Zero_corrected (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0/z 2^2,-σ*z 0*(-γ+z 3),0]
theorem sinU3Zero_specialize (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) (hξ : z 2 ≠ 0) :
    sinU3Printed σ γ z = sinU3Zero_corrected σ γ z := by
  ext i; fin_cases i <;> simp [sinU3Printed,sinU3Zero_corrected,sinEtaPrinted,sinD,hp]
    <;> field_simp [hξ] <;> ring
```
