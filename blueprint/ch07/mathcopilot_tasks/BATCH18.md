# BATCH18 第7章原文与陈述审校

## MD-7.12-MEVMEAlgorithm
```json
{
  "source_id": "MD-7.12-MEVMEAlgorithm",
  "kind": "definition",
  "label": null,
  "section": "7.12",
  "printed_page": "318–319",
  "pdf_page": "339–340",
  "statement_latex": "Midpoint Euler - Verlet - Midpoint Euler (see [232])\n\\[p_{n+1/4}=p_n-\\tfrac{h\\gamma}4(p_n+p_{n+1/4})+\\sqrt{h\\gamma k_BTM}R_n-g'(q_n)^T\\lambda_{n+1/4},\\quad g'(q_n)M^{-1}p_{n+1/4}=0.\\]\n\\[p_{n+1/2}=p_{n+1/4}-\\tfrac h2\\nabla U(q_n)-g'(q_n)^T\\lambda_{n+1/2},\\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\]\n\\[p_{n+3/4}=p_{n+1/2}-\\tfrac h2\\nabla U(q_{n+1})-g'(q_{n+1})^T\\lambda_{n+3/4},\\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\\quad g(q_{n+1})=0.\\]\n\\[p_{n+1}=p_{n+3/4}-\\tfrac{h\\gamma}4(p_{n+3/4}+p_{n+1})+\\sqrt{h\\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\\lambda_{n+1},\\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 339,
      "printed_page": 318,
      "text": "318\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWe could instead consider splitting the dynamics up and performing the integra-\ntion using a splitting method. Such a splitting strategy is considered in [232] where\none uses\n2\n4\ndq\ndp\n0\n3\n5 D\n2\n4\nM\u00021pdt\n\u0003rU.q/dt \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nHc\nC\n2\n4\n0\n\u0003\npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nOc\n;\nsplitting the dynamics into two pieces: the constrained Hamiltonian (NVE) equa-\ntions, and a constrained Ornstein-Uhlenbeck piece.\nWe solve these two pieces symmetrically, where the constrained Hamiltonian\npart is solved over a step h, in between two solves of the Ornstein-Uhlenbeck\nSDE with stepsize h=2. The SHAKE (or RATTLE) algorithm can be used to solve\nthe constrained Hamiltonian part to a high degree of accuracy, while solving the\nOrnstein-Uhlenbeck piece along the manifold amounts to ﬁnding the solution of a\nlinear system. We observe the constraint in both solutions, so that the computed\npoints lie in the co-tangent bundle of the constraint manifold. Instead of solving the\nOrnstein-Uhlenbeck exactly, we discretize using a midpoint Euler scheme, yielding\nthe following scheme:\nMidpoint Euler - Verlet - Midpoint Euler (see [232])\nSolve\n(\npnC1=4 D pn \u0002 h\n4 .pn C pnC1=4/ C ph\nkBTMRn \u0002 g0.qn/T\fnC1=4\nSuch that g0.qn/M\u00021pnC1=4 D 0\nSolve\n8\nˆˆˆ<\nˆˆˆ:\npnC1=2 D pnC1=4 \u0002 h\n2rU.qn/ \u0002 g0.qn/T\fnC1=2\nqnC1 D qn C hM\u00021pnC1=2\npnC3=4 D pnC1=2 \u0002 h\n2rU.qnC1/ \u0002 g0.qnC1/T\fnC3=4\nSuch that g0.qnC1/M\u00021pnC3=4 D 0 and g.qnC1/ D 0:\nSolve\n(\npnC1 D pnC3=4 \u0002 h\n4 .pnC3=4 C pnC1/ C ph\nkBTMRnC1=2 \u0002 g0.qnC1/T\fnC1\nSuch that g0.qnC1/M\u00021pnC1 D 0\nThe vectors Rn and RnC1=2 are vectors of N.0; 1/ i.i.d. random numbers, with \n \b 0\nthe usual Langevin dynamics friction parameter. Setting \n D 0 reduces the scheme\nto the usual RATTLE scheme for solving holonomically constrained Hamiltonian\nequations of motion, whereas if \n is chosen large then this will be expected to\ncause instability in the scheme, as we are not solving the OU process exactly. The\n"
    },
    {
      "pdf_page": 340,
      "printed_page": 319,
      "text": "7.12\nConstrained Langevin Dynamics\n319\nLagrange multiplier \fnC1=4 (and likewise \fnC1) can be obtained by solving the\nlinear system\ng0.qn/M\u00021\n\u0002\b\n1 \u0003 h\n4\n\t\npn C\np\nh\nkBTMRn \u0003 g0.qn/T\fnC1=4\n\u0003\nD 0;\nwhich is easily computed once the Rn vector is evaluated in the step, and gives us a\nstability criterion\n\nh < 4:\n(7.46)\nA similar calculation and linear solve is needed to compute \fnC3=4 in order to\nmaintain the hidden constraint for pnC3=4, whereas the Lagrange multiplier \fnC1=2\nis responsible for ensuring that g.qnC1/ D 0, and is typically found using an implicit\nsolve.\nThere are many other ways we could choose to combine traditional molecular\ndynamics discretization schemes with constrained solvers such as variants of the\nSHAKE algorithm (see, for example [81, 383, 396]). The following section presents\nan alternative based upon the work on splitting methods in this chapter so far.\n7.12.1\nA “Geodesic Integrator”\nWe may consider alternative splittings of the dynamics in order to build a library of\navailable schemes, just as we did in the unconstrained case in Sect. 7.3.1. Solving\nthe constrained OU part exactly would allieviate the condition (7.46), while we\nmay hope to reduce discretization error in the spirit of the success of the \u0002BAOAB\u0003\nscheme in Sect. 7.9.3. The natural splitting template to consider would be to again\nsplit into potential and kinetic energies, with the constrained Ornstein-Uhlenbeck\npiece:\n2\n4\ndq\ndp\n0\n3\n5 D\n2\n4\nM\u00021pdt\n\u0003g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nAc\nC\n2\n4\n0\n\u0003rU.q/dt \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nBc\nC\n2\n4\n0\n\u0003\npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nOc\n:\nObserve that the holonomic constraint (as well as the hidden constraint) is main-\ntained in each part, changing the usual A piece into a geodesic drift along the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.midpointConstrainedORelation",
  "lean_declarations": [
    "MD.Ch07.midpointConstrainedORelation",
    "MD.Ch07.constrainedVerletRelation",
    "MD.Ch07.mevmeRelation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (multiplier : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (multiplier μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ multipliera multiplierb multiplierc multiplierd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa multipliera ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph multiplierb multiplierc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 multiplierd
```

