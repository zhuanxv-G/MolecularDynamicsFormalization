# BATCH20 第7章原文与陈述审校

## MD-7.13-StabilityEnvelope
```json
{
  "source_id": "MD-7.13-StabilityEnvelope",
  "kind": "unnumbered_claim",
  "label": "(7.49)",
  "section": "7.13",
  "printed_page": "325",
  "pdf_page": "346",
  "statement_latex": "The oscillatory cosine term is bounded between $\\pm1$, implying that we have stability for all step sizes provided the condition\n\\[\\sqrt{1+h^2/\\widehat\\eta^2}\\le\\cosh(\\gamma h/2),\\tag{7.49}\\]\nholds. We have guaranteed stability where (7.49) holds, which we can simplify to\n\\[\\frac h{\\sqrt{4\\Omega^2-\\gamma^2}}\\le\\sinh(\\gamma h/2).\\]",
  "proof_latex": null,
  "proof_outline": "Bound the cosine by one; square nonnegative quantities and use cosh²-sinh²=1.",
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
    "“所有步长”指对每个h满足该条件；一次h的包络条件不能声称自动覆盖所有h。仍仅为谱模不超过1的充分条件，严格随机平稳性另需严格不等式。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.stabilityEnvelope",
  "lean_declarations": [
    "MD.Ch07.stabilityEnvelope",
    "MD.Ch07.stabilityEnvelope_sufficient",
    "MD.Ch07.stabilityEnvelope_iff"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def stabilityEnvelope (η γ h : ℝ) : Prop := Real.sqrt (1+h^2/η^2) ≤ Real.cosh (γ*h/2)
theorem stabilityEnvelope_sufficient (η γ h : ℝ) (he : stabilityEnvelope η γ h) :
    |underdampedPhasePrinted_corrected η h| ≤ Real.cosh (γ*h/2) := by
  dsimp [underdampedPhasePrinted_corrected]
  calc
    _ ≤ Real.sqrt (1+(h/η)^2)*1 := by
      rw [abs_mul,abs_of_nonneg (Real.sqrt_nonneg _)]
      exact mul_le_mul_of_nonneg_left (Real.abs_cos_le_one _) (Real.sqrt_nonneg _)
    _ = Real.sqrt (1+h^2/η^2) := by rw [div_pow,mul_one]
    _ ≤ _ := he
theorem stabilityEnvelope_iff (η γ h : ℝ) (hη : 0 < η) (hγ : 0 ≤ γ) (hh : 0 ≤ h) :
    stabilityEnvelope η γ h ↔ h/η ≤ Real.sinh (γ*h/2) := by
  sorry
```

