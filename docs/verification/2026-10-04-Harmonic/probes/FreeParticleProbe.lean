import MolecularDynamics.Chapter01.HarmonicOscillator

open Set
namespace MolecularDynamics
local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def freeParticleFlow {n : ℕ} (m : CoordinateMasses n)
    (t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (z.1 + t • velocityOperator m z.2, z.2)

@[simp] theorem freeParticleFlow_zero {n : ℕ} (m : CoordinateMasses n)
    (z : PhaseSpace n) : freeParticleFlow m 0 z = z := by simp [freeParticleFlow]

theorem freeParticleFlow_isMechanicalSolution {n : ℕ} (m : CoordinateMasses n)
    (z : PhaseSpace n) :
    IsMechanicalSolutionOn m (fun _ => 0) univ univ (fun t => freeParticleFlow m t z) := by
  rw [isMechanicalSolutionOn_iff_components _ _ _ _ _ isOpen_univ]
  refine ⟨fun _ _ => mem_univ _, ?_⟩
  intro t ht
  have hq := ((hasDerivAt_id t).smul_const (velocityOperator m z.2)).const_add z.1
  rw [one_smul] at hq
  exact ⟨hq,
    hasDerivAt_const t z.2⟩

theorem freeParticleFlow_isGlobalFlow {n : ℕ} (m : CoordinateMasses n) :
    IsGlobalMechanicalFlowOn m (fun _ => 0) univ univ (freeParticleFlow m) := by
  exact ⟨fun z _ => ⟨freeParticleFlow_isMechanicalSolution m z,
    freeParticleFlow_zero m z⟩, fun t z _ => mem_univ _⟩

theorem freeParticleFlow_continuous {n : ℕ} (m : CoordinateMasses n) :
    Continuous (fun x : ℝ × PhaseSpace n => freeParticleFlow m x.1 x.2) := by
  unfold freeParticleFlow
  fun_prop

theorem freeParticleFlow_add {n : ℕ} (m : CoordinateMasses n)
    (z : PhaseSpace n) (s t : ℝ) :
    freeParticleFlow m (t + s) z = freeParticleFlow m t (freeParticleFlow m s z) := by
  exact globalMechanicalFlow_add (freeParticleFlow_isGlobalFlow m)
    (fun q _ => contDiffAt_const) (mem_univ z) s t

noncomputable def freeParticleContinuousFlow {n : ℕ} (m : CoordinateMasses n) :
    Flow ℝ (PhaseSpace n) where
  toFun := freeParticleFlow m
  cont' := freeParticleFlow_continuous m
  map_add' t s z := freeParticleFlow_add m z s t
  map_zero' := freeParticleFlow_zero m

theorem freeParticleFlow_energy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (hU : ∀ q, U q = 0) (z : PhaseSpace n) (t : ℝ) :
    massHamiltonian m U (freeParticleFlow m t z) = massHamiltonian m U z := by
  simp [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian, freeParticleFlow, hU]

#print axioms freeParticleFlow_isMechanicalSolution
#print axioms freeParticleFlow_isGlobalFlow
#print axioms freeParticleFlow_continuous
#print axioms freeParticleFlow_add
#print axioms freeParticleContinuousFlow
#print axioms freeParticleFlow_energy
end MolecularDynamics
