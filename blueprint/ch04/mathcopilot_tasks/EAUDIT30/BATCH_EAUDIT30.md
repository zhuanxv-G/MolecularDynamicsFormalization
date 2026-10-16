# EAUDIT30：第4章§4.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3-HolonomicRelation",
  "kind": "definition",
  "label": "(4.3)",
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "In this section we consider holonomic constraints which may be expressed in terms of positions only, and perhaps time, i.e.\n\\[g(q,t)=0.\\tag{4.3}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "g的真实位置/时间函数；不同于任意独立动量约束。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.holonomicRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "5bead929413907bebf3e3eff9760e33c91dc8b0bc7b8b50bda1e6ee89481250a",
      "after_sha256": "bddc34d38be1737798357c75b117c9ad60c773472aef27ca9c4bad0dcb2a81c7",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.holonomicRelation
```lean
def holonomicRelation {n l : ℕ} (g : MolecularDynamics.Chapter04Review.Q n → ℝ → MolecularDynamics.Chapter04Review.Q l) (q : ℝ → MolecularDynamics.Chapter04Review.Q n) : Prop :=
  ∀ t, g (q t) t=0
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-ConstrainedSolution",
  "kind": "definition",
  "label": "(4.4)–(4.9)",
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "the equations of motion may be written\n\\[\\dot q=M^{-1}p,\\tag{4.4}\\]\n\\[\\dot p=-\\nabla U(q)-\\sum_{k=1}^l\\lambda_k\\nabla g_k(q),\\tag{4.5}\\]\n\\[0=g_j(q),\\quad j=1,2,\\ldots,l.\\tag{4.6}\\]\nthen we may write the constrained equations of motion in the form\n\\[\\dot q=M^{-1}p,\\tag{4.7}\\qquad\\dot p=-\\nabla U(q)-g'(q)^T\\lambda,\\tag{4.8}\\qquad0=g(q).\\tag{4.9}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=−grad U代入所给一般位置力定义；实际各时刻导数和逐分量约束，不假定λ存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedSolution",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 教材主接口固定F=−∇U、正质量、经典可微U/g及开时间域上真实导数；任意位置力/within总化接口改名保留辅助，不冒充教材机械系统。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "2a763320078008594f992690855d70efb4bb3cbd7b57ffb2d6af032726e5d35c",
      "after_sha256": "ff2af1505e57aaad0f4a7f2d881cdbc58d9bec41c4d8fd72c43fa682fc85c687",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g

def constrainedSolution_generalForce {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
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
### 实际依赖 MD.Ch04.constrainedSolution
```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```
### 实际依赖 MD.Ch04.constrainedSolution_generalForce
```lean
def constrainedSolution_generalForce {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
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
  "source_id": "MD-4.3-ConstraintSet",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "Constraints such as those described above define a manifold in the configuration space $\\mathcal M=\\{q\\mid g(q)=0\\}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintSet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "定义仅集合；称为光滑流形需要独立梯度/正则值资格，未构造抽象流形。",
    "[EXTRA] 零点集合定义保留；补C∞及满秩的真实局部光滑坐标正规形，零点集对应l个坐标为零，即余维l嵌入流形资格；l≤n及正则性均标EXTRA，新结论暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "5b9fa63b38ada516a0db2fd84d8f0a57e165820cd63183b87bcc6967d4b61e5d",
      "after_sha256": "0a50905b46c803f3683604e6776c80d5ba596658d618679e3903ded1bf267b97",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}

theorem constraintSet_regularLevel (n l : ℕ) (_hln : l ≤ n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ ⊤ (g j))
    (q : MolecularDynamics.Chapter04Review.Q n) (_hq : q ∈ constraintSet g)
    (_hregular : Function.Surjective (fderiv ℝ (fun x j ↦ g j x) q)) :
    ∃ A B : Set (MolecularDynamics.Chapter04Review.Q n), IsOpen A ∧ IsOpen B ∧ q ∈ A ∧ 0 ∈ B ∧
      ∃ φ ψ : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n,
        ContDiffOn ℝ ⊤ φ A ∧ ContDiffOn ℝ ⊤ ψ B ∧ φ q=0 ∧
        MapsTo φ A B ∧ MapsTo ψ B A ∧
        (∀ x ∈ A, ψ (φ x)=x) ∧ (∀ y ∈ B, φ (ψ y)=y) ∧
        (∀ x ∈ A, x ∈ constraintSet g ↔ ∀ j : Fin l, φ x (Fin.castLE _hln j)=0) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-ConstraintJacobian",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "It is often convenient to combine all the constraints and to describe them by a single vector-valued function $g:\\mathbb R^{N_c}\\to\\mathbb R^l$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "g′由各真实Fréchet偏导组成，原页方程(4.8)的Jacobian对象。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constraintJacobian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 在同一source_id补原句真正的标量约束合并向量函数；Jacobian作为相邻(4.8)记号辅助保留，两对象明确。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "2cb8ed6f6ffc75cc40d387ef8741aa35a732bd20c6013b884e7eb65ba90a59a4",
      "after_sha256": "a0f18e4f02562294b34a5609747cad3fda2ab39fa6c2a96f5fa5cb833165b05a",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i

