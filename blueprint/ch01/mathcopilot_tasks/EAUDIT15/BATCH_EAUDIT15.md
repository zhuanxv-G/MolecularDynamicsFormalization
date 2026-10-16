# EAUDIT15：第1章§1.5.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-KeplerPolarODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Working these out directly, one gets\n\\[\\ddot r=-\\frac1{r^2}+r\\dot\\theta^2,\\qquad0=\\frac{\\mathrm d}{\\mathrm dt}(r^2\\dot\\theta).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "IsKeplerPolarEulerLagrangeOn包含真实一阶/二阶导数及r≠0，展开定义核对。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerpolarode",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-120"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem keplerpolarode :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ),
    IsKeplerPolarEulerLagrangeOn I r θ v omega ↔
      ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (omega t) t ∧
        HasDerivAt v (r t * omega t ^ 2 - (r t ^ 2)⁻¹) t ∧
        HasDerivAt (fun u => r u ^ 2 * omega u) 0 t := by
  exact @MolecularDynamics.keplerPolar_eulerLagrange_iff
```
### 实际依赖 MolecularDynamics.IsKeplerPolarEulerLagrangeOn
```lean
def IsKeplerPolarEulerLagrangeOn (I : Set ℝ) (r θ v ω : ℝ → ℝ) : Prop :=
  ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t ∧
    HasDerivAt (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) w (ω u)) (v u))
      (deriv (fun ρ => keplerPolarScalarLagrangian ρ (θ t) (v t) (ω t)) (r t)) t ∧
    HasDerivAt (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) (v u) w) (ω u))
      (deriv (fun ϑ => keplerPolarScalarLagrangian (r t) ϑ (v t) (ω t)) (θ t)) t
```
### 实际依赖 MolecularDynamics.keplerPolarScalarLagrangian
```lean
noncomputable def keplerPolarScalarLagrangian (r _θ v ω : ℝ) : ℝ :=
  v ^ 2 / 2 + r ^ 2 * ω ^ 2 / 2 + 1 / r
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-KeplerRadialReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "29",
  "pdf_page": "52",
  "statement_latex": "Taking this quantity as fixed, we may write the remaining equation as $\\ddot r=-1/r^2+l_z^2/r^3$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.keplerradialreduction",
  "extra_assumptions": [
    "r非零、角动量l固定，既有极坐标Euler–Lagrange真实解；角动量常性先前已证。"
  ],
  "old_ids": [
    "CH01-122"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem keplerradialreduction :
  ∀ (I : Set ℝ) (r θ v omega : ℝ → ℝ)
    (h : IsKeplerPolarEulerLagrangeOn I r θ v omega) (t : ℝ) (ht : t ∈ I)
    (l : ℝ) (hl : r t ^ 2 * omega t = l),
    HasDerivAt v (-(r t ^ 2)⁻¹ + l ^ 2 / r t ^ 3) t := by
  exact @MolecularDynamics.keplerPolar_radial_reduction
```
### 实际依赖 MolecularDynamics.IsKeplerPolarEulerLagrangeOn
```lean
def IsKeplerPolarEulerLagrangeOn (I : Set ℝ) (r θ v ω : ℝ → ℝ) : Prop :=
  ∀ t ∈ I, 0 < r t ∧ HasDerivAt r (v t) t ∧ HasDerivAt θ (ω t) t ∧
    HasDerivAt (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) w (ω u)) (v u))
      (deriv (fun ρ => keplerPolarScalarLagrangian ρ (θ t) (v t) (ω t)) (r t)) t ∧
    HasDerivAt (fun u => deriv (fun w => keplerPolarScalarLagrangian (r u) (θ u) (v u) w) (ω u))
      (deriv (fun ϑ => keplerPolarScalarLagrangian (r t) ϑ (v t) (ω t)) (θ t)) t
