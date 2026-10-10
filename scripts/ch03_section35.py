"""Eight §3.5 entries from visually checked PDF144–146."""
from ch03_data import add,copied,proposition,D
add('EqualComponentIntegral','3.5',122,[90],r'''Consider the following 2D example of a differential equation system
\[\dot u=f(u,v),\qquad\dot v=f(u,v).\]
Notice that this system has a first integral
\[I(u,v)=u-v,\]
and consider the application of Euler's method:
\[u_{n+1}=u_n+hf(u_n,v_n),\qquad v_{n+1}=v_n+hf(u_n,v_n).\]''',
'''theorem equalComponentFirstIntegral :
    ∃ I : ℝ × ℝ → ℝ, (∀ z, I z = z.1-z.2) ∧
      ∀ (f : ℝ × ℝ → ℝ) (u v : ℝ → ℝ),
        (∀ t, HasDerivAt u (f (u t,v t)) t) →
        (∀ t, HasDerivAt v (f (u t,v t)) t) →
        ∀ t, I (u t,v t) = I (u 0,v 0) := by
  sorry''',
context=['Euler一步不变性在下一条；本条同时给真实I函数及连续轨道的first-integral结论，非只定义函数。'],extra=['真实轨道导数资格显式，采用全实时间轨道版本，不宣称任意f都全时间有解。'],missing='待减法导数为0与常函数短证明。')
add('EqualEulerIntegral','3.5',123,[91],r'''We see that
\[I(u_{n+1},v_{n+1})=u_{n+1}-v_{n+1}=u_n-v_n=I(u_n,v_n),\]
which means that Euler's method conserves this first integral.''',proposition('equalEulerIntegral_statement',proof='exact MolecularDynamics.Chapter03Review.equalEulerIntegral_proved'),context=['同页与PDF144的Euler更新及I=u−v。'],prior=['MolecularDynamics.Chapter03Review.equalEulerIntegral_proved'])
add('LinearEulerIntegral','3.5',123,[92],r'''Generalizing this slightly, we could imagine a system of ODEs of the form
\[\dot{\boldsymbol z}=f(\boldsymbol z),\]
such that, for some vector $\boldsymbol b$,
\[\boldsymbol b\cdot f(\boldsymbol z)\equiv0,\]
then $I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z$ is a first integral. It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.''',proposition('linearEulerIntegral_statement',proof='exact MolecularDynamics.Chapter03Review.linearEulerIntegral_proved'),
context=['精确实数一步Euler保持线性函数；连续ODE first integral由链式法则；不解释为机器浮点完全无误差。'],prior=['MolecularDynamics.Chapter03Review.linearEulerIntegral_proved'])
add('LinearRKIntegral','3.5',123,[93],r'''It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.''',proposition('linearRKIntegral_statement',proof='exact MolecularDynamics.Chapter03Review.linearRKIntegral_proved'),
context=['原文many other popular numerical methods的Runge–Kutta实例作为[EXTRA]证明辅助，不宣称原句明确列出RK；实际有限阶段方程用第2章定义。'],extra=['明确选择任意有限阶段Runge–Kutta关系；所有阶段满足原场线性第一积分资格。'],prior=['MolecularDynamics.Chapter03Review.linearRKIntegral_proved'])
add('VerletOscillatorEnergy','3.5',123,[94],r'''In the case of Euler's method applied to the harmonic oscillator, the error in energy grows with time and without bound. In the case of Störmer-Verlet, the energy fluctuates but remains bounded for all time and at its worst is of size proportional to $h^2$, a numerical observation that is supported by the existence of the modified Hamiltonian.''',proposition('verletOscillatorEnergy_statement'),context=['Euler无界另为EulerGrowth；本条保留Verlet谐振子全时间能量界。'],extra=['Ω>0，固定ρ∈(0,2)，|hΩ|≤ρ；排除不稳定及阈值步长。'],missing='缺稳定Verlet矩阵的正定不变量及初值相关一致h²界；短矩阵能量路线尚待尝试。')
add('MomentumProjection','3.5',123,[95],r'''We start by taking a timestep with any arbitrary (nonconserving) numerical method, say to an intermediate phase point $\overline Q,\overline P$, then we “fix it up” by scaling the momentum by an adjustment factor, defining
\[Q=\overline Q,\qquad P=\gamma\overline P,\]
selecting $\gamma$ so that the energy in the result is a prescribed value $E$.''',copied(D,'momentumProjection'),kind='definition',context=['γ选择由后面的constraint及factor定义，投影本身不证明可求解性。'])
add('ProjectionConstraint','3.5',123,[96],r'''This method is easy to implement: the equation that must be solved is
\[\frac{\gamma^2\overline P^TM^{-1}\overline P}{2}+U(\overline Q)=E.\tag{3.12}\]''',copied(D,'projectionConstraint'),kind='definition',label='(3.12)',context=['K=P̄ᵀM⁻¹P̄/2，U=U(Q̄)；γ约束。'])
add('ProjectionFactor','3.5',124,[97],r'''and, since $\overline Q$ is known, this gives
\[\gamma=\left(\frac{E-\overline U}{\overline K}\right)^{1/2},\tag{3.13}\]
where $\overline U=U(\overline Q)$ and $\overline K=\overline P^TM^{-1}\overline P/2$ are the potential and kinetic energies after a step of the original non-conserving scheme.''',copied(D,'projectionFactor'),kind='definition',label='(3.13)',context=['实平方根取非负分支；原文要求K>0、E−U≥0，定义的真实约束解另列ProjectionEnergy。'])
from blueprint_source import apply_saved_routes
from ch03_data import RECORDS
apply_saved_routes(3,RECORDS,['EqualComponentIntegral','VerletOscillatorEnergy'])
