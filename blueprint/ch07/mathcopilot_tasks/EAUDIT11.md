# EAUDIT11 第7章修改后陈述复审

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
    "定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。",
    "29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。"
  ],
  "issues": [],
  "statement_scope": "原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。",
  "lean_decl": "MD.Ch07.constraintJacobian",
  "lean_declarations": [
    "MD.Ch07.constraintJacobian",
    "MD.Ch07.constraintReaction",
    "MD.Ch07.hiddenConstraint",
    "MD.Ch07.cotangentConstraint",
    "MD.Ch07.constrainedLangevin",
    "MD.Ch07.constrainedLangevin_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "NEEDS_HUMAN",
      "suggested_fix": "保留原印并标[ERRATUM?]；人工确认λdt是否代表含dW的乘子冲量。标准修正版应使用投影噪声和匹配漂移，或允许随机约束乘子微分；把适应性及强解限制标[EXTRA]，不补存在性证明。",
      "actual_scope": "原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。",
    "29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。"
  ]
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

/-- 限制到单位质量、常正交投影的线性约束修正版；未声称一般非线性情形。 -/
def constrainedLangevin_corrected {l : ℕ} (P : Measure Ω) (C : Matrix (Fin l) (Fin n) ℝ)
    (proj : Matrix (Fin n) (Fin n) ℝ) (U : V n → ℝ) (γ θ : ℝ)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 U ∧
  proj*proj=proj ∧ proj.transpose=proj ∧ C*proj=0 ∧
  (∀ v : V n, C *ᵥ v=0 → proj *ᵥ v=v) ∧
  C *ᵥ x0.1=0 ∧ C *ᵥ x0.2=0 ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    C *ᵥ (X t sample).1=0 ∧ C *ᵥ (X t sample).2=0 ∧
    (∀ i, (X t sample).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i) ∧
    ∀ i, (X t sample).2 i=x0.2 i+
      (∫ s in (0 : ℝ)..t, -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i)+
      Real.sqrt (2*γ*θ)*(proj *ᵥ (W t sample-W 0 sample)) i
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
    "实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。",
    "29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。"
  ],
  "issues": [],
  "statement_scope": "delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。",
  "lean_decl": "MD.Ch07.constrainedCanonical",
  "lean_declarations": [
    "MD.Ch07.constrainedCanonical",
    "MD.Ch07.constrainedReference",
    "MD.Ch07.constrainedErgodicAverages",
    "MD.Ch07.constrainedCanonicalQualification"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "NEEDS_HUMAN",
      "suggested_fix": "保留原印并标[ERRATUM?]；明确delta参考测度与几何体积的换算，加入正有限配分积分、正则满秩/连通等资格。补把SDE、参考测度、canonical概率和遍历极限连接的完整目标签名。",
      "actual_scope": "delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。"
  ]
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

def constrainedCanonicalQualification {l : ℕ} (ν : Measure (Phase n))
    (m : V n) (g : V n → V l) (U : V n → ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ContDiff ℝ 2 g ∧ constrainedReference ν m g ∧
  Integrable (gibbsWeight m U β) ν ∧ (0 < ∫ x, gibbsWeight m U β x ∂ν)
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
    "每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。",
    "29号覆盖限定：H/O总化漂移、O扩散，以及两段各自受约束积分解规格；组合仍为代数辅助，未构造随机核及两次独立噪声组合。",
    "H/O漂移与O扩散、各段约束保持的积分解规格、满足这些规格的H/O随机映射组合；两次O用乘积概率空间的独立样本。未构造这些解的存在性或一般非线性投影漂移理论。"
  ],
  "issues": [],
  "statement_scope": "H/O漂移与O扩散、各段约束保持的积分解规格、满足这些规格的H/O随机映射组合；两次O用乘积概率空间的独立样本。未构造这些解的存在性或一般非线性投影漂移理论。",
  "lean_decl": "MD.Ch07.constrainedHField",
  "lean_declarations": [
    "MD.Ch07.constrainedHField",
    "MD.Ch07.constrainedOField",
    "MD.Ch07.constrainedHOComposition",
    "MD.Ch07.constrainedONoise",
    "MD.Ch07.constrainedHIntegralStep",
    "MD.Ch07.constrainedOIntegralStep",
    "MD.Ch07.constrainedHMapQualification",
    "MD.Ch07.constrainedOMapQualification",
    "MD.Ch07.constrainedHOQualifiedComposition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "补Hc/Oc的积分解或随机核规格、Oc扩散和各段cotangentConstraint保持，并把H/O参数约束为这些解/核；分步乘子分别指定，保留当前组合为辅助定义。",
      "actual_scope": "H/O总化漂移、O扩散，以及两段各自受约束积分解规格；组合仍为代数辅助，未构造随机核及两次独立噪声组合。",
      "signature_changed": true
    },
    {
      "instruction": 29,
      "supplement": "补过程Markov条件分布或H/O解资格连接",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。"
  ]
}
```
```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)

