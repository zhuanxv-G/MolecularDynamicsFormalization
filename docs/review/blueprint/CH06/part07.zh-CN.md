[上一部分](part06.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part08.zh-CN.md)

## MD-6.3.4-OverdampedLimit

印刷p.240 / PDFp.261；§6.3.4。

### 1. 原文陈述

> This is also sometimes referred to as Brownian dynamics or Smoluchowski dynamics. The transition from Langevin to Brownian dynamics is typically referred to as the “Kramers to Smoluchowski limit.”

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem overdampedLimit : ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (B : ℝ≥0 → Ω → (Fin n → ℝ)) (m : Fin n → ℝ)
    (U : (Fin n → ℝ) → ℝ) (β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ))
    (X : ℝ → ℝ → Ω → ((Fin n → ℝ) × (Fin n → ℝ))) (q : ℝ → Ω → (Fin n → ℝ)),
  textbookIsWienerVector B P → (∀ i, 0 < m i) → ContDiff ℝ ∞ U →
  textbookUnitPeriodicPotential U → 0 < β →
  (∀ γ : ℝ, 0 < γ → MolecularDynamics.Chapter06Review.langevinMassSDE P
    (fun t sample ↦ B t.toNNReal sample) (X γ) m U γ β⁻¹ x0) →
  MolecularDynamics.Chapter06Review.brownianMassSDE P (fun t sample ↦ B t.toNNReal sample) q m U 1 β⁻¹ x0.1 →
  ∀ T : ℝ, 0 < T → ∀ f : (Fin n → ℝ) → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun γ : ℝ ↦ ∫ sample, f (X γ (γ*T) sample).1 ∂P) atTop
      (𝓝 (∫ sample, f (q T sample) ∂P)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部正对角质量、正β、光滑周期U，原热浴路径模型；高γ需按γT观察，完整任意有界连续检验弱极限，没有把极限本身作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意维正m、β>0、光滑单位周期势U，固定确定初始相点；B为共同n维Wiener。前提对所有γ>0给Chapter06Review.langevinMassSDE解族，q满足该命名空间brownianMassSDE且摩擦参数1、温度β⁻¹。结论仅在每个T>0对所有有界连续位置检验f有期望弱收敛，观察时间γT正确，未主张路径强收敛。核对了所引用的是项目Review模型，而非同名MD加强定义；在光滑周期势下梯度有界且Lipschitz，路径连续性使实际漂移积分有意义。周期、光滑、时间重标度和弱拓扑限制均已由[EXTRA]披露。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.overdampedLimit` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1551`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.5-ScalarGenerator

印刷p.240 / PDFp.261；§6.3.5。

### 1. 原文陈述

> where $`\mathcal L`$ is a linear operator, called the generator of the stochastic process, defined by

$$
\mathcal L\phi(x)=\left(a(x)\frac d{dx}+\tfrac12 b^2(x)\frac{d^2}{dx^2}\right)\phi(x).\tag{6.38}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def scalarGenerator (a b f : ℝ → ℝ) (x : ℝ) : ℝ := a x*deriv f x + b x^2/2*deriv (deriv f) x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意实函数a/b/f及实x，a(x)f′(x)+b(x)²f″(x)/2与原生成元动作完全对应，括号和平方位置正确。对非光滑函数deriv有总定义，但这里是形式算子定义，不含错误的对任意函数经典可微性断言；经典解释取C²测试函数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1566`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.5-GeneratorExpectation

印刷p.240 / PDFp.261；§6.3.5。

### 1. 原文陈述

> Then, taking the expectation of the Itô-Doeblin formula (6.17) we find

$$
\mathbb E\{d\phi(X)\}=\mathbb E\{\phi'(X)a(X)\}dt+\tfrac12\mathbb E\{\phi''(X)b(X)^2\}dt =\mathbb E\{(\mathcal L\phi)(X)\}dt.\tag{6.37}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem generatorExpectation :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (a b φ : ℝ → ℝ) (x0 : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  ContDiff ℝ 1 a → ContDiff ℝ 1 b → ContDiff ℝ 2 φ → MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample)) →
  (∀ t : ℝ, 0 ≤ t → Integrable (fun sample ↦ MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample)) P) →
  ContinuousOn (fun t ↦ ∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) (Ici 0) →
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) →
  Measurable (Function.uncurry X) →
  (∀ T : ℝ, 0 ≤ T → Integrable
    (fun w : ℝ × Ω ↦ |MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X w.1 w.2)|)
    ((volume.restrict (Icc 0 T)).prod P)) →
  ∀ t : ℝ, 0 < t → HasDerivAt (fun s ↦ ∫ sample, φ (X s sample) ∂P)
    (∫ sample, MolecularDynamics.Chapter06Review.scalarGenerator a b φ (X t sample) ∂P) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实严格SDE、C²φ、适应平方可积资格、Lφ实际可积且时间期望连续；完整期望时间导数，不只定义L。
- [EXTRA]自然Wiener历史适应、联合可测X、C¹a/b及Lφ在每个有限时间×样本上的绝对可积资格，保证实际Fubini；有符号期望连续不自动蕴含此资格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：完整量化样本测度、W/X、a/b/φ、确定x0；前提为PreBrownian、实际strictScalarSDE、C¹a/b、C²φ、φ′(X)b(X)自然历史适应且平方时间可积、每时刻Lφ可积、期望连续、X自然历史适应/联合可测，以及每个有限时间×样本上|Lφ|可积。结论为每个t>0期望函数的HasDerivAt，导数等于E[Lφ(Xt)]。Fubini和去随机积分期望所需范围已作为[EXTRA]披露，没有把所求导数或弱PDE当作前提。严格SDE给实际积分残差，结论强于只定义L而未偷换对象。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.generatorExpectation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1571`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-PolynomialSmooth

印刷p.241 / PDFp.262；§6.3.6。

### 1. 原文陈述

> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $`C^\infty`$ smooth and satisfy the polynomial growth restriction by $`C_P^\infty`$:

$$
C_P^\infty\stackrel{\mathrm{def}}=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def polynomialSmooth (f : ℝ → ℝ) : Prop :=
  ContDiff ℝ ∞ f ∧ ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |f x| ≤ C*(1+|x|)^r
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：ContDiff ℝ ∞ f且存在统一C≥0、自然r、∀x的|f(x)|≤C(1+|x|)^r。光滑函数在紧区间有界，因此该全局界与原双侧无穷处Big-O等价。没有擅自把C\_P∞强化为所有阶导数都多项式增长。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.polynomialSmooth` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1589`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-DensityExpectation

印刷p.241 / PDFp.262；§6.3.6。

### 1. 原文陈述

> For any $`\phi\in C_P^\infty`$, the expectation with respect to $`\rho(x,t)`$ is well defined and we have

$$
\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem densityExpectation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (X : Ω → ℝ) (ρ φ : ℝ → ℝ),
  HasLaw X (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ x))) P →
  (∀ x, 0 ≤ ρ x) → Measurable ρ → MolecularDynamics.Chapter06Review.polynomialSmooth φ →
  (∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x, ρ x ≤ C*Real.exp (-c*|x|)) →
  Integrable (fun sample ↦ φ (X sample)) P ∧
    (∫ sample, φ (X sample) ∂P)=(∫ x, φ x*ρ x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实非负可测density与全局指数尾界；完整可积与积分law等式，不预置这些结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：HasLaw把真实X分布与volume.withDensity(ofRealρ)关联，额外ρ非负且可测，φ取D49（函数值多项式增长），ρ有全局正指数尾上界。无需假设导数增长即可得|φ|ρ可积；结论同时给样本上的Integrable和与∫φρ相等，乘积顺序无影响。指数尾和多项式界控制实轴尾部，law桥接真实随机变量，不把积分恒等作前提。[EXTRA]准确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.densityExpectation` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1594`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-ScalarForward

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> In the case at hand the adjoint is

$$
\mathcal L^\dagger\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx},
$$


