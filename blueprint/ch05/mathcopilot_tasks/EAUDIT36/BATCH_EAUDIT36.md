# EAUDIT36：第5章§5.4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-UniformMicroErgodic",
  "kind": "definition",
  "label": "Definition 5.1",
  "section": "5.4.1",
  "printed_page": "197",
  "pdf_page": "218",
  "statement_latex": "Definition 5.1 A Hamiltonian system is said to be ergodic on an energy surface $\\Sigma_E$ (microcanonically ergodic) if, for almost all trajectories $\\Gamma$ emanating from initial conditions on $\\Sigma_E$, and for any observable $g$, the following holds $\\bar g_\\Gamma=\\operatorname{Av}_{H=E}(g)$, where $\\bar g_\\Gamma$ is defined in (5.9). By “almost all” we mean that there could be a low-dimensional subset for which the trajectory averages fail to equal the space averages.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\Gamma=\\{z(t):t\\in[0,\\infty)\\}$ 是轨道；$\\bar g_\\Gamma$ 按(5.9)定义（PDF216/印刷195）；$\\operatorname{Av}_{H=E}$ 是微正则概率空间平均；$\\Sigma_E=\\{H=E\\}$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.uniformMicroErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]沿用前文光滑可观测量且明确µ可积，避免给不存在空间平均的函数套等式；AE采用真实µ_E零测资格。",
    "[EXTRA] 明示C² Hamiltonian、常非退化反对称J生成的实际流、能量保持与正有限正则能量面背景；保留AE后∀可积光滑观测量的原量词顺序。 并恢复C∞而非Cω资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.827007",
      "before_sha256": "a2b2c38363c2a889664487ef530712f8be737c53d130bf147f4943197bc104c3",
      "after_sha256": "e23a7e46e6d1ff435ad4ffd4a3d92bcdd7cd54628887e022156abd0f2fc703b0",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.microAverage
```lean
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
```
### 实际依赖 MolecularDynamics.Chapter05Review.microMeasure
```lean
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```
### 实际依赖 MolecularDynamics.Chapter05Review.microRaw
```lean
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularEnergy
```lean
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
```
### 实际依赖 MolecularDynamics.Chapter05Review.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.microAverage
```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g
```
### 实际依赖 MD.Ch05.microMeasure
```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```
### 实际依赖 MD.Ch05.microRaw
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularEnergy
```lean
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
```
### 实际依赖 MD.Ch05.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MD.Ch05.uniformMicroErgodic
```lean
def uniformMicroErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-MicroErgodicStandard",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "197",
  "pdf_page": "218",
  "statement_latex": "for almost all trajectories $\\Gamma$ emanating from initial conditions on $\\Sigma_E$, and for any observable $g$, $\\bar g_\\Gamma=\\operatorname{Av}_{H=E}(g)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "本句摘自Definition 5.1；原文先“almost all trajectories”，再“any observable”；$\\Gamma$ 和 $\\bar g_\\Gamma$ 同(5.9)，PDF216。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.microErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准每个L¹可观测量各自AE初值版本，和原字面共满测集版本分开；不声称两者已等价。",
    "[EXTRA] 主接口恢复原句共同AE后∀光滑可积观测量，实际Hamiltonian/概率背景显式；旧∀L¹后AE版本仅保留为标明的替代定义，等价连接在ErgodicTimeEquivalence补列。 并恢复C∞而非Cω资格。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.827007",
      "before_sha256": "9a6af3fffa0acf5ec55899d8df51812ec8db0dbbdc6ec02b957a3e63cf891ae9",
      "after_sha256": "61f880427038b991fb1d97b2520969e6dbbeb9b037a72af8eb107d247087528f",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)

