"""Preserve the anisotropic force qualification instead of upgrading its plots."""
from ch05_data import add,NS
add('AnisotropicPotential','5.4.1',201,[],r'''Example 5.6 (Anisotropic Oscillator) The anisotropic oscillator was used in Chap. 1 to illustrate the concept of a chaotic dynamical system.''',f'''def anisotropicPotential (κ l ε : ℝ) (z : {NS}E 2) :=
  MolecularDynamics.Chapter01Review.anisotropicEnergy κ l ε (z 0) (z 1) 0 0''',kind='definition',label='Example 5.6',context=['实际第1章既有各向异性弹簧能量在零速度的势；引用正式定义，不改第1章文件。'])
add('AnisotropicAxisPrinted','5.4.1',201,[],r'''Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $E_0$, with positions in a small interval on the positive $x$ axis, $1.05\le x\le1.15$ and $y=0$. For each point $(x,0)$ taken from this set select the initial velocities as $\dot x=0$, $\dot y=[2(E_0-U(x,0))]^{1/2}$. The set $y=0$, $\dot y=0$ is invariant under the differential equations of the perturbed central force problem, since the force acts in the radial direction; our choice of initial conditions ensures that trajectories explore the larger $H=E_0$ energy surface.''',f'''theorem anisotropicAxisPrinted : ∀ (κ l ε : ℝ) (z : ℝ → {NS}Phase 2),
  0 < κ → 0 < l →
  (∀ t,HasDerivAt z ((z t).2,-gradient (anisotropicPotential κ l ε) (z t).1) t) →
  (z 0).1 1=0 → (z 0).2 1=0 → ∀ t,(z t).1 1=0 ∧ (z t).2 1=0 := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]一般各向异性势的力不能凭“central”称径向，x轴正向处的角向导数未必为零；所选初始ẏ通常非零，亦不属于后句y=ẏ=0集合。探索整个能量面的结论只为模拟直觉，未提升为定理。',extra=['[EXTRA]用第1章实际各向异性势陈述全真实轨道上的轴不变义务；κ/l正及全时间可微轨道，不把轴不变结论作假设。'],missing='原各向异性力/轴不变说法需语义裁定；不证明，不恢复第1章。')
add('TwoOscillatorEnergyDecomposition','5.4.1',199,[],r'''On the other hand, the energy surface $H=E$ is the union of all such 2-tori with $E_1+E_2=E$. There is no mechanism for the system to move from one torus to the other, so the system is not ergodic.''',f'''theorem twoOscillatorEnergyDecomposition : ∀ (Ω : Fin 2 → ℝ) (E : ℝ) (z : {NS}E 4),
  ((∑ i,twoOscillatorEnergy Ω i z)=E) ↔
  ∃ c : Fin 2 → ℝ,(∀ i,0 ≤ c i) ∧ (∑ i,c i)=E ∧ (∀ i,twoOscillatorEnergy Ω i z=c i) := by
  sorry''',extra=['[EXTRA]包括c_i=0的退化边界；原“all such 2-tori”字面忽略零分能量层，完整全能量面分解不能遗漏这些层。'],missing='待平方非负及有限和分解短证明；不会以拓扑名称作假设。')
add('CurveImageDimension','5.4.1',202,[],r'''The segment of initial conditions, a one-dimensional object, when transformed by the smooth map defined by solving initial value problems, should result, again, in a one-dimensional object, i.e. a curve. Yet it appears also to provide a dense covering of a two-dimensional region in the position projection.''',f'''theorem curveImageDimension : ∀ n (f : {NS}E n → {NS}E n) Φ (γ : ℝ → {NS}E n),
  {NS}flow f Φ → ContDiff ℝ ⊤ (Function.uncurry Φ) → ContDiff ℝ ⊤ γ →
  (∀ s,deriv γ s ≠ 0) → ∀ t,
  ContDiff ℝ ⊤ (fun s => Φ t (γ s)) ∧ (∀ s,deriv (fun r => Φ t (γ r)) s ≠ 0) := by
  sorry''',extra=['[EXTRA]原“one-dimensional”以实际正则参数曲线及全平滑自治流实现；由群律推出可逆场导数而非假设最终像曲线正则。位置投影未必浸入，且有限时刻的曲线本身不是一般二维开集；视觉稠密覆盖仅作为数值观察保留。'],missing='待真实全流逆映射导数及链式法则的正则曲线短桥；不建设新的流形维数理论。')
