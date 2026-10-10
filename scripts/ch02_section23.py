"""Verbatim §2.3 source text checked on rendered PDF94–104."""
from ch02_data import add,copied,proposition,EXCLUDED
RD='MolecularDynamics/Chapter02/ReviewDefinitions.lean'
SF='MolecularDynamics/Chapter02/SymplecticForm.lean'
SM='MolecularDynamics/Chapter02/SymplecticMaps.lean'
LV='MolecularDynamics/Chapter02/LiouvilleVolume.lean'
HV='MolecularDynamics/Chapter02/HamiltonianVolume.lean'
AV='MolecularDynamics/Chapter02/ActualFlowVariations.lean'
AM='MolecularDynamics/Chapter02/AdjointMethods.lean'
SE='MolecularDynamics/Chapter02/SymplecticEuler.lean'
def d(name):return copied(RD,name,'bp_'+name)
def c(path,name,key=None):return copied(path,name,key or 'bp_'+name.replace('.','_')).replace('ι','(Fin n)')
def err(detail):return [dict(code='ERRATUM?',status='NEEDS_HUMAN',detail=detail)]

add('Divergence','2.3.1',72,[62],r'''the divergence of $f$ vanishes, i.e.
\[\nabla\cdot f=\sum_{i=1}^m\frac{\partial f_i}{\partial z_i}=0.\]''',d('divergence'),kind='definition',context=['div f为实际Jacobian的迹；f C¹。'])
add('Liouville','2.3.1',72,[63],r'''Consider a set of points $S(t)$ in phase space with evolution associated to a differential equation $\dot{\boldsymbol z}=f(\boldsymbol z)$ described by the flow map $\mathcal F_t(S(0))=S(t)$. Liouville’s theorem [16] states that the volume of such a set is invariant with respect to $t$ if the divergence of $f$ vanishes,''',
c(LV,'textbookDivergenceFreeFlow_volume_image_of_jointC2','liouville'),label='Liouville’s theorem',
extra=['[EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。'],prior=['MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2'])
add('HamiltonDivergence','2.3.1',72,[64],r'''It is a simple exercise to show that for a Hamiltonian system the divergence vanishes, since
\[\nabla\cdot f=\sum_{i=1}^{N_c}\frac{\partial^2 H}{\partial q_i\partial p_i}-\sum_{i=1}^{N_c}\frac{\partial^2 H}{\partial p_i\partial q_i}=0,\]
by equality of mixed partials.''',c(HV,'textbookHamiltonianVectorField_divergence_zero','hamiltonDivergence'),extra=['H C²，保证混合偏导对称。'],prior=['MolecularDynamics.textbookHamiltonianVectorField_divergence_zero'])
add('HamiltonVolume','2.3.1',72,[65],'''Thus Hamiltonian systems always have volume preserving flows.''',c(HV,'textbookHamiltonianFlow_volume_image_of_jointC2','hamiltonVolume'),
context=['流为实际Hamilton向量场的解族；完整体积结论覆盖闭时间窗每个t及每个可测S。'],extra=['[EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。'],prior=['MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2'])
add('VolumeChange','2.3.1',73,[66],r'''If we view the map $\mathcal F_t$ as a change of variables, we have
\[\operatorname{Vol}(S(t))=\int_S |D|\,d\omega,\]
where $D=\det\left(\frac{\partial\mathcal F_t}{\partial\boldsymbol z}\right)$.''',proposition('volumeChange_statement'),
extra=['Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。'],missing='Mathlib有限维实空间Jacobian换元定理接口桥接。')
add('VariationalPrinted','2.3.1',73,[67],r'''To understand where Liouville’s theorem comes from, recall that the variational equations of the last chapter are a system of ordinary differential equations for $W(t)=\mathcal F_t'(\boldsymbol z(t))$:
\[\frac{\mathrm dW}{\mathrm dt}=f'(\boldsymbol z(t))W.\]
Thus
\[\dot W W^{-1}=f'(\boldsymbol z(t)).\]''',
'''theorem variationalPrinted : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ))) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ)))⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ)) := by
  sorry''',issues=err('原文W在z(t)取Jacobian，而变分矩阵应在固定初值ζ取Jacobian；沿移动取值点会多一链式项。后式还需要W可逆，局部流可给但不能忽略域。'),verdict='NEEDS_HUMAN',explanation='忠实保留移动取值点及两子句；与正确变分矩阵不同，需导师裁定。',missing='原书取值点裁定；正确固定初值版本库已有jointC²证明。')
