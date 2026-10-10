"""Rendered-page transcription for §2.2; imported after the §2.1 checkpoint."""
from ch02_data import add, copied, proposition, EXCLUDED, RECORDS, ROOT
RD='MolecularDynamics/Chapter02/ReviewDefinitions.lean'
OC='MolecularDynamics/Chapter02/OneStepConvergence.lean'
def issue(detail):return [dict(code='ERRATUM?',status='NEEDS_HUMAN',detail=detail)]
def d(name):return copied(RD,name,'bp_'+name)

add('VerletOrder','2.2',60,[18],r'''The Verlet method (also known as leapfrog or Störmer-Verlet) is a second order method that is popular for molecular simulation. It is specialized to problems that can be expressed in the form $\dot{\boldsymbol q}=\boldsymbol v$, $M\dot{\boldsymbol v}=F(\boldsymbol q)$, with even dimensional phase space $\mathbb R^{2N_c}$, which includes constant energy molecular dynamics.''',proposition('verletOrder_statement'),
extra=['固定正对角质量、力全域C⁴、τ>0及实际解在闭时间窗连续；原文未逐一给出的阶定理正则性显式列出。'],missing='缺完整Verlet局部截断误差、稳定性及数值留域推导。')
add('Lagrangian','2.2.1',60,[19],r'''Recall from Chap. 1 that the Lagrangian for the N-body system is defined by
\[L(\boldsymbol q,\boldsymbol v)\stackrel{\rm def}{=}\frac{\boldsymbol v^TM\boldsymbol v}{2}-U(\boldsymbol q),\]
where $M$ is the mass matrix and the potential energy function $U$ is, for simplicity, taken to be smooth ($C^2$).''',d('mechanicalL'),kind='definition',context=['M为固定对角质量矩阵；bp_mechanicalL坐标求和给出同一动能。'])
add('Admissible','2.2.1',60,[20],r'''We consider the collection of all twice continuously differentiable curves in the configuration space which start from a certain point $\boldsymbol Q$ and end at another given point $\boldsymbol Q'$. We may think of any such curve as being represented by a parameterization $\boldsymbol q(t)$, $t\in[\alpha,\beta]$ with $\boldsymbol q(\alpha)=\boldsymbol Q$ and $\boldsymbol q(\beta)=\boldsymbol Q'$, where the components of $\boldsymbol q(t)$ are $C^\infty$ functions. Denote by $G=G(\boldsymbol Q,\boldsymbol Q',\alpha,\beta)$ the class of smooth parameterized curves such that $\boldsymbol q(\alpha)=\boldsymbol Q$, $\boldsymbol q(\beta)=\boldsymbol Q'$.''',
'''def admissibleSmooth {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  ContDiff ℝ ∞ q ∧ q a = x ∧ q b = y''',kind='definition',
issues=[dict(code='REGULARITY_AMBIGUITY',status='NEEDS_HUMAN',detail='原页先说twice continuously differentiable，后说C∞/smooth；按后一明确C∞登记，不能用旧CSV的C1转述。')],verdict='NEEDS_HUMAN',explanation='原文C²与C∞两种表述需导师裁定；当前保留后一C∞，尚不视作与整段完全一致。',extra=['全实线C∞延拓强于只在[α,β]光滑的局部资格。'])
add('Action','2.2.1',60,[21],r'''Then the classical action (or, simply, action) of the Lagrangian $L$ is defined for any $\Gamma\in G$ by
\[\mathcal A_L(\Gamma)\stackrel{\rm def}{=}\int_\alpha^\beta L(\boldsymbol q(t),\dot{\boldsymbol q}(t))\,dt.\]''',d('action'),kind='definition',context=['q为Γ的参数曲线；α<β，光滑资格见同页G。'])
add('Variation','2.2.1',61,[22],r'''Given $\Gamma$ in $G$ with parameterization $\boldsymbol q(t)$, $t\in[\alpha,\beta]$, we consider the curve $\Gamma^\epsilon$ with parameterization $\boldsymbol q^\epsilon$ defined by
\[\boldsymbol q^\epsilon(t)=\boldsymbol q(t)+\epsilon\boldsymbol\eta(t),\qquad t\in[\alpha,\beta],\tag{2.3}\]
where $\boldsymbol\eta(t)$ satisfies $\boldsymbol\eta(\alpha)=\boldsymbol\eta(\beta)=\boldsymbol0$. Thus $\boldsymbol\eta$ is a $C^\infty$ parameterized curve linking $\boldsymbol0$ to $\boldsymbol0$.''',d('variation'),kind='definition',context=['η的C∞及零端点是可用变分资格；函数体定义q+εη本身不宣称这些资格自动成立。'])
add('FirstVariation','2.2.1',61,[23],r'''Using a Taylor series expansion of the Lagrangian, we have
\[\mathcal A_L(\Gamma^\epsilon)-\mathcal A_L(\Gamma)=\int_\alpha^\beta[L(\boldsymbol q(t)+\epsilon\boldsymbol\eta(t),\dot{\boldsymbol q}(t)+\epsilon\dot{\boldsymbol\eta}(t))-L(\boldsymbol q(t),\dot{\boldsymbol q}(t))]\,dt,\]
\[=\int_\alpha^\beta\left[\epsilon\left(\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\boldsymbol\eta(t)+\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\dot{\boldsymbol\eta}(t)\right)+O(\epsilon^2)\right]\,dt.\]''',proposition('firstVariation_statement'),
extra=['L、q、η的C²及α<β显式给出；Lean用实际ε导数表达一阶系数，原文O(ε²)余项未完整编码。'],
verdict='NEEDS_HUMAN',explanation='现有实际一阶变分签名只给导数，未给原文二阶余项界；完整展开另需余项理论，不能将只给一阶系数标PASS。',missing='积分下求导及一致二阶Taylor余项。')
add('TaylorPrinted','2.2.1',61,[24],r'''In the multidimensional setting, Taylor’s theorem states that given a $C^{k+1}$ function $f:\mathbb R^m\to\mathbb R$ and a point $\boldsymbol z_0$, we have
\[f(\boldsymbol z)-f(\boldsymbol z_0)=\nabla f(\boldsymbol z_0)\cdot(\boldsymbol z-\boldsymbol z_0)+f^{(2)}\langle\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0\rangle+f^{(3)}\langle\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0\rangle+\ldots f^{(k)}\langle\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0,\ldots,\boldsymbol z-\boldsymbol z_0\rangle+O(\|\boldsymbol z-\boldsymbol z_0\|^{k+1})\]''',
'''theorem taylorPrinted : ∀ n (k : ℕ) (f : Q n → ℝ) z₀,
    1 ≤ k → ContDiff ℝ (k+1) f →
    Asymptotics.IsBigO (𝓝 0)
      (fun u => f (z₀+u)-f z₀-∑ j ∈ Finset.range k,
        iteratedFDeriv ℝ (j+1) f z₀ (fun _ => u))
      (fun u : Q n => ‖u‖^(k+1)) := by
  sorry''',label='Footnote 3',context=[r"原脚注f^(2)明确为Hessian，f^(3)为三阶偏导张量，故不含1/j!不是缩放记号。"],
issues=issue('原脚注二阶及以后漏1/j!；f(x)=x²在0的k=2展开会给2x²，余项差为-x²而非O(x³)。'),verdict='NEEDS_HUMAN',explanation='保留原文漏阶乘的字面式，不静默修正，需导师确认。',missing='原书疑误裁定；正确Taylor余项理论另缺。')
add('StationaryAction','2.2.1','61–62',[25],r'''Hamilton’s principle states that the natural motion of the system described by the Lagrangian $L$ is a stationary point of the classical action which implies that the $O(\epsilon)$ term above should vanish for any smooth variation $\boldsymbol\eta(t)$ with $\boldsymbol\eta(\alpha)=\boldsymbol\eta(\beta)=\boldsymbol0$, i.e.,
\[I=\int_\alpha^\beta\left[\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\boldsymbol\eta(t)+\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\dot{\boldsymbol\eta}(t)\right]dt=0.\]''',
'''def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0''',kind='definition',extra=['驻值以真实一阶变分导数为零定义；展开式相等由FirstVariation条目承担。'])
add('Parts','2.2.1',62,[26],r'''We use integration by parts to remove the differentiation of $\boldsymbol\eta$, thus (in light of the boundary conditions on $\boldsymbol\eta(t)$),
\[I=\int_\alpha^\beta\left[\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t))-\frac{\mathrm d}{\mathrm dt}\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\right]\boldsymbol\eta(t)\,dt=0.\]''',proposition('firstVariationParts_statement'),
context=['I=0来自驻值前提；本条只证明分部积分恒等式，零结论由驻值展开传入。'],extra=['α<β；L及曲线C²；η端点为0。'],missing='连续线性泛函值曲线的区间分部积分。')
add('EulerLagrange','2.2.1',62,[27],r'''Since the variation $\boldsymbol\eta$ is meant to be arbitrary, it requires
\[\frac{\mathrm d}{\mathrm dt}\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))=\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t)),\]
which is precisely the Lagrangian formulation of the equations of motion.''',proposition('hamiltonPrinciple_statement'),extra=['α<β，L及q C²；驻值接口中变分C²，与原文C∞差异须处理。'],verdict='NEEDS_HUMAN',explanation='保留真实作用量与Euler–Lagrange方程双向，但旧接口的C²变分量词与本段C∞不同；需光滑变分基本引理后统一。',missing='基本变分引理、实际一阶变分及C∞/C²资格统一。')
add('VariationalDerivativePrinted','2.2.1',62,[28],r'''Define the variational derivative of a functional $\mathcal F$, $\delta\mathcal F/\delta\boldsymbol q$ so that
\[\mathcal F(\boldsymbol q+\epsilon\boldsymbol\eta)=\epsilon\frac{\delta\mathcal F}{\delta\boldsymbol q}\boldsymbol\eta+O(\epsilon^2),\]
for all suitable (say, $C^\infty$) functions $\boldsymbol\eta$.''',
'''def printedVariationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - ε * A η) (fun ε : ℝ => ε^2)''',kind='definition',
issues=issue('左式漏F(q)，原页实际如此。字面定义对于非零常值F无解，不能静默替成HasFDerivAt。'),verdict='NEEDS_HUMAN',explanation='字面漏基准值；抽象E仅表达函数空间中的方向变分，完整C∞曲线拓扑未构造。')
add('StationaryNotMin','2.2.1',62,[29],'''Any curve which satisfies this equation will represent a “stationary point” (actually, “stationary curve” would be more accurate) of the classical action. Such curves could include smooth local action minimizers, local action maximizers, or “saddle points” of the actional functional in a generalized sense. Deciding whether a given stationary curve is an actual minimizer of the action would require analysis of the second variation (the coefficient of $\epsilon^2$ in the expansion above), which introduces additional complexity.''',
proposition('stationaryNotMinimum_statement'),label='Footnote 4',extra=['用存在驻值但非局部极小的实际L与曲线反例表达could，不声称所有驻值不是极小。'],missing='尚缺具体负动能作用量曲线反例及积分平方严格正证明。')
add('DiscretePath','2.2.2',63,[30],r'''We work on the time interval $[0,\tau]$. Consider the $\nu+1$ points $\boldsymbol q_0$ to $\boldsymbol q_\nu$ in configuration space
\[\hat\Gamma=(\boldsymbol q_0,\boldsymbol q_1,\ldots,\boldsymbol q_\nu).\]''',
'''def finiteDiscretePath (n ν : ℕ) := Fin (ν+1) → Q n''',kind='definition',context=['ν为正整数，νh=τ；端点固定的变分见后文。'])
add('DiscreteVelocity','2.2.2',63,[31],r'''we are led to consider the approximation at time level $n$
\[\boldsymbol v_n\stackrel{\rm def}{=}\frac{\boldsymbol q_{n+1}-\boldsymbol q_n}{h},\]''',d('discreteVelocity'),kind='definition',context=['h>0，n<ν；总函数接口仅在该网格范围使用。'])
add('DiscreteAction','2.2.2',63,[32],r'''and thus, by Riemann summation
\[\mathcal A_L\approx\hat{\mathcal A}\stackrel{\rm def}{=}\sum_{n=0}^{\nu-1} L\left(\boldsymbol q_n,\frac{\boldsymbol q_{n+1}-\boldsymbol q_n}{h}\right)h.\]
In the case of a mechanical system with Lagrangian $L(\boldsymbol q,\boldsymbol v)=\dot{\boldsymbol v}^TM\boldsymbol v/2+U(\boldsymbol q)$, we then have
\[\hat{\mathcal A}=\sum_{n=0}^{\nu-1}\left[\frac{(\boldsymbol q_{n+1}-\boldsymbol q_n)^TM(\boldsymbol q_{n+1}-\boldsymbol q_n)}{2h^2}-U(\boldsymbol q_n)\right]h.\]''',d('discreteAction'),kind='definition',
issues=issue('正文L写v上方点且+U，与p.60/PDF82和紧接展示离散作用量的-U冲突；定义只登记一般L离散求和，不把两种机械式同时认作正确。'),verdict='NEEDS_HUMAN',explanation='一般L的离散求和忠实；机械L字面自相矛盾，需要导师裁定，不能从+U推出后续-U。')
add('DiscreteStationaryPrinted','2.2.2','63–64',[33],r'''Critical points of this function satisfy
\[\nabla\hat{\mathcal A}=0,\]
where the gradient must be taken with respect to all configurational points on the path (and all coordinates). This condition leads to the equations
\[\frac{\partial\hat{\mathcal A}}{\partial\boldsymbol q_n}=0,\qquad n=1,\ldots,\nu,\]
since we think of the starting point $\boldsymbol q_0$ as fixed.''',
'''def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    fderiv ℝ (fun x => discreteAction L (replaceNode q k x) h ν) (q k) = 0''',kind='definition',
issues=issue('原页n=1,…,ν包含右端点，后页说端点固定且只对1,…,ν-1求导。保留字面≤ν，不默改为<ν。'),verdict='NEEDS_HUMAN',explanation='忠实记录字面端点索引，但与固定两端及后文内部节点冲突。')
add('DiscreteDerivative','2.2.2',64,[34],r'''To calculate the derivative of $\hat{\mathcal A}$ with respect to $\boldsymbol q_n$, $n=1,2,\ldots,\nu-1$, note that only a few terms of the discrete action involve this configurational point, thus
\[\frac{\partial\hat{\mathcal A}}{\partial\boldsymbol q_n}=\frac1h[M(\boldsymbol q_n-\boldsymbol q_{n-1})-M(\boldsymbol q_{n+1}-\boldsymbol q_n)]-\nabla U(\boldsymbol q_n)h,\]''',proposition('discreteActionDerivative_statement'),
extra=['固定正对角质量、实际U可微、h≠0；仅内部节点0<k<ν；沿p.60及p.63展示的-U作用量。'],missing='有限节点替换对实际离散作用量的Fréchet求导。')
add('DiscreteVerlet','2.2.2',64,[35],r'''which yields the equations
\[M(\boldsymbol q_{n+1}-2\boldsymbol q_n+\boldsymbol q_{n-1})=-h^2\nabla U(\boldsymbol q_n),\qquad n=1,2,\ldots,\nu-1.\tag{2.4}\]''',proposition('discreteStationaryVerlet_statement'),
context=['端点固定，只对内部节点驻值；L按p.60的-U版本。'],extra=['正对角质量、U可微、h≠0。'],missing='实际离散作用量导数及驻值与Störmer式等价。')
add('Stormer','2.2.2',64,[36,160],r'''The method (2.4) is commonly referred to as Störmer’s rule.''',d('stormerRelation'),kind='definition',context=[r'式(2.4)为$M(q_{n+1}-2q_n+q_{n-1})=h^2F(q_n)$；p.93/PDF115再以消元给同一递推。'])
add('VelocityVerlet','2.2.2',64,[37],r'''The scheme is usually given in an alternative “velocity Verlet” form that takes a step from a given vector $\boldsymbol q_n,\boldsymbol v_n$ to $\boldsymbol q_{n+1},\boldsymbol v_{n+1}$ by the sequence of operations
\[\boldsymbol v_{n+1/2}=\boldsymbol v_n+(h/2)M^{-1}F_n,\tag{2.5}\]
\[\boldsymbol q_{n+1}=\boldsymbol q_n+h\boldsymbol v_{n+1/2},\tag{2.6}\]
\[\boldsymbol v_{n+1}=\boldsymbol v_{n+1/2}+(h/2)M^{-1}F_{n+1},\tag{2.7}\]''',d('velocityVerlet'),kind='definition',context=['Fn=F(qn)=-∇U(qn)，p.65/PDF87；输入第二分量为速度v而非动量p。'])
add('EliminateVelocity','2.2.2',65,[38],'''The derivation of the Störmer form from the velocity Verlet form is straightforward: write down two consecutive steps of (2.5)–(2.7) then eliminate velocities.''',
proposition('velocityVerletStormer_statement',proof='exact MolecularDynamics.Chapter02Review.velocityVerletStormer_proved'),prior=['MolecularDynamics.Chapter02Review.velocityVerletStormer_proved'])
add('MomentumVerlet','2.2.2',65,[39],r'''The most straightforward rewriting of the Verlet method is to put the equations and the discretization in Hamiltonian form, i.e. introducing momenta $\boldsymbol p=M\boldsymbol v$, and thus $\boldsymbol p_n=M\boldsymbol v_n$, which results in the flow map approximation (taking us from any point in phase space $(\boldsymbol q,\boldsymbol p)$ to a new point $(\boldsymbol Q,\boldsymbol P)$):
\[\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p+\frac{h^2}{2}M^{-1}F(\boldsymbol q),\qquad\boldsymbol P=\boldsymbol p+\frac h2[F(\boldsymbol q)+F(\boldsymbol Q)].\tag{2.8}\]''',d('verlet'),kind='definition',context=['p为动量；“Alternatively”后半踢、漂移、半踢与此展开式代数等价。'])
add('Leapfrog','2.2.2',65,[40],r'''Returning to (2.5)–(2.7), write out the formulas for two successive steps ($(\boldsymbol q_{n-1},\boldsymbol v_{n-1})\mapsto(\boldsymbol q_n,\boldsymbol v_n)$ and $(\boldsymbol q_n,\boldsymbol v_n)\mapsto(\boldsymbol q_{n+1},\boldsymbol v_{n+1})$) and note that, from
\[\boldsymbol v_n=\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,\]
one has
\[\boldsymbol v_{n+1/2}=\boldsymbol v_{n-1/2}+hM^{-1}F_n,\qquad\boldsymbol q_{n+1}=\boldsymbol q_n+h\boldsymbol v_{n+1/2}.\]''',d('leapfrog'),kind='definition',context=['第二分量代表交错半步速度v(n-1/2)。'])
add('LeapfrogInit','2.2.2',65,[41],r'''It is necessary to define an initialization procedure for $\boldsymbol v_{-1/2}$:
\[\boldsymbol v_{-1/2}=\boldsymbol v_0-(h/2)M^{-1}F(\boldsymbol q_0).\]''',d('leapfrogInitialize'),kind='definition',context=['q0,v0为实际初值。'])
add('LeapfrogReconstruct','2.2.2',65,[42],r'''And it is also necessary to use, at any subsequent step,
\[\boldsymbol v_n=\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,\]
if $\boldsymbol q_n,\boldsymbol v_n$ are both needed, e.g. for the evaluation of the energy or other velocity-dependent observable.''',d('leapfrogReconstruct'),kind='definition',context=['Fn=F(qn)，第二分量是半步速度。'])

