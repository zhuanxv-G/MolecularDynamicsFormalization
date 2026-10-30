[上一部分](part11.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part13.zh-CN.md)

## MD-6.4.4-LieBracketProperties

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> The Lie bracket is a bilinear and skew-symmetric operation:
> • $`[\alpha u+\beta v,w]=\alpha[u,w]+\beta[v,w]`$,
> • $`[u,v]=-[v,u]`$ and $`[u,u]=0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lieBracketProperties : ∀ {n : ℕ} (u v w : (Fin n → ℝ) → (Fin n → ℝ)) (a b : ℝ),
  Differentiable ℝ u → Differentiable ℝ v → Differentiable ℝ w →
  (MolecularDynamics.Chapter06Review.lieBracket (fun x ↦ a • u x+b • v x) w =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u w x+b • MolecularDynamics.Chapter06Review.lieBracket v w x) ∧
  (MolecularDynamics.Chapter06Review.lieBracket u (fun x ↦ a • v x+b • w x) =
    fun x ↦ a • MolecularDynamics.Chapter06Review.lieBracket u v x+b • MolecularDynamics.Chapter06Review.lieBracket u w x) ∧
  MolecularDynamics.Chapter06Review.lieBracket u v = -MolecularDynamics.Chapter06Review.lieBracket v u ∧
  MolecularDynamics.Chapter06Review.lieBracket u u=0 := by
  intro n u v w a b hu hv hw
  have hb : ∀ (u v : (Fin n → ℝ) → (Fin n → ℝ)),
      MolecularDynamics.Chapter06Review.lieBracket u v=VectorField.lieBracket ℝ u v :=
    fun u v ↦ rfl
  simp_rw [hb]
  refine ⟨?_,?_,?_,?_⟩
  · funext x
    change VectorField.lieBracket ℝ (a • u+b • v) w x = _
    rw [VectorField.lieBracket_add_left ((hu x).const_smul a) ((hv x).const_smul b),
      VectorField.lieBracket_const_smul_left (hu x),
      VectorField.lieBracket_const_smul_left (hv x)]
  · funext x
    change VectorField.lieBracket ℝ u (a • v+b • w) x = _
    rw [VectorField.lieBracket_add_right ((hv x).const_smul a) ((hw x).const_smul b),
      VectorField.lieBracket_const_smul_right (hv x),
      VectorField.lieBracket_const_smul_right (hw x)]
  · funext x
    exact VectorField.lieBracket_swap
  · exact VectorField.lieBracket_self
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部双槽线性、skew及自身零明确，真实全域可微资格；不只保存某一固定字段或单槽例子。

### 6. 审计结论（含网站结论）

网站原返回：PASS。两槽所有实线性组合、反对称、自括号零同时给出，字段全局可微确保导数线性；全局版本为已标注技术范围。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lieBracketProperties` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3007`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Definition61

印刷p.254 / PDFp.275；§6.4.4。

### 1. 原文陈述

> Definition 6.1 (Hörmander's Condition) Let $`U\subset\mathbb R^m`$ be open. The SDE (6.43) with $`C^\infty`$ vector fields $`b_0,b_1,\ldots,b_r:U\to\mathbb R^m`$ are said to satisfy Hörmander's condition at $`z\in U`$ if the vector space spanned by the collection of iterated Lie brackets

$$
b_0,b_1,\ldots,b_r,[b_0,b_1],[b_0,b_2],\ldots,[b_{r-1},b_r],[b_0,[b_0,b_1]],\ldots
$$


> (evaluated at $`z`$) is $`\mathbb R^m`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def definition61 {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x

/-- 修正版，对应原文 MD-6.4.4-Definition61；改动：用于密度结论时，从噪声字段开始，允许与漂移及噪声反复取括号；不把漂移本身直接加入初始生成族。 -/
def parabolicNoiseBracketLevels {m S : ℕ}
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) : ℕ → Set ((Fin m → ℝ) → (Fin m → ℝ))
  | 0 => Set.range (fun i : Fin S ↦ b i.succ)
  | k+1 => parabolicNoiseBracketLevels b k ∪
      {w | ∃ u ∈ parabolicNoiseBracketLevels b k, ∃ i : Fin (S+1),
        w=MolecularDynamics.Chapter06Review.lieBracket (b i) u}

def definition61_corrected {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧
    Submodule.span ℝ {v | ∃ k : ℕ, ∃ w ∈ parabolicNoiseBracketLevels b k, v=w x}=⊤

/-- 【原书疑误】保留原含漂移的张成条件，不能据此推出一般转移密度。 -/
def definition61Printed {m S : ℕ} (D : Set (Fin m → ℝ)) (_hD : IsOpen D)
    (b : Fin (S+1) → ((Fin m → ℝ) → (Fin m → ℝ))) (x : Fin m → ℝ) : Prop :=
  x ∈ D ∧ (∀ i, ContDiffOn ℝ ∞ (b i) D) ∧ textbookHormanderAt (Set.range b) x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]Fin(S+1)完整包含原drift b0与全部噪声，实际无限次括号及实span；明确C∞字段资格。保留原定义含b0，不冒充一般parabolic噪声生成条件；具体Langevin rank另证。
- [EXTRA]原开域U和域内点完整保留；坐标字段全空间任意总化只用于函数表示，C∞仅要求在原开域，不要求全局光滑延拓。开域内真实fderiv/全部迭代括号是局部对象。
- [EXTRA] 补textbookIteratedBracket定义体；原含漂移版仅为原书括号秩定义，密度用途必须用噪声起始的抛物型修正版。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：Definition 6.1的开域、光滑向量场、域内点、包括b0的迭代括号及实线性张成等于ℝm均准确转录，省略号保持同一完整有限生成族。C：definition61与Printed逐项保留开域D、x∈D、所有Fin(S+1)字段在D上C∞以及包括漂移b0的全部迭代Lie括号；D95不是有限深度截断，D96–D97在x处取实span=⊤。全空间总化函数只用于表示局部字段，D开且光滑性只要求ContDiffOn D，因此不要求原书没有的全局光滑延拓。Bracket符号与原文v′u−u′v一致。corrected的第0层只用b1,…,bS，后续允许与任一bᵢ取括号再取并，最后量化所有自然数层并取实span，正确区分用于正时刻密度的抛物型条件。原定义包含漂移作为一个数学定义本身并不矛盾；不能据此对一般SDE断言转移密度，而本条也没有这样的定理结论。四个定义的角色及[EXTRA]一致。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.definition61` | 定义 | — | PASS |
| `MD.Ch06.parabolicNoiseBracketLevels` | 定义 | — | PASS |
| `MD.Ch06.definition61_corrected` | 定义 | — | PASS |
| `MD.Ch06.definition61Printed` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3040`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinFields

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> In the case of Langevin dynamics, we identify the vectors $`b_i`$ in (6.43) with the terms in (6.47). One puts Langevin dynamics into the correct form by using

$$
b_0=\begin{bmatrix}p\\-\nabla U(q)-\gamma p\end{bmatrix},\qquad b_i=\sigma\begin{bmatrix}0\\e_i\end{bmatrix},\quad i=1,2,\ldots,N_c,
$$


> where $`e_i`$ is the $`i`$th Euclidean basis vector in $`\mathbb R^{N_c}`$ and $`\sigma=\sqrt{2\gamma k_BT}`$ is constant.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def langevinDrift {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (γ : ℝ) (_hU : ContDiff ℝ ∞ U) : textbookLangevinPhase Nc → textbookLangevinPhase Nc :=
  fun z ↦ (z.2, textbookPotentialForce U z.1 - γ • z.2)

def langevinNoise (Nc : ℕ) (σ : ℝ) (i : Fin Nc) :
    textbookLangevinPhase Nc → textbookLangevinPhase Nc := fun _ ↦ (0, σ • Pi.single i 1)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际全部2Nc相空间坐标的真实drift/noise，C∞势资格编码，通用σ在物理定理取√(2γkBT)；不把noise定义计作独立Wiener law或密度存在证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Drift为(p,−∇U−γp)，Noise为(0,σe\_i)，Fin Nc覆盖全部坐标。C∞资格和通用σ/物理代入均已说明；噪声定义自身不是Wiener定律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinDrift` | 定义 | — | PASS |
