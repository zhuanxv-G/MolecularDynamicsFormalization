# BATCH06 第7章原文与陈述审校

## MD-7.4-HarmonicHamiltonian
```json
{
  "source_id": "MD-7.4-HarmonicHamiltonian",
  "kind": "definition",
  "label": "(7.6)",
  "section": "7.4",
  "printed_page": "273",
  "pdf_page": "294",
  "statement_latex": "Recall that the one-dimensional harmonic oscillator with spring constant $\\Omega^2$ has potential energy function $U(q)=\\Omega^2q^2/2$, with Hamiltonian\n\\[H(q,p)=\\frac{p^2}{2m}+\\frac{\\Omega^2q^2}{2},\\tag{7.6}\\]\nwhere $(q,p)\\in\\mathbb R^2$ represent a particle's position and momentum, and $m>0$ is the particle's mass.",
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
    "正m、正θ、Ω≠0时为可归一化的正则谐振子Gibbs分布；θ=k_BT。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.harmonicHamiltonian",
  "lean_declarations": [
    "MD.Ch07.harmonicHamiltonian",
    "MD.Ch07.harmonicLaw"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def harmonicHamiltonian (m Ω : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/(2*m)+Ω^2*x.1^2/2
def harmonicLaw (m Ω θ : ℝ) : Measure (ℝ × ℝ) :=
  (gaussianReal 0 (Real.toNNReal (θ/Ω^2))).prod (gaussianReal 0 (Real.toNNReal (θ*m)))
```

