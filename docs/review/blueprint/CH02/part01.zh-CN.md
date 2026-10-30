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

