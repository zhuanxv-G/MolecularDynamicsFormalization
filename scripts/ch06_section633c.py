"""Inactive draft: the complete plotted frequency families and missing weak-force qualifications."""
from ch06_data import add,NS
add('FrequencyMemoryKernel','6.3.3',237,[61],r'''\[\psi(t)=k^{-1}\sum_{i=1}^k\cos(\Omega_i(t)).\]''','''def frequencyMemoryKernel {k : ℕ} (Ω : Fin k → ℝ) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹*∑ i, Real.cos (Ω i*t)''',kind='definition',extra=['[EXTRA]以实际给定频率直接表达原核，方便记录图6.4/6.5全部数值族；k>0用于物理解释，有限函数定义不计δ极限已证。'])
add('Figure64Frequencies','6.3.3',238,[61,62],r'''Fig. 6.4 The memory kernel $\psi$ is shown for three different sets of frequencies $\Omega_i$. Blue: $k=400$, $\Omega_i=0.01i$; red: $k=1,000$, $\Omega_i\sim U[0,1]$; green: $k=1,000$, $\Omega_i=10\widehat\Omega_i$, where $\widehat\Omega_i\sim U[0,1]$.''','''def figure64Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (blue : Fin 400 → ℝ) (red green : Fin 1000 → A → ℝ) : Prop :=
  (∀ i, blue i=(1/100 : ℝ)*(i.val+1)) ∧
  (∀ i, HasLaw (red i) (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ i, HasLaw (fun sample ↦ green i sample/10) (volume.restrict (Icc (0 : ℝ) 1)) P''',kind='definition',label='Fig. 6.4',extra=['[EXTRA]Fin下标val+1恢复原i=1,…,k；长度1区间限制Lebesgue测度是U[0,1]，记录原边际law，未擅加原未明说的独立性。green/10完整表示10×Uniform频率。图中核使用前条实际频率求和定义。'])
add('Figure65Frequencies','6.3.3',238,[62],r'''Fig. 6.5 The memory kernels $\psi$ are shown for various choices of $\Omega_i^{(k)}$. Left: $\Omega_i^{(k)}=i/\sqrt k$, $k=5^2,10^2,\ldots,35^2$; center: $\Omega_i=\sqrt k\widehat\Omega_i$, $\widehat\Omega_i\sim U[0,1]$, $k=10,20,\ldots,100$; right: $\Omega_i=k\widehat\Omega_i$, $\widehat\Omega_i\sim U[0,1]$, $k=10,20,\ldots,100$. In each case the red curve indicates the largest value of $k$ considered, whereas green indicates the smallest value.''','''def figure65Frequencies {A : Type*} [MeasurableSpace A] (P : Measure A)
    (left : (k : ℕ) → Fin k → ℝ) (center right : (k : ℕ) → Fin k → A → ℝ) : Prop :=
  (∀ j ∈ Finset.range 7, ∀ i : Fin ((5*(j+1))^2),
    left ((5*(j+1))^2) i=(i.val+1 : ℝ)/Real.sqrt ((5*(j+1))^2 : ℕ)) ∧
  (∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ center (10*(j+1)) i sample/Real.sqrt (10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P) ∧
  ∀ j ∈ Finset.range 10, ∀ i : Fin (10*(j+1)),
    HasLaw (fun sample ↦ right (10*(j+1)) i sample/(10*(j+1) : ℕ))
      (volume.restrict (Icc (0 : ℝ) 1)) P''',kind='definition',label='Fig. 6.5',extra=['[EXTRA]两个原数列分别7/10项、完整全部频率及随机边际；Fin下标+1；不把绘图外观当严格极限定理。'],context=['各图红色为最大k、绿色为最小k；实际η由FrequencyMemoryKernel构造。'])
add('BathForceWeakLimitMeaning','6.3.3','237–238',[62],r'''For large $k$ and for many choices of the frequencies $\Omega_i$ and the initial conditions $\{q_i(0);p_i(0)\}$, function $f(t)$ will take on the character of a Wiener process; in fact the convergence can be shown in the weak sense. We may even take the initial conditions to be randomly distributed [13,205].''','''def bathForceWeakLimitMeaning {A : Type*} [MeasurableSpace A] (P : Measure A)
    (masses : (k : ℕ) → Fin k → ℝ) (q0 p0 : (k : ℕ) → A → (Fin k → ℝ))
    (Q0 : ℝ) (W : ℝ → A → ℝ)
    (forcePaths : (k : ℕ) → (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ))
    (wienerPaths : (T : ℝ) → A → C(Icc (0 : ℝ) T, ℝ)) : Prop :=
  IsPreBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ k, 0 < k → ∀ i, 0 < masses k i) ∧
  (∀ k T sample s, forcePaths k T sample s =
    MolecularDynamics.Chapter06Review.bathForcePrinted (masses k) (q0 k sample) (p0 k sample) Q0 s) ∧
  (∀ T sample s, wienerPaths T sample s=W s sample) ∧
  ∀ T : ℝ, 0 < T → ∀ f : C(Icc (0 : ℝ) T, ℝ) → ℝ,
    Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun k ↦ ∫ sample, f (forcePaths k T sample) ∂P) atTop
      (𝓝 (∫ sample, f (wienerPaths T sample) ∂P))''',kind='definition',verdict='NEEDS_HUMAN',issues=['原many choices没有给热浴初值法则/频率条件/拓扑；此处f像Wiener process、下页f(t)作为Wiener increment还存在力与积分过程的类型疑问。'],extra=['[EXTRA]完整连续路径空间的弱法则，而非只收敛均值/某单时边际；实际有限热浴力路径与Wiener路径逐点关联，只定义原希望的资格，不宣称任意族满足。'],missing='缺精确热浴初始化/谱条件及white-force或integrated-force极限解释；保留疑误，不建大型弱收敛理论。')
