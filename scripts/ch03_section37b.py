"""Eight §3.7.1–2 claims, original PDF156–157."""
from ch03_data import add,copied,proposition,D,RECORDS
add('ObstacleReflection','3.7.1',134,[133],r'''The coefficient $\alpha$ is chosen so that the kinetic energy is conserved through collision, thus
\[\alpha=-2\frac{u_\perp\cdot\overline P}{u_\perp\cdot u_\perp}.\]''',copied(D,'obstacleReflection'),kind='definition',context=['质量=1，u=qc非零；本定义是p+αu的实际函数，能量性质关联ElasticEnergy。'])
add('PrimitiveDefect','3.7.1',134,[134],r'''We next calculate the change in energy in a single step by inserting $Q$ and $P$ into the Hamiltonian and expanding around the point of collision $q_c$, obtaining
\[\Delta H\stackrel{\mathrm{def}}=H(Q,P)-H(q,p)=-(h-2\tau_c)\frac{q_c^T\overline P}{q_c^Tq_c}q_c^T\nabla U(q_c)+O(h^2).\]''',proposition('primitiveDefect_statement'),extra=['C³势、固定非零qc、真实初末碰撞步族和0<tc(h)<h；O(h²)以小正h的一致界表示。'],
verdict='NEEDS_HUMAN',explanation='原文P̄是第一次half-kick后的动量；旧正式库Prop的pbar则写初始动量，本Blueprint沿用但明确差O(h)，其线性系数对应及一致族资格需审。',issues=[dict(code='NEEDS_HUMAN',detail='书中P̄与签名初始pbar的差异及通过O(h²)吸收的正则性需要独立审校。')],missing='缺实际碰撞步族的Taylor展开及一致O(h²)余项；本地非PASS不证明。')
add('CollisionDefectZero','3.7.1',134,[135],r'''• the collision occurs at the middle of the timestep, $\tau_c=h/2$,
• the directional derivative of $U$ along the collision vector $(u_\perp=q_c)$ vanishes, or
• the momentum vector is orthogonal to the collision vector at the point of contact.''',proposition('collisionDefectZero_statement',proof='exact MolecularDynamics.Chapter03Review.collisionDefectZero_proved'),
context=['只给上式线性系数在这三个条件下为0，保留O(h²)，不由零系数推出三阶；no collision/end-step两条另见EndImpactThirdOrderPrinted。'],prior=['MolecularDynamics.Chapter03Review.collisionDefectZero_proved'])
add('EndImpactThirdOrderPrinted','3.7.1',134,[],r'''In cases (i) and (ii) it is clear that the error accumulating in a single step will be third order in the stepsize, since the Verlet method has local error of order three (since it is a second order method).
• there is no collision
• the collision occurs at the end of a timestep''',
proposition('primitiveDefect_statement','endImpactThirdOrderPrinted').replace('0 < tc h ∧ tc h < h','tc h = h').replace('''|((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))+
        (h-2*tc h)*(inner ℝ qc pbar/inner ℝ qc qc)*inner ℝ qc (gradient U qc)| ≤ C*h^2''','''|((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))| ≤ C*h^3'''),
context=['保留(ii)tc=h、原primitive末端反射及最后half-kick的真实步族；无碰撞的Verlet局部三阶在第2章已另述。'],
verdict='FAIL',explanation='一维qc=1,pbar=−1,U(q)=q,tc=h给initial=(1+h+h²/2,−1)、final=(1,1)，ΔH=−h−h²/2，绝非O(h³)。',issues=[dict(code='ERRATUM?',detail='原文end-step豁免与同页−(h−2tc)线性项冲突；具体单位障碍反例见审计。')],missing='字面FAIL不证明，等待网站/导师裁定。')
add('CollisionQuadraticPath','3.7.2',135,[136],r'''The idea is to make use of the quadratic
\[Q(t)=q+tM^{-1}p-\frac{t^2}{2}M^{-1}\nabla U(q)\tag{3.18}\]
which represents the position vector obtained from a Verlet step of size $t$. Note that this defines quadratic paths for all particles in the system.''',copied(D,'collisionQuadraticPath'),kind='definition',label='(3.18)',context=['F=−grad U代入一般Force函数；t²/2实际有限多项式。'])
add('CollisionTimeRelation','3.7.2',135,[137],r'''It is then possible to calculate the collision times by solving equations
\[\|Q_i(t)-Q_j(t)\|=\sigma_i+\sigma_j,\qquad i\ne j.\tag{3.19}\]''',copied(D,'collisionTimeRelation'),kind='definition',label='(3.19)',context=['a=Qi,b=Qj,radius=σi+σj；关系列出所有正候选根；下一次最小根与横截资格由方法声明单列。'])
add('CollisionQuartic','3.7.2',135,[138],r'''If the Verlet method is used, then it turns out that the insertion of (3.18) into (3.19) results in a quartic polynomial that must be solved for each particle pair.''',proposition('collisionQuartic_statement',proof='exact MolecularDynamics.Chapter03Review.collisionQuartic_proved'),context=['a=qᵢ−qⱼ,b=vᵢ−vⱼ,c=(M⁻¹Fᵢ−M⁻¹Fⱼ)/2；完整四次系数及norm等价，不假设其根存在。'],extra=['radius≥0保证平方不引入负半径伪根；四次最高系数可退化，degree≤4。'],prior=['MolecularDynamics.Chapter03Review.collisionQuartic_proved'])
add('CollisionalVerletRelation','3.7.2',135,[139],r'''Collisional Verlet Algorithm (CVA) [Single Step]
[computes $h$ (the timestep) and $(Q,P)$ given a starting point $(q,p)$]
Calculate $\tau_c$ the time of next collision from the Verlet paths (quadratics) of (3.18) using collision conditions (3.19).
If $\tau_c<h_{\max}$, then
\[h:=\tau_c,\qquad(Q,P):=R_c\mathcal G_h^{\mathrm{Verlet}}(q,p)\]
else
\[h:=h_{\max},\qquad(Q,P):=\mathcal G_h^{\mathrm{Verlet}}(q,p).\]''',copied(D,'collisionalVerletRelation'),kind='definition',context=['实际方法关系保持严格tc<hmax；tc=hmax时原算法不反射，随后顺序/资格疑点保留。'],extra=['tc>0,hmax>0明示；tc必须是下一接触时刻，求根实现不是数学定理。'],issues=[dict(code='NEEDS_HUMAN',detail='tc=hmax边界时原伪代码不反射，之后的二阶陈述排除此边界，不能冒充一般结果。')])
