import MolecularDynamics.Chapter06.BrownianGibbsComplexification
open MeasureTheory Filter Topology
open scoped InnerProductSpace LinearPMap
#check Submodule.toLinearPMap
#check Submodule.toLinearPMap_graph_eq
#check LinearPMap.mem_graph_iff
#check LinearPMap.mem_domain_of_mem_graph
#check LinearPMap.mem_graph
#check LinearPMap.IsClosed
#check HilbertBasis.repr_apply_apply
#check HilbertBasis.hasSum_repr
#check lp.memℓp
#check inner_add_right
#check inner_smul_right
#check inner_zero_right
#check Complex.mul_re
#check Complex.mul_im
#check isClosed_iInter
#check isClosed_eq