add('ErrorDifference','2.2.3',66,[43],r'''Taking the difference of the numerical and exact solutions, we have
\[\boldsymbol z_{n+1}-\boldsymbol z(t_{n+1})=\mathcal G_h(\boldsymbol z_n)-\mathcal F_h(\boldsymbol z(t_n)).\tag{2.9}\]''',proposition('errorDifference_statement',proof='exact MolecularDynamics.Chapter02Review.errorDifference_proved'),
context=['实际精确节点满足γ((k+1)h)=Fh(γ(kh))；数值节点由G迭代。'],prior=['MolecularDynamics.Chapter02Review.errorDifference_proved'])
add('Consistency','2.2.3','66–67',[44],r'''The first assumption is that $\mathcal G_h$ is an $O(h^{p+1})$ approximation of $\mathcal F_h$ in the sense that there is a constant $K\ge0$ and a constant $\Delta>0$ such that, for $t\in[0,\tau]$, we have
\[\|\mathcal F_h(\boldsymbol z(t))-\mathcal G_h(\boldsymbol z(t))\|\le\bar K h^{p+1},\qquad h<\Delta.\tag{2.10}\]
The assumption (2.10) that the local error is of order $p+1$, $p>0$, is termed the consistency of the numerical method. We say the method is consistent of order $p$.''',
'''def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)''',kind='definition',context=['正文K与展示式Kbar为同一局部误差界常数；δ=Δ，h>0来自本节起点。'])
add('Stability','2.2.3','66–67',[45],r'''To tackle the question of the growth of local error, we still must make an important assumption on $\mathcal G_h$, namely that it satisfies a Lipschitz condition of the form
\[\|\mathcal G_h(\boldsymbol u)-\mathcal G_h(\boldsymbol w)\|\le(1+hL)\|\boldsymbol u-\boldsymbol w\|,\qquad\boldsymbol u,\boldsymbol w\in\mathcal D;\ h\le\Delta.\tag{2.11}\]
The assumption (2.11) that the method does not increase the separation between two nearby trajectories by more than a factor of the form $1+hL$ in each step is referred to as the stability of the method.''',
'''def stability {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u-G h w‖ ≤ (1+h*L)*‖u-w‖''',kind='definition',context=['h>0；D含实际解与假设留域的数值解；后面的除L界可选严格正L。'])
add('ErrorRecursion','2.2.3',67,[46],r'''then take norms and use the triangle inequality and (2.10), (2.11) to get the following recurrent inequality for the error $\epsilon_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|$:
\[\epsilon_{n+1}\le(1+Lh)\epsilon_n+\bar K h^{p+1}.\]''',copied(OC,'oneStep_error_recursion','errorRecursion'),
context=['精确及数值节点都在D是p.66–67/PDF88–89的明确简化假设。'],extra=['精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。'],prior=['MolecularDynamics.oneStep_error_recursion'])
add('ErrorBound','2.2.3',67,[47],r'''From this, the bound
\[\epsilon_n\le\frac{\bar K}{L}e^{Lnh}h^p,\qquad n=0,1,\ldots,\nu,\tag{2.12}\]
follows by a straightforward calculation, for $h\le\Delta$.''',copied(OC,'oneStep_error_bound','errorBound'),
extra=['h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。'],prior=['MolecularDynamics.oneStep_error_bound'])
add('ConsistencyConvergence','2.2.3',67,[48],'''This result shows that a method which is consistent of order $p$ and stable is convergent of order $p$.''',
copied(OC,'oneStep_converges_of_consistency_stability','consistencyConvergence',prove=False),
extra=['τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。'],
verdict='NEEDS_HUMAN',explanation='桥接签名目前只有误差趋零，原文还说of order p；邻项ErrorBound提供节点阶界，但本条还需统一固定窗最大误差阶结论，暂不批准该缩减签名。',missing='把最大误差阶界与趋零合并到同一条完整签名。')
add('ScalarVerlet','2.2.3',67,[49],r'''In this example, assume a single degree of freedom system, i.e. $q,p\in\mathbb R$, and take $M=1$. The Verlet method can be written in the form of a map, as in (2.8), or, in slightly more detail, as
\[Q=q+hp+\frac{h^2}{2}F(q),\tag{2.13}\]
\[P=p+\frac h2\left[F(q)+F(q+hp+\frac{h^2}{2}F(q))\right].\tag{2.14}\]''',
copied('MolecularDynamics/Chapter02/Statements.lean','scalarVerlet','bp_scalarVerlet'),kind='definition',label='Example 2.2 (map)',context=['n=1单位质量；大写Q,P为更新坐标。'])
add('VerletExpansion','2.2.3','67–68',[50],r'''Combining terms of like powers of $h$, we have
\[P=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{4}[F'F+p^2F'']+O(h^4).\]''',proposition('verletExpansion_statement'),
context=[r"$F,F',F''$均在q取值；p.67/PDF89展开F(q+hp+h²F/2)，标量M=1。"],extra=['F C³，使O(h⁴)余项有实际意义。'],missing='实际标量复合力的三阶Taylor余项及代数归一。')
add('ExactExpansion','2.2.3',68,[51],r'''Since $\dot q=p$, we have $\ddot q=\dot p=F(q)$, and the third derivative is $q^{(3)}=F'(q)p$. On the other hand $\dot p=F(q)$ implies that $\ddot p=F'(q)\dot q=pF'$, and thus
\[p^{(3)}=p^2F''+F'F.\]
The Taylor expansion of the solution is (taking $q(t)=q$, $p(t)=p$):
\[q(t+h)=q+hp+\frac{h^2}{2}F+\frac{h^3}{6}F'p+O(h^4),\]
\[p(t+h)=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{6}[p^2F''+F'F]+O(h^4).\]''',proposition('exactExpansion_statement'),
extra=['F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。'],missing='ODE导数升阶与四阶Taylor余项界。')
add('DefectPrinted','2.2.3',68,[52],r'''We now examine the series expansions for the exact and Verlet solutions and find that these differ in the third (and higher) order terms.
\[Q-q(t+h)=\frac{h^3}{6}F'p+O(h^4),\]
and
\[P-p(t+h)=\frac{h^3}{12}[p^2F''+F'F]+O(h^4).\]''',
'''theorem defectPrinted : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
  sorry''',extra=['实际轨迹、F C³；t=0归一。'],issues=issue('位置Q仅到h²，减精确q(t+h)应为负h³F′p/6；原页为正号，保留字面。'),verdict='NEEDS_HUMAN',explanation='位置差符号与紧邻展开相反，忠实记录两个子句且不静默修正。',missing='原书位置差疑误裁定及实际余项理论。')
