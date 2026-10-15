# EAUDIT20：第4章§4.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4-DipolarPotentialSum",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "170",
  "pdf_page": "192",
  "statement_latex": "$\\varphi^{\\rm dip}_{ij}=\\varphi_{\\rm LJ}(r_{ij})+\\mu_i^TL(q_{ij})\\mu_j$, with $U$ given as the sum of these over pairs.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "q_ij=q_i−q_j，r_ij=||q_ij||为欧氏距离；μ_i、μ_j为单位偶极方向。",
    "原PDF写 L(q_ij)=1/r_ij³−(3/r_ij⁵)q_ij q_ij^T，并称L为3×3矩阵；首项按标量乘单位矩阵理解，原式未显式印I。",
    "U是所有不同粒子无序配对的相互作用势之和；φ_LJ为Lennard–Jones径向势，使用r_ij>0的无重叠构形。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dipolarPotentialSum",
  "reusable_proofs": [],
  "extra_assumptions": [
    "对无重叠位置，真实Euclidean距离sqrtΣ(qi−qj)²及有限无序pair和；经验势定义，不计模拟正确性。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:04:11.964101",
      "before_sha256": "0b9ca44fa171ddd8d3ac4cff0327df07d663d3132e416517af5ee3f8f86a78f7",
      "after_sha256": "311814d1b2f52872358595211eeb815243a20426bccc51a2a3edd76c6b2674ab",
      "changed_fields": [
        "statement_latex",
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
def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0
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
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
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
### 实际依赖 MD.Ch04.dipolarPairPotential
```lean
def dipolarPairPotential (lj : ℝ → ℝ) (r : ℝ) (q μ ν : MolecularDynamics.Chapter04Review.V) : ℝ :=
  lj r+MolecularDynamics.Chapter04Review.dot μ (((r^3)⁻¹ • (1 : MolecularDynamics.Chapter04Review.Mat3)-(3/r^5) • MolecularDynamics.Chapter04Review.outer q) *ᵥ ν)
```
### 实际依赖 MD.Ch04.dipolarPotentialSum
```lean
def dipolarPotentialSum {N : ℕ} (lj : ℝ → ℝ) (q μ : Fin N → MolecularDynamics.Chapter04Review.V) : ℝ :=
  ∑ i, ∑ j, if i < j then
    dipolarPairPotential lj (Real.sqrt (MolecularDynamics.Chapter04Review.dot (q i-q j) (q i-q j))) (q i-q j) (μ i) (μ j) else 0
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RotationTrajectory",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "168",
  "pdf_page": "190",
  "statement_latex": "$\\delta_i(t)=\\Theta(t)\\delta_i(0)$, see Fig. 4.7, thus we have\n\\[K_{\\rm rot}=\\frac12\\sum_{i=1}^N m_i\\delta_i(0)^T\\dot\\Theta^T\\dot\\Theta\\delta_i(0).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "δ_i(t)为相对质心的位置，δ_i(0)为参考构形；Θ(t)为3×3正交方向矩阵，m_i为各粒子质量，dotΘ为时间导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅δ_i(t)=Θ(t)δ_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。"
  ],
  "statement_scope": "仅δ_i(t)=Θ(t)δ_i(0)的真实导数辅助；原段落旋转动能有限和及trace等价由MD-4.4-RotationTraceIdentity承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:04:11.964235",
      "before_sha256": "7891f694c7c894b513cb1c2d42c2248951f436beba14c299ef1086a8bb5fa65f",
      "after_sha256": "cb836426bafa8d6c344a9da79b2f35bcb7a0d4e8aeca77236a0e334cb7553b7b",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
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
theorem rotationTrajectory : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (d : MolecularDynamics.Chapter04Review.Mat3) (δ : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ d t → HasDerivAt (fun s => Θ s *ᵥ δ) (d *ᵥ δ) t := by
  intro Θ d δ t hd
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,d i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  exact hasDerivAt_pi.mpr he
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
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```

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
