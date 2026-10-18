# EAUDIT04 第7章修改后陈述复审

## MD-7.7.1-TaylorRemainder
```json
{
  "source_id": "MD-7.7.1-TaylorRemainder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.1",
  "printed_page": "286–287",
  "pdf_page": "307–308",
  "statement_latex": "We can make use of Taylor’s theorem to write the identity\n\\[P_h=P_0+h\\left.\\frac{dP_t}{dt}\\right|_{t=0}+\\cdots+\\frac{h^n}{n!}\\left.\\frac{d^nP_t}{dt^n}\\right|_{t=0}\n+\\frac{h^{n+1}}{n!}\\int_0^1(1-\\lambda)^n\\left.\\frac{d^{n+1}P_t}{dt^{n+1}}\\right|_{t=\\lambda h}d\\lambda,\\]\nfor some finite truncation index $n\\in\\{1,2,3,\\ldots\\}$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 307,
      "printed_page": 286,
      "text": "286\n7\nNumerical Methods for Stochastic Molecular Dynamics\nwith the important case of its invariant distribution satisfying the partial differential\nequation\nOL\u0004 O\u0005 D 0:\nOur goal in the following section is to ﬁnd\nOL\u0004 and solve the PDE for the\ndistribution O\u0005 by using our ansatz (7.17). The solution gives us the corrupted\ninvariant distribution sampled by our numerical scheme, allowing us to correct\nour observed averages to achieve more accurate results. It also gives us a way of\nevaluating which schemes are best for sampling, by evaluating the error introduced\nby the discretization.\nThe terms of the perturbation expansion for OL\u0004 can be computed using the Baker-\nCampbell-Hausdorff(BCH) expansion already introduced in Chap. 3. Recall that for\nlinear operators X and Y, we can write the composition of their exponentials as\nexp .hX/ exp .hY/ D exp .hZ/ ;\nwhere we have the expansion\nZ D X C Y C h\n2ŒX; Y\t C h2\n12 .ŒX; ŒX; Y\t\t C ŒY; ŒY; X\t\t/ C O.h3/:\nThe notation ŒX; Y\t\ndef\nD XY \u0003 YX represents the commutator of the operators X\nand Y. By repeated application of the BCH formula, we can obtain such an\nexpansion for any splitting-based method, however the terms grow in complexity\nat successive powers of h, requiring commutators of increasing length that make\ncomputation cumbersome. Additionally any careful mathematician should question\nthe convergence of this sequence when computing OL, as we deal only with formal\nseries that offer no guidance on the boundedness of the resulting terms, which will\ninvolve high order derivatives in both q and p.\nTo offer some reassurance, let us deﬁne the evolution operator for our numerical\nmethod as\nPt D et OL D etL1etL2 : : : etLk;\nwhere the numerical method has k-many stages with each Li proportional to one of\nLA, LB and LO. We can make use of Taylor’s theorem to write the identity\nPh D P0 C h dPt\ndt\nˇˇˇˇ\ntD0\nC : : : C hn\nnŠ\ndnPt\ndtn\nˇˇˇˇ\ntD0\nC hnC1\nnŠ\n1\nZ\n0\n.1 \u0003 \u0013/n dnC1Pt\ndtnC1\nˇˇˇˇ\ntD\u0013h\nd\u0013;\n"
    },
    {
      "pdf_page": 308,
      "printed_page": 287,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n287\nfor some ﬁnite truncation index n 2 f1; 2; 3; : : :g. The remainder term at order hnC1\nwill involve the integration of ﬁnitely many derivatives of its argument. Hence for\nobservables of sufﬁcient smoothness with compact support, this remainder term will\nremain bounded (see [223]).\n7.7.2\nFirst Order Operator Expansion\nAs we consider schemes involving compositions of three splitting pieces, the\nminimum number of stages to our methods (in order for it to be consistent) will\nbe three. The perturbed Fokker-Planck operator for a splitting method with three\nstages will be computed as\nexp.hS/ D exp.hZ/ exp.hY/ exp.hX/;\n(7.18)\nwhere X, Y and Z are one of L\u0004\nA, L\u0004\nB and L\u0004\nO. Let us work the ﬁrst terms of this\nexpansion out, retaining terms involving triple products only\nexp.hY/ exp.hX/ D exp\n \nh\n \n.Y C X/ C h\n2ŒY; X\t C h2\n12 .ŒY; Y; X\t C ŒX; X; Y\t/ C : : :\n!!\n;\nwhere the notation ŒA; B; C\t is notation for ŒA; ŒB; C\t\t. Applying this formula one\nmore time in (7.18), we ﬁnd\nS D X C Y C Z C h\n2ŒY; X\t C h2\n12 .ŒY; ŒY; X\t\t C ŒX; ŒX; Y\t\t/\nC h\n2\n\u0002\nZ; Y C X C h\n2ŒY; X\t\n\u0003\nC h2\n12 .ŒZ; ŒZ; Y C X\t\t \u0003 ŒY C X; ŒZ; Y C X\t\t/ C : : :\nD X C Y C Z C h\n2.ŒZ; Y\t C ŒZ; X\t C ŒY; X\t/ C h2\n4 ŒZ; Y; X\t\nC h2\n12 .ŒY; Y; X\t C ŒX; X; Y\t C ŒZ; Z; Y\t C ŒZ; Z; X\t\nCŒY C X; Y C X; Z\t/ C : : :\nIn general the terms in this expansion will lead to complicated expansions. In the\ncase of deterministic systems, the operators are always ﬁrst order due to equality\nof mixed partials (the 2nd order derivatives are cancelled). Due to the second\nderivatives present in the L\u0004\nO operator, derivatives of all orders will appear in the\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。",
    "29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。"
  ],
  "issues": [],
  "statement_scope": "标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。",
  "lean_decl": "MD.Ch07.taylorRemainder",
  "lean_declarations": [
    "MD.Ch07.taylorRemainder",
    "MD.Ch07.taylorRemainder_bound",
    "MD.Ch07.propagatedObservable_remainder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "为固定光滑紧支撑观测量说明F(t)=P_tφ(z)并证明相应时间正则性；明确需要逐点还是统一余项界，并陈述该界。",
      "actual_scope": "标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。"
  ]
}
```
```lean
theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry

theorem propagatedObservable_remainder {E : Type*} (P : ℝ → (E → ℝ) → E → ℝ)
    (φ : E → ℝ) (z : E) (k : ℕ)
    (htime : ContDiff ℝ (k+1) (fun t ↦ P t φ z)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ P h φ z-∑ j ∈ Finset.range (k+1),
        h^j/(Nat.factorial j : ℝ)*iteratedDeriv j (fun t ↦ P t φ z) 0)
      (fun h ↦ h^(k+1)) := taylorRemainder_bound _ k htime
```

