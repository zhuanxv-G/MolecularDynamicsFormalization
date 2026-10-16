# EAUDIT91：第2章§2.4.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.3-HarmonicSplit",
  "kind": "definition",
  "label": null,
  "section": "2.4.3",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "Some systems can be decomposed into a harmonic (quadratic) part $H_0(\\boldsymbol q,\\boldsymbol p)=\\boldsymbol p^T M^{-1}\\boldsymbol p/2+\\boldsymbol q^T A\\boldsymbol q/2$ and an anharmonic part $H_1(\\boldsymbol q,\\boldsymbol p)=\\hat U(\\boldsymbol q)$. Then a splitting method can be formulated based on exact solution of the linear system together with “kicks” representing impulses defined by the anharmonic part. For a simple system consisting of a harmonic oscillator $H_0(q,p)=p^2/2+\\Omega^2q^2/2$, such a method can be written\n\\[\\begin{bmatrix}Q\\\\\\hat p\\end{bmatrix}=\\begin{bmatrix}\\cos h\\Omega&\\frac{1}{\\Omega}\\sin h\\Omega\\\\-\\Omega\\sin h\\Omega&\\cos h\\Omega\\end{bmatrix}\\begin{bmatrix}q\\\\p\\end{bmatrix},\\qquad P=\\hat p-h\\hat U'(Q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文一般情形中 q、p 为向量，M 为质量矩阵，A 为二次势矩阵；标量简例中的 q、p、Q、p̂、P 为实数，Ω 为振子频率，h 为步长，原文扰动势记为 Û。Lean 的 U 对应原文 Û；Lean 定义仅覆盖原文明确给出的标量简例，一般矩阵分裂保留为背景。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_harmonicAnharmonic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。",
    "[EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:22:34.432802",
      "before_sha256": "99e865286f29241f8c5a36091cf15f842f21683fa98b03ed2785530c740a33c9",
      "after_sha256": "197b309681a8300f168e16cf194798b9fc56d152bdb657f2914c8b9050a241f3",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:26:18.212960",
      "before_sha256": "197b309681a8300f168e16cf194798b9fc56d152bdb657f2914c8b9050a241f3",
      "after_sha256": "c31f911f4ecf219615256b673242407be5aeca5102f379370cc1b3f0326aba7c",
      "changed_fields": [
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "printed_page": {
          "before": "85–86",
          "after": "85"
        },
        "pdf_page": {
          "before": "107–108",
          "after": "107"
        }
      },
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH24_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json",
  "review_context_pdf_pages": [
    108
  ]
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_harmonicAnharmonic (Ω : ℝ) (_hΩ : Ω ≠ 0) (U : ℝ → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```
### 实际依赖 MD.Ch02.bp_harmonicAnharmonic
```lean
def bp_harmonicAnharmonic (Ω : ℝ) (_hΩ : Ω ≠ 0) (U : ℝ → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```
