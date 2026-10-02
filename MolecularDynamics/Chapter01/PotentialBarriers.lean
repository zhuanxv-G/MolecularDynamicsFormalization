import MolecularDynamics.Notation
import Mathlib.Topology.Order.Compact
import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.Topology.MetricSpace.ProperSpace
import Mathlib.Topology.Order.IntermediateValue
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-!
# Strict potential minima and energy barriers

Leimkuhler--Matthews, printed page 32 (PDF page 55), the strict minimum
hypothesis in Theorem 1.1. These results establish sphere barriers and
confinement for a supplied continuous trajectory with conserved energy.
The energy gap depends on the chosen radius. ODE existence, momentum bounds,
and global extension remain separate goals.
-/

open Set Filter Metric
open scoped Topology

namespace MolecularDynamics


def StrictPotentialMinRadius {E : Type*} [MetricSpace E]
    (U : E → ℝ) (Q : Set E) (q₀ : E) (R : ℝ) : Prop :=
  0 < R ∧ ∀ q ∈ Q, q ≠ q₀ → dist q q₀ < R → U q₀ < U q

def IsStrictPotentialMinOn {E : Type*} [MetricSpace E]
    (U : E → ℝ) (Q : Set E) (q₀ : E) : Prop :=
  q₀ ∈ Q ∧ ∃ R : ℝ, StrictPotentialMinRadius U Q q₀ R

def IsStrictPotentialMin {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) : Prop :=
  ∃ R : ℝ, 0 < R ∧ ∀ q, 0 < dist q q₀ → dist q q₀ < R → U q₀ < U q

def HasSpherePotentialBarrier {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) (r δ : ℝ) : Prop :=
  0 < δ ∧ ∀ q ∈ sphere q₀ r, U q₀ + δ ≤ U q

theorem strictOn_iff_punctured {E : Type*} [MetricSpace E]
    (U : E → ℝ) (Q : Set E) (q₀ : E) :
    IsStrictPotentialMinOn U Q q₀ ↔
      q₀ ∈ Q ∧ ∀ᶠ q in 𝓝[Q \ {q₀}] q₀, U q₀ < U q := by
  constructor
  · rintro ⟨hq₀, R, hR, hstrict⟩
    refine ⟨hq₀, Metric.mem_nhdsWithin_iff.mpr ⟨R, hR, ?_⟩⟩
    intro q hq
    rcases hq with ⟨hball, hpunct⟩
    exact hstrict q hpunct.1 hpunct.2 (by simpa [Metric.mem_ball] using hball)
  · rintro ⟨hq₀, hevent⟩
    obtain ⟨R, hR, hball⟩ := Metric.mem_nhdsWithin_iff.mp hevent
    refine ⟨hq₀, R, hR, ?_⟩
    intro q hq hne hdist
    exact hball ⟨by simpa [Metric.mem_ball] using hdist, ⟨hq, by simpa using hne⟩⟩

theorem strictUniv_iff {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) :
    IsStrictPotentialMin U q₀ ↔ IsStrictPotentialMinOn U univ q₀ := by
  constructor
  · rintro ⟨R, hR, hstrict⟩
    refine ⟨Set.mem_univ _, R, hR, ?_⟩
    intro q _ hne hdist
    exact hstrict q (dist_pos.mpr hne) hdist
  · rintro ⟨_, R, hR, hstrict⟩
    refine ⟨R, hR, ?_⟩
    intro q hpos hdist
    exact hstrict q (Set.mem_univ _) (dist_pos.mp hpos) hdist

theorem strictOn_isLocalMinOn {E : Type*} [MetricSpace E]
    (U : E → ℝ) (Q : Set E) (q₀ : E)
    (h : IsStrictPotentialMinOn U Q q₀) : IsLocalMinOn U Q q₀ := by
  obtain ⟨_, R, hR, hstrict⟩ := h
  show ∀ᶠ q in 𝓝[Q] q₀, U q₀ ≤ U q
  apply Metric.mem_nhdsWithin_iff.mpr
  refine ⟨R, hR, ?_⟩
  intro q hq
  by_cases heq : q = q₀
  · simp [heq]
  · exact le_of_lt (hstrict q hq.2 heq (by simpa [Metric.mem_ball] using hq.1))

