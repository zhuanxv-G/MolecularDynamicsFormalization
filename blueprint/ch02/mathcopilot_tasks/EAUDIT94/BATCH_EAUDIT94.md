# EAUDIT94：第2章§2.5.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.5.1-RK4",
  "kind": "definition",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "An example of a popular 4th order explicit method is the choice of matrix $A$ with coefficients $a_{ij}\\equiv 0$ except $a_{21}=1/2$, $a_{32}=1/2$ and $a_{43}=1$, and $b_1=1/6$, $b_2=1/3$, $b_3=1/3$, $b_4=1/6$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "展开实际四阶段给出同一A/b权重；4阶陈述单列。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_rk4",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:26:18.510671",
      "before_sha256": "320c7304b6dfeb67935ad056f91684e42cdc98783e02f259f2ae5f90d7a97f79",
      "after_sha256": "e0551ea2e00095e9f840a6ba2123f19f6e70b605c76197850f1c5c48e943b55c",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.bp_rk4
```lean
def bp_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)
```

## 原文JSON
```json
{
  "source_id": "MD-2.5.1-ExplicitRK",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "89",
  "pdf_page": "111",
  "statement_latex": "This method is not symplectic, and it is in fact impossible to find symplectic explicit methods within the Runge-Kutta family.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.explicitRK",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。",
    "[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:26:18.510671",
      "before_sha256": "8e4eb7844929520aadd22ab929aca8e27b9732dfb6eb60fa87ee282f6f2bb189",
      "after_sha256": "4c9d664f9d55de8dc1bb69c240569bf32f58f8dfea6b74c52d4e49c5660af714",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EAUDIT50_LOCAL_REPAIR",
      "timestamp": "2026-10-16T09:29:25.859638",
      "before_sha256": "4c9d664f9d55de8dc1bb69c240569bf32f58f8dfea6b74c52d4e49c5660af714",
      "after_sha256": "3f408ae20576b59c8d364a645ae06dc510d0c98729ce2c6f157f841b5a48676f",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT50/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem explicitRK :
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ∞ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.IsTextbookSymplecticMap
```lean
def IsTextbookSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  ContDiff ℝ 1 Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
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
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.5.1-MidpointProperties",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "which has order 2.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "来自GLRK辛RK上下文，保留二阶与辛性两个结论；实际中点关系见同页。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.midpointProperties",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。",
    "[EXTRA] 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:26:18.510671",
      "before_sha256": "3c3cb51b16331c9836bda40975342d6769835498180eb90d447624154462f38e",
      "after_sha256": "b70f2001ede3089f8b016f8a05e4fa4bfdf5d37107d4794dc74d3959da21fbac",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem midpointProperties
    (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (U : Set (SymplecticCoordinates n)) (δ : ℝ) (_hδ : 0 < δ)
    (_hU : IsOpen U) (_hH : ContDiff ℝ 4 H)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (textbookHamiltonianVectorField H (F t z)) t) :
    (∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    (∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3) := by
  sorry

theorem midpointProperties_generalODE (n : ℕ) (f : Q n → Q n)
    (G F : ℝ → Q n → Q n) (U : Set (Q n)) (δ : ℝ)
    (_hδ : 0 < δ) (_hU : IsOpen U) (_hf : ContDiff ℝ 3 f)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U, G h z = z+h • f ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (f (F t z)) t) :
    ∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3 := by
  sorry
```
### 实际依赖 MolecularDynamics.IsTextbookSymplectic
```lean
def IsTextbookSymplectic {Nc : ℕ} (A : SymplecticCoordinateMatrix Nc) : Prop :=
  Aᵀ * textbookJ Nc * A = textbookJ Nc
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
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
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
### 实际依赖 MolecularDynamics.textbookJacobian
```lean
noncomputable def textbookJacobian {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc :=
  LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.5.1-GaussTwoOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.5.1",
  "printed_page": "90",
  "pdf_page": "112",
  "statement_latex": "The 4th order method ($s=2$) has coefficients",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "同页GaussTwoData保存全部A、b；此条保存确切2阶段方法全局4阶结论而非仅系数。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.gaussTwoOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。",
    "[EXTRA] 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:26:18.510671",
      "before_sha256": "cd308356f8fa4040a5c4d0d9d3a15b2984350ac9c325098d47b7a53e7e1146f6",
      "after_sha256": "c44f1f8834d52664410e77c8cf102028fd7c55feaa8a7984258c56871c5cb9ad",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem gaussTwoOrder (n : ℕ) (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) (τ : ℝ) (_htrajectory : compactTrajectory f γ τ)
    (U : Set (Q n)) (δ : ℝ) (_hδ : 0 < δ) (_hU : IsOpen U)
    (_hcover : γ '' Icc 0 τ ⊆ U)
    (_hG : ContDiffOn ℝ 6 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (stages : ℝ → Q n → Fin 2 → Q n)
    (_hregular : ∀ i, ContDiffOn ℝ 6 (fun x : ℝ × Q n ↦ stages x.1 x.2 i)
      (Ioo (-δ) δ ×ˢ U))
    (_hstagezero : ∀ z ∈ U, ∀ i, stages 0 z i = f z)
    (_hstage : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) (stages h z)) :
    globalOrder G γ τ 4 ∧
    (∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀, ∀ k ≤ ν,
      oneStepIterate G (τ/ν) (γ 0) k ∈ U) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.compactTrajectory
```lean
def compactTrajectory {n : ℕ} (f : Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  0 < τ ∧ ContDiff ℝ 6 f ∧ solution f γ 0 τ ∧ ContinuousOn γ (Icc 0 τ)
```
### 实际依赖 MolecularDynamics.Chapter02Review.gaussTwoCoefficients
```lean
def gaussTwoCoefficients : Matrix (Fin 2) (Fin 2) ℝ :=
  !![(1/4 : ℝ), 1/4-Real.sqrt 3/6; 1/4+Real.sqrt 3/6, 1/4]
```
### 实际依赖 MolecularDynamics.Chapter02Review.globalOrder
```lean
def globalOrder {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ C * (τ / ν) ^ r
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```
### 实际依赖 MolecularDynamics.oneStepMaxError
```lean
noncomputable def oneStepMaxError (G : ℝ → E → E) (h : ℝ) (γ : ℝ → E) (ν : ℕ) : ℝ :=
  (Finset.range (ν + 1)).sup' Finset.nonempty_range_add_one
    (fun n => ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖)
```
### 实际依赖 MolecularDynamics.Chapter02Review.rungeKuttaRelation
```lean
def rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
```
