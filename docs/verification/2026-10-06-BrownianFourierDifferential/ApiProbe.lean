import MolecularDynamics.Chapter06.BrownianVariance
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
open Set MeasureTheory Filter Topology
open scoped ContDiff BigOperators InnerProductSpace
#check ContinuousLinearMap.proj
#check ContinuousLinearMap.hasFDerivAt
#check HasDerivAt.comp_hasFDerivAt
#check Real.hasDerivAt_cos
#check Real.hasDerivAt_sin
#check Real.contDiff_cos
#check Real.contDiff_sin
#check Complex.exp_sum
#check Complex.exp_mul_I
#check Complex.ofRealCLM
#check MolecularDynamics.textbookConfigurationPartial
#check MolecularDynamics.textbookTorusFourier_lift_contDiff
#check MolecularDynamics.textbookConfigurationTorusProjection_integer_translate
#check UnitAddTorus.hasSum_prod_mFourierCoeff
#check UnitAddTorus.hasSum_sq_mFourierCoeff
