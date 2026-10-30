上一部分：无 / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第2章 Lean Blueprint 本地审阅材料

160条；网站PASS 126，本地按意见修复4条（未再送网站），合并勘误25项。
统计与证明状态见[导师摘要](../../CH02_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](../../CH02_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch02/full/CHECK\_REPORT.json。

## 1. MD-2-HamiltonianODE · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> The challenge before us is to compute solutions of

$$
\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad \dot{\boldsymbol p}=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q),
$$


> or, more compactly, with $`\boldsymbol z`$ representing the collection of all positions and momenta,

$$
\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),\qquad \boldsymbol f(\boldsymbol z)=\boldsymbol J\nabla H,\tag{2.1}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def hamiltonianODE {n : ℕ} (m : Fin n → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) (I : Set ℝ) : Prop :=
  IsOpen I ∧
  (∀ z, H z = (∑ i, z (Sum.inr i)^2/(2*m i)) + U (fun i ↦ z (Sum.inl i))) ∧
  (∀ t ∈ I, DifferentiableAt ℝ H (γ t) ∧
    DifferentiableAt ℝ U (fun i ↦ γ t (Sum.inl i))) ∧
  ∀ t ∈ I, HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t ∧
    (∀ i, HasDerivAt (fun s ↦ γ s (Sum.inl i)) ((m i)⁻¹*γ t (Sum.inr i)) t) ∧
    ∀ i, HasDerivAt (fun s ↦ γ s (Sum.inr i))
      (-fderiv ℝ U (fun j ↦ γ t (Sum.inl j)) (Pi.single i 1)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonianODE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] EAUDIT01显式固定正对角质量、U/H沿轨道可微、H与真实机械式的全坐标关系；完整q̇=M⁻¹p、ṗ=−∇U及ż=J∇H均保留。I为开时间域，采用环境HasDerivAt；只定义经典轨道关系，不宣称存在或唯一。 | [EXTRA] |

[EXTRA] 原文ODE按时间域I逐点解释；只定义关系，不宣称解存在。；[EXTRA] EAUDIT01显式固定正对角质量、U/H沿轨道可微、H与真实机械式的全坐标关系；完整q̇=M⁻¹p、ṗ=−∇U及ż=J∇H均保留。I为开时间域，采用环境HasDerivAt；只定义经典轨道关系，不宣称存在或唯一。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；配置坐标为Fin n，完整相空间为Fin n⊕Fin n，inl为q、inr为p。质量逐坐标严格正；H在全空间等于动能和势能。I开放，H、U沿轨道可微，逐t∈I同时要求完整向量导数和每个q、p分量的经典导数。textbookJ的块矩阵为[0,I;-I,0]，坐标梯度以fderiv作用于Pi.single取得，符号和质量逆正确。[EXTRA]均明示；这是关系定义，不是存在性定理。

### 7. 状态与证明位置

self-contained；`MD.Ch02.hamiltonianODE`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L20)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2-Hamiltonian · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> and $`H=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)`$ is the Hamiltonian.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mechanicalHamiltonian {n : ℕ} (m : CoordinateMasses n)
    (_hm : ∀ i, 0 < m i) (U : PotentialEnergy n) : PhaseSpace n → ℝ :=
  massHamiltonian m U
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.mechanicalHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] EAUDIT01显式∀i,0<mᵢ排除奇异M及零除延拓；保持真实PhaseSpace的(q,p)机械Hamiltonian，固定对角质量来自第1章。 | [EXTRA] |

[EXTRA] 固定对角质量的机械模型来自第1章；一般非对角矩阵不纳入此复用接口。；[EXTRA] EAUDIT01显式∀i,0<mᵢ排除奇异M及零除延拓；保持真实PhaseSpace的(q,p)机械Hamiltonian，固定对角质量来自第1章。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；CoordinateMasses=Fin n→ℝ；PhaseSpace=Position×Momentum，位置和动量均为实EuclideanSpace。展开massHamiltonian、massSeparableEnergy、momentumKineticEnergy后恰为Σ p\_i²/(2m\_i)+U(q)。显式正质量排除除零；固定对角模型的限制已披露，不冒充任意质量矩阵版本。

### 7. 状态与证明位置

self-contained；`MD.Ch02.mechanicalHamiltonian`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L34)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2-Euler · definition · 印刷p.54 / PDFp.76

### 2. 原文陈述

> The simplest scheme is certainly Euler’s method which advances the solution from timestep to timestep by the formula\textsuperscript{1}

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+h\boldsymbol f(\boldsymbol z_n).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def euler {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (f : E → E) (h : ℝ) (z : E) : E := z + h • f z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.euler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意实赋范线性空间E、任意f:E→E、实h和z，返回z+h•f(z)，与显式Euler一步完全对应。泛化到E不改变公式；本定义不宣称收敛性或给定迭代轨迹存在。

### 7. 状态与证明位置

self-contained；`MD.Ch02.euler`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L39)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2-OneStep · definition · 印刷p.54 / PDFp.76

### 2. 原文陈述

> Suppose that the system under study has a well defined flow map $`\mathscr F_t`$ defined on the phase space (which is assumed to exclude any singular points of the potential energy function). The solution of the initial value problem, $`\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)`$, $`\boldsymbol z(0)=\boldsymbol\zeta`$, may be written $`\boldsymbol z(t,\boldsymbol\zeta)`$ (with $`\boldsymbol z(0,\boldsymbol\zeta)=\boldsymbol\zeta`$), and the flow-map $`\mathscr F_t`$ satisfies $`\mathscr F_t(\boldsymbol\zeta)=\boldsymbol z(t,\boldsymbol\zeta)`$. A one-step method, starting from a given point, approximates a point on the solution trajectory at a given time $`h`$ units later. Such a method defines a map $`\mathscr G_h`$ of the phase space as illustrated in Fig. 2.1.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def numericalTrajectory {n : ℕ} (m : Fin n → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin n → ℝ) → ℝ) (H : SymplecticCoordinates n → ℝ)
    (D : Set (SymplecticCoordinates n)) (G F : ℝ → D → D)
    (γ : ℝ → D → SymplecticCoordinates n) (Z : D → ℝ → ℕ → D) : Prop :=
  IsOpen D ∧ (∀ z ∈ D, DifferentiableAt ℝ U (fun i ↦ z (Sum.inl i))) ∧
  ∀ ζ : D, γ 0 ζ=ζ.1 ∧
    hamiltonianODE m hm U H (fun t ↦ γ t ζ) Set.univ ∧
    (∀ t, (F t ζ).1=γ t ζ) ∧
    ∀ h ν, Z ζ h ν=(G h)^[ν] ζ

def numericalIterate {E : Type*} (G : ℝ → E → E) (h : ℝ) (ζ : E) (ν : ℕ) : E :=
  (G h)^[ν] ζ

def oneStepTargetDifference {n : ℕ} {D : Set (SymplecticCoordinates n)}
    (G F : ℝ → D → D) (h : ℝ) (ζ : D) : ℝ :=
  ‖(G h ζ).1-(F h ζ).1‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.numericalTrajectory`；`MD.Ch02.numericalIterate`；`MD.Ch02.oneStepTargetDifference` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] EAUDIT01在开放正规相空间D排除势能不可微/奇异点；F的已给全时解族与初值/完整机械ODE相联，G作用于同一D，Z关联全部实际n次迭代。oneStepTargetDifference明确目标F\_h与G\_h的差；原段未规定定量近似质量，未加入虚构误差阶或收敛结论。全时流是此接口的给定模型资格，不是解存在定理。 | [EXTRA] |

[EXTRA] [EXTRA] EAUDIT01在开放正规相空间D排除势能不可微/奇异点；F的已给全时解族与初值/完整机械ODE相联，G作用于同一D，Z关联全部实际n次迭代。oneStepTargetDifference明确目标F\_h与G\_h的差；原段未规定定量近似质量，未加入虚构误差阶或收敛结论。全时流是此接口的给定模型资格，不是解存在定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；完整检查numericalTrajectory、numericalIterate、oneStepTargetDifference。开放D上U可微；G、F均从D到D；每个ζ的γ以ζ为初值、满足全时机械ODE、与F逐时相等，Z对所有h、ν等于G的ν次迭代。差值实际比较同一ζ上的G\_h和F\_h。全时、全步长留域和正规性是明显较强而已披露的接口资格；原段未给定量近似精度，因此没有缺失应有误差阶。

### 7. 状态与证明位置

self-contained；`MD.Ch02.numericalTrajectory`：定义；`MD.Ch02.numericalIterate`：定义；`MD.Ch02.oneStepTargetDifference`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L44)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Convergence · definition · 印刷p.55 / PDFp.77

### 2. 原文陈述

> The convergence of a numerical method refers to the ability of the method to provide an arbitrary level of accuracy by using small enough timesteps.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def convergence {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) : Prop :=
  Tendsto (fun ν : ℕ => oneStepMaxError G (τ / ν) γ ν) atTop (𝓝 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.convergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 按固定时间窗网格h=τ/ν表达任意精度；τ>0在具体定理中明示。 | [EXTRA] |

[EXTRA] 按固定时间窗网格h=τ/ν表达任意精度；τ>0在具体定理中明示。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。Ch02\_deps.txt 的 ReviewDefinitions.lean:2816 将 Q n 展开为 Fin n → ℝ，即有限维实坐标向量，标准函数空间范数为最大坐标范数；原条目未指定必须使用欧氏范数，且有限维范数等价，收敛与阶上界不受此选择影响。OneStepConvergence.lean:1443–1444 的 oneStepIterate G h z₀ k = (G h)^[k] z₀；1460–1463 的 oneStepMaxError = (Finset.range (ν+1)).sup′ nonempty (fun k => ‖(G h)^[k](../../γ 0) − γ((k:ℝ)*h)‖)。sup′ 在非空有限实数集合上为真正最大值，range(ν+1) 正好为0,…,ν，包含初末节点，不是只有末节点，也没有替换初值。 因而在固定 τ>0、h=τ/ν 的原文网格语境下，Tendsto atTop (𝓝 0) 展开为对每个 ε>0，存在自然数阈值 N，使所有 ν≥N 的全部节点误差最大值小于 ε；阈值可依赖 G、γ、τ、ε。这忠实表达任意精度和足够小步长。ν=0 的零除按 Lean 全函数约定处理，但有限前缀不影响极限。[EXTRA] 固定时间窗和网格受 PDF78/印刷56页上下文支持；无需给定义本身额外加 ODE 或正则性假设，因为这里只定义相对于给定准确曲线的误差性质。τ 未限制的接口是扩展；τ=0 或负时间的值不应冒充原文正时间窗的断言。注释“τ>0在具体定理中明示”不精确：本批 theorem\_2\_1 为0≤τ，且库明确单独处理τ=0；这是说明文字需修订，不是收敛谓词在原文使用域内的错误。无本条[ERRATUM?]。证明状态单列：这是定义，无直接sorry；本次不作编译或传递公理检查。

### 7. 状态与证明位置

self-contained；`MD.Ch02.convergence`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L63)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Order · definition · 印刷p.55 / PDFp.77

### 2. 原文陈述

> The order of accuracy is the exponent in the power law by which the error in the method is related to the stepsize. For example, when we say that a method is third order accurate, we mean that the global error (on a fixed finite time interval) can be bounded by $`Kh^3`$, where $`h`$ is a sufficiently small timestep and $`K`$ is a number which depends on the length of the time interval and the features of the problem, but which is independent of $`h`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def order {n : ℕ} (G : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (r : ℕ) : Prop :=
  ∃ K > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
    oneStepMaxError G (τ / ν) γ ν ≤ K * (τ / ν)^r
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.order` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 自然数阶r；ν₀>0避免零除；K选择严格正不损失误差上界。 | [EXTRA] |