## MD-7.12-MidpointStabilityPrinted
```json
{
  "source_id": "MD-7.12-MidpointStabilityPrinted",
  "kind": "unnumbered_claim",
  "label": "(7.46)",
  "section": "7.12",
  "printed_page": "319",
  "pdf_page": "340",
  "statement_latex": "The Lagrange multiplier $\\lambda_{n+1/4}$ (and likewise $\\lambda_{n+1}$) can be obtained by solving the linear system\n\\[g'(q_n)M^{-1}[(1-h\\gamma/4)p_n+\\sqrt{h\\gamma k_BTM}R_n-g'(q_n)^T\\lambda_{n+1/4}]=0,\\]\nwhich is easily computed once the $R_n$ vector is evaluated in the step, and gives us a stability criterion\n\\[\\gamma h<4.\\tag{7.46}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 340,
      "printed_page": 319,
      "text": "7.12\nConstrained Langevin Dynamics\n319\nLagrange multiplier \fnC1=4 (and likewise \fnC1) can be obtained by solving the\nlinear system\ng0.qn/M\u00021\n\u0002\b\n1 \u0003 h\n4\n\t\npn C\np\nh\nkBTMRn \u0003 g0.qn/T\fnC1=4\n\u0003\nD 0;\nwhich is easily computed once the Rn vector is evaluated in the step, and gives us a\nstability criterion\n\nh < 4:\n(7.46)\nA similar calculation and linear solve is needed to compute \fnC3=4 in order to\nmaintain the hidden constraint for pnC3=4, whereas the Lagrange multiplier \fnC1=2\nis responsible for ensuring that g.qnC1/ D 0, and is typically found using an implicit\nsolve.\nThere are many other ways we could choose to combine traditional molecular\ndynamics discretization schemes with constrained solvers such as variants of the\nSHAKE algorithm (see, for example [81, 383, 396]). The following section presents\nan alternative based upon the work on splitting methods in this chapter so far.\n7.12.1\nA “Geodesic Integrator”\nWe may consider alternative splittings of the dynamics in order to build a library of\navailable schemes, just as we did in the unconstrained case in Sect. 7.3.1. Solving\nthe constrained OU part exactly would allieviate the condition (7.46), while we\nmay hope to reduce discretization error in the spirit of the success of the \u0002BAOAB\u0003\nscheme in Sect. 7.9.3. The natural splitting template to consider would be to again\nsplit into potential and kinetic energies, with the constrained Ornstein-Uhlenbeck\npiece:\n2\n4\ndq\ndp\n0\n3\n5 D\n2\n4\nM\u00021pdt\n\u0003g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nAc\nC\n2\n4\n0\n\u0003rU.q/dt \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nBc\nC\n2\n4\n0\n\u0003\npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nOc\n:\nObserve that the holonomic constraint (as well as the hidden constraint) is main-\ntained in each part, changing the usual A piece into a geodesic drift along the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。"
  ],
  "issues": [
    "已目视核对PDF340／印刷319：所印γh<4保留为原书给出的限制。它保证中点OU放大因子为正；OU线性绝对稳定性本身对γh≥0均成立。原文没有写充要关系，不能把本条当作已确认的原书错误。完整耦合Verlet仍有独立步长限制。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.multiplierLinearSystem",
  "lean_declarations": [
    "MD.Ch07.multiplierLinearSystem",
    "MD.Ch07.midpointAmplification",
    "MD.Ch07.midpointStabilityPrinted",
    "MD.Ch07.midpointStabilityPrinted_corrected",
    "MD.Ch07.midpointStability_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (multiplier : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor
  · apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
  · apply (div_le_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]
```

