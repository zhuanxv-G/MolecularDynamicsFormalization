import MolecularDynamics.Chapter01.MomentumBounds
import MolecularDynamics.Chapter01.PotentialBarriers

/-!
# Energy barriers for actual mechanical solutions

Printed page 32 (PDF page 55), dependencies of Theorem 1.1.
Energy conservation is proved from the ODE and the conservative-force relation.
The time interval and the solution are supplied; global existence remains separate.
-/

open Set Metric

namespace MolecularDynamics

/-- A supplied conservative mechanical solution cannot cross a potential barrier
after an initial state of lower energy, on its stated open time interval. -/
theorem mechanicalSolution_below_barrier_stays_in_ball {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b t₀ : ℝ) (γ : ℝ → PhaseSpace n)
    (q₀ : Position n) (r δ : ℝ)
    (hm : ∀ i, 0 < m i)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (ht₀ : t₀ ∈ Ioo a b) (hstart : (γ t₀).1 ∈ ball q₀ r)
    (hbelow : massHamiltonian m U (γ t₀) < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ)
    (t : ℝ) (ht : t ∈ Ioo a b) (htime : t₀ ≤ t) :
    (γ t).1 ∈ ball q₀ r := by
  have hsub : Icc t₀ t ⊆ Ioo a b := by
    intro s hs
    exact ⟨lt_of_lt_of_le ht₀.1 hs.1, lt_of_le_of_lt hs.2 ht.2⟩
  have hcont : ContinuousOn (fun s => (γ s).1) (Icc t₀ t) :=
    (hγ.continuousOn.mono hsub).fst
  have henergy : ∀ s ∈ Icc t₀ t,
      momentumKineticEnergy m (γ s).2 + U (γ s).1 = massHamiltonian m U (γ t₀) := by
    intro s hs
    exact mechanical_energy_const_on_Ioo m F U Q a b γ hm hγ hU hF
      s t₀ (hsub hs) ht₀
  exact conserved_trajectory_below_barrier_stays_in_ball U (momentumKineticEnergy m)
    (fun s => (γ s).1) (fun s => (γ s).2) q₀ t₀ t r δ
    (massHamiltonian m U (γ t₀)) hcont hstart
    (fun s _ => momentumKineticEnergy_nonneg m (γ s).2 hm) henergy
    hbelow hbarrier t ⟨htime, le_rfl⟩

/-- Position confinement and an energy budget below a local potential minimum
give a phase-space bound for an existing solution, in the product maximum metric. -/
theorem mechanicalSolution_phase_dist_lt {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (a b t₀ : ℝ) (γ : ℝ → PhaseSpace n)
    (q₀ : Position n) (M r δ : ℝ)
    (hm : ∀ i, 0 < m i) (hMpos : 0 < M) (hM : ∀ i, m i ≤ M) (hr : 0 < r)
    (hγ : IsMechanicalSolutionOn m F Q (Ioo a b) γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (ht₀ : t₀ ∈ Ioo a b) (hstart : (γ t₀).1 ∈ ball q₀ r)
    (hbelow : massHamiltonian m U (γ t₀) < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ)
    (hmin : ∀ q ∈ ball q₀ r, U q₀ ≤ U q)
    (hbudget : massHamiltonian m U (γ t₀) < U q₀ + r ^ 2 / (2 * M))
    (t : ℝ) (ht : t ∈ Ioo a b) (htime : t₀ ≤ t) :
    dist (γ t) (q₀, (0 : Momentum n)) < r := by
  have hq := mechanicalSolution_below_barrier_stays_in_ball m F U Q a b t₀ γ
    q₀ r δ hm hγ hU hF ht₀ hstart hbelow hbarrier t ht htime
  have henergy := mechanical_energy_const_on_Ioo m F U Q a b γ hm hγ hU hF
    t t₀ ht ht₀
  have hkin : momentumKineticEnergy m (γ t).2 < r ^ 2 / (2 * M) := by
    change momentumKineticEnergy m (γ t).2 + U (γ t).1 = _ at henergy
    linarith [hmin (γ t).1 hq]
  have hp := momentum_norm_lt_of_kineticEnergy m (γ t).2 M r hm hMpos hM hr hkin
  rw [Prod.dist_eq, dist_zero_right]
  exact max_lt (mem_ball.mp hq) hp

end MolecularDynamics
