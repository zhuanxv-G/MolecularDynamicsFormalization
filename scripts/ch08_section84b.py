from ch08_data import add
add('Theorem81','8.4.1','346–348',r'''If A is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on D×R.''',
'''theorem theorem81Printed (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  sorry
theorem theorem81_corrected (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ) (hQ : 0 < Q)
    (hθ : 0 < θ) (hγ : 0 < γ) (hσ : σ ≠ 0)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  exact textbookNHL_hormander A hA hdist Q θ γ σ hσ w hw''',kind='theorem',label='Theorem 8.1',issues=['已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除σ=0；只证明Hörmander张成，不自动获得全局几何遍历性。'],extra=['D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。'],verdict='NEEDS_HUMAN',missing='原文未明确σ≠0的强版本不证；修正版完整桥接。',prior=['textbookNHL_hormander'])
add('ZeroModeInvariant','8.4.1',346,r'''V_k={ (q,p) | u_k·q=0, u_k·p=0 } is an invariant submanifold. D=R^{2Nc}\⋃V_k.''',
'''theorem modeDomain_complement {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian) :
    textbookThermostatModeDomain hA = (⋃ i, textbookNHLZeroMode hA i)ᶜ :=
  textbookThermostatModeDomain_eq_compl_zeroModes hA
theorem zeroMode_invariant {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian)
    (i : Fin n) {a b : ℝ} (q p : ℝ → Vec n) (ξ : ℝ → ℝ)
    (hcq : ContinuousOn q (Icc a b)) (hcp : ContinuousOn p (Icc a b))
    (hξ : ContinuousOn ξ (Icc a b))
    (hq : ∀ t ∈ Ico a b, HasDerivWithinAt q (p t) (Ici t) t)
    (hp : ∀ t ∈ Ico a b, HasDerivWithinAt p (-(A *ᵥ q t)-ξ t • p t) (Ici t) t)
    (hzero : (q a,p a) ∈ textbookNHLZeroMode hA i) :
    ∀ t ∈ Icc a b, (q t,p t) ∈ textbookNHLZeroMode hA i := by
  exact textbookNHL_zeroMode_invariant hA i q p ξ hcq hcp hξ hq hp hzero''',extra=['任意紧时间区间上的实际模态ODE；连续随机热浴路径可逐路径应用，不额外声称SDE解存在。'],prior=['textbookNHL_zeroMode_invariant'])
add('NHLGenerator','8.4.1',348,r'''L_NHL f=M⁻¹p·∇qf-∇U·∇pf-ξp·∇pf+[μ⁻¹(pᵀM⁻¹p-N_dk_BT)-γξ]∂ξf+k_BTγμ⁻¹∂ξ²f.''',
'''def additiveGenerator {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (B : E) (f : E → ℝ) (z : E) : ℝ :=
  fderiv ℝ f z (F z) + fderiv ℝ (fun x ↦ fderiv ℝ f x B) z B / 2
def nhlGenerator (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (f : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  additiveGenerator (nhlDrift invm U β Q γ) (0, Real.sqrt (2*γ/(β*Q))) f z
def nhlLyapunov (U : Vec n → ℝ) (Q a : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∑ i, z.1.2 i^2)/2 + U z.1.1 + Q*(z.2-a)^2/2
def geometricDriftBound {E : Type*} (L : (E → ℝ) → E → ℝ) (V : E → ℝ) : Prop :=
  (∀ z, 0 < V z) ∧ ∃ α δ : ℝ, 0 < α ∧ 0 < δ ∧ ∀ z, L V z ≤ -α*V z+δ''',kind='definition',extra=['采用实际一阶、二阶Fréchet导数；原文省略f的-ξp·∇p理解为作用于f；Q,β,γ须正。'])
add('LyapunovCalculation','8.4.1','348–349',r'''For M=I, φ=‖p‖²/2+U+μ(ξ-a)²/2, Lφ=-a‖p‖²-γμξ(ξ-a)-N_dk_BT(ξ-a)+k_BTγ.''',
'''def nhlLyapunovExpression (P2 U ξ Q θ γ a N : ℝ) : ℝ :=
  -a*P2-γ*Q*ξ*(ξ-a)-N*θ*(ξ-a)+θ*γ
theorem nhlLyapunov_calculation (U : Vec n → ℝ) (β Q γ a : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (hQ : 0 < Q) (hγ : 0 < γ)
    (z : Phase n × ℝ) :
    nhlGenerator (fun _ ↦ 1) U β Q γ (nhlLyapunov U Q a) z =
      nhlLyapunovExpression (∑ i, z.1.2 i^2) (U z.1.1) z.2 Q (1/β) γ a n := by
  sorry
theorem shiftedSquare_bound (ξ a : ℝ) : -ξ^2-a^2 ≤ -(ξ-a)^2/2 := by
  nlinarith [sq_nonneg (ξ+a)]''',extra=['U下界>1且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需C²。'],missing='实际扩散生成元作用于二次能量的链式法则。')
add('LyapunovRatePrinted','8.4.1',349,r'''Choose aγμ-N_dk_BT=0, α=min(2a,γμ), δ=αU_max+γμa²+aN_dk_BT+k_BTγ; then Lφ≤-αφ+δ.''',
'''def lyapunovAlphaPrinted (a γ Q : ℝ) : ℝ := min (2*a) (γ*Q)
def lyapunovAlpha_corrected (a γ : ℝ) : ℝ := min (2*a) γ
theorem lyapunovRatePrinted (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlphaPrinted a γ Q * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlphaPrinted a γ Q*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
theorem lyapunovRate_counterexample :
    ¬ (nhlLyapunovExpression 0 2 10 4 1 1 2 8 ≤
      -lyapunovAlphaPrinted 2 1 4 * ((0:ℝ)/2+2+4*(10-2)^2/2) +
      (lyapunovAlphaPrinted 2 1 4*2+1*4*2^2+2*8*1+1*1)) := by
  norm_num [nhlLyapunovExpression, lyapunovAlphaPrinted]
theorem lyapunovRate_corrected (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlpha_corrected a γ * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlpha_corrected a γ*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry''',issues=['已目视核对原页PDF370：与φ热浴项μ(ξ-a)²/2比较时衰减系数应≤γ，所印min(2a,γμ)对一般μ不足；正参数数值反例已列。'],extra=['修正为min(2a,γ)，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。'],verdict='NEEDS_HUMAN',missing='Printed有反例不证；修正版代数二次型估计待短证。')
add('NHLTimestep','8.4.2',350,r'''The symmetric NHL splitting uses kick, drift, feedback, damping, exact OU, damping, feedback, drift, kick. ζ=√(k_BTμ⁻¹(1-e^{-2γh})).''',
'''def nhlOU (β Q γ h R : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, Real.exp (-γ*h)*z.2 + Real.sqrt ((1-Real.exp (-2*γ*h))/(β*Q))*R)
def forceKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i-h*gradient U z.1.1 i), z.2)
def bathDamping (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i), z.2)
def nhlStep (invm : Vec n) (U : Vec n → ℝ) (β Q γ h R : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  forceKick U (h/2) ∘ nhDrift invm (h/2) ∘ nhFeedback invm β Q (h/2) ∘ bathDamping (h/2) ∘
  nhlOU β Q γ h R ∘ bathDamping (h/2) ∘ nhFeedback invm β Q (h/2) ∘ nhDrift invm (h/2) ∘ forceKick U (h/2)
def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧ ∀ k, HasLaw (R k) (gaussianReal 0 1) P''',kind='definition',extra=['R_n独立标准正态；h≥0、β,Q>0、γ≥0用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。'])