theorem compact_positive_gap {E : Type*} [TopologicalSpace E]
    (U : E → ℝ) (K : Set E) (c : ℝ)
    (hK : IsCompact K) (hU : ContinuousOn U K)
    (hgt : ∀ q ∈ K, c < U q) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ q ∈ K, c + δ ≤ U q := by
  obtain ⟨a, ha, hbound⟩ := hK.exists_forall_le' hU hgt
  refine ⟨a - c, by linarith, ?_⟩
  intro q hq
  have := hbound q hq
  linarith

theorem fixed_sphere_barrier (n : ℕ)
    (U : Position n → ℝ) (Q : Set (Position n)) (q₀ : Position n) (R r : ℝ)
    (hstrict : StrictPotentialMinRadius U Q q₀ R)
    (hr : 0 < r) (hrR : r < R)
    (hsub : sphere q₀ r ⊆ Q)
    (hU : ContinuousOn U (sphere q₀ r)) :
    ∃ δ : ℝ, HasSpherePotentialBarrier U q₀ r δ := by
  have hc : IsCompact (sphere q₀ r) := isCompact_sphere q₀ r
  have hgt : ∀ q ∈ sphere q₀ r, U q₀ < U q := by
    intro q hq
    have hd : dist q q₀ = r := Metric.mem_sphere.mp hq
    have hne : q ≠ q₀ := dist_pos.mp (by rw [hd]; exact hr)
    exact hstrict.2 q (hsub hq) hne (by rw [hd]; exact hrR)
  obtain ⟨δ, hδ, hbound⟩ := compact_positive_gap U (sphere q₀ r) (U q₀) hc hU hgt
  exact ⟨δ, hδ, hbound⟩

