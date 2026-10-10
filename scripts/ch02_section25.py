"""§2.5 verbatim mathematical text, rendered PDF111–116 (before Exercises)."""
from ch02_data import add,copied,proposition,EXCLUDED
RD='MolecularDynamics/Chapter02/ReviewDefinitions.lean'
def d(name):return copied(RD,name,'bp_'+name)
def err(detail):return [dict(code='ERRATUM?',status='NEEDS_HUMAN',detail=detail)]

add('RK','2.5.1',89,[139],r'''The family of Runge-Kutta methods for solving $\dot{\boldsymbol z}=f(\boldsymbol z)$ is defined by
\[\boldsymbol Z=\boldsymbol z+h\sum_{i=1}^s b_i\boldsymbol F_i,\]
where the vectors $\boldsymbol F_i$, $i=1,\ldots,s$, are computed by solving the system
\[\boldsymbol F_i=f\left(\boldsymbol z+h\sum_{j=1}^s a_{ij}\boldsymbol F_j\right),\qquad i=1,\ldots,s.\]''',d('rungeKuttaRelation'),kind='definition',context=['s有限阶段；给实际关系，不宣称任意隐式系统可解。'])
add('RK4','2.5.1',89,[140],r'''An example of a popular 4th order explicit method is the choice of matrix $A$ with coefficients $a_{ij}=0$ except $a_{21}=1/2$, $a_{32}=1/2$ and $a_{43}=1$, and $b_1=1/6$, $b_2=1/3$, $b_3=1/3$, $b_4=1/6$.''',d('rk4'),kind='definition',context=['展开实际四阶段给出同一A/b权重；4阶陈述单列。'])
add('RK4Order','2.5.1',89,[141],'''An example of a popular 4th order explicit method''',proposition('rk4Order_statement','rk4Order'),context=['完整系数与映射见同页RK4条目，非任意方法；有限时间窗全局4阶。'],extra=['[EXTRA]compactTrajectory实际C⁶向量场与紧窗实际轨迹；高阶资格强于原文简写。'],missing='一般RK树阶条件/实际四阶Taylor展开及局部误差、稳定性、数值留域的全局阶桥接。')
add('ExplicitRK','2.5.1',89,[142],'''This method is not symplectic, and in fact impossible to find symplectic explicit methods within the Runge-Kutta family.''',proposition('explicitRKUniversal_statement','explicitRK'),
extra=['[EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。'],missing='已有证明仅系数条件不可能；普适必要性及实际RK反例构造尚缺，不能把系数lemma当完整结论。')
add('RKSymplectic','2.5.1','89–90',[143],r'''Let us emphasize that, while a typical RK method is not symplectic, some implicit Runge-Kutta methods are symplectic. The precise condition that must be satisfied [325] is
\[b_i a_{ij}+b_j a_{ji}=b_i b_j,\qquad i=1,\ldots,s,\quad j=1,\ldots,s.\]''',proposition('rkSymplectic_statement','rkSymplectic'),
context=['本签名完整充分性，原句“precise condition”若含必要性须不可约RK资格，另登记。'],extra=['H C²；真实阶段函数与完整步G C¹且确实满足RK关系。'],issues=[dict(code='NECESSITY_QUALIFICATION',status='NEEDS_HUMAN',detail='原句precise condition含必要性语气；现签名仅充分性，完整iff需不可约/非退化方法资格，不能默认为一般RK必要条件。')],verdict='NEEDS_HUMAN',explanation='完整必要性范围尚未裁定，充分性签名保留但不进入证明。',missing='实际RK楔积充分性与不可约必要性理论。')
add('GaussFamily','2.5.1',90,[145],r'''The Gauss-Legendre family of Runge-Kutta (GLRK) methods correspond to approximating the vector field at the Gauss points, i.e. the zeros of the orthogonal polynomials that arise in Gaussian quadrature. As these points are symmetrically distributed the GLRK schemes are symmetric, hence have even order.''',proposition('gaussRK_statement','gaussFamily'),label='Example 2.7 (family)',extra=['[EXTRA]实际Legendre根节点、Lagrange积分系数；s>0，节点单射，C∞向量场和实际光滑G；真实唯一阶段及真实流资格。'],missing='大型Gauss配点构造、正交多项式根/对称性、阶2s及逆步理论；当前库无完整理论。')
add('Midpoint','2.5.1',90,[144],r'''The simplest such method is the implicit midpoint rule:
\[\boldsymbol Z=\boldsymbol z+h\boldsymbol F_1,\qquad\boldsymbol F_1=f\left(\boldsymbol z+\frac h2\boldsymbol F_1\right),\]''',d('midpointRelation'),kind='definition',context=['消去实际F₁得到Z=z+hf((z+Z)/2)；只是隐式关系。'])
add('MidpointProperties','2.5.1',90,[146],'''which has order 2.''',proposition('midpointProperties_statement','midpointProperties'),context=['来自GLRK辛RK上下文，保留二阶与辛性两个结论；实际中点关系见同页。'],extra=['[EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。'],missing='实际中点隐式楔积、局部三阶余项及唯一可微求解接口。')
add('GaussTwo','2.5.1',90,[147],r'''The 4th order method ($s=2$) has coefficients
\[b_1=b_2=\frac12,\qquad A=(a_{ij})=\begin{bmatrix}\frac14&\frac14-\frac{\sqrt3}6\\\frac14+\frac{\sqrt3}6&\frac14\end{bmatrix}.\]''',
'''def gaussTwoData : Matrix (Fin 2) (Fin 2) ℝ × (Fin 2 → ℝ) :=
  (gaussTwoCoefficients, fun _ => 1/2)''',kind='definition',context=['本定义完整A及b；四阶子句来自GaussFamily(s=2)的大型配点阶理论，不能只凭系数称已证明。'])
