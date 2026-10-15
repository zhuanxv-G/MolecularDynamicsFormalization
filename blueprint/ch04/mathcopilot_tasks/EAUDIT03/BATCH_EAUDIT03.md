# EAUDIT03：第4章§4.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.1-PrintedImplicitRelation",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "The Implicit Midpoint method which, for the ODE $\\dot z=f(z)$ takes the form\n\\[z_{n+1}=z_n+h\\frac{f(z_n)+f(z_{n+1})}{2},\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [
    {
      "code": "ERRATUM?",
      "detail": "p142名为Implicit Midpoint却写Trapezoidal Rule更新式；p144采用真正机械中点式。"
    }
  ],
  "lean_decl": "MD.Ch04.printedImplicitRelation",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:52:31.915585",
      "before_sha256": "fa498573eaca1631807e654059f2a8dc68d6dc7accf2b9cbc803e064bd3a3ced",
      "after_sha256": "a95bd1a243e3205e600dc2ee64b1e4228bf46b1c217e25abd9fdd7cf9bbfe068",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MD.Ch04.printedImplicitRelation
```lean
def printedImplicitRelation {n : ℕ} (f : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (h : ℝ) (z znew : MolecularDynamics.Chapter04Review.Q n) : Prop :=
  znew=z+(h/2) • (f z+f znew)
```

## 原文JSON
```json
{
  "source_id": "MD-4.1-ImplicitFactor",
  "kind": "definition",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "can be applied to $\\dot z=i\\Omega z$ and yields\n\\[z_{n+1}=\\frac{1+ih\\Omega/2}{1-ih\\Omega/2}z_n.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "线性场中点/梯形相同；Ω,h实数，分母实部1永不为0。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.implicitFactor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留因子并补线性场iΩz的印刷隐式更新等价式；分母实部1不需额外非零假设，新定理暂sorry。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:52:31.915585",
      "before_sha256": "8021860fd2c844960022dcc32a67943d33e51869334fa80f08a44d466e40df65",
      "after_sha256": "11d289333462a1e7bce5955c576d606b860aba2dcc888753df303ed5a85b413b",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))

theorem implicitFactor_update (Ω h : ℝ) (z out : ℂ) :
    (out=z+(h : ℂ)*(Complex.I*Ω*z+Complex.I*Ω*out)/2) ↔
      out=implicitFactor Ω h*z := by
  sorry
```
### 实际依赖 MD.Ch04.implicitFactor
```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
```

## 原文JSON
```json
{
  "source_id": "MD-4.1-ImplicitModulus",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.1",
  "printed_page": "142",
  "pdf_page": "164",
  "statement_latex": "For all real $\\Omega$, we find\n\\[\\left|\\frac{1+ih\\Omega/2}{1-ih\\Omega/2}\\right|=1.\\]\nThis indicates that the Implicit Midpoint method has no stability threshold for the stepsize when solving a linear system!",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch04.implicitModulus",
  "reusable_proofs": [],
  "extra_assumptions": [
    "只保留本段纯虚线性振子对象；不扩成任意不稳定线性系统的有界性。",
    "[EXTRA] 增加任意步长的标量迭代范数保持，准确对应当前线性振子模态；不扩大到任意线性系统。原模长证明保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:52:31.915585",
      "before_sha256": "c387ecd515fe9fc15e624613052d82f8db93f0191f143eb7fff0a601f2805c3f",
      "after_sha256": "c32ba6090fc753c66b44495b750f1006a56bcda0cba0ba8ec30fff80d72a9747",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem implicitModulus :
  ∀ Ω h : ℝ, ‖MolecularDynamics.Chapter04Review.implicitFactor Ω h‖=1 := by
  intro Ω h
  rw [MolecularDynamics.Chapter04Review.implicitFactor,norm_div]
  have he : (1+Complex.I*((h*Ω/2 : ℝ) : ℂ)) = star (1-Complex.I*((h*Ω/2 : ℝ) : ℂ)) := by simp
  rw [he,norm_star]
  apply div_self
  intro hn
  have hz := norm_eq_zero.mp hn
  have hr := congrArg Complex.re hz
  norm_num at hr

theorem implicitModulus_iterates (Ω h : ℝ) (z : ℂ) (k : ℕ) :
    ‖(MolecularDynamics.Chapter04Review.implicitFactor Ω h)^k*z‖=‖z‖ := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.implicitFactor
```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
```
### 实际依赖 MD.Ch04.implicitFactor
```lean
def implicitFactor (Ω h : ℝ) : ℂ :=
  (1+Complex.I*(h*Ω/2 : ℝ))/(1-Complex.I*(h*Ω/2 : ℝ))
