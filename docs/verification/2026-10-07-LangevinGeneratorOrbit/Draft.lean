import MolecularDynamics.Chapter06.LangevinCompactC2Domain

/-! Actual generator-domain invariance and norm evolution for original Langevin6.47.
All orbit statements use the same original C0 transition and its genuine generator. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped Topology ContDiff NNReal ENNReal ZeroAtInfty

namespace MolecularDynamics
noncomputable section

variable {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
  (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
  (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
  (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (hγ : 0 < γ)

local notation "E" => C₀(textbookLangevinPeriodicPhase N, ℝ)
local notation "S" => textbookLangevinPeriodicC0Transition B P hB U hU hp L hF γ σ hγ
local notation "A" => textbookLangevinPeriodicC0Generator B P hB U hU hp L hF γ σ hγ
local notation "G" => textbookLangevinPeriodicC0GeneratorGraph B P hB U hU hp L hF γ σ hγ

/-- Actual Chapman-Kolmogorov and the bounded transition map propagate the
genuine right norm derivative graph, including time zero. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_transition (f g : E)
    (hg : (f, g) ∈ G) (T : ℝ≥0) : (S T f, S T g) ∈ G := by
  change HasDerivWithinAt (fun t : ℝ ↦ S t.toNNReal f) g (Ici 0) 0 at hg
  have hcl := (S T).hasFDerivAt.comp_hasDerivWithinAt 0 hg
  have hd : HasDerivWithinAt (fun s : ℝ ↦ S T (S s.toNNReal f))
      (S T g) (Ici 0) 0 := by
    simpa only [Function.comp_apply] using! hcl
  change HasDerivWithinAt (fun s : ℝ ↦ S s.toNNReal (S T f)) (S T g) (Ici 0) 0
  apply hd.congr_of_mem _ (mem_Ici.mpr le_rfl)
  intro s _
  calc
    S s.toNNReal (S T f) = S (s.toNNReal + T) f := by
      rw [textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ,
        ContinuousLinearMap.comp_apply]
    _ = S (T + s.toNNReal) f := by rw [add_comm]
    _ = S T (S s.toNNReal f) := by
      rw [textbookLangevinPeriodicC0Transition_add B P hB U hU hp L hF γ σ hγ,
        ContinuousLinearMap.comp_apply]

/-- Every actual generator-domain element stays in that same domain under
the original semigroup. No later-time classical smoothness is assumed. -/
theorem textbookLangevinPeriodicC0Generator_transition_mem_domain
    (f : E) (hf : f ∈ (A).domain) (T : ℝ≥0) : S T f ∈ (A).domain := by
  have hg := (A).mem_graph ⟨f, hf⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ] at hg
  apply LinearPMap.mem_domain_iff.mpr
  refine ⟨S T (A ⟨f, hf⟩), ?_⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ]
  exact textbookLangevinPeriodicC0GeneratorGraph_transition B P hB U hU hp L hF γ σ hγ f _ hg T

/-- The actual closed generator commutes with the original transition on
its derived domain: A(S_T f) = S_T(A f). -/
theorem textbookLangevinPeriodicC0Generator_transition_apply
    (f : E) (hf : f ∈ (A).domain) (T : ℝ≥0) :
    A ⟨S T f, textbookLangevinPeriodicC0Generator_transition_mem_domain
      B P hB U hU hp L hF γ σ hγ f hf T⟩ = S T (A ⟨f, hf⟩) := by
  have hfg := (A).mem_graph ⟨f, hf⟩
  have hTg := (A).mem_graph ⟨S T f, textbookLangevinPeriodicC0Generator_transition_mem_domain
    B P hB U hU hp L hF γ σ hγ f hf T⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ] at hfg hTg
  exact textbookLangevinPeriodicC0GeneratorGraph_unique B P hB U hU hp L hF γ σ hγ
    (S T f) _ _ hTg
    (textbookLangevinPeriodicC0GeneratorGraph_transition B P hB U hU hp L hF γ σ hγ f _ hfg T)

/-- The actual integrated identity and vector FTC give the full two-sided
norm derivative at every positive time, with the propagated graph image. -/
theorem textbookLangevinPeriodicC0GeneratorGraph_orbit_hasDerivAt
    (f g : E) (hg : (f, g) ∈ G) (t : ℝ) (ht : 0 < t) :
    HasDerivAt (fun s : ℝ ↦ S s.toNNReal f) (S t.toNNReal g) t := by
  have hc : Continuous (fun s : ℝ ↦ S s.toNNReal g) :=
    (textbookLangevinPeriodicC0Transition_strong_continuous B P hB U hU hp L hF γ σ hγ g).comp
      continuous_real_toNNReal
  have hd := (hc.integral_hasStrictDerivAt 0 t).hasDerivAt.add_const f
  apply hd.congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds ht] with s hs
  have he := (textbookLangevinPeriodicC0GeneratorGraph_integrated_iff
    B P hB U hU hp L hF γ σ hγ f g).mp hg s.toNNReal
  rw [Real.coe_toNNReal s hs.le] at he
  exact eq_add_of_sub_eq he.symm

