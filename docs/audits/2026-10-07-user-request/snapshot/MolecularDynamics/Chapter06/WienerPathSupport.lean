import MolecularDynamics.Chapter06.WienerPathLaw
import Mathlib.Algebra.Order.Floor.Semiring
import Mathlib.Topology.UniformSpace.HeineCantor

/-! Genuine uniform-cell and endpoint-error estimates for prescribed-time Wiener control tubes. -/

open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology NNReal ENNReal

namespace MolecularDynamics

/-- Every time in the actual finite uniform interval belongs to an actual cell, including the final endpoint. -/
theorem textbookWienerUniformGrid_cell (h : ℝ≥0) (hh : 0 < h) (K : ℕ) (s : ℝ≥0)
    (hs : s ≤ h * (K + 1 : ℝ≥0)) :
    ∃ i : Fin (K + 1), ∃ r ∈ Icc (0 : ℝ≥0) h, s = h * (i : ℕ) + r := by
  let n := min (Nat.floor (s / h)) K
  have hnK : n ≤ K := Nat.min_le_right _ _
  have hnf : n ≤ Nat.floor (s / h) := Nat.min_le_left _ _
  have hdiv : (n : ℝ≥0) ≤ s / h :=
    (Nat.cast_le.mpr hnf).trans (Nat.floor_le (by positivity))
  have hb : h * n ≤ s := by
    simpa only [mul_comm] using (le_div_iff₀ hh).mp hdiv
  have hu : s ≤ h * (n + 1 : ℝ≥0) := by
    by_cases hf : Nat.floor (s / h) ≤ K
    · have he : n = Nat.floor (s / h) := min_eq_left hf
      rw [he]
      have ht := (div_lt_iff₀ hh).mp (Nat.lt_floor_add_one (s / h))
      simpa only [mul_comm] using ht.le
    · have he : n = K := min_eq_right (le_of_lt (lt_of_not_ge hf))
      simpa only [he] using hs
  let r := s - h * n
  have hr : r ≤ h := by
    apply tsub_le_iff_right.mpr
    calc
      s ≤ h * (n + 1 : ℝ≥0) := hu
      _ = h + h * n := by ring
  refine ⟨⟨n, Nat.lt_succ_of_le hnK⟩, r, ⟨by positivity, hr⟩, ?_⟩
  have he := tsub_add_cancel_of_le hb
  exact (by simpa only [add_comm] using he : h * n + r = s).symm

/-- The real endpoint error equals the genuine finite sum of the original increment errors. -/
theorem textbookWienerEndpointError_telescope {Ω : Type*} (B : ℝ≥0 → Ω → ℝ)
    (R : ℝ≥0 → ℝ) (h : ℝ≥0) (j : ℕ) (ω : Ω) (hB0 : B 0 ω = 0) (hR0 : R 0 = 0) :
    B (h * j) ω - R (h * j) =
      ∑ k ∈ Finset.range j, (textbookWienerSegment B h k h ω - (R (h * (k + 1)) - R (h * k))) := by
  have ht := Finset.sum_range_sub (fun k : ℕ ↦ B (h * k) ω - R (h * k)) j
  calc
    _ = ∑ k ∈ Finset.range j,
        ((B (h * (k + 1)) ω - R (h * (k + 1))) - (B (h * k) ω - R (h * k))) := by
      simpa [hB0, hR0] using ht.symm
    _ = _ := by
      apply Finset.sum_congr rfl
      intro k _
      have he : h * (k : ℝ≥0) + h = h * (k + 1 : ℝ≥0) := by ring
      unfold textbookWienerSegment
      rw [he]
      abel


/-- Actual refinement of a prescribed positive total time below any positive mesh threshold. -/
theorem textbookWienerUniformGrid_exists (T η : ℝ≥0) (hT : 0 < T) (hη : 0 < η) :
    ∃ K : ℕ, ∃ h : ℝ≥0, 0 < h ∧ h < η ∧ h * (K + 1 : ℝ≥0) = T := by
  obtain ⟨K, hK⟩ := exists_nat_gt (T / η)
  have hN : 0 < (K + 1 : ℝ≥0) := by positivity
  have ht : T < (K + 1 : ℝ≥0) * η := by
    have hk := (div_lt_iff₀ hη).mp hK
    have hle : (K : ℝ≥0) ≤ (K + 1 : ℝ≥0) := le_add_of_nonneg_right (by positivity)
    exact hk.trans_le (mul_le_mul_of_nonneg_right hle (by positivity))
  refine ⟨K, T / (K + 1 : ℝ≥0), div_pos hT hN, (div_lt_iff₀ hN).mpr ?_, ?_⟩
  · simpa only [mul_comm] using ht
  · exact div_mul_cancel₀ _ hN.ne'

