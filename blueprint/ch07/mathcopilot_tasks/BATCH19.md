# BATCH19 第7章原文与陈述审校

## MD-7.13-ExactFastGaussianLaw
```json
{
  "source_id": "MD-7.13-ExactFastGaussianLaw",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.13",
  "printed_page": "323–324",
  "pdf_page": "344–345",
  "statement_latex": "Writing $F=\\begin{bmatrix}0&1\\\\-\\Omega^2&-\\gamma\\end{bmatrix}$, we can write down the solution to the fast dynamics as\n\\[\\binom{q(t)}{p(t)}=\\exp(Ft)\\binom{q(0)}{p(0)}+B_tR,\\]\nwhere $R$ is a column vector of two i.i.d. random normal numbers distributed as $\\mathcal N(0,1)$, and\n\\[B_tB_t^T=\\frac{2\\gamma}\\beta\\int_0^t\\exp(F(t-s))\\begin{bmatrix}0&0\\\\0&1\\end{bmatrix}\\exp(F^T(t-s))ds.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 344,
      "printed_page": 323,
      "text": "7.13\nMultiple Timestepping\n323\n7.13\nMultiple Timestepping\nRecall the r-RESPA multiple timestepping scheme introduced in Sect. 4.2, designed\nto propagate systems which have a fast highly oscillatory motion, as well as a slower\nlong-ranged force term. Splitting the potential energy function into fast and slow\ncomponents in the deterministic setting provided only a small gain in the stability\nthreshold, as we encountered linear resonance phenomena at step sizes that were\ninteger multiples of half a period. In systems where the timescale gap is very\nlarge, the r-RESPA scheme does not give signiﬁcant improvement, with the stability\nthreshold scaling identically to the Symplectic Euler method.\nOur hope would be that using Langevin dynamics to add stochasticity would\ndisrupt resonance effects and permit larger usable timesteps. While some consider-\nable efﬁciency improvements have been demonstrated using multiple timestepping\nmethods for Langevin dynamics with constraints [118], we shall investigate the\nsimpler fast/slow splitting demonstrated in previous chapters.\nWe consider propagating a system with Hamiltonian\nH.q; p/ D p2=2 C U.q/;\nU.q/ D UF.q/ C US.q/;\nwhere q; p 2 R and US and UF denote the slow and fast components of the\npotential energy respectively. For the purposes of analysis, we shall model these\nwith harmonic potentials, with\nUS.q/ D q2=2;\nUF.q/ D ˝2q2=2;\n(7.47)\nwhere ˝ \n 1. The question we shall be interested in is whether using Langevin\ndynamics with a multiple timestepping algorithm gives us any extra stability\ncompared to the deterministic case. Let us consider splitting the dynamics into\n\u0002dq\ndp\n\u0003\nD\n\u0002\np dt\n\u0003˝2q dt \u0003 \np dt C\np\n2\n=ˇ dW\n\u0003\n„\nƒ‚\n…\nFast\nC\n\u0002\n0\n\u0003q dt\n\u0003\n„ ƒ‚ …\nSlow\n;\n(7.48)\nand proceed as in the case of the r-RESPA scheme. As before, we consider the case\nwhere we are able to solve the fast part exactly (in practice we use several small\ntimesteps as the fast parts are considered computationally “cheap”). Writing\nF D\n\u0002\n0\n1\n\u0003˝2 \u0003\n\u0003\n;\nwe can write down the solution to the fast dynamics as\n\u0002q.t/\np.t/\n\u0003\nD exp.Ft/\n\u0002 q.0/\np.0/\n\u0003\nC BtR;\n"
    },
    {
      "pdf_page": 345,
      "printed_page": 324,
      "text": "324\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere R is a column vector of two i.i.d. random normal numbers distributed as\nN.0; 1/, and\nBtBT\nt D 2\nˇ\nt\nZ\n0\nexp.F.t \u0003 s//\n\u0002 0 0\n0 1\n\u0003\nexp.FT.t \u0003 s//ds:\nThe solution to the slow part of our splitting is just\n\u0002q.t/\np.t/\n\u0003\nD\n\u0002 1 0\n\u0003t 1\n\u0003 \u0002 q.0/\np.0/\n\u0003\n:\nThus for a method taking one step of the fast system followed by a step of the\nslow system, using ﬁxed step size h > 0, we can write the update scheme for z D\nŒq; p\tT as\nznC1 D Xzn C YRn;\nfor\nX D\n\u0002 1 0\n\u0003h 1\n\u0003\nexp.hF/;\nY D\n\u0002 1 0\n\u0003h 1\n\u0003\nBh:\nThe stability of the method therefore depends solely on the spectral radius of the\nmatrix X. Denoting \u000f D\np\n\n2 \u0003 4˝2, then we compute\ndet.X/ D e\u0002\nh;\ntr.X/ D \u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2;\ngiving a stability condition\nˇˇˇˇ\n\u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2\nˇˇˇˇ \t 1 C e\u0002\nh:\nMultiplying by e\nh=2 gives\nˇˇˇˇcosh\n\b\u000fh\n2\n\t\nC h\n\u000f sinh\n\b\n\u0003\u000fh\n2\n\tˇˇˇˇ \t cosh\n\b\nh\n2\n\t\n;\nwhich reduces to the deterministic stability condition as expected in the limit \n D 0.\nFor \n > 0, we can simplify to\nˇˇˇˇˇˇ\ncosh\n\b\u000fh\n2 \u0003 atanh\n\bh\n\u000f\n\t\t s\n1 \u0003 h2\n\u000f2\nˇˇˇˇˇˇ\n\t cosh\n\b\nh\n2\n\t\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "陈述真实过程的转移分布，不将强解等于一组新独立R假设成结论。Bt只需给定平方根因子；正半定矩阵平方根存在性未另证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.fastExponential",
  "lean_declarations": [
    "MD.Ch07.fastExponential",
    "MD.Ch07.fastCovariance",
    "MD.Ch07.exactFastGaussianLaw"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def fastExponential (Ω γ t : ℝ) : Mat2 := NormedSpace.exp (t • fastMatrix Ω γ)
def fastCovariance (Ω γ β t : ℝ) : Mat2 := fun i j ↦ 2*γ/β*∫ s in (0 : ℝ)..t,
  (fastExponential Ω γ (t-s)* (!![0,0;0,1] : Mat2)*(fastExponential Ω γ (t-s))ᵀ) i j
theorem exactFastGaussianLaw (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β t : ℝ) (x0 : Phase 1) (B : Mat2)
    (hX : fastLangevin P W X frequency γ β x0) (ht : 0 ≤ t)
    (hB : B*Bᵀ = fastCovariance frequency γ β t) :
    HasLaw (fun sample ↦ (![ (X t sample).1 0, (X t sample).2 0] : Fin 2 → ℝ))
      (Measure.map (fun R : Fin 2 → ℝ ↦
        fastExponential frequency γ t *ᵥ (![x0.1 0,x0.2 0] : Fin 2 → ℝ)+B*ᵥ R)
        (Measure.pi (fun _ : Fin 2 ↦ gaussianReal 0 1))) P := by
  sorry
```