[EXTRA] 自然数阶r；ν₀>0避免零除；K选择严格正不损失误差上界。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。Ch02\_deps.txt 的 ReviewDefinitions.lean:2816 将 Q n 展开为 Fin n → ℝ，即有限维实坐标向量，标准函数空间范数为最大坐标范数；原条目未指定必须使用欧氏范数，且有限维范数等价，收敛与阶上界不受此选择影响。OneStepConvergence.lean:1443–1444 的 oneStepIterate G h z₀ k = (G h)^[k] z₀；1460–1463 的 oneStepMaxError = (Finset.range (ν+1)).sup′ nonempty (fun k => ‖(G h)^[k](../../γ 0) − γ((k:ℝ)*h)‖)。sup′ 在非空有限实数集合上为真正最大值，range(ν+1) 正好为0,…,ν，包含初末节点，不是只有末节点，也没有替换初值。 量词为固定 G、γ、τ、r 后 ∃K>0，∃ν₀>0，∀ν≥ν₀，最大误差≤K(τ/ν)^r。K和阈值可依赖问题及时间长度，但不能依赖后选的ν；同时控制全部节点，完整保留固定时间区间的全局误差上界。原文用上界定义第三阶，未要求非零误差下界或“最佳阶”，故本签名无需添加这类条款。[EXTRA] r:ℕ 是已登记的一般化，取r=3直接回到原句；r=0只表O(1)，不能据此声称收敛。ν₀>0排除分母零；在原文τ>0域内将K增大到严格正不损失任何上界。h=τ/ν 来自原文固定网格，足够大ν等价该网格上足够小正步长；本条不宣称非网格步长或统一所有曲线的额外结论。τ:ℝ 的域外扩展不改变正时间窗含义，但应在使用说明中明确τ>0。无[ERRATUM?]。证明状态单列：定义，无直接sorry，不据此推断整个工程无sorry或已编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.order`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L68)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Error · definition · 印刷p.56 / PDFp.78

### 2. 原文陈述

> Let the approximate solution vectors at successive timesteps be $`\boldsymbol z_0,\boldsymbol z_1,\ldots,\boldsymbol z_\nu`$ where $`\nu h=\tau`$. We assume that $`\tau`$, the length of the time interval, is fixed, and $`\nu`$ is an integer parameter representing the total number of timesteps. In order to improve the quality of the approximation, the parameter $`\nu`$ may be increased, as the stepsize is proportionately decreased. The error at step $`n`$ is defined by $`e_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|`$, where $`t_n=nh`$; it clearly depends on $`h`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def maximumError {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (G : ℝ → E → E) (γ : ℝ → E) (h : ℝ) (ν : ℕ) : ℝ :=
  oneStepMaxError G h γ ν
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.maximumError` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。已展开 OneStepConvergence.lean:1443–1444、1460–1463：maximumError G γ h ν = max_{0≤k≤ν} ‖(G h)^[k](../../γ 0)−γ((k:ℝ)*h)‖。ReviewDefinitions.lean:2819–2821 同时给出 meshTime h k = k*h、nodeError G γ h k = ‖oneStepIterate G h (γ 0) k−γ(meshTime h k)‖，所以原文逐点 e\_k 与 t\_k=kh 条款确实有正式展开，最大值接口没有换用其他误差定义。原文的z\_k是单步递推轨迹，准确初始化z₀=γ(0)来自章内上下文；νh=τ、固定τ是使用参数的网格关系，不是独立误差函数必须额外证明的条件。最大量来自本条context\_notation明确登记的紧接定理，包含两个端点。[EXTRA] 实范数空间泛化可实例化为教材有限维向量空间，不新增光滑、ODE或留域条件；这里原文也未指定某一特定范数。无需新增定义：正式库已有nodeError。无[ERRATUM?]。证明状态单列：maximumError、oneStepIterate、oneStepMaxError、nodeError为定义，无直接sorry；未执行编译或传递公理审计。

### 7. 状态与证明位置

self-contained；`MD.Ch02.maximumError`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L73)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Thm2.1 · Theorem 2.1 · 印刷p.56 / PDFp.78

### 2. 原文陈述

> Let $`\mathcal D`$ be a bounded, open region in $`\mathbb R^m`$ such that $`f:\mathcal D\to\mathbb R^m`$ is continuously differentiable. Let $`\boldsymbol\zeta`$ be an interior point of $`\mathcal D`$ and suppose the initial value problem (2.1) has a unique solution that remains in $`\mathcal D`$ for $`t\in[0,\tau]`$. Then there exists a constant $`C(\tau)\gt 0`$ such that for sufficiently large $`\nu\in\mathbb N`$ the numerical solution $`\boldsymbol z_n`$ remains in $`\mathcal D`$ for $`n=0,1,\ldots,\nu`$, where $`h\nu=\tau`$, and, moreover, the maximum global error in Euler’s method satisfies

$$
\bar e:=\max_{0\le n\le\nu}e_n\le C(\tau)h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem theorem_2_1 {m : ℕ} (D : Set (Position m))
    (hDb : Bornology.IsBounded D) (hD : IsOpen D)
    (f : Position m → Position m) (hf : ContDiffOn ℝ 1 f D)
    (γ : ℝ → Position m) {τ : ℝ} (hτ : 0 ≤ τ)
    (hγD : MapsTo γ (Icc 0 τ) D)
    (hγ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt γ (f (γ t)) (Icc 0 τ) t)
    (_hunique : ∀ η : ℝ → Position m, η 0 = γ 0 → MapsTo η (Icc 0 τ) D →
      (∀ t ∈ Icc 0 τ, HasDerivWithinAt η (f (η t)) (Icc 0 τ) t) →
      ∀ t ∈ Icc 0 τ, η t = γ t) :
    ∃ C : ℝ, 0 < C ∧ ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      (∀ n ≤ ν, eulerIterate f (τ / (ν : ℝ)) (γ 0) n ∈ D) ∧
        eulerMaxError f (τ / (ν : ℝ)) γ ν ≤ C * (τ / (ν : ℝ)) := by
  exact MolecularDynamics.theorem_2_1_euler D hDb hD f hf γ hτ hγD hγ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.theorem_2_1` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 时间长度τ≥0显式化；f以环境全函数表示，只在开放D上要求C¹。 | [EXTRA] |

[EXTRA] 时间长度τ≥0显式化；f以环境全函数表示，只在开放D上要求C¹。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。Notation.lean:844 的 Position m = EuclideanSpace ℝ (Fin m)，为欧氏m维实空间。EulerConvergence.lean:897–902 展开 eulerStep f h x=x+h•f x、eulerIterate f h x₀ k=(eulerStep f h)^[k]x₀；918–921 展开 eulerMaxError=max_{0≤k≤ν} ‖eulerIterate f h (γ 0) k−γ((k:ℝ)*h)‖，range和sup′含义同前。签名保留 D 有界开放、f在D上C¹、γ在闭区间留于D且满足ODE。由0≤τ及MapsTo得到γ(0)∈D，由开放得到ζ=γ(0)是内点；无需独立ζ参数。唯一性量词遍历所有同初值、在本时间窗留域并满足相同ODE的η，结论是在整个[0,τ]与γ一致。HasDerivWithinAt描述区间内导数，正时间窗端点为单侧导数，与仅要求本时间窗的解一致；不会额外约束曲线在时间窗外的行为。结论为∃C>0，∃ν₀>0，∀ν≥ν₀，合取∀k≤ν数值点∈D与最大误差≤Cτ/ν，两个结论完整且C、阈值均在ν之前选择。[EXTRA] 时间长度τ≥0合理显式化，τ=0时Euler步为恒等、所有节点误差为0并留于D，属于成立的退化扩展；环境全函数f只在D要求C¹，域外值不影响已证明留域的迭代；ν₀>0排除零除。开放region的连通性不是误差估计所需条件，任意开放D的扩展仍涵盖原命题。wrapper保留\_hunique而证明体不使用它，只说明库有更强结果，不构成签名遗漏。无本条[ERRATUM?]。证明状态单列：实际wrapper为exact MolecularDynamics.theorem\_2\_1\_euler；依赖文件1191–1216完整提供该定理并分别处理τ=0、τ>0，整段EulerConvergence源码没有直接sorry/admit。此文本检查不等于重新编译或审计所有Mathlib传递公理；本次PASS仅为签名语义。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.theorem_2_1`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L79)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1.2-SecondDerivative · unnumbered_claim · 印刷p.59 / PDFp.81

### 2. 原文陈述

> and the second derivative is obtained by differentiating the differential equation itself:

$$
\ddot{\boldsymbol z}(t)=\frac{\mathrm d}{\mathrm dt}\dot{\boldsymbol z}(t)=\frac{\mathrm d}{\mathrm dt}f(\boldsymbol z(t))=f'(\boldsymbol z(t))\dot{\boldsymbol z}(t)=f'(\boldsymbol z(t))f(\boldsymbol z(t)),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem odeSecondDerivative :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n), ContDiff ℝ 1 f → ContDiff ℝ 2 γ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (deriv γ) ((fderiv ℝ f (γ t)) (f (γ t))) t := by
  intro n f γ hf hγ hode t
  have heq : deriv γ = fun s => f (γ s) := funext (fun s => (hode s).deriv)
  rw [heq]
  exact ((hf.differentiable (by norm_num)).differentiableAt.hasFDerivAt).comp_hasDerivAt t (hode t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.odeSecondDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 解γ取C²；原文连续求两次时间导数的正则性显式化。 | [EXTRA] |

[EXTRA] 解γ取C²；原文连续求两次时间导数的正则性显式化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Q n为Fin n→ℝ。对每个n、f、γ，在f全域C¹、γ全域C²及全部t上的真实ODE导数前提下，结论对全部t给出deriv γ的导数为Df(γ(t))[f(γ(t))]。等式链中的中间项由ODE及链式法则表达；没有把总化deriv在不可微点的值当作导数。C¹假设正确但extra\_assumptions记录不全。

### 7. 状态与证明位置

self-contained；`MD.Ch02.odeSecondDerivative`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L95)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1.2-Taylor2 · Example 2.1 (map) · 印刷p.59 / PDFp.81

### 2. 原文陈述

> so one may write the 2nd order Taylor series method as

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_n)+\frac{h^2}{2}f'(\boldsymbol z_n)f(\boldsymbol z_n).
$$


> This method generates the flow map approximation

$$
\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\boldsymbol z)+\frac{h^2}{2}f'(\boldsymbol z)f(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def taylorSecond {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  z + h • f z + (h^2 / 2) • (fderiv ℝ f z) (f z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.taylorSecond` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；PASS。Ch02\_deps.txt 第2816行展开 Q n = Fin n → ℝ，故 z 与 f z 是实际有限维实向量；加法和 • 分别是向量加法与实数标量乘法。Ch02.lean 第79—80行完整定义为 z + h • f z + (h²/2) • (fderiv ℝ f z) (f z)，因此对象、任意步长 h、系数、求导点、作用顺序以及三项之和均与原页 G\_h 一致；以 z\_n 为输入并将输出定义为 z_{n+1} 即给出同页递推公式。依赖合集第2827—2828行的 taylor2 具有完全相同定义体，后续阶定理确实使用同一个映射。fderiv 是实际 Fréchet 导数；原文的 Jacobian 解释限定于可微向量场，Lean def 的全函数化在不可微点也赋值，不构成原文对不可微情形的额外数学断言。作为映射公式定义，无须把可微性作为 def 的参数；需要使用 Jacobian 语义的性质应另有可微性资格，本批阶定理已有更强 C⁶ 假设。本条无 [EXTRA]、无 [ERRATUM?]，未发现疑误。定义有完整体且不含 sorry/admit，未声称重新编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.taylorSecond`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L105)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1.2-Taylor2Order · Example 2.1 (order) · 印刷p.59 / PDFp.81

### 2. 原文陈述

