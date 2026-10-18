# BATCH17 第7章原文与陈述审校

## MD-7.9.3-ZeroFrictionVerlet
```json
{
  "source_id": "MD-7.9.3-ZeroFrictionVerlet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.3",
  "printed_page": "306",
  "pdf_page": "327",
  "statement_latex": "An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $\\gamma=0$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.",
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
    "OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.zeroFrictionOU",
  "lean_declarations": [
    "MD.Ch07.zeroFrictionOU",
    "MD.Ch07.zeroFrictionBAOAB"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  funext x
  have ha : driftStep m (h/2) (driftStep m (h/2) (kickStep U (h/2) x)) =
      driftStep m h (kickStep U (h/2) x) := by
    ext i <;> dsimp [driftStep] <;> ring
  simp only [baoab,Function.comp_apply,zeroFrictionOU]
  rw [ha]
```

## MD-7.11.1-TemperatureObservables
```json
{
  "source_id": "MD-7.11.1-TemperatureObservables",
  "kind": "unnumbered_claim",
  "label": "(7.41)–(7.42)",
  "section": "7.11.1",
  "printed_page": "310",
  "pdf_page": "331",
  "statement_latex": "Indeed, calculating the temperature of the system from an average of kinetic energy by\n\\[N_dk_BT=\\langle p^TM^{-1}p\\rangle,\\tag{7.41}\\]\ngives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature\n\\[N_dk_BT=\\langle q\\cdot\\nabla U(q)\\rangle.\\tag{7.42}\\]\nWere one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 331,
      "printed_page": 310,
      "text": "310\n7\nNumerical Methods for Stochastic Molecular Dynamics\nexploration rate. The spectral properties of the operator L\u0004\nLD guarantee that we will\nexplore the entire phase space (ergodicity), while the relatively small perturbations\nto the operator induced by numerical discretization are hoped not to signiﬁcantly\nalter the rate of search. Ultimately, pushing the timestep up is the only way to\nbreach timescale gaps when computing trajectories, although this comes at the cost\nof corruption of the long-time averages.\nThe self-diffusion coefﬁcient gives a metric quantifying the diffusion rate. It is\noften used as a way to compare the rate of phase space exploration between methods,\nand is typically calculated using the integral of the velocity auto-correlation\nfunction. However, in theory one can construct arbitrary methods to artiﬁcially scale\nthe velocity auto-correlation function, hence giving inaccurate diffusion constants:\nthe momentum sampled may not be the momentum we use to propagate the position\nwith.\nIndeed, calculating the temperature of the system from an average of kinetic\nenergy by\nNdkBT D\n˝\npTM\u00021p\n˛\n;\n(7.41)\ngives a similar problem. Using Proposition 6.1 we may formulate many alternative\nfunctions whose averages are proportional to the system temperature [193, 211,\n319]. Such observables are normally based on the periodic forces of the system\nin order to work in periodic boundary conditions; in the following experiments we\nshall use the conﬁgurational temperature\nNdkBT D hq \u0002 rU.q/i:\n(7.42)\nWere one able to solve the dynamics exactly, the kinetic and conﬁgurational\ntemperatures would of course be equal. However, using a numerical method in the\nlarge-timestep regime we instead sample expectations with respect to the perturbed\ndensity O\u0005, that may introduce discrepancies between conﬁgurational and kinetic\ntemperatures. Often conﬁguration-based temperature calculation is more useful and\nrelevant for assessing the quality of conﬁgurational sampling methods.\nIn a similar way, the speed of exploration of the space should not be determined\nsolely from functions of momentum. Far more reliable is to compute conﬁgurational\nquantities such as barrier crossing rates, passage times to reach some target region\nof phase space or the diffusion constant through an Einstein relation (which uses the\nposition data).\nThe friction parameter is free in Langevin dynamics when it is used purely as\na sampling method; we know that for any \n > 0 we will obtain states from an\napproximate canonical distribution, though it is unclear what value of \n we should\nchoose in our simulation. From our analysis in Sect. 7.9.3, we have seen that the\n\u0002BAOAB\u0003 scheme has a superconvergence property in the limit of large friction,\ngiving us higher accuracy O.h4/ conﬁgurational averages. However, it is unclear\nwhat the scheme’s behavior is in the middle-to-low friction limit, as we did not give\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。",
    "构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.kineticTemperatureObservable",
  "lean_declarations": [
    "MD.Ch07.kineticTemperatureObservable",
    "MD.Ch07.configurationTemperatureObservable",
    "MD.Ch07.kineticTemperature",
    "MD.Ch07.configurationTemperature"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry
```

