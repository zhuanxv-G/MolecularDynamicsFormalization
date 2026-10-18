# BATCH05 第7章原文与陈述审校

## MD-7.3.1-WordConvention
```json
{
  "source_id": "MD-7.3.1-WordConvention",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "270",
  "pdf_page": "291",
  "statement_latex": "As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABAOBAO]$ has an update\n\\[\\mathcal U_h^{[OABAOBAO]}=\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/4}^O,\\]\nwhere the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 291,
      "printed_page": 270,
      "text": "270\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhich we label A, B and O, where each of the three parts may be solved “exactly”,\nwith individual updates given as\nU A\nh .q; p/ D .q C hM\u00021p; p/;\nU B\nh .q; p/ D .q; p \u0003 hrU.q//;\nU O\nh .q; p/ D .q; e\u0002\nhp C\np\nkBT .1 \u0003 e\u00022\nh/M1=2R/;\nwhere R is a vector of i.i.d. normal random numbers. For the deterministic pieces\nA and B, the updates correspond to their ﬂow maps, while the update for the O\npiece corresponds to the solution derived in (7.3). The relevant forward propagators\nfor each piece of the Hamiltonian part are computed through the adjoint of the Lie\nderivative as\nL\u0004\nA D \u0003M\u00021p \u0002 rq;\nL\u0004\nB D rU.q/ \u0002 rp:\nUsing this splitting strategy, we can deﬁne a family of schemes by the desired\nsequence of updates, codiﬁed as a string using the alphabet “ABO”. For example,\nthe method denoted \u0002ABO\u0003 (acting from left to right) has a resulting update\nU \u0002ABO\u0003\nh\nD U O\nh ı U B\nh ı U A\nh :\nThis corresponds to using the adjoint symplectic Euler scheme to solve the\nNewtonian part of the Langevin dynamics SDE, followed by an exact OU solve. An\nalternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme\ndenoted \u0002BABO\u0003 with associated map\nU \u0002BABO\u0003\nh\nD U O\nh ı U B\nh=2 ı U A\nh ı U B\nh=2:\nNote that the presence of two B characters in the string results in halving the\ncorresponding piece’s time step length. As we need the method to be consistent,\nwe require that the each of the A, B and O pieces are propagated in time for a\ntotal time of h. As a result we use the convention that if a letter appears k times in a\nmethod’s string, then each individual update piece uses a timestep h=k. For example,\nthe scheme denoted \u0002OABOAOBAO\u0003 has an update\nU \u0002OABOAOBAO\u0003\nh\nD U O\nh=4 ı U A\nh=3 ı U B\nh=2 ı U O\nh=4 ı U A\nh=3 ı U O\nh=4 ı U B\nh=2 ı U A\nh=3 ı U O\nh=4;\nwhere the random numbers used in each O update are independent. This scheme will\nrequire a total of 4Nc normal random numbers and two force evaluations per step\n(the force must be recomputed at the ﬁrst B step following an A step; the number of\nforce evaluations required is not directly related to the length of the string).\nA class of methods like those considered above were discussed in [46] and given\nthe general title of “Geometric” Langevin Algorithm (GLA). The idea of a GLA\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文图式照录3个h/4的O；修正版改3个h/3和3N_c随机数。力求值次数为实现说明，未形式化成本模型。",
    "每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。"
  ],
  "issues": [
    "已目视核对PDF291／印刷270：字串OABAOBAO有3个O，所印复合也仅3个O，却各用h/4并称4N_c个正态数；不符前句每字母总时长h的约定。"
  ],
  "statement_scope": "完整复合图式、O计数及时间分配修正；力求值说明列于上下文，不声称已证明计算成本。",
  "lean_decl": "MD.Ch07.oabaobaoPrinted",
  "lean_declarations": [
    "MD.Ch07.oabaobaoPrinted",
    "MD.Ch07.oabaobaoPrinted_corrected",
    "MD.Ch07.oabaobaoCount"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/3) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/3) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/3) (R 0)

theorem oabaobaoCount : (["O","A","B","A","O","B","A","O"] : List String).count "O" = 3 := by decide
```

