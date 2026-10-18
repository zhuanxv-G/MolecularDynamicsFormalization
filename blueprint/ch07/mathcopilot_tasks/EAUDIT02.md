# EAUDIT02 第7章修改后陈述复审

## MD-7.4.1-NonsymmetricExactMoments
```json
{
  "source_id": "MD-7.4.1-NonsymmetricExactMoments",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.1",
  "printed_page": "277",
  "pdf_page": "298",
  "statement_latex": "For example, analysis shows that the schemes denoted $[AOAB]$ or $[BAOA]$ both exhibit a first order error in the covariance $\\langle qp\\rangle_h=O(h)$, however they give exact results for both $\\langle q^2\\rangle_h$ and $\\langle p^2\\rangle_h$.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 298,
      "printed_page": 277,
      "text": "7.4\nError Results for Harmonic Problems\n277\nTable 7.1 The expected long-time computed average using the given second-order Langevin\ndynamics discretization scheme\nScheme\nhq2ih=hq2i\nhp2ih=hp2i\nhqpi\n\u0002ABOBA\u0003\n1\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n0\n\u0002OBABO\u0003\nŒ1 \u0002 h2˝2=.4m/\t\u00021\n1\n0\n\u0002BAOAB\u0003\n1\n1 \u0002 h2˝2=.4m/\n0\n\u0002OABAO\u0003\n1 \u0002 h2˝2=.4m/\n1\n0\nschemes, we are able to compute the exact expected average by solving the linear\nequations. The results are summarized in Table 7.1, where we have not considered\nthe \u0002AOBOA\u0003 and \u0002BOAOB\u0003 schemes due to their inconsistency at large friction\n(this does not preclude the analysis, but limits each those method’s usefulness in\nsimulation). Similar analysis can be conducted for more complicated composition\nschemes involving multiple force evaluations.\nThe mentioned splitting schemes give a second-order error in the computed\naverages, but surprisingly each gives an exact result for computed averages of either\nposition or momentum. The exactness property is not born out of the symmetry of\nthe method, but rather of the speciﬁc order of terms and choice of splitting “building\nblocks”. Even non-symmetric ﬁrst-order schemes can exhibit similar qualities. For\nexample, analysis shows that the schemes denoted \u0002AOAB\u0003 or \u0002BAOA\u0003 both exhibit\na ﬁrst order error in the covariance hqpih D O.h/, however they give exact results\nfor both hq2ih and hp2ih.\n7.4.2\nMore General Schemes\nWe can conduct a similar analysis for any integrator that we can express in the\nform (7.7), simply by plugging in the relevant constants and solving a linear\nequation. The difﬁculty lies when random numbers are reused, leading to correlation\nbetween steps. This requires careful treatment to compute the expectation.\nExample 7.2 Consider the variant of the BBK integrator that recycles the random\nnumber between steps:\nBrünger-Brooks-Karplus with post-step re-use of random number (BBK*)\npnC1=2 D .1 \u0003 h\n=2/pn \u0003 .h=2/rU.qn/ C 1\n2\np2kBTh\nM1=2Rn\nqnC1 D qn C hM\u00021pnC1=2\npnC1 D ŒpnC1=2 \u0003 .h=2/rU.qnC1/ C 1\n2\np2kBTh\nM1=2RnC1\t=.1 C h\n=2/,\nwhere Rn is a vector of normal random numbers with zero mean and unit variance.\nIn some systems, it can be computationally expensive to generate normal random\nnumbers for each degree of freedom, hence algorithms may re-use the random\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。",
    "本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。",
    "29号覆盖限定：正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。"
  ],
  "issues": [],
  "statement_scope": "正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。",
  "lean_decl": "MD.Ch07.nonsymmetricHarmonicStep",
  "lean_declarations": [
    "MD.Ch07.nonsymmetricHarmonicStep",
    "MD.Ch07.nonsymmetricExactMoments",
    "MD.Ch07.nonsymmetricMixedMoment_order"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "增加混合矩公式：AOAB 为 -θh/2，BAOA 为 θh/2，并据此给出固定物理参数的 O(h)；或者明确把本条标为仅覆盖两个方差。",
      "actual_scope": "正质量和稳定范围内AOAB/BAOA不变概率的两个方差、精确混合矩；固定参数下混合矩为O(h)的量化界另列。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": []
}
```
```lean
def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m ∧
    (∫ x, x.1*x.2 ∂μ) = (if flip then -θ*h/2 else θ*h/2) := by
  sorry

theorem nonsymmetricMixedMoment_order (θ : ℝ) (flip : Bool) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ if flip then -θ*h/2 else θ*h/2) (fun h : ℝ ↦ h) := by
  sorry
```

