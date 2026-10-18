# BATCH02 第7章原文与陈述审校

## MD-7.2-StrongOrder
```json
{
  "source_id": "MD-7.2-StrongOrder",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "Having settled on a choice of $\\alpha$, we say that a method has strong order $r$ if\n$\\mathrm{Err}_{h,\\tau}^{\\rm strong}<C(\\tau)h^r$ for some coefficient $C(\\tau)$ depending on the time interval.",
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
    "显式h=T/N趋零及统一常数的量词；正α、r和时间；有限矩资格作为方法适用条件不隐去。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.hasStrongOrder",
  "lean_declarations": [
    "MD.Ch07.hasStrongOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def hasStrongOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (α r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < α ∧ 0 < r ∧
  ∀ T : ℝ, 0 < T → ∃ C : ℝ, 0 < C ∧ ∃ N0 : ℕ, 0 < N0 ∧
    ∀ N : ℕ, N0 ≤ N →
      (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ |Xh (T/N) k sample - X (k*(T/N)) sample|^α) P) ∧
      strongError P (Xh (T/N)) X (T/N) α N < C * (T/N)^r
```

## MD-7.2-WeakError
```json
{
  "source_id": "MD-7.2-WeakError",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "265",
  "pdf_page": "286",
  "statement_latex": "The weak error is usually defined with reference to suitable test functions (observables) $\\phi(x)$ by\n\\[\\mathrm{Err}^{\\rm weak}_{h,\\tau,\\phi}=\\max_{n=0,1,2,\\ldots,\\nu}|\\mathbb E\\phi(X_n)-\\mathbb E\\phi(X(nh))|,\\]\nand we say that a method has weak order $r$ if $\\mathrm{Err}^{\\rm weak}_{h,\\tau,\\phi}<D(\\tau)h^r$ for some $D(\\tau)$, for all members of the chosen class of observables.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 286,
      "printed_page": 265,
      "text": "7.2\nError in Methods for Stochastic Differential Equations\n265\nThe weak error is usually deﬁned with reference to suitable test functions\n(observables) \b.x/ by\nErrweak\nh;\u0002;\b D\nmax\nnD0;1;2;:::;\u0003 jE\b.Xn/ \u0003 E\b.X.nh//j ;\nand we say that a method has weak order r if Errweak\nh;\u0002;\b < D.\u0002/hr for some D.\u0002/, for\nall members of the chosen class of observables. It is easy to see that methods with\nhigh strong order give us high weak order too, but the converse is generally false.\nAs the focus of this chapter is on the computation of averages, the concept of\nweak order is more appropriate in evaluating methods.1 Yet, even the weak order of\nconvergence may not be suitable in molecular dynamics applications, or rather, we\nare interested in the very long term behavior of the weak error which is governed by\nthe coefﬁcient D.\u0002/ as \u0002 ! 1 [270, 356].\nThe standard approach to analyze the weak error would be based on computing a\nrecurrence relation for jE\b.Xn/\u0003E\b.X.nh//j by use of the SDE and the methods of\nstochastic analysis. This approach mirrors the forward convergenceanalysis of ODE\nmethods discussed in Chap. 2. It tends, however, to overestimate the magnitude of\nthe quantity D.\u0002/. In what follows, we show that, when the emphasis is on stationary\naverages, a more direct approach can be used to gain insight into the error based on\nan asymptotic expansion. In some cases, we are able to resolve explicitly the leading\nerror term of computed averages in this long-time limit. The approach used here is\nanalogous in many ways to the backward error analysis of deterministic problems\npresented in Chap. 3.\nThe sampling error is an additional error term that results from the ﬁniteness of\nour trajectory: both in our inability to sample over an inﬁnite time (for Langevin\ndynamics, we recover our averages only in the limit of \u0002 ! 1) and our generation\nof only a ﬁnite number of points (averages are calculated from our discretized\ntrajectory of \u0003 steps). In large, high-dimensional systems (such as many relevant\nbiomolecular applications) often the computational resource required to sample\nlong enough in time to recover good averages is not available—the challenge then\ncan be viewed as an exploration problem. Obtaining a complete sampling of the\nphase space in a system with rare transitions is extremely difﬁcult, and is the most\nimportant challenge in molecular simulation [401].\nHowever, we emphasize in this chapter that the discretization error (or perfect\nsampling bias) is also a very important contribution to the overall error, and in\nsome cases may dominate the sampling error (for example, in systems where\nlocal resolution of the measure is more important than the global search). This\ndiscretization bias cannot be removed by considering a longer simulation time, so\nin some sense it is akin to a modelling error. Indeed as computing power increases\nand new algorithms are utilized, it is likely that trajectory generation will always be\n1In practice all the methods presented here are convergent in the strong sense, but their strong\nconvergence orders may be low, typically r D 1=2.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "测试函数类明确量化；D允许依赖测试函数；积分只有在可积时解释为期望，后续误差定理显式要求可积。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.weakError",
  "lean_declarations": [
    "MD.Ch07.weakError",
    "MD.Ch07.hasWeakOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def weakError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (f : ℝ → ℝ) (h : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = |(∫ sample, f (Xh k sample) ∂P) - ∫ sample, f (X (k*h) sample) ∂P|}

def hasWeakOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (tests : Set (ℝ → ℝ)) (r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < r ∧ ∀ f ∈ tests, ∀ T : ℝ, 0 < T →
    ∃ D : ℝ, 0 < D ∧ ∃ N0 : ℕ, 0 < N0 ∧
      ∀ N : ℕ, N0 ≤ N →
        (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ f (Xh (T/N) k sample)) P ∧
          Integrable (fun sample ↦ f (X (k*(T/N)) sample)) P) ∧
        weakError P (Xh (T/N)) X f (T/N) N < D*(T/N)^r
```

