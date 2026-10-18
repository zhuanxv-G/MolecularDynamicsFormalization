# BATCH01 第7章原文与陈述审校

## MD-7.1-Bias
```json
{
  "source_id": "MD-7.1-Bias",
  "kind": "definition",
  "label": null,
  "section": "7.1",
  "printed_page": "263",
  "pdf_page": "284",
  "statement_latex": "All standard methods based on discretizing SDEs introduce some stepsize-dependent error in computed averages, which we shall refer to as bias (related to the truncation error of the discretization scheme).",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 284,
      "printed_page": 263,
      "text": "7.1\nBias\n263\nlong term (invariant measure) conservation properties; in this way they can provide\na rational and ﬂexible framework for designing stable algorithms.\nOnce a stochastic molecular dynamics-based framework is developed it is\npossible to modify it or use it as a building block in order to enhance sampling\nefﬁciency. One can for example incorporate these methods into kinetic Monte-Carlo,\nother metropolized schemes, or various advanced “path sampling” techniques. Thus\nthe design of good molecular SDE methods is the cornerstone of much of modern\nmolecular modelling.\n7.1\nBias\nIn this chapter, the focus is on sampling strategies based on approximating Langevin\ndynamics (6.32)–(6.33). As will be seen, these methods offer a great deal of\nﬂexibility and, most importantly, reliability and robustness in the approximation of\nthe canonical measure. All standard methods based on discretizing SDEs introduce\nsome stepsize-dependent error in computed averages, which we shall refer to as\nbias (related to the truncation error of the discretization scheme). This bias can be\ncorrected for using certain ‘rebiasing’ algorithms, for example using a Metropolis\n(accept-reject) condition [44, 47], however there may be signiﬁcant computational\noverhead in employing these schemes leading to inefﬁciency compared to standard\nMD, in spite of the introduced error.\nAn illustration of the sampling bias (i.e., due to discretization error) is shown in\nFig. 7.1. As the stepsize is increased, the error in sampling is increased as well,\nlimiting the effectiveness of numerical methods. This bias can be dramatically\ndifferent for different numerical methods. As we shall show, with the right choice\nof numerical method it is often possible to substantially reduce this error, and it is\nalso possible to calculate (under some assumptions) the perturbation introduced by\nthe numerical method, and to correct for its presence.\nh=0.005\nh=0.02\nh=0.025\nh=0.03\nh=0.035\nh=0.04\nFig. 7.1 We illustrate computed (canonical) distributions of q D .x; y/ for a planar potential\nenergy function with two distinct basins connected by a narrow transition corridor, where high/low\nintensity is colored red/blue respectively. Each distribution is computed through simulations using\na different stepsize parameter—no other properties are changed between the simulations. The\ndifferences between the distributions are the result of discretization error. At simulations with a\nlarger timestep we can see a qualitative change in the sampled landscape, with the bridge between\nthe two regions disappearing. Figure reprinted with permission from [222]. Copyright 2013, AIP\nPublishing LLC\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。"
  ],
  "issues": [],
  "statement_scope": "离散平均值偏差的定义；本段关于标准方法的概述不作为普遍量化结论。",
  "lean_decl": "MD.Ch07.bias",
  "lean_declarations": [
    "MD.Ch07.bias"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bias (exact computed : ℝ) : ℝ := |exact - computed|
```

