# 第6章本地五步流程进度

范围：印刷p.211–258/PDF232–279，Exercises及参考文献排除；第1–5章冻结，正式库冻结，heartbeat ACTIVE/15分钟原样。
第6章本地部分完成；第6章等待用户提交MathCopilot批次；继续下一章本地流程。网站不可用，未冻结。
当前249条；旧清单映射126/126；本地PASS 219；网站返回0。

| source_id | JSON | Blueprint | 本地预审 | 网站审计 | 证明/状态 |
|---|---|---|---|---|---|
| MD-6.1.1-Microcanonical | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.2-Entropy | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.2-IndependentPartition | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.2-EntropyAdditivity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.2-EntropyEquilibrium | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.2-Temperature | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.2-InverseThermal | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.2-BathTaylor | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；热浴近似缺量化误差/热力学极限；本条不证明，不恢复封存长证明。 |
| MD-6.1.2-LogTemperature | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.2-BathMeanValue | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.2-BathTaylorEstimate | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；三条短证明路线失败，停止该条；保存证据见validation/short_search/BathTaylorEstimate.json。 |
| MD-6.1.2-BoltzmannConstantSlope | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.2-CanonicalCDFPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；原书启发式概率论证的ZA权重及热浴误差需人工裁定；不证明字面关系。 |
| MD-6.1.2-CanonicalEnergyDensity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.3-EntropyFunctional | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.3-ConstrainedEntropyModel | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.3-EntropyFirstVariation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺熵泛函沿紧支变分的微分积分交换；无现成桥接保留sorry，不展开大型变分理论。 |
| MD-6.1.3-EntropyVariation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺上一条泛函导数以及变分基本引理的真实包装；不以待证EL作假设。 |
| MD-6.1.3-CanonicalDensity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.3-MassHamiltonian | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.3-PartitionMass | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；现有正式公式只覆盖单位质量/周期模型；一般质量Gaussian乘积积分无现成完整桥接，保留sorry。 |
| MD-6.1.3-PartitionDomain | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待一般质量Gaussian有限积及实际Fubini分离；无现成完整桥接保留sorry。 |
| MD-6.1.3-FiniteDomainPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；有限域的边界/下界条件需补齐；不证明当前字面断言。 |
| MD-6.1.3-PeriodicPartitionBridge | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.3-ConfiningPartition | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺任意实p>0的径向尾部可积估计包装；不是周期紧域桥接能涵盖的一般结论，保留sorry。 |
| MD-6.1.3-LennardJonesNonintegrable | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；需q→∞时权重→1以及无穷半轴不可积的实际尾部比较；无现成完整桥接，保留sorry。 |
| MD-6.1.3-LennardJonesConfinement | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.3-PeriodicWeightIntegrable | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.3-PeriodicPartitionPositive | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.4-PolynomialObservable | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.4-CanonicalAveragePrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；式(6.4)重复Z⁻¹待人工审校；字面定义不作新证明。 |
| MD-6.1.4-CanonicalAverage | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.4-CanonicalAverageOne | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.5-Equipartition | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；现成单位质量Gaussian测度未打包任意质量的真实Phase积分归一化二阶矩；缺完整桥接，保留sorry。 |
| MD-6.1.5-ConfigurationalTemperature | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般配置空间加权IBP及具体G=∇U的完整包装；Prop6.1一般向量场桥接不直接等于本条，保留sorry。 |
| MD-6.1.5-Proposition61 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.5-WeightedFluxZero | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.5-CanonicalDivergenceIdentity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.5-TemperatureChoiceDerivatives | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待实际Fréchet有限和导数、正对角质量及坐标基计算；缺现成完整桥接保留sorry。 |
| MD-6.1.5-PeriodicBoundaryCancellation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.3-MeanEnergyConstraint | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.1.3-DensityNormalization | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.5-PartitionInversePrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；p.220的Zcan上标−1疑似笔误，待人工审校；不证明字面关系。 |
| MD-6.1.5-WeightedFluxIdentity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.1.5-VirialTemperature | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般质量相空间归一化到配置IBP的完整桥接；不将方向导数计算当作本条已证，保留sorry。 |
| MD-6.1.5-VirialFieldNotPeriodic | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.3-DensityPositive | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.1.5-KineticWeightFactorization | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.2-EnergySupportObstruction | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.2-CanonicalSamplingObstruction | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.2.1-RademacherJumps | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.1-RandomWalk | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.1-WalkRecurrence | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.2.1-WalkInitial | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.2.1-WalkVariance | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待Mathlib有限独立和二阶矩及Rademacher单位二阶矩短桥；缺项具体保留，不把标量CLT当作该证明。 |
| MD-6.2.1-DiffusiveWalk | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.1-InterpolatedWalk | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.1-WalkIncrement | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.1-WalkGridMoments | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；依赖有限独立中心和二阶矩短桥；不以连续插值的近似方差代替。 |
| MD-6.2.1-InterpolatedWalkMean | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待实际有限和零均值及线性插值积分短桥。 |
| MD-6.2.1-WalkDiffusion | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺Donsker函数空间不变性原理及tightness；不建立大型概率路径理论，保留完整sorry。 |
| MD-6.2.1-WienerVector | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.1-WienerIncrement | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.2.1-WienerContinuousVersion | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待现成Kolmogorov连续修改桥接；若无完整桥接，不重建概率路径理论；给定连续模型的路径值封装另列[EXTRA]。 |
| MD-6.2.1-WienerNondifferentiable | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺Brownian路径振荡与处处不可微理论；不建大型路径理论，保留完整sorry。 |
| MD-6.2.1-WienerFutureCompletedHistory | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.1-GridWienerIncrementLaw | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.1-GridIncrementIndependent | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.1-WienerContinuousPathEval | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.1-WienerContinuousPathMeasurable | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.1-CoarseMarkovPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；不证明粗条件概率字面式；完整当前状态条件期望资格另条定义，现成未来独立桥保留。 |
| MD-6.2.1-StateMarkovMeaning | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-RiemannTags | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待现成带任意标记的Riemann求积完整桥接；不建立积分构造理论。 |
| MD-6.2.2-ItoLeftSum | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-StrictItoIntegral | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-WeakItoAlias | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；保留原正式库定义签名冻结；本地严格L²定义另列，严格模型用于后续新陈述。 |
| MD-6.2.2-StratonovichSum | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-SelfItoFiniteIdentity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-Proposition62 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-MeanSquareConvergence | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-WienerMidpointSum | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-GaussianIncrementMean | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-GaussianIncrementSecond | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-GaussianIncrementFourth | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-QuadraticMeanSquareError | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-SelfItoIntegral | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-SelfStratonovichIntegral | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-Proposition63 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-QuadraticSumExpectation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-SelfItoLimitL2 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-SelfItoSumsL2 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-MidpointSumsL2 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.2.2-DeterministicIntegralProcess | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.2.2-DeterministicStrobePrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；待网站审计原σ参数意图；完整独立增量更正陈述另列。 |
| MD-6.2.2-DeterministicStrobeCorrected | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；现成Prop6.3只打包单时构造；缺同一积分过程全部区间联合Gaussian/独立增量桥接，保留完整sorry。 |
| MD-6.2.2-StochasticDifferentialIntegral | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3-BiasedWalk | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3-BiasedWalkSum | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.3-ScalarSDE | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3-VectorSDE | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.1-ScalarItoFormula | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般随机Ito链式法则；不建大型理论，保留完整sorry。 |
| MD-6.3.1-DiffusiveTaylorPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；不证明C²的错误阶数；完整Ito公式另条保存，不恢复封存长证明。 |
| MD-6.3.1-TimeItoFormula | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；缺一般时空Ito链式法则；完整更正积分式保留sorry。 |
| MD-6.3-BiasedWalkDiffusion | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺状态依赖Euler随机游走扩散极限及强解存在桥接；不建设大型随机理论。 |
| MD-6.3.2-OUProcess | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.2-OUIntegratingFactor | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺严格OU方程与现成确定积分构造的完整变常数/唯一性桥接；不恢复长证明。 |
| MD-6.3.2-OUVarianceIntegral | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.3.2-OULawPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；不证明印刷漏根号分布；完整更正单时law另列，不将独立边际当同一OU过程。 |
| MD-6.3.2-OULawCorrect | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺严格OU变常数与积分法则的完整桥接；Prop6.3现成单独结果不等于本条。 |
| MD-6.3.2-OUGibbsLimit | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待Gaussian law参数连续性与指数极限完整短桥；现成一般Gaussian连续性可复用，保留未核桥接。 |
| MD-6.3.2-MomentumOU | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.2-GibbsGaussianDensity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-BathHamiltonian | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-BathHamiltonEquations | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；待真实Fréchet有限和导数桥接；不恢复封存长证明。 |
| MD-6.3.3-BathFrequency | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-BathOscillatorSolution | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺现成受迫振子变常数解完整桥接；不恢复封存证明。 |
| MD-6.3.3-BathConvolutionIBP | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；三条短证明路线失败，停止该条；保存证据见validation/short_search/BathConvolutionIBP.json。 |
| MD-6.3.3-BathForce | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-BathForcePrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；保留字面负号，导师/网站待裁定；完整两种约化陈述下一批保留。 |
| MD-6.3.3-MemoryKernel | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-BathReduction | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺受迫振子解及卷积IBP的完整组合桥接；不恢复封存长证明。 |
| MD-6.3.3-BathReductionPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；不证明符号疑误；网站/导师待裁定。 |
| MD-6.3.3-MemoryKernelDeltaMeaning | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；缺具体热浴谱/初值法则、白噪声极限及严格Langevin导出理论；原书也明确略去，不建设。 |
| MD-6.3.3-ScalarLangevin | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-MassLangevin | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-VariableFriction | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-ParticleDiagonalFriction | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.4-BrownianMassModel | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-FrequencyMemoryKernel | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-Figure64Frequencies | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-Figure65Frequencies | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-BathForceWeakLimitMeaning | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；缺精确热浴初始化/谱条件及white-force或integrated-force极限解释；保留疑误，不建大型弱收敛理论。 |
| MD-6.3.4-OverdampedLimit | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般正质量Kramers–Smoluchowski极限理论；不恢复封存长证明，不建设大型理论。 |
| MD-6.3.5-ScalarGenerator | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.5-GeneratorExpectation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺Ito链式法则与期望求导/鞅零均值完整桥接。 |
| MD-6.3.6-PolynomialSmooth | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.6-DensityExpectation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺多项式乘指数尾积分及withDensity实积分的完整打包桥接。 |
| MD-6.3.6-ScalarForward | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.6-FPDriftAdjoint | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.3.6-FPDiffusionPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；不证明错误负号；正号完整伴随式另批保留。 |
| MD-6.3.6-FPAdjointCompact | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.3.6-FPPolynomialAdjoint | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺完整指数尾IBP打包；不以边界通量消失本身作假设。 |
| MD-6.3.6-FPEquation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般Ito鞅期望、真实law到弱方程与测试函数基本引理完整桥接。 |
| MD-6.3.6-ZeroNoise | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.3.7-VectorIto | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般多维Ito公式完整桥接。 |
| MD-6.3.7-VectorForward | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.7-DiffusionTrace | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.3.7-VectorFPEquation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺多维Ito/鞅期望及真实law到强Fokker–Planck完整桥接。 |
| MD-6.3.8-LangevinMassForward | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.8-MomentumMassLaplacian | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.8-LangevinFPEquation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般质量Langevin law的完整Fokker–Planck桥接；单位质量形式算子不是过程密度PDE证明。 |
| MD-6.4.2-MassGibbsStationary | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；现成单位质量表达已证，任意质量坐标包装尚缺短桥；实际过程不变另条。 |
| MD-6.4.2-UnitMassGibbsStationaryBridge | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.3.3-VariableFrictionForward | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.3.3-VariableFrictionCanonicalPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；等待网站/导师明确Γ与M的交换或正确漂移；不证明一般错误stationarity，更不伪造采样收敛。 |
| MD-6.3.3-VariableFrictionCommutingStationary | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺任意质量/矩阵交换的完整坐标涨落耗散代数打包；不建设一般随机理论。 |
| MD-6.4.1-StochasticMatrix | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-FiniteDistribution | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-FiniteEvolution | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-FiniteEvolutionRecurrence | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.1-ReturnTimes | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-Period | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-Aperiodic | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-Irreducible | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-FiniteInvariant | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-FiniteErgodicity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺现成有限非负随机矩阵Perron–Frobenius/primitive极限完整打包桥接；不建设大型理论。 |
| MD-6.4.1-StochasticEntryBound | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.1-FiniteChainExample | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-ExampleStochastic | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.1-ExampleNotIrreducible | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.1-Communicates | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.1-DirectedGraphIrreducible | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺非负矩阵幂正项与有向路径的完整有限求和桥接；不建设一般PF理论。 |
| MD-6.4.2-CylinderCoordinates | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.2-CylinderSDE | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.2-CylinderGenerator | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.2-CylinderForwardPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；网站/导师待裁定印刷φ/ρ笔误。 |
| MD-6.4.2-StationaryDensity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.2-StationaryInvariant | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺抽象generator域与求导换积分/测度分离的完整短桥；不建一般半群理论。 |
| MD-6.4-CanonicalMixingMeaning | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.2-LangevinCanonicalMixing | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺完整原Langevin正密度/Harris/kernel混合验收桥接；不恢复封存的Theorem6.2长证明。 |
| MD-6.4.3-BrownianGenerator | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.3-BrownianWeightedInner | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.3-BrownianDirichlet | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianSymmetry | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianNonpositive | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianRealEigenvalue | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianClosedSelfAdjoint | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianCompactResolvent | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianDiscreteSpectrum | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianSpectralGap | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-Theorem61 | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；无现成整个原Thm6.1域/严格负定/时间平均完整桥接；保持sorry，不恢复封存长证明。各已证子条款单独登记。 |
| MD-6.4.3-Theorem61TimeAveragePrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；原时间平均/演化分布平均冲突待导师；不证明字面指数轨道界。 |
| MD-6.4.3-BrownianEnsembleExponential | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.3-BrownianNegativeDefinitePrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；字面严格负定被常数核反驳，不能证明。 |
| MD-6.4.2-OUDensityPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；字面式只为未归一权重；不证明它是概率密度。 |
| MD-6.4.2-OUDensityCorrect | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-Assumption1Printed | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；保留原包含t=0的字面资格；不证明当前物理扩散满足它。 |
| MD-6.4.4-Assumption1Correct | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-Assumption2 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-MinorizationPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；原等价适用对象/密度和时间域需导师；保留完整双向字面陈述。 |
| MD-6.4.4-MinorizationCorrectedImplication | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺真实kernel小集/联合连续密度的完整组合桥接；不建立一般Harris理论。 |
| MD-6.4.4-Theorem62 | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；没有现成完整Thm6.2桥接；保持sorry，不恢复封存Harris长证明或构建缺失大型理论。 |
| MD-6.4.4-PeriodicPotentialBound | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-PotentialNormalization | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-UnitLangevinModel | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-PeriodicConfiningPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | definition / incomplete；原周期/配置围束条件须导师签核，实际H^l在动量无穷远的proper结论另列。 |
| MD-6.4.4-HamiltonianPower | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-HamiltonianPowerCancellation | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-HamiltonianPowerMomentumDerivative | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.4-HamiltonianPowerMomentumLaplacian | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LaplacianBoundPrinted | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；保留字面错误不等式，不能证明；正确完整上界另条。 |
| MD-6.4.4-LaplacianBoundCounterexample | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-HamiltonianPowerGenerator | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LaplacianBoundCorrect | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LyapunovYoungBounds | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.4-LangevinLyapunov | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LieBracket | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-LieBracketProperties | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.4-Definition61 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-LangevinFields | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-LangevinNoiseBracket | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LangevinBracketIndependent | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LangevinHormander | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LangevinTransitionDensity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺实际Langevin hypoelliptic/Malliavin转移密度存在桥接；不建设大型理论。 |
| MD-6.4.4-Lemma61Printed | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；保留原缺非空的完整字面断言，不证；下一条桥接原单位周期实际过程的完整非空版本。 |
| MD-6.4.4-Lemma61Nonempty | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-ControlPath | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-ControlEndpointStable | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-WienerControlTube | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LangevinCanonicalStationary | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-LangevinGeometricErgodicity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺实际transition density、Harris/minorization及canonical invariance完整桥接；保留sorry，不恢复Thm6.2封存长证明。 |
| MD-6.4.4-LangevinTimeAverage | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺实际canonical唯一不变/遍历及weighted观测量强大数桥接；不建设大型理论。 |
| MD-6.4.4-WeightedH1 | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-WeightedH1Norm | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | existing_bridge / checked+documented priors |
| MD-6.4.4-Proposition64Printed | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；无现成整条桥接；不恢复封存Prop6.4长证明，保留sorry。 |
| MD-6.4.4-Proposition64Relative | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺实际加权adjoint域、compact resolvent与rough kernel；无现成整条桥接保留sorry，封存不恢复。 |
| MD-6.4.4-FredholmAlternative | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺一般closed partialoperator的Fredholm alternative现成完整桥接；不建设大型谱理论。 |
| MD-6.4.4-BackwardKernelConstants | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；rough加权Hilbert generator kernel尚缺完整桥接；CanonicalKernelConstant封存长证明不恢复。 |
| MD-6.4.4-ForwardKernelGibbs | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺flat forward弱域与实际adjoint/relative坐标转换、kernel识别；不恢复封存长证明。 |
| MD-6.4.4-WeightedFunctionNorm | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.4-WeightedVectorNorm | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.5-KernelEvolution | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.5-KernelAverage | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.5-DensityEvolutionMeaning | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.5-KernelDuality | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | local_proof / self-contained |
| MD-6.4.5-SmoothTestL2Printed | DRAFT/原页已核 | 已编译/公理已核 | NEEDS_HUMAN | 待网站审计 | placeholder / incomplete；不证明错误自动可积断言；下面完整衰减保留真实L²检验资格。 |
| MD-6.4.5-ComplexInitialDensity | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.5-LangevinForwardSemigroupMeaning | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | definition / self-contained |
| MD-6.4.5-ComplexEigenmodeDecay | DRAFT/原页已核 | 已编译/公理已核 | PASS | 待网站审计 | placeholder / incomplete；缺复C0生成元本征模式的现成完整桥接及实际Langevin forward semigroup识别；不建设大型谱/半群理论。 |

