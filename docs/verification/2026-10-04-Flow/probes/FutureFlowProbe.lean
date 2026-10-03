import MolecularDynamics.Chapter01.EnergyGlobalExistence

open Set Filter
open scoped Topology

namespace MolecularDynamics

theorem mechanicalSolution_translate_on_Ioi {n : ℕ} {m : CoordinateMasses n}
    {F : Force n} {Q : Set (Position n)} {a : ℝ} {γ : ℝ → PhaseSpace n}
    (hγ : IsMechanicalSolutionOn m F Q (Ioi a) γ) (s : ℝ) :
    IsMechanicalSolutionOn m F Q (Ioi (a - s)) (fun t => γ (t + s)) := by
  refine ⟨?_, ?_⟩
  · intro t ht
    exact hγ.1 (t + s) (by change a < t + s; change a - s < t at ht; linarith)
  · intro t ht
    have htime : t + s ∈ Ioi a := by change a < t + s; change a - s < t at ht; linarith
    have hder := (hγ.2 (t + s) htime).hasDerivAt (isOpen_Ioi.mem_nhds htime)
    have hshift : HasDerivAt (fun u : ℝ => u + s) 1 t := (hasDerivAt_id t).add_const s
    simpa only [Function.comp_def, one_smul] using (hder.scomp t hshift).hasDerivWithinAt

