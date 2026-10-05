import MolecularDynamics.Chapter06.LangevinLyapunov
import Mathlib.Topology.Constructions.SumProd

/-! The actual descended Hamiltonian power on the unit torus and its compact sublevels. -/

open Set Filter
open scoped Topology ContDiff BigOperators

namespace MolecularDynamics

/-- The actual position quotient is an open quotient map, needed to descend continuity. -/
theorem textbookLangevinPeriodicProjection_isOpenQuotientMap (Nc : ℕ) :
    IsOpenQuotientMap (textbookLangevinPeriodicProjection :
      textbookLangevinPhase Nc → textbookLangevinPeriodicPhase Nc) := by
  have hq : IsOpenQuotientMap (fun q : Fin Nc → ℝ ↦ fun i ↦ (q i : UnitAddCircle)) :=
    IsOpenQuotientMap.piMap (fun _ ↦ QuotientAddGroup.isOpenQuotientMap_mk)
  exact hq.prodMap IsOpenQuotientMap.id

private theorem potential_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hP : textbookUnitPeriodicPotential U) (q : Fin Nc → ℝ) :
    U (textbookLangevinPeriodicRepresentative (fun i ↦ (q i : UnitAddCircle))) = U q := by
  let Q : UnitAddTorus (Fin Nc) := fun i ↦ (q i : UnitAddCircle)
  let r := textbookLangevinPeriodicRepresentative Q
  have h (i : Fin Nc) : ∃ n : ℤ, (n : ℝ) = r i - q i := by
    have hz : ((r i - q i : ℝ) : UnitAddCircle) = 0 := by
      rw [AddCircle.coe_sub]
      have he := congrFun (textbookLangevinPeriodicRepresentative_projects Q) i
      change (r i : UnitAddCircle) = (q i : UnitAddCircle) at he
      rw [he, sub_self]
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp hz
    exact ⟨n, by simpa only [zsmul_eq_mul, mul_one] using hn⟩
  choose n hn using h
  have he : q + (fun i ↦ (n i : ℝ)) = r := by
    ext i
    change q i + (n i : ℝ) = r i
    rw [hn i]
    ring
  have hp := hP q n
  rw [he] at hp
  exact hp

/-- The actual Hamiltonian power on periodic position and real momentum. -/
noncomputable def textbookLangevinPeriodicHamiltonianPower {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (l : ℕ) (z : textbookLangevinPeriodicPhase Nc) : ℝ :=
  textbookLangevinHamiltonianPower U l (textbookLangevinPeriodicRepresentative z.1, z.2)

/-- True lattice periodicity makes the energy independent of the chosen position representative. -/
theorem textbookLangevinPeriodicHamiltonianPower_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hP : textbookUnitPeriodicPotential U) (l : ℕ)
    (z : textbookLangevinPhase Nc) :
    textbookLangevinPeriodicHamiltonianPower U l (textbookLangevinPeriodicProjection z) =
      textbookLangevinHamiltonianPower U l z := by
  simp only [textbookLangevinPeriodicHamiltonianPower, textbookLangevinPeriodicProjection,
    textbookLangevinHamiltonianPower, textbookLangevinHamiltonian]
  rw [potential_lift U hP z.1]

/-- The genuine descended energy is continuous by the actual open quotient map. -/
theorem textbookLangevinPeriodicHamiltonianPower_continuous {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U) (l : ℕ) :
    Continuous (textbookLangevinPeriodicHamiltonianPower U l) := by
  apply (textbookLangevinPeriodicProjection_isOpenQuotientMap Nc).isQuotientMap.continuous_iff.mpr
  have he : textbookLangevinPeriodicHamiltonianPower U l ∘ textbookLangevinPeriodicProjection =
      textbookLangevinHamiltonianPower U l :=
    funext (fun z ↦ textbookLangevinPeriodicHamiltonianPower_lift U hP l z)
  rw [he]
  exact (textbookLangevinHamiltonianPower_contDiff U hU l).continuous

