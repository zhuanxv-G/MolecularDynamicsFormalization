"""Implicit schemes, eight records from original PDF164–166."""
from ch04_data import add,copied,proposition,D,NS,EXCLUDED
add('PrintedImplicitRelation','4.1',142,[12],r'''The Implicit Midpoint method, for the ODE $\dot z=f(z)$ takes the form
\[z_{n+1}=z_n+h\frac{f(z_n)+f(z_{n+1})}{2},\]''',copied(D,'printedImplicitRelation'),kind='definition',verdict='NEEDS_HUMAN',explanation='字面是梯形法。非线性实际中点f((z+Z)/2)另列，不静默改原公式；线性测试时二者相同。',issues=[dict(code='ERRATUM?',detail='p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。')])
add('ActualMidpointRelation','4.1',142,[],r'''The Implicit Midpoint method, for the ODE $\dot z=f(z)$''',copied(D,'actualMidpointRelation'),kind='definition',extra=['[EXTRA]名称通常对应的真正中点关系Z=z+h f((z+Z)/2)供审校上下文；不是原页的印刷公式。'])
add('ImplicitFactor','4.1',142,[13],r'''can be applied to $\dot z=i\Omega z$ and yields
\[z_{n+1}=\frac{1+ih\Omega/2}{1-ih\Omega/2}z_n.\]''',copied(D,'implicitFactor'),kind='definition',context=['线性场中点/梯形相同；Ω,h实数，分母实部1永不为0。'])
add('ImplicitModulus','4.1',142,[14],r'''For all real $\Omega$, we find
\[\left|\frac{1+ih\Omega/2}{1-ih\Omega/2}\right|=1.\]
This indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!''',proposition('implicitModulus_statement'),extra=['只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。'],missing='待复数商模与共轭对的有限代数证明。')
add('PrintedModifiedFrequency','4.1',143,[15],r'''If the Implicit Midpoint method is viewed as the exact solution of a perturbed harmonic oscillator, then the frequency of this oscillator is
\[\widehat\Omega=\frac1{ih}\ln\frac{1+ih\Omega/2}{1-ih\Omega/2}.\]''',
f'''def printedModifiedFrequency (Ω h : ℝ) : ℂ :=
  (Complex.I*(h : ℂ))⁻¹ * Complex.log ({NS}implicitFactor Ω h)''',kind='definition',extra=['h≠0；采用Mathlib Complex.log主支，对原未指定log支单独记录；后条连续实相位为2 atan(hΩ/2)/h。'],issues=[dict(code='NEEDS_HUMAN',detail='原书未指定复log分支；与连续实相位的桥接须审校。')],verdict='NEEDS_HUMAN',explanation='印刷复log表达式原样保留，不用实atan定义替换原式。')
add('ModifiedFrequencyLimit','4.1',143,[16],r'''The figure shows that the frequency is only well approximated in case $h\Omega$ is sufficiently small. For $h\Omega\gg1$ the frequency is highly modified.''',proposition('modifiedFrequencyLimit_statement'),extra=['[EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。'],context=['printedModifiedFrequency复log支对应需另审；本条采用实连续相位。'],missing='待atan在0的导数/差商极限桥接；不将图示当证明。')
add('MechanicalMidpoint','4.1',144,[17],r'''we may reduce the equations to determining midpoint values $\widehat q,\widehat p$ such that
\[\widehat q=q_n+\frac h2M^{-1}\widehat p,\qquad\widehat p=p_n-\frac h2\nabla U(\widehat q),\]
where, then,
\[q_{n+1}=\widehat q+\frac h2M^{-1}\widehat p,\qquad p_{n+1}=\widehat p-\frac h2\nabla U(\widehat q).\]''',copied(D,'mechanicalMidpointRelation'),kind='definition',context=['保留四个真实关系，不假装隐式解存在唯一；质量正是物理资格。'])
add('MidpointElimination','4.1',144,[18],r'''We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $\widehat p$, we find
\[\widehat q=q_n+\frac h2M^{-1}p_n-\frac{h^2}{4}M^{-1}\nabla U(\widehat q).\]''',proposition('midpointElimination_statement'),context=['实际四关系推出位置消元等式；不增加解存在或Newton收敛结论。'],missing='待逐坐标线性质量与有限代数短证明。')
EXCLUDED += [dict(printed_page='139–144',pdf_page='161–166',reason='MD平衡点类型的经验判断、化学键最快模式、图示精度和误差传播推测、求解成本与使用建议为定性背景；稳定性、谱、端点、频率和中点数学公式均独立保留。')]
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ImplicitModulus','MidpointElimination','ModifiedFrequencyLimit'])