> which is referred to as the 2nd order Taylor series method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem taylor2Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ,
    compactTrajectory f γ τ → globalOrder (taylor2 f) γ τ 2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.taylor2Order` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | compactTrajectory要求f全域C⁶及实际解在固定紧时间窗连续；强于二阶所需，标[EXTRA]，仍需证明局部误差及稳定留域。 | [EXTRA] |

[EXTRA] compactTrajectory要求f全域C⁶及实际解在固定紧时间窗连续；强于二阶所需，标[EXTRA]，仍需证明局部误差及稳定留域。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；PASS。展开依赖合集第2941—2945行：compactTrajectory f γ τ 正好是 0<τ、ContDiff ℝ 6 f、solution f γ 0 τ、ContinuousOn γ (Icc 0 τ) 的合取；solution 是对每个 t∈[0,τ] 要求 HasDerivWithinAt γ (f (γ t)) [0,τ] t。故 γ 是实际 ODE 轨迹，闭窗端点也包括在内；并无全域轨迹 C⁶、全局 Lipschitz、预设误差界或数值留域前提。连续轨迹在有限维空间的紧时间窗有紧像，不需要额外假设名称所暗示的另一种紧性。第2827—2828行 taylor2 是 z+h f(z)+(h²/2)Df(z)f(z)，与 taylorSecond 定义体相同。第2824—2826行 globalOrder 展开为先存在 C>0，再存在自然数 ν₀>0，使所有 ν≥ν₀ 满足 oneStepMaxError G (τ/ν) γ ν≤C(τ/ν)^2；C 与阈值可以依赖已量化的 n、f、γ、τ，但不依赖随后量化的 ν。第1443—1444行 oneStepIterate 是 (G h)^[k] z₀；第1460—1463行 oneStepMaxError 是 k=0,…,ν 上 ‖(G h)^[k](../../γ 0)−γ(kh)‖ 的有限最大值，数值初值等于精确初值，覆盖全窗，且正阈值避免零网格。因此结论确实是固定有限时间窗上的全局 O(h²)，没有偷换为一步局部误差、误差极限或精确阶下界。Q n=Fin n→ℝ 的标准函数范数与有限维其他标准范数等价，允许改变 C 而不改变二阶。[EXTRA] 全域 C⁶ 远强于二阶所需但合理；τ>0 和真实解资格使有限窗阶断言有明确适用范围，ContinuousOn 与有限窗内实际解相容，未将待证稳定性作假设。无需预先假设数值迭代留域：在光滑向量场轨迹的紧邻域内建立局部误差和稳定性，再对充分细网格证明留在邻域，是该结论的证明义务。本条无 [ERRATUM?]，原文二阶称谓未发现疑误。Ch02.lean 第87行仍为 sorry；证明未完成与上述签名语义 PASS 分开，本次仅只读审计且不写证明、不编译。

### 7. 状态与证明位置

incomplete；`MD.Ch02.taylor2Order`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L110)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2-VerletOrder · unnumbered_claim · 印刷p.60 / PDFp.82

### 2. 原文陈述

> The Verlet method (also known as leapfrog or Störmer-Verlet) is a second order method that is popular for molecular simulation. It is specialized to problems that can be expressed in the form $`\dot{\boldsymbol q}=\boldsymbol v`$, $`\boldsymbol M\dot{\boldsymbol v}=\boldsymbol F(\boldsymbol q)`$, with even dimensional phase space $`\mathbb R^{2\mathrm{N}_c}`$, which includes constant energy molecular dynamics.

### 3. 原文证明

原书无独立完整证明。
本条所引 PDF 第82页（印刷第60页）仅陈述 Verlet 的二阶性质，未在该页附独立证明；本批不对后续节是否给出完整证明作结论。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletOrder :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (fun z : Z n ↦ (z.2, invMass m (F z.1))) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError (velocityVerlet m F) (τ / ν) γ ν ≤ C * (τ / ν)^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 固定正对角质量、力全域C⁴、τ>0及实际解在闭时间窗连续；原文未逐一给出的阶定理正则性显式列出。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 网站首选路线：直接保留原文(q,v)速度变量，使用已定义velocityVerlet与真实速度场(v,M⁻¹F(q))；正对角质量及C⁴为充分但非最小资格，闭窗连续性为冗余明确限制。未更改正式mechanicalField/verlet，不新增证明。 | [EXTRA] |

[EXTRA] 固定正对角质量、力全域C⁴、τ>0及实际解在闭时间窗连续；原文未逐一给出的阶定理正则性显式列出。；[EXTRA] 网站首选路线：直接保留原文(q,v)速度变量，使用已定义velocityVerlet与真实速度场(v,M⁻¹F(q))；正对角质量及C⁴为充分但非最小资格，闭窗连续性为冗余明确限制。未更改正式mechanicalField/verlet，不新增证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐项展开positiveMass、solution、velocityVerlet、oneStepMaxError：第二分量是速度v，场为(v,M⁻¹F(q))，不是动量p。solution在[0,τ]为HasDerivWithinAt；τ>0且轨道连续。F C⁴、正对角质量为充分资格。存在C>0、正整数ν₀，对所有ν≥ν₀用h=τ/ν控制0至ν全部网格点的最大实际迭代误差≤Ch²。这是二阶全局收敛的正确具体化，未偷换成仅局部误差。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L118)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Lagrangian · definition · 印刷p.60 / PDFp.82

### 2. 原文陈述

> Recall from Chap. 1 that the Lagrangian for the N-body system is defined by

$$
L(\boldsymbol q,\boldsymbol v)\stackrel{\rm def}{=}\frac{\boldsymbol v^TM\boldsymbol v}{2}-U(\boldsymbol q),
$$


> where $`M`$ is the mass matrix and the potential energy function $`U`$ is, for simplicity, taken to be smooth ($`C^2`$).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_mechanicalL {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (q v : Q n) : ℝ :=
  (∑ i, m i * v i ^ 2) / 2 - U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_mechanicalL` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02.lean:100 的 bp\_mechanicalL：(∑ i, m i*v i^2)/2−U q。固定参数 m:Fin n→ℝ 对应第1章固定对角 M，求和恰为 vᵀMv，减势能的符号和分母2完整；q、v 同属 Q n，U:Q n→ℝ，没有量词次序问题。此处是代数函数的总定义，在正质量及 U∈C² 的原文模型资格下限制使用即给出原式；总定义允许更多输入并不断言这些输入具有物理/光滑资格。没有 [EXTRA] 或 [ERRATUM?]。此项是定义，无 sorry 证明义务。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_mechanicalL`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L127)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Admissible · definition · 印刷p.60 / PDFp.82

### 2. 原文陈述

> We consider the collection of all twice continuously differentiable curves in the configuration space which start from a certain point $`\boldsymbol Q`$ and end at another given point $`\boldsymbol Q'`$. We may think of any such curve as being represented by a parameterization $`\boldsymbol q(t)`$, $`t\in[\alpha,\beta]`$ with $`\boldsymbol q(\alpha)=\boldsymbol Q`$ and $`\boldsymbol q(\beta)=\boldsymbol Q'`$, where the components of $`\boldsymbol q(t)`$ are $`C^\infty`$ functions. Denote by $`G=G(\boldsymbol Q,\boldsymbol Q',\alpha,\beta)`$ the class of smooth parameterized curves such that $`\boldsymbol q(\alpha)=\boldsymbol Q`$, $`\boldsymbol q(\beta)=\boldsymbol Q'`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def admissibleSmooth {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  ContDiff ℝ ∞ q ∧ q a = x ∧ q b = y



/-- 修正版，对应原文 MD-2.2.1-Admissible。改动：默认C∞区间版，补a<b；只对闭区间限制要求光滑，不强制任意全线代表光滑。C²与C∞的原文冲突保留导师选项。 -/
```

独立修正版：

```lean
def admissibleSmooth_corrected {n : ℕ} (a b : ℝ) (x y : Q n) (q : ℝ → Q n) : Prop :=
  a < b ∧ ContDiffOn ℝ ∞ q (Icc a b) ∧ q a = x ∧ q b = y
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.admissibleSmooth`；`MD.Ch02.admissibleSmooth_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 全实线C∞延拓强于只在[α,β]光滑的局部资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 默认C∞区间版，补a<b；只对闭区间限制要求光滑，不强制任意全线代表光滑。C²与C∞的原文冲突保留导师选项。 | [EXTRA] |

[EXTRA] 全实线C∞延拓强于只在[α,β]光滑的局部资格。；[ERRATUM?] 默认C∞区间版，补a<b；只对闭区间限制要求光滑，不强制任意全线代表光滑。C²与C∞的原文冲突保留导师选项。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；已展开 Ch02.lean:106：admissibleSmooth a b x y q 为 ContDiff ℝ ∞ q ∧ q a=x ∧ q b=y，两端点完整。正式 Q 已找到，缺失定义不再是障碍。仍需裁定原文 PDF82 同段的“all twice continuously differentiable”与后续“C∞ functions / smooth”的冲突：本定义选择后一资格，不能同时代表首句全部 C² 曲线。[EXTRA] 对全实线代表函数要求 C∞，并非区间计算所必要；若以区间限制识别曲线、选择光滑延拓为表示约定，可以合理使用，但对任意给定全局 q 与局部光滑资格并不等价，现签名也未编码曲线商或存在延拓。a<b 是时间窗语境，谓词自身未保证它。NEEDS\_HUMAN 的唯一原因是原文曲线类的正则性及域含义需数学/编辑裁定，非依赖缺失。此项是定义，无 sorry。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。

### 7. 状态与证明位置

self-contained；`MD.Ch02.admissibleSmooth`：定义；`MD.Ch02.admissibleSmooth_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L134)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Action · definition · 印刷p.60 / PDFp.82

### 2. 原文陈述

> Then the classical action (or, simply, action) of the Lagrangian $`L`$ is defined for any $`\Gamma\in G`$ by

