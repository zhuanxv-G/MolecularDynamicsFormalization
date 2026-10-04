import MolecularDynamics.Chapter01.EquilibriumLinearization
import Mathlib.Analysis.ODE.ExistUnique

open Set Filter Metric
open scoped Topology NNReal
namespace MolecularDynamics
section Banach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

/-- A genuine local solution family with joint continuity and one uniform initial-data bound. -/
theorem exists_C1_localContinuousSolutionFamily (f : E → E) (z₀ : E) (t₀ : ℝ)
    (hf : ContDiffAt ℝ 1 f z₀) :
    ∃ (r ε : ℝ) (C : ℝ≥0) (Φ : E × ℝ → E), 0 < r ∧ 0 < ε ∧
      ContinuousOn Φ (closedBall z₀ r ×ˢ Icc (t₀ - ε) (t₀ + ε)) ∧
      (∀ z ∈ closedBall z₀ r, Φ (z, t₀) = z ∧
        ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε),
          HasDerivAt (fun u => Φ (z, u)) (f (Φ (z, t))) t) ∧
      (∀ t ∈ Icc (t₀ - ε) (t₀ + ε), LipschitzOnWith C (fun z => Φ (z, t)) (closedBall z₀ r)) ∧
      (∀ z ∈ ball z₀ r, ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), ContinuousAt Φ (z, t)) := by
  obtain ⟨ε, hε, a, r, L, K, hr, hpl⟩ := IsPicardLindelof.of_contDiffAt_one hf
  obtain ⟨α, hα, C, hLip⟩ := (hpl t₀).exists_forall_mem_closedBall_eq_hasDerivWithinAt_lipschitzOnWith
  let Φ : E × ℝ → E := fun p => α p.1 p.2
  have hc : ContinuousOn Φ (closedBall z₀ (r : ℝ) ×ˢ Icc (t₀ - ε) (t₀ + ε)) := by
    exact continuousOn_prod_of_continuousOn_lipschitzOnWith _ C
      (fun z hz => HasDerivWithinAt.continuousOn (hα z hz).2) hLip
  refine ⟨r, ε, C, Φ, hr, hε, hc, ?_, hLip, ?_⟩
  · intro z hz
    refine ⟨(hα z hz).1, fun t ht => ?_⟩
    exact ((hα z hz).2 t (Ioo_subset_Icc_self ht)).hasDerivAt (Icc_mem_nhds ht.1 ht.2)
  · intro z hz t ht
    have hznh : closedBall z₀ (r : ℝ) ∈ 𝓝 z :=
      mem_of_superset (isOpen_ball.mem_nhds hz) ball_subset_closedBall
    exact hc.continuousAt (prod_mem_nhds hznh (Icc_mem_nhds ht.1 ht.2))

local instance (n : ℕ) : ContinuousSMul ℝ (PhaseSpace n) := by
  have : IsBoundedSMul ℝ (PhaseSpace n) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

/-- The derivative-derived local family applies directly to an actual mechanical field. -/
theorem exists_localContinuousMechanicalFamily {n : ℕ} (m : CoordinateMasses n)
    (F : Force n) (z₀ : PhaseSpace n) (t₀ : ℝ) (hF : ContDiffAt ℝ 1 F z₀.1) :
    ∃ (r ε : ℝ) (C : ℝ≥0) (Φ : PhaseSpace n × ℝ → PhaseSpace n), 0 < r ∧ 0 < ε ∧
      ContinuousOn Φ (closedBall z₀ r ×ˢ Icc (t₀ - ε) (t₀ + ε)) ∧
      (∀ z ∈ closedBall z₀ r, Φ (z, t₀) = z ∧
        ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε),
          HasDerivAt (fun u => Φ (z, u)) (mechanicalVectorField m F (Φ (z, t))) t) ∧
      (∀ t ∈ Icc (t₀ - ε) (t₀ + ε), LipschitzOnWith C (fun z => Φ (z, t)) (closedBall z₀ r)) ∧
      (∀ z ∈ ball z₀ r, ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), ContinuousAt Φ (z, t)) := by
  have hf : ContDiffAt ℝ 1 (mechanicalVectorField m F) z₀ := by
    exact ((velocityOperator m).contDiff.contDiffAt.comp z₀ contDiffAt_snd).prodMk
      (hF.comp z₀ contDiffAt_fst)
  exact exists_C1_localContinuousSolutionFamily (mechanicalVectorField m F) z₀ t₀ hf

