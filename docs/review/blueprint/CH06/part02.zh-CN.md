[上一部分](part01.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## MD-6.2.1-InterpolatedWalk

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> For points between $`t_k`$ and $`t_{k+1}`$ we define the value of $`Y(t)`$ by linear interpolation:

$$
Y(t)=Y_k+\frac{t-t_k}{\delta t}\Delta Y_k.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def interpolatedWalk {Ω : Type*} (J : ℕ → Ω → ℝ) (dt t : ℝ) (sample : Ω) : ℝ :=
  let n := Nat.floor (t / dt)
  MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample + (t - n * dt) / dt *
    (MolecularDynamics.Chapter06Review.diffusiveWalk J dt (n+1) sample - MolecularDynamics.Chapter06Review.diffusiveWalk J dt n sample)
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

网站原返回：PASS。在dt>0、t≥0的原语境，n=Nat.floor(t/dt)正是网格区间编号；增量为Y_(n+1)-Y\_n，系数(t-n dt)/dt正确，端点也与网格值一致。定义对其他实数的延拓未声称为原书正步长过程。A层公式因子位置须恢复原页顺序。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.interpolatedWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:679`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkIncrement

印刷p.225–226 / PDFp.246–247；§6.2.1。

### 1. 原文陈述

> The increments of the random walk are the differences $`\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}`$, thus $`(X_n)`$ is a random process with independent increments.
> We will use the shorthand $`Y_k=Y(t_k)`$ and $`\Delta Y_k=Y_{k+1}-Y_k=\sqrt{\delta t}J_k`$. The increments are clearly independent.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def walkIncrement {Ω : Type*} (J : ℕ → Ω → ℝ) (dx : ℝ) (n : ℕ) (sample : Ω) : ℝ :=
  MolecularDynamics.Chapter06Review.randomWalk J dx (n+1) sample - MolecularDynamics.Chapter06Review.randomWalk J dx n sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。
- 覆盖缺口：仅覆盖一步差分定义；dx·J、扩散缩放等式及独立增量尚未在本条声明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。walkIncrement对任意样本类型、任意实跳过程J及实dx，定义randomWalk(n+1)-randomWalk(n)。randomWalk=dx*Σ_{k<n}J\_k，故是原文ΔX_(n+1)的重新编号。没有概率测度或J独立前提，因此没有宣称独立性。statement\_scope和coverage\_gaps已诚实注明只覆盖一步差分，未覆盖dx*J等式、扩散缩放或独立增量；按披露的局部范围PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkIncrement` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:686`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkGridMoments

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> Let us observe the following facts, for $`0\leq k\leq l\leq\nu`$

$$
(i)\quad\mathbb E(Y_l-Y_k)=0,\qquad(ii)\quad\operatorname{Var}(Y_l-Y_k)=t_l-t_k.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkGridMoments :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (dt : ℝ) (k l : ℕ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → k ≤ l →
  (∫ sample, MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample ∂P) = 0 ∧
  (∫ sample, (MolecularDynamics.Chapter06Review.diffusiveWalk J dt l sample-MolecularDynamics.Chapter06Review.diffusiveWalk J dt k sample)^2 ∂P) = ((l : ℝ)-k)*dt := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际独立公平L²跳跃、正δt和k≤l；保存零均值与完整增量二阶矩，不假设这些结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀P,J,dt,k,l，D14、dt>0、k≤l。结论含增量均值0及二阶矩((l:ℝ)-k)dt；由零均值与L²等于原Var，涵盖k=l时零增量。无有限ν限制是同一无限跳跃列上的直接推广，可限制到任一窗口。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkGridMoments` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:691`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-InterpolatedWalkMean

印刷p.226 / PDFp.247；§6.2.1。

### 1. 原文陈述

> Then, for $`0\leq t\leq s\leq\tau`$, we have

$$
\mathbb E(Y(s)-Y(t))=0.
$$


> This is easy to demonstrate. However, the intuitive corresponding statement $`\operatorname{Var}(Y(s)-Y(t))=(s-t)`$ does not quite hold due to the reliance on interpolation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem interpolatedWalkMean : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (J : ℕ → Ω → ℝ) (dt t s : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → 0 ≤ t → t ≤ s →
  (∫ sample, MolecularDynamics.Chapter06Review.interpolatedWalk J dt s sample -
    MolecularDynamics.Chapter06Review.interpolatedWalk J dt t sample ∂P) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实线性插值均值；任意有限正时间可置于τ窗口，不声称精确插值方差等于s−t。

### 6. 审计结论（含网站结论）

网站原返回：PASS。∀P,J,dt,t,s，D14、dt>0、0≤t≤s；D24插值值是有限个L²跳跃的确定线性组合，因此两插值之差可积且均值0。没有τ上界是可限制到任意有限窗口的推广；没有错误声称插值方差恰为s-t。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.interpolatedWalkMean` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:700`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WalkDiffusion

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).

$$
W(t)=\widehat{\lim}_{\delta t\to0}\sqrt{\delta t}\sum_{k=0}^{\lfloor t/\delta t\rfloor}J_k.
$$


> The convergence here, signified by the symbol $`\widehat{\lim}`$ is in the sense of distributions (see Appendix B).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem walkDiffusion :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (T : ℝ), MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < T →
  ∃ μ : Measure (C(Icc (0 : ℝ) T, ℝ)), IsProbabilityMeasure μ ∧
    (∀ t : Icc (0 : ℝ) T, μ.map (fun w ↦ w t) = gaussianReal 0 t.1.toNNReal) ∧
    (∀ s t : Icc (0 : ℝ) T, s ≤ t →
      HasLaw (fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w t-w s) (gaussianReal 0 (t.1-s.1).toNNReal) μ) ∧
    (∀ k : ℕ, ∀ ts : Fin (k+1) → Icc (0 : ℝ) T, Monotone ts →
      iIndepFun (fun i : Fin k ↦ fun w : C(Icc (0 : ℝ) T, ℝ) ↦ w (ts i.succ)-w (ts i.castSucc)) μ) ∧
    ∀ F : C(Icc (0 : ℝ) T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
      ∃ Y : ℕ → Ω → C(Icc (0 : ℝ) T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample t, Y K sample t = MolecularDynamics.Chapter06Review.interpolatedWalk J (T/K) t sample) ∧
        Tendsto (fun K ↦ ∫ sample, F (Y K sample) ∂P) atTop (𝓝 (∫ w, F w ∂μ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整连续路径空间C([0,T],ℝ)弱法则、各时Gaussian边际、独立增量和全部有界连续路径检验函数；使用实际线性插值的n项和，不将单时CLT计为路径Donsker已证。
- [EXTRA]印刷含端点的多一项有限和与标准n项版本之差在扩散极限消失须另核；连续版本和不可微性质另条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。P为任意测度、J为可测独立零均值±1跳跃且P为概率；T>0。结论完整量化连续路径概率μ、所有单时边际、任意有序时刻增量法则和独立性，以及每个有界连续路径检验函数的积分极限。插值采用range n而非印刷含端点和，差至多√(T/K)（几乎处处）；与印刷扩散极限一致。[EXTRA]明确加强到路径弱收敛。Y虽在F之后存在，其K>0的值由插值唯一确定，未削弱检验族。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.walkDiffusion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:710`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerVector

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> As we take $`n`$ to infinity, $`\delta t`$ to zero, in such a way that $`n\delta t=t`$, we obtain the random variable $`W(t)`$ such that

$$
W(t)\sim N(0,t).
$$


> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$;

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def wienerVector {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) : Prop :=
  MolecularDynamics.textbookIsWienerVector B P
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

网站原返回：PASS。定义接受任意维数n、非负时间过程B及P；D12要求联合Gaussian、零均值、同坐标min(s,t)协方差、异坐标0及AE连续。属于已在context\_notation注明的多维Wiener结构别名；没有声称由单时CLT构造连续过程。标量边际/增量结论另见第3条。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerVector` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:726`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerIncrement

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> Moreover, we may easily demonstrate that

$$
\mathbb E(W(t)-W(s))^2=|t-s|.\tag{6.7}
$$


> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$;

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerIncrement :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P → ∀ s t : ℝ≥0,
      HasLaw (fun sample ↦ W t sample-W s sample) (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P ∧
      (∫ sample, (W t sample-W s sample)^2 ∂P)=|((t : ℝ)-s)| := by
  intro Ω inst P W hW s t
  have hl : HasLaw (fun sample ↦ W t sample-W s sample)
      (gaussianReal 0 (|((t : ℝ)-s)|).toNNReal) P := by
    convert hW.hasLaw_sub t s using 1
    apply congrArg (gaussianReal 0)
    apply NNReal.coe_injective
    simp [Real.nndist_eq, Real.nnabs]
  refine ⟨hl, ?_⟩
  simpa only [Real.coe_toNNReal _ (abs_nonneg _)] using
    MolecularDynamics.textbookCenteredGaussian_secondMoment hl
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际IsPreBrownianReal模型、任意非负s,t、完整Gaussian法则与二阶矩；不局限等距网格。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意PreBrownian实过程、任意非负s,t，完整保留方差|t−s|的中心Gaussian法则及二阶矩。t<s亦以对称Gaussian分布处理；t=s允许退化法则。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerIncrement` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:732`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerContinuousVersion

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerContinuousVersion :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∃ V : ℝ≥0 → Ω → ℝ, (∀ t, W t =ᵐ[P] V t) ∧ ∀ᵐ sample ∂P, Continuous (fun t ↦ V t sample) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]从实际PreBrownian Gaussian法则构造AE连续修改，保持每个时刻AE一致；不将连续性本身作存在连续版本定理的前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。从PreBrownian假设存在逐时AE相等的修改V，且同一满测度集上V整条非负时间路径连续；没有把连续性作为构造前提。此处是修改而非任意原版本与V不可分辨，符合原文可取连续路径的含义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerContinuousVersion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:750`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerNondifferentiable

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerNondifferentiable :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  (∀ᵐ sample ∂P, Continuous (fun t : ℝ≥0 ↦ W t sample)) →
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t → ¬ DifferentiableAt ℝ (fun s ↦ W s.toNNReal sample) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian法则与连续路径版本，结论AE每个正时刻不可微；不将不可微性作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。加入原版本AE连续假设后，在同一满测度集上所有正实时间点均不可微；不是仅每个固定时刻分别AE不可微。toNNReal在正时刻邻域为恒等。时间0的单侧不可微未陈述，[EXTRA]已明确正时刻范围。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerNondifferentiable` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:758`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerFutureCompletedHistory

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$; this does not depend on whether there is additional information available regarding its value prior to $`\min(t,s)`$, that is to say, the Wiener process is a Markov process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerFutureCompletedHistory
    {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (S : ℝ≥0) (T : ℝ) :
    Indep ((inferInstance : MeasurableSpace C(Icc (0 : ℝ) T, Fin Nc → ℝ)).comap
        (textbookWienerVectorContinuousPath (textbookWienerVectorFuture B S) T))
      (textbookWienerVectorCompletedFiltration B P hB S) P.completion := by
  apply MolecularDynamics.textbookWienerVectorFuture_independent_completed_filtration <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实多维Wiener、真实未来连续路径与整个零集完成的过去filtration独立；独立对象全部保留。粗事件条件概率式另条疑误，不将本条视为该式证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D12真实Wiener向量；未来定义B(S+t)−B(S)，D13在不连续样本上置零。结论为完整未来C([0,T],ℝ^Nc)生成σ代数与所有r≤S的过去σ代数加P零集生成σ代数，在P.completion下独立。T任意实数，T<0的空区间情形无额外断言。确实为未来增量路径独立，非未来原值独立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerFutureCompletedHistory` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:767`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-GridWienerIncrementLaw

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> For the Wiener process, we know that $`W(t)-W(s)`$ is normally distributed with mean zero and variance $`|t-s|`$;

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gridWienerIncrementLaw {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) (k : Fin K) :
    HasLaw (textbookWienerIncrement W T K k) (gaussianReal 0 (T / (K : ℝ≥0))) P := by
  apply MolecularDynamics.textbookWienerIncrement_hasLaw <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]等距T/K网格完整Gaussian法则；任意时刻原结论另条WienerIncrement保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。T为非负、K为自然数、k:Fin K自动使K>0。D14、D15给第k个T/K长度增量，结论为方差T/K的完整Gaussian法则。为已标明的网格辅助条，不冒充任意s,t定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gridWienerIncrementLaw` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:777`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-GridIncrementIndependent

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> this does not depend on whether there is additional information available regarding its value prior to $`\min(t,s)`$, that is to say, the Wiener process is a Markov process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gridIncrementIndependent {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) (K : ℕ) :
    iIndepFun (textbookWienerIncrement W T K) P := by
  apply MolecularDynamics.textbookWienerIncrement_independent <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际等距有限增量族iIndepFun；整条未来路径独立在上一条保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意K个相邻网格增量族整体iIndepFun，非仅两两独立；K=0为空族无碍。任意T≥0及PreBrownian假设与[EXTRA]一致；完整过去独立另在第6条。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gridIncrementIndependent` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:784`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerContinuousPathEval

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerContinuousPathEval {Nc : ℕ} {Ω : Type*}
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (T : ℝ) (sample : Ω)
    (hc : Continuous (fun t ↦ B t sample)) (t : Icc 0 T) :
    textbookWienerVectorContinuousPath B T sample t = B ⟨t.1, t.2.1⟩ sample := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_eval <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]给定连续样本的真实C([0,T],ℝⁿ)值与所有时刻原路径一致；不证明从PreBrownian构造连续修改。

### 6. 审计结论（含网站结论）

网站原返回：PASS。不要求概率空间或Wiener性质；给定一条连续样本，D13真分支在每个t:Icc 0 T的值恰为原B值。假设、全称时间及向量值均吻合辅助求值条。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerContinuousPathEval` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:791`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-WienerContinuousPathMeasurable

印刷p.226–227 / PDFp.247–248；§6.2.1。

### 1. 原文陈述

> an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem wienerContinuousPathMeasurable {Nc : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) (T : ℝ) :
    AEMeasurable (textbookWienerVectorContinuousPath B T) P := by
  apply MolecularDynamics.textbookWienerVectorContinuousPath_aemeasurable <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]给定真实连续Wiener模型导出整个连续路径空间AE可测性；不是将路径可测结论作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。由真实Wiener向量结构（包括AE连续）得整个连续路径空间映射AEMeasurable；不是仅各个时间点可测，也没有将路径可测性当前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerContinuousPathMeasurable` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:799`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-CoarseMarkovPrinted

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> Let $`A(x)`$, $`B(x)`$ and $`C(x)`$ be three events dependent on state variable $`x`$, and let $`t_+\gt t_0\gt t_-`$ be three times, then, for a Markov process $`X(t)`$ we have (using the notation for conditional probability):

$$
\Pr[A(X(t_+))\mid B(X(t_0)),C(X(t_-))]=\Pr[A(X(t_+))\mid B(X(t_0))].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem coarseMarkovPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W : ℝ≥0 → Ω → ℝ), IsPreBrownianReal W P →
  ∀ (a b c : Set ℝ) (past present future : ℝ≥0),
    MeasurableSet a → MeasurableSet b → MeasurableSet c → past < present → present < future →
    0 < P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) →
    P ((W future ⁻¹' a) ∩ ((W present ⁻¹' b) ∩ (W past ⁻¹' c))) /
      P ((W present ⁻¹' b) ∩ (W past ⁻¹' c)) =
    P ((W future ⁻¹' a) ∩ (W present ⁻¹' b)) / P (W present ⁻¹' b) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。字面版在真实PreBrownian下量化任意可测事件a,b,c、past<present<future及正条件事件概率，ENNReal比值忠实表达印刷条件概率式。但原书把完整当前状态换成任意粗事件，一般错误，须保留疑误而不因字面忠实判数学正确。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.coarseMarkovPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:807`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.1-StateMarkovMeaning

印刷p.227 / PDFp.248；§6.2.1。

### 1. 原文陈述

> More generally, when we say that a stochastic process is Markovian, we mean that the probability of a future event conditioned on the current state of the process and the past history of the process is the same as the probability conditioned on the current state of the process.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stateMarkovMeaning {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))

