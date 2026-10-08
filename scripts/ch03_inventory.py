"""Initial chapter 3 mathematical inventory, before supplementation."""
from pathlib import Path
import csv,re
root=Path(__file__).resolve().parents[1];target=root/'docs/review/CH03_CLAIMS.csv'
if target.exists():raise RuntimeError('Do not overwrite maintained chapter 3 CSV.')
data="""
97|3|未编号结论|A smooth near-identity symplectic integrator admits a formal modified Hamiltonian to arbitrary finite order.|modifiedConstruction_statement|statement_only|局部凸开域；完整构造与匹配仅陈述
98|3.1|定义|Adjoint symplectic Euler for the oscillator is Q=q+h p,P=p-h Omega^2 Q.|oscillatorAdjointEuler|defined|数学算法，排除数值六点轨道实验
98|3.1|定义|The modified oscillator invariant is (p^2+h Omega^2 p q+Omega^2 q^2)/2, (3.1).|oscillatorShadow|defined|精确实数二次式
98|3.1|未编号结论|The physical oscillator energy is generally not preserved by adjoint symplectic Euler.|oscillatorEnergyFailure_statement|statement_only|给具体非零误差，不声称所有初值都漂移
99|3.1|未编号结论|The modified oscillator Hamiltonian (3.1) is exactly preserved.|oscillatorShadowInvariant_statement|statement_only|可有限代数证明
99|3.1|未编号结论|For abs(h Omega)<2 the modified oscillator level sets are ellipses.|shadowPositive_statement|statement_only|正频率和正能量；边界与不稳定步长排除
100|3.1|未编号结论|Euler oscillator energy grows without bound for a nonzero fixed step and nonzero initial energy.|eulerOscillatorGrowth_statement|statement_only|Omega非零、初值非零，避免平衡点例外
100|3.1|定义|The modified Hamiltonian has formal expansion H+h^r H_r+h^(r+1) H_(r+1)+... .|formalHamiltonian|defined|形式PowerSeries，不宣称收敛
100|3.1|定义|The modified field is J grad of each coefficient in the Hamiltonian series.|formalHamiltonianField|defined|逐系数定义
100|3.2|定义|The Lie derivative L_f phi is f dot grad phi.|textbookLieDerivative|defined|实际Fréchet导数
100|3.2|未编号结论|The derivative of an observable along an actual solution equals L_f phi.|hasDerivAt_textbookLieDerivative|proved|实际时间链式法则；只需局部解
101|3.2|未编号结论|The second derivative along a solution equals L_f^2 phi.|hasDerivAt_textbookLieDerivative_second|proved|C1场/C2观测量；实际导数
101|3.2|定义|Repeated Lie derivatives give the formal operator exponential coefficients 1/j!.|textbookFormalOperatorExponential|defined|在实非交换代数上；不宣称实际算子收敛
101|3.2|定义|The formal evolution of an observable is sum t^j L_f^j phi/j!.|formalObservable|defined|形式级数
101|3.2|未编号结论|A finite Taylor expansion along the flow has repeated Lie derivatives and a remainder of order k+1.|lieTaylor_statement|statement_only|补足光滑阶数；原文明确不处理无限级数收敛
101|3.2|未编号结论|The flow components are given by the evolution operator acting on coordinate functions.|flowObservable_statement|statement_only|解释为实际pullback；不把形式exp当收敛级数
102|3.2|定义|The Poisson bracket is grad F^T J grad G.|textbookPoissonBracket|defined|教材符号
102|3.2|未编号结论|The Poisson bracket equals the sum of F_q G_p-G_q F_p.|textbookPoissonBracket_coordinates|proved|实际偏导
102|3.2|未编号结论|The Poisson bracket is bilinear in both arguments.|textbookPoissonBracket_linear_right;textbookPoissonBracket_linear_left|proved|相应可微条件
102|3.2|未编号结论|The Poisson bracket is skew symmetric.|textbookPoissonBracket_skew|proved|教材J的反对称性
102|3.2|未编号结论|The Poisson bracket of a function with itself is zero.|textbookPoissonBracket_self|proved|精确恒等式
102|3.2|未编号结论|The Poisson bracket satisfies the Jacobi identity.|textbookPoissonBracket_jacobi|proved|C2三函数；实际Hessian对称性
102|3.2|未编号结论|Along a Hamiltonian trajectory, the derivative of F is {F,H}.|hasDerivWithinAt_textbookPoissonBracket|proved|真实Hamiltonian ODE
102|3.2|未编号结论|L_(J grad H) F={F,H}.|textbookLieDerivative_hamiltonian_eq_poisson|proved|固定符号
102|3.2|notation|L_H is shorthand for the Lie derivative along J grad H.|hamiltonianLie|defined|观测量算子
103|3.3|未编号结论|L_(H1+H2)=L_H1+L_H2.|textbookHamiltonianLieDerivative_add|proved|可微H1/H2
103|3.3|定义|A splitting evolution operator is exp(h L_H1) exp(h L_H2).|formalSplitting|defined|形式算子乘积，不混同状态映射组合次序
103|3.3|未编号结论|The exact formal exponential coefficients through cubic order are (A+B)^j/j!.|textbookFormalOperatorExponential_coeff|proved|纯形式代数
104|3.3|未编号结论|The product exponential has coefficients 1,A+B,(A^2+2AB+B^2)/2 and (A^3+3A^2B+3AB^2+B^3)/6.|textbookFormalOperatorProduct_coeff_zero;textbookFormalOperatorProduct_coeff_one;textbookFormalOperatorProduct_coeff_two;textbookFormalOperatorProduct_coeff_three|proved|顺序AB保留非交换性
104|3.3|未编号结论|The degree-two difference of product and sum exponentials is [A,B]/2.|textbookFormalOperatorDifference_coeff_two|proved|完整形式系数证明
104|3.3|未编号结论|The cubic difference is (2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)/6.|textbookFormalOperatorDifference_coeff_three|proved|完整非交换系数证明
104|3.3|定义|The commutator is [A,B]=AB-BA.|commutator|defined|非交换实代数
104|3.3|未编号结论|The splitting leading defect is h^2 [L_H1,L_H2]/2 at the formal level.|textbookFormalOperatorDifference_coeff_two|proved|只声称形式系数，实际范数余项另需正则条件
105|3.3|未编号结论|[L_H1,L_H2]F=L_{H2,H1}F; the next display reverses the bracket.|textbookHamiltonianLieDerivative_commutator|weakened|既有完整证明给正确{H2,H1}；补印刷{H1,H2}字面Prop
105|3.3|未编号结论|The first modified exponential correction is R=[A,B]/2.|textbookFormalModifiedExponential_matches_product|proved|已证明所有n<3系数匹配，非完整BCH收敛
105|3.3|未编号结论|The leading shadow Hamiltonian is H1+H2+h{H1,H2}/2 under the displayed convention.|leadingShadowPrinted_statement|statement_only|原文Lie commutator符号与此系数需一起审阅；状态/观测量顺序须区分
106|3.3|未编号结论|BCH logarithm has the displayed degree-two, degree-three and degree-four nested commutators.|bch4_statement|statement_only|真实形式幂级数有限阶等式；高阶未证
106|3.3|定义|A finite modified Hamiltonian uses nested Poisson bracket coefficients through h^3.|bchHamiltonian3|defined|保留印刷公式作为有限函数；不声称匹配
106|3.3|未编号结论|The finite BCH Hamiltonian matches the splitting through the stated order.|bchHamiltonianMatching_statement|statement_only|需符号/映射顺序核对和更高系数推导
106|3.3|未编号结论|If H1 and H2 Poisson commute, their exact splitting has no error.|commutingFlows_statement|statement_only|光滑、流存在、适当共域和完整时间范围
106|3.3.1|定义|The symplectic Euler modified Hamiltonian through h^3 is the displayed mechanical expression.|symplecticEulerShadow3|defined|质量正、实际梯度和Hessian；有限式与匹配分开
106|3.3.1|未编号结论|The mechanical symplectic Euler shadow expansion agrees to the displayed order.|symplecticEulerShadowMatching_statement|statement_only|真实局部流误差O(h5)；未证
107|3.3.2|定义|Velocity Verlet is kick-drift-kick; position Verlet is drift-kick-drift, (3.3).|coordinateVerlet;positionVerlet|defined|速度版复用第2章，位置版新增
107|3.3.2|定义|Velocity Verlet splits H as U/2,T,U/2.|verletHamiltonianParts|defined|有限三部分
107|3.3.2|未编号结论|Both Verlet variants are symplectic and self-adjoint.|verletVariants_statement|statement_only|复用既有kick/drift及伴随引理
107|3.3.2|定义|The printed Verlet shadow Hamiltonian includes the displayed h^2 and h^4 nested brackets.|verletModifiedH|defined|印刷与kick/drift次序需审阅；定义不代表系数已证明
107|3.3.2|未编号结论|The printed nested-bracket Hamiltonian matches a Verlet variant through h^4.|verletModifiedH_statement|statement_only|同时给明确速度Verlet与印刷版，不能混同两种Verlet
107|3.3.2|未编号结论|Symmetry removes odd powers from the modified Hamiltonian.|modifiedEven_statement|statement_only|形式log奇性而非不同步长log互相可交换
108|3.3.2|定义|A Strang product is exp(t X/2) exp(t Y) exp(t X/2).|formalStrang|defined|非交换PowerSeries
108|3.3.2|未编号结论|Z_s and Z_t are claimed to commute for different step sizes.|differentLogsCommute_statement|statement_only|字面一般不成立；保留待审，正确奇性不依赖此断言
108|3.3.2|未编号结论|A symmetric product times its negative-step counterpart is the identity.|strangInverse_statement|statement_only|纯形式级数反步关系
108|3.3.2|未编号结论|The cubic Strang log coefficient is [Y,[Y,X]]/12-[X,[X,Y]]/24, (3.7).|strangCubic_statement|statement_only|有限正式系数；待证
109|3.3.3|定义|Yoshida uses three steps a h,b h,a h with 2a+b=1.|yoshidaCompose|defined|保留负步长
109|3.3.3|未编号结论|The cancellation equations are 2a+b=1 and 2a^(2s+1)+b^(2s+1)=0.|yoshidaCancellation_statement|statement_only|有限代数参数条件
109|3.3.3|定义|Yoshida coefficients are a=1/(2-kappa), b=-kappa/(2-kappa), kappa^(2s+1)=2.|yoshidaCoefficients|defined|采用Real.rpow给正实根；s≥1
109|3.3.3|未编号结论|The two cancellation equations have the unique real solution stated.|yoshidaUnique_statement|statement_only|奇次幂根唯一与非零分母；待证
109|3.3.3|未编号结论|A symmetric method of order 2s is raised to order 2s+2 by Yoshida composition.|yoshidaRaiseOrder_statement|statement_only|需实际局部误差展开、负步长流存在；不搭大型BCH理论
110|3.3.3|定义|Fourth-order Yoshida is three velocity Verlet steps with the cube-root coefficients, (3.8).|yoshida4|defined|算法数学映射；纯实现步骤和成本排除
110|3.3.3|未编号结论|Yoshida4 is symplectic and symmetric.|yoshida4Structure_statement|statement_only|可直接组合既有引理
111|3.3.3|定义|General composition alternates drift and kick maps with coefficients alpha_i,beta_i.|generalSplitting|defined|有限列表、顺序显式
112|3.3.4|定义|Takahashi-Imada uses Verlet with U-h^2 grad U^T M^-1 grad U/24.|takahashiPotential|defined|复用第2章；符号待导师审阅
112|3.3.4|未编号结论|grad U^T M^-1 grad U={U,{U,T}}.|potentialDoubleBracket_statement|statement_only|实际Poisson偏导和固定正质量
112|3.3.4|定义|The printed leading TI shadow correction is (p^T M^-1 U'' M^-1 p-grad U^T M^-1 grad U)/12.|takahashiShadow2|defined|有限函数定义
113|3.3.4|定义|The processor is qtilde=q-h^2 M^-1 grad U/12, ptilde=p+h^2 U'' M^-1 p/12, (3.9).|takahashiProcessor|defined|数学坐标变换；不假设全球可逆
113|3.3.4|未编号结论|H after the processor equals the printed TI shadow through O(h^4).|processorEnergy_statement|statement_only|补前式遗漏U；实际Taylor余项待证
113|3.3.4|未编号结论|Takahashi-Imada has effective fourth order for general observables.|takahashiOrder_statement|statement_only|复用第2章忠实处理陈述，未证
113|3.4|定义|A modified vector field is the formal series f+h^r f_r+... .|formalField|defined|逐系数形式对象
113|3.4|未编号结论|The leading modified vector-field coefficient equals the leading local error coefficient.|leadingModifiedField_statement|statement_only|完整匹配关系；需步长光滑展开
114|3.4|定义|A finite Hamiltonian truncation is H+sum_(j=r)^k h^j H_j, (3.11).|textbookTruncatedHamiltonian|defined|已有有限函数定义，非收敛级数
114|3.4|未编号结论|The actual finite truncation is C1 if its finitely many coefficients are C1.|contDiffOn_textbookTruncatedHamiltonian|proved|固定r,k,h；原文proof依赖
114|3.4|定理|Theorem 3.1 with the omitted construction made explicit: high-order modified Hamiltonians and matching yield physical energy O(h^r) for n h=O(h^(-k+r)).|theorem31_statement|statement_only|先给原文条件化完整Prop，再给全阶构造/匹配Prop；指数界另列需解析性，不搭大型理论
114|3.4|未编号结论|Smooth H is Lipschitz on a compact convex B inside its open domain.|exists_compact_C1_lipschitz_constant|proved|真实fderiv界和紧性推导
115|3.4|notation|F_h^(k) is the actual time-h flow of the finite modified Hamiltonian.|truncatedFlow|defined|定义满足真实ODE的曲线关系，不把exp算子当解存在证明
115|3.4|未编号结论|The numerical step can be written as a truncated-flow step plus a defect of order h^(k+1).|modifiedConstruction_statement|statement_only|完整构造与匹配不可当已证假设；全阶陈述待证
115|3.4|未编号结论|The finite modified Hamiltonian is conserved by its own actual flow.|textbookHamiltonian_energy_const_on_Icc|proved|实际Hamilton曲线；不声称由数值方法构造完成
115|3.4|未编号结论|The modified energy change is the sum of successive changes along the numerical iterates.|oneStep_energy_telescoping|proved|任意函数和真实迭代，n=0包含
115|3.4|未编号结论|The finite truncated Hamiltonian has a step-uniform Lipschitz constant.|exists_uniform_textbookTruncatedHamiltonian_lipschitz|proved|常数来自有限系数的C1与紧凸域
115|3.4|未编号结论|The difference between the finite truncation and H is uniformly O(h^r).|exists_uniform_textbookTruncatedHamiltonian_remainder;textbookTruncatedHamiltonian_difference_isBigO|proved|所有h∈[0,1]与B内点，真实界
115|3.4|未编号结论|Physical energy drift is bounded by two truncation remainders plus a Lipschitz constant times actual endpoint defects.|textbook_energy_drift_le_actual_defects|proved|不先假设所需能量结论，匹配另列
116|3.4|未编号结论|A uniform O(h^(k+1)) matching defect implies O(h^r) energy error for polynomially long time.|textbook_energy_drift_rate_of_flow_defect|proved|有条件部分已证；不声称产生该matching defect
116|3.4|未编号结论|The step count identity n h^(k+1)=(n h h^(k-r)) h^r converts the drift bound.|energy_step_count_power_factor|proved|r≤k；纯代数
116|3.4|未编号结论|C-infinity data permits each fixed truncation index, with constants depending on the index.|modifiedConstruction_statement|statement_only|全阶构造未证；不把C-infinity当指数估计充分条件
116|3.4|未编号结论|Under analytic bounds, a finite modified flow defect is bounded by C h [D(k+1)h]^(k+1).|analyticBEA_statement|statement_only|原文many standard classes缺明示正则性；补解析/Gevrey量化，未证
116|3.4|未编号结论|Optimal truncation near k+1=1/(D e h) gives an exponentially small defect C h exp(-gamma/h).|optimalTruncation_statement|statement_only|整数取整与小h域需补；未证
116|3.4|未编号结论|Exponential smallness decays faster than any fixed power as h tends to zero.|exponentialFlat_statement|statement_only|正gamma；可复用Mathlib极限
117|3.4|定义|For unit scalar mass, the printed Verlet shadow through h^4 uses derivatives U' through U''''.|scalarVerletShadow4|defined|有限式；排除double-well数值图
117|3.4|未编号结论|If H is conserved by the modified Hamiltonian flow then {H,Htilde}=0.|commutingEnergy_statement|statement_only|从所有初值的实际流守恒导出，非单条轨道
118|3.4|未编号结论|By bracket antisymmetry, {Htilde,H}=0 and Htilde is a first integral of the original system.|commutingEnergySymmetry_statement|statement_only|实际全域陈述与原始流存在
118|3.4|未编号结论|Energy preservation and symplecticity are described as practically incompatible except exact flow up to time rescaling.|energySymplecticNoGo_statement|not_formalizable_now|缺非可积性/无额外第一积分等Ge-Marsden精确假设；保留条件化忠实Prop，不断言无条件不可能
122|3.5|定义|The example system has u'=f(u,v),v'=f(u,v), and I=u-v.|equalComponentIntegral|defined|数学示例，排除数值实验
123|3.5|未编号结论|Euler exactly preserves I=u-v for equal component fields.|equalEulerIntegral_statement|statement_only|可有限代数证明
123|3.5|未编号结论|Euler exactly preserves a linear functional b dot z if b dot f(z)=0.|linearEulerIntegral_statement|statement_only|任意有限维、精确实数
123|3.5|未编号结论|Runge-Kutta methods preserve such linear first integrals.|linearRKIntegral_statement|statement_only|直接有限和证明，无需一般RK阶理论
123|3.5|未编号结论|Verlet oscillator energy remains bounded and fluctuates by O(h^2) for stable steps.|verletOscillatorEnergy_statement|statement_only|需abs(h Omega)<2，排除不稳定步长；非一般非线性全时间定理
123|3.5|定义|Momentum projection leaves q unchanged and scales p by gamma.|momentumProjection|defined|实际映射
123|3.5|定义|The energy correction solves gamma^2 Kbar+Ubar=E, (3.12).|projectionConstraint|defined|数学约束
124|3.5|定义|The positive correction factor is sqrt((E-Ubar)/Kbar), (3.13).|projectionFactor|defined|Kbar>0,E≥Ubar域
124|3.5|未编号结论|The momentum projection preserves the specified energy under its domain conditions.|projectionEnergy_statement|statement_only|明确非零动能和非负根号；可有限证明
124|3.5|未编号结论|When all momenta vanish, Kbar=0 and the correction quotient is undefined physically.|kineticZero_statement|statement_only|正质量下K=0 iff p=0；Lean全除法不等于物理解存在
124|3.5|定义|General energy projection solves H(Q,P)=E.|energyProjectionRelation|defined|不声称求解存在和保几何结构
126|3.5|未编号结论|A Hamiltonian flow cannot have an attracting periodic orbit with an open basin.|noHamiltonianAttractor_statement|statement_only|补有限体积局部吸引和真实体积保持；缺一般动力系统基础
128|3.6|未编号结论|Hamiltonian mechanical flow preserves the symplectic form, energy and phase volume.|textbookHamiltonianFlow_isSymplectic_of_jointC2;textbookHamiltonian_energy_const_on_Icc;textbookHamiltonianFlow_volume_image_of_jointC2|weakened|前三性质复用；jointC2较强假设，忠实C1域陈述复用第2章
128|3.6|未编号结论|Volume preservation is weaker than symplecticity.|volumeNotSymplectic_statement|statement_only|具体四维线性反例
128|3.6.1|定义|An involution R satisfies R^2=I.|linearInvolution|defined|一般线性R不自动正交
128|3.6.1|定义|The printed reversed field is -R^T f(Rz).|reversedField|defined|字面定义；一般involution正确应R^-1=R，另给corrected
128|3.6.1|定义|Mechanical time reversal is R(q,p)=(q,-p).|momentumReversal|defined|该R确实对称正交
128|3.6.1|未编号结论|The mechanical field satisfies f(Rz)=-R f(z).|mechanicalReversal_statement|statement_only|可直接有限代数证明
129|3.6.1|未编号结论|If f is reversible, t↦R gamma(-t) solves the same ODE.|reversedTrajectory_statement|statement_only|实际时间导数、线性R和反步域
129|3.6.2|未编号结论|The unique reversible flow satisfies F_(-t)(Rz)=R F_t(z).|flowReversal_statement|statement_only|真实唯一流；不把此等式藏进假设
129|3.6.2|未编号结论|The flow satisfies R composed with F_t composed with R composed with F_t=Id, (3.14).|flowReversalIdentity_statement|statement_only|从反步关系与flow群性质推导
130|3.6.2|定义|A time-reversible numerical method satisfies R G_h R G_h=Id, (3.15).|reversibleMethod|defined|固定R；与自伴随分开
130|3.6.2|定义|A symmetric numerical method satisfies G_(-h)=G_h^-1.|symmetricMethod|defined|步映射equivalence
130|3.6.2|定义|Definition 3.1: affine invariance transports a method on f to the method on A f A^-1.|affineInvariant|defined|原定义只含线性A，无平移；保留区分
130|3.6.2|未编号结论|Symmetry and affine equivariance imply reversibility on an R-reversible field.|symmetricAffineReversible_statement|statement_only|步长符号相容性是独立必要条件，须明示
130|3.6.2|未编号结论|Runge-Kutta methods are affine invariant.|rkAffine_statement|statement_only|实际阶段方程运输；可有限和证明
130|3.6.2|未编号结论|Partitioned RK is affine invariant and symmetric methods preserve reversibility.|partitionedAffine_statement|statement_only|仅保留分块线性变换；原文任意混合q,p的全称过强，字面Prop待审
131|3.6.3|未编号结论|Symplectic Euler is symplectic but not time reversible for momentum reversal.|symplecticNotReversible_statement|statement_only|具体单位振子反例
131|3.6.3|定义|Trapezoidal rule is Z=z+h(f(z)+f(Z))/2.|trapezoidalRelation|defined|隐式关系
131|3.6.3|未编号结论|Trapezoidal rule is reversible but generally not symplectic.|trapezoidalProperties_statement|statement_only|给非线性实际局部解反例；待证
131|3.6.3|未编号结论|Eigenvalues of a real Hamiltonian matrix J A with A symmetric occur in +/- and conjugate pairs.|hamiltonianSpectrum_statement|statement_only|实际复特征值；不沿用原文同一u作为转置特征向量错误
131|3.6.3|未编号结论|Eigenvalues of a real symplectic matrix occur in reciprocal and conjugate pairs.|symplecticSpectrum_statement|statement_only|复特征值及非零性；一般线性代数基础需复用
131|3.6.3|未编号结论|A reversible linear map with T^-1=R T R also has reciprocal/conjugate eigenvalue pairs.|reversibleSpectrum_statement|statement_only|R可逆、T可逆，谱命题未证
132|3.6.3|未编号结论|Conjugate iterates share transported asymptotic behavior.|textbook_conjugate_iterates;textbook_conjugate_iterates_tendsto_iff|proved|原文homomorphism应homeomorphism；不保证任意处理器同有效阶
132|3.6.3|未编号结论|A reversible map need not preserve phase volume.|reversibleVolumeFailure_statement|statement_only|非线性可逆反例，非线性det逐点可能≠1
132|3.7|定义|Hard cores impose norm(q_i-q_j)≥radius_i+radius_j.|hardCoreDomain|defined|有限粒子欧氏坐标；不混同重叠闭边界约定
132|3.7|定义|An elastic collision adds alpha times the constraint normal to momentum.|elasticReflection|defined|质量度量法向反射，正质量、非零法向
132|3.7|未编号结论|The collision coefficient preserves kinetic energy and normal pair momentum exchange.|elasticEnergy_statement|statement_only|可有限内积代数证明；二元无擦碰
133|3.7|定义|Hard-sphere trajectories concatenate smooth flow segments with collision maps.|collisionComposition|defined|有限事件序列；不宣称无限碰撞/同时碰撞唯一解
133|3.7|未编号结论|The resulting trajectory has continuous positions and piecewise-smooth momenta with finite jumps.|collisionRegularity_statement|statement_only|有限二元非擦碰、事件隔离；待证
133|3.7.1|定义|The hard-sphere potential is zero on nonoverlap and infinite on overlap.|hardCorePotential|defined|扩展非负实数；边界接触不当重叠
133|3.7.1|定义|Primitive splitting is half smooth kick, exact free hard-sphere evolution, half smooth kick.|primitiveSplitting|defined|给定实际freeflow；不以伪代码实现计数学证明
133|3.7.1|未编号结论|Primitive hard-sphere splitting has first-order global error with finitely many collisions.|primitiveOrder_statement|statement_only|横截二元事件、有限间距、正规力；待证
134|3.7.1|定义|For unit mass and a fixed obstacle, alpha=-2 (u dot p)/(u dot u).|obstacleReflection|defined|非零法向
134|3.7.1|未编号结论|A primitive collisional step has leading energy defect -(h-2 t_c)(q_c dot pbar)/(q_c dot q_c)(q_c dot grad U(q_c))+O(h^2).|primitiveDefect_statement|statement_only|实际碰撞族和小h展开；原式endcollision的解释与线性项矛盾待审
134|3.7.1|未编号结论|The leading collision defect vanishes at midpoint impact or zero normal force or grazing momentum.|collisionDefectZero_statement|statement_only|仅前式线性系数，不从endimpact推出一般三阶
135|3.7.2|定义|The collision prediction path is Q(t)=q+t M^-1 p+t^2 M^-1 F(q)/2, (3.18).|collisionQuadraticPath|defined|数学多项式
135|3.7.2|定义|Collision times solve norm(Q_i(t)-Q_j(t))=radius_i+radius_j, (3.19).|collisionTimeRelation|defined|取正时间最小根、须横截
135|3.7.2|未编号结论|Squaring the quadratic-path collision condition yields a quartic polynomial.|collisionQuartic_statement|statement_only|具体系数与正半径等价；可有限代数证明
135|3.7.2|定义|Collisional Verlet takes min(next collision time,hmax), applies Verlet, and reflects if an impact occurs.|collisionalVerletRelation|defined|算法映射关系；不登记根搜索实现
135|3.7.2|未编号结论|Collisional Verlet has second-order accuracy.|collisionalVerletOrder_statement|statement_only|有限非擦碰、稳定事件定位、正外步长；大型非光滑误差理论缺口
136|3.7.3|定义|Pair potentials split into alpha+beta with one radial derivative vanishing at contact.|pairForceDecoupling|defined|原文说second却写alpha'，两种字面约定待审
136|3.7.3|未编号结论|Zero-normal-component impulses permit a second-order hybrid collisional method.|decoupledOrder_statement|statement_only|需要明确哪个势产生kick及事件误差；未证
136|3.7.3|定义|Modified-energy collision projection preserves a finite truncated shadow level.|modifiedCollisionProjection|defined|给关系、不宣称投影唯一或统计准确
"""
index={}
for p in sorted((root/'MolecularDynamics').rglob('*.lean')):
    s=p.read_text(encoding='utf-8-sig');ns=[]
    for i,line in enumerate(s.splitlines(),1):
        if line.startswith('namespace '):ns.append(line[10:].strip())
        if line.startswith('end ') and ns and line[4:].strip()==ns[-1]:ns.pop()
        m=re.match(r'(?:@\[[^\n]*\]\s*)?(?:noncomputable )?(?:def|abbrev|theorem|structure)\s+([\w.]+)',line)
        if m:index.setdefault(m[1],('.'.join(ns+[m[1]]),f'{p.relative_to(root).as_posix()}:{i}'))
rows=[];fields=['id','节号','印刷页','PDF页','类型','原文陈述(英文原句或忠实转述)','Lean声明名','文件:行号','状态','备注']
for line in data.strip().splitlines():
    pg,sec,kind,claim,names,status,note=line.split('|'); full=[];loc=[]
    for name in names.split(';'):
        if name in index:
            n,l=index[name];full.append(n);loc.append(l)
        else:
            full.append('MolecularDynamics.Chapter03Review.'+name)
            mod='Statements' if name.endswith('_statement') else 'ReviewDefinitions'
            loc.append(f'MolecularDynamics/Chapter03/{mod}.lean:1');note+='；计划声明，补齐阶段核实'
    rows.append(dict(zip(fields,[f'CH03-{len(rows)+1:03}',sec,pg,str(int(pg)+22),kind,claim,';'.join(full),';'.join(loc),status,note])))
with target.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=fields);w.writeheader();w.writerows(rows)
print('Chapter 3 inventory',len(rows))
