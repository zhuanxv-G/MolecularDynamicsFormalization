"""Chapter 1 inventory transcribed from the supplied textbook, before new proofs."""
from pathlib import Path
import csv, json
root=Path(__file__).resolve().parents[1]
if (root/'docs/review/CH01_CLAIMS.csv').exists():
    raise RuntimeError('Historical initial inventory script: do not overwrite the maintained claim CSV.')
decls=json.loads((root.parent/'tmp/ch01-review/declarations.json').read_text(encoding='utf-8'))
byname={r['name']:r for r in decls}
# Section | printed page | kind | faithful English paraphrase | existing declaration or new key | status | scope note.
data='''
1.1|5|notation|The wave function is complex valued in the particle position coordinates and time.|waveFunction|statement_only|量子背景；不声称存在解
1.1|5|notation|i is the square root of minus one.|imaginaryUnit|statement_only|复数单位
1.1|5|notation|hbar is Planck's constant.|planckConstant|statement_only|正参数，不登记实验数值
1.1|5|notation|mu_j is the mass of particle j.|quantumMass|statement_only|正质量
1.1|5|定义|U_P is the primitive particle potential energy.|primitivePotential|statement_only|实值位置函数
1.1|5|定义|The Schrodinger equation (1.1) is i hbar d_t Phi = -hbar^2 sum_j Laplacian_j(Phi)/(2 mu_j) + U_P Phi.|schrodingerEquation|statement_only|保留原式13粒子；只定义满足方程关系
1.1|6|定义|The Born-Oppenheimer potential U depends on nuclear positions only.|PotentialEnergy|proved|给定实值函数；不证明量子到经典的近似有效性
1.1|6|未编号结论|For each nuclear coordinate, m_i d^2 q_i/dt^2 = -partial U/partial q_i, equation (1.2).|solution_nBodyEquationAt_of_differentiable|proved|正质量、实际二阶导数、势可微、存在区间
1.1|6|定义|Initial positions and velocities at a specified time supplement Newton's equations.|initialData|statement_only|初值关系
1.1|7|定义|Hard spheres are impenetrable and interact by perfectly elastic collisions.|hardSphereCollision|statement_only|瞬时碰撞模型；不证明事件驱动解存在
1.1.1|8|notation|q_i is the position vector of atom i in R^3.|ParticleVectors|proved|d=3实例；通用d接口
1.1.1|8|定义|The potential is a sum of two-body contributions U_ij(q_i,q_j).|twoBodyTerms|statement_only|有限索引
1.1.1|8|定义|Three-body contributions are U_ijk(q_i,q_j,q_k).|threeBodyTerms|statement_only|有限索引
1.1.1|8|定义|Four-body contributions are U_ijkl(q_i,q_j,q_k,q_l).|fourBodyTerms|statement_only|有限索引
1.1.1|8|定义|The Morse potential is D(1-exp(-a(r-r_e)))^2.|morsePotential|statement_only|D,a,r_e正；r>0物理域
1.1.1|8|未编号结论|The Morse potential has its minimum at r_e and well depth D.|morseMinimum|statement_only|D,a正；深度是无穷远极限减最小值
1.1.1|9|定义|The harmonic length-bond potential is k_ij/2 (r_ij-r_ij^0)^2.|lengthBond|statement_only|正弹性系数
1.1.1|9|notation|r_ij = norm(q_i-q_j).|pairDistance|statement_only|三维欧氏范数
1.1.1|10|定义|London dispersion is modeled by -K/r^6 with K>0.|dispersionPotential|statement_only|r>0
1.1.1|10|定义|The Buckingham potential is A exp(-Br)-C/r^6, with A,B,C>0.|buckinghamPotential|statement_only|r>0
1.1.1|10|定义|The Lennard-Jones potential is 4 epsilon ((sigma/r)^12-(sigma/r)^6).|lennardJonesPotential|statement_only|epsilon,sigma,r正
1.1.1|11|未编号结论|The Lennard-Jones potential tends to positive infinity as r tends to zero.|lennardJonesSingularity|statement_only|右极限，正epsilon及sigma
1.1.1|11|定义|For different atom types epsilon_ij and sigma_ij determine the pair LJ contribution.|heterogeneousLJ|statement_only|逐对参数
1.1.2|12|定义|The Coulomb potential is C Q_i Q_j/(dielectric r_ij).|coulombPotential|statement_only|正dielectric、C，非碰撞
1.1.2|12|未编号结论|Coulomb forces attract opposite charges and repel charges of the same sign.|coulombForceSign|statement_only|径向负导数的符号
1.1.2|12|定义|A cutoff potential vanishes for r>r_cut and should remain at least continuously differentiable.|smoothCutoff|statement_only|性质定义；不证明任意截断连续
1.1.2|12|定义|The screened Yukawa potential is C Q_i Q_j exp(-r_ij/lambda)/(dielectric r_ij).|yukawaPotential|statement_only|正Debye长度
1.1.2|13|定义|An angle bond has energy k_ijk/2 (theta_ijk-theta_ijk^0)^2.|angleBond|statement_only|正系数
1.1.2|13|定义|theta_ijk = arccos((q_i-q_j) dot (q_j-q_k)/(r_ij r_jk)).|bondAngle|statement_only|忠实保留印刷向量方向；非零键长
1.1.2|13|定义|A dihedral potential is k(1+cos(n theta-d)).|dihedralPotential|statement_only|角参数；位置到二面角原文未给公式
1.1.2|14|定义|Stillinger-Weber models contain two-body and three-body terms favoring tetrahedral structures.|stillingerWeberTerms|statement_only|原文仅定性说明；形式式只陈述分解，不断言结构极小性
1.1.2|14|定义|Embedded Atom potentials include local electron-cloud density contributed by neighbors.|embeddedAtomPotential|statement_only|原文未指定函数；以任意密度/嵌入函数参数化
1.1.2|14|定义|Bond Order potentials depend on the local bonding structure.|bondOrderPotential|statement_only|原文未指定公式；依赖环境的系数
1.1.2|15|定义|United-atom models group atoms into pseudoatoms and sum their effective interactions.|unitedAtomModel|statement_only|只形式化分组对象；不登记介绍性数值例子
1.1.2|16|notation|Gay-Berne uses separation q_12=q_2-q_1 and unit orientation vectors u_1,u_2.|gayBerneGeometry|statement_only|非零分离
1.1.2|16|定义|The Gay-Berne potential is 4 epsilon_GB[(sigma_0/rho)^12-(sigma_0/rho)^6].|gayBernePotential|statement_only|保留模型定义，排除原文数值参数演示
1.1.2|16|定义|epsilon_GB = epsilon_1(u_1,u_2) epsilon_2(r_hat,u_1,u_2)^2.|gayBerneWell|statement_only|原式指数2
1.1.2|16|定义|rho = norm(r)-sigma_0/sqrt(W(r_hat,u_1,u_2,chi)).|gayBerneRho|statement_only|物理参数域W正
1.1.2|17|定义|epsilon_1 = epsilon_0 [1-chi^2 (u_1 dot u_2)^2]^(-1/2).|gayBerneEpsilonOne|statement_only|根号内正
1.1.2|17|定义|epsilon_2 = W(r_hat,u_1,u_2,chi_prime).|gayBerneEpsilonTwo|statement_only|代入定义
1.1.2|17|定义|W = 1-chi/2[(r_hat dot (u_1+u_2))^2/(1+chi u_1 dot u_2)+(r_hat dot (u_1-u_2))^2/(1-chi u_1 dot u_2)].|gayBerneW|statement_only|分母非零
1.1.2|17|定义|chi=[(sigma_e/sigma_s)^2-1]/[(sigma_e/sigma_s)^2+1].|gayBerneChi|statement_only|正形状参数
1.1.2|17|定义|chi_prime=[1-(epsilon_e/epsilon_s)^(1/mu)]/[1+(epsilon_e/epsilon_s)^(1/mu)].|gayBerneChiPrime|statement_only|正能量参数，mu非零
1.2|18|notation|q is the vector of all positions.|Position|proved|有限维欧氏空间
1.2|18|notation|qdot is the velocity vector.|Velocity|proved|实际轨迹导数见LocalTrajectories
1.2|18|notation|M is a diagonal mass matrix.|diagonalMassMatrix|proved|固定对角质量
1.2|18|定义|F(q) = -gradient U(q).|Force|weakened|Force只给类型；忠实关系需补Prop陈述
1.2|18|定义|The compact Newton equation is M qddot = F(q), (1.3).|NBodyEquationAt|proved|质量作用按坐标，实际二阶导数
1.2|18|notation|N_c=3N is the number of position coordinates in three dimensions.|particleCoordinateEquiv|proved|Fin N × Fin 3与Fin (N*3)等价
1.2|18|notation|M=diag(m_1,m_1,m_1,...,m_N,m_N,m_N).|coordinateMassesOfParticles|proved|每粒子质量重复d次，d=3
1.2|18|定义|Degrees of freedom count the local directions in which configuration can vary.|degreesOfFreedom|statement_only|用局部正则约束导数核的维数
1.2|18|未编号结论|Without constraints N_d=N_c=3N; r independent constraints give N_d=N_c-r.|constraintDimension|statement_only|满秩导数，r≤N_c
1.2|18|定义|Kinetic energy is sum_j m_j norm(qdot_j)^2/2.|particleKineticEnergy|proved|有限粒子任意d
1.2|18|定义|Total energy is kinetic energy plus U, (1.4).|nBodyTotalEnergy|proved|展开坐标形式等价粒子形式
1.2|19|未编号结论|The derivative of total energy along Newtonian solutions vanishes.|mechanical_energy_hasDerivAt_zero|proved|真实导数与势梯度关系
1.2|19|未编号结论|Total energy is constant along a solution.|mechanical_energy_const_on_Ioo|proved|开放连通时间区间；非全局存在假设
1.2|19|notation|E denotes the fixed energy value; the energy function is distinguished from this parameter.|fixedEnergy|statement_only|能量层参数
1.2|19|未编号结论|Pair forces obey F_ij=-F_ji and the sum of internal forces vanishes.|pairForceCancellation|statement_only|只陈述反对称内部力；外力不计
1.2|19|定义|Momentum satisfies dp_i/dt = F_i and p_i=m_i qdot_i.|momentum_eq_mass_deriv_position|proved|固定正质量
1.2|19|定义|The total momentum vector is sum_i p_i.|totalMomentumCoordinate|proved|按方向求和，逐坐标向量等价
1.2|19|未编号结论|Each component of total momentum is conserved when the net force vanishes.|totalMomentumCoordinate_const_on_Ioo|proved|净力零是物理结构假设
1.2|19|定义|A unit-mass harmonic oscillator satisfies xdot=v, vdot=-Omega^2 x.|harmonicPotential|proved|Omega参数；实际解另行映射
1.2|20|未编号结论|The harmonic solution is x(t)=xi cos(Omega t)+eta sin(Omega t)/Omega.|harmonicFlow_isMechanicalSolution|proved|Omega非零；位置与动量同时给出
1.2|20|定义|For one degree of freedom E(x,v)=v^2/2+U(x).|scalarPotentialEnergy|proved|原式单位质量
1.2|20|未编号结论|At a nonturning point v0!=0 the energy level solves smoothly for v=V(x;xi,eta).|scalarPotential_localDescription|proved|U光滑；局部表示，真实隐函数条件
1.2|20|未编号结论|The reduced separable equation can be integrated and locally inverted to describe the solution.|scalarPotential_exists_localIVP_integrable|proved|非转向初值，局部时间窗
1.2|20|未编号结论|Global scalar solutions require concatenating local descriptions; degenerate turning points need separate treatment.|scalarGlobalPatching|statement_only|不把已有局部证明当全局拼接
1.2|21|定义|A uniform pairwise LJ model sums phi_LJ(r_ij) over unordered pairs.|uniformLJEnergy|statement_only|模型定义保留；argon数值单位及数值例子排除
1.2|21|未编号结论|The force for a radial pair potential follows by the chain rule.|radialPairForce|statement_only|印刷首个等式符号待审，数学陈述用负梯度
1.3|22|定义|The Lagrangian is L(q,v)=v^T M v/2-U(q).|massLagrangian|proved|固定正对角质量
1.3|22|定义|The principle of least action is a variational characterization of the equations.|leastAction|statement_only|本章原文明确将推导推迟至第2章；仅忠实驻值陈述
1.3|23|定义|Euler-Lagrange equations are d/dt(partial L/partial qdot)=partial L/partial q.|IsEulerLagrangeTrajectoryOn|proved|按梯度/实际导数陈述
1.3|23|未编号结论|Newton's equations can be written as the Euler-Lagrange equations.|mechanicalSolution_eulerLagrange|proved|固定质量，势可微
1.3|23|notation|Generalized coordinates Q parameterize q=Phi(Q), possibly with fewer coordinates.|generalizedCoordinates|statement_only|参数化需正则；不假设全球可逆
1.3|23|未编号结论|Under q=Phi(Q), qdot=Phi'(Q) Qdot.|hasDerivAt_coordinateChange|proved|实际可微Phi与Q
1.3|23|定义|The generalized mass matrix is Phi'(Q)^T M Phi'(Q).|generalizedMassMatrix|proved|矩阵维数Nd×Nd
1.3|23|未编号结论|The transformed Lagrangian is Qdot^T Phi'^T M Phi' Qdot/2-U(Phi(Q)).|massLagrangian_coordinateChange|proved|给定Jacobian线性作用的代数等式
1.3|23|未编号结论|A full-rank regular transformation gives an invertible generalized mass matrix.|generalizedMassMatrix_isUnit|proved|正质量、Jacobian单射
1.4|24|定义|The convex Legendre transform is gtilde(eta)=sup_theta(eta^T theta-g(theta)).|legendreTransform|statement_only|允许扩展实值避免未界实数sup
1.4|24|未编号结论|For a mechanical quadratic L the maximizing velocity is M(q)^(-1)p.|legendre_objective_eq_massHamiltonian_iff|weakened|已证固定正对角质量；一般位置相关SPD质量待忠实陈述
1.4|24|定义|p=partial L/partial qdot=M(q) qdot.|hasGradientAt_massLagrangian_velocity|weakened|固定质量；一般质量逐点版本补陈述
1.4|24|定义|H(q,p)=p^T M(q)^(-1)p/2+U(q).|massHamiltonian|weakened|固定正对角质量；一般质量版本补陈述
1.4|24|未编号结论|The mechanical Hamiltonian is the Legendre supremum of L in velocity.|massHamiltonian_eq_legendre_sup|weakened|固定正对角质量；正定性强于原文字面仅可逆，原文缺条件
1.4|24|定义|Hamilton's equations are qdot=partial H/partial p and pdot=-partial H/partial q.|hamiltonianVectorField|proved|梯度接口，未声称一般L全部等价
1.4|24|未编号结论|For constant mass Hamilton's equations reduce to qdot=M^-1 p and pdot=-gradient U.|hamiltonianVectorField_eq|proved|势可微，固定正对角质量
1.4|25|未编号结论|The Hamiltonian and Lagrangian formulations are interchangeable for regular mechanical models.|generalLegendreEquivalence|statement_only|一般位置相关质量与正则域，不扩展证明
1.4|25|定义|Phase space consists of positions and momenta for which energy is finite.|PhaseSpace|weakened|已有类型为全欧氏积；奇异势的有限能量域补陈述
1.4|25|notation|An N-particle phase point in three dimensions has 6N real coordinates.|phaseDimension|statement_only|位置与动量各3N
1.5|25|未编号结论|Smooth molecular Hamiltonian systems have locally unique solutions.|exists_localMechanicalIVP_open|proved|力C1，开放非奇异位置域，正质量
1.5|25|定义|Sigma_E0={(q,p):H(q,p)=E0}.|energySurface|statement_only|实值H的指定能量层
1.5|25|未编号结论|If U>=Umin, then kinetic energy at energy E0 is at most E0-Umin.|kineticEnergyBound|statement_only|直接能量代数
1.5|25|未编号结论|Positive definite M^-1 implies momenta are bounded at fixed energy.|momentum_norm_le_of_energy|proved|固定正对角质量、势下界
1.5|25|未编号结论|At energy E0 one has Umin<=U(q)<=E0.|positionEnergyBound|statement_only|动能非负，势下界
1.5|26|未编号结论|Uniformly bounded potential levels together with energy conservation confine solutions to a compact set.|isCompact_phaseEnergySublevel|weakened|已有紧子水平集条件；补原文一致有界层与闭域陈述
1.5|26|未编号结论|Smooth solutions confined to a compact nonsingular set extend globally.|exists_globalMechanicalSolution_of_local_compact_confinement|proved|紧集在开放力C1域内部，真实延拓链
1.5|26|定义|A confining potential prevents unbounded position motion at fixed energy.|confiningPotential|statement_only|有界子水平集，奇异域需另约束
1.5|26|未编号结论|U(x,y)=x^2 does not bound y at constant energy.|nonconfiningExample|statement_only|正文用于解释假设的数学反例；非数值例子
1.5.1|26|定义|The flow F_t(xi)=z(t) solves zdot=f(z), z(0)=xi, (1.5).|IsGlobalMechanicalFlowOn|proved|机械系统接口；通用ODE原式补陈述
1.5.1|26|未编号结论|F_(-t) F_t = identity.|globalMechanicalFlow_inverse|proved|全局解及局部唯一性由C1保证
1.5.1|26|未编号结论|F_t F_s=F_s F_t=F_(t+s); the flow forms an Abelian group.|globalMechanicalFlow_commute|proved|既有add与commute定理，全局域
1.5.1|26|未编号结论|Hamiltonian flows conserve H: H(F_t(xi))=H(xi).|globalMechanicalFlow_energy|proved|机械保守力；已实际证明
1.5.1|27|定义|The oscillator phase flow has the explicit sine-cosine position and momentum formula.|harmonicFlow|proved|非零频率时，与打印公式相符
1.5.1|27|未编号结论|If A has an eigenbasis, z(t)=sum_i c_i exp(lambda_i(t-t0)) eta_i.|complexExponentialFlow_eigenbasis|proved|有限维复数特征基，允许实矩阵的复特征值
1.5.1|27|未编号结论|For real A and real initial data, complex spectral expansion gives a real solution.|realMatrix_complexSpectral_sum_isReal|proved|共轭不变性，未假设所有特征值实
1.5.1|27|未编号结论|The eigenvector column matrix X is invertible and coefficients satisfy xi=Xc.|basisColumnMatrix_inverse_coefficients|proved|真实基，repr系数
1.5.1|27|未编号结论|The linear IVP solution is z(t)=exp(A(t-t0))xi.|matrixExponentialFlow_unique|proved|所有有限实方阵，不要求可对角化
1.5.1|27|定义|exp(A)=I+A+A^2/2!+A^3/3!+... .|matrixExponential_series|proved|NormedSpace.exp与收敛级数一致
1.5.1|28|未编号结论|The exponential series converges for every matrix.|matrixExponential_series|proved|完整HasSum含收敛，不重复证明
1.5.2|28|定义|A first integral is a smooth scalar function constant along every solution.|IsFirstIntegralOn|proved|开放位置域与解区间接口
1.5.2|28|未编号结论|A smooth I is a first integral exactly when gradient I dot f=0 everywhere.|isFirstIntegralOn_iff_differential|proved|f局部C1、I可微、开放域；微分作用等价内积
1.5.2|28|未编号结论|A regular planar first-integral level can locally be solved as y=psi(x).|exists_planarFirstIntegral_C1Graph|proved|对y偏导非零，不遗漏隐函数条件
1.5.2|28|未编号结论|Substitution gives xdot=g(x,psi(x)), a separable scalar equation.|planarFirstIntegral_localGraph_reduction|proved|局部正则图
1.5.2|28|未编号结论|Separable equations with nonzero speed admit a local quadrature solution.|planarFirstIntegral_nonturning_quadrature|proved|非转向区间，真实积分与逆函数
1.5.2|28|未编号结论|The scalar mechanical system is integrable by its energy first integral.|scalarPotentialEnergy_isFirstIntegral|proved|单位质量、U光滑；全局拼接另条
1.5.2|29|定义|The planar fixed-center Kepler energy is (xdot^2+ydot^2)/2-1/sqrt(x^2+y^2).|keplerPotential|proved|排除原点，单位质量与引力常数
1.5.2|29|未编号结论|Kepler energy is conserved.|kepler_energy_const_on_Ioo|proved|非碰撞开放解区间
1.5.2|29|未编号结论|Kepler angular momentum l_z=x ydot-y xdot is conserved.|kepler_planarAngularMomentum_const_on_Ioo|proved|非碰撞，平面模型
1.5.2|29|定义|Polar coordinates are (x,y)=(r cos theta,r sin theta).|polarCoordinateMap|proved|r>0时局部正则
1.5.2|29|未编号结论|In polar variables L=rdot^2/2+r^2 thetadot^2/2+1/r.|keplerPolarLagrangian_identity|proved|代数恒等式，非零半径物理域
1.5.2|29|未编号结论|Polar Euler-Lagrange equations give rddot=-1/r^2+r thetadot^2 and d_t(r^2 thetadot)=0.|keplerPolar_eulerLagrange_iff|proved|r非零，真实一阶/二阶导数
1.5.2|29|未编号结论|l_z=r^2 thetadot.|polarAngularMomentum_identity|proved|展开平面坐标恒等式
1.5.2|29|未编号结论|Fixing l_z reduces the radial equation to rddot=-1/r^2+l_z^2/r^3.|keplerPolar_radial_reduction|proved|解区间内固定角动量
1.5.2|30|定义|The radial energy is rdot^2/2-1/r+l_z^2/(2r^2).|keplerRadialEnergy|proved|实际径向函数
1.5.2|30|未编号结论|The Kepler radius can be expressed via scalar quadratures and their inverses.|keplerRadial_nonturning_quadrature|weakened|已有非转向局部窗；不能声称一般全局轨道已解，补忠实全域拼接陈述
1.5.2|30|未编号结论|theta(t)=theta(0)+integral_0^t l_z/r(s)^2 ds.|keplerPolar_angle_integral|proved|正半径，区间含0，可积/连续
1.5.2|30|未编号结论|The complete Kepler motion is reconstructed from radial quadrature and angular integration.|exists_kepler_localIVP_radialReconstruction|weakened|已证局部重建，未证穿越全部转向点的全局拼接
1.5.2|30|定义|Oscillator action-angle coordinates satisfy x=sqrt(2I/Omega)cos(theta), v=sqrt(2I Omega)sin(theta).|harmonicActionPosition|proved|I>0、Omega>0；另函数harmonicActionVelocity
1.5.2|30|未编号结论|In action-angle variables E=I Omega.|harmonicAction_energy|proved|正I及正频率
1.5.2|30|未编号结论|The oscillator equations become Idot=0 and thetadot=-Omega.|harmonicAction_ode_iff|proved|非退化局部坐标
1.5.2|30|未编号结论|theta(t)=theta(0)-Omega t gives the action-angle solution.|harmonicAction_explicit_solution|proved|正I/Omega、常数action
1.5.2|30|定义|d decoupled oscillators rotate on a d-dimensional torus with constant actions.|HarmonicTorus|proved|角环面；phase实现见harmonicTorusPhase
1.5.2|30|未编号结论|Commensurate frequencies yield periodic torus motion.|harmonicTorusRotation_periodic_iff_integer|proved|周期存在等价每频率乘周期为整圈
1.5.2|30|未编号结论|Incommensurate frequencies yield nonperiodic quasiperiodic motion filling a torus.|harmonicTorusRotation_two_dense|weakened|仅2维无理频率比稠密；高维须所有整数关系无共振，补原意陈述
1.5.2|30|未编号结论|Independent first integrals in involution permit a local action-angle reduction.|liouvilleArnold|statement_only|需紧连通正则共同能量层等条件；原文省略，不建设完整理论
1.5.3|31|定义|An equilibrium of zdot=f(z) solves f(z*)=0, (1.6).|equilibriumDefinition|statement_only|通用有限维ODE
1.5.3|31|未编号结论|An equilibrium gives a constant solution.|equilibrium_constant_ode_iff|proved|实际HasDerivAt
1.5.3|31|未编号结论|For C1 f near z*, f(z)=f(z*)+f'(z*)(z-z*)+o(norm(z-z*)).|equilibriumLinearizationRemainder_of_C1|proved|实际小o而非不明确近似符号
1.5.3|31|定义|The linearization is delta_z_dot=f'(z*) delta_z.|equilibrium_linearized_IVP|proved|有限维Banach接口
1.5.3|31|定义|Hyperbolic means every eigenvalue of f'(z*) has nonzero real part.|hyperbolic|statement_only|复数特征向量判据
1.5.3|32|未编号结论|Hartman-Grobman: nonlinear and linear systems near a hyperbolic equilibrium are conjugate by a smooth invertible local map.|hartmanGrobmanLiteral|statement_only|忠实保留smooth，通常定理仅homeomorphism；疑似原文过强，不能证明假命题
1.5.3|32|定义|Lyapunov stability means for every epsilon>0 there is delta>0 such that all future flow points stay within epsilon.|IsFutureMechanicalStableEuclidean|proved|采用真实未来解及欧氏相空间距离；sup严格版本补陈述
1.5.3|32|未编号结论|Stability of a hyperbolic nonlinear equilibrium is determined by stability of its linearization.|hyperbolicStabilityTransfer|statement_only|局部共轭与完整未来轨迹；原文smooth疑点另条
1.5.3|32|未编号结论|At a mechanical Hamiltonian equilibrium p*=0 and gradient U(q*)=0.|IsMechanicalEquilibrium|proved|已有定义含真实向量场关系；固定正质量
1.5.3|32|定义|A strong local minimum q* means 0<norm(q-q*)<epsilon implies U(q)>U(q*).|IsStrictPotentialMin|proved|严格局部极小，不等于Hessian正定
1.5.3|32|定理|Theorem 1.1: a strong local minimum of smooth U gives stable z*=(q*,0).|strictPotentialMin_futureStableEuclidean_of_smooth|proved|正固定质量，U在q*附近光滑，欧氏稳定及未来解存在
1.5.3|32|定义|The linearized Hamiltonian is delta_p^T M^-1 delta_p/2+delta_q^T U''(q*) delta_q/2.|linearizedHamiltonianQuadratic_eq_textbook_form|proved|真实Hessian二次形式，C2
1.5.3|33|未编号结论|A positive definite Hessian makes the quadratic Hamiltonian a strong local minimum.|positiveHessianQuadraticMinimum|statement_only|非负性已有；严格极小另行忠实陈述
1.5.3|33|未编号结论|Positive distinct Hessian eigenvalues imply a strong local minimum of U.|positiveHessianMinimum|statement_only|distinct非必要但忠实保留；C2
1.6|33|定义|Uniform pair potential energy is sum_{i<j} phi(abs(x_i-x_j)).|uniformPairPotentialEnergy|proved|有限1维粒子
1.6|33|未编号结论|The unordered pair count is N(N-1)/2.|unorderedPairCount|statement_only|自然数除法
1.6|33|定义|Nearest-neighbor energy is sum_{i=1}^{N-1} phi(abs(x_{i+1}-x_i)).|nearestNeighborPotentialEnergy|proved|N+1站点的Fin N索引
1.6|33|定义|Walled chain energy is phi_c(abs(x_1))+phi_c(abs(L-x_N))+nearest-neighbor sum, (1.7).|walledNearestNeighborPotentialEnergy|proved|固定端墙，可任意势
1.6|33|定义|Periodic chain energy adds phi(abs(L+x_1-x_N)), (1.8).|boxPeriodicNearestNeighborPotentialEnergy|proved|真实L偏移，非仅抽象循环
1.6|34|定义|Periodic boundary coordinates identify x with x+L.|periodicBoundary|statement_only|L>0，加性圆/商
1.6|34|未编号结论|Periodic boundary conditions preserve translations and thus momentum for internal pair forces.|boxPeriodicNearestNeighborPotentialEnergy_translate|weakened|已有能量平移恒等式；实际周期模型力与动量守恒补陈述
1.6|34|定义|A one-dimensional regular lattice consists of points separated by fixed delta_x.|regularLattice|statement_only|正间距，有限格点
1.6|34|未编号结论|For a uniform pair potential with periodic boundaries energy minimizers are regular lattices.|regularLatticeMinimizer|statement_only|原文对任意均匀势过强，需额外凸性/密度条件；保留字面陈述待审
1.6|35|定义|In 3D PBC, U sums phi_ij(q_i,q_j+L(k,l,m)) over neighboring image cells and i<j.|periodicImageEnergy|statement_only|忠实有限27副本公式，不能等同无限求和
1.6|35|定义|The minimum-image convention uses the nearest periodic replica of another atom.|minimumImage|statement_only|最近副本关系，等距时可不唯一
1.6|35|定义|A planar rhombic lattice has sides n_x,n_y and included angle theta.|rhombicLattice|statement_only|正边长、非退化角
1.6|35|定义|The hexagonal lattice is the equal-side rhombic lattice at 60 or 120 degrees.|hexagonalLattice|statement_only|角规范，两种基
1.6|35|定义|A unit cell is repeated in coordinate directions to describe an atomic lattice.|unitCellLattice|statement_only|三维格子与有限motif
1.6|35|定义|A bcc unit cell has cubic corners and a body-center atom.|bccCell|statement_only|几何motif，尺度为1
1.6|36|定义|An fcc lattice is an ABCABC stacking of hexagonal layers.|fccStacking|statement_only|层偏移加整数格子；不证明最密堆积
1.6|36|定义|An hcp lattice alternates ABAB hexagonal layers.|hcpStacking|statement_only|层偏移及两层周期
1.6.1|36|未编号结论|At a differentiable interior potential minimum gradient U=0.|minimumGradientZero|statement_only|内部极小、可微；不登记边界极小的错误版本
1.6.1|37|未编号结论|Near equilibrium gradient U(q)=U''(q*)(q-q*)+o(norm(q-q*)).|gradientLinearization_expansion|proved|梯度在q*可微，梯度q*=0
1.6.1|37|定义|Linearized motion is delta_q_dot=M^-1 delta_p, delta_p_dot=-U''(q*) delta_q.|conservative_mechanical_linearization|proved|真实向量场微分及C2
1.6.1|37|未编号结论|At a minimum U'' is a positive definite symmetric matrix.|minimumHessianLiteral|statement_only|字面正定通常应为半正定；x^4反例，不能静默增加非退化假设
1.6.1|37|定义|The Hamiltonian block matrix A has blocks 0,M^-1,-U''(q*),0.|mechanicalLinearization|proved|CLM块作用等价矩阵
1.6.1|37|未编号结论|For positive definite M and Hessian, the eigenvalues of A are purely imaginary pairs plus/minus i Omega.|imaginarySpectrum|statement_only|不把条件性normal mode当完整谱定理
1.6.1|37|未编号结论|An imaginary eigenpair gives conjugate exponential normal-mode solutions.|normalModeComplex|statement_only|共轭对、实矩阵
1.6.1|37|未编号结论|Real normal modes are alpha[sin(Omega t)Re eta+cos(Omega t)Im eta]+beta[cos(Omega t)Re eta-sin(Omega t)Im eta].|hasDerivAt_realNormalMode|proved|真实特征向量分解作用假设；未自动构造全套模式
1.7|38|定义|Central pair potentials have U_ij=phi_ij(norm(q_i-q_j)), U=1/2 sum_{i!=j} U_ij.|centralPairEnergy|statement_only|对称逐对势，非碰撞
1.7|38|未编号结论|For central forces partial_i U_ij=-partial_j U_ij.|centralPairGradient|statement_only|势可微、非碰撞
1.7|39|未编号结论|Central internal forces conserve total momentum.|totalMomentumCoordinate_const_on_Ioo|proved|净力零；结构推出净力另条
1.7|39|未编号结论|Central pair torques cancel and total angular momentum is conserved.|totalAngularMomentum|statement_only|已有单粒子平面版本，不冒充一般N体3D版本
1.7|39|未编号结论|The center of mass moves linearly under zero net force.|centerOfMassMotion|statement_only|正质量、真实二阶Newton轨迹
1.7|39|未编号结论|Zero angular momentum removes net rotation at a constant rate.|rotationLiteral|statement_only|原文由角动量守恒推出定角速度过强；忠实保留待审
1.7|39|定义|The isosceles trimer positions are (x,-y/3),(-x,-y/3),(0,2y/3).|isoscelesCoordinates|statement_only|保留正文代数推导，排除轨迹数值实验
1.7|39|未编号结论|The isosceles trimer energy is xdot^2+ydot^2/3+2phi_LJ(sqrt(x^2+y^2))+phi_LJ(2x).|isoscelesEnergy|statement_only|x>0，各距离正；单位质量
1.7|40|未编号结论|The accessible position region satisfies U(x,y)<=E because kinetic energy is nonnegative.|isoscelesEnergyBound|statement_only|真实代数结论，不登记图中轨迹
1.7.1|41|定义|Sensitive dependence means arbitrarily nearby initial points can later separate by a fixed visible amount.|sensitiveDependence|statement_only|原文描述非严格，给标准量词版；不要求无限有界域指数增长
1.7.1|41|定义|Chaos includes sensitive dependence and topological transitivity on phase domain D.|chaosConditions|statement_only|只记录本章两个必要性质，不补密周期点条件
1.7.1|42|定义|Topological transitivity means a trajectory joins any two nonempty open neighborhoods in D.|topologicalTransitivity|statement_only|正时间流，相对拓扑
1.7.1|42|未编号结论|Topological transitivity is essentially equivalent to ergodicity.|transitivityErgodicityLiteral|statement_only|缺少不变测度，通常不等价；保留文字涉及的数学对象与待审问题
1.7.1|42|定义|The anisotropic oscillator energy is (xdot^2+ydot^2)/2+k(c3)(r-l(c3))^2/2, (1.9).|anisotropicEnergy|statement_only|仅模型公式，排除其介绍性数值轨迹和实验结论
1.7.1|42|定义|c3=cos(3theta)=4c^3-3c, c=x/r.|anisotropicAngular|statement_only|r>0，三倍角关系
1.7.1|42|定义|k(c3)=k0(1-epsilon c3/2), l(c3)=l0(1+epsilon c3/2).|anisotropicParameters|statement_only|参数函数，不登记数值实验
1.7.2|44|notation|The flow F_t is assumed continuously differentiable in its initial condition.|differentiableFlow|statement_only|原文C1假设，joint正则性另述
1.7.2|44|定义|The printed variational matrix is W(t)=F_t'(z(t,xi)).|variationalMatrixLiteral|statement_only|忠实原文取值点；通常应在xi取导数
1.7.2|44|未编号结论|Differentiating the flow Jacobian gives Wdot=f'(z(t,xi)) W, (1.10).|variationalEquation|weakened|现有仅常系数；需补一般非线性忠实陈述，打印W取值点错误独立列出
1.7.2|45|未编号结论|Nearby trajectories differ to first order by W(t)(xi_hat-xi).|flowFirstOrder|statement_only|严格小o形式，固定t；W在初值xi取导数
1.7.2|45|定义|Singular values are square roots of eigenvalues of A^T A, ordered largest to smallest.|singularValues|statement_only|有限维实矩阵，非负、有序
1.7.2|45|未编号结论|An invertible linear map sends a unit sphere to an ellipsoid whose semi-axes are its singular values.|singularEllipsoid|statement_only|奇异值分解与像椭球，暂不建设谱几何理论
1.7.2|45|定义|lambda_i=limsup_{t->infinity} (1/t) log sigma_i(W(t)).|lyapunovExponent|statement_only|扩展实值limsup，W可逆避免log0
1.7.2|45|未编号结论|A positive Lyapunov exponent implies exponential amplification of infinitesimal perturbations.|positiveLyapunovGrowth|statement_only|limsup给无穷时间子列增长，不保证所有充分大t的统一增长
'''
rows=[]
for i,line in enumerate(data.strip().splitlines(),1):
    sec,page,kind,english,name,status,note=line.split('|')
    existing=byname.get(name)
    rows.append({'id':f'CH01-{i:03d}','节号':sec,'印刷页':page,'PDF页':str(int(page)+23),'类型':kind,'原文陈述(英文原句或忠实转述)':english,'Lean声明名':'MolecularDynamics.'+name if existing else 'MolecularDynamics.Chapter01Review.'+name+'_statement','文件:行号':existing['file']+':'+str(existing['line']) if existing else 'MolecularDynamics/Chapter01/Statements.lean:待补','状态':status,'备注':note+('；清单阶段：待补忠实陈述，未计为证明' if not existing else '')})
