# EAUDIT04：第1章§1.5.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.5.3-EquilibriumLinearization",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31",
  "pdf_page": "54",
  "statement_latex": "We assume that $f$ is continuously differentiable in the vicinity of the equilibrium point $\\boldsymbol z^*$ and make use of the fact that $f(\\boldsymbol z)\\approx f(\\boldsymbol z^*)+f'(\\boldsymbol z^*)(\\boldsymbol z-\\boldsymbol z^*)$ for $\\|\\boldsymbol z-\\boldsymbol z^*\\|$ sufficiently small. Since $f(\\boldsymbol z^*)=0$ we have, defining $\\delta\\boldsymbol z:=\\boldsymbol z-\\boldsymbol z^*$,\n\\[\\frac{\\mathrm d\\delta\\boldsymbol z}{\\mathrm dt}=\\boldsymbol A\\delta\\boldsymbol z,\\qquad\\boldsymbol A=f'(\\boldsymbol z^*).\\]\nThe symbol $\\approx$ is not very precise.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "小o余项将≈精确定义为一阶近似；δ的线性ODE是近似系统，不声称非线性扰动精确满足Aδ。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.equilibriumlinearization",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-137",
    "CH01-138"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem equilibriumlinearization :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (z₀ h₀ : E) (t₀ : ℝ)
    (hF : ContDiffAt ℝ 1 f z₀) (heq : f z₀ = 0),
    ∃ δ : ℝ → E, δ t₀ = h₀ ∧
      (∀ t, HasDerivAt δ ((fderiv ℝ f z₀) (δ t)) t) ∧
      (equilibriumLinearizationRemainder f z₀ (fderiv ℝ f z₀)) =o[𝓝 0] (fun h : E => h) := by
  exact @MolecularDynamics.equilibrium_linearized_IVP