def IsFutureMechanicalFlowOn {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (S : Set (PhaseSpace n))
    (ψ : ℝ → PhaseSpace n → PhaseSpace n) : Prop :=
  (∀ z ∈ S, ∃ a < (0 : ℝ),
    IsMechanicalSolutionOn m F Q (Ioi a) (fun t => ψ t z) ∧ ψ 0 z = z) ∧
  ∀ t, 0 ≤ t → MapsTo (ψ t) S S

theorem futureMechanicalFlow_add {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsFutureMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) {s t : ℝ} (hs : 0 ≤ s) (ht : 0 ≤ t) :
    ψ (t + s) z = ψ t (ψ s z) := by
  obtain ⟨a, ha, hγ, hinit⟩ := hψ.1 z hz
  obtain ⟨b, hb, hη, hinitη⟩ := hψ.1 (ψ s z) (hψ.2 s hs hz)
  have htrans := mechanicalSolution_translate_on_Ioi hγ s
  let c := max (a - s) b
  have hc : c < 0 := max_lt (by linarith) hb
  have hγ' : IsMechanicalSolutionOn m F Q (Ioi c) (fun u => ψ (u + s) z) :=
    htrans.mono (Ioi_subset_Ioi (le_max_left _ _))
  have hη' : IsMechanicalSolutionOn m F Q (Ioi c) (fun u => ψ u (ψ s z)) :=
    hη.mono (Ioi_subset_Ioi (le_max_right _ _))
  have heq : EqOn (fun u => ψ (u + s) z) (fun u => ψ u (ψ s z)) (Ioi c) :=
    mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_Ioi isPreconnected_Ioi hc hγ' hη'
      (fun u hu => mechanicalVectorField_contDiffAt m F (ψ (u + s) z)
        (hreg _ (hγ'.1 u hu))) (by simpa using hinitη.symm)
  exact heq (lt_of_lt_of_le hc ht)

theorem futureMechanicalFlow_commute {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsFutureMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    {z : PhaseSpace n} (hz : z ∈ S) {s t : ℝ} (hs : 0 ≤ s) (ht : 0 ≤ t) :
    ψ t (ψ s z) = ψ s (ψ t z) := by
  rw [← futureMechanicalFlow_add hψ hreg hz hs ht,
    ← futureMechanicalFlow_add hψ hreg hz ht hs, add_comm]

theorem futureMechanicalFlow_energy {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n} (U : PotentialEnergy n)
    (hψ : IsFutureMechanicalFlowOn m F Q S ψ) (hm : ∀ i, 0 < m i)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    {z : PhaseSpace n} (hz : z ∈ S) {t : ℝ} (ht : 0 ≤ t) :
    massHamiltonian m U (ψ t z) = massHamiltonian m U z := by
  obtain ⟨a, ha, hγ, hinit⟩ := hψ.1 z hz
  have hγ' : IsMechanicalSolutionOn m F Q (Ioo a (t + 1)) (fun u => ψ u z) :=
    hγ.mono fun u hu => hu.1
  have heq := mechanical_energy_const_on_Ioo m F U Q a (t + 1) (fun u => ψ u z)
    hm hγ' hU hF t 0 ⟨lt_of_lt_of_le ha ht, by linarith⟩ ⟨ha, by linarith⟩
  simpa only [hinit] using heq

theorem futureMechanicalFlow_injOn {n : ℕ} {m : CoordinateMasses n} {F : Force n}
    {Q : Set (Position n)} {S : Set (PhaseSpace n)}
    {ψ : ℝ → PhaseSpace n → PhaseSpace n}
    (hψ : IsFutureMechanicalFlowOn m F Q S ψ)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q) {t : ℝ} (ht : 0 ≤ t) :
    InjOn (ψ t) S := by
  intro x hx y hy hxy
  obtain ⟨a, ha, hγ, hinitx⟩ := hψ.1 x hx
  obtain ⟨b, hb, hη, hinity⟩ := hψ.1 y hy
  have hγ' := hγ.mono (Ioi_subset_Ioi (le_max_left a b))
  have hη' := hη.mono (Ioi_subset_Ioi (le_max_right a b))
  have heq : EqOn (fun u => ψ u x) (fun u => ψ u y) (Ioi (max a b)) :=
    mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_Ioi isPreconnected_Ioi (lt_of_lt_of_le (max_lt ha hb) ht) hγ' hη'
      (fun u hu => mechanicalVectorField_contDiffAt m F (ψ u x)
        (hreg _ (hγ'.1 u hu))) hxy
  simpa only [hinitx, hinity] using heq (max_lt ha hb)

theorem exists_futureMechanicalFlow_of_energy_barrier {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n) (r δ : ℝ)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hclosedQ : Metric.closedBall q₀ r ⊆ Q)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∃ ψ : ℝ → PhaseSpace n → PhaseSpace n,
      IsFutureMechanicalFlowOn m F Q
        {z | z.1 ∈ Metric.ball q₀ r ∧ massHamiltonian m U z < U q₀ + δ} ψ := by
  classical
  let S : Set (PhaseSpace n) :=
    {z | z.1 ∈ Metric.ball q₀ r ∧ massHamiltonian m U z < U q₀ + δ}
  have hex : ∀ z : S, ∃ a < (0 : ℝ), ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ 0 = (z : PhaseSpace n) ∧
      ∀ t, 0 ≤ t → γ t ∈ S := by
    intro z
    obtain ⟨a, ha, γ, hγ, hinit, hpos⟩ :=
      exists_globalMechanicalIVP_of_energy_barrier m F U Q q₀ r δ 0 z
        hm hQ hU hF hreg hclosedQ z.property.1 z.property.2 hbarrier
    refine ⟨a, ha, γ, hγ, hinit, ?_⟩
    intro t ht
    refine ⟨hpos t ht, ?_⟩
    have hγ' : IsMechanicalSolutionOn m F Q (Ioo a (t + 1)) γ := hγ.mono fun u hu => hu.1
    have heq := mechanical_energy_const_on_Ioo m F U Q a (t + 1) γ
      hm hγ' hU hF t 0 ⟨lt_of_lt_of_le ha ht, by linarith⟩ ⟨ha, by linarith⟩
    rw [heq, hinit]
    exact z.property.2
  choose a ha f hf hinit hmem using hex
  let ψ : ℝ → PhaseSpace n → PhaseSpace n :=
    fun t z => if hz : z ∈ S then f ⟨z, hz⟩ t else z
  have hψ : ∀ z (hz : z ∈ S) t, ψ t z = f ⟨z, hz⟩ t := by
    intro z hz t
    exact dite_eq_left hz
  refine ⟨ψ, ?_, ?_⟩
  · intro z hz
    refine ⟨a ⟨z, hz⟩, ha ⟨z, hz⟩, ?_, ?_⟩
    · have heq : (fun t => ψ t z) = f ⟨z, hz⟩ := funext (hψ z hz)
      rw [heq]
      exact hf ⟨z, hz⟩
    · rw [hψ z hz]
      exact hinit ⟨z, hz⟩
  · intro t ht z hz
    rw [hψ z hz]
    exact hmem ⟨z, hz⟩ t ht

#print axioms mechanicalSolution_translate_on_Ioi
#print axioms futureMechanicalFlow_add
#print axioms futureMechanicalFlow_commute
#print axioms futureMechanicalFlow_energy
#print axioms futureMechanicalFlow_injOn
#print axioms exists_futureMechanicalFlow_of_energy_barrier

end MolecularDynamics
