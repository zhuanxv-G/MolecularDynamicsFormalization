import MolecularDynamics.Chapter05.ReviewDefinitions
/-! Unproved Chapter 5 statements. Geometric area, coarea, continuous-flow
ergodic theorems and KAM infrastructure are explicitly outstanding. -/
open Set Filter MeasureTheory Matrix
open scoped BigOperators Topology ENNReal
noncomputable section
namespace MolecularDynamics.Chapter05Review
def flowFieldTransport_statement : Prop := ∀ n (f : E n → E n) Φ,
  flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z)
def pullbackPDE_statement : Prop := ∀ n (f : E n → E n) Φ (g : E n → ℝ),
  flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    HasDerivAt (fun s => pullback Φ g s z) (lie f (pullback Φ g t) z) t
def steadyFirstIntegral_statement : Prop := ∀ n (f : E n → E n) Φ (g : E n → ℝ),
  flow f Φ → Differentiable ℝ g → ((∀ z,lie f g z=0) ↔ ∀ t z,g (Φ t z)=g z)
def densityNormalization_statement : Prop := ∀ n (ρ : E n → ℝ), density ρ → 0 < (∫ z,ρ z) →
  probabilityDensity (fun z => ρ z/(∫ x,ρ x))
def borelClosure_statement : Prop := ∀ n (s : Set (E n)) (A : ℕ → Set (E n)),
  (IsOpen s → MeasurableSet s) ∧ (IsClosed s → MeasurableSet s) ∧
  ((∀ k,MeasurableSet (A k)) → MeasurableSet (⋃ k,A k) ∧ MeasurableSet (⋂ k,A k))
def l2NormSquare_statement : Prop := ∀ n (μ : Measure (E n)) (g : L2Space μ),
  l2Norm μ g^2=∫ z,(g z)^2 ∂μ
def l2Complete_statement : Prop := ∀ n (μ : Measure (E n)) (u : ℕ → L2Space μ),
  CauchySeq u → ∃ v : L2Space μ,Tendsto u atTop (𝓝 v)
def l2Symmetry_statement : Prop := ∀ n (μ : Measure (E n)) (f g : E n → ℝ),
  l2Inner μ f g=l2Inner μ g f
def l2Linearity_statement : Prop := ∀ n (μ : Measure (E n)) (f g h : E n → ℝ) a b,
  Integrable (fun z => f z*h z) μ → Integrable (fun z => g z*h z) μ →
  l2Inner μ (fun z => a*f z+b*g z) h=a*l2Inner μ f h+b*l2Inner μ g h
def compactL2_statement : Prop := ∀ n (g : E n → ℝ), Continuous g → HasCompactSupport g → MemLp g 2 volume
def massDerivative_statement : Prop := ∀ n (ρ : ℝ → E n → ℝ) (A : Set (E n)) t,
  MeasurableSet A → (∀ s,IntegrableOn (ρ s) A) →
  (∃ δ > 0, ∃ b : E n → ℝ, IntegrableOn b A ∧
    (∀ s ∈ Ioo (t-δ) (t+δ), ∀ z ∈ A, HasDerivAt (fun u => ρ u z) (deriv (fun u => ρ u z) s) s ∧
      |deriv (fun u => ρ u z) s| ≤ b z)) →
  HasDerivAt (massFraction ρ A) (∫ z in A,deriv (fun u => ρ u z) t) t