## MD-7.4-HarmonicMoments
```json
{
  "source_id": "MD-7.4-HarmonicMoments",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4",
  "printed_page": "273–274",
  "pdf_page": "294–295",
  "statement_latex": "In this setting, the canonical distribution $\\rho_\\beta$ is the product of two Gaussian distributions, where we have invariant (stationary) averages\n\\[\\langle q\\rangle=\\langle p\\rangle=0,\\qquad\\langle\\Omega^2q^2\\rangle=\\langle p^2/m\\rangle=k_BT,\\qquad\\langle qp\\rangle=0.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 294,
      "printed_page": 273,
      "text": "7.4\nError Results for Harmonic Problems\n273\nsampling will become inconsistent: the force will be dominated by the stochastic\nterm, leaving the dynamics to evolve as a random walk.\nSimilar behavior is exhibited using the splitting strategy in (7.5), when interpos-\ning the kick term B between two O steps, such as in the schemes \u0002AOBOA\u0003 or\n\u0002BOAOB\u0003. By avoiding “OBO” updates, we can derive schemes that are consistent\neven at inﬁnite friction (the \u0002BAOAB\u0003 and \u0002ABOBA\u0003 schemes are examples of such\nmethods).\nThe Brünger-Brooks-Karplus (BBK) Langevin integrator [55] is one of the most\npopular and widely-implemented schemes.\nBrünger-Brooks-Karplus (BBK)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2R0\nn\t=.1 C h\n=2/\nOften R0 is chosen such that R0\nn D RnC1, so the random vector would be reused at\nthe start of the following timestep, however there are many variants of this scheme\nthat incorporate the redraw of random numbers differently. In other variants of BBK\nwe take R0\nn D Rn, reusing the random number within the step. We may also consider\nindependent R0\nn and Rn, however when using independent noise processes we must\nmodify the algorithm as it will not sample canonically (see Exercise 1).\n7.4\nError Results for Harmonic Problems\nFor general systems it can be very challenging to give a complete description of\nthe weak error in averages computed from trajectories evolved through a Langevin\ndynamics discretization scheme. However, using a linear model problem signiﬁ-\ncantly reduces the complexity, while using small dimensional test problems allows\nus to effectively annihilate sampling error in demonstrative numerical experiments.\nAs such, we return now to the harmonic oscillator, which as well as being the\nsimplest molecular model is also one of the most relevant for molecular dynamics\napplications, as many issues of stability and timestep in molecular dynamics\nsimulations arise due to harmonic potentials used to model covalent bonds (such\nas in crystalline solids and biomolecules). The canonical distributions of position\nand momentum are also of a simple form (Gaussians), making such oscillators\nparticularly amenable to analysis.\nRecall that the one-dimensional harmonic oscillator with spring constant ˝2 has\npotential energy function U.q/ D ˝2q2=2, with Hamiltonian\nH.q; p/ D p2\n2m C ˝2q2\n2\n;\n(7.6)\nwhere .q; p/ 2 R2 represent a particle’s position and momentum, and m > 0 is the\nparticle’s mass. In this setting, the canonical distribution \u0005ˇ is the product of two\n"
    },
    {
      "pdf_page": 295,
      "printed_page": 274,
      "text": "274\n7\nNumerical Methods for Stochastic Molecular Dynamics\nGaussian distributions, where we have invariant (stationary) averages\nhqi D hpi D 0;\nand\nh˝2q2i D hp2=mi D kBT;\nhqpi D 0:\nWe expect that the discretization schemes that we employ will introduce errors in\nthe computed values of the invariant (long-time) averages. In the large-time limit,\nthese averages will converge towards their invariant value, which we can ﬁnd using\nthe procedure outlined in [59].\nFor the harmonic oscillator, the force \u0003U0.q/ will be linear, and therefore we\nwould expect that any update step in an algorithm will be linear in the state variables\nq and p. Thus, denoting the iteration index as a subscript, we may explicitly write\none iteration of a general numerical method for evolving the dynamics as\n\u0002 qnC1\npnC1\n\u0003\nD \f\n\u0002qn\npn\n\u0003\nC \u0006n;\n(7.7)\nwhere \f is a constant matrix that depends on the stepsize h, the friction coefﬁcient\n\n, the particle mass m and the spring constant ˝. Additionally \u0006n is a vector of\nstochastic processes. For example, in the BBK method we can compute directly\nfrom its update scheme that\n\f BBK D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C R0\nn\n\u0007\n3\n5 :\nMore generally, if we deﬁne the components of \f as ij and denote \u0006n D\nŒ\u0006n;1; \u0006n;2\tT we can take products of the update equations deﬁned by (7.7) to obtain\nq2\nnC1 D 2\n11q2\nn C 2\n12p2\nn C \u00062\nn;1 C 2 11 12qnpn C 2 11\u0006n;1qn C 2 12\u0006n;1pn;\n(7.8)\np2\nnC1 D 2\n21q2\nn C 2\n22p2\nn C \u00062\nn;2 C 2 21 22qnpn C 2 21\u0006n;2qn C 2 22\u0006n;2pn;\n(7.9)\nqnC1pnC1 D 11 21q2\nn C 12 22p2\nn C \u0006n;1\u0006n;2 C . 11 22 C 12 21/qnpn\nC . 11\u0006n;2 C 21\u0006n;1/qn C . 22\u0006n;1 C 12\u0006n;2/pn:\n(7.10)\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "harmonicLaw给出实际正态乘积，未把所需各矩值作为假设；与Hamiltonian的密度识别另列覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "实际正态乘积的全部五个矩；其Lebesgue密度等于归一Gibbs权的识别未另作定理。",
  "lean_decl": "MD.Ch07.harmonicMoments",
  "lean_declarations": [
    "MD.Ch07.harmonicMoments"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem harmonicMoments (m Ω θ : ℝ) (hm : 0 < m) (hΩ : Ω ≠ 0) (hθ : 0 < θ) :
    (∫ x, x.1 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, x.2 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, Ω^2*x.1^2 ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.2^2/m ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.1*x.2 ∂harmonicLaw m Ω θ) = 0 := by
  sorry
```

