[上一部分](part05.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

## MD-7.9.1-TripleCommutatorPrinted

印刷页 299 / PDF页 320。

### 1. 原文陈述


$$
[\mathcal L_A^\dagger,\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=(2\beta p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,
$$



$$
[\mathcal L_B^\dagger,\mathcal L_B^\dagger,\mathcal L_A^\dagger]\rho_\beta=-(2\beta p^T(\nabla^2U)\nabla U)\rho_\beta.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- M=I；Hessian、三阶张量及张量缩并均为实际坐标导数；原文版仅定义，不证明。反例先给系数代数区别，完整势函数测度反例未构造。
- 29号覆盖限定：字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C分项：hessianU、thirdU、hessianGrad、cubicThird的对象、域与求和指标正确；tripleCommutatorPrinted作为字面表达式PASS；_corrected以及其实际双重phaseComm定理在β>0、光滑U、单位质量下PASS。factor\_counterexample的代数断言PASS但并未声称构造势函数。原书首式缺β是真正的数学疑误，按任务要求保留原文并汇总NEEDS\_HUMAN；不能因修正版正确就把字面原书公式判为数学定理通过。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：字面式忠实保留缺β；单位质量修正版和实际双交换子恒等式独立，数值系数反例只是代数反例，网站给四次势的数学反例另记。

### 7. 状态与证明位置

- `MD.Ch07.hessianU`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.thirdU`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hessianGrad`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.cubicThird`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutatorPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutatorPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutator_corrected`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.tripleCommutator_factor_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-SymmetricRHS

印刷页 299 / PDF页 320。

### 1. 原文陈述


$$
\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OABAO]})=\frac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p)\rho_\beta,
$$



$$
\mathcal L_{LD}^\dagger(\rho_\beta f_{2,[OBABO]})=\frac\beta{24}(2\nabla^3U:p\otimes p\otimes p-6p^T(\nabla^2U)\nabla U)\rho_\beta.
$$


