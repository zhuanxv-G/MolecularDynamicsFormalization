"""First eight source records, visually verified printed 180–181/PDF201–202."""
from ch05_data import add,copied,proposition,D,NS,EXCLUDED
add('LieDerivative','5.1',180,[1],r'''In Chap. 3, we introduced the Lie derivative of a function $g$ of the phase variables with respect to a dynamical system $\dot z=f(z)$:
\[\mathcal L_fg=f\cdot\nabla g.\]''',copied(D,'lie'),kind='definition',context=['相空间采用实际EuclideanSpace；fderiv是真实Fréchet导数。'])
add('TrajectoryChain','5.1',180,[2],r'''This is obtained by differentiating a composite function $g(z(t))$ with respect to $t$, along a solution trajectory. That is, describing a trajectory in terms of the flow map by $z(t)=\mathcal F_t(\xi),t\in\mathbb R$, we have
\[\frac d{dt}g(\mathcal F_t(\xi))=(\mathcal L_fg)(\mathcal F_t(\xi)).\]
The partial derivative of $\widetilde g(z,t)$ with respect to $t$ is
\[\frac{\partial\widetilde g}{\partial t}(t,z)=\nabla g(\mathcal F_t(z))\cdot\frac d{dt}\mathcal F_t(z)=\nabla g(\mathcal F_t(z))\cdot f(\mathcal F_t(z))=(\mathcal L_fg)(\mathcal F_t(z)).\tag{5.1}\]''',copied('MolecularDynamics/Chapter03/LiePoisson.lean','hasDerivAt_textbookLieDerivative','trajectoryChain'),extra=['[EXTRA]复用一般实赋范空间的真实可微链式法则，Euclidean相空间是其特例；给定实际解的导数，不假设结论。'],prior=['MolecularDynamics.hasDerivAt_textbookLieDerivative'])
add('ActualFlow','5.1',180,[],r'''describing a trajectory in terms of the flow map by $z(t)=\mathcal F_t(\xi),t\in\mathbb R$.''',copied(D,'flow'),kind='definition',extra=['[EXTRA]明确自洽的零时刻、群律和实际自治ODE解条件；不给任意映射冠以流，也不构造流存在理论。'])
add('ObservablePullback','5.1','180–181',[3,7],r'''Replacing $\xi$ by $z$ (it is an arbitrary point), define a function $\widetilde g(z,t)\stackrel{\rm def}{=}g(\mathcal F_t(z))$.
It is intuitively appealing to define the solution of (5.2) by
\[\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}.\]''',copied(D,'pullback'),kind='definition',context=['Gt及exp(tLf)作为实际pullback的解算子记号；不伪造无界算子指数级数的收敛或存在证明。'])
add('FlowFieldTransport','5.1',181,[4],r'''On the other hand, viewing $\mathcal L_f$ as an operator on the phase variables only, we have
\[(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]
=f(z)\cdot\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))
=\mathcal F_t'(z)f(z)\cdot\nabla g(\mathcal F_t(z))
=f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))
=(\mathcal L_fg)(\mathcal F_t(z)).\]''',proposition('flowFieldTransport_statement'),extra=['[EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。'],missing='待既有流群律、真实链式法则与一维导数唯一性短桥；不建设一般ODE流存在理论。')
add('PullbackPDE','5.1',181,[5],r'''This is the same as the right hand side of (5.1). This means that $\widetilde g$ satisfies the equation
\[\frac{\partial\widetilde g}{\partial t}=\mathcal L_f\widetilde g.\tag{5.2}\]
This is a time-dependent, linear (hyperbolic) partial differential equation.''',proposition('pullbackPDE_statement'),extra=['[EXTRA]实际C²流和C¹可观测量；只证给定实际pullback的PDE，不把一般PDE适定性作结论。'],missing='所需FlowFieldTransport短桥已失败3条路线并停止；本条保留sorry，不以含sorryAx的引理伪造已证，不建设一般输运PDE适定性理论。')
add('SteadyFirstIntegral','5.1',181,[6],r'''The steady state solutions of this equation (defined by $\partial\widetilde g/\partial t=0$) are of the form $\widetilde g(z,t)=\varphi(z)$ where $\varphi$ satisfies $\mathcal L_f\varphi(z)\equiv0$. These are just the first integrals of the ordinary differential equation system $\dot z=f(z)$.''',proposition('steadyFirstIntegral_statement'),extra=['[EXTRA]所有初值上的真实自治流、可微g；结论是Lie导数零与沿所有轨道恒定的完整双向关系。'],missing='待真实轨道链式法则、零导数常值和零时刻导数唯一性短桥。')
add('CoordinatePullback','5.1',181,[8],r'''The interpretation of the solution of the initial value problem in terms of the solution operator $G_t$ is given by
\[(e^{t\mathcal L_f}\partial_i)(z(0))=z_i(t).\]''',copied('MolecularDynamics/Chapter05/ReviewProofs.lean','coordinatePullback_proved','coordinatePullback'),context=['∂i(z)=zi是坐标投影，不是对坐标取偏导的算子；actual pullback等式，不计流存在证明。'],prior=['MolecularDynamics.Chapter05Review.coordinatePullback_proved'])
EXCLUDED += [dict(printed_page='179–181',pdf_page='200–202',reason='引言的宏观/微观建模动机、参考教材推荐，以及iL与量子记号的物理解释为定性背景；Lie导数、流、PDE、第一积分和坐标投影的数学内容保留。')]