## MD-7.4-LinearIteration
```json
{
  "source_id": "MD-7.4-LinearIteration",
  "kind": "definition",
  "label": "(7.7)",
  "section": "7.4",
  "printed_page": "274",
  "pdf_page": "295",
  "statement_latex": "Thus, denoting the iteration index as a subscript, we may explicitly write one iteration of a general numerical method for evolving the dynamics as\n\\[\\binom{q_{n+1}}{p_{n+1}}=\\Psi\\binom{q_n}{p_n}+\\mu_n,\\tag{7.7}\\]\nwhere $\\Psi$ is a constant matrix that depends on the stepsize $h$, the friction coefficient $\\gamma$, the particle mass $m$ and the spring constant $\\Omega$. Additionally $\\mu_n$ is a vector of stochastic processes.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 295,
      "printed_page": 274,
      "text": "274\n7\nNumerical Methods for Stochastic Molecular Dynamics\nGaussian distributions, where we have invariant (stationary) averages\nhqi D hpi D 0;\nand\nh˝2q2i D hp2=mi D kBT;\nhqpi D 0:\nWe expect that the discretization schemes that we employ will introduce errors in\nthe computed values of the invariant (long-time) averages. In the large-time limit,\nthese averages will converge towards their invariant value, which we can ﬁnd using\nthe procedure outlined in [59].\nFor the harmonic oscillator, the force \u0003U0.q/ will be linear, and therefore we\nwould expect that any update step in an algorithm will be linear in the state variables\nq and p. Thus, denoting the iteration index as a subscript, we may explicitly write\none iteration of a general numerical method for evolving the dynamics as\n\u0002 qnC1\npnC1\n\u0003\nD \f\n\u0002qn\npn\n\u0003\nC \u0006n;\n(7.7)\nwhere \f is a constant matrix that depends on the stepsize h, the friction coefﬁcient\n\n, the particle mass m and the spring constant ˝. Additionally \u0006n is a vector of\nstochastic processes. For example, in the BBK method we can compute directly\nfrom its update scheme that\n\f BBK D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C R0\nn\n\u0007\n3\n5 :\nMore generally, if we deﬁne the components of \f as ij and denote \u0006n D\nŒ\u0006n;1; \u0006n;2\tT we can take products of the update equations deﬁned by (7.7) to obtain\nq2\nnC1 D 2\n11q2\nn C 2\n12p2\nn C \u00062\nn;1 C 2 11 12qnpn C 2 11\u0006n;1qn C 2 12\u0006n;1pn;\n(7.8)\np2\nnC1 D 2\n21q2\nn C 2\n22p2\nn C \u00062\nn;2 C 2 21 22qnpn C 2 21\u0006n;2qn C 2 22\u0006n;2pn;\n(7.9)\nqnC1pnC1 D 11 21q2\nn C 12 22p2\nn C \u0006n;1\u0006n;2 C . 11 22 C 12 21/qnpn\nC . 11\u0006n;2 C 21\u0006n;1/qn C . 22\u0006n;1 C 12\u0006n;2/pn:\n(7.10)\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "具体2×2矩阵用四个真实系数，噪声不假定自动独立；后续陈述分别补独立或相关结构。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.linearUpdate",
  "lean_declarations": [
    "MD.Ch07.linearUpdate",
    "MD.Ch07.momentQ",
    "MD.Ch07.momentP",
    "MD.Ch07.momentQP"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def linearUpdate (a b c d : ℝ) (x noise : ℝ × ℝ) : ℝ × ℝ :=
  (a*x.1+b*x.2+noise.1,c*x.1+d*x.2+noise.2)
def momentQ (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1^2 ∂μ
def momentP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.2^2 ∂μ
def momentQP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1*x.2 ∂μ
```

