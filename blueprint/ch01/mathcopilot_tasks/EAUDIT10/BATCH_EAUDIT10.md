# EAUDIT10：第1章§1.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.1-Schrodinger",
  "kind": "definition",
  "label": null,
  "section": "1.1",
  "printed_page": "5",
  "pdf_page": "28",
  "statement_latex": "The Schrödinger equation itself is a partial differential equation of the following form:\n\\[i\\hbar\\frac{\\partial\\Phi}{\\partial t}=-\\hbar^2\\sum_{j=1}^{13}\\frac{1}{2\\mu_j}\\left(\\frac{\\partial^2\\Phi}{\\partial q_{j,x}^2}+\\frac{\\partial^2\\Phi}{\\partial q_{j,y}^2}+\\frac{\\partial^2\\Phi}{\\partial q_{j,z}^2}\\right)+U_P(q_{1,x},q_{1,y},\\ldots,q_{13,z})\\Phi.\\tag{1.1}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$\\Phi:\\mathbb R\\times\\mathbb R^{39}\\to\\mathbb C$；$i^2=-1$；$\\hbar$为Planck常数；$\\mu_j$为第$j$粒子质量；$U_P$为原始原子势能。13粒子来自10电子+3核水分子示例。"
  ],
  "review_status": "CORRECTED",
  "issues": [
    {
      "code": "CONTEXT_LATEX_OVERESCAPED",
      "detail": "BATCH02.md与ch01_source.json中的本条完全一致，但context_notation的数学命令被重复转义；这是上下文表示问题，不是原书公式错误。",
      "status": "local_verified",
      "receipt": "BATCH02_result.json"
    }
  ],
  "lean_decl": "MD.Ch01.schrodingerEquation",
  "extra_assumptions": [
    "正质量及正Planck参数；按经典解解释，Φ在时间/位置联合C2，保证总导数算子表示实际偏导数；不声明解存在。",
    "[EXTRA] 19号：按EAUDIT02新返回，将联合全域C²改为连续时间一阶/逐空间坐标二阶经典导数；不要求二阶时间或混合偏导。"
  ],
  "old_ids": [
    "CH01-001",
    "CH01-002",
    "CH01-003",
    "CH01-004",
    "CH01-005",
    "CH01-006"
  ],
  "source_page_verification": "VERIFIED_RENDERED; 2026-10-13 PDF28; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  (∀ q, ContDiff ℝ 1 (fun t => Φ t q)) ∧
  (∀ t q (i : Fin 39), ContDiff ℝ 2 (fun s : ℝ => Φ t (q + s • coordinateDirection i))) ∧
  Continuous (fun tq : ℝ × Q13 => deriv (fun t => Φ t tq.2) tq.1) ∧
  (∀ i, Continuous (fun tq : ℝ × Q13 => secondPartial (Φ tq.1) tq.2 i)) ∧
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.Q13
```lean
abbrev Q13 := Position 39
```
### 实际依赖 MolecularDynamics.Chapter01Review.coordinateDirection
```lean
def coordinateDirection {n : ℕ} (i : Fin n) : Position n :=
  WithLp.toLp 2 (fun j => if j = i then 1 else 0)
```
### 实际依赖 MolecularDynamics.Chapter01Review.planckConstant
```lean
abbrev planckConstant := {h : ℝ // 0 < h}
```
### 实际依赖 MolecularDynamics.Chapter01Review.primitivePotential
```lean
abbrev primitivePotential := Q13 → ℝ
```
### 实际依赖 MolecularDynamics.Chapter01Review.quantumMass
```lean
abbrev quantumMass := Fin 13 → {m : ℝ // 0 < m}
```
### 实际依赖 MD.Ch01.schrodingerEquation
```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  (∀ q, ContDiff ℝ 1 (fun t => Φ t q)) ∧
  (∀ t q (i : Fin 39), ContDiff ℝ 2 (fun s : ℝ => Φ t (q + s • coordinateDirection i))) ∧
  Continuous (fun tq : ℝ × Q13 => deriv (fun t => Φ t tq.2) tq.1) ∧
  (∀ i, Continuous (fun tq : ℝ × Q13 => secondPartial (Φ tq.1) tq.2 i)) ∧
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q

/-- source_id: MD-1.1-NewtonModel · definition · printed p.6 / PDF p.29
[EXTRA] EAUDIT02: positive particle masses repeated over exactly three coordinates;
```
### 实际依赖 MolecularDynamics.Chapter01Review.secondPartial
```lean
def secondPartial {n : ℕ} (f : Position n → ℂ) (q : Position n) (i : Fin n) : ℂ :=
  deriv (deriv (fun s : ℝ => f (q + s • coordinateDirection i))) 0
```
### 实际依赖 MolecularDynamics.Chapter01Review.waveFunction
```lean
abbrev waveFunction := ℝ → Q13 → ℂ
```

