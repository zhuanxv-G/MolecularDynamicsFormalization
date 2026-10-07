import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter03.LiePoisson
import Mathlib.LinearAlgebra.Trace
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

/-! Actual Liouville density calculus required by the proof of Proposition 8.1. -/

open Matrix
open scoped BigOperators Topology

namespace MolecularDynamics

section Divergence

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]

/-- Genuine divergence: the basis-independent trace of the actual Fréchet derivative. -/
noncomputable def textbookDivergence (F : E → E) (z : E) : ℝ :=
  LinearMap.trace ℝ E (fderiv ℝ F z).toLinearMap

/-- The literal stationary Liouville equation for the specified density and field. -/
def textbookLiouvilleStationary (F : E → E) (ρ : E → ℝ) : Prop :=
  ∀ z, textbookDivergence (fun x ↦ ρ x • F x) z = 0

theorem textbookDivergence_density {ρ : E → ℝ} {F : E → E} {z : E}
    (hρ : DifferentiableAt ℝ ρ z) (hF : DifferentiableAt ℝ F z) :
    textbookDivergence (fun x ↦ ρ x • F x) z =
      (fderiv ℝ ρ z) (F z) + ρ z * textbookDivergence F z := by
  unfold textbookDivergence
  rw [fderiv_fun_smul hρ hF]
  change LinearMap.trace ℝ E (ρ z • (fderiv ℝ F z).toLinearMap +
    (fderiv ℝ ρ z).toLinearMap.smulRight (F z)) = _
  rw [map_add, map_smul, LinearMap.trace_smulRight]
  simp only [smul_eq_mul]
  change ρ z * LinearMap.trace ℝ E (fderiv ℝ F z).toLinearMap + (fderiv ℝ ρ z) (F z) =
    (fderiv ℝ ρ z) (F z) + ρ z * LinearMap.trace ℝ E (fderiv ℝ F z).toLinearMap
  exact add_comm _ _

omit [FiniteDimensional ℝ E] in
theorem textbookDivergence_add {F G : E → E} {z : E}
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ F x + G x) z = textbookDivergence F z + textbookDivergence G z := by
  unfold textbookDivergence
  rw [fderiv_fun_add hF hG]
  change LinearMap.trace ℝ E ((fderiv ℝ F z).toLinearMap + (fderiv ℝ G z).toLinearMap) = _
  exact map_add _ _ _

omit [FiniteDimensional ℝ E] in
theorem textbookDivergence_sub {F G : E → E} {z : E}
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z) :
    textbookDivergence (fun x ↦ F x - G x) z = textbookDivergence F z - textbookDivergence G z := by
  unfold textbookDivergence
  rw [fderiv_fun_sub hF hG]
  change LinearMap.trace ℝ E ((fderiv ℝ F z).toLinearMap - (fderiv ℝ G z).toLinearMap) = _
  exact map_sub _ _ _

theorem textbookDivergence_const_smul (c : ℝ) {F : E → E} {z : E}
    (hF : DifferentiableAt ℝ F z) :
    textbookDivergence (fun x ↦ c • F x) z = c * textbookDivergence F z := by
  rw [textbookDivergence_density (differentiableAt_const c) hF,
    (hasFDerivAt_const c z).fderiv]
  simp

variable {G : Type*} [NormedAddCommGroup G] [NormedSpace ℝ G] [FiniteDimensional ℝ G]

