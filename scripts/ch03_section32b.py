"""Second <=8-item batch for printed102/PDF124."""
from ch03_data import add,copied,L
add('PoissonCoordinates','3.2',102,[18],r'''\[\{g_1,g_2\}=\sum_{i=1}^N\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2.\]''',
copied(L,'textbookPoissonBracket_coordinates','poissonCoordinates'),context=[r'$g_1,g_2$为同页smooth scalar-valued函数；实际Fréchet偏导对单位基向量作用。'],prior=['MolecularDynamics.textbookPoissonBracket_coordinates'])
add('PoissonBilinearity','3.2',102,[19],r'''The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
Bilinearity $\{g_1,\alpha g_2+\beta g_3\}=\alpha\{g_1,g_2\}+\beta\{g_1,g_3\}$.''',
'''theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z) := by
  exact ⟨MolecularDynamics.textbookPoissonBracket_linear_right F G H α β z hG hH,
    MolecularDynamics.textbookPoissonBracket_linear_left F H G α β z hF hG⟩''',
context=[r'$\alpha,\beta\in\mathbb R$；Poisson定义见同页；第一变量线性由下一条反对称性推出。'],
extra=['原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。'],
prior=['MolecularDynamics.textbookPoissonBracket_linear_right','MolecularDynamics.textbookPoissonBracket_linear_left'])
add('PoissonSkew','3.2',102,[20],r'''Skew symmetry $\{g_1,g_2\}=-\{g_2,g_1\}$''',
copied(L,'textbookPoissonBracket_skew','poissonSkew'),context=[r'$J$为同页规范辛矩阵；不要求J另有任意自定义参数。'],prior=['MolecularDynamics.textbookPoissonBracket_skew'])
add('PoissonSelf','3.2',102,[21],r'''and this implies $\{g_1,g_1\}=0$.''',
copied(L,'textbookPoissonBracket_self','poissonSelf'),context=[r'由同页Skew symmetry；实数域特征不为2。'],prior=['MolecularDynamics.textbookPoissonBracket_self'])
add('PoissonJacobi','3.2',102,[22],r'''Jacobi identity $\{g_1,\{g_2,g_3\}\}+\{g_3,\{g_1,g_2\}\}+\{g_2,\{g_3,g_1\}\}=0$.''',
copied(L,'textbookPoissonBracket_jacobi','poissonJacobi'),context=[r'同页三个smooth scalar-valued函数；非任意未微分函数。'],
extra=['显式各函数在z为C²；真实二阶导数对称性支持Jacobi。'],prior=['MolecularDynamics.textbookPoissonBracket_jacobi'])
add('HamiltonianObservableDerivative','3.2',102,[23],r'''More generally, if $F(\boldsymbol q,\boldsymbol p)$ is any smooth, scalar-valued function of the phase variables, we may write
\[\dot F=\frac{\mathrm d}{\mathrm dt}F(\boldsymbol q(t),\boldsymbol p(t))=\{F,H\}.\]''',
'''theorem hamiltonianObservableDerivative
    (F H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (t : ℝ) (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) t := by
  exact MolecularDynamics.hasDerivAt_textbookLieDerivative
    (textbookHamiltonianVectorField H) F γ t hF hγ''',
context=[r'$\gamma(t)=(q(t),p(t))$为实际Hamiltonian解。'],extra=['smooth只需在γ(t)可微；ODE真实导数明示。'],prior=['MolecularDynamics.hasDerivAt_textbookLieDerivative'])
add('HamiltonianLie','3.2',102,[24,25],r'''As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:
\[\mathcal L_{J\nabla H}F=\{F,H\}.\]
For a Hamiltonian flow, we typically simplify notation by writing $\mathcal L_H$ in place of $\mathcal L_{J\nabla H}$.''',
copied(L,'textbookLieDerivative_hamiltonian_eq_poisson','hamiltonianLie_eq_poisson'),
context=[r'$\mathcal L_H=\mathcal L_{J\nabla H}$仅记号，旧CH03-025合并于此；实际hamiltonianLie定义亦为此。'],prior=['MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson'])
add('HamiltonianCoordinateDerivative','3.2',102,[],r'''In terms of the Poisson bracket, it is possible to write the differential equation corresponding to a coordinate $q_i$, say, as
\[\dot q_i=\{q_i,H\}.\]''',
'''theorem hamiltonianCoordinateDerivative
    (H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (i : Fin Nc) (t : ℝ)
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => γ u (Sum.inl i))
      (textbookPoissonBracket (fun z => z (Sum.inl i)) H (γ t)) t := by
  exact hamiltonianObservableDerivative (fun z => z (Sum.inl i)) H γ t
    (differentiableAt_pi.mp differentiableAt_id (Sum.inl i)) hγ''',context=[r'$q_i$作为规范相空间上的坐标函数z↦z(Sum.inl i)，不是额外任意观测量。'],
prior=['MolecularDynamics.hasDerivAt_textbookLieDerivative'])