## MD-7.2-StrongWeakComparison
```json
{
  "source_id": "MD-7.2-StrongWeakComparison",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "265",
  "pdf_page": "286",
  "statement_latex": "It is easy to see that methods with high strong order give us high weak order too, but the converse is generally false.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 286,
      "printed_page": 265,
      "text": "7.2\nError in Methods for Stochastic Differential Equations\n265\nThe weak error is usually deﬁned with reference to suitable test functions\n(observables) \b.x/ by\nErrweak\nh;\u0002;\b D\nmax\nnD0;1;2;:::;\u0003 jE\b.Xn/ \u0003 E\b.X.nh//j ;\nand we say that a method has weak order r if Errweak\nh;\u0002;\b < D.\u0002/hr for some D.\u0002/, for\nall members of the chosen class of observables. It is easy to see that methods with\nhigh strong order give us high weak order too, but the converse is generally false.\nAs the focus of this chapter is on the computation of averages, the concept of\nweak order is more appropriate in evaluating methods.1 Yet, even the weak order of\nconvergence may not be suitable in molecular dynamics applications, or rather, we\nare interested in the very long term behavior of the weak error which is governed by\nthe coefﬁcient D.\u0002/ as \u0002 ! 1 [270, 356].\nThe standard approach to analyze the weak error would be based on computing a\nrecurrence relation for jE\b.Xn/\u0003E\b.X.nh//j by use of the SDE and the methods of\nstochastic analysis. This approach mirrors the forward convergenceanalysis of ODE\nmethods discussed in Chap. 2. It tends, however, to overestimate the magnitude of\nthe quantity D.\u0002/. In what follows, we show that, when the emphasis is on stationary\naverages, a more direct approach can be used to gain insight into the error based on\nan asymptotic expansion. In some cases, we are able to resolve explicitly the leading\nerror term of computed averages in this long-time limit. The approach used here is\nanalogous in many ways to the backward error analysis of deterministic problems\npresented in Chap. 3.\nThe sampling error is an additional error term that results from the ﬁniteness of\nour trajectory: both in our inability to sample over an inﬁnite time (for Langevin\ndynamics, we recover our averages only in the limit of \u0002 ! 1) and our generation\nof only a ﬁnite number of points (averages are calculated from our discretized\ntrajectory of \u0003 steps). In large, high-dimensional systems (such as many relevant\nbiomolecular applications) often the computational resource required to sample\nlong enough in time to recover good averages is not available—the challenge then\ncan be viewed as an exploration problem. Obtaining a complete sampling of the\nphase space in a system with rare transitions is extremely difﬁcult, and is the most\nimportant challenge in molecular simulation [401].\nHowever, we emphasize in this chapter that the discretization error (or perfect\nsampling bias) is also a very important contribution to the overall error, and in\nsome cases may dominate the sampling error (for example, in systems where\nlocal resolution of the measure is more important than the global search). This\ndiscretization bias cannot be removed by considering a longer simulation time, so\nin some sense it is akin to a modelling error. Indeed as computing power increases\nand new algorithms are utilized, it is likely that trajectory generation will always be\n1In practice all the methods presented here are convergent in the strong sense, but their strong\nconvergence orders may be low, typically r D 1=2.\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "正向结论明确限制为全局Lipschitz可观测量及可积误差；对一般无界测试函数需额外矩条件，列为覆盖缺口。",
    "反向用两点分布上交换X、Y的反例表达；同分布但耦合强误差不为零。"
  ],
  "issues": [],
  "statement_scope": "Lipschitz测试函数的逐步定量界与反向不成立的存在性；未证明一般多项式增长测试类的阶数传递。",
  "lean_decl": "MD.Ch07.strongWeakLipschitz",
  "lean_declarations": [
    "MD.Ch07.strongWeakLipschitz",
    "MD.Ch07.weakDoesNotImplyStrong"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem strongWeakLipschitz (P : Measure Ω) (X Y : Ω → ℝ)
    (f : ℝ → ℝ) (L : ℝ) (hL : 0 ≤ L)
    (hf : ∀ x y, |f x - f y| ≤ L * |x-y|)
    (hfx : Integrable (fun sample ↦ f (X sample)) P)
    (hfy : Integrable (fun sample ↦ f (Y sample)) P)
    (hxy : Integrable (fun sample ↦ |X sample-Y sample|) P) :
    |(∫ sample, f (X sample) ∂P) - ∫ sample, f (Y sample) ∂P| ≤
      L * ∫ sample, |X sample-Y sample| ∂P := by
  calc
    _ ≤ ∫ sample, |f (X sample)-f (Y sample)| ∂P :=
      meanErrorExpectation P _ _ hfx hfy
    _ ≤ ∫ sample, L * |X sample-Y sample| ∂P :=
      integral_mono (hfx.sub hfy).abs (hxy.const_mul L) (fun sample ↦ hf _ _)
    _ = _ := integral_const_mul _ _

theorem weakDoesNotImplyStrong : ∃ (P : Measure ℝ) (X Y : ℝ → ℝ),
    IsProbabilityMeasure P ∧
    (∀ f : ℝ → ℝ, (∫ sample, f (X sample) ∂P) = ∫ sample, f (Y sample) ∂P) ∧
    0 < ∫ sample, |X sample-Y sample| ∂P := by
  let P : Measure ℝ := (1/2 : ℝ≥0) • Measure.dirac (-1)+(1/2 : ℝ≥0) • Measure.dirac 1
  have hi (f : ℝ → ℝ) (a : ℝ) : Integrable f ((1/2 : ℝ≥0) • Measure.dirac a) :=
    (integrable_dirac (by simp)).smul_measure_nnreal
  refine ⟨P,id,Neg.neg,?_,?_,?_⟩
  · constructor
    simp only [P,Measure.add_apply,Measure.smul_apply,Measure.dirac_apply_of_mem (Set.mem_univ _),ENNReal.smul_def,smul_eq_mul,mul_one]
    exact_mod_cast (by norm_num : (1/2 : ℝ≥0)+(1/2 : ℝ≥0) = 1)
  · intro f
    dsimp [P]
    rw [integral_add_measure (hi _ _) (hi _ _),integral_add_measure (hi _ _) (hi _ _)]
    simp [integral_smul_nnreal_measure,add_comm]
  · dsimp [P]
    rw [integral_add_measure (hi _ _) (hi _ _)]
    norm_num [integral_smul_nnreal_measure]

```

