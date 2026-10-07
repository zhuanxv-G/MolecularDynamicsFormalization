import MolecularDynamics.Chapter06.LangevinCompletedHistory
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ProbabilityTheory
set_option pp.universes false in
#check @condDistrib
#check MeasurableSpace.comap_id
#check MeasureTheory.Measure.ae_completion
#check MeasureTheory.trim_eq_map
#check @IndepFun_iff_Indep
#check @Measurable.of_comap_le
#check @IndepFun.symm
#check @Measurable.congr_ae
