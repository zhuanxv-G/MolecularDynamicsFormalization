"""Fresh Chapter 5 inventory; do not turn definitions into completed proofs."""
from pathlib import Path
import csv,json
root=Path(__file__).resolve().parents[1];target=root/'docs/review/CH05_CLAIMS.csv'
if target.exists():raise RuntimeError('Maintained CSV already exists.')
data='''
180|5.1|定义|The Lie derivative is L_f g=Dg[f].|lie|defined|实际Fréchet导数；复用第3章对象
180|5.1|未编号结论|Along an actual trajectory the time derivative of g is L_f g, (5.1).|@hasDerivAt_textbookLieDerivative|proved|既有局部链式法则完整证明；实际解
180|5.1|定义|The observable solution operator is pullback g(F_t(z)).|pullback|defined|实际流，不将形式exp当收敛算子
181|5.1|未编号结论|A differentiable autonomous flow satisfies DF_t(z) f(z)=f(F_t(z)).|flowFieldTransport_statement|statement_only|真实流群/C2条件；不搭一般flow变分理论
181|5.1|未编号结论|The pullback solves partial_t gtilde=L_f gtilde, (5.2).|pullbackPDE_statement|statement_only|给定joint光滑实际流；一般输运PDE未证
181|5.1|未编号结论|Steady solutions of the observable equation are first integrals.|steadyFirstIntegral_statement|statement_only|实际流与所有初值，量词清晰
181|5.1|notation|G_t=exp(t L_f) denotes the solution operator.|solutionOperator|defined|定义为pullback，不证明无界算子的exp构造
181|5.1|未编号结论|The solution operator applied to coordinate projection returns the trajectory coordinate.|coordinatePullback_proved|proved|定义展开的完整证明，不是ODE存在证明
182|5.2.1|定义|A density is measurable, nonnegative and has finite integral.|density;probabilityDensity|defined|显式Lebesgue测度与可积性；归一化单列
182|5.2.1|未编号结论|Every nonnegative density with positive finite integral can be normalized to a probability density.|densityNormalization_statement|statement_only|基础积分理论有支持；本次有限时间盒未推广
182|5.2.1|定义|The density assigns a set its integral over that set.|densityMeasure|defined|真实withDensity，不将所有概率测度误限于AC
182|5.2.1|未编号结论|Open and closed sets and countable unions/intersections of measurable sets are measurable.|borelClosure_statement|statement_only|正文页脚理论逐条量化；Mathlib支持，未新增证明
183|5.2.1|未编号结论|A probability measure assigns every measurable set a value between zero and one.|probabilityBounds_proved|proved|Mathlib概率测度基础引理复用包装
183|5.2.1|定义|L2 consists of AE classes of square-integrable functions, with norm sqrt(integral f²).|L2Space;l2Norm|defined|书中忽略AE商，Lean采用真实Lp；不将原始函数空间称Hilbert
183|5.2.1|定义|The L2 inner product is the integral of the product.|l2Inner|defined|实际Bochner integral
183|5.2.1|未编号结论|The actual L2 norm squared equals its self inner product.|l2NormSquare_statement|statement_only|真实Lp quotient，基础Mathlib支持；单列陈述
183|5.2.1|未编号结论|L2 is a complete Hilbert space.|l2Complete_statement|statement_only|实际CauchySeq趋于极限；不搭新Hilbert理论
183|5.2.1|未编号结论|The L2 inner product is symmetric and bilinear.|l2Symmetry_statement;l2Linearity_statement|statement_only|补可积乘积/平方可积假设；原公式的严格版本
183|5.2.1|未编号结论|Continuous compactly supported functions belong to L2 of Euclidean space.|compactL2_statement|statement_only|实际Lebesgue局部有限测度；基础库支持未深挖
184|5.2.1|定义|The spatial average is integral(g rho)/integral(rho).|densityAverage;average|defined|分母正方可解释平均；average用给定Measure
184|5.2.2|定义|The mass fraction of points in A at time t is integral_A rho(t).|massFraction|defined|实际Lebesgue积分
184|5.2.2|未编号结论|Its derivative is integral_A partial_t rho under differentiation-under-integral hypotheses.|massDerivative_statement|statement_only|一致可积支配界；不搭一般输运解存在理论
184|5.2.2|未编号结论|The derivative of the mass is negative outward flux, and equals negative integral_A div(rho f).|fluxBalance_statement|not_formalizable_now|需边界法向量/曲面测度及散度定理，对长方体给忠实有限面公式
185|5.2.2|定义|The Liouvillian is M_f w=-div(w f).|divergence;liouvillian|defined|实际偏导/trace
185|5.2.2|未编号结论|The transported smooth density satisfies partial_t rho=-div(rho f).|liouvilleEquation_statement|not_formalizable_now|实际体积变换密度与连续性方程；缺一般PDE/几何输运桥接
185|5.2.2|未编号结论|The continuity equation expands as -sum_i(rho partial_i f_i+f_i partial_i rho).|liouvilleProduct_statement|statement_only|局部乘积规则；完整实际导数
185|5.2.2|未编号结论|Integration by parts gives integral u L_f v=integral M_f u v after the boundary term vanishes, (5.4)-(5.5).|liouvillianAdjoint_statement|not_formalizable_now|用C1 compact support给明确消边界条件；形式伴随不是闭算子Hilbert伴随已识别
186|5.2.2|notation|The measure propagator is formally exp(t L_f^*) rho0.|measurePropagator|defined|用真实Measure.map表示，exp仅原文notation
186|5.2.3|未编号结论|A C2 Hamiltonian vector field has zero divergence.|@trace_textbookHamiltonianJacobian_eq_zero|proved|复用既有真实HamiltonianJacobian trace证明
186|5.2.3|未编号结论|For a divergence-free field the differential expressions satisfy M_f=-L_f.|hamiltonianSkewExpression_statement|statement_only|实际differential expression；闭Hilbert skew-adjoint另需domain
187|5.2.3|未编号结论|Forward/backward Hamiltonian density propagation reverses time and preserves total mass.|hamiltonianDensityPropagation_statement|statement_only|给定全时域C2流及体积保留；非一般PDE存在
187|5.2.3|定义|The mechanical forward Liouvillian is -sum_i (p_i/m_i partial_qi+F_i partial_pi).|mechanicalLiouvillian|defined|F=-grad U；质量正解释
188|5.3.1|定义|The test spaces are C-infinity compact support functions and Schwartz functions.|testSpace;schwartzSpace|defined|实际SchwartzMap；正文广义函数需连续性，书只提线性
188|5.3.1|定义|A generalized function is a linear functional on the test space.|distribution|defined|原文代数线性定义；连续分布空间另列缺口
188|5.3.1|定义|A regular generalized function acts by integral f phi.|regularDistribution|defined|先给积分表达；线性需可积条件
189|5.3.1|定义|The Dirac distribution acts by evaluating a test function at zero.|diracAction;diracMeasure|defined|实际点测度与线性评价分别登记
189|5.3.1|未编号结论|A concentrated normalized approximate identity converges weakly to Dirac.|diracApproximation_statement|statement_only|非负总质量1、support缩小；不将点wise收敛误作weak
189|5.3.1|定义|One-dimensional Gaussian approximate Dirac is exp(-z²/(2 epsilon))/sqrt(2 pi epsilon).|gaussianDelta|defined|epsilon>0；分母正
189|5.3.2|定义|A weak stationary distribution annihilates L_f acting on test functions.|weakStationary|defined|对真实measure积分，未混同可微密度
190|5.3.2|定义|The finite-time ensemble average is the normalized density integral, (5.6).|ensembleAverage|defined|不是轨道时间平均
190|5.3.2|未编号结论|Hamiltonian energy is a first integral: L_H H=0.|@textbookPoissonBracket_self;@textbookLieDerivative_hamiltonian_eq_poisson|proved|既有完整自括号/真实Hamiltonian Lie证明联合映射
190|5.3.2|未编号结论|A smooth function of H has zero Hamiltonian Lie derivative and defines an invariant density when integrable.|energyDensityInvariant_statement|statement_only|补归一化与真实全流；原文t导数趋零只为启发，非平均收敛充分条件
190|5.3.2|定义|The energy-shell smooth approximation is exp(-(H-E)²/(2 epsilon)) divided by its partition integral.|shellDensity;shellPartition|defined|可积/非零归一化为适用条件
191|5.3.2|未编号结论|The normalized shell densities converge weakly to the normalized microcanonical measure, (5.7)-(5.8).|shellWeakLimit_statement|not_formalizable_now|需coarea及正则紧能量面/尾部控制；原文rho已归一又乘Z^-1疑重复，保留字面版
191|5.3.2|定义|The geometric microcanonical measure is surface measure weighted by 1/abs(grad H).|energySurface;surfaceMeasure;microRaw|defined|真实Hausdorff measure withDensity；归一化常数不宣称构造已正确识别Riemannian体积
191|5.3.2|未编号结论|A smooth injective regular parameterization has area element sqrt(det(Dg^T Dg)).|surfaceAreaFormula_statement|not_formalizable_now|需曲面面积/coarea/嵌入流形Riemannian volume form；可陈述未证明
192|5.3.2|定义|The unit normal is grad H/abs(grad H) on a regular level surface.|normalField|defined|Euclidean范数；grad采用真实导数
192|5.3.2|未编号结论|A normal energy displacement satisfies dE=abs(grad H) ds+O(ds²).|normalEnergyTaylor_statement|statement_only|局部C2、非零grad；真实余项量化
192|5.3.2|未编号结论|Thickened-shell volume divided by dE tends to integral_surface 1/abs(grad H).|shellVolumeLimit_statement|not_formalizable_now|缺tubular coordinates/coarea/几何Jacobian；明确正则紧性
193|5.3.2|未编号结论|The geometric microcanonical measure is invariant under Hamiltonian flow.|microInvariant_statement|not_formalizable_now|体积与能量守恒并不足以已证曲面测度桥接；需coarea与流正则性
193|5.3.2|定义|The microcanonical partition function is the total raw measure of the energy surface.|microPartition|defined|ENNReal量转实；有限且正是使用条件
194|5.3.3|定义|The microcanonical probability measure is the normalized raw surface measure.|microMeasure|defined|真实Measure scalar normalization；不视为已证概率实例
195|5.3.3|未编号结论|The normalized microcanonical measure has total mass one and all probabilities lie in [0,1].|microProbability_statement|statement_only|明确0<raw mass<infinity；基础归一化部分不需要一般几何理论
195|5.3.3|未编号结论|Lower-dimensional smooth submanifolds have zero microcanonical measure.|lowerDimensionNull_statement|not_formalizable_now|需Hausdorff维数/Lipschitz图像与几何measure桥接；非任意低维拓扑集
195|5.3.3|定义|A microcanonical observable average is integral g against microMeasure, denoted angle brackets.|microAverage|defined|可积观测量；surface密度/ambient奇异measure分清
195|5.4|定义|The finite trajectory average is (1/T) integral_0^T g(z(t)); its infinite limit is (5.9).|timeAverage;hasTimeAverage|defined|T>0；以Tendsto表达极限存在
197|5.4|未编号结论|The time average of a conserved first integral equals its initial value.|conservedAverage_proved|proved|给定轨道守恒值，有限时间积分完全证明；额外第一积分构造另列
197|5.4.1|定义|Definition 5.1: microcanonical ergodicity equates temporal and spatial averages for almost every initial state and every integrable observable.|microErgodic|defined|采用每观测量分别AE；书中共满测集和低维例外表述不严谨，待审
197|5.4.1|定义|Invariant-set ergodicity means every measurable flow-invariant set has probability zero or one.|setErgodic;flowInvariant|defined|真实概率Measure与全实时间流
198|5.4.1|未编号结论|For an invariant set the complement indicator is identically zero along its initial trajectories.|invariantIndicator_proved|proved|集合实际不变性质的完整推导
198|5.4.1|未编号结论|The time-average definition of ergodicity is equivalent to invariant-set zero-one ergodicity.|ergodicTimeAverage_statement|not_formalizable_now|Mathlib有离散ergodic支持；缺本章连续流Birkhoff/积分时间平均桥接，不搭理论
198|5.4.1|未编号结论|A nonergodic system has an invariant set of probability strictly between zero and one.|nonergodicSet_statement|statement_only|显式概率/不变性前提；逻辑等价仅陈述
200|5.4.1|未编号结论|KAM theory predicts invariant torus barriers in suitable near-integrable systems, obstructing energy-surface coverage.|kam_statement|not_formalizable_now|原文只在double-pendulum例中定性引用；陈述为非退化Diophantine torus的持久化，不宣称例5.5参数已满足，需KAM/Nash-Moser与测度版
199|5.4.1|定义|Mixing means transported initial densities converge weakly to the invariant measure.|mixing|defined|对有界连续test与AC初始概率；比单轨道ergodicity强
203|5.5|定义|The temporal correlation is k times average of a(F_t(z)) dot b(z).|correlation|defined|真实vector dot；k归一化须非零零时刻相关
204|5.5|未编号结论|The correlation can be expressed as an observable pullback spatial average.|correlationPullback_proved|proved|定义重写完整证明
204|5.5|未编号结论|For an ergodic flow the correlation equals the trajectory average of a(z(s+t)) dot b(z(s)).|correlationTime_statement|statement_only|AE初值，给定lag逐次量词；semigroup与可积性
204|5.5|定义|Velocity autocorrelation is the correlation divided by its zero-lag value.|velocityCorrelation|defined|分母正才可归一；不假设任意v都非零
204|5.5|定义|The transition probability from A to B at lag t is average(1_A 1_B∘F_t)/average(1_A).|transitionProbability|defined|mu(A)>0；确定流endpoint概率非首达时间
205|5.5|未编号结论|Pushforward/pullback duality gives integral phi against evolved density equals integral phi∘F_t against the initial measure, (5.10).|measureDuality_statement|statement_only|真实Measure.map和可测/可积条件；基础库可用，时间盒保留
205|5.5|未编号结论|Mixing implies correlations converge to the product of means and centered correlations tend to zero.|mixingCorrelation_statement|statement_only|保留原k归一化；印刷极限遗漏k，附修正版
206|5.6|定义|The discrete finite average is n^-1 sum_(k=0)^n g(z_k) in the printed formula.|discreteAveragePrinted;discreteAverage|defined|书写n+1项却除n；补标准n项版，有限n0除零不作概率解释
206|5.6|定义|A numerical method induces a distribution propagator by pushforward.|discretePropagator|defined|真实measure map，不声称modified equation存在
206|5.6|定义|The finite modified field is f+h^r f_r and its forward differential expression splits linearly.|modifiedField|defined|不将BEA形式展开误作实际精确流
206|5.6|未编号结论|The Liouvillian of f+h^r f_r is the sum of the corresponding expressions.|modifiedLiouvillian_statement|statement_only|真实微分运算，补可微条件
207|5.6|未编号结论|Forward Euler oscillator admits only the point mass at the origin as an invariant probability measure for h≠0.|eulerInvariant_statement|statement_only|原文两分量都趋∞并非严格成立；改述范数，delta不吸引
207|5.6|未编号结论|Backward Euler oscillator trajectories tend to zero and every initial probability measure tends weakly to delta0.|backwardEulerLimit_statement|statement_only|h非零；weak有界连续test与真实概率，非点wise密度收敛
207|5.6|未编号结论|Symplectic Euler preserves its modified quadratic oscillator Hamiltonian.|@textbookSymplecticEuler_preserves_modifiedHamiltonian|proved|既有完整有限模型证明，稳定椭圆需abs(h Omega)<2
207|5.6|未编号结论|An integrable normalized density depending on the preserved quadratic invariant remains invariant.|symplecticEulerDensity_statement|statement_only|补线性体积保留与可积；不推一般数值ergodicity
208|5.6|定义|The leading Verlet modified Hamiltonian has the displayed Hessian and force-square h² coefficient.|@Chapter02Review.takahashiPotential;verletShadow2|defined|只定义有限修正函数，不声称全阶形式级数收敛
208|5.6|定理|Theorem 5.1: microcanonical averages for H and H+epsilon eta differ by average(div(g u))-average(g)average(div u)+O(epsilon²),u=epsilon eta w/(w dot grad H).|theorem51_statement|statement_only|紧正则能量面、smooth H/eta/g/w、w dot grad H非零；完整几何平均差量化，未把校正公式假设成前提
209|5.6|定义|The perturbation displacement is u=epsilon eta w/(w dot grad H).|perturbationDisplacement;perturbationCorrection|defined|实际div(g u)而不是grad g dot u；真实Euclidean内积
209|5.6|未编号结论|On a compact energy surface a smooth nowhere-zero w dot grad H is bounded away from zero.|denominatorBound_proved|proved|仅Theorem5.1可直接推出的正则部分；完整micro平均校正未证
209|5.6|未编号结论|The first-order correction vanishes when eta is identically zero.|zeroPerturbation_proved|proved|只证显式校正函数恒等式，不将一般平均扰动定理记proved
209|5.6|未编号结论|Choosing w=grad H satisfies transversality on a regular energy surface.|gradientTransverse_statement|statement_only|有限Euclidean平方范数正；本次不推广几何理论
209|5.6|未编号结论|The perturbation formula applies to dynamical averages viewed as stationary observables.|dynamicalCorrection_statement|statement_only|固定lag的真实光滑pullback observable；流参数扰动不可自动忽略
'''
fields=['id','节号','印刷页','PDF页','类型','原文陈述(英文原句或忠实转述)','Lean声明名','文件:行号','状态','备注'];rows=[]
for line in data.strip().splitlines():
    p,sec,kind,text,names,status,note=line.split('|')
    names=';'.join('MolecularDynamics.'+n[1:] if n.startswith('@') else 'MolecularDynamics.Chapter05Review.'+n for n in names.split(';'))
    rows.append(dict(zip(fields,[f'CH05-{len(rows)+1:03}',sec,p,str(int(p)+21),kind,text,names,'补齐阶段解析',status,note])))
with target.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=fields);w.writeheader();w.writerows(rows)
scan=[{'pdf_page':i,'printed_page':i-21 if i>=200 else 177,'disposition':
    'excluded previous chapter Exercises' if i==199 else 'excluded Exercises' if i==231 else
    'body before Exercises scanned' if i==230 else 'excluded numerical/introductory examples' if i in [217,220,221,222,223] else 'body scanned',
    'claim_ids':[r['id'] for r in rows if int(r['PDF页'])==i]} for i in range(199,232)]
(root/'docs/review/CH05_PAGE_SCAN.json').write_text(json.dumps(scan,ensure_ascii=False,indent=2),encoding='utf-8')
print('CH05 rows',len(rows))