## MD-7.3.1-SixSchemes
```json
{
  "source_id": "MD-7.3.1-SixSchemes",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "271",
  "pdf_page": "292",
  "statement_latex": "For reference and to remove any ambiguity, we write out some of these algorithms below as single timestep maps.\n\\[\\begin{array}{ll}\n[ABAO]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\\quad p_{n+1/2}=p_n-h\\nabla U(q_{n+1/2}),\\\\\n&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1/2},\\quad p_{n+1}=e^{-h\\gamma}p_{n+1/2}+\\zeta_2M^{1/2}R_n;\\\\\n[BABO]:&p_{n+1/2}=p_n-(h/2)\\nabla U(q_n),\\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\\\\n&\\hat p_{n+1/2}=p_{n+1/2}-(h/2)\\nabla U(q_{n+1}),\\quad p_{n+1}=e^{-h\\gamma}\\hat p_{n+1/2}+\\zeta_2M^{1/2}R_n;\\\\\n[ABOBA]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\\quad p_{n+1/2}=p_n-(h/2)\\nabla U(q_{n+1/2}),\\\\\n&\\hat p_{n+1/2}=e^{-h\\gamma}p_{n+1/2}+\\zeta_2M^{1/2}R_n,\\\\\n&p_{n+1}=\\hat p_{n+1/2}-(h/2)\\nabla U(q_{n+1/2}),\\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1};\\\\\n[BAOAB]:&p_{n+1/2}=p_n-(h/2)\\nabla U(q_n),\\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\\\\n&\\hat p_{n+1/2}=e^{-h\\gamma}p_{n+1/2}+\\zeta_2M^{1/2}R_n,\\\\\n&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\\hat p_{n+1/2},\\quad p_{n+1}=\\hat p_{n+1/2}-(h/2)\\nabla U(q_{n+1});\\\\\n[OABAO]:&p_{n+1/2}=e^{-h\\gamma/2}p_n+\\zeta_1M^{1/2}R_n,\\\\\n&q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\quad\\hat p_{n+1/2}=p_{n+1/2}-h\\nabla U(q_{n+1/2}),\\\\\n&q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\\hat p_{n+1/2},\\quad p_{n+1}=e^{-h\\gamma/2}\\hat p_{n+1/2}+\\zeta_1M^{1/2}R_{n+1/2};\\\\\n[OBABO]:&p_{n+1/2}=e^{-h\\gamma/2}p_n+\\zeta_1M^{1/2}R_n,\\quad\\hat p_{n+1/2}=p_{n+1/2}-(h/2)\\nabla U(q_n),\\\\\n&q_{n+1}=q_n+hM^{-1}\\hat p_{n+1/2},\\quad\\hat p_{n+1}=\\hat p_{n+1/2}-(h/2)\\nabla U(q_{n+1}),\\\\\n&p_{n+1}=e^{-h\\gamma/2}\\hat p_{n+1}+\\zeta_1M^{1/2}R_{n+1/2},\n\\end{array}\\]\nwhere $\\zeta_j=[k_BT(1-e^{-j\\gamma h})]^{1/2}$, and $R_n,R_{n+1/2}$ are $N_d$ vectors of standard independent $\\mathcal N(0,1)$ random variables, resampled at each step.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 292,
      "printed_page": 271,
      "text": "7.3\nSampling Iterations\n271\nmethod is to treat the Newtonian part of Langevin dynamics by a symplectic method,\nand follow this by an Ornstein-Uhlenbeck exact solve; this is just what is done in the\nschemes denoted \u0002BABO\u0003 and \u0002ABAO\u0003. Thus we could give these two methods the\nalternate (and more descriptive) names Geometric Langevin (Velocity-Verlet) and\nGeometric Langevin (Position-Verlet) respectively.\nBuilding on these schemes, the OU solves can instead be placed in the center of\nthe step, or we may choose to have more than one OU solve distributed through the\niteration. As it happens, some of these methods are of particular interest. We refer\nto the method obtained by inserting the OU solve in the middle of the Verlet method\neither by the strings \u0002ABOBA\u0003 (Position-Verlet version) and \u0002BAOAB\u0003 (Velocity-\nVerlet version) or by the more pronounceable names Symmetric Langevin Position-\nVerlet or Symmetric Langevin Velocity-Verlet, respectively.\nFor reference and to remove any ambiguity, we write out some of these\nalgorithms below as single timestep maps (sample implementations in MATLAB\nare available at http://www.MolecularDynamics.info).\n\u0002ABAO\u0003\n\u0002BABO\u0003\nqnC1=2 D qn C .h=2/M\u00021pn,\npnC1=2 D pn \u0003 .h=2/rU.qn/,\npnC1=2 D pn \u0003 hrU.qnC1=2/,\nqnC1 D qn C hM\u00021pnC1=2,\nqnC1 D qnC1=2 C .h=2/M\u00021pnC1=2,\nOpnC1=2 D pnC1=2 \u0003 .h=2/rU.qnC1/,\npnC1 D e\u0002h\npnC1=2 C \u00182M1=2Rn,\npnC1 D e\u0002h\n OpnC1=2 C \u00182M1=2Rn,\n\u0002ABOBA\u0003\n\u0002BAOAB\u0003\nqnC1=2 D qn C .h=2/M\u00021pn,\npnC1=2 D pn \u0003 .h=2/rU.qn/,\npnC1=2 D pn \u0003 .h=2/rU.qnC1=2/,\nqnC1=2 D qn C .h=2/M\u00021pnC1=2,\nOpnC1=2 D e\u0002h\npnC1=2 C \u00182M1=2Rn,\nOpnC1=2 D e\u0002h\npnC1=2 C \u00182M1=2Rn,\npnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1=2/,\nqnC1 D qnC1=2 C .h=2/M\u00021OpnC1=2,\nqnC1 D qnC1=2 C .h=2/M\u00021pnC1,\npnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/,\n\u0002OABAO\u0003\n\u0002OBABO\u0003\npnC1=2 D e\u0002h\n=2pn C \u00181M1=2Rn,\npnC1=2 D e\u0002h\n=2pn C \u00181M1=2Rn,\nqnC1=2 D qn C .h=2/M\u00021pnC1=2,\nOpnC1=2 D pnC1=2 \u0003 .h=2/rU.qn/,\nOpnC1=2 D pnC1=2 \u0003 hrU.qnC1=2/,\nqnC1 D qn C hM\u00021OpnC1=2,\nqnC1 D qnC1=2 C .h=2/M\u00021OpnC1=2,\nOpnC1 D OpnC1=2 \u0003 .h=2/rU.qnC1/,\npnC1 D e\u0002h\n=2OpnC1=2 C \u00181M1=2RnC1=2,\npnC1De\u0002h\n=2OpnC1 C \u00181M1=2RnC1=2,\nwhere \u0018j\nD\n\nkBT\n\u0004\n1 \u0003 e\u0002j\nh\u0005\u000b1=2, and Rn; RnC1=2 are Nd vectors of standard\nindependent N.0; 1/ random variables, resampled at each step. Note that, as in the\nVelocity-Verlet method, the two apparent evaluations of the force F D \u0003rU in the\nmethods labelled \u0002BABO\u0003, \u0002BAOAB\u0003 and \u0002OBABO\u0003 actually require only a single\nevaluation at each timestep, since the second evaluation at one step may be reused at\nthe ﬁrst stage of the following step. Thus all of the above methods require only one\nforce evaluation per timestep, and hence we can think of them having exactly the\nsame computational cost as the evaluation of the force is the principle computational\nexpense.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "BABO已定义于ABOBABO；其余5个完整复合依次对应所列中间步。",
    "R与S为同一步两次O的独立标准正态向量；跨步也独立，用vectorNormalSequence提供资格。",
    "原文最后“single evaluation”使用跨步缓存；实现成本不列为待证数学命题。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.abao",
  "lean_declarations": [
    "MD.Ch07.abao",
    "MD.Ch07.aboba",
    "MD.Ch07.baoab",
    "MD.Ch07.oabao",
    "MD.Ch07.obabo"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def abao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2)
def aboba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U (h/2) ∘ ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m (h/2)
def baoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def oabao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ (h/2) R
def obabo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ ouStep m γ θ (h/2) R
```

