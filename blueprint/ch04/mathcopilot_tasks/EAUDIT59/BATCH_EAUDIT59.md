# EAUDIT59：第4章§4.3.5.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.3.5.1-AdjointEuler",
  "kind": "definition",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "Now replace $h$ by $-h$ and then swap $Q$ with $q$ and $P$ with $p$, resulting in\n\\[\\widehat P=p-hg'(q)^T\\lambda,\\quad Q=q+hM^{-1}\\widehat P,\\quad P=\\widehat P+hF(Q)-hg'(Q)^T\\mu,\\]\nwhere $\\lambda,\\mu$ are again defined by the constraint conditions. This defines the adjoint method, another first order method for the constrained system.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "真实末位置/隐藏约束；原正h、乘子吸收缩放须h≠0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.adjointEulerRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:58:18.044200",
      "before_sha256": "5488f6a4d2f415b6e0fc2496bb528d8c0ad38845f40d55035c535e534d5556d5",
      "after_sha256": "cc526a923d8775b287d6ac7c0f68312baf8b3db341de2f68370545a343b93488",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

theorem adjointEuler_inverseRelation (n l : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (_hh : h ≠ 0)
    (z out : MolecularDynamics.Chapter04Review.Z n)
    (_hz : z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hout : out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g) :
    (∃ half rho μ, adjointEulerRelation m F g h z out half rho μ) ↔
      ∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (-h) out z pbar rho μ := by
  sorry

theorem adjointEulerLocalOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E A : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 A → ContDiff ℝ 3 Φ → E 0=z → A 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖A h-Φ h‖ ≤ C*h^2 := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.adjointEulerRelation
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ cotangentSet m g
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
### 实际依赖 MD.Ch04.adjointEulerRelation
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
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
  "source_id": "MD-4.3.5.1-ConstrainedComposition",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "By composing the maps $G_{h/2}$ and $G^*_{h/2}$ we get a second order symplectic method. In the sense that it is defined by first order maps which reduce to the Symplectic Euler method and its adjoint, this is an analogous scheme to the Störmer-Verlet method. Interestingly, this method is not equivalent to SHAKE or RATTLE.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedComposition",
  "reusable_proofs": [],
  "extra_assumptions": [
    "U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。",
    "[EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的具体单值近分支实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。"
  ],
  "statement_scope": "小h光滑分支上的组合辛性、无约束退化及非等价实例；二阶精度子句由MD-4.3.5.1-ConstrainedCompositionOrder承担，原文保留。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:58:18.044288",
      "before_sha256": "4ea18f6452a46f96e549fa31150efc9e6f69bbd058d6ca40e58646a3ad3d54ac",
      "after_sha256": "836ff5b4234046febaf62ef6f145e101920aa518b88d8db23975334d1ce40751",
      "changed_fields": [
        "extra_assumptions",
        "statement_scope"
      ],
      "annotation_corrections": {
        "extra_assumptions": {
          "before": [
            "给定真实C¹半步分支、C²势与约束，前后位置约束；本条完整拉回形式结论，二阶精度另条。"
          ],
          "after": [
            "U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。",
            "[EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的具体单值近分支实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。"
          ]
        }
      },
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem constrainedComposition :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoA μA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ q ∈ MolecularDynamics.Chapter04Review.constraintSet g, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) q)) →
    (∀ h ∈ Ioo (-η) η, ContDiff ℝ 1 (E h) ∧ ContDiff ℝ 1 (A h) ∧
      ContDiff ℝ 1 (pE h) ∧ ContDiff ℝ 1 (pA h) ∧ ContDiff ℝ 1 (rhoE h) ∧
      ContDiff ℝ 1 (μE h) ∧ ContDiff ℝ 1 (rhoA h) ∧ ContDiff ℝ 1 (μA h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h ∈ Ioo (-η) η, MolecularDynamics.Chapter04Review.restrictedSymplectic m g (A (h/2) ∘ E (h/2)) := by
  sorry

theorem constrainedComposition_circleExample :
    let m : Fin 2 → ℝ := fun _ ↦ 1
    let g : Fin 1 → (Fin 2 → ℝ) → ℝ := fun _ q ↦ (q 0)^2+(q 1)^2-1
    let F : (Fin 2 → ℝ) → Fin 2 → ℝ := fun _ ↦ 0
    let z : MolecularDynamics.Chapter04Review.Z 2 := (![1,0],![0,1])
    let e : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 15/4,1/4],![-1/4,Real.sqrt 15/4])
    let a : MolecularDynamics.Chapter04Review.Z 2 :=
      (![7/8,Real.sqrt 15/8],![-Real.sqrt 15/8,7/8])
    let r : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 3/2,1/2],![-1/2,Real.sqrt 3/2])
    ∃ pE pA pR pS ρE μE ρA μA ρR μR ρS ρSnew pSout,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (1/4) z e pE ρE μE ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m F g (1/4) e a pA ρA μA ∧
      MolecularDynamics.Chapter04Review.rattleRelation m F g (1/2) z r pR ρR μR ∧
      MolecularDynamics.Chapter04Review.shakeRelation m F g (1/2) z (r.1,pSout) pS ρS ρSnew ∧
      a.1 ≠ r.1 := by
  sorry

