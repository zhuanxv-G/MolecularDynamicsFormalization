# BATCH03 第7章原文与陈述审校

## MD-7.3-VectorOU
```json
{
  "source_id": "MD-7.3-VectorOU",
  "kind": "definition",
  "label": "(7.2)",
  "section": "7.3",
  "printed_page": "267",
  "pdf_page": "288",
  "statement_latex": "By way of illustration of what we mean by a numerical sampling method, consider the system of independent Ornstein-Uhlenbeck (OU) processes\n\\[dp=-\\gamma pdt+\\sqrt{2k_BT\\gamma}\\,M^{1/2}dW.\\tag{7.2}\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 288,
      "printed_page": 267,
      "text": "7.3\nSampling Iterations\n267\n105\n104\n103\n102\n101\n0.05\n0.1\n0.2\n0.3\nStepsize\nNumber of force evaluations\nOp\nOp\nOptitimu\nmum ststststep\nep\nep\nepsisisize\nze\nze\nze\nLarge\nError\nSmall\nError\nFig. 7.2 We plot the error in the distribution of q 2 R for U.q/ D .q2 \u0002 1/2. The error in\nthe computed distribution is a function of both the number of force evaluations and the stepsize\nused, with the optimal choice of stepsize for a given number of force evaluations shown by the\nwhite guideline. Due to discretization bias, choosing the maximum stepsize is not always the best\nstrategy\nﬁgure: while increasing the stepsize means we more rapidly converge with each\nstep, the distribution that the discretization scheme converges to is incorrect. For\nsmall stepsizes, this error due to discretization may be negligible when compared to\nthe sampling error, but we converge more slowly towards the ﬁnal distribution. As\nthe stepsize is increased, the discretization error may dominate the overall error in\ncalculation.\n7.3\nSampling Iterations\nBy way of illustration of what we mean by a numerical sampling method, consider\nthe system of independent Ornstein-Uhlenbeck (OU) processes\ndp D \u0003\npdt C\np\n2kBT\nM1=2dW:\n(7.2)\nFollowing the argument of Sect. 6.3.2 in the previous chapter,\ndŒexp.\nt/p\t D \n exp.\nt/pdt C exp.\nt/Œ\u0003\npdt C\np\n2kBT\nM1=2dW\t\nD exp.\nt/\np\n2kBT\nM1=2dW:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [
    "θ=k_BT；M为正对角质量矩阵，m i为其对角元。"
  ],
  "extra_assumptions": [
    "显式标准多维Wiener及整个坐标路径独立，正质量、温度与非负摩擦；各坐标用真实Itô积分方程。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.V",
  "lean_declarations": [
    "MD.Ch07.V",
    "MD.Ch07.Phase",
    "MD.Ch07.vectorWiener",
    "MD.Ch07.momentumOU"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
abbrev V (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := V n × V n

def vectorWiener (P : Measure Ω) (W : ℝ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  iIndepFun (fun i sample t ↦ W t sample i) P

def momentumOU (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  ∀ i, scalarSDE P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i)
    (fun x ↦ -γ*x) (fun _ ↦ Real.sqrt (2*γ*θ*m i)) (p0 i)
```

