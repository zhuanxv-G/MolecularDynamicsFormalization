# EAUDIT03 第7章修改后陈述复审

## MD-7.6-JSplitting
```json
{
  "source_id": "MD-7.6-JSplitting",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.6",
  "printed_page": "282–283",
  "pdf_page": "303–304",
  "statement_latex": "Let $J$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $J$ into a finite number $K$ of skew-symmetric matrices $J_i$, $i=1,\\ldots,K$. This induces a splitting of the Hamiltonian vector field into $K$ vector fields $f_i=J_i\\nabla H$. Each of these vector fields preserves $H$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 303,
      "printed_page": 282,
      "text": "282\n7\nNumerical Methods for Stochastic Molecular Dynamics\ndeterministic Hamiltonian system taken ﬁrst, followed by the Ornstein-Uhlenbeck\nequation for p. The ﬂows of each of these systems individually preserves the Gibbs\ndistribution: denoting the Fokker-Planck operators associated to these ﬂows by L\u0004\nH\nand L\u0004\nO we have\nL\u0004\nH\u0005ˇ D 0;\nL\u0004\nO\u0005ˇ D 0;\nand hence\nexp.tL\u0004\nH/\u0005ˇ D exp.tL\u0004\nO/\u0005ˇ D \u0005ˇ:\nWe can consider the propagation of measure resulting from a numerical discretiza-\ntion deﬁned by the composition of these two pieces. For a scheme \u0002HO\u0003, we have\nthe distribution ﬁrst propagated under Hamiltonian dynamics, and then the momenta\nare evolved as the solution to the Ornstein-Uhlenbeck process, which clearly will\npreserve the Gibbs measure\nexp.hL\u0004\nO/\n\u0006\nexp.hL\u0004\nH/\u0005ˇ\n\u0007\nD exp.hL\u0004\nO/\u0005ˇ D \u0005ˇ:\nThe problem with this “method” is of course that it requires the exact ﬂow map\nof the Hamiltonian system. However, this requirement can be relaxed. Given any\ndivergence free vector ﬁeld f, we have\n\u0003r \u0002 .f\u0005/ D \u0003f \u0002 r\u0005;\nthus\nL\u0004\nf \u0005 D \u0003Lf\u0005:\nIf Lf preserves a ﬁrst integral I, then Lf preserves any distribution which is a\nfunction of I. It follows that any energy-preserving, divergence free vector ﬁeld\nwill always preserve the Gibbs distribution.\nAll symplectic methods preserve the volume, but for a system with no ﬁrst\nintegrals except the energy, it is known from a theorem of Ge and Marsden [400]\nthat a symplectic method cannot preserve the system energy exactly (unless the\nsymplectic method is itself a time-reparameterization of the exact solution). The\noptions for volume preserving non-symplectic discretization methods that conserve\nenergy exactly are limited (standard form schemes that rely on calculation of the\nvector ﬁeld at a few points cannot achieve this [380]).\nA class of methods that do provide the necessary features can be found in the\nwork of Feng Kang [133], referred to as J-splitting by McLachlan and Quispel [261].\nLet J be the skew-symmetric canonical symplectic structure matrix. The idea is to\nconsider a splitting of J into a ﬁnite number K of skew-symmetric matrices Ji,\ni D 1; : : : ; K. This induces a splitting of the Hamiltonian vector ﬁeld into K vector\n"
    },
    {
      "pdf_page": 304,
      "printed_page": 283,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n283\nﬁelds f i D JirH. Each of these vector ﬁelds preserves H and, because they are\nthemselves Hamiltonian, their ﬂows are also volume-preserving. Assuming each\nsuch vector ﬁeld is exactly integrable, the system dynamics may be approximated\nby composing the ﬂow maps for each vector ﬁeld.\nAs an example of such a J-splitting, we may take K D Nc with each Ji to be\ndeﬁned by the components of the canonical symplectic structure matrix having to\ndo with the ith position and momentum pair, thus the equations of motion for the ith\nvector ﬁeld become\nPqi D pi\nmi\n;\nPpi D \u0003@U\n@qi\n.Nq1; : : : ; Nqi\u00021; qi; NqiC1; : : : ; NqNc/;\nwhere components with a bar over them are ﬁxed during the calculation. This is,\nitself, a Hamiltonian system with a single degree of freedom qi and the potential\nOUi.qi/ obtained by freezing all other components in the original potential function.\nAny such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).\nThus, if we are willing to solve a system using quadrature, we have a numerical\nmethod for the Hamiltonian system which preserves volume and energy. We solve\neach such dynamics from i D 1 to Nc, updating the values of each .qi; pi/ in\nsequence (the temporally contiguous nature of the updates rules it out as a strategy\nfor parallel computation).\nAlthough this method can be applied to molecular systems, its implementation\nis challenging and it is not recommended for general computation. Some systems\nmay have a structure amenable to exploitation via this splitting strategy, or it could\npotentially serve as a starting point in some special purpose methods. For another\nuse of J-splitting in the setting of Metropolis correction of deterministic methods,\nsee [48].\n7.7\nThe Evolution of the Distribution Using a Numerical\nMethod\nIn this section, we shall give an approach that allows the computation of the errors\nintroduced by the discretization of Langevin dynamics for more general potential\nenergy functions. The discretization schemes we shall consider will be those created\nby composition of the A, B and O splitting pieces described earlier in this chapter,\nbut in principle we can apply this analysis to a wider class of SDE methods.\nWe outline the basic approach for determining the leading order behavior of the\ndiscretization error introduced by our SDE integration scheme (see [221–223]),\nbased on expansions due to Talay and Tubaro [357, 358].\nIn Chap.3 we employed an asymptotic expansion of the conserved energy-like\nquantity of a numerical method in powers of the stepsize. By positing such an\nexpansion we are able to calculate the term of any order directly, using a recursive\napproach. Given such an expansion of the Hamiltonian, we have a corresponding\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。",
    "体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。",
    "29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。"
  ],
  "issues": [],
  "statement_scope": "有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。",
  "lean_decl": "MD.Ch07.jField",
  "lean_declarations": [
    "MD.Ch07.jField",
    "MD.Ch07.jSplitting_energy",
    "MD.Ch07.composition_preservesEnergy",
    "MD.Ch07.jField_finiteDecomposition"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "登记有限反对称矩阵分解及向量场分解；在存在的适当光滑流上陈述能量和体积保持，并给出复合方案与原系统的关联。",
      "actual_scope": "有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。"
  ]
}
```
```lean
def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]

theorem jField_finiteDecomposition {K : ℕ} (J : Fin K → Matrix (Fin n) (Fin n) ℝ)
    (H : V n → ℝ) (hJ : ∀ k i j, J k i j = -J k j i) :
    jField (∑ k, J k) H = fun x ↦ ∑ k, jField (J k) H x := by
  sorry
```

