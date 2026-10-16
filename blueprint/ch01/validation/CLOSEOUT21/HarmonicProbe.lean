import MolecularDynamics.Chapter01.HarmonicOscillator
open MolecularDynamics Set
noncomputable section
def harmonicEnergy21 {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) : ℝ :=
  ‖z.2‖^2 / 2 + Ω^2 * ‖z.1‖^2 / 2
theorem harmonicEnergy21_eq {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) :
    harmonicEnergy21 Ω z = massHamiltonian (fun _ : Fin n => (1 : ℝ))
      (harmonicPotential Ω) z := by
  simp [harmonicEnergy21, massHamiltonian, massSeparableEnergy,
    SeparableEnergy.hamiltonian, momentumKineticEnergy, harmonicPotential,
    nBodyKineticEnergy, EuclideanSpace.real_norm_sq_eq, Finset.sum_div,
    Finset.mul_sum, mul_div_assoc]
theorem harmonic_unique21 {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n)
    (γ : ℝ → PhaseSpace n)
    (hγ : IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω^2)) • q) univ univ γ) (hinit : γ 0 = z) (t : ℝ) :
    γ t = harmonicFlow Ω t z := by
  have heq := mechanicalSolution_unique_on_preconnected_of_contDiffAt
    isOpen_univ isPreconnected_univ (mem_univ (0 : ℝ)) hγ
    (harmonicFlow_isMechanicalSolution Ω hΩ z)
    (fun s _ => mechanicalVectorField_contDiffAt _ _ (γ s) (by fun_prop))
    (by simpa using hinit)
  exact heq (mem_univ t)
#print axioms harmonicEnergy21_eq
#print axioms harmonic_unique21
