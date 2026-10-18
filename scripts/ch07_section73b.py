from ch07_data import add
add('HamiltonianGibbs','7.3.1',269,
r'''Since Hamiltonian dynamics leaves invariant any function of the energy, its corresponding Fokker-Planck operator (in this case the Liouvillian, $\mathcal L_H^\dagger=-\mathcal L_H$) will preserve distributions that are functions of the Hamiltonian $H$. This implies in particular that it preserves $\rho_\beta$, which is proportional to $\exp(-\beta H)$. Thus the forward propagator associated to the Hamiltonian system automatically preserves the Gibbs distribution, and we have
\[e^{t\mathcal L_H^\dagger}\rho_\beta=\rho_\beta.\]''',
'''theorem hamiltonianGibbs {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (F : D → D) (H : D → ℝ) (β : ℝ)
    (hF : Measurable F) (hv : MeasurePreserving F ν ν)
    (hH : ∀ x, H (F x) = H x) (hweight : Measurable (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) :
    Measure.map F (ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) =
      ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x))) := by
  sorry''',
extra=['F为已存在的实际Hamiltonian流的固定时刻映射；显式体积保持与能量保持，结论为实际加权测度不变性。','本文未重证明一般Hamiltonian流存在；若需归一化为概率，须另补配分积分正有限。'],
missing='需map与withDensity的测度输运短桥；现有Hamiltonian体积保持可作为流资格，不新建流存在理论。')
add('ABOPieces','7.3.1','269–270',
r'''We therefore consider dividing the Langevin system (7.4) into parts
\[d\binom qp=\binom{M^{-1}p}{0}dt+\binom0{-\nabla U(q)}dt+\binom0{-\gamma pdt+\sigma M^{1/2}dW},\tag{7.5}\]
which we label A, B, and O, where each of the three parts may be solved “exactly”, with individual updates given as
\[\mathcal U_h^A(q,p)=(q+hM^{-1}p,p),\quad
\mathcal U_h^B(q,p)=(q,p-h\nabla U(q)),\quad
\mathcal U_h^O(q,p)=(q,e^{-\gamma h}p+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R),\]
where $R$ is a vector of i.i.d. normal random numbers.''',
'''def driftStep (m : V n) (h : ℝ) (x : Phase n) : Phase n :=
  (fun i ↦ x.1 i + h * x.2 i / m i, x.2)

def kickStep (U : V n → ℝ) (h : ℝ) (x : Phase n) : Phase n :=
  (x.1, fun i ↦ x.2 i - h * gradient U x.1 i)

def aField (m : V n) (x : Phase n) : Phase n := (fun i ↦ x.2 i / m i, 0)
def bField (U : V n → ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -gradient U x.1 i)
def oDrift (γ : ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -γ*x.2 i)

theorem splittingDrift (m : V n) (U : V n → ℝ) (γ : ℝ) (x : Phase n) :
    aField m x + bField U x + oDrift γ x =
      (fun i ↦ x.2 i / m i, fun i ↦ -gradient U x.1 i - γ*x.2 i) := by
  ext i <;> simp [aField, bField, oDrift] <;> ring''',kind='definition',label='(7.5)',
extra=['M为正对角质量；σ=√(2γk_BT)；OU单步及独立正态资格已在OUPhaseIteration写全。','仅最后短定理证明漂移相加；A/B确定性精确流与O分布精确性各自另列，不用漂移恒等式替代。'])
add('ABExactFlows','7.3.1',270,
'''For the deterministic pieces A and B, the updates correspond to their flow maps, while the update for the O piece corresponds to the solution derived in (7.3).''',
'''theorem driftStep_derivative (m : V n) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (driftStep m s x).1 i) (x.2 i / m i) t := by
  simpa [driftStep, mul_div_assoc] using ((hasDerivAt_id t).mul_const (x.2 i / m i)).const_add (x.1 i)

theorem kickStep_derivative (U : V n → ℝ) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (kickStep U s x).2 i) (-gradient U x.1 i) t := by
  sorry''',
extra=['逐坐标A位置/B动量真实时间导数；另一个分量由更新定义恒定；O精确性引用OUTransitionLaw未证陈述，不冒称全部已证。'],
scope='A/B非恒定坐标的精确微分关系；O部分见MD-7.3-OUExactUpdate。',missing='kickStep导数三条短路线均未通过；停止该条，保留陈述。')
add('ABForward','7.3.1',270,
r'''The relevant forward propagators for each piece of the Hamiltonian part are computed through the adjoint of the Lie derivatives as
\[\mathcal L_A^\dagger=-M^{-1}p\cdot\nabla_q,\qquad
\mathcal L_B^\dagger=\nabla U(q)\cdot\nabla_p.\]''',
'''def aForward (m : V n) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  -∑ i, x.2 i / m i * coordDerivative (fun q ↦ f (q,x.2)) x.1 i
def bForward (U : V n → ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, gradient U x.1 i * coordDerivative (fun p ↦ f (x.1,p)) x.2 i''',kind='definition',
extra=['以真实偏导定义所印微分表达式；形式伴随解释要求足够光滑及边界通量消失，未声称一般强算子域。'])
add('ABOBABO','7.3.1',270,
r'''For example, the method denoted $[ABO]$ (acting from left to right) has a resulting update
\[\mathcal U_h^{[ABO]}=\mathcal U_h^O\circ\mathcal U_h^B\circ\mathcal U_h^A.\]
An alternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme denoted $[BABO]$ with associated map
\[\mathcal U_h^{[BABO]}=\mathcal U_h^O\circ\mathcal U_{h/2}^B\circ\mathcal U_h^A\circ\mathcal U_{h/2}^B.\]''',
'''def abo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U h ∘ driftStep m h
def babo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2)''',kind='definition',
extra=['字母从左到右执行，函数复合从右到左；随机变量独立资格由vectorNormalSequence约束。'])
add('WordConvention','7.3.1',270,
r'''As a result we use the convention that if a letter appears $k$ times in a method's string, then each individual update piece uses a timestep $h/k$. For example, the scheme denoted $[OABAOBAO]$ has an update
\[\mathcal U_h^{[OABAOBAO]}=\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O,\]
where the random numbers used in each O update are independent. This scheme will require a total of $4N_c$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.''',
'''def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 3 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/3) (R 2) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/3) (R 1) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/3) (R 0)

theorem oabaobaoCount : (["O","A","B","A","O","B","A","O"] : List String).count "O" = 3 := by decide''',
kind='definition',issues=['已目视核对PDF291／印刷270：字串OABAOBAO有3个O，所印复合也仅3个O，却各用h/4并称4N_c个正态数；不符前句每字母总时长h的约定。'],
extra=['原文图式照录3个h/4的O；修正版改3个h/3和3N_c随机数。力求值次数为实现说明，未形式化成本模型。','每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。'],
scope='完整复合图式、O计数及时间分配修正；力求值说明列于上下文，不声称已证明计算成本。',verdict='NEEDS_HUMAN')
