import MolecularDynamics.Chapter08.ThermostatLieFields
import Mathlib.Analysis.Matrix.PosDef
import Mathlib.LinearAlgebra.Vandermonde
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas
import Mathlib.Tactic.LinearCombination

/-! Proposition8.3, printed347--348/PDF368--369: genuine positive distinct spectral modes.
The coordinate equations follow the actual C/D definitions on printed347.
-/

open Matrix

namespace MolecularDynamics

attribute [local instance] LieRing.ofAssociativeRing

/-- Actual orthogonal eigen-coordinates, using the spectral theorem's eigenvector matrix. -/
noncomputable def textbookThermostatEigenCoordinates {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian) :
    Module.End ℝ (Fin Nc → ℝ) :=
  (star (hA.eigenvectorUnitary : Matrix (Fin Nc) (Fin Nc) ℝ)).toLin'

/-- The genuine block coordinate map on position and momentum. -/
noncomputable def textbookThermostatSpectralPhase {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian) :
    Module.End ℝ (textbookThermostatPhase Nc) :=
  (textbookThermostatEigenCoordinates hA).prodMap (textbookThermostatEigenCoordinates hA)

theorem textbookThermostatEigenCoordinates_eq_dotProduct {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian)
    (v : Fin Nc → ℝ) (i : Fin Nc) :
    textbookThermostatEigenCoordinates hA v i =
      v ⬝ᵥ (fun j ↦ hA.eigenvectorBasis i j) := by
  change ((star (hA.eigenvectorUnitary : Matrix (Fin Nc) (Fin Nc) ℝ)) *ᵥ v) i = _
  simp only [Matrix.mulVec, dotProduct, Matrix.star_apply, star_trivial,
    Matrix.IsHermitian.eigenvectorUnitary_apply]
  apply Finset.sum_congr rfl
  intro j _
  ring

theorem textbookThermostatEigenCoordinates_intertwine {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian)
    (v : Fin Nc → ℝ) (i : Fin Nc) :
    textbookThermostatEigenCoordinates hA (A *ᵥ v) i =
      hA.eigenvalues i * textbookThermostatEigenCoordinates hA v i := by
  let U : Matrix (Fin Nc) (Fin Nc) ℝ := hA.eigenvectorUnitary
  have hd : star U * A * U = diagonal hA.eigenvalues := by
    simpa [U, Unitary.conjStarAlgAut_star_apply, RCLike.ofReal_real_eq_id] using
      hA.conjStarAlgAut_star_eigenvectorUnitary
  have hu : U * star U = 1 := Unitary.coe_mul_star_self hA.eigenvectorUnitary
  have hi : star U * A = diagonal hA.eigenvalues * star U := by
    calc
      star U * A = star U * A * (U * star U) := by rw [hu, mul_one]
      _ = (star U * A * U) * star U := (mul_assoc (star U * A) U (star U)).symm
      _ = diagonal hA.eigenvalues * star U := by rw [hd]
  change (star U *ᵥ (A *ᵥ v)) i = _
  rw [mulVec_mulVec, hi, ← mulVec_mulVec, mulVec_diagonal]
  rfl

