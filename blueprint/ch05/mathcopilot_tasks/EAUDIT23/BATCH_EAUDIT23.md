# EAUDIT23：第5章§5.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.6-EulerLogFlow",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "z_n=(q_n,p_n), H(q,p)=p^2/2+q^2/2；h为数值时间步长。",
    "\\widetilde f 是数值方法的modified向量场；\\mathcal L_{\\widetilde f}^{\\dagger}\\rho=-\\nabla\\cdot(\\rho\\widetilde f)；\\delta[q]\\delta[p] 是原点Dirac概率。",
    "dz/dt=f(z)+h^r f_{(r)}(z)\\equiv\\widetilde f_h(z)，r为方法阶数；原书明说采用backward error analysis展开的有限截断。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerLogFlow",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]为两种实际线性modified场写出完整连续时间指数旋转流；不是把任意算法的有限截断当精确解。只有本单位线性振子的对应作为独立待证明义务。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。"
  ],
  "statement_scope": "仅单位振子h>0新增的精确对数流技术定义；ODE与实际Euler一步的识别由MD-5.6-EulerLogCorrespondence承担，不冒称一般有限截断modified场。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:19:38.401044",
      "before_sha256": "581ab66745dcd48c3c486858909901e52d3cb6ee8456ca0f6c63ab30e6705678",
      "after_sha256": "6af8baefc37ce4c1f6403d57615063ee7ca44dbd0efd83aecf7e51a3d2ae59ff",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.eulerLogFlow
