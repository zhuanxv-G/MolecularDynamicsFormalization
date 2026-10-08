import MolecularDynamics.Chapter04.ReviewDefinitions
import MolecularDynamics.Chapter02.HamiltonianVolume
import MolecularDynamics.Chapter03.ReviewDefinitions
import Mathlib.MeasureTheory.Measure.Hausdorff
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.Analysis.Distribution.SchwartzSpace.Basic
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Calculus.Gradient.Basic
import Mathlib.Dynamics.Ergodic.Ergodic

/-! Chapter 5 review definitions. Microcanonical geometry uses a genuine
Euclidean metric, not the supremum norm on coordinate functions.
Identification with induced Riemannian area and coarea remain obligations. -/
open Set Filter MeasureTheory Matrix
open scoped BigOperators Topology ENNReal
noncomputable section
namespace MolecularDynamics.Chapter05Review
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
abbrev Phase (n : ℕ) := E n × E n
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
def solutionOperator {X : Type*} (Φ : ℝ → X → X) (t : ℝ) (g : X → ℝ) := pullback Φ g t
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
def density {n : ℕ} (ρ : E n → ℝ) : Prop :=
  Measurable ρ ∧ (∀ z, 0 ≤ ρ z) ∧ Integrable ρ volume
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
def densityMeasure {n : ℕ} (ρ : E n → ℝ) : Measure (E n) := volume.withDensity (fun z => ENNReal.ofReal (ρ z))
abbrev L2Space {n : ℕ} (μ : Measure (E n)) := Lp ℝ 2 μ
def l2Norm {n : ℕ} (μ : Measure (E n)) (g : L2Space μ) := ‖g‖
def l2Inner {n : ℕ} (μ : Measure (E n)) (f g : E n → ℝ) := ∫ z, f z*g z ∂μ
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
def densityAverage {n : ℕ} (ρ g : E n → ℝ) := (∫ z,g z*ρ z)/(∫ z,ρ z)
def massFraction {n : ℕ} (ρ : ℝ → E n → ℝ) (A : Set (E n)) (t : ℝ) := ∫ z in A,ρ t z
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
def measurePropagator {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : E n → E n)
    (u : Phase n → ℝ) (z : Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
def testSpace (n : ℕ) := {φ : E n → ℝ // ContDiff ℝ ⊤ φ ∧ HasCompactSupport φ}
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
abbrev distribution (n : ℕ) := schwartzSpace n →ₗ[ℝ] ℝ
def regularDistribution {n : ℕ} (f : E n → ℝ) (φ : schwartzSpace n) := ∫ z, f z*φ z
def diracAction {n : ℕ} (φ : schwartzSpace n) := φ 0
def diracMeasure (n : ℕ) : Measure (E n) := Measure.dirac 0
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
def weakStationary {n : ℕ} (f : E n → E n) (μ : Measure (E n)) : Prop :=
  ∀ φ : testSpace n, Integrable (lie f φ.1) μ ∧ (∫ z,lie f φ.1 z ∂μ)=0
def ensembleAverage {n : ℕ} (ρ : ℝ → E n → ℝ) (φ : E n → ℝ) (t : ℝ) := densityAverage (ρ t) φ
def shellWeight {n : ℕ} (H : E n → ℝ) (c ε : ℝ) (z : E n) := Real.exp (-(H z-c)^2/(2*ε))
def shellPartition {n : ℕ} (H : E n → ℝ) (c ε : ℝ) := ∫ z,shellWeight H c ε z
def shellDensity {n : ℕ} (H : E n → ℝ) (c ε : ℝ) (z : E n) := shellWeight H c ε z/shellPartition H c ε
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
def microPartition {n : ℕ} (H : E n → ℝ) (c : ℝ) := ((microRaw H c) univ).toReal
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
def normalField {n : ℕ} (H : E n → ℝ) (z : E n) := ‖grad H z‖⁻¹ • grad H z
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
def microErgodic {n : ℕ} (H : E n → ℝ) (c : ℝ) (Φ : ℝ → E n → E n) : Prop :=
  ∀ g : E n → ℝ, Integrable g (microMeasure H c) →
    ∀ᵐ z ∂microMeasure H c, hasTimeAverage (fun t => Φ t z) g (microAverage H c g)
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X) : Prop :=
  ∀ A : Set X, MeasurableSet A → flowInvariant Φ A → μ A=0 ∨ μ A=1
def mixing {n : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n) : Prop :=
  ∀ r φ : E n → ℝ, density r → (∫ z,r z ∂μ)=1 → Continuous φ →
    Bornology.IsBounded (Set.range φ) →
    Tendsto (fun t => ∫ z,φ (Φ t z)*r z ∂μ) atTop (𝓝 (average μ φ))
def correlation {n d : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (a b : E n → E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
def velocityCorrelation {n d : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (v : E n → E d) (t : ℝ) := correlation μ Φ v v 1 t/correlation μ Φ v v 1 0
def transitionProbability {n : ℕ} (μ : Measure (E n)) (Φ : ℝ → E n → E n)
    (A B : Set (E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (μ : Measure X) := Measure.map G μ
def modifiedField {n : ℕ} (f fr : E n → E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
def backwardEuler (h : ℝ) (z : E 2) : E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
def forwardEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
def symplecticEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*(z 1-h*z 0),z 1-h*z 0]
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
def verletShadow2 {n : ℕ} (m : Fin n → ℝ) (U : E n → ℝ) (h : ℝ) (z : Phase n) :=
  let v : E n := WithLp.toLp 2 fun i => z.2 i/m i
  (∑ i,z.2 i^2/m i)/2+U z.1+h^2/24*
    (2*(fderiv ℝ (fderiv ℝ U) z.1) v v-∑ i,(grad U z.1 i)^2/m i)
def perturbationDisplacement {n : ℕ} (H η : E n → ℝ) (w : E n → E n) (ε : ℝ) (z : E n) :=
  (ε*η z/inner ℝ (w z) (grad H z)) • w z
def perturbationCorrection {n : ℕ} (H η g : E n → ℝ) (w : E n → E n) (c ε : ℝ) :=
  let Hε := fun z => H z+ε*η z
  let u := perturbationDisplacement H η w ε
  microAverage Hε c (divergence (fun z => g z • u z))-
    microAverage Hε c g*microAverage Hε c (divergence u)
def hamiltonianField {n : ℕ} (H : Phase n → ℝ) (z : Phase n) : Phase n :=
  (gradient (fun p => H (z.1,p)) z.2,-gradient (fun q => H (q,z.2)) z.1)
def periodicPerturbation {n : ℕ} (P : Phase n → ℝ) : Prop :=
  ∀ q p : E n, ∀ k : Fin n → ℤ, P (q+WithLp.toLp 2 (fun i => (k i : ℝ)),p)=P (q,p)
def diophantine {n : ℕ} (ω : E n) (κ τ : ℝ) : Prop :=
  0 < κ ∧ (n : ℝ)-1 < τ ∧ ∀ k : Fin n → ℤ, k ≠ 0 →
    κ/Real.rpow (1+‖(WithLp.toLp 2 (fun i => (k i : ℝ)) : E n)‖) τ ≤ |∑ i,(k i : ℝ)*ω i|
end MolecularDynamics.Chapter05Review
