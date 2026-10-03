import MolecularDynamics.Chapter01.GlobalFlow
import MolecularDynamics.Chapter01.Lagrangian

/-! Explicit unit-mass harmonic oscillator: printed page 27, PDF page 50.
The ODE and flow laws require nonzero scalar frequency. Joint continuity
constructs a genuine mathlib Flow; general initial-state continuity is separate. -/


open Set
open scoped Topology

namespace MolecularDynamics

local instance (n : ℕ) : ContinuousSMul ℝ (Position n) := by
  have : IsBoundedSMul ℝ (Position n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def harmonicFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω * t) • z.1 + (Real.sin (Ω * t) / Ω) • z.2,
    (-Ω * Real.sin (Ω * t)) • z.1 + Real.cos (Ω * t) • z.2)

@[simp] theorem harmonicFlow_zero {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) :
    harmonicFlow Ω 0 z = z := by simp [harmonicFlow]

theorem velocityOperator_unit {n : ℕ} (p : Momentum n) :
    velocityOperator (fun _ : Fin n => (1 : ℝ)) p = p := by
  ext i
  rw [velocityOperator_coordinate _ (fun _ => by norm_num)]
  simp

theorem harmonicFlow_isMechanicalSolution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0)
    (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω ^ 2)) • q) univ univ (fun t => harmonicFlow Ω t z) := by
  rw [isMechanicalSolutionOn_iff_components _ _ _ _ _ isOpen_univ]
  refine ⟨fun _ _ => mem_univ _, ?_⟩
  intro t ht
  have hscale : HasDerivAt (fun u : ℝ => Ω * u) Ω t := by
    simpa using (hasDerivAt_id t).const_mul Ω
  have hc := (Real.hasDerivAt_cos (Ω * t)).comp t hscale
  have hs := (Real.hasDerivAt_sin (Ω * t)).comp t hscale
  have hsdiv : HasDerivAt (fun u => Real.sin (Ω * u) / Ω) (Real.cos (Ω * t)) t := by
    simpa [hΩ] using hs.div_const Ω
  have hq := (hc.smul_const z.1).add (hsdiv.smul_const z.2)
  have hcoef : -Real.sin (Ω * t) * Ω = -Ω * Real.sin (Ω * t) := by ring
  have hq' : HasDerivAt (fun u => (harmonicFlow Ω u z).1) (harmonicFlow Ω t z).2 t := by
    rw [hcoef] at hq
    exact hq
  have hp := ((hs.const_mul (-Ω)).smul_const z.1).add (hc.smul_const z.2)
  have heq : (-Ω * (Real.cos (Ω * t) * Ω)) • z.1 +
      (-Real.sin (Ω * t) * Ω) • z.2 = (-(Ω ^ 2)) • (harmonicFlow Ω t z).1 := by
    ext i
    simp only [harmonicFlow, PiLp.add_apply, PiLp.smul_apply, smul_eq_mul]
    field_simp [hΩ]
    ring
  have hp' : HasDerivAt (fun u => (harmonicFlow Ω u z).2)
      ((-(Ω ^ 2)) • (harmonicFlow Ω t z).1) t := by
    rw [heq] at hp
    exact hp
  refine ⟨?_, hp'⟩
  rw [velocityOperator_unit]
  exact hq'

theorem harmonicFlow_isGlobalFlow {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) :
    IsGlobalMechanicalFlowOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω ^ 2)) • q) univ univ (harmonicFlow Ω) := by
  constructor
  · intro z hz
    exact ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z⟩
  · intro t z hz
    exact mem_univ _

theorem harmonicFlow_continuous {n : ℕ} (Ω : ℝ) :
    Continuous (fun x : ℝ × PhaseSpace n => harmonicFlow Ω x.1 x.2) := by
  unfold harmonicFlow
  fun_prop

theorem harmonicFlow_add {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0)
    (z : PhaseSpace n) (s t : ℝ) :
    harmonicFlow Ω (t + s) z = harmonicFlow Ω t (harmonicFlow Ω s z) := by
  exact globalMechanicalFlow_add (harmonicFlow_isGlobalFlow Ω hΩ)
    (fun q hq => by fun_prop) (mem_univ z) s t

theorem harmonicFlow_inverse {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0)
    (z : PhaseSpace n) (t : ℝ) :
    harmonicFlow Ω (-t) (harmonicFlow Ω t z) = z := by
  exact globalMechanicalFlow_inverse (harmonicFlow_isGlobalFlow Ω hΩ)
    (fun q hq => by fun_prop) (mem_univ z) t

noncomputable def harmonicContinuousFlow {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) :
    Flow ℝ (PhaseSpace n) where
  toFun := harmonicFlow Ω
  cont' := harmonicFlow_continuous Ω
  map_add' t s z := harmonicFlow_add Ω hΩ z s t
  map_zero' := harmonicFlow_zero Ω

noncomputable def harmonicPotential {n : ℕ} (Ω : ℝ) : PotentialEnergy n :=
  nBodyKineticEnergy (fun _ => Ω ^ 2)

theorem hasGradientAt_harmonicPotential {n : ℕ} (Ω : ℝ) (q : Position n) :
    HasGradientAt (harmonicPotential Ω) ((Ω ^ 2) • q) q := by
  have heq : massOperator (fun _ : Fin n => Ω ^ 2) q = (Ω ^ 2) • q := by
    ext i
    rw [massOperator_coordinate]
    rfl
  rw [← heq]
  exact hasGradientAt_nBodyKineticEnergy (fun _ => Ω ^ 2) q

theorem harmonicFlow_energy {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0)
    (z : PhaseSpace n) (t : ℝ) :
    massHamiltonian (fun _ : Fin n => (1 : ℝ)) (harmonicPotential Ω)
      (harmonicFlow Ω t z) =
    massHamiltonian (fun _ : Fin n => (1 : ℝ)) (harmonicPotential Ω) z := by
  exact globalMechanicalFlow_energy (harmonicPotential Ω) (harmonicFlow_isGlobalFlow Ω hΩ)
    (fun _ => by norm_num)
    (fun q _ => (hasGradientAt_harmonicPotential Ω q).differentiableAt)
    (fun q _ => by rw [(hasGradientAt_harmonicPotential Ω q).gradient, neg_smul])
    (mem_univ z) t


end MolecularDynamics
