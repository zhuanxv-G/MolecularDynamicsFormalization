# BATCH07 第7章原文与陈述审校

## MD-7.4.1-ABOHarmonic
```json
{
  "source_id": "MD-7.4.1-ABOHarmonic",
  "kind": "unnumbered_claim",
  "label": "Example 7.1 / (7.12)",
  "section": "7.4.1",
  "printed_page": "275–276",
  "pdf_page": "296–297",
  "statement_latex": "Example 7.1 Consider the scheme coded $[ABO]$.\nIn the case of the one-dimensional harmonic oscillator, we have $U'(q)=\\Omega^2q$, yielding the compact form of one iteration as\n\\[\\binom{q_{n+1}}{p_{n+1}}=\\begin{bmatrix}1&h/m\\\\-\\Omega^2he^{-h\\gamma}&(1-\\Omega^2h^2/m)e^{-h\\gamma}\\end{bmatrix}\\binom{q_n}{p_n}+\\binom0{\\zeta m^{1/2}R_n}.\\tag{7.12}\\]\nTaking expectations of (7.12) and then taking the limit as $n\\to\\infty$, we see immediately that\n$\\langle q\\rangle_h^{[ABO]}=\\langle p\\rangle_h^{[ABO]}=0$, as $\\mathbb E(R_n)=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "原文长时间极限前提改为已存在的实际平稳概率分布及一阶矩可积；趋平稳结论不在本条覆盖。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aboHarmonic",
  "lean_declarations": [
    "MD.Ch07.aboHarmonic",
    "MD.Ch07.aboStationaryMean"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aboHarmonic (m Ω γ θ h R : ℝ) (x : ℝ × ℝ) : ℝ × ℝ :=
  linearUpdate 1 (h/m) (-Ω^2*h*Real.exp (-h*γ)) ((1-Ω^2*h^2/m)*Real.exp (-h*γ)) x
    (0, Real.sqrt (θ*(1-Real.exp (-2*γ*h)))*Real.sqrt m*R)

theorem aboStationaryMean (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : Integrable (fun x ↦ x.1) μ) (hp : Integrable (fun x ↦ x.2) μ)
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    (∫ x, x.1 ∂μ) = 0 ∧ (∫ x, x.2 ∂μ) = 0 := by
  sorry
```

## MD-7.4.1-ABOVariance
```json
{
  "source_id": "MD-7.4.1-ABOVariance",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.1",
  "printed_page": "276",
  "pdf_page": "297",
  "statement_latex": "For example, the relative increase in the variance of position is computed for the $[ABO]$ scheme as\n\\[\\frac{\\langle q^2\\rangle_h^{[ABO]}}{\\langle q^2\\rangle}=\\frac{e^{h\\gamma}m(1+e^{-h\\gamma})^2}{2m(1+e^{-h\\gamma})-h^2\\Omega^2e^{-h\\gamma}}\n=1+\\gamma h/2+(\\Omega^2+\\gamma^2m)h^2/(4m)+O(h^3).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "完整保留方差有理式与Taylor展开；实际平稳概率、L²及稳定区分母为正明示，不假设目标方差公式。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aboVarianceRatio",
  "lean_declarations": [
    "MD.Ch07.aboVarianceRatio",
    "MD.Ch07.aboVarianceRatio_expansion",
    "MD.Ch07.aboStationaryVariance"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aboVarianceRatio (m Ω γ h : ℝ) : ℝ :=
  Real.exp (h*γ)*m*(1+Real.exp (-h*γ))^2 /
    (2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))

theorem aboVarianceRatio_expansion (m Ω γ : ℝ) (hm : 0 < m) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ aboVarianceRatio m Ω γ h - (1+γ*h/2+(Ω^2+γ^2*m)*h^2/(4*m)))
      (fun h ↦ h^3) := by
  sorry

theorem aboStationaryVariance (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hμ : IsProbabilityMeasure μ) (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hden : 0 < 2*m*(1+Real.exp (-h*γ))-h^2*Ω^2*Real.exp (-h*γ))
    (hinv : Measure.map (fun z ↦ aboHarmonic m Ω γ θ h z.2 z.1) (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ / (θ/Ω^2) = aboVarianceRatio m Ω γ h := by
  sorry
```

