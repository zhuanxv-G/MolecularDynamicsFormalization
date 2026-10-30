[上一部分](part02.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## MD-7.9-Proposition71

印刷页 297 / PDF页 318。

### 1. 原文陈述

> Proposition 7.1 Let $`\mathcal L_X^\dagger`$, $`\mathcal L_Y^\dagger`$ and $`\mathcal L_Z^\dagger`$ be general operators to which BCH can be applied, then defining

$$
e^{h\widehat{\mathcal L}^\dagger}=e^{\frac h2\mathcal L_X^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{h\mathcal L_Z^\dagger}e^{\frac h2\mathcal L_Y^\dagger}e^{\frac h2\mathcal L_X^\dagger},\tag{7.26}
$$


> gives $`\widehat{\mathcal L}^\dagger=\mathcal L_0^\dagger+h^2\mathcal L_2^\dagger+O(h^4)`$, where

$$
\mathcal L_0^\dagger=\mathcal L_X^\dagger+\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,
$$



$$
\mathcal L_2^\dagger=\frac1{12}([\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger,\mathcal L_X^\dagger]) -\frac1{24}([\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_X^\dagger,\mathcal L_X^\dagger,\mathcal L_Y^\dagger+\mathcal L_Z^\dagger]).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 proposition71, symmetricOddCorrections 所列对象、量词、前提和结论。范围说明：C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 桥接正式库已证的实际非交换形式log/exp及完整对称修正定义体；余项为h⁴形式因子，未声称无界算符级数收敛。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 proposition71, symmetricOddCorrections 所列对象、量词、前提和结论。范围说明：C：任意实代数中的X,Y,Z，无交换性假设。proposition71用∃Q并以X^4*Q准确表达形式O(h⁴)，二阶项为完整D72而非缩减项。symmetricOddCorrections对全部k:ℕ断言第2k+1系数为零，是对称组合的合理强化；不推导密度奇阶自动为零，也不声称无界算符解析收敛。所引用项目定理的完整类型与包装一致。

### 7. 状态与证明位置

- `MD.Ch07.proposition71`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.symmetricOddCorrections`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9-EvenDensityPerturbation

印刷页 298 / PDF页 319。

### 1. 原文陈述

> If we suppose that the odd order correction functions are zero, then we are left with

$$
\widehat\rho=\rho_\beta(1+h^2f_2+h^4f_4+\cdots),\tag{7.27}
$$


> where each $`\langle f_i\rangle=0`$ as usual. Equating the second order terms we obtain

$$
\mathcal L_{LD}^\dagger(\rho_\beta f_2)=-\mathcal L_2^\dagger\rho_\beta.\tag{7.28}
$$


> The condition on the existence of such a solution requires us to use the Fredholm alternative, which requires us to verify that the inhomogeneous term $`\mathcal L_2^\dagger\rho_\beta`$ integrates to zero.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

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

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 系数相消得到必要方程；Fredholm可解性的充分性需核、余核、函数空间和域的闭值域资格，本条不证明。原书将奇阶修正零作为假设，本条保留。
- 29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。
- 覆盖缺口：29号覆盖限定：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：evenDensityExpansion在k=0给ρ，在正偶数k给ρ f\_k，奇数k给零，定义正确。evenPerturbationEquation在任意实模上正确，hL1与hρ1同时列出虽可弱化但不造成错误。FAIL是完整原文覆盖不足：所有修正项的零均值缺失，且未陈述在适当域/边界下由方程导出的∫L2ρ=0。Fredholm可解性需函数空间、核/余核及算符域，原文并未提供足以在任意空间中采信的充分性框架；这里不能声称已证明Fredholm结论。
网站复审结论：PASS。evenDensityExpansion在k=0取ρ、正偶数取ρ·f k、奇数取零。actionCoefficient的和域是j=0,…,k；k=2恰为L₀ρ₂+L₁ρ₁+L₂ρ₀。在线性ℝ模上hL1、hρ1、h2足以推出L₀ρ₂=−L₂ρ₀，无遗漏负号；hL1与hρ1可冗余但不使结论错误。E是局部任意模，不应误识为附列Chapter05Review.E。零均值、Fredholm资格和可解性明确不在覆盖范围。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：偶形式系数定义与二阶必要代数方程；修正项零均值、Fredholm兼容性和充分可解性未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.evenDensityExpansion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.evenPerturbationEquation`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.1-OYZYOInhomogeneity

印刷页 298–299 / PDF页 319–320。

### 1. 原文陈述

> For methods $`[OYZYO]`$, substituting $`\mathcal L_X^\dagger=\mathcal L_O^\dagger`$, $`\mathcal L_Y^\dagger+\mathcal L_Z^\dagger=\mathcal L_A^\dagger+\mathcal L_B^\dagger=\mathcal L_H^\dagger`$ simplifies the computation to

$$
\mathcal L_{2,[OYZYO]}^\dagger\rho_\beta=\frac1{12}[\mathcal L_Z^\dagger,\mathcal L_Z^\dagger,\mathcal L_Y^\dagger]\rho_\beta-\frac1{24}[\mathcal L_Y^\dagger,\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]\rho_\beta.\tag{7.29}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem oyzyoInhomogeneity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (O Y Z : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (Y+Z) ρ = 0) :
    MolecularDynamics.textbookSymmetricOperatorCorrection O Y Z ρ =
      (1/12 : ℝ) • comm Z (comm Z Y) ρ-(1/24 : ℝ) • comm Y (comm Y Z) ρ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 oyzyoInhomogeneity 所列对象、量词、前提和结论。范围说明：C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 oyzyoInhomogeneity 所列对象、量词、前提和结论。范围说明：C：O,Y,Z为任意实模上的线性自同态，Oρ=0及(Y+Z)ρ=0恰是消去交叉嵌套项需要的前提。完整L2由D72给定，余下Z,Z,Y与Y,Y,Z项的次序、负号及标量正确。抽象结果覆盖原文对两种Hamiltonian排列的特化；不声称证明实际Gibbs不变性。

### 7. 状态与证明位置

- `MD.Ch07.oyzyoInhomogeneity`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

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

## MD-7.10-MomentumRedrawLimit

印刷页 306 / PDF页 327。

### 1. 原文陈述

> We now consider schemes in the limit $`\gamma\to\infty`$, where the exact solution of the vector OU process reduces to redrawing momenta from the canonical distribution, so $`p_{n+1}=\sqrt{k_BT}M^{1/2}R`$, where $`R`$ is a vector of i.i.d. normal random numbers.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry

theorem redrawMomentum_law (P : Measure Ω) (m : V n) (θ : ℝ) (R : Ω → V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ)
    (hR : HasLaw R (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ redrawMomentum m θ (R sample)) (momentumGibbs m θ⁻¹) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。
- 29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。
- 覆盖缺口：29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：固定h>0、θ>0，对任意固定p,R的逐噪声路径极限正确，有限维逐坐标拓扑也匹配。m不需正值即可使这个经Real.sqrt截断的纯实函数极限成立；但要忠实表达M正质量与canonical重抽，应加∀i m\_i>0，并给随机R及独立标准Gaussian的分布对象。当前R只是确定向量，无P、HasLaw或随机变量资格；extra\_assumptions称“实际独立Gaussian R”超出了签名。此FAIL是原文分布结论缺失，不否认现有确定性极限定理。
网站复审结论：PASS。ouMomentum完整公式exp(−γh)p+√[θ(1−exp(−2γh))]√m R；固定h>0、正质量、θ>0，γ→∞逐坐标极限正好为√θ√m R。law声明的标准Gaussian乘积分布是独立坐标，输出momentumGibbs m θ⁻¹的方差为m/(θ⁻¹)=mθ，正确。HasLaw使用给定P，不额外把任意确定R声称为随机Gaussian。位置未改变；质量零极限及弱收敛未冒充已证内容。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.redrawMomentum`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.redrawStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumRedrawLimit`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.redrawMomentum_law`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-OBABOOverdampedEuler

印刷页 307 / PDF页 328。

### 1. 原文陈述

> For the method denoted $`[OBABO]`$, we have the limiting scheme

$$
p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad \widehat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),
$$



$$
q_{n+1}=q_n+hM^{-1}\widehat p_{n+1/2},\quad \widehat p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=\sqrt{k_BT}M^{1/2}R_{n+1/2}.
$$



$$
q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+h\sqrt{k_BT}M^{-1/2}R_n.\tag{7.38}
$$


> Denoting $`\tau=h^2/2`$, the update scheme (7.38) becomes the Euler-Maruyama scheme

$$
q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}R_n.\tag{7.39}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def obaboInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  redrawStep m θ S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ redrawStep m θ R
def overdampedEulerH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-h^2/2/m i*gradient U q i+h/m i*redrawMomentum m θ R i
def overdampedEuler (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*R i
theorem obaboInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) (x : Phase n) :
    (obaboInfinite m U θ h R S x).1 = overdampedEulerH m U θ h R x.1 := by
  funext i
  dsimp [obaboInfinite,redrawStep,kickStep,driftStep,overdampedEulerH,Function.comp_def]
  ring
theorem overdampedEuler_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    overdampedEulerH m U θ h R q = overdampedEuler m U θ (h^2/2) R q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite\_position, overdampedEuler\_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite\_position, overdampedEuler\_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。

### 7. 状态与证明位置

- `MD.Ch07.obaboInfinite`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEulerH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEuler`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obaboInfinite_position`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEuler_rescale`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-BAOABLimitMethod

印刷页 307–308 / PDF页 328–329。

### 1. 原文陈述


$$
p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},
$$



$$
\widehat p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\widehat p_{n+1/2},\quad p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}).
$$


