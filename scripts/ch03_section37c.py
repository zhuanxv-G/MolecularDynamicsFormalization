"""Final §3.7 claims, original PDF157–158, Exercises excluded."""
from ch03_data import add,copied,proposition,D,EXCLUDED
add('CollisionalVerletOrder','3.7.2',135,[140],r'''A step can then be taken to the first point of subsequent collision, with positions updated using the quadratic and momenta adjusted according to the Verlet map combined with $R_c$. In this way, all steps taken are Verlet steps so the order of accuracy is two. Effectively, this is a Verlet method with variable timestep chosen to match collision times.''',proposition('collisionalVerletOrder_statement'),
extra=['正质量、C∞势/接触函数、有限横截隔离事件、最小正接触根；自适应累计真实时间及O(hmax²)单调时间对齐；所有内部接触严格早于hmax，排除伪代码未反射的相等边界。'],
verdict='NEEDS_HUMAN',explanation='原文二阶论断未明示边界和跳跃轨道误差度量；忠实记录额外资格，不能将变步长当固定hmax迭代时钟。',issues=[dict(code='NEEDS_HUMAN',detail='同时间全相空间误差与时间对齐、tc=hmax边界、隔离接触资格需裁定。')],missing='缺自适应碰撞事件定位稳定性与非光滑全局误差理论；不建设大型理论。')
add('PairForceDecoupling','3.7.3',136,[141],r'''This can be achieved in systems of spheres with pair potentials $\varphi_{ij}$ only by writing $\varphi_{ij}=\alpha_{ij}+\beta_{ij}$ where the derivative of the second term is chosen to vanish at the point of contact between the spheres, i.e. $\alpha'_{ij}(\sigma_i+\sigma_j)=0$.''',copied(D,'pairForceDecoupling'),kind='definition',
verdict='NEEDS_HUMAN',explanation='字面公式α′=0保留；second term指β却写α，随后用α生成路径、β作kick，需独立裁定约定。',issues=[dict(code='ERRATUM?',detail='“second term”与α′接触为0不一致；不静默改为β′。')])
add('DecoupledOrder','3.7.3',136,[142],r'''The idea is to exploit the observation that impulsive forces (“kicks”) can be supplied without reducing the order of accuracy as long as these have a vanishing component in the direction of the collision vector $u_\perp$, that is if $F_\perp=-\nabla U(q_c)\cdot u_\perp=0$.
If this decomposition is used, then it is possible to build a 2nd order accurate hybrid method that uses only the first part $\alpha$ to define the quadratic Verlet paths for the collision detection scheme, whereas $\beta$ is introduced as a standard “kick” at collision points.''',proposition('decoupledOrder_statement'),extra=['以U表示真正kick势并要求它在接触法向导数0；另一V用于碰撞子流；正质量、有限横截隔离事件与时间对齐误差。'],
verdict='NEEDS_HUMAN',explanation='保留完整条件化二阶误差；原文α/β职责冲突及方法/误差资格未裁定，不以某个约定假装原文已审。',issues=[dict(code='ERRATUM?',detail='结合PairForceDecoupling，哪个势负责零法向kick需导师判定。')],missing='缺混合冲量与碰撞稳定性全局误差理论；本地非PASS不证明。')
add('ModifiedCollisionProjection','3.7.3',136,[143],r'''In particular, one may use the backward error analysis to obtain a modified Hamiltonian $\widetilde H_h$ corresponding to the Verlet method with stepsize $h$, then to project during collisions not onto the energy surface, but onto the modified energy surface, so that
\[\widetilde H_h=\mathrm{const}.\]
(In practice, a low order approximation of $\widetilde H_h$ is used, such as the truncation to terms of order four or six in the stepsize.)''',copied(D,'modifiedCollisionProjection'),kind='definition',context=['原书实际使用有限截断；关系只要求起点终点有同一截断值，不证明投影存在/唯一、不供应BEA或统计准确。'])
add('FreeHardSphereHamiltonian','3.7.1',133,[],r'''The hard sphere system described by
\[H_{\mathrm{free}}=p^TM^{-1}p/2+U_{\mathrm{h.s.}}\]
consists of purely ballistic (straight line) motion punctuated by momentum jumps.''',
'''def freeHardSphereHamiltonian {N d : ℕ} (m σ : Fin N → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  @ite (WithTop ℝ) (q ∈ MolecularDynamics.Chapter03Review.hardCoreDomain σ)
    (Classical.propDecidable _) ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ) ⊤''',kind='definition',
extra=['正质量下用WithTop ℝ保留有限动能和+∞障碍；沿用p132接触允许的边界，p133≤疑点仍由HardCorePotential保留。'],
context=['位置不接触时自由ODE为q′=M⁻¹p,p′=0；事件复合与真实动量反射在CollisionComposition/CollisionRegularity/ElasticEnergy保留。'])
EXCLUDED += [dict(printed_page='133',pdf_page='155',text='This system is formally integrable, i.e. we may write down its exact solution for any given initial conditions.',reason='这是事件驱动精确计算的算法可用性说明；没有给计算模型、同时碰撞裁决或任意初始条件资格。保留原句供网站审校，不将算法可用性伪装成已证明的全局流存在唯一定理；实际自由Hamiltonian、事件复合和轨道规则在JSON/Blueprint保留。'),dict(printed_page='132–136',pdf_page='154–158',reason='检测/求根/并行成本、长期数值观察及统计性能、文献推荐为定性或实现背景；正文数学定义、误差与接触疑点均保留；p136的Exercises起及后页习题全部排除。')]