$$
\mathcal A_L(\Gamma)\stackrel{\rm def}{=}\int_\alpha^\beta L(\boldsymbol q(t),\dot{\boldsymbol q}(t))\,dt.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_action {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : ℝ :=
  ∫ t in a..b, L (q t) (deriv q t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_action` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02.lean:110 的 bp\_action 和依赖 action，二者均为 ∫ t in a..b, L (q t) (deriv q t)。区间积分上下限为 a,b；第一个 L 参数为位置，第二个为实际时间导数，完整对应 PDF82 的作用量公式。定义在所有 L,q 上总化；原文 Γ∈G 是使用资格，不是函数体自动保证的性质，在原文光滑 L 与合格曲线上积分具经典含义。无 [EXTRA] 或 [ERRATUM?]。定义无 sorry。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_action`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L144)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Variation · definition · 印刷p.61 / PDFp.83

### 2. 原文陈述

> Given $`\Gamma`$ in $`G`$ with parameterization $`\boldsymbol q(t)`$, $`t\in[\alpha,\beta]`$, we consider the curve $`\Gamma^\epsilon`$ with parameterization $`\boldsymbol q^\epsilon`$ defined by

$$
\boldsymbol q^\epsilon(t)=\boldsymbol q(t)+\epsilon\boldsymbol\eta(t),\qquad t\in[\alpha,\beta],\tag{2.3}
$$


> where $`\boldsymbol\eta(t)`$ satisfies $`\boldsymbol\eta(\alpha)=\boldsymbol\eta(\beta)=\boldsymbol0`$. Thus $`\boldsymbol\eta`$ is a $`C^\infty`$ parameterized curve linking $`\boldsymbol0`$ to $`\boldsymbol0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_variation {n : ℕ} (q η : ℝ → Q n) (ε : ℝ) (t : ℝ) : Q n := q t + ε • η t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_variation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02.lean:114 的 bp\_variation 及正式 variation，均为 q t+ε • η t，实参数 ε 在给定时间 t 对 η 作标量乘法。完全对应 PDF83 (2.3)。按条目 context\_notation，函数构造本身不声称 q、η 自动合格；原文使用时 q 合格，η∈C∞ 且 η a=η b=0，因此变分曲线保持两端点并在区间光滑。该构造无需把这些资格作为计算参数。无 [EXTRA] 或 [ERRATUM?]。定义无 sorry。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_variation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L148)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-FirstVariation · unnumbered_claim · 印刷p.61 / PDFp.83

### 2. 原文陈述

> Using a Taylor series expansion of the Lagrangian\textsuperscript{3}, we have

$$
\mathcal A_L(\Gamma^\epsilon)-\mathcal A_L(\Gamma)=\int_\alpha^\beta[L(\boldsymbol q(t)+\epsilon\boldsymbol\eta(t),\dot{\boldsymbol q}(t)+\epsilon\dot{\boldsymbol\eta}(t))-L(\boldsymbol q(t),\dot{\boldsymbol q}(t))]\,dt,
$$



$$
=\int_\alpha^\beta\left[\epsilon\left(\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\boldsymbol\eta(t)+\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\dot{\boldsymbol\eta}(t)\right)+O(\epsilon^2)\right]\,dt.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem firstVariation :
  ∀ n (L : Q n → Q n → ℝ) (q η : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q → ContDiff ℝ 2 η →
    (∀ ε : ℝ, action L a b (variation q η ε)-action L a b q =
      ∫ t in a..b, L (q t+ε • η t) (deriv q t+ε • deriv η t)-L (q t) (deriv q t)) ∧
    HasDerivAt (fun ε => action L a b (variation q η ε))
      (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) 0 ∧
    Asymptotics.IsBigO (𝓝 0)
      (fun ε : ℝ => action L a b (variation q η ε)-action L a b q-
        ε*(∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)))
      (fun ε : ℝ => ε^2)
    ∧ (∃ C > 0, ∃ δ > 0, ∀ ε : ℝ, |ε| < δ → ∀ t ∈ Icc a b,
      |L (q t + ε • η t) (deriv q t + ε • deriv η t) - L (q t) (deriv q t) -
        ε * ((fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) (η t) +
          (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t))| ≤ C * |ε|^2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.firstVariation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | α<β；L、q、η C²以保证实际导数和紧时间窗余项资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原三个结论，并补同一个真实点态Taylor余项的紧时间窗统一C\|ε\|²控制；没有把余项界当作前提，未新增证明。 | [EXTRA] |

[EXTRA] α<β；L、q、η C²以保证实际导数和紧时间窗余项资格。；[EXTRA] 保留原三个结论，并补同一个真实点态Taylor余项的紧时间窗统一C|ε|²控制；没有把余项界当作前提，未新增证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意维数、C²的uncurry L及C²曲线q、η和a<b，同时保留：任意ε的作用量差积分恒等式；ε=0处真实一阶导数；积分后二阶BigO；同一实际点态Taylor余项在t∈[a,b]上的统一C|ε|²界。action使用真实deriv q，variation=q+εη。端点为零不是这一Taylor恒等式的必要前提，放宽η不破坏结论。没有预先假设所需余项界。

### 7. 状态与证明位置

incomplete；`MD.Ch02.firstVariation`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L153)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-TaylorPrinted · Footnote 3 · 印刷p.61 / PDFp.83

### 2. 原文陈述

> In the multidimensional setting, Taylor’s theorem states that given a $`C^{k+1}`$ function $`f:\mathbb R^m\to\mathbb R`$ and a point $`\boldsymbol z_0`$, we have

$$
f(\boldsymbol z)-f(\boldsymbol z_0)=\nabla f(\boldsymbol z_0)\cdot(\boldsymbol z-\boldsymbol z_0)+f^{(2)}\langle\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0\rangle+f^{(3)}\langle\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0\rangle+\ldots f^{(k)}\langle\boldsymbol z-\boldsymbol z_0,\boldsymbol z-\boldsymbol z_0,\ldots,\boldsymbol z-\boldsymbol z_0\rangle+O(\|\boldsymbol z-\boldsymbol z_0\|^{k+1})
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem taylorPrinted : ∀ n (k : ℕ) (f : Q n → ℝ) z₀,
    1 ≤ k → ContDiff ℝ (k+1) f →
    Asymptotics.IsBigO (𝓝 0)
      (fun u => f (z₀+u)-f z₀-∑ j ∈ Finset.range k,
        iteratedFDeriv ℝ (j+1) f z₀ (fun _ => u))
      (fun u : Q n => ‖u‖^(k+1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.taylorPrinted` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02.lean:135：n,k,f,z₀ 在前，1≤k 和 f∈C^(k+1) 为前提，range k 的 j+1 恰枚举1,…,k，iteratedFDeriv 是未作阶乘归一化的迭代 Fréchet 导数，作用于各槽都为 u 的向量组。第一阶为梯度的线性作用，第二阶为原始 Hessian 的双线性作用；u=z−z₀，𝓝0 和 ‖u‖^(k+1) 给出原式局部余项。在 Fin n→ℝ 的默认范数与欧氏范数间有限维范数等价，Big-O 阶不变。签名确实没有1/(j+1)!，忠实保留 PDF83 脚注的字面错误，因此忠实性 PASS 不表示数学定理成立。[ERRATUM?] 成立；1≤k 合理明确已有梯度项的阶数范围。证明体为 sorry，且该一般命题有反例，不能取得无额外公理的正确证明。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。

### 7. 状态与证明位置

incomplete；`MD.Ch02.taylorPrinted`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L174)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-StationaryAction · definition · 印刷p.61–62 / PDFp.83–84

### 2. 原文陈述

> Hamilton’s principle states that the natural motion of the system described by the Lagrangian $`L`$ is a stationary point of the classical action which implies that the $`O(\epsilon)`$ term above should vanish for any smooth variation $`\boldsymbol\eta(t)`$ with $`\boldsymbol\eta(\alpha)=\boldsymbol\eta(\beta)=\boldsymbol0`$, i.e.,

$$
I=\int_\alpha^\beta\left[\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\boldsymbol\eta(t)+\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\dot{\boldsymbol\eta}(t)\right]dt=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def stationarySmoothAction {n : ℕ} (L : Q n → Q n → ℝ) (a b : ℝ) (q : ℝ → Q n) : Prop :=
  ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
    HasDerivAt (fun ε => action L a b (variation q η ε)) 0 0

theorem stationarySmoothAction_iff_first_variation {n : ℕ}
    (L : Q n → Q n → ℝ) (q : ℝ → Q n) (a b : ℝ)
    (_hab : a < b) (_hL : ContDiff ℝ 2 (Function.uncurry L)) (_hq : ContDiff ℝ 2 q) :
    stationarySmoothAction L a b q ↔
      ∀ η : ℝ → Q n, ContDiff ℝ ∞ η → η a = 0 → η b = 0 →
      (∫ t in a..b, (fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) (η t) +
        (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) = 0 := by
  sorry

theorem stationarySmoothAction_hamilton {n : ℕ}
    (L : Q n → Q n → ℝ) (q : ℝ → Q n) (a b : ℝ)
    (_hab : a < b) (_hL : ContDiff ℝ 2 (Function.uncurry L)) (_hq : ContDiff ℝ 2 q)
    (_hnatural : ∀ t ∈ Ioo a b,
      HasDerivAt (fun s ↦ fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x ↦ L x (deriv q t)) (q t)) t) :
    stationarySmoothAction L a b q := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.stationarySmoothAction`；`MD.Ch02.stationarySmoothAction_iff_first_variation`；`MD.Ch02.stationarySmoothAction_hamilton` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 驻值以真实一阶变分导数为零定义；展开式相等由FirstVariation条目承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留驻值定义，同一source\_id补完整积分I=0等价式及自然Euler–Lagrange运动推出驻值的Hamilton原理；C²及a<b是充分资格。新结论只登记sorry陈述，证明留到网站PASS后。 | [EXTRA] |

[EXTRA] 驻值以真实一阶变分导数为零定义；展开式相等由FirstVariation条目承担。；[EXTRA] 保留驻值定义，同一source\_id补完整积分I=0等价式及自然Euler–Lagrange运动推出驻值的Hamilton原理；C²及a<b是充分资格。新结论只登记sorry陈述，证明留到网站PASS后。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；三个声明均检查：stationarySmoothAction对所有C∞零端点方向要求作用量对ε在0处的导数为0；iff声明在a<b、L与q C²下给出完整积分为零的等价式；hamilton声明把开区间内的Euler–Lagrange经典导数关系作为自然运动资格并推出驻值。所有位置、速度偏导均为相应fderiv，域和端点匹配；没有将驻值误写为极小值。

### 7. 状态与证明位置

incomplete；`MD.Ch02.stationarySmoothAction`：定义；`MD.Ch02.stationarySmoothAction_iff_first_variation`：未证（缺大型理论）；`MD.Ch02.stationarySmoothAction_hamilton`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L185)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Parts · unnumbered_claim · 印刷p.62 / PDFp.84

### 2. 原文陈述

> We use integration by parts to remove the differentiation of $`\boldsymbol\eta`$, thus (in light of the boundary conditions on $`\boldsymbol\eta(t)`$),

$$
I=\int_\alpha^\beta\left[\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t))-\frac{\mathrm d}{\mathrm dt}\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))\right]\boldsymbol\eta(t)\,dt=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem firstVariationParts : ∀ n (L : Q n → Q n → ℝ)
    (q η : ℝ → Q n) a b, a < b → ContDiff ℝ 2 (Function.uncurry L) →
    ContDiff ℝ 2 q → ContDiff ℝ ∞ η → η a=0 → η b=0 →
    stationarySmoothAction L a b q →
    (∫ t in a..b, (fderiv ℝ (fun x => L x (deriv q t)) (q t)) (η t)+
      (fderiv ℝ (L (q t)) (deriv q t)) (deriv η t)) =
    (∫ t in a..b, ((fderiv ℝ (fun x => L x (deriv q t)) (q t))-
      deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t)) ∧
    (∫ t in a..b, ((fderiv ℝ (fun x => L x (deriv q t)) (q t))-
      deriv (fun s => fderiv ℝ (L (q s)) (deriv q s)) t) (η t))=0 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.firstVariationParts` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | α<β，实际L和q C²；η按原文C∞、零端点；真实作用量驻值。 | [EXTRA] |

[EXTRA] α<β，实际L和q C²；η按原文C∞、零端点；真实作用量驻值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02.lean:151 的 stationarySmoothAction 和正式 action、variation。先量化 n,L,q,η,a,b，再要求 a<b、联合 L∈C²、q∈C²、η∈C∞、两个零端点及对全部合格变分的真实驻值。两个合取结论完整：原始两项第一变分积分等于分部积分后的积分，且后者为0。fderiv ℝ (L(q s)) (deriv q s) 是随 s 变化的速度偏导连续线性泛函；deriv 对整个泛函曲线求时间导数，再作用于 η t，与 D\_q L−d/dt D\_v L 的符号、对象和作用次序相符。无边界项遗漏，因 η a=η b=0。[EXTRA] C² 与端点资格足以保证经典分部积分，驻值是最终零值的上文假设；仅积分相等不需要驻值，但合并零值结论后此前提合理。全域光滑及 a<b 是明确加强，局部资格足够；不把待证积分为0直接作前提。无 [ERRATUM?]。证明体为 sorry，本次 PASS 仅审计签名语义，未验证证明。 依赖展开证据：Ch02\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean（段标 SHA256 3778ef36df51f5218bf14a00fa3a37b0f8ac7dcfa01a4a9f7450d82db5c490b7），第2816行 Q n := Fin n → ℝ；第2831–2832行 action L a b q := ∫ t in a..b, L (q t) (deriv q t)；第2833行 variation q η ε t := q t + ε • η t。Q 是有限维实坐标空间，向量加法和实标量乘法逐坐标作用；n 为坐标数而非强制粒子数。action/variation 与本地 bp\_action/bp\_variation 的函数体逐字同式，展开后对应相同对象。这里的 stationarySmoothAction 是 Ch02.lean 的本地 C∞ 变分谓词，不能混用依赖第2834行只要求 C² 变分的 stationaryAction。实际读取的蓝图附件路径为 /workspace/Ch02.lean，输出 input\_sha256 按请求使用逻辑名称 Blueprint/Ch02.lean，并未声称磁盘存在该子目录。

### 7. 状态与证明位置

incomplete；`MD.Ch02.firstVariationParts`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L209)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-EulerLagrange · unnumbered_claim · 印刷p.62 / PDFp.84

### 2. 原文陈述

> Since the variation $`\boldsymbol\eta`$ is meant to be arbitrary, it requires

$$
\frac{\mathrm d}{\mathrm dt}\frac{\partial L}{\partial\dot{\boldsymbol q}}(\boldsymbol q(t),\dot{\boldsymbol q}(t))=\frac{\partial L}{\partial\boldsymbol q}(\boldsymbol q(t),\dot{\boldsymbol q}(t)),
$$