> We can see immediately that the Fredholm alternative holds in both cases, as both equations have right-hand sides that are of odd order in $`p`$, and hence will average to 0.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 右端去掉共同正Gibbs权，改用真实乘积Gibbs测度积分；奇性与零均值不等于完整Fredholm充分可解性。PDE左端与L2识别另需三重交换子桥。
- 29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。
- 覆盖缺口：29号覆盖限定：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C分项：symmetricRHS的两种标量多项式PASS；odd对所有flip,U,β,x成立，PASS；zeroMean带可积性时PASS。完整原文覆盖FAIL：未将多项式乘Gibbs权识别为−L2ρ或LD(ρf2)，也未建立真实原页积分和productGibbs积分的正有限归一化桥。奇性与零均值不构成给定闭算符的Fredholm替代定理。A中的原书充分性措辞另外判NEEDS\_HUMAN，保留而不篡改。
网站复审结论：NEEDS\_HUMAN。V n=Fin n→ℝ、Phase n=V n×V n；Hessian/三阶张量按附录D3–D11真实坐标导数定义。flip=false对应OABAO、true对应OBABO；β/24及张量收缩正确。odd声明对全部U、β和x成立，代数奇性无需正则性。zeroMean只加实际productGibbs的可积性，Gaussian动量反射不变足够；即使β≤0发生退化也仍对称，故无须据此判缺β>0。没有断言其为归一概率或完整PDE/Fredholm充分可解性；原书的后者存在函数空间资格疑点。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：所列函数、奇性及零积分签名PASS；零均值只是必要兼容条件，函数空间、算子域与核/余核资格仍待确认。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：单位质量下flip=true为OBABO、false为OABAO的多项式、奇性及给定可积性下零积分；PDE右端识别、概率归一和Fredholm充分性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.symmetricRHS`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricRHS_odd`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricRHS_zeroMean`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-Lemma71

印刷页 299–300 / PDF页 320–321。

### 1. 原文陈述

> Lemma 7.1 Consider two numerical schemes with associated operators governing the evolution of measure $`ST`$ and $`TS`$, with unique associated invariant distributions $`\widehat\rho_{ST}`$ and $`\widehat\rho_{TS}`$ respectively, such that

$$
ST\widehat\rho_{ST}=\widehat\rho_{ST},\qquad TS\widehat\rho_{TS}=\widehat\rho_{TS}.
$$


> Under suitable ergodicity assumptions (such that in the long-time limit, all distributions converge to the invariant distribution), we have

$$
\widehat\rho_{ST}=S\widehat\rho_{TS},\qquad\widehat\rho_{TS}=T\widehat\rho_{ST}.
$$



### 2. 原文证明

> If we assume that $`\lim_{n\to\infty}(ST)^n\rho=\widehat\rho_{ST}`$, for any initial distribution $`\rho`$, then we have
> $`\widehat\rho_{ST}=\lim_{n\to\infty}(ST)^n\widehat\rho_{ST}=\lim_{n\to\infty}S(TS)^{n-1}T\widehat\rho_{ST}=S\widehat\rho_{TS}`$.
> A similar statement holds for $`\widehat\rho_{ST}`$.

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem lemma71 (S T : Kernel Ω Ω) [IsMarkovKernel S] [IsMarkovKernel T]
    (ρST ρTS : Measure Ω)
    (hST : MolecularDynamics.textbookUniqueInvariantProbability (S ∘ₖ T) ρST)
    (hTS : MolecularDynamics.textbookUniqueInvariantProbability (T ∘ₖ S) ρTS) :
    ρST = S ∘ₘ ρTS ∧ ρTS = T ∘ₘ ρST :=
  MolecularDynamics.textbookInvariantDistributionSwap S T hST hTS
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 lemma71 所列对象、量词、前提和结论。范围说明：C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 真实Markov核、真实概率与不变概率的唯一性完整；借助不变性和唯一性即足够，不要求额外极限交换。保留原书证明文本，Lean采用已证更弱假设路线。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 lemma71 所列对象、量词、前提和结论。范围说明：C：在任意可测空间Ω上，S,T为Markov核，ρST,ρTS为真实测度，hST/hTS给出两种复合核唯一不变概率。由SρTS是ST不变概率及唯一性得第一式，第二式同理，故无需额外遍历极限或连续性，采用更弱充分假设合理。结论恰为ρST=SρTS与ρTS=TρST，全部PASS。证明原文末句的重复ST下标另留人工处理；不把该印刷文字问题误判为Lean签名失败。

### 7. 状态与证明位置

- `MD.Ch07.lemma71`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-ConjugateSymmetricCorrections

印刷页 300–301 / PDF页 321–322。

### 1. 原文陈述


$$
\widehat\rho_{[ZYOYZ]}=\exp((h/2)\mathcal L_Z^\dagger)\exp((h/2)\mathcal L_Y^\dagger)\exp((h/2)\mathcal L_O^\dagger)\widehat\rho_{[OYZYO]}.
$$



$$
f_{2,[ZYOYZ]}\rho_\beta=f_{2,[OYZYO]}\rho_\beta+\tfrac14\mathcal L_{1,[OYZ]}^\dagger\rho_\beta.
$$



$$
\mathcal L_{1,[OAB]}^\dagger\rho_\beta=\tfrac12\mathcal L_H^\dagger(g\rho_\beta),\qquad \mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\tfrac12\mathcal L_H^\dagger(g\rho_\beta),
$$



$$
\mathcal L_H^\dagger(g\rho_\beta)=\beta(|\nabla U|^2-p^T\nabla^2Up)\rho_\beta,
$$



$$
f_{2,[ABOBA]}=f_{2,[OBABO]}-\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up),\tag{7.30a}
$$



$$
f_{2,[BAOAB]}=f_{2,[OABAO]}+\tfrac\beta8(|\nabla U|^2-p^T\nabla^2Up).\tag{7.30b}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

def conjugateExpansionPrinted {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/2) • L0

def conjugateExpansionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L0 L1 : Module.End ℝ E) (h : ℝ) : Module.End ℝ E :=
  1+(h/2) • L0+(h^2/4) • L1+(h^2/8) • (L0*L0)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。
- 29号覆盖限定：两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。
- 覆盖缺口：Lean证明给定真实二阶传递系数的消项，(7.30)完整作为两关系的命题定义；ST/TS指数系数识别、Hamiltonian微分及实际两组修正系数识别仍列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：V n=Fin n→ℝ，Phase n为位置/动量对；梯度、Hessian及pᵀHess(U)p的下标收缩正确，conjugateCorrections完整记录两条函数等式。coefficient对任意实模E及线性自同态L0,L1量化，在L0(p0)=0、p1=0和明确的二阶传递假设下消项正确。[EXTRA]这些是假设的系数，不是具体分裂传播子的系数识别；ρβ、具体ST/TS不变分布传递及Hamiltonian微分恒等式没有相应完整声明。Printed逐字保留原印，忠实性PASS；_corrected的1/8及平方修正合理，作为二阶截断定义PASS，不能当作完整指数等式。因原印疑误本条综合NEEDS\_HUMAN。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：两条候选修正函数关系、给定二阶传递系数后的代数消项、原印展开及二阶截断修正版；不含真实分裂不变分布传递、L1ρ或实际误差系数识别。

### 7. 状态与证明位置

- `MD.Ch07.gradNormSq`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hessianQuadratic`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateCorrectionChange`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateCorrections`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateCorrection_coefficient`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateExpansionPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.conjugateExpansionPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-ReciprocalFrictionExpansion

印刷页 301–302 / PDF页 322–323。

### 1. 原文陈述

> We will denote

$$
f_2(q,p)=f_{2,0}(q,p)+\epsilon f_{2,1}(q,p)+\epsilon^2f_{2,2}(q,p)+\cdots,\tag{7.31}
$$


> with each $`\langle f_{2,i}\rangle=0`$. Dividing by the friction in (7.28) we obtain

$$
(\overline{\mathcal L}_O^\dagger+\epsilon\mathcal L_H^\dagger)(f_2\rho_\beta)=-\epsilon\mathcal L_2^\dagger\rho_\beta,
$$


> where $`\overline{\mathcal L}_O^\dagger\vartheta=\epsilon\mathcal L_O^\dagger\vartheta=\nabla_p\cdot(p\vartheta)+\beta^{-1}\Delta_p\vartheta`$.

$$
w(q,p)=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\nabla^3U:p\otimes p\otimes p).
$$


> Equating powers gives

$$
\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,0})=0,\quad \mathcal L_H^\dagger(\rho_\beta f_{2,0})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,1})=-w\rho_\beta,\tag{7.32}
$$



$$
\mathcal L_H^\dagger(\rho_\beta f_{2,1})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2})=0,\quad \mathcal L_H^\dagger(\rho_\beta f_{2,2})+\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,3})=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def phaseH (U : V n → ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ := aForward (fun _ ↦ 1) ρ+bForward U ρ
def reciprocalHierarchy (U : V n → ℝ) (β : ℝ) (f : ℕ → Phase n → ℝ) : Prop :=
  let ρ := gibbsWeight (fun _ ↦ 1) U β
  phaseO (fun _ ↦ 1) 1 β (ρ*f 0) = 0 ∧
  phaseH U (ρ*f 0)+phaseO (fun _ ↦ 1) 1 β (ρ*f 1) = (fun x ↦ -(-symmetricRHS false U β x)*ρ x) ∧
  ∀ k, 0 < k → phaseH U (ρ*f k)+phaseO (fun _ ↦ 1) 1 β (ρ*f (k+1)) = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- ε=1/γ；使用真实偏导、单位质量、β>0；形式层级包含所有后续阶。各阶零均值及归一性需另加centeredCorrections，不把其当作已证。
- 29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。
- 覆盖缺口：29号覆盖限定：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：phaseH采用单位质量，aForward为−p·∇q，bForward为∇U·∇p；phaseO以γ=1、θ=β⁻¹给出缩放OU。symmetricRHS false=β(6pH∇U−U‴:p³)/24=−w，故双负号右端确实为−wρβ；k>0覆盖所有后续阶。FAIL在完整性：reciprocalHierarchy只定义层级，没有(7.31)级数/形式系数对象、ε=1/γ缩放方程或每阶Gibbs零均值。extra\_assumptions提及centeredCorrections，但该定义既未提供也未并入本条命题；β>0也未进入此签名。对任意实β的裸形式表达式可以定义，但不能声称已含物理域资格。
网站复审结论：PASS。phaseH=aForward(单位质量)+bForward，符号为−p·∇q+∇U·∇p；phaseO单位摩擦、β⁻¹温度正好是Ō†。ρ为未归一Gibbs，方程齐次于该常数。二阶层级右端−(−symmetricRHS)ρ=+symmetricRHSρ=−wρ，双负号正确。后续∀k>0包含k=1,2及全部更高阶；f₀、f₁位置正确。此处只有Prop定义，不证明存在解、级数收敛、ε=1/γ桥或各阶中心化；任意β的总化与物理β>0已区分。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：仅未中心化形式层级的定义；任意β的总化表达式不表示物理Gaussian资格。(7.31)级数、ε=1/γ方程、逐阶可积零均值未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.phaseH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.reciprocalHierarchy`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-OUKernelQualification

