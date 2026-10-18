# BATCH15 第7章原文与陈述审校

## MD-7.9.2-OUKernelQualification
```json
{
  "source_id": "MD-7.9.2-OUKernelQualification",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.2",
  "printed_page": "302",
  "pdf_page": "323",
  "statement_latex": "The first equation at order one tells us that $f_{2,0,[OABAO]}(q,p)$ must be a function of position only, as the kernel of $\\overline{\\mathcal L}_O^\\dagger$ is the set of functions that are constant with respect to $p$. Hence we shall denote $f_{2,0,[OABAO]}(q,p)=\\nu(q)$, where $\\langle\\nu\\rangle=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。"
  ],
  "issues": [
    "已目视核对PDF323：前向OU生成元的核实际是Gaussian密度倍数；对ρβf共轭后，合适L²域中的f才对p为常数。原文此句缺少共轭与定义域限定。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.ouKernelPrinted",
  "lean_declarations": [
    "MD.Ch07.ouKernelPrinted",
    "MD.Ch07.ouKernelPrinted_corrected"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry
```

## MD-7.9.2-OUHermiteIdentities
```json
{
  "source_id": "MD-7.9.2-OUHermiteIdentities",
  "kind": "unnumbered_claim",
  "label": "(7.33)–(7.34)",
  "section": "7.9.2",
  "printed_page": "302",
  "pdf_page": "323",
  "statement_latex": "\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta\\nabla^3U:p\\otimes p\\otimes p)=-3\\rho_\\beta\\nabla^3U:p\\otimes p\\otimes p+\\tfrac{6\\rho_\\beta}{\\beta}p^T\\nabla_q\\Delta_qU,\\]\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta p^T\\nabla_q\\Delta_qU)=-\\rho_\\beta p^T\\nabla_q\\Delta_qU,\\]\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta p^T(\\nabla^2U)\\nabla U)=-\\rho_\\beta p^T(\\nabla^2U)\\nabla U.\\]\n\\[w\\rho_\\beta=\\tfrac\\beta{24}\\overline{\\mathcal L}_O^\\dagger([6p^T(\\nabla^2U)\\nabla U-\\tfrac13\\nabla^3U:p\\otimes p\\otimes p-\\tfrac2\\beta p^T\\nabla_q\\Delta_qU]\\rho_\\beta).\\tag{7.33}\\]\n\\[\\mathcal L_H^\\dagger(\\rho_\\beta\\nu)=-p^T\\nabla\\nu\\rho_\\beta=\\overline{\\mathcal L}_O^\\dagger([p^T\\nabla\\nu+\\mu(q)]\\rho_\\beta).\\tag{7.34}\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.laplacian",
  "lean_declarations": [
    "MD.Ch07.laplacian",
    "MD.Ch07.pGradLaplacian",
    "MD.Ch07.hermitePrimitive",
    "MD.Ch07.ouHermiteIdentities"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def laplacian (U : V n → ℝ) (q : V n) : ℝ := ∑ i, hessianU U q i i
def pGradLaplacian (U : V n → ℝ) (x : Phase n) : ℝ := ∑ i, x.2 i*gradient (laplacian U) x.1 i
def hermitePrimitive (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  6*hessianGrad U x-(1/3)*cubicThird U x-2/β*pGradLaplacian U x
theorem ouHermiteIdentities (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    let O := phaseO (fun _ ↦ 1) 1 β
    O (ρ*cubicThird U) = (fun x ↦ -3*ρ x*cubicThird U x+6*ρ x/β*pGradLaplacian U x) ∧
    O (ρ*pGradLaplacian U) = -(ρ*pGradLaplacian U) ∧
    O (ρ*hessianGrad U) = -(ρ*hessianGrad U) ∧
    (fun x ↦ -symmetricRHS false U β x*ρ x) = (fun x ↦ β/24*O (hermitePrimitive U β*ρ) x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry
```

