"""Verlet and Strang: original PDF129–130, printed107–108."""
from ch03_data import add,copied,proposition,D,EXCLUDED
add('VerletMaps','3.3.2',107,[43],r'''Recall the position and velocity Verlet methods:
\[\begin{array}{ll}\text{Position Verlet:}&\text{Velocity Verlet:}\\
\widehat Q:=q+(h/2)M^{-1}p,&\widehat P:=p-(h/2)\nabla U(q),\\
P:=p-h\nabla U(\widehat Q),&Q:=q+hM^{-1}\widehat P,\\
Q:=\widehat Q+(h/2)M^{-1}P.&P:=\widehat P-(h/2)\nabla U(Q).\end{array}\tag{3.3}\]''',
'''def verletMaps {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    (SymplecticCoordinates n → SymplecticCoordinates n) ×
      (SymplecticCoordinates n → SymplecticCoordinates n) :=
  (positionVerlet m (textbookPotentialForce U) h,
    coordinateVerlet m (textbookPotentialForce U) h)''',kind='definition',label='(3.3)',
context=[r'第一分量为position/drift-kick-drift；第二分量velocity/kick-drift-kick。真实F=−grad U。'],extra=['固定对角质量M，保持第1章对象；无非对角质量一般化。'])
add('VerletHamiltonianParts','3.3.2',107,[44],r'''We can think of the velocity Verlet method as being defined by a splitting into three parts:
\[H(q,p)=H_1+H_2+H_3,\qquad H_1=\frac12U(q),\qquad H_2=\frac12p^TM^{-1}p,\qquad H_3=\frac12U(q).\]''',
copied(D,'verletHamiltonianParts'),kind='definition',context=[r'T=½pᵀM⁻¹p；三部分按U/2,T,U/2顺序，不交换。'])
add('VerletStructure','3.3.2',107,[45],r'''This is a sequence of two types of operations: it consists of a “kick” exhibited by a jump in the momentum, linear “drift” with the resulting momentum, followed by a final kick. The symmetry of the method is one of its important features. Switching the order of the operations, i.e. drift-kick-drift, gives the position Verlet method.''',
proposition('verletVariants_statement','verletStructure','exact MolecularDynamics.Chapter03Review.verletVariants_proved'),
context=[r'原文对称关系结合第2章辛kick/drift性质；位置及速度Verlet实际映射见同页(3.3)。'],
extra=['U全域C²以保障真实梯度kick为辛映射；原文光滑Hamiltonian假设显式化。'],
explanation='保留两种Verlet的反步复合恒等式及辛结构；辛结构由前章kick/drift性质和此处真实复合继承，不假设待证对称性。',
prior=['MolecularDynamics.Chapter03Review.verletVariants_proved'])
add('VerletModifiedHamiltonian','3.3.2',107,[46],r'''In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH Lemma gives
\[\begin{aligned}\widetilde H_h={}&T+U+\frac{h^2}{12}\left(\{T,\{T,U\}\}-\frac12\{U,\{U,T\}\}\right)\\
&+\frac{h^4}{120}\left(-\frac16\{T,\{T,\{T,\{T,U\}\}\}\}+\frac13\{U,\{T,\{T,\{T,U\}\}\}\}-\frac14\{U,\{U,\{T,\{T,U\}\}\}\}+\{T,\{T,\{U,\{U,T\}\}\}\}\right)+O(h^6).\end{aligned}\]''',
copied(D,'verletModifiedH'),kind='definition',context=[r'只定义到h⁴的印刷有限函数；h²/h⁴系数实际匹配另条；一般T,U暂未假定机械T。'])
add('VerletModifiedMatching','3.3.2',107,[47],r'''In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH Lemma gives''',
proposition('verletModifiedHPrinted_statement','verletModifiedMatching'),
context=[r'完整印刷h²,h⁴展开见同页VerletModifiedHamiltonian；本条不静默换成另一种Verlet或改h²系数。'],
extra=['正对角质量、U全域C∞、紧初值B；完整印刷h⁴截断实际O(h⁶)端点匹配为额外严格化。'],
verdict='NEEDS_HUMAN',explanation='印刷h²系数对应哪个Verlet和状态/pullback次序需要核对；完整印刷有限函数的匹配存在结论保留，未用较弱h²另一签名替代。',
issues=[dict(code='NEEDS_HUMAN',detail='与速度/位置Verlet的组合次序共同核对h²,h⁴系数；原文Hamiltonian O(h⁶)与实际匹配阶也需裁定。')],
missing='缺完整BCH嵌套Poisson系数推导及实际流余项；非PASS不证明。')
add('ModifiedEven','3.3.2','107–108',[48],r'''The extra power of $h$ in the leading perturbation reflects the fact that this method is 2nd order accurate, rather than first order, as Symplectic Euler. Note that only even order terms $(h^2,h^4,\ldots)$ appear in the perturbative expansion; this is a consequence of the symmetry of the method.
Setting $s=-t$, the left hand side of (3.4) collapses to the identity. Hence the surviving even-powered terms in the expansion on the right hand side of (3.5) must be zero. If the even order terms vanish, then the effect of composing linear operators symmetrically is to keep only odd order terms in the exponent, giving the symmetric BCH formula
\[\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(t(X+Y)+t^3\widehat Z_{[3]}+\cdots).\tag{3.6}\]''',
proposition('modifiedEven_statement'),context=[r'formalLog奇次⇔除以形式变量h后的modifiedHamiltonian为偶次；原文证明中使用不同步长log交换的额外断言另列ERRATUM，结论不靠该假设。'],
missing='缺形式反步恒等式→formalLog奇性的完整桥接；不建设大型非交换formalLog理论。')
add('Strang','3.3.2',108,[49],r'''For Hamiltonians $X$ and $Y$, consider symmetrizing a composition of exponentials (a Strang splitting), such that
\[\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(tZ_t)=\exp(t(\widehat Z_{[1]}+t^2\widehat Z_{[2]}+t^3\widehat Z_{[3]}+t^4\widehat Z_{[4]}+\cdots)).\]''',
copied(D,'formalStrang'),kind='definition',context=[r'本定义为左端真实形式乘积；右端展开的索引可能有排印疑误（t²Z₂应结合后面t³Z₃及log定义审校），不假设log系数交换。'],
issues=[dict(code='ERRATUM?',detail='p.108/PDF130第一展开把Z_[2]配t²、Z_[3]配t³，而下一展开(3.5)按总指数幂2、3排列；保留原页不静默纠正索引。')])
add('DifferentLogsCommute','3.3.2',108,[50],r'''Multiplying by the same expansion using a different time step $s$, we have
\[\exp(\tfrac s2X)\exp(sY)\exp(\tfrac s2X)\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(sZ_s)\exp(tZ_t).\tag{3.4}\]
But we know that $Z_s$ commutes with $Z_t$, giving
\[\begin{aligned}\exp(sZ_s)\exp(tZ_t)&=\exp(sZ_s+tZ_t)\\
&=\exp((s+t)\widehat Z_{[1]}+(s^2+t^2)\widehat Z_{[2]}+(s^3+t^3)\widehat Z_{[3]}+(s^4+t^4)\widehat Z_{[4]}+\cdots).\end{aligned}\tag{3.5}\]''',
proposition('differentLogsCommute_statement'),label='(3.4)–(3.5)',
context=[r'formalLog(Strang(sA,sB))=sZ_s；对非零s,t其交换等价；零步长形式log为0。'],
verdict='NEEDS_HUMAN',explanation='一般不同步长修正生成元没有自动交换的依据；字面全称断言保留，不用它证明正确奇性。',
issues=[dict(code='ERRATUM?',detail='p.108/PDF130 “Z_s commutes with Z_t” 对一般非交换X,Y可疑；应由反步关系单独推导奇性。')],missing='印刷不同步长交换断言待独立反例/导师裁定；非PASS不证明。')
EXCLUDED += [dict(printed_page='108',pdf_page='130',reason='更多对称二阶变体及Verlet金标准/力评估成本为定性设计与实现背景，excluded_qualitative。')]
