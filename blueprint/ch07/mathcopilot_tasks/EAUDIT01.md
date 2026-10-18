# EAUDIT01 第7章修改后陈述复审

## MD-7.3.1-WordConvention
```json
{
  "source_id": "MD-7.3.1-WordConvention",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "270",
  "pdf_page": "291",
  "statement_latex": "As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABOAOBAO]$ has an update\n\\[\\mathcal U_h^{[OABOAOBAO]}=\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/4}^O\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_{h/3}^A\\circ\\mathcal U_{h/4}^O,\\]\nwhere the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.",
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
    "每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。",
    "29号覆盖限定：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。",
    "PDF291已目视核对：原书九字母OABOAOBAO、四次O(h/4)、4N_c均正确；撤销转录造成的假疑误。"
  ],
  "issues": [],
  "statement_scope": "九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。",
  "lean_decl": "MD.Ch07.oabaobaoPrinted",
  "lean_declarations": [
    "MD.Ch07.oabaobaoPrinted",
    "MD.Ch07.oabaobaoPrinted_corrected",
    "MD.Ch07.oabaobaoCount"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "按原页恢复九字母OABOAOBAO，Fin 4独立噪声，四个O均用h/4；删除把原书判为计数错误的标注，撤销无依据的h/3修正。保持原页4N_c。",
      "actual_scope": "九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": []
}
```
```lean
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 3) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘
  ouStep m γ θ (h/4) (R 1) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

/-- 恢复原页的兼容名称；原书此处没有计数勘误。 -/
def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n := oabaobaoPrinted m U γ θ h R

theorem oabaobaoCount : (["O","A","B","O","A","O","B","A","O"] : List String).count "O" = 4 := by decide
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
    "对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。",
    "29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。"
  ],
  "issues": [],
  "statement_scope": "一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。",
  "lean_decl": "MD.Ch07.compositionIterate",
  "lean_declarations": [
    "MD.Ch07.compositionIterate",
    "MD.Ch07.oaba",
    "MD.Ch07.conjugateNoiseS",
    "MD.Ch07.conjugateNoiseT",
    "MD.Ch07.oaba_baoab_noiseShift"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "增加明确的 OABA/BAOAB 特化及扩展噪声空间上的移位关系；保持目前明确承认的覆盖缺口。",
      "actual_scope": "一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。"
  ]
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

def conjugateNoiseS (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (z : Phase n × ℕ) : Phase n × ℕ :=
  ((kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h (R z.2)) z.1,z.2+1)

def conjugateNoiseT (m : V n) (U : V n → ℝ) (h : ℝ)
    (z : Phase n × ℕ) : Phase n × ℕ :=
  ((driftStep m (h/2) ∘ kickStep U (h/2)) z.1,z.2)

theorem oaba_baoab_noiseShift (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (k : ℕ) :
    (fun z : Phase n × ℕ ↦ (oaba m U γ θ h (R z.2) z.1,z.2+1))^[k+1] =
      conjugateNoiseT m U h ∘
      (fun z : Phase n × ℕ ↦ (baoab m U γ θ h (R z.2) z.1,z.2+1))^[k] ∘
      conjugateNoiseS m U γ θ h R := by
  sorry
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
    "γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。",
    "29号覆盖限定：Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。"
  ],
  "issues": [
    "已目视核对原页PDF293／印刷272：SPV展示式动量用∇U(q_n)，而前文说对两部分作对称积分，漂移半步后冻结位置应为q_{n+1/2}；两者分别保留，待导师判断。"
  ],
  "statement_scope": "Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。",
  "lean_decl": "MD.Ch07.spvPrinted",
  "lean_declarations": [
    "MD.Ch07.spvPrinted",
    "MD.Ch07.spvPrinted_corrected",
    "MD.Ch07.spvQualification"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "NEEDS_HUMAN",
      "suggested_fix": "保留原文 q_n；将 qhalf 版本明确列为勘误候选，限制 γ>0、正质量及有效噪声方差；如要覆盖 γ=0，另定义 η=h。",
      "actual_scope": "Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：Printed保留原页q_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。"
  ]
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

/-- 两个总化映射的物理适用域；γ=0另需定义η=h，此处不含该延拓。 -/
def spvQualification (m : V n) (γ θ h : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ 0 ≤ h
```
