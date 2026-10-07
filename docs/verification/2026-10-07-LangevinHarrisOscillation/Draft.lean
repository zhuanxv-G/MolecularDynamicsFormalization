import MolecularDynamics.Chapter06.LangevinInvariantMoments
import MolecularDynamics.Chapter06.LangevinSkeletonInputs
import Mathlib.MeasureTheory.Measure.Sub
import Mathlib.Probability.Kernel.MeasurableIntegral

/-! Necessary weighted-oscillation and genuine residual-probability dependencies for original Theorem 6.2. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal
namespace MolecularDynamics
noncomputable section

/-- The weighted pairwise oscillation bound used for the original Hamiltonian Harris argument; constants disappear from this genuine difference bound. -/
def textbookLangevinWeightedOscillationBound {N : ℕ}
    (V : textbookLangevinPeriodicPhase N → ℝ) (β : ℝ)
    (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ) : Prop :=
  ∀ x y, ‖f x - f y‖ ≤ C * (2 + β * (V x + V y))

/-- A measurable weighted observable is genuinely integrable under a probability law with a true V moment; no integrability of the observable is separately assumed. -/
theorem textbookLangevinWeightedOscillationBound_integrable {N : ℕ}
    (V : textbookLangevinPeriodicPhase N → ℝ) (β : ℝ)
    (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ)
    (hf : Measurable f) (h : textbookLangevinWeightedOscillationBound V β f C)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hV : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N))) :
    Integrable f (μ : Measure (textbookLangevinPeriodicPhase N)) := by
  let z : textbookLangevinPeriodicPhase N := (0, 0)
  have hi : Integrable (fun x ↦ C * (2 + β * (V x + V z)) + ‖f z‖)
      (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (((integrable_const (2 : ℝ)).add ((hV.add (integrable_const (V z))).const_mul β)).const_mul C).add
      (integrable_const ‖f z‖)
  apply hi.mono' hf.aestronglyMeasurable
  apply Eventually.of_forall
  intro x
  calc
    ‖f x‖ = ‖(f x - f z) + f z‖ := by rw [sub_add_cancel]
    _ ≤ ‖f x - f z‖ + ‖f z‖ := norm_add_le _ _
    _ ≤ _ := add_le_add (h x z) le_rfl

private theorem probabilityIntegral_affine_weight {N : ℕ}
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (V : textbookLangevinPeriodicPhase N → ℝ)
    (hV : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N))) (C β a : ℝ) :
    (∫ x, C * (2 + β * (V x + a)) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
      C * (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) + a)) := by
  have h₁ := integral_add (integrable_const (2 : ℝ)) ((hV.add (integrable_const a)).const_mul β)
  have h₂ := integral_add hV (integrable_const a)
  calc
    _ = C * ∫ x, 2 + β * (V x + a) ∂(μ : Measure (textbookLangevinPeriodicPhase N)) :=
      integral_const_mul C _
    _ = C * ((∫ _, (2 : ℝ) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, β * (V x + a) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) :=
      congrArg (fun t : ℝ ↦ C * t) h₁
    _ = C * ((∫ _, (2 : ℝ) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ _, a ∂(μ : Measure (textbookLangevinPeriodicPhase N)))) :=
      congrArg (fun t : ℝ ↦ C * ((∫ _, (2 : ℝ) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) + t))
        ((integral_const_mul β _).trans (congrArg (fun t : ℝ ↦ β * t) h₂))
    _ = _ := by simp

/-- Two genuine probability-law expectations obey the true weighted oscillation bound obtained by integrating the original pairwise inequality twice. -/
theorem textbookLangevinWeightedOscillationBound_integral_difference {N : ℕ}
    (V : textbookLangevinPeriodicPhase N → ℝ) (β : ℝ)
    (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ)
    (hf : Measurable f) (h : textbookLangevinWeightedOscillationBound V β f C)
    (μ ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hVμ : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)))
    (hVν : Integrable V (ν : Measure (textbookLangevinPeriodicPhase N))) :
    ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
        ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ ≤
      C * (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N)))) := by
  have hfμ := textbookLangevinWeightedOscillationBound_integrable V β f C hf h μ hVμ
  have hfν := textbookLangevinWeightedOscillationBound_integrable V β f C hf h ν hVν
  have hpoint (y : textbookLangevinPeriodicPhase N) :
      ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) - f y‖ ≤
        C * (2 + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) + V y)) := by
    have hi := hfμ.sub (integrable_const (f y))
    have hb : Integrable (fun x ↦ C * (2 + β * (V x + V y)))
        (μ : Measure (textbookLangevinPeriodicPhase N)) :=
      ((integrable_const (2 : ℝ)).add ((hVμ.add (integrable_const (V y))).const_mul β)).const_mul C
    calc
      _ = ‖∫ x, f x - f y ∂(μ : Measure (textbookLangevinPeriodicPhase N))‖ := by
        rw [integral_sub hfμ (integrable_const (f y))]
        simp
      _ ≤ ∫ x, ‖f x - f y‖ ∂(μ : Measure (textbookLangevinPeriodicPhase N)) :=
        norm_integral_le_integral_norm _
      _ ≤ ∫ x, C * (2 + β * (V x + V y)) ∂(μ : Measure (textbookLangevinPeriodicPhase N)) :=
        integral_mono hi.norm hb (fun x ↦ h x y)
      _ = _ := probabilityIntegral_affine_weight μ V hVμ C β (V y)
  let a := ∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))
  let b := ∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))
  have hi := (integrable_const a).sub hfν
  have hb : Integrable (fun y ↦ C * (2 + β * (V y + b)))
      (ν : Measure (textbookLangevinPeriodicPhase N)) :=
    ((integrable_const (2 : ℝ)).add ((hVν.add (integrable_const b)).const_mul β)).const_mul C
  calc
    _ = ‖∫ y, a - f y ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ := by
      rw [integral_sub (integrable_const a) hfν]
      simp [a]
    _ ≤ ∫ y, ‖a - f y‖ ∂(ν : Measure (textbookLangevinPeriodicPhase N)) :=
      norm_integral_le_integral_norm _
    _ ≤ ∫ y, C * (2 + β * (V y + b)) ∂(ν : Measure (textbookLangevinPeriodicPhase N)) :=
      integral_mono hi.norm hb (fun y ↦ by simpa only [a, b, add_comm] using hpoint y)
    _ = C * (2 + β * ((∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N))) + b)) :=
      probabilityIntegral_affine_weight ν V hVν C β b
    _ = _ := by dsimp only [b]; ring