/-- The true accumulated grid error is bounded by the sum of the genuine endpoint errors. -/
theorem textbookWienerEndpointError_bound {Ω : Type*} (B : ℝ≥0 → Ω → ℝ)
    (R : ℝ≥0 → ℝ) (h : ℝ≥0) (N j : ℕ) (ω : Ω) (δ : ℝ) (hδ : 0 ≤ δ)
    (hB0 : B 0 ω = 0) (hR0 : R 0 = 0) (hj : j ≤ N)
    (he : ∀ k < N,
      |textbookWienerSegment B h k h ω - (R (h * (k + 1)) - R (h * k))| ≤ δ) :
    |B (h * j) ω - R (h * j)| ≤ (N : ℝ) * δ := by
  rw [textbookWienerEndpointError_telescope B R h j ω hB0 hR0]
  calc
    _ ≤ ∑ k ∈ Finset.range j,
        |textbookWienerSegment B h k h ω - (R (h * (k + 1)) - R (h * k))| :=
      Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _k ∈ Finset.range j, δ := Finset.sum_le_sum (fun k hk ↦
      he k (lt_of_lt_of_le (Finset.mem_range.mp hk) hj))
    _ = (j : ℝ) * δ := by simp
    _ ≤ (N : ℝ) * δ := mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hj) hδ