```
### 实际依赖 MolecularDynamics.keplerPolarScalarLagrangian
```lean
noncomputable def keplerPolarScalarLagrangian (r _θ v ω : ℝ) : ℝ :=
  v ^ 2 / 2 + r ^ 2 * ω ^ 2 / 2 + 1 / r
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-KeplerFullSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "From our previous work, we know that this system (a single degree of freedom system) can be solved for $r$ as a function of $t$ and the initial conditions. Once $r=r(t)$ is known, we may obtain $\\theta$ by integration:\n\\[\\theta=\\theta(0)+\\int_0^t\\frac{l_z}{r^2(s)}\\,\\mathrm ds.\\]\nThe example shows that the full solution of the Kepler problem can be worked out given the initial conditions, as long as we are happy to express the solution in terms of antiderivatives of simple functions (and their inverses).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.kepler_full_solution",
  "extra_assumptions": [
    "完整非碰撞存在区间含0；原文不保证径向碰撞时仍有全局解；角θ为区间上的连续实提升。"
  ],
  "old_ids": [
    "CH01-124",
    "CH01-125",
    "CH01-126"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem kepler_full_solution (a b : ℝ) (z : ℝ → PhaseSpace 2)
    (h0 : 0 ∈ Ioo a b)
    (hz : IsMechanicalSolutionOn (fun _ => (1 : ℝ)) keplerForce
      {q : Position 2 | q ≠ 0} (Ioo a b) z) :
    ∃ ℓ θ₀ : ℝ, ∃ r v θ : ℝ → ℝ,
      (∀ t ∈ Ioo a b, 0 < r t ∧ HasDerivAt r (v t) t ∧
        HasDerivAt v (-1/(r t)^2+ℓ^2/(r t)^3) t ∧
        θ t = θ₀ + ∫ s in (0 : ℝ)..t, ℓ/(r s)^2 ∧
        (z t).1 = polarCoordinates (r t) (θ t)) ∧
      (∀ t₀ ∈ Ioo a b, ScalarPotentialLocalDescription
        (fun x => -1/x + ℓ^2/(2*x^2)) (fun t => (r t,v t)) a b t₀) ∧
      z 0 = ((polarCoordinates (r 0) θ₀),
        WithLp.toLp 2 ![v 0*Real.cos θ₀-ℓ/r 0*Real.sin θ₀,
          v 0*Real.sin θ₀+ℓ/r 0*Real.cos θ₀]) := by
  sorry
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.HasScalarQuadratureRepresentation
```lean
def HasScalarQuadratureRepresentation (r s : ℝ → ℝ)
    (W : (ℝ → ℝ) → ℝ → ℝ) (w₀ a b t₀ : ℝ) : Prop :=
  ∃ (ψ g : ℝ → ℝ) (δ ε : ℝ), 0 < δ ∧ 0 < ε ∧
    ψ (r t₀) = s t₀ ∧ ContDiffAt ℝ 1 ψ (r t₀) ∧ HasStrictDerivAt g w₀ 0 ∧
    (∀ᶠ t in 𝓝 t₀, r t = g (t - t₀) ∧ s t = ψ (g (t - t₀))) ∧
    (∀ᶠ x in 𝓝 (r t₀), g (separableTimePrimitive (W ψ) (r t₀) x) = x) ∧
    (∀ᶠ y in 𝓝 0, separableTimePrimitive (W ψ) (r t₀) (g y) = y) ∧
    (∀ t ∈ Ioo (t₀ - ε) (t₀ + ε), t ∈ Ioo a b ∧
      separableTimePrimitive (W ψ) (r t₀) (r t) = t - t₀)
```
### 实际依赖 MolecularDynamics.IsMechanicalSolutionOn
```lean
def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PhaseSpace
```lean
abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.ScalarPotentialLocalDescription
```lean
def ScalarPotentialLocalDescription (U : ℝ → ℝ) (γ : ℝ → ℝ × ℝ)
    (a b t₀ : ℝ) : Prop :=
  ((γ t₀).2 ≠ 0 ∧ HasScalarQuadratureRepresentation
    (fun t => (γ t).1) (fun t => (γ t).2) (fun ψ => ψ) (γ t₀).2 a b t₀) ∨
  ((γ t₀).2 = 0 ∧ deriv U (γ t₀).1 ≠ 0 ∧ HasScalarQuadratureRepresentation
    (fun t => (γ t).2) (fun t => (γ t).1) (fun ψ v => -deriv U (ψ v))
    (-deriv U (γ t₀).1) a b t₀) ∨
  ((γ t₀).2 = 0 ∧ deriv U (γ t₀).1 = 0 ∧ ∀ t ∈ Ioo a b, γ t = γ t₀)
```
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.keplerForce
```lean
noncomputable def keplerForce {n : ℕ} (q : Position n) : Position n :=
  (-(‖q‖ ^ 3)⁻¹) • q
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
```
### 实际依赖 MD.Ch01.polarCoordinates
```lean
def polarCoordinates (r θ : ℝ) : Position 2 := WithLp.toLp 2 ![r*Real.cos θ,r*Real.sin θ]
```
### 实际依赖 MolecularDynamics.separableTimePrimitive
```lean
noncomputable def separableTimePrimitive (w : ℝ → ℝ) (x₀ x : ℝ) : ℝ :=
  ∫ u in x₀..x, 1 / w u
```
### 实际依赖 MolecularDynamics.velocityOperator
```lean
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-ActionEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "In these variables, the energy is $E=I\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.actionenergy",
  "extra_assumptions": [
    "Ω>0，I≥0；harmonicActionVelocity_formula保证v的sqrt(2IΩ)形式一致。"
  ],
  "old_ids": [
    "CH01-128"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem actionenergy :
  ∀ (Ω J θ : ℝ) (hΩ : 0 < Ω) (hJ : 0 ≤ J),
    harmonicScalarEnergy Ω (harmonicActionPosition Ω J θ)
      (harmonicActionVelocity Ω J θ) = J * Ω := by
  exact @MolecularDynamics.harmonicAction_energy
```
### 实际依赖 MolecularDynamics.harmonicActionAmplitude
```lean
noncomputable def harmonicActionAmplitude (Ω J : ℝ) : ℝ := Real.sqrt (2 * J / Ω)
```
### 实际依赖 MolecularDynamics.harmonicActionPosition
```lean
noncomputable def harmonicActionPosition (Ω J θ : ℝ) : ℝ :=
  harmonicActionAmplitude Ω J * Real.cos θ
```
### 实际依赖 MolecularDynamics.harmonicActionVelocity
```lean
noncomputable def harmonicActionVelocity (Ω J θ : ℝ) : ℝ :=
  Ω * harmonicActionAmplitude Ω J * Real.sin θ
```
### 实际依赖 MolecularDynamics.harmonicScalarEnergy
```lean
noncomputable def harmonicScalarEnergy (Ω x v : ℝ) : ℝ := v ^ 2 / 2 + Ω ^ 2 * x ^ 2 / 2
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-ActionODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "Introducing these formulas into the equations of motion and simplifying leads to $\\dot I=0$, $\\dot\\theta=-\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.actionode",
  "extra_assumptions": [
    "Ω,I正；真实I′、θ′，非退化局部角坐标。"
  ],
  "old_ids": [
    "CH01-129"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem actionode :
  ∀ (Ω : ℝ) (J θ : ℝ → ℝ) (d omega t : ℝ)
    (hΩ : 0 < Ω) (hJ : 0 < J t) (hd : HasDerivAt J d t) (hθ : HasDerivAt θ omega t),
    (HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t) ↔ d = 0 ∧ omega = -Ω := by
  exact @MolecularDynamics.harmonicAction_ode_iff
```
### 实际依赖 MolecularDynamics.harmonicActionAmplitude
```lean
noncomputable def harmonicActionAmplitude (Ω J : ℝ) : ℝ := Real.sqrt (2 * J / Ω)
```
### 实际依赖 MolecularDynamics.harmonicActionPosition
```lean
noncomputable def harmonicActionPosition (Ω J θ : ℝ) : ℝ :=
  harmonicActionAmplitude Ω J * Real.cos θ
```
### 实际依赖 MolecularDynamics.harmonicActionVelocity
```lean
noncomputable def harmonicActionVelocity (Ω J θ : ℝ) : ℝ :=
  Ω * harmonicActionAmplitude Ω J * Real.sin θ
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-ActionSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "The first equation expresses the constancy of energy; the second describes a rotation with frequency $\\Omega$, i.e., the solution is $\\theta(t)=\\theta(0)-\\Omega t$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "取s=0即原文公式；签名同时给I(t)=I(s)。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.actionsolution",
  "extra_assumptions": [
    "连通开放时间窗含起始s；正action及Ω，真实坐标解。"
  ],
  "old_ids": [
    "CH01-130"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem actionsolution :
  ∀ (Ω a b : ℝ) (J θ : ℝ → ℝ)
    (hΩ : 0 < Ω) (hJ : ∀ t ∈ Ioo a b, 0 < J t)
    (hreg : ∀ t ∈ Ioo a b, DifferentiableAt ℝ J t ∧ DifferentiableAt ℝ θ t)
    (hODE : ∀ t ∈ Ioo a b,
      HasDerivAt (fun u => harmonicActionPosition Ω (J u) (θ u))
        (harmonicActionVelocity Ω (J t) (θ t)) t ∧
      HasDerivAt (fun u => harmonicActionVelocity Ω (J u) (θ u))
        (-(Ω ^ 2) * harmonicActionPosition Ω (J t) (θ t)) t)
    (s t : ℝ) (hs : s ∈ Ioo a b) (ht : t ∈ Ioo a b),
    J t = J s ∧ θ t = θ s - Ω * (t - s) := by
  exact @MolecularDynamics.harmonicAction_time_formula
```
### 实际依赖 MolecularDynamics.harmonicActionAmplitude
```lean
noncomputable def harmonicActionAmplitude (Ω J : ℝ) : ℝ := Real.sqrt (2 * J / Ω)
```
### 实际依赖 MolecularDynamics.harmonicActionPosition
```lean
noncomputable def harmonicActionPosition (Ω J θ : ℝ) : ℝ :=
  harmonicActionAmplitude Ω J * Real.cos θ
```
### 实际依赖 MolecularDynamics.harmonicActionVelocity
```lean
noncomputable def harmonicActionVelocity (Ω J θ : ℝ) : ℝ :=
  Ω * harmonicActionAmplitude Ω J * Real.sin θ
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-HarmonicTorus",
  "kind": "definition",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "The same change of variables $(x_j,v_j)\\to(I_j,\\theta_j)$, applied to each oscillator, would yield equations of motion $\\dot I_j=0$, $\\dot\\theta_j=-\\Omega_j$. This describes a point winding about a $d$-dimensional torus defined by angular rotation frequencies $\\Omega_j$ and radii $|I_j|$ (Fig. 1.14).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "HarmonicTorus d = Fin d→Real.Angle；角模2π；I为固定action，半径的几何映射不新造定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.oscillatorTorusMotion",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-131"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)
```
### 实际依赖 MolecularDynamics.HarmonicTorus
```lean
abbrev HarmonicTorus (n : ℕ) := Fin n → Real.Angle
```
### 实际依赖 MolecularDynamics.harmonicTorusRotation
```lean
noncomputable def harmonicTorusRotation {n : ℕ} (Ω : Fin n → ℝ) (t : ℝ)
    (θ : HarmonicTorus n) : HarmonicTorus n := fun j => θ j - (Ω j * t : ℝ)
```
### 实际依赖 MD.Ch01.oscillatorTorusMotion
```lean
def oscillatorTorusMotion {d : ℕ} (I Ω : Fin d → ℝ) (θ₀ : HarmonicTorus d)
    (t : ℝ) : (Fin d → ℝ) × HarmonicTorus d := (I, harmonicTorusRotation Ω t θ₀)
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.2-TorusPeriod",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.2",
  "printed_page": "30",
  "pdf_page": "53",
  "statement_latex": "Depending on the ratio of frequencies such motions may be periodic or quasi-periodic;",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.torusperiod",
  "extra_assumptions": [
    "给定周期T；每频率×T为整数圈是精确共振条件；原句没有单独定义commensurate。",
    "[EXTRA] 19号：保留指定T的整数圈判据，补正周期存在或无正周期的有限频率环面准周期表示二分；准周期可有共振，不声称稠密整个环面。"
  ],
  "old_ids": [
    "CH01-132"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem torusperiod :
  ∀ {n : ℕ}
    (Ω : Fin n → ℝ) (T : ℝ) (θ : HarmonicTorus n),
    Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T ↔
      ∀ j, ∃ k : ℤ, (k : ℝ) * (2 * Real.pi) = Ω j * T := by
  exact @MolecularDynamics.harmonicTorusRotation_periodic_iff_integer

/-- Finite-dimensional torus translation: a quasiperiodic representation allows resonances. -/
def torusQuasiperiodic {n : ℕ} (γ : ℝ → HarmonicTorus n) : Prop :=
  ∃ (Ω : Fin n → ℝ) (θ : HarmonicTorus n), γ = fun t => harmonicTorusRotation Ω t θ

theorem torusperiod_classification {n : ℕ} (Ω : Fin n → ℝ) (θ : HarmonicTorus n) :
    (∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) ∨
    (torusQuasiperiodic (fun t => harmonicTorusRotation Ω t θ) ∧
      ¬ ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T) := by
  classical
  by_cases h : ∃ T > 0, Function.Periodic (fun t => harmonicTorusRotation Ω t θ) T
  · exact Or.inl h
  · exact Or.inr ⟨⟨Ω,θ,rfl⟩,h⟩
```
### 实际依赖 MolecularDynamics.HarmonicTorus
```lean
abbrev HarmonicTorus (n : ℕ) := Fin n → Real.Angle
```
### 实际依赖 MolecularDynamics.harmonicTorusRotation
```lean
noncomputable def harmonicTorusRotation {n : ℕ} (Ω : Fin n → ℝ) (t : ℝ)
    (θ : HarmonicTorus n) : HarmonicTorus n := fun j => θ j - (Ω j * t : ℝ)
```
### 实际依赖 MD.Ch01.torusQuasiperiodic
```lean
def torusQuasiperiodic {n : ℕ} (γ : ℝ → HarmonicTorus n) : Prop :=
  ∃ (Ω : Fin n → ℝ) (θ : HarmonicTorus n), γ = fun t => harmonicTorusRotation Ω t θ
```