> which is precisely the Lagrangian formulation of the equations of motion.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonPrinciple :
  ∀ n (L : Q n → Q n → ℝ) (q : ℝ → Q n) a b,
    a < b → ContDiff ℝ 2 (Function.uncurry L) → ContDiff ℝ 2 q →
    (stationarySmoothAction L a b q ↔ ∀ t ∈ Ioo a b,
      HasDerivAt (fun s => fderiv ℝ (L (q s)) (deriv q s))
        (fderiv ℝ (fun x => L x (deriv q t)) (q t)) t) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonPrinciple` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | α<β，L和q C²；变分按原文C∞且零端点。 | [EXTRA] |

[EXTRA] α<β，L和q C²；变分按原文C∞且零端点。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、一般C²拉格朗日函数及C²曲线，在a<b时，所有C∞零端点变分驻值等价于每个t∈(a,b)上的Euler–Lagrange经典导数关系。速度偏导沿轨道的导数取值于连续线性泛函空间，右侧是位置偏导，类型和次序正确。开区间结论对应端点固定的变分，不擅加端点微分结论；泛化L不损害陈述。

### 7. 状态与证明位置

incomplete；`MD.Ch02.hamiltonPrinciple`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L223)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-VariationalDerivativePrinted · definition · 印刷p.62 / PDFp.84

### 2. 原文陈述

> Define the variational derivative of a functional $`\mathcal F`$, $`\delta\mathcal F/\delta\boldsymbol q`$ so that

$$
\mathcal F(\boldsymbol q+\epsilon\boldsymbol\eta)=\epsilon\frac{\delta\mathcal F}{\delta\boldsymbol q}\boldsymbol\eta+O(\epsilon^2),
$$


> for all suitable (say, $`C^\infty`$) functions $`\boldsymbol\eta`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedVariationalDerivative {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - ε * A η) (fun ε : ℝ => ε^2)



/-- 修正版，对应原文 MD-2.2.1-VariationalDerivativePrinted。改动：补被漏去的F(q)常项，保留逐方向O(ε²)及连续线性泛函，不将其混称一般Fréchet可微的必要条件。 -/
```

独立修正版：

```lean
def printedVariationalDerivative_corrected {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → ℝ) (q : E) (A : E →L[ℝ] ℝ) : Prop :=
  ∀ η : E, Asymptotics.IsBigO (𝓝 0)
    (fun ε : ℝ => F (q + ε • η) - F q - ε * A η) (fun ε : ℝ => ε^2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.printedVariationalDerivative`；`MD.Ch02.printedVariationalDerivative_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 补被漏去的F(q)常项，保留逐方向O(ε²)及连续线性泛函，不将其混称一般Fréchet可微的必要条件。 | [EXTRA] |

[EXTRA] [ERRATUM?] 补被漏去的F(q)常项，保留逐方向O(ε²)及连续线性泛函，不将其混称一般Fréchet可微的必要条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；printedVariationalDerivative逐η要求F(q+εη)-εAη=O(ε²)，确实没有减F(q)，忠实保留印刷公式；A为连续实线性泛函。抽象E表示允许的方向空间，结论不是通常HasFDerivAt定义。字面接口本身忠实，但原书所谓一般变分导数定义存在数学疑误，按任务规则整体转人工。

### 7. 状态与证明位置

self-contained；`MD.Ch02.printedVariationalDerivative`：定义；`MD.Ch02.printedVariationalDerivative_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L234)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-StationaryNotMin · Footnote 4 · 印刷p.62 / PDFp.84

### 2. 原文陈述

> Any curve which satisfies this equation will represent a “stationary point” (actually, “stationary curve” would be more accurate) of the classical action. Such curves could include smooth local action minimizers, local action maximizers, or “saddle points” of the actional functional in a generalized sense. Deciding whether a given stationary curve is an actual minimizer of the action would require analysis of the second variation (the coefficient of $`\epsilon^2`$ in the expansion above), which introduces additional complexity.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem stationaryNotMinimum :
  ∃ (L : Q 1 → Q 1 → ℝ) (q : ℝ → Q 1),
    ContDiff ℝ 2 (Function.uncurry L) ∧ ContDiff ℝ 2 q ∧ stationaryAction L 0 1 q ∧
    ∀ δ > 0, ∃ η : ℝ → Q 1, ContDiff ℝ 2 η ∧ η 0 = 0 ∧ η 1 = 0 ∧
      (∀ t ∈ Icc (0 : ℝ) 1, ‖η t‖ < δ) ∧ action L 0 1 (fun t => q t + η t) < action L 0 1 q := by
  sorry



/-- 修正版，对应原文 MD-2.2.1-StationaryNotMin。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem stationaryNotMinimum_corrected :
  ∃ (L : Q 1 → Q 1 → ℝ) (q : ℝ → Q 1),
    ContDiff ℝ 2 (Function.uncurry L) ∧ ContDiff ℝ 2 q ∧ stationaryAction L 0 1 q ∧
    ∀ δ > 0, ∃ η : ℝ → Q 1, ContDiff ℝ 2 η ∧ η 0 = 0 ∧ η 1 = 0 ∧
      (∀ t ∈ Icc (0 : ℝ) 1, ‖η t‖ < δ) ∧ action L 0 1 (fun t => q t + η t) < action L 0 1 q := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.stationaryNotMinimum`；`MD.Ch02.stationaryNotMinimum_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 用存在驻值但非局部极小的实际L与曲线反例表达could，不声称所有驻值不是极小。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 用存在驻值但非局部极小的实际L与曲线反例表达could，不声称所有驻值不是极小。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；版本绑定：本次实际读取 BATCH06.md、根目录 Ch02.lean（所称 Blueprint/Ch02.lean 的提供副本；工作区无该 Blueprint 路径）和 Ch02\_deps.txt，哈希见 input\_sha256；不声称不存在的路径已读取或验证了完整工程。依赖合集声明 HEAD=acc4fc5f11c882dd78acc6151bbde1607afdc528；本审计依据实际附件字节，不以分段声明哈希替代整体哈希。 已展开 Ch02\_deps.txt:2816、2831–2836：Q 1=Fin 1→ℝ，action 是真实 L(q,q̇) 的时间区间积分，variation 是 q+εη，stationaryAction 对所有 C²、零端点 η 要求 ε↦action L 0 1 (q+εη) 的导数在0为0。它与本地量化 C∞ 的 stationarySmoothAction 不是定义相同，但 C² 驻值蕴含 C∞ 驻值，且在本 C² 的 L,q 资格下通过 Euler–Lagrange 残差可获得一致的经典驻值解释，不能仅凭名字断定相等。Ch02.lean:182–187 的量词为存在固定 L,q 后，对每个 δ>0 存在可依赖 δ 的 C² 零端点 η，且闭区间位置范数处处 <δ 并使真实 action 严格下降。Q 1 的函数范数在此对应唯一坐标绝对值，故明确表达位置一致范数意义的非局部极小。[EXTRA] 以一维、固定时间窗存在例说明驻值不保证极小合理，不是所有驻值均非极小；但这是所引完整三句中的一个子命题，不能取代完整 scope。缺失条款：任意满足所指方程的曲线为驻值的普遍结论；光滑局部极小、局部极大、广义鞍点的可能类型；第二变分在判断极小中的作用。签名完全未引入第二变分。通用 L 的存在例还未限定原机械 L 的正质量形式；C² 曲线/扰动强度不同于原页后文 C∞；原文未指定局部极值拓扑，不能把位置一致范数解释扩张为所有光滑拓扑的非极小。材料缺失已解除，FAIL 来自明确的 scope 遗漏而非 sorry 或缺库。所涉原印刷泛函导数的 ERRATUM? 仍成立，但本条正确采用真实一阶驻值，不能把漏项字面定义与该驻值定义无条件混同。:187 的 sorry 另表示证明未完成；未做编译检查。

### 7. 状态与证明位置

incomplete；`MD.Ch02.stationaryNotMinimum`：未证（原书疑误不证）；`MD.Ch02.stationaryNotMinimum_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L250)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscretePath · definition · 印刷p.63 / PDFp.85

### 2. 原文陈述

> We work on the time interval $`[0,\tau]`$. Consider the $`\nu+1`$ points $`\boldsymbol q_0`$ to $`\boldsymbol q_\nu`$ in configuration space

$$
\hat\Gamma=(\boldsymbol q_0,\boldsymbol q_1,\ldots,\boldsymbol q_\nu).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def finiteDiscretePath (n ν : ℕ) := Fin (ν+1) → Q n
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.finiteDiscretePath` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt:2816 的 Q n = Fin n → ℝ；Ch02.lean:187 的 Fin (ν+1) → Q n 正好是 ν+1 个 n 维实配置点，索引为0至ν。ν>0、h>0、νh=τ是网格使用语境，不是该元组对象定义的额外结论；允许ν=0的总接口扩展不改变正整数网格上的含义。本条无[EXTRA]/[ERRATUM?]，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.finiteDiscretePath`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L272)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteVelocity · definition · 印刷p.63 / PDFp.85

### 2. 原文陈述

> we are led to consider the approximation at time level $`n`$

$$
\boldsymbol v_n\stackrel{\rm def}{=}\frac{\boldsymbol q_{n+1}-\boldsymbol q_n}{h},
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_discreteVelocity {n : ℕ} (q : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  h⁻¹ • (q (k+1) - q k)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_discreteVelocity` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Q n = Fin n → ℝ（deps:2816），标量乘法与减法逐坐标作用，故 bp\_discreteVelocity q h k 的第i坐标是(q(k+1)i-q(k)i)/h；与PDF85定义逐项一致。q:ℕ→Q n是有限网格的总函数延拓，仅需0≤k<ν、h>0时解释原文；没有断言h=0时的结果是物理速度。未增加假设或遗漏该定义的结论；无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_discreteVelocity`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L275)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteAction · definition · 印刷p.63 / PDFp.85

### 2. 原文陈述

> and thus, by Riemann summation

$$
\mathcal A_L\approx\hat{\mathcal A}\stackrel{\rm def}{=}\sum_{n=0}^{\nu-1} L\left(\boldsymbol q_n,\frac{\boldsymbol q_{n+1}-\boldsymbol q_n}{h}\right)h.
$$


> In the case of a mechanical system with Lagrangian $`L(\boldsymbol q,\boldsymbol v)=\dot{\boldsymbol v}^TM\boldsymbol v/2+U(\boldsymbol q)`$, we then have

$$
\hat{\mathcal A}=\sum_{n=0}^{\nu-1}\left[\frac{(\boldsymbol q_{n+1}-\boldsymbol q_n)^TM(\boldsymbol q_{n+1}-\boldsymbol q_n)}{2h^2}-U(\boldsymbol q_n)\right]h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_discreteAction {n : ℕ} (L : Q n → Q n → ℝ) (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h * L (q k) (discreteVelocity q h k)



/-- 修正版，对应原文 MD-2.2.2-DiscreteAction。改动：按原展示式采用动能−U的机械离散作用量，并限制h>0；正文+U原印保留。Riemann收敛只作背景，未给极限定理。 -/
```

独立修正版：

```lean
def bp_discreteAction_corrected {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (_hh : 0 < h) (ν : ℕ) : ℝ :=
  ∑ k ∈ Finset.range ν, h*((∑ i, m i*((q (k+1) i-q k i)/h)^2)/2-U (q k))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_discreteAction`；`MD.Ch02.bp_discreteAction_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 按原展示式采用动能−U的机械离散作用量，并限制h>0；正文+U原印保留。Riemann收敛只作背景，未给极限定理。 | [EXTRA] |

[EXTRA] [ERRATUM?] 按原展示式采用动能−U的机械离散作用量，并限制h>0；正文+U原印保留。Riemann收敛只作背景，未给极限定理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；展开 deps:2816、2844–2847：Q为实坐标空间，discreteVelocity的第i坐标为相邻差除h，Finset.range ν为0至ν−1，h*L与原文L*h相等，因此一般L的求和定义正确。但本条statement\_scope包含机械作用量展示式，而bp\_discreteAction只有一般L求和，未陈述机械式。deps:2842–2843 的 mechanicalL = (∑i m\_i v\_i²)/2−U(q) 确实支持展示式的−U模型，却没有作为本条的等式结论。原文Riemann近似亦仅被定义右端和式，未表达近似/极限；原文未给误差界，不能擅加具体阶数。保留的[ERRATUM?]成立于已沿用A证据：正文带点v及+U与展示式和前节−U不一致；选择一般L不能补全本条机械子句。该定义无sorry，FAIL来自结论覆盖不足。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_discreteAction`：定义；`MD.Ch02.bp_discreteAction_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L281)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteStationaryPrinted · definition · 印刷p.63–64 / PDFp.85–86

### 2. 原文陈述

> Critical points of this function satisfy

$$
\nabla\hat{\mathcal A}=0,
$$


> where the gradient must be taken with respect to all configurational points on the path (and all coordinates). This condition leads to the equations

$$
\frac{\partial\hat{\mathcal A}}{\partial\boldsymbol q_n}=0,\qquad n=1,\ldots,\nu,
$$


> since we think of the starting point $`\boldsymbol q_0`$ as fixed.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def printedDiscreteStationary {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k ≤ ν →
    HasFDerivAt (fun x ↦ discreteAction L (replaceNode q k x) h ν) (0 : Q n →L[ℝ] ℝ) (q k)



/-- 修正版，对应原文 MD-2.2.2-DiscreteStationaryPrinted。改动：双端点固定的驻值只变动0<k<ν内部节点，保留原印≤ν供比较。 -/
```

