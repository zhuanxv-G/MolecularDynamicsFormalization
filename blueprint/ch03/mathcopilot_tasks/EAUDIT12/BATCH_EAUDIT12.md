# EAUDIT12：第3章§3.5网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-3.5-LinearEulerIntegral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "Generalizing this slightly, we could imagine a system of ODEs of the form\n\\[\\dot{\\boldsymbol z}=\\boldsymbol f(\\boldsymbol z),\\]\nsuch that, for some vector $\\boldsymbol b$,\n\\[\\boldsymbol b\\cdot \\boldsymbol f(\\boldsymbol z)\\equiv0,\\]\nthen $I(\\boldsymbol z)=\\boldsymbol b\\cdot\\boldsymbol z$ is a first integral. It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "精确实数一步Euler保持线性函数；连续ODE first integral由链式法则；不解释为机器浮点完全无误差。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.linearEulerIntegral",
  "reusable_proofs": [
    "MolecularDynamics.Chapter03Review.linearEulerIntegral_proved"
  ],
  "extra_assumptions": [
    "[EXTRA] 保留已证Euler精确保存；补连续ODE解上真实线性第一积分恒定，覆盖本条原句连续与离散两结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:57.297656",
      "before_sha256": "970628e45831a9e279bad693384cfeff79fe256e1a9449cac0f7b24b1352508b",
      "after_sha256": "2fa0fff1ff47e69b7d61400b47548a9a53a00f09a63f78ac39282955ed87c1ac",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem linearEulerIntegral :
  ∀ (n : ℕ) (b : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, b (f z)=0) →
    ∀ (h : ℝ) z, b (z+h • f z)=b z := by
  exact MolecularDynamics.Chapter03Review.linearEulerIntegral_proved

theorem linearEulerIntegral_continuous (n : ℕ) (b : Q n →L[ℝ] ℝ)
    (f : Q n → Q n) (_hb : ∀ z, b (f z)=0)
    (γ : ℝ → Q n) (a d : ℝ) (_had : a ≤ d)
    (_hγ : ∀ t ∈ Icc a d, HasDerivWithinAt γ (f (γ t)) (Icc a d) t) :
    ∀ t ∈ Icc a d, b (γ t)=b (γ a) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-3.5-VerletOscillatorEnergy",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "In the case of Euler's method applied to the harmonic oscillator, the error in energy grows with time and without bound. In the case of Störmer-Verlet, the energy fluctuates but remains bounded for all time and at its worst is of size proportional to $h^2$, a numerical observation that is supported by the existence of the modified Hamiltonian.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "Euler无界另为EulerGrowth；本条保留Verlet谐振子全时间能量界。",
    "原文此句未写步长稳定性条件；Verlet 的全时间 O(h²) 能量误差界只在稳定步长范围解释。Lean 的 Ω>0、固定0<ρ<2、|hΩ|≤ρ 是对原文省略限定的显式补充，不是原文逐字假设。零初值并无能量波动，故“fluctuates”按典型行为理解；这里只形式化误差上界。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.verletOscillatorEnergy",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0，固定ρ∈(0,2)，|hΩ|≤ρ；排除不稳定及阈值步长。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:57.297656",
      "before_sha256": "838a0f5955cbb970b344bf1aec3b13120ed6ea6aab7e440d208617d361ae907b",
      "after_sha256": "4bc067503482b66507a6146b7778f8ae17a6d2145fd3189bf27935ad2bb423a4",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem verletOscillatorEnergy :
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2 := by
  intro Ω ρ hΩ hρ hρ2 z
  let A : ℝ := 1-ρ^2/4
  have hA : 0 < A := by dsimp [A]; nlinarith
  let E0 : ℝ := (z.2 0)^2+Ω^2*(z.1 0)^2
  refine ⟨Ω^2*E0/(4*A), by dsimp [E0]; positivity, ?_⟩
  intro h hh ν
  have hh2 : h^2*Ω^2 ≤ ρ^2 := by
    have hp := abs_le.mp hh
    nlinarith
  have hcoeff : A ≤ 1-h^2*Ω^2/4 := by dsimp [A]; linarith
  let K : Z 1 → ℝ := fun w => (w.2 0)^2+Ω^2*(1-h^2*Ω^2/4)*(w.1 0)^2
  have hstep : ∀ w, K (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0) h w) = K w := by
    intro w
    simp only [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]
    ring
  have hi : K (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν) = K z := by
    induction ν with
    | zero => rfl
    | succ ν ih => rw [oneStepIterate_succ, hstep, ih]
  have hupper : K z ≤ E0 := by
    dsimp [K, E0]
    nlinarith [mul_nonneg (sq_nonneg h) (mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sq_nonneg Ω) (sq_nonneg (z.1 0))))]
  have hlower : ∀ w, Ω^2*A*(w.1 0)^2 ≤ K w := by
    intro w
    dsimp [K]
    nlinarith [sq_nonneg (w.2 0), mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sub_nonneg.mpr hcoeff) (sq_nonneg (w.1 0)))]
  let w := oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν
  have hden : 0 < Ω^2*A := mul_pos (sq_pos_of_pos hΩ) hA
  have hw : (w.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower w
    change K w=K z at hi
    nlinarith
  have hz : (z.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower z
    nlinarith
  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    rw [mul_div_assoc]
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (w.1 0), sq_nonneg (z.1 0)]
  have heq : mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z =
      (h^2*Ω^4/8)*((w.1 0)^2-(z.1 0)^2) := by
    norm_num [mechanicalEnergy, quadraticKinetic, Fin.sum_univ_one]
    change K w=K z at hi
    dsimp [K] at hi
    nlinarith
  change |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
    mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ _
  rw [heq, abs_mul, abs_of_nonneg (show 0 ≤ h^2*Ω^4/8 by positivity)]
  calc
    _ ≤ (h^2*Ω^4/8)*(2*E0/(Ω^2*A)) := mul_le_mul_of_nonneg_left habs (by positivity)
    _ = Ω^2*E0/(4*A)*h^2 := by
      have hg : Ω ≠ 0 := ne_of_gt hΩ
      have ha : A ≠ 0 := ne_of_gt hA
      field_simp
      ring
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter03Review.mechanicalEnergy
```lean
def mechanicalEnergy {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n) : ℝ := quadraticKinetic m z.2+U z.1
```
### 实际依赖 MolecularDynamics.oneStepIterate
```lean
noncomputable def oneStepIterate (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (G h)^[n] z₀

@[simp] theorem oneStepIterate_zero (G : ℝ → E → E) (h : ℝ) (z₀ : E) :
    oneStepIterate G h z₀ 0 = z₀ := rfl

@[simp] theorem oneStepIterate_succ (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    oneStepIterate G h z₀ (n + 1) = G h (oneStepIterate G h z₀ n) :=
  Function.iterate_succ_apply' _ _ _
```
### 实际依赖 MolecularDynamics.Chapter03Review.quadraticKinetic
```lean
def quadraticKinetic {n : ℕ} (m : Fin n → ℝ) (p : Q n) : ℝ := (∑ i, p i^2/m i)/2
```
### 实际依赖 MolecularDynamics.Chapter02Review.verlet
```lean
def verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```

## 原文JSON
```json
{
  "source_id": "MD-3.5-MomentumProjection",
  "kind": "definition",
  "label": null,
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "We start by taking a timestep with any arbitrary (nonconserving) numerical method, say to an intermediate phase point $\\overline{\\boldsymbol Q},\\overline{\\boldsymbol P}$, then we “fix it up” by scaling the momentum by an adjustment factor, defining\n\\[\\boldsymbol Q=\\overline{\\boldsymbol Q},\\qquad\\boldsymbol P=\\gamma\\overline{\\boldsymbol P},\\]\nselecting $\\gamma$ so that the energy in the result is a prescribed value $E$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "γ选择由后面的constraint及factor定义，投影本身不证明可求解性。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.momentumProjection",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:57.298157",
      "before_sha256": "f51035b6478ed6621ff6f0ac14927f8a82ae33eba803a3522032888cc7b4c61a",
      "after_sha256": "7fa0b495ab95c46eb527649279fbdf24cba30fd73e481d0816398bc3b4503fe4",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MD.Ch03.momentumProjection
```lean
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)
```

## 原文JSON
```json
{
  "source_id": "MD-3.5-ProjectionConstraint",
  "kind": "definition",
  "label": "(3.12)",
  "section": "3.5",
  "printed_page": "123",
  "pdf_page": "145",
  "statement_latex": "This method is easy to implement: the equation that must be solved is\n\\[\\frac{\\gamma^2\\overline{\\boldsymbol P}^{T}\\boldsymbol M^{-1}\\overline{\\boldsymbol P}}{2}+U(\\overline{\\boldsymbol Q})=E.\\tag{3.12}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "K=P̄ᵀM⁻¹P̄/2，U=U(Q̄)；γ约束。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.projectionConstraint",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:57.298157",
      "before_sha256": "37bd7e96b5be450af3ddf7a9e0ec166a617494d08a1f9eb60c4e91f8de909caf",
      "after_sha256": "46c27b1a353c79f8e1166a7a2fec5c9cd70e0078699b729dff18f758fd726726",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E
```
### 实际依赖 MD.Ch03.projectionConstraint
```lean
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E
```

## 原文JSON
```json
{
  "source_id": "MD-3.5-ProjectionFactor",
  "kind": "definition",
  "label": "(3.13)",
  "section": "3.5",
  "printed_page": "124",
  "pdf_page": "146",
  "statement_latex": "and, since $\\overline{\\boldsymbol Q}$ is known, this gives\n\\[\\gamma=\\left(\\frac{E-\\overline U}{\\overline K}\\right)^{1/2},\\tag{3.13}\\]\nwhere $\\overline U=U(\\overline{\\boldsymbol Q})$ and $\\overline K=\\overline{\\boldsymbol P}^{T}\\boldsymbol M^{-1}\\overline{\\boldsymbol P}/2$ are the potential and kinetic energies after a step of the original non-conserving scheme.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实平方根取非负分支；原文要求K>0、E−U≥0，定义的真实约束解另列ProjectionEnergy。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch03.projectionFactor",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:57.298157",
      "before_sha256": "64f06f34870731d87912c040bcea4819d98e2cc3a69a3768cb4e336883c30b84",
      "after_sha256": "dc6cd0b8c50b901b94642cd950de3ac963b6c5d8cf2cdb03c48e8cc4e87b3623",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH15_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)
```
### 实际依赖 MD.Ch03.projectionFactor
```lean
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)
```

## 原文JSON
```json
{
  "source_id": "MD-3.5-NoHamiltonianAttractor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "3.5",
  "printed_page": "126",
  "pdf_page": "148",
  "statement_latex": "In the first phase, the discrete trajectory appears to be filling in the correct region and without any evidence of nonphysical behavior. The performance is very similar to a Verlet method without projection during this period. In the second phase the system begins to move toward a limit cycle, i.e. an attractive periodic orbit. The presence of such limit cycles is impossible in a Hamiltonian system, thus it is evident that a nonphysical artefact has been introduced by the projection method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch03.noHamiltonianAttractor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT12_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:23:57.298157",
      "before_sha256": "b4eadbdc2b95dffb6970f98fa0cd344db2f5cf4b15f7a45120eec13e66806526",
      "after_sha256": "9bccec99c11fddb5623efb6e17e9615c1ba5fec346bbe7b0f213aa6179a4fd95",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch03/mathcopilot_results/BATCH16_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT12/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem noHamiltonianAttractor :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (orbit B : Set (SymplecticCoordinates n)), ContDiff ℝ 2 H →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (textbookHamiltonianVectorField H (Φ t z)) t) →
    IsCompact orbit → orbit.Nonempty → volume orbit=0 → IsOpen B → 0 < volume B → volume B < ⊤ →
    ¬ (∀ z ∈ B, Tendsto (fun t => Metric.infDist (Φ t z) orbit) atTop (𝓝 0)) := by
  sorry
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