印刷页 302 / PDF页 323。

### 1. 原文陈述

> The first equation at order one tells us that $`f_{2,0,[OABAO]}(q,p)`$ must be a function of position only, as the kernel of $`\overline{\mathcal L}_O^\dagger`$ is the set of functions that are constant with respect to $`p`$. Hence we shall denote $`f_{2,0,[OABAO]}(q,p)=\nu(q)`$, where $`\langle\nu\rangle=0`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def ouKernelPrinted (β : ℝ) : Prop :=
  ∀ f : V n → ℝ, ouForward (fun _ ↦ 1) 1 β⁻¹ f = 0 → ∃ c : ℝ, f = fun _ ↦ c
theorem ouKernelPrinted_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0) :
    ∃ ν : V n → ℝ, ∀ q p, f (q,p) = ν q := by
  sorry

theorem ouKernelCentered_corrected (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ)
    (hβ : 0 < β) (hf : ContDiff ℝ ⊤ f)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hi : Integrable f (productGibbs (fun _ ↦ 1) U β))
    (hL2 : ∀ q, MemLp (fun p ↦ f (q,p)) 2 (momentumGibbs (fun _ ↦ 1) β))
    (hzero : phaseO (fun _ ↦ 1) 1 β (gibbsWeight (fun _ ↦ 1) U β*f) = 0)
    (hmean : ∫ x, f x ∂productGibbs (fun _ ↦ 1) U β = 0) :
    ∃ ν : V n → ℝ, (∀ q p, f (q,p)=ν q) ∧
      Integrable ν (positionGibbs U β) ∧ (∫ q, ν q ∂positionGibbs U β)=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 修正版明确实际Gaussian L²域和光滑性；原文目标定义保留但不证明。零均值仅限制ν常数方向，不由OU核自动给出。
