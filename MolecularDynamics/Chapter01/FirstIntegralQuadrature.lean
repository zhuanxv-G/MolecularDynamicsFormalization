import MolecularDynamics.Chapter01.FirstIntegralGraph
import Mathlib.Analysis.Calculus.ImplicitContDiff

open Set Filter
open scoped Topology
namespace MolecularDynamics

theorem exists_planarFirstIntegral_C1Graph (J : ℝ × ℝ → ℝ) (p : ℝ × ℝ)
    (hJ : ContDiffAt ℝ 1 J p) (hpartial : (fderiv ℝ J p) (0, 1) ≠ 0) :
    ∃ ψ : ℝ → ℝ, ψ p.1 = p.2 ∧ ContDiffAt ℝ 1 ψ p.1 ∧
      (∀ᶠ v in 𝓝 p, J v = J p ↔ ψ v.1 = v.2) := by
  have hi := planarScalarPartial_isInvertible (fderiv ℝ J p) hpartial
  exact ⟨hJ.implicitFunction (by norm_num) hi, hJ.implicitFunction_apply_self (by norm_num) hi,
    hJ.contDiffAt_implicitFunction (by norm_num) hi,
    hJ.eventually_apply_eq_iff_implicitFunction (by norm_num) hi⟩

theorem exists_planarFirstIntegral_quadratureWindow (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0) :
    ∃ (ψ : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      (∀ᶠ v in 𝓝 (γ t₀), J v = J (γ t₀) ↔ ψ v.1 = v.2) ∧
      ContinuousOn (fun x => (f (x, ψ x)).1) (Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ)) ∧
      (∀ x ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ), (f (x, ψ x)).1 ≠ 0) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        (γ t).1 ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ) ∧
        (γ t).2 = ψ (γ t).1 ∧
        HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t) := by
  obtain ⟨ψ, hinit, hψ, hgraph⟩ := exists_planarFirstIntegral_C1Graph J (γ t₀) hJ hpartial
  let w : ℝ → ℝ := fun x => (f (x, ψ x)).1
  have hf' : ContDiffAt ℝ 1 f ((γ t₀).1, ψ (γ t₀).1) := by
    rw [hinit]
    exact hf
  have hw : ContDiffAt ℝ 1 w (γ t₀).1 := by
    exact (hf'.comp (γ t₀).1 (contDiffAt_id.prodMk hψ)).fst
  have hw₀ : w (γ t₀).1 ≠ 0 := by dsimp [w]; rw [hinit]; exact hspeed
  have hpos : {x : ℝ | ContinuousAt w x ∧ w x ≠ 0} ∈ 𝓝 (γ t₀).1 := by
    filter_upwards [hw.eventually (by norm_num), hw.continuousAt.eventually_ne hw₀] with x hx hn
    exact ⟨hx.continuousAt, hn⟩
  obtain ⟨δ, hδ, hδsub⟩ := Metric.mem_nhds_iff.mp hpos
  have hcw : ContinuousOn w (Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ)) := by
    intro x hx
    exact (hδsub (by rwa [Real.ball_eq_Ioo])).1.continuousWithinAt
  have hnw : ∀ x ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ), w x ≠ 0 := by
    intro x hx
    exact (hδsub (by rwa [Real.ball_eq_Ioo])).2
  have hbase : (γ t₀).1 ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ) := by
    constructor <;> linarith
  have hrange := (hγ t₀ ht₀).continuousAt.fst.preimage_mem_nhds (isOpen_Ioo.mem_nhds hbase)
  have hpull := (hγ t₀ ht₀).continuousAt.tendsto.eventually hgraph
  have htime : {t : ℝ | t ∈ Ioo a b ∧
      (γ t).1 ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ) ∧ (γ t).2 = ψ (γ t).1 ∧
      HasDerivAt (fun u => (γ u).1) (w (γ t).1) t} ∈ 𝓝 t₀ := by
    filter_upwards [isOpen_Ioo.mem_nhds ht₀, hrange, hpull] with t ht hr hg
    have hlevel := hfirst a b γ hQ hγ t ht t₀ ht₀
    have hs := (hg.mp hlevel).symm
    have hp : γ t = ((γ t).1, ψ (γ t).1) := Prod.ext rfl hs
    have hd := (hγ t ht).fst
    rw [hp] at hd
    exact ⟨ht, hr, hs, hd⟩
  obtain ⟨ε, hε, hεsub⟩ := Metric.mem_nhds_iff.mp htime
  refine ⟨ψ, δ, ε, hδ, hε, hinit, hψ, hgraph, hcw, hnw, ?_⟩
  intro t ht
  exact hεsub (by rwa [Real.ball_eq_Ioo])

