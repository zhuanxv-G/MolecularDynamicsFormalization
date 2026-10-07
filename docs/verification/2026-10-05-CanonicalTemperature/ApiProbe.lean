import MolecularDynamics.Chapter08.ThermostatDensity
import Mathlib.Analysis.Calculus.LineDeriv.IntegrationByParts
open Set Filter MeasureTheory
#check HasCompactSupport.fderiv_apply
#check ContDiff.continuous_fderiv
#check Continuous.integrable_of_hasCompactSupport
#check integral_smul_fderiv_eq_neg_fderiv_smul_of_integrable
#check ContinuousLinearMap.integral_comp_comm
#check Integrable.apply
#check Integrable.eval
#check Pi.basisFun
#check LinearMap.trace_eq_matrix_trace