## MD-7.3.1-ConjugateIteration
```json
{
  "source_id": "MD-7.3.1-ConjugateIteration",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3.1",
  "printed_page": "272",
  "pdf_page": "293",
  "statement_latex": "When iterated $n+1$ times, we can see the scheme $[OABA]$ produces a mapping of the form\n\\[(\\mathcal U_h^{[OABA]})^{n+1}=\\mathcal U_{h/2}^A\\circ\\mathcal U_{h/2}^B\\circ(\\mathcal U_h^{[BAOAB]})^n\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/2}^A\\circ\\mathcal U_h^O;\\]\ntherefore through a coordinate transformation the $[OABA]$ method can be morphed into the $[BAOAB]$ scheme.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 293,
      "printed_page": 272,
      "text": "272\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWhen iterated n C 1 times, we can see the scheme \u0002OABA\u0003 produces a mapping\nof the form\n\u0006\nU \u0002OABA\u0003\nh\n\u0007nC1\nD U A\nh=2 ı U B\nh=2 ı\n\u0006\nU \u0002BAOAB\u0003\nh\n\u0007n\nı U B\nh=2 ı U A\nh=2 ı U O\nh ;\ntherefore through a coordinate transformation the \u0002OABA\u0003 method can be morphed\ninto the \u0002BAOAB\u0003 scheme. To put this another way, if we compute an iteration using\n\u0002OABA\u0003 and simply evaluate it at different points within the step, we can recover\nthe same results as the \u0002BAOAB\u0003 method would provide. Another term to describe\nthis relationship is to say that one method is conjugate to the other.\n7.3.2\nOther Langevin Integrators\nWe may use our alphabet of A, B and O splitting pieces to create a wide variety\nof methods other than those given in the previous section (some requiring multiple\nforce evaluations). However, it is not obvious that there is any gain in increasing the\ncomplexity of the splitting scheme (in terms of the length of its codifying string).\nSome popular methods can be rewritten in terms of this splitting, for example the\nscheme considered in [62] is equivalent to \u0002OBABO\u0003. Examples of methods based\non this type of splitting were also proposed by De Fabritiis et al [96] and Thalmann\nand Farago [363], in the context of dissipative particle dynamics (see Chapter 8).\nOther Langevin dynamics splitting schemes in common use utilize a different\nadditive decomposition of the SDE vector ﬁeld. For example, the Stochastic Position\nVerlet (SPV) method of [265] relies on the splitting strategy\nd\n\u0002q\np\n\u0003\nD\n\u0002 M\u00021p\n0\n\u0003\ndt C\n\u0002\n0\n\u0003rU.q/dt \u0003 \npdt C \u0007M1=2dW\n\u0003\n:\nTo solve the splitting piece including the stochastic dW term, we note that q does not\nchange through its integration, and hence we may treat F D \u0003rU as constant during\nthis part of the step. The exact solution is hence given through the usual Ornstein-\nUhlenbeck formula, where the scheme itself derives from a symmetric integration\nof the two parts:\nStochastic Position Verlet (SPV)\nqnC1=2 D qn C .h=2/M\u00021pn\npnC1 D e\u0002h\npn \u0003 \u000frU.qn/ C \u0018M1=2Rn\nqnC1 D qnC1=2 C .h=2/M\u00021pnC1\nwhere \u000f D .1\u0003e\u0002h\n/=\n, \u0018 D\n\nkBT\n\u0004\n1 \u0003 e\u00022\nh\u0005\u000b1=2. It is important to note that in the\nlimit of inﬁnite friction, we have \u000f ! 0 independent of the timestep h. This suggests\nthat this splitting strategy is unsuitable for large choices of the parameter \n as the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "compositionIterate是任意确定性映射的真实复合恒等式；实际随机迭代应在扩展噪声序列空间中使用更新映射，不能把固定R重复使用当独立重抽样。",
    "对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。"
  ],
  "issues": [],
  "statement_scope": "有限复合恒等式及OABA单步映射；独立随机序列上的共轭解释未形式化。",
  "lean_decl": "MD.Ch07.compositionIterate",
  "lean_declarations": [
    "MD.Ch07.compositionIterate",
    "MD.Ch07.oaba"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem compositionIterate {D : Type*} (S T : D → D) (k : ℕ) :
    (S ∘ T)^[k+1] = S ∘ (T ∘ S)^[k] ∘ T := by
  funext x
  induction k with
  | zero => rfl
  | succ k ih =>
    simp only [Function.iterate_succ_apply', Function.comp_apply] at *
    rw [ih]

def oaba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R
```

