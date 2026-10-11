"""Pendulum qualifications and reaction system, PDF172–175."""
from ch04_data import add,copied,proposition
R='MolecularDynamics/Chapter04/ConstrainedReaction.lean'
add('ConstraintDegrees','4.3',151,[100],r'''Note that with $l$ constraints the actual number of degrees of freedom, which is needed for things like the computation of temperature, is $N_d=N_c-l$.''',proposition('constraintDegrees_statement'),extra=['[EXTRA]真实约束导数满射、当前点可微；独立正则约束下切空间是ker Dg，维数关系不作假设。'],missing='待真实导数满射与有限维秩-零化度短桥接。')
add('FlexiblePendulumHamiltonian','4.3',150,[],r'''We suppose the restraint to have an associated coefficient $k=\varepsilon^{-1}$, where $\varepsilon$ is a small parameter. Then we have a generalized flexible pendulum with Hamiltonian $H=\|p\|^2/(2m)+U(q)+\varepsilon^{-1}(\|q\|-r_0)^2/2$.''',
'''def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2''',kind='definition',context=['欧氏Position3及欧氏norm，非Pi最大范数；m>0,ε>0为物理模型资格。'])
add('RestraintPotential','4.3',150,[],r'''where the restraint potential $\varphi_\varepsilon(q)=\varepsilon^{-1}(\|q\|-r_0)^2/2$ has associated restoring force''',
'''def restraintPotential (ε r₀ : ℝ) (q : Position 3) : ℝ :=
  ε⁻¹*(‖q‖-r₀)^2/2''',kind='definition',context=['真实欧氏范数径向势；q=0处径向可微性需另核，不由定义冒充光滑。'])
add('RestraintForcePrinted','4.3',150,[],r'''\[F_\varepsilon=-\nabla\varphi_\varepsilon(q)=\varphi'_\varepsilon(q).\]''',
'''theorem restraintForcePrinted :
    ∀ ε r₀ : ℝ, ∀ q : Position 3,
      -gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q =
       gradient (fun x : Position 3 => ε⁻¹*(‖x‖-r₀)^2/2) q := by
  sorry''',verdict='NEEDS_HUMAN',explanation='原φ′ε(q)未定义；若按通常势导数/梯度理解，末项缺负号且标量径向导数不能直接等向量。本候选签名显式记录该解释，不把疑式当证明。',extra=['[EXTRA]将prime暂按配置梯度解释；该记号解释待审。'],issues=[dict(code='ERRATUM?',detail='Fε=−∇φε=φ′ε的prime含义/负号待裁定；原文不静默更正。')],missing='本地非PASS，等待记号及负号裁定。')
add('ConstrainedPendulum','4.3',151,[],r'''The equations of motion for the constrained system take the form
\[\dot q=v,\qquad\dot v=-\nabla U(q)-q\lambda,\qquad0=\|q\|^2-r_0^2.\]''',
'''def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0''',kind='definition',extra=['原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。'],context=['Gauss法向力Fc=−qλ由本关系保留；不将约束力唯一存在作已证结论。'])
add('ConstraintCurvature','4.3',153,[38],r'''where $\varphi$ is an $l$-dimensional vector whose $k$th component is
\[\varphi_k=p(t)^TM^{-1}\nabla_q^2g_k(q(t))M^{-1}p(t).\]''',copied(R,'textbookConstraintCurvature','constraintCurvature'),kind='definition',context=['真实D²g双线性作用在两个M⁻¹p上；不是任意给定曲率符号。'])
add('ReactionMultiplier','4.3',153,[39],r'''Using (4.8) in (4.10) we obtain
\[g'(q)M^{-1}[F-g'(q)^T\lambda]+\varphi=0.\]
This is a system of linear equations for $\lambda$. Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\lambda$.''',copied(R,'textbookConstrainedReactionMultiplier','reactionMultiplier'),kind='definition',context=['λ为真实Gram逆乘(GM⁻¹F+φ)；矩阵逆的语义资格det≠0在下一定理及Gram性质中明确。'])
add('ReactionBalance','4.3',153,[40],r'''Using (4.8) in (4.10) we obtain
\[g'(q)M^{-1}[F-g'(q)^T\lambda]+\varphi=0.\]''',copied(R,'textbookConstrainedReaction_balance','reactionBalance'),extra=['真实Gram det≠0；F=−grad U是Hamiltonian实例，一般位置力定理提供更强桥接。'],prior=['MolecularDynamics.textbookConstrainedReaction_balance'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['ConstraintDegrees'])