```

## 原文JSON
```json
{
  "source_id": "MD-4.1-ModifiedFrequencyLimit",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.1",
  "printed_page": "143",
  "pdf_page": "165",
  "statement_latex": "The figure shows that the frequency is only well approximated in case $h\\Omega$ is sufficiently small. For $h\\Omega\\gg1$ the frequency is highly modified.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "printedModifiedFrequency复log支对应需另审；本条采用实连续相位。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.modifiedFrequencyLimit",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]将small-h准确表达为连续实相位2 atan(hΩ/2)/h沿非零h→0趋Ω；不声称此极限自动给耦合系统准确度。",
    "[EXTRA] 补x=hΩ的频率比零点极限1与正无穷极限0及实际频率桥接，保留旧h→0证明；新结论不作证明。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:52:31.915585",
      "before_sha256": "2c94950bbc719eebd3d2cce8be281f398ce7ec3895cea6d311c145f1f3948fcc",
      "after_sha256": "1362866f9af48f81977137c54b6c841993c3ab123f1399ad9bbf071b08faa5c4",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem modifiedFrequencyLimit :
  ∀ Ω : ℝ, Tendsto (MolecularDynamics.Chapter04Review.modifiedFrequency Ω) (nhdsWithin 0 ({0}ᶜ)) (𝓝 Ω) := by
  intro Ω
  have hd : HasDerivAt (fun h : ℝ => 2*Real.arctan (h*Ω/2)) Ω 0 := by
    convert (((hasDerivAt_id (0 : ℝ)).mul_const Ω).div_const 2).arctan.const_mul 2 using 1 <;> norm_num <;> ring
  convert hd.tendsto_slope_zero using 1
  funext t
  simp [MolecularDynamics.Chapter04Review.modifiedFrequency,smul_eq_mul,div_eq_mul_inv]
  ring

def midpointFrequencyRatio (x : ℝ) : ℝ := 2*Real.arctan (x/2)/x

theorem modifiedFrequencyRatio_limits :
    Tendsto midpointFrequencyRatio (nhdsWithin 0 ({0}ᶜ)) (𝓝 1) ∧
    Tendsto midpointFrequencyRatio atTop (𝓝 0) ∧
    (∀ Ω h : ℝ, h*Ω ≠ 0 →
      MolecularDynamics.Chapter04Review.modifiedFrequency Ω h/Ω=midpointFrequencyRatio (h*Ω)) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.modifiedFrequency
```lean
def modifiedFrequency (Ω h : ℝ) : ℝ := 2*Real.arctan (h*Ω/2)/h
```
### 实际依赖 MD.Ch04.midpointFrequencyRatio
```lean
def midpointFrequencyRatio (x : ℝ) : ℝ := 2*Real.arctan (x/2)/x
```
### 实际依赖 MolecularDynamics.Chapter04Review.modifiedFrequency
```lean
def modifiedFrequency (Ω h : ℝ) : ℝ := 2*Real.arctan (h*Ω/2)/h
```

## 原文JSON
```json
{
  "source_id": "MD-4.1-MidpointElimination",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.1",
  "printed_page": "144",
  "pdf_page": "166",
  "statement_latex": "We may therefore view the step as a composition of Implicit Euler and Explicit Euler half-steps. Eliminating $\\widehat p$, we find\n\\[\\widehat q=q_n+\\frac h2M^{-1}p_n-\\frac{h^2}{4}M^{-1}\\nabla U(\\widehat q).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际四关系推出位置消元等式；不增加解存在或Newton收敛结论。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.midpointElimination",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 保留消元公式及其已有证明，补实际相空间场的隐式Euler半步→显式Euler半步关系等价，不静默缩掉组合结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT03_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:52:31.915585",
      "before_sha256": "1da23e7f63fc7a9416152edfec9509d8a02d5ca03f880fe9ca5013cdc03742db",
      "after_sha256": "968e30c2d98715f689fde57b9d38d6911c45e5af466130de2d4c0c642d22f393",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH03_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT03/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem midpointElimination :
  ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) h (z mid out : MolecularDynamics.Chapter04Review.Z n),
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out →
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m z.2-(h^2/4) • MolecularDynamics.Chapter04Review.invMass m (MolecularDynamics.Chapter04Review.grad U mid.1) := by
  intro n m U h z mid out hm
  rcases hm with ⟨hq,hp,houtq,houtp⟩
  calc
    mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 := hq
    _ = _ := by
      rw [hp]
      funext i
      simp [MolecularDynamics.Chapter04Review.invMass]
      ring

theorem midpointEulerHalfSteps (n : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ)
    (z mid out : MolecularDynamics.Chapter04Review.Z n) :
    MolecularDynamics.Chapter04Review.mechanicalMidpointRelation m U h z mid out ↔
      (let f := fun w : MolecularDynamics.Chapter04Review.Z n ↦
        (MolecularDynamics.Chapter04Review.invMass m w.2,
          -MolecularDynamics.Chapter04Review.grad U w.1)
       mid=z+(h/2) • f mid ∧ out=mid+(h/2) • f mid) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.mechanicalMidpointRelation
```lean
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (h : ℝ) (z mid out : Z n) : Prop :=
  mid.1=z.1+(h/2) • invMass m mid.2 ∧ mid.2=z.2-(h/2) • grad U mid.1 ∧
  out.1=mid.1+(h/2) • invMass m mid.2 ∧ out.2=mid.2-(h/2) • grad U mid.1
```
### 实际依赖 MolecularDynamics.Chapter02Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter04Review.Q
```lean
abbrev Q (n : ℕ) := Fin n → ℝ
```
### 实际依赖 MolecularDynamics.Chapter02Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter04Review.Z
```lean
abbrev Z (n : ℕ) := Q n × Q n
```
### 实际依赖 MolecularDynamics.Chapter02Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := fun i => (fderiv ℝ U q) (Pi.single i 1)
```
### 实际依赖 MolecularDynamics.Chapter04Review.grad
```lean
def grad {n : ℕ} (U : Q n → ℝ) (q : Q n) : Q n := textbookConstraintGradient U q
```
### 实际依赖 MolecularDynamics.Chapter02Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MolecularDynamics.Chapter04Review.invMass
```lean
def invMass {n : ℕ} (m : Fin n → ℝ) (v : Q n) : Q n := fun i => (m i)⁻¹ * v i
```
### 实际依赖 MD.Ch04.mechanicalMidpointRelation
```lean
def mechanicalMidpointRelation {n : ℕ} (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (h : ℝ) (z mid out : MolecularDynamics.Chapter04Review.Z n) : Prop :=
  mid.1=z.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ mid.2=z.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1 ∧
  out.1=mid.1+(h/2) • MolecularDynamics.Chapter04Review.invMass m mid.2 ∧ out.2=mid.2-(h/2) • MolecularDynamics.Chapter04Review.grad U mid.1
```
### 实际依赖 MolecularDynamics.textbookConstraintGradient
```lean
noncomputable def textbookConstraintGradient {Nc : ℕ}
    (γ : (Fin Nc → ℝ) → ℝ) (q : Fin Nc → ℝ) : Fin Nc → ℝ :=
  fun i => (fderiv ℝ γ q) (Pi.single i 1)
```