add('PartitionedVerlet','2.5.2',90,[148],r'''As an illustration, consider the method:
\[\hat{\boldsymbol P}=\boldsymbol p-\frac h2\nabla_qH(\boldsymbol q,\hat{\boldsymbol P}),\tag{2.26}\]
\[\boldsymbol Q=\boldsymbol q+\frac h2(\nabla_pH(\boldsymbol q,\hat{\boldsymbol P})+\nabla_pH(\boldsymbol Q,\hat{\boldsymbol P})),\tag{2.27}\]
\[\boldsymbol P=\hat{\boldsymbol P}-\frac h2\nabla_qH(\boldsymbol Q,\hat{\boldsymbol P}).\tag{2.28}\]''',d('partitionedVerletRelation'),kind='definition',context=['实际H(q,p)两个偏导与中间动量；不假设隐式关系全球可解。'])
add('PartitionedReduction','2.5.2',91,[149],r'''When $H=\boldsymbol p^TM^{-1}\boldsymbol p/2+U(\boldsymbol q)$ this is just the leapfrog/Verlet method, but it can be used also for more general systems.''',proposition('partitionedReduction_statement','partitionedReduction'),extra=['固定正对角质量、U实际可微；中间动量存在关系与Verlet映射等价。'],missing='机械H两个实际偏导的坐标计算，随后三步关系消元。')
add('GeneralEuler','2.5.2',91,[150],r'''where $\mathcal G_h$ is defined by
\[\boldsymbol P=\boldsymbol p-h\nabla_qH(\boldsymbol q,\boldsymbol P),\tag{2.29}\]
\[\boldsymbol Q=\boldsymbol q+h\nabla_pH(\boldsymbol q,\boldsymbol P),\tag{2.30}\]''',d('generalSymplecticEulerRelation'),kind='definition',context=['实际隐式辛Euler关系，真实求解及可微资格在辛性条目。'])
add('GeneralSymplectic','2.5.2',91,[151],r'''To see that it is symplectic, we first note that this is a symmetric composition of the form
\[\mathcal K_h=\mathcal G_{h/2}^*\circ\mathcal G_{h/2},\]
so it is enough to show that this basic method is symplectic.''',
proposition('generalSymplectic_statement','generalSymplectic'),
proof=r'''Taking differentials of (2.30) defining $\mathcal G_h$ and then wedge products and summing, we have
\[\sum_i dQ_i\wedge dP_i=\sum_i dq_i\wedge dP_i+h\sum_i\sum_j H_{p_iq_j}dq_j\wedge dP_i+h\sum_i\sum_j H_{p_ip_j}dP_j\wedge dP_i.\]
The last term on the right vanishes by equality of mixed partials and the antisymmetry of the wedge product. On the other hand, using (2.29), we obtain, by similar means,
\[\sum_i dq_i\wedge dP_i=\sum_i dq_i\wedge dp_i-h\sum_i\sum_j H_{q_ip_j}dq_i\wedge dP_j.\]
Relabelling the indices in the sum and using our previous work results in
\[\sum_i dQ_i\wedge dP_i=\sum_i dq_i\wedge dp_i,\]
implying that the method is symplectic.''',extra=['H C²，真实C¹完整求解映射，逐点满足实际隐式关系。'],missing='隐式实际Jacobian/楔积抵消；混合Hessian和一般求解接口。')
add('GeneralVerletSymplectic','2.5.2',91,[],'''To see that it is symplectic, we first note that this is a symmetric composition''',proposition('generalizedVerletSymplectic_statement','generalVerletSymplectic'),context=['完整原文主语是(2.26)–(2.28)；GeneralSymplectic条目保存全部原书证明。'],extra=['H C²，实际C¹中间动量和完整求解映射，满足三步隐式关系。'],missing='一般隐式辛Euler的实际证明、伴随求解及半步组合等价；需要完整隐式映射理论。')
add('Newmark','2.5.3',92,[152],r'''As a special case of a partitioned Runge-Kutta method, consider the Newmark family of methods [280] defined for two parameters $\sigma$ and $\eta$ by the formulas
\[\boldsymbol P=\boldsymbol p-h(1-\sigma)\nabla U(\boldsymbol q)-h\sigma\nabla U(\boldsymbol Q),\]
\[\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p-h^2\left(\frac12-\eta\right)\nabla U(\boldsymbol q)-h^2\eta\nabla U(\boldsymbol Q).\]''',d('newmarkRelation'),kind='definition',context=['Lean γ/β分别原文σ/η，F=-∇U；严格保留Q式两个force项缺M⁻¹。'],issues=err('Q式力项缺M⁻¹；不默改成质量一致Newmark。'),verdict='NEEDS_HUMAN',explanation='字面关系已保存；原书质量约定需裁定。')
add('NewmarkReduction','2.5.3',92,[153],r'''For $\eta=0$ we then arrive at the Verlet method.''',
'''theorem newmarkReduction : ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkRelation m F (1/2) 0 h z w ↔ w=verlet m F h z := by
  sorry''',context=['“then”前句σ=1/2；保留一般M的字面全称。'],issues=err('字面Newmark在一般M不等于Verlet，仅M=I或修正Q式force质量因子后成立；不以旧质量修正版证明替代原句。'),verdict='NEEDS_HUMAN',explanation='完整字面一般质量结论，不静默限定单位质量；待裁定。',missing='原书质量因子；旧已证版本是质量修正式，不能直接桥接。')
