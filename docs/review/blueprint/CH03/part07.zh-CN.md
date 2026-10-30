[上一部分](part06.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part08.zh-CN.md)

## 1. MD-3.5-NoHamiltonianAttractor · unnumbered_claim · 印刷p.126 / PDFp.148

### 2. 原文陈述

> In the first phase, the discrete trajectory appears to be filling in the correct region and without any evidence of nonphysical behavior. The performance is very similar to a Verlet method without projection during this period. In the second phase the system begins to move toward a limit cycle, i.e. an attractive periodic orbit. The presence of such limit cycles is impossible in a Hamiltonian system, thus it is evident that a nonphysical artefact has been introduced by the projection method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem noHamiltonianAttractor :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (orbit B : Set (SymplecticCoordinates n)), ContDiff ℝ 2 H →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (textbookHamiltonianVectorField H (Φ t z)) t) →
    IsCompact orbit → orbit.Nonempty → volume orbit=0 → IsOpen B → 0 < volume B → volume B < ⊤ →
    ¬ (∀ z ∈ B, Tendsto (fun t => Metric.infDist (Φ t z) orbit) atTop (𝓝 0)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.noHamiltonianAttractor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。 | [EXTRA] |

[EXTRA] 明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；noHamiltonianAttractor量化任意维数的C² Hamiltonian和全实时间真实流，具有初值及群律。orbit要求紧、非空、零体积；B要求开放、正且有限体积。完整结论否定对所有z∈B，t→+∞时到orbit的距离趋零，确实排除正体积开放盆的吸引，不是错误地排除一条特殊收敛轨道。该声明甚至不需orbit周期性或不变性，覆盖任何紧零体积目标集，故包含普通周期轨道的情形。C² H给C¹向量场；ODE唯一性使所给全时间解族成为保体积流。取足够小的有限体积轨道邻域，点态吸引和保体积的Fatou估计即产生矛盾；无需把一致吸引偷加为前提。[EXTRA]的正有限盆及紧零体积目标是合理明确化。

### 7. 状态与证明位置

incomplete；`MD.Ch03.noHamiltonianAttractor`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1781)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-LinearContinuousIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> Generalizing this slightly, we could imagine a system of ODEs of the form

$$
\dot{\boldsymbol z}=f(\boldsymbol z),
$$


> such that, for some vector $`\boldsymbol b`$,

$$
\boldsymbol b\cdot f(\boldsymbol z)\equiv0,
$$


