import MolecularDynamics.Chapter06.LangevinDensityTimeZero

/-! The explicit positive-time variant for Theorem 6.2 implies genuine local measure
lower bounds for the same actual Langevin kernel. Existence of such a density
for the actual SDE remains a separate proof obligation. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal

namespace MolecularDynamics
noncomputable section

local instance langevinPositiveTimeHaarMeasureSpace : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
local instance langevinPositiveTimeHaarIsAddHaar : Measure.IsAddHaarMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (Measure.IsAddHaarMeasure AddCircle.haarAddCircle)
local instance langevinPositiveTimeHaarProbability : IsProbabilityMeasure (volume : Measure UnitAddCircle) :=
  inferInstanceAs (IsProbabilityMeasure AddCircle.haarAddCircle)

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ)

/-- Explicit positive-time variant of Assumption 1(ii), separate from the literal original: the actual transition is represented by its flat-reference density on C at positive times, with the positive-time joint continuity. -/
def textbookLangevinPeriodicPositiveTimeDensityClause
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ) : Prop :=
  (∀ (T : ℝ≥0), (0 : ℝ) < T → ∀ x ∈ C,
    ∀ A : Set (textbookLangevinPeriodicPhase N), MeasurableSet A → A ⊆ C →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z T)) ∧
  ContinuousOn (fun w : (textbookLangevinPeriodicPhase N × textbookLangevinPeriodicPhase N) × ℝ ↦
    ρ w.1.1 w.1.2 w.2) ((C ×ˢ C) ×ˢ Ioi 0)

/-- The explicit positive-time joint density continuity includes the continuous spatial sheet at every positive time. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_fixed_time_continuous
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ) (T : ℝ≥0) (hT : (0 : ℝ) < T) :
    ContinuousOn (fun w : textbookLangevinPeriodicPhase N × textbookLangevinPeriodicPhase N ↦ ρ w.1 w.2 T)
      (C ×ˢ C) := by
  exact hρ.2.comp (continuous_id.prodMk continuous_const).continuousOn (fun w hw ↦ ⟨hw, hT⟩)

include hB in
/-- Genuine open accessibility and the original density representation force an actually positive density value inside C, rather than assuming positivity as a conclusion. -/
private theorem textbookLangevinPeriodicPositiveTimeDensityClause_positive_interior_point
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ)
    (hσ : σ ≠ 0) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (y : textbookLangevinPeriodicPhase N) (hy : y ∈ interior C) :
    ∃ z ∈ interior C, 0 < ρ y z T := by
  obtain ⟨r, hr, hb⟩ := Metric.mem_nhds_iff.mp (mem_interior_iff_mem_nhds.mp hy)
  have hpos := textbookLangevinPeriodicTransitionKernel_open_pos B P hB U hU hp L hF γ σ T hT hσ y
    (Metric.ball y r) Metric.isOpen_ball ⟨y, Metric.mem_ball_self hr⟩
  rw [hρ.1 T hT y (interior_subset hy) _ Metric.isOpen_ball.measurableSet hb] at hpos
  have he : ∃ z ∈ Metric.ball y r, 0 < ρ y z T := by
    by_contra hn
    push Not at hn
    have hz : (∫⁻ z in Metric.ball y r, ENNReal.ofReal (ρ y z T)) = 0 := by
      apply lintegral_eq_zero_of_ae_eq_zero
      filter_upwards [ae_restrict_mem Metric.isOpen_ball.measurableSet] with z hz
      exact ENNReal.ofReal_eq_zero.mpr (hn z hz)
    rw [hz] at hpos
    exact (lt_irrefl _ hpos)
  obtain ⟨z, hz, hpz⟩ := he
  exact ⟨z, (Metric.isOpen_ball.subset_interior_iff.mpr hb) hz, hpz⟩