add('NewmarkDamping','2.5.3',92,[154],r'''In practice the choice $\sigma=1/2$ is used to avoid spurious damping (it can be demonstrated for a simple model problem); this certainly would appear to be desirable in the setting of molecular dynamics.''',proposition('newmarkNoDamping_statement','newmarkDamping'),extra=['[EXTRA]限定原文simple model为单位质量线性振子；h步隐式线性系统非奇异；用实际放大矩阵det=1表达无面积收缩，不声称任意势能能量恒定。'],missing='线性振子实际隐式放大矩阵与行列式计算。')
add('NewmarkNotSymplectic','2.5.3',92,[155],'''The implicit Newmark methods are not symplectic, but a related family of symplectic methods can be constructed by using linear interpolated forces evaluated at interpolated positions [395].''',proposition('newmarkNotSymplectic_statement','newmarkNotSymplectic'),extra=['[EXTRA]存在一个非线性势能、β≠0与非零步长的实际可微求解反例；不是排除每个线性特殊情形。单位质量与字面式一致。'],missing='具体非线性势能全局C¹隐式求解反例与实际Jacobian非辛；相关interpolated family无公式登记定性排除。')
add('MultiTaylor','2.5.4',92,[156],r'''we may approximate a single step by
\[\boldsymbol z_{n+1}=\boldsymbol z_n+h\dot{\boldsymbol z}_n+\frac{h^2}{2}\ddot{\boldsymbol z}_n+\cdots+\frac{h^k}{k!}\boldsymbol z_n^{(k)},\]
where it is possible to make use of higher order derivatives of the solution in formulating the method. Then using the differential equation, the time derivatives may be replaced by elementary differentials of the vector field.''',d('multiTaylor'),kind='definition',context=['dⱼ是真实解j阶时间导数数据，不把任意数据当作已有Taylor阶证明。'])
add('TIPotential','2.5.4','92–93',[157],r'''the Takahashi-Imada method [355] (also known as Rowlands’ method [316]) has the same form as the Verlet method
\[\hat{\boldsymbol P}=\boldsymbol p-(h/2)\nabla\tilde U(\boldsymbol q),\quad\boldsymbol Q=\boldsymbol q+hM^{-1}\hat{\boldsymbol P},\quad\boldsymbol P=\hat{\boldsymbol P}-(h/2)\nabla\tilde U(\boldsymbol Q),\]
where the corresponding potential energy function is
\[\tilde U(\boldsymbol q)=U(\boldsymbol q)-\frac{h^2}{24}\nabla U(\boldsymbol q)^TM^{-1}\nabla U(\boldsymbol q).\]''',
'''def tiMethod {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h''',kind='definition',context=['实际改势已递归引用takahashiPotential；完整Verlet映射而非只记势能符号。'])
add('TIForce','2.5.4',93,[158],r'''The forces arising from such a modified potential can be worked out:
\[\tilde F=-\nabla\tilde U=-\left[I+\frac{h^2}{12}U''M^{-1}\right]\nabla U,\]
where $U''$ is the Hessian matrix of the potential.''',proposition('takahashiForce_statement','tiForce'),extra=['正质量，U C²，真实改势梯度及Hessian作用。'],issues=err('上项改势为U−h²‖gradU‖²M⁻¹/24，负梯度应有+ h²Hessian项；原页此力式负号冲突，保留字面。'),verdict='NEEDS_HUMAN',explanation='原书力与改势符号不一致，未作静默修正。',missing='原书改势/力符号裁定。')
add('TIOrder','2.5.4',93,[159],r'''This method can be shown to have effective order four, meaning that there is a change of variables $\chi_h$ which can be used to transform the Takahashi-Imada method into one of order four using the processing technique of Sect. 2.4.5. The potential energy modification has been specifically chosen to annihilate terms in the local error expansion (after coordinate transformation).''',proposition('takahashiOrder_statement','tiOrder'),extra=['正质量，U C∞；实际步依照上项负号改势；处理器为实际Homeomorph，原轨迹及有限时间窗误差结论。'],issues=[dict(code='DEPENDENT_ERRATUM',status='NEEDS_HUMAN',detail='有效四阶依赖改势符号；原文改势和力相互冲突，本签名保留负号改势，需裁定处理器方向和正负修正。')],verdict='NEEDS_HUMAN',explanation='符号依赖未裁定，保留存在处理器的实际四阶结论。',missing='大型修正方程/处理器构造及四阶局部消项与全局阶理论。')
add('Beeman','2.5.5',94,[],r'''The method treats the positions and momenta differently, updating these from the formulas
\[\boldsymbol q_{n+1}=\boldsymbol q_n+h\dot{\boldsymbol q}_n+\frac{h^2}{6}[4\ddot{\boldsymbol q}_n-\ddot{\boldsymbol q}_{n-1}].\tag{2.31}\]
\[\boldsymbol p_{n+1}=\boldsymbol p_n+\frac h6 M[2\ddot{\boldsymbol q}_{n+1}+5\ddot{\boldsymbol q}_n-\ddot{\boldsymbol q}_{n-1}].\tag{2.32}\]
The shorthand $\dot{\boldsymbol q}_n\equiv M^{-1}\boldsymbol p_n$, $\ddot{\boldsymbol q}_n\equiv M^{-1}F(\boldsymbol q_n)$ has been used.''',
'''def beeman {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (qPrev : Q n) (z : Z n) : Z n :=
  let a := invMass m (F z.1)
  let aPrev := invMass m (F qPrev)
  let q := z.1+h • invMass m z.2+(h^2/6) • ((4 : ℝ) • a-aPrev)
  let p := z.2+(h/6) • mass m ((2 : ℝ) • invMass m (F q)+(5 : ℝ) • a-aPrev)
  (q,p)''',kind='definition',label='Example 2.8 (Beeman’s Algorithm)',context=['需要前两个位置与当前动量；先qnext后F(qnext)，每步只需一个新force。'])