> Expressing this as an update solely for the configurations, we obtain

$$
q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+\tfrac h2\sqrt{k_BT}M^{-1/2}(R_n+R_{n-1}),
$$


> and substituting $`\tau=h^2/2`$ gives the BAOAB Limit Method (Leimkuhler-Matthews method)

$$
q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}\left(\tfrac{R_n+R_{n-1}}2\right).\tag{7.40}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def baoabInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ redrawStep m θ R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def lmStepH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-h^2/(2*m i)*gradient U q i+h/(2*m i)*(redrawMomentum m θ R i+redrawMomentum m θ S i)
def lmStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*((R i+S i)/2)
theorem baoabInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) :
    (baoabInfinite m U θ h R (q,fun i ↦ redrawMomentum m θ S i-h/2*gradient U q i)).1 =
      lmStepH m U θ h R S q := by
  funext i
  dsimp [baoabInfinite,lmStepH,kickStep,driftStep,redrawStep,Function.comp_def]
  ring

theorem lmStepH_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    lmStepH m U θ h R S q = lmStep m U θ (h^2/2) R S q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。
- 完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。
- 29号覆盖限定：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：组合次序正确；baoabInfinite\_position显式把初始p写为上一步redraw S减半kick，恰好避免对任意初始p错误地声称位置闭合。lmStepH与lmStep的两个公式正确；但只证明/声明了h形式消元，没有在正质量、θ≥0、h≥0下声明lmStepH=lmStep(τ=h²/2)。前条rescale只作用单噪声Euler，不能自动成为此双噪声声明。该完整结论缺项已在extra\_assumptions承认，但未给目标签名。
网站复审结论：PASS。函数复合从右至左是kick、drift、redraw、drift、kick，符合五段原文。position定理明确以p=redraw(S)−h∇U(q)/2为初值，因此第一个kick后p=redraw(S)−h∇U(q)，消元得到−h²∇U/(2m)及h(redraw R+redraw S)/(2m)。该代数恒等式对所有实参数在Lean总化下成立；rescale另加m>0、θ≥0、h≥0以正确识别√(h²θ)=h√θ，和τ=h²/2一致。没有无条件对任意初始动量声称闭合，也没有声称长期精度。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。