## MD-7.4.1-Table71
```json
{
  "source_id": "MD-7.4.1-Table71",
  "kind": "unnumbered_claim",
  "label": "Table 7.1",
  "section": "7.4.1",
  "printed_page": "277",
  "pdf_page": "298",
  "statement_latex": "Table 7.1 The expected long-time computed average using the given second-order Langevin dynamics discretization scheme\n\\[\\begin{array}{c|ccc}\n\\text{Scheme}&\\langle q^2\\rangle_h/\\langle q^2\\rangle&\\langle p^2\\rangle_h/\\langle p^2\\rangle&\\langle qp\\rangle\\\\\n[ABOBA]&1&[1-h^2\\Omega^2/(4m)]^{-1}&0\\\\\n[OBABO]&[1-h^2\\Omega^2/(4m)]^{-1}&1&0\\\\\n[BAOAB]&1&1-h^2\\Omega^2/(4m)&0\\\\\n[OABAO]&1-h^2\\Omega^2/(4m)&1&0\n\\end{array}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "表7.1是由矩方程推导的精确数学公式，保留为待证；与数值实验观测表区分。",
    "4个算法均使用本章完整定义、独立标准正态乘积与实际平稳推前；不把所需矩值写成假设。",
    "只陈述已存在平稳概率的矩；长期收敛和遍历解释另列缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.scalarLift",
  "lean_declarations": [
    "MD.Ch07.scalarLift",
    "MD.Ch07.symmetricHarmonicStep",
    "MD.Ch07.symmetricInvariant",
    "MD.Ch07.table71"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def scalarLift (F : Phase 1 → Phase 1) (x : ℝ × ℝ) : ℝ × ℝ :=
  let y := F ((fun _ ↦ x.1),(fun _ ↦ x.2))
  (y.1 0,y.2 0)

def symmetricHarmonicStep (scheme : Fin 4) (m Ω γ θ h : ℝ) (R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if scheme = 0 then aboba masses U γ θ h (fun _ ↦ R)
    else if scheme = 1 then obabo masses U γ θ h (fun _ ↦ R) (fun _ ↦ S)
    else if scheme = 2 then baoab masses U γ θ h (fun _ ↦ R)
    else oabao masses U γ θ h (fun _ ↦ R) (fun _ ↦ S))

def symmetricInvariant (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ symmetricHarmonicStep scheme m Ω γ θ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ

theorem table71 (scheme : Fin 4) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hinv : symmetricInvariant scheme m Ω γ θ h μ) :
    momentQ μ/(θ/Ω^2) = (if scheme = 1 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 3 then 1-h^2*Ω^2/(4*m) else 1) ∧
    momentP μ/(θ*m) = (if scheme = 0 then (1-h^2*Ω^2/(4*m))⁻¹
      else if scheme = 2 then 1-h^2*Ω^2/(4*m) else 1) ∧ momentQP μ = 0 := by
  sorry
```

## MD-7.4.1-NonsymmetricExactMoments
```json
{
  "source_id": "MD-7.4.1-NonsymmetricExactMoments",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.1",
  "printed_page": "277",
  "pdf_page": "298",
  "statement_latex": "For example, analysis shows that the schemes denoted $[AOAB]$ or $[BAOA]$ both exhibit a first order error in the covariance $\\langle qp\\rangle_h=O(h)$, however they give exact results for both $\\langle q^2\\rangle_h$ and $\\langle p^2\\rangle_h$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "AOAB和BAOA按字母总时间h定义；实际平稳概率、L²、稳定参数显式。",
    "本条仅覆盖两个精确方差；O(h)协方差及其随h统一常数未陈述，列入覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "两个非对称算法精确位置/动量二阶矩；协方差阶数暂缺。",
  "lean_decl": "MD.Ch07.nonsymmetricHarmonicStep",
  "lean_declarations": [
    "MD.Ch07.nonsymmetricHarmonicStep",
    "MD.Ch07.nonsymmetricExactMoments"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def nonsymmetricHarmonicStep (flip : Bool) (m Ω γ θ h R : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let masses : V 1 := fun _ ↦ m
  let U : V 1 → ℝ := fun q ↦ Ω^2*(q 0)^2/2
  scalarLift (if flip then kickStep U h ∘ driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2)
    else driftStep masses (h/2) ∘ ouStep masses γ θ h (fun _ ↦ R) ∘ driftStep masses (h/2) ∘ kickStep U h)

theorem nonsymmetricExactMoments (flip : Bool) (m Ω γ θ h : ℝ) (μ : Measure (ℝ × ℝ))
    (hm : 0 < m) (hΩ : Ω ≠ 0) (hγ : 0 < γ) (hθ : 0 < θ) (hh : 0 < h)
    (hstable : h^2*Ω^2 < 4*m) (hμ : IsProbabilityMeasure μ)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hinv : Measure.map (fun z ↦ nonsymmetricHarmonicStep flip m Ω γ θ h z.2 z.1)
      (μ.prod (gaussianReal 0 1)) = μ) :
    momentQ μ = θ/Ω^2 ∧ momentP μ = θ*m := by
  sorry
```