## 旧126条完整映射

| 旧id | 新source_id或当前缺项 |
|---|---|
| CH06-001 | MD-6.1.1-Microcanonical |
| CH06-002 | MD-6.1.2-Entropy |
| CH06-003 | MD-6.1.2-EntropyAdditivity |
| CH06-004 | MD-6.1.2-EntropyEquilibrium |
| CH06-005 | MD-6.1.2-LogTemperature |
| CH06-006 | MD-6.1.2-LogTemperature |
| CH06-007 | MD-6.1.2-BoltzmannConstantSlope |
| CH06-008 | MD-6.1.2-CanonicalEnergyDensity |
| CH06-009 | MD-6.1.3-ConstrainedEntropyModel |
| CH06-010 | MD-6.1.3-MeanEnergyConstraint |
| CH06-011 | MD-6.1.3-DensityPositive |
| CH06-012 | MD-6.1.3-PeriodicPartitionBridge |
| CH06-013 | MD-6.1.3-PeriodicPartitionPositive |
| CH06-014 | MD-6.1.3-ConfiningPartition |
| CH06-015 | MD-6.1.4-PolynomialObservable |
| CH06-016 | MD-6.1.4-CanonicalAverage |
| CH06-017 | MD-6.1.4-CanonicalAverageOne |
| CH06-018 | MD-6.1.5-KineticWeightFactorization |
| CH06-019 | MD-6.1.5-ConfigurationalTemperature |
| CH06-020 | MD-6.1.5-Proposition61 |
| CH06-021 | MD-6.1.5-WeightedFluxIdentity |
| CH06-022 | MD-6.1.5-VirialFieldNotPeriodic |
| CH06-023 | MD-6.1.5-PeriodicBoundaryCancellation |
| CH06-024 | MD-6.2-CanonicalSamplingObstruction |
| CH06-025 | MD-6.2.1-WalkIncrement |
| CH06-026 | MD-6.2.1-WalkRecurrence |
| CH06-027 | MD-6.2.1-WalkVariance |
| CH06-028 | MD-6.2.1-WalkIncrement |
| CH06-029 | MD-6.2.1-WalkGridMoments |
| CH06-030 | MD-6.2.1-WalkDiffusion |
| CH06-031 | MD-6.2.1-WienerVector |
| CH06-032 | MD-6.2.1-GridIncrementIndependent |
| CH06-033 | MD-6.2.1-WienerContinuousPathMeasurable |
| CH06-034 | MD-6.2.1-WienerNondifferentiable |
| CH06-035 | MD-6.2.1-StateMarkovMeaning |
| CH06-036 | MD-6.2.2-WeakItoAlias |
| CH06-037 | MD-6.2.2-WienerMidpointSum |
| CH06-038 | MD-6.2.2-SelfItoFiniteIdentity |
| CH06-039 | MD-6.2.2-QuadraticSumExpectation |
| CH06-040 | MD-6.2.2-GaussianIncrementFourth |
| CH06-041 | MD-6.2.2-QuadraticMeanSquareError |
| CH06-042 | MD-6.2.2-SelfItoSumsL2 |
| CH06-043 | MD-6.2.2-MidpointSumsL2 |
| CH06-044 | MD-6.2.2-DeterministicStrobeCorrected |
| CH06-045 | MD-6.2.2-StochasticDifferentialIntegral |
| CH06-046 | MD-6.3-BiasedWalkDiffusion |
| CH06-047 | MD-6.3-BiasedWalkDiffusion |
| CH06-048 | MD-6.3-VectorSDE |
| CH06-049 | MD-6.3.1-DiffusiveTaylorPrinted |
| CH06-050 | MD-6.3.1-TimeItoFormula |
| CH06-051 | MD-6.3.2-OUProcess |
| CH06-052 | MD-6.3.2-OUIntegratingFactor |
| CH06-053 | MD-6.3.2-OULawCorrect |
| CH06-054 | MD-6.3.2-GibbsGaussianDensity |
| CH06-055 | MD-6.3.2-MomentumOU |
| CH06-056 | MD-6.3.3-BathHamiltonian |
| CH06-057 | MD-6.3.3-BathHamiltonEquations |
| CH06-058 | MD-6.3.3-BathOscillatorSolution |
| CH06-059 | MD-6.3.3-BathConvolutionIBP |
| CH06-060 | MD-6.3.3-BathReductionPrinted |
| CH06-061 | MD-6.3.3-Figure64Frequencies |
| CH06-062 | MD-6.3.3-BathForceWeakLimitMeaning |
| CH06-063 | MD-6.3.3-MassLangevin |
| CH06-064 | MD-6.3.3-VariableFrictionCommutingStationary |
| CH06-065 | MD-6.3.4-OverdampedLimit |
| CH06-066 | MD-6.3.5-GeneratorExpectation |
| CH06-067 | MD-6.3.5-ScalarGenerator |
| CH06-068 | MD-6.3.6-DensityExpectation |
| CH06-069 | MD-6.3.6-FPPolynomialAdjoint |
| CH06-070 | MD-6.3.6-FPPolynomialAdjoint |
| CH06-071 | MD-6.3.6-FPPolynomialAdjoint |
| CH06-072 | MD-6.3.6-FPEquation |
| CH06-073 | MD-6.3.6-ZeroNoise |
| CH06-074 | MD-6.3.7-VectorIto |
| CH06-075 | MD-6.3.7-VectorFPEquation |
| CH06-076 | MD-6.3.7-DiffusionTrace |
| CH06-077 | MD-6.3.8-LangevinFPEquation |
| CH06-078 | MD-6.4.1-StochasticEntryBound |
| CH06-079 | MD-6.4.1-FiniteEvolutionRecurrence |
| CH06-080 | MD-6.4.1-Aperiodic |
| CH06-081 | MD-6.4.1-DirectedGraphIrreducible |
| CH06-082 | MD-6.4.1-FiniteErgodicity |
| CH06-083 | MD-6.4.2-CylinderForwardPrinted |
| CH06-084 | MD-6.4.2-StationaryInvariant |
| CH06-085 | MD-6.4.2-LangevinCanonicalMixing |
| CH06-086 | MD-6.4.2-OUDensityCorrect |
| CH06-087 | MD-6.4.3-BrownianGenerator |
| CH06-088 | MD-6.4.3-BrownianWeightedInner |
| CH06-089 | MD-6.4.3-BrownianSymmetry |
| CH06-090 | MD-6.4.3-BrownianNegativeDefinitePrinted |
| CH06-091 | MD-6.4.3-BrownianClosedSelfAdjoint |
| CH06-092 | MD-6.4.3-BrownianDiscreteSpectrum |
| CH06-093 | MD-6.4.3-BrownianNegativeDefinitePrinted |
| CH06-094 | MD-6.4.3-BrownianSpectralGap |
| CH06-095 | MD-6.4.3-BrownianEnsembleExponential |
| CH06-096 | MD-6.4.4-Assumption1Correct |
| CH06-097 | MD-6.4.4-Assumption2 |
| CH06-098 | MD-6.4.4-MinorizationCorrectedImplication |
| CH06-099 | MD-6.4.4-Theorem62 |
| CH06-100 | MD-6.4.4-PeriodicConfiningPrinted |
| CH06-101 | MD-6.4.4-HamiltonianPower |
| CH06-102 | MD-6.4.4-HamiltonianPowerGenerator |
| CH06-103 | MD-6.4.4-LaplacianBoundCorrect |
| CH06-104 | MD-6.4.4-LaplacianBoundCorrect |
| CH06-105 | MD-6.4.4-LangevinLyapunov |
| CH06-106 | MD-6.4.4-LieBracket |
| CH06-107 | MD-6.4.4-LieBracketProperties |
| CH06-108 | MD-6.4.4-Definition61 |
| CH06-109 | MD-6.4.4-LangevinFields |
| CH06-110 | MD-6.4.4-LangevinBracketIndependent |
| CH06-111 | MD-6.4.4-LangevinHormander |
| CH06-112 | MD-6.4.4-LangevinTransitionDensity |
| CH06-113 | MD-6.4.4-Lemma61Nonempty |
| CH06-114 | MD-6.4.4-ControlPath |
| CH06-115 | MD-6.4.4-ControlEndpointStable |
| CH06-116 | MD-6.4.4-WienerControlTube |
| CH06-117 | MD-6.4.4-LangevinCanonicalStationary |
| CH06-118 | MD-6.4.4-LangevinTimeAverage |
| CH06-119 | MD-6.4.4-WeightedFunctionNorm |
| CH06-120 | MD-6.4.4-WeightedVectorNorm |
| CH06-121 | MD-6.4.4-Proposition64Relative |
| CH06-122 | MD-6.4.4-FredholmAlternative |
| CH06-123 | MD-6.4.4-ForwardKernelGibbs |
| CH06-124 | MD-6.4.5-LangevinForwardSemigroupMeaning |
| CH06-125 | MD-6.4.5-KernelDuality |
| CH06-126 | MD-6.4.5-ComplexEigenmodeDecay |

