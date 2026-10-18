from ch07_data import add
add('VectorOU','7.3',267,
r'''By way of illustration of what we mean by a numerical sampling method, consider the system of independent Ornstein-Uhlenbeck (OU) processes
\[dp=-\gamma pdt+\sqrt{2k_BT\gamma}\,M^{1/2}dW.\tag{7.2}\]''',
'''abbrev V (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := V n × V n

def vectorWiener (P : Measure Ω) (W : ℝ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  iIndepFun (fun i sample t ↦ W t sample i) P

def momentumOU (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  ∀ i, scalarSDE P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i)
    (fun x ↦ -γ*x) (fun _ ↦ Real.sqrt (2*γ*θ*m i)) (p0 i)''',
kind='definition',label='(7.2)',context=['θ=k_BT；M为正对角质量矩阵，m i为其对角元。'],
extra=['显式标准多维Wiener及整个坐标路径独立，正质量、温度与非负摩擦；各坐标用真实Itô积分方程。'])
add('OUIntegratingFactor','7.3',267,
r'''Following the argument of Sect. 6.3.2 in the previous chapter,
\[d[\exp(\gamma t)p]=\gamma\exp(\gamma t)pdt+\exp(\gamma t)[-\gamma pdt+\sqrt{2k_BT\gamma}M^{1/2}dW]
=\exp(\gamma t)\sqrt{2k_BT\gamma}M^{1/2}dW.\]''',
'''theorem ouIntegratingFactor (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t : ℝ) (ht : 0 ≤ t) : ∀ i,
    MolecularDynamics.Chapter06Review.isItoIntegral P (fun s sample ↦ W s sample i)
      (fun s _ ↦ Real.exp (γ*s)*Real.sqrt (2*γ*θ*m i)) t
      (fun sample ↦ Real.exp (γ*t)*p t sample i-p0 i) := by
  sorry''',
extra=['把随机微分乘积法则陈述为从0到t的确定性加权Itô积分等式；有限时间和L²解资格由momentumOU明确。'],
missing='需要第6章Itô积分定义与积分因子法的桥接；不新建一般随机乘积法则。')
add('OUExactUpdate','7.3',268,
r'''Integrating from $t$ to $t+h$ and multiplying by $\exp(-\gamma t)$, we arrive at the solution
\[p(t+h)=e^{-\gamma h}p(t)+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}Z,\tag{7.3}\]
where $Z$ is a vector of independent, standard normal random variables.''',
'''def ouMomentum (m : V n) (γ θ h : ℝ) (p R : V n) : V n :=
  fun i ↦ Real.exp (-γ*h)*p i + Real.sqrt (θ*(1-Real.exp (-2*γ*h))) * Real.sqrt (m i) * R i

theorem ouTransitionLaw (P : Measure Ω) (W p : ℝ → Ω → V n)
    (m : V n) (γ θ : ℝ) (p0 : V n) (hp : momentumOU P W p m γ θ p0)
    (t h : ℝ) (ht : 0 ≤ t) (hh : 0 < h) :
    ∃ Z : Ω → V n, HasLaw Z (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P ∧
      IndepFun (p t) Z P ∧ ∀ᵐ sample ∂P,
        p (t+h) sample = ouMomentum m γ θ h (p t sample) (Z sample) := by
  sorry''',kind='unnumbered_claim',label='(7.3)',
extra=['等式解释为存在与过去动量独立的标准正态向量的随机表示；不是沿用同一Z表示所有时刻。','独立性要求使用W自然历史的适应解，见scalarSDE；θ=k_BT，M正对角。'],
missing='需要加权Wiener增量的联合Gaussian分布及相对过去的独立性；不建设一般SDE转移核理论。')
add('OUPhaseIteration','7.3',268,
r'''Alternatively, we may write this as a discrete iteration in terms of a random map:
\[p_{n+1}=e^{-\gamma h}p_n+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R_n,\]
with normally distributed $R$. For later purposes, we will think of this update as acting on both $q$ and $p$, leaving $q$ unchanged, i.e.
\[(q_{n+1},p_{n+1})=(q_n,e^{-\gamma h}p_n+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R_n).\]''',
'''def ouStep (m : V n) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  (x.1, ouMomentum m γ θ h x.2 R)

def vectorNormalSequence (P : Measure Ω) (R : ℕ → Ω → V n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P''',kind='definition',
extra=['独立标准正态的完整概率资格由vectorNormalSequence规定；ouStep只是总化单步函数。'])
add('OUForward','7.3',268,
r'''The Fokker-Planck operator for the OU system (7.2) can be computed directly as
\[\mathcal L_O^\dagger\phi(q,p)=\gamma\nabla_p\cdot(p\phi)+\gamma k_BT\nabla_p\cdot M\nabla_p\phi.\]''',
'''def partial (f : V n → ℝ) (x : V n) (i : Fin n) : ℝ :=
  deriv (fun z ↦ f (Function.update x i z)) (x i)

def ouForward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  γ * (∑ i, partial (fun x ↦ x i*f x) p i) +
    γ*θ * ∑ i, m i * partial (fun x ↦ partial f x i) p i

def ouBackward (m : V n) (γ θ : ℝ) (f : V n → ℝ) (p : V n) : ℝ :=
  -γ * (∑ i, p i * partial f p i) +
    γ*θ * ∑ i, m i * partial (fun x ↦ partial f x i) p i

theorem ouForward_adjoint (m : V n) (γ θ : ℝ) (f g : V n → ℝ)
    (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hfc : HasCompactSupport f) (hgc : HasCompactSupport g) :
    (∫ p, f p * ouBackward m γ θ g p) = ∫ p, ouForward m γ θ f p * g p := by
  sorry''',
extra=['partial为真实单坐标导数；给出前向表达式与后向生成元在紧支撑C²测试函数上的伴随恒等式。','仅p变量，q是固定参数；未声称已构造OU Markov半群的强生成元域。'],
missing='需要任意有限维逐坐标两次分部积分；本轮仅陈述，不为此建设大型算子域理论。')
add('OUGaussianInvariant','7.3',268,
'''Alternatively, if we ignore the physical origin of this parameter, we can think of $\gamma$ as an arbitrary coefficient; the sampling of the invariant measure does not depend on this choice. Thus we have a family of sampling iterations for the Gaussian distribution, defined for different choices of $\gamma$.''',
'''theorem ouGaussianInvariant (m : V n) (γ θ h : ℝ)
    (hm : ∀ i, 0 < m i) (hγ : 0 ≤ γ) (hθ : 0 < θ) (hh : 0 ≤ h) :
    Measure.map (fun x : V n × V n ↦ ouMomentum m γ θ h x.1 x.2)
      ((Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩)).prod
        (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) =
      Measure.pi (fun i ↦ gaussianReal 0 ⟨θ*m i, le_of_lt (mul_pos hθ (hm i))⟩) := by
  sorry''',extra=['γ=0允许恒等更新，仍保留Gaussian不变性；不把此时的不变性说成遍历采样收敛。'],
missing='需实际独立Gaussian向量线性变换与指数/方差恒等式的桥接；不建立一般随机核理论。')
add('Langevin','7.3.1',268,
r'''Langevin dynamics:
\[dq=M^{-1}pdt,\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{7.4}\]''',
'''def gradient (U : V n → ℝ) (q : V n) : V n := fun i ↦ partial U q i

def langevin (P : Measure Ω) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (U : V n → ℝ) (m : V n) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → ∀ i,
    IntervalIntegrable (fun s ↦ (X s sample).2 i / m i) volume 0 t ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i - γ*(X s sample).2 i) volume 0 t ∧
    (X t sample).1 i = x0.1 i + (∫ s in 0..t, (X s sample).2 i / m i) ∧
    (X t sample).2 i = x0.2 i + (∫ s in 0..t, -gradient U (X s sample).1 i - γ*(X s sample).2 i) +
      Real.sqrt (2*γ*θ*m i) * (W t sample i - W 0 sample i)''',kind='definition',label='(7.4)',
extra=['用真实坐标偏导与完整位置/动量积分方程表达；常扩散的Itô项即W增量乘系数；显式状态适应W自然历史、漂移可积。'])