### 7. 状态与证明位置

- `MD.Ch07.baoabInfinite`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmStepH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.baoabInfinite_position`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.lmStepH_rescale`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-ColoredNoiseAndExtension

印刷页 308 / PDF页 329。

### 1. 原文陈述

> We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $`p_n`$).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)

def lmExtendedKernel (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦
      lmExtendedStep m U θ τ z.2 z.1)) : Kernel (V n × V n) (V n × V n) :=
  (Kernel.id.prod (Kernel.const (V n × V n) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)))).map
    (fun z ↦ lmExtendedStep m U θ τ z.2 z.1)

def lmExtendedChain (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n) : ℕ → Ω → V n × V n
  | 0 => X0
  | k+1 => fun sample ↦ lmExtendedStep m U θ τ (R k sample)
      (lmExtendedChain m U θ τ R X0 k sample)

/-- 每次新噪声独立于初始状态及所有先前噪声；集合积分式给出扩展过程的Markov条件分布。 -/
theorem lmExtendedChain_markov (P : Measure Ω) (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (hτ : 0 < τ)
    (hR : vectorNormalSequence P R) (hX0 : Measurable X0)
    (hfresh : ∀ k, IndepFun (R k)
      (fun sample ↦ (X0 sample,fun j : Fin k ↦ R j sample)) P)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦ lmExtendedStep m U θ τ z.2 z.1)) :
    let X := lmExtendedChain m U θ τ R X0
    ∀ k (A : Set (V n × V n)) (hA : MeasurableSet A) (B : Set Ω),
    MeasurableSet[⨆ j : Fin (k+1), MeasurableSpace.comap (X j) inferInstance] B →
    P (B ∩ (X (k+1)) ⁻¹' A) =
      ∫⁻ sample in B, lmExtendedKernel m U θ τ hstep (X k sample) A ∂P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。
- 覆盖缺口：一般位置过程非Markov需额外非退化参数与初态；此处未作无条件断言。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：coloredNoise采用相邻标准独立Gaussian平均，索引(R\_k,R_{k+1})与原页(R\_n,R_{n−1})仅差移位；covariance对概率P、iIndepFun和HasLaw量化，方差1/2、邻接协方差1/4、其余0正确，应标[EXTRA]推导结论。lmExtendedStep把(q,R旧)映射到(lmStep(R新,R旧,q),R新)正确。但未有新噪声独立于过去的过程条件、Markov核/条件分布或扩展Markov性声明；只给一个确定性状态映射不能覆盖原页的核心Markov断言。一般位置过程非Markov也不宜无条件量化。
网站复审结论：NEEDS\_HUMAN。coloredNoise=(Rk+Rk+1)/2是对原文相邻噪声的移位记号；独立标准正态使其均值零，二阶矩分别为1/2、1/4、0，故covariance名虽结论写E[ηjηk]仍正确。这是[EXTRA]协方差结论。extendedStep输入状态(q,旧噪声)，输出(lmStep(新,旧,q),新)，Kernel为δ状态×标准Gaussian的可测推前，确为转移核。chain递归k=0起，markov的hfresh要求Rk独立于X0及R0,…,Rk−1，hstep、hX0与vectorNormalSequence足以保证对X0,…,Xk历史中所有可测B的集合积分恒等式；索引Fin(k+1)正确。metadata却仍称Markov定理未覆盖，须订正。原书由有色噪声直接推非Markov也须保留例外资格。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：fresh独立性下Markov集合积分式签名PASS；删去过时的同名缺口。协方差为额外推论，位置非Markov仍需限定。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。

### 7. 状态与证明位置

- `MD.Ch07.coloredNoise`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.coloredNoise_covariance`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedKernel`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedChain`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedChain_markov`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-LimitMethodAccuracy

印刷页 308 / PDF页 329。

### 1. 原文陈述

> We would expect that this scheme should have an $`O(h^4)=O(\tau^2)`$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $`O(h^2)`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
def limitAccuracyPrinted (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^2)

def limitAccuracyPrinted_corrected (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^4)

theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring

def limitAccuracyInfiniteTime_corrected (error : ℝ → ℝ → ℝ) (longtime : ℝ → ℝ) : Prop :=
  (∀ h, 0 < h → Tendsto (fun T ↦ error (h^2/2) T) atTop (𝓝 (longtime h))) ∧
  limitAccuracyPrinted_corrected longtime
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。
- 原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。
- 29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
- 覆盖缺口：29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：Printed忠实保留h²幂次，PASS；_corrected给h⁴合理对应无限时间不变平均，但必须限定该error为长期误差，不能直接用于固定有限T。lmTransientErrorBound正确记录C(e^(−aT)τ+τ²)的一种充分界，正C/a/δ及所有小τ、T≥0的量词明确，属于[EXTRA]精确定量目标；原书文字本身不保证该统一界。rescale恒等式正确。缺少LM真实平均误差与error的联系、势/观测/初值条件和实际误差满足该界的签名。
网站复审结论：NEEDS\_HUMAN。瞬态界的量词是存在统一C>0、衰减率>0、δ>0，∀0<τ<δ及∀T≥0，界C(e^(−λT)τ+τ²)；它只是error的性质定义。Printed保留h→0正侧的O(h²)，corrected改为O(h⁴)，rescale代数式τ²=h⁴/4正确。InfiniteTime\_corrected显式把固定h先T→∞的longtime接到O(h⁴)，防止把固定有限T误判四阶。任何声明都未证明真实LM误差满足瞬态界。原书末句符号歧义保留，孤立corrected定义应仅在长期语境中解释。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：限定定义和长期极限连接签名PASS；h⁴仅在先取长期极限的解释下适用，不表示固定有限时间四阶或真实LM误差界已证。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.lmTransientErrorBound`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracyPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.limitAccuracyPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracy_rescale`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracyInfiniteTime_corrected`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-ZeroFrictionVerlet

印刷页 306 / PDF页 327。

### 1. 原文陈述

> An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $`\gamma=0`$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  funext x
  have ha : driftStep m (h/2) (driftStep m (h/2) (kickStep U (h/2) x)) =
      driftStep m h (kickStep U (h/2) x) := by
    ext i <;> dsimp [driftStep] <;> ring
  simp only [baoab,Function.comp_apply,zeroFrictionOU]
  rw [ha]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。

### 7. 状态与证明位置

- `MD.Ch07.zeroFrictionOU`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.zeroFrictionBAOAB`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.11.1-TemperatureObservables

印刷页 310 / PDF页 331。

### 1. 原文陈述

> Indeed, calculating the temperature of the system from an average of kinetic energy by

$$
N_dk_BT=\langle p^TM^{-1}p\rangle,\tag{7.41}
$$


> gives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature

$$
N_dk_BT=\langle q\cdot\nabla U(q)\rangle.\tag{7.42}
$$


> Were one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。
- 构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。

### 7. 状态与证明位置

- `MD.Ch07.kineticTemperatureObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.configurationTemperatureObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.kineticTemperature`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.configurationTemperature`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.11.1-VelocityAutocorrelationDefinition

印刷页 310 / PDF页 331。

### 1. 原文陈述

> The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation\_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。
- 已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。
- 覆盖缺口：已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation\_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。

### 7. 状态与证明位置

- `MD.Ch07.velocityAutocorrelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.greenKuboDiffusion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.autocorrelation_rescale`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedLangevin

印刷页 317 / PDF页 338。

### 1. 原文陈述


$$
dq=M^{-1}pdt,\tag{7.43}
$$



$$
dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\tag{7.44}
$$



$$
0=g(q).\tag{7.45}
$$


> The vector of $`l`$ constraints is given by $`g:\mathbb R^{N_c}\to\mathbb R^l`$ and $`\lambda`$ is an $`l`$-dimensional vector of Lagrange multipliers. $`W`$ is a vector of standard Wiener processes, with the usual friction parameter $`\gamma\gt 0`$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint

$$
g(q)=0,\qquad g'(q)M^{-1}p=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (multiplier : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*multiplier j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))

/-- 限制到单位质量、常正交投影的线性约束修正版；未声称一般非线性情形。 -/
def constrainedLangevin_corrected {l : ℕ} (P : Measure Ω) (C : Matrix (Fin l) (Fin n) ℝ)
    (proj : Matrix (Fin n) (Fin n) ℝ) (U : V n → ℝ) (γ θ : ℝ)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 U ∧
  proj*proj=proj ∧ proj.transpose=proj ∧ C*proj=0 ∧
  (∀ v : V n, C *ᵥ v=0 → proj *ᵥ v=v) ∧
  C *ᵥ x0.1=0 ∧ C *ᵥ x0.2=0 ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    C *ᵥ (X t sample).1=0 ∧ C *ᵥ (X t sample).2=0 ∧
    (∀ i, (X t sample).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i) ∧
    ∀ i, (X t sample).2 i=x0.2 i+
      (∫ s in (0 : ℝ)..t, -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i)+
      Real.sqrt (2*γ*θ)*(proj *ᵥ (W t sample-W 0 sample)) i
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。
- 定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
- 29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。
- 覆盖缺口：定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
- 覆盖缺口：29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：Jacobian、反力求和、g′M⁻¹p=0和约束相空间定义正确；vectorWiener确含概率、联合Gaussian、标准协方差、连续路径和坐标过程独立。积分式的m\_i、γ、θ、W增量及初值无误。[EXTRA]正质量/温度、C²约束、自然W历史适应、确定初值及逐sample可积都是对解类的额外限制，非原页已给定全部资格。关键问题：Λ被限定为普通时间可积过程，反力只有有限变差∫g′ᵀΛds，无法抵消标准环境W的法向Brownian分量而保持隐藏约束；若原书λdt意指随机冲量，当前定义就不忠实于通常约束Langevin。若严格照字面则继承原印问题，不能据此断言有解。
网站复审结论：NEEDS\_HUMAN。V n、V l、Jacobian(j,i)、Reaction=JacobianᵀΛ及hiddenConstraint中的p\_i/m\_i均对应原式；θ=kBT，质量为正对角质量而非一般非对角矩阵，是[EXTRA]范围限制。vectorWiener的联合Gaussian、零均值、min协方差、连续路径和坐标独立规格确为标准向量Wiener。原版限定正时间，X和Λ适应W的自然历史、X路径连续/确定初值几乎处处，漂移逐路径可积，∀t≥0几乎处处满足完整约束和两个积分方程；λ确以dt积分，仅保留原印解类，不宣称存在。corrected仅单位质量、线性齐次约束Cq=0：proj自伴幂等、Cproj=0且恒等于ker C，故正是到ker C的正交投影；投影力和噪声、摩擦−γp与两条约束一致，修正合理。原印一般非退化噪声与有限变差反作用难以保持隐藏约束，应加[ERRATUM?]。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：单位质量线性约束投影修正版签名PASS；原印有限变差乘子模型不声称一般存在。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.constraintJacobian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constraintReaction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.hiddenConstraint`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.cotangentConstraint`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedLangevin`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedLangevin_corrected`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedCanonicalErgodicity

印刷页 317 / PDF页 338。

### 1. 原文陈述

> In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $`\widetilde\rho_\beta`$ ergodically, such that

$$
\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,
$$


> where $`\widetilde\rho_\beta`$ is the normalized constrained canonical distribution

$$
\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],
$$


> for normalizing constant $`Z`$ and where $`\delta[z]:=\prod_i\delta[z_i]`$ for a vector $`z`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))

def constrainedCanonicalQualification {l : ℕ} (ν : Measure (Phase n))
    (m : V n) (g : V n → V l) (U : V n → ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ContDiff ℝ 2 g ∧ constrainedReference ν m g ∧
  Integrable (gibbsWeight m U β) ν ∧ (0 < ∫ x, gibbsWeight m U β x ∂ν)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。
- 实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。
- 29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。
- 覆盖缺口：29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：constrainedReference用(πε)^(−l)对2l个标量约束同时正则化，常数和ε幂正确，且显式要求支撑于cotangentConstraint；作为所印delta乘积的弱极限目标是忠实的。constrainedCanonical接受任意ν，未要求它满足constrainedReference、配分积分正有限或β>0，因此并非自动归一约束canonical。constrainedErgodicAverages仅是对任意P/X/μ的遍历目标定义，没有将μ连接到该canonical、也没有X满足约束SDE的前提或相应蕴涵声明。原书delta参考测度与自然约束相空间体积的Jacobian因子和遍历性条件需人工处理；extra\_assumptions的提醒不足以连接这些签名。
网站复审结论：NEEDS\_HUMAN。四个声明作为已缩小范围的定义基本忠实且内部合理，但没有完整的受约束SDE遍历结论。原书无条件遍历采样及delta参考的解释存在实质疑问，必须依任务规则保留原印并判NEEDS\_HUMAN；本判定不是因没有补证明或因sorry。
按版本登记：四个参考与遍历目标定义的限定范围获认可；没有完整受约束SDE遍历定理，几何参考体积和连通/不可约资格仍待导师。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。

### 7. 状态与证明位置

- `MD.Ch07.constrainedCanonical`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedReference`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedErgodicAverages`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedCanonicalQualification`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedHOSplitting

印刷页 318 / PDF页 339。

### 1. 原文陈述

> We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses

$$
H_c:\quad dq=M^{-1}pdt,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> We solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $`h`$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $`h/2`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)

