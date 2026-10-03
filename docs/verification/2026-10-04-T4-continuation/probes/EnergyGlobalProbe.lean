import MolecularDynamics.Chapter01.GlobalContinuation
import MolecularDynamics.Chapter01.MechanicalConfinement

open Set Metric Filter
open scoped Topology

namespace MolecularDynamics

theorem energy_global_probe {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n) (r δ t₀ : ℝ) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hclosedQ : closedBall q₀ r ⊆ Q) (hstart : z₀.1 ∈ ball q₀ r)
    (hbelow : massHamiltonian m U z₀ < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∃ a < t₀, ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ t₀ = z₀ ∧
      ∀ t, t₀ ≤ t → (γ t).1 ∈ ball q₀ r := by
  have hzQ : z₀.1 ∈ Q := hclosedQ (ball_subset_closedBall hstart)
  obtain ⟨ε, γ₀, hlocal⟩ :=
    exists_localMechanicalIVP_open_of_force_contDiffAt m F Q hQ t₀ z₀ hzQ (hreg _ hzQ)
  rcases hlocal with ⟨hε, hinit₀, hγ₀⟩
  let a := t₀ - ε
  let E := massHamiltonian m U z₀
  let K : Set (PhaseSpace n) := {z | z.1 ∈ closedBall q₀ r ∧ massHamiltonian m U z ≤ E}
  have hat : a < t₀ := by dsimp [a]; linarith
  have htb : t₀ < t₀ + ε := by linarith
  have hUc : ContinuousOn U (closedBall q₀ r) :=
    fun q hq => (hU q (hclosedQ hq)).continuousAt.continuousWithinAt
  have hK : IsCompact K := isCompact_phaseEnergySublevel m U (closedBall q₀ r) E
    hm (isCompact_closedBall q₀ r) hUc
  have hKQ : ∀ z ∈ K, z.1 ∈ Q := fun _ hz => hclosedQ hz.1
  have hconfine : ∀ b γ, t₀ < b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ t₀ = z₀ → ∀ t ∈ Ioo a b, t₀ ≤ t → γ t ∈ K := by
    intro b γ htb' hγ hinit t ht htime
    have hstart' : (γ t₀).1 ∈ ball q₀ r := by simpa [hinit] using hstart
    have hbelow' : massHamiltonian m U (γ t₀) < U q₀ + δ := by simpa [hinit] using hbelow
    have hball := mechanicalSolution_below_barrier_stays_in_ball m F U Q a b t₀ γ
      q₀ r δ hm hγ hU hF ⟨hat, htb'⟩ hstart' hbelow' hbarrier t ht htime
    have henergy := mechanical_energy_const_on_Ioo m F U Q a b γ hm hγ hU hF
      t t₀ ht ⟨hat, htb'⟩
    refine ⟨ball_subset_closedBall hball, ?_⟩
    dsimp [E]
    rw [henergy, hinit]
  obtain ⟨γ, hγ, hinit, _⟩ := exists_globalMechanicalSolution_of_local_compact_confinement
    hat htb hQ hreg hγ₀ hinit₀ hK hKQ hconfine
  refine ⟨a, hat, γ, hγ, hinit, ?_⟩
  intro t htime
  have hγ' : IsMechanicalSolutionOn m F Q (Ioo a (t + 1)) γ :=
    hγ.mono fun u hu => hu.1
  have hstart' : (γ t₀).1 ∈ ball q₀ r := by simpa [hinit] using hstart
  have hbelow' : massHamiltonian m U (γ t₀) < U q₀ + δ := by simpa [hinit] using hbelow
  exact mechanicalSolution_below_barrier_stays_in_ball m F U Q a (t + 1) t₀ γ
    q₀ r δ hm hγ' hU hF ⟨hat, by linarith⟩ hstart' hbelow' hbarrier t
    ⟨lt_of_lt_of_le hat htime, by linarith⟩ htime

#print axioms energy_global_probe

end MolecularDynamics