## MD-7.6-GibbsComposition
```json
{
  "source_id": "MD-7.6-GibbsComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.6",
  "printed_page": "282",
  "pdf_page": "303",
  "statement_latex": "The flows of each of these systems individually preserves the Gibbs distribution: denoting the Fokker-Planck operators associated to these flows by $\\mathcal L_H^\\dagger$ and $\\mathcal L_O^\\dagger$ we have\n\\[\\mathcal L_H^\\dagger\\rho_\\beta=0,\\qquad\\mathcal L_O^\\dagger\\rho_\\beta=0,\\]\nand hence\n\\[\\exp(t\\mathcal L_H^\\dagger)\\rho_\\beta=\\exp(t\\mathcal L_O^\\dagger)\\rho_\\beta=\\rho_\\beta.\\]\nFor a scheme $[HO]$, we have\n\\[\\exp(h\\mathcal L_O^\\dagger)[\\exp(h\\mathcal L_H^\\dagger)\\rho_\\beta]=\\exp(h\\mathcal L_O^\\dagger)\\rho_\\beta=\\rho_\\beta.\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 303,
      "printed_page": 282,
      "text": "282\n7\nNumerical Methods for Stochastic Molecular Dynamics\ndeterministic Hamiltonian system taken ﬁrst, followed by the Ornstein-Uhlenbeck\nequation for p. The ﬂows of each of these systems individually preserves the Gibbs\ndistribution: denoting the Fokker-Planck operators associated to these ﬂows by L\u0004\nH\nand L\u0004\nO we have\nL\u0004\nH\u0005ˇ D 0;\nL\u0004\nO\u0005ˇ D 0;\nand hence\nexp.tL\u0004\nH/\u0005ˇ D exp.tL\u0004\nO/\u0005ˇ D \u0005ˇ:\nWe can consider the propagation of measure resulting from a numerical discretiza-\ntion deﬁned by the composition of these two pieces. For a scheme \u0002HO\u0003, we have\nthe distribution ﬁrst propagated under Hamiltonian dynamics, and then the momenta\nare evolved as the solution to the Ornstein-Uhlenbeck process, which clearly will\npreserve the Gibbs measure\nexp.hL\u0004\nO/\n\u0006\nexp.hL\u0004\nH/\u0005ˇ\n\u0007\nD exp.hL\u0004\nO/\u0005ˇ D \u0005ˇ:\nThe problem with this “method” is of course that it requires the exact ﬂow map\nof the Hamiltonian system. However, this requirement can be relaxed. Given any\ndivergence free vector ﬁeld f, we have\n\u0003r \u0002 .f\u0005/ D \u0003f \u0002 r\u0005;\nthus\nL\u0004\nf \u0005 D \u0003Lf\u0005:\nIf Lf preserves a ﬁrst integral I, then Lf preserves any distribution which is a\nfunction of I. It follows that any energy-preserving, divergence free vector ﬁeld\nwill always preserve the Gibbs distribution.\nAll symplectic methods preserve the volume, but for a system with no ﬁrst\nintegrals except the energy, it is known from a theorem of Ge and Marsden [400]\nthat a symplectic method cannot preserve the system energy exactly (unless the\nsymplectic method is itself a time-reparameterization of the exact solution). The\noptions for volume preserving non-symplectic discretization methods that conserve\nenergy exactly are limited (standard form schemes that rely on calculation of the\nvector ﬁeld at a few points cannot achieve this [380]).\nA class of methods that do provide the necessary features can be found in the\nwork of Feng Kang [133], referred to as J-splitting by McLachlan and Quispel [261].\nLet J be the skew-symmetric canonical symplectic structure matrix. The idea is to\nconsider a splitting of J into a ﬁnite number K of skew-symmetric matrices Ji,\ni D 1; : : : ; K. This induces a splitting of the Hamiltonian vector ﬁeld into K vector\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只覆盖末尾不变对象的组合恒等式；P/Q可取实际测度推前或已定义的传播子。H/O各自Gibbs不变性由前面独立陈述承担，生成元零蕴含半群固定点还需半群域理论。",
    "29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。"
  ],
  "issues": [],
  "statement_scope": "只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。",
  "lean_decl": "MD.Ch07.gibbsComposition",
  "lean_declarations": [
    "MD.Ch07.gibbsComposition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "补上具体 H/O 传播子对实际 Gibbs 测度的识别以及所需生成元/半群域前提；或将声明对应范围缩至末尾组合恒等式。",
      "actual_scope": "只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：只覆盖两个已给定共同固定点映射的末尾组合恒等式；未识别实际H/O生成元、Gibbs测度及其半群。"
  ]
}
```
```lean
theorem gibbsComposition {E : Type*} (P Q : E → E) (ρ : E)
    (hP : P ρ = ρ) (hQ : Q ρ = ρ) : (Q ∘ P) ρ = ρ := by
  simp only [Function.comp_apply, hP, hQ]
```

