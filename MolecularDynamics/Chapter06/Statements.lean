import MolecularDynamics.Chapter06.ReviewDefinitions

/-! Faithful obligations, not proofs. Literal textbook errors have separate corrected
formulations. Parked checkpoints remain outside these imports. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped BigOperators Topology ContDiff ENNReal NNReal InnerProductSpace
namespace MolecularDynamics.Chapter06Review
noncomputable section
def entropyAdditivity_statement : Prop := ∀ (kB ZA ZB : ℝ), 0 < ZA → 0 < ZB →
  kB*Real.log (ZA*ZB) = kB*Real.log ZA+kB*Real.log ZB
def entropyEquilibrium_statement : Prop := ∀ (SA SB : ℝ → ℝ) (E e : ℝ),
  DifferentiableAt ℝ SA e → DifferentiableAt ℝ SB (E-e) →
  IsLocalMax (fun x ↦ SA x+SB (E-x)) e → deriv SA e = deriv SB (E-e)
def bathTaylor_statement : Prop := ∀ (S : ℝ → ℝ) (E : ℝ), ContDiff ℝ 2 S →
  ∃ C δ : ℝ, 0 ≤ C ∧ 0 < δ ∧ ∀ e, |e| < δ →
    |S (E-e)-S E+deriv S E*e| ≤ C*e^2
def independentPartition_statement : Prop := ∀ {n m : ℕ} (HA : Chapter05Review.E n → ℝ)
    (HB : Chapter05Review.E m → ℝ) (EA EB : ℝ),
  Chapter05Review.regularEnergy HA EA → Chapter05Review.regularEnergy HB EB →
  let μA := Chapter05Review.microRaw HA EA
  let μB := Chapter05Review.microRaw HB EB
  (μA.prod μB) univ = μA univ * μB univ
def entropyFirstVariation_statement : Prop := ∀ {n : ℕ} (H ρ : V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  ∀ ψ : V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    HasDerivAt (fun e ↦ entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β)
      (∫ x, (-(1+Real.log (ρ x))-lambdaParam-β*H x)*ψ x) 0
def entropyVariation_statement : Prop := ∀ {n : ℕ} (H ρ : V n → ℝ) (lambdaParam β : ℝ),
  Continuous H → Continuous ρ → (∀ x, 0 < ρ x) →
  Integrable ρ → Integrable (fun x ↦ ρ x*Real.log (ρ x)) → Integrable (fun x ↦ H x*ρ x) →
  (∀ ψ : V n → ℝ, ContDiff ℝ ∞ ψ → HasCompactSupport ψ →
    IsLocalMax (fun e ↦ entropyLagrangian H (fun x ↦ ρ x+e*ψ x) lambdaParam β) 0) →
  ∀ x, -(1+Real.log (ρ x))-lambdaParam-β*H x=0 ∧
    ρ x=Real.exp (-1-lambdaParam)*Real.exp (-β*H x)
def partitionMass_statement : Prop := ∀ {n : ℕ} (m : V n) (U : V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∫ x : Phase n, Real.exp (-β*massHamiltonian m U x)) =
    (∫ q, Real.exp (-β*U q)) * ∏ i, Real.sqrt (2*Real.pi*m i/β)
def confiningPartition_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ) (β c p C : ℝ),
  Continuous U → 0 < β → 0 < c → 0 < p →
  (∀ q, c*Real.rpow ‖q‖ p-C ≤ U q) → Integrable (fun q ↦ Real.exp (-β*U q))
def equipartition_statement : Prop := ∀ {n : ℕ} (m : V n) (U : V n → ℝ) (β : ℝ),
  (∀ i, 0 < m i) → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  0 < (∫ q, Real.exp (-β*U q)) →
  (∀ i, (∫ x : Phase n, (x.2 i)^2 * canonicalDensity volume (massHamiltonian m U) β x) = m i/β) ∧
  (∫ x : Phase n, (∑ i, (x.2 i)^2/m i) * canonicalDensity volume (massHamiltonian m U) β x) = n/β
def configTemperature_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ) (β : ℝ),
  ContDiff ℝ 2 U → 0 < β → Integrable (fun q ↦ Real.exp (-β*U q)) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q ^ 2 * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial (textbookConfigurationPartial U i) i q * Real.exp (-β*U q))) →
  (∀ i, Integrable (fun q ↦ textbookConfigurationPartial U i q * Real.exp (-β*U q))) →
  0 < (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) →
  (∫ q, (∑ i, textbookConfigurationPartial U i q ^ 2) * Real.exp (-β*U q)) /
    (∫ q, (∑ i, textbookConfigurationPartial (textbookConfigurationPartial U i) i q) * Real.exp (-β*U q)) = β⁻¹