## MD-7.4-BBKLinearForm
```json
{
  "source_id": "MD-7.4-BBKLinearForm",
  "kind": "definition",
  "label": null,
  "section": "7.4",
  "printed_page": "274",
  "pdf_page": "295",
  "statement_latex": "For example, in the BBK method we can compute directly from its update scheme that\n\\[\\Psi^{\\rm BBK}=\\begin{bmatrix}1-\\frac{h^2\\Omega^2}{2m}&\\frac hm(1-\\frac{\\gamma h}2)\\\\\n\\frac{h\\Omega^2}{2m}\\frac{h^2\\Omega^2-4m}{2+\\gamma h}&\\frac{(2-\\gamma h)(2m-h^2\\Omega^2)}{2m(2+\\gamma h)}\\end{bmatrix},\\]\n\\[\\mu_n^{\\rm BBK}=\\begin{bmatrix}\\sqrt{\\frac{k_BT\\gamma h^3}{2m}}R_n\\\\\n\\frac{\\sqrt{2k_BT\\gamma hm}}{2+\\gamma h}[(1-\\frac{h^2\\Omega^2}{2m})R_n+R'_n]\\end{bmatrix}.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 295,
      "printed_page": 274,
      "text": "274\n7\nNumerical Methods for Stochastic Molecular Dynamics\nGaussian distributions, where we have invariant (stationary) averages\nhqi D hpi D 0;\nand\nh˝2q2i D hp2=mi D kBT;\nhqpi D 0:\nWe expect that the discretization schemes that we employ will introduce errors in\nthe computed values of the invariant (long-time) averages. In the large-time limit,\nthese averages will converge towards their invariant value, which we can ﬁnd using\nthe procedure outlined in [59].\nFor the harmonic oscillator, the force \u0003U0.q/ will be linear, and therefore we\nwould expect that any update step in an algorithm will be linear in the state variables\nq and p. Thus, denoting the iteration index as a subscript, we may explicitly write\none iteration of a general numerical method for evolving the dynamics as\n\u0002 qnC1\npnC1\n\u0003\nD \f\n\u0002qn\npn\n\u0003\nC \u0006n;\n(7.7)\nwhere \f is a constant matrix that depends on the stepsize h, the friction coefﬁcient\n\n, the particle mass m and the spring constant ˝. Additionally \u0006n is a vector of\nstochastic processes. For example, in the BBK method we can compute directly\nfrom its update scheme that\n\f BBK D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C R0\nn\n\u0007\n3\n5 :\nMore generally, if we deﬁne the components of \f as ij and denote \u0006n D\nŒ\u0006n;1; \u0006n;2\tT we can take products of the update equations deﬁned by (7.7) to obtain\nq2\nnC1 D 2\n11q2\nn C 2\n12p2\nn C \u00062\nn;1 C 2 11 12qnpn C 2 11\u0006n;1qn C 2 12\u0006n;1pn;\n(7.8)\np2\nnC1 D 2\n21q2\nn C 2\n22p2\nn C \u00062\nn;2 C 2 21 22qnpn C 2 21\u0006n;2qn C 2 22\u0006n;2pn;\n(7.9)\nqnC1pnC1 D 11 21q2\nn C 12 22p2\nn C \u0006n;1\u0006n;2 C . 11 22 C 12 21/qnpn\nC . 11\u0006n;2 C 21\u0006n;1/qn C . 22\u0006n;1 C 12\u0006n;2/pn:\n(7.10)\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkMatrix",
  "lean_declarations": [
    "MD.Ch07.bbkMatrix",
    "MD.Ch07.bbkNoise"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbkMatrix (m Ω γ h : ℝ) : ℝ × ℝ × ℝ × ℝ :=
  (1-h^2*Ω^2/(2*m), h/m*(1-γ*h/2),
    h*Ω^2/(2*m)*((h^2*Ω^2-4*m)/(2+γ*h)),
    (2-γ*h)*(2*m-h^2*Ω^2)/(2*m*(2+γ*h)))
def bbkNoise (m Ω γ θ h R S : ℝ) : ℝ × ℝ :=
  (Real.sqrt (θ*γ*h^3/(2*m))*R,
    Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*((1-h^2*Ω^2/(2*m))*R+S))
```

