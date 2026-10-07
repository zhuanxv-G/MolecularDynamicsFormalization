import MolecularDynamics.Chapter02.EulerConvergence
import MolecularDynamics.Chapter02.SymplecticMaps
import Mathlib.Analysis.Calculus.ContDiff.Operations
import Mathlib.Analysis.Asymptotics.Defs

/-! §2.4.1, printed83/PDF105: the quadratic local error of a true splitting.
All error constants are derived from C¹ fields and actual solution curves.
The first flow is evaluated at the second flow's actual endpoint.
-/

open Set Metric
open scoped Matrix Topology
namespace MolecularDynamics
section Splitting
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [ProperSpace E]

omit [ProperSpace E] in
private theorem exists_uniform_euler_family_defect
    (D : Set E) (hD : IsOpen D) (f : E → E) (hf : ContDiffOn ℝ 1 f D)
    (Γ : ℝ → ℝ → E) {τ : ℝ} (hτ : 0 ≤ τ)
    (hc : ContinuousOn (Function.uncurry Γ) (Icc 0 τ ×ˢ Icc 0 τ))
    (hΓD : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, Γ s t ∈ D)
    (hΓ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt (Γ s) (f (Γ s t)) (Icc 0 τ) t) :
    ∃ A : ℝ, 0 < A ∧ ∀ s ∈ Icc 0 τ, ∀ h ∈ Icc 0 τ,
      ‖Γ s h - eulerStep f h (Γ s 0)‖ ≤ A * h ^ 2 := by
  have hmaps : MapsTo (Function.uncurry Γ) (Icc 0 τ ×ˢ Icc 0 τ) D :=
    fun p hp => hΓD p.1 hp.1 p.2 hp.2
  obtain ⟨B, hB⟩ := (isCompact_Icc.prod isCompact_Icc).bddAbove_image
    (((hf.continuousOn_fderiv_of_isOpen hD (by rfl)).comp hc hmaps).norm)
  obtain ⟨M, hM⟩ := (isCompact_Icc.prod isCompact_Icc).bddAbove_image
    ((hf.continuousOn.comp hc hmaps).norm)
  let L := max B 1
  let V := max M 1
  have hL : 0 < L := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hV : 0 < V := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hdf : ∀ x ∈ D, DifferentiableAt ℝ f x := fun x hx =>
    (hf.differentiableOn_one x hx).differentiableAt (hD.mem_nhds hx)
  have hcomp : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt (fun u => f (Γ s u))
        ((fderiv ℝ f (Γ s t)) (f (Γ s t))) (Icc 0 τ) t :=
    fun s hs t ht => (hdf _ (hΓD s hs t ht)).hasFDerivAt.comp_hasDerivWithinAt t
      (hΓ s hs t ht)
  have hbound : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ,
      ‖(fderiv ℝ f (Γ s t)) (f (Γ s t))‖ ≤ L * V := by
    intro s hs t ht
    exact ((fderiv ℝ f (Γ s t)).le_opNorm _).trans
      (mul_le_mul ((hB ⟨(s,t), ⟨hs,ht⟩, rfl⟩).trans (le_max_left _ _))
        ((hM ⟨(s,t), ⟨hs,ht⟩, rfl⟩).trans (le_max_left _ _)) (norm_nonneg _) hL.le)
  refine ⟨L * V, mul_pos hL hV, ?_⟩
  intro s hs h hh
  have hsub : Icc 0 h ⊆ Icc 0 τ := Icc_subset_Icc le_rfl hh.2
  have h0 : (0 : ℝ) ∈ Icc 0 τ := ⟨le_rfl,hτ⟩
  have hvbound : ∀ u ∈ Icc 0 h, ‖f (Γ s u) - f (Γ s 0)‖ ≤ (L * V) * h := by
    intro u hu
    have hv := (convex_Icc (0 : ℝ) τ).norm_image_sub_le_of_norm_hasDerivWithin_le
      (hcomp s hs) (hbound s hs) h0 (hsub hu)
    rw [sub_zero, Real.norm_eq_abs, abs_of_nonneg hu.1] at hv
    exact hv.trans (mul_le_mul_of_nonneg_left hu.2 (mul_nonneg hL.le hV.le))
  have hb := euler_localDefect_of_derivative_bound f (Γ s) hh.1
    (fun u hu => (hΓ s hs u (hsub hu)).mono hsub) (A := L * V)
    (by simpa only [sub_zero] using hvbound)
  simpa only [sub_zero] using hb

