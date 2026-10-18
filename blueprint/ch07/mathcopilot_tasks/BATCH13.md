# BATCH13 第7章原文与陈述审校

## MD-7.8.1-FirstCorrectionTablePrinted
```json
{
  "source_id": "MD-7.8.1-FirstCorrectionTablePrinted",
  "kind": "unnumbered_claim",
  "label": "(7.25a)–(7.25d)",
  "section": "7.8.1",
  "printed_page": "293–294",
  "pdf_page": "314–315",
  "statement_latex": "In summary, we find that\n\\[f_{1,[ABO]}(q,p)=f_{1,[OAB]}(q,p)=\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25a}\\]\n\\[f_{1,[OBA]}(q,p)=f_{1,[BAO]}(q,p)=-\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25b}\\]\n\\[f_{1,[AOB]}(q,p)=-\\frac\\beta2(\\gamma U(q)-p^TM^{-1}\\nabla U(q)-c),\\tag{7.25c}\\]\n\\[f_{1,[BOA]}(q,p)=\\frac\\beta2(\\gamma U(q)+p^TM^{-1}\\nabla U(q)-c),\\tag{7.25d}\\]\nwhere the constant $c$ is chosen to ensure each correction function has average 0, giving $c=\\gamma\\langle U(q)\\rangle$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "六个排列分别编码ABO,OAB,OBA,BAO,AOB,BOA；原文版不证明，修正版陈述实际PDE。c任意常数时PDE不变，零均值另行规定c=γ〈U〉。"
  ],
  "issues": [
    "已目视核对PDF315／印刷294：(7.25c)中动量梯度项印为负号，与同页上一段推导给出的正号及f_AOB=-f_BOA矛盾；修正为括号内正号。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.firstCorrectionTablePrinted",
  "lean_declarations": [
    "MD.Ch07.firstCorrectionTablePrinted",
    "MD.Ch07.firstCorrectionTablePrinted_corrected",
    "MD.Ch07.firstCorrection_sign_counterexample",
    "MD.Ch07.phaseComm",
    "MD.Ch07.firstCorrectionRHS",
    "MD.Ch07.firstCorrectionTable_pde"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def firstCorrectionTablePrinted (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  let v := ∑ i, x.2 i/m i*gradient U x.1 i
  if s = 0 ∨ s = 1 then β/2*(γ*U x.1-v-c)
  else if s = 2 ∨ s = 3 ∨ s = 4 then -β/2*(γ*U x.1-v-c)
  else β/2*(γ*U x.1+v-c)
def firstCorrectionTablePrinted_corrected (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ) (x : Phase n) : ℝ :=
  if s = 4 then -β/2*(γ*U x.1+(∑ i, x.2 i/m i*gradient U x.1 i)-c)
  else firstCorrectionTablePrinted s m U β γ c x
theorem firstCorrection_sign_counterexample :
    (-(1 : ℝ)/2*(1-1-0)) ≠ -(1 : ℝ)/2*(1+1-0) := by norm_num
def phaseComm (A B : (Phase n → ℝ) → Phase n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := A (B ρ)-B (A ρ)
def firstCorrectionRHS (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  let A := aForward m
  let B := bForward U
  let O := phaseO m γ β
  let ops := if s = 0 then (A,B,O) else if s = 1 then (O,A,B)
    else if s = 2 then (O,B,A) else if s = 3 then (B,A,O)
    else if s = 4 then (A,O,B) else (B,O,A)
  fun x ↦ (1/2)*(phaseComm ops.1 ops.2.1 ρ x+phaseComm ops.1 ops.2.2 ρ x+phaseComm ops.2.1 ops.2.2 ρ x)
theorem firstCorrectionTable_pde (s : Fin 6) (m : V n) (U : V n → ℝ) (β γ c : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    phaseLD m U γ β (fun x ↦ firstCorrectionTablePrinted_corrected s m U β γ c x*gibbsWeight m U β x) =
      firstCorrectionRHS s m U β γ (gibbsWeight m U β) := by
  sorry
```