def constrainedONoise (m : V n) (γ θ : ℝ) (j : Fin n) : Phase n :=
  (0,fun i ↦ if i=j then Real.sqrt (2*γ*θ*m i) else 0)

def constrainedHIntegralStep {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (X : ℝ → Phase n) (Λ : ℝ → V l) (x0 : Phase n) (T : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 g ∧ ContDiff ℝ 1 U ∧ 0 ≤ T ∧
  ContinuousOn X (Icc 0 T) ∧ X 0=x0 ∧
  (∀ t ∈ Icc 0 T, X t ∈ cotangentConstraint m g) ∧
  ∀ i, IntervalIntegrable (fun t ↦ (X t).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun t ↦ -gradient U (X t).1 i-
      constraintReaction g (X t).1 (Λ t) i) volume 0 T ∧
    ∀ t ∈ Icc 0 T,
      (X t).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s).2 i/m i ∧
      (X t).2 i=x0.2 i+∫ s in (0 : ℝ)..t,
        -gradient U (X s).1 i-constraintReaction g (X s).1 (Λ s) i

/-- O乘子冲量允许含随机部分；不把它限为有限变差的λdt。 -/
def constrainedOIntegralStep {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (reactionImpulse : ℝ → Ω → V n) (x0 : Phase n) (T : ℝ) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧ 0 ≤ T ∧
  (∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P, X t sample ∈ cotangentConstraint m g) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Icc 0 T) ∧
    X 0 sample=x0 ∧ reactionImpulse 0 sample=0) ∧
  (∀ sample i, IntervalIntegrable (fun t ↦ -γ*(X t sample).2 i) volume 0 T) ∧
  (∀ sample t, ∃ impulseCoeff : V l, reactionImpulse t sample=constraintReaction g x0.1 impulseCoeff) ∧
  (∀ t ∈ Icc 0 T, Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
      (reactionImpulse t)) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1 ∧ ∀ i,
      (X t sample).2 i=x0.2 i+(∫ s in (0 : ℝ)..t, -γ*(X s sample).2 i)-
        reactionImpulse t sample i+Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

