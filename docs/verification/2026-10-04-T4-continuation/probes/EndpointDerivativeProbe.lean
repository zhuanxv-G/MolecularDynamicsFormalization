import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Tactic.Abel

open Set Filter MeasureTheory
open scoped Topology

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

theorem endpoint_derivative_probe {a b : ℝ} {f f' : ℝ → E}
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

#print axioms endpoint_derivative_probe