## MD-7.8.1-PositionMomentumCorrections
```json
{
  "source_id": "MD-7.8.1-PositionMomentumCorrections",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.1",
  "printed_page": "294–295",
  "pdf_page": "315–316",
  "statement_latex": "If $\\vartheta=\\vartheta_1(p)$ then this $O(\\gamma)$ term will not trouble us, as\n\\[\\langle\\vartheta_1(p)f_1(q,p)\\rangle=\\pm\\frac\\beta2\\langle(\\gamma U(q)-c)\\vartheta_1(p)\\pm p^TM^{-1}\\nabla U(q)\\vartheta_1(p)\\rangle\n=\\pm\\frac\\beta2\\langle p^TM^{-1}\\nabla U(q)\\vartheta_1(p)\\rangle.\\]\nHowever, if we instead set $\\vartheta=\\vartheta_2(q)$, then\n\\[\\langle\\vartheta_2(q)f_1(q,p)\\rangle=\\pm\\frac{\\gamma\\beta}{2}\\langle(U(q)-\\langle U(q)\\rangle)\\vartheta_2(q)\\rangle.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "产品Gibbs实际含位置概率及独立中心Gaussian动量；所有显示期望需可积，未把待求修正值作为假设。",
    "六个算法分别给符号；大摩擦O(γ)的解释来自明确线性γ项，随γ,h的统一误差界未证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.positionGibbs",
  "lean_declarations": [
    "MD.Ch07.positionGibbs",
    "MD.Ch07.momentumGibbs",
    "MD.Ch07.productGibbs",
    "MD.Ch07.positionMomentumCorrections"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def positionGibbs (U : V n → ℝ) (β : ℝ) : Measure (V n) :=
  volume.withDensity (fun q ↦ ENNReal.ofReal (Real.exp (-β*U q)/(∫ y, Real.exp (-β*U y))))
def momentumGibbs (m : V n) (β : ℝ) : Measure (V n) := Measure.pi (fun i ↦ gaussianReal 0 (Real.toNNReal (m i/β)))
def productGibbs (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  (positionGibbs U β).prod (momentumGibbs m β)
theorem positionMomentumCorrections (m : V n) (U ψ χ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hU : Integrable U (positionGibbs U β))
    (hψ : Integrable ψ (positionGibbs U β)) (hχ : Integrable χ (momentumGibbs m β))
    (hgrad : ∀ i, Integrable (fun q ↦ gradient U q i) (positionGibbs U β))
    (hint : ∀ s : Fin 6,
      Integrable (fun x ↦ ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β) ∧
      Integrable (fun x ↦ χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x) (productGibbs m U β)) :
    ∀ s : Fin 6, let sign : ℝ := if s = 0 ∨ s = 1 ∨ s = 5 then 1 else -1
    let vsign : ℝ := if s = 0 ∨ s = 1 ∨ s = 4 then -1 else 1
    (∫ x, ψ x.1*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      sign*γ*β/2*∫ q, (U q-(∫ y, U y ∂positionGibbs U β))*ψ q ∂positionGibbs U β ∧
    (∫ x, χ x.2*firstCorrectionTablePrinted_corrected s m U β γ (γ*∫ q, U q ∂positionGibbs U β) x ∂productGibbs m U β) =
      vsign*β/2*∫ x, (∑ i, x.2 i/m i*gradient U x.1 i)*χ x.2 ∂productGibbs m U β := by
  sorry
```

## MD-7.8.1-OverdampedFirstOrderCaution
```json
{
  "source_id": "MD-7.8.1-OverdampedFirstOrderCaution",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.1",
  "printed_page": "295",
  "pdf_page": "316",
  "statement_latex": "When considering the limit of infinite friction in the $[XYZ]$ schemes we obtain an inconsistent discretization. Hence these first-order schemes will be unsuitable for the integration of overdamped Langevin dynamics.\nThis is not always the case for first order schemes, however. For example the scheme denoted $[AOAB]$ is consistent with the dynamics, and may be used for integrating the overdamped ($\\gamma=\\infty$) Langevin equation.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "覆盖AOAB全部更新与固定噪声/固定h下的摩擦极限；不把摩擦极限本身称作过阻尼一致性证明。六个XYZ不一致及AOAB有效时间重标度的一致性仍是明确覆盖缺口。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.aoab",
  "lean_declarations": [
    "MD.Ch07.aoab",
    "MD.Ch07.aoabInfiniteFriction",
    "MD.Ch07.aoabFrictionLimit"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def aoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2)
def aoabInfiniteFriction (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U h ∘ driftStep m (h/2) ∘ (fun x ↦ (x.1,fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i)) ∘ driftStep m (h/2)
theorem aoabFrictionLimit (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) (x : Phase n)
    (hh : 0 < h) (hθ : 0 < θ) (hU : ContDiff ℝ 1 U) :
    Filter.Tendsto (fun γ : ℝ ↦ aoab m U γ θ h R x) Filter.atTop (𝓝 (aoabInfiniteFriction m U θ h R x)) := by
  sorry
```

