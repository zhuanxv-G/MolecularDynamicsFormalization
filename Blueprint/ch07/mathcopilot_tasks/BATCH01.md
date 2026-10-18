# BATCH01 第7章原文与陈述审校

## MD-7.1-Bias
```json
{
  "source_id": "MD-7.1-Bias",
  "kind": "definition",
  "label": null,
  "section": "7.1",
  "printed_page": "263",
  "pdf_page": "284",
  "statement_latex": "All standard methods based on discretizing SDEs introduce some stepsize-dependent error in computed averages, which we shall refer to as bias (related to the truncation error of the discretization scheme).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "将本段bias记号具体写为后文印刷p.266所给的绝对平均误差；不把“所有标准方法”量化成无条件定理。"
  ],
  "issues": [],
  "statement_scope": "离散平均值偏差的定义；本段关于标准方法的概述不作为普遍量化结论。",
  "lean_decl": "MD.Ch07.bias",
  "lean_declarations": [
    "MD.Ch07.bias"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bias (exact computed : ℝ) : ℝ := |exact - computed|
```

## MD-7.2-ScalarSDE
```json
{
  "source_id": "MD-7.2-ScalarSDE",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "Let us begin with a discussion of the first order stochastic differential equation\n\\[dX=a(X)dt+b(X)dW,\\]\nwhere $W$ defines a standard scalar Wiener process.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "明确概率空间与标准连续Wiener过程；Itô积分采用第6章网格左和L²定义，扩散项适应自然历史且时间平方可积。",
    "X的初值、几乎处处路径连续性和积分方程在第6章定义体中全部保留；未声称一般弱解与本L²表示等价。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.scalarSDE",
  "lean_declarations": [
    "MD.Ch07.scalarSDE"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def scalarSDE (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 : ℝ) : Prop :=
  IsProbabilityMeasure P ∧ IsBrownianReal (fun t sample ↦ W t sample) P ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ T : ℝ, 0 ≤ T → ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 T) ∧
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W
    (fun t sample ↦ b (X t sample)) ∧
  MolecularDynamics.Chapter06Review.scalarSDE P W X
    (fun x _ ↦ a x) (fun x _ ↦ b x) x0
```

## MD-7.2-EulerMaruyama
```json
{
  "source_id": "MD-7.2-EulerMaruyama",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "The natural extension of the Euler method for SDEs like this one takes the form\n\\[X_{n+1}=X_n+ha(X_n)+b(X_n)\\sqrt h R_n,\\]\nwhere $R_n$ is a normal random variable with zero mean and unit variance. This method is referred to as the Euler-Maruyama method.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "步长h>0用于数值解释；单步映射本身为总函数；跨步独立正态资格另由standardNormalSequence明确给出。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.eulerMaruyamaStep",
  "lean_declarations": [
    "MD.Ch07.eulerMaruyamaStep",
    "MD.Ch07.standardNormalSequence",
    "MD.Ch07.eulerMaruyama"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def eulerMaruyamaStep (a b : ℝ → ℝ) (h x R : ℝ) : ℝ :=
  x + h * a x + b x * Real.sqrt h * R

def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧
  ∀ k, HasLaw (R k) (gaussianReal 0 1) P

def eulerMaruyama (a b : ℝ → ℝ) (h x0 : ℝ) (R : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | k+1 => fun sample ↦ eulerMaruyamaStep a b h (eulerMaruyama a b h x0 R k sample) (R k sample)
```

## MD-7.2-SDEIncrement
```json
{
  "source_id": "MD-7.2-SDEIncrement",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "Note that from the definition of the SDE, we may write\n\\[X(t+h)=X(t)+\\int_t^{t+h}a(X(s))ds+\\int_t^{t+h}b(X(s))dW(s).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "区间Itô积分用两个从0开始的L²积分值之差表示；t,h非负，漂移在整个区间可积；不另造未规定的随机积分。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.sdeIncrement",
  "lean_declarations": [
    "MD.Ch07.sdeIncrement"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem sdeIncrement (P : Measure Ω) (W X : ℝ → Ω → ℝ)
    (a b : ℝ → ℝ) (x0 t h : ℝ) (ht : 0 ≤ t) (hh : 0 ≤ h)
    (hX : scalarSDE P W X a b x0)
    (ha : ∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 (t+h)) :
    MolecularDynamics.Chapter06Review.isItoIntegral P W (fun s sample ↦ b (X s sample)) (t+h)
      (fun sample ↦ X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) ∧
    ∀ᵐ sample ∂P, X (t+h) sample - X t sample =
      (∫ s in t..(t+h), a (X s sample)) +
      ((X (t+h) sample - x0 - ∫ s in 0..(t+h), a (X s sample)) -
       (X t sample - x0 - ∫ s in 0..t, a (X s sample))) := by
  sorry
```

## MD-7.2-StrongError
```json
{
  "source_id": "MD-7.2-StrongError",
  "kind": "definition",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "In the case of strong accuracy, our measure of the global error is the quantity [200]\n\\[\\mathrm{Err}_{h,\\tau;\\alpha}^{\\rm strong}=\\max_{n=0,1,2,\\ldots,\\nu}\n\\left[\\mathbb E|X_n-X(nh)|^\\alpha\\right]^{1/\\alpha}.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [
    "τ=νh固定；Xh与X在同一概率空间耦合。"
  ],
  "extra_assumptions": [
    "α>0且各网格误差的α次矩可积时具有误差解释；有限非空网格的sSup表示最大值；Real.rpow为实指数幂。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.strongError",
  "lean_declarations": [
    "MD.Ch07.strongError"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def strongError (P : Measure Ω) (Xh : ℕ → Ω → ℝ) (X : ℝ → Ω → ℝ)
    (h α : ℝ) (N : ℕ) : ℝ :=
  sSup {v | ∃ k ∈ Finset.range (N+1),
    v = (∫ sample, |Xh k sample - X (k*h) sample| ^ α ∂P) ^ (1/α)}
```

## MD-7.2-MeanErrorExpectation
```json
{
  "source_id": "MD-7.2-MeanErrorExpectation",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.2",
  "printed_page": "264",
  "pdf_page": "285",
  "statement_latex": "For $\\alpha=1$ this implies convergence of expectation. The more natural choice from the probabilistic point of view is $\\alpha=2$ (mean square convergence).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "期望可积；不以数值方法的收敛为假设重新宣布同一收敛，只给使收敛传递成立的定量不等式。"
  ],
  "issues": [],
  "statement_scope": "α=1所需期望误差不等式，及α=2均方误差的记号；网格极限通过此界立即归约。",
  "lean_decl": "MD.Ch07.meanErrorExpectation",
  "lean_declarations": [
    "MD.Ch07.meanErrorExpectation",
    "MD.Ch07.meanSquareError"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem meanErrorExpectation (P : Measure Ω) (X Y : Ω → ℝ)
    (hX : Integrable X P) (hY : Integrable Y P) :
    |(∫ sample, X sample ∂P) - ∫ sample, Y sample ∂P| ≤
      ∫ sample, |X sample - Y sample| ∂P := by
  rw [← integral_sub hX hY]
  simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun sample ↦ X sample - Y sample)

def meanSquareError (P : Measure Ω) (X Y : Ω → ℝ) : ℝ :=
  Real.sqrt (∫ sample, (X sample - Y sample)^2 ∂P)
```