add('DeterminantODE','2.3.1',73,[68],r'''Now let $D=\det(W)$. One can show (see Exercise 5) that
\[\frac{\dot D}{D}=\operatorname{tr}(\dot W W^{-1}).\]
This implies that
\[\dot D=\operatorname{div}(f(\boldsymbol z(t)))D,\]''',
c(LV,'textbookMatrixDet_hasDerivAt_of_linearODE','determinantODE'),context=['A(t)=f′(z(t))，tr A=div f(z(t))；W满足上一变分ODE。原文除D的等式需D≠0，当前签名登记未除零的最终D′子句。'],
extra=['矩阵W实际HasDerivAt；一般矩阵线性ODE版本允许奇异W，强于原文可逆情形。'],prior=['MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE'])
add('DeterminantExponential','2.3.1',73,[69],r'''and thus
\[D(t)=D(0)e^{\int_0^t\operatorname{div}(f(\boldsymbol z(s)))\,ds}.\]''',proposition('determinantExponential_statement'),extra=['实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。'],missing='真实矩阵行列式导数与标量积分因子常值证明。')
add('FlowDet','2.3.1',73,[70],r'''In particular, if $\operatorname{div}f\equiv0$, we see that $D\equiv D(0)=1$ and it follows that the volume is constant. Liouville’s theorem may be summarized compactly as:
\[\nabla\cdot f=0\Rightarrow\det\mathcal F_t'=1.\]''',c(LV,'textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2','flowDet'),extra=['[EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。'],prior=['MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2'])
add('LJOscillator','2.3.1','73–74',[],r'''A 1-d oscillator with Lennard-Jones potential is described by the equations
\[\dot q=p,\qquad\dot p=-\varphi_{LJ}'(q).\]''',
'''def ljOscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t''',kind='definition',label='Example 2.3 (model)',context=['φ=第1章Lennard–Jones势，q>0物理位置域；仅定义实际ODE关系。'])
add('LJBoundedPeriodic','2.3.1',74,[],'''As a consequence of energy conservation, any bounded individual trajectory of this system will be a periodic orbit.''',
'''theorem ljBoundedPeriodic : ∀ (σ ε : ℝ) (γ : ℝ → ℝ × ℝ),
    0 < σ → 0 < ε →
    ljOscillatorEquation (fun q => 4*ε*((σ/q)^12-(σ/q)^6)) γ Set.univ →
    (∀ t, 0 < (γ t).1) → Bornology.IsBounded (Set.range γ) →
    ∃ T > 0, ∀ t, γ (t+T) = γ t := by
  sorry''',extra=['LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。'],missing='LJ能级闭曲线/非平衡周期轨道理论；能量守恒本身不足以自动得周期。')
add('LinearDivergence','2.3.2','74–75',[71],r'''Consider a linear differential equation system in $\mathbb R^m$,
\[\dot{\boldsymbol z}=S\boldsymbol z,\]
for some matrix $S\in\mathbb R^{m\times m}$. The condition for the flow of this system to conserve volume is just that the trace of $S$ (which is the divergence of the vector field $f(\boldsymbol z)=S\boldsymbol z$) be zero.''',proposition('linearDivergence_statement'),
context=['div f=tr S；体积结论由Liouville承担，逆向需线性流行列式公式。'],verdict='NEEDS_HUMAN',explanation='当前真实Jacobian迹等式保留充分判别背景，但原文condition暗含充要的流体积结论尚未编码。',missing='线性流体积保存↔tr S=0完整签名及矩阵指数行列式。')
add('LinearEuler','2.3.2',75,[72],r'''Applying Euler’s method to the same system results in
\[\boldsymbol z_{n+1}=\boldsymbol z_n+hS\boldsymbol z_n=(I+hS)\boldsymbol z_n,\]''',d('linearEuler'),kind='definition',context=['S有限实矩阵；I为单位阵。'])
add('EulerVolumePrinted','2.3.2',75,[73],r'''and the condition for Euler’s method to conserve volume is that $\det(I+hS)=1$.''',
'''theorem eulerVolumePrinted : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ (linearEuler S h).det=1 := by
  sorry''',issues=err('体积只要求|det|=1；原文省略正向/足够小步长条件。反射在大步长可保持体积但det=-1。'),verdict='NEEDS_HUMAN',explanation='保留字面det=1判别，不静默改绝对值；需裁定小h方向约定。')