## NEEDS_HUMAN / [ERRATUM?] / 缺理论

- MD-6.1.2-BathTaylor：保留均值定理与精确Boltzmann因子的完整印刷论证；固定能量导数不推出所有中间点导数恒定，不能把精确关系计为本地PASS。严格均值定理/局部Taylor余项另列[EXTRA]。 热浴近似缺量化误差/热力学极限；本条不证明，不恢复封存长证明。[ERRATUM?]原书脚注3承认热浴推导不精确；S′(ξ)=1/T通常只能作为大热浴近似，完整精确Boltzmann因子保留字面NEEDS_HUMAN。
- MD-6.1.2-BathTaylorEstimate：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 三条短证明路线失败，停止该条；保存证据见validation/short_search/BathTaylorEstimate.json。
- MD-6.1.2-CanonicalCDFPrinted：保留与真实分别计数的能量CDF相比较的字面关系；不从启发式省略权重伪造精确概率定律。 原书启发式概率论证的ZA权重及热浴误差需人工裁定；不证明字面关系。[ERRATUM?]页末能量密度含ZA(α)，此前CDF却省略ZA(s)权重；一般ZA下两归一化CDF不相等。
- MD-6.1.3-EntropyFirstVariation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺熵泛函沿紧支变分的微分积分交换；无现成桥接保留sorry，不展开大型变分理论。
- MD-6.1.3-EntropyVariation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺上一条泛函导数以及变分基本引理的真实包装；不以待证EL作假设。
- MD-6.1.3-PartitionMass：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 现有正式公式只覆盖单位质量/周期模型；一般质量Gaussian乘积积分无现成完整桥接，保留sorry。
- MD-6.1.3-PartitionDomain：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待一般质量Gaussian有限积及实际Fubini分离；无现成完整桥接保留sorry。
- MD-6.1.3-FiniteDomainPrinted：字面资格保留，不从内部光滑偷推有界，也不假设目标可积性。真实周期特例另列。 有限域的边界/下界条件需补齐；不证明当前字面断言。[ERRATUM?]仅有限体积、Q内部光滑不足以排除趋向边界的U→−∞；需要下界、紧域上的连续性或权重可积性。
- MD-6.1.3-ConfiningPartition：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺任意实p>0的径向尾部可积估计包装；不是周期紧域桥接能涵盖的一般结论，保留sorry。
- MD-6.1.3-LennardJonesNonintegrable：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 需q→∞时权重→1以及无穷半轴不可积的实际尾部比较；无现成完整桥接，保留sorry。
- MD-6.1.4-CanonicalAveragePrinted：完整字面定义保留；重复归一化疑点尚未裁定，不把该定义计为标准概率平均。标准版独立记录。 式(6.4)重复Z⁻¹待人工审校；字面定义不作新证明。[ERRATUM?]式(6.3)的ρβ已含Zcan⁻¹，式(6.4)再乘一次导致Avβ(1)=Zcan⁻¹，而后文p.221使用标准归一化平均。
- MD-6.1.5-Equipartition：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 现成单位质量Gaussian测度未打包任意质量的真实Phase积分归一化二阶矩；缺完整桥接，保留sorry。
- MD-6.1.5-ConfigurationalTemperature：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般配置空间加权IBP及具体G=∇U的完整包装；Prop6.1一般向量场桥接不直接等于本条，保留sorry。
- MD-6.1.5-TemperatureChoiceDerivatives：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待实际Fréchet有限和导数、正对角质量及坐标基计算；缺现成完整桥接保留sorry。
- MD-6.1.5-PartitionInversePrinted：不默改原式、不从可积性偷推partition=1；保留不成立的字面反转等式。 p.220的Zcan上标−1疑似笔误，待人工审校；不证明字面关系。[ERRATUM?]此页印刷Zcan⁻¹=积分，与p.218的Zcan=积分相反；字面保留，标准DensityNormalization仍按真实积分归一化。
- MD-6.1.5-VirialTemperature：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般质量相空间归一化到配置IBP的完整桥接；不将方向导数计算当作本条已证，保留sorry。
- MD-6.2.1-WalkVariance：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待Mathlib有限独立和二阶矩及Rademacher单位二阶矩短桥；缺项具体保留，不把标量CLT当作该证明。
- MD-6.2.1-WalkGridMoments：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 依赖有限独立中心和二阶矩短桥；不以连续插值的近似方差代替。
- MD-6.2.1-InterpolatedWalkMean：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待实际有限和零均值及线性插值积分短桥。
- MD-6.2.1-WalkDiffusion：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺Donsker函数空间不变性原理及tightness；不建立大型概率路径理论，保留完整sorry。
- MD-6.2.1-WienerContinuousVersion：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待现成Kolmogorov连续修改桥接；若无完整桥接，不重建概率路径理论；给定连续模型的路径值封装另列[EXTRA]。
- MD-6.2.1-WienerNondifferentiable：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺Brownian路径振荡与处处不可微理论；不建大型路径理论，保留完整sorry。
- MD-6.2.1-CoarseMarkovPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 不证明粗条件概率字面式；完整当前状态条件期望资格另条定义，现成未来独立桥保留。印刷用任意粗事件B(X(t0))替代完整当前状态的条件σ代数；一般不成立，例如B=univ时过去事件仍可影响未来。
- MD-6.2.2-RiemannTags：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待现成带任意标记的Riemann求积完整桥接；不建立积分构造理论。
- MD-6.2.2-WeakItoAlias：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 保留原正式库定义签名冻结；本地严格L²定义另列，严格模型用于后续新陈述。既有Review定义仅要求Y∈L²及误差Bochner积分收敛，未要求各有限和L²，非可积默认积分0会掩盖错误；不得用于新PASS SDE证明。
- MD-6.2.2-Proposition62：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 印刷证明的独立交叉项展开带负号；平方展开应正号，见单独疑误条。
- MD-6.2.2-DeterministicStrobePrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待网站审计原σ参数意图；完整独立增量更正陈述另列。生成增量使用σ(tn)而非相邻时刻方差差；单时边际法则也不能确定同一过程联合分布。保持印刷式，不以独立边际偷换过程。
- MD-6.2.2-DeterministicStrobeCorrected：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 现成Prop6.3只打包单时构造；缺同一积分过程全部区间联合Gaussian/独立增量桥接，保留完整sorry。
- MD-6.3.1-ScalarItoFormula：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般随机Ito链式法则；不建大型理论，保留完整sorry。
- MD-6.3.1-DiffusiveTaylorPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 不证明C²的错误阶数；完整Ito公式另条保存，不恢复封存长证明。C² Taylor余项仅o(h²)，不能自动提升为O(h³)；在h≈√δt时原O(δt³⁄²)需要更高阶正则性。
- MD-6.3.1-TimeItoFormula：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般时空Ito链式法则；完整更正积分式保留sorry。印刷φ_t(X,t)项漏dt，字面微分式不具一致类型；补dt需要网站审计裁定。
- MD-6.3-BiasedWalkDiffusion：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺状态依赖Euler随机游走扩散极限及强解存在桥接；不建设大型随机理论。
- MD-6.3.2-OUIntegratingFactor：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺严格OU方程与现成确定积分构造的完整变常数/唯一性桥接；不恢复长证明。
- MD-6.3.2-OULawPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 不证明印刷漏根号分布；完整更正单时law另列，不将独立边际当同一OU过程。原页根号只覆盖(2γ)⁻¹，(1−e⁻²γt)漏在根号内；方差因此被错误平方。单时分布等价不确定整个过程耦合。
- MD-6.3.2-OULawCorrect：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺严格OU变常数与积分法则的完整桥接；Prop6.3现成单独结果不等于本条。
- MD-6.3.2-OUGibbsLimit：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待Gaussian law参数连续性与指数极限完整短桥；现成一般Gaussian连续性可复用，保留未核桥接。
- MD-6.3.3-BathHamiltonEquations：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 待真实Fréchet有限和导数桥接；不恢复封存长证明。
- MD-6.3.3-BathOscillatorSolution：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺现成受迫振子变常数解完整桥接；不恢复封存证明。
- MD-6.3.3-BathConvolutionIBP：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 三条短证明路线失败，停止该条；保存证据见validation/short_search/BathConvolutionIBP.json。
- MD-6.3.3-BathForcePrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 保留字面负号，导师/网站待裁定；完整两种约化陈述下一批保留。印刷f含负k⁻¹，而(6.29)写+f；从(6.23)代入振子解得到正k⁻¹合力。
- MD-6.3.3-BathReduction：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺受迫振子解及卷积IBP的完整组合桥接；不恢复封存长证明。
- MD-6.3.3-BathReductionPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 不证明符号疑误；网站/导师待裁定。原负f与+f约化式符号冲突；保留完整字面卷积方程。
- MD-6.3.3-MemoryKernelDeltaMeaning：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺具体热浴谱/初值法则、白噪声极限及严格Langevin导出理论；原书也明确略去，不建设。原“sufficient high frequency/typically”没有给频率序列、归一化、热浴初值法则及白噪声弱收敛资格，不能声明任意热浴自动满足δ极限。
- MD-6.3.3-BathForceWeakLimitMeaning：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺精确热浴初始化/谱条件及white-force或integrated-force极限解释；保留疑误，不建大型弱收敛理论。原many choices没有给热浴初值法则/频率条件/拓扑；此处f像Wiener process、下页f(t)作为Wiener increment还存在力与积分过程的类型疑问。
- MD-6.3.4-OverdampedLimit：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般正质量Kramers–Smoluchowski极限理论；不恢复封存长证明，不建设大型理论。
- MD-6.3.5-GeneratorExpectation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺Ito链式法则与期望求导/鞅零均值完整桥接。
- MD-6.3.6-DensityExpectation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺多项式乘指数尾积分及withDensity实积分的完整打包桥接。
- MD-6.3.6-FPDiffusionPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 不证明错误负号；正号完整伴随式另批保留。原页两次IBP后仍打印负号；正确应正号，且(6.39)最终算子已经使用正号。
- MD-6.3.6-FPPolynomialAdjoint：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺完整指数尾IBP打包；不以边界通量消失本身作假设。原只给函数值尾部增长而未约束导数；完整IBP及边界消失需技术资格，已全部明示，不静默添加。
- MD-6.3.6-FPEquation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般Ito鞅期望、真实law到弱方程与测试函数基本引理完整桥接。
- MD-6.3.7-VectorIto：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般多维Ito公式完整桥接。
- MD-6.3.7-VectorFPEquation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺多维Ito/鞅期望及真实law到强Fokker–Planck完整桥接。
- MD-6.3.8-LangevinFPEquation：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般质量Langevin law的完整Fokker–Planck桥接；单位质量形式算子不是过程密度PDE证明。
- MD-6.4.2-MassGibbsStationary：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 现成单位质量表达已证，任意质量坐标包装尚缺短桥；实际过程不变另条。
- MD-6.3.3-VariableFrictionCanonicalPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 等待网站/导师明确Γ与M的交换或正确漂移；不证明一般错误stationarity，更不伪造采样收敛。任意ΓΓᵀ与对角质量不交换时，印刷漂移ΓΓᵀp与噪声M½Γ不自动满足Gibbs涨落耗散平衡；原canonical目标不能推广为任意质量/任意矩阵全称定理。
- MD-6.3.3-VariableFrictionCommutingStationary：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺任意质量/矩阵交换的完整坐标涨落耗散代数打包；不建设一般随机理论。
- MD-6.4.1-FiniteDistribution：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 印刷nonzero应区分典型正权重与一般非负概率；原句完整保留，未声明字面nonzero定义网站PASS。
- MD-6.4.1-FiniteErgodicity：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺现成有限非负随机矩阵Perron–Frobenius/primitive极限完整打包桥接；不建设大型理论。
- MD-6.4.1-DirectedGraphIrreducible：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺非负矩阵幂正项与有向路径的完整有限求和桥接；不建设一般PF理论。
- MD-6.4.2-CylinderForwardPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 网站/导师待裁定印刷φ/ρ笔误。印刷forward密度算子仍写φ″，应ρ″；本条保留两个不同对象的字面表达，不宣称其是密度演化算子。
- MD-6.4.2-StationaryInvariant：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺抽象generator域与求导换积分/测度分离的完整短桥；不建一般半群理论。
- MD-6.4.2-LangevinCanonicalMixing：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺完整原Langevin正密度/Harris/kernel混合验收桥接；不恢复封存的Theorem6.2长证明。
- MD-6.4.3-BrownianNonpositive：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 常数属于核，≤0只证明半负定，不能升级严格负定。
- MD-6.4.3-Theorem61：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 无现成整个原Thm6.1域/严格负定/时间平均完整桥接；保持sorry，不恢复封存长证明。各已证子条款单独登记。原C₀²核心域、自伴闭实现及negative definite术语需要签核；原末句时间平均与前句分布平均冲突。原一般初始分布未证明，本条技术范围限定另行披露。
- MD-6.4.3-Theorem61TimeAveragePrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 原时间平均/演化分布平均冲突待导师；不证明字面指数轨道界。保留原5.6轨道时间平均读法；通常随机时间平均并无原指称指数路径误差界。原文未说明随机量的概率资格，不能改成分布平均后冒称原结论已证。
- MD-6.4.3-BrownianNegativeDefinitePrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 字面严格负定被常数核反驳，不能证明。常数非零函数给零二次型，严格负定字面不成立；原非正谱正确子结论独立保留。
- MD-6.4.2-OUDensityPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 字面式只为未归一权重；不证明它是概率密度。(6.44)遗漏(2πσ²(t))⁻¹/²归一化系数；t=0为Dirac，不能声称每个有限t都是非退化Lebesgue密度。
- MD-6.4.4-Assumption1Printed：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 保留原包含t=0的字面资格；不证明当前物理扩散满足它。正维连续状态中t=0初始Dirac通常不具有可连续延拓的Lebesgue转移密度；字面[0,∞)与正时刻密度不能混同。
- MD-6.4.4-MinorizationPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 原等价适用对象/密度和时间域需导师；保留完整双向字面陈述。原tantamount按双向等价读取；一般小集下界并不自动产生原要求的联合连续密度，且原时间0连续性需勘误。不能只证单向后冒称原等价已证。
- MD-6.4.4-MinorizationCorrectedImplication：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺真实kernel小集/联合连续密度的完整组合桥接；不建立一般Harris理论。
- MD-6.4.4-Theorem62：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 没有现成完整Thm6.2桥接；保持sorry，不恢复封存Harris长证明或构建缺失大型理论。原未指定阈值、generator域或非爆炸/Markov域识别；原Assumption1时间0勘误和全状态密度资格需要明确签核。
- MD-6.4.4-PeriodicPotentialBound：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 非恒零维周期势在lift上不会趋∞；光滑周期本身也不推出原1<Umin。
- MD-6.4.4-PeriodicConfiningPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 原周期/配置围束条件须导师签核，实际H^l在动量无穷远的proper结论另列。原周期位置域与同一势能lift的q→∞围束条件冲突；保留字面资格而非构造一个不存在的周期围束势。
- MD-6.4.4-LaplacianBoundPrinted：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 保留字面错误不等式，不能证明；正确完整上界另条。用|p|²≤2H推导时遗漏系数2；一般原界不成立，具体52>40反例另给。
- MD-6.4.4-LyapunovYoungBounds：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 原中间严格U上界需要Umax选严格外界；原错误Laplacian系数不能由这些正确标量估计证明。
- MD-6.4.4-LangevinTransitionDensity：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺实际Langevin hypoelliptic/Malliavin转移密度存在桥接；不建设大型理论。
- MD-6.4.4-Lemma61Printed：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 保留原缺非空的完整字面断言，不证；下一条桥接原单位周期实际过程的完整非空版本。字面all open C包括空集，概率为0；需Nonempty。原(6.47)单位质量，旧清单一般质量扩展须另标技术范围。
- MD-6.4.4-LangevinGeometricErgodicity：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺实际transition density、Harris/minorization及canonical invariance完整桥接；保留sorry，不恢复Thm6.2封存长证明。
- MD-6.4.4-LangevinTimeAverage：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺实际canonical唯一不变/遍历及weighted观测量强大数桥接；不建设大型理论。
- MD-6.4.4-Proposition64Printed：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 无现成整条桥接；不恢复封存Prop6.4长证明，保留sorry。印刷flat forward PDE与Gibbs加权mean-zero/adjoint pairing混用；测度及density-vs-relative-density选择待导师，原式完整保留。
- MD-6.4.4-Proposition64Relative：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺实际加权adjoint域、compact resolvent与rough kernel；无现成整条桥接保留sorry，封存不恢复。
- MD-6.4.4-FredholmAlternative：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺一般closed partialoperator的Fredholm alternative现成完整桥接；不建设大型谱理论。
- MD-6.4.4-BackwardKernelConstants：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 rough加权Hilbert generator kernel尚缺完整桥接；CanonicalKernelConstant封存长证明不恢复。
- MD-6.4.4-ForwardKernelGibbs：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺flat forward弱域与实际adjoint/relative坐标转换、kernel识别；不恢复封存长证明。
- MD-6.4.5-SmoothTestL2Printed：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 不证明错误自动可积断言；下面完整衰减保留真实L²检验资格。环面×无界动量上C∞不自动L²；常数1已不在flat L²，指数增长函数也可能不在Gibbs L²。需适当weighted空间/增长资格。
- MD-6.4.5-ComplexEigenmodeDecay：本地逐项核对原文对象、真实定义、量词、前提及全部结论；技术资格逐条[EXTRA]。 缺复C0生成元本征模式的现成完整桥接及实际Langevin forward semigroup识别；不建设大型谱/半群理论。

## 定性段落排除

- p.211–214/PDF232–235：引言关于热浴、环境、瞬态/稳态和模拟的物理动机、图6.1与历史说明为定性内容；N/V粒子密度、NVE/NVT及固定N,V,E为context notation，数学微正则密度公式已保留。
- p.219/PDF240：图6.2的100个粒子、L=20周期模拟、红色双阱粒子轨道及虚实密度曲线是数值/定性说明；完整Lennard-Jones势、尾部发散与εq²束缚公式另列，不省略数学内容。
- p.223–224/PDF244–245：分母接近零导致数值不稳、优先使用动能温度是定性计算建议；三个实际温度公式、周期边界消去及q场非周期性均已单列。
- p.224–225/PDF245–246：thermostat术语、governor历史、Brown/Perrin历史和图6.3为定性背景；守恒导致采样障碍及随机游走全部数学公式另列。
