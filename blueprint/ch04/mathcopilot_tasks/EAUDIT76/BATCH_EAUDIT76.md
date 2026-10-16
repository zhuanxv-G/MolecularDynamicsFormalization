# EAUDIT76：第4章§4.3.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.1-RestrictedForm",
  "kind": "definition",
  "label": null,
  "section": "4.3.1",
  "printed_page": "153",
  "pdf_page": "175",
  "statement_latex": "The simplifying concept that we exploit is that the symplectic $2$-form in the ambient space can be projected to the co-tangent bundle to define an associated symplectic form on the manifold.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实可微约束图的标准2-form拉回；抽象余切丛存在/非退化未由定义证明。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.restrictedForm",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留一般拉回定义，并补实际位置/隐藏约束余切流形切空间上限制标准二形式的非退化；正质量、C²、梯度独立为EXTRA正则资格。任意chart本身不声称辛。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:16.151063",
      "before_sha256": "c8dfa43d82a2a29148a302c1834c13b0a0ab91f2e8b912a726600ab40b28becc",
      "after_sha256": "466e853da56e0eac47a6acb9577221ec1fa87d8730dccf32a8311504e83b1a55",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def restrictedForm {n : ℕ} (chart : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (z u v : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)

theorem restrictedForm_nondegenerate (n l : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (z : MolecularDynamics.Chapter04Review.Z n)
    (_hz : ∀ j, g j z.1=0)
    (_hp : textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0)
    (_hind : LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1)) :
    let c := fun w : MolecularDynamics.Chapter04Review.Z n ↦
      ((fun j ↦ g j w.1), textbookConstraintJacobian g w.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m w.2)
    let T := (fderiv ℝ c z).ker
    ∀ u ∈ T, (∀ v ∈ T, MolecularDynamics.Chapter04Review.phaseForm u v=0) → u=0 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.phaseForm
```lean
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
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
### 实际依赖 MolecularDynamics.Chapter04Review.dot
```lean
def dot {n : ℕ} (u v : Q n) : ℝ := ∑ i, u i * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.phaseForm
```lean
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
```
### 实际依赖 MD.Ch04.restrictedForm
```lean
def restrictedForm {n : ℕ} (chart : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (z u v : MolecularDynamics.Chapter04Review.Z n) : ℝ :=
  MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ chart z) u) ((fderiv ℝ chart z) v)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.1-VariationalFormula",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.1",
  "printed_page": "154",
  "pdf_page": "176",
  "statement_latex": "Next, we interchange time derivatives and differentials, and use the chain rule to write\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\mathrm dq=M^{-1}\\mathrm dp,\\tag{4.11}\\]\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\mathrm dp=-U''(q)\\mathrm dq-\\sum_{k=1}^l[(\\mathrm d\\lambda_k)\\nabla g_k(q)+\\lambda_kg_k''\\mathrm dq],\\tag{4.12}\\]\n\\[0=g_j'(q)\\mathrm dq,\\quad j=1,\\ldots,l.\\tag{4.13}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.variational",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际Fréchet变分场：U/g C²、乘子ρ(z)可微；切向dg=0由tangentPhase/拉回消去条另保留，不把它漏掉或作无条件全空间结论。",
    "[EXTRA] 保留一般场导数公式，新增真实约束曲线的切向变分资格，将Gdq=0与两分量变分方程同一结论合取。新结论暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:16.151063",
      "before_sha256": "b714f90e885502901876a3db11678d64bb635a6e865dea07ed14fe072e27cb43",
      "after_sha256": "914a6c2c70f724aa8aed169b3943e03602828aba4e7536c872aaf01993fb43da",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem variational :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry

theorem variational_constraints :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (rho : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (z v : MolecularDynamics.Chapter04Review.Z n), ContDiff ℝ 2 U → (∀ j, ContDiff ℝ 2 (g j)) →
    DifferentiableAt ℝ rho z →
    ∀ (c : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ),
    c t=z → HasDerivAt c v t →
    (∀ᶠ s in 𝓝 t, ∀ j, g j (c s).1=0) →
    (∀ j, (fderiv ℝ (g j) z.1) v.1=0) ∧
    (fderiv ℝ (fun x : MolecularDynamics.Chapter04Review.Z n =>
      (MolecularDynamics.Chapter04Review.invMass m x.2,-MolecularDynamics.Chapter04Review.grad U x.1-(textbookConstraintJacobian g x.1)ᵀ *ᵥ rho x)) z) v =
      (MolecularDynamics.Chapter04Review.invMass m v.2,-(fderiv ℝ (MolecularDynamics.Chapter04Review.grad U) z.1) v.1-
        ∑ j, (((fderiv ℝ rho z) v) j • MolecularDynamics.Chapter04Review.grad (g j) z.1+
          rho z j • (fderiv ℝ (MolecularDynamics.Chapter04Review.grad (g j)) z.1) v.1)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
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
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.1-HessianPullbackCancel",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.1",
  "printed_page": "155",
  "pdf_page": "177",
  "statement_latex": "This follows from the antisymmetry of the wedge product $(\\mathrm dx\\wedge\\mathrm dy=-\\mathrm dy\\wedge\\mathrm dx)$, and the fact that the Hessian matrix of $U$ is symmetric. Next, note that\n\\[\\sum_{i=1}^{N_c}\\sum_{k=1}^{l}\\mathrm dq_i\\wedge\\lambda_k\\sum_{j=1}^{N_c}(g_k^{\\prime\\prime})_{ij}\\mathrm dq_j=\\sum_{k=1}^{l}\\lambda_k\\sum_{i=1}^{N_c}\\mathrm dq_i\\wedge\\sum_{j=1}^{N_c}(g_k^{\\prime\\prime})_{ij}\\mathrm dq_j=0,\\]\nby the same reasoning, since each of $g_k^{\\prime\\prime}$ is a symmetric matrix. Finally\n\\[\\sum_{i=1}^{N_c}\\sum_{k=1}^{l}[\\mathrm dq_i\\wedge(\\mathrm d\\lambda_k)g_{ki}^{\\prime}]=\\sum_{k=1}^{l}\\left(\\sum_{i=1}^{N_c}g_{ki}^{\\prime}\\mathrm dq_i\\right)\\wedge\\mathrm d\\lambda_k=\\sum_{k=1}^{l}\\mathrm dg_k\\wedge\\mathrm d\\lambda_k=0,\\]\nsince we know that $\\mathrm dg_k=0$ from (4.13). Therefore\n\\[\\frac{\\mathrm d}{\\mathrm dt}\\sum_{j=1}^{N_c}\\mathrm dq_j\\wedge\\mathrm dp_j=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "U及各g_k的双撇表示Hessian；质量矩阵常对角，m_i为第i个对角元。完整时间导数还使用本页上半部 Σ_i m_i^{-1} dp_i∧dp_i=0 和Leibniz规则。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.hessianPullbackCancel",
  "reusable_proofs": [
    "MolecularDynamics.textbookConstrainedAcceleration_pullback_zero"
  ],
  "extra_assumptions": [
    "完整实际C²势/约束、可微乘子和切向位置图；前文各消去项在已证正式库有限和展开中保留。",
    "[EXTRA] 保留动量项消去已有证明，补实际时间流/线性变分及合法约束切向量上的完整二形式导数零；位置项由常对角逆质量对称抵消，未把二形式守恒作前提。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT09_LOCAL_REPAIR",
      "timestamp": "2026-10-15T13:03:16.151063",
      "before_sha256": "7bf2230f1ff34a04a9e4c4a9a4c34f8cb287ec26ec547a14b56256b88efb592d",
      "after_sha256": "d849e243847e799656d8abd85f97e46927d65f34a9006e423018c5832435cac2",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH10_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT09/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hessianPullbackCancel {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (ρ : Fin Mc → E → ℝ) (q : E → Fin Nc → ℝ) (x u v : E)
    (hU : ContDiff ℝ 2 U) (hγ : ∀ j, ContDiff ℝ 2 (γ j))
    (hq : DifferentiableAt ℝ q x) (hρ : ∀ j, DifferentiableAt ℝ (ρ j) x)
    (hconstraint : ∀ j, ∀ᶠ y in 𝓝 x, γ j (q y) = 0) :
    ∑ i : Fin Nc,
      ((fderiv ℝ q x) u i * (fderiv ℝ
        (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) v i -
        (fderiv ℝ (textbookMultiConstrainedMomentum Finset.univ γ ρ q
          (fun y => textbookPotentialForce U (q y))) x) u i * (fderiv ℝ q x) v i) = 0 := by
  apply MolecularDynamics.textbookConstrainedAcceleration_pullback_zero <;> assumption

theorem hessianPullbackCancel_time (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (ρ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j)) (_hρ : ContDiff ℝ 1 ρ)
    (γ u v : ℝ → MolecularDynamics.Chapter04Review.Z n) (t : ℝ)
    (_hγ : HasDerivAt γ
      (MolecularDynamics.Chapter04Review.invMass m (γ t).2,
       -MolecularDynamics.Chapter04Review.grad U (γ t).1-(textbookConstraintJacobian g (γ t).1)ᵀ *ᵥ ρ (γ t)) t)
    (_hu : HasDerivAt u ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (u t)) t)
    (_hv : HasDerivAt v ((fderiv ℝ (fun z : MolecularDynamics.Chapter04Review.Z n ↦
      (MolecularDynamics.Chapter04Review.invMass m z.2,
       -MolecularDynamics.Chapter04Review.grad U z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ ρ z)) (γ t)) (v t)) t)
    (_htu : ∀ j, (fderiv ℝ (g j) (γ t).1) (u t).1=0)
    (_htv : ∀ j, (fderiv ℝ (g j) (γ t).1) (v t).1=0) :
    HasDerivAt (fun s ↦ MolecularDynamics.Chapter04Review.phaseForm (u s) (v s)) 0 t := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.phaseForm
```lean
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
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
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.phaseForm
```lean
def phaseForm {n : ℕ} (u v : Z n) : ℝ := dot u.1 v.2 - dot v.1 u.2
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookConstraintJacobian
```lean
noncomputable def textbookConstraintJacobian {Nc Mc : ℕ}
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Matrix (Fin Mc) (Fin Nc) ℝ :=
  fun j i => textbookConstraintGradient (γ j) q i
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
