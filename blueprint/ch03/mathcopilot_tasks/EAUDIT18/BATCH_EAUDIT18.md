# EAUDIT18：第3章§3.7.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.7.1-HardCorePotential",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "Splitting methods are suggested by considering a formal hard-sphere Hamiltonian\n\\[H_{\\mathrm{h.s.}}=p^TM^{-1}p/2+U(q)+U_{\\mathrm{h.s.}},\\]\nwhere $U_{\\mathrm{h.s.}}$ is assumed to be infinite for overlapping configurations (some $\\|q_i-q_j\\|\\le\\sigma_i+\\sigma_j$) and zero otherwise.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p133括号印刷≤与p132接触等号允许冲突；不静默改成<。"
    }
  ],
  "lean_decl": "MD.Ch03.hardCorePotential",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 原印≤接触也取∞独立忠实定义，并补K+U+U_hs完整Hamiltonian；原接触允许的物理版本改名保留辅助。两种边界约定明确区分，不擅自勘误原书。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:32:10.075381",
      "before_sha256": "e64d26539d0b11ff060f1a98c4d9e0a3f8250f05a9afd384a2aeb2cf8da89ce2",
      "after_sha256": "a72e4bf2415aa566a6a56f36258b9049e11a8afc7455743a9d2d4f1669a0d6aa",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤ else 0

def hardSphereHamiltonianPrinted {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (U : (Fin N → Position d) → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i))+U q : ℝ)

def hardCorePotential_contactAllowed {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  @ite ENNReal (q ∈ hardCoreDomain σ) (Classical.propDecidable _) 0 ⊤
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
### 实际依赖 MD.Ch03.hardCorePotential
```lean
def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤ else 0
```
### 实际依赖 MD.Ch03.hardCorePotential_contactAllowed
```lean
def hardCorePotential_contactAllowed {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  @ite ENNReal (q ∈ hardCoreDomain σ) (Classical.propDecidable _) 0 ⊤
```
### 实际依赖 MD.Ch03.hardSphereHamiltonianPrinted
```lean
def hardSphereHamiltonianPrinted {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (U : (Fin N → Position d) → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i))+U q : ℝ)
```

## 原文JSON
```json
{
  "source_id": "MD-3.7.1-ObstacleReflection",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "134",
  "pdf_page": "156",
  "statement_latex": "The coefficient $\\alpha$ is chosen so that the kinetic energy is conserved through collision, thus\n\\[\\alpha=-2\\frac{u_\\perp\\cdot\\overline P}{u_\\perp\\cdot u_\\perp}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原文模型：原点固定球与质量1的运动球，两球半径均0.5；接触时‖q_c‖=1，u_⊥=q_c≠0。",
    "P̄=p−(h/2)∇U(q)，q_c=q+τ_cP̄；α=−2⟨u_⊥,P̄⟩/⟨u_⊥,u_⊥⟩，P̂=P̄+αu_⊥。Lean的第二参数p对应P̄，返回值是P̂而非α。",
    "该定义实现反射动量；能量守恒性质关联ElasticEnergy。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.obstacleReflection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:32:10.077383",
      "before_sha256": "00932443d3aee729113ffbc2c311d4a068e0ce02f2f922d1065f6ac0ffbfa31e",
      "after_sha256": "6a62c7493010823edd1e718de57cec6762e2b3369a89a3a23c07b8d4933710ba",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch03.obstacleReflection
```lean
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
```

## 原文JSON
```json
{
  "source_id": "MD-3.7.1-PrimitiveDefect",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.7.1",
  "printed_page": "134",
  "pdf_page": "156",
  "statement_latex": "We next calculate the change in energy in a single step by inserting $Q$ and $P$ into the Hamiltonian and expanding around the point of collision $q_c$, obtaining\n\\[\\Delta H\\stackrel{\\mathrm{def}}=H(Q,P)-H(q,p)=-(h-2\\tau_c)\\frac{q_c^T\\overline P}{q_c^Tq_c}q_c^T\\nabla U(q_c)+O(h^2).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "沿用原点固定球、运动球质量1、两球半径均0.5的模型；接触点‖q_c‖=1，讨论步内单碰撞0<τ_c<h。",
    "H(q,p)=‖p‖²/2+U(q)；P̄=p−(h/2)∇U(q)，q_c=q+τ_cP̄，P̂=P̄+αq_c，Q=q_c+(h−τ_c)P̂，P=P̂−(h/2)∇U(Q)。",
    "公式的P̄是第一次半kick后的动量。Lean形参pbar却是整步初始动量；二者差是否可吸收到O(h²)须检查局部性，不能靠符号名称断定。"
  ],
  "issues": [
    {
      "code": "NEEDS_HUMAN",
      "detail": "书中P̄与签名初始pbar的差异及通过O(h²)吸收的正则性需要独立审校。"
    }
  ],
  "lean_decl": "MD.Ch03.primitiveDefect",
  "reusable_proofs": [],
  "extra_assumptions": [
    "C³势、固定非零qc、真实初末碰撞步族和0<tc(h)<h；O(h²)以小正h的一致界表示。",
    "[EXTRA] 仅小正h、单位接触点及初态趋近接触点的首次单碰撞物理分支；系数使用原书碰前P̄（含半kick），不再用初始p冒充；保留O(h²)余项。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:32:10.077383",
      "before_sha256": "dfb1721f2443d1e7ad060226b3b72f532896b17291287782cd59c87af45bfb88",
      "after_sha256": "1c6c6745180860f3f3593fa00c2b9624bf97dd05ba704b657a68007ff25ebdb2",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem primitiveDefect :
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ) (Δ : ℝ), 0 < Δ → ContDiff ℝ 3 U → qc ≠ 0 → ‖qc‖=1 →
    Tendsto (fun h ↦ (initial h).1) (𝓝[>] 0) (𝓝 qc) →
    (∀ h ∈ Ioo 0 Δ, 0 < tc h ∧ tc h < h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      (∀ t ∈ Ioo 0 (tc h), 1 < ‖(initial h).1+t • pminus‖) ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))+
        (h-2*tc h)*(inner ℝ qc (pbar+(h/2) • (-gradient U (initial h).1))/inner ℝ qc qc)*inner ℝ qc (gradient U qc)| ≤ C*h^2 := by
  sorry
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch03.obstacleReflection
```lean
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
```