add('EulerVolumeCounterexample','2.3.2',75,[74],'''The conditions for volume preservation by the flow map and its Euler approximation are essentially unrelated. Thus Euler’s method does not in general conserve phase space volume (it conserves volume only in very special cases—see Exercise 6).''',
proposition('eulerVolumeCounterexample_statement',proof='exact MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved'),prior=['MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved'],
explanation='二维旋转矩阵tr S=0而det(I+hS)=1+h²，对任意非零h大于1；已证具体反例表达does not in general。')
add('AsymmetricEuler','2.3.2',75,[75],r'''the asymmetrical variant of Euler’s method defined by
\[u_{n+1}=u_n+hf(u_{n+1},v_n),\qquad v_{n+1}=v_n+hg(u_{n+1},v_n).\]''',d('asymmetricEulerRelation'),kind='definition',context=['u′=f(u,v)，v′=g(u,v)；divergence free为fu+gv=0；只定义隐式关系，不宣称全球求解器。'])
add('AsymmetricJacobian','2.3.2',75,[76],r'''Solving for the various entries we have
\[\mathcal G_h'=\begin{bmatrix}1/(1-hf_u)&hf_v/(1-hf_u)\\hg_u/(1-hf_u)&1+hg_v+h^2g_uf_v/(1-hf_u)\end{bmatrix},\]
and calculating the determinant of the Jacobian results in
\[\det\mathcal G_h'=\frac{1+hg_v}{1-hf_u}.\]''',proposition('asymmetricDet_statement'),extra=['f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。'],
verdict='NEEDS_HUMAN',explanation='现有签名仅保留行列式子句，原文完整Jacobian四个条目仍需并入；不能把子结论冒充整条。',missing='实际隐式关系求导及完整四条矩阵项。')
add('AsymmetricArea','2.3.2','75–76',[77],r'''In the event that the vector field is divergence free, we have $f_u+g_v=0$ which implies that the numerator and denominator are identical, and it follows that $\det\mathcal G_h'=1$. Thus the asymmetric variant of the Euler method is area preserving, even though the standard Euler method is not.''',proposition('asymmetricArea_statement'),extra=['f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。'],missing='实际隐式求导；若全局area保持还须单射局部域与换元。')
add('SymplecticMap','2.3.3',76,[78],r'''Let $m=2N_c$. A symplectic map $\Phi:\mathbb R^m\to\mathbb R^m$ is one that preserves the symplectic differential 2-form. The simplest way to write this is as the following algebraic condition on the Jacobian matrix of $\Phi$:
\[\Phi'^TJ\Phi'=J.\]''',copied(SM,'IsTextbookSymplecticMap','bp_IsSymplecticMap'),kind='definition',context=['m=2Nc，Jacobian是真实Fréchet导数矩阵；J=[[0,I],[-I,0]]，p.53/PDF75；资格Differentiable。'])
add('OneForm','2.3.3',76,[79],r'''A 1-form $\alpha$ defined on $\mathbb R^m$ is a family of linear mappings from $\mathbb R^m$ to $\mathbb R$, defined for each point of $\mathbb R^m$. Let $\boldsymbol a:\mathbb R^m\to\mathbb R^m$, then we may define a one-form associated to this vector by $\alpha(\boldsymbol x)(\boldsymbol\xi)=\boldsymbol a(\boldsymbol x)^T\boldsymbol\xi$.''',
'''def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ''',kind='definition',context=['有限维线性泛函自动连续；a(x)对应线性泛函的坐标表示。'])
add('Differential','2.3.3',76,[80],r'''The differential of a function $g:\mathbb R^m\to\mathbb R$, denoted $dg$, is a family of linear mappings (one for each point in phase space) from vectors $\boldsymbol\xi\in\mathbb R^m$ into the reals defined by
\[dg(\boldsymbol q,\boldsymbol p)(\boldsymbol\xi)=\nabla g(\boldsymbol q,\boldsymbol p)^T\boldsymbol\xi.\]''',d('differential'),kind='definition',context=['实际fderiv；有限维导数=梯度与方向内积。'])
add('CoordinateDifferentials','2.3.3',76,[81],r'''So, denoting the $i$th position coordinate by $q_i$, we have $dq_i(\boldsymbol\xi)=\xi_i$; the differential is thus an example of a 1-form.''',
'''def coordinateDifferentials (n : ℕ) :
    (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) × (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) :=
  (textbookDq,textbookDp)''',kind='definition',context=['dp_i(ξ)=ξ_(i+Nc)由p.77/PDF99同页楔积式补齐；坐标分拆按Sum.inl/inr。'])
