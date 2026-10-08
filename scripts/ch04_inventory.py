"""Original-page Chapter 4 inventory. Preserve definitions separately from proofs."""
from pathlib import Path
import csv
root=Path(__file__).resolve().parents[1]
target=root/'docs/review/CH04_CLAIMS.csv'
if target.exists():raise RuntimeError('Maintained CSV already exists.')
# page | section | kind | faithful paraphrase | declaration(s) | status | differences
data='''
139|4|定义|Linear test dynamics is z'=Az, (4.1).|linearField|defined|有限维实/复线性系统；一般非对角化矩阵不能只看特征值
139|4|定义|Scalar Euler has amplification factor 1+h lambda.|eulerFactor|defined|复数测试方程
139|4|未编号结论|Scalar Euler iterates are bounded exactly when abs(1+h lambda)≤1, for nonzero initial data.|scalarEulerStable_statement|statement_only|限标量；Jordan边界另需条件
139|4|定义|Euler's stability region is the disk centered at -1 with radius 1.|eulerStabilityRegion|defined|以复数h lambda为自变量
139|4|定义|The harmonic oscillator matrix is [[0,1],[-Omega²,0]].|oscillatorMatrix|defined|单位质量模型
140|4|未编号结论|The oscillator eigenvalues are ±i Omega; Euler grows for a nonzero oscillator frequency and nonzero step.|eulerImaginaryGrowth_statement|statement_only|排除零频率、零步长和零初值
140|4|定义|Symplectic Euler oscillator matrix is [[1-h²Omega²,h],[-h Omega²,1]].|symplecticEulerMatrix|defined|位置先用更新后的动量
140|4|未编号结论|The characteristic polynomial of symplectic Euler is lambda²-(2-h²Omega²)lambda+1.|symplecticEulerCharacteristic_statement|statement_only|复特征值，有限行列式恒等式
140|4|未编号结论|For 0<abs(h Omega)<2 symplectic Euler powers are bounded; for abs(h Omega)>2 it has an eigenvalue outside the unit circle.|symplecticEulerStability_statement|statement_only|边界abs(h Omega)=2通常有Jordan增长；补绝对值与非零条件
140|4|未编号结论|The maximal harmonic stability threshold among explicit symplectic PRK methods is quoted as 2/Omega.|prkThreshold_statement|not_formalizable_now|原文援引[74]；需限制阶段数/成本与方法类，保留书中文字面普适断言，未证明
141|4|未编号结论|Verlet oscillator trajectories remain bounded for abs(h Omega)<2.|verletStability_statement|statement_only|非零正频率；无声称非线性系统全局稳定
142|4.1|定义|The printed Implicit Midpoint formula averages f(z) and f(Z).|printedImplicitRelation|defined|字面是trapezoidal；实际midpoint另附定义，原文误名待人工判断
142|4.1|定义|On imaginary linear dynamics the implicit amplification factor is (1+i h Omega/2)/(1-i h Omega/2).|implicitFactor|defined|线性情形midpoint/trapezoidal重合
142|4.1|未编号结论|The imaginary-axis implicit amplification factor has modulus one for every real h Omega.|implicitModulus_statement|statement_only|仅线性振荡系统；不保证一般不稳定线性场稳定
143|4.1|定义|The numerical oscillator frequency is the continuous-branch phase divided by h.|modifiedFrequency|defined|用2 atan(h Omega/2)/h消除复log分支歧义，h非零
143|4.1|未编号结论|The modified frequency tends to Omega as h tends to zero, but differs at large h Omega.|modifiedFrequencyLimit_statement|statement_only|极限是可核实数学内容；耦合共振的实践推测不计定理
144|4.1|定义|Mechanical midpoint is qhat=q+h M^-1 phat/2,phat=p-h grad U(qhat)/2, followed by the same half updates.|mechanicalMidpointRelation|defined|质量正；关系不代表隐式解存在/唯一
144|4.1|未编号结论|Eliminating phat gives qhat=q+h M^-1p/2-h² M^-1 grad U(qhat)/4.|midpointElimination_statement|statement_only|只陈述有限代数等价，不建立求解理论
145|4.2.1|定义|The slow/fast Hamiltonian is kinetic+US+UF.|splitHamiltonian|defined|固定正质量
145|4.2.1|定义|Fast inner steps use kick-drift-kick Verlet for UF.|fastVerlet|defined|复用第2章Verlet数学映射
145|4.2.1|定义|Reversible RESPA is slow half-kick, r fast Verlet steps of size h/r, slow half-kick, (4.2).|respa|defined|r>0；使用实际有限迭代，不将形式exp当实际流
145|4.2.1|未编号结论|RESPA is symplectic and reversible when its component maps are well-defined smooth Hamiltonian kicks and drifts.|respaStructure_statement|statement_only|新增仅陈述；辛性需实际导数，未重复证明
146|4.2.1|定义|The resonance model uses slow kick S_h and exact fast rotation F_h.|slowMatrix;fastMatrix;impulseMatrix|defined|Omega>0；矩阵乘积顺序S(h/2) F(h) S(h/2)
146|4.2.1|未编号结论|S_h and F_h have determinant one, hence W_h does too.|impulseDet_statement|statement_only|有限实矩阵
146|4.2.1|未编号结论|The trace of W_h is 2 cos(h Omega)-(h/Omega) sin(h Omega).|impulseTrace_statement|statement_only|补非零Omega
146|4.2.1|未编号结论|At h=pi/Omega, W_h^n=(-1)^n [[1,0],[-n h,1]].|resonancePower_statement|statement_only|所有自然数n，Omega>0
147|4.2.1|未编号结论|Resonance at h=pi/Omega causes linear growth for initial q≠0.|resonanceGrowth_statement|statement_only|不是所有初值都增长
147|4.2.1|未编号结论|The trace has linear expansion -2+(pi/Omega)(h-pi/Omega)+O((h-pi/Omega)²).|resonanceTaylor_statement|statement_only|原图核对；保留Taylor余项量化
147|4.2.1|未编号结论|Immediately below pi/Omega the impulse matrix has a real eigenvalue outside the unit circle.|resonanceInstability_statement|statement_only|原特征值sqrt(abs(epsilon)/2)系数疑误，附字面Prop；只登记局部区间
149|4.2.2|定义|MOLLY replaces US(q) by US(A(q)); A is a weighted average of fast positions from zero momentum.|mollifiedAverage;mollifiedPotential|defined|实际有限fastVerlet迭代；不声称权重任意时物理有效
149|4.2.2|未编号结论|A smooth mollified potential has conservative forces and its RESPA composition is symplectic.|mollifiedStructure_statement|statement_only|真实链式导数；不证明实践的步长增益
150|4.3|定义|A holonomic constraint is g(q,t)=0, (4.3).|holonomicRelation|defined|允许显式时间依赖，后续自主g单列
150|4.3|未编号结论|Differentiating g(q(t),t)=0 gives Dq g q'+partial_t g=0.|timeConstraintDerivative_statement|statement_only|补可微实际曲线，局部恒为零
152|4.3|定义|The constrained system is q'=M^-1p,p'=F-G^T lambda,g(q)=0, (4.4)-(4.9).|constrainedSolution|defined|F=-grad U；不把约束力存在视为证明
152|4.3|定义|The constraint manifold and cotangent phase set satisfy g(q)=0 and G(q)M^-1p=0.|constraintSet;cotangentSet|defined|正质量/独立梯度是光滑流形解释所需条件
152|4.3|定义|G(q) is the actual Jacobian of the component constraints.|@textbookConstraintJacobian|defined|真实Fréchet偏导矩阵
152|4.3|未编号结论|The Jacobian multiplication equals the actual directional derivative of each constraint.|@textbookConstraintJacobian_eq_actualDerivative|proved|复用既有证明，需可微
153|4.3|定义|The curvature is D²g_k(q)[M^-1p,M^-1p].|@textbookConstraintCurvature|defined|真实二阶导数
153|4.3|定义|The reaction multiplier solves the Gram system with right side G M^-1F+curvature.|@textbookConstrainedReactionMultiplier|defined|逆Gram；非奇异另需验证
153|4.3|未编号结论|The constructed multiplier satisfies G M^-1(F-G^T lambda)+curvature=0, (4.10).|@textbookConstrainedReaction_balance|proved|Gram行列式非零；复用既有证明
153|4.3|未编号结论|Positive masses and linearly independent constraint gradients make the Gram matrix positive definite and invertible.|@textbookConstraintGram_posDef;@textbookConstraintGram_det_ne_zero|proved|复用既有证明
153|4.3|未编号结论|A given actual reduced ODE solution starting in the cotangent set stays there on its specified interval.|@textbookConstrainedODE_cotangent_invariant_of_mass_and_independence|proved|C2约束，给定闭区间解；非全时域解存在证明
153|4.3|未编号结论|Smooth constraints and independent gradients give a smooth reduced constrained vector field.|@contDiffAt_textbookConstrainedPhaseVectorField_of_mass_and_independence|proved|相应C3约束/C1力；局部正则性复用
153|4.3.1|定义|The symplectic form is the ambient canonical two-form pulled back to constraint charts.|restrictedForm|defined|坐标拉回，未构造抽象余切丛
154|4.3.1|未编号结论|Differentials of the constrained vector field obey the displayed variational formulas (4.11)-(4.13).|variational_statement|statement_only|实际fderiv；现有场正则性仅依赖，完整变分方程另陈述
155|4.3.1|未编号结论|Symmetric Hessian terms and tangent constraint terms cancel in the derivative of the pulled-back two-form.|@textbookConstrainedAcceleration_pullback_zero|proved|真实Hessian与切向条件；复用既有证明
156|4.3.1|未编号结论|The constrained flow preserves the pulled-back canonical two-form.|@textbookConstrainedFlow_pullback_constant_of_mass_and_independence|proved|joint C2给定流、质量正/梯度独立；不声称构造流存在
156|4.3.2|定义|Position-projected symplectic Euler is (4.14)-(4.16).|positionEulerRelation|defined|Fn印刷负号与F=-grad U约定不一致；附统一力符号
156|4.3.2|未编号结论|The hidden constraint error of position-projected Euler is O(h).|hiddenEulerError_statement|statement_only|光滑局部分支/小乘子条件；不会误记完全保持隐藏约束
156|4.3.2|定义|The projection equation is g(Qn-M^-1 Gn^T eta)=0 with eta=h²lambda, (4.17).|projectionResidual;projectionJacobian|defined|给定Qn/Gn；真实Jacobian交叉Gram
157|4.3.2|定义|Newton solves R(eta) Delta eta=g(Q(eta)), then adds Delta eta, (4.18)-(4.19).|newtonConstraint;frozenNewtonConstraint|defined|逆矩阵的适用需非奇异；冻结矩阵版也登记
157|4.3.2|未编号结论|Near a regular root the full Newton iteration converges quadratically.|newtonQuadratic_statement|statement_only|局部C2、Jacobian非奇异，未搭Newton一般收敛理论
157|4.3.2|未编号结论|With a frozen nonsingular matrix and a contraction derivative, the modified Newton iteration converges linearly.|frozenNewtonLinear_statement|statement_only|书中小步条件量化为真实导数范数<1；不无条件断言
158|4.3.2|未编号结论|The position projection multiplier eta is O(h²) for consistent constrained initial data.|projectionScale_statement|statement_only|局部光滑选根且eta(0)=0；不构造隐式分支存在
158|4.3.3|定义|The component-wise solver updates one constraint using its scalar linearized denominator and sweeps all constraints.|componentConstraintStep|defined|印刷G1_j索引误写，采用Gj_n；分母非零才是可用步骤
159|4.3.4|定义|Projected constrained Euler adds P=pbar-G(Q)^T mu and enforces G(Q)M^-1P=0, (4.20)-(4.24).|projectedEulerRelation|defined|完整关系；lambda/mu由原约束指定，未给存在理论
159|4.3.4|引理|Lemma 4.1: for C2 gamma, constrained q,p and P=p-mu grad gamma(q), the pulled-back sum dq∧dP equals sum dq∧dp.|@lemma_4_1;@lemma_4_1_coordinates|proved|已验收原标量完整证明；实际局部约束图，不重复证明；导师语义签核待定
160|4.3.4|未编号结论|The lemma extends to a sum of constraint-gradient momentum corrections.|@textbookMultiConstrainedMomentum_preserves_pullback|proved|有限约束族、真实可微乘子；复用既有证明
160|4.3.4|未编号结论|The drift and projected constrained Euler chart preserve the pullback two-form.|@textbookProjectedEulerChart_preserves_pullback|proved|给定可微分支及位置约束；不是求解存在证明
160|4.3.4|定义|The cotangent correction is obtained from the true inverse Gram matrix.|@textbookCotangentMultiplier;@textbookCotangentProjection|defined|原公式质量一致
160|4.3.4|未编号结论|The true Gram cotangent projection enforces the hidden constraint.|@textbookCotangentProjection_hiddenConstraint_of_mass_and_independence|proved|正质量、梯度独立；已验收
160|4.3.4|未编号结论|The cotangent projection is differentiable and preserves the restricted two-form.|@contDiffAt_textbookCotangentProjection;@textbookCotangentProjection_preserves_pullback|proved|真实正则性与Gram非奇异；已验收
160|4.3.4|未编号结论|The constructed Gram projected Euler chart has both the hidden constraint and preserved pullback form.|@textbookGramProjectedEulerChart_hiddenConstraint_and_pullback|proved|仅给定光滑位置投影分支；现有完整依赖映射
161|4.3.5|定义|The printed position-only SHAKE scheme is (4.25)-(4.26).|shakePositionPrinted;shakePositionRelation|defined|印刷约束反力缺M^-1；同时给质量一致版本，关系不计证明
161|4.3.5|定义|The phase-space SHAKE scheme uses the same force-plus-constraint half kicks, (4.27)-(4.29).|shakeRelation|defined|不保证隐藏约束；未求解分支
161|4.3.5|定义|RATTLE preserves position and hidden constraints with the two multipliers in (4.30)-(4.34).|rattleRelation|defined|完整真实有限算法关系
161|4.3.5|未编号结论|Projected Euler is first order; SHAKE/RATTLE are second order for regular smooth constrained branches.|constrainedOrders_statement|statement_only|统一实际ODE局部误差；阶结论非作为输入；不建立分支存在
162|4.3.5|未编号结论|RATTLE is symplectic on the cotangent set.|rattleSymplectic_statement|statement_only|已有Lemma4.1/Gram依赖映射；完整算法陈述未证
162|4.3.5|定义|The common staggered scheme is (4.35)-(4.37).|staggeredConstraintRelation|defined|F力约定显式
162|4.3.5|未编号结论|After compatible initialization and cotangent projection, SHAKE and RATTLE have identical position sequences.|shakeRattlePositions_statement|statement_only|原mu与lambda在缩放上需审阅；给各自完整关系与相容半步动量，不把位置相等放进假设
163|4.3.5.1|定义|The constrained adjoint Euler method swaps force and constraint corrections as displayed.|adjointEulerRelation|defined|mu/h缩放可吸收入独立乘子；h非零
163|4.3.5.1|未编号结论|Half-step Euler followed by its adjoint is a second-order symplectic constrained method.|constrainedComposition_statement|statement_only|完整阶/辛陈述依赖实际光滑分支；未证明
163|4.3.5.1|定义|The mass-weighted momentum projector is I-G^T(GM^-1G^T)^-1 GM^-1.|momentumProjector|defined|注意投影作用于动量协向量
163|4.3.5.1|未编号结论|The constrained potential flow is Q=q,P=p-h Pi(q) grad U(q).|constrainedPotentialFlow_statement|statement_only|仅给定正则固定q；真实约束ODE，不用流结论作假设
164|4.3.5.1|定义|The constrained kinetic flow is the mass-weighted geodesic system q'=M^-1p,p'=-G^Tlambda,g(q)=0.|geodesicRelation|defined|不搭建流形测地流存在理论
164|4.3.6|定义|M-SHAKE implements SHAKE using the Newton solver; the traditional solver is component-wise.|mShakeIteration|defined|只登记数学迭代；计算成本/实现建议非数学定理
165|4.3.6|定义|SETTLE uses an exact small-system constraint solve; LINCS approximates an inverse by a series.|settleRelation;lincsInverse|defined|SETTLE为exact关系，正文没有详细closed form，不额外发明；LINCS有限级数
165|4.3.6|未编号结论|The LINCS Neumann series converges to the inverse when the coupling matrix is contractive.|lincsConvergence_statement|statement_only|范数<1；缺一般算法误差/并行成本理论
167|4.4|定义|The center of mass is sum mi qi divided by total mass and weighted relative positions sum to zero.|totalMass;centerMass;relativePositions|defined|排除TIP4P介绍模型和数值实例
167|4.4|未编号结论|Kinetic energy splits into translational and relative rotational terms when weighted relative velocities sum to zero.|kineticSplit_statement|statement_only|质量正、真实有限和；只陈述
168|4.4|定义|The fixed second moment matrix R is sum mi delta_i delta_i^T and Krot=trace(dotTheta R dotTheta^T)/2.|secondMoment;rotationKinetic|defined|参照体坐标；不含例4.1独立交付
168|4.4|未编号结论|For an orthogonal rotation trajectory, dotTheta Theta^T is skew-symmetric.|rotationSkew_statement|statement_only|真实HasDerivAt与局部正交
169|4.4|定义|skew(omega) is the displayed 3x3 cross-product matrix, (4.38).|skewMatrix;cross3|defined|坐标展开，固定右手符号
169|4.4|未编号结论|skew(omega)delta=omega cross delta, and rigid relative velocities have this form, (4.39).|crossMatrix_statement|statement_only|有限坐标恒等式与实际运动学分开
169|4.4|定义|The inertia tensor is sum mi (abs(delta_i)² I-delta_i delta_i^T).|inertiaTensor;rotationalEnergy|defined|body angular velocity/动能定义；平方范数用Euclidean有限和
169|4.4|未编号结论|The printed relation is R=trace(T) I-T, (4.40); the corrected coefficient is trace(T)/2.|inertiaTracePrinted_statement;inertiaTraceCorrected_statement|statement_only|已图像核对；保留字面及修正版，字面一般不成立
170|4.4|定义|The rigid body matrix Hamiltonian is p_cm²/(2M)+trace(Pi R^-1 Pi^T)/2+U(q_cm,Theta).|rigidHamiltonian|defined|R逆存在另需非奇异，正交约束单列
171|4.4|定义|The rigid matrix ODE has q'=p/M,Theta'=Pi R^-1,p'=-grad_q U,Pi'=-grad_Theta U-Theta Lambda,Theta^TTheta=I.|rigidMatrixRelation|defined|矩阵梯度以实际fderiv构造；未搭解存在/辛理论
171|4.4.1|定义|Spatial angular momentum is sum mi delta_i cross delta_i', and body momentum is Theta^T l.|angularMomentum;bodyMomentum|defined|实际有限坐标函数
171|4.4.1|未编号结论|Body angular momentum equals inertia times body angular velocity.|angularInertia_statement|statement_only|在SO(3)旋转下；正文三重积符号需导师复核
172|4.4.1|定义|Free-body Euler equations are pi'=pi cross (T^-1 pi), (4.41).|eulerRigidField;freeRigidSolution|defined|正惯性矩阵；不把解存在计为定义
172|4.4.1|未编号结论|Euler dynamics conserves rotational energy and angular momentum magnitude.|rigidInvariants_statement|statement_only|实际ODE、对称正定T，固定时间区间
172|4.4.1|定义|The noncanonical structure is J(pi)=skew(pi), with J(pi)pi=0.|rigidPoissonMatrix|defined|J退化；是否Poisson/Jacobi另待理论
173|4.4.1|定义|Split free-body dynamics rotates successively about principal inertia axes.|axisRotation;spinAxis;spinStep|defined|显示第二分量误写pi，采用pi_2；正I1/I2/I3
173|4.4.1|未编号结论|Each principal-axis subsystem is solved exactly by its planar rotation, and the composition is a Poisson integrator.|axisFlow_statement;spinPoisson_statement|statement_only|真实解公式与非canonical Poisson映射分开；不搭完整刚体辛理论
173|4.4.2|定义|The force is -partial_q U and torque is -rot(Theta^T partial_Theta U).|rigidForce;matrixRot;rigidTorque|defined|实际Fréchet偏导，原rot(A)=skew^-1(A-A^T)，不额外除以2
174|4.4.2|定义|The DLM step is half kick, drift, five-axis symmetric spin, half kick with refreshed force/torque.|dlmPrinted;dlmMassConsistent|defined|原drift写q+h p缺1/M，保留字面与质量一致版；实际算法映射
174|4.4.2|未编号结论|Drift and spin commute, revealing the symmetric kick-drift-spin-drift-kick composition.|driftSpinCommute_statement|statement_only|真实分量更新，正质量与惯量
174|4.4.2|未编号结论|The complete rigid-body splitting is symmetric and preserves the constrained geometric structure.|dlmStructure_statement|statement_only|完整非canonical Poisson/约束辛性缺口；不搭建新理论
'''
fields=['id','节号','印刷页','PDF页','类型','原文陈述(英文原句或忠实转述)','Lean声明名','文件:行号','状态','备注']
rows=[]
for line in data.strip().splitlines():
    p,sec,kind,text,names,status,note=line.split('|')
    names=';'.join('MolecularDynamics.'+n[1:] if n.startswith('@') else 'MolecularDynamics.Chapter04Review.'+n for n in names.split(';'))
    rows.append(dict(zip(fields,[f'CH04-{len(rows)+1:03}',sec,p,str(int(p)+22),kind,text,names,'补齐阶段解析',status,note])))
with target.open('w',encoding='utf-8-sig',newline='') as f:
    w=csv.DictWriter(f,fieldnames=fields);w.writeheader();w.writerows(rows)
print('CH04 rows:',len(rows))
