# EAUDIT03：第1章§1.1.1网站修复及真实依赖复审

## 原文JSON
```json
{
  "source_id": "MD-1.1.1-Multibody",
  "kind": "definition",
  "label": null,
  "section": "1.1.1",
  "printed_page": "8",
  "pdf_page": "31",
  "statement_latex": "In the most common situations, the potential energy function consists of a sum of 2-body, 3-body and/or 4-body terms,\n\\[U_{ij}(\\boldsymbol q_i,\\boldsymbol q_j),\\qquad U_{ijk}(\\boldsymbol q_i,\\boldsymbol q_j,\\boldsymbol q_k),\\qquad U_{ijkl}(\\boldsymbol q_i,\\boldsymbol q_j,\\boldsymbol q_k,\\boldsymbol q_l),\\]\nwhere $\\boldsymbol q_i$ is the position vector of atom $i$ such that $(q_{i,x},q_{i,y},q_{i,z})=\\boldsymbol q_i\\in\\mathbb R^3$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.multibodyPotential",
  "extra_assumptions": [
    "按无序不同粒子组计数i<j<k<l；原文仅列成分未指定求和计数约定。",
    "[EXTRA] EAUDIT03补真实V3=Position 3=EuclideanSpace ℝ(Fin 3)及求和依赖，仅补材料，不改多体定义。"
  ],
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T19:56:14.250068",
      "before_sha256": "a8936eba6c279b25597c34ec454fe8cd4802cf9a2e2895d10442f6fe12813c23",
      "after_sha256": "a8936eba6c279b25597c34ec454fe8cd4802cf9a2e2895d10442f6fe12813c23",
      "changed_fields": [],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH03_result.json",
      "raw_sha256": "5a2eea461e6d03d433d23ed6bdd5870a8da8192b9f0da86bbe0ade99cff9a565",
      "reason": "原PDF31–34逐页视觉核对；长度键删除原多出的the；两条签名补全部曲率/粒子距离；两条补真实依赖；LJ经验语义待导师。"
    }
  ],
  "old_ids": [
    "CH01-011",
    "CH01-012",
    "CH01-013",
    "CH01-014"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 当前完整Lean
```lean
def multibodyPotential {N : ℕ} (U₂ : Fin N → Fin N → V3 → V3 → ℝ)
    (U₃ : Fin N → Fin N → Fin N → V3 → V3 → V3 → ℝ)
    (U₄ : Fin N → Fin N → Fin N → Fin N → V3 → V3 → V3 → V3 → ℝ)
    (q : Fin N → V3) : ℝ :=
  (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, ∑ l ∈ Finset.Ioi k,
    U₄ i j k l (q i) (q j) (q k) (q l))
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.multibodyPotential
```lean
def multibodyPotential {N : ℕ} (U₂ : Fin N → Fin N → V3 → V3 → ℝ)
    (U₃ : Fin N → Fin N → Fin N → V3 → V3 → V3 → ℝ)
    (U₄ : Fin N → Fin N → Fin N → Fin N → V3 → V3 → V3 → V3 → ℝ)
    (q : Fin N → V3) : ℝ :=
  (∑ i, ∑ j ∈ Finset.Ioi i, U₂ i j (q i) (q j)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, U₃ i j k (q i) (q j) (q k)) +
  (∑ i, ∑ j ∈ Finset.Ioi i, ∑ k ∈ Finset.Ioi j, ∑ l ∈ Finset.Ioi k,
    U₄ i j k l (q i) (q j) (q k) (q l))
```

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
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T19:56:14.250068",
      "before_sha256": "76f09cbc4cd011f5336d8919582679d28fca6a28ed647828dcb4e266b38a6428",
      "after_sha256": "76f09cbc4cd011f5336d8919582679d28fca6a28ed647828dcb4e266b38a6428",
      "changed_fields": [],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH03_result.json",
      "raw_sha256": "5a2eea461e6d03d433d23ed6bdd5870a8da8192b9f0da86bbe0ade99cff9a565",
      "reason": "原PDF31–34逐页视觉核对；长度键删除原多出的the；两条签名补全部曲率/粒子距离；两条补真实依赖；LJ经验语义待导师。"
    }
  ],
  "old_ids": [
    "CH01-016"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 当前完整Lean
```lean
theorem morse_minimum :
  ∀ D a rₑ : ℝ, 0 < D → 0 < a → 0 < rₑ →
    (∀ r > 0, 0 ≤ morsePotential D a rₑ r) ∧
    morsePotential D a rₑ rₑ = 0 ∧ Tendsto (morsePotential D a rₑ) atTop (𝓝 D) ∧
    deriv (deriv (morsePotential D a rₑ)) rₑ = 2*D*a^2 ∧
    (∀ a₁ a₂ : ℝ, 0 < a₁ → a₁ < a₂ →
      deriv (deriv (morsePotential D a₁ rₑ)) rₑ < deriv (deriv (morsePotential D a₂ rₑ)) rₑ)
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
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T19:56:14.250068",
      "before_sha256": "b1b953df47ebd7a1a71f2ef52caeb2c7a3823a5f2a5b8c3525ca131cd7ee153d",
      "after_sha256": "c9ab6013c5df63a1d7377e4afe01d2ea4a6bd5e719a37c88f4b0e2f705d43b6d",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH03_result.json",
      "raw_sha256": "5a2eea461e6d03d433d23ed6bdd5870a8da8192b9f0da86bbe0ade99cff9a565",
      "reason": "原PDF31–34逐页视觉核对；长度键删除原多出的the；两条签名补全部曲率/粒子距离；两条补真实依赖；LJ经验语义待导师。"
    }
  ],
  "old_ids": [
    "CH01-017",
    "CH01-018"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 当前完整Lean
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
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T19:56:14.250068",
      "before_sha256": "e24cbaf865c2e7d34c0ff16ef534a6d872225dc62539851a1ae3efb243732098",
      "after_sha256": "e24cbaf865c2e7d34c0ff16ef534a6d872225dc62539851a1ae3efb243732098",
      "changed_fields": [],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH04_result.json",
      "raw_sha256": "5941619e97b3355cd8f77b1243fca72cc469320afd27458cc8129f92346bdf1e",
      "reason": "原PDF31–34逐页视觉核对；长度键删除原多出的the；两条签名补全部曲率/粒子距离；两条补真实依赖；LJ经验语义待导师。"
    }
  ],
  "old_ids": [
    "CH01-023"
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 当前完整Lean
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