review=root/'docs/review'
review.mkdir(parents=True,exist_ok=True)
with (review/'CH01_CLAIMS.csv').open('w',encoding='utf-8-sig',newline='') as f:
    writer=csv.DictWriter(f,fieldnames=list(rows[0]))
    writer.writeheader();writer.writerows(rows)
(review/'CH01_SCOPE.zh-CN.md').write_text('''# 第1章原页覆盖记录
原书PDF本地核对：PDF24为印刷1；PDF69印刷46中途开始Exercises；PDF76印刷53开始第2章。
正文范围是印刷1–46（PDF24–69），印刷47–52为习题，排除。印刷1–4为背景与介绍性数值实例，无独立待证对象。
已逐页读取正文文本；印刷32、44的关键公式另经页面渲染核对。每行页码为该对象首次/主要出现页。
排除数值参数表、模拟曲线、经验数值结果及所有Exercises；保留Example中正文给出推导的数学结论（harmonic、scalar、Kepler、trimer）与势模型定义。
本清单先于新增Lean陈述提交；statement_only在此阶段包括待补陈述。后续以文件行号替换“待补”并审计。
疑似原文错误保留字面Prop，不证明，不把修正假设暗中加入原文。最终人工审阅负责确认这些边界和定性模型的转述。
''',encoding='utf-8')
print('Inventory rows:',len(rows))