## MD-7.13-MultipleTimestepUpdate
```json
{
  "source_id": "MD-7.13-MultipleTimestepUpdate",
  "kind": "definition",
  "label": null,
  "section": "7.13",
  "printed_page": "324",
  "pdf_page": "345",
  "statement_latex": "The solution to the slow part of our splitting is just\n\\[\\binom{q(t)}{p(t)}=\\begin{bmatrix}1&0\\\\-t&1\\end{bmatrix}\\binom{q(0)}{p(0)}.\\]\nFor a method taking one step of the fast system followed by a step of the slow system, using fixed step size $h>0$, we can write the update scheme for $z=[q,p]^T$ as\n\\[z_{n+1}=Xz_n+YR_n,\\qquad X=\\begin{bmatrix}1&0\\\\-h&1\\end{bmatrix}\\exp(hF),\\quad Y=\\begin{bmatrix}1&0\\\\-h&1\\end{bmatrix}B_h.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 345,
      "printed_page": 324,
      "text": "324\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere R is a column vector of two i.i.d. random normal numbers distributed as\nN.0; 1/, and\nBtBT\nt D 2\nˇ\nt\nZ\n0\nexp.F.t \u0003 s//\n\u0002 0 0\n0 1\n\u0003\nexp.FT.t \u0003 s//ds:\nThe solution to the slow part of our splitting is just\n\u0002q.t/\np.t/\n\u0003\nD\n\u0002 1 0\n\u0003t 1\n\u0003 \u0002 q.0/\np.0/\n\u0003\n:\nThus for a method taking one step of the fast system followed by a step of the\nslow system, using ﬁxed step size h > 0, we can write the update scheme for z D\nŒq; p\tT as\nznC1 D Xzn C YRn;\nfor\nX D\n\u0002 1 0\n\u0003h 1\n\u0003\nexp.hF/;\nY D\n\u0002 1 0\n\u0003h 1\n\u0003\nBh:\nThe stability of the method therefore depends solely on the spectral radius of the\nmatrix X. Denoting \u000f D\np\n\n2 \u0003 4˝2, then we compute\ndet.X/ D e\u0002\nh;\ntr.X/ D \u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2;\ngiving a stability condition\nˇˇˇˇ\n\u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2\nˇˇˇˇ \t 1 C e\u0002\nh:\nMultiplying by e\nh=2 gives\nˇˇˇˇcosh\n\b\u000fh\n2\n\t\nC h\n\u000f sinh\n\b\n\u0003\u000fh\n2\n\tˇˇˇˇ \t cosh\n\b\nh\n2\n\t\n;\nwhich reduces to the deterministic stability condition as expected in the limit \n D 0.\nFor \n > 0, we can simplify to\nˇˇˇˇˇˇ\ncosh\n\b\u000fh\n2 \u0003 atanh\n\bh\n\u000f\n\t\t s\n1 \u0003 h2\n\u000f2\nˇˇˇˇˇˇ\n\t cosh\n\b\nh\n2\n\t\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "Rn为每步独立标准二维Gaussian；稳定分布分析仍要求真实独立序列及有限协方差，不能只以更新定义宣称存在平稳解。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.multipleX",
  "lean_declarations": [
    "MD.Ch07.multipleX",
    "MD.Ch07.multipleY",
    "MD.Ch07.multipleStep",
    "MD.Ch07.multipleStep_composition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def multipleX (Ω γ h : ℝ) : Mat2 := slowMatrix h*fastExponential Ω γ h
def multipleY (h : ℝ) (B : Mat2) : Mat2 := slowMatrix h*B
def multipleStep (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) : Fin 2 → ℝ :=
  multipleX Ω γ h *ᵥ z+multipleY h B *ᵥ R
theorem multipleStep_composition (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) :
    multipleStep Ω γ h B R z = slowMatrix h *ᵥ (fastExponential Ω γ h *ᵥ z+B*ᵥ R) := by
  simp [multipleStep,multipleX,multipleY,Matrix.mulVec_add,Matrix.mulVec_mulVec]
```

