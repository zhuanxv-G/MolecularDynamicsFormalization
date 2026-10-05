# 下一批：actual completed filtration 条件 Markov

目标仍是原印刷252/PDF273 Theorem6.2实际Markov模型必要依赖；不添加一般化交付。当前已接受F_S completed ambient/Adapted及每F_S事件AE等于Cpath过去、future独立于全部F_S。

新文件LangevinCompletedMarkov.lean。定义Ω的history type tag，其唯一measurable instance为实际F_S，使id从NullMeasurableSpace Ω P到该history measurable（F_S.le S）。actual current从history measurable由Adapted。future独立history=id，真实joint law=(history law)×(原Wiener Cpath law)。joint可测endpoint映射与commonAE未来restart得到history/future-state law=history law⊗KT.comap actualCurrent。condDistrib唯一性和ae_of_ae_map给同一实际过程的completed过滤条件分布恒等式。periodic分支保留C∞lattice U并derived forceLip主结论。

NullMeasurableSpace source inference须显式@Measure.map、@Measurable；condDistrib声明需显式原P及P.completion probability instance。condition codomain无standardBorel必要，future state有。沿用accepted私有product-disintegration实际证明可复制为本文件私有必要依赖或先证通用private条件核lemma。

固定mathlib CondDistrib APIs需读取真实声明后探针；全部是待证明路线，不能写成已验证。固定S/T AE，不声称全uncountable时间同一异常集、right-continuity或strongMarkov。其后density/actual generator/Harris，CORE_SCOPE仍未整体完成，负责人语义签核pending。
