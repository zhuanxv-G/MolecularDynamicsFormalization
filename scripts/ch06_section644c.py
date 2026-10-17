"""Inactive draft: complete corrected Lyapunov calculation and the literal bracket family."""
from ch06_data import add,copied,D,NS,RECORDS
F='MolecularDynamics/Chapter06/LangevinLyapunov.lean'
add('HamiltonianPowerGenerator','6.4.4','253–254',[102,105],r'''Computing the generator of Langevin dynamics as
\[\mathcal L_{LD}f=p\cdot\nabla_qf-\nabla U(q)\cdot\nabla_pf-\gamma p\cdot\nabla_pf+\gamma k_BT\Delta_pf,\]
we can see that $\mathcal L_H\varphi=0$. Hence
\[\mathcal L_{LD}\varphi=-\gamma p\cdot\nabla_p\varphi+\gamma k_BT\Delta_p\varphi.\]''',copied(F,'textbookLangevinHamiltonianPower_differentialOperator','hamiltonianPowerGenerator'),extra=['[EXTRA]实际全坐标一二阶导数与完整H^l，现成通用σ算子取σ=√(2γkBT)使σ²/2=γkBT；不是给定目标导数再改写。物理热参数代入在下一完整Lyapunov桥接实际出现。'],prior=['MolecularDynamics.textbookLangevinHamiltonianPower_differentialOperator'])
add('LaplacianBoundCorrect','6.4.4',253,[103,104],r'''\[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]''',copied(F,'textbookLangevinHamiltonianPower_momentum_laplacian_bound','laplacianBoundCorrect'),extra=['[EXTRA]修正上界系数为2l(l−1)+Nc l；原错误l(l+Nc−1)另列NEEDS，未静默更换JSON原句。'],prior=['MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian_bound'])
add('LyapunovYoungBounds','6.4.4',253,[105],r'''As $H^l$ grows faster than $H^{l-1}$, for any fixed $l$ we are able to find positive constants $c$ and $d$ such that
\[l(l+N_c-1)H^{l-1}\le\tfrac l2H^l+c;\qquad 2lH^{l-1}U(q)<2lH^{l-1}U_{\max}\le\tfrac l2H^l+d.\]''','''theorem lyapunovYoungBounds : ∀ (l n : ℕ) (Umax : ℝ), 1 ≤ l → 1 ≤ Umax →
  ∃ c d : ℝ, 0 < c ∧ 0 < d ∧ ∀ H : ℝ, 1 ≤ H →
    ((l : ℝ)*((l : ℝ)+(n : ℝ)-1)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) ∧
    (2*(l : ℝ)*H^(l-1)*Umax ≤ (l : ℝ)/2*H^l+d) ∧
    ((2*(l : ℝ)*((l : ℝ)-1)+(n : ℝ)*l)*H^(l-1) ≤ (l : ℝ)/2*H^l+c) := by
  sorry''',extra=['[EXTRA]完整同时覆盖原两个标量界与修正系数界，常数可依赖l/n/Umax但不依赖H；H≥1来自已归一物理势。原U(q)<Umax一环需选择严格外界，本条没有从≤假推出<。'],issues=['原中间严格U上界需要Umax选严格外界；原错误Laplacian系数不能由这些正确标量估计证明。'],missing='待基本实数正幂的大/小H分情况估计短桥；不建设新大型理论。')
add('LangevinLyapunov','6.4.4','253–254',[105],r'''giving
\[\mathcal L_{LD}\varphi\le-2\gamma l\varphi+2\gamma lH^{l-1}U(q)+\gamma k_BT l(l+N_c-1)H^{l-1}
\le-\gamma l\varphi+\gamma k_BT c+\gamma d
=-\alpha\varphi+\delta,\]
satisfying Assumption 2. The purpose of using the $l$ exponent in the Lyapunov function is to ensure that we can apply the theorem to a wide enough class of observables, as (6.48) is only valid for functions $f$ with magnitude less than or equal to the Lyapunov function.''',copied('MolecularDynamics/Chapter06/LangevinPeriodicLyapunov.lean','textbookLangevinPeriodicHamiltonianPower_physical_lyapunov','langevinLyapunov'),extra=['[EXTRA]实际单位质量周期模型、归一U≥1、γ/β>0及l≥1；完整正性/紧子水平集/无穷远proper/正δ全域线性恢复界，采用真实更正系数2。原证明计算的错系数仍按原句保留；不是整个Thm6.2或canonical invariance桥接。'],prior=['MolecularDynamics.textbookLangevinPeriodicHamiltonianPower_physical_lyapunov'])
add('LieBracket','6.4.4',254,[106],r'''The Lie bracket of a pair of vector fields $u(z),v(z)$ is another vector field
\[[u,v]=v'u-u'v;\]
where $u'$ is the Jacobian matrix of the vector field $u$. In coordinates, if we let $w=[u,v]$, then the coordinates of $w$ are
\[w_i=\sum_{j=1}^m\left(u_j\frac{\partial v_i}{\partial z_j}-v_j\frac{\partial u_i}{\partial z_j}\right).\]''',copied(D,'lieBracket').replace('(a b : ℝ)','(a b : ℝ)').replace(': V n → V n :=',': V n → V n :='),kind='definition',extra=['[EXTRA]实际Fréchet导数括号，具体性质/迭代均要求适当可微字段；其通用辅助函数的非可微总化值不作经典Jacobian解释。有限坐标式由真实fderiv在basis上取分量。'])
add('LieBracketProperties','6.4.4',254,[107],r'''The Lie bracket is bilinear and skew symmetric, and the Lie bracket of any vector field with itself is zero.''','''theorem lieBracketProperties : ∀ {n : ℕ} (u v w : (Fin n → ℝ) → (Fin n → ℝ)) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (MolecularDynamics.Chapter06Review.lieBracket (fun x ↦ a • u x+b • v x) w =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u w x+b • MolecularDynamics.Chapter06Review.lieBracket v w x) ∧
  (MolecularDynamics.Chapter06Review.lieBracket u (fun x ↦ a • v x+b • w x) =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u v x+b • MolecularDynamics.Chapter06Review.lieBracket u w x) ∧
  MolecularDynamics.Chapter06Review.lieBracket u v = -MolecularDynamics.Chapter06Review.lieBracket v u ∧
  MolecularDynamics.Chapter06Review.lieBracket u u=0 := by
  sorry''',extra=['[EXTRA]全部双槽线性、skew及自身零明确，真实全域可微资格；不只保存某一固定字段或单槽例子。'],missing='待Mathlib真实VectorField括号线性/反对称的完整短包装。')