## MD-7.2-ScalarSDE
```json
{
  "source_id": "MD-7.2-ScalarSDE",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "Let us begin with a discussion of the first order stochastic differential equation\n\\[dX=a(X)dt+b(X)dW,\\]\nwhere $W$ defines a standard scalar Wiener process.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 285,
      "printed_page": 264,
      "text": "264\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.2\nError in Methods for Stochastic Differential Equations\nWe brieﬂy present some standard material on the development of numerical schemes\nfor SDEs. The interested reader is pointed to the standard textbooks [200, 270] for a\nmore thorough discussion of foundational concepts. Let us begin with a discussion\nof the ﬁrst order stochastic differential equation\ndX D a.X/dt C b.X/dW;\nwhere W deﬁnes a standard scalar Wiener process. The natural extension of the\nEuler method for SDEs like this one takes the form\nXnC1 D Xn C ha.Xn/ C b.Xn/\np\nhRn;\nwhere Rn is a normal random variable with zero mean and unit variance. This\nmethod is referred to as the Euler-Maruyama method.\nNote that from the deﬁnition of the SDE, we may write\nX.t C h/ D X.t/ C\ntCh\nZ\nt\na.X.s//ds C\ntCh\nZ\nt\nb.X.s//dW.s/:\nJust as in the deterministic case, we may build a numerical method by approximating\nthese integrals over a small timestep h. However, when designing a numerical\nscheme it is important to keep in mind the goal of the discretization itself. For\nexample, as we have considered Langevin dynamics as a tool for studying the\ncanonical distribution, do we always need methods to give us good approximations\nof X.t C h/? If we seek to compute averages with respect to the canonical\ndistribution, then the answer is no: we simply require that the average over the\ndiscretized trajectory is accurate.\nThe numerical analysis of stochastic differential equations is traditionally based\non the concepts of weak and strong accuracy. Let a numerical method be given for\nsolving an SDE in the form of a discrete stochastic process XnC1 D ˚.Xn; h/ for\nn D 0; 1; : : : ; \u0003 \u0003 1, where \u0003h D \u0002 is ﬁxed. We denote the stochastic solution of the\nSDE by X.t/. In the case of strong accuracy, our measure of the global error is the\nquantity [200]\nErrstrong\nh;\u0002I˛ D\nmax\nnD0;1;2;:::;\u0003\n\nE jXn \u0003 X.nh/j˛\u000b1=˛ :\nFor ˛ D 1 this implies convergence of expectation. The more natural choice from\nthe probabilistic point of view is ˛ D 2 (mean square convergence). Having settled\non a choice of ˛, we say that a method has strong order r if Errstrong\nh;\u0002\n< C.\u0002/hr for\nsome coefﬁcient C.\u0002/ depending on the time interval.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "明确概率空间与标准连续Wiener过程；Itô积分采用第6章网格左和L²定义，扩散项适应自然历史且时间平方可积。",
    "X的初值、几乎处处路径连续性和积分方程在第6章定义体中全部保留；未声称一般弱解与本L²表示等价。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.scalarSDE",
  "lean_declarations": [
    "MD.Ch07.scalarSDE"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def scalarSDE (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ IsBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ T : ℝ, 0 ≤ T → ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W
    (fun t sample ↦ b (X t sample)) ∧
  MolecularDynamics.Chapter06Review.scalarSDE P W X
    (fun x _ ↦ a x) (fun x _ ↦ b x) x0
```