theorem constrainedComposition_noConstraints (n : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) :
    ((∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out pbar rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m (z.2+h • F z.1),z.2+h • F z.1)) ∧
    ((∃ half rho μ, MolecularDynamics.Chapter04Review.adjointEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out half rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2,
        z.2+h • F (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2))) := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.adjointEulerRelation
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ cotangentSet m g
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
### 实际依赖 MolecularDynamics.Chapter04Review.restrictedSymplectic
```lean
def restrictedSymplectic {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (G : Z n → Z n) : Prop :=
  ∀ z ∈ cotangentSet m g, ∀ u v, tangentPhase m g z u → tangentPhase m g z v →
    phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=phaseForm u v
```
### 实际依赖 MolecularDynamics.Chapter04Review.shakeRelation
```lean
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho rhonew : Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
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
### 实际依赖 MD.Ch04.adjointEulerRelation
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
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
### 实际依赖 MolecularDynamics.Chapter04Review.restrictedSymplectic
```lean
def restrictedSymplectic {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → Q n → ℝ)
    (G : Z n → Z n) : Prop :=
  ∀ z ∈ cotangentSet m g, ∀ u v, tangentPhase m g z u → tangentPhase m g z v →
    phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=phaseForm u v
```
### 实际依赖 MD.Ch04.shakeRelation
```lean
def shakeRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho rhonew : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2+(h/2) • (F z.1-(textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+(h/2) • (F out.1-(textbookConstraintJacobian g out.1)ᵀ *ᵥ rhonew)
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

## 原文JSON
```json
{
  "source_id": "MD-4.3.5.1-ConstrainedCompositionOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "163",
  "pdf_page": "185",
  "statement_latex": "By composing the maps $G_{h/2}$ and $G^*_{h/2}$ we get a second order symplectic method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.constrainedCompositionOrder",
  "reusable_proofs": [],
  "extra_assumptions": [
    "真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。",
    "[EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。"
  ],
  "statement_scope": "组合方法O(h³)局部误差（二阶精度）子句；辛性、退化及非等价实例由MD-4.3.5.1-ConstrainedComposition承担；不冒充全局二阶收敛。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:58:18.044344",
      "before_sha256": "9ae5f0f1e7bbf694e287adda8107861fe1dd1891f4f3f1eff5458fe1bb1910af",
      "after_sha256": "a323d3a95345d5e960bf7b78e98935af2eb807b731c3ea4ecee23340a88c273f",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem constrainedCompositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE muE rhoA muA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → MolecularDynamics.Chapter04Review.Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3 := by
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
### 实际依赖 MolecularDynamics.Chapter04Review.adjointEulerRelation
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (h : ℝ) (z out : Z n) (half : Q n) (rho μ : Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • invMass m half ∧ out.1 ∈ constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ cotangentSet m g
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
### 实际依赖 MD.Ch04.adjointEulerRelation
```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g
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
  "source_id": "MD-4.3.5.1-GeodesicRelation",
  "kind": "definition",
  "label": null,
  "section": "4.3.5.1",
  "printed_page": "164",
  "pdf_page": "186",
  "statement_latex": "The constrained flow on the kinetic energy term, on the other hand, is generated by the equations of motion\n\\[\\frac{dq}{dt}=M^{-1}p,\\quad\\frac{dp}{dt}=-g'(q)^T\\lambda,\\quad0=g(q).\\]\nThis is nothing other than the mass-weighted geodesic flow on the given constraint surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际零势约束ODE；不搭建流形测地流存在理论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.geodesicRelation",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补正质量诱导度量∑m_i u_i v_i，并在开放时间、C²约束/轨迹及满秩域上，将质量正交加速度的嵌入测地线方程与真实零势约束ODE及p=Mqdot等价；不声称全局流存在。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT15_LOCAL_REPAIR",
      "timestamp": "2026-10-15T18:58:18.044393",
      "before_sha256": "c576f481f3b375d03feaff63d69584c8d5825762f9fc36af705772eb32645d88",
      "after_sha256": "2efe1a9a6ca8ae896e2f1f2658fb4d3ab065d6d24d5ff9d6eb5479f6985058b8",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT15/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) (_hm : ∀ i, 0 < m i)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) : Prop :=
  MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ => 0) g q p rho I