add('Wedge','2.3.3',76,[82],r'''It is written $\alpha\wedge\beta$ and is defined, for vectors $\boldsymbol\xi,\boldsymbol\eta\in\mathbb R^m$ by
\[\alpha\wedge\beta(\boldsymbol\xi,\boldsymbol\eta)=\alpha(\boldsymbol\xi)\beta(\boldsymbol\eta)-\alpha(\boldsymbol\eta)\beta(\boldsymbol\xi).\]''',copied(SF,'textbookWedgeOneForms','bp_wedge'),kind='definition',context=['在固定底点取1-form的两个线性泛函；双线性反对称。'])
add('SymplecticForm','2.3.3',77,[83],r'''Summing these terms results in the symplectic 2-form, denoted $\psi_S$:
\[\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.\]''',copied(SF,'textbookSymplecticForm','bp_symplecticForm'),kind='definition',context=['J^(i)仅(i,i+Nc)=1、(i+Nc,i)=-1；教材J同p.53/PDF75。'])
add('FormSumWedges','2.3.3',77,[84],r'''The wedge product of the coordinate differentials $dq_i,dp_i$ may be written
\[dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\xi_i\eta_{i+N_c}-\xi_{i+N_c}\eta_i=\boldsymbol\xi^TJ^{(i)}\boldsymbol\eta.\]
Summing these terms results in the symplectic 2-form, denoted $\psi_S$:
\[\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^TJ\boldsymbol\eta.\]''',c(SF,'textbookSymplecticForm_eq_sum_wedges','formSumWedges'),prior=['MolecularDynamics.textbookSymplecticForm_eq_sum_wedges'],context=['J^(i)单项坐标矩阵公式来自dq/dp真实定义，和式为完整最终结论。'])
add('GeneralTwoForm','2.3.3',77,[85],r'''In general, a differential 2-form $\psi$ is represented in coordinates by
\[\psi_{\boldsymbol z}=\sum_{i,j}a_{ij}(\boldsymbol z)\,dz_i\wedge dz_j,\]
with matrix of coefficients $A(\boldsymbol z)=(a_{ij}(\boldsymbol z))$.''',
'''def coefficientTwoForm {n : ℕ} (A : Q n → Matrix (Fin n) (Fin n) ℝ)
    (z u v : Q n) : ℝ :=
  ∑ i, ∑ j, A z i j * (u i*v j-v i*u j)''',kind='definition',
issues=err('双和系数A的实际双线性矩阵是A-Aᵀ；若A反对称为2A。后文直接用A作矩阵表示存在因子约定疑点。'),verdict='NEEDS_HUMAN',explanation='逐字保留双和系数定义，不静默除2或假设已归一；后文矩阵解释需裁定。')
add('PullbackOne','2.3.3',77,[86],r'''It is written $\Phi^*\psi$, so
\[(\Phi^*\psi_{\boldsymbol z})(\boldsymbol\xi)=\psi_{\Phi(\boldsymbol z)}(\Phi'(\boldsymbol z)\boldsymbol\xi).\]''',d('pullbackOne'),kind='definition',context=['Φ′为实际fderiv；底点在Φ(z)取值，非z。'])
add('PullbackTwo','2.3.3',77,[87],r'''The pull-back of a differential 2-form $\psi_1\wedge\psi_2$ is consequently defined as
\[\Phi^*(\psi_1\wedge\psi_2)=(\Phi^*\psi_1)\wedge(\Phi^*\psi_2).\]''',d('pullbackTwo'),kind='definition',context=['两个方向都用Φ′(z)作用，底点Φ(z)；楔积乘法性为定义的双线性展开。'])
add('PullbackMatrix','2.3.3','77–78',[88],r'''Given a differential 2-form $\psi_{\boldsymbol z}$ represented by the matrix $A(\boldsymbol z)=(a_{ij}(\boldsymbol z))$, the pull-back of $\psi_{\boldsymbol z}$ under $\Phi$ is defined by
\[\Phi^*\psi_{\boldsymbol z}=\sum_{ij}b_{ij}(\boldsymbol z)dz_i\wedge dz_j,\]
where the matrix $B(\boldsymbol z)=(b_{ij}(\boldsymbol z))$ is related to $A(\boldsymbol z)$ by
\[B(\boldsymbol z)=\Phi'^T(\boldsymbol z)A(\Phi(\boldsymbol z))\Phi'(\boldsymbol z).\]''',proposition('pullbackMatrix_statement'),context=['矩阵A在Φ(z)取值；系数双和归一问题另见GeneralTwoForm。'],missing='真实Jacobian转置/矩阵乘积与双线性拉回的坐标代数。')
add('PreservesForm','2.3.3',78,[89],r'''We say that a 2-form $\psi$ is conserved under mapping $\Phi$ if
\[\Phi^*\psi=\psi.\]
In coordinates, the conservation of the 2-form represented by matrix $A$ under a mapping $\Phi$ means that
\[\Phi'^TA\Phi'=A.\]''',d('preservesTwoForm'),kind='definition',
issues=err('一般位置相关A的守恒式应DΦ(z)ᵀA(Φ(z))DΦ(z)=A(z)；原文省略底点，若只针对常矩阵才无歧义。'),verdict='NEEDS_HUMAN',explanation='拉回定义保留实际底点，原文简写矩阵式是否只指常系数需导师裁定。')
add('SymplecticIffForm','2.3.3',78,[90],r'''In the particular case of the symplectic 2-form $\psi_S$, we have $A=J$, and the following condition for conservation under the mapping $\Phi$
\[\Phi'^TJ\Phi'=J.\tag{2.17}\]
A map that conserves the symplectic 2-form, or, in coordinates, satisfies (2.17), is termed a symplectic map.''',c(SM,'isTextbookSymplecticMap_iff_preserves_form','symplecticIffForm'),prior=['MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form'])
add('SymplecticDet','2.3.3',78,[91],r'''Taking the determinant of both sides of (2.17), we have
\[\det(\Phi'^TJ\Phi')=\det(J)\Rightarrow\det(\Phi'^T)\det(J)\det(\Phi')=\det(J),\]
hence
\[\det(\Phi')^2=1,\]
so $|\det(\Phi')|=1$.''',
'''theorem symplecticDet {n : ℕ} (A : SymplecticCoordinateMatrix n) (hA : IsTextbookSymplectic A) :
    A.det^2=1 ∧ |A.det|=1 := by
  exact ⟨hA.det_square,hA.abs_det⟩''',prior=['MolecularDynamics.IsTextbookSymplectic.det_square','MolecularDynamics.IsTextbookSymplectic.abs_det'],context=['A=实际Φ′；J可逆由标准块矩阵定义。'])