def microErgodic_L1_alternative {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.energySurface
```lean
def energySurface {n : ℕ} (H : E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MolecularDynamics.Chapter05Review.microAverage
```lean
def microAverage {n : ℕ} (H : E n → ℝ) (c : ℝ) (g : E n → ℝ) := average (microMeasure H c) g
```
### 实际依赖 MolecularDynamics.Chapter05Review.microMeasure
```lean
def microMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  ((microRaw H c) univ)⁻¹ • microRaw H c
```
### 实际依赖 MolecularDynamics.Chapter05Review.microRaw
```lean
def microRaw {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularEnergy
```lean
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
```
### 实际依赖 MolecularDynamics.Chapter05Review.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : E n → ℝ) (c : ℝ) : Measure (E n) :=
  (hausdorffArea (n-1)).restrict (energySurface H c)
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.energySurface
```lean
def energySurface {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) := {z | H z=c}
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter05Review.grad
```lean
def grad {n : ℕ} (H : E n → ℝ) (z : E n) := gradient H z
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.hausdorffArea
```lean
def hausdorffArea (d : ℕ) {n : ℕ} : Measure (E n) :=
  ENNReal.ofReal ((volume (Metric.ball (0 : E d) 1)).toReal/(2 : ℝ)^d) •
    Measure.hausdorffMeasure (d : ℝ)
```
### 实际依赖 MD.Ch05.microAverage
```lean
def microAverage {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (g : MolecularDynamics.Chapter05Review.E n → ℝ) := MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.microMeasure H c) g
```
### 实际依赖 MD.Ch05.microErgodic
```lean
def microErgodic {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ)
    (_hreg : MolecularDynamics.Chapter05Review.regularEnergy H c)
    (_hH : ContDiff ℝ 2 H) (_hE : ∀ t z,H (Φ t z)=H z)
    (_hHam : ∃ J : Matrix (Fin n) (Fin n) ℝ,Jᵀ= -J ∧ J.det ≠ 0 ∧
      ∀ z,f z=WithLp.toLp 2 (J *ᵥ WithLp.ofLp (gradient H z))) : Prop :=

  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
    ContDiff ℝ ∞ g → Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
      MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```
### 实际依赖 MD.Ch05.microErgodic_L1_alternative
```lean
def microErgodic_L1_alternative {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g (MolecularDynamics.Chapter05Review.microMeasure H c) →
    ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.microAverage H c g)
```
### 实际依赖 MD.Ch05.microMeasure
```lean
def microMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  ((MolecularDynamics.Chapter05Review.microRaw H c) univ)⁻¹ • MolecularDynamics.Chapter05Review.microRaw H c
```
### 实际依赖 MD.Ch05.microRaw
```lean
def microRaw {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.surfaceMeasure H c).withDensity (fun z => ENNReal.ofReal (‖MolecularDynamics.Chapter05Review.grad H z‖⁻¹))
```
### 实际依赖 MolecularDynamics.Chapter05Review.regularEnergy
```lean
def regularEnergy {n : ℕ} (H : E n → ℝ) (c : ℝ) : Prop :=
  (energySurface H c).Nonempty ∧ IsCompact (energySurface H c) ∧
  (∀ z ∈ energySurface H c, grad H z ≠ 0) ∧
  0 < (microRaw H c) univ ∧ (microRaw H c) univ < ∞
```
### 实际依赖 MD.Ch05.surfaceMeasure
```lean
def surfaceMeasure {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (c : ℝ) : Measure (MolecularDynamics.Chapter05Review.E n) :=
  (MolecularDynamics.Chapter05Review.hausdorffArea (n-1)).restrict (MolecularDynamics.Chapter05Review.energySurface H c)
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-FlowInvariant",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "197–198",
  "pdf_page": "218–219",
  "statement_latex": "An invariant set $\\mathcal A$ of the flow is one such that $\\mathcal F_t(\\mathcal A)=\\mathcal A$, for all $t\\ne0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal F_t$ 是流映射，$\\mathcal F_t(\\mathcal A)$ 是集合像；真实流有 $\\mathcal F_0=\\mathrm{id}$。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.flowInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原t≠0；真实流的零时刻恒等自动补上t=0，因而用实际全实时间集合像不变性。仅给定的真实流可解释为动力系统不变性。",
    "[EXTRA] 按原印精确限定t≠0；真实零时恒等流下等价全时间条件，不对任意Φ默加零时限制。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.827007",
      "before_sha256": "d98bc3be1b1ba853702aeae81fd1a0450e6c2d29e6856df4ad4a05a80058a75d",
      "after_sha256": "ee1dc646c80095d781f3b4f760aec4dea2c83dbfcbe1f6bbd234f9585d7ce244",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```
### 实际依赖 MD.Ch05.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-SetErgodic",
  "kind": "definition",
  "label": null,
  "section": "5.4.1",
  "printed_page": "197–198",
  "pdf_page": "218–219",
  "statement_latex": "Alternatively, we may say that a dynamical system as ergodic if the probability measure of any invariant set $\\mathcal A$ of the flow is either 0 or 1.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal A$ 是流的不变集合，概率测度取值0或1；不变性公式及 $t\\ne0$ 都在PDF218。原书“as ergodic”原样保留。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.setErgodic",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]明示集合可测和实际概率测度背景；原“as ergodic”字面保留，不在逐字JSON中默改为“is”。",
    "[EXTRA] 集合0/1定义限定概率测度、零时恒等、实际群律及联合可测流，排除任意测度/映射的伪遍历解释。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.827007",
      "before_sha256": "9269f853dbe0f2d862ebb572a7920d286124299f2f2eedab08f568a87ff4b67f",
      "after_sha256": "e7ab4e422df562c2309718a96607a0b27d80799f56ef180d4f08281c94f65ed9",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```
### 实际依赖 MD.Ch05.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```
### 实际依赖 MD.Ch05.setErgodic
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-InvariantIndicator",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "Then for any trajectory starting in $\\mathcal A$, we have that the average of $\\chi$ along $\\Gamma$ vanishes, i.e. $\\bar\\chi_\\Gamma=\\lim_{\\tau\\to\\infty}\\tau^{-1}\\int_0^\\tau\\chi(z(t))dt=0$, since $\\mathcal A$ is an invariant set.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF218–219：$\\chi(z)=0$ 若 $z\\in\\mathcal A$，$\\chi(z)=1$ 若 $z\\in\\Sigma_E\\setminus\\mathcal A$；初值在 $\\mathcal A$；$\\Gamma$ 是该轨道，$\\tau$ 为平均时长。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.invariantIndicator",
  "reusable_proofs": [
    "MolecularDynamics.Chapter05Review.invariantIndicator_proved"
  ],
  "extra_assumptions": [
    "[EXTRA]原φ是可达空间内A的补集示性函数，实际Measure支撑空间限定时可用ambient Aᶜ示性函数；本条保留沿轨道逐点为零，完整无限时间平均另条。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。"
  ],
  "statement_scope": "仅不变集合内补集indicator逐点恒零辅助引理；无限平均零由MD-5.4.1-InvariantIndicatorAverage承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.827007",
      "before_sha256": "5d22a5edf9f1260740d646395163004b8818dd14b957e276c6897817dd0f39d6",
      "after_sha256": "0c31e86c3e13d7bbf12ce5ed91a43a03426ea997ebc943c50bab2323d5bb5e4d",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem invariantIndicator {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (h : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) (t : ℝ) :
    Aᶜ.indicator (fun _ => (1 : ℝ)) (Φ t z)=0 := by
  apply MolecularDynamics.Chapter05Review.invariantIndicator_proved <;> assumption
```
### 实际依赖 MolecularDynamics.Chapter05Review.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```
### 实际依赖 MD.Ch05.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-InvariantIndicatorAverage",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "$\\bar\\chi_\\Gamma=\\lim_{\\tau\\to\\infty}\\tau^{-1}\\int_0^\\tau\\chi(z(t))dt=0$, since $\\mathcal A$ is an invariant set.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF218–219：$\\chi$ 是 $\\Sigma_E\\setminus\\mathcal A$ 的示性函数；本结论的初值在不变集合 $\\mathcal A$；$\\Gamma$ 是该轨道，$\\tau$ 为平均时长。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.invariantIndicatorAverage",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.827007",
      "before_sha256": "f09db311058fddea09c12e82d6a36fcea81fd4f6f8ba127daa6b9494c785691f",
      "after_sha256": "324c6358675e41c486dc5c16e44e45c8dc999279d16da6493793761030301efc",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem invariantIndicatorAverage {X : Type*} (Φ : ℝ → X → X) (A : Set X)
    (hA : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (z : X) (hz : z ∈ A) :
  MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) (Aᶜ.indicator (fun _ => (1 : ℝ))) 0 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MD.Ch05.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-ErgodicTimeEquivalence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "If we assume the system is ergodic, we must have $\\operatorname{Pr}(\\Sigma_E\\setminus\\mathcal A)=0$, thus $\\operatorname{Pr}(\\mathcal A)=1$. Since, according to the definition, equality of time and space averages is allowed to fail only on a set of probability measure zero, we have that either $\\operatorname{Pr}(\\mathcal A)=0$ or $\\operatorname{Pr}(\\mathcal A)=1$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF218–219：$\\mathcal A$ 不变，$\\chi=1_{\\Sigma_E\\setminus\\mathcal A}$；其空间平均为 $\\operatorname{Pr}(\\Sigma_E\\setminus\\mathcal A)$，在 $\\mathcal A$ 中的轨道平均为零。原书先写补集概率为0，最后才分辨 $\\operatorname{Pr}(\\mathcal A)=0$ 的情形；应用AE等式推出补集概率为0须先有 $\\operatorname{Pr}(\\mathcal A)>0$，这里仅记录而不改原句。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.ergodicTimeAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]完整全实时间可测流、概率保持、群律及L¹资格；对应标准每观测量AE版本，未将原共满测集量词交换当无条件事实。",
    "[EXTRA] 保留标准L¹双向定理，补紧支持概率流上共同AE光滑定义的连接及正概率不变集分支/实际indicator平均，区分原定义与标准替代定义。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.828007",
      "before_sha256": "ec8ddcefd5f505e431f9b421e33d182a7505f9da7c6bfc3beadbc2c6321a052b",
      "after_sha256": "9d7da121a29567760a54ac5e617bf6b4effded8b54d02c861e7f869bffa2bbfd",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem ergodicTimeAverage :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (∀ t,MeasurePreserving (Φ t) μ μ) →
  (∀ z,Φ 0 z=z) → (∀ s t z,Φ (s+t) z=Φ s (Φ t z)) →
  Measurable (Function.uncurry Φ) →
  (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔ ∀ g : MolecularDynamics.Chapter05Review.E n → ℝ, Integrable g μ →
    ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun t => Φ t z) g (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_common_smooth (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n))
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hμ : IsProbabilityMeasure μ) (_hpres : ∀ t,MeasurePreserving (Φ t) μ μ)
    (_h0 : ∀ z,Φ 0 z=z) (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hΦ : Continuous (Function.uncurry Φ))
    (_hK : ∃ K : Set (MolecularDynamics.Chapter05Review.E n),IsCompact K ∧ μ Kᶜ=0) :
    (MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
      ∀ᵐ z ∂μ,∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,
        ContDiff ℝ ∞ g → Integrable g μ →
          MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z) g
            (MolecularDynamics.Chapter05Review.average μ g)) := by
  sorry