def constrainedHMapQualification {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (H : ℝ → Phase n → Phase n) : Prop :=
  (∀ T, 0 ≤ T → Measurable (H T)) ∧
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ Λ : ℝ → V l,
    constrainedHIntegralStep m U g (fun t ↦ H t x) Λ x T

def constrainedOMapQualification {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (O : ℝ → Ω → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure P ∧ vectorWiener P W ∧
  (∀ T, 0 ≤ T → Measurable (fun z : Ω × Phase n ↦ O T z.1 z.2)) ∧
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ reaction : ℝ → Ω → V n,
    constrainedOIntegralStep P m g γ θ W (fun t sample ↦ O t sample x) reaction x T

/-- 非负步长、合规确定初值下的输出；底层概率测度明确为P.prod P。 -/
def constrainedHOQualifiedComposition {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) : Ω × Ω → Phase n :=
  fun sample ↦ O (h/2) sample.2 (H h (O (h/2) sample.1 x))

theorem constrainedHOQualifiedComposition_measurable {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    Measurable (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx) := by
  have hhalf : 0 ≤ h/2 := by positivity
  have hmO := hO.2.2.1 (h/2) hhalf
  have hfirst : Measurable (fun sample : Ω × Ω ↦ O (h/2) sample.1 x) :=
    hmO.comp (measurable_fst.prodMk measurable_const)
  exact hmO.comp (measurable_snd.prodMk ((hH.1 h hh).comp hfirst))

/-- 输出律由乘积概率上的可测推前给出；不声称已识别条件积分解。 -/
def constrainedHOOutputLaw {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) : Measure (Phase n) :=
  (P.prod P).map (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx)

theorem constrainedHOOutput_hasLaw {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    HasLaw (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx)
      (constrainedHOOutputLaw P m U g γ θ W H O hH hO h hh x hx) (P.prod P) := by
  exact hasLaw_map (constrainedHOQualifiedComposition_measurable P m U g γ θ W H O hH hO h hh x hx).aemeasurable

theorem constrainedHOOutputLaw_probability {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    IsProbabilityMeasure (constrainedHOOutputLaw P m U g γ θ W H O hH hO h hh x hx) := by
  letI : IsProbabilityMeasure P := hO.1
  exact (constrainedHOOutput_hasLaw P m U g γ θ W H O hH hO h hh x hx).isProbabilityMeasure_iff.mp inferInstance
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。
- 每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。
- 30号修复：P为概率及W为向量Wiener独立于约束集非空性；H的初值可测与O的样本/初值联合可测。
- H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。
- 覆盖缺口：未建立随机初值代入后的条件积分解、几乎处处约束保持及完整条件转移核识别；未构造分段解存在唯一性、Oc半群律或约束Gaussian不变性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：HField正确记录dq=M⁻¹p与−∇U−g′ᵀλ，OField只记录dq=0和−γp−g′ᵀλ的漂移。composition在任意类型E及任意映射H/O上实现右至左O半步、H全步、O半步，顺序正确。然而完整Oc噪声√(2γkBTM)dW没有参数或扩散对象，本条也没有H/O满足各自受约束方程、g=0及隐藏约束保持的资格。映射E→E还不能直接表达随机OU核及两次独立新噪声；不能以extra\_assumptions中“前条噪声”替代本条缺失的连接签名。FAIL是完整对象/结论缺项，不要求实际流的存在证明。
网站复审结论：FAIL。漂移、扩散、分段积分解及O-H-O时间次序核对正确，且hH/hO确已连接分段规格。FAIL限于本条声明要覆盖的独立随机映射组合：规格只逐确定初值可测，没有H/O联合可测性，也未指定P.prod P上的输出随机变量/条件分布。两个坐标的函数不足以保证随机初值下的有效组合。另有原印λdt解释疑义，因此A部分仍NEEDS\_HUMAN。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：按网站审校意见修复，本地核验通过（未再送网站）。
本条实际覆盖：H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。

### 7. 状态与证明位置

- `MD.Ch07.constrainedHField`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOField`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOComposition`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedONoise`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHIntegralStep`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOIntegralStep`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHMapQualification`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOMapQualification`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOQualifiedComposition`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOQualifiedComposition_measurable`：已证；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutputLaw`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutput_hasLaw`：已证；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutputLaw_probability`：已证；网站：按意见修复，本地核验通过（未再送网站）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-MEVMEAlgorithm

印刷页 318–319 / PDF页 339–340。

### 1. 原文陈述

> Midpoint Euler - Verlet - Midpoint Euler (see [232])

$$
p_{n+1/4}=p_n-\tfrac{h\gamma}4(p_n+p_{n+1/4})+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4},\quad g'(q_n)M^{-1}p_{n+1/4}=0.
$$



$$
p_{n+1/2}=p_{n+1/4}-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/2},\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},
$$



$$
p_{n+3/4}=p_{n+1/2}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+3/4},\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\quad g(q_{n+1})=0.
$$



$$
p_{n+1}=p_{n+3/4}-\tfrac{h\gamma}4(p_{n+3/4}+p_{n+1})+\sqrt{h\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (multiplier : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (multiplier μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ multipliera multiplierb multiplierc multiplierd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa multipliera ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph multiplierb multiplierc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 multiplierd
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。

### 7. 状态与证明位置

- `MD.Ch07.midpointConstrainedORelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedVerletRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.mevmeRelation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

