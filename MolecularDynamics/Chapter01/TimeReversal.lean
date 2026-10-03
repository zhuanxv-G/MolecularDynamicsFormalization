import MolecularDynamics.Chapter01.FutureFlow

/-!
# Mechanical time reversal and two-sided energy-barrier existence

Section 1.5.1, printed page 26 / PDF page 49. Time reversal flips momentum
as well as time. Forward solutions of the initial state and its momentum
reflection match on an open overlap and glue to an all-real-time IVP.
-/

open Set Metric
open scoped Topology

namespace MolecularDynamics

local instance (n : ℕ) : ContinuousSMul ℝ (PhaseSpace n) := by
  have : IsBoundedSMul ℝ (PhaseSpace n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

noncomputable def momentumReflection {n : ℕ} : PhaseSpace n →L[ℝ] PhaseSpace n :=
  (ContinuousLinearMap.id ℝ (Position n)).prodMap
    (-ContinuousLinearMap.id ℝ (Momentum n))

@[simp] theorem momentumReflection_apply {n : ℕ} (z : PhaseSpace n) :
    momentumReflection z = (z.1, -z.2) := rfl

@[simp] theorem momentumReflection_twice {n : ℕ} (z : PhaseSpace n) :
    momentumReflection (momentumReflection z) = z := by
  simp

@[simp] theorem massHamiltonian_momentumReflection {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (z : PhaseSpace n) :
    massHamiltonian m U (momentumReflection z) = massHamiltonian m U z := by
  simp [massHamiltonian, massSeparableEnergy, SeparableEnergy.hamiltonian,
    momentumKineticEnergy]

theorem momentumReflection_neg_field {n : ℕ} (m : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) :
    momentumReflection (-mechanicalVectorField m F z) =
      mechanicalVectorField m F (momentumReflection z) := by
  apply Prod.ext <;> simp [mechanicalVectorField, map_neg]

theorem mechanicalSolution_time_reverse_on_Iio {n : ℕ} {m : CoordinateMasses n}
    {F : Force n} {Q : Set (Position n)} {a : ℝ} {γ : ℝ → PhaseSpace n}
    (hγ : IsMechanicalSolutionOn m F Q (Ioi a) γ) :
    IsMechanicalSolutionOn m F Q (Iio (-a)) (fun t => momentumReflection (γ (-t))) := by
  refine ⟨?_, ?_⟩
  · intro t ht
    change (γ (-t)).1 ∈ Q
    exact hγ.1 (-t) (by change a < -t; change t < -a at ht; linarith)
  · intro t ht
    have htime : -t ∈ Ioi a := by change a < -t; change t < -a at ht; linarith
    have hder := (hγ.2 (-t) htime).hasDerivAt (isOpen_Ioi.mem_nhds htime)
    have hneg : HasDerivAt (fun u => γ (-u)) (-mechanicalVectorField m F (γ (-t))) t := by
      simpa only [Function.comp_def, neg_smul, one_smul] using
        hder.scomp t (hasDerivAt_id t).neg
    have hreflect := momentumReflection.hasFDerivAt.comp_hasDerivAt t hneg
    simpa only [Function.comp_def, momentumReflection_neg_field] using hreflect.hasDerivWithinAt

theorem exists_globalMechanicalIVP_of_energy_barrier_two_sided {n : ℕ}
    (m : CoordinateMasses n) (F : Force n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (q₀ : Position n) (r δ : ℝ) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q)
    (hU : ∀ q ∈ Q, DifferentiableAt ℝ U q)
    (hF : ∀ q ∈ Q, F q = -gradient U q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hclosedQ : closedBall q₀ r ⊆ Q) (hstart : z₀.1 ∈ ball q₀ r)
    (hbelow : massHamiltonian m U z₀ < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∃ ζ : ℝ → PhaseSpace n, IsMechanicalSolutionOn m F Q univ ζ ∧ ζ 0 = z₀ ∧
      ∀ t, (ζ t).1 ∈ ball q₀ r := by
  obtain ⟨a, ha, γ, hγ, hinitγ, hposγ⟩ :=
    exists_globalMechanicalIVP_of_energy_barrier m F U Q q₀ r δ 0 z₀
      hm hQ hU hF hreg hclosedQ hstart hbelow hbarrier
  have hstartR : (momentumReflection z₀).1 ∈ ball q₀ r := hstart
  have hbelowR : massHamiltonian m U (momentumReflection z₀) < U q₀ + δ := by
    simpa only [massHamiltonian_momentumReflection] using hbelow
  obtain ⟨b, hb, η, hη, hinitη, hposη⟩ :=
    exists_globalMechanicalIVP_of_energy_barrier m F U Q q₀ r δ 0 (momentumReflection z₀)
      hm hQ hU hF hreg hclosedQ hstartR hbelowR hbarrier
  let κ := fun t => momentumReflection (η (-t))
  have hκ : IsMechanicalSolutionOn m F Q (Iio (-b)) κ := mechanicalSolution_time_reverse_on_Iio hη
  have hinitκ : κ 0 = z₀ := by
    change momentumReflection (η (-(0 : ℝ))) = z₀
    rw [neg_zero, hinitη, momentumReflection_twice]
  have hγ' : IsMechanicalSolutionOn m F Q (Ioo a (-b)) γ := hγ.mono fun u hu => hu.1
  have hκ' : IsMechanicalSolutionOn m F Q (Ioo a (-b)) κ := hκ.mono fun u hu => hu.2
  have heq : EqOn γ κ (Ioo a (-b)) :=
    mechanicalSolution_unique_on_preconnected_of_contDiffAt isOpen_Ioo isPreconnected_Ioo
      (show (0 : ℝ) ∈ Ioo a (-b) from ⟨ha, by linarith⟩) hγ' hκ'
      (fun u hu => mechanicalVectorField_contDiffAt m F (γ u) (hreg _ (hγ'.1 u hu)))
      (hinitγ.trans hinitκ.symm)
  let s : Bool → Set ℝ := fun i => if i then Ioi a else Iio (-b)
  let f : Bool → ℝ → PhaseSpace n := fun i => if i then γ else κ
  have hopen : ∀ i, IsOpen (s i) := by
    intro i
    cases i
    · exact isOpen_Iio
    · exact isOpen_Ioi
  have hsol : ∀ i, IsMechanicalSolutionOn m F Q (s i) (f i) := by
    intro i
    cases i
    · exact hκ
    · exact hγ
  have hcompat : ∀ i j, EqOn (f i) (f j) (s i ∩ s j) := by
    intro i j
    cases i <;> cases j
    · intro t ht; rfl
    · intro t ht; exact (heq ⟨ht.2, ht.1⟩).symm
    · intro t ht; exact heq ⟨ht.1, ht.2⟩
    · intro t ht; rfl
  obtain ⟨ζ, hζ, hagree⟩ := exists_mechanicalSolutionOn_iUnion z₀ hopen hsol hcompat
  have hcover : (⋃ i : Bool, s i) = univ := by
    apply eq_univ_of_forall
    intro t
    by_cases ht : 0 ≤ t
    · exact mem_iUnion.mpr ⟨true, lt_of_lt_of_le ha ht⟩
    · have ht' : t < -b := by linarith
      exact mem_iUnion.mpr ⟨false, ht'⟩
  refine ⟨ζ, by simpa only [hcover] using hζ, (hagree true ha).trans hinitγ, ?_⟩
  intro t
  by_cases ht : 0 ≤ t
  · rw [hagree true (lt_of_lt_of_le ha ht)]
    exact hposγ t ht
  · have ht' : t < -b := by linarith
    rw [hagree false ht']
    change (η (-t)).1 ∈ ball q₀ r
    exact hposη (-t) (by linarith)


end MolecularDynamics