- 29号覆盖限定：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：ouKernelPrinted对任意V n→ℝ函数量化，原印核的错误忠实保留，literal忠实性PASS。_corrected作用于ρβf，要求β>0、f全局光滑、每个q的f(q,·)属于动量Gaussian L²，结论对所有q,p给出f(q,p)=ν(q)，该共轭后核陈述正确；Gaussian L²是必要的域限定而非原印已有前提，应标[EXTRA]。结论不含⟨ν⟩=0，原页中心化须另行加上，不能由核自动推出。sorry不影响本次判断。
网站复审结论：NEEDS\_HUMAN。ouKernelPrinted逐字面保留裸前向OU核断言，作为Prop而非定理，不因原印错误判转写FAIL。corrected假设β>0、f全相空间C∞、每个q切片在非退化Gaussian L²中，且Ō†(ρf)=0；Gibbs共轭得到β⁻¹Δpf−p·∇pf=0，L²核为常数，光滑性使结论从几乎处处提升为∀q,p。U无需对q光滑，因为本式只对p微分。centered版额外给位置概率、全空间可积与零均值，结论含ν可积及其零均值，未从核条件凭空推出中心化。两修正版陈述合理，原印疑误需人工确认。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：密度共轭与Gaussian L²域的两个修正版签名PASS；裸前向OU核原印疑误待导师。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：原印裸前向OU核为常数的错误命题保留；修正版为Gibbs共轭及动量Gaussian L²中的核刻画，中心化推论另加概率及零均值。

### 7. 状态与证明位置

- `MD.Ch07.ouKernelPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.ouKernelPrinted_corrected`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.ouKernelCentered_corrected`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-OUHermiteIdentities

印刷页 302 / PDF页 323。

### 1. 原文陈述


$$
\overline{\mathcal L}_O^\dagger(\rho_\beta\nabla^3U:p\otimes p\otimes p)=-3\rho_\beta\nabla^3U:p\otimes p\otimes p+\tfrac{6\rho_\beta}{\beta}p^T\nabla_q\Delta_qU,
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta p^T\nabla_q\Delta_qU)=-\rho_\beta p^T\nabla_q\Delta_qU,
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta p^T(\nabla^2U)\nabla U)=-\rho_\beta p^T(\nabla^2U)\nabla U.
$$



$$
w\rho_\beta=\tfrac\beta{24}\overline{\mathcal L}_O^\dagger([6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU]\rho_\beta).\tag{7.33}
$$



$$
\mathcal L_H^\dagger(\rho_\beta\nu)=-p^T\nabla\nu\rho_\beta=\overline{\mathcal L}_O^\dagger([p^T\nabla\nu+\mu(q)]\rho_\beta).\tag{7.34}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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
      (fun x ↦ -(∑ i, x.2 i*gradient ν x.1 i)*ρ x) ∧
    phaseH U (fun x ↦ ρ x*ν x.1) =
      O (fun x ↦ ((∑ i, x.2 i*gradient ν x.1 i)+μ x.1)*ρ x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- OU仅对p微分，μ(q)不需对p额外正则；U,ν光滑且β>0。全部三个Hermite式和两个合成恒等式都在Lean结论中。
- 29号覆盖限定：所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：β>0、U和ν全局光滑足以使三阶张量对称并合法交换所需偏导；μ只依赖q，OU不对q微分，故不要求μ光滑合理。三个Hermite等式及wρβ的符号正确，最后phaseH(ρν)=O((p·∇ν+μ)ρ)也正确。但完整(7.34)中的中间结论phaseH(ρν)=−p·∇νρ未出现在合取中；现有两端等式不能作为已列出该独立等式。此为完整结论缺项，不是sorry或数学错误。光滑性和β>0是合理[EXTRA]资格。
网站复审结论：PASS。ouHermiteIdentities全称U,ν,μ及β，β>0，U、ν C∞，无须μ光滑因为仅在p方向被微分。完整六个合取依次为三阶Hermite式、p·∇ΔU式、pᵀH∇U式、w的OU原函数、H(ρν)=−p·∇νρ和其OU表示。ρ用单位质量Gibbs，O用单位摩擦，正确。共轭OU作用于三次多项式为−3T+(6/β)p·∇ΔU，故primitive中−1/3及−2/β恰消额外线性项，得到−symmetricRHSρ。未以sorry为失败理由；本项仅是微分恒等式，不宣称唯一解。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：所列OU/Hermite微分恒等式，显式补H(ρν)=−p·∇νρ的中间式；无核唯一性或Fredholm可解性。

### 7. 状态与证明位置

- `MD.Ch07.laplacian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.pGradLaplacian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.hermitePrimitive`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.ouHermiteIdentities`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-FirstReciprocalCorrection

