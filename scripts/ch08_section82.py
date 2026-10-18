from ch08_data import add,EXCLUDED
add('GeneralThermostat','8.2',336,r'''ż=J∇H, J constant skew-symmetric; ż=J∇H+Φ(ξ,z), ξ̇=g(ξ,z).''',
'''def generalThermostat {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (z : Vec n × Vec k) : Vec n × Vec k := (J *ᵥ gradient H z.1 + Φ z, g z)
def skewMatrix (J : Matrix (Fin n) (Fin n) ℝ) : Prop := J.transpose = -J''',kind='definition',equations=['8.14','8.15'],extra=['J为常矩阵，Jᵀ=-J；z、ξ为实向量，光滑资格在结论中给出。'])
add('ContinuityProductRule','8.2.1','336–337',r'''∂tρ=-div_z[ρ(J∇H+Φ)]-div_ξ(ρg)=L†ρ; the product rule gives four terms W₁+W₂+W₃+W₄.''',
'''def continuityRHS {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k) : ℝ :=
  -textbookDivergence (fun x ↦ ρ x • F x) z
theorem continuity_productRule {k : ℕ} (F : Vec n × Vec k → Vec n × Vec k)
    (ρ : Vec n × Vec k → ℝ) (z : Vec n × Vec k)
    (hF : DifferentiableAt ℝ F z) (hρ : DifferentiableAt ℝ ρ z) :
    continuityRHS F ρ z = -(fderiv ℝ ρ z (F z)) - ρ z*textbookDivergence F z := by
  rw [continuityRHS, textbookDivergence_density hρ hF]; ring''',extra=['覆盖总散度乘积公式；按z/ξ分拆四项的分量等式与完整连续性方程解理论另列缺口。'],scope='实际Fréchet散度的乘积展开；未声称连续性方程解的存在唯一性。')
add('ThermostatCriterion','8.2.1',337,r'''- [∇z-β∇zH]·Φ + βξᵀμ⁻¹g - ∇ξ·g=0 is the fundamental equation for deterministic thermostats.''',
'''def thermalWeight {k : ℕ} (H : Vec n → ℝ) (Q : Vec k) (β : ℝ)
    (z : Vec n × Vec k) : ℝ := Real.exp (-β*(H z.1 + (∑ i, Q i*z.2 i^2)/2))
theorem thermostatCriterion {k : ℕ} (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (Φ : Vec n × Vec k → Vec n) (g : Vec n × Vec k → Vec k)
    (Q : Vec k) (β : ℝ) (hβ : 0 < β) (hQ : ∀ i, 0 < Q i) (hJ : skewMatrix J)
    (hH : ContDiff ℝ 2 H) (hΦ : ContDiff ℝ 1 Φ) (hg : ContDiff ℝ 1 g) :
    textbookLiouvilleStationary (generalThermostat J H Φ g) (thermalWeight H Q β) ↔
    ∀ z, -(textbookDivergence (fun x ↦ Φ (x,z.2)) z.1) +
      β*fderiv ℝ H z.1 (Φ z) + β*(∑ i, Q i*z.2 i*g z i) -
      textbookDivergence (fun y ↦ g (z.1,y)) z.2 = 0 := by
  sorry''',extra=['原文μ_i在指数中是热质量，统一写Q_i；矩阵μ⁻¹的记号按对角热质量解释。归一化概率密度需另加有限正配分积分。'],missing='一般高维Gaussian链式法则、常反对称矩阵的零散度和变量分裂。')
add('Examples81and82','8.2.1','337–338',r'''Example 8.1 Φ=-ξ(0,p), g=μ⁻¹(p·∇pH-N_d k_BT). Example 8.2 Φ=ξG(z), g=μ⁻¹[∇H-k_BT∇]·G. Configurational choice G=(∇qK,0).''',
'''def generalizedFeedback (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ) (z : Vec n) : ℝ :=
  (fderiv ℝ H z (G z) - textbookDivergence G z/β)/Q
def configurationalFeedback (U K : Vec n → ℝ) (β Q : ℝ) (q : Vec n) : ℝ :=
  (dot (gradient U q) (gradient K q) - textbookDivergence (gradient K) q/β)/Q
theorem generalizedFeedback_stationary (J : Matrix (Fin n) (Fin n) ℝ)
    (H : Vec n → ℝ) (G : Vec n → Vec n) (β Q : ℝ)
    (hJ : skewMatrix J) (hH : ContDiff ℝ 3 H) (hG : ContDiff ℝ 2 G)
    (hβ : 0 < β) (hQ : 0 < Q) :
    textbookLiouvilleStationary
      (fun z : Vec n × ℝ ↦ (J *ᵥ gradient H z.1 + z.2 • G z.1, generalizedFeedback H G β Q z.1))
      (fun z ↦ Real.exp (-β*(H z.1+Q*z.2^2/2))) := by
  sorry''',label='Examples 8.1, 8.2',extra=['Example8.1使用此前完整NH定义；本条单热浴一般G与构型反馈公式，构型全场与驻定证明未单列。'],missing='Bulgac–Kusnezov一般散度抵消计算。')