## MD-7.6-CoordinateJSplitting
```json
{
  "source_id": "MD-7.6-CoordinateJSplitting",
  "kind": "definition",
  "label": null,
  "section": "7.6",
  "printed_page": "283",
  "pdf_page": "304",
  "statement_latex": "As an example of such a $J$-splitting, we may take $K=N_c$ with each $J_i$ to be defined by the components of the canonical symplectic structure matrix having to do with the $i$th position and momentum pair, thus the equations of motion for the $i$th vector field become\n\\[\\dot q_i=p_i/m_i,\\qquad \\dot p_i=-\\frac{\\partial U}{\\partial q_i}(\\bar q_1,\\ldots,\\bar q_{i-1},q_i,\\bar q_{i+1},\\ldots,\\bar q_{N_c}),\\]\nwhere components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 304,
      "printed_page": 283,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n283\nﬁelds f i D JirH. Each of these vector ﬁelds preserves H and, because they are\nthemselves Hamiltonian, their ﬂows are also volume-preserving. Assuming each\nsuch vector ﬁeld is exactly integrable, the system dynamics may be approximated\nby composing the ﬂow maps for each vector ﬁeld.\nAs an example of such a J-splitting, we may take K D Nc with each Ji to be\ndeﬁned by the components of the canonical symplectic structure matrix having to\ndo with the ith position and momentum pair, thus the equations of motion for the ith\nvector ﬁeld become\nPqi D pi\nmi\n;\nPpi D \u0003@U\n@qi\n.Nq1; : : : ; Nqi\u00021; qi; NqiC1; : : : ; NqNc/;\nwhere components with a bar over them are ﬁxed during the calculation. This is,\nitself, a Hamiltonian system with a single degree of freedom qi and the potential\nOUi.qi/ obtained by freezing all other components in the original potential function.\nAny such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).\nThus, if we are willing to solve a system using quadrature, we have a numerical\nmethod for the Hamiltonian system which preserves volume and energy. We solve\neach such dynamics from i D 1 to Nc, updating the values of each .qi; pi/ in\nsequence (the temporally contiguous nature of the updates rules it out as a strategy\nfor parallel computation).\nAlthough this method can be applied to molecular systems, its implementation\nis challenging and it is not recommended for general computation. Some systems\nmay have a structure amenable to exploitation via this splitting strategy, or it could\npotentially serve as a starting point in some special purpose methods. For another\nuse of J-splitting in the setting of Metropolis correction of deterministic methods,\nsee [48].\n7.7\nThe Evolution of the Distribution Using a Numerical\nMethod\nIn this section, we shall give an approach that allows the computation of the errors\nintroduced by the discretization of Langevin dynamics for more general potential\nenergy functions. The discretization schemes we shall consider will be those created\nby composition of the A, B and O splitting pieces described earlier in this chapter,\nbut in principle we can apply this analysis to a wider class of SDE methods.\nWe outline the basic approach for determining the leading order behavior of the\ndiscretization error introduced by our SDE integration scheme (see [221–223]),\nbased on expansions due to Talay and Tubaro [357, 358].\nIn Chap.3 we employed an asymptotic expansion of the conserved energy-like\nquantity of a numerical method in powers of the stepsize. By positing such an\nexpansion we are able to calculate the term of any order directly, using a recursive\napproach. Given such an expansion of the Hamiltonian, we have a corresponding\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。",
    "29号覆盖限定：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。"
  ],
  "issues": [],
  "statement_scope": "两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。",
  "lean_decl": "MD.Ch07.coordinateJField",
  "lean_declarations": [
    "MD.Ch07.coordinateJField",
    "MD.Ch07.frozenPotential",
    "MD.Ch07.coordinateJQualification",
    "MD.Ch07.frozenPotential_deriv"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "补齐适用的正质量、光滑性、冻结势导数关系和分段求积/转折点资格；或者明确将形式化范围缩为两个定义，不标为完整覆盖。",
      "actual_scope": "两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。"
  ]
}
```
```lean
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)

def coordinateJQualification (m : V n) (U : V n → ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 U

theorem frozenPotential_deriv (m : V n) (U : V n → ℝ)
    (hq : coordinateJQualification m U) (q : V n) (i : Fin n) :
    deriv (frozenPotential U q i) (q i) = gradient U q i := rfl
```

