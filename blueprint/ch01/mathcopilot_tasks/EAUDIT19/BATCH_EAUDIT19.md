# EAUDIT19：第1章§1.6.1网站修复复审

## 原文JSON
```json
{
  "source_id": "MD-1.6.1-MinimumGradientZero",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "36–37",
  "pdf_page": "59–60",
  "statement_latex": "Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where\n\\[\\nabla U=0,\\]\nwhich gives in general a nonlinear system of $N_c$ equations in $N_c$ unknowns to be solved for the position vector $\\boldsymbol q^*$ associated to mechanical equilibrium.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "不限定内点及可微时，Regardless of boundary的全梯度零过强；显式[EXTRA]内点解释。"
    }
  ],
  "lean_decl": "MD.Ch01.minimumgradientzero",
  "extra_assumptions": [
    "可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。"
  ],
  "old_ids": [
    "CH01-166"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem minimumgradientzero :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved

/-- 修正版，对应原文 MD-1.6.1-MinimumGradientZero，改动：显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。 -/
theorem minimumgradientzero_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-1.6.1-ForceLinearization",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "At the equilibrium point, we can linearize the system of differential equations by computing the Hessian matrix, then we find\n\\[\\nabla U(\\boldsymbol q)\\approx U''(\\boldsymbol q^*)(\\boldsymbol q-\\boldsymbol q^*).\\]\nThen, letting $\\delta\\boldsymbol q=\\boldsymbol q-\\boldsymbol q^*$, $\\delta\\boldsymbol p$ represent small deviations from the equilibrium point at $(\\boldsymbol q,\\boldsymbol p)=(\\boldsymbol q^*,0)$, we have\n\\[\\frac{\\mathrm d\\delta\\boldsymbol q}{\\mathrm dt}=\\boldsymbol M^{-1}\\delta\\boldsymbol p,\\qquad\\frac{\\mathrm d\\delta\\boldsymbol p}{\\mathrm dt}=-U''(\\boldsymbol q^*)\\delta\\boldsymbol q.\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.force_linearization",
  "extra_assumptions": [
    "真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。"
  ],
  "old_ids": [
    "CH01-167",
    "CH01-168",
    "CH01-170"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar) := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  constructor
  · change HasFDerivAt (fun z : PhaseSpace n => (B z.2, -gradient U z.1)) _ (qstar,0)
    have hn : HasFDerivAt (fun q => -gradient U q) (-fderiv ℝ (gradient U) qstar) qstar :=
      hg.hasFDerivAt.neg
    have h₂ := hn.comp (qstar,0)
      ((ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    have h₁ := B.hasFDerivAt.comp (qstar,0)
      ((ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    exact h₁.prodMk h₂
  · have h := hasFDerivAt_iff_isLittleO.mp hg.hasFDerivAt
    simpa only [heq, sub_zero] using h
```
### 实际依赖 MolecularDynamics.Momentum
```lean
abbrev Momentum (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PhaseSpace
```lean
abbrev PhaseSpace (n : ℕ) := Position n × Momentum n
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```
### 实际依赖 MD.Ch01.matrixAction
```lean
noncomputable def matrixAction {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ)
    (v : Position n) : Position n := Matrix.toEuclideanLin A v