## MD-7.3-OUIntegratingFactor
```json
{
  "source_id": "MD-7.3-OUIntegratingFactor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3",
  "printed_page": "267",
  "pdf_page": "288",
  "statement_latex": "Following the argument of Sect. 6.3.2 in the previous chapter,\n\\[d[\\exp(\\gamma t)p]=\\gamma\\exp(\\gamma t)pdt+\\exp(\\gamma t)[-\\gamma pdt+\\sqrt{2k_BT\\gamma}M^{1/2}dW]\n=\\exp(\\gamma t)\\sqrt{2k_BT\\gamma}M^{1/2}dW.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 288,
      "printed_page": 267,
      "text": "7.3\nSampling Iterations\n267\n105\n104\n103\n102\n101\n0.05\n0.1\n0.2\n0.3\nStepsize\nNumber of force evaluations\nOp\nOp\nOptitimu\nmum ststststep\nep\nep\nepsisisize\nze\nze\nze\nLarge\nError\nSmall\nError\nFig. 7.2 We plot the error in the distribution of q 2 R for U.q/ D .q2 \u0002 1/2. The error in\nthe computed distribution is a function of both the number of force evaluations and the stepsize\nused, with the optimal choice of stepsize for a given number of force evaluations shown by the\nwhite guideline. Due to discretization bias, choosing the maximum stepsize is not always the best\nstrategy\nﬁgure: while increasing the stepsize means we more rapidly converge with each\nstep, the distribution that the discretization scheme converges to is incorrect. For\nsmall stepsizes, this error due to discretization may be negligible when compared to\nthe sampling error, but we converge more slowly towards the ﬁnal distribution. As\nthe stepsize is increased, the discretization error may dominate the overall error in\ncalculation.\n7.3\nSampling Iterations\nBy way of illustration of what we mean by a numerical sampling method, consider\nthe system of independent Ornstein-Uhlenbeck (OU) processes\ndp D \u0003\npdt C\np\n2kBT\nM1=2dW:\n(7.2)\nFollowing the argument of Sect. 6.3.2 in the previous chapter,\ndŒexp.\nt/p\t D \n exp.\nt/pdt C exp.\nt/Œ\u0003\npdt C\np\n2kBT\nM1=2dW\t\nD exp.\nt/\np\n2kBT\nM1=2dW:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "把随机微分乘积法则陈述为从0到t的确定性加权Itô积分等式；有限时间和L²解资格由momentumOU明确。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.ouIntegratingFactor",
  "lean_declarations": [
    "MD.Ch07.ouIntegratingFactor"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem ouIntegratingFactor (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t : ℝ) (ht : 0 ≤ t) : ∀ i,
    MolecularDynamics.Chapter06Review.isItoIntegral P (fun s sample ↦ W s sample i)
      (fun s _ ↦ Real.exp (γ*s)*Real.sqrt (2*γ*θ*m i)) t
      (fun sample ↦ Real.exp (γ*t)*p t sample i-p0 i) := by
  sorry
```

## MD-7.3-OUExactUpdate
```json
{
  "source_id": "MD-7.3-OUExactUpdate",
  "kind": "unnumbered_claim",
  "label": "(7.3)",
  "section": "7.3",
  "printed_page": "268",
  "pdf_page": "289",
  "statement_latex": "Integrating from $t$ to $t+h$ and multiplying by $\\exp(-\\gamma t)$, we arrive at the solution\n\\[p(t+h)=e^{-\\gamma h}p(t)+\\sqrt{k_BT(1-e^{-2\\gamma h})}M^{1/2}Z,\\tag{7.3}\\]\nwhere $Z$ is a vector of independent, standard normal random variables.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 289,
      "printed_page": 268,
      "text": "268\n7\nNumerical Methods for Stochastic Molecular Dynamics\nIntegrating from t to t C h and multiplying by exp.\u0003\nt/, we arrive at the solution\np.t C h/ D e\u0002\nhp.t/ C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Z;\n(7.3)\nwhere Z is a vector of independent, standard normal random variables. Alterna-\ntively, we may write this as a discrete iteration in terms of a random map:\npnC1 D e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn;\nwith normally distributed R. For later purposes, we will think of this update as acting\non both q and p, leaving q unchanged, i.e.\n.qnC1; pnC1/ D .qn; e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn/:\nThe Fokker-Planck operator for the OU system (7.2) can be computed directly as\nL\u0004\nO\b.q; p/ D \nrp \u0002 .p\b/ C \nkBTrp \u0002 Mrp\b:\nThe Ornstein-Uhlenbeck process models the momentum of a Brownian particle,\nand in deriving it we thought of \n as being associated to the collisional frequency\nwith the particles of the bath. Alternatively, if we ignore the physical origin of this\nparameter, we can think of \n as an arbitrary coefﬁcient; the sampling of the invariant\nmeasure does not depend on this choice. Thus we have a family of sampling\niterations for the Gaussian distribution, deﬁned for different choices of \n.\n7.3.1\nSplitting Methods for Langevin Dynamics\nWe will now consider a family of iterations for molecular systems which are con-\nstructed from simple building blocks based on the splitting of an SDE, speciﬁcally\nLangevin dynamics:\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \npdt C\np\n2\nkBTM1=2dW:\n(7.4)\nJust as in the deterministic setting (for Newton’s equations of motion) we construct\nsuch splitting methods by way of an additive decomposition of the vector ﬁeld,\nwhere the differential equations corresponding to any individual piece can be solved\nexactly. Methods are built from a sequence of updates corresponding to an exact\nsolve of each piece. By “exact solve” we here mean the construction of a method of\nexactly sampling the distribution generated by the corresponding component. The\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "等式解释为存在与过去动量独立的标准正态向量的随机表示；不是沿用同一Z表示所有时刻。",
    "独立性要求使用W自然历史的适应解，见scalarSDE；θ=k_BT，M正对角。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.ouMomentum",
  "lean_declarations": [
    "MD.Ch07.ouMomentum",
    "MD.Ch07.ouTransitionLaw"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def ouMomentum (m : V n) (γ θ h : ℝ) (p R : V n) : V n :=
  fun i ↦ Real.exp (-γ*h)*p i + Real.sqrt (θ*(1-Real.exp (-2*γ*h))) * Real.sqrt (m i) * R i

theorem ouTransitionLaw (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t h : ℝ) (ht : 0 ≤ t) (hh : 0 < h) :
    ∃ Z : Ω → V n, HasLaw Z (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P ∧
      IndepFun (p t) Z P ∧ ∀ᵐ sample ∂P,
        p (t+h) sample = ouMomentum m γ θ h (p t sample) (Z sample) := by
  sorry
```