## MD-7.9.2-FirstReciprocalCorrection
```json
{
  "source_id": "MD-7.9.2-FirstReciprocalCorrection",
  "kind": "unnumbered_claim",
  "label": "(7.35)–(7.36)",
  "section": "7.9.2",
  "printed_page": "303–304",
  "pdf_page": "324–325",
  "statement_latex": "\\[f_{2,1,[OABAO]}=-\\tfrac\\beta{24}(6p^T(\\nabla^2U)\\nabla U-\\tfrac13\\nabla^3U:p\\otimes p\\otimes p-\\tfrac2\\beta p^T\\nabla_q\\Delta_qU)-p^T\\nabla\\nu-\\mu.\\]\n\\[\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,2,[OABAO]})=-\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,1,[OABAO]}).\\tag{7.35}\\]\n\\[\\int_{\\mathcal P}\\overline{\\mathcal L}_O^\\dagger(\\rho_\\beta f_{2,2,[OABAO]})d\\omega_p=0,\\qquad\n\\int_{\\mathcal P}\\mathcal L_H^\\dagger(\\rho_\\beta f_{2,1,[OABAO]})d\\omega_p=\\overline\\pi\\mathcal L_H^\\dagger f_{2,1,[OABAO]}=0,\\tag{7.36}\\]\nwhere $(\\overline\\pi f)(q)=\\int_{\\mathcal P}f(q,p)\\rho_\\beta d\\omega_p$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。"
  ],
  "issues": [
    "已目视核对PDF324–325：π̄定义带联合ρβ权，后续M公式却使用归一条件动量平均并隐含ρβ共轭。本文区分原文加权积分与修正的条件Gaussian平均，避免遗漏位置密度因子。"
  ],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.firstReciprocalCorrection",
  "lean_declarations": [
    "MD.Ch07.firstReciprocalCorrection",
    "MD.Ch07.momentumAverage",
    "MD.Ch07.momentumAveragePrinted",
    "MD.Ch07.firstReciprocalCorrection_pde"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*gibbsWeight (fun _ ↦ 1) U β (q,p)
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry
```

## MD-7.9.2-OverdampedSolvabilityOperators
```json
{
  "source_id": "MD-7.9.2-OverdampedSolvabilityOperators",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.2",
  "printed_page": "304",
  "pdf_page": "325",
  "statement_latex": "We abbreviate\n\\[\\mathcal M\\psi(q)=\\overline\\pi\\mathcal L_H^\\dagger\\mathcal L_A^\\dagger\\psi(q)\n=\\overline\\pi((\\mathcal L_A^\\dagger)^2+\\mathcal L_B^\\dagger\\mathcal L_A^\\dagger)\\psi(q)\n=\\beta^{-1}\\Delta_q\\psi(q)-\\nabla U\\cdot\\nabla_q\\psi(q),\\]\n\\[\\mathcal N\\psi(q)=\\overline\\pi\\mathcal L_H^\\dagger(\\mathcal L_A^\\dagger)^3\\psi(q)\n=\\overline\\pi((\\mathcal L_A^\\dagger)^4+\\mathcal L_B^\\dagger(\\mathcal L_A^\\dagger)^3)\\psi(q)\n=\\tfrac3\\beta\\mathcal M(\\Delta_q\\psi(q)).\\]\nThus we have\n\\[\\overline\\pi\\mathcal L_H^\\dagger\\rho_\\beta f_{2,1,[OABAO]}=\\tfrac\\beta8\\mathcal M(|\\nabla U|^2-\\beta^{-1}\\Delta_qU)+\\mathcal M\\nu,\\]\nand hence by (7.36) we finally obtain $\\nu(q)=\\tfrac18(\\Delta_qU-\\beta|\\nabla U|^2)$, where $\\langle\\nu\\rangle=0$.",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。",
    "只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。"
  ],
  "issues": [],
  "statement_scope": "M,N及ν全部显式公式和ν代数识别；平均算符等价与可解性未证明。",
  "lean_decl": "MD.Ch07.overdampedM",
  "lean_declarations": [
    "MD.Ch07.overdampedM",
    "MD.Ch07.overdampedN",
    "MD.Ch07.highFrictionOABAO",
    "MD.Ch07.overdampedSolvability_choice"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def overdampedM (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  β⁻¹*laplacian ψ q-(∑ i, gradient U q i*gradient ψ q i)
def overdampedN (U ψ : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  3/β*overdampedM U (laplacian ψ) β q
def highFrictionOABAO (U : V n → ℝ) (β : ℝ) (q : V n) : ℝ :=
  (laplacian U q-β*gradNormSq U q)/8
theorem overdampedSolvability_choice (U : V n → ℝ) (β : ℝ) (hβ : β ≠ 0) :
    ∀ q, highFrictionOABAO U β q =
      -β/8*(gradNormSq U q-β⁻¹*laplacian U q) := by
  intro q
  dsimp [highFrictionOABAO]
  field_simp
  <;> ring
```

