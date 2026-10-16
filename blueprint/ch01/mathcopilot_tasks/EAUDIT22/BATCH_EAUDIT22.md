# EAUDIT22：第1章§1.7.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.7.1-ChaosConditions",
  "kind": "definition",
  "label": null,
  "section": "1.7.1",
  "printed_page": "41–42",
  "pdf_page": "64–65",
  "statement_latex": "Typical definitions of a “chaotic dynamical system” [103] require at least the following conditions to be satisfied on the phase space $D$:\n• The solutions depend sensitively on the initial data taken from $D$;\n• The flow is topologically transitive in $D$.\nThe second condition states that given arbitrarily small neighborhoods $D_1$ and $D_2$ of two different points in $D$ then it is possible to find a trajectory that goes from some point of $D_1$ to some point of $D_2$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.chaosConditions",
  "extra_assumptions": [
    "敏感依赖以固定可见分离量ε、任意δ近邻的标准量词解释；原文说明without being entirely formal，未指定这个严格ε/δ版本。",
    "topologicalTransitivity使用相对开集和非负时间，D须流不变才能解释为相域。"
  ],
  "old_ids": [
    "CH01-183",
    "CH01-184",
    "CH01-185"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.chaosConditions
```lean
def chaosConditions {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  sensitiveDependence F D ∧ topologicalTransitivity F D
```
### 实际依赖 MolecularDynamics.Chapter01Review.sensitiveDependence
```lean
def sensitiveDependence {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∃ ε > 0, ∀ x ∈ D, ∀ δ > 0, ∃ y ∈ D, dist x y < δ ∧
    ∃ t ≥ 0, ε ≤ dist (F t x) (F t y)
```
### 实际依赖 MolecularDynamics.Chapter01Review.topologicalTransitivity
```lean
def topologicalTransitivity {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∀ U V : Set (Position n), IsOpen U → IsOpen V → (U ∩ D).Nonempty →
    (V ∩ D).Nonempty → ∃ t ≥ 0, ∃ x ∈ U ∩ D, F t x ∈ V ∩ D
```

## 原文JSON
```json
{
  "source_id": "MD-1.7.1-TransitivityErgodicityLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7.1",
  "printed_page": "42",
  "pdf_page": "65",
  "statement_latex": "We will see later that this concept, which is essentially equivalent to ergodicity, is a crucial component of molecular theories.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "拓扑传递和给定测度遍历通常不等价；μ=0时identity流遍历为真而传递为假。非退化概率测度也需进一步限定。"
    }
  ],
  "lean_decl": "MD.Ch01.transitivityergodicityliteral",
  "extra_assumptions": [
    "为表达ergodicity必须引入原文此处未给的不变测度μ；F为连续真实流。"
  ],
  "old_ids": [
    "CH01-186"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem transitivityergodicityliteral :
  ∀ (n : ℕ) (f : Position n → Position n)
    (F : ℝ → Position n → Position n) (μ : Measure (Position n)),
    isFlowOf f F → Continuous (Function.uncurry F) →
    (∀ t, MeasurePreserving (F t) μ μ) →
    (topologicalTransitivity F univ ↔ flowErgodic F μ) := by
  sorry

/-- 修正版，对应原文 MD-1.7.1-TransitivityErgodicityLiteral，改动：改为有限、满支撑不变测度下的遍历性⇒拓扑传递单向结论。 -/
theorem transitivityergodicityliteral_corrected {n : ℕ}
    (f : Position n → Position n) (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) [IsFiniteMeasure μ]
    (hf : ContDiff ℝ 1 f) (hflow : isFlowOf f F) (hcont : Continuous (Function.uncurry F))
    (hfull : ∀ U : Set (Position n), IsOpen U → U.Nonempty → μ U ≠ 0)
    (he : flowErgodic F μ) : topologicalTransitivity F univ := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.flowErgodic
```lean
def flowErgodic {n : ℕ} (F : ℝ → Position n → Position n)
    (μ : Measure (Position n)) : Prop :=
  (∀ t, MeasurePreserving (F t) μ μ) ∧
  ∀ S : Set (Position n), MeasurableSet S →
    (∀ t, F t ⁻¹' S = S) → μ S = 0 ∨ μ Sᶜ = 0
```
### 实际依赖 MolecularDynamics.Chapter01Review.isFlowOf
```lean
def isFlowOf {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ x, F 0 x = x) ∧ ∀ x t, HasDerivAt (fun s => F s x) (f (F t x)) t
```
### 实际依赖 MolecularDynamics.Chapter01Review.topologicalTransitivity
```lean
def topologicalTransitivity {n : ℕ} (F : ℝ → Position n → Position n) (D : Set (Position n)) : Prop :=
  ∀ U V : Set (Position n), IsOpen U → IsOpen V → (U ∩ D).Nonempty →
    (V ∩ D).Nonempty → ∃ t ≥ 0, ∃ x ∈ U ∩ D, F t x ∈ V ∩ D
```

## 原文JSON
```json
{
  "source_id": "MD-1.7.1-AnisotropicOscillator",
  "kind": "definition",
  "label": "Example 1.9 (Anisotropic Oscillator)",
  "section": "1.7.1",
  "printed_page": "42",
  "pdf_page": "65",
  "statement_latex": "Consider the system with energy\n\\[E(x,y,\\dot x,\\dot y)=\\frac12(\\dot x^2+\\dot y^2)+\\frac{\\kappa(c_3)}2(r-l(c_3))^2,\\qquad r=\\sqrt{x^2+y^2},\\tag{1.9}\\]\nwhere\n\\[c_3=\\cos(3\\theta)\\]\nis defined in terms of the angular coordinate of the position $(x,y)$ with respect to the $(1,0)$-direction,\n\\[\\cos\\theta=c=\\frac xr,\\qquad c_3=4c^3-3c,\\]\nand we have defined\n\\[\\kappa(c_3)=\\kappa_0(1-\\tfrac12\\epsilon c_3),\\qquad l(c_3)=l_0(1+\\tfrac12\\epsilon c_3).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "anisotropicAngular及anisotropicParameters是本定义依赖公式；r>0；c3三倍角关系须单独核对。",
    "原文κ按PDF字形抄；数值实验κ₀=l₀=1、ε变化不转成全称轨迹定理。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.anisotropicEnergy",
  "extra_assumptions": [
    "定义在r=0用Lean总函数延拓，物理域r>0。"
  ],
  "old_ids": [
    "CH01-187",
    "CH01-188",
    "CH01-189"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicAngular
```lean
def anisotropicAngular (x y : ℝ) :=
  let c := x/Real.sqrt (x^2+y^2)
  4*c^3-3*c
```
### 实际依赖 MD.Ch01.anisotropicEnergy
```lean
def anisotropicEnergy (κ₀ l₀ ε x y v w : ℝ) :=
  let p := anisotropicParameters κ₀ l₀ ε (anisotropicAngular x y)
  (v^2+w^2)/2+p.1/2*(Real.sqrt (x^2+y^2)-p.2)^2
```
### 实际依赖 MolecularDynamics.Chapter01Review.anisotropicParameters
```lean
def anisotropicParameters (κ₀ l₀ ε c₃ : ℝ) : ℝ × ℝ :=
  (κ₀*(1-ε*c₃/2),l₀*(1+ε*c₃/2))
```
