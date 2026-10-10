# BATCH21 第2章A原文审校 + C只读语义审计

A：逐字核对原页的陈述、证明、上下文和页码，不静默修正原书疑误。C：只读核对实际Lean定义展开、对象、量词、前提及全部结论，逐条判断[EXTRA]与[ERRATUM?]；签名语义和sorry分开。材料不足或PDF读失败写NEEDS_HUMAN，未核对不得记PASS。不得改工程或补证明。
仅返回JSON数组，每个source_id恰一次，字段：source_id；json_review{status,issue_codes,corrected_json,issues,evidence}；audit{lean_decl,verdict,explanation,counterexample,suggested_fix}。status=APPROVED/CORRECTED/NEEDS_HUMAN；verdict=PASS/FAIL/NEEDS_HUMAN。修订时corrected_json给完整条目，否则null；反例/建议无则null。证据标原PDF页和具体公式/短语。无围栏或额外文字。

Lean4.34.0 / Mathlibv4.34.0。完整依赖工程版本以MANIFEST哈希为准；compact材料是审阅摘录，不是独立Lean工程。

### MD-2.4.1-Splitting
```json
{
  "source_id": "MD-2.4.1-Splitting",
  "kind": "definition",
  "label": null,
  "section": "2.4.1",
  "printed_page": "83",
  "pdf_page": "105",
  "statement_latex": "Suppose that a Hamiltonian $H$ can be split into two parts, i.e. $H=H_1+H_2$, and that the flow maps $\\mathcal F_{1,t}$ and $\\mathcal F_{2,t}$ are known in closed form for the Hamiltonians $H_1$ and $H_2$, respectively. It is natural to think of using the composition of the flow maps $\\mathcal G_h=\\mathcal F_{1,h}\\circ\\mathcal F_{2,h}$ as an approximation to $\\mathcal F_h$, the flow map of the combined Hamiltonian $H$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "只定义给定实际子流的组合；近似精度由后项给出，不把任意映射称为实际流。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_splittingMap",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
def bp_splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h
```

### MD-2.4.1-FieldAdd
```json
{
  "source_id": "MD-2.4.1-FieldAdd",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "83",
  "pdf_page": "105",
  "statement_latex": "$J\\nabla H=J\\nabla H_1+J\\nabla H_2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.fieldAdd",
  "reusable_proofs": [
    "MolecularDynamics.textbookHamiltonianVectorField_add"
  ],
  "extra_assumptions": [
    "H₁,H₂在实际点可微，实际Fréchet梯度。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem fieldAdd {Nc : ℕ}
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (h₁ : DifferentiableAt ℝ H₁ z) (h₂ : DifferentiableAt ℝ H₂ z) :
    textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) z =
      textbookHamiltonianVectorField H₁ z + textbookHamiltonianVectorField H₂ z
```

### MD-2.4.1-SplittingLocal
```json
{
  "source_id": "MD-2.4.1-SplittingLocal",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "83",
  "pdf_page": "105",
  "statement_latex": "For this to be a first order method, we need at least $\\|\\mathcal G_h(\\boldsymbol u)-\\mathcal F_h(\\boldsymbol u)\\|\\le C(\\boldsymbol u)h^2$.",
  "proof_latex": "We expand the map $\\mathcal F_h$ into its Taylor series:\n\\[\\mathcal F_h(\\boldsymbol u)=\\boldsymbol u+hJ\\nabla H(\\boldsymbol u)+\\mathcal O(h^2)=\\boldsymbol u+h(J\\nabla H_1(\\boldsymbol u)+J\\nabla H_2(\\boldsymbol u))+\\mathcal O(h^2).\\tag{2.24}\\]\nFor the individual maps $\\mathcal F_{1,h}$ and $\\mathcal F_{2,h}$, we have\n\\[\\mathcal F_{1,h}(\\boldsymbol u)=\\boldsymbol u+hJ\\nabla H_1(\\boldsymbol u)+\\mathcal O(h^2),\\qquad\\mathcal F_{2,h}(\\boldsymbol u)=\\boldsymbol u+hJ\\nabla H_2(\\boldsymbol u)+\\mathcal O(h^2).\\]\nComposing the two maps we obtain\n\\[\\mathcal F_{1,h}(\\mathcal F_{2,h}(\\boldsymbol u))=\\boldsymbol u+hJ\\nabla H_2(\\boldsymbol u)+hJ\\nabla H_1(\\boldsymbol u+hJ\\nabla H_2(\\boldsymbol u))+\\mathcal O(h^2).\\]\nAssuming $H_1$ is twice continuously differentiable, we may expand further in the last term and collect\n\\[\\mathcal F_{1,h}(\\mathcal F_{2,h}(\\boldsymbol u))=\\boldsymbol u+h(J\\nabla H_2(\\boldsymbol u)+J\\nabla H_1(\\boldsymbol u))+\\mathcal O(h^2).\\]\nThus the splitting method does indeed provide a second order local approximation to the flow map.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.splittingLocal",
  "reusable_proofs": [
    "MolecularDynamics.exists_hamiltonian_splitting_localError_bound"
  ],
  "extra_assumptions": [
    "实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem splittingLocal {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2))
```