## MD-7.8.2-BiasedDoubleWellExact
```json
{
  "source_id": "MD-7.8.2-BiasedDoubleWellExact",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.8.2",
  "printed_page": "295–297",
  "pdf_page": "316–318",
  "statement_latex": "Let $M=\\beta=1$ and define the biased double-well potential as\n\\[U(q)=(q^2-1)^2+q/2.\\]\nWe choose the observable\n\\[\\vartheta(q,p)=p^2-qU'(q)+2qp,\\qquad\\langle\\vartheta\\rangle=0.\\]\nThe first order correction term for the $[BOA]$ scheme is given by the formula\n\\[\\langle\\vartheta f_{1,[BOA]}\\rangle=\\frac\\beta2\\int_{\\mathcal D}(p^2-qU'(q)+2qp)(pU'(q)+\\gamma U(q)-c)\\rho_\\beta d\\omega\n=\\frac1\\beta+\\frac\\gamma2\\langle U\\rangle-\\frac{\\gamma\\beta}{2}\\langle qUU'\\rangle=\\frac{2-\\gamma}{2\\beta}.\\]\nHence for the critical value of $\\gamma=2$, the leading order correction will be zero, giving\n\\[\\langle\\vartheta\\rangle_h^{[BOA]}=\\langle\\vartheta\\rangle+O(h^2).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "保留数值例中的精确数学积分和解析消项；原文虽起初β=1，推导中保留β，本条正β形式需同样积分分部理论。",
    "中间〈qUU′〉公式及γ=2实际误差O(h²)需先有严格弱展开，本条不声称已获该余项。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.biasedDoubleWell",
  "lean_declarations": [
    "MD.Ch07.biasedDoubleWell",
    "MD.Ch07.doubleWellObservable",
    "MD.Ch07.doubleWellGibbs",
    "MD.Ch07.doubleWellBOACorrection",
    "MD.Ch07.doubleWellExact",
    "MD.Ch07.doubleWellCritical"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def biasedDoubleWell (q : ℝ) : ℝ := (q^2-1)^2+q/2
def doubleWellObservable (x : ℝ × ℝ) : ℝ := x.2^2-x.1*deriv biasedDoubleWell x.1+2*x.1*x.2
def doubleWellGibbs (β : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-β*(x.2^2/2+biasedDoubleWell x.1))
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def doubleWellBOACorrection (β γ : ℝ) (x : ℝ × ℝ) : ℝ :=
  β/2*(x.2*deriv biasedDoubleWell x.1+γ*biasedDoubleWell x.1-
    γ*(∫ y, biasedDoubleWell y.1 ∂doubleWellGibbs β))
theorem doubleWellExact (β γ : ℝ) (hβ : 0 < β) :
    (∫ x, doubleWellObservable x ∂doubleWellGibbs β) = 0 ∧
    (∫ x, doubleWellObservable x*doubleWellBOACorrection β γ x ∂doubleWellGibbs β) = (2-γ)/(2*β) := by
  sorry
theorem doubleWellCritical (β : ℝ) : (2-(2 : ℝ))/(2*β) = 0 := by ring
```

