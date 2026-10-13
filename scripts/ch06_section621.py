"""Next section draft; activate only after the §6.1 checked checkpoint is pushed."""
from ch06_data import add,copied,proposition,D,NS,EXCLUDED
add('EnergySupportObstruction','6.2',224,[24],r'''It should be apparent that constant-energy dynamics (designed to sample the microcanonical ensemble with constant energy $E$) will not sample the canonical distribution in the absence of the heat bath: such Newtonian trajectories cannot access regions of the phase space where $H(z)\neq H(z_0)$, where $z_0$ is the initial condition.''',proposition('energyObstruction_statement','energySupportObstruction'),kind='extra_claim',extra=['[EXTRA]实际能量守恒轨道、连续H及另一能量区域有正μ测度；本条是支持障碍，完整积分/时间平均障碍在下一条保留。'],missing='待守恒等式排除其他能量点的短证明。')
add('CanonicalSamplingObstruction','6.2',224,[24],r'''such Newtonian trajectories cannot access regions of the phase space where $H(z)\neq H(z_0)$, where $z_0$ is the initial condition.''',
'''theorem canonicalSamplingObstruction : ∀ {n : ℕ}
    (H : MolecularDynamics.Chapter06Review.V n → ℝ) (energy : ℝ)
    (z : ℝ → MolecularDynamics.Chapter06Review.V n)
    (μ : Measure (MolecularDynamics.Chapter06Review.V n)) [IsProbabilityMeasure μ],
  Continuous H → (∀ t, H (z t) = energy) → 0 < μ {x | H x ≠ energy} →
  ∃ g : MolecularDynamics.Chapter06Review.V n → ℝ, Integrable g μ ∧
    0 < (∫ x, g x ∂μ) ∧
    Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 0) := by
  sorry''',extra=['[EXTRA]目标为真实概率测度、其他能量区域正测度；结论构造实际可积检验函数，其沿轨道时间平均为零而目标平均严格正；不以采样失败为前提。'],missing='待实际能量补集indicator积分及沿轨道恒零的短桥；不建设一般采样收敛理论。')
add('RademacherJumps','6.2.1',225,[25],r'''In the classic model of a random walk the jump takes values $\pm1$ with equal probability.
The increments of the random walk are the differences $\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}$, thus $(X_n)$ is a random process with independent increments.''',copied(D,'rademacherJumps'),kind='definition',extra=['[EXTRA]真实概率空间、独立可测L²跳跃、AE取±1且期望零；这些条件保留公平Rademacher意义，不把二阶有限和结论作假设。'])
add('RandomWalk','6.2.1',225,[25],r'''That is, we have
\[X_{n+1}=X_n+\delta x J_n.\]
We initiate the random walk with $X_0=0$.
The solution $X_n$ of the random walk may be written
\[X_n=\delta x\sum_{k=0}^{n-1}J_k.\]''',copied(D,'randomWalk'),kind='definition',context=['真实n项Finset.range n有限和；递推、初值及独立增量另列，不计为定义自动证明。'])
add('WalkRecurrence','6.2.1',225,[26],r'''A random walk is a discrete stochastic process in which the state $X_n$ at a given instant (defined by the index $n$) is related to the state $X_{n-1}$, at step $n-1$ by an offset that may be viewed as a random variable. That is, we have
\[X_{n+1}=X_n+\delta x J_n.\]''',proposition('walkRecurrence_statement'),missing='待sum_range_succ及ring短证明。')
add('WalkInitial','6.2.1',225,[25],r'''We initiate the random walk with $X_0=0$.''',
'''theorem walkInitial : ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (sample : Ω),
  MolecularDynamics.Chapter06Review.randomWalk J dx 0 sample = 0 := by
  sorry''',missing='待实际空有限和的短证明。')
add('WalkVariance','6.2.1','225–226',[27],r'''hence the variance is
\[\mathbb E X_n^2=\delta x^2\mathbb E\left(\sum_{k=0}^{n-1}J_k\right)^2.\]
Expanding the squared sum we see that there are (i) $n$ squares $J_k^2$ plus (ii) products of the form $J_kJ_l$, $k\neq l$. Clearly the former are always one and the latter have zero expectation, thus
\[\mathbb E X_n^2=n\delta x^2.\]''',proposition('walkVariance_statement'),extra=['[EXTRA]完整真实概率、L²、独立且公平±1跳跃；同时保存零均值与原完整二阶矩，不将和的二阶矩或交叉项零作前提。'],missing='待Mathlib有限独立和二阶矩及Rademacher单位二阶矩短桥；缺项具体保留，不把标量CLT当作该证明。')
add('DiffusiveWalk','6.2.1',226,[28],r'''Let $t_n=n\delta t$, $n=0,1,\ldots,\nu$ and define
\[Y(t_{k+1})=Y(t_k)+\sqrt{\delta t}J_k,\qquad k=0,1,\ldots,\nu-1,\]
where $Y(0)=0$. Effectively we are making the size of the jump $\delta x$ taken at each step of the random walk equal to $\sqrt{\delta t}$.''',copied(D,'diffusiveWalk'),kind='definition',context=['δt>0；Yk是真实随机游走取δx=√δt；连续时间插值另条。'])
EXCLUDED += [dict(printed_page='224–225',pdf_page='245–246',reason='thermostat术语、governor历史、Brown/Perrin历史和图6.3为定性背景；守恒导致采样障碍及随机游走全部数学公式另列。')]
