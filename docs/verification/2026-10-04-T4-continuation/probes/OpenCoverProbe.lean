import Mathlib.Analysis.ODE.Basic

open Set Filter
open scoped Topology

theorem exists_glued_function_probe {α E ι : Type*} (s : ι → Set α)
    (f : ι → α → E) (z₀ : E) (hcompat : ∀ i j, EqOn (f i) (f j) (s i ∩ s j)) :
    ∃ γ : α → E, ∀ i, EqOn γ (f i) (s i) := by
  classical
  refine ⟨fun x => if h : ∃ i, x ∈ s i then f (Classical.choose h) x else z₀, ?_⟩
  intro i x hx
  have hcover : ∃ j, x ∈ s j := ⟨i, hx⟩
  dsimp only
  rw [dif_pos hcover]
  exact hcompat (Classical.choose hcover) i ⟨Classical.choose_spec hcover, hx⟩

#print axioms exists_glued_function_probe