## MD-7.2-CanonicalAverage
```json
{
  "source_id": "MD-7.2-CanonicalAverage",
  "kind": "definition",
  "label": "(7.1)",
  "section": "7.2",
  "printed_page": "266",
  "pdf_page": "287",
  "statement_latex": "Recall that for canonical sampling, the (stationary or invariant) average of an observable $\\phi(q,p)$ is given as\n\\[\\operatorname{Av}_\\beta(\\phi)=\\int_D\\phi(q,p)\\rho_\\beta(q,p)d\\omega,\\tag{7.1}\\]\nwhere $\\rho_\\beta$ is the canonical measure\n\\[\\rho_\\beta(q,p)=Z_{\\rm can}^{-1}\\exp(-\\beta H(q,p)).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 287,
      "printed_page": 266,
      "text": "266\n7\nNumerical Methods for Stochastic Molecular Dynamics\nat the core of sampling in molecular dynamics. Hence we are motivated to ﬁnd\nschemes that minimize this sampling bias introduced to the long-time averages,\nwithout signiﬁcant increase to the method’s computational cost.\nRecall that for canonical sampling, the (stationary or invariant) average of an\nobservable \b.q; p/ is given as\nAvˇ.\b/ D\nZ\nD\n\b.q; p/\u0005ˇ.q; p/d!;\n(7.1)\nwhere \u0005ˇ is the canonical measure\n\u0005ˇ.q; p/ D Z\u00021\ncan exp .\u0003ˇH.q; p// ;\nand Zcan is the canonical partition function\nZ\u00021\ncan D\nZ\nD\nexp .\u0003ˇH.q; p// d!;\nensuring the integral of \u0005ˇ is unity. In this chapter, we will abbreviate the exact\naverage of the observable \b to\nh\bi\ndef\nD Avˇ.\b/;\nand write the observed average computed in experiment (using a discretization\nmethod with step size h) as h\bih. The error in the average of \b due to the perfect\nsampling bias can be evaluated as\nError due to discretization D jh\bi \u0003 h\bihj :\nWe assume that the observed value of h\bih is corrupted as a result of our discretiza-\ntion, ignoring all other sources of error in our simulation. It is this sampling bias\nwe would like to calculate (in order to correct our computed averages), or develop\nnumerical sampling methods that naturally minimize this error.\nIn Fig. 7.2 we quantify the difference between the computed distribution of\nq 2 R and the canonical distribution, for the one-dimensional double well potential\nU.q/ D .q2 \u0003 1/2, using Langevin dynamics with parameters M D \n D ˇ D 1.\nThe dynamics are discretized using a standard Langevin dynamics second-order\nalgorithm taken from [62], where we sample the distribution of q along our\ndiscretized trajectory. Each step of the algorithm requires one force evaluation, so\nwe may think of the vertical axis in Fig. 7.2 representing the total computational\nwork.\nIf we were able to solve the Langevin dynamics SDE exactly, then as we\nevolve the system in time the distribution will converge towards the canonical\ndistribution, however the effects of numerical discretization are apparent in the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "该公式先保留显式Z参数；只有probabilityDensity成立才称概率密度。正有限配分积分及其归一化见修正版，不把原页倒数疑误带入默认定义。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.densityWithPartition",
  "lean_declarations": [
    "MD.Ch07.densityWithPartition",
    "MD.Ch07.canonicalAverage",
    "MD.Ch07.probabilityDensity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def densityWithPartition {D : Type*} (H : D → ℝ) (β Z : ℝ) (x : D) : ℝ :=
  Z⁻¹ * Real.exp (-β * H x)

def canonicalAverage {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z : ℝ) : ℝ := ∫ x, f x * densityWithPartition H β Z x ∂ν

def probabilityDensity {D : Type*} [MeasurableSpace D] (ν : Measure D) (ρ : D → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ x) ∧ Integrable ρ ν ∧ (∫ x, ρ x ∂ν) = 1
```