## MD-7.6-DivergenceFreeInvariant
```json
{
  "source_id": "MD-7.6-DivergenceFreeInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.6",
  "printed_page": "282",
  "pdf_page": "303",
  "statement_latex": "Given any divergence free vector field $f$, we have\n\\[-\\nabla\\cdot(f\\rho)=-f\\cdot\\nabla\\rho,\\]\nthus $\\mathcal L_f^\\dagger\\rho=-\\mathcal L_f\\rho$.\nIf $\\mathcal L_f$ preserves a first integral $I$, then $\\mathcal L_f$ preserves any distribution which is a function of $I$. It follows that any energy-preserving, divergence free vector field will always preserve the Gibbs distribution.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 303,
      "printed_page": 282,
      "text": "282\n7\nNumerical Methods for Stochastic Molecular Dynamics\ndeterministic Hamiltonian system taken ﬁrst, followed by the Ornstein-Uhlenbeck\nequation for p. The ﬂows of each of these systems individually preserves the Gibbs\ndistribution: denoting the Fokker-Planck operators associated to these ﬂows by L\u0004\nH\nand L\u0004\nO we have\nL\u0004\nH\u0005ˇ D 0;\nL\u0004\nO\u0005ˇ D 0;\nand hence\nexp.tL\u0004\nH/\u0005ˇ D exp.tL\u0004\nO/\u0005ˇ D \u0005ˇ:\nWe can consider the propagation of measure resulting from a numerical discretiza-\ntion deﬁned by the composition of these two pieces. For a scheme \u0002HO\u0003, we have\nthe distribution ﬁrst propagated under Hamiltonian dynamics, and then the momenta\nare evolved as the solution to the Ornstein-Uhlenbeck process, which clearly will\npreserve the Gibbs measure\nexp.hL\u0004\nO/\n\u0006\nexp.hL\u0004\nH/\u0005ˇ\n\u0007\nD exp.hL\u0004\nO/\u0005ˇ D \u0005ˇ:\nThe problem with this “method” is of course that it requires the exact ﬂow map\nof the Hamiltonian system. However, this requirement can be relaxed. Given any\ndivergence free vector ﬁeld f, we have\n\u0003r \u0002 .f\u0005/ D \u0003f \u0002 r\u0005;\nthus\nL\u0004\nf \u0005 D \u0003Lf\u0005:\nIf Lf preserves a ﬁrst integral I, then Lf preserves any distribution which is a\nfunction of I. It follows that any energy-preserving, divergence free vector ﬁeld\nwill always preserve the Gibbs distribution.\nAll symplectic methods preserve the volume, but for a system with no ﬁrst\nintegrals except the energy, it is known from a theorem of Ge and Marsden [400]\nthat a symplectic method cannot preserve the system energy exactly (unless the\nsymplectic method is itself a time-reparameterization of the exact solution). The\noptions for volume preserving non-symplectic discretization methods that conserve\nenergy exactly are limited (standard form schemes that rely on calculation of the\nvector ﬁeld at a few points cannot achieve this [380]).\nA class of methods that do provide the necessary features can be found in the\nwork of Feng Kang [133], referred to as J-splitting by McLachlan and Quispel [261].\nLet J be the skew-symmetric canonical symplectic structure matrix. The idea is to\nconsider a splitting of J into a ﬁnite number K of skew-symmetric matrices Ji,\ni D 1; : : : ; K. This induces a splitting of the Hamiltonian vector ﬁeld into K vector\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "微分对象C¹，第一积分和散度为实际导数；密度非负及归一化需g另行满足，此微分恒等式不把任意g都称概率密度。",
    "不变生成元到全局流不变测度仍需完整流/输运桥，见HamiltonianGibbs。",
    "29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。"
  ],
  "issues": [],
  "statement_scope": "只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。",
  "lean_decl": "MD.Ch07.lieField",
  "lean_declarations": [
    "MD.Ch07.lieField",
    "MD.Ch07.divergenceField",
    "MD.Ch07.forwardField",
    "MD.Ch07.divergenceFreeInvariant",
    "MD.Ch07.firstIntegral_density"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "保留微分恒等式；明确补上可归一 Gibbs 密度的链式法则特化及适当全局流/输运定理，或把本条覆盖范围限制在生成元恒等式。",
      "actual_scope": "只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：只覆盖C¹向量场的散度乘积恒等式和可微第一积分的链式法则；不包含归一Gibbs测度或全局流保测。"
  ]
}
```
```lean
def lieField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  (fderiv ℝ ρ x) (f x)
def divergenceField (f : V n → V n) (x : V n) : ℝ :=
  ∑ i, coordDerivative (fun y ↦ f y i) x i
def forwardField (f : V n → V n) (ρ : V n → ℝ) (x : V n) : ℝ :=
  -∑ i, coordDerivative (fun y ↦ f y i*ρ y) x i
theorem divergenceFreeInvariant (f : V n → V n) (ρ : V n → ℝ)
    (hf : ContDiff ℝ 1 f) (hρ : ContDiff ℝ 1 ρ)
    (hdiv : ∀ x, divergenceField f x = 0) : ∀ x, forwardField f ρ x = -lieField f ρ x := by
  sorry
theorem firstIntegral_density (f : V n → V n) (I : V n → ℝ) (g : ℝ → ℝ)
    (hI : Differentiable ℝ I) (hg : Differentiable ℝ g)
    (hfirst : ∀ x, lieField f I x = 0) : ∀ x, lieField f (g ∘ I) x = 0 := by
  intro x
  rw [lieField, fderiv_comp x (hg (I x)) (hI x)]
  simp only [ContinuousLinearMap.comp_apply]
  change (fderiv ℝ g (I x)) (lieField f I x) = 0
  rw [hfirst x, map_zero]
```
