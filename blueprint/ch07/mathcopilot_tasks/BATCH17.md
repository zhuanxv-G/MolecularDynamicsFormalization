# BATCH17 第7章原文与陈述审校

## MD-7.9.3-ZeroFrictionVerlet
```json
{
  "source_id": "MD-7.9.3-ZeroFrictionVerlet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.3",
  "printed_page": "306",
  "pdf_page": "327",
  "statement_latex": "An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $\\gamma=0$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.zeroFrictionOU",
  "lean_declarations": [
    "MD.Ch07.zeroFrictionOU",
    "MD.Ch07.zeroFrictionBAOAB"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  sorry
```
