"""First eight entries, original PDF161–162."""
from ch04_data import add,copied,proposition,D
add('LinearField','4',139,[1],r'''Let us recall the method of studying the asymptotic numerical stability of a linear system
\[\dot z=Az,\tag{4.1}\]
where $z\in\mathbb R^m,A\in\mathbb R^{m\times m}$, when solved by a numerical method.''',copied(D,'linearField'),kind='definition',label='(4.1)',extra=['复线性扩张用于随后的标量测试；原实矩阵实例嵌入ℂ。'],context=['原文generic conditions下才作特征分解；非半单Jordan边界不能只依据特征值。'])
add('EulerFactor','4',139,[2],r'''Here $\lambda\in\mathbb C$, hence $u$ may in general be complex. Then one applies the numerical method directly to the scalar equation. For example Euler’s method yields
\[u_{n+1}=(1+h\lambda)u_n.\]''',copied(D,'eulerFactor'),kind='definition',context=['标量连续方程u′=λu，h实数；迭代因子1+hλ。'])
add('ScalarEulerStable','4',139,[3],r'''The iteration is stable if $|u_n|$ remains bounded as $n\to\infty$, implying the following condition for asymptotic stability:
\[|1+h\lambda|\le1.\]''',proposition('scalarEulerStable_statement'),extra=['scalarStable明确定义为因子各次幂一致有界；非零初值下等价于迭代有界，零初值例外。'],missing='待标量复数模幂有界与≤1的短证明；不使用任意矩阵谱条件冒充。')
add('EulerRegion','4',139,[4],r'''This defines the “stability region” for Euler’s method as a disk in the complex $h\lambda$-plane centered around $-1$ of radius $1$.''',copied(D,'eulerStabilityRegion'),kind='definition',context=['自变量z=hλ，集合{z:ℂ|‖1+z‖≤1}。'])
add('OscillatorMatrix','4',139,[5],r'''If we consider applying this technique to the harmonic oscillator $\dot q=p;\dot p=-\Omega^2q$, then the matrix $A$ is
\[A=\begin{bmatrix}0&I\\-\Omega^2&0\end{bmatrix}.\]''',copied(D,'oscillatorMatrix'),kind='definition',extra=['一个自由度，I=1；按标量频率实例解释。'])
add('EulerImaginaryGrowth','4',140,[6],r'''The eigenvalues are $\pm i\omega$. The stability condition always fails to hold and, for Euler’s method, $z_n$ grows exponentially rapidly away from the equilibrium point.''',proposition('eulerImaginaryGrowth_statement'),extra=['h≠0、Ω≠0、复标量非零初值；只证明此线性振荡例，不声称所有非线性Hamiltonian平衡点都有纯虚谱。'],context=['原页从Ω改用ω；矩阵的完整±iΩ谱另列，不由增长结论替代。'],missing='待复数因子模大于1及幂趋无穷短证明。')
add('SymplecticEulerMatrix','4',140,[7],r'''The timestep map is defined by
\[Q=q+hP,\qquad P=p-h\Omega^2q.\]
Solving for $Q,P$ this yields
\[\begin{bmatrix}Q\\P\end{bmatrix}=\begin{bmatrix}1-h^2\Omega^2&h\\-h\Omega^2&1\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix}.\]''',copied(D,'symplecticEulerMatrix'),kind='definition',context=['动量先更新，位置使用P。'])
add('SymplecticEulerCharacteristic','4',140,[8],r'''The eigenvalues of the matrix are easily found, they are
\[\lambda_{1,2}=1-\frac{h^2\Omega^2}{2}\pm\frac12\sqrt{h^4\Omega^4-4h^2\Omega^2}.\]''',proposition('symplecticEulerCharacteristic_statement'),extra=['以真实复特征多项式等式表达二次根方程；全部复根公式另列，不能将特征多项式等式当实际求根已证。'],missing='待有限2×2行列式短证明；复根的分支与边界在相邻条记录。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ScalarEulerStable','EulerImaginaryGrowth','SymplecticEulerCharacteristic'])