> then $`I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z`$ is a first integral.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem linearContinuousIntegral :
    ∀ (n : ℕ) (b : Fin n → ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
      (∀ z, ∑ i, b i*f z i = 0) →
      (∀ t, HasDerivAt γ (f (γ t)) t) →
      ∀ t, (∑ i, b i*γ t i) = ∑ i, b i*γ 0 i := by
  intro n b f γ hbf hγ t
  have hd : ∀ s, HasDerivAt (fun t => ∑ i, b i*γ t i) 0 s := by
    intro s
    simpa only [hbf] using HasDerivAt.fun_sum
      (u := Finset.univ) (fun i _ => ((hasDerivAt_pi.mp (hγ s)) i).const_mul (b i))
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.linearContinuousIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实全时间轨道导数资格显式；不宣称任意f有全时间解。 | [EXTRA] |

[EXTRA] 真实全时间轨道导数资格显式；不宣称任意f有全时间解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开依赖2816的 Q n=Fin n→ℝ，b为实有限向量，∑i b i*f z i 正是 b·f(z)。量词先全称 n,b,f,轨道γ，再假设∀z 的恒零点积和∀t 的真实轨道导数γ′(t)=f(γ(t))，最终对每个实t断言 b·γ(t)=b·γ(0)。这给出连续轨道上的完整 first integral，而不是仅 Euler 一步或某个离散格式。无需f额外光滑性：已有每时刻可微解和零点积，复合线性函数导数恒零即可。全时间轨道条件明确且合理，未断言所有f均有全局解；原文任何连通局部解区间上的版本是相应局部推广，本签名取已声明的全时间范围。所有数学结论子句在此范围内保留；相邻 Euler/RK 保持性质不属本条。Ch03.lean:1043–1049 所示证明以有限和求导及零导数推出常数，无本条 sorry；本次只读审计未编译工程。无 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch03.linearContinuousIntegral`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1792)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6-HamiltonianFlowStructures · unnumbered_claim · 印刷p.127–128 / PDFp.149–150

### 2. 原文陈述

> The flow of a Hamiltonian system of the form $`H=p^TM^{-1}p/2+U(q)`$ will preserve all of the following:
> 1. The symplectic two-form $`\mathrm dq\wedge\mathrm dp`$.
> 2. The Hamiltonian (i.e., the energy) $`H`$.
> 3. The volume in phase space (as the vector field is divergence free).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianFlowStructures :
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, H (Φ (t,z))=H z) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianFlowStructures` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Hamiltonian在开放域C²；真实localFlowC1的初值、ODE与局部定义域资格，未假设显式反步。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。 | [EXTRA] |

[EXTRA] Hamiltonian在开放域C²；真实localFlowC1的初值、ODE与局部定义域资格，未假设显式反步。；[EXTRA] 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐项展开localFlowC1、J、Jacobian、Hessian与Hamiltonian向量场后，声明量化开放D、Ω⊆D、τ>0、H在D上C²及真实C¹局部流。完整结论有五组：内部时间上的Jacobian变分方程；闭时间区间上的辛性；det=1；H(Φ(t,z))=H z；以及每个可测S⊆Ω的像集合体积守恒。能量结论已经明确在第四个合取中，不能沿用旧注释说它缺失。初值与ODE资格没有预先供应辛性、能量或体积结论；虽然未假设反步公式，ODE局部唯一性仍给固定时刻的单射性。任意C² H是对原机械型H的合理推广；Ω的开放性使各时刻空间全导数有意义，变分式只取内部时间，端点保留空间辛性等结论，域与量词无缺漏。

### 7. 状态与证明位置

incomplete；`MD.Ch03.hamiltonianFlowStructures`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1808)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6-VolumeNotSymplectic · unnumbered_claim · 印刷p.128 / PDFp.150

### 2. 原文陈述

> The phase volume conservation can be seen as a consequence of the symplectic property, but it is a weaker condition. It is possible to construct methods that preserve volume but which are not symplectic, and we can build methods that exactly conserve the energy (as we shall show below).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem volumeNotSymplectic :
  ∃ G : SymplecticCoordinates 2 → SymplecticCoordinates 2,
    ContDiff ℝ 1 G ∧ Function.Injective G ∧
    (∀ S, MeasurableSet S → volume (G '' S)=volume S) ∧ (∀ z, (textbookJacobian G z).det=1) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry

theorem volumeNotSymplectic_symplectic_volume (n : ℕ)
    (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (_hG : IsTextbookSymplecticMap G) (_hinj : Function.Injective G) :
    ∀ S, MeasurableSet S → volume (G '' S)=volume S := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 辛C¹全局单射映射的真实体积保持及保体积非辛见证；精确能量方法构造由MD-3.5-ProjectionEnergy承担，Hamiltonian流实例由MD-3.6-HamiltonianFlowStructures承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.volumeNotSymplectic`；`MD.Ch03.volumeNotSymplectic_symplectic_volume` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两个声明全部核对。volumeNotSymplectic在SymplecticCoordinates 2即四维实空间选C¹单射G，明确要求所有可测集合的真实像体积相同、各点det=1且G不辛；它不只是一个行列式条件。第二个volumeNotSymplectic\_symplectic\_volume对任意n的全局C¹辛单射G给出全部可测集合的像体积守恒，确已覆盖“辛性蕴含体积守恒”。单射性排除重数造成的全局像体积问题，是已明示scope内的合理资格。四维足以提供严格较弱见证；例如按(q₁,q₂,p₁,p₂)取diag(2,1,1,1/2)，其det为1且全局保体积，但两个辛配对缩放分别为2与1/2，故不辛。旧context称仅有det=1且未覆盖其它结论，与当前两个完整签名不符，须更正元数据；不构成现行Lean签名失败。

### 7. 状态与证明位置

incomplete；`MD.Ch03.volumeNotSymplectic`：未证（缺大型理论）；`MD.Ch03.volumeNotSymplectic_symplectic_volume`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1824)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-LinearInvolution · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> By an involution we mean a linear mapping $`\boldsymbol z\mapsto R\boldsymbol z`$ where $`R^2=I`$, i.e. $`R`$ is its own inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.linearInvolution` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt：Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；这些是实有限维坐标。 Ch03.lean:1073 的 R 是实连续线性自映射，R.comp R=id 即 ∀z,R(Rz)=z。有限维线性自动连续，未添加实质限制。无需 Rᵀ=R；例如 [[1,1],[0,-1]] 是非对称involution。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.linearInvolution`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1837)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedFieldPrinted · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Given the involution $`R`$ we define the time reversal of the vector field $`f`$ with respect to $`R`$ by

$$
\widetilde f(\boldsymbol z)=-R^Tf(R\boldsymbol z).
$$


> When a vector field is its own reversal we say that it is a time-reversible vector field.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def reversedField {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (z : Q n) : Q n :=
  -(R.transpose.mulVec (f (R.mulVec z)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversedField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt：Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；这些是实有限维坐标。 依赖 Chapter03/ReviewDefinitions.lean:3617 与本地1077均展开为 −(R.transpose.mulVec(f(R.mulVec z)))，即原书字面−Rᵀf(Rz)。定义容许一般矩阵是定义域扩展，应用到R²=I时完全相符；“自身反转”解释为∀z,f z=reversedField R f z，不是该函数定义本身的额外结论。[ERRATUM?]成立：轨道链式法则给−Rf(Rz)，一般involution不等于其转置；不应静默替换字面定义。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.reversedField`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1841)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-MomentumReversal · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Let $`H(q,p)=p^TM^{-1}p/2+U(q)`$ be the Hamiltonian for a system of $`N_c`$ configuration variables. Define the $`2N_c\times2N_c`$ matrix $`R`$ by