/-- Joint continuity yields a uniform actual local IVP family inside an open position domain. -/
theorem exists_localContinuousMechanicalFamily_open {n : ℕ} (m : CoordinateMasses n)
    (F : Force n) (Q : Set (Position n)) (hQ : IsOpen Q)
    (z₀ : PhaseSpace n) (hz₀ : z₀.1 ∈ Q) (t₀ : ℝ) (hF : ContDiffAt ℝ 1 F z₀.1) :
    ∃ (r ε : ℝ) (C : ℝ≥0) (Φ : PhaseSpace n × ℝ → PhaseSpace n), 0 < r ∧ 0 < ε ∧
      ContinuousOn Φ (ball z₀ r ×ˢ Ioo (t₀ - ε) (t₀ + ε)) ∧
      (∀ z ∈ ball z₀ r, IsLocalMechanicalIVP m F Q t₀ z ε (fun t => Φ (z, t))) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), LipschitzOnWith C (fun z => Φ (z, t)) (ball z₀ r)) := by
  obtain ⟨R, τ, C, Φ, hR, hτ, hcont, hα, hLip, hcontAt⟩ :=
    exists_localContinuousMechanicalFamily m F z₀ t₀ hF
  have ht₀ : t₀ ∈ Ioo (t₀ - τ) (t₀ + τ) := by constructor <;> linarith
  have hinit : Φ (z₀, t₀) = z₀ := (hα z₀ (mem_closedBall_self hR.le)).1
  have hpos : {p : PhaseSpace n × ℝ | (Φ p).1 ∈ Q} ∈ 𝓝 (z₀, t₀) :=
    (hcontAt z₀ (mem_ball_self hR) t₀ ht₀).fst.preimage_mem_nhds
      (hQ.mem_nhds (by rw [hinit]; exact hz₀))
  obtain ⟨δ, hδ, hδsub⟩ := Metric.mem_nhds_iff.mp hpos
  let r := min R (δ / 2)
  let ε := min τ (δ / 2)
  have hr : 0 < r := lt_min hR (by linarith)
  have hε : 0 < ε := lt_min hτ (by linarith)
  have hzR : ball z₀ r ⊆ closedBall z₀ R :=
    (ball_subset_ball (min_le_left _ _)).trans ball_subset_closedBall
  have htτ : Ioo (t₀ - ε) (t₀ + ε) ⊆ Ioo (t₀ - τ) (t₀ + τ) := by
    intro t ht
    constructor <;> linarith [min_le_left τ (δ / 2), ht.1, ht.2]
  refine ⟨r, ε, C, Φ, hr, hε,
    hcont.mono (fun p hp => ⟨hzR hp.1, Ioo_subset_Icc_self (htτ hp.2)⟩), ?_, ?_⟩
  · intro z hz
    refine ⟨hε, (hα z (hzR hz)).1, ?_, ?_⟩
    · intro t ht
      apply hδsub
      rw [mem_ball, Prod.dist_eq, max_lt_iff]
      refine ⟨?_, ?_⟩
      · have hd := mem_ball.mp hz
        dsimp [r] at hd
        linarith [min_le_right R (δ / 2)]
      · rw [Real.dist_eq, abs_lt]
        constructor <;> linarith [min_le_right τ (δ / 2), ht.1, ht.2]
    · intro t ht
      exact ((hα z (hzR hz)).2 t (htτ ht)).hasDerivWithinAt
  · intro t ht
    exact (hLip t (Ioo_subset_Icc_self (htτ ht))).mono hzR
end Banach
end MolecularDynamics
#print axioms MolecularDynamics.exists_C1_localContinuousSolutionFamily
#print axioms MolecularDynamics.exists_localContinuousMechanicalFamily

#print axioms MolecularDynamics.exists_localContinuousMechanicalFamily_open