## MD-7.4.2-BBKStar
```json
{
  "source_id": "MD-7.4.2-BBKStar",
  "kind": "definition",
  "label": "Example 7.2",
  "section": "7.4.2",
  "printed_page": "277–278",
  "pdf_page": "298–299",
  "statement_latex": "Example 7.2 Consider the variant of the BBK integrator that recycles the random number between steps:\nBrünger-Brooks-Karplus with post-step re-use of random number (BBK*)\n\\[p_{n+1/2}=(1-h\\gamma/2)p_n-(h/2)\\nabla U(q_n)+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R_n,\\]\n\\[q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\qquad\np_{n+1}=[p_{n+1/2}-(h/2)\\nabla U(q_{n+1})+\\tfrac12\\sqrt{2k_BTh\\gamma}M^{1/2}R_{n+1}]/(1+h\\gamma/2),\\]\nwhere $R_n$ is a vector of normal random numbers with zero mean and unit variance.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "R序列需独立同分布标准正态；状态与当前R因上一步重用相关，不再假设独立。矩阵及κ常数由BBKLinearForm给出。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarTrajectory",
  "lean_declarations": [
    "MD.Ch07.bbkStarTrajectory",
    "MD.Ch07.bbkStarNoise"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def bbkStarTrajectory (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (x0 : Phase n) : ℕ → Phase n
  | 0 => x0
  | k+1 => bbk m U γ θ h (R k) (R (k+1)) (bbkStarTrajectory m U γ θ h R x0 k)

def bbkStarNoise (κ1 κ2 κ3 R S : ℝ) : ℝ × ℝ := (κ1*R,κ2*R+κ3*S)
```

## MD-7.4.2-BBKStarCorrelations
```json
{
  "source_id": "MD-7.4.2-BBKStarCorrelations",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.4.2",
  "printed_page": "278",
  "pdf_page": "299",
  "statement_latex": "Denoting the entries of $\\Psi^{\\rm BBK*}$ by $\\psi_{ij}$ we have\n\\[\\mathbb E(\\mu_{n,2}p_n)=\\mathbb E((\\kappa_2R_n+\\kappa_3R_{n+1})(\\psi_{21}q_{n-1}+\\psi_{22}p_{n-1}+\\kappa_2R_{n-1}+\\kappa_3R_n))=\\kappa_2\\kappa_3.\\]\nAdditionally it is easily shown that\n\\[\\mathbb E(\\mu_{n,1}q_n)=\\mathbb E(\\mu_{n,2}q_n)=0,\\quad \\mathbb E(\\mu_{n,1}p_n)=\\kappa_1\\kappa_3,\\]\nwith $\\mathbb E(\\mu_{n,1}^2)=\\kappa_1^2$, $\\mathbb E(\\mu_{n,1}\\mu_{n,2})=\\kappa_1\\kappa_2$, $\\mathbb E(\\mu_{n,2}^2)=\\kappa_2^2+\\kappa_3^2$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "Qold/Pold代表吸收R_{n-1}后仍独立于未来R_n,R_{n+1}的旧状态组合；不把当前p与R_n假设独立。",
    "所有分量L²和未来独立资格明示；此抽象局部模型覆盖所列七个相关矩。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.bbkStarCorrelations",
  "lean_declarations": [
    "MD.Ch07.bbkStarCorrelations"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem bbkStarCorrelations (P : Measure Ω) [IsProbabilityMeasure P]
    (R S Qold Pold : Ω → ℝ) (a b c d κ1 κ2 κ3 : ℝ)
    (hR : HasLaw R (gaussianReal 0 1) P) (hS : HasLaw S (gaussianReal 0 1) P)
    (hind : IndepFun (fun sample ↦ (Qold sample,Pold sample)) (fun sample ↦ (R sample,S sample)) P)
    (hRS : IndepFun R S P) (hq : MemLp Qold 2 P) (hp : MemLp Pold 2 P) :
    let q := fun sample ↦ a*Qold sample+b*Pold sample
    let p := fun sample ↦ c*Qold sample+d*Pold sample+κ3*R sample
    let u := fun sample ↦ κ1*R sample
    let v := fun sample ↦ κ2*R sample+κ3*S sample
    (∫ sample, v sample*p sample ∂P) = κ2*κ3 ∧
    (∫ sample, u sample*q sample ∂P) = 0 ∧
    (∫ sample, v sample*q sample ∂P) = 0 ∧
    (∫ sample, u sample*p sample ∂P) = κ1*κ3 ∧
    (∫ sample, (u sample)^2 ∂P) = κ1^2 ∧
    (∫ sample, u sample*v sample ∂P) = κ1*κ2 ∧
    (∫ sample, (v sample)^2 ∂P) = κ2^2+κ3^2 := by
  sorry
```