## MD-7.12.1-ConstrainedABOSplitting
```json
{
  "source_id": "MD-7.12.1-ConstrainedABOSplitting",
  "kind": "definition",
  "label": null,
  "section": "7.12.1",
  "printed_page": "319–320",
  "pdf_page": "340–341",
  "statement_latex": "\\[A_c:\\quad dq=M^{-1}pdt,\\quad dp=-g'(q)^T\\lambda dt,\\quad g(q)=0,\\]\n\\[B_c:\\quad dq=0,\\quad dp=-\\nabla U(q)dt-g'(q)^T\\lambda dt,\\quad g(q)=0,\\]\n\\[O_c:\\quad dq=0,\\quad dp=-\\gamma pdt+\\sqrt{2\\gamma k_BTM}dW-g'(q)^T\\lambda dt,\\quad g(q)=0.\\]\nObserve that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $g(q)=0$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 340,
      "printed_page": 319,
      "text": "7.12\nConstrained Langevin Dynamics\n319\nLagrange multiplier \fnC1=4 (and likewise \fnC1) can be obtained by solving the\nlinear system\ng0.qn/M\u00021\n\u0002\b\n1 \u0003 h\n4\n\t\npn C\np\nh\nkBTMRn \u0003 g0.qn/T\fnC1=4\n\u0003\nD 0;\nwhich is easily computed once the Rn vector is evaluated in the step, and gives us a\nstability criterion\n\nh < 4:\n(7.46)\nA similar calculation and linear solve is needed to compute \fnC3=4 in order to\nmaintain the hidden constraint for pnC3=4, whereas the Lagrange multiplier \fnC1=2\nis responsible for ensuring that g.qnC1/ D 0, and is typically found using an implicit\nsolve.\nThere are many other ways we could choose to combine traditional molecular\ndynamics discretization schemes with constrained solvers such as variants of the\nSHAKE algorithm (see, for example [81, 383, 396]). The following section presents\nan alternative based upon the work on splitting methods in this chapter so far.\n7.12.1\nA “Geodesic Integrator”\nWe may consider alternative splittings of the dynamics in order to build a library of\navailable schemes, just as we did in the unconstrained case in Sect. 7.3.1. Solving\nthe constrained OU part exactly would allieviate the condition (7.46), while we\nmay hope to reduce discretization error in the spirit of the success of the \u0002BAOAB\u0003\nscheme in Sect. 7.9.3. The natural splitting template to consider would be to again\nsplit into potential and kinetic energies, with the constrained Ornstein-Uhlenbeck\npiece:\n2\n4\ndq\ndp\n0\n3\n5 D\n2\n4\nM\u00021pdt\n\u0003g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nAc\nC\n2\n4\n0\n\u0003rU.q/dt \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nBc\nC\n2\n4\n0\n\u0003\npdt C\np\n2\nkBTMdW \u0003 g0.q/T\fdt\ng.q/\n3\n5\n„\nƒ‚\n…\nOc\n:\nObserve that the holonomic constraint (as well as the hidden constraint) is main-\ntained in each part, changing the usual A piece into a geodesic drift along the\n"
    },
    {
      "pdf_page": 341,
      "printed_page": 320,
      "text": "320\n7\nNumerical Methods for Stochastic Molecular Dynamics\nmanifold deﬁned by g.q/ D 0. We will denote schemes using this splitting in a\nsimilar fashion to the unconstrained case, but precede the schemes with “c-” to label\nthe constrained form (for example c-\u0002BAOAB\u0003 rather than the more cumbersome\nnotation \u0002BcAcOcAcBc\u0003). Such a constrained scheme would be:\nc-\u0002BAOAB\u0003\nSolve\n\f pnC1=5 D pn \u0003 h\n2rU.qn/ \u0003 g0.qn/T\fnC1=3\nSuch that g0.qn/M\u00021pnC1=5 D 0\nSolve the geodesic ﬂow Ac for h=2, and map Œqn; pnC1=5\t ! ŒqnC1=2; pnC2=5\t\nSolve\n\f pnC3=5 D e\u0002\nhpnC2=5 C\np\n.1 \u0003 e\u00022\nh/kBTMRn \u0003 g0.qnC1=2/T\fnC2=3\nSuch that g0.qnC1=2/M\u00021pnC3=5 D 0\nSolve the geodesic ﬂow Ac for h=2, and map ŒqnC1=2; pnC3=5\t ! ŒqnC1; pnC4=5\t\nSolve\n\f pnC1 D pnC4=5 \u0003 h\n2rU.qnC1/ \u0003 g0.qnC1/T\fnC1\nSuch that g0.qnC1/M\u00021pnC1 D 0;\nwhere Rn is a vector of i.i.d N.0; 1/ random numbers and the Lagrange multipliers\n\f, ensuring that the hidden constraint is satisﬁed, can be computed through a linear\nsolve. We do not necessarily need to solve the geodesic ﬂow exactly in practice,\nthough for the purposes of analysis we shall assume we do. If we are considering\na second order scheme, then solving the Ac piece to at least second order would be\nsufﬁcient to preserve the overall order of the scheme, although a scheme may have\npotentially better accuracy and stability properties if a higher order solve is used.\nIn practice, we can solve the Ac piece using any constraint algorithm for constant\nenergy dynamics (see Sect. 4.3.6) and subsituting zero force. A more accurate\nsolution is obtained for the geodesic drift by either using a number of small steps\nto integrate over the total time, or composing steps in a certain order to obtain a\nhigher order solution (see Sect. 3.3.3). Relative to the force calculation, solving the\ngeodesic drift step (even to high accuracy) can, in typical molecular systems, be\nconsidered computationally cheap. Given these splitting pieces, one may write down\nconstrained equivalents of any of the schemes described in Sect. 7.3.1.\nWe then ask how to analyze such schemes using the algebraic machinery\ndeveloped throughout this chapter. As we solve each vector ﬁeld on the constraint\nmanifold, it is natural to consider the associated Lie derivatives on these manifolds\nand solve the corresponding Fokker-Planck equation for the discretization to ﬁnd an\ninvariant distribution, just as we did in the unconstrained case. This is a complicated\nprogramme and we do not develop this in detail here.\nTo compare the performance of the various schemes we perform a numerical\nexperiment to quantify the discretization error caused by the schemes. We imple-\nment the c-\u0002BAOAB\u0003 and c-\u0002OBABO\u0003 schemes into the NAMD-lite [170, 302]\npackage and consider 233 TIP3P water molecules in a periodic box with dimensions\n20 \u0004 20 \u0004 20 Angstroms at 300 K. We constrain the angles and bond lengths\nof each molecule so that the only forces felt are due to the van der Waals and\nelectronic interations, parameterized by the CHARMM22 forceﬁeld [246] with an\n8-Angstrom cutoff. The system was simulated for a ﬁxed total time of 3ns, after a\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。",
    "正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.constrainedAField",
  "lean_declarations": [
    "MD.Ch07.constrainedAField",
    "MD.Ch07.constrainedBField",
    "MD.Ch07.geodesicConstraintFlow",
    "MD.Ch07.constrainedKickRelation",
    "MD.Ch07.constrainedExactORelation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 multiplier i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ multiplier : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (multiplier t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
```