## MD-7.3-OUPhaseIteration
```json
{
  "source_id": "MD-7.3-OUPhaseIteration",
  "kind": "definition",
  "label": null,
  "section": "7.3",
  "printed_page": "268",
  "pdf_page": "289",
  "statement_latex": "Alternatively, we may write this as a discrete iteration in terms of a random map:\n\\[p_{n+1}=e^{-\\gamma h}p_n+\\sqrt{k_BT(1-e^{-2\\gamma h})}M^{1/2}R_n,\\]\nwith normally distributed $R$. For later purposes, we will think of this update as acting on both $q$ and $p$, leaving $q$ unchanged, i.e.\n\\[(q_{n+1},p_{n+1})=(q_n,e^{-\\gamma h}p_n+\\sqrt{k_BT(1-e^{-2\\gamma h})}M^{1/2}R_n).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 289,
      "printed_page": 268,
      "text": "268\n7\nNumerical Methods for Stochastic Molecular Dynamics\nIntegrating from t to t C h and multiplying by exp.\u0003\nt/, we arrive at the solution\np.t C h/ D e\u0002\nhp.t/ C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Z;\n(7.3)\nwhere Z is a vector of independent, standard normal random variables. Alterna-\ntively, we may write this as a discrete iteration in terms of a random map:\npnC1 D e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn;\nwith normally distributed R. For later purposes, we will think of this update as acting\non both q and p, leaving q unchanged, i.e.\n.qnC1; pnC1/ D .qn; e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn/:\nThe Fokker-Planck operator for the OU system (7.2) can be computed directly as\nL\u0004\nO\b.q; p/ D \nrp \u0002 .p\b/ C \nkBTrp \u0002 Mrp\b:\nThe Ornstein-Uhlenbeck process models the momentum of a Brownian particle,\nand in deriving it we thought of \n as being associated to the collisional frequency\nwith the particles of the bath. Alternatively, if we ignore the physical origin of this\nparameter, we can think of \n as an arbitrary coefﬁcient; the sampling of the invariant\nmeasure does not depend on this choice. Thus we have a family of sampling\niterations for the Gaussian distribution, deﬁned for different choices of \n.\n7.3.1\nSplitting Methods for Langevin Dynamics\nWe will now consider a family of iterations for molecular systems which are con-\nstructed from simple building blocks based on the splitting of an SDE, speciﬁcally\nLangevin dynamics:\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \npdt C\np\n2\nkBTM1=2dW:\n(7.4)\nJust as in the deterministic setting (for Newton’s equations of motion) we construct\nsuch splitting methods by way of an additive decomposition of the vector ﬁeld,\nwhere the differential equations corresponding to any individual piece can be solved\nexactly. Methods are built from a sequence of updates corresponding to an exact\nsolve of each piece. By “exact solve” we here mean the construction of a method of\nexactly sampling the distribution generated by the corresponding component. The\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "独立标准正态的完整概率资格由vectorNormalSequence规定；ouStep只是总化单步函数。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.ouStep",
  "lean_declarations": [
    "MD.Ch07.ouStep",
    "MD.Ch07.vectorNormalSequence"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def ouStep (m : V n) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  (x.1, ouMomentum m γ θ h x.2 R)

def vectorNormalSequence (P : Measure Ω) (R : ℕ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P
```

