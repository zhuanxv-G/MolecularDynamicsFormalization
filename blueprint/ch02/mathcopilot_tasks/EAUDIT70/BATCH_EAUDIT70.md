# EAUDIT70：第2章§2.4.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.5-ConjugateIterates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "Conjugate maps have the property that their iterates are also conjugate, since\n\\[A^n=(\\chi^{-1}\\circ B\\circ\\chi)^n=(\\chi^{-1}\\circ B\\circ\\chi)\\circ(\\chi^{-1}\\circ B\\circ\\chi)\\circ\\cdots\\circ(\\chi^{-1}\\circ B\\circ\\chi)=\\chi^{-1}\\circ B^n\\circ\\chi.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.conjugateIterates",
  "reusable_proofs": [
    "MolecularDynamics.textbook_conjugate_iterates"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:24:26.172844",
      "before_sha256": "2c212548a95e57a12b9bd168df0e9e00e1447b66a8c3818b7ae3ce9d21dd3e5b",
      "after_sha256": "86ecba73d41fe05e906d4d98939e767ab86ec7f57087ef4e82121f0e2fda6365",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption
```
### 实际依赖 MolecularDynamics.textbookConjugateMap
```lean
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.5-EulerConjugacy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Symplectic Euler与Verlet指本章机械Hamilton系统的相应一步映射；原页将共轭的证明指向Exercise 12，未在此给出具体χ_h。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.eulerConjugacy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:24:26.172844",
      "before_sha256": "5b06ba1a2f293bcda4ab5e07a16a3767f91b841392d15ffde2d169ce97bc2653",
      "after_sha256": "ee815533cc9d400cf2840973656586aad414427be7bed76c8a55e54b4eea005b",
      "changed_fields": [
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem eulerConjugacy :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h := by
  intro n m U h
  funext z
  let F := textbookPotentialForce U
  let q : Q n := fun i => z (Sum.inl i)+h*(m i)⁻¹*
    (z (Sum.inr i)+(h/2)*F (textbookPositionProjection n z) i)
  have hl : textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))=q := by
    funext i
    simp [q,F,textbookPositionProjection,textbookSymplecticEuler,
      textbookMomentumKick,textbookPositionDrift,Function.comp_def]
    ring <;> simp
  have hr : textbookPositionProjection n
      (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))=q := by
    funext i
    simp [q,textbookPositionProjection,textbookPositionDrift,textbookMomentumKick]
  funext i
  rcases i with i | i
  · change textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z)) i =
        textbookPositionProjection n (textbookPositionDrift m h (textbookMomentumKick F (h/2) z)) i
    rw [hl,hr]
  · change textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z) (Sum.inr i)+
      (h/2)*F (textbookPositionProjection n
        (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))) i =
      textbookMomentumKick F (h/2) z (Sum.inr i)+(h/2)*F (textbookPositionProjection n
        (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))) i
    rw [hl,hr,textbookSymplecticEuler_momentum,textbookPositionProjection_momentumKick]
    simp [F,textbookMomentumKick]
    ring

theorem eulerConjugacy_homeomorph (n : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : Q n → ℝ)
    (_hF : Continuous (textbookPotentialForce U)) (h : ℝ) :
    ∃ χ : SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ z, χ z = textbookMomentumKick (textbookPotentialForce U) (-h/2) z) ∧
      (∀ z, χ.symm z = textbookMomentumKick (textbookPotentialForce U) (h/2) z) ∧
      coordinateVerlet m (textbookPotentialForce U) h =
        χ.symm ∘ textbookSymplecticEuler m U h ∘ χ := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.coordinateVerlet
