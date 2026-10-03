import MolecularDynamics.Chapter01.EnergyConservation
import Mathlib.Analysis.ODE.ExistUnique

open Set
open scoped Topology
namespace MolecularDynamics
section Banach
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Conservation along every actual trajectory in the state domain. -/
def IsFirstIntegralOn (f : E → E) (Q : Set E) (J : E → ℝ) : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → E),
    (∀ t ∈ Ioo a b, γ t ∈ Q) →
    (∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t) →
    ∀ s ∈ Ioo a b, ∀ t ∈ Ioo a b, J (γ s) = J (γ t)
theorem firstIntegral_hasDerivAt_zero (f : E → E) (J : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hγ : HasDerivAt γ (f (γ t)) t)
    (hJ : DifferentiableAt ℝ J (γ t))
    (hfirst : fderiv ℝ J (γ t) (f (γ t)) = 0) :
    HasDerivAt (fun u => J (γ u)) 0 t := by
  have h := hJ.hasFDerivAt.comp_hasDerivAt t hγ
  rw [hfirst] at h
  exact h

theorem firstIntegral_const_on_Ioo (f : E → E) (J : E → ℝ) (Q : Set E)
    (a b : ℝ) (γ : ℝ → E)
    (hQ : ∀ t ∈ Ioo a b, γ t ∈ Q)
    (hγ : ∀ t ∈ Ioo a b, HasDerivAt γ (f (γ t)) t)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x)
    (hfirst : ∀ x ∈ Q, fderiv ℝ J x (f x) = 0)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b) : J (γ s) = J (γ t) := by
  have hd : ∀ u ∈ Ioo a b, HasDerivAt (fun v => J (γ v)) 0 u :=
    fun u hu => firstIntegral_hasDerivAt_zero f J γ u (hγ u hu)
      (hJ (γ u) (hQ u hu)) (hfirst (γ u) (hQ u hu))
  exact isOpen_Ioo.is_const_of_deriv_eq_zero isPreconnected_Ioo
    (fun u hu => (hd u hu).differentiableAt.differentiableWithinAt)
    (fun u hu => (hd u hu).deriv) hs ht

theorem firstIntegral_differential_necessary (f : E → E) (J : E → ℝ)
    (γ : ℝ → E) (t₀ : ℝ) (hγ : HasDerivAt γ (f (γ t₀)) t₀)
    (hJ : DifferentiableAt ℝ J (γ t₀))
    (hconst : ∀ᶠ t in 𝓝 t₀, J (γ t) = J (γ t₀)) :
    fderiv ℝ J (γ t₀) (f (γ t₀)) = 0 := by
  have hd := hJ.hasFDerivAt.comp_hasDerivAt t₀ hγ
  have hc : HasDerivAt (fun t => J (γ t)) 0 t₀ :=
    (hasDerivAt_const t₀ (J (γ t₀))).congr_of_eventuallyEq hconst
  exact hd.unique hc
end Banach


section LocalExistence
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
local instance : ContinuousSMul ℝ E := by
  have : IsBoundedSMul ℝ E := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul

theorem isFirstIntegralOn_iff_differential (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x) :
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0 := by
  constructor
  · intro hfirst x hx
    obtain ⟨γ, hinit, ε, hε, hder⟩ :=
      (hf x hx).exists_forall_mem_closedBall_exists_eq_forall_mem_Ioo_hasDerivAt₀ 0
    have h0 : (0 : ℝ) ∈ Ioo (0 - ε) (0 + ε) := by constructor <;> linarith
    have hγcont := (hder 0 h0).continuousAt
    have hxγ : γ 0 ∈ Q := by rw [hinit]; exact hx
    obtain ⟨δ, hδ, hsub⟩ := Metric.mem_nhds_iff.mp
      (hγcont.preimage_mem_nhds (hQ.mem_nhds hxγ))
    let r := min ε δ
    have hr : 0 < r := lt_min hε hδ
    have hQr : ∀ t ∈ Ioo (-r) r, γ t ∈ Q := by
      intro t ht
      apply hsub
      rw [Real.ball_eq_Ioo]
      constructor <;> linarith [min_le_right ε δ, ht.1, ht.2]
    have hγr : ∀ t ∈ Ioo (-r) r, HasDerivAt γ (f (γ t)) t := by
      intro t ht
      apply hder
      constructor <;> linarith [min_le_left ε δ, ht.1, ht.2]
    have h0r : (0 : ℝ) ∈ Ioo (-r) r := ⟨by linarith, hr⟩
    have hconst : ∀ᶠ t in 𝓝 (0 : ℝ), J (γ t) = J (γ 0) := by
      filter_upwards [isOpen_Ioo.mem_nhds h0r] with t ht
      exact hfirst (-r) r γ hQr hγr t ht 0 h0r
    have hnecess := firstIntegral_differential_necessary f J γ 0
      (hγr 0 h0r) (hJ (γ 0) hxγ) hconst
    rw [hinit] at hnecess
    exact hnecess
  · intro hfirst a b γ hγQ hγ s hs t ht
    exact firstIntegral_const_on_Ioo f J Q a b γ hγQ hγ hJ hfirst s t hs ht
end LocalExistence
section Euclidean
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
theorem firstIntegral_gradient_criterion (f : E → E) (J : E → ℝ) (x : E)
    (hJ : DifferentiableAt ℝ J x) :
    fderiv ℝ J x (f x) = inner ℝ (gradient J x) (f x) := by
  have h := hJ.hasGradientAt.hasFDerivAt.unique hJ.hasFDerivAt
  rw [← h]
  rfl
end Euclidean
#print axioms isFirstIntegralOn_iff_differential
#print axioms firstIntegral_const_on_Ioo
#print axioms firstIntegral_differential_necessary
#print axioms firstIntegral_gradient_criterion
end MolecularDynamics