## MD-7.13-FrictionThresholdPrinted
```json
{
  "source_id": "MD-7.13-FrictionThresholdPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.13",
  "printed_page": "325",
  "pdf_page": "346",
  "statement_latex": "The minimum required friction for stability can be found by considering the case of small timestep. This gives a bound\n\\[\\frac1{\\sqrt{4\\Omega^2-\\gamma^2}}\\le\\frac\\gamma2,\\]\nwhich gives a stability condition for all step sizes $h$ as long as\n\\[\\gamma\\ge\\Omega\\sqrt{2-2\\sqrt{1-\\Omega^{-4}}}\\ge\\sqrt2/\\Omega.\\]\nTherefore we expect that the minimum friction value required for stability for all timesteps $h>0$, scales with the value of inverse $\\Omega$.",
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
    "保留原精确根式，它本身与有理化修正版相同；疑误在后续比较方向/系数。欠阻尼上界γ<2Ω显式，不把该范围内的代数条件推广到任意大γ。",
    "所有h包络由sinh x≥x推出，严格稳定与随机矩界仍需另证。反例给出有理平方数值，完整根式代入识别未另证明。"
  ],
  "issues": [
    "已目视核对PDF346：最后链式下界√2/Ω不成立。将精确阈值有理化得√(2/(Ω²+√(Ω⁴-1)))，大Ω时约1/Ω；√2/Ω可作更保守的充分选择而非精确阈值下界。Ω²=5/4时精确阈值平方=1，小于2/Ω²=8/5。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.frictionThresholdPrinted",
  "lean_declarations": [
    "MD.Ch07.frictionThresholdPrinted",
    "MD.Ch07.frictionThresholdPrinted_corrected",
    "MD.Ch07.frictionBoundPrinted",
    "MD.Ch07.frictionBoundPrinted_corrected",
    "MD.Ch07.frictionThreshold_rationalized",
    "MD.Ch07.frictionThreshold_allSteps",
    "MD.Ch07.frictionThreshold_asymptotic",
    "MD.Ch07.frictionThreshold_squared_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def frictionThresholdPrinted (Ω : ℝ) : ℝ := Ω*Real.sqrt (2-2*Real.sqrt (1-Ω⁻¹^4))
def frictionThresholdPrinted_corrected (Ω : ℝ) : ℝ := Real.sqrt (2/(Ω^2+Real.sqrt (Ω^4-1)))
def frictionBoundPrinted (Ω γ : ℝ) : Prop :=
  frictionThresholdPrinted Ω ≤ γ ∧ Real.sqrt 2/Ω ≤ frictionThresholdPrinted Ω

def frictionBoundPrinted_corrected (Ω γ : ℝ) : Prop :=
  0 < γ ∧ γ < 2*Ω ∧ 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2

theorem frictionThreshold_rationalized (Ω : ℝ) (hΩ : 1 ≤ Ω) :
    frictionThresholdPrinted Ω = frictionThresholdPrinted_corrected Ω := by
  sorry
theorem frictionThreshold_allSteps (Ω γ : ℝ) (hΩ : 1 ≤ Ω) (hγ : 0 < γ) (hu : γ < 2*Ω)
    (hb : 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2) :
    ∀ h, 0 ≤ h → stabilityEnvelope (Real.sqrt (4*Ω^2-γ^2)) γ h := by
  sorry
theorem frictionThreshold_asymptotic :
    Filter.Tendsto (fun Ω : ℝ ↦ Ω*frictionThresholdPrinted_corrected Ω) Filter.atTop (𝓝 1) := by
  sorry
theorem frictionThreshold_squared_counterexample : (1 : ℝ) < 2/(5/4 : ℝ) := by norm_num
```

