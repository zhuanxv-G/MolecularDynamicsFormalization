"""Trajectory averages and the explicit double-well obstruction."""
from ch05_data import add,copied,NS,EXCLUDED
D='MolecularDynamics/Chapter05/ReviewDefinitions.lean'
add('TimeAverage','5.4',195,[56],r'''Given an autonomous system of differential equations $\dot z=f(z)$ in $\mathbb R^m$, and a trajectory $\tau=\{z(t)\mid t\in[0,\infty)\}$, let $g=g(z)$ be any smooth scalar valued function of $z$ (an observable) and define (assuming it exists) the infinite time average of $g$ along $\tau$ by
\[\bar g=\lim_{T\to\infty}\frac1T\int_0^T g(z(t))dt.\tag{5.9}\]''',copied(D,'timeAverage'),kind='definition',context=['真实0..T区间积分；T>0及极限存在意义另条，T=0总化值不赋予平均意义。'])
add('HasTimeAverage','5.4',195,[56],r'''define (assuming it exists) the infinite time average of $g$ along $\tau$ by $\bar g=\lim_{T\to\infty}T^{-1}\int_0^Tg(z(t))dt$.''',copied(D,'hasTimeAverage'),kind='definition',context=['真实Tendsto atTop；定义未声称所有轨道或所有可观测量必有极限。'])
add('ConservedAverage','5.4','196–197',[57],r'''Considering any conservative system, we know that the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. More generally, if a given system has a first integral (conserved quantity) $I=I(z)$, different from the energy, which is preserved along trajectories, then the average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.''',copied('MolecularDynamics/Chapter05/ReviewProofs.lean','conservedAverage_proved','conservedAverage'),extra=['[EXTRA]任意真实轨道和已给出的第一积分守恒值；有限T≠0平均等于其值，T→∞结论另条，不把有限式称无限极限已经检查。'],prior=['MolecularDynamics.Chapter05Review.conservedAverage_proved'])
add('ConservedInfiniteAverage','5.4','196–197',[57],r'''the energy itself is a conserved quantity along trajectories, and its average is therefore a function of the initial condition. The average of this conserved quantity (and any other quantity that depends upon it) will be dependent on the choice of initial condition.''',f'''theorem conservedInfiniteAverage {{X : Type*}} (z : ℝ → X) (I : X → ℝ) (r : ℝ → ℝ)
    (hI : ∀ t,I (z t)=I (z 0)) :
  {NS}hasTimeAverage z I (I (z 0)) ∧
    {NS}hasTimeAverage z (r ∘ I) (r (I (z 0))) := by
  sorry''',context=['保留第一积分及任意依赖它的量两个无限平均结论；不只保留有限时间积分。'])
add('DoubleWellEnergy','5.4',196,[],r'''Example 5.3 Consider the double well potential $\phi(q)=(1-q^2)^2$. The energy $H(q,p)=p^2/2+\phi(q)$ will tend to $+\infty$ as $q\to\infty$ or $p\to\infty$, but is obviously bounded below (by zero).''',f'''def doubleWellEnergy (z : {NS}E 2) : ℝ := (z 1)^2/2+(1-(z 0)^2)^2''',kind='definition',label='Example 5.3',context=['真实二维(q,p)标量能量；非负、紧下水平集与能量面分离性质另外保留。'])
add('DoubleWellCoercivity','5.4',196,[],r'''The energy $H(q,p)=p^2/2+(1-q^2)^2$ will tend to $+\infty$ as $q\to\infty$ or $p\to\infty$, but is obviously bounded below (by zero).''',f'''theorem doubleWellCoercivity : (∀ z : {NS}E 2,0 ≤ doubleWellEnergy z) ∧
  ∀ c : ℝ,IsCompact {{z : {NS}E 2 | doubleWellEnergy z ≤ c}} := by
  sorry''',extra=['[EXTRA]以所有真实下水平集的紧性表达有限维能量强制性；不是从数值图升级一般势结论。'],missing='待固定维数Euclidean坐标界、闭集及Heine–Borel短桥。')
add('DoubleWellDisconnected','5.4',196,[],r'''From the graph it is clear that the energy surface $H(q,p)=E$ has more than one component if $0<E<1$.''',f'''theorem doubleWellDisconnected : ∀ c ∈ Ioo (0 : ℝ) 1,
  ¬IsPreconnected ({NS}energySurface doubleWellEnergy c) := by
  sorry''',label='Example 5.3',missing='待显式双侧能量点与连续坐标投影分离短桥，不依赖图像作证明。')
add('DoubleWellBasin','5.4',196,[],r'''If an initial condition is taken from one of the two basins, say with energy $E_0$, then the trajectory through that point will remain forever in the one basin, thus the averages of many quantities, if computed using the trajectory values, would not be a good approximation of the overall average at constant energy $E_0$.''',f'''theorem doubleWellBasin : ∀ (z : ℝ → {NS}E 2) c,
  Continuous z → c ∈ Ioo (0 : ℝ) 1 → (∀ t,doubleWellEnergy (z t)=c) →
  ∀ t,((z 0) 0 > 0 ∧ (z t) 0 > 0) ∨ ((z 0) 0 < 0 ∧ (z t) 0 < 0) := by
  sorry''',extra=['[EXTRA]实际连续且守恒的轨道；保持左右basin全部结论；“许多平均不近似总平均”是定性后果，未编造数值误差界。'],missing='待实际连续坐标的中值定理与q=0能量至少1的短桥。')
