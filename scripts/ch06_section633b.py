"""Bath reduction, actual all-mass Langevin model and state-dependent friction."""
from ch06_data import add,copied,proposition,D,NS,RECORDS
def complete_constant_mass_model(name):
 code=copied(D,name)
 if name=='langevinMassSDE':
  regular='''(∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ fun i ↦ -textbookConfigurationPartial U i (X s sample).1-
      γ*(X s sample).2 i) volume 0 T) ∧'''
 else:
  assert name=='brownianMassSDE'
  regular='''(∀ᵐ sample ∂P, ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample))
      volume 0 T) ∧'''
 guards='''(∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧ '''+regular
 return code.replace(': Prop :=',': Prop :=\n  '+guards,1)
add('BathReduction','6.3.3',237,[60],r'''Introducing this formula in (6.23), we obtain a reduced system
\[\dot Q=P;\tag{6.27}\quad\dot P=-U'(Q)-k^{-1}\sum_{i=1}^k(Q-q_i);\tag{6.28}\]
\[=-U'(Q)+f(t)-\int_0^t\eta(t-s)P(s)ds.\tag{6.29}\]''',proposition('bathReduction_statement','bathReduction'),extra=['[EXTRA]保留全部原Hamilton ODE与初值、正质量、真实卷积，按导出正k⁻¹合力；不将约化等式作前提。'],missing='缺受迫振子解及卷积IBP的完整组合桥接；不恢复封存长证明。')
add('BathReductionPrinted','6.3.3',237,[60,61],r'''\[\dot P=-U'(Q)+f(t)-\int_0^t\eta(t-s)P(s)ds.\tag{6.29}\]
\[f(t)=-k^{-1}\sum_{i=1}^k[\cos(\Omega_i t)q_i(0)+\Omega_i^{-1}\sin(\Omega_i t)p_i(0)/\mu_i-\cos(\Omega_i t)Q(0)].\]''',proposition('bathReductionPrinted_statement','bathReductionPrinted'),verdict='NEEDS_HUMAN',issues=['原负f与+f约化式符号冲突；保留完整字面卷积方程。'],missing='不证明符号疑误；网站/导师待裁定。')
add('MemoryKernelDeltaMeaning','6.3.3',238,[62],r'''If sufficient high frequency components are present, then the mass of the memory kernel is typically found to be localized around 0; in such a situation of rapid decay it is found that one may replace the function $\eta$ by a Dirac delta function scaled by a positive coefficient $\gamma$; we say that the system is Markovian or memory-less in this situation and we replace the delay-differential equation (6.29) by the SDEs
\[dQ=Pdt;\tag{6.30}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\tag{6.31}\]''',
'''def memoryKernelDeltaMeaning (masses : (k : ℕ) → (Fin k → ℝ)) (γ : ℝ) : Prop :=
  0 < γ ∧ ∀ f : ℝ → ℝ, ContDiff ℝ ∞ f → HasCompactSupport f →
    Tendsto (fun k ↦ ∫ t, MolecularDynamics.Chapter06Review.memoryKernel (masses k) t*f t)
      atTop (𝓝 (γ*f 0))''',kind='definition',verdict='NEEDS_HUMAN',issues=['原“sufficient high frequency/typically”没有给频率序列、归一化、热浴初值法则及白噪声弱收敛资格，不能声明任意热浴自动满足δ极限。'],extra=['[EXTRA]明确ηk→γδ0的实际分布意义，仅定义该近似资格；不计极限或Langevin推导已证。'],missing='缺具体热浴谱/初值法则、白噪声极限及严格Langevin导出理论；原书也明确略去，不建设。')
add('ScalarLangevin','6.3.3',238,[62],r'''\[dQ=Pdt;\tag{6.30}\quad dP=-U'(Q)dt+\sigma dW-\gamma Pdt.\tag{6.31}\]''',
'''def scalarLangevin {Ω : Type*} [MeasurableSpace Ω] (law : Measure Ω)
    (W Q momentum : ℝ → Ω → ℝ) (U : ℝ → ℝ) (γ σ q0 p0 : ℝ) : Prop :=
  0 < γ ∧ ContDiff ℝ ∞ U ∧
  textbookIsWienerVector (fun t sample (_i : Fin 1) ↦ W t sample) law ∧
  (∀ᵐ sample ∂law, ContinuousOn (fun t ↦ Q t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ momentum t sample) (Ici 0) ∧ momentum 0 sample=p0 ∧ ∀ T : ℝ, 0 ≤ T →
    IntervalIntegrable (fun s ↦ momentum s sample) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -deriv U (Q s sample)-γ*momentum s sample) volume 0 T ∧
    Q T sample=q0+∫ s in 0..T, momentum s sample) ∧
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral law W (fun _ _ ↦ σ) T
    (fun sample ↦ momentum T sample-p0-∫ s in 0..T, -deriv U (Q s sample)-γ*momentum s sample)''',kind='definition',extra=['[EXTRA]真实耦合随机Q(t,sample)及动量漂移、实际可积性、初值与严格Ito积分；无任意样本代替随机状态。'])