## MD-7.3.2-SPVPrinted
```json
{
  "source_id": "MD-7.3.2-SPVPrinted",
  "kind": "definition",
  "label": null,
  "section": "7.3.2",
  "printed_page": "272",
  "pdf_page": "293",
  "statement_latex": "Stochastic Position Verlet (SPV)\n\\[q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\\qquad\np_{n+1}=e^{-h\\gamma}p_n-\\eta\\nabla U(q_n)+\\zeta M^{1/2}R_n,\\qquad\nq_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}\\]\nwhere $\\eta=(1-e^{-h\\gamma})/\\gamma$, $\\zeta=[k_BT(1-e^{-2\\gamma h})]^{1/2}$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 293,
      "printed_page": 272,
      "text": "272\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWhen iterated n C 1 times, we can see the scheme \u0002OABA\u0003 produces a mapping\nof the form\n\u0006\nU \u0002OABA\u0003\nh\n\u0007nC1\nD U A\nh=2 ı U B\nh=2 ı\n\u0006\nU \u0002BAOAB\u0003\nh\n\u0007n\nı U B\nh=2 ı U A\nh=2 ı U O\nh ;\ntherefore through a coordinate transformation the \u0002OABA\u0003 method can be morphed\ninto the \u0002BAOAB\u0003 scheme. To put this another way, if we compute an iteration using\n\u0002OABA\u0003 and simply evaluate it at different points within the step, we can recover\nthe same results as the \u0002BAOAB\u0003 method would provide. Another term to describe\nthis relationship is to say that one method is conjugate to the other.\n7.3.2\nOther Langevin Integrators\nWe may use our alphabet of A, B and O splitting pieces to create a wide variety\nof methods other than those given in the previous section (some requiring multiple\nforce evaluations). However, it is not obvious that there is any gain in increasing the\ncomplexity of the splitting scheme (in terms of the length of its codifying string).\nSome popular methods can be rewritten in terms of this splitting, for example the\nscheme considered in [62] is equivalent to \u0002OBABO\u0003. Examples of methods based\non this type of splitting were also proposed by De Fabritiis et al [96] and Thalmann\nand Farago [363], in the context of dissipative particle dynamics (see Chapter 8).\nOther Langevin dynamics splitting schemes in common use utilize a different\nadditive decomposition of the SDE vector ﬁeld. For example, the Stochastic Position\nVerlet (SPV) method of [265] relies on the splitting strategy\nd\n\u0002q\np\n\u0003\nD\n\u0002 M\u00021p\n0\n\u0003\ndt C\n\u0002\n0\n\u0003rU.q/dt \u0003 \npdt C \u0007M1=2dW\n\u0003\n:\nTo solve the splitting piece including the stochastic dW term, we note that q does not\nchange through its integration, and hence we may treat F D \u0003rU as constant during\nthis part of the step. The exact solution is hence given through the usual Ornstein-\nUhlenbeck formula, where the scheme itself derives from a symmetric integration\nof the two parts:\nStochastic Position Verlet (SPV)\nqnC1=2 D qn C .h=2/M\u00021pn\npnC1 D e\u0002h\npn \u0003 \u000frU.qn/ C \u0018M1=2Rn\nqnC1 D qnC1=2 C .h=2/M\u00021pnC1\nwhere \u000f D .1\u0003e\u0002h\n/=\n, \u0018 D\n\nkBT\n\u0004\n1 \u0003 e\u00022\nh\u0005\u000b1=2. It is important to note that in the\nlimit of inﬁnite friction, we have \u000f ! 0 independent of the timestep h. This suggests\nthat this splitting strategy is unsuitable for large choices of the parameter \n as the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。"
  ],
  "issues": [
    "已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.spvPrinted",
  "lean_declarations": [
    "MD.Ch07.spvPrinted",
    "MD.Ch07.spvPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def spvPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U x.1 i
  driftStep m (h/2) (qhalf,pnew)

def spvPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U qhalf i
  driftStep m (h/2) (qhalf,pnew)
```