```lean
def coordinateVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  textbookMomentumKick F (h/2) ∘ textbookPositionDrift m h ∘ textbookMomentumKick F (h/2)
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionDrift
```lean
noncomputable def textbookPositionDrift {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
### 实际依赖 MolecularDynamics.textbookPotentialForce
```lean
noncomputable def textbookPotentialForce {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => -(fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.textbookSymplecticEuler
```lean
noncomputable def textbookSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.5-Processing",
  "kind": "definition",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "Let us suppose that we have such a conjugacy between two numerical methods $\\mathcal G_h$ and $\\tilde{\\mathcal G}_h$, that is\n\\[\\mathcal G_h=\\chi_h^{-1}\\circ\\tilde{\\mathcal G}_h\\circ\\chi_h,\\]\ndefined in such a way that $\\mathcal G_h$ has order $r$ and $\\tilde{\\mathcal G}_h$ has order $s$ where $s<r$. Then, given an initial condition $\\boldsymbol z_0$, we first modify (“pre-process”) this to $\\tilde{\\boldsymbol z}_0=\\chi_h(\\boldsymbol z_0)$, then take multiple steps with the method $\\tilde{\\mathcal G}_h$, and finally transform (“post-process”) the end result by $\\chi_h^{-1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "𝒢_h=χ_h⁻¹∘𝒢̃_h∘χ_h；𝒢_h具有r阶，𝒢̃_h具有s阶且s<r；预处理初值为z̃₀=χ_h(z₀)，最后以后处理χ_h⁻¹变换最终结果。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_processedIterate",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:24:26.172844",
      "before_sha256": "df549a1e8fb9551d50e2238b4ffa26a221135b51114e009a749495f716536548",
      "after_sha256": "cc9fa0bfbcac2751a26bed842424d05a58eaad528ec233f5302ed53c6c2cbeff",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
noncomputable def bp_processedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)

def processingData (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (F : Flow ℝ E) (f : E → E) (r s : ℕ) : Prop :=
  0 < s ∧ s < r ∧
  (∀ t z, HasDerivAt (fun u ↦ F u z) (f (F t z)) t) ∧
  (∀ h, G h = textbookProcessedMethod χ B h) ∧
  methodLocalOrder G (fun h ↦ F h) r ∧ methodLocalOrder B (fun h ↦ F h) s ∧
  ¬ methodLocalOrder B (fun h ↦ F h) (s+1)
```
### 实际依赖 MD.Ch02.bp_processedIterate
```lean
noncomputable def bp_processedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)
```
### 实际依赖 MolecularDynamics.Chapter02Review.methodLocalOrder
```lean
def methodLocalOrder {E : Type*} [NormedAddCommGroup E]
    (G F : ℝ → E → E) (r : ℕ) : Prop :=
  ∀ z, ∃ C > 0, ∃ δ > 0, ∀ h : ℝ, |h| < δ → ‖G h z-F h z‖ ≤ C*|h|^(r+1)
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
### 实际依赖 MD.Ch02.processingData
```lean
def processingData (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (F : Flow ℝ E) (f : E → E) (r s : ℕ) : Prop :=
  0 < s ∧ s < r ∧
  (∀ t z, HasDerivAt (fun u ↦ F u z) (f (F t z)) t) ∧
  (∀ h, G h = textbookProcessedMethod χ B h) ∧
  methodLocalOrder G (fun h ↦ F h) r ∧ methodLocalOrder B (fun h ↦ F h) s ∧
  ¬ methodLocalOrder B (fun h ↦ F h) (s+1)
```
### 实际依赖 MolecularDynamics.textbookConjugateMap
```lean
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```
### 实际依赖 MolecularDynamics.textbookProcessedMethod
```lean
def textbookProcessedMethod (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E) (h : ℝ) : E → E :=
  textbookConjugateMap (χ h) (B h)
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.5-ProcessingIterates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "The resulting approximation will be of order $r$ even though all timestepping was performed using a lower order method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "此句承接上段假设：高阶方法𝒢_h阶r，低阶方法𝒢̃_h阶s<r，两者经χ_h共轭；前后处理后的近似具有r阶。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.processingIterates",
  "reusable_proofs": [
    "MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy"
  ],
  "extra_assumptions": [
    "[EXTRA] 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。"
  ],
  "statement_scope": "仅预处理/迭代/后处理与G的精确迭代恒等式；同一所引原句的阶数结论及低阶资格由MD-2.4.5-ProcessingOrder完整承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:24:26.172844",
      "before_sha256": "729fa815a6907eaef55fb8d9f67ed81f4ada4c20fffddf5f3a328f7d70a9191b",
      "after_sha256": "423e95d43d50ec48012147948dd7327c0d5c2e3db9e2b62c3d8ac474c1095c15",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem processingIterates (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n := by
  apply MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy <;> assumption
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
### 实际依赖 MolecularDynamics.textbookConjugateMap
```lean
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```
### 实际依赖 MolecularDynamics.textbookProcessedIterate
```lean
noncomputable def textbookProcessedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)
```
### 实际依赖 MolecularDynamics.textbookProcessedMethod
```lean
def textbookProcessedMethod (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E) (h : ℝ) : E → E :=
  textbookConjugateMap (χ h) (B h)
