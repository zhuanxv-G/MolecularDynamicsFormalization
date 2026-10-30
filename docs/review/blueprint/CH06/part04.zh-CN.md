[上一部分](part03.zh-CN.md) / [目录](../../CH06_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## MD-6.4.1-FiniteDistribution

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> A distribution on the state space is typically associated to a row vector $`\psi=(\psi_1,\psi_2,\ldots,\psi_k)`$ with nonzero elements and which is normalized such that

$$
\sum_{i=1}^k\psi_i=1.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteDistribution {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

/-- 修正版，对应原文 MD-6.4.1-FiniteDistribution；改动：原nonzero单独保留为严格正权重版本；一般定义采用非负权重、总和1。 -/
def finiteDistribution_corrected {k : ℕ} (ψ : MolecularDynamics.Chapter06Review.V k) : Prop := (∀ i, 0 ≤ ψ i) ∧ ∑ i, ψ i = 1

/-- 【原书疑误】保留nonzero按正概率权重的字面版本。 -/
def finiteDistributionPrinted {k : ℕ} (ψ : Fin k → ℝ) : Prop :=
  (∀ i, 0 < ψ i) ∧ ∑ i, ψ i=1

/-- 边界概率向量(1,0)是概率分布，但不满足印刷nonzero权重资格。 -/
theorem finiteDistributionPrinted_counterexample :
    finiteDistribution (fun i : Fin 2 ↦ if i=0 then 1 else 0) ∧
      ¬ finiteDistributionPrinted (fun i : Fin 2 ↦ if i=0 then 1 else 0) := by
  constructor
  · constructor
    · intro i
      dsimp only
      split_ifs <;> norm_num
    · norm_num [Fin.sum_univ_two]
  · intro h
    have hi := h.1 (1 : Fin 2)
    norm_num at hi
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]概率权重取非负，允许零概率状态；原nonzero作为“typically”的描述而非概率的必要条件，不添加严格正初值要求。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐个审校：finiteDistribution及\_corrected均为非负且总和1的一般概率向量；finiteDistributionPrinted按概率权重上下文将nonzero保留为严格正且总和1；反例(1,0)确实满足前者且不满足后者。三种对象及counterexample相互吻合。原句含typically，不能无条件把原文认定为错误定义；应保留人审。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteDistribution` | 定义 | — | PASS |
| `MD.Ch06.finiteDistribution_corrected` | 定义 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.finiteDistributionPrinted` | 定义 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.finiteDistributionPrinted_counterexample` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:1956`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteEvolution

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> The probability of being in state $`i`$ at the $`n+1`$st iteration, is the sum over $`j`$ of the probabilities of being in state $`j`$ multiplied by the probability of transitioning from state $`j`$ to state $`i`$, thus

$$
\psi_{n+1}=\psi_n\Pi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteEvolution {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) (n : ℕ) : MolecularDynamics.Chapter06Review.V k :=
  Matrix.vecMul ψ (PiMark^n)
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

网站原返回：PASS。定义ψ\_n=ψ₀Πⁿ，Matrix.vecMul方向是行向量右乘；n=0得到初值，全部分量保留。原递推式与此闭式等价（19另列完整递推定理）。作为线性演化定义允许任意实矩阵/向量，不声称它们都是概率；无需额外随机性前提。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteEvolution` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1980`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteEvolutionRecurrence

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述


$$
\psi_{n+1}=\psi_n\Pi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem finiteEvolutionRecurrence : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ)
    (initial : Fin k → ℝ) (n : ℕ),
  MolecularDynamics.Chapter06Review.finiteEvolution matrix initial (n+1)=
    Matrix.vecMul (MolecularDynamics.Chapter06Review.finiteEvolution matrix initial n) matrix := by
  intro k matrix initial n
  simp only [MolecularDynamics.Chapter06Review.finiteEvolution, pow_succ]
  exact (Matrix.vecMul_vecMul initial (matrix^n) matrix).symm
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

