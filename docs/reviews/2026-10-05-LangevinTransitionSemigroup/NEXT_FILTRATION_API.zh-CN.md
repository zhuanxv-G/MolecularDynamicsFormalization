# 下一完成化Wiener过滤与actual适应性（待实现/未验证路线）

已接受本批actual probability semigroup，不可据此自动声称逐点adapted。原模型B只保证各eval AEm/AE连续，Cpath和global solution使用exceptional sample分支；原自然σ代数不直接容纳该exceptional集合。

## 固定版本已读API

- NullMeasurableSpace Ω P是原Ω的type tag，可测集合=原P的NullMeasurableSet；P.completion在该type上保持所有集合outer measure/ae。AEMeasurable.nullMeasurable.measurable'给在completed ambient的实际可测；不是选另一个process。
- Filtration.natural B hum定义seq S=⨆t≤S, configMeasurableSpace.comap(B t)。这里hum需要每t StronglyMeasurable，可用finite config和completed ambient由原B eval AEm推出。也可直接定义同一iSup并证明mono/ambient le，避免完成化typeclass推断。
- 加入Nullσ=MeasurableSpace.generateFrom {a | P a=0}，seq S=上述iSup⊔Nullσ。NullMeasurableSet.of_null、MeasurableSpace.measurableSet_generateFrom/generateFrom_le证明全部原P-null集合在每time可测，且seqS≤completed ambient。
- Measure.trim_measurableSet_eq hle hs：completion.trim hle在local-measurable集合值等于原P值；Measure.le_trim：原P≤trim。若trim a=0则P a=0，所以seqS含a，得到(trim measure).IsComplete。若原P a=0则seqS可测且trim a=P a，故trim的ae与原P相等（可用ae_iff逐任意predicate证明）；不能只用ae_of_ae_trim倒推。
- Dense sampling：TopologicalSpace.denseSeq (Icc0S)/denseRange_denseSeq，continuous evaluation e:Cpath→(ℕ→config)为continuous injective（用DenseRange.induction_on与isClosed_eq），Cpath Polish→e.measurableEmbedding。MeasurableEmbedding.measurable_invFun与leftInverse_invFun提供实际measurable retraction r；Cpath有zero map故Nonempty。
- 每dense sample时刻t_n≤S，原B(t_n)在seqS实际可测（iSup/comap），samples map Measurable.of_eval成立。r∘samples为seqS-measurable，hB.cont共同AE及Cpath_eval得到r(samples)=Cpath B S；通过local trim ae等于原P以及trim complete上的Measurable.congr_ae，证明actual Cpath B S自身可测。避免对原uncountable time Pi使用AEMeasurable.of_eval（需要Countable）。
- actual endpoint因果恒等式_history_endpoint_ae给Global X(S)=E_S(x,Cpath B S)共同AE；E_S固定初值连续可测，local trim complete+congr_ae给GlobalX(S)在seqS真正可测，∴MeasureTheory.Adapted。periodic同理投影或者已接受periodic_history_endpoint_ae。

## 顺序与范围

新建LangevinFiltration.lean，先single-file检查completed ambient B eval measurable、filter definition/zero sets/trim complete/ae equality，之后Cpath dense retraction meas及actual real/periodic Adapted。给原C∞periodic U derivedLip主结论。同一global process保持不换版本，variance/independence基于原P，未来若移到completion须重新验证law/condDistrib跨measSpace转换。不要声称right-continuous usual augmentation、completed-filtration Markov条件期望、stopping-time strongMarkov或generator/Harris已完整。以上为路线未验收定理，遇到API类型问题先Scratch probe；禁止占位证明或升级固定依赖。
