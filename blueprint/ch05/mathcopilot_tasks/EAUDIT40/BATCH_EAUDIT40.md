# EAUDIT40：第5章§5.6网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-5.6-DiscreteAveragePrinted",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "If $z_n$ represents the approximation to $z(t_n)$, then we might attempt to estimate $\\bar g_\\Gamma$ by\n\\[\\bar g_\\Gamma\\approx\\lim_{n\\to\\infty}n^{-1}\\sum_{k=0}^ng(z_k).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原式包含n+1项却除n，字面有限和保留；无限极限并非对所有算法/所有轨道存在。",
    "原书平均记号为\\bar g_\\Gamma；z_k为数值轨道，形式化用G^[k] z表示自治单步映射迭代；原书未保证无限平均存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.discreteAveragePrinted",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "29bf153d736a561f82df2415e6952b92febc6a7c7a4ce3c292ea3da4d89fafa7",
      "after_sha256": "4cecb9f975ad63f6a46244d16b4a9b71d84336dbd970f6b8c8e1ccae9b0c6411",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)
```
### 实际依赖 MD.Ch05.discreteAveragePrinted
```lean
def discreteAveragePrinted {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range (N+1),g (G^[k] z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-DiscreteAverage",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "$\\bar g_\\Gamma\\approx\\lim_{n\\to\\infty}n^{-1}\\sum_{k=0}^ng(z_k)$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "原书平均记号为\\bar g_\\Gamma；z_k为数值轨道，形式化用G^[k] z表示自治单步映射迭代；原书未保证无限平均存在。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.discreteAverage",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。"
  ],
  "statement_scope": "仅标准N项平均的独立衍生变体；原印N+1项精确有限统计量由MD-5.6-DiscreteAveragePrinted承担，不宣称两有限值相同。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "36f3d688815efdfffa8c25166f58d2e4a88b084c8c2baf8127536e2531ff2b9c",
      "after_sha256": "99ab8fdb7c3aed699504fd707d0eef45e34bc0bd7767e6304317151b9b47b26d",
      "changed_fields": [
        "statement_latex",
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
```
### 实际依赖 MD.Ch05.discreteAverage
```lean
def discreteAverage {X : Type*} (G : X → X) (g : X → ℝ) (z : X) (N : ℕ) :=
  (N : ℝ)⁻¹*∑ k ∈ Finset.range N,g (G^[k] z)
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-DiscretePropagator",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "In a similar way, a numerical method $z_{n+1}=\\mathcal F_h(z_n)$ induces an effective distributional propagator.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际Measure.map迭代映射；不把有限modified equation宣称算法的精确全时流。",
    "G应可测（至少对μ几乎处处可测）才能把Measure.map解释为分布推前。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.discretePropagator",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA] 离散分布传播主接口显式限定可测G，避免不可测映射的Measure.map零总化被当概率推前。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "59c8c270fbef239dfd54967d849aee73a5ca2ee947c83e9471e39cff9a20ede3",
      "after_sha256": "a14e25ea05f2285e8f47c18d220d6bdc4598e08d3af2e4f97218d94987fc28a9",
      "changed_fields": [
        "statement_latex",
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (_hG : Measurable G) (μ : Measure X) := Measure.map G μ
```
### 实际依赖 MD.Ch05.discretePropagator
```lean
def discretePropagator {X : Type*} [MeasurableSpace X] (G : X → X) (_hG : Measurable G) (μ : Measure X) := Measure.map G μ
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-ModifiedField",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "One way to understand this propagator is to interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation\n\\[\\frac{dz}{dt}=f(z)+h^rf_{(r)}(z)\\equiv\\widetilde f_h(z).\\]\nThe perturbation term may be viewed as the finite truncation of the perturbative expansion obtained from the backward error analysis using the methods of the previous chapter. ($r$ is the order of the numerical method.)",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "实际有限截断向量场；近似与余项受控未由定义推出，不假设形式展开收敛。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch05.modifiedField",
  "reusable_proofs": [],
  "extra_assumptions": [],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "1b9ebebc809cc336ed6f90ed1246c5f1213205f283d2aecf05b6235c88a43356",
      "after_sha256": "1e4345df5d551880915eabf1f7e908260718e40d3ecf67143dac78c1b8c310ad",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.modifiedField
```lean
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-ModifiedLiouvillian",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "206",
  "pdf_page": "227",
  "statement_latex": "Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by\n\\[\\frac{\\partial\\rho}{\\partial t}=\\mathcal L_{\\widetilde f}^{*}\\rho\n\\stackrel{\\rm def}{\\equiv}\\mathcal L_f^{\\dagger}\\rho+h^r\\mathcal L_{f_{(r)}}^{\\dagger}\\rho.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.modifiedLiouvillian",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。",
    "[EXTRA] 保留算子线性证明，并新增原文假设的修正模型PDE定义（r≥1），与展开右侧的等价式；仅定义模型及其算子展开，不声称任意空间可微ρ自动满足PDE。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "047c915859911186ee50716e92be9d0bb8d7fc7eae60c1518a5ddafb0248b07c",
      "after_sha256": "c36f52cde8a300f93228d4b1a15329e7b51fdfad7548f84cc019ac42347ecc6a",
      "changed_fields": [
        "statement_latex"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem modifiedLiouvillian :
  ∀ n (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) h r,
  Differentiable ℝ f → Differentiable ℝ fr → Differentiable ℝ u → ∀ z,
  MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=MolecularDynamics.Chapter05Review.liouvillian f u z+h^r*MolecularDynamics.Chapter05Review.liouvillian fr u z := by
  intro n f fr u h r hf hfr hu z
  have hx : DifferentiableAt ℝ (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z :=
    (hf z).add ((hfr z).const_smul (h^r))
  rw [liouvilleProduct n _ u z hx (hu z),liouvilleProduct n f u z (hf z) (hu z),
    liouvilleProduct n fr u z (hfr z) (hu z)]
  have hd : MolecularDynamics.Chapter05Review.divergence (MolecularDynamics.Chapter05Review.modifiedField f fr h r) z=
      MolecularDynamics.Chapter05Review.divergence f z+(h^r)*MolecularDynamics.Chapter05Review.divergence fr z := by
    unfold MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.modifiedField
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      (fderiv ℝ (f+(h^r) • fr) z).toLinearMap=_
    rw [((hf z).hasFDerivAt.add ((hfr z).hasFDerivAt.const_smul (h^r))).fderiv]
    change LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
      ((fderiv ℝ f z).toLinearMap+(h^r) • (fderiv ℝ fr z).toLinearMap)=_
    simp only [map_add,map_smul,smul_eq_mul]
  have hl : MolecularDynamics.Chapter05Review.lie (MolecularDynamics.Chapter05Review.modifiedField f fr h r) u z=
      MolecularDynamics.Chapter05Review.lie f u z+(h^r)*MolecularDynamics.Chapter05Review.lie fr u z := by
    simp [MolecularDynamics.Chapter05Review.lie,MolecularDynamics.Chapter05Review.modifiedField,
      map_add,map_smul,smul_eq_mul]
  rw [hd,hl]
  ring

def modifiedDensityEquation {n : ℕ}
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (h : ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  ∀ t z,HasDerivAt (fun s ↦ ρ s z)
    (MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) (ρ t) z) t

theorem modifiedLiouvillian_model_equivalence (n : ℕ)
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : Differentiable ℝ f) (_hfr : Differentiable ℝ fr)
    (h : ℝ) (r : ℕ) (hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (_hρ : ∀ t,Differentiable ℝ (ρ t)) :
    modifiedDensityEquation f fr h r hr ρ ↔
      ∀ t z,HasDerivAt (fun s ↦ ρ s z)
        (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z+
          h^r*MolecularDynamics.Chapter05Review.liouvillian fr (ρ t) z) t := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.divergence
```lean
def divergence {n : ℕ} (f : E n → E n) (z : E n) : ℝ :=
  LinearMap.trace ℝ (E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MolecularDynamics.Chapter05Review.lie
```lean
def lie {n : ℕ} (f : E n → E n) (g : E n → ℝ) (z : E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MolecularDynamics.Chapter05Review.liouvillian
```lean
def liouvillian {n : ℕ} (f : E n → E n) (u : E n → ℝ) (z : E n) :=
  -divergence (fun x => u x • f x) z
```
### 实际依赖 MolecularDynamics.Chapter05Review.modifiedField
```lean
def modifiedField {n : ℕ} (f fr : E n → E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```
### 实际依赖 MD.Ch05.divergence
```lean
def divergence {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (z : MolecularDynamics.Chapter05Review.E n) : ℝ :=
  LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap
```
### 实际依赖 MD.Ch05.lie
```lean
def lie {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) := (fderiv ℝ g z) (f z)
```
### 实际依赖 MD.Ch05.liouvillian
```lean
def liouvillian {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ) (z : MolecularDynamics.Chapter05Review.E n) :=
  -MolecularDynamics.Chapter05Review.divergence (fun x => u x • f x) z
```
### 实际依赖 MD.Ch05.modifiedDensityEquation
```lean
def modifiedDensityEquation {n : ℕ}
    (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (h : ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) : Prop :=
  ∀ t z,HasDerivAt (fun s ↦ ρ s z)
    (MolecularDynamics.Chapter05Review.liouvillian (MolecularDynamics.Chapter05Review.modifiedField f fr h r) (ρ t) z) t
```
### 实际依赖 MD.Ch05.modifiedField
```lean
def modifiedField {n : ℕ} (f fr : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (h : ℝ) (r : ℕ) := fun z => f z+h^r • fr z
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-ForwardEnergyGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "the eigenvalues of the propagation matrix are outside the unit disk.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.forwardEnergyGrowth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。",
    "[EXTRA] 保留能量精确增长率并补原谱结论：两个复特征值恰为1±ih及模√(1+h²)>1，非零步长显式；不替换原两分量疑误。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "019cb7d0484e6184d65e6dede1b27e688f2e46f55bfe8dd12018291b20e9672c",
      "after_sha256": "ba3d1db545b2afb529210f5074c4be377069d51917a69a4b83b589d2f130910e",
      "changed_fields": [],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH24_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem forwardEnergyGrowth : ∀ (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) (k : ℕ),
  (((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 0)^2+(((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) 1)^2=
    (1+h^2)^k*((z 0)^2+(z 1)^2) := by
  intro h z k
  have hs (x : MolecularDynamics.Chapter05Review.E 2) :
      (MolecularDynamics.Chapter05Review.forwardEuler h x 0)^2+
        (MolecularDynamics.Chapter05Review.forwardEuler h x 1)^2=(1+h^2)*((x 0)^2+(x 1)^2) := by
    simp [MolecularDynamics.Chapter05Review.forwardEuler]
    ring
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply',hs,ih,pow_succ]
    ring

theorem forwardEnergyGrowth_spectrum (h : ℝ) (_hh : h ≠ 0) :
    let A : Matrix (Fin 2) (Fin 2) ℂ := !![1,(h : ℂ);-(h : ℂ),1]
    (∀ ζ : ℂ,(∃ v : Fin 2 → ℂ,v ≠ 0 ∧ A *ᵥ v=ζ • v) ↔
      ζ=1+Complex.I*h ∨ ζ=1-Complex.I*h) ∧
    ‖(1 : ℂ)+Complex.I*h‖=Real.sqrt (1+h^2) ∧
    ‖(1 : ℂ)-Complex.I*h‖=Real.sqrt (1+h^2) ∧ 1 < Real.sqrt (1+h^2) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.forwardEuler
```lean
def forwardEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```
### 实际依赖 MD.Ch05.forwardEuler
```lean
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-EulerInvariant",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "This means that with the single exception $\\rho(q,p;0)=\\delta[q]\\delta[p]$ there is no limiting (invariant) distribution for Forward Euler. To put it another way, the only solution, in the weak sense, of $\\mathcal L_{\\widetilde f}^{\\dagger}\\rho=0$ is the point distribution $\\delta[q]\\delta[p]$, and this solution is not “asymptotically stable.”",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.eulerInvariant",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]真实Forward Euler映射的不变概率测度，h≠0；一般modified微分方程的弱稳态并非自动等同离散不变测度，原记号作为解释而非未经证明的算子识别。",
    "[EXTRA] 除离散唯一性再补非Dirac初始概率的离散推前无任何弱概率极限；连续modified模型/稳态/非吸引分别明确绑定EulerLogCorrespondence与ForwardWeakStationary。"
  ],
  "statement_scope": "仅离散Euler唯一不变概率及非Dirac初始概率无弱概率极限（补列）；实际modified模型一步对应由MD-5.6-EulerLogCorrespondence，弱稳态唯一/非吸引由MD-5.6-ForwardWeakStationary承担。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT20_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:08.273883",
      "before_sha256": "ae064d76e59e4a7e2fc1241ebbdb1e1420d3937f7436313d3d172a9a94a7a7a0",
      "after_sha256": "837a7584b1428c7e41e10a5b42b913f3963cf281519ff471d42bb160072b18ce",
      "changed_fields": [
        "statement_latex",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT20/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem eulerInvariant :
  ∀ h : ℝ, h ≠ 0 → ∀ μ : Measure (MolecularDynamics.Chapter05Review.E 2),
  IsProbabilityMeasure μ → MeasurePreserving (MolecularDynamics.Chapter05Review.forwardEuler h) μ μ → μ=MolecularDynamics.Chapter05Review.diracMeasure 2 := by
  intro h hh μ hμ hΦ
  letI := hμ
  have heq : ∀ᵐ z ∂μ,z=(0 : MolecularDynamics.Chapter05Review.E 2) := by
    filter_upwards [hΦ.conservative.ae_frequently_mem_of_mem_nhds] with z hz
    by_contra hn
    have hs : 0 < (z 0)^2+(z 1)^2 := by
      have hs' : 0 < ‖z‖^2 := pow_pos (norm_pos_iff.mpr hn) _
      rw [EuclideanSpace.norm_sq_eq] at hs'
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using hs'
    have hp : 1 < 1+h^2 := by nlinarith [sq_pos_of_ne_zero hh]
    have ht := (tendsto_pow_atTop_atTop_of_one_lt hp).atTop_mul_const hs
    have hret := hz (Metric.ball 0 (‖z‖+1))
      (Metric.isOpen_ball.mem_nhds (by simp [Metric.mem_ball,dist_zero_right]))
    obtain ⟨k,hk,hlarge⟩ := (hret.and_eventually
      (ht.eventually (eventually_ge_atTop ((‖z‖+1)^2+1)))).exists
    have hen : ‖(MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z‖^2=
        (1+h^2)^k*((z 0)^2+(z 1)^2) := by
      rw [EuclideanSpace.norm_sq_eq]
      simpa [Fin.sum_univ_two,Real.norm_eq_abs] using forwardEnergyGrowth h z k
    rw [←hen] at hlarge
    rw [Metric.mem_ball,dist_zero_right] at hk
    nlinarith [norm_nonneg ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z),norm_nonneg z]
  have hm : Measure.map (fun z : MolecularDynamics.Chapter05Review.E 2 => z) μ =
      Measure.map (fun _ : MolecularDynamics.Chapter05Review.E 2 => (0 : MolecularDynamics.Chapter05Review.E 2)) μ := Measure.map_congr heq
  simpa [MolecularDynamics.Chapter05Review.diracMeasure,Measure.map_id,Measure.map_const] using hm

theorem eulerInvariant_no_probability_limit (h : ℝ) (_hh : h ≠ 0)
    (μ : Measure (MolecularDynamics.Chapter05Review.E 2)) (_hμ : IsProbabilityMeasure μ)
    (_hne : μ ≠ MolecularDynamics.Chapter05Review.diracMeasure 2) :
    ¬∃ ν : Measure (MolecularDynamics.Chapter05Review.E 2),IsProbabilityMeasure ν ∧
      ∀ φ : MolecularDynamics.Chapter05Review.E 2 → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
        Tendsto (fun k : ℕ ↦ ∫ z,φ ((MolecularDynamics.Chapter05Review.forwardEuler h)^[k] z) ∂μ)
          atTop (𝓝 (∫ z,φ z ∂ν)) := by
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
### 实际依赖 MolecularDynamics.Chapter05Review.forwardEuler
```lean
def forwardEuler (h : ℝ) (z : E 2) : E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```
### 实际依赖 MD.Ch05.diracMeasure
```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```
### 实际依赖 MD.Ch05.forwardEuler
```lean
def forwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 := WithLp.toLp 2 ![z 0+h*z 1,z 1-h*z 0]
```

## 原文JSON
```json
{
  "source_id": "MD-5.6-BackwardEuler",
  "kind": "definition",
  "label": null,
  "section": "5.6",
  "printed_page": "207",
  "pdf_page": "228",
  "statement_latex": "As an alternative, consider the Backward Euler method: $q_{n+1}=q_n+hp_{n+1}$, $p_{n+1}=p_n-hq_{n+1}$. Then it is easily shown that both eigenvalues of the matrix lie in the interior of the unit disk, and hence all solutions of the recurrence relation tend to the origin with increasing $n$ (the origin is an attractive equilibrium point).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [],
  "issues": [],
  "lean_decl": "MD.Ch05.backwardEuler",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]解出的实际二维线性更新，分母1+h²恒正；收缩需h≠0，h=0恒等映射不收缩。",
    "[EXTRA] 显式逐句范围及跨source_id映射；原文保留，repair_log追加。仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。"
  ],
  "statement_scope": "仅隐式Euler的显式解映射定义；完整复谱与模由MD-5.6-BackwardEnergyDecay补列，所有迭代趋零由MD-5.6-BackwardEulerLimit承担。",
  "review_status": "DRAFT",
  "repair_log": [
    {
      "stage": "EAUDIT21_LOCAL_REPAIR",
      "timestamp": "2026-10-16T10:18:38.392728",
      "before_sha256": "f53333ee147063792dea38db0e3e4d7045165782de79f145a7f9e729a8cd1def",
      "after_sha256": "3d89b5cf480fe1898d19209549079483d0db3cf08716ae56b34bedbc57452ac7",
      "changed_fields": [
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch05/mathcopilot_results/BATCH25_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT21/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.Chapter05Review.E
```lean
abbrev E (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MD.Ch05.backwardEuler
```lean
def backwardEuler (h : ℝ) (z : MolecularDynamics.Chapter05Review.E 2) : MolecularDynamics.Chapter05Review.E 2 :=
  WithLp.toLp 2 ![(z 0+h*z 1)/(1+h^2),(z 1-h*z 0)/(1+h^2)]
```