private theorem residualProbability_of_minorization {N : ℕ}
    (μ ρ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (ε : ℝ) (hε : 0 < ε) (hε1 : ε < 1)
    (hsmall : ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) ≤ μ)
    (V : textbookLangevinPeriodicPhase N → ℝ)
    (hV : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N))) :
    ∃ Q : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
      (μ : Measure (textbookLangevinPeriodicPhase N)) =
        ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) +
          ENNReal.ofReal (1 - ε) • (Q : Measure (textbookLangevinPeriodicPhase N)) ∧
      Integrable V (Q : Measure (textbookLangevinPeriodicPhase N)) := by
  let s := ENNReal.ofReal ε
  let m : Measure (textbookLangevinPeriodicPhase N) := μ - s • (ρ : Measure (textbookLangevinPeriodicPhase N))
  have : IsFiniteMeasure (s • (ρ : Measure (textbookLangevinPeriodicPhase N))) :=
    ⟨lt_of_le_of_lt (hsmall univ) (by simp)⟩
  have hm : m univ = ENNReal.ofReal (1 - ε) := by
    rw [Measure.sub_apply MeasurableSet.univ hsmall, Measure.smul_apply, smul_eq_mul, measure_univ, measure_univ,
      mul_one, ← ENNReal.ofReal_one]
    exact (ENNReal.ofReal_sub 1 hε.le).symm
  have hm0 : m univ ≠ 0 := by rw [hm]; exact (ENNReal.ofReal_pos.mpr (sub_pos.mpr hε1)).ne'
  have hmtop : m univ ≠ (⊤ : ℝ≥0∞) := by rw [hm]; exact ENNReal.ofReal_ne_top
  let Q : ProbabilityMeasure (textbookLangevinPeriodicPhase N) :=
    ⟨(m univ)⁻¹ • m, ⟨by
      rw [Measure.smul_apply, smul_eq_mul]
      exact ENNReal.inv_mul_cancel hm0 hmtop⟩⟩
  have hQ : ENNReal.ofReal (1 - ε) • (Q : Measure (textbookLangevinPeriodicPhase N)) = m := by
    change ENNReal.ofReal (1 - ε) • ((m univ)⁻¹ • m) = m
    rw [← hm, smul_smul, ENNReal.mul_inv_cancel hm0 hmtop, one_smul]
  refine ⟨Q, ?_, ?_⟩
  · rw [hQ, add_comm]
    exact (Measure.sub_add_cancel_of_le hsmall).symm
  · exact (hV.mono_measure Measure.sub_le).smul_measure (ENNReal.inv_ne_top.mpr hm0)

