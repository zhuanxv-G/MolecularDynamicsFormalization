import MolecularDynamics.Chapter01.EuclideanStability
import MolecularDynamics.Chapter01.VariationalEquation
import MolecularDynamics.Chapter01.TorusDensity
import MolecularDynamics.Chapter01.LatticePairPotential
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Inverse
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic

/-! Chapter 1 body definitions, printed 5--45. These definitions do not assert
existence of a solution or validity of a physical approximation. -/
open Set Filter
open scoped BigOperators Topology
noncomputable section
namespace MolecularDynamics.Chapter01Review
abbrev V3 := Position 3
abbrev Q13 := Position 39
abbrev waveFunction := ℝ → Q13 → ℂ
def imaginaryUnit : ℂ := Complex.I
abbrev planckConstant := {h : ℝ // 0 < h}
abbrev quantumMass := Fin 13 → {m : ℝ // 0 < m}
abbrev primitivePotential := Q13 → ℝ
def coordinateDirection {n : ℕ} (i : Fin n) : Position n :=
  WithLp.toLp 2 (fun j => if j = i then 1 else 0)
def secondPartial {n : ℕ} (f : Position n → ℂ) (q : Position n) (i : Fin n) : ℂ :=
  deriv (deriv (fun s : ℝ => f (q + s • coordinateDirection i))) 0
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
def initialData {n : ℕ} (q : ℝ → Position n) (t₀ : ℝ)
    (q₀ v₀ : Position n) : Prop := q t₀ = q₀ ∧ HasDerivAt q v₀ t₀
def hardSphereCollision (R₁ R₂ m₁ m₂ : ℝ) (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  0 < R₁ ∧ 0 < R₂ ∧ 0 < m₁ ∧ 0 < m₂ ∧ dist q₁ q₂ = R₁+R₂ ∧
  m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
  m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 = m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2
abbrev twoBodyTerms := V3 → V3 → ℝ
abbrev threeBodyTerms := V3 → V3 → V3 → ℝ
abbrev fourBodyTerms := V3 → V3 → V3 → V3 → ℝ
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2
def lengthBond (k r₀ r : ℝ) := k / 2 * (r-r₀)^2
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
def dispersionPotential (K r : ℝ) := -K / r^6
def buckinghamPotential (A B C r : ℝ) := A * Real.exp (-B*r) - C/r^6
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
def coulombPotential (C Qᵢ Qⱼ dielectric r : ℝ) := C*Qᵢ*Qⱼ/(dielectric*r)
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  ContDiff ℝ 1 φ ∧ ∀ r, r_cut < r → φ r = 0
def yukawaPotential (C Qᵢ Qⱼ dielectric debye r : ℝ) :=
  coulombPotential C Qᵢ Qⱼ dielectric r * Real.exp (-r/debye)
def angleBond (k θ₀ θ : ℝ) := k/2*(θ-θ₀)^2
def bondAngle (qᵢ qⱼ qₖ : V3) :=
  Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) / (pairDistance qᵢ qⱼ * pairDistance qⱼ qₖ))
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))
def stillingerWeberTerms {N : ℕ} (U : (Fin N → V3) → ℝ)
    (U₂ : Fin N → Fin N → twoBodyTerms)
    (U₃ : Fin N → Fin N → Fin N → threeBodyTerms) : Prop :=
  ∀ q, U q = (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
    ∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)
def embeddedAtomPotential {N : ℕ} (φ ρ : ℝ → ℝ) (F : Fin N → ℝ → ℝ)
    (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.Ioi i, φ (pairDistance (q i) (q j))) +
    ∑ i, F i (∑ j ∈ Finset.univ.erase i, ρ (pairDistance (q i) (q j)))