网站原返回：PASS。任意k、矩阵、初始向量及n均量化，结论把n+1步演化严格等于第n步行向量右乘同一个矩阵，是原递推的完整形式。由矩阵幂和行乘结合律成立，不需要随机矩阵或正初值。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteEvolutionRecurrence` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:1984`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-ReturnTimes

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> For each state of the chain, we define the number $`d(i)`$ to be the greatest common divisor of all integers $`l`$ such that $`\pi_{ii}^{(l)}\gt 0`$ (if the probability of return to state $`i`$ is zero, then we set $`d(i)=0`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def returnTimes {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : Set ℕ :=
  {n | 0 < n ∧ 0 < (PiMark^n) i i}
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Πˡ正返回时间l>0，排除0步恒等阵；原gcd周期定义必须如此解读。

### 6. 审计结论（含网站结论）

网站原返回：PASS。返回时间集恰为所有正自然数n且(Πⁿ)ii>0，排除n=0恒等阵的平凡返回。[EXTRA]已明示这一解读，与原无返回时周期0的约定一致。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.returnTimes` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1994`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Period

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> For each state of the chain, we define the number $`d(i)`$ to be the greatest common divisor of all integers $`l`$ such that $`\pi_{ii}^{(l)}\gt 0`$ (if the probability of return to state $`i`$ is zero, then we set $`d(i)=0`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def period {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (i : Fin k) : ℕ :=
  sSup {d : ℕ | ∀ n ∈ MolecularDynamics.Chapter06Review.returnTimes PiMark i, d ∣ n}
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

网站原返回：PASS。对正返回时间的公因子取自然数sSup：返回集非空时公因子被任一返回时间界住，最大者就是gcd；返回集空时公因子集为全部ℕ，Mathlib自然数条件完备序的无界sSup取0，符合书中特殊约定。不能把无界sSup误当作自然数中的无穷大而判错。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.period` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:1998`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Aperiodic

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> If $`d(i)=1`$, for all $`i`$ then we say that the chain is aperiodic.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def aperiodic {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i, MolecularDynamics.Chapter06Review.period PiMark i = 1
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

网站原返回：PASS。所有状态i均要求实际D18周期等于1；D16/D18与21所核对定义一致。没有偷换成单个状态、存在状态或仅自环条件。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.aperiodic` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2002`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Irreducible

印刷p.245–246 / PDFp.266–267；§6.4.1。

### 1. 原文陈述

> States $`i`$ and $`j`$ are said to communicate if $`\pi_{ij}^{(l_1)}\gt 0`$ and $`\pi_{ji}^{(l_2)}\gt 0`$ for some integers $`l_1`$ and $`l_2`$. This means that it is possible to reach $`j`$ from $`i`$ with positive probability and vice-versa.
> A finite state space model is irreducible if every state is reachable from every other state in a finite “time”, where time in this context refers to the number of iterations of the chain. Equivalently, we say the model is irreducible if all states communicate.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def irreducible {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) : Prop := ∀ i j, ∃ n : ℕ, 0 < (PiMark^n) i j
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

网站原返回：PASS。对每一对i,j存在有限自然数n使(Πⁿ)ij>0；交换全称变量即可得到反向存在，时间可不同，等价所有状态互相communicate。允许n=0只增加同状态的平凡可达性，不改变不同状态连通要求。原矩阵幂的文字方向有上下文笔误，但该全称双向定义不受影响。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.irreducible` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2005`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteInvariant

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> An invariant distribution is a left eigenvector of $`\Pi`$, having only non-negative elements, and corresponding to the eigenvalue 1. That is, an invariant distribution $`\psi_*`$ satisfies

$$
\psi_*=\psi_*\Pi.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteInvariant {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ) (ψ : MolecularDynamics.Chapter06Review.V k) : Prop :=
  MolecularDynamics.Chapter06Review.finiteDistribution ψ ∧ Matrix.vecMul ψ PiMark = ψ
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

网站原返回：PASS。真实Chapter06Review.finiteDistribution要求非负且总和1，再以Matrix.vecMul ψ Π=ψ表达特征值1的左不变性；完整概率对象而不是未归一化/零特征向量。总和1由distribution的前文语义继承合理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteInvariant` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2008`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteErgodicity

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> The fundamental result for Markov chains is the following: If a given Markov chain is both irreducible and aperiodic, then it can be shown that there is a unique invariant distribution $`\psi_*`$ such that

$$
\lim_{n\to\infty}\psi_n=\psi_*,
$$


> for arbitrary initial distribution $`\psi_0`$. The convergence of an irreducible finite Markov chain to its stationary distribution can be understood through the properties of its eigenvalues by applying of the Perron-Frobenius theorem (see [269]).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem finiteErgodicity :
  ∀ {k : ℕ} (PiMark : Matrix (Fin k) (Fin k) ℝ),
  0 < k → MolecularDynamics.Chapter06Review.stochasticMatrix PiMark → MolecularDynamics.Chapter06Review.irreducible PiMark → MolecularDynamics.Chapter06Review.aperiodic PiMark →
  ∃ ψ : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteInvariant PiMark ψ ∧ (∀ χ, MolecularDynamics.Chapter06Review.finiteInvariant PiMark χ → χ=ψ) ∧
    ∀ ψ0 : MolecularDynamics.Chapter06Review.V k, MolecularDynamics.Chapter06Review.finiteDistribution ψ0 → Tendsto (MolecularDynamics.Chapter06Review.finiteEvolution PiMark ψ0) atTop (𝓝 ψ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]非空真实有限状态、右随机矩阵、全部幂Πⁿ、真实全部初始概率；完整存在、唯一性及任意初值向量收敛，不假设谱隙或收敛结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。非空有限域、实际右随机性、所有状态不可约且非周期的前提完整；结论为概率不变向量存在、在全部概率不变向量中唯一，以及所有初始概率向量的Πⁿ演化向该向量收敛。没有把谱隙或收敛作为前提，[EXTRA]说明准确。完整定理的非周期性排除了原末句单独阅读时的周期反例。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteErgodicity` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2013`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-StochasticEntryBound

印刷p.245 / PDFp.266；§6.4.1。

### 1. 原文陈述

> it is a matrix whose entries are all nonnegative and less than or equal to 1.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem stochasticEntryBound : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix → ∀ i j, matrix i j ≤ 1 := by
  intro k matrix h i j
  rw [← h.2 i]
  exact Finset.single_le_sum (fun k _ ↦ h.1 i k) (Finset.mem_univ j)
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

网站原返回：PASS。输入实际stochasticMatrix已包含全部元素非负，结论逐一给出≤1；合在一起正是原条目全部[0,1]界。对任意k,i,j成立，来自行和1及其余元素非负，无遗漏。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stochasticEntryBound` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2021`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-FiniteChainExample

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> Fig. 6.6 A Markov matrix (left) and its graph representation (right). In this example, the Markov Chain is not irreducible.

$$
\Pi=\begin{bmatrix}0.2&0.1&0.7&0&0\\0&0&0&1&0\\0.3&0&0&0.3&0.4\\0&0.5&0&0.3&0.2\\0&0&0&1&0\end{bmatrix}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def finiteChainExample : Matrix (Fin 5) (Fin 5) ℝ :=
  !![(1/5),(1/10),(7/10),0,0;
     0,0,0,1,0;
     (3/10),0,0,(3/10),(2/5);
     0,(1/2),0,(3/10),(1/5);
     0,0,0,1,0]
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

网站原返回：PASS。逐个核对图6.6矩阵25个数值及行列方向；1/5=0.2、1/10=0.1、7/10=0.7、3/10=0.3、2/5=0.4、1/2=0.5，全部零和1也一致。该定义只负责数值矩阵，不可约结论由29独立审校。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.finiteChainExample` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2028`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-ExampleStochastic

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> Fig. 6.6 A Markov matrix (left) and its graph representation (right).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem exampleStochastic : MolecularDynamics.Chapter06Review.stochasticMatrix finiteChainExample := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [finiteChainExample]
  · intro i
    fin_cases i <;> norm_num [finiteChainExample, Fin.sum_univ_succ]
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]原具体数值矩阵的真实随机行资格检查。

### 6. 审计结论（含网站结论）

网站原返回：PASS。真实谓词对27的完整数值矩阵逐项要求非负和行和1。五行分别为1、1、1、1、1，所有项非负；[EXTRA]是该具体例的资格检查，没有添加原例中不存在的假设。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.exampleStochastic` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2037`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-ExampleNotIrreducible

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> In this example, the Markov Chain is not irreducible.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem exampleNotIrreducible : ¬ MolecularDynamics.Chapter06Review.irreducible finiteChainExample := by
  have hz : ∀ n : ℕ,
      (finiteChainExample^n) (1 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (3 : Fin 5) 0=0 ∧
      (finiteChainExample^n) (4 : Fin 5) 0=0 := by
    intro n
    induction n with
    | zero => norm_num
    | succ n ih =>
      rw [pow_succ']
      simp only [finiteChainExample] at ih
      norm_num [Matrix.mul_apply, Fin.sum_univ_succ, finiteChainExample,
        ih.1, ih.2.1, ih.2.2]
  intro h
  obtain ⟨n,hn⟩ := h (1 : Fin 5) (0 : Fin 5)
  rw [(hz n).1] at hn
  linarith
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

网站原返回：PASS。实际irreducible是所有有序状态对存在正概率有限步转移。按书中1起始标签，{2,4,5}为闭类，无法达到1或3，因此矩阵确实不不可约。没有误把无向连通或单步全正性当作不可约。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.exampleNotIrreducible` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2045`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-Communicates

印刷p.245–246 / PDFp.266–267；§6.4.1。

### 1. 原文陈述

> States $`i`$ and $`j`$ are said to communicate if $`\pi_{ij}^{(l_1)}\gt 0`$ and $`\pi_{ji}^{(l_2)}\gt 0`$ for some integers $`l_1`$ and $`l_2`$. This means that it is possible to reach $`j`$ from $`i`$ with positive probability and vice-versa.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def communicates {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ) (i j : Fin k) : Prop :=
  (∃ n : ℕ, 0 < (matrix^n) i j) ∧ ∃ n : ℕ, 0 < (matrix^n) j i
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

网站原返回：PASS。两个方向分别使用存在自然数n，允许不同时间；矩阵幂正项忠实表达正概率可达。原句的integers结合Markov步数解读为非负整数，不能允许任意负幂；这是上下文限定而不是额外概率假设。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.communicates` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2064`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.1-DirectedGraphIrreducible

印刷p.246 / PDFp.267；§6.4.1。

### 1. 原文陈述

> Then one may understand irreducibility as expressing the connectedness of this graph (see Fig. 6.6).
> For a directed graph, we must have, for any pair of vertices $`A`$ and $`B`$, paths which take us from $`A`$ to $`B`$ and vice-versa.

### 2. 原文证明

> 原书未给独立完整证明。 本摘录第二句来自同页脚注8；正文与脚注间有省略。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem directedGraphIrreducible : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix →
  (MolecularDynamics.Chapter06Review.irreducible matrix ↔
    ∀ i j, Relation.ReflTransGen (fun a b ↦ 0 < matrix a b) i j) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实正权边与有向路径可达关系；∀i,j强连通，不用无向连通偷换。

### 6. 审计结论（含网站结论）

网站原返回：PASS。有限非负行随机矩阵；irreducible为任意i,j存在自然数次幂正元，右侧为正权边自反传递闭包。非负性排除路径贡献抵消；n=0与零长路径相合，k=0亦无遗漏。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.directedGraphIrreducible` | 未证 | 时间盒止 | PASS |

位置：`Blueprint/Ch06.lean:2069`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderCoordinates

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Now consider an SDE system defined on the space $`D=\mathbb T^{k_1}\times\mathbb R^{k_2}`$ for non-negative integers $`k_1`$ and $`k_2`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderCoordinates {k₁ k₂ : ℕ} (z : Fin (k₁+k₂) → ℝ) :
    (Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ) :=
  (fun i ↦ (z ⟨i.val, by omega⟩ : AddCircle (1 : ℝ)), fun j ↦ z ⟨k₁+j.val, by omega⟩)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际圆环商坐标与Euclidean非紧坐标；局部微分表达通过周期lift解释，不偷换D为纯ℝⁿ。

### 6. 审计结论（含网站结论）

网站原返回：PASS。k₁、k₂取任意自然数，允许零；前k₁个实坐标商到AddCircle 1，后k₂个保留为实数。维数及真正的圆环×非紧空间均正确，定义是坐标投影这一明确[EXTRA]构造。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderCoordinates` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2077`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderSDE

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Now consider an SDE system defined on the space $`D=\mathbb T^{k_1}\times\mathbb R^{k_2}`$ for non-negative integers $`k_1`$ and $`k_2`$:

$$
dX=b_0(X)dt+\sum_{i=1}^r b_i dW_i;\tag{6.43}
$$


> where $`b_0`$ is $`C^\infty`$ and the $`W_i`$ are independent standard Wiener processes. In this book, we will only consider the analysis for the case of additive noise (i.e. the $`b_i`$ vectors multiplying a Wiener process are constant).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderSDE {Ω : Type*} [MeasurableSpace Ω] {k₁ k₂ r : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → (Fin r → ℝ))
    (X : ℝ → Ω → ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)))
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ) (x0 : Fin (k₁+k₂) → ℝ) : Prop :=
  ContDiff ℝ ∞ (fun z ↦ b₀ (cylinderCoordinates z)) ∧
  textbookIsWienerVector (fun t sample ↦ W t sample) P ∧
  ∃ lift : ℝ → Ω → (Fin (k₁+k₂) → ℝ),
    strictVectorSDE P W lift (fun z _ ↦ b₀ (cylinderCoordinates z)) (fun _ _ ↦ B) x0 ∧
    (∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → X t sample=cylinderCoordinates (lift t sample))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实D及其周期lift、原C∞漂移、常矩形B和全部严格Ito积分；仅方程意义，不预置遍历/不变结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义同时要求周期lift漂移C∞、D6独立标准Wiener向量、全部常噪声矩阵和D4严格路径方程；输出X确实在圆环×实空间中，且几乎处处对所有非负时刻等于lift投影。x0是选定实lift初值，[EXTRA]已明确；没有先假设遍历或不变性。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderSDE` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2083`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderGenerator

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Working in flat $`L^2`$ space, we have that the infinitesmal generator for (6.43) acting on a smooth test function $`\phi(X)`$ is

$$
\mathcal L\phi=b_0\cdot\nabla\phi+\tfrac12\operatorname{Tr}(B^T\phi''B);
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderGenerator {k₁ k₂ r : ℕ}
    (b₀ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → (Fin (k₁+k₂) → ℝ))
    (B : Matrix (Fin (k₁+k₂)) (Fin r) ℝ)
    (φ : ((Fin k₁ → AddCircle (1 : ℝ)) × (Fin k₂ → ℝ)) → ℝ) (z : Fin (k₁+k₂) → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorGenerator (fun y ↦ b₀ (cylinderCoordinates y)) B
    (fun y ↦ φ (cylinderCoordinates y)) z
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

网站原返回：PASS。展开vectorGenerator后是一阶方向导数Dφ·b₀加D7扩散的一半；φ和b₀都经cylinderCoordinates拉回，输入空间和全部k₁+k₂方向正确。此处给出局部微分表达式的定义，不是另一个声称已证明强生成元域的定理。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2095`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-CylinderForwardPrinted

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> Taking the adjoint, the forward Kolmogorov or Fokker-Planck operator is $`\mathcal L^\dagger`$, acting on a density $`\rho(X)`$ as

$$
\mathcal L^\dagger\rho=-\nabla\cdot(b_0\rho)+\tfrac12\operatorname{Tr}(B^T\phi''B).
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def cylinderForwardPrinted {n r : ℕ} (b₀ : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ φ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  -(∑ i, fderiv ℝ (fun z ↦ b₀ z i*ρ z) x (Pi.single i 1)) +
    MolecularDynamics.Chapter06Review.vectorDiffusion B φ x / 2

/-- 修正版：真正环面×动量圆柱空间的前向表达式，使用周期lift方向导数。
原Euclidean坐标辅助cylinderForwardPrinted_corrected另保留；本定义不声称密度存在。 -/
def cylinderForwardPeriodic_corrected {n r : ℕ}
    (a : textbookLangevinPeriodicPhase n → (Fin n ⊕ Fin n → ℝ))
    (B : Matrix (Fin n ⊕ Fin n) (Fin r) ℝ)
    (ρ : textbookLangevinPeriodicPhase n → ℝ) (x : textbookLangevinPeriodicPhase n) : ℝ :=
  -(∑ i : Fin n ⊕ Fin n, textbookLangevinPeriodicDirectionalDerivative
      (fun y ↦ a y i*ρ y) (textbookLangevinCanonicalCoordinateDirection i) x) +
    (∑ j : Fin r, ∑ i : Fin n ⊕ Fin n, ∑ k : Fin n ⊕ Fin n,
      B i j*B k j*textbookLangevinPeriodicDirectionalDerivative
        (textbookLangevinPeriodicDirectionalDerivative ρ (textbookLangevinCanonicalCoordinateDirection k))
        (textbookLangevinCanonicalCoordinateDirection i) x)/2
```

同问题的独立限定/修正版（位于另一条）：
```lean
def cylinderForwardPrinted_corrected {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) (x : Fin n → ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.vectorForward a B ρ x
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] Printed补原页1/2，保留印刷φ而不静默改ρ；独立corrected采用实际周期lift的前向密度表达式，与VectorForward相同。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。cylinderForwardPrinted：任意欧氏n维b0、n×r常B、密度ρ和独立测试φ，负散度作用于b0ρ，扩散作用φ并除2，忠实保留原书符号错误，但这是欧氏局部坐标表达式，不是完整一般T^k1×R^k2域。cylinderForwardPrinted\_corrected调用vectorForward，将扩散改为ρ，欧氏辅助定义正确。cylinderForwardPeriodic\_corrected在真实T^n×R^n上按Fin n⊕Fin n坐标方向求周期lift的一、二阶方向导数，用Σ\_j B\_ij B\_kj和1/2给前向密度算子；维数与噪声列维一致，作为光滑周期密度的形式表达式正确。它只覆盖k1=k2=n的Langevin相空间，非原页全部k1,k2；且未在类型内强制光滑/密度资格，不能当算子域或不变性定理。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.cylinderForwardPrinted` | 定义 | — | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |
| `MD.Ch06.cylinderForwardPeriodic_corrected` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2105`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-StationaryDensity

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of

$$
\mathcal L^\dagger\rho_{\rm eq}\equiv0.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def stationaryWeightRaw25 {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0

def stationaryDensity {n r : ℕ} (a : (Fin n → ℝ) → (Fin n → ℝ))
    (B : Matrix (Fin n) (Fin r) ℝ) (ρ : (Fin n → ℝ) → ℝ) : Prop :=
  Measurable ρ ∧ (∀ x, 0 ≤ ρ x) ∧ Integrable ρ volume ∧
  (∫ x, ρ x)=1 ∧ ∀ x, MolecularDynamics.Chapter06Review.vectorForward a B ρ x=0
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留总化平稳权重stationaryWeightRaw25作辅助；stationaryDensity补可测、非负、可积及体积积分1后才要求前向算子为零。

### 6. 审计结论（含网站结论）

网站原返回：PASS。stationaryWeightRaw25只定义任意实函数的vectorForward逐点为0，是总化辅助。stationaryDensity另外要求ρ可测、处处非负、Lebesgue可积及积分1，再要求同一逐点形式方程，概率密度资格已补足，签名作为形式平稳密度定义PASS。D29为负散度加常B扩散半项；n,r任意，当前域为ℝ^n而非一般圆柱。类型未要求C²或适当generator域，Lean的不可微处导数总化为零；所以不能凭该谓词推出真实Markov核不变性，当前context\_notation已明示形式stationarity且另给generator域/演化。该限制须持续保留，不把“correspond in general”误报为已证等价定理。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stationaryWeightRaw25` | 定义 | — | PASS |
| `MD.Ch06.stationaryDensity` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2126`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-StationaryInvariant

印刷p.247 / PDFp.268；§6.4.2。

### 1. 原文陈述

> We have seen that invariant distributions correspond in general to solutions of

$$
\mathcal L^\dagger\rho_{\rm eq}\equiv0.
$$


> Solutions to this equation are of central importance to the probabilistic behavior of solutions to (6.43). Such solutions give distributions of points in phase space which will remain constant as solutions evolve in time.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem stationaryInvariant :
  ∀ {D : Type*} [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) (L : (D → ℝ) → D → ℝ),
  MolecularDynamics.Chapter06Review.markovSemigroup K → IsProbabilityMeasure μ →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → ∀ T : ℝ, 0 ≤ T →
    ∃ bound : D → ℝ, Integrable bound μ ∧ ∀ s ∈ Icc 0 T, ∀ x,
      |L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal y) x| ≤ bound x) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) →
    (∀ t, Integrable (L (fun x ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t x)) μ) ∧
    (∀ x t, HasDerivWithinAt (fun s : ℝ ↦ MolecularDynamics.Chapter06Review.kernelAverage K f s.toNNReal x)
      (L (fun y ↦ MolecularDynamics.Chapter06Review.kernelAverage K f t.toNNReal y) x) (Ici 0) t)) →
  (∀ f : D → ℝ, Measurable f → Bornology.IsBounded (Set.range f) → (∫ x, L f x ∂μ)=0) →
  MolecularDynamics.Chapter06Review.invariantKernel K μ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Markov kernel semigroup、真实generator对演化检验的导数关系与弱stationarity，并明确局部可积支配保证求导换积分；完整kernel测度不变，未假设不变结论或把形式exp当实际流。
- [EXTRA] 补实际Chapter06Review.invariantKernel及其kernelEvolution定义体；不以MD.Ch06同名定义替代。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：引文、公式、节号及印刷247/PDF268页均与附件第1页相符。C：D为任意可测状态空间，K为非负时间的实际概率Markov核半群，μ为概率测度；逐一核对了全部有界可测检验函数、每个有限时间区间上的可积导数支配、演化检验函数的右侧导数关系、L作用后的可积性及弱平稳性前提。D3–D6中kernelAverage是真实核积分，kernelEvolution为K t ∘ₘ μ，invariantKernel量化所有非负时刻的测度相等。因此结论是完整的核不变性，未将形式指数、只对常数检验的恒等式或不变性本身作为前提。[EXTRA]清楚披露了这是一条在可交换微分与积分条件下由弱平稳推出不变的充分命题；不把它解读为无条件的形式偏微分方程等价定理。本次只审签名，不因sorry扣分。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.stationaryInvariant` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2138`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4-CanonicalMixingMeaning

印刷p.244 / PDFp.265；§6.4。

### 1. 原文陈述

> At any time $`t`$ we take a snapshot $`M_t`$ of the resulting set of random variables. Even if $`M_0`$ is bounded, the evolving set of points would be expected to expand and fill in the phase space accessible at the temperature $`T`$; eventually we hope that the points will be distributed in the entire phase space in accordance with the target measure (usually the Gibbs distribution $`e^{-\beta H}`$).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def canonicalMixingMeaning {D : Type*} [TopologicalSpace D] [MeasurableSpace D]
    (K : ℝ≥0 → Kernel D D) (μ : Measure D) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ x : D, ∀ f : D → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂K t.toNNReal x) atTop (𝓝 (∫ z, f z ∂μ))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实概率目标和任意点初始law、全部有界连续检验函数弱混合定义；没有宣称所有SDE自动满足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。定义为概率目标及每个点初值、每个有界连续实检验的弱收敛；时间atTop下toNNReal不影响极限。此为[EXTRA]明确选择的含义，不是任意SDE的定理。Kernel本身不保证Markov，应避免把任意K称概率law。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.canonicalMixingMeaning` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2155`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-LangevinCanonicalMixing

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> Even a single phase space point, which corresponds to a delta-function initial distribution, will instantly diffuse as the solution of the Fokker-Planck equation and, eventually, would cover the entire phase space.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem langevinCanonicalMixing :
  ∀ {n : ℕ} (U : MolecularDynamics.Chapter06Review.V n → ℝ) (β γ : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω)
    (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (L : ℝ≥0) (hF : LipschitzWith L (textbookPotentialForce U)),
  textbookIsWienerVector B P → 0 < γ →
  (∀ t : ℝ≥0, 0 < t → ∃ density : textbookLangevinPeriodicPhase n × textbookLangevinPeriodicPhase n → ℝ,
    Continuous density ∧ (∀ x y, 0 < density (x,y)) ∧
    ∀ x, textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t x =
        (MolecularDynamics.Chapter06Review.flatPhaseMeasure n).withDensity (fun y ↦ ENNReal.ofReal (density (x,y)))) ∧
  ∀ x : textbookLangevinPeriodicPhase n,
    ∀ f : textbookLangevinPeriodicPhase n → ℝ, Continuous f → Bornology.IsBounded (Set.range f) →
    Tendsto (fun t : ℝ ↦ ∫ z, f z ∂textbookLangevinPeriodicTransitionKernel B P U hU hp L hF γ
      (Real.sqrt (2*γ*β⁻¹)) t.toNNReal x) atTop
        (𝓝 (∫ z, f z ∂textbookLangevinCanonicalMeasure U β hβ)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实现有周期单位质量Langevin kernel、正γ/β、原光滑力全局Lipschitz；完整任意点初值的正时刻严格正连续转移密度以及全部有界连续检验弱混合，原一般混合意义另条，不以单位质量特例替代一般定义。
- [EXTRA] 补所选真实路径的存在规格和初值/积分方程；范围仅周期、单位质量及已列全局Lipschitz力，不声称一般非周期Langevin结论。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：印刷248/PDF269页中从“Even a single phase space point”到“entire phase space”的摘录准确。C：状态空间确为单位位置环面×实动量，U全局C∞且单位周期，力为−∇U并有显式全局Lipschitz常数；β、γ正，噪声幅度√(2γ/β)，B满足给定高斯、均值、协方差和几乎处处连续的Wiener规格。D17、D19–D23给出所选路径的存在、初值和两条积分方程；D28的核是该实际路径端点的推前，未任意选一个具有所需性质的核。flatPhaseMeasure为位置Haar×动量Lebesgue；canonicalMeasure为归一位置Gibbs×各坐标方差β⁻¹的独立高斯。第一结论对每个t>0提供在两个初末态变量上连续、处处严格正的密度及全测度相等；第二结论对每个点初值、每个有界连续f给出到该规范测度的弱收敛。[EXTRA]已明确周期、单位质量的范围；不把此声明扩大为任意退化SDE或非紧配置空间的结论。
当前处理：网站PASS（复审）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.langevinCanonicalMixing` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2163`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianGenerator

印刷p.249 / PDFp.270；§6.4.3。

### 1. 原文陈述

> For example, let us return to Brownian dynamics (or overdamped Langevin dynamics) and set $`M=I`$ and $`\gamma=1`$ in (6.36), giving an equation of motion

$$
dq=-\nabla U(q)dt+\sqrt{2k_BT}dW.\tag{6.46}
$$


> Writing $`\beta^{-1}=k_BT`$ as usual, the generator of the stochastic process may be written as

$$
\mathcal L f=-\nabla U^T\cdot\nabla f+\beta^{-1}\Delta f.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
noncomputable def brownianGenerator {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际任意对角质量版本，取m≡1即此处公式；不声称原6.46本身含一般质量。

### 6. 审计结论（含网站结论）

网站原返回：PASS。逐坐标fderiv方向导数及二阶导数给出逆质量加权漂移和扩散；m≡1还原原式。[EXTRA]已披露推广。当前是代数算子定义，并非在任意β,m及任意f下断言存在相应扩散生成元。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianGenerator` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2183`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianWeightedInner

印刷p.249 / PDFp.270；§6.4.3。

### 1. 原文陈述

> Let $`\bar\rho_\beta=\exp(-\beta U)`$, and define the space of functions $`C_0^2(\bar\mu_\beta)`$ consisting of functions in $`C_0^2`$ on the configuration space $`\mathcal Q\subset\mathbb R^{N_c}`$ together with the inner product

$$
\langle f,g\rangle_\beta\stackrel{\rm def}=\int_{\mathcal Q}f(q)g(q)\bar\mu_\beta(d\omega_q)=\int_{\mathcal Q}f(q)g(q)\bar\rho_\beta(q)d\omega_q;
$$


> where $`d\omega_q=dq_1dq_2\cdots dq_{N_c}`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def brownianWeightedInner {n : ℕ} (U : (Fin n → ℝ) → ℝ) (β : ℝ)
    (f g : (Fin n → ℝ) → ℝ) : ℝ :=
  ∫ q in textbookConfigurationCube n, f q*g q*Real.exp (-β*U q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]本章后续周期Q的单位基本域；保留原未归一权重，不偷加Z⁻¹。C₀²域与闭算子域另行区别。

### 6. 审计结论（含网站结论）

网站原返回：PASS。积分域确为Icc 0 1，权重exp(-βU)未除Z；f,g为任意函数的总定义，适当函数域上才是内积。周期基本域限制已披露；此定义没有形式化C₀²函数空间本身。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianWeightedInner` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2192`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianDirichlet

印刷p.249–250 / PDFp.270–271；§6.4.3。

### 1. 原文陈述

> Combining this with the first part of the inner product, we see that

$$
\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.
$$



### 2. 原文证明


$$
\langle f,\mathcal Lg\rangle_\beta=\int_{\mathcal Q}f[-\nabla U^T\nabla g+\beta^{-1}\Delta g]\bar\rho_\beta d\omega_q.
$$


> Integrating by parts in the second term we have

$$
\beta^{-1}\int_{\mathcal Q}f\Delta g\bar\rho_\beta d\omega_q=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla(f\bar\rho_\beta)d\omega_q =-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q+\int_{\mathcal Q}f(\nabla g^T\nabla U)\bar\rho_\beta d\omega_q.
$$


> Combining this with the first part of the inner product, we see that

$$
\langle f,\mathcal Lg\rangle_\beta=-\beta^{-1}\int_{\mathcal Q}\nabla g^T\nabla f\bar\rho_\beta d\omega_q.
$$



### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianDirichlet {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    (∫ q in textbookConfigurationCube Nc,
      f q * textbookBrownianGenerator m U β g q * textbookConfigurationGibbsWeight U β q) =
      -β⁻¹ * ∫ q in textbookConfigurationCube Nc,
        textbookConfigurationGradientPair m f g q * textbookConfigurationGibbsWeight U β q := by
  apply MolecularDynamics.textbookBrownianGenerator_integral_dirichlet <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实C∞周期资格保证边界通量消去；实际全质量逆M梯度积，m≡1还原原式；β≠0。

### 6. 审计结论（含网站结论）

网站原返回：PASS。U,f,g全域C∞、整数平移周期及β≠0保证分部积分边界抵消；两侧使用同一未归一权重和全部逆质量坐标和。等式不需质量正性；m≡1还原原文。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianDirichlet` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2198`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianSymmetry

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In this form we see that $`f`$ and $`g`$ appear symmetrically, so we may write

$$
\langle f,\mathcal Lg\rangle_\beta=\langle\mathcal Lf,g\rangle_\beta;
$$


> hence, with respect to the weighted inner product, $`\mathcal L^\dagger=\mathcal L`$. (Note that the adjoint indicated here is quite different than the $`L^2`$ adjoint mentioned previously in connection with the Fokker-Planck operator.)

### 2. 原文证明

> 原书给出分部积分得到形式对称配对的论证；未给出无界算子闭域及伴随域相等的完整论证。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianSymmetry {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianSymmetry_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : β ≠ 0)
    (f g : (Fin Nc → ℝ) → ℝ)
    (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f) (hg : ContDiff ℝ ∞ g)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hPg : textbookUnitPeriodicPotential g) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β g) =
      brownianWeightedInner U β (textbookBrownianGenerator m U β f) g := by
  have hs := textbookBrownianGenerator_inner_symmetric m U β hβ f g hU hf hg hPU hPf hPg
  unfold textbookConfigurationInner at hs
  have hz := (textbookConfigurationPartition_pos U hU β).ne'
  have hc := mul_left_cancel₀ (inv_ne_zero hz) hs
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原文引文保持不变；两份Lean声明仅覆盖C∞单位周期核心上的加权配对对称。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]完整未归一配对等式，由现成归一配对消去正Z⁻¹；C∞周期核心上的形式对称，不宣称C₀²核心本身已闭自伴。
- [EXTRA] 本条仅为周期光滑核心上的形式对称配对；核心对称不推出伴随域相等。闭实现自伴另见BrownianClosedSelfAdjoint，原C₀²域解释待签核。
- [ERRATUM?] 形式对称与闭自伴须区分；本条配对恒等式不等于已经忠实实现原C₀²域上的L†=L。
- [EXTRA] 复审范围：两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
- 覆盖缺口：原C₀²域的自伴解释待人工确认；闭实现的自伴性由BrownianClosedSelfAdjoint单独处理。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：配对等式及随后L†=L的引文准确，原文的自伴措辞应保留。C：两份Lean签名完全相同，均为PASS的限定配对恒等式：积分在一个基本立方体上，权为exp(−βU)，U、f、g均C∞且单位周期，β≠0；m仅作实系数参数，形式对称本身不需要质量正性。D32–D34及归一配对定义表明取消正的配分函数因子不会改变等式。它们没有表达伴随算子的定义域等于原定义域。原页从对称积分直接说L†=L，但此前给出的C₀²域是否指闭实现并不清楚，不能把正确的核心对称等式当作原域已自伴。corrected版数学陈述通过；整条因原文域解释仍为NEEDS\_HUMAN，而非因证明占位或定义缺失。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
两份相同签名只覆盖周期核心的形式配对对称；不覆盖原域与伴随域相等。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianSymmetry` | 已证 | — | PASS |
| `MD.Ch06.brownianSymmetry_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2213`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianNonpositive

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> Moreover, from the calculation above,

$$
\langle f,\mathcal Lf\rangle=-\beta^{-1}\int_{\mathcal Q}\|\nabla f\|^2\bar\rho_\beta d\omega_q;
$$


> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianNonpositive {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNonpositive；改动：采用≤0并区分闭算子实现与光滑核心；严格负定字面另见BrownianNegativeDefinitePrinted。 -/
theorem brownianNonpositive_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc

/-- 修正版，对应原文 MD-6.4.3-BrownianNegativeDefinitePrinted；改动：将严格小于0改为小于等于0；零特征值与常数核保留。 -/
theorem brownianNegativeDefinitePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]正质量与β>0，未归一配对；本条结论精确保留≤0，原negative definite术语错误另记录。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。正质量、β>0及周期光滑域下未归一二次型≤0正确。原文negative definite错误，已有[ERRATUM?]保留；本签名仅保留正确的半负定子结论。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianNonpositive` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.brownianNonpositive_corrected` | 已证 | — | 未获单独PASS；见分版意见 |
| `MD.Ch06.brownianNegativeDefinitePrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2246`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianRealEigenvalue

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianRealEigenvalue {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianRealEigenvalue_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f)
    (hne : ¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0)
    (ℓ : ℝ) (heig : ∀ q, textbookBrownianGenerator m U β f q = ℓ * f q) :
    ℓ ≤ 0 := by
  exact MolecularDynamics.textbookBrownianGenerator_real_eigenvalue_nonpos m hm U β hβ f hU hf hPU hPf hne ℓ heig
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真正非零L²特征函数、C∞周期、正质量与β>0；不以特征值符号作假设。
- [EXTRA] [ERRATUM?]原引文negative definite应为半负定，常数零模反例与BrownianNegativeDefinitePrinted共用；本条只证明已给实特征参数≤0，不冒称全部复谱实性。
- 覆盖缺口：仅证明已给实特征参数非正；不单独证明复特征值实性，也不把原严格负定用语认作成立。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：原文确实同时写⟨f,Lf⟩≤0和“negative definite”，转录未错，不能在原引文中静默改成半负定。C：两份签名均PASS：正质量、β>0、C∞周期U及非零L²意义的C∞周期f，逐点满足Lf=ℓf，且参数ℓ预先属于ℝ，结论ℓ≤0。非零性相对于基本立方体Lebesgue几乎处处定义，正Gibbs权使其等价于Gibbs-L²非零；没有把特征值符号作为假设。声明不证明任意复特征值实性，也不证明严格负定；这些限制已由[EXTRA]说明。整条因原书严格负定用语的数学疑误需人工签核。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianRealEigenvalue` | 已证 | — | PASS |
| `MD.Ch06.brownianRealEigenvalue_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2281`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianClosedSelfAdjoint

印刷p.249–250 / PDFp.270–271；§6.4.3。

### 1. 原文陈述

> Then $`\mathcal L`$ is self-adjoint with respect to this inner product.

### 2. 原文证明

> 原书给出形式分部积分的论证，见印刷249–250页；未说明完整闭域及伴随域。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianClosedSelfAdjoint {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianClosedSelfAdjoint_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexOperator_isSelfAdjoint <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 原文自伴句保持不变；Lean主版与corrected版均指周期Gibbs复L²上的闭/最大图实现。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]使用现成实际Gibbs复L²闭实现及完整adjoint域；原C₀²核心对称不等于闭自伴。权重归一不改变自伴关系。
- [EXTRA] 明确采用周期紧环面的Gibbs L²图闭包/最大复图实现；此域修正替换原C₀²核心域，不能把核心上的形式对称当原域自伴，待人工签核。
- [EXTRA] 原页先取单位质量；本条还推广至任意正对角质量。
- [ERRATUM?] 原C₀²域上的形式对称不应直接等同于完整无界算子的自伴。
- [EXTRA] 复审范围：限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
- 覆盖缺口：原C₀²核心域自伴的字面断言未由这两份签名实现，需人工确认作者原意。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：印刷249页末的“Then L is self-adjoint with respect to this inner product.”摘录准确。C：两份签名相同且作为修正版均PASS：正对角质量、β>0、C∞单位周期势；对象为归一Gibbs复L²上的实际部分线性算子，结论为完整IsSelfAdjoint。已展开光滑周期空间→L²嵌入→光滑域算子→实图闭包→由实际闭算子特征空间构成的复Hilbert基→最大复图。复图约束的是所有谱系数，并非只在原光滑域验证对称；归一权重的常数缩放不改变自伴关系。原书该句的前置对象是C₀²(μ̄β)，并先取M=I、γ=1；本条采用周期闭实现及正对角质量推广，是明确披露的域修正而非原C₀²域的逐字实现。[EXTRA]已要求人工确认，整条据此为NEEDS\_HUMAN。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
限定版正质量、β>0、C∞单位周期势、闭Gibbs复L²实现已获PASS；原C₀²措辞与闭实现的解释仍待导师。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianClosedSelfAdjoint` | 已证 | — | PASS |
| `MD.Ch06.brownianClosedSelfAdjoint_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2303`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianCompactResolvent

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianCompactResolvent {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption

/-- 修正版/限定版：原文公式或定义的正确限定陈述；证明/域解释缺口见ERRATA。复制独立证明体，不从原文版占位推导。 -/
theorem brownianCompactResolvent_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    IsCompactOperator (textbookBrownianGibbsComplexResolvent m hm U hU hPU β hβ) := by
  apply MolecularDynamics.textbookBrownianGibbsComplexResolvent_isCompact <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | Lean仅覆盖紧环面Gibbs-L²闭实现的(1−L)⁻¹紧性；原文离散谱子句由条目7承接。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Gibbs复L²闭实现的(1−L)⁻¹；全部离散谱子结论另条保留，未从本条自动声称原C₀²域自伴。
- [EXTRA] 仅断言紧torus上的闭实现具有紧预解式；原一般C₀²措辞未覆盖，域与紧配置假设需人工签核。
- [ERRATUM?] 预解式必须属于明确的闭实现，不能仅以核心上的形式微分表达认定原域具有该预解式。
- [EXTRA] 复审范围：只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
- 覆盖缺口：原C₀²域及一般配置空间的解释待人工确认。
- 覆盖缺口：原句中的离散谱结论由BrownianDiscreteSpectrum及其eigenvalue补充声明另列。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：compact resolvent、引用[360]及随后可数离散特征值的原句准确。C：两份紧性签名作为周期闭实现的限定版均PASS。已展开D86–D91：实闭图上的shift为(x,y)↦x−y，逆映射后取第一坐标，所得确为(1−L)⁻¹；复预解式由实部、虚部分别作用该真实预解式并复线性化得到，不是一个仅名为resolvent的任意紧算子。正质量、β>0和紧配置环面是明确前提；没有将紧性本身假设进去。此条签名仅给预解式紧性，离散谱的对应条目为7。原页仍把性质归在C₀²函数空间上；与闭实现、紧配置假设之间的解释差别已在[EXTRA]要求签核，不能由本条自动认证原一般域表述。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
只给实际(1−L)⁻¹紧性，离散谱由相邻独立条目承接；不把原域解释自动视为已认证。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianCompactResolvent` | 已证 | — | PASS |
| `MD.Ch06.brownianCompactResolvent_corrected` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2319`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianDiscreteSpectrum

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> In particular, it has a compact resolvent [360]; this can be shown to imply that the spectrum consists only of a countable collection of eigenvalues, i.e. that the operator has a discrete spectrum.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianDiscreteSpectrum {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ, z.im=0) ∧
  ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    ∃ N : Set ℂ, IsOpen N ∧ z ∈ N ∧
      N ∩ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ={z} := by
  refine ⟨textbookBrownianGibbsGeneratorComplexSpectrum_countable m hm U hU hPU β hβ, ?_, ?_⟩
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz
  · exact fun z hz ↦ textbookBrownianGibbsGeneratorComplexSpectrum_isolated m hm U hU hPU β hβ z hz

/-- 25号补全：每个谱点均为闭实现的特征值；尚缺完整谱理论桥接。 -/
theorem brownianDiscreteSpectrum_eigenvalue {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hp : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
    ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
      ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
        (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条Lean覆盖范围：保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 保留已证可数/实谱/孤立子句，新增“每谱点为特征值”的完整短陈述，尚未证明；有限重数与无有限聚点未冒称覆盖。
- [EXTRA] 全部谱结论针对正质量、β>0、C∞单位周期势的紧环面Gibbs复L²闭实现。
- [ERRATUM?] 原C₀²域与上述闭实现的对应关系承接条目6，仍需人工签核。
- [EXTRA] 复审范围：合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。
- 覆盖缺口：有限重数和无有限聚点的标准离散谱强化尚未单列。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。A：与条目6同一句原文，转录准确。C：两份签名分别PASS。主声明给出所定义复谱的可数性、虚部为零及每个谱点的开邻域孤立性；补充声明对每个谱点给出非零复L²向量及(v,z•v)在完整闭图中，准确表达它是特征值而非仅“谱点可数”。D92–D93的预解集要求有界复线性算子同时满足左右逆图关系，谱取其补集，未偷换成预先枚举的特征值集合。审校按两份声明合并覆盖原文的“countable collection of eigenvalues”，不因补充声明的sorry判FAIL。有限重数没有作为该两份签名的结论；不得把依赖中某定理的存在误计为这里显式列出的结论。整条仍承接条目6的原C₀²域/闭实现解释疑问。
当前处理：修正版/限定声明=网站PASS；原文疑误或范围解释待导师。
合并主声明与eigenvalue补充声明覆盖可数实孤立谱及每谱点为特征值；正质量、β>0、C∞单位周期势和闭Gibbs复L²域均为限定；有限重数等强化未单列。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianDiscreteSpectrum` | 已证 | — | PASS |
| `MD.Ch06.brownianDiscreteSpectrum_eigenvalue` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2334`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianSpectralGap

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianSpectralGap {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hPU β hβ,
    z ≠ 0 → z.im=0 ∧ z.re ≤ -α := by
  refine ⟨textbookBrownianGibbsCoercivityRate m U hU hPU β,
    textbookBrownianGibbsCoercivityRate_pos m U hU hPU β hβ, ?_⟩
  intro z hz hn
  exact ⟨textbookBrownianGibbsGeneratorComplexSpectrum_im_zero m hm U hU hPU β hβ z hz,
    textbookBrownianGibbsGeneratorComplexSpectrum_gap m hm U hU hPU β hβ z hn hz⟩
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]现成实际全闭谱；正谱隙从真实Poincaré常数得出，不把目标谱隙作前提。

### 6. 审计结论（含网站结论）

网站原返回：PASS。存在统一α>0，对全复谱每个非零点同时给出虚部0和实部≤−α，未将谱隙作为假设；与原排除零特征值的陈述吻合。正质量、β>0、C∞周期及完整谱已明确。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianSpectralGap` | 已证 | — | PASS |

位置：`Blueprint/Ch06.lean:2358`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-Theorem61

印刷p.250–251 / PDFp.271–272；§6.4.3。

### 1. 原文陈述

> Theorem 6.1 Define the generator of Brownian dynamics by

$$
\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.
$$


> Suppose that $`U`$ is smooth with periodic boundary conditions $`\mathcal Q=\mathbb T^{N_c}`$ ($`\mathbb T^{N_c}`$ an $`N_c`$-dimensional torus). Then, with respect to the space $`C_0^2(\mu_\beta)`$ with inner product $`\langle f,g\rangle_\beta`$ as defined above, we have:
> 1. $`\mathcal L`$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $`(-\infty,0]`$.
> 2. $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};
$$


> for some positive $`K`$ and $`\alpha`$, where recall $`\bar\varphi(t)`$ denotes the time average of $`\varphi`$ defined in (5.6).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem61 :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 修正版，对应原文 MD-6.4.3-Theorem61；改动：明确闭Gibbs-L²实现、半负定、离散谱、谱隙和L²初始相对密度的演化分布平均；Brownian扩散使用逆质量权重，不混用p.244动量算子的ΔM；不声称已证原轨道时间平均。 -/
theorem theorem61_corrected :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → MolecularDynamics.Chapter06Review.V n) (P : Measure Ω),
    textbookIsWienerVector B P →
    ∀ ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β),
      0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ →
      (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β)=1 →
      ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace n) (t : ℝ≥0),
        |textbookBrownianDensityAverage m hm U hU hp β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K * ‖textbookPeriodicSmoothEmbedding U hU hp β f‖ * Real.exp (-α*(t : ℝ)) := by
  sorry