private theorem probabilityIntegral_mixture {N : ℕ}
    (μ ρ Q : ProbabilityMeasure (textbookLangevinPeriodicPhase N)) (ε : ℝ)
    (hε : 0 ≤ ε) (hε1 : ε ≤ 1)
    (hm : (μ : Measure (textbookLangevinPeriodicPhase N)) =
      ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) +
        ENNReal.ofReal (1 - ε) • (Q : Measure (textbookLangevinPeriodicPhase N)))
    (f : textbookLangevinPeriodicPhase N → ℝ)
    (hfρ : Integrable f (ρ : Measure (textbookLangevinPeriodicPhase N)))
    (hfQ : Integrable f (Q : Measure (textbookLangevinPeriodicPhase N))) :
    (∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
      ε * (∫ x, f x ∂(ρ : Measure (textbookLangevinPeriodicPhase N))) +
        (1 - ε) * (∫ x, f x ∂(Q : Measure (textbookLangevinPeriodicPhase N))) := by
  rw [hm, integral_add_measure (hfρ.smul_measure ENNReal.ofReal_ne_top)
    (hfQ.smul_measure ENNReal.ofReal_ne_top)]
  simp only [integral_smul_measure, ENNReal.toReal_ofReal hε, ENNReal.toReal_ofReal (sub_nonneg.mpr hε1), smul_eq_mul]

/-- Shared genuine measure minorization cancels its common probability part; the true residual laws yield the stronger weighted expectation-difference estimate. -/
theorem textbookLangevinWeightedOscillationBound_minorized_integral_difference {N : ℕ}
    (V : textbookLangevinPeriodicPhase N → ℝ) (hV0 : ∀ x, 0 ≤ V x) (β : ℝ) (hβ : 0 ≤ β)
    (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ) (hC : 0 ≤ C)
    (hf : Measurable f) (h : textbookLangevinWeightedOscillationBound V β f C)
    (μ ν ρ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hVμ : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)))
    (hVν : Integrable V (ν : Measure (textbookLangevinPeriodicPhase N)))
    (ε : ℝ) (hε : 0 < ε) (hε1 : ε < 1)
    (hμ : ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) ≤ μ)
    (hν : ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) ≤ ν) :
    ‖(∫ x, f x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
        ∫ x, f x ∂(ν : Measure (textbookLangevinPeriodicPhase N))‖ ≤
      C * (2 * (1 - ε) + β * ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N)))) := by
  obtain ⟨Q, hm, hVQ⟩ := residualProbability_of_minorization μ ρ ε hε hε1 hμ V hVμ
  obtain ⟨S, hn, hVS⟩ := residualProbability_of_minorization ν ρ ε hε hε1 hν V hVν
  have hVρ : Integrable V (ρ : Measure (textbookLangevinPeriodicPhase N)) :=
    (integrable_smul_measure (ENNReal.ofReal_pos.mpr hε).ne' ENNReal.ofReal_ne_top).mp
      (hVμ.mono_measure hμ)
  have hfρ := textbookLangevinWeightedOscillationBound_integrable V β f C hf h ρ hVρ
  have hfQ := textbookLangevinWeightedOscillationBound_integrable V β f C hf h Q hVQ
  have hfS := textbookLangevinWeightedOscillationBound_integrable V β f C hf h S hVS
  have hfm := probabilityIntegral_mixture μ ρ Q ε hε.le hε1.le hm f hfρ hfQ
  have hfn := probabilityIntegral_mixture ν ρ S ε hε.le hε1.le hn f hfρ hfS
  have hVm := probabilityIntegral_mixture μ ρ Q ε hε.le hε1.le hm V hVρ hVQ
  have hVn := probabilityIntegral_mixture ν ρ S ε hε.le hε1.le hn V hVρ hVS
  have hρpos : 0 ≤ ∫ x, V x ∂(ρ : Measure (textbookLangevinPeriodicPhase N)) := integral_nonneg hV0
  have hsum : (1 - ε) * ((∫ x, V x ∂(Q : Measure (textbookLangevinPeriodicPhase N))) +
      ∫ x, V x ∂(S : Measure (textbookLangevinPeriodicPhase N))) ≤
      (∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N)) := by
    nlinarith
  have hQQ := textbookLangevinWeightedOscillationBound_integral_difference V β f C hf h Q S hVQ hVS
  calc
    _ = ‖(1 - ε) * ((∫ x, f x ∂(Q : Measure (textbookLangevinPeriodicPhase N))) -
        ∫ x, f x ∂(S : Measure (textbookLangevinPeriodicPhase N)))‖ := by
      rw [hfm, hfn]
      congr 1
      ring
    _ = (1 - ε) * ‖(∫ x, f x ∂(Q : Measure (textbookLangevinPeriodicPhase N))) -
        ∫ x, f x ∂(S : Measure (textbookLangevinPeriodicPhase N))‖ := by
      rw [norm_mul, Real.norm_of_nonneg (sub_nonneg.mpr hε1.le)]
    _ ≤ (1 - ε) * (C * (2 + β * ((∫ x, V x ∂(Q : Measure (textbookLangevinPeriodicPhase N))) +
        ∫ x, V x ∂(S : Measure (textbookLangevinPeriodicPhase N))))) :=
      mul_le_mul_of_nonneg_left hQQ (sub_nonneg.mpr hε1.le)
    _ = 2 * C * (1 - ε) + (C * β) * ((1 - ε) *
        ((∫ x, V x ∂(Q : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ x, V x ∂(S : Measure (textbookLangevinPeriodicPhase N)))) := by ring
    _ ≤ 2 * C * (1 - ε) + (C * β) *
        ((∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
          ∫ x, V x ∂(ν : Measure (textbookLangevinPeriodicPhase N))) :=
      add_le_add le_rfl (mul_le_mul_of_nonneg_left hsum (mul_nonneg hC hβ))
    _ = _ := by ring

private theorem harrisHalfDrift_constants (D R ε : ℝ) (hD : 0 < D) (hR : 4 * D < R)
    (hε : 0 < ε) (hε1 : ε < 1) :
    ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
      (∀ S : ℝ, R ≤ S → 2 + β * (S / 2 + 2 * D) ≤ a * (2 + β * S)) ∧
      (∀ S : ℝ, 0 ≤ S → 2 * (1 - ε) + β * (S / 2 + 2 * D) ≤ a * (2 + β * S)) := by
  let β := ε / (4 * D)
  have hβ : 0 < β := by dsimp only [β]; positivity
  have hβD : β * D = ε / 4 := by dsimp only [β]; field_simp [hD.ne']
  have hR0 : 0 < R := by linarith
  have hden : 0 < 2 + β * R := by positivity
  let aL := (2 + β * (R / 2 + 2 * D)) / (2 + β * R)
  let aS := 1 - ε / 2
  let a := max aL aS
  have haLhalf : (1 / 2 : ℝ) ≤ aL := by
    dsimp only [aL]
    apply (le_div_iff₀ hden).mpr
    nlinarith [mul_pos hβ hD]
  have haL1 : aL < 1 := by
    dsimp only [aL]
    apply (div_lt_one hden).mpr
    nlinarith [mul_pos hβ (show 0 < R / 2 - 2 * D by linarith)]
  have haS0 : 0 < aS := by dsimp only [aS]; linarith
  have haS1 : aS < 1 := by dsimp only [aS]; linarith
  have haShalf : (1 / 2 : ℝ) ≤ aS := by dsimp only [aS]; linarith
  have hrel : aL * (2 + β * R) = 2 + β * (R / 2 + 2 * D) := by
    dsimp only [aL]
    exact div_mul_cancel₀ _ hden.ne'
  refine ⟨β, hβ, a, haS0.trans_le (le_max_right _ _), max_lt haL1 haS1, ?_, ?_⟩
  · intro S hRS
    have hS0 : 0 ≤ S := hR0.le.trans hRS
    have hm := mul_le_mul_of_nonneg_right haLhalf (mul_nonneg hβ.le (sub_nonneg.mpr hRS))
    have hl : 2 + β * (S / 2 + 2 * D) ≤ aL * (2 + β * S) := by nlinarith
    exact hl.trans (mul_le_mul_of_nonneg_right (le_max_left _ _) (by positivity))
  · intro S hS0
    have hm := mul_le_mul_of_nonneg_right haShalf (mul_nonneg hβ.le hS0)
    have hl : 2 * (1 - ε) + β * (S / 2 + 2 * D) ≤ aS * (2 + β * S) := by
      dsimp only [aS] at hm ⊢
      nlinarith
    exact hl.trans (mul_le_mul_of_nonneg_right (le_max_right _ _) (by positivity))

private theorem phaseKernel_halfDrift_weighted_contraction {N : ℕ}
    (K : Kernel (textbookLangevinPeriodicPhase N) (textbookLangevinPeriodicPhase N)) [IsMarkovKernel K]
    (V : textbookLangevinPeriodicPhase N → ℝ) (hV0 : ∀ x, 0 ≤ V x)
    (hVI : ∀ x, Integrable V (K x)) (D R : ℝ) (hD : 0 < D) (hR : 4 * D < R)
    (hd : ∀ x, (∫ y, V y ∂K x) ≤ (1 / 2 : ℝ) * V x + D)
    (ε : ℝ) (hε : 0 < ε) (hε1 : ε < 1)
    (ρ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hsmall : ∀ x, V x ≤ R → ENNReal.ofReal ε • (ρ : Measure (textbookLangevinPeriodicPhase N)) ≤ K x) :
    ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
      ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
        textbookLangevinWeightedOscillationBound V β f C →
        (∀ x, Integrable f (K x)) ∧
          Measurable (fun x ↦ ∫ y, f y ∂K x) ∧
          textbookLangevinWeightedOscillationBound V β (fun x ↦ ∫ y, f y ∂K x) (a * C) := by
  obtain ⟨β, hβ, a, ha, ha1, hbig, hlittle⟩ := harrisHalfDrift_constants D R ε hD hR hε hε1
  let μ : textbookLangevinPeriodicPhase N → ProbabilityMeasure (textbookLangevinPeriodicPhase N) :=
    fun x ↦ ⟨K x, inferInstance⟩
  refine ⟨β, hβ, a, ha, ha1, fun f C hf hC hosc ↦ ?_⟩
  refine ⟨fun x ↦ textbookLangevinWeightedOscillationBound_integrable V β f C hf hosc (μ x) (hVI x),
    hf.stronglyMeasurable.integral_kernel.measurable, ?_⟩
  intro x y
  have hS0 : 0 ≤ V x + V y := add_nonneg (hV0 x) (hV0 y)
  have hm : (∫ z, V z ∂K x) + (∫ z, V z ∂K y) ≤ (V x + V y) / 2 + 2 * D := by
    linarith [hd x, hd y]
  by_cases hlarge : R ≤ V x + V y
  · have hp := textbookLangevinWeightedOscillationBound_integral_difference V β f C hf hosc
      (μ x) (μ y) (hVI x) (hVI y)
    calc
      _ ≤ C * (2 + β * ((∫ z, V z ∂K x) + ∫ z, V z ∂K y)) := hp
      _ ≤ C * (2 + β * ((V x + V y) / 2 + 2 * D)) :=
        mul_le_mul_of_nonneg_left (add_le_add le_rfl (mul_le_mul_of_nonneg_left hm hβ.le)) hC
      _ ≤ C * (a * (2 + β * (V x + V y))) :=
        mul_le_mul_of_nonneg_left (hbig _ hlarge) hC
      _ = _ := by ring
  · have hx : V x ≤ R := by have hy0 := hV0 y; linarith
    have hy : V y ≤ R := by have hx0 := hV0 x; linarith
    have hp := textbookLangevinWeightedOscillationBound_minorized_integral_difference V hV0 β hβ.le
      f C hC hf hosc (μ x) (μ y) ρ (hVI x) (hVI y) ε hε hε1 (hsmall x hx) (hsmall y hy)
    calc
      _ ≤ C * (2 * (1 - ε) + β * ((∫ z, V z ∂K x) + ∫ z, V z ∂K y)) := hp
      _ ≤ C * (2 * (1 - ε) + β * ((V x + V y) / 2 + 2 * D)) :=
        mul_le_mul_of_nonneg_left (add_le_add le_rfl (mul_le_mul_of_nonneg_left hm hβ.le)) hC
      _ ≤ C * (a * (2 + β * (V x + V y))) :=
        mul_le_mul_of_nonneg_left (hlittle _ hS0) hC
      _ = _ := by ring

/-- The same actual original Langevin skeleton has a genuine strict Hamiltonian-weighted oscillation contraction, conditional only on the original density clause on its actually derived large energy set. Drift, moments, residual laws and the contraction constants are derived. -/
theorem textbookLangevinPeriodicDensityClause_hamiltonian_weighted_one_step_contraction
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (hLower : ∀ q, 1 ≤ U q)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ σ : ℝ) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        ∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ β : ℝ, 0 < β ∧ ∃ a : ℝ, 0 < a ∧ a < 1 ∧
            ∀ (f : textbookLangevinPeriodicPhase N → ℝ) (C : ℝ), Measurable f → 0 ≤ C →
              textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β f C →
              (∀ x, Integrable f (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x)) ∧
                Measurable (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ∧
                textbookLangevinWeightedOscillationBound (textbookLangevinPeriodicHamiltonianPower U l) β
                  (fun x ↦ ∫ y, f y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) (a * C) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_inputs
    B P hB U hU hp L hF γ σ hLower hγ hσ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR4, _, _, _, hVI, hd, _, hm⟩ := h l hl
  refine ⟨D, R, hD, hR4, fun ρ hρ ↦ ?_⟩
  obtain ⟨η, ν, hη, hη1, hηtop, hsmall⟩ := hm ρ hρ
  let ε := η.toReal / 2
  have hηreal : 0 < η.toReal := ENNReal.toReal_pos hη.ne' hηtop
  have hηreal1 : η.toReal ≤ 1 := by simpa using ENNReal.toReal_mono (by simp) hη1
  have hε : 0 < ε := by dsimp only [ε]; positivity
  have hε1 : ε < 1 := by dsimp only [ε]; linarith
  have hscalar : ENNReal.ofReal ε ≤ η := by
    rw [← ENNReal.ofReal_toReal hηtop]
    apply ENNReal.ofReal_le_ofReal
    dsimp only [ε]
    linarith
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ
  have : IsMarkovKernel K := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ τ
  have hm' (x : textbookLangevinPeriodicPhase N) (hx : textbookLangevinPeriodicHamiltonianPower U l x ≤ R) :
      ENNReal.ofReal ε • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤ K x := by
    apply Measure.le_iff.mpr
    intro A hA
    have hh := Measure.le_iff.mp (hsmall x hx) A hA
    rw [Measure.smul_apply, smul_eq_mul] at hh ⊢
    exact (mul_le_mul' hscalar le_rfl).trans hh
  exact phaseKernel_halfDrift_weighted_contraction K
    (textbookLangevinPeriodicHamiltonianPower U l)
    (fun x ↦ (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le)
    hVI D R hD hR4 hd ε hε hε1 ν hm'

end
end MolecularDynamics
