# EAUDIT90：第4章§4.4.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4.2-RigidForce",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "The relevant expressions are $F^k=-\\partial U/\\partial q^k$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实Fréchet偏导，不用新力公理。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidForce",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:08:05.166905",
      "before_sha256": "3547c82e3f532215698ac3d6e2bac146187dc01a4bfd7ca624fcdeffc18368e8",
      "after_sha256": "f70e6e8be9a4fae5291e8721e2078009e93c1ee681adb1264c3d8895ff31a805",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
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
### 实际依赖 MD.Ch04.rigidForce
```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
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
  "source_id": "MD-4.4.2-RigidTorque",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "$\\tau^k=-\\operatorname{rot}(\\Theta^{kT}\\partial U/\\partial\\Theta^k)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidTorque",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:08:05.166978",
      "before_sha256": "20c33291461e2227e591dd3288aba53e00710cf2a7705ee985380ae56568ed49",
      "after_sha256": "fd99cf822ad637ac4e9037b397280e533c437371b2ab01e1c81d74a74969eb52",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
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
### 实际依赖 MolecularDynamics.Chapter04Review.matrixGrad
```lean
def matrixGrad (U : Mat3 → ℝ) (Θ : Mat3) : Mat3 :=
  fun i j => (fderiv ℝ U Θ) (Pi.single i (Pi.single j 1))
```
### 实际依赖 MolecularDynamics.Chapter04Review.matrixRot
```lean
def matrixRot (A : Mat3) : V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
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
### 实际依赖 MD.Ch04.rigidTorque
```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.2-DLMPrinted",
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
    "原表列动量Rπ与方向ΘRᵀ，与正式库一致。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "字面drift缺1/M；正角spin动量符号疑点保留。"
    }
  ],
  "lean_decl": "MD.Ch04.dlmPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]本条仅N=1实例；任意N体耦合势与完整算法另由DLMPrintedSystem忠实保存。",
    "[EXTRA] 保留N=1字面算法作为单体实例；完整任意N、耦合势、逐阶段重算所有力矩的原算法已由DLMPrintedSystem覆盖，显式跨条目映射，不以单体冒充全系统。"
  ],
  "statement_scope": "原DLM完整算法的N=1实例；任意N耦合系统的原算法由MD-4.4.2-DLMPrintedSystem承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:08:05.167047",
      "before_sha256": "2977371f7c85a40fe01be775116598a1fa5ba83c4fc73c3d874e3594e7670836",
      "after_sha256": "2643525c73aeb83492cd75e88bb0a64f0e6b63cb80c95f59fba586a42bed144f",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def dlmPrinted (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.RBState
```lean
abbrev RBState := (V × V) × (V × Mat3)
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
### 实际依赖 MolecularDynamics.Chapter04Review.rigidDrift
```lean
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidKick
```lean
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
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
### 实际依赖 MD.Ch04.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```
### 实际依赖 MD.Ch04.dlmPrinted
```lean
def dlmPrinted (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
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
### 实际依赖 MolecularDynamics.Chapter04Review.rigidDrift
```lean
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
```
### 实际依赖 MD.Ch04.rigidForce
```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidKick
```lean
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
```
### 实际依赖 MD.Ch04.rigidTorque
```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
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
  "source_id": "MD-4.4.2-DriftSpinCommute",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "Note that the symmetric character of the algorithm could be revealed more clearly by dividing the “Drift” step into two half steps sandwiched around the Spin step (Kick, Drift, Spin, Drift, Kick), but as the updates Drift/Spin are decoupled, the order they are performed is not important.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实原字面五轴spin与质量drift的全状态相等，非只算子标签。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.driftSpinCommute",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原交换性证明，并补漂移半步合成与完整Kick/Drift/Spin/Drift/Kick排列恒等式；M=1即字面原算法，新结论暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:08:05.167172",
      "before_sha256": "029339cc1edf2426245e682d5bcf76afbc3e87a29a12fe1e5e35bc1e3981c5e6",
      "after_sha256": "70502d8456d3d9349d97b1c5d41a98273f744f34f7fab7ce4136ef87ff4505c0",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem driftSpinCommute : ∀ M h (I : MolecularDynamics.Chapter04Review.V) (z : MolecularDynamics.Chapter04Review.RBState),
  MolecularDynamics.Chapter04Review.rigidDrift M h (z.1,printedSpinStep I h z.2)=
    ((MolecularDynamics.Chapter04Review.rigidDrift M h z).1,printedSpinStep I h (MolecularDynamics.Chapter04Review.rigidDrift M h z).2) := by
  intro M h I z
  rfl

theorem driftSpinCommute_halves (M h : ℝ) (I : MolecularDynamics.Chapter04Review.V)
    (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) :
    MolecularDynamics.Chapter04Review.rigidDrift M h=
      MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘ MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∧
    (MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘
      (fun z : MolecularDynamics.Chapter04Review.RBState ↦ (z.1,printedSpinStep I h z.2)) ∘
      MolecularDynamics.Chapter04Review.rigidDrift M h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2))=
    (MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘
      (fun z : MolecularDynamics.Chapter04Review.RBState ↦ (z.1,printedSpinStep I h z.2)) ∘
      MolecularDynamics.Chapter04Review.rigidDrift M (h/2) ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)) := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.RBState
```lean
abbrev RBState := (V × V) × (V × Mat3)
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
### 实际依赖 MolecularDynamics.Chapter04Review.rigidDrift
```lean
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidKick
```lean
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
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
### 实际依赖 MD.Ch04.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
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
### 实际依赖 MolecularDynamics.Chapter04Review.rigidDrift
```lean
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
```
### 实际依赖 MD.Ch04.rigidForce
```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidKick
```lean
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
```
### 实际依赖 MD.Ch04.rigidTorque
```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
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
  "source_id": "MD-4.4.2-DLMPrintedStructure",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173–174",
  "pdf_page": "195–196",
  "statement_latex": "The reliability of these methods is supported by the fact that the combined scheme is a symplectic method in the generalized sense of constrained dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.dlmPrintedStructure",
  "reusable_proofs": [],
  "extra_assumptions": [
    "明确SO3初态与实际切向量在rbSymplectic定义内；单位质量为原字面drift。",
    "[EXTRA] 本条仅为字面单体辛性实例；原句任意N耦合算法与输入/输出SO(3)域由DLMPrintedSystemStructure承担，不再把rbSymplectic名字当作完整输出约束。"
  ],
  "statement_scope": "仅N=1字面算法两形式拉回等式；原全系统含SO(3)域的结构断言由MD-4.4.2-DLMPrintedSystemStructure承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:08:05.167282",
      "before_sha256": "bc75cdf59a42ab712b306f3ae3598c952d919e243c6da478e8ab46bbf3188ac0",
      "after_sha256": "d485e6e4d92de883bc50c416d9b34145c52211f71cb6a7efb7f5b6778d2feac6",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem dlmPrintedStructure : ∀ (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ),
  (∀ i, 0 < I i) → ContDiff ℝ 3 (Function.uncurry U) → ∀ h,
    MolecularDynamics.Chapter04Review.rbSymplectic (dlmPrinted I U h) := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.RBState