独立修正版：

```lean
def printedDiscreteStationary_corrected {n : ℕ} (L : Q n → Q n → ℝ)
    (q : ℕ → Q n) (h : ℝ) (ν : ℕ) : Prop :=
  ∀ k, 0 < k → k < ν →
    HasFDerivAt (fun x ↦ discreteAction L (replaceNode q k x) h ν) (0 : Q n →L[ℝ] ℝ) (q k)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.printedDiscreteStationary`；`MD.Ch02.printedDiscreteStationary_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原印0<k≤ν范围和端点疑误；改用HasFDerivAt表达经典零导数，防止不可微处fderiv总化为零；内部节点版本已有独立DiscreteVerlet条目，不裁定端点勘误。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 双端点固定的驻值只变动0<k<ν内部节点，保留原印≤ν供比较。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原印0<k≤ν范围和端点疑误；改用HasFDerivAt表达经典零导数，防止不可微处fderiv总化为零；内部节点版本已有独立DiscreteVerlet条目，不裁定端点勘误。；[ERRATUM?] 双端点固定的驻值只变动0<k<ν内部节点，保留原印≤ν供比较。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；printedDiscreteStationary对所有0<k≤ν要求替换第k个节点后的真实HasFDerivAt为零；replaceNode为Function.update，discreteAction为k=0至ν-1的hL(q\_k,(q_{k+1}-q\_k)/h)和。q₀未被变动，q\_ν仍被变动，完全保留印刷范围。经典导数资格避免不可微处fderiv=0的伪驻值。[EXTRA]正确，但书中右端点是否固定的矛盾须人工裁定。

### 7. 状态与证明位置

self-contained；`MD.Ch02.printedDiscreteStationary`：定义；`MD.Ch02.printedDiscreteStationary_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L295)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteDerivative · unnumbered_claim · 印刷p.64 / PDFp.86

### 2. 原文陈述

> To calculate the derivative of $`\hat{\mathcal A}`$ with respect to $`\boldsymbol q_n`$, $`n=1,2,\ldots,\nu-1`$, note that only a few terms of the discrete action involve this configurational point, thus

$$
\frac{\partial\hat{\mathcal A}}{\partial\boldsymbol q_n}=\frac{\partial}{\partial\boldsymbol q_n}\left[\frac{1}{2h}\left((\boldsymbol q_n-\boldsymbol q_{n-1})^TM(\boldsymbol q_n-\boldsymbol q_{n-1})+(\boldsymbol q_{n+1}-\boldsymbol q_n)^TM(\boldsymbol q_{n+1}-\boldsymbol q_n)\right)-U(\boldsymbol q_n)h\right]=\frac1h[M(\boldsymbol q_n-\boldsymbol q_{n-1})-M(\boldsymbol q_{n+1}-\boldsymbol q_n)]-\nabla U(\boldsymbol q_n)h,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem discreteActionDerivative :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν k,
    positiveMass m → Differentiable ℝ U → h ≠ 0 → 0 < k → k < ν →
    ∀ v : Q n,
      (fderiv ℝ (fun x => discreteAction (mechanicalL m U) (replaceNode q k x) h ν) (q k)) v =
        ∑ i, (m i * (2*q k i-q (k-1) i-q (k+1) i)/h-h*grad U (q k) i) * v i := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.discreteActionDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 固定正对角质量、实际U可微、h≠0；仅内部节点0<k<ν；沿p.60及p.63展示的-U作用量。 | [EXTRA] |

[EXTRA] 固定正对角质量、实际U可微、h≠0；仅内部节点0<k<ν；沿p.60及p.63展示的-U作用量。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对每个n、正对角质量、全域可微U、任意节点序列、h≠0及0<k<ν，对任意方向v计算真实离散作用量的fderiv作用：Σ\_i[m\_i(2q\_k−q_{k−1}−q_{k+1})/h−h∂_iU(q\_k)]v\_i。两相邻动能项和当前势能项全部保留；k>0防止自然数减法截断，k<ν排除末端缺项。全域可微U保证此处fderiv确为导数。

### 7. 状态与证明位置

incomplete；`MD.Ch02.discreteActionDerivative`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L310)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteVerlet · unnumbered_claim · 印刷p.64 / PDFp.86

### 2. 原文陈述

> which yields the equations

$$
M(\boldsymbol q_{n+1}-2\boldsymbol q_n+\boldsymbol q_{n-1})=-h^2\nabla U(\boldsymbol q_n),\qquad n=1,2,\ldots,\nu-1.\tag{2.4}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem discreteStationaryVerlet :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) (q : ℕ → Q n) h ν,
    positiveMass m → Differentiable ℝ U → h ≠ 0 →
    (discreteStationary (mechanicalL m U) q h ν ↔
      ∀ k, 0 < k → k < ν → stormerRelation m (fun x => -grad U x) h (q (k-1)) (q k) (q (k+1))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.discreteStationaryVerlet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正对角质量、U可微、h≠0。 | [EXTRA] |

[EXTRA] 正对角质量、U可微、h≠0。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 deps:2842–2854、2932、2948：discreteStationary逐节点要求0<k<ν的节点作用量fderiv为零；mechanicalL为动能−U；grad为坐标导数；stormerRelation逐坐标为q_{k+1}−2q\_k+q_{k−1}=h²(−∂_iU(q\_k))/m\_i。positiveMass逐坐标m\_i>0使逆质量可逆，故右侧恰等价于原文M(q_{k+1}−2q\_k+q_{k−1})=−h²∇U(q\_k)。U可微和h≠0使节点作用量实际可微，排除fderiv默认零的伪驻值。量词先固定n,m,U,q,h,ν，再要求质量/可微/非零步长，之后等价对所有内部节点成立；无额外终点方程。双向等价强于文字中的推出，但反向由同一可微梯度式成立；[EXTRA]正质量、可微、非零步长必要或合理。签名PASS；定理正文含sorry，证明未验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.discreteStationaryVerlet`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L320)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-Stormer · definition · 印刷p.64 / PDFp.86

### 2. 原文陈述

> The method (2.4) is commonly referred to as Störmer’s rule.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_stormerRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (a b c : Q n) : Prop :=
  mass m (c - (2 : ℝ) • b + a) = h^2 • F b
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_stormerRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 直接使用原文质量乘法形式M(qₙ₊₁−2qₙ+qₙ₋₁)=h²F(qₙ)，避免零质量下逆质量总化造成对象不等价；仅更改Blueprint本条。 | [EXTRA] |

[EXTRA] [EXTRA] 直接使用原文质量乘法形式M(qₙ₊₁−2qₙ+qₙ₋₁)=h²F(qₙ)，避免零质量下逆质量总化造成对象不等价；仅更改Blueprint本条。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；检查mass逐坐标乘法，a、b、c分别表示q_{n−1}、q\_n、q_{n+1}，关系为M(c−2b+a)=h²F(b)。没有用逆质量扩展替代原乘法形式。作为给定三个节点的一步关系不需要序列量词或启动过程；没有声称零质量模型的存在唯一性。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_stormerRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L329)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-VelocityVerlet · definition · 印刷p.64 / PDFp.86

### 2. 原文陈述

> The scheme is usually given in an alternative “velocity Verlet” form that takes a step from a given vector $`\boldsymbol q_n,\boldsymbol v_n`$ to $`\boldsymbol q_{n+1},\boldsymbol v_{n+1}`$ by the sequence of operations

$$
\boldsymbol v_{n+1/2}=\boldsymbol v_n+(h/2)M^{-1}F_n,\tag{2.5}
$$



$$
\boldsymbol q_{n+1}=\boldsymbol q_n+h\boldsymbol v_{n+1/2},\tag{2.6}
$$



$$
\boldsymbol v_{n+1}=\boldsymbol v_{n+1/2}+(h/2)M^{-1}F_{n+1},\tag{2.7}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_velocityVerlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vhalf := z.2 + (h/2) • invMass m (F z.1)
  let qnew := z.1 + h • vhalf
  (qnew, vhalf + (h/2) • invMass m (F qnew))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_velocityVerlet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 deps:2816–2817、2840：Z n=(Fin n→ℝ)×(Fin n→ℝ)，没有将第二分量强制定义为动量的包装或类型约束，故此接口可按本条上下文解释为(q,v)。invMass逐坐标除质量，在原文可逆正对角质量语境下等于M⁻¹。bp\_velocityVerlet先令vhalf=z.2+(h/2)M⁻¹F(z.1)，再qnew=z.1+h*vhalf，最后返回(qnew,vhalf+(h/2)M⁻¹F(qnew))，完整覆盖(2.5)–(2.7)，末力使用新位置且第二输出为速度。任意F的参数化包含原文F=−∇U的机械特例，不要求输出为动量。该显式算法在非正/零质量或h=0上是总函数代数扩展；PASS仅对原文正质量、h>0使用域，零质量不解释为真实矩阵逆。建议后续文档明示positiveMass使用前提，但它不是本条三步显式公式的遗漏结论。无[EXTRA]/[ERRATUM?]；无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_velocityVerlet`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L333)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-EliminateVelocity · unnumbered_claim · 印刷p.65 / PDFp.87

### 2. 原文陈述

