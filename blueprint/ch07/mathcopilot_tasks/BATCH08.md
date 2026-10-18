# BATCH08 第7章原文与陈述审校

## MD-7.4.2-BBKStarMomentSystemPrinted
```json
{
  "source_id": "MD-7.4.2-BBKStarMomentSystemPrinted",
  "kind": "definition",
  "label": null,
  "section": "7.4.2",
  "printed_page": "278–279",
  "pdf_page": "299–300",
  "statement_latex": "Thus taking expectations of (7.8)–(7.10) and substituting in the constants gives\n\\[Q=\\psi_{11}^2Q+\\psi_{12}^2P+2\\psi_{11}\\psi_{12}C+2\\psi_{12}\\kappa_1 2\\psi_{12}\\kappa_1\\kappa_3+\\kappa_1^2,\\]\n\\[P=\\psi_{21}^2Q+\\psi_{22}^2P+2\\psi_{21}\\psi_{22}C+2\\psi_{22}\\kappa_2 2\\psi_{22}\\kappa_2\\kappa_3+\\kappa_2^2+\\kappa_3^2,\\]\n\\[C=\\psi_{11}\\psi_{21}Q+\\psi_{12}\\psi_{22}P+(\\psi_{11}\\psi_{22}+\\psi_{12}\\psi_{21})C+\\kappa_1\\kappa_2+\\psi_{12}\\kappa_2\\kappa_3+\\psi_{22}\\kappa_1\\kappa_3.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "PDF300续接第三条方程；此处定义保留方程组全部三式，不把修正方程定义计作概率推导已证。"
  ],
  "issues": [
    "已目视核对PDF299／印刷278：前两条方程交叉项重复印出2ψ12κ1与2ψ22κ2；按前面已列相关矩，应分别为2ψ12κ1κ3和2ψ22κ2κ3。原文与修正方程均保留。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarMomentSystemPrinted",
  "lean_declarations": [
    "MD.Ch07.bbkStarMomentSystemPrinted",
    "MD.Ch07.bbkStarMomentSystemPrinted_corrected",
    "MD.Ch07.bbkStarExtraFactor_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbkStarMomentSystemPrinted (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

def bbkStarMomentSystemPrinted_corrected (a b c d κ1 κ2 κ3 Q P C : ℝ) : Prop :=
  Q=a^2*Q+b^2*P+2*a*b*C+2*b*κ1*κ3+κ1^2 ∧
  P=c^2*Q+d^2*P+2*c*d*C+2*d*κ2*κ3+κ2^2+κ3^2 ∧
  C=a*c*Q+b*d*P+(a*d+b*c)*C+κ1*κ2+b*κ2*κ3+d*κ1*κ3

theorem bbkStarExtraFactor_counterexample : (2*(1:ℝ)*1*2*1*1*1) ≠ 2*1*1*1 := by norm_num
```

## MD-7.4.2-BBKStarStationary
```json
{
  "source_id": "MD-7.4.2-BBKStarStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.2",
  "printed_page": "279",
  "pdf_page": "300",
  "statement_latex": "Finally, solving the simultaneous equations gives the stationary observed averages as\n\\[\\langle q^2\\rangle_h^{\\rm BBK*}=\\frac{k_BT}{\\Omega^2}(1-\\frac{\\Omega^2h^2}{4m})^{-1},\\qquad\n\\langle p^2\\rangle_h^{\\rm BBK*}=k_BTm(1+\\frac{\\gamma h}2)^{-1},\\qquad\n\\langle qp\\rangle_h^{\\rm BBK*}=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "只陈述修正后的矩方程组求解；一般平稳分布导出此方程需BBKStarCorrelations及历史模型，未声称整条分布理论完成。"
  ],
  "issues": [],
  "statement_scope": "给定正确矩方程的代数求解及全部三矩值；未证明BBK*长期收敛。",
  "lean_decl": "MD.Ch07.bbkStarStationaryAlgebra",
  "lean_declarations": [
    "MD.Ch07.bbkStarStationaryAlgebra"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem bbkStarStationaryAlgebra (m Ω γ θ h Q P C : ℝ)
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m)
    (hsys : bbkStarMomentSystemPrinted_corrected
      (bbkMatrix m Ω γ h).1 (bbkMatrix m Ω γ h).2.1
      (bbkMatrix m Ω γ h).2.2.1 (bbkMatrix m Ω γ h).2.2.2
      (Real.sqrt (θ*γ*h^3/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*(1-h^2*Ω^2/(2*m)))
      (Real.sqrt (2*θ*γ*h*m)/(2+γ*h)) Q P C) :
    Q = θ/Ω^2*(1-Ω^2*h^2/(4*m))⁻¹ ∧
    P = θ*m*(1+γ*h/2)⁻¹ ∧ C = 0 := by
  sorry
```