## MD-7.4-QuadraticProducts
```json
{
  "source_id": "MD-7.4-QuadraticProducts",
  "kind": "unnumbered_claim",
  "label": "(7.8)–(7.10)",
  "section": "7.4",
  "printed_page": "274",
  "pdf_page": "295",
  "statement_latex": "More generally, if we define the components of $\\Psi$ as $\\psi_{ij}$ and denote $\\mu_n=[\\mu_{n,1},\\mu_{n,2}]^T$ we can take products of the update equations defined by (7.7) to obtain\n\\[q_{n+1}^2=\\psi_{11}^2q_n^2+\\psi_{12}^2p_n^2+\\mu_{n,1}^2+2\\psi_{11}\\psi_{12}q_np_n+2\\psi_{11}\\mu_{n,1}q_n+2\\psi_{12}\\mu_{n,1}p_n,\\tag{7.8}\\]\n\\[p_{n+1}^2=\\psi_{21}^2q_n^2+\\psi_{22}^2p_n^2+\\mu_{n,2}^2+2\\psi_{21}\\psi_{22}q_np_n+2\\psi_{21}\\mu_{n,2}q_n+2\\psi_{22}\\mu_{n,2}p_n,\\tag{7.9}\\]\n\\[q_{n+1}p_{n+1}=\\psi_{11}\\psi_{21}q_n^2+\\psi_{12}\\psi_{22}p_n^2+\\mu_{n,1}\\mu_{n,2}+(\\psi_{11}\\psi_{22}+\\psi_{12}\\psi_{21})q_np_n\n+(\\psi_{11}\\mu_{n,2}+\\psi_{21}\\mu_{n,1})q_n+(\\psi_{22}\\mu_{n,1}+\\psi_{12}\\mu_{n,2})p_n.\\tag{7.10}\\]",
  "proof_latex": null,
  "proof_outline": "Take products of the update equations defined by (7.7).",
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 295,
      "printed_page": 274,
      "text": "274\n7\nNumerical Methods for Stochastic Molecular Dynamics\nGaussian distributions, where we have invariant (stationary) averages\nhqi D hpi D 0;\nand\nh˝2q2i D hp2=mi D kBT;\nhqpi D 0:\nWe expect that the discretization schemes that we employ will introduce errors in\nthe computed values of the invariant (long-time) averages. In the large-time limit,\nthese averages will converge towards their invariant value, which we can ﬁnd using\nthe procedure outlined in [59].\nFor the harmonic oscillator, the force \u0003U0.q/ will be linear, and therefore we\nwould expect that any update step in an algorithm will be linear in the state variables\nq and p. Thus, denoting the iteration index as a subscript, we may explicitly write\none iteration of a general numerical method for evolving the dynamics as\n\u0002 qnC1\npnC1\n\u0003\nD \f\n\u0002qn\npn\n\u0003\nC \u0006n;\n(7.7)\nwhere \f is a constant matrix that depends on the stepsize h, the friction coefﬁcient\n\n, the particle mass m and the spring constant ˝. Additionally \u0006n is a vector of\nstochastic processes. For example, in the BBK method we can compute directly\nfrom its update scheme that\n\f BBK D\n2\n4\n1 \u0003 h2˝2\n2m\nh\nm\n\u0006\n1 \u0003 \nh\n2\n\u0007\nh˝2\n2m\n\u0006\nh2˝2\u00024m\n2C\nh\n\u0007 .2\u0002\nh/.2m\u0002h2˝2/\n2m.2C\nh/\n3\n5 ;\n\u0006BBK\nn\nD\n2\n4\nq\nkBT\nh3\n2m\nRn\np2kBT\nhm\n2C\nh\n\u0006\u0006\n1 \u0003 h2˝2\n2m\n\u0007\nRn C R0\nn\n\u0007\n3\n5 :\nMore generally, if we deﬁne the components of \f as ij and denote \u0006n D\nŒ\u0006n;1; \u0006n;2\tT we can take products of the update equations deﬁned by (7.7) to obtain\nq2\nnC1 D 2\n11q2\nn C 2\n12p2\nn C \u00062\nn;1 C 2 11 12qnpn C 2 11\u0006n;1qn C 2 12\u0006n;1pn;\n(7.8)\np2\nnC1 D 2\n21q2\nn C 2\n22p2\nn C \u00062\nn;2 C 2 21 22qnpn C 2 21\u0006n;2qn C 2 22\u0006n;2pn;\n(7.9)\nqnC1pnC1 D 11 21q2\nn C 12 22p2\nn C \u0006n;1\u0006n;2 C . 11 22 C 12 21/qnpn\nC . 11\u0006n;2 C 21\u0006n;1/qn C . 22\u0006n;1 C 12\u0006n;2/pn:\n(7.10)\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.quadraticProducts",
  "lean_declarations": [
    "MD.Ch07.quadraticProducts"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem quadraticProducts (a b c d q p r s : ℝ) :
    (linearUpdate a b c d (q,p) (r,s)).1^2 =
      a^2*q^2+b^2*p^2+r^2+2*a*b*q*p+2*a*r*q+2*b*r*p ∧
    (linearUpdate a b c d (q,p) (r,s)).2^2 =
      c^2*q^2+d^2*p^2+s^2+2*c*d*q*p+2*c*s*q+2*d*s*p ∧
    (linearUpdate a b c d (q,p) (r,s)).1*(linearUpdate a b c d (q,p) (r,s)).2 =
      a*c*q^2+b*d*p^2+r*s+(a*d+b*c)*q*p+(a*s+c*r)*q+(d*r+b*s)*p := by
  dsimp [linearUpdate]
  constructor
  · ring
  constructor <;> ring
```