## MD-7.9-Proposition71
```json
{
  "source_id": "MD-7.9-Proposition71",
  "kind": "proposition",
  "label": "Proposition 7.1 / (7.26)",
  "section": "7.9",
  "printed_page": "297",
  "pdf_page": "318",
  "statement_latex": "Proposition 7.1 Let $\\mathcal L_X^\\dagger$, $\\mathcal L_Y^\\dagger$ and $\\mathcal L_Z^\\dagger$ be general operators to which BCH can be applied, then defining\n\\[e^{h\\widehat{\\mathcal L}^\\dagger}=e^{\\frac h2\\mathcal L_X^\\dagger}e^{\\frac h2\\mathcal L_Y^\\dagger}e^{h\\mathcal L_Z^\\dagger}e^{\\frac h2\\mathcal L_Y^\\dagger}e^{\\frac h2\\mathcal L_X^\\dagger},\\tag{7.26}\\]\ngives $\\widehat{\\mathcal L}^\\dagger=\\mathcal L_0^\\dagger+h^2\\mathcal L_2^\\dagger+O(h^4)$, where\n\\[\\mathcal L_0^\\dagger=\\mathcal L_X^\\dagger+\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger,\\]\n\\[\\mathcal L_2^\\dagger=\\frac1{12}([\\mathcal L_Z^\\dagger,\\mathcal L_Z^\\dagger,\\mathcal L_Y^\\dagger]+[\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger,\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger,\\mathcal L_X^\\dagger])\n-\\frac1{24}([\\mathcal L_Y^\\dagger,\\mathcal L_Y^\\dagger,\\mathcal L_Z^\\dagger]+[\\mathcal L_X^\\dagger,\\mathcal L_X^\\dagger,\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger]).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.proposition71",
  "lean_declarations": [
    "MD.Ch07.proposition71",
    "MD.Ch07.symmetricOddCorrections"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": [
    "MolecularDynamics.textbookSymmetricOperatorCorrection",
    "MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71"
  ]
}
```
```lean
theorem proposition71 {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    ∃ Q : PowerSeries R, MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z =
      PowerSeries.C (X+Y+Z)+
      PowerSeries.C (MolecularDynamics.textbookSymmetricOperatorCorrection X Y Z)*PowerSeries.X^2+
      PowerSeries.X^4*Q := MolecularDynamics.textbookSymmetricModifiedGenerator_formal_proposition71 X Y Z
theorem symmetricOddCorrections {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) (k : ℕ) :
    PowerSeries.coeff (2*k+1) (MolecularDynamics.textbookSymmetricModifiedGenerator X Y Z) = 0 :=
  MolecularDynamics.textbookSymmetricModifiedGenerator_odd_coeff_zero X Y Z k
```

## MD-7.9-EvenDensityPerturbation
```json
{
  "source_id": "MD-7.9-EvenDensityPerturbation",
  "kind": "unnumbered_claim",
  "label": "(7.27)–(7.28)",
  "section": "7.9",
  "printed_page": "298",
  "pdf_page": "319",
  "statement_latex": "If we suppose that the odd order correction functions are zero, then we are left with\n\\[\\widehat\\rho=\\rho_\\beta(1+h^2f_2+h^4f_4+\\cdots),\\tag{7.27}\\]\nwhere each $\\langle f_i\\rangle=0$ as usual. Equating the second order terms we obtain\n\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_2)=-\\mathcal L_2^\\dagger\\rho_\\beta.\\tag{7.28}\\]\nThe condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $\\mathcal L_2^\\dagger\\rho_\\beta$ integrates to zero.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.evenDensityExpansion",
  "lean_declarations": [
    "MD.Ch07.evenDensityExpansion",
    "MD.Ch07.evenPerturbationEquation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def evenDensityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) (k : ℕ) : Ω → ℝ :=
  if k = 0 then ρ else if Even k then fun x ↦ ρ x*f k x else 0
theorem evenPerturbationEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (hL1 : L 1 = 0) (hρ1 : ρ 1 = 0) (h2 : actionCoefficient L ρ 2 = 0) :
    L 0 (ρ 2) = -L 2 (ρ 0) := by
  have he : L 0 (ρ 2)+L 2 (ρ 0) = 0 := by
    simpa [actionCoefficient,Finset.sum_range_succ,hL1,hρ1] using h2
  exact eq_neg_of_add_eq_zero_left he
```