private theorem trace_product_blocks (L : (E × G) →ₗ[ℝ] (E × G)) :
    LinearMap.trace ℝ (E × G) L =
      LinearMap.trace ℝ E ((LinearMap.fst ℝ E G).comp (L.comp (LinearMap.inl ℝ E G))) +
      LinearMap.trace ℝ G ((LinearMap.snd ℝ E G).comp (L.comp (LinearMap.inr ℝ E G))) := by
  have he : L = (L.comp (LinearMap.inl ℝ E G)).comp (LinearMap.fst ℝ E G) +
      (L.comp (LinearMap.inr ℝ E G)).comp (LinearMap.snd ℝ E G) := by
    apply LinearMap.ext
    intro z
    change L z = L (z.1, 0) + L (0, z.2)
    rw [← map_add]
    congr 1
    exact Prod.ext (add_zero _).symm (zero_add _).symm
  conv_lhs => rw [he]
  rw [map_add, LinearMap.trace_comp_comm' (LinearMap.fst ℝ E G),
    LinearMap.trace_comp_comm' (LinearMap.snd ℝ E G)]

/-- True divergence in a product equals the actual two diagonal partial divergences. -/
theorem textbookDivergence_prod {F : E × G → E × G} {z : E × G}
    (hF : DifferentiableAt ℝ F z) :
    textbookDivergence F z =
      textbookDivergence (fun u ↦ (F (u, z.2)).1) z.1 +
      textbookDivergence (fun v ↦ (F (z.1, v)).2) z.2 := by
  rcases z with ⟨x, y⟩
  have hinl : (ContinuousLinearMap.id ℝ E).prod (0 : E →L[ℝ] G) =
      ContinuousLinearMap.inl ℝ E G := by
    apply ContinuousLinearMap.ext
    intro u
    rfl
  have hinr : (0 : G →L[ℝ] E).prod (ContinuousLinearMap.id ℝ G) =
      ContinuousLinearMap.inr ℝ E G := by
    apply ContinuousLinearMap.ext
    intro v
    rfl
  have hl : HasFDerivAt (fun u ↦ (F (u, y)).1)
      ((ContinuousLinearMap.fst ℝ E G).comp
        ((fderiv ℝ F (x, y)).comp (ContinuousLinearMap.inl ℝ E G))) x := by
    simpa only [Function.comp_def, id_eq, hinl, ContinuousLinearMap.coe_fst'] using
      (ContinuousLinearMap.fst ℝ E G).hasFDerivAt.comp x
        (hF.hasFDerivAt.comp x ((hasFDerivAt_id x).prodMk (hasFDerivAt_const y x)))
  have hr : HasFDerivAt (fun v ↦ (F (x, v)).2)
      ((ContinuousLinearMap.snd ℝ E G).comp
        ((fderiv ℝ F (x, y)).comp (ContinuousLinearMap.inr ℝ E G))) y := by
    simpa only [Function.comp_def, id_eq, hinr, ContinuousLinearMap.coe_snd'] using
      (ContinuousLinearMap.snd ℝ E G).hasFDerivAt.comp y
        (hF.hasFDerivAt.comp y ((hasFDerivAt_const x y).prodMk (hasFDerivAt_id y)))
  unfold textbookDivergence
  rw [hl.fderiv, hr.fderiv]
  exact trace_product_blocks (fderiv ℝ F (x, y)).toLinearMap

omit [FiniteDimensional ℝ E] [FiniteDimensional ℝ G] in
/-- Genuine divergence is unchanged by an actual invertible linear change of coordinates. -/
theorem textbookDivergence_conjugate (e : E ≃L[ℝ] G) {F : G → G} {x : E}
    (hF : DifferentiableAt ℝ F (e x)) :
    textbookDivergence (fun u ↦ e.symm (F (e u))) x = textbookDivergence F (e x) := by
  have hd : HasFDerivAt (fun u ↦ e.symm (F (e u)))
      (e.symm.toContinuousLinearMap.comp ((fderiv ℝ F (e x)).comp e.toContinuousLinearMap)) x := by
    simpa only [Function.comp_def] using
      e.symm.hasFDerivAt.comp x (hF.hasFDerivAt.comp x e.hasFDerivAt)
  unfold textbookDivergence
  rw [hd.fderiv]
  exact LinearMap.trace_conj' (fderiv ℝ F (e x)).toLinearMap e.symm.toLinearEquiv

/-- A genuine passive auxiliary coordinate multiplies the stationary density. -/
theorem textbookLiouvilleStationary_lift_idle {F : E → E} {ρ : E → ℝ} {a : ℝ → ℝ}
    (hF : ContDiff ℝ 1 F) (hρ : ContDiff ℝ 1 ρ) (ha : ContDiff ℝ 1 a)
    (hs : textbookLiouvilleStationary F ρ) :
    textbookLiouvilleStationary (fun p : E × ℝ ↦ (F p.1, 0)) (fun p ↦ a p.2 * ρ p.1) := by
  have hflux : ContDiff ℝ 1 (fun p : E × ℝ ↦ (a p.2 * ρ p.1) • (F p.1, (0 : ℝ))) :=
    ((ha.comp contDiff_snd).mul (hρ.comp contDiff_fst)).smul
      ((hF.comp contDiff_fst).prodMk contDiff_const)
  rintro ⟨x, y⟩
  rw [textbookDivergence_prod (hflux.differentiable_one (x, y))]
  change textbookDivergence (fun u ↦ (a y * ρ u) • F u) x +
    textbookDivergence (fun v : ℝ ↦ (a v * ρ x) • (0 : ℝ)) y = 0
  simp only [mul_smul, smul_zero]
  have hd : DifferentiableAt ℝ (fun u ↦ ρ u • F u) x := by
    simpa only [Pi.smul_def'] using (hρ.differentiable_one x).smul (hF.differentiable_one x)
  rw [textbookDivergence_const_smul (a y) hd, hs x]
  simp [textbookDivergence]

omit [FiniteDimensional ℝ E] [FiniteDimensional ℝ G] in
theorem textbookLiouvilleStationary_conjugate (e : E ≃L[ℝ] G) {F : G → G} {ρ : G → ℝ}
    (hF : ContDiff ℝ 1 F) (hρ : ContDiff ℝ 1 ρ) (hs : textbookLiouvilleStationary F ρ) :
    textbookLiouvilleStationary (fun u ↦ e.symm (F (e u))) (fun u ↦ ρ (e u)) := by
  intro x
  have he : (fun u ↦ ρ (e u) • e.symm (F (e u))) =
      (fun u ↦ e.symm (ρ (e u) • F (e u))) := by
    funext u
    exact (e.symm.map_smul _ _).symm
  have hd : DifferentiableAt ℝ (fun u ↦ ρ u • F u) (e x) := by
    simpa only [Pi.smul_def'] using
      (hρ.differentiable_one (e x)).smul (hF.differentiable_one (e x))
  rw [he, textbookDivergence_conjugate e hd]
  exact hs (e x)

omit [FiniteDimensional ℝ E] in
theorem textbookLiouvilleStationary_add_sub {F G B : E → E} {ρ : E → ℝ}
    (hF : ContDiff ℝ 1 F) (hG : ContDiff ℝ 1 G) (hB : ContDiff ℝ 1 B) (hρ : ContDiff ℝ 1 ρ)
    (hsF : textbookLiouvilleStationary F ρ) (hsG : textbookLiouvilleStationary G ρ)
    (hsB : textbookLiouvilleStationary B ρ) :
    textbookLiouvilleStationary (fun x ↦ F x + G x - B x) ρ := by
  intro x
  have hdF : DifferentiableAt ℝ (fun u ↦ ρ u • F u) x := by
    simpa only [Pi.smul_def'] using (hρ.differentiable_one x).smul (hF.differentiable_one x)
  have hdG : DifferentiableAt ℝ (fun u ↦ ρ u • G u) x := by
    simpa only [Pi.smul_def'] using (hρ.differentiable_one x).smul (hG.differentiable_one x)
  have hdB : DifferentiableAt ℝ (fun u ↦ ρ u • B u) x := by
    simpa only [Pi.smul_def'] using (hρ.differentiable_one x).smul (hB.differentiable_one x)
  have hdAdd : DifferentiableAt ℝ (fun u ↦ ρ u • F u + ρ u • G u) x := by
    simpa only [Pi.add_def] using hdF.add hdG
  have he : (fun x ↦ ρ x • (F x + G x - B x)) =
      (fun x ↦ (ρ x • F x + ρ x • G x) - ρ x • B x) := by
    funext x
    simp only [smul_sub, smul_add]
  rw [he, textbookDivergence_sub hdAdd hdB, textbookDivergence_add hdF hdG,
    hsF x, hsG x, hsB x]
  norm_num

/-- Multiplying an actual stationary density by a fixed normalizing constant preserves the PDE. -/
theorem textbookLiouvilleStationary_const_mul {F : E → E} {ρ : E → ℝ}
    (hF : ContDiff ℝ 1 F) (hρ : ContDiff ℝ 1 ρ)
    (hs : textbookLiouvilleStationary F ρ) (c : ℝ) :
    textbookLiouvilleStationary F (fun x ↦ c * ρ x) := by
  intro x
  have hd : DifferentiableAt ℝ (fun u ↦ ρ u • F u) x := by
    simpa only [Pi.smul_def'] using (hρ.differentiable_one x).smul (hF.differentiable_one x)
  change textbookDivergence (fun u ↦ (c * ρ u) • F u) x = 0
  simp only [mul_smul]
  rw [textbookDivergence_const_smul c hd, hs x, mul_zero]

end Divergence

/-- The actual Gibbs weight of the actual Hamiltonian. -/
noncomputable def textbookHamiltonianGibbsWeight {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) : SymplecticCoordinates Nc → ℝ :=
  fun z ↦ Real.exp (-β * H z)

theorem textbookHamiltonianGibbsWeight_pos {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) (z : SymplecticCoordinates Nc) :
    0 < textbookHamiltonianGibbsWeight H β z := Real.exp_pos _

/-- The true Hamiltonian divergence and true energy derivative annihilate the actual Gibbs flux. -/
theorem textbookHamiltonianGibbsWeight_stationary {Nc : ℕ}
    {H : SymplecticCoordinates Nc → ℝ} (hH : ContDiff ℝ 2 H) (β : ℝ) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H) (textbookHamiltonianGibbsWeight H β) := by
  have hF : ContDiff ℝ 1 (textbookHamiltonianVectorField H) := contDiffOn_univ.mp
    (contDiffOn_textbookHamiltonianVectorField Set.univ isOpen_univ H hH.contDiffOn)
  intro z
  have hρ := ((hH.differentiable (by norm_num) z).hasFDerivAt.const_mul (-β)).exp
  have hdiv : textbookDivergence (textbookHamiltonianVectorField H) z = 0 := by
    unfold textbookDivergence
    rw [LinearMap.trace_eq_matrix_trace ℝ (Pi.basisFun ℝ (Fin Nc ⊕ Fin Nc))]
    exact textbookHamiltonianVectorField_divergence_zero H z hH.contDiffAt
  have henergy : (fderiv ℝ H z) (textbookHamiltonianVectorField H z) = 0 :=
    textbookPoissonBracket_self H z
  change textbookDivergence (fun x ↦ Real.exp (-β * H x) • textbookHamiltonianVectorField H x) z = 0
  rw [textbookDivergence_density hρ.differentiableAt (hF.differentiable_one z), hdiv, mul_zero, add_zero]
  rw [hρ.fderiv]
  simp only [_root_.smul_apply, smul_eq_mul, henergy, mul_zero]

/-- A specified Gibbs normalizer; finiteness or existence of the partition function is separate. -/
noncomputable def textbookHamiltonianGibbsDensity {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β c : ℝ) : SymplecticCoordinates Nc → ℝ :=
  fun z ↦ c * textbookHamiltonianGibbsWeight H β z

theorem textbookHamiltonianGibbsDensity_stationary {Nc : ℕ}
    {H : SymplecticCoordinates Nc → ℝ} (hH : ContDiff ℝ 2 H) (β c : ℝ) :
    textbookLiouvilleStationary (textbookHamiltonianVectorField H)
      (textbookHamiltonianGibbsDensity H β c) := by
  have hF : ContDiff ℝ 1 (textbookHamiltonianVectorField H) := contDiffOn_univ.mp
    (contDiffOn_textbookHamiltonianVectorField Set.univ isOpen_univ H hH.contDiffOn)
  have hρ : ContDiff ℝ 1 (textbookHamiltonianGibbsWeight H β) :=
    (contDiff_const.mul (hH.of_le (by norm_num))).exp
  exact textbookLiouvilleStationary_const_mul hF hρ
    (textbookHamiltonianGibbsWeight_stationary hH β) c

theorem textbookHamiltonianGibbsDensity_pos {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (β : ℝ) {c : ℝ} (hc : 0 < c)
    (z : SymplecticCoordinates Nc) : 0 < textbookHamiltonianGibbsDensity H β c z :=
  mul_pos hc (textbookHamiltonianGibbsWeight_pos H β z)

section ThermostatAdditivity

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]

/-- The actual single thermostat field, in physical-first coordinates. -/
def textbookSingleThermostatField (F : E → E) (φ : E × ℝ → E) (g : E × ℝ → ℝ)
    (w : E × ℝ) : E × ℝ := (F w.1 + φ w, g w)

/-- The actual combined field has one Hamiltonian drift and both feedback equations. -/
def textbookCombinedThermostatField (F : E → E) (φ₁ φ₂ : E × ℝ → E)
    (g₁ g₂ : E × ℝ → ℝ) (w : (E × ℝ) × ℝ) : (E × ℝ) × ℝ :=
  ((F w.1.1 + φ₁ w.1 + φ₂ (w.1.1, w.2), g₁ w.1), g₂ (w.1.1, w.2))

/-- The literal product density on physical and both auxiliary coordinates. -/
def textbookThermostatProductDensity (ρ : E → ℝ) (a b : ℝ → ℝ)
    (w : (E × ℝ) × ℝ) : ℝ := b w.2 * (a w.1.2 * ρ w.1.1)

private def thermostatAuxSwapLinear : ((E × ℝ) × ℝ) ≃ₗ[ℝ] ((E × ℝ) × ℝ) where
  toFun w := ((w.1.1, w.2), w.1.2)
  invFun w := ((w.1.1, w.2), w.1.2)
  left_inv _ := rfl
  right_inv _ := rfl
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

private noncomputable def thermostatAuxSwap : ((E × ℝ) × ℝ) ≃L[ℝ] ((E × ℝ) × ℝ) :=
  thermostatAuxSwapLinear.toContinuousLinearEquiv

private theorem thermostatAuxSwap_apply (w : (E × ℝ) × ℝ) :
    thermostatAuxSwap w = ((w.1.1, w.2), w.1.2) := rfl

private theorem thermostatAuxSwap_symm_apply (w : (E × ℝ) × ℝ) :
    thermostatAuxSwap.symm w = ((w.1.1, w.2), w.1.2) := rfl

/-- Liouville additivity for the actual fields and product density, with a stationary base. -/
theorem textbookThermostatProductDensity_stationary
    {F : E → E} {φ₁ φ₂ : E × ℝ → E} {g₁ g₂ : E × ℝ → ℝ}
    {ρ : E → ℝ} {a b : ℝ → ℝ}
    (hF : ContDiff ℝ 1 F) (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (hρ : ContDiff ℝ 1 ρ) (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (hs : textbookLiouvilleStationary F ρ)
    (hs₁ : textbookLiouvilleStationary (textbookSingleThermostatField F φ₁ g₁)
      (fun w ↦ a w.2 * ρ w.1))
    (hs₂ : textbookLiouvilleStationary (textbookSingleThermostatField F φ₂ g₂)
      (fun w ↦ b w.2 * ρ w.1)) :
    textbookLiouvilleStationary (textbookCombinedThermostatField F φ₁ φ₂ g₁ g₂)
      (textbookThermostatProductDensity ρ a b) := by
  let V₁ := textbookSingleThermostatField F φ₁ g₁
  let V₂ := textbookSingleThermostatField F φ₂ g₂
  let L₁ : (E × ℝ) × ℝ → (E × ℝ) × ℝ := fun w ↦ (V₁ w.1, 0)
  let L₂ : (E × ℝ) × ℝ → (E × ℝ) × ℝ :=
    fun w ↦ thermostatAuxSwap.symm (V₂ (thermostatAuxSwap w).1, 0)
  let B₁ : E × ℝ → E × ℝ := fun w ↦ (F w.1, 0)
  let B : (E × ℝ) × ℝ → (E × ℝ) × ℝ := fun w ↦ (B₁ w.1, 0)
  have hV₁ : ContDiff ℝ 1 V₁ :=
    ((hF.comp contDiff_fst).add hφ₁).prodMk hg₁
  have hV₂ : ContDiff ℝ 1 V₂ :=
    ((hF.comp contDiff_fst).add hφ₂).prodMk hg₂
  have hρ₁ : ContDiff ℝ 1 (fun w : E × ℝ ↦ a w.2 * ρ w.1) :=
    (ha.comp contDiff_snd).mul (hρ.comp contDiff_fst)
  have hρ₂ : ContDiff ℝ 1 (fun w : E × ℝ ↦ b w.2 * ρ w.1) :=
    (hb.comp contDiff_snd).mul (hρ.comp contDiff_fst)
  have hL₁ : ContDiff ℝ 1 L₁ := (hV₁.comp contDiff_fst).prodMk contDiff_const
  have hLift₂ : ContDiff ℝ 1 (fun w : (E × ℝ) × ℝ ↦ (V₂ w.1, (0 : ℝ))) :=
    (hV₂.comp contDiff_fst).prodMk contDiff_const
  have hL₂ : ContDiff ℝ 1 L₂ :=
    thermostatAuxSwap.symm.contDiff.comp (hLift₂.comp thermostatAuxSwap.contDiff)
  have hB₁ : ContDiff ℝ 1 B₁ := (hF.comp contDiff_fst).prodMk contDiff_const
  have hB : ContDiff ℝ 1 B := (hB₁.comp contDiff_fst).prodMk contDiff_const
  have hQ : ContDiff ℝ 1 (textbookThermostatProductDensity ρ a b) :=
    (hb.comp contDiff_snd).mul (hρ₁.comp contDiff_fst)
  have hsL₁ : textbookLiouvilleStationary L₁ (textbookThermostatProductDensity ρ a b) :=
    textbookLiouvilleStationary_lift_idle hV₁ hρ₁ hb hs₁
  have hsL₂ : textbookLiouvilleStationary L₂ (textbookThermostatProductDensity ρ a b) := by
    have h := textbookLiouvilleStationary_conjugate thermostatAuxSwap hLift₂
      ((ha.comp contDiff_snd).mul (hρ₂.comp contDiff_fst))
      (textbookLiouvilleStationary_lift_idle hV₂ hρ₂ ha hs₂)
    have hdensity : (fun w : (E × ℝ) × ℝ ↦ a w.1.2 * (b w.2 * ρ w.1.1)) =
        textbookThermostatProductDensity ρ a b := by
      funext w
      exact mul_left_comm _ _ _
    change textbookLiouvilleStationary L₂
      (fun w ↦ a w.1.2 * (b w.2 * ρ w.1.1)) at h
    rw [hdensity] at h
    exact h
  have hsB : textbookLiouvilleStationary B (textbookThermostatProductDensity ρ a b) :=
    textbookLiouvilleStationary_lift_idle hB₁ hρ₁ hb
      (textbookLiouvilleStationary_lift_idle hF hρ ha hs)
  have hfields : (fun w ↦ L₁ w + L₂ w - B w) =
      textbookCombinedThermostatField F φ₁ φ₂ g₁ g₂ := by
    funext w
    simp only [L₁, L₂, B, B₁, V₁, V₂, thermostatAuxSwap_apply,
      thermostatAuxSwap_symm_apply, textbookSingleThermostatField,
      textbookCombinedThermostatField, Prod.mk_add_mk, Prod.mk_sub_mk,
      add_zero, zero_add, sub_zero]
    congr 2
    abel
  have h := textbookLiouvilleStationary_add_sub hL₁ hL₂ hB hQ hsL₁ hsL₂ hsB
  rw [hfields] at h
  exact h

omit [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E] in
theorem textbookThermostatProductDensity_nonneg {ρ : E → ℝ} {a b : ℝ → ℝ}
    (hρ : ∀ z, 0 ≤ ρ z) (ha : ∀ x, 0 ≤ a x) (hb : ∀ y, 0 ≤ b y)
    (w : (E × ℝ) × ℝ) : 0 ≤ textbookThermostatProductDensity ρ a b w :=
  mul_nonneg (hb w.2) (mul_nonneg (ha w.1.2) (hρ w.1.1))

end ThermostatAdditivity

/-- Proposition 8.1: the actual Hamiltonian base is derived, rather than assumed stationary. -/
theorem textbookThermostats_additive_proposition81 {Nc : ℕ}
    {H : SymplecticCoordinates Nc → ℝ} (hH : ContDiff ℝ 2 H) (β c : ℝ)
    {φ₁ φ₂ : SymplecticCoordinates Nc × ℝ → SymplecticCoordinates Nc}
    {g₁ g₂ : SymplecticCoordinates Nc × ℝ → ℝ} {a b : ℝ → ℝ}
    (hφ₁ : ContDiff ℝ 1 φ₁) (hφ₂ : ContDiff ℝ 1 φ₂)
    (hg₁ : ContDiff ℝ 1 g₁) (hg₂ : ContDiff ℝ 1 g₂)
    (ha : ContDiff ℝ 1 a) (hb : ContDiff ℝ 1 b)
    (hs₁ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₁ g₁)
      (fun w ↦ a w.2 * textbookHamiltonianGibbsDensity H β c w.1))
    (hs₂ : textbookLiouvilleStationary
      (textbookSingleThermostatField (textbookHamiltonianVectorField H) φ₂ g₂)
      (fun w ↦ b w.2 * textbookHamiltonianGibbsDensity H β c w.1)) :
    textbookLiouvilleStationary
      (textbookCombinedThermostatField (textbookHamiltonianVectorField H) φ₁ φ₂ g₁ g₂)
      (textbookThermostatProductDensity (textbookHamiltonianGibbsDensity H β c) a b) := by
  have hF : ContDiff ℝ 1 (textbookHamiltonianVectorField H) := contDiffOn_univ.mp
    (contDiffOn_textbookHamiltonianVectorField Set.univ isOpen_univ H hH.contDiffOn)
  have hρ : ContDiff ℝ 1 (textbookHamiltonianGibbsDensity H β c) :=
    contDiff_const.mul ((contDiff_const.mul (hH.of_le (by norm_num))).exp)
  exact textbookThermostatProductDensity_stationary hF hφ₁ hφ₂ hg₁ hg₂ hρ ha hb
    (textbookHamiltonianGibbsDensity_stationary hH β c) hs₁ hs₂

end MolecularDynamics
