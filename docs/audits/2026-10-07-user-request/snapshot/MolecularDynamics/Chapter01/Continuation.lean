import MolecularDynamics.Chapter01.LocalExistence
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Normed.Group.Bounded
import Mathlib.Topology.Connected.Clopen

/-!
# Finite endpoint limits and gluing mechanical curves

Supporting dependencies for Leimkuhler--Matthews Theorem 1.1, printed page 32
(PDF page 55). These results do not yet assert maximal or global existence.
The value of the ambient curve at the right endpoint is unrestricted.
-/

open Set Filter
open scoped Topology

namespace MolecularDynamics

/-- A Lipschitz curve into a complete metric space has a limit at a finite
right endpoint. Only the open interval is controlled. -/
theorem exists_rightEndpointLimit_of_lipschitzOnWith
    {E : Type*} [MetricSpace E] [CompleteSpace E]
    {a b : ℝ} {γ : ℝ → E} {K : NNReal}
    (hab : a < b) (hLip : LipschitzOnWith K γ (Ioo a b)) :
    ∃ z, Tendsto γ (𝓝[<] b) (𝓝 z) := by
  apply cauchy_map_iff_exists_tendsto.mp
  have hc : Cauchy (𝓝[<] b) := cauchy_nhds.mono nhdsWithin_le_nhds
  exact hc.map_of_le hLip.uniformContinuousOn
    (le_principal_iff.mpr (Ioo_mem_nhdsLT hab))

/-- If the curve stays in a closed set, its finite endpoint limit stays there. -/
theorem exists_rightEndpointLimit_mem_of_lipschitzOnWith
    {E : Type*} [MetricSpace E] [CompleteSpace E]
    {a b : ℝ} {γ : ℝ → E} {L : NNReal} {K : Set E}
    (hab : a < b) (hLip : LipschitzOnWith L γ (Ioo a b))
    (hK : IsClosed K) (hmem : MapsTo γ (Ioo a b) K) :
    ∃ z ∈ K, Tendsto γ (𝓝[<] b) (𝓝 z) := by
  obtain ⟨z, hz⟩ := exists_rightEndpointLimit_of_lipschitzOnWith hab hLip
  refine ⟨z, hK.mem_of_tendsto hz ?_, hz⟩
  filter_upwards [Ioo_mem_nhdsLT hab] with t ht
  exact hmem ht

/-- A uniform bound on the actual mechanical derivative controls the curve
on its convex open time interval. -/
theorem mechanicalSolution_lipschitzOnWith_of_field_bound
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n} {L : NNReal}
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hbound : ∀ t ∈ Ioo a b, ‖mechanicalVectorField m F (γ t)‖₊ ≤ L) :
    LipschitzOnWith L γ (Ioo a b) := by
  exact (convex_Ioo a b).lipschitzOnWith_of_nnnorm_hasDerivWithin_le hγ.2 hbound

/-- A uniform field bound yields a finite right endpoint limit for a supplied
mechanical solution; it does not require a value or derivative at the endpoint. -/
theorem mechanicalSolution_has_rightEndpointLimit_of_field_bound
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n} {L : NNReal}
    (hab : a < b) (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hbound : ∀ t ∈ Ioo a b, ‖mechanicalVectorField m F (γ t)‖₊ ≤ L) :
    ∃ z, Tendsto γ (𝓝[<] b) (𝓝 z) :=
  exists_rightEndpointLimit_of_lipschitzOnWith hab
    (mechanicalSolution_lipschitzOnWith_of_field_bound hγ hbound)

/-- Compact phase confinement and continuity of the field supply the uniform
derivative bound and keep the endpoint limit inside the same compact set. -/
theorem mechanicalSolution_has_rightEndpointLimit_of_compact
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n}
    {K : Set (PhaseSpace n)}
    (hab : a < b) (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hK : IsCompact K) (hmem : MapsTo γ (Ioo a b) K)
    (hfield : ContinuousOn (mechanicalVectorField m F) K) :
    ∃ z ∈ K, Tendsto γ (𝓝[<] b) (𝓝 z) := by
  obtain ⟨C, hC⟩ := hK.exists_bound_of_continuousOn hfield
  let L : NNReal := ⟨max C 0, le_max_right _ _⟩
  have hbound : ∀ t ∈ Ioo a b, ‖mechanicalVectorField m F (γ t)‖₊ ≤ L := by
    intro t ht
    change ‖mechanicalVectorField m F (γ t)‖ ≤ max C 0
    exact (hC _ (hmem ht)).trans (le_max_left _ _)
  exact exists_rightEndpointLimit_mem_of_lipschitzOnWith hab
    (mechanicalSolution_lipschitzOnWith_of_field_bound hγ hbound) hK.isClosed hmem

/-- Local C¹ uniqueness propagates over a connected open time domain.
The regularity assumption is only along the first curve, not a global
Lipschitz assumption on the whole phase space. -/
theorem mechanicalSolution_unique_on_preconnected_of_contDiffAt
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {I : Set ℝ} {γ η : ℝ → PhaseSpace n} {t₀ : ℝ}
    (hI : IsOpen I) (hconn : IsPreconnected I) (ht₀ : t₀ ∈ I)
    (hγ : IsMechanicalSolutionOn m F Q I γ)
    (hη : IsMechanicalSolutionOn m F Q I η)
    (hfield : ∀ t ∈ I, ContDiffAt ℝ 1 (mechanicalVectorField m F) (γ t))
    (hinit : γ t₀ = η t₀) : EqOn γ η I := by
  let S : Set I := {t | γ t = η t}
  have hclosed : IsClosed S :=
    isClosed_eq hγ.continuousOn.domRestrict hη.continuousOn.domRestrict
  have hopen : IsOpen S := by
    apply isOpen_iff_mem_nhds.mpr
    intro t ht
    have hevent := mechanicalSolution_eventually_unique_of_contDiffAt
      m F Q I t γ η (γ t) hI t.property hγ hη rfl ht.symm (hfield t t.property)
    exact (continuous_subtype_val.tendsto t).eventually hevent
  have : PreconnectedSpace I := Subtype.preconnectedSpace hconn
  have hall : S = univ := (show IsClopen S from ⟨hclosed, hopen⟩).eq_univ
    ⟨⟨t₀, ht₀⟩, hinit⟩
  intro t ht
  have hmem : (⟨t, ht⟩ : I) ∈ S := by rw [hall]; trivial
  exact hmem

/-- Glue two mechanical solutions that agree on an open overlap.
In an extension application one also supplies `b < d`; the gluing proof
itself works even without that extra ordering hypothesis. -/
theorem mechanicalSolution_glue_on_Ioo
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b c d : ℝ} {γ η : ℝ → PhaseSpace n}
    (hcb : c < b)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hη : IsMechanicalSolutionOn m F Q (Ioo c d) η)
    (heq : EqOn γ η (Ioo c b)) :
    ∃ ζ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioo a d) ζ ∧ EqOn ζ γ (Ioo a b) := by
  let ζ : ℝ → PhaseSpace n := fun t => if t < b then γ t else η t
  have hleft (t : ℝ) (ht : t < b) : ζ =ᶠ[𝓝 t] γ := by
    filter_upwards [Iio_mem_nhds ht] with s hs
    have hsb : s < b := hs
    simp [ζ, hsb]
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

end MolecularDynamics
