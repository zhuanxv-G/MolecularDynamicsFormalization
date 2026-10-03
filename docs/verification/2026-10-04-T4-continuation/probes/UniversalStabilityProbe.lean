import MolecularDynamics.Chapter01.GlobalContinuation
import MolecularDynamics.Chapter01.MechanicalConfinement
import MolecularDynamics.Chapter01.PotentialRegularity
import MolecularDynamics.Chapter01.Equilibrium

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

theorem stability_probe {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    ∀ ε > 0, ∃ η > 0, ∀ z₀ : PhaseSpace n,
      dist z₀ (q₀, (0 : Momentum n)) < η →
      ∃ a < (0 : ℝ), ∃ γ : ℝ → PhaseSpace n,
        IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ 0 = z₀ ∧
        BddAbove (range (fun t : Ici (0 : ℝ) => dist (γ t) (q₀, (0 : Momentum n)))) ∧
        sSup (range (fun t : Ici (0 : ℝ) => dist (γ t) (q₀, (0 : Momentum n)))) < ε := by
  intro ε hε
  have hUc : ContinuousOn U Q := fun q hq => (hU q hq).continuousAt.continuousWithinAt
  obtain ⟨R, hR, hballQ, hbar⟩ := open_domain_barrier n U Q q₀ hQ hUc hstrict
  obtain ⟨Rs, hRs, hstr⟩ := hstrict.2
  let r := min (R / 2) (min (Rs / 2) (ε / 2))
  have hr : 0 < r := lt_min (by linarith) (lt_min (by linarith) (by linarith))
  have hrR : r < R := lt_of_le_of_lt (min_le_left _ _) (by linarith)
  have hrRs : r < Rs := by
    have : r ≤ Rs / 2 := (min_le_right _ _).trans (min_le_left _ _)
    linarith
  have hrε : r < ε := by
    have : r ≤ ε / 2 := (min_le_right _ _).trans (min_le_right _ _)
    linarith
  have hclosedQ : closedBall q₀ r ⊆ Q := (closedBall_subset_ball hrR).trans hballQ
  obtain ⟨δ, hδ, hbarrier⟩ := hbar r hr hrR
  have hmin : ∀ q ∈ ball q₀ r, U q₀ ≤ U q := by
    intro q hq
    by_cases heq : q = q₀
    · simp [heq]
    · exact (hstr q (hclosedQ (ball_subset_closedBall hq)) heq
        (lt_trans (mem_ball.mp hq) hrRs)).le
  let M : ℝ := 1 + ∑ i, |m i|
  have hMpos : 0 < M := by dsimp [M]; positivity
  have hM : ∀ i, m i ≤ M := by
    intro i
    have hsum : |m i| ≤ ∑ j, |m j| :=
      Finset.single_le_sum (fun j _ => abs_nonneg (m j)) (Finset.mem_univ i)
    dsimp [M]
    linarith [le_abs_self (m i)]
  have hbudgetpos : 0 < r ^ 2 / (2 * M) := by positivity
  have hH : ContinuousAt (massHamiltonian m U) (q₀, (0 : Momentum n)) := by
    change ContinuousAt (fun z : PhaseSpace n => momentumKineticEnergy m z.2 + U z.1) _
    have hKc : Continuous (momentumKineticEnergy m) :=
      continuous_iff_continuousAt.mpr fun p =>
        (hasGradientAt_momentumKineticEnergy m p).differentiableAt.continuousAt
    have hVc : ContinuousAt (fun z : PhaseSpace n => U z.1) (q₀, (0 : Momentum n)) :=
      ContinuousAt.comp (f := fun z : PhaseSpace n => z.1) (x := (q₀, (0 : Momentum n)))
        (hU q₀ hstrict.1).continuousAt continuous_fst.continuousAt
    exact (hKc.comp continuous_snd).continuousAt.add hVc
  have hH₀ : massHamiltonian m U (q₀, (0 : Momentum n)) = U q₀ := by
    simp [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian, momentumKineticEnergy]
  have henergy : ∀ᶠ z in 𝓝 (q₀, (0 : Momentum n)),
      massHamiltonian m U z < U q₀ + min δ (r ^ 2 / (2 * M)) :=
    hH.eventually (Iio_mem_nhds (by rw [hH₀]; linarith [lt_min hδ hbudgetpos]))
  have hpos : ∀ᶠ z : PhaseSpace n in 𝓝 (q₀, (0 : Momentum n)), z.1 ∈ ball q₀ r :=
    continuous_fst.continuousAt.preimage_mem_nhds (ball_mem_nhds _ hr)
  obtain ⟨η, hη, hηsub⟩ := Metric.mem_nhds_iff.mp (henergy.and hpos)
  refine ⟨η, hη, ?_⟩
  intro z₀ hz₀
  have hz := hηsub (mem_ball.mpr hz₀)
  have hbelow : massHamiltonian m U z₀ < U q₀ + δ := by
    linarith [hz.1, min_le_left δ (r ^ 2 / (2 * M))]
  have hbudget : massHamiltonian m U z₀ < U q₀ + r ^ 2 / (2 * M) := by
    linarith [hz.1, min_le_right δ (r ^ 2 / (2 * M))]
  obtain ⟨a, ha, γ, hγ, hinit, _⟩ := energy_global_probe m F U Q q₀ r δ 0 z₀
    hm hQ hU hF hreg hclosedQ hz.2 hbelow ⟨hδ, hbarrier⟩
  have hbound : ∀ t, 0 ≤ t → dist (γ t) (q₀, (0 : Momentum n)) < r := by
    intro t ht
    have hγ' : IsMechanicalSolutionOn m F Q (Ioo a (t + 1)) γ := hγ.mono fun u hu => hu.1
    apply mechanicalSolution_phase_dist_lt m F U Q a (t + 1) 0 γ q₀ M r δ
      hm hMpos hM hr hγ' hU hF ⟨ha, by linarith⟩
    · simpa [hinit] using hz.2
    · simpa [hinit] using hbelow
    · exact ⟨hδ, hbarrier⟩
    · exact hmin
    · simpa [hinit] using hbudget
    · exact ⟨lt_of_lt_of_le ha ht, by linarith⟩
    · exact ht
  refine ⟨a, ha, γ, hγ, hinit, ⟨r, ?_⟩, lt_of_le_of_lt ?_ hrε⟩
  · rintro d ⟨t, rfl⟩
    exact (hbound t t.property).le
  apply csSup_le
  · exact range_nonempty _
  · rintro d ⟨t, rfl⟩
    exact (hbound t t.property).le

#print axioms stability_probe

def IsFutureMechanicalStable {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (zstar : PhaseSpace n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ z₀ : PhaseSpace n, dist z₀ zstar < δ →
    (∃ a < (0 : ℝ), ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ ∧ γ 0 = z₀) ∧
    ∀ a < (0 : ℝ), ∀ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m F Q (Ioi a) γ → γ 0 = z₀ →
      BddAbove (range (fun t : Ici (0 : ℝ) => dist (γ t) zstar)) ∧
      sSup (range (fun t : Ici (0 : ℝ) => dist (γ t) zstar)) < ε

theorem universal_stability_probe {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsFutureMechanicalStable m F Q (q₀, (0 : Momentum n)) := by
  intro ε hε
  obtain ⟨δ, hδ, hstable⟩ := stability_probe m F U Q q₀ hm hQ hU hF hreg hstrict ε hε
  refine ⟨δ, hδ, ?_⟩
  intro z₀ hz₀
  obtain ⟨a, ha, γ, hγ, hinit, hbounded, hsup⟩ := hstable z₀ hz₀
  refine ⟨⟨a, ha, γ, hγ, hinit⟩, ?_⟩
  intro b hb η hη hinitη
  have hγ' : IsMechanicalSolutionOn m F Q (Ioi (max a b)) γ :=
    hγ.mono (Ioi_subset_Ioi (le_max_left _ _))
  have hη' : IsMechanicalSolutionOn m F Q (Ioi (max a b)) η :=
    hη.mono (Ioi_subset_Ioi (le_max_right _ _))
  have heq : EqOn γ η (Ioi (max a b)) :=
    mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_Ioi isPreconnected_Ioi (max_lt ha hb) hγ' hη'
      (fun t ht => mechanicalVectorField_contDiffAt m F (γ t) (hreg _ (hγ'.1 t ht)))
      (hinit.trans hinitη.symm)
  have hdist : (fun t : Ici (0 : ℝ) => dist (η t) (q₀, (0 : Momentum n))) =
      (fun t : Ici (0 : ℝ) => dist (γ t) (q₀, (0 : Momentum n))) := by
    funext t
    rw [heq (lt_of_lt_of_le (max_lt ha hb) t.property)]
  rw [hdist]
  exact ⟨hbounded, hsup⟩

theorem textbook_stability_c2_probe {n : ℕ}
    (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, ContDiffAt ℝ 2 U q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    IsMechanicalEquilibrium m (fun q => -gradient U q) (q₀, (0 : Momentum n)) ∧
    IsFutureMechanicalStable m (fun q => -gradient U q) Q (q₀, (0 : Momentum n)) := by
  have hdiff : ∀ q ∈ Q, DifferentiableAt ℝ U q :=
    fun q hq => (hU q hq).differentiableAt (by norm_num)
  constructor
  · exact strictPotentialMin_mechanicalEquilibrium m (fun q => -gradient U q) U Q q₀
      hQ hstrict (hdiff _ hstrict.1) rfl
  · exact universal_stability_probe m (fun q => -gradient U q) U Q q₀ hm hQ hdiff
      (fun _ _ => rfl)
      (fun q hq => (gradient_contDiffAt_of_potential_contDiffAt_two (hU q hq)).neg) hstrict

#print axioms universal_stability_probe
#print axioms textbook_stability_c2_probe

end MolecularDynamics
