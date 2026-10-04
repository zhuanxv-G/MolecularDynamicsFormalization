import MolecularDynamics.Chapter01.ScalarIntegrability

open Set Filter
open scoped Topology
namespace MolecularDynamics
noncomputable section

/-- Coordinates (velocity, position), used at a regular turning point. -/
def scalarPotentialSwappedEnergy (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ :=
  scalarPotentialEnergy U (p.2, p.1)

def scalarPotentialSwappedField (U : ℝ → ℝ) (p : ℝ × ℝ) : ℝ × ℝ :=
  (-deriv U p.2, p.1)

theorem scalarPotentialSwappedEnergy_contDiff (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    ContDiff ℝ 1 (scalarPotentialSwappedEnergy U) := by
  have hE := scalarPotentialEnergy_contDiff U hU
  unfold scalarPotentialSwappedEnergy
  fun_prop

theorem scalarPotentialSwappedField_contDiff (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    ContDiff ℝ 1 (scalarPotentialSwappedField U) := by
  have hd : ContDiff ℝ 1 (deriv U) := hU.deriv'
  unfold scalarPotentialSwappedField
  fun_prop

theorem scalarPotentialSwappedEnergy_isFirstIntegral (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U) :
    IsFirstIntegralOn (scalarPotentialSwappedField U) univ (scalarPotentialSwappedEnergy U) := by
  intro a b γ _ hγ s hs t ht
  have hswap : ∀ u ∈ Ioo a b,
      HasDerivAt (fun v => ((γ v).2, (γ v).1))
        (scalarPotentialVectorField U ((γ u).2, (γ u).1)) u :=
    fun u hu => (hγ u hu).snd.prodMk (hγ u hu).fst
  exact scalarPotentialEnergy_isFirstIntegral U hU a b (fun u => ((γ u).2, (γ u).1))
    (fun _ _ => mem_univ _) hswap s hs t ht

theorem scalarPotentialSwappedEnergy_positionPartial (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (p : ℝ × ℝ) : (fderiv ℝ (scalarPotentialSwappedEnergy U) p) (0, 1) = deriv U p.2 := by
  have hj := (scalarPotentialSwappedEnergy_contDiff U hU).differentiable (by norm_num) p
  have hline : HasDerivAt (fun t : ℝ => (p.1, p.2 + t)) (0, 1) 0 :=
    (hasDerivAt_const 0 p.1).prodMk ((hasDerivAt_id 0).const_add p.2)
  have hj' : HasFDerivAt (scalarPotentialSwappedEnergy U)
      (fderiv ℝ (scalarPotentialSwappedEnergy U) p) (p.1, p.2 + (0 : ℝ)) := by
    have hp0 : (p.1, p.2 + (0 : ℝ)) = p := by simp
    rw [hp0]
    exact hj.hasFDerivAt
  have h := hj'.comp_hasDerivAt 0 hline
  have hu := (hU.differentiable (by norm_num) (p.2 + (0 : ℝ))).hasDerivAt.comp 0
    ((hasDerivAt_id (0 : ℝ)).const_add p.2)
  rw [add_zero, mul_one] at hu
  have he := (hasDerivAt_const 0 (p.1 ^ 2 / 2)).add hu
  rw [zero_add] at he
  exact h.unique he

theorem scalarPotential_regularTurning_quadrature (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hforce : deriv U (γ t₀).1 ≠ 0) :
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).2 = (γ t₀).1 ∧ ContDiffAt ℝ 1 ψ (γ t₀).2 ∧
      HasStrictDerivAt g (-deriv U (γ t₀).1) 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).2 = g (t - t₀) ∧ (γ t).1 = ψ (g (t - t₀))) ∧
      (∀ᶠ v in 𝓝 (γ t₀).2,
        g (separableTimePrimitive (fun v => -deriv U (ψ v)) (γ t₀).2 v) = v) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun v => -deriv U (ψ v)) (γ t₀).2 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun v => -deriv U (ψ v)) (γ t₀).2 (γ t).2 = t - t₀) := by
  let η : ℝ → ℝ × ℝ := fun t => ((γ t).2, (γ t).1)
  have hη : ∀ t ∈ Ioo a b, HasDerivAt η (scalarPotentialSwappedField U (η t)) t :=
    fun t ht => (hγ t ht).snd.prodMk (hγ t ht).fst
  have hp : (fderiv ℝ (scalarPotentialSwappedEnergy U) (η t₀)) (0, 1) ≠ 0 := by
    rw [scalarPotentialSwappedEnergy_positionPartial U hU]
    exact hforce
  exact planarFirstIntegral_nonturning_quadrature (scalarPotentialSwappedField U) univ
    (scalarPotentialSwappedEnergy U) a b t₀ η (scalarPotentialSwappedEnergy_isFirstIntegral U hU)
    (fun _ _ => mem_univ _) hη ht₀ (scalarPotentialSwappedEnergy_contDiff U hU).contDiffAt
    (scalarPotentialSwappedField_contDiff U hU).contDiffAt hp (neg_ne_zero.mpr hforce)