## MD-7.7.2-OBAModifiedOperator
```json
{
  "source_id": "MD-7.7.2-OBAModifiedOperator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.7.2",
  "printed_page": "288–289",
  "pdf_page": "309–310",
  "statement_latex": "\\[\\exp(h\\widehat{\\mathcal L}_{[OBA]}^\\dagger)=\\exp(h\\mathcal L_A^\\dagger)\\exp(h\\mathcal L_B^\\dagger)\\exp(h\\mathcal L_O^\\dagger).\\]\n\\[\\widehat{\\mathcal L}_{[OBA]}^\\dagger\\rho=\\mathcal L_{LD}^\\dagger\\rho+\\frac h2[-pU''(q)\\rho_p+U'(q)\\rho_q+\\gamma p\\rho_q+\\sigma^2\\rho_{qp}+\\gamma U'(q)\\rho_p]+O(h^2).\\]",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 309,
      "printed_page": 288,
      "text": "288\n7\nNumerical Methods for Stochastic Molecular Dynamics\nexpansion of the SDE method. The series expansion is therefore not particularly\ninformative on its own, but only in relation to its action on some particular\ndistribution.\nA simple ﬁrst order example of a Langevin dynamics integrator is the method\nobtained by composing one of the Symplectic Euler variants with an Ornstein-\nUhlenbeck step. To get a feel for how the expansion goes, let us work out its terms\nfor such a splitting scheme in the case of a one degree of freedom model with unit\nmass: H D p2=2 CU.q/. To be explicit, let us say our numerical method ﬁrst solves\nexactly the OU process, then evaluates the impulse due to the force \u0003U0.q/ and\nlastly drifts in position space according to the momentum. This method is denoted in\nour notation as \u0002OBA\u0003, where the evolution of measure in one step can be computed\nby writing\nexp.h OL\u0004\n\u0002OBA\u0003/ D exp.hL\u0004\nA/ exp.hL\u0004\nB/ exp.hL\u0004\nO/:\nIn this one dimensional example, we substitute\nZ D L\u0004\nA D \u0003p @\n@q;\nY D L\u0004\nB D U0.q/ @\n@p;\nX D L\u0004\nO D \n\b\nId C p @\n@p\n\t\nC \u00072\n2\n@2\n@p2 ;\ninto (7.18), where \u0007 D p2\nkBT. This gives us an expansion for the Kolmogorov\noperator for our discretized map\nOL\u0004\n\u0002OBA\u0003 D S D L\u0004\nA C L\u0004\nB C L\u0004\nO C h\n2\n\u0006\nŒL\u0004\nA; L\u0004\nB\t C ŒL\u0004\nA; L\u0004\nO\t C ŒL\u0004\nB; L\u0004\nO\t\n\u0007\nC : : :\nIt is clear that even writing out the O.h2/ terms considerably increases the\ncomplexity of the right hand side.\nThe commutators are best considered in relation to their action on a function (or\nrather, their action on a density) \u0005.q; p/. For example, we may compute directly\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003p @\n@q\n\b\nU0.q/@\u0005\n@p\n\t\n\u0003 U0.q/ @\n@p\n\b\n\u0003p@\u0005\n@q\n\t\nD \u0003p.U0.q/\u0005p/q C U0.q/.p\u0005q/p;\nD \u0003pU00.q/\u0005p \u0003 pU0.q/\u0005pq C U0.q/\u0005q C U0.q/p\u0005qp:\nAs this is the commutator of two 1st order differential operators, the mixed partial\nterm vanishes, leaving\nŒL\u0004\nA; L\u0004\nB\t\u0005 D \u0003pU00.q/\u0005p C U0.q/\u0005q:\n"
    },
    {
      "pdf_page": 310,
      "printed_page": 289,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n289\nSimilar computations give\nŒL\u0004\nA; L\u0004\nO\t\u0005 D \np\u0005q C \u00072\u0005qp;\nŒL\u0004\nB; L\u0004\nO\t\u0005 D \nU0.q/\u0005p:\nTo ﬁrst order, the discretization map corresponding to scheme \u0002OBA\u0003 alters the\nphase space density at each step as if it were solving the time dependent PDE\n\u0005t D OL\u0004\u0005;\nwhere\nOL\u0004\u0005DL\u0004\nLD\u0005 C h\n2\n\n\u0003pU00.q/\u0005p C U0.q/\u0005qC\np\u0005q C \u00072\u0005qp C \nU0.q/\u0005p\n\u000b\nC O.h2/:\nThe validity of this sort of expansion, even for small h, should be considered\ncarefully. Deﬁning\nL\u0004\nLD D L\u0004\nA C L\u0004\nB C L\u0004\nO\nas the Kolmogorov operator for Langevin dynamics, the assumption of validity\nbecomes more credible as we ﬁnd that the operator L\u0004\nLD has a compact resolvent and\ntherefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous\nchapter. It will have one zero eigenvalue corresponding to the invariant density \u0005ˇ\nand all the remaining eigenvalues lie in the negative half plane. Of course it is not\njust this operator whose properties are important, but also all the other operators\narising in the expansion, and bounding these in relation to L\u0004\nLD is not a simple task\n(particularly for higher orders).\n7.7.3\nPerturbation Technique\nSuppose we are able to derive a series expansion for OL\u0004 of the form\nOL\u0004 D L\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/;\nfor some perturbation operators L\u0004\ni . We assume that the invariant density has a\nsimilar expansion in powers of the stepsize, of the form given in (7.17). Inserting\nthis ansatz into the stationary Fokker-Planck equation\nOL\u0004 O\u0005 D 0;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。",
    "29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。"
  ],
  "issues": [],
  "statement_scope": "OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。",
  "lean_decl": "MD.Ch07.obaFirstCorrection",
  "lean_declarations": [
    "MD.Ch07.obaFirstCorrection",
    "MD.Ch07.obaFirstCorrection_commutators"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "FAIL",
      "suggested_fix": "增加OBA传播子与形式/弱修改生成元的关联及0、1阶系数结论；若主张O(h²)，还需注明余项采用的测试函数类与意义。",
      "actual_scope": "OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。",
      "signature_changed": false
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。"
  ]
}
```
```lean
def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring
```

