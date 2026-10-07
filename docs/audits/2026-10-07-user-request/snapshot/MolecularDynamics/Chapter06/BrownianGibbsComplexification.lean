import MolecularDynamics.Chapter06.BrownianSpectralAverage

/-! Actual complexification and complete complex eigenbasis for the same original Gibbs measure.
This provides a dependency for the complex generator spectrum; that spectrum is not assumed here. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace

namespace MolecularDynamics
noncomputable section

private abbrev Gibbs {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)
private abbrev GibbsComplex {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) :=
  Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β)

variable {Nc : ℕ} (U : (Fin Nc → ℝ) → ℝ) (β : ℝ)

/-- The actual real-to-complex map on the entire original Gibbs L2 spaces for precisely the same measure. -/
def textbookBrownianGibbsL2Complexify : Gibbs U β →L[ℝ] GibbsComplex U β :=
  Complex.ofRealCLM.compLpL 2 (textbookConfigurationTorusGibbsMeasure U β)

/-- The actual real-part map on the entire original complex Gibbs L2. -/
def textbookBrownianGibbsL2RealPart : GibbsComplex U β →L[ℝ] Gibbs U β :=
  Complex.reCLM.compLpL 2 (textbookConfigurationTorusGibbsMeasure U β)

/-- The actual imaginary-part map on the entire original complex Gibbs L2. -/
def textbookBrownianGibbsL2ImagPart : GibbsComplex U β →L[ℝ] Gibbs U β :=
  Complex.imCLM.compLpL 2 (textbookConfigurationTorusGibbsMeasure U β)

/-- Actual AE representative values of the original Gibbs complexification. -/
theorem textbookBrownianGibbsL2Complexify_ae (x : Gibbs U β) :
    textbookBrownianGibbsL2Complexify U β x =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      fun Q ↦ (x Q : ℂ) :=
  Complex.ofRealCLM.coeFn_compLpL x

/-- Actual AE representative values of the original Gibbs real-part map. -/
theorem textbookBrownianGibbsL2RealPart_ae (z : GibbsComplex U β) :
    textbookBrownianGibbsL2RealPart U β z =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      fun Q ↦ (z Q).re :=
  Complex.reCLM.coeFn_compLpL z

/-- Actual AE representative values of the original Gibbs imaginary-part map. -/
theorem textbookBrownianGibbsL2ImagPart_ae (z : GibbsComplex U β) :
    textbookBrownianGibbsL2ImagPart U β z =ᵐ[textbookConfigurationTorusGibbsMeasure U β]
      fun Q ↦ (z Q).im :=
  Complex.imCLM.coeFn_compLpL z

/-- Real part is a genuine left inverse on the entire original real Gibbs space. -/
theorem textbookBrownianGibbsL2RealPart_complexify (x : Gibbs U β) :
    textbookBrownianGibbsL2RealPart U β (textbookBrownianGibbsL2Complexify U β x) = x := by
  apply Lp.ext
  filter_upwards [textbookBrownianGibbsL2RealPart_ae U β (textbookBrownianGibbsL2Complexify U β x),
    textbookBrownianGibbsL2Complexify_ae U β x] with Q hR hJ
  rw [hR, hJ, Complex.ofReal_re]

/-- Imaginary part of every actual embedded real Gibbs vector is genuinely zero. -/
theorem textbookBrownianGibbsL2ImagPart_complexify (x : Gibbs U β) :
    textbookBrownianGibbsL2ImagPart U β (textbookBrownianGibbsL2Complexify U β x) = 0 := by
  apply Lp.ext
  filter_upwards [textbookBrownianGibbsL2ImagPart_ae U β (textbookBrownianGibbsL2Complexify U β x),
    textbookBrownianGibbsL2Complexify_ae U β x, Lp.coeFn_zero (E := ℝ)
      (p := (2 : ENNReal)) (μ := textbookConfigurationTorusGibbsMeasure U β)] with Q hI hJ h0
  rw [hI, hJ, Complex.ofReal_im, h0]
  rfl

/-- Every entire complex Gibbs vector is actually reconstructed from its genuine real and imaginary parts. -/
theorem textbookBrownianGibbsL2Complexify_decomposition (z : GibbsComplex U β) :
    textbookBrownianGibbsL2Complexify U β (textbookBrownianGibbsL2RealPart U β z) +
      Complex.I • textbookBrownianGibbsL2Complexify U β (textbookBrownianGibbsL2ImagPart U β z) = z := by
  let a := textbookBrownianGibbsL2RealPart U β z
  let b := textbookBrownianGibbsL2ImagPart U β z
  apply Lp.ext
  filter_upwards [Lp.coeFn_add (textbookBrownianGibbsL2Complexify U β a)
      (Complex.I • textbookBrownianGibbsL2Complexify U β b),
    Lp.coeFn_smul Complex.I (textbookBrownianGibbsL2Complexify U β b),
    textbookBrownianGibbsL2Complexify_ae U β a, textbookBrownianGibbsL2Complexify_ae U β b,
    textbookBrownianGibbsL2RealPart_ae U β z, textbookBrownianGibbsL2ImagPart_ae U β z]
      with Q hsum hsmul ha hb hre him
  simp only [Pi.add_apply, Pi.smul_apply] at hsum hsmul
  rw [hsum, hsmul, ha, hb]
  change (a Q : ℂ) + Complex.I * (b Q : ℂ) = z Q
  change a Q = (z Q).re at hre
  change b Q = (z Q).im at him
  rw [hre, him, mul_comm Complex.I]
  exact Complex.re_add_im (z Q)

