"""Prepared extra claims for subsection 4.3.2."""
from ch04_data import add,copied,proposition,D,NS
add('FrozenNewtonLinear','4.3.2',157,[53],r'''When $R$ is evaluated only once per step, the asymptotic convergence of Newton’s method is linear, i.e. we have instead
\[\|\Lambda^{(l+1)}-\Lambda_*\|\le\widetilde C\|\Lambda^{(l)}-\Lambda_*\|,\]
sufficiently near to the solution.''',proposition('frozenNewtonLinear_statement'),extra=['[EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。'],missing='缺交叉Gram逆的实际Fréchet正则性和局部收缩统一范数界；不建完整一般Newton理论。')
add('ProjectionScale','4.3.2',158,[54],r'''It is worth noting that $\Lambda(h)=O(h^2)$, i.e. for small steps $\Lambda$ will also be small. This justifies the initial guess $\Lambda^{(0)}=0$.''',proposition('projectionScale_statement'),extra=['给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。'],missing='缺隐式残差的η′(0)=0链式推导和真实C²小步分支Taylor一致余项桥接；不构造大型分支存在理论。')
add('FrozenGramPrinted','4.3.2',157,[],r'''Moreover, in case we have chosen $\Lambda^{(0)}=0$, we have
\[R^{(0)}=G_nM^{-1}G_n^T,\]
which is a symmetric matrix,''',
f'''theorem frozenGramPrinted :
    ∀ n l (m : Fin n → ℝ) (g : Fin l → {NS}Q n → ℝ) (q base : {NS}Q n),
      {NS}projectionJacobian m g q base 0 = textbookConstraintGram m g q := by
  sorry''',verdict='FAIL',explanation='n=l=1,m=1,g(q)=q²−1,q=1,base=2：g′(base)=4,g′(q)=2，实际R(0)=8而旧点Gram=4。η0=0并不使Q0=qn；若另冻结Jacobian到qn才得到所写对称Gram。',issues=[dict(code='ERRATUM?',detail='R(0)仍是新预测点与旧点的交叉Gram，原等式一般不成立。')],missing='本地FAIL不证明，待原始/冻结版本约定裁定。')
