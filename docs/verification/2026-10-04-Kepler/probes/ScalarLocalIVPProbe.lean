import MolecularDynamics.Chapter01.ScalarTurning

open Set Filter
open scoped Topology
namespace MolecularDynamics

/-- Both actual coordinates, a strict local time-integral inverse, and its inverse identities. -/
def HasScalarQuadratureRepresentation (r s : ℝ → ℝ)
    (W : (ℝ → ℝ) → ℝ → ℝ) (w₀ a b t₀ : ℝ) : Prop :=
  ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
    ψ (r t₀) = s t₀ ∧ ContDiffAt ℝ 1 ψ (r t₀) ∧ HasStrictDerivAt g w₀ 0 ∧
    (∀ᶠ t in 𝓝 t₀, r t = g (t - t₀) ∧ s t = ψ (g (t - t₀))) ∧
    (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive (W ψ) (r t₀) x) = x) ∧
    (∀ᶠ y in 𝓝 0, separableTimePrimitive (W ψ) (r t₀) (g y) = y) ∧
    (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
      separableTimePrimitive (W ψ) (r t₀) (r t) = t - t₀)

/-- Disjoint exhaustive local alternatives for a genuine scalar potential trajectory. -/
def ScalarPotentialLocalDescription (U : ℝ → ℝ) (γ : ℝ → ℝ × ℝ)
    (a b t₀ : ℝ) : Prop :=
  ((γ t₀).2 ≠ 0 ∧ HasScalarQuadratureRepresentation
    (fun t => (γ t).1) (fun t => (γ t).2) (fun ψ => ψ) (γ t₀).2 a b t₀) ∨
  ((γ t₀).2 = 0 ∧ deriv U (γ t₀).1 ≠ 0 ∧ HasScalarQuadratureRepresentation
    (fun t => (γ t).2) (fun t => (γ t).1) (fun ψ v => -deriv U (ψ v))
    (-deriv U (γ t₀).1) a b t₀) ∨
  ((γ t₀).2 = 0 ∧ deriv U (γ t₀).1 = 0 ∧ ∀ t ∈ Ioo a b, γ t = γ t₀)

theorem scalarPotential_localDescription (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) : ScalarPotentialLocalDescription U γ a b t₀ := by
  by_cases hv : (γ t₀).2 = 0
  · by_cases hf : deriv U (γ t₀).1 = 0
    · exact Or.inr (Or.inr ⟨hv, hf, scalarPotential_equilibrium_on_Ioo U hU a b t₀ γ hγ ht₀ hv hf⟩)
    · exact Or.inr (Or.inl ⟨hv, hf, scalarPotential_regularTurning_quadrature U hU a b t₀ γ hγ ht₀ hf⟩)
  · exact Or.inl ⟨hv, scalarPotential_nonturning_quadrature U hU a b t₀ γ hγ ht₀ hv⟩

theorem scalarPotential_exists_localIVP (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (z₀ : ℝ × ℝ) (t₀ : ℝ) :
    ∃ (ε : ℝ) (γ : ℝ → ℝ × ℝ), 0 < ε ∧ γ t₀ = z₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), HasDerivAt γ (scalarPotentialVectorField U (γ t)) t) := by
  obtain ⟨γ, hinit, ε, hε, hder⟩ :=
    ((scalarPotentialVectorField_contDiff U hU).contDiffAt (x := z₀)).exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀ t₀
  exact ⟨ε, γ, hε, hinit, hder⟩

/-- Actual arbitrary initial-data IVP together with its derived energy and exhaustive local solution. -/
theorem scalarPotential_exists_localIVP_integrable (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (z₀ : ℝ × ℝ) (t₀ : ℝ) :
    ∃ (ε : ℝ) (γ : ℝ → ℝ × ℝ), 0 < ε ∧ γ t₀ = z₀ ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), HasDerivAt γ (scalarPotentialVectorField U (γ t)) t) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), scalarPotentialEnergy U (γ t) = scalarPotentialEnergy U z₀) ∧
      ScalarPotentialLocalDescription U γ (t₀ - ε) (t₀ + ε) t₀ := by
  obtain ⟨ε, γ, hε, hinit, hder⟩ := scalarPotential_exists_localIVP U hU z₀ t₀
  have ht₀ : t₀ ∈ Ioo (t₀ - ε) (t₀ + ε) := by constructor <;> linarith
  refine ⟨ε, γ, hε, hinit, hder, ?_, scalarPotential_localDescription U hU _ _ t₀ γ hder ht₀⟩
  intro t ht
  have he := scalarPotentialEnergy_isFirstIntegral U hU _ _ γ (fun _ _ => mem_univ _) hder t ht t₀ ht₀
  rw [hinit] at he
  exact he

end MolecularDynamics
#print axioms MolecularDynamics.scalarPotential_localDescription
#print axioms MolecularDynamics.scalarPotential_exists_localIVP
#print axioms MolecularDynamics.scalarPotential_exists_localIVP_integrable