## MD-7.2-EulerMaruyama
```json
{
  "source_id": "MD-7.2-EulerMaruyama",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "The natural extension of the Euler method for SDEs like this one takes the form\n\\[X_{n+1}=X_n+ha(X_n)+b(X_n)\\sqrt h R_n,\\]\nwhere $R_n$ is a normal random variable with zero mean and unit variance. This method is referred to as the Euler-Maruyama method.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 285,
      "printed_page": 264,
      "text": "264\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.2\nError in Methods for Stochastic Differential Equations\nWe brieﬂy present some standard material on the development of numerical schemes\nfor SDEs. The interested reader is pointed to the standard textbooks [200, 270] for a\nmore thorough discussion of foundational concepts. Let us begin with a discussion\nof the ﬁrst order stochastic differential equation\ndX D a.X/dt C b.X/dW;\nwhere W deﬁnes a standard scalar Wiener process. The natural extension of the\nEuler method for SDEs like this one takes the form\nXnC1 D Xn C ha.Xn/ C b.Xn/\np\nhRn;\nwhere Rn is a normal random variable with zero mean and unit variance. This\nmethod is referred to as the Euler-Maruyama method.\nNote that from the deﬁnition of the SDE, we may write\nX.t C h/ D X.t/ C\ntCh\nZ\nt\na.X.s//ds C\ntCh\nZ\nt\nb.X.s//dW.s/:\nJust as in the deterministic case, we may build a numerical method by approximating\nthese integrals over a small timestep h. However, when designing a numerical\nscheme it is important to keep in mind the goal of the discretization itself. For\nexample, as we have considered Langevin dynamics as a tool for studying the\ncanonical distribution, do we always need methods to give us good approximations\nof X.t C h/? If we seek to compute averages with respect to the canonical\ndistribution, then the answer is no: we simply require that the average over the\ndiscretized trajectory is accurate.\nThe numerical analysis of stochastic differential equations is traditionally based\non the concepts of weak and strong accuracy. Let a numerical method be given for\nsolving an SDE in the form of a discrete stochastic process XnC1 D ˚.Xn; h/ for\nn D 0; 1; : : : ; \u0003 \u0003 1, where \u0003h D \u0002 is ﬁxed. We denote the stochastic solution of the\nSDE by X.t/. In the case of strong accuracy, our measure of the global error is the\nquantity [200]\nErrstrong\nh;\u0002I˛ D\nmax\nnD0;1;2;:::;\u0003\n\nE jXn \u0003 X.nh/j˛\u000b1=˛ :\nFor ˛ D 1 this implies convergence of expectation. The more natural choice from\nthe probabilistic point of view is ˛ D 2 (mean square convergence). Having settled\non a choice of ˛, we say that a method has strong order r if Errstrong\nh;\u0002\n< C.\u0002/hr for\nsome coefﬁcient C.\u0002/ depending on the time interval.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "步长h>0用于数值解释；单步映射本身为总函数；跨步独立正态资格另由standardNormalSequence明确给出。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.eulerMaruyamaStep",
  "lean_declarations": [
    "MD.Ch07.eulerMaruyamaStep",
    "MD.Ch07.standardNormalSequence",
    "MD.Ch07.eulerMaruyama"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def eulerMaruyamaStep (a b : ℝ → ℝ) (h x R : ℝ) : ℝ :=
  x + h * a x + b x * Real.sqrt h * R

def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (gaussianReal 0 1) P

def eulerMaruyama (a b : ℝ → ℝ) (h x0 : ℝ) (R : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | k+1 => fun sample ↦ eulerMaruyamaStep a b h (eulerMaruyama a b h x0 R k sample) (R k sample)
```

## MD-7.2-SDEIncrement
```json
{
  "source_id": "MD-7.2-SDEIncrement",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "Note that from the definition of the SDE, we may write\n\\[X(t+h)=X(t)+\\int_t^{t+h}a(X(s))ds+\\int_t^{t+h}b(X(s))dW(s).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 285,
      "printed_page": 264,
      "text": "264\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.2\nError in Methods for Stochastic Differential Equations\nWe brieﬂy present some standard material on the development of numerical schemes\nfor SDEs. The interested reader is pointed to the standard textbooks [200, 270] for a\nmore thorough discussion of foundational concepts. Let us begin with a discussion\nof the ﬁrst order stochastic differential equation\ndX D a.X/dt C b.X/dW;\nwhere W deﬁnes a standard scalar Wiener process. The natural extension of the\nEuler method for SDEs like this one takes the form\nXnC1 D Xn C ha.Xn/ C b.Xn/\np\nhRn;\nwhere Rn is a normal random variable with zero mean and unit variance. This\nmethod is referred to as the Euler-Maruyama method.\nNote that from the deﬁnition of the SDE, we may write\nX.t C h/ D X.t/ C\ntCh\nZ\nt\na.X.s//ds C\ntCh\nZ\nt\nb.X.s//dW.s/:\nJust as in the deterministic case, we may build a numerical method by approximating\nthese integrals over a small timestep h. However, when designing a numerical\nscheme it is important to keep in mind the goal of the discretization itself. For\nexample, as we have considered Langevin dynamics as a tool for studying the\ncanonical distribution, do we always need methods to give us good approximations\nof X.t C h/? If we seek to compute averages with respect to the canonical\ndistribution, then the answer is no: we simply require that the average over the\ndiscretized trajectory is accurate.\nThe numerical analysis of stochastic differential equations is traditionally based\non the concepts of weak and strong accuracy. Let a numerical method be given for\nsolving an SDE in the form of a discrete stochastic process XnC1 D ˚.Xn; h/ for\nn D 0; 1; : : : ; \u0003 \u0003 1, where \u0003h D \u0002 is ﬁxed. We denote the stochastic solution of the\nSDE by X.t/. In the case of strong accuracy, our measure of the global error is the\nquantity [200]\nErrstrong\nh;\u0002I˛ D\nmax\nnD0;1;2;:::;\u0003\n\nE jXn \u0003 X.nh/j˛\u000b1=˛ :\nFor ˛ D 1 this implies convergence of expectation. The more natural choice from\nthe probabilistic point of view is ˛ D 2 (mean square convergence). Having settled\non a choice of ˛, we say that a method has strong order r if Errstrong\nh;\u0002\n< C.\u0002/hr for\nsome coefﬁcient C.\u0002/ depending on the time interval.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "区间Itô积分用两个从0开始的L²积分值之差表示；t,h非负，漂移在整个区间可积；不另造未规定的随机积分。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.sdeIncrement",
  "lean_declarations": [
    "MD.Ch07.sdeIncrement"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem sdeIncrement (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 t h : ℝ) (ht : 0 ≤ t) (hh : 0 ≤ h)
    (hX : scalarSDE P W X a b x0)
    (ha : ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 (t+h)) :
    MolecularDynamics.Chapter06Review.isItoIntegral P W (fun s sample ↦ b (X s sample)) (t+h)
      (fun sample ↦ X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) ∧
    ∀ᵐ sample ∂P, X (t+h) sample - X t sample =
      (∫ s in t..(t+h), a (X s sample)) +
      ((X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) -
       (X t sample - x0 - ∫ s in 0..t, a (X s sample))) := by
  sorry
```

