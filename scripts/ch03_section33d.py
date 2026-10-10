"""Symmetry and Yoshida first batch: original PDF130–132."""
from ch03_data import add,copied,proposition,D,EXCLUDED
add('StrangInverse','3.3.2',108,[51],r'''Setting $s=-t$, the left hand side of (3.4) collapses to the identity.''',
proposition('strangInverse_statement'),context=[r'(3.4)完整形式乘积见同页DifferentLogsCommute；本条单独反步恒等式不假设不同步长log交换。'],
missing='缺任意实非交换代数中形式指数负参数的完整逆元系数桥接；保留sorry，不搭大型形式指数理论。')
add('StrangCubic','3.3.2',108,[52],r'''\[\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(t(X+Y)+t^3\widehat Z_{[3]}+\cdots),\tag{3.6}\]
where
\[\widehat Z_{[3]}=\frac1{12}[Y,[Y,X]]-\frac1{24}[X,[X,Y]].\tag{3.7}\]''',
proposition('strangCubic_statement'),label='(3.6)–(3.7)',context=[r'$X,Y$为非交换形式生成元；[A,B]=AB−BA；签名直接为真实formalLog三次系数。'],
missing='缺形式Strang乘积与formalLog三次系数的有限非交换代数桥接；待有界短证明。')
add('YoshidaComposition','3.3.3',109,[53],r'''We now consider iterating this scheme three times, first using a step of $\tau_0h$, followed by a step of $\tau_1h$, and finally another step with stepsize $\tau_0h$ (where $\tau_0h+\tau_1h+\tau_0h=h$). The overall effect on the system is given by a product of exponentials, as
\[\exp(\tau_0h\widehat{\mathcal L}_{\tau_0h})\exp(\tau_1h\widehat{\mathcal L}_{\tau_1h})\exp(\tau_0h\widehat{\mathcal L}_{\tau_0h})=\exp(hZ_h).\]''',
copied(D,'yoshidaCompose'),kind='definition',context=[r'$a=\tau_0,b=\tau_1$；2a+b=1在系数结论中明示；允许中间负步长，不裁掉反向步。'])
add('YoshidaCoefficients','3.3.3',109,[55],r'''We have free reign over constants $\tau_0$ and $\tau_1$ as long as $2\tau_0+\tau_1=1$. Hence we have an opportunity to annihilate the perturbation operator at order $h^{2s}$ by choosing $2\tau_0^{2s+1}+\tau_1^{2s+1}=0$ as well. Solving simultaneously, there exists a unique real solution
\[\tau_0=\frac1{2-\kappa},\qquad\tau_1=-\frac\kappa{2-\kappa},\qquad\kappa^{2s+1}=2,\]''',
copied(D,'yoshidaCoefficients'),kind='definition',context=[r'$s\ge1$；$\kappa=2^{1/(2s+1)}$为正实根，真实Real.rpow；方程成立和唯一性分别另条完整结论，不因定义而假定。'])
add('YoshidaCancellation','3.3.3',109,[54],r'''We have free reign over constants $\tau_0$ and $\tau_1$ as long as $2\tau_0+\tau_1=1$. Hence we have an opportunity to annihilate the perturbation operator at order $h^{2s}$ by choosing $2\tau_0^{2s+1}+\tau_1^{2s+1}=0$ as well.''',
proposition('yoshidaCancellation_statement',proof='''intro s hs
  let κ := yoshidaRoot s
  have hκ0 : 0 < κ := Real.rpow_pos_of_pos (by norm_num) _
  have hN : 1 < ((2*s+1 : ℕ) : ℝ) := by exact_mod_cast (show 1 < 2*s+1 by omega)
  have hκ2 : κ < 2 := by
    change Real.rpow 2 (1/((2*s+1 : ℕ):ℝ)) < 2
    calc
      _ < Real.rpow 2 1 := Real.rpow_lt_rpow_of_exponent_lt (by norm_num)
        ((div_lt_one (by positivity)).2 hN)
      _ = 2 := Real.rpow_one 2
  have hκpow : κ^(2*s+1)=2 := by
    simpa [κ, yoshidaRoot, one_div] using
      (Real.rpow_inv_natCast_pow (x := (2:ℝ)) (n := 2*s+1) (by norm_num) (by omega))
  have hd : 0 < 2-κ := sub_pos.mpr hκ2
  have hd0 : 2-κ ≠ 0 := ne_of_gt hd
  have ho : Odd (2*s+1) := ⟨s, by omega⟩
  change 2*(1/(2-κ))+(-κ/(2-κ))=1 ∧
    2*(1/(2-κ))^(2*s+1)+(-κ/(2-κ))^(2*s+1)=0 ∧ -κ/(2-κ)<0
  refine ⟨?_, ?_, div_neg_of_neg_of_pos (neg_neg_of_pos hκ0) hd⟩
  · field_simp
    ring
  · rw [neg_div, ho.neg_pow, div_pow, div_pow, one_pow, hκpow]
    ring'''),
context=[r'系数与κ正实根见同页YoshidaCoefficients；s≥1排除s=0退化分母。'],
extra=['显式s≥1，并保留中间系数τ₁<0作为根公式的数学推论。'])
add('YoshidaUnique','3.3.3',109,[56],r'''Solving simultaneously, there exists a unique real solution
\[\tau_0=\frac1{2-\kappa},\qquad\tau_1=-\frac\kappa{2-\kappa},\qquad\kappa^{2s+1}=2.\]''',
proposition('yoshidaUnique_statement',proof='''intro s hs a b
  let κ := yoshidaRoot s
  have hN : 1 < ((2*s+1 : ℕ) : ℝ) := by exact_mod_cast (show 1 < 2*s+1 by omega)
  have hκ2 : κ < 2 := by
    change Real.rpow 2 (1/((2*s+1 : ℕ):ℝ)) < 2
    calc
      _ < Real.rpow 2 1 := Real.rpow_lt_rpow_of_exponent_lt (by norm_num)
        ((div_lt_one (by positivity)).2 hN)
      _ = 2 := Real.rpow_one 2
  have hd0 : 2-κ ≠ 0 := ne_of_gt (sub_pos.mpr hκ2)
  have hκpow : κ^(2*s+1)=2 := by
    simpa [κ, yoshidaRoot, one_div] using
      (Real.rpow_inv_natCast_pow (x := (2:ℝ)) (n := 2*s+1) (by norm_num) (by omega))
  have ho : Odd (2*s+1) := ⟨s, by omega⟩
  constructor
  · rintro ⟨hab, hp⟩
    have heq : (-b)^(2*s+1)=(κ*a)^(2*s+1) := by
      rw [ho.neg_pow, mul_pow, hκpow]
      linarith
    have hrel : -b=κ*a := ho.pow_injective heq
    have ha : a=1/(2-κ) := by
      apply (eq_div_iff hd0).2
      nlinarith
    have hb : b=-κ/(2-κ) := by
      calc
        b = -κ*a := by nlinarith
        _ = -κ/(2-κ) := by rw [ha]; ring
    change (a,b)=(1/(2-κ),-κ/(2-κ))
    exact Prod.ext ha hb
  · intro heq
    change (a,b)=(1/(2-κ),-κ/(2-κ)) at heq
    rcases Prod.mk.inj heq with ⟨rfl,rfl⟩
    exact ⟨(yoshidaCancellation s hs).1, (yoshidaCancellation s hs).2.1⟩'''),
context=[r'$s\ge1$；两个原方程见同页YoshidaCancellation；κ为正实根。'])
add('YoshidaRaiseOrder','3.3.3',109,[57],r'''giving us a scheme of order $2s+2$. We can then proceed recursively, as this new order $2s+2$ scheme can be composed similarly to wipe out successive higher order terms.''',
proposition('yoshidaRaiseOrder_statement'),context=[r'原方法对称且阶2s≥2，真实三步复合及系数同页；保留负时间步。'],
extra=['给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。'],
missing='缺完整非交换BCH/奇性到实际局部余项改阶桥接；属大型理论，不建设。')
add('Yoshida4','3.3.3','109–110',[58],r'''Example 3.1 Consider using velocity Verlet as the base second-order method to build a Yoshida fourth-order method from. As the scheme is second-order, we have $s=1$, and hence
\[\tau_0=\frac1{2-\sqrt[3]2},\qquad\tau_1=-\frac{\sqrt[3]2}{2-\sqrt[3]2}.\]
The overall scheme is then three iterations of velocity Verlet, using stepsizes $\tau_0h$, $\tau_1h$ and $\tau_0h$ respectively. We write this with subindices $\alpha,\beta$ to indicate the intermediate stages.
Yoshida fourth-order scheme (velocity Verlet):
\[\begin{aligned}P_\alpha&:=p-(\tau_0h/2)\nabla U(q),&Q_\alpha&:=q+(\tau_0h)M^{-1}P_\alpha,\\
P_\alpha&:=P_\alpha-(\tau_0h/2)\nabla U(Q_\alpha),&P_\beta&:=P_\alpha-(\tau_1h/2)\nabla U(Q_\alpha),\\
Q_\beta&:=Q_\alpha+(\tau_1h)M^{-1}P_\beta,&P_\beta&:=P_\beta-(\tau_1h/2)\nabla U(Q_\beta),\\
P&:=P_\beta-(\tau_0h/2)\nabla U(Q_\beta),&Q&:=Q_\beta+(\tau_0h)M^{-1}P,\\
P&:=P-(\tau_0h/2)\nabla U(Q).\end{aligned}\tag{3.8}\]''',
copied(D,'yoshida4'),kind='definition',label='Example 3.1 / (3.8)',context=[r'三次速度Verlet与每次kick-drift-kick九阶段完全相同；算法名fourth-order，实际阶结论仍在YoshidaRaiseOrder且未证明。'],
extra=['M为固定对角质量；不假设正反步骤的实际无限时域流存在。'])
EXCLUDED += [dict(printed_page='109–112',pdf_page='131–134',reason='Yoshida历史、力计算成本、图3.2实验能量曲线、最优系数与模型截断误差选择为定性背景；真实复合公式另列。')]
