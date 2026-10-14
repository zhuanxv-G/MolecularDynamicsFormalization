# 网站NEEDS_HUMAN分流

原始返回和完整理由见website_audit.json；以下问题未替导师作数学选择。

## (i) 材料缺失：补材料后复审

- MD-1.1-Schrodinger：补齐与附件Ch01.lean同一版本的ReviewDefinitions.lean、相关导入及MANIFEST.json，展开上述五个辅助定义。确认secondPartial的方向、阶数和坐标顺序，并明确这是经典C2解谓词；若U_P仅在非碰撞域定义，应显式给出该域和时间域，调整量词范围后重新审计。 已补材料/修复并生成EAUDIT02，等待网站复审。
- MD-1.1.1-Multibody：提供与附件 Ch01.lean 同版本的 ReviewDefinitions.lean、ReviewProofs.lean 及对应输入清单，核实 V3 的展开确为三维实欧氏空间；保持已注明的无序不同粒子组计数约定。 已补材料/修复并生成EAUDIT03，等待网站复审。
- MD-1.1.1-HeterogeneousLJ：补充本批对应版本的真实依赖定义及输入清单，以核实 V3 的空间和范数、pairDistance 的具体表达式。若确为欧氏距离，应明确原文对应域为 pairDistance (q i) (q j)>0；Lean 实数除法在零处分母被全定义化，公式会返回0，不能将该值解释为教材在碰撞处的势能。可保留总函数实现，但应显式记录非碰撞有效域。 已补材料/修复并生成EAUDIT03，等待网站复审。
- MD-1.1.2-AngleBond：补充同一输入快照中的V3及相关实例定义，核实三维欧氏内积和距离；明确qᵢ≠qⱼ、qⱼ≠qₖ的模型有效域。保留原书的向量方向，不擅加本段未明示的k>0条件。
- MD-1.1.2-GayBerne：补充同一输入快照的上述辅助定义及V3的实例后重新展开审计；明确‖u₁‖=‖u₂‖=1、q₁≠q₂、根号及各分母的有效域。逐式核实εGB=ε1ε2、ε2=W(χ′)，不得直接采用含ε2²的其他版本。
- MD-1.2-NewtonCompact：补齐与Ch01.lean同版本的Notation.lean、NBody.lean、LocalTrajectories.lean及MANIFEST.json。将势能在q(t)处可微或HasGradientAt作为模型适用资格，避免把总化梯度的默认零值解释为经典力；保留两个真实时间导数见证。
- MD-1.2-TotalEnergy：补齐本批V3的定义文件、相关Notation.lean及MANIFEST.json，确认V3为三维欧氏内积空间且范数平方为三个分量平方之和；普通函数空间的默认上确界范数不能替代这里的欧氏范数。已见有限和和能量表达式无需改变。
- MD-1.2-PairCancellation：提供本批V3及其实际向量空间结构的定义和MANIFEST.json，并确认F(i,j)的内部作用解释及每粒子净力为Σj F(i,j)。已见反对称前提与抵消结论无需修订。
- MD-1.2-MomentumConservation：补齐本批V3定义及MANIFEST.json，确认其为三维实向量空间，并绑定F(i,j)与粒子内部作用及p_i=m_i v_i的模型解释。保留全部三项结论、真实动量导数前提及连通时间域；目前没有依据要求改动这些已见条款。
- MD-1.2-HarmonicSolution：补齐同版本HarmonicOscillator.lean、LocalTrajectories.lean、Notation.lean及MANIFEST.json，展开harmonicFlow的两个分量和真实机械解谓词，核查单位质量下动量等于速度及能量函数对应。若目标是覆盖“The solution”的唯一性含义，还需提供任意同初值解等于所示曲线的条款或明确关联的唯一性结果。保留原文，不静默改写Ω=0情形。
- MD-1.3-GeneralizedCoordinates：提供与上传 Ch01.lean 同一快照的 Lagrangian.lean、GeneralizedCoordinates.lean 及其必要依赖和输入哈希，供只读核实 massLagrangian 是否等于原文 L，以及 generalizedMassMatrix 是否实际定义为 Jᵀ(diagonalMassMatrix m)J。
- MD-1.3-GeneralizedMassRegular：提供同一输入快照的 GeneralizedCoordinates.lean 和必要依赖，核实 generalizedMassMatrix 的真实公式；同时明确原文模型在相关配置域各点采用满列秩 Jacobian 的条件，避免把此代数引理误读为任意坐标变换自动正则。
- MD-1.4-HamiltonLagrangeEquivalence：补齐与Ch01.lean同一版本的quadraticL、quadraticH定义、相关导入和输入MANIFEST，展开核实后再判定。若要覆盖有奇异性的分子模型，改在开放配置域Q上要求局部C²和正定，并要求轨迹留在Q；保留双向等价及真实导数，不能用未核实的同名或类似函数替代。
- MD-1.5-LocalExistUnique：补齐与Ch01.lean同版本的LocalTrajectories.lean、LocalExistence.lean、相关导入及MANIFEST.json，核实正区间半径、初值、真实ODE和留域条件。若采用已见缓存定义，应明确物理质量的正性及U在Q内的可微性，或明确标注该声明推广到总化算子模型，并提供到原文Hamiltonian系统的对应关系。
- MD-1.5.1-FlowEnergy：补齐与本批Ch01.lean同版本的symplecticGradient及相关gradient定义文件和输入清单，核实其展开确为(∂H/∂p,-∂H/∂q)，再完成语义判定。
- MD-1.5.1-SpectralSolution：提供本批ComplexSpectralFlow.lean及其流定义、初值和ODE关联结果，核实complexExponentialFlow确为A生成的零初时线性流，并明确时间平移后与原文任意t₀初值问题的对应。
- MD-1.5.1-BasisCoefficients：提供本批BasisMatrix.lean，核实逐项定义basisColumnMatrix b i j=(b j) i以及WithLp转换；完成后再判定是否完整覆盖原文列矩阵与系数方程。
- MD-1.5.1-MatrixExponentialSolution：补齐本批MatrixFlow.lean及必要依赖，核实matrixExponentialFlow A s z等于e^{sA}z，并检查真实初值和微分方程性质；保留当前合理的hγ与hinit。
- MD-1.5.2-FirstIntegral：提供与Ch01.lean同一版本的MolecularDynamics/Chapter01/FirstIntegrals.lean及其依赖，核查IsFirstIntegralOn的完整展开；若教材状态域为开域，应明确Q的域约定。
- MD-1.5.2-FirstIntegralCriterion：提供同版本FirstIntegrals.lean及梯度桥接声明。核实后明确该定理是可微函数的守恒判据；若要与smoothFirstIntegral完整对应，应保留光滑J前提，并在该前提下陈述smoothFirstIntegral与梯度条件的等价。
- MD-1.5.2-PlanarGraphReduction：提供同版本FirstIntegrals.lean和FirstIntegralGraph.lean；保留原文缺项记录，并明确Lean声明对应∂I/∂y≠0的局部版本。退化点需另选可用坐标或单独分类，不能声称本签名覆盖。
- MD-1.5.2-PlanarQuadrature：提供同版本相关定义并确认separableTimePrimitive的被积函数、基点和积分约定。若覆盖原文给定初值可求解的全部范围，补充局部初值问题存在结论及零速度情形；删除未使用的δ或将其连接到明确的空间邻域。
- MD-1.5.2-ScalarFirstIntegral：提供同版本ScalarIntegrability.lean、FirstIntegrals.lean及SeparableQuadrature.lean。完整可积性应同时处理非转向点、非平衡转向点和平衡点，并明确任意初值的局部解存在；若仅保留现签名，应明确标记为能量守恒与非转向局部求积的部分形式化。
- MD-1.5.2-KeplerConservedEnergy：提供同版本Kepler.lean、Hamiltonian.lean、PlanarAngularMomentum.lean、ScalarIntegrability.lean、ScalarTurning.lean及机械解定义。逐项确认力为−q/‖q‖³、势为−1/‖q‖、角动量为q₀p₁−q₁p₀，并展开ScalarPotentialLocalDescription核查全部径向情形及由初值求解的内容；证明中的sorry另行处理。
- MD-1.5.2-KeplerAngularMomentum：提供同版本Kepler.lean、PlanarAngularMomentum.lean及IsMechanicalSolutionOn所在文件，核查q'=p、p'=−q/‖q‖³和角动量坐标公式，并确认势仅依赖半径且力与该势匹配。
- MD-1.5.2-KeplerPolarODE：提供与本批Ch01.lean同版本的KeplerPolarDynamics.lean及其依赖，展开IsKeplerPolarEulerLagrangeOn，核实其表达原Lagrangian的两条Euler–Lagrange方程，且没有将待证运动方程直接放入前提。
- MD-1.5.2-KeplerRadialReduction：提供本批对应的KeplerPolarDynamics.lean，核实前提中的速度及非碰撞条件。若该条还要独立表达固定角动量后的区间归约，应另明确同一个l满足∀t∈I，r t²*omega t=l，并在整个区间陈述径向方程。
- MD-1.5.2-KeplerFullSolution：提供本批同版本的Kepler.lean、LocalTrajectories.lean、ScalarIntegrability.lean及相关求积、转向和重建依赖，并提供对应输入清单。展开ScalarPotentialLocalDescription核实真实求积与逆函数条件、转向点及平衡分支；同时核实机械解确有位置与动量的导数关系，而非假定重建结论。
- MD-1.5.2-ActionEnergy：提供与本批Ch01.lean匹配的依赖源码及MANIFEST，核实能量确为v²/2+Ω²x²/2，位置、速度确为本页坐标公式后再判定。
- MD-1.5.2-ActionODE：补充本批HarmonicActionAngle.lean等依赖，逐项展开坐标定义并核对导数等价所用对象。
- MD-1.5.2-ActionSolution：提供匹配依赖定义，核实坐标公式与能量表达式；说明原文以0为初始时刻时须0∈Ioo a b，能量恒定由J恒定及E=JΩ推出。
- MD-1.5.2-HarmonicTorus：提供HarmonicTorus.lean及相关依赖；明确展开角模2π及负频率旋转，并给出逐振子坐标变换和半径|I_j|的解释或对应声明，不应仅以固定action标签代替全部语义。
- MD-1.5.3-EquilibriumLinearization：补齐对应版本的EquilibriumLinearization.lean并核查余项展开；明确点处可微假设是原文邻域C1的充分条件弱化。若覆盖完整恢复段落，应说明局部解近似的范围或另列相应误差结论。
- MD-1.5.3-HyperbolicStabilityTransfer：提供同版本Stability.lean、GlobalFlow.lean及定义线性指数流的模块，逐项展开核查。给出stable与严格sup定义的等价依据，并明确全局流模型仅覆盖原文局部结论的受限实例，或改为局部流陈述。
- MD-1.5.3-PositiveHessianQuadratic：提供与当前 Ch01.lean 对应的 IsStrictPotentialMin 实际定义及其导入依赖，重点核对正半径、全部附近相空间点和严格能量比较；确认该谓词确为严格局部最小值后再完成判定。
- MD-1.5.3-PositiveHessianMinimum：提供当前版本的 gradient、IsStrictPotentialMin 及相关依赖定义；核实梯度与真实 Hessian 的对应、严格局部最小值谓词及完整特征基解释。若要求覆盖原文仅局部光滑的情形，将全局 ContDiff ℝ 2 U 调整为平衡点邻域上的相应条件。
- MD-1.6-RegularLatticeMinimizerLiteral：提供与本批一致的能量辅助定义及版本依据，明确排序、盒内域和周期等价代表元的语义。保留原文及 ERRATUM 标记；如另立经修正的数学命题，应显式列出足以推出等间距的势条件，并与原书字面命题分开。
- MD-1.6-PeriodicImages：提供同版本 V3、twoBodyTerms 及相关导入定义。保留原书公式及 ISSUE，明确ν_i的全配置含义和取单原子块的映射；取得这一解释的确认后再判定逐原子实现是否忠实。
- MD-1.6-RhombicLattice：明确正边长和非退化夹角的资格，并区分总点集构造与有效二维晶格对象。将低温典型性明确标为未形式化的物理背景，或单独给出其可审计陈述；不能仅靠context_notation声称整句已经覆盖。
- MD-1.6-UnitCell：提供V3的同版本定义，并明确此声明是一般周期化辅助构造还是合法单胞定义。后一种情形应编码三方向非退化性、盒内基元资格及采用的原子排列条件；允许边界重叠时应说明代表元约定。
- MD-1.6-FCCStacking：提供同版本triangularLayer、V3及相关导入定义。展开核对层内生成向量、参数平移含义、三层偏移的互异性与邻层距离，并保留单位化坐标选择为[EXTRA]说明。
- MD-1.6-HCPStacking：提供同版本triangularLayer与V3定义，展开核验层内几何、水平偏移是否落在不同点阵陪集中，以及邻层的密堆积关系；保留数值归一化为明确的[EXTRA]编码说明。
- MD-1.6.1-MinimumGradientZero：保留原文并确认边界解释；将现有声明明确标为内点版本。若需覆盖约束极小，应另给适当可行方向必要条件；一般边界不能直接要求全梯度或所有方向导数为零。补齐本批依赖及输入清单。
- MD-1.6.1-ForceLinearization：提供本批实际EquilibriumLinearization及其导入依赖和MANIFEST.json，以确认gradient等名称的解析和版本。机械模型的实例化应保留质量矩阵可逆或正定条件；广义导数声明可单独保留。
- MD-1.6.1-RealNormalMode：提供本批实际NormalModes.lean及匹配清单，展开realNormalMode逐项核对。若要求完整表达“recast”，还应连接u=Re ξ、v=Im ξ与复公式的实值子族；对应系数为a=(β−iα)/2、b=(β+iα)/2，而非任意复系数都产生实值解。
- MD-1.7-PlanarTrimerModel：补齐本批对应版本的依赖文件及MANIFEST.json，并明确该定义是供非碰撞配置使用的总函数延拓，或用非碰撞配置子类型、关联域谓词限定物理模型的对象范围。
- MD-1.7-CentralPairPotential：提供此次导入版本中V3、pairDistance的完整定义及输入清单；确认pairDistance q r=‖q−r‖。若后续把相互作用解释为同一无序对，应在对应模型中明确对称性，而不要声称本定义已经约束了φ。
- MD-1.7-CentralPairGradient：补齐V3及相关实例所在的本批依赖文件，确认其为标准欧氏三维空间，并确认本声明解析到Mathlib的gradient。保留当前非碰撞与径向可微条件，不需要添加所求梯度等式作为假设。
- MD-1.7-CentralMomentum：补齐本批V3及力学依赖定义，明确F与距离势的负位置梯度如何对应，并提供与实际Newton轨迹的接口。不要把总内力为零或总动量守恒改成该接口的假设。
- MD-1.7-CenterOfMassMotion：补齐V3所在的本批依赖，明确登记本声明只对应原句的平移子句。保留原句及旋转疑误标记，让下一条独立处理旋转，不要将质心公式的通过状态扩展到整句。
- MD-1.7-IsoscelesCoordinates：补齐V3及本批依赖版本，确认其为标准欧氏三维空间。保留当前坐标定义及上下文疑误标记，明确这是所选择的对称配置；不要添加任意零总动量、零总角动量配置均为等腰的推断。
- MD-1.7-IsoscelesEnergyReduction：补齐与附件 Ch01.lean 同版本、由本批 MANIFEST.json 绑定的相关依赖，至少提供 V3、uniformLJEnergy、isoscelesEnergy、isoscelesPotential 的完整定义，再核对两条斜边和底边的势能及约化动能。
- MD-1.7-IsoscelesAccessibleRegion：提供同版本 isoscelesEnergy、isoscelesPotential 及所用 LJ 势的实际定义，确认能量差为 v²+w²/3，并明确物理坐标域与总化代数定义的关系。
- MD-1.7-EquilateralTrimerMinimum：补齐同版本 V3、pairDistance、uniformLJEnergy 的定义和本批 MANIFEST.json；核实三对相互作用的计数。审计时同时覆盖任意等边边长 r 的势能公式及边长 2^(1/6) 的可实现配置，必要时补充对应陈述。
- MD-1.7-TrimerEnergyLowerBound：提供同版本 uniformLJEnergy、V3、相关 LJ 定义及本批 MANIFEST.json，核实每对势能下界和三对计数；在条目元数据中明确记录非碰撞域。保留与正能量逃逸条目的范围划分。
- MD-1.7-TrimerSaddle：补齐同版本 isoscelesPotential 的实际定义及本批 MANIFEST.json，确认它是 2φ̂_LJ(√(x²+y²))+φ̂_LJ(2x)，并核实 y=0、x>0 时与 collinearTrimer 一致。若要显式固定物理邻域，可将 δ<x 写入陈述；这不是当前已确定的必要修复。
- MD-1.7.1-ChaosConditions：补齐与本批Ch01.lean同一版本的辅助定义，尤其是MolecularDynamics/Chapter01/ReviewDefinitions.lean及流相关依赖。随后展开两项谓词，核实全部量词，并明确真实流和D不变性由何处提供；保留原文非形式化说明，说明ε/δ版本与原文解释的关系。
- MD-1.7.1-AnisotropicOscillator：补齐与本批一致的anisotropicAngular和anisotropicParameters源码，展开核对全部公式及参数对顺序。在r>0的物理域说明c₃与cos(3θ)的对应关系，并将原点延拓限定为域外约定；不要把实验参数或轨迹现象加入本定义的全称结论。

