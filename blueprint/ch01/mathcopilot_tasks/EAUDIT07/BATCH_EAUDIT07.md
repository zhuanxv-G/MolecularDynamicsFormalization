# EAUDIT07：第1章§1.3网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.3-GeneralizedCoordinates",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.3",
  "printed_page": "23",
  "pdf_page": "46",
  "statement_latex": "When we introduce a smooth change of variables $\\boldsymbol q=\\boldsymbol\\Phi(\\boldsymbol Q)$, where $\\boldsymbol\\Phi:\\mathbb R^{N_c}\\to\\mathbb R^{N_c}$, this induces a corresponding transformation of the velocity vector by\n\\[\\dot{\\boldsymbol q}=\\boldsymbol\\Phi'(\\boldsymbol Q)\\dot{\\boldsymbol Q},\\]\nwhere $\\boldsymbol\\Phi'$ is the $N_c\\times N_c$ Jacobian matrix of $\\boldsymbol\\Phi$. Then the Lagrangian of the system is transformed to\n\\[\\widetilde L=\\frac{\\dot{\\boldsymbol Q}^{T}\\boldsymbol\\Phi'(\\boldsymbol Q)^{T}\\boldsymbol M\\boldsymbol\\Phi'(\\boldsymbol Q)\\dot{\\boldsymbol Q}}2-U(\\boldsymbol\\Phi(\\boldsymbol Q)),\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "J=Φ′(Q)真实Frechet导数；generalizedMassMatrix=JᵀMJ；后段允许k=Nd≤Nc参数化约束流形。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.generalized_coordinates",
  "extra_assumptions": [
    "原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。"
  ],
  "old_ids": [
    "CH01-074",
    "CH01-075",
    "CH01-076",
    "CH01-077"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem generalized_coordinates {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t ∧
    massLagrangian m U (Φ (q t)) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ (q t)) := by
  exact ⟨hasDerivAt_coordinateChange Φ J q V t hΦ hq,
    massLagrangian_coordinateChange m U Φ J (q t) V⟩
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
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
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.generalizedMassMatrix
```lean
noncomputable def generalizedMassMatrix {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) : MassMatrix k :=
  J.transpose * diagonalMassMatrix m * J
```
### 实际依赖 MolecularDynamics.massLagrangian
```lean
noncomputable def massLagrangian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (q : Position n) (v : Velocity n) : ℝ :=
  nBodyKineticEnergy m v - U q
```
### 实际依赖 MolecularDynamics.nBodyKineticEnergy
```lean
noncomputable def nBodyKineticEnergy {n : ℕ} (masses : CoordinateMasses n)
    (velocity : Velocity n) : ℝ :=
  ∑ i, masses i * (velocity i) ^ 2 / 2
```

## 原文JSON
```json
{
  "source_id": "MD-1.3-GeneralizedMassRegular",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.3",
  "printed_page": "23",
  "pdf_page": "46",
  "statement_latex": "We will assume that any such changes of variables are regular transformations in the sense that $\\boldsymbol\\Phi'$ is of full rank and the resulting generalized mass matrix is invertible.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "这是原文模型假设及其由正定质量推出的关系，不假设结论可逆。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.generalizedmassregular",
  "extra_assumptions": [
    "正粒子质量；full rank为Jacobian列单射，符合n≥k。"
  ],
  "old_ids": [
    "CH01-078"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem generalizedmassregular :
  ∀ {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec),
    IsUnit (generalizedMassMatrix m J) := by
  exact @MolecularDynamics.generalizedMassMatrix_isUnit

/- END FULL SECTION 1.3 -/

/- BEGIN FULL SECTION 1.4 -/
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.MassMatrix
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```
### 实际依赖 MolecularDynamics.diagonalMassMatrix
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```
### 实际依赖 MolecularDynamics.generalizedMassMatrix
```lean
noncomputable def generalizedMassMatrix {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) : MassMatrix k :=
  J.transpose * diagonalMassMatrix m * J
```