## MD-7.3-OUForward
```json
{
  "source_id": "MD-7.3-OUForward",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3",
  "printed_page": "268",
  "pdf_page": "289",
  "statement_latex": "The Fokker-Planck operator for the OU system (7.2) can be computed directly as\n\\[\\mathcal L_O^\\dagger\\phi(q,p)=\\gamma\\nabla_p\\cdot(p\\phi)+\\gamma k_BT\\nabla_p\\cdot M\\nabla_p\\phi.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 289,
      "printed_page": 268,
      "text": "268\n7\nNumerical Methods for Stochastic Molecular Dynamics\nIntegrating from t to t C h and multiplying by exp.\u0003\nt/, we arrive at the solution\np.t C h/ D e\u0002\nhp.t/ C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Z;\n(7.3)\nwhere Z is a vector of independent, standard normal random variables. Alterna-\ntively, we may write this as a discrete iteration in terms of a random map:\npnC1 D e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn;\nwith normally distributed R. For later purposes, we will think of this update as acting\non both q and p, leaving q unchanged, i.e.\n.qnC1; pnC1/ D .qn; e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn/:\nThe Fokker-Planck operator for the OU system (7.2) can be computed directly as\nL\u0004\nO\b.q; p/ D \nrp \u0002 .p\b/ C \nkBTrp \u0002 Mrp\b:\nThe Ornstein-Uhlenbeck process models the momentum of a Brownian particle,\nand in deriving it we thought of \n as being associated to the collisional frequency\nwith the particles of the bath. Alternatively, if we ignore the physical origin of this\nparameter, we can think of \n as an arbitrary coefﬁcient; the sampling of the invariant\nmeasure does not depend on this choice. Thus we have a family of sampling\niterations for the Gaussian distribution, deﬁned for different choices of \n.\n7.3.1\nSplitting Methods for Langevin Dynamics\nWe will now consider a family of iterations for molecular systems which are con-\nstructed from simple building blocks based on the splitting of an SDE, speciﬁcally\nLangevin dynamics:\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \npdt C\np\n2\nkBTM1=2dW:\n(7.4)\nJust as in the deterministic setting (for Newton’s equations of motion) we construct\nsuch splitting methods by way of an additive decomposition of the vector ﬁeld,\nwhere the differential equations corresponding to any individual piece can be solved\nexactly. Methods are built from a sequence of updates corresponding to an exact\nsolve of each piece. By “exact solve” we here mean the construction of a method of\nexactly sampling the distribution generated by the corresponding component. The\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "partial为真实单坐标导数；给出前向表达式与后向生成元在紧支撑C²测试函数上的伴随恒等式。",
    "仅p变量，q是固定参数；未声称已构造OU Markov半群的强生成元域。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.coordDerivative",
  "lean_declarations": [
    "MD.Ch07.coordDerivative",
    "MD.Ch07.ouForward",
    "MD.Ch07.ouBackward",
    "MD.Ch07.ouForward_adjoint"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def coordDerivative (f : V n → ℝ) (x : V n) (i : Fin n) : ℝ :=
  deriv (fun z ↦ f (Function.update x i z)) (x i)

def ouForward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  γ * (∑ i, coordDerivative (fun x ↦ x i*f x) p i) +
    γ*θ * ∑ i, m i * coordDerivative (fun x ↦ coordDerivative f x i) p i

def ouBackward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  -γ * (∑ i, p i * coordDerivative f p i) +
    γ*θ * ∑ i, m i * coordDerivative (fun x ↦ coordDerivative f x i) p i

theorem ouForward_adjoint (m : V n) (γ θ : ℝ) (f g : V n → ℝ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) :
    (∫ p, f p * ouBackward m γ θ g p) = ∫ p, ouForward m γ θ f p * g p := by
  sorry
```