```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-EulerLogCorrespondence",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "206–207",
  "pdf_page": "227–228",
  "statement_latex": "Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by $\\frac{\\partial\\rho}{\\partial t}=\\mathcal L_{\\widetilde f}^{\\dagger}\\rho\\overset{\\mathrm{def}}{=}\\mathcal L_f^{\\dagger}\\rho+h^r\\mathcal L_{f_{(r)}}^{\\dagger}\\rho$. […] Applying Forward Euler to the harmonic oscillator, we have $q_{n+1}=q_n+hp_n$, $p_{n+1}=p_n-hq_n$. […] As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "z_n=(q_n,p_n), H(q,p)=p^2/2+q^2/2；h为数值时间步长。",
    "\\widetilde f 是数值方法的modified向量场；\\mathcal L_{\\widetilde f}^{\\dagger}\\rho=-\\nabla\\cdot(\\rho\\widetilde f)；\\delta[q]\\delta[p] 是原点Dirac概率。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerLogCorrespondence",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]只对书中实际单位线性振子给出选定logarithmic场与两Euler更新的真实对应及全部t的ODE；不把更新等式或ODE作假设。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:19:38.401044",
      "before_sha256": "7a684c10e6780947b8c47c4c9653e1562582b151d36fc0463d74e0fb7efd9c48",
      "after_sha256": "1ccdcff1310fa912ee1e10310e3d02a832013b509b3c59e918f8243c3e4c199b",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem eulerLogCorrespondence : ∀ h : ℝ,0 < h →
  (∀ z,eulerLogFlow false h h z=MolecularDynamics.Chapter05Review.forwardEuler h z ∧
    eulerLogFlow true h h z=MolecularDynamics.Chapter05Review.backwardEuler h z) ∧
  (∀ backward z t,HasDerivAt (fun s => eulerLogFlow backward h s z)
    (eulerLogField backward h (eulerLogFlow backward h t z)) t) := by
  intro h hh
  have hn : h ≠ 0 := ne_of_gt hh
  have hp : 0 < 1+h^2 := by positivity
  have hs : Real.sqrt (1+h^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 hp)
  have he : Real.exp (Real.log (1+h^2)/2)=Real.sqrt (1+h^2) := by
    have he2 : (Real.exp (Real.log (1+h^2)/2))^2=1+h^2 := by
      rw [pow_two,←Real.exp_add]
      convert Real.exp_log hp using 1 <;> congr 1 <;> ring
    nlinarith [Real.exp_pos (Real.log (1+h^2)/2),Real.sqrt_nonneg (1+h^2),Real.sq_sqrt hp.le]
  have hbh : Real.arctan h/h*h=Real.arctan h := by field_simp [hn]
  have haf : (Real.log (1+h^2)/(2*h))*h=Real.log (1+h^2)/2 := by field_simp [hn] <;> ring
  have hab : (-(Real.log (1+h^2))/(2*h))*h= -(Real.log (1+h^2)/2) := by field_simp [hn] <;> ring
  constructor
  · intro z
    constructor <;> ext i <;> fin_cases i <;>
      simp [eulerLogFlow,MolecularDynamics.Chapter05Review.forwardEuler,
        MolecularDynamics.Chapter05Review.backwardEuler,hbh,haf,hab,Real.exp_neg,
        he,Real.cos_arctan,Real.sin_arctan]
    all_goals field_simp [hs] <;> simp only [Real.sq_sqrt hp.le] <;> ring
  · intro backward z t
    let a := (if backward then (-1 : ℝ) else 1)*Real.log (1+h^2)/(2*h)
    let b := Real.arctan h/h
    have ha := ((hasDerivAt_id t).const_mul a).exp
    have hc := ((hasDerivAt_id t).const_mul b).cos
    have hs := ((hasDerivAt_id t).const_mul b).sin
    have hq := ha.mul ((hc.const_mul (z 0)).add (hs.const_mul (z 1)))
    have hp := ha.mul ((hc.const_mul (z 1)).sub (hs.const_mul (z 0)))
    have hv : HasDerivAt (fun s : ℝ => ![Real.exp (a*s)*(z 0*Real.cos (b*s)+z 1*Real.sin (b*s)),
        Real.exp (a*s)*(z 1*Real.cos (b*s)-z 0*Real.sin (b*s))])
        ![a*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))+
            b*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t))),
          a*(Real.exp (a*t)*(z 1*Real.cos (b*t)-z 0*Real.sin (b*t)))-
            b*(Real.exp (a*t)*(z 0*Real.cos (b*t)+z 1*Real.sin (b*t)))] t := by
      apply hasDerivAt_pi.mpr
      intro i
      fin_cases i
      · convert hq using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
      · convert hp using 1 <;> (try funext s) <;> simp [mul_comm] <;> ring
    convert (PiLp.hasFDerivAt_toLp (𝕜:=ℝ) 2 _).comp_hasDerivAt t hv using 1
    · funext s
      ext i
      fin_cases i <;> simp [eulerLogFlow,a,b]
    · ext i
      fin_cases i <;> simp [eulerLogField,eulerLogFlow,a,b] <;> ring
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : E 2) : E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```
### 实际依赖 MolecularDynamics.Chapter05Review.forwardEuler
```lean
def forwardEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```
### 实际依赖 MD.Ch05.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```
### 实际依赖 MD.Ch05.eulerLogField
```lean
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]
```
### 实际依赖 MD.Ch05.eulerLogFlow
```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```
### 实际依赖 MD.Ch05.forwardEuler
```lean
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-ForwardWeakStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "To put it another way, the only solution, in the weak sense, of $\\mathcal L_{\\widetilde f}^{\\dagger}\\rho=0$ is the point distribution $\\delta[q]\\delta[p]$, and this solution is not “asymptotically stable.”",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "z_n=(q_n,p_n), H(q,p)=p^2/2+q^2/2；h为数值时间步长。",
    "\\widetilde f 是数值方法的modified向量场；\\mathcal L_{\\widetilde f}^{\\dagger}\\rho=-\\nabla\\cdot(\\rho\\widetilde f)；\\delta[q]\\delta[p] 是原点Dirac概率。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardWeakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际概率弱稳态和弱拓扑非吸引两个结论；选择上一条给出的真实modified场/流及正h。离散不变概率唯一性不替代本弱PDE与非吸引结论。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:19:38.401044",
      "before_sha256": "ad21d55260702e0a84e4a2314d7bbe7504a23d7049e1983c7b68e4849ca5ea5d",
      "after_sha256": "6bdfab2feebb3cdabebf0a7c1be2235ad5007f4d0099719c39f808ca93addcf1",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH27_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem forwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField false h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  ¬weakAttractor (eulerLogFlow false h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (E n) := Measure.dirac 0
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```
### 实际依赖 MD.Ch05.eulerLogField
```lean
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]
```
### 实际依赖 MD.Ch05.eulerLogFlow
```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.testSpace
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```
### 实际依赖 MD.Ch05.weakAttractor
```lean
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))
```
### 实际依赖 MD.Ch05.weakStationary
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-BackwardWeakStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "The only (distributional) solution of $\\mathcal L_{\\widetilde f}^{*}\\rho=0$ is again $\\delta[q]\\delta[p]$, which in this case is attractive.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardWeakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]选定实际logarithmic modified场、正h与概率分布；完整弱PDE唯一性及弱概率吸引保留，实际离散全轨道与所有概率弱极限另条。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:19:38.401044",
      "before_sha256": "402ffc397c824ae5e11e4d28c845886511dca5aa3cce10cef80c18f93792b9f9",
      "after_sha256": "8c723183c00e932d95ba083793b4fc7d16712cf4c88ecaa5e2adf8fc9158af29",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem backwardWeakStationary : ∀ h : ℝ,0 < h →
  weakStationary (eulerLogField true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ →
    weakStationary (eulerLogField true h) μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2) ∧
  weakAttractor (eulerLogFlow true h) (MolecularDynamics.Chapter05Review.diracMeasure 2) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (E n) := Measure.dirac 0
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```
### 实际依赖 MD.Ch05.eulerLogField
```lean
def eulerLogField (backward : Bool) (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  WithLp.toLp 2 ![a*z 0+b*z 1,a*z 1-b*z 0]
```
### 实际依赖 MD.Ch05.eulerLogFlow
```lean
def eulerLogFlow (backward : Bool) (h t : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  let a := (if backward then -1 else 1)*Real.log (1+h^2)/(2*h)
  let b := Real.arctan h/h
  Real.exp (a*t) • WithLp.toLp 2 ![z 0*Real.cos (b*t)+z 1*Real.sin (b*t),
    z 1*Real.cos (b*t)-z 0*Real.sin (b*t)]
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.testSpace
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```
### 实际依赖 MD.Ch05.weakAttractor
```lean
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))
```
### 实际依赖 MD.Ch05.weakStationary
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-SymplecticWeakStationary",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "This implies that a density which is a function of $\\widetilde H_h$ will remain invariant under the associated Liouville equation. There are many solutions of $\\mathcal L_{\\widetilde f}^{*}\\rho=0$, none of which is attractive.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.symplecticWeakStationary",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]稳定区|h|<2下的真实二次modified Hamiltonian、Hamilton场及其实际全时间flow；保留能量函数密度弱稳态、至少两个不同概率稳态、全部概率稳态非吸引三项，不以单步能量保持替代。能量的正比例因子仅重参数化时间，不改变稳态/吸引命题。",
    "[EXTRA] 弱稳态接口使用前条实际一步对应的主对数modified Hamiltonian及其梯度场；函数能量密度、多种概率稳态和非吸引结论齐全，不把未按时间缩放的不变量场冒充数值步的时间h模型。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT23_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:19:38.401044",
      "before_sha256": "a895478d36d856e9504e4274c1d6dfa03e749ee8c5f80f644a7fb84879402a51",
      "after_sha256": "c65e4f542aab7e8043b51b0692a5d39143e440b32a47d2c186a0161847197399",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH28_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT23/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem symplecticWeakStationary : ∀ h : ℝ,|h| < 2 →
  let f := fun z : MolecularDynamics.Chapter05Review.E 2 => WithLp.toLp 2
    ![(gradient (symplecticEulerModifiedHamiltonian h) z) 1,-(gradient (symplecticEulerModifiedHamiltonian h) z) 0]
  ∀ Φ : ℝ → MolecularDynamics.Chapter05Review.E 2 → MolecularDynamics.Chapter05Review.E 2,MolecularDynamics.Chapter05Review.flow f Φ →
    (∀ r : ℝ → ℝ,MolecularDynamics.Chapter05Review.probabilityDensity (fun z => r (symplecticEulerModifiedHamiltonian h z)) →
      weakStationary f (MolecularDynamics.Chapter05Review.densityMeasure (fun z => r (symplecticEulerModifiedHamiltonian h z)))) ∧
    (∃ μ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ ∧ IsProbabilityMeasure ν ∧
      μ ≠ ν ∧ weakStationary f μ ∧ weakStationary f ν) ∧
    (∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure μ → weakStationary f μ → ¬weakAttractor Φ μ) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.densityMeasure
```lean
def densityMeasure {n : ℕ} (ρ : E n → ℝ) : Measure (E n) := volume.withDensity (fun z => ENNReal.ofReal (ρ z))
```
### 实际依赖 MolecularDynamics.Chapter05Review.flow
```lean
def flow {n : ℕ} (f : E n → E n) (Φ : ℝ → E n → E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.probabilityDensity
```lean
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MolecularDynamics.Chapter05Review.density
```lean
def density {n : ℕ} (ρ : E n → ℝ) : Prop :=
  Measurable ρ ∧ (∀ z, 0 ≤ ρ z) ∧ Integrable ρ volume
```
### 实际依赖 MolecularDynamics.Chapter05Review.densityMeasure
```lean
def densityMeasure {n : ℕ} (ρ : E n → ℝ) : Measure (E n) := volume.withDensity (fun z => ENNReal.ofReal (ρ z))
```
### 实际依赖 MD.Ch05.flow
```lean
def flow {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) : Prop :=
  (∀ z, Φ 0 z=z) ∧ (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) ∧
  ∀ t z, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.probabilityDensity
```lean
def probabilityDensity {n : ℕ} (ρ : E n → ℝ) : Prop := density ρ ∧ (∫ z, ρ z)=1
```
### 实际依赖 MolecularDynamics.Chapter05Review.shadowOscillator
```lean
def shadowOscillator (h : ℝ) (z : E 2) := (z 0^2+z 1^2-h*z 0*z 1)/2
```
### 实际依赖 MD.Ch05.symplecticEulerLogScale
```lean
def symplecticEulerLogScale (h : ℝ) : ℝ :=
  if h=0 then 1 else (2*Real.arcsin (h/2))/(h*Real.sqrt (1-h^2/4))
```
### 实际依赖 MD.Ch05.symplecticEulerModifiedHamiltonian
```lean
def symplecticEulerModifiedHamiltonian (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : ℝ :=
  symplecticEulerLogScale h*MolecularDynamics.Chapter05Review.shadowOscillator h z
```
### 实际依赖 MD.Ch05.testSpace
```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}
```
### 实际依赖 MD.Ch05.weakAttractor
```lean
def weakAttractor {n : ℕ} (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∃ m : ℕ,∃ ψ : Fin m → MolecularDynamics.Chapter05Review.E n → ℝ,∃ ε > 0,
    (∀ i,Continuous (ψ i) ∧ Bornology.IsBounded (range (ψ i))) ∧
    ∀ ν : Measure (MolecularDynamics.Chapter05Review.E n),IsProbabilityMeasure ν →
      (∀ i,|(∫ z,ψ i z ∂ν)-(∫ z,ψ i z ∂μ)| < ε) →
      ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun t => ∫ z,φ (Φ t z) ∂ν) atTop (𝓝 (∫ z,φ z ∂μ))
```
### 实际依赖 MD.Ch05.weakStationary
```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```