/-- Every actual domain element has a norm-differentiable original orbit
at positive times, whose derivative is S_t(A f). -/
theorem textbookLangevinPeriodicC0Generator_orbit_hasDerivAt
    (f : E) (hf : f ∈ (A).domain) (t : ℝ) (ht : 0 < t) :
    HasDerivAt (fun s : ℝ ↦ S s.toNNReal f) (S t.toNNReal (A ⟨f, hf⟩)) t := by
  have hg := (A).mem_graph ⟨f, hf⟩
  rw [textbookLangevinPeriodicC0Generator_graph B P hB U hU hp L hF γ σ hγ] at hg
  exact textbookLangevinPeriodicC0GeneratorGraph_orbit_hasDerivAt
    B P hB U hU hp L hF γ σ hγ f _ hg t ht

variable (F : textbookLangevinPeriodicPhase N → ℝ)
  (hG : ContDiff ℝ 2 (F ∘ textbookLangevinPeriodicProjection)) (hcs : HasCompactSupport F)

local notation "f" => textbookLangevinPeriodicCompactC2Observable F hG hcs
local notation "g" => textbookLangevinPeriodicCompactC2DifferentialImage U hU hp γ σ F hG hcs

/-- Original compact periodic C2 tests evolve inside the actual closed
generator domain, without assuming that their evolved functions are C2. -/
theorem textbookLangevinPeriodicCompactC2_transition_mem_generator_domain (T : ℝ≥0) :
    S T f ∈ (A).domain :=
  textbookLangevinPeriodicC0Generator_transition_mem_domain B P hB U hU hp L hF γ σ hγ f
    (textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hF γ σ hγ F hG hcs) T

/-- For original compact C2 data, the actual generator of the evolved
observable equals the semigroup applied to the existing differential image. -/
theorem textbookLangevinPeriodicC0Generator_compactC2_transition_apply (T : ℝ≥0) :
    A ⟨S T f, textbookLangevinPeriodicCompactC2_transition_mem_generator_domain
      B P hB U hU hp L hF γ σ hγ F hG hcs T⟩ = S T g := by
  have he := textbookLangevinPeriodicC0Generator_transition_apply
    B P hB U hU hp L hF γ σ hγ f
    (textbookLangevinPeriodicCompactC2_mem_generator_domain B P hB U hU hp L hF γ σ hγ F hG hcs) T
  rw [textbookLangevinPeriodicC0Generator_compactC2_apply B P hB U hU hp L hF γ σ hγ F hG hcs] at he
  exact he

/-- The original compact C2 observable solves the actual norm evolution
equation at positive times, with derivative S_t of its textbook differential
image. This does not assert classical regularity of the evolved function. -/
theorem textbookLangevinPeriodicC0Transition_compactC2_orbit_hasDerivAt
    (t : ℝ) (ht : 0 < t) :
    HasDerivAt (fun s : ℝ ↦ S s.toNNReal f) (S t.toNNReal g) t := by
  exact textbookLangevinPeriodicC0GeneratorGraph_orbit_hasDerivAt
    B P hB U hU hp L hF γ σ hγ f g
    (textbookLangevinPeriodicCompactC2_mem_generator_graph B P hB U hU hp L hF γ σ hγ F hG hcs) t ht

end
end MolecularDynamics
