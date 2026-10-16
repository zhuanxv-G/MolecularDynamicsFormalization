# EAUDIT88：第4章§4.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.4.1-PrincipalAxisField",
  "kind": "definition",
  "label": null,
  "section": "4.4.1",
  "printed_page": "172",
  "pdf_page": "194",
  "statement_latex": "If $T$ is a diagonal matrix, $T=\\operatorname{diag}(I_1,I_2,I_3)$, then we split the Euler equations and approximate the solution by successive rotations around the three axes of inertia,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.principalAxisField",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]将第二和第三子场的分量分别明确为π₂/π₃；原印刷两处缺下标另列待审，不覆盖原式。",
    "[EXTRA] 本条为单轴分裂场定义；完整印刷五次轴复合由PrintedSpinStep承担，实际子流的负角与原印正角冲突保留AxisFlowFormal/ExactPlanarRotation待导师。"
  ],
  "statement_scope": "仅各单轴子向量场的定义；完整印刷五次复合由MD-4.4.1-PrintedSpinStep承担，精确平面子流解释由MD-4.4.1-ExactPlanarRotation单列待导师。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "date": "2026-10-11",
      "reason": "原页高倍率复核纠正预备转录：列动量Rπ、方向ΘRᵀ与正式库一致；第二及第三拆分均缺下标。原记录归档，正角与π×ω子流符号疑点仍待审。",
      "before": "blueprint/ch04/validation/transcription-repair-20261011/BEFORE.json",
      "visual_sha256": {
        "blueprint/ch04/source_pages/p195-split-detail.png": "2187e0fc326143559f3ee751a3d628e8168e8376ed833d5b4d440bb1cf5039b0",
        "blueprint/ch04/source_pages/p196-spin-detail.png": "103c0a22caee08e216a7a749055fb24cd007afd063c43f0139555845b335c501"
      }
    },
    {
      "stage": "EAUDIT22_LOCAL_REPAIR",
      "timestamp": "2026-10-15T19:06:47.838276",
      "before_sha256": "774a90154c526837dd0378beb1b03489dd2c49827b07bd7426fddfa7cf16ed72",
      "after_sha256": "1e9b4b8025c9d2e73b7df4e010e0fed36eb336ba66b490f65b607d9d94b96602",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:27:39.597807",
      "before_sha256": "1e9b4b8025c9d2e73b7df4e010e0fed36eb336ba66b490f65b607d9d94b96602",
      "after_sha256": "41bc804261bd3befd3db1da8b045c5a8743181514c5f6167fd6980eba5ef0b09",
      "changed_fields": [
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "printed_page": {
          "before": "173",
          "after": "172"
        },
        "pdf_page": {
          "before": "195",
          "after": "194"
        }
      },
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH25_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json",
  "review_context_pdf_pages": [
    195
  ]
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def principalAxisField (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))
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
### 实际依赖 MD.Ch04.principalAxisField
```lean
def principalAxisField (I : MolecularDynamics.Chapter04Review.V) (i : Fin 3) (π : MolecularDynamics.Chapter04Review.V) : MolecularDynamics.Chapter04Review.V :=
  MolecularDynamics.Chapter04Review.cross3 π (Pi.single i (π i/I i))
```
