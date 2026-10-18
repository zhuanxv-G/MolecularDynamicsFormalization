from ch08_data import add,EXCLUDED

add('BerendsenRelaxation','8.10','396–397',r'''Ṫ(t)=γ_T(Ttarget−T(t)), γ_T>0. After Verlet, p←√[1+γ_Th(N_d k_BT/‖p‖²−1)]p.''',
'''def berendsenTemperature (θ T0 γ t : ℝ) : ℝ := θ+(T0-θ)*Real.exp (-γ*t)
theorem berendsenTemperature_derivative (θ T0 γ t : ℝ) :
    HasDerivAt (berendsenTemperature θ T0 γ) (γ*(θ-berendsenTemperature θ T0 γ t)) t := by
  convert (hasDerivAt_const t θ).add (((hasDerivAt_id t).const_mul (-γ)).exp.const_mul (T0-θ)) using 1
  · ext x
    dsimp [berendsenTemperature]
  · dsimp [berendsenTemperature]
    ring
def berendsenRadicand (nd θ γ h E : ℝ) : ℝ := 1+γ*h*(nd*θ/E-1)
def berendsenScale {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Vec n :=
  Real.sqrt (berendsenRadicand n θ γ h (dot p p)) • p
def berendsenScaleQualification {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Prop :=
  0 < n ∧ 0 < θ ∧ 0 < γ ∧ 0 ≤ h ∧ 0 < dot p p ∧ 0 ≤ berendsenRadicand n θ γ h (dot p p)
theorem dot_smul_same {n : ℕ} (c : ℝ) (p : Vec n) : dot (c • p) (c • p)=c^2*dot p p := by
  simp only [dot,Pi.smul_apply,smul_eq_mul,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  ring
theorem berendsenScale_energy {n : ℕ} (θ γ h : ℝ) (p : Vec n)
    (hq : berendsenScaleQualification θ γ h p) :
    dot (berendsenScale θ γ h p) (berendsenScale θ γ h p)=
      (1-γ*h)*dot p p+γ*h*n*θ := by
  rw [berendsenScale,dot_smul_same,Real.sq_sqrt hq.2.2.2.2.2]
  dsimp [berendsenRadicand]
  field_simp [ne_of_gt hq.2.2.2.2.1]
  <;> ring''',extra=['取单位粒子质量的Euclidean动量平方和；有效域显式要求非零动量及非负根号，避免将总化sqrt/division当作物理方法。','只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。'],scope='Berendsen温度方程的显式解、动量缩放、有效域和单次能量恒等式。')

add('CanonicalTotalMomentumGaussian','8.10','397–398',r'''In Euclidean canonical equilibrium, total momenta are sums of independent centered normal particle momenta and hence are centered normal.''',
'''theorem totalMomentum_gaussian {N d : ℕ} (P : Measure Ω) [IsProbabilityMeasure P]
    (p : Ω → ParticleConfig N d) (m : Fin N → ℝ) (θ : ℝ)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (a : Fin d)
    (hind : iIndepFun (fun i sample ↦ p sample i a) P)
    (hlaw : ∀ i, HasLaw (fun sample ↦ p sample i a)
      (gaussianReal 0 (Real.toNNReal (m i*θ))) P) :
    HasLaw (fun sample ↦ totalMomentum (p sample) a)
      (gaussianReal 0 (Real.toNNReal ((∑ i, m i)*θ))) P := by
  sorry''',extra=['结论明确以各粒子坐标的独立正则Gaussian分布为前提；不从“系统遍历”直接推出有限时刻分布。','原页比较直方图和轨迹属于经验试验，未转为普适数学断言。'],missing='有限独立正态和分布、有限和坐标与总动量的桥接。',scope='实际独立Gaussian动量假设下的一坐标总动量分布；非采样收敛定理。')

add('NHLTotalMomentumSign','8.10',398,r'''With central forces and an NHL thermostat, total momentum obeys Ṗ=−ξP, so each component keeps the sign of its initial value.''',
'''def nhlMomentumFactor (ξ : ℝ → ℝ) (t : ℝ) : ℝ := Real.exp (-(∫ s in (0 : ℝ)..t, ξ s))
theorem nhlMomentumFactor_pos (ξ : ℝ → ℝ) (t : ℝ) : 0 < nhlMomentumFactor ξ t := Real.exp_pos _
theorem nhlMomentum_sign (ξ : ℝ → ℝ) (P0 : ℝ) (t : ℝ) :
    (0 < nhlMomentumFactor ξ t*P0 ↔ 0 < P0) ∧
    (nhlMomentumFactor ξ t*P0 < 0 ↔ P0 < 0) := by
  constructor
  · exact mul_pos_iff_of_pos_left (nhlMomentumFactor_pos ξ t)
  · constructor
    · intro h
      by_contra hp
      have hp' : 0 ≤ P0 := le_of_not_gt hp
      have hn := mul_nonneg (le_of_lt (nhlMomentumFactor_pos ξ t)) hp'
      linarith
    · intro h
      exact mul_neg_of_pos_of_neg (nhlMomentumFactor_pos ξ t) h
theorem nhlTotalMomentum_odeSolution (ξ P : ℝ → ℝ) (hξ : Continuous ξ)
    (hP : ∀ t, HasDerivAt P (-ξ t*P t) t) (t : ℝ) :
    P t=nhlMomentumFactor ξ t*P 0 := by
  sorry''',extra=['只对连续ξ及实际标量ODE声明解公式，正指数乘子的符号结论已证；从NHL粒子SDE推出总动量ODE仍需成对力抵消及积分方程桥接。','欧氏空间正负动量不变与特殊初值下遍历性的讨论不扩展为任意系统的遍历性反例。'],missing='线性非自治ODE唯一性与积分因子公式桥接。',scope='总动量标量ODE解目标、正指数因子及显式表达式的符号保持。')

EXCLUDED += [dict(printed_page='396–399',pdf_page='417–420',object='§8.10试验设置、Figure8.8、8.9、8.10及全部轨迹/直方图/误差与自相关比较',reason='18粒子二维周期盒参数、性能、采样优势和统计曲线是经验数值结果；独立数学内容Berendsen公式、Gaussian和、NHL符号已分别保留。'),dict(printed_page='399–401',pdf_page='420–422',object='Exercises（从PDF420的Exercises标题起）',reason='用户明确排除习题；正文止于其前的Figure8.10图注。'),dict(printed_page='402–415',pdf_page='423–436',object='Appendices',reason='已超出第8章正文；用户明确全书正文结束后不做附加章节。')]