add('HamiltonDet','2.3.3',78,[92],r'''If the system is Hamiltonian, the map is symplectic for all $t$, and the determinant will be a continuous function of $t$, so the cases of interest have $\det(\mathcal F_t')=+1$. The flow map of a Hamiltonian system is volume preserving.''',c(AV,'textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2','hamiltonDet'),extra=['[EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。'],prior=['MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2'])

add('Hessian','2.3.4',79,[93],r'''where $S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))$ is a symmetric matrix.''',copied('MolecularDynamics/Chapter02/HamiltonianVariational.lean','textbookHamiltonianHessian','bp_hessian'),kind='definition',context=['S为沿实际轨迹取值的Hessian；对称结论另项保留。'])
add('HessianSymmetry','2.3.4',79,[94],r'''where $S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))$ is a symmetric matrix.''',c('MolecularDynamics/Chapter02/HamiltonianVariational.lean','textbookHamiltonianHessian_isSymm','hessianSymmetry'),extra=['H在所取点C²，混合偏导相等。'],prior=['MolecularDynamics.textbookHamiltonianHessian_isSymm'])
add('HamiltonVariationalPrinted','2.3.4',79,[95],r'''For the Hamiltonian system $\dot{\boldsymbol z}=J\nabla H(\boldsymbol z)$, these take the form:
\[\dot W=JS(t)W,\]
where $S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))$ is a symmetric matrix.''',
'''theorem hamiltonVariationalPrinted : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t := by
  sorry''',context=['同页后段W(t)=F′t(z(t,ζ))字面采用移动点；S=Hessian在轨迹点。'],issues=err('与p.73一样W应在固定初值ζ求导；原页后文明确W(t)=F′t(z(t,ζ))，本条保留该字面W。'),verdict='NEEDS_HUMAN',explanation='原文移动取值点与变分方程冲突；不静默改成固定ζ。',missing='原书W取值点裁定；固定初值真实流版本已有证明。')