## MD-7.12.1-ConstrainedBAOABAlgorithm
```json
{
  "source_id": "MD-7.12.1-ConstrainedBAOABAlgorithm",
  "kind": "definition",
  "label": null,
  "section": "7.12.1",
  "printed_page": "320",
  "pdf_page": "341",
  "statement_latex": "c-$[BAOAB]$\n\\[p_{n+1/5}=p_n-\\tfrac h2\\nabla U(q_n)-g'(q_n)^T\\lambda_{n+1/3},\\quad g'(q_n)M^{-1}p_{n+1/5}=0.\\]\nSolve the geodesic flow $A_c$ for $h/2$, and map $[q_n,p_{n+1/5}]\\to[q_{n+1/2},p_{n+2/5}]$.\n\\[p_{n+3/5}=e^{-\\gamma h}p_{n+2/5}+\\sqrt{(1-e^{-2\\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\\lambda_{n+2/3},\\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.\\]\nSolve the geodesic flow $A_c$ for $h/2$, and map $[q_{n+1/2},p_{n+3/5}]\\to[q_{n+1},p_{n+4/5}]$.\n\\[p_{n+1}=p_{n+4/5}-\\tfrac h2\\nabla U(q_{n+1})-g'(q_{n+1})^T\\lambda_{n+1},\\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 341,
      "printed_page": 320,
      "text": "320\n7\nNumerical Methods for Stochastic Molecular Dynamics\nmanifold deﬁned by g.q/ D 0. We will denote schemes using this splitting in a\nsimilar fashion to the unconstrained case, but precede the schemes with “c-” to label\nthe constrained form (for example c-\u0002BAOAB\u0003 rather than the more cumbersome\nnotation \u0002BcAcOcAcBc\u0003). Such a constrained scheme would be:\nc-\u0002BAOAB\u0003\nSolve\n\f pnC1=5 D pn \u0003 h\n2rU.qn/ \u0003 g0.qn/T\fnC1=3\nSuch that g0.qn/M\u00021pnC1=5 D 0\nSolve the geodesic ﬂow Ac for h=2, and map Œqn; pnC1=5\t ! ŒqnC1=2; pnC2=5\t\nSolve\n\f pnC3=5 D e\u0002\nhpnC2=5 C\np\n.1 \u0003 e\u00022\nh/kBTMRn \u0003 g0.qnC1=2/T\fnC2=3\nSuch that g0.qnC1=2/M\u00021pnC3=5 D 0\nSolve the geodesic ﬂow Ac for h=2, and map ŒqnC1=2; pnC3=5\t ! ŒqnC1; pnC4=5\t\nSolve\n\f pnC1 D pnC4=5 \u0003 h\n2rU.qnC1/ \u0003 g0.qnC1/T\fnC1\nSuch that g0.qnC1/M\u00021pnC1 D 0;\nwhere Rn is a vector of i.i.d N.0; 1/ random numbers and the Lagrange multipliers\n\f, ensuring that the hidden constraint is satisﬁed, can be computed through a linear\nsolve. We do not necessarily need to solve the geodesic ﬂow exactly in practice,\nthough for the purposes of analysis we shall assume we do. If we are considering\na second order scheme, then solving the Ac piece to at least second order would be\nsufﬁcient to preserve the overall order of the scheme, although a scheme may have\npotentially better accuracy and stability properties if a higher order solve is used.\nIn practice, we can solve the Ac piece using any constraint algorithm for constant\nenergy dynamics (see Sect. 4.3.6) and subsituting zero force. A more accurate\nsolution is obtained for the geodesic drift by either using a number of small steps\nto integrate over the total time, or composing steps in a certain order to obtain a\nhigher order solution (see Sect. 3.3.3). Relative to the force calculation, solving the\ngeodesic drift step (even to high accuracy) can, in typical molecular systems, be\nconsidered computationally cheap. Given these splitting pieces, one may write down\nconstrained equivalents of any of the schemes described in Sect. 7.3.1.\nWe then ask how to analyze such schemes using the algebraic machinery\ndeveloped throughout this chapter. As we solve each vector ﬁeld on the constraint\nmanifold, it is natural to consider the associated Lie derivatives on these manifolds\nand solve the corresponding Fokker-Planck equation for the discretization to ﬁnd an\ninvariant distribution, just as we did in the unconstrained case. This is a complicated\nprogramme and we do not develop this in detail here.\nTo compare the performance of the various schemes we perform a numerical\nexperiment to quantify the discretization error caused by the schemes. We imple-\nment the c-\u0002BAOAB\u0003 and c-\u0002OBABO\u0003 schemes into the NAMD-lite [170, 302]\npackage and consider 233 TIP3P water molecules in a periodic box with dimensions\n20 \u0004 20 \u0004 20 Angstroms at 300 K. We constrain the angles and bond lengths\nof each molecule so that the only forces felt are due to the van der Waals and\nelectronic interations, parameterized by the CHARMM22 forceﬁeld [246] with an\n8-Angstrom cutoff. The system was simulated for a ﬁxed total time of 3ns, after a\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.constrainedBAOABRelation",
  "lean_declarations": [
    "MD.Ch07.constrainedBAOABRelation",
    "MD.Ch07.constrainedBAOAB_constraint"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2
```