/-- Actual whole Gibbs complexification preserves the true original L2 norm. -/
theorem textbookBrownianGibbsL2Complexify_norm (x : Gibbs U β) :
    ‖textbookBrownianGibbsL2Complexify U β x‖ = ‖x‖ := by
  rw [Lp.norm_def, Lp.norm_def]
  congr 1
  apply eLpNorm_congr_norm_ae (Lp.aestronglyMeasurable _) (Lp.aestronglyMeasurable _)
  filter_upwards [textbookBrownianGibbsL2Complexify_ae U β x] with Q hQ
  rw [hQ, Complex.norm_real]

/-- The actual whole Gibbs complexification is injective. -/
theorem textbookBrownianGibbsL2Complexify_injective :
    Function.Injective (textbookBrownianGibbsL2Complexify U β) := by
  intro x y h
  have hr := congrArg (textbookBrownianGibbsL2RealPart U β) h
  simpa only [textbookBrownianGibbsL2RealPart_complexify] using hr

/-- The true complex Hilbert pairing of embedded real Gibbs vectors is precisely the real original pairing embedded in the complex numbers. -/
theorem textbookBrownianGibbsL2Complexify_inner (x y : Gibbs U β) :
    ⟪textbookBrownianGibbsL2Complexify U β x, textbookBrownianGibbsL2Complexify U β y⟫_ℂ =
      (⟪x, y⟫_ℝ : ℂ) := by
  rw [L2.inner_def, L2.inner_def]
  change (∫ Q, ⟪(textbookBrownianGibbsL2Complexify U β x) Q,
      (textbookBrownianGibbsL2Complexify U β y) Q⟫_ℂ ∂textbookConfigurationTorusGibbsMeasure U β) =
    Complex.ofRealCLM (∫ Q, ⟪x Q, y Q⟫_ℝ ∂textbookConfigurationTorusGibbsMeasure U β)
  rw [← Complex.ofRealCLM.integral_comp_comm (L2.integrable_inner (𝕜 := ℝ) x y)]
  apply integral_congr_ae
  filter_upwards [textbookBrownianGibbsL2Complexify_ae U β x,
    textbookBrownianGibbsL2Complexify_ae U β y] with Q hx hy
  rw [hx, hy]
  simp [RCLike.inner_apply, mul_comm]

variable (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
  (hU : ContDiff ℝ ∞ U) (hPU : textbookUnitPeriodicPotential U) (hβ : 0 < β)

/-- The embedded actual full real eigenbasis is genuinely complex orthonormal for the same original Gibbs measure. -/
theorem textbookBrownianGibbsComplexEigenmodes_orthonormal :
    Orthonormal ℂ (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦
      textbookBrownianGibbsL2Complexify U β (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j)) := by
  classical
  rw [orthonormal_iff_ite]
  intro i j
  rw [textbookBrownianGibbsL2Complexify_inner,
    orthonormal_iff_ite.mp (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ).orthonormal]
  split_ifs <;> simp

/-- The actual embedded entire real eigenbasis is a complete complex Hilbert basis of the same whole original Gibbs space, with every original eigenmode and multiplicity. -/
def textbookBrownianGibbsComplexEigenbasis :
    HilbertBasis (textbookBrownianGibbsEigenIndex m U hU hPU β) ℂ (GibbsComplex U β) := by
  classical
  let b := textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ
  let J := textbookBrownianGibbsL2Complexify U β
  let s := Submodule.span ℂ (Set.range (fun j ↦ J (b j)))
  let K := s.topologicalClosure
  have hJ (x : Gibbs U β) : J x ∈ K := by
    have hs := J.hasSum (b.hasSum_repr x)
    refine s.isClosed_topologicalClosure.mem_of_tendsto hs ?_
    exact Filter.Eventually.of_forall fun F ↦ K.sum_mem fun j _ ↦ by
      rw [map_smul]
      rw [← algebraMap_smul ℂ (b.repr x j) (J (b j))]
      exact K.smul_mem _ (s.le_topologicalClosure (Submodule.subset_span ⟨j, rfl⟩))
  refine HilbertBasis.mk
    (textbookBrownianGibbsComplexEigenmodes_orthonormal U β m hm hU hPU hβ) ?_
  intro z _
  change z ∈ K
  rw [← textbookBrownianGibbsL2Complexify_decomposition U β z]
  exact K.add_mem (hJ _) (K.smul_mem Complex.I (hJ _))

/-- Each genuine complex basis vector is exactly the embedded original real eigenmode, preserving the actual index and multiplicity. -/
theorem textbookBrownianGibbsComplexEigenbasis_apply (j : textbookBrownianGibbsEigenIndex m U hU hPU β) :
    textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ j =
      textbookBrownianGibbsL2Complexify U β (textbookBrownianGibbsEigenbasis m hm U hU hPU β hβ j) := by
  simp only [textbookBrownianGibbsComplexEigenbasis, HilbertBasis.coe_mk]

/-- Every entire original complex Gibbs vector has an actual convergent full eigenmode expansion. -/
theorem textbookBrownianGibbsComplexEigenbasis_hasSum (z : GibbsComplex U β) :
    HasSum (fun j : textbookBrownianGibbsEigenIndex m U hU hPU β ↦
      ⟪textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ j, z⟫_ℂ •
        textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ j) z := by
  simpa only [HilbertBasis.repr_apply_apply] using
    (textbookBrownianGibbsComplexEigenbasis U β m hm hU hPU hβ).hasSum_repr z

end
end MolecularDynamics