add('VerletConsistency','2.2.3',68,[53],r'''These relations can be summarized as telling us that
\[\|\mathcal G_h(\boldsymbol z)-\mathcal F_h(\boldsymbol z)\|=\kappa(\boldsymbol z)h^3+O(h^4),\]
where $\kappa(\boldsymbol z)=\kappa(q,p)$ is a function of the position and momentum. We may then define
\[\bar K=\max_{t\in[0,\tau]}\kappa(\boldsymbol z(t))\]
bounding the local error by (with neglect of the fourth order terms) $\bar K h^3$. Thus the Verlet method is consistent of order two.''',proposition('verletConsistency_statement'),
extra=['固定正对角质量、F C³、紧集K、联合连续实际流、正δ；严格O(h³)界需吸收而非忽略h⁴。'],verdict='NEEDS_HUMAN',explanation='现有签名只保留严格一致误差界，原文还给leading κ和max κ；且忽略h⁴不构成严格界。登记待导师，不把缩减签名标PASS。',missing='实际三阶缺陷、κ连续性及统一余项常数。')
add('VerletStability','2.2.3','68–69',[54],r'''To complete the convergence proof for Verlet’s method, we would still need to verify the second assumption. This requires the assumption that the force field $F$ satisfy a Lipschitz condition:
\[\|F(\boldsymbol u)-F(\boldsymbol w)\|\le\hat L\|\boldsymbol u-\boldsymbol w\|\tag{2.15}\]
for all $\boldsymbol u,\boldsymbol w$. Generally speaking this could be taken to hold in a neighborhood of the solution where all approximate solutions for $h<\bar h$ are assumed to lie. With a bit of effort, it is then possible to demonstrate the stability condition for the numerical method (see Exercise 4).''',proposition('verletStability_statement'),extra=['全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。'],missing='实际Verlet映射的1+hC Lipschitz界，可用半踢漂移组合逐坐标界证明。')
add('FirstIntegral','2.2.4',70,[55],r'''Recall that the condition for a given function $I:\mathbb R^m\to\mathbb R$ to be a first integral is that
\[\nabla I(\boldsymbol z)\cdot f(\boldsymbol z)=\sum_{j=1}^m\frac{\partial I}{\partial z_j}(\boldsymbol z)f_j(\boldsymbol z)=0.\]''',d('firstIntegral'),kind='definition',context=['条件在整个开放域D处处成立；I实际可微，f为给定向量场。'])
add('IntegralPreserved','2.2.4',70,[56],r'''It is important in this definition that this is an equivalence that holds everywhere (or at least in some open set in $\mathbb R^m$), so the statement is not just that $I(\boldsymbol z(t))=I(\boldsymbol z(0))$ for some particular trajectory, but, moreover, $I$ is conserved for all nearby initial conditions. The flow map preserves the first integral, thus $I(\mathcal F_t(\boldsymbol z))=I(\boldsymbol z)$.''',
proposition('firstIntegralPreserved_statement'),extra=['开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。'],missing='旧已证定理仅开时间窗；本条需链式法则within及闭区间常值桥接。')
add('EnergyPreserved','2.2.4',70,[57],r'''For example, in a Hamiltonian system, the flow map conserves the energy:
\[H\circ\mathcal F_t=H.\]''',copied('MolecularDynamics/Chapter03/LiePoisson.lean','textbookHamiltonian_energy_const_on_Icc','energyPreserved'),
extra=['实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。'],prior=['MolecularDynamics.textbookHamiltonian_energy_const_on_Icc'])
add('AngularMomentum','2.2.4',71,[58],r'''There may, in specific instances, be additional first integrals present. For example, in a planar 2-body system in central forces, the angular momentum $xp_y-yp_x=l$ is a conserved quantity, thus $l\circ\mathcal F_t=l$.''',proposition('centralAngularMomentum_statement'),extra=['中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。'],missing='两坐标乘积求导抵消及闭时间窗常值；旧第1章库质量接口需匹配。')
add('IntegralMeanValue','2.2.4',71,[59],r'''Now if $I:\mathbb R^m\to\mathbb R$ has continuous partial derivatives, we may conclude directly that
\[I(\boldsymbol a)=I(\boldsymbol b)+\nabla I(\boldsymbol z_*)\cdot(\boldsymbol a-\boldsymbol b),\]
where $\boldsymbol z_*$ is a point on the line in $\mathbb R^m$ connecting $\boldsymbol a$ to $\boldsymbol b$.''',proposition('integralMeanValue_statement'),extra=['开放域含连接线段；C¹，明确z*在线段上；原文全R^m情形自动满足。'],missing='有限维实标量沿线段均值定理。')
add('IntegralLipschitz','2.2.4',71,[60],r'''Hence
\[|I(\boldsymbol a)-I(\boldsymbol b)|\le\|\nabla I(\boldsymbol z_*)\|\|\boldsymbol a-\boldsymbol b\|.\]''',proposition('integralLipschitz_statement'),context=['后句假设∇I在包含解的开放域中有界B；该签名登记统一B版本，点态z*结论由前项承担。'],extra=['域含线段；实际Fréchet导数算子范数界≤B。'],missing='实际均值点与Cauchy–Schwarz/算子范数界。')
add('IntegralErrorPrinted','2.2.4',71,[61],r'''This means if we know that $\|\nabla I(\boldsymbol z)\|$ remains bounded, say less than $B$, in an open domain containing the solution, we could conclude that the error in $I$-values computed along a numerical trajectory is of order $h^p$,
\[|I(\boldsymbol z(t_n))-I(\boldsymbol z_n)|\le\frac{\bar K B}{2L}e^{nLh}h^p,\qquad h<\bar h,\tag{2.16}\]
with the same assumptions as are needed to characterize the convergence of the method.''',proposition('integralErrorPrinted_statement'),
extra=['域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。'],issues=issue('由(2.12)及均值不等式只能得Kbar B/L，额外1/2未推导；常数Kbar若重命名需明确。'),verdict='NEEDS_HUMAN',explanation='保留字面1/(2L)，需裁定原文常数疑误。',missing='原书1/2因子裁定；均值与轨迹误差组合。')
EXCLUDED += [dict(printed_page='60',pdf_page='82',reason='Verlet的物理环境意义与历史介绍为定性说明，excluded_qualitative。'),
 dict(printed_page='65–66',pdf_page='87–88',reason='力评估次数、实现与舍入误差说明归入excluded_qualitative；数学初始化与重构另列。'),
 dict(printed_page='69–71',pdf_page='91–93',reason='图2.4–2.5能量/轨迹误差的数值观察与长时间警示为excluded_qualitative；不冒充普适界。')]

