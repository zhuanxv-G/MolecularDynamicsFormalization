[上一部分](part03.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## 1. MD-5.2.3-MechanicalLiouvillianIdentity · unnumbered_claim · 印刷p.187 / PDFp.208

### 2. 原文陈述

> The Liouvillian of a Hamiltonian system with $`N_c`$ degrees of freedom and a Hamiltonian of the form $`H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})`$ can be written

$$
\mathcal L_H^\dagger=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},
$$


> where $`F_i=-\partial U/\partial q_i`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mechanicalLiouvillianIdentity : ∀ n (m : Fin n → ℝ) (U : MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ i,0 < m i) → ContDiff ℝ 2 U →
  ∀ (u : MolecularDynamics.Chapter05Review.Phase n → ℝ),Differentiable ℝ u → ∀ z,
    -(fderiv ℝ u z) (MolecularDynamics.Chapter05Review.hamiltonianField
      (fun x => (∑ i,(x.2 i)^2/(2*m i))+U x.1) z)=
    MolecularDynamics.Chapter05Review.mechanicalLiouvillian m (fun q => -gradient U q) u z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mechanicalLiouvillianIdentity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。 | [EXTRA] |

[EXTRA] [EXTRA]正的固定物理质量及C²势；任意实际可微u与完整q,p，保留一般U，不仅二次势；此处为Hamiltonian场的实际负Lie表达式，形式伴随由散度/积分资格另条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对∀n、所有坐标正质量m、任意C²势U、任意全空间可微实函数u及所有z∈Phase n。H为∑p\_i²/(2m\_i)+U(q)，hamiltonianField实际定义是(∇pH,-∇qH)；由固定非零m及势仅依赖q，恰得(p\_i/m\_i,-∇U(q))。结论将此场的负方向导数等同于mechanicalLiouvillian m (-gradient U)，完整保留一般势、所有q,p和所有u，并无只测二次势的弱化。[EXTRA]明确这是负Lie表达式身份而非无界Hilbert算子域的识别；正质量和C²强化合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.mechanicalLiouvillianIdentity`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L648)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-TestSpace · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> The functions on which the generalized function acts are called test functions. Some choices for the space of test functions $`\mathcal T^m`$ defined on $`\mathbb R^m`$ include: the $`C^\infty`$ functions with compact support in $`\mathbb R^m`$, denoted $`C_0^\infty(\mathbb R^m)`$; the space $`\mathcal S(\mathbb R^m)`$ of $`C^\infty`$ functions on $`\mathbb R^m`$ whose derivatives decay rapidly at infinity (the so-called Schwarz space).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def testSpace (n : ℕ) := {φ : MolecularDynamics.Chapter05Review.E n → ℝ // ContDiff ℝ ∞ φ ∧ HasCompactSupport φ}

/-- 原文第二选项，独立保留Schwartz空间。 -/

def testSpaceSchwartz (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.testSpace`；`MD.Ch05.testSpaceSchwartz` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 紧支持C∞选项保留，并在同一source\_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。 | [EXTRA] |

[EXTRA] [EXTRA] 将Cω误编码改为原书C∞（scoped ∞）；只改Blueprint实际测试空间，正式库冻结。；[EXTRA] 紧支持C∞选项保留，并在同一source\_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。

### 6. 审计结论

本轮修复：紧支持C∞选项保留，并在同一source\_id新增实际SchwartzMap选项testSpaceSchwartz；二者各自独立，不用其它条目的名称替代第二选项。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；当前仅有testSpace n这一声明：实n维欧氏空间上的实值函数子类型，ContDiff ℝ ∞与HasCompactSupport正确编码第一选项C∞紧支持，未误用Cω。但原文及本条statement\_scope还完整列出第二选项S(R^m)，且context\_notation声称两个选项都保留。所给本source\_id全部声明与依赖里没有SchwartzMap/Schwartz空间选项、二选一接口或对应映射；不能因其他条目6引用过schwartzSpace就认定本条已经覆盖第二选项。因此完整覆盖FAIL；第一选项自身PASS。

### 7. 状态与证明位置

self-contained；`MD.Ch05.testSpace`：定义；`MD.Ch05.testSpaceSchwartz`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L659)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-SchwartzSpace · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> The formal definition of $`\mathcal S`$ is

$$
\mathcal S(\mathbb R^m)\stackrel{\rm def}{=}\{f\in C^\infty(\mathbb R^m)\mid\|f\|_{\alpha,\beta}\lt \infty\},
$$


> where $`\alpha`$ and $`\beta`$ are arbitrary multi-indices, i.e. vectors of non-negative integers, and