/-- The true periodic energy is positive under the textbook's lower normalization. -/
theorem textbookLangevinPeriodicHamiltonianPower_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hL : ∀ q, 1 ≤ U q) (l : ℕ) (z : textbookLangevinPeriodicPhase Nc) :
    0 < textbookLangevinPeriodicHamiltonianPower U l z :=
  textbookLangevinHamiltonianPower_pos U hL l
    (textbookLangevinPeriodicRepresentative z.1, z.2)

/-- The actual torus energy controls all unbounded momentum directions. -/
theorem textbookLangevinPeriodicHamiltonianPower_momentum_coercive {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hL : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l)
    (z : textbookLangevinPeriodicPhase Nc) :
    ‖z.2‖ ^ 2 ≤ 2 * textbookLangevinPeriodicHamiltonianPower U l z :=
  textbookLangevinHamiltonianPower_momentum_coercive U hL l hl
    (textbookLangevinPeriodicRepresentative z.1, z.2)

/-- The actual periodic energy has genuinely compact sublevels, proving the necessary properness. -/
theorem textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) (R : ℝ) :
    IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R} := by
  let r : ℝ := Real.sqrt (max 0 (2 * R))
  have hr : 0 ≤ r := Real.sqrt_nonneg _
  have hc : IsCompact ((univ : Set (UnitAddTorus (Fin Nc))) ×ˢ Metric.closedBall (0 : Fin Nc → ℝ) r) :=
    isCompact_univ.prod (isCompact_closedBall _ _)
  apply hc.of_isClosed_subset
  · exact isClosed_le (textbookLangevinPeriodicHamiltonianPower_continuous U hU hP l) continuous_const
  · intro z hz
    change textbookLangevinPeriodicHamiltonianPower U l z ≤ R at hz
    refine ⟨mem_univ _, ?_⟩
    rw [Metric.mem_closedBall, dist_zero_right]
    have hb := textbookLangevinPeriodicHamiltonianPower_momentum_coercive U hL l hl z
    have he : r ^ 2 = max 0 (2 * R) := Real.sq_sqrt (le_max_left _ _)
    have hR : 2 * R ≤ max 0 (2 * R) := le_max_right _ _
    nlinarith [hb, he, hR, hr, norm_nonneg z.2]

/-- The genuine energy diverges along escape from every compact subset of the periodic phase space. -/
theorem textbookLangevinPeriodicHamiltonianPower_tendsto_atTop {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (l : ℕ) (hl : 1 ≤ l) :
    Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
      (cocompact (textbookLangevinPeriodicPhase Nc)) atTop := by
  apply tendsto_atTop.mpr
  intro R
  filter_upwards [(textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hP hL l hl R).compl_mem_cocompact]
    with z hz
  change ¬ textbookLangevinPeriodicHamiltonianPower U l z ≤ R at hz
  exact (lt_of_not_ge hz).le

/-- The periodic differential expression is evaluated on the actual smooth real lift.
Identification with the Markov generator remains a separate theorem. -/
noncomputable def textbookLangevinPeriodicDifferentialOperator {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ σ : ℝ) (f : textbookLangevinPeriodicPhase Nc → ℝ)
    (z : textbookLangevinPeriodicPhase Nc) : ℝ :=
  textbookLangevinDifferentialOperator U γ σ (f ∘ textbookLangevinPeriodicProjection)
    (textbookLangevinPeriodicRepresentative z.1, z.2)

/-- The genuine periodic Hamiltonian power satisfies the actual drift inequality on the torus. -/
theorem textbookLangevinPeriodicHamiltonianPower_lyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ σ : ℝ) (hγ : 0 < γ) (l : ℕ) (hl : 1 ≤ l) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
      textbookLangevinPeriodicDifferentialOperator U γ σ (textbookLangevinPeriodicHamiltonianPower U l) z ≤
        -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  obtain ⟨δ, hδ, hBound⟩ := textbookLangevinHamiltonianPower_periodic_lyapunov U hU hP hL γ σ hγ l hl
  have he : textbookLangevinPeriodicHamiltonianPower U l ∘ textbookLangevinPeriodicProjection =
      textbookLangevinHamiltonianPower U l :=
    funext (fun z ↦ textbookLangevinPeriodicHamiltonianPower_lift U hP l z)
  refine ⟨δ, hδ, fun z ↦ ?_⟩
  unfold textbookLangevinPeriodicDifferentialOperator
  rw [he]
  exact hBound _

