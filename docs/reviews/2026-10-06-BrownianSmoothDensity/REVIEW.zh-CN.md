# Theorem 6.1：实际 Gibbs Hilbert 光滑周期定义域稠密性

原印刷250–251/PDF271–272已在前批核对。本批沿用同一actual unit torus、所有C∞整数周期实函数和已构造的actual normalized Gibbs probability。有限Nc、U C∞且integer periodic，β任意；稠密性不需要β正或质量条件，质量不参与本批结论。

mathlib的真实UnitAddTorus.mFourier在原Euclidean quotient lift上为有限coordinate exponential product，Complex.contDiff_exp的实际ℝ标量版本/coordinate evaluation给C∞。包含所有smooth Euclidean lift的实际complex ContinuousMap Submodule包含整个Fourier span，原mathlib span closure=top推其dense。实际Complex.reCLM.compLeftContinuous是连续满射，真实complexification是右逆，smoothness由real-part CLM composition保持，故所有real continuous torus smooth-lift函数dense。

原quotient projection对任意integer coordinate translation真正不变；torus smooth-lift函数g的lift g∘π属于前批全smooth periodic space，原chosen measurable representative_projects给其实际observable exactly=g。µProbability真正推finite，actual compact/pseudometrizable/Borel torus给weakRegular，因此ContinuousMap.toLp是真sameµ continuous linear map，actual denseRange由固定mathlib定理。AE equality/Lp.ext将每个real smooth torus continuous L²向量等同前批实际embedding向量，所以actual full smooth periodic embedding.range真正dense并closure=top，未假设density。

仍未完成closed/selfadjoint realization、compact resolvent/discrete spectrum/Poincare-gap/actual semigroup期待；原C²表述到合适closed realization需要单独处理；本批不能把dense+formal symmetry称为selfadjoint。全Theorem6.1及CORE_SCOPE未完成；负责人教材语义pending。

local01退出1：simp_rw链div_one无进展；CM Submodule membership需显式展开ContDiff；compLeftContinuous第一显式参数是标量ℝ，不能把Torus传作标量；real-part membership也需显式change。local02修这些后仅exp.restrict_scalars未决定中间标量，IsScalarTower stuck；固定Complex.contDiff_exp本身支持ℝ，用(𝕜:=ℝ)明确原定理，local03全候选退出0空日志/零警告。未加结论假设。失败日志保留；full-check01正式输入freeze，尚待统一验收。

full-check01 passed：9067jobs/1275公理声明/150exact inputs；10checks退出0，全部input/rawlog SHA256匹配，16public逐名只基础三公理，Lean警告0；Lean4.34.0/mathlib5ed2965；负责人semanticpending。