def rectangle {n : ℕ} (a b : E n) := {z : E n | ∀ i,a i ≤ z i ∧ z i ≤ b i}
def boxFace {n : ℕ} (a b : E n) (i : Fin n) (side : ℝ) := {z : E n | z ∈ rectangle a b ∧ z i=side}
def faceFlux {n : ℕ} (f : E n → E n) (ρ : E n → ℝ) (a b : E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(hausdorffArea (n-1))
def fluxBalance_statement : Prop := ∀ n (f : E n → E n) Φ (ρ : ℝ → E n → ℝ) (a b : E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,probabilityDensity (ρ t)) →
  (∀ t,densityMeasure (ρ t)=measurePropagator Φ t (densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i))
def liouvilleEquation_statement : Prop := ∀ n (f : E n → E n) Φ (ρ : ℝ → E n → ℝ),
  ContDiff ℝ 1 f → flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  ContDiff ℝ 1 (Function.uncurry ρ) → (∀ t,probabilityDensity (ρ t)) →
  (∀ t,densityMeasure (ρ t)=measurePropagator Φ t (densityMeasure (ρ 0))) →
  ∀ t z, HasDerivAt (fun s => ρ s z) (liouvillian f (ρ t) z) t
def liouvilleProduct_statement : Prop := ∀ n (f : E n → E n) (ρ : E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  liouvillian f ρ z = -ρ z*divergence f z-lie f ρ z
def liouvillianAdjoint_statement : Prop := ∀ n (f : E n → E n) (u v : E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*lie f v z)=(∫ z,liouvillian f u z*v z)
def hamiltonianSkewExpression_statement : Prop := ∀ n (f : E n → E n) (u : E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,divergence f z=0) →
  ∀ z,liouvillian f u z= -lie f u z
def hamiltonianDensityPropagation_statement : Prop := ∀ n (f : E n → E n) Φ (ρ : E n → ℝ),
  ContDiff ℝ 1 f → flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ z,divergence f z=0) → density ρ → ∀ t,
  (∫ z,ρ (Φ (-t) z))=(∫ z,ρ z) ∧
  densityMeasure (fun z => ρ (Φ (-t) z))=measurePropagator Φ t (densityMeasure ρ)
def diracApproximation_statement : Prop := ∀ n (r : ℝ → E n → ℝ),
  (∀ ε > 0,probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0))
def energyDensityInvariant_statement : Prop := ∀ n (H : E n → ℝ) (f : E n → E n)
    Φ (r : ℝ → ℝ), flow f Φ → ContDiff ℝ 1 H → ContDiff ℝ 1 r →
    (∀ z,lie f H z=0) → (∀ t,MeasurePreserving (Φ t) volume volume) →
    probabilityDensity (r ∘ H) → ∀ t,
    measurePropagator Φ t (densityMeasure (r ∘ H))=densityMeasure (r ∘ H)
def shellWeakLimit_statement : Prop := ∀ n (H : E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → regularEnergy H c →
  (∃ δ > 0, IsCompact {z | |H z-c| ≤ δ} ∧ (∀ ε ∈ Ioo 0 δ,
    Integrable (shellWeight H c ε) volume ∧ 0 < shellPartition H c ε)) →
  ∀ φ : testSpace n, Tendsto (fun ε => ∫ z,φ.1 z*shellDensity H c ε z)
    (𝓝[>] 0) (𝓝 (microAverage H c φ.1))
def shellWeakPrinted_statement : Prop := ∀ n (H : E n → ℝ) c,
  ContDiff ℝ 2 H → regularEnergy H c → ∀ φ : testSpace n,
    Tendsto (fun ε => (shellPartition H c ε)⁻¹*(∫ z,φ.1 z*shellDensity H c ε z))
      (𝓝[>] 0) (𝓝 (microAverage H c φ.1))
def surfaceAreaFormula_statement : Prop := ∀ d (g : E d → E (d+1)) (U : Set (E d)),
  IsOpen U → ContDiffOn ℝ 1 g U → Function.Injective g →
  (∀ x ∈ U,Function.Injective (fderiv ℝ g x)) →
  ((hausdorffArea d) (g '' U)).toReal=
    ∫ x in U,Real.sqrt (Matrix.det (fun i j : Fin d =>
      inner ℝ ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single i 1)))
        ((fderiv ℝ g x) (WithLp.toLp 2 (Pi.single j 1))) : Matrix (Fin d) (Fin d) ℝ))
def normalEnergyTaylor_statement : Prop := ∀ n (H : E n → ℝ) z,
  ContDiff ℝ 2 H → grad H z ≠ 0 → ∃ C > 0, ∃ δ > 0, ∀ s : ℝ, |s| < δ →
    |H (z+s • normalField H z)-H z-s*‖grad H z‖| ≤ C*s^2
