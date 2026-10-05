import MolecularDynamics.Chapter08.HormanderClosure
import MolecularDynamics.Chapter08.ThermostatSpan

/-! Proposition8.2 and Theorem8.1: actual thermostat derivative fields and pointwise brackets. -/

open Matrix
open scoped ContDiff

namespace MolecularDynamics

attribute [local instance] LieRing.ofAssociativeRing

section General
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

def textbookThermostatLift (V : E → E) : E × ℝ → E × ℝ := fun w ↦ (V w.1, 0)

def textbookThermostatDrift (F G : E → E) (g : E → ℝ) (γ : ℝ) : E × ℝ → E × ℝ :=
  fun w ↦ (F w.1 + w.2 • G w.1, g w.1 - γ * w.2)

def textbookThermostatNoise (σ : ℝ) : E × ℝ → E × ℝ := fun _ ↦ (0, σ)

def textbookThermostatSeed (F G : E → E) (g : E → ℝ) (γ σ : ℝ) :
    Set (E × ℝ → E × ℝ) :=
  {textbookThermostatDrift F G g γ, textbookThermostatNoise σ}

theorem textbookThermostatSeed_contDiff (F G : E → E) (g : E → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g) :
    ∀ V ∈ textbookThermostatSeed F G g γ σ, ContDiff ℝ ∞ V := by
  intro V hv
  rcases Set.mem_insert_iff.mp hv with rfl | hv
  · exact ((hF.comp contDiff_fst).add (contDiff_snd.smul (hG.comp contDiff_fst))).prodMk
      ((hg.comp contDiff_fst).sub (contDiff_const.mul contDiff_snd))
  · rcases Set.mem_singleton_iff.mp hv with rfl
    exact contDiff_const

theorem textbookThermostatLift_lieBracket (V W : E → E)
    (hV : Differentiable ℝ V) (hW : Differentiable ℝ W) :
    VectorField.lieBracket ℝ (textbookThermostatLift V) (textbookThermostatLift W) =
      textbookThermostatLift (VectorField.lieBracket ℝ V W) := by
  funext w
  have hv := ((hV w.1).hasFDerivAt.comp w hasFDerivAt_fst).prodMk (hasFDerivAt_const (0 : ℝ) w)
  have hw := ((hW w.1).hasFDerivAt.comp w hasFDerivAt_fst).prodMk (hasFDerivAt_const (0 : ℝ) w)
  simp only [Function.comp_apply] at hv hw
  change fderiv ℝ (fun u : E × ℝ ↦ (W u.1, 0)) w (V w.1, 0) -
    fderiv ℝ (fun u : E × ℝ ↦ (V u.1, 0)) w (W w.1, 0) = _
  rw [hv.fderiv, hw.fderiv]
  apply Prod.ext
  · rfl
  · change (0 : ℝ) - 0 = 0
    exact sub_self 0

theorem textbookThermostatDrift_noise_bracket (F G : E → E) (g : E → ℝ) (γ σ : ℝ)
    (hF : Differentiable ℝ F) (hG : Differentiable ℝ G) (hg : Differentiable ℝ g)
    (w : E × ℝ) :
    VectorField.lieBracket ℝ (textbookThermostatDrift F G g γ) (textbookThermostatNoise σ) w =
      (-σ • G w.1, σ * γ) := by
  have hf := (hF w.1).hasFDerivAt.comp w hasFDerivAt_fst
  have hgv := (hG w.1).hasFDerivAt.comp w hasFDerivAt_fst
  have hgs := (hg w.1).hasFDerivAt.comp w hasFDerivAt_fst
  have hs := hasFDerivAt_snd (𝕜 := ℝ) (p := w)
  have hd := (hf.add (hs.smul hgv)).prodMk (hgs.sub (hs.const_smul γ))
  simp only [Function.comp_apply, Pi.add_apply, Pi.smul_apply, Pi.smul_apply', Pi.sub_apply,
    smul_eq_mul] at hd
  have hn := hasFDerivAt_const (𝕜 := ℝ) ((0 : E), σ) w
  change fderiv ℝ (fun _ : E × ℝ ↦ ((0 : E), σ)) w
      (textbookThermostatDrift F G g γ w) -
    fderiv ℝ (fun u : E × ℝ ↦ (F u.1 + u.2 • G u.1, g u.1 - γ * u.2)) w (0, σ) = _
  rw [hn.fderiv, hd.fderiv]
  simp [ContinuousLinearMap.prod_apply, ContinuousLinearMap.comp_apply,
    ContinuousLinearMap.smulRight_apply, neg_smul, mul_comm]

