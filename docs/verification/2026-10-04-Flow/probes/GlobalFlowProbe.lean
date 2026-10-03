import MolecularDynamics.Chapter01.TimeReversal

open Set Metric
open scoped Topology

namespace MolecularDynamics

theorem mechanicalSolution_translate_on_univ {n : ℕ} {m : CoordinateMasses n}
    {F : Force n} {Q : Set (Position n)} {γ : ℝ → PhaseSpace n}
    (hγ : IsMechanicalSolutionOn m F Q univ γ) (s : ℝ) :
    IsMechanicalSolutionOn m F Q univ (fun t => γ (t + s)) := by
  refine ⟨fun t _ => hγ.1 (t + s) (mem_univ _), ?_⟩
  intro t ht
  have hder := (hγ.2 (t + s) (mem_univ _)).hasDerivAt (by simp)
  have hshift : HasDerivAt (fun u : ℝ => u + s) 1 t := (hasDerivAt_id t).add_const s
  simpa only [Function.comp_def, one_smul] using (hder.scomp t hshift).hasDerivWithinAt

theorem mechanicalSolution_energy_on_univ {n : ℕ} (m : CoordinateMasses n)
    (F : Force n) (U : PotentialEnergy n) (Q : Set (Position n))
    (γ : ℝ → PhaseSpace n) (hm : ∀ i, 0 < m i)
    (hγ : IsMechanicalSolutionOn m F Q univ γ)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q) (t : ℝ) :
    massHamiltonian m U (γ t) = massHamiltonian m U (γ 0) := by
  have hγ' : IsMechanicalSolutionOn m F Q (Ioo (min t 0 - 1) (max t 0 + 1)) γ :=
    hγ.mono (subset_univ _)
  apply mechanical_energy_const_on_Ioo m F U Q (min t 0 - 1) (max t 0 + 1) γ hm hγ' hU hF
  · exact ⟨by linarith [min_le_left t 0], by linarith [le_max_left t 0]⟩
  · exact ⟨by linarith [min_le_right t 0], by linarith [le_max_right t 0]⟩

def IsGlobalMechanicalFlowOn {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n) : Prop :=
  (∀ z ∈ S, IsMechanicalSolutionOn m F Q univ (fun t => ψ t z) ∧ ψ 0 z = z) ∧
  ∀ t, MapsTo (ψ t) S S

theorem globalMechanicalFlow_add {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) (s t : ℝ) :
    ψ (t + s) z = ψ t (ψ s z) := by
  have hγ := (hψ.1 z hz).1
  have hη := (hψ.1 (ψ s z) (hψ.2 s hz)).1
  have htrans := mechanicalSolution_translate_on_univ hγ s
  have heq : EqOn (fun u => ψ (u + s) z) (fun u => ψ u (ψ s z)) univ :=
    mechanicalSolution_unique_on_preconnected_of_contDiffAt isOpen_univ isPreconnected_univ
      (mem_univ (0 : ℝ)) htrans hη
      (fun u hu => mechanicalVectorField_contDiffAt m F (ψ (u + s) z)
        (hreg _ (htrans.1 u hu))) (by simpa using (hψ.1 (ψ s z) (hψ.2 s hz)).2.symm)
  exact heq (mem_univ t)

theorem globalMechanicalFlow_inverse {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) (t : ℝ) : ψ (-t) (ψ t z) = z := by
  rw [← globalMechanicalFlow_add hψ hreg hz t (-t), neg_add_cancel, (hψ.1 z hz).2]

theorem globalMechanicalFlow_commute {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) (s t : ℝ) :
    ψ t (ψ s z) = ψ s (ψ t z) := by
  rw [← globalMechanicalFlow_add hψ hreg hz s t,
    ← globalMechanicalFlow_add hψ hreg hz t s, add_comm]

theorem globalMechanicalFlow_bijOn {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q) (t : ℝ) : BijOn (ψ t) S S := by
  refine ⟨hψ.2 t, ?_, ?_⟩
  · intro x hx y hy hxy
    have heq := congrArg (ψ (-t)) hxy
    simpa only [globalMechanicalFlow_inverse hψ hreg hx t,
      globalMechanicalFlow_inverse hψ hreg hy t] using heq
  · intro z hz
    refine ⟨ψ (-t) z, hψ.2 (-t) hz, ?_⟩
    simpa only [neg_neg] using globalMechanicalFlow_inverse hψ hreg hz (-t)

theorem globalMechanicalFlow_energy {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n} (U : PotentialEnergy n)
    (hψ : IsGlobalMechanicalFlowOn m F Q S ψ) (hm : ∀ i, 0 < m i)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    {z : PhaseSpace n} (hz : z ∈ S) (t : ℝ) :
    massHamiltonian m U (ψ t z) = massHamiltonian m U z := by
  have heq := mechanicalSolution_energy_on_univ m F U Q (fun u => ψ u z) hm
    (hψ.1 z hz).1 hU hF t
  simpa only [(hψ.1 z hz).2] using heq

theorem exists_globalMechanicalFlow_of_energy_barrier {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n) (r δ : ℝ)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hclosedQ : closedBall q₀ r ⊆ Q)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∃ ψ : ℝ → PhaseSpace n → PhaseSpace n,
      IsGlobalMechanicalFlowOn m F Q
        {z | z.1 ∈ ball q₀ r ∧ massHamiltonian m U z < U q₀ + δ} ψ := by
  classical
  let S : Set (PhaseSpace n) := {z | z.1 ∈ ball q₀ r ∧ massHamiltonian m U z < U q₀ + δ}
  have hex : ∀ z : S, ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = (z : PhaseSpace n) ∧ ∀ t, γ t ∈ S := by
    intro z
    obtain ⟨γ, hγ, hinit, hpos⟩ :=
      exists_globalMechanicalIVP_of_energy_barrier_two_sided m F U Q q₀ r δ z
        hm hQ hU hF hreg hclosedQ z.property.1 z.property.2 hbarrier
    refine ⟨γ, hγ, hinit, ?_⟩
    intro t
    refine ⟨hpos t, ?_⟩
    have heq := mechanicalSolution_energy_on_univ m F U Q γ hm hγ hU hF t
    rw [heq, hinit]
    exact z.property.2
  choose f hf hinit hmem using hex
  let ψ : ℝ → PhaseSpace n → PhaseSpace n :=
    fun t z => if hz : z ∈ S then f ⟨z, hz⟩ t else z
  have hψ : ∀ z (hz : z ∈ S) t, ψ t z = f ⟨z, hz⟩ t := by
    intro z hz t
    exact dite_eq_left hz
  refine ⟨ψ, ?_, ?_⟩
  · intro z hz
    constructor
    · have heq : (fun t => ψ t z) = f ⟨z, hz⟩ := funext (hψ z hz)
      rw [heq]
      exact hf ⟨z, hz⟩
    · rw [hψ z hz]
      exact hinit ⟨z, hz⟩
  · intro t z hz
    rw [hψ z hz]
    exact hmem ⟨z, hz⟩ t

#print axioms mechanicalSolution_translate_on_univ
#print axioms mechanicalSolution_energy_on_univ
#print axioms globalMechanicalFlow_add
#print axioms globalMechanicalFlow_inverse
#print axioms globalMechanicalFlow_commute
#print axioms globalMechanicalFlow_bijOn
#print axioms globalMechanicalFlow_energy
#print axioms exists_globalMechanicalFlow_of_energy_barrier

end MolecularDynamics