## MD-7.12.1-ApproximateGeodesicOrder
```json
{
  "source_id": "MD-7.12.1-ApproximateGeodesicOrder",
  "kind": "definition",
  "label": null,
  "section": "7.12.1",
  "printed_page": "320",
  "pdf_page": "341",
  "statement_latex": "We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $A_c$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 341,
      "printed_page": 320,
      "text": "320\n7\nNumerical Methods for Stochastic Molecular Dynamics\nmanifold deﬁned by g.q/ D 0. We will denote schemes using this splitting in a\nsimilar fashion to the unconstrained case, but precede the schemes with “c-” to label\nthe constrained form (for example c-\u0002BAOAB\u0003 rather than the more cumbersome\nnotation \u0002BcAcOcAcBc\u0003). Such a constrained scheme would be:\nc-\u0002BAOAB\u0003\nSolve\n\f pnC1=5 D pn \u0003 h\n2rU.qn/ \u0003 g0.qn/T\fnC1=3\nSuch that g0.qn/M\u00021pnC1=5 D 0\nSolve the geodesic ﬂow Ac for h=2, and map Œqn; pnC1=5\t ! ŒqnC1=2; pnC2=5\t\nSolve\n\f pnC3=5 D e\u0002\nhpnC2=5 C\np\n.1 \u0003 e\u00022\nh/kBTMRn \u0003 g0.qnC1=2/T\fnC2=3\nSuch that g0.qnC1=2/M\u00021pnC3=5 D 0\nSolve the geodesic ﬂow Ac for h=2, and map ŒqnC1=2; pnC3=5\t ! ŒqnC1; pnC4=5\t\nSolve\n\f pnC1 D pnC4=5 \u0003 h\n2rU.qnC1/ \u0003 g0.qnC1/T\fnC1\nSuch that g0.qnC1/M\u00021pnC1 D 0;\nwhere Rn is a vector of i.i.d N.0; 1/ random numbers and the Lagrange multipliers\n\f, ensuring that the hidden constraint is satisﬁed, can be computed through a linear\nsolve. We do not necessarily need to solve the geodesic ﬂow exactly in practice,\nthough for the purposes of analysis we shall assume we do. If we are considering\na second order scheme, then solving the Ac piece to at least second order would be\nsufﬁcient to preserve the overall order of the scheme, although a scheme may have\npotentially better accuracy and stability properties if a higher order solve is used.\nIn practice, we can solve the Ac piece using any constraint algorithm for constant\nenergy dynamics (see Sect. 4.3.6) and subsituting zero force. A more accurate\nsolution is obtained for the geodesic drift by either using a number of small steps\nto integrate over the total time, or composing steps in a certain order to obtain a\nhigher order solution (see Sect. 3.3.3). Relative to the force calculation, solving the\ngeodesic drift step (even to high accuracy) can, in typical molecular systems, be\nconsidered computationally cheap. Given these splitting pieces, one may write down\nconstrained equivalents of any of the schemes described in Sect. 7.3.1.\nWe then ask how to analyze such schemes using the algebraic machinery\ndeveloped throughout this chapter. As we solve each vector ﬁeld on the constraint\nmanifold, it is natural to consider the associated Lie derivatives on these manifolds\nand solve the corresponding Fokker-Planck equation for the discretization to ﬁnd an\ninvariant distribution, just as we did in the unconstrained case. This is a complicated\nprogramme and we do not develop this in detail here.\nTo compare the performance of the various schemes we perform a numerical\nexperiment to quantify the discretization error caused by the schemes. We imple-\nment the c-\u0002BAOAB\u0003 and c-\u0002OBABO\u0003 schemes into the NAMD-lite [170, 302]\npackage and consider 233 TIP3P water molecules in a periodic box with dimensions\n20 \u0004 20 \u0004 20 Angstroms at 300 K. We constrain the angles and bond lengths\nof each molecule so that the only forces felt are due to the van der Waals and\nelectronic interations, parameterized by the CHARMM22 forceﬁeld [246] with an\n8-Angstrom cutoff. The system was simulated for a ﬁxed total time of 3ns, after a\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。"
  ],
  "issues": [],
  "statement_scope": "局部二阶替换的目标资格；从该资格推出随机全局/不变分布阶数尚未陈述完整定理。",
  "lean_decl": "MD.Ch07.localMapErrorBound",
  "lean_declarations": [
    "MD.Ch07.localMapErrorBound",
    "MD.Ch07.geodesicReplacementSecondOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
```

