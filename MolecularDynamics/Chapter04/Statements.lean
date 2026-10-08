import MolecularDynamics.Chapter04.ReviewDefinitions
/-! Unproved Chapter 4 obligations. A proposition definition is not a proof. -/
open Set Filter Matrix
open scoped BigOperators Topology Matrix.Norms.Elementwise
noncomputable section
namespace MolecularDynamics.Chapter04Review
def constraintDegrees_statement : Prop :=
  ∀ n l (g : Q n → Q l) (q : Q n), DifferentiableAt ℝ g q →
    Function.Surjective (fderiv ℝ g q) →
    Module.finrank ℝ (LinearMap.ker (fderiv ℝ g q).toLinearMap)+l=n
def scalarEulerStable_statement : Prop := ∀ h rho, scalarStable (eulerFactor h rho) ↔ ‖eulerFactor h rho‖ ≤ 1
def eulerImaginaryGrowth_statement : Prop :=
  ∀ h Ω : ℝ, h ≠ 0 → Ω ≠ 0 → ∀ z : ℂ, z ≠ 0 →
    Tendsto (fun k : ℕ => ‖(eulerFactor h (Complex.I*Ω))^k*z‖) atTop atTop
def symplecticEulerCharacteristic_statement : Prop :=
  ∀ Ω h : ℝ, ∀ rho : ℂ, (rho • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
    (symplecticEulerMatrix Ω h).map Complex.ofReal).det=rho^2-(2-h^2*Ω^2 : ℝ)*rho+1
def symplecticEulerStability_statement : Prop :=
  ∀ Ω h : ℝ, (0 < |h*Ω| ∧ |h*Ω| < 2 → matrixStable (symplecticEulerMatrix Ω h)) ∧
    (2 < |h*Ω| → eigenvalueOutside (symplecticEulerMatrix Ω h))
-- The reference supplies the missing method-class restrictions; kept for review.
def prkThreshold_statement : Prop :=
  ∀ s (A B : Matrix (Fin s) (Fin s) ℝ) (b c : Fin s → ℝ)
    (G : ℝ → ℝ → Matrix (Fin 2) (Fin 2) ℝ), 0 < s →
    (∑ i,b i)=1 → (∑ i,c i)=1 →
    (∀ i j, b i*B i j+c j*A j i=b i*c j) →
    (∀ i j, i ≤ j → A i j=0) → (∀ i j, i < j → B i j=0) →
    (∀ Ω h z, ∃ q p, prkOscillatorRelation A B b c Ω h z (G Ω h *ᵥ z) q p) →
    (∀ Ω h, matrixStable (G Ω h) → |h*Ω| ≤ 2)
def verletStability_statement : Prop :=
  ∀ Ω h : ℝ, 0 < |h*Ω| → |h*Ω| < 2 → matrixStable (verletMatrix Ω h)
def implicitModulus_statement : Prop := ∀ Ω h : ℝ, ‖implicitFactor Ω h‖=1
def modifiedFrequencyLimit_statement : Prop :=
  ∀ Ω : ℝ, Tendsto (modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω)
def midpointElimination_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h (z mid out : Z n),
    mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • invMass m z.2-(h^2/4) • invMass m (grad U mid.1)
def respaStructure_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (US UF : Q n → ℝ) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → 0 < r →
    symplecticMap (respa m US UF r h) ∧ ∀ z, respa m US UF r (-h) (respa m US UF r h z)=z
def impulseDet_statement : Prop := ∀ Ω h : ℝ, Ω ≠ 0 →
  (slowMatrix h).det=1 ∧ (fastMatrix Ω h).det=1 ∧ (impulseMatrix Ω h).det=1
def impulseTrace_statement : Prop := ∀ Ω h : ℝ, Ω ≠ 0 →
  (impulseMatrix Ω h).trace=2*Real.cos (h*Ω)-(h/Ω)*Real.sin (h*Ω)
def resonancePower_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∀ k : ℕ,
  (impulseMatrix Ω (Real.pi/Ω))^k=(-1 : ℝ)^k • !![1,0; -(k : ℝ)*(Real.pi/Ω),1]
def resonanceGrowth_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop
def resonanceTaylor_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2
def resonanceInstability_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), eigenvalueOutside (impulseMatrix Ω h)
def resonanceEigenPrinted_statement : Prop := ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), ∃ rho : ℝ,
    (rho • (1 : Matrix (Fin 2) (Fin 2) ℝ)-impulseMatrix Ω h).det=0 ∧
    |rho+1-Real.sqrt (|(Real.pi/Ω)*(h-Real.pi/Ω)|/2)| ≤ C*|h-Real.pi/Ω|
def mollifiedStructure_statement : Prop :=
  ∀ n (m : Fin n → ℝ) (US UF : Q n → ℝ) (A : Q n → Q n) r h,
    (∀ i, 0 < m i) → ContDiff ℝ 2 US → ContDiff ℝ 2 UF → ContDiff ℝ 2 A → 0 < r →
    (∀ q v, (fderiv ℝ (mollifiedPotential US A) q) v=(fderiv ℝ US (A q)) ((fderiv ℝ A q) v)) ∧
    symplecticMap (respa m (mollifiedPotential US A) UF r h)
