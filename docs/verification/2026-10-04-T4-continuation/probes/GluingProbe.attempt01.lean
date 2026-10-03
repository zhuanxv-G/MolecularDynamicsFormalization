import MolecularDynamics.Chapter01.LocalExistence
import Mathlib.Topology.Connected.Clopen

open Set Filter
open scoped Topology

namespace MolecularDynamics

theorem probe_glue {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b c d : ℝ} {γ η : ℝ → PhaseSpace n}
    (hcb : c < b) (hbd : b < d)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hη : IsMechanicalSolutionOn m F Q (Ioo c d) η)
    (heq : EqOn γ η (Ioo c b)) :
    ∃ ζ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioo a d) ζ ∧ EqOn ζ γ (Ioo a b) := by
  let ζ : ℝ → PhaseSpace n := fun t => if t < b then γ t else η t
  have hleft (t : ℝ) (ht : t < b) : ζ =ᶠ[𝓝 t] γ := by
    filter_upwards [Iio_mem_nhds ht] with s hs
    simp [ζ, hs]
  have hright (t : ℝ) (ht : c < t) : ζ =ᶠ[𝓝 t] η := by
    filter_upwards [Ioi_mem_nhds ht] with s hs
    dsimp [ζ]
    split_ifs with hsb
    · exact heq ⟨hs, hsb⟩
    · rfl
  refine ⟨ζ, ⟨?_, ?_⟩, ?_⟩
  · intro t ht
    dsimp [ζ]
    split_ifs with htb
    · exact hγ.1 t ⟨ht.1, htb⟩
    · exact hη.1 t ⟨lt_of_lt_of_le hcb (le_of_not_gt htb), ht.2⟩
  · intro t ht
    by_cases htb : t < b
    · have hd := (hγ.2 t ⟨ht.1, htb⟩).hasDerivAt (Ioo_mem_nhds ht.1 htb)
      have hz : ζ t = γ t := by simp [ζ, htb]
      rw [hz]
      exact (hd.congr_of_eventuallyEq (hleft t htb)).hasDerivWithinAt
    · have hct : c < t := lt_of_lt_of_le hcb (le_of_not_gt htb)
      have hd := (hη.2 t ⟨hct, ht.2⟩).hasDerivAt (Ioo_mem_nhds hct ht.2)
      have hz : ζ t = η t := by simp [ζ, htb]
      rw [hz]
      exact (hd.congr_of_eventuallyEq (hright t hct)).hasDerivWithinAt
  · intro t ht
    simp [ζ, ht.2]

theorem probe_unique {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {I : Set ℝ} {γ η : ℝ → PhaseSpace n} {t₀ : ℝ}
    (hI : IsOpen I) (hconn : IsPreconnected I) (ht₀ : t₀ ∈ I)
    (hγ : IsMechanicalSolutionOn m F Q I γ)
    (hη : IsMechanicalSolutionOn m F Q I η)
    (hfield : ∀ t ∈ I, ContDiffAt ℝ 1 (mechanicalVectorField m F) (γ t))
    (hinit : γ t₀ = η t₀) : EqOn γ η I := by
  let S : Set I := {t | γ t = η t}
  have hclosed : IsClosed S := isClosed_eq hγ.continuousOn.restrict hη.continuousOn.restrict
  have hopen : IsOpen S := by
    apply isOpen_iff_mem_nhds.mpr
    intro t ht
    have hevent := mechanicalSolution_eventually_unique_of_contDiffAt
      m F Q I t γ η (γ t) hI t.property hγ hη rfl ht.symm (hfield t t.property)
    exact (continuous_subtype_val.tendsto t).eventually hevent
  letI : PreconnectedSpace I := Subtype.preconnectedSpace hconn
  have hall : S = univ := (show IsClopen S from ⟨hclosed, hopen⟩).eq_univ
    ⟨⟨t₀, ht₀⟩, hinit⟩
  intro t ht
  have hmem : (⟨t, ht⟩ : I) ∈ S := by rw [hall]; trivial
  exact hmem

#print axioms probe_glue
#print axioms probe_unique

end MolecularDynamics
