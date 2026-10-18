from ch07_data import add

add('FastSlowHarmonicModel','7.13',323,
r'''\[H(q,p)=p^2/2+U(q),\qquad U(q)=U_F(q)+U_S(q),\]
\[U_S(q)=q^2/2,\qquad U_F(q)=\Omega^2q^2/2,\tag{7.47}\]
where $\Omega\gg1$.
\[\binom{dq}{dp}=\underbrace{\binom{pdt}{-\Omega^2qdt-\gamma pdt+\sqrt{2\gamma/\beta}dW}}_{\rm Fast}+\underbrace{\binom0{-qdt}}_{\rm Slow}.\tag{7.48}\]''',
'''abbrev Mat2 := Matrix (Fin 2) (Fin 2) ℝ
def fastPotential (Ω q : ℝ) : ℝ := Ω^2*q^2/2
def slowPotential (q : ℝ) : ℝ := q^2/2
def fastMatrix (Ω γ : ℝ) : Mat2 := !![0,1;-Ω^2,-γ]
def slowMatrix (h : ℝ) : Mat2 := !![1,0;-h,1]
def fastLangevin (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β : ℝ) (x0 : Phase 1) : Prop :=
  0 < frequency ∧ 0 < β ∧ langevin P W X (fun q ↦ fastPotential frequency (q 0)) (fun _ ↦ 1) γ β⁻¹ x0''',kind='definition',label='(7.47)–(7.48)',
extra=['单位质量、实际标准Wiener、状态适应、正β及完整积分方程由langevin定义体保留；Ω≫1在定量结论中分别改成明确不等式。'])

add('ExactFastGaussianLaw','7.13','323–324',
r'''Writing $F=\begin{bmatrix}0&1\\-\Omega^2&-\gamma\end{bmatrix}$, we can write down the solution to the fast dynamics as
\[\binom{q(t)}{p(t)}=\exp(Ft)\binom{q(0)}{p(0)}+B_tR,\]
where $R$ is a column vector of two i.i.d. random normal numbers distributed as $\mathcal N(0,1)$, and
\[B_tB_t^T=\frac{2\gamma}\beta\int_0^t\exp(F(t-s))\begin{bmatrix}0&0\\0&1\end{bmatrix}\exp(F^T(t-s))ds.\]''',
'''def fastExponential (Ω γ t : ℝ) : Mat2 := NormedSpace.exp (t • fastMatrix Ω γ)
def fastCovariance (Ω γ β t : ℝ) : Mat2 := fun i j ↦ 2*γ/β*∫ s in (0 : ℝ)..t,
  (fastExponential Ω γ (t-s)* (!![0,0;0,1] : Mat2)*(fastExponential Ω γ (t-s))ᵀ) i j
theorem exactFastGaussianLaw (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β t : ℝ) (x0 : Phase 1) (B : Mat2)
    (hX : fastLangevin P W X frequency γ β x0) (ht : 0 ≤ t)
    (hB : B*Bᵀ = fastCovariance frequency γ β t) :
    HasLaw (fun sample ↦ (![ (X t sample).1 0, (X t sample).2 0] : Fin 2 → ℝ))
      (Measure.map (fun R : Fin 2 → ℝ ↦
        fastExponential frequency γ t *ᵥ (![x0.1 0,x0.2 0] : Fin 2 → ℝ)+B*ᵥ R)
        (Measure.pi (fun _ : Fin 2 ↦ gaussianReal 0 1))) P := by
  sorry''',
extra=['陈述真实过程的转移分布，不将强解等于一组新独立R假设成结论。Bt只需给定平方根因子；正半定矩阵平方根存在性未另证明。'],
missing='需要线性SDE变分常数、确定积分Gaussian律及矩阵协方差理论；本轮不建设。')

