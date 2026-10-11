"""Eight mathematical assertions beyond the old checklist, original PDF189–194."""
from ch04_data import add,NS
add('SecondMomentDiagonal','4.4',168,[],r'''By choosing an appropriate coordinate frame, it is possible to insure that the symmetric matrix $R$ is a diagonal matrix.''',f'''theorem secondMomentDiagonal : ∀ N (m : Fin N → ℝ) (δ : Fin N → {NS}V),
    ∃ O : {NS}Mat3, Oᵀ*O=1 ∧ ∀ i j, i ≠ j →
      (Oᵀ*{NS}secondMoment m δ*O) i j=0 := by
  sorry''',missing='待实际对称3×3二阶矩与Mathlib实谱定理的基变换桥接；不建立新谱理论。')
add('RotationBodyEnergy','4.4',169,[],r'''It is convenient to express this in terms of the so-called body angular velocity $\omega_b=\Theta^T\omega$ in which case it becomes $K_{\rm rot}=\frac12\omega_b^TT\omega_b$.''',f'''theorem rotationBodyEnergy : ∀ N (m : Fin N → ℝ) (δ : Fin N → {NS}V) (Θ : {NS}Mat3) (ω : {NS}V),
  Θᵀ*Θ=1 → Θ.det=1 →
  (∑ i, m i*{NS}dot ({NS}cross3 ω (Θ *ᵥ δ i)) ({NS}cross3 ω (Θ *ᵥ δ i)))/2=
    {NS}rotationalEnergy ({NS}inertiaTensor m δ) (Θᵀ *ᵥ ω) := by
  sorry''',extra=['真实SO3旋转；不把动能等式/叉积协变当假设。'],missing='缺SO3实际叉积与惯性有限和动能桥接；保留完整结论。')
add('DipolarConstraint','4.4',170,[],r'''The vectors $\mu_k$ can be taken to be unit vectors reflecting the dipole orientation, so they are subject to the constraint $\|\mu_k\|\equiv1$.''',f'''def dipolarConstraint {{N : ℕ}} (μ : Fin N → {NS}V) : Prop :=
  ∀ i, {NS}dot (μ i) (μ i)=1''',kind='definition',context=['Euclidean单位平方定义，与Pi最大范数不同。'])
add('DipolarPotentialSum','4.4',170,[],r'''$\varphi^{\rm dip}_{ij}=\varphi^{\rm LJ}(r_{ij})+\mu_i^TL(q_{ij})\mu_j$, with $U$ given as the sum of these over pairs.''',f'''def dipolarPotentialSum {{N : ℕ}} (lj : ℝ → ℝ) (q μ : Fin N → {NS}V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt ({NS}dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0''',kind='definition',extra=['对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。'])
add('RotationTrajectory','4.4',168,[],r'''$\delta_i(t)=\Theta(t)\delta_i(0)$, see Fig. 4.7, thus we have $\dot\delta_i=\dot\Theta\delta_i(0)$.''',f'''theorem rotationTrajectory : ∀ (Θ : ℝ → {NS}Mat3) (d : {NS}Mat3) (δ : {NS}V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  sorry''',missing='待实际矩阵mulVec固定配置的连续线性求导短桥接。')
add('RotationDerivativePrinted','4.4',168,[],r'''An alternative form for the rotational kinetic energy may be obtained by writing
\[\dot\delta_i=\dot\Theta\delta_i(0)=\dot\Theta\Theta^T\Theta\delta_i(0)=\dot\Theta\Theta^T\dot\delta_i,\]
where we have used the fact that $\Theta$ is orthogonal.''',f'''theorem rotationDerivativePrinted : ∀ (Θ : ℝ → {NS}Mat3) (d : {NS}Mat3) (δ : {NS}V) t,
  HasDerivAt Θ d t → Θ t*(Θ t)ᵀ=1 →
    d *ᵥ δ=(d*(Θ t)ᵀ) *ᵥ (d *ᵥ δ) := by
  sorry''',verdict='NEEDS_HUMAN',explanation='原页最后δ_i带点，与先前δ_i=Θδ_i(0)代换不符；通常应为无点δ_i，正确运动学另条保留。',issues=[dict(code='ERRATUM?',detail='p168展示最后应以配置δ_i而非速度dotδ_i代换；已渲染视觉复核。')],missing='待网站/导师裁定最后δ点号；不证明疑误版本。')

from blueprint_source import apply_saved_routes
from ch04_data import RECORDS
apply_saved_routes(4,RECORDS,["RotationTrajectory","SecondMomentDiagonal","RotationBodyEnergy"])
