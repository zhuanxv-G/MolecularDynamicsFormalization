"""First local batch of §3.3; original pages125–127 rendered and checked."""
from ch03_data import add,copied,proposition,D,L
F='MolecularDynamics/Chapter03/FormalOperatorSeries.lean'
add('HamiltonianLieAdditivity','3.3',103,[26],r'''As the relation
\[\mathcal L_H\phi=\{\phi,H\},\]
is linear in $H$, we may write, for Hamiltonians $H_1,H_2$,
\[\mathcal L_{H_1+H_2}=\mathcal L_{H_1}+\mathcal L_{H_2}.\]''',
copied(L,'textbookHamiltonianLieDerivative_add','hamiltonianLieAdditivity'),context=[r'对任意观测量F的算子相等；$\mathcal L_H$记号见p.102/PDF124。'],
extra=['H₁,H₂在z可微；原文smooth资格显式化。'],prior=['MolecularDynamics.textbookHamiltonianLieDerivative_add'])
add('FormalSplitting','3.3',103,[27],r'''The flow map of the system with Hamiltonian $H=H_1+H_2$ is
\[\mathcal F_t=e^{t(\mathcal L_{H_1}+\mathcal L_{H_2})}.\]
On the other hand, the splitting method based on a composition of flows on $H_1$ and $H_2$ is
\[\mathcal G_h=e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}.\]''',
copied(D,'formalSplitting'),kind='definition',context=[r'A,B分别表示$\mathcal L_{H_1},\mathcal L_{H_2}$；形式指数，不能由此假设实际级数收敛。',r'状态映射与观测量pullback组合顺序相反；实际Hamiltonian匹配条目另待审。'])
add('ExactExponentialCubic','3.3',103,[28],r'''Expanding these out using the exponential series we have
\[\begin{aligned}e^{h(A+B)}&=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(A+B)^2+\frac{h^3}{6}(A+B)^3+O(h^4)\\
&=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(AB+BA+A^2+B^2)\\
&\quad+\frac{h^3}{6}(A^3+A^2B+AB^2+ABA+B^2A+BA^2+BAB+B^3)+O(h^4).\end{aligned}\]''',
'''theorem exactExponentialCubic (A B : R) :
    (∀ j < 4, PowerSeries.coeff j (textbookFormalOperatorExponential (A+B)) =
      (1/(j.factorial : ℝ)) • (A+B)^j) ∧
    ((A+B)^2 = A*B+B*A+A^2+B^2) ∧
    ((A+B)^3 = A^3+A^2*B+A*B^2+A*B*A+B^2*A+B*A^2+B*A*B+B^3) := by
  refine ⟨fun j _ => textbookFormalOperatorExponential_coeff (A+B) j, ?_, ?_⟩
  · noncomm_ring
  · noncomm_ring''',context=[r'$R$为任意实结合环代数；不添加AB=BA；$O(h^4)$按形式系数次数≥4解释，不宣称实际范数余项。'],
prior=['MolecularDynamics.textbookFormalOperatorExponential_coeff'])
add('ProductExponentialCubic','3.3',104,[29],r'''whereas,
\[\begin{aligned}e^{hA}e^{hB}&=(\mathrm{Id}+hA+\frac{h^2A^2}{2}+\frac{h^3A^3}{6}+O(h^4))\times(\mathrm{Id}+hB+\frac{h^2B^2}{2}+\frac{h^3B^3}{6}+O(h^4))\\
&=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(2AB+A^2+B^2)+\frac{h^3}{6}(A^3+B^3+3AB^2+3A^2B)+O(h^4).\end{aligned}\]''',
'''theorem productExponentialCubic (A B : R) :
    PowerSeries.coeff 0 (formalSplitting A B)=1 ∧
    PowerSeries.coeff 1 (formalSplitting A B)=A+B ∧
    PowerSeries.coeff 2 (formalSplitting A B)=
      (1/2:ℝ) • A^2+A*B+(1/2:ℝ) • B^2 ∧
    PowerSeries.coeff 3 (formalSplitting A B)=
      (1/6:ℝ) • A^3+(1/2:ℝ) • (A^2*B)+(1/2:ℝ) • (A*B^2)+(1/6:ℝ) • B^3 := by
  exact ⟨textbookFormalOperatorProduct_coeff_zero A B,
    textbookFormalOperatorProduct_coeff_one A B,
    textbookFormalOperatorProduct_coeff_two A B,
    textbookFormalOperatorProduct_coeff_three A B⟩''',context=[r'形式Cauchy乘积；保持AB的次序，两个多项式写法经分配律等价；O(h⁴)为高次系数。'],
prior=['MolecularDynamics.textbookFormalOperatorProduct_coeff_zero','MolecularDynamics.textbookFormalOperatorProduct_coeff_one','MolecularDynamics.textbookFormalOperatorProduct_coeff_two','MolecularDynamics.textbookFormalOperatorProduct_coeff_three'])
add('DifferenceCommutator','3.3',104,[30,32,33],r'''So the difference is
\[e^{hA}e^{hB}-e^{h(A+B)}=\frac{h^2}{2}[A,B]+O(h^3),\]
where $[A,B]=AB-BA$ is the commutator of $A$ and $B$.
For a splitting method, we have, replacing $A$ by $\mathcal L_{H_1}$ and $B$ by $\mathcal L_{H_2}$,
\[e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}-e^{h\mathcal L_H}=\frac{h^2}{2}[\mathcal L_{H_1},\mathcal L_{H_2}]+O(h^3).\]''',
copied(F,'textbookFormalOperatorDifference_coeff_two','differenceCommutator'),
context=[r'$[A,B]=AB-BA$定义合并旧CH03-032；Hamiltonian算子是同一形式代数恒等式的实例；H=H₁+H₂及Lie加法见p.103/PDF125。'],
prior=['MolecularDynamics.textbookFormalOperatorDifference_coeff_two'])
add('DifferenceCubic','3.3',104,[31],r'''\[e^{hA}e^{hB}-e^{h(A+B)}=\frac{h^2}{2}(AB-BA)+\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4).\]''',
copied(F,'textbookFormalOperatorDifference_coeff_three','differenceCubic'),context=[r'同页差值展示式的三次系数；二次系数见DifferenceCommutator，不省略整个差式的另一子句。'],prior=['MolecularDynamics.textbookFormalOperatorDifference_coeff_three'])
add('HamiltonianCommutator','3.3','104–105',[],r'''Observe that, for any real-valued functions $f$ and $H$ of phase space,
\[\mathcal L_Hf=\nabla f^TJ\nabla H=\{f,H\}.\]
Hence $\mathcal L_{H_1}\mathcal L_{H_2}f=\{\{f,H_2\},H_1\}$, and, using this and skew-symmetry of the Poisson bracket,
\[[\mathcal L_{H_1},\mathcal L_{H_2}]f=\{\{f,H_2\},H_1\}-\{\{f,H_1\},H_2\}=\{\{f,H_2\},H_1\}+\{\{H_1,f\},H_2\}.\]
By the Jacobi identity, $\{\{f,H_2\},H_1\}+\{\{H_2,H_1\},f\}+\{\{H_1,f\},H_2\}=0$.
Therefore
\[[\mathcal L_{H_1},\mathcal L_{H_2}]f=-\{\{H_2,H_1\},f\}=\{f,\{H_2,H_1\}\}.\]''',
copied(L,'textbookHamiltonianLieDerivative_commutator','hamiltonianCommutator'),
context=[r'$[A,B]=AB-BA$；$\mathcal L_Hf=\{f,H\}$；本条保留原书第一推导正确的$\{H_2,H_1\}$顺序。'],
extra=['F,H₁,H₂在z为C²；原文smooth资格显式化。'],prior=['MolecularDynamics.textbookHamiltonianLieDerivative_commutator'])
add('HamiltonianCommutatorPrinted','3.3',105,[34],r'''This means that it is possible to relate the commutator of Lie derivatives of Hamiltonian vector fields to the Lie derivative of the Poisson bracket of the corresponding Hamiltonians, i.e.,
\[[\mathcal L_{H_1},\mathcal L_{H_2}]f=\mathcal L_{\{H_1,H_2\}}f.\]''',
proposition('leadingShadowPrinted_statement'),context=[r'本页上一式为$\{f,\{H_2,H_1\}\}$；定义$\mathcal L_Hf=\{f,H\}$及[A,B]=AB−BA。'],
extra=['F,H₁,H₂取C²，原文smooth资格明示。'],verdict='FAIL',
explanation='原页的下一式把{H₂,H₁}改成{H₁,H₂}，与刚推导的式子相差负号；字面错误签名保留sorry，不以正确桥接替换原文。',
issues=[dict(code='ERRATUM?',detail='p.105/PDF127相邻两式的Hamiltonian Poisson括号顺序相反；本条保留印刷{H₁,H₂}。')],
missing='印刷符号疑误待网站/导师裁定；本地FAIL不进入证明。')
