# EAUDIT05：第1章§1.2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.2-NewtonCompact",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "In this book, we shall frequently use a compact, vectorial notation, where $\\boldsymbol q$ and $\\dot{\\boldsymbol q}$ represent vectors of the positions and velocities, and $\\boldsymbol M$ is a diagonal mass matrix, so the equations of motion (1.2) become\n\\[\\boldsymbol M\\frac{\\mathrm d^2}{\\mathrm dt^2}\\boldsymbol q=\\boldsymbol F(\\boldsymbol q)=-\\nabla U(\\boldsymbol q).\\tag{1.3}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$N_c=3N$；$\\boldsymbol M=\\operatorname{diag}(m_1,m_1,m_1,\\ldots,m_N,m_N,m_N)$；一维时$N_c=N$。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.compactNewton",
  "extra_assumptions": [
    "真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。"
  ],
  "old_ids": [
    "CH01-044",
    "CH01-045",
    "CH01-046",
    "CH01-047",
    "CH01-048",
    "CH01-049",
    "CH01-050"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.compactNewton
```lean
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.massOperator
```lean
noncomputable def massOperator {n : ℕ} (μ : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)).toContinuousLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-DegreesFreedom",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $N_d$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.degreesOfFreedom",
  "extra_assumptions": [
    "在可微约束C局部正则层中以导数核维数表示；无约束取零约束。",
    "[EXTRA] 19号：只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。"
  ],
  "old_ids": [
    "CH01-051"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
/- Linear algebra auxiliary; geometric validity is stated by constraintdimension. -/
def linearizedConstraintDimension {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)

def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) : ℕ := linearizedConstraintDimension C q.val
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.degreesOfFreedom
```lean
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) : ℕ := linearizedConstraintDimension C q.val
```
### 实际依赖 MD.Ch01.linearizedConstraintDimension
```lean
def linearizedConstraintDimension {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-ConstraintDimension",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "For the N-body system in $\\mathbb R^3$ without additional constraints there are $N_d=N_c=3N$ degrees of freedom. If $r$ independent constraints are present the number of degrees of freedom is $N_d=N_c-r$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.constraintdimension",
  "extra_assumptions": [
    "约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。",
    "[EXTRA] 19号：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。"
  ],
  "old_ids": [
    "CH01-052"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem constraintdimension {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) :
    degreesOfFreedom C c q + r = n ∧
    ∃ (U : Set (Position n)) (V : Set (Position (degreesOfFreedom C c q) × Position r))
      (φ : Position n → Position (degreesOfFreedom C c q) × Position r)
      (ψ : Position (degreesOfFreedom C c q) × Position r → Position n),
      IsOpen U ∧ IsOpen V ∧ q.val ∈ U ∧
      ContDiffOn ℝ 1 φ U ∧ ContDiffOn ℝ 1 ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      (∀ x ∈ U, C x = c ↔ (φ x).2 = 0) := by
  sorry

/-- Unconstrained three-dimensional N-particle specialization, not a geometry assumption. -/
theorem constraintdimension_unconstrained (N : ℕ) :
    linearizedConstraintDimension (fun _ : Position (3*N) => (0 : Position 0)) 0 = 3*N := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.degreesOfFreedom
```lean
def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) : ℕ := linearizedConstraintDimension C q.val
```
### 实际依赖 MD.Ch01.linearizedConstraintDimension
```lean
def linearizedConstraintDimension {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-TotalEnergy",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "18",
  "pdf_page": "41",
  "statement_latex": "The total energy of the N-body system is a function of positions and velocities,\n\\[E(\\boldsymbol q_1,\\ldots,\\boldsymbol q_N,\\dot{\\boldsymbol q}_1,\\ldots,\\dot{\\boldsymbol q}_N)=\\sum_{j=1}^{N}\\frac{m_j\\|\\dot{\\boldsymbol q}_j\\|^2}{2}+U(\\boldsymbol q_1,\\ldots,\\boldsymbol q_N).\\tag{1.4}\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "斜体E为函数，直立E为守恒能量值；动能是有限和。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.particleTotalEnergy",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-053",
    "CH01-054",
    "CH01-057"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```
### 实际依赖 MD.Ch01.particleTotalEnergy
```lean
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-PairCancellation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19",
  "pdf_page": "42",
  "statement_latex": "This means that the sum of all the forces will vanish.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "前文Newton第三定律：i作用j的力是j作用i的力的exact negative。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.paircancellation",
  "extra_assumptions": [
    "Fi i=0，内部两体力反对称；无外力。"
  ],
  "old_ids": [
    "CH01-058"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem paircancellation :
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0 := by
  intro N F _ hanti
  have h : (∑ i, ∑ j, F i j) = -(∑ i, ∑ j, F i j) := by
    calc
      (∑ i, ∑ j, F i j) = ∑ j, ∑ i, F i j := Finset.sum_comm
      _ = ∑ j, ∑ i, -F j i := by
        apply Finset.sum_congr rfl
        intro j _
        apply Finset.sum_congr rfl
        intro i _
        exact hanti i j
      _ = -(∑ j, ∑ i, F j i) := by simp only [Finset.sum_neg_distrib]
  have hcoord (k : Fin 3) : (∑ i, ∑ j, F i j) k = 0 := by
    have hk := congrArg (fun v : V3 => v k) h
    simp only [PiLp.neg_apply] at hk
    linarith
  ext k
  exact hcoord k
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-MomentumConservation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19",
  "pdf_page": "42",
  "statement_latex": "and thus the three components of the total momentum vector $\\boldsymbol p_{\\mathrm{tot}}:=\\sum_{i=1}^{N}\\boldsymbol p_i$ will be conserved quantities.",
  "proof_latex": "Since\n\\[\\frac{\\mathrm d\\boldsymbol p_i}{\\mathrm dt}=\\boldsymbol F_i,\\]\nwe have\n\\[\\sum_{i=1}^{N}\\frac{\\mathrm d\\boldsymbol p_i}{\\mathrm dt}=\\sum_{i=1}^{N}\\boldsymbol F_i=0\\]",
  "proof_note": "按渲染原页逐字转录原文论证。",
  "context_notation": [
    "p=m qdot，三维d=3，任意d为推广；IsMechanicalSolutionOn是真正时间微分方程。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.momentum_conservation",
  "extra_assumptions": [
    "真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。"
  ],
  "old_ids": [
    "CH01-059",
    "CH01-060",
    "CH01-061"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem momentum_conservation :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  intro N m v F I ho hi hanti hNewton
  have hz (t : ℝ) (ht : t ∈ I) : (∑ i, ∑ j, F t i j) = 0 := by
    apply paircancellation N (F t)
    · intro i
      ext k
      have h := congrArg (fun u : V3 => u k) (hanti t ht i i)
      simp only [PiLp.neg_apply] at h
      change (F t i i) k = 0
      linarith
    · exact hanti t ht
  have hd (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • v s i) 0 t := by
    have h := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hNewton t ht i)
    rwa [hz t ht] at h
  refine ⟨hz,hd,?_⟩
  intro a ha b hb
  exact ho.is_const_of_deriv_eq_zero hi
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter01Review.V3
```lean
abbrev V3 := Position 3
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-HarmonicSolution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.2",
  "printed_page": "19–20",
  "pdf_page": "42–43",
  "statement_latex": "Example 1.3 (Harmonic Oscillator) Consider the system\n\\[\\dot x=v,\\qquad\\dot v=-\\Omega^2x.\\]\nThis system describes the behavior of a particle with unit mass in one dimension, with energy function $E(x,\\dot x)=\\dot x^2/2+\\Omega^2x^2/2$, where its motion is governed by a linear 2nd order equation $\\ddot x+\\Omega^2x=0$. The solution, for given $x(0)=\\xi$, $\\dot x(0)=v(0)=\\eta$, is\n\\[x(t)=\\xi\\cos(\\Omega t)+\\frac\\eta\\Omega\\sin(\\Omega t).\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "harmonicFlow同时给出位置与实际动量/速度；harmonicFlow_zero保证初值。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.harmonic_solution",
  "extra_assumptions": [
    "Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。"
  ],
  "old_ids": [
    "CH01-062",
    "CH01-063"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    ∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2 := by
  exact ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z, fun _ => rfl⟩
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.IsMechanicalSolutionOn
```lean
def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PhaseSpace
```lean
abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Velocity
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.harmonicFlow
```lean
noncomputable def harmonicFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω * t) • z.1 + (Real.sin (Ω * t) / Ω) • z.2,
    (-Ω * Real.sin (Ω * t)) • z.1 + Real.cos (Ω * t) • z.2)
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
```
### 实际依赖 MolecularDynamics.velocityOperator
```lean
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap
```

## 原文JSON
```json
{
  "source_id": "MD-1.2-ScalarMechanical",
  "kind": "definition",
  "label": null,
  "section": "1.2",
  "printed_page": "20",
  "pdf_page": "43",
  "statement_latex": "Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $m=1$ for simplicity) and energy function $E(x,\\dot x)=\\dot x^2/2+U(x)$ (which includes the harmonic oscillator as a special case). The equations of motion are\n\\[\\dot x=v,\\qquad\\dot v=-\\frac{\\partial U}{\\partial x}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "scalarPotentialEnergy U z = z.2²/2+U z.1；定义方程不宣称解存在。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.scalarMechanicalModel",
  "extra_assumptions": [
    "[EXTRA] 19号：沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。"
  ],
  "old_ids": [
    "CH01-064"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t
```
### 实际依赖 MD.Ch01.scalarMechanicalModel
```lean
def scalarMechanicalModel (U : ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t
```
