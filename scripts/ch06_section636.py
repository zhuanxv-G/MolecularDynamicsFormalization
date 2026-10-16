"""Complete Fokker–Planck claims; no weak PDE identity used as a hidden conclusion premise."""
from ch06_data import add,proposition
add('FPAdjointCompact','6.3.6',242,[71],r'''where the operator appearing on the right hand side is the adjoint $\mathcal L^*$ of the generator of the stochastic process, satisfying the relation
\[\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^*\rho\rangle.\]
In the case at hand the adjoint is
\[\mathcal L^*\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx};\]''',proposition('fpAdjoint_statement','fpAdjointCompact'),extra=['[EXTRA]紧支撑C²检验的完整正号伴随恒等；多项式检验及指数尾版本另条保留。'],missing='待一维IBP完整短桥。')
add('FPPolynomialAdjoint','6.3.6','241–242',[69,70,71],r'''We assume that $\rho$ is $C^\infty$ for all $t$ and that the density tends to zero exponentially fast as $x\to\pm\infty$, whereas $a$ and $b$ are $C^\infty$ functions which grow at most polynomially fast in these limits.
\[\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^*\rho\rangle.\]''',
'''theorem fpPolynomialAdjoint : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry''',extra=['[EXTRA]原C∞P值增长不足以控制所有IBP边界；明确一、二阶a,b,φ多项式增长及ρ导数指数尾，保存整个非紧支撑真实积分恒等。'],issues=['原只给函数值尾部增长而未约束导数；完整IBP及边界消失需技术资格，已全部明示，不静默添加。'],missing='缺完整指数尾IBP打包；不以边界通量消失本身作假设。')
add('FPEquation','6.3.6',242,[72],r'''If this is to hold for all test functions $\phi$, we must have
\[\frac{\partial\rho}{\partial t}=-\frac\partial{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).\]
The Fokker-Planck equation may be written in the compact form
\[\frac{\partial\rho}{\partial t}=\mathcal L^*\rho.\]''',
'''theorem fpEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧
    HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |a x|+|b x| ≤ C*(1+|x|)^r) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*|x|)) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.scalarForward a b (ρ t) x := by
  sorry''',extra=['[EXTRA]实际严格SDE与其真实平滑非负密度law、局部一致指数尾可求导资格；没有把弱PDE或所求点态PDE当假设。'],missing='缺一般Ito鞅期望、真实law到弱方程与测试函数基本引理完整桥接。')
add('ZeroNoise','6.3.6',242,[73],r'''In case $b\equiv0$, the SDE becomes an ordinary differential equation. Then the generator $\mathcal L$ becomes simply the Lie derivative, and its adjoint is just the Liouvillian.''',proposition('zeroNoise_statement','zeroNoise'),missing='待实际总导数零噪声化简短证明。')
add('VectorIto','6.3.7',243,[74],r'''If $\phi$ is a scalar valued function of $\mathbb R^m$, and $Z(t)$ is the solution of the SDE system
\[dZ=a(Z)dt+B dW;\tag{6.39}\]
where $a$ is a function in $\mathbb R^m$ and $B$ is a constant matrix, then we have
\[d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12dW^TB^T\phi''B dW;\tag{6.40}\]
\[d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12\operatorname{Tr}(B^T\phi''B)dt.\tag{6.41}\]''',
'''theorem vectorIto : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (φ : (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 → ContDiff ℝ 2 φ →
  (∀ j, MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P (fun t sample ↦ W t sample j)
    (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j))) →
  ∀ T : ℝ, 0 ≤ T → ∃ integrals : Fin r → Ω → ℝ,
    (∀ j, strictItoIntegral P (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T (integrals j)) ∧
    (∀ᵐ sample ∂P, φ (X T sample)-φ x0-
      (∫ s in 0..T, MolecularDynamics.Chapter06Review.vectorGenerator a B φ (X s sample))=∑ j, integrals j sample) := by
  sorry''',label='(6.40)–(6.41)',extra=['[EXTRA]按本节实际常矩阵B范围；真实全部坐标严格Ito积分与Hessian/trace完整校正，未缩成仅漂移定义。'],missing='缺一般多维Ito公式完整桥接。')
add('VectorForward','6.3.7',243,[75],r'''In the multivariate case, the density is a function of the vector describing a state of the system $z$ and $t$, and is governed by the partial differential equation
\[\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).\]''',
'''def vectorForward {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x''',kind='definition',context=['原本节常矩阵B实际完整负散度+正1/2二阶扩散；PDE从真实law推出另条。'])
add('DiffusionTrace','6.3.7',243,[76],r'''The second order “diffusion” term in this expression may be expanded as
\[\operatorname{Tr}(B^T\rho''B)=\sum_{i=1}^m\sum_{j=1}^m(BB^T)_{ij}\frac{\partial^2\rho}{\partial z_i\partial z_j}.\]''',proposition('diffusionTrace_statement','diffusionTrace'),missing='待Matrix.trace有限求和重排短证明。')
add('VectorFPEquation','6.3.7',243,[75],r'''In the multivariate case, the density is a function of the vector describing a state of the system $z$ and $t$, and is governed by the partial differential equation
\[\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).\]''',
'''theorem vectorFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (ρ : ℝ → (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ k : ℕ, ∀ x, ‖a x‖ ≤ C*(1+‖x‖)^k) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x := by
  sorry''',extra=['[EXTRA]真实多维Wiener、严格SDE、完整非负密度law、光滑和局部尾部求导资格；没有将弱PDE结论作假设。'],missing='缺多维Ito/鞅期望及真实law到强Fokker–Planck完整桥接。')