add('MultipleTimestepUpdate','7.13',324,
r'''The solution to the slow part of our splitting is just
\[\binom{q(t)}{p(t)}=\begin{bmatrix}1&0\\-t&1\end{bmatrix}\binom{q(0)}{p(0)}.\]
For a method taking one step of the fast system followed by a step of the slow system, using fixed step size $h>0$, we can write the update scheme for $z=[q,p]^T$ as
\[z_{n+1}=Xz_n+YR_n,\qquad X=\begin{bmatrix}1&0\\-h&1\end{bmatrix}\exp(hF),\quad Y=\begin{bmatrix}1&0\\-h&1\end{bmatrix}B_h.\]''',
'''def multipleX (Ω γ h : ℝ) : Mat2 := slowMatrix h*fastExponential Ω γ h
def multipleY (h : ℝ) (B : Mat2) : Mat2 := slowMatrix h*B
def multipleStep (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) : Fin 2 → ℝ :=
  multipleX Ω γ h *ᵥ z+multipleY h B *ᵥ R
theorem multipleStep_composition (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) :
    multipleStep Ω γ h B R z = slowMatrix h *ᵥ (fastExponential Ω γ h *ᵥ z+B*ᵥ R) := by
  simp [multipleStep,multipleX,multipleY,Matrix.mulVec_add,Matrix.mulVec_mulVec]''',kind='definition',
extra=['Rn为每步独立标准二维Gaussian；稳定分布分析仍要求真实独立序列及有限协方差，不能只以更新定义宣称存在平稳解。'])

add('DeterminantTrace','7.13',324,
r'''Denoting $\eta=\sqrt{\gamma^2-4\Omega^2}$, then we compute
\[\det(X)=e^{-\gamma h},\qquad
\operatorname{tr}(X)=\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}.\]''',
'''def traceFormula (γ h : ℝ) (η : ℂ) : ℂ :=
  (η-(h : ℂ))/η*Complex.exp ((η-(γ : ℂ))*(h : ℂ)/2)+
  (η+(h : ℂ))/η*Complex.exp ((-η-(γ : ℂ))*(h : ℂ)/2)
theorem determinantTrace (Ω γ h : ℝ) (η : ℂ) (hη : η^2 = (γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    Matrix.det (multipleX Ω γ h) = Real.exp (-γ*h) ∧
    (Matrix.trace (multipleX Ω γ h) : ℂ) = traceFormula γ h η := by
  sorry''',
extra=['η允许纯虚数；显式排除临界η=0，避免除零假公式。临界阻尼应取连续极限，另列覆盖缺口。'],
missing='真实矩阵指数的特征分解/二阶Cayley–Hamilton闭式与det/trace桥；不建设一般线性SDE理论。')

add('SpectralRadiusStability','7.13',324,
r'''The stability of the method therefore depends solely on the spectral radius of the matrix $X$. This gives a stability condition
\[\left|\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}\right|\le1+e^{-\gamma h}.\]
Multiplying by $e^{\gamma h/2}$ gives
\[|\cosh(\eta h/2)+(h/\eta)\sinh(-\eta h/2)|\le\cosh(\gamma h/2).\]''',
'''def characteristicUnitDisk (X : Mat2) : Prop :=
  ∀ z : ℂ, z^2-(Matrix.trace X : ℂ)*z+(Matrix.det X : ℂ) = 0 → ‖z‖ ≤ 1
theorem spectralRadiusStability (X : Mat2) (hd : 0 < Matrix.det X) (hd1 : Matrix.det X < 1) :
    characteristicUnitDisk X ↔ |Matrix.trace X| ≤ 1+Matrix.det X := by
  sorry
def hyperbolicStability (γ h : ℝ) (η : ℂ) : Prop :=
  ‖Complex.cosh (η*(h : ℂ)/2)+(h : ℂ)/η*Complex.sinh (-η*(h : ℂ)/2)‖ ≤ Real.cosh (γ*h/2)''',
extra=['只陈述谱半径≤1的确定性边界资格；有非退化随机驱动时平稳二阶矩一般要求严格谱半径<1，等号并不自动给随机长期稳定。','正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。'],
missing='需实二次特征多项式的Schur/Jury判据与复根模长分类；不建设通用随机稳定性理论。')