add('TemperatureIdentity','8.2.1',338,r'''∫ divG ρ dω = -∫∇ρ·G dω = β∫∇H·G ρ dω. T=k_B⁻¹〈∇H·G〉/〈divG〉.''',
'''theorem temperatureIdentity (H : Vec n → ℝ) (G : Vec n → Vec n) (β : ℝ)
    (hH : ContDiff ℝ 2 H) (hG : ContDiff ℝ 1 G) (hcompact : HasCompactSupport G)
    (hβ : 0 < β) :
    (∫ z, textbookDivergence G z * gibbsWeight H β z) =
      β * ∫ z, fderiv ℝ H z (G z) * gibbsWeight H β z := by
  sorry
def phaseTemperature (kB numerator denominator : ℝ) : ℝ := numerator/(kB*denominator)''',extra=['以G紧支撑替代原文未量化的足够快边界衰减；温度比值解释另要求k_B>0、分母非零。'],missing='高维散度定理与Gibbs权重积分分部。')
add('Proposition81','8.2.1','338–339',r'''Two thermostats preserving a(ξ)ρ_β and b(η)ρ_β can be added and preserve a(ξ)b(η)ρ_β.''',
'''theorem proposition81 {H : SymplecticCoordinates n → ℝ} (hH : ContDiff ℝ 2 H) (β c : ℝ)
    {φ₁ φ₂ : SymplecticCoordinates n × ℝ → SymplecticCoordinates n}
    {g₁ g₂ : SymplecticCoordinates n × ℝ → ℝ} {a b : ℝ → ℝ}
    (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (hs₁ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₁ g₁)
      (fun w ↦ a w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (hs₂ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₂ g₂)
      (fun w ↦ b w.2 * textbookHamiltonianGibbsDensity H β c w.1)) :
    textbookLiouvilleStationary
      (textbookCombinedThermostatField (textbookHamiltonianVectorField H) φ₁ φ₂ g₁ g₂)
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) := by
  exact textbookThermostats_additive_proposition81 hH β c hφ₁ hφ₂ hg₁ hg₂ ha hb hs₁ hs₂''',kind='proposition',label='Proposition 8.1',proof='The proof is an immediate consequence of the linearity of the divergence\noperator, since the Liouville operator is constructed from this.',extra=['两个标量辅助变量的实际Liouville驻定版本；非负、归一后称概率密度，流保测性另需完整流存在与Jacobian条件。多维辅助变量未覆盖。'],prior=['textbookThermostats_additive_proposition81'])
add('NHChains','8.2.2','339–340',r'''The Nosé–Hoover chain (8.16)–(8.21) preserves ρ_β exp(-βΣμ_iξ_i²/2).''',
'''def nhChainField (k : ℕ) (invm : Vec n) (U : Vec n → ℝ) (β : ℝ)
    (Q : Fin k → ℝ) (z : Phase n × (Fin k → ℝ)) : Phase n × (Fin k → ℝ) :=
  ((fun i ↦ invm i*z.1.2 i,
    fun i ↦ -gradient U z.1.1 i - (if hk : 0 < k then z.2 ⟨0,hk⟩ else 0)*z.1.2 i),
   fun j ↦ (if hj : j.val = 0 then (kineticTwice invm z.1.2-(n : ℝ)/β)/Q j
     else (Q ⟨j.val-1,by omega⟩ * z.2 ⟨j.val-1,by omega⟩ ^2 - 1/β)/Q j) -
     (if hj : j.val+1 < k then z.2 j * z.2 ⟨j.val+1,hj⟩ else 0))
theorem nhChain_stationary (k : ℕ) (hk : 0 < k) (invm : Vec n) (U : Vec n → ℝ)
    (β : ℝ) (Q : Fin k → ℝ) (hβ : 0 < β) (hQ : ∀ j, 0 < Q j)
    (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhChainField k invm U β Q)
      (fun z ↦ Real.exp (-β*(kineticTwice invm z.1.2/2+U z.1.1+(∑ j, Q j*z.2 j^2)/2))) := by
  sorry''',kind='unnumbered_claim',equations=['8.16','8.17','8.18','8.19','8.20','8.21'],extra=['链长k>0，各热质量Q_j>0、β>0，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。'],missing='任意链长的散度抵消与有限和组合；不建确定性遍历理论。')
EXCLUDED += [dict(printed_page='340–341',pdf_page='361–362',object='§8.2.3 / Figure 8.1',reason='环面轨道、参数敏感性与采样有效性的经验描述；图中谐振子方程为NH链的特例，已由NHChains保留，不将图像提升为严格非遍历定理。')]