印刷页 303–304 / PDF页 324–325。

### 1. 原文陈述


$$
f_{2,1,[OABAO]}=-\tfrac\beta{24}(6p^T(\nabla^2U)\nabla U-\tfrac13\nabla^3U:p\otimes p\otimes p-\tfrac2\beta p^T\nabla_q\Delta_qU)-p^T\nabla\nu-\mu.
$$



$$
\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})=-\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]}).\tag{7.35}
$$



$$
\int_{\mathcal P}\overline{\mathcal L}_O^\dagger(\rho_\beta f_{2,2,[OABAO]})d\omega_p=0,\qquad \int_{\mathcal P}\mathcal L_H^\dagger(\rho_\beta f_{2,1,[OABAO]})d\omega_p=\overline\pi\mathcal L_H^\dagger f_{2,1,[OABAO]}=0,\tag{7.36}
$$


> where $`(\overline\pi f)(q)=\int_{\mathcal P}f(q,p)\rho_\beta d\omega_p`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def firstReciprocalCorrection (U ν μ : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  -β/24*hermitePrimitive U β x-(∑ i, x.2 i*gradient ν x.1 i)-μ x.1
def momentumAverage (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p) ∂momentumGibbs (fun _ ↦ 1) β
def momentumAveragePrinted_corrected (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  momentumAverage β f q

def momentumAveragePrinted (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (q : V n) : ℝ :=
  ∫ p, f (q,p)*(gibbsWeight (fun _ ↦ 1) U β (q,p)/
    (∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x))
theorem firstReciprocalCorrection_pde (U ν μ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U) (hν : ContDiff ℝ ⊤ ν) :
    let ρ := gibbsWeight (fun _ ↦ 1) U β
    phaseO (fun _ ↦ 1) 1 β (ρ*firstReciprocalCorrection U ν μ β)+
      phaseH U (fun x ↦ ρ x*ν x.1) = (fun x ↦ symmetricRHS false U β x*ρ x) := by
  sorry

def conjugatedPhaseH (U : V n → ℝ) (β : ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  phaseH U (gibbsWeight (fun _ ↦ 1) U β*f) x/gibbsWeight (fun _ ↦ 1) U β x

def jointGibbsQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ Integrable (gibbsWeight (fun _ ↦ 1) U β) volume ∧
  0 < ∫ x : Phase n, gibbsWeight (fun _ ↦ 1) U β x
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
- 29号覆盖限定：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。
- 覆盖缺口：给出全部f2,1公式并陈述其一阶PDE；二阶可解相容性需OU积分通量消失及实际域条件，尚未证明。
- 覆盖缺口：29号覆盖限定：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：firstReciprocalCorrection和一阶PDE的正负号正确；β>0、U/ν光滑足够，μ任意q函数不会影响OU动量微分。momentumAverage是归一条件Gaussian平均；Printed是Lebesgue动量积分乘未归一gibbsWeight，原书ρβ则为归一联合密度，因此一般还差总配分常数。_corrected作为条件平均定义合理，但与Printed不是同一算符，必须说明位置边际因子及归一常数。完整声明没有f2,2对象、(7.35)、OU通量零积分或(7.36)的相容结论；extra\_assumptions虽承认未证明，实际缺的是签名而非证明。
网站复审结论：NEEDS\_HUMAN。候选f₂,₁=−β·primitive/24−p·∇ν−μ，与原印一致；PDE的完整结论Ō(ρf₂,₁)+H(ρν)=+symmetricRHSρ=−wρ，符号正确，所加β>0及U、ν C∞合理。Printed是带全相空间配分函数的联合归一密度积分；corrected是独立Gaussian条件平均，不是同一算子。conjugatedPhaseH=H(ρf)/ρ，ρ严格正可除。jointGibbsQualification只定义β>0、可积及配分函数正，不是证明其成立。二阶方程和通量条件已列未覆盖。本项目Hamiltonian输运满足Hρ=0，因此H(ρf)=ρHf；不能将(7.36)该等式本身判错。真正的原书疑点在随后M的归一化与算子解释，需保留该限定。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：所列限定签名PASS；联合权平均与条件平均分别登记。本项目Hρ=0，故H(ρf)=ρHf，撤销把该Hamiltonian乘积等式本身判错的解释；疑点在后续M归一化与算子解释。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：一阶候选及PDE、条件Gaussian平均和原印联合归一密度的动量积分；二者不是同一算子；f2,2、(7.35)/(7.36)通量与可解性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.firstReciprocalCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumAveragePrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumAveragePrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.firstReciprocalCorrection_pde`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.conjugatedPhaseH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.jointGibbsQualification`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-OverdampedSolvabilityOperators

印刷页 304 / PDF页 325。

### 1. 原文陈述

> We abbreviate

$$
\mathcal M\psi(q)=\overline\pi\mathcal L_H^\dagger\mathcal L_A^\dagger\psi(q) =\overline\pi((\mathcal L_A^\dagger)^2+\mathcal L_B^\dagger\mathcal L_A^\dagger)\psi(q) =\beta^{-1}\Delta_q\psi(q)-\nabla U\cdot\nabla_q\psi(q),
$$



$$
\mathcal N\psi(q)=\overline\pi\mathcal L_H^\dagger(\mathcal L_A^\dagger)^3\psi(q) =\overline\pi((\mathcal L_A^\dagger)^4+\mathcal L_B^\dagger(\mathcal L_A^\dagger)^3)\psi(q) =\tfrac3\beta\mathcal M(\Delta_q\psi(q)).
$$


> Thus we have

$$
\overline\pi\mathcal L_H^\dagger\rho_\beta f_{2,1,[OABAO]}=\tfrac\beta8\mathcal M(|\nabla U|^2-\beta^{-1}\Delta_qU)+\mathcal M\nu,
$$


> and hence by (7.36) we finally obtain $`\nu(q)=\tfrac18(\Delta_qU-\beta|\nabla U|^2)`$, where $`\langle\nu\rangle=0`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- M,N记录所印右端微分表达式；π̄与前向算符须用条件Gaussian平均和Gibbs共轭修正后才能证明左侧识别，详见前条。
- 只证明ν候选的代数改写；Mν相容方程、核常数唯一性、零均值须积分分部与定义域桥，不把候选定义当成解已证。
- 29号覆盖限定：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。
- 覆盖缺口：29号覆盖限定：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：overdampedM正确记录β⁻¹Δψ−∇U·∇ψ，N正确记录3M(Δψ)/β，候选ν正确。choice仅在β≠0时对所有q证明同一公式的代数改写，真实但远弱于可解性：没有M/N的平均算符识别、相容方程、ν的核唯一性或零均值声明。[EXTRA]β≠0足够代数运算，但物理Gaussian与积分分部需β>0、正则性、可积和边界资格。原印的算符不一致需人工决定采用哪一共轭约定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：M/N和候选函数定义以及β≠0下代数改写；Gibbs共轭与裸前向算子区分，未含平均识别、相容性、核唯一或零均值结论。

### 7. 状态与证明位置

- `MD.Ch07.overdampedM`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.overdampedN`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.highFrictionOABAO`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.overdampedSolvability_choice`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.2-HighFrictionCorrectionTable

印刷页 304–305 / PDF页 325–326。

### 1. 原文陈述


$$
f_{2,0,[OABAO]}=\tfrac18(\Delta_qU-\beta|\nabla U|^2),
$$



$$
f_{2,0,[OBABO]}=\tfrac18(\beta|\nabla U|^2-2\Delta_qU+c),
$$


> where $`c=\langle\Delta U\rangle`$ is a constant chosen to ensure zero average.

$$
f_{2,0,[ABOBA]}=\tfrac18(\beta p^T\nabla^2U(q)p-2\Delta_qU+c),
$$



$$
f_{2,0,[BAOAB]}=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p).
$$



$$
\langle\vartheta\rangle_h=\langle\vartheta\rangle+h^2\langle\vartheta f_{2,0}\rangle+O(\epsilon h^2+h^4).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

def highFrictionMeanLaplacian (U : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, laplacian U q ∂positionGibbs U β

def highFrictionCenteredQualification (U : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧
  Integrable (laplacian U) (positionGibbs U β) ∧
  ∀ s : Fin 4, Integrable (highFrictionCorrection s U β (highFrictionMeanLaplacian U β))
    (productGibbs (fun _ ↦ 1) U β) ∧
    (∫ x, highFrictionCorrection s U β (highFrictionMeanLaplacian U β) x
      ∂productGibbs (fun _ ↦ 1) U β) = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 算法编号OABAO,OBABO,ABOBA,BAOAB；保留全部四个候选、c选择和双渐近余项命题。
- 候选的代数共轭关系可单独证明；其为实际平稳误差系数、零均值及严格双渐近界均未获证明。
- 29号覆盖限定：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。
- 覆盖缺口：29号覆盖限定：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：s=0,1,2,3依次为OABAO、OBABO、ABOBA、BAOAB，四个公式及共轭关系正确；任意β,c的纯代数定理无需物理资格。positivePairLimit是(ε,h)从正象限趋于(0,0)，doublyAsymptoticAverage的幂次和变量顺序正确。但c只是任意实数，未定义/限制为⟨ΔU⟩，也无四种候选的零均值签名；A、exact、correction完全抽象，未与真实数值均值、Gibbs均值及⟨ϑf2,0⟩建立联系。其为平稳系数和余项尚未证明与尚未声明应分别记录。
网站复审结论：PASS。Fin 4的0/1/2/3精确对应OABAO/OBABO/ABOBA/BAOAB，四分支完整；c参数保留。conjugateCorrectionChange=β(|∇U|²−pᵀHp)/8，两条conjugateCorrections方向分别为减、加，四式满足该纯代数关系。positivePairLimit为(ε,h)从双正侧到(0,0)，余项参数z.1*z.2²+z.2⁴正确。MeanLaplacian为实际位置Gibbs积分；CenteredQualification把概率、可积及四项零均值列成资格，并未证明资格。A、exact、correction为抽象量，没有被误称为真实四算法平稳均值定理，缺口已披露。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：四种候选、其代数共轭、c的实际Gibbs期望与中心化资格定义；双渐近只为抽象目标，真实平稳均值识别未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.highFrictionCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.doublyAsymptoticAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.highFrictionCorrection_conjugacy`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.highFrictionMeanLaplacian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.highFrictionCenteredQualification`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-BAOABMarginalCancellation

印刷页 305 / PDF页 326。

### 1. 原文陈述


$$
\langle\vartheta\rangle=\langle\vartheta\rangle_h-h^2\langle\vartheta f_{2,0}\rangle+O(h^2/\gamma+h^4).\tag{7.37}
$$


> The $`[BAOAB]`$ scheme has leading order correction

$$
f_{2,0,[BAOAB]}(q,p)=\tfrac18(\Delta U-\beta p^T\nabla^2U(q)p),
$$


> which has the interesting property that its marginal average with respect to momentum is zero:

$$
\overline\pi f_{2,0,[BAOAB]}=\int_{\mathcal P}f_{2,0,[BAOAB]}(q,p)\rho_\beta(q,p)d\omega_p=0.
$$



$$
\langle\vartheta(q)f_{2,0,[BAOAB]}\rangle=\int_{\mathcal Q}\vartheta(q)\int_{\mathcal P}f_{2,0,[BAOAB]}\rho_\beta d\omega_p d\omega_q=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem baoabMarginalCancellation (U : V n → ℝ) (β : ℝ) (q : V n) (hβ : 0 < β) :
    momentumAverage β (highFrictionCorrection 3 U β 0) q = 0 := by
  sorry
theorem baoabConfigurationalCancellation (U φ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hint : Integrable (fun x ↦ φ x.1*highFrictionCorrection 3 U β 0 x)
      (productGibbs (fun _ ↦ 1) U β)) :
    (∫ x, φ x.1*highFrictionCorrection 3 U β 0 x ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 归一条件Gaussian平均为零即推出原文带位置权的平均为零；两个零积分结论均为实际测度。双渐近余项的有效性须另外证明，不由形式消项自动给出。
- 29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。
- 覆盖缺口：29号覆盖限定：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：两个零积分声明正确：单位质量Gaussian协方差β⁻¹I使平均βpᵀHess(U)p=ΔU；对配置任意U的逐q系数无需U光滑。构型声明显式要求被积函数可积，足以使用条件零均值。productGibbs未要求位置分布为概率，U=0等情况下positionGibbs可退化为零测度，因此它并不自动是原文的canonical expectation。更主要的是完整(7.37)没有在本条出现，既无真实均值对象也无余项声明；不能用前条未实例化的抽象定义当作本条已覆盖。
网站复审结论：PASS。条件动量Gaussian协方差β⁻¹I，故〈βpᵀHp〉p=tr H=ΔU；U任意也可，因为固定q的有限导数值只是二次多项式系数。Marginal声明∀U,β,q且β>0，结论正确。Configurational声明额外位置Gibbs概率、φ乘修正可积，结论是实际productGibbs下的零积分，足够使用Fubini。原书联合权边际和条件平均相差位置密度，但其零值一致；并未由此推出(7.37)的真实算法误差界。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：Gaussian条件动量消项和归一位置Gibbs资格下的构型消项；真实数值平稳平均及(7.37)双渐近余项未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.baoabMarginalCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.baoabConfigurationalCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-SuperconvergenceScope

印刷页 306 / PDF页 327。

### 1. 原文陈述

> Thus we expect that the $`[BAOAB]`$ scheme recovers $`O(h^4)`$ configurational averages in the limit of infinite friction.
> Its conjugate method, the $`[OABAO]`$ scheme, has the property

$$
\int_{\mathcal Q}f_{2,0,[OABAO]}(q,p)\rho_\beta(q,p)d\omega_q=0,
$$


> implying that we obtain high-order averages for functions purely of the momenta in the limit of infinite friction.
> It is important to note that this superconvergence property is only present in the limit of large time, i.e. this is an attribute of the invariant distribution of the discretization schemes $`\widehat\rho`$. As such, there are no bonuses to the weak or strong order of the superconvergent schemes.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem oabaoPositionCancellation (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ ⊤ U)
    (hweight : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hgrad : ∀ i, Integrable (fun q ↦ (hessianU U q i i-β*gradient U q i^2)*Real.exp (-β*U q)) volume)
    (hboundary : ∀ q i, Filter.Tendsto
      (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ gradient U (Function.update q i r) i*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, highFrictionOABAO U β q ∂positionGibbs U β) = 0 := by
  sorry
theorem superconvergence_fromBound (A : ℝ → ℝ) (exact : ℝ)
    (hA : Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact-h^2*(0 : ℝ)) (fun h ↦ h^4)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ)) (fun h ↦ A h-exact) (fun h ↦ h^4) := by
  simpa using hA

theorem oabaoMomentumCancellation (U χ : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hprob : IsProbabilityMeasure (positionGibbs U β))
    (hf : Integrable (highFrictionOABAO U β) (positionGibbs U β))
    (hχ : Integrable χ (momentumGibbs (fun _ ↦ 1) β))
    (hc : ∫ q, highFrictionOABAO U β q ∂positionGibbs U β = 0) :
    (∫ x, χ x.2*highFrictionOABAO U β x.1 ∂productGibbs (fun _ ↦ 1) U β) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 显式归一Gibbs构型边界通量消失和积分可积条件；此处只给OABAO积分消项。
- 四阶推论仅在已有有效h⁴余项界下成立，不能从固定有限γ的h²/γ余项直接推出；弱/强有限时间阶数不因此提高。
- 29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。
- 覆盖缺口：29号覆盖限定：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：oabaoPositionCancellation中β>0、U光滑、权重与每项通量可积、各坐标两端通量消失，是可执行积分分部资格，结论合理。[EXTRA]这些条件原页省略。superconvergence\_fromBound对任意A和exact假设的h⁴余项界仅消去h²·0，正确但没有BAOAB、γ→∞、实际平稳分布或OABAO任意动量观测对象；它将主要结论所需阶数直接放入前提。缺少由双渐近界及积分消项推出实际方法四阶的完整签名，也未表达有限时间弱/强阶的范围。
网站复审结论：PASS。oabaoPositionCancellation的β>0、U C∞、权可积、各(∂iiU−β(∂iU)²)e^(−βU)可积及每条坐标线两端通量零，足以逐坐标分部积分给零；n=0情形求和亦为零。superconvergence\_fromBound把已有h⁴界中的h²·0消掉，既不建立该界也不识别真实数值误差。MomentumCancellation另假设χ及位置修正可积、位置概率和已知零积分，乘积积分结论正确。无限摩擦、长期和h→0三种范围未混淆，真实四阶桥已列缺口。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：积分分部的配置消项及其纯动量观测乘积消项；fromBound仅代数辅助，真实BAOAB先大摩擦后h→0的四阶结论未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.oabaoPositionCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.superconvergence_fromBound`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.oabaoMomentumCancellation`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