## MD-7.3-OUGaussianInvariant
```json
{
  "source_id": "MD-7.3-OUGaussianInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3",
  "printed_page": "268",
  "pdf_page": "289",
  "statement_latex": "Alternatively, if we ignore the physical origin of this parameter, we can think of $\\gamma$ as an arbitrary coefficient; the sampling of the invariant measure does not depend on this choice. Thus we have a family of sampling iterations for the Gaussian distribution, defined for different choices of $\\gamma$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 289,
      "printed_page": 268,
      "text": "268\n7\nNumerical Methods for Stochastic Molecular Dynamics\nIntegrating from t to t C h and multiplying by exp.\u0003\nt/, we arrive at the solution\np.t C h/ D e\u0002\nhp.t/ C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Z;\n(7.3)\nwhere Z is a vector of independent, standard normal random variables. Alterna-\ntively, we may write this as a discrete iteration in terms of a random map:\npnC1 D e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn;\nwith normally distributed R. For later purposes, we will think of this update as acting\non both q and p, leaving q unchanged, i.e.\n.qnC1; pnC1/ D .qn; e\u0002\nhpn C\np\nkBT.1 \u0003 e\u00022\nh/M1=2Rn/:\nThe Fokker-Planck operator for the OU system (7.2) can be computed directly as\nL\u0004\nO\b.q; p/ D \nrp \u0002 .p\b/ C \nkBTrp \u0002 Mrp\b:\nThe Ornstein-Uhlenbeck process models the momentum of a Brownian particle,\nand in deriving it we thought of \n as being associated to the collisional frequency\nwith the particles of the bath. Alternatively, if we ignore the physical origin of this\nparameter, we can think of \n as an arbitrary coefﬁcient; the sampling of the invariant\nmeasure does not depend on this choice. Thus we have a family of sampling\niterations for the Gaussian distribution, deﬁned for different choices of \n.\n7.3.1\nSplitting Methods for Langevin Dynamics\nWe will now consider a family of iterations for molecular systems which are con-\nstructed from simple building blocks based on the splitting of an SDE, speciﬁcally\nLangevin dynamics:\ndq D M\u00021pdt;\ndp D \u0003rU.q/dt \u0003 \npdt C\np\n2\nkBTM1=2dW:\n(7.4)\nJust as in the deterministic setting (for Newton’s equations of motion) we construct\nsuch splitting methods by way of an additive decomposition of the vector ﬁeld,\nwhere the differential equations corresponding to any individual piece can be solved\nexactly. Methods are built from a sequence of updates corresponding to an exact\nsolve of each piece. By “exact solve” we here mean the construction of a method of\nexactly sampling the distribution generated by the corresponding component. The\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "γ=0允许恒等更新，仍保留Gaussian不变性；不把此时的不变性说成遍历采样收敛。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.ouGaussianInvariant",
  "lean_declarations": [
    "MD.Ch07.ouGaussianInvariant"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem ouGaussianInvariant (m : V n) (γ θ h : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : 0 ≤ γ) (hθ : 0 < θ) (hh : 0 ≤ h) :
    Measure.map (fun x : V n × V n ↦ ouMomentum m γ θ h x.1 x.2)
      ((Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩)).prod
        (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) =
      Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩) := by
  sorry
```
