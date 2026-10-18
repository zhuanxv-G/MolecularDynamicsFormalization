from ch07_data import add

add('OverdampedSolvabilityOperators','7.9.2',304,
r'''We abbreviate
\[\mathcal M\psi(q)=\overline\pi\mathcal L_H^\dagger\mathcal L_A^\dagger\psi(q)
=\overline\pi((\mathcal L_A^\dagger)^2+\mathcal L_B^\dagger\mathcal L_A^\dagger)\psi(q)
=\beta^{-1}\Delta_q\psi(q)-\nabla U\cdot\nabla_q\psi(q),\]
\[\mathcal N\psi(q)=\overline\pi\mathcal L_H^\dagger(\mathcal L_A^\dagger)^3\psi(q)
=\overline\pi((\mathcal L_A^\dagger)^4+\mathcal L_B^\dagger(\mathcal L_A^\dagger)^3)\psi(q)
=\tfrac3\beta\mathcal M(\Delta_q\psi(q)).\]
Thus we have
\[\overline\pi\mathcal L_H^\dagger\rho_\beta f_{2,1,[OABAO]}=\tfrac\beta8\mathcal M(|\nabla U|^2-\beta^{-1}\Delta_qU)+\mathcal M\nu,\]
and hence by (7.36) we finally obtain $\nu(q)=\tfrac18(\Delta_qU-\beta|\nabla U|^2)$, where $\langle\nu\rangle=0$.''',
'''def overdampedM (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  β⁻¹*laplacian ψ q-(∑ i, gradient U q i*gradient ψ q i)
def overdampedN (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  3/β*overdampedM U (laplacian ψ) β q
def highFrictionOABAO (U : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  (laplacian U q-β*gradNormSq U q)/8
theorem overdampedSolvability_choice (U : V n → ℝ) (β : ℝ) (hβ : β ≠ 0) :
    ∀ q, highFrictionOABAO U β q =
      -β/8*(gradNormSq U q-β⁻¹*laplacian U q) := by
  intro q
  dsimp [highFrictionOABAO]
  field_simp
  <;> ring''',
extra=['M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。','只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。'],
scope='M,N及ν全部显式公式和ν代数识别；平均算符等价与可解性未证明。')

add('HighFrictionCorrectionTable','7.9.2','304–305',
r'''\[f_{2,0,[OABAO]}=\tfrac18(\Delta_qU-\beta|\nabla U|^2),\]
\[f_{2,0,[OBABO]}=\tfrac18(\beta|\nabla U|^2-2\Delta_qU+c),\]
where $c=\langle\Delta U\rangle$ is a constant chosen to ensure zero average.
\[f_{2,0,[ABOBA]}=\tfrac18(\beta p^T\nabla^2U(q)p-2\Delta_qU+c),\]
\[f_{2,0,[BAOAB]}=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p).\]
\[\langle\vartheta\rangle_h=\langle\vartheta\rangle+h^2\langle\vartheta f_{2,0}\rangle+O(\epsilon h^2+h^4).\]''',
'''def highFrictionCorrection (s : Fin 4) (U : V n → ℝ) (β c : ℝ) (x : Phase n) : ℝ :=
  if s = 0 then highFrictionOABAO U β x.1
  else if s = 1 then (β*gradNormSq U x.1-2*laplacian U x.1+c)/8
  else if s = 2 then (β*hessianQuadratic U x-2*laplacian U x.1+c)/8
  else (laplacian U x.1-β*hessianQuadratic U x)/8
def doublyAsymptoticAverage (A : ℝ → ℝ → ℝ) (exact correction : ℝ) : Prop :=
  Asymptotics.IsBigO positivePairLimit
    (fun z ↦ A z.1 z.2-exact-z.2^2*correction) (fun z ↦ z.1*z.2^2+z.2^4)
theorem highFrictionCorrection_conjugacy (U : V n → ℝ) (β c : ℝ) :
    conjugateCorrections U β (highFrictionCorrection 2 U β c) (highFrictionCorrection 1 U β c)
      (highFrictionCorrection 3 U β c) (highFrictionCorrection 0 U β c) := by
  constructor <;> funext x <;>
    norm_num [conjugateCorrections,highFrictionCorrection,highFrictionOABAO,conjugateCorrectionChange]
    <;> ring''',
extra=['算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。','候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。'])

add('BAOABMarginalCancellation','7.9.3',305,
r'''\[\langle\vartheta\rangle=\langle\vartheta\rangle_h-h^2\langle\vartheta f_{2,0}\rangle+O(h^2/\gamma+h^4).\tag{7.37}\]
The $[BAOAB]$ scheme has leading order correction
\[f_{2,0,[BAOAB]}(q,p)=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p),\]
which has the interesting property that its marginal average with respect to momentum is zero:
\[\overline\pi f_{2,0,[BAOAB]}=\int_{\mathcal P}f_{2,0,[BAOAB]}(q,p)\rho_\beta(q,p)d\omega_p=0.\]
\[\langle\vartheta(q)f_{2,0,[BAOAB]}\rangle=\int_{\mathcal Q}\vartheta(q)\int_{\mathcal P}f_{2,0,[BAOAB]}\rho_\beta d\omega_p d\omega_q=0.\]''',
'''theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry''',label='(7.37)',proof='Integrate first over the Gaussian momenta; the quadratic Gaussian moment contracts the Hessian to β⁻¹ΔU. Then use Fubini.',
extra=['归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。'],
missing='需Gaussian协方差矩阵、Hessian缩并与乘积Fubini桥；不发展Talay–Tubaro余项理论。')

add('SuperconvergenceScope','7.9.3',306,
r'''Thus we expect that the $[BAOAB]$ scheme recovers $O(h^4)$ configurational averages in the limit of infinite friction.
Its conjugate method, the $[OABAO]$ scheme, has the property
\[\int_{\mathcal Q}f_{2,0,[OABAO]}(q,p)\rho_\beta(q,p)d\omega_q=0,\]
implying that we obtain high-order averages for functions purely of the momenta in the limit of infinite friction.
It is important to note that this superconvergence property is only present in the limit of large time, i.e. this is an attribute of the invariant distribution of the discretization schemes $\widehat\rho$. As such, there are no bonuses to the weak or strong order of the superconvergent schemes.''',
'''theorem oabaoPositionCancellation (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U)
    (hweight : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hgrad : ∀ i, Integrable (fun q ↦ (hessianU U q i i-β*gradient U q i^2)*Real.exp (-β*U q)) volume)
    (hboundary : ∀ q i, Filter.Tendsto
      (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, highFrictionOABAO U β q ∂positionGibbs U β) = 0 := by
  sorry
theorem superconvergence_fromBound (A : ℝ → ℝ) (exact : ℝ)
    (hA : Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact-h^2*(0 : ℝ)) (fun h ↦ h^4)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact) (fun h ↦ h^4) := by
  simpa using hA''',
extra=['显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。','四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。'],
missing='需要逐坐标积分分部及Fubini边界桥；不建设一般无限时间弱展开。')
