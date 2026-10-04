import MolecularDynamics.Chapter01.TorusPeriod
import MolecularDynamics.Chapter01.FirstIntegrals
import Mathlib.Analysis.Calculus.ImplicitFunction.ProdDomain

open Set Filter
open scoped Topology
namespace MolecularDynamics

theorem planarScalarPartial_isInvertible (L : (ℝ × ℝ) →L[ℝ] ℝ) (hL : L (0, 1) ≠ 0) :
    (L.comp (ContinuousLinearMap.inr ℝ ℝ ℝ)).IsInvertible := by
  let g : ℝ →L[ℝ] ℝ := (L (0, 1))⁻¹ • ContinuousLinearMap.id ℝ ℝ
  have hrepr : ∀ y : ℝ, (L.comp (ContinuousLinearMap.inr ℝ ℝ ℝ)) y = y * L (0, 1) := by
    intro y
    calc
      _ = L (y • (0, 1)) := by simp
      _ = _ := by rw [map_smul]; rfl
  apply ContinuousLinearMap.IsInvertible.of_inverse (g := g)
  · ext
    rw [ContinuousLinearMap.comp_apply, hrepr]
    simp [g, hL]
  · ext
    rw [ContinuousLinearMap.comp_apply, hrepr]
    simp [g, hL]

theorem exists_planarFirstIntegral_localGraph (J : ℝ × ℝ → ℝ)
    (p : ℝ × ℝ) (L : (ℝ × ℝ) →L[ℝ] ℝ)
    (hJ : HasStrictFDerivAt J L p) (hpartial : L (0, 1) ≠ 0) :
    ∃ ψ : ℝ → ℝ, ψ p.1 = p.2 ∧ DifferentiableAt ℝ ψ p.1 ∧
      (∀ᶠ v in 𝓝 p, J v = J p ↔ ψ v.1 = v.2) ∧
      (∀ᶠ x in 𝓝 p.1, J (x, ψ x) = J p) := by
  have hi := planarScalarPartial_isInvertible L hpartial
  let ψ := hJ.implicitFunctionOfProdDomain hi
  have hgraph : ∀ᶠ v in 𝓝 p, J v = J p ↔ ψ v.1 = v.2 :=
    hJ.eventually_apply_eq_iff_implicitFunctionOfProdDomain hi
  exact ⟨ψ, hgraph.self_of_nhds.mp rfl,
    (hJ.hasStrictFDerivAt_implicitFunctionOfProdDomain hi).hasFDerivAt.differentiableAt,
    hgraph, hJ.eventually_apply_implicitFunctionOfProdDomain hi⟩

theorem planarFirstIntegral_localGraph_reduction (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (L : (ℝ × ℝ) →L[ℝ] ℝ) (hJ : HasStrictFDerivAt J L (γ t₀))
    (hpartial : L (0, 1) ≠ 0) :
    ∃ ψ : ℝ → ℝ, ψ (γ t₀).1 = (γ t₀).2 ∧ DifferentiableAt ℝ ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t) := by
  obtain ⟨ψ, hinit, hdiff, hgraph, _⟩ := exists_planarFirstIntegral_localGraph J (γ t₀) L hJ hpartial
  refine ⟨ψ, hinit, hdiff, hgraph, ?_⟩
  have hpull := (hγ t₀ ht₀).continuousAt.tendsto.eventually hgraph
  filter_upwards [isOpen_Ioo.mem_nhds ht₀, hpull] with t ht hg
  have hlevel : J (γ t) = J (γ t₀) := hfirst a b γ hQ hγ t ht t₀ ht₀
  have hψ : (γ t).2 = ψ (γ t).1 := (hg.mp hlevel).symm
  have hp : γ t = ((γ t).1, ψ (γ t).1) := Prod.ext rfl hψ
  have hd := (hγ t ht).fst
  rw [hp] at hd
  exact ⟨hψ, hd⟩

#print axioms planarScalarPartial_isInvertible
#print axioms exists_planarFirstIntegral_localGraph
#print axioms planarFirstIntegral_localGraph_reduction
end MolecularDynamics
