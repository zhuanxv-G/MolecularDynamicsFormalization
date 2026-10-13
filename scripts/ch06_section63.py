"""Full scalar/state-dependent vector SDEs; strict L² semantics for new obligations."""
from ch06_data import add,copied,proposition,D,NS
def strict_statement(name,newname=None):
 code=proposition(name,newname)
 for old,new in [('isItoIntegral','strictItoIntegral'),('scalarSDE','strictScalarSDE'),('ouProcess','strictOUProcess')]:
  code=code.replace(NS+old,new)
 return code
add('BiasedWalk','6.3',232,[46],r'''We introduce a pair of smooth functions $a(x,t)$ and $b(x,t)$, where $a$ represents a drift tendency and $b$ the average magnitude of the random jump. In the interval $[n\delta t,(n+1)\delta t]$, a step $\delta X_n=X_{n+1}-X_n$ of the random walk will be given by
\[\delta X_n=a(X_n,t_n)h+b(X_n,t_n)J_n\delta x.\tag{6.9}\]''',copied(D,'biasedWalk'),kind='definition',label='(6.9)',extra=['[EXTRA]按正文h=δt及δx=√δt解释真实递归与x0初值；印刷h/δt记号不一致已保留。'])
add('BiasedWalkSum','6.3',232,[46],r'''Choose a positive $t$ and sum (6.9) from $n=0$ to $\nu-1$, where $\nu=\lfloor t/\delta t\rfloor$, obtaining
\[X_\nu-X_0=\sum_{n=0}^{\nu-1}\delta X_n=\sum_{n=0}^{\nu-1}a(X_n,t_n)\delta t+\sum_{n=0}^{\nu-1}b(X_n,t_n)J_n\delta x.\tag{6.10}\]''',
'''theorem biasedWalkSum : ∀ {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) (K : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 K sample-x0 =
    (∑ k ∈ Finset.range K, a (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*dt) +
    ∑ k ∈ Finset.range K, b (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*Real.sqrt dt*J k sample := by
  sorry''',label='(6.10)',missing='待实际递归有限望远镜求和短证明。')