add('MatrixCancellation','2.3.4',79,[96],r'''Computing
\[W^TJ\dot W=W^TJ^2SW=-W^TSW,\]
whereas
\[\dot W^TJW=W^TS^TJ^TJW=W^TSW,\]
hence
\[\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.\]''',c('MolecularDynamics/Chapter02/HamiltonianVariational.lean','hamiltonian_variational_matrix_cancellation','matrixCancellation'),context=['W′=JSW由前项背景；本条矩阵恒等式两个乘积项之和为0，实际乘积求导见FormConstant。'],extra=['S对称；任意矩阵W。'],prior=['MolecularDynamics.hamiltonian_variational_matrix_cancellation'])
add('FormConstant','2.3.4',79,[97],r'''This means that $W^TJW$ is a constant matrix.''',c('MolecularDynamics/Chapter02/HamiltonianVariational.lean','hamiltonian_variational_form_constant','formConstant'),extra=['S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。'],prior=['MolecularDynamics.hamiltonian_variational_form_constant'])
add('HamiltonSymplectic','2.3.4',79,[98],r'''hence
\[W^TJW\equiv W(0)^TJW(0)=J.\]
This proves that the flow map of a Hamiltonian system is a symplectic map.''',c(AV,'textbookHamiltonianFlow_isSymplectic_of_jointC2','hamiltonSymplectic'),
context=['原文W移动取值点疑点另项记录；本最终结论以实际固定时刻流映射的Jacobian表达，不假设其变分方程。'],extra=['[EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。'],prior=['MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2'])
add('ChainRule','2.3.5',79,[99],r'''Let $\Phi_1$ and $\Phi_2$ be any pair of symplectic maps. Then
\[(\Phi_1\circ\Phi_2)'=\Phi_1'\Phi_2',\]
by the chain rule,''',c(SM,'textbookJacobian_comp','chainRule'),extra=['两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。'],issues=[dict(code='OMITTED_EVALUATION_POINT',status='NEEDS_HUMAN',detail='原文Φ₁′Φ₂′未写外导数的Φ₂(z)取值点；Lean用正确链式法则，需审校确认简写约定。')],prior=['MolecularDynamics.textbookJacobian_comp'])
add('SymplecticComposition','2.3.5',79,[100],'''Thus the composition of any pair of symplectic maps is a symplectic map.''',c(SM,'IsTextbookSymplecticMap.comp','symplecticComposition'),prior=['MolecularDynamics.IsTextbookSymplecticMap.comp'])
add('SymplecticInverse','2.3.5',79,[101],r'''and the inverse of a symplectic map is symplectic since $\Phi'^TJ\Phi'=J$ implies $J=\Phi'^{-T}J\Phi'^{-1}$.''',c(SM,'IsTextbookSymplecticEquiv.symm','symplecticInverse'),extra=['[EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。'],prior=['MolecularDynamics.IsTextbookSymplecticEquiv.symm'])
add('GlobalGroupPrinted','2.3.5',79,[102,103],r'''The determinant of a symplectic map is $\pm1$, hence these maps are always invertible, and the inverse of a symplectic map is symplectic since $\Phi'^TJ\Phi'=J$ implies $J=\Phi'^{-T}J\Phi'^{-1}$. Thus the symplectic maps form a group under composition.''',
'''theorem globalGroupPrinted : ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n),
    IsTextbookSymplecticMap Φ → Function.Bijective Φ ∧
      IsTextbookSymplecticMap (Function.invFun Φ) := by
  sorry''',issues=err('Jacobian可逆仅推出局部可逆，不能推出任意辛映射全球双射；正确群是给定全球辛微分同胚。'),verdict='NEEDS_HUMAN',explanation='字面全球逆与逆辛性两个结论保留；不偷偷加入全球双射为假设。',missing='原书全球逆断言裁定；正确微分同胚群接口已有。')