## MD-7.7.1-OperatorOrderReversal
```json
{
  "source_id": "MD-7.7.1-OperatorOrderReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.1",
  "printed_page": "285",
  "pdf_page": "306",
  "statement_latex": "For example, for the method labelled by the string $[ABAO]$, we have\n\\[\\exp(h\\widehat{\\mathcal L}_{[ABAO]})=\\exp((h/2)\\mathcal L_A)\\exp(h\\mathcal L_B)\\exp((h/2)\\mathcal L_A)\\exp(h\\mathcal L_O),\\]\nwhere importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $\\widehat{\\mathcal L}^\\dagger$, which we may compute as\n\\[\\exp(h\\widehat{\\mathcal L}_{[ABAO]}^\\dagger)=\\exp(h\\mathcal L_O^\\dagger)\\exp((h/2)\\mathcal L_A^\\dagger)\\exp(h\\mathcal L_B^\\dagger)\\exp((h/2)\\mathcal L_A^\\dagger).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 306,
      "printed_page": 285,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n285\n7.7.1\nExpansion of the Operator OL\nConsider a Langevin splitting method using the A, B and O splitting pieces, where\nwe compose exact solves of each of the vector ﬁelds in a prescribed sequence to\ndeﬁne our discretization scheme. Because we solve each piece exactly, we are able\nto write down the action of each individual solve on the initial distribution in terms\nof the vector ﬁeld’s evolution operator (using the respective generators for each\npiece as in [99]), where\n\u0004\netLA\b\n\u0005\n.q; p/ D \b.q C tM\u00021p; p/;\n\u0004\netLB\b\n\u0005\n.q; p/ D \b.q; p \u0003 trU.q//;\n\u0004\netLO\b\n\u0005\n.q; p/ D\nZ\nP\n\b\n\u0006\nq; e\u0002\ntp C \u0018M1=2x\n\u0007 e\u0002jxj2=2\n.2\u0014/Nc=2 dx;\nwhere \u0018 D\n\nkBT\n\u0004\n1 \u0003 e\u00022\nt\u0005\u000b1=2. The overall generator for an associated Langevin\nsplitting method\nOL can be computed by composing each individual operator\nassociated to the terms in the splitting. For example, for the method labelled by\nthe string \u0002ABAO\u0003, we have\nexp.h OL\u0002ABAO\u0003/ D exp..h=2/LA/ exp.hLB/ exp..h=2/LA/ exp.hLO/;\nwhere importantly note the apparent reversal of the sequence of products, known\nas the vertauschungssatz (see the discussion in [164, Section III.5.1]), which is a\nconsequence of the relation\n\b.U f1\nt .z// D\n\u0004\netLf1\b\n\u0005\n.z/;\nfor some vector ﬁeld f1 with associated ﬂow map U f1\nt\nand generator Lf1, where the\nchoice of \b.z/ D U f2\nt .z/ D .etLf2Id/.z/ demonstrates this reversal.\nWe will ﬁnd it more convenient to work with the adjoint of the perturbed\ngenerator, denoted OL\u0004, which we may compute as\nexp.h OL\u0004\n\u0002ABAO\u0003/ D exp.hL\u0004\nO/ exp..h=2/L\u0004\nA/ exp.hL\u0004\nB/ exp..h=2/L\u0004\nA/:\nUnder the propagation of the numerical scheme (or the discretized dynamics),\nthe Fokker-Planck equation gives us that the evolution of a density of points \u0005 is\ngiven by\n@\n@t\u0005.z; t/ D OL\u0004\u0005;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。",
    "伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。",
    "29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。"
  ],
  "issues": [],
  "statement_scope": "拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。",
  "lean_decl": "MD.Ch07.pullback_order",
  "lean_declarations": [
    "MD.Ch07.pullback_order",
    "MD.Ch07.abaoBackward",
    "MD.Ch07.fourStage_duality"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "在合适对偶空间上增加四段前向算子及反序伴随等式，或明确拆分“后向定义”与仍未形式化的伴随条目。",
      "actual_scope": "拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。"
  ]
}
```
```lean
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))

theorem fourStage_duality {E : Type*} [AddCommGroup E] [Module ℝ E]
    (pair : E → E → ℝ) (A B C D a b c d : Module.End ℝ E)
    (hA : ∀ x y, pair (A x) y = pair x (a y))
    (hB : ∀ x y, pair (B x) y = pair x (b y))
    (hC : ∀ x y, pair (C x) y = pair x (c y))
    (hD : ∀ x y, pair (D x) y = pair x (d y)) (x y : E) :
    pair (A (B (C (D x)))) y = pair x (d (c (b (a y)))) := by
  rw [hA,hB,hC,hD]
```
