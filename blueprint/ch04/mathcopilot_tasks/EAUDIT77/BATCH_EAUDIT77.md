# EAUDIT77：第4章§4.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-ProjectionResidual",
  "kind": "definition",
  "label": "(4.17)",
  "section": "4.3.2",
  "printed_page": "156",
  "pdf_page": "178",
  "statement_latex": "To solve the Eqs. (4.14)–(4.16), insert the second in the first and the first then in the third to obtain the simplified equation\n\\[g(Q_n-M^{-1}G_n^T\\Lambda)=0,\\tag{4.17}\\]\nwhere\n\\[Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n,\\qquad G_n=g'(q_n),\\qquad\\Lambda=h^2\\lambda_n.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q为旧位置，base为所给Qn，η=Λ；关系只定义残差，不宣称非线性根存在。Fn符号原式已单列，不用一个任意base假装完成动量消元证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.projectionResidual",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补真实零残差方程及原印F符号下base、η=h²λ与旧状态的消元等价；不把残差函数冒充已解投影方程。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "b474c617a6bfcfa75f76f2eb1bb171f04327bbde9c7740071608b37722a3bb6b",
      "after_sha256": "27a586e15652e6f2a47ab8bf3406c350a82f42c98c60c1b0f545f8e2d112157f",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))

def projectionEquation {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  projectionResidual m g q base η=0

theorem projectionResidual_elimination {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (Fprinted : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n)
    (lam : MolecularDynamics.Chapter04Review.Q l)
    (_hp : out.2=z.2-h • Fprinted z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ lam))
    (_hq : out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m out.2) :
    (out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g) ↔
      projectionEquation m g z.1
        (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2-
          h^2 • MolecularDynamics.Chapter04Review.invMass m (Fprinted z.1)) (h^2 • lam) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.projectionEquation
```lean
def projectionEquation {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  projectionResidual m g q base η=0
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-ProjectionJacobian",
  "kind": "definition",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "$R^{(l)}\\Delta\\Lambda^{(l)}=g(Q^{(l)}),\\qquad R^{(l)}\\stackrel{\\mathrm{def}}=g'(Q^{(l)})M^{-1}G_n^T$,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "R是负的残差Jacobian（Q=base−M⁻¹Gᵀη）；保留原Newton加号，不误称R=+Dη残差。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.projectionJacobian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留交叉Jacobian定义，并补实际Newton线性方程RΔΛ=r及Δ=η_next−η；Q依赖base−M⁻¹Gᵀη已在R中展开。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "13c0e7e8bd365099b3d050d938d77894fd2564499ef30a6f6115da6a4e49c9db",
      "after_sha256": "de81674a30a52dd9be2f949968055a25233916f81d2f3299d79c60ea01090efc",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ

def projectionNewtonIncrement {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n)
    (η ηnext : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  let Δ := ηnext-η
  projectionJacobian m g q base η *ᵥ Δ=projectionResidual m g q base η
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MD.Ch04.projectionNewtonIncrement
```lean
def projectionNewtonIncrement {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n)
    (η ηnext : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  let Δ := ηnext-η
  projectionJacobian m g q base η *ᵥ Δ=projectionResidual m g q base η
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-NewtonConstraint",
  "kind": "definition",
  "label": "(4.18)–(4.19)",
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "The simplest is Gauss-Newton iteration, which may be written\n\\[\\Lambda^{(l+1)}=\\Lambda^{(l)}+[g'(Q^{(l)})M^{-1}G_n^T]^{-1}g(Q^{(l)}),\\tag{4.18}\\]\n\\[Q^{(l)}:=Q_n-M^{-1}G_n^T\\Lambda^{(l)},\\tag{4.19}\\]\nwhich might be initialized with $\\Lambda^{(0)}=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际交叉Gram逆及残差，矩阵非奇异时才是合法求解步；初始化η0=0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.newtonConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 真实Newton主接口加入当前交叉矩阵det≠0；补建议初值0的有限序列且逐步可逆资格显式，不把奇异逆总化当合法迭代。Mathlib逆矩阵按标准含义采信。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "73cc0d8233bfa39abc6ecc5d8af9bef5f8cf06fab5c9b9dd15a06aabe4ee2e79",
      "after_sha256": "5eb19aa1d9885152d211e8c332d0ceabdd4780ad78e7c130a6c3b68ffa4d3845",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η

def newtonConstraintSequence {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ)
    (_hvalid : ∀ i < k,
      (MolecularDynamics.Chapter04Review.projectionJacobian m g q base
        ((MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[i] 0)).det ≠ 0) :
    MolecularDynamics.Chapter04Review.Q l :=
  (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.newtonConstraint
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base η)⁻¹ *ᵥ projectionResidual m g q base η
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.newtonConstraint
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```
### 实际依赖 MD.Ch04.newtonConstraintSequence
```lean
def newtonConstraintSequence {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (k : ℕ)
    (_hvalid : ∀ i < k,
      (MolecularDynamics.Chapter04Review.projectionJacobian m g q base
        ((MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[i] 0)).det ≠ 0) :
    MolecularDynamics.Chapter04Review.Q l :=
  (MolecularDynamics.Chapter04Review.newtonConstraint m g q base)^[k] 0
```
### 实际依赖 MD.Ch04.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-NewtonQuadratic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "When the solution is unique, the constraints sufficiently smooth, and the determinant of $R$ is bounded well away from zero, Newton’s method has a very rapid asymptotic convergence property. It is possible to show that, if $\\Lambda_*$ is the solution of (4.17), then sufficiently near the zero we have\n\\[\\|\\Lambda^{(l+1)}-\\Lambda_*\\|\\le C\\|\\Lambda^{(l)}-\\Lambda_*\\|^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.newtonQuadratic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "局部C²约束、真实残差root=0及真实R(root) det≠0；结论给存在邻域/二次界，不假设Newton误差结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "420ba5cfe570cb14c03871bfc0bbee53a367425c1a2b10b5320731ffb098c344",
      "after_sha256": "9e8432a7a285837592185da1e898641f0f3fd2af63f2899a8282a97b789d9742",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:52:56.028825",
      "before_sha256": "9e8432a7a285837592185da1e898641f0f3fd2af63f2899a8282a97b789d9742",
      "after_sha256": "5fdb4584a3c25ff65bfb5c06b9e1497585f536fbb8ca49bf93bb6cc2bb77fc1e",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem newtonQuadratic :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base root).det ≠ 0 → ∃ C > 0, ∃ δ > 0,
    ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ → ‖MolecularDynamics.Chapter04Review.newtonConstraint m g q base η-root‖ ≤ C*‖η-root‖^2 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.newtonConstraint
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base η)⁻¹ *ᵥ projectionResidual m g q base η
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.newtonConstraint
```lean
def newtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l)
    (_hdet : (MolecularDynamics.Chapter04Review.projectionJacobian m g q base η).det ≠ 0) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base η)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```
### 实际依赖 MD.Ch04.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-FrozenNewtonLinear",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.2",
  "printed_page": "157",
  "pdf_page": "179",
  "statement_latex": "When $R$ is evaluated only once per step, the asymptotic convergence of Newton’s method is linear, i.e. we have instead\n\\[\\|\\Lambda^{(l+1)}-\\Lambda_*\\|\\le\\widehat C\\|\\Lambda^{(l)}-\\Lambda_*\\|,\\]\nsufficiently near to the solution.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$g$ is the vector of holonomic constraints; $G_n=g^{\\prime}(q_n)$ is its Jacobian at the old position. PDF p.178 / printed p.156, immediately below (4.17).",
    "$Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n$ is the predictor printed below (4.17); retain this minus sign literally. PDF p.178 / printed p.156.",
    "$\\Lambda=h^2\\lambda_n$ is the scaled vector of constraint multipliers, and $g(Q_n-M^{-1}G_n^T\\Lambda)=0$ is (4.17). PDF p.178 / printed p.156.",
    "$Q^{(l)}=Q_n-M^{-1}G_n^T\\Lambda^{(l)}$ and $R^{(l)}=g^{\\prime}(Q^{(l)})M^{-1}G_n^T$; $l$ is the iteration index. PDF p.179 / printed p.157, (4.19) and the definition of $R^{(l)}$.",
    "$M^{-1}$ is the inverse mass matrix; $h$ is the timestep, and the subscript $n$ labels the old timestep. In the Lean signature, $n$ instead denotes the number of position coordinates, $l$ the number of scalar constraints, and $m$ the vector of diagonal masses.",
    "$\\Lambda_*$ solves (4.17), and $\\Lambda^{(l)}$ is the $l$th iterate. PDF p.179 / printed p.157, the paragraph beginning “When the solution is unique” and the two displayed error estimates.",
    "$\\widehat C$ is the constant printed in the frozen-iteration linear error bound, and $\\|\\cdot\\|$ is the norm on multiplier errors. The textbook does not specify the norm or explicitly print $\\widehat C<1$ in this displayed formula.",
    "“When $R$ is evaluated only once per step” refers to the previously described sufficiently small timestep and sufficiently smooth $g^{\\prime}$, with the matrix fixed at the beginning of the timestep. The neighboring Newton discussion assumes a unique solution, sufficiently smooth constraints, and a determinant bounded away from zero. PDF p.179 / printed p.157."
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.frozenNewtonLinear",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实冻结映射在root的导数范数<1量化small-step收缩资格；det R0≠0、真实root和C²约束，不无条件声称冻结必收敛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "60347fca81b24952be92b40e16507f8c39f5a642f38cb9711602412082d707d9",
      "after_sha256": "2788b8f2488bd2e7bc446f67ce5997dec0c82743002bd1a6067ccc07571ac779",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem frozenNewtonLinear :
  ∀ n l (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q base : MolecularDynamics.Chapter04Review.Q n) (root : MolecularDynamics.Chapter04Review.Q l),
    (∀ j, ContDiff ℝ 2 (g j)) → MolecularDynamics.Chapter04Review.projectionResidual m g q base root=0 →
    (MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0).det ≠ 0 →
    ‖fderiv ℝ (MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base) root‖ < 1 →
    ∃ C ∈ Ioo (0 : ℝ) 1, ∃ δ > 0, ∀ η : MolecularDynamics.Chapter04Review.Q l, ‖η-root‖ < δ →
      ‖MolecularDynamics.Chapter04Review.frozenNewtonConstraint m g q base η-root‖ ≤ C*‖η-root‖ := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.frozenNewtonConstraint
```lean
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  η+(projectionJacobian m g q base 0)⁻¹ *ᵥ projectionResidual m g q base η
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.frozenNewtonConstraint
```lean
def frozenNewtonConstraint {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  η+(MolecularDynamics.Chapter04Review.projectionJacobian m g q base 0)⁻¹ *ᵥ MolecularDynamics.Chapter04Review.projectionResidual m g q base η
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.projectionJacobian
```lean
def projectionJacobian {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : Matrix (Fin l) (Fin l) ℝ :=
  textbookConstraintJacobian g (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η)) *
    textbookInverseMassMatrix m * (textbookConstraintJacobian g q)ᵀ
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.2-ProjectionScale",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.2",
  "printed_page": "158",
  "pdf_page": "180",
  "statement_latex": "It is worth noting that $\\Lambda(h)=O(h^2)$, i.e. for small steps $\\Lambda$ will also be small. This justifies the initial guess $\\Lambda^{(0)}=0$,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$g$ is the vector of holonomic constraints; $G_n=g^{\\prime}(q_n)$ is its Jacobian at the old position. PDF p.178 / printed p.156, immediately below (4.17).",
    "$Q_n=q_n+hM^{-1}p_n-h^2M^{-1}F_n$ is the predictor printed below (4.17); retain this minus sign literally. PDF p.178 / printed p.156.",
    "$\\Lambda=h^2\\lambda_n$ is the scaled vector of constraint multipliers, and $g(Q_n-M^{-1}G_n^T\\Lambda)=0$ is (4.17). PDF p.178 / printed p.156.",
    "$Q^{(l)}=Q_n-M^{-1}G_n^T\\Lambda^{(l)}$ and $R^{(l)}=g^{\\prime}(Q^{(l)})M^{-1}G_n^T$; $l$ is the iteration index. PDF p.179 / printed p.157, (4.19) and the definition of $R^{(l)}$.",
    "$M^{-1}$ is the inverse mass matrix; $h$ is the timestep, and the subscript $n$ labels the old timestep. In the Lean signature, $n$ instead denotes the number of position coordinates, $l$ the number of scalar constraints, and $m$ the vector of diagonal masses.",
    "$\\Lambda(h)$ denotes the solution multiplier of (4.17) as the timestep $h$ varies; $O(h^2)$ is its asymptotic size as $h\\to0$, not the size of the unscaled $\\lambda_n$. PDF p.180 / printed p.158, first paragraph; scaling is printed on PDF p.178.",
    "$\\Lambda^{(0)}=0$ is the initial Newton iterate for a fixed timestep, whereas $\\Lambda(0)=0$ would be the value of a step-dependent root branch at zero step. These are different uses of zero. PDF p.179, (4.18)–(4.19), and PDF p.180, first paragraph.",
    "The excerpt stops after the initial-guess clause; the actual second sentence continues with “and it also suggests” a smaller timestep if convergence is poor. Its printed comma is preserved at the excerpt boundary. PDF p.180 / printed p.158.",
    "PDF p.178 explicitly permits violation of the hidden constraint in the discussed method. The conditional Lean estimate assumes an initially compatible cotangent state; this is a declared extra hypothesis, not an assertion that every method step satisfies the hidden constraint exactly."
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.projectionScale",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定真实C²选根分支η0=0、正则Gram及初始余切资格；非线性根存在是独立缺项，不把O(h²)结论作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:51.275819",
      "before_sha256": "15c058656a8168c4fc44d45921af69245bcb319141d5236db89702e41f46a5fe",
      "after_sha256": "b1fbbb40c220d8ae569bbb9a82806b41d6f8d5a4da07e271da4947c9cfc62cca",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem projectionScale :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (η : ℝ → MolecularDynamics.Chapter04Review.Q l), z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
    (∀ j, ContDiff ℝ 2 (g j)) → ContDiff ℝ 2 η → η 0=0 →
    (textbookConstraintGram m g z.1).det ≠ 0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectionResidual m g z.1 (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2+h^2 • MolecularDynamics.Chapter04Review.invMass m (F z.1)) (η h)=0) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ‖η h‖ ≤ C*h^2 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.cotangentSet
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) : Set (Z n) :=
  {z | z.1 ∈ constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ invMass m z.2=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (q base : Q n) (η : Q l) : Q l :=
  fun j => g j (base-invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MD.Ch04.cotangentSet
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.projectionResidual
```lean
def projectionResidual {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q base : MolecularDynamics.Chapter04Review.Q n) (η : MolecularDynamics.Chapter04Review.Q l) : MolecularDynamics.Chapter04Review.Q l :=
  fun j => g j (base-MolecularDynamics.Chapter04Review.invMass m ((textbookConstraintJacobian g q)ᵀ *ᵥ η))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```