add('Definition61','6.4.4',254,[108],r'''Definition 6.1 The SDE satisfies Hörmander's condition at a point $X\in D$ if the linear span of the vector fields $b_0,b_1,\ldots,b_S$ and their repeated commutators evaluated at $X$ spans $\mathbb R^m$.''','''def definition61 {m S : ℕ} (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ)))
    (x : Fin m → ℝ) : Prop :=
  (∀ i, ContDiff ℝ ∞ (b i)) ∧ textbookHormanderAt (Set.range b) x''',kind='definition',label='Definition 6.1',extra=['[EXTRA]Fin(S+1)完整包含原drift b0与全部噪声，实际无限次括号及实span；明确C∞字段资格。保留原定义含b0，不冒充一般parabolic噪声生成条件；具体Langevin rank另证。'])
fields=copied('MolecularDynamics/Chapter06/LangevinHormander.lean','textbookLangevinDrift','langevinDrift')
fields=fields.replace('(γ : ℝ)', '(γ : ℝ) (_hU : ContDiff ℝ ∞ U)',1)
fields+='\n\n'+copied('MolecularDynamics/Chapter06/LangevinHormander.lean','textbookLangevinNoise','langevinNoise')
add('LangevinFields','6.4.4',255,[109],r'''For Langevin dynamics we have
\[b_0=\begin{bmatrix}p\\-\nabla U(q)-\gamma p\end{bmatrix};\qquad b_i=\sigma\begin{bmatrix}0\\e_i\end{bmatrix},\quad i=1,\ldots,N_c,\]
where $\sigma=\sqrt{2\gamma k_BT}$ and $e_i$ is the $i$th coordinate unit vector in $\mathbb R^{N_c}$.''',fields,kind='definition',extra=['[EXTRA]实际全部2Nc相空间坐标的真实drift/noise，C∞势资格编码，通用σ在物理定理取√(2γkBT)；不把noise定义计作独立Wiener law或密度存在证明。'])

# Preserve the original open coordinate domain, rather than requiring a global
# smooth extension as an unannounced restriction of Definition 6.1.
r=next(r for r in RECORDS if r['source_id'].endswith('-Definition61'))
r['statement_latex']=r'''Definition 6.1 (Hörmander's Condition) Let $U\subset\mathbb R^m$ be open. The SDE (6.43) with $C^\infty$ vector fields $b_0,b_1,\ldots,b_r:U\to\mathbb R^m$ are said to satisfy Hörmander's condition at $z\in U$ if the vector space spanned by the collection of iterated Lie brackets
\[b_0,b_1,\ldots,b_r,[b_0,b_1],[b_0,b_2],\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\ldots\]
(evaluated at $z$) is $\mathbb R^m$.'''
r['code']='''def definition61 {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x'''
r['extra_assumptions'].append('[EXTRA]原开域U和域内点完整保留；坐标字段全空间任意总化只用于函数表示，C∞仅要求在原开域，不要求全局光滑延拓。开域内真实fderiv/全部迭代括号是局部对象。')
r=next(r for r in RECORDS if r['source_id'].endswith('-LieBracket'))
r['code']='''def lieBracket {n : ℕ} (D : Set (Fin n → ℝ)) (_hD : IsOpen D)
    (u v : (Fin n → ℝ) → (Fin n → ℝ)) (_hu : ContDiffOn ℝ 1 u D)
    (_hv : ContDiffOn ℝ 1 v D) (x : D) : (Fin n → ℝ) :=
  MolecularDynamics.Chapter06Review.lieBracket u v x'''
r['extra_assumptions'].append('[EXTRA]实际字段仅需原开域内C¹，输出点属于D，非可微/域外的总化fderiv值不作为经典Jacobian。')
