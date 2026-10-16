# EAUDIT08：第1章§1.4网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.4-LegendreHamiltonian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "If $\\boldsymbol{M}(\\boldsymbol{q})$ is invertible, the supremum is achieved precisely when\n\\[\\boldsymbol{v}=\\boldsymbol{M}^{-1}(\\boldsymbol{q})\\boldsymbol{p},\\]\nwhich gives the standard definition of the momentum vector $\\boldsymbol{p}$ in terms of velocities,\n\\[\\boldsymbol{p}=\\frac{\\partial L}{\\partial\\dot{\\boldsymbol{q}}}=\\boldsymbol{M}(\\boldsymbol{q})\\dot{\\boldsymbol{q}},\\]\nand, with $\\boldsymbol{v}=\\boldsymbol{M}^{-1}(\\boldsymbol{q})\\boldsymbol{p}$, the Legendre transformation results in a new function\n\\[H(\\boldsymbol{q},\\boldsymbol{p})\\stackrel{\\mathrm{def}}{=}\\boldsymbol{p}^TM(\\boldsymbol{q})^{-1}\\boldsymbol{p}/2+U(\\boldsymbol{q}).\\]\nThis is precisely the energy function, written in terms of positions and momenta.",
  "proof_latex": null,
  "proof_note": "原文仅展示将U(q)从上确界中移出的代数恒等式，未独立证明上界、达到条件及唯一性；该段原文完整保存于proof_discussion_latex。",
  "context_notation": [
    "同页Legendre定义：凸函数$g(\\boldsymbol{\\xi}):\\mathbb{R}^m\\to\\mathbb{R}$，$\\widetilde g(\\boldsymbol{\\eta})=\\sup_{\\boldsymbol{\\xi}}(\\boldsymbol{\\eta}^T\\boldsymbol{\\xi}-g(\\boldsymbol{\\xi}))$；印刷p.24/PDF47。",
    "配置相关质量矩阵来自$\\Phi^{\\prime}(\\boldsymbol{Q})^T\\boldsymbol{M}\\Phi^{\\prime}(\\boldsymbol{Q})$；§1.3印刷p.23/PDF46要求变换Jacobian满秩且所得质量矩阵可逆。在固定正质量的机械背景中，这给出对称正定矩阵；对称性和正定性不是单独由可逆推出。",
    "$\\boldsymbol{q},\\boldsymbol{v},\\boldsymbol{p}$属于广义配置坐标空间；无约束例为$\\mathbb{R}^{N_c}$，约束参数化可为$\\mathbb{R}^{N_d}$，见印刷p.23/PDF46。$H$是位置和动量中的能量，见印刷p.24/PDF47。"
  ],
  "issues": [
    {
      "code": "POSSIBLE_ERRATUM",
      "status": "NEEDS_HUMAN",
      "detail": "若只假设可逆，M=-1、p=0、U=0时目标=v²/2无上界；须确认同页凸性及p.23机械质量背景是否应并入假设。当前保留字面可逆陈述并标ERRATUM?，未静默加正定。"
    },
    {
      "code": "REUSE_SCOPE_GAP",
      "status": "open",
      "detail": "现有定理仅固定正对角m；本条保留任意配置相关M(q)、上界、sup、精确达到条件、动量偏导和能量对应，不能直接调用旧定理覆盖。"
    },
    {
      "code": "INCOMPLETE_PROOF_AS_PROOF",
      "status": "local_verified",
      "detail": "PDF47/印刷p.24的计算只将U(q)移出sup，不能独立证明所摘陈述。依本批proof_latex的完整证明约定改为null，原段完整转存proof_discussion_latex。",
      "receipt": "review.json"
    },
    {
      "code": "CONTEXT_DEPENDENT_INVERTIBILITY",
      "status": "local_verified",
      "detail": "原句确实只写可逆，保持原文并标ISSUE；PDF46给出JᵀM_cartJ和满秩机械背景，继承对称正定性。仅以任意矩阵的可逆性解释则错误，不能静默把原句改写为正定性命题。",
      "receipt": "review.json"
    },
    {
      "code": "GENERALIZED_COORDINATE_DIMENSION",
      "status": "local_verified",
      "detail": "PDF46允许R^{N_d}→R^{N_c}的约束参数化；原context_notation一律将广义q、v、p放在R^{N_c}过窄，已修正。",
      "receipt": "review.json"
    }
  ],
  "lean_decl": "MD.Ch01.hamiltonian_legendre_transform",
  "reusable_proofs": [
    "MolecularDynamics.massHamiltonian_eq_legendre_sup",
    "MolecularDynamics.legendre_objective_eq_massHamiltonian_iff"
  ],
  "extra_assumptions": [
    "[EXTRA] hPositive : (M q).PosDef；展开p23正物理质量及满秩Jacobian继承的对称正定背景，任意可逆矩阵反例不属于此子类。字面可逆原句保留，配置相关M及全部六项结论不变。"
  ],
  "statement_scope": "从“If M(q) is invertible”到“written in terms of positions and momenta.”；前一计算为proof_discussion_latex，前置抽象定义为context_notation；Hamilton方程属于下一条。",
  "review_status": "CORRECTED",
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json",
  "proof_discussion_latex": "In the case of the Lagrangian $L(\\boldsymbol{q},\\boldsymbol{v})=\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2-U(\\boldsymbol{q})$ (which we have seen is the formulation of a mechanical system in generalized coordinates) we find\n\\[\\sup_{\\boldsymbol{v}}(\\boldsymbol{p}^T\\boldsymbol{v}-(\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2-U(\\boldsymbol{q})))=\\sup_{\\boldsymbol{v}}(\\boldsymbol{p}^T\\boldsymbol{v}-\\boldsymbol{v}^TM(\\boldsymbol{q})\\boldsymbol{v}/2)+U(\\boldsymbol{q}).\\]"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonian_legendre_transform {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q))
    (hPositive : (M q).PosDef) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry

/-- 修正版，对应原文 MD-1.4-LegendreHamiltonian，改动：新增仅可逆的原文字面版；修正版继承正定质量背景并保留上界、精确上确界、唯一达到点、动量梯度与能量全部结论。 -/
theorem hamiltonian_legendre_transform_literal {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q)) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry

/-- 修正版，对应原文 MD-1.4-LegendreHamiltonian，改动：显式继承对称正定机械质量背景。 -/
theorem hamiltonian_legendre_transform_corrected {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) (hM : IsUnit (M q))
    (hPositive : (M q).PosDef) :
    BddAbove (range (fun v : Velocity n =>
      inner ℝ p v - variableMassLagrangian M U q v)) ∧
    sSup (range (fun v : Velocity n => inner ℝ p v - variableMassLagrangian M U q v)) =
      variableMassHamiltonian M U q p ∧
    (∀ v : Velocity n, inner ℝ p v - variableMassLagrangian M U q v =
      variableMassHamiltonian M U q p ↔ v = matrixAction (M q)⁻¹ p) ∧
    (∀ v : Velocity n, HasGradientAt (variableMassLagrangian M U q)
      (matrixAction (M q) v) v) ∧
    p = matrixAction (M q) (matrixAction (M q)⁻¹ p) ∧
    variableMassHamiltonian M U q p =
      inner ℝ (matrixAction (M q)⁻¹ p)
        (matrixAction (M q) (matrixAction (M q)⁻¹ p)) / 2 + U q := by
  sorry
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
### 实际依赖 MD.Ch01.matrixAction
```lean
noncomputable def matrixAction {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (v : Position n) : Position n := Matrix.toEuclideanLin A v
```
### 实际依赖 MD.Ch01.variableMassHamiltonian
```lean
noncomputable def variableMassHamiltonian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (p : Momentum n) : ℝ := inner ℝ p (matrixAction (M q)⁻¹ p) / 2 + U q
```
### 实际依赖 MD.Ch01.variableMassLagrangian
```lean
noncomputable def variableMassLagrangian {n : ℕ}
    (M : Position n → Matrix (Fin n) (Fin n) ℝ) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := inner ℝ v (matrixAction (M q) v) / 2 - U q
```