## MD-7.3.2-SPVLargeFriction
```json
{
  "source_id": "MD-7.3.2-SPVLargeFriction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3.2",
  "printed_page": "272–273",
  "pdf_page": "293–294",
  "statement_latex": "It is important to note that in the limit of infinite friction, we have $\\eta\\to0$ independent of the timestep $h$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $\\gamma$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 293,
      "printed_page": 272,
      "text": "272\n7\nNumerical Methods for Stochastic Molecular Dynamics\nWhen iterated n C 1 times, we can see the scheme \u0002OABA\u0003 produces a mapping\nof the form\n\u0006\nU \u0002OABA\u0003\nh\n\u0007nC1\nD U A\nh=2 ı U B\nh=2 ı\n\u0006\nU \u0002BAOAB\u0003\nh\n\u0007n\nı U B\nh=2 ı U A\nh=2 ı U O\nh ;\ntherefore through a coordinate transformation the \u0002OABA\u0003 method can be morphed\ninto the \u0002BAOAB\u0003 scheme. To put this another way, if we compute an iteration using\n\u0002OABA\u0003 and simply evaluate it at different points within the step, we can recover\nthe same results as the \u0002BAOAB\u0003 method would provide. Another term to describe\nthis relationship is to say that one method is conjugate to the other.\n7.3.2\nOther Langevin Integrators\nWe may use our alphabet of A, B and O splitting pieces to create a wide variety\nof methods other than those given in the previous section (some requiring multiple\nforce evaluations). However, it is not obvious that there is any gain in increasing the\ncomplexity of the splitting scheme (in terms of the length of its codifying string).\nSome popular methods can be rewritten in terms of this splitting, for example the\nscheme considered in [62] is equivalent to \u0002OBABO\u0003. Examples of methods based\non this type of splitting were also proposed by De Fabritiis et al [96] and Thalmann\nand Farago [363], in the context of dissipative particle dynamics (see Chapter 8).\nOther Langevin dynamics splitting schemes in common use utilize a different\nadditive decomposition of the SDE vector ﬁeld. For example, the Stochastic Position\nVerlet (SPV) method of [265] relies on the splitting strategy\nd\n\u0002q\np\n\u0003\nD\n\u0002 M\u00021p\n0\n\u0003\ndt C\n\u0002\n0\n\u0003rU.q/dt \u0003 \npdt C \u0007M1=2dW\n\u0003\n:\nTo solve the splitting piece including the stochastic dW term, we note that q does not\nchange through its integration, and hence we may treat F D \u0003rU as constant during\nthis part of the step. The exact solution is hence given through the usual Ornstein-\nUhlenbeck formula, where the scheme itself derives from a symmetric integration\nof the two parts:\nStochastic Position Verlet (SPV)\nqnC1=2 D qn C .h=2/M\u00021pn\npnC1 D e\u0002h\npn \u0003 \u000frU.qn/ C \u0018M1=2Rn\nqnC1 D qnC1=2 C .h=2/M\u00021pnC1\nwhere \u000f D .1\u0003e\u0002h\n/=\n, \u0018 D\n\nkBT\n\u0004\n1 \u0003 e\u00022\nh\u0005\u000b1=2. It is important to note that in the\nlimit of inﬁnite friction, we have \u000f ! 0 independent of the timestep h. This suggests\nthat this splitting strategy is unsuitable for large choices of the parameter \n as the\n"
    },
    {
      "pdf_page": 294,
      "printed_page": 273,
      "text": "7.4\nError Results for Harmonic Problems\n273\nsampling will become inconsistent: the force will be dominated by the stochastic\nterm, leaving the dynamics to evolve as a random walk.\nSimilar behavior is exhibited using the splitting strategy in (7.5), when interpos-\ning the kick term B between two O steps, such as in the schemes \u0002AOBOA\u0003 or\n\u0002BOAOB\u0003. By avoiding “OBO” updates, we can derive schemes that are consistent\neven at inﬁnite friction (the \u0002BAOAB\u0003 and \u0002ABOBA\u0003 schemes are examples of such\nmethods).\nThe Brünger-Brooks-Karplus (BBK) Langevin integrator [55] is one of the most\npopular and widely-implemented schemes.\nBrünger-Brooks-Karplus (BBK)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2R0\nn\t=.1 C h\n=2/\nOften R0 is chosen such that R0\nn D RnC1, so the random vector would be reused at\nthe start of the following timestep, however there are many variants of this scheme\nthat incorporate the redraw of random numbers differently. In other variants of BBK\nwe take R0\nn D Rn, reusing the random number within the step. We may also consider\nindependent R0\nn and Rn, however when using independent noise processes we must\nmodify the algorithm as it will not sample canonically (see Exercise 1).\n7.4\nError Results for Harmonic Problems\nFor general systems it can be very challenging to give a complete description of\nthe weak error in averages computed from trajectories evolved through a Langevin\ndynamics discretization scheme. However, using a linear model problem signiﬁ-\ncantly reduces the complexity, while using small dimensional test problems allows\nus to effectively annihilate sampling error in demonstrative numerical experiments.\nAs such, we return now to the harmonic oscillator, which as well as being the\nsimplest molecular model is also one of the most relevant for molecular dynamics\napplications, as many issues of stability and timestep in molecular dynamics\nsimulations arise due to harmonic potentials used to model covalent bonds (such\nas in crystalline solids and biomolecules). The canonical distributions of position\nand momentum are also of a simple form (Gaussians), making such oscillators\nparticularly amenable to analysis.\nRecall that the one-dimensional harmonic oscillator with spring constant ˝2 has\npotential energy function U.q/ D ˝2q2=2, with Hamiltonian\nH.q; p/ D p2\n2m C ˝2q2\n2\n;\n(7.6)\nwhere .q; p/ 2 R2 represent a particle’s position and momentum, and m > 0 is the\nparticle’s mass. In this setting, the canonical distribution \u0005ˇ is the product of two\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只表达明确的η极限；采样不一致的定性判断缺统一模型、时标与测试函数量化，不作为已证结论。"
  ],
  "issues": [],
  "statement_scope": "固定正h的η→0；随后的数值方法失效说明登记为适用范围讨论。",
  "lean_decl": "MD.Ch07.spvEtaLimit",
  "lean_declarations": [
    "MD.Ch07.spvEtaLimit"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem spvEtaLimit (h : ℝ) (hh : 0 < h) :
    Tendsto (fun γ : ℝ ↦ (1-Real.exp (-h*γ))/γ) atTop (𝓝 0) := by
  sorry
```