## (ii) 原文数学判断：供导师裁定

- MD-1.1.1-LJRepulsion：经验句保留定性覆盖未完成，还是由导师指定算法、时间段及rarely概率语义后另立命题？选项：定性登记 / 指定数学模型。
- MD-1.4-ConvexLegendre：Legendre变换采用扩展实数，还是在实值版本显式增加有限性条件？选项：EReal推广 / 实值加有界性。
- MD-1.5.2-TorusDense：原句的稠密性限定为全整数无共振，还是改述为相应子环面上的稠密性？选项：全维加无共振 / 子环面版本。
- MD-1.5.2-LocalActionAngleReduction：是否采用紧、连通、非空正则共同水平集上的作用角结论？选项：批准明确资格 / 保留字面疑误待定。
- MD-1.5.3-HartmanGrobmanLiteral：原书光滑共轭应勘误为局部同胚，还是保留并补充光滑线性化条件？选项：同胚勘误 / 光滑加条件。
- MD-1.7-TrimerEscapeLiteral：原文逃逸指每个粒子逃逸还是系统直径无界？选项：逐粒子原句登记错误 / 另立系统分离命题待审。
- MD-1.7.1-TransitivityErgodicityLiteral：如何裁定拓扑传递与遍历性的字面等价？选项：仅保留疑误 / 另立满支撑测度下的单向结果。
- MD-1.7.2-VariationalEquationLiteral：是否另立标准变分矩阵W(t)=DF_t(ζ)的勘误版本？选项：批准另立 / 保留字面疑误。
- MD-1.7.2-NearbyTrajectoryLiteral：是否把导数取值点另行勘误为DF_t(ζ)？选项：批准另立 / 保留字面疑误。
