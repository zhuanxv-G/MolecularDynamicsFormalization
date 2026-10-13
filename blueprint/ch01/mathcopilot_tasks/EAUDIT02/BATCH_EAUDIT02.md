# EAUDIT02：第1章§1.1签名修复及补材料复审

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
    "正质量及正Planck参数；按经典解解释，Φ在时间/位置联合C2，保证总导数算子表示实际偏导数；不声明解存在。"
  ],
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T13:51:34.594771",
      "before_sha256": "4f1477c2e45fb4684278e4cd3632ba088f0f85bc88a68ec0eadb598073bcf5c5",
      "after_sha256": "4f1477c2e45fb4684278e4cd3632ba088f0f85bc88a68ec0eadb598073bcf5c5",
      "changed_fields": [],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "f42249abe5a3dedc7bee7a55d8ef6043c8b1e758d58f77a92cff033e10d267ac",
      "reason": "PDF28–30视觉核对；Newton补回原页第i个核的遗漏词；Schrodinger提案当前字段已一致，保留已有文本；原书数学不改。Newton/HardSphere签名按网站FAIL加强模型资格及补全动力学；其余条目不改。"
    }
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

## 当前完整Lean签名/定义
```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ContDiff ℝ 2 (Function.uncurry Φ) ∧
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q
```

上下文：Lean4.34.0/Mathlibv4.34.0；namespace MD.Ch01；noncomputable section；
open Set Filter MolecularDynamics MolecularDynamics.Chapter01Review；open scoped Topology BigOperators ContDiff InnerProductSpace。
标准Mathlib符号按固定版本展开；项目实际定义如下。多重同名候选均列出，不猜测解析。