## MD-7.13-FastSlowHarmonicModel
```json
{
  "source_id": "MD-7.13-FastSlowHarmonicModel",
  "kind": "definition",
  "label": "(7.47)–(7.48)",
  "section": "7.13",
  "printed_page": "323",
  "pdf_page": "344",
  "statement_latex": "\\[H(q,p)=p^2/2+U(q),\\qquad U(q)=U_F(q)+U_S(q),\\]\n\\[U_S(q)=q^2/2,\\qquad U_F(q)=\\Omega^2q^2/2,\\tag{7.47}\\]\nwhere $\\Omega\\gg1$.\n\\[\\binom{dq}{dp}=\\underbrace{\\binom{pdt}{-\\Omega^2qdt-\\gamma pdt+\\sqrt{2\\gamma/\\beta}dW}}_{\\rm Fast}+\\underbrace{\\binom0{-qdt}}_{\\rm Slow}.\\tag{7.48}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 344,
      "printed_page": 323,
      "text": "7.13\nMultiple Timestepping\n323\n7.13\nMultiple Timestepping\nRecall the r-RESPA multiple timestepping scheme introduced in Sect. 4.2, designed\nto propagate systems which have a fast highly oscillatory motion, as well as a slower\nlong-ranged force term. Splitting the potential energy function into fast and slow\ncomponents in the deterministic setting provided only a small gain in the stability\nthreshold, as we encountered linear resonance phenomena at step sizes that were\ninteger multiples of half a period. In systems where the timescale gap is very\nlarge, the r-RESPA scheme does not give signiﬁcant improvement, with the stability\nthreshold scaling identically to the Symplectic Euler method.\nOur hope would be that using Langevin dynamics to add stochasticity would\ndisrupt resonance effects and permit larger usable timesteps. While some consider-\nable efﬁciency improvements have been demonstrated using multiple timestepping\nmethods for Langevin dynamics with constraints [118], we shall investigate the\nsimpler fast/slow splitting demonstrated in previous chapters.\nWe consider propagating a system with Hamiltonian\nH.q; p/ D p2=2 C U.q/;\nU.q/ D UF.q/ C US.q/;\nwhere q; p 2 R and US and UF denote the slow and fast components of the\npotential energy respectively. For the purposes of analysis, we shall model these\nwith harmonic potentials, with\nUS.q/ D q2=2;\nUF.q/ D ˝2q2=2;\n(7.47)\nwhere ˝ \n 1. The question we shall be interested in is whether using Langevin\ndynamics with a multiple timestepping algorithm gives us any extra stability\ncompared to the deterministic case. Let us consider splitting the dynamics into\n\u0002dq\ndp\n\u0003\nD\n\u0002\np dt\n\u0003˝2q dt \u0003 \np dt C\np\n2\n=ˇ dW\n\u0003\n„\nƒ‚\n…\nFast\nC\n\u0002\n0\n\u0003q dt\n\u0003\n„ ƒ‚ …\nSlow\n;\n(7.48)\nand proceed as in the case of the r-RESPA scheme. As before, we consider the case\nwhere we are able to solve the fast part exactly (in practice we use several small\ntimesteps as the fast parts are considered computationally “cheap”). Writing\nF D\n\u0002\n0\n1\n\u0003˝2 \u0003\n\u0003\n;\nwe can write down the solution to the fast dynamics as\n\u0002q.t/\np.t/\n\u0003\nD exp.Ft/\n\u0002 q.0/\np.0/\n\u0003\nC BtR;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "单位质量、实际标准Wiener、状态适应、正β及完整积分方程由langevin定义体保留；Ω≫1在定量结论中分别改成明确不等式。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.Mat2",
  "lean_declarations": [
    "MD.Ch07.Mat2",
    "MD.Ch07.fastPotential",
    "MD.Ch07.slowPotential",
    "MD.Ch07.fastMatrix",
    "MD.Ch07.slowMatrix",
    "MD.Ch07.fastLangevin"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev Mat2 := Matrix (Fin 2) (Fin 2) ℝ
def fastPotential (Ω q : ℝ) : ℝ := Ω^2*q^2/2
def slowPotential (q : ℝ) : ℝ := q^2/2
def fastMatrix (Ω γ : ℝ) : Mat2 := !![0,1;-Ω^2,-γ]
def slowMatrix (h : ℝ) : Mat2 := !![1,0;-h,1]
def fastLangevin (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β : ℝ) (x0 : Phase 1) : Prop :=
  0 < frequency ∧ 0 < β ∧ langevin P W X (fun q ↦ fastPotential frequency (q 0)) (fun _ ↦ 1) γ β⁻¹ x0
```
