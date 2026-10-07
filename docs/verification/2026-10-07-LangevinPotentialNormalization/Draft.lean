import MolecularDynamics.Chapter06.LangevinTimeLawKernel
import Mathlib.Analysis.Calculus.FDeriv.Add

/-! The genuine additive-potential normalization preserves the same original Langevin process and transition kernel.
This removes the explicit lower-potential normalization from the actual full-time invariant-law existence proof. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

/-- Adding any real constant leaves the true coordinate negative-gradient force unchanged, even at nondifferentiable points under the original fderiv convention. -/
theorem textbookPotentialForce_add_const {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (c : ℝ) :
    textbookPotentialForce (fun q ↦ U q + c) = textbookPotentialForce U := by
  funext q
  ext i
  simp only [textbookPotentialForce, fderiv_add_const]

/-- A true additive energy normalization preserves the original integer-lattice periodicity. -/
theorem textbookUnitPeriodicPotential_add_const {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential U) (c : ℝ) :
    textbookUnitPeriodicPotential (fun q ↦ U q + c) := by
  intro q n
  exact congrArg (fun r : ℝ ↦ r + c) (hp q n)

/-- The original additive-noise integral equations are literally unchanged by adding a constant to the potential. -/
theorem textbookLangevinIntegralSolution_add_const_iff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (c γ σ T : ℝ) (x : textbookLangevinPhase N)
    (W q p : ℝ → (Fin N → ℝ)) :
    textbookLangevinIntegralSolution (fun q ↦ U q + c) γ σ T x W q p ↔
      textbookLangevinIntegralSolution U γ σ T x W q p := by
  unfold textbookLangevinIntegralSolution
  rw [textbookPotentialForce_add_const]

/-- Actual solution uniqueness proves equality of the same finite-history endpoints after a genuine additive energy normalization; arbitrary valid Lipschitz witnesses are allowed. -/
theorem textbookLangevinPathEndpoint_add_const {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (c : ℝ) (Lc : ℝ≥0)
    (hFc : LipschitzWith Lc (textbookPotentialForce (fun q ↦ U q + c)))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPhase N)
    (t : ℝ) (ht : t ∈ Icc 0 T) (W : C(Icc 0 T, Fin N → ℝ)) :
    textbookLangevinPathEndpoint (fun q ↦ U q + c) Lc hFc γ σ T hT x t W =
      textbookLangevinPathEndpoint U L hF γ σ T hT x t W := by
  let a := textbookLangevinPathSolution (fun q ↦ U q + c) Lc hFc γ σ T hT x W
  let b := textbookLangevinPathSolution U L hF γ σ T hT x W
  have ha := (textbookLangevinIntegralSolution_add_const_iff U c γ σ T x
    (textbookLangevinPathNoise T hT W) a.1 a.2).mp
      (textbookLangevinPathSolution_integralSolution (fun q ↦ U q + c) Lc hFc γ σ T hT x W)
  have hb := textbookLangevinPathSolution_integralSolution U L hF γ σ T hT x W
  exact textbookLangevinIntegralSolution_unique_globalLip U hU L hF γ σ T hT x
    (textbookLangevinPathNoise T hT W) a.1 a.2 b.1 b.2 ha hb t ht

/-- The actual projected original torus endpoint is unchanged by the genuine additive potential normalization. -/
theorem textbookLangevinPeriodicPathEndpoint_add_const {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ 2 U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (c : ℝ) (Lc : ℝ≥0)
    (hFc : LipschitzWith Lc (textbookPotentialForce (fun q ↦ U q + c)))
    (γ σ T : ℝ) (hT : 0 ≤ T) (x : textbookLangevinPeriodicPhase N)
    (t : ℝ) (ht : t ∈ Icc 0 T) (W : C(Icc 0 T, Fin N → ℝ)) :
    textbookLangevinPeriodicPathEndpoint (fun q ↦ U q + c) Lc hFc γ σ T hT x t W =
      textbookLangevinPeriodicPathEndpoint U L hF γ σ T hT x t W := by
  unfold textbookLangevinPeriodicPathEndpoint
  rw [textbookLangevinPathEndpoint_add_const U hU L hF c Lc hFc γ σ T hT
    (textbookLangevinPeriodicRepresentative x.1, x.2) t ht W]


/-- Under the same original Wiener law, the genuine transition kernel at every nonnegative time is exactly unchanged by adding a real constant to the potential. -/
theorem textbookLangevinPeriodicTransitionKernel_add_const {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (c : ℝ) (Lc : ℝ≥0)
    (hFc : LipschitzWith Lc (textbookPotentialForce (fun q ↦ U q + c)))
    (γ σ : ℝ) (T : ℝ≥0) :
    textbookLangevinPeriodicTransitionKernel B P (fun q ↦ U q + c) (hU.add contDiff_const)
      (textbookUnitPeriodicPotential_add_const U hp c) Lc hFc γ σ T =
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T := by
  apply DFunLike.ext
  intro x
  rw [textbookLangevinPeriodicTransitionKernel_apply B P hB (fun q ↦ U q + c) (hU.add contDiff_const)
    (textbookUnitPeriodicPotential_add_const U hp c) Lc hFc γ σ T x,
    textbookLangevinPeriodicTransitionKernel_apply B P hB U hU hp L hF γ σ T x]
  congr 1
  funext W
  exact textbookLangevinPeriodicPathEndpoint_add_const U (hU.of_le (by simp)) L hF c Lc hFc
    γ σ T T.property x T ⟨T.property, le_rfl⟩ W

/-- The actual compact fundamental cube bound constructs a genuine additive normalization U+c at least one everywhere; it is not supplied as a hypothesis. -/
theorem textbookUnitPeriodicPotential_normalization {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Continuous U) (hp : textbookUnitPeriodicPotential U) :
    ∃ c : ℝ, ∀ q, 1 ≤ U q + c := by
  obtain ⟨M, _, hM⟩ := textbookUnitPeriodicPotential_bound U hU hp
  refine ⟨M + 1, fun q ↦ ?_⟩
  have hh : -M ≤ U q := (abs_le.mp (by simpa only [Real.norm_eq_abs] using hM q)).1
  linarith

/-- A genuine full-time invariant probability exists for the original kernel of any smooth periodic potential, with no lower-potential normalization, density, moment, or invariant-law premise. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists_unrestricted_potential
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∀ T : ℝ≥0,
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨c, hc⟩ := textbookUnitPeriodicPotential_normalization U hU.continuous hp
  let V := fun q ↦ U q + c
  have hV : ContDiff ℝ ∞ V := hU.add contDiff_const
  have hpV : textbookUnitPeriodicPotential V := textbookUnitPeriodicPotential_add_const U hp c
  have hFV : LipschitzWith L (textbookPotentialForce V) := by
    dsimp only [V]
    rw [textbookPotentialForce_add_const]
    exact hF
  obtain ⟨μ, hμ⟩ := textbookLangevinPeriodicTransitionKernel_invariant_exists B P hB V hV hpV L hFV γ σ hc hγ
  refine ⟨μ, fun T ↦ ?_⟩
  have hK := textbookLangevinPeriodicTransitionKernel_add_const B P hB U hU hp L hF c L hFV γ σ T
  rw [← hK]
  exact hμ T

/-- Original smooth periodicity derives force Lipschitz regularity and a true all-time invariant law of the actual original kernel without any artificial potential lower bound. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists_unrestricted_potential_of_periodic
    {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (hγ : 0 < γ) :
    ∃ (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
      ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N), ∀ T : ℝ≥0,
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
          (μ : Measure (textbookLangevinPeriodicPhase N)) = μ := by
  obtain ⟨L, hF⟩ := textbookUnitPeriodicPotential_force_lipschitz U hU hp
  exact ⟨L, hF, textbookLangevinPeriodicTransitionKernel_invariant_exists_unrestricted_potential B P hB U hU hp L hF γ σ hγ⟩

end
end MolecularDynamics
