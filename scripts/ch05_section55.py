"""Real dynamic observables, literal all-trajectory defect, and measure duality."""
from ch05_data import add,copied,proposition,D,NS
add('Correlation','5.5',203,[65],r'''Let $a$ and $b$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $a$ and $b$ (on the surface of energy $E$) by
\[C_{ab}(\tau)\stackrel{\rm def}{=}k\operatorname{Av}_{H=E}(a(\mathcal F_t(z))\cdot b(z))
=kZ_E^{-1}\int_{\Sigma_E}a(\mathcal F_t(z))\cdot b(z)\delta[H-E]d\omega,\]
where $k$ is a normalization constant that is often incorporated to ensure that $C_{ab}(0)=1$.''',copied(D,'correlation'),kind='definition',context=['真实向量内积与µ积分；原左τ右t记号保留、Lean用单个lag参数；k只在零lag非零时能归一。δ积分解释为真实微正则测度配对。'])
add('CorrelationPullback','5.5',204,[66],r'''Using the notation developed earlier for the propagator, this has the alternative formulation
\[C_{ab}(t)=k\operatorname{Av}_{H=E}\left[b(z)\cdot(e^{t\mathcal L}a)(z)\right].\]''',copied('MolecularDynamics/Chapter05/ReviewProofs.lean','correlationPullback_proved','correlationPullback'),prior=['MolecularDynamics.Chapter05Review.correlationPullback_proved'])
add('CorrelationTimePrinted','5.5',204,[],r'''If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $H=E$ energy surface:
\[C_{a,b}(t)=k\lim_{T\to\infty}\frac1T\int_0^T a(z(s+t))\cdot b(z(s))ds.\]''',f'''theorem correlationTimePrinted : ∀ n d (H : {NS}E n → ℝ) c Φ
    (a b : {NS}E n → {NS}E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  {NS}microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) ({NS}microMeasure H c) →
  ∀ z ∈ {NS}energySurface H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 ({NS}correlation ({NS}microMeasure H c) Φ a b k t)) := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]“any trajectory”强于此前AE遍历平均；本字面版保留能量面上全部初值量词，正确AE修正版另条；不能凭概率遍历宣称每条轨道。',extra=['[EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。'],missing='原any与AE的量词冲突待裁定，不证明。')
add('CorrelationTimeAE','5.5',204,[67],r'''$C_{a,b}(t)=k\lim_{T\to\infty}T^{-1}\int_0^T a(z(s+t))\cdot b(z(s))ds$.''',proposition('correlationTime_statement'),extra=['[EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。'],missing='待现有hasTimeAverage的群律重写和常数乘Tendsto短桥。')
add('VelocityCorrelation','5.5',204,[68],r'''The velocity autocorrelation function is often written in the shorthand notation
\[C_{v,v}(t)\stackrel{\rm def}{=}\frac{\langle v(t)\cdot v(0)\rangle}{\langle v(0)\cdot v(0)\rangle},\]
where the averaging may be assumed to be against the microcanonical measure, if otherwise unspecified.''',copied(D,'velocityCorrelation'),kind='definition',context=['真实vector dot相关函数除零lag；分母非零资格另需，0总化除法不赋予归一化意义。'])
add('PositionTransition','5.5',204,[],r'''Now let $A$ and $B$ be subsets of configuration space (i.e. subsets in the position space) of nonzero measure, and define $T_{AB}(\tau)\stackrel{\rm def}{=}C_{1_B,1_A}(\tau)$.''',f'''def positionTransition {{n d : ℕ}} (μ : Measure ({NS}E n)) (Φ : ℝ → {NS}E n → {NS}E n)
    (π : {NS}E n → {NS}E d) (A B : Set ({NS}E d)) (t : ℝ) :=
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)''',kind='definition',context=['π是实际位置投影，配置集合在相空间上的逆像；真实指标乘积平均，不把状态点概率误作首次到达时间。'])
add('TransitionProbability','5.5',204,[69],r'''Dividing $T_{AB}$ by the measure of the set $A$, we obtain the probability for a trajectory to make this transition in the given time, which we may write as
\[\operatorname{Pr}_\tau(A\to B)=\frac{\langle1_B(z(\tau))1_A(z(0))\rangle}{\langle1_A(z(0))\rangle},\]
where the averaging is assumed to be with respect to the microcanonical distribution at given energy $E$.''',copied(D,'transitionProbability'),kind='definition',extra=['[EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。'])
add('MeasureDuality','5.5',205,[70],r'''\[\int_{\Sigma_E}\phi(z)\rho(z;t)d\omega
=\int_{\Sigma_E}\phi(z)e^{t\mathcal L^*}\rho(z,0)d\omega
=\int_{\Sigma_E}[e^{t\mathcal L}\phi(z)]\rho(z,0)d\omega
=\int_{\Sigma_E}\phi(\mathcal F_t(z))\rho(z;0)d\omega
=\int_{\Sigma_E}\phi(\mathcal F_t(z))\frac{\rho(z;0)}{\rho_E(z)}\rho_E(z)d\omega.\tag{5.10}\]''',proposition('measureDuality_statement'),extra=['[EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。'],missing='待Mathlib积分Measure.map/pullback短桥。')
