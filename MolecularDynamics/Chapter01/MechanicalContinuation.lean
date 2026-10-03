import MolecularDynamics.Chapter01.Continuation
import MolecularDynamics.Chapter01.ODEEndpoint

/-!
# Finite right endpoint continuation of mechanical solutions

Supporting Theorem 1.1, printed page 32 (PDF page 55). A limit in an open
position domain and a C¹ field there give an actual extension. Compact
phase confinement supplies the limit. No overlap equality is assumed.
-/

open Set Filter
open scoped Topology

namespace MolecularDynamics

/-- A finite endpoint limit in the position domain, with C¹ field there,
gives a mechanical solution extending beyond the endpoint. -/
theorem mechanicalSolution_extend_of_rightEndpointLimit
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n} {z : PhaseSpace n}
    (hab : a < b) (hQ : IsOpen Q)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hz : Tendsto γ (𝓝[<] b) (𝓝 z)) (hzQ : z.1 ∈ Q)
    (hfield : ContDiffAt ℝ 1 (mechanicalVectorField m F) z) :
    ∃ δ > 0, ∃ ζ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioo a (b + δ)) ζ ∧ EqOn ζ γ (Ioo a b) := by
  obtain ⟨ε, hε, η, hη₀, hη, c, hc, heq⟩ :=
    exists_localODE_matching_rightEndpoint hab
      (fun t ht => (hγ.2 t ht).hasDerivAt (isOpen_Ioo.mem_nhds ht)) hz hfield
  have hb : b ∈ Ioo (b - ε) (b + ε) := by constructor <;> linarith
  have hcont : ContinuousAt (fun t => (η t).1) b := (hη b hb).continuousAt.fst
  obtain ⟨ρ, hρ, hsub⟩ := Metric.mem_nhds_iff.mp
    (hcont.preimage_mem_nhds (hQ.mem_nhds (by simpa [hη₀] using hzQ)))
  let δ := min ε ρ
  have hδ : 0 < δ := lt_min hε hρ
  have hηQ : IsMechanicalSolutionOn m F Q (Ioo (b - δ) (b + δ)) η := by
    constructor
    · intro t ht
      apply hsub
      rw [Real.ball_eq_Ioo]
      dsimp [δ] at ht
      rcases ht with ⟨htl, htr⟩
      constructor <;> linarith [min_le_right ε ρ]
    · intro t ht
      apply (hη t ?_).hasDerivWithinAt
      dsimp [δ] at ht
      rcases ht with ⟨htl, htr⟩
      constructor <;> linarith [min_le_left ε ρ]
  let c' := max c (b - δ / 2)
  have hc'b : c' < b := max_lt hc.2 (by linarith)
  have hcδ : b - δ < c' := by
    dsimp [c']
    linarith [le_max_right c (b - δ / 2)]
  have heq' : EqOn γ η (Ioo c' b) := by
    intro t ht
    apply heq
    exact ⟨lt_of_le_of_lt (le_max_left _ _) ht.1, ht.2⟩
  have hη' : IsMechanicalSolutionOn m F Q (Ioo c' (b + δ)) η :=
    hηQ.mono (Ioo_subset_Ioo hcδ.le le_rfl)
  obtain ⟨ζ, hζ, hagree⟩ := mechanicalSolution_glue_on_Ioo hc'b hγ hη' heq'
  exact ⟨δ, hδ, ζ, hζ, hagree⟩

/-- A continuously differentiable force at the endpoint position provides
the field regularity needed for finite endpoint continuation. -/
theorem mechanicalSolution_extend_of_force_contDiffAt
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n} {z : PhaseSpace n}
    (hab : a < b) (hQ : IsOpen Q)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hz : Tendsto γ (𝓝[<] b) (𝓝 z)) (hzQ : z.1 ∈ Q)
    (hF : ContDiffAt ℝ 1 F z.1) :
    ∃ δ > 0, ∃ ζ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioo a (b + δ)) ζ ∧ EqOn ζ γ (Ioo a b) :=
  mechanicalSolution_extend_of_rightEndpointLimit hab hQ hγ hz hzQ
    (mechanicalVectorField_contDiffAt m F z hF)

/-- Compact phase confinement inside an open position domain prevents
a supplied mechanical solution from terminating at a finite right endpoint. -/
theorem mechanicalSolution_extend_of_compact
    {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n}
    {K : Set (PhaseSpace n)}
    (hab : a < b) (hQ : IsOpen Q)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hK : IsCompact K) (hmem : MapsTo γ (Ioo a b) K)
    (hKQ : ∀ z ∈ K, z.1 ∈ Q)
    (hF : ∀ z ∈ K, ContDiffAt ℝ 1 F z.1) :
    ∃ δ > 0, ∃ ζ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioo a (b + δ)) ζ ∧ EqOn ζ γ (Ioo a b) := by
  have hfield : ContinuousOn (mechanicalVectorField m F) K := by
    intro z hz
    exact (mechanicalVectorField_contDiffAt m F z (hF z hz)).continuousAt.continuousWithinAt
  obtain ⟨z, hzK, hz⟩ := mechanicalSolution_has_rightEndpointLimit_of_compact
    hab hγ hK hmem hfield
  exact mechanicalSolution_extend_of_force_contDiffAt hab hQ hγ hz (hKQ z hzK) (hF z hzK)

end MolecularDynamics
