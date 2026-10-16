# EAUDIT91：第4章§4.4.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4.2-DLMPrintedSystem",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "DLM Rigid Body Molecular Dynamics Step\n1. “Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:\n\\[p^k:=p^k+\\tfrac h2 F^k;\\quad\\pi^k:=\\pi^k+\\tfrac h2\\tau^k.\\]\n2. “Drift”: step forward a whole step in positions\n\\[q^k:=q^k+hp^k.\\]\n3. “Spin”: update the rotational state of the kth rigid body by the sequence of steps\n\\[\\Theta:=\\Theta^x(\\tfrac h2\\pi_1^k/I_1);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^y(\\tfrac h2\\pi_2^k/I_2);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^z(h\\pi_3^k/I_3);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^y(\\tfrac h2\\pi_2^k/I_2);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T,\\]\n\\[\\Theta:=\\Theta^x(\\tfrac h2\\pi_1^k/I_1);\\ \\pi^k:=\\Theta\\pi^k;\\ \\Theta^k:=\\Theta^k\\Theta^T.\\]\n4. “Kick”: update the momenta and angular momentum vectors (as in Step 1) with a half step using new forces $F^k$ and torques $\\tau^k$ evaluated at the current $q,\\Theta$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF195（印刷173）规定：每个刚体的 q^k 是质心位置，p^k 是线动量，π^k 是体坐标角动量，Θ^k 是3×3旋转矩阵；对每个刚体执行该步骤。π_i^k 表示第i分量，I_1,I_2,I_3 是当前刚体的主惯性矩；Lean中各体惯性可分别取 I k。",
    "力与力矩使用上标k：\\(F^k=-\\partial U/\\partial q^k\\)，\\(\\tau^k=-\\operatorname{rot}((\\Theta^k)^T\\,\\partial U/\\partial\\Theta^k)\\)。U可依赖所有刚体的位置和方向。首次kick使用当前输入构型的力/力矩，末kick在更新后的全部q,Θ处重新求值，不冻结旧力/力矩。",
    "PDF196（印刷174）定义 \\(\\operatorname{rot}(A)=\\operatorname{skew}^{-1}(A-A^T)\\)。其分量为 \\((A_{32}-A_{23},A_{13}-A_{31},A_{21}-A_{12})\\)。这里原书分量从1起编号，Lean Fin 3从0起编号。",
    "PDF196步骤3后的记号说明：\\(\\Theta^x(\\phi)=\\begin{pmatrix}1&0&0\\\\0&\\cos\\phi&-\\sin\\phi\\\\0&\\sin\\phi&\\cos\\phi\\end{pmatrix}\\)，Θ^y、Θ^z有对应的绕轴旋转公式。这确定了原表的正角主动旋转约定；五个角度均用各子步执行时的当前π^k计算。",
    "保留原表q^k:=q^k+hp^k以及正角π^k:=Θπ^k、Θ^k:=Θ^kΘ^T，不补1/M_k、不改为负角。[ERRATUM?]针对与物理运动方程的一致性；这些疑误本身不能推出该映射不辛。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "完整原表的缺质量drift与正角spin疑点保持；编译定义不代表正确辛性。"
    }
  ],
  "lean_decl": "MD.Ch04.dlmPrintedSystem",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT24_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:09:07.422606",
      "before_sha256": "c51495f9c2acdbdcad6da932e22c97d058b017c3fe25e2a3e931c6b067f540b2",
      "after_sha256": "a026443cc83f04fecff9d7054aeac581b2dc2df66c1da03dfec1bc353be0410f",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH29_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT24/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)
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
### 实际依赖 MolecularDynamics.Chapter04Review.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
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
### 实际依赖 MolecularDynamics.Chapter04Review.matrixRot
```lean
def matrixRot (A : Mat3) : V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
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
### 实际依赖 MD.Ch04.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```
### 实际依赖 MD.Ch04.dlmPrintedSystem
```lean
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)
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
### 实际依赖 MD.Ch04.matrixRot
```lean
def matrixRot (A : MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```
### 实际依赖 MD.Ch04.printedSpinAxis
```lean
def printedSpinAxis (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (h : ℝ) (s : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  let R := MolecularDynamics.Chapter04Review.axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)
```
### 实际依赖 MD.Ch04.printedSpinStep
```lean
def printedSpinStep (I : MolecularDynamics.Chapter04Review.V) (h : ℝ) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 → MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)
```
### 实际依赖 MD.Ch04.rigidSystemDriftPrinted
```lean
def rigidSystemDriftPrinted {N : ℕ} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)
```
### 实际依赖 MD.Ch04.rigidSystemForce
```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
```
### 实际依赖 MD.Ch04.rigidSystemKick
```lean
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))
```
### 实际依赖 MD.Ch04.rigidSystemSpinPrinted
```lean
def rigidSystemSpinPrinted {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)
```
### 实际依赖 MD.Ch04.rigidSystemTorque
```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
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
  "source_id": "MD-4.4.2-RigidSystemSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "the combined scheme is a symplectic method in the generalized sense of constrained dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "该短句出自PDF195（印刷173）的算法辛性断言，并非原书给出的独立定义；原文的主语the combined scheme指§4.4.2随后列出的完整刚体分裂算法。PDF196仅接续记号说明和算法表。",
    "rigidSystemSymplectic是为解释该断言引入的Lean辅助谓词；它描述N体SO(3)相空间上的约束保持及两形式拉回，单独定义这个谓词尚未断言combined scheme满足它。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整N体SO(3)配置、实际切向量和各体rbForm之和；明确包含输出配置约束及真实Fréchet拉回，不假设辛性或以抽象形式替代。",
    "[EXTRA] 本条仅定义全系统受约束两形式拉回性质，原句算法确实满足该性质由已有DLMPrintedSystemStructure断言，区分性质定义与算法定理。"
  ],
  "statement_scope": "仅全系统辛性辅助谓词定义；原文算法性质由MD-4.4.2-DLMPrintedSystemStructure承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT24_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:09:07.422754",
      "before_sha256": "18a87ef7268607f302f514a2fd3a3db5e559ed81977b1f06ae815340cbee925d",
      "after_sha256": "63f474987e633bd34686954c6d118354d6d01d32214ddb10dec0dd9dd22fd1e3",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH29_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:27:39.597807",
      "before_sha256": "63f474987e633bd34686954c6d118354d6d01d32214ddb10dec0dd9dd22fd1e3",
      "after_sha256": "54f0d407df02c115aaa1d52393d75ee3603c4fd5c4de02c9a1fbd0d5ed64cba0",
      "changed_fields": [
        "kind",
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "kind": {
          "before": "definition",
          "after": "unnumbered_claim"
        },
        "printed_page": {
          "before": "173–174",
          "after": "173"
        },
        "pdf_page": {
          "before": "195–196",
          "after": "195"
        }
      },
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH29_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json",
  "review_context_pdf_pages": [
    196
  ]
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)
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
### 实际依赖 MolecularDynamics.Chapter04Review.rbForm
```lean
def rbForm (z u v : RBState) : ℝ :=
  let ξ := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*u.2.2)
  let η := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*v.2.2)
  phaseForm u.1 v.1+dot ξ v.2.1-dot η u.2.1+dot z.2.1 (cross3 ξ η)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbTangent
```lean
def rbTangent (z v : RBState) : Prop := z.2.2ᵀ*v.2.2+v.2.2ᵀ*z.2.2=0
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.RBState
```lean
abbrev RBState := (V × V) × (V × Mat3)
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MD.Ch04.matrixRot
```lean
def matrixRot (A : MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.phaseForm
```lean
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbForm
```lean
def rbForm (z u v : RBState) : ℝ :=
  let ξ := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*u.2.2)
  let η := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*v.2.2)
  phaseForm u.1 v.1+dot ξ v.2.1-dot η u.2.1+dot z.2.1 (cross3 ξ η)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbTangent
```lean
def rbTangent (z v : RBState) : Prop := z.2.2ᵀ*v.2.2+v.2.2ᵀ*z.2.2=0
```
### 实际依赖 MD.Ch04.rigidSystemSymplectic
```lean
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.2-DLMPrintedSystemStructure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "此句完整位于PDF195（印刷173）§4.4.2，所指combined scheme是下接PDF196原表的完整N体Kick/Drift/Spin/Kick组合；该页说明逐体执行并由势U产生力与力矩。",
    "“symplectic”是约束相空间上的保两形式断言；该句没有另行断言全局误差、物理一致性阶数或经验可靠性的量化界。原表的质量及正角Spin疑点应独立记录，不静默改动。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.dlmPrintedSystemStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "C³耦合势和正主惯性矩为明确技术资格；实际全部SO3输入/输出约束及N体两形式在定义内。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT24_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:09:07.422859",
      "before_sha256": "510b4993c7671371f37c889b93ac2e2242c6ccfe3b898f5f68ea991a68b95d12",
      "after_sha256": "5a2f4b86705f6975c518fddef7547778f7219b85099ecf542d13cad4014a57ee",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH29_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:27:39.597807",
      "before_sha256": "5a2f4b86705f6975c518fddef7547778f7219b85099ecf542d13cad4014a57ee",
      "after_sha256": "89847cd01e0c326cc44c906340f62766cd53352f2d181833063422204d2b852d",
      "changed_fields": [
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "printed_page": {
          "before": "173–174",
          "after": "173"
        },
        "pdf_page": {
          "before": "195–196",
          "after": "195"
        }
      },
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH29_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json",
  "review_context_pdf_pages": [
    196
  ]
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem dlmPrintedSystemStructure : ∀ N (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ),
  (∀ k i, 0 < I k i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    rigidSystemSymplectic (dlmPrintedSystem I U h) := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
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
### 实际依赖 MolecularDynamics.Chapter04Review.matrixRot
```lean
def matrixRot (A : Mat3) : V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbForm
```lean
def rbForm (z u v : RBState) : ℝ :=
  let ξ := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*u.2.2)
  let η := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*v.2.2)
  phaseForm u.1 v.1+dot ξ v.2.1-dot η u.2.1+dot z.2.1 (cross3 ξ η)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbTangent
```lean
def rbTangent (z v : RBState) : Prop := z.2.2ᵀ*v.2.2+v.2.2ᵀ*z.2.2=0
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.RBState
```lean
abbrev RBState := (V × V) × (V × Mat3)
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch04.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```
### 实际依赖 MD.Ch04.cross3
```lean
def cross3 (u v : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V := ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MD.Ch04.dlmPrintedSystem
```lean
def dlmPrintedSystem {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V)
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ) :
    rigidSystemState N → rigidSystemState N :=
  rigidSystemKick U (h/2) ∘ rigidSystemSpinPrinted I h ∘
    rigidSystemDriftPrinted h ∘ rigidSystemKick U (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
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
### 实际依赖 MD.Ch04.matrixRot
```lean
def matrixRot (A : MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.phaseForm
```lean
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
```
### 实际依赖 MD.Ch04.printedSpinAxis
```lean
def printedSpinAxis (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (h : ℝ) (s : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  let R := MolecularDynamics.Chapter04Review.axisRotation i (h*s.1 i/I i)
  (R *ᵥ s.1,s.2*Rᵀ)
```
### 实际依赖 MD.Ch04.printedSpinStep
```lean
def printedSpinStep (I : MolecularDynamics.Chapter04Review.V) (h : ℝ) : MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 → MolecularDynamics.Chapter04Review.V × MolecularDynamics.Chapter04Review.Mat3 :=
  printedSpinAxis I 0 (h/2) ∘ printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 2 h ∘
    printedSpinAxis I 1 (h/2) ∘ printedSpinAxis I 0 (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbForm
```lean
def rbForm (z u v : RBState) : ℝ :=
  let ξ := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*u.2.2)
  let η := (1/2 : ℝ) • matrixRot (z.2.2ᵀ*v.2.2)
  phaseForm u.1 v.1+dot ξ v.2.1-dot η u.2.1+dot z.2.1 (cross3 ξ η)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbTangent
```lean
def rbTangent (z v : RBState) : Prop := z.2.2ᵀ*v.2.2+v.2.2ᵀ*z.2.2=0
```
### 实际依赖 MD.Ch04.rigidSystemDriftPrinted
```lean
def rigidSystemDriftPrinted {N : ℕ} (h : ℝ) (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1+h • (z k).1.2,(z k).1.2),(z k).2)
```
### 实际依赖 MD.Ch04.rigidSystemForce
```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
```
### 实际依赖 MD.Ch04.rigidSystemKick
```lean
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))
```
### 实际依赖 MD.Ch04.rigidSystemSpinPrinted
```lean
def rigidSystemSpinPrinted {N : ℕ} (I : Fin N → MolecularDynamics.Chapter04Review.V) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => ((z k).1,printedSpinStep (I k) h (z k).2)
```
### 实际依赖 MD.Ch04.rigidSystemSymplectic
```lean
def rigidSystemSymplectic {N : ℕ} (G : rigidSystemState N → rigidSystemState N) : Prop :=
  ∀ (z : rigidSystemState N), (∀ k, (z k).2.2ᵀ*(z k).2.2=1 ∧ (z k).2.2.det=1) →
    (∀ k, (G z k).2.2ᵀ*(G z k).2.2=1 ∧ (G z k).2.2.det=1) ∧
    ∀ (u v : rigidSystemState N), (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (u k)) → (∀ k, MolecularDynamics.Chapter04Review.rbTangent (z k) (v k)) →
      (∑ k, MolecularDynamics.Chapter04Review.rbForm (G z k) (((fderiv ℝ G z) u) k) (((fderiv ℝ G z) v) k))=
        ∑ k, MolecularDynamics.Chapter04Review.rbForm (z k) (u k) (v k)
```
### 实际依赖 MD.Ch04.rigidSystemTorque
```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
