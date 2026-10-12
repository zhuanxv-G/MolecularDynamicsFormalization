"""Mathematical content beside the numerical plots: actual initial sets and laws."""
from ch05_data import add,NS
add('PendulumPotential','5.4.1',200,[],r'''Example 5.5 (Double Pendulum) To explore some of the issues related to ergodicity, let us return to the double pendulum considered in Chap. 3.''',f'''def pendulumPotential (k₁ k₂ l₁ l₂ : ℝ) (q : {NS}E 2) :=
  k₁/2*(Real.sqrt ((q 0)^2+(q 1)^2)-l₁)^2+
    k₂/2*(Real.sqrt ((q 0)^2+(q 1+2)^2)-l₂)^2''',kind='definition',label='Example 5.5',extra=['[EXTRA]引用的真实双弹簧势按§3.5印刷126/PDF148已存在原页核对：U=k₁(r₁−l₁)²/2+k₂(r₂−l₂)²/2，r₁=√(x²+y²)、r₂=√(x²+(y+2)²)；不是把数值轨迹图当势的定义。'],context=['本条为第5章引用对象的本地定义；不改变已完成第3章文件。'])
add('PendulumRegionPrinted','5.4.1',200,[],r'''For given positive values of the coefficients, the region swept out in the plane by trajectories can be seen to be a union of intersections of pairs of disks centered at the origin and $(0,-2)$, with radii $r_1,r_2$ respectively, which themselves represent a point on an ellipse in the first quadrant. Determining the boundary of this region analytically is difficult but it is easy to find it numerically. For the special case $k_1=k_2=2$, $l_1=l_2=1$, and $E=4$ that the projected region covered by positions at this energy is the interior of the level set $U=E$ shown as a dark oval curve in the three panels of Fig. 5.4.''',f'''theorem pendulumRegionPrinted : ∀ k₁ k₂ l₁ l₂ c : ℝ,
  0 < k₁ → 0 < k₂ → 0 < l₁ → 0 < l₂ → 0 < c →
  {{q : {NS}E 2 | ∃ p : {NS}E 2,
    ((p 0)^2+(p 1)^2)/2+pendulumPotential k₁ k₂ l₁ l₂ q=c}}=
  {{q : {NS}E 2 | ∃ r₁ > 0,∃ r₂ > 0,
    k₁/2*(r₁-l₁)^2+k₂/2*(r₂-l₂)^2=c ∧
    Real.sqrt ((q 0)^2+(q 1)^2) ≤ r₁ ∧ Real.sqrt ((q 0)^2+(q 1+2)^2) ≤ r₂}} := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]一般弹簧势在距离小于rest length时不随距离单调，不能由椭圆上的半径上界自动推出能量可达；给定图的特殊参数与一般系数需分开。“swept out”还不能保证单条轨迹覆盖静态能量投影，且边界U=E在全能量投影中可达，原“interior”需解释。',extra=['[EXTRA]原描述的可达region按所有能量初值的位置投影解释，单位动能；真实两圆盘中心、正半径和半径能量椭圆完整保留，不假设所求等式。'],missing='一般圆盘并集说法及边界/轨道覆盖解释需原页语义裁定，不证明。')
add('AnisotropicInitialCurve','5.4.1',201,[],r'''Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\le x\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$.''',f'''def anisotropicInitialCurve (κ l ε c x : ℝ) : {NS}Phase 2 :=
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![0,Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))])''',kind='definition',context=['实际位置及动量随x参数化，单位质量；区间Icc(105/100)(115/100)与根号非负资格在使用条目保留。'])
add('AnisotropicInitialEnergy','5.4.1',201,[],r'''For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$.''',f'''theorem anisotropicInitialEnergy : ∀ κ l ε c x : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := anisotropicInitialCurve κ l ε c x
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry''',extra=['[EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。'],missing='待真实sqrt平方及初值能量代数短证明。')
add('InitialSegmentPrinted','5.4.1',201,[],r'''The set of initial conditions forms a line segment in the four-dimensional phase space.''',f'''theorem initialSegmentPrinted : ∀ κ l ε c : ℝ,
  (∀ x ∈ Icc (105/100 : ℝ) (115/100),0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])) →
  ∃ a b : {NS}Phase 2,anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)=segment ℝ a b := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]位置区间是线段，但p_y=√(2(E₀−U(x,0)))通常非仿射函数，完整四维初值集一般是曲线而非直线段；字面陈述与正则曲线像定理分开。',extra=['[EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。'],missing='原四维line segment疑误待裁定，不证明。')
add('CircleInitialPoints','5.4.1',202,[],r'''Now consider an alternative initial set. Begin, as before, with a line segment on the $x$-axis, but now choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$. In this way we again get initial conditions on the $H=E_0$ energy surface, but this time the points are not close to one another in phase space, since the momenta of successive points may differ greatly.''',f'''def circleInitialPoints (κ l ε c x θ : ℝ) : {NS}Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])''',kind='definition',context=['实际动量圆的角参数化；根号非负时对应书中圆，半径0允许退化点，均匀角概率推送另条。'])
add('CircleInitialLaw','5.4.1',202,[],r'''choose the initial momenta from the uniform distribution on the circle $p_x^2+p_y^2=2(E_0-U(x,0))$.''',f'''def circleInitialLaw (κ l ε c x : ℝ) : Measure ({NS}Phase 2) :=
  Measure.map (circleInitialPoints κ l ε c x)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))''',kind='definition',extra=['[EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。'])
add('CircleInitialEnergy','5.4.1',202,[],r'''In this way we again get initial conditions on the $H=E_0$ energy surface.''',f'''theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry''',extra=['[EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。'],missing='待sqrt平方及cos²+sin²=1的能量代数短证明。')
