# EAUDIT36：第4章§4.3.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.5-ConstrainedOrders",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "161–162",
  "pdf_page": "183–184",
  "statement_latex": "The projected symplectic constrained method (4.20)–(4.24) is only first order accurate. We forego providing a detailed proof of this fact, but note that it could be demonstrated using standard methods [164]. There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "statement_latex依原文先后选取非连续句子：省略“Note that (4.20)–(4.24) reduces ...”说明及SHAKE两步来源推导；末句“The symmetry suggests ...”位于(4.26)后。所引句子全部在印刷161/PDF183。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedOrders",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。",
    "[EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。"
  ],
  "statement_scope": "投影Euler全局一阶（含非二阶实例）及RATTLE全局二阶；SHAKE位置全局二阶由MD-4.3.5-SHAKEPositionOrder承担，其原印质量约定待导师。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:57:05.217421",
      "before_sha256": "f53c93306fc9b7fdcad1d823b73e65959ccef9f18cc1db541dd5d2553ddda8ad",
      "after_sha256": "63050ff359bff656aeb81e274fba78bad693a16cc416b1223a2132ab052b52fa",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH16_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem constrainedOrders :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  sorry

theorem constrainedOrders_global (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 4 U) (_hg : ∀ j, ContDiff ℝ 4 (g j))
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      (textbookConstraintGram m g z.1).det ≠ 0)
    (E R : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (pE pR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (η : ℝ) (_hη : 0 < η)
    (_hE : ContDiffOn ℝ 3 (Function.uncurry E) (Ioo (-η) η ×ˢ D))
    (_hR : ContDiffOn ℝ 3 (Function.uncurry R) (Ioo (-η) η ×ˢ D))
    (_hrhoE : ContDiffOn ℝ 2 (Function.uncurry rhoE) (Ioo (-η) η ×ˢ D))
    (_hμE : ContDiffOn ℝ 2 (Function.uncurry μE) (Ioo (-η) η ×ˢ D))
    (_hrhoR : ContDiffOn ℝ 2 (Function.uncurry rhoR) (Ioo (-η) η ×ˢ D))
    (_hμR : ContDiffOn ℝ 2 (Function.uncurry μR) (Ioo (-η) η ×ˢ D))
    (_hzero : ∀ z ∈ D, E 0 z=z ∧ R 0 z=z ∧ μE 0 z=0 ∧ μR 0 z=0)
    (_hsteps : ∀ h ∈ Ioo (-η) η, ∀ z ∈ D,
      z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (R h z) (pR h z) (rhoR h z) (μR h z))
    (T : ℝ) (_hT : 0 < T) (Φ : ℝ → MolecularDynamics.Chapter04Review.Z n)
    (_hΦ : ∀ t ∈ Icc 0 T, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t)
    (_hc : ∀ t ∈ Icc 0 T, Φ t ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hcompact : ∃ B, IsCompact B ∧ B ⊆ D ∧ ∀ t ∈ Icc 0 T, Φ t ∈ B) :
    ∃ C > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      let h := T/(N:ℝ)
      ∀ k ≤ N, ‖(E h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h ∧
        ‖(R h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h^2 := by
  sorry

theorem constrainedOrders_firstOrderSharp :
    ∃ c > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      c/(N:ℝ) ≤ ‖(MolecularDynamics.Chapter04Review.symplecticEulerMatrix 1 (1/(N:ℝ)))^N *ᵥ
        (![1,0] : Fin 2 → ℝ)-![Real.cos 1,-Real.sin 1]‖ := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.cotangentSet
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) : Set (Z n) :=
  {z | z.1 ∈ constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ invMass m z.2=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.projectedEulerRelation
```lean
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (pbar : Q n) (rho μ : Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m pbar ∧ out.1 ∈ constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ cotangentSet m g
```
### 实际依赖 MolecularDynamics.Chapter04Review.rattleRelation
```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ cotangentSet m g
```
### 实际依赖 MolecularDynamics.Chapter04Review.symplecticEulerMatrix
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
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
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MD.Ch04.cotangentSet
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
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
### 实际依赖 MD.Ch04.projectedEulerRelation
```lean
def projectedEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (pbar : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  pbar=z.2+h • F z.1-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m pbar ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=pbar-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧ out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```
### 实际依赖 MD.Ch04.rattleRelation
```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```
### 实际依赖 MD.Ch04.symplecticEulerMatrix
```lean
def symplecticEulerMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![1-h^2*Ω^2,h; -h*Ω^2,1]
```
### 实际依赖 MolecularDynamics.textbookConstrainedPhaseVectorField
```lean
noncomputable def textbookConstrainedPhaseVectorField {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (U : (Fin Nc → ℝ) → ℝ)
    (z : (Fin Nc → ℝ) × (Fin Nc → ℝ)) : (Fin Nc → ℝ) × (Fin Nc → ℝ) :=
  (textbookInverseMassMatrix m *ᵥ z.2,
    textbookPotentialForce U z.1 - (textbookConstraintJacobian γ z.1)ᵀ *ᵥ
      textbookConstrainedReactionMultiplier m γ (textbookPotentialForce U) z.1 z.2)
```
### 实际依赖 MolecularDynamics.textbookConstrainedReactionMultiplier
```lean
noncomputable def textbookConstrainedReactionMultiplier {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (F : (Fin Nc → ℝ) → Fin Nc → ℝ)
    (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  (textbookConstraintGram m γ q)⁻¹ *ᵥ
    (textbookConstraintJacobian γ q *ᵥ (textbookInverseMassMatrix m *ᵥ F q) +
      textbookConstraintCurvature m γ q p)
```
### 实际依赖 MolecularDynamics.textbookConstraintCurvature
```lean
noncomputable def textbookConstraintCurvature {Nc Mc : ℕ} (m : Fin Nc → ℝ)
    (γ : Fin Mc → (Fin Nc → ℝ) → ℝ) (q p : Fin Nc → ℝ) : Fin Mc → ℝ :=
  fun j => (fderiv ℝ (fderiv ℝ (γ j)) q)
    (textbookInverseMassMatrix m *ᵥ p) (textbookInverseMassMatrix m *ᵥ p)
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
### 实际依赖 MolecularDynamics.textbookInverseMassMatrix
```lean
noncomputable def textbookInverseMassMatrix {Nc : ℕ} (m : Fin Nc → ℝ) :
    Matrix (Fin Nc) (Fin Nc) ℝ := Matrix.diagonal fun i => (m i)⁻¹
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```

## 原文JSON
```json
{
  "source_id": "MD-4.3.5-RATTLESymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5",
  "printed_page": "162",
  "pdf_page": "184",
  "statement_latex": "Moreover, the symplecticness of (4.30)–(4.34) may be demonstrated using a very similar approach to that used to demonstrate the symplectic condition for (4.20)–(4.24). Given the above discussion and derivation, the proof of symplecticness of the RATTLE method (4.30)–(4.34) is now a formality. For details refer to [229].",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.rattleSymplectic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。",
    "[EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:57:05.217489",
      "before_sha256": "ae225f119c5b1d10f553076ef0d45d3a44c02537a3d811b5fd73cacd5ac91059",
      "after_sha256": "6bedfd2b055965aa27859d41688615609163c6e71b1f2aadb29a4e350b25e3da",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH16_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT14/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem rattleSymplectic (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j))
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D) (h : ℝ)
    (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1))
    (_hG : ContDiffOn ℝ 1 G D) (_hp : ContDiffOn ℝ 1 half D)
    (_hr : ContDiffOn ℝ 1 rho D) (_hμ : ContDiffOn ℝ 1 μ D)
    (_hstep : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) :
    ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      ∀ u v, MolecularDynamics.Chapter04Review.tangentPhase m g z u →
      MolecularDynamics.Chapter04Review.tangentPhase m g z v →
        MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=
          MolecularDynamics.Chapter04Review.phaseForm u v := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MolecularDynamics.Chapter04Review.cotangentSet
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) : Set (Z n) :=
  {z | z.1 ∈ constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ invMass m z.2=0}
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
### 实际依赖 MolecularDynamics.Chapter04Review.rattleRelation
```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ cotangentSet m g
```
### 实际依赖 MolecularDynamics.Chapter04Review.tangentPhase
```lean
def tangentPhase {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (z v : Z n) : Prop :=
  ∀ j, (fderiv ℝ (g j) z.1) v.1=0 ∧
    (fderiv ℝ (fun x : Z n => (fderiv ℝ (g j) x.1) (invMass m x.2)) z) v=0
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
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MD.Ch04.cotangentSet
```lean
def cotangentSet {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Z n) :=
  {z | z.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧ textbookConstraintJacobian g z.1 *ᵥ MolecularDynamics.Chapter04Review.invMass m z.2=0}
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
### 实际依赖 MD.Ch04.rattleRelation
```lean
def rattleRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ μ ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
```
### 实际依赖 MolecularDynamics.Chapter04Review.tangentPhase
```lean
def tangentPhase {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ) (z v : Z n) : Prop :=
  ∀ j, (fderiv ℝ (g j) z.1) v.1=0 ∧
    (fderiv ℝ (fun x : Z n => (fderiv ℝ (g j) x.1) (invMass m x.2)) z) v=0
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
