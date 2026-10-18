from ch07_data import add

add('MomentumRedrawLimit','7.10',306,
r'''We now consider schemes in the limit $\gamma\to\infty$, where the exact solution of the vector OU process reduces to redrawing momenta from the canonical distribution, so $p_{n+1}=\sqrt{k_BT}M^{1/2}R$, where $R$ is a vector of i.i.d. normal random numbers.''',
'''def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry''',
extra=['固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。'],
missing='指数衰减、sqrt连续与有限维逐坐标极限短桥；不建立Smoluchowski–Kramers理论。')

add('OBABOOverdampedEuler','7.10',307,
r'''For the method denoted $[OBABO]$, we have the limiting scheme
\[p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad \widehat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),\]
\[q_{n+1}=q_n+hM^{-1}\widehat p_{n+1/2},\quad
\widehat p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=\sqrt{k_BT}M^{1/2}R_{n+1/2}.\]
\[q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+h\sqrt{k_BT}M^{-1/2}R_n.\tag{7.38}\]
Denoting $\tau=h^2/2$, the update scheme (7.38) becomes the Euler-Maruyama scheme
\[q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}R_n.\tag{7.39}\]''',
'''def obaboInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  redrawStep m θ S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ redrawStep m θ R
def overdampedEulerH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-h^2/2/m i*gradient U q i+h/m i*redrawMomentum m θ R i
def overdampedEuler (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*R i
theorem obaboInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) (x : Phase n) :
    (obaboInfinite m U θ h R S x).1 = overdampedEulerH m U θ h R x.1 := by
  funext i
  dsimp [obaboInfinite,redrawStep,kickStep,driftStep,overdampedEulerH,Function.comp_def]
  ring
theorem overdampedEuler_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    overdampedEulerH m U θ h R q = overdampedEuler m U θ (h^2/2) R q := by
  sorry''',label='(7.38)–(7.39)',
extra=['完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。'],
missing='时间尺度替换需实平方根、质量正性与根号乘积的短桥。')

add('BAOABLimitMethod','7.10','307–308',
r'''\[p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\]
\[\widehat p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\widehat p_{n+1/2},\quad
p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}).\]
Expressing this as an update solely for the configurations, we obtain
\[q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+\tfrac h2\sqrt{k_BT}M^{-1/2}(R_n+R_{n-1}),\]
and substituting $\tau=h^2/2$ gives the BAOAB Limit Method (Leimkuhler-Matthews method)
\[q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}\left(\tfrac{R_n+R_{n-1}}2\right).\tag{7.40}\]''',
'''def baoabInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ redrawStep m θ R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def lmStepH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-h^2/(2*m i)*gradient U q i+h/(2*m i)*(redrawMomentum m θ R i+redrawMomentum m θ S i)
def lmStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*((R i+S i)/2)
theorem baoabInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) :
    (baoabInfinite m U θ h R (q,fun i ↦ redrawMomentum m θ S i-h/2*gradient U q i)).1 =
      lmStepH m U θ h R S q := by
  funext i
  dsimp [baoabInfinite,lmStepH,kickStep,driftStep,redrawStep,Function.comp_def]
  ring''',label='(7.40)',
extra=['消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。','完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。'])

add('ColoredNoiseAndExtension','7.10',308,
r'''We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $p_n$).''',
'''def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)''',
extra=['MA(1)噪声以相邻两独立Gaussian平均定义；定义扩展状态(q,R旧)的完整一步映射。非Markov性的普遍表述依赖具体势和初值，未把任意位置过程都判非Markov；扩展Markov核与半群律仍是覆盖缺口。'],
missing='需独立Gaussian一二阶矩的全部相邻/不相邻组合积分；不建一般时间序列理论。')

add('LimitMethodAccuracy','7.10',308,
r'''We would expect that this scheme should have an $O(h^4)=O(\tau^2)$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $O(h^2)$.''',
'''def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring''',kind='definition',
issues=['已目视核对PDF329：本段前面以τ为实际过阻尼步长并称长期二阶，末句却写O(h²)。若仍沿用τ=h²/2，应区分长期O(τ²)=O(h⁴)和有限时一阶O(τ)=O(h²)；原文符号存在歧义。'],
extra=['用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。','原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。'],
scope='误差界目标和步长幂次转换；尚缺LM算法到该界的完整定理。',verdict='NEEDS_HUMAN')

add('ZeroFrictionVerlet','7.9.3',306,
r'''An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $\gamma=0$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.''',
'''theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  sorry''',
extra=['OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。'],
missing='两个A半步合并及函数组合化简的短桥尚未完成。')