theorem planarFirstIntegral_nonturning_quadrature (f : ℝ × ℝ → ℝ × ℝ)
    (Q : Set (ℝ × ℝ)) (J : ℝ × ℝ → ℝ) (a b t₀ : ℝ) (γ : ℝ → ℝ × ℝ)
    (hfirst : IsFirstIntegralOn f Q J) (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) (ht₀ : t₀ ∈ Ioo a b)
    (hJ : ContDiffAt ℝ 1 J (γ t₀)) (hf : ContDiffAt ℝ 1 f (γ t₀))
    (hpartial : (fderiv ℝ J (γ t₀)) (0, 1) ≠ 0) (hspeed : (f (γ t₀)).1 ≠ 0) :
    ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
      ψ (γ t₀).1 = (γ t₀).2 ∧ ContDiffAt ℝ 1 ψ (γ t₀).1 ∧
      HasStrictDerivAt g (f (γ t₀)).1 0 ∧
      (∀ᶠ t in 𝓝 t₀, (γ t).1 = g (t - t₀) ∧ (γ t).2 = ψ (g (t - t₀))) ∧
      (∀ᶠ x in 𝓝 (γ t₀).1,
        g (separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 x) = x) ∧
      (∀ᶠ y in 𝓝 0, separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (g y) = y) ∧
      (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
        separableTimePrimitive (fun x => (f (x, ψ x)).1) (γ t₀).1 (γ t).1 = t - t₀) := by
  obtain ⟨ψ, δ, ε, hδ, hε, hinit, hψ, _, hw, hn, htime⟩ :=
    exists_planarFirstIntegral_quadratureWindow f Q J a b t₀ γ hfirst hQ hγ ht₀ hJ hf hpartial hspeed
  have hbase : (γ t₀).1 ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ) := by constructor <;> linarith
  have ht₀' : t₀ ∈ Ioo (t₀ - ε) (t₀ + ε) := by constructor <;> linarith
  have hODE : ∀ t ∈ Ioo (t₀ - ε) (t₀ + ε),
      (γ t).1 ∈ Ioo ((γ t₀).1 - δ) ((γ t₀).1 + δ) ∧
      HasDerivAt (fun u => (γ u).1) ((f ((γ t).1, ψ (γ t).1)).1) t :=
    fun t ht => ⟨(htime t ht).2.1, (htime t ht).2.2.2⟩
  obtain ⟨g, hl, hr, hg, hsol⟩ := separableTimePrimitive_inverse_along_solution
    (fun x => (f (x, ψ x)).1) ((γ t₀).1 - δ) ((γ t₀).1 + δ) (γ t₀).1
    (t₀ - ε) (t₀ + ε) t₀ hw hn hbase (fun t => (γ t).1) hODE ht₀' rfl
  have hspeed' : (f ((γ t₀).1, ψ (γ t₀).1)).1 = (f (γ t₀)).1 := by rw [hinit]
  rw [hspeed'] at hg
  refine ⟨ψ, g, δ, ε, hδ, hε, hinit, hψ, hg, ?_, hl, hr, ?_⟩
  · filter_upwards [hsol, isOpen_Ioo.mem_nhds ht₀'] with t ht hi
    exact ⟨ht.symm, by rw [ht]; exact (htime t hi).2.2.1⟩
  · intro t ht
    exact ⟨(htime t ht).1, separableTimePrimitive_along_solution
      (fun x => (f (x, ψ x)).1) ((γ t₀).1 - δ) ((γ t₀).1 + δ) (γ t₀).1
      (t₀ - ε) (t₀ + ε) t₀ hw hn hbase (fun t => (γ t).1) hODE ht₀' rfl t ht⟩

end MolecularDynamics
