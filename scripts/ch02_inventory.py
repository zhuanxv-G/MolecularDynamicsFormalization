"""Initial chapter 2 inventory; never overwrite an existing maintained CSV."""
from pathlib import Path
import csv, re
root=Path(__file__).resolve().parents[1]
target=root/'docs/review/CH02_CLAIMS.csv'
if target.exists(): raise RuntimeError('Inventory already exists; edit the maintained CSV.')
# page|section|kind|English paraphrase|declaration|status|differences and assumptions
data='''
53|2|定义|The Hamiltonian vector field is f=J grad H, equation (2.1).|textbookHamiltonianVectorField|defined|有限维欧氏坐标；固定J符号
53|2|定义|The mechanical Hamiltonian is p^T M^-1 p/2+U(q).|massHamiltonian|defined|复用第1章固定正对角质量定义
53|2|notation|J is the canonical block matrix with blocks 0,I,-I,0.|textbookJ|defined|与Mathlib符号相反的教材约定
54|2|定义|Euler advances z to z+h f(z).|eulerStep|defined|精确实数映射
54|2|定义|A numerical trajectory consists of repeated one-step maps from the initial point.|oneStepIterate|defined|任意步映射的有限迭代
54|2|notation|F_t denotes the exact flow and G_h its one-step approximation.|exactAndNumericalMaps|defined|映射类型；不宣称存在全局流
55|2.1|定义|Convergence means that finite-interval maximum errors tend to zero as the step decreases.|convergentMethod|defined|固定时间区间和h=tau/nu
55|2.1|定义|Global order r means an error bound C(tau) h^r with C independent of h.|globalOrder|defined|足够小步长；显式量词
56|2.1|notation|The mesh has h nu=tau and t_n=n h.|meshTime|defined|nu为正整数，tau正
56|2.1|定义|The error at node n is the norm of the difference between numerical and exact solutions.|nodeError|defined|真实范数误差
56|2.1|定义|The maximum global error is the maximum over 0 through nu.|oneStepMaxError|defined|非空有限最大值
56|2.1|定理|Theorem 2.1: for C1 f on a bounded open D and a unique trajectory staying in D, sufficiently fine Euler meshes stay in D and have maximum error at most C(tau) h.|theorem_2_1_euler|proved|原页已核对；复用完整留域和误差证明，不将留域藏入假设
56|2.1|未编号结论|Euler is first-order convergent on a fixed finite interval.|theorem_2_1_euler|proved|与Theorem2.1共用完整证明；不是第二个独立定理
59|2.1.2|未编号结论|Differentiating z'=f(z) gives z''=f'(z) f(z).|odeSecondDerivative_statement|statement_only|实际导数；f C1和解C2
59|2.1.2|定义|The second-order Taylor map is z+h f(z)+h^2 f'(z)f(z)/2.|taylor2|defined|Fréchet导数作用
59|2.1.2|未编号结论|The second-order Taylor method has global order two.|taylor2Order_statement|statement_only|f足够光滑，轨道和数值留域、稳定性需落实；待证
59|2.1.2|notation|f'(z) is the Jacobian, with ij entry partial_j f_i.|textbookCoordinateJacobian|defined|坐标Fréchet导数矩阵
60|2.2|未编号结论|Verlet is a second-order method for q'=M^-1 p,p'=F(q).|verletOrder_statement|statement_only|非数值示例；正质量、光滑力、留域；待证
60|2.2.1|定义|The mechanical Lagrangian is v^T M v/2-U(q).|massLagrangian|defined|复用第1章
60|2.2.1|定义|Admissible curves have fixed endpoints and sufficient smoothness.|admissibleCurve|defined|以C2曲线统一原文C2/C1不一致
60|2.2.1|定义|The classical action is the time integral of L(q,q').|action|defined|真实区间积分
61|2.2.1|定义|Variations are q_epsilon=q+epsilon eta with eta vanishing at endpoints.|variation|defined|实际曲线加法与数乘
61|2.2.1|未编号结论|The first variation of action is the integral of L_q eta+L_v eta'.|firstVariation_statement|statement_only|C2及固定紧时间窗；积分与求导交换未证
61|2.2.1|未编号结论|Taylor expansion includes derivative tensors and an order k+1 remainder.|taylorRemainder_statement|statement_only|补原脚注遗漏的1/j!；一般向量空间Taylor界待证
61|2.2.1|定义|Hamilton's principle requires the first variation to vanish for every endpoint-fixed variation.|stationaryAction|defined|驻值不是全局极小
62|2.2.1|未编号结论|Integration by parts removes eta' with zero boundary contributions.|firstVariationParts_statement|statement_only|真实积分恒等式；待证
62|2.2.1|未编号结论|Stationarity for all variations implies the Euler-Lagrange equations.|hamiltonPrinciple_statement|statement_only|需基本变分引理、正则性及真实一阶变分推导
62|2.2.1|定义|A variational derivative is a linear first-order approximation of the functional.|variationalDerivative|defined|用HasFDerivAt忠实定义，补原文缺失的F(q)
62|2.2.1|未编号结论|A stationary curve need not be an action minimizer.|stationaryNotMinimum_statement|statement_only|存在反例命题；原文脚注
63|2.2.2|定义|The discrete path consists of the points q_0,...,q_nu.|discretePath|defined|有限索引
63|2.2.2|定义|The discrete velocity is (q_(n+1)-q_n)/h.|discreteVelocity|defined|h非零物理域
63|2.2.2|定义|The discrete action is h times the sum L(q_n,(q_(n+1)-q_n)/h).|discreteAction|defined|正步长；原文L的+U为笔误，采用前文-U
63|2.2.2|定义|Discrete stationarity means derivatives in interior points vanish with endpoints fixed.|discreteStationary|defined|仅1≤n<nu；原文n=nu索引待审
64|2.2.2|未编号结论|The discrete action derivative is M(2q_n-q_(n-1)-q_(n+1))/h-h grad U(q_n).|discreteActionDerivative_statement|statement_only|实际Fréchet导数；仅内部节点
64|2.2.2|未编号结论|Discrete stationarity yields M(q_(n+1)-2q_n+q_(n-1))=-h^2 grad U(q_n), (2.4).|discreteStationaryVerlet_statement|statement_only|真实作用量驻值推导未证明
64|2.2.2|定义|The Störmer position recurrence uses the centered second difference.|stormerRelation|defined|等式关系而非多步唯一解
64|2.2.2|定义|Velocity Verlet uses a half kick, position drift, and half kick, (2.5)-(2.7).|velocityVerlet|defined|任意有限维正对角质量
65|2.2.2|未编号结论|Eliminating velocities from two Verlet steps yields the Störmer recurrence.|velocityVerletStormer_statement|statement_only|逐坐标代数；可限时补证明
65|2.2.2|定义|Momentum Verlet is Q=q+h M^-1 p+h^2 M^-1 F(q)/2, P=p+h(F(q)+F(Q))/2, (2.8).|verlet|defined|定义完整映射，F独立参数
65|2.2.2|定义|Leapfrog evolves staggered velocity by a full kick and drifts positions.|leapfrog|defined|数学映射；排除力计算复用实现描述
65|2.2.2|定义|The staggered initial velocity is v_0-h M^-1 F(q_0)/2.|leapfrogInitialize|defined|不忽略初始化
65|2.2.2|定义|Full-node velocity is reconstructed by a half kick.|leapfrogReconstruct|defined|真实速度关系
66|2.2.3|未编号结论|The error difference is G_h(z_n)-F_h(z(t_n)), (2.9).|errorDifference_statement|statement_only|实际一步关系；可直接证明
66|2.2.3|定义|Consistency of order p is a uniform local defect bound K h^(p+1), (2.10).|consistentOrder|defined|沿精确轨道、固定窗口、K与h无关
66|2.2.3|定义|Stability is a Lipschitz factor at most 1+h L on the containing domain, (2.11).|stableMethod|defined|L≥0，足够小正h
67|2.2.3|未编号结论|Local defect and stability imply e_(n+1)≤(1+Lh)e_n+K h^(p+1).|oneStep_error_recursion|proved|已证明实际误差递推；精确与数值留域
67|2.2.3|未编号结论|The error is bounded by (K/L) exp(Lnh) h^p, (2.12).|oneStep_error_bound|proved|L>0避免除零；可把零L扩为正L
67|2.2.3|未编号结论|Consistency of order p and stability give convergence of order p.|oneStep_converges_of_consistency_stability|proved|保留原文简化的数值留域假设
67|2.2.3|定义|The scalar Verlet map has Q=q+h p+h^2 F(q)/2 and P=p+h(F(q)+F(Q))/2.|verlet|defined|n=1,m=1实例
68|2.2.3|未编号结论|The scalar Verlet momentum expansion has cubic coefficient (F'F+p^2 F'')/4.|verletExpansion_statement|statement_only|C3力；实际O(h4)余项，待证
68|2.2.3|未编号结论|Exact position and momentum have cubic Taylor coefficients F'p/6 and (p^2 F''+F'F)/6.|exactExpansion_statement|statement_only|真实解、C3力、原文展开；待证
68|2.2.3|未编号结论|Verlet position defect is -h^3 F'p/6+O(h^4) and momentum defect h^3(p^2 F''+F'F)/12+O(h^4).|verletDefectExpansion_statement|statement_only|原文位置差误写正号；保留修正与字面两个陈述
68|2.2.3|未编号结论|Verlet has uniform local error O(h^3) on a compact trajectory.|verletConsistency_statement|statement_only|不是忽略h4项当严格界；补紧性和正则性
69|2.2.3|未编号结论|A Lipschitz force gives the Verlet stability factor 1+h L.|verletStability_statement|statement_only|整空间Lipschitz或留域邻域；仅正文结论，习题证明排除
70|2.2.4|定义|A first integral satisfies grad I dot f=0 on the domain.|firstIntegral|defined|定义用fderiv作用
70|2.2.4|未编号结论|A first integral is preserved by the exact flow.|firstIntegralPreserved_statement|statement_only|真实解和连通时间区间
70|2.2.4|未编号结论|Hamiltonian flow preserves H.|textbookHamiltonian_energy_const_on_Icc|proved|已有Chapter03可复用；可微H、真实Hamilton曲线
71|2.2.4|未编号结论|Planar central-force motion conserves angular momentum.|centralAngularMomentum_statement|statement_only|复用第1章结论核对后映射，当前一般陈述待证
71|2.2.4|未编号结论|The scalar mean-value theorem gives I(a)-I(b)=grad I(c) dot(a-b) on the segment.|integralMeanValue_statement|statement_only|补包含整条线段的开域；非任意非凸D
71|2.2.4|未编号结论|A bounded gradient makes I Lipschitz along the segment.|integralLipschitz_statement|statement_only|凸邻域或线段包含条件；待证
71|2.2.4|未编号结论|First-integral error inherits O(h^p) finite-interval trajectory error, (2.16).|integralError_statement|statement_only|原常数1/2无出处；忠实字面版与安全界并存
72|2.3.1|定义|Divergence is the trace of the Jacobian.|divergence|defined|有限实坐标
72|2.3.1|未编号结论|Liouville: divergence-free C1 flows preserve phase volume.|textbookDivergenceFreeFlow_volume_image_of_jointC2|weakened|已有证明要求jointC2解族；补忠实C1陈述，原文未写可测集和解域
72|2.3.1|未编号结论|Hamiltonian vector fields have zero divergence by equality of mixed partials.|textbookHamiltonianVectorField_divergence_zero|proved|H C2
72|2.3.1|未编号结论|Hamiltonian flow preserves phase-space volume.|textbookHamiltonianFlow_volume_image_of_jointC2|weakened|jointC2解族、实际可测域；补较弱正则性忠实陈述
73|2.3.1|未编号结论|Volume under a flow is the integral of the absolute Jacobian determinant.|volumeChange_statement|statement_only|C1单射微分同胚、可测集；待证
73|2.3.1|未编号结论|The actual flow Jacobian solves W'=f'(z)W.|textbookSolutionFamilyJacobian_hasDerivAt|weakened|jointC2解族；书中W取值点应为初值，不应重复沿轨道
73|2.3.1|未编号结论|D=det W solves D'=div f(z) D.|textbookMatrixDet_hasDerivAt_of_linearODE|proved|完整矩阵导数公式；不需假设W可逆
73|2.3.1|未编号结论|D(t)=D(0) exp(integral_0^t div f(z(s)) ds).|determinantExponential_statement|statement_only|连续系数、真实W；待补积分解公式
73|2.3.1|未编号结论|If div f=0 and W(0)=I then det W(t)=1.|textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2|weakened|jointC2解族；补C1变分陈述
74|2.3.2|未编号结论|A linear system z'=S z is divergence free exactly when tr S=0.|linearDivergence_statement|statement_only|有限实矩阵；待证
75|2.3.2|定义|Euler for z'=S z is multiplication by I+hS.|linearEuler|defined|有限矩阵
75|2.3.2|未编号结论|Euler preserves oriented linear volume exactly when det(I+hS)=1.|linearEulerVolume_statement|statement_only|原体积只需绝对det=1；正小h方向条件需注明
75|2.3.2|未编号结论|Euler does not generally preserve volume for divergence-free fields.|eulerVolumeCounterexample_statement|statement_only|具体二维旋转反例而非含糊否定
75|2.3.2|定义|Asymmetric Euler is U=u+h f(U,v), V=v+h g(U,v).|asymmetricEulerRelation|defined|隐式关系；不宣称全球唯一解
75|2.3.2|未编号结论|Its Jacobian determinant is (1+h g_v)/(1-h f_u).|asymmetricDet_statement|statement_only|隐式函数可微、分母非零
76|2.3.2|未编号结论|Asymmetric Euler preserves area when f_u+g_v=0.|asymmetricArea_statement|statement_only|存在光滑局部解和分母非零
76|2.3.3|定义|A symplectic map satisfies D Phi^T J D Phi=J.|IsTextbookSymplecticMap|defined|要求可微；局部性质不保证全球可逆
76|2.3.3|定义|A one-form is a point-dependent linear functional.|oneForm|defined|坐标域中的线性形式族
76|2.3.3|定义|The differential dg is the derivative of g acting on tangent vectors.|differential|defined|实际Fréchet导数
76|2.3.3|定义|dq_i and dp_i select tangent vector coordinates.|textbookDq;textbookDp|defined|位置/动量索引
76|2.3.3|定义|The wedge is alpha(u) beta(v)-alpha(v) beta(u).|textbookWedgeOneForms|defined|反对称双线性式
77|2.3.3|定义|The canonical symplectic form is u^T J v.|textbookSymplecticForm|defined|教材符号
77|2.3.3|未编号结论|The symplectic form is the sum of dq_i wedge dp_i.|textbookSymplecticForm_eq_sum_wedges|proved|有限坐标求和
77|2.3.3|定义|A general two-form has skew coefficients depending on the point.|twoForm|defined|反对称矩阵；原文双和与系数2约定待审
77|2.3.3|定义|Pullback of a one-form evaluates it at Phi(z) on D Phi(z) u.|pullbackOne|defined|真实Jacobian与取值点
77|2.3.3|定义|Pullback of a two-form acts on both derivative-transformed arguments.|pullbackTwo|defined|完整位置相关定义
78|2.3.3|未编号结论|Matrix pullback is D Phi(z)^T A(Phi(z)) D Phi(z).|pullbackMatrix_statement|statement_only|原文一般守恒省略A取值点；用完整版本
78|2.3.3|定义|Preservation of a two-form is equality of its pullback with itself.|preservesTwoForm|defined|位置相关A需在Phi(z)取值
78|2.3.3|未编号结论|Symplecticity is equivalent to preserving the canonical form.|isTextbookSymplecticMap_iff_preserves_form|proved|实际可微映射
78|2.3.3|未编号结论|A symplectic Jacobian has determinant squared one and absolute determinant one.|IsTextbookSymplectic.det_square;IsTextbookSymplectic.abs_det|proved|已有更强det=1结论；原文±1疑虑无须流连续性
78|2.3.3|未编号结论|Hamiltonian flow has determinant one.|textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2|weakened|jointC2解族；完整C1域陈述补齐
79|2.3.4|定义|The Hessian of H gives a symmetric matrix S.|textbookHamiltonianHessian|defined|C2时对称性另有证明
79|2.3.4|未编号结论|The Hamiltonian Hessian is symmetric.|textbookHamiltonianHessian_isSymm|proved|H C2
79|2.3.4|未编号结论|The variational equation is W'=J S W.|textbookHamiltonianFlowJacobian_hasDerivAt|weakened|jointC2真实流、正确初值取导位置
79|2.3.4|未编号结论|J^T=-J and J^2=-I imply cancellation in the derivative of W^T J W.|hamiltonian_variational_matrix_cancellation|proved|对称S；真实矩阵代数
79|2.3.4|未编号结论|W^T J W is constant along Hamiltonian variational solutions.|hamiltonian_variational_form_constant|proved|连通时间区间、实际导数
79|2.3.4|未编号结论|Hamiltonian flow is symplectic.|textbookHamiltonianFlow_isSymplectic_of_jointC2|weakened|jointC2解族；一般局部C1流陈述补齐
79|2.3.5|未编号结论|The derivative of a composition is the product with the outer derivative at the inner image.|textbookJacobian_comp|proved|修正原文省略取值点
79|2.3.5|未编号结论|A composition of symplectic maps is symplectic.|IsTextbookSymplecticMap.comp|proved|真实可微映射
79|2.3.5|未编号结论|An inverse symplectic diffeomorphism is symplectic.|IsTextbookSymplecticEquiv.symm|proved|假设给定全局可微逆，不从局部det非零冒充全球逆
79|2.3.5|未编号结论|Symplectic maps are always globally invertible and form a group.|globalSymplecticGroup_statement|statement_only|字面断言欠全球双射；另有正确辛微分同胚群定义，待人工判断
79|2.3.5|定义|Globally invertible smooth symplectic maps form the symplectic diffeomorphism group.|textbookSymplecticDiffeomorphismGroup|defined|全球可微逆明示
80|2.3.6|定义|A symplectic integrator is a one-step map preserving the symplectic form.|symplecticIntegrator|defined|不将精度结论塞进定义
80|2.3.6|定义|Symplectic Euler is P=p+h F(q), Q=q+h M^-1 P.|textbookSymplecticEuler|defined|kick后drift
81|2.3.6|未编号结论|The derivative of the kick contains the symmetric potential Hessian.|textbookJacobian_momentumKick|proved|U C2、实际Jacobian
81|2.3.6|未编号结论|The wedge of a one-form with itself vanishes.|wedgeSelf_statement|statement_only|可直接双线性代数证明
81|2.3.6|未编号结论|Symplectic Euler preserves the canonical form.|textbookSymplecticEuler_isSymplectic|proved|U C2，固定对角质量
81|2.3.7|定义|The adjoint is G_h^*=G_(-h)^-1.|textbookAdjointMethod|defined|给定每步双射，反步可用
82|2.3.7|未编号结论|The exact flow is self-adjoint.|textbookFlowMethod_isSelfAdjoint|proved|全局flow群接口；局部流需限制定义域
82|2.3.7|定义|Backward Euler is Z=z+h f(Z).|backwardEulerRelation|defined|关系、不宣称解唯一
82|2.3.7|未编号结论|Euler's adjoint is backward Euler.|euler_adjoint_iff_backward|proved|给定Euler双射，不假设所有h均可逆
82|2.3.7|定义|Adjoint symplectic Euler is Q=q+h M^-1 p, P=p+h F(Q).|textbookAdjointSymplecticEuler|defined|实际drift后kick
82|2.3.7|未编号结论|The adjoint of the adjoint is the original method.|textbookAdjointMethod_involutive|proved|Equiv.Perm接口
83|2.4.1|定义|A Hamiltonian splitting divides H into H1+H2 and composes their maps.|textbookComposeMaps|defined|组合从右到左
83|2.4.1|未编号结论|The Hamiltonian vector field of H1+H2 is the sum of the fields.|textbookHamiltonianVectorField_add|proved|两者可微
83|2.4.1|未编号结论|Splitting actual subflows gives local error O(h^2).|exists_hamiltonian_splitting_localError_bound|proved|真实子流正则性和留域；常数从C1/C2条件推导
83|2.4.1|定义|The kinetic subflow is Q=q+h M^-1 p, P=p.|textbookPositionDrift|defined|固定质量
84|2.4.1|定义|The potential subflow is Q=q, P=p-h grad U(q).|textbookMomentumKick|defined|真实势力定义
84|2.4.1|未编号结论|Kinetic and potential maps compose to symplectic Euler and its adjoint.|textbookSymplecticEuler;textbookAdjointSymplecticEuler|defined|已有映射定义即组合；流解身份单列补证
84|2.4.1|未编号结论|Composing half symplectic Euler and half its adjoint gives Verlet.|verletComposition_statement|statement_only|实际坐标等式，可有限代数证明
85|2.4.1|未编号结论|Verlet is symplectic.|verletSymplectic_statement|statement_only|组合已有辛性定理即可，不需重证
85|2.4.1|未编号结论|A composition with its adjoint in symmetric half steps is self-adjoint.|textbookSymmetricComposition_isSelfAdjoint|proved|可逆步映射
85|2.4.1|未编号结论|A consistent symmetric method has even finite order.|symmetricEvenOrder_statement|statement_only|需存在非零首误差项和光滑步长展开，排除精确流的无穷阶
85|2.4.2|未编号结论|Composing symplectic numerical methods gives another symplectic method.|textbookComposeMethods_isSymplectic|proved|任意组合步参数
85|2.4.2|未编号结论|For approximations to the same flow, half-step composition has order at least the minimum of the two orders.|compositionOrder_statement|statement_only|补same flow与稳定性；不同Hamiltonian半步字面需区分
85|2.4.3|定义|Harmonic plus anharmonic splitting composes the oscillator matrix flow with a potential kick.|harmonicAnharmonic|defined|Omega非零；定义数学映射，不含数值实验
86|2.4.4|未编号结论|Small-step implicit equations have a unique smooth local solution when the defining derivative is nonsingular.|implicitLocal_statement|statement_only|局部逆函数条件；不声称全球逆
86|2.4.4|定义|Newton's update is x-(g'(x))^-1(g(x)-tau).|newtonStep|defined|有限维连续线性等价接口
87|2.4.4|未编号结论|Newton's method converges quadratically near a simple zero.|newtonQuadratic_statement|statement_only|C2、非奇异导数、充分近初值，待证
87|2.4.4|未编号结论|A frozen approximate Jacobian gives geometric convergence under a contraction condition.|frozenNewton_statement|statement_only|补范数收缩条件；原文泛称many cases并非无条件
88|2.4.5|定义|Conjugacy is A=chi^-1 composed with B composed with chi.|textbookConjugateMap|defined|chi为homeomorphism
88|2.4.5|未编号结论|Conjugate iterates satisfy A^n=chi^-1 B^n chi.|textbook_conjugate_iterates|proved|精确任意n恒等式
88|2.4.5|未编号结论|Conjugacy carries convergence of iterates to the corresponding transformed limit.|textbook_conjugate_iterates_tendsto_iff|proved|正确初值是chi(z0)；不冒充定量稳定性界
88|2.4.5|未编号结论|Symplectic Euler is conjugate to Verlet by a half kick.|symplecticEulerConjugacy_statement|statement_only|正文声明保留，习题12的要求排除
88|2.4.5|定义|A processed method pre-processes, iterates the kernel, then post-processes.|textbookProcessedMethod;textbookProcessedIterate|defined|步长相关homeomorphism
88|2.4.5|未编号结论|Processed iterates equal the iterates of the conjugate higher-order map.|textbookProcessedIterate_eq_of_conjugacy|proved|精确公式；不声称处理器存在
88|2.4.5|未编号结论|Processed maximum errors equal those of the conjugate method.|textbookProcessedMaxError_eq_of_conjugacy|proved|同一初值、精确conjugacy
89|2.5.1|定义|Runge-Kutta stages satisfy F_i=f(z+h sum a_ij F_j), and Z=z+h sum b_i F_i.|rungeKuttaRelation|defined|有限s阶段隐式关系
89|2.5.1|定义|Classical RK4 has the stated four stages and weights 1/6,1/3,1/3,1/6.|rk4|defined|明确四阶段映射
89|2.5.1|未编号结论|Classical RK4 has global order four.|rk4Order_statement|statement_only|光滑f、紧轨道、留域和稳定性；待证
89|2.5.1|未编号结论|No consistent explicit RK method is universally symplectic.|explicitRKNotSymplectic_statement|statement_only|补一致性sum b=1；不把零权重恒等法算反例
90|2.5.1|未编号结论|The RK symplectic coefficient condition is b_i a_ij+b_j a_ji=b_i b_j.|rkSymplectic_statement|statement_only|条件的充分性；必要性需不可约等附加条件
90|2.5.1|定义|Implicit midpoint is Z=z+h f((z+Z)/2).|midpointRelation|defined|关系而非全局求解器
90|2.5.1|未编号结论|Gauss-Legendre RK schemes are symmetric and have even order.|gaussRK_statement|statement_only|s阶段实际Gauss配点构造；大型配点理论缺口
90|2.5.1|未编号结论|Implicit midpoint is second order and symplectic.|midpointProperties_statement|statement_only|光滑向量场，Hamiltonian C2，局部唯一可微解
90|2.5.1|定义|The two-stage Gauss method has b_i=1/2 and A entries 1/4 with off-diagonal shifts +/-sqrt(3)/6.|gaussTwoCoefficients|defined|实际系数矩阵
90|2.5.2|定义|Generalized Verlet uses the partitioned implicit equations (2.26)-(2.28).|partitionedVerletRelation|defined|保留q,p偏导和中间动量
91|2.5.2|未编号结论|Generalized Verlet reduces to Verlet for separable mechanical H.|partitionedReduction_statement|statement_only|固定正质量、U可微；实际关系等价
91|2.5.2|定义|General symplectic Euler is P=p-h H_q(q,P), Q=q+h H_p(q,P).|generalSymplecticEulerRelation|defined|隐式映射存在另述
91|2.5.2|未编号结论|General implicit symplectic Euler and generalized Verlet are symplectic.|generalSymplectic_statement|statement_only|C2 H、局部唯一可微解；混合Hessian与楔和抵消待证
92|2.5.3|定义|Newmark uses parameters gamma,beta and the two displayed position/momentum equations.|newmarkRelation|defined|字面Q式缺M^-1；另给质量一致修正版
92|2.5.3|未编号结论|Newmark with gamma=1/2,beta=0 reduces to Verlet.|newmarkReduction_statement|statement_only|字面仅M=I；质量一致修正版适用于一般正质量
92|2.5.3|未编号结论|Gamma=1/2 avoids artificial damping in the linear oscillator.|newmarkNoDamping_statement|statement_only|线性振子放大矩阵det=1，需非奇异解域
92|2.5.3|未编号结论|Implicit Newmark is generally not symplectic for nonlinear potentials.|newmarkNotSymplectic_statement|statement_only|具体非线性反例存在；避免错误全称排除线性特殊情况
92|2.5.4|定义|The multiderivative Taylor map uses terms h^j z^(j)/j!.|multiTaylor|defined|时间导数数据；不宣称误差阶
92|2.5.4|定义|Takahashi-Imada uses Verlet with modified potential U-h^2 grad U^T M^-1 grad U/24.|takahashiPotential|defined|h固定参数
93|2.5.4|未编号结论|The displayed modified force is -(I+h^2 U''M^-1/12) grad U.|takahashiForce_statement|statement_only|与前式-U修正求负梯度的符号不一致；字面和修正版并存
93|2.5.4|未编号结论|Takahashi-Imada has effective order four after processing.|takahashiOrder_statement|statement_only|处理器存在、C足够阶、实际四阶全局误差；待证
93|2.5.5|定义|Position-only Verlet is a multistep recurrence q_(n+1)-2q_n+q_(n-1)=h^2 M^-1 F(q_n).|stormerRelation|defined|与前文同一数学算法；排除实现成本
'''
decls={}
for p in sorted((root/'MolecularDynamics').rglob('*.lean')):
    s=p.read_text(encoding='utf-8-sig')
    for m in re.finditer(r'(?m)^(?:noncomputable )?(?:def|abbrev|theorem|structure)\s+([\w.]+)',s):
        decls.setdefault(m[1],(p.relative_to(root).as_posix(),s[:m.start()].count('\n')+1))
rows=[]
for line in data.strip().splitlines():
    page,sec,kind,claim,names,status,note=line.split('|')
    loc=[]; full=[]
    for n in names.split(';'):
        if n in decls:
            p,l=decls[n]; full.append('MolecularDynamics.'+n); loc.append(f'{p}:{l}')
        else:
            module='Statements' if n.endswith('_statement') else 'ReviewDefinitions'
            full.append('MolecularDynamics.Chapter02Review.'+n)
            loc.append(f'MolecularDynamics/Chapter02/{module}.lean:1')
            note+='；计划声明，补齐阶段核实'
    rows.append(dict(zip(['id','节号','印刷页','PDF页','类型','原文陈述(英文原句或忠实转述)','Lean声明名','文件:行号','状态','备注'],
                         [f'CH02-{len(rows)+1:03}',sec,page,str(int(page)+22),kind,claim,';'.join(full),';'.join(loc),status,note])))
with target.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
print('Initial chapter 2 inventory:',len(rows))