add('BeemanOrder','2.5.5',94,[],'''The order of accuracy of the scheme above can be shown to be three.''',
'''theorem beemanOrder : ∀ n (m : Fin n → ℝ) (F : Q n → Q n)
    (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 1 < ν₀ ∧ ∀ ν ≥ ν₀,
      ∀ z : ℕ → Z n, z 0=γ 0 → z 1=γ (τ/ν) →
        (∀ k, 1 ≤ k → z (k+1)=beeman m F (τ/ν) (z (k-1)).1 (z k)) →
        ∀ k ≤ ν, ‖z k-γ (k*(τ/ν))‖ ≤ C*(τ/ν)^3 := by
  sorry''',extra=['[EXTRA]正固定对角质量，F C⁴；实际紧轨迹，前两步取精确起始值（强于三阶启动）；真实多步递推，保留两坐标误差。'],
issues=[dict(code='ERRATUM?',status='NEEDS_HUMAN',detail='三阶的阶定义需要裁定：单位质量谐振子q=cos t、p=−sin t，从两个精确起点代入原式，一步动量误差首项为−h³/12；全相空间全局三阶与该局部缺陷不一致。保留原文three及完整全局三阶签名，不静默改成二阶。')],
verdict='NEEDS_HUMAN',explanation='原式逐字核对；谐振子局部Taylor诊断显示动量h³缺陷，需导师裁定原文three是局部阶、位置阶还是原书疑误。',
missing='先裁定Beeman阶约定/原书疑误；大型多步全局误差理论亦缺。Taylor与数值诊断不是Lean反例证明。')
EXCLUDED += [dict(printed_page='89–94',pdf_page='111–116',reason='隐式RK效率、PRK一般族文献、Hessian稀疏成本、multistep物理优劣为excluded_qualitative；全部展示算法及阶陈述单列。'),dict(printed_page='94–96',pdf_page='116–118',reason='Exercises标题起所有习题排除；Beeman例及三阶正文在标题前保留。')]

