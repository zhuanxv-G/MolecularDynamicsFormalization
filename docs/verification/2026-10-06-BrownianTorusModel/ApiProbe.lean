import MolecularDynamics.Chapter06.BrownianMarkovModel
import MolecularDynamics.Chapter06.BrownianHilbertCore
open MeasureTheory
#check @Continuous.measurable
#check @AddCircle.coe_add
#check @Measurable.comp
#check @ContinuousMap.measurable_iff_eval
#synth BorelSpace (UnitAddTorus (Fin 2))
#synth BorelSpace (UnitAddTorus (Fin 2) × C(Set.Icc (0 : ℝ) 1, Fin 2 → ℝ))