add('MassLangevin','6.3.3',239,[63],r'''The equations of motion are, in vectorial form:
\[dq=M^{-1}pdt;\tag{6.32}\quad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{6.33}\]''',complete_constant_mass_model('langevinMassSDE'),kind='definition',label='(6.32)–(6.33)',context=['任意正对角质量m、γ>0、θ=kBT>0均在模型内明确；常噪声的实际路径积分方程完整保留，额外漂移可积资格在具体定理明确；不把单位质量正式桥当一般质量模型已证。'])
add('VariableFriction','6.3.3',239,[64],r'''In particular, a different friction coefficient can be used for each particle and these coefficients can even depend on spatial location, thus we might work with the following system:
\[dq=M^{-1}pdt;\tag{6.34}\quad dp=-\nabla U(q)dt-\Gamma(q)\Gamma(q)^T pdt+\sqrt{2k_BT}M^{1/2}\Gamma(q)d\widetilde W;\tag{6.35}\]
where we use the matrix $\Gamma(q)\in\mathbb R^{N_c\times S}$ and a vector of $S$ independent Wiener processes $\widetilde W$.''',
'''def variableFriction {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ)))
    (m : Fin n → ℝ) (U : (Fin n → ℝ) → ℝ)
    (Γ : (Fin n → ℝ) → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ)
    (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < θ ∧ ContDiff ℝ ∞ U ∧ ContDiff ℝ ∞ Γ ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0 ∧
    ∀ T : ℝ, 0 ≤ T → IntervalIntegrable (fun s ↦ fun i ↦ (m i)⁻¹*(X s sample).2 i) volume 0 T ∧
      (X T sample).1=x0.1+∫ s in 0..T, fun i ↦ (m i)⁻¹*(X s sample).2 i) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ Real.sqrt (2*θ*m i)*Γ (X s sample).1 i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i) volume 0 T ∧
        (X T sample).2 i-x0.2 i-(∫ s in 0..T, -textbookConfigurationPartial U i (X s sample).1-
          ((Γ (X s sample).1*(Γ (X s sample).1).transpose).mulVec (X s sample).2) i)=∑ j, integrals j sample)''',kind='definition',label='(6.34)–(6.35)',extra=['[EXTRA]完整任意矩形Γ(q)、任意质量和真实全部噪声坐标严格Ito积分；未缩成对角或单位质量，不宣称自动Gibbs不变。'])
add('ParticleDiagonalFriction','6.3.3',239,[64],r'''In the case of Langevin dynamics with different, variable friction coefficients for each particle, we have $S=N_c$ and
\[\Gamma=\operatorname{diag}(\gamma_1(q),\gamma_1(q),\gamma_1(q),\gamma_2(q),\gamma_2(q),\gamma_2(q),\ldots,\gamma_N(q),\gamma_N(q),\gamma_N(q)).\]''',
'''def particleDiagonalFriction {N : ℕ} (γ : Fin N → (Fin (N*3) → ℝ) → ℝ)
    (q : Fin (N*3) → ℝ) : Matrix (Fin (N*3)) (Fin (N*3)) ℝ :=
  Matrix.diagonal (fun i ↦ γ ⟨i.val/3, by omega⟩ q)''',kind='definition',context=['每个粒子三个真实坐标重复系数；原Γ记号沿用，无静默平方根替换。'])
add('BrownianMassModel','6.3.4',240,[65],r'''Let $v=M^{-1}p$ and assume that the acceleration is negligible, so that Langevin dynamics reduces to
\[dq=vdt;\quad0=-\nabla U(q)dt-\gamma Mvdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\]
The second equation can be solved for $v$ and we obtain the following SDE for $q$:
\[dq=-\gamma^{-1}M^{-1}\nabla U(q)dt+\sqrt{2k_B\gamma^{-1}T}M^{-1/2}dW.\tag{6.36}\]''',complete_constant_mass_model('brownianMassSDE'),kind='definition',label='(6.36)',context=['任意正质量、γ>0、θ=kBT>0均在模型内明确；全部真实常噪声路径积分模型；仅给方程意义，Kramers–Smoluchowski弱极限另条。'])

for _r in RECORDS:
 if _r["source_id"].split("-")[-1] in ("ScalarLangevin","MassLangevin","VariableFriction","BrownianMassModel"):
  _r["extra_assumptions"].append("[EXTRA]明确真正Wiener driver及当前全域C∞势（Γ模型还要求Γ C∞）的充分技术范围，全部实际漂移可积；不是把不可微梯度或非可积Bochner默认值当经典过程，不声称此范围覆盖奇异势的正规域版本。")
