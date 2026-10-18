from ch08_data import add,EXCLUDED
add('NHLWeakStationary','8.4.1','345–346',r'''The NHL method preserves the extended canonical distribution ρ_β exp(-βμξ²/2), by adding an OU thermostat in ξ.''',
'''def weakStationaryNHL (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (ρ : Phase n × ℝ → ℝ) : Prop :=
  probabilityDensity volume ρ ∧ ∀ f : Phase n × ℝ → ℝ,
    ContDiff ℝ ∞ f → HasCompactSupport f →
    (∫ z, nhlGenerator invm U β Q γ f z * ρ z) = 0
theorem nhlWeakStationary (invm : Vec n) (U : Vec n → ℝ) (β Q γ Z : ℝ)
    (hp : thermostatParameters invm β Q) (hγ : 0 < γ) (hZ : 0 < Z)
    (hU : ContDiff ℝ 2 U) (hi : Integrable (nhWeight invm U β Q))
    (hpart : ∫ z, nhWeight invm U β Q z = Z) :
    weakStationaryNHL invm U β Q γ (fun z ↦ nhWeight invm U β Q z/Z) := by
  sorry''',extra=['只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。'],missing='Gibbs积分分部及OU对称性，未将局部生成元式冒充保测流或遍历定理。')
add('PreEquilibriumMeans','8.4.3','354–355',r'''θ̄(t)=∫2Kρ(q,p,ξ,t)dωdξ, ξ̄(t)=∫ξρ(q,p,ξ,t)dωdξ, with normalized pre-equilibrium density ρ.''',
'''def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  ∀ t, 0 ≤ t → probabilityDensity volume (ρ t)''',kind='definition',extra=['ρ非负、可积且归一；外引局部稳定性分析未给闭合方程，列覆盖缺口。'])
add('VelocityRescaling','8.4.4',355,r'''dq=pdt, dp=-∇Udt-Ψ(K)pdt+√(2k_BTΦ(K))p dW; Ψ=(2K-(1+N_d)k_BT)Φ-2k_BTKΦ′. Φ(K)=γ_VR/(2K).''',
'''def rescalingPsi (Φ : ℝ → ℝ) (θ K : ℝ) : ℝ :=
  (2*K-((n:ℝ)+1)*θ)*Φ K-2*θ*K*deriv Φ K
def rescalingDrift (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (z.2, fun i ↦ -gradient U z.1 i-rescalingPsi (n:=n) Φ θ ((∑ j, z.2 j^2)/2)*z.2 i)
def rescalingNoise (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (0, fun i ↦ Real.sqrt (2*θ*Φ ((∑ j, z.2 j^2)/2))*z.2 i)
def originalRescalingPhi (γ K : ℝ) : ℝ := γ/(2*K)
def rescalingAdmissible (Φ : ℝ → ℝ) : Prop :=
  ContDiffOn ℝ ∞ Φ (Ioi 0) ∧ (∀ K, 0 < K → 0 < Φ K) ∧
  (∃ C ε : ℝ, 0 < ε ∧ ∀ K, 0 < K → K < ε → |K*Φ K| ≤ C) ∧
  ∃ C : ℝ, ∃ m : ℕ, ∀ K, 1 ≤ K → |Φ K| ≤ C*K^m
theorem rescalingPsi_original (γ θ K : ℝ) (hK : K ≠ 0) :
    rescalingPsi (n:=n) (originalRescalingPhi γ) θ K =
      (1-((n:ℝ)-1)*θ/(2*K))*γ := by
  sorry''',extra=['Φ在K>0光滑正，KΦ在0附近有界且多项式增长；原始Φ在K=0奇异，未声称全空间光滑扩散或遍历性。'],missing='导数γ/(2K)的商法则短桥接。')
add('RescalingStationary','8.4.4',355,r'''With these definitions, the method preserves the canonical probability density ρ_β. The book does not prove ergodicity.''',
'''theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ Function.support f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry''',extra=['测试函数支撑远离K=0，覆盖弱驻定式；完整随机解与半群不变性列缺口。二阶项冻结f的一阶微分求导，表示Itô Hessian而不混入Stratonovich漂移。'],missing='退化乘性扩散的Gibbs积分分部；不建设一般Fokker–Planck与遍历理论。')
add('ThermostatEfficiency','8.4.5','356–357',r'''efficiency = rate of convergence to equilibrium / rate of growth of perturbation of dynamics. Table 8.1 gives analytic lowest-order estimates; NHL has initially quadratic error.''',
'''def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2

def langevinRateEstimate (γ : ℝ) : ℝ := γ
def langevinEfficiencyEstimate : ℝ := 1
def originalRescalingRateEstimate (γVR : ℝ) : ℝ := γVR
def originalRescalingErrorEstimate (N : ℕ) (γVR t : ℝ) : ℝ := γVR/(N:ℝ)*t
def originalRescalingEfficiencyEstimate (N : ℕ) : ℝ := N
def nhlCriticalEfficiencyEstimate (N : ℕ) : ℝ := 2*N
def rescalingEfficiencyOrder (efficiency : ℕ → ℝ) : Prop :=
  efficiency =O[atTop] (fun N : ℕ ↦ (N : ℝ))''',kind='definition',extra=['表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。','γ>0、θ,Q>0、N>0用于物理解释；一般VR的O(N)给出确切渐近性质定义，没有声称任意Φ族满足它。'],scope='效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的O(N)含义；外引估计定理未证，经验曲线排除。')
for fig,p in [('8.2',373),('8.3',374),('8.4',375)]:
 EXCLUDED.append(dict(printed_page=str(p-21),pdf_page=str(p),object='Figure '+fig,reason='计算轨道的平均能量收敛曲线或自相关曲线为经验数值结果，不作为待证对象。'))
EXCLUDED.append(dict(printed_page='351–354',pdf_page='372–375',object='§8.4.3 数值参数及比较结论',reason='125粒子、625副本、步长与图形观测属数值实验；数学定义均另条保留。'))
