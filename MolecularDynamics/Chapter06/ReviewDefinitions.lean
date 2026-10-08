import MolecularDynamics.Chapter05.Statements
import MolecularDynamics.Chapter06.CanonicalIntegrationByParts
import MolecularDynamics.Chapter06.BrownianProbabilityDensityAverage
import MolecularDynamics.Chapter06.BrownianGibbsComplexSpectrum
import MolecularDynamics.Chapter06.LangevinCanonicalKernelContinuousTest
import MolecularDynamics.Chapter06.LangevinC0ConservedObservable
import MolecularDynamics.Chapter06.LangevinDensityMinorization
import MolecularDynamics.Chapter06.LangevinGlobalRandomSolution
import Mathlib.Analysis.Calculus.VectorField

/-! Chapter 6 review vocabulary. Only definitions; no new theorem or parked import.
The physical formulas and the actual stochastic integral relations are separate. -/
open Set Filter MeasureTheory ProbabilityTheory
open scoped BigOperators Topology ContDiff ENNReal NNReal
namespace MolecularDynamics.Chapter06Review
noncomputable section
abbrev V (n : ℕ) := Fin n → ℝ
abbrev Phase (n : ℕ) := V n × V n
def entropy (kB : ℝ) (Z : ℝ → ℝ) (E : ℝ) : ℝ := kB * Real.log (Z E)
def inverseTemperature (S : ℝ → ℝ) (E : ℝ) : ℝ := deriv S E
def temperature (S : ℝ → ℝ) (E : ℝ) : ℝ := (inverseTemperature S E)⁻¹
def inverseThermal (kB T : ℝ) : ℝ := (kB * T)⁻¹
def canonicalEnergyDensity (Z : ℝ → ℝ) (β E : ℝ) : ℝ :=
  Z E * Real.exp (-β * E) / (∫ e, Z e * Real.exp (-β * e))
def entropyFunctional {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (kB : ℝ) (ρ : D → ℝ) : ℝ := -kB * ∫ x, ρ x * Real.log (ρ x) ∂ν
def entropyLagrangian {n : ℕ} (H ρ : V n → ℝ) (lambdaParam β : ℝ) : ℝ :=
  entropyFunctional volume 1 ρ - lambdaParam*(∫ x, ρ x) - β*(∫ x, H x*ρ x)
def canonicalDensity {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ) (x : D) : ℝ := Real.exp (-β * H x) / (∫ z, Real.exp (-β * H z) ∂ν)
def canonicalAveragePrinted {Nc : ℕ} (H : SymplecticCoordinates Nc → ℝ) (β : ℝ)
    (f : SymplecticCoordinates Nc → ℝ) : ℝ :=
  (textbookCanonicalPartition H β)⁻¹ *
    ∫ z, f z * canonicalDensity volume H β z
def polynomialObservable {n : ℕ} (f : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C * (1 + ‖x.2‖) ^ r
def massHamiltonian {n : ℕ} (m : V n) (U : V n → ℝ) (x : Phase n) : ℝ :=
  (∑ i, (x.2 i) ^ 2 / (2 * m i)) + U x.1
def randomWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  dx * ∑ k ∈ Finset.range n, J k sample
def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  randomWalk J dx (n+1) sample - randomWalk J dx n sample
def diffusiveWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt : ℝ) : ℕ → Ω → ℝ :=
  randomWalk J (Real.sqrt dt)
def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (diffusiveWalk J dt (n+1) sample - diffusiveWalk J dt n sample)
def rademacherJumps {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun J P ∧ ∀ k,
    Measurable (J k) ∧ MemLp (J k) 2 P ∧
    (∀ᵐ sample ∂P, J k sample = 1 ∨ J k sample = -1) ∧ (∫ sample, J k sample ∂P) = 0
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)
def isItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W (fun s _ ↦ g s) T (Y T)
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample
def scalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ T : ℝ, 0 ≤ T → isItoIntegral P W (fun s sample ↦ b (X s sample) s) T
    (fun sample ↦ X T sample - x0 - ∫ s in 0..T, a (X s sample) s)
def adaptedSquareIntegrand {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) : Prop :=
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
    (g t)) ∧ ∀ T : ℝ, 0 ≤ T → Integrable (fun s ↦ ∫ sample, (g s sample)^2 ∂P) (volume.restrict (Icc 0 T))
def additiveSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ}
    (P : Measure Ω) (W : ℝ → Ω → V r) (X : ℝ → Ω → V n)
    (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ) (x0 : V n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    X t sample = x0 + (∫ s in 0..t, a (X s sample)) + B.mulVec (W t sample - W 0 sample)
def ouProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  scalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0
def ouMean (γ x0 t : ℝ) : ℝ := Real.exp (-γ*t)*x0
def ouVariance (γ σ t : ℝ) : ℝ := σ^2 * (1-Real.exp (-2*γ*t))/(2*γ)
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-ouMean γ x0 t)^2/(2*ouVariance γ σ t))
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*ouVariance γ σ t)
def momentumOU {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W p : ℝ → Ω → V n) (m : V n) (γ θ : ℝ) (p0 : V n) : Prop :=
  ∀ i, ouProcess P (fun t sample ↦ W t sample i) (fun t sample ↦ p t sample i) γ (Real.sqrt (2*γ*θ*m i)) (p0 i)
def bathHamiltonian {k : ℕ} (μ : V k) (U : ℝ → ℝ) (Q P : ℝ) (q p : V k) : ℝ :=
  P^2/2 + (∑ i, (p i)^2/(2*μ i)) + U Q + (∑ i, (q i-Q)^2)/(2*k)
def bathFrequency {k : ℕ} (μ : V k) (i : Fin k) : ℝ := (Real.sqrt ((k : ℝ)*μ i))⁻¹
def memoryKernel {k : ℕ} (μ : V k) (t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, Real.cos (bathFrequency μ i*t)
def bathForce {k : ℕ} (μ q0 p0 : V k) (Q0 t : ℝ) : ℝ :=
  (k : ℝ)⁻¹ * ∑ i, (Real.cos (bathFrequency μ i*t)*(q0 i-Q0) +
    (bathFrequency μ i)⁻¹ * Real.sin (bathFrequency μ i*t)*p0 i/μ i)
def bathForcePrinted {k : ℕ} (μ q0 p0 : V k) (Q0 t : ℝ) : ℝ := -bathForce μ q0 p0 Q0 t
def langevinMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (m : V n)
    (U : V n → ℝ) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹ * (X s sample).2 i) ∧
    (X t sample).2 = x0.2 + (∫ s in 0..t, fun i ↦
      -textbookConfigurationPartial U i (X s sample).1 - γ*(X s sample).2 i) +
      fun i ↦ Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)
def variableFrictionSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → V r) (X : ℝ → Ω → Phase n) (m : V n) (U : V n → ℝ)
    (Γ : V n → Matrix (Fin n) (Fin r) ℝ) (θ : ℝ) (x0 : Phase n) : Prop :=
  (∀ᵐ sample ∂P, ∀ t ∈ Ici 0, (X t sample).1 = x0.1 + (∫ s in 0..t, fun i ↦ (m i)⁻¹*(X s sample).2 i)) ∧
  ∀ i, ∀ T : ℝ, 0 ≤ T →
    Tendsto (fun K : ℕ ↦ ∫ sample,
      ((∑ j : Fin r, itoLeftSum (fun t sample ↦ W t sample j)
        (fun t sample ↦ Real.sqrt (2*θ*m i)*Γ (X t sample).1 i j) T K sample) -
        ((X T sample).2 i-x0.2 i - ∫ s in 0..T,
          -textbookConfigurationPartial U i (X s sample).1 -
            ((Γ (X s sample).1 * (Γ (X s sample).1).transpose).mulVec (X s sample).2) i))^2 ∂P)
      atTop (𝓝 0)
