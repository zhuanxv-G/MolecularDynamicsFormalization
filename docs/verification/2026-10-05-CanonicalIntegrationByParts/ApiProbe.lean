import MolecularDynamics.Chapter06.CanonicalTemperature
import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension
import Mathlib.Analysis.Normed.Group.Bounded
open Set Filter MeasureTheory
#check ContDiffBump.contDiff
#check ContDiffBump.one_of_mem_closedBall
#check ContDiffBump.mem_Icc
#check HasCompactSupport.exists_bound_of_continuous
#check HasCompactSupport.fderiv
#check HasCompactSupport.comp_homeomorph
#check Homeomorph.smulOfNeZero
#check tendsto_integral_of_dominated_convergence
#check norm_integral_le_of_norm_le
#check integral_add
#check HasFDerivAt.const_smul
