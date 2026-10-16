# EAUDIT57：第4章§4.3.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.4-Lemma41",
  "kind": "lemma",
  "label": "Lemma 4.1",
  "section": "4.3.4",
  "printed_page": "159–160",
  "pdf_page": "181–182",
  "statement_latex": "Lemma 4.1 Let $\\gamma:\\mathbb R^{N_c}\\to\\mathbb R$ be $C^2$. Let $q,p\\in\\mathbb R^{N_c}$ be constrained to the manifold defined by\n\\[\\gamma(q)=0,\\quad p\\cdot\\nabla\\gamma(q)=0,\\]\nand suppose $P,\\mu$ satisfy $P=p-\\mu\\nabla\\gamma(q)$. Then\n\\[\\sum_{j=1}^{N_c}dq_j\\wedge dP_j=\\sum_{j=1}^{N_c}dq_j\\wedge dp_j.\\]",
  "proof_latex": "Clearly the result follows provided\n\\[\\sum_{j=1}^{N_c}dq_j\\wedge d[\\mu\\nabla\\gamma(q)]_j=0,\\]\nwhere $[\\ldots]_j$ indicates the jth component of the term in brackets. We have\n\\[\\sum_jdq_j\\wedge d[\\mu\\nabla\\gamma(q)]_j=\\sum_jdq_j\\wedge\\left(\\frac{\\partial\\gamma}{\\partial q_j}d\\mu+\\mu\\sum_i\\gamma''_{ij}dq_j\\right).\\]\nThen we note\n\\[\\sum_jdq_j\\wedge\\frac{\\partial\\gamma}{\\partial q_j}d\\mu=\\sum_j\\frac{\\partial\\gamma}{\\partial q_j}dq_j\\wedge d\\mu=0,\\]\nsince $\\gamma(q)\\equiv0$ implies $d\\gamma(q)=\\sum_j\\frac{\\partial\\gamma}{\\partial q_j}dq_j\\equiv0$. Moreover\n\\[\\sum_jdq_j\\wedge\\sum_i\\gamma''_{ij}dq_j=0,\\]\nsince the Hessian matrix $\\gamma''$ is symmetric.",
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
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219265",
      "before_sha256": "08d6c5e8b99731f2ae2b75bbbae8e16b7ec8ba4b8447ea4d44da1a1455c119c8",
      "after_sha256": "c0388b3e2e6891a2c1a466aefe379e74b59af70e5af11e44cf05547d250d02d5",
      "changed_fields": [
        "proof_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
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
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.lemma_4_1 <;> assumption
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookConstrainedMomentum
```lean
noncomputable def textbookConstrainedMomentum {Nc : ℕ} {E : Type*}
    (γ : (Fin Nc → ℝ) → ℝ) (μ : E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  p x - μ x • textbookConstraintGradient γ (q x)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookCotangentChart
```lean
def textbookCotangentChart {Nc : ℕ} {E : Type*}
    (q p : E → Fin Nc → ℝ) (x : E) : SymplecticCoordinates Nc :=
  Sum.elim (q x) (p x)
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookSymplecticForm
```lean
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

## 原文JSON
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
    "真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。",
    "[EXTRA] 原总拉回等式已有证明保留；同条补Q/Pbar与q/Pbar、q/Pbar与q/p的两条实际微分二形式中间等式，逐句覆盖原证明链。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219345",
      "before_sha256": "1feac18c2b75cb2b423728e0e6e697a3bf6ce8b397d0d5c49c745523ce958c55",
      "after_sha256": "4ba21c65e8648c96727bd8faf7a02ba9be335649e464a405aefb9ceb2e33f7fb",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
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
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookProjectedEulerChart_preserves_pullback <;> assumption

theorem projectedEulerPullback_intermediate {Nc : ℕ} {E ι : Type*}
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
    let Pbar := textbookProjectedEulerPreMomentum s γ lam U h a q p
    let Q := textbookProjectedEulerPosition m h q Pbar
    (textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart Q Pbar) x u) (fderiv ℝ (textbookCotangentChart Q Pbar) x v) = textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q Pbar) x u) (fderiv ℝ (textbookCotangentChart q Pbar) x v)) ∧
    (textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q Pbar) x u) (fderiv ℝ (textbookCotangentChart q Pbar) x v) = textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u) (fderiv ℝ (textbookCotangentChart q p) x v)) ∧
    textbookSymplecticForm Nc (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x u)
      (fderiv ℝ (textbookProjectedEulerChart s γ lam μ m U h a q p) x v) =
      textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
        (fderiv ℝ (textbookCotangentChart q p) x v) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookCotangentChart
```lean
def textbookCotangentChart {Nc : ℕ} {E : Type*}
    (q p : E → Fin Nc → ℝ) (x : E) : SymplecticCoordinates Nc :=
  Sum.elim (q x) (p x)
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookMultiConstrainedMomentum
```lean
noncomputable def textbookMultiConstrainedMomentum {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  p x - ∑ j ∈ s, μ j x • textbookConstraintGradient (γ j) (q x)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookProjectedEulerChart
```lean
noncomputable def textbookProjectedEulerChart {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam μ : ι → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) : E → SymplecticCoordinates Nc :=
  let P := textbookProjectedEulerPreMomentum s γ lam U h a q p
  let Q := textbookProjectedEulerPosition m h q P
  textbookCotangentChart Q (textbookMultiConstrainedMomentum s γ μ Q P)
```
### 实际依赖 MolecularDynamics.textbookProjectedEulerPosition
```lean
noncomputable def textbookProjectedEulerPosition {Nc : ℕ} {E : Type*}
    (m : Fin Nc → ℝ) (h : ℝ) (q P : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  fun i => q x i + (h * (m i)⁻¹) * P x i
```
### 实际依赖 MolecularDynamics.textbookProjectedEulerPreMomentum
```lean
noncomputable def textbookProjectedEulerPreMomentum {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam : ι → E → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ) (q p : E → Fin Nc → ℝ) : E → Fin Nc → ℝ :=
  textbookMultiConstrainedMomentum s γ (fun j y => h * lam j y) q
    (fun y => p y + a • textbookPotentialForce U (q y))
```
### 实际依赖 MolecularDynamics.textbookSymplecticForm
```lean
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

## 原文JSON
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
    "[EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。",
    "[EXTRA] Gram构造限定det≠0，并补Aμ=GDp及真实投影隐藏约束；这是(4.23–24)推导的受限构造，不用值函数替代方程。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219406",
      "before_sha256": "4598cb45421f82b21ed76b21c8850d8d9aa29377b1a56e9e8b32bd1bc366b197",
      "after_sha256": "ca0548eb16af377b786afb2c56e4ec25c84a70707f79b984f218ed722ae09135",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def cotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))