## MD-7.11.1-VelocityAutocorrelationDefinition
```json
{
  "source_id": "MD-7.11.1-VelocityAutocorrelationDefinition",
  "kind": "definition",
  "label": null,
  "section": "7.11.1",
  "printed_page": "310",
  "pdf_page": "331",
  "statement_latex": "The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 331,
      "printed_page": 310,
      "text": "310\n7\nNumerical Methods for Stochastic Molecular Dynamics\nexploration rate. The spectral properties of the operator L\u0004\nLD guarantee that we will\nexplore the entire phase space (ergodicity), while the relatively small perturbations\nto the operator induced by numerical discretization are hoped not to signiﬁcantly\nalter the rate of search. Ultimately, pushing the timestep up is the only way to\nbreach timescale gaps when computing trajectories, although this comes at the cost\nof corruption of the long-time averages.\nThe self-diffusion coefﬁcient gives a metric quantifying the diffusion rate. It is\noften used as a way to compare the rate of phase space exploration between methods,\nand is typically calculated using the integral of the velocity auto-correlation\nfunction. However, in theory one can construct arbitrary methods to artiﬁcially scale\nthe velocity auto-correlation function, hence giving inaccurate diffusion constants:\nthe momentum sampled may not be the momentum we use to propagate the position\nwith.\nIndeed, calculating the temperature of the system from an average of kinetic\nenergy by\nNdkBT D\n˝\npTM\u00021p\n˛\n;\n(7.41)\ngives a similar problem. Using Proposition 6.1 we may formulate many alternative\nfunctions whose averages are proportional to the system temperature [193, 211,\n319]. Such observables are normally based on the periodic forces of the system\nin order to work in periodic boundary conditions; in the following experiments we\nshall use the conﬁgurational temperature\nNdkBT D hq \u0002 rU.q/i:\n(7.42)\nWere one able to solve the dynamics exactly, the kinetic and conﬁgurational\ntemperatures would of course be equal. However, using a numerical method in the\nlarge-timestep regime we instead sample expectations with respect to the perturbed\ndensity O\u0005, that may introduce discrepancies between conﬁgurational and kinetic\ntemperatures. Often conﬁguration-based temperature calculation is more useful and\nrelevant for assessing the quality of conﬁgurational sampling methods.\nIn a similar way, the speed of exploration of the space should not be determined\nsolely from functions of momentum. Far more reliable is to compute conﬁgurational\nquantities such as barrier crossing rates, passage times to reach some target region\nof phase space or the diffusion constant through an Einstein relation (which uses the\nposition data).\nThe friction parameter is free in Langevin dynamics when it is used purely as\na sampling method; we know that for any \n > 0 we will obtain states from an\napproximate canonical distribution, though it is unclear what value of \n we should\nchoose in our simulation. From our analysis in Sect. 7.9.3, we have seen that the\n\u0002BAOAB\u0003 scheme has a superconvergence property in the limit of large friction,\ngiving us higher accuracy O.h4/ conﬁgurational averages. However, it is unclear\nwhat the scheme’s behavior is in the middle-to-low friction limit, as we did not give\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。",
    "已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.velocityAutocorrelation",
  "lean_declarations": [
    "MD.Ch07.velocityAutocorrelation",
    "MD.Ch07.greenKuboDiffusion",
    "MD.Ch07.autocorrelation_rescale"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]
```