```lean
abbrev RBState := (V × V) × (V × Mat3)
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
### 实际依赖 MolecularDynamics.Chapter04Review.rbSymplectic
```lean
def rbSymplectic (G : RBState → RBState) : Prop :=
  ∀ z, z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 → ∀ u v, rbTangent z u → rbTangent z v →
    rbForm (G z) ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=rbForm z u v
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidDrift
```lean
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidKick
```lean
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
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
### 实际依赖 MD.Ch04.dlmPrinted
```lean
def dlmPrinted (I : MolecularDynamics.Chapter04Review.V) (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (h : ℝ) : MolecularDynamics.Chapter04Review.RBState → MolecularDynamics.Chapter04Review.RBState :=
  MolecularDynamics.Chapter04Review.rigidKick U (h/2) ∘ (fun z => (z.1,printedSpinStep I h z.2)) ∘
    MolecularDynamics.Chapter04Review.rigidDrift 1 h ∘ MolecularDynamics.Chapter04Review.rigidKick U (h/2)
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
### 实际依赖 MolecularDynamics.Chapter04Review.rbSymplectic
```lean
def rbSymplectic (G : RBState → RBState) : Prop :=
  ∀ z, z.2.2ᵀ*z.2.2=1 → z.2.2.det=1 → ∀ u v, rbTangent z u → rbTangent z v →
    rbForm (G z) ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=rbForm z u v