$$
\|f\|_{\alpha,\beta}\stackrel{\rm def}{=}\sup_{z\in\mathbb R^m}\left|z_1^{\alpha_1}z_2^{\alpha_2}\cdots z_m^{\alpha_m}\frac{\partial^{\beta_1+\beta_2+\cdots+\beta_m}f}{\partial z_1^{\beta_1}\partial z_2^{\beta_2}\cdots\partial z_m^{\beta_m}}\right|.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def schwartzTestSpace (n : ℕ) := SchwartzMap (MolecularDynamics.Chapter05Review.E n) ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.schwartzTestSpace` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。 | [EXTRA] |

[EXTRA] [EXTRA]Mathlib实际SchwartzMap以全阶Fréchet导数及多项式权界编码快速衰减；使用其既有空间，未把名称当任意类型。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。项目 E n 已在 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean 段展开为 EuclideanSpace ℝ (Fin n)；MD.Ch05.schwartzTestSpace n 为 SchwartzMap (E n) ℝ。依用户补充规则，采信 SchwartzMap 的标准意义：实际实值 C∞ 函数，任意自然数 k 与微分阶数 r 的 ‖x‖^k‖D^r f(x)‖ 有统一有限上界。该标准空间自身使用 C∞ 阶数 ∞，不能因项目 testSpace 中另有 ⊤ 误用而把它当成解析函数空间。在有限维 ℝⁿ 上，全阶 Fréchet 导数范数的多项式权界与原书任意多重指标 α、β 的坐标单项式加权偏导数界等价：正向由坐标偏导受全阶导数范数控制，反向由有限坐标展开及有限维范数等价保证。n 任意，标量及函数值均为 ℝ，全部微分阶数与全部权的量词均保留。[EXTRA] 是等价的标准实现说明，没有增加数学限制，合理；无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.schwartzTestSpace`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L667)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GeneralizedFunction · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def generalizedFunction (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.generalizedFunction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。MD.Ch05.generalizedFunction 的完整定义是 (T : Type*) [AddCommGroup T] [Module ℝ T] := T →ₗ[ℝ] ℝ；该声明没有调用待展开的 MolecularDynamics 自定义定义。按标准含义，结果恰为 T 上满足加法及实数标量作用的实值代数线性泛函。量词／参数顺序为测试空间 T、其加法群及实模块结构，随后构成所有这些线性泛函的类型；这些结构编码原文所需的实向量空间。T 作为适当测试函数空间的抽象参数，无需给测试函数选定拓扑。原文只要求 real-valued linear operation，没有连续性要求，本签名亦没有连续性前提或字段，符合 context\_notation。[EXTRA] 与 [ERRATUM?] 均无。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.generalizedFunction`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L670)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-SchwartzFunctional · definition · 印刷p.188 / PDFp.209

### 2. 原文陈述

> Formally, we define a generalized function as a real-valued linear operation (a linear functional) defined on a suitable space of functions.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def schwartzFunctional (n : ℕ) := (MolecularDynamics.Chapter05Review.schwartzSpace n) →ₗ[ℝ] ℝ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.schwartzFunctional` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。 | [EXTRA] |

[EXTRA] [EXTRA]明确选择原书第二个测试空间；上条泛型定义与紧支持C∞选项仍保留，不以Schwartz选择替换原文所有测试空间。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已从依赖附件展开 MolecularDynamics.Chapter05Review.schwartzSpace n := SchwartzMap (E n) ℝ 与 E n := EuclideanSpace ℝ (Fin n)。因此 MD.Ch05.schwartzFunctional n 是 ℝⁿ 上实际 Schwartz 实值测试函数空间到 ℝ 的实线性泛函类型。变量 n 任意，实标量、实值域及完整线性要求均保留，没有附加连续性。[EXTRA] 明确选择原书列出的第二种测试空间，是合理专门化，泛型 generalizedFunction 与另一测试空间条目在本批分别保留。另一条 testSpace 的阶数偏差由该条的 FAIL 单独记录，不影响此处 Schwartz 专门化与原文的对应。无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.schwartzFunctional`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L674)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-RegularDistribution · definition · 印刷p.188–189 / PDFp.209–210

### 2. 原文陈述

> If $`f`$ is a bounded, smooth function on $`\mathbb R^m`$, we may define a generalized function $`T_f`$ by reference to its action on a test function $`\phi\in\mathcal T`$ via integration:

$$
T_f(\phi)=\int_{\mathbb R^m}f(z)\phi(z)d\omega.
$$


> This is very like the $`L^2`$ inner product, but the functions involved do not both need to lie in $`L^2`$. Nevertheless, we write $`T_f(\phi)=\langle f,\phi\rangle`$, as a helpful shorthand.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def regularDistribution {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := ∫ z, f z*φ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.regularDistribution` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E n 是实 n 维欧氏空间，schwartzSpace n 是实值 SchwartzMap。声明对任意 n、任意实函数 f 及 Schwartz 测试函数 φ 定义体积积分 ∫ fφ，积分域和被积式正确。它把原书的有界光滑 f 定义式延伸到更大的函数类型；总化积分在这一定义中不声称任意 f 都产生线性分布。在原书有界 C∞ 范围，可积性和完整实线性由本批条目2的 regularDistributionLinearity 承担；本定义无需把这些结论充当参数。原页明列 Schwartz 为一种可选测试空间，因此所选测试域忠实。

### 7. 状态与证明位置

self-contained；`MD.Ch05.regularDistribution`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L677)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-RegularDistributionLinearity · unnumbered_claim · 印刷p.188 / PDFp.209