### MD-2.4.1-KineticFlow
```json
{
  "source_id": "MD-2.4.1-KineticFlow",
  "kind": "definition",
  "label": "Example 2.4 (kinetic)",
  "section": "2.4.1",
  "printed_page": "83–84",
  "pdf_page": "105–106",
  "statement_latex": "Let $H_1(\\boldsymbol q,\\boldsymbol p)=\\boldsymbol p^TM^{-1}\\boldsymbol p/2$ and $H_2(\\boldsymbol q,\\boldsymbol p)=U(\\boldsymbol q)$, and calculate the flow maps $\\mathcal F_{1,h}$ and $\\mathcal F_{2,h}$ for these individual Hamiltonians. Since\n\\[\\dot{\\boldsymbol q}=M^{-1}\\boldsymbol p,\\qquad\\dot{\\boldsymbol p}=\\boldsymbol0\\quad(H_1),\\]\nwe find the time-$h$ flow to be\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p,\\qquad\\boldsymbol P=\\boldsymbol p.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "固定对角质量，mᵢ≠0资格由机械模型；闭式映射逐坐标表达。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_kineticFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)
```

### MD-2.4.1-PotentialFlow
```json
{
  "source_id": "MD-2.4.1-PotentialFlow",
  "kind": "definition",
  "label": null,
  "section": "2.4.1",
  "printed_page": "84",
  "pdf_page": "106",
  "statement_latex": "On the other hand, for the system with Hamiltonian $H_2$, we have\n\\[\\dot{\\boldsymbol q}=\\boldsymbol0,\\qquad\\dot{\\boldsymbol p}=-\\nabla U(\\boldsymbol q)\\quad(H_2),\\]\nwhich implies the flow map\n\\[\\boldsymbol Q=\\boldsymbol q,\\qquad\\boldsymbol P=\\boldsymbol p-h\\nabla U(\\boldsymbol q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "F=-∇U；实际闭式映射。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.bp_potentialFlow",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
noncomputable def bp_potentialFlow {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```

### MD-2.4.1-SplitEuler
```json
{
  "source_id": "MD-2.4.1-SplitEuler",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "84",
  "pdf_page": "106",
  "statement_latex": "When these maps are composed, we obtain\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol P,\\qquad\\boldsymbol P=\\boldsymbol p-h\\nabla U(\\boldsymbol q),\\]\nwhich is the Symplectic Euler method. The reversed composition gives the adjoint Symplectic Euler method (2.22), (2.23).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.splitEuler",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem splitEuler :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z)
```

### MD-2.4.1-VerletComposition
```json
{
  "source_id": "MD-2.4.1-VerletComposition",
  "kind": "unnumbered_claim",
  "label": "Example 2.5 (composition)",
  "section": "2.4.1",
  "printed_page": "84–85",
  "pdf_page": "106–107",
  "statement_latex": "We compose the Symplectic Euler method $\\mathcal G_h$ and its adjoint $\\mathcal G_h^*$, in each case using step $h/2$; we define $\\mathcal K_h=\\mathcal G_{h/2}^*\\circ\\mathcal G_{h/2}$.",
  "proof_latex": "We obtain\n\\[\\bar{\\boldsymbol q}=\\boldsymbol q+\\frac h2M^{-1}\\bar{\\boldsymbol p},\\quad\\bar{\\boldsymbol p}=\\boldsymbol p-\\frac h2\\nabla U(\\boldsymbol q),\\]\n\\[\\boldsymbol Q=\\bar{\\boldsymbol q}+\\frac h2M^{-1}\\bar{\\boldsymbol p},\\quad\\boldsymbol P=\\bar{\\boldsymbol p}-\\frac h2\\nabla U(\\boldsymbol Q).\\]\nThese simplify to\n\\[\\bar{\\boldsymbol p}=\\boldsymbol p-\\frac h2\\nabla U(\\boldsymbol q),\\quad\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\bar{\\boldsymbol p},\\quad\\boldsymbol P=\\bar{\\boldsymbol p}-\\frac h2\\nabla U(\\boldsymbol Q).\\]\nThis is the leapfrog/Verlet scheme.",
  "proof_note": "原书计算按原页转录。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.verletComposition",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.verletComposition_proved"
  ],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletComposition :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z)
```

### MD-2.4.1-VerletSymplectic
```json
{
  "source_id": "MD-2.4.1-VerletSymplectic",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "2.4.1",
  "printed_page": "85",
  "pdf_page": "107",
  "statement_latex": "Hence the leapfrog/Verlet scheme is a composition of two symplectic maps and is itself symplectic.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch02.verletSymplectic",
  "reusable_proofs": [
    "MolecularDynamics.Chapter02Review.verletSymplectic_proved"
  ],
  "extra_assumptions": [
    "U C²；真实完整步映射。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
```lean
theorem verletSymplectic :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h)
```