add('SymplecticIntegrator','2.3.6',80,[104],'''A symplectic integrator is an approximation of the flow map that conserves the symplectic 2-form.''',d('symplecticIntegrator'),kind='definition',context=['G为给定单步方法；精度资格在前节另行定义；每个可用h步映射保辛。'])
add('SymplecticEuler','2.3.6',80,[105],r'''The following scheme is a slight modification of the Euler method.
\[\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\tag{2.18}\]
\[\boldsymbol P=\boldsymbol p+hF(\boldsymbol q).\tag{2.19}\]''',copied(SE,'textbookSymplecticEuler','bp_symplecticEuler'),kind='definition',context=['固定对角质量，F=-∇U；先P后Q；原文explicit不等于声称隐式法解存在。'])
add('KickDifferential','2.3.6',81,[106],r'''then
\[dQ_i=dq_i+hm_i^{-1}dP_i,\tag{2.20}\]
\[dP_i=dp_i-h\sum_{j=1}^{N_c}\frac{\partial^2U}{\partial q_j\partial q_i}dq_j.\tag{2.21}\]''',c(SE,'textbookJacobian_momentumKick','kickDifferential'),
context=['P来自kick；Q来自随后position drift；本现有签名只给kick Jacobian，Q微分另需并入。'],extra=['U C²，实际Hessian。'],verdict='NEEDS_HUMAN',explanation='原文Q与P两个微分子句都需编码；现签名仅kick矩阵，暂不批准或证明。',missing='将drift微分dQ=dq+hM⁻¹dP与kick完整合并。')
add('WedgeSelf','2.3.6',81,[107],r'''but $du\wedge du\equiv0$ for any $u$,''',proposition('wedgeSelf_statement',proof='exact MolecularDynamics.Chapter02Review.wedgeSelf_proved'),prior=['MolecularDynamics.Chapter02Review.wedgeSelf_proved'])
add('SymplecticEulerPreserves','2.3.6',81,[108],r'''This implies that
\[\sum_{i=1}^{N_c}dQ_i\wedge dP_i=\sum_{i=1}^{N_c}dq_i\wedge dp_i,\]
which means that the method is symplectic.''',c(SE,'textbookSymplecticEuler_isSymplectic','symplecticEulerPreserves'),extra=['U C²，固定对角质量；真实完整步映射。'],prior=['MolecularDynamics.textbookSymplecticEuler_isSymplectic'])
add('Adjoint','2.3.7',81,[109],r'''Given any numerical integrator $\mathcal G_h$, consider the map
\[\mathcal G_h^*=\mathcal G_{-h}^{-1}.\]''',copied(AM,'textbookAdjointMethod','bp_adjoint'),kind='definition',extra=['[EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。'])
add('FlowSelfAdjoint','2.3.7',82,[110],r'''For the flow map $\mathcal F_h$, we know that the inverse map is precisely $\mathcal F_{-h}$, so $\mathcal F_h^*=\mathcal F_h$, i.e. the flow map is in the normal sense “self-adjoint,” i.e. symmetric.''',c(AM,'textbookFlowMethod_isSelfAdjoint','flowSelfAdjoint'),extra=['[EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。'],prior=['MolecularDynamics.textbookFlowMethod_isSelfAdjoint'])
add('BackwardEuler','2.3.7',82,[111],r'''The adjoint method is defined by
\[\boldsymbol Z=\boldsymbol z+hf(\boldsymbol Z),\]
and where the first was explicit, the second is implicit (it is the so-called backward Euler method).''',d('backwardEulerRelation'),kind='definition',context=['只给隐式关系，不把全球唯一解作未证事实。'])
add('EulerAdjoint','2.3.7',82,[112],r'''In particular, consider Euler’s method
\[\boldsymbol Z=\boldsymbol z+hf(\boldsymbol z).\]
The adjoint method is defined by
\[\boldsymbol Z=\boldsymbol z+hf(\boldsymbol Z),\]''',c(AM,'euler_adjoint_iff_backward','eulerAdjoint'),extra=['[EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。'],prior=['MolecularDynamics.euler_adjoint_iff_backward'])
add('AdjointSymplecticEuler','2.3.7',82,[113],r'''Its adjoint method has a similar structure:
\[\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\tag{2.22}\]
\[\boldsymbol P=\boldsymbol p+hF(\boldsymbol Q).\tag{2.23}\]''',copied(AM,'textbookAdjointSymplecticEuler','bp_adjointSymplecticEuler'),kind='definition',context=['实际辛Euler可逆，逆负步得到drift再kick；定义体与两个坐标式一致。'])
add('AdjointInvolution','2.3.7',82,[114],r'''the adjoint of the adjoint is the original method:
\[\mathcal G_h^{**}=[\mathcal G_{-h}^*]^{-1}=[\mathcal G_h^{-1}]^{-1}=\mathcal G_h.\]''',c(AM,'textbookAdjointMethod_involutive','adjointInvolution'),extra=['实际可逆步方法族Equiv.Perm；负步及双逆确实存在。'],prior=['MolecularDynamics.textbookAdjointMethod_involutive'])
EXCLUDED += [dict(printed_page='71–72',pdf_page='93–94',reason='几何积分动机与指向第3章的修正能量说明为excluded_qualitative；此处不开展第3章理论。'),
 dict(printed_page='74',pdf_page='96',reason='图2.6初始圆盘与能量数值区间为示例观察，excluded_qualitative；LJ模型与bounded→periodic陈述另列。'),
 dict(printed_page='80–82',pdf_page='102–104',reason='辛积分历史与软件实现说明为excluded_qualitative；实际映射公式另列。')]

