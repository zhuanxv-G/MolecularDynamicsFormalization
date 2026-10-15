# EAUDIT36：第3章§3.7网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.7-HardCoreDomain",
  "kind": "definition",
  "label": null,
  "section": "3.7",
  "printed_page": "132",
  "pdf_page": "154",
  "statement_latex": "We assume, as usual a Hamiltonian $H=p^TM^{-1}p/2+U(q)$ but we add the inequality constraint $\\|q_i-q_j\\|\\ge\\sigma_i+\\sigma_j$ where $\\sigma_i$, $i=1,\\ldots,N$ is a core radius. The condition $\\|q_i-q_j\\|=\\sigma_i+\\sigma_j$, some $i,j$ defines the constraint surface.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原书未显式写出 i≠j；不同粒子之间的硬核约束按物理语境理解为 i≠j，此为解释性补充，不能称原文明确。接触等号允许，不当重叠。σ作为半径通常非负，但原句未显式给出非负假设。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.hardCoreDomain",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:31:30.636685",
      "before_sha256": "11b09e2c7d2d4fba6839ab5ede43bded88aa0fbcb1d05f982e89ee9788088c24",
      "after_sha256": "8ec443e661ffaff983101430256f64b5998d705387536103ae9a4d2e906a6763",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch03.hardCoreDomain
```lean
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
```

## 原文JSON
```json
{
  "source_id": "MD-3.7-CollisionComposition",
  "kind": "definition",
  "label": null,
  "section": "3.7",
  "printed_page": "132–133",
  "pdf_page": "154–155",
  "statement_latex": "Let $\\mathcal R_c$ denote the action of the collision operator on the vector of positions and momenta. Then we can write the evolution formally as\n\\[\\mathcal F_\\tau^{\\mathrm{h.s.}}(q,p)=\\mathcal G_{\\Delta\\tau_r}\\circ\\mathcal R_c\\circ\\mathcal G_{\\Delta\\tau_{r-1}}\\cdots\\circ\\mathcal R_c\\circ\\mathcal G_{\\Delta\\tau_0}\\]\nwhere $\\Delta\\tau_1,\\Delta\\tau_2,\\ldots,\\Delta\\tau_{r-1}$ are the times between collisions, $\\Delta\\tau_0$ is the time until the first collision, and $\\Delta\\tau_r$ is the time between the last collision and $\\tau$. Here $\\mathcal G_t$ is the flow map of the smooth system (Hamiltonian $H$).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "有限事件序列，实际右到左流/反射复合；不宣称任意多重或无限碰撞解存在唯一。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionComposition",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:31:30.636685",
      "before_sha256": "591a845affe8f92c6d93fea2c97dc86a42773a390dda780e5b434d618ef4acee",
      "after_sha256": "9372a02ac4362685ec931a7889dfe67a360271b94b113453685c775c3a658c4e",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def collisionComposition {E : Type*} (G : ℝ → E → E) (Rc : E → E) (times : List ℝ) : E → E :=
  match times with
  | [] => id
  | [t] => G t
  | t::u::ts => G t ∘ Rc ∘ collisionComposition G Rc (u::ts)
termination_by times.length
```
### 实际依赖 MD.Ch03.collisionComposition
```lean
def collisionComposition {E : Type*} (G : ℝ → E → E) (Rc : E → E) (times : List ℝ) : E → E :=
  match times with
  | [] => id
  | [t] => G t
  | t::u::ts => G t ∘ Rc ∘ collisionComposition G Rc (u::ts)
termination_by times.length
```

## 原文JSON
```json
{
  "source_id": "MD-3.7-CollisionRegularity",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "The trajectory is thus piecewise smooth with continuous configurational path and momenta exhibiting finite jump discontinuities.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.collisionRegularity",
  "reusable_proofs": [],
  "extra_assumptions": [
    "有限严格递增隔离时刻、相邻实际光滑ODE段、碰撞接触处位置匹配和真实法向动量跳跃；不把拼接后连续或光滑结论作假设。",
    "[EXTRA] 补光滑接触函数、非零法向、严格入射及各段合法非重叠资格；结论补完整(q,p)内段光滑及每次真实碰撞的非零动量跳跃，保留双侧有限极限。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT17_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:31:30.636685",
      "before_sha256": "6f0faec19da8b5033efdf683d2dfe8555fb27a4211db1409c6f788770ba1461e",
      "after_sha256": "9d32b5a04ac10a340512f4312fc5a52af5ed09f76be51adfb5c10461d3f58342",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH23_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT17/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem collisionRegularity :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) (g : Q n → ℝ)
    (times : ℕ → ℝ) (segments : ℕ → ℝ → Z n) ν,
    positiveMass m → ContDiff ℝ ⊤ F → ContDiff ℝ 1 g →
    (∀ j < ν, grad g (segments j (times (j+1))).1 ≠ 0 ∧
      (∑ i, grad g (segments j (times (j+1))).1 i *
        (segments j (times (j+1))).2 i/m i) < 0) →
    (∀ j ≤ ν, ∀ t ∈ Icc (times j) (times (j+1)), 0 ≤ g (segments j t).1) →
    concatenatedCollisionSegments m F g times segments ν →
    (∀ j < ν, (segments j (times (j+1))).2 ≠ (segments (j+1) (times (j+1))).2) ∧
    ContinuousOn (fun t => (gluedCollision times segments ν t).1) (Icc (times 0) (times (ν+1))) ∧
    (∀ j ≤ ν, ∀ t ∈ Ioo (times j) (times (j+1)),
      ContDiffAt ℝ ⊤ (gluedCollision times segments ν) t) ∧
    (∀ j < ν, Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[<] (times (j+1))) (𝓝 ((segments j (times (j+1))).2)) ∧
      Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[>] (times (j+1))) (𝓝 ((segments (j+1) (times (j+1))).2))) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter03Review.concatenatedCollisionSegments
```lean
def concatenatedCollisionSegments {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n)
    (g : Q n → ℝ) (times : ℕ → ℝ) (segments : ℕ → ℝ → Z n) (ν : ℕ) : Prop :=
  (∀ j ≤ ν, times j < times (j+1)) ∧
  (∀ j ≤ ν, solution (mechanicalField m F) (segments j) (times j) (times (j+1))) ∧
  ∀ j < ν, let left := segments j (times (j+1)); let right := segments (j+1) (times (j+1))
    g left.1=0 ∧ right.1=left.1 ∧
    right.2=left.2+(-2*(∑ i, grad g left.1 i*left.2 i/m i)/(∑ i, grad g left.1 i^2/m i)) • grad g left.1
```
### 实际依赖 MolecularDynamics.Chapter03Review.gluedCollision
```lean
def gluedCollision {n : ℕ} (times : ℕ → ℝ) (segments : ℕ → ℝ → Z n) (ν : ℕ) (t : ℝ) : Z n :=
  segments (((Finset.range (ν+1)).filter (fun j => times j ≤ t)).sup id) t
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter02Review.mechanicalField
```lean
def mechanicalField {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) : Z n :=
  (invMass m z.2, F z.1)
```
### 实际依赖 MolecularDynamics.Chapter02Review.positiveMass
```lean
def positiveMass {n : ℕ} (m : Fin n → ℝ) : Prop := ∀ i, 0 < m i
```
### 实际依赖 MolecularDynamics.Chapter02Review.solution
```lean
def solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (γ : ℝ → E) (a b : ℝ) : Prop :=
  ∀ t ∈ Icc a b, HasDerivWithinAt γ (f (γ t)) (Icc a b) t
```
