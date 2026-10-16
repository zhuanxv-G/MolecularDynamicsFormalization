# EAUDIT89：第4章§4.4.1; 4.4.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-AxisRotation",
  "kind": "definition",
  "label": null,
  "section": "4.4.1; 4.4.2",
  "printed_page": "173–174",
  "pdf_page": "195–196",
  "statement_latex": "Each of these is, it turns out, easily integrated as a planar rotation (see Exercise 7). The notation $\\Theta^x(\\phi)$ refers to a rotation around the x-axis by an angle $\\phi$, that is\n\\[\\Theta^x(\\phi)=\\begin{bmatrix}1&0&0\\\\0&\\cos(\\phi)&-\\sin(\\phi)\\\\0&\\sin(\\phi)&\\cos(\\phi)\\end{bmatrix},\\]\nwith corresponding formulae for $\\Theta^y$ and $\\Theta^z$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "右手主动轴旋转；原书使用上标Θ^x、Θ^y、Θ^z；Fin 3的0,1,2对应书1,2,3。",
    "平面旋转句在§4.4.1 PDF195；旋转矩阵定义在§4.4.2 PDF196。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.axisRotation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT22_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:06:47.837950",
      "before_sha256": "67600283bd49520a46abeda6d1244110a66a8489e81de7ef7db957c0bf3e5836",
      "after_sha256": "f5d416463e8e975f69206a07ef3ee92a15b062d7c1c9c9bbe275e0fee86d2c3d",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:27:39.597807",
      "before_sha256": "f5d416463e8e975f69206a07ef3ee92a15b062d7c1c9c9bbe275e0fee86d2c3d",
      "after_sha256": "e2a39150e5539b58aa84be3f0a2f1189bd05c5e17510b5aeb83d09e7e117d482",
      "changed_fields": [
        "section"
      ],
      "changes": {
        "section": {
          "before": "4.4.1",
          "after": "4.4.1; 4.4.2"
        }
      },
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH25_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Mat3
```lean
abbrev Mat3 := Matrix (Fin 3) (Fin 3) ℝ
```
### 实际依赖 MD.Ch04.axisRotation
```lean
def axisRotation (i : Fin 3) (φ : ℝ) : MolecularDynamics.Chapter04Review.Mat3 :=
  if i=0 then !![1,0,0; 0,Real.cos φ,-Real.sin φ; 0,Real.sin φ,Real.cos φ]
  else if i=1 then !![Real.cos φ,0,Real.sin φ; 0,1,0; -Real.sin φ,0,Real.cos φ]
  else !![Real.cos φ,-Real.sin φ,0; Real.sin φ,Real.cos φ,0; 0,0,1]
```