## 原文JSON
```json
{
  "source_id": "MD-1.1-HardSphere",
  "kind": "definition",
  "label": null,
  "section": "1.1",
  "printed_page": "7",
  "pdf_page": "30",
  "statement_latex": "The simplest model for a molecular interaction potential is the hard-sphere model. We assume that each atom is an impenetrable sphere which interacts with other atoms via perfectly elastic collision with the atoms transferring, according to standard rules, momentum and energy to one another during the collisions.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "APPROVED",
  "issues": [],
  "lean_decl": "MD.Ch01.hardSphereModel",
  "extra_assumptions": [
    "[历史签名，EAUDIT02已替换] 只编码不可穿透与完全弹性守恒关系；原文未指定碰撞散射规则，此定义不唯一决定碰撞后速度。",
    "[EXTRA] EAUDIT02：以标准无摩擦孤立二体弹性碰撞展开standard rules；同时多接触需另有规则。碰撞时刻在整个开放时间域局部孤立，排除稠密事件集使动力学真空化；全粒子对全时间不可穿透；位置连续，碰撞外真实自由运动；实际速度左右极限接入法向冲量、法向速度反转、碰后分离及全部动量/动能守恒。旧只含瞬时必要守恒关系的说明为历史版本。"
  ],
  "old_ids": [
    "CH01-010"
  ],
  "source_page_verification": "VERIFIED_RENDERED; 2026-10-13 PDF30; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hardSphereModel {N : ℕ} (R m : Fin N → ℝ) (I C : Set ℝ)
    (q v before after : ℝ → Fin N → V3) (pair : ℝ → Fin N × Fin N) : Prop :=
  (∀ i, 0 < R i ∧ 0 < m i) ∧ IsOpen I ∧ IsPreconnected I ∧ C ⊆ I ∧
  (∀ t ∈ I, ∃ δ > 0, ∀ s ∈ I, |s - t| < δ → s ∈ C → s = t) ∧
  (∀ t ∈ I, ∀ i j, i ≠ j → R i + R j ≤ dist (q t i) (q t j)) ∧
  (∀ i, ContinuousOn (fun t => q t i) I) ∧
  (∀ t ∈ I \ C, ∀ i,
    HasDerivAt (fun s => q s i) (v t i) t ∧
    HasDerivAt (fun s => v s i) (0 : V3) t) ∧
  (∀ t ∈ C,
    let i := (pair t).1
    let j := (pair t).2
    i ≠ j ∧
    binaryElasticSphereCollision (R i) (R j) (m i) (m j)
      (q t i) (q t j) (before t i) (before t j) (after t i) (after t j) ∧
    (∀ k, Tendsto (fun s => v s k) (𝓝[I ∩ Iio t] t) (𝓝 (before t k)) ∧
      Tendsto (fun s => v s k) (𝓝[I ∩ Ioi t] t) (𝓝 (after t k))) ∧
    (∀ k, k ≠ i → k ≠ j → after t k = before t k))
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.binaryElasticSphereCollision
```lean
def binaryElasticSphereCollision (R₁ R₂ m₁ m₂ : ℝ)
    (q₁ q₂ v₁ v₂ w₁ w₂ : V3) : Prop :=
  dist q₁ q₂ = R₁ + R₂ ∧
  let normal := (‖q₂ - q₁‖⁻¹) • (q₂ - q₁)
  0 ≤ inner ℝ (v₁ - v₂) normal ∧
  w₁ = v₁ - (2 * m₂ / (m₁ + m₂) * inner ℝ (v₁ - v₂) normal) • normal ∧
  w₂ = v₂ + (2 * m₁ / (m₁ + m₂) * inner ℝ (v₁ - v₂) normal) • normal ∧
  inner ℝ (w₁ - w₂) normal = -inner ℝ (v₁ - v₂) normal ∧
  inner ℝ (w₂ - w₁) normal ≥ 0 ∧
  m₁ • v₁ + m₂ • v₂ = m₁ • w₁ + m₂ • w₂ ∧
  m₁ * ‖v₁‖^2 / 2 + m₂ * ‖v₂‖^2 / 2 =
    m₁ * ‖w₁‖^2 / 2 + m₂ * ‖w₂‖^2 / 2

-- EAUDIT03: original radial profile retained as an auxiliary.
```
### 实际依赖 MD.Ch01.hardSphereModel
```lean
def hardSphereModel {N : ℕ} (R m : Fin N → ℝ) (I C : Set ℝ)
    (q v before after : ℝ → Fin N → V3) (pair : ℝ → Fin N × Fin N) : Prop :=
  (∀ i, 0 < R i ∧ 0 < m i) ∧ IsOpen I ∧ IsPreconnected I ∧ C ⊆ I ∧
  (∀ t ∈ I, ∃ δ > 0, ∀ s ∈ I, |s - t| < δ → s ∈ C → s = t) ∧
  (∀ t ∈ I, ∀ i j, i ≠ j → R i + R j ≤ dist (q t i) (q t j)) ∧
  (∀ i, ContinuousOn (fun t => q t i) I) ∧
  (∀ t ∈ I \ C, ∀ i,
    HasDerivAt (fun s => q s i) (v t i) t ∧
    HasDerivAt (fun s => v s i) (0 : V3) t) ∧
  (∀ t ∈ C,
    let i := (pair t).1
    let j := (pair t).2
    i ≠ j ∧
    binaryElasticSphereCollision (R i) (R j) (m i) (m j)
      (q t i) (q t j) (before t i) (before t j) (after t i) (after t j) ∧
    (∀ k, Tendsto (fun s => v s k) (𝓝[I ∩ Iio t] t) (𝓝 (before t k)) ∧
      Tendsto (fun s => v s k) (𝓝[I ∩ Ioi t] t) (𝓝 (after t k))) ∧
    (∀ k, k ≠ i → k ≠ j → after t k = before t k))
```