def massMetric {n : ℕ} (m : Fin n → ℝ) (u v : Fin n → ℝ) : ℝ :=
  ∑ i, m i*u i*v i

theorem geodesicRelation_massMetric (n l : ℕ) (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) (I : Set ℝ) (_hI : IsOpen I)
    (q : ℝ → MolecularDynamics.Chapter04Review.Q n) (_hq : ContDiff ℝ 2 q)
    (_hc : ∀ t ∈ I, ∀ j, g j (q t)=0)
    (_hreg : ∀ t ∈ I, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) (q t))) :
    (∀ t ∈ I, ∀ ξ : MolecularDynamics.Chapter04Review.Q n,
      textbookConstraintJacobian g (q t) *ᵥ ξ=0 →
        massMetric m (deriv (deriv q) t) ξ=0) ↔
    ∃ p rho, (∀ t ∈ I, p t=fun i ↦ m i*deriv q t i) ∧
      MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ ↦ 0) g q p rho I := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.constrainedSolution
```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Fin l → Q n → ℝ) (q p : ℝ → Q n) (rho : ℝ → Q l) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivWithinAt q (invMass m (p t)) I t ∧
    HasDerivWithinAt p (F (q t)-(textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) I t ∧
    q t ∈ constraintSet g
```
### 实际依赖 MolecularDynamics.Chapter04Review.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → Q n → ℝ) : Set (Q n) := {q | ∀ j, g j q=0}
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
### 实际依赖 MD.Ch04.constrainedSolution
```lean
def constrainedSolution {n l : ℕ} (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hU : Differentiable ℝ U) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hg : ∀ j, Differentiable ℝ (g j))
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n)
    (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) : Prop :=
  ∀ t ∈ I, HasDerivAt q (MolecularDynamics.Chapter04Review.invMass m (p t)) t ∧
    HasDerivAt p (-MolecularDynamics.Chapter04Review.grad U (q t)-
      (textbookConstraintJacobian g (q t))ᵀ *ᵥ rho t) t ∧
    q t ∈ MolecularDynamics.Chapter04Review.constraintSet g
```
### 实际依赖 MD.Ch04.constraintSet
```lean
def constraintSet {n l : ℕ} (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) : Set (MolecularDynamics.Chapter04Review.Q n) := {q | ∀ j, g j q=0}
```
### 实际依赖 MD.Ch04.geodesicRelation
```lean
def geodesicRelation {n l : ℕ} (m : Fin n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) (I : Set ℝ) (_hI : IsOpen I) (_hm : ∀ i, 0 < m i)
    (_hg : ∀ j, ContDiff ℝ 2 (g j)) : Prop :=
  MolecularDynamics.Chapter04Review.constrainedSolution m (fun _ => 0) g q p rho I
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
### 实际依赖 MD.Ch04.massMetric
```lean
def massMetric {n : ℕ} (m : Fin n → ℝ) (u v : Fin n → ℝ) : ℝ :=
  ∑ i, m i*u i*v i
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
