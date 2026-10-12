"""Hamiltonian Liouville statements: preserve the general domain and actual operators."""
from ch05_data import add,copied,proposition,D,NS
add('HamiltonianDivergence','5.2.3',186,[29],r'''The term $\nabla\cdot f$ vanishes for $f=J\nabla H$.''',copied('MolecularDynamics/Chapter02/HamiltonianVolume.lean','textbookHamiltonianVectorField_divergence_zero','hamiltonianDivergence'),extra=['[EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。'],prior=['MolecularDynamics.textbookHamiltonianVectorField_divergence_zero'])
add('HamiltonianSkewExpression','5.2.3',186,[29],r'''From the above we know that for a smooth scalar function $u=u(z)$, $\mathcal L_f^*u=-\nabla\cdot(uf)=-f\cdot\nabla u-u\nabla\cdot f$. The term $\nabla\cdot f$ vanishes for $f=J\nabla H$. Thus we have $\mathcal L_f^*u=-f\cdot\nabla u=-\mathcal L_fu$. If this holds for all smooth $u$, we write $\mathcal L_f^*=-\mathcal L_f$.''',proposition('hamiltonianSkewExpression_statement'),extra=['[EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。'],missing='待实际Fréchet乘积导数及trace秩一映射短桥，依赖本章LiouvilleProduct；不以含sorryAx证明冒充已证。')
add('HamiltonianDensityPropagation','5.2.3',187,[30],r'''An important consequence of the skew symmetry of $\mathcal L_f$ for a divergence-free system is that the propagator $e^{t\mathcal L_f^*}$ preserves the integral over the whole phase space, i.e.
\[\int_D e^{t\mathcal L_f^*}\rho(z)d\omega=\int_D e^{-t\mathcal L_f}\rho(z)d\omega=\int_D\rho(\mathcal F_{-t}(z))d\omega=\int_D\rho(z)d\omega,\]
since we can view $\mathcal F_{-t}(z)$ as a change of variables by a volume-preserving map.''',f'''theorem hamiltonianDensityPropagation : ∀ n (D : Set ({NS}E n))
    (f : {NS}E n → {NS}E n) Φ (ρ : {NS}E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → {NS}flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,{NS}divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))={NS}measurePropagator Φ t (densityMeasureOn D ρ) := by
  sorry''',extra=['[EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。'],missing='缺当前全实时间实际流的Jacobian/change-of-variables与受限密度测度输运桥接；保留完整陈述，不建设新的连续性PDE理论。')
add('MechanicalLiouvillian','5.2.3',187,[31,32],r'''The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})$ can be written
\[\mathcal L_H^*=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},\]
where $F_i=-\partial U/\partial q_i$.''',copied(D,'mechanicalLiouvillian'),kind='definition',context=['实际相空间Fréchet导数沿(p/m,F)方向的负值，是上述坐标偏导求和；完整原H触发到该表达式的对应另条。'])
add('MechanicalLiouvillianIdentity','5.2.3',187,[31,32],r'''The Liouvillian of a Hamiltonian system with $N_c$ degrees of freedom and a Hamiltonian of the form $H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})$ can be written $\mathcal L_H^*=-\sum_i m_i^{-1}p_i\partial_{q_i}-\sum_iF_i\partial_{p_i}$, where $F_i=-\partial U/\partial q_i$.''',f'''theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : {NS}E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : {NS}Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) ({NS}hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    {NS}mechanicalLiouvillian m (fun q => -gradient U q) u z := by
  sorry''',extra=['[EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。'],missing='待现有规范Hamiltonian二次动能梯度与实际乘积相空间梯度接口桥接；短路线最多3次，不新建理论。')
