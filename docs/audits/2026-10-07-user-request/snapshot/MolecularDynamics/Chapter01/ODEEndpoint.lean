import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Tactic.Abel
import Mathlib.Analysis.ODE.ExistUnique

/-!
# Recovery of the endpoint derivative and local ODE matching

Dependencies for finite endpoint continuation, supporting Theorem 1.1
(printed page 32 / PDF page 55). The fundamental theorem of calculus recovers
the endpoint derivative, then local Lipschitz uniqueness identifies a tail
of the original curve with a genuine IVP through its endpoint limit.
-/

open Set Filter MeasureTheory
open scoped Topology

namespace MolecularDynamics

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

/-- Continuous derivative data on a closed interval recover the derivative
at its right endpoint from derivatives on the interior. -/
theorem hasDerivWithinAt_rightEndpoint_of_continuousOn {a b : ℝ} {f f' : ℝ → E}
    (hab : a ≤ b) (hcont : ContinuousOn f (Icc a b))
    (hder : ∀ t ∈ Ioo a b, HasDerivAt f (f' t) t)
    (hdercont : ContinuousOn f' (Icc a b)) :
    HasDerivWithinAt f (f' b) (Icc a b) b := by
  have hint : IntervalIntegrable f' volume a b := by
    apply ContinuousOn.intervalIntegrable
    simpa [uIcc_of_le hab] using hdercont
  have : Fact (b ∈ Icc a b) := ⟨⟨hab, le_rfl⟩⟩
  have hd := intervalIntegral.integral_hasDerivWithinAt_right
    (s := Icc a b) (t := Icc a b) hint
    (hdercont.stronglyMeasurableAtFilter_nhdsWithin measurableSet_Icc b)
    (hdercont b ⟨hab, le_rfl⟩)
  have heq : ∀ x ∈ Icc a b, f x = f a + ∫ t in a..x, f' t := by
    intro x hx
    have hsub : Icc a x ⊆ Icc a b := Icc_subset_Icc le_rfl hx.2
    have hi : IntervalIntegrable f' volume a x := by
      apply ContinuousOn.intervalIntegrable
      simpa [uIcc_of_le hx.1] using hdercont.mono hsub
    have hval := intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le hx.1
      (hcont.mono hsub)
      (fun t ht => hder t ⟨ht.1, lt_of_lt_of_le ht.2 hx.2⟩) hi
    rw [hval]
    abel
  exact (hd.const_add (f a)).congr_of_mem heq ⟨hab, le_rfl⟩


/-- A C¹ field at the finite endpoint limit admits a local IVP whose left
tail agrees with the original solution. Overlap equality is derived. -/
theorem exists_localODE_matching_rightEndpoint {v : E → E} {γ : ℝ → E} {a b : ℝ} {z : E}
    (hab : a < b) (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (v (γ t)) t)
    (hz : Tendsto γ (𝓝[<] b) (𝓝 z)) (hv : ContDiffAt ℝ 1 v z) :
    ∃ ε > 0, ∃ η : ℝ → E, η b = z ∧
      (∀ t ∈ Ioo (b - ε) (b + ε), HasDerivAt η (v (η t)) t) ∧
      ∃ c ∈ Ioo a b, EqOn γ η (Ioo c b) := by
  classical
  obtain ⟨η, hη₀, ε, hε, hη⟩ :=
    hv.exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀ b
  have hb : b ∈ Ioo (b - ε) (b + ε) := by constructor <;> linarith
  obtain ⟨L, S, hS, hLip⟩ := hv.exists_lipschitzOnWith
  have hγS : ∀ᶠ t in 𝓝[<] b, γ t ∈ S := hz.eventually hS
  have hηS : ∀ᶠ t in 𝓝 b, η t ∈ S :=
    (hη b hb).continuousAt.preimage_mem_nhds (by simpa [hη₀] using hS)
  have htail_event : ∀ᶠ t in 𝓝[<] b,
      γ t ∈ S ∧ η t ∈ S ∧ t ∈ Ioo a b ∧ t ∈ Ioo (b - ε) (b + ε) := by
    filter_upwards [hγS, nhdsWithin_le_nhds hηS, Ioo_mem_nhdsLT hab,
      nhdsWithin_le_nhds (Ioo_mem_nhds hb.1 hb.2)] with t ht₁ ht₂ ht₃ ht₄
    exact ⟨ht₁, ht₂, ht₃, ht₄⟩
  obtain ⟨l, hl, htail⟩ := mem_nhdsLT_iff_exists_Ioo_subset.mp htail_event
  have hlb : l < b := hl
  obtain ⟨c, hlc, hcb⟩ := exists_between hlb
  have hc := htail ⟨hlc, hcb⟩
  let f := Function.update γ b z
  have hfc : ContinuousOn f (Icc c b) := by
    dsimp [f]
    rw [continuousOn_update_iff, Icc_sdiff_right]
    refine ⟨?_, fun _ => hz.mono_left (nhdsWithin_mono _ Ico_subset_Iio_self)⟩
    intro t ht
    exact (hγ t ⟨lt_of_lt_of_le hc.2.2.1.1 ht.1, ht.2⟩).continuousAt.continuousWithinAt
  have hfm : MapsTo f (Icc c b) S := by
    intro t ht
    by_cases htb : t = b
    · subst t
      simpa [f] using mem_of_mem_nhds hS
    · have htb' : t < b := lt_of_le_of_ne ht.2 htb
      have h := htail ⟨lt_of_lt_of_le hlc ht.1, htb'⟩
      simpa [f, Function.update_of_ne htb] using h.1
  have hfd : ∀ t ∈ Ioo c b, HasDerivAt f (v (f t)) t := by
    intro t ht
    have hd := hγ t ⟨lt_trans hc.2.2.1.1 ht.1, ht.2⟩
    have he : f =ᶠ[𝓝 t] γ := by
      filter_upwards [Iio_mem_nhds ht.2] with s hs
      exact Function.update_of_ne (ne_of_lt hs) z γ
    have he₀ : f t = γ t := Function.update_of_ne ht.2.ne z γ
    rw [he₀]
    exact hd.congr_of_eventuallyEq he
  have hfv : ContinuousOn (fun t => v (f t)) (Icc c b) := hLip.continuousOn.comp hfc hfm
  have hfb := hasDerivWithinAt_rightEndpoint_of_continuousOn hcb.le hfc hfd hfv
  have hηc : ∀ t ∈ Icc c b, t ∈ Ioo (b - ε) (b + ε) := by
    intro t ht
    exact ⟨lt_of_lt_of_le hc.2.2.2.1 ht.1, lt_of_le_of_lt ht.2 hb.2⟩
  have hηm : MapsTo η (Icc c b) S := by
    intro t ht
    by_cases htb : t = b
    · subst t
      simpa [hη₀] using mem_of_mem_nhds hS
    · exact (htail ⟨lt_of_lt_of_le hlc ht.1, lt_of_le_of_ne ht.2 htb⟩).2.1
  have heq : EqOn f η (Icc c b) := by
    apply ODE_solution_unique_of_mem_Icc_left
      (v := fun _ => v) (s := fun _ => S) (K := L)
      (fun _ _ => hLip) hfc
    · intro t ht
      by_cases htb : t = b
      · subst t
        exact hfb.mono_of_mem_nhdsWithin (Icc_mem_nhdsLE hcb)
      · exact (hfd t ⟨ht.1, lt_of_le_of_ne ht.2 htb⟩).hasDerivWithinAt
    · intro t ht
      exact hfm (Ioc_subset_Icc_self ht)
    · exact HasDerivAt.continuousOn (fun t ht => hη t (hηc t ht))
    · intro t ht
      exact (hη t (hηc t (Ioc_subset_Icc_self ht))).hasDerivWithinAt
    · intro t ht
      exact hηm (Ioc_subset_Icc_self ht)
    · simpa [f] using hη₀.symm
  refine ⟨ε, hε, η, hη₀, hη, c, ⟨hc.2.2.1.1, hcb⟩, ?_⟩
  intro t ht
  simpa [f, Function.update_of_ne ht.2.ne] using heq (Ioo_subset_Icc_self ht)


end MolecularDynamics
