import MolecularDynamics.Chapter06.ReviewDefinitions
import MolecularDynamics.Chapter07.FormalOperatorFunctionalCalculus
import MolecularDynamics.Chapter07.InvariantDistributionSwap
import Mathlib.Tactic

open Set Filter MeasureTheory ProbabilityTheory MolecularDynamics
open scoped BigOperators Topology ContDiff ENNReal NNReal
noncomputable section
namespace MD.Ch07
variable {Ω : Type*} [MeasurableSpace Ω]
variable {n : ℕ}

/-- source_id: MD-7.1-Bias · 印刷p.263 / PDFp.284
[EXTRA] 将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。 -/
def bias (exact computed : ℝ) : ℝ := |exact - computed|

end MD.Ch07

#print axioms MD.Ch07.bias
