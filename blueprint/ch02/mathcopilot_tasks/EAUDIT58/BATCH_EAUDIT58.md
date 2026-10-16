# EAUDIT58：第2章§2.3.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-Divergence",
  "kind": "definition",
  "label": null,
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "the divergence of $f$ vanishes, i.e.\n\\[\\nabla\\cdot f=\\sum_{i=1}^m\\frac{\\partial f_i}{\\partial z_i}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "div f为实际Jacobian的迹；f C¹。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_divergence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.931611",
      "before_sha256": "f65c755778fdf003ed02b69cd360ac5f6534b65e75dba99476d5fc8baaa852cf",
      "after_sha256": "350e0be5a5a06ef7f719c52969531eaa058c3c96bbf7f51c22c3e5b820cf0d5a",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def bp_divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace

def divergenceFree {n : ℕ} (f : Q n → Q n) : Prop :=
  Differentiable ℝ f ∧ ∀ z, bp_divergence f z = 0
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch02.bp_divergence
```lean
def bp_divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace
```
### 实际依赖 MD.Ch02.divergenceFree
```lean
def divergenceFree {n : ℕ} (f : Q n → Q n) : Prop :=
  Differentiable ℝ f ∧ ∀ z, bp_divergence f z = 0
```
### 实际依赖 MolecularDynamics.textbookCoordinateJacobian
```lean
noncomputable def textbookCoordinateJacobian (f : (ι → ℝ) → ι → ℝ) (z : ι → ℝ) :
    Matrix ι ι ℝ := LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-Liouville",
  "kind": "unnumbered_claim",
  "label": "Liouville’s theorem",
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "Consider a set of points $S(t)$ in phase space with evolution associated to a differential equation $\\dot{\\boldsymbol z}=f(\\boldsymbol z)$ described by the flow map $\\mathcal F_t(S(0))=S(t)$. Liouville’s theorem [16] states that the volume of such a set is invariant with respect to $t$ if the divergence of $f$ vanishes,",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.liouville",
  "reusable_proofs": [
    "MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.931611",
      "before_sha256": "38b7c400886bec64429142bb8889c22eb85c78dc2c33252d204d222d4f01739c",
      "after_sha256": "3734129202806e73e8abbf51c5934c391cba67d2086bcbbe8519310e3d3fdb5b",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem liouville
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set ((Fin n) → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 <;> assumption
```
### 实际依赖 MolecularDynamics.textbookCoordinateJacobian
```lean
noncomputable def textbookCoordinateJacobian (f : (ι → ℝ) → ι → ℝ) (z : ι → ℝ) :
    Matrix ι ι ℝ := LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-HamiltonVolume",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "72",
  "pdf_page": "94",
  "statement_latex": "Thus Hamiltonian systems always have volume preserving flows.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "流为实际Hamilton向量场的解族；完整体积结论覆盖闭时间窗每个t及每个可测S。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonVolume",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.932113",
      "before_sha256": "062557aea424f64921c592dd516b34127799171ea670f940ccbe0a3d6773d714",
      "after_sha256": "71b80b96cceda4340a126c6204be0b6b5408ad8eca27063ceaf4eb9ceb7322ff",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonVolume {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 <;> assumption
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

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-DeterminantODE",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "Now let $D=\\det(W)$. One can show (see Exercise 5) that\n\\[\\frac{\\dot D}{D}=\\operatorname{tr}(\\dot W W^{-1}).\\]\nThis implies that\n\\[\\dot D=\\operatorname{div}(f(\\boldsymbol z(t)))D,\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "A(t)=f′(z(t))，tr A=div f(z(t))；W满足上一变分ODE。原文除D的等式需D≠0；实际Lean签名同时登记最终D′子句及D′/D=tr((AW)W⁻¹)子句，使用HasDerivAt W (A t*W t) t识别W′。A在签名中是一般矩阵系数，取A(t)=f′(z(t))得到原文实例。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.determinantODE",
  "reusable_proofs": [
    "MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE"
  ],
  "extra_assumptions": [
    "实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.932113",
      "before_sha256": "05180b5f80ad800f00467974b8824540ba2fd6fa410a68c48a0d1d51bc14871e",
      "after_sha256": "03ef0a4dcc7a260c38eb0b1308b166b2eaa2837abf1a103ff489017d177cab1f",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH12_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem determinantODE : ∀ n (A W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    HasDerivAt W (A t * W t) t → (W t).det ≠ 0 →
    HasDerivAt (fun s => (W s).det) ((A t).trace*(W t).det) t ∧
      deriv (fun s => (W s).det) t/(W t).det =
        Matrix.trace ((A t*W t)*(W t)⁻¹) := by
  intro n A W t hW hdet
  have hd := MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE W (A t) t hW
  refine ⟨hd,?_⟩
  rw [hd.deriv, mul_div_cancel_right₀ _ hdet, Matrix.mul_assoc,
    Matrix.mul_nonsing_inv _ (isUnit_iff_ne_zero.mpr hdet), Matrix.mul_one]
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-FlowDet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "73",
  "pdf_page": "95",
  "statement_latex": "In particular, if $\\operatorname{div}f\\equiv0$, we see that $D\\equiv D(0)=1$ and it follows that the volume is constant. Liouville’s theorem may be summarized compactly as:\n\\[\\nabla\\cdot f=0\\Rightarrow\\det\\mathcal F_t'=1.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F_t为ODE ż=f(z)从t=0出发的流映射，F_0=id；F_t′表示关于初始状态的Jacobian。",
    "D为该Jacobian行列式；初始Jacobian为单位矩阵，故D(0)=1。",
    "div f=∇·f为向量场散度；S(t)=F_t(S)，Vol(S(t))为像集体积，页上换元公式积分|D|。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.flowDet",
  "reusable_proofs": [
    "MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2"
  ],
  "extra_assumptions": [
    "[EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。",
    "[EXTRA] 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.932113",
      "before_sha256": "857e316b3c50da1760f3957561c0a274c719217b59fcb9d776fb9c8e5be209e2",
      "after_sha256": "e79c1dc5ed463a8336ee0908275765a4c4b50fb936a269e995c5a8142e453bdc",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem flowDet
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (_hτ : 0 < τ) :
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1 ) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (Q n), MeasurableSet S →
      volume ((fun z ↦ Φ (t,z)) '' S) = volume S) := by
  constructor
  · apply MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2 <;> assumption
  · exact MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 f hf hdiv Φ hΦ τ hODE hinit
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.textbookCoordinateJacobian
```lean
noncomputable def textbookCoordinateJacobian (f : (ι → ℝ) → ι → ℝ) (z : ι → ℝ) :
    Matrix ι ι ℝ := LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-LJOscillator",
  "kind": "definition",
  "label": "Example 2.3 (model)",
  "section": "2.3.1",
  "printed_page": "73–74",
  "pdf_page": "95–96",
  "statement_latex": "A 1-d oscillator with Lennard-Jones potential is described by the equations\n\\[\\dot q=p,\\qquad\\dot p=-\\varphi_{LJ}'(q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "φ=第1章Lennard–Jones势，q>0物理位置域；仅定义实际ODE关系。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.ljOscillatorEquation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.932113",
      "before_sha256": "24bae1592cf5ca3d6f2bc18840769290225735bcbd1f537f248bde468118f005",
      "after_sha256": "ea47e68106d37f6d8c5110c00ce267f8601a1278587daa315e8580194acca1f1",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def ljOscillatorEquation (σ ε : ℝ) (_hσ : 0 < σ) (_hε : 0 < ε)
    (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  (∀ t ∈ I, 0 < (γ t).1) ∧
  ∀ t ∈ I, HasDerivAt γ
    ((γ t).2,-deriv (fun q : ℝ ↦ 4*ε*((σ/q)^12-(σ/q)^6)) (γ t).1) t

def oscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t
```
### 实际依赖 MD.Ch02.ljOscillatorEquation
```lean
def ljOscillatorEquation (σ ε : ℝ) (_hσ : 0 < σ) (_hε : 0 < ε)
    (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  (∀ t ∈ I, 0 < (γ t).1) ∧
  ∀ t ∈ I, HasDerivAt γ
    ((γ t).2,-deriv (fun q : ℝ ↦ 4*ε*((σ/q)^12-(σ/q)^6)) (γ t).1) t
```
### 实际依赖 MD.Ch02.oscillatorEquation
```lean
def oscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t
```

## 原文JSON
```json
{
  "source_id": "MD-2.3.1-LJBoundedPeriodic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.3.1",
  "printed_page": "74",
  "pdf_page": "96",
  "statement_latex": "As a consequence of energy conservation, any bounded individual trajectory of this system will be a periodic orbit.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "this system指Example 2.3中的一维Lennard–Jones振子：q̇=p，ṗ=−φ_LJ′(q)，物理位置q>0。",
    "bounded individual trajectory指相空间(q,p)中的单条完整轨迹有界；periodic orbit在此按存在正周期解释，平衡轨迹也满足此解释。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.ljBoundedPeriodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。",
    "[EXTRA] 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT07_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:10:09.932113",
      "before_sha256": "10d1f205fba4a4c74157b382f251c2a5f96657e3a9a7bb93f84c4b90b8667f0c",
      "after_sha256": "8f0242e94852ac75b7ea23adbf055ec85f0e1849beb826c9c40710cdd81078c7",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH13_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT07/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem ljBoundedPeriodic : ∀ (σ ε : ℝ) (γ : ℝ → ℝ × ℝ),
    0 < σ → 0 < ε →
    oscillatorEquation (fun q => 4*ε*((σ/q)^12-(σ/q)^6)) γ Set.univ →
    (∀ t, 0 < (γ t).1) → Bornology.IsBounded (Set.range γ) →
    ∃ T > 0, ∀ t, γ (t+T) = γ t := by
  sorry
```
### 实际依赖 MD.Ch02.oscillatorEquation
```lean
def oscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t
```
