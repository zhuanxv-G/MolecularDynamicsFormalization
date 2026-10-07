import MolecularDynamics.Chapter06.BrownianTorusGibbs
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.MeasureTheory.Function.LpSpace.ContinuousFunctions
open Set MeasureTheory Filter
open scoped ContDiff RealInnerProductSpace
#check QuotientAddGroup.isOpenQuotientMap_mk
#check IsOpenQuotientMap.piMap
#check IsQuotientMap.continuous_iff
#check ContinuousMap.memLp
#check MemLp.toLp
#check MemLp.coeFn_toLp
#check L2.inner_def
#check RCLike.inner_apply
#check real_inner_self_eq_norm_sq
#check Lp.ext
#check MeasureTheory.integral_congr_ae
#check MeasureTheory.MemLp.congr
#check MeasureTheory.MemLp.add
#check MeasureTheory.MemLp.const_smul