def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.combineConstraints
```lean
def combineConstraints {n l : ℕ}
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) :
    MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q l :=
  fun q j ↦ g j q
```
### 实际依赖 MD.Ch04.constraintJacobian
```lean
noncomputable def constraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-JacobianActualDerivative",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3",
  "printed_page": "152",
  "pdf_page": "174",
  "statement_latex": "Given a motion $(q(t),p(t),\\lambda(t))$ of (4.7)–(4.9) we note that $g(q(t))\\equiv0$ at all times $t$, hence, by differentiation\n\\[g'(q(t))\\dot q(t)\\equiv0,\\]\nwhich we may rephrase as\n\\[g'(q(t))M^{-1}p(t)\\equiv0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.jacobianActualDerivative",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative"
  ],
  "extra_assumptions": [
    "[EXTRA]本条桥接真实向量Jacobian，不以它冒充完整曲线隐藏约束保持；实际曲线/ODE不变性另条保留。",
    "[EXTRA] 保留Jacobian实际导数桥接已有证明，补实际曲线、邻域约束恒零及ODE速度的求导结论，完整包含Gqdot=0与隐藏GMinvp=0。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "379029702dcbd35a3c8b311ae1f43ab956135c3f9a6db97859193fbfdd97a48b",
      "after_sha256": "a64f6161fdbc2ad3296ab85fc1789d9e0648b07c622405373a99fb2b90858ea6",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH07_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem jacobianActualDerivative {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ)
    (hγ : ∀ j, DifferentiableAt ℝ (γ j) q) :
    textbookConstraintJacobian γ q =
      LinearMap.toMatrix' (fderiv ℝ (fun y j => γ j y) q).toLinearMap := by
  apply MolecularDynamics.textbookConstraintJacobian_eq_actualDerivative <;> assumption

theorem jacobianActualDerivative_curve (n l : ℕ)
    (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (p v : MolecularDynamics.Chapter04Review.Q n) (t : ℝ)
    (_hg : ∀ j, DifferentiableAt ℝ (g j) (q t)) (_hq : HasDerivAt q v t)
    (_hv : v=MolecularDynamics.Chapter04Review.invMass m p)
    (_hc : ∀ᶠ s in 𝓝 t, ∀ j, g j (q s)=0) :
    textbookConstraintJacobian g (q t) *ᵥ v=0 ∧
    textbookConstraintJacobian g (q t) *ᵥ MolecularDynamics.Chapter04Review.invMass m p=0 := by
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
  "source_id": "MD-4.3-FlexiblePendulumHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "150",
  "pdf_page": "172",
  "statement_latex": "We suppose the restraint to have an associated coefficient $k=\\varepsilon^{-1}$, where $\\varepsilon$ is a small parameter. Then we have a generalized flexible pendulum with Hamiltonian $H=\\|p\\|^2/(2m)+U(q)+\\varepsilon^{-1}(\\|q\\|-r_0)^2/2$ (see the left panel of Fig. 4.4).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "欧氏Position3及欧氏norm，非Pi最大范数；m>0,ε>0为物理模型资格。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.flexiblePendulumHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.937079",
      "before_sha256": "fa240d2d2541038ec8eaa1bdc45bdfcc1d50285b43a484f06f4c738ec9d5224d",
      "after_sha256": "533f15665607d7ce42cc3eaee4e0cca815dd5946fa60ed280ffa55d9e04eef42",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch04.flexiblePendulumHamiltonian
```lean
def flexiblePendulumHamiltonian (m ε r₀ : ℝ) (U : Position 3 → ℝ)
    (z : Position 3 × Position 3) : ℝ :=
  ‖z.2‖^2/(2*m)+U z.1+ε⁻¹*(‖z.1‖-r₀)^2/2
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-ConstrainedPendulum",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "151",
  "pdf_page": "173",
  "statement_latex": "The equations of motion for the constrained system take the form\n\\[\\dot q=v,\\qquad\\dot v=-\\nabla U(q)-q\\lambda,\\qquad0=\\|q\\|^2-r_0^2.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Gauss法向力Fc=−qλ由本关系保留；不将约束力唯一存在作已证结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedPendulum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原所写v′方程按单位质量，λ吸收法向grad(‖q‖²)=2q的因子；真实欧氏曲线和导数。",
    "[EXTRA] 增加开时间域，保证within导数确为经典运动导数，排除单点域任意导数的伪运动。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:57:09.952011",
      "before_sha256": "3963678b6c66235262f317a9acdd22c73990d8b4c325d20343adfe0738377142",
      "after_sha256": "88436bad890bb19183d405f2c129d3dc4b5f0160bb0cf9020b035ef94a549bce",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch04.constrainedPendulum
```lean
def constrainedPendulum (U : Position 3 → ℝ) (r₀ : ℝ)
    (q v : ℝ → Position 3) (lam : ℝ → ℝ) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (v t) I t ∧
    HasDerivWithinAt v (-gradient U (q t)-(lam t) • q t) I t ∧
    ‖q t‖^2-r₀^2=0
```

## 原文JSON
```json
{
  "source_id": "MD-4.3-ReactionMultiplier",
  "kind": "definition",
  "label": null,
  "section": "4.3",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "Using (4.8) in (4.10) we obtain\n\\[g'(q)M^{-1}[F-g'(q)^T\\lambda]+\\varphi\\equiv0.\\]\nThis is a system of linear equations for $\\lambda$. Assuming $g'(q)M^{-1}g'(q)^T$ is invertible, we may solve for $\\lambda$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "λ为真实Gram逆乘(GM⁻¹F+φ)；矩阵逆的语义资格det≠0在下一定理及Gram性质中明确。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.reactionMultiplier",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT08_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:58:11.914481",
      "before_sha256": "44ce2841af26995d099911aacbe19eabc71c414a61d6b15329c7df84f1268453",
      "after_sha256": "be91ee1027b0df723b8cfae4dc153c2997c3e6498d061dc247ecd28e7ce6643d",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH08_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT08/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def reactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```
### 实际依赖 MD.Ch04.reactionMultiplier
```lean
noncomputable def reactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```
### 实际依赖 MolecularDynamics.textbookConstraintCurvature
```lean
noncomputable def textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
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
