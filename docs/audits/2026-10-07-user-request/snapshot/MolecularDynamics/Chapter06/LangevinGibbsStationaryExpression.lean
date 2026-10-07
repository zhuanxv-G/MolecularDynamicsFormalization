import MolecularDynamics.Chapter06.LangevinC0ConservedObservable

/-! The original unit-mass Langevin classical forward expression and Gibbs weight.
These pointwise differential identities do not assert probabilistic invariance. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty BigOperators

namespace MolecularDynamics
noncomputable section

/-- The genuine coordinate divergence on the original real phase space. -/
def textbookLangevinPhaseDivergence {N : ℕ}
    (V : textbookLangevinPhase N → textbookLangevinPhase N) (z : textbookLangevinPhase N) : ℝ :=
  (∑ i : Fin N, deriv (fun t : ℝ ↦ (V (z + t • ((Pi.single i 1 : Fin N → ℝ), 0))).1 i) 0) +
    ∑ i : Fin N, deriv (fun t : ℝ ↦ (V (z + t • ((0 : Fin N → ℝ), Pi.single i 1))).2 i) 0

/-- The original mechanical drift has actual divergence -gamma times N,
computed from the true phase coordinates rather than supplied as a premise. -/
theorem textbookLangevinDrift_divergence {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ : ℝ) (z : textbookLangevinPhase N) :
    textbookLangevinPhaseDivergence (textbookLangevinDrift U γ) z = -γ * (N : ℝ) := by
  have hq (i : Fin N) : (fun t : ℝ ↦
      (textbookLangevinDrift U γ (z + t • ((Pi.single i 1 : Fin N → ℝ), 0))).1 i) =
      (fun _ : ℝ ↦ z.2 i) := by
    funext t
    simp [textbookLangevinDrift]
  have hp (i : Fin N) : (fun t : ℝ ↦
      (textbookLangevinDrift U γ (z + t • ((0 : Fin N → ℝ), Pi.single i 1))).2 i) =
      (fun t : ℝ ↦ textbookPotentialForce U z.1 i - γ * (z.2 i + t)) := by
    funext t
    simp [textbookLangevinDrift, mul_add]
  have hd (i : Fin N) : HasDerivAt
      (fun t : ℝ ↦ textbookPotentialForce U z.1 i - γ * (z.2 i + t)) (-γ) 0 := by
    simpa only [id_eq, Pi.sub_apply, mul_one, zero_sub] using!
      (hasDerivAt_const (0 : ℝ) (textbookPotentialForce U z.1 i)).sub
        (((hasDerivAt_id 0).const_add (z.2 i)).const_mul γ)
  unfold textbookLangevinPhaseDivergence
  simp_rw [hq, hp, deriv_const, fun i ↦ (hd i).deriv]
  simp only [Finset.sum_const_zero, zero_add, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  ring

/-- The classical forward differential expression -b dot grad f -(div b)f
plus the original sigma-squared-over-two momentum diffusion. A functional
adjoint domain or transition-density equation is not part of this definition. -/
def textbookLangevinForwardDifferentialOperator {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (γ σ : ℝ) (f : textbookLangevinPhase N → ℝ)
    (z : textbookLangevinPhase N) : ℝ :=
  -deriv (fun t : ℝ ↦ f (z + t • textbookLangevinDrift U γ z)) 0 -
    textbookLangevinPhaseDivergence (textbookLangevinDrift U γ) z * f z +
    σ ^ 2 / 2 * ∑ i : Fin N,
      deriv (deriv (fun t : ℝ ↦ f (z + t • ((0 : Fin N → ℝ), Pi.single i 1)))) 0

/-- The actual unnormalized Gibbs weight of the original mechanical H. -/
def textbookLangevinGibbsWeight {N : ℕ} (U : (Fin N → ℝ) → ℝ) (β : ℝ)
    (z : textbookLangevinPhase N) : ℝ :=
  Real.exp (-β * textbookLangevinHamiltonian U z)

/-- Smoothness of the same true Gibbs weight follows from the original U. -/
theorem textbookLangevinGibbsWeight_contDiff {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookLangevinGibbsWeight U β) := by
  have hH : ContDiff ℝ ∞ (textbookLangevinHamiltonian U) := by
    have hh := textbookLangevinHamiltonianPower_contDiff U hU 1
    change ContDiff ℝ ∞ (fun z ↦ textbookLangevinHamiltonian U z ^ 1) at hh
    simpa only [pow_one] using! hh
  exact (contDiff_const.mul hH).exp

private theorem gibbs_quadratic_hasDerivAt (H p t : ℝ) :
    HasDerivAt (fun s : ℝ ↦ H + p * s + s ^ 2 / 2) (p + t) t := by
  convert! ((hasDerivAt_const t H).add ((hasDerivAt_id t).const_mul p)).add
    (((hasDerivAt_id t).pow 2).div_const 2) using 1
  simp only [id_eq]
  ring

/-- The actual momentum-direction Gibbs curve has its true Gaussian first
derivative at every real shift, with no smoothness or moment premise. -/
theorem textbookLangevinGibbsWeight_momentum_hasDerivAt {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (z : textbookLangevinPhase N) (i : Fin N) (t : ℝ) :
    HasDerivAt (fun s : ℝ ↦ textbookLangevinGibbsWeight U β
      (z + s • ((0 : Fin N → ℝ), Pi.single i 1)))
      (-β * (z.2 i + t) * textbookLangevinGibbsWeight U β
        (z + t • ((0 : Fin N → ℝ), Pi.single i 1))) t := by
  have he : (fun s : ℝ ↦ textbookLangevinGibbsWeight U β
      (z + s • ((0 : Fin N → ℝ), Pi.single i 1))) =
      (fun s : ℝ ↦ Real.exp (-β * (textbookLangevinHamiltonian U z + z.2 i * s + s ^ 2 / 2))) := by
    funext s
    rw [textbookLangevinGibbsWeight, textbookLangevinHamiltonian_momentum_shift]
  rw [he]
  convert! ((gibbs_quadratic_hasDerivAt (textbookLangevinHamiltonian U z) (z.2 i) t).const_mul (-β)).exp using 1
  simp only [textbookLangevinGibbsWeight, textbookLangevinHamiltonian_momentum_shift]
  ring

/-- The exact original momentum second derivative, including its negative
beta term, is derived from the true shifted Gaussian curve. -/
theorem textbookLangevinGibbsWeight_momentum_second {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (z : textbookLangevinPhase N) (i : Fin N) :
    deriv (deriv (fun t : ℝ ↦ textbookLangevinGibbsWeight U β
      (z + t • ((0 : Fin N → ℝ), Pi.single i 1)))) 0 =
      (β ^ 2 * z.2 i ^ 2 - β) * textbookLangevinGibbsWeight U β z := by
  have he : deriv (fun t : ℝ ↦ textbookLangevinGibbsWeight U β
      (z + t • ((0 : Fin N → ℝ), Pi.single i 1))) =
      (fun t : ℝ ↦ -β * (z.2 i + t) * textbookLangevinGibbsWeight U β
        (z + t • ((0 : Fin N → ℝ), Pi.single i 1))) :=
    funext (fun t ↦ (textbookLangevinGibbsWeight_momentum_hasDerivAt U β z i t).deriv)
  rw [he]
  have hd := (((hasDerivAt_id (0 : ℝ)).const_add (z.2 i)).const_mul (-β)).mul
    (textbookLangevinGibbsWeight_momentum_hasDerivAt U β z i 0)
  convert! hd.deriv using 1
  simp only [zero_smul, add_zero, mul_one, id_eq]
  ring

/-- The true mechanical Hamiltonian dissipation gives the same Gibbs drift
derivative, without assuming stationarity or the target forward identity. -/
theorem textbookLangevinGibbsWeight_drift_hasDerivAt {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U) (β γ : ℝ) (z : textbookLangevinPhase N) :
    HasDerivAt (fun t : ℝ ↦ textbookLangevinGibbsWeight U β
      (z + t • textbookLangevinDrift U γ z))
      (γ * β * (∑ i : Fin N, z.2 i ^ 2) * textbookLangevinGibbsWeight U β z) 0 := by
  convert! ((textbookLangevinHamiltonian_drift_hasDerivAt U hU γ z).const_mul (-β)).exp using 1
  simp only [zero_smul, add_zero, textbookLangevinGibbsWeight]
  ring

/-- Fluctuation-dissipation cancels the exact computed classical forward
expression on the original Gibbs weight, including dimension zero. -/
theorem textbookLangevinForwardDifferentialOperator_gibbs_eq_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U) (β γ σ : ℝ) (hβ : 0 < β)
    (hσ : σ ^ 2 = 2 * γ / β) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ σ (textbookLangevinGibbsWeight U β) z = 0 := by
  unfold textbookLangevinForwardDifferentialOperator
  rw [(textbookLangevinGibbsWeight_drift_hasDerivAt U hU β γ z).deriv,
    textbookLangevinDrift_divergence, hσ]
  simp_rw [textbookLangevinGibbsWeight_momentum_second]
  have hs : (∑ i : Fin N, (β ^ 2 * z.2 i ^ 2 - β) * textbookLangevinGibbsWeight U β z) =
      (β ^ 2 * (∑ i : Fin N, z.2 i ^ 2) - (N : ℝ) * β) *
        textbookLangevinGibbsWeight U β z := by
    rw [← Finset.sum_mul, Finset.sum_sub_distrib, ← Finset.mul_sum]
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [hs]
  field_simp [(ne_of_gt hβ)]
  ring

/-- The original positive-temperature physical noise supplies the needed
coefficient relation by the real square-root theorem, rather than assuming
the Gibbs differential equation. -/
theorem textbookLangevinForwardDifferentialOperator_physical_gibbs_eq_zero {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (textbookLangevinGibbsWeight U β) z = 0 := by
  apply textbookLangevinForwardDifferentialOperator_gibbs_eq_zero U hU β γ _ hβ _ z
  simpa only [div_eq_mul_inv] using
    Real.sq_sqrt (mul_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hγ.le) (inv_nonneg.mpr hβ.le))

/-- The same mechanical Gibbs weight on the original periodic phase space. -/
def textbookLangevinPeriodicGibbsWeight {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (β : ℝ) (x : textbookLangevinPeriodicPhase N) : ℝ :=
  Real.exp (-β * textbookLangevinPeriodicHamiltonianPower U 1 x)

/-- Original potential periodicity gives exactly the same real Gibbs weight
at every representative, without assuming representative continuity. -/
theorem textbookLangevinPeriodicGibbsWeight_lift {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential U) (β : ℝ)
    (z : textbookLangevinPhase N) :
    textbookLangevinPeriodicGibbsWeight U β (textbookLangevinPeriodicProjection z) =
      textbookLangevinGibbsWeight U β z := by
  unfold textbookLangevinPeriodicGibbsWeight textbookLangevinGibbsWeight
  rw [textbookLangevinPeriodicHamiltonianPower_lift U hp 1 z]
  simp only [textbookLangevinHamiltonianPower, pow_one]


end
end MolecularDynamics