def shellVolumeLimit_statement : Prop := ∀ n (H : E n → ℝ) c,
  0 < n → ContDiff ℝ 2 H → regularEnergy H c →
  (∃ δ > 0,IsCompact {z | |H z-c| ≤ δ} ∧ ∀ z, |H z-c| ≤ δ → grad H z ≠ 0) →
  Tendsto (fun ε => (volume {z | c ≤ H z ∧ H z ≤ c+ε}).toReal/ε)
    (𝓝[>] 0) (𝓝 (microPartition H c))
def microInvariant_statement : Prop := ∀ n (H : E n → ℝ) c (f : E n → E n) Φ,
  ContDiff ℝ 2 H → regularEnergy H c → flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,MeasurePreserving (Φ t) volume volume) → (∀ t z,H (Φ t z)=H z) →
  ∀ t,MeasurePreserving (Φ t) (microMeasure H c) (microMeasure H c)
def microProbability_statement : Prop := ∀ n (H : E n → ℝ) c,
  0 < (microRaw H c) univ → (microRaw H c) univ < ∞ →
  (microMeasure H c) univ=1 ∧ ∀ A : Set (E n), (microMeasure H c) A ≤ 1
def lowerDimensionNull_statement : Prop := ∀ n d (H : E n → ℝ) c (g : E d → E n)
    (K : Set (E d)), d+1 < n → ContDiff ℝ 1 H → regularEnergy H c →
    ContDiff ℝ 1 g → IsCompact K →
    g '' K ⊆ energySurface H c → (microMeasure H c) (g '' K)=0