## MD-7.1-ConfigurationalSampling
```json
{
  "source_id": "MD-7.1-ConfigurationalSampling",
  "kind": "definition",
  "label": null,
  "section": "7.1",
  "printed_page": "262",
  "pdf_page": "283",
  "statement_latex": "we often only wish to know the average of a given function $\\phi(q)$ with respect the configurational density $\\exp(-\\beta U(q))$, where $U$ is the potential energy function of a molecular system.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 283,
      "printed_page": 262,
      "text": "262\n7\nNumerical Methods for Stochastic Molecular Dynamics\ndynamics information, but this may or may not be essential to the problem at hand:\nwe often only wish to know the average of a given function \b.q/ with respect the\nconﬁgurational density exp.\u0003ˇU.q//, where U is the potential energy function of a\nmolecular system. Nevertheless, Metropolis Monte-Carlo can encounter additional\nproblems in the setting of molecular modelling. Where steep potentials (Lennard-\nJones potentials, for example) and stiff bonds are present, Monte-Carlo methods\nmay experience a high rejection rate. From another perspective, the “interesting\nregion” for sampling a Gibbs distribution is an extremely small portion of the\naccessible phase space, since the measure of phase space is highly concentrated\nand localized by the inherent geometric constraints of the problem and/or steep\npotentials. As the dimensionality increases, the accessible phase space becomes\nthinner. A sampling algorithm must be guided from place to place in a large\ndimensional phase space riddled with steep barriers, and blind search typically leads\nto a lot of wasted effort. For this reason molecular dynamics, which beneﬁts from\nacceleration information (the forces) to guide timestepping, and for which every\nstep is accepted, is often superior to crude Monte-Carlo for molecular sampling.\nFor a comparative discussion of Monte-Carlo and molecular dynamics methods, see\n[6, 278].\nWe hasten to add that there are many situations in which Monte-Carlo methods\nhave the advantage. For example, we might have speciﬁc knowledge of a catalog\nof large scale structural “moves” that would allow our algorithm to scale energetic\nbarriers without drastically biasing the sampling outcome. An example is when an\nassembly consisting of several component macromolecules is moved by rearranging\nthe pieces, since it may take atomistic MD a very long time to make such moves. In\nthose cases we would likely wish to make use of the system-speciﬁc knowledge that\nwe have in order to accelerate the sampling. An alternative to assuming, a priori,\na detailed book of moves, is to consider methods that adaptively construct good\nproposals, for example taking advantage of parallel computing methods. At the very\nleast, one would expect that such methods need to take into consideration the local\nforces to avoid wasted steps. A practical way to do this is the Hybrid Monte-Carlo\nmethod mentioned in Appendix C.\nNote that deterministic methods (e.g. Hamiltonian dynamics itself) can some-\ntimes be used for molecular sampling, but without stochastic perturbation, such\nmethods are not rigorously ergodic, since the Liouvillian operator does not possess\na spectral gap and does not provide a unique stationary solution. The stochastic\nmethods of this chapter are general purpose techniques that require little in the\nway of system-speciﬁc knowledge. They are workhorse methods which provide\nrigorous control of the canonical distribution. The challenge in using Langevin\ndynamics is to design maximally efﬁcient methods that provide accurate averages\nfor a wide range of observables using as large stepsizes as possible, and which\nconverge as rapidly as possible. It is possible—even very easy—to build schemes\nthat are wasteful, for example subject to unnecessarily stringent numerical stability\nbarriers, and eliminating such mistakes is essential. This can be achieved by\ncareful attention to the principles by which integrators are designed. Well designed\nstochastic differential equation approaches introduce dissipation without destroying\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "原文省略归一常数；positionGibbs定义体保留实际配分积分。可积性与概率归一资格单列，不把未归一指数直接视为概率密度。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.configurationalSamplingAverage",
  "lean_declarations": [
    "MD.Ch07.configurationalSamplingAverage",
    "MD.Ch07.configurationalSamplingQualified"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def configurationalSamplingAverage (U φ : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, φ q ∂positionGibbs U β

def configurationalSamplingQualified (U φ : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧ Integrable φ (positionGibbs U β)
```

