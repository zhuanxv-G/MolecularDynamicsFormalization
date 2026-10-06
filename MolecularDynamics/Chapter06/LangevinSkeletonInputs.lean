import MolecularDynamics.Chapter06.LangevinDensityMinorization
import MolecularDynamics.Chapter06.LangevinHamiltonianPowerDrift

/-! Necessary same-time drift and conditional small-set inputs for original Theorem 6.2. The actual density existence and Harris conclusion remain separate. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

local instance langevinSkeletonInputHaarMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance langevinSkeletonInputHaarIsAddHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance langevinSkeletonInputHaarProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

include hB in
/-- At every prescribed positive total time, the original density clause implies a true compact small set for the same actual kernel; the two half times sum to that exact time. -/
theorem textbookLangevinPeriodicDensityClause_compact_minorization_at_time
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ C ρ)
    (hC : IsCompact C) (hCi : (interior C).Nonempty) (hσ : σ ≠ 0)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) :
    ∃ (η : ℝ≥0∞) (ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N)),
      0 < η ∧ η ≤ 1 ∧ η ≠ (⊤ : ℝ≥0∞) ∧ ∀ x ∈ C,
        η • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤
          textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x := by
  let u : ℝ≥0 := T / 2
  have hu : (0 : ℝ) < u := by
    change (0 : ℝ) < (T : ℝ) / 2
    exact div_pos hT (by norm_num)
  have hsplit : u + u = T := by
    apply NNReal.eq
    change (T : ℝ) / 2 + (T : ℝ) / 2 = (T : ℝ)
    ring
  obtain ⟨y, hy⟩ := hCi
  obtain ⟨z, hz, hpos⟩ := textbookLangevinPeriodicDensityClause_positive_interior_point B P hB U hU hp L hF γ σ
    C ρ hρ hσ u hu y hy
  obtain ⟨a, r, ha, hr, hballY, hballZ, hbound⟩ :=
    textbookLangevinPeriodicDensityClause_local_lower_bound B P U hU hp L hF γ σ C ρ hρ u y z hy hz hpos
  obtain ⟨ε, hε, hb⟩ := textbookLangevinPeriodicDensityClause_two_step_lower_bound B P hB U hU hp L hF γ σ
    C ρ hρ hC hσ u u hu hu y z a r hr hballY hballZ hbound
  let V := Metric.ball z r
  let μ : Measure (textbookLangevinPeriodicPhase N) := volume.restrict V
  have hVpos : 0 < (volume : Measure (textbookLangevinPeriodicPhase N)) V :=
    Metric.isOpen_ball.measure_pos volume ⟨z, Metric.mem_ball_self hr⟩
  have hVfinite : (volume : Measure (textbookLangevinPeriodicPhase N)) V ≠ (⊤ : ℝ≥0∞) :=
    (lt_of_le_of_lt (measure_mono hballZ) hC.measure_lt_top).ne
  have hμ0 : μ univ ≠ 0 := by
    simpa only [μ, Measure.restrict_apply_univ] using hVpos.ne'
  have hμtop : μ univ ≠ (⊤ : ℝ≥0∞) := by
    simpa only [μ, Measure.restrict_apply_univ] using hVfinite
  let ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N) :=
    ⟨(μ univ)⁻¹ • μ, ⟨by
      rw [Measure.smul_apply, smul_eq_mul]
      exact ENNReal.inv_mul_cancel hμ0 hμtop⟩⟩
  let θ := ENNReal.ofReal ε * ENNReal.ofReal a
  let η := θ * μ univ
  have hη : 0 < η := ENNReal.mul_pos_iff.mpr
    ⟨ENNReal.mul_pos_iff.mpr ⟨ENNReal.ofReal_pos.mpr hε, ENNReal.ofReal_pos.mpr ha⟩,
      by simpa only [μ, Measure.restrict_apply_univ] using hVpos⟩
  have hηfinite : η ≠ (⊤ : ℝ≥0∞) :=
    ENNReal.mul_ne_top (ENNReal.mul_ne_top ENNReal.ofReal_ne_top ENNReal.ofReal_ne_top) hμtop
  have he : η • (ν : Measure (textbookLangevinPeriodicPhase N)) = θ • μ := by
    change (θ * μ univ) • ((μ univ)⁻¹ • μ) = θ • μ
    rw [smul_smul, mul_assoc, ENNReal.mul_inv_cancel hμ0 hμtop, mul_one]
  have hsmall : ∀ x ∈ C, η • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x := by
    intro x hx
    rw [he]
    apply Measure.le_iff.mpr
    intro A hA
    rw [Measure.smul_apply, smul_eq_mul, Measure.restrict_apply hA]
    simpa only [θ, V, hsplit] using hb x hx A hA
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  have hηone := Measure.le_iff.mp (hsmall y (interior_subset hy)) univ MeasurableSet.univ
  simp only [Measure.smul_apply, smul_eq_mul, measure_univ, mul_one] at hηone
  exact ⟨η, ν, hη, hηone, hηfinite, hsmall⟩