## MD-7.13-DeterminantTrace
```json
{
  "source_id": "MD-7.13-DeterminantTrace",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.13",
  "printed_page": "324",
  "pdf_page": "345",
  "statement_latex": "Denoting $\\eta=\\sqrt{\\gamma^2-4\\Omega^2}$, then we compute\n\\[\\det(X)=e^{-\\gamma h},\\qquad\n\\operatorname{tr}(X)=\\frac{\\eta-h}{\\eta}e^{(\\eta-\\gamma)h/2}+\\frac{\\eta+h}{\\eta}e^{(-\\eta-\\gamma)h/2}.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 345,
      "printed_page": 324,
      "text": "324\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere R is a column vector of two i.i.d. random normal numbers distributed as\nN.0; 1/, and\nBtBT\nt D 2\nˇ\nt\nZ\n0\nexp.F.t \u0003 s//\n\u0002 0 0\n0 1\n\u0003\nexp.FT.t \u0003 s//ds:\nThe solution to the slow part of our splitting is just\n\u0002q.t/\np.t/\n\u0003\nD\n\u0002 1 0\n\u0003t 1\n\u0003 \u0002 q.0/\np.0/\n\u0003\n:\nThus for a method taking one step of the fast system followed by a step of the\nslow system, using ﬁxed step size h > 0, we can write the update scheme for z D\nŒq; p\tT as\nznC1 D Xzn C YRn;\nfor\nX D\n\u0002 1 0\n\u0003h 1\n\u0003\nexp.hF/;\nY D\n\u0002 1 0\n\u0003h 1\n\u0003\nBh:\nThe stability of the method therefore depends solely on the spectral radius of the\nmatrix X. Denoting \u000f D\np\n\n2 \u0003 4˝2, then we compute\ndet.X/ D e\u0002\nh;\ntr.X/ D \u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2;\ngiving a stability condition\nˇˇˇˇ\n\u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2\nˇˇˇˇ \t 1 C e\u0002\nh:\nMultiplying by e\nh=2 gives\nˇˇˇˇcosh\n\b\u000fh\n2\n\t\nC h\n\u000f sinh\n\b\n\u0003\u000fh\n2\n\tˇˇˇˇ \t cosh\n\b\nh\n2\n\t\n;\nwhich reduces to the deterministic stability condition as expected in the limit \n D 0.\nFor \n > 0, we can simplify to\nˇˇˇˇˇˇ\ncosh\n\b\u000fh\n2 \u0003 atanh\n\bh\n\u000f\n\t\t s\n1 \u0003 h2\n\u000f2\nˇˇˇˇˇˇ\n\t cosh\n\b\nh\n2\n\t\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "η允许纯虚数；显式排除临界η=0，避免除零假公式。临界阻尼应取连续极限，另列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.traceFormula",
  "lean_declarations": [
    "MD.Ch07.traceFormula",
    "MD.Ch07.determinantTrace"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def traceFormula (γ h : ℝ) (η : ℂ) : ℂ :=
  (η-(h : ℂ))/η*Complex.exp ((η-(γ : ℂ))*(h : ℂ)/2)+
  (η+(h : ℂ))/η*Complex.exp ((-η-(γ : ℂ))*(h : ℂ)/2)
theorem determinantTrace (Ω γ h : ℝ) (η : ℂ) (hη : η^2 = (γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    Matrix.det (multipleX Ω γ h) = Real.exp (-γ*h) ∧
    ((Matrix.trace (multipleX Ω γ h) : ℝ) : ℂ) = traceFormula γ h η := by
  sorry
```

