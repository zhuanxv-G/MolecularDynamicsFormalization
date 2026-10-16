# EAUDIT12：第1章§1.1.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.1.2-Coulomb",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "12",
  "pdf_page": "35",
  "statement_latex": "When, as in the case of the alanine dipeptide, net charges are present on the atoms, one may model this by means of Coulomb potentials:\n\\[\\varphi_{ij}^{\\mathrm{Coulomb}}(r_{ij})=\\frac{CQ_iQ_j}{\\epsilon r_{ij}},\\]\nwhere $\\epsilon>0$ is the dielectric constant, and $Q_i,Q_j$ are the charges on atoms $i$ and $j$, respectively. $C$ is a positive coefficient allowing the adjustment of units. Obviously the effect of the Coulombic potential depends strongly on whether the atoms have the same or oppositely signed charges.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "不同电荷符号的影响是定性背景；原页没有旧清单声称的导数符号定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.coulombPotential",
  "extra_assumptions": [
    "[EXTRA] 19号：正C、介电常数与距离落实到子类型；电荷仍可正负，未另造吸引排斥结论。"
  ],
  "old_ids": [
    "CH01-024",
    "CH01-025"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def coulombPotential (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric r : {x : ℝ // 0 < x}) : ℝ := C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)
```
### 实际依赖 MD.Ch01.coulombPotential
```lean
def coulombPotential (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric r : {x : ℝ // 0 < x}) : ℝ := C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.2-Cutoff",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "12",
  "pdf_page": "35",
  "statement_latex": "In the simplest treatments, the Coulomb potential is simply cut off at distance $r_{\\mathrm{cut}}$, i.e., is taken to be zero for $r>r_{\\mathrm{cut}}$. This should be done in such a way that the potential remains at least continuously differentiable, preferably smoother (see Exercise 11).",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.smoothCutoff",
  "extra_assumptions": [
    "[EXTRA] 19号：C¹只要求正距离域，保留严格r_cut<r截零及正截断半径。"
  ],
  "old_ids": [
    "CH01-026"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  0 < r_cut ∧ ContDiffOn ℝ 1 φ (Ioi 0) ∧ ∀ r, r_cut < r → φ r = 0
```
### 实际依赖 MD.Ch01.smoothCutoff
```lean
def smoothCutoff (φ : ℝ → ℝ) (r_cut : ℝ) : Prop :=
  0 < r_cut ∧ ContDiffOn ℝ 1 φ (Ioi 0) ∧ ∀ r, r_cut < r → φ r = 0
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.2-Yukawa",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "12",
  "pdf_page": "35",
  "statement_latex": "More accurate treatments of the long range behavior include the use of an exponential term involving the Debye length $\\kappa$ which models screening due to the presence of a polar solvent, in which case the potential is modified to have the form of a Yukawa potential:\n\\[\\varphi_{ij}^{\\mathrm{screened}}(r_{ij})=\\frac{CQ_iQ_j}{\\epsilon r_{ij}}e^{-\\kappa r_{ij}}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "保留原文κ；不把指数改成-r/κ。原文称Debye length但式子以逆长度参数使用，待导师判断。"
  ],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文κ称Debye length，但e^{-κr}的量纲通常对应逆长度；本定义保留字面公式。"
    }
  ],
  "lean_decl": "MD.Ch01.yukawaScreened",
  "extra_assumptions": [
    "[EXTRA] 19号：正C、介电常数、距离落实到子类型；不改原书指数−κr，κ称谓量纲仅登记疑点。"
  ],
  "old_ids": [
    "CH01-027"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def yukawaScreened (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric : {x : ℝ // 0 < x}) (κ : ℝ) (r : {x : ℝ // 0 < x}) : ℝ :=
  C.val * Qᵢ * Qⱼ / (dielectric.val * r.val) * Real.exp (-κ * r.val)

/-- 修正版，对应原文 MD-1.1.2-Yukawa，改动：a保留−κr但把κ解释为逆屏蔽长度；b若保留Debye length称谓则用−r/ℓ。正参数为物理域补充。 -/
def yukawaScreened_corrected_a (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric κ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-κ.val*r.val)

/-- 修正版，对应原文 MD-1.1.2-Yukawa，改动：若参数称Debye长度，指数应为−r/ℓ。 -/
def yukawaScreened_corrected_b (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric ℓ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-r.val/ℓ.val)
```
### 实际依赖 MD.Ch01.yukawaScreened
```lean
def yukawaScreened (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric : {x : ℝ // 0 < x}) (κ : ℝ) (r : {x : ℝ // 0 < x}) : ℝ :=
  C.val * Qᵢ * Qⱼ / (dielectric.val * r.val) * Real.exp (-κ * r.val)
```
### 实际依赖 MD.Ch01.yukawaScreened_corrected_a
```lean
def yukawaScreened_corrected_a (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric κ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-κ.val*r.val)
```
### 实际依赖 MD.Ch01.yukawaScreened_corrected_b
```lean
def yukawaScreened_corrected_b (C : {x : ℝ // 0 < x}) (Qᵢ Qⱼ : ℝ)
    (dielectric ℓ r : {x : ℝ // 0 < x}) : ℝ :=
  C.val*Qᵢ*Qⱼ/(dielectric.val*r.val)*Real.exp (-r.val/ℓ.val)
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.2-AngleBond",
  "kind": "definition",
  "label": null,
  "section": "1.1.2",
  "printed_page": "13",
  "pdf_page": "36",
  "statement_latex": "When a trio of atoms with labels $i,j,k$ and $k$ admits a pair of length bonds, say $(i,j)$ and $(j,k)$, then an additional three-body term will need to be incorporated:\n\\[\\varphi_{ijk}^{\\mathrm{ang}}=\\frac{k_{ijk}^{\\mathrm{ang}}}{2}(\\theta_{ijk}-\\theta_{ijk}^0)^2,\\]\nwhere the angle $\\theta_{ijk}$ is given in terms of the positions as\n\\[\\theta_{ijk}=\\arccos\\frac{(\\boldsymbol q_i-\\boldsymbol q_j)\\cdot(\\boldsymbol q_j-\\boldsymbol q_k)}{r_{ij}r_{jk}}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "k正、两键长非零；保留原页(qᵢ-qⱼ)·(qⱼ-qₖ)方向及重复and k。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.angleBondModel",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-028",
    "CH01-029"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.angleBondModel
```lean
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.2-GayBerne",
  "kind": "definition",
  "label": "Example 1.2",
  "section": "1.1.2",
  "printed_page": "16–17",
  "pdf_page": "39–40",
  "statement_latex": "The potential energy may be written as\n\\[\\varphi_{\\mathrm{GB}}(\\boldsymbol q_1,\\boldsymbol q_2,\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=4\\epsilon_{\\mathrm{GB}}\\left[\\left(\\frac{\\sigma_0}{\\Delta}\\right)^{12}-\\left(\\frac{\\sigma_0}{\\Delta}\\right)^6\\right],\\]\n\\[\\epsilon_{\\mathrm{GB}}(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=\\epsilon_1(\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)\\epsilon_2(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2),\\]\nwith\n\\[\\Delta(\\boldsymbol r,\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=\\|\\boldsymbol r\\|-\\sigma_0/\\sqrt{W(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2,\\chi)},\\]\n\\[\\epsilon_1(\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=\\epsilon_0[1-\\chi^2(\\hat{\\boldsymbol u}_1\\cdot\\hat{\\boldsymbol u}_2)^2]^{-1/2},\\qquad\\epsilon_2(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2)=W(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2,\\chi'),\\]\nand\n\\[W(\\hat{\\boldsymbol r},\\hat{\\boldsymbol u}_1,\\hat{\\boldsymbol u}_2,\\chi)\\stackrel{\\mathrm{def}}=1-\\frac\\chi2\\left[\\frac{(\\hat{\\boldsymbol r}\\cdot(\\hat{\\boldsymbol u}_1+\\hat{\\boldsymbol u}_2))^2}{1+\\chi\\hat{\\boldsymbol u}_1\\cdot\\hat{\\boldsymbol u}_2}+\\frac{(\\hat{\\boldsymbol r}\\cdot(\\hat{\\boldsymbol u}_1-\\hat{\\boldsymbol u}_2))^2}{1-\\chi\\hat{\\boldsymbol u}_1\\cdot\\hat{\\boldsymbol u}_2}\\right].\\]\nFinally\n\\[\\chi=\\frac{[\\sigma_e/\\sigma_s]^2-1}{[\\sigma_e/\\sigma_s]^2+1},\\qquad\\chi'=\\frac{1-[\\epsilon_e/\\epsilon_s]^{1/\\mu}}{1+[\\epsilon_e/\\epsilon_s]^{1/\\mu}}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$\\boldsymbol r=\\boldsymbol q_{12}=\\boldsymbol q_2-\\boldsymbol q_1$；$\\hat{\\boldsymbol r}=\\boldsymbol r/\\|\\boldsymbol r\\|$；两取向单位向量；各根号正、分母非零。",
    "放大PDF39原页确认εGB=ε1ε2，无平方；旧库gayBerneWell有ε2²，不能桥接，Blueprint保留忠实公式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.gayBerneModel",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-035",
    "CH01-036",
    "CH01-037",
    "CH01-038",
    "CH01-039",
    "CH01-040",
    "CH01-041",
    "CH01-042",
    "CH01-043"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)

/- END FULL SECTION 1.1 -/

/- BEGIN FULL SECTION 1.2 -/
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MolecularDynamics.Chapter01Review.gayBerneChi
```lean
def gayBerneChi (σₑ σₛ : ℝ) := ((σₑ/σₛ)^2-1)/((σₑ/σₛ)^2+1)
```
### 实际依赖 MolecularDynamics.Chapter01Review.gayBerneChiPrime
```lean
def gayBerneChiPrime (εₑ εₛ μ : ℝ) :=
  (1-Real.rpow (εₑ/εₛ) (1/μ))/(1+Real.rpow (εₑ/εₛ) (1/μ))
```
### 实际依赖 MolecularDynamics.Chapter01Review.gayBerneEpsilonOne
```lean
def gayBerneEpsilonOne (ε₀ χ : ℝ) (u₁ u₂ : V3) :=
  ε₀ / Real.sqrt (1-χ^2*(inner ℝ u₁ u₂)^2)
```
### 实际依赖 MolecularDynamics.Chapter01Review.gayBerneEpsilonTwo
```lean
def gayBerneEpsilonTwo (r u₁ u₂ : V3) (χ' : ℝ) := gayBerneW r u₁ u₂ χ'
```
### 实际依赖 MD.Ch01.gayBerneModel
```lean
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.gayBerneW
```lean
def gayBerneW (r u₁ u₂ : V3) (χ : ℝ) :=
  1 - χ/2 * ((inner ℝ r (u₁+u₂))^2/(1+χ*inner ℝ u₁ u₂) +
    (inner ℝ r (u₁-u₂))^2/(1-χ*inner ℝ u₁ u₂))
```
