import MolecularDynamics.Chapter01.KeplerReconstruction
import Mathlib.Analysis.Calculus.InverseFunctionTheorem.Deriv

/-! Printed28--30/PDF51--53: genuine scalar separated quadrature.
Continuous nonzero speed on an open position interval gives a true
antiderivative, differentiable local inverse and actual solution formula. -/

open Set Filter
open scoped Topology
namespace MolecularDynamics

noncomputable def separableTimePrimitive (w : ℝ → ℝ) (x₀ x : ℝ) : ℝ :=
  ∫ u in x₀..x, 1 / w u

theorem separableTimePrimitive_initial (w : ℝ → ℝ) (x₀ : ℝ) :
    separableTimePrimitive w x₀ x₀ = 0 := by simp [separableTimePrimitive]

theorem separableTimePrimitive_hasStrictDerivAt (w : ℝ → ℝ) (A B x₀ : ℝ)
    (hw : ContinuousOn w (Ioo A B)) (hn : ∀ x ∈ Ioo A B, w x ≠ 0)
    (hx₀ : x₀ ∈ Ioo A B) (x : ℝ) (hx : x ∈ Ioo A B) :
    HasStrictDerivAt (separableTimePrimitive w x₀) (1 / w x) x := by
  have hc : ContinuousOn (fun u => 1 / w u) (Ioo A B) := continuousOn_const.div hw hn
  have hseg : uIcc x₀ x ⊆ Ioo A B := ordConnected_Ioo.uIcc_subset hx₀ hx
  exact intervalIntegral.integral_hasStrictDerivAt_right
    ((hc.mono hseg).intervalIntegrable) (hc.stronglyMeasurableAtFilter isOpen_Ioo x hx)
    ((hc x hx).continuousAt (isOpen_Ioo.mem_nhds hx))

theorem separableTimePrimitive_localInverse (w : ℝ → ℝ) (A B x₀ : ℝ)
    (hw : ContinuousOn w (Ioo A B)) (hn : ∀ x ∈ Ioo A B, w x ≠ 0)
    (hx₀ : x₀ ∈ Ioo A B) :
    ∃ g : ℝ → ℝ,
      (∀ᶠ x in 𝓝 x₀, g (separableTimePrimitive w x₀ x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive w x₀ (g y) = y) ∧
      HasStrictDerivAt g (w x₀) 0 := by
  have hd := separableTimePrimitive_hasStrictDerivAt w A B x₀ hw hn hx₀ x₀ hx₀
  have hn' : 1 / w x₀ ≠ 0 := one_div_ne_zero (hn x₀ hx₀)
  let g := hd.localInverse (separableTimePrimitive w x₀) (1 / w x₀) x₀ hn'
  have hl : ∀ᶠ x in 𝓝 x₀, g (separableTimePrimitive w x₀ x) = x :=
    hd.eventually_left_inverse hn'
  have hr : ∀ᶠ y in 𝓝 (separableTimePrimitive w x₀ x₀),
      separableTimePrimitive w x₀ (g y) = y := hd.eventually_right_inverse hn'
  rw [separableTimePrimitive_initial] at hr
  have hg : HasStrictDerivAt g (1 / w x₀)⁻¹ 0 := by
    rw [← separableTimePrimitive_initial w x₀]
    exact hd.to_localInverse hn'
  have hcoeff : (1 / w x₀)⁻¹ = w x₀ := by simp
  rw [hcoeff] at hg
  exact ⟨g, hl, hr, hg⟩

theorem separableTimePrimitive_along_solution (w : ℝ → ℝ) (A B x₀ a b t₀ : ℝ)
    (hw : ContinuousOn w (Ioo A B)) (hn : ∀ x ∈ Ioo A B, w x ≠ 0)
    (hx₀ : x₀ ∈ Ioo A B) (r : ℝ → ℝ)
    (h : ∀ t ∈ Ioo a b, r t ∈ Ioo A B ∧ HasDerivAt r (w (r t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hinit : r t₀ = x₀) (t : ℝ) (ht : t ∈ Ioo a b) :
    separableTimePrimitive w x₀ (r t) = t - t₀ := by
  have hd : ∀ u ∈ Ioo a b,
      HasDerivAt (fun u => separableTimePrimitive w x₀ (r u) - u) 0 u := by
    intro u hu
    have hg := (separableTimePrimitive_hasStrictDerivAt w A B x₀ hw hn hx₀
      (r u) (h u hu).1).hasDerivAt.comp u (h u hu).2
    have heq : (1 / w (r u)) * w (r u) = 1 := by field_simp [hn _ (h u hu).1]
    rw [heq] at hg
    have hd := hg.sub (hasDerivAt_id u)
    rw [sub_self] at hd
    exact hd
  have hc := isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).deriv) ht₀ ht
  rw [hinit, separableTimePrimitive_initial] at hc
  linarith

theorem separableTimePrimitive_inverse_along_solution (w : ℝ → ℝ) (A B x₀ a b t₀ : ℝ)
    (hw : ContinuousOn w (Ioo A B)) (hn : ∀ x ∈ Ioo A B, w x ≠ 0)
    (hx₀ : x₀ ∈ Ioo A B) (r : ℝ → ℝ)
    (h : ∀ t ∈ Ioo a b, r t ∈ Ioo A B ∧ HasDerivAt r (w (r t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hinit : r t₀ = x₀) :
    ∃ g : ℝ → ℝ,
      (∀ᶠ x in 𝓝 x₀, g (separableTimePrimitive w x₀ x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive w x₀ (g y) = y) ∧
      HasStrictDerivAt g (w x₀) 0 ∧
      (∀ᶠ t in 𝓝 t₀, g (t - t₀) = r t) := by
  obtain ⟨g, hl, hr, hg⟩ := separableTimePrimitive_localInverse w A B x₀ hw hn hx₀
  refine ⟨g, hl, hr, hg, ?_⟩
  have hrt : Tendsto r (𝓝 t₀) (𝓝 x₀) := by
    rw [← hinit]
    exact (h t₀ ht₀).2.continuousAt.tendsto
  filter_upwards [hrt.eventually hl, isOpen_Ioo.mem_nhds ht₀] with t hg ht
  rw [separableTimePrimitive_along_solution w A B x₀ a b t₀ hw hn hx₀ r h ht₀ hinit t ht] at hg
  exact hg

end MolecularDynamics