theorem textbookThermostatEigenCoordinates_power {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian)
    (k : ℕ) (v : Fin Nc → ℝ) (i : Fin Nc) :
    textbookThermostatEigenCoordinates hA ((A ^ k) *ᵥ v) i =
      hA.eigenvalues i ^ k * textbookThermostatEigenCoordinates hA v i := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [pow_succ', ← mulVec_mulVec, textbookThermostatEigenCoordinates_intertwine, ih]
    ring

theorem textbookThermostat_C_coordinates {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian)
    (k : ℕ) (z : textbookThermostatPhase Nc) :
    textbookThermostatSpectralPhase hA (textbookThermostatC A k z) =
      ((fun i ↦ hA.eigenvalues i ^ k * textbookThermostatEigenCoordinates hA z.2 i),
       (fun i ↦ hA.eigenvalues i ^ (k + 1) * textbookThermostatEigenCoordinates hA z.1 i)) := by
  apply Prod.ext <;> ext i <;> exact textbookThermostatEigenCoordinates_power hA _ _ i

theorem textbookThermostat_D_coordinates {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian)
    (k : ℕ) (z : textbookThermostatPhase Nc) :
    textbookThermostatSpectralPhase hA (textbookThermostatD A k z) =
      ((fun i ↦ hA.eigenvalues i ^ (k + 1) * textbookThermostatEigenCoordinates hA z.1 i),
       (fun i ↦ -(hA.eigenvalues i ^ (k + 1) * textbookThermostatEigenCoordinates hA z.2 i))) := by
  apply Prod.ext
  · ext i
    exact textbookThermostatEigenCoordinates_power hA _ _ i
  · change textbookThermostatEigenCoordinates hA (-((A ^ (k + 1)) *ᵥ z.2)) = _
    rw [map_neg]
    ext i
    simp only [Pi.neg_apply, textbookThermostatEigenCoordinates_power]

/-- The actual eigenmode domain D from Theorem8.1. -/
def textbookThermostatModeDomain {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian) :
    Set (textbookThermostatPhase Nc) :=
  {z | ∀ i, textbookThermostatEigenCoordinates hA z.1 i ≠ 0 ∨
    textbookThermostatEigenCoordinates hA z.2 i ≠ 0}

theorem textbookThermostatModeDomain_isOpen {Nc : ℕ}
    {A : Matrix (Fin Nc) (Fin Nc) ℝ} (hA : A.IsHermitian) :
    IsOpen (textbookThermostatModeDomain hA) := by
  have hq (i : Fin Nc) : Continuous (fun z : textbookThermostatPhase Nc ↦
      textbookThermostatEigenCoordinates hA z.1 i) :=
    (continuous_apply i).comp
      ((LinearMap.toContinuousLinearMap (textbookThermostatEigenCoordinates hA)).continuous.comp
        continuous_fst)
  have hp (i : Fin Nc) : Continuous (fun z : textbookThermostatPhase Nc ↦
      textbookThermostatEigenCoordinates hA z.2 i) :=
    (continuous_apply i).comp
      ((LinearMap.toContinuousLinearMap (textbookThermostatEigenCoordinates hA)).continuous.comp
        continuous_snd)
  have hd : textbookThermostatModeDomain hA =
      ⋂ i, ({z | textbookThermostatEigenCoordinates hA z.1 i ≠ 0} ∪
        {z | textbookThermostatEigenCoordinates hA z.2 i ≠ 0}) := by
    ext z
    simp [textbookThermostatModeDomain]
  rw [hd]
  apply isOpen_iInter_of_finite
  intro i
  apply IsOpen.union
  · change IsOpen ((fun z : textbookThermostatPhase Nc ↦
      textbookThermostatEigenCoordinates hA z.1 i) ⁻¹' ({0}ᶜ : Set ℝ))
    exact (isClosed_singleton : IsClosed ({0} : Set ℝ)).isOpen_compl.preimage (hq i)
  · change IsOpen ((fun z : textbookThermostatPhase Nc ↦
      textbookThermostatEigenCoordinates hA z.2 i) ⁻¹' ({0}ᶜ : Set ℝ))
    exact (isClosed_singleton : IsClosed ({0} : Set ℝ)).isOpen_compl.preimage (hp i)

/-- Actual modal coefficient cancellation and Vandermonde injectivity. -/
theorem textbookThermostatModal_coefficients_eq_zero {Nc : ℕ}
    (ν q p a b : Fin Nc → ℝ) (hν : ∀ i, 0 < ν i) (hdist : Function.Injective ν)
    (hmode : ∀ i, q i ≠ 0 ∨ p i ≠ 0)
    (hfirst : ∀ i, (∑ k, a k * ν i ^ (k : ℕ)) * p i +
      ν i * (∑ k, b k * ν i ^ (k : ℕ)) * q i = 0)
    (hsecond : ∀ i, ν i * (∑ k, a k * ν i ^ (k : ℕ)) * q i -
      ν i * (∑ k, b k * ν i ^ (k : ℕ)) * p i = 0) : a = 0 ∧ b = 0 := by
  let α (i : Fin Nc) := ∑ k, a k * ν i ^ (k : ℕ)
  let β (i : Fin Nc) := ∑ k, b k * ν i ^ (k : ℕ)
  have hw (i : Fin Nc) : 0 < p i ^ 2 + ν i * q i ^ 2 := by
    rcases hmode i with hq | hp
    · exact add_pos_of_nonneg_of_pos (sq_nonneg _) (mul_pos (hν i) (sq_pos_of_ne_zero hq))
    · exact add_pos_of_pos_of_nonneg (sq_pos_of_ne_zero hp) (mul_nonneg (hν i).le (sq_nonneg _))
  have ha (i : Fin Nc) : α i = 0 := by
    have he : (p i ^ 2 + ν i * q i ^ 2) * α i = 0 := by
      linear_combination p i * hfirst i + q i * hsecond i
    exact (mul_eq_zero.mp he).resolve_left (ne_of_gt (hw i))
  have hb (i : Fin Nc) : β i = 0 := by
    have hw' : 0 < ν i * (p i ^ 2 + ν i * q i ^ 2) := mul_pos (hν i) (hw i)
    have he : (ν i * (p i ^ 2 + ν i * q i ^ 2)) * β i = 0 := by
      linear_combination ν i * q i * hfirst i - p i * hsecond i
    exact (mul_eq_zero.mp he).resolve_left (ne_of_gt hw')
  exact ⟨Matrix.eq_zero_of_forall_index_sum_mul_pow_eq_zero hdist ha,
    Matrix.eq_zero_of_forall_index_sum_mul_pow_eq_zero hdist hb⟩

/-- The actual 2Nc vectors C1,D1,...,CNc,DNc, indexed without artificial coordinates. -/
noncomputable def textbookThermostatFamily {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (z : textbookThermostatPhase Nc) :
    Fin Nc ⊕ Fin Nc → textbookThermostatPhase Nc :=
  Sum.elim (fun k ↦ textbookThermostatC A k z) (fun k ↦ textbookThermostatD A k z)

/-- Proposition8.3 for the actual positive-definite matrix and its genuine spectral domain. -/
theorem textbookThermostatFamily_linearIndependent {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase Nc)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    LinearIndependent ℝ (textbookThermostatFamily A z) := by
  classical
  rw [Fintype.linearIndependent_iff]
  intro g hg
  have hrel : (∑ k : Fin Nc, g (Sum.inl k) • textbookThermostatC A k z) +
      (∑ k : Fin Nc, g (Sum.inr k) • textbookThermostatD A k z) = 0 := by
    simpa [Fintype.sum_sum_type, textbookThermostatFamily] using hg
  have hc := congrArg (textbookThermostatSpectralPhase hA.1) hrel
  simp only [map_add, map_sum, map_smul, map_zero, textbookThermostat_C_coordinates,
    textbookThermostat_D_coordinates] at hc
  have hfirst (i : Fin Nc) :
      (∑ k : Fin Nc, g (Sum.inl k) * hA.1.eigenvalues i ^ (k : ℕ)) *
        textbookThermostatEigenCoordinates hA.1 z.2 i +
      hA.1.eigenvalues i * (∑ k : Fin Nc, g (Sum.inr k) * hA.1.eigenvalues i ^ (k : ℕ)) *
        textbookThermostatEigenCoordinates hA.1 z.1 i = 0 := by
    have he := congrArg (((LinearMap.proj i).comp
      (LinearMap.fst ℝ (Fin Nc → ℝ) (Fin Nc → ℝ))) : textbookThermostatPhase Nc → ℝ) hc
    simp only [map_add, map_sum, map_smul, map_zero, LinearMap.comp_apply,
      LinearMap.fst_apply, LinearMap.proj_apply, smul_eq_mul] at he
    simpa [Finset.sum_mul, Finset.mul_sum, pow_succ, mul_assoc, mul_left_comm, mul_comm]
      using he
  have hsecond (i : Fin Nc) :
      hA.1.eigenvalues i * (∑ k : Fin Nc, g (Sum.inl k) * hA.1.eigenvalues i ^ (k : ℕ)) *
        textbookThermostatEigenCoordinates hA.1 z.1 i -
      hA.1.eigenvalues i * (∑ k : Fin Nc, g (Sum.inr k) * hA.1.eigenvalues i ^ (k : ℕ)) *
        textbookThermostatEigenCoordinates hA.1 z.2 i = 0 := by
    have he := congrArg (((LinearMap.proj i).comp
      (LinearMap.snd ℝ (Fin Nc → ℝ) (Fin Nc → ℝ))) : textbookThermostatPhase Nc → ℝ) hc
    simp only [map_add, map_sum, map_smul, map_zero, LinearMap.comp_apply,
      LinearMap.snd_apply, LinearMap.proj_apply, smul_eq_mul] at he
    simpa [Finset.sum_mul, Finset.mul_sum, pow_succ, mul_assoc, mul_left_comm, mul_comm,
      sub_eq_add_neg, ← Finset.sum_neg_distrib] using he
  obtain ⟨ha, hb⟩ := textbookThermostatModal_coefficients_eq_zero hA.1.eigenvalues
    (textbookThermostatEigenCoordinates hA.1 z.1) (textbookThermostatEigenCoordinates hA.1 z.2)
    (fun k ↦ g (Sum.inl k)) (fun k ↦ g (Sum.inr k)) hA.eigenvalues_pos hdist hz hfirst hsecond
  intro k
  cases k with
  | inl k => exact congrFun ha k
  | inr k => exact congrFun hb k

/-- The actual finite family spans the whole 2Nc-dimensional phase, including Nc=0. -/
theorem textbookThermostatFamily_span_eq_top {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase Nc)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    Submodule.span ℝ (Set.range (textbookThermostatFamily A z)) = ⊤ := by
  apply (textbookThermostatFamily_linearIndependent A hA hdist z hz).span_eq_top_of_card_eq_finrank'
  simp [textbookThermostatPhase, Module.finrank_prod]

/-- The true generated Lie algebra evaluates to a spanning set at every point of D. -/
theorem textbookThermostatLieSpan_pointwise_span_eq_top {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase Nc)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    Submodule.span ℝ (Set.range (fun X : textbookThermostatLieSpan A ↦ (X : Module.End ℝ _) z)) =
      ⊤ := by
  apply top_unique
  rw [← textbookThermostatFamily_span_eq_top A hA hdist z hz]
  apply Submodule.span_mono
  rintro _ ⟨k, rfl⟩
  cases k with
  | inl k =>
    exact ⟨⟨textbookThermostatC A k, (textbookThermostat_C_D_mem_lieSpan A k).1⟩, rfl⟩
  | inr k =>
    exact ⟨⟨textbookThermostatD A k, (textbookThermostat_C_D_mem_lieSpan A k).2⟩, rfl⟩

end MolecularDynamics
