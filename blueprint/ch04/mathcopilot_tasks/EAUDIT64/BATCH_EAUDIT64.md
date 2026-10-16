# EAUDIT64：第4章§4.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4-RigidMatrixRelation",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "The constraint may be enforced using Lagrange multipliers with the following equations\n\\[\\frac d{dt}q_{\\rm cm}=p_{\\rm cm}/M,\\quad\\frac d{dt}\\Theta=\\Pi R^{-1},\\]\n\\[\\frac d{dt}p_{\\rm cm}=-\\nabla_{q_{\\rm cm}}U,\\quad\\frac d{dt}\\Pi=-\\nabla_\\Theta U-\\Theta\\Lambda,\\quad I=\\Theta^T\\Theta.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q_cm、p_cm为质心位置和动量，M为总质量；Θ、Π为方向矩阵及共轭动量，R为固定二阶矩矩阵。",
    "Λ为执行Θ^TΘ=I约束的矩阵拉格朗日乘子；∇_q U和∇_Θ U分别为位置梯度和按矩阵元素取偏导的梯度。",
    "原书点态时间导数的轨道解释以可微势、M>0及可逆R的物理构形为背景；原文未在此另作解存在性断言。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidMatrixRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 增加开放时间域、势能联合经典可微、M>0及R可逆，使within导数等于真实时间导数，排除单点域伪运动；姿态正交约束仍逐t保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:04:11.964438",
      "before_sha256": "6840048b7b6a6dd4bbcc5ddc82f27f016d7b1caa0d99fb83dd68636e695ab797",
      "after_sha256": "54f29bfb05bbdf711ecac2efbb9aaa66cfb47f6e81db064901af6572f5184c47",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidMatrixRelation (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.V) (Θ mom Λ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (I : Set ℝ) (_hI : IsOpen I)
    (_hU : Differentiable ℝ (fun z : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 ↦ U z.1 z.2)) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-MolecularDynamics.Chapter04Review.grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-MolecularDynamics.Chapter04Review.matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.matrixGrad
```lean
def matrixGrad (U : Mat3 → ℝ) (Θ : Mat3) : Mat3 :=
  fun i j => (fderiv ℝ U Θ) (Pi.single i (Pi.single j 1))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.matrixGrad
```lean
def matrixGrad (U : Mat3 → ℝ) (Θ : Mat3) : Mat3 :=
  fun i j => (fderiv ℝ U Θ) (Pi.single i (Pi.single j 1))
```
### 实际依赖 MD.Ch04.rigidMatrixRelation
```lean
def rigidMatrixRelation (M : ℝ) (R : MolecularDynamics.Chapter04Review.Mat3) (_hM : 0 < M) (_hR : R.det ≠ 0) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.V) (Θ mom Λ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (I : Set ℝ) (_hI : IsOpen I)
    (_hU : Differentiable ℝ (fun z : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 ↦ U z.1 z.2)) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (M⁻¹ • p t) I t ∧ HasDerivWithinAt Θ (mom t*R⁻¹) I t ∧
    HasDerivWithinAt p (-MolecularDynamics.Chapter04Review.grad (fun x => U x (Θ t)) (q t)) I t ∧
    HasDerivWithinAt mom (-MolecularDynamics.Chapter04Review.matrixGrad (U (q t)) (Θ t)-Θ t*Λ t) I t ∧ (Θ t)ᵀ*Θ t=1
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