def temperatureChoices_statement : Prop := ∀ {n : ℕ} (m : V n) (U : V n → ℝ) (q p : V n),
  (∀ i, 0 < m i) → ContDiff ℝ 2 U →
  fderiv ℝ (massHamiltonian m U) (q,p) (0,p) = ∑ i, p i^2/m i ∧
  fderiv ℝ (massHamiltonian m U) (q,p) ((fun i ↦ textbookConfigurationPartial U i q),0) =
    ∑ i, textbookConfigurationPartial U i q ^ 2 ∧
  fderiv ℝ (massHamiltonian m U) (q,p) (q,0) = ∑ i, q i * textbookConfigurationPartial U i q
def energyObstruction_statement : Prop := ∀ {n : ℕ} (H : V n → ℝ) (E : ℝ)
    (z : ℝ → V n) (μ : Measure (V n)), Continuous H →
  (∀ t, H (z t) = E) → 0 < μ {x | H x ≠ E} →
  (∀ t, z t ∉ {x | H x ≠ E}) ∧ μ {x | H x ≠ E} ≠ 0
def walkRecurrence_statement : Prop := ∀ {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω),
  randomWalk J dx (n+1) sample = randomWalk J dx n sample + dx*J n sample
def walkVariance_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ), rademacherJumps P J →
  (∫ sample, randomWalk J dx n sample ∂P) = 0 ∧ (∫ sample, randomWalk J dx n sample ^ 2 ∂P) = n*dx^2
def walkGridMoments_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dt : ℝ) (k l : ℕ), rademacherJumps P J → 0 < dt → k ≤ l →
  (∫ sample, diffusiveWalk J dt l sample-diffusiveWalk J dt k sample ∂P) = 0 ∧
  (∫ sample, (diffusiveWalk J dt l sample-diffusiveWalk J dt k sample)^2 ∂P) = ((l : ℝ)-k)*dt
def walkDiffusion_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (T : ℝ), rademacherJumps P J → 0 < T →
  ∃ μ : Measure (C(Icc (0 : ℝ) T, ℝ)), IsProbabilityMeasure μ ∧
    (∀ t : Icc (0 : ℝ) T, μ.map (fun w ↦ w t) = gaussianReal 0 t.1.toNNReal) ∧
    (∀ s t : Icc (0 : ℝ) T, s ≤ t →
      HasLaw (fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w t-w s) (gaussianReal 0 (t.1-s.1).toNNReal) μ) ∧
    (∀ k : ℕ, ∀ ts : Fin (k+1) → Icc (0 : ℝ) T, Monotone ts →
      iIndepFun (fun i : Fin k ↦ fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w (ts i.succ)-w (ts i.castSucc)) μ) ∧
    ∀ F : C(Icc (0 : ℝ) T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
      ∃ Y : ℕ → Ω → C(Icc (0 : ℝ) T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample t, Y K sample t = interpolatedWalk J (T/K) t sample) ∧
        Tendsto (fun K ↦ ∫ sample, F (Y K sample) ∂P) atTop (𝓝 (∫ w, F w ∂μ))
def wienerContinuousVersion_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∃ V : ℝ≥0 → Ω → ℝ, (∀ t, W t =ᵐ[P] V t) ∧ ∀ᵐ sample ∂P, Continuous (fun t ↦ V t sample)
def wienerIncrement_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P → ∀ s t : ℝ≥0,
      HasLaw (fun sample ↦ W t sample-W s sample) (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P ∧
      (∫ sample, (W t sample-W s sample)^2 ∂P)=|((t : ℝ)-s)|
def wienerNondifferentiable_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  (∀ᵐ sample ∂P, Continuous (fun t : ℝ≥0 ↦ W t sample)) →
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t → ¬ DifferentiableAt ℝ (fun s ↦ W s.toNNReal sample) t
def itoFormula_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2)
def itoTimeFormula_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X a b x0 → ContDiff ℝ 2 φ →
  adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2)
def ouIntegratingFactor_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ouProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, isItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample
def ouLaw_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ouProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (ouMean γ x0 T) (ouVariance γ σ T).toNNReal) P
def ouGibbsLimit_statement : Prop := ∀ (γ θ m x0 : ℝ), 0 < γ → 0 < θ → 0 < m →
  ∀ f : ℝ → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ x, f x ∂gaussianReal (ouMean γ x0 t)
      (ouVariance γ (Real.sqrt (2*γ*θ*m)) t).toNNReal) atTop
      (𝓝 (∫ x, f x ∂gaussianReal 0 (θ*m).toNNReal))
