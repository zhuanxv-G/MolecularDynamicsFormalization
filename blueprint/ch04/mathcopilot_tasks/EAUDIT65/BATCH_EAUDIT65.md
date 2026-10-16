# EAUDIT65：第4章§4.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-AngularMomentum",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "The angular momentum vector in the reference frame is given by $l=\\sum_{i=1}^Nm_i\\delta_i\\times\\dot\\delta_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$m_i$ 为粒子质量，$\\delta_i=q_i-q_{cm}\\in\\mathbb R^3$，$\\dot\\delta_i$ 是其时间导数；$l$ 是空间参考系角动量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.angularMomentum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832604",
      "before_sha256": "7dd6d2dd7983a81067a887809520c37aea1c2682ec7006b95f36c981023cab8f",
      "after_sha256": "3a3ea6ec2a56fb4cf4e4a0ffddeb06e53191fb9a2038653cae9b50977245f91d",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.angularMomentum
```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-BodyMomentum",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "Define $\\pi=\\Theta^Tl$, the angular momentum vector referred to the body frame of reference.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\Theta$ 是从初始体坐标到空间坐标的正交旋转矩阵；$l$ 为空间角动量，$\\pi=\\Theta^Tl$ 为体坐标角动量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.bodyMomentum",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832674",
      "before_sha256": "ebc41c35f82c381781d27e538c8ef6450f0c27da0c604b5629e490ca32ca7b99",
      "after_sha256": "8f8868b152860c5680e0f96cd5075693be32fb9d28bbeb9da15c4add9aefaa90",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l
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
### 实际依赖 MD.Ch04.bodyMomentum
```lean
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-AngularInertia",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "171",
  "pdf_page": "193",
  "statement_latex": "From Eq. (4.39) we may write this as $l=\\sum_im_i\\delta_i\\times\\omega\\times\\delta_i$, from which, using the vector triple product identity $a\\times b\\times c=(a\\cdot c)b-(a\\cdot b)c$, we obtain $l=\\sum_im_i[\\|\\delta_i\\|^2I-\\delta_i\\delta_i^T]\\omega$. Define $\\pi=\\Theta^Tl$, then we have (using $\\delta_i=\\Theta\\delta_i(0)$): $\\pi=T\\omega_b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\delta_i(t)=\\Theta(t)\\delta_i(0)$，$\\dot\\delta_i=\\omega\\times\\delta_i$（4.39）；$\\omega_b=\\Theta^T\\omega$。",
    "$T=\\sum_{i=1}^Nm_i[\\|\\delta_i(0)\\|^2I-\\delta_i(0)\\delta_i(0)^T]$；$\\pi=\\Theta^Tl$。",
    "原书三重叉积未加括号；原页给出的恒等式及（4.39）确定其为右嵌套 $a\\times(b\\times c)$，保留原排版，不默改。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.angularInertia",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实SO(3)矩阵和cross3，嵌套为δ×(ω×δ)；原无括号三重积含糊，明确上下文对象。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832739",
      "before_sha256": "0575efa5a1f7ff53c2cab4faef618ba80417640f369dfc104d4b545c54bc1b6f",
      "after_sha256": "b51efe9de877903c6fb6c461170f6a41bcf184b5f9611a078c4ebf662e816560",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem angularInertia :
  ∀ N (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) («ω» : MolecularDynamics.Chapter04Review.V),
  Θᵀ*Θ=1 → Θ.det=1 → MolecularDynamics.Chapter04Review.bodyMomentum Θ
    (MolecularDynamics.Chapter04Review.angularMomentum m (fun i => Θ *ᵥ δ i) (fun i => MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ δ i))) =
      MolecularDynamics.Chapter04Review.inertiaTensor m δ *ᵥ (Θᵀ *ᵥ «ω») := by
  intro N m δ Θ «ω» ho hdet
  have ht : ∀ (A : MolecularDynamics.Chapter04Review.Mat3) (v w : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot (A *ᵥ v) w=MolecularDynamics.Chapter04Review.dot v (Aᵀ *ᵥ w) := by
    intro A v w
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hi : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ (Θ *ᵥ v)=v := by
    intro v
    rw [Matrix.mulVec_mulVec,ho,Matrix.one_mulVec]
  have hn : ∀ v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (Θ *ᵥ v) (Θ *ᵥ v)=MolecularDynamics.Chapter04Review.dot v v := by
    intro v
    rw [ht,hi]
  have hc : ∀ u w : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.cross3 u (MolecularDynamics.Chapter04Review.cross3 w u)=MolecularDynamics.Chapter04Review.dot u u • w-MolecularDynamics.Chapter04Review.dot u w • u := by
    intro u w
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul] <;> ring
  have he : ∀ v y : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.outer v *ᵥ y=MolecularDynamics.Chapter04Review.dot v y • v := by
    intro v y
    ext i
    simp [MolecularDynamics.Chapter04Review.outer,Matrix.mulVec,dotProduct,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three,Pi.smul_apply,smul_eq_mul]
    ring
  have hterm : ∀ v : MolecularDynamics.Chapter04Review.V, Θᵀ *ᵥ MolecularDynamics.Chapter04Review.cross3 (Θ *ᵥ v) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ *ᵥ v))=
      (MolecularDynamics.Chapter04Review.dot v v • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer v) *ᵥ (Θᵀ *ᵥ «ω») := by
    intro v
    rw [hc,Matrix.mulVec_sub,Matrix.mulVec_smul,Matrix.mulVec_smul,hn,ht,hi,
      Matrix.sub_mulVec,Matrix.smul_mulVec,Matrix.one_mulVec,he]
  simp only [MolecularDynamics.Chapter04Review.bodyMomentum,MolecularDynamics.Chapter04Review.angularMomentum,
    MolecularDynamics.Chapter04Review.inertiaTensor,Matrix.mulVec_sum,Matrix.mulVec_smul,Matrix.sum_mulVec,Matrix.smul_mulVec]
  apply Finset.sum_congr rfl
  intro i hii
  rw [hterm]
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
### 实际依赖 MolecularDynamics.Chapter04Review.angularMomentum
```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → V) : V :=
  ∑ i, m i • cross3 (δ i) (v i)
```
### 实际依赖 MolecularDynamics.Chapter04Review.bodyMomentum
```lean
def bodyMomentum (Θ : Mat3) (l : V) : V := Θᵀ *ᵥ l
```
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.inertiaTensor
```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → V) : Mat3 :=
  ∑ i, m i • (dot (δ i) (δ i) • (1 : Mat3)-outer (δ i))
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
### 实际依赖 MD.Ch04.angularMomentum
```lean
def angularMomentum {N : ℕ} (m : Fin N → ℝ) (δ v : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  ∑ i, m i • MolecularDynamics.Chapter04Review.cross3 (δ i) (v i)
```
### 实际依赖 MD.Ch04.bodyMomentum
```lean
def bodyMomentum (Θ : MolecularDynamics.Chapter04Review.Mat3) (l : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := Θᵀ *ᵥ l
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.inertiaTensor
```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))
```
### 实际依赖 MolecularDynamics.Chapter04Review.outer
```lean
def outer (v : V) : Mat3 := fun i j => v i*v j
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-EulerRigidField",
  "kind": "definition",
  "label": "(4.41)",
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "but since $\\omega_b=T^{-1}\\pi$, we may conclude $\\dot\\pi=\\pi\\times T^{-1}\\pi$. These are the so-called Euler equations for the free rigid body.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "无外力的自由刚体，$\\pi=\\Theta^Tl$，$T$ 为固定体坐标惯性张量；本页使用可逆 $T$，$\\omega_b=T^{-1}\\pi$；点表示时间导数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.eulerRigidField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832798",
      "before_sha256": "41d4ff009bf97f3239c4f708eb577bc39de1bbc00b614cf1d3f8fd06682df531",
      "after_sha256": "398cb254cc4cebac42cf38fee99ef805abc873231226330b387a6b09952f5243",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
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
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MD.Ch04.eulerRigidField
```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-FreeRigidSolution",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\dot\\pi=\\pi\\times T^{-1}\\pi$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "这是（4.41）的原公式，原书未另行定义一个命名的解关系。",
    "无外力自由刚体；$\\pi(t)\\in\\mathbb R^3$，$T$ 为固定、可逆的体坐标惯性张量；点表示时间导数。",
    "Lean 用集合 $I$ 上 HasDerivWithinAt 表示解，是形式化选择而非原文记号；不声称轨道存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.freeRigidSolution",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 采用开放时间域和正定惯性张量，明确within导数就是实际经典导数；Mathlib标准定义按用户约定直接采信，不再因未复制定义体待人工。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832850",
      "before_sha256": "fbb4542832a0906302b0650a19eaff510d58c4b6d16082bee5333f0c71cfadcb",
      "after_sha256": "ff26593e106f2e225578dc8a25bebb8baffb6da03f124236a73f937d1ce8afd7",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) (_hI : IsOpen I) (_hT : T.PosDef) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t
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
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.eulerRigidField
```lean
def eulerRigidField (T : Mat3) (π : V) : V := cross3 π (T⁻¹ *ᵥ π)
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MD.Ch04.eulerRigidField
```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```
### 实际依赖 MD.Ch04.freeRigidSolution
```lean
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) (_hI : IsOpen I) (_hT : T.PosDef) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-RigidInvariants",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "Thus the Euler equations are in the form of a Hamiltonian system on a three-dimensional phase space. The symplectic structure matrix is dependent on the phase variables, and it is degenerate: $\\widetilde J\\pi=\\pi\\times\\pi=0$, signifying that total angular momentum is conserved: $\\|\\pi\\|=\\mathrm{constant}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\widetilde J(\\pi)=\\operatorname{skew}(\\pi)$，$\\widetilde H=\\pi^TT^{-1}\\pi/2$；$\\pi$ 为自由刚体的体坐标角动量。",
    "$\\|\\pi\\|$ 为欧氏长度。原书称退化矩阵为 symplectic structure matrix；保留措辞，此处是退化的 Hamiltonian/Poisson 表述，不能将其解读为非退化辛形式。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidInvariants",
  "reusable_proofs": [],
  "extra_assumptions": [
    "对称正定T、实际连续闭区间轨道，证明原能量H̃=πᵀT⁻¹π/2和角动量平方同时守恒；不假设任一守恒。",
    "[EXTRA] 本条仅保留原页的能量与角动量模长守恒，实际Hamiltonian梯度表示/反对称性由RigidPoissonMatrix补全，退化由PoissonDegeneracy原已有声明承担，完整原文保留。"
  ],
  "statement_scope": "仅能量与角动量模长守恒；同段Hamiltonian表示及结构矩阵反对称性由MD-4.4.1-RigidPoissonMatrix、退化由MD-4.4.1-PoissonDegeneracy承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832904",
      "before_sha256": "ca534abd18829c7d89315deb80da9e7f1e9b1cd777b1ccc2be03a6ac998e8d4d",
      "after_sha256": "858b178a0d4c4f69c8963e3b27128cac363fce5d43489e5c1ccafce6dd61c92d",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rigidInvariants :
  ∀ (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) a b,
  T.PosDef → a ≤ b → ContinuousOn π (Icc a b) → MolecularDynamics.Chapter04Review.freeRigidSolution T π (Icc a b) →
    ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) ∧
      MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
  intro T π a b hT hab hπ hsol
  have hsym : (T⁻¹)ᵀ=T⁻¹ := by
    simpa [Matrix.conjTranspose_eq_transpose_of_trivial] using hT.isHermitian.inv.eq
  have hcomm : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot u v=MolecularDynamics.Chapter04Review.dot v u := by
    intro u v
    simp [MolecularDynamics.Chapter04Review.dot,mul_comm]
  have htrans : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) (u v : MolecularDynamics.Chapter04Review.V), MolecularDynamics.Chapter04Review.dot u (B *ᵥ v)=MolecularDynamics.Chapter04Review.dot (Bᵀ *ᵥ u) v := by
    intro B u v
    simp [MolecularDynamics.Chapter04Review.dot,Matrix.mulVec,dotProduct,Fin.sum_univ_three]
    ring
  have hc : ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.cross3 u v) v=0 ∧ MolecularDynamics.Chapter04Review.dot u (MolecularDynamics.Chapter04Review.cross3 u v)=0 := by
    intro u v
    constructor <;> simp [MolecularDynamics.Chapter04Review.cross3,MolecularDynamics.Chapter04Review.dot,Fin.sum_univ_three] <;> ring
  have hd : ∀ (B : MolecularDynamics.Chapter04Review.Mat3) t, t ∈ Icc a b →
      HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (B *ᵥ π s))
      (MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (B *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))) (Icc a b) t := by
    intro B t ht
    have hp := hsol t ht
    have hx : ∀ i, HasDerivWithinAt (fun s => (B *ᵥ π s) i) ((B *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) i) (Icc a b) t := by
      intro i
      change HasDerivWithinAt (fun s => ∑ j, B i j*π s j) (∑ j,B i j*MolecularDynamics.Chapter04Review.eulerRigidField T (π t) j) (Icc a b) t
      apply HasDerivWithinAt.fun_sum
      intro j hj
      exact (hasDerivWithinAt_pi.mp hp j).const_mul (B i j)
    have h := HasDerivWithinAt.fun_sum (u := Finset.univ) (fun i _ => (hasDerivWithinAt_pi.mp hp i).mul (hx i))
    simpa [MolecularDynamics.Chapter04Review.dot,Finset.sum_add_distrib] using h
  have he : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (T⁻¹ *ᵥ π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (T⁻¹ *ᵥ π t)+MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [htrans T⁻¹ (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)),hsym,hcomm (T⁻¹ *ᵥ π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).1]
    simpa [hz] using hd T⁻¹ t ht
  have hn : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => MolecularDynamics.Chapter04Review.dot (π s) (π s)) 0 (Icc a b) t := by
    intro t ht
    have hz : MolecularDynamics.Chapter04Review.dot (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)+MolecularDynamics.Chapter04Review.dot (π t) (MolecularDynamics.Chapter04Review.eulerRigidField T (π t))=0 := by
      rw [hcomm (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) (π t)]
      simp [MolecularDynamics.Chapter04Review.eulerRigidField,(hc (π t) (T⁻¹ *ᵥ π t)).2]
    simpa [Matrix.one_mulVec,hz] using hd 1 t ht
  have ce : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (T⁻¹ *ᵥ π t)=MolecularDynamics.Chapter04Review.dot (π a) (T⁻¹ *ᵥ π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (he t ht).continuousWithinAt)
    intro t ht
    exact (he t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  have cn : ∀ t ∈ Icc a b, MolecularDynamics.Chapter04Review.dot (π t) (π t)=MolecularDynamics.Chapter04Review.dot (π a) (π a) := by
    apply constant_of_has_deriv_right_zero (fun t ht => (hn t ht).continuousWithinAt)
    intro t ht
    exact (hn t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
  intro t ht
  exact ⟨ce t ht,cn t ht⟩
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
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.eulerRigidField
```lean
def eulerRigidField (T : Mat3) (π : V) : V := cross3 π (T⁻¹ *ᵥ π)
```
### 实际依赖 MolecularDynamics.Chapter04Review.freeRigidSolution
```lean
def freeRigidSolution (T : Mat3) (π : ℝ → V) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (eulerRigidField T (π t)) I t
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
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.eulerRigidField
```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```
### 实际依赖 MD.Ch04.freeRigidSolution
```lean
def freeRigidSolution (T : MolecularDynamics.Chapter04Review.Mat3) (π : ℝ → MolecularDynamics.Chapter04Review.V) (I : Set ℝ) (_hI : IsOpen I) (_hT : T.PosDef) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt π (MolecularDynamics.Chapter04Review.eulerRigidField T (π t)) I t
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-RigidPoissonMatrix",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\dot\\pi=\\widetilde J(\\pi)\\nabla\\widetilde H$, where $\\widetilde J(\\pi)=\\operatorname{skew}(\\pi)$ is obviously skew symmetric, and $\\widetilde H=\\pi^TT^{-1}\\pi/2$ is the energy function.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\pi\\in\\mathbb R^3$，$T$ 为固定体坐标惯性张量；$\\nabla$ 是欧氏坐标梯度。",
    "$\\operatorname{skew}(v)=\\begin{pmatrix}0&-v_3&v_2\\\\v_3&0&-v_1\\\\-v_2&v_1&0\\end{pmatrix}$，满足 $\\operatorname{skew}(v)w=v\\times w$（4.38）。",
    "本条原文范围包括场恒等式、反对称性及能量函数；原 context_notation 的“另条”不能取消 statement_scope 中的这些子句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidPoissonMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留J定义，补实际二次能量定义、真实fderiv梯度Hamiltonian表示及反对称性；正定惯性是物理充分资格，不预设所求梯度公式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.832962",
      "before_sha256": "9b3eb384cfdae623a2346c8db73e7351b37ca7c4ed39ba27a6852ea2f29fd1e7",
      "after_sha256": "d92b268cf7bc464ea632e58e3bf6a1c86153038f6579607823f630eec2d28366",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π

def rigidBodyHamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (mom : MolecularDynamics.Chapter04Review.V) : ℝ :=
  MolecularDynamics.Chapter04Review.dot mom (T⁻¹ *ᵥ mom)/2

theorem rigidPoissonMatrix_hamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (_hT : T.PosDef) (mom : MolecularDynamics.Chapter04Review.V) :
    (rigidPoissonMatrix mom)ᵀ= -rigidPoissonMatrix mom ∧
    MolecularDynamics.Chapter04Review.eulerRigidField T mom=
      rigidPoissonMatrix mom *ᵥ MolecularDynamics.Chapter04Review.grad (rigidBodyHamiltonian T) mom := by
  sorry
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
### 实际依赖 MolecularDynamics.Chapter04Review.cross3
```lean
def cross3 (u v : V) : V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.eulerRigidField
```lean
def eulerRigidField (T : Mat3) (π : V) : V := cross3 π (T⁻¹ *ᵥ π)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.skewMatrix
```lean
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
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
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.eulerRigidField
```lean
def eulerRigidField (T : MolecularDynamics.Chapter04Review.Mat3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := MolecularDynamics.Chapter04Review.cross3 π (T⁻¹ *ᵥ π)
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MD.Ch04.rigidBodyHamiltonian
```lean
def rigidBodyHamiltonian (T : MolecularDynamics.Chapter04Review.Mat3)
    (mom : MolecularDynamics.Chapter04Review.V) : ℝ :=
  MolecularDynamics.Chapter04Review.dot mom (T⁻¹ *ᵥ mom)/2
```
### 实际依赖 MD.Ch04.rigidPoissonMatrix
```lean
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π
```
### 实际依赖 MD.Ch04.skewMatrix
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
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
  "source_id": "MD-4.4.1-PoissonDegeneracy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "$\\widetilde J\\pi=\\pi\\times\\pi=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\widetilde J=\\widetilde J(\\pi)=\\operatorname{skew}(\\pi)$，$\\pi\\in\\mathbb R^3$；零为三维零向量。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.poissonDegeneracy",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:05:44.833013",
      "before_sha256": "72143eec26b5d1af65e9aed37c8af7442c712f73b9116e8f1c53439f7b7c920b",
      "after_sha256": "f3c4eaea45b306274bcf26a02011e698e06610dfb641726daad668f98e504edb",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem poissonDegeneracy : ∀ π : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.rigidPoissonMatrix π *ᵥ π=0 := by
  intro π
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.rigidPoissonMatrix,MolecularDynamics.Chapter04Review.skewMatrix,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
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
### 实际依赖 MolecularDynamics.Chapter04Review.rigidPoissonMatrix
```lean
def rigidPoissonMatrix (π : V) : Mat3 := skewMatrix π
```
### 实际依赖 MolecularDynamics.Chapter04Review.skewMatrix
```lean
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.rigidPoissonMatrix
```lean
def rigidPoissonMatrix (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := MolecularDynamics.Chapter04Review.skewMatrix π
```
### 实际依赖 MD.Ch04.skewMatrix
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```