def ergodicTimeAverage_statement : Prop := ∀ n (μ : Measure (E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (setErgodic μ Φ ↔ ∀ g : E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, hasTimeAverage (fun t => Φ t z) g (average μ g))
def nonergodicSet_statement : Prop := ∀ n (μ : Measure (E n)) Φ,
  IsProbabilityMeasure μ → (¬setErgodic μ Φ ↔
    ∃ A : Set (E n),MeasurableSet A ∧ flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1)
-- A faithful persistence obligation, not a claim that the numerical example
-- meets KAM hypotheses. Analyticity, nondegeneracy and Diophantine conditions
-- are explicit; no invariant torus is supplied as an assumption.
def kam_statement : Prop := ∀ n (H0 : E n → ℝ) (P : Phase n → ℝ) (I0 : E n) κ τ,
  0 < n → AnalyticOnNhd ℝ H0 univ → AnalyticOnNhd ℝ P univ → periodicPerturbation P →
  Function.Bijective (fderiv ℝ (gradient H0) I0) → diophantine (gradient H0 I0) κ τ →
  ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∃ K : E n → Phase n,
    ContDiff ℝ 1 K ∧
    (∀ x,Function.Injective (fderiv ℝ K x)) ∧
    (∀ x (k : Fin n → ℤ), K (x+WithLp.toLp 2 (fun i => (k i : ℝ)))=
      ((K x).1+WithLp.toLp 2 (fun i => (k i : ℝ)),(K x).2)) ∧
    (∀ x,(fderiv ℝ K x) (gradient H0 I0)=hamiltonianField
      (fun z => H0 z.2+ε*P z) (K x)) ∧
    (∀ x,‖(K x).2-I0‖ < 1)
def correlationTime_statement : Prop := ∀ n d (μ : Measure (E n)) Φ
    (a b : E n → E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, hasTimeAverage (fun s => Φ s z) g (average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (correlation μ Φ a b k t))
def measureDuality_statement : Prop := ∀ n (μ : Measure (E n)) Φ (φ : E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (measurePropagator Φ t μ) →
    average (measurePropagator Φ t μ) φ=average μ (pullback Φ φ t)
def mixingCorrelation_statement : Prop := ∀ n (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (a b : E n → ℝ) k, IsProbabilityMeasure μ →
  (∀ r φ : E n → ℝ, Integrable r μ → (∀ z,0 ≤ r z) → (∫ z,r z ∂μ)=1 →
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (average μ φ))) →
  Continuous a → Continuous b → Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
  Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (k*average μ a*average μ b))
def mixingCorrelationPrinted_statement : Prop := ∀ n (μ : Measure (E n)) Φ
    (a b : E n → ℝ) k, IsProbabilityMeasure μ → mixing μ Φ → Continuous a → Continuous b →
    Bornology.IsBounded (range a) → Bornology.IsBounded (range b) →
    Tendsto (fun t => k*(∫ z,a (Φ t z)*b z ∂μ)) atTop (𝓝 (average μ a*average μ b))
def modifiedLiouvillian_statement : Prop := ∀ n (f fr : E n → E n) (u : E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  liouvillian (modifiedField f fr h r) u z=liouvillian f u z+h^r*liouvillian fr u z
def eulerInvariant_statement : Prop := ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (E 2),
  IsProbabilityMeasure μ → MeasurePreserving (forwardEuler h) μ μ → μ=diracMeasure 2
def backwardEulerLimit_statement : Prop := ∀ h : ℝ,h ≠ 0 →
  (∀ z : E 2,Tendsto (fun k : ℕ => (backwardEuler h)^[k] z) atTop (𝓝 0)) ∧
  ∀ μ : Measure (E 2),IsProbabilityMeasure μ → ∀ φ : E 2 → ℝ,
    Continuous φ → Bornology.IsBounded (range φ) →
    Tendsto (fun k : ℕ => ∫ z,φ ((backwardEuler h)^[k] z) ∂μ) atTop (𝓝 (φ 0))
def symplecticEulerDensity_statement : Prop := ∀ h : ℝ, |h| < 2 → ∀ r : ℝ → ℝ,
  probabilityDensity (r ∘ shadowOscillator h) →
    MeasurePreserving (symplecticEuler h) (densityMeasure (r ∘ shadowOscillator h))
      (densityMeasure (r ∘ shadowOscillator h))
def symplecticEulerShadow_statement : Prop := ∀ h (z : E 2),
  shadowOscillator h (symplecticEuler h z)=shadowOscillator h z
def theorem51_statement : Prop :=
  ∀ n (H η g : E n → ℝ) (w : E n → E n) c,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ g → ContDiff ℝ ⊤ w →
    regularEnergy H c → (∀ z ∈ energySurface H c,inner ℝ (w z) (grad H z) ≠ 0) →
    (∃ δ > 0, ∃ K : Set (E n), IsCompact K ∧
      ∀ ε ∈ Ioo (-δ) δ, regularEnergy (fun z => H z+ε*η z) c ∧
        energySurface (fun z => H z+ε*η z) c ⊆ K ∧
        (∀ z ∈ K,inner ℝ (w z) (grad H z) ≠ 0)) →
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |microAverage H c g-microAverage (fun z => H z+ε*η z) c g-
        perturbationCorrection H η g w c ε| ≤ C*ε^2
def gradientTransverse_statement : Prop := ∀ n (H : E n → ℝ) c,
  (∀ z ∈ energySurface H c,grad H z ≠ 0) →
    ∀ z ∈ energySurface H c,inner ℝ (grad H z) (grad H z) ≠ 0
def dynamicalCorrection_statement : Prop :=
  ∀ n d (H η : E n → ℝ) (w : E n → E n) (a b : E n → E d) (Φ : ℝ → E n → E n) c t,
    0 < n → ContDiff ℝ ⊤ H → ContDiff ℝ ⊤ η → ContDiff ℝ ⊤ w →
    ContDiff ℝ ⊤ a → ContDiff ℝ ⊤ b → ContDiff ℝ ⊤ (Φ t) → regularEnergy H c →
    (∃ δ > 0, ∃ K : Set (E n), IsCompact K ∧ energySurface H c ⊆ K ∧
      (∀ z ∈ K,inner ℝ (w z) (grad H z) ≠ 0) ∧
      ∀ ε ∈ Ioo (-δ) δ,regularEnergy (fun z => H z+ε*η z) c ∧
        energySurface (fun z => H z+ε*η z) c ⊆ K) →
    let g := fun z => inner ℝ (a (Φ t z)) (b z)
    ∃ C > 0, ∃ δ > 0, ∀ ε ∈ Ioo (-δ) δ,
      |microAverage H c g-microAverage (fun z => H z+ε*η z) c g-
        perturbationCorrection H η g w c ε| ≤ C*ε^2
end MolecularDynamics.Chapter05Review
