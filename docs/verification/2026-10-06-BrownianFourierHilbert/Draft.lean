import MolecularDynamics.Chapter06.BrownianGroundStateCore

/-! Genuine real Haar L² Fourier reconstruction for the original mass Laplacian. -/

open Set MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace BigOperators

namespace MolecularDynamics

noncomputable section

local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

/-- The genuine real-to-complex embedding of full Haar L². -/
def textbookHaarL2Complexify (Nc : ℕ) :
    Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
      Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  Complex.ofRealCLM.compLpL 2 volume

/-- The genuine pointwise real part on full complex Haar L². -/
def textbookHaarL2RealPart (Nc : ℕ) :
    Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
      Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) :=
  Complex.reCLM.compLpL 2 volume

/-- Actual almost-everywhere values of complexification. -/
theorem textbookHaarL2Complexify_ae {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookHaarL2Complexify Nc x =ᵐ[volume] fun Q ↦ (x Q : ℂ) :=
  Complex.ofRealCLM.coeFn_compLpL x

/-- Actual almost-everywhere values of the real-part map. -/
theorem textbookHaarL2RealPart_ae {Nc : ℕ}
    (x : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookHaarL2RealPart Nc x =ᵐ[volume] fun Q ↦ (x Q).re :=
  Complex.reCLM.coeFn_compLpL x

/-- Real part is a genuine left inverse on the entire original real Hilbert space. -/
theorem textbookHaarL2RealPart_complexify {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    textbookHaarL2RealPart Nc (textbookHaarL2Complexify Nc x) = x := by
  apply Lp.ext
  filter_upwards [textbookHaarL2RealPart_ae (textbookHaarL2Complexify Nc x),
    textbookHaarL2Complexify_ae x] with Q hR hJ
  rw [hR, hJ, Complex.ofReal_re]

/-- Complexification preserves the genuine L² norm, from actual AE norm equality. -/
theorem textbookHaarL2Complexify_norm {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    ‖textbookHaarL2Complexify Nc x‖ = ‖x‖ := by
  rw [Lp.norm_def, Lp.norm_def]
  congr 1
  apply eLpNorm_congr_norm_ae (Lp.aestronglyMeasurable _) (Lp.aestronglyMeasurable _)
  filter_upwards [textbookHaarL2Complexify_ae x] with Q hQ
  rw [hQ, Complex.norm_real]

/-- The actual full real Hilbert embedding is injective. -/
theorem textbookHaarL2Complexify_injective (Nc : ℕ) :
    Function.Injective (textbookHaarL2Complexify Nc) := by
  intro x y h
  have hr := congrArg (textbookHaarL2RealPart Nc) h
  simpa only [textbookHaarL2RealPart_complexify] using hr

/-- The genuine Fourier series reconstructs every real Haar L² vector. -/
theorem textbookHaarL2RealPart_fourier_hasSum {Nc : ℕ}
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    HasSum (fun n : Fin Nc → ℤ ↦ textbookHaarL2RealPart Nc
      (UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n •
        UnitAddTorus.mFourierLp 2 n)) x := by
  have h := (textbookHaarL2RealPart Nc).hasSum
    (UnitAddTorus.hasSum_mFourier_series_L2 (textbookHaarL2Complexify Nc x))
  simpa only [textbookHaarL2RealPart_complexify] using h

end MolecularDynamics