def timeConstraintDerivative_statement : Prop :=
  ∀ n l (g : Q n → ℝ → Q l) (q : ℝ → Q n) t v,
    DifferentiableAt ℝ (Function.uncurry g) (q t,t) → HasDerivAt q v t →
    (∀ᶠ s in 𝓝 t, g (q s) s=0) → (fderiv ℝ (Function.uncurry g) (q t,t)) (v,1)=0
def variational_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (rho : Z n → Q l) (z v : Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    (fderiv ℝ (fun x : Z n =>
      (invMass m x.2,-grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (invMass m v.2,-(fderiv ℝ (grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • grad (g j) z.1+
          rho z j • (fderiv ℝ (grad (g j)) z.1) v.1))
def hiddenEulerError_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (z : Z n) (out : ℝ → Z n) (rho : ℝ → Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 out → out 0=z →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, positionEulerRelation m (fun q => -grad U q) g h z (out h) (rho h)) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      ‖textbookConstraintJacobian g (out h).1 *ᵥ invMass m (out h).2‖ ≤ C*h
def newtonQuadratic_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (q base : Q n) (root : Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → projectionResidual m g q base root=0 →
    (projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : Q l, ‖η-root‖ < δ → ‖newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2
def frozenNewtonLinear_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (q base : Q n) (root : Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → projectionResidual m g q base root=0 →
    (projectionJacobian m g q base 0).det ≠ 0 →
    ‖fderiv ℝ (frozenNewtonConstraint m g q base) root‖ < 1 →
    ∃ C ∈ Ioo (0 : ℝ) 1, ∃ δ > 0, ∀ η : Q l, ‖η-root‖ < δ →
      ‖frozenNewtonConstraint m g q base η-root‖ ≤ C*‖η-root‖
def projectionScale_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (F : Q n → Q n) (g : Fin l → Q n → ℝ)
    (z : Z n) (η : ℝ → Q l), z ∈ cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      projectionResidual m g z.1 (z.1+h • invMass m z.2+h^2 • invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2
def branchEquations {n l : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (h : ℝ) (G : Z n → Z n) (half : Z n → Q n) (rho μ : Z n → Q l) : Prop :=
  ∀ x ∈ cotangentSet m g, rattleRelation m (fun q => -grad U q) g h x (G x) (half x) (rho x) (μ x)
def rattleSymplectic_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    h (G : Z n → Z n) (half : Z n → Q n) (rho μ : Z n → Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 U → Differentiable ℝ G →
    Differentiable ℝ half → Differentiable ℝ rho → Differentiable ℝ μ →
    (∀ z ∈ cotangentSet m g, rattleRelation m (fun q => -grad U q) g h z (G z) (half z) (rho z) (μ z)) →
    restrictedSymplectic m g G
def constrainedOrders_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (z : Z n) (Φ E R : ℝ → Z n) (pE pR : ℝ → Q n) (rhoE μE rhoR μR : ℝ → Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      projectedEulerRelation m (fun q => -grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      rattleRelation m (fun q => -grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3
def commonStaggeredPositions_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (F : Q n → Q n) (g : Fin l → Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q a b : Q n, ∀ rho ν : Q l, q ∈ constraintSet g →
      a=q+h • invMass m (b+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho)) →
      a ∈ constraintSet g → ν ≠ rho →
      q+h • invMass m (b+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ ν)) ∈ constraintSet g →
      (textbookConstraintJacobian g q)ᵀ *ᵥ ν=(textbookConstraintJacobian g q)ᵀ *ᵥ rho) →
    ∀ (qS qR bS bR : ℕ → Q n) (rhoS rhoR : ℕ → Q l), qS 0=qR 0 → bS 0=bR 0 →
      (∀ k, staggeredConstraintRelation m F g h (qS k) (qS (k+1)) (bS k) (bS (k+1)) (rhoS k)) →
      (∀ k, staggeredConstraintRelation m F g h (qR k) (qR (k+1)) (bR k) (bR (k+1)) (rhoR k)) →
      ∀ k, qS k=qR k
def shakeRattlePositions_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (F : Q n → Q n) (g : Fin l → Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q base : Q n, ∀ eta nu : Q l, q ∈ constraintSet g →
      projectionResidual m g q base eta=0 → projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → Q n) (rhoS rhoR muR : ℕ → Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1))
def shakeElimination_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (F : Q n → Q n) (g : Fin l → Q n → ℝ)
    h (q p half : ℕ → Q n) (rho : ℕ → Q l),
    (∀ k, shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1))
def shakePositionOrder_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (q p : ℝ → Q n) (rho : ℝ → Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    constrainedSolution m (fun x => -grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → Q n) (rhon : ℕ → Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → shakePositionRelation m (fun x => -grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2
def constrainedComposition_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (E A : ℝ → Z n → Z n) (pE pA : ℝ → Z n → Q n) (rhoE μE rhoA μA : ℝ → Z n → Q l),
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ h, Differentiable ℝ (E h) ∧ Differentiable ℝ (A h) ∧
      Differentiable ℝ (pE h) ∧ Differentiable ℝ (pA h) ∧ Differentiable ℝ (rhoE h) ∧
      Differentiable ℝ (μE h) ∧ Differentiable ℝ (rhoA h) ∧ Differentiable ℝ (μA h)) →
    (∀ h z, z ∈ cotangentSet m g →
      projectedEulerRelation m (fun q => -grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      adjointEulerRelation m (fun q => -grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h, restrictedSymplectic m g (A (h/2) ∘ E (h/2))
def constrainedCompositionOrder_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ)
    (E A : ℝ → Z n → Z n) (pE pA : ℝ → Z n → Q n) (rhoE muE rhoA muA : ℝ → Z n → Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h z, z ∈ cotangentSet m g →
      projectedEulerRelation m (fun q => -grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      adjointEulerRelation m (fun q => -grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3
def constrainedPotentialFlow_statement : Prop :=
  ∀ n l (m : Fin n → ℝ) (U : Q n → ℝ) (g : Fin l → Q n → ℝ) (z : Z n),
    z ∈ cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    (∀ j, Differentiable ℝ (g j)) → ∀ t : ℝ,
    let P := fun s : ℝ => z.2-s • (momentumProjector m g z.1 *ᵥ grad U z.1)
    (z.1,P t) ∈ cotangentSet m g ∧ HasDerivAt P (-momentumProjector m g z.1 *ᵥ grad U z.1) t
def lincsConvergence_statement : Prop := ∀ l (C : Matrix (Fin l) (Fin l) ℝ),
  ‖C.toLin'.toContinuousLinearMap‖ < 1 → Tendsto (lincsInverse C) atTop (𝓝 ((1-C)⁻¹))
def kineticSplit_statement : Prop := ∀ N (m : Fin N → ℝ) (v : V) (w : Fin N → V),
  (∑ i, m i • w i)=0 →
    (∑ i, m i*dot (v+w i) (v+w i))/2=totalMass m*dot v v/2+(∑ i,m i*dot (w i) (w i))/2
def rotationSkew_statement : Prop := ∀ (Θ : ℝ → Mat3) t d,
  HasDerivAt Θ d t → (∀ᶠ s in 𝓝 t, Θ s*(Θ s)ᵀ=1) → (d*(Θ t)ᵀ)ᵀ=-(d*(Θ t)ᵀ)
def crossMatrix_statement : Prop := ∀ u v : V, skewMatrix u *ᵥ v=cross3 u v
def inertiaTracePrinted_statement : Prop := ∀ N (m : Fin N → ℝ) (δ : Fin N → V),
  secondMoment m δ=(inertiaTensor m δ).trace • (1 : Mat3)-inertiaTensor m δ
def inertiaTraceCorrected_statement : Prop := ∀ N (m : Fin N → ℝ) (δ : Fin N → V),
  secondMoment m δ=((inertiaTensor m δ).trace/2) • (1 : Mat3)-inertiaTensor m δ
def angularInertia_statement : Prop := ∀ N (m : Fin N → ℝ) (δ : Fin N → V) (Θ : Mat3) (ω : V),
  Θᵀ*Θ=1 → Θ.det=1 → bodyMomentum Θ
    (angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => cross3 ω (Θ *ᵥ δ i))) =
      inertiaTensor m δ *ᵥ (Θᵀ *ᵥ ω)
def rigidInvariants_statement : Prop := ∀ (T : Mat3) (π : ℝ → V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, dot (π t) (T⁻¹ *ᵥ π t)=dot (π a) (T⁻¹ *ᵥ π a) ∧
      dot (π t) (π t)=dot (π a) (π a)
def axisFlow_statement : Prop := ∀ (I π : V) i, 0 < I i → ∀ t : ℝ,
  HasDerivAt (fun s : ℝ => (spinAxis I i s (π,1)).1)
    (cross3 ((spinAxis I i t (π,1)).1) (Pi.single i (((spinAxis I i t (π,1)).1 i)/I i))) t
def poissonMap (G : V → V) : Prop := ∀ π,
  let D : Mat3 := fun i j => (fderiv ℝ G π) (Pi.single j 1) i
  D*skewMatrix π*Dᵀ=skewMatrix (G π)
def spinPoisson_statement : Prop := ∀ I : V, (∀ i, 0 < I i) → ∀ h : ℝ,
  poissonMap (fun π => (spinStep I h (π,1)).1)
def driftSpinCommute_statement : Prop := ∀ M h (I : V) (z : RBState),
  rigidDrift M h (rigidSpin I h z)=rigidSpin I h (rigidDrift M h z)
def dlmStructure_statement : Prop := ∀ M (I : V) (U : V → Mat3 → ℝ),
  0 < M → (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rbSymplectic (dlmMassConsistent M I U h) ∧ ∀ z : RBState,
      z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 →
      dlmMassConsistent M I U (-h) (dlmMassConsistent M I U h z)=z ∧
      (dlmMassConsistent M I U h z).2.2ᵀ*(dlmMassConsistent M I U h z).2.2=1
end MolecularDynamics.Chapter04Review