> The derivation of the Störmer form from the velocity Verlet form is straightforward: write down two consecutive steps of (2.5)–(2.7) then eliminate velocities.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem velocityVerletStormer :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h (a b c : Z n),
    b = velocityVerlet m F h a → c = velocityVerlet m F h b →
    stormerRelation m F h a.1 b.1 c.1 := by
  exact MolecularDynamics.Chapter02Review.velocityVerletStormer_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.velocityVerletStormer` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean:2816–2817、2840：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m x i=(m i)⁻¹*x i；加减、实数标量作用均逐坐标，因此对应有限维坐标空间及固定对角质量矩阵 diag(m)。教材的非零（物理上正）质量域上，这正是 M⁻¹。Lean 在零质量处取 0⁻¹=0，是公式的全域延拓，不宣称零质量矩阵可逆；在原文定义域上没有改变公式。任意实数 h、任意 F 的代数公式无需光滑性、保守力或 h≠0；这些物理/分析条件不用于本条等式。五条均无 [EXTRA] 或 [ERRATUM?] 标记。实际蓝图附件为 /workspace/Ch02.lean，按要求以 Blueprint/Ch02.lean 为版本绑定键。已展开正式库 velocityVerlet（2855–2858）及 stormerRelation（2853–2854），未以蓝图 bp_ 同名近似定义代替。前者依次令 v½=v+(h/2)M⁻¹F(q)、q′=q+h v½、v′=v½+(h/2)M⁻¹F(q′)；后者恰为 q₂−2q₁+q₀=h²M⁻¹F(q₁)。蓝图238–242行先全称量化 n,m,F,h,a,b,c，再假定同一参数下 b=VV(a)、c=VV(b)，推出三个位置满足该关系，覆盖两次连续更新与消去速度的全部结论。逐坐标代入得 q₂−2q₁+q₀=h(v₁−v½₀)+(h²/2)M⁻¹F(q₁)=h²M⁻¹F(q₁)，不需质量非零。Statements.lean:3017–3021 的签名一致。证明状态单列：蓝图 exact 指向 ReviewProofs.lean:3375–3383 的 subst/ext/simp/ring 证明，该证明文本没有 sorry；本审计未运行编译或依赖公理检查。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.velocityVerletStormer`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L339)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-MomentumVerlet · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> The most straightforward rewriting of the Verlet method is to put the equations and the discretization in Hamiltonian form, i.e. introducing momenta $`\boldsymbol p=M\boldsymbol v`$, and thus $`\boldsymbol p_n=M\boldsymbol v_n`$, which results in the flow map approximation (taking us from any point in phase space $`(\boldsymbol q,\boldsymbol p)`$ to a new point $`(\boldsymbol Q,\boldsymbol P)`$):

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p+\frac{h^2}{2}M^{-1}F(\boldsymbol q),\qquad\boldsymbol P=\boldsymbol p+\frac h2[F(\boldsymbol q)+F(\boldsymbol Q)].\tag{2.8}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_verlet {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let qnew := z.1 + h • invMass m z.2 + (h^2/2) • invMass m (F z.1)
  (qnew, z.2 + (h/2) • (F z.1 + F qnew))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_verlet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean:2816–2817、2840：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m x i=(m i)⁻¹*x i；加减、实数标量作用均逐坐标，因此对应有限维坐标空间及固定对角质量矩阵 diag(m)。教材的非零（物理上正）质量域上，这正是 M⁻¹。Lean 在零质量处取 0⁻¹=0，是公式的全域延拓，不宣称零质量矩阵可逆；在原文定义域上没有改变公式。任意实数 h、任意 F 的代数公式无需光滑性、保守力或 h≠0；这些物理/分析条件不用于本条等式。五条均无 [EXTRA] 或 [ERRATUM?] 标记。实际蓝图附件为 /workspace/Ch02.lean，按要求以 Blueprint/Ch02.lean 为版本绑定键。已展开蓝图245–247行：输入 z=(q,p)，qnew=q+h M⁻¹p+(h²/2)M⁻¹F(q)，输出 (qnew,p+(h/2)(F(q)+F(qnew)))。两分量逐项对应(2.8)，第二分量为动量，未误用速度更新中的 M⁻¹。正式库 verlet（2859–2861）展开也完全相同。半踢 p½=p+(h/2)F(q)、漂移 Q=q+h M⁻¹p½、半踢 P=p½+(h/2)F(Q)展开即此式。原文 p=Mv 是坐标解释；此定义输入已经为动量，不另断言奇异质量下速度与动量互相可逆。返回任意相空间点的一步映射，定义无额外量词或遗漏的输出分量。证明状态单列：这是无 sorry 的显式定义，不以该事实替代签名判断。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_verlet`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L346)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-Leapfrog · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> Returning to (2.5)–(2.7), write out the formulas for two successive steps ($`(\boldsymbol q_{n-1},\boldsymbol v_{n-1})\mapsto(\boldsymbol q_n,\boldsymbol v_n)`$ and $`(\boldsymbol q_n,\boldsymbol v_n)\mapsto(\boldsymbol q_{n+1},\boldsymbol v_{n+1})`$) and note that, from

$$
\boldsymbol v_n=\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,
$$


> one has

$$
\boldsymbol v_{n+1/2}=\boldsymbol v_{n-1/2}+hM^{-1}F_n,\qquad\boldsymbol q_{n+1}=\boldsymbol q_n+h\boldsymbol v_{n+1/2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_leapfrog {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Z n :=
  let vnew := z.2 + h • invMass m (F z.1)
  (z.1 + h • vnew, vnew)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_leapfrog` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean:2816–2817、2840：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m x i=(m i)⁻¹*x i；加减、实数标量作用均逐坐标，因此对应有限维坐标空间及固定对角质量矩阵 diag(m)。教材的非零（物理上正）质量域上，这正是 M⁻¹。Lean 在零质量处取 0⁻¹=0，是公式的全域延拓，不宣称零质量矩阵可逆；在原文定义域上没有改变公式。任意实数 h、任意 F 的代数公式无需光滑性、保守力或 h≠0；这些物理/分析条件不用于本条等式。五条均无 [EXTRA] 或 [ERRATUM?] 标记。实际蓝图附件为 /workspace/Ch02.lean，按要求以 Blueprint/Ch02.lean 为版本绑定键。已展开蓝图250–252行与正式库 leapfrog（2863–2865）：输入 z=(q\_n,v_(n−1/2))，vnew=v_(n−1/2)+h M⁻¹F(q\_n)，输出 (q\_n+h vnew,vnew)=(q_(n+1),v_(n+1/2))，原文两条更新式及其先后顺序均保留。n 的类型参数是维数，时间下标通过一次更新的输入输出解释，不混淆二者。原文引出的 v\_n=v_(n−1/2)+(h/2)M⁻¹F\_n 是推导所用重建关系，本批 Reconstruct 定义单独覆盖；本条一步映射无需额外记录整数时标。证明状态单列：显式定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_leapfrog`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L351)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-LeapfrogInit · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> It is necessary to define an initialization procedure for $`\boldsymbol v_{-1/2}`$:

$$
\boldsymbol v_{-1/2}=\boldsymbol v_0-(h/2)M^{-1}F(\boldsymbol q_0).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_leapfrogInitialize {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 - (h/2) • invMass m (F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_leapfrogInitialize` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean:2816–2817、2840：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m x i=(m i)⁻¹*x i；加减、实数标量作用均逐坐标，因此对应有限维坐标空间及固定对角质量矩阵 diag(m)。教材的非零（物理上正）质量域上，这正是 M⁻¹。Lean 在零质量处取 0⁻¹=0，是公式的全域延拓，不宣称零质量矩阵可逆；在原文定义域上没有改变公式。任意实数 h、任意 F 的代数公式无需光滑性、保守力或 h≠0；这些物理/分析条件不用于本条等式。五条均无 [EXTRA] 或 [ERRATUM?] 标记。实际蓝图附件为 /workspace/Ch02.lean，按要求以 Blueprint/Ch02.lean 为版本绑定键。已展开蓝图255–256行与正式库 leapfrogInitialize（2866–2867）：输入实际初值 z=(q₀,v₀)，仅返回速度 v₀−(h/2)M⁻¹F(q₀)，精确对应 v_(−1/2) 初始化；负号、半步系数、力的取值点及返回类型 Q n 均一致。原文不要求同时输出位置，故不返回配对状态没有遗漏结论。证明状态单列：显式定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_leapfrogInitialize`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L356)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-LeapfrogReconstruct · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> And it is also necessary to use, at any subsequent step,

$$
\boldsymbol v_n=\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,
$$


> if $`\boldsymbol q_n,\boldsymbol v_n`$ are both needed, e.g. for the evaluation of the energy or other velocity-dependent observable.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_leapfrogReconstruct {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (z : Z n) : Q n :=
  z.2 + (h/2) • invMass m (F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_leapfrogReconstruct` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean:2816–2817、2840：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m x i=(m i)⁻¹*x i；加减、实数标量作用均逐坐标，因此对应有限维坐标空间及固定对角质量矩阵 diag(m)。教材的非零（物理上正）质量域上，这正是 M⁻¹。Lean 在零质量处取 0⁻¹=0，是公式的全域延拓，不宣称零质量矩阵可逆；在原文定义域上没有改变公式。任意实数 h、任意 F 的代数公式无需光滑性、保守力或 h≠0；这些物理/分析条件不用于本条等式。五条均无 [EXTRA] 或 [ERRATUM?] 标记。实际蓝图附件为 /workspace/Ch02.lean，按要求以 Blueprint/Ch02.lean 为版本绑定键。已展开蓝图259–260行与正式库 leapfrogReconstruct（2868–2869）：输入 (q\_n,v_(n−1/2))，返回 v_(n−1/2)+(h/2)M⁻¹F(q\_n)，正号、半步系数、F\_n=F(q\_n)及返回整步速度完全一致。任意输入状态的定义可在任意后续步骤应用，无需将时间指标作为额外参数。能量和依赖速度的观测量是重建速度的用途，原文未给这些量的额外等式，本定义没有遗漏需形式化的结论。证明状态单列：显式定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_leapfrogReconstruct`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L360)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorDifference · unnumbered_claim · 印刷p.66 / PDFp.88

### 2. 原文陈述

> Taking the difference of the numerical and exact solutions, we have

$$
\boldsymbol z_{n+1}-\boldsymbol z(t_{n+1})=\mathcal G_h(\boldsymbol z_n)-\mathcal F_h(\boldsymbol z(t_n)).\tag{2.9}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem errorDifference :
  ∀ n (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) h k,
    γ ((k+1 : ℕ)*h) = F h (γ (k*h)) →
    oneStepIterate G h (γ 0) (k+1) - γ ((k+1 : ℕ)*h) =
      G h (oneStepIterate G h (γ 0) k) - F h (γ (k*h)) := by
  exact MolecularDynamics.Chapter02Review.errorDifference_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.errorDifference` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；对象展开：Ch02\_deps.txt:2816（MolecularDynamics/Chapter02/ReviewDefinitions.lean）Q n := Fin n → ℝ，是n维实坐标空间；加减逐坐标，默认Pi范数为最大坐标绝对值。原文此处使用范数而未在本条指定欧氏范数，此选择不改变所述范数不等式的结构；不能将该实例误称为欧氏范数。n可取完整状态的坐标数，Q这个名字不把变量限制为位置。 迭代展开：Ch02\_deps.txt:1443–1452（MolecularDynamics/Chapter02/OneStepConvergence.lean）oneStepIterate G h z₀ n := (G h)^[n] z₀；0次为z₀，后继为G h作用于前一节点。代入z₀=γ 0，正是共同初值的数值解。 Ch02.lean:263–270全称n,G,F,γ,h,k，先假设γ((k+1)h)=F\_h(γ(kh))，再得到数值后继减精确后继等于G\_h(数值当前节点)减F\_h(精确当前节点)，正是PDF88式(2.9)，未缺结论项。相同初值来自数值解的背景；任意h及无光滑性是代数恒等式的合理推广，无新增必要假设或[ERRATUM?]。依赖Statements.lean的errorDifference\_statement（deps:3020–3025）同签名，ReviewProofs.lean的errorDifference\_proved（deps:3366–3368）用后继递推及精确节点等式改写。证明状态单独记录：本地声明及本项直接调用的依赖证明体未见sorry；本次未编译工程，不据此认证整个依赖工程无证明缺口。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.errorDifference`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L364)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-Consistency · definition · 印刷p.66–67 / PDFp.88–89

### 2. 原文陈述

> The first assumption is that $`\mathscr G_h`$ is an $`O(h^{p+1})`$ approximation of $`\mathscr F_h`$ in the sense that there is a constant $`K\ge0`$ and a constant $`\Delta\gt 0`$ such that, for $`t\in[0,\tau]`$, we have

$$
\|\mathscr F_h(\boldsymbol z(t))-\mathscr G_h(\boldsymbol z(t))\|\le\bar K h^{p+1},\qquad h\lt \Delta.\tag{2.10}
$$


> The assumption (2.10) that the local error is of order $`p+1`$, $`p\gt 0`$, is termed the consistency of the numerical method. We say the method is consistent of order $`p`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def consistency {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  0 < p ∧ ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)



/-- 修正版，对应原文 MD-2.2.3-Consistency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def consistency_corrected {n : ℕ} (G F : ℝ → Q n → Q n) (γ : ℝ → Q n) (τ : ℝ) (p : ℕ) : Prop :=
  0 < p ∧ ∃ K ≥ 0, ∃ δ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ,
    ‖F h (γ t)-G h (γ t)‖ ≤ K*h^(p+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.consistency`；`MD.Ch02.consistency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 显式0<p；本条只登记正自然数阶，属于[EXTRA]整数阶限制；保持统一K、δ及严格0<h<δ，不静默扩大端点。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；consistency固定G、F、γ、τ和自然数阶p；要求p>0，并先存在与t、h无关的K≥0、δ>0，再对全部t∈[0,τ]、0<h<δ给局部误差界Kh^(p+1)。严格步长范围与原式一致，整数阶限制已明确为[EXTRA]。未要求F必须是流是此纯误差关系的抽象接口。正文K和式中Kbar不一致已保留，不能在来源层面擅自等同，转人工。

### 7. 状态与证明位置

self-contained；`MD.Ch02.consistency`：定义；`MD.Ch02.consistency_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L374)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-Stability · definition · 印刷p.66–67 / PDFp.88–89

### 2. 原文陈述

> To tackle the question of the growth of local error, we still must make an important assumption on $`\mathcal G_h`$, namely that it satisfies a Lipschitz condition of the form

$$
\|\mathcal G_h(\boldsymbol u)-\mathcal G_h(\boldsymbol w)\|\le(1+hL)\|\boldsymbol u-\boldsymbol w\|,\qquad\boldsymbol u,\boldsymbol w\in\mathcal D;\ h\le\Delta.\tag{2.11}
$$