def bathHamiltonEquations_statement : Prop := ∀ {k : ℕ} (μ : V k) (U : ℝ → ℝ)
    (Q P : ℝ) (q p : V k), 0 < k → (∀ i, 0 < μ i) → DifferentiableAt ℝ U Q →
  deriv (fun z ↦ bathHamiltonian μ U Q z q p) P = P ∧
  -deriv (fun z ↦ bathHamiltonian μ U z P q p) Q = -deriv U Q-(∑ i : Fin k, (Q - q i))/(k : ℝ) ∧
  (∀ i, fderiv ℝ (fun v ↦ bathHamiltonian μ U Q P q v) p (Pi.single i 1) = p i/μ i) ∧
  (∀ i, -fderiv ℝ (fun v ↦ bathHamiltonian μ U Q P v p) q (Pi.single i 1) = (Q-q i)/(k : ℝ))
def bathOscillator_statement : Prop := ∀ (Q q : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 2 q → Continuous Q → 0 < Ω → 0 ≤ t →
  (∀ s ∈ Icc 0 t, deriv (deriv q) s = Ω^2*(Q s-q s)) →
  q t = Real.cos (Ω*t)*q 0 + Ω⁻¹*Real.sin (Ω*t)*deriv q 0 +
    ∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s
def bathConvolutionIBP_statement : Prop := ∀ (Q P : ℝ → ℝ) (Ω t : ℝ),
  ContDiff ℝ 1 Q → (∀ s, deriv Q s=P s) → 0 ≤ t →
  (∫ s in 0..t, Ω*Real.sin (Ω*(t-s))*Q s) = Q t-Real.cos (Ω*t)*Q 0 -
    ∫ s in 0..t, Real.cos (Ω*(t-s))*P s
def bathReduction_statement : Prop := ∀ {k : ℕ} (μ : V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+bathForce μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, memoryKernel μ (t-s)*P s
def bathReductionPrinted_statement : Prop := ∀ {k : ℕ} (μ : V k) (U Q P : ℝ → ℝ)
    (q p : ℝ → V k) (t : ℝ), 0 < k → (∀ i, 0 < μ i) → 0 ≤ t →
  ContDiff ℝ 2 Q → ContDiff ℝ 2 q →
  (∀ s, deriv Q s=P s) → (∀ s, deriv P s = -deriv U (Q s)-(∑ i : Fin k, (Q s - q s i))/(k : ℝ)) →
  (∀ i s, deriv (fun u ↦ q u i) s=p s i/μ i) →
  (∀ i s, deriv (deriv (fun u ↦ q u i)) s=(Q s-q s i)/((k : ℝ)*μ i)) →
  deriv P t = -deriv U (Q t)+bathForcePrinted μ (q 0) (p 0) (Q 0) t -
    ∫ s in 0..t, memoryKernel μ (t-s)*P s
def overdampedLimit_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → V n) (U : V n → ℝ) (β : ℝ)
    (x0 : Phase n) (X : ℝ → ℝ → Ω → Phase n) (q : ℝ → Ω → V n),
  textbookIsWienerVector B P → ContDiff ℝ ∞ U → textbookUnitPeriodicPotential U → 0 < β →
  (∀ γ : ℝ, 0 < γ → langevinMassSDE P (fun t sample ↦ B t.toNNReal sample) (X γ)
    (fun _ ↦ 1) U γ β⁻¹ x0) →
  brownianMassSDE P (fun t sample ↦ B t.toNNReal sample) q (fun _ ↦ 1) U 1 β⁻¹ x0.1 →
  ∀ T : ℝ, 0 < T → ∀ f : V n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun γ : ℝ ↦ ∫ sample, f (X γ (γ*T) sample).1 ∂P) atTop
      (𝓝 (∫ sample, f (q T sample) ∂P))
def generatorExpectation_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b φ : ℝ → ℝ) (x0 : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 2 φ → adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample)) →
  (∀ t : ℝ, 0 ≤ t → Integrable (fun sample ↦ scalarGenerator a b φ (X t sample)) P) →
  ContinuousOn (fun t ↦ ∫ sample, scalarGenerator a b φ (X t sample) ∂P) (Ici 0) →
  ∀ t : ℝ, 0 < t → HasDerivAt (fun s ↦ ∫ sample, φ (X s sample) ∂P)
    (∫ sample, scalarGenerator a b φ (X t sample) ∂P) t