```

## 原文JSON
```json
{
  "source_id": "MD-1.6.1-MinimumHessianLiteral",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "At the minimum of the potential energy, $U''$ is a positive definite symmetric matrix.",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [],
  "review_status": "DRAFT",
  "issues": [
    {
      "code": "ERRATUM?",
      "status": "NEEDS_HUMAN",
      "detail": "局部极小Hessian仅半正定；U(x)=x^4在0为严格极小但二阶导数0。"
    }
  ],
  "lean_decl": "MD.Ch01.minimumhessianliteral",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-169"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem minimumhessianliteral :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

/-- 修正版，对应原文 MD-1.6.1-MinimumHessianLiteral，改动：正定改为半正定；仍保留Hessian对称性及所有非零方向。 -/
theorem minimumhessianliteral_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 ≤ inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

theorem minimumhessianliteral_counterexample :
    IsLocalMin (fun x : ℝ => x^4) 0 ∧ deriv (deriv (fun x : ℝ => x^4)) 0 = 0 := by
  constructor
  · change ∀ᶠ x in 𝓝 (0 : ℝ), (0 : ℝ)^4 ≤ x^4
    exact Filter.Eventually.of_forall (fun x => by norm_num only [zero_pow]; positivity)
  · have hd : deriv (fun x : ℝ => x^4) = fun x => 4*x^3 := by
      funext x
      convert ((hasDerivAt_id x).pow 4).deriv using 1 <;> simp
    rw [hd]
    simpa using (((hasDerivAt_id (0 : ℝ)).pow 3).const_mul 4).deriv
```
### 实际依赖 MolecularDynamics.Position
```lean
abbrev Position (n : ℕ) := EuclideanSpace ℝ (Fin n)
```
### 实际依赖 MolecularDynamics.PotentialEnergy
```lean
abbrev PotentialEnergy (n : ℕ) := Position n → ℝ
```

## 原文JSON
```json
{
  "source_id": "MD-1.6.1-ComplexNormalMode",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "Associated to each eigenvalue pair we have a pair of complex conjugate eigenvectors $\\boldsymbol\\xi,\\overline{\\boldsymbol\\xi}$ and also a pair of solutions which can be written in the complex form\n\\[\\boldsymbol z(t)=ae^{i\\Omega t}\\boldsymbol\\xi+be^{-i\\Omega t}\\overline{\\boldsymbol\\xi},\\]\n($a,b$ complex coefficients),",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "实A确保共轭模式；两个解的复线性组合，未强迫结果为实。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.complexnormalmode",
  "extra_assumptions": [
    "[EXTRA] 19号：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。"
  ],
  "old_ids": [
    "CH01-172"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem complexnormalmode :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    η ≠ 0 → (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    (fun i => star (η i)) ≠ 0 ∧
    (A.map (algebraMap ℝ ℂ)).mulVec (fun i => star (η i)) =
      (-Complex.I * Ω) • (fun i => star (η i)) ∧
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t := by
  sorry
```

## 原文JSON
```json
{
  "source_id": "MD-1.6.1-RealNormalMode",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "1.6.1",
  "printed_page": "37",
  "pdf_page": "60",
  "statement_latex": "or recast in real form as ($\\alpha,\\beta$ real coefficients):\n\\[\\boldsymbol z(t)=\\alpha[\\sin(\\Omega t)\\operatorname{Re}(\\boldsymbol\\xi)+\\cos(\\Omega t)\\operatorname{Im}(\\boldsymbol\\xi)]+\\beta[\\cos(\\Omega t)\\operatorname{Re}(\\boldsymbol\\xi)-\\sin(\\Omega t)\\operatorname{Im}(\\boldsymbol\\xi)].\\]",
  "proof_latex": null,
  "proof_note": "原书无独立完整证明。",
  "context_notation": [
    "u=Reξ,v=Imξ，Au=-Ωv、Av=Ωu来自实矩阵复特征向量方程；realNormalMode展开即原式。"
  ],
  "review_status": "DRAFT",
  "issues": [],
  "lean_decl": "MD.Ch01.realnormalmode",
  "extra_assumptions": [],
  "old_ids": [
    "CH01-173"
  ],
  "source_page_verification": "VERIFIED_RENDERED; source_page_checks.json"
}
```
## 完整当前Lean（同一source_id的全部声明）
```lean
theorem realnormalmode :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ),
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t := by
  exact @MolecularDynamics.hasDerivAt_realNormalMode

/- END FULL SECTION 1.6 -/

/- BEGIN FULL SECTION 1.7 -/
```
### 实际依赖 MolecularDynamics.realNormalMode
```lean
def realNormalMode {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (Ω α β : ℝ) (u v : E) (t : ℝ) : E :=
  α • (Real.sin (Ω * t) • u + Real.cos (Ω * t) • v) +
    β • (Real.cos (Ω * t) • u - Real.sin (Ω * t) • v)
```