## MD-7.12-ConstrainedLangevin
```json
{
  "source_id": "MD-7.12-ConstrainedLangevin",
  "kind": "definition",
  "label": "(7.43)–(7.45)",
  "section": "7.12",
  "printed_page": "317",
  "pdf_page": "338",
  "statement_latex": "\\[dq=M^{-1}pdt,\\tag{7.43}\\]\n\\[dp=-\\nabla U(q)dt-\\gamma pdt+\\sqrt{2\\gamma k_BTM}dW-g'(q)^T\\lambda dt,\\tag{7.44}\\]\n\\[0=g(q).\\tag{7.45}\\]\nThe vector of $l$ constraints is given by $g:\\mathbb R^{N_c}\\to\\mathbb R^l$ and $\\lambda$ is an $l$-dimensional vector of Lagrange multipliers. $W$ is a vector of standard Wiener processes, with the usual friction parameter $\\gamma>0$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint\n\\[g(q)=0,\\qquad g'(q)M^{-1}p=0.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 338,
      "printed_page": 317,
      "text": "7.12\nConstrained Langevin Dynamics\n317\n7.12\nConstrained Langevin Dynamics\nWe may use a splitting approach to develop discretization algorithms for other forms\nof dynamics. In Chap. 4, we included holonomic constraints to the ODEs deﬁning\nconstant-energy Hamiltonian dynamics, as a way to increase the stability of our\nalgorithms and increase the usable timestep. We can add constraints to the Langevin\ndynamics SDEs similarly as\ndq D M\u00021pdt;\n(7.43)\ndp D \u0003rU.q/dt \u0003 \npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt;\n(7.44)\n0 D g.q/;\n(7.45)\nwhere the vector of l constraints is given by g W RNc ! Rl and \f is an l-dimensional\nvector of Lagrange multipliers. W is a vector of standard Wiener processes, with\nthe usual friction parameter \n > 0. As in the constant energy dynamics, permissible\nphase points lie in the co-tangent bundle deﬁned by the constraint and hidden\nconstraint\ng.q/ D 0;\ng0.q/M\u00021p D 0;\nwhile in the inﬁnite time limit, we have that solution trajectories of constrained\nLangevin (7.43)–(7.45) sample Q\u0005ˇ ergodically, such that\nlim\nT!1\n1\nT\nT\nZ\n0\n\b.q.t/; p.t//dt D\nZ\nD\n\b.q; p/ Q\u0005ˇd!;\nwhere Q\u0005ˇ is the normalized constrained canonical distribution\nQ\u0005ˇ D Z\u00021 exp.\u0003ˇH.q; p//ıŒg.q/\tıŒg0.q/M\u00021p\t;\nfor normalizing constant Z and where ıŒz\t :D Q\ni ıŒzi\t for a vector z. The goal is\nnow to ﬁnd solutions to the constrained dynamics, in order to sample the target\ndistribution.\nOne approach for algorithms is simply to evolve unconstrained Langevin dynam-\nics using any algorithm of choice, then follow each step by a step of the SHAKE\nalgorithm (see Chapter 4 or [322]) to pull the system back on to the manifold\nsatisfying the holonomic constraints.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。",
    "定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。"
  ],
  "issues": [],
  "statement_scope": "全部约束积分方程及隐约束资格；适应性作为解资格显式保留，存在唯一性未证明。",
  "lean_decl": "MD.Ch07.constraintJacobian",
  "lean_declarations": [
    "MD.Ch07.constraintJacobian",
    "MD.Ch07.constraintReaction",
    "MD.Ch07.hiddenConstraint",
    "MD.Ch07.cotangentConstraint",
    "MD.Ch07.constrainedLangevin"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (multiplier : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*multiplier j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))
```

## MD-7.12-ConstrainedCanonicalErgodicity
```json
{
  "source_id": "MD-7.12-ConstrainedCanonicalErgodicity",
  "kind": "definition",
  "label": null,
  "section": "7.12",
  "printed_page": "317",
  "pdf_page": "338",
  "statement_latex": "In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\\widetilde\\rho_\\beta$ ergodically, such that\n\\[\\lim_{T\\to\\infty}\\frac1T\\int_0^T\\phi(q(t),p(t))dt=\\int_{\\mathcal D}\\phi(q,p)\\widetilde\\rho_\\beta d\\omega,\\]\nwhere $\\widetilde\\rho_\\beta$ is the normalized constrained canonical distribution\n\\[\\widetilde\\rho_\\beta=Z^{-1}\\exp(-\\beta H(q,p))\\delta[g(q)]\\delta[g'(q)M^{-1}p],\\]\nfor normalizing constant $Z$ and where $\\delta[z]:=\\prod_i\\delta[z_i]$ for a vector $z$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 338,
      "printed_page": 317,
      "text": "7.12\nConstrained Langevin Dynamics\n317\n7.12\nConstrained Langevin Dynamics\nWe may use a splitting approach to develop discretization algorithms for other forms\nof dynamics. In Chap. 4, we included holonomic constraints to the ODEs deﬁning\nconstant-energy Hamiltonian dynamics, as a way to increase the stability of our\nalgorithms and increase the usable timestep. We can add constraints to the Langevin\ndynamics SDEs similarly as\ndq D M\u00021pdt;\n(7.43)\ndp D \u0003rU.q/dt \u0003 \npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt;\n(7.44)\n0 D g.q/;\n(7.45)\nwhere the vector of l constraints is given by g W RNc ! Rl and \f is an l-dimensional\nvector of Lagrange multipliers. W is a vector of standard Wiener processes, with\nthe usual friction parameter \n > 0. As in the constant energy dynamics, permissible\nphase points lie in the co-tangent bundle deﬁned by the constraint and hidden\nconstraint\ng.q/ D 0;\ng0.q/M\u00021p D 0;\nwhile in the inﬁnite time limit, we have that solution trajectories of constrained\nLangevin (7.43)–(7.45) sample Q\u0005ˇ ergodically, such that\nlim\nT!1\n1\nT\nT\nZ\n0\n\b.q.t/; p.t//dt D\nZ\nD\n\b.q; p/ Q\u0005ˇd!;\nwhere Q\u0005ˇ is the normalized constrained canonical distribution\nQ\u0005ˇ D Z\u00021 exp.\u0003ˇH.q; p//ıŒg.q/\tıŒg0.q/M\u00021p\t;\nfor normalizing constant Z and where ıŒz\t :D Q\ni ıŒzi\t for a vector z. The goal is\nnow to ﬁnd solutions to the constrained dynamics, in order to sample the target\ndistribution.\nOne approach for algorithms is simply to evolve unconstrained Langevin dynam-\nics using any algorithm of choice, then follow each step by a step of the SHAKE\nalgorithm (see Chapter 4 or [322]) to pull the system back on to the manifold\nsatisfying the holonomic constraints.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。",
    "实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。"
  ],
  "issues": [],
  "statement_scope": "全部分布及遍历平均目标的测度定义；约束参考测度存在与具体过程的遍历定理仍缺。",
  "lean_decl": "MD.Ch07.constrainedCanonical",
  "lean_declarations": [
    "MD.Ch07.constrainedCanonical",
    "MD.Ch07.constrainedReference",
    "MD.Ch07.constrainedErgodicAverages"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))
```

