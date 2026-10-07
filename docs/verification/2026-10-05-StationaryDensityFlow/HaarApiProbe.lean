import MolecularDynamics.Chapter08.ThermostatDensity
import MolecularDynamics.Chapter02.LiouvilleVolume
import Mathlib.MeasureTheory.Measure.WithDensity
open MeasureTheory MeasureTheory.Measure
#check MeasureTheory.Measure.prod.instIsAddHaarMeasure
#synth IsAddHaarMeasure (volume : Measure ℝ)
example {Nc : ℕ} (μ : Measure (MolecularDynamics.SymplecticCoordinates Nc)) [IsAddHaarMeasure μ] :
    IsAddHaarMeasure ((μ.prod (volume : Measure ℝ)).prod (volume : Measure ℝ)) := by
  have hμ : SFinite μ := inferInstance
  have hleft : IsAddHaarMeasure (μ.prod (volume : Measure ℝ)) :=
    MeasureTheory.Measure.prod.instIsAddHaarMeasure μ (volume : Measure ℝ)
  letI := hleft
  exact MeasureTheory.Measure.prod.instIsAddHaarMeasure (μ.prod (volume : Measure ℝ))
    (volume : Measure ℝ)
