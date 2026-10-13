"""Integral L² qualifications, and full marginal versus increment-process distinction."""
from ch06_data import add,probability_copy
Q='MolecularDynamics/Chapter06/WienerQuadraticVariation.lean'
I='MolecularDynamics/Chapter06/WienerIntegration.lean'
S='MolecularDynamics/Chapter06/WienerStratonovich.lean'
add('QuadraticSumExpectation','6.2.2',229,[39],r'''On the other hand, from (6.7), we have
\[\lim_{K\to\infty}\mathbb E\sum_{k=0}^{K-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau.\]''',probability_copy(Q,'textbookWienerQuadraticSum_integral','quadraticSumExpectation'),extra=['[EXTRA]实际上每个K>0有限和期望已经恰等于τ；均方极限在Prop6.2保留。'],prior=['MolecularDynamics.textbookWienerQuadraticSum_integral'])
for key,path,name,page,old in [('SelfItoLimitL2',I,'textbookWienerSelfItoLimit_memLp',230,42),('SelfItoSumsL2',I,'textbookWienerSelfItoSum_memLp',230,42),('MidpointSumsL2',S,'textbookWienerMidpointSum_memLp',230,43)]:
 add(key,'6.2.2',page,[old],r'''First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.''',probability_copy(path,name,key[0].lower()+key[1:]),kind='extra_claim',extra=['[EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。'],prior=['MolecularDynamics.'+name])
add('DeterministicIntegralProcess','6.2.2',231,[45],r'''Also it is natural to view the stochastic integral as the solution of the stochastic differential equation (SDE) with zero initial condition:
\[dY(t)=g(t)dW(t);\quad Y(0)=0.\tag{6.8}\]''',
'''def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)''',kind='definition',label='(6.8)',extra=['[EXTRA]全部非负时间真实严格L²积分关系；Y0=0从零时间L²极限导出，不能把单时Gaussian独立采样当同一过程。'])
add('DeterministicStrobePrinted','6.2.2',231,[44,45],r'''Finally, we observe that by calculating $\sigma^2(t_n)$ and generating random increments $R_n\sim N(0,\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t_n)$, effectively an exact stroboscopic representation.''',
'''theorem deterministicStrobePrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  ∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (Real.sqrt (∫ s in (0 : ℝ)..times (k+1), g s^2)).toNNReal) P := by
  sorry''',verdict='NEEDS_HUMAN',issues=['生成增量使用σ(tn)而非相邻时刻方差差；单时边际法则也不能确定同一过程联合分布。保持印刷式，不以独立边际偷换过程。'],missing='待网站审计原σ参数意图；完整独立增量更正陈述另列。')
add('DeterministicStrobeCorrected','6.2.2',231,[44,45],r'''Finally, we observe that by calculating $\sigma^2(t_n)$ and generating random increments $R_n\sim N(0,\sigma(t_n))$ we have a discrete representation of the continuous time stochastic process $Y(t_n)$, effectively an exact stroboscopic representation.''',
'''theorem deterministicStrobeCorrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry''',extra=['[EXTRA]相邻时间积分g²为完整增量方差，并保存整个增量族独立性；不是仅单时law；强L²模型。'],missing='现成Prop6.3只打包单时构造；缺同一积分过程全部区间联合Gaussian/独立增量桥接，保留完整sorry。')
add('StochasticDifferentialIntegral','6.2.2',231,[45],r'''Importantly, with appropriate regularity we have the familiar relation from calculus:
\[\int_0^t dY(s)=Y(t)-Y(0).\]''',
'''def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)''',kind='definition',context=['积分形式给出dY及其积分的语义关系；不假设普通样本导数存在，不把定义关系计为一般随机链式法则已证。'])