## MD-7.1-HamiltonianSamplingObstruction
```json
{
  "source_id": "MD-7.1-HamiltonianSamplingObstruction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.1",
  "printed_page": "262",
  "pdf_page": "283",
  "statement_latex": "Note that deterministic methods (e.g. Hamiltonian dynamics itself) can sometimes be used for molecular sampling, but without stochastic perturbation, such methods are not rigorously ergodic, since the Liouvillian operator does not possess a spectral gap and does not provide a unique stationary solution.",
  "proof_latex": null,
  "proof_outline": null,
  "proof_note": "原页推导与上下文全文见original_page_text；数学符号的排版以随附原页PDF为准。",
  "original_page_text": [
    {
      "pdf_page": 283,
      "printed_page": 262,
      "text": "262\n7\nNumerical Methods for Stochastic Molecular Dynamics\ndynamics information, but this may or may not be essential to the problem at hand:\nwe often only wish to know the average of a given function \b.q/ with respect the\nconﬁgurational density exp.\u0003ˇU.q//, where U is the potential energy function of a\nmolecular system. Nevertheless, Metropolis Monte-Carlo can encounter additional\nproblems in the setting of molecular modelling. Where steep potentials (Lennard-\nJones potentials, for example) and stiff bonds are present, Monte-Carlo methods\nmay experience a high rejection rate. From another perspective, the “interesting\nregion” for sampling a Gibbs distribution is an extremely small portion of the\naccessible phase space, since the measure of phase space is highly concentrated\nand localized by the inherent geometric constraints of the problem and/or steep\npotentials. As the dimensionality increases, the accessible phase space becomes\nthinner. A sampling algorithm must be guided from place to place in a large\ndimensional phase space riddled with steep barriers, and blind search typically leads\nto a lot of wasted effort. For this reason molecular dynamics, which beneﬁts from\nacceleration information (the forces) to guide timestepping, and for which every\nstep is accepted, is often superior to crude Monte-Carlo for molecular sampling.\nFor a comparative discussion of Monte-Carlo and molecular dynamics methods, see\n[6, 278].\nWe hasten to add that there are many situations in which Monte-Carlo methods\nhave the advantage. For example, we might have speciﬁc knowledge of a catalog\nof large scale structural “moves” that would allow our algorithm to scale energetic\nbarriers without drastically biasing the sampling outcome. An example is when an\nassembly consisting of several component macromolecules is moved by rearranging\nthe pieces, since it may take atomistic MD a very long time to make such moves. In\nthose cases we would likely wish to make use of the system-speciﬁc knowledge that\nwe have in order to accelerate the sampling. An alternative to assuming, a priori,\na detailed book of moves, is to consider methods that adaptively construct good\nproposals, for example taking advantage of parallel computing methods. At the very\nleast, one would expect that such methods need to take into consideration the local\nforces to avoid wasted steps. A practical way to do this is the Hybrid Monte-Carlo\nmethod mentioned in Appendix C.\nNote that deterministic methods (e.g. Hamiltonian dynamics itself) can some-\ntimes be used for molecular sampling, but without stochastic perturbation, such\nmethods are not rigorously ergodic, since the Liouvillian operator does not possess\na spectral gap and does not provide a unique stationary solution. The stochastic\nmethods of this chapter are general purpose techniques that require little in the\nway of system-speciﬁc knowledge. They are workhorse methods which provide\nrigorous control of the canonical distribution. The challenge in using Langevin\ndynamics is to design maximally efﬁcient methods that provide accurate averages\nfor a wide range of observables using as large stepsizes as possible, and which\nconverge as rapidly as possible. It is possible—even very easy—to build schemes\nthat are wasteful, for example subject to unnecessarily stringent numerical stability\nbarriers, and eliminating such mistakes is essential. This can be achieved by\ncareful attention to the principles by which integrators are designed. Well designed\nstochastic differential equation approaches introduce dissipation without destroying\n"
    }
  ],
  "transcription_note": "PDF文字层原样保留，陈述中的数学排版转写为LaTeX；文字层有特殊字形编码时以目视原页为准。PDF347的Exercises之后不在正文范围内。",
  "context_notation": [],
  "extra_assumptions": [
    "本条只证明保能流的能量子水平集不变；结合非平凡概率质量可形成遍历性障碍。能量壳上的遍历性不能由原句否定。",
    "原句未指定Liouvillian定义域、函数空间与参考概率。谱隙缺失和多个平稳解的完整算子陈述列为覆盖缺口，不把子水平集恒等式标作整段谱理论的证明。"
  ],
  "issues": [],
  "statement_scope": "保能流、非平凡不变集资格及不变集恒等式；原文的谱隙与平稳解主张仅逐字登记，尚缺明确函数空间后的完整陈述。",
  "lean_decl": "MD.Ch07.energyConservingFlow",
  "lean_declarations": [
    "MD.Ch07.energyConservingFlow",
    "MD.Ch07.energySublevel_invariant",
    "MD.Ch07.energyObstructionQualified"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def energyConservingFlow (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧ ∀ t x, H (F t x) = H x

theorem energySublevel_invariant (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n)
    (hf : energyConservingFlow H F) (a t : ℝ) :
    (F t) ⁻¹' {x | H x ≤ a} = {x | H x ≤ a} := by
  ext x
  change H (F t x) ≤ a ↔ H x ≤ a
  rw [hf.2.2 t x]

def energyObstructionQualified (μ : Measure (Phase n)) (H : Phase n → ℝ)
    (F : ℝ → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure μ ∧ energyConservingFlow H F ∧
    (∀ t, MeasurePreserving (F t) μ μ) ∧
    ∃ a, MeasurableSet {x | H x ≤ a} ∧ 0 < μ {x | H x ≤ a} ∧ μ {x | H x ≤ a} < 1
```
