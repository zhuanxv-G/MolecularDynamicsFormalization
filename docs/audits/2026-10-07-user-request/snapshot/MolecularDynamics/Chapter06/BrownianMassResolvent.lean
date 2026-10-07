import MolecularDynamics.Chapter06.BrownianFourierCompact

/-! Identify the actual compact Fourier map as a genuine two-sided mass resolvent. -/

open MeasureTheory Filter Topology
open scoped ContDiff InnerProductSpace BigOperators LinearPMap

namespace MolecularDynamics

noncomputable section

private local instance brownianMassResolventCircleMeasure : MeasureSpace UnitAddCircle :=
  ⟨AddCircle.haarAddCircle⟩
private local instance brownianMassResolventCircleProbability :
    IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

private theorem coefficient_sub {Nc : ℕ}
    (z w : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) (n : Fin Nc → ℤ) :
    UnitAddTorus.mFourierCoeff (z - w) n =
      UnitAddTorus.mFourierCoeff z n - UnitAddTorus.mFourierCoeff w n := by
  simp only [← UnitAddTorus.mFourierBasis_repr, map_sub, lp.coeFn_sub, Pi.sub_apply]

private theorem realPart_polynomial_tendsto {Nc : ℕ}
    (z : Lp ℂ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    Tendsto (fun s : Finset (Fin Nc → ℤ) ↦
      textbookPeriodicSmoothHaarEmbedding Nc
        (textbookHaarFourierPolynomial (UnitAddTorus.mFourierCoeff z) s))
      atTop (𝓝 (textbookHaarL2RealPart Nc z)) := by
  have h := (textbookHaarL2RealPart Nc).hasSum (UnitAddTorus.hasSum_mFourier_series_L2 z)
  unfold HasSum SummationFilter.unconditional at h
  simpa only [textbookHaarFourierPolynomial_embedding] using h

private theorem mass_partial_le_closed {Nc : ℕ} (m : Fin Nc → ℝ) (β : ℝ) :
    textbookHaarMassPartialOperator m β ≤ textbookHaarMassClosedOperator m β :=
  textbookBrownianHaarGroundStatePartialOperator_le_closed m (fun _ ↦ 0)
    contDiff_const (by intro _ _; rfl) β

private theorem inverse_weight_identity {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) (n : Fin Nc → ℤ) :
    (-textbookMassFourierFrequency m β n) * textbookMassFourierInverseWeight m β n =
      textbookMassFourierInverseWeight m β n - 1 := by
  have hn := textbookMassFourierFrequency_nonneg m hm β hβ n
  have hne : 1 + textbookMassFourierFrequency m β n ≠ 0 := by linarith
  unfold textbookMassFourierInverseWeight
  field_simp
  nlinarith

/-- Every full real Haar vector has a genuine resolvent graph preimage, proved by actual smooth graph limits. -/
theorem textbookHaarMassFourierOperator_mem_graph {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) :
    (textbookHaarMassFourierOperator m hm β hβ x,
      textbookHaarMassFourierOperator m hm β hβ x - x) ∈
        (textbookHaarMassClosedOperator m β).graph := by
  let z := textbookHaarMassComplexFourierOperator m hm β hβ (textbookHaarL2Complexify Nc x)
  let w := z - textbookHaarL2Complexify Nc x
  have hcoeff (n : Fin Nc → ℤ) :
      (-textbookMassFourierFrequency m β n : ℂ) * UnitAddTorus.mFourierCoeff z n =
        UnitAddTorus.mFourierCoeff w n := by
    change _ = UnitAddTorus.mFourierCoeff (z - textbookHaarL2Complexify Nc x) n
    rw [coefficient_sub]
    change (-textbookMassFourierFrequency m β n : ℂ) *
      UnitAddTorus.mFourierCoeff
        (textbookHaarMassComplexFourierOperator m hm β hβ (textbookHaarL2Complexify Nc x)) n = _
    rw [textbookHaarMassComplexFourierOperator_coeff]
    change (-textbookMassFourierFrequency m β n : ℂ) *
      ((textbookMassFourierInverseWeight m β n : ℂ) *
        UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n) =
      (textbookMassFourierInverseWeight m β n : ℂ) *
        UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n -
          UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n
    rw [← mul_assoc, ← Complex.ofReal_neg, ← Complex.ofReal_mul, inverse_weight_identity m hm β hβ n,
      Complex.ofReal_sub, Complex.ofReal_one]
    ring
  have hz := realPart_polynomial_tendsto z
  have hw := realPart_polynomial_tendsto w
  have hgen (s : Finset (Fin Nc → ℤ)) :
      textbookHaarMassSmoothGenerator m β
        (textbookHaarFourierPolynomial (UnitAddTorus.mFourierCoeff z) s) =
      textbookHaarFourierPolynomial (UnitAddTorus.mFourierCoeff w) s := by
    rw [textbookHaarFourierPolynomial_generator_coeff]
    congr 1
    funext n
    exact hcoeff n
  have hlimit :
      Tendsto (fun s : Finset (Fin Nc → ℤ) ↦
        (textbookPeriodicSmoothHaarEmbedding Nc
          (textbookHaarFourierPolynomial (UnitAddTorus.mFourierCoeff z) s),
        textbookPeriodicSmoothHaarEmbedding Nc (textbookHaarMassSmoothGenerator m β
          (textbookHaarFourierPolynomial (UnitAddTorus.mFourierCoeff z) s))))
        atTop (𝓝 (textbookHaarL2RealPart Nc z, textbookHaarL2RealPart Nc w)) := by
    simpa only [hgen] using hz.prodMk_nhds hw
  have hgraph := (textbookHaarMassClosedOperator_isClosed m β hβ.ne').mem_of_tendsto
    hlimit (Filter.Eventually.of_forall (fun s ↦
      LinearPMap.le_graph_of_le (mass_partial_le_closed m β)
        ((textbookHaarMassPartialOperator_graph_smooth m β _).mpr
          ⟨textbookHaarFourierPolynomial (UnitAddTorus.mFourierCoeff z) s, rfl⟩)))
  have hRw : textbookHaarL2RealPart Nc w = textbookHaarL2RealPart Nc z - x := by
    dsimp only [w]
    rw [map_sub, textbookHaarL2RealPart_complexify]
  rw [hRw] at hgraph
  exact hgraph

/-- The actual real resolvent has exactly the original complexified inverse-frequency coefficients. -/
theorem textbookHaarMassFourierOperator_coeff {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (x : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) (n : Fin Nc → ℤ) :
    UnitAddTorus.mFourierCoeff
      (textbookHaarL2Complexify Nc (textbookHaarMassFourierOperator m hm β hβ x)) n =
      (textbookMassFourierInverseWeight m β n : ℂ) *
        UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n := by
  have hc := (textbookHaarMassClosedOperator_graph_iff_coeff m β hβ.ne' _ _).mp
    (textbookHaarMassFourierOperator_mem_graph m hm β hβ x) n
  rw [map_sub, coefficient_sub] at hc
  have hsum : (1 + (textbookMassFourierFrequency m β n : ℂ)) *
      UnitAddTorus.mFourierCoeff
        (textbookHaarL2Complexify Nc (textbookHaarMassFourierOperator m hm β hβ x)) n =
      UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n := by
    linear_combination hc
  have hn := textbookMassFourierFrequency_nonneg m hm β hβ n
  have hne : 1 + textbookMassFourierFrequency m β n ≠ 0 := by linarith
  have hreal : textbookMassFourierInverseWeight m β n *
      (1 + textbookMassFourierFrequency m β n) = 1 := inv_mul_cancel₀ hne
  have hid : (textbookMassFourierInverseWeight m β n : ℂ) *
      (1 + (textbookMassFourierFrequency m β n : ℂ)) = 1 := by
    exact_mod_cast hreal
  calc
    _ = 1 * UnitAddTorus.mFourierCoeff
      (textbookHaarL2Complexify Nc (textbookHaarMassFourierOperator m hm β hβ x)) n := by ring
    _ = ((textbookMassFourierInverseWeight m β n : ℂ) *
      (1 + (textbookMassFourierFrequency m β n : ℂ))) *
      UnitAddTorus.mFourierCoeff
        (textbookHaarL2Complexify Nc (textbookHaarMassFourierOperator m hm β hβ x)) n := by rw [hid]
    _ = (textbookMassFourierInverseWeight m β n : ℂ) *
      ((1 + (textbookMassFourierFrequency m β n : ℂ)) *
        UnitAddTorus.mFourierCoeff
          (textbookHaarL2Complexify Nc (textbookHaarMassFourierOperator m hm β hβ x)) n) := by ring
    _ = _ := by rw [hsum]

/-- The actual Fourier map is also the left inverse on the entire genuine mass closed graph. -/
theorem textbookHaarMassFourierOperator_inverse_graph {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β)
    (x y : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))
    (hxy : (x, y) ∈ (textbookHaarMassClosedOperator m β).graph) :
    textbookHaarMassFourierOperator m hm β hβ (x - y) = x := by
  apply textbookHaarL2Fourier_coeff_injective
  intro n
  rw [textbookHaarMassFourierOperator_coeff, map_sub, coefficient_sub]
  have hc := (textbookHaarMassClosedOperator_graph_iff_coeff m β hβ.ne' x y).mp hxy n
  rw [hc]
  have hn := textbookMassFourierFrequency_nonneg m hm β hβ n
  have hne : 1 + textbookMassFourierFrequency m β n ≠ 0 := by linarith
  have hreal : textbookMassFourierInverseWeight m β n *
      (1 + textbookMassFourierFrequency m β n) = 1 := inv_mul_cancel₀ hne
  have hid : (textbookMassFourierInverseWeight m β n : ℂ) *
      (1 + (textbookMassFourierFrequency m β n : ℂ)) = 1 := by
    exact_mod_cast hreal
  calc
    _ = ((textbookMassFourierInverseWeight m β n : ℂ) *
      (1 + (textbookMassFourierFrequency m β n : ℂ))) *
        UnitAddTorus.mFourierCoeff (textbookHaarL2Complexify Nc x) n := by ring
    _ = _ := by rw [hid, one_mul]

/-- The range of the genuine compact Fourier map equals the entire actual closed mass domain. -/
theorem textbookHaarMassFourierOperator_range {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    Set.range (textbookHaarMassFourierOperator m hm β hβ) =
      ((textbookHaarMassClosedOperator m β).domain :
        Set (Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))))) := by
  ext x
  constructor
  · rintro ⟨a, rfl⟩
    obtain ⟨u, hu, _⟩ := (LinearPMap.mem_graph_iff _).mp
      (textbookHaarMassFourierOperator_mem_graph m hm β hβ a)
    change (u : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc)))) =
      textbookHaarMassFourierOperator m hm β hβ a at hu
    rw [← hu]
    exact u.prop
  · intro hx
    let u : (textbookHaarMassClosedOperator m β).domain := ⟨x, hx⟩
    refine ⟨x - textbookHaarMassClosedOperator m β u, ?_⟩
    exact textbookHaarMassFourierOperator_inverse_graph m hm β hβ x
      (textbookHaarMassClosedOperator m β u)
      ((LinearPMap.mem_graph_iff _).mpr ⟨u, rfl, rfl⟩)

/-- The actual original-mass graph closure has a true compact two-sided resolvent at 1. -/
theorem textbookHaarMassClosedOperator_hasCompactResolvent {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (β : ℝ) (hβ : 0 < β) :
    ∃ R : Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))) →L[ℝ]
        Lp ℝ 2 (volume : Measure (UnitAddTorus (Fin Nc))),
      IsCompactOperator R ∧
      (∀ x, (R x, R x - x) ∈ (textbookHaarMassClosedOperator m β).graph) ∧
      (∀ x y, (x, y) ∈ (textbookHaarMassClosedOperator m β).graph → R (x - y) = x) :=
  ⟨textbookHaarMassFourierOperator m hm β hβ,
    textbookHaarMassFourierOperator_isCompact m hm β hβ,
    textbookHaarMassFourierOperator_mem_graph m hm β hβ,
    textbookHaarMassFourierOperator_inverse_graph m hm β hβ⟩

end

end MolecularDynamics