## MD-7.2-PartitionPrinted
```json
{
  "source_id": "MD-7.2-PartitionPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "266",
  "pdf_page": "287",
  "statement_latex": "and $Z_{\\rm can}$ is the canonical partition function\n\\[Z_{\\rm can}^{-1}=\\int_D\\exp(-\\beta H(q,p))d\\omega,\\]\nensuring the integral of $\\rho_\\beta$ is unity.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 287,
      "printed_page": 266,
      "text": "266\n7\nNumerical Methods for Stochastic Molecular Dynamics\nat the core of sampling in molecular dynamics. Hence we are motivated to ﬁnd\nschemes that minimize this sampling bias introduced to the long-time averages,\nwithout signiﬁcant increase to the method’s computational cost.\nRecall that for canonical sampling, the (stationary or invariant) average of an\nobservable \b.q; p/ is given as\nAvˇ.\b/ D\nZ\nD\n\b.q; p/\u0005ˇ.q; p/d!;\n(7.1)\nwhere \u0005ˇ is the canonical measure\n\u0005ˇ.q; p/ D Z\u00021\ncan exp .\u0003ˇH.q; p// ;\nand Zcan is the canonical partition function\nZ\u00021\ncan D\nZ\nD\nexp .\u0003ˇH.q; p// d!;\nensuring the integral of \u0005ˇ is unity. In this chapter, we will abbreviate the exact\naverage of the observable \b to\nh\bi\ndef\nD Avˇ.\b/;\nand write the observed average computed in experiment (using a discretization\nmethod with step size h) as h\bih. The error in the average of \b due to the perfect\nsampling bias can be evaluated as\nError due to discretization D jh\bi \u0003 h\bihj :\nWe assume that the observed value of h\bih is corrupted as a result of our discretiza-\ntion, ignoring all other sources of error in our simulation. It is this sampling bias\nwe would like to calculate (in order to correct our computed averages), or develop\nnumerical sampling methods that naturally minimize this error.\nIn Fig. 7.2 we quantify the difference between the computed distribution of\nq 2 R and the canonical distribution, for the one-dimensional double well potential\nU.q/ D .q2 \u0003 1/2, using Langevin dynamics with parameters M D \n D ˇ D 1.\nThe dynamics are discretized using a standard Langevin dynamics second-order\nalgorithm taken from [62], where we sample the distribution of q along our\ndiscretized trajectory. Each step of the algorithm requires one force evaluation, so\nwe may think of the vertical axis in Fig. 7.2 representing the total computational\nwork.\nIf we were able to solve the Langevin dynamics SDE exactly, then as we\nevolve the system in time the distribution will converge towards the canonical\ndistribution, however the effects of numerical discretization are apparent in the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文版严格保留倒数关系；修正版取Z_can=配分积分，并补正性、可积性。",
    "反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。"
  ],
  "issues": [
    "已目视核对原页PDF287／印刷266：原书确为Z_can^{-1}=积分，和紧接的归一化断言不相容；不是转录错误。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.partitionPrinted",
  "lean_declarations": [
    "MD.Ch07.partitionPrinted",
    "MD.Ch07.partitionPrinted_counterexample",
    "MD.Ch07.partitionPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem partitionPrinted {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β Z : ℝ) (hZ : 0 < Z)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hPrinted : Z⁻¹ = ∫ x, Real.exp (-β*H x) ∂ν) :
    (∫ x, densityWithPartition H β Z x ∂ν) = 1 := by
  sorry

theorem partitionPrinted_counterexample :
    (2 : ℝ)⁻¹ * (2 : ℝ)⁻¹ ≠ 1 := by norm_num

theorem partitionPrinted_corrected {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hZ : 0 < ∫ x, Real.exp (-β*H x) ∂ν) :
    probabilityDensity ν (densityWithPartition H β (∫ x, Real.exp (-β*H x) ∂ν)) := by
  refine ⟨fun x ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ)) (le_of_lt (Real.exp_pos _)),
    hi.const_mul _, ?_⟩
  simp only [densityWithPartition, integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)
```

