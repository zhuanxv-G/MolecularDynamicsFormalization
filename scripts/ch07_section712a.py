from ch07_data import add

add('ConstrainedLangevin','7.12',317,
r'''\[dq=M^{-1}pdt,\tag{7.43}\]
\[dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\tag{7.44}\]
\[0=g(q).\tag{7.45}\]
The vector of $l$ constraints is given by $g:\mathbb R^{N_c}\to\mathbb R^l$ and $\lambda$ is an $l$-dimensional vector of Lagrange multipliers. $W$ is a vector of standard Wiener processes, with the usual friction parameter $\gamma>0$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint
\[g(q)=0,\qquad g'(q)M^{-1}p=0.\]''',
'''def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (λ : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*λ j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))''',kind='definition',label='(7.43)–(7.45)',
extra=['实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。','定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。'],
scope='全部约束积分方程及隐约束资格；适应性作为解资格显式保留，存在唯一性未证明。')

add('ConstrainedCanonicalErgodicity','7.12',317,
r'''In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $\widetilde\rho_\beta$ ergodically, such that
\[\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,\]
where $\widetilde\rho_\beta$ is the normalized constrained canonical distribution
\[\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],\]
for normalizing constant $Z$ and where $\delta[z]:=\prod_i\delta[z_i]$ for a vector $z$.''',
'''def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))''',kind='definition',
extra=['δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。','实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。'],
scope='全部分布及遍历平均目标的测度定义；约束参考测度存在与具体过程的遍历定理仍缺。',verdict='NEEDS_HUMAN')

add('ConstrainedHOSplitting','7.12',318,
r'''We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses
\[H_c:\quad dq=M^{-1}pdt,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,\]
\[O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.\]
We solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $h$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $h/2$.''',
'''def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (λ : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 λ i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (λ : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 λ i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)''',kind='definition',
extra=['Hc、Oc分别使用各自乘子，不能将相同λ在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。','每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。'])

add('MEVMEAlgorithm','7.12','318–319',
r'''Midpoint Euler - Verlet - Midpoint Euler (see [232])
\[p_{n+1/4}=p_n-\tfrac{h\gamma}4(p_n+p_{n+1/4})+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4},\quad g'(q_n)M^{-1}p_{n+1/4}=0.\]
\[p_{n+1/2}=p_{n+1/4}-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/2},\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\]
\[p_{n+3/4}=p_{n+1/2}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+3/4},\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\quad g(q_{n+1})=0.\]
\[p_{n+1}=p_{n+3/4}-\tfrac{h\gamma}4(p_{n+3/4}+p_{n+1})+\sqrt{h\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.\]''',
'''def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (λ : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q λ i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (λ μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 λ i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ λa λb λc λd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa λa ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph λb λc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 λd''',kind='definition',
extra=['完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。'])