include hB in
/-- The original physical Langevin energy set is a genuine small set at the specified positive time, conditional on the original density clause on that exact set. -/
theorem textbookLangevinPeriodicDensityClause_physical_energy_minorization_at_time
    (hLower : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) (R : ℝ)
    (hR : textbookLangevinPeriodicHamiltonianPower U l
      ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R)
    (β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicDensityClause B P U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹))
      {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ) :
    ∃ (η : ℝ≥0∞) (ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N)),
      0 < η ∧ η ≤ 1 ∧ η ≠ (⊤ : ℝ≥0∞) ∧ ∀ x : textbookLangevinPeriodicPhase N,
        textbookLangevinPeriodicHamiltonianPower U l x ≤ R →
          η • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤
            textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) T x := by
  exact textbookLangevinPeriodicDensityClause_compact_minorization_at_time B P hB U hU hp L hF γ
    (Real.sqrt (2 * γ * β⁻¹)) _ ρ hρ
    (textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower l hl R)
    (textbookLangevinPeriodicHamiltonianPower_sublevel_interior_nonempty U hU hp l R hR)
    (ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))) T hT

include hB in
/-- The actual H^l drift gives a derived large energy set and a stronger contraction outside it, without assuming a drift inequality. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_large_sublevel_drift
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l → ∀ T : ℝ≥0, τ ≤ T →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        textbookLangevinPeriodicHamiltonianPower U l
          ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R ∧
        (∀ x : textbookLangevinPeriodicPhase N,
          (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
            ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
            (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D) ∧
        (∀ x : textbookLangevinPeriodicPhase N, R < textbookLangevinPeriodicHamiltonianPower U l x →
          (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
            ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x) ≤
            (3 / 4 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_large_time_drift
    B P hB U hU hp hLower L hF γ σ hγ
  refine ⟨τ, hτ, fun l hl T hT ↦ ?_⟩
  obtain ⟨D, hD, hd⟩ := h l hl T hT
  let V0 := textbookLangevinPeriodicHamiltonianPower U l
    ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ))
  have hV0 : 0 < V0 := textbookLangevinPeriodicHamiltonianPower_pos U hLower l _
  let R := 4 * D + V0 + 1
  have hR4 : 4 * D < R := by dsimp only [R]; linarith
  have hR0 : V0 < R := by dsimp only [R]; linarith
  refine ⟨D, R, hD, hR4, hR0, hd, fun x hx ↦ ?_⟩
  have hh := hd x
  linarith

include hB in
/-- The same actual kernel on one common positive skeleton time has derived proper H^l drift and, conditional on the original density clause on its derived large energy set, true measure minorization. -/
theorem textbookLangevinPeriodicTransitionKernel_hamiltonian_power_skeleton_inputs
    (hLower : ∀ q, 1 ≤ U q) (hγ : 0 < γ) (hσ : σ ≠ 0) :
    ∃ τ : ℝ≥0, 0 < τ ∧ ∀ l : ℕ, 1 ≤ l →
      ∃ D R : ℝ, 0 < D ∧ 4 * D < R ∧
        textbookLangevinPeriodicHamiltonianPower U l
          ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R ∧
        IsCompact {x : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l x ≤ R} ∧
        (interior {x : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l x ≤ R}).Nonempty ∧
        (∀ x : textbookLangevinPeriodicPhase N, Integrable (textbookLangevinPeriodicHamiltonianPower U l)
          (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x)) ∧
        (∀ x : textbookLangevinPeriodicPhase N,
          (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
            ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
            (1 / 2 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x + D) ∧
        (∀ x : textbookLangevinPeriodicPhase N,
          (∫ y, textbookLangevinPeriodicHamiltonianPower U l y
            ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) ≤
            (3 / 4 : ℝ) * textbookLangevinPeriodicHamiltonianPower U l x +
              {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}.indicator
                (fun _ ↦ D) x) ∧
        (∀ ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ,
          textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ
            {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ →
          ∃ (η : ℝ≥0∞) (ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N)),
            0 < η ∧ η ≤ 1 ∧ η ≠ (⊤ : ℝ≥0∞) ∧
            ∀ x : textbookLangevinPeriodicPhase N, textbookLangevinPeriodicHamiltonianPower U l x ≤ R →
              η • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤
                textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ τ x) := by
  obtain ⟨τ, hτ, h⟩ := textbookLangevinPeriodicTransitionKernel_hamiltonian_power_large_sublevel_drift
    B P hB U hU hp L hF γ σ hLower hγ
  refine ⟨τ, hτ, fun l hl ↦ ?_⟩
  obtain ⟨D, R, hD, hR4, hR0, hd, ho⟩ := h l hl τ le_rfl
  have hC := textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower l hl R
  have hCi := textbookLangevinPeriodicHamiltonianPower_sublevel_interior_nonempty U hU hp l R hR0
  refine ⟨D, R, hD, hR4, hR0, hC, hCi, ?_, hd, ?_, ?_⟩
  · intro x
    exact textbookLangevinPeriodicTransitionKernel_hamiltonian_power_integrable
      B P hB U hU hp hLower L hF γ σ hγ τ x l hl
  · intro x
    by_cases hx : textbookLangevinPeriodicHamiltonianPower U l x ≤ R
    · rw [Set.indicator_of_mem (show x ∈ {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} from hx)]
      have hh := hd x
      have hp := (textbookLangevinPeriodicHamiltonianPower_pos U hLower l x).le
      linarith
    · rw [Set.indicator_of_notMem (show x ∉ {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} from hx)]
      simpa only [add_zero] using ho x (lt_of_not_ge hx)
  · intro ρ hρ
    exact textbookLangevinPeriodicDensityClause_compact_minorization_at_time
      B P hB U hU hp L hF γ σ _ ρ hρ hC hCi hσ τ hτ

end
end MolecularDynamics