omit [ProperSpace E] in
private theorem exists_ode_cross_increment_bound
    (D : Set E) (hD : IsOpen D) (f g : E → E)
    (hf : ContDiffOn ℝ 1 f D) (hg : ContDiffOn ℝ 1 g D)
    (γ : ℝ → E) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (g (γ t)) (Icc 0 τ) t) :
    ∃ B : ℝ, 0 < B ∧ ∀ t ∈ Icc 0 τ, ‖f (γ t) - f (γ 0)‖ ≤ B * t := by
  have hc : ContinuousOn γ (Icc 0 τ) := fun t ht => (hγ t ht).continuousWithinAt
  obtain ⟨L₀,hL₀⟩ := isCompact_Icc.bddAbove_image
    (((hf.continuousOn_fderiv_of_isOpen hD (by rfl)).comp hc hγD).norm)
  obtain ⟨M₀,hM₀⟩ := isCompact_Icc.bddAbove_image ((hg.continuousOn.comp hc hγD).norm)
  let L := max L₀ 1
  let M := max M₀ 1
  have hL : 0 < L := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hM : 0 < M := lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hd : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun u => f (γ u))
      ((fderiv ℝ f (γ t)) (g (γ t))) (Icc 0 τ) t := by
    intro t ht
    exact ((hf.differentiableOn_one _ (hγD ht)).differentiableAt
      (hD.mem_nhds (hγD ht))).hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
  have hb : ∀ t ∈ Icc 0 τ, ‖(fderiv ℝ f (γ t)) (g (γ t))‖ ≤ L * M := by
    intro t ht
    exact ((fderiv ℝ f (γ t)).le_opNorm _).trans
      (mul_le_mul ((hL₀ ⟨t,ht,rfl⟩).trans (le_max_left _ _))
        ((hM₀ ⟨t,ht,rfl⟩).trans (le_max_left _ _)) (norm_nonneg _) hL.le)
  refine ⟨L * M,mul_pos hL hM,?_⟩
  intro t ht
  have h := (convex_Icc (0 : ℝ) τ).norm_image_sub_le_of_norm_hasDerivWithin_le hd hb
    (show (0 : ℝ) ∈ Icc 0 τ from ⟨le_rfl,hτ⟩) ht
  simpa only [sub_zero, Real.norm_eq_abs, abs_of_nonneg ht.1] using h

