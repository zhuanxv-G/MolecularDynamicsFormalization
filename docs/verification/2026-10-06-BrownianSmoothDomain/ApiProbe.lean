import MolecularDynamics.Chapter06.BrownianHilbertCore
import Mathlib.Algebra.Module.Submodule.Equiv
open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace
#check HasFDerivAt.add
#check HasFDerivAt.const_smul
#check ContDiff.const_smul
#check LinearEquiv.ofInjective
#check LinearEquiv.ofInjective_apply
#check LinearEquiv.ofInjective_symm_apply
#check LinearMap.rangeRestrict
#check LinearMap.mem_range_self
#check MemLp.toLp_add
#check MemLp.toLp_const_smul
#check Lp.coeFn_add
#check Lp.coeFn_smul
#check Submodule.mk
#check ContinuousMap.toLp_denseRange
#check UnitAddTorus.span_mFourier_closure_eq_top
