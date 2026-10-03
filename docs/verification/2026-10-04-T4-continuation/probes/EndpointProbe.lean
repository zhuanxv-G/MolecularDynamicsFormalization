import MolecularDynamics.Chapter01.LocalExistence
import Mathlib.Analysis.Calculus.MeanValue

open Set Filter
open scoped Topology

namespace MolecularDynamics

theorem probe_endpoint {E : Type*} [MetricSpace E] [CompleteSpace E]
    {a b : ℝ} {γ : ℝ → E} {K : NNReal}
    (hab : a < b) (hLip : LipschitzOnWith K γ (Ioo a b)) :
    ∃ z, Tendsto γ (𝓝[<] b) (𝓝 z) := by
  apply cauchy_map_iff_exists_tendsto.mp
  have hc : Cauchy (𝓝[<] b) := cauchy_nhds.mono nhdsWithin_le_nhds
  exact hc.map_of_le hLip.uniformContinuousOn
    (le_principal_iff.mpr (Ioo_mem_nhdsLT hab))

theorem probe_bound {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {a b : ℝ} {γ : ℝ → PhaseSpace n} {K : NNReal}
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hbound : ∀ t ∈ Ioo a b, ‖mechanicalVectorField m F (γ t)‖₊ ≤ K) :
    LipschitzOnWith K γ (Ioo a b) := by
  exact (convex_Ioo a b).lipschitzOnWith_of_nnnorm_hasDerivWithin_le hγ.2 hbound

#print axioms probe_endpoint
#print axioms probe_bound

end MolecularDynamics