> The assumption (2.11) that the method does not increase the separation between two nearby trajectories by more than a factor of the form $`1+hL`$ in each step is referred to as the stability of the method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def stability {n : ℕ} (G : ℝ → Q n → Q n) (D : Set (Q n)) : Prop :=
  ∃ L ≥ 0, ∃ δ > 0, ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
    ‖G h u-G h w‖ ≤ (1+h*L)*‖u-w‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.stability` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；对象展开：Ch02\_deps.txt:2816（MolecularDynamics/Chapter02/ReviewDefinitions.lean）Q n := Fin n → ℝ，是n维实坐标空间；加减逐坐标，默认Pi范数为最大坐标绝对值。原文此处使用范数而未在本条指定欧氏范数，此选择不改变所述范数不等式的结构；不能将该实例误称为欧氏范数。n可取完整状态的坐标数，Q这个名字不把变量限制为位置。 Ch02.lean:278–280定义先存在L≥0、δ>0，再对0<h≤δ以及任意u,w∈D全称量化；展开后即PDF88式(2.11)。量词顺序、两个状态及全部结论一致。L非负是合理的常数选择：若某个实L满足界，放大到max L 0对h>0保持界，故存在性不变；后续需要除L时还能选严格正L。D内精确和数值留域是后续应用假设，无需置入此稳定性谓词；不需光滑性。[EXTRA]/[ERRATUM?]均无本地标记，原文h>0由背景提供。证明状态：完整def，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.stability`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L386)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorRecursion · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> then take norms and use the triangle inequality and (2.10), (2.11) to get the following recurrent inequality for the error $`\epsilon_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|`$:

$$
\epsilon_{n+1}\le(1+Lh)\epsilon_n+\bar K h^{p+1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem errorRecursion (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    (h L K p : ℝ) (ν : ℕ)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1))
    (n : ℕ) (hn : n < ν) :
    ‖oneStepIterate G h (γ 0) (n + 1) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤
      (1 + h * L) * ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ +
        K * h ^ (p + 1) := by
  apply MolecularDynamics.oneStep_error_recursion <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.errorRecursion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。 | [EXTRA] |

[EXTRA] 精确流作用直接以γ后继节点表示；一般范数空间版本含有限维实例；实数p接口覆盖自然数正阶。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；迭代展开：Ch02\_deps.txt:1443–1452（MolecularDynamics/Chapter02/OneStepConvergence.lean）oneStepIterate G h z₀ n := (G h)^[n] z₀；0次为z₀，后继为G h作用于前一节点。代入z₀=γ 0，正是共同初值的数值解。 Ch02.lean:284–299在实范数空间E中固定h,L,K,p,ν，hnum和hexact保证0≤n≤ν两类节点均在D；hstable为D上单步界，hconsistent为所有n<ν的轨道局部误差界，然后对任意n<ν输出完整ε_(n+1)≤(1+hL)ε\_n+K h^(p+1)。将F\_h(γ(nh))用精确后继γ((n+1)h)替换、并利用范数对相反差的对称性，忠实对应PDF89递推。[EXTRA]一般实范数空间是合理推广，有限维实例被覆盖而非附加有限维假设；p为实数、在固定步长局部界已直接假定时无需另加p>0、h<Δ等条件，推导只用三角不等式。留域不是额外未经说明的限制。deps:1479–1505的直接依赖证明展开了上述加减G\_h(精确节点)及三角不等式。无[ERRATUM?]标记。证明状态单独记录：本地声明及本项直接调用的依赖证明体未见sorry；本次未编译工程，不据此认证整个依赖工程无证明缺口。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.errorRecursion`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L392)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorBound · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> From this, the bound

$$
\epsilon_n\le\frac{\bar K}{L}e^{Lnh}h^p,\qquad n=0,1,\ldots,\nu,\tag{2.12}
$$


> follows by a straightforward calculation, for $`h\le\Delta`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem errorBound (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply MolecularDynamics.oneStep_error_bound <;> assumption



/-- 修正版，对应原文 MD-2.2.3-ErrorBound。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem errorBound_corrected (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {h L K p : ℝ} (ν : ℕ) (hh : 0 < h) (hL : 0 < L) (hK : 0 ≤ K)
    (hnum : ∀ n ≤ ν, oneStepIterate G h (γ 0) n ∈ D)
    (hexact : ∀ n ≤ ν, γ ((n : ℝ) * h) ∈ D)
    (hstable : ∀ u ∈ D, ∀ w ∈ D, ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ n < ν,
      ‖G h (γ ((n : ℝ) * h)) - γ (((n + 1 : ℕ) : ℝ) * h)‖ ≤ K * h ^ (p + 1)) :
    ∀ n ≤ ν, ‖oneStepIterate G h (γ 0) n - γ ((n : ℝ) * h)‖ ≤
      (K / L) * Real.exp (L * ((n : ℝ) * h)) * h ^ p := by
  apply MolecularDynamics.oneStep_error_bound <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.errorBound`；`MD.Ch02.errorBound_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] h>0、L>0及K≥0显式化；L=0时可增大为正L，除零界不能字面使用；假设精确与数值留域来自原文。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；errorBound对给定正h、正L、非负K和ν，要求0至ν实际迭代与精确网格值均在D，G在D上稳定，且全部n<ν上的实际局部缺陷≤Kh^(p+1)。初始误差由迭代起点γ(0)保证为零。结论对所有n≤ν为(K/L)exp(Lnh)h^p；p为实数，h>0使实幂有意义。此加强前提的界正确，不需要额外p>0才能成立。但没有δ及h≤Δ的量词，不能据此消除书中从严格步长范围跳到闭端点的问题，整体转人工。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.errorBound`：已证；`MD.Ch02.errorBound_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L408)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ConsistencyConvergence · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> This result shows that a method which is consistent of order $`p`$ and stable is convergent of order $`p`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem consistencyConvergence
    (G : ℝ → E → E) (γ : ℝ → E) (D : Set E)
    {τ δ L K p : ℝ} (hτ : 0 < τ) (hδ : 0 < δ) (hL : 0 < L)
    (hK : 0 ≤ K) (hp : 0 < p)
    (hexact : MapsTo γ (Icc 0 τ) D)
    (hnum : ∀ ν : ℕ, 0 < ν → τ / (ν : ℝ) ≤ δ →
      ∀ n ≤ ν, oneStepIterate G (τ / (ν : ℝ)) (γ 0) n ∈ D)
    (hstable : ∀ h ∈ Ioc 0 δ, ∀ u ∈ D, ∀ w ∈ D,
      ‖G h u - G h w‖ ≤ (1 + h * L) * ‖u - w‖)
    (hconsistent : ∀ h ∈ Ioo 0 δ, ∀ t ∈ Icc 0 τ, t + h ≤ τ →
      ‖G h (γ t) - γ (t + h)‖ ≤ K * h ^ (p + 1)) :
    Tendsto (fun ν : ℕ => oneStepMaxError G (τ / (ν : ℝ)) γ ν) atTop (𝓝 0) ∧
    ∀ᶠ ν : ℕ in atTop, oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
      ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
  constructor
  · exact MolecularDynamics.oneStep_converges_of_consistency_stability G γ D
      (τ := τ) (δ := δ) (L := L) (K := K) (p := p)
      hτ hδ hL hK hp hexact hnum hstable hconsistent
  · have hstep : Tendsto (fun ν : ℕ => τ / (ν : ℝ)) atTop (𝓝 0) :=
      tendsto_const_div_atTop_nhds_zero_nat τ
    have hbound : ∀ᶠ ν : ℕ in atTop,
        oneStepMaxError G (τ / (ν : ℝ)) γ ν ≤
          ((K / L) * Real.exp (L * τ)) * (τ / (ν : ℝ)) ^ p := by
      filter_upwards [eventually_gt_atTop (0 : ℕ), hstep.eventually_lt_const hδ]
        with ν hν hsmall
      have hνR : 0 < (ν : ℝ) := Nat.cast_pos.mpr hν
      have hh : 0 < τ / (ν : ℝ) := div_pos hτ hνR
      have hend : (ν : ℝ) * (τ / (ν : ℝ)) = τ := mul_div_cancel₀ _ hνR.ne'
      have htime : ∀ n ≤ ν, (n : ℝ) * (τ / (ν : ℝ)) ∈ Icc 0 τ := by
        intro n hn
        refine ⟨mul_nonneg (Nat.cast_nonneg n) hh.le, ?_⟩
        calc
          _ ≤ (ν : ℝ) * (τ / (ν : ℝ)) :=
            mul_le_mul_of_nonneg_right (Nat.cast_le.mpr hn) hh.le
          _ = τ := hend
      apply oneStepMaxError_order_bound G γ D ν hh hL hK hend.le
        (hnum ν hν hsmall.le) (fun n hn => hexact (htime n hn))
        (hstable _ ⟨hh, hsmall.le⟩)
      intro n hn
      have ht := htime n (Nat.le_of_lt hn)
      have hnext := (htime (n + 1) (Nat.succ_le_of_lt hn)).2
      simp only [Nat.cast_add, Nat.cast_one, add_mul, one_mul] at hnext ⊢
      exact hconsistent _ ⟨hh, hsmall⟩ _ ht hnext
    exact hbound
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.consistencyConvergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。 | [EXTRA] |

[EXTRA] τ,δ,L,p严格正，K≥0；D含精确及所有细网格数值解（原文明确简化前提）。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；迭代展开：Ch02\_deps.txt:1443–1452（MolecularDynamics/Chapter02/OneStepConvergence.lean）oneStepIterate G h z₀ n := (G h)^[n] z₀；0次为z₀，后继为G h作用于前一节点。代入z₀=γ 0，正是共同初值的数值解。 最大误差展开：deps:1460–1462的oneStepMaxError := (Finset.range (ν+1)).sup' 非空证明 (fun n => ‖oneStepIterate G h (γ 0) n−γ(nh)‖)，取的恰是0≤n≤ν全部节点的有限最大值，含两端。Ch02.lean:320–339先固定统一τ,δ,L,K,p并要求τ,δ,L,p>0、K≥0；精确轨道在[0,τ]留域，所有正ν且τ/ν≤δ的网格数值节点留域，稳定界统一覆盖0<h≤δ，局部界统一覆盖0<h<δ和t,t+h∈[0,τ]。结论第一项是最大误差沿ν→∞趋零，第二项是最终≤((K/L)exp(Lτ))(τ/ν)^p，既含收敛又含p阶，无遗漏子句。最终正ν自动避免τ/0，有限前缀不影响atTop。局部一致性仅用到t+h≤τ处是足够且合理的轨道表述，在精确流关系下与原文局部缺陷相同。[EXTRA]τ,δ,p正、K非负有背景依据；L正可放大取得；两类留域是原文明示的简化假设。一般E覆盖有限维空间，未额外假定ODE存在或唯一性，因为此处γ已给定且其精确后继局部缺陷直接作为假设。收敛不依赖h=δ端点，未受原书端点疑误影响；无本地[ERRATUM?]标记。deps:1587–1620直接依赖证明采用同一最大误差定义及同一量词和前提。证明状态单独记录：本地声明及本项直接调用的依赖证明体未见sorry；本次未编译工程，不据此认证整个依赖工程无证明缺口。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.consistencyConvergence`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L436)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ScalarVerlet · Example 2.2 (map) · 印刷p.67 / PDFp.89

### 2. 原文陈述

> In this example, assume a single degree of freedom system, i.e. $`q,p\in\mathbb R`$, and take $`M=1`$. The Verlet method can be written in the form of a map, as in (2.8), or, in slightly more detail, as

$$
Q=q+hp+\frac{h^2}{2}F(q),\tag{2.13}
$$



$$
P=p+\frac h2\left[F(q)+F(q+hp+\frac{h^2}{2}F(q))\right].\tag{2.14}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_scalarVerlet (F : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2+h^2/2*F z.1
  (q, z.2+h/2*(F z.1+F q))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_scalarVerlet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；重新展开Ch02.lean:356–358本地bp\_scalarVerlet：z:ℝ×ℝ，z.1是初始q、z.2是初始p；局部绑定q\_new=z.1+h*z.2+(h²/2)F(z.1)，输出(q\_new,z.2+(h/2)(F(z.1)+F(q\_new)))。完全对应PDF89式(2.13)的Q及式(2.14)的P，坐标顺序、标量对象和单位质量无遗漏；原文F为力，不是此处前面精确流符号F\_h。deps:3026–3028正式scalarVerlet与此本地定义体一致，已另行读取核对。任意F,h的代数公式覆盖本例，无须额外光滑性；无[EXTRA]/[ERRATUM?]标记。证明状态：完整def，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_scalarVerlet`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L482)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

