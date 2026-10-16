# EAUDIT52：第5章§5.3.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-IdealGasPositionDomain",
  "kind": "definition",
  "label": null,
  "section": "5.3.2",
  "printed_page": "193–194",
  "pdf_page": "214–215",
  "statement_latex": "$Z_E=V^N\\int_S(m/r)d\\sigma$, where $S$ is the $3N-1$ dimensional sphere in $3N$ dimensions of radius $r=\\sqrt{2mE}$, and $d\\sigma$ is the surface area element on this sphere. $V^N$ is the contribution due to integration over positions.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Z_E=μ(Σ_E)为微正则分区函数，N为三维粒子数，V为周期盒体积，m为质量，E为能量；S位于3N维动量空间。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.idealGasPositionDomain",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]选择边长L的三维立方基本胞，V=L³；实际位置域有限，不能对无限全位置空间积分再声称分区函数有限。周期边界的基本胞面零测度识别未证明。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。"
  ],
  "statement_scope": "仅有限位置立方胞辅助域定义；球面半径、位置体积因子和真实微正则分解由MD-5.3.2-IdealGasPartition补全，闭胞边界零测不声称逐点周期识别。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:59:03.890531",
      "before_sha256": "1f7d380cc6c4127627f6fa65882028aad4cc903e0a7bf8261f44c65d77103642",
      "after_sha256": "65983f592b1079ffd54abcf0326c2a78a06fbcc99eea870002c6517cf9c341fb",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT10/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.idealGasPositionDomain
```lean
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.2-IdealGasPartition",
  "kind": "unnumbered_claim",
  "label": "Example 5.2",
  "section": "5.3.2",
  "printed_page": "194",
  "pdf_page": "215",
  "statement_latex": "Thus we have\n\\[Z_E=V^N\\frac{m}{\\sqrt{2mE}}A(S)\n=V^N\\frac{\\sqrt m}{\\sqrt{2E}}\\frac{3N\\pi^{3N/2}(2mE)^{(3N-1)/2}}{\\Gamma(3N/2+1)}\n=V^N\\frac{(2\\pi mE)^{3N/2}}{E\\Gamma(3N/2)}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "S为3N维动量空间中半径r=√(2mE)的(3N−1)维球面；A(S)为其面积，Γ为gamma函数，V^N为位置积分体积因子，Z_E为微正则分区函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.idealGasPartition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]正N/m/E/L、有限基本胞V=L³；微正则raw测度在位置胞上实际限制。3N系数是球面积的正确系数，不登记伪造勘误。",
    "[EXTRA] 补真实动量(3N−1)维球面S、r=√(2mc)、位置体积(L³)^N及面积/Gamma两项中间分解，保留原终值；不以参数积分作microRaw定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT10_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:59:03.890531",
      "before_sha256": "d3eea283bd0f906e565b58044737e7e3a7e5e698d78a7977dab2f96d918c3212",
      "after_sha256": "2320acd02ed5db02c9f3ff7f26c0f57bd5d07c8943b4c402d339d89d63bf29f3",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:28:28.864805",
      "before_sha256": "2320acd02ed5db02c9f3ff7f26c0f57bd5d07c8943b4c402d339d89d63bf29f3",
      "after_sha256": "0886200657682fd40d737c67cd92ef7cf9ea9c603035822a81fdc053267f5603",
      "changed_fields": [
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "printed_page": {
          "before": "193–194",
          "after": "194"
        },
        "pdf_page": {
          "before": "214–215",
          "after": "215"
        }
      },
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH15_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json",
  "review_context_pdf_pages": [
    214
  ]
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem idealGasPartition : ∀ (N : ℕ) (m c L : ℝ),0 < N → 0 < m → 0 < c → 0 < L →
  ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal=
    (L^3)^N*Real.rpow (2*Real.pi*m*c) ((3*N : ℝ)/2)/(c*Real.Gamma ((3*N : ℝ)/2)) := by
  sorry

theorem idealGasPartition_factors (N : ℕ) (m c L : ℝ)
    (_hN : 0 < N) (_hm : 0 < m) (_hc : 0 < c) (_hL : 0 < L) :
    let S := Metric.sphere (0 : MolecularDynamics.Chapter05Review.E (3*N)) (Real.sqrt (2*m*c))
    let A := (MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1) S).toReal
    let Z := ((MolecularDynamics.Chapter05Review.microRaw (idealGasEnergy N m) c) (idealGasPositionDomain N L)).toReal
    Z=(L^3)^N*(∫ p in S,m/Real.sqrt (2*m*c)
      ∂(MolecularDynamics.Chapter05Review.hausdorffArea (3*N-1))) ∧
    Z=(L^3)^N*(m/Real.sqrt (2*m*c))*A ∧
    Z=(L^3)^N*(Real.sqrt m/Real.sqrt (2*c))*
      ((3*N : ℝ)*Real.rpow Real.pi ((3*N : ℝ)/2)*Real.rpow (2*m*c) (((3*N : ℝ)-1)/2)/
      Real.Gamma ((3*N : ℝ)/2+1)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.microRaw
```lean
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
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
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.idealGasEnergy
```lean
def idealGasEnergy (N : ℕ) (m : ℝ) (z : MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  (∑ i : Fin (3*N),(z (Fin.natAdd (3*N) i))^2)/(2*m)
```
### 实际依赖 MD.Ch05.idealGasPositionDomain
```lean
def idealGasPositionDomain (N : ℕ) (L : ℝ) : Set (MolecularDynamics.Chapter05Review.E (3*N+3*N)) :=
  {z | ∀ i : Fin (3*N),z (Fin.castAdd (3*N) i) ∈ Icc (0 : ℝ) L}
```
### 实际依赖 MD.Ch05.microRaw
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```
### 实际依赖 MD.Ch05.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