## 已绑定旧返回及本次修复
```json
{
  "lean_decl": "MD.Ch01.schrodingerEquation",
  "verdict": "NEEDS_HUMAN",
  "explanation": "已读取附件Ch01.lean第229–235行的实际定义。显式表达式包含联合C2条件、所有t和q上的方程、时间导数、负号、ℏ²、39项空间求和及实势能乘Φ。若空间坐标按每粒子三个方向排列，零基索引i.val/3可对应原书μ_j。然而planckConstant、quantumMass、primitivePotential、waveFunction和secondPartial的真实定义未提供；当前工作区及共享目录中未找到ReviewDefinitions.lean，亦无本批MANIFEST.json。不能凭名称确认质量与参数确实为正、位置域确实为ℝ³⁹、波函数确实复值、secondPartial确实是指定方向的二阶偏导。正物理参数及明确限定经典C2解的解释可以合理，但联合全域C2强于原文最低偏导要求，且仍须核实势能定义域是否排除奇点。本条是定义，语义保留判定与sorry或证明完成度无关。",
  "counterexample": null,
  "suggested_fix": "补齐与附件Ch01.lean同一版本的ReviewDefinitions.lean、相关导入及MANIFEST.json，展开上述五个辅助定义。确认secondPartial的方向、阶数和坐标顺序，并明确这是经典C2解谓词；若U_P仅在非碰撞域定义，应显式给出该域和时间域，调整量词范围后重新审计。"
}
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:18 namespace MolecularDynamics.Chapter01Review
```lean
abbrev planckConstant := {h : ℝ // 0 < h}
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:20 namespace MolecularDynamics.Chapter01Review
```lean
abbrev primitivePotential := Q13 → ℝ
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:15 namespace MolecularDynamics.Chapter01Review
```lean
abbrev Q13 := Position 39
```

### MolecularDynamics/Notation.lean:13 namespace MolecularDynamics
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:19 namespace MolecularDynamics.Chapter01Review
```lean
abbrev quantumMass := Fin 13 → {m : ℝ // 0 < m}
```

### Blueprint/Ch01.lean:257 namespace MD.Ch01
```lean
def schrodingerEquation (h : planckConstant) (μ : quantumMass)
    (U : primitivePotential) (Φ : waveFunction) : Prop :=
  ContDiff ℝ 2 (Function.uncurry Φ) ∧
  ∀ t q, Complex.I * (h.val : ℂ) * deriv (fun s => Φ s q) t =
    -(h.val : ℂ)^2 * ∑ i : Fin 39,
      secondPartial (Φ t) q i / (2 * (μ ⟨i.val / 3, by omega⟩).val : ℂ) +
      (U q : ℂ) * Φ t q

/-- source_id: MD-1.1-NewtonModel · definition · printed p.6 / PDF p.29
[EXTRA] EAUDIT02: positive particle masses repeated over exactly three coordinates;
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:23 namespace MolecularDynamics.Chapter01Review
```lean
def secondPartial {n : ℕ} (f : Position n → ℂ) (q : Position n) (i : Fin n) : ℂ :=
  deriv (deriv (fun s : ℝ => f (q + s • coordinateDirection i))) 0
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:21 namespace MolecularDynamics.Chapter01Review
```lean
def coordinateDirection {n : ℕ} (i : Fin n) : Position n :=
  WithLp.toLp 2 (fun j => if j = i then 1 else 0)
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:16 namespace MolecularDynamics.Chapter01Review
```lean
abbrev waveFunction := ℝ → Q13 → ℂ
```


## 原文JSON
```json
{
  "source_id": "MD-1.1-NewtonModel",
  "kind": "definition",
  "label": null,
  "section": "1.1",
  "printed_page": "6",
  "pdf_page": "29",
  "statement_latex": "where the forces are determined from the potential energy function $U$. Denoting the coordinates of the $i$th nucleus of an N-atom system by $q_{i,x},q_{i,y},q_{i,z}$, and the atomic mass by $m_i$, the equations of motion for the $i$th nucleus can be written out as\n\\[m_i\\frac{\\mathrm d^2q_{i,x}}{\\mathrm dt^2}=-\\frac{\\partial U}{\\partial q_{i,x}},\\qquad m_i\\frac{\\mathrm d^2q_{i,y}}{\\mathrm dt^2}=-\\frac{\\partial U}{\\partial q_{i,y}},\\qquad m_i\\frac{\\mathrm d^2q_{i,z}}{\\mathrm dt^2}=-\\frac{\\partial U}{\\partial q_{i,z}}.\\tag{1.2}\\]\nIt is important to recognize that (1.2) does not, itself, give a complete description of the motion; it must be supplemented by initial conditions (positions and velocities given at some specified instant) for all atoms.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "$U=U_{BO}$仅依赖核位置；$n=3N$，每粒子质量重复三次。"
  ],
  "review_status": "CORRECTED",
  "issues": [
    {
      "code": "SOURCE_WORD_OMISSION",
      "detail": "statement_latex中的the equations of motion for the nucleus遗漏原页第二次出现的ith，应为the equations of motion for the $i$th nucleus。",
      "status": "local_verified",
      "receipt": "BATCH02_result.json"
    }
  ],
  "lean_decl": "MD.Ch01.newtonInitialValueModel",
  "extra_assumptions": [
    "n为展平坐标数；三维实例n=3N，质量限制通过coordinateMassesOfParticles给出。",
    "[EXTRA] EAUDIT02：精确N*3维与逐粒子重复质量；正质量；含初始时刻的开放连通时间域；势能沿轨迹可微，资格保证实际梯度而非总化默认值。一般n维定义仅为辅助。"
  ],
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T13:51:34.596250",
      "before_sha256": "b6f92f95a5c4d8bad137ef9b1bf7c10f8c2829d4aa33e8a31b14f812217fe82c",
      "after_sha256": "23ae20c5cd1a427adc82851528cdab272598465bc1006b75b885c5fb215142c5",
      "changed_fields": [
        "statement_latex"
      ],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "f42249abe5a3dedc7bee7a55d8ef6043c8b1e758d58f77a92cff033e10d267ac",
      "reason": "PDF28–30视觉核对；Newton补回原页第i个核的遗漏词；Schrodinger提案当前字段已一致，保留已有文本；原书数学不改。Newton/HardSphere签名按网站FAIL加强模型资格及补全动力学；其余条目不改。"
    }
  ],
  "old_ids": [
    "CH01-007",
    "CH01-008",
    "CH01-009"
  ],
  "source_page_verification": "VERIFIED_RENDERED; 2026-10-13 PDF29; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```

## 当前完整Lean签名/定义
```lean
def newtonInitialValueModel {N : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N * 3)) (Q : Set (Position (N * 3)))
    (I : Set ℝ) (q : ℝ → Position (N * 3)) (t₀ : ℝ)
    (q₀ v₀ : Position (N * 3)) : Prop :=
  classicalNewtonInitialValueModel (coordinateMassesOfParticles (d := 3) m)
    U Q I q t₀ q₀ v₀
```

上下文：Lean4.34.0/Mathlibv4.34.0；namespace MD.Ch01；noncomputable section；
open Set Filter MolecularDynamics MolecularDynamics.Chapter01Review；open scoped Topology BigOperators ContDiff InnerProductSpace。
标准Mathlib符号按固定版本展开；项目实际定义如下。多重同名候选均列出，不猜测解析。

## 已绑定旧返回及本次修复
```json
{
  "lean_decl": "MD.Ch01.newtonInitialValueModel",
  "verdict": "FAIL",
  "explanation": "已展开Ch01.lean第54–59行的IsNewtonTrajectoryOn：它要求每个t∈I时q(t)∈Q，q和deriv q分别有真实HasDerivAt见证，并满足质量算子作用于二阶导数等于−gradient U；第241–244行再加入q(t₀)=q₀和真实初始速度条件，因此时间导数及两类初值没有被总化deriv等式替代。但定义没有要求t₀∈I，甚至允许I为空，故初值可以完全脱离牛顿方程适用的时间域；这缺失了同一运动在指定初始时刻满足模型的条件。此外，已读PotentialEnergy n只是Position n→ℝ，谓词未要求U沿轨迹可微，不能保证总化gradient代表原文真实偏导。任意n和坐标质量可作为推广，但注释中的n=3N及粒子质量重复并未成为本声明的约束或物理实例化条件。massOperator及coordinateMassesOfParticles只在旧缓存找到，未与本批版本绑定；时间域缺口直接来自已提供定义，足以判FAIL，不依赖这些辅助算子的实现。判定与证明完成度无关。",
  "counterexample": "取n=3，m_i=1，U=0，Q=ℝ³，I=∅，t₀=0，q(t)=t²e₁，q₀=v₀=0。IsNewtonTrajectoryOn中的全部时间量词为空，且q(0)=0、q′(0)=0，因此该Lean谓词成立；但q″(0)=2e₁，与零势能下原文要求的零加速度不符。漏洞也存在于非空时间域：取I=(1,2)，令q(t)=t²e₁当t<1/2，否则q(t)=0，则I内满足自由运动，而指定初始时刻0仍不满足牛顿方程。",
  "suggested_fix": "要求初始时刻属于解的时间域，宜令I为包含t₀的非空开放区间，或显式加入t₀∈interior I；这样初始位置属于Q也可由轨迹条件得到。加入U在相关位置的DifferentiableAt或真实梯度见证，保证力是原文偏导。保留通用坐标版本时，另给n=3N、正粒子质量及coordinateMassesOfParticles的物理实例化声明，并补齐本批依赖和MANIFEST.json核实质量算子。"
}
```

### MolecularDynamics/Chapter01/ParticleCoordinates.lean:20 namespace MolecularDynamics
```lean
abbrev ParticleMasses (N : ℕ) := Fin N → ℝ
```

### MolecularDynamics/Notation.lean:13 namespace MolecularDynamics
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics/Notation.lean:21 namespace MolecularDynamics
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```

### Blueprint/Ch01.lean:75 namespace MD.Ch01
```lean
def classicalNewtonInitialValueModel {n : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Q : Set (Position n)) (I : Set ℝ)
    (q : ℝ → Position n) (t₀ : ℝ) (q₀ v₀ : Position n) : Prop :=
  (∀ i, 0 < m i) ∧ IsOpen I ∧ IsPreconnected I ∧ t₀ ∈ I ∧
  (∀ t ∈ I, DifferentiableAt ℝ U (q t)) ∧
  IsNewtonTrajectoryOn m U Q I q ∧ q t₀ = q₀ ∧ HasDerivAt q v₀ t₀
```

### MolecularDynamics/Chapter01/NBody.lean:19 namespace MolecularDynamics
```lean
abbrev CoordinateMasses (n : ℕ) := Fin n → ℝ
```

### Blueprint/Ch01.lean:54 namespace MD.Ch01
```lean
def IsNewtonTrajectoryOn {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (I : Set ℝ) (q : ℝ → Position n) : Prop :=
  (∀ t ∈ I, q t ∈ Q) ∧ ∀ t ∈ I,
    HasDerivAt q (deriv q t) t ∧
    HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
    massOperator m (deriv (deriv q) t) = -gradient U (q t)
```

### MolecularDynamics/Chapter01/ParticleCoordinates.lean:28 namespace MolecularDynamics
```lean
def coordinateMassesOfParticles {N d : ℕ} (m : ParticleMasses N) :
    CoordinateMasses (N * d) :=
  fun k => m ((particleCoordinateEquiv N d).symm k).1
```

### MolecularDynamics/Chapter01/LocalTrajectories.lean:18 namespace MolecularDynamics
```lean
noncomputable def massOperator {n : ℕ} (μ : CoordinateMasses n) :
    Velocity n →L[ℝ] Momentum n :=
  (Matrix.toEuclideanLin (diagonalMassMatrix μ)).toContinuousLinearMap
```

### MolecularDynamics/Notation.lean:15 namespace MolecularDynamics
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics/Notation.lean:14 namespace MolecularDynamics
```lean
abbrev Velocity (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### MolecularDynamics/Chapter01/NBody.lean:22 namespace MolecularDynamics
```lean
def diagonalMassMatrix {n : ℕ} (masses : CoordinateMasses n) : MassMatrix n :=
  Matrix.diagonal masses
```

### MolecularDynamics/Notation.lean:18 namespace MolecularDynamics
```lean
abbrev MassMatrix (n : ℕ) := Matrix (Fin n) (Fin n) ℝ
```

### Blueprint/Ch01.lean:270 namespace MD.Ch01
```lean
def newtonInitialValueModel {N : ℕ} (m : ParticleMasses N)
    (U : PotentialEnergy (N * 3)) (Q : Set (Position (N * 3)))
    (I : Set ℝ) (q : ℝ → Position (N * 3)) (t₀ : ℝ)
    (q₀ v₀ : Position (N * 3)) : Prop :=
  classicalNewtonInitialValueModel (coordinateMassesOfParticles (d := 3) m)
    U Q I q t₀ q₀ v₀
```

### MolecularDynamics/Chapter01/ParticleCoordinates.lean:25 namespace MolecularDynamics
```lean
def particleCoordinateEquiv (N d : ℕ) : Fin N × Fin d ≃ Fin (N * d) :=
  finProdFinEquiv
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
  "repair_log": [
    {
      "stage": "EAUDIT02_LOCAL_PAGE_RECHECK",
      "timestamp": "2026-10-13T13:51:34.596250",
      "before_sha256": "15730fb9a4bf36a0a92a8cac7cafe9f5aef2ef273a48307e2738b8dae3fcd89a",
      "after_sha256": "15730fb9a4bf36a0a92a8cac7cafe9f5aef2ef273a48307e2738b8dae3fcd89a",
      "changed_fields": [],
      "raw_return": "blueprint/ch01/mathcopilot_results/BATCH02_result.json",
      "raw_sha256": "f42249abe5a3dedc7bee7a55d8ef6043c8b1e758d58f77a92cff033e10d267ac",
      "reason": "PDF28–30视觉核对；Newton补回原页第i个核的遗漏词；Schrodinger提案当前字段已一致，保留已有文本；原书数学不改。Newton/HardSphere签名按网站FAIL加强模型资格及补全动力学；其余条目不改。"
    }
  ],
  "old_ids": [
    "CH01-010"
  ],
  "source_page_verification": "VERIFIED_RENDERED; 2026-10-13 PDF30; validation/EAUDIT02/SOURCE_PAGE_VERIFICATION.json"
}
```

## 当前完整Lean签名/定义
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

上下文：Lean4.34.0/Mathlibv4.34.0；namespace MD.Ch01；noncomputable section；
open Set Filter MolecularDynamics MolecularDynamics.Chapter01Review；open scoped Topology BigOperators ContDiff InnerProductSpace。
标准Mathlib符号按固定版本展开；项目实际定义如下。多重同名候选均列出，不猜测解析。

## 已绑定旧返回及本次修复
```json
{
  "lean_decl": "MD.Ch01.hardSphereModel",
  "verdict": "FAIL",
  "explanation": "已读取Ch01.lean第250–254行的完整定义：正半径、正质量和单次位置距离下界均显式存在；接触时要求两粒子的总动量及总动能守恒，两个守恒量的系数和形式正确。但这只是双粒子瞬时必要条件，没有轨迹、全部时间上的不可穿透、碰撞后的分离条件或标准碰撞更新关系。当w₁=v₁、w₂=v₂时，守恒等式自动成立，即使粒子正迎面接近并将立即相互穿透。原文没有展开标准规则的公式，不意味着任意守恒速度都可作为硬球碰撞结果。[EXTRA]中只编码必要条件的说明属于删减模型内容，不能使整个hardSphereModel与原文等价。V3的真实定义当前未提供，无法认证其确实为欧氏ℝ³；即便按原文所需对象解释，仍有明确反例，故缺失条款足以判FAIL。判定与证明完成度无关。",
  "counterexample": "按原文欧氏ℝ³取R₁=R₂=m₁=m₂=1，q₁=(0,0,0)，q₂=(2,0,0)，v₁=w₁=(1,0,0)，v₂=w₂=(−1,0,0)。两球恰好接触，总动量碰撞前后均为0，总动能均为1，所以定义中的全部显式条件成立。但按所给碰撞后速度运动，小正时间t时球心距离为2−2t<2，立即穿透。等质量迎面完全弹性硬球碰撞应使两球反向离开。",
  "suggested_fix": "补齐本批V3定义及版本绑定。将瞬时守恒关系明确作为必要条件组件；完整硬球模型应包含所有不同粒子对在全部时间上的距离下界、碰撞外运动和碰撞更新。对标准无摩擦二体碰撞，可显式规定接触、入射条件、沿球心连线的冲量及法向相对速度反转，并保证碰撞后分离；正半径和正质量作为物理资格合理。"
}
```

### MolecularDynamics/Chapter01/ReviewDefinitions.lean:14 namespace MolecularDynamics.Chapter01Review
```lean
abbrev V3 := Position 3
```

### MolecularDynamics/Notation.lean:13 namespace MolecularDynamics
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```

### Blueprint/Ch01.lean:85 namespace MD.Ch01
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
```

### Blueprint/Ch01.lean:286 namespace MD.Ch01
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

