# Theorem6.2 actual completed Wiener过滤与实际适应性依赖

原印刷252/PDF273要求真实Langevin Markov模型，沿用已核对original图tmp/chapter6-causal/page-273.png。本批补真实过程的过滤与适应性，不代替密度/generator/Harris证明。

## 实际模型与证明

在NullMeasurableSpace Ω P的ambient可测空间，定义F_S=(⨆t≤S configMeasurable.comap(B t))⊔generateFrom{a|P a=0}。标准vector Wiener的Gaussian逐coordinate AEm推到completed ambient实际Measurable；原所有零测子集NullMeasurable，故F_S≤ambient且单调。每个过去eval实际F_S-measurable，由comap与iSup界证明。所有原P-null subsets每S可测而非只可测的null sets。

completion.trim(F_S≤ambient)局部测度若a测度0，则原P a=0（le_trim），故a属于F_S，得到trim.IsComplete。反向若P a=0，则a local measurable，trim_measurableSet_eq使trim a=P a。由两个方向得到整个local ae filter=原ae P，不只单向AE迁移。

actual Cpath B S在连续样本上每个t eval等于原B(t)，原hB.cont给所有t共同AE；F_S包含原零测子集且local trim complete，将每个actual eval以Measurable.congr_ae证明F_S可测。已核对固定mathlib ContinuousMap.measurable_iff_eval（Borel=iSup eval comap，局部紧/second-countable interval与finite config）直接给Cpath实际可测；无需重建dense retraction，也不对uncountable Pi使用AEMeasurable.of_eval。

actual全时间解在S由同一有限noise history构造endpoint的commonAE identity已接受，endpoint continuous/measurable和actual Cpath local meas给measurable候选。再local trim complete/原AE一致推出原Global X(S)本身F_S可测，故同一actual process Adapted。periodic以原actual projection推导Adapted，不假设代表可测；C∞lattice periodic U主结论推导力globalLip。

任意γ/σ、finite Nc、unit mass/unit torus，real auxiliary C² U/globalLip显式；原periodic主模型C∞lattice U。仅null augmentation，不声称right-continuity/usual conditions/strongMarkov。此前whole-history conditional Markov在原P下已验收，本批不自动声称完成化过滤条件律识别已证明；progressive、density/actual generator/Harris及全CORE_SCOPE仍pending。

## 验证

local01序关系应用和trim命名空间；local02-03 completion type tag与原Ω的实例推断/trim重写冲突；local04只剩ContinuousMap source实例与letI警告。第一次额度自动审批中断仅未执行读文件，非安全否决，local04已terminal。用户继续后实际读取其诊断，local05直接rewrite仍因type tag透明度失败；api01读取完整参数（额外错误来自无效命名空间check，不影响参数证据）。local06以完整@ContinuousMap.measurable_iff_eval显式Ω及F_S参数解决，11public文件退出0空日志/零Lean警告。固定依赖无修改，无heartbeats提升。full-check01 2026-10-05T21:05:07.7047296+08:00--2026-10-05T21:11:39.3824305+08:00退出0；9057 jobs/零Lean警告/1100audit基础三公理/140inputs及全部raw SHA复核一致；11public逐名覆盖。机器验收通过，负责人最终语义签核pending。