/-- The actual differential expression on the periodic energy agrees with every real phase lift. -/
theorem textbookLangevinPeriodicHamiltonianPower_operator_lift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (γ σ : ℝ) (l : ℕ) (hl : 1 ≤ l) (z : textbookLangevinPhase Nc) :
    textbookLangevinPeriodicDifferentialOperator U γ σ (textbookLangevinPeriodicHamiltonianPower U l)
      (textbookLangevinPeriodicProjection z) =
      textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z := by
  have he : textbookLangevinPeriodicHamiltonianPower U l ∘ textbookLangevinPeriodicProjection =
      textbookLangevinHamiltonianPower U l :=
    funext (fun x ↦ textbookLangevinPeriodicHamiltonianPower_lift U hP l x)
  unfold textbookLangevinPeriodicDifferentialOperator
  rw [he]
  let z' : textbookLangevinPhase Nc :=
    (textbookLangevinPeriodicRepresentative (textbookLangevinPeriodicProjection z).1, z.2)
  have hH : textbookLangevinHamiltonian U z' = textbookLangevinHamiltonian U z := by
    dsimp [z', textbookLangevinHamiltonian, textbookLangevinPeriodicProjection]
    rw [potential_lift U hP z.1]
  change textbookLangevinDifferentialOperator U γ σ (textbookLangevinHamiltonianPower U l) z' = _
  rw [textbookLangevinHamiltonianPower_differentialOperator U (hU.differentiable (by simp)) γ σ l hl z',
    textbookLangevinHamiltonianPower_differentialOperator U (hU.differentiable (by simp)) γ σ l hl z, hH]

/-- The physical noise gives the actual thermal diffusion coefficient γβ⁻¹, without setting it to one. -/
theorem textbookLangevinLyapunov_physical_diffusion_coefficient
    (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) :
    (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ := by
  rw [Real.sq_sqrt (by positivity : 0 ≤ 2 * γ * β⁻¹)]
  ring

/-- The actual physical-noise periodic model has the same true Lyapunov drift, compact energy sublevels and positivity. -/
theorem textbookLangevinPeriodicHamiltonianPower_physical_lyapunov {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hP : textbookUnitPeriodicPotential U)
    (hL : ∀ q, 1 ≤ U q) (γ β : ℝ) (hγ : 0 < γ) (hβ : 0 < β) (l : ℕ) (hl : 1 ≤ l) :
    0 < γ * l ∧ (Real.sqrt (2 * γ * β⁻¹)) ^ 2 / 2 = γ * β⁻¹ ∧
      (∀ z : textbookLangevinPeriodicPhase Nc, 0 < textbookLangevinPeriodicHamiltonianPower U l z) ∧
      (∀ R : ℝ, IsCompact {z : textbookLangevinPeriodicPhase Nc | textbookLangevinPeriodicHamiltonianPower U l z ≤ R}) ∧
      Tendsto (textbookLangevinPeriodicHamiltonianPower U l)
        (cocompact (textbookLangevinPeriodicPhase Nc)) atTop ∧
      ∃ δ : ℝ, 0 < δ ∧ ∀ z : textbookLangevinPeriodicPhase Nc,
        textbookLangevinPeriodicDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
          (textbookLangevinPeriodicHamiltonianPower U l) z ≤
            -(γ * l) * textbookLangevinPeriodicHamiltonianPower U l z + δ := by
  have hlR : (0 : ℝ) < l := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hl)
  exact ⟨mul_pos hγ hlR, textbookLangevinLyapunov_physical_diffusion_coefficient γ β hγ hβ,
    textbookLangevinPeriodicHamiltonianPower_pos U hL l,
    textbookLangevinPeriodicHamiltonianPower_isCompact_sublevel U hU hP hL l hl,
    textbookLangevinPeriodicHamiltonianPower_tendsto_atTop U hU hP hL l hl,
    textbookLangevinPeriodicHamiltonianPower_lyapunov U hU hP hL γ _ hγ l hl⟩

end MolecularDynamics