def constrainedONoise (m : V n) (γ θ : ℝ) (j : Fin n) : Phase n :=
  (0,fun i ↦ if i=j then Real.sqrt (2*γ*θ*m i) else 0)

def constrainedHIntegralStep {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (X : ℝ → Phase n) (Λ : ℝ → V l) (x0 : Phase n) (T : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 g ∧ ContDiff ℝ 1 U ∧ 0 ≤ T ∧
  ContinuousOn X (Icc 0 T) ∧ X 0=x0 ∧
  (∀ t ∈ Icc 0 T, X t ∈ cotangentConstraint m g) ∧
  ∀ i, IntervalIntegrable (fun t ↦ (X t).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun t ↦ -gradient U (X t).1 i-
      constraintReaction g (X t).1 (Λ t) i) volume 0 T ∧
    ∀ t ∈ Icc 0 T,
      (X t).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s).2 i/m i ∧
      (X t).2 i=x0.2 i+∫ s in (0 : ℝ)..t,
        -gradient U (X s).1 i-constraintReaction g (X s).1 (Λ s) i

/-- O乘子冲量允许含随机部分；不把它限为有限变差的λdt。 -/
def constrainedOIntegralStep {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (reactionImpulse : ℝ → Ω → V n) (x0 : Phase n) (T : ℝ) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧ 0 ≤ T ∧
  (∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P, X t sample ∈ cotangentConstraint m g) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Icc 0 T) ∧
    X 0 sample=x0 ∧ reactionImpulse 0 sample=0) ∧
  (∀ sample i, IntervalIntegrable (fun t ↦ -γ*(X t sample).2 i) volume 0 T) ∧
  (∀ sample t, ∃ impulseCoeff : V l, reactionImpulse t sample=constraintReaction g x0.1 impulseCoeff) ∧
  (∀ t ∈ Icc 0 T, Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
      (reactionImpulse t)) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1 ∧ ∀ i,
      (X t sample).2 i=x0.2 i+(∫ s in (0 : ℝ)..t, -γ*(X s sample).2 i)-
        reactionImpulse t sample i+Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

def constrainedHMapQualification {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (H : ℝ → Phase n → Phase n) : Prop :=
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ Λ : ℝ → V l,
    constrainedHIntegralStep m U g (fun t ↦ H t x) Λ x T

def constrainedOMapQualification {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (O : ℝ → Ω → Phase n → Phase n) : Prop :=
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ reaction : ℝ → Ω → V n,
    constrainedOIntegralStep P m g γ θ W (fun t sample ↦ O t sample x) reaction x T

/-- 两次O使用乘积概率空间上的独立样本；H/O都须满足各自受约束解规格。 -/
def constrainedHOQualifiedComposition {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) :
    Ω × Ω → Phase n → Phase n :=
  fun sample x ↦ O (h/2) sample.2 (H h (O (h/2) sample.1 x))
```