| `MD.Ch06.langevinNoise` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:3064`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinNoiseBracket

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> For $`i=1,2,\ldots,N_c`$, we have, using the fact that $`b_i`$ is a constant vector field and so its Jacobian matrix vanishes,

$$
[b_0,b_i]=-\begin{bmatrix}0&I\\-U''(q)&-\gamma I\end{bmatrix}b_i =-\sigma\begin{bmatrix}e_i\\-\gamma e_i\end{bmatrix}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinNoiseBracket {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ 2 U) (γ σ : ℝ)
    (i : Fin Nc) (z : textbookLangevinPhase Nc) :
    VectorField.lieBracket ℝ (textbookLangevinDrift U γ) (textbookLangevinNoise Nc σ i) z =
      (-σ • Pi.single i 1, (σ * γ) • Pi.single i 1) := by
  apply MolecularDynamics.textbookLangevinDrift_noise_bracket <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C²势的Fréchet Jacobian、全部噪声坐标；σ任意，非零条件在独立性条明确。

### 6. 审计结论（含网站结论）

网站原返回：PASS。C²势足以使力可微；常字段导数为零，−Db0·bi=(−σe\_i,σγe\_i)，与原符号和全部i,z吻合；σ=0也允许本恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinNoiseBracket` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3073`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinBracketIndependent

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> As these $`N_c`$ vectors, taken together with the original $`b_i`$, clearly provide a linearly independent set of $`2N_c`$ vectors,

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinBracketIndependent (Nc : ℕ) (γ σ : ℝ) (hσ : σ ≠ 0) :
    LinearIndependent ℝ (textbookLangevinBracketFamily Nc γ σ) := by
  apply MolecularDynamics.textbookLangevinBracketFamily_linearIndependent <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Fin Nc⊕Fin Nc的全部2Nc向量族、σ≠0；不以维数计数代替独立性。

### 6. 审计结论（含网站结论）

网站原返回：PASS。族定义Sum.elim分别为全部噪声及全部括号，Fin Nc⊕Fin Nc恰有2Nc个向量；σ≠0保证位置块再动量块消元独立，n=0为空族也正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinBracketIndependent` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3082`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinHormander

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> we have verified Hörmander’s condition. Thus Assumption 1(ii) holds in the case of Langevin dynamics.

### 2. 原文证明

> 原书在结论前给出漂移、噪声、Lie括号计算及线性无关论证；本条仅摘录最后的结论句。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinHormander {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ θ : ℝ)
    (hγ : 0 < γ) (hθ : 0 < θ) (z : textbookLangevinPhase Nc) :
    textbookHormanderAt (textbookLangevinSeed U γ (Real.sqrt (2 * γ * θ))) z := by
  apply MolecularDynamics.textbookLangevin_hormander_physicalNoise <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Lean仅覆盖实际Langevin向量场的原书括号秩条件；转移密度由条目14的正时刻修正版承接。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整物理σ=√(2γθ)、γ/θ>0、C∞ U的实际噪声及括号span；本桥只证rank，转移密度存在另条未证。
- [EXTRA] scope仅实际Langevin向量场括号rank；密度结论由LangevinTransitionDensity承接，补全部迭代括号定义。
- [ERRATUM?] 原Assumption 1(ii)中的零时刻端点不能由此rank核验推出；仅正时刻密度可由相应抛物型条件讨论。
- [EXTRA] 复审范围：原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。
- 覆盖缺口：本条rank签名不包含密度存在或连续性。
- 覆盖缺口：原Assumption 1(ii)包含t=0的端点仍需人工处理。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：所引两句与原页相符；原页在此前已明确计算漂移、噪声及第一层括号并说明2Nc个向量线性无关，proof\_note不应让人误以为没有这段论证。C：rank声明自身PASS：状态为实配置×实动量，漂移(p,−∇U−γp)，噪声(0,σeᵢ)，σ=√(2γθ)且γ、θ正；给出每个z处的全部迭代括号span=整个相空间。Nc=0时是零维的无害情形。D95–D97以及实际seed均已展开，不是把rank结论当作假设。签名只给含漂移种子族的原书秩条件，没有直接给出转移密度或Assumption 1(ii)的联合连续性；这种拆分在EXTRA已有说明，需同步修正statement\_scope和coverage\_gaps。引文后半句的原Assumption 1(ii)实际写到t=0，正时刻密度即使正确，也不能自动覆盖这个端点，故原书层面的合并断言仍NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
原页已给噪声、漂移及第一层括号的线性独立论证。本条只给秩条件；正时刻密度另列，原Assumption1(ii)含零时刻端点仍有疑。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinHormander` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3089`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinTransitionDensity

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Thus Assumption 1(ii) holds in the case of Langevin dynamics.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinTransitionDensity :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β γ : ℝ)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
  textbookIsWienerVector B P → 0 < β → 0 < γ →
  ∃ ρ : textbookLangevinPeriodicPhase n → textbookLangevinPeriodicPhase n → ℝ → ℝ,
    (∀ x z t, 0 < t → 0 ≤ ρ x z t) ∧
    ContinuousOn (fun w : (textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n) × ℝ ↦
      ρ w.1.1 w.1.2 w.2) (univ ×ˢ Ioi 0) ∧
    ∀ (t : ℝ≥0), 0 < t → ∀ x A, MeasurableSet A →
      textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)) t x A =
        ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂MolecularDynamics.Chapter06Review.flatPhaseMeasure n := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原引文保留；Lean覆盖实际周期单位质量Langevin核在t>0的联合连续转移密度及全部可测集合表示。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]具体实际单位周期Langevin、C∞势、正γ/β，全部点初值的正时间连续转移密度及真实平坦相空间测度表示；没有从含drift的任意原Definition6.1断言一般parabolic密度定理。
- [EXTRA] 补actual\_path\_solution\_exists完整存在类型及所选解满足初值/积分方程的规格；不把缺摘录误记原书问题。
- [ERRATUM?] 原Assumption 1(ii)的[0,∞)应就转移密度连续性改为(0,∞)；点初值在零时刻是Dirac测度。
- [EXTRA] 复审范围：网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。
- 覆盖缺口：原Assumption 1(ii)在t=0的联合连续端点不成立/未按原文形式化，须勘误签核。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：所引“Thus Assumption 1(ii) holds in the case of Langevin dynamics.”原句准确；须连同其所引用的Assumption 1(ii)核对，不能只看该短句。C：当前正时刻限定签名PASS：真实周期单位质量Langevin端点核、C∞周期势和Lipschitz力、β和γ正、物理幅度√(2γ/β)、真实Wiener过程。D17、D19–D23及D28–D31说明是实际积分解的推前核；flatPhaseMeasure为真实平坦相空间测度。ρ先于所有t>0、x、可测A选择，在(x,z,t)联合变量上ContinuousOn(univ×(0,∞))，并给出全部可测集合上的限制积分表示；这是全密度结论，不是仅有限检验函数相等，也未把密度存在当作假设。原书Assumption 1(ii)却要求C×C×[0,∞)联合连续，当前声明有意改成t>0。该修改合理且必要，但应明标[ERRATUM?]并由人工认可；它不是原Assumption 1(ii)端点的完整忠实实现。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
网站PASS的是正时刻联合连续密度限定版；原[0,∞)连续密度端点需勘误。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinTransitionDensity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3098`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Lemma61Printed

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Lemma 6.1 For all $`t\gt 0`$ and all open $`C\subset D`$, we have that

