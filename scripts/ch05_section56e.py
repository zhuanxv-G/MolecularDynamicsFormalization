"""Keep the weak PDE and attraction claims separate from discrete invariance."""
from ch05_data import add,NS
add('WeakStationary','5.6',207,[],r'''the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{*}\rho=0$ is the point distribution $\delta[q]\delta[p]$.''',f'''def weakStationaryModel {{n : ℕ}} (f : {NS}E n → {NS}E n) (μ : Measure ({NS}E n)) : Prop :=
  {NS}weakStationary f μ''',kind='definition',extra=['[EXTRA]复用§5.3.2已经定义的真实弱Liouville稳态：所有C∞紧支测试函数的Lie导数可积且配对为零，允许Dirac等奇异概率；与离散Measure.map不变分别陈述，不从名称推出等价。'])
add('WeakAttractor','5.6',207,[],r'''this solution is not “asymptotically stable.”''',f'''def weakAttractor {{n : ℕ}} (Φ : ℝ → {NS}E n → {NS}E n) (μ : Measure ({NS}E n)) : Prop :=
  ∃ m : ℕ,∃ ψ : Fin m → {NS}E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure ({NS}E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : {NS}E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))''',kind='definition',extra=['[EXTRA]“attractive”取概率弱拓扑中某邻域内所有初值概率的有界连续测试函数收敛；邻域以有限测试族和正ε明确，不把个别轨道收敛当全密度吸引。此为三个后续结论共用的技术定义；不添加已收敛或已不变的前提。'])
add('EulerLogField','5.6',207,[],r'''the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{*}\rho=0$ is the point distribution $\delta[q]\delta[p]$.''',f'''def eulerLogField (backward : Bool) (h : ℝ) (z : {NS}E 2) : {NS}E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]''',kind='definition',extra=['[EXTRA]单位振子Euler的实际实线性logarithmic modified场；取h>0时正/负径向率分别对应前/后Euler，旋转率arctan(h)/h。真实模型的一步对应及ODE资格另条，定义本身不证明无限BEA展开收敛。'])
add('EulerLogFlow','5.6',207,[],r'''interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation''',f'''def eulerLogFlow (backward : Bool) (h t : ℝ) (z : {NS}E 2) : {NS}E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]''',kind='definition',extra=['[EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。'])
add('EulerLogCorrespondence','5.6','206–207',[],r'''Let us assume that the perturbed equation is a realistic model for the numerical solutions. Applying Forward Euler to the harmonic oscillator, we have $q_{n+1}=q_n+hp_n$, $p_{n+1}=p_n-hq_n$. As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$.''',f'''theorem eulerLogCorrespondence : ∀ h : ℝ,0 < h →
  (∀ z,eulerLogFlow false h h z={NS}forwardEuler h z ∧
    eulerLogFlow true h h z={NS}backwardEuler h z) ∧
  (∀ backward z t,HasDerivAt (fun s => eulerLogFlow backward h s z)
    (eulerLogField backward h (eulerLogFlow backward h t z)) t) := by
  sorry''',extra=['[EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。'],missing='待指数/反正切三角关系与实际向量ODE导数桥接；保留对应义务，不把定义冒称已证模型识别。')
add('ForwardWeakStationary','5.6',207,[],r'''To put it another way, the only solution, in the weak sense, of $\mathcal L_{\widetilde f}^{*}\rho=0$ is the point distribution $\delta[q]\delta[p]$, and this solution is not “asymptotically stable.”''',f'''theorem forwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField false h) ({NS}diracMeasure 2) ∧
  (∀ μ : Measure ({NS}E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField false h) μ → μ={NS}diracMeasure 2) ∧
  ¬weakAttractor (eulerLogFlow false h) ({NS}diracMeasure 2) := by
  sorry''',extra=['[EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。'],missing='缺弱stationarity到连续流不变的输运/测试函数桥接及概率弱邻域的非吸引论证；不建设大型PDE理论。')
add('BackwardWeakStationary','5.6',207,[],r'''The only (distributional) solution of $\mathcal L_{\widetilde f}^{*}\rho=0$ is again $\delta[q]\delta[p]$, which in this case is attractive.''',f'''theorem backwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField true h) ({NS}diracMeasure 2) ∧
  (∀ μ : Measure ({NS}E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField true h) μ → μ={NS}diracMeasure 2) ∧
  weakAttractor (eulerLogFlow true h) ({NS}diracMeasure 2) := by
  sorry''',extra=['[EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。'],missing='缺弱stationarity到连续流不变的真实输运桥接和概率弱拓扑吸引论证；不建设大型PDE理论。')
add('SymplecticWeakStationary','5.6',207,[],r'''This implies that a density which is a function of $\widetilde H_h$ will remain invariant under the associated Liouville equation. There are many solutions of $\mathcal L_{\widetilde f}^{*}\rho=0$, none of which is attractive.''',f'''theorem symplecticWeakStationary : ∀ h : ℝ,|h| < 2 →
  let f := fun z : {NS}E 2 => WithLp.toLp 2
    ![(gradient ({NS}shadowOscillator h) z) 1,-(gradient ({NS}shadowOscillator h) z) 0]
  ∀ Φ : ℝ → {NS}E 2 → {NS}E 2,{NS}flow f Φ →
    (∀ r : ℝ → ℝ,{NS}probabilityDensity (fun z => r ({NS}shadowOscillator h z)) →
      weakStationary f ({NS}densityMeasure (fun z => r ({NS}shadowOscillator h z)))) ∧
    (∃ μ ν : Measure ({NS}E 2),IsProbabilityMeasure μ ∧ IsProbabilityMeasure ν ∧
      μ ≠ ν ∧ weakStationary f μ ∧ weakStationary f ν) ∧
    (∀ μ : Measure ({NS}E 2),IsProbabilityMeasure μ → weakStationary f μ → ¬weakAttractor Φ μ) := by
  sorry''',extra=['[EXTRA]稳定区|h|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。'],missing='缺真实弱Liouville测试函数变换、归一能量密度构造及全部稳态的弱邻域非吸引论证；保留完整三项，不建设大型算子/输运理论。')
