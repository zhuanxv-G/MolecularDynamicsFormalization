# EAUDIT18：第2章§2.4.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.4-ImplicitLocal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.4",
  "printed_page": "86",
  "pdf_page": "108",
  "statement_latex": "An implicit method will typically result in a system of nonlinear equations of the form\n\\[g(\\boldsymbol z_{n+1})=\\boldsymbol\\tau_n,\\tag{2.25}\\]\nwhich will need to be solved at each timestep. The right hand side $\\boldsymbol\\tau_n$ is a vector that depends on the previous time-step $\\boldsymbol z_n$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the space where $\\boldsymbol z$ is defined, so we have a square nonlinear system. Typically $g$ will depend on the stepsize and coefficients of the method and will have the property that for $h$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $\\boldsymbol\\tau_n$, that is the mapping $g$ has a bounded and smooth inverse.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.implicitLocal",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。",
    "[EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。",
    "[EXTRA] 补g_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:23:27.796691",
      "before_sha256": "e62be691e5c7254269a7c927b9b62bf3e9de2bee4cc2a0d950856e9c932638f2",
      "after_sha256": "3114765218056373b04ada15843506fc9fb1cd218511f2c4318c51dde548ad4a",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem implicitLocal : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.4-BackwardEulerSolve",
  "kind": "definition",
  "label": "Example 2.6",
  "section": "2.4.4",
  "printed_page": "86",
  "pdf_page": "108",
  "statement_latex": "The Backward Euler method,\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+hf(\\boldsymbol z_{n+1}),\\]\nis an example of an implicit method. The calculation of a timestep involves solving a system of equations of the form\n\\[g(\\boldsymbol w)\\equiv\\boldsymbol w-\\boldsymbol z_n-hf(\\boldsymbol w)=\\boldsymbol0.\\]\nThe map $\\mathcal G_t$ is defined implicitly by the equation\n\\[\\mathcal G_h(\\boldsymbol z)=\\boldsymbol z+hf(\\mathcal G_h(\\boldsymbol z)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "零点即隐式步关系；没有断言每个f/h存在唯一零点。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.backwardEulerResidual",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:23:27.796691",
      "before_sha256": "d6e44b9e34019f5de5282ce4e97e5893907632c40ab6502db4672fc50f24e3bd",
      "after_sha256": "461513a0583c44d7f6207ca54e245b8e3629fe98636dc83120a64fb0cf191fe1",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w

theorem backwardEulerResidual_zero_iff (f : E → E) (h : ℝ) (z w : E) :
    backwardEulerResidual f h z w = 0 ↔ w = z + h • f w := by
  sorry

def backwardEulerMapRelation (f : E → E) (h : ℝ) (G : E → E) : Prop :=
  ∀ z, G z = z + h • f (G z)
```
### 实际依赖 MD.Ch02.backwardEulerMapRelation
```lean
def backwardEulerMapRelation (f : E → E) (h : ℝ) (G : E → E) : Prop :=
  ∀ z, G z = z + h • f (G z)
```
### 实际依赖 MD.Ch02.backwardEulerResidual
```lean
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.4-Newton",
  "kind": "definition",
  "label": null,
  "section": "2.4.4",
  "printed_page": "86–87",
  "pdf_page": "108–109",
  "statement_latex": "Solving the system may then proceed, from an initial guess $\\boldsymbol z_{n+1}^{(0)}$ by use of Newton’s method:\n\\[\\boldsymbol z_{n+1}^{(k+1)}=\\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\\boldsymbol z_n^{(k)})-\\boldsymbol\\tau_n),\\]\nwhere $J^{(k)}$ is the Jacobian matrix of the mapping $g$ evaluated at $\\boldsymbol z_n^{(k)}$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form\n\\[\\boldsymbol b_k=-(g(\\boldsymbol z_n^{(k)})-\\boldsymbol\\tau_n),\\quad J^{(k)}\\Delta\\boldsymbol z_k=\\boldsymbol b_k,\\quad\\boldsymbol z_{n+1}^{(k+1)}=\\boldsymbol z_{n+1}^{(k)}+\\Delta\\boldsymbol z_k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文混用zₙ⁽ᵏ⁾与zₙ₊₁⁽ᵏ⁾；保留两个不同输入，不静默改成相同迭代点。映射可逆也不保证任意近似Jacobian非奇异。"
    }
  ],
  "lean_decl": "MD.Ch02.newtonPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:23:27.796691",
      "before_sha256": "aa4ef780d7a76ba628fceae6bb46cdee39bcd0fc43aa381f5b9275229fe1ae50",
      "after_sha256": "bd36e2d3405c08f2a27023649fb68d3778fa00294f620bdb794238fd8fecff35",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.newtonPrinted
```lean
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.4-NewtonQuadratic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.4",
  "printed_page": "87",
  "pdf_page": "109",
  "statement_latex": "Newton’s method (without approximation of the Jacobian matrix) has a remarkable quadratic convergence property, meaning that, when the initial guess is close the solution, the errors $e_k,e_{k+1}$ at the $k$th and $k+1$st iterations satisfy the relation\n\\[e_{k+1}\\le Ke_k^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "标准Newton的同一个迭代点，前项字面索引疑点另列；e=‖y−x*‖。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.newtonQuadratic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:23:27.796691",
      "before_sha256": "75c9860485167bea8155321830ee4239da6c34af94e88bb2dca7b70fd5055629",
      "after_sha256": "d99c60df48df499486d0b8dd1475231cf93c1e4cc235f3ef6dd145ce23c2b3e1",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean
```lean
theorem newtonQuadratic :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.newtonStep
```lean
def newtonStep {n : ℕ} (g : Q n → Q n) (τ x : Q n) (A : Q n ≃L[ℝ] Q n) : Q n :=
  x - A.symm (g x - τ)
```
