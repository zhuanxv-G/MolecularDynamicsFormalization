# EAUDIT01：第5章§5.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.1-FlowFieldTransport",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "On the other hand, viewing $\\mathcal L_f$ as an operator on the phase variables only, we have\n\\[(\\mathcal L_f\\widetilde g)(z)=f(z)\\cdot\\nabla_z[g(\\mathcal F_t(z))]\n=f(z)\\cdot\\mathcal F_t'(z)^T\\nabla g(\\mathcal F_t(z))\n=\\mathcal F_t'(z)f(z)\\cdot\\nabla g(\\mathcal F_t(z))\n=f(\\mathcal F_t(z))\\cdot\\nabla g(\\mathcal F_t(z))\n=(\\mathcal L_fg)(\\mathcal F_t(z)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.flowFieldTransport",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际自治流群律、联合C²光滑；本条保存中间输运恒等式DFt(z)f(z)=f(Ft(z))，完整PDE另条。",
    "[EXTRA] 补可观测量g、链式中间式及完整Lie拉回输运等式，保留原向量场输运引理。联合C²与g为C¹标为充分资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:50:45.556556",
      "before_sha256": "3e36d5e97fa5dfe3188a73b17667f1563ec7a40f88715ab675613f4f8ba36377",
      "after_sha256": "923f6ea790a26ffa19be869425edb291dff471657a81c2e1c5d98f4b6094a2a2",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH01_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem flowFieldTransport :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ,
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ∀ t z,
    (fderiv ℝ (Φ t) z) (f z)=f (Φ t z) := by
  sorry

theorem flowFieldTransport_observable (n : ℕ)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hΦ : ContDiff ℝ 2 (Function.uncurry Φ))
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) (_hg : ContDiff ℝ 1 g) (t : ℝ)
    (z : MolecularDynamics.Chapter05Review.E n) :
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z)) ∧
    (fderiv ℝ g (Φ t z)) ((fderiv ℝ (Φ t) z) (f z))=
      (fderiv ℝ g (Φ t z)) (f (Φ t z)) ∧
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=
      MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.1-SolutionOperator",
  "kind": "definition",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "$\\widetilde g(z,t)=G_t\\widetilde g(z,0),\\qquad\\hbox{where }G_t=e^{t\\mathcal L_f}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实pullback解算子；exp是原书给定的算子记号，不声称未建设的无界指数级数收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.solutionOperator",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 主定义加入实际自治流资格，补G₀g=g接口；e^(tL)作为该实际流拉回的记号，不构造无界算子级数。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:50:45.556556",
      "before_sha256": "185e99f675e7dca9de970305dbf8012b1998ffca41b1f5446badb7475df76c47",
      "after_sha256": "7659de7cfc5e1356f9ddcacade507279b4cf527d1a5801f846180dee1eb1e150",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def solutionOperator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.pullback Φ g t

theorem solutionOperator_initial {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (hf : MolecularDynamics.Chapter05Review.flow f Φ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) :
    solutionOperator f Φ hf 0 g=g := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```
### 实际依赖 MD.Ch05.solutionOperator
```lean
def solutionOperator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (g : MolecularDynamics.Chapter05Review.E n → ℝ) :=
  MolecularDynamics.Chapter05Review.pullback Φ g t
```

## 原文JSON
```json
{
  "source_id": "MD-5.1-CoordinateLie",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "The projection onto the $i$th coordinate, denoted $\\partial_i$, is itself a scalar valued function of $z$ ($\\partial_i(z)=z_i$). Calculating directly we have $\\mathcal L_fz_i=f_i$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "保留实际EuclideanSpace的第i坐标投影；∂i是原书的坐标函数，不是对其它函数的偏导。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.coordinateLie",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:50:45.556556",
      "before_sha256": "656eea9e2ece562e044d87c8620544196a7ef02212d125ab6b763e27e9a4f2cd",
      "after_sha256": "056c6d4d877844a19f3ae084c715ab1b858c819cf1cc68502975d8565225c2de",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem coordinateLie : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) (i : Fin n),
  MolecularDynamics.Chapter05Review.lie f (fun x => x i) z=f z i := by
  intro n f z i
  change (fderiv ℝ (fun x : MolecularDynamics.Chapter05Review.E n => x i) z) (f z)=f z i
  change (fderiv ℝ (PiLp.proj 2 (fun _ : Fin n => ℝ) i : MolecularDynamics.Chapter05Review.E n →L[ℝ] ℝ) z) (f z)=f z i
  rw [ContinuousLinearMap.fderiv]
  rfl
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.1-LiePullbackCommutes",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.1",
  "printed_page": "181",
  "pdf_page": "202",
  "statement_latex": "$ (\\mathcal L_f\\widetilde g)(z)=f(z)\\cdot\\nabla_z[g(\\mathcal F_t(z))]\n=f(z)\\cdot[\\mathcal F_t'(z)^T\\nabla g(\\mathcal F_t(z))]\n=[\\mathcal F_t'(z)f(z)]\\cdot\\nabla g(\\mathcal F_t(z))\n=f(\\mathcal F_t(z))\\cdot\\nabla g(\\mathcal F_t(z))\n=(\\mathcal L_fg)(\\mathcal F_t(z))$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "承接PDF第201页：自治系统 ż=f(z)，实际流映射 F_t，g̃(z,t)=g(F_t(z))；本页在固定t时只对相变量z施加L_f。F_t′(z)是对初值z的Jacobian，T表示转置。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.liePullbackCommutes",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:50:45.556556",
      "before_sha256": "a0d854c626fd9be6fa55ad85bc6cb01899e0ddeac4e162384c37e48527c85af4",
      "after_sha256": "8ee80d45837e49c129aabe1d3b5e253faa596ad1a21be6224650e0ed77d6e41f",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH02_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT01/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem liePullbackCommutes : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (g : MolecularDynamics.Chapter05Review.E n → ℝ),
  MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    MolecularDynamics.Chapter05Review.lie f (MolecularDynamics.Chapter05Review.pullback Φ g t) z=MolecularDynamics.Chapter05Review.lie f g (Φ t z) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.pullback
```lean
def pullback {X : Type*} (Φ : ℝ → X → X) (g : X → ℝ) (t : ℝ) (z : X) := g (Φ t z)
```
