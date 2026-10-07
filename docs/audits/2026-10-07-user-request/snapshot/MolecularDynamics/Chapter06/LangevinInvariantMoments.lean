import MolecularDynamics.Chapter06.LangevinPotentialNormalization
import Mathlib.MeasureTheory.Integral.Lebesgue.Add
import Mathlib.Topology.Order.LiminfLimsup

/-! Genuine Hamiltonian-power moments of the same original Langevin invariant probability laws.
Target-law integrability is derived from actual drift, bounded truncation stationarity and Fatou, not assumed. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

private def langevinMomentTruncation {N : ℕ}
    (V : textbookLangevinPeriodicPhase N → ℝ) (hV : Continuous V) (hV0 : ∀ x, 0 ≤ V x) (n : ℕ) :
    BoundedContinuousFunction (textbookLangevinPeriodicPhase N) ℝ :=
  BoundedContinuousFunction.ofNormedAddCommGroup (fun x ↦ min (V x) (n : ℝ))
    (hV.min continuous_const) (n : ℝ) (fun x ↦ by
      rw [Real.norm_of_nonneg (le_min (hV0 x) (Nat.cast_nonneg n))]
      exact min_le_right _ _)

private theorem langevinMomentTruncation_apply {N : ℕ}
    (V : textbookLangevinPeriodicPhase N → ℝ) (hV : Continuous V) (hV0 : ∀ x, 0 ≤ V x) (n : ℕ)
    (x : textbookLangevinPeriodicPhase N) :
    langevinMomentTruncation V hV hV0 n x = min (V x) (n : ℝ) := rfl

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
private theorem actualInvariant_integrable_of_half_drift
    (τ : ℝ≥0) (V : textbookLangevinPeriodicPhase N → ℝ) (hV : Continuous V)
    (hV0 : ∀ x, 0 ≤ V x)
    (hVK : ∀ x, Integrable V (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x))
    (D : ℝ) (hD : 0 < D)
    (hd : ∀ x, (∫ y, V y ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
      (1 / 2 : ℝ) * V x + D)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
      (∫ x, V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤ 2 * D := by
  let K := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ
  have : IsMarkovKernel K := textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ τ
  let W : textbookLangevinPeriodicPhase N → ℝ := fun x ↦ (1 / 2 : ℝ) * V x + D
  have hW : Continuous W := (hV.const_mul (1 / 2 : ℝ)).add continuous_const
  have hW0 (x : textbookLangevinPeriodicPhase N) : 0 ≤ W x := by
    exact add_nonneg (mul_nonneg (by norm_num) (hV0 x)) hD.le
  let f := fun n : ℕ ↦ langevinMomentTruncation V hV hV0 n
  let w := fun n : ℕ ↦ langevinMomentTruncation W hW hW0 n
  have hf (n : ℕ) : Integrable (f n) (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (integrable_const ‖f n‖).mono' (f n).continuous.aestronglyMeasurable (Eventually.of_forall (f n).norm_coe_le_norm)
  have hw (n : ℕ) : Integrable (w n) (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    (integrable_const ‖w n‖).mono' (w n).continuous.aestronglyMeasurable (Eventually.of_forall (w n).norm_coe_le_norm)
  have hfK (n : ℕ) (x : textbookLangevinPeriodicPhase N) : Integrable (f n) (K x) :=
    (integrable_const ‖f n‖).mono' (f n).continuous.aestronglyMeasurable (Eventually.of_forall (f n).norm_coe_le_norm)
  have hstep (n : ℕ) (x : textbookLangevinPeriodicPhase N) :
      textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ (f n) x ≤ w n x := by
    change (∫ y, f n y ∂K x) ≤ min (W x) (n : ℝ)
    apply le_min
    · exact (integral_mono (hfK n x) (hVK x) (fun y ↦ min_le_left (V y) (n : ℝ))).trans (hd x)
    · calc
        (∫ y, f n y ∂K x) ≤ ∫ _, (n : ℝ) ∂K x :=
          integral_mono (hfK n x) (integrable_const _) (fun y ↦ min_le_right (V y) (n : ℝ))
        _ = (n : ℝ) := by simp
  have hmean (n : ℕ) : (∫ x, f n x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤
      ∫ x, w n x ∂(μ : Measure (textbookLangevinPeriodicPhase N)) := by
    have he := textbookLangevinPeriodicProbabilityEvolution_integral B P hB U hU hp L hF γ σ τ μ (f n)
    change (∫ x, f n x ∂(K ∘ₘ (μ : Measure (textbookLangevinPeriodicPhase N)))) = _ at he
    rw [hInv] at he
    rw [he]
    apply integral_mono
      ((integrable_const ‖textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ (f n)‖).mono'
        (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ (f n)).continuous.aestronglyMeasurable
        (Eventually.of_forall (textbookLangevinPeriodicBoundedTransition B P hB U hU hp L hF γ σ τ (f n)).norm_coe_le_norm))
      (hw n) (hstep n)
  let G := fun (n : ℕ) (x : textbookLangevinPeriodicPhase N) ↦ f n x - w n x + D
  have hG0 (n : ℕ) (x : textbookLangevinPeriodicPhase N) : 0 ≤ G n x := by
    have hle : min (W x) (n : ℝ) ≤ min (V x) (n : ℝ) + D := by
      by_cases hx : V x ≤ (n : ℝ)
      · rw [min_eq_left hx]
        have hwle := min_le_left (W x) (n : ℝ)
        dsimp only [W] at hwle
        have hv := hV0 x
        linarith
      · rw [min_eq_right (le_of_not_ge hx)]
        have hwle := min_le_right (W x) (n : ℝ)
        linarith
    change 0 ≤ min (V x) (n : ℝ) - min (W x) (n : ℝ) + D
    linarith
  have hGc (n : ℕ) : Continuous (G n) := ((f n).continuous.sub (w n).continuous).add continuous_const
  have hGi (n : ℕ) : Integrable (G n) (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    ((hf n).sub (hw n)).add (integrable_const D)
  have hGmean (n : ℕ) : (∫ x, G n x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤ D := by
    have he : (∫ x, G n x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) =
        (∫ x, f n x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) -
        (∫ x, w n x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) + D := by
      calc
        _ = (∫ x, f n x - w n x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) +
            ∫ _, D ∂(μ : Measure (textbookLangevinPeriodicPhase N)) :=
          integral_add ((hf n).sub (hw n)) (integrable_const D)
        _ = _ := congrArg₂ (fun a b : ℝ ↦ a + b) (integral_sub (hf n) (hw n)) (by simp)
    rw [he]
    linarith [hmean n]

  have hGlim (x : textbookLangevinPeriodicPhase N) :
      Tendsto (fun n : ℕ ↦ G n x) atTop (𝓝 ((1 / 2 : ℝ) * V x)) := by
    have he : (fun n : ℕ ↦ G n x) =ᶠ[atTop] (fun _ ↦ (1 / 2 : ℝ) * V x) := by
      filter_upwards
        [(tendsto_natCast_atTop_atTop (R := ℝ)).eventually (eventually_ge_atTop (V x)),
          (tendsto_natCast_atTop_atTop (R := ℝ)).eventually (eventually_ge_atTop (W x))]
        with n hnV hnW
      change min (V x) (n : ℝ) - min (W x) (n : ℝ) + D = (1 / 2 : ℝ) * V x
      rw [min_eq_left hnV, min_eq_left hnW]
      dsimp only [W]
      ring
    exact tendsto_const_nhds.congr' he.symm
  have hGln (n : ℕ) :
      (∫⁻ x, ENNReal.ofReal (G n x) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤ ENNReal.ofReal D := by
    rw [← ofReal_integral_eq_lintegral_ofReal (hGi n) (Eventually.of_forall (hG0 n))]
    exact ENNReal.ofReal_le_ofReal (hGmean n)
  have hlim (x : textbookLangevinPeriodicPhase N) :
      atTop.liminf (fun n : ℕ ↦ ENNReal.ofReal (G n x)) = ENNReal.ofReal ((1 / 2 : ℝ) * V x) :=
    (ENNReal.continuous_ofReal.tendsto _ |>.comp (hGlim x)).liminf_eq
  have hFatou :
      (∫⁻ x, ENNReal.ofReal ((1 / 2 : ℝ) * V x) ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤
        ENNReal.ofReal D := by
    calc
      _ = ∫⁻ x, atTop.liminf (fun n : ℕ ↦ ENNReal.ofReal (G n x))
          ∂(μ : Measure (textbookLangevinPeriodicPhase N)) :=
        lintegral_congr (fun x ↦ (hlim x).symm)
      _ ≤ atTop.liminf (fun n : ℕ ↦ ∫⁻ x, ENNReal.ofReal (G n x)
          ∂(μ : Measure (textbookLangevinPeriodicPhase N))) :=
        lintegral_liminf_le (fun n ↦ (ENNReal.continuous_ofReal.comp (hGc n)).measurable)
      _ ≤ ENNReal.ofReal D :=
        liminf_le_of_frequently_le' (Frequently.of_forall hGln)
  have hHalf0 : ∀ x, 0 ≤ (1 / 2 : ℝ) * V x := fun x ↦ mul_nonneg (by norm_num) (hV0 x)
  have hiHalf : Integrable (fun x ↦ (1 / 2 : ℝ) * V x) (μ : Measure (textbookLangevinPeriodicPhase N)) :=
    ⟨(hV.const_mul (1 / 2 : ℝ)).aestronglyMeasurable,
      (hasFiniteIntegral_iff_ofReal (Eventually.of_forall hHalf0)).mpr
        (lt_of_le_of_lt hFatou ENNReal.ofReal_lt_top)⟩
  have hiV : Integrable V (μ : Measure (textbookLangevinPeriodicPhase N)) := by
    have hi := hiHalf.const_mul (2 : ℝ)
    have he : (fun x : textbookLangevinPeriodicPhase N ↦ 2 * ((1 / 2 : ℝ) * V x)) = V :=
      funext (fun x ↦ by ring)
    rwa [he] at hi
  have hreal : (∫ x, (1 / 2 : ℝ) * V x ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤ D := by
    apply (ENNReal.ofReal_le_ofReal_iff hD.le).mp
    rw [ofReal_integral_eq_lintegral_ofReal hiHalf (Eventually.of_forall hHalf0)]
    exact hFatou
  rw [integral_const_mul (1 / 2 : ℝ)] at hreal
  exact ⟨hiV, by linarith⟩

include hB in
/-- The original Hamiltonian power of a genuine actual skeleton invariant law is integrable and has the true 2D bound, derived from actual half drift without assuming target-law moments. -/
theorem textbookLangevinPeriodicInvariant_hamiltonian_power_moment_of_half_drift
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (τ : ℝ≥0) (l : ℕ) (hl : 1 ≤ l)
    (D : ℝ) (hD : 0 < D)
    (hd : ∀ x, (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
      ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
        (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    Integrable (textbookLangevinPeriodicHamiltonianPower U l)
      (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
      (∫ x, textbookLangevinPeriodicHamiltonianPower U l x
        ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤ 2 * D := by
  exact actualInvariant_integrable_of_half_drift B P hB U hU hp L hF γ σ τ
    (textbookLangevinPeriodicHamiltonianPower U l)
    (textbookLangevinPeriodicHamiltonianPower_continuous U hU hp l)
    (fun x ↦ (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le)
    (fun x ↦ textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable
      B P hB U hU hp hLower L hF γ σ hγ τ x l hl) D hD hd μ hInv

include hB in
/-- Every genuine full-time invariant law of the same original kernel has all required original Hamiltonian-power moments; the actual common skeleton drift supplies finite constants. -/
theorem textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ)
    (μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N))
    (hInv : ∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
      (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) :
    ∀ l : ℕ, 1 ≤ l →
      Integrable (textbookLangevinPeriodicHamiltonianPower U l) (μ : Measure (textbookLangevinPeriodicPhase N)) ∧
      ∃ C : ℝ, 0 < C ∧ (∫ x, textbookLangevinPeriodicHamiltonianPower U l x
        ∂(μ : Measure (textbookLangevinPeriodicPhase N))) ≤ C := by
  obtain ⟨τ, _, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_common_skeleton_drift
    B P hB U hU hp hLower L hF γ σ hγ
  intro l hl
  obtain ⟨D, hD, hd⟩ := h l hl
  have hm := textbookLangevinPeriodicInvariant_hamiltonian_power_moment_of_half_drift B P hB U hU hp L hF γ σ
    hLower hγ τ l hl D hD hd μ (hInv τ)
  exact ⟨hm.1, 2 * D, by positivity, hm.2⟩

include hB in
/-- The actual original kernel has a genuine full-time invariant probability with all original Hamiltonian-power moments, using the actual existence proof and derived moment integrability. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists_with_hamiltonian_power_moments
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
      (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
        (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
      ∀ l : ℕ, 1 ≤ l →
        Integrable (textbookLangevinPeriodicHamiltonianPower U l)
          (μ : Measure (textbookLangevinPeriodicPhase N)) := by
  obtain ⟨μ, hμ⟩ := textbookLangevinPeriodicTransitionKernel_invariant_exists B P hB U hU hp L hF γ σ hLower hγ
  exact ⟨μ, hμ, fun l hl ↦
    (textbookLangevinPeriodicInvariant_all_hamiltonian_power_moments B P hB U hU hp L hF γ σ hLower hγ μ hμ l hl).1⟩

include hB in
/-- For any original smooth periodic potential, an actual additive energy normalization and a genuine invariant law of the original kernel have every required normalized Hamiltonian-power moment, without moment or stationary premises. -/
theorem textbookLangevinPeriodicTransitionKernel_invariant_exists_with_normalized_energy_moments
    (hγ : 0 < γ) :
    ∃ c : ℝ, (∀ q, 1 ≤ U q + c) ∧
      ∃ μ : ProbabilityMeasure (textbookLangevinPeriodicPhase N),
        (∀ T : ℝ≥0, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T ∘ₘ
          (μ : Measure (textbookLangevinPeriodicPhase N)) = μ) ∧
        ∀ l : ℕ, 1 ≤ l →
          Integrable (textbookLangevinPeriodicHamiltonianPower (fun q ↦ U q + c) l)
            (μ : Measure (textbookLangevinPeriodicPhase N)) := by
  obtain ⟨c, hc⟩ := textbookUnitPeriodicPotential_normalization U hU.continuous hp
  let V := fun q ↦ U q + c
  have hV : ContDiff ℝ ∞ V := hU.add contDiff_const
  have hpV : textbookUnitPeriodicPotential V := textbookUnitPeriodicPotential_add_const U hp c
  have hFV : LipschitzWith L (textbookPotentialForce V) := by
    dsimp only [V]
    rw [textbookPotentialForce_add_const]
    exact hF
  obtain ⟨μ, hμ, hmoment⟩ :=
    textbookLangevinPeriodicTransitionKernel_invariant_exists_with_hamiltonian_power_moments B P hB V hV hpV L hFV γ σ hc hγ
  refine ⟨c, hc, μ, ?_, hmoment⟩
  intro T
  rw [← textbookLangevinPeriodicTransitionKernel_add_const B P hB U hU hp L hF c L hFV γ σ T]
  exact hμ T

end
end MolecularDynamics