add('ScalarSDE','6.3',232,[47],r'''Take the diffusion limit $\delta t\to0$, $\delta x^2/\delta t\to1$ with $\nu\delta t=t$ fixed, then we obtain, under the Itô convention,
\[X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).\tag{6.11}\]
\[dX=a(X,t)dt+b(X,t)dW.\tag{6.14}\]''',
'''def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)''',kind='definition',label='(6.11)–(6.14)',extra=['[EXTRA]真实连续路径、实际可积漂移及全部有限和L²的Ito极限；是方程意义，不计随机游走扩散极限已证。'],context=['(6.12)漂移为普通时间积分；(6.13)为左点均方极限；连续微分并非普通样本导数。'])
add('VectorSDE','6.3','232–233',[48],r'''Let $a(z,t)$ and $b^{(i)}(z,t)$, $i=1,2,\ldots,r$ be a set of $r+1$ vector fields in $\mathbb R^m$, and let $W_1,W_2,\ldots,W_r$ be a collection of $r$ independent Wiener processes, then we may write a system of SDEs in $\mathbb R^m$ in the form
\[dZ=a(Z,t)dt+\sum_{i=1}^r b^{(i)}(Z,t)dW_i.\tag{6.15}\]
alternatively, if $B$ is the matrix with columns $b^{(1)},b^{(2)},\ldots,b^{(r)}$, and $W$ represents the $r$-component vector of Wiener processes, then
\[dZ=a(Z,t)dt+B(Z,t)dW.\tag{6.16}\]''',
'''def strictVectorSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → ℝ → (Fin n → ℝ))
    (B : (Fin n → ℝ) → ℝ → Matrix (Fin n) (Fin r) ℝ) (x0 : Fin n → ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s i) volume 0 T) ∧
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ B (X s sample) s i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, X T sample i-x0 i-(∫ s in 0..T, a (X s sample) s i)=∑ j, integrals j sample)''',kind='definition',label='(6.15)–(6.16)',extra=['[EXTRA]完整状态及时间依赖矩阵B(Z,t)，每坐标真实严格Ito积分与漂移；没有缩成常矩阵加性特例。'])
add('ScalarItoFormula','6.3.1',233,[49],r'''Let $\phi(x)$ be any continuously twice differentiable function and let $X_n\in\mathbb R$ represent the state of a biased random walk as considered in Sect. 6.3, i.e., with state $X_{n+1}=X_n+a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x$.
\[d\phi(X)=\phi'(X)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi''(X)b(X,t)^2dt.\tag{6.17}\]''',strict_statement('itoFormula_statement','scalarItoFormula'),label='(6.17)',extra=['[EXTRA]原C²φ、真实PreBrownian和严格积分方程；完整漂移、噪声、二阶Ito校正；适应/可积技术资格保留。'],missing='缺一般随机Ito链式法则；不建大型理论，保留完整sorry。',proof=r'''Let $\phi_n=\phi(X_n)$, then Taylor's theorem gives
\[\delta\phi\stackrel{\rm def}=\phi_{n+1}-\phi_n=\phi'(X_n)\delta X_n+\tfrac12\phi''(X_n)\delta X_n^2+o(\delta X_n^2)
=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)
+\tfrac12\phi''(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)^2+o(\delta X_n^2).\]
Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\delta x^2\approx\delta t$, thus we have
\[\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).\]
Passing to the limit, this leads to the SDE.''',proof_note='原启发证明完整保留；C²仅给o(δt)，O(δt³⁄²)需要更高阶资格，另条疑误。')
add('DiffusiveTaylorPrinted','6.3.1',233,[49],r'''Now we expand the 2nd order term and, working in the diffusion limit, recognize that $\delta x^2\approx\delta t$, thus we have
\[\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).\]''',
'''theorem diffusiveTaylorPrinted : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 2 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['C² Taylor余项仅o(h²)，不能自动提升为O(h³)；在h≈√δt时原O(δt³⁄²)需要更高阶正则性。'],missing='不证明C²的错误阶数；完整Ito公式另条保存，不恢复封存长证明。')
add('TimeItoFormula','6.3.1',234,[50],r'''We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $\phi(x,t)$:
\[d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}\]''',strict_statement('itoTimeFormula_statement','timeItoFormula'),label='(6.18)',verdict='NEEDS_HUMAN',extra=['[EXTRA]Lean保留完整积分陈述，以φ_t dt的正确时间积分表达；原无dt的字面式仍在逐字JSON，不宣称字面式已证。'],issues=['印刷φ_t(X,t)项漏dt，字面微分式不具一致类型；补dt需要网站审计裁定。'],missing='缺一般时空Ito链式法则；完整更正积分式保留sorry。')
add('BiasedWalkDiffusion','6.3',232,[46,47],r'''Take the diffusion limit $\delta t\to0$, $\delta x^2/\delta t\to1$ with $\nu\delta t=t$ fixed, then we obtain, under the Itô convention,
\[X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).\]''',
'''theorem biasedWalkDiffusion : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (W : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 T : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J →
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ W t sample) (Ici 0)) →
  (∃ L : ℝ≥0, LipschitzWith L (Function.uncurry a) ∧ LipschitzWith L (Function.uncurry b)) → 0 < T →
  ∃ X : ℝ → Ω → ℝ, strictScalarSDE P W X a b x0 ∧
    ∃ paths : Ω → C(Icc 0 T, ℝ),
      (∀ᵐ sample ∂P, ∀ t : Icc 0 T, paths sample t=X t sample) ∧
      ∃ walks : ℕ → Ω → C(Icc 0 T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample (t : Icc 0 T),
          walks K sample t = let dt := T/K; let k := Nat.floor ((t : ℝ)/dt);
            MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample +
            ((t : ℝ)-k*dt)/dt*(MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 (k+1) sample-
              MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample)) ∧
        (∀ F : C(Icc 0 T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
          Tendsto (fun K ↦ ∫ sample, F (walks K sample) ∂P) atTop (𝓝 (∫ sample, F (paths sample) ∂P))) := by
  sorry''',extra=['[EXTRA]明确全局Lipschitz技术资格及AE连续W版本；完整SDE解存在与真实偏置有限游走线性插值的路径空间弱极限，没有只以定义取代扩散极限。'],missing='缺状态依赖Euler随机游走扩散极限及强解存在桥接；不建设大型随机理论。')
