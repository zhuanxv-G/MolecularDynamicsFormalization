# BATCH04 第7章原文与陈述审校

## MD-7.3.1-Langevin
```json
{
  "source_id": "MD-7.3.1-Langevin",
  "kind": "definition",
  "label": "(7.4)",
  "section": "7.3.1",
  "printed_page": "268",
  "pdf_page": "289",
  "statement_latex": "Langevin dynamics:\n\\[dq=M^{-1}pdt,\\qquad dp=-\\nabla U(q)dt-\\gamma pdt+\\sqrt{2\\gamma k_BT}M^{1/2}dW.\\tag{7.4}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "用真实坐标偏导与完整位置/动量积分方程表达；常扩散的Itô项即W增量乘系数；显式状态适应W自然历史、漂移可积。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.gradient",
  "lean_declarations": [
    "MD.Ch07.gradient",
    "MD.Ch07.langevin"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def gradient (U : V n → ℝ) (q : V n) : V n := fun i ↦ coordDerivative U q i

def langevin (P : Measure Ω) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (U : V n → ℝ) (m : V n) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → ∀ i,
    IntervalIntegrable (fun s ↦ (X s sample).2 i / m i) volume 0 t ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i - γ*(X s sample).2 i) volume 0 t ∧
    (X t sample).1 i = x0.1 i + (∫ s in 0..t, (X s sample).2 i / m i) ∧
    (X t sample).2 i = x0.2 i + (∫ s in 0..t, -gradient U (X s sample).1 i - γ*(X s sample).2 i) +
      Real.sqrt (2*γ*θ*m i) * (W t sample i - W 0 sample i)
```

## MD-7.3.1-HamiltonianGibbs
```json
{
  "source_id": "MD-7.3.1-HamiltonianGibbs",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3.1",
  "printed_page": "269",
  "pdf_page": "290",
  "statement_latex": "Since Hamiltonian dynamics leaves invariant any function of the energy, its corresponding Fokker-Planck operator (in this case the Liouvillian, $\\mathcal L_H^\\dagger=-\\mathcal L_H$) will preserve distributions that are functions of the Hamiltonian $H$. This implies in particular that it preserves $\\rho_\\beta$, which is proportional to $\\exp(-\\beta H)$. Thus the forward propagator associated to the Hamiltonian system automatically preserves the Gibbs distribution, and we have\n\\[e^{t\\mathcal L_H^\\dagger}\\rho_\\beta=\\rho_\\beta.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "F为已存在的实际Hamiltonian流的固定时刻映射；显式体积保持与能量保持，结论为实际加权测度不变性。",
    "本文未重证明一般Hamiltonian流存在；若需归一化为概率，须另补配分积分正有限。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.hamiltonianGibbs",
  "lean_declarations": [
    "MD.Ch07.hamiltonianGibbs"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem hamiltonianGibbs {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (F : D → D) (H : D → ℝ) (β : ℝ)
    (hF : Measurable F) (hv : MeasurePreserving F ν ν)
    (hH : ∀ x, H (F x) = H x) (hweight : Measurable (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) :
    Measure.map F (ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) =
      ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x))) := by
  sorry
```

## MD-7.3.1-ABOPieces
```json
{
  "source_id": "MD-7.3.1-ABOPieces",
  "kind": "definition",
  "label": "(7.5)",
  "section": "7.3.1",
  "printed_page": "269–270",
  "pdf_page": "290–291",
  "statement_latex": "We therefore consider dividing the Langevin system (7.4) into parts\n\\[d\\binom qp=\\binom{M^{-1}p}{0}dt+\\binom0{-\\nabla U(q)}dt+\\binom0{-\\gamma pdt+\\sigma M^{1/2}dW},\\tag{7.5}\\]\nwhich we label A, B, and O, where each of the three parts may be solved “exactly”, with individual updates given as\n\\[\\mathcal U_h^A(q,p)=(q+hM^{-1}p,p),\\quad\n\\mathcal U_h^B(q,p)=(q,p-h\\nabla U(q)),\\quad\n\\mathcal U_h^O(q,p)=(q,e^{-\\gamma h}p+\\sqrt{k_BT(1-e^{-2\\gamma h})}M^{1/2}R),\\]\nwhere $R$ is a vector of i.i.d. normal random numbers.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "M为正对角质量；σ=√(2γk_BT)；OU单步及独立正态资格已在OUPhaseIteration写全。",
    "仅最后短定理证明漂移相加；A/B确定性精确流与O分布精确性各自另列，不用漂移恒等式替代。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.driftStep",
  "lean_declarations": [
    "MD.Ch07.driftStep",
    "MD.Ch07.kickStep",
    "MD.Ch07.aField",
    "MD.Ch07.bField",
    "MD.Ch07.oDrift",
    "MD.Ch07.splittingDrift"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def driftStep (m : V n) (h : ℝ) (x : Phase n) : Phase n :=
  (fun i ↦ x.1 i + h * x.2 i / m i, x.2)

def kickStep (U : V n → ℝ) (h : ℝ) (x : Phase n) : Phase n :=
  (x.1, fun i ↦ x.2 i - h * gradient U x.1 i)

def aField (m : V n) (x : Phase n) : Phase n := (fun i ↦ x.2 i / m i, 0)
def bField (U : V n → ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -gradient U x.1 i)
def oDrift (γ : ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -γ*x.2 i)

theorem splittingDrift (m : V n) (U : V n → ℝ) (γ : ℝ) (x : Phase n) :
    aField m x + bField U x + oDrift γ x =
      (fun i ↦ x.2 i / m i, fun i ↦ -gradient U x.1 i - γ*x.2 i) := by
  ext i <;> simp [aField, bField, oDrift] <;> ring
```

