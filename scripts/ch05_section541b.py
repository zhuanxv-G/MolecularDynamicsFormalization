"""Actual oscillator examples, mixing, and qualified KAM persistence."""
from ch05_data import add,copied,proposition,D,NS,EXCLUDED
add('HarmonicFlow','5.4.1','198–199',[],r'''As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).''',f'''def harmonicFlow (Ω t : ℝ) (z : {NS}E 2) : {NS}E 2 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω*t)+z 1/Ω*Real.sin (Ω*t),
    z 1*Real.cos (Ω*t)-Ω*z 0*Real.sin (Ω*t)]''',kind='definition',extra=['[EXTRA]真实解析振子流，用于完整遍历命题；Ω>0使用资格另条。'])
add('HarmonicErgodic','5.4.1',198,[],r'''As a very simple example, the harmonic oscillator is always ergodic on its energy surfaces (i.e. energy curves, in this case).''',f'''theorem harmonicErgodic : ∀ Ω c : ℝ,0 < Ω → 0 < c →
  {NS}microErgodic (harmonicEnergy Ω) c (harmonicFlow Ω) := by
  sorry''',extra=['[EXTRA]正频率/正能量，真实已定义振子和曲面测度；本条采用逐个L¹可观测量的AE版本，原平滑版本的共同零集量词另保留。'],missing='缺椭圆曲面测度识别与连续时间圆周轨道平均桥接，不建设大型遍历/几何理论。')
add('TwoOscillatorEnergy','5.4.1','198–199',[],r'''Example 5.4 (2D Harmonic System) Consider a two-dimensional harmonic system, i.e. the system with Hamiltonian
\[H=p_1^2/2+p_2^2/2+\Omega_1^2q_1^2/2+\Omega_2^2q_2^2/2,\]
where $\Omega_1$ and $\Omega_2$ are two nonzero parameters. Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1=p_1^2/2+\Omega_1^2q_1^2/2$ and $H_2=p_2^2/2+\Omega_2^2q_2^2/2$.''',f'''def twoOscillatorEnergy (Ω : Fin 2 → ℝ) (i : Fin 2) (z : {NS}E 4) :=
  (z (Fin.natAdd 2 i))^2/2+(Ω i)^2*(z (Fin.castAdd 2 i))^2/2''',kind='definition',label='Example 5.4')
add('TwoOscillatorFlow','5.4.1','198–199',[],r'''Because the two systems involving $q_1,p_1$ and $q_2,p_2$ are not coupled in the equations of motion, this system has two invariants $H_1$ and $H_2$.''',f'''def twoOscillatorFlow (Ω : Fin 2 → ℝ) (t : ℝ) (z : {NS}E 4) : {NS}E 4 :=
  WithLp.toLp 2 ![z 0*Real.cos (Ω 0*t)+z 2/(Ω 0)*Real.sin (Ω 0*t),
    z 1*Real.cos (Ω 1*t)+z 3/(Ω 1)*Real.sin (Ω 1*t),
    z 2*Real.cos (Ω 0*t)-Ω 0*z 0*Real.sin (Ω 0*t),
    z 3*Real.cos (Ω 1*t)-Ω 1*z 1*Real.sin (Ω 1*t)]''',kind='definition',extra=['[EXTRA]明确相空间排列(q1,q2,p1,p2)和真实两个振子流；非零频率资格另条。'])
add('TwoOscillatorTori','5.4.1',199,[],r'''For any $E_1,E_2>0$, the set of points satisfying $H_1=E_1,H_2=E_2$ is a two-dimensional torus. If the frequencies $\Omega_1$ and $\Omega_2$ are not rationally related (i.e. $\Omega_1/\Omega_2$ is an irrational number), then for any $E_1,E_2$ the torus will eventually be filled in by any trajectory. On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.''',f'''theorem twoOscillatorTori : ∀ (Ω : Fin 2 → ℝ) (c : Fin 2 → ℝ),
  (∀ i,Ω i ≠ 0) → (∀ i,0 < c i) →
  let T := {{z : {NS}E 4 | ∀ i,twoOscillatorEnergy Ω i z=c i}}
  (Nonempty (T ≃ₜ (Metric.sphere (0 : {NS}E 2) 1 × Metric.sphere (0 : {NS}E 2) 1))) ∧
  (∀ z ∈ T,∀ t,∀ i,twoOscillatorEnergy Ω i (twoOscillatorFlow Ω t z)=c i) ∧
  (Irrational (Ω 0/Ω 1) → ∀ z ∈ T,closure (range (fun t => twoOscillatorFlow Ω t z))=T) ∧
  (∀ E > 0,¬{NS}setErgodic ({NS}microMeasure (fun z => ∑ i,twoOscillatorEnergy Ω i z) E)
    (twoOscillatorFlow Ω)) := by
  sorry''',label='Example 5.4',extra=['[EXTRA]正分能量、非零频率；“填满”解释为实际轨道稠密，非有限时间覆盖；原总能量面分解包括一个分能量为0的退化圆，不能只以正分能量2-tori穷尽整个集合。'],missing='缺完整椭圆乘积拓扑、Kronecker稠密及正测度不变子域桥接；不建设新的连续遍历理论。')
add('Mixing','5.4.1',199,[64],r'''An even stronger property than the ergodic property is the concept of a mixing system. For a mixing system, the finite time density $\rho(z;t)$ converges, in the weak sense, to the invariant distribution $\rho_\infty(z)$, as $t\to\infty$. That is, we have, for all test functions $\phi$ in some chosen space
\[\lim_{t\to\infty}\langle\phi,\rho(\cdot;t)\rangle=\langle\phi,\rho_\infty\rangle.\]''',f'''def weakMixing {{n : ℕ}} (μ : Measure ({NS}E n)) (Φ : ℝ → {NS}E n → {NS}E n) : Prop :=
  ∀ r φ : {NS}E n → ℝ,Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
  Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 ({NS}average μ φ))''',kind='definition',extra=['[EXTRA]实际不变参考测度上的AC概率初值、有界连续测试函数；参考测度是μ，可取微正则测度；避免旧density r谓词暗中以Lebesgue可积替代微正则可积。'])
add('KAMPersistence','5.4.1',200,[63],r'''The energy surface is three-dimensional (represented as the zero-set of a single constraint in four-dimensional space), but apparently it bifurcates into a collection of isolated components (bounded by two-dimensional closed surfaces). These are none other than the tori predicted by the KAM theory [386].''',proposition('kam_statement'),extra=['[EXTRA]书中引用的KAM持久化作独立完整定理展开：解析近可积Hamiltonian、频率映射非退化和Diophantine条件，实际周期提升的C¹浸入不变环面及动力学共轭；不宣称图中双摆的参数已满足这些资格，也不称环面是三维能量面拓扑连通分支。'],missing='缺当前有限维Hamiltonian KAM/Nash–Moser及不变环面持久化理论；按用户要求不建设。')
EXCLUDED.append(dict(section='5.4.1',printed_page='200–203',pdf_page='221–224',kind='excluded_qualitative',reason='Examples 5.5–5.6的轨迹图、100 million steps、可达域数值边界/视觉混合均为有限模拟观察；保留其动力学背景及KAM引用，不升级为精确遍历/混合定理。'))