```
### 实际依赖 MolecularDynamics.Chapter04Review.rbTangent
```lean
def rbTangent (z v : RBState) : Prop := z.2.2ᵀ*v.2.2+v.2.2ᵀ*z.2.2=0
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidDrift
```lean
def rigidDrift (M h : ℝ) (z : RBState) : RBState := ((z.1.1+(h/M) • z.1.2,z.1.2),z.2)
```
### 实际依赖 MD.Ch04.rigidForce
```lean
def rigidForce (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.grad (fun x => U x Θ) q
```
### 实际依赖 MolecularDynamics.Chapter04Review.rigidKick
```lean
def rigidKick (U : V → Mat3 → ℝ) (h : ℝ) (z : RBState) : RBState :=
  ((z.1.1,z.1.2+h • rigidForce U z.1.1 z.2.2),
    (z.2.1+h • rigidTorque U z.1.1 z.2.2,z.2.2))
```
### 实际依赖 MD.Ch04.rigidTorque
```lean
def rigidTorque (U : MolecularDynamics.Chapter04Review.V → MolecularDynamics.Chapter04Review.Mat3 → ℝ) (q : MolecularDynamics.Chapter04Review.V) (Θ : MolecularDynamics.Chapter04Review.Mat3) := -MolecularDynamics.Chapter04Review.matrixRot (Θᵀ*MolecularDynamics.Chapter04Review.matrixGrad (U q) Θ)
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
  "source_id": "MD-4.4.2-RigidSystemForce",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "The relevant expressions are: $F^k=-\\partial U/\\partial q^k$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实耦合势的第k个位置切片Fréchet梯度；其余坐标保持在当前完整状态。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemForce",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:08:05.167331",
      "before_sha256": "d0481ad2d65a7511667780ccd459c9c97db9b7f38150cf1c39d803b928501f58",
      "after_sha256": "592a432409baf4021cd88278fdeec11cfc78fbdb8bc07a6a2d6cc8ba43bc0e64",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
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
### 实际依赖 MD.Ch04.rigidSystemForce
```lean
def rigidSystemForce {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.grad (fun x => U (Function.update (fun j => (z j).1.1) k x) (fun j => (z j).2.2)) (z k).1.1
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
  "source_id": "MD-4.4.2-RigidSystemTorque",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "173",
  "pdf_page": "195",
  "statement_latex": "$\\tau^k=-\\operatorname{rot}([\\Theta^k]^T\\partial U/\\partial\\Theta^k)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实矩阵元素Fréchet偏导；rot(A)=skew⁻¹(A−Aᵀ)，没有额外1/2。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemTorque",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT24_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:09:07.422301",
      "before_sha256": "083dfdb7adb783b7640827404eab5c106ea03aa6565e863d41e4a0c7ba7c8d34",
      "after_sha256": "b5fd0decc63f66bd041a9e58924b54256fe9c1ed27b789f929c3b92f0e7a2903",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT24/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
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
### 实际依赖 MolecularDynamics.Chapter04Review.matrixGrad
```lean
def matrixGrad (U : Mat3 → ℝ) (Θ : Mat3) : Mat3 :=
  fun i j => (fderiv ℝ U Θ) (Pi.single i (Pi.single j 1))
```
### 实际依赖 MolecularDynamics.Chapter04Review.matrixRot
```lean
def matrixRot (A : Mat3) : V := ![A 2 1-A 1 2,A 0 2-A 2 0,A 1 0-A 0 1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.V
```lean
abbrev V := Fin 3 → ℝ
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
### 实际依赖 MD.Ch04.rigidSystemTorque
```lean
def rigidSystemTorque {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ)
    (z : rigidSystemState N) (k : Fin N) : MolecularDynamics.Chapter04Review.V :=
  -MolecularDynamics.Chapter04Review.matrixRot ((z k).2.2ᵀ * MolecularDynamics.Chapter04Review.matrixGrad
    (fun A => U (fun j => (z j).1.1) (Function.update (fun j => (z j).2.2) k A)) (z k).2.2)
```

## 原文JSON
```json
{
  "source_id": "MD-4.4.2-RigidSystemKick",
  "kind": "definition",
  "label": null,
  "section": "4.4.2",
  "printed_page": "174",
  "pdf_page": "196",
  "statement_latex": "“Kick”: update the momenta and angular momentum vectors with known forces and torques for a half step:\n\\[p^k:=p^k+\\tfrac h2 F^k;\\quad\\pi^k:=\\pi^k+\\tfrac h2\\tau^k.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "参数h表示本次kick长度；整体算法以h/2调用，全部力/力矩从同一当前状态同时计算。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.rigidSystemKick",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT24_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:09:07.422469",
      "before_sha256": "ccf409f66e1144ce95c4cb8f8eb3ee6965f5ec31d6c576566c93478b76e856a8",
      "after_sha256": "c2128a8a8805e081d2e9f876c411cc3c04e9e84154aed3d6a27fc833761909f6",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT24/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def rigidSystemKick {N : ℕ}
    (U : (Fin N → MolecularDynamics.Chapter04Review.V) → (Fin N → MolecularDynamics.Chapter04Review.Mat3) → ℝ) (h : ℝ)
    (z : rigidSystemState N) : rigidSystemState N :=
  fun k => (((z k).1.1,(z k).1.2+h • rigidSystemForce U z k),
    ((z k).2.1+h • rigidSystemTorque U z k,(z k).2.2))
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