## 原文JSON
```json
{
  "source_id": "MD-3.7.1-FreeHardSphereHamiltonian",
  "kind": "definition",
  "label": null,
  "section": "3.7.1",
  "printed_page": "133",
  "pdf_page": "155",
  "statement_latex": "The hard sphere system described by\n\\[H_{\\mathrm{free}}=p^TM^{-1}p/2+U_{\\mathrm{h.s.}}\\]\nconsists of purely ballistic (straight line) motion punctuated by momentum jumps.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "位置不接触时自由ODE为q′=M⁻¹p,p′=0；事件复合与真实动量反射在CollisionComposition/CollisionRegularity/ElasticEnergy保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.freeHardSphereHamiltonian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "正质量下用WithTop ℝ保留有限动能和+∞障碍；沿用p132接触允许的边界，p133≤疑点仍由HardCorePotential保留。",
    "[EXTRA] 忠实保留原印≤无穷势并显式正质量，接触允许物理版本另名存档；补非接触直线运动q′=M⁻¹p,p′=0，接触弹性反射由ElasticReflection/ElasticEnergy原有条目承担。"
  ],
  "statement_scope": "原印自由硬球Hamiltonian、非接触弹道ODE；所引动力学中接触弹性反射关系及能量保存由MD-3.7-ElasticReflection和MD-3.7-ElasticEnergy承担。原印≤边界与接触允许物理版本独立命名。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT18_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:32:10.077383",
      "before_sha256": "f55cf5b35261a9c39c484a19b2c898c6b94f6cfdb28441cc4e75bb6bc1488191",
      "after_sha256": "05d01985e08988ec7650ac326964d32d3551b5745f24e3ac7a3c334c90e13605",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT18/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def freeHardSphereHamiltonian {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ)

theorem freeHardSphereHamiltonian_ballistic {N d : ℕ} (m : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) :
    (∀ t : ℝ, HasDerivAt (fun s ↦ fun i ↦ q i+(s/m i) • p i)
      (fun i ↦ (m i)⁻¹ • p i) t) ∧
    (∀ t : ℝ, HasDerivAt (fun _ : ℝ ↦ p) 0 t) := by
  sorry

def freeHardSphereHamiltonian_contactAllowed {N d : ℕ} (m σ : Fin N → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  @ite (WithTop ℝ) (q ∈ MolecularDynamics.Chapter03Review.hardCoreDomain σ)
    (Classical.propDecidable _) ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ) ⊤
```
### 实际依赖 MolecularDynamics.Chapter03Review.hardCoreDomain
```lean
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch03.freeHardSphereHamiltonian
```lean
def freeHardSphereHamiltonian {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ)
```
### 实际依赖 MD.Ch03.freeHardSphereHamiltonian_contactAllowed
```lean
def freeHardSphereHamiltonian_contactAllowed {N d : ℕ} (m σ : Fin N → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  @ite (WithTop ℝ) (q ∈ MolecularDynamics.Chapter03Review.hardCoreDomain σ)
    (Classical.propDecidable _) ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ) ⊤
```
### 实际依赖 MD.Ch03.hardCoreDomain
```lean
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}
```