def brownianMassSDE {Ω : Type*} [MeasurableSpace Ω] {n : ℕ} (P : Measure Ω)
    (W q : ℝ → Ω → V n) (m : V n) (U : V n → ℝ) (γ θ : ℝ) (q0 : V n) : Prop :=
  ∀ᵐ sample ∂P, ContinuousOn (fun t ↦ q t sample) (Ici 0) ∧ ∀ t ∈ Ici 0,
    q t sample = q0 + (∫ s in 0..t, fun i ↦ -(γ*m i)⁻¹*textbookConfigurationPartial U i (q s sample)) +
      fun i ↦ Real.sqrt (2*θ/(γ*m i))*(W t sample i-W 0 sample i)
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x
def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2
def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r
def vectorDiffusion {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ) (f : V n → ℝ) (x : V n) : ℝ :=
  ∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j *
    textbookConfigurationPartial (textbookConfigurationPartial f j) i x
def vectorGenerator {n r : ℕ} (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ)
    (f : V n → ℝ) (x : V n) : ℝ := fderiv ℝ f x (a x) + vectorDiffusion B f x/2
def vectorForward {n r : ℕ} (a : V n → V n) (B : Matrix (Fin n) (Fin r) ℝ)
    (ρ : V n → ℝ) (x : V n) : ℝ :=
  -(∑ i, textbookConfigurationPartial (fun z ↦ a z i*ρ z) i x) + vectorDiffusion B ρ x/2
def langevinMassForward {n : ℕ} (m : V n) (U : V n → ℝ) (γ β : ℝ)
    (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))
def stochasticMatrix {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop :=
  (∀ i j, 0 ≤ PiMark i j) ∧ ∀ i, ∑ j, PiMark i j = 1
def finiteDistribution {k : ℕ} (ψ : V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1
def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : V k) (n : ℕ) : V k :=
  Matrix.vecMul ψ (PiMark^n)
def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}
def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ returnTimes PiMark i, d ∣ n}
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, period PiMark i = 1
def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j
def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : V k) : Prop :=
  finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ
def lieBracket {n : ℕ} (u v : V n → V n) : V n → V n := VectorField.lieBracket ℝ u v
def kernelEvolution {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (μ : Measure D) (t : ℝ≥0) : Measure D := K t ∘ₘ μ
def kernelAverage {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D)
    (f : D → ℝ) (t : ℝ≥0) (x : D) : ℝ := ∫ z, f z ∂K t x
def invariantKernel {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  ∀ t, kernelEvolution K μ t = μ
def markovSemigroup {D : Type*} [MeasurableSpace D] (K : ℝ≥0 → Kernel D D) : Prop :=
  (∀ t, IsMarkovKernel (K t)) ∧ K 0 = Kernel.id ∧ ∀ s t, K (s+t) = K s ∘ₖ K t
def assumption1 {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
def assumption1Printed {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ici 0)
def assumption2 {D : Type*} [TopologicalSpace D] (L : (D → ℝ) → D → ℝ)
    (φ : D → ℝ) (α δ : ℝ) : Prop :=
  (∀ x, 0 < φ x) ∧ Continuous φ ∧ (∀ R : ℝ, IsCompact {x | φ x ≤ R}) ∧
    0 < α ∧ 0 < δ ∧ ∀ x, L φ x ≤ -α*φ x+δ
local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
def flatPhaseMeasure (n : ℕ) : Measure (textbookLangevinPeriodicPhase n) :=
  (volume : Measure (UnitAddTorus (Fin n))).prod (volume : Measure (V n))
def flatForwardWeak {n : ℕ} (U : V n → ℝ) (β γ : ℝ)
    (φ g : textbookLangevinPeriodicPhase n → ℝ) : Prop :=
  ∀ ψ : textbookLangevinPeriodicPhase n → ℝ,
    ContDiff ℝ ∞ (ψ ∘ textbookLangevinPeriodicProjection) → HasCompactSupport ψ →
      Integrable (fun x ↦ φ x * textbookLangevinPeriodicDifferentialOperator U γ
        (Real.sqrt (2*γ*β⁻¹)) ψ x) (flatPhaseMeasure n) ∧
      Integrable (fun x ↦ g x*ψ x) (flatPhaseMeasure n) ∧
      (∫ x, φ x*textbookLangevinPeriodicDifferentialOperator U γ
        (Real.sqrt (2*γ*β⁻¹)) ψ x ∂flatPhaseMeasure n) = ∫ x, g x*ψ x ∂flatPhaseMeasure n
end
end MolecularDynamics.Chapter06Review