> which we shall refer to as the Kolmogorov operator.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def scalarForward (a b ρ : ℝ → ℝ) (x : ℝ) : ℝ :=
  -deriv (fun z ↦ a z*ρ z) x + deriv (deriv (fun z ↦ b z^2*ρ z)) x/2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意实函数a/b/ρ及实x，−(aρ)′+(b²ρ)″/2完整正确。形式定义没有把ρ′′误写为φ′′，也没有带入条目23虚构的负扩散号。经典含义需相应可微性，此定义没有宣称PDE已从law推出。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarForward` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1604`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPDriftAdjoint

印刷p.241–242 / PDFp.262–263；§6.3.6。

### 1. 原文陈述

> First, we find

$$
\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{+\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx =-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpDriftAdjoint :
  ∀ (a ρ φ : ℝ → ℝ),
  ContDiff ℝ 1 a → ContDiff ℝ 1 ρ → ContDiff ℝ 1 φ →
  HasCompactSupport φ → (∫ x, a x*deriv φ x*ρ x) = ∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x) := by
  intro a ρ φ ha hρ hφ hc
  have hg : ContDiff ℝ 1 (fun x ↦ a x*ρ x) := ha.mul hρ
  have hi1 : Integrable (fun x ↦ (a x*ρ x)*deriv φ x) :=
    (hg.continuous.mul hφ.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.mul_left
  have hi2 : Integrable (fun x ↦ deriv (fun z ↦ a z*ρ z) x*φ x) :=
    (hg.continuous_deriv_one.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have hi3 : Integrable (fun x ↦ (a x*ρ x)*φ x) :=
    (hg.continuous.mul hφ.continuous).integrable_of_hasCompactSupport hc.mul_left
  have he := MeasureTheory.integral_mul_deriv_eq_deriv_mul_of_integrable
    (u := fun x ↦ a x*ρ x) (v := φ)
    (fun x _ ↦ (hg.differentiable_one x).hasDerivAt)
    (fun x _ ↦ (hφ.differentiable_one x).hasDerivAt) hi1 hi2 hi3
  simpa only [Pi.mul_apply, mul_comm, mul_left_comm, mul_assoc, mul_neg, integral_neg] using he
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]当前完整紧支撑C¹检验桥接；原指数尾和多项式检验的全域版本在FPPolynomialAdjoint保留，不将紧支撑特例计为原全部检验已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：∀a/ρ/φ为C¹，且φ紧支；左积分aφ′ρ，右积分φ[−(aρ)′]，全实轴真实积分相等。紧支和C¹使两边连续紧支、可积，边界自动消失；未要求a或ρ紧支。仅证明[EXTRA]明示的紧支桥接，不能计为原所有多项式测试函数的全域版本。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpDriftAdjoint` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1609`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPDiffusionPrinted

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> With two rounds of integration by parts on the term involving $`b(x)`$, we find, using the fact that the boundary terms vanish,

$$
\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpDiffusionPrinted : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  intro b ρ φ hb hρ hφ hc
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have h1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have h2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  calc
    _ = (∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
      apply integral_congr_ae
      filter_upwards [] with x
      ring
    _ = _ := by
      rw [h1,h2,neg_neg]
      apply integral_congr_ae
      filter_upwards [] with x
      ring



/-- 原页本为正号；此同义_corrected名称为兼容保留，不是原书勘误。 -/
theorem fpDiffusionPrinted_corrected : ∀ (b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ → HasCompactSupport φ →
  (∫ x, b x^2*deriv (deriv φ) x*ρ x)=
    (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
  intro b ρ φ hb hρ hφ hc
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have h1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have h2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  calc
    _ = (∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
      apply integral_congr_ae
      filter_upwards [] with x
      ring
    _ = _ := by
      rw [h1,h2,neg_neg]
      apply integral_congr_ae
      filter_upwards [] with x
      ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧\_corrected名字仅兼容保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] PDF263/印刷242已目视核对：两次分部积分右端是正号并含(x,t)。删除错误外负号，Printed使用已有独立分部积分证明；撤销虚假原书疑误，旧\_corrected名字仅兼容保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。fpDiffusionPrinted与\_corrected同签名：b,ρ,φ为C²，φ紧支撑，则∫b²φ″ρ=∫φ(b²ρ)″。将时间固定后ρ为实函数符合原式；紧支撑φ及其导数消除边界项，C²使各紧支 integrand可积。没有外负号，亦没有在该纯扩散分部积分恒等式中额外放1/2。两版PASS；_corrected只是兼容同义名，不是原书勘误。fpDriftAdjoint的C¹紧支辅助式负号也正确。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpDiffusionPrinted` | 已证 | — | PASS |
| `MD.Ch06.fpDiffusionPrinted_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1629`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPAdjointCompact

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> where the operator appearing on the right hand side is the adjoint $`\mathcal L^\dagger`$ of the generator of the stochastic process, satisfying the relation

$$
\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.
$$


> In the case at hand the adjoint is

$$
\mathcal L^\dagger\rho=-(a(x)\rho)_x+\tfrac12(b^2(x)\rho)_{xx},
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpAdjointCompact :
  ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ 2 a → ContDiff ℝ 2 b → ContDiff ℝ 2 ρ → ContDiff ℝ 2 φ →
  HasCompactSupport φ → (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x) = ∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x := by
  intro a b ρ φ ha hb hρ hφ hc
  have ha1 : ContDiff ℝ 1 a := ha.of_le (by norm_num)
  have hρ1 : ContDiff ℝ 1 ρ := hρ.of_le (by norm_num)
  have hφ1 : ContDiff ℝ 1 φ := hφ.of_le (by norm_num)
  have hG : ContDiff ℝ 2 (fun x ↦ b x^2*ρ x) := (hb.pow 2).mul hρ
  have hG1 : ContDiff ℝ 1 (fun x ↦ b x^2*ρ x) := hG.of_le (by norm_num)
  have ibp : ∀ (g f : ℝ → ℝ), ContDiff ℝ 1 g → ContDiff ℝ 1 f → HasCompactSupport f →
      (∫ x, g x*deriv f x)=-(∫ x, deriv g x*f x) := by
    intro g f hg hf hs
    have he := fpDriftAdjoint g (fun _ ↦ 1) f hg contDiff_const hf hs
    simpa only [mul_one, mul_neg, integral_neg, mul_comm] using he
  have hh1 := ibp (fun x ↦ b x^2*ρ x) (deriv φ) hG1 hφ.deriv' hc.deriv
  have hh2 := ibp (deriv (fun x ↦ b x^2*ρ x)) φ hG.deriv' hφ1 hc
  have hdiff : (∫ x, (b x^2*ρ x)*deriv (deriv φ) x)=
      (∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [hh1, hh2, neg_neg]
    congr 1
    funext x
    ring
  have hD := fpDriftAdjoint a ρ φ ha1 hρ1 hφ1 hc
  have hiA : Integrable (fun x ↦ a x*deriv φ x*ρ x) :=
    ((ha.continuous.mul hφ1.continuous_deriv_one).mul hρ.continuous).integrable_of_hasCompactSupport hc.deriv.mul_left.mul_right
  have hiB : Integrable (fun x ↦ (b x^2*ρ x)*deriv (deriv φ) x) :=
    (hG.continuous.mul hφ.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.deriv.deriv.mul_left
  have hiC : Integrable (fun x ↦ φ x*(-deriv (fun z ↦ a z*ρ z) x)) :=
    (hφ.continuous.mul (ha1.mul hρ1).continuous_deriv_one.neg).integrable_of_hasCompactSupport hc.mul_right
  have hiE : Integrable (fun x ↦ φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) :=
    (hφ.continuous.mul hG.deriv'.continuous_deriv_one).integrable_of_hasCompactSupport hc.mul_right
  have hleft : (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
      (∫ x, a x*deriv φ x*ρ x)+(1/2 : ℝ)*(∫ x, (b x^2*ρ x)*deriv (deriv φ) x) := by
    rw [← integral_const_mul, ← integral_add hiA (hiB.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarGenerator]
    ring
  have hright : (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x)=
      (∫ x, φ x*(-deriv (fun z ↦ a z*ρ z) x))+
        (1/2 : ℝ)*(∫ x, φ x*deriv (deriv (fun z ↦ b z^2*ρ z)) x) := by
    rw [← integral_const_mul, ← integral_add hiC (hiE.const_mul (1/2))]
    apply integral_congr_ae
    filter_upwards [] with x
    dsimp [MolecularDynamics.Chapter06Review.scalarForward]
    ring
  rw [hleft, hright, hD, hdiff]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]紧支撑C²检验的完整正号伴随恒等；多项式检验及指数尾版本另条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：对任意C² a/b/ρ/φ和紧支φ，真实全实轴∫(Lφ)ρ=∫φ(L†ρ)。D47/D50展开后正确，紧支使全部相关积分存在；紧支C²范围已在[EXTRA]明示，不把它计作所有C\_P∞测试的完整伴随域结论。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpAdjointCompact` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1686`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPPolynomialAdjoint

印刷p.241–242 / PDFp.262–263；§6.3.6。

### 1. 原文陈述

> We assume that $`\rho`$ is $`C^\infty`$ for all $`t`$ and that the density tends to zero exponentially fast as $`x\to\pm\infty`$, whereas $`a`$ and $`b`$ are $`C^\infty`$ functions which grow at most polynomially fast in these limits, that is, there are constants $`\eta_a`$, $`\eta_b`$ such that

$$
a(x)=\mathcal O(|x|^{\eta_a}),\quad b(x)=\mathcal O(|x|^{\eta_b}),\quad x\to\pm\infty.
$$


> This condition of polynomial growth of the coefficients is a common assumption in the analysis of SDEs. For future reference we define the space of functions which are $`C^\infty`$ smooth and satisfy the polynomial growth restriction by $`CP^\infty`$:

$$
CP^\infty=\{\phi\in C^\infty\mid\exists\eta\in\mathbb N:\phi(x)=O(|x|^\eta),\ x\to\pm\infty\}.
$$


> For any $`\phi\in CP^\infty`$, the expectation with respect to $`\rho(x,t)`$ is well defined and we have

$$
\mathbb E\phi(X(t))=\langle\phi,\rho\rangle=\int_{-\infty}^{+\infty}\phi(x)\rho(x,t)dx.
$$


> Taking the differential, we obtain an equation for $`\mathbb E d\phi`$ which must be equal to (6.37):

$$
\int_{-\infty}^{+\infty}\phi(x)\frac{\partial\rho}{\partial t}dx=\int_{-\infty}^{+\infty}(\mathcal L\phi)(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}(a(x)\phi'+\tfrac12 b^2(x)\phi''(x))\rho(x,t)dx.
$$


> Using the assumptions given above regarding the exponential rate of decay of the density, it is possible to recast the right hand side as an integral of a product with $`\phi`$. First, we find

$$
\int_{-\infty}^{+\infty}a(x)\phi'(x)\rho(x,t)dx=[\phi(x)a(x)\rho(x,t)]_{-\infty}^{\infty}-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx=-\int_{-\infty}^{+\infty}\phi(x)(a(x)\rho(x,t))_x dx.
$$


> With two rounds of integration by parts on the term involving $`b(x)`$, we find, using the fact that the boundary terms vanish,

$$
\int_{-\infty}^{+\infty}b^2(x)\phi''(x)\rho(x,t)dx=\int_{-\infty}^{+\infty}\phi(x)(b^2(x)\rho)_{xx}(x,t)dx.
$$


> Finally, putting these results together, we have

$$
\int_{-\infty}^{+\infty}\phi(x)\left[\frac{\partial\rho}{\partial t}+\frac{\partial}{\partial x}(a(x)\rho(x,t))-\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho)\right]dx=0.
$$


> If this is to hold for all test functions $`\phi`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\frac{\partial}{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).
$$


> This partial differential equation is often called the Fokker-Planck equation. The great benefit of the Fokker-Planck equation is that it enables the macroscopic perspective on the solutions of an SDE.
> The Fokker-Planck equation may be written in the compact form

$$
\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho,
$$


> where the operator appearing on the right hand side is the adjoint $`\mathcal L^\dagger`$ of the generator of the stochastic process, satisfying the relation

$$
\langle\mathcal L\phi,\rho\rangle=\langle\phi,\mathcal L^\dagger\rho\rangle.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpPolynomialAdjoint : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- 修正版，对应原文 MD-6.3.6-FPPolynomialAdjoint；改动：显式约束所需导数的多项式增长和密度导数的指数衰减。 -/
theorem fpPolynomialAdjoint_corrected : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k ≤ 2 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k ≤ 2 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry

/-- 【原书疑误】仅函数值增长条件的字面伴随断言；不证。 -/
theorem fpPolynomialAdjointPrinted : ∀ (a b ρ φ : ℝ → ℝ),
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiff ℝ ∞ ρ → ContDiff ℝ ∞ φ →
  (∀ f ∈ ({a,b,φ} : Set (ℝ → ℝ)), ∀ k : ℕ, k = 0 →
    ∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |iteratedDeriv k f x| ≤ C*(1+|x|)^r) →
  (∀ k : ℕ, k = 0 → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧ ∀ x,
    |iteratedDeriv k ρ x| ≤ C*Real.exp (-c*|x|)) →
  (∫ x, MolecularDynamics.Chapter06Review.scalarGenerator a b φ x*ρ x)=
    (∫ x, φ x*MolecularDynamics.Chapter06Review.scalarForward a b ρ x) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原C∞P值增长不足以控制所有IBP边界；明确一、二阶a,b,φ多项式增长及ρ导数指数尾，保存整个非紧支撑真实积分恒等。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。fpPolynomialAdjoint及\_corrected：a,b,ρ,φ为C∞；a,b,φ的0至2阶导数逐阶有全局多项式界，ρ的0至2阶导数逐阶有正指数尾；这些明确加强条件保证真正非紧支撑积分可积与所需边界消失，scalarGenerator=aφ′+b²φ″/2、scalarForward=-(aρ)′+(b²ρ)″/2，签名正确。fpPolynomialAdjointPrinted只约束k=0的函数值，忠实于原书CP∞和密度衰减，不能据此控制导数、边界或积分；Printed保留NEEDS\_HUMAN。原文并未证明任意此类测试函数的Lφ可积，不能让Bochner总化积分掩盖问题。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpPolynomialAdjoint` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.fpPolynomialAdjoint_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.fpPolynomialAdjointPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:1739`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-FPEquation

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> If this is to hold for all test functions $`\phi`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\frac\partial{\partial x}(a(x)\rho)+\frac12\frac{\partial^2}{\partial x^2}(b^2(x)\rho).
$$


> The Fokker-Planck equation may be written in the compact form

$$
\frac{\partial\rho}{\partial t}=\mathcal L^\dagger\rho.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem fpEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ) (x0 : ℝ) (ρ : ℝ → ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  strictScalarSDE P W X (fun x _ ↦ a x) (fun x _ ↦ b x) x0 →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ b (X t sample)) →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ b → ContDiffOn ℝ ∞ (Function.uncurry ρ) {z : ℝ × ℝ | 0 < z.1} →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧
    HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ r : ℕ, ∀ x, |a x|+|b x| ≤ C*(1+|x|)^r) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*|x|)) →
  ∀ t x : ℝ, 0 < t → deriv (fun s ↦ ρ s x) t=MolecularDynamics.Chapter06Review.scalarForward a b (ρ t) x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。
- 覆盖缺口：严格网格积分关系到通常适应Itô解、以及一般Fokker–Planck推导尚缺证明；不将单文件编译当作这些桥接已完成。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。fpEquation的P、W,X、a,b、确定初态x0及ρ(t,x)量词、自然历史适应与联合可测X、扩散平方可积、真实正密度HasLaw、多项式值界及正时间紧窗一致指数尾均已核对；结论是每t>0、每x的经典PDE，scalarForward系数正确，未把目标PDE设为前提。但ContDiff ℝ ∞ (Function.uncurry ρ)要求ρ在包括t=0的整个ℝ²光滑，同时strictScalarSDE要求X0=x0且AE路径在0连续，HasLaw对所有t>0成立。这使整组前提不可能：连续初态的边际趋δ\_x0，而跨t=0连续的Lebesgue密度在小紧矩形有一致界，不能产生该原子极限。因此该签名是空泛的加强，并非原书“给定初始密度”的FP陈述，判FAIL；与sorry无关。仅补适应性不能修复时间域和初始法则。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
密度联合光滑性只要求在(0,∞)×ℝ，保留确定初态及正时刻密度；不再要求密度跨t=0光滑。严格网格积分解到通常适应Itô解的桥接仍未证明，PDE结论不当作前提。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.fpEquation` | 未证 | 缺大型理论 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:1775`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.6-ZeroNoise

印刷p.242 / PDFp.263；§6.3.6。

### 1. 原文陈述

> In case $`b\equiv0`$, the SDE becomes an ordinary differential equation. Then the generator $`\mathcal L`$ becomes simply the Lie derivative, and its adjoint is just the Liouvillian.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem zeroNoise :
  ∀ (a f ρ : ℝ → ℝ) (x : ℝ),
  MolecularDynamics.Chapter06Review.scalarGenerator a (fun _ ↦ 0) f x=a x*deriv f x ∧
    MolecularDynamics.Chapter06Review.scalarForward a (fun _ ↦ 0) ρ x = -deriv (fun z ↦ a z*ρ z) x := by
  intro a f ρ x
  constructor
  · simp [MolecularDynamics.Chapter06Review.scalarGenerator]
  · simp [MolecularDynamics.Chapter06Review.scalarForward]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。
- 覆盖缺口：仅覆盖生成元和前向算子的零扩散代数简化；SDE解到ODE积分方程及经典导数桥接未覆盖。

### 6. 审计结论（含网站结论）

网站原返回：PASS。zeroNoise对任意实函数a,f,ρ和任意x给两合取：scalarGenerator(a,0)f=a f′及scalarForward(a,0)ρ=-(aρ)′。展开D25、D26即得，扩散项为恒零故不需可微性前提。覆盖范围已注明只是算子代数化简，未声称SDE解成为经典ODE解，PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.zeroNoise` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1793`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-VectorIto

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> If $`\phi`$ is a scalar valued function of $`\mathbb R^m`$, and $`Z(t)`$ is the solution of the SDE system

$$
dZ=a(Z)dt+B dW;\tag{6.39}
$$


> where $`a`$ is a function in $`\mathbb R^m`$ and $`B`$ is a constant matrix, then we have

$$
d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12dW^TB^T\phi''B dW;\tag{6.40}
$$


> where $`\phi''`$ is the Hessian matrix of $`\phi`$, i.e. the matrix of second partial derivatives of $`\phi`$ with respect to pairs of the variables. In some applications $`B=B(Z)`$, in which case the SDE (6.39) is said to involve multiplicative noise (as oppose to the additive case we consider when $`B`$ is constant). For a discussion of the differences and applications of these types of noise, see [289, 324].
> All components on the right hand side of (6.40) are evaluated at $`Z(t)`$. Then using the shorthand rules $`dW_i dW_j=dt\delta_{ij}`$ (where $`\delta_{ij}`$ is one if $`i=j`$, zero otherwise), we have

$$
d\phi(Z(t))=\nabla\phi\cdot[adt+B dW]+\tfrac12\operatorname{Tr}(B^T\phi''B)dt.\tag{6.41}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem vectorIto : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (φ : (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 → ContDiff ℝ 2 φ →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω (Fin n → ℝ) (naturalHistory25 W t) inferInstance (X t)) →
  vectorGridItoQualification25 P W
    (fun j t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) →
  ∀ T : ℝ, 0 ≤ T → ∃ integrals : Fin r → Ω → ℝ,
    (∀ j, strictItoIntegral P (fun t sample ↦ W t sample j)
      (fun t sample ↦ fderiv ℝ φ (X t sample) (fun i ↦ B i j)) T (integrals j)) ∧
    (∀ᵐ sample ∂P, φ (X T sample)-φ x0-
      (∫ s in 0..T, MolecularDynamics.Chapter06Review.vectorGenerator a B φ (X s sample))=∑ j, integrals j sample) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected\_json恢复连接文本。仍缺一般多维Itô理论。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 改为共同向量自然过滤上的适应性，补X联合可测、各被积过程全部左和L²及局部均方时间资格；strictVectorSDE已含整族Wiener资格。原文相隔公式按网站corrected\_json恢复连接文本。仍缺一般多维Itô理论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。vectorIto：任意n,r、共同向量Wiener及strictVectorSDE、常n×r矩阵B、C² φ、联合可测且共同向量自然历史适应X；vectorGridItoQualification25对每列方向导数被积过程给共同历史适应、每时及每网格L²、局部均方Hölder资格。结论逐T≥0存在r个严格标量积分，且φ增量减∫vectorGenerator等于积分和AE。共同过滤不误限为各自单坐标过滤；vectorDiffusion=Σ\_ij(BBᵀ)_ij∂i∂jφ，等价Tr(Bᵀ Hess φ B)，漂移fderiv φ(a)与1/2正确。资格未预设结论，签名PASS；只审签名，不认证sorry证明。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.vectorIto` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1804`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-VectorForward

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> In the multivariate case, the density is a function of the vector describing a state of the system $`z`$ and $`t`$, and is governed by the partial differential equation

$$
\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def vectorForward {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x

/-- 修正版，对应原文 MD-6.4.2-CylinderForwardPrinted；改动：扩散项中的φ″改为ρ″。 -/
def cylinderForwardPrinted_corrected {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：任意n/r、向量漂移a、常n×r矩阵B、标量ρ及状态x；MD包装的精确项目定义为−∑i∂i(a\_iρ)+½ vectorDiffusion B ρ，D51给BBᵀ与ρ的混合二阶导数，次序和系数正确。context\_notation已明示这里只定义前向算子，不算从law证明PDE。代码块附带的cylinderForwardPrinted\_corrected是另一source\_id的别名，目标相同且无额外数学断言，不把它混算为本条证明或独立条目。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.vectorForward` | 定义 | — | PASS |
| `MD.Ch06.cylinderForwardPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1822`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-DiffusionTrace

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> The second order “diffusion” term in this expression may be expanded as

$$
\operatorname{Tr}(B^T\rho''B)=\sum_{i=1}^m\sum_{j=1}^m(BB^T)_{ij}\frac{\partial^2\rho}{\partial z_i\partial z_j}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem diffusionTrace :
  ∀ {n r : ℕ} (B : Matrix (Fin n) (Fin r) ℝ)
    (H : Matrix (Fin n) (Fin n) ℝ),
  Matrix.trace (B.transpose*H*B)=∑ i : Fin n, ∑ j : Fin n, (B*B.transpose) i j*H i j := by
  intro n r B H
  rw [Matrix.trace_mul_cycle B.transpose H B, Matrix.trace_mul_cycle B B.transpose H]
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Matrix.transpose_apply,
    Finset.mul_sum, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro k hk
  ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C：签名将Hessian抽象为任意n×n实矩阵H，B为n×r；没有额外正定或对称前提。trace(BᵀHB)=∑ij(BBᵀ)ij H\_ij对任意H成立：按矩阵乘法展开并用实数乘法交换律及BBᵀ对称性重排。包括n/r=0的空和情况。取H=ρ的Hessian即原式，强化为任意矩阵没有丢结论，也不需要用Hessian对称性作隐藏前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.diffusionTrace` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1832`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.7-VectorFPEquation

印刷p.243 / PDFp.264；§6.3.7。

### 1. 原文陈述

> In the multivariate case, the density is a function of the vector describing a state of the system $`z`$ and $`t`$, and is governed by the partial differential equation

$$
\frac{\partial\rho}{\partial t}=-\nabla\cdot(a(z)\rho(z))+\tfrac12\operatorname{Tr}(B^T\rho''B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem vectorFPEquation : ∀ {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → (Fin n → ℝ)) (B : Matrix (Fin n) (Fin r) ℝ)
    (x0 : Fin n → ℝ) (ρ : ℝ → (Fin n → ℝ) → ℝ),
  textbookIsWienerVector (fun t sample ↦ W t sample) P →
  strictVectorSDE P W X (fun x _ ↦ a x) (fun _ _ ↦ B) x0 →
  ContDiff ℝ ∞ a → ContDiff ℝ ∞ (Function.uncurry ρ) →
  (∀ t : ℝ, 0 < t → (∀ x, 0 ≤ ρ t x) ∧ HasLaw (X t) (volume.withDensity (fun x ↦ ENNReal.ofReal (ρ t x))) P) →
  (∃ C : ℝ, 0 ≤ C ∧ ∃ k : ℕ, ∀ x, ‖a x‖ ≤ C*(1+‖x‖)^k) →
  (∀ lo hi : ℝ, 0 < lo → lo ≤ hi → ∃ C c : ℝ, 0 ≤ C ∧ 0 < c ∧
    ∀ t ∈ Icc lo hi, ∀ x, |ρ t x|+|deriv (fun s ↦ ρ s x) t| ≤ C*Real.exp (-c*‖x‖)) →
  ∀ t x, 0 < t → deriv (fun s ↦ ρ s x) t=vectorForward a B (ρ t) x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实多维Wiener、严格SDE、完整非负密度law、光滑和局部尾部求导资格；没有将弱PDE结论作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。全部n个状态、r个噪声、常矩形B、确定初值和任意正时刻/空间点均保留。D2/D7/D8给出负散度及(1/2)∑(BBᵀ)ij∂ijρ，等于原迹公式。D3/D4是实际L²左和积分及路径方程，没有把PDE作前提；光滑、多项式漂移增长、局部一致指数密度/时间导数尾界均属已标[EXTRA]的充分资格。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.vectorFPEquation` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1851`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.8-LangevinMassForward

印刷p.244 / PDFp.265；§6.3.8。

### 1. 原文陈述

> In the special case of Langevin dynamics (6.32)–(6.33) for a system with $`N_c`$ configuration variables, the density is a function of the vectors of positions $`q`$, momenta $`p`$, and time, and the formula for the Kolmogorov operator becomes

$$
\mathcal L_{\rm LD}^*\rho=-\nabla_q\cdot(M^{-1}p\rho)+\nabla_p\cdot([\nabla U(q)+\gamma p]\rho)+\gamma k_BT\Delta_M\rho;\tag{6.42}
$$


> where the mass-weighted Laplacian $`\Delta_M`$ is defined as

$$
\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def langevinMassForward {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (U : MolecularDynamics.Chapter06Review.V n → ℝ) (γ β : ℝ)
    (ρ : MolecularDynamics.Chapter06Review.Phase n → ℝ) (x : MolecularDynamics.Chapter06Review.Phase n) : ℝ :=
  ∑ i, (-(m i)⁻¹*x.2 i * fderiv ℝ ρ x (Pi.single i 1,0) +
    fderiv ℝ (fun z : MolecularDynamics.Chapter06Review.Phase n ↦ (textbookConfigurationPartial U i z.1+γ*z.2 i)*ρ z) x (0,Pi.single i 1) +
    γ*β⁻¹*m i*fderiv ℝ (fun z ↦ fderiv ℝ ρ z (0,Pi.single i 1)) x (0,Pi.single i 1))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Phase n明确是全部位置和动量的乘积。对每个i，位置项为−mi⁻¹pi∂qiρ，动量项对(∂iU+γpi)ρ整体求导，扩散为γβ⁻¹mi∂pi²ρ；β⁻¹=kBT。系数不依赖q，所以位置散度展开正确。此为算子定义，无须把密度law或PDE证明混入定义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinMassForward` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1866`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.8-MomentumMassLaplacian

印刷p.244 / PDFp.265；§6.3.8。

### 1. 原文陈述


$$
\Delta_M\stackrel{\rm def}=\nabla\cdot(M\nabla)=\sum_{i=1}^{N_c}m_i\frac{\partial^2}{\partial p_i^2}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def momentumMassLaplacian {n : ℕ} (m : Fin n → ℝ)
    (ρ : ((Fin n → ℝ) × (Fin n → ℝ)) → ℝ) (x : (Fin n → ℝ) × (Fin n → ℝ)) : ℝ :=
  ∑ i, m i*fderiv ℝ (fun y ↦ fderiv ℝ ρ y (0,Pi.single i 1)) x (0,Pi.single i 1)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

无新增技术前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对所有Fin n动量方向(0,ei)作两次Fréchet导数，再以mi相乘求和，恰为原正质量权重动量Laplacian；没有误用mi⁻¹或位置方向。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.momentumMassLaplacian` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1873`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