/-- 【限定摘录，非原域字面版】保留严格负定及(5.6)轨道时间平均的疑误，但算子为闭Gibbs复L²实现；不把另列质量表达式当成本声明的算子，不证明此版。 -/
theorem theorem61ClosedRealizationExcerpt :
  ∀ {n : ℕ} (m : MolecularDynamics.Chapter06Review.V n) (hm : ∀ i, 0 < m i)
    (U : MolecularDynamics.Chapter06Review.V n → ℝ) (hU : ContDiff ℝ ∞ U) (hp : textbookUnitPeriodicPotential U)
    (β : ℝ) (hβ : 0 < β),
  IsSelfAdjoint (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z.im=0 ∧ z.re ≤ 0) ∧
  (textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ).Countable ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    ∃ v : Lp ℂ 2 (textbookConfigurationTorusGibbsMeasure U β), v ≠ 0 ∧
      (v,z • v) ∈ (textbookBrownianGibbsComplexOperator m hm U hU hp β hβ).graph) ∧
  (∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, ∃ ε : ℝ, 0 < ε ∧
    ∀ w ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ, dist w z < ε → w=z) ∧
  (∃ α : ℝ, 0 < α ∧ ∀ z ∈ textbookBrownianGibbsGeneratorComplexSpectrum m hm U hU hp β hβ,
    z ≠ 0 → z.re ≤ -α) ∧
  (∀ f : (Fin n → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube n)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0) ∧
  ∀ {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω), textbookIsWienerVector B P →
    ∀ x : UnitAddTorus (Fin n), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
      ∀ f : textbookPeriodicSmoothSpace n, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
        |t⁻¹*(∫ s in (0 : ℝ)..t,
            textbookConfigurationTorusObservable f
              (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hp β hβ x B s sample)) -
          (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
            K*‖textbookPeriodicSmoothEmbedding U hU hp β f‖*Real.exp (-α*t) := by
  sorry

/-- 【原书疑误】在ΔM=Σmi∂ii这一记号解释下的条件性代数表达；原页记号尚待核定，不宣称它是整个原定理或Brownian过程生成元。 -/
def brownianMassGeneratorPrinted {n : ℕ} (m : Fin n → ℝ) (U f : (Fin n → ℝ) → ℝ)
    (β : ℝ) (x : Fin n → ℝ) : ℝ :=
  ∑ i, (-(m i)⁻¹*fderiv ℝ U x (Pi.single i 1)*fderiv ℝ f x (Pi.single i 1)+
    β⁻¹*m i*fderiv ℝ (fun y ↦ fderiv ℝ f y (Pi.single i 1)) x (Pi.single i 1))

/-- 修正版，Brownian扩散使用逆质量权重；实际生成元的表达式定义。 -/
noncomputable def brownianMassGeneratorPrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (f : (Fin Nc → ℝ) → ℝ)
    (q : Fin Nc → ℝ) : ℝ :=
  ∑ i, (m i)⁻¹ * (β⁻¹ * textbookConfigurationPartial
    (textbookConfigurationPartial f i) i q -
      textbookConfigurationPartial U i q * textbookConfigurationPartial f i q)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条当前覆盖范围：主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | FAIL；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。
- [ERRATUM?] 原书数学疑误与本次形式化修复分别记录，见CH06\_ERRATA。
- 覆盖缺口：原C₀²域及原ΔM生成元对应的整条字面形式化未提供；独立质量表达式不补足此联系。
- 覆盖缺口：严格负定与几乎处处轨道时间平均的固定指数界不作为成立结论。
- 覆盖缺口：本轮已目视核定印刷244/PDF265：ΔM=Σmi∂²/∂pi²。质量表达式注释中的“原页记号尚待核定”是复审时旧状态；核页不等于已建立原域/整条生成元联系。Theorem6.1的构型逆质量解释仍待导师。

### 6. 审计结论（含网站结论）

网站原返回：FAIL。A：Theorem 6.1的生成元、三款结论及最后明确指向(5.6)的time average均准确转录；书中分布平均与轨道时间平均的冲突以及negative definite措辞须保留为原书疑误。C分版本：theorem61和theorem61\_corrected作为限定修正版均PASS，包含完整闭自伴、全部复谱实且非正、可数、每点有非零图特征向量、孤立、非零谱隙及对所有非负归一L²相对初始密度的演化分布平均指数界。K、α在ρ之后、在所有f和t之前选择，量词正确；DensityLaw为真实Brownian核作用初始ρμβ，DensityAverage的分母在这些概率条件下为1。修正生成元的扩散和漂移均用逆质量，匹配给出的实际Brownian路径系数。theorem61Printed的严格负定及几乎处处轨道平均指数界保留了原文疑误，但它仍使用与corrected相同的闭复L²算子，而原文明确以C₀²(μβ)为域；其全部谱/自伴断言也未与另列的brownianMassGeneratorPrinted建立对象联系。因此该名字为Printed的整条声明不是原域及原生成元的字面实现，忠实性FAIL；这与原书数学错误本身的NEEDS\_HUMAN及sorry无关。brownianMassGeneratorPrinted的代数表达与其注释一致，但附件没有印刷244页，无法据本附件独立确认ΔM在该页的既定含义，应保留记号歧义而不能假称已逐页核实。
当前处理：按网站审校意见修复，本地核验通过（未再送网站）。
主版与\_corrected保持网站已通过的闭实现/分布平均签名。旧theorem61Printed改名theorem61ClosedRealizationExcerpt，明确只是闭实现限定摘录，不能冒称C₀²原域及原ΔM生成元的整条字面实现。分布平均与轨道时间平均冲突、negative definite措辞保留为原书疑误。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem61` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem61_corrected` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.theorem61ClosedRealizationExcerpt` | 未证 | 原书疑误不证 | 修复后未再送网站 |
| `MD.Ch06.brownianMassGeneratorPrinted` | 定义 | — | 修复后未再送网站 |
| `MD.Ch06.brownianMassGeneratorPrinted_corrected` | 定义 | — | 修复后未再送网站 |

位置：`Blueprint/Ch06.lean:2373`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-Theorem61TimeAveragePrinted

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> Theorem 6.1 Define the generator of Brownian dynamics by

$$
\mathcal Lf\stackrel{\rm def}=-M^{-1}\nabla U^T\nabla f+\beta^{-1}\Delta_Mf.
$$


> Suppose that $`U`$ is smooth with periodic boundary conditions $`\mathcal Q=\mathbb T^{N_c}`$ ($`\mathbb T^{N_c}`$ an $`N_c`$-dimensional torus). Then, with respect to the space $`C_0^2(\mu_\beta)`$ with inner product $`\langle f,g\rangle_\beta`$ as defined above, we have:
> 1. $`\mathcal L`$ is self-adjoint, negative definite, with spectrum consisting of discrete eigenvalues on the half line $`(-\infty,0]`$.
> 2. $`\mathcal L`$ has a spectral gap, meaning that, with exception of the zero eigenvalue, the remainder of the spectrum satisfies $`\sigma(\mathcal L)\subset(-\infty,-\alpha]`$ for some $`\alpha\gt 0`$.
> 3. averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t};
$$


> for some positive $`K`$ and $`\alpha`$, where recall $`\bar\varphi(t)`$ denotes the time average of $`\varphi`$ defined in (5.6).

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem theorem61TimeAveragePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin Nc → ℝ)) (P : Measure Ω) (hB : textbookIsWienerVector B P) :
  ∀ x : UnitAddTorus (Fin Nc), ∃ K α : ℝ, 0 < K ∧ 0 < α ∧
    ∀ f : textbookPeriodicSmoothSpace Nc, ∀ᵐ sample ∂P, ∀ t : ℝ, 0 < t →
      |t⁻¹*(∫ s in (0 : ℝ)..t,
          textbookConfigurationTorusObservable f
            (textbookBrownianTorusGlobalRandomConfiguration m hm U hU hPU β hβ x B s sample)) -
        (∫ Q, textbookConfigurationTorusObservable f Q ∂textbookConfigurationTorusGibbsMeasure U β)| ≤
          K*‖textbookPeriodicSmoothEmbedding U hU hPU β f‖*Real.exp (-α*t) := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]实际Brownian全时torus过程、任意点初值、AE路径资格和t>0明确；原C∞紧支检验在紧torus周期表示。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。按Printed规则核查：任意点初值、K,α先于f与AE样本、全部t>0的轨道时间积分，确为原末句时间平均读法的明确化。AE资格是额外选择；原文本身与前句分布平均冲突且该指数路径界一般错误。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.theorem61TimeAveragePrinted` | 未证 | 原书疑误不证 | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2476`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianEnsembleExponential

印刷p.251 / PDFp.272；§6.4.3。

### 1. 原文陈述

> averages with respect to the evolving, time-dependent distribution converge exponentially rapidly to averages with respect to the invariant distribution, and, for any smooth, compactly supported test function $`\varphi`$, we have

$$
|\bar\varphi(t)-\operatorname{Av}_\beta(\varphi)|\le K\|\varphi\|_\beta e^{-\alpha t}.
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianEnsembleExponential {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption

/-- 修正版，对应原文 MD-6.4.3-Theorem61TimeAveragePrinted；改动：选择演化分布平均，限定L²初始相对密度；轨道遍历极限应另行陈述，不赋予指数逐路径率。 -/
theorem theorem61TimeAveragePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β)
    {Ω : Type*} [MeasurableSpace Ω] (B : ℝ≥0 → Ω → (Fin Nc → ℝ))
    (P : Measure Ω) (hB : textbookIsWienerVector B P)
    (ρ : Lp ℝ 2 (textbookConfigurationTorusGibbsMeasure U β))
    (hρpos : 0 ≤ᵐ[textbookConfigurationTorusGibbsMeasure U β] ρ)
    (hρmass : (∫ Q, ρ Q ∂textbookConfigurationTorusGibbsMeasure U β) = 1) :
    ∃ K α : ℝ, 0 < K ∧ 0 < α ∧ ∀ (f : textbookPeriodicSmoothSpace Nc) (t : ℝ≥0),
      |textbookBrownianDensityAverage m hm U hU hPU β hβ B P ρ t
          (textbookConfigurationContinuousObservable f f.prop.1.continuous f.prop.2) -
        (textbookConfigurationPartition U β)⁻¹ *
          (∫ q in textbookConfigurationCube Nc, (f : (Fin Nc → ℝ) → ℝ) q *
            textbookConfigurationGibbsWeight U β q)| ≤
        K * ‖textbookPeriodicSmoothEmbedding U hU hPU β f‖ * Real.exp (-α * (t : ℝ)) := by
  apply MolecularDynamics.textbookBrownianDensityAverage_smooth_exponential <;> assumption
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]选择实际演化分布平均；真实Wiener/kernel和非负质量1的L²初始相对密度，所有光滑周期检验同时受界。范围限定不覆盖singular点初始law，不是原轨道时间平均证明。

### 6. 审计结论（含网站结论）

网站原返回：PASS。实际Wiener驱动转移kernel推动非负质量1的L²相对密度；DensityAverage是总质量归一的演化分布平均，右侧Z⁻¹积分与torus Gibbs平均一致。K,α统一于所有光滑周期f与t≥0；归一范数与原范数的常数差可吸收进K。[EXTRA]明确非轨道平均及不含奇异初始law。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianEnsembleExponential` | 已证 | — | PASS |
| `MD.Ch06.theorem61TimeAveragePrinted_corrected` | 已证 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2492`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.3-BrownianNegativeDefinitePrinted

印刷p.250 / PDFp.271；§6.4.3。

### 1. 原文陈述

> so that $`\langle f,\mathcal Lf\rangle\le0`$ so the operator is negative definite and can only have non-positive eigenvalues.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem brownianNegativeDefinitePrinted {Nc : ℕ} (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U)
    (hPU : textbookUnitPeriodicPotential U) (β : ℝ) (hβ : 0 < β) :
  ∀ f : (Fin Nc → ℝ) → ℝ, ContDiff ℝ ∞ f → textbookUnitPeriodicPotential f →
    (¬ f =ᵐ[volume.restrict (textbookConfigurationCube Nc)] 0) →
      brownianWeightedInner U β f (textbookBrownianGenerator m U β f) < 0 := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem brownianNegativeDefinitePrinted_corrected {Nc : ℕ} (m : Fin Nc → ℝ)
    (hm : ∀ i, 0 < m i) (U : (Fin Nc → ℝ) → ℝ) (β : ℝ) (hβ : 0 < β)
    (f : (Fin Nc → ℝ) → ℝ) (hU : ContDiff ℝ ∞ U) (hf : ContDiff ℝ ∞ f)
    (hPU : textbookUnitPeriodicPotential U) (hPf : textbookUnitPeriodicPotential f) :
    brownianWeightedInner U β f (textbookBrownianGenerator m U β f) ≤ 0 := by
  have hn := textbookBrownianGenerator_inner_nonpos m hm U β hβ f hU hf hPU hPf
  unfold textbookConfigurationInner at hn
  have hc := nonpos_of_mul_nonpos_right hn (inv_pos.mpr (textbookConfigurationPartition_pos U hU β))
  simpa [brownianWeightedInner, textbookConfigurationGibbsWeight] using hc
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]明确严格负定含全部非零周期光滑L²函数的读法。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed严格负定版准确编码任意非零周期光滑f的二次型<0；虽为假，按原文字面版规则不以不忠实判FAIL。已有[ERRATUM?]正确。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.brownianNegativeDefinitePrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:2531`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-OUDensityPrinted

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> The solution $`p(t)`$ to the Ornstein-Uhlenbeck equation, for any finite time $`t`$, is always normally distributed

$$
\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}
$$