$$
R=\begin{bmatrix}I&0\\0&-I\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.momentumReversal` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt：Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；这些是实有限维坐标。 momentumReversal z=(z.1,−z.2)，正是块矩阵diag(I,−I)的作用。依赖中的 SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ，pack z=Sum.elim z.1 z.2，canonicalReversal保持inl坐标并取反inr坐标，所以context等价坐标说法成立。H仅说明使用环境，定义R无需m、U参数或假设。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.momentumReversal`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1845)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-MechanicalReversal · unnumbered_claim · 印刷p.128 / PDFp.150

### 2. 原文陈述

> The vector fields involved are

$$
f=\begin{bmatrix}M^{-1}p\\-\nabla U(q)\end{bmatrix},\qquad\widetilde f=-Rf(Rz)=-\begin{bmatrix}-M^{-1}p\\\nabla U(q)\end{bmatrix},
$$


> which are clearly equal. Therefore the molecular dynamics Hamiltonian system is time-reversible.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mechanicalReversalPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n),
      (-momentumReversal (mechanicalField m (fun q => -grad U q) (momentumReversal z)) =
        -(-invMass m z.2, grad U z.1)) ∧
      (-(-invMass m z.2, grad U z.1) = mechanicalField m (fun q => -grad U q) z) ∧
      mechanicalField m (fun q => -grad U q) (momentumReversal z) =
        -momentumReversal (mechanicalField m (fun q => -grad U q) z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.mechanicalReversalPrinted` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。 | [EXTRA] |

[EXTRA] [EXTRA] 按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；mechanicalReversalPrinted的三个合取全部核对：−R f(Rz)等于带外负号的列向量；该列向量等于f(z)；并有f(Rz)=−R f(z)。momentumReversal(q,p)=(q,−p)，mechanicalField=(invMass m p,−grad U q)，invMass逐坐标线性；展开后所有负号一致。任意实质量参数和任意U是这个代数恒等式的合法推广；不需要为了梯度的物理解释而把不必要的光滑或质量正性加入代数结论。[EXTRA]所述外负号修复确已落实。

### 7. 状态与证明位置

incomplete；`MD.Ch03.mechanicalReversalPrinted`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1850)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedTrajectoryPrinted · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> For the system $`\mathrm dz/\mathrm dt=f(\boldsymbol z)`$, a coordinate transformation $`\boldsymbol z\mapsto\widetilde{\boldsymbol z}=R\boldsymbol z`$ results in

$$
\frac{\mathrm d\widetilde{\boldsymbol z}}{\mathrm dt}=R\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Rf(R^{-1}\widetilde{\boldsymbol z})=Rf(R\widetilde{\boldsymbol z}),
$$


> since $`R^{-1}=R`$. A change of time $`t\mapsto\tau=-t`$ results in

$$
\frac{\mathrm d\boldsymbol z}{\mathrm d\tau}=\frac{\mathrm dt}{\mathrm d\tau}\frac{\mathrm d\boldsymbol z}{\mathrm dt}=-f(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reversedTrajectoryPrinted :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (-R.mulVec (f (γ (-t)))) t := by
  sorry

theorem reversedTrajectoryPrinted_coordinateChange (n : ℕ)
    (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hR : R*R=1) (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ R.mulVec (γ s))
      (R.mulVec (f (R.mulVec (R.mulVec (γ t))))) t := by
  sorry

theorem reversedTrajectoryPrinted_timeChange (n : ℕ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ γ (-s)) (-f (γ (-t))) t := by
  sorry



/-- 修正版，对应原文 MD-3.6.1-ReversedTrajectoryPrinted。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem reversedTrajectoryPrinted_corrected :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (-R.mulVec (f (γ (-t)))) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversedTrajectoryPrinted`；`MD.Ch03.reversedTrajectoryPrinted_coordinateChange`；`MD.Ch03.reversedTrajectoryPrinted_timeChange`；`MD.Ch03.reversedTrajectoryPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；同source\_id三条声明全部正确且忠实于当前所录原页129：主声明给Rγ(−t)的导数−Rf(γ(−t))；coordinateChange给Rγ(t)的导数Rf(R(Rγ(t)))，R²=I使其等于Rf(γ(t))，正是Rf(Rz̃)；timeChange给γ(−t)的导数−f(γ(−t))。R是任意实方阵且R²=I，γ在所有实时间满足真实ODE；主结论并未声称变换轨道仍解原f，也未使用Rᵀ或要求R对称。因此Printed版本没有被换成错误的转置反转版本，[EXTRA]补出的分离链式规则已存在。PASS仅就本条原文链式规则及三个当前签名；p128定义争议另留NEEDS\_HUMAN。

### 7. 状态与证明位置

incomplete；`MD.Ch03.reversedTrajectoryPrinted`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectoryPrinted_coordinateChange`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectoryPrinted_timeChange`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectoryPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1864)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedTrajectory · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> In other words, for a reversible vector field, the coordinate transformation $`\boldsymbol z\mapsto R\boldsymbol z`$ is equivalent to the change of time $`t\mapsto-t`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reversedTrajectory :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ i j, R (Pi.single j 1) i = R (Pi.single i 1) j) → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
  sorry



/-- 修正版，对应原文 MD-3.6.1-ReversedTrajectory。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem reversedTrajectory_corrected :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ i j, R (Pi.single j 1) i = R (Pi.single i 1) j) → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversedTrajectory`；`MD.Ch03.reversedTrajectory_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。；[EXTRA] 补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；reversedTrajectory量化任意n、连续线性R、f和全实时间解γ；要求R²=id，另明确加入全部基矩阵元素R\_ij=R\_ji的对称资格，以及f(Rz)=−Rf(z)。结论Rγ(−t)仍满足原f的ODE；由链式法则导数=−Rf(γ(−t))=f(Rγ(−t))，数学正确。坐标对称资格不是隐藏的，它恰使Rᵀ=R=R⁻¹，从而可与原印反转定义兼容；这是一条合理但严格受限的修复，并未证明原书对任意非对称involution的宽泛句子。PASS针对已显式标注[EXTRA]的受限当前签名，原书一般性问题保留NEEDS\_HUMAN。

### 7. 状态与证明位置

incomplete；`MD.Ch03.reversedTrajectory`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectory_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1900)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-FlowReversal · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> From this we see that if we start from a point $`z_0`$ and integrate forward in time (i.e apply $`\mathcal F_t`$) then apply the involution $`R`$, we get the exact same result as if we start from $`\widetilde z(0)=Rz_0`$ and integrate backward in time (i.e apply $`\mathcal F_{-t}`$). In sum, since $`z_0`$ is an arbitrary point,

$$
\mathcal F_{-t}(Rz)=R\mathcal F_t(z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowReversal :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z) := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-FlowReversal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem flowReversal_corrected :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.flowReversal`；`MD.Ch03.flowReversal_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；flowReversal作为经典修正版数学正确：任意n与连续线性involution R、全局C¹ f，显式要求f(Rz)=−Rf(z)，Φ对每个初值在全部实时间有正确初值和ODE导数，结论对所有t,z为Φ(−t,Rz)=RΦ(t,z)。C¹场保证唯一性；没有把所需反转等式塞进Φ的资格，也不需预先假设群律。对应原文的唯一未决点是“reversible”的含义：当前关系采用正确R版，而p128字面定义用Rᵀ；仅involution不使二者等价，且本条未像reversedTrajectory那样补对称R资格。因此不给数学正确的经典定理判FAIL，但原书与当前签名之间的定义对应仍需人工确认；NEEDS\_HUMAN不是sorry导致的。

### 7. 状态与证明位置

incomplete；`MD.Ch03.flowReversal`：未证（原书疑误不证）；`MD.Ch03.flowReversal_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1924)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-FlowReversalIdentity · (3.14) · 印刷p.129 / PDFp.151