def bondOrderPotential {N : ℕ} (rep att : ℝ → ℝ)
    (b : (Fin N → V3) → Fin N → Fin N → ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i,
    (rep (pairDistance (q i) (q j)) - b q i j * att (pairDistance (q i) (q j)))
def unitedAtomModel {N G : ℕ} (group : Fin N → Fin G) : Prop := Function.Surjective group
def gayBerneGeometry (q₁ q₂ u₁ u₂ : V3) : Prop :=
  q₁ ≠ q₂ ∧ ‖u₁‖ = 1 ∧ ‖u₂‖ = 1
def gayBerneW (r u₁ u₂ : V3) (χ : ℝ) :=
  1 - χ/2 * ((inner ℝ r (u₁+u₂))^2/(1+χ*inner ℝ u₁ u₂) +
    (inner ℝ r (u₁-u₂))^2/(1-χ*inner ℝ u₁ u₂))
def gayBerneEpsilonOne (ε₀ χ : ℝ) (u₁ u₂ : V3) :=
  ε₀ / Real.sqrt (1-χ^2*(inner ℝ u₁ u₂)^2)
def gayBerneEpsilonTwo (r u₁ u₂ : V3) (χ' : ℝ) := gayBerneW r u₁ u₂ χ'
def gayBerneWell (ε₀ χ χ' : ℝ) (r u₁ u₂ : V3) :=
  gayBerneEpsilonOne ε₀ χ u₁ u₂ * (gayBerneEpsilonTwo r u₁ u₂ χ')^2
def gayBerneRho (σ₀ χ : ℝ) (r u₁ u₂ : V3) :=
  ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
def gayBernePotential (ε₀ σ₀ χ χ' : ℝ) (q₁ q₂ u₁ u₂ : V3) :=
  let r := q₂-q₁
  let ρ := gayBerneRho σ₀ χ r u₁ u₂
  4 * gayBerneWell ε₀ χ χ' (‖r‖⁻¹ • r) u₁ u₂ * ((σ₀/ρ)^12-(σ₀/ρ)^6)
def gayBerneChi (σₑ σₛ : ℝ) := ((σₑ/σₛ)^2-1)/((σₑ/σₛ)^2+1)
def gayBerneChiPrime (εₑ εₛ μ : ℝ) :=
  (1-Real.rpow (εₑ/εₛ) (1/μ))/(1+Real.rpow (εₑ/εₛ) (1/μ))
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)
abbrev fixedEnergy := ℝ
def uniformLJEnergy {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i, lennardJonesPotential ε σ (pairDistance (q i) (q j))
abbrev generalizedCoordinates (n d : ℕ) := Position d → Position n
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)
def energySurface {n : ℕ} (H : PhaseSpace n → ℝ) (E : ℝ) := {z | H z = E}
def confiningPotential {n : ℕ} (U : PotentialEnergy n) : Prop :=
  ∀ E : ℝ, Bornology.IsBounded {q | U q ≤ E}
def equilibriumDefinition {n : ℕ} (f : Position n → Position n) (z : Position n) : Prop := f z = 0
def periodicBoundary (L : ℝ) (x y : ℝ) : Prop := ∃ k : ℤ, y = x + k*L
def regularLattice {N : ℕ} (a δ : ℝ) (x : Fin N → ℝ) : Prop :=
  0 < δ ∧ ∀ i, x i = a + i.val*δ
def periodicImageEnergy {N : ℕ} (L : ℝ) (φ : Fin N → Fin N → twoBodyTerms)
    (q : Fin N → V3) :=
  ∑ k : Fin 3, ∑ l : Fin 3, ∑ m : Fin 3, ∑ i, ∑ j ∈ Finset.Ioi i,
    φ i j (q i) (q j + WithLp.toLp 2 ![L*((k.val:ℝ)-1),L*((l.val:ℝ)-1),L*((m.val:ℝ)-1)])
def minimumImage (L : ℝ) (q r image : V3) : Prop :=
  ∃ k : Fin 3 → ℤ, image = r + WithLp.toLp 2 (fun i => L*k i) ∧
    ∀ l : Fin 3 → ℤ, ‖q-image‖ ≤ ‖q-(r+WithLp.toLp 2 (fun i => L*l i))‖
def rhombicLattice (a b θ : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k*a+l*b*Real.cos θ,l*b*Real.sin θ]}
def hexagonalLattice (a : ℝ) := rhombicLattice a a (Real.pi/3)
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}
def bccCell : Set V3 :=
  {x | (∀ i, x i = 0 ∨ x i = 1) ∨ x = WithLp.toLp 2 ![1/2,1/2,1/2]}
def triangularLayer (u v : ℝ) : Set (Position 2) :=
  {x | ∃ k l : ℤ, x = WithLp.toLp 2 ![k+l/2+u,l*Real.sqrt 3/2+v]}
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
def isoscelesPotential (x y : ℝ) :=
  2*lennardJonesPotential 1 1 (Real.sqrt (x^2+y^2)) + lennardJonesPotential 1 1 (2*x)
def isoscelesEnergy (x y v w : ℝ) := v^2 + w^2/3 + isoscelesPotential x y
def sensitiveDependence {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∃ ε > 0, ∀ x ∈ D, ∀ δ > 0, ∃ y ∈ D, dist x y < δ ∧
    ∃ t ≥ 0, ε ≤ dist (F t x) (F t y)
def topologicalTransitivity {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∀ U V : Set (Position n), IsOpen U → IsOpen V → (U ∩ D).Nonempty →
    (V ∩ D).Nonempty → ∃ t ≥ 0, ∃ x ∈ U ∩ D, F t x ∈ V ∩ D
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
def anisotropicAngular (x y : ℝ) :=
  let c := x/Real.sqrt (x^2+y^2)
  4*c^3-3*c
def anisotropicParameters (κ₀ l₀ ε c₃ : ℝ) : ℝ × ℝ :=
  (κ₀*(1-ε*c₃/2),l₀*(1+ε*c₃/2))
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
def differentiableFlow {n : ℕ} (F : ℝ → Position n → Position n) : Prop :=
  ∀ t, ContDiff ℝ 1 (F t)
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)
def singularValues {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) (σ : Fin n → ℝ) : Prop :=
  (∀ i, 0 ≤ σ i) ∧ Antitone σ ∧
  ∃ O : Matrix (Fin n) (Fin n) ℝ,
    O.transpose*O=1 ∧ O.transpose*(A.transpose*A)*O=Matrix.diagonal (fun i => (σ i)^2)
def lyapunovExponent (σ : ℝ → ℝ) : EReal :=
  Filter.limsup (fun t : ℝ => ((Real.log (σ t)/t : ℝ) : EReal)) atTop
end MolecularDynamics.Chapter01Review