/-- 修正版，对应原文 MD-6.2.1-CoarseMarkovPrinted；改动：以完整当前状态生成的σ代数写条件期望Markov性质。 -/
def coarseMarkovPrinted_corrected {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (X : ℝ≥0 → Ω → ℝ) (history : ℝ≥0 → MeasurableSpace Ω) : Prop :=
  IsProbabilityMeasure P ∧ (∀ t, Measurable (X t)) ∧
  (∀ s, history s = ⨆ r : {r : ℝ≥0 // r ≤ s}, MeasurableSpace.comap (X r) inferInstance) ∧
  ∀ s t : ℝ≥0, s ≤ t → ∀ a : Set ℝ, MeasurableSet a →
    MeasureTheory.condExp (history s) P (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample)) =ᵐ[P]
    MeasureTheory.condExp (MeasurableSpace.comap (X s) inferInstance) P
      (fun sample ↦ a.indicator (fun _ ↦ (1 : ℝ)) (X t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：原版及coarseMarkovPrinted\_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原版及coarseMarkovPrinted\_corrected同时要求概率空间、X各时可测和history严格等于全部过去生成的自然过滤；排除任意history伪Markov。

### 6. 审计结论（含网站结论）

网站原返回：PASS。stateMarkovMeaning与coarseMarkovPrinted\_corrected完全相同：概率空间、每时X可测、history严格等于0≤r≤s的全部自然历史；对s≤t及所有可测实事件a，未来事件指标关于历史与当前状态的条件期望AE相等。指标可积且两个σ代数从X的可测性均小于环境σ代数，排除了任意history和默认零条件期望的伪性质。是实值过程标准自然历史Markov定义，两版PASS。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stateMarkovMeaning` | 定义 | — | PASS |
| `MD.Ch06.coarseMarkovPrinted_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:819`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-RiemannTags

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> Recall that the Riemann integral of a continuous function $`g`$ on $`[0,\tau]`$ is the limit of Riemann sums constructed as follows: partition the interval $`[0,\tau]`$ into $`K`$ subintervals each of width $`\delta t=\tau/\nu`$, choose an arbitrary $`t_k`$ from the $`k`$th subinterval, $`1\leq k\leq \nu`$, and evaluate the integral as a limit of the sum of products:

$$
\int_0^\tau g(t)dt=\lim_{\nu\to\infty}\sum_{k=0}^{\nu-1}g(t_k)\delta t.
$$


> We know that this limit does not depend on where the $`t_k`$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem riemannTags : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem riemannTags_corrected : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]非负窗口和所有合法任意tags；完整标签无关性，没有缩减为仅左端点特例。
- [EXTRA] 原书文字1≤k≤ν与求和0≤k<ν冲突；本条数学修正版统一0≤k<ν，原句保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。riemannTags与riemannTags\_corrected都对任意连续于[0,T]的g、T≥0及所有合法tag族陈述均匀网格Riemann和趋于区间积分。K>0和k<K只用于标签条件，K=0单项不影响atTop极限；T=0也正确。任意端点或内部tag均包含，未降成左端点特例。两个数学签名PASS，但这是统一索引后的版本，原文索引疑误应保留NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.riemannTags` | 未证 | 时间盒止 | PASS |
| `MD.Ch06.riemannTags_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:841`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-ItoLeftSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def itoLeftSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g ((k : ℝ) * T / K) sample *
    (W (((k : ℝ)+1) * T / K) sample - W ((k : ℝ) * T / K) sample)
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

网站原返回：PASS。W,g是实时间随机函数，任意T和K的有限和；左端点kT/K与相应W增量均正确，range K精确为0到K−1；仅定义有限和，不断言存在极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.itoLeftSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:857`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StrictItoIntegral

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.
> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)

/-- 修正版，对应原文 MD-6.2.2-WeakItoAlias；改动：严格定义要求每个有限和及极限变量均属于L²；正式库冻结，只在Blueprint使用严格版。 -/
def weakItoAlias_corrected {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式所有有限和与极限的L²资格，防止Bochner非可积默认值0伪造均方收敛；真实取样和极限，不假设任何求值结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意P、W,g,T,Y；每个有限和及Y均MemLp 2，再要求误差平方积分趋零。D16取样相符。所附weakItoAlias\_corrected逐项相同，合理修复第16条非可积默认值漏洞；作为L²均方积分定义不声称所有g可积。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictItoIntegral` | 定义 | — | PASS |
| `MD.Ch06.weakItoAlias_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:863`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-WeakItoAlias

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> where the increments $`W((k+1)\delta t)-W(k\delta t)`$ identified here are the increments of a Wiener process whose properties are given above. (In particular they are normally distributed with mean zero and variance $`\delta t`$.) First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.
> Next, unlike in the case of the Riemann sums, it turns out that the result depends on where we place the points $`t_k`$. Using the properties of the Wiener process we may easily show that the choice $`t_k=k\delta t`$ (left endpoint) and the choice $`t_k=(k+1/2)\delta t`$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def weakItoAlias {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample, (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample - Y sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 采用既有strictItoIntegral的全部有限和L²资格；极限及平方误差的可积性不再被Bochner默认零掩盖。正式库旧辅助保持冻结。

### 6. 审计结论（含网站结论）

网站原返回：PASS。weakItoAlias是任意测度P、过程W,g、实T和候选Y的均方左和极限关系：每个K的itoLeftSum及Y均为L²，平方误差积分趋0。D3的和确用左端点kT/K和相邻W增量。L²前提排除了不可积函数Bochner默认零的漏洞。作为左和极限关系定义PASS；P不是自动概率、W不是自动Wiener、g不是自动适应，此定义本身不授予标准Itô积分的存在性或一般等距性质，不能扩充解释。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.weakItoAlias` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:878`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StratonovichSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> By analogy, we would like to write the stochastic integral of a function $`g`$, where $`g`$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:

$$
\sum_{k=0}^{\nu-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad \nu\to\infty.
$$


> The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)
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

网站原返回：PASS。真实时间中点((k+1/2)T/K)处取g值，而非端点g均值；W增量及0到K−1索引均正确。只定义原书中点和，不声称对任意随机g等于一般Stratonovich积分。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stratonovichSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:884`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoFiniteIdentity

印刷p.228–229 / PDFp.249–250；§6.2.2。

### 1. 原文陈述

> As an example, consider the case where $`g(t)=W(t)`$. We suppose this to be approximated by a sum

$$
\int_0^\tau W(t)dW(t)\approx\sum_{k=0}^{\nu-1}W(k\delta t)[W((k+1)\delta t)-W(k\delta t)],
$$



$$
=\frac12\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2-(W((k+1)\delta t)-W(k\delta t))^2].
$$


> Breaking this into two parts, we see that the first sum telescopes to give $`W(\tau)^2`$ (as $`W(0)=0`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoFiniteIdentity {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    ∀ᵐ sample ∂P, 2 * textbookWienerSelfItoSum W T K sample =
      W T sample ^ 2 - textbookWienerQuadraticSum W T K sample := by
  apply MolecularDynamics.textbookWienerSelfItoSum_identity <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实PreBrownian、K>0和AE W0=0；保存完整有限和望远镜恒等。

### 6. 审计结论（含网站结论）

网站原返回：PASS。K>0，PreBrownian给W0=0几乎处处；D18左和与D17平方增量和构成2S=W(T)^2−Q的AE有限恒等，完整保留望远镜结果而没有把积分极限偷当前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoFiniteIdentity` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:890`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-Proposition62

印刷p.229–230 / PDFp.250–251；§6.2.2。

### 1. 原文陈述

> Proposition 6.2 Let $`\nu\delta t=\tau`$ then

$$
\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,
$$


> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$


> (This is referred to as convergence in the mean square sense.)

### 2. 原文证明

> With $`\tau,\nu`$ fixed, we have $`\delta t=\tau/\nu`$.
> Let $`\Delta W_{\nu,k}=W((k+1)\delta t)-W(k\delta t)=W((k+1)\tau/\nu)-W(k\tau/\nu)`$ and observe that

$$
\sum_{k=0}^{\nu-1}\Delta W_{\nu,k}^2-\tau=\sum_{k=0}^{\nu-1}[\Delta W_{\nu,k}^2-\delta t].
$$


> Then

$$
I_\nu\stackrel{\rm def}=\mathbb E(\sum_{k=0}^{\nu-1}\Delta W_{\nu,k}^2-\tau)^2=\mathbb E(\sum_{k=0}^{\nu-1}[\Delta W_{\nu,k}^2-\delta t])^2.
$$


> Terms of the form $`Z_{\nu,k}\stackrel{\rm def}=\Delta W_{\nu,k}^2-\delta t`$ are independent and have mean zero. Therefore

$$
\mathbb E(\sum_{k=0}^{\nu-1}Z_{\nu,k})^2=\mathbb E\sum_{k=0}^{\nu-1}Z_{\nu,k}^2-2\mathbb E\sum_{k\ne l}Z_{\nu,k}Z_{\nu,l}=\mathbb E\sum_{k=0}^{\nu-1}Z_{\nu,k}^2,
$$


> where the last equation follows from independence of the increments ($`\mathbb E Z_kZ_l=0`$ if $`k\ne l`$).
> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$


> Thus we have

$$
I_\nu=\sum_{k=0}^{\nu-1}\mathbb E(\Delta W_{\nu,k}^2-\delta t)^2 =\sum_{k=0}^{\nu-1}\mathbb E[\Delta W_{\nu,k}^4-2\delta t\Delta W_{\nu,k}^2+\delta t^2] =\sum_{k=0}^{\nu-1}[3\delta t^2-2\delta t^2+\delta t^2]=2\nu\delta t^2=2\tau^2/\nu.
$$


> Thus $`I_\nu\to0`$ as $`\nu\to0`$, which is the desired result.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition62 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 修正版，对应原文 MD-6.2.2-Proposition62；改动：保持已证二次变差结论；独立记录印刷平方展开与其正确代数式，并注明极限方向。 -/
theorem proposition62_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    Tendsto (fun K : ℕ ↦ ∫ sample,
      (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) atTop (𝓝 0) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto <;> assumption

/-- 【原书疑误】p.229错误交叉项展开；双变量形式，原文不证。 -/
def proposition62Printed (x y : ℝ) : ℝ := x^2+y^2-4*x*y

/-- 修正平方展开；有序交叉和的系数为+1。 -/
theorem proposition62Expansion_corrected (x y : ℝ) : (x+y)^2=x^2+y^2+2*x*y := by
  ring

theorem proposition62Printed_counterexample : ¬ ((1+1 : ℝ)^2=1^2+1^2-4*1*1) := by
  norm_num
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian law、τ≥0、全部均方极限；印刷最后K→0是笔误，更正K→∞。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。proposition62及proposition62\_corrected：实际IsPreBrownianReal、T≥0，均匀网格平方增量和的均方误差atTop趋0，签名正确。WienerTime=k*T/K、WienerIncrement为相邻差、QuadraticSum为Fin K平方和，均核对。proposition62Printed定义x²+y²-4xy，忠实记录按有序k≠l理解印刷展开的两变量表达；未将错误式当定理。proposition62Expansion\_corrected的普通平方展开正确；proposition62Printed\_counterexample在x=y=1正确。原书一般代数展开错误虽因独立零均值而不改变期望最终结果，仍需标疑误；末极限应为ν→∞。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition62` | 已证 | — | PASS |
| `MD.Ch06.proposition62_corrected` | 已证 | — | PASS |
| `MD.Ch06.proposition62Printed` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.proposition62Expansion_corrected` | 已证 | — | PASS |
| `MD.Ch06.proposition62Printed_counterexample` | 已证 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:900`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-MeanSquareConvergence

印刷p.229 / PDFp.250；§6.2.2。

### 1. 原文陈述

> where, for a sequence of random variables, $`A_\nu`$ and a random variable $`B`$, we have

$$
\operatorname{l.i.m.}_{\nu\to\infty}A_\nu=B\iff\lim_{\nu\to\infty}\mathbb E(A_\nu-B)^2=0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]显式L²随机变量资格防止非可积Bochner默认值；不假设收敛结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义量化所有K的L²资格、B的L²资格及误差平方期望趋零；比印刷速记补足合法均方随机变量域，[EXTRA]已明确。并非仅形式Bochner默认0。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.meanSquareConvergence` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:925`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-WienerMidpointSum

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> The choice $`t_k=k\delta t`$ (left endpoint) and the choice $`t_k=(k+1/2)\delta t`$ yield different formulas for the integral. The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def wienerMidpointSum {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} (W : ℝ≥0 → Ω → ℝ) (T : ℝ≥0) (K : ℕ) : Ω → ℝ :=
  fun sample ↦ ∑ k : Fin K, W (textbookWienerTime T (2 * K) (2 * k.val + 1)) sample *
    textbookWienerIncrement W T K k sample
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

网站原返回：PASS。Fin K上取W((2k+1)T/(2K))乘整步增量，K>0时精确时间中点；K=0为空和。虽有未使用的P隐参，不改变数学内容。仅g=W辅助定义。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.wienerMidpointSum` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:931`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementMean

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementMean {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω}
    {X : Ω → ℝ} {v : ℝ≥0} (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ∂P) = 0 := by
  rw [hX.integral_eq, integral_id_gaussianReal]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]任意真实中心Gaussian完整法则推出零均值；增量law桥接先前已保存。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意HasLaw X (gaussianReal 0 v) P，v≥0，推出期望0；真实增量法则在第7条提供。此条只承载三项矩公式的第一项，其余分别由第23、24条承载。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementMean` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:937`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementSecond

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementSecond {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 2 ∂P) = (v : ℝ) := by
  apply MolecularDynamics.textbookCenteredGaussian_secondMoment <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同一中心Gaussian完整法则推出二阶矩v，包括v=0；未把二阶矩作为前提，网格代入v=T/K与原式一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementSecond` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:944`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-GaussianIncrementFourth

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Also observe that $`\Delta W_k`$ is a normally distributed random variable with the following properties

$$
\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/\nu;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/\nu)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem gaussianIncrementFourth {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {X : Ω → ℝ} {v : ℝ≥0}
    (hX : HasLaw X (gaussianReal 0 v) P) :
    (∫ sample, X sample ^ 4 ∂P) = 3 * (v : ℝ) ^ 2 := by
  apply MolecularDynamics.textbookCenteredGaussian_fourthMoment <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实中心Gaussian法则导出完整矩；不将矩结论前置。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意中心Gaussian完整法则推出四阶矩3v²，包括退化v=0；并未遗漏四次幂或误用标准差。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.gaussianIncrementFourth` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:951`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-QuadraticMeanSquareError

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> Thus we have

$$
I_\nu=\mathbb E\sum_{k=0}^{\nu-1}(\Delta W_{\nu,k}^2-\tau/\nu)^2 =\sum_{k=0}^{\nu-1}\mathbb E\left(\Delta W_{\nu,k}^4-2\frac{\tau}{\nu}\Delta W_{\nu,k}^2+\frac{\tau^2}{\nu^2}\right) =\sum_{k=0}^{\nu-1}\left(3(\tau/\nu)^2-2(\tau/\nu)^2+\tau^2/\nu^2\right)=2\frac{\tau^2}{\nu^2}\nu=2\frac{\tau^2}{\nu}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem quadraticMeanSquareError {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, (textbookWienerQuadraticSum W T K sample - (T : ℝ)) ^ 2 ∂P) =
      2 * (T : ℝ) ^ 2 / (K : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_meanSquareError <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian且K>0；精确误差，不是仅Tendsto0。

### 6. 审计结论（含网站结论）

网站原返回：PASS。T≥0，K>0，实际PreBrownian平方增量和的整体误差平方期望精确等于2T²/K；不是仅逐项矩或仅极限。D14、15、17的网格与原书一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.quadraticMeanSquareError` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:958`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoIntegral

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> The calculation implies that

$$
\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerSelfItoSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = (W T sample ^ 2 - (T : ℝ)) / 2 := by
  apply MolecularDynamics.textbookWienerSelfItoIntegral_exists <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实L²见证、全均方收敛及AE求值三项保留；有限和L²另条补足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在Y∈L²、真实D18左和整体均方趋于Y、Y几乎处处等于(W(T)²−T)/2三项齐全。任意T≥0；没有把积分求值当前提。有限和L²不在此签名显式陈述，但对PreBrownian有限Gaussian乘积成立。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoIntegral` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:966`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfStratonovichIntegral

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> In contrast, the Stratonovich (midpoint) integral (denoted by $`\int_0^\tau\circ dW(t)`$) can be calculated as

$$
\int_0^\tau W(t)\circ dW(t)=\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].
$$


> Writing

$$
W(k\delta t+\delta t/2)=W(\frac{(k+1)\delta t+k\delta t}{2})=\frac12(W((k+1)\delta t)+W(k\delta t))+O(\sqrt{\delta t}),
$$


> allows us to evaluate the integral as

$$
\int_0^\tau W(t)\circ dW(t)=\frac12\operatorname{l.i.m.}_{\nu\to\infty}\sum_{k=0}^{\nu-1}[W((k+1)\delta t)^2-W(k\delta t)^2]=\frac12W(\tau)^2.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfStratonovichIntegral {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem selfStratonovichIntegral_corrected {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerMidpointSum W T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧ ∀ᵐ sample ∂P, Y sample = W T sample ^ 2 / 2 := by
  apply MolecularDynamics.textbookWienerSelfStratonovichIntegral_exists <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实时间中点和、L²见证、整体均方极限、AE求值；原O(√δt)单步启发不足，正式整体均方误差证明不直接丢弃逐步残项。
- [EXTRA] 仅覆盖真实时间中点和的均方结论；原单步O(√dt)推理未控制总误差，不能当成完整证明；所需Brownian桥残差估计未补建。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。selfStratonovichIntegral及\_corrected在IsPreBrownianReal、T≥0下给出L²见证Y、真实时间中点和的均方收敛及Y=W(T)²/2的AE求值，数学签名PASS。MidpointSum确取2K细网格的2k+1时刻，并非端点值平均。布朗增量Gaussian四阶矩保证各和及极限的资格。原书将单步中点桥差O(sqrt(dt))直接舍掉未控制总和，不能单凭该行作完整证明；两相同定理签名没有解决原书论证缺口。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfStratonovichIntegral` | 已证 | — | PASS |
| `MD.Ch06.selfStratonovichIntegral_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:976`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-Proposition63

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Proposition 6.3 Let $`g`$ be a smooth deterministic function and $`W(t)`$ a Wiener process. The stochastic integral $`Y(t)=\int_0^t g(s)dW(s)`$ is, for all times $`t\geq0`$, a normally distributed random variable such that

$$
\mathbb E(Y(t))=0;\quad\mathbb E(Y^2(t))=\sigma^2(t)=\int_0^t g(s)^2ds.
$$



### 2. 原文证明

> See Exercise 2.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem proposition63 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) {g : ℝ → ℝ} (hg : ContDiff ℝ 1 g) (T : ℝ≥0) :
    ∃ Y : Ω → ℝ, MemLp Y 2 P ∧
      Tendsto (fun K : ℕ ↦ ∫ sample, (textbookWienerDeterministicSum W g T K sample - Y sample) ^ 2 ∂P)
        atTop (𝓝 0) ∧
      HasLaw Y (gaussianReal 0 (textbookWienerDeterministicVariance g T)) P ∧
      (∫ sample, Y sample ∂P) = 0 ∧ (∫ sample, Y sample ^ 2 ∂P) = ∫ x in (0 : ℝ)..T, g x ^ 2 := by
  apply MolecularDynamics.textbookWienerDeterministicIto_proposition63 <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian与C¹ g已足；完整构造L²见证、均方极限、Gaussian law、零均值及二阶矩，不仅保存矩。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意T≥0、PreBrownian及C¹实确定函数g；存在Y∈L²，实际左和均方收敛；Gaussian完整法则的方差是∫g²的toNNReal（非负故不截断值）；均值0及二阶矩等于∫g²齐全。C¹比原smooth弱且足够。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.proposition63` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:993`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-QuadraticSumExpectation

印刷p.229 / PDFp.250；§6.2.2。

### 1. 原文陈述

> On the other hand, from (6.7), we have

$$
\lim_{\nu\to\infty}\mathbb E\sum_{k=0}^{\nu-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem quadraticSumExpectation {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    (∫ sample, textbookWienerQuadraticSum W T K sample ∂P) = (T : ℝ) := by
  apply MolecularDynamics.textbookWienerQuadraticSum_integral <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际上每个K>0有限和期望已经恰等于τ；均方极限在Prop6.2保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。K>0时平方增量有限和期望已经等于T，较原文极限式强并直接蕴含它；[EXTRA]准确注明。非负窗口、真实PreBrownian及完整和均保留。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.quadraticSumExpectation` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1004`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoLimitL2

印刷p.228 / PDFp.249；§6.2.2。

### 1. 原文陈述

> First, we should be careful regarding the sense in which we expect convergence, since sequences of random variables may converge in various ways.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoLimitL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) :
    MemLp (fun sample ↦ (W T sample ^ 2 - (T : ℝ)) / 2) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoLimit_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。签名只证明候选极限(W(T)²−T)/2的MemLp 2 P，数学正确。extra\_assumptions声称“有限和/候选极限”两者L²，但此签名没有有限和L²结论，须缩减标注。引文实际在印刷228页，并不在所配附件第39页（印刷230）。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoLimitL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1011`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-SelfItoSumsL2

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> The calculation implies that

$$
\int_0^\tau W(t)dW(t)=\frac12(W(\tau)^2-\tau).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem selfItoSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerSelfItoSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerSelfItoSum_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Ω任意可测空间，P任意测度但hW给出PreBrownian资格；T非负、K正。结论仅左点有限乘积和属于L²，没有候选极限或收敛结论。有限联合Gaussian的四阶矩足够，签名正确；[EXTRA]中的“候选极限”超出本声明。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.selfItoSumsL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1018`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-MidpointSumsL2

印刷p.230 / PDFp.251；§6.2.2。

### 1. 原文陈述

> In contrast, the Stratonovich (midpoint) integral (denoted by $`\int_0^\tau\circ dW(t)`$) can be calculated as

$$
\int_0^\tau W(t)\circ dW(t)=\mathrm{l.i.m.}_{ u\to\infty}\sum_{k=0}^{ u-1}W(k\delta t+\delta t/2)[W((k+1)\delta t)-W(k\delta t)].
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem midpointSumsL2 {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {W : ℝ≥0 → Ω → ℝ}
    (hW : IsPreBrownianReal W P) (T : ℝ≥0) {K : ℕ} (hK : 0 < K) :
    MemLp (textbookWienerMidpointSum W T K) 2 P := by
  apply MolecularDynamics.textbookWienerMidpointSum_memLp <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际有限和/候选极限的L²资格，由Gaussian law证明，不作为求值假设；补足严格均方意义。

### 6. 审计结论（含网站结论）

网站原返回：PASS。同第1条的空间/测度资格；T≥0、K>0；依D1、D2及所列定义，采样时间为(2k+1)T/(2K)，乘整段增量。仅有限和MemLp 2正确；未证明候选极限资格或收敛。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.midpointSumsL2` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1025`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicIntegralProcess

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Also it is natural to view the stochastic integral as the solution of the stochastic differential equation (SDE) with zero initial condition:

$$
dY(t)=g(t)dW(t);\quad Y(0)=0.\tag{6.8}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def deterministicIntegralProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun s _ ↦ g s) T (Y T)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]全部非负时间真实严格L²积分关系；Y0=0从零时间L²极限导出，不能把单时Gaussian独立采样当同一过程。

### 6. 审计结论（含网站结论）

网站原返回：PASS。对同一W,Y以及确定g，量化全部T≥0，D5要求每个有限左点和及Y T的L²资格和均方收敛。T=0的和恒零，所以Y 0=0几乎处处。作为积分关系定义正确；未独立断言W是Wiener、过程路径连续或同时逐样本等式，使用时须另给W资格。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicIntegralProcess` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1032`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicStrobePrinted

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Finally, we observe that by calculating $`\sigma^2(t_n)`$ and generating random increments $`R_n\sim N(0,\sigma(t_n))`$ we have a discrete representation of the continuous time stochastic process $`Y(t)`$, effectively an exact stroboscopic representation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem deterministicStrobePrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  ∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 ((Real.sqrt (∫ s in (0 : ℝ)..times k, g s^2))^2).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Printed保留原书累计尺度N(0,σ(t\_n))；将第二参数解释为标准差并平方传入gaussianReal是额外约定，需确认。本条未摘录所称相邻区间方差与整族独立性的修正版，不能认证该修正版。
- [EXTRA] 复审范围：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
- 覆盖缺口：本条未提供[EXTRA]声称的独立修正版完整声明，无法审校其相邻区间方差及整族独立性。
- 覆盖缺口：Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。deterministicIntegralProcess为每个T≥0的严格均方积分资格，已核对。deterministicStrobePrinted把第k到k+1观测的增量分布方差写成0到times k的累计∫g²（对sqrt再平方），保留了原书增量/边际混淆。N(0,σ)按标准差理解是额外约定；此前书中W(t)∼N(0,t)使用方差式习惯，更需人工确认。[EXTRA]与statement\_scope声称独立修正版包含相邻区间方差和整族独立性，但本条全部摘录没有任何相应\_corrected声明；不能认证未提供的修正版，coverage\_gaps=[]不实。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
Printed保留增量/累计边际方差混淆。独立deterministicStrobePrinted\_corrected位于DeterministicStrobeCorrected来源，已本地存在但本次附件未提供，不能冒称复审PASS。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicStrobePrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1039`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-DeterministicStrobeCorrected

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Finally, we observe that by calculating $`\sigma^2(t_n)`$ and generating random increments $`R_n\sim N(0,\sigma(t_n))`$ we have a discrete representation of the continuous time stochastic process $`Y(t)`$, effectively an exact stroboscopic representation.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem deterministicStrobeCorrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry

/-- 修正版，对应原文 MD-6.2.2-DeterministicStrobePrinted；改动：采用区间积分∫[tₙ,tₙ₊₁]g²及同一过程的独立增量资格。 -/
theorem deterministicStrobePrinted_corrected : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W Y : ℝ → Ω → ℝ) (g : ℝ → ℝ) (times : ℕ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → ContDiff ℝ 1 g →
  deterministicIntegralProcess P W Y g → Monotone times → (∀ k, 0 ≤ times k) →
  (∀ k, HasLaw (fun sample ↦ Y (times (k+1)) sample-Y (times k) sample)
    (gaussianReal 0 (∫ s in times k..times (k+1), g s^2).toNNReal) P) ∧
  iIndepFun (fun k sample ↦ Y (times (k+1)) sample-Y (times k) sample) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]相邻时间积分g²为完整增量方差，并保存整个增量族独立性；不是仅单时law；强L²模型。

### 6. 审计结论（含网站结论）

网站原返回：PASS。PreBrownian、C¹确定g、全部时间严格积分关系、非负单调times足够；各相邻增量的variance为∫[times k,times(k+1)]g²，并断言整个族iIndepFun。允许相等时刻，退化零增量正确。修正数学合理；若称完整stroboscopic表示，应从实际Y(times 0)初始化，或另设times 0=0。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.deterministicStrobeCorrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.deterministicStrobePrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1049`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.2.2-StochasticDifferentialIntegral

印刷p.231 / PDFp.252；§6.2.2。

### 1. 原文陈述

> Importantly, with appropriate regularity we have the familiar relation from calculus:

$$
\int_0^t dY(s)=Y(t)-Y(0).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stochasticDifferentialIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (Y integralOfDifferential : ℝ → Ω → ℝ) : Prop :=
  ∀ T : ℝ, 0 ≤ T → integralOfDifferential T =ᵐ[P] (fun sample ↦ Y T sample-Y 0 sample)
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

网站原返回：PASS。P,Y及integralOfDifferential均任意，对全部T≥0断言两随机变量几乎处处相等。按context\_notation，这是积分符号的语义定义；没有循环地声称已构造一般积分或证明链式法则。无需样本普通导数。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stochasticDifferentialIntegral` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1069`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalk

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> We introduce a pair of smooth functions $`a(x,t)`$ and $`b(x,t)`$, where $`a`$ represents a drift tendency and $`b`$ the average magnitude of the random jump. In the interval $`[n\delta t,(n+1)\delta t]`$, a step $`\delta X_n=X_{n+1}-X_n`$ of the random walk will be given by

$$
\delta X_n=a(X_n,t_n)h+b(X_n,t_n)J_n\delta x.\tag{6.9}
$$


> where the random increment $`J_n`$ was introduced in Sect. 6.2.1.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def biasedWalk {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) : ℕ → Ω → ℝ
  | 0 => fun _ ↦ x0
  | n+1 => fun sample ↦ let x := MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 n sample
    x + a x (n * dt) * dt + b x (n * dt) * Real.sqrt dt * J n sample
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]按正文h=δt及δx=√δt解释真实递归与x0初值；印刷h/δt记号不一致已保留。

### 6. 审计结论（含网站结论）

网站原返回：PASS。递归以x0起始；第n步在n*dt取a,b，漂移a*dt，噪声b*sqrt(dt)*J\_n，次序和乘法正确。MD包装调用Chapter06Review的旧步值，按D10/D11展开逐步一致。作为确定性递归定义允许任意dt,a,b,J；随机游走解释另需dt>0和Rademacher资格。[EXTRA]将h解释为δt需标为解释而非书中显式等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalk` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1075`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalkSum

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Choose a positive $`t`$ and sum (6.9) from $`n=0`$ to $`\nu-1`$, where $`\nu=\lfloor t/\delta t\rfloor`$, obtaining

$$
X_\nu-X_0=\sum_{n=0}^{\nu-1}\delta X_n=\sum_{n=0}^{\nu-1}a(X_n,t_n)\delta t+\sum_{n=0}^{\nu-1}b(X_n,t_n)J_n\delta x.\tag{6.10}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem biasedWalkSum : ∀ {Ω : Type*} (a b : ℝ → ℝ → ℝ) (J : ℕ → Ω → ℝ)
    (dt x0 : ℝ) (K : ℕ) (sample : Ω),
  MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 K sample-x0 =
    (∑ k ∈ Finset.range K, a (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*dt) +
    ∑ k ∈ Finset.range K, b (MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample) (k*dt)*Real.sqrt dt*J k sample := by
  intro Ω a b J dt x0 K sample
  induction K with
  | zero => simp [MolecularDynamics.Chapter06Review.biasedWalk]
  | succ K ih =>
    simp only [MolecularDynamics.Chapter06Review.biasedWalk, Finset.sum_range_succ]
    linarith [ih]
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

网站原返回：PASS。对任意K∈ℕ、任意sample作递归望远镜求和，K=0也成立。K泛化原ν，不丢失原结论；dt和系数无正性/随机性限制也不影响此代数恒等式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalkSum` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1082`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-ScalarSDE

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Take the diffusion limit $`\delta t\to0`$, $`\delta x^2/\delta t\to1`$ with $`\nu\delta t=t`$ fixed, then we obtain, under the Itô convention,

$$
X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).\tag{6.11}
$$



$$
dX=a(X,t)dt+b(X,t)dW.\tag{6.14}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictScalarSDE {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) : Prop :=
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ T : ℝ, 0 ≤ T → (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s) volume 0 T) ∧
    strictItoIntegral P W (fun s sample ↦ b (X s sample) s) T
      (fun sample ↦ X T sample-x0-∫ s in 0..T, a (X s sample) s)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实连续路径、实际可积漂移及全部有限和L²的Ito极限；是方程意义，不计随机游走扩散极限已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D19保留连续路径和确定初值的共同AE集合；每个T≥0漂移路径区间可积，并以完整残差作严格Ito积分。a,b仍状态和时间依赖。作为方程关系定义可接受；[EXTRA]正确说明未由此证明游走极限，W及适应性资格应由使用环境另给。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictScalarSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1096`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-VectorSDE

印刷p.232–233 / PDFp.253–254；§6.3。

### 1. 原文陈述

> We mention in passing the extension to systems of SDEs. Let $`a(z,t)`$ and $`b^{(i)}(z,t)`$, $`i=1,2,\ldots,r`$ be a set of $`r+1`$ vector fields in $`\mathbb R^m`$, and let $`W_1,W_2,\ldots,W_r`$ be a collection of $`r`$ independent Wiener processes, then we may write a system of SDEs in $`\mathbb R^m`$ in the form

$$
dZ=a(Z,t)dt+\sum_{i=1}^r b^{(i)}(Z,t)dW_i.\tag{6.15}
$$


> alternatively, if $`B`$ is the matrix with columns $`b^{(1)},b^{(2)},\ldots,b^{(r)}`$, and $`W`$ represents the $`r`$-component vector of Wiener processes, then

$$
dZ=a(Z,t)dt+B(Z,t)dW.\tag{6.16}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictVectorSDE {Ω : Type*} [MeasurableSpace Ω] {n r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ)) (X : ℝ → Ω → (Fin n → ℝ))
    (a : (Fin n → ℝ) → ℝ → (Fin n → ℝ))
    (B : (Fin n → ℝ) → ℝ → Matrix (Fin n) (Fin r) ℝ) (x0 : Fin n → ℝ) : Prop :=
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  ∀ i : Fin n, ∀ T : ℝ, 0 ≤ T →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample) s i) volume 0 T) ∧
    ∃ integrals : Fin r → Ω → ℝ,
      (∀ j, strictItoIntegral P (fun s sample ↦ W s sample j)
        (fun s sample ↦ B (X s sample) s i j) T (integrals j)) ∧
      (∀ᵐ sample ∂P, X T sample i-x0 i-(∫ s in 0..T, a (X s sample) s i)=∑ j, integrals j sample)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补真实标准向量Wiener资格；该结构给联合Gaussian、全部跨时协方差及连续路径，并有整坐标路径独立定理，不仅是同一时刻独立。其余方程关系保持。
- [EXTRA] 复审范围：strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。
- 覆盖缺口：strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。strictVectorSDE对任意n,r、样本空间、实时间W和X、时变向量a与n×r矩阵B、确定初态x0，要求真实联合Gaussian向量Wiener、AE连续初态、逐坐标逐T漂移可积与各列严格左和积分，增量等于列积分和。D9的Gaussian、零均值、全部跨时协方差和AE连续确可给坐标过程独立，D10、D11已核对，未仅以同一时刻独立代替。但定义不要求X联合可测或相对共同W历史适应，不能未经限定当作标准适应Itô解的完整定义；第28条另外加这些资格印证区别。作为积分方程关系签名正确，作为完整SDE资格仍需人工确认范围。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
strictVectorSDE只定义严格网格积分方程关系，未单独要求X联合可测/共同历史适应，不能等同完整通常Itô解定义。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictVectorSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1105`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-ScalarItoFormula

印刷p.233 / PDFp.254；§6.3.1。

### 1. 原文陈述

> Let $`\phi(\cdot)`$ be any continuously twice differentiable function and let $`X_n\in\mathbb R`$ represent the state of a biased random walk as considered in Sect. 6.3, i.e., with state $`X_{n+1}=X_n+a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x`$.

$$
d\phi(X)=\phi'(X)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi''(X)b(X,t)^2dt.\tag{6.17}
$$



### 2. 原文证明

> Let $`\phi_n=\phi(X_n)`$, then Taylor's theorem gives

$$
\delta\phi\stackrel{\rm def}=\phi_{n+1}-\phi_n=\phi'(X_n)\delta X_n+\tfrac12\phi''(X_n)\delta X_n^2+o(\delta X_n^2) =\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x) +\tfrac12\phi''(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)^2+o(\delta X_n^2).
$$


> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $`\delta x^2\sim\delta t`$, thus we have

$$
\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).
$$


> Passing to the limit, this leads to the SDE.

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem scalarItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 2 φ → ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W (fun t sample ↦ deriv φ (X t sample)*b (X t sample) t) T
    (fun sample ↦ φ (X T sample)-φ x0 - ∫ s in 0..T,
      deriv φ (X s sample)*a (X s sample) s + deriv (deriv φ) (X s sample)*b (X s sample) s^2/2) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。scalarItoFormula：P上的preBrownian、strictScalarSDE（AE连续、确定初态、逐终点漂移可积和严格均方左和关系）、φ为C²、a,b在状态时间上C¹，再加φ′(X)b适应平方可积、X联合可测及自然历史适应、gridItoQualification25。后者含P概率、联合可测和适应、每时L²、每个左和L²以及局部均方Hölder控制，并未假设所求结论。结论为每T≥0下φ(X\_T)-φ(x0)-∫(φ′a+φ″b²/2)等于φ′b的严格均方积分，系数、初项、时变量和量词正确。限定签名PASS，不因sorry判FAIL；原文C²余项推成O(dt^(3/2))及直接过极限缺口保留NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.scalarItoFormula` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1120`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-DiffusiveTaylorPrinted

印刷p.233 / PDFp.254；§6.3.1。

### 1. 原文陈述

> Now we expand the 2nd order term and, working in the diffusion limit, recognize that $`\delta x^2\sim\delta t`$, thus we have

$$
\delta\phi=\phi'(X_n)(a(X_n,n\delta t)\delta t+b(X_n,n\delta t)J_n\delta x)+\tfrac12\phi''(X_n)b(X_n,n\delta t)^2\delta t+O(\delta t^{3/2}).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem diffusiveTaylorPrinted : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 2 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-DiffusiveTaylorPrinted；改动：C²加强为C³，使三阶Taylor余项与扩散缩放匹配。 -/
theorem diffusiveTaylorPrinted_corrected : ∀ (φ : ℝ → ℝ) (x a b : ℝ), ContDiff ℝ 3 φ →
  Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
    (fun dt ↦ φ (x+a*dt+b*Real.sqrt dt)-φ x-deriv φ x*(a*dt+b*Real.sqrt dt)-
      deriv (deriv φ) x*b^2*dt/2) (fun dt ↦ Real.rpow dt (3/2 : ℝ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。diffusiveTaylorPrinted：任意C² φ、任意实x,a,b，沿dt→0+对增量a*dt+b*sqrt(dt)宣称三阶扩散余项BigO，忠实记录原书J=+1特例但断言过强。diffusiveTaylorPrinted\_corrected：C³提供局部三阶Taylor界，混合二阶项也为O(dt^(3/2))，对固定实x,a,b正确。右滤子和实rpow的指数3/2均正确；b可负；此式只包含J=+1分支，J=-1可用替换b覆盖，但不是显式随机极限定理。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.diffusiveTaylorPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.diffusiveTaylorPrinted_corrected` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:1138`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.1-TimeItoFormula

印刷p.234 / PDFp.255；§6.3.1。

### 1. 原文陈述

> We also mention that the Itô-Doeblin formula can be easily generalized to functions of the form $`\phi(x,t)`$:

$$
d\phi(X,t)=\phi_t(X,t)+\phi_x(X,t)(a(X,t)dt+b(X,t)dW)+\tfrac12\phi_{xx}(X,t)b(X,t)^2dt.\tag{6.18}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem timeItoFormula :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 修正版，对应原文 MD-6.3.1-TimeItoFormula；改动：原文右端以形式微分占位量记录，时间偏导补dt；完整修正积分公式独立命名。 -/
theorem timeItoFormula_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 : ℝ) (φ : ℝ×ℝ → ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictScalarSDE P W X a b x0 →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ a w.1 w.2) →
  ContDiff ℝ 1 (fun w : ℝ×ℝ ↦ b w.1 w.2) → ContDiff ℝ 2 φ →
  MolecularDynamics.Chapter06Review.adaptedSquareIntegrand P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  Measurable (Function.uncurry X) →
  (∀ t, 0 ≤ t → @Measurable Ω ℝ (naturalHistory25 W t) inferInstance (X t)) →
  gridItoQualification25 P W (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) →
  ∀ T : ℝ, 0 ≤ T → strictItoIntegral P W
    (fun s sample ↦ fderiv ℝ φ (X s sample,s) (1,0)*b (X s sample) s) T
    (fun sample ↦ φ (X T sample,T)-φ (x0,0) - ∫ s in 0..T,
      fderiv ℝ φ (X s sample,s) (0,1) + fderiv ℝ φ (X s sample,s) (1,0)*a (X s sample) s +
        fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (X s sample,s) (1,0)*b (X s sample) s^2/2) := by
  sorry

/-- 【原书疑误】(6.17)逐字右端形式表达，dX/dXX为形式微分占位；不宣称它是正确积分等式。 -/
def timeItoFormulaPrinted (φ : ℝ×ℝ → ℝ) (x t dX dXX : ℝ) : ℝ :=
  fderiv ℝ φ (x,t) (0,1)+fderiv ℝ φ (x,t) (1,0)*dX+
    fderiv ℝ (fun z ↦ fderiv ℝ φ z (1,0)) (x,t) (1,0)*dXX/2
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 补X联合可测及自然过滤适应、被积过程全部网格和L²与局部均方时间Hölder资格。仅时间积分平方可积的旧签名前提不足且有网站反例；新签名不假设所求积分公式/极限，仍缺一般Itô理论，不证明。Time版与\_corrected同步，漏dt原文形式单列保留。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。timeItoFormula及timeItoFormula\_corrected签名相同：在与标量版一致的preBrownian、严格SDE、C¹ a,b、C²联合φ、联合可测及自然适应X、被积过程适应平方可积和网格L²/Hölder资格下，给出任意T≥0完整积分公式。方向(1,0)为x偏导，(0,1)为t偏导，二次方向导数给φ\_xx；漂移积分已正确包含φ\_t，初值φ(x0,0)，扩散φ\_x*b，系数b²/2均正确，两数学签名PASS。timeItoFormulaPrinted以dX,dXX形式占位保留漏dt的右端，是表达式定义，不是正确积分定理，其文档误标(6.17)，应为(6.18)。原书疑误与已修正主签名不能混认。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.timeItoFormula` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.timeItoFormula_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.timeItoFormulaPrinted` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1154`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3-BiasedWalkDiffusion

印刷p.232 / PDFp.253；§6.3。

### 1. 原文陈述

> Take the diffusion limit $`\delta t\to0`$, $`\delta x^2/\delta t\to1`$ with $`\nu\delta t=t`$ fixed, then we obtain, under the Itô convention,

$$
X(t)-X(0)=\int_0^t a(X(s),s)ds+\int_0^t b(X(s),s)dW(s).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem biasedWalkDiffusion : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (J : ℕ → Ω → ℝ) (W : ℝ → Ω → ℝ) (a b : ℝ → ℝ → ℝ) (x0 T : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J →
  IsPreBrownianReal (fun t sample ↦ W t sample) P →
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ W t sample) (Ici 0)) →
  (∃ L : ℝ≥0, LipschitzWith L (Function.uncurry a) ∧ LipschitzWith L (Function.uncurry b)) → 0 < T →
  ∃ X : ℝ → Ω → ℝ, strictScalarSDE P W X a b x0 ∧
    ∃ paths : Ω → C(Icc 0 T, ℝ),
      (∀ᵐ sample ∂P, ∀ t : Icc 0 T, paths sample t=X t sample) ∧
      ∃ walks : ℕ → Ω → C(Icc 0 T, ℝ),
        (∀ K : ℕ, 0 < K → ∀ sample (t : Icc 0 T),
          walks K sample t = let dt := T/K; let k := Nat.floor ((t : ℝ)/dt);
            MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample +
            ((t : ℝ)-k*dt)/dt*(MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 (k+1) sample-
              MolecularDynamics.Chapter06Review.biasedWalk a b J dt x0 k sample)) ∧
        (∀ F : C(Icc 0 T, ℝ) → ℝ, Continuous F → Bornology.IsBounded (Set.range F) →
          Tendsto (fun K ↦ ∫ sample, F (walks K sample) ∂P) atTop (𝓝 (∫ sample, F (paths sample) ∂P))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确全局Lipschitz技术资格及AE连续W版本；完整SDE解存在与真实偏置有限游走线性插值的路径空间弱极限，没有只以定义取代扩散极限。

### 6. 审计结论（含网站结论）

网站原返回：PASS。rademacherJumps含概率测度、独立、可测、±1、均值零。W另有PreBrownian和AE连续资格；a,b对(x,t)全局Lipschitz是明示[EXTRA]。结论含全时间严格标量SDE解、[0,T]连续路径版本、dt=T/K的线性插值及所有有界连续路径泛函积分收敛；不是仅参数或单时边际收敛。T>0且K=0不约束无碍atTop。J与W无需互相独立，因为结论只作分布极限。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.biasedWalkDiffusion` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1196`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUProcess

印刷p.234 / PDFp.255；§6.3.2。

### 1. 原文陈述

> For now we will examine the special case of a scalar equation

$$
dX=-\gamma Xdt+\sigma dW;\tag{6.19}
$$


> where $`\gamma\gt 0`$ and $`\sigma`$ are constants. We term Eq. (6.19) the Ornstein-Uhlenbeck SDE.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def strictOUProcess {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 : ℝ) : Prop :=
  0 < γ ∧ strictScalarSDE P W X (fun x _ ↦ -γ*x) (fun _ _ ↦ σ) x0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原显式γ>0保留在真实严格L²积分方程的资格中，不将分布式解作方程前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。D21明列γ>0并把a(x,t)=−γx、b(x,t)=σ、固定x0代入D19。保留负漂移、实常σ和严格积分语义；不是用Gaussian law定义OU。W资格仍需在使用处给出。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.strictOUProcess` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1217`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUIntegratingFactor

印刷p.234 / PDFp.255；§6.3.2。

### 1. 原文陈述

> Multiply both sides of (6.19) by the integrating factor $`\exp(\gamma t)`$, and observe that

$$
d(\exp(\gamma t)X)=\exp(\gamma t)(dX+\gamma Xdt);
$$


> thus (6.19) becomes

$$
d(\exp(\gamma t)X)=\sigma\exp(\gamma t)dW(t).
$$


> We then integrate both sides to obtain

$$
\exp(\gamma t)X(t)=X(0)+\int_0^t\sigma\exp(\gamma s)dW(s).
$$


> Multiplying by $`e^{-\gamma t}`$ gives

$$
X(t)=e^{-\gamma t}X(0)+\sigma e^{-\gamma t}\int_0^t\exp(\gamma s)dW(s).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouIntegratingFactor :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  ∃ Y : Ω → ℝ, strictItoIntegral P W (fun s _ ↦ Real.exp (γ*s)) T Y ∧
    ∀ᵐ sample ∂P, X T sample = Real.exp (-γ*T)*x0 + σ*Real.exp (-γ*T)*Y sample := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际PreBrownian、严格OU与严格确定性Ito积分见证、γ>0和t≥0；完整求值，不以解公式作假设。

### 6. 审计结论（含网站结论）

网站原返回：PASS。任意概率样本空间和PreBrownian W，真实OU关系、γ>0、T≥0；存在Y为exp(γs)的严格确定积分且X T几乎处处等于完整变常数解。σ=0也成立；额外重复γ>0无害。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouIntegratingFactor` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1223`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OUVarianceIntegral

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> Using Proposition 6.3, we know that for a Wiener process $`W(t)`$, $`Y(t)\stackrel{\rm def}=\int_0^t\exp(\gamma s)dW(s)`$ is a Gaussian random variable with mean zero and variance

$$
\operatorname{Var}\{Y(t)\}=\int_0^t e^{2\gamma s}ds=\frac{e^{2\gamma t}-1}{2\gamma}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouVarianceIntegral : ∀ (γ T : ℝ), 0 < γ → 0 ≤ T →
  (∫ s in (0 : ℝ)..T, Real.exp (2*γ*s))=(Real.exp (2*γ*T)-1)/(2*γ) := by
  intro γ T hγ hT
  have hc : 2*γ ≠ 0 := mul_ne_zero (by norm_num) hγ.ne'
  have hd : ∀ x : ℝ, HasDerivAt (fun s : ℝ ↦ Real.exp (2*γ*s)/(2*γ))
      (Real.exp (2*γ*x)) x := by
    intro x
    simpa [hc] using
      ((Real.hasDerivAt_exp (2*γ*x)).comp x
        ((hasDerivAt_id x).const_mul (2*γ))).div_const (2*γ)
  have hi : IntervalIntegrable (fun s : ℝ ↦ Real.exp (2*γ*s)) volume 0 T :=
    Continuous.intervalIntegrable (by fun_prop) _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun x _ ↦ hd x) hi]
  simp only [mul_zero, Real.exp_zero]
  ring
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。
- 覆盖缺口：仅覆盖确定性指数积分求值；随机积分的Gaussian法则、均值及方差由其他条目承接，本条不声称覆盖。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouVarianceIntegral对任意γ>0、T≥0断言确定性区间积分∫exp(2γs)=(exp(2γT)-1)/(2γ)，签名正确。明确排除γ=0以免总化除零给错误值。scope和coverage\_gaps已声明不覆盖随机积分Gaussian法则、均值或方差的识别；按此范围PASS。条目中额外列出的SymplecticCoordinates、textbookJ及复合辛映射声明与本积分结论无关，不把它们当证据。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouVarianceIntegral` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1233`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OULawPrinted

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> The solution with equivalent distribution is therefore