def fpDriftAdjoint_statement : Prop := ∀ (a ρ φ : ℝ → ℝ),
  ContDiff ℝ 1 a → ContDiff ℝ 1 ρ → ContDiff ℝ 1 φ →
  HasCompactSupport φ → (∫ x, a x*deriv φ x*ρ x) = ∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x)
def fpAdjoint_statement : Prop := ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ →
  HasCompactSupport φ → (∫ x, scalarGenerator a b φ x*ρ x) = ∫ x, φ x*scalarForward a b ρ x
def fpEquation_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → scalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∀ φ : ℝ → ℝ, ContDiff ℝ ∞ φ → HasCompactSupport φ → ∀ t : ℝ, 0 < t →
    HasDerivAt (fun s ↦ ∫ x, φ x*ρ s x) (∫ x, scalarGenerator a b φ x*ρ t x) t) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=scalarForward a b (ρ t) x
def zeroNoise_statement : Prop := ∀ (a f ρ : ℝ → ℝ) (x : ℝ),
  scalarGenerator a (fun _ ↦ 0) f x=a x*deriv f x ∧
    scalarForward a (fun _ ↦ 0) ρ x = -deriv (fun z ↦ a z*ρ z) x
def vectorIto_statement : Prop := ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → V r) (X : ℝ → Ω → V n)
    (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ) (x0 : V n) (φ : V n → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P → additiveSDE P W X a B x0 → ContDiff ℝ 2 φ →
  (∀ j, adaptedSquareIntegrand P (fun t sample ↦ W t sample j)
    (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j))) →
  ∀ T : ℝ, 0 ≤ T → Tendsto (fun K : ℕ ↦ ∫ sample,
    ((∑ j : Fin r, itoLeftSum (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T K sample) -
      (φ (X T sample)-φ x0 - ∫ s in 0..T, vectorGenerator a B φ (X s sample)))^2 ∂P) atTop (𝓝 0)
def vectorFP_statement : Prop := ∀ {n r : ℕ} (a : V n → V n)
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : ℝ → V n → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 (Function.uncurry ρ) →
  (∀ φ : V n → ℝ, ContDiff ℝ ∞ φ → HasCompactSupport φ → ∀ t : ℝ, 0 < t →
    (∫ x, φ x*deriv (fun s ↦ ρ s x) t) = ∫ x, vectorGenerator a B φ x*ρ t x) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x
def diffusionTrace_statement : Prop := ∀ {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ)
    (H : Matrix (Fin n) (Fin n) ℝ),
  Matrix.trace (B.transpose*H*B)=∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j*H i j
def finiteErgodicity_statement : Prop := ∀ {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ),
  0 < k → stochasticMatrix PiMark → irreducible PiMark → aperiodic PiMark →
  ∃ ψ : V k, finiteInvariant PiMark ψ ∧ (∀ χ, finiteInvariant PiMark χ → χ=ψ) ∧
    ∀ ψ0 : V k, finiteDistribution ψ0 → Tendsto (finiteEvolution PiMark ψ0) atTop (𝓝 ψ)
def stationaryInvariant_statement : Prop := ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ kernelAverage K f s.toNNReal x)
      (L (fun y ↦ kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  invariantKernel K μ
def canonicalMixing_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ → ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ))
def theorem61_statement : Prop := ∀ {n : ℕ} (m : V n) (hm : ∀ i, 0 < m i)
    (U : V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ))
def kernelGenerator {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (x : D) : ℝ := derivWithin (fun t : ℝ ↦ kernelAverage K f t.toNNReal x) (Ici 0) 0
def minorization_statement : Prop := ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D), assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x
def theorem62_statement : Prop := ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D), markovSemigroup K →
  (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) → ∀ t,
    Continuous (kernelAverage K f t)) →
  ∀ (φ : D → ℝ) (α δ : ℝ), assumption2 (kernelGenerator K) φ α δ →
    ∃ R : ℝ, 0 < R ∧ ∀ (_ : assumption1 ν K {x | φ x ≤ R}),
      ∃ μ : Measure D, IsProbabilityMeasure μ ∧ invariantKernel K μ ∧
      (∀ μ' : Measure D, IsProbabilityMeasure μ' → invariantKernel K μ' → μ'=μ) ∧
      (∃ ρ : D → ℝ, Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧
        μ=ν.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) ∧
      (∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
        Integrable (kernelGenerator K f) μ → (∫ x, kernelGenerator K f x ∂μ)=0) ∧
      ∃ κ lambdaParam : ℝ, 0 < κ ∧ 0 < lambdaParam ∧ ∀ f : D → ℝ, Measurable f → (∀ x, |f x| ≤ φ x) →
        Integrable f μ ∧ ∀ (t : ℝ≥0) (x : D),
          |kernelAverage K f t x-(∫ z, f z ∂μ)| ≤ κ*Real.exp (-lambdaParam*(t : ℝ))*φ x