# Complete the source's clauses before approving the signature. These are
# local drafting refinements, not changes to the immutable Chapter 1 delivery.
for r in RECORDS:
    if r['source_id']=='MD-2.2.1-FirstVariation':
        code=proposition('firstVariation_statement')
        code=code.replace(' 0 := by\n  sorry',''' 0 ∧
    Asymptotics.IsBigO (𝓝 0)
      (fun ε : ℝ => action L a b (variation q η ε)-action L a b q-
        ε*(∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)))
      (fun ε : ℝ => ε^2) := by
  sorry''')
        r.update(code=code,local_verdict='PASS',local_explanation='实际作用量一阶变分与O(ε²)余项均保留；紧时间窗下积分内一致余项以作用量余项表达，实际导数及积分未换成任意系数。',
            extra_assumptions=['α<β；L、q、η C²以保证实际导数和紧时间窗余项资格。'])
    if r['source_id']=='MD-2.2.1-EulerLagrange':
        r['code']=proposition('hamiltonPrinciple_statement').replace('stationaryAction L a b q','stationarySmoothAction L a b q')
        r.update(local_verdict='PASS',local_explanation='量词改为原文C∞零端点变分，保留真实作用量及实际Euler–Lagrange方程；C² q覆盖原文至少两次可微资格。',
            extra_assumptions=['α<β，L和q C²；变分按原文C∞且零端点。'],missing='基本变分引理、积分分部及实际作用量的一阶求导。')
    if r['source_id']=='MD-2.2.3-ConsistencyConvergence':
        original=(ROOT/OC).read_text(encoding='utf-8')
        start=original.index('  have hbound :',original.index('theorem oneStep_converges_of_consistency_stability'))
        stop=original.index("  apply squeeze_zero'",start)
        proof='''  constructor
  · exact MolecularDynamics.oneStep_converges_of_consistency_stability G γ D
      (τ := τ) (δ := δ) (L := L) (K := K) (p := p)
      hτ hδ hL hK hp hexact hnum hstable hconsistent
  · have hstep : Tendsto (fun ν : ℕ => τ / (ν : ℝ)) atTop (𝓝 0) :=
      tendsto_const_div_atTop_nhds_zero_nat τ
'''+''.join('  '+line+'\n' for line in original[start:stop].rstrip().splitlines())+'    exact hbound'
        code=copied(OC,'oneStep_converges_of_consistency_stability','consistencyConvergence',prove=False)
        code=code.replace('atTop (𝓝 0) := by\n  sorry','''atTop (𝓝 0) ∧
    ∀ᶠ ν : ℕ in atTop, oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
      ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
'''+proof)
        r.update(code=code,local_verdict='PASS',local_explanation='保留收敛趋零及固定时间窗最大误差阶p两个结论；数值留域是原文明确简化前提；正L避免除零。',
            missing=None,priors=['MolecularDynamics.oneStep_converges_of_consistency_stability','MolecularDynamics.oneStepMaxError_order_bound'])
    if r['source_id']=='MD-2.2.3-VerletConsistency':
        r['code']='''theorem verletConsistency : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
  sorry'''
        r.update(local_verdict='PASS',local_explanation='完整保留κ主项、沿轨迹max κ存在、严格二阶一致性界；不把“忽略h⁴”冒充同一个max常数的严格界。',
            extra_assumptions=['实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。'])
        r['issues']=[dict(code='NEGLECTED_REMAINDER',status='NEEDS_HUMAN',detail='原文忽略O(h⁴)后用maxκ界误差，不是严格界；保留κ主项和严格一致性，常数区分maxκ与吸收余项后的C。')]
    if r['source_id']=='MD-2.2.4-IntegralPreserved':
        r['code']=proposition('firstIntegralPreserved_statement',proof='''intro n I f D γ a b hab hI hD hfirst hγD hγ
  have hd : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => I (γ s)) 0 (Icc a b) t := by
    intro t ht
    have hIt : DifferentiableAt ℝ I (γ t) :=
      (hI (γ t) (hγD ht)).differentiableAt (hD.mem_nhds (hγD ht))
    have hc : HasDerivWithinAt (fun s => I (γ s))
        ((fderiv ℝ I (γ t)) (f (γ t))) (Icc a b) t :=
      hIt.hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
    rw [hfirst (γ t) (hγD ht)] at hc
    exact hc
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)''')
        r.update(missing=None)
    if r['source_id']=='MD-2.2.4-AngularMomentum':
        r['code']=proposition('centralAngularMomentum_statement')
        r.update(missing='短证明3次失败：within导数的tuple投影/Filter接口转换未完成；乘积求导抵消路线及日志已保留。')
    if r['source_id']=='MD-2.2.4-IntegralLipschitz':
        r['code']='''theorem integralPointwiseBound : ∀ n (I : Q n → ℝ) (D : Set (Q n)) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b=(fderiv ℝ I c) (a-b) ∧
      |I a-I b| ≤ ‖fderiv ℝ I c‖*‖a-b‖ := by
  sorry'''
        r.update(lean_decl='MD.Ch02.integralPointwiseBound',local_verdict='PASS',local_explanation='保留原文实际均值点c及点态梯度范数界，未仅替成统一B界。',extra_assumptions=['开放域含连接线段，实际C¹标量I；Fréchet算子范数与梯度对偶范数相同。'])