### 2. 原文陈述

> If $`f`$ is a bounded, smooth function on $`\mathbb R^m`$, we may define a generalized function $`T_f`$ by reference to its action on a test function $`\phi\in\mathcal T`$ via integration: $`T_f(\phi)=\int_{\mathbb R^m}f(z)\phi(z)d\omega`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem regularDistributionLinearity : ∀ n (f : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ ∞ f → (∃ C : ℝ,∀ z,|f z| ≤ C) →
  (∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,Integrable (fun z => f z*φ z) volume) ∧
  (∀ (φ ψ : MolecularDynamics.Chapter05Review.schwartzSpace n) (a b : ℝ),
    MolecularDynamics.Chapter05Review.regularDistribution f (a • φ+b • ψ)=a*MolecularDynamics.Chapter05Review.regularDistribution f φ+b*MolecularDynamics.Chapter05Review.regularDistribution f ψ) := by
  intro n f hf hb
  obtain ⟨C,hC⟩ := hb
  have hi : ∀ φ : MolecularDynamics.Chapter05Review.schwartzSpace n,
      Integrable (fun z => f z*φ z) volume := by
    intro φ
    apply Integrable.mono' (φ.integrable.norm.mul_const C)
    · exact hf.continuous.measurable.aestronglyMeasurable.mul φ.continuous.measurable.aestronglyMeasurable
    · filter_upwards [] with z
      simpa only [norm_mul,Real.norm_eq_abs,mul_comm] using mul_le_mul_of_nonneg_right (hC z) (abs_nonneg (φ z))
  refine ⟨hi,?_⟩
  intro φ ψ a b
  simp only [MolecularDynamics.Chapter05Review.regularDistribution,SchwartzMap.add_apply,SchwartzMap.smul_apply,smul_eq_mul]
  simp_rw [mul_add,← mul_assoc,mul_comm (f _) a,mul_comm (f _) b]
  simp_rw [mul_assoc]
  rw [integral_add ((hi φ).const_mul a) ((hi ψ).const_mul b),integral_const_mul,integral_const_mul]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.regularDistributionLinearity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。 | [EXTRA] |

[EXTRA] [EXTRA]原有界光滑f及明确选择的Schwartz测试空间；可积与完整线性两个结论都保留，不把可积作结论假设。；[EXTRA] 将不必要的实解析限制恢复为原书C∞，保留有界性、Schwartz选择及原可积/线性结论；已有证明随本批编译复查。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；全部量词为 ∀ n、∀ f，随后要求 ContDiff ℝ ∞ f 和一个对所有 z 通用的实上界 C。∞ 是 C∞，不是实解析。结论保留两个部分：每个 Schwartz φ 的 fφ 体积可积，以及对任意 φ、ψ 和任意实标量 a、b 的完整线性等式。regularDistribution 的依赖是真实积分；没有将可积性或线性改放进假设。有界光滑是原书条件，Schwartz 是书中明列的测试选择；[EXTRA] 的实质与签名一致。审校不将已有证明文本当作本次编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch05.regularDistributionLinearity`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L682)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracAction · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> For the Dirac delta $`\delta`$, its action on a function $`\phi\in\mathcal T`$ is $`\delta[\phi]=\phi(0)`$. We write this also as $`\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def diracAction {n : ℕ} (φ : MolecularDynamics.Chapter05Review.schwartzSpace n) := φ 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracAction` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已展开项目 schwartzSpace n := SchwartzMap (E n) ℝ 与 E n := EuclideanSpace ℝ (Fin n)，MD.Ch05.diracAction {n} φ 与依赖同名定义均直接返回 φ 0。按标准 SchwartzMap 函数作用，0 是 ℝⁿ 的零向量，返回实际实数 φ(0)，n 与 φ 均任意，恰为原页 δ[φ]=φ(0)。评价对测试函数加法和实数倍具有标准线性意义，原页 ⟨δ,φ⟩ 和形式积分表示同一动作，没有要求普通 Lebesgue 密度。选择原书列出的 Schwartz 测试空间是合理专门化；本条未单列 [EXTRA]，但这一选择由参数类型及本批相关定义明确，不附加排除 Schwartz 成员的条件。无 [ERRATUM?]。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracAction`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L704)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracMeasure · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> For the Dirac delta $`\delta`$, its action on a function $`\phi\in\mathcal T`$ is $`\delta[\phi]=\phi(0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def diracMeasure (n : ℕ) : Measure (MolecularDynamics.Chapter05Review.E n) := Measure.dirac 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracMeasure` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS。已展开项目 E n := EuclideanSpace ℝ (Fin n)，并核对 MD.Ch05.diracMeasure n 与依赖同名定义均为 Measure.dirac 0 : Measure (E n)。按补充规则采信标准零点 Dirac 测度：单位质量集中于0；其对本批连续 Schwartz 测试函数的积分作用为 ∫ φ(z) d(δ\_0)(z)=φ(0)。因此测度对象、零点、单位质量、任意维度以及原文的全部评价动作均一致，与同批 diracAction 的实现相符。它实现原文的点分布，没有将形式 δ(z)dω 解释成普通光滑 Lebesgue 密度。不存在必要而未提供的项目自定义定义。[EXTRA] 与 [ERRATUM?] 均无。本次仅审计签名语义；直接定义不含 sorry，未进行 Lean 编译或补写证明。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracMeasure`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L707)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracApproximation · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> This concept of the delta function (that appears in the integral) may be motivated by introducing a sequence of continuous functions $`d_\varepsilon`$ having the properties (i) $`\int d_\varepsilon d\omega=1`$, (ii) $`\operatorname{supp}(d_\varepsilon)\to0`$, as $`\varepsilon\to0`$. Then the action of the delta function can be seen as the limit of the actions of the functions $`d_\varepsilon`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem diracApproximation :
  ∀ n (r : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  (∀ ε > 0,Continuous (r ε)) →
  (∀ ε > 0,MolecularDynamics.Chapter05Review.probabilityDensity (r ε)) →
  (∀ δ > 0, ∃ η > 0, ∀ ε ∈ Ioo 0 η, Function.support (r ε) ⊆ Metric.ball 0 δ) →
  ∀ φ : MolecularDynamics.Chapter05Review.E n → ℝ, Continuous φ →
    Tendsto (fun ε => ∫ z,φ z*r ε z) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro n r hr hp hs φ hφ
  apply Metric.tendsto_nhds.mpr
  intro e he
  obtain ⟨δ,hδ,hφδ⟩ := Metric.continuousAt_iff.mp hφ.continuousAt (e/2) (by positivity)
  obtain ⟨η,hη,hsη⟩ := hs δ hδ
  filter_upwards [Ioo_mem_nhdsGT hη] with ε hε
  have hd := (hp ε hε.1).1
  have hmass := (hp ε hε.1).2
  have hb : ∀ z,‖(φ z-φ 0)*r ε z‖ ≤ (e/2)*r ε z := by
    intro z
    by_cases hz : r ε z=0
    · simp [hz]
    · have hzball := hsη ε hε (show z ∈ Function.support (r ε) from hz)
      have heφ := hφδ (by simpa only [Metric.mem_ball] using hzball)
      simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hd.2.1 z),Real.dist_eq] using
        mul_le_mul_of_nonneg_right heφ.le (hd.2.1 z)
  have hdiff : Integrable (fun z => (φ z-φ 0)*r ε z) volume := by
    apply Integrable.mono' (hd.2.2.const_mul (e/2))
    · exact ((hφ.sub continuous_const).mul (hr ε hε.1)).measurable.aestronglyMeasurable
    · exact ae_of_all _ hb
  have hpr : Integrable (fun z => φ z*r ε z) volume := by
    convert hdiff.add (hd.2.2.const_mul (φ 0)) using 1
    funext z
    change φ z*r ε z=(φ z-φ 0)*r ε z+φ 0*r ε z
    ring
  have hi : (∫ z,(φ z-φ 0)*r ε z)=(∫ z,φ z*r ε z)-φ 0 := by
    simp_rw [sub_mul]
    rw [integral_sub hpr (hd.2.2.const_mul (φ 0)),integral_const_mul,hmass,mul_one]
  have hle := norm_integral_le_of_norm_le (hd.2.2.const_mul (e/2)) (ae_of_all _ hb)
  rw [integral_const_mul,hmass,mul_one,hi] at hle
  rw [dist_eq_norm]
  exact hle.trans_lt (by linarith)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracApproximation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。 | [EXTRA] |

[EXTRA] [EXTRA]实际连续概率密度（原句未写非负，补非负或需统一L¹界）；supp→0解释为闭支持最终在任意零点邻域中，本谓词对非零点支撑的包含和其闭包收缩等价。保留集合supp，不误写函数sup；正ε单侧极限。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；已读取并展开 Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean（5315–5348行）：E n = EuclideanSpace ℝ (Fin n)；density ρ = Measurable ρ ∧ (∀ z,0 ≤ ρ z) ∧ Integrable ρ volume；probabilityDensity ρ = density ρ ∧ (∫ z,ρ z)=1；schwartzSpace n = SchwartzMap (E n) ℝ；diracAction φ = φ 0；diracMeasure n = Measure.dirac 0；gaussianDelta ε z = Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)。 量词顺序为任意维数、任意参数族，依次给出正参数下连续性、概率密度资格及统一最终支撑收缩，最后对每个连续测试函数断言 ε→0+ 的积分收敛到 φ(0)。Function.support 是非零点集合；对所有 δ>0 的该收缩条件与闭支持收缩等价（先用 δ/2）。连续测试函数虽可全局无界，但最终支持位于零点附近，局部有界足以保证乘积可积。非负性是明确披露、合理的 [EXTRA]；原文只列质量1与支撑收缩，若允许带符号函数，其推论不成立。例如取非负偶光滑紧支撑概率密度 b，令 rε(x)=ε⁻¹b(x/ε)+ε⁻²b((x−2ε)/ε)−ε⁻²b((x+2ε)/ε)，则质量1、支持收缩，而对在零附近等于 x 的光滑紧支撑 φ，积分最终等于4而 φ(0)=0。统一 L¹ 界可作为非负性的替代条件；当前签名已作显式修补，不应把这一修补回写为原书已有假设。无 [ERRATUM?] 标签。 签名语义与证明状态分别判断：已读 Ch05.lean 对应声明及其证明块，本条无 sorry/admit；本轮只读语义审计，没有运行 Lean 编译，PASS 不表示编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracApproximation`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L711)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDelta · definition · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $`\{d_\varepsilon\}`$, such as, in one dimension,

