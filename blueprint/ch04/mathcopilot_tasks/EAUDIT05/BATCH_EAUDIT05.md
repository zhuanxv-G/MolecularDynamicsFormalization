# EAUDIT05：第4章§4.2.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ResonanceTaylor",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "We can see this by expanding $\\mu(h)=2\\cos(h\\Omega)-\\frac h\\Omega\\sin(h\\Omega)$ in a Taylor expansion around $h=\\pi/\\Omega$:\n\\[\\mu(h)=-2+\\varepsilon,\\qquad\\varepsilon=\\frac\\pi\\Omega(h-\\pi/\\Omega).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.168（印刷p.146）：状态列向量为(q,p)ᵀ；Ω≫1是模型背景。此处代数结论适用于任意Ω>0，不需要定量大频率门槛。",
    "S_h=[[1,0],[-h,1]]；F_h=[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]；W_h=S_{h/2}F_hS_{h/2}，快子系统在内步趋零时采用精确流，不是一次Verlet更新。",
    "λ₁、λ₂是W_h的两个复特征根，按代数重数计；det(W_h)=1，μ(h)=Tr(W_h)=2cos(hΩ)−(h/Ω)sin(hΩ)。",
    "h₀=π/Ω；ε=(π/Ω)(h−h₀)。原展示μ(h)=−2+ε是截断的一阶Taylor写法，非精确恒等式；同页随后λ+λ⁻¹=−2+ε+O(ε²)明确保留余项。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceTaylor",
  "reusable_proofs": [],
  "extra_assumptions": [
    "[EXTRA]原省略高阶项以真实一致O((h−π/Ω)²)余项保留，不将截断线性式当精确等式。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:54:42.701512",
      "before_sha256": "c0737d6d1cdec4190a0dc4c275ae97292cecac54d570df8cfbbfdd848ef1061f",
      "after_sha256": "576f876d207a2e3123fedebef6e77f31aed99e0a6789af8e42067ca469fb4fee",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem resonanceTaylor :
  ∀ Ω : ℝ, 0 < Ω → ∃ C > 0, ∃ δ > 0,
  ∀ h : ℝ, |h-Real.pi/Ω| < δ →
    |(MolecularDynamics.Chapter04Review.impulseMatrix Ω h).trace+2-(Real.pi/Ω)*(h-Real.pi/Ω)| ≤ C*(h-Real.pi/Ω)^2 := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ResonanceInstability",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "Here both eigenvalues are real and one is outside the unit circle. There is thus a small interval of exponential instability directly below $h=\\pi/\\Omega$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.168（印刷p.146）：状态列向量为(q,p)ᵀ；Ω≫1是模型背景。此处代数结论适用于任意Ω>0，不需要定量大频率门槛。",
    "S_h=[[1,0],[-h,1]]；F_h=[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]；W_h=S_{h/2}F_hS_{h/2}，快子系统在内步趋零时采用精确流，不是一次Verlet更新。",
    "λ₁、λ₂是W_h的两个复特征根，按代数重数计；det(W_h)=1，μ(h)=Tr(W_h)=2cos(hΩ)−(h/Ω)sin(hΩ)。",
    "Here指ε<0，即h<π/Ω且充分接近π/Ω；两个根均实且互为倒数，至少一个模大于1。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceInstability",
  "reusable_proofs": [],
  "extra_assumptions": [
    "Ω>0；存在左邻域，每个h有真实复谱模>1。",
    "[EXTRA] 补共振左邻域完整两实根分解、圆外根及实际指数轨道；δ≤π/Ω明确正步长。旧圆外复根结论保留。"
  ],
  "statement_scope": "本条所引原句及展示公式；单个记号归入context_notation。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:54:42.701512",
      "before_sha256": "fe88ef09219960731bde62560632ec9d10ee1adad477b1623e538ed252fc5d21",
      "after_sha256": "bef5cc18281405f3e77418477c2d378ffe4c77cc54d93963bcae09351247a531",
      "changed_fields": [
        "context_notation"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem resonanceInstability :
  ∀ Ω : ℝ, 0 < Ω → ∃ δ > 0,
  ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω), MolecularDynamics.Chapter04Review.eigenvalueOutside (MolecularDynamics.Chapter04Review.impulseMatrix Ω h) := by
  sorry

theorem resonanceInstability_realSpectrum (Ω : ℝ) (_hΩ : 0 < Ω) :
    ∃ δ > 0, δ ≤ Real.pi/Ω ∧ ∀ h ∈ Ioo (Real.pi/Ω-δ) (Real.pi/Ω),
      ∃ a b : ℝ, 1 < max |a| |b| ∧
        (∀ ζ : ℂ, (ζ • (1 : Matrix (Fin 2) (Fin 2) ℂ)-
          (MolecularDynamics.Chapter04Review.impulseMatrix Ω h).map Complex.ofReal).det=
            (ζ-(a:ℂ))*(ζ-(b:ℂ))) ∧
        (∃ v : Fin 2 → ℝ, v ≠ 0 ∧
          ((1 < |a| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=a^k • v) ∨
           (1 < |b| ∧ ∀ k : ℕ, (MolecularDynamics.Chapter04Review.impulseMatrix Ω h)^k *ᵥ v=b^k • v))) := by
  sorry
```
### 实际依赖 MolecularDynamics.Chapter04Review.eigenvalueOutside
```lean
def eigenvalueOutside (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ rho : ℂ, 1 < ‖rho‖ ∧ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (A.map Complex.ofReal) *ᵥ v = rho • v
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MolecularDynamics.Chapter04Review.eigenvalueOutside
```lean
def eigenvalueOutside (A : Matrix (Fin 2) (Fin 2) ℝ) : Prop :=
  ∃ rho : ℂ, 1 < ‖rho‖ ∧ ∃ v : Fin 2 → ℂ, v ≠ 0 ∧ (A.map Complex.ofReal) *ᵥ v = rho • v
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```

## 原文JSON
```json
{
  "source_id": "MD-4.2.1-ResonanceGrowth",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "4.2.1",
  "printed_page": "147",
  "pdf_page": "169",
  "statement_latex": "and the norm of the solution will oscillate and grow linearly with $n$ as $n\\to\\infty$. This is the simplest type of linear resonance present in multiple timestepping.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "proof_discussion_latex": null,
  "context_notation": [
    "PDF p.168（印刷p.146）：状态列向量为(q,p)ᵀ；Ω≫1是模型背景。此处代数结论适用于任意Ω>0，不需要定量大频率门槛。",
    "S_h=[[1,0],[-h,1]]；F_h=[[cos(Ωh),sin(Ωh)/Ω],[-Ωsin(Ωh),cos(Ωh)]]；W_h=S_{h/2}F_hS_{h/2}，快子系统在内步趋零时采用精确流，不是一次Verlet更新。",
    "λ₁、λ₂是W_h的两个复特征根，按代数重数计；det(W_h)=1，μ(h)=Tr(W_h)=2cos(hΩ)−(h/Ω)sin(hΩ)。",
    "本句承接PDF p.168的W_h^n公式，固定h=π/Ω且z₀=(q₀,p₀)ᵀ：z_n=(−1)^n(q₀,p₀−nhq₀)ᵀ。线性增长需要q₀≠0；q₀=0时范数恒定。",
    "原句norm ... oscillate照录保留；交替的是解的整体符号，范数一般没有交替振荡。Lean Fin 2→ℝ采用Pi最大范数；仅范数趋无穷没有表达所引句子的线性增长率。"
  ],
  "issues": [],
  "lean_decl": "MD.Ch04.resonanceGrowth",
  "reusable_proofs": [],
  "extra_assumptions": [
    "原泛称增长补q0≠0；q0=0时纯动量轨道模不增长。",
    "[EXTRA] 本条明确为发散推论；线性率由MD-4.2.1-ResonanceLinearRate、交替幂公式由MD-4.2.1-ResonancePower承担，原norm振荡疑误在LinearRate待导师，不删句。"
  ],
  "statement_scope": "仅非零q初值轨道发散推论；完整线性率见MD-4.2.1-ResonanceLinearRate，带(-1)^k的精确幂见MD-4.2.1-ResonancePower，norm振荡措辞待导师。",
  "review_status": "CORRECTED",
  "repair_log": [
    {
      "stage": "EAUDIT05_LOCAL_REPAIR",
      "timestamp": "2026-10-15T12:54:42.701512",
      "before_sha256": "0d22e0146acf39de613a40c19d79cb5bb4fac67d9f194b92f44667b2dd20551e",
      "after_sha256": "c3a725db50f0a0333cd8452142501a2563f60671687d6d344059edfeda5ab2d3",
      "changed_fields": [
        "context_notation",
        "statement_scope"
      ],
      "annotation_corrections": {},
      "raw_return": "blueprint/ch04/mathcopilot_results/BATCH05_result.json",
      "reason": "已视觉核对原PDF页；签名修复/审校或导师分流；不写新证明、不裁定原书疑误。"
    }
  ],
  "source_page_verification": "VERIFIED_RENDERED; validation/EAUDIT05/SOURCE_PAGE_VERIFICATION.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem resonanceGrowth :
  ∀ Ω : ℝ, 0 < Ω → ∀ z : Fin 2 → ℝ, z 0 ≠ 0 →
  Tendsto (fun k : ℕ => ‖(MolecularDynamics.Chapter04Review.impulseMatrix Ω (Real.pi/Ω))^k *ᵥ z‖) atTop atTop := by
  intro Ω hΩ z hz
  have hc : 0 < |(Real.pi/Ω)*z 0| := abs_pos.mpr (mul_ne_zero (div_ne_zero Real.pi_ne_zero (ne_of_gt hΩ)) hz)
  have hr := resonanceLinearRate Ω hΩ z hz
  have ht := hr.pos_mul_atTop hc (tendsto_natCast_atTop_atTop (R := ℝ))
  apply ht.congr'
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with k hk
  have hk0 : (k : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hk)
  exact div_mul_cancel₀ _ hk0
```
### 实际依赖 MolecularDynamics.Chapter04Review.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MolecularDynamics.Chapter04Review.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := slowMatrix (h/2) * fastMatrix Ω h * slowMatrix (h/2)
```
### 实际依赖 MolecularDynamics.Chapter04Review.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
### 实际依赖 MD.Ch04.fastMatrix
```lean
def fastMatrix (Ω h : ℝ) (_hΩ : Ω ≠ 0) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos (Ω*h),Real.sin (Ω*h)/Ω; -Ω*Real.sin (Ω*h),Real.cos (Ω*h)]
```
### 实际依赖 MD.Ch04.impulseMatrix
```lean
def impulseMatrix (Ω h : ℝ) := MolecularDynamics.Chapter04Review.slowMatrix (h/2) * MolecularDynamics.Chapter04Review.fastMatrix Ω h * MolecularDynamics.Chapter04Review.slowMatrix (h/2)
```
### 实际依赖 MD.Ch04.slowMatrix
```lean
def slowMatrix (h : ℝ) : Matrix (Fin 2) (Fin 2) ℝ := !![1,0; -h,1]
```