## MD-7.13-SpectralRadiusStability
```json
{
  "source_id": "MD-7.13-SpectralRadiusStability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.13",
  "printed_page": "324",
  "pdf_page": "345",
  "statement_latex": "The stability of the method therefore depends solely on the spectral radius of the matrix $X$. This gives a stability condition\n\\[\\left|\\frac{\\eta-h}{\\eta}e^{(\\eta-\\gamma)h/2}+\\frac{\\eta+h}{\\eta}e^{(-\\eta-\\gamma)h/2}\\right|\\le1+e^{-\\gamma h}.\\]\nMultiplying by $e^{\\gamma h/2}$ gives\n\\[|\\cosh(\\eta h/2)+(h/\\eta)\\sinh(-\\eta h/2)|\\le\\cosh(\\gamma h/2).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 345,
      "printed_page": 324,
      "text": "324\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere R is a column vector of two i.i.d. random normal numbers distributed as\nN.0; 1/, and\nBtBT\nt D 2\nˇ\nt\nZ\n0\nexp.F.t \u0003 s//\n\u0002 0 0\n0 1\n\u0003\nexp.FT.t \u0003 s//ds:\nThe solution to the slow part of our splitting is just\n\u0002q.t/\np.t/\n\u0003\nD\n\u0002 1 0\n\u0003t 1\n\u0003 \u0002 q.0/\np.0/\n\u0003\n:\nThus for a method taking one step of the fast system followed by a step of the\nslow system, using ﬁxed step size h > 0, we can write the update scheme for z D\nŒq; p\tT as\nznC1 D Xzn C YRn;\nfor\nX D\n\u0002 1 0\n\u0003h 1\n\u0003\nexp.hF/;\nY D\n\u0002 1 0\n\u0003h 1\n\u0003\nBh:\nThe stability of the method therefore depends solely on the spectral radius of the\nmatrix X. Denoting \u000f D\np\n\n2 \u0003 4˝2, then we compute\ndet.X/ D e\u0002\nh;\ntr.X/ D \u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2;\ngiving a stability condition\nˇˇˇˇ\n\u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2\nˇˇˇˇ \t 1 C e\u0002\nh:\nMultiplying by e\nh=2 gives\nˇˇˇˇcosh\n\b\u000fh\n2\n\t\nC h\n\u000f sinh\n\b\n\u0003\u000fh\n2\n\tˇˇˇˇ \t cosh\n\b\nh\n2\n\t\n;\nwhich reduces to the deterministic stability condition as expected in the limit \n D 0.\nFor \n > 0, we can simplify to\nˇˇˇˇˇˇ\ncosh\n\b\u000fh\n2 \u0003 atanh\n\bh\n\u000f\n\t\t s\n1 \u0003 h2\n\u000f2\nˇˇˇˇˇˇ\n\t cosh\n\b\nh\n2\n\t\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述谱半径≤1的确定性边界资格；有非退化随机驱动时平稳二阶矩一般要求严格谱半径<1，等号并不自动给随机长期稳定。",
    "正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.characteristicUnitDisk",
  "lean_declarations": [
    "MD.Ch07.characteristicUnitDisk",
    "MD.Ch07.spectralRadiusStability",
    "MD.Ch07.hyperbolicStability"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def characteristicUnitDisk (X : Mat2) : Prop :=
  ∀ z : ℂ, z^2-((Matrix.trace X : ℝ) : ℂ)*z+((Matrix.det X : ℝ) : ℂ) = 0 → ‖z‖ ≤ 1
theorem spectralRadiusStability (X : Mat2) (hd : 0 < Matrix.det X) (hd1 : Matrix.det X < 1) :
    characteristicUnitDisk X ↔ |Matrix.trace X| ≤ 1+Matrix.det X := by
  sorry
def hyperbolicStability (γ h : ℝ) (η : ℂ) : Prop :=
  ‖Complex.cosh (η*(h : ℂ)/2)+(h : ℂ)/η*Complex.sinh (-η*(h : ℂ)/2)‖ ≤ Real.cosh (γ*h/2)
```

