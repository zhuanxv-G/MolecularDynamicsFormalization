import MolecularDynamics.Chapter06.LangevinPeriodicForce
import Mathlib.MeasureTheory.Integral.DivergenceTheorem

/-! Actual periodic-cube integration by parts needed for Theorem 6.1,
printed 250–251 / PDF 271–272. Formal symmetry is distinct from self-adjoint closure. -/

open Set MeasureTheory
open scoped BigOperators ContDiff

namespace MolecularDynamics

/-- The actual coordinate partial derivative on the configuration lift. -/
noncomputable def textbookConfigurationPartial {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (i : Fin Nc) (q : Fin Nc → ℝ) : ℝ :=
  fderiv ℝ f q (Pi.single i 1)

/-- The full unit-periodic configuration fundamental cube. -/
def textbookConfigurationCube (Nc : ℕ) : Set (Fin Nc → ℝ) := Icc 0 1

/-- The genuine configurational Gibbs weight. -/
noncomputable def textbookConfigurationGibbsWeight {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (q : Fin Nc → ℝ) : ℝ :=
  Real.exp (-β * U q)

/-- The mass-weighted gradient pairing uses every actual inverse coordinate mass. -/
noncomputable def textbookConfigurationGradientPair {Nc : ℕ} (m : Fin Nc → ℝ)
    (f g : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * textbookConfigurationPartial f i q * textbookConfigurationPartial g i q

/-- The literal Brownian generator from the textbook, with arbitrary coordinate masses. -/
noncomputable def textbookBrownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)

/-- Actual differentiation of a smooth scalar observable, rather than a supplied gradient. -/
theorem textbookConfigurationPartial_contDiff {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f) (i : Fin Nc) :
    ContDiff ℝ ∞ (textbookConfigurationPartial f i) := by
  exact (hf.fderiv_right (by simp)).clm_apply contDiff_const

/-- The actual derivative of a smooth periodic observable is periodic. -/
theorem textbookConfigurationPartial_periodic {Nc : ℕ}
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ ∞ f)
    (hp : textbookUnitPeriodicPotential f) (i : Fin Nc) :
    textbookUnitPeriodicPotential (textbookConfigurationPartial f i) := by
  intro q n
  unfold textbookConfigurationPartial
  rw [textbookUnitPeriodicPotential_fderiv f hf hp q n]

/-- Opposite faces differ by the actual integer unit lattice vector. -/
theorem textbookConfigurationCube_opposite_faces {n : ℕ}
    (i : Fin (n + 1)) (q : Fin n → ℝ) :
    i.insertNth 1 q = i.insertNth 0 q + fun j ↦ (((Pi.single i (1 : ℤ) : Fin (n + 1) → ℤ) j) : ℝ) := by
  ext j
  by_cases h : j = i
  · subst j
    simp
  · obtain ⟨k, rfl⟩ := Fin.exists_succAbove_eq h
    simp

/-- The true periodic boundary values cancel in the full finite-dimensional divergence theorem. -/
theorem textbookConfigurationCube_integral_divergence_eq_zero {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ ∞ (F i))
    (hp : ∀ i, textbookUnitPeriodicPotential (F i)) :
    (∫ q in textbookConfigurationCube Nc,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0 := by
  cases Nc with
  | zero => simp
  | succ n =>
    have hi : IntegrableOn
        (fun q ↦ ∑ i, textbookConfigurationPartial (F i) i q)
        (Icc (0 : Fin (n + 1) → ℝ) 1) := by
      apply ContinuousOn.integrableOn_compact isCompact_Icc
      exact (continuous_finsetSum _ fun i _ ↦
        (textbookConfigurationPartial_contDiff (F i) (hF i) i).continuous).continuousOn
    have hd := integral_divergence_of_hasFDerivAt_off_countable'
      (0 : Fin (n + 1) → ℝ) 1 (fun _ ↦ zero_le_one)
      F (fun i q ↦ fderiv ℝ (F i) q) ∅ Set.countable_empty
      (fun i ↦ (hF i).continuous.continuousOn)
      (fun q _ i ↦ ((hF i).differentiable (by simp) q).hasFDerivAt) hi
    rw [show (fun q ↦ ∑ i, (fderiv ℝ (F i) q) (Pi.single i 1)) =
      (fun q ↦ ∑ i, textbookConfigurationPartial (F i) i q) from rfl] at hd
    change (∫ q in Icc (0 : Fin (n + 1) → ℝ) 1,
      ∑ i, textbookConfigurationPartial (F i) i q) = 0
    rw [hd]
    apply Finset.sum_eq_zero
    intro i _
    have he : (fun q : Fin n → ℝ ↦ F i (i.insertNth 1 q)) =
        (fun q ↦ F i (i.insertNth 0 q)) := by
      funext q
      rw [textbookConfigurationCube_opposite_faces]
      exact hp i _ (Pi.single i 1)
    simp only [Pi.zero_apply, Pi.one_apply, he, sub_self]

/-- Smoothness of the actual configurational Gibbs density. -/
theorem textbookConfigurationGibbsWeight_contDiff {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    ContDiff ℝ ∞ (textbookConfigurationGibbsWeight U β) :=
  (contDiff_const.mul hU).exp

/-- Actual lattice invariance of the configurational Gibbs weight. -/
theorem textbookConfigurationGibbsWeight_periodic {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential U) (β : ℝ) :
    textbookUnitPeriodicPotential (textbookConfigurationGibbsWeight U β) := by
  intro q n
  simp only [textbookConfigurationGibbsWeight, hp q n]

/-- The actual coordinate chain rule for the Gibbs weight. -/
theorem textbookConfigurationGibbsWeight_partial {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ)
    (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (textbookConfigurationGibbsWeight U β) i q =
      -β * textbookConfigurationPartial U i q * textbookConfigurationGibbsWeight U β q := by
  have h := (((hU.differentiable (by simp) q).hasFDerivAt).const_mul (-β)).exp
  unfold textbookConfigurationPartial
  change HasFDerivAt (textbookConfigurationGibbsWeight U β) _ q at h
  rw [h.fderiv]
  simp only [_root_.smul_apply, smul_eq_mul, textbookConfigurationGibbsWeight]
  ring


private theorem partial_mul {Nc : ℕ} (f g : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g) (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (fun x ↦ f x * g x) i q =
      textbookConfigurationPartial f i q * g q +
        f q * textbookConfigurationPartial g i q := by
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).mul
    ((hg.differentiable (by simp) q).hasFDerivAt)
  change HasFDerivAt (fun x ↦ f x * g x) _ q at h
  unfold textbookConfigurationPartial
  rw [h.fderiv]
  simp only [add_apply, _root_.smul_apply, smul_eq_mul]
  ring

private theorem partial_const_mul {Nc : ℕ} (f : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ ∞ f) (c : ℝ) (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (fun x ↦ c * f x) i q =
      c * textbookConfigurationPartial f i q := by
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).const_mul c
  unfold textbookConfigurationPartial
  rw [h.fderiv]
  simp only [_root_.smul_apply, smul_eq_mul]

/-- The actual weighted gradient flux on the entire configuration cube. -/
noncomputable def textbookBrownianWeightedFlux {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (i : Fin Nc) (q : Fin Nc → ℝ) : ℝ :=
  (m i)⁻¹ * (f q * textbookConfigurationPartial g i q *
    textbookConfigurationGibbsWeight U β q)

/-- The actual product flux is smooth. -/
theorem textbookBrownianWeightedFlux_contDiff {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (i : Fin Nc) : ContDiff ℝ ∞ (textbookBrownianWeightedFlux m U β f g i) := by
  exact contDiff_const.mul ((hf.mul
    (textbookConfigurationPartial_contDiff g hg i)).mul
      (textbookConfigurationGibbsWeight_contDiff U hU β))

/-- The product flux really agrees on opposite faces by the original periodicity. -/
theorem textbookBrownianWeightedFlux_periodic {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) (i : Fin Nc) :
    textbookUnitPeriodicPotential (textbookBrownianWeightedFlux m U β f g i) := by
  intro q n
  simp only [textbookBrownianWeightedFlux, hPf q n,
    textbookConfigurationPartial_periodic g hg hPg i q n,
    textbookConfigurationGibbsWeight_periodic U hPU β q n]

/-- Literal differentiation of the weighted flux, without an integration identity premise. -/
theorem textbookBrownianWeightedFlux_partial {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (textbookBrownianWeightedFlux m U β f g i) i q =
      (m i)⁻¹ * ((textbookConfigurationPartial f i q * textbookConfigurationPartial g i q +
        f q * textbookConfigurationPartial (textbookConfigurationPartial g i) i q -
        β * f q * textbookConfigurationPartial g i q * textbookConfigurationPartial U i q) *
          textbookConfigurationGibbsWeight U β q) := by
  have hgi := textbookConfigurationPartial_contDiff g hg i
  have hρ := textbookConfigurationGibbsWeight_contDiff U hU β
  unfold textbookBrownianWeightedFlux
  rw [partial_const_mul _ ((hf.mul hgi).mul hρ),
    partial_mul _ _ (hf.mul hgi) hρ, partial_mul _ _ hf hgi,
    textbookConfigurationGibbsWeight_partial U hU β]
  ring

/-- The true flux divergence equals the actual generator and Dirichlet energy density. -/
theorem textbookBrownianWeightedFlux_divergence {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (q : Fin Nc → ℝ) :
    (∑ i, textbookConfigurationPartial (textbookBrownianWeightedFlux m U β f g i) i q) =
      (textbookConfigurationGradientPair m f g q +
        β * f q * textbookBrownianGenerator m U β g q) *
          textbookConfigurationGibbsWeight U β q := by
  unfold textbookConfigurationGradientPair textbookBrownianGenerator
  simp only [Finset.mul_sum, Finset.sum_mul, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  rw [textbookBrownianWeightedFlux_partial m U β f g hU hf hg]
  generalize (m i)⁻¹ = a
  field_simp [hβ]
  ring

/-- The actual smooth periodic Brownian generator has the full mass-weighted Gibbs Dirichlet identity. -/
theorem textbookBrownianGenerator_integral_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  have hρ := (textbookConfigurationGibbsWeight_contDiff U hU β).continuous
  have hG : Continuous (textbookConfigurationGradientPair m f g) := by
    exact continuous_finsetSum _ fun i _ ↦ (continuous_const.mul
      (textbookConfigurationPartial_contDiff f hf i).continuous).mul
        (textbookConfigurationPartial_contDiff g hg i).continuous
  have hL : Continuous (textbookBrownianGenerator m U β g) := by
    apply continuous_finsetSum
    intro i _
    exact continuous_const.mul ((continuous_const.mul
      (textbookConfigurationPartial_contDiff _ (textbookConfigurationPartial_contDiff g hg i) i).continuous).sub
        ((textbookConfigurationPartial_contDiff U hU i).continuous.mul
          (textbookConfigurationPartial_contDiff g hg i).continuous))
  have hGI : IntegrableOn (fun q ↦ textbookConfigurationGradientPair m f g q *
      textbookConfigurationGibbsWeight U β q) (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc (hG.mul hρ).continuousOn
  have hLI : IntegrableOn (fun q ↦ f q * textbookBrownianGenerator m U β g q *
      textbookConfigurationGibbsWeight U β q) (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc
    ((hf.continuous.mul hL).mul hρ).continuousOn
  have hz := textbookConfigurationCube_integral_divergence_eq_zero
    (textbookBrownianWeightedFlux m U β f g)
    (textbookBrownianWeightedFlux_contDiff m U β f g hU hf hg)
    (textbookBrownianWeightedFlux_periodic m U β f g hg hPU hPf hPg)
  simp_rw [textbookBrownianWeightedFlux_divergence m U β hβ f g hU hf hg] at hz
  have he : (fun q ↦ (textbookConfigurationGradientPair m f g q +
      β * f q * textbookBrownianGenerator m U β g q) *
        textbookConfigurationGibbsWeight U β q) =
    (fun q ↦ textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q +
      β * (f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q)) := by
    funext q
    ring
  rw [he, integral_add hGI (hLI.const_mul β), integral_const_mul] at hz
  calc
    _ = β⁻¹ * (β * ∫ q in textbookConfigurationCube Nc,
        f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) := by
          rw [← mul_assoc, inv_mul_cancel₀ hβ, one_mul]
    _ = -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
          rw [show β * (∫ q in textbookConfigurationCube Nc,
            f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
              -(∫ q in textbookConfigurationCube Nc,
                textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q)
            by linarith [hz]]
          ring


/-- The actual fundamental-domain configurational partition integral. -/
noncomputable def textbookConfigurationPartition {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube Nc, textbookConfigurationGibbsWeight U β q

/-- The actual normalized Gibbs weighted pairing of lifted observables. -/
noncomputable def textbookConfigurationInner {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ) : ℝ :=
  (textbookConfigurationPartition U β)⁻¹ *
    ∫ q in textbookConfigurationCube Nc, f q * g q * textbookConfigurationGibbsWeight U β q

/-- The true complete configuration cube has unit Lebesgue volume, including Nc=0. -/
theorem textbookConfigurationCube_volume (Nc : ℕ) :
    volume (textbookConfigurationCube Nc) = 1 := by
  simp [textbookConfigurationCube, Real.volume_Icc_pi]

/-- Genuine smoothness on the compact cube gives a strictly positive finite partition. -/
theorem textbookConfigurationPartition_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (β : ℝ) :
    0 < textbookConfigurationPartition U β := by
  have hρ : IntegrableOn (textbookConfigurationGibbsWeight U β)
      (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc
      (textbookConfigurationGibbsWeight_contDiff U hU β).continuous.continuousOn
  have : NeZero (volume.restrict (textbookConfigurationCube Nc)) :=
    ⟨by
      intro hz
      have he := Measure.restrict_eq_zero.mp hz
      rw [textbookConfigurationCube_volume] at he
      exact one_ne_zero he⟩
  exact integral_exp_pos hρ

/-- The actual normalized weighted Dirichlet identity for smooth periodic observables. -/
theorem textbookBrownianGenerator_inner_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β g) =
      -β⁻¹ * (textbookConfigurationPartition U β)⁻¹ *
        ∫ q in textbookConfigurationCube Nc,
          textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  unfold textbookConfigurationInner
  rw [textbookBrownianGenerator_integral_dirichlet m U β hβ f g hU hf hg hPU hPf hPg]
  ring

/-- Genuine weighted symmetry on periodic smooth tests; no closed self-adjoint operator is claimed here. -/
theorem textbookBrownianGenerator_inner_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β g) =
      textbookConfigurationInner U β (textbookBrownianGenerator m U β f) g := by
  have hpair : textbookConfigurationGradientPair m f g =
      textbookConfigurationGradientPair m g f := by
    funext q
    unfold textbookConfigurationGradientPair
    apply Finset.sum_congr rfl
    intro i _
    ring
  have hswap : textbookConfigurationInner U β (textbookBrownianGenerator m U β f) g =
      textbookConfigurationInner U β g (textbookBrownianGenerator m U β f) := by
    unfold textbookConfigurationInner
    congr 1
    apply integral_congr_ae
    filter_upwards [] with q
    ring
  rw [hswap, textbookBrownianGenerator_inner_dirichlet m U β hβ f g hU hf hg hPU hPf hPg,
    textbookBrownianGenerator_inner_dirichlet m U β hβ g f hU hg hf hPU hPg hPf, hpair]

/-- Positive actual masses make the actual Brownian weighted quadratic form nonpositive. -/
theorem textbookBrownianGenerator_inner_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  rw [textbookBrownianGenerator_inner_dirichlet m U β hβ.ne' f f hU hf hf hPU hPf hPf]
  have henergy : 0 ≤ ∫ q in textbookConfigurationCube Nc,
      textbookConfigurationGradientPair m f f q * textbookConfigurationGibbsWeight U β q := by
    apply integral_nonneg
    intro q
    apply mul_nonneg _ (Real.exp_pos _).le
    unfold textbookConfigurationGradientPair
    apply Finset.sum_nonneg
    intro i _
    have hs : 0 ≤ (textbookConfigurationPartial f i q)^2 := sq_nonneg _
    have he : (m i)⁻¹ * textbookConfigurationPartial f i q * textbookConfigurationPartial f i q =
        (m i)⁻¹ * (textbookConfigurationPartial f i q)^2 := by ring
    rw [he]
    exact mul_nonneg (inv_pos.mpr (hm i)).le hs
  have hZ := textbookConfigurationPartition_pos U hU β
  exact mul_nonpos_of_nonpos_of_nonneg
    (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (inv_pos.mpr hβ).le)
      (inv_pos.mpr hZ).le) henergy

/-- A genuinely nonzero L2 observable has positive actual weighted norm; this is derived, not assumed. -/
theorem textbookConfigurationInner_self_pos {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) :
    0 < textbookConfigurationInner U β f f := by
  have hi : IntegrableOn (fun q ↦ f q * f q * textbookConfigurationGibbsWeight U β q)
      (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc
      ((hf.continuous.mul hf.continuous).mul
        (textbookConfigurationGibbsWeight_contDiff U hU β).continuous).continuousOn
  have hp : ∀ q, 0 ≤ f q * f q * textbookConfigurationGibbsWeight U β q := by
    intro q
    exact mul_nonneg (mul_self_nonneg _) (Real.exp_pos _).le
  have hz : (∫ q in textbookConfigurationCube Nc,
      f q * f q * textbookConfigurationGibbsWeight U β q) ≠ 0 := by
    intro hz
    have hae := (integral_eq_zero_iff_of_nonneg_ae (Filter.Eventually.of_forall hp) hi).mp hz
    apply hne
    filter_upwards [hae] with q hq
    have hρ : textbookConfigurationGibbsWeight U β q ≠ 0 := (Real.exp_pos _).ne'
    have hff := (mul_eq_zero.mp hq).resolve_right hρ
    simpa only [Pi.zero_apply] using (mul_self_eq_zero.mp hff)
  unfold textbookConfigurationInner
  exact mul_pos (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
    (lt_of_le_of_ne (integral_nonneg hp) hz.symm)

/-- Every real eigenvalue of this actual smooth periodic generator on a nonzero weighted L2 vector is nonpositive. -/
theorem textbookBrownianGenerator_real_eigenvalue_nonpos {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  have he : textbookConfigurationInner U β f (textbookBrownianGenerator m U β f) =
      ℓ * textbookConfigurationInner U β f f := by
    unfold textbookConfigurationInner
    have hw : (fun q ↦ f q * textbookBrownianGenerator m U β f q *
        textbookConfigurationGibbsWeight U β q) =
      (fun q ↦ ℓ * (f q * f q * textbookConfigurationGibbsWeight U β q)) := by
      funext q
      rw [heig]
      ring
    rw [hw, integral_const_mul]
    ring
  rw [he] at hn
  apply le_of_not_gt
  intro hℓ
  exact (not_lt_of_ge hn) (mul_pos hℓ (textbookConfigurationInner_self_pos U β f hU hf hne))

private theorem partial_const {Nc : ℕ} (c : ℝ) (i : Fin Nc) :
    textbookConfigurationPartial (fun _ : (Fin Nc → ℝ) ↦ c) i = 0 := by
  funext q
  simp [textbookConfigurationPartial]
private theorem partial_zero {Nc : ℕ} (i : Fin Nc) :
    textbookConfigurationPartial (0 : (Fin Nc → ℝ) → ℝ) i = 0 :=
  partial_const 0 i
/-- The actual generator kills constant observables in every dimension. -/
theorem textbookBrownianGenerator_const {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β c : ℝ) :
    textbookBrownianGenerator m U β (fun _ ↦ c) = 0 := by
  funext q
  simp [textbookBrownianGenerator, partial_const, partial_zero]

/-- The genuine configurational Gibbs weight is weakly stationary for this generator on all periodic smooth tests. -/
theorem textbookBrownianGenerator_gibbs_weak_stationary {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (g : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) = 0 := by
  have hp : textbookUnitPeriodicPotential (fun _ : (Fin Nc → ℝ) ↦ (1 : ℝ)) := by
    intro q n
    rfl
  have h := textbookBrownianGenerator_integral_dirichlet m U β hβ (fun _ ↦ 1) g
    hU contDiff_const hg hPU hp hPg
  simpa only [textbookConfigurationGradientPair, partial_const, Pi.zero_apply,
    mul_zero, zero_mul, Finset.sum_const_zero, integral_zero, one_mul] using h

end MolecularDynamics
