"""Actual Wiener bridges and the distinction between state and coarse-event conditioning."""
from ch06_data import add,copied,probability_copy,proposition
Q='MolecularDynamics/Chapter06/WienerQuadraticVariation.lean'
C='MolecularDynamics/Chapter06/WienerVectorContinuousPath.lean'
add('WienerNondifferentiable','6.2.1','226–227',[34],r'''In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process.''',proposition('wienerNondifferentiable_statement'),extra=['[EXTRA]实际PreBrownian法则与连续路径版本，结论AE每个正时刻不可微；不将不可微性作前提。'],missing='缺Brownian路径振荡与处处不可微理论；不建大型路径理论，保留完整sorry。')
add('WienerFutureCompletedHistory','6.2.1',227,[35],r'''For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$; this does not depend on whether there is additional information available regarding its value prior to $\min(t,s)$, that is to say, the Wiener process is a Markov process.''',copied('MolecularDynamics/Chapter06/LangevinCompletedHistory.lean','textbookWienerVectorFuture_independent_completed_filtration','wienerFutureCompletedHistory'),extra=['[EXTRA]真实多维Wiener、真实未来连续路径与整个零集完成的过去filtration独立；独立对象全部保留。粗事件条件概率式另条疑误，不将本条视为该式证明。'],prior=['MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration'])
add('GridWienerIncrementLaw','6.2.1',227,[32],r'''For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$.''',probability_copy(Q,'textbookWienerIncrement_hasLaw','gridWienerIncrementLaw'),kind='extra_claim',extra=['[EXTRA]等距T/K网格完整Gaussian法则；任意时刻原结论另条WienerIncrement保留。'],prior=['MolecularDynamics.textbookWienerIncrement_hasLaw'])
add('GridIncrementIndependent','6.2.1',227,[32,35],r'''this does not depend on whether there is additional information available regarding its value prior to $\min(t,s)$.''',probability_copy(Q,'textbookWienerIncrement_independent','gridIncrementIndependent'),kind='extra_claim',extra=['[EXTRA]实际等距有限增量族iIndepFun；整条未来路径独立在上一条保留。'],prior=['MolecularDynamics.textbookWienerIncrement_independent'])
add('WienerContinuousPathEval','6.2.1','226–227',[33],r'''an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process''',copied(C,'textbookWienerVectorContinuousPath_eval','wienerContinuousPathEval'),kind='extra_claim',extra=['[EXTRA]给定连续样本的真实C([0,T],ℝⁿ)值与所有时刻原路径一致；不证明从PreBrownian构造连续修改。'],prior=['MolecularDynamics.textbookWienerVectorContinuousPath_eval'])
add('WienerContinuousPathMeasurable','6.2.1','226–227',[33],r'''an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process''',copied(C,'textbookWienerVectorContinuousPath_aemeasurable','wienerContinuousPathMeasurable'),kind='extra_claim',extra=['[EXTRA]给定真实连续Wiener模型导出整个连续路径空间AE可测性；不是将路径可测结论作假设。'],prior=['MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable'])
add('CoarseMarkovPrinted','6.2.1',227,[35],r'''Let $A(x)$, $B(x)$ and $C(x)$ be three events dependent on state variable $x$, and let $t_+>t_0>t_-$ be three times, then, for a Markov process $X(t)$ we have (using the notation for conditional probability):
\[\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].\]''',
'''theorem coarseMarkovPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∀ (a b c : Set ℝ) (past present future : ℝ≥0),
    MeasurableSet a → MeasurableSet b → MeasurableSet c → past < present → present < future →
    0 < P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) →
    P ((W future ⁻¹' a) ∩ ((W present ⁻¹' b) ∩ (W past ⁻¹' c))) /
      P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) =
    P ((W future ⁻¹' a) ∩ (W present ⁻¹' b)) / P (W present ⁻¹' b) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['印刷用任意粗事件B(X(t0))替代完整当前状态的条件σ代数；一般不成立，例如B=univ时过去事件仍可影响未来。'],missing='不证明粗条件概率字面式；完整当前状态条件期望资格另条定义，现成未来独立桥保留。')
add('StateMarkovMeaning','6.2.1',227,[35],r'''More generally, when we say that a stochastic process is Markovian, we mean that the probability of a future event conditioned on the current state of the process and the past history of the process is the same as the probability conditioned on the current state of the process.''',
'''def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))''',kind='definition',extra=['[EXTRA]明确以真实当前状态σ(Xs)及过去history作条件期望；仅定义完整Markov意义，不计任意过程满足它已证。'])