$$
d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def gaussianDelta (ε z : ℝ) := Real.exp (-z^2/(2*ε))/Real.sqrt (2*Real.pi*ε)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDelta` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；参数 ε、z 均为实数，Real.exp (−z²/(2ε))/Real.sqrt (2*pi*ε) 与原式仅相差乘法因子次序。作为函数的总化定义允许所有 ε；其概率或逼近单位元含义只在 ε>0 下使用，已由 context\_notation 说明，并由条目5、6分别审校。高斯对 ε>0 的支撑是全实线；原页用 Alternatively 引入另一种近似族，并未把紧支撑收缩作为本定义的条件。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDelta`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L752)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-DiracEvaluates · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> $`\langle\delta,\phi\rangle=\int\delta(z)\phi(z)d\omega=\phi(0)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem diracEvaluates : ∀ n (φ : MolecularDynamics.Chapter05Review.schwartzSpace n),
  (∫ z,φ z ∂(MolecularDynamics.Chapter05Review.diracMeasure n))=MolecularDynamics.Chapter05Review.diracAction φ := by
  intro n φ
  simp [MolecularDynamics.Chapter05Review.diracMeasure,MolecularDynamics.Chapter05Review.diracAction]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.diracEvaluates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀ n 和 ∀ 实值 Schwartz φ 的量化完整。diracMeasure n 展开为 E n 上的 Measure.dirac 0，diracAction φ 展开为 φ 0，故结论是真实 Dirac 测度积分等于在原点取值。δ 处的书面形式积分被正确解释为测度／分布配对，没有把 δ 换成普通 Lebesgue 密度。Schwartz 是前页给出的可选测试空间；无附加可积性假设，也没有漏掉右端的取值结论。

### 7. 状态与证明位置

self-contained；`MD.Ch05.diracEvaluates`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L755)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDeltaProbability · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $`\{d_\varepsilon\}`$, such as, in one dimension,

$$
d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianDeltaProbability : ∀ ε : ℝ,0 < ε →
  (∀ x : ℝ,0 ≤ MolecularDynamics.Chapter05Review.gaussianDelta ε x) ∧ Integrable (MolecularDynamics.Chapter05Review.gaussianDelta ε) volume ∧
  (∫ x,MolecularDynamics.Chapter05Review.gaussianDelta ε x)=1 := by
  intro ε hε
  have he0 : ε ≠ 0 := ne_of_gt hε
  have hcoef : 0 < (1 : ℝ)/(2*ε) := by positivity
  have heq : MolecularDynamics.Chapter05Review.gaussianDelta ε=
      (fun x : ℝ => Real.exp (-(1/(2*ε))*x^2)/Real.sqrt (2*Real.pi*ε)) := by
    funext x
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    congr 2
    ring
  rw [heq]
  refine ⟨fun x => by positivity,?_,?_⟩
  · exact (integrable_exp_neg_mul_sq hcoef).div_const _
  · rw [integral_div,integral_gaussian]
    have hp0 : 0 ≤ 2*Real.pi*ε := by positivity
    have hratio : Real.pi/(1/(2*ε))=2*Real.pi*ε := by field_simp
    rw [hratio,div_self (ne_of_gt (Real.sqrt_pos.2 (by positivity)))]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDeltaProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。 | [EXTRA] |

[EXTRA] [EXTRA]ε>0，完整真实概率密度资格另列；定义没有替代归一化证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；声明对每个实 ε，在 0<ε 的明确条件下，同时断言对所有实 x 的非负性、相对于实线 Lebesgue 体积的可积性以及完整全空间积分等于1。依赖 gaussianDelta 的指数为 −x²/(2ε)，归一化为 √(2πε)；这是真实的方差 ε 高斯密度。三个概率密度资格都在结论里，未由总化定义或预设积分等于1替代。[EXTRA] 的正参数条件必要且合理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDeltaProbability`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L762)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.1-GaussianDeltaWeak · unnumbered_claim · 印刷p.189 / PDFp.210