/-- A genuinely positive interior density value and original joint continuity produce true positive density lower bounds on actual product neighborhoods. -/
private theorem textbookLangevinPeriodicPositiveTimeDensityClause_local_lower_bound
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (y z : textbookLangevinPeriodicPhase N)
    (hy : y ∈ interior C) (hz : z ∈ interior C) (hpos : 0 < ρ y z T) :
    ∃ a r : ℝ, 0 < a ∧ 0 < r ∧ Metric.ball y r ⊆ C ∧ Metric.ball z r ⊆ C ∧
      ∀ x ∈ Metric.ball y r, ∀ w ∈ Metric.ball z r, a ≤ ρ x w T := by
  let a := ρ y z T / 2
  have ha : 0 < a := by dsimp [a]; linarith
  have hal : a < ρ y z T := by dsimp [a]; linarith
  have hmem : (y, z) ∈ interior (C ×ˢ C) := by
    rw [interior_prod_eq]
    exact ⟨hy, hz⟩
  have hC : C ×ˢ C ∈ 𝓝 (y, z) := mem_interior_iff_mem_nhds.mp hmem
  have hc := (textbookLangevinPeriodicPositiveTimeDensityClause_fixed_time_continuous B P U hU hp L hF γ σ C ρ hρ T hT
    (y, z) ⟨interior_subset hy, interior_subset hz⟩).continuousAt hC
  have hval : {w : textbookLangevinPeriodicPhase N × textbookLangevinPeriodicPhase N | a < ρ w.1 w.2 T}
      ∈ 𝓝 (y, z) := hc.preimage_mem_nhds (Ioi_mem_nhds hal)
  obtain ⟨r, hr, hb⟩ := Metric.mem_nhds_iff.mp (inter_mem hC hval)
  have hpair (x w : textbookLangevinPeriodicPhase N) (hx : x ∈ Metric.ball y r) (hw : w ∈ Metric.ball z r) :
      (x, w) ∈ Metric.ball (y, z) r := by
    rw [Metric.mem_ball, Prod.dist_eq, max_lt_iff]
    exact ⟨hx, hw⟩
  refine ⟨a, r, ha, hr, ?_, ?_, ?_⟩
  · intro x hx
    exact (hb (hpair x z hx (Metric.mem_ball_self hr))).1.1
  · intro w hw
    exact (hb (hpair y w (Metric.mem_ball_self hr) hw)).1.2
  · intro x hx w hw
    exact (hb (hpair x w hx hw)).2.le

/-- Original local density representation and a true lower density bound imply actual measure minorization on the target ball for every measurable event. -/
private theorem textbookLangevinPeriodicPositiveTimeDensityClause_local_minorization
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (y z : textbookLangevinPeriodicPhase N) (a r : ℝ)
    (hy : Metric.ball y r ⊆ C) (hz : Metric.ball z r ⊆ C)
    (hb : ∀ x ∈ Metric.ball y r, ∀ w ∈ Metric.ball z r, a ≤ ρ x w T)
    (x : textbookLangevinPeriodicPhase N) (hx : x ∈ Metric.ball y r)
    (A : Set (textbookLangevinPeriodicPhase N)) (hA : MeasurableSet A) :
    ENNReal.ofReal a * volume (A ∩ Metric.ball z r) ≤
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x A := by
  have hAB : MeasurableSet (A ∩ Metric.ball z r) := hA.inter Metric.isOpen_ball.measurableSet
  calc
    _ = ∫⁻ _ in A ∩ Metric.ball z r, ENNReal.ofReal a := (setLIntegral_const _ _).symm
    _ ≤ ∫⁻ w in A ∩ Metric.ball z r, ENNReal.ofReal (ρ x w T) := by
      apply lintegral_mono_ae
      filter_upwards [ae_restrict_mem hAB] with w hw
      exact ENNReal.ofReal_le_ofReal (hb x hx w hw.2)
    _ = textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x (A ∩ Metric.ball z r) :=
      (hρ.1 T hT x (hy hx) _ hAB (fun w hw ↦ hz hw.2)).symm
    _ ≤ _ := measure_mono inter_subset_left