### 2. 原文陈述

> For the flow map, $`\mathcal F_{-t}=\mathcal F_t^{-1}`$ so we can recast the identity as

$$
R\circ\mathcal F_t\circ R\circ\mathcal F_t=\mathrm{Id},\tag{3.14}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowReversalIdentity :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-FlowReversalIdentity。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem flowReversalIdentity_corrected :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.flowReversalIdentity`；`MD.Ch03.flowReversalIdentity_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正确R反转、C¹场、实际全时间流、群性质；不供应结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正确R反转、C¹场、实际全时间流、群性质；不供应结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；flowReversalIdentity逐项包含线性involution、C¹向量场、经典反转条件、Φ初值、全实时间ODE和群律，完整结论对任意t,z给R(Φ t(R(Φ t z)))=z。群律加初值确实给Φ(−t)为双侧逆；结合经典反转得到(3.14)，无循环假设。和上一条一样，这个经典版本正确，但原印p128的Rᵀ定义与当前f(Rz)=−Rf(z)在一般R下不等价；本条没有对称性限定。NEEDS\_HUMAN用于确认原文到当前声明的勘误解释，不否定所给条件下的代数/ODE结论。

### 7. 状态与证明位置

incomplete；`MD.Ch03.flowReversalIdentity`：未证（原书疑误不证）；`MD.Ch03.flowReversalIdentity_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1948)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-ReversibleMethod · (3.15) · 印刷p.130 / PDFp.152

### 2. 原文陈述

> It does not automatically follow that a symmetric numerical method is time-reversible, i.e. satisfies a relation inspired by (3.14), namely

$$
R\circ\mathcal G_h\circ R\circ\mathcal G_h=\mathrm{Id}.\tag{3.15}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversibleMethod` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03.lean 和依赖 Chapter03/ReviewDefinitions.lean 中 reversibleMethod 均逐字展开为 ∀h z, R(G h(R(G h z)))=z，即(3.15)在每一步长、每个状态的点态等式。E 的类型泛化不改变定义含义；R 作为外部给定 involution 的语境参数，定义本身无须再断言 R²=id。该 def 表达“time-reversible”的定义性关系；原句对 symmetric 不自动推出 reversible 的否定说明不是本 def 的定理结论。无 [EXTRA]、无 [ERRATUM?]，定义体无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.reversibleMethod`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1970)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-SymmetricMethod · definition · 印刷p.130 / PDFp.152

### 2. 原文陈述

> Recall from the previous chapter that a numerical method $`\mathcal G_h`$ was said to be symmetric if it satisfied

$$
\mathcal G_{-h}=\mathcal G_h^{-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.symmetricMethod` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；symmetricMethod对任意类型E，以G:ℝ→Equiv.Perm E显式保证各一步映射可逆，再对所有实h规定G(−h)=(G h).symm。右端是实际逆置换，而非任意候选反步或单侧逆；对象、步长符号和等号方向均与定义相同，不额外宣称R时间可逆性。