# Non-PASS signatures are never used for a new proof.
from ch02_data import RECORDS
for r in RECORDS:
    if r['source_id']=='MD-2.3.6-KickDifferential':
        r['code']='''theorem kickDifferential : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    ContDiff ℝ 2 U → ∀ ξ : SymplecticCoordinates n, ∀ i : Fin n,
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inl i) =
        ξ (Sum.inl i)+h*(m i)⁻¹*((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) ∧
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) =
        ξ (Sum.inr i)-h*((fderiv ℝ (grad U) (z ∘ Sum.inl)) (ξ ∘ Sum.inl)) i := by
  sorry'''
        r.update(local_verdict='PASS',local_explanation='完整实际辛Euler步映射的两个坐标微分子句；grad U的真实导数即Hessian，不以任意矩阵代替。',missing='完整步映射Fréchet导数与kick/drift组合的坐标整理。')
        r['context_notation']=['P来自kick，Q来自position drift；dP/dQ是完整步映射实际Fréchet导数。']
    if r['source_id']=='MD-2.3.2-LinearDivergence':
        r['code']='''theorem linearDivergence : ∀ n (S : Matrix (Fin n) (Fin n) ℝ)
    (Φ : ℝ × Q n → Q n), ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t z, HasDerivAt (fun s => Φ (s,z)) (S.mulVec (Φ (t,z))) t) →
    (∀ z, divergence S.mulVec z=S.trace) ∧
    ((∀ t, ∀ T : Set (Q n), MeasurableSet T →
      volume ((fun z => Φ (t,z)) '' T)=volume T) ↔ S.trace=0) := by
  sorry'''
        r.update(local_verdict='PASS',local_explanation='完整div=tr S及实际线性流所有可测集合体积保存↔tr S=0；未仅以迹等式替换流体积结论。',extra_assumptions=['[EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。'],missing='线性流行列式指数公式及体积换元的必要/充分方向。')
    if r['source_id']=='MD-2.3.2-AsymmetricJacobian':
        r['code']=proposition('asymmetricDet_statement').replace('(textbookCoordinateJacobian Ψ z).det =', '''(textbookCoordinateJacobian Ψ z) =
        !![(1/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) : ℝ),
          h*deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0));
          h*deriv (fun u => g u (z 1)) (Ψ z 0)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)),
          1+h*deriv (g (Ψ z 0)) (z 1)+h^2*deriv (fun u => g u (z 1)) (Ψ z 0)*
            deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))] ∧
      (textbookCoordinateJacobian Ψ z).det =''')
        r.update(local_verdict='PASS',local_explanation='完整Jacobian四条矩阵项与行列式，实际偏导统一在(U,v)取值。',missing='隐式实际关系的求导、分母非零解导数及2×2矩阵整理。')
    if r['source_id']=='MD-2.3.2-AsymmetricArea':
        r['code']=proposition('asymmetricArea_statement').replace(
          '    ∀ z, (textbookCoordinateJacobian Ψ z).det = 1',
          '''    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T)''')
        r['extra_assumptions'].append('[EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。')
        r.update(local_explanation='实际Jacobian1与所有可测集合面积保持两个结论均保留。')
    if r['source_id']=='MD-2.3.1-DeterminantODE':
        r['code']='''theorem determinantODE : ∀ n (A W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    HasDerivAt W (A t * W t) t → (W t).det ≠ 0 →
    HasDerivAt (fun s => (W s).det) ((A t).trace*(W t).det) t ∧
      deriv (fun s => (W s).det) t/(W t).det =
        Matrix.trace ((A t*W t)*(W t)⁻¹) := by
  intro n A W t hW hdet
  have hd := MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE W (A t) t hW
  refine ⟨hd,?_⟩
  rw [hd.deriv, mul_div_cancel_right₀ _ hdet, Matrix.mul_assoc,
    Matrix.mul_nonsing_inv _ (isUnit_iff_ne_zero.mpr hdet), Matrix.mul_one]'''
        r['extra_assumptions']=['实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。']
        r.update(local_explanation='同时保留D实际导数及D′/D=tr(Wdot W⁻¹)，不遗漏原文除法子句。')
    if r['source_id']=='MD-2.3.1-VolumeChange':
        r['code']=proposition('volumeChange_statement',proof='''intro n Φ S hΦ hinj hS
  have hd : ∀ z ∈ S, HasFDerivWithinAt Φ (fderiv ℝ Φ z) S z := by
    intro z hz
    exact (hΦ.differentiable_one z).hasFDerivAt.hasFDerivWithinAt
  have hcv := lintegral_abs_det_fderiv_eq_addHaar_image
    (volume : Measure (Q n)) hS hd hinj.injOn
  have heq : ∀ z, (fderiv ℝ Φ z).det=(textbookCoordinateJacobian Φ z).det := by
    intro z
    change LinearMap.det (fderiv ℝ Φ z).toLinearMap=_
    rw [← LinearMap.det_toMatrix']
    rfl
  simpa only [heq] using hcv.symm''')
        r.update(missing=None)
    if r['source_id']=='MD-2.3.3-PullbackMatrix':
        r['code']=proposition('pullbackMatrix_statement',proof='''intro n Φ A z u v
  rw [← textbookCoordinateJacobian_mulVec Φ z u,
    ← textbookCoordinateJacobian_mulVec Φ z v]
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
    Matrix.dotProduct_transpose_mulVec]
  exact dotProduct_comm _ _''')
        r.update(missing=None)
    if r['source_id']=='MD-2.3.3-HamiltonDet':
        r['code']='''theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S) := by
  constructor
  · exact MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 H hH Φ hΦ τ hODE hinit
  · exact MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 H hH Φ hΦ τ hODE hinit'''
        r['priors'].append('MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2')
        r['context_notation']=['同时保留真实流Jacobian det=1及所有可测集合体积保存，不遗漏原文最后一句。']
