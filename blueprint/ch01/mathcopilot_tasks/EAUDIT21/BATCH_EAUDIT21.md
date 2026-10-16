# EAUDIT21：第1章§1.7网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.7-IsoscelesEnergyReduction",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "39",
  "pdf_page": "62",
  "statement_latex": "reducing the energy to\n\\[E=\\dot x^2+\\frac{\\dot y^2}{3}+2\\hat\\varphi_{\\mathrm{LJ}}\\left(\\sqrt{x^2+y^2}\\right)+\\hat\\varphi_{\\mathrm{LJ}}(2x),\\]\nwhich describes the vibrational motion.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.isosceles_energy_reduction",
  "extra_assumptions": [
    "单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。"
  ],
  "old_ids": [
    "CH01-181"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w := by
  have h01 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 1 =
      WithLp.toLp 2 ![2*x,0,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h02 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h12 : isoscelesCoordinates x y 1-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![-x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have hsq (z : V3) : ‖z‖^2 = (z 0)^2+(z 1)^2+(z 2)^2 := by
    simpa only [Fin.sum_univ_three,Real.norm_eq_abs,sq_abs] using
      PiLp.norm_sq_eq_of_L2 (fun _ : Fin 3 => ℝ) z
  have hn (a b : ℝ) : ‖(WithLp.toLp 2 ![a,b,0] : V3)‖ = Real.sqrt (a^2+b^2) := by
    rw [norm_eq_sqrt_real_inner,real_inner_self_eq_norm_sq,hsq]
    simp
  have hK : (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) = v^2+w^2/3 := by
    simp only [Fin.sum_univ_three,hsq]
    simp [isoscelesCoordinates]
    ring
  have h0 : Finset.Ioi (0:Fin 3) = {1,2} := by decide
  have h1 : Finset.Ioi (1:Fin 3) = {2} := by decide
  have h2 : Finset.Ioi (2:Fin 3) = ∅ := by decide
  rw [hK]
  unfold uniformLJEnergy
  simp only [Fin.sum_univ_three,h0,h1,h2,Finset.sum_singleton,Finset.sum_empty]
  rw [Finset.sum_pair (show (1:Fin 3) ≠ 2 by decide)]
  simp [pairDistance,h01,h02,h12,hn,Real.sqrt_sq_eq_abs,abs_of_pos hx,abs_mul,
    isoscelesEnergy,isoscelesPotential]
  ring
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.isoscelesCoordinates
```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
```
### 实际依赖 MolecularDynamics.Chapter01Review.isoscelesEnergy
```lean
def isoscelesEnergy (x y v w : ℝ) := v^2 + w^2/3 + isoscelesPotential x y
```
### 实际依赖 MolecularDynamics.Chapter01Review.isoscelesPotential
```lean
def isoscelesPotential (x y : ℝ) :=
  2*lennardJonesPotential 1 1 (Real.sqrt (x^2+y^2)) + lennardJonesPotential 1 1 (2*x)
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```
### 实际依赖 MolecularDynamics.Chapter01Review.uniformLJEnergy
```lean
def uniformLJEnergy {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i, lennardJonesPotential ε σ (pairDistance (q i) (q j))
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-IsoscelesAccessibleRegion",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "kinetic energy is non-negative, we must have\n\\[2\\hat\\varphi_{\\mathrm{LJ}}\\left(\\sqrt{x^2+y^2}\\right)+\\hat\\varphi_{\\mathrm{LJ}}(2x)\\le E.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.isoscelesaccessibleregion",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-182"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem isoscelesaccessibleregion :
  ∀ x y v w E : ℝ, isoscelesEnergy x y v w = E → isoscelesPotential x y ≤ E := by
  exact MolecularDynamics.Chapter01Review.isoscelesEnergyBound_proved
```
### 实际依赖 MolecularDynamics.Chapter01Review.isoscelesEnergy
```lean
def isoscelesEnergy (x y v w : ℝ) := v^2 + w^2/3 + isoscelesPotential x y
```
### 实际依赖 MolecularDynamics.Chapter01Review.isoscelesPotential
```lean
def isoscelesPotential (x y : ℝ) :=
  2*lennardJonesPotential 1 1 (Real.sqrt (x^2+y^2)) + lennardJonesPotential 1 1 (2*x)
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-EquilateralTrimerMinimum",
  "kind": "unnumbered_claim",
  "label": "Example 1.8 (Planar Lennard-Jones Trimer)",
  "section": "1.7",
  "printed_page": "38",
  "pdf_page": "61",
  "statement_latex": "The global minimum of this simple system must be radially symmetric. Placing the atoms at the vertices of an equilateral triangle, we have\n\\[U=3\\hat\\varphi_{\\mathrm{LJ}}(r),\\]\nwhere $r$ is the length of a side. This is minimized when $r=2^{1/6}\\approx1.1225$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.equilateraltrimerminimum",
  "extra_assumptions": [
    "单位LJ；非碰撞配置。"
  ],
  "old_ids": [
    "CH01-203"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem equilateraltrimerminimum :
  ∀ q : Fin 3 → V3, (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ uniformLJEnergy 1 1 q ∧
    (uniformLJEnergy 1 1 q = -3 ↔
      ∀ i j, i ≠ j → pairDistance (q i) (q j) = Real.rpow 2 (1/6)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```
### 实际依赖 MolecularDynamics.Chapter01Review.uniformLJEnergy
```lean
def uniformLJEnergy {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i, lennardJonesPotential ε σ (pairDistance (q i) (q j))
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-TrimerEnergyLowerBound",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "(When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "本条为E<-3不可达；E>0逃逸下一条字面保留。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.trimerenergylowerbound",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-204"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem trimerenergylowerbound :
  ∀ (q v : Fin 3 → V3), (∀ i j, i ≠ j → q i ≠ q j) →
    -3 ≤ (∑ i, ‖v i‖^2/2) + uniformLJEnergy 1 1 q := by
  exact MolecularDynamics.Chapter01Review.trimerLowerBound_proved
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```
### 实际依赖 MolecularDynamics.Chapter01Review.uniformLJEnergy
```lean
def uniformLJEnergy {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i, lennardJonesPotential ε σ (pairDistance (q i) (q j))
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-TrimerSaddle",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40–41",
  "pdf_page": "63–64",
  "statement_latex": "Minimizing the potential in the collinear configuration allows us to determine the saddle point $(x^*,0)$. Near this point, $U$ decreases if we move in the $\\pm y$ direction and increases if we move in the $\\pm x$ direction.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.trimersaddle",
  "extra_assumptions": [
    "x>0，局部严格增减按足够小非零位移解释；去掉图上数字猜测。"
  ],
  "old_ids": [
    "CH01-206"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem trimersaddle :
  ∃ x > 0, (∀ y > 0, collinearTrimer x ≤ collinearTrimer y) ∧
    ∃ δ > 0, (∀ u : ℝ, 0 < |u-x| → |u-x| < δ →
      isoscelesPotential x 0 < isoscelesPotential u 0) ∧
    ∀ y : ℝ, 0 < |y| → |y| < δ → isoscelesPotential x y < isoscelesPotential x 0 := by
  sorry
```
### 实际依赖 MD.Ch01.collinearTrimer
```lean
def collinearTrimer (x : ℝ) :=
  2*lennardJonesPotential 1 1 x + lennardJonesPotential 1 1 (2*x)
```
### 实际依赖 MolecularDynamics.Chapter01Review.isoscelesPotential
```lean
def isoscelesPotential (x y : ℝ) :=
  2*lennardJonesPotential 1 1 (Real.sqrt (x^2+y^2)) + lennardJonesPotential 1 1 (2*x)
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```

## 原文JSON
```json
{
  "source_id": "MD-1.7-TrimerEscapeLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.7",
  "printed_page": "40",
  "pdf_page": "63",
  "statement_latex": "(When $E>0$, the bodies eventually escape to infinity; $E<-3$ is not attainable.)",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "every body逃逸字面过强：取等腰退化为共线y≡0，q₁=(x,0,0)、q₂=(-x,0,0)、q₃=0，中心粒子合力零，质心/动量/角动量均零；x>1的外向正能量解使外侧两粒子逃逸而中心始终固定。需裁定是否改为至少一对分离。"
    }
  ],
  "lean_decl": "MD.Ch01.trimerescapeliteral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-207"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem trimerescapeliteral :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∀ i : Fin 3, Tendsto (fun t => ‖q t i‖) atTop atTop := by
  sorry

/-- 修正版，对应原文 MD-1.7-TrimerEscapeLiteral，改动：把every body逐粒子逃逸改为至少一对粒子分离的候选陈述；全部动力学、正能量、零质心/角动量资格保留。 -/
theorem trimerescapeliteral_corrected :
  ∀ (q v : ℝ → Fin 3 → V3) (E : ℝ), 0 < E →
    (∀ t i j, i ≠ j → q t i ≠ q t j) →
    (∀ t, (∑ i, q t i) = 0 ∧ (∑ i, v t i) = 0 ∧
      (∑ i, cross3 (q t i) (v t i)) = 0 ∧
      ∃ x > 0, ∃ y, q t = isoscelesCoordinates x y) →
    (∀ t i, HasDerivAt (fun s => q s i) (v t i) t ∧
      HasDerivAt (fun s => v s i) (ljForce 1 1 (q t) i) t) →
    (∀ t, (∑ i, ‖v t i‖^2/2)+uniformLJEnergy 1 1 (q t) = E) →
    ∃ i j : Fin 3, i ≠ j ∧ Tendsto (fun t => dist (q t i) (q t j)) atTop atTop := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MolecularDynamics.Chapter01Review.cross3
```lean
def cross3 (u v : V3) : V3 := WithLp.toLp 2
  ![u 1*v 2-u 2*v 1,u 2*v 0-u 0*v 2,u 0*v 1-u 1*v 0]
```
### 实际依赖 MD.Ch01.isoscelesCoordinates
```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]
```
### 实际依赖 MD.Ch01.lennardJonesPotential
```lean
def lennardJonesPotential (ε σ r : ℝ) := 4*ε*((σ/r)^12-(σ/r)^6)
```
### 实际依赖 MolecularDynamics.Chapter01Review.ljForce
```lean
def ljForce {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) (i : Fin N) : V3 :=
  ∑ j ∈ Finset.univ.erase i,
    (-deriv (lennardJonesPotential ε σ) (pairDistance (q i) (q j)) /
      pairDistance (q i) (q j)) • (q i-q j)
```
### 实际依赖 MolecularDynamics.Chapter01Review.pairDistance
```lean
def pairDistance (qᵢ qⱼ : V3) := ‖qᵢ-qⱼ‖
```
### 实际依赖 MolecularDynamics.Chapter01Review.uniformLJEnergy
```lean
def uniformLJEnergy {N : ℕ} (ε σ : ℝ) (q : Fin N → V3) :=
  ∑ i, ∑ j ∈ Finset.Ioi i, lennardJonesPotential ε σ (pairDistance (q i) (q j))
```