## MD-7.7.2-SpectralQualification
```json
{
  "source_id": "MD-7.7.2-SpectralQualification",
  "kind": "definition",
  "label": null,
  "section": "7.7.2",
  "printed_page": "289",
  "pdf_page": "310",
  "statement_latex": "The assumption of validity becomes more credible as we find that the operator $\\mathcal L_{LD}^\\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\\rho_\\beta$ and all the remaining eigenvalues lie in the negative half plane.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 310,
      "printed_page": 289,
      "text": "7.7\nThe Evolution of the Distribution Using a Numerical Method\n289\nSimilar computations give\nŒL\u0004\nA; L\u0004\nO\t\u0005 D \np\u0005q C \u00072\u0005qp;\nŒL\u0004\nB; L\u0004\nO\t\u0005 D \nU0.q/\u0005p:\nTo ﬁrst order, the discretization map corresponding to scheme \u0002OBA\u0003 alters the\nphase space density at each step as if it were solving the time dependent PDE\n\u0005t D OL\u0004\u0005;\nwhere\nOL\u0004\u0005DL\u0004\nLD\u0005 C h\n2\n\n\u0003pU00.q/\u0005p C U0.q/\u0005qC\np\u0005q C \u00072\u0005qp C \nU0.q/\u0005p\n\u000b\nC O.h2/:\nThe validity of this sort of expansion, even for small h, should be considered\ncarefully. Deﬁning\nL\u0004\nLD D L\u0004\nA C L\u0004\nB C L\u0004\nO\nas the Kolmogorov operator for Langevin dynamics, the assumption of validity\nbecomes more credible as we ﬁnd that the operator L\u0004\nLD has a compact resolvent and\ntherefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous\nchapter. It will have one zero eigenvalue corresponding to the invariant density \u0005ˇ\nand all the remaining eigenvalues lie in the negative half plane. Of course it is not\njust this operator whose properties are important, but also all the other operators\narising in the expansion, and bounding these in relation to L\u0004\nLD is not a simple task\n(particularly for higher orders).\n7.7.3\nPerturbation Technique\nSuppose we are able to derive a series expansion for OL\u0004 of the form\nOL\u0004 D L\u0004\nLD C hL\u0004\n1 C h2L\u0004\n2 C O.h3/;\nfor some perturbation operators L\u0004\ni . We assume that the invariant density has a\nsimilar expansion in powers of the stepsize, of the form given in (7.17). Inserting\nthis ansatz into the stationary Fokker-Planck equation\nOL\u0004 O\u0005 D 0;\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。",
    "29号覆盖限定：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。"
  ],
  "issues": [
    "已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。"
  ],
  "statement_scope": "Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。",
  "lean_decl": "MD.Ch07.simpleEigenvalue",
  "lean_declarations": [
    "MD.Ch07.simpleEigenvalue",
    "MD.Ch07.printedSpectralConclusion",
    "MD.Ch07.spectralConclusionPrinted",
    "MD.Ch07.spectralConclusionPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [
    {
      "instruction": 29,
      "website_verdict": "NEEDS_HUMAN",
      "suggested_fix": "保留Printed文字版并注明simple的解释；修正版须区分完整谱、孤立性、有限代数重数和零谱点的单重性，在明确复Banach/Hilbert空间及闭生成元定义域后分别加资格，不把紧预解式单独当成负半平面谱或简单零谱的证明。",
      "actual_scope": "Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。",
      "signature_changed": true
    }
  ],
  "documented_priors": [],
  "coverage_gaps": [
    "只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。"
  ]
}
```
```lean
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)

def spectralConclusionPrinted {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop := printedSpectralConclusion L ρ

def spectralConclusionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧
  (∀ v : E, L v = 0 → v ∈ Submodule.span ℂ ({ρ} : Set E)) ∧
  ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    FiniteDimensional ℂ (Module.End.eigenspace L eigen) ∧ (eigen = 0 ∨ eigen.re < 0)
```
