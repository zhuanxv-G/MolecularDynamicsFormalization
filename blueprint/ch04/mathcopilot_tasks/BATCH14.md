# BATCH14 第4章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-4.3.4-ProjectedEulerPrinted
```json
{
  "source_id": "MD-4.3.4-ProjectedEulerPrinted",
  "kind": "definition",
  "label": null,
  "section": "4.3.4",
  "printed_page": "159",
  "pdf_page": "181",
  "statement_latex": "On the other hand it is not too difficult to correct this defect by incorporating an additional projection onto the cotangent space:\n\\[q_{n+1}=q_n+hM^{-1}\\bar p_{n+1},\\tag{4.20}\\]\n\\[\\bar p_{n+1}=p_n-hF_n-hg'(q_n)^T\\lambda_n,\\tag{4.21}\\]\n\\[0=g(q_{n+1}),\\tag{4.22}\\]\n\\[p_{n+1}=\\bar p_{n+1}-g'(q_{n+1})^T\\mu_{n+1},\\tag{4.23}\\]\n\\[0=g'(q_{n+1})M^{-1}p_{n+1}.\\tag{4.24}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p159(4.21)力符号与p163及F=−∇U定义不一致。"
    }
  ],
  "lean_decl": "MD.Ch04.projectedEulerPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def projectedEulerPrinted {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • (-F z.1)-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### MD-4.3.4-ProjectedEulerRelation
```json
{
  "source_id": "MD-4.3.4-ProjectedEulerRelation",
  "kind": "definition",
  "label": null,
  "section": "4.3.4",
  "printed_page": "159",
  "pdf_page": "181",
  "statement_latex": "The demonstration that the method is symplectic can be seen as a consequence of the following lemma.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.projectedEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```

### MD-4.3.4-Lemma41
```json
{
  "source_id": "MD-4.3.4-Lemma41",
  "kind": "lemma",
  "label": "Lemma 4.1",
  "section": "4.3.4",
  "printed_page": "159–160",
  "pdf_page": "181–182",
  "statement_latex": "Lemma 4.1 Let $\\gamma:\\mathbb R^{N_c}\\to\\mathbb R$ be $C^2$. Let $q,p\\in\\mathbb R^{N_c}$ be constrained to the manifold defined by\n\\[\\gamma(q)=0,\\quad p\\cdot\\nabla\\gamma(q)=0,\\]\nand suppose $P,\\mu$ satisfy $P=p-\\mu\\nabla\\gamma(q)$. Then\n\\[\\sum_{j=1}^{N_c}dq_j\\wedge dP_j=\\sum_{j=1}^{N_c}dq_j\\wedge dp_j.\\]",
  "proof_latex": "Clearly the result follows provided\n\\[\\sum_{j=1}^{N_c}dq_j\\wedge d[\\mu\\nabla\\gamma(q)]_j=0,\\]\nwhere $[\\ldots]_j$ indicates the jth component of the term in brackets. We have\n\\[\\sum_jdq_j\\wedge d[\\mu\\nabla\\gamma(q)]_j=\\sum_jdq_j\\wedge\\left(\\frac{\\partial\\gamma}{\\partial q_j}d\\mu+\\mu\\sum_i\\gamma''_{ij}dq_j\\right).\\]\nThen we note\n\\[\\sum_jdq_j\\wedge\\frac{\\partial\\gamma}{\\partial q_j}d\\mu=\\sum_jdq_j\\frac{\\partial\\gamma}{\\partial q_j}\\wedge d\\mu=0,\\]\nsince $\\gamma(q)\\equiv0$ implies $d\\gamma(q)=\\sum_j\\frac{\\partial\\gamma}{\\partial q_j}dq_j\\equiv0$. Moreover\n\\[\\sum_jdq_j\\wedge\\sum_i\\gamma''_{ij}dq_j=0,\\]\nsince the Hessian matrix $\\gamma''$ is symmetric.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p160证明两处内和印刷dq_j；实际Hessian链式公式应dq_i。原proof_latex保持字面，正式库用真实Hessian对称性证明结论。"
    }
  ],
  "lean_decl": "MD.Ch04.lemma41",
  "reusable_proofs": [
    "MolecularDynamics.lemma_4_1"
  ],
  "extra_assumptions": [
    "真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem lemma41 {Nc : ℕ} {E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (γ : (Fin Nc → ℝ) → ℝ) (hγ : ContDiff ℝ 2 γ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hμ : DifferentiableAt ℝ μ x)
    (hchart : ∀ᶠ y in 𝓝 x, γ (q y) = 0 ∧
      p y ⬝ᵥ textbookConstraintGradient γ (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookConstrainedMomentum γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v)
```

### MD-4.3.4-MultiMomentumPullback
```json
{
  "source_id": "MD-4.3.4-MultiMomentumPullback",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.4",
  "printed_page": "160",
  "pdf_page": "182",
  "statement_latex": "Observe that $g'(q_{n+1})^T\\mu_{n+1}=\\sum_{k=1}^l\\mu_{n+1,k}\\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\\gamma$ replaced by each $g_k$ to demonstrate\n\\[\\sum_jdq_{n+1,j}\\wedge dp_{n+1,j}=\\sum_jdq_{n+1,j}\\wedge d\\bar p_{n+1,j}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.multiMomentumPullback",
  "reusable_proofs": [
    "MolecularDynamics.textbookMultiConstrainedMomentum_preserves_pullback"
  ],
  "extra_assumptions": [
    "有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem multiMomentumPullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q : E → Fin Nc → ℝ) (x : E) (hq : DifferentiableAt ℝ q x)
    (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hconstraint : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (p : E → Fin Nc → ℝ) (hp : DifferentiableAt ℝ p x) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x u)
      (fderiv ℝ (textbookCotangentChart q (textbookMultiConstrainedMomentum s γ μ q p)) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v)
```

### MD-4.3.4-ProjectedEulerPullback
```json
{
  "source_id": "MD-4.3.4-ProjectedEulerPullback",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.4",
  "printed_page": "160",
  "pdf_page": "182",
  "statement_latex": "Using similar argumentation based on the properties of the wedge product, we next show\n\\[\\sum_jdq_{n+1,j}\\wedge d\\bar p_{n+1,j}=\\sum_jdq_{n,j}\\wedge d\\bar p_{n+1,j};\\]\nand, finally, invoking Lemma 4.1 again,\n\\[\\sum_jdq_{n,j}\\wedge d\\bar p_{n+1,j}=\\sum_jdq_{n,j}\\wedge dp_{n,j}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.projectedEulerPullback",
  "reusable_proofs": [
    "MolecularDynamics.textbookProjectedEulerChart_preserves_pullback"
  ],
  "extra_assumptions": [
    "真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem projectedEulerPullback {Nc : ℕ} {E ι : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : DifferentiableAt ℝ q x) (hp : DifferentiableAt ℝ p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j ∈ s, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j ∈ s, DifferentiableAt ℝ (lam j) x)
    (hμ : ∀ j ∈ s, DifferentiableAt ℝ (μ j) x)
    (hold : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j ∈ s, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q (textbookProjectedEulerPreMomentum s γ lam U h a q p) y) = 0)
    (u v : E) :
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v)
```

### MD-4.3.4-CotangentMultiplier
```json
{
  "source_id": "MD-4.3.4-CotangentMultiplier",
  "kind": "definition",
  "label": null,
  "section": "4.3.4",
  "printed_page": "159",
  "pdf_page": "181",
  "statement_latex": "$0=g'(q_{n+1})M^{-1}p_{n+1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentMultiplier",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def cotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```

### MD-4.3.4-CotangentProjection
```json
{
  "source_id": "MD-4.3.4-CotangentProjection",
  "kind": "definition",
  "label": null,
  "section": "4.3.4",
  "printed_page": "159",
  "pdf_page": "181",
  "statement_latex": "$p_{n+1}=\\bar p_{n+1}-g'(q_{n+1})^T\\mu_{n+1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentProjection",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```

### MD-4.3.4-CotangentHidden
```json
{
  "source_id": "MD-4.3.4-CotangentHidden",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.4",
  "printed_page": "159",
  "pdf_page": "181",
  "statement_latex": "$0=g'(q_{n+1})M^{-1}p_{n+1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentHidden",
  "reusable_proofs": [
    "MolecularDynamics.textbookCotangentProjection_hiddenConstraint_of_mass_and_independence"
  ],
  "extra_assumptions": [
    "[EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem cotangentHidden {Nc Mc : ℕ}
    (m : Fin Nc → ℝ) (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i)
    (hind : LinearIndependent ℝ (fun j => textbookConstraintGradient (γ j) q)) :
    textbookConstraintJacobian γ q *ᵥ
      (textbookInverseMassMatrix m *ᵥ textbookCotangentProjection m γ q p) = 0
```