private theorem smoothBracket_seed_mem (seed : Set (E → E)) (V : E → E) (hV : V ∈ seed) :
    V ∈ textbookSmoothBracketModule seed := by
  simpa only [one_smul] using textbookSmoothBracketModule_generator_mem seed
    (fun _ ↦ (1 : ℝ)) V contDiff_const (textbookIteratedBracket.seed hV)

/-- Actual drift/noise fields recover both physical lifts using smooth scalar coefficients. -/
theorem textbookThermostatLift_mem_module (F G : E → E) (g : E → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g) (hσ : σ ≠ 0) :
    textbookThermostatLift F ∈ textbookSmoothBracketModule (textbookThermostatSeed F G g γ σ) ∧
      textbookThermostatLift G ∈ textbookSmoothBracketModule (textbookThermostatSeed F G g γ σ) := by
  let s := textbookThermostatSeed F G g γ σ
  let S := textbookSmoothBracketModule s
  have hs : ∀ V ∈ s, ContDiff ℝ ∞ V := textbookThermostatSeed_contDiff F G g γ σ hF hG hg
  have hb0 : textbookThermostatDrift F G g γ ∈ S := smoothBracket_seed_mem s _ (by simp [s, textbookThermostatSeed])
  have hb1 : textbookThermostatNoise σ ∈ S := smoothBracket_seed_mem s _ (by simp [s, textbookThermostatSeed])
  have hc := textbookSmoothBracketModule_bracket_mem s hs hb0 hb1
  have heG : textbookThermostatLift G = (-σ⁻¹) •
      (VectorField.lieBracket ℝ (textbookThermostatDrift F G g γ) (textbookThermostatNoise σ) -
        γ • textbookThermostatNoise σ) := by
    funext w
    rw [Pi.smul_apply, Pi.sub_apply, textbookThermostatDrift_noise_bracket F G g γ σ
      (hF.differentiable (by simp)) (hG.differentiable (by simp)) (hg.differentiable (by simp))]
    apply Prod.ext
    · change G w.1 = (-σ⁻¹) • ((-σ) • G w.1 - γ • 0)
      simp [smul_smul, hσ]
    · change (0 : ℝ) = (-σ⁻¹) * (σ * γ - γ * σ)
      ring
  have hGl : textbookThermostatLift G ∈ S := by rw [heG]; exact S.smul_mem _ (S.sub_mem hc (S.smul_mem γ hb1))
  have hξG := textbookSmoothBracketModule_smooth_smul_mem s (fun w : E × ℝ ↦ w.2) contDiff_snd hGl
  have hgb := textbookSmoothBracketModule_smooth_smul_mem s
    (fun w : E × ℝ ↦ (g w.1 - γ * w.2) * σ⁻¹)
    (((hg.comp contDiff_fst).sub (contDiff_const.mul contDiff_snd)).mul contDiff_const) hb1
  have heF : textbookThermostatLift F = textbookThermostatDrift F G g γ -
      (fun w : E × ℝ ↦ w.2 • textbookThermostatLift G w) -
      (fun w : E × ℝ ↦ ((g w.1 - γ * w.2) * σ⁻¹) • textbookThermostatNoise σ w) := by
    funext w
    apply Prod.ext
    · change F w.1 = F w.1 + w.2 • G w.1 - w.2 • G w.1 - _ • (0 : E)
      simp
    · change (0 : ℝ) = g w.1 - γ * w.2 - w.2 * 0 -
        ((g w.1 - γ * w.2) * σ⁻¹) * σ
      simp [hσ]
  exact ⟨by rw [heF]; exact S.sub_mem (S.sub_mem hb0 hξG) hgb, hGl⟩

theorem textbookThermostatLift_iterated_mem_module (F G : E → E) (g : E → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g) (hσ : σ ≠ 0)
    {V : E → E} (hV : textbookIteratedBracket {F, G} V) :
    textbookThermostatLift V ∈ textbookSmoothBracketModule (textbookThermostatSeed F G g γ σ) := by
  have hs : ∀ W ∈ ({F, G} : Set (E → E)), ContDiff ℝ ∞ W := by
    intro W hw
    rcases Set.mem_insert_iff.mp hw with rfl | hw
    · exact hF
    · rcases Set.mem_singleton_iff.mp hw with rfl
      exact hG
  have hlifts := textbookThermostatLift_mem_module F G g γ σ hF hG hg hσ
  induction hV with
  | seed hv =>
    rcases Set.mem_insert_iff.mp hv with rfl | hv
    · exact hlifts.1
    · rcases Set.mem_singleton_iff.mp hv with rfl
      exact hlifts.2
  | bracket hv hw ihv ihw =>
    rw [← textbookThermostatLift_lieBracket _ _
      ((textbookIteratedBracket_contDiff _ hs hv).differentiable (by simp))
      ((textbookIteratedBracket_contDiff _ hs hw).differentiable (by simp))]
    exact textbookSmoothBracketModule_bracket_mem _
      (textbookThermostatSeed_contDiff F G g γ σ hF hG hg) ihv ihw

