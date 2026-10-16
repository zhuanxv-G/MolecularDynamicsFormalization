# EAUDIT13：第1章§1.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.5-LocalExistUnique",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "One of the most important properties of a typical classical molecular Hamiltonian system is the existence and uniqueness of solutions started from a generic initial condition.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.local_exist_unique",
  "extra_assumptions": [
    "generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。"
  ],
  "old_ids": [
    "CH01-089"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem local_exist_unique {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (hQ : IsOpen Q) (t₀ : ℝ) (z₀ : PhaseSpace n) (hz : z₀.1 ∈ Q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∃ ε γ, IsLocalMechanicalIVP m (fun q => -gradient U q) Q t₀ z₀ ε γ) ∧
    ∀ I γ η, IsOpen I → t₀ ∈ I →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I η →
      γ t₀ = z₀ → η t₀ = z₀ → γ =ᶠ[𝓝 t₀] η := by
  constructor
  · exact exists_localMechanicalIVP_open_of_force_contDiffAt m _ Q hQ t₀ z₀ hz (hreg _ hz)
  · intro I γ η hI ht hγ hη hi hj
    exact mechanicalSolution_eventually_unique_of_contDiffAt m _ Q I t₀ γ η z₀ hI ht hγ hη hi hj
      (mechanicalVectorField_contDiffAt m _ z₀ (hreg _ hz))
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.IsLocalMechanicalIVP
```lean
def IsLocalMechanicalIVP {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (t₀ : ℝ) (z₀ : PhaseSpace n)
    (ε : ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  0 < ε ∧ γ t₀ = z₀ ∧
    IsMechanicalSolutionOn μ F Q (Ioo (t₀ - ε) (t₀ + ε)) γ
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
  "source_id": "MD-1.5-CompactContinuation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.5",
  "printed_page": "25–26",
  "pdf_page": "48–49",
  "statement_latex": "The uniqueness of solutions is easily verified in the usual way (as for the local result for uniqueness of solutions). The key point is that, with the energy constraint, solutions typically remain bounded for all time.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.compact_continuation",
  "extra_assumptions": [
    "共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。",
    "[EXTRA] 19号：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。"
  ],
  "old_ids": [
    "CH01-095"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
/- General confinement helper retained separately from the Hamiltonian result. -/
theorem compact_continuation_aux {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry

theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z₀ : PhaseSpace n) (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U)
    (hlower : ∃ b : ℝ, ∀ q, b ≤ U q)
    (hconfine : ∀ E : ℝ, Bornology.IsBounded {q : Position n | U q ≤ E}) :
    ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ γ ∧ γ 0 = z₀ ∧
      (∀ t, massHamiltonian m U (γ t) = massHamiltonian m U z₀) ∧
      Bornology.IsBounded (Set.range γ) ∧
      (∀ η : ℝ → PhaseSpace n,
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ η → η 0 = z₀ → η = γ) ∧
      (∀ a b η, 0 ∈ Ioo a b →
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ (Ioo a b) η → η 0 = z₀ →
        ∀ t ∈ Ioo a b, η t = γ t) := by
  sorry
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Force
```lean
abbrev Force (n : ℕ) := Position n → Position n
```
### 实际依赖 MolecularDynamics.Hamiltonian
```lean
abbrev Hamiltonian (n : ℕ) := PhaseSpace n → ℝ
```
### 实际依赖 MolecularDynamics.IsMechanicalSolutionOn
```lean
def IsMechanicalSolutionOn {n : ℕ} (μ : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (I : Set ℝ) (γ : ℝ → PhaseSpace n) : Prop :=
  (∀ t ∈ I, (γ t).1 ∈ Q) ∧
    IsIntegralCurveOn γ (fun _ z => mechanicalVectorField μ F z) I
```
### 实际依赖 MolecularDynamics.KineticEnergy
```lean
abbrev KineticEnergy (n : ℕ) := Momentum n → ℝ
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
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
### 实际依赖 MolecularDynamics.SeparableEnergy
```lean
structure SeparableEnergy (n : ℕ) where
  kinetic : KineticEnergy n
  potential : PotentialEnergy n
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
### 实际依赖 MolecularDynamics.massHamiltonian
```lean
noncomputable def massHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : Hamiltonian n := (massSeparableEnergy m U).hamiltonian
```
### 实际依赖 MolecularDynamics.massSeparableEnergy
```lean
noncomputable def massSeparableEnergy {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) : SeparableEnergy n := ⟨momentumKineticEnergy m, U⟩
```
### 实际依赖 MolecularDynamics.mechanicalVectorField
```lean
noncomputable def mechanicalVectorField {n : ℕ} (μ : CoordinateMasses n)
    (F : Force n) (z : PhaseSpace n) : PhaseSpace n :=
  (velocityOperator μ z.2, F z.1)
```
### 实际依赖 MolecularDynamics.momentumKineticEnergy
```lean
noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)
```
### 实际依赖 MolecularDynamics.velocityOperator
```lean
noncomputable def velocityOperator {n : ℕ} (μ : CoordinateMasses n) :
    Momentum n →L[ℝ] Velocity n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)⁻¹).toContinuousLinearMap
```
