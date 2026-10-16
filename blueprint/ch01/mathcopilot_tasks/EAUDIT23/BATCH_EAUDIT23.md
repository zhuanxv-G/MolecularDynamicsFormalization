# EAUDIT23：第1章§1.7.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.7.2-FlowJacobianLiteral",
  "kind": "definition",
  "label": null,
  "section": "1.7.2",
  "printed_page": "44",
  "pdf_page": "67",
  "statement_latex": "Let a dynamical system $\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z)$ be given in $\\mathbb R^m$ with flow map $F_t:\\mathbb R^m\\to\\mathbb R^m$ which we assume to be continuously differentiable. Let $\\boldsymbol z(t,\\boldsymbol\\xi)$ represent the solution of initial value problem\n\\[\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z),\\qquad\\boldsymbol z(0)=\\boldsymbol\\xi.\\]\nWe then compute the $m\\times m$ Jacobian matrix of $F_t(\\boldsymbol z(t,\\boldsymbol\\xi))$:\n\\[\\boldsymbol W(t)=F_t'(\\boldsymbol z(t,\\boldsymbol\\xi))=\\frac{\\partial F_t}{\\partial\\boldsymbol z}(\\boldsymbol z(t,\\boldsymbol\\xi)).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "F为C1真实flow，z(t,ξ)=Ftξ；原文字面在Ftξ处对初值变量微分。"
  ],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "标准变分矩阵应为DξFt(ξ)，原文把取值点写Ftξ；忠实保留字面定义，后续两条不静默改。"
    }
  ],
  "lean_decl": "MD.Ch01.variationalMatrixLiteral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-190",
    "CH01-191"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)

/-- 修正版，对应原文 MD-1.7.2-FlowJacobianLiteral，改动：DF_t取值点从F_t(ξ)改为初值ξ。 -/
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.variationalMatrixLiteral
```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)
```
### 实际依赖 MD.Ch01.variationalMatrixLiteral_corrected
```lean
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```

## 原文JSON
```json
{
  "source_id": "MD-1.7.2-VariationalEquationLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.2",
  "printed_page": "44–45",
  "pdf_page": "67–68",
  "statement_latex": "Differentiating $\\boldsymbol W(t)$ with respect to $t$ and using the differential equation and the chain rule, we have\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\boldsymbol W(t)=\\boldsymbol f'(\\boldsymbol z(t,\\boldsymbol\\xi))\\boldsymbol W(t).\\tag{1.10}\\]\nThe system of Eq. (1.10) is referred to as the system of variational equations corresponding to the dynamical system $\\mathrm d\\boldsymbol z/\\mathrm dt=\\boldsymbol f(\\boldsymbol z)$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "标准W应在ξ处取DFt。取全局光滑完备流f(x)=sin x，在ξ=π/2附近Ft(x)=2 arctan(e^t tan(x/2))；t=log 2时字面W=10/17，W′=-198/289，而f′(Ftξ)W=-6/17=-102/289，不相等。"
    }
  ],
  "lean_decl": "MD.Ch01.variationalequationliteral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-192"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem variationalequationliteral :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral F ξ t)) t := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-VariationalEquationLiteral，改动：采用W(t)=DF_t(ξ)，保留C¹向量场及真实流资格。 -/
theorem variationalequationliteral_corrected :
  ∀ (n : ℕ) (f : Position n → Position n) (F : ℝ → Position n → Position n),
    ContDiff ℝ 1 f → differentiableFlow F → isFlowOf f F →
    ∀ ξ t, HasDerivAt (fun s => variationalMatrixLiteral_corrected F ξ s)
      ((fderiv ℝ f (F t ξ)).comp (variationalMatrixLiteral_corrected F ξ t)) t := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.differentiableFlow
```lean
def differentiableFlow {n : ℕ} (F : ℝ → Position n → Position n) : Prop :=
  ∀ t, ContDiff ℝ 1 (F t)
```
### 实际依赖 MolecularDynamics.Chapter01Review.isFlowOf
```lean
def isFlowOf {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ x, F 0 x = x) ∧ ∀ x t, HasDerivAt (fun s => F s x) (f (F t x)) t
```
### 实际依赖 MD.Ch01.variationalMatrixLiteral
```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)
```
### 实际依赖 MD.Ch01.variationalMatrixLiteral_corrected
```lean
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```

## 原文JSON
```json
{
  "source_id": "MD-1.7.2-NearbyTrajectoryLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.2",
  "printed_page": "45",
  "pdf_page": "68",
  "statement_latex": "If we have two solutions started from nearby initial conditions $\\boldsymbol\\xi,\\hat{\\boldsymbol\\xi}$, then their difference is approximated by the solution of the variational equations\n\\[\\boldsymbol z(t,\\hat{\\boldsymbol\\xi})-\\boldsymbol z(t,\\boldsymbol\\xi)\\approx\\boldsymbol W(t)(\\hat{\\boldsymbol\\xi}-\\boldsymbol\\xi).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "同一全局sin流在ξ=π/2,t=log 2时DFt(ξ)=4/5，字面DFt(Ftξ)=10/17；差额线性项不为小o。须导师裁定取值点，当前不静默修正。"
    }
  ],
  "lean_decl": "MD.Ch01.nearby_trajectory_literal",
  "extra_assumptions": [
    "≈严格化为固定t、扰动趋0的Frechet小o；沿用原文字面W。"
  ],
  "old_ids": [
    "CH01-193"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem nearby_trajectory_literal :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.2-NearbyTrajectoryLiteral，改动：线性化在初值ξ处取DF_t，固定t的余项为o(扰动)。 -/
theorem nearby_trajectory_literal_corrected :
  ∀ (n : ℕ) (F : ℝ → Position n → Position n), differentiableFlow F →
    ∀ t ξ, (fun x => F t x-F t ξ-variationalMatrixLiteral_corrected F ξ t (x-ξ))
      =o[𝓝 ξ] (fun x => x-ξ) := by
  intro n F hF t ξ
  exact ((hF t).differentiable (by norm_num) ξ).hasFDerivAt.isLittleO
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.differentiableFlow
```lean
def differentiableFlow {n : ℕ} (F : ℝ → Position n → Position n) : Prop :=
  ∀ t, ContDiff ℝ 1 (F t)
```
### 实际依赖 MD.Ch01.variationalMatrixLiteral
```lean
def variationalMatrixLiteral {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) (F t ξ)
```
### 实际依赖 MD.Ch01.variationalMatrixLiteral_corrected
```lean
def variationalMatrixLiteral_corrected {n : ℕ} (F : ℝ → Position n → Position n)
    (ξ : Position n) (t : ℝ) := fderiv ℝ (F t) ξ
```