from ch02_data import RECORDS
for r in RECORDS:
    if r['source_id']=='MD-2.5.1-RKSymplectic':
        r['code']='''theorem rkSymplectic : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) ↔
    (∀ n (H : SymplecticCoordinates n → ℝ) (h : ℝ)
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G) := by
  sorry'''
        r.update(local_explanation='完整字面系数判别的充分与普适必要方向都保留；可约/冗余阶段必要性反例资格未裁定，不能只证明充分性冒充整句。')
        r['context_notation']=['“precise condition”按针对所有光滑Hamilton模型的判别表达；一般可约RK的必要性仍有疑点。']
        r['issues'][0]['detail']='原句precise condition需不可约/非退化资格；完整普适iff已保留，冗余RK必要性不能默认为真。'
add('GaussTwoOrder','2.5.1',90,[],r'''The 4th order method ($s=2$) has coefficients''',
'''theorem gaussTwoOrder : ∀ n (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → ContDiff ℝ 6 (Function.uncurry G) →
    (∀ h z, ∃ stages : Fin 2 → Q n,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) stages) →
    globalOrder G γ τ 4 := by
  sorry''',context=['同页GaussTwoData保存全部A、b；此条保存确切2阶段方法全局4阶结论而非仅系数。'],extra=['[EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。'],missing='大型Gauss2阶段局部五阶余项、光滑求解/稳定性及全局阶理论。')