> where

$$
\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def ouDensityPrinted (γ σ x0 t x : ℝ) : ℝ :=
  Real.exp (-(x-MolecularDynamics.Chapter06Review.ouMean γ x0 t)^2/(2*MolecularDynamics.Chapter06Review.ouVariance γ σ t))
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]定义中使用通用噪声σ，取σ=√(2γkBTm)即6.45；t=0资格另记录。

### 6. 审计结论（含网站结论）

网站原返回：PASS。Printed定义保留了原书未归一化指数。ouMean=exp(−γt)x0，ouVariance=σ\_noise²(1−exp(−2γt))/(2γ)；取σ\_noise²=2γkBTm就得到6.45。[EXTRA]已经说明参数转换。作为字面公式定义PASS，不把原书缺归一化或t=0问题算成该字面定义的签名错误。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouDensityPrinted` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2542`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.2-OUDensityCorrect

印刷p.248 / PDFp.269；§6.4.2。

### 1. 原文陈述

> The solution $`p(t)`$ to the Ornstein-Uhlenbeck equation, for any finite time $`t`$, is always normally distributed

$$
\rho(p,t)=\exp\left[-\frac{(p-\mu(t))^2}{2\sigma(t)^2}\right];\tag{6.44}
$$


> where

$$
\mu(t)=p_0e^{-\gamma t};\qquad\sigma^2(t)=k_BT m[1-e^{-2\gamma t}].\tag{6.45}
$$



### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def ouDensity (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)

/-- 修正版，对应原文 MD-6.4.2-OUDensityPrinted；改动：增加(2πσ²(t))⁻¹/²，并限γ>0、噪声非零、t>0的密度解释。 -/
def ouDensityPrinted_corrected (γ σ x0 t x : ℝ) : ℝ :=
  MolecularDynamics.Chapter06Review.ouDensityPrinted γ σ x0 t x / Real.sqrt (2*Real.pi*MolecularDynamics.Chapter06Review.ouVariance γ σ t)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]补归一化系数，正γ/温度/质量且t>0使用；仅实际密度公式定义，原OU严格law结论在§6.3.2保留，不计密度积分或过程law已证。

### 6. 审计结论（含网站结论）

网站原返回：PASS。ouDensity与ouDensityPrinted\_corrected均用完整指数除以sqrt(2πv)，修正合理。γ>0、σ\_noise≠0、t>0时v>0，得到通常正态密度；注释明确密度解释只在这一域成立。定义对全部实数全定义不意味着声称退化参数下也是密度；没有积分归一化或过程HasLaw定理可被误计为已证。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.ouDensity` | 定义 | — | PASS |
| `MD.Ch06.ouDensityPrinted_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2547`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption1Printed

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $`C\in\mathcal B(D)`$, the conditions:
> (i) For some $`y\in\operatorname{int}(C)`$, we have that for any $`\delta\gt 0`$ there is a $`t_0\gt 0`$ such that

$$
\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)\gt 0,\quad\forall X_0\in C.
$$


> (ii) For $`t\gt 0`$, the transition kernel possesses a density $`\widehat\rho(X,z,t)`$ such that

$$
\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);
$$


> and $`\widehat\rho(X,z,t)`$ is jointly continuous in $`C\times C\times[0,\infty)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption1Printed {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ici 0)
```

同问题的独立限定/修正版（位于另一条）：
```lean
def assumption1Printed_corrected {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | NEEDS\_HUMAN；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]真实Borel Markov kernel与局部参考测度；完整同一内点可达、全部初值与可测子集及联合连续资格。
- [EXTRA] 原文版忠实性与数学疑误分开；补齐所交条目所属的现有\_corrected完整签名，不从repair\_log名称推断网站已通过修正版。

