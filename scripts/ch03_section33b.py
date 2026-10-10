"""Second §3.3 batch: formal matching, BCH and symplectic Euler."""
from ch03_data import add,copied,proposition,D
F='MolecularDynamics/Chapter03/FormalOperatorSeries.lean'
add('LeadingModifiedExponential','3.3',105,[35],r'''An alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:
\[e^{hA}e^{hB}=e^{h(A+B+hR)},\]
for some operator $R$. Expanding out the right hand side gives
\[\begin{aligned}e^{h(A+B+hR)}&=\mathrm{Id}+h(A+B+hR)+\frac{h^2}{2}(A+B+hR)^2+\cdots\\
&=\mathrm{Id}+hA+hB+h^2R+\frac{h^2}{2}(A^2+AB+BA+B^2)+h^3((A+B)R+R(A+B))+\cdots.\end{aligned}\]
Comparing this to our expansion for $e^{hA}e^{hB}$, for agreement to $O(h^2)$, we must have
\[\frac12(2AB+A^2+B^2)-R+\frac12(A^2+AB+BA+B^2)=O(h),\]
or
\[R=AB-\frac12(AB+BA)=\frac12[A,B]+O(h).\]''',
copied(F,'textbookFormalModifiedExponential_matches_product','leadingModifiedExponential',prove=False),
context=[r'实际形式系数匹配只到次数<3；上面印刷比较式及h³交叉项另有疑误，不改动转录。'],
verdict='NEEDS_HUMAN',explanation='真实形式匹配定理支持R₀=[A,B]/2，但原页中间比较式的加号及h³项的1/2遗漏需要独立裁定；本条暂不因局部桥接而记整段PASS。',
issues=[dict(code='ERRATUM?',detail='p.105/PDF127比较式似应为二次系数之差（第二项前负号）；展示h³交叉项似缺1/2。最终R₀式与既有匹配一致。')],
prior=['MolecularDynamics.textbookFormalModifiedExponential_matches_product'])
add('LeadingShadowHamiltonian','3.3',105,[36],r'''and from this it follows that
\[e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}=e^{h\mathcal L_G},\]
where
\[G=H_1+H_2+\frac h2\{H_1,H_2\}+O(h^2).\]''',
proposition('leadingShadowHamiltonian_statement'),
context=[r'$\mathcal L_HF=\{F,H\}$；本页Lie交换子后式疑误已单列；状态Φ_h∘Ψ_h与pullback次序相反。'],
extra=['D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。'],
verdict='NEEDS_HUMAN',explanation='字面Hamiltonian系数保留；原文观测量算子和实际状态映射组合顺序及交换子符号疑误使实际匹配暂待审。',
issues=[dict(code='ERRATUM?',detail='与同页印刷交换子和状态/pullback组合约定一起核对，不能静默换号。')],
missing='缺实际Hamiltonian截断匹配和统一ODE余项；符号/组合约定待审，本地非PASS不证明。')
add('BCH4','3.3',106,[37],r'''Higher order terms can also be worked out, for example,
\[e^Ae^B=\exp\left(A+B+\frac12[A,B]+\frac1{12}([A,[A,B]]-[B,[A,B]])-\frac1{24}[B,[A,[A,B]]]+\cdots\right).\]''',
proposition('bch4_statement'),context=[r'A,B为非交换形式算子；重新插入形式变量h，按formalLog的次数1–4逐系数相等，不主张无限级数收敛。'],
missing='缺非交换formalLog的四阶有限系数计算桥接；完整BCH理论不建设，保留sorry。')
add('BCHHamiltonian','3.3',106,[38],r'''and, using the correspondence between Lie and Poisson brackets,
\[e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}=e^{h\mathcal L_{\widetilde H_h}},\]
where
\[\widetilde H_h=H_1+H_2+\frac h2\{H_1,H_2\}+\frac{h^2}{12}\bigl(\{H_1,\{H_1,H_2\}\}-\{H_2,\{H_1,H_2\}\}\bigr)-\frac{h^3}{24}\{H_2,\{H_1,\{H_1,H_2\}\}\}+\cdots.\]''',
copied(D,'bchHamiltonian3'),kind='definition',context=[r'本定义只保存印刷到h³的有限函数；无穷省略号不作为已证匹配。实际匹配另条，保留印刷符号。'])
add('BCHHamiltonianMatching','3.3',106,[39],r'''We refer to this series as the modified (also perturbed, shadow) Hamiltonian corresponding to the splitting method. The implication of the series is that the numerical method may be viewed as being equivalent to the exact solution of a nearby Hamiltonian system, although we have not addressed the convergence of the expansion.''',
proposition('bchHamiltonianMatching_statement'),context=[r'印刷有限系数见同页BCHHamiltonian；形式级数未讨论收敛。'],
extra=['实际匹配按截断至h³、端点误差O(h⁵)表达；D开放、K紧、光滑Hamiltonian与真实局部流明示。'],
verdict='NEEDS_HUMAN',explanation='实际状态组合Φ_h∘Ψ_h与印刷Lie算子次序需审；严格有限匹配比原文形式意义更强，标EXTRA并保留完整存在结论。',
issues=[dict(code='NEEDS_HUMAN',detail='需确定原书组合顺序和有限截断的实际余项阶；未把匹配结论当假设。')],missing='缺高阶Hamiltonian/ODE端点余项；非PASS不证明。')
add('CommutingFlows','3.3',106,[40],r'''If $H_1$ and $H_2$ Poisson-commute, i.e.
\[\{H_1,H_2\}=0,\]
then there is no error in splitting.''',proposition('commutingFlows_statement'),
context=[r'同页固定Hamiltonians及对应真实局部流；不假设两个流本身已相等。'],
extra=['光滑Hamiltonian、开放域及三个真实局部流；|h|<η/2保证复合时间在所给流的定义区间。'],
missing='缺实际Hamiltonian向量场交换子到局部流交换及和场流的桥接；不搭完整交换流理论。')
add('SymplecticEulerShadow','3.3.1',106,[41],r'''Splitting our Hamiltonian using $H_1=T(\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2$ and $H_2=U(\boldsymbol q)$ gives the symplectic Euler method. The BCH expansion gives the perturbed Hamiltonian
\[\widetilde H_h=H-\frac h2\boldsymbol p^TM^{-1}\nabla U(\boldsymbol q)+\frac{h^2}{12}\bigl(\boldsymbol p^TM^{-1}U''(\boldsymbol q)M^{-1}\boldsymbol p+\nabla U(\boldsymbol q)^TM^{-1}\nabla U(\boldsymbol q)\bigr)-\frac{h^3}{12}\nabla U(\boldsymbol q)^TM^{-1}U''(\boldsymbol q)M^{-1}\boldsymbol p+O(h^4).\]''',
copied(D,'symplecticEulerShadow3'),kind='definition',context=[r'真实梯度与Hessian作用；本条只存有限函数，匹配另条。'],extra=['M取固定对角质量矩阵，与第1章机械模型一致；不包括任意非对角M。'])
add('SymplecticEulerShadowMatching','3.3.1',106,[42],r'''The BCH expansion gives the perturbed Hamiltonian''',
proposition('symplecticEulerShadowMatching_statement'),context=[r'同页展示式逐字保存在SymplecticEulerShadow；数值symplectic Euler采用第2章坐标约定。'],
extra=['正对角质量、U全域C∞、紧初值集B；截断h³的实际局部流端点O(h⁵)为额外严格化。'],
verdict='NEEDS_HUMAN',explanation='h³截断只通常支持局部O(h⁵)，完整匹配和状态/算子次序需要独立审校；保留完整签名但不提前证明。',
issues=[dict(code='NEEDS_HUMAN',detail='原文只写Hamiltonian O(h⁴)，实际端点O(h⁵)解释与数值坐标顺序待审。')],missing='缺完整BCH机械系数与实际截断ODE匹配；本地非PASS不证明。')