## MD-7.4.1-StationaryMomentSystem
```json
{
  "source_id": "MD-7.4.1-StationaryMomentSystem",
  "kind": "unnumbered_claim",
  "label": "(7.11)",
  "section": "7.4.1",
  "printed_page": "275",
  "pdf_page": "296",
  "statement_latex": "Hence we have $\\mathbb E(\\mu_{n,i}q_n)=\\mathbb E(\\mu_{n,i}p_n)=0$, for any $i$ and $n$. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then considering the limit $n\\to\\infty$ we obtain a closed, linear system of equations\n\\[Q=\\psi_{11}^2Q+\\psi_{12}^2P+2\\psi_{11}\\psi_{12}C+\\bar\\mu_{11},\\]\n\\[P=\\psi_{21}^2Q+\\psi_{22}^2P+2\\psi_{21}\\psi_{22}C+\\bar\\mu_{22},\\]\n\\[C=\\psi_{11}\\psi_{21}Q+\\psi_{12}\\psi_{22}P+(\\psi_{11}\\psi_{22}+\\psi_{12}\\psi_{21})C+\\bar\\mu_{12},\\tag{7.11}\\]\nwhere $\\bar\\mu_{11}=\\mathbb E(\\mu_{n,1}^2)$, $\\bar\\mu_{12}=\\mathbb E(\\mu_{n,1}\\mu_{n,2})$, $\\bar\\mu_{22}=\\mathbb E(\\mu_{n,2}^2)$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 296,
      "printed_page": 275,
      "text": "7.4\nError Results for Harmonic Problems\n275\nAssuming that the discretization schemes preserve the ergodic property of\nLangevin dynamics, taking the expectation of these equations and considering the\nlimit as n goes to inﬁnity allows us to compute the invariant average of the schemes,\nand thus to evaluate the perfect sampling bias introduced by the discretization.\n7.4.1\nInvariant Averages for Schemes Using the A, B and O\nSplitting\nThe analysis of schemes using the splitting strategy coded with the A, B and O\npieces is particularly simple, as we use a new random number for each stochastic\nupdate meaning that the random numbers and state variables are not correlated\nbetween steps. Hence we have\nE.\u0006n;iqn/ D E.\u0006n;ipn/ D 0;\nfor any i and n. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then\nconsidering the limit n ! 1 we obtain a closed, linear system of equations\nhq2ih D 2\n11hq2ih C 2\n12hp2ih C 2 11 12hqpih C N\u000611;\nhp2ih D 2\n21hq2ih C 2\n22hp2ih C 2 21 22hqpih C N\u000622;\nhqpih D 11 21hq2ih C 12 22hp2ih C . 11 22 C 12 21/hqpih C N\u000612;\n(7.11)\nwhere we have constants\nN\u000611 D E.\u00062\nn;1/;\nN\u000612 D E.\u0006n;1\u0006n;2/;\nN\u000622 D E.\u00062\nn;2/:\nWe can solve this linear system to ﬁnd the invariant averages computed by the\nchosen discretization scheme for the harmonic oscillator with Hamiltonian (7.6).\nExample 7.1 Consider the scheme coded \u0002ABO\u0003, where\n\u0002ABO\u0003\nqnC1 D qn C hM\u00021pn\npnC1=2 D pn \u0003 hrU.qnC1/\npnC1 D e\u0002h\npnC1=2 C \u0018M1=2Rn\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "使用独立乘积μ.prodη及实际推前不变性，不把所求矩方程当作该定理假设；所有坐标L²、噪声中心化明示。",
    "只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.momentSystem",
  "lean_declarations": [
    "MD.Ch07.momentSystem",
    "MD.Ch07.invariantLinearLaw",
    "MD.Ch07.stationaryMomentSystem"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def momentSystem (a b c d u v w Q P C : ℝ) : Prop :=
  Q = a^2*Q+b^2*P+2*a*b*C+u ∧
  P = c^2*Q+d^2*P+2*c*d*C+w ∧
  C = a*c*Q+b*d*P+(a*d+b*c)*C+v

def invariantLinearLaw (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ IsProbabilityMeasure η ∧
  Measure.map (fun z ↦ linearUpdate a b c d z.1 z.2) (μ.prod η) = μ

theorem stationaryMomentSystem (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ)
    (hinv : invariantLinearLaw μ η a b c d)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hr : MemLp (fun x ↦ x.1) 2 η) (hs : MemLp (fun x ↦ x.2) 2 η)
    (hmean : (∫ x, x.1 ∂η) = 0 ∧ (∫ x, x.2 ∂η) = 0) :
    momentSystem a b c d (momentQ η) (momentQP η) (momentP η)
      (momentQ μ) (momentP μ) (momentQP μ) := by
  sorry
```
