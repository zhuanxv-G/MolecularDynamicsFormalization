# Theorem6.2实际Markov模型的历史与restart依赖（机器验收通过，语义pending）

原页印刷252/PDF273已重新目视，教材工作区tmp/chapter6-causal/page-273.png。Assumption1明确使用真实Markov process/transition kernel；Theorem6.2给唯一不变measure与weighted exponential convergence。原joint density的时间区间目视为[0,∞)，OCR误把∞作1不可复用。该原区间端点语义及真实密度仍独立pending。

## 真实本地证明

LangevinCausalFlow.lean：actual noise EqOn转移、真实C(Icc0A,FinNc→ℝ)历史restriction/1-Lipschitz、chosen endpoint早期history一致。真实Bochner积分拆分/change-variable从原积分方程推导time shift；定义真实noise increment Cpath segment，并通过实际解唯一性证明chosen endpoint restart。continuous zero-start Wiener样本上selected解满足每个真实horizon原模型，再与已接受同一global phase在共同full-measure样本集上证明全部real A whole-interval历史一致和所有real S,T restart；未错误交换不可数AE。

LangevinPeriodicCausalFlow.lean：任意real initial phase真实投影，periodic解构造real lifts后由实际periodic derived globalLip与Gronwall唯一性推导周期唯一。periodic endpoint等于任意real initial代表投影，因而restart真正不依赖代表。明确单一actual periodic global phase，证明原periodic模型在同一AE样本所有real T、逐time AEm、common AE history和全部real S,T increment restart。

标准vector Wiener law/C∞unit-periodic potential/finite Nc/unit mass；辅助real模型C²与actual global forceLip显式。periodic唯一从compact cube推导Lip；endpoint构造函数的L/hF是已证明force bound的输入见证。任意γ/σ均有causal解，概率可达和physical positive noise沿用既有条件。

## 验收与边界

full-check01 2026-10-05T18:44:02.8608590+08:00--2026-10-05T18:45:10.9005763+08:00退出0；Lean4.34.0/mathlib5ed2965256430c3649e86755f9576b54eca72435；9051jobs、零Lean警告、1037audit仅propext/Classical.choice/Quot.sound，134inputs/全部raw日志SHA实查一致，22public全名覆盖。local01仅unused simp、local02 segment加法inclusion类型（elaborator synthetic sorry，实际源码无sorry/admit），periodic-local01 lambda/prod beta及phase类型、local02 AddCircle generic参数均已修复；local04/periodic-local03最终零警告，全部失败原日志保留。

原Wiener Cmap exceptional版本可能查询全时域连续事件，故本批提供common-full-measure因果history/restart，未冒称每个exceptional sample逐点适应。本批不把pathwise cocycle当作已证明Markov条件律；future increments law/历史独立、joint initial-state可测性、completed filtration、transition密度/真正Markov generator识别、Harris及最终语义签核仍pending。全CORE_SCOPE未完成。