## MD-7.9.2-HighFrictionCorrectionTable
```json
{
  "source_id": "MD-7.9.2-HighFrictionCorrectionTable",
  "kind": "unnumbered_claim",
  "label": null,
  "section": "7.9.2",
  "printed_page": "304–305",
  "pdf_page": "325–326",
  "statement_latex": "\\[f_{2,0,[OABAO]}=\\tfrac18(\\Delta_qU-\\beta|\\nabla U|^2),\\]\n\\[f_{2,0,[OBABO]}=\\tfrac18(\\beta|\\nabla U|^2-2\\Delta_qU+c),\\]\nwhere $c=\\langle\\Delta U\\rangle$ is a constant chosen to ensure zero average.\n\\[f_{2,0,[ABOBA]}=\\tfrac18(\\beta p^T\\nabla^2U(q)p-2\\Delta_qU+c),\\]\n\\[f_{2,0,[BAOAB]}=\\tfrac18(\\Delta U-\\beta p^T\\nabla^2U(q)p).\\]\n\\[\\langle\\vartheta\\rangle_h=\\langle\\vartheta\\rangle+h^2\\langle\\vartheta f_{2,0}\\rangle+O(\\epsilon h^2+h^4).\\]",
  "proof_latex": null,
  "proof_note": "原书未给独立完整证明。",
  "context_notation": [],
  "extra_assumptions": [
    "算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。",
    "候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.highFrictionCorrection",
  "lean_declarations": [
    "MD.Ch07.highFrictionCorrection",
    "MD.Ch07.doublyAsymptoticAverage",
    "MD.Ch07.highFrictionCorrection_conjugacy"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
def highFrictionCorrection (s : Fin 4) (U : V n → ℝ) (β c : ℝ) (x : Phase n) : ℝ :=
  if s = 0 then highFrictionOABAO U β x.1
  else if s = 1 then (β*gradNormSq U x.1-2*laplacian U x.1+c)/8
  else if s = 2 then (β*hessianQuadratic U x-2*laplacian U x.1+c)/8
  else (laplacian U x.1-β*hessianQuadratic U x)/8
def doublyAsymptoticAverage (A : ℝ → ℝ → ℝ) (exact correction : ℝ) : Prop :=
  Asymptotics.IsBigO positivePairLimit
    (fun z ↦ A z.1 z.2-exact-z.2^2*correction) (fun z ↦ z.1*z.2^2+z.2^4)
theorem highFrictionCorrection_conjugacy (U : V n → ℝ) (β c : ℝ) :
    conjugateCorrections U β (highFrictionCorrection 2 U β c) (highFrictionCorrection 1 U β c)
      (highFrictionCorrection 3 U β c) (highFrictionCorrection 0 U β c) := by
  constructor <;> funext x <;>
    norm_num [conjugateCorrections,highFrictionCorrection,highFrictionOABAO,conjugateCorrectionChange]
    <;> ring
```

## MD-7.9.3-BAOABMarginalCancellation
```json
{
  "source_id": "MD-7.9.3-BAOABMarginalCancellation",
  "kind": "unnumbered_claim",
  "label": "(7.37)",
  "section": "7.9.3",
  "printed_page": "305",
  "pdf_page": "326",
  "statement_latex": "\\[\\langle\\vartheta\\rangle=\\langle\\vartheta\\rangle_h-h^2\\langle\\vartheta f_{2,0}\\rangle+O(h^2/\\gamma+h^4).\\tag{7.37}\\]\nThe $[BAOAB]$ scheme has leading order correction\n\\[f_{2,0,[BAOAB]}(q,p)=\\tfrac18(\\Delta U-\\beta p^T\\nabla^2U(q)p),\\]\nwhich has the interesting property that its marginal average with respect to momentum is zero:\n\\[\\overline\\pi f_{2,0,[BAOAB]}=\\int_{\\mathcal P}f_{2,0,[BAOAB]}(q,p)\\rho_\\beta(q,p)d\\omega_p=0.\\]\n\\[\\langle\\vartheta(q)f_{2,0,[BAOAB]}\\rangle=\\int_{\\mathcal Q}\\vartheta(q)\\int_{\\mathcal P}f_{2,0,[BAOAB]}\\rho_\\beta d\\omega_p d\\omega_q=0.\\]",
  "proof_latex": "Integrate first over the Gaussian momenta; the quadratic Gaussian moment contracts the Hessian to β⁻¹ΔU. Then use Fubini.",
  "proof_note": "按所列原页转录原书证明。",
  "context_notation": [],
  "extra_assumptions": [
    "归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。"
  ],
  "issues": [],
  "statement_scope": "本条逐字引用的全部数学对象与公式；未纳入的上下文另列。",
  "lean_decl": "MD.Ch07.baoabMarginalCancellation",
  "lean_declarations": [
    "MD.Ch07.baoabMarginalCancellation",
    "MD.Ch07.baoabConfigurationalCancellation"
  ],
  "source_page_verification": "见source_page_checks.json；必须已目视核对本条原页。",
  "repair_log": [],
  "documented_priors": []
}
```
```lean
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```