## MD-7.2-StrongError
```json
{
  "source_id": "MD-7.2-StrongError",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "In the case of strong accuracy, our measure of the global error is the quantity [200]\n\\[\\mathrm{Err}_{h,\\tau;\\alpha}^{\\rm strong}=\\max_{n=0,1,2,\\ldots,\\nu}\n\\left[\\mathbb E|X_n-X(nh)|^\\alpha\\right]^{1/\\alpha}.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 285,
      "printed_page": 264,
      "text": "264\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.2\nError in Methods for Stochastic Differential Equations\nWe brieﬂy present some standard material on the development of numerical schemes\nfor SDEs. The interested reader is pointed to the standard textbooks [200, 270] for a\nmore thorough discussion of foundational concepts. Let us begin with a discussion\nof the ﬁrst order stochastic differential equation\ndX D a.X/dt C b.X/dW;\nwhere W deﬁnes a standard scalar Wiener process. The natural extension of the\nEuler method for SDEs like this one takes the form\nXnC1 D Xn C ha.Xn/ C b.Xn/\np\nhRn;\nwhere Rn is a normal random variable with zero mean and unit variance. This\nmethod is referred to as the Euler-Maruyama method.\nNote that from the deﬁnition of the SDE, we may write\nX.t C h/ D X.t/ C\ntCh\nZ\nt\na.X.s//ds C\ntCh\nZ\nt\nb.X.s//dW.s/:\nJust as in the deterministic case, we may build a numerical method by approximating\nthese integrals over a small timestep h. However, when designing a numerical\nscheme it is important to keep in mind the goal of the discretization itself. For\nexample, as we have considered Langevin dynamics as a tool for studying the\ncanonical distribution, do we always need methods to give us good approximations\nof X.t C h/? If we seek to compute averages with respect to the canonical\ndistribution, then the answer is no: we simply require that the average over the\ndiscretized trajectory is accurate.\nThe numerical analysis of stochastic differential equations is traditionally based\non the concepts of weak and strong accuracy. Let a numerical method be given for\nsolving an SDE in the form of a discrete stochastic process XnC1 D ˚.Xn; h/ for\nn D 0; 1; : : : ; \u0003 \u0003 1, where \u0003h D \u0002 is ﬁxed. We denote the stochastic solution of the\nSDE by X.t/. In the case of strong accuracy, our measure of the global error is the\nquantity [200]\nErrstrong\nh;\u0002I˛ D\nmax\nnD0;1;2;:::;\u0003\n\nE jXn \u0003 X.nh/j˛\u000b1=˛ :\nFor ˛ D 1 this implies convergence of expectation. The more natural choice from\nthe probabilistic point of view is ˛ D 2 (mean square convergence). Having settled\non a choice of ˛, we say that a method has strong order r if Errstrong\nh;\u0002\n< C.\u0002/hr for\nsome coefﬁcient C.\u0002/ depending on the time interval.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [
    "τ=νh固定；Xh与X在同一概率空间耦合。"
  ],
  "extra_assumptions": [
    "α>0且各网格误差的α次矩可积时具有误差解释；有限非空网格的sSup表示最大值；Real.rpow为实指数幂。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.strongError",
  "lean_declarations": [
    "MD.Ch07.strongError"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def strongError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (h α : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = (∫ sample, |Xh k sample - X (k*h) sample| ^ α ∂P) ^ (1/α)}
```