## 原文JSON
```json
{
  "source_id": "MD-1.4-ConvexLegendre",
  "kind": "definition",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "Abstractly, a Legendre transformation of a given convex function $g=g(\\boldsymbol\\xi):\\mathbb R^m\\to\\mathbb R$ is a new function $\\widetilde g=\\widetilde g(\\boldsymbol\\eta):\\mathbb R^m\\to\\mathbb R$ defined by\n\\[\\widetilde g(\\boldsymbol\\eta)=\\sup_{\\boldsymbol\\xi}(\\boldsymbol\\eta^T\\boldsymbol\\xi-g(\\boldsymbol\\xi)),\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "原文给任意凸g却称共轭R值；g=0,η≠0时上确界+∞。Blueprint保留sup定义并显式扩展值域，须导师裁定是否接受。"
    }
  ],
  "lean_decl": "MD.Ch01.legendreTransform",
  "extra_assumptions": [
    "值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。"
  ],
  "old_ids": [
    "CH01-079"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：新增原书“任意凸函数的变换处处实值”的literal陈述；默认EReal扩展实数，并给有界时实值备选。 -/
theorem legendreTransform_literal {n : ℕ} (g : Position n → ℝ)
    (hg : ConvexOn ℝ univ g) :
    ∀ η : Position n, ∃ r : ℝ, IsLUB (Set.range (fun θ => inner ℝ η θ - g θ)) r := by
  sorry

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：允许上确界为+∞。 -/
def legendreTransform_corrected {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：实值版显式要求有上界。 -/
theorem legendreTransform_corrected_b {n : ℕ} (g : Position n → ℝ) (η : Position n)
    (hb : BddAbove (Set.range (fun θ => inner ℝ η θ - g θ))) :
    IsLUB (Set.range (fun θ => inner ℝ η θ - g θ))
      (sSup (Set.range (fun θ => inner ℝ η θ - g θ))) := by
  exact isLUB_csSup (Set.range_nonempty _) hb
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch01.legendreTransform
```lean
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)
```
### 实际依赖 MD.Ch01.legendreTransform_corrected
```lean
def legendreTransform_corrected {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)
```

## 原文JSON
```json
{
  "source_id": "MD-1.4-HamiltonEquations",
  "kind": "definition",
  "label": null,
  "section": "1.4",
  "printed_page": "24",
  "pdf_page": "47",
  "statement_latex": "The equations of motion can be written\n\\[\\dot{\\boldsymbol q}=\\frac{\\partial H}{\\partial\\boldsymbol p},\\qquad\\dot{\\boldsymbol p}=-\\frac{\\partial H}{\\partial\\boldsymbol q}.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "速度与动量导数均是真导数；H可微的模型背景在使用时另给资格。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hamiltonEquations",
  "extra_assumptions": [
    "[EXTRA] 19号：沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。"
  ],
  "old_ids": [
    "CH01-084"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hamiltonEquationsOn {n : ℕ} (H : PhaseSpace n → ℝ)
    (I : Set ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t ∈ I, DifferentiableAt ℝ (fun v => H (q t,v)) (p t) ∧
    DifferentiableAt ℝ (fun x => H (x,p t)) (q t) ∧
    HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t

def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  hamiltonEquationsOn H univ q p
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
### 实际依赖 MD.Ch01.hamiltonEquations
```lean
def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  hamiltonEquationsOn H univ q p
```
### 实际依赖 MD.Ch01.hamiltonEquationsOn
```lean
def hamiltonEquationsOn {n : ℕ} (H : PhaseSpace n → ℝ)
    (I : Set ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t ∈ I, DifferentiableAt ℝ (fun v => H (q t,v)) (p t) ∧
    DifferentiableAt ℝ (fun x => H (x,p t)) (q t) ∧
    HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t
```

## 原文JSON
```json
{
  "source_id": "MD-1.4-HamiltonLagrangeEquivalence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.4",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "More generally, for molecular models, the Hamiltonian and Lagrangian formulations are interchangeable, but the use of the Hamiltonian form is preferred for allowing simplified description of the geometric character of the solutions of the system as we discuss in Chaps. 2–4.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.hamiltonlagrangeequivalence",
  "extra_assumptions": [
    "一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。"
  ],
  "old_ids": [
    "CH01-086"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem hamiltonlagrangeequivalence :
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t) := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter01Review.quadraticH
```lean
def quadraticH {n : ℕ} (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) :=
  inner ℝ p ((M q)⁻¹.toEuclideanLin p)/2+U q
```
### 实际依赖 MolecularDynamics.Chapter01Review.quadraticL
```lean
def quadraticL {n : ℕ} (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : Position n) :=
  inner ℝ v ((M q).toEuclideanLin v)/2-U q
```

## 原文JSON
```json
{
  "source_id": "MD-1.4-PhaseSpace",
  "kind": "definition",
  "label": null,
  "section": "1.4",
  "printed_page": "25",
  "pdf_page": "48",
  "statement_latex": "The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $\\mathbb R^3$ is described by coordinates and positions, i.e., by a point in $\\mathbb R^{6N}$.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "p.25原句described by coordinates and positions字面重复位置；前句定义是positions and momenta，Lean按前句定义保留位置×动量，原句不静默改字。"
    }
  ],
  "lean_decl": "MD.Ch01.finiteEnergyPhaseDomain",
  "extra_assumptions": [
    "采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。"
  ],
  "old_ids": [
    "CH01-087",
    "CH01-088"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}

/- END FULL SECTION 1.4 -/

/- BEGIN FULL SECTION 1.5 -/

/-- 修正版，对应原文 MD-1.4-PhaseSpace，改动：有限能量位置×动量定义保留；把后句coordinates and positions按前句解释为位置与动量，并显式核验6N维。 -/
def finiteEnergyPhaseDomain_corrected {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}

theorem finiteEnergyPhaseDomain_corrected_dimension (N : ℕ) :
    Module.finrank ℝ (PhaseSpace (3*N)) = 6*N := by
  simp [PhaseSpace,Position,Momentum]
  omega
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
### 实际依赖 MD.Ch01.finiteEnergyPhaseDomain
```lean
def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}
```
### 实际依赖 MD.Ch01.finiteEnergyPhaseDomain_corrected
```lean
def finiteEnergyPhaseDomain_corrected {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}
```