## MD-7.2-AverageNotationBias
```json
{
  "source_id": "MD-7.2-AverageNotationBias",
  "kind": "notation",
  "label": null,
  "section": "7.2",
  "printed_page": "266",
  "pdf_page": "287",
  "statement_latex": "In this chapter, we will abbreviate the exact average of the observable $\\phi$ to\n\\[\\langle\\phi\\rangle\\overset{\\rm def}=\\operatorname{Av}_\\beta(\\phi),\\]\nand write the observed average computed in experiment (using a discretization method with step size $h$) as $\\langle\\phi\\rangle_h$. The error in the average of $\\phi$ due to the perfect sampling bias can be evaluated as\n\\[\\text{Error due to discretization}=|\\langle\\phi\\rangle-\\langle\\phi\\rangle_h|.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 287,
      "printed_page": 266,
      "text": "266\n7\nNumerical Methods for Stochastic Molecular Dynamics\nat the core of sampling in molecular dynamics. Hence we are motivated to ﬁnd\nschemes that minimize this sampling bias introduced to the long-time averages,\nwithout signiﬁcant increase to the method’s computational cost.\nRecall that for canonical sampling, the (stationary or invariant) average of an\nobservable \b.q; p/ is given as\nAvˇ.\b/ D\nZ\nD\n\b.q; p/\u0005ˇ.q; p/d!;\n(7.1)\nwhere \u0005ˇ is the canonical measure\n\u0005ˇ.q; p/ D Z\u00021\ncan exp .\u0003ˇH.q; p// ;\nand Zcan is the canonical partition function\nZ\u00021\ncan D\nZ\nD\nexp .\u0003ˇH.q; p// d!;\nensuring the integral of \u0005ˇ is unity. In this chapter, we will abbreviate the exact\naverage of the observable \b to\nh\bi\ndef\nD Avˇ.\b/;\nand write the observed average computed in experiment (using a discretization\nmethod with step size h) as h\bih. The error in the average of \b due to the perfect\nsampling bias can be evaluated as\nError due to discretization D jh\bi \u0003 h\bihj :\nWe assume that the observed value of h\bih is corrupted as a result of our discretiza-\ntion, ignoring all other sources of error in our simulation. It is this sampling bias\nwe would like to calculate (in order to correct our computed averages), or develop\nnumerical sampling methods that naturally minimize this error.\nIn Fig. 7.2 we quantify the difference between the computed distribution of\nq 2 R and the canonical distribution, for the one-dimensional double well potential\nU.q/ D .q2 \u0003 1/2, using Langevin dynamics with parameters M D \n D ˇ D 1.\nThe dynamics are discretized using a standard Langevin dynamics second-order\nalgorithm taken from [62], where we sample the distribution of q along our\ndiscretized trajectory. Each step of the algorithm requires one force evaluation, so\nwe may think of the vertical axis in Fig. 7.2 representing the total computational\nwork.\nIf we were able to solve the Langevin dynamics SDE exactly, then as we\nevolve the system in time the distribution will converge towards the canonical\ndistribution, however the effects of numerical discretization are apparent in the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "computed代表步长h下的不变平均，按原文忽略有限采样误差；正确Z和密度概率资格见CanonicalAverage及修正版。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.observableBias",
  "lean_declarations": [
    "MD.Ch07.observableBias",
    "MD.Ch07.bias_nonnegative"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def observableBias {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z computed : ℝ) : ℝ :=
  bias (canonicalAverage ν H f β Z) computed

theorem bias_nonnegative (exact computed : ℝ) : 0 ≤ bias exact computed := abs_nonneg _
```