### 6. 审计结论（含网站结论）

网站原返回：NEEDS\_HUMAN。Printed保留紧C、同一内点y、δ后选统一t、全部x和可测A⊆C及联合连续时间Ici 0；与原[0,∞)一致。ν是披露的参考测度推广，但Kernel本身不含Markov/半群资格；此定义只编码局部条件。原零时连续性疑误保留。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption1Printed` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2558`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption1Correct

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 1 The Markov process generated by the SDE (6.43) satisfies, for some fixed compact set $`C\in\mathcal B(D)`$, the conditions:
> (i) For some $`y\in\operatorname{int}(C)`$, we have that for any $`\delta\gt 0`$ there is a $`t_0\gt 0`$ such that

$$
\operatorname{Pr}(X(t_0)\in B_\delta(y)\mid X(0)=X_0)\gt 0,\quad\forall X_0\in C.
$$


> (ii) For $`t\gt 0`$, the transition kernel possesses a density $`\widehat\rho(X,z,t)`$ such that

$$
\operatorname{Pr}(X(t)\in A\mid X(0)=X_0)=\int_A\widehat\rho(X_0,z,t)dz,\quad\forall X_0\in C,\ A\in\mathcal B(D)\cap\mathcal B(C);
$$


> and $`\widehat\rho(X,z,t)`$ is jointly continuous in $`C\times C\times[0,\infty)`$.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption1 {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)