$$
\Pr(X(t)\in C\mid X(0)=X_0)\gt 0,\quad\forall X_0\in D,
$$


> where $`X(t)=(q(t),p(t))^T`$ is a solution to Langevin dynamics (6.47).

### 2. 原文证明

> 原书给出证明论述；本条仅摘录命题，相关论述见相邻原页，未在此补写。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lemma61Printed {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ θ : ℝ) (hγ : 0 < γ) (hθ : 0 < θ)
    (T : ℝ≥0) (hT : (0 : ℝ) < T) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*θ)) T x C := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06\_ERRATA。
- 覆盖缺口：原书漏非空目标；Printed忠实保留空集漏洞。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：Lemma 6.1的标题、所有t>0、所有开集、全部点初值及原式准确；kind应为编号lemma而不是unnumbered\_claim。C：缺少C.Nonempty忠实保留了原文的空集漏洞，这个数学错误应NEEDS\_HUMAN，不能仅因此判Printed签名FAIL。实际端点核的定义、时间正性、全部点初值及周期单位质量相空间均已核对。不过原页把过程指定为(6.47)，其γ为正且噪声为√(2γkBT)；当前Printed却量化任意实γ和任意非零实σ，额外覆盖γ≤0及不满足物理噪声关系的过程。它们可用于有限时刻开放集可达性的正确推广，但该推广没有在本条EXTRA中完整披露，也不是(6.47)的字面参数域。按Printed必须审忠实性的要求，本条因参数域扩张FAIL；原书空集错误仍独立标NEEDS\_HUMAN。此结论不依据sorry。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
kind恢复编号lemma；Printed收回原(6.47)正摩擦γ>0及物理噪声σ=√(2γθ)、θ=kBT>0的参数域，保留所有开集（包括空集）的原断言。任意实γ/非零σ的推广只留在非空修正版；漏C.Nonempty是原书疑误，不证明Printed。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lemma61Printed` | 未证 | 原书疑误不证 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3117`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Lemma61Nonempty

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述