theorem open_domain_barrier (n : ℕ)
    (U : Position n → ℝ) (Q : Set (Position n)) (q₀ : Position n)
    (hQ : IsOpen Q) (hU : ContinuousOn U Q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    ∃ R : ℝ, 0 < R ∧ ball q₀ R ⊆ Q ∧
      ∀ r : ℝ, 0 < r → r < R → ∃ δ : ℝ, HasSpherePotentialBarrier U q₀ r δ := by
  obtain ⟨a, ha, hball⟩ := Metric.isOpen_iff.mp hQ q₀ hstrict.1
  obtain ⟨b, hb, hbstrict⟩ := hstrict.2
  refine ⟨min a b, lt_min ha hb, ?_, ?_⟩
  · exact (Metric.ball_subset_ball (min_le_left a b)).trans hball
  · intro r hr hrmin
    have hrb : r < b := lt_of_lt_of_le hrmin (min_le_right a b)
    have hsub : sphere q₀ r ⊆ Q := by
      exact (Metric.sphere_subset_ball (lt_of_lt_of_le hrmin (min_le_left a b))).trans hball
    exact fixed_sphere_barrier n U Q q₀ b r ⟨hb, hbstrict⟩ hr hrb hsub (hU.mono hsub)

/-- At an energy equal to the potential at the center, nonnegative kinetic
energy rules out every point on a positive potential barrier. -/
theorem energy_excludes_sphere {E P : Type*} [MetricSpace E]
    (U : E → ℝ) (K : P → ℝ) (q₀ q : E) (p : P) (r δ : ℝ)
    (hK : 0 ≤ K p) (hH : K p + U q = U q₀)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    q ∉ sphere q₀ r := by
  intro hq
  have hgap := hbarrier.2 q hq
  linarith [hbarrier.1]

theorem energy_below_barrier_excludes_sphere {E P : Type*} [MetricSpace E]
    (U : E → ℝ) (K : P → ℝ) (q₀ q : E) (p : P) (r δ H₀ : ℝ)
    (hK : 0 ≤ K p) (hH : K p + U q = H₀)
    (hbelow : H₀ < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    q ∉ sphere q₀ r := by
  intro hq
  have hgap := hbarrier.2 q hq
  linarith

/-- A continuous trajectory with conserved energy cannot cross the sphere
on its stated time interval. No existence or extension claim is involved. -/
theorem conserved_trajectory_stays_in_ball {E P : Type*} [MetricSpace E]
    (U : E → ℝ) (K : P → ℝ) (q : ℝ → E) (p : ℝ → P)
    (q₀ : E) (t₀ t₁ r δ : ℝ)
    (hr : 0 < r)
    (hqcont : ContinuousOn q (Icc t₀ t₁))
    (hq₀ : q t₀ = q₀)
    (hK : ∀ t ∈ Icc t₀ t₁, 0 ≤ K (p t))
    (hH : ∀ t ∈ Icc t₀ t₁, K (p t) + U (q t) = U q₀)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∀ t ∈ Icc t₀ t₁, q t ∈ ball q₀ r := by
  intro t htmem
  rw [Metric.mem_ball]
  by_contra hnot
  have hrt : r ≤ dist (q t) q₀ := le_of_not_gt hnot
  have hdc : ContinuousOn (fun s => dist (q s) q₀) (Icc t₀ t) := by
    have hqsub : ContinuousOn q (Icc t₀ t) :=
      hqcont.mono (Icc_subset_Icc_right htmem.2)
    exact (continuous_dist.comp_continuousOn (hqsub.prodMk continuousOn_const))
  have hhit : r ∈ Icc (dist (q t₀) q₀) (dist (q t) q₀) := by
    rw [hq₀, dist_self]
    exact ⟨le_of_lt hr, hrt⟩
  obtain ⟨s, hs, hdist⟩ := (intermediate_value_Icc htmem.1 hdc) hhit
  have hsin : s ∈ Icc t₀ t₁ := ⟨hs.1, le_trans hs.2 htmem.2⟩
  have hball : q s ∈ sphere q₀ r := Metric.mem_sphere.mpr hdist
  exact energy_excludes_sphere U K q₀ (q s) (p s) r δ
    (hK s hsin) (hH s hsin) hbarrier hball

theorem conserved_trajectory_below_barrier_stays_in_ball
    {E P : Type*} [MetricSpace E]
    (U : E → ℝ) (K : P → ℝ) (q : ℝ → E) (p : ℝ → P)
    (q₀ : E) (t₀ t₁ r δ H₀ : ℝ)
    (hqcont : ContinuousOn q (Icc t₀ t₁))
    (hstart : q t₀ ∈ ball q₀ r)
    (hK : ∀ t ∈ Icc t₀ t₁, 0 ≤ K (p t))
    (hH : ∀ t ∈ Icc t₀ t₁, K (p t) + U (q t) = H₀)
    (hbelow : H₀ < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∀ t ∈ Icc t₀ t₁, q t ∈ ball q₀ r := by
  intro t htmem
  rw [Metric.mem_ball]
  by_contra hnot
  have hrt : r ≤ dist (q t) q₀ := le_of_not_gt hnot
  have hdc : ContinuousOn (fun s => dist (q s) q₀) (Icc t₀ t) := by
    have hqsub : ContinuousOn q (Icc t₀ t) :=
      hqcont.mono (Icc_subset_Icc_right htmem.2)
    exact (continuous_dist.comp_continuousOn (hqsub.prodMk continuousOn_const))
  have hhit : r ∈ Icc (dist (q t₀) q₀) (dist (q t) q₀) := by
    exact ⟨le_of_lt (Metric.mem_ball.mp hstart), hrt⟩
  obtain ⟨s, hs, hdist⟩ := (intermediate_value_Icc htmem.1 hdc) hhit
  have hsin : s ∈ Icc t₀ t₁ := ⟨hs.1, le_trans hs.2 htmem.2⟩
  have hball : q s ∈ sphere q₀ r := Metric.mem_sphere.mpr hdist
  exact energy_below_barrier_excludes_sphere U K q₀ (q s) (p s) r δ H₀
    (hK s hsin) (hH s hsin) hbelow hbarrier hball

theorem conserved_trajectory_center_below_barrier_stays_in_ball
    {E P : Type*} [MetricSpace E]
    (U : E → ℝ) (K : P → ℝ) (q : ℝ → E) (p : ℝ → P)
    (q₀ : E) (t₀ t₁ r δ H₀ : ℝ)
    (hr : 0 < r) (hqcont : ContinuousOn q (Icc t₀ t₁))
    (hq₀ : q t₀ = q₀)
    (hK : ∀ t ∈ Icc t₀ t₁, 0 ≤ K (p t))
    (hH : ∀ t ∈ Icc t₀ t₁, K (p t) + U (q t) = H₀)
    (hbelow : H₀ < U q₀ + δ)
    (hbarrier : HasSpherePotentialBarrier U q₀ r δ) :
    ∀ t ∈ Icc t₀ t₁, q t ∈ ball q₀ r := by
  apply conserved_trajectory_below_barrier_stays_in_ball
    U K q p q₀ t₀ t₁ r δ H₀ hqcont
  · rw [hq₀, Metric.mem_ball, dist_self]
    exact hr
  · exact hK
  · exact hH
  · exact hbelow
  · exact hbarrier

/-- Composition of local strict minimality, a positive sphere barrier, and
energy conservation. The quantified trajectories are supplied by callers. -/
theorem open_domain_energy_confinement (n : ℕ) {P : Type*}
    (U : Position n → ℝ) (K : P → ℝ)
    (Q : Set (Position n)) (q₀ : Position n)
    (hQ : IsOpen Q) (hU : ContinuousOn U Q)
    (hstrict : IsStrictPotentialMinOn U Q q₀) :
    ∃ R : ℝ, 0 < R ∧ ball q₀ R ⊆ Q ∧
      ∀ r : ℝ, 0 < r → r < R →
        ∃ δ : ℝ, 0 < δ ∧
          ∀ (q : ℝ → Position n) (p : ℝ → P) (t₀ t₁ H₀ : ℝ),
            ContinuousOn q (Icc t₀ t₁) → q t₀ ∈ ball q₀ r →
            (∀ t ∈ Icc t₀ t₁, 0 ≤ K (p t)) →
            (∀ t ∈ Icc t₀ t₁, K (p t) + U (q t) = H₀) →
            H₀ < U q₀ + δ →
            ∀ t ∈ Icc t₀ t₁, q t ∈ ball q₀ r ∧ q t ∈ Q := by
  obtain ⟨R, hR, hsub, hper⟩ := open_domain_barrier n U Q q₀ hQ hU hstrict
  refine ⟨R, hR, hsub, ?_⟩
  intro r hr hrR
  obtain ⟨δ, hδ⟩ := hper r hr hrR
  refine ⟨δ, hδ.1, ?_⟩
  intro q p t₀ t₁ H₀ hqcont hstart hK hH hbelow t ht
  have hstay := conserved_trajectory_below_barrier_stays_in_ball
    U K q p q₀ t₀ t₁ r δ H₀ hqcont hstart hK hH hbelow hδ t ht
  exact ⟨hstay, hsub ((Metric.ball_subset_ball (le_of_lt hrR)) hstay)⟩

theorem zero_dimensional_sphere_empty (q₀ : Position 0) (r : ℝ) (hr : 0 < r) :
    sphere q₀ r = ∅ := by
  exact Metric.sphere_eq_empty_of_subsingleton (ne_of_gt hr)

theorem zero_dimensional_barrier (U : Position 0 → ℝ) (q₀ : Position 0)
    (r : ℝ) (hr : 0 < r) : HasSpherePotentialBarrier U q₀ r 1 := by
  constructor
  · norm_num
  · rw [zero_dimensional_sphere_empty q₀ r hr]
    simp

theorem zero_dimensional_strict_min (U : Position 0 → ℝ) (q₀ : Position 0) :
    IsStrictPotentialMin U q₀ := by
  refine ⟨1, by norm_num, ?_⟩
  intro q hpos _
  have hsame : q = q₀ := Subsingleton.elim q q₀
  simp [hsame] at hpos

theorem singleton_relative_strict (U : ℝ → ℝ) (q₀ : ℝ) :
    IsStrictPotentialMinOn U {q₀} q₀ := by
  refine ⟨by simp, 1, by norm_num, ?_⟩
  intro q hq hne _
  have : q = q₀ := by simpa using hq
  exact (hne this).elim

theorem singleton_sphere_not_subset :
    ¬ sphere (0 : ℝ) 1 ⊆ ({0} : Set ℝ) := by
  intro hsub
  have hmem : (1 : ℝ) ∈ sphere (0 : ℝ) 1 := by simp
  have hzero := hsub hmem
  norm_num at hzero

theorem quartic_strict_min : IsStrictPotentialMin (fun x : ℝ => x ^ 4) 0 := by
  refine ⟨1, by norm_num, ?_⟩
  intro x hx _
  have hne : x ≠ 0 := dist_pos.mp hx
  simp only [zero_pow (by decide : (4 : ℕ) ≠ 0)]
  have hs : 0 < (x ^ 2) ^ 2 := sq_pos_of_ne_zero (pow_ne_zero 2 hne)
  convert hs using 1; ring

theorem quartic_sphere_barrier (r : ℝ) (hr : 0 < r) :
    HasSpherePotentialBarrier (fun x : ℝ => x ^ 4) 0 r (r ^ 4) := by
  refine ⟨pow_pos hr 4, ?_⟩
  intro x hx
  have habs : |x| = r := by
    simpa [Metric.mem_sphere, Real.dist_eq] using hx
  have heq : x ^ 4 = r ^ 4 := by
    rcases le_total 0 x with h | h
    · have : x = r := by simpa [abs_of_nonneg h] using habs
      rw [this]
    · have : -x = r := by simpa [abs_of_nonpos h] using habs
      rw [← this]
      ring
  simp only [zero_pow (by decide : (4 : ℕ) ≠ 0), zero_add, heq, le_refl]

theorem constant_local_min : IsLocalMin (fun _ : ℝ => (0 : ℝ)) 0 := by
  show ∀ᶠ _ in 𝓝 (0 : ℝ), (0 : ℝ) ≤ 0
  exact Filter.Eventually.of_forall (fun _ => le_rfl)

theorem constant_not_strict : ¬ IsStrictPotentialMin (fun _ : ℝ => (0 : ℝ)) 0 := by
  rintro ⟨R, hR, hstrict⟩
  have hhalf : 0 < R / 2 := by linarith
  have hd : dist (R / 2) (0 : ℝ) = R / 2 := by
    rw [Real.dist_eq, sub_zero, abs_of_pos hhalf]
  have hlt : R / 2 < R := by linarith
  have hfalse := hstrict (R / 2) (by rwa [hd]) (by rwa [hd])
  exact (lt_irrefl (0 : ℝ)) hfalse

theorem quartic_potential_continuous : Continuous (fun x : ℝ => x ^ 4) := continuous_id.pow 4

def endpointPotential (x : ℝ) : ℝ := x ^ 2 * (1 - x ^ 2)

theorem endpoint_potential_continuous : Continuous endpointPotential := by
  change Continuous (fun x : ℝ => x ^ 2 * (1 - x ^ 2))
  fun_prop

theorem endpoint_strict_radius :
    StrictPotentialMinRadius endpointPotential univ 0 1 := by
  constructor
  · norm_num
  · intro x _ hne hdist
    have habs : |x| < 1 := by simpa [Real.dist_eq] using hdist
    have hbounds := abs_lt.mp habs
    have hprod : 0 < (1 - x) * (1 + x) :=
      mul_pos (by linarith) (by linarith)
    have hsq : 0 < x ^ 2 := sq_pos_of_ne_zero hne
    have hgap : 0 < 1 - x ^ 2 := by nlinarith
    have hpositive : 0 < x ^ 2 * (1 - x ^ 2) := mul_pos hsq hgap
    simpa [endpointPotential] using hpositive

theorem endpoint_no_barrier :
    ¬ ∃ δ : ℝ, HasSpherePotentialBarrier endpointPotential 0 1 δ := by
  rintro ⟨δ, hδ⟩
  have hmem : (1 : ℝ) ∈ sphere (0 : ℝ) 1 := by
    simp
  have hle := hδ.2 1 hmem
  norm_num [endpointPotential] at hle
  linarith [hδ.1]


end MolecularDynamics
