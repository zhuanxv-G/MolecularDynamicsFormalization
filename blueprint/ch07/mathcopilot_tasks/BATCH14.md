# BATCH14 第7章原文与陈述审校

## MD-7.9.1-OYZYOInhomogeneity
```json
{
  "source_id": "MD-7.9.1-OYZYOInhomogeneity",
  "kind": "unnumbered_claim",
  "label": "(7.29)",
  "section": "7.9.1",
  "printed_page": "298–299",
  "pdf_page": "319–320",
  "statement_latex": "For methods $[OYZYO]$, substituting $\\mathcal L_X^\\dagger=\\mathcal L_O^\\dagger$, $\\mathcal L_Y^\\dagger+\\mathcal L_Z^\\dagger=\\mathcal L_A^\\dagger+\\mathcal L_B^\\dagger=\\mathcal L_H^\\dagger$ simplifies the computation to\n\\[\\mathcal L_{2,[OYZYO]}^\\dagger\\rho_\\beta=\\frac1{12}[\\mathcal L_Z^\\dagger,\\mathcal L_Z^\\dagger,\\mathcal L_Y^\\dagger]\\rho_\\beta-\\frac1{24}[\\mathcal L_Y^\\dagger,\\mathcal L_Y^\\dagger,\\mathcal L_Z^\\dagger]\\rho_\\beta.\\tag{7.29}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.oyzyoInhomogeneity",
  "lean_declarations": [
    "MD.Ch07.oyzyoInhomogeneity"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry
```

## MD-7.9.1-TripleCommutatorPrinted
```json
{
  "source_id": "MD-7.9.1-TripleCommutatorPrinted",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.1",
  "printed_page": "299",
  "pdf_page": "320",
  "statement_latex": "\\[[\\mathcal L_A^\\dagger,\\mathcal L_A^\\dagger,\\mathcal L_B^\\dagger]\\rho_\\beta=(2\\beta p^T(\\nabla^2U)\\nabla U-\\nabla^3U:p\\otimes p\\otimes p)\\rho_\\beta,\\]\n\\[[\\mathcal L_B^\\dagger,\\mathcal L_B^\\dagger,\\mathcal L_A^\\dagger]\\rho_\\beta=-(2\\beta p^T(\\nabla^2U)\\nabla U)\\rho_\\beta.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。"
  ],
  "issues": [
    "已目视核对PDF320／印刷299：首条三重交换子的三阶导数项未带β；后面的PDE却把β乘整个括号，且直接微分给出共同β。原文版与补β修正版独立保留。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.hessianU",
  "lean_declarations": [
    "MD.Ch07.hessianU",
    "MD.Ch07.thirdU",
    "MD.Ch07.hessianGrad",
    "MD.Ch07.cubicThird",
    "MD.Ch07.tripleCommutatorPrinted",
    "MD.Ch07.tripleCommutatorPrinted_corrected",
    "MD.Ch07.tripleCommutator_corrected",
    "MD.Ch07.tripleCommutator_factor_counterexample"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def hessianU (U : V n → ℝ) (q : V n) (i j : Fin n) : ℝ := coordDerivative (fun y ↦ gradient U y j) q i
def thirdU (U : V n → ℝ) (q : V n) (i j k : Fin n) : ℝ := coordDerivative (fun y ↦ hessianU U y j k) q i
def hessianGrad (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*gradient U x.1 j
def cubicThird (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, ∑ k, thirdU U x.1 i j k*x.2 i*x.2 j*x.2 k
def tripleCommutatorPrinted (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  (2*β*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
def tripleCommutatorPrinted_corrected (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*(2*hessianGrad U x-cubicThird U x)*gibbsWeight (fun _ ↦ 1) U β x
theorem tripleCommutator_corrected (U : V n → ℝ) (β : ℝ) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) :
    let m : V n := fun _ ↦ 1
    let ρ := gibbsWeight m U β
    phaseComm (aForward m) (phaseComm (aForward m) (bForward U)) ρ = tripleCommutatorPrinted_corrected U β ∧
    phaseComm (bForward U) (phaseComm (bForward U) (aForward m)) ρ =
      (fun x ↦ -2*β*hessianGrad U x*ρ x) := by
  sorry
theorem tripleCommutator_factor_counterexample : (2*(2 : ℝ)*0-1) ≠ 2*(2*0-1) := by norm_num
```

