import MolecularDynamics.Chapter06.BrownianSpectralAverage
open MeasureTheory Filter Topology
open scoped InnerProductSpace
#check Complex.ofRealCLM.compLpL 2 (volume : Measure ℝ)
#check Complex.ofRealCLM.coeFn_compLpL
#check Complex.reCLM.compLpL 2 (volume : Measure ℝ)
#check Complex.imCLM.compLpL 2 (volume : Measure ℝ)
#check Complex.re_add_im
#check Lp.norm_def
#check eLpNorm_congr_norm_ae
#check L2.inner_def
#check RCLike.inner_apply
#check ContinuousLinearMap.integral_comp_comm
#check ContinuousLinearMap.hasSum
#check Submodule.isClosed_topologicalClosure
#check IsClosed.mem_of_tendsto
#check Submodule.sum_mem
#check Submodule.le_topologicalClosure
#check Submodule.subset_span
#check Submodule.eq_top_iff'
#check orthonormal_iff_ite
#check algebraMap_smul