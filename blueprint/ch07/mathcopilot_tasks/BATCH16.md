# BATCH16 第7章原文与陈述审校

## MD-7.9.3-SuperconvergenceScope
```json
{
  "source_id": "MD-7.9.3-SuperconvergenceScope",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.3",
  "printed_page": "306",
  "pdf_page": "327",
  "statement_latex": "Thus we expect that the $[BAOAB]$ scheme recovers $O(h^4)$ configurational averages in the limit of infinite friction.\nIts conjugate method, the $[OABAO]$ scheme, has the property\n\\[\\int_{\\mathcal Q}f_{2,0,[OABAO]}(q,p)\\rho_\\beta(q,p)d\\omega_q=0,\\]\nimplying that we obtain high-order averages for functions purely of the momenta in the limit of infinite friction.\nIt is important to note that this superconvergence property is only present in the limit of large time, i.e. this is an attribute of the invariant distribution of the discretization schemes $\\widehat\\rho$. As such, there are no bonuses to the weak or strong order of the superconvergent schemes.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。",
    "四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.oabaoPositionCancellation",
  "lean_declarations": [
    "MD.Ch07.oabaoPositionCancellation",
    "MD.Ch07.superconvergence_fromBound"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem oabaoPositionCancellation (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U)
    (hweight : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hgrad : ∀ i, Integrable (fun q ↦ (hessianU U q i i-β*gradient U q i^2)*Real.exp (-β*U q)) volume)
    (hboundary : ∀ q i, Filter.Tendsto
      (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, highFrictionOABAO U β q ∂positionGibbs U β) = 0 := by
  sorry
theorem superconvergence_fromBound (A : ℝ → ℝ) (exact : ℝ)
    (hA : Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact-h^2*(0 : ℝ)) (fun h ↦ h^4)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact) (fun h ↦ h^4) := by
  simpa using hA
```