## MD-7.2-MeanErrorExpectation
```json
{
  "source_id": "MD-7.2-MeanErrorExpectation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "For $\\alpha=1$ this implies convergence of expectation. The more natural choice from the probabilistic point of view is $\\alpha=2$ (mean square convergence).",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 285,
      "printed_page": 264,
      "text": "264\n7\nNumerical Methods for Stochastic Molecular Dynamics\n7.2\nError in Methods for Stochastic Differential Equations\nWe brieﬂy present some standard material on the development of numerical schemes\nfor SDEs. The interested reader is pointed to the standard textbooks [200, 270] for a\nmore thorough discussion of foundational concepts. Let us begin with a discussion\nof the ﬁrst order stochastic differential equation\ndX D a.X/dt C b.X/dW;\nwhere W deﬁnes a standard scalar Wiener process. The natural extension of the\nEuler method for SDEs like this one takes the form\nXnC1 D Xn C ha.Xn/ C b.Xn/\np\nhRn;\nwhere Rn is a normal random variable with zero mean and unit variance. This\nmethod is referred to as the Euler-Maruyama method.\nNote that from the deﬁnition of the SDE, we may write\nX.t C h/ D X.t/ C\ntCh\nZ\nt\na.X.s//ds C\ntCh\nZ\nt\nb.X.s//dW.s/:\nJust as in the deterministic case, we may build a numerical method by approximating\nthese integrals over a small timestep h. However, when designing a numerical\nscheme it is important to keep in mind the goal of the discretization itself. For\nexample, as we have considered Langevin dynamics as a tool for studying the\ncanonical distribution, do we always need methods to give us good approximations\nof X.t C h/? If we seek to compute averages with respect to the canonical\ndistribution, then the answer is no: we simply require that the average over the\ndiscretized trajectory is accurate.\nThe numerical analysis of stochastic differential equations is traditionally based\non the concepts of weak and strong accuracy. Let a numerical method be given for\nsolving an SDE in the form of a discrete stochastic process XnC1 D ˚.Xn; h/ for\nn D 0; 1; : : : ; \u0003 \u0003 1, where \u0003h D \u0002 is ﬁxed. We denote the stochastic solution of the\nSDE by X.t/. In the case of strong accuracy, our measure of the global error is the\nquantity [200]\nErrstrong\nh;\u0002I˛ D\nmax\nnD0;1;2;:::;\u0003\n\nE jXn \u0003 X.nh/j˛\u000b1=˛ :\nFor ˛ D 1 this implies convergence of expectation. The more natural choice from\nthe probabilistic point of view is ˛ D 2 (mean square convergence). Having settled\non a choice of ˛, we say that a method has strong order r if Errstrong\nh;\u0002\n< C.\u0002/hr for\nsome coefﬁcient C.\u0002/ depending on the time interval.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "期望可积；不以数值方法的收敛为假设重新宣布同一收敛，只给使收敛传递成立的定量不等式。"
  ],
  "issues": [],
  "statement_scope": "α=1所需期望误差不等式，及α=2均方误差的记号；网格极限通过此界立即归约。",
  "lean_decl": "MD.Ch07.meanErrorExpectation",
  "lean_declarations": [
    "MD.Ch07.meanErrorExpectation",
    "MD.Ch07.meanSquareError"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem meanErrorExpectation (P : Measure Ω) (X Y : Ω → ℝ)
    (hX : Integrable X P) (hY : Integrable Y P) :
    |(∫ sample, X sample ∂P) - ∫ sample, Y sample ∂P| ≤
      ∫ sample, |X sample - Y sample| ∂P := by
  rw [← integral_sub hX hY]
  simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun sample ↦ X sample - Y sample)

def meanSquareError (P : Measure Ω) (X Y : Ω → ℝ) : ℝ :=
  Real.sqrt (∫ sample, (X sample - Y sample)^2 ∂P)
```
