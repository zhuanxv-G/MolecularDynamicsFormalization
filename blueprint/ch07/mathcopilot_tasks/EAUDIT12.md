# EAUDIT12 第7章修改后陈述复审

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
    "用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。",
    "29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。"
  ],
  "issues": [],
  "statement_scope": "仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。",
  "lean_decl": "MD.Ch07.localMapErrorBound",
  "lean_declarations": [
    "MD.Ch07.localMapErrorBound",
    "MD.Ch07.geodesicReplacementSecondOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "缩小statement_scope为局部误差资格定义，并明确原文保阶命题未形式化；或另行陈述带必要稳定性等假设的组合保阶定理。本次仅登记，不补证明。",
      "actual_scope": "仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。"
  ]
}
```
```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
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
    "正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。",
    "29号覆盖限定：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。"
  ],
  "issues": [],
  "statement_scope": "实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。",
  "lean_decl": "MD.Ch07.characteristicUnitDisk",
  "lean_declarations": [
    "MD.Ch07.characteristicUnitDisk",
    "MD.Ch07.spectralRadiusStability",
    "MD.Ch07.hyperbolicStability",
    "MD.Ch07.multipleX_spectral_hyperbolic"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "补充带γ>0,h>0、η²关系与η≠0的代数等价声明，并把谱条件与随机稳定性分开。",
      "actual_scope": "实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。"
  ]
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

theorem multipleX_spectral_hyperbolic (Ω γ h : ℝ) (η : ℂ)
    (hγ : 0 < γ) (hh : 0 < h)
    (hη : η^2=(γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    characteristicUnitDisk (multipleX Ω γ h) ↔ hyperbolicStability γ h η := by
  sorry
```