```

## 原文JSON
```json
{
  "source_id": "MD-2.4.5-ProcessingOrder",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.5",
  "printed_page": "88",
  "pdf_page": "110",
  "statement_latex": "The resulting approximation will be of order $r$ even though all timestepping was performed using a lower order method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "承接𝒢_h阶r、𝒢̃_h阶s且s<r及𝒢_h=χ_h⁻¹∘𝒢̃_h∘χ_h；r阶是已给的高阶方法的精度，后处理恢复该精度。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.processingOrder",
  "reusable_proofs": [
    "MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy"
  ],
  "extra_assumptions": [
    "r自然数有限时间窗误差界；χh为实际Homeomorph。",
    "[EXTRA] 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT19_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:24:26.172844",
      "before_sha256": "a395f324c5f3bc3d63d6b1bb8da88f15a12fba99d39f7f55c8d192374460ac5d",
      "after_sha256": "28e0641f8b9ed23cbb6b1f78118f4f4557afdb3967b5b8099310a499b335a839",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH26_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT19/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem processingOrder (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (hG : ∀ h, G h=textbookProcessedMethod χ B h) (γ : ℝ → E) (τ : ℝ) (_hτ : 0 < τ) (r s : ℕ) (_hs : 0 < s) (_hsr : s < r)
    (F : Flow ℝ E) (f : E → E) (_hdata : processingData χ B G F f r s)
    (_hγ : ∀ t, γ t = F t (γ 0))
    (_hB : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError B (τ/ν) γ ν ≤ C*(τ/ν)^s)
    (horder : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError G (τ/ν) γ ν ≤ C*(τ/ν)^r) :
    (∀ h ν, textbookProcessedMaxError χ B h γ ν=oneStepMaxError G h γ ν) ∧
    (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      textbookProcessedMaxError χ B (τ/ν) γ ν ≤ C*(τ/ν)^r) := by
  have heq := MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy χ B G hG
  refine ⟨fun h ν => heq h γ ν, ?_⟩
  simpa only [heq] using horder
```
### 实际依赖 MolecularDynamics.Chapter02Review.methodLocalOrder
```lean
def methodLocalOrder {E : Type*} [NormedAddCommGroup E]
    (G F : ℝ → E → E) (r : ℕ) : Prop :=
  ∀ z, ∃ C > 0, ∃ δ > 0, ∀ h : ℝ, |h| < δ → ‖G h z-F h z‖ ≤ C*|h|^(r+1)
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
### 实际依赖 MD.Ch02.processingData
```lean
def processingData (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (F : Flow ℝ E) (f : E → E) (r s : ℕ) : Prop :=
  0 < s ∧ s < r ∧
  (∀ t z, HasDerivAt (fun u ↦ F u z) (f (F t z)) t) ∧
  (∀ h, G h = textbookProcessedMethod χ B h) ∧
  methodLocalOrder G (fun h ↦ F h) r ∧ methodLocalOrder B (fun h ↦ F h) s ∧
  ¬ methodLocalOrder B (fun h ↦ F h) (s+1)
```
### 实际依赖 MolecularDynamics.textbookConjugateMap
```lean
def textbookConjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```
### 实际依赖 MolecularDynamics.textbookProcessedIterate
```lean
noncomputable def textbookProcessedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)
```
### 实际依赖 MolecularDynamics.textbookProcessedMaxError
```lean
noncomputable def textbookProcessedMaxError (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (γ : ℝ → E) (ν : ℕ) : ℝ :=
  (Finset.range (ν + 1)).sup' Finset.nonempty_range_add_one
    (fun n => ‖textbookProcessedIterate χ B h (γ 0) n - γ ((n : ℝ) * h)‖)
```
### 实际依赖 MolecularDynamics.textbookProcessedMethod
```lean
def textbookProcessedMethod (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E) (h : ℝ) : E → E :=
  textbookConjugateMap (χ h) (B h)
```
