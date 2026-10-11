"""MOLLY and holonomic definitions, eight records from PDF171–174."""
from ch04_data import add,copied,proposition,D
C='MolecularDynamics/Chapter04/CotangentProjection.lean'
add('HolonomicRelation','4.3',150,[32],r'''In this section we consider holonomic constraints which may be expressed in terms of positions only, and perhaps time, i.e.
\[g(q,t)=0.\tag{4.3}\]''',copied(D,'holonomicRelation'),kind='definition',label='(4.3)',context=['g的真实位置/时间函数；不同于任意独立动量约束。'])
add('TimeConstraintDerivative','4.3',150,[33],r'''Note that by differentiating (4.3) with respect to time, we obtain $\nabla_q g(q,t)\cdot\dot q+\partial g/\partial t=0$ which involves velocities.''',proposition('timeConstraintDerivative_statement'),extra=['g的实际uncurry可微、真实曲线导数q′=v、在当前时刻邻域g(q(s),s)=0；不把导数等于0作假设。'],missing='待乘积曲线链式法则和局部零函数导数短证明。')
add('ConstrainedSolution','4.3',152,[34],r'''the equations of motion may be written
\[\dot q=M^{-1}p,\tag{4.4}\]
\[\dot p=-\nabla U(q)-\sum_{k=1}^l\lambda_k\nabla g_k(q),\tag{4.5}\]
\[0=g_j(q),\quad j=1,2,\ldots,l.\tag{4.6}\]
then we may write the constrained equations of motion in the form
\[\dot q=M^{-1}p,\tag{4.7}\qquad\dot p=-\nabla U(q)-g'(q)^T\lambda,\tag{4.8}\qquad0=g(q).\tag{4.9}\]''',copied(D,'constrainedSolution'),kind='definition',label='(4.4)–(4.9)',context=['F=−grad U代入所给一般位置力定义；实际各时刻导数和逐分量约束，不假定λ存在。'])
add('ConstraintSet','4.3',152,[],r'''Constraints such as those described above define a manifold in the configuration space $\mathcal M=\{q\mid g(q)=0\}$.''',copied(D,'constraintSet'),kind='definition',extra=['定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。'])
add('CotangentSet','4.3',152,[35],r'''The set of pairs $(q,p)$ satisfying, simultaneously, the equations
\[g(q)=0,\qquad g'(q)M^{-1}p=0,\]
is called the co-tangent bundle associated to the manifold $\mathcal M$, and we refer to it as $T^*\mathcal M$.''',copied(D,'cotangentSet'),kind='definition',context=['真实约束Jacobian和质量逆作用；以嵌入相空间集合实现，不伪称已构造抽象余切丛。'],extra=['正质量及独立梯度为几何解释资格。'])
add('ConstraintJacobian','4.3',152,[36],r'''It is often convenient to combine all the constraints and to describe them by a single vector-valued function $g:\mathbb R^{N_c}\to\mathbb R^l$.''',copied(C,'textbookConstraintJacobian','constraintJacobian'),kind='definition',context=['g′由各真实Fréchet偏导组成，原页方程(4.8)的Jacobian对象。'])
add('JacobianActualDerivative','4.3',152,[37],r'''Given a motion $(q(t),p(t),\lambda(t))$ of (4.7)–(4.9) we note that $g(q(t))\equiv0$ at all times $t$, hence, by differentiation
\[g'(q(t))\dot q(t)\equiv0,\]
which we may rephrase as
\[g'(q(t))M^{-1}p(t)\equiv0.\]''',copied(C,'textbookConstraintJacobian_eq_actualDerivative','jacobianActualDerivative'),extra=['[EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。'],prior=['MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['TimeConstraintDerivative'])
