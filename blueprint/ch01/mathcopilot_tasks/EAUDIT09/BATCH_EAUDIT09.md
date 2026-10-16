# EAUDIT09：第1章§1.5.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.5.1-FlowEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "26",
  "pdf_page": "49",
  "statement_latex": "The flow map of a Hamiltonian system conserves its Hamiltonian, thus\n\\[H(\\mathcal F_t(\\boldsymbol\\xi))=H(\\boldsymbol\\xi).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.flow_energy",
  "extra_assumptions": [
    "H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。"
  ],
  "old_ids": [
    "CH01-101"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ := by
  intro ξ t
  have hd (s : ℝ) : HasDerivAt (fun u => H (F u ξ)) 0 s := by
    let z := F s ξ
    let A := fderiv ℝ H z
    have hA : HasFDerivAt H A z := (hH z).hasFDerivAt
    have hq := hA.comp z.1 ((hasFDerivAt_id (𝕜 := ℝ) z.1).prodMk (hasFDerivAt_const (𝕜 := ℝ) z.2 z.1))
    have hp := hA.comp z.2 ((hasFDerivAt_const (𝕜 := ℝ) z.1 z.2).prodMk (hasFDerivAt_id (𝕜 := ℝ) z.2))
    simp only [Function.comp_def, id_eq] at hq hp
    let gq := gradient (fun q => H (q,z.2)) z.1
    let gp := gradient (fun p => H (z.1,p)) z.2
    have eqQ (v : Position n) : A (v,0) = inner ℝ gq v := by
      rw [inner_gradient_left, hq.fderiv]
      rfl
    have eqP (v : Position n) : A (0,v) = inner ℝ gp v := by
      rw [inner_gradient_left, hp.fderiv]
      rfl
    have hz : A (symplecticGradient H z) = 0 := by
      change A (gp,-gq) = 0
      have he : (gp,-gq) = (gp,0)+(0,-gq) := by simp
      rw [he, map_add, eqQ, eqP, inner_neg_right, real_inner_comm gq gp]
      ring
    have hh := hA.comp_hasDerivAt s ((hF ξ).2 s)
    have he : A (symplecticGradient H (F s ξ)) = 0 := hz
    rw [he] at hh
    simpa only [Function.comp_def] using hh
  have hc := is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
  simpa [(hF ξ).1] using hc
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
### 实际依赖 MolecularDynamics.Chapter01Review.symplecticGradient
```lean
def symplecticGradient {d : ℕ} (H : PhaseSpace d → ℝ) (z : PhaseSpace d) : PhaseSpace d :=
  (gradient (fun p => H (z.1,p)) z.2, -gradient (fun q => H (q,z.2)) z.1)
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.1-HarmonicPhaseFlow",
  "kind": "definition",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "for which the solution subject to initial values $q(0)=q_0,p(0)=p_0$ is\n\\[\\begin{pmatrix}q(t)\\\\p(t)\\end{pmatrix}=\\mathcal F_t\\begin{pmatrix}q_0\\\\p_0\\end{pmatrix}=\\begin{pmatrix}q_0\\cos(\\Omega t)+p_0\\sin(\\Omega t)/\\Omega\\\\-q_0\\Omega\\sin(\\Omega t)+p_0\\cos(\\Omega t)\\end{pmatrix}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "p.26方程q′=p,p′=-Ω²q；Ω≠0域；§1.2已有真实解与初值证明。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.harmonicPhaseFlow",
  "extra_assumptions": [
    "[EXTRA] 19号：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。"
  ],
  "old_ids": [
    "CH01-102"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)

theorem harmonicPhaseFlow_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    harmonicPhaseFlow Ω 0 z = z ∧
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω^2)) • q) univ univ (fun t => harmonicPhaseFlow Ω t z) := by
  constructor
  · simp [harmonicPhaseFlow]
  · exact harmonicFlow_isMechanicalSolution Ω hΩ z
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
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
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MD.Ch01.harmonicPhaseFlow
```lean
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
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
  "source_id": "MD-1.5.1-SpectralSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "If $\\boldsymbol A$ has a basis of eigenvectors $\\boldsymbol\\eta_i$, $i=1,\\ldots,m$, with corresponding eigenvalues $\\lambda_1,\\lambda_2,\\ldots,\\lambda_m$, then we may write the solution at time $t$ as\n\\[\\boldsymbol z(t)=\\sum_{i=1}^{m}c_i e^{\\lambda_i(t-t_0)}\\boldsymbol\\eta_i\\]\nwhere the coefficients $c_i$ are obtained by solving the equation\n\\[\\boldsymbol z(t_0)=\\boldsymbol\\xi=\\sum_{i=1}^{m}c_i\\boldsymbol\\eta_i.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "允许复数特征值，不偷换为实谱。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.spectralsolution",
  "extra_assumptions": [
    "有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。"
  ],
  "old_ids": [
    "CH01-103"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem spectralsolution :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E] {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ),
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i := by
  exact @MolecularDynamics.complexExponentialFlow_eigenbasis
```
### 实际依赖 MolecularDynamics.complexExponentialFlow
```lean
noncomputable def complexExponentialFlow (A : E →L[ℂ] E) (t : ℝ) (z : E) : E :=
  linearExponentialFlow (A.restrictScalars ℝ) t z

omit [CompleteSpace E] in
 theorem hasDerivAt_complexEigenmode (A : E →L[ℂ] E) (ν : ℂ) (η : E)
    (hη : A η = ν • η) (t₀ t : ℝ) :
    HasDerivAt (fun u : ℝ => Complex.exp (ν * ((u - t₀ : ℝ) : ℂ)) • η)
      (A (Complex.exp (ν * ((t - t₀ : ℝ) : ℂ)) • η)) t := by
  have hscale : HasDerivAt (fun u : ℂ => ν * u) ν (t - t₀ : ℝ) := by
    simpa using (hasDerivAt_id ((t - t₀ : ℝ) : ℂ)).const_mul ν
  have he := ((Complex.hasDerivAt_exp (ν * ((t - t₀ : ℝ) : ℂ))).comp
    ((t - t₀ : ℝ) : ℂ) hscale).comp_ofReal
  have h := (he.scomp t ((hasDerivAt_id t).sub_const t₀)).smul_const η
  rw [one_smul] at h
  rw [map_smul, hη, smul_smul]
  exact h
```
### 实际依赖 MolecularDynamics.linearExponentialFlow
```lean
noncomputable def linearExponentialFlow (A : E →L[ℝ] E) (t : ℝ) (z : E) : E :=
  NormedSpace.exp (t • A) z

omit [CompleteSpace E] in @[simp] theorem linearExponentialFlow_zero (A : E →L[ℝ] E) (z : E) :
    linearExponentialFlow A 0 z = z := by
  simp [linearExponentialFlow]
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.1-BasisCoefficients",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "(ii) with our assumption that the $\\{\\boldsymbol\\eta_i\\}$ form a basis, the calculation of the coefficients will always be possible, since the matrix $\\boldsymbol X$ whose columns are the eigenvectors will be invertible, that is, the coefficients $c_i$ can be enumerated as the components of a vector $\\boldsymbol c$ which satisfies the square linear system\n\\[\\boldsymbol\\xi=\\boldsymbol X\\boldsymbol c.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.basis_coefficients",
  "extra_assumptions": [
    "RCLike域包含实/复两种；真实有限基。"
  ],
  "old_ids": [
    "CH01-105"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  exact ⟨basisColumnMatrix_isUnit b, basisColumnMatrix_mulVec_repr b z,
    basisColumnMatrix_inverse_coefficients b z⟩
```
### 实际依赖 MolecularDynamics.basisColumnMatrix
```lean
noncomputable def basisColumnMatrix {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m))) :
    Matrix (Fin m) (Fin m) 𝕜 := fun i j => b j i
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.1-MatrixExponentialSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.1",
  "printed_page": "27",
  "pdf_page": "50",
  "statement_latex": "An alternative expression for the solution is in terms of the exponential of the matrix $\\boldsymbol A$ scaled by time,\n\\[\\boldsymbol z(t)=e^{\\boldsymbol A(t-t_0)}\\boldsymbol\\xi.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "matrixExponentialFlow_eq把连续算子指数对应到真正矩阵指数。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.matrixexponentialsolution",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-106"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem matrixexponentialsolution :
  ∀ {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z),
    γ = fun t => matrixExponentialFlow A (t - t₀) z := by
  exact @MolecularDynamics.matrixExponentialFlow_unique
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.linearExponentialFlow
```lean
noncomputable def linearExponentialFlow (A : E →L[ℝ] E) (t : ℝ) (z : E) : E :=
  NormedSpace.exp (t • A) z

omit [CompleteSpace E] in @[simp] theorem linearExponentialFlow_zero (A : E →L[ℝ] E) (z : E) :
    linearExponentialFlow A 0 z = z := by
  simp [linearExponentialFlow]
```
### 实际依赖 MolecularDynamics.matrixExponentialFlow
```lean
noncomputable def matrixExponentialFlow {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (t : ℝ) (z : Position m) : Position m :=
  linearExponentialFlow (Matrix.toEuclideanCLM (n := Fin m) (𝕜 := ℝ) A) t z
```