theorem scalarPotential_equilibrium_constant (U : ℝ → ℝ) (ξ : ℝ) (hξ : deriv U ξ = 0)
    (t : ℝ) : HasDerivAt (fun _ : ℝ => (ξ, (0 : ℝ)))
      (scalarPotentialVectorField U (ξ, 0)) t := by
  have hz : scalarPotentialVectorField U (ξ, 0) = 0 := by
    ext <;> simp [scalarPotentialVectorField, hξ]
  rw [hz]
  exact hasDerivAt_const t (ξ, 0)

theorem scalarPotential_equilibrium_locally_unique (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv : (γ t₀).2 = 0) (hforce : deriv U (γ t₀).1 = 0) :
    ∀ᶠ t in 𝓝 t₀, γ t = γ t₀ := by
  let p := γ t₀
  obtain ⟨K, S, hS, hLip⟩ := (scalarPotentialVectorField_contDiff U hU).contDiffAt.exists_lipschitzOnWith (x := p)
  let v : ℝ → (ℝ × ℝ) → ℝ × ℝ := fun _ => scalarPotentialVectorField U
  let s : ℝ → Set (ℝ × ℝ) := fun _ => S
  have hL : ∀ᶠ t in 𝓝 t₀, LipschitzOnWith K (v t) (s t) := Eventually.of_forall (fun _ => hLip)
  have hγS : ∀ᶠ t in 𝓝 t₀, γ t ∈ S := (hγ t₀ ht₀).continuousAt.preimage_mem_nhds hS
  have hpS : p ∈ S := mem_of_mem_nhds hS
  have hp : p = (p.1, (0 : ℝ)) := Prod.ext rfl hv
  have hc : ∀ t, HasDerivAt (fun _ : ℝ => p) (scalarPotentialVectorField U p) t := by
    intro t
    rw [hp]
    exact scalarPotential_equilibrium_constant U p.1 hforce t
  have hdγ : ∀ᶠ t in 𝓝 t₀, HasDerivAt γ (v t (γ t)) t ∧ γ t ∈ s t := by
    filter_upwards [isOpen_Ioo.mem_nhds ht₀, hγS] with t ht hts
    exact ⟨hγ t ht, hts⟩
  have hdc : ∀ᶠ t in 𝓝 t₀,
      HasDerivAt (fun _ : ℝ => p) (v t p) t ∧ p ∈ s t :=
    Eventually.of_forall (fun t => ⟨hc t, hpS⟩)
  exact ODE_solution_unique_of_eventually hL hdγ hdc rfl

/-- A stationary initial state stays stationary throughout any connected solution interval. -/
theorem scalarPotential_equilibrium_on_Ioo (U : ℝ → ℝ) (hU : ContDiff ℝ 2 U)
    (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (scalarPotentialVectorField U (γ t)) t)
    (ht₀ : t₀ ∈ Ioo a b) (hv : (γ t₀).2 = 0) (hforce : deriv U (γ t₀).1 = 0) :
    ∀ t ∈ Ioo a b, γ t = γ t₀ := by
  let S : Set ℝ := {t | t ∈ Ioo a b ∧ γ t = γ t₀}
  have hS : IsOpen S := by
    rw [isOpen_iff_mem_nhds]
    intro t ht
    have hv' : (γ t).2 = 0 := by rw [ht.2]; exact hv
    have hf' : deriv U (γ t).1 = 0 := by rw [ht.2]; exact hforce
    have heq := scalarPotential_equilibrium_locally_unique U hU a b t γ hγ ht.1 hv' hf'
    filter_upwards [isOpen_Ioo.mem_nhds ht.1, heq] with u hu he
    exact ⟨hu, he.trans ht.2⟩
  have hclosure : closure S ∩ Ioo a b ⊆ S := by
    intro t ht
    refine ⟨ht.2, ?_⟩
    by_contra hne
    have hn := (hγ t ht.2).continuousAt.eventually_ne hne
    obtain ⟨u, hune, huS⟩ := mem_closure_iff_nhds.mp ht.1 {u | γ u ≠ γ t₀} hn
    exact hune huS.2
  have hsub : Ioo a b ⊆ S := isPreconnected_Ioo.subset_of_closure_inter_subset hS
    ⟨t₀, ht₀, ht₀, rfl⟩ hclosure
  exact fun t ht => (hsub ht).2
end
end MolecularDynamics
#print axioms MolecularDynamics.scalarPotentialSwappedEnergy_contDiff
#print axioms MolecularDynamics.scalarPotentialSwappedField_contDiff
#print axioms MolecularDynamics.scalarPotentialSwappedEnergy_isFirstIntegral
#print axioms MolecularDynamics.scalarPotentialSwappedEnergy_positionPartial
#print axioms MolecularDynamics.scalarPotential_regularTurning_quadrature
#print axioms MolecularDynamics.scalarPotential_equilibrium_constant
#print axioms MolecularDynamics.scalarPotential_equilibrium_locally_unique

#print axioms MolecularDynamics.scalarPotential_equilibrium_on_Ioo