## MD-7.13-HyperbolicPhaseTransform
```json
{
  "source_id": "MD-7.13-HyperbolicPhaseTransform",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.13",
  "printed_page": "324",
  "pdf_page": "345",
  "statement_latex": "For $\\gamma>0$, we can simplify to\n\\[\\left|\\cosh\\left(\\frac{\\eta h}{2}-\\operatorname{atanh}\\left(\\frac h\\eta\\right)\\right)\\sqrt{1-\\frac{h^2}{\\eta^2}}\\right|\\le\\cosh(\\gamma h/2).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 345,
      "printed_page": 324,
      "text": "324\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwhere R is a column vector of two i.i.d. random normal numbers distributed as\nN.0; 1/, and\nBtBT\nt D 2\nˇ\nt\nZ\n0\nexp.F.t \u0003 s//\n\u0002 0 0\n0 1\n\u0003\nexp.FT.t \u0003 s//ds:\nThe solution to the slow part of our splitting is just\n\u0002q.t/\np.t/\n\u0003\nD\n\u0002 1 0\n\u0003t 1\n\u0003 \u0002 q.0/\np.0/\n\u0003\n:\nThus for a method taking one step of the fast system followed by a step of the\nslow system, using ﬁxed step size h > 0, we can write the update scheme for z D\nŒq; p\tT as\nznC1 D Xzn C YRn;\nfor\nX D\n\u0002 1 0\n\u0003h 1\n\u0003\nexp.hF/;\nY D\n\u0002 1 0\n\u0003h 1\n\u0003\nBh:\nThe stability of the method therefore depends solely on the spectral radius of the\nmatrix X. Denoting \u000f D\np\n\n2 \u0003 4˝2, then we compute\ndet.X/ D e\u0002\nh;\ntr.X/ D \u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2;\ngiving a stability condition\nˇˇˇˇ\n\u000f \u0003 h\n\u000f\ne.\u000f\u0002\n/h=2 C \u000f C h\n\u000f\ne.\u0002\u000f\u0002\n/h=2\nˇˇˇˇ \t 1 C e\u0002\nh:\nMultiplying by e\nh=2 gives\nˇˇˇˇcosh\n\b\u000fh\n2\n\t\nC h\n\u000f sinh\n\b\n\u0003\u000fh\n2\n\tˇˇˇˇ \t cosh\n\b\nh\n2\n\t\n;\nwhich reduces to the deterministic stability condition as expected in the limit \n D 0.\nFor \n > 0, we can simplify to\nˇˇˇˇˇˇ\ncosh\n\b\u000fh\n2 \u0003 atanh\n\bh\n\u000f\n\t\t s\n1 \u0003 h2\n\u000f2\nˇˇˇˇˇˇ\n\t cosh\n\b\nh\n2\n\t\n:\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "实η版本必须补|h/η|<1，γ>0本身不足；复η需选择sqrt/artanh分支，原文未说明。只覆盖明确实域上的等式，不把所有γ>0都纳入。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.hyperbolicPhase",
  "lean_declarations": [
    "MD.Ch07.hyperbolicPhase",
    "MD.Ch07.hyperbolicPhase_identity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def hyperbolicPhase (η h : ℝ) : ℝ :=
  Real.cosh (η*h/2-Real.artanh (h/η))*Real.sqrt (1-h^2/η^2)
theorem hyperbolicPhase_identity (η h : ℝ) (hη : η ≠ 0) (hr : |h/η| < 1) :
    hyperbolicPhase η h = Real.cosh (η*h/2)-h/η*Real.sinh (η*h/2) := by
  have hh : h/η ∈ Set.Ioo (-1 : ℝ) 1 := abs_lt.mp hr
  have hs : Real.sqrt (1-(h/η)^2) ≠ 0 := by
    apply ne_of_gt
    apply Real.sqrt_pos.2
    have hsq : (h/η)^2 < 1 := (sq_lt_one_iff_abs_lt_one (h/η)).2 hr
    linarith
  simp only [hyperbolicPhase,Real.cosh_sub,Real.cosh_artanh hh,Real.sinh_artanh hh]
  rw [← div_pow]
  calc
    _ = (Real.cosh (η*h/2)-(h/η)*Real.sinh (η*h/2))/Real.sqrt (1-(h/η)^2)*Real.sqrt (1-(h/η)^2) := by ring
    _ = _ := div_mul_cancel₀ _ hs
```

