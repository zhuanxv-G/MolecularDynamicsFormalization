# EAUDIT74：第2章§2网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-2-HamiltonianODE",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "53",
  "pdf_page": "75",
  "statement_latex": "The challenge before us is to compute solutions of\n\\[\\dot{\\boldsymbol q}=\\boldsymbol M^{-1}\\boldsymbol p,\\qquad \\dot{\\boldsymbol p}=\\boldsymbol F(\\boldsymbol q)=-\\nabla U(\\boldsymbol q),\\]\nor, more compactly, with $\\boldsymbol z$ representing the collection of all positions and momenta,\n\\[\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z),\\qquad \\boldsymbol f(\\boldsymbol z)=\\boldsymbol J\\nabla H,\\tag{2.1}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\boldsymbol z=(\\boldsymbol q,\\boldsymbol p)$；$H$见同页MD-2-Hamiltonian条目；此处$n$为配置坐标数，对应第1章§1.2的$N_c$。",
    "where $\\boldsymbol J=\\begin{bmatrix}\\boldsymbol 0&\\boldsymbol I\\\\-\\boldsymbol I&\\boldsymbol 0\\end{bmatrix}$,",
    "$\\boldsymbol I$为$n\\times n$单位阵，$\\boldsymbol 0$为同尺寸零块；教材坐标顺序为$(\\boldsymbol q,\\boldsymbol p)$。",
    "$\\boldsymbol M$为固定对角质量矩阵；$\\boldsymbol F(\\boldsymbol q)=-\\nabla U(\\boldsymbol q)$为力，$\\boldsymbol f$为完整相空间向量场。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.hamiltonianODE",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。",
    "[EXTRA] EAUDIT01显式固定正对角质量、U/H沿轨道可微、H与真实机械式的全坐标关系；完整q̇=M⁻¹p、ṗ=−∇U及ż=J∇H均保留。I为开时间域，采用环境HasDerivAt；只定义经典轨道关系，不宣称存在或唯一。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-14T11:18:25.413538",
      "before_sha256": "060f78c88768eb4820733e1110c1a0336ed0253ec66e10a891402f7f3bb15254",
      "after_sha256": "0d532722f974677fabd598c616c71ad5d2c872073ced238fb73f320da32b67bf",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "raw_sha256": "f90487ad39a9d4bdb1451ba630cc3fe6108d2c96fcdb5b248c53271bad69c447",
      "reason": "重新视觉核对PDF75–76后合并第一轮A排印修订；C以已绑定reaudit为准，补齐经典梯度、可逆质量及完整流/单步域关联；不采用未批准数学更正。"
    },
    {
      "stage": "EAUDIT25_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:38:36.845458",
      "before_sha256": "c57ddea0fbc0f378ee348acff25f1f9797dcd53ce837f4e047c740ef692199e6",
      "after_sha256": "655a465a617bf1939e501e8a5474960540745c3e80b19bf55bda5d1bc34506d4",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT25/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hamiltonianODE {n : ℕ} (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  IsOpen I ∧
  (∀ z, H z = (∑ i, z (Sum.inr i)^2/(2*m i)) + U (fun i ↦ z (Sum.inl i))) ∧
  (∀ t ∈ I, DifferentiableAt ℝ H (γ t) ∧
    DifferentiableAt ℝ U (fun i ↦ γ t (Sum.inl i))) ∧
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t ∧
    (∀ i, HasDerivAt (fun s ↦ γ s (Sum.inl i)) ((m i)⁻¹*γ t (Sum.inr i)) t) ∧
    ∀ i, HasDerivAt (fun s ↦ γ s (Sum.inr i))
      (-fderiv ℝ U (fun j ↦ γ t (Sum.inl j)) (Pi.single i 1)) t
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MD.Ch02.hamiltonianODE
```lean
def hamiltonianODE {n : ℕ} (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  IsOpen I ∧
  (∀ z, H z = (∑ i, z (Sum.inr i)^2/(2*m i)) + U (fun i ↦ z (Sum.inl i))) ∧
  (∀ t ∈ I, DifferentiableAt ℝ H (γ t) ∧
    DifferentiableAt ℝ U (fun i ↦ γ t (Sum.inl i))) ∧
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t ∧
    (∀ i, HasDerivAt (fun s ↦ γ s (Sum.inl i)) ((m i)⁻¹*γ t (Sum.inr i)) t) ∧
    ∀ i, HasDerivAt (fun s ↦ γ s (Sum.inr i))
      (-fderiv ℝ U (fun j ↦ γ t (Sum.inl j)) (Pi.single i 1)) t
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```

## 原文JSON
```json
{
  "source_id": "MD-2-Hamiltonian",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "53",
  "pdf_page": "75",
  "statement_latex": "and $H=\\boldsymbol p^T\\boldsymbol M^{-1}\\boldsymbol p/2+U(\\boldsymbol q)$ is the Hamiltonian.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\boldsymbol M$为第1章§1.2中固定的对角质量矩阵；$\\boldsymbol q,\\boldsymbol p\\in\\mathbb R^n$，此处$n$对应原书配置坐标数$N_c$。",
    "第1章PDF41/印刷18明确写M is a diagonal mass matrix，并在三维N粒子情形写$\\boldsymbol M=\\operatorname{diag}(m_1,m_1,m_1,\\ldots,m_N,m_N,m_N)$；本条原式使用$\\boldsymbol M^{-1}$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.mechanicalHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。",
    "[EXTRA] EAUDIT01显式∀i,0<mᵢ排除奇异M及零除延拓；保持真实PhaseSpace的(q,p)机械Hamiltonian，固定对角质量来自第1章。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-14T11:18:25.414579",
      "before_sha256": "9582ae8e070d8e8590851645f60a3c7ee8ca7618c0ec81610c8862d58d94746c",
      "after_sha256": "bb20a32ed3bdf6d77ea089d706eb8a7be476eb4c5aa46b151eb8d2f68fbb4168",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "raw_sha256": "f90487ad39a9d4bdb1451ba630cc3fe6108d2c96fcdb5b248c53271bad69c447",
      "reason": "重新视觉核对PDF75–76后合并第一轮A排印修订；C以已绑定reaudit为准，补齐经典梯度、可逆质量及完整流/单步域关联；不采用未批准数学更正。"
    },
    {
      "stage": "EAUDIT25_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:38:36.845458",
      "before_sha256": "01c3ed89700e80cb6e9a0956e7ce3bf2300009183a90502bbc1527eeed78854f",
      "after_sha256": "e0a6a314ffd98e506718c1c550faf4356f5eed978ece9d2965bd5a6de20010f6",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT25/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (_hm : ∀ i, 0 < m i) (U : PotentialEnergy n) : PhaseSpace n → ℝ :=
  massHamiltonian m U
```
### 实际依赖 MolecularDynamics.CoordinateMasses
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Hamiltonian
```lean
abbrev Hamiltonian (n : ℕ) := PhaseSpace n → ℝ
```
### 实际依赖 MolecularDynamics.KineticEnergy
```lean
abbrev KineticEnergy (n : ℕ) := Momentum n → ℝ
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
### 实际依赖 MD.Ch02.mechanicalHamiltonian
```lean
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (_hm : ∀ i, 0 < m i) (U : PotentialEnergy n) : PhaseSpace n → ℝ :=
  massHamiltonian m U
```
### 实际依赖 MolecularDynamics.momentumKineticEnergy
```lean
noncomputable def momentumKineticEnergy {n : ℕ} (m : CoordinateMasses n)
    (p : Momentum n) : ℝ := ∑ i, (p i)^2 / (2 * m i)
```

## 原文JSON
```json
{
  "source_id": "MD-2-Euler",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "54",
  "pdf_page": "76",
  "statement_latex": "The simplest scheme is certainly Euler’s method which advances the solution from timestep to timestep by the formula\\textsuperscript{1}\n\\[\\boldsymbol z_{n+1}=\\boldsymbol z_n+h\\boldsymbol f(\\boldsymbol z_n).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$h$为步长；下标$n$为时间步而非向量分量。",
    "原页formula后接脚注1；该脚注说明粗体向量下标表示时间步，若同时标时间步和分量，可写$z_{n,i}$表示时间步$n$的第$i$分量。",
    "$\\boldsymbol f$为ODE向量场，原页与$\\boldsymbol z$一样使用粗体；本式是显式Euler的一步更新。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.euler",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT25_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:38:36.845458",
      "before_sha256": "6cea9f828e9e8ddca2da90afe4ef5392bec4abce3eb0d33046d1e343492457ec",
      "after_sha256": "f37ec337307ed701acdeb901974267d7d87d54060d5bf1ea880e79613c9df637",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT25/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z
```
### 实际依赖 MD.Ch02.euler
```lean
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z
```

## 原文JSON
```json
{
  "source_id": "MD-2-OneStep",
  "kind": "definition",
  "label": null,
  "section": "2",
  "printed_page": "54",
  "pdf_page": "76",
  "statement_latex": "Suppose that the system under study has a well defined flow map $\\mathscr F_t$ defined on the phase space (which is assumed to exclude any singular points of the potential energy function). The solution of the initial value problem, $\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z)$, $\\boldsymbol z(0)=\\boldsymbol\\zeta$, may be written $\\boldsymbol z(t,\\boldsymbol\\zeta)$ (with $\\boldsymbol z(0,\\boldsymbol\\zeta)=\\boldsymbol\\zeta$), and the flow-map $\\mathscr F_t$ satisfies $\\mathscr F_t(\\boldsymbol\\zeta)=\\boldsymbol z(t,\\boldsymbol\\zeta)$. A one-step method, starting from a given point, approximates a point on the solution trajectory at a given time $h$ units later. Such a method defines a map $\\mathscr G_h$ of the phase space as illustrated in Fig. 2.1.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathscr F_t(\\boldsymbol\\zeta)=\\boldsymbol z(t,\\boldsymbol\\zeta)$为给定实际ODE的流；初值为$\\boldsymbol z(0,\\boldsymbol\\zeta)=\\boldsymbol\\zeta$。",
    "$\\mathscr G_h$为相空间上的单步近似映射，其目标是$h$时间单位后的实际流$\\mathscr F_h$；图2.1标$\\boldsymbol z_1=\\mathscr G_h(\\boldsymbol\\zeta)$并与$\\boldsymbol z(h,\\boldsymbol\\zeta)=\\mathscr F_h(\\boldsymbol\\zeta)$比较。",
    "该相空间被假定排除势能函数的所有奇异点；本段未规定定量误差、收敛性或误差阶，近似质量由后面的误差定义衡量。",
    "原页使用RSFS花体流映射符号，故记作$\\mathscr F_t,\\mathscr G_h$；原页解记号中时间与初值以逗号分隔。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch02.numericalTrajectory",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] EAUDIT01在开放正规相空间D排除势能不可微/奇异点；F的已给全时解族与初值/完整机械ODE相联，G作用于同一D，Z关联全部实际n次迭代。oneStepTargetDifference明确目标F_h与G_h的差；原段未规定定量近似质量，未加入虚构误差阶或收敛结论。全时流是此接口的给定模型资格，不是解存在定理。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT01_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-14T11:18:25.414579",
      "before_sha256": "50854266d91d56e9de89433ff4f0dbdea0937e0f64fc529cb88ba06fbc24429e",
      "after_sha256": "3792fc44ab44d066d0a9b90144eb9e31d3edb9e97e91023d382e298f921bb50f",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "raw_sha256": "f90487ad39a9d4bdb1451ba630cc3fe6108d2c96fcdb5b248c53271bad69c447",
      "reason": "重新视觉核对PDF75–76后合并第一轮A排印修订；C以已绑定reaudit为准，补齐经典梯度、可逆质量及完整流/单步域关联；不采用未批准数学更正。"
    },
    {
      "stage": "EAUDIT25_LOCAL_REPAIR",
      "timestamp": "2026-10-15T11:38:36.845458",
      "before_sha256": "6223095ced72971f7e6d3d677730657dee01a6ef9634a0836212b0f0fbbdab3a",
      "after_sha256": "733095cd145815271378aeffac5f7c05f91eb2d63186fca861d4f4c2760793c1",
      "changed_fields": [],
      "raw_return": "blueprint/ch02/mathcopilot_results/BATCH01_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT25/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def numericalTrajectory {n : ℕ} (m : Fin n → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (D : Set (SymplecticCoordinates n)) (G F : ℝ → D → D)
    (γ : ℝ → D → SymplecticCoordinates n) (Z : D → ℝ → ℕ → D) : Prop :=
  IsOpen D ∧ (∀ z ∈ D, DifferentiableAt ℝ U (fun i ↦ z (Sum.inl i))) ∧
  ∀ ζ : D, γ 0 ζ=ζ.1 ∧
    hamiltonianODE m hm U H (fun t ↦ γ t ζ) Set.univ ∧
    (∀ t, (F t ζ).1=γ t ζ) ∧
    ∀ h ν, Z ζ h ν=(G h)^[ν] ζ

def numericalIterate {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (ν : ℕ) : E :=
  (G h)^[ν] ζ

def oneStepTargetDifference {n : ℕ} {D : Set (SymplecticCoordinates n)}
    (G F : ℝ → D → D) (h : ℝ) (ζ : D) : ℝ :=
  ‖(G h ζ).1-(F h ζ).1‖
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinateMatrix
```lean
abbrev SymplecticCoordinateMatrix (Nc : ℕ) :=
  Matrix (Fin Nc ⊕ Fin Nc) (Fin Nc ⊕ Fin Nc) ℝ
```
### 实际依赖 MolecularDynamics.SymplecticCoordinates
```lean
abbrev SymplecticCoordinates (Nc : ℕ) := (Fin Nc ⊕ Fin Nc) → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch02.hamiltonianODE
```lean
def hamiltonianODE {n : ℕ} (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  IsOpen I ∧
  (∀ z, H z = (∑ i, z (Sum.inr i)^2/(2*m i)) + U (fun i ↦ z (Sum.inl i))) ∧
  (∀ t ∈ I, DifferentiableAt ℝ H (γ t) ∧
    DifferentiableAt ℝ U (fun i ↦ γ t (Sum.inl i))) ∧
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t ∧
    (∀ i, HasDerivAt (fun s ↦ γ s (Sum.inl i)) ((m i)⁻¹*γ t (Sum.inr i)) t) ∧
    ∀ i, HasDerivAt (fun s ↦ γ s (Sum.inr i))
      (-fderiv ℝ U (fun j ↦ γ t (Sum.inl j)) (Pi.single i 1)) t
```
### 实际依赖 MD.Ch02.numericalIterate
```lean
def numericalIterate {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (ν : ℕ) : E :=
  (G h)^[ν] ζ
```
### 实际依赖 MD.Ch02.numericalTrajectory
```lean
def numericalTrajectory {n : ℕ} (m : Fin n → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (D : Set (SymplecticCoordinates n)) (G F : ℝ → D → D)
    (γ : ℝ → D → SymplecticCoordinates n) (Z : D → ℝ → ℕ → D) : Prop :=
  IsOpen D ∧ (∀ z ∈ D, DifferentiableAt ℝ U (fun i ↦ z (Sum.inl i))) ∧
  ∀ ζ : D, γ 0 ζ=ζ.1 ∧
    hamiltonianODE m hm U H (fun t ↦ γ t ζ) Set.univ ∧
    (∀ t, (F t ζ).1=γ t ζ) ∧
    ∀ h ν, Z ζ h ν=(G h)^[ν] ζ
```
### 实际依赖 MD.Ch02.oneStepTargetDifference
```lean
def oneStepTargetDifference {n : ℕ} {D : Set (SymplecticCoordinates n)}
    (G F : ℝ → D → D) (h : ℝ) (ζ : D) : ℝ :=
  ‖(G h ζ).1-(F h ζ).1‖
```
### 实际依赖 MolecularDynamics.textbookHamiltonianVectorField
```lean
noncomputable def textbookHamiltonianVectorField {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc :=
  textbookJ Nc *ᵥ (fun i => (fderiv ℝ H z) (Pi.single i 1))
```
### 实际依赖 MolecularDynamics.textbookJ
```lean
noncomputable def textbookJ (Nc : ℕ) : SymplecticCoordinateMatrix Nc :=
  Matrix.fromBlocks 0 1 (-1) 0
```
