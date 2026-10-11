"""Eight rigid equations and invariants, PDF193–194."""
from ch04_data import add,copied,proposition,D,NS
add('RigidMatrixRelation','4.4',171,[88],r'''The constraint may be enforced using Lagrange multipliers with the following equations
\[\frac d{dt}q_{\rm cm}=p_{\rm cm}/M,\quad\frac d{dt}\Theta=\Pi R^{-1},\]
\[\frac d{dt}p_{\rm cm}=-\nabla_{q_{\rm cm}}U,\quad\frac d{dt}\Pi=-\nabla_\Theta U-\Theta\Lambda,\quad I=\Theta^T\Theta.\]''',copied(D,'rigidMatrixRelation'),kind='definition',context=['真实Fréchet矩阵元素偏导，完整轨道关系；不计解存在证明。'])
add('AngularMomentum','4.4.1',171,[89],r'''The angular momentum vector in the reference frame is given by $l=\sum_{i=1}^Nm_i\delta_i\times\dot\delta_i$.''',copied(D,'angularMomentum'),kind='definition')
add('BodyMomentum','4.4.1',171,[89],r'''Define $\pi=\Theta^Tl$, the angular momentum vector referred to the body frame of reference.''',copied(D,'bodyMomentum'),kind='definition')
add('AngularInertia','4.4.1',171,[90],r'''From Eq. (4.39) we may write this as $l=\sum_im_i\delta_i\times\omega\times\delta_i$, from which, using the vector triple product identity $a\times b\times c=(a\cdot c)b-(a\cdot b)c$, we obtain $l=\sum_im_i[\|\delta_i\|^2I-\delta_i\delta_i^T]\omega$. Define $\pi=\Theta^Tl$, then we have (using $\delta_i=\Theta\delta_i(0)$): $\pi=T\omega_b$.''',proposition('angularInertia_statement'),extra=['真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。'],missing='待SO3叉积协变与惯性有限和短桥；不搭新刚体理论。')
add('EulerRigidField','4.4.1',172,[91],r'''but since $\omega_b=T^{-1}\pi$, we may conclude $\dot\pi=\pi\times T^{-1}\pi$. These are the so-called Euler equations for the free rigid body.''',copied(D,'eulerRigidField'),kind='definition',label='(4.41)')
add('FreeRigidSolution','4.4.1',172,[91],r'''$\dot\pi=\pi\times T^{-1}\pi$.''',copied(D,'freeRigidSolution'),kind='definition',context=['实际HasDerivWithinAt解关系；不计轨道存在。'])
add('RigidInvariants','4.4.1',172,[92],r'''the Euler equations are in the form of a Hamiltonian system on a three-dimensional phase space. The symplectic structure matrix is dependent on the phase variables, and it is degenerate: $\widetilde J\pi=\pi\times\pi=0$, signifying that total angular momentum is conserved: $\|\pi\|=\mathrm{constant}$.''',proposition('rigidInvariants_statement'),extra=['对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。'],missing='缺实际区间导数与逆惯性对称性/cross正交短桥；不建立刚体解存在理论。')
add('RigidPoissonMatrix','4.4.1',172,[93],r'''$\dot\pi=\widetilde J(\pi)\nabla\widetilde H$, where $\widetilde J(\pi)=\operatorname{skew}(\pi)$ is obviously skew symmetric, and $\widetilde H=\pi^TT^{-1}\pi/2$ is the energy function.''',copied(D,'rigidPoissonMatrix'),kind='definition',context=['真实skewπ；退化与场恒等式另条，不假称Jacobi或全Poisson理论已验。'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['AngularInertia','RigidInvariants'])