## MD-7.13-UnderdampedPhasePrinted
```json
{
  "source_id": "MD-7.13-UnderdampedPhasePrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.13",
  "printed_page": "325",
  "pdf_page": "346",
  "statement_latex": "We consider the case with $\\gamma\\ll\\Omega$, allowing us to write $\\eta=i\\widehat\\eta$ for $\\widehat\\eta\\in\\mathbb R$, and\n\\[\\left|\\cos\\left(\\frac{\\widehat\\eta h}{2}-\\operatorname{atanh}\\left(\\frac h{\\widehat\\eta}\\right)\\right)\\sqrt{1+\\frac{h^2}{\\widehat\\eta^2}}\\right|\\le\\cosh(\\gamma h/2).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 346,
      "printed_page": 325,
      "text": "7.13\nMultiple Timestepping\n325\nWe consider the case with \n \f ˝, allowing us to write \u000f D iO\u000f for O\u000f 2 R, and\nˇˇˇˇˇˇ\ncos\n\b O\u000fh\n2 \u0003 atanh\n\bh\nO\u000f\n\t\t s\n1 C h2\nO\u000f2\nˇˇˇˇˇˇ\n\t cosh\n\b\nh\n2\n\t\n:\nThe term on the left hand side of the inequality is oscillatory in h, while the term on\nthe right hand side uniformly grows with step size. This implies that for any suitable\n\n > 0, we can ﬁnd small pocket regions of the step size where the left hand side is\nsufﬁciently minimized in order to give stability. However, just as in the deterministic\ncase, these island stability regions are difﬁcult to predict the location of in a more\ngeneral system.\nThe oscillatory cosine term is bounded between ˙1, implying that we have\nstability for all step sizes provided the condition\ns\n1 C h2\nO\u000f2 \t cosh\n\b\nh\n2\n\t\n;\n(7.49)\nholds. We expect there to exist stability regions for smaller values of the friction\nwhere this condition is violated, but these will be interposed between unstable\nregions coming from the oscillatory term. We have guaranteed stability where (7.49)\nholds, which we can simplify to\nh\np\n4˝2 \u0003 \n2 \t sinh\n\b\nh\n2\n\t\n:\nFor a ﬁxed value of the friction, if we increase the step size the right hand side will\ngrow exponentially compared to the linear growth on the left hand side, so it would\nseem that for large h we actually need a smaller friction in order to be stable. Hence\nthe minimum required friction for stability can be found by considering the case of\nsmall timestep. This gives a bound\n1\np\n4˝2 \u0003 \n2 \t \n2 ;\nwhich gives a stability condition for all step sizes h as long as\n\n \b ˝\nq\n2 \u0003 2\np\n1 \u0003 ˝\u00024 \b\np\n2=˝:\nTherefore we expect that the minimum friction value required for stability for all\ntimesteps h > 0, scales with the value of inverse ˝. Unlike the deterministic case,\nwe are able to remove linear resonance effects with a sufﬁciently large friction term.\nWe illustrate this numerically in Fig. 7.13, by applying the splitting scheme (7.48)\nusing various timesteps and frictions. Each gridpoint marks an independent simula-\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文版与修正版分别定义，原文版不证明；直接用幅相恒等式绕过复函数分支。η̂=√(4Ω²-γ²)>0需要明确欠阻尼条件。"
  ],
  "issues": [
    "已目视核对PDF346／印刷325：从η=iη̂化为实余弦时应使用+arctan(h/η̂)，所印-atanh(h/η̂)的函数与符号均不符。修正版从cos(a)-r sin(a)的标准幅相恒等式得到。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.underdampedPhasePrinted",
  "lean_declarations": [
    "MD.Ch07.underdampedPhasePrinted",
    "MD.Ch07.underdampedPhasePrinted_corrected",
    "MD.Ch07.underdampedPhase_identity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def underdampedPhasePrinted (η h : ℝ) : ℝ :=
  Real.cos (η*h/2-Real.artanh (h/η))*Real.sqrt (1+h^2/η^2)
def underdampedPhasePrinted_corrected (η h : ℝ) : ℝ :=
  Real.sqrt (1+(h/η)^2)*Real.cos (η*h/2+Real.arctan (h/η))
theorem underdampedPhase_identity (a r : ℝ) :
    Real.cos a-r*Real.sin a = Real.sqrt (1+r^2)*Real.cos (a+Real.arctan r) := by
  rw [Real.cos_add,Real.cos_arctan,Real.sin_arctan]
  have hs : Real.sqrt (1+r^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by positivity))
  field_simp
  <;> ring
```
