"""Six resonance claims and two MOLLY definitions, PDF168–171."""
from ch04_data import add,copied,proposition,D
add('ImpulseTrace','4.2.1',146,[25],r'''On the other hand, a short calculation shows that
\[\lambda_1+\lambda_2=\operatorname{Tr}(W_h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega).\]''',proposition('impulseTrace_statement'),extra=['Ω≠0；本条完整矩阵trace恒等式，特征值与trace关系需有限谱桥接。'],missing='待有限矩阵乘积与trace代数短证明。')
add('ResonancePower','4.2.1',146,[26],r'''For example, at $h=\pi/\Omega$, we have
\[F_h=-I\Rightarrow W_h=-S_{h/2}^2=-\begin{bmatrix}1&0\\-h&1\end{bmatrix},\]
so that
\[W_h^n=(-1)^n\begin{bmatrix}1&0\\-nh&1\end{bmatrix}.\]''',proposition('resonancePower_statement'),extra=['Ω>0；所有自然数k，不止图中有限迭代。'],missing='待π角sin/cos化简与二维nilpotent矩阵幂归纳。')
add('ResonanceGrowth','4.2.1',147,[27],r'''and the norm of the solution will oscillate and grow linearly with $n$ as $n\to\infty$. This is the simplest type of linear resonance present in multiple timestepping.''',proposition('resonanceGrowth_statement'),extra=['原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。'],context=['实际所有矩阵幂作用的范数趋无穷；线性率可从前条幂公式读取，尚未声称已证。'],missing='待前条真实幂公式与分量范数下界，非仅数值实验。')
add('ResonanceTaylor','4.2.1',147,[28],r'''We can see this by expanding $\mu(h)=2\cos(h\Omega)-\frac h\Omega\sin(h\Omega)$ in a Taylor expansion around $h=\pi/\Omega$:
\[\mu(h)=-2+\varepsilon,\qquad\varepsilon=\frac\pi\Omega(h-\pi/\Omega).\]''',proposition('resonanceTaylor_statement'),extra=['[EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。'],missing='待真实二阶Taylor余项及三角导数在共振点的桥接。')
add('ResonanceInstability','4.2.1',147,[29],r'''Here both eigenvalues are real and one is outside the unit circle. There is thus a small interval of exponential instability directly below $h=\pi/\Omega$.''',proposition('resonanceInstability_statement'),extra=['Ω>0；存在左邻域，每个h有真实复谱模>1。'],missing='缺trace<-2的局部Taylor判定与真实复特征向量桥接；保留实际谱而非假设谱。')
add('ResonanceEigenPrinted','4.2.1',147,[],r'''For $\varepsilon<0$, however, we have
\[\lambda=-1\pm(|\varepsilon|/2)^{1/2}+O(\varepsilon).\]''',proposition('resonanceEigenPrinted_statement'),verdict='NEEDS_HUMAN',explanation='det=1、trace=−2+ε的二次根近−1±sqrt(|ε|)+O(ε)，印刷sqrt(|ε|/2)系数疑误；保留字面实根误差界，未更正成PASS。',issues=[dict(code='ERRATUM?',detail='根展开首项疑少sqrt(2)因子；待网站/导师裁定。')],missing='字面签名疑误不证明；正确二次根展开也未声称已证。')
add('MollifiedAverage','4.2.2',149,[],r'''The mapping $\mathcal A(q)$ is defined by reference to the fast dynamics, e.g. by the weighted average
\[\mathcal A(q)=\frac1{K+1}\sum_{i=0}^K\phi_i\theta_i(q),\]
where the $\theta_i$ are defined recursively by solving the system with Hamiltonian
\[H^{\mathrm{fast}}(q,p)=p^TM^{-1}p/2+U_F(q)\]
starting from initial position $q$ and zero initial momentum $p$, for $K$ timesteps using a small stepsize $\tau_f$.''',copied(D,'mollifiedAverage'),kind='definition',extra=['[EXTRA]原未指定快积分器，以真实fastVerlet离散位置作为θi的具体实例；K+1项有限加权和，不假定权重任意都有效滤波。'])
add('MollifiedPotential','4.2.2',149,[30],r'''Effectively, one replaces $U_S(q)$ wherever it appears within the MTS method by a modified potential function $\overline U(q)\stackrel{\mathrm{def}}=U_S(\mathcal A(q))$.''',copied(D,'mollifiedPotential'),kind='definition',context=['实际US∘A；前条原页加权构造分开，不将def当滤波性能定理。'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ImpulseTrace','ResonancePower'])