for r in RECORDS:
    if r['source_id']=='MD-2.2.4-IntegralMeanValue':
        r['code']=proposition('integralMeanValue_statement',proof='''intro n I D a b hD hs hI
  have hd : ∀ x ∈ segment ℝ a b, HasFDerivWithinAt I (fderiv ℝ I x) (segment ℝ a b) x := by
    intro x hx
    exact ((hI.differentiableOn (by norm_num) x (hs hx)).differentiableAt (hD.mem_nhds (hs hx))).hasFDerivAt.hasFDerivWithinAt
  obtain ⟨c,hc,heq⟩ := domain_mvt hd (convex_segment a b)
    (right_mem_segment ℝ a b) (left_mem_segment ℝ a b)
  refine ⟨c, ?_, heq⟩
  rw [segment_symm] at hc
  exact hc''')
        r.update(missing=None)
    if r['source_id']=='MD-2.2.4-IntegralLipschitz':
        r['code']=r['code'].replace('  sorry','''  intro n I D a b hD hs hI
  obtain ⟨c,hc,heq⟩ := integralMeanValue n I D a b hD hs hI
  refine ⟨c,hc,heq,?_⟩
  rw [heq, ← Real.norm_eq_abs]
  exact (fderiv ℝ I c).le_opNorm (a-b)''')
        r.update(missing=None)

# The original gradient inequality uses the Euclidean norm, not Pi's max norm.
for r in RECORDS:
    if r['source_id'] in ('MD-2.2.4-IntegralMeanValue','MD-2.2.4-IntegralLipschitz'):
        r['code']=r['code'].replace('Q n','EuclideanSpace ℝ (Fin n)')
        r['extra_assumptions']=['实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。']
