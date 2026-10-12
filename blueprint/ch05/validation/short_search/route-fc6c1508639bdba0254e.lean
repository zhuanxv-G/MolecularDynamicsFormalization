import MolecularDynamics.Chapter05.ReviewProofs
import Mathlib.MeasureTheory.Function.LpSpace.Indicator
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform
import Mathlib.Tactic
open Set Filter Matrix MeasureTheory MolecularDynamics MolecularDynamics.Chapter05Review
open scoped BigOperators Topology ContDiff InnerProductSpace ENNReal
noncomputable section
set_option maxHeartbeats 500000
namespace MD.Ch05Short
variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)

theorem trajectoryChain (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption

def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t

def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)

theorem steadyFirstIntegral :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → Differentiable ℝ g → ((∀ z,MolecularDynamics.Chapter05Review.lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z) := by
  intro n f Φ g hflow hg
  constructor
  · intro hz t z
    have ht : ∀ s : ℝ,HasDerivAt (fun u => g (Φ u z)) 0 s := by
      intro s
      have hc := (hg (Φ s z)).hasFDerivAt.comp_hasDerivAt s (hflow.2.2 s z)
      change HasDerivAt (fun u => g (Φ u z)) (MolecularDynamics.Chapter05Review.lie f g (Φ s z)) s at hc
      rw [hz] at hc
      exact hc
    have hh := is_const_of_deriv_eq_zero (fun s => (ht s).differentiableAt) (fun s => (ht s).deriv)
    simpa only [hflow.1] using hh t 0
  · intro hh z
    have hd := (hg (Φ 0 z)).hasFDerivAt.comp_hasDerivAt 0 (hflow.2.2 0 z)
    have heq : (fun s => g (Φ s z))=(fun _ : ℝ => g z) := funext (fun s => hh s z)
    simp only [Function.comp_def] at hd
    rw [heq] at hd
    simpa only [MolecularDynamics.Chapter05Review.lie,hflow.1] using
      hd.unique (hasDerivAt_const 0 (g z))

theorem coordinatePullback {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (t : ℝ) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n) :
    MolecularDynamics.Chapter05Review.pullback Φ (fun x => x i) t z=Φ t z i := by
  apply MolecularDynamics.Chapter05Review.coordinatePullback_proved <;> assumption

def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := MolecularDynamics.Chapter05Review.pullback Φ g t

theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i := by
  intro n f z i
  change (fderiv ℝ (fun x : MolecularDynamics.Chapter05Review.E n => x i) z) (f z)=f z i
  change (fderiv ℝ (PiLp.proj 2 (fun _ : Fin n => ℝ) i : MolecularDynamics.Chapter05Review.E n →L[ℝ] ℝ) z) (f z)=f z i
  rw [ContinuousLinearMap.fderiv]
  rfl

def densityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  NullMeasurableSet D volume ∧ AEMeasurable ρ (volume.restrict D) ∧
    (∀ z ∈ D,0 ≤ ρ z) ∧ IntegrableOn ρ D

def probabilityDensityOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  densityOn D ρ ∧ (∫ z in D,ρ z)=1

theorem densityOnNormalization : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityOn D ρ → 0 < (∫ z in D,ρ z) →
    probabilityDensityOn D (fun z => ρ z/(∫ x in D,ρ x)) := by
  intro n D ρ hd hp
  refine ⟨⟨hd.1,hd.2.1.div_const _,?_,hd.2.2.2.div_const _⟩,?_⟩
  · intro z hz
    exact div_nonneg (hd.2.2.1 z hz) hp.le
  · rw [integral_div,div_self hp.ne']

def densityProbability {n : ℕ} (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (A : Set (MolecularDynamics.Chapter05Review.E n)) : ℝ :=
  ∫ z in A,ρ z

def densityMeasureOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (volume.restrict D).withDensity (fun z => ENNReal.ofReal (ρ z))

theorem lebesgueClosure : ∀ n (s : Set (MolecularDynamics.Chapter05Review.E n)) (A : ℕ → Set (MolecularDynamics.Chapter05Review.E n)),
  (IsOpen s → NullMeasurableSet s volume) ∧ (IsClosed s → NullMeasurableSet s volume) ∧
  ((∀ k,NullMeasurableSet (A k) volume) →
    NullMeasurableSet (⋃ k,A k) volume ∧ NullMeasurableSet (⋂ k,A k) volume) := by
  intro n s A
  refine ⟨fun h => h.measurableSet.nullMeasurableSet,fun h => h.measurableSet.nullMeasurableSet,?_⟩
  intro h
  exact ⟨NullMeasurableSet.iUnion h,NullMeasurableSet.iInter h⟩

def borelSigma (n : ℕ) : MeasurableSpace (MolecularDynamics.Chapter05Review.E n) := borel (MolecularDynamics.Chapter05Review.E n)

theorem densityProbabilityBounds : ∀ n (D A : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  probabilityDensityOn D ρ → A ⊆ D → NullMeasurableSet A volume →
    0 ≤ densityProbability ρ A ∧ densityProbability ρ A ≤ 1 := by
  intro n D A ρ hp hAD hA
  have hnD : 0 ≤ᵐ[volume.restrict D] ρ := by
    filter_upwards [ae_restrict_mem₀ hp.1.1] with z hz
    exact hp.1.2.2.1 z hz
  have hnA : 0 ≤ᵐ[volume.restrict A] ρ := by
    filter_upwards [ae_restrict_mem₀ hA] with z hz
    exact hp.1.2.2.1 z (hAD hz)
  refine ⟨setIntegral_nonneg_of_ae_restrict hnA,?_⟩
  change (∫ z in A,ρ z) ≤ 1
  rw [← hp.2]
  exact setIntegral_mono_set hp.1.2.2.2 hnD (Filter.Eventually.of_forall hAD)

@[reducible] def domainL2 (n : ℕ) (D : Set (MolecularDynamics.Chapter05Review.E n)) := Lp ℝ 2 (volume.restrict D)

def domainL2Norm {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (g : domainL2 n D) := ‖g‖

def domainL2Inner {n : ℕ} {D : Set (MolecularDynamics.Chapter05Review.E n)} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z

theorem domainL2NormSquare : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g := by
  intro n D g
  change ‖g‖^2=∫ z in D,g z*g z
  simpa only [MeasureTheory.L2.inner_def,Real.inner_apply] using (real_inner_self_eq_norm_sq g).symm

theorem domainL2Complete : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  intro n D u hu
  exact cauchySeq_tendsto_of_complete hu

theorem domainL2SymmetricBilinear : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f := by
  intro n D f g h a b
  have hi : ∀ u v : domainL2 n D,domainL2Inner u v=inner ℝ u v := by
    intro u v
    simp only [domainL2Inner,MeasureTheory.L2.inner_def,Real.inner_apply]
  simp only [hi,inner_add_left,inner_smul_left,real_inner_comm]
  simp

theorem compactL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume := by
  intro n g hg hs
  exact hg.memLp_of_hasCompactSupport hs

def densityAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)

def closedSupport {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) : Set (MolecularDynamics.Chapter05Review.E n) := tsupport f

theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume := by
  intro n a ha
  have hc : Continuous (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,a i*(z i)^2))) := by fun_prop
  rw [memLp_two_iff_integrable_sq hc.aestronglyMeasurable]
  have hi := integrable_cexp_neg_sum_mul_add (ι := Fin n) (b := fun i => ((2*a i : ℝ) : ℂ))
    (by intro i; simpa using (mul_pos (by norm_num : (0 : ℝ)<2) (ha i))) (fun _ => (0 : ℂ))
  have hr : Integrable (fun v : Fin n → ℝ => Real.exp (-(∑ i,(2*a i)*(v i)^2))) volume := by
    simpa only [zero_mul,Finset.sum_const_zero,add_zero,← Complex.ofReal_pow,← Complex.ofReal_mul,
      ← Complex.ofReal_sum,← Complex.ofReal_neg,Complex.exp_ofReal,Complex.ofReal_re] using hi.re
  have he : Integrable (fun z : MolecularDynamics.Chapter05Review.E n => Real.exp (-(∑ i,(2*a i)*(z i)^2))) volume := by
    rw [← (PiLp.volume_preserving_toLp (Fin n)).integrable_comp_emb (MeasurableEquiv.toLp 2 _).measurableEmbedding]
    exact hr
  convert he using 1
  funext z
  rw [← Real.exp_nat_mul]
  congr 1
  simp only [mul_assoc,← Finset.mul_sum]
  ring

theorem finiteJumpL2 : ∀ n (g : MolecularDynamics.Chapter05Review.E n → ℝ) (S : Set (MolecularDynamics.Chapter05Review.E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume := by
  intro n g S hS hs hc hb
  have hm : Measurable g := hc.measurable_of_countable_compl (by simpa only [compl_compl] using hS.countable)
  have hl : ∀ z,∃ C > 0,∀ᶠ x in 𝓝 z,|g x| ≤ C := by
    intro z
    by_cases hz : z ∈ S
    · obtain ⟨C,hC,U,hU,hbU⟩ := hb z hz
      exact ⟨C,hC,Filter.mem_of_superset hU hbU⟩
    · have hcont := hc.continuousAt (hS.isClosed.isOpen_compl.mem_nhds hz)
      refine ⟨|g z|+1,by positivity,?_⟩
      exact (hcont.abs.eventually_lt_const (lt_add_one _)).mono (fun _ h => h.le)
  have hbound : ∃ C > 0,∀ x ∈ tsupport g,|g x| ≤ C := by
    apply hs.induction_on (p := fun A => ∃ C > 0,∀ x ∈ A,|g x| ≤ C)
    · exact ⟨1,by norm_num,by simp⟩
    · intro A B hAB hB
      obtain ⟨C,hC,hCB⟩ := hB
      exact ⟨C,hC,fun x hx => hCB x (hAB hx)⟩
    · intro A B hA hB
      obtain ⟨C,hC,hCA⟩ := hA
      obtain ⟨D,hD,hDB⟩ := hB
      refine ⟨max C D,lt_of_lt_of_le hC (le_max_left _ _),?_⟩
      intro x hx
      rcases hx with hx|hx
      · exact (hCA x hx).trans (le_max_left _ _)
      · exact (hDB x hx).trans (le_max_right _ _)
    · intro z hz
      obtain ⟨C,hC,hCL⟩ := hl z
      exact ⟨{x | |g x| ≤ C},mem_nhdsWithin_of_mem_nhds hCL,C,hC,fun _ hx => hx⟩
  obtain ⟨C,hC,hBC⟩ := hbound
  apply hs.memLp_of_bound hm.aestronglyMeasurable C
  filter_upwards [] with x
  by_cases hx : x ∈ tsupport g
  · simpa only [Real.norm_eq_abs] using hBC x hx
  · rw [image_eq_zero_of_notMem_tsupport hx,norm_zero]
    exact hC.le

theorem normalizedAverageFormula : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ g : MolecularDynamics.Chapter05Review.E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x))) := by
  intro n D ρ g
  simp only [densityAverageOn,← mul_div_assoc,integral_div]

end MD.Ch05Short
