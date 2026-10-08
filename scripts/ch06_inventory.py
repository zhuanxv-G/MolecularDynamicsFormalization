"""Chapter 6 original-page inventory; no new proof work and no parked imports."""
from pathlib import Path
import csv,json,subprocess,collections
root=Path(__file__).resolve().parents[1];target=root/'docs/review/CH06_CLAIMS.csv'
if target.exists():raise RuntimeError('Maintained inventory already exists')
data='''
214|6.1.1|定义|The isolated system is described by the microcanonical energy-surface distribution.|@Chapter05Review.microMeasure|defined|复用第5章真实正则面加权测度；一般几何识别仍未证
214|6.1.1|定义|Entropy is S(E)=kB log Z(E), (6.1).|entropy|defined|Z为能量面partition，正有限是物理解释前提
215|6.1.1|未编号结论|Independent subsystems have Z_AB=Z_A Z_B and additive entropy.|entropyAdditivity_statement|statement_only|不将固定总能量的卷积partition误作独立固定能量乘积
215|6.1.1|未编号结论|At a differentiable interior entropy maximum under E_A+E_B=E, S_A'=S_B'.|entropyEquilibrium_statement|statement_only|固定总能量、一元内点极值；只陈述
215|6.1.2|定义|The inverse temperature is partial S/partial E, 1/T=S'(E).|inverseTemperature;temperature|defined|真实导数；导数非零才可倒数
216|6.1.2|notation|The inverse thermal energy is beta=1/(kB T), (6.2).|inverseThermal|defined|正kB、正T
216|6.1.2|未编号结论|The large-bath entropy expansion produces a Boltzmann factor exp(-beta E_A) to first order.|bathTaylor_statement|statement_only|局部C2 Taylor余项明确量化；一般热力学极限不在本次范围
216|6.1.2|定义|The canonical energy distribution is proportional to Z_A(E) exp(-beta E).|canonicalEnergyDensity|defined|实际能量积分归一化，正有限分母另需假设
217|6.1.3|定义|The entropy functional is -kB integral rho log rho.|entropyFunctional|defined|0log0按实数log总定义处理；可积性需明确
218|6.1.3|未编号结论|The constrained entropy first variation yields -(1+log rho)-lambda-beta H=0 and hence rho=exp(-1-lambda)exp(-beta H).|entropyVariation_statement|statement_only|正rho、可积变分和约束；不假设Euler-Lagrange结论
218|6.1.3|定义|The canonical Gibbs density is exp(-beta H)/Zcan, (6.3).|canonicalDensity;@textbookCanonicalPartition|defined|复用真实partition；不把密度定义计证明
218|6.1.3|未编号结论|A separable Hamiltonian has a configurational times Gaussian momentum partition.|@textbookLangevinCanonicalPartition_formula|weakened|已有完整单位质量/单位torus公式；一般各坐标质量公式仅陈述partitionMass_statement
218|6.1.3|未编号结论|Smooth potentials bounded below on a compact position torus give a positive finite partition.|@textbookLangevinCanonicalPartition_pos;@textbookLangevinPeriodicGibbsWeight_integrable|proved|既有真实单位质量/周期模型；有限有界域若边界奇异不能仅用内部smooth
219|6.1.3|未编号结论|A confining full-space potential with U(q)>=c norm(q)^p-C has a finite canonical partition.|confiningPartition_statement|statement_only|c,p,beta正；需尾部可积估计，未新增证明
220|6.1.4|定义|Canonical observables may grow polynomially in momentum.|polynomialObservable|defined|q在紧torus；显式uniform polynomial bound
220|6.1.4|定义|The canonical average is the normalized Gibbs integral, (6.4).|@textbookCanonicalAverage;canonicalAveragePrinted|defined|原6.4又乘已归一rho的Z^-1，保留字面与标准版
220|6.1.4|未编号结论|The normalized canonical average of one equals one.|@textbookCanonicalAverage_one|proved|原partition可积即可；此前已验收
221|6.1.5|未编号结论|Equipartition gives Av(p_i squared)=m_i/beta and Av(2K)=Nc/beta.|equipartition_statement|statement_only|一般质量、真实可积Gibbs；既有Gaussian动量measure尚未打包此式
222|6.1.5|未编号结论|The configurational temperature is Av(norm(grad U)^2)/Av(laplacian U)=kB T, (6.5).|configTemperature_statement|statement_only|质量/域及非零分母明确；Prop6.1不是此特定选G的完整包装
222|6.1.5|命题|Proposition 6.1: kB T=Av(G dot grad H)/Av(div G).|@proposition_6_1|proved|复用完整证明；G exp(-beta H)解释为统一有界，两weighted观测量可积；正文球体积除法证明不足，真实双截断替代
222|6.1.5|未编号结论|Integration by parts gives integral div(G exp(-beta H))=0 under the flux hypotheses.|@textbookCanonicalWeightedFlux_integral_divergence_eq_zero;@textbookCanonicalAverage_divergence_eq_beta_lieDerivative|proved|真实全相空间两截断+DCT，未假设目标IBP
223|6.1.5|未编号结论|G=(0,p) produces kinetic temperature; G=(grad U,0) gives configurational temperature; G=(q,0) gives a virial formula.|temperatureChoices_statement|statement_only|完整三个选项一般质量定义；不将G=(q,0)视为periodic
223|6.1.5|未编号结论|Opposite periodic boundary faces cancel for smooth periodic H and G.|@textbookConfigurationCube_integral_divergence_eq_zero|proved|既有真实任意维周期cube散度积分；momentum无穷方向仍需尾部条件
224|6.2|未编号结论|A constant-energy trajectory cannot sample canonical mass on other energies.|energyObstruction_statement|statement_only|给定能量守恒及canonical另一能量集合正测度；不假设采样失败为前提
225|6.2.1|定义|A random walk is X_n=dx sum_(k<n) J_k with X_0=0.|randomWalk;walkIncrement|defined|真实有限和；Rademacher独立同分布条件在结论列明
225|6.2.1|未编号结论|The recurrence X_(n+1)=X_n+dx J_n follows from the finite sum.|walkRecurrence_statement|statement_only|仅陈述，未做新证明
226|6.2.1|未编号结论|Independent centered unit-variance jumps give E X_n=0 and Var X_n=n dx squared.|walkVariance_statement|statement_only|随机变量L2与独立性，不假设二阶和公式
226|6.2.1|定义|The diffusive walk has jumps sqrt(dt) J_k and linear interpolation.|diffusiveWalk;interpolatedWalk|defined|dt正；n项有限和，不用书中含端点的多一项版本
226|6.2.1|未编号结论|On grid points E(Y_l-Y_k)=0 and Var(Y_l-Y_k)=(l-k)dt.|walkGridMoments_statement|statement_only|0<=k<=l；插值区间方差不与时间差完全相同
226|6.2.1|未编号结论|Diffusively rescaled independent Rademacher walks converge in law to the Wiener process.|walkDiffusion_statement|not_formalizable_now|需Donsker函数空间不变性原理及tightness；不是CLT一维极限已证明
227|6.2.1|定义|A vector Wiener process has independent centered Gaussian stationary increments and starts at zero.|@textbookIsWienerVector|defined|实际Mathlib IsPreBrownianReal+vectorGaussian法则；连续版本已有独立证明
227|6.2.1|未编号结论|W(t)-W(s) has Gaussian law with variance abs(t-s), (6.7).|@textbookWienerIncrement_hasLaw;@textbookWienerIncrement_independent|weakened|既有等距网格增量任意T/K与独立性；一般实时间版本通过Wiener定义映射，非独立再证明
227|6.2.1|未编号结论|Wiener paths have an almost surely continuous version.|@textbookWienerVectorContinuousPath_eval|proved|已有实际连续路径版本及逐时刻AE桥接；非连续性作为额外假设
227|6.2.1|未编号结论|Almost every Wiener path is nowhere differentiable.|wienerNondifferentiable_statement|not_formalizable_now|需Brownian路径振荡/几乎处处不可微分析，不新增理论
227|6.2.1|未编号结论|Future Wiener increments are independent of the completed past filtration.|@textbookWienerVectorFuture_independent_completed_filtration|proved|复用真实完成filtration独立；Markov条件概率语义需说明
228|6.2.2|定义|The Ito integral is the mean-square limit of left-point sums.|itoLeftSum;isItoIntegral|defined|实际概率测度/L2余差；存在性不由定义给出
228|6.2.2|定义|The Stratonovich integral uses temporal midpoint values in the sums.|@textbookWienerMidpointSum|defined|真实W时间中点，不混同端点算术中点
228|6.2.2|未编号结论|The self Ito finite sum equals one half of W(T)^2-W(0)^2 minus the quadratic sum.|@textbookWienerSelfItoSum_identity|proved|此前完整有限望远镜恒等
229|6.2.2|命题|Proposition 6.2: the quadratic sum converges to T in mean square.|@textbookWienerQuadraticSum_meanSquare_tendsto|proved|真实preBrownian法则、T>=0；K趋无穷，原最后K趋0为笔误
230|6.2.2|未编号结论|E increment=0, E increment squared=T/K, E increment fourth=3(T/K)^2.|@textbookCenteredGaussian_secondMoment;@textbookCenteredGaussian_fourthMoment|proved|已有真实Gaussian矩；增量law前页映射
230|6.2.2|未编号结论|The quadratic-sum mean-square error is 2T squared/K.|@textbookWienerQuadraticSum_meanSquareError|proved|K>0；原交叉项负号改为正常平方展开
230|6.2.2|未编号结论|Integral W dW=one half(W(T)^2-T).|@textbookWienerSelfItoIntegral_exists;@textbookWienerSelfItoSum_meanSquare_tendsto|proved|实际L2见证与均方极限；不是一般Ito理论
230|6.2.2|未编号结论|Integral W circle dW=one half W(T)^2.|@textbookWienerSelfStratonovichIntegral_exists;@textbookWienerMidpointSum_meanSquare_tendsto|proved|真实时间中点余差整体均方估计，补足原单步O(sqrt dt)启发
231|6.2.2|命题|Proposition 6.3: for smooth deterministic g, the Ito integral is Gaussian with mean zero and variance integral g squared.|@textbookWienerDeterministicIto_proposition63|proved|C1足够，真实L2构造+Gaussian法则，无law结论前置
231|6.2.2|定义|dY=g(t)dW, Y(0)=0 denotes the corresponding integral process, (6.8).|deterministicIntegralProcess|defined|对所有有限时间的真实Ito极限关系；共同AE版本需另外处理
232|6.3|定义|The biased walk uses increments a(X_n,t_n)dt+b(X_n,t_n)sqrt(dt)J_n, (6.9)-(6.10).|biasedWalk|defined|递归初值真实有限离散过程；仅定义
232|6.3|定义|The scalar SDE means X(t)-X(0)=integral a ds+integral b dW, (6.11)-(6.14).|scalarSDE|defined|确定漂移时间积分及真实left-sum极限，不假设ODE导数存在
233|6.3|定义|A system of additive SDEs is dZ=a(Z)dt+B dW, (6.15)-(6.16).|additiveSDE|defined|真实向量积分方程；连续轨道/过程可测条件分列
233|6.3.1|未编号结论|The scalar Ito formula adds one half phi'' b squared dt, (6.17).|itoFormula_statement|statement_only|实际scalarSDE+局部C2/可积/适应条件；一般随机Ito链式法则未证
234|6.3.1|未编号结论|For phi(x,t), the Ito formula also includes phi_t dt, (6.18).|itoTimeFormula_statement|statement_only|原显示phi_t遗漏dt；忠实解释为时间积分项
234|6.3.2|定义|Ornstein-Uhlenbeck dynamics is dX=-gamma Xdt+sigma dW, gamma>0, (6.19).|ouProcess;ouMean;ouVariance|defined|真实scalar积分关系，方差非标准差
234|6.3.2|未编号结论|The OU solution is exp(-gamma t)X0+sigma exp(-gamma t) integral exp(gamma s)dW.|ouIntegratingFactor_statement|statement_only|实际Ito极限、初值确定、gamma正；无新证明
235|6.3.2|未编号结论|The OU marginal law is Gaussian with mean exp(-gamma t)X0 and variance sigma squared(1-exp(-2gamma t))/(2gamma).|ouLaw_statement|statement_only|只单时刻law；不把独立标准Gaussian各时刻视作同一过程
235|6.3.2|未编号结论|With sigma squared=2gamma kB T m, OU laws converge to the Gibbs Gaussian.|ouGibbsLimit_statement|statement_only|弱收敛有界连续test；正gamma、kB、T、m
235|6.3.2|定义|Vector momentum OU has drift -gamma p and independent noise sqrt(2gamma kB T m_i), (6.20)-(6.21).|momentumOU|defined|一般对角质量；仅完整积分关系
236|6.3.3|定义|The finite oscillator bath Hamiltonian includes p_i squared/(2mu_i) and (q_i-Q)^2/(2k).|bathHamiltonian|defined|正文推导用模型，区别于独立介绍数值例子
236|6.3.3|未编号结论|The bath Hamiltonian gives the displayed four coupled Hamilton equations, (6.22)-(6.25).|bathHamiltonEquations_statement|statement_only|真实有限坐标导数；k正、mu正
236|6.3.3|未编号结论|The forced linear bath oscillator has the cosine-sine convolution solution, (6.26).|bathOscillator_statement|statement_only|Omega=(k mu)^-1/2，真实C2强解与有限区间
237|6.3.3|未编号结论|Integration by parts rewrites the convolution using cos and the distinguished momentum.|bathConvolutionIBP_statement|statement_only|Q'=P、Omega非零；实际区间积分
237|6.3.3|定义|Eliminating bath modes gives a finite cosine memory kernel and initial-condition force.|memoryKernel;bathForcePrinted;bathForce|defined|原f的负号与qi-Q推导冲突，保留字面和代入后正号版
237|6.3.3|未编号结论|The reduced momentum equation is P'=-U'(Q)+f(t)-integral memory(t-s)P(s)ds, (6.29).|bathReduction_statement|statement_only|保留原字面负f与代入一致版；未把经验噪声极限当严格结论
238|6.3.3|定义|Langevin dynamics combines Hamiltonian drift, friction and Wiener forcing, (6.30)-(6.33).|langevinMassSDE;@textbookLangevinIntegralSolution|defined|一般质量完整积分式；复用单位质量模型，两者区分
239|6.3.3|定义|Position-dependent matrix friction uses Gamma Gamma transpose and sqrt(2kB T)M^(1/2)Gamma noise, (6.34)-(6.35).|variableFrictionSDE|defined|忠实质量乘法次序；一般Gamma不自动满足目标Gibbs，需要交换/涨落耗散条件
239|6.3.3|未编号结论|The actual Langevin process has the Markov property.|@textbookLangevinPeriodicTransitionKernel_add;@textbookLangevinPeriodicGlobalRandomPhase_condDistrib_completed_history_of_periodic|weakened|复用单位质量/单位周期实际kernel CK及完成history条件期望；原一般质量/variable friction未扩展
240|6.3.4|定义|Neglecting inertia yields Brownian drift -gamma^-1 M^-1 grad U and noise sqrt(2kB T/gamma)M^-1/2, (6.36).|brownianMassSDE;@textbookBrownianIntegralSolution|defined|代数消元定义；严谨Kramers-Smoluchowski极限不宣称已证
240|6.3.4|未编号结论|The scaled Langevin position converges to overdamped Brownian dynamics in the large-friction limit.|overdampedLimit_statement|not_formalizable_now|需明确时间重标度、初值/质量与随机奇异摄动紧性；书只作形式消元
240|6.3.5|定义|The scalar generator is a phi'+one half b squared phi'', (6.38).|scalarGenerator|defined|实际一二阶导数；形式differential expression与闭generator域分开
240|6.3.5|未编号结论|The derivative of E phi(X_t) equals E L phi(X_t), (6.37).|generatorExpectation_statement|statement_only|实际SDE+适应可积支配条件；已有特定Brownian/Langevin模型依赖另见证据登记
241|6.3.6|定义|C-infinity polynomial-growth functions obey a global polynomial bound.|polynomialSmooth|defined|原只约束函数不约束全部导数；不据此自动消边界
241|6.3.6|未编号结论|Exponentially decaying density and appropriate derivative tails permit the drift integration by parts.|fpDriftAdjoint_statement|statement_only|显式实际乘积可积及边界极限；原C1rho不足二阶PDE
242|6.3.6|未编号结论|Two integrations by parts give the scalar Fokker-Planck adjoint and density PDE.|fpEquation_statement;fpAdjoint_statement|statement_only|明确C2rho和所有必要尾部；既有过程特例不能当一般FP理论
242|6.3.6|定义|The scalar forward operator is -(a rho)'+one half (b squared rho)'', called Kolmogorov operator.|scalarForward|defined|真实deriv表达；flat形式伴随不同于Gibbs加权伴随
242|6.3.6|未编号结论|Zero noise reduces the generator to the Lie derivative and its forward operator to Liouville.|zeroNoise_statement|statement_only|逐点代数表达；不构造一般PDE解
243|6.3.7|定义|The vector generator has diffusion one half trace(B transpose Hess(phi)B).|vectorGenerator;vectorForward|defined|B常量，实际有限和二阶导数；multiplicative B需导数作用于B Btranspose rho
243|6.3.7|未编号结论|The vector Ito formula has trace diffusion and yields the vector Fokker-Planck equation.|vectorIto_statement;vectorFP_statement|statement_only|实际additiveSDE/L2随机积分；原dW_i dW_j=dt delta仅启发notation
243|6.3.7|未编号结论|trace(B transpose Hess(phi)B)=sum_ij (B Btranspose)_ij partial_ij phi.|diffusionTrace_statement|statement_only|有限矩阵表达；不做新代数证明
244|6.3.8|定义|The Langevin Kolmogorov operator is -div_q(M^-1 p rho)+div_p((grad U+gamma p)rho)+gamma/beta sum m_i partial_pi²rho, (6.42).|langevinMassForward;@textbookLangevinForwardDifferentialOperator|defined|一般质量表达与已有单位质量表达映射，不混同overdamped逆质量
245|6.4.1|定义|A finite Markov transition matrix has nonnegative rows summing to one.|stochasticMatrix;finiteDistribution|defined|原distribution nonzero应为nonnegative；严格正初值不必要
245|6.4.1|定义|A distribution evolves by row-vector multiplication psi_(n+1)=psi_n Pi.|finiteEvolution|defined|方向i到j；原pi(l)解释颠倒，遵循row convention
245|6.4.1|定义|A state period is the gcd of positive return times; aperiodicity means period one.|returnTimes;period;aperiodic|defined|正整数时间，排除l=0；用Nat.gcd全返回集合
246|6.4.1|定义|Irreducibility means every pair communicates; a stationary distribution is a left eigenvector for eigenvalue one.|irreducible;finiteInvariant|defined|同向可达双向自动量化，不把无向连接当strong connectivity
246|6.4.1|未编号结论|A finite irreducible aperiodic chain has a unique stationary probability and all initial distributions converge to it.|finiteErgodicity_statement|statement_only|非空有限状态、真实Pi^n；不新增Perron-Frobenius理论
247|6.4.2|定义|An additive diffusion on a torus-cylinder has generator b0 dot grad+one half trace(B transpose Hess B).|additiveSDE;vectorGenerator|defined|局部坐标与周期lift；原forward式Hessian phi应为rho
247|6.4.2|未编号结论|A stationary density solves L* rho=0 and yields an invariant probability when the actual evolution is uniquely identified.|stationaryInvariant_statement|statement_only|弱stationarity不自动推出过程不变，需semigroup与generator域桥接
248|6.4.2|未编号结论|Canonical mixing means evolved averages tend to Gibbs averages, including point initial laws.|canonicalMixing_statement|statement_only|真实Markovkernel、任意初值/合适test；非仅形式exp
248|6.4.2|未编号结论|OU time-dependent density is a normalized Gaussian with the displayed mean and variance, (6.44)-(6.45).|ouLaw_statement;ouDensityPrinted;ouDensity|statement_only|原6.44遗漏Gaussian归一因子；字面与标准密度分列
249|6.4.3|定义|For Brownian dynamics M=I,gamma=1, Lf=-grad U dot grad f+beta^-1 laplacian f.|@textbookBrownianGenerator|defined|已有实际一般逆质量版本，取unit即可
249|6.4.3|定义|The Gibbs weighted inner product is integral f g exp(-beta U).|@textbookConfigurationInner|defined|未归一cube内积与真实normalizedtorusL2只差partition系数
250|6.4.3|未编号结论|Brownian integration by parts gives the weighted Dirichlet identity and symmetry.|@textbookBrownianGenerator_inner_dirichlet;@textbookBrownianGenerator_inner_symmetric|proved|完整周期lift/任意正质量；形式对称区别于C2核心已自伴
250|6.4.3|未编号结论|The Brownian generator has nonpositive quadratic form and nonpositive real eigenvalues.|@textbookBrownianGenerator_inner_nonpos;@textbookBrownianGenerator_real_eigenvalue_nonpos|proved|常数在核，所以原negative definite应nonpositive
250|6.4.3|未编号结论|The Gibbs Hilbert generator has a self-adjoint closed realization.|@textbookBrownianGibbsComplexOperator_isSelfAdjoint|proved|复用已验收实际complex闭graph；不是原C2compact核心本身自伴
250|6.4.3|未编号结论|The closed Brownian generator has compact resolvent and isolated discrete real spectrum.|@textbookBrownianGibbsComplexResolvent_isCompact;@textbookBrownianGibbsGeneratorComplexSpectrum_countable;@textbookBrownianGibbsGeneratorComplexSpectrum_isolated|proved|真实normalizedGibbs L2/复谱；182文件内已有接受，不重证明
250|6.4.3|定理|Theorem 6.1: self-adjoint nonpositive discrete spectrum, a positive spectral gap, and exponential convergence of evolved ensemble averages.|theorem61_statement|statement_only|保留完整三部分待证陈述；已有复谱、半群和真实law-L2平均桥接较旧ledger更完整，但教材C2域/所有初始分布及平均术语未统一验收
251|6.4.3|未编号结论|Nonzero spectral points lie to the left of a strictly negative threshold.|@textbookBrownianGibbsGeneratorComplexSpectrum_gap;@textbookBrownianGibbsGeneratorComplexSpectrum_nonpos|proved|既有实际闭算子复谱结论；不据此将完整Theorem6.1标proved
251|6.4.3|未编号结论|For nonnegative unit-mass L2 initial density, actual Brownian ensemble averages converge exponentially.|@textbookBrownianDensityAverage_smooth_exponential|weakened|真实Wiener实际过程+L2 Gibbs density，有限K依赖initial；所有singular初始law未计此式
252|6.4.4|定义|Assumption 1 combines one compact-set accessible interior point and a jointly continuous local transition density.|assumption1;assumption1Printed|defined|字面连续包括t=0，非原点平滑概率密度可实现；修正版仅t>0，忠实保留两版
252|6.4.4|定义|Assumption 2 is a positive proper Lyapunov function with Lphi<=-alpha phi+delta.|assumption2|defined|用compact sublevels描述torus-cylinder趋无穷；不把Harris结论藏进假设
252|6.4.4|未编号结论|The compact accessibility and density conditions yield a minorization bound.|minorization_statement|statement_only|有限正时间真实kernel，小集阈值/aperiodicity尚需条件；已有单位周期conditional依赖登记
252|6.4.4|定理|Theorem 6.2: under Assumptions 1 and 2 on an appropriate Lyapunov sublevel, there is a unique invariant probability and a uniform weighted exponential estimate.|theorem62_statement|statement_only|完整唯一性和alltime bound；一般Harris定理/实际density存在未完成，条件Harris证明不替代假设验证
253|6.4.4|未编号结论|A smooth periodic potential is bounded above and below; an additive energy shift makes its lower bound greater than one.|@textbookUnitPeriodicPotential_bound;@textbookUnitPeriodicPotential_normalization|proved|原同时U周期且q趋无穷U趋无穷矛盾；使用周期bounded及实际shift
253|6.4.4|定义|The Langevin Lyapunov function is phi=H^l with H=norm(p)^2/2+U(q).|@textbookLangevinHamiltonianPower;@textbookLangevinPeriodicHamiltonianPower|defined|单位质量/单位torus；l>=1，U>=1
253|6.4.4|未编号结论|The Hamiltonian part annihilates H^l and p dot grad_p H^l=2lH^l-2lH^(l-1)U.|@textbookLangevinHamiltonianPower_drift_hasDerivAt;@textbookLangevinHamiltonianPower_differentialOperator|proved|实际导数，无目标导数前置
253|6.4.4|未编号结论|The momentum Laplacian is l(l-1)H^(l-2) norm(p)^2+Nc l H^(l-1).|@textbookLangevinHamiltonianPower_momentum_laplacian|proved|保留正确系数；原随后bound遗漏2，另有已证counterexample
253|6.4.4|未编号结论|The printed Laplacian upper bound l(l+Nc-1)H^(l-1) is false in general.|@textbookLangevinLyapunov_printed_laplacian_bound_counterexample|proved|既有具体52>40反例，是原文差异证据，不算原断言证明
254|6.4.4|未编号结论|The corrected Hamiltonian-power Lyapunov drift has a positive linear restoring bound.|@textbookLangevinPeriodicHamiltonianPower_physical_lyapunov;@textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel|proved|真实thermal系数与correct factor2；单位质量模型完整，非一般Theorem6.2
254|6.4.4|定义|The genuine Lie bracket is Dv[u]-Du[v].|lieBracket|defined|实际Fréchet导数，来自已有Chapter08公共依赖
254|6.4.4|未编号结论|Lie brackets are bilinear and skew-symmetric and [u,u]=0.|bracketProperties_statement|statement_only|Mathlib真实Lie括号已有基础支持；本次仅陈述，不作新证明
254|6.4.4|定义|Definition 6.1: drift/noise and iterated brackets span the full tangent space at a point.|@textbookHormanderAt|defined|忠实原定义含drift b0；密度定理所需parabolic版本不能自动混同
255|6.4.4|定义|The unit-mass Langevin drift and independent noise vectors are (p,-grad U-gamma p) and sigma(0,e_i).|@textbookLangevinDrift;@textbookLangevinNoise;@textbookLangevinSeed|defined|真实gradient/坐标；sigma非零
255|6.4.4|未编号结论|The first noise commutators are -sigma(e_i,-gamma e_i), and the resulting 2Nc vectors are independent.|@textbookLangevinDrift_noise_bracket;@textbookLangevinBracketFamily_linearIndependent|proved|真实C2 Jacobian与有限族消元已验收
255|6.4.4|未编号结论|Langevin's noise/bracket fields satisfy the stated Hormander span condition.|@textbookLangevin_hormander_physicalNoise|proved|C-infinity U、positivegamma/thermal；不计transitiondensity存在已证
255|6.4.4|未编号结论|The parabolic Hormander condition implies a positive-time smooth transition density.|hormanderDensity_statement|statement_only|需真正hypoellipticity/Malliavin密度定理、parabolic bracket族；不能仅从含b0原span推出
255|6.4.4|引理|Lemma 6.1: at every positive time every nonempty open set has positive transition probability from every initial point.|@textbookLangevinPeriodicGlobalRandomSolution_physicalNoise_exists_open_pos;lemma61_statement|weakened|完整单位质量/单位周期实际模型已验收；一般正质量/任意周期框架忠实陈述但未推广；原漏Nonempty已补
255|6.4.4|未编号结论|There is a smooth control path realizing any prescribed position and velocity endpoints.|@textbookLangevinControlledEndpoint|proved|既有实际Hermite路径和derivedR，不将控制存在误作随机正概率
256|6.4.4|未编号结论|Uniformly small noise perturbations keep the endpoint within the chosen ball.|@textbookLangevinControlledEndpoint_stable|proved|光滑势局部cutoff/退出时间，未添加globalLipschitz前提
256|6.4.4|未编号结论|Every positive-radius finite-time tube around the smooth Wiener control has positive probability.|@textbookWienerVectorRealControlTube_pos|proved|真实Gaussian独立segments及路径支持；标准vectorWiener
256|6.4.4|未编号结论|The Langevin Gibbs density satisfies the stationary forward differential expression.|@textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero|proved|单位质量真实已归一canonicaldensity，实际operator；不变measure识别仍未证
256|6.4.4|未编号结论|Langevin dynamics is geometrically ergodic and time averages converge to canonical averages.|langevinErgodicity_statement|statement_only|仍缺density实际存在、唯一性/Harris条件验收及canonical实际invariance；不借假设声称完整
256|6.4.4|定义|H1(mu) consists of L2 functions with L2 weak position and momentum derivatives.|@textbookLangevinCanonicalWeakH1;@textbookLangevinCanonicalWeakH1Value;@textbookLangevinCanonicalWeakH1Derivative|defined|已有真实weightedweakH1，使用AE商；不将smooth jet当全H1
257|6.4.4|未编号结论|The H1 norm squared is the L2 value plus the sum of squared coordinate-derivative L2 norms.|@textbookLangevinCanonicalWeakH1_norm_sq|proved|既有完整真实Hilbert范数恒等
257|6.4.4|命题|Proposition 6.4: weighted-mean-zero g in H1 has a forward Poisson solution, unique modulo the Gibbs density.|proposition64_statement;proposition64Relative_statement|statement_only|忠实flat前向字面版与Gibbs加权相对密度修正版分列；printed兼容条件/adjoint测度不一致；Fredholm/compactresolvent/kernel仍缺，封存不恢复
257|6.4.4|未编号结论|Fredholm alternative gives solvability exactly when the right-hand side is orthogonal to the adjoint kernel.|fredholm_statement|statement_only|用actualclosed Hilbertpartialoperator graph与formalAdjoint；compactresolvent待证
257|6.4.4|未编号结论|The only conserved observables are constants and the only flat-forward stationary modes are Gibbs multiples.|kernelConstant_statement|statement_only|C0固定观测量特例已证但roughweightedHilbertkernel未完成；CanonicalKernelConstant封存不计成果
257|6.4.5|定义|The evolving measure is the actual Markov transition applied to the initial measure.|kernelEvolution;kernelAverage|defined|真实kernelcompProd测度；形式exp不是独立收敛级数
258|6.4.5|未编号结论|Forward density evolution and backward observable evolution have the same averaged pairing.|kernelDuality_statement|statement_only|实际kernel积分双重平均，可测可积；不泛化既有Brownian谱对偶到所有Langevin密度
258|6.4.5|未编号结论|An eigenmode density perturbation evolves as rho_eq+alpha exp(lambda t)rho_1 and its average correction decays exponentially.|eigenmodeDecay_statement|statement_only|generator本征向量+实际semigroup/初值正性；Re(lambda)<0，所有smooth函数不自动L2
'''
fields=['id','节号','印刷页','PDF页','类型','原文陈述(英文原句或忠实转述)','Lean声明名','文件:行号','状态','备注'];rows=[]
for line in data.strip().splitlines():
 p,sec,kind,text,names,status,note=line.split('|')
 names=';'.join('MolecularDynamics.'+n[1:] if n.startswith('@') else 'MolecularDynamics.Chapter06Review.'+n for n in names.split(';'))
 rows.append(dict(zip(fields,[f'CH06-{len(rows)+1:03}',sec,p,str(int(p)+21),kind,text,names,'补齐阶段解析',status,note])))
