"""Final §3.5 entries from PDF146–149."""
from ch03_data import add,copied,proposition,D,EXCLUDED
add('ProjectionEnergy','3.5',124,[98],r'''We also must assume that $E-\overline U\ge0$, which, for a large system, seems the likely situation, since we may suppose $\overline K+\overline U=\overline E\approx E$, thus $E-\overline U\approx\overline K\ge0$. Thus we assume a system with many degrees of freedom so that all the conditions for the method to be well defined are satisfied.''',proposition('projectionEnergy_statement',proof='exact MolecularDynamics.Chapter03Review.projectionEnergy_proved'),
context=['(3.12)/(3.13)给γ²K+U=E，实际数学资格直接取K>0、U≤E；many degrees of freedom只为经验动机，不能推出此资格。'],extra=['K>0且U≤E显式给出，禁止由自由度数目推算。'],prior=['MolecularDynamics.Chapter03Review.projectionEnergy_proved'])
add('KineticZero','3.5',124,[99],r'''If, in the harmonic oscillator, $\overline p_{n+1}$ happens to vanish, then $\gamma$ is not defined. We could work around this obstacle by assuming a large number of degrees of freedom, in which case $\overline K$ is only zero if all the momenta simultaneously vanish and this situation is, in a realistic model of a molecule, extremely unlikely.''',proposition('kineticZero_statement',proof='exact MolecularDynamics.Chapter03Review.kineticZero_proved'),
context=['只形式化正质量下K=0 iff p=0；概率extremely unlikely为定性评述，未当普遍数学断言。Lean全除法不代表物理γ定义可用。'],extra=['正质量。'],prior=['MolecularDynamics.Chapter03Review.kineticZero_proved'])
add('EnergyProjectionRelation','3.5',124,[100],r'''There are many alternative projection methods which we could use for this purpose, which might alter both the positions and momenta. Modifying the positions means that we will somehow need to solve the equation
\[H(Q,P)=E,\]
where $Q$ depends on a parameter or parameters (typically a Lagrange multiplier that is used to maintain the constraint).''',copied(D,'energyProjectionRelation'),kind='definition',context=['真实能量水平关系；不由定义保证投影解存在、唯一或保几何结构。'])
add('NoHamiltonianAttractor','3.5',126,[101],r'''In the first phase, the discrete trajectory appears to be filling in the correct region and without any evidence of nonphysical behavior. The performance is very similar to a Verlet method without projection during this period. In the second phase the system begins to move toward a limit cycle, i.e. an attractive periodic orbit. The presence of such limit cycles is impossible in a Hamiltonian system, thus it is evident that an nonphysical artefact has been introduced by the projection method.''',proposition('noHamiltonianAttractor_statement'),
extra=['明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。'],
missing='缺实际流体积保持到开放盆不可能吸引零体积轨道的动力系统测度论桥接；不建设大型吸引子理论。')
EXCLUDED += [dict(printed_page='122–127',pdf_page='144–149',reason='舍入误差、投影实现代价/概率、投影LJ和双弹簧数值实验、Fig3.10–3.14及性能判断为定性或经验观测；数学投影关系和Hamiltonian无吸引子断言已单列。')]
add('LinearContinuousIntegral','3.5',123,[],r'''Generalizing this slightly, we could imagine a system of ODEs of the form
\[\dot{\boldsymbol z}=f(\boldsymbol z),\]
such that, for some vector $\boldsymbol b$,
\[\boldsymbol b\cdot f(\boldsymbol z)\equiv0,\]
then $I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z$ is a first integral.''',
'''theorem linearContinuousIntegral :
    ∀ (n : ℕ) (b : Fin n → ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
      (∀ z, ∑ i, b i*f z i = 0) →
      (∀ t, HasDerivAt γ (f (γ t)) t) →
      ∀ t, (∑ i, b i*γ t i) = ∑ i, b i*γ 0 i := by
  sorry''',extra=['真实全时间轨道导数资格显式；不宣称任意f有全时间解。'],context=['完整连续轨道first-integral性质；有限Euler及RK保持性质是相邻独立条目。'],missing='待有限和导数为0及常函数短证明。')
from blueprint_source import apply_saved_routes
from ch03_data import RECORDS
apply_saved_routes(3,RECORDS,['LinearContinuousIntegral'])