theorem cotangentMultiplier_hidden {n l : ℕ} (m : Fin n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : MolecularDynamics.Chapter04Review.Q n)
    (_hdet : (textbookConstraintGram m g q).det ≠ 0) :
    let μ := textbookCotangentMultiplier m g q p
    (textbookConstraintGram m g q) *ᵥ μ=
      textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ p) ∧
    textbookConstraintJacobian g q *ᵥ (textbookInverseMassMatrix m *ᵥ
      (p-(textbookConstraintJacobian g q)ᵀ *ᵥ μ))=0 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.cotangentMultiplier
```lean
noncomputable def cotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookCotangentMultiplier
```lean
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
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
    "[EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。",
    "[EXTRA] 主声明忠实为任意μ的印刷投影等式；Gram专项实现独立命名且加可逆资格，隐藏约束由CotangentMultiplier补全，不暗中求解任意原式乘子。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219458",
      "before_sha256": "29c1da9b29c67ff036779c1533da894a4845c72cae546fcc47261f0c98f57416",
      "after_sha256": "0b444be663b3f94bcdd434ae781dfb13969e90851082b01f8d0625da92b9904a",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p P : Fin Nc → ℝ) (μ : Fin Mc → ℝ) : Prop :=
  P=p-(textbookConstraintJacobian γ q)ᵀ *ᵥ μ

noncomputable def cotangentProjection_gram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```
### 实际依赖 MD.Ch04.cotangentProjection
```lean
def cotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p P : Fin Nc → ℝ) (μ : Fin Mc → ℝ) : Prop :=
  P=p-(textbookConstraintJacobian γ q)ᵀ *ᵥ μ
```
### 实际依赖 MD.Ch04.cotangentProjection_gram
```lean
noncomputable def cotangentProjection_gram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ)
    (_hdet : (textbookConstraintGram m γ q).det ≠ 0) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookCotangentMultiplier
```lean
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.4-CotangentRegularity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.4",
  "printed_page": "160",
  "pdf_page": "182",
  "statement_latex": "Thus we may apply Lemma 4.1 with $\\gamma$ replaced by each $g_k$ to demonstrate $\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge dp_{n+1,j}=\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge d\\bar p_{n+1,j}$.",
  "proof_latex": null,
  "proof_note": "原书以有限梯度和及 Lemma 4.1 给出本等式的简短论证；未另列独立定理或完整重复证明。",
  "proof_discussion_latex": "Observe that $g\\prime(q_{n+1})^T\\mu_{n+1}=\\sum_{k=1}^{l}\\mu_{n+1,k}\\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\\gamma$ replaced by each $g_k$.",
  "context_notation": [
    "$q_{n+1}\\in\\mathbb R^{N_c}$ satisfies $g(q_{n+1})=0$; $g=(g_1,\\ldots,g_l)$.",
    "$\\bar p_{n+1}$ is the pre-projection momentum; $p_{n+1}=\\bar p_{n+1}-g\\prime(q_{n+1})^T\\mu_{n+1}$ (4.23).",
    "$g\\prime(q_{n+1})^T\\mu_{n+1}=\\sum_{k=1}^{l}\\mu_{n+1,k}\\nabla g_k(q_{n+1})$; Lemma 4.1 assumes $\\gamma\\in C^2$.",
    "The displayed two-forms are restricted to constrained parameter variations, with $d g_k(q_{n+1})=0$; $j=1,\\ldots,N_c$."
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentRegularity",
  "reusable_proofs": [
    "MolecularDynamics.contDiffAt_textbookCotangentProjection"
  ],
  "extra_assumptions": [
    "[EXTRA]实际逆Gram投影的一阶正则性资格：C²约束、C¹参数图、Gram非奇异；非另印定理。",
    "[EXTRA] 本条显式仅为专项投影C¹正则性辅助；所引完整限制二形式等式已由MD-4.3.4-CotangentPullback承担并含真实邻域位置约束，不重复冒充同一结论。"
  ],
  "statement_scope": "Gram专项投影C¹正则性辅助；原句位置约束下完整二形式等式由MD-4.3.4-CotangentPullback承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219515",
      "before_sha256": "8fe786879ea62646cfb3f86de8605aa7afa02ba617a5e1b90a0789b6fa2dd5ca",
      "after_sha256": "a2c36aabbdc287925e5a7f11c7678a68750a43f556b4c74a1b0c928529863d1c",
      "changed_fields": [
        "statement_latex",
        "proof_note",
        "proof_discussion_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem cotangentRegularity {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0) :
    ContDiffAt ℝ 1 (fun y => textbookCotangentProjection m γ (q y) (p y)) x := by
  apply MolecularDynamics.contDiffAt_textbookCotangentProjection <;> assumption
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookCotangentMultiplier
```lean
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```
### 实际依赖 MolecularDynamics.textbookCotangentProjection
```lean
noncomputable def textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.4-CotangentPullback",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.4",
  "printed_page": "160",
  "pdf_page": "182",
  "statement_latex": "Thus we may apply Lemma 4.1 with $\\gamma$ replaced by each $g_k$ to demonstrate $\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge dp_{n+1,j}=\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge d\\bar p_{n+1,j}$.",
  "proof_latex": null,
  "proof_note": "原书以有限梯度和及 Lemma 4.1 给出本等式的简短论证；未另列独立定理或完整重复证明。",
  "proof_discussion_latex": "Observe that $g\\prime(q_{n+1})^T\\mu_{n+1}=\\sum_{k=1}^{l}\\mu_{n+1,k}\\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\\gamma$ replaced by each $g_k$.",
  "context_notation": [
    "$q_{n+1}\\in\\mathbb R^{N_c}$ satisfies $g(q_{n+1})=0$; $g=(g_1,\\ldots,g_l)$.",
    "$\\bar p_{n+1}$ is the pre-projection momentum; $p_{n+1}=\\bar p_{n+1}-g\\prime(q_{n+1})^T\\mu_{n+1}$ (4.23).",
    "$g\\prime(q_{n+1})^T\\mu_{n+1}=\\sum_{k=1}^{l}\\mu_{n+1,k}\\nabla g_k(q_{n+1})$; Lemma 4.1 assumes $\\gamma\\in C^2$.",
    "The displayed two-forms are restricted to constrained parameter variations, with $d g_k(q_{n+1})=0$; $j=1,\\ldots,N_c$."
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.cotangentPullback",
  "reusable_proofs": [
    "MolecularDynamics.textbookCotangentProjection_preserves_pullback"
  ],
  "extra_assumptions": [
    "实际逆Gram投影、C²约束、C¹参数图、Gram非奇异及邻域位置约束；可微乘子由正式库导出，不作新假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219580",
      "before_sha256": "f10756f3eb0cf068e6363ffc36409eb840b00ac81334d445dfb32896bc917299",
      "after_sha256": "2ced0b94a75f3e41d330551e2f3cc7350163614941d7596b120917effc66b4e3",
      "changed_fields": [
        "statement_latex",
        "proof_note",
        "proof_discussion_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem cotangentPullback {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : E → Fin Nc → ℝ) (x : E)
    (hγ : ∀ j, ContDiff ℝ 2 (γ j)) (hq : ContDiffAt ℝ 1 q x)
    (hp : ContDiffAt ℝ 1 p x) (hdet : (textbookConstraintGram m γ (q x)).det ≠ 0)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) (u v : E) :
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x u)
      (fderiv ℝ (textbookCotangentChart q
        (fun y => textbookCotangentProjection m γ (q y) (p y))) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookCotangentProjection_preserves_pullback <;> assumption
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookCotangentChart
```lean
def textbookCotangentChart {Nc : ℕ} {E : Type*}
    (q p : E → Fin Nc → ℝ) (x : E) : SymplecticCoordinates Nc :=
  Sum.elim (q x) (p x)
```
### 实际依赖 MolecularDynamics.textbookCotangentMultiplier
```lean
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```
### 实际依赖 MolecularDynamics.textbookCotangentProjection
```lean
noncomputable def textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookSymplecticForm
```lean
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.4-GramProjectedEuler",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.4",
  "printed_page": "160",
  "pdf_page": "182",
  "statement_latex": "The demonstration that the method is symplectic can be seen as a consequence of the following lemma.",
  "proof_latex": null,
  "proof_note": "所引句位于印刷第159页；方法的三段二形式论证在印刷第160页，未另列独立完整定理证明。",
  "proof_discussion_latex": "On printed p.160 (PDF p.182), Lemma 4.1 first gives $\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge dp_{n+1,j}=\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge d\\bar p_{n+1,j}$. The wedge-product argument next gives $\\sum_{j=1}^{N_c}dq_{n+1,j}\\wedge d\\bar p_{n+1,j}=\\sum_{j=1}^{N_c}dq_{n,j}\\wedge d\\bar p_{n+1,j}$; invoking Lemma 4.1 again gives $\\sum_{j=1}^{N_c}dq_{n,j}\\wedge d\\bar p_{n+1,j}=\\sum_{j=1}^{N_c}dq_{n,j}\\wedge dp_{n,j}$.",
  "context_notation": [
    "The method refers to (4.20)–(4.24): $q_{n+1}=q_n+hM^{-1}\\bar p_{n+1}$; $\\bar p_{n+1}=p_n-hF_n-hg\\prime(q_n)^T\\lambda_n$; $g(q_{n+1})=0$; $p_{n+1}=\\bar p_{n+1}-g\\prime(q_{n+1})^T\\mu_{n+1}$; $g\\prime(q_{n+1})M^{-1}p_{n+1}=0$.",
    "$M$ is the diagonal mass matrix; $F_n=F(q_n)$; $\\lambda_n,\\mu_{n+1}$ are constraint multipliers. The printed force sign in (4.21) is retained.",
    "Symplecticity means preservation of $\\sum_{j=1}^{N_c}dq_j\\wedge dp_j$ on the constrained phase space."
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.gramProjectedEuler",
  "reusable_proofs": [
    "MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback"
  ],
  "extra_assumptions": [
    "[EXTRA]将(4.20–24)实际Gram末投影同时证明隐藏约束与完整拉回形式不变；给定C¹位置投影分支，非解的存在理论。",
    "[EXTRA] 教材包装全部固定a=−h，对应原印−hF的特殊参数；任意a几何推广作为独立辅助保留，原已证apply仅参数实例化。未把a=h物理修订暗作原印；不声称隐式分支存在或全局微分同胚。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:55:41.219640",
      "before_sha256": "26981427740f1bc4f359945b2528d6886324d278f45d00a9a4aa6de9448b7605",
      "after_sha256": "13d99b6bd2e5cb1a67bfc1b2e6083720f0be7ecf4417d2dd886b34ad17818564",
      "changed_fields": [
        "proof_note",
        "proof_discussion_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem gramProjectedEuler {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h (-h) q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h (-h) q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h (-h) q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption

theorem gramProjectedEuler_general {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) (x : E)
    (hq : ContDiffAt ℝ 1 q x) (hp : ContDiffAt ℝ 1 p x)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hlam : ∀ j, ContDiffAt ℝ 1 (lam j) x)
    (hold : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0)
    (hnew : ∀ j, ∀ᶠ y in 𝓝 x, γ j
      (textbookProjectedEulerPosition m h q
        (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) y) = 0)
    (hdet : (textbookConstraintGram m γ (textbookProjectedEulerPosition m h q
      (textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p) x)).det ≠ 0)
    (u v : E) :
    (∀ j, (fderiv ℝ (γ j) (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inl i)))
        (textbookInverseMassMatrix m *ᵥ
          (fun i => textbookGramProjectedEulerChart γ lam m U h a q p x (Sum.inr i))) = 0) ∧
    textbookSymplecticForm Nc
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x u)
      (fderiv ℝ (textbookGramProjectedEulerChart γ lam m U h a q p) x v) =
    textbookSymplecticForm Nc (fderiv ℝ (textbookCotangentChart q p) x u)
      (fderiv ℝ (textbookCotangentChart q p) x v) := by
  apply MolecularDynamics.textbookGramProjectedEulerChart_hiddenConstraint_and_pullback <;> assumption
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintGram
```lean
noncomputable def textbookConstraintGram {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Mc) ℝ :=
  textbookConstraintJacobian γ q * textbookInverseMassMatrix m *
    (textbookConstraintJacobian γ q)ᵀ
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```
### 实际依赖 MolecularDynamics.textbookCotangentChart
```lean
def textbookCotangentChart {Nc : ℕ} {E : Type*}
    (q p : E → Fin Nc → ℝ) (x : E) : SymplecticCoordinates Nc :=
  Sum.elim (q x) (p x)
```
### 实际依赖 MolecularDynamics.textbookCotangentMultiplier
```lean
noncomputable def textbookCotangentMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ p))
```
### 实际依赖 MolecularDynamics.textbookCotangentProjection
```lean
noncomputable def textbookCotangentProjection {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Nc → ℝ :=
  p - (textbookConstraintJacobian γ q)ᵀ *ᵥ textbookCotangentMultiplier m γ q p
```
### 实际依赖 MolecularDynamics.textbookGramProjectedEulerChart
```lean
noncomputable def textbookGramProjectedEulerChart {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (lam : Fin Mc → E → ℝ)
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ)
    (q p : E → Fin Nc → ℝ) : E → SymplecticCoordinates Nc :=
  let P := textbookProjectedEulerPreMomentum Finset.univ γ lam U h a q p
  let Q := textbookProjectedEulerPosition m h q P
  textbookCotangentChart Q (fun y => textbookCotangentProjection m γ (Q y) (P y))
```
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookMultiConstrainedMomentum
```lean
noncomputable def textbookMultiConstrainedMomentum {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (μ : ι → E → ℝ)
    (q p : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  p x - ∑ j ∈ s, μ j x • textbookConstraintGradient (γ j) (q x)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookProjectedEulerPosition
```lean
noncomputable def textbookProjectedEulerPosition {Nc : ℕ} {E : Type*}
    (m : Fin Nc → ℝ) (h : ℝ) (q P : E → Fin Nc → ℝ) (x : E) : Fin Nc → ℝ :=
  fun i => q x i + (h * (m i)⁻¹) * P x i
```
### 实际依赖 MolecularDynamics.textbookProjectedEulerPreMomentum
```lean
noncomputable def textbookProjectedEulerPreMomentum {Nc : ℕ} {E ι : Type*}
    (s : Finset ι) (γ : ι → (Fin Nc → ℝ) → ℝ) (lam : ι → E → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (h a : ℝ) (q p : E → Fin Nc → ℝ) : E → Fin Nc → ℝ :=
  textbookMultiConstrainedMomentum s γ (fun j y => h * lam j y) q
    (fun y => p y + a • textbookPotentialForce U (q y))
```
### 实际依赖 MolecularDynamics.textbookSymplecticForm
```lean
noncomputable def textbookSymplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```
