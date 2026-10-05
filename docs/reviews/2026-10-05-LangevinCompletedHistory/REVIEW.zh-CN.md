# Theorem6.2 actual completed Wiener过去与future独立性依赖

原印刷252/PDF273真实Langevin模型必要依赖；沿用已核对tmp/chapter6-causal/page-273.png。不能把本批独立性记成completed-filtration条件Markov或strongMarkov已完整。

## 实际数学链

记mW=actual Cpath B S的可测comap，固定mathlib eventuallyMeasurableSpace mW(aeP)的可测集合是∃c measurable[mW]，a=ᵐ[P]c。对每t≤S的raw B(t) measurable preimage，用actual Cpath evaluation原像和hB.cont的共同AE equality明确给出见证；所有原P-null a给∅见证。iSup₂_le/sup_le/generateFrom_le推出整个真实F_S≤eventual space。因此每actual completed past事件有原Cpath measurable事件的AE表示。

已接受future Cpath/history Cpath真正独立。对于future事件d和完成化past事件a取见证c，measure_congr(d∩a~d∩c)与IndepFun.meas_inter导出P(d∩a)=P d*P a。P.completion的所有集合值等于原P，所以该公式给真正Indep future-comap/F_S在completed空间，而非仅与原未增广历史独立。

Cpath原AEm给completion真Measurable，逐可测集合map_apply/map_apply_of_aemeasurable及原completion每集合概率一致得到completion Cpath law=原law。actual real/periodic current state由前批Adapted，comap current≤F_S，故实际future/current independent；在completion上概率测度实例直接由原P measure_univ推导、真实measurability和indepFun joint law给product，future边缘以completion law及已接受future Wiener law识别为原Wiener Cpath law。

同一B、原P、同一actual global real/periodic process。unit mass/torus/finite Nc，任意γ/σ；real C² U/global forceLip辅助，periodic原C∞lattice U主模型力Lip已有derived结论。S NNReal，独立性允许任意real T，joint future law需T≥0。F_S null增广没有right-continuity声明。completed条件核/progressive/transition密度/actual generator/Harris与全CORE_SCOPE未完成；负责人签核pending。

## 验证

local01--03都只有∅见证MeasurableSet.empty自动推断原ambient而非mW（早先误从诊断猜为function API）；最终显式@MeasurableSet.empty Ω mW解决；弃用EventuallyEq.inter已改EventuallyEqSet.inter。local04额外completion.map陈述推断原Ω实例，local05显式@Measure.map(NullMeasurableSpace Ω P)解决；8public全文件退出0空日志/零警告。ApiProbe读取真实完整参数，额外无效命名空间check报错已记录，不当成功验收。无heartbeats提升/固定依赖更改。full-check01退出0；9058 jobs/零Lean警告/1108audit基础三公理/141inputs及全部raw SHA复核一致；8public逐名覆盖。 起止2026-10-05T21:26:21.8226687+08:00--2026-10-05T21:30:02.9447291+08:00。负责人最终语义pending。