include hB in
/-- True Chapman–Kolmogorov composition and compact-uniform access lift the local density bound to the whole compact set for every measurable event. -/
private theorem textbookLangevinPeriodicPositiveTimeDensityClause_two_step_lower_bound
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ)
    (hC : IsCompact C) (hσ : σ ≠ 0) (S T : ℝ≥0)
    (hS : (0 : ℝ) < S) (hT : (0 : ℝ) < T)
    (y z : textbookLangevinPeriodicPhase N) (a r : ℝ) (hr : 0 < r)
    (hy : Metric.ball y r ⊆ C) (hz : Metric.ball z r ⊆ C)
    (hb : ∀ x ∈ Metric.ball y r, ∀ w ∈ Metric.ball z r, a ≤ ρ x w T) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ x ∈ C, ∀ A : Set (textbookLangevinPeriodicPhase N), MeasurableSet A →
      (ENNReal.ofReal ε * ENNReal.ofReal a) * volume (A ∩ Metric.ball z r) ≤
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ (S + T) x A := by
  obtain ⟨ε, hε, hhit⟩ := textbookLangevinPeriodicTransitionKernel_compact_open_uniform_pos B P hB U hU hp L hF γ σ
    S hS hσ C (Metric.ball y r) hC Metric.isOpen_ball ⟨y, Metric.mem_ball_self hr⟩
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ S
  have : IsMarkovKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T) :=
    textbookLangevinPeriodicTransitionKernel_isMarkov B P hB U hU hp L hF γ σ T
  refine ⟨ε, hε, ?_⟩
  intro x hx A hA
  rw [textbookLangevinPeriodicTransitionKernel_add B P hB U hU hp L hF γ σ S T, Kernel.comp_apply' _ _ _ hA]
  calc
    _ = (ENNReal.ofReal a * volume (A ∩ Metric.ball z r)) * ENNReal.ofReal ε := by ac_rfl
    _ ≤ (ENNReal.ofReal a * volume (A ∩ Metric.ball z r)) *
        textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S x (Metric.ball y r) :=
      by
        gcongr
        exact hhit x hx
    _ = ∫⁻ _ in Metric.ball y r, ENNReal.ofReal a * volume (A ∩ Metric.ball z r)
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S x :=
      (setLIntegral_const _ _).symm
    _ ≤ ∫⁻ w in Metric.ball y r, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T w A
        ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S x := by
      apply lintegral_mono_ae
      filter_upwards [ae_restrict_mem Metric.isOpen_ball.measurableSet] with w hw
      exact textbookLangevinPeriodicPositiveTimeDensityClause_local_minorization B P U hU hp L hF γ σ C ρ hρ
        T hT y z a r hy hz hb w hw A hA
    _ ≤ _ := by
      simpa only [Measure.restrict_univ] using
        (lintegral_mono_set (μ := textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ S x)
          (f := fun w ↦ textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T w A)
          (subset_univ (Metric.ball y r)))


/-- The literal printed condition has the positive-time part, without asserting any converse or a witness of either clause. -/
theorem textbookLangevinPeriodicDensityClause_positive_time_part
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicDensityClause B P U hU hp L hF γ σ C ρ) :
    textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ := by
  refine ⟨hρ.1, hρ.2.mono ?_⟩
  intro w hw
  exact ⟨hw.1, show (0 : ℝ) ≤ w.2 from le_of_lt (show (0 : ℝ) < w.2 from hw.2)⟩

include hB in
/-- At every prescribed positive total time, the explicit positive-time density clause implies a true compact small set for the same actual kernel; the two half times sum to that exact time. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_compact_minorization_at_time
    (C : Set (textbookLangevinPeriodicPhase N))
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ σ C ρ)
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
  obtain ⟨z, hz, hpos⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_positive_interior_point B P hB U hU hp L hF γ σ
    C ρ hρ hσ u hu y hy
  obtain ⟨a, r, ha, hr, hballY, hballZ, hbound⟩ :=
    textbookLangevinPeriodicPositiveTimeDensityClause_local_lower_bound B P U hU hp L hF γ σ C ρ hρ u hu y z hy hz hpos
  obtain ⟨ε, hε, hb⟩ := textbookLangevinPeriodicPositiveTimeDensityClause_two_step_lower_bound B P hB U hU hp L hF γ σ
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
/-- The original physical Langevin energy set is a genuine small set at the specified positive time, conditional on the explicit positive-time density clause on that exact set. -/
theorem textbookLangevinPeriodicPositiveTimeDensityClause_physical_energy_minorization_at_time
    (hLower : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) (R : ℝ)
    (hR : textbookLangevinPeriodicHamiltonianPower U l
      ((0 : UnitAddTorus (Fin N)), (0 : Fin N → ℝ)) < R)
    (β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (ρ : textbookLangevinPeriodicPhase N → textbookLangevinPeriodicPhase N → ℝ → ℝ)
    (hρ : textbookLangevinPeriodicPositiveTimeDensityClause B P U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹))
      {z : textbookLangevinPeriodicPhase N | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} ρ) :
    ∃ (η : ℝ≥0∞) (ν : ProbabilityMeasure (textbookLangevinPeriodicPhase N)),
      0 < η ∧ η ≤ 1 ∧ η ≠ (⊤ : ℝ≥0∞) ∧ ∀ x : textbookLangevinPeriodicPhase N,
        textbookLangevinPeriodicHamiltonianPower U l x ≤ R →
          η • (ν : Measure (textbookLangevinPeriodicPhase N)) ≤
            textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2 * γ * β⁻¹)) T x := by
  exact textbookLangevinPeriodicPositiveTimeDensityClause_compact_minorization_at_time B P hB U hU hp L hF γ
    (Real.sqrt (2 * γ * β⁻¹)) _ ρ hρ
    (textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hp hLower l hl R)
    (textbookLangevinPeriodicHamiltonianPower_sublevel_interior_nonempty U hU hp l R hR)
    (ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (by norm_num) hγ) (inv_pos.mpr hβ)))) T hT


end
end MolecularDynamics
