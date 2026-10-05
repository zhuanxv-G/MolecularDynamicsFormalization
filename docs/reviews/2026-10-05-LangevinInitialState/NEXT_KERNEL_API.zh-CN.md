# 下一必要批次：actual transition kernel / deterministic-time conditional Markov

2026-10-05，本地固定 Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435。WienerVectorFuture/LangevinFutureLaw17public已接受472d496；LangevinInitialState9public local03和full-check01均退出0，9054/1063/137零警告、exact源/log SHA及逐名公理审计通过。以下是已查实际API与实施顺序，不是已验证定理。

1. 固定T≥0，μT=P.map(textbookWienerVectorContinuousPath B T)，从hB导出IsProbabilityMeasure μT。real endpoint E_T(x,w)已有joint measurable候选。用((Kernel.id : Kernel realPhase realPhase) ×ₖ Kernel.const realPhase μT).map (fun z↦E_T(z.1,z.2))定义真实K_T，Kernel.IsMarkovKernel.map/Kernel.prod的已查实例给probability kernel。Kernel.map_apply、Kernel.prod_apply、Kernel.id_apply、Kernel.const_apply、Measure.dirac_prod、Measure.map_map识别每个K_T x为μT.map(E_T(x,·))。
2. 对actual global process证明K_T x等于实际X(T) law，使用已接受history endpoint common AE和定义；无新的solution existence/causal/Markov假设。
3. hS(sample) : Icc(0,S)→realPhase为全部实际过去状态，已有derived whole-history AEm。真实future Cpath与hS独立，μfuture=μT，真实noise-history product law已接受；交换到history×future后通过joint E_T(h.end,w)映射，用actual future-path restart把输出识别为同一X(S+T)。目标measure因子分解为 P.map(hS) ⊗ₘ (K_T.comap endpoint measurable_pi_apply)。必要时直接Measure.ext、Measure.compProd_apply、Measure.prod_apply/lintegral_map核实，不把等式当假设。
4. 固定mathlib Probability/Kernel/CondDistrib.lean:164 condDistrib_ae_eq_of_measure_eq_compProd 接AEMeasurable X/Y和真实joint measure等式，返回condDistrib Y X P =ᵐ[P.map X] κ。实际变量历史codomainβ只要求MeasurableSpace；standard Borel/Nonempty条件施加于未来phaseΩ，不要求不可数历史函数类型StandardBorel。未来phase是有限dim real/torus产品，可用既有Borel/Polish实例。
5. 周期K_T用已局部证明joint periodic endpoint Borel map；历史AEm由明确同一real global模型和可测phase projection派生。future/history独立已有actual periodic版；用代表独立periodic restart连接conditional distribution。避免假设代表选择本身可测。
6. 确切条件等式接受后再登记deterministic-time Markov模型；raw AE版本不自动构成逐sample适应，completed filtration仍须另证。density、actual generator识别/Harris/负责人语义签核和整个CORE_SCOPE仍独立未完成。

注意：IndepFun.comp的φ/ψ是隐式命名参数，需(phi := ...)/(psi := ...)对应实际Unicodeφψ。condDistrib同上AEm版可用于实际模型；联合初值map的高阶composition宜先显式声明pair AEm，再推导composition后exact，避免Classical.choose展开heartbeats。
