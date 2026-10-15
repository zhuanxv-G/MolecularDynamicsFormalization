# EAUDIT30：第3章§3.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.4-ScalarVerletShadow4",
  "kind": "definition",
  "label": null,
  "section": "3.4",
  "printed_page": "117",
  "pdf_page": "139",
  "statement_latex": "The modified energy for the Verlet method for a single degree of freedom system with energy $H=p^2/2+U(q)$ is\n\\[\\widetilde H_h=H+\\frac{h^2}{24}(2p^2U''-(U')^2)\n+h^4\\left(\\frac1{720}p^4U''''-\\frac1{120}p^2U'U'''-\\frac1{240}(U')^2U''-\\frac1{60}p^2((U'')^2+U'U''')\\right)+O(h^6).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文脚注1；有限式只定义h⁴截断，O(h⁶)系数匹配和实际流余项不从定义证明，关联VerletModifiedMatching。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "O(h⁶)的实际修正匹配另为未完成理论；有限函数与余项分开。"
    }
  ],
  "lean_decl": "MD.Ch03.scalarVerletShadow4",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 有限h⁴多项式保留；补足光滑势/紧集上与真实velocity Verlet及该Hamiltonian实际局部流的O(h⁷)端点匹配，对应Hamiltonian O(h⁶)遗漏；新陈述未证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT11_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:10.109001",
      "before_sha256": "a5101cc532d90ef5c944cc85a3abb2ecd4d1336227b4f6eae41db0e689774c27",
      "after_sha256": "4e8c062b7b955ade6f531b8432fba74ae5e52183ee108657b56cc523cd8b5636",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH14_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT11/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)

theorem scalarVerletShadow4_matching (U : ℝ → ℝ) (_hU : ContDiff ℝ ⊤ U)
    (B : Set (ℝ × ℝ)) (_hB : IsCompact B) :
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → (ℝ × ℝ) → ℝ → (ℝ × ℝ),
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧
        solution (fun x : ℝ × ℝ ↦
          (deriv (fun p ↦ scalarVerletShadow4 U h (x.1,p)) x.2,
           -deriv (fun q ↦ scalarVerletShadow4 U h (q,x.2)) x.1)) (Γ h z) 0 h ∧
        ‖(let P := z.2-(h/2)*deriv U z.1
           let Q := z.1+h*P
           (Q,P-(h/2)*deriv U Q))-Γ h z h‖ ≤ C*h^7 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch03.scalarVerletShadow4
```lean
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
```