def bracketProperties_statement : Prop := ∀ {n : ℕ} (u v w : V n → V n) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (lieBracket (fun x ↦ a • u x+b • v x) w = (fun x ↦ a • lieBracket u w x+b • lieBracket v w x)) ∧
  lieBracket u v = -lieBracket v u ∧ lieBracket u u=0
def hormanderDensity_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂flatPhaseMeasure n
def lemma61_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → V n) (m : V n) (U : V n → ℝ)
    (γ β : ℝ) (x0 : Phase n) (X : ℝ → Ω → Phase n),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  0 < γ → 0 < β → langevinMassSDE P (fun t sample ↦ B t.toNNReal sample) X m U γ β⁻¹ x0 →
  (∀ t : ℝ, 0 ≤ t → AEMeasurable (X t) P) →
  ∀ t : ℝ, 0 < t → ∀ C : Set (Phase n), IsOpen C → C.Nonempty → 0 < P {sample | X t sample ∈ C}
def langevinErgodicity_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → V n) (P : Measure Ω) (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Continuous f → HasCompactSupport f →
    ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧ ∀ t : ℝ≥0,
      |kernelAverage (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
        (Real.sqrt (2*γ*β⁻¹))) f t x - (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
          C*Real.exp (-lambdaParam*(t : ℝ))
def langevinTimeAverage_statement : Prop := ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → V n) (P : Measure Ω) (U : V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Continuous f → HasCompactSupport f → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ))
def proposition64_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x
def proposition64Relative_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  let A := (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).adjoint
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ,
        textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∈ A.graph →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x=c
def fredholm_statement : Prop := ∀ {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [CompleteSpace E] (A : E →ₗ.[ℝ] E), Dense (A.domain : Set E) → IsClosed (A.graph : Set (E × E)) →
  (∃ R : E →L[ℝ] E, IsCompactOperator R ∧
    (∀ x, (R x, R x-x) ∈ A.graph) ∧
    ∀ x y, (y,y-x) ∈ A.graph → y=R x) →
  ∀ g : E, (∃ φ : E, (φ,g) ∈ A.graph) ↔ ∀ y : E, (y,0) ∈ A.adjoint.graph → ⟪y,g⟫_ℝ=0
def kernelConstant_statement : Prop := ∀ {n : ℕ} (U : V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ f : Lp ℝ 2 (textbookLangevinCanonicalMeasure U β hβ),
    (f,0) ∈ (textbookLangevinCanonicalHilbertClosedOperator U β γ (Real.sqrt (2*γ*β⁻¹)) hβ).graph →
    ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ, f x=c
def kernelDuality_statement : Prop := ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (t : ℝ≥0) (f : D → ℝ),
  IsProbabilityMeasure μ → IsMarkovKernel (K t) → Measurable f →
  Integrable f (kernelEvolution K μ t) →
  (∫ x, f x ∂kernelEvolution K μ t) = ∫ x, kernelAverage K f t x ∂μ
def eigenmodeDecay_statement : Prop := ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [CompleteSpace E] (S : ℝ≥0 → E →L[ℝ] E) (ρeq ρ1 : E) (α lambdaParam : ℝ),
  S 0=ContinuousLinearMap.id ℝ E → (∀ s t, S (s+t)=(S s).comp (S t)) →
  (∀ x, Continuous (fun t : ℝ≥0 ↦ S t x)) →
  (∀ t, S t ρeq=ρeq) →
  (∀ t : ℝ, 0 ≤ t → HasDerivWithinAt (fun s : ℝ ↦ S s.toNNReal ρ1)
    (lambdaParam • S t.toNNReal ρ1) (Ici 0) t) → lambdaParam < 0 →
  (∀ t : ℝ≥0, S t (ρeq+α • ρ1)=ρeq+(α*Real.exp (lambdaParam*(t : ℝ))) • ρ1) ∧
  ∀ ℓ : E →L[ℝ] ℝ, ∀ t : ℝ≥0,
    |ℓ (S t (ρeq+α • ρ1))-ℓ ρeq| ≤ |α| *‖ℓ‖*‖ρ1‖*Real.exp (lambdaParam*(t : ℝ))
end
end MolecularDynamics.Chapter06Review