theorem ergodicTimeAverage_positive_invariant (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_herg : MolecularDynamics.Chapter05Review.setErgodic μ Φ)
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) :
    μ A=1 ∧ (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.setErgodic
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X) : Prop :=
  ∀ A : Set X, MeasurableSet A → flowInvariant Φ A → μ A=0 ∨ μ A=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MD.Ch05.setErgodic
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```

## 原文JSON
```json
{
  "source_id": "MD-5.4.1-NonergodicSet",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.4.1",
  "printed_page": "198",
  "pdf_page": "219",
  "statement_latex": "If a system is not ergodic, then there will be an invariant set $\\mathcal A$ whose probability measure is strictly between zero and one. The trajectories emanating from this set are unable to explore the entire energy surface and the corresponding trajectory averages will, at least for some observables, be different than the spatial average of that observable.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "$\\mathcal A$ 是能量面 $\\Sigma_E$ 中的不变集合，$0<\\operatorname{Pr}(\\mathcal A)<1$；该段还声称轨道受困及某些可观测量的时间平均异于空间平均。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.nonergodicSet",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 补中间概率不变集合内真实轨道保持、补集indicator无限平均零及空间平均非零的见证；可用于实际能量面概率流，不把不等式作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT13_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:01:07.828007",
      "before_sha256": "d6bdbdaa608bc426b38e0ab0b7b45372118680bc9287d57b5c50a0dc86f28465",
      "after_sha256": "f594e66dc086376cc944a417fae8c3c021e676f22fdffbc75c77900f6934db5d",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH18_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT13/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem nonergodicSet :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ,
  IsProbabilityMeasure μ → (¬MolecularDynamics.Chapter05Review.setErgodic μ Φ ↔
    ∃ A : Set (MolecularDynamics.Chapter05Review.E n),MeasurableSet A ∧ MolecularDynamics.Chapter05Review.flowInvariant Φ A ∧ 0 < μ A ∧ μ A < 1) := by
  sorry

theorem nonergodicSet_average_witness (n : ℕ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (A : Set (MolecularDynamics.Chapter05Review.E n)) (_hA : MeasurableSet A)
    (_hinv : MolecularDynamics.Chapter05Review.flowInvariant Φ A) (_hpos : 0 < μ A) (_hlt : μ A < 1) :
    (∀ z ∈ A,∀ t,Φ t z ∈ A) ∧
    (∀ z ∈ A,MolecularDynamics.Chapter05Review.hasTimeAverage (fun t ↦ Φ t z)
      (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) 0) ∧
    MolecularDynamics.Chapter05Review.average μ (Aᶜ.indicator (fun _ ↦ (1 : ℝ))) ≠ 0 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MolecularDynamics.Chapter05Review.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t, Φ t '' A=A
```
### 实际依赖 MolecularDynamics.Chapter05Review.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MolecularDynamics.Chapter05Review.setErgodic
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X) : Prop :=
  ∀ A : Set X, MeasurableSet A → flowInvariant Φ A → μ A=0 ∨ μ A=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
### 实际依赖 MolecularDynamics.Chapter05Review.average
```lean
def average {n : ℕ} (μ : Measure (E n)) (g : E n → ℝ) := ∫ z, g z ∂μ
```
### 实际依赖 MD.Ch05.flowInvariant
```lean
def flowInvariant {X : Type*} (Φ : ℝ → X → X) (A : Set X) : Prop := ∀ t,t ≠ 0 → Φ t '' A=A
```
### 实际依赖 MD.Ch05.hasTimeAverage
```lean
def hasTimeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (a : ℝ) : Prop :=
  Tendsto (MolecularDynamics.Chapter05Review.timeAverage z g) atTop (𝓝 a)
```
### 实际依赖 MD.Ch05.setErgodic
```lean
def setErgodic {X : Type*} [MeasurableSpace X] (μ : Measure X) (Φ : ℝ → X → X)
    (_hμ : IsProbabilityMeasure μ) (_h0 : ∀ z,Φ 0 z=z)
    (_hgrp : ∀ s t z,Φ (s+t) z=Φ s (Φ t z))
    (_hjoint : Measurable (Function.uncurry Φ)) : Prop :=
  ∀ A : Set X, MeasurableSet A → MolecularDynamics.Chapter05Review.flowInvariant Φ A → μ A=0 ∨ μ A=1
```
### 实际依赖 MD.Ch05.timeAverage
```lean
def timeAverage {X : Type*} (z : ℝ → X) (g : X → ℝ) (T : ℝ) := T⁻¹*(∫ t in (0 : ℝ)..T,g (z t))
```
