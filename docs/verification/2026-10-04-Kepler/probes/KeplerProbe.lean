import MolecularDynamics.Chapter01.PlanarAngularMomentum

open Set
namespace MolecularDynamics
noncomputable def keplerPotential {n : ℕ} (q : Position n) : ℝ := -‖q‖⁻¹
noncomputable def keplerForce {n : ℕ} (q : Position n) : Position n :=
  (-(‖q‖ ^ 3)⁻¹) • q

theorem hasGradientAt_keplerPotential {n : ℕ} (q : Position n) (hq : q ≠ 0) :
    HasGradientAt keplerPotential ((‖q‖ ^ 3)⁻¹ • q) q := by
  have hn : ‖q‖ ≠ 0 := norm_ne_zero_iff.mpr hq
  have hs := ((hasFDerivAt_id q).norm_sq).sqrt (pow_ne_zero 2 hn)
  simp only [id_eq, Real.sqrt_sq_eq_abs, abs_norm] at hs
  have hu := ((hasDerivAt_inv hn).comp_hasFDerivAt q hs).neg
  have heq : -(-(‖q‖ ^ 2)⁻¹ • ((1 / (2 * ‖q‖)) •
      (2 • (innerSL ℝ q).comp (ContinuousLinearMap.id ℝ (Position n))))) =
      InnerProductSpace.toDual ℝ (Position n) ((‖q‖ ^ 3)⁻¹ • q) := by
    ext u
    simp only [neg_apply, smul_apply,
      ContinuousLinearMap.comp_apply, ContinuousLinearMap.id_apply,
      InnerProductSpace.toDual_apply_apply, inner_smul_left, innerSL_apply_apply,
      conj_trivial, smul_eq_mul]
    field_simp [hn]
    ring
  rw [heq] at hu
  exact hasGradientAt_iff_hasFDerivAt.mpr hu

theorem keplerForce_eq_neg_gradient {n : ℕ} (q : Position n) (hq : q ≠ 0) :
    keplerForce q = -gradient keplerPotential q := by
  rw [(hasGradientAt_keplerPotential q hq).gradient]
  simp [keplerForce, neg_smul]

theorem keplerForce_contDiffAt {n : ℕ} (q : Position n) (hq : q ≠ 0) :
    ContDiffAt ℝ 1 keplerForce q := by
  have hn : ‖q‖ ≠ 0 := norm_ne_zero_iff.mpr hq
  exact (((contDiffAt_norm ℝ hq).pow 3).inv (pow_ne_zero 3 hn)).neg.smul contDiffAt_id


theorem exists_kepler_localIVP {n : ℕ} (t₀ : ℝ) (z₀ : PhaseSpace n) (hq : z₀.1 ≠ 0) :
    ∃ ε γ, IsLocalMechanicalIVP (fun _ => (1 : ℝ)) keplerForce
      {q : Position n | q ≠ 0} t₀ z₀ ε γ := by
  have hQ : IsOpen {q : Position n | q ≠ 0} :=
    (isClosed_eq continuous_id continuous_const).isOpen_compl
  exact exists_localMechanicalIVP_open_of_force_contDiffAt
    (fun _ => (1 : ℝ)) keplerForce _ hQ t₀ z₀ hq (keplerForce_contDiffAt z₀.1 hq)

theorem kepler_energy_const_on_Ioo {n : ℕ} (a b : ℝ) (γ : ℝ → PhaseSpace n)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position n | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ s) =
      massHamiltonian (fun _ => (1 : ℝ)) keplerPotential (γ t) := by
  exact mechanical_energy_const_on_Ioo _ keplerForce keplerPotential _ a b γ
    (fun _ => by norm_num) hγ
    (fun q hq => (hasGradientAt_keplerPotential q hq).differentiableAt)
    (fun q hq => keplerForce_eq_neg_gradient q hq) s t hs ht

theorem kepler_planarAngularMomentum_const_on_Ioo (a b : ℝ) (γ : ℝ → PhaseSpace 2)
    (hγ : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) γ)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) :
    planarAngularMomentum (γ s) = planarAngularMomentum (γ t) :=
  centralForce_planarAngularMomentum_const (fun q => -(‖q‖ ^ 3)⁻¹) _ a b γ hγ s t hs ht

#print axioms exists_kepler_localIVP
#print axioms kepler_energy_const_on_Ioo
#print axioms kepler_planarAngularMomentum_const_on_Ioo
#print axioms hasGradientAt_keplerPotential
#print axioms keplerForce_eq_neg_gradient
#print axioms keplerForce_contDiffAt
end MolecularDynamics
