# BATCH02 第7章原文与陈述审校

## MD-7.2-StrongOrder
```json
{
  "source_id": "MD-7.2-StrongOrder",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "Having settled on a choice of $\\alpha$, we say that a method has strong order $r$ if\n$\\mathrm{Err}_{h,\\tau}^{\\rm strong}<C(\\tau)h^r$ for some coefficient $C(\\tau)$ depending on the time interval.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "显式h=T/N趋零及统一常数的量词；正α、r和时间；有限矩资格作为方法适用条件不隐去。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.hasStrongOrder",
  "lean_declarations": [
    "MD.Ch07.hasStrongOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def hasStrongOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (α r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < α ∧ 0 < r ∧
  ∀ T : ℝ, 0 < T → ∃ C : ℝ, 0 < C ∧ ∃ N0 : ℕ, 0 < N0 ∧
    ∀ N : ℕ, N0 ≤ N →
      (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ |Xh (T/N) k sample - X (k*(T/N)) sample|^α) P) ∧
      strongError P (Xh (T/N)) X (T/N) α N < C * (T/N)^r
```

## MD-7.2-WeakError
```json
{
  "source_id": "MD-7.2-WeakError",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "265",
  "pdf_page": "286",
  "statement_latex": "The weak error is usually defined with reference to suitable test functions (observables) $\\phi(x)$ by\n\\[\\mathrm{Err}^{\\rm weak}_{h,\\tau,\\phi}=\\max_{n=0,1,2,\\ldots,\\nu}|\\mathbb E\\phi(X_n)-\\mathbb E\\phi(X(nh))|,\\]\nand we say that a method has weak order $r$ if $\\mathrm{Err}^{\\rm weak}_{h,\\tau,\\phi}<D(\\tau)h^r$ for some $D(\\tau)$, for all members of the chosen class of observables.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "测试函数类明确量化；D允许依赖测试函数；积分只有在可积时解释为期望，后续误差定理显式要求可积。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.weakError",
  "lean_declarations": [
    "MD.Ch07.weakError",
    "MD.Ch07.hasWeakOrder"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def weakError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (f : ℝ → ℝ) (h : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = |(∫ sample, f (Xh k sample) ∂P) - ∫ sample, f (X (k*h) sample) ∂P|}

def hasWeakOrder (P : Measure Ω) (Xh : ℝ → ℕ → Ω → ℝ)
    (X : ℝ → Ω → ℝ) (tests : Set (ℝ → ℝ)) (r : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ 0 < r ∧ ∀ f ∈ tests, ∀ T : ℝ, 0 < T →
    ∃ D : ℝ, 0 < D ∧ ∃ N0 : ℕ, 0 < N0 ∧
      ∀ N : ℕ, N0 ≤ N →
        (∀ k ∈ Finset.range (N+1), Integrable (fun sample ↦ f (Xh (T/N) k sample)) P ∧
          Integrable (fun sample ↦ f (X (k*(T/N)) sample)) P) ∧
        weakError P (Xh (T/N)) X f (T/N) N < D*(T/N)^r
```

## MD-7.2-StrongWeakComparison
```json
{
  "source_id": "MD-7.2-StrongWeakComparison",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "265",
  "pdf_page": "286",
  "statement_latex": "It is easy to see that methods with high strong order give us high weak order too, but the converse is generally false.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "正向结论明确限制为全局Lipschitz可观测量及可积误差；对一般无界测试函数需额外矩条件，列为覆盖缺口。",
    "反向用两点分布上交换X、Y的反例表达；同分布但耦合强误差不为零。"
  ],
  "issues": [],
  "statement_scope": "Lipschitz测试函数的逐步定量界与反向不成立的存在性；未证明一般多项式增长测试类的阶数传递。",
  "lean_decl": "MD.Ch07.strongWeakLipschitz",
  "lean_declarations": [
    "MD.Ch07.strongWeakLipschitz",
    "MD.Ch07.weakDoesNotImplyStrong"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem strongWeakLipschitz (P : Measure Ω) (X Y : Ω → ℝ)
    (f : ℝ → ℝ) (L : ℝ) (hL : 0 ≤ L)
    (hf : ∀ x y, |f x - f y| ≤ L * |x-y|)
    (hfx : Integrable (fun sample ↦ f (X sample)) P)
    (hfy : Integrable (fun sample ↦ f (Y sample)) P)
    (hxy : Integrable (fun sample ↦ |X sample-Y sample|) P) :
    |(∫ sample, f (X sample) ∂P) - ∫ sample, f (Y sample) ∂P| ≤
      L * ∫ sample, |X sample-Y sample| ∂P := by
  calc
    _ ≤ ∫ sample, |f (X sample)-f (Y sample)| ∂P :=
      meanErrorExpectation P _ _ hfx hfy
    _ ≤ ∫ sample, L * |X sample-Y sample| ∂P :=
      integral_mono (hfx.sub hfy).abs (hxy.const_mul L) (fun sample ↦ hf _ _)
    _ = _ := integral_const_mul _ _

theorem weakDoesNotImplyStrong : ∃ (P : Measure ℝ) (X Y : ℝ → ℝ),
    IsProbabilityMeasure P ∧
    (∀ f : ℝ → ℝ, (∫ sample, f (X sample) ∂P) = ∫ sample, f (Y sample) ∂P) ∧
    0 < ∫ sample, |X sample-Y sample| ∂P := by
  sorry
```

