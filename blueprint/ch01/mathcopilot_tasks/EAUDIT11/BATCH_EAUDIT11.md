# EAUDIT11：第1章§1.1.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.1.1-MorseMinimum",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.1.1",
  "printed_page": "8",
  "pdf_page": "31",
  "statement_latex": "(See Fig. 1.5.) $r_e$ is the location of the minimum, $D$ gives the well depth, and $a$ is a shape parameter that can be used to control the curvature at the minimum.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "a controls curvature为定性形状参数说明，合并为Morse定义背景；原页无二阶导数公式，不凭计算添加原文公式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.morse_minimum",
  "extra_assumptions": [
    "D,a,rₑ正；well depth解释为无穷远极限减最小值。",
    "[EXTRA] EAUDIT03补原曲率子句的实际展开φ″(rₑ)=2Da²，并表达固定D>0时正a增大曲率严格增大；公式为形式化展开，不回填成教材原句。"
  ],
  "old_ids": [
    "CH01-016"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem morse_minimum :
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D) ∧
    deriv (deriv (morsePotential D a rₑ)) rₑ = 2*D*a^2 ∧
    (∀ a₁ a₂ : ℝ, 0 < a₁ → a₁ < a₂ →
      deriv (deriv (morsePotential D a₁ rₑ)) rₑ < deriv (deriv (morsePotential D a₂ rₑ)) rₑ) := by
  sorry
```
### 实际依赖 MD.Ch01.morsePotential
```lean
def morsePotential (D a rₑ r : ℝ) := D * (1 - Real.exp (-a * (r-rₑ)))^2
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.1-LengthBond",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "9",
  "pdf_page": "32",
  "statement_latex": "Because they often do not need to be allowed to break during simulation and are very strong compared to other potential terms, chemical bonds such as the covalent $\\mathrm H_2^+$ bond described above are sometimes treated as springs with given rest-length:\n\\[\\varphi_{ij}^{\\mathrm{len}}(r_{ij})=\\frac{k_{ij}^{\\mathrm{len}}}{2}(r_{ij}-r_{ij}^0)^2,\\qquad r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|$；Lean pairDistance；$k>0$，$r_0$静长。"
  ],
  "review_status": "CORRECTED",
  "issues": [],
  "lean_decl": "MD.Ch01.lengthBond",
  "extra_assumptions": [
    "[EXTRA] EAUDIT03保留原径向剖面为lengthBondRadial；主定义以真实三维粒子位置为参数，rᵢⱼ=‖qᵢ−qⱼ‖代入原弹簧能。"
  ],
  "old_ids": [
    "CH01-017",
    "CH01-018"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def lengthBond (k r₀ : ℝ) (qᵢ qⱼ : V3) := k / 2 * (‖qᵢ-qⱼ‖-r₀)^2
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.lengthBond
```lean
def lengthBond (k r₀ : ℝ) (qᵢ qⱼ : V3) := k / 2 * (‖qᵢ-qⱼ‖-r₀)^2
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.1-LJRepulsion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.1.1",
  "printed_page": "10–11",
  "pdf_page": "33–34",
  "statement_latex": "Because of the strongly repulsive character of short-ranged soft walls in molecular dynamics, i.e., the fact that $\\varphi_{\\mathrm{LJ}}$ tends rapidly to positive infinity as $r\\to0$, the atoms remain well separated in long simulations. The singularity at $r=0$ is therefore rarely encountered in dynamics trajectories, however the presence of the singularity may nonetheless create problems for mathematical analysis, as many theoretical techniques rely on assumed smoothness.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "数学结论是原文r→0极限；长模拟保持分离为定性经验，不升级为有限能量全局无碰撞定理。",
    "EAUDIT03：精确LJ单侧极限保留；“long simulations/well separated/rarely”尚无算法、时间段和概率频率语义，经验叙述覆盖未完成，供导师裁定，不能推为无条件全局无碰撞。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.lj_repulsion",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-022"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem lj_repulsion :
  ∀ ε σ : ℝ, 0 < ε → 0 < σ →
    Tendsto (lennardJonesPotential ε σ) (𝓝[>] 0) atTop := by
  intro ε σ hε hσ
  have h₁ : Tendsto (fun r : ℝ => σ/r) (𝓝[>] (0:ℝ)) atTop := by
    simpa [div_eq_mul_inv] using (tendsto_inv_nhdsGT_zero (𝕜 := ℝ)).const_mul_atTop hσ
  have h₂ : Tendsto (fun r : ℝ => (σ/r)^6) (𝓝[>] (0:ℝ)) atTop := by
    simpa only [Function.comp_def] using (tendsto_pow_atTop (by decide : (6:ℕ) ≠ 0)).comp h₁
  have h₃ : Tendsto (fun r : ℝ => 2*(σ/r)^6-1) (𝓝[>] (0:ℝ)) atTop := by
    simpa only [sub_eq_add_neg] using (h₂.const_mul_atTop (by norm_num : (0:ℝ) < 2)).atTop_add
      (tendsto_const_nhds (x := (-1:ℝ)))
  have h₄ : Tendsto (fun r : ℝ => ε*(2*(σ/r)^6-1)^2-ε) (𝓝[>] (0:ℝ)) atTop := by
    simpa only [Function.comp_def, sub_eq_add_neg] using
      (((tendsto_pow_atTop (by decide : (2:ℕ) ≠ 0)).comp h₃).const_mul_atTop hε).atTop_add
        (tendsto_const_nhds (x := -ε))
  convert h₄ using 1
  funext r
  unfold lennardJonesPotential
  ring

/-- 修正版，对应原文 MD-1.1.1-LJRepulsion，改动：保留已证单侧极限；把可严格陈述的内容写成任意有限能级对应正距离屏障，不声称数值模拟rarely的概率。 -/
theorem lj_repulsion_corrected (ε σ : ℝ) (hε : 0 < ε) (hσ : 0 < σ) (E : ℝ) :
    ∃ δ > 0, ∀ r ∈ Ioo 0 δ, E < lennardJonesPotential ε σ r := by
  have h := (lj_repulsion ε σ hε hσ).eventually (eventually_gt_atTop E)
  obtain ⟨δ,hδ,hh⟩ := mem_nhdsGT_iff_exists_Ioo_subset.mp h
  exact ⟨δ,hδ,fun r hr => hh hr⟩
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

## 原文JSON
```json
{
  "source_id": "MD-1.1.1-HeterogeneousLJ",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "11",
  "pdf_page": "34",
  "statement_latex": "When there are many atoms of different types, the parameters of the potential will depend on this, so we obtain contributions to the total potential energy of the form\n\\[\\varphi_{ij}^{\\mathrm{LJ}}(r_{ij})=4\\epsilon_{ij}\\left[\\left(\\frac{\\sigma_{ij}}{r_{ij}}\\right)^{12}-\\left(\\frac{\\sigma_{ij}}{r_{ij}}\\right)^6\\right],\\]\nwhere $r_{ij}=\\|\\boldsymbol q_i-\\boldsymbol q_j\\|$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.heterogeneousLJ",
  "extra_assumptions": [
    "[EXTRA] EAUDIT03补真实V3和pairDistance=‖qᵢ−qⱼ‖；总函数公式对应域为pairDistance>0，零距离的总化取值不解释为物理势。"
  ],
  "old_ids": [
    "CH01-023"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.heterogeneousLJ
```lean
def heterogeneousLJ {N : ℕ} (ε σ : Fin N → Fin N → ℝ)
    (q : Fin N → V3) (i j : Fin N) :=
  lennardJonesPotential (ε i j) (σ i j) (pairDistance (q i) (q j))
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```
