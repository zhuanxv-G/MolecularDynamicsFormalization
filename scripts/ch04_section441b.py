"""Eight axis/noncanonical objects, PDF194–195; orientation signs explicit."""
from ch04_data import add,copied,proposition,D,NS
add('PoissonDegeneracy','4.4.1',172,[93],r'''$\widetilde J\pi=\pi\times\pi=0$.''',f'''theorem poissonDegeneracy : ∀ π : {NS}V, {NS}rigidPoissonMatrix π *ᵥ π=0 := by
  sorry''',missing='待实际Fin3矩阵代数短证明。')
add('AxisRotation','4.4.1','173–174',[94],r'''Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7). The notation $\Theta_x(\phi)$ refers to a rotation around the x-axis by an angle $\phi$, that is
\[\Theta_x(\phi)=\begin{bmatrix}1&0&0\\0&\cos\phi&-\sin\phi\\0&\sin\phi&\cos\phi\end{bmatrix},\]
with corresponding formulae for $\Theta_y$ and $\Theta_z$.''',copied(D,'axisRotation'),kind='definition',context=['右手主动轴旋转，Fin3为0,1,2对应书1,2,3。'])
add('SecondAxisPrinted','4.4.1',173,[94],r'''$\dot\pi=\pi\times[0,T_2^{-1}\pi,0]^T$.''',f'''def secondAxisPrinted (I : {NS}V) (π : {NS}V) (a : ℝ) : {NS}V :=
  {NS}cross3 π ![0,a/I 1,0]''',kind='definition',verdict='NEEDS_HUMAN',explanation='第二子系统向量第二分量印π而不是π₂，标量/向量类型含糊；a仅代表未确定印刷标量，不能假定a=π₂。',extra=['为未定义标量引入a供审校，不声称它等于π₂。'],issues=[dict(code='ERRATUM?',detail='p173第二子系统分量少下标2，原文尚需导师裁定。')])
add('ThirdAxisPrinted','4.4.1',173,[94],r'''$\dot\pi=\pi\times[0,0,T_3^{-1}\pi]^T$.''',f'''def thirdAxisPrinted (I : {NS}V) (π : {NS}V) (a : ℝ) : {NS}V :=
  {NS}cross3 π ![0,0,a/I 2]''',kind='definition',verdict='NEEDS_HUMAN',explanation='高倍率原页确认第三子系统末分量也印π而不是π₃；未确定印刷标量以a表示，不假定它等于π₃。',extra=['[EXTRA]a只为缺下标的印刷标量供审校。'],issues=[dict(code='ERRATUM?',detail='p173第三子系统分量少下标3，单列保留原式。')])
add('PrincipalAxisField','4.4.1',173,[],r'''If $T$ is a diagonal matrix, $T=\operatorname{diag}(I_1,I_2,I_3)$, then we split the Euler equations and approximate the solution by successive rotations around the three axes of inertia.''',f'''def principalAxisField (I : {NS}V) (i : Fin 3) (π : {NS}V) : {NS}V :=
  {NS}cross3 π (Pi.single i (π i/I i))''',kind='definition',extra=['[EXTRA]第二分量修为π₂；完整正确三个子场统一定义，不覆盖印刷错版。'])
add('PrintedSpinAxis','4.4.2',174,[94],r'''$\pi^k:=\Theta\pi^k;\quad\Theta^k:=\Theta^k\Theta^T$.''',f'''def printedSpinAxis (I : {NS}V) (i : Fin 3) (h : ℝ) (s : {NS}V × {NS}Mat3) : {NS}V × {NS}Mat3 :=
  let R := {NS}axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)''',kind='definition',context=['高倍率原页确认：π为列向量左乘R，Θ右乘Rᵀ；与正式库spinAxis的定义一致。'],issues=[dict(code='ERRATUM?',detail='p174正角列动量Rπ的导数符号与(4.41)π×ω相反；保留原算法，不证明其精确子流。')])
add('PrintedSpinStep','4.4.2',174,[94],r'''“Spin”: update the rotational state of the kth rigid body by the sequence of steps
\[\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,\]
\[\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,\]
\[\Theta:=\Theta^z(h\pi_3^k/I_3);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,\]
\[\Theta:=\Theta^y(\tfrac h2\pi_2^k/I_2);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T,\]
\[\Theta:=\Theta^x(\tfrac h2\pi_1^k/I_1);\ \pi^k:=\Theta\pi^k;\ \Theta^k:=\Theta^k\Theta^T.\]''',f'''def printedSpinStep (I : {NS}V) (h : ℝ) : {NS}V × {NS}Mat3 → {NS}V × {NS}Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)''',kind='definition',context=['真实五轴算法映射；保留字面旋转/动量符号。'])
add('AxisFlowFormal','4.4.1',173,[95],r'''Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7).''',proposition('axisFlow_statement'),verdict='NEEDS_HUMAN',explanation='正式库spinAxis正角动量Rπ与π×ω子场符号相反；结论不先证明错误版。',extra=['[EXTRA]旧声明使用与p174一致的正式库spinAxis；作为待审正角精确子流候选，不把它当已证原结论。'],issues=[dict(code='ERRATUM?',detail='正角主动Rπ导数=ω×π，不是π×ω；精确流需负角列动量。')],missing='本地NEEDS_HUMAN；待网站/导师裁定正负号。')
add('SpinPoissonFormal','4.4.1',173,[95],r'''This yields a simple, efficient algorithm for the free rigid body which is symplectic in a generalized sense.''',proposition('spinPoisson_statement'),extra=['[EXTRA]此条仅正式库三维非canonical动量映射D J Dᵀ=J(Gπ)；Θ字面算法的完整几何结构另列。'],missing='缺动量依赖轴旋转Jacobian与Poisson结构短桥；不搭完整Poisson理论。')
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['PoissonDegeneracy'])
next(r for r in RECORDS if r['source_id'].endswith('-PrincipalAxisField'))['extra_assumptions']=['[EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。']