## MD-7.3.1-ABExactFlows
```json
{
  "source_id": "MD-7.3.1-ABExactFlows",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.3.1",
  "printed_page": "270",
  "pdf_page": "291",
  "statement_latex": "For the deterministic pieces A and B, the updates correspond to their flow maps, while the update for the O piece corresponds to the solution derived in (7.3).",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "逐坐标A位置/B动量真实时间导数；另一个分量由更新定义恒定；O精确性引用OUTransitionLaw未证陈述，不冒称全部已证。"
  ],
  "issues": [],
  "statement_scope": "A/B非恒定坐标的精确微分关系；O部分见MD-7.3-OUExactUpdate。",
  "lean_decl": "MD.Ch07.driftStep_derivative",
  "lean_declarations": [
    "MD.Ch07.driftStep_derivative",
    "MD.Ch07.kickStep_derivative"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem driftStep_derivative (m : V n) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (driftStep m s x).1 i) (x.2 i / m i) t := by
  simpa [driftStep, mul_div_assoc] using ((hasDerivAt_id t).mul_const (x.2 i / m i)).const_add (x.1 i)

theorem kickStep_derivative (U : V n → ℝ) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (kickStep U s x).2 i) (-gradient U x.1 i) t := by
  sorry
```

## MD-7.3.1-ABForward
```json
{
  "source_id": "MD-7.3.1-ABForward",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "270",
  "pdf_page": "291",
  "statement_latex": "The relevant forward propagators for each piece of the Hamiltonian part are computed through the adjoint of the Lie derivatives as\n\\[\\mathcal L_A^\\dagger=-M^{-1}p\\cdot\\nabla_q,\\qquad\n\\mathcal L_B^\\dagger=\\nabla U(q)\\cdot\\nabla_p.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "以真实偏导定义所印微分表达式；形式伴随解释要求足够光滑及边界通量消失，未声称一般强算子域。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aForward",
  "lean_declarations": [
    "MD.Ch07.aForward",
    "MD.Ch07.bForward"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aForward (m : V n) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  -∑ i, x.2 i / m i * coordDerivative (fun q ↦ f (q,x.2)) x.1 i
def bForward (U : V n → ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, gradient U x.1 i * coordDerivative (fun p ↦ f (x.1,p)) x.2 i
```

## MD-7.3.1-ABOBABO
```json
{
  "source_id": "MD-7.3.1-ABOBABO",
  "kind": "definition",
  "label": null,
  "section": "7.3.1",
  "printed_page": "270",
  "pdf_page": "291",
  "statement_latex": "For example, the method denoted $[ABO]$ (acting from left to right) has a resulting update\n\\[\\mathcal U_h^{[ABO]}=\\mathcal U_h^O\\circ\\mathcal U_h^B\\circ\\mathcal U_h^A.\\]\nAn alternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme denoted $[BABO]$ with associated map\n\\[\\mathcal U_h^{[BABO]}=\\mathcal U_h^O\\circ\\mathcal U_{h/2}^B\\circ\\mathcal U_h^A\\circ\\mathcal U_{h/2}^B.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "字母从左到右执行，函数复合从右到左；随机变量独立资格由vectorNormalSequence约束。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.abo",
  "lean_declarations": [
    "MD.Ch07.abo",
    "MD.Ch07.babo"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def abo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U h ∘ driftStep m h
def babo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2)
```