/-- Proposition8.2 with genuine iterated-bracket spans and explicit nonzero noise. -/
theorem textbookThermostatHormanderLift (F G : E → E) (g : E → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g) (hσ : σ ≠ 0)
    (w : E × ℝ) (hphysical : textbookHormanderAt {F, G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  let s := textbookThermostatSeed F G g γ σ
  let H := textbookBracketPointSpan s w
  let Q := H.comap (LinearMap.inl ℝ E ℝ)
  have hQ : Q = ⊤ := by
    apply top_unique
    rw [← hphysical]
    apply Submodule.span_le.mpr
    rintro _ ⟨V, rfl⟩
    change (V.val w.1, 0) ∈ H
    exact textbookSmoothBracketModule_eval_mem s
      (textbookThermostatLift_iterated_mem_module F G g γ σ hF hG hg hσ V.property) w
  have hhorizontal (v : E) : (v, 0) ∈ H := by
    have hv : v ∈ Q := by rw [hQ]; exact Submodule.mem_top
    exact hv
  have hvertical (a : ℝ) : (0, a) ∈ H := by
    have hn := textbookSmoothBracketModule_eval_mem s
      (smoothBracket_seed_mem s (textbookThermostatNoise σ) (by simp [s, textbookThermostatSeed])) w
    simpa [textbookThermostatNoise, div_eq_mul_inv, hσ] using H.smul_mem (a / σ) hn
  apply top_unique
  intro v _
  simpa using H.add_mem (hhorizontal v.1) (hvertical v.2)

end General

/-- True linear Lie-algebra values lie in the actual derivative-bracket point span. -/
theorem textbookThermostatPhysical_hormander {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase Nc)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {fun x ↦ textbookThermostatF A x, fun x ↦ -(textbookThermostatG Nc x)} z := by
  let s : Set (textbookThermostatPhase Nc → textbookThermostatPhase Nc) :=
    {fun x ↦ textbookThermostatF A x, fun x ↦ -(textbookThermostatG Nc x)}
  let S := textbookSmoothBracketModule s
  have hs : ∀ V ∈ s, ContDiff ℝ ∞ V := by
    intro V hv
    rcases Set.mem_insert_iff.mp hv with rfl | hv
    · exact (LinearMap.toContinuousLinearMap (textbookThermostatF A)).contDiff
    · rcases Set.mem_singleton_iff.mp hv with rfl
      exact (LinearMap.toContinuousLinearMap (textbookThermostatG Nc)).contDiff.neg
  let L : LieSubalgebra ℝ (Module.End ℝ (textbookThermostatPhase Nc)) :=
    { carrier := {X | (fun x ↦ X x) ∈ S}
      zero_mem' := S.zero_mem
      add_mem' := fun hX hY ↦ S.add_mem hX hY
      smul_mem' := fun c _ hX ↦ S.smul_mem c hX
      lie_mem' := by
        intro X Y hX hY
        have hm := textbookSmoothBracketModule_bracket_mem s hs hX hY
        have he : (fun x ↦ ⁅X, Y⁆ x) = -VectorField.lieBracket ℝ (fun x ↦ X x) (fun x ↦ Y x) := by
          funext x
          rw [Pi.neg_apply, textbookThermostatLinearField_lieBracket]
          exact (neg_neg _).symm
        change (fun x ↦ ⁅X, Y⁆ x) ∈ S
        rw [he]
        exact S.neg_mem hm }
  have hLF : textbookThermostatF A ∈ L := smoothBracket_seed_mem s _ (by simp [s])
  have hLG : textbookThermostatG Nc ∈ L := by
    have hn := S.neg_mem (smoothBracket_seed_mem s (fun x ↦ -(textbookThermostatG Nc x)) (by simp [s]))
    have he : (fun x ↦ textbookThermostatG Nc x) = -(fun x ↦ -(textbookThermostatG Nc x)) := by
      funext x
      exact (neg_neg _).symm
    change (fun x ↦ textbookThermostatG Nc x) ∈ S
    rw [he]
    exact hn
  have hL : textbookThermostatLieSpan A ≤ L := LieSubalgebra.lieSpan_le.mpr (by
    intro X hx
    rcases Set.mem_insert_iff.mp hx with rfl | hx
    · exact hLF
    · rcases Set.mem_singleton_iff.mp hx with rfl
      exact hLG)
  apply top_unique
  rw [← textbookThermostatLieSpan_pointwise_span_eq_top A hA hdist z hz]
  apply Submodule.span_le.mpr
  rintro _ ⟨X, rfl⟩
  exact textbookSmoothBracketModule_eval_mem s (hL X.property) z

/-- The actual feedback in (8.32), with theta denoting k_B T and Nd=Nc. -/
noncomputable def textbookNHLFeedback (Nc : ℕ) (μ θ : ℝ) (z : textbookThermostatPhase Nc) : ℝ :=
  μ⁻¹ * ((∑ i : Fin Nc, z.2 i ^ 2) - (Nc : ℝ) * θ)

theorem textbookNHLFeedback_contDiff (Nc : ℕ) (μ θ : ℝ) :
    ContDiff ℝ ∞ (textbookNHLFeedback Nc μ θ) := by
  unfold textbookNHLFeedback
  fun_prop

noncomputable def textbookNHLDrift {Nc : ℕ} (A : Matrix (Fin Nc) (Fin Nc) ℝ)
    (μ θ γ : ℝ) : textbookThermostatPhase Nc × ℝ → textbookThermostatPhase Nc × ℝ :=
  textbookThermostatDrift (fun x ↦ textbookThermostatF A x)
    (fun x ↦ -(textbookThermostatG Nc x)) (textbookNHLFeedback Nc μ θ) γ

theorem textbookNHL_domain_isOpen {Nc : ℕ} {A : Matrix (Fin Nc) (Fin Nc) ℝ}
    (hA : A.IsHermitian) :
    IsOpen (textbookThermostatModeDomain hA ×ˢ (Set.univ : Set ℝ)) :=
  (textbookThermostatModeDomain_isOpen hA).prod isOpen_univ

theorem textbookNHLSeed_contDiff {Nc : ℕ} (A : Matrix (Fin Nc) (Fin Nc) ℝ)
    (μ θ γ σ : ℝ) :
    ∀ V ∈ ({textbookNHLDrift A μ θ γ, textbookThermostatNoise σ} :
      Set (textbookThermostatPhase Nc × ℝ → textbookThermostatPhase Nc × ℝ)),
      ContDiff ℝ ∞ V :=
  textbookThermostatSeed_contDiff _ _ _ γ σ
    (LinearMap.toContinuousLinearMap (textbookThermostatF A)).contDiff
    (LinearMap.toContinuousLinearMap (textbookThermostatG Nc)).contDiff.neg
    (textbookNHLFeedback_contDiff Nc μ θ)

theorem textbookNHLDrift_apply {Nc : ℕ} (A : Matrix (Fin Nc) (Fin Nc) ℝ)
    (μ θ γ : ℝ) (w : textbookThermostatPhase Nc × ℝ) :
    textbookNHLDrift A μ θ γ w =
      ((w.1.2, -(A *ᵥ w.1.1) - w.2 • w.1.2), textbookNHLFeedback Nc μ θ w.1 - γ * w.2) := by
  apply Prod.ext
  · apply Prod.ext
    · change w.1.2 + w.2 • (-(0 : Fin Nc → ℝ)) = w.1.2
      simp
    · change -(A *ᵥ w.1.1) + w.2 • (-w.1.2) = -(A *ᵥ w.1.1) - w.2 • w.1.2
      simp [sub_eq_add_neg]
  · rfl

/-- Theorem8.1 for the actual NHL fields, with the necessary noise condition explicit. -/
theorem textbookNHL_hormander {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (μ θ γ σ : ℝ) (hσ : σ ≠ 0)
    (w : textbookThermostatPhase Nc × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A μ θ γ, textbookThermostatNoise σ} w :=
  textbookThermostatHormanderLift _ _ _ γ σ
    (LinearMap.toContinuousLinearMap (textbookThermostatF A)).contDiff
    (LinearMap.toContinuousLinearMap (textbookThermostatG Nc)).contDiff.neg
    (textbookNHLFeedback_contDiff Nc μ θ) hσ w (textbookThermostatPhysical_hormander A hA hdist w.1 hw)

/-- Original physical noise amplitude from positive temperature, friction and thermal inertia. -/
theorem textbookNHL_hormander_physicalNoise {Nc : ℕ}
    (A : Matrix (Fin Nc) (Fin Nc) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (μ θ γ : ℝ)
    (hμ : 0 < μ) (hθ : 0 < θ) (hγ : 0 < γ)
    (w : textbookThermostatPhase Nc × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt
      {textbookNHLDrift A μ θ γ, textbookThermostatNoise (Real.sqrt (2 * θ * γ * μ⁻¹))} w := by
  apply textbookNHL_hormander A hA hdist μ θ γ _ _ w hw
  exact ne_of_gt (Real.sqrt_pos.mpr (mul_pos (mul_pos (mul_pos (by norm_num) hθ) hγ) (inv_pos.mpr hμ)))

end MolecularDynamics