### 2. 原文陈述

> Alternatively, one may use a sequence of smooth functions $`\{d_\varepsilon\}`$, such as, in one dimension,

$$
d_\varepsilon=\frac1{\sqrt{2\varepsilon\pi}}\exp\left(-\frac{z^2}{2\varepsilon}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussianDeltaWeak : ∀ φ : ℝ → ℝ,Continuous φ → Bornology.IsBounded (range φ) →
  Tendsto (fun ε : ℝ => ∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (𝓝[>] 0) (𝓝 (φ 0)) := by
  intro φ hφ hb
  have hg := gaussianDeltaProbability 1 (by norm_num)
  obtain ⟨C,hC,hBC⟩ := hb.exists_pos_norm_le
  have ht : Tendsto (fun ε : ℝ => ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (𝓝[>] 0) (𝓝 (φ 0)) := by
    have hc := tendsto_integral_filter_of_dominated_convergence
      (fun x : ℝ => C*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (F:=fun ε x => φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (f:=fun x => φ 0*MolecularDynamics.Chapter05Review.gaussianDelta 1 x)
      (Filter.Eventually.of_forall (fun ε => by
        apply Continuous.aestronglyMeasurable
        unfold MolecularDynamics.Chapter05Review.gaussianDelta
        fun_prop))
      (Filter.Eventually.of_forall (fun ε => ae_of_all _ (fun x => by
        simpa only [norm_mul,Real.norm_eq_abs,abs_of_nonneg (hg.1 x)] using
          mul_le_mul_of_nonneg_right (hBC (φ (Real.sqrt ε*x)) (mem_range_self _)) (hg.1 x))))
      (hg.2.1.const_mul C) (ae_of_all _ (fun x => by
        have hs : Tendsto (fun ε : ℝ => Real.sqrt ε*x) (𝓝[>] 0) (𝓝 0) := by
          simpa using! ((Real.continuous_sqrt.tendsto 0).mono_left inf_le_left).mul_const x
        exact (hφ.tendsto 0 |>.comp hs).mul_const _))
    simpa only [integral_const_mul,hg.2.2,mul_one] using hc
  apply tendsto_congr' _ |>.2 ht
  filter_upwards [self_mem_nhdsWithin] with ε hε
  have hεpos : 0 < ε := hε
  have hspos : 0 < Real.sqrt ε := Real.sqrt_pos.2 hεpos
  have hs0 : Real.sqrt ε ≠ 0 := ne_of_gt hspos
  have hpoint (x : ℝ) : Real.sqrt ε*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)=
      MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
    unfold MolecularDynamics.Chapter05Review.gaussianDelta
    rw [mul_pow,Real.sq_sqrt hεpos.le]
    have hexp : -(ε*x^2)/(2*ε)= -x^2/2 := by field_simp
    rw [hexp,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
    simp only [mul_one]
    field_simp
  calc
    (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=
      Real.sqrt ε*(∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x)) := by
        change (∫ x,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x)=Real.sqrt ε*(∫ x,(fun y => φ y*MolecularDynamics.Chapter05Review.gaussianDelta ε y) (Real.sqrt ε*x))
        have hchange : (∫ x : ℝ,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta ε (Real.sqrt ε*x))=
            (Real.sqrt ε)⁻¹*(∫ x : ℝ,φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) := by
          simpa only [smul_eq_mul,abs_of_pos (inv_pos.mpr hspos)] using!
            (Measure.integral_comp_mul_left (fun x : ℝ => φ x*MolecularDynamics.Chapter05Review.gaussianDelta ε x) (Real.sqrt ε))
        rw [hchange]
        field_simp
    _ = ∫ x,φ (Real.sqrt ε*x)*MolecularDynamics.Chapter05Review.gaussianDelta 1 x := by
      rw [←integral_const_mul]
      apply integral_congr_ae
      filter_upwards [] with x
      rw [←hpoint]
      ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.gaussianDeltaWeak` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。 | [EXTRA] |

[EXTRA] [EXTRA]明确选择有界连续测试函数的实际概率弱极限；原“suitable test”以此资格实现，Schwartz测试也适用。全空间Gaussian没有收缩support，不用上一条support假设套用。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量化所有 φ:ℝ→ℝ，要求 Continuous φ 及 Bornology.IsBounded (range φ)，即有界连续测试函数。对真实配对 ∫φ(x)dε(x) 的结论使用 𝓝[>]0，正确表示 ε 从正侧趋于0，目标是 φ 0。它覆盖书中 Schwartz 和光滑紧支撑测试函数，并合理推广到有界连续测试；没有错误地要求高斯支撑收缩。正侧滤子、全实线积分、乘法配对及极限值均完整；[EXTRA] 没有把所求极限作为假设。

### 7. 状态与证明位置

self-contained；`MD.Ch05.gaussianDeltaWeak`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L784)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-WeakStationary · definition · 印刷p.189–190 / PDFp.210–211

### 2. 原文陈述

> We are inclined to view the steady states (equilibrium solutions) of the Liouville equation as solutions of

$$
\mathcal L_f^\dagger\rho=0.
$$


> However, this requires a little care. In general, we would like to be able to apply $`\mathcal L_f^\dagger`$ to nonsmooth distributions such as Dirac delta functions for which the application of the Liouville operator does not make obvious sense (as we have not mentioned how to differentiate delta functions). Instead we will define the stationary solution in terms of integrals against test functions.
> this suggests that the condition for the invariant probability density function $`\rho_\infty`$ should be

$$
\int_{\mathcal D}\phi\mathcal L_f^\dagger\rho_\infty\,d\omega=0,
$$


> for all suitable functions $`\phi\in C_0^\infty(\mathbb R^m)`$. We say that $`\rho_\infty`$ satisfies

$$
\mathcal L^\dagger\rho_\infty=0,
$$


> in the weak or variational sense.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def weakStationary {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) : Prop :=
  ∀ φ : testSpace n,Integrable (MolecularDynamics.Chapter05Review.lie f φ.1) μ ∧
    (∫ z,MolecularDynamics.Chapter05Review.lie f φ.1 z ∂μ)=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.weakStationary` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。 | [EXTRA] |

[EXTRA] [EXTRA]真实测度对实际测试Lie导数的零配对实现弱方程，来自形式伴随；不是把不可微分布当普通密度求导。用全空间上的测度表达，包括受限D的测度。；[EXTRA] Blueprint弱稳态接口实际量化修正后的全部C∞紧支撑测试函数，避免冻结正式库中的Cω测试类型；不修改正式库。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；testSpace n 展开后恰为所有满足 ContDiff ℝ ∞ 和 HasCompactSupport 的实函数，不是 Cω 类型。lie f φ z 是真实 fderiv ℝ φ z 作用于 f z。weakStationary 对每个这样的 φ 同时要求 lie 的 μ 可积性和积分为0，因此保留全部测试量词及非平凡弱方程；没有依赖不可积 Bochner 积分的默认0。全空间测度 μ 可取受限域 D 上密度测度的零延拓，分布伴随的边界作用由该配对保留。μ 类型允许一般正测度，是稳态方程本身的推广；若要称为原书的概率分布，还应另有 μ(univ)=1 的资格。本定义没有声称每个 weakStationary μ 都已经归一化，也未声称在任意不规则 f 下与某个流的不变性等价。

### 7. 状态与证明位置

self-contained；`MD.Ch05.weakStationary`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L840)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-EnsembleAverage · 5.6 · 印刷p.190 / PDFp.211

### 2. 原文陈述

> Let $`\phi`$ be a $`C^\infty`$ function of the phase variables with compact support and define the time $`t`$ average by

$$
\bar\phi(t)=\frac{\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\rho(\mathbf q,\mathbf p,t)\,d\omega}{\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega}.\tag{5.6}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def ensembleAverageOn {n : ℕ} (D : Set (MolecularDynamics.Chapter05Review.E n)) (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (t : ℝ) :=
  densityAverageOn D (ρ t) φ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.ensembleAverageOn` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；ensembleAverageOn 的参数完整含 n、域 D、随时间变化的 ρ:ℝ→E n→ℝ、观测函数 φ 和时刻 t。densityAverageOn 展开后为 (∫_D φ(z)ρ(t,z))/(∫_D ρ(t,z))，没有漏掉分母、域或时间参数。定义的函数类型较原书的概率密度和 C∞ 紧支撑观测函数更宽；在原书资格下恰为(5.6)。这是时刻 t 的系综平均，没有换成时间轨道平均；对总质量0或不可积输入的总化值不赋予概率平均含义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.ensembleAverageOn`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L847)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.3.2-ConvergenceHeuristic · unnumbered_claim · 印刷p.190 / PDFp.211

### 2. 原文陈述

> As the flow is Hamiltonian, $`\int_{\mathcal D}\rho(\mathbf q,\mathbf p,t)\,d\omega\equiv\int_{\mathcal D}\rho(\mathbf q,\mathbf p,0)\,d\omega`$. Thus the condition for $`\bar\phi`$ to converge is just that

$$
\int_{\mathcal D}\phi(\mathbf q,\mathbf p)\frac{\partial\rho}{\partial t}(\mathbf q,\mathbf p,t)\,d\omega\to0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem convergenceHeuristic : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → MolecularDynamics.Chapter05Review.flow f Φ → (∀ t,Φ t '' D=D) →
  (∀ t,MeasurePreserving (Φ t) volume volume) →
  ContDiff ℝ 1 (Function.uncurry ρ) → ContDiff ℝ ⊤ φ → HasCompactSupport φ →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  Tendsto (fun t => ∫ z in D,φ z*deriv (fun s => ρ s z) t) atTop (𝓝 0) →
    ∃ L : ℝ,Tendsto (ensembleAverageOn D ρ φ) atTop (𝓝 L) := by
  sorry



/-- 修正版，对应原文 MD-5.3.2-ConvergenceHeuristic。改动：导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。 -/
```

独立修正版：

```lean
theorem convergenceHeuristic_corrected (A : ℝ → ℝ)
    (_hA : ContDiff ℝ 1 A) (_hint : IntegrableOn (deriv A) (Ici (0 : ℝ))) :
    ∃ L : ℝ, Tendsto A atTop (𝓝 L) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.convergenceHeuristic`；`MD.Ch05.convergenceHeuristic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。 | [EXTRA] |

[EXTRA] [EXTRA]实际流、流不变D、原Hamiltonian背景使用的体积保持先验、平滑概率密度和紧支持测试函数明示；不替换成任意标量函数，不将最终平均收敛作假设。；[ERRATUM?] 导数趋零不蕴含函数收敛；修正版对真实观测平均A显式采用一阶连续可微及导数在正半轴绝对可积的充分条件。将A实例化为原平均仍需积分换导资格，单列覆盖缺口。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮依补充规则采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义：EuclideanSpace ℝ (Fin n) 是欧氏 ℝⁿ，volume 是标准 Lebesgue 测度，积分是 Bochner 积分（不可积时为 0），受限测度、可测性、可积性、紧支撑、光滑性和极限均按标准含义解释；不在 Ch05\_deps.txt 寻找 Mathlib 定义体，不因其未收录而判材料不足。本次仅使用与 input\_sha256 一致的三个附件；不使用其他旧 Ch0x.lean 或 ch0x\_source.json。核对 Ch05.lean:707–716，并展开项目 flow、measurePropagator 以及本文件的 densityOn、probabilityDensityOn、densityMeasureOn、densityAverageOn。flow 含 Φ0=id、实时间群律及每条轨道的真实 ODE 导数；measurePropagator 是 Measure.map；densityOn 是受限体积下的可测、非负、可积资格，probabilityDensityOn 另含 ∫_Dρ=1；densityMeasureOn 是 (volume.restrict D).withDensity(ofReal ρ)；densityAverageOn 是实际积分商。标准定义足以确认这些对象，无缺失 Mathlib 定义问题。量词先给 n,D,f,Φ,ρ,φ，前提为零可测 D、真实流、D 流不变、每个 Φt 保体积、联合 C¹ 密度、C∞ 紧支撑 φ、各时刻实际概率密度及从初始测度的真实输运；最后假设导数配对趋零，并得依赖 φ 的某个平均极限。[EXTRA] 域不变、输运与保体积均合理，未假设最终平均收敛。质量等式可由各时刻概率归一化直接读出，两端都是 1，不因其未重复列在结论而判失败。保留 FAIL 的具体原因是 statement\_scope 的完整条件措辞：“the condition ... is just that”的条件读法包含必要方向，当前签名只有导数配对趋零 ⇒ 平均收敛；缺少反向，而且没有在映射中登记为单向子命题。原文未写显式 iff，这一范围问题不能通过默认把“condition”缩成充分性来静默消除；若采用这种作者解释，需明确登记缩窄范围。此 FAIL 不表示目前充分方向在上述动力学背景中为假，也不依据 Mathlib 缺失。一般标量导数趋零却不收敛的例子不是满足该签名全部前提的反例。证明体为 sorry，单独记录，不用于决定语义 verdict；无 [ERRATUM?] 标注。

### 7. 状态与证明位置

incomplete；`MD.Ch05.convergenceHeuristic`：未证（原书疑误不证）；`MD.Ch05.convergenceHeuristic_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L853)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