## MD-7.3.2-BBK
```json
{
  "source_id": "MD-7.3.2-BBK",
  "kind": "definition",
  "label": null,
  "section": "7.3.2",
  "printed_page": "273",
  "pdf_page": "294",
  "statement_latex": "Brünger-Brooks-Karplus (BBK)\n\\[p_{n+1/2}=(1-h\\gamma/2)p_n-(h/2)\\nabla U(q_n)+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R_n,\\]\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\qquad\np_{n+1}=[p_{n+1/2}-(h/2)\\nabla U(q_{n+1})+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R'_n]/(1+h\\gamma/2).\\]\nOften $R'$ is chosen such that $R'_n=R_{n+1}$, so the random vector would be reused at the start of the following timestep, however there are many variants of this scheme that incorporate the redraw of random numbers differently. In other variants of BBK we take $R'_n=R_n$, reusing the random number within the step.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 294,
      "printed_page": 273,
      "text": "7.4\nError Results for Harmonic Problems\n273\nsampling will become inconsistent: the force will be dominated by the stochastic\nterm, leaving the dynamics to evolve as a random walk.\nSimilar behavior is exhibited using the splitting strategy in (7.5), when interpos-\ning the kick term B between two O steps, such as in the schemes \u0002AOBOA\u0003 or\n\u0002BOAOB\u0003. By avoiding “OBO” updates, we can derive schemes that are consistent\neven at inﬁnite friction (the \u0002BAOAB\u0003 and \u0002ABOBA\u0003 schemes are examples of such\nmethods).\nThe Brünger-Brooks-Karplus (BBK) Langevin integrator [55] is one of the most\npopular and widely-implemented schemes.\nBrünger-Brooks-Karplus (BBK)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2R0\nn\t=.1 C h\n=2/\nOften R0 is chosen such that R0\nn D RnC1, so the random vector would be reused at\nthe start of the following timestep, however there are many variants of this scheme\nthat incorporate the redraw of random numbers differently. In other variants of BBK\nwe take R0\nn D Rn, reusing the random number within the step. We may also consider\nindependent R0\nn and Rn, however when using independent noise processes we must\nmodify the algorithm as it will not sample canonically (see Exercise 1).\n7.4\nError Results for Harmonic Problems\nFor general systems it can be very challenging to give a complete description of\nthe weak error in averages computed from trajectories evolved through a Langevin\ndynamics discretization scheme. However, using a linear model problem signiﬁ-\ncantly reduces the complexity, while using small dimensional test problems allows\nus to effectively annihilate sampling error in demonstrative numerical experiments.\nAs such, we return now to the harmonic oscillator, which as well as being the\nsimplest molecular model is also one of the most relevant for molecular dynamics\napplications, as many issues of stability and timestep in molecular dynamics\nsimulations arise due to harmonic potentials used to model covalent bonds (such\nas in crystalline solids and biomolecules). The canonical distributions of position\nand momentum are also of a simple form (Gaussians), making such oscillators\nparticularly amenable to analysis.\nRecall that the one-dimensional harmonic oscillator with spring constant ˝2 has\npotential energy function U.q/ D ˝2q2=2, with Hamiltonian\nH.q; p/ D p2\n2m C ˝2q2\n2\n;\n(7.6)\nwhere .q; p/ 2 R2 represent a particle’s position and momentum, and m > 0 is the\nparticle’s mass. In this setting, the canonical distribution \u0005ˇ is the product of two\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "h>0、γ≥0、θ>0、m_i>0时分母非零及噪声方差有效；不同R′耦合方案分别处理，不把独立与重用噪声混为一谈。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbk",
  "lean_declarations": [
    "MD.Ch07.bbk",
    "MD.Ch07.bbkSameNoise"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbk (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) (x : Phase n) : Phase n :=
  let ph := fun i ↦ (1-h*γ/2)*x.2 i - (h/2)*gradient U x.1 i +
    (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*R i
  let q := (driftStep m h (x.1,ph)).1
  (q, fun i ↦ (ph i-(h/2)*gradient U q i + (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*S i)/(1+h*γ/2))

def bbkSameNoise (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) := bbk m U γ θ h R R
```
