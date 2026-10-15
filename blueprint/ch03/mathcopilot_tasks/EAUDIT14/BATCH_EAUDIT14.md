# EAUDIT14：第3章§3.6.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.6.1-MechanicalReversal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "The vector fields involved are\n\\[f=\\begin{bmatrix}M^{-1}p\\\\-\\nabla U(q)\\end{bmatrix},\\qquad\\widetilde f=-Rf(Rz)=-\\begin{bmatrix}-M^{-1}p\\\\\\nabla U(q)\\end{bmatrix},\\]\nwhich are clearly equal. Therefore the molecular dynamics Hamiltonian system is time-reversible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF150右侧列向量外有整体负号，故−[−M⁻¹p;∇U(q)]=[M⁻¹p;−∇U(q)]=f；原书此处无所称符号错误。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.mechanicalReversalPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:19.432395",
      "before_sha256": "3db289f42762d8cd1dc7d398311919c25e7c7dc88d442166e1fd0bcb1f515454",
      "after_sha256": "52253bea0c023e491b8bb233894449f0569ffda0a93fdf70330cd5d042b9ff0e",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "issues"
      ],
      "annotation_corrections": {
        "issues": {
          "before": [
            {
              "code": "ERRATUM?",
              "detail": "p128右端列向量符号与−Rf(Rz)实际计算不符；原文不静默更改。"
            }
          ],
          "after": []
        }
      },
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem mechanicalReversalPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n),
      (-momentumReversal (mechanicalField m (fun q => -grad U q) (momentumReversal z)) =
        -(-invMass m z.2, grad U z.1)) ∧
      (-(-invMass m z.2, grad U z.1) = mechanicalField m (fun q => -grad U q) z) ∧
      mechanicalField m (fun q => -grad U q) (momentumReversal z) =
        -momentumReversal (mechanicalField m (fun q => -grad U q) z) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.mechanicalField
```lean
def mechanicalField {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) : Z n :=
  (invMass m z.2, F z.1)
```
### 实际依赖 MD.Ch03.momentumReversal
```lean
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.1-ReversedTrajectoryPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128–129",
  "pdf_page": "150–151",
  "statement_latex": "For the system $\\mathrm dz/\\mathrm dt=f(\\boldsymbol z)$, a coordinate transformation $\\boldsymbol z\\mapsto\\widetilde{\\boldsymbol z}=R\\boldsymbol z$ results in\n\\[\\frac{\\mathrm d\\widetilde{\\boldsymbol z}}{\\mathrm dt}=R\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=Rf(R^{-1}\\widetilde{\\boldsymbol z})=Rf(R\\widetilde{\\boldsymbol z}),\\]\nsince $R^{-1}=R$. A change of time $t\\mapsto\\tau=-t$ results in\n\\[\\frac{\\mathrm d\\boldsymbol z}{\\mathrm d\\tau}=\\frac{\\mathrm dt}{\\mathrm d\\tau}\\frac{\\mathrm d\\boldsymbol z}{\\mathrm dt}=-f(\\boldsymbol z).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "将p128字面−Rᵀ定义代入反向轨道得到的待审断言；不是p129实际R链式法则的正确版本。"
  ],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p128的Rᵀ字面反转与p129的R链式法则不能一般同时成立；具体二维反例见本地审计。"
    }
  ],
  "lean_decl": "MD.Ch03.reversedTrajectoryPrinted",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:19.432395",
      "before_sha256": "ff0d176eb8772aaee564316be6dcf63ce0735488b75bb792bdb4f5015de8b505",
      "after_sha256": "490ca4b2d1321c08da3c7c887530f09337b41fc2501f2700f85ed80d40ab9561",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem reversedTrajectoryPrinted :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (-R.mulVec (f (γ (-t)))) t := by
  sorry

theorem reversedTrajectoryPrinted_coordinateChange (n : ℕ)
    (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hR : R*R=1) (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ R.mulVec (γ s))
      (R.mulVec (f (R.mulVec (R.mulVec (γ t))))) t := by
  sorry

theorem reversedTrajectoryPrinted_timeChange (n : ℕ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ γ (-s)) (-f (γ (-t))) t := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.1-ReversedTrajectory",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "129",
  "pdf_page": "151",
  "statement_latex": "In other words, for a reversible vector field, the coordinate transformation $\\boldsymbol z\\mapsto R\\boldsymbol z$ is equivalent to the change of time $t\\mapsto-t$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "p129正确R链式法则版本；与字面Rᵀ断言分开；γ的真实时间导数明示。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.reversedTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。",
    "[EXTRA] 补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:19.432395",
      "before_sha256": "4baa833a06c089a2bacf665f848962ec813f5b7594c18aac6ab3e14036404d13",
      "after_sha256": "be864df1e6257f22751e8b1df33d565e136b7e646c602de308fd9b84e0d04338",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem reversedTrajectory :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ i j, R (Pi.single j 1) i = R (Pi.single i 1) j) → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.linearInvolution
```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

## 原文JSON
```json
{
  "source_id": "MD-3.6.1-MechanicalReversalCorrect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.6.1",
  "printed_page": "128",
  "pdf_page": "150",
  "statement_latex": "Therefore the molecular dynamics Hamiltonian system is time-reversible.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=−grad U代入任意位置力版本；泛化不改变机械坐标反转对象。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.mechanicalReversalCorrect",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.mechanicalReversal_proved"
  ],
  "extra_assumptions": [
    "独立正确机械R反转结论；原印展示式亦正确，原先错误标记撤销。",
    "[EXTRA] 原已证独立机械反转结论保留；更正旧注释：原书展示式正确，先前原书错误判断已撤销。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:25:19.432395",
      "before_sha256": "1fd870bfd85d1146f22590002dd9be2d9a07d86ace24e5872ae099613d4aa082",
      "after_sha256": "64b2ab4a38f58ccb28d4ba21a70da5bc47d9ccf163c32a97623f8849032de131",
      "changed_fields": [
        "extra_assumptions"
      ],
      "annotation_corrections": {
        "extra_assumptions": {
          "before": [
            "[EXTRA]独立正确机械R反转结论；原书错误展示等式仍由MechanicalReversalPrinted保留，不静默更改它。"
          ],
          "after": [
            "独立正确机械R反转结论；原印展示式亦正确，原先错误标记撤销。",
            "[EXTRA] 原已证独立机械反转结论保留；更正旧注释：原书展示式正确，先前原书错误判断已撤销。"
          ]
        }
      },
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem mechanicalReversalCorrect :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) z,
    mechanicalField m F (momentumReversal z)=-momentumReversal (mechanicalField m F z) := by
  exact MolecularDynamics.Chapter03Review.mechanicalReversal_proved
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.mechanicalField
```lean
def mechanicalField {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) : Z n :=
  (invMass m z.2, F z.1)
```
### 实际依赖 MD.Ch03.momentumReversal
```lean
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
```
