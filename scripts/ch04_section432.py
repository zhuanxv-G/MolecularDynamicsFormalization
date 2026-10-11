"""Eight projected-Euler/Newton records from PDF178–179."""
from ch04_data import add,copied,proposition,D
add('PositionEulerPrinted','4.3.2',156,[48],r'''A simple example of such a method is the constrained Symplectic Euler-like method
\[q_{n+1}=q_n+hM^{-1}p_{n+1},\tag{4.14}\]
\[p_{n+1}=p_n-hF_n-hg'(q_n)^T\lambda_n,\tag{4.15}\]
\[0=g(q_{n+1}).\tag{4.16}\]''',copied(D,'positionEulerRelation','positionEulerPrinted').replace('z.2+h • F z.1','z.2-h • F z.1'),kind='definition',label='(4.14)–(4.16)',verdict='NEEDS_HUMAN',explanation='保留印刷−hFn；p163写+hF(q)，若F一直是−grad U则本页负号冲突。物理力符号统一版另列，未静默修复原式。',issues=[dict(code='ERRATUM?',detail='印刷Fn负号与后文F=−grad U/+hF用法的约定需裁定。')])
add('PositionEulerForceConvention','4.3.2',156,[],r'''A simple example of such a method is the constrained Symplectic Euler-like method''',copied(D,'positionEulerRelation'),kind='definition',extra=['[EXTRA]采用F=−grad U的统一力版本，动量+hF；字面−hFn原式仍保留在相邻条。'])
add('HiddenEulerError','4.3.2',156,[49],r'''The hidden constraint $g'(q_0)M^{-1}p_0=0$ will be violated, but one hopes it remains approximately satisfied. The justification for the latter assumption is that if we expand $g$ in a Taylor series, we may write
\[g(q_n)\approx g(q_{n+1})+g'(q_{n+1})(q_n-q_{n+1}).\]
Then since we maintain $g(q_n)=0$ for all $n$, we have
\[g'(q_{n+1})M^{-1}p_{n+1}\approx0.\]''',proposition('hiddenEulerError_statement'),extra=['C²约束与C²实际出点小步分支，out0=z，初位置合法；将approx0定量化为小正h的一致O(h)，不把隐藏误差作前提。'],missing='缺约束Taylor一致二次余项、真实光滑分支与h除法后O(h)估计桥接；不构造大型隐式分支误差理论。')
add('ProjectionResidual','4.3.2',156,[50],r'''To solve the Eqs. (4.14)–(4.16), insert the second in the first and the first then in the third to obtain the simplified equation
\[g(Q_n-M^{-1}G_n^T\Lambda)=0,\tag{4.17}\]
where
\[Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n,\qquad G_n=g'(q_n),\qquad\Lambda=h^2\lambda_n.\]''',copied(D,'projectionResidual'),kind='definition',label='(4.17)',context=['q为旧位置，base为所给Qn，η=Λ；关系只定义残差，不宣称非线性根存在。Fn符号原式已单列，不用一个任意base假装完成动量消元证明。'])
add('ProjectionJacobian','4.3.2',157,[],r'''$R^{(l)}\Delta\Lambda^{(l)}=g(Q^{(l)}),\qquad R^{(l)}\stackrel{\mathrm{def}}=g'(Q^{(l)})M^{-1}G_n^T$,''',copied(D,'projectionJacobian'),kind='definition',context=['R是负的残差Jacobian（Q=base−M⁻¹Gᵀη）；保留原Newton加号，不误称R=+Dη残差。'])
add('NewtonConstraint','4.3.2',157,[51],r'''The simplest is Gauss-Newton iteration, which may be written
\[\Lambda^{(l+1)}=\Lambda^{(l)}+[g'(Q^{(l)})M^{-1}G_n^T]^{-1}g(Q^{(l)}),\tag{4.18}\]
\[Q^{(l)}:=Q_n-M^{-1}G_n^T\Lambda^{(l)},\tag{4.19}\]
which might be initialized with $\Lambda^{(0)}=0$.''',copied(D,'newtonConstraint'),kind='definition',label='(4.18)–(4.19)',context=['实际交叉Gram逆及残差，矩阵非奇异时才是合法求解步；初始化η0=0。'])
add('FrozenNewtonConstraint','4.3.2',157,[],r'''we may be able to fix $R$ at the beginning of the timestep, factor it once only, and then solve at each iteration with the same factors. Moreover, in case we have chosen $\Lambda^{(0)}=0$, we have
\[R^{(0)}=G_nM^{-1}G_n^T,\]
which is a symmetric matrix,''',copied(D,'frozenNewtonConstraint'),kind='definition',context=['固定η0=0处的R作为每步矩阵；但Q(0)=base，不无条件等G(q)M⁻¹G(q)ᵀ；原文所写初始Gram等式另列疑点。'],issues=[dict(code='ERRATUM?',detail='R(0)=g′(Qn)M⁻¹Gnᵀ，一般不是GnM⁻¹Gnᵀ；只有Qn=qn或冻结Jacobian到旧位置时相同。')],verdict='NEEDS_HUMAN',explanation='定义保留固定实际R(0)版本；原初始Gram和对称性不能当一般已证。')
add('NewtonQuadratic','4.3.2',157,[52],r'''When the solution is unique, the constraints sufficiently smooth, and the determinant of $R$ is bounded well away from zero, Newton’s method has a very rapid asymptotic convergence property. It is possible to show that, if $\Lambda_*$ is the solution of (4.17), then sufficiently near the zero we have
\[\|\Lambda^{(l+1)}-\Lambda_*\|\le C\|\Lambda^{(l)}-\Lambda_*\|^2.\]''',proposition('newtonQuadratic_statement'),extra=['局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。'],missing='缺有限维一般Newton逆Jacobian正则性与统一二次误差定理；不新建完整一般Newton收敛理论。')
