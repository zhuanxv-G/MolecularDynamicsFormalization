"""Eight entries §3.6.2–3, original PDF152–154."""
from ch03_data import add,copied,proposition,D
add('PartitionedAffine','3.6.2',130,[],r'''All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.''',proposition('partitionedAffine_statement'),
extra=['[EXTRA]正确限定为保持q,p分区的连续线性等价Lq,Lp；不同分区表格不要求混合线性等变。'],context=['这是原文PRK的严格条件化分块版本；字面全称单独保留，未替代它。'],missing='待有限和线性运输短证明。')
add('SymplecticNotReversible','3.6.3',131,[117],r'''A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).''',proposition('symplecticNotReversible_statement'),
context=['本条保留单位质量谐振子Symplectic Euler相对于机械R的反例；辛性已有第2章SymplecticEuler证明；trapezoidal相邻条目单列。'],missing='待单位振子h=1数值反例；需明确Jacobian/梯度坐标展开，不改正式库。')
add('TrapezoidalRelation','3.6.3',131,[118],r'''A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).''',copied(D,'trapezoidalRelation'),kind='definition',
context=['原页只举Trapezoidal Rule名称，没有印出更新式；[EXTRA]补标准定义Z=z+h(f(z)+f(Z))/2作为后条对象，非本页逐字新增公式。'],extra=['补梯形法标准隐式关系作为审阅上下文。'])
add('TrapezoidalProperties','3.6.3',131,[119],r'''A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).''',proposition('trapezoidalProperties_statement'),
context=['本条保留梯形关系在正确反转下可逆及一个真实Hamiltonian非辛步解反例；Symplectic Euler相邻反例单列。'],extra=['完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。'],missing='缺非线性梯形实际解族和非辛Jacobian反例桥接；不建设一般隐式法理论。')
add('HamiltonianSpectrum','3.6.3',131,[120],r'''For example, consider a linear Hamiltonian system $\mathrm dz/\mathrm dt=JAz$, with $A$ a symmetric matrix. If $\lambda$ is an eigenvalue of $JA$ then $JAu=\lambda u$ for some eigenvector $u\ne0$. Because the matrix $JA$ is real, we know that $\overline\lambda$ will also be an eigenvalue. At the same time, we know that since $\lambda$ is an eigenvalue of $JA$ it is also an eigenvalue of its transpose $(JA)^T=A^TJ^T=-AJ$, thus
\[-AJu=\lambda u\]
multiplying by $J$ and setting $v=Ju$ we have
\[-JAv=\lambda v\]
implying that $-\lambda$ (and hence also $-\overline\lambda$) is an eigenvalue of $JA$. Real eigenvalues of $JA$ are paired with their negatives. If the imaginary part is nonzero, the eigenvalues occur in quadruplets $\{\pm\lambda,\pm\overline\lambda\}$.''',proposition('hamiltonianSpectrum_statement'),
verdict='NEEDS_HUMAN',explanation='谱结论保留真实复特征值；原证明把原矩阵同一个u当成转置特征向量，不能照抄为有效证明；纯虚时quadruplets可退化。',issues=[dict(code='ERRATUM?',detail='同一u一般不是转置特征向量；四元素集合可重复，不声称总有4个互异值。')],missing='缺Hamiltonian矩阵复谱及转置相似性桥接；字面证明需审，不证明非PASS。')
add('SymplecticSpectrum','3.6.3',131,[121],r'''The flow map is
\[\mathcal F_t(z)=\mathrm e^{tJA}z\]
and the exponential matrix will inherit a related structure within the spectrum: $\lambda$ an eigenvalue of $\exp(tJA)$ implies that $\overline\lambda$, $1/\lambda$ and $1/\overline\lambda$ are all eigenvalues of $\exp(tJA)$. This eigenvalue structure is generic for linear symplectic maps in general.''',proposition('symplecticSpectrum_statement'),
context=['原文一般线性辛矩阵的谱结论直接表达；指数流实例来自线性流为辛的性质；ζ≠0明确，不假设逆谱。'],missing='缺辛矩阵非退化、逆转置相似及复谱桥接；不建设新的完整谱理论。')
add('ReversibleSpectrum','3.6.3',131,[122],r'''Suppose now we have a linear time-reversible map $\phi(z)=Tz$, then
\[T^{-1}=RTR.\]
Given an eigenvalue, eigenvector pair $(\lambda,u)$ of $T$, let $u=Rv$, so that $Ru=R^2v=v$, then
\[T^{-1}v=RTRv=RTu=\lambda Ru=\lambda v.\]
Thus $\lambda$ is an eigenvalue of $T^{-1}$ which, in turn, implies that $1/\lambda$ is an eigenvalue of $T$. The matrix being real implies that the conjugates of $\lambda$ and $1/\lambda$ are also eigenvalues, thus we have the same eigenvalue quadruplets as for a linear symplectic map.''',proposition('reversibleSpectrum_statement'),extra=['T可逆、R²=I明确；真实complexEigenvalue，非零性作为结论。'],missing='缺有限矩阵可逆相似和共轭复特征向量运输桥接；不建设完整谱理论。')
add('ConjugateIterates','3.6.3','131–132',[123],r'''Recall that a pair of maps $\Phi$ and $\Psi$ are said to be conjugate if there is a homomorphism $\chi$ such that
\[\Phi=\chi^{-1}\Psi\chi.\]
In such a case the iterates of the two maps will also be conjugate''',copied('MolecularDynamics/Chapter02/ProcessedMethods.lean','textbook_conjugate_iterates','conjugateIterates'),
extra=['χ明确为equivalence，以使原文χ⁻¹有定义；原文homomorphism的用词待审。'],context=['数值effective order的附加断言另列ConjugateOrderPrinted，不靠有限共轭恒等式声称已证。'],prior=['MolecularDynamics.textbook_conjugate_iterates'],issues=[dict(code='ERRATUM?',detail='原文homomorphism至少需可逆；连续渐近运输还需homeomorphism。')])
from blueprint_source import apply_saved_routes
from ch03_data import RECORDS
apply_saved_routes(3,RECORDS,['PartitionedAffine','SymplecticNotReversible'])
