# EAUDIT18：第4章§4.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4-SkewMatrix",
  "kind": "definition",
  "label": "(4.38)",
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "Any $3\\times3$ skew matrix may be written as\n\\[\\dot\\Theta\\Theta^T=\\operatorname{skew}(\\omega)\\equiv\\begin{bmatrix}0&-\\omega_3&\\omega_2\\\\\\omega_3&0&-\\omega_1\\\\-\\omega_2&\\omega_1&0\\end{bmatrix}.\\tag{4.38}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF191（印刷169）式(4.38)定义右手约定的skew(ω)；ω=(ω_1,ω_2,ω_3)^T称为空间角速度，满足dot Θ Θ^T=skew(ω)。",
    "原句同时声称任意3×3反对称矩阵均有该表示；定义本身不构成此存在性结论的证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.skewMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。"
  ],
  "statement_scope": "仅三维skew坐标定义；反对称表示存在性由MD-4.4-SkewRepresentation，真实旋转导数的反对称性由MD-4.4-RotationSkew承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.119418",
      "before_sha256": "4e1eba102f51a0822077b72ed6f999d392c3674f1b881a66a0db50199507df9d",
      "after_sha256": "d11af5682c99c9c030775380912713822971338d32fcd43e657bab55eba67d48",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
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
### 实际依赖 MD.Ch04.skewMatrix
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-CrossProduct",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\frac d{dt}\\delta_i=\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF190–191（印刷168–169）：δ_i(t)=Θ(t)δ_i(0)，ω为空间角速度，dot Θ Θ^T=skew(ω)；×为三维右手叉积。",
    "PDF191式(4.39)含真实时间导数及三个等号；cross3坐标定义本身不表达完整运动学陈述。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.cross3",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。"
  ],
  "statement_scope": "仅三维右手叉积坐标定义；原整条(4.39)的真实轨道导数由MD-4.4-RigidVelocity、全部代数等式由MD-4.4-CrossIdentityFull承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.119569",
      "before_sha256": "bda5a9fadf4c9413b1cf304762a72fc74b049fd1a8dc5f95806925e97d11803a",
      "after_sha256": "8ae257441b93118e895d4fb6a6492a7eff3719f25545a6e88cce1d315146ba4e",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-SkewRepresentation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "Any $3\\times3$ skew matrix may be written as $\\operatorname{skew}(\\omega)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF191（印刷169）式(4.38)：skew(ω)=[[0,-ω_3,ω_2],[ω_3,0,-ω_1],[-ω_2,ω_1,0]]；skew matrix指实3×3反对称矩阵。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.skewRepresentation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.119680",
      "before_sha256": "b31188927ec18ce036393aca55294096f6da67e8e0badfec64df05b9c90bbbd9",
      "after_sha256": "65db48efa604bc145f598ba6000e085bda66515148b3e5a961a73d010842a86a",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem skewRepresentation : ∀ A : MolecularDynamics.Chapter04Review.Mat3, Aᵀ = -A → ∃! «ω» : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix «ω»=A := by
  intro A ha
  have hs : ∀ i j : Fin 3, A j i= -A i j := by
    intro i j
    simpa using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B i j) ha
  refine ⟨![A 2 1,A 0 2,A 1 0],?_,?_⟩
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [MolecularDynamics.Chapter04Review.skewMatrix] <;> nlinarith [hs 0 0,hs 0 1,hs 0 2,hs 1 1,hs 1 2,hs 2 2]
  · intro w hw
    ext i
    fin_cases i
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 2 1) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 0 2) hw
    · simpa [MolecularDynamics.Chapter04Review.skewMatrix] using congrArg (fun B : MolecularDynamics.Chapter04Review.Mat3 => B 1 0) hw
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
### 实际依赖 MolecularDynamics.Chapter04Review.skewMatrix
```lean
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.skewMatrix
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-CrossMatrix",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF191（印刷169）式(4.38)定义skew，式(4.39)的代数部分为skew(ω)δ_i=ω×δ_i=-skew(δ_i)ω；×为三维右手叉积。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.crossMatrix",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本条仅首等式的子引理；原式两个等式全部保存在CrossIdentityFull，不把子引理当全部结论。",
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。"
  ],
  "statement_scope": "仅skew(u)v=u×v首等式；原整条双等式由MD-4.4-CrossIdentityFull承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.119785",
      "before_sha256": "37e040d7e8fb31cc3334fadc45bda838b125111ae5d4da4e0ece118c129ec344",
      "after_sha256": "0574a3ae5bf5e7154065aff4b156ccc25a7750a19e3311d0c9264f7e7bfb3ca0",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem crossMatrix :
  ∀ u v : MolecularDynamics.Chapter04Review.V, MolecularDynamics.Chapter04Review.skewMatrix u *ᵥ v=MolecularDynamics.Chapter04Review.cross3 u v := by
  intro u v
  ext i
  fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
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
### 实际依赖 MolecularDynamics.Chapter04Review.skewMatrix
```lean
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MD.Ch04.skewMatrix
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-RigidVelocity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$\\frac d{dt}\\delta_i=\\operatorname{skew}(\\omega)\\delta_i=\\omega\\times\\delta_i=-\\operatorname{skew}(\\delta_i)\\omega$, which is the usual definition.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF190（印刷168）：δ_i(t)=Θ(t)δ_i(0)，δ_i(0)固定，Θ为正交矩阵轨道。",
    "PDF191（印刷169）：ω为空间角速度，dot Θ Θ^T=skew(ω)，式(4.39)同时给出导数、skew乘积、叉积和负的反向skew乘积。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidVelocity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "给定真实正交旋转轨道和定义角速度的skew关系；不是把速度公式当假设。",
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。"
  ],
  "statement_scope": "仅真实旋转轨道的导数等于ω×δ；原段落全部代数等式由MD-4.4-CrossIdentityFull承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.119888",
      "before_sha256": "747e018f1dffeaaedf7e1398b66e9001a417eed816fa89b27b0d6b3d45a8c08c",
      "after_sha256": "47861c6e86f7028af9a9c69b8ef431374dcd280fa2353043ffdb72ff34993eb2",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rigidVelocity : ∀ (Θ : ℝ → MolecularDynamics.Chapter04Review.Mat3) (dΘ : MolecularDynamics.Chapter04Review.Mat3) (δ «ω» : MolecularDynamics.Chapter04Review.V) t,
  HasDerivAt Θ dΘ t → Θ t*(Θ t)ᵀ=1 → dΘ*(Θ t)ᵀ=MolecularDynamics.Chapter04Review.skewMatrix «ω» →
    HasDerivAt (fun s => Θ s *ᵥ δ) (MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ)) t := by
  intro Θ dΘ δ «ω» t hd ho hs
  have he : ∀ i, HasDerivAt (fun s => ∑ j, Θ s i j*δ j) (∑ j,dΘ i j*δ j) t := by
    intro i
    apply HasDerivAt.fun_sum
    intro j hj
    exact (hasDerivAt_pi.mp (hasDerivAt_pi.mp hd i) j).mul_const (δ j)
  have hv : HasDerivAt (fun s => Θ s *ᵥ δ) (dΘ *ᵥ δ) t := hasDerivAt_pi.mpr he
  have hi : (Θ t)ᵀ*Θ t=1 := mul_eq_one_comm.mp ho
  have hcross : MolecularDynamics.Chapter04Review.skewMatrix «ω» *ᵥ (Θ t *ᵥ δ)=
      MolecularDynamics.Chapter04Review.cross3 «ω» (Θ t *ᵥ δ) := by
    ext i
    fin_cases i <;> simp [MolecularDynamics.Chapter04Review.skewMatrix,MolecularDynamics.Chapter04Review.cross3,Matrix.mulVec,dotProduct,Fin.sum_univ_three] <;> ring
  rw [← hcross,← hs,Matrix.mulVec_mulVec,Matrix.mul_assoc,hi,Matrix.mul_one]
  exact hv
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
### 实际依赖 MolecularDynamics.Chapter04Review.skewMatrix
```lean
def skewMatrix (v : V) : Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MD.Ch04.skewMatrix
```lean
def skewMatrix (v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 := !![0,-v 2,v 1; v 2,0,-v 0; -v 1,v 0,0]
```

## 原文JSON
```json
{
  "source_id": "MD-4.4-InertiaTensor",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "$K_{\\rm rot}=\\frac12\\omega_b^TT\\omega_b$, where the matrix $T=-\\sum_{i=1}^Nm_i\\operatorname{skew}(\\delta_i(0))^2$ is referred to as the moment of inertia tensor or simply the inertia tensor and can be written as\n\\[T=\\sum_{i=1}^Nm_i[\\|\\delta_i(0)\\|^2I-\\delta_i(0)\\delta_i(0)^T].\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF190–191（印刷168–169）：δ_i(0)为固定参考相对位置，m_i为质量；ω_b=Θ^Tω称为体角速度。",
    "PDF191（印刷169）：T=-∑_i m_i skew(δ_i(0))^2；矩阵平方指矩阵乘法，I为3×3单位矩阵，||δ_i(0)||为欧氏范数，T称为惯性张量。",
    "所引原文同时包含K_rot=(1/2)ω_b^T T ω_b及T的两种表达式；仅定义有限和不表达这些等价结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.inertiaTensor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω_b关系由MD-4.4-RotationBodyEnergy承担。"
  ],
  "statement_scope": "仅T的欧氏有限和定义；skew平方关系由MD-4.4-InertiaSkewIdentity，质量旋转动能及ω_b关系由MD-4.4-RotationBodyEnergy承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.119994",
      "before_sha256": "6435fa3bb2e74c1a706a5dc6d71d066451f09fc4630138887008784edf01a371",
      "after_sha256": "bc773cefc86fe2f10a58360344c6b8f1a31bf2e6546ab71772c13f9457657044",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def inertiaTensor {N : ℕ} (m : Fin N → ℝ) (δ : Fin N → MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.Mat3 :=
  ∑ i, m i • (MolecularDynamics.Chapter04Review.dot (δ i) (δ i) • (1 : MolecularDynamics.Chapter04Review.Mat3)-MolecularDynamics.Chapter04Review.outer (δ i))
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
  "source_id": "MD-4.4-RotationalEnergy",
  "kind": "definition",
  "label": null,
  "section": "4.4",
  "printed_page": "169",
  "pdf_page": "191",
  "statement_latex": "It is convenient to express this in terms of the so-called body angular velocity $\\omega_b=\\Theta^T\\omega$ in which case it becomes $K_{\\rm rot}=\\frac12\\omega_b^TT\\omega_b$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "ω为空间角速度；Θ为刚体旋转矩阵；ω_b=Θᵀω 为体坐标角速度。",
    "T 为参考构型 δ_i(0) 的惯性张量；K_rot=1/2 ω_bᵀTω_b。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rotationalEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原完整引文，仅在statement_scope显式分工到已有source_id，所列其余结论未删；仅体角速度ω_b的二次型能量定义；ω_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。"
  ],
  "statement_scope": "仅体角速度ω_b的二次型能量定义；ω_b=Θᵀω及真实旋转粒子能量由MD-4.4-RotationBodyEnergy承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:02:01.120098",
      "before_sha256": "ddf04a9d8e70553840537662e0030f0de2a86b49a02aac315ddd6d5b46bdd4bb",
      "after_sha256": "ff78240377d7b87381494a831be5b96a2b5fdad333e92aedce92d4a895b851d9",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH22_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) (ωb : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot ωb (T *ᵥ ωb)/2
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
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.rotationalEnergy
```lean
def rotationalEnergy (T : MolecularDynamics.Chapter04Review.Mat3) (ωb : MolecularDynamics.Chapter04Review.V) : ℝ := MolecularDynamics.Chapter04Review.dot ωb (T *ᵥ ωb)/2
```
