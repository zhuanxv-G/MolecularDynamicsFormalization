# EAUDIT97：第2章§2.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2.4.1-KineticFlow",
  "kind": "definition",
  "label": "Example 2.4",
  "section": "2.4.1",
  "printed_page": "83",
  "pdf_page": "105",
  "statement_latex": "Let\n\\[H_1(\\boldsymbol q,\\boldsymbol p)=\\boldsymbol p^TM^{-1}\\boldsymbol p/2,\\qquad H_2(\\boldsymbol q,\\boldsymbol p)=U(\\boldsymbol q),\\]\nthen a splitting method for $H=H_1+H_2$ may be obtained by determining the flow maps for each of the two parts. For $H_1$ we have the differential equations\n\\[\\dot{\\boldsymbol q}=M^{-1}\\boldsymbol p,\\qquad\\dot{\\boldsymbol p}=\\boldsymbol0.\\]\nThe second equation tells us that $\\boldsymbol p$ is constant, so it is fixed at its initial value, whereas the first equation says that $\\boldsymbol q$ evolves on a linear path, hence its flow map is\n\\[\\boldsymbol Q=\\boldsymbol q+hM^{-1}\\boldsymbol p,\\qquad\\boldsymbol P=\\boldsymbol p.\\]",
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
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT14_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:19:46.414902",
      "before_sha256": "c08fe5d8e590cbc6a4afc475f7ab49c7b7f8e13971e68af96a2d437fdb25a1c0",
      "after_sha256": "1015e30957b256ceea570e068301f743a858b3bd9d54d86c7cd79d8be1e55648",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    },
    {
      "stage": "EDITORIAL_METADATA_VISUAL_REVIEW",
      "timestamp": "2026-10-16T10:26:18.212960",
      "before_sha256": "1015e30957b256ceea570e068301f743a858b3bd9d54d86c7cd79d8be1e55648",
      "after_sha256": "e6fdb34802feac6761387d7e862eaa84b085ae545cd663848898cbb0aeb96772",
      "changed_fields": [
        "label",
        "printed_page",
        "pdf_page"
      ],
      "changes": {
        "label": {
          "before": "Example 2.4 (kinetic)",
          "after": "Example 2.4"
        },
        "printed_page": {
          "before": "83–84",
          "after": "83"
        },
        "pdf_page": {
          "before": "105–106",
          "after": "105"
        }
      },
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH21_result.json",
      "reason": "已对照原页标题、展示式与跨页续文；合并页码/标签/原文类别，原文/签名及既有statement_scope不变。移出的相邻推导页明确保留为review_context_pdf_pages，不裁定数学疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/METADATA_REVIEW_20261016.json",
  "review_context_pdf_pages": [
    106
  ]
}
```
## 完整当前Lean（同一source_id的全部声明）
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
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch02.bp_kineticFlow
```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))
```
### 实际依赖 MD.Ch02.momentumKickDerivative
```lean
private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))
```
### 实际依赖 MolecularDynamics.textbookMomentumKick
```lean
noncomputable def textbookMomentumKick {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i))
    (fun i => z (Sum.inr i) + h * F (textbookPositionProjection Nc z) i)
```
### 实际依赖 MolecularDynamics.textbookPositionProjection
```lean
noncomputable def textbookPositionProjection (Nc : ℕ) :
    SymplecticCoordinates Nc →L[ℝ] (Fin Nc → ℝ) :=
  ContinuousLinearMap.pi fun i => ContinuousLinearMap.proj (Sum.inl i)
```