/-- True grid endpoint, bridge, and control oscillation bounds imply an entire-path error bound. -/
theorem textbookWienerGridTube_bound {Ω : Type*} (B : ℝ≥0 → Ω → ℝ)
    (R : ℝ≥0 → ℝ) (h : ℝ≥0) (hh : 0 < h) (K : ℕ) (ω : Ω)
    (b δ α : ℝ) (hδ : 0 ≤ δ) (hB0 : B 0 ω = 0) (hR0 : R 0 = 0)
    (he : ∀ i : Fin (K + 1),
      |textbookWienerSegment B h i h ω - (R (h * ((i : ℕ) + 1)) - R (h * (i : ℕ)))| ≤ δ)
    (hb : ∀ i : Fin (K + 1), ∀ r ∈ Icc 0 h,
      |textbookBrownianBridge (textbookWienerSegment B h i) h r ω| ≤ b)
    (hR : ∀ i : Fin (K + 1), ∀ r ∈ Icc 0 h,
      |R (h * (i : ℕ) + r) - R (h * (i : ℕ))| ≤ α) :
    ∀ s ∈ Icc 0 (h * (K + 1 : ℝ≥0)),
      |B s ω - R s| ≤ b + (K + 1 : ℝ) * δ + δ + 2 * α := by
  intro s hs
  obtain ⟨i, r, hr, rfl⟩ := textbookWienerUniformGrid_cell h hh K s hs.2
  have hhr : 0 < (h : ℝ) := by exact_mod_cast hh
  have hrr : (r : ℝ) ≤ h := by exact_mod_cast hr.2
  have hc0 : 0 ≤ (r : ℝ) / h := div_nonneg r.property hhr.le
  have hc1 : (r : ℝ) / h ≤ 1 := (div_le_one hhr).mpr hrr
  have hg := textbookWienerEndpointError_bound B R h (K + 1) i ω δ hδ hB0 hR0
    (Nat.le_of_lt i.2) (fun k hk ↦ he ⟨k, hk⟩)
  have hg' : |B (h * (i : ℕ)) ω - R (h * (i : ℕ))| ≤ (K + 1 : ℝ) * δ := by
    simpa only [Nat.cast_add, Nat.cast_one] using hg
  have ha : |R (h * ((i : ℕ) + 1)) - R (h * (i : ℕ))| ≤ α := by
    have ht : h * (i : ℕ) + h = h * ((i : ℕ) + 1 : ℝ≥0) := by ring
    simpa only [ht] using hR i h ⟨by positivity, le_rfl⟩
  have hi := hR i r hr
  let a := R (h * ((i : ℕ) + 1)) - R (h * (i : ℕ))
  let e := textbookWienerSegment B h i h ω - a
  let c := (r : ℝ) / h
  have hce : |c * e| ≤ δ := by
    rw [abs_mul, abs_of_nonneg hc0]
    calc
      _ ≤ 1 * |e| := mul_le_mul_of_nonneg_right hc1 (abs_nonneg _)
      _ ≤ δ := by simpa [e, a] using he i
  have hca : |c * a| ≤ α := by
    rw [abs_mul, abs_of_nonneg hc0]
    calc
      _ ≤ 1 * |a| := mul_le_mul_of_nonneg_right hc1 (abs_nonneg _)
      _ ≤ α := by simpa [a] using ha
  have hid : B (h * (i : ℕ) + r) ω - R (h * (i : ℕ) + r) =
      ((textbookBrownianBridge (textbookWienerSegment B h i) h r ω + c * e) +
        (B (h * (i : ℕ)) ω - R (h * (i : ℕ)))) +
        (c * a - (R (h * (i : ℕ) + r) - R (h * (i : ℕ)))) := by
    dsimp [c, e, a, textbookBrownianBridge, textbookWienerSegment]
    ring
  rw [hid]
  have hp : |c * a - (R (h * (i : ℕ) + r) - R (h * (i : ℕ)))| ≤ 2 * α := by
    calc
      _ ≤ |c * a| + |R (h * (i : ℕ) + r) - R (h * (i : ℕ))| := by
        simpa only [Real.norm_eq_abs] using norm_sub_le (c * a) (R (h * (i : ℕ) + r) - R (h * (i : ℕ)))
      _ ≤ α + α := add_le_add hca hi
      _ = 2 * α := by ring
  calc
    _ ≤ |(textbookBrownianBridge (textbookWienerSegment B h i) h r ω + c * e) +
          (B (h * (i : ℕ)) ω - R (h * (i : ℕ)))| +
        |c * a - (R (h * (i : ℕ) + r) - R (h * (i : ℕ)))| := by
      simp only [← Real.norm_eq_abs]
      exact norm_add_le _ _
    _ ≤ (|textbookBrownianBridge (textbookWienerSegment B h i) h r ω + c * e| +
        |B (h * (i : ℕ)) ω - R (h * (i : ℕ))|) + 2 * α := by
      have ht : |(textbookBrownianBridge (textbookWienerSegment B h i) h r ω + c * e) +
          (B (h * (i : ℕ)) ω - R (h * (i : ℕ)))| ≤
        |textbookBrownianBridge (textbookWienerSegment B h i) h r ω + c * e| +
          |B (h * (i : ℕ)) ω - R (h * (i : ℕ))| := by
        simp only [← Real.norm_eq_abs]
        exact norm_add_le _ _
      exact add_le_add ht hp
    _ ≤ ((|textbookBrownianBridge (textbookWienerSegment B h i) h r ω| + |c * e|) +
        (K + 1 : ℝ) * δ) + 2 * α := by
      have ht : |textbookBrownianBridge (textbookWienerSegment B h i) h r ω + c * e| ≤
          |textbookBrownianBridge (textbookWienerSegment B h i) h r ω| + |c * e| := by
        simp only [← Real.norm_eq_abs]
        exact norm_add_le _ _
      exact add_le_add (add_le_add ht hg') le_rfl
    _ ≤ ((b + δ) + (K + 1 : ℝ) * δ) + 2 * α := by
      exact add_le_add (add_le_add (add_le_add (hb i r hr) hce) le_rfl) le_rfl
    _ = _ := by ring


/-- The actual entire-path tube around a prescribed continuous control. -/
def textbookWienerControlTube {Ω : Type*} (B : ℝ≥0 → Ω → ℝ)
    (T : ℝ≥0) (R : ℝ≥0 → ℝ) (ε : ℝ) : Set Ω :=
  {ω | ∀ s ∈ Icc 0 T, |B s ω - R s| ≤ ε}

/-- True sample continuity identifies the control tube with its dense countable sample event. -/
theorem textbookWienerControlTube_ae_samples {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (T : ℝ≥0) (hT : 0 < T) (R : ℝ≥0 → ℝ) (hR : ContinuousOn R (Icc 0 T))
    (u : ℕ → Icc (0 : ℝ≥0) 1) (hu : DenseRange u) (ε : ℝ) :
    {ω | ∀ k, |B (T * u k) ω - R (T * u k)| ≤ ε} =ᵐ[P]
      textbookWienerControlTube B T R ε := by
  let f : Icc (0 : ℝ≥0) 1 → Icc (0 : ℝ≥0) T := fun v ↦
    ⟨T * v, by positivity, by simpa using mul_le_mul_of_nonneg_left v.2.2 (by positivity : (0 : ℝ≥0) ≤ T)⟩
  have hf : Continuous f := by fun_prop
  have hr : Continuous (fun v : Icc (0 : ℝ≥0) 1 ↦ R (T * v)) := hR.domRestrict.comp hf
  filter_upwards [hB.cont] with ω hc
  apply propext
  constructor
  · intro h s hs
    let v : Icc (0 : ℝ≥0) 1 := ⟨s / T, by positivity, (div_le_one hT).mpr hs.2⟩
    have hh : Continuous (fun v : Icc (0 : ℝ≥0) 1 ↦ |B (T * v) ω - R (T * v)|) :=
      ((hc.comp (continuous_const.mul continuous_subtype_val)).sub hr).abs
    have hb : |B (T * (v : ℝ≥0)) ω - R (T * v)| ≤ ε :=
      hu.induction_on v (isClosed_le hh continuous_const) h
    have he : T * (v : ℝ≥0) = s := by dsimp [v]; field_simp
    simpa only [he] using hb
  · intro h k
    apply h
    refine ⟨by positivity, ?_⟩
    simpa using mul_le_mul_of_nonneg_left (u k).2.2 (by positivity : (0 : ℝ≥0) ≤ T)

/-- A genuine continuous control tube is null-measurable by actual Brownian sample continuity. -/
theorem textbookWienerControlTube_nullMeasurable {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (T : ℝ≥0) (hT : 0 < T) (R : ℝ≥0 → ℝ) (hR : ContinuousOn R (Icc 0 T)) (ε : ℝ) :
    NullMeasurableSet (textbookWienerControlTube B T R ε) P := by
  let : Nonempty (Icc (0 : ℝ≥0) 1) := ⟨⟨0, by simp⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ≥0) 1)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  let E : Set Ω := {ω | ∀ k, |B (T * u k) ω - R (T * u k)| ≤ ε}
  have hE : NullMeasurableSet E P := by
    unfold E
    simp only [ofPred_forall]
    apply NullMeasurableSet.iInter
    intro k
    exact nullMeasurableSet_le ((hB.aemeasurable (T * u k)).sub_const _).norm aemeasurable_const
  exact hE.congr (textbookWienerControlTube_ae_samples B P hB T hT R hR u hu ε)

/-- At every prescribed positive time, every actual continuous control from zero has a positive Wiener tube. -/
theorem textbookWienerControlTube_pos {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → ℝ) (P : Measure Ω) (hB : IsBrownianReal B P)
    (T : ℝ≥0) (hT : 0 < T) (R : ℝ≥0 → ℝ) (hR : ContinuousOn R (Icc 0 T))
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerControlTube B T R ε) := by
  let : Nonempty (Icc (0 : ℝ≥0) 1) := ⟨⟨0, by simp⟩⟩
  let u := TopologicalSpace.denseSeq (Icc (0 : ℝ≥0) 1)
  have hu : DenseRange u := TopologicalSpace.denseRange_denseSeq _
  obtain ⟨η, hη, hp⟩ := textbookWienerSegmentJointEvent_short_pos B P hB u (ε / 8) (by positivity)
  obtain ⟨ρ, hρ, hm⟩ := Metric.uniformContinuousOn_iff.mp
    (isCompact_Icc.uniformContinuousOn_of_continuous hR) (ε / 8) (by positivity)
  let θ : ℝ≥0 := min η ⟨ρ, hρ.le⟩
  have hθ : 0 < θ := lt_min hη (by exact_mod_cast hρ)
  obtain ⟨K, h, hh, hhθ, heT⟩ := textbookWienerUniformGrid_exists T θ hT hθ
  have hhη : h ≤ η := (hhθ.trans_le (min_le_left _ _)).le
  have hhρ : (h : ℝ) < ρ := by
    have ht : h < (⟨ρ, hρ.le⟩ : ℝ≥0) := hhθ.trans_le (min_le_right _ _)
    exact_mod_cast ht
  let a : Fin (K + 1) → ℝ := fun i ↦ R (h * ((i : ℕ) + 1)) - R (h * (i : ℕ))
  let δ : ℝ := ε / (8 * (K + 1 : ℝ))
  have hN : 0 < (K + 1 : ℝ) := by positivity
  have hδ : 0 < δ := by dsimp [δ]; positivity
  have hδN : (K + 1 : ℝ) * δ = ε / 8 := by dsimp [δ]; field_simp
  have hδle : δ ≤ ε / 8 := by
    dsimp [δ]
    apply (div_le_iff₀ (by positivity : 0 < 8 * (K + 1 : ℝ))).mpr
    have hn : (1 : ℝ) ≤ (K + 1 : ℝ) := le_add_of_nonneg_left (by positivity)
    nlinarith
  have hmod : ∀ i : Fin (K + 1), ∀ r ∈ Icc 0 h,
      |R (h * (i : ℕ) + r) - R (h * (i : ℕ))| ≤ ε / 8 := by
    intro i r hr
    have hi : ((i : ℕ) + 1 : ℝ≥0) ≤ (K + 1 : ℝ≥0) := by
      exact_mod_cast Nat.succ_le_of_lt i.2
    have hx : h * (i : ℕ) + r ≤ T := by
      calc
        _ ≤ h * (i : ℕ) + h := add_le_add le_rfl hr.2
        _ = h * ((i : ℕ) + 1 : ℝ≥0) := by ring
        _ ≤ h * (K + 1 : ℝ≥0) := mul_le_mul_of_nonneg_left hi (by positivity)
        _ = T := heT
    have hy : h * (i : ℕ) ≤ T := (le_add_of_nonneg_right hr.1).trans hx
    have hd : dist (h * (i : ℕ) + r) (h * (i : ℕ)) < ρ := by
      rw [NNReal.dist_eq, NNReal.coe_add, add_sub_cancel_left]
      calc
        |(r : ℝ)| = (r : ℝ) := abs_of_nonneg r.property
        _ < ρ := (NNReal.coe_le_coe.mpr hr.2).trans_lt hhρ
    have ht := hm _ ⟨by positivity, hx⟩ _ ⟨by positivity, hy⟩ hd
    simpa only [Real.dist_eq] using ht.le
  have hpos := hp h ⟨hh, hhη⟩ (K + 1) a (fun _ ↦ δ) (fun _ ↦ hδ)
  apply lt_of_lt_of_le hpos
  apply measure_mono_ae
  have hfull : ∀ᵐ ω ∂P, ∀ i : Fin (K + 1),
      ω ∈ textbookBrownianBridgeSampleTube (textbookWienerSegment B h i) h u (ε / 8) ↔
        ∀ s ∈ Icc 0 h, |textbookBrownianBridge (textbookWienerSegment B h i) h s ω| ≤ ε / 8 := by
    apply ae_all_iff.mpr
    intro i
    exact textbookBrownianBridgeSampleTube_ae_full _ P (hB.shift (h * (i : ℕ))) h hh.ne' u hu (ε / 8)
  filter_upwards [hfull, hB.eval_zero_ae_eq_zero] with ω hω hz
  intro hjoint s hs
  have hb (i : Fin (K + 1)) := (hω i).mp (hjoint i).1
  have hend (i : Fin (K + 1)) :
      |textbookWienerSegment B h i h ω - (R (h * ((i : ℕ) + 1)) - R (h * (i : ℕ)))| ≤ δ := by
    have ht := (hjoint i).2
    change |textbookWienerSegment B h i h ω - a i| < δ at ht
    exact ht.le
  have hbnd := textbookWienerGridTube_bound B R h hh K ω (ε / 8) δ (ε / 8)
    hδ.le hz hR0 hend hb hmod s (by simpa only [heT] using hs)
  rw [hδN] at hbnd
  exact hbnd.trans (by linarith)

end MolecularDynamics
