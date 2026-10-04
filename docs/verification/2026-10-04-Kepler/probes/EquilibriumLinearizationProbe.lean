import MolecularDynamics.Chapter01.LinearFlow
import MolecularDynamics.Chapter01.PotentialRegularity
import MolecularDynamics.Chapter01.Equilibrium

open Set Filter Asymptotics
open scoped Topology
namespace MolecularDynamics
noncomputable section
section Banach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- The exact nonlinear remainder after subtracting the derivative at a stationary state. -/
def equilibriumLinearizationRemainder (f : E → E) (z₀ : E) (A : E →L[ℝ] E) (h : E) : E :=
  f (z₀ + h) - A h

theorem equilibrium_constant_ode_iff (f : E → E) (z₀ : E) (t : ℝ) :
    HasDerivAt (fun _ : ℝ => z₀) (f z₀) t ↔ f z₀ = 0 := by
  constructor
  · intro h
    exact h.unique (hasDerivAt_const t z₀)
  · intro h
    rw [h]
    exact hasDerivAt_const t z₀

theorem equilibriumLinearizationRemainder_isLittleO (f : E → E) (z₀ : E)
    (A : E →L[ℝ] E) (hF : HasFDerivAt f A z₀) (heq : f z₀ = 0) :
    (equilibriumLinearizationRemainder f z₀ A) =o[𝓝 0] (fun h : E => h) := by
  have h := hasFDerivAt_iff_isLittleO_nhds_zero.mp hF
  change (fun h : E => f (z₀ + h) - A h) =o[𝓝 0] (fun h : E => h)
  simpa only [heq, sub_zero] using h

theorem equilibriumLinearizationRemainder_of_C1 (f : E → E) (z₀ : E)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0) :
    (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h) := by
  exact equilibriumLinearizationRemainder_isLittleO f z₀ (fderiv ℝ f z₀)
    (hF.differentiableAt (by norm_num)).hasFDerivAt heq

theorem actual_perturbation_ode (f : E → E) (z₀ : E) (A : E →L[ℝ] E)
    (γ : ℝ → E) (t : ℝ) (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => γ u - z₀)
      (A (γ t - z₀) + equilibriumLinearizationRemainder f z₀ A (γ t - z₀)) t := by
  have h := hγ.sub_const z₀
  have hc : A (γ t - z₀) + equilibriumLinearizationRemainder f z₀ A (γ t - z₀) = f (γ t) := by
    simp [equilibriumLinearizationRemainder]
  rw [← hc] at h
  exact h

variable [CompleteSpace E]
theorem equilibrium_linearized_IVP (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0) :
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h) := by
  refine ⟨fun t => linearExponentialFlow (fderiv ℝ f z₀) (t - t₀) h₀,
    linearExponentialFlow_initial_time _ _ _,
    fun t => hasDerivAt_linearExponentialFlow_initial_time _ _ _ t,
    equilibriumLinearizationRemainder_of_C1 f z₀ hF heq⟩
end Banach

/-- The actual block derivative (dq,dp) ↦ (M⁻¹ dp, DF dq). -/
def mechanicalLinearization {n : ℕ} (m : CoordinateMasses n)
    (DF : Position n →L[ℝ] Momentum n) : PhaseSpace n →L[ℝ] PhaseSpace n :=
  ((velocityOperator m).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
    (DF.comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n)))

theorem mechanicalLinearization_apply {n : ℕ} (m : CoordinateMasses n)
    (DF : Position n →L[ℝ] Momentum n) (h : PhaseSpace n) :
    mechanicalLinearization m DF h = (velocityOperator m h.2, DF h.1) := rfl

theorem hasFDerivAt_mechanicalVectorField {n : ℕ} (m : CoordinateMasses n)
    (F : Force n) (z₀ : PhaseSpace n) (DF : Position n →L[ℝ] Momentum n)
    (hF : HasFDerivAt F DF z₀.1) :
    HasFDerivAt (mechanicalVectorField m F) (mechanicalLinearization m DF) z₀ := by
  exact ((velocityOperator m).hasFDerivAt.comp z₀
    (ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt).prodMk
    (hF.comp z₀ (ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt)

theorem conservative_mechanical_linearization {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z₀ : PhaseSpace n) (hU : ContDiffAt ℝ 2 U z₀.1) :
    HasFDerivAt (mechanicalVectorField m (fun q => -gradient U q))
      (mechanicalLinearization m (-fderiv ℝ (gradient U) z₀.1)) z₀ := by
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  exact hasFDerivAt_mechanicalVectorField m _ z₀ _ hg.hasFDerivAt.neg

end
end MolecularDynamics
#print axioms MolecularDynamics.equilibrium_constant_ode_iff
#print axioms MolecularDynamics.equilibriumLinearizationRemainder_isLittleO
#print axioms MolecularDynamics.equilibriumLinearizationRemainder_of_C1
#print axioms MolecularDynamics.actual_perturbation_ode
#print axioms MolecularDynamics.equilibrium_linearized_IVP
#print axioms MolecularDynamics.mechanicalLinearization_apply
#print axioms MolecularDynamics.hasFDerivAt_mechanicalVectorField
#print axioms MolecularDynamics.conservative_mechanical_linearization
