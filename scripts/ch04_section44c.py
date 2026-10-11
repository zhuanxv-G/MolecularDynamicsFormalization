"""Eight inertia and dipolar-example records; keep printed errors, PDF191–192."""
from ch04_data import add,copied,proposition,D,NS
add('RotationalEnergy','4.4',169,[85],r'''It is convenient to express this in terms of the so-called body angular velocity $\omega_b=\Theta^T\omega$ in which case it becomes $K_{\rm rot}=\frac12\omega_b^TT\omega_b$.''',copied(D,'rotationalEnergy'),kind='definition')
add('InertiaSkewIdentity','4.4',169,[],r'''$T=-\sum_{i=1}^Nm_i\operatorname{skew}(\delta_i(0))^2$.''',f'''theorem inertiaSkewIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → {NS}V),
  {NS}inertiaTensor m δ= -∑ i, m i • ({NS}skewMatrix (δ i))^2 := by
  sorry''',missing='待3×3skew平方与有限和恒等式短证明。')
add('InertiaTracePrinted','4.4',169,[86],r'''This matrix is closely related to the matrix $R$:
\[R=\sum_im_i\delta_i\delta_i^T=\sum_im_i\|\delta_i\|^2I-T=(T_{11}+T_{22}+T_{33})I-T.\tag{4.40}\]''',proposition('inertiaTracePrinted_statement'),verdict='FAIL',explanation='3维trace(T)=2Σm|δ|²，末式系数少1/2，一般不成立。',issues=[dict(code='ERRATUM?',detail='(4.40)末式应trace(T)/2 I−T；原式逐字保留。')],missing='本地FAIL；待网站/导师裁定。')
add('InertiaTraceCorrected','4.4',169,[],r'''$R=\sum_im_i\delta_i\delta_i^T=\sum_im_i\|\delta_i\|^2I-T$.''',proposition('inertiaTraceCorrected_statement'),extra=['[EXTRA]纠正(4.40)末式系数为trace(T)/2；不覆盖原印刷条目。'],missing='待真实有限和trace惯性矩恒等式短证明。')
add('DipolarHamiltonian','4.4','169–170',[],r'''Example 4.1 (Dipolar Molecular Liquid) The Hamiltonian for a more general dipolar system can be written
\[H=K_{\rm rot}(\pi_1,\ldots,\pi_N)+K_{\rm trans}(p_1,\ldots,p_N)+U(q_1,\ldots,q_N,\mu_1,\ldots,\mu_N).\]
The vectors $\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\|\mu_k\|\equiv1$.''',f'''def dipolarHamiltonian {{N : ℕ}} (mass : Fin N → ℝ) (inertia : {NS}V)
    (U : (Fin N → {NS}V) → (Fin N → {NS}V) → ℝ)
    (q p μ π : Fin N → {NS}V) : ℝ :=
  (∑ i, ∑ j, (π i j)^2/(2*inertia j))+(∑ i, {NS}dot (p i) (p i)/(2*mass i))+U q μ''',kind='definition',label='Example 4.1',extra=['所有质量/主惯性矩>0，单位偶极方向为物理约束；N有限。'])
add('DipolarPairPotential','4.4',170,[],r'''The total dipole-dipole interaction potential then takes the form $\varphi^{\rm dip}_{ij}=\varphi^{\rm LJ}(r_{ij})+\mu_i^TL(q_{ij})\mu_j$, with $U$ given as the sum of these over pairs. The $3\times3$ matrix $L$ is given by
\[L(q_{ij})=\frac1{r_{ij}^3}I-\frac3{r_{ij}^5}q_{ij}q_{ij}^T,\qquad q_{ij}=q_i-q_j.\]''',f'''def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : {NS}V) : ℝ :=
  lj r+{NS}dot μ (((r^3)⁻¹ • (1 : {NS}Mat3)-(3/r^5) • {NS}outer q) *ᵥ ν)''',kind='definition',extra=['r=Euclidean距离>0；本条实际pair函数，不声称经验模型准确性。'])
add('DipolarRotationalPrinted','4.4',170,[],r'''Then $K_{\rm rot}=\sum_{i=1}^N\operatorname{Tr}[\dot\Theta_iR\dot\Theta_i^T]$, with $R$ defined in terms of $T=\operatorname{diag}(I_1,I_2,I_3)$ by (4.40).''',f'''def dipolarRotationalPrinted {{N : ℕ}} (R : {NS}Mat3) (dΘ : Fin N → {NS}Mat3) : ℝ :=
  ∑ i, (dΘ i*R*(dΘ i)ᵀ).trace''',kind='definition',verdict='NEEDS_HUMAN',explanation='此处trace和缺1/2，与p168及此页Σπ²/(2I)不一致；且引用错误(4.40)。',issues=[dict(code='ERRATUM?',detail='p170 Ex4.1 trace动能印刷少1/2；R与T关系亦引用疑误式。')])
add('RigidHamiltonian','4.4',170,[87],r'''The Hamiltonian is (for a single rigid body):
\[H_{\rm RB}=\frac{\|p_{\rm cm}\|^2}{2M}+\frac{\operatorname{Tr}[\Pi R^{-1}\Pi^T]}2+U(q_{\rm cm},\Theta),\]
subject to the orthogonality constraint $\Theta^T\Theta=I$.''',copied(D,'rigidHamiltonian'),kind='definition',extra=['M>0、R非奇异是物理资格；正交约束单列在真实ODE关系中；inverse定义不计存在理论。'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['InertiaSkewIdentity','InertiaTraceCorrected'])
