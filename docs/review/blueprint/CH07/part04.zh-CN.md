[上一部分](part03.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / 下一部分：无

## MD-7.12-MidpointStabilityPrinted

印刷页 319 / PDF页 340。

### 1. 原文陈述

> The Lagrange multiplier $`\lambda_{n+1/4}`$ (and likewise $`\lambda_{n+1}`$) can be obtained by solving the linear system

$$
g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,
$$


> which is easily computed once the $`R_n`$ vector is evaluated in the step, and gives us a stability criterion

$$
\gamma h\lt 4.\tag{7.46}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (multiplier : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor
  · apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
  · apply (div_le_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。

### 7. 状态与证明位置

- `MD.Ch07.multiplierLinearSystem`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointAmplification`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStabilityPrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStabilityPrinted_corrected`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStability_counterexample`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ConstrainedABOSplitting

印刷页 319–320 / PDF页 340–341。

### 1. 原文陈述


$$
A_c:\quad dq=M^{-1}pdt,\quad dp=-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
B_c:\quad dq=0,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> Observe that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $`g(q)=0`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 multiplier i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ multiplier : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (multiplier t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。
- 正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。

### 7. 状态与证明位置

- `MD.Ch07.constrainedAField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedBField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.geodesicConstraintFlow`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedKickRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedExactORelation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ConstrainedBAOABAlgorithm

印刷页 320 / PDF页 341。

### 1. 原文陈述

> c-$`[BAOAB]`$

$$
p_{n+1/5}=p_n-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/3},\quad g'(q_n)M^{-1}p_{n+1/5}=0.
$$


> Solve the geodesic flow $`A_c`$ for $`h/2`$, and map $`[q_n,p_{n+1/5}]\to[q_{n+1/2},p_{n+2/5}]`$.

$$
p_{n+3/5}=e^{-\gamma h}p_{n+2/5}+\sqrt{(1-e^{-2\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\lambda_{n+2/3},\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.
$$


> Solve the geodesic flow $`A_c`$ for $`h/2`$, and map $`[q_{n+1/2},p_{n+3/5}]\to[q_{n+1},p_{n+4/5}]`$.

$$
p_{n+1}=p_{n+4/5}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 constrainedBAOABRelation, constrainedBAOAB\_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 constrainedBAOABRelation, constrainedBAOAB\_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。

### 7. 状态与证明位置

- `MD.Ch07.constrainedBAOABRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedBAOAB_constraint`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ApproximateGeodesicOrder

印刷页 320 / PDF页 341。

### 1. 原文陈述

> We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $`A_c`$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。
- 29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。
- 覆盖缺口：29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。localMapErrorBound对同一C≥0、δ>0以及全部0<h<δ、x∈D给出O(h^(r+1))误差；r=2即局部O(h³)，定义本身合理。但geodesicReplacementSecondOrder只是该定义的别名，无任何组合方法、随机强/弱误差、稳定性前提或整体二阶结论。EXTRA诚实说明缺口，却不能使“本条全部数学对象与公式”的statement\_scope成立。FAIL基于完整结论缺失，与是否有sorry无关。
网站复审结论：PASS。按本条明确声明的“一致局部O(h³)误差资格定义”范围，域、范数、全部量词和r+1指数均正确。两个def未声称替换后整体二阶，故不以缺少该定理否定其已缩小范围的签名。原文完整保阶论断仍未形式化，不能由本PASS消除该覆盖缺口。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。

### 7. 状态与证明位置

- `MD.Ch07.localMapErrorBound`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.geodesicReplacementSecondOrder`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-FastSlowHarmonicModel

印刷页 323 / PDF页 344。

### 1. 原文陈述


$$
H(q,p)=p^2/2+U(q),\qquad U(q)=U_F(q)+U_S(q),
$$



$$
U_S(q)=q^2/2,\qquad U_F(q)=\Omega^2q^2/2,\tag{7.47}
$$


> where $`\Omega\gg1`$.

$$
\binom{dq}{dp}=\underbrace{\binom{pdt}{-\Omega^2qdt-\gamma pdt+\sqrt{2\gamma/\beta}dW}}_{\rm Fast}+\underbrace{\binom0{-qdt}}_{\rm Slow}.\tag{7.48}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
abbrev Mat2 := Matrix (Fin 2) (Fin 2) ℝ
def fastPotential (Ω q : ℝ) : ℝ := Ω^2*q^2/2
def slowPotential (q : ℝ) : ℝ := q^2/2
def fastMatrix (Ω γ : ℝ) : Mat2 := !![0,1;-Ω^2,-γ]
def slowMatrix (h : ℝ) : Mat2 := !![1,0;-h,1]
def fastLangevin (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β : ℝ) (x0 : Phase 1) : Prop :=
  0 < frequency ∧ 0 < β ∧ langevin P W X (fun q ↦ fastPotential frequency (q 0)) (fun _ ↦ 1) γ β⁻¹ x0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 单位质量、实际标准Wiener、状态适应、正β及完整积分方程由langevin定义体保留；Ω≫1在定量结论中分别改成明确不等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。

### 7. 状态与证明位置

- `MD.Ch07.Mat2`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.slowPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.slowMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastLangevin`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-ExactFastGaussianLaw

印刷页 323–324 / PDF页 344–345。

### 1. 原文陈述

> Writing $`F=\begin{bmatrix}0&1\\-\Omega^2&-\gamma\end{bmatrix}`$, we can write down the solution to the fast dynamics as

$$
\binom{q(t)}{p(t)}=\exp(Ft)\binom{q(0)}{p(0)}+B_tR,
$$


> where $`R`$ is a column vector of two i.i.d. random normal numbers distributed as $`\mathcal N(0,1)`$, and

$$
B_tB_t^T=\frac{2\gamma}\beta\int_0^t\exp(F(t-s))\begin{bmatrix}0&0\\0&1\end{bmatrix}\exp(F^T(t-s))ds.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def fastExponential (Ω γ t : ℝ) : Mat2 := NormedSpace.exp (t • fastMatrix Ω γ)
def fastCovariance (Ω γ β t : ℝ) : Mat2 := fun i j ↦ 2*γ/β*∫ s in (0 : ℝ)..t,
  (fastExponential Ω γ (t-s)* (!![0,0;0,1] : Mat2)*(fastExponential Ω γ (t-s))ᵀ) i j
theorem exactFastGaussianLaw (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β t : ℝ) (x0 : Phase 1) (B : Mat2)
    (hX : fastLangevin P W X frequency γ β x0) (ht : 0 ≤ t)
    (hB : B*Bᵀ = fastCovariance frequency γ β t) :
    HasLaw (fun sample ↦ (![ (X t sample).1 0, (X t sample).2 0] : Fin 2 → ℝ))
      (Measure.map (fun R : Fin 2 → ℝ ↦
        fastExponential frequency γ t *ᵥ (![x0.1 0,x0.2 0] : Fin 2 → ℝ)+B*ᵥ R)
        (Measure.pi (fun _ : Fin 2 ↦ gaussianReal 0 1))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 陈述真实过程的转移分布，不将强解等于一组新独立R假设成结论。Bt只需给定平方根因子；正半定矩阵平方根存在性未另证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。

### 7. 状态与证明位置

- `MD.Ch07.fastExponential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastCovariance`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.exactFastGaussianLaw`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-MultipleTimestepUpdate

印刷页 324 / PDF页 345。

### 1. 原文陈述

> The solution to the slow part of our splitting is just

$$
\binom{q(t)}{p(t)}=\begin{bmatrix}1&0\\-t&1\end{bmatrix}\binom{q(0)}{p(0)}.
$$


> For a method taking one step of the fast system followed by a step of the slow system, using fixed step size $`h\gt 0`$, we can write the update scheme for $`z=[q,p]^T`$ as

$$
z_{n+1}=Xz_n+YR_n,\qquad X=\begin{bmatrix}1&0\\-h&1\end{bmatrix}\exp(hF),\quad Y=\begin{bmatrix}1&0\\-h&1\end{bmatrix}B_h.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def multipleX (Ω γ h : ℝ) : Mat2 := slowMatrix h*fastExponential Ω γ h
def multipleY (h : ℝ) (B : Mat2) : Mat2 := slowMatrix h*B
def multipleStep (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) : Fin 2 → ℝ :=
  multipleX Ω γ h *ᵥ z+multipleY h B *ᵥ R
theorem multipleStep_composition (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) :
    multipleStep Ω γ h B R z = slowMatrix h *ᵥ (fastExponential Ω γ h *ᵥ z+B*ᵥ R) := by
  simp [multipleStep,multipleX,multipleY,Matrix.mulVec_add,Matrix.mulVec_mulVec]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 multipleX, multipleY, multipleStep, multipleStep\_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Rn为每步独立标准二维Gaussian；稳定分布分析仍要求真实独立序列及有限协方差，不能只以更新定义宣称存在平稳解。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 multipleX, multipleY, multipleStep, multipleStep\_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。

### 7. 状态与证明位置

- `MD.Ch07.multipleX`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleY`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleStep_composition`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-DeterminantTrace

印刷页 324 / PDF页 345。

### 1. 原文陈述

> Denoting $`\eta=\sqrt{\gamma^2-4\Omega^2}`$, then we compute

$$
\det(X)=e^{-\gamma h},\qquad \operatorname{tr}(X)=\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def traceFormula (γ h : ℝ) (η : ℂ) : ℂ :=
  (η-(h : ℂ))/η*Complex.exp ((η-(γ : ℂ))*(h : ℂ)/2)+
  (η+(h : ℂ))/η*Complex.exp ((-η-(γ : ℂ))*(h : ℂ)/2)
theorem determinantTrace (Ω γ h : ℝ) (η : ℂ) (hη : η^2 = (γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    Matrix.det (multipleX Ω γ h) = Real.exp (-γ*h) ∧
    ((Matrix.trace (multipleX Ω γ h) : ℝ) : ℂ) = traceFormula γ h η := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- η允许纯虚数；显式排除临界η=0，避免除零假公式。临界阻尼应取连续极限，另列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。

### 7. 状态与证明位置

- `MD.Ch07.traceFormula`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.determinantTrace`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-SpectralRadiusStability

印刷页 324 / PDF页 345。

### 1. 原文陈述

> The stability of the method therefore depends solely on the spectral radius of the matrix $`X`$. This gives a stability condition

$$
\left|\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}\right|\le1+e^{-\gamma h}.
$$


> Multiplying by $`e^{\gamma h/2}`$ gives

$$
|\cosh(\eta h/2)+(h/\eta)\sinh(-\eta h/2)|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def characteristicUnitDisk (X : Mat2) : Prop :=
  ∀ z : ℂ, z^2-((Matrix.trace X : ℝ) : ℂ)*z+((Matrix.det X : ℝ) : ℂ) = 0 → ‖z‖ ≤ 1
theorem spectralRadiusStability (X : Mat2) (hd : 0 < Matrix.det X) (hd1 : Matrix.det X < 1) :
    characteristicUnitDisk X ↔ |Matrix.trace X| ≤ 1+Matrix.det X := by
  sorry
def hyperbolicStability (γ h : ℝ) (η : ℂ) : Prop :=
  ‖Complex.cosh (η*(h : ℂ)/2)+(h : ℂ)/η*Complex.sinh (-η*(h : ℂ)/2)‖ ≤ Real.cosh (γ*h/2)

theorem multipleX_spectral_hyperbolic (Ω γ h : ℝ) (η : ℂ)
    (hγ : 0 < γ) (hh : 0 < h)
    (hη : η^2=(γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    characteristicUnitDisk (multipleX Ω γ h) ↔ hyperbolicStability γ h η := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述谱半径≤1的确定性边界资格；有非退化随机驱动时平稳二阶矩一般要求严格谱半径<1，等号并不自动给随机长期稳定。
- 正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。
- 29号覆盖限定：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。
- 覆盖缺口：正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。characteristicUnitDisk量化所有复特征根的模≤1；对实2×2矩阵且0<det<1，与|tr|≤1+det等价，抽象定理签名正确。hyperbolicStability只定义不等式；没有把multipleX、traceFormula、η²关系及η≠0联结到该条件的等价定理，故原条完整结论尚缺桥梁。EXTRA已说明此缺口，不能替代完整形式化。谱边界不等于Gaussian驱动的平稳有限方差条件。
网站复审结论：NEEDS\_HUMAN。四条Lean声明的对象、域、全部假设与结论均核对正确；在0<det X<1及γ>0,h>0,η²=γ²−4Ω²,η≠0的前提下，两个等价定理的签名成立。若只看明确缩小的确定性谱范围，可判PASS。全条依任务“原书数学疑误保留并判NEEDS\_HUMAN”的规则，仍需人工界定原印随机系统中的稳定性；不能把闭圆盘条件当成有限方差平稳性，也不能因sorry判FAIL。
按版本登记：四条闭单位圆谱声明签名PASS；不可把≤边界等同Gaussian噪声下有限二阶矩平稳性，η=0另留缺口。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。

### 7. 状态与证明位置

- `MD.Ch07.characteristicUnitDisk`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.spectralRadiusStability`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.hyperbolicStability`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleX_spectral_hyperbolic`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-HyperbolicPhaseTransform

印刷页 324 / PDF页 345。

### 1. 原文陈述

> For $`\gamma\gt 0`$, we can simplify to

$$
\left|\cosh\left(\frac{\eta h}{2}-\operatorname{atanh}\left(\frac h\eta\right)\right)\sqrt{1-\frac{h^2}{\eta^2}}\right|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def hyperbolicPhase (η h : ℝ) : ℝ :=
  Real.cosh (η*h/2-Real.artanh (h/η))*Real.sqrt (1-h^2/η^2)
theorem hyperbolicPhase_identity (η h : ℝ) (hη : η ≠ 0) (hr : |h/η| < 1) :
    hyperbolicPhase η h = Real.cosh (η*h/2)-h/η*Real.sinh (η*h/2) := by
  have hh : h/η ∈ Set.Ioo (-1 : ℝ) 1 := abs_lt.mp hr
  have hs : Real.sqrt (1-(h/η)^2) ≠ 0 := by
    apply ne_of_gt
    apply Real.sqrt_pos.2
    have hsq : (h/η)^2 < 1 := (sq_lt_one_iff_abs_lt_one (h/η)).2 hr
    linarith
  simp only [hyperbolicPhase,Real.cosh_sub,Real.cosh_artanh hh,Real.sinh_artanh hh]
  rw [← div_pow]
  calc
    _ = (Real.cosh (η*h/2)-(h/η)*Real.sinh (η*h/2))/Real.sqrt (1-(h/η)^2)*Real.sqrt (1-(h/η)^2) := by ring
    _ = _ := div_mul_cancel₀ _ hs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅实η≠0、/h/η/<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实η版本必须补|h/η|<1，γ>0本身不足；复η需选择sqrt/artanh分支，原文未说明。只覆盖明确实域上的等式，不把所有γ>0都纳入。
- 29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。
- 覆盖缺口：29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。hyperbolicPhase\_identity对实η≠0及|h/η|<1的等式正确，额外实域前提明确且必要；展开cosh差公式即得cosh(a)−r sinh(a)。它没有覆盖纯虚η或实|h/η|≥1，也未给整个稳定不等式的全参数等价声明。不能由这个有效的受限等式确认原书对所有γ>0的措辞。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。

### 7. 状态与证明位置

- `MD.Ch07.hyperbolicPhase`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hyperbolicPhase_identity`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-UnderdampedPhasePrinted

印刷页 325 / PDF页 346。

### 1. 原文陈述

> We consider the case with $`\gamma\ll\Omega`$, allowing us to write $`\eta=i\widehat\eta`$ for $`\widehat\eta\in\mathbb R`$, and

$$
\left|\cos\left(\frac{\widehat\eta h}{2}-\operatorname{atanh}\left(\frac h{\widehat\eta}\right)\right)\sqrt{1+\frac{h^2}{\widehat\eta^2}}\right|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def underdampedPhasePrinted (η h : ℝ) : ℝ :=
  Real.cos (η*h/2-Real.artanh (h/η))*Real.sqrt (1+h^2/η^2)
def underdampedPhasePrinted_corrected (η h : ℝ) : ℝ :=
  Real.sqrt (1+(h/η)^2)*Real.cos (η*h/2+Real.arctan (h/η))
theorem underdampedPhase_identity (a r : ℝ) :
    Real.cos a-r*Real.sin a = Real.sqrt (1+r^2)*Real.cos (a+Real.arctan r) := by
  rw [Real.cos_add,Real.cos_arctan,Real.sin_arctan]
  have hs : Real.sqrt (1+r^2) ≠ 0 := ne_of_gt (Real.sqrt_pos.2 (by positivity))
  field_simp
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文版与修正版分别定义，原文版不证明；直接用幅相恒等式绕过复函数分支。η̂=√(4Ω²-γ²)>0需要明确欠阻尼条件。
- 29号覆盖限定：字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。Printed定义忠实表达字面公式。corrected定义以及对任意实a,r的underdampedPhase\_identity均正确：cos(a)−r sin(a)=√(1+r²)cos(a+arctan(r))。这是代入η=iη̂后应得形式；η̂>0及η̂²=4Ω²−γ²的模型衔接未在该独立三角恒等式内声明。EXTRA正确承认这一点。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：字面三角式及+arctan修正版、任意实a/r的恒等式；模型代入须0≤γ<2Ω及ηhat>0，未由此声称全稳定定理。

### 7. 状态与证明位置

- `MD.Ch07.underdampedPhasePrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.underdampedPhasePrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.underdampedPhase_identity`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-StabilityEnvelope

印刷页 325 / PDF页 346。

### 1. 原文陈述

> The oscillatory cosine term is bounded between $`\pm1`$, implying that we have stability for all step sizes provided the condition

$$
\sqrt{1+h^2/\widehat\eta^2}\le\cosh(\gamma h/2),\tag{7.49}
$$


> holds. We have guaranteed stability where (7.49) holds, which we can simplify to

$$
\frac h{\sqrt{4\Omega^2-\gamma^2}}\le\sinh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def stabilityEnvelope (η γ h : ℝ) : Prop := Real.sqrt (1+h^2/η^2) ≤ Real.cosh (γ*h/2)
theorem stabilityEnvelope_sufficient (η γ h : ℝ) (he : stabilityEnvelope η γ h) :
    |underdampedPhasePrinted_corrected η h| ≤ Real.cosh (γ*h/2) := by
  dsimp [underdampedPhasePrinted_corrected]
  calc
    _ ≤ Real.sqrt (1+(h/η)^2)*1 := by
      rw [abs_mul,abs_of_nonneg (Real.sqrt_nonneg _)]
      exact mul_le_mul_of_nonneg_left (Real.abs_cos_le_one _) (Real.sqrt_nonneg _)
    _ = Real.sqrt (1+h^2/η^2) := by rw [div_pow,mul_one]
    _ ≤ _ := he
theorem stabilityEnvelope_iff (η γ h : ℝ) (hη : 0 < η) (hγ : 0 ≤ γ) (hh : 0 ≤ h) :
    stabilityEnvelope η γ h ↔ h/η ≤ Real.sinh (γ*h/2) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 stabilityEnvelope, stabilityEnvelope\_sufficient, stabilityEnvelope\_iff 所列对象、量词、前提和结论。范围说明：sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用/cos/≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- “所有步长”指对每个h满足该条件；一次h的包络条件不能声称自动覆盖所有h。仍仅为谱模不超过1的充分条件，严格随机平稳性另需严格不等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用|cos|≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 stabilityEnvelope, stabilityEnvelope\_sufficient, stabilityEnvelope\_iff 所列对象、量词、前提和结论。范围说明：sufficient对任意实参数，只从包络条件推出修正相位的绝对值界；利用|cos|≤1正确，包括Lean总化除法的退化参数也仅为形式代数结论。iff在η>0、γ≥0、h≥0下正确，因cosh²−1=sinh²及两边非负可等价平方/开方。模型中需另认η=η̂>0。量词是每个给定h的条件，不是单次验证即推出所有h。未声称噪声边界平稳性。

### 7. 状态与证明位置

- `MD.Ch07.stabilityEnvelope`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.stabilityEnvelope_sufficient`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.stabilityEnvelope_iff`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-FrictionThresholdPrinted

印刷页 325 / PDF页 346。

### 1. 原文陈述

> The minimum required friction for stability can be found by considering the case of small timestep. This gives a bound

$$
\frac1{\sqrt{4\Omega^2-\gamma^2}}\le\frac\gamma2,
$$


> which gives a stability condition for all step sizes $`h`$ as long as

$$
\gamma\ge\Omega\sqrt{2-2\sqrt{1-\Omega^{-4}}}\ge\sqrt2/\Omega.
$$


> Therefore we expect that the minimum friction value required for stability for all timesteps $`h\gt 0`$, scales with the value of inverse $`\Omega`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def frictionThresholdPrinted (Ω : ℝ) : ℝ := Ω*Real.sqrt (2-2*Real.sqrt (1-Ω⁻¹^4))
def frictionThresholdPrinted_corrected (Ω : ℝ) : ℝ := Real.sqrt (2/(Ω^2+Real.sqrt (Ω^4-1)))
def frictionBoundPrinted (Ω γ : ℝ) : Prop :=
  frictionThresholdPrinted Ω ≤ γ ∧ Real.sqrt 2/Ω ≤ frictionThresholdPrinted Ω

def frictionBoundPrinted_corrected (Ω γ : ℝ) : Prop :=
  0 < γ ∧ γ < 2*Ω ∧ 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2

theorem frictionThreshold_rationalized (Ω : ℝ) (hΩ : 1 ≤ Ω) :
    frictionThresholdPrinted Ω = frictionThresholdPrinted_corrected Ω := by
  sorry
theorem frictionThreshold_allSteps (Ω γ : ℝ) (hΩ : 1 ≤ Ω) (hγ : 0 < γ) (hu : γ < 2*Ω)
    (hb : 1/Real.sqrt (4*Ω^2-γ^2) ≤ γ/2) :
    ∀ h, 0 ≤ h → stabilityEnvelope (Real.sqrt (4*Ω^2-γ^2)) γ h := by
  sorry
theorem frictionThreshold_asymptotic :
    Filter.Tendsto (fun Ω : ℝ ↦ Ω*frictionThresholdPrinted_corrected Ω) Filter.atTop (𝓝 1) := by
  sorry
theorem frictionThreshold_squared_counterexample : (1 : ℝ) < 2/(5/4 : ℝ) := by norm_num
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 保留原精确根式，它本身与有理化修正版相同；疑误在后续比较方向/系数。欠阻尼上界γ<2Ω显式，不把该范围内的代数条件推广到任意大γ。
- 所有h包络由sinh x≥x推出，严格稳定与随机矩界仍需另证。反例给出有理平方数值，完整根式代入识别未另证明。
- 29号覆盖限定：字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。Printed定义及frictionBoundPrinted忠实保留错误链。rationalized在Ω≥1时正确；allSteps在Ω≥1、0<γ<2Ω及小步长包络斜率条件下推出所有h≥0的包络，正确；asymptotic极限为1正确。corrected的frictionBound保留隐式条件，避免仅用γ≥低根而漏掉高根上界。squared\_counterexample只有1<8/5的数值真命题，并未将其联结至Ω=√5/2的根式，所以不是Lean中完整的原命题反例；EXTRA已说明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：字面错误阈值、保留隐式条件的修正版、Ω≥1有理化/渐近/包络充分性；简化成γ区间须保留高根上界，数值反例不是完整Lean势模型反例。

### 7. 状态与证明位置

- `MD.Ch07.frictionThresholdPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThresholdPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionBoundPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionBoundPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_rationalized`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_allSteps`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_asymptotic`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.frictionThreshold_squared_counterexample`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.1-ConfigurationalSampling

印刷页 262 / PDF页 283。

### 1. 原文陈述

> we often only wish to know the average of a given function $`\phi(q)`$ with respect the configurational density $`\exp(-\beta U(q))`$, where $`U`$ is the potential energy function of a molecular system.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def configurationalSamplingAverage (U φ : V n → ℝ) (β : ℝ) : ℝ :=
  ∫ q, φ q ∂positionGibbs U β

def configurationalSamplingQualified (U φ : V n → ℝ) (β : ℝ) : Prop :=
  0 < β ∧ IsProbabilityMeasure (positionGibbs U β) ∧ Integrable φ (positionGibbs U β)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 configurationalSamplingAverage, configurationalSamplingQualified 所列对象、量词、前提和结论。范围说明：positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文省略归一常数；positionGibbs定义体保留实际配分积分。可积性与概率归一资格单列，不把未归一指数直接视为概率密度。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 configurationalSamplingAverage, configurationalSamplingQualified 所列对象、量词、前提和结论。范围说明：positionGibbs依赖体明确为相对Lebesgue体积的归一指数密度；平均为该测度积分。Qualified对β>0、测度确为概率及φ可积单列资格，避免Lean总化积分在配分函数发散或不可积时被误作有效期望。n、U、φ全量化且域为Fin n→ℝ，对应配置空间。无偷加概率归一结论。

### 7. 状态与证明位置

- `MD.Ch07.configurationalSamplingAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.configurationalSamplingQualified`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.1-HamiltonianSamplingObstruction

印刷页 262 / PDF页 283。

### 1. 原文陈述

> Note that deterministic methods (e.g. Hamiltonian dynamics itself) can sometimes be used for molecular sampling, but without stochastic perturbation, such methods are not rigorously ergodic, since the Liouvillian operator does not possess a spectral gap and does not provide a unique stationary solution.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def energyConservingFlow (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧ ∀ t x, H (F t x) = H x

theorem energySublevel_invariant (H : Phase n → ℝ) (F : ℝ → Phase n → Phase n)
    (hf : energyConservingFlow H F) (a t : ℝ) :
    (F t) ⁻¹' {x | H x ≤ a} = {x | H x ≤ a} := by
  ext x
  change H (F t x) ≤ a ↔ H x ≤ a
  rw [hf.2.2 t x]

def energyObstructionQualified (μ : Measure (Phase n)) (H : Phase n → ℝ)
    (F : ℝ → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure μ ∧ energyConservingFlow H F ∧
    (∀ t, MeasurePreserving (F t) μ μ) ∧
    ∃ a, MeasurableSet {x | H x ≤ a} ∧ 0 < μ {x | H x ≤ a} ∧ μ {x | H x ≤ a} < 1
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 本条只证明保能流的能量子水平集不变；结合非平凡概率质量可形成遍历性障碍。能量壳上的遍历性不能由原句否定。
- 原句未指定Liouvillian定义域、函数空间与参考概率。谱隙缺失和多个平稳解的完整算子陈述列为覆盖缺口，不把子水平集恒等式标作整段谱理论的证明。
- 29号覆盖限定：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。
- 覆盖缺口：29号覆盖限定：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。energyConservingFlow具有F0=id、全实时间流合成律及保能；energySublevel\_invariant对任意a,t给出原像集合相等，正确。Qualified补上概率、测度保持及一个可测且质量严格介于0和1的能量子水平集，足以解释全相空间遍历障碍，但它只是资格定义，不是非遍历性定理；尤其没有Liouvillian定义域、谱隙或多个平稳解的声明。statement\_scope已经诚实缩小，不据此声称整段谱理论已形式化。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：保能流、子水平集不变和非平凡能量分布的保测概率资格定义；非遍历性及Liouvillian谱隙/多稳态定理未覆盖，不排除固定能壳遍历。

### 7. 状态与证明位置

- `MD.Ch07.energyConservingFlow`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.energySublevel_invariant`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.energyObstructionQualified`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

