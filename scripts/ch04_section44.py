"""Eight rigid-body setup records, PDF189–190."""
from ch04_data import add,copied,proposition,D,NS
add('WaterPairPotential','4.4',167,[],r'''the interaction of two water molecules, the sets of whose charge sites are denoted by $A$ and $B$, takes the form
\[\varphi_{\rm water}=\sum_{i\in A}\sum_{j\in B}\frac{k_1Q_iQ_j}{r_{ij}}+\frac{k_2}{r_{OO}^{12}}-\frac{k_3}{r_{OO}^{6}},\]
where $r_{OO}$ represents the distance between the oxygen atoms of the two molecules, and $k_1,k_2,k_3$ are positive constants.''',r'''def waterPairPotential {a b : ℕ} (k1 k2 k3 rOO : ℝ) (qa : Fin a → ℝ)
    (qb : Fin b → ℝ) (r : Fin a → Fin b → ℝ) : ℝ :=
  (∑ i, ∑ j, k1*qa i*qb j/r i j)+k2/rOO^12-k3/rOO^6''',kind='definition',extra=['有限电荷位点、所有距离>0与k1,k2,k3>0是物理定义域；不将经验模型当普遍物理定律。'])
add('TotalMass','4.4',167,[79],r'''where $M=\sum_{i=1}^Nm_i$ is the total mass.''',copied(D,'totalMass'),kind='definition')
add('CenterMass','4.4',167,[79],r'''The atomic positions may be referred to a coordinate system placed at the center of mass of the collection $q_{\rm cm}=\frac{\sum_{i=1}^Nm_iq_i}{M}$.''',copied(D,'centerMass'),kind='definition',context=['物理质量正，M>0；三维向量有限和。'])
add('RelativePositions','4.4',167,[79],r'''We write $q_i=q_{\rm cm}+\delta_i$, where $\sum_{i=1}^Nm_i\delta_i=0$.''',copied(D,'relativePositions'),kind='definition',context=['加法关系直接由定义；加权零和另条真实证明。'])
add('RelativeWeightedZero','4.4',167,[],r'''We write $q_i=q_{\rm cm}+\delta_i$, where $\sum_{i=1}^Nm_i\delta_i=0$.''',f'''theorem relativeWeightedZero : ∀ N (m : Fin N → ℝ) (q : Fin N → {NS}V),
    {NS}totalMass m ≠ 0 → (∑ i, m i • {NS}relativePositions m q i)=0 := by
  sorry''',extra=['总质量非零；原物理正质量给此资格，空体系排除。'],missing='待有限和标量分配与质量逆消元短证明。')
add('KineticSplit','4.4',167,[80],r'''Thus the kinetic energy becomes
\[K=\frac12\sum_im_i\|\dot q_{\rm cm}\|^2+\sum_im_i\dot q_{\rm cm}\cdot\dot\delta_i+\frac12\sum_im_i\|\dot\delta_i\|^2
=\frac M2\|\dot q_{\rm cm}\|^2+\frac12\sum_im_i\|\dot\delta_i\|^2,\]
where we have used the fact that $\sum_im_i\delta_i\equiv0$, hence that the time derivative also vanishes, in order to remove the middle term.''',proposition('kineticSplit_statement'),context=['真实有限坐标Euclidean平方；只假设加权相对速度和零，不假设能量分解。'],missing='待有限和双线性展开及零和消元短证明。')
add('SecondMoment','4.4',168,[81],r'''where the fixed matrix $R$ is given by $R=\sum_{i=1}^Nm_i\delta_i(0)\delta_i(0)^T$.''',copied(D,'secondMoment'),kind='definition',context=['真实参照体固定3×3对称二阶矩。'])
add('RotationKinetic','4.4',168,[81],r'''$K_{\rm rot}=\frac12\sum_{i=1}^Nm_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0)$. This expression may be rewritten as $K_{\rm rot}=\frac12\operatorname{Tr}[\dot\Theta R\dot\Theta^T]$.''',copied(D,'rotationKinetic'),kind='definition',context=['保留1/2；有限和到trace的恒等式另列，定义不计该恒等式证明。'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['RelativeWeightedZero','KineticSplit'])