$$
\Pr(X(t)\in C\mid X(0)=X_0)\gt 0,\quad\forall X_0\in D,
$$



### 2. 原文证明

> 原书给出Lemma 6.1的Proof论述；本条只摘录展示式，未重录证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem lemma61Nonempty {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption

/-- 修正版，对应原文 MD-6.4.4-Lemma61Printed；改动：增加目标开集非空；保留任意点初值、任意t>0的实际核正概率。 -/
theorem lemma61Printed_corrected {N : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin N → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)) (γ σ : ℝ) (T : ℝ≥0) (hT : (0 : ℝ) < T)
    (hσ : σ ≠ 0) (x : textbookLangevinPeriodicPhase N)
    (C : Set (textbookLangevinPeriodicPhase N)) (hC : IsOpen C) (hCN : C.Nonempty) :
    0 < textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ σ T x C := by
  apply MolecularDynamics.textbookLangevinPeriodicTransitionKernel_open_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原展示式保持原文；两份Lean声明均为增加目标非空条件、并将γ及σ参数推广后的实际周期单位质量核正概率命题。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]补非空目标；桥接实际单位周期相空间、原单位质量、真实Wiener/实际完整Langevin核，σ≠0。原一般质量扩大版不计已证。
- [EXTRA] 补所选解存在规格；目标开集非空修正保持。
- [EXTRA] γ可为任意实数，σ可为任意非零实数，是有限正时刻支持性质的推广；原物理(6.47)为其中的特例。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：该展示式来自同一Lemma 6.1；原页展示式以逗号承接where句，JSON改成句号，已还原。公式单独摘录时需补上原来的t>0、开集C、Langevin解及任意初值的上下文。原页下面有Proof段，当前proof\_note应说明仅摘录命题，而不是遗漏这段原书论述。C：两份签名相同且作为修正/推广版均PASS：真实Wiener过程、C∞单位周期势及Lipschitz力、实际单位质量周期端点核；T>0、σ≠0、任意初值x以及非空开集C给出严格正概率。已展开路径存在规格和初值/积分方程、推前核定义，并核对所引open\_pos定理的完整文件参数。增加C.Nonempty恰好消除条目15的空集漏洞；γ任意实数、σ任意非零实数是有限时刻可达性的合理推广，不需要为此引入规范不变测度或正摩擦。修正版并未声称一般质量矩阵版本已经覆盖。[EXTRA]应补全该参数推广，不把nonempty写进原文引文冒充原书已印出。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.lemma61Nonempty` | 已证 | — | PASS |
| `MD.Ch06.lemma61Printed_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3129`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ControlPath

印刷p.255 / PDFp.276；§6.4.4。

### 1. 原文陈述

> Consider the ODE

$$
\frac{d^2q}{dt^2}+\nabla U(q)+\gamma\frac{dq}{dt}=\sigma\frac{dR}{dt}.\tag{6.49}
$$


> for some positive constants $`\gamma`$ and $`\sigma`$. This is precisely Langevin dynamics (6.47), substituting a process $`R(t)`$ in place of the Wiener process. Choose $`q`$ to be a $`C^\infty`$ path such that for a given $`t\gt 0`$

$$
(q(0),\dot q(0))^T=X_0;\quad(q(t),\dot q(t))^T=y.
$$


> Taking $`R(0)=0`$, we can obtain a $`C^\infty`$ function $`dR/dt`$ by substitution.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem controlPath {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (x y : textbookLangevinPhase Nc) :
    ∃ q p R : ℝ → (Fin Nc → ℝ),
      ContDiff ℝ ∞ q ∧ ContDiff ℝ ∞ p ∧ ContDiff ℝ ∞ R ∧
      q 0 = x.1 ∧ p 0 = x.2 ∧ q T = y.1 ∧ p T = y.2 ∧ R 0 = 0 ∧
      ∀ t, HasDerivAt q (p t) t ∧
        HasDerivAt p (textbookPotentialForce U (q t) - γ • p t + σ • deriv R t) t := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整实际任意位置/速度端点、q/p/R全光滑、R0=0及真实全时ODE；σ≠0，未冒充随机正概率。

### 6. 审计结论（含网站结论）

网站原返回：PASS。所有x,y、T>0、σ≠0，存在全光滑q,p,R，四个端点及R0=0，逐时q′=p与p′=−∇U−γp+σR′全部保留。欧氏提升的可控性足够用于环面投影，EXTRA范围清楚。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.controlPath` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3150`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-ControlEndpointStable

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Using the results of [257, Lemma 3.4], we can deduce that for any $`\delta\gt 0`$, there exists a sufficiently small $`\varepsilon\gt 0`$ such that if a realization of the Wiener process $`W`$ remains close to our solution $`R`$

$$
\sup_{0\le s\le t}\|W(s)-R(s)\|\le\varepsilon,\tag{6.50}
$$


> then $`X(t)\in\mathcal B_\delta(y)`$. 

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem controlEndpointStable {Nc : ℕ}
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (γ σ T δ : ℝ)
    (hσ : σ ≠ 0) (hT : 0 < T) (hδ : 0 < δ) (x y : textbookLangevinPhase Nc) :
    ∃ ε > 0, ∀ W q p : ℝ → (Fin Nc → ℝ),
      textbookLangevinIntegralSolution U γ σ T x W q p →
      (∀ t ∈ Icc 0 T, ‖W t - textbookLangevinControlPath U γ σ T x y t‖ ≤ ε) →
      dist (q T, p T) y < δ := by
  apply MolecularDynamics.textbookLangevinControlledEndpoint_stable <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际完整受控积分方程和原平滑势局部cutoff稳定性，全部端点/δ/ε；未假设全局Lipschitz势，原环面投影由上一真实核桥接。

### 6. 审计结论（含网站结论）

网站原返回：PASS。δ后选统一ε，再量化所有连续W,q,p；积分解定义包含初值、W0和两条真实积分方程。给定controlPosition/Momentum/Rate为Hermite三次路径及ODE反解，R为其积分；sup管道用逐时≤表达，端点严格dist<δ正确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.controlEndpointStable` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3162`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WienerControlTube

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> The event (6.50) is shown in [349] to have positive probability for any $`\varepsilon\gt 0`$, and hence the required property is shown for any open set.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerControlTube {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (T : ℝ) (hT : 0 < T) (R : ℝ → (Fin Nc → ℝ)) (hR : Continuous R)
    (hR0 : R 0 = 0) (ε : ℝ) (hε : 0 < ε) :
    0 < P (textbookWienerVectorRealControlTube B T R ε) := by
  apply MolecularDynamics.textbookWienerVectorRealControlTube_pos <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整实际标准多维Wiener法则、真实连续控制R0=0、T/ε>0及sup管道事件；非仅某单时Gaussian边际。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D50规定联合高斯、均值、独立坐标Brownian协方差与几乎处处连续，管道定义在闭时间区间逐时≤ε，T/ε>0且连续R起于0。对象、时间和事件完整，未以单时边际替代路径规律。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerControlTube` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3173`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinCanonicalStationary

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Langevin dynamics is geometrically ergodic with respect to the canonical distribution

$$
\rho_\beta(q,p)=\exp(-\beta H(q,p)),
$$


> where it is easily checked that

$$
\mathcal L_{LD}^\dagger\rho_\beta=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinCanonicalStationary {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β) (hγ : 0 < γ) (z : textbookLangevinPhase N) :
    textbookLangevinForwardDifferentialOperator U γ (Real.sqrt (2 * γ * β⁻¹))
      (fun y ↦ textbookLangevinCanonicalDensity U β (textbookLangevinPeriodicProjection y)) z = 0 := by
  apply MolecularDynamics.textbookLangevinForwardDifferentialOperator_physical_canonical_eq_zero <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际归一canonical density（原式缺Z为未归一权重，常数不影响微分式）、全部相空间点及物理噪声；这里只证stationary differential expression，真实invariance/ergodicity在下一条。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际forward算子全文为−DF·b−div(b)F+σ²Δ\_pF/2；散度由全部位置/动量对角方向导数定义，确为平坦前向算子。D56–D57给归一canonical密度，正β、γ及σ=√(2γ/β)完整，逐点平稳式正确。原几何遍历性另列21，本条scope已限stationary differential expression。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinCanonicalStationary` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:3182`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinGeometricErgodicity

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Hence Langevin dynamics is geometrically ergodic with respect to the canonical distribution

$$
\rho_\beta(q,p)=\exp(-\beta H(q,p)),
$$


> where it is easily checked that

$$
\mathcal L_{LD}^{\dagger}\rho_\beta=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinGeometricErgodicity :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  MolecularDynamics.Chapter06Review.invariantKernel (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹)))
    (textbookLangevinCanonicalMeasure U β hβ) ∧
  (∀ ν : Measure (textbookLangevinPeriodicPhase n), IsProbabilityMeasure ν →
    MolecularDynamics.Chapter06Review.invariantKernel
      (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) ν →
    ν=textbookLangevinCanonicalMeasure U β hβ) ∧
  ∀ l : ℕ, 1 ≤ l → ∃ C lambdaParam : ℝ, 0 < C ∧ 0 < lambdaParam ∧
    ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
      Measurable f → (∀ y, |f y| ≤ (1+‖y.2‖^2)^l) → ∀ t : ℝ≥0,
      |MolecularDynamics.Chapter06Review.kernelAverage
        (textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ (Real.sqrt (2*γ*β⁻¹))) f t x
        -(∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)| ≤
        C*(1+‖x.2‖^2)^l*Real.exp (-lambdaParam*(t : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Lean采用单位周期、单位质量的实际Langevin核与归一Gibbs概率，显式要求U光滑周期、力全局Lipschitz及β,γ>0。
- [EXTRA] 对每个l≥1，常数在x、f、t之外；f精确限定为可测且|f(y)|≤(1+‖p‖²)^l的点态权界类。一般常数倍由缩放处理；不能称任意仅加权可积函数。
- [EXTRA] 固定有限维时可使用正平移后的Hamiltonian权重与(1+‖p‖²)^l比较，不能对未平移H^l作全局双边比较。
- [ERRATUM?] 原页exp(-βH)未显示归一因子；保留原式，需人工确认省略Z的约定。Lean实际采用归一Gibbs概率。
- [EXTRA] 复审范围：权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PASS指所交Lean签名的语义审校。相空间确为T^n×R^n；U光滑且单位周期，力全局Lipschitz，β、γ严格为正，噪声幅度√(2γ/β)。核来自有限窗真实Langevin积分解及Wiener路径分布；结论依次是归一Gibbs不变、全部不变概率的唯一性、每个整数l≥1上的统一加权指数估计。观测量为所有可测且逐点满足|f(y)|≤(1+‖p‖²)^l的实函数，既不是仅紧支函数，也不是任意加权L¹函数。C、λ可依赖n、U、β、γ、l等此前参数，但不依赖x、f、t；t=0包括在内。Fin n→R的标准范数与欧氏范数在固定有限维可比，不改变这一增长类。归一Gibbs与原页未写Z的exp(-βH)有明确区别，因此A阶段保留归一约定疑问为NEEDS\_HUMAN；该疑问及过时EXTRA措辞不构成此正确签名的FAIL。未检查证明完成度。
当前处理：网站PASS（复审）。
权界是对所有(q,p)逐点成立；Hamiltonian权比较采用充分正平移后的Hamiltonian，原展示式及归一约定见原文。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinGeometricErgodicity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3192`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-LangevinTimeAverage

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> Hence averages along solutions to (6.47) will converge to the spatial average with respect to $`\rho_\beta`$. Thus, Langevin dynamics is a useful tool for sampling the canonical distribution, as we may sample $`\rho_\beta`$ by computing solutions to the SDE.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinTimeAverage :
  ∀ {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω) (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (_hU : ContDiff ℝ ∞ U) (_hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U))
    (γ β : ℝ) (hβ : 0 < β), textbookIsWienerVector B P → 0 < γ →
  ∀ x : textbookLangevinPeriodicPhase n, ∀ f : textbookLangevinPeriodicPhase n → ℝ,
    Measurable f →
    (∃ l : ℕ, ∃ C : ℝ, 0 ≤ C ∧ ∀ y, |f y| ≤ C*(1+‖y.2‖^2)^l) → ∀ᵐ sample ∂P,
      Tendsto (fun T : ℝ ↦ T⁻¹ * ∫ s in 0..T,
        f (textbookLangevinPeriodicGlobalRandomPhase U L hF γ (Real.sqrt (2*γ*β⁻¹)) x B s sample))
        atTop (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际同一全时随机周期Langevin轨迹，任意点初始状态、全部可测多项式动量增长观测量、几乎处处时间均值；不把初始density的ensemble衰减当轨迹时间均值。
- [EXTRA] 补实际选解存在、真实积分方程、唯一性、限制及同一全时随机过程一致性的完整声明类型；有限窗选择不能仅凭choose名称认定相容。

### 6. 审计结论（含网站结论）

网站原返回：PASS。相空间、归一Gibbs测度、β和γ及Wiener向量与上一条一致。结论确为沿同一随机轨迹的Cesàro时间均值：∀确定x、∀可测实f，若存在l∈N及C≥0使|f|≤C(1+‖p‖²)^l，则对P几乎所有样本，实数T→+∞时T⁻¹∫₀ᵀf(X\_s)ds趋于Gibbs空间平均。l=0允许全部有界可测函数；零测例外集可以依赖x、f，并未声称所有x、f共享例外集。GlobalRandomPhase虽按ceil(t)+1选有限窗，但本任务同时提供真实积分解、全局唯一性、窗口一致性及∀T的AE规格，故不是把不相容choose选择误认成一条轨迹。周期过程由该全时解投影得到；hU、hp即便以下划线命名仍是显式前提。没有用初始密度ensemble收敛替代时间平均。sorry不参与本签名判定。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinTimeAverage` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:3216`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedH1

印刷p.256 / PDFp.277；§6.4.4。

### 1. 原文陈述

> We denote by $`H^1(\mu)`$ the space of functions $`f(q,p)`$ defined on $`D=\mathbb T^{N_c}\times\mathbb R^{N_c}`$ with bounded norm

$$
\|f\|_{H^1(\mu)}^2\stackrel{\mathrm{def}}=\|f\|_{L^2(\mu)}^2+\|\nabla_qf\|_{L^2(\mu)}^2+\|\nabla_pf\|_{L^2(\mu)}^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weightedH1 {N : ℕ} (U : (Fin N → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) : Type :=
  textbookLangevinCanonicalWeakH1 U hU hp β hβ
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Gibbs加权弱导数闭图及AE商的完整Hilbert H1；不是smooth jet子集，函数/导数投影和范数下一条明确。
- [EXTRA] 补坐标伴随测试表达式及memLp\_two完整规格；明确位置β∂U、动量βp项及分部积分符号，补摘录不算原书勘误。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weightedH1是Gibbs权重下的完整实弱H¹实现：none分量为函数的AE等价类，some(inl i)、some(inr i)分别是q、p的L²弱导数。测试恒等式的负号和β∂U、βp项正确，因为dμβ正比于exp(-βH)dω。所有测试函数的伴随表达式MemLp规格已实际摘录，不能只看名称。每项均为L²类，PiLp 2给出平方和范数；测试恒等式是连续线性约束，数学上刻画闭弱导数图及通常的Sobolev完备空间。所加U光滑、单位周期、β>0和Gibbs权重专业化已有EXTRA说明。这里审查类型和定义语义，不另宣称项目已证明闭性、完备性或所有相关实例。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedH1` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:3233`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-WeightedH1Norm

印刷p.256–257 / PDFp.277–278；§6.4.4。

### 1. 原文陈述

> where

$$
\|f\|_{L^2(\mu)}^2=\int_D f^2\mu(d\omega),
$$


> and, for a vector function $`w:D\to\mathbb R^{N_c}`$, we have

$$
\|w\|_{L^2(\mu)}^2=\sum_{i=1}^{N_c}\|w_i\|_{L^2(\mu)}^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem weightedH1Norm {N : ℕ}
    (U : (Fin N → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β) (f : textbookLangevinCanonicalWeakH1 U hU hp β hβ) :
    ‖f‖ ^ 2 = ‖textbookLangevinCanonicalWeakH1Value U hU hp β hβ f‖ ^ 2 +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inl i) f‖ ^ 2) +
      (∑ i : Fin N, ‖textbookLangevinCanonicalWeakH1Derivative U hU hp β hβ (Sum.inr i) f‖ ^ 2) := by
  apply MolecularDynamics.textbookLangevinCanonicalWeakH1_norm_sq <;> assumption

/-- 原文第一式：实标量L²范数平方等于平方积分。 -/
theorem weightedL2NormScalar26 {D : Type*} [MeasurableSpace D]
    (μ : Measure D) (f : Lp ℝ 2 μ) :
    ‖f‖ ^ 2 = ∫ x, (f x) ^ 2 ∂μ := by
  sorry

/-- 原文第二式：任意欧氏向量值L²函数的分量均属L²，范数平方为分量平方和。 -/
theorem weightedL2NormVector26 {D : Type*} [MeasurableSpace D] {Nc : ℕ}
    (μ : Measure D) (w : D → EuclideanSpace ℝ (Fin Nc)) (hw : MemLp w 2 μ) :
    ∃ hc : ∀ i : Fin Nc, MemLp (fun x ↦ w x i) 2 μ,
      ‖hw.toLp w‖ ^ 2 = ∑ i : Fin Nc, ‖(hc i).toLp (fun x ↦ w x i)‖ ^ 2 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。现有weightedH1Norm本身数学正确：它确实给出加权H¹范数等于函数值及全部位置、动量弱导数L²范数的平方和，N、β、U及坐标投影均正确。但原文JSON的两项主结论分别是‖f‖²L²=∫f²dμ，以及任意w:D→R^N的‖w‖²L²=Σ‖wᵢ‖²L²。该Lean结论没有积分，没有独立标量f:L²，也没有任意向量w，因此不能覆盖这些结论。FAIL仅指本条原文与声明的完整覆盖关系，不指jet等式错误，也不因证明或sorry。EXTRA承认缺口是准确的，但不能替代缺失声明。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
保留已证H¹ jet范数分解为辅助；新增原文实标量L²平方积分式及任意欧氏向量值L²函数的分量范数平方和两条独立短陈述。新增陈述的证明状态单列，不用辅助等式代替原文两式。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weightedH1Norm` | 已证 | — | PASS |
| `MD.Ch06.weightedL2NormScalar26` | 未证 | 缺大型理论 | 修复后未再送网站 |
| `MD.Ch06.weightedL2NormVector26` | 未证 | 缺大型理论 | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:3240`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Proposition64Printed

印刷p.257 / PDFp.278；§6.4.4。

### 1. 原文陈述

> Proposition 6.4 Let $`U`$ be $`C^\infty`$ on the position domain $`Q=\mathbb T^{N_c}`$ and suppose $`g\in H^1(\mu)`$ satisfies

$$
\int_D g\,d\mu_\beta=0,
$$


> where $`\mu_\beta`$ is the canonical measure, then the Poisson equation

$$
\mathcal L_{LD}^\dagger\varphi=g
$$


> has a solution $`\varphi\in H^1(\mu)`$ which is unique up to addition of a constant multiple of the Gibbs density.

### 2. 原文证明

> 原书给出证明论述；本条仅摘录命题，相关论述见相邻原页，未在此补写。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition64Printed :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β γ : ℝ) (hβ : 0 < β), 0 < γ →
  ∀ g : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
    (∫ x, textbookLangevinCanonicalWeakH1Value U hU hp β hβ g x ∂textbookLangevinCanonicalMeasure U β hβ)=0 →
    ∃ φ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
      MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ)
        (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) ∧
      ∀ ψ : textbookLangevinCanonicalWeakH1 U hU hp β hβ,
        MolecularDynamics.Chapter06Review.flatForwardWeak U β γ (textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ)
          (textbookLangevinCanonicalWeakH1Value U hU hp β hβ g) →
        ∃ c : ℝ, ∀ᵐ x ∂textbookLangevinCanonicalMeasure U β hβ,
          textbookLangevinCanonicalWeakH1Value U hU hp β hβ ψ x -
            textbookLangevinCanonicalWeakH1Value U hU hp β hβ φ x = c*textbookLangevinCanonicalDensity U β x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留原flat/Gibbs坐标混用疑误和非Gibbs恒通量反例；补H¹伴随测试表达式，修正版本由Proposition64Relative独立保存。
- [ERRATUM?] 原印刷同时混用Gibbs零均值与flat前向核的Gibbs倍数结论；所给弱域存在非Gibbs恒通量零模，须人工核定伴随坐标与算子域，原句不改。
- [EXTRA] 本任务没有提供\_counterexample声明；不能把“保留反例”当作已完成的Lean审查证据。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed忠实性：PASS。给定光滑周期U、β>0、γ>0，对每个Gibbs加权H¹且μβ零均值的g，确实逐项保留flat-forward弱Poisson方程、完整H¹解存在、以及全部H¹解唯一模Gibbs密度倍数。CanonicalDensity为D52–D59的归一exp(-βH)，与未归一Gibbs密度相差正常数，不改变唯一模其倍数的表述。但这一原文字面版本在所定义弱域上存在明确恒通量反例；不能将平直前向伴随与Gibbs Hilbert伴随混用。因此总判NEEDS\_HUMAN，保留Printed；不是因sorry失败。修正版在条目6的独立声明另审，未用它替换此原文版。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition64Printed` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:3265`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