with target.open('w',encoding='utf-8-sig',newline='') as f:
 w=csv.DictWriter(f,fieldnames=fields);w.writeheader();w.writerows(rows)
scan=[]
for page in range(232,286):
 ids=[r['id'] for r in rows if r['PDF页']==str(page)]
 note='正文逐页核对；历史依赖直接映射，无新证明' if page<280 else 'Exercises：不纳入' if page<282 else '第7章：边界核对后排除，不进入新数学工作'
 if page<=234:note='标题/导论/热浴示意：介绍性物理讨论不单列数学结论'
 if page==259:note='记忆核图/数值曲线排除；正文Langevin定义承接到239页'
 scan.append({'pdf_page':page,'printed_page':page-21,'claim_ids':ids,'review_note':note})
(root/'docs/review/CH06_PAGE_SCAN.json').write_text(json.dumps(scan,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
ledger=list(csv.DictReader((root/'docs/audits/2026-10-01-initial/CLAIM_LEDGER.csv').open(encoding='utf-8-sig')))
evidence=[r for r in ledger if r['chapter_section'].startswith('6')]
files=subprocess.check_output(['git','ls-tree','-r','8948420','--','MolecularDynamics/Chapter06'],cwd=root,text=True).splitlines()
registry=[]
for line in files:
 meta,path=line.split('\t');ids=[r['item_id'] for r in evidence if Path(path).name in str(r)]
 registry.append({'file':path,'frozen_git_blob':meta.split()[-1],'ledger_ids':ids,'acceptance':'Historical CLAIM_LEDGER records; fresh full check confirms unchanged source. No new proof.'})
assert len(registry)==182
(root/'docs/review/CH06_EXISTING_EVIDENCE.json').write_text(json.dumps({'frozen_base':'8948420','original_files':182,'files':registry,'ledger_records':evidence,'unmapped_ledger_files':[r['file'] for r in registry if not r['ledger_ids']],'parked_policy':'CanonicalKernelConstant and all parked sources untouched, not imported'},ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'rows':len(rows),'counts':dict(collections.Counter(r['状态'] for r in rows))},ensure_ascii=False))