```
### 实际依赖 MolecularDynamics.equilibriumLinearizationRemainder
```lean
def equilibriumLinearizationRemainder (f : E → E) (z₀ : E) (A : E →L[ℝ] E) (h : E) : E :=
  f (z₀ + h) - A h
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.3-HartmanGrobmanLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "31–32",
  "pdf_page": "54–55",
  "statement_latex": "then one can infer that the solutions of the nonlinear and linear systems are in fact topologically conjugate: if $\\boldsymbol z$ is the solution of the nonlinear system and $\\delta\\boldsymbol z$ is the solution of the linear system, then there is a smooth, invertible map $\\boldsymbol\\Phi$ of $\\mathbb R^m$ defined in a neighborhood of the origin such that\n\\[\\boldsymbol z(t)=\\boldsymbol z^*+\\boldsymbol\\Phi(\\delta\\boldsymbol z(t)).\\]\nThis is referred to as the Hartman-Grobman theorem (for more discussion see [177], where this result is referred to as the “Linearization Theorem”; a proof may be found in [362]).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文smooth invertible强于常见Hartman–Grobman的homeomorphism，C1仅双曲不保证光滑共轭。"
    }
  ],
  "lean_decl": "MD.Ch01.hartmangrobmanliteral",
  "extra_assumptions": [
    "C1全域模型及真实全局流为局部应用的技术资格；共轭在轨迹保持局部域时断言。"
  ],
  "old_ids": [
    "CH01-140"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hartmangrobmanliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContDiffOn ℝ ∞ φ U ∧ ContDiffOn ℝ ∞ ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry

/-- 修正版，对应原文 MD-1.5.3-HartmanGrobmanLiteral，改动：C∞可逆坐标替换改为连续互逆局部同胚；保留零点、邻域与留域期间共轭公式。 -/
theorem hartmangrobmanliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → f z = 0 → hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    ∃ (U V : Set (Position n)) (φ ψ : Position n → Position n),
      IsOpen U ∧ IsOpen V ∧ 0 ∈ U ∧ 0 ∈ V ∧ φ 0 = 0 ∧
      ContinuousOn φ U ∧ ContinuousOn ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      ∀ x ∈ U, ∀ t : ℝ,
        (∀ s ∈ uIcc 0 t, linearExponentialFlow (fderiv ℝ f z) s x ∈ U) →
        F t (z+φ x) = z+φ (linearExponentialFlow (fderiv ℝ f z) t x) := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.hyperbolic
```lean
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
```
### 实际依赖 MolecularDynamics.Chapter01Review.isFlowOf
```lean
def isFlowOf {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ x, F 0 x = x) ∧ ∀ x t, HasDerivAt (fun s => F s x) (f (F t x)) t
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
  "source_id": "MD-1.5.3-HyperbolicStabilityTransfer",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "The Hartman-Grobman theorem clearly implies that the stability of a given hyperbolic equilibrium point $\\boldsymbol z^*$ of a nonlinear system can be inferred from the stability of the origin for the linearization of the system around $\\boldsymbol z^*$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hyperbolicstabilitytransfer",
  "extra_assumptions": [
    "C1及真实全局流；stable谓词的统一界<ε与原文严格sup形式等价。"
  ],
  "old_ids": [
    "CH01-142"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hyperbolicstabilitytransfer :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry

/-- 修正版，对应原文 MD-1.5.3-HyperbolicStabilityTransfer，改动：显式独立登记以拓扑共轭为依据的稳定性转移，不调用光滑literal。 -/
theorem hyperbolicstabilitytransfer_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (z : Position n)
    (F : ℝ → Position n → Position n), ContDiff ℝ 1 f → f z = 0 →
    hyperbolic (fderiv ℝ f z) → isFlowOf f F →
    (stable F z ↔ stable (fun t x => linearExponentialFlow (fderiv ℝ f z) t x) 0) := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.hyperbolic
```lean
def hyperbolic {n : ℕ} (A : Position n →L[ℝ] Position n) : Prop :=
  ∀ (a b : ℝ) (x y : Position n), (x ≠ 0 ∨ y ≠ 0) →
    A x = a • x - b • y → A y = b • x + a • y → a ≠ 0
```
### 实际依赖 MolecularDynamics.Chapter01Review.isFlowOf
```lean
def isFlowOf {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ x, F 0 x = x) ∧ ∀ x t, HasDerivAt (fun s => F s x) (f (F t x)) t
```
### 实际依赖 MolecularDynamics.linearExponentialFlow
```lean
noncomputable def linearExponentialFlow (A : E →L[ℝ] E) (t : ℝ) (z : E) : E :=
  NormedSpace.exp (t • A) z

omit [CompleteSpace E] in @[simp] theorem linearExponentialFlow_zero (A : E →L[ℝ] E) (z : E) :
    linearExponentialFlow A 0 z = z := by
  simp [linearExponentialFlow]
```
### 实际依赖 MolecularDynamics.Chapter01Review.stable
```lean
def stable {n : ℕ} (F : ℝ → Position n → Position n) (z : Position n) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, dist x z < δ →
    ∃ B : ℝ, B < ε ∧ ∀ t ≥ 0, dist (F t x) z ≤ B
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.3-LinearizedHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "1.5.3",
  "printed_page": "32",
  "pdf_page": "55",
  "statement_latex": "If the potential is $C^2$, then the linearized version is of the same “kinetic plus potential” form with Hamiltonian\n\\[\\widetilde H=\\frac{\\delta\\boldsymbol p^T\\boldsymbol M^{-1}\\delta\\boldsymbol p}2+\\frac{\\delta\\boldsymbol q^T U''(\\boldsymbol q^*)\\delta\\boldsymbol q}2.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "C2使fderiv gradient为真实Hessian；定义只登记该二次Hamiltonian形式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.linearizedHamiltonian",
  "extra_assumptions": [
    "[EXTRA] 19号：保留二次型定义，补正定质量、C²势、平衡点资格及原Hamilton向量场导数等于二次Hamilton向量场的完整对应。"
  ],
  "old_ids": [
    "CH01-146"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def linearizedHamiltonian {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (δq δp : Position n) : ℝ :=
  inner ℝ δp (matrixAction M⁻¹ δp)/2 + inner ℝ δq (fderiv ℝ (gradient U) qstar δq)/2

theorem linearizedHamiltonian_field {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hM : M.PosDef)
    (hU : ContDiff ℝ 2 U) (heq : gradient U qstar = 0) :
    ∀ δz : PhaseSpace n,
      fderiv ℝ (symplecticGradient (fun z : PhaseSpace n =>
        inner ℝ z.2 (matrixAction M⁻¹ z.2)/2 + U z.1)) (qstar,0) δz =
      symplecticGradient (fun z : PhaseSpace n => linearizedHamiltonian M U qstar z.1 z.2) δz := by
  sorry
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
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
### 实际依赖 MD.Ch01.linearizedHamiltonian
```lean
def linearizedHamiltonian {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (δq δp : Position n) : ℝ :=
  inner ℝ δp (matrixAction M⁻¹ δp)/2 + inner ℝ δq (fderiv ℝ (gradient U) qstar δq)/2
```
### 实际依赖 MD.Ch01.matrixAction
```lean
noncomputable def matrixAction {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (v : Position n) : Position n := Matrix.toEuclideanLin A v
```
### 实际依赖 MolecularDynamics.Chapter01Review.symplecticGradient
```lean
def symplecticGradient {d : ℕ} (H : PhaseSpace d → ℝ) (z : PhaseSpace d) : PhaseSpace d :=
  (gradient (fun p => H (z.1,p)) z.2, -gradient (fun q => H (q,z.2)) z.1)
```

## 原文JSON
```json
{
  "source_id": "MD-1.5.3-PositiveHessianQuadratic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "A condition for this system to have a strong local minimum at $\\delta\\boldsymbol p=0$, $\\delta\\boldsymbol q=0$ is that the Hessian matrix $U''(\\boldsymbol q^*)$ be positive definite.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.positivehessianquadratic",
  "extra_assumptions": [
    "M正定，K=U″对称正定；一般矩阵。"
  ],
  "old_ids": [
    "CH01-147"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem positivehessianquadratic :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    IsStrictPotentialMin (fun z : PhaseSpace n =>
      inner ℝ z.2 (M⁻¹.toEuclideanLin z.2)/2 + inner ℝ z.1 (K.toEuclideanLin z.1)/2) 0 := by
  intro n M K hM hK
  have hn (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosSemidef) (v : Position n) :
      0 ≤ inner ℝ v (A.toEuclideanLin v) := by
    change 0 ≤ inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    simpa using ha.dotProduct_mulVec_nonneg (x := WithLp.ofLp v)
  have hp (A : Matrix (Fin n) (Fin n) ℝ) (ha : A.PosDef) (v : Position n) (hv : v ≠ 0) :
      0 < inner ℝ v (A.toEuclideanLin v) := by
    change 0 < inner ℝ v (Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) A v)
    rw [Matrix.inner_toEuclideanCLM]
    have hv' : WithLp.ofLp v ≠ 0 := by simpa using hv
    simpa using ha.dotProduct_mulVec_pos hv'
  refine ⟨1,by norm_num,?_⟩
  intro z hz _
  have hzn : z ≠ 0 := dist_pos.mp hz
  have hq := hn K hK.posSemidef z.1
  have hpp := hn M⁻¹ hM.inv.posSemidef z.2
  have hz0 : inner ℝ ((0:PhaseSpace n).2) (M⁻¹.toEuclideanLin (0:PhaseSpace n).2)/2 +
      inner ℝ ((0:PhaseSpace n).1) (K.toEuclideanLin (0:PhaseSpace n).1)/2 = 0 := by
    change inner ℝ (0:Position n) (M⁻¹.toEuclideanLin 0)/2 + inner ℝ (0:Position n) (K.toEuclideanLin 0)/2 = 0
    simp
  dsimp only
  rw [hz0]
  by_cases hqz : z.1 = 0
  · have hpz : z.2 ≠ 0 := by
      intro h; exact hzn (Prod.ext hqz h)
    nlinarith [hp M⁻¹ hM.inv z.2 hpz]
  · nlinarith [hp K hK z.1 hqz]
```
### 实际依赖 MolecularDynamics.IsStrictPotentialMin
```lean
def IsStrictPotentialMin {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) : Prop :=
  ∃ R : ℝ, 0 < R ∧ ∀ q, 0 < dist q q₀ → dist q q₀ < R → U q₀ < U q
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

## 原文JSON
```json
{
  "source_id": "MD-1.5.3-PositiveHessianMinimum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5.3",
  "printed_page": "33",
  "pdf_page": "56",
  "statement_latex": "In case the eigenvalues of $U''(\\boldsymbol q^*)$ are all distinct and positive, then the strong local minimum property will also follow for $\\boldsymbol q^*$ in relation to the original potential.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.positive_hessian_minimum",
  "extra_assumptions": [
    "C2与平衡∇U=0来自同节；显式特征基表达全部distinct positive eigenvalues。"
  ],
  "old_ids": [
    "CH01-148"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem positive_hessian_minimum {n : ℕ} (U : PotentialEnergy n) (q : Position n)
    (hU : ContDiff ℝ 2 U) (hq : gradient U q = 0)
    (B : Module.Basis (Fin n) ℝ (Position n)) (freq : Fin n → ℝ)
    (hdistinct : Function.Injective freq) (hpos : ∀ i, 0 < freq i)
    (heig : ∀ i, fderiv ℝ (gradient U) q (B i) = freq i • B i) :
    IsStrictPotentialMin U q := by
  sorry

/- END FULL SECTION 1.5 -/

/- BEGIN FULL SECTION 1.6 -/
```
### 实际依赖 MolecularDynamics.IsStrictPotentialMin
```lean
def IsStrictPotentialMin {E : Type*} [MetricSpace E]
    (U : E → ℝ) (q₀ : E) : Prop :=
  ∃ R : ℝ, 0 < R ∧ ∀ q, 0 < dist q q₀ → dist q q₀ < R → U q₀ < U q
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