/-- Quadratic local error for the actual first flow evaluated at the actual
second-flow endpoint.  No Taylor remainders or Lipschitz/error constants
are assumptions.  Γ(s,t) is the first solution starting at γ₂(s). -/
theorem exists_splitting_localError_bound
    (D : Set E) (hD : IsOpen D) (f₁ f₂ : E → E)
    (hf₁ : ContDiffOn ℝ 1 f₁ D) (hf₂ : ContDiffOn ℝ 1 f₂ D)
    (γ γ₂ : ℝ → E) (Γ : ℝ → ℝ → E) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D) (hγ₂D : MapsTo γ₂ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (f₁ (γ t) + f₂ (γ t)) (Icc 0 τ) t)
    (hγ₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ₂ (f₂ (γ₂ t)) (Icc 0 τ) t)
    (hcΓ : ContinuousOn (Function.uncurry Γ) (Icc 0 τ ×ˢ Icc 0 τ))
    (hΓD : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, Γ s t ∈ D)
    (hΓ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt (Γ s) (f₁ (Γ s t)) (Icc 0 τ) t)
    (hinit : γ₂ 0 = γ 0) (hinitΓ : ∀ s ∈ Icc 0 τ, Γ s 0 = γ₂ s) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc 0 τ, ‖Γ h h - γ h‖ ≤ C * h ^ 2 := by
  obtain ⟨A₁,hA₁,hdef₁⟩ := exists_uniform_euler_family_defect D hD f₁ hf₁ Γ hτ hcΓ hΓD hΓ
  obtain ⟨_,_,A₂,_,_,hA₂,_,hdef₂⟩ := exists_euler_trajectory_bounds D hD f₂ hf₂ γ₂ τ hγ₂D hγ₂
  obtain ⟨_,_,A,_,_,hA,_,hdef⟩ := exists_euler_trajectory_bounds D hD
    (fun x => f₁ x + f₂ x) (hf₁.add hf₂) γ τ hγD hγ
  obtain ⟨B,hB,hcross⟩ := exists_ode_cross_increment_bound D hD f₁ f₂ hf₁ hf₂ γ₂ hτ hγ₂D hγ₂
  refine ⟨A₁ + A₂ + B + A,by positivity,?_⟩
  intro h hh
  have h₁ := hdef₁ h hh h hh
  rw [hinitΓ h hh] at h₁
  have h₂ := hdef₂ 0 h le_rfl hh.1 hh.2
  have h₀ := hdef 0 h le_rfl hh.1 hh.2
  simp only [sub_zero] at h₂ h₀
  have heq : Γ h h - γ h =
      (Γ h h - eulerStep f₁ h (γ₂ h)) +
      (γ₂ h - eulerStep f₂ h (γ₂ 0)) +
      h • (f₁ (γ₂ h) - f₁ (γ₂ 0)) +
      (eulerStep (fun x => f₁ x + f₂ x) h (γ 0) - γ h) := by
    simp only [eulerStep,smul_add,smul_sub,hinit]
    abel
  have hcross' : ‖h • (f₁ (γ₂ h) - f₁ (γ₂ 0))‖ ≤ B * h ^ 2 := by
    rw [norm_smul,Real.norm_eq_abs,abs_of_nonneg hh.1]
    calc
      _ ≤ h * (B * h) := mul_le_mul_of_nonneg_left (hcross h hh) hh.1
      _ = _ := by ring
  rw [heq]
  calc
    _ ≤ ‖Γ h h - eulerStep f₁ h (γ₂ h)‖ +
        ‖γ₂ h - eulerStep f₂ h (γ₂ 0)‖ + ‖h • (f₁ (γ₂ h) - f₁ (γ₂ 0))‖ +
        ‖eulerStep (fun x => f₁ x + f₂ x) h (γ 0) - γ h‖ := by
      exact (norm_add_le _ _).trans
        (add_le_add ((norm_add_le _ _).trans
          (add_le_add (norm_add_le _ _) le_rfl)) le_rfl)
    _ ≤ A₁ * h ^ 2 + A₂ * h ^ 2 + B * h ^ 2 + A * h ^ 2 := by
      exact add_le_add (add_le_add (add_le_add h₁ h₂) hcross') (by rwa [norm_sub_rev] at h₀)
    _ = _ := by ring

/-- The textbook's literal F1_h(F2_h(u)) comparison, for actual local
solution families. Joint continuity and ODE/domain data are explicit;
all local-error constants are conclusions. -/
theorem exists_flow_splitting_localError_bound
    (D : Set E) (hD : IsOpen D) (f₁ f₂ : E → E)
    (hf₁ : ContDiffOn ℝ 1 f₁ D) (hf₂ : ContDiffOn ℝ 1 f₂ D)
    (F F₁ F₂ : ℝ → E → E) (u : E) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (f₁ (F t u) + f₂ (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u) (f₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (f₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2 := by
  exact exists_splitting_localError_bound D hD f₁ f₂ hf₁ hf₂
    (fun t => F t u) (fun t => F₂ t u) (fun s t => F₁ t (F₂ s u)) hτ
    hFD hF₂D hF hF₂ hc hF₁D hF₁ (hinit₂.trans hinit.symm) hinit₁

end Splitting

/-- The actual canonical Hamiltonian field, in the labeled coordinate basis. -/
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))

theorem contDiffOn_textbookHamiltonianVectorField {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiffOn ℝ 2 H D) :
    ContDiffOn ℝ 1 (textbookHamiltonianVectorField H) D := by
  intro z hz
  apply contDiffWithinAt_pi.mpr
  intro i
  change ContDiffWithinAt ℝ 1
    (fun z => ∑ j, textbookJ Nc i j * (fderiv ℝ H z) (Pi.single j 1)) D z
  apply ContDiffWithinAt.sum
  intro j _
  have hd : ContDiffAt ℝ 1 (fderiv ℝ H) z :=
    (hH.contDiffAt (hD.mem_nhds hz)).fderiv_right (by norm_num)
  simpa only [smul_eq_mul] using
    (ContDiffAt.const_smul (textbookJ Nc i j)
      (hd.clm_apply (contDiffAt_const (c := Pi.single j 1)))).contDiffWithinAt

theorem textbookHamiltonianVectorField_add {Nc : ℕ}
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (h₁ : DifferentiableAt ℝ H₁ z) (h₂ : DifferentiableAt ℝ H₂ z) :
    textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) z =
      textbookHamiltonianVectorField H₁ z + textbookHamiltonianVectorField H₂ z := by
  unfold textbookHamiltonianVectorField
  rw [fderiv_fun_add h₁ h₂]
  simp only [add_apply]
  have heq : (fun i => (fderiv ℝ H₁ z) (Pi.single i 1) +
      (fderiv ℝ H₂ z) (Pi.single i 1)) =
      (fun i => (fderiv ℝ H₁ z) (Pi.single i 1)) +
        (fun i => (fderiv ℝ H₂ z) (Pi.single i 1)) := by
    funext i
    rfl
  rw [heq]
  exact Matrix.mulVec_add _ _ _

/-- C² Hamiltonians and their actual local flow families give the displayed
second-order local approximation (2.24). No global flow is assumed. -/
theorem exists_hamiltonian_splitting_localError_bound {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2)) := by
  have hODE : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField H₁ (F t u) +
        textbookHamiltonianVectorField H₂ (F t u)) (Icc 0 τ) t := by
    intro t ht
    have h₁ := (hH₁.differentiableOn (by norm_num) _ (hFD t ht)).differentiableAt
      (hD.mem_nhds (hFD t ht))
    have h₂ := (hH₂.differentiableOn (by norm_num) _ (hFD t ht)).differentiableAt
      (hD.mem_nhds (hFD t ht))
    simpa only [textbookHamiltonianVectorField_add H₁ H₂ (F t u) h₁ h₂] using hF t ht
  obtain ⟨C,hC,hbound⟩ := exists_flow_splitting_localError_bound D hD
    (textbookHamiltonianVectorField H₁) (textbookHamiltonianVectorField H₂)
    (contDiffOn_textbookHamiltonianVectorField D hD H₁ hH₁)
    (contDiffOn_textbookHamiltonianVectorField D hD H₂ hH₂)
    F F₁ F₂ u hτ hFD hF₂D hF₁D hODE hF₂ hF₁ hc hinit hinit₂ hinit₁
  refine ⟨C,hC,hbound,?_⟩
  intro hτpos
  apply Asymptotics.IsBigO.of_bound C
  filter_upwards [Ioo_mem_nhdsGT hτpos] with h hh
  simpa only [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg h)] using
    hbound h ⟨hh.1.le,hh.2.le⟩

end MolecularDynamics
