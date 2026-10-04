import MolecularDynamics.Chapter01.FirstIntegralQuadrature
import Mathlib.Analysis.Calculus.ContDiff.Deriv

open Set Filter
open scoped Topology
namespace MolecularDynamics
noncomputable section

/-- Unit-mass scalar mechanical energy, printed20/PDF43 and28/PDF51. -/
def scalarPotentialEnergy (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ := p.2 ^ 2 / 2 + U p.1

def scalarPotentialVectorField (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ × ℝ :=
  (p.2, -deriv U p.1)

theorem scalarPotentialEnergy_contDiff (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    ContDiff ℝ 1 (scalarPotentialEnergy U) := by
  have hU' : ContDiff ℝ 1 U := hU.of_le (by norm_num)
  unfold scalarPotentialEnergy
  fun_prop

theorem scalarPotentialVectorField_contDiff (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    ContDiff ℝ 1 (scalarPotentialVectorField U) := by
  have hd : ContDiff ℝ 1 (deriv U) := hU.deriv'
  unfold scalarPotentialVectorField
  fun_prop

theorem scalarPotentialEnergy_hasDerivAt_zero (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (γ : ℝ → ℝ × ℝ) (t : ℝ)
    (hγ : HasDerivAt γ (scalarPotentialVectorField U (γ t)) t) :
    HasDerivAt (fun u => scalarPotentialEnergy U (γ u)) 0 t := by
  have hx : HasDerivAt (fun u => (γ u).1) (γ t).2 t := hγ.fst
  have hv : HasDerivAt (fun u => (γ u).2) (-deriv U (γ t).1) t := hγ.snd
  have hu := (hU.differentiable (by norm_num) (γ t).1).hasDerivAt.comp t hx
  have he := ((hv.pow 2).div_const 2).add hu
  have hc : (↑(2 : ℕ) : ℝ) * (γ t).2 ^ (2 - 1) * (-deriv U (γ t).1) / 2 +
      deriv U (γ t).1 * (γ t).2 = 0 := by ring
  rw [hc] at he
  exact he

theorem scalarPotentialEnergy_isFirstIntegral (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    IsFirstIntegralOn (scalarPotentialVectorField U) univ (scalarPotentialEnergy U) := by
  intro a b γ _ hγ s hs t ht
  have hd : ∀ u ∈ Ioo a b, HasDerivAt (fun v => scalarPotentialEnergy U (γ v)) 0 u :=
    fun u hu => scalarPotentialEnergy_hasDerivAt_zero U hU γ u (hγ u hu)
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).deriv) hs ht

theorem scalarPotentialEnergy_velocityPartial (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (p : ℝ × ℝ) : (fderiv ℝ (scalarPotentialEnergy U) p) (0, 1) = p.2 := by
  have hj := (scalarPotentialEnergy_contDiff U hU).differentiable (by norm_num) p
  have hline : HasDerivAt (fun t : ℝ => (p.1, p.2 + t)) (0, 1) 0 :=
    (hasDerivAt_const 0 p.1).prodMk ((hasDerivAt_id 0).const_add p.2)
  have hj' : HasFDerivAt (scalarPotentialEnergy U) (fderiv ℝ (scalarPotentialEnergy U) p)
      (p.1, p.2 + (0 : ℝ)) := by
    have hp0 : (p.1, p.2 + (0 : ℝ)) = p := by simp
    rw [hp0]
    exact hj.hasFDerivAt
  have h := hj'.comp_hasDerivAt 0 hline
  have henergy := ((((hasDerivAt_id (0 : ℝ)).const_add p.2).pow 2).div_const 2).add
    (hasDerivAt_const 0 (U p.1))
  have hc : (↑(2 : ℕ) : ℝ) * (p.2 + (0 : ℝ)) ^ (2 - 1) * 1 / 2 + 0 = p.2 := by ring
  dsimp only [id] at henergy
  rw [hc] at henergy
  have hh := h.unique henergy
  simpa only [add_zero] using hh

theorem scalarPotential_nonturning_quadrature (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv₀ : (γ t₀).2 ≠ 0) :
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (γ t₀).2 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1, g (separableTimePrimitive ψ (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive ψ (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive ψ (γ t₀).1 (γ t).1 = t - t₀) := by
  have hp : (fderiv ℝ (scalarPotentialEnergy U) (γ t₀)) (0, 1) ≠ 0 := by
    rw [scalarPotentialEnergy_velocityPartial U hU]
    exact hv₀
  exact planarFirstIntegral_nonturning_quadrature (scalarPotentialVectorField U) univ
    (scalarPotentialEnergy U) a b t₀ γ (scalarPotentialEnergy_isFirstIntegral U hU)
    (fun _ _ => mem_univ _) hγ ht₀ (scalarPotentialEnergy_contDiff U hU).contDiffAt
    (scalarPotentialVectorField_contDiff U hU).contDiffAt hp hv₀

end
end MolecularDynamics
#print axioms MolecularDynamics.scalarPotentialEnergy_contDiff
#print axioms MolecularDynamics.scalarPotentialVectorField_contDiff
#print axioms MolecularDynamics.scalarPotentialEnergy_hasDerivAt_zero
#print axioms MolecularDynamics.scalarPotentialEnergy_isFirstIntegral
#print axioms MolecularDynamics.scalarPotentialEnergy_velocityPartial
#print axioms MolecularDynamics.scalarPotential_nonturning_quadrature