## MD-7.9.1-SymmetricRHS
```json
{
  "source_id": "MD-7.9.1-SymmetricRHS",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.1",
  "printed_page": "299",
  "pdf_page": "320",
  "statement_latex": "\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_{2,[OABAO]})=\\frac\\beta{24}(6p^T(\\nabla^2U)\\nabla U-\\nabla^3U:p\\otimes p\\otimes p)\\rho_\\beta,\\]\n\\[\\mathcal L_{LD}^\\dagger(\\rho_\\beta f_{2,[OBABO]})=\\frac\\beta{24}(2\\nabla^3U:p\\otimes p\\otimes p-6p^T(\\nabla^2U)\\nabla U)\\rho_\\beta.\\]\nWe can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $p$, and hence will average to 0.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.symmetricRHS",
  "lean_declarations": [
    "MD.Ch07.symmetricRHS",
    "MD.Ch07.symmetricRHS_odd",
    "MD.Ch07.symmetricRHS_zeroMean"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def symmetricRHS (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/24*(if flip then 2*cubicThird U x-6*hessianGrad U x else 6*hessianGrad U x-cubicThird U x)
theorem symmetricRHS_odd (flip : Bool) (U : V n → ℝ) (β : ℝ) (x : Phase n) :
    symmetricRHS flip U β (x.1,-x.2) = -symmetricRHS flip U β x := by
  have hG : hessianGrad U (x.1,-x.2) = -hessianGrad U x := by
    simp [hessianGrad,Finset.sum_neg_distrib]
  have hT : cubicThird U (x.1,-x.2) = -cubicThird U x := by
    simp [cubicThird,Finset.sum_neg_distrib]
  cases flip <;> simp [symmetricRHS,hG,hT] <;> ring
theorem symmetricRHS_zeroMean (flip : Bool) (U : V n → ℝ) (β : ℝ)
    (hint : Integrable (symmetricRHS flip U β) (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, symmetricRHS flip U β x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

## MD-7.9.1-Lemma71
```json
{
  "source_id": "MD-7.9.1-Lemma71",
  "kind": "lemma",
  "label": "Lemma 7.1",
  "section": "7.9.1",
  "printed_page": "299–300",
  "pdf_page": "320–321",
  "statement_latex": "Lemma 7.1 Consider two numerical schemes with associated operators governing the evolution of measure $ST$ and $TS$, with unique associated invariant distributions $\\widehat\\rho_{ST}$ and $\\widehat\\rho_{TS}$ respectively, such that\n\\[ST\\widehat\\rho_{ST}=\\widehat\\rho_{ST},\\qquad TS\\widehat\\rho_{TS}=\\widehat\\rho_{TS}.\\]\nUnder suitable ergodicity assumptions (such that in the long-time limit, all distributions converge to the invariant distribution), we have\n\\[\\widehat\\rho_{ST}=S\\widehat\\rho_{TS},\\qquad\\widehat\\rho_{TS}=T\\widehat\\rho_{ST}.\\]",
  "proof_latex": "If we assume that $\\lim_{n\\to\\infty}(ST)^n\\rho=\\widehat\\rho_{ST}$, for any initial distribution $\\rho$, then we have\n$\\widehat\\rho_{ST}=\\lim_{n\\to\\infty}(ST)^n\\widehat\\rho_{ST}=\\lim_{n\\to\\infty}S(TS)^{n-1}T\\widehat\\rho_{ST}=S\\widehat\\rho_{TS}$.\nA similar statement holds for $\\widehat\\rho_{ST}$.",
  "proof_note": "按所列原页转录原书证明。",
  "context_notation": [],
  "extra_assumptions": [
    "真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.lemma71",
  "lean_declarations": [
    "MD.Ch07.lemma71"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": [
    "MolecularDynamics.textbookUniqueInvariantProbability",
    "MolecularDynamics.textbookInvariantDistributionSwap"
  ]
}
```
```lean
theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS
```

## MD-7.9.1-ConjugateSymmetricCorrections
```json
{
  "source_id": "MD-7.9.1-ConjugateSymmetricCorrections",
  "kind": "unnumbered_claim",
  "label": "(7.30a)–(7.30b)",
  "section": "7.9.1",
  "printed_page": "300–301",
  "pdf_page": "321–322",
  "statement_latex": "\\[\\widehat\\rho_{[ZYOYZ]}=\\exp((h/2)\\mathcal L_Z^\\dagger)\\exp((h/2)\\mathcal L_Y^\\dagger)\\exp((h/2)\\mathcal L_O^\\dagger)\\widehat\\rho_{[OYZYO]}.\\]\n\\[f_{2,[ZYOYZ]}\\rho_\\beta=f_{2,[OYZYO]}\\rho_\\beta+\\tfrac14\\mathcal L_{1,[OYZ]}^\\dagger\\rho_\\beta.\\]\n\\[\\mathcal L_{1,[OAB]}^\\dagger\\rho_\\beta=\\tfrac12\\mathcal L_H^\\dagger(g\\rho_\\beta),\\qquad\n\\mathcal L_{1,[OBA]}^\\dagger\\rho_\\beta=-\\tfrac12\\mathcal L_H^\\dagger(g\\rho_\\beta),\\]\n\\[\\mathcal L_H^\\dagger(g\\rho_\\beta)=\\beta(|\\nabla U|^2-p^T\\nabla^2Up)\\rho_\\beta,\\]\n\\[f_{2,[ABOBA]}=f_{2,[OBABO]}-\\tfrac\\beta8(|\\nabla U|^2-p^T\\nabla^2Up),\\tag{7.30a}\\]\n\\[f_{2,[BAOAB]}=f_{2,[OABAO]}+\\tfrac\\beta8(|\\nabla U|^2-p^T\\nabla^2Up).\\tag{7.30b}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。"
  ],
  "issues": [
    "已目视核对PDF321：所印传播子展开末项为(h²/2)L_LD，按exp的二阶展开应为(h²/8)(L_LD)²；该项作用ρβ为零，不改变后续修正关系。"
  ],
  "statement_scope": "形式传递系数的消项及(7.30)全部目标；未证明从具体分裂映射导出这些系数。",
  "lean_decl": "MD.Ch07.gradNormSq",
  "lean_declarations": [
    "MD.Ch07.gradNormSq",
    "MD.Ch07.hessianQuadratic",
    "MD.Ch07.conjugateCorrectionChange",
    "MD.Ch07.conjugateCorrections",
    "MD.Ch07.conjugateCorrection_coefficient"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def gradNormSq (U : V n → ℝ) (q : V n) : ℝ := ∑ i, gradient U q i^2
def hessianQuadratic (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, ∑ j, x.2 i*hessianU U x.1 i j*x.2 j
def conjugateCorrectionChange (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β/8*(gradNormSq U x.1-hessianQuadratic U x)
def conjugateCorrections (U : V n → ℝ) (β : ℝ) (fABOBA fOBABO fBAOAB fOABAO : Phase n → ℝ) : Prop :=
  fABOBA = fOBABO-conjugateCorrectionChange U β ∧ fBAOAB = fOABAO+conjugateCorrectionChange U β
theorem conjugateCorrection_coefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (p : ℕ → E) (q2 : E)
    (hL : L0 (p 0) = 0) (hp : p 1 = 0)
    (htransfer : q2 = p 2+(1/2 : ℝ) • L0 (p 1)+
      (1/4 : ℝ) • L1 (p 0)+(1/8 : ℝ) • (L0*L0) (p 0)) :
    q2 = p 2+(1/4 : ℝ) • L1 (p 0) := by
  simpa [hp,hL,Module.End.mul_apply] using htransfer
```

## MD-7.9.2-ReciprocalFrictionExpansion
```json
{
  "source_id": "MD-7.9.2-ReciprocalFrictionExpansion",
  "kind": "definition",
  "label": "(7.31) / (7.32)",
  "section": "7.9.2",
  "printed_page": "301–302",
  "pdf_page": "322–323",
  "statement_latex": "We will denote\n\\[f_2(q,p)=f_{2,0}(q,p)+\\epsilon f_{2,1}(q,p)+\\epsilon^2f_{2,2}(q,p)+\\cdots,\\tag{7.31}\\]\nwith each $\\langle f_{2,i}\\rangle=0$. Dividing by the friction in (7.28) we obtain\n\\[(\\overline{\\mathcal L}_O^\\dagger+\\epsilon\\mathcal L_H^\\dagger)(f_2\\rho_\\beta)=-\\epsilon\\mathcal L_2^\\dagger\\rho_\\beta,\\]\nwhere $\\overline{\\mathcal L}_O^\\dagger\\vartheta=\\epsilon\\mathcal L_O^\\dagger\\vartheta=\\nabla_p\\cdot(p\\vartheta)+\\beta^{-1}\\Delta_p\\vartheta$.\n\\[w(q,p)=-\\tfrac\\beta{24}(6p^T(\\nabla^2U)\\nabla U-\\nabla^3U:p\\otimes p\\otimes p).\\]\nEquating powers gives\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,0})=0,\\quad\n\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,0})+\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,1})=-w\\rho_\\beta,\\]\n\\[\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,1})+\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,2})=0,\\quad\n\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,2})+\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,3})=0.\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.phaseH",
  "lean_declarations": [
    "MD.Ch07.phaseH",
    "MD.Ch07.reciprocalHierarchy"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0
```