## MD-7.2-CanonicalAverage
```json
{
  "source_id": "MD-7.2-CanonicalAverage",
  "kind": "definition",
  "label": "(7.1)",
  "section": "7.2",
  "printed_page": "266",
  "pdf_page": "287",
  "statement_latex": "Recall that for canonical sampling, the (stationary or invariant) average of an observable $\\phi(q,p)$ is given as\n\\[\\operatorname{Av}_\\beta(\\phi)=\\int_D\\phi(q,p)\\rho_\\beta(q,p)d\\omega,\\tag{7.1}\\]\nwhere $\\rho_\\beta$ is the canonical measure\n\\[\\rho_\\beta(q,p)=Z_{\\rm can}^{-1}\\exp(-\\beta H(q,p)).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "该公式先保留显式Z参数；只有probabilityDensity成立才称概率密度。正有限配分积分及其归一化见修正版，不把原页倒数疑误带入默认定义。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.densityWithPartition",
  "lean_declarations": [
    "MD.Ch07.densityWithPartition",
    "MD.Ch07.canonicalAverage",
    "MD.Ch07.probabilityDensity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def densityWithPartition {D : Type*} (H : D → ℝ) (β Z : ℝ) (x : D) : ℝ :=
  Z⁻¹ * Real.exp (-β * H x)

def canonicalAverage {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z : ℝ) : ℝ := ∫ x, f x * densityWithPartition H β Z x ∂ν

def probabilityDensity {D : Type*} [MeasurableSpace D] (ν : Measure D) (ρ : D → ℝ) : Prop :=
  (∀ x, 0 ≤ ρ x) ∧ Integrable ρ ν ∧ (∫ x, ρ x ∂ν) = 1
```

## MD-7.2-PartitionPrinted
```json
{
  "source_id": "MD-7.2-PartitionPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "266",
  "pdf_page": "287",
  "statement_latex": "and $Z_{\\rm can}$ is the canonical partition function\n\\[Z_{\\rm can}^{-1}=\\int_D\\exp(-\\beta H(q,p))d\\omega,\\]\nensuring the integral of $\\rho_\\beta$ is unity.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原文版严格保留倒数关系；修正版取Z_can=配分积分，并补正性、可积性。",
    "反例的代数核心：取一点评价空间总质量1/2、H=0，则原式强制Z=2，密度积分为1/4；counterexample声明给出1/4≠1，测度实现的积分化简未另作声明。"
  ],
  "issues": [
    "已目视核对原页PDF287／印刷266：原书确为Z_can^{-1}=积分，和紧接的归一化断言不相容；不是转录错误。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.partitionPrinted",
  "lean_declarations": [
    "MD.Ch07.partitionPrinted",
    "MD.Ch07.partitionPrinted_counterexample",
    "MD.Ch07.partitionPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem partitionPrinted {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β Z : ℝ) (hZ : 0 < Z)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hPrinted : Z⁻¹ = ∫ x, Real.exp (-β*H x) ∂ν) :
    (∫ x, densityWithPartition H β Z x ∂ν) = 1 := by
  sorry

theorem partitionPrinted_counterexample :
    (2 : ℝ)⁻¹ * (2 : ℝ)⁻¹ ≠ 1 := by norm_num

theorem partitionPrinted_corrected {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H : D → ℝ) (β : ℝ)
    (hi : Integrable (fun x ↦ Real.exp (-β*H x)) ν)
    (hZ : 0 < ∫ x, Real.exp (-β*H x) ∂ν) :
    probabilityDensity ν (densityWithPartition H β (∫ x, Real.exp (-β*H x) ∂ν)) := by
  refine ⟨fun x ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ)) (le_of_lt (Real.exp_pos _)),
    hi.const_mul _, ?_⟩
  simp only [densityWithPartition, integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)
```

## MD-7.2-AverageNotationBias
```json
{
  "source_id": "MD-7.2-AverageNotationBias",
  "kind": "notation",
  "label": null,
  "section": "7.2",
  "printed_page": "266",
  "pdf_page": "287",
  "statement_latex": "In this chapter, we will abbreviate the exact average of the observable $\\phi$ to\n\\[\\langle\\phi\\rangle\\overset{\\rm def}=\\operatorname{Av}_\\beta(\\phi),\\]\nand write the observed average computed in experiment (using a discretization method with step size $h$) as $\\langle\\phi\\rangle_h$. The error in the average of $\\phi$ due to the perfect sampling bias can be evaluated as\n\\[\\text{Error due to discretization}=|\\langle\\phi\\rangle-\\langle\\phi\\rangle_h|.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "computed代表步长h下的不变平均，按原文忽略有限采样误差；正确Z和密度概率资格见CanonicalAverage及修正版。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.observableBias",
  "lean_declarations": [
    "MD.Ch07.observableBias",
    "MD.Ch07.bias_nonnegative"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def observableBias {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H f : D → ℝ) (β Z computed : ℝ) : ℝ :=
  bias (canonicalAverage ν H f β Z) computed

theorem bias_nonnegative (exact computed : ℝ) : 0 ≤ bias exact computed := abs_nonneg _
```
