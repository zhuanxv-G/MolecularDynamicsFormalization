"""Eight complete existing Gaussian and stochastic-integral bridges."""
from ch06_data import add,probability_copy
Q='MolecularDynamics/Chapter06/WienerQuadraticVariation.lean'
I='MolecularDynamics/Chapter06/WienerIntegration.lean'
S='MolecularDynamics/Chapter06/WienerStratonovich.lean'
G='MolecularDynamics/Chapter06/WienerDeterministicLaw.lean'
add('WienerMidpointSum','6.2.2',228,[37],r'''The choice $t_k=k\delta t$ (left endpoint) and the choice $t_k=(k+1/2)\delta t$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.''',probability_copy(S,'textbookWienerMidpointSum','wienerMidpointSum'),kind='definition',context=['g=W时真实时间中点W((k+1/2)δt)；一般g中点定义另列。'])
add('GaussianIncrementMean','6.2.2',230,[40],r'''Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
\[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/K;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/K)^2.\]''',
'''theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0 := by
  rw [hX.integral_eq, integral_id_gaussianReal]''',extra=['[EXTRA]任意真实中心Gaussian完整法则推出零均值；增量law桥接先前已保存。'],prior=['ProbabilityTheory.HasLaw.integral_eq','ProbabilityTheory.integral_id_gaussianReal'])
for key,name in [('GaussianIncrementSecond','textbookCenteredGaussian_secondMoment'),('GaussianIncrementFourth','textbookCenteredGaussian_fourthMoment')]:
 add(key,'6.2.2',230,[40],r'''Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
\[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/K;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/K)^2.\]''',probability_copy(Q,name,key[0].lower()+key[1:]),extra=['[EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。'],prior=['MolecularDynamics.'+name])
add('QuadraticMeanSquareError','6.2.2',230,[41],r'''Thus we have
\[I=\sum_{k=0}^{K-1}\mathbb E(\Delta W_{K,k}^2-\delta t)^2
=\sum_{k=0}^{K-1}\mathbb E[\Delta W_{K,k}^4-2\delta t\Delta W_{K,k}^2+\delta t^2]
=\sum_{k=0}^{K-1}[3\delta t^2-2\delta t^2+\delta t^2]=2K\delta t^2=2\tau^2/K.\]''',probability_copy(Q,'textbookWienerQuadraticSum_meanSquareError','quadraticMeanSquareError'),extra=['[EXTRA]实际PreBrownian且K>0；精确误差，不是仅Tendsto0。'],prior=['MolecularDynamics.textbookWienerQuadraticSum_meanSquareError'])
add('SelfItoIntegral','6.2.2',230,[42],r'''The calculation implies that
\[\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).\]''',probability_copy(I,'textbookWienerSelfItoIntegral_exists','selfItoIntegral'),extra=['[EXTRA]真实L²见证、全均方收敛及AE求值三项保留；有限和L²另条补足。'],prior=['MolecularDynamics.textbookWienerSelfItoIntegral_exists'])
add('SelfStratonovichIntegral','6.2.2',230,[43],r'''In contrast, the Stratonovich (midpoint) integral can be calculated as
\[\int_0^\tau W(t)\circ dW(t)=\operatorname{l.i.m.}_{K\to\infty}\sum_{k=0}^{K-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].\]
Writing
\[W(k\delta t+\delta t/2)=W(\frac{(k+1)\delta t+k\delta t}{2})=\frac12(W((k+1)\delta t)+W(k\delta t))+O(\sqrt{\delta t}),\]
allows us to evaluate the integral as
\[\int_0^\tau W(t)\circ dW(t)=\frac12\operatorname{l.i.m.}_{K\to\infty}\sum_{k=0}^{K-1}[W((k+1)\delta t)^2-W(k\delta t)^2]=\frac12W(\tau)^2.\]''',probability_copy(S,'textbookWienerSelfStratonovichIntegral_exists','selfStratonovichIntegral'),extra=['[EXTRA]真实时间中点和、L²见证、整体均方极限、AE求值；原O(√δt)单步启发不足，正式整体均方误差证明不直接丢弃逐步残项。'],prior=['MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists'])
add('Proposition63','6.2.2',231,[44],r'''Proposition 6.3 Let $g$ be a smooth deterministic function and $W(t)$ a Wiener process. The stochastic integral $Y(t)=\int_0^t g(s)dW(s)$ is, for all times $t\geq0$, a normally distributed random variable such that
\[\mathbb E(Y(t))=0;\quad\mathbb E(Y^2(t))=\sigma^2(t)=\int_0^t g(s)^2ds.\]''',probability_copy(G,'textbookWienerDeterministicIto_proposition63','proposition63'),kind='proposition',label='Proposition 6.3',extra=['[EXTRA]实际PreBrownian与C¹ g已足；完整构造L²见证、均方极限、Gaussian law、零均值及二阶矩，不仅保存矩。'],prior=['MolecularDynamics.textbookWienerDeterministicIto_proposition63'],proof='See Exercise 2.',proof_note='原书仅指向习题；按本任务不转录习题。现成正式构造证明桥接。')