/-- 修正版，对应原文 MD-6.4.4-Assumption1Printed；改动：联合连续性的时间域由[0,∞)改为(0,∞)。 -/
def assumption1Printed_corrected {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D) : Prop :=
  IsCompact C ∧ (∃ y ∈ interior C, ∀ δ : ℝ, 0 < δ → ∃ t : ℝ≥0, 0 < t ∧
    ∀ x ∈ C, 0 < K t x (Metric.ball y δ)) ∧
  ∃ ρ : D → D → ℝ → ℝ, (∀ x z t, 0 ≤ ρ x z t) ∧
    (∀ t : ℝ≥0, 0 < t → ∀ x ∈ C, ∀ A : Set D, MeasurableSet A → A ⊆ C →
      K t x A = ∫⁻ z in A, ENNReal.ofReal (ρ x z t) ∂ν) ∧
    ContinuousOn (fun w : (D×D)×ℝ ↦ ρ w.1.1 w.1.2 w.2) ((C×ˢ C)×ˢ Ioi 0)
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]联合连续域改为C×C×(0,∞)，正时刻实际密度与全部可达资格保留；只定义修正版，未计任何具体SDE已满足。

### 6. 审计结论（含网站结论）

网站原返回：PASS。assumption1与assumption1Printed\_corrected两定义一致，唯一实质修正为Ici 0→Ioi 0；密度公式仍仅正时、x∈C及可测A⊆C，内点可达量词未变。作为修正条件定义合理，不是具体SDE满足它的断言。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption1` | 定义 | — | PASS |
| `MD.Ch06.assumption1Printed_corrected` | 定义 | — | 未获单独PASS；见分版意见 |

位置：`Blueprint/Ch06.lean:2569`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-Assumption2

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> Assumption 2 There is a function $`\varphi:D\to(0,\infty)`$, with $`\varphi(X)\to\infty`$ as $`|X|\to\infty`$ such that

$$
\mathcal L\varphi\le-\alpha\varphi+\delta
$$


> for positive constants $`\alpha`$ and $`\delta`$, where $`\mathcal L`$ is the generator of the stochastic process (6.43). The function $`\varphi`$ is known as a Lyapunov function.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
def assumption2 {D : Type*} [TopologicalSpace D] (L : (D → ℝ) → D → ℝ)
    (φ : D → ℝ) (α δ : ℝ) : Prop :=
  (∀ x, 0 < φ x) ∧ Continuous φ ∧ (∀ R : ℝ, IsCompact {x | φ x ≤ R}) ∧
    0 < α ∧ 0 < δ ∧ ∀ x, L φ x ≤ -α*φ x+δ
local instance : MeasureSpace UnitAddCircle := ⟨AddCircle.haarAddCircle⟩
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 本条所引原句及展示公式；单个记号归入context\_notation。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；首轮保留 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA]柱形相空间以真实compact sublevels表达趋无穷；连续正Lyapunov及正α/δ，未把Harris结论藏进定义。具体generator域资格在对应命题明确。

### 6. 审计结论（含网站结论）

网站原返回：PASS。φ处处严格正、连续、所有实数水平的次水平集紧，α,δ>0及逐点漂移不等式完整。在欧氏/torus×欧氏常用状态空间上，这是披露的proper Lyapunov解释；一般拓扑上仅是所选推广。L的域资格未由该定义提供。
当前处理：网站PASS（首轮未改版本）。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.assumption2` | 定义 | — | PASS |