$$
X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}(1-e^{-2\gamma t})}\widehat Y(t).
$$


> where $`\widehat Y(t)`$ should be interpreted as random process which at every time $`t`$ evaluates to a normal random variable ($`\widehat Y(t)\sim N(0,1)`$). This is what we mean by the exact distributional solution of the Ornstein-Uhlenbeck SDE with prescribed initial value $`X(0)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouLawPrinted : ∀ {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 →
  0 < γ → 0 ≤ T → HasLaw (X T)
    (gaussianReal (Real.exp (-γ*T)*x0)
      (σ^2*(1-Real.exp (-2*γ*T))/(2*γ)).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] PDF256/印刷235已目视核对：根号覆盖完整(2γ)⁻¹(1−e^(−2γt))。Printed方差改σ²(1−e^(−2γT))/(2γ)，此前根号范围是转录错误，撤销原书疑误归因。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouLawPrinted：对实际preBrownian驱动与strictOUProcess（γ>0及线性漂移-γx、常扩散σ、确定初态x0的严格积分方程），任意T≥0，X\_T有Gaussian法则，均值exp(-γT)x0、方差σ²(1-exp(-2γT))/(2γ)。方差非负，toNNReal不截掉任何合法量；σ为任意实数、T=0退化为初态Dirac也正确。原文只规定每时刻正态边际，签名没有错误声称各时刻独立或整路径法则，因此PASS；sorry不影响签名审校。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouLawPrinted` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:1251`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.3.2-OULawCorrect

印刷p.235 / PDFp.256；§6.3.2。

### 1. 原文陈述

> The solution with equivalent distribution is therefore

$$
X(t)=e^{-\gamma t}X(0)+\sigma\sqrt{(2\gamma)^{-1}(1-e^{-2\gamma t})}\widehat Y(t).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem ouLawCorrect :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry

/-- 修正版，对应原文 MD-6.3.2-OULawPrinted；改动：把整个(1−e^(−2γt))/(2γ)放入根号；只断言同一OU过程的单时刻法则。 -/
theorem ouLawPrinted_corrected :
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (W X : ℝ → Ω → ℝ) (γ σ x0 T : ℝ),
  IsPreBrownianReal (fun t sample ↦ W t sample) P → strictOUProcess P W X γ σ x0 → 0 < γ → 0 ≤ T →
  HasLaw (X T) (gaussianReal (MolecularDynamics.Chapter06Review.ouMean γ x0 T) (MolecularDynamics.Chapter06Review.ouVariance γ σ T).toNNReal) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]修正标准差σ√((1−e⁻²γt)/(2γ))，完整真实单时Gaussian法则；均值e⁻γtx0、方差σ²(1−e⁻²γt)/(2γ)，不预置law结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouMean和ouVariance的实际定义已给，完整均值及variance正确；PreBrownian、严格OU、γ>0及T≥0足够。σ任意实数由σ²消除符号，T=0退化为点质量正确。这一law忠实于实际PDF公式。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouLawCorrect` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.ouLawPrinted_corrected` | 未证 | 缺大型理论 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1261`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

