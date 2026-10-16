# EAUDIT30：第5章§5.3.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-TestSpace",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "The functions on which the generalized function acts are called test functions. Some choices for the space of test functions $\\mathcal T^m$ defined on $\\mathbb R^m$ include: the $C^\\infty$ functions with compact support in $\\mathbb R^m$, denoted $C_0^\\infty(\\mathbb R^m)$; the space $\\mathcal S(\\mathbb R^m)$ of $C^\\infty$ functions on $\\mathbb R^m$ whose derivatives decay rapidly at infinity (the so-called Schwarz space).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "两个测试空间选项都保留；紧支持C∞子类型是实际函数与资格，不把任意函数称测试函数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.testSpace",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "3025fabb512c2d3501e542f4dab5dc643d4df7e51433dfc9956f8cfeeaef6692",
      "after_sha256": "cb27a1acc178e78b65d3c98d2041b444a26dd3bf734f5f5c3d683684ad39cf15",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.testSpace
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-RegularDistribution",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "If $f$ is a bounded, smooth function on $\\mathbb R^m$, we may define a generalized function $T_f$ by reference to its action on a test function $\\phi\\in\\mathcal T$ via integration:\n\\[T_f(\\phi)=\\int_{\\mathbb R^m}f(z)\\phi(z)d\\omega.\\]\nThis is very like the $L^2$ inner product, but the functions involved do not both need to lie in $L^2$. Nevertheless, we write $T_f(\\phi)=\\langle f,\\phi\\rangle$, as a helpful shorthand.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Lebesgue积分配对；线性泛函性质及有界光滑f下可积性须另证，定义编译未代替这一结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.regularDistribution",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "bb7ea56efbc4935d1abc093fefcd4deaca0cb80b6f15e3d26f260d1e0a727124",
      "after_sha256": "88277dc08a9391e5dac116d37607ba2360a18adfe1f373951961f0aff0047a72",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```
### 实际依赖 MD.Ch05.regularDistribution
```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-RegularDistributionLinearity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "188",
  "pdf_page": "209",
  "statement_latex": "If $f$ is a bounded, smooth function on $\\mathbb R^m$, we may define a generalized function $T_f$ by reference to its action on a test function $\\phi\\in\\mathcal T$ via integration: $T_f(\\phi)=\\int_{\\mathbb R^m}f(z)\\phi(z)d\\omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.regularDistributionLinearity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。",
    "[EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "0fd41af0f8f39405a594fdc30a02bf80cc5e31a3a47060861838d7ff2d795f5f",
      "after_sha256": "c441d60331f1c7260438916f13f224529e97bdee2c02776f960916ca252b14a3",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem regularDistributionLinearity : ∀ n (f : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ ∞ f → (∃ C : ℝ,∀ z,|f z| ≤ C) →
  (∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,Integrable (fun z => f z*φ z) volume) ∧
  (∀ (φ ψ : MolecularDynamics.Chapter05Review.schwartzSpace n) (a b : ℝ),
    MolecularDynamics.Chapter05Review.regularDistribution f (a • φ+b • ψ)=a*MolecularDynamics.Chapter05Review.regularDistribution f φ+b*MolecularDynamics.Chapter05Review.regularDistribution f ψ) := by
  intro n f hf hb
  obtain ⟨C,hC⟩ := hb
  have hi : ∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,
      Integrable (fun z => f z*φ z) volume := by
    intro φ
    apply Integrable.mono' (φ.integrable.norm.mul_const C)
    · exact hf.continuous.measurable.aestronglyMeasurable.mul φ.continuous.measurable.aestronglyMeasurable
    · filter_upwards [] with z
      simpa only [norm_mul,Real.norm_eq_abs,mul_comm] using mul_le_mul_of_nonneg_right (hC z) (abs_nonneg (φ z))
  refine ⟨hi,?_⟩
  intro φ ψ a b
  simp only [MolecularDynamics.Chapter05Review.regularDistribution,SchwartzMap.add_apply,SchwartzMap.smul_apply,smul_eq_mul]
  simp_rw [mul_add,← mul_assoc,mul_comm (f _) a,mul_comm (f _) b]
  simp_rw [mul_assoc]
  rw [integral_add ((hi φ).const_mul a) ((hi ψ).const_mul b),integral_const_mul,integral_const_mul]
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularDistribution
```lean
def regularDistribution {n : ℕ} (f : E n → ℝ) (φ : schwartzSpace n) := ∫ z, f z*φ z
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```
### 实际依赖 MD.Ch05.regularDistribution
```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-GaussianDelta",
  "kind": "definition",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "Alternatively, one may use a sequence of smooth functions $\\{d_\\varepsilon\\}$, such as, in one dimension,\n\\[d_\\varepsilon=\\frac1{\\sqrt{2\\varepsilon\\pi}}\\exp\\left(-\\frac{z^2}{2\\varepsilon}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Gaussian替代族的真实函数，ε>0下有概率解释；其支撑是整个ℝ，未声称它满足上一条紧支撑收缩条件。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianDelta",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "e1421336f82a2c6bba8b950588d14e2f98ca018fbac418da9bee6c6cec1eae16",
      "after_sha256": "af7ae2daf1cae4f65bd826ade53e31b14041698bba82d454572c3ab11dbbd720",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```
### 实际依赖 MD.Ch05.gaussianDelta
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-DiracEvaluates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "$\\langle\\delta,\\phi\\rangle=\\int\\delta(z)\\phi(z)d\\omega=\\phi(0)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "形式积分以真实Dirac测度实现；不是给δ(z)定义普通Lebesgue函数。",
    "φ∈𝒯；上文 PDF209／印刷188页列出可选测试空间 C_c^∞(ℝ^m) 与 Schwartz 空间 𝒮(ℝ^m)，此条 Lean 选择后者；dω 为欧氏空间体积积分记号，δ 处的积分为分布配对的形式写法。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.diracEvaluates",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "945575ce2975c939b7e9dc22b07ec1ab27dd38dcb3889a06cdbe5c6f0f918d95",
      "after_sha256": "c86ee6d608307f67672c2c2101cedf87805f08994f00aeaae54a435af11719e2",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem diracEvaluates : ∀ n (φ : MolecularDynamics.Chapter05Review.schwartzSpace n),
  (∫ z,φ z ∂(MolecularDynamics.Chapter05Review.diracMeasure n))=MolecularDynamics.Chapter05Review.diracAction φ := by
  intro n φ
  simp [MolecularDynamics.Chapter05Review.diracMeasure,MolecularDynamics.Chapter05Review.diracAction]
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.diracAction
```lean
def diracAction {n : ℕ} (φ : schwartzSpace n) := φ 0
```
### 实际依赖 MolecularDynamics.Chapter05Review.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (E n) := Measure.dirac 0
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```
### 实际依赖 MD.Ch05.diracAction
```lean
def diracAction {n : ℕ} (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := φ 0
```
### 实际依赖 MD.Ch05.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```
### 实际依赖 MolecularDynamics.Chapter05Review.schwartzSpace
```lean
abbrev schwartzSpace (n : ℕ) := SchwartzMap (E n) ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-GaussianDeltaProbability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "Alternatively, one may use a sequence of smooth functions $\\{d_\\varepsilon\\}$, such as, in one dimension,\n\\[d_\\varepsilon=\\frac1{\\sqrt{2\\varepsilon\\pi}}\\exp\\left(-\\frac{z^2}{2\\varepsilon}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianDeltaProbability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "f442228c15bccaa64f44fad09ef947e9b256c2786bc39f09306fe9c2b878c131",
      "after_sha256": "415fc0540e926753a920692744d5acc2edfadaef92aa4f4ed01a23e6b3b7b3eb",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ MolecularDynamics.Chapter05Review.gaussianDelta ε x) ∧ Integrable (MolecularDynamics.Chapter05Review.gaussianDelta ε) volume ∧
  (∫ x,MolecularDynamics.Chapter05Review.gaussianDelta ε x)=1 := by
  intro ε hε
  have he0 : ε ≠ 0 := ne_of_gt hε
  have hcoef : 0 < (1 : ℝ)/(2*ε) := by positivity
  have heq : MolecularDynamics.Chapter05Review.gaussianDelta ε=
      (fun x : ℝ => Real.exp (-(1/(2*ε))*x^2)/Real.sqrt (2*Real.pi*ε)) := by
    funext x
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    congr 2
    ring
  rw [heq]
  refine ⟨fun x => by positivity,?_,?_⟩
  · exact (integrable_exp_neg_mul_sq hcoef).div_const _
  · rw [integral_div,integral_gaussian]
    have hp0 : 0 ≤ 2*Real.pi*ε := by positivity
    have hratio : Real.pi/(1/(2*ε))=2*Real.pi*ε := by field_simp
    rw [hratio,div_self (ne_of_gt (Real.sqrt_pos.2 (by positivity)))]
```
### 实际依赖 MolecularDynamics.Chapter05Review.gaussianDelta
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```
### 实际依赖 MD.Ch05.gaussianDelta
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

## 原文JSON
```json
{
  "source_id": "MD-5.3.1-GaussianDeltaWeak",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.3.1",
  "printed_page": "189",
  "pdf_page": "210",
  "statement_latex": "Alternatively, one may use a sequence of smooth functions $\\{d_\\varepsilon\\}$, such as, in one dimension,\n\\[d_\\varepsilon=\\frac1{\\sqrt{2\\varepsilon\\pi}}\\exp\\left(-\\frac{z^2}{2\\varepsilon}\\right).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.gaussianDeltaWeak",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:57:24.308932",
      "before_sha256": "a3cf004e1b687c4d119ea4126608b44d3287c3adeee46aa24428dd02f20e5427",
      "after_sha256": "853ac0244308e9f43f40535c31e81e52128406ca8dd6bbf28d6fef5a720c57b5",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH11_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro φ hφ hb
  have hg := gaussianDeltaProbability 1 (by norm_num)
  obtain ⟨C,hC,hBC⟩ := hb.exists_pos_norm_le
  have ht : Tendsto (fun ε : ℝ => ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (𝓝[>] 0) (𝓝 (φ 0)) := by
    have hc := tendsto_integral_filter_of_dominated_convergence
      (fun x : ℝ => C*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (F:=fun ε x => φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (f:=fun x => φ 0*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (Filter.Eventually.of_forall (fun ε => by
        apply Continuous.aestronglyMeasurable
        unfold MolecularDynamics.Chapter05Review.gaussianDelta
        fun_prop))
      (Filter.Eventually.of_forall (fun ε => ae_of_all _ (fun x => by
        simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hg.1 x)] using
          mul_le_mul_of_nonneg_right (hBC (φ (Real.sqrt ε*x)) (mem_range_self _)) (hg.1 x))))
      (hg.2.1.const_mul C) (ae_of_all _ (fun x => by
        have hs : Tendsto (fun ε : ℝ => Real.sqrt ε*x) (𝓝[>] 0) (𝓝 0) := by
          simpa using! ((Real.continuous_sqrt.tendsto 0).mono_left inf_le_left).mul_const x
        exact (hφ.tendsto 0 |>.comp hs).mul_const _))
    simpa only [integral_const_mul,hg.2.2,mul_one] using hc
  apply tendsto_congr' _ |>.2 ht
  filter_upwards [self_mem_nhdsWithin] with ε hε
  have hεpos : 0 < ε := hε
  have hspos : 0 < Real.sqrt ε := Real.sqrt_pos.2 hεpos
  have hs0 : Real.sqrt ε ≠ 0 := ne_of_gt hspos
  have hpoint (x : ℝ) : Real.sqrt ε*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)=
      MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    rw [mul_pow,Real.sq_sqrt hεpos.le]
    have hexp : -(ε*x^2)/(2*ε)= -x^2/2 := by field_simp
    rw [hexp,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
    simp only [mul_one]
    field_simp
  calc
    (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=
      Real.sqrt ε*(∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)) := by
        change (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=Real.sqrt ε*(∫ x,(fun y => φ y*MolecularDynamics.Chapter05Review.gaussianDelta ε y) (Real.sqrt ε*x))
        have hchange : (∫ x : ℝ,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x))=
            (Real.sqrt ε)⁻¹*(∫ x : ℝ,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) := by
          simpa only [smul_eq_mul,abs_of_pos (inv_pos.mpr hspos)] using!
            (Measure.integral_comp_mul_left (fun x : ℝ => φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (Real.sqrt ε))
        rw [hchange]
        field_simp
    _ = ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
      rw [←integral_const_mul]
      apply integral_congr_ae
      filter_upwards [] with x
      rw [←hpoint]
      ring
```
### 实际依赖 MolecularDynamics.Chapter05Review.gaussianDelta
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```
### 实际依赖 MD.Ch05.gaussianDelta
```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```
