"""Printed 100–102, PDF122–124, visually checked original-page transcription."""
from ch03_data import add,copied,proposition,D,L
F='MolecularDynamics/Chapter03/FormalOperatorSeries.lean'
add('LieDerivative','3.2',100,[10],r'''The right hand side suggests a shorthand notation. If we define the Lie derivative $\mathcal L_f$ by
\[\mathcal L_f\phi=f\cdot\nabla\phi,\]''',copied(L,'textbookLieDerivative'),kind='definition',
context=[r'Let $\phi(\boldsymbol z)$ be an arbitrary smooth, scalar-valued function of the phase variables (assumed to lie in $\mathbb R^m$). $f$为ODE向量场；Fréchet导数对f的作用等于坐标点积。'])
add('ObservableDerivative','3.2','100–101',[11],r'''At any point $\boldsymbol z=\boldsymbol\zeta$ in phase space assume that there is a unique solution $\boldsymbol z(t;\boldsymbol\zeta)$ such that $\dot{\boldsymbol z}(t)=f(\boldsymbol z(t))$, $\boldsymbol z(0)=\boldsymbol\zeta$ that is globally defined for all $t$. Now differentiate $\phi(t)=\phi(\boldsymbol z(t))$ with respect to time, using the chain rule, to see how $\phi(\boldsymbol z(t))$ is changing as $t$ is varied:
\[\left.\frac{\mathrm d}{\mathrm dt}\phi\right|_{t=0}=\left[\sum_{i=1}^m\frac{\partial\phi}{\partial z_i}\dot z_i\right]_{\boldsymbol z=\boldsymbol\zeta}=\nabla\phi(\boldsymbol\zeta)\cdot f(\boldsymbol\zeta).\]
and note that the origin of time is irrelevant, then the equation for the evolution of $\phi$ could be written
\[\frac{\mathrm d}{\mathrm dt}\phi=(\mathcal L_f\phi)(\boldsymbol z).\tag{3.2}\]''',
copied(L,'hasDerivAt_textbookLieDerivative','observableDerivative'),label='(3.2)',
context=[r'$\gamma$为原文给定实际解；$\mathcal L_f$见p.100/PDF122。'],
explanation='用任意实际解及任意时间点的真实链式法则表达；原文全局唯一性强于此局部结论所需，未新增解存在结论。',
prior=['MolecularDynamics.hasDerivAt_textbookLieDerivative'])
add('ObservableSecondDerivative','3.2',101,[12],r'''Similarly,
\[\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))=(\mathcal L_f^2\phi)(\boldsymbol z(t)).\]''',
copied(L,'hasDerivAt_textbookLieDerivative_second','observableSecondDerivative'),context=[r'$\dot\gamma=f(\gamma)$；$\mathcal L_f^2$为两次算子作用，不是函数值平方。'],
extra=['f全域C¹、φ全域C²，显式化原文smooth及第二次求导资格。'],prior=['MolecularDynamics.hasDerivAt_textbookLieDerivative_second'])
add('OperatorExponential','3.2',101,[13],r'''By analogy with the derivation of the matrix exponential, it is tempting to express the exponential as a series expansion in powers of $t$:
\[e^{t\mathcal L_f}=\mathrm{Id}+t\mathcal L_f+\frac{t^2}{2}\mathcal L_f^2+\cdots.\]''',
copied(F,'textbookFormalOperatorExponential','formalOperatorExponential'),kind='definition',
context=[r'A代表原文$\mathcal L_f$所在的实结合非交换代数；原文同页明确“we ignore the convergence issue here and treat the operator exponential as a formal series expansion”。'])
add('FormalObservable','3.2',101,[14],r'''The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as
\[\begin{aligned}\phi(\boldsymbol z(t))&=\phi(\boldsymbol z(0))+t\left.\frac{\mathrm d}{\mathrm dt}\phi(\boldsymbol z(t))\right|_{t=0}+\frac{t^2}{2}\left.\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))\right|_{t=0}+\cdots\\
&=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots\\
&=(e^{t\mathcal L_f}\phi)(\boldsymbol z(0)).\end{aligned}\]''',
copied(D,'formalObservable'),kind='definition',context=[r'时间展开按形式系数定义，不宣称smooth函数等于无限Taylor级数；实际有限余项另条。'],
discussion=r'''However, as $\mathcal L_f$ is a first order operator, this series involves high order mixed partial derivatives, and the convergence of the expansion has to be considered in connection with its application to given initial data, that is, we should consider the expansion
\[e^{t\mathcal L_f}\phi=\phi+t\mathcal L_f\phi+\frac{t^2}{2}\mathcal L_f^2\phi+\cdots\]
then the primary issue is the boundedness of the terms with respect to functions $\phi$ of a certain space of functions; we ignore the convergence issue here and treat the operator exponential as a formal series expansion.''')
add('FiniteLieTaylor','3.2',101,[15],r'''The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as
\[\phi(\boldsymbol z(t))=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots.\]''',
proposition('lieTaylor_statement'),context=[r'与FormalObservable同一展示公式，旧清单有限Taylor余项解释单列；原文没有明写余项不等式。'],
extra=['[EXTRA]有限阶k+1统一局部余项是原文形式展开的额外严格有限解释，原文未明写常数C与δ。','[EXTRA]f与φ取全域C∞并给定实际ODE解；不预设无限级数收敛。'],
verdict='NEEDS_HUMAN',explanation='旧清单添加了原书未显式写出的有限Taylor余项；完整有限签名保留并标EXTRA，独立审校前不将其称为原书逐字定理。',
issues=[dict(code='NEEDS_HUMAN',detail='是否将额外有限余项定理作为原文的忠实严格化，由导师/网站裁定；本地不进入证明。')],missing='任意阶Lie迭代正则性与实际Taylor一致余项桥接尚缺；非PASS不证明。')
add('FlowCoordinates','3.2',101,[16],r'''This gives a concise formula for the evolution of any function of the phase variables, including, in particular, any solution component $z_i$. Thus the flow map for the system can be represented by $\exp(t\mathcal L_f)$. When one writes $\mathcal F_t=\exp(t\mathcal L_f)$, what is actually meant is that the individual components satisfy
\[z_i(t,\boldsymbol\zeta)=[\mathcal F_t(\boldsymbol\zeta)]_i=\left.(\exp(t\mathcal L_f)z_i)\right|_{\boldsymbol z=\boldsymbol\zeta}.\]''',
'''theorem flowCoordinates :
    ∀ (n k : ℕ) (f : Q n → Q n) (D : Set (Q n))
      (Φ : ℝ → Q n → Q n) (η : ℝ),
      ContDiff ℝ ⊤ f → actualFlow f D Φ η →
      ∀ ζ ∈ D, ∀ i : Fin n, ∃ C > 0, ∃ δ > 0, δ ≤ η ∧
        ∀ t ∈ Ioo (-δ) δ,
          |Φ t ζ i - ∑ j ∈ Finset.range (k+1),
            t^j * PowerSeries.coeff j (formalObservable f (fun z => z i) ζ)|
            ≤ C * |t|^(k+1) := by
  sorry''',context=[r'原文同页将exp按形式解释；坐标ζ的每个实际流分量的有限Taylor展开，不声称形式级数实际收敛。'],
extra=['有限截断阶k+1真实余项是额外严格化，原文没有此显式不等式；f全域C∞。'],
verdict='NEEDS_HUMAN',explanation='保留真实流、坐标、实际Lie形式系数及任意有限截断余项；原文形式等式与此额外有限解释的范围待独立审校，未把只证明坐标ODE当作整个结论。',
issues=[dict(code='NEEDS_HUMAN',detail='形式exp作用于坐标的等式无实际收敛主张；严格化为有限Taylor余项是否超出原文需裁定。')],missing='缺实际流与高阶Lie Taylor系数的完整有限余项桥接；本地非PASS不证明。')
add('PoissonBracket','3.2',102,[17],r'''Another common notation for performing computations involving Hamiltonian systems is the Poisson bracket which is defined for two smooth scalar-valued functions $g_1$ and $g_2$ of the phase variables $(\boldsymbol q,\boldsymbol p)$ of a Hamiltonian system in $\mathbb R^m$ by
\[\{g_1,g_2\}=\sum_{i=1}^N\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2,\]''',
copied(L,'textbookPoissonBracket'),kind='definition',context=[r'$J=\begin{bmatrix}0&I\\-I&0\end{bmatrix}$；$I$为$N\times N$单位阵；本文n/Nc为配置坐标数，环境相空间维2n。'])