## MD-7.12-ConstrainedHOSplitting
```json
{
  "source_id": "MD-7.12-ConstrainedHOSplitting",
  "kind": "definition",
  "label": null,
  "section": "7.12",
  "printed_page": "318",
  "pdf_page": "339",
  "statement_latex": "We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses\n\\[H_c:\\quad dq=M^{-1}pdt,\\quad dp=-\\nabla U(q)dt-g'(q)^T\\lambda dt,\\quad g(q)=0,\\]\n\\[O_c:\\quad dq=0,\\quad dp=-\\gamma pdt+\\sqrt{2\\gamma k_BTM}dW-g'(q)^T\\lambda dt,\\quad g(q)=0.\\]\nWe solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $h$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $h/2$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 339,
      "printed_page": 318,
      "text": "318\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWe could instead consider splitting the dynamics up and performing the integra-\ntion using a splitting method. Such a splitting strategy is considered in [232] where\none uses\n2\n4\ndq\ndp\n0\n3\n5 D\n2\n4\nM\u00021pdt\n\u0003rU.q/dt \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nHc\nC\n2\n4\n0\n\u0003\npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nOc\n;\nsplitting the dynamics into two pieces: the constrained Hamiltonian (NVE) equa-\ntions, and a constrained Ornstein-Uhlenbeck piece.\nWe solve these two pieces symmetrically, where the constrained Hamiltonian\npart is solved over a step h, in between two solves of the Ornstein-Uhlenbeck\nSDE with stepsize h=2. The SHAKE (or RATTLE) algorithm can be used to solve\nthe constrained Hamiltonian part to a high degree of accuracy, while solving the\nOrnstein-Uhlenbeck piece along the manifold amounts to ﬁnding the solution of a\nlinear system. We observe the constraint in both solutions, so that the computed\npoints lie in the co-tangent bundle of the constraint manifold. Instead of solving the\nOrnstein-Uhlenbeck exactly, we discretize using a midpoint Euler scheme, yielding\nthe following scheme:\nMidpoint Euler - Verlet - Midpoint Euler (see [232])\nSolve\n(\npnC1=4 D pn \u0002 h\n4 .pn C pnC1=4/ C ph\nkBTMRn \u0002 g0.qn/T\fnC1=4\nSuch that g0.qn/M\u00021pnC1=4 D 0\nSolve\n8\nˆˆˆ<\nˆˆˆ:\npnC1=2 D pnC1=4 \u0002 h\n2rU.qn/ \u0002 g0.qn/T\fnC1=2\nqnC1 D qn C hM\u00021pnC1=2\npnC3=4 D pnC1=2 \u0002 h\n2rU.qnC1/ \u0002 g0.qnC1/T\fnC3=4\nSuch that g0.qnC1/M\u00021pnC3=4 D 0 and g.qnC1/ D 0:\nSolve\n(\npnC1 D pnC3=4 \u0002 h\n4 .pnC3=4 C pnC1/ C ph\nkBTMRnC1=2 \u0002 g0.qnC1/T\fnC1\nSuch that g0.qnC1/M\u00021pnC1 D 0\nThe vectors Rn and RnC1=2 are vectors of N.0; 1/ i.i.d. random numbers, with \n \b 0\nthe usual Langevin dynamics friction parameter. Setting \n D 0 reduces the scheme\nto the usual RATTLE scheme for solving holonomically constrained Hamiltonian\nequations of motion, whereas if \n is chosen large then this will be expected to\ncause instability in the scheme, as we are not solving the OU process exactly. The\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。",
    "每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.constrainedHField",
  "lean_declarations": [
    "MD.Ch07.constrainedHField",
    "MD.Ch07.constrainedOField",
    "MD.Ch07.constrainedHOComposition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)
```
