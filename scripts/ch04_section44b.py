"""Eight rotation/inertia records, PDF190–191."""
from ch04_data import add,copied,proposition,D,NS
add('RotationTraceIdentity','4.4',168,[],r'''$K_{\rm rot}=\frac12\sum_{i=1}^Nm_i\delta_i(0)^T\dot\Theta^T\dot\Theta\delta_i(0)$. This expression may be rewritten as $K_{\rm rot}=\frac12\operatorname{Tr}[\dot\Theta R\dot\Theta^T]$.''',f'''theorem rotationTraceIdentity : ∀ N (m : Fin N → ℝ) (δ : Fin N → {NS}V) (dΘ : {NS}Mat3),
    (∑ i, m i*{NS}dot (dΘ *ᵥ δ i) (dΘ *ᵥ δ i))/2=
      {NS}rotationKinetic ({NS}secondMoment m δ) dΘ := by
  sorry''',missing='待有限和、外积与trace展开短证明。')
add('RotationSkew','4.4','168–169',[82],r'''Moreover, since $\Theta\Theta^T=I$, we have $\dot\Theta\Theta^T+\Theta\dot\Theta^T=0$, which indicates that $\dot\Theta\Theta^T$ is a skew symmetric matrix.''',proposition('rotationSkew_statement'),extra=['真实HasDerivAt矩阵轨道与邻域正交约束；不假设导数乘积恒等式。'],missing='待矩阵乘积与转置真实导数短桥。')
add('SkewMatrix','4.4',169,[83],r'''Any $3\times3$ skew matrix may be written as
\[\dot\Theta\Theta^T=\operatorname{skew}(\omega)\equiv\begin{bmatrix}0&-\omega_3&\omega_2\\\omega_3&0&-\omega_1\\-\omega_2&\omega_1&0\end{bmatrix}.\tag{4.38}\]''',copied(D,'skewMatrix'),kind='definition',label='(4.38)',context=['本条定义实际skew；任意skew有此唯一表示另条，不能省作已证明。'])
add('CrossProduct','4.4',169,[83],r'''$\frac d{dt}\delta_i=\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$.''',copied(D,'cross3'),kind='definition',context=['右手cross3有限坐标定义；实际导数运动学另条。'])
add('SkewRepresentation','4.4',169,[],r'''Any $3\times3$ skew matrix may be written as $\operatorname{skew}(\omega)$.''',f'''theorem skewRepresentation : ∀ A : {NS}Mat3, Aᵀ = -A → ∃! ω : {NS}V, {NS}skewMatrix ω=A := by
  sorry''',missing='待3×3坐标存在唯一性有限证明。')
add('CrossMatrix','4.4',169,[84],r'''$\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$.''',proposition('crossMatrix_statement'),extra=['[EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。'],missing='待Fin3枚举及真实矩阵向量乘法代数短证明。')
add('RigidVelocity','4.4',169,[84],r'''$\frac d{dt}\delta_i=\operatorname{skew}(\omega)\delta_i=\omega\times\delta_i=-\operatorname{skew}(\delta_i)\omega$, which is the usual definition.''',f'''theorem rigidVelocity : ∀ (Θ : ℝ → {NS}Mat3) (dΘ : {NS}Mat3) (δ ω : {NS}V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ={NS}skewMatrix ω →
    HasDerivAt (fun s => Θ s *ᵥ δ) ({NS}cross3 ω (Θ t *ᵥ δ)) t := by
  sorry''',extra=['给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。'],missing='待实际矩阵mulVec求导与skew×cross代数桥接。')
add('InertiaTensor','4.4',169,[85],r'''$K_{\rm rot}=\frac12\omega_b^TT\omega_b$, where the matrix $T=-\sum_{i=1}^Nm_i\operatorname{skew}(\delta_i(0))^2$ is referred to as the moment of inertia tensor or simply the inertia tensor and can be written as
\[T=\sum_{i=1}^Nm_i[\|\delta_i(0)\|^2I-\delta_i(0)\delta_i(0)^T].\]''',copied(D,'inertiaTensor'),kind='definition',context=['实际Euclidean有限和定义；skew²等价另条，动能标量定义另条。'])
from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,['CrossMatrix','SkewRepresentation','RotationTraceIdentity','RotationSkew','RigidVelocity'])