位置：`Blueprint/Ch06.lean:2590`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-MinorizationPrinted

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem minorizationPrinted : ∀ {S : Type*} [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (ν : Measure S) (K : ℝ≥0 → Kernel S S) (C : Set S),
  MolecularDynamics.Chapter06Review.assumption1Printed ν K C ↔
    ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure S,
      IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

同问题的独立限定/修正版（位于另一条）：
```lean
theorem minorizationPrinted_corrected :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
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

网站原返回：NEEDS\_HUMAN。Printed将tantamount忠实读为↔，右侧给一个正时刻、正ENNReal下界系数和同一概率μ，对全部x∈C作完整测度序下界。左侧仍为原零时连续版；抽象签名没有SDE或Markov半群假设，等价一般错误。
当前处理：原文疑误或语义范围待导师；不冒称未提供版本已通过。
保留所交版本的明确结论。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.minorizationPrinted` | 未证 | 原书疑误不证 | 原文忠实性PASS；原书数学/范围NEEDS\_HUMAN |

位置：`Blueprint/Ch06.lean:2599`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

## MD-6.4.4-MinorizationCorrectedImplication

印刷p.252 / PDFp.273；§6.4.4。

### 1. 原文陈述

> It can be shown that this assumption is tantamount to the SDE satisfying a minorization condition. This condition is a particular case of the general concept of small sets, found in Markov literature for proving ergodicity.

### 2. 原文证明

> 原书未给独立完整证明。

### 3. 完整当前Lean（原文版与修正版独立列出）

```lean
theorem minorizationCorrectedImplication :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry

/-- 修正版，对应原文 MD-6.4.4-MinorizationPrinted；改动：只保留在明确正时刻密度、可达性条件下到小集下界的充分方向。 -/
theorem minorizationPrinted_corrected :
  ∀ {D : Type*} [MetricSpace D] [MeasurableSpace D] [BorelSpace D]
    (ν : Measure D) (K : ℝ≥0 → Kernel D D) (C : Set D),
    MolecularDynamics.Chapter06Review.markovSemigroup K →
    (∀ A : Set D, IsOpen A → A.Nonempty → 0 < ν A) →
    MolecularDynamics.Chapter06Review.assumption1 ν K C →
  (∀ t : ℝ≥0, ∀ x : D, ∀ A : Set D, IsOpen A → A.Nonempty → 0 < t → 0 < K t x A) →
  ∃ t : ℝ≥0, 0 < t ∧ ∃ ε : ℝ≥0∞, 0 < ε ∧ ∃ μ : Measure D,
    IsProbabilityMeasure μ ∧ ∀ x ∈ C, ε • μ ≤ K t x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 当前Lean与范围 |
|---|---|
| 所引原句 | 只覆盖加强假设下由Assumption 1到共同小集下界的充分方向；不覆盖原tantamount所可能表示的必要方向。 |
| 对象、域、量词及前提 | 以上完整声明；额外资格与未覆盖部分见下一段 |
| 最新网站原始评价 | PASS；复审 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] 主版与minorizationPrinted\_corrected同时补Chapman–Kolmogorov/Markov半群及参考测度全支撑。两步核局部共同下界仍需大型小集理论，未证明、未宣称数学结论已核定；审阅结论按各版本分别记录。
- [EXTRA] 还独立假设：对所有t>0、所有x及所有非空开集A，K t x A>0；这比原Assumption 1(i)强，不能省略于假设说明。
- [EXTRA] assumption1中的密度联合连续性只在t>0要求；原书写到t=0的端点问题另见条目10、14。
- [EXTRA] 复审范围：仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
- 覆盖缺口：未声明或认证minorization反推原Assumption 1的必要方向。

### 6. 审计结论（含网站结论）

网站原返回：PASS。A：关于“tantamount”及small sets的两句原文准确。C：两份声明签名相同，作为明确加强前提的充分方向均PASS。逐项包含实际概率核半群/Chapman–Kolmogorov、参考测度对所有非空开集为正、紧C及其内点可达条件、仅正时刻在C×C上联合连续的实非负密度；此外还另行假设所有点、所有正时刻对每个非空开集都有正概率。这一全局开放集可达性是实质性加强，不能由原Assumption 1(i)的固定内点可达性直接冒充。结论的时间、ε>0及概率μ先于所有x∈C选择，测度序ε•μ≤K t x正是共同小集下界；ε不必额外假设≤1，因为K t x和μ为概率。连续局部密度、紧性和真实核合成足以支持此加强版的共同下界；未以sorry是否消除作为签名判据。这里只认证充分方向，未把原文“tantamount”解读为已经认证了必要方向。JSON须补记遗漏的全局可达前提。
当前处理：网站PASS（复审）。
仅覆盖加强条件下充分方向；还独立要求所有点、所有正时刻对每个非空开集有正概率，以及Markov合成、参考测度全支撑，不覆盖原tantamount的必要方向。
本地编译和逐声明依赖核对通过。原文疑误、各限定/修正版、反例的评价分别列出；有未完成证明依赖的声明仍为未证。

### 7. 状态与证明位置

| 声明 | 证明状态 | 未证原因 | 网站分版结论 |
|---|---|---|---|
| `MD.Ch06.minorizationCorrectedImplication` | 未证 | 缺大型理论 | PASS |
| `MD.Ch06.minorizationPrinted_corrected` | 未证 | 缺大型理论 | PASS |

位置：`Blueprint/Ch06.lean:2608`；本地核验记录：`blueprint/ch06/closeout26/FINAL_COMPILE.log`。

