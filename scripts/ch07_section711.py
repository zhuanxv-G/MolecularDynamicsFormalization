from ch07_data import add, EXCLUDED

add('TemperatureObservables','7.11.1',310,
r'''Indeed, calculating the temperature of the system from an average of kinetic energy by
\[N_dk_BT=\langle p^TM^{-1}p\rangle,\tag{7.41}\]
gives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature
\[N_dk_BT=\langle q\cdot\nabla U(q)\rangle.\tag{7.42}\]
Were one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.''',
'''def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry''',label='(7.41)–(7.42)',
extra=['无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。','构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。'],
missing='需Gaussian二阶矩和多维Gibbs积分分部桥；不新建遍历性理论。')

add('VelocityAutocorrelationDefinition','7.11.1',310,
r'''The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.''',
'''def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]''',kind='definition',
extra=['原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。','已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。'])
EXCLUDED.extend([
 {'section':'7.11','printed_page':'308–316','reason':'丙氨酸二肽真空/水溶液、全部图7.5–7.10、热图、直方图、稳定步长阈值、经验平均误差和算法经验排序不作待证；温度数学恒等式和自相关定义另保留。'},
 {'section':'7.11.1','printed_page':'309–311','reason':'势及函数空间假设沿用前章的遍历性解释仅作上下文；本节未给新的完整谱/遍历定理，不将无条件全空间探索当作已证结论。'}])
