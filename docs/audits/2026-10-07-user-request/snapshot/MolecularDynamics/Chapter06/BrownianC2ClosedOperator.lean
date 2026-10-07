import MolecularDynamics.Chapter06.BrownianC2DynkinFormula
import MolecularDynamics.Chapter06.BrownianPotentialSelfAdjoint

/-! Necessary original C2 Gibbs integration by parts and closed-generator
domain identification, using genuine fluxes and the accepted self-adjoint closure. -/

open Set MeasureTheory Filter Topology
open scoped Topology ContDiff InnerProductSpace BigOperators LinearPMap NNReal ENNReal ProbabilityTheory

namespace MolecularDynamics
noncomputable section

private theorem c1_partial_contDiff_zero {N : ℕ}
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 1 f) (i : Fin N) :
    ContDiff ℝ 0 (textbookConfigurationPartial f i) :=
  (hf.fderiv_right (by norm_num)).clm_apply contDiff_const

private theorem c2_partial_contDiff_one {N : ℕ}
    (f : (Fin N → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (i : Fin N) :
    ContDiff ℝ 1 (textbookConfigurationPartial f i) :=
  (hf.fderiv_right (by norm_num)).clm_apply contDiff_const

private theorem c2_partial_periodic {N : ℕ}
    (f : (Fin N → ℝ) → ℝ) (hp : textbookUnitPeriodicPotential f) (i : Fin N) :
    textbookUnitPeriodicPotential (textbookConfigurationPartial f i) := by
  intro q n
  have hh := congrArg (fun L ↦ L (fun _ : Fin 1 ↦ Pi.single i 1))
    (textbookUnitPeriodicObservable_iteratedFDeriv_periodic f hp 1 q n)
  simpa only [iteratedFDeriv_one_apply, textbookConfigurationPartial] using hh

private theorem partial_mul {Nc : ℕ} (f g : (Fin Nc → ℝ) → ℝ)
    (hf : ContDiff ℝ 1 f) (hg : ContDiff ℝ 1 g) (i : Fin Nc) (q : Fin Nc → ℝ) :
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
    (hf : ContDiff ℝ 1 f) (c : ℝ) (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (fun x ↦ c * f x) i q =
      c * textbookConfigurationPartial f i q := by
  have h := ((hf.differentiable (by simp) q).hasFDerivAt).const_mul c
  unfold textbookConfigurationPartial
  rw [h.fderiv]
  simp only [_root_.smul_apply, smul_eq_mul]

/-- The true periodic boundary values cancel in the full finite-dimensional divergence theorem. -/
theorem textbookConfigurationCube_C1integral_divergence_eq_zero {Nc : ℕ}
    (F : Fin Nc → (Fin Nc → ℝ) → ℝ)
    (hF : ∀ i, ContDiff ℝ 1 (F i))
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
        (c1_partial_contDiff_zero (F i) (hF i) i).continuous).continuousOn
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

/-- The actual product flux is smooth. -/
theorem textbookBrownianC2WeightedFlux_contDiff_one {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (i : Fin Nc) : ContDiff ℝ 1 (textbookBrownianWeightedFlux m U β f g i) := by
  exact contDiff_const.mul (((hf.of_le (by norm_num)).mul
    (c2_partial_contDiff_one g hg i)).mul
      ((textbookConfigurationGibbsWeight_contDiff U hU β).of_le (by simp)))

/-- The product flux really agrees on opposite faces by the original periodicity. -/
theorem textbookBrownianC2WeightedFlux_periodic {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) (i : Fin Nc) :
    textbookUnitPeriodicPotential (textbookBrownianWeightedFlux m U β f g i) := by
  intro q n
  simp only [textbookBrownianWeightedFlux, hPf q n,
    c2_partial_periodic g hPg i q n,
    textbookConfigurationGibbsWeight_periodic U hPU β q n]

/-- Literal differentiation of the weighted flux, without an integration identity premise. -/
theorem textbookBrownianC2WeightedFlux_partial {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (i : Fin Nc) (q : Fin Nc → ℝ) :
    textbookConfigurationPartial (textbookBrownianWeightedFlux m U β f g i) i q =
      (m i)⁻¹ * ((textbookConfigurationPartial f i q * textbookConfigurationPartial g i q +
        f q * textbookConfigurationPartial (textbookConfigurationPartial g i) i q -
        β * f q * textbookConfigurationPartial g i q * textbookConfigurationPartial U i q) *
          textbookConfigurationGibbsWeight U β q) := by
  have hgi := c2_partial_contDiff_one g hg i
  have hρ : ContDiff ℝ 1 (textbookConfigurationGibbsWeight U β) := (textbookConfigurationGibbsWeight_contDiff U hU β).of_le (by simp)
  unfold textbookBrownianWeightedFlux
  rw [partial_const_mul _ (((hf.of_le (by norm_num)).mul hgi).mul hρ),
    partial_mul _ _ ((hf.of_le (by norm_num)).mul hgi) hρ, partial_mul _ _ (hf.of_le (by norm_num)) hgi,
    textbookConfigurationGibbsWeight_partial U hU β]
  ring

/-- The true flux divergence equals the actual generator and Dirichlet energy density. -/
theorem textbookBrownianC2WeightedFlux_divergence {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (q : Fin Nc → ℝ) :
    (∑ i, textbookConfigurationPartial (textbookBrownianWeightedFlux m U β f g i) i q) =
      (textbookConfigurationGradientPair m f g q +
        β * f q * textbookBrownianGenerator m U β g q) *
          textbookConfigurationGibbsWeight U β q := by
  unfold textbookConfigurationGradientPair textbookBrownianGenerator
  simp only [Finset.mul_sum, Finset.sum_mul, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  rw [textbookBrownianC2WeightedFlux_partial m U β f g hU hf hg]
  generalize (m i)⁻¹ = a
  field_simp [hβ]
  ring

/-- The actual smooth periodic Brownian generator has the full mass-weighted Gibbs Dirichlet identity. -/
theorem textbookBrownianC2Generator_integral_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  have hρ := (textbookConfigurationGibbsWeight_contDiff U hU β).continuous
  have hG : Continuous (textbookConfigurationGradientPair m f g) := by
    exact continuous_finsetSum _ fun i _ ↦ (continuous_const.mul
      (c2_partial_contDiff_one f hf i).continuous).mul
        (c2_partial_contDiff_one g hg i).continuous
  have hL : Continuous (textbookBrownianGenerator m U β g) := textbookBrownianC2Generator_continuous m U β g hU hg
  have hGI : IntegrableOn (fun q ↦ textbookConfigurationGradientPair m f g q *
      textbookConfigurationGibbsWeight U β q) (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc (hG.mul hρ).continuousOn
  have hLI : IntegrableOn (fun q ↦ f q * textbookBrownianGenerator m U β g q *
      textbookConfigurationGibbsWeight U β q) (textbookConfigurationCube Nc) :=
    ContinuousOn.integrableOn_compact isCompact_Icc
    ((hf.continuous.mul hL).mul hρ).continuousOn
  have hz := textbookConfigurationCube_C1integral_divergence_eq_zero
    (textbookBrownianWeightedFlux m U β f g)
    (textbookBrownianC2WeightedFlux_contDiff_one m U β f g hU hf hg)
    (textbookBrownianC2WeightedFlux_periodic m U β f g hPU hPf hPg)
  simp_rw [textbookBrownianC2WeightedFlux_divergence m U β hβ f g hU hf hg] at hz
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


/-- The actual normalized weighted Dirichlet identity for smooth periodic observables. -/
theorem textbookBrownianC2Generator_inner_dirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    textbookConfigurationInner U β f (textbookBrownianGenerator m U β g) =
      -β⁻¹ * (textbookConfigurationPartition U β)⁻¹ *
        ∫ q in textbookConfigurationCube Nc,
          textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  unfold textbookConfigurationInner
  rw [textbookBrownianC2Generator_integral_dirichlet m U β hβ f g hU hf hg hPU hPf hPg]
  ring

/-- Genuine weighted symmetry on periodic smooth tests; no closed self-adjoint operator is claimed here. -/
theorem textbookBrownianC2Generator_inner_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
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
  rw [hswap, textbookBrownianC2Generator_inner_dirichlet m U β hβ f g hU hf hg hPU hPf hPg,
    textbookBrownianC2Generator_inner_dirichlet m U β hβ g f hU hg hf hPU hPg hPf, hpair]



/-- True original C2 integration by parts gives symmetry of the genuine original Gibbs L2 generator images. -/
theorem textbookBrownianC2GibbsL2GeneratorImage_symmetric {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hg : ContDiff ℝ 2 g)
    (hpf : textbookUnitPeriodicPotential f) (hpg : textbookUnitPeriodicPotential g) :
    ⟪textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf,
      textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β g hg hpg⟫_ℝ =
    ⟪textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf,
      textbookConfigurationGibbsL2Observable U hU hPU β g hg.continuous hpg⟫_ℝ := by
  unfold textbookBrownianC2GibbsL2GeneratorImage
  rw [textbookConfigurationGibbsL2Observable_inner, textbookConfigurationGibbsL2Observable_inner]
  exact textbookBrownianC2Generator_inner_symmetric m U β hβ f g hU hf hg hPU hpf hpg

variable {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : β ≠ 0)
    (f : (Fin Nc → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (hpf : textbookUnitPeriodicPotential f)

include hβ in
/-- True C2 pairing, actual graph closure continuity and the already proved self-adjoint closure identify the original C2 graph pair. -/
theorem textbookBrownianGibbsClosedOperator_C2graph :
    (textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf,
      textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf) ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).graph := by
  let H := Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β)
  let A := textbookBrownianGibbsClosedOperator m U hU hPU β
  let T := textbookBrownianGibbsPartialOperator m U hU hPU β
  let F := textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf
  let G := textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf
  have hcore (a : T.domain) : ⟪G, (a : H)⟫_ℝ = ⟪F, T a⟫_ℝ := by
    change ⟪G, (a : H)⟫_ℝ = ⟪F, textbookBrownianGibbsDomainOperator m U hU hPU β a⟫_ℝ
    obtain ⟨g, rfl⟩ := (textbookPeriodicSmoothEmbeddingEquiv U hU hPU β).surjective a
    rw [textbookPeriodicSmoothEmbeddingEquiv_coe, textbookBrownianGibbsDomainOperator_apply_equiv]
    change ⟪G, textbookConfigurationGibbsL2Observable U hU hPU β g g.prop.1.continuous g.prop.2⟫_ℝ =
      ⟪F, textbookBrownianGibbsL2Image m U hU hPU β g g.prop.1 g.prop.2⟫_ℝ
    simpa only [F, G, textbookBrownianC2GibbsL2GeneratorImage, textbookBrownianGibbsL2Image] using
      (textbookBrownianC2GibbsL2GeneratorImage_symmetric m U hU hPU β hβ f g
        hf (g.prop.1.of_le (by simp)) hpf g.prop.2).symm
  let Z : Set (H × H) := {p | ⟪G, p.1⟫_ℝ = ⟪F, p.2⟫_ℝ}
  have hZ : IsClosed Z := isClosed_eq (by fun_prop) (by fun_prop)
  have hsub : (T.graph : Set (H × H)) ⊆ Z := by
    intro p hp
    obtain ⟨a, ha, hTa⟩ := (LinearPMap.mem_graph_iff T).mp hp
    change ⟪G, p.1⟫_ℝ = ⟪F, p.2⟫_ℝ
    rw [← ha, ← hTa]
    exact hcore a
  have hcl : closure (T.graph : Set (H × H)) ⊆ Z := closure_minimal hsub hZ
  have htransport (a : A.domain) : ⟪G, (a : H)⟫_ℝ = ⟪F, A a⟫_ℝ := by
    have hpa : ((a : H), A a) ∈ T.graph.topologicalClosure := by
      change ((a : H), A a) ∈ (textbookBrownianGibbsPartialOperator m U hU hPU β).graph.topologicalClosure
      rw [textbookBrownianGibbsClosedOperator_graph m U hU hPU β hβ]
      exact A.mem_graph a
    change ((a : H), A a) ∈ closure (T.graph : Set (H × H)) at hpa
    exact hcl hpa
  have hdom : F ∈ A†.domain := LinearPMap.mem_adjoint_domain_of_exists F ⟨G, htransport⟩
  let a : A†.domain := ⟨F, hdom⟩
  have hAa : A† a = G := LinearPMap.adjoint_apply_eq
    (textbookBrownianGibbsClosedOperator_dense m U hU hPU β) a htransport
  have h := A†.mem_graph a
  rw [hAa] at h
  have hself : A† = A := LinearPMap.isSelfAdjoint_def.mp
    (textbookBrownianGibbsClosedOperator_isSelfAdjoint m U hU hPU β hβ)
  change (F, G) ∈ A.graph
  simpa only [hself] using h

include hβ in
/-- Every actual original C2 periodic observable genuinely lies in the constructed closed Gibbs generator domain. -/
theorem textbookBrownianGibbsClosedOperator_C2mem_domain :
    textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf ∈
      (textbookBrownianGibbsClosedOperator m U hU hPU β).domain :=
  LinearPMap.mem_domain_iff.mpr
    ⟨textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf,
      textbookBrownianGibbsClosedOperator_C2graph m U hU hPU β hβ f hf hpf⟩

include hβ in
/-- The actual closed Gibbs generator value on the proved original C2 domain element is exactly the literal original differential image. -/
theorem textbookBrownianGibbsClosedOperator_C2apply :
    textbookBrownianGibbsClosedOperator m U hU hPU β
      ⟨textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf,
        textbookBrownianGibbsClosedOperator_C2mem_domain m U hU hPU β hβ f hf hpf⟩ =
      textbookBrownianC2GibbsL2GeneratorImage m U hU hPU β f hf hpf := by
  obtain ⟨a, ha, hAa⟩ := (LinearPMap.mem_graph_iff _).mp
    (textbookBrownianGibbsClosedOperator_C2graph m U hU hPU β hβ f hf hpf)
  have he : a = ⟨textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf,
      textbookBrownianGibbsClosedOperator_C2mem_domain m U hU hPU β hβ f hf hpf⟩ := Subtype.ext ha
  simpa only [he] using hAa

/-- On every original C2 observable, the same actual probability strong Gibbs L2 generator limit is exactly the value of the genuine closed Gibbs realization. -/
theorem textbookBrownianProbabilityGibbsL2Image_C2closed_original_generator_tendsto
    (hm : ∀ i, 0 < m i) (hβpos : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
    Tendsto (fun t : ℝ ↦ t⁻¹ •
      (textbookBrownianProbabilityGibbsL2Image U hU hPU β m hm hβpos B P hB t.toNNReal
        (textbookConfigurationContinuousObservable f hf.continuous hpf) -
       textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf))
      (𝓝[>] 0) (𝓝 (textbookBrownianGibbsClosedOperator m U hU hPU β
        ⟨textbookConfigurationGibbsL2Observable U hU hPU β f hf.continuous hpf,
          textbookBrownianGibbsClosedOperator_C2mem_domain m U hU hPU β hβpos.ne' f hf hpf⟩)) := by
  rw [textbookBrownianGibbsClosedOperator_C2apply m U hU hPU β hβpos.ne' f hf hpf]
  exact textbookBrownianProbabilityGibbsL2Image_C2original_generator_tendsto m hm U hU hPU β hβpos B P hB f hf hpf


/-- The actual real continuous torus functions whose Euclidean lifts have exactly the original C2 regularity. -/
def textbookC2TorusRealSpace (N : ℕ) : Submodule ℝ C(UnitAddTorus (Fin N), ℝ) where
  carrier := {g | ContDiff ℝ 2 (fun q : Fin N → ℝ ↦ g (textbookConfigurationTorusProjection q))}
  zero_mem' := by
    change ContDiff ℝ 2 (fun _ : Fin N → ℝ ↦ (0 : ℝ))
    exact contDiff_const
  add_mem' := by
    intro g k hg hk
    change ContDiff ℝ 2 (fun q : Fin N → ℝ ↦ g (textbookConfigurationTorusProjection q)) at hg
    change ContDiff ℝ 2 (fun q : Fin N → ℝ ↦ k (textbookConfigurationTorusProjection q)) at hk
    change ContDiff ℝ 2 (fun q : Fin N → ℝ ↦ g (textbookConfigurationTorusProjection q) + k (textbookConfigurationTorusProjection q))
    exact hg.add hk
  smul_mem' := by
    intro c g hg
    change ContDiff ℝ 2 (fun q : Fin N → ℝ ↦ g (textbookConfigurationTorusProjection q)) at hg
    change ContDiff ℝ 2 (fun q : Fin N → ℝ ↦ c • g (textbookConfigurationTorusProjection q))
    exact hg.const_smul c

/-- The genuine original C2 torus observables embedded in the same original Gibbs L2, as an actual linear subspace. -/
def textbookBrownianGibbsC2Domain {N : ℕ}
    (V : (Fin N → ℝ) → ℝ) (hV : ContDiff ℝ ∞ V)
    (hPV : textbookUnitPeriodicPotential V) (b : ℝ) :
    Submodule ℝ (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure V b)) :=
  (textbookC2TorusRealSpace N).map (textbookGibbsContinuousToLp V hV hPV b).toLinearMap

/-- Every original C2 integer-periodic lift belongs to the genuine same-Gibbs C2 domain. -/
theorem textbookBrownianGibbsC2Domain_original_observable_mem {N : ℕ}
    (V : (Fin N → ℝ) → ℝ) (hV : ContDiff ℝ ∞ V)
    (hPV : textbookUnitPeriodicPotential V) (b : ℝ)
    (g : (Fin N → ℝ) → ℝ) (hg : ContDiff ℝ 2 g) (hpg : textbookUnitPeriodicPotential g) :
    textbookConfigurationGibbsL2Observable V hV hPV b g hg.continuous hpg ∈
      textbookBrownianGibbsC2Domain V hV hPV b := by
  apply Submodule.mem_map.mpr
  refine ⟨textbookConfigurationContinuousObservable g hg.continuous hpg, ?_, ?_⟩
  · change ContDiff ℝ 2 (fun q : Fin N → ℝ ↦
      textbookConfigurationContinuousObservable g hg.continuous hpg (textbookConfigurationTorusProjection q))
    have he : (fun q : Fin N → ℝ ↦
        textbookConfigurationContinuousObservable g hg.continuous hpg (textbookConfigurationTorusProjection q)) = g :=
      funext (fun q ↦ textbookConfigurationTorusObservable_lift g hpg q)
    rw [he]
    exact hg
  · exact textbookGibbsContinuousToLp_original_observable V hV hPV b g hg.continuous hpg

/-- The whole genuine original C2 Gibbs subspace lies in the true closed-generator domain, using the proved C2 graph identity. -/
theorem textbookBrownianGibbsC2Domain_le_closed_domain {N : ℕ} (m0 : Fin N → ℝ)
    (V : (Fin N → ℝ) → ℝ) (hV : ContDiff ℝ ∞ V)
    (hPV : textbookUnitPeriodicPotential V) (b : ℝ) (hb : b ≠ 0) :
    textbookBrownianGibbsC2Domain V hV hPV b ≤
      (textbookBrownianGibbsClosedOperator m0 V hV hPV b).domain := by
  intro x hx
  change x ∈ (textbookC2TorusRealSpace N).map (textbookGibbsContinuousToLp V hV hPV b).toLinearMap at hx
  obtain ⟨g, hg, rfl⟩ := Submodule.mem_map.mp hx
  let u : (Fin N → ℝ) → ℝ := fun q ↦ g (textbookConfigurationTorusProjection q)
  have hu : ContDiff ℝ 2 u := hg
  have hpu : textbookUnitPeriodicPotential u := by
    intro q n
    change g (textbookConfigurationTorusProjection (q + fun i ↦ (n i : ℝ))) = g (textbookConfigurationTorusProjection q)
    rw [textbookConfigurationTorusProjection_integer_translate]
  have he : textbookConfigurationContinuousObservable u hu.continuous hpu = g := by
    ext X
    change g (textbookConfigurationTorusProjection (textbookConfigurationTorusRepresentative X)) = g X
    rw [textbookConfigurationTorusRepresentative_projects]
  change textbookGibbsContinuousToLp V hV hPV b g ∈ _
  rw [← he, textbookGibbsContinuousToLp_original_observable]
  exact textbookBrownianGibbsClosedOperator_C2mem_domain m0 V hV hPV b hb u hu hpu

/-- The accepted full smooth Gibbs domain is contained in the genuine original C2 Gibbs domain. -/
theorem textbookBrownianGibbsSmoothDomain_le_C2Domain {N : ℕ}
    (V : (Fin N → ℝ) → ℝ) (hV : ContDiff ℝ ∞ V)
    (hPV : textbookUnitPeriodicPotential V) (b : ℝ) :
    textbookBrownianGibbsSmoothDomain V hV hPV b ≤ textbookBrownianGibbsC2Domain V hV hPV b := by
  intro x hx
  change ∃ g : textbookPeriodicSmoothSpace N, textbookPeriodicSmoothEmbedding V hV hPV b g = x at hx
  obtain ⟨g, rfl⟩ := hx
  change textbookConfigurationGibbsL2Observable V hV hPV b g g.prop.1.continuous g.prop.2 ∈ _
  exact textbookBrownianGibbsC2Domain_original_observable_mem V hV hPV b g (g.prop.1.of_le (by simp)) g.prop.2

/-- The actual original C2 Gibbs domain is genuinely dense in the original weighted Hilbert space. -/
theorem textbookBrownianGibbsC2Domain_dense {N : ℕ}
    (V : (Fin N → ℝ) → ℝ) (hV : ContDiff ℝ ∞ V)
    (hPV : textbookUnitPeriodicPotential V) (b : ℝ) :
    Dense (textbookBrownianGibbsC2Domain V hV hPV b :
      Set (Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure V b))) :=
  (textbookBrownianGibbsSmoothDomain_dense V hV hPV b).mono
    (textbookBrownianGibbsSmoothDomain_le_C2Domain V hV hPV b)

/-- The whole genuine original C2 Gibbs domain is a true graph core of the already constructed original closed generator. -/
theorem textbookBrownianGibbsClosedOperator_hasCore_C2 {N : ℕ} (m0 : Fin N → ℝ)
    (V : (Fin N → ℝ) → ℝ) (hV : ContDiff ℝ ∞ V)
    (hPV : textbookUnitPeriodicPotential V) (b : ℝ) (hb : b ≠ 0) :
    (textbookBrownianGibbsClosedOperator m0 V hV hPV b).HasCore
      (textbookBrownianGibbsC2Domain V hV hPV b) := by
  let H := Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure V b)
  let A := textbookBrownianGibbsClosedOperator m0 V hV hPV b
  let D := textbookBrownianGibbsC2Domain V hV hPV b
  let T := textbookBrownianGibbsPartialOperator m0 V hV hPV b
  let R := A.domRestrict D
  have hd : D ≤ A.domain := textbookBrownianGibbsC2Domain_le_closed_domain m0 V hV hPV b hb
  have hTd : T.domain ≤ D := textbookBrownianGibbsSmoothDomain_le_C2Domain V hV hPV b
  have hTA : T ≤ A := textbookBrownianGibbsPartialOperator_le_closed m0 V hV hPV b
  have hTR : T ≤ R := by
    refine ⟨fun x hx ↦ ⟨hTd hx, hTA.1 hx⟩, ?_⟩
    intro y z he
    let w : A.domain := ⟨(y : H), hTA.1 y.prop⟩
    exact (hTA.2 (show (y : H) = (w : H) from rfl)).trans
      (LinearPMap.domRestrict_apply (show (z : H) = (w : H) from he.symm)).symm
  have hRA : R ≤ A := LinearPMap.domRestrict_le
  have hA : A.IsClosed := textbookBrownianGibbsClosedOperator_isClosed m0 V hV hPV b hb
  have hRc : R.IsClosable := hA.isClosable.leIsClosable hRA
  have hlow : A ≤ R.closure := textbookBrownianGibbsClosedOperator_le_extension m0 V hV hPV b
    R.closure hRc.closure_isClosed (hTR.trans R.le_closure)
  have heA : A.closure = A := LinearPMap.eq_of_eq_graph
    (hA.isClosable.graph_closure_eq_closure_graph.symm.trans hA.submodule_topologicalClosure_eq)
  have hup : R.closure ≤ A := heA ▸ hA.isClosable.closure_mono hRA
  exact ⟨hd, le_antisymm hup hlow⟩

end
end MolecularDynamics