### 7. 状态与证明位置

self-contained；`MD.Ch03.symmetricMethod`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1973)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-AffineInvariant · Definition 3.1 · 印刷p.130 / PDFp.152

### 2. 原文陈述

> Definition 3.1 (Affine Invariance) Let

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)\tag{3.16}
$$


> be a given ordinary differential equation. The transformation $`\widetilde{\boldsymbol z}=A\boldsymbol z`$, where $`A`$ is a non-singular square matrix, results in the modified differential equation

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Af(A^{-1}\widetilde{\boldsymbol z}).\tag{3.17}
$$


> Let $`z_0,z_1,\ldots`$ be a sequence of points obtained by application of the numerical method $`\mathcal G_h`$ to (3.16). If the same method, when applied to (3.17) produces the set of points $`Az_0,Az_1,\ldots`$, then we say that the numerical method is invariant with respect to the transformation $`\widetilde{\boldsymbol z}=Az`$. An affine invariant method is one which is invariant under any such transformation.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)



/-- 修正版，对应原文 MD-3.6.2-AffineInvariant。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def affineInvariant_corrected {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.affineInvariant`；`MD.Ch03.affineInvariant_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；affineInvariant量化固定有限维实空间上的全部连续线性同构A、向量场f、实步长h和初值z；transportedField A f(z)=A(f(A⁻¹z))。完整关系G_{A f A⁻¹}(h,Az)=A(G\_f(h,z))正是变换初值后每一步等变，归纳即得所述序列。≃L准确表示有限维非奇异方阵；未偷加平移，也未把A限制成正交矩阵。PASS针对上下文已明示的变换坐标语义及当前方法定义；原印(3.17)左端记号疑误在json\_review保留NEEDS\_HUMAN。

### 7. 状态与证明位置

self-contained；`MD.Ch03.affineInvariant`：定义；`MD.Ch03.affineInvariant_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1978)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-SymmetricAffineReversible · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> If a differential equation is time-reversible with respect to the involution $`R`$, and we apply a method which is affine invariant and symmetric, then the method will be time-reversible (3.15).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricAffineReversible :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ h z, G (fun x => -f x) h z=G f (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f) := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-SymmetricAffineReversible。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symmetricAffineReversible_corrected :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ h z, G (fun x => -f x) h z=G f (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.symmetricAffineReversible`；`MD.Ch03.symmetricAffineReversible_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]G_{−f}(h)=G\_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]G_{−f}(h)=G\_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。；[EXTRA] 明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；symmetricAffineReversible的全部条件已核对：R为连续线性同构且平方为id；f有经典R反转；方法对全部线性同构等变；另只对本固定f显式要求G_{−f}(h)=G\_f(−h)；并要求所有h的反步复合G\_f(−h)∘G\_f(h)=id。因为量化所有h，最后一个条件同时给另一方向的逆关系，不必再把G编码为Perm。对R使用affineInvariant，利用transportedField R f=−f及变号相容性，得到R∘G\_f(h)∘R=G\_f(−h)，再复合G\_f(h)即为reversibleMethod。完整结论∀h,z,R(G\_f(h,R(G\_f(h,z))))=z与(3.15)一致；不存在把所需结论作为假设的问题。[EXTRA]变号相容性是实质新增且已明示的合理修复，不能把当前受限正确版本当作原句对所有抽象方法已成立。

### 7. 状态与证明位置

incomplete；`MD.Ch03.symmetricAffineReversible`：未证（原书疑误不证）；`MD.Ch03.symmetricAffineReversible_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1992)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-RKAffine · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rkAffine :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i)) := by
  exact MolecularDynamics.Chapter03Review.rkAffine_proved



/-- 修正版，对应原文 MD-3.6.2-RKAffine。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem rkAffine_corrected :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i)) := by
  exact MolecularDynamics.Chapter03Review.rkAffine_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 普通RK关系的线性坐标变换等变性子句；PRK保持分区的修复子句见MD-3.6.2-PartitionedAffine，时间反演推论见MD-3.6.2-SymmetricAffineReversible。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.rkAffine`；`MD.Ch03.rkAffine_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；普通RK子句签名正确：n、s允许零维/零阶段，L为实连续线性自同构；任意f、实系数A,b及实h，给定完整阶段解F与终点w，结论正是运输场L∘f∘L⁻¹下运输阶段、初末状态满足同一关系。没有偷加求解唯一性，也没有断言存在数值单值映射。原页定义所谓affine invariance实际只写非奇异线性变换，故本条不因缺平移判FAIL。[EXTRA]/scope明确只覆盖普通RK，未覆盖PRK和时间反演推论。原句对任意混合q,p变换的PRK全称过强，且时间反演仍须原微分方程对R可逆；这些原书资格疑点须保留。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.rkAffine`：已证；`MD.Ch03.rkAffine_corrected`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2018)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

