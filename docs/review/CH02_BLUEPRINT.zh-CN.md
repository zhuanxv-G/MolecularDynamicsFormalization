# 第2章 Lean Blueprint 本地审阅材料

160条；网站PASS 126，本地按意见修复4条（未再送网站），合并勘误25项。
统计与证明状态见[导师摘要](CH02_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](CH02_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch02/full/CHECK\_REPORT.json。

## 1. MD-2-HamiltonianODE · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> The challenge before us is to compute solutions of

$$
\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad \dot{\boldsymbol p}=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q),
$$


> or, more compactly, with $\boldsymbol z$ representing the collection of all positions and momenta,

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L20)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2-Hamiltonian · definition · 印刷p.53 / PDFp.75

### 2. 原文陈述

> and $H=\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p/2+U(\boldsymbol q)$ is the Hamiltonian.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L34)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L39)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2-OneStep · definition · 印刷p.54 / PDFp.76

### 2. 原文陈述

> Suppose that the system under study has a well defined flow map $\mathscr F_t$ defined on the phase space (which is assumed to exclude any singular points of the potential energy function). The solution of the initial value problem, $\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z)$, $\boldsymbol z(0)=\boldsymbol\zeta$, may be written $\boldsymbol z(t,\boldsymbol\zeta)$ (with $\boldsymbol z(0,\boldsymbol\zeta)=\boldsymbol\zeta$), and the flow-map $\mathscr F_t$ satisfies $\mathscr F_t(\boldsymbol\zeta)=\boldsymbol z(t,\boldsymbol\zeta)$. A one-step method, starting from a given point, approximates a point on the solution trajectory at a given time $h$ units later. Such a method defines a map $\mathscr G_h$ of the phase space as illustrated in Fig. 2.1.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L44)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。Ch02\_deps.txt 的 ReviewDefinitions.lean:2816 将 Q n 展开为 Fin n → ℝ，即有限维实坐标向量，标准函数空间范数为最大坐标范数；原条目未指定必须使用欧氏范数，且有限维范数等价，收敛与阶上界不受此选择影响。OneStepConvergence.lean:1443–1444 的 oneStepIterate G h z₀ k = (G h)^[k] z₀；1460–1463 的 oneStepMaxError = (Finset.range (ν+1)).sup′ nonempty (fun k => ‖(G h)^[k](γ 0) − γ((k:ℝ)*h)‖)。sup′ 在非空有限实数集合上为真正最大值，range(ν+1) 正好为0,…,ν，包含初末节点，不是只有末节点，也没有替换初值。 因而在固定 τ>0、h=τ/ν 的原文网格语境下，Tendsto atTop (𝓝 0) 展开为对每个 ε>0，存在自然数阈值 N，使所有 ν≥N 的全部节点误差最大值小于 ε；阈值可依赖 G、γ、τ、ε。这忠实表达任意精度和足够小步长。ν=0 的零除按 Lean 全函数约定处理，但有限前缀不影响极限。[EXTRA] 固定时间窗和网格受 PDF78/印刷56页上下文支持；无需给定义本身额外加 ODE 或正则性假设，因为这里只定义相对于给定准确曲线的误差性质。τ 未限制的接口是扩展；τ=0 或负时间的值不应冒充原文正时间窗的断言。注释“τ>0在具体定理中明示”不精确：本批 theorem\_2\_1 为0≤τ，且库明确单独处理τ=0；这是说明文字需修订，不是收敛谓词在原文使用域内的错误。无本条[ERRATUM?]。证明状态单列：这是定义，无直接sorry；本次不作编译或传递公理检查。

### 7. 状态与证明位置

self-contained；`MD.Ch02.convergence`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L63)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Order · definition · 印刷p.55 / PDFp.77

### 2. 原文陈述

> The order of accuracy is the exponent in the power law by which the error in the method is related to the stepsize. For example, when we say that a method is third order accurate, we mean that the global error (on a fixed finite time interval) can be bounded by $Kh^3$, where $h$ is a sufficiently small timestep and $K$ is a number which depends on the length of the time interval and the features of the problem, but which is independent of $h$.

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
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。Ch02\_deps.txt 的 ReviewDefinitions.lean:2816 将 Q n 展开为 Fin n → ℝ，即有限维实坐标向量，标准函数空间范数为最大坐标范数；原条目未指定必须使用欧氏范数，且有限维范数等价，收敛与阶上界不受此选择影响。OneStepConvergence.lean:1443–1444 的 oneStepIterate G h z₀ k = (G h)^[k] z₀；1460–1463 的 oneStepMaxError = (Finset.range (ν+1)).sup′ nonempty (fun k => ‖(G h)^[k](γ 0) − γ((k:ℝ)*h)‖)。sup′ 在非空有限实数集合上为真正最大值，range(ν+1) 正好为0,…,ν，包含初末节点，不是只有末节点，也没有替换初值。 量词为固定 G、γ、τ、r 后 ∃K>0，∃ν₀>0，∀ν≥ν₀，最大误差≤K(τ/ν)^r。K和阈值可依赖问题及时间长度，但不能依赖后选的ν；同时控制全部节点，完整保留固定时间区间的全局误差上界。原文用上界定义第三阶，未要求非零误差下界或“最佳阶”，故本签名无需添加这类条款。[EXTRA] r:ℕ 是已登记的一般化，取r=3直接回到原句；r=0只表O(1)，不能据此声称收敛。ν₀>0排除分母零；在原文τ>0域内将K增大到严格正不损失任何上界。h=τ/ν 来自原文固定网格，足够大ν等价该网格上足够小正步长；本条不宣称非网格步长或统一所有曲线的额外结论。τ:ℝ 的域外扩展不改变正时间窗含义，但应在使用说明中明确τ>0。无[ERRATUM?]。证明状态单列：定义，无直接sorry，不据此推断整个工程无sorry或已编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.order`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L68)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Error · definition · 印刷p.56 / PDFp.78

### 2. 原文陈述

> Let the approximate solution vectors at successive timesteps be $\boldsymbol z_0,\boldsymbol z_1,\ldots,\boldsymbol z_\nu$ where $\nu h=\tau$. We assume that $\tau$, the length of the time interval, is fixed, and $\nu$ is an integer parameter representing the total number of timesteps. In order to improve the quality of the approximation, the parameter $\nu$ may be increased, as the stepsize is proportionately decreased. The error at step $n$ is defined by $e_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|$, where $t_n=nh$; it clearly depends on $h$.

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
网站原返回（对应其审校版本）：PASS；已将 BATCH02.md 的 Lean 块与实际 /workspace/Ch02.lean 对应声明核对，一致。本次哈希键 Blueprint/Ch02.lean 绑定实际读取的 /workspace/Ch02.lean（附件为扁平存放），未以不存在的路径或依赖段内标注哈希代替整附件字节哈希。已展开 OneStepConvergence.lean:1443–1444、1460–1463：maximumError G γ h ν = max_{0≤k≤ν} ‖(G h)^[k](γ 0)−γ((k:ℝ)*h)‖。ReviewDefinitions.lean:2819–2821 同时给出 meshTime h k = k*h、nodeError G γ h k = ‖oneStepIterate G h (γ 0) k−γ(meshTime h k)‖，所以原文逐点 e\_k 与 t\_k=kh 条款确实有正式展开，最大值接口没有换用其他误差定义。原文的z\_k是单步递推轨迹，准确初始化z₀=γ(0)来自章内上下文；νh=τ、固定τ是使用参数的网格关系，不是独立误差函数必须额外证明的条件。最大量来自本条context\_notation明确登记的紧接定理，包含两个端点。[EXTRA] 实范数空间泛化可实例化为教材有限维向量空间，不新增光滑、ODE或留域条件；这里原文也未指定某一特定范数。无需新增定义：正式库已有nodeError。无[ERRATUM?]。证明状态单列：maximumError、oneStepIterate、oneStepMaxError、nodeError为定义，无直接sorry；未执行编译或传递公理审计。

### 7. 状态与证明位置

self-contained；`MD.Ch02.maximumError`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L73)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.1-Thm2.1 · Theorem 2.1 · 印刷p.56 / PDFp.78

### 2. 原文陈述

> Let $\mathcal D$ be a bounded, open region in $\mathbb R^m$ such that $f:\mathcal D\to\mathbb R^m$ is continuously differentiable. Let $\boldsymbol\zeta$ be an interior point of $\mathcal D$ and suppose the initial value problem (2.1) has a unique solution that remains in $\mathcal D$ for $t\in[0,\tau]$. Then there exists a constant $C(\tau)>0$ such that for sufficiently large $\nu\in\mathbb N$ the numerical solution $\boldsymbol z_n$ remains in $\mathcal D$ for $n=0,1,\ldots,\nu$, where $h\nu=\tau$, and, moreover, the maximum global error in Euler’s method satisfies

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L79)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L95)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L105)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
网站原返回（对应其审校版本）：PASS；PASS。展开依赖合集第2941—2945行：compactTrajectory f γ τ 正好是 0<τ、ContDiff ℝ 6 f、solution f γ 0 τ、ContinuousOn γ (Icc 0 τ) 的合取；solution 是对每个 t∈[0,τ] 要求 HasDerivWithinAt γ (f (γ t)) [0,τ] t。故 γ 是实际 ODE 轨迹，闭窗端点也包括在内；并无全域轨迹 C⁶、全局 Lipschitz、预设误差界或数值留域前提。连续轨迹在有限维空间的紧时间窗有紧像，不需要额外假设名称所暗示的另一种紧性。第2827—2828行 taylor2 是 z+h f(z)+(h²/2)Df(z)f(z)，与 taylorSecond 定义体相同。第2824—2826行 globalOrder 展开为先存在 C>0，再存在自然数 ν₀>0，使所有 ν≥ν₀ 满足 oneStepMaxError G (τ/ν) γ ν≤C(τ/ν)^2；C 与阈值可以依赖已量化的 n、f、γ、τ，但不依赖随后量化的 ν。第1443—1444行 oneStepIterate 是 (G h)^[k] z₀；第1460—1463行 oneStepMaxError 是 k=0,…,ν 上 ‖(G h)^[k](γ 0)−γ(kh)‖ 的有限最大值，数值初值等于精确初值，覆盖全窗，且正阈值避免零网格。因此结论确实是固定有限时间窗上的全局 O(h²)，没有偷换为一步局部误差、误差极限或精确阶下界。Q n=Fin n→ℝ 的标准函数范数与有限维其他标准范数等价，允许改变 C 而不改变二阶。[EXTRA] 全域 C⁶ 远强于二阶所需但合理；τ>0 和真实解资格使有限窗阶断言有明确适用范围，ContinuousOn 与有限窗内实际解相容，未将待证稳定性作假设。无需预先假设数值迭代留域：在光滑向量场轨迹的紧邻域内建立局部误差和稳定性，再对充分细网格证明留在邻域，是该结论的证明义务。本条无 [ERRATUM?]，原文二阶称谓未发现疑误。Ch02.lean 第87行仍为 sorry；证明未完成与上述签名语义 PASS 分开，本次仅只读审计且不写证明、不编译。

### 7. 状态与证明位置

incomplete；`MD.Ch02.taylor2Order`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L110)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2-VerletOrder · unnumbered_claim · 印刷p.60 / PDFp.82

### 2. 原文陈述

> The Verlet method (also known as leapfrog or Störmer-Verlet) is a second order method that is popular for molecular simulation. It is specialized to problems that can be expressed in the form $\dot{\boldsymbol q}=\boldsymbol v$, $\boldsymbol M\dot{\boldsymbol v}=\boldsymbol F(\boldsymbol q)$, with even dimensional phase space $\mathbb R^{2\mathrm{N}_c}$, which includes constant energy molecular dynamics.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L118)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Lagrangian · definition · 印刷p.60 / PDFp.82

### 2. 原文陈述

> Recall from Chap. 1 that the Lagrangian for the N-body system is defined by

$$
L(\boldsymbol q,\boldsymbol v)\stackrel{\rm def}{=}\frac{\boldsymbol v^TM\boldsymbol v}{2}-U(\boldsymbol q),
$$


> where $M$ is the mass matrix and the potential energy function $U$ is, for simplicity, taken to be smooth ($C^2$).

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L127)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Admissible · definition · 印刷p.60 / PDFp.82

### 2. 原文陈述

> We consider the collection of all twice continuously differentiable curves in the configuration space which start from a certain point $\boldsymbol Q$ and end at another given point $\boldsymbol Q'$. We may think of any such curve as being represented by a parameterization $\boldsymbol q(t)$, $t\in[\alpha,\beta]$ with $\boldsymbol q(\alpha)=\boldsymbol Q$ and $\boldsymbol q(\beta)=\boldsymbol Q'$, where the components of $\boldsymbol q(t)$ are $C^\infty$ functions. Denote by $G=G(\boldsymbol Q,\boldsymbol Q',\alpha,\beta)$ the class of smooth parameterized curves such that $\boldsymbol q(\alpha)=\boldsymbol Q$, $\boldsymbol q(\beta)=\boldsymbol Q'$.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L134)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Action · definition · 印刷p.60 / PDFp.82

### 2. 原文陈述

> Then the classical action (or, simply, action) of the Lagrangian $L$ is defined for any $\Gamma\in G$ by

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L144)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Variation · definition · 印刷p.61 / PDFp.83

### 2. 原文陈述

> Given $\Gamma$ in $G$ with parameterization $\boldsymbol q(t)$, $t\in[\alpha,\beta]$, we consider the curve $\Gamma^\epsilon$ with parameterization $\boldsymbol q^\epsilon$ defined by

$$
\boldsymbol q^\epsilon(t)=\boldsymbol q(t)+\epsilon\boldsymbol\eta(t),\qquad t\in[\alpha,\beta],\tag{2.3}
$$


> where $\boldsymbol\eta(t)$ satisfies $\boldsymbol\eta(\alpha)=\boldsymbol\eta(\beta)=\boldsymbol0$. Thus $\boldsymbol\eta$ is a $C^\infty$ parameterized curve linking $\boldsymbol0$ to $\boldsymbol0$.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L148)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L153)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-TaylorPrinted · Footnote 3 · 印刷p.61 / PDFp.83

### 2. 原文陈述

> In the multidimensional setting, Taylor’s theorem states that given a $C^{k+1}$ function $f:\mathbb R^m\to\mathbb R$ and a point $\boldsymbol z_0$, we have

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L174)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-StationaryAction · definition · 印刷p.61–62 / PDFp.83–84

### 2. 原文陈述

> Hamilton’s principle states that the natural motion of the system described by the Lagrangian $L$ is a stationary point of the classical action which implies that the $O(\epsilon)$ term above should vanish for any smooth variation $\boldsymbol\eta(t)$ with $\boldsymbol\eta(\alpha)=\boldsymbol\eta(\beta)=\boldsymbol0$, i.e.,

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L185)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-Parts · unnumbered_claim · 印刷p.62 / PDFp.84

### 2. 原文陈述

> We use integration by parts to remove the differentiation of $\boldsymbol\eta$, thus (in light of the boundary conditions on $\boldsymbol\eta(t)$),

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L209)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-EulerLagrange · unnumbered_claim · 印刷p.62 / PDFp.84

### 2. 原文陈述

> Since the variation $\boldsymbol\eta$ is meant to be arbitrary, it requires

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L223)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-VariationalDerivativePrinted · definition · 印刷p.62 / PDFp.84

### 2. 原文陈述

> Define the variational derivative of a functional $\mathcal F$, $\delta\mathcal F/\delta\boldsymbol q$ so that

$$
\mathcal F(\boldsymbol q+\epsilon\boldsymbol\eta)=\epsilon\frac{\delta\mathcal F}{\delta\boldsymbol q}\boldsymbol\eta+O(\epsilon^2),
$$


> for all suitable (say, $C^\infty$) functions $\boldsymbol\eta$.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L234)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.1-StationaryNotMin · Footnote 4 · 印刷p.62 / PDFp.84

### 2. 原文陈述

> Any curve which satisfies this equation will represent a “stationary point” (actually, “stationary curve” would be more accurate) of the classical action. Such curves could include smooth local action minimizers, local action maximizers, or “saddle points” of the actional functional in a generalized sense. Deciding whether a given stationary curve is an actual minimizer of the action would require analysis of the second variation (the coefficient of $\epsilon^2$ in the expansion above), which introduces additional complexity.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L250)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscretePath · definition · 印刷p.63 / PDFp.85

### 2. 原文陈述

> We work on the time interval $[0,\tau]$. Consider the $\nu+1$ points $\boldsymbol q_0$ to $\boldsymbol q_\nu$ in configuration space

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L272)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteVelocity · definition · 印刷p.63 / PDFp.85

### 2. 原文陈述

> we are led to consider the approximation at time level $n$

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L275)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteAction · definition · 印刷p.63 / PDFp.85

### 2. 原文陈述

> and thus, by Riemann summation

$$
\mathcal A_L\approx\hat{\mathcal A}\stackrel{\rm def}{=}\sum_{n=0}^{\nu-1} L\left(\boldsymbol q_n,\frac{\boldsymbol q_{n+1}-\boldsymbol q_n}{h}\right)h.
$$


> In the case of a mechanical system with Lagrangian $L(\boldsymbol q,\boldsymbol v)=\dot{\boldsymbol v}^TM\boldsymbol v/2+U(\boldsymbol q)$, we then have

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L281)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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


> since we think of the starting point $\boldsymbol q_0$ as fixed.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L295)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-DiscreteDerivative · unnumbered_claim · 印刷p.64 / PDFp.86

### 2. 原文陈述

> To calculate the derivative of $\hat{\mathcal A}$ with respect to $\boldsymbol q_n$, $n=1,2,\ldots,\nu-1$, note that only a few terms of the discrete action involve this configurational point, thus

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L310)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L320)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L329)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-VelocityVerlet · definition · 印刷p.64 / PDFp.86

### 2. 原文陈述

> The scheme is usually given in an alternative “velocity Verlet” form that takes a step from a given vector $\boldsymbol q_n,\boldsymbol v_n$ to $\boldsymbol q_{n+1},\boldsymbol v_{n+1}$ by the sequence of operations

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L333)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L339)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-MomentumVerlet · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> The most straightforward rewriting of the Verlet method is to put the equations and the discretization in Hamiltonian form, i.e. introducing momenta $\boldsymbol p=M\boldsymbol v$, and thus $\boldsymbol p_n=M\boldsymbol v_n$, which results in the flow map approximation (taking us from any point in phase space $(\boldsymbol q,\boldsymbol p)$ to a new point $(\boldsymbol Q,\boldsymbol P)$):

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L346)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-Leapfrog · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> Returning to (2.5)–(2.7), write out the formulas for two successive steps ($(\boldsymbol q_{n-1},\boldsymbol v_{n-1})\mapsto(\boldsymbol q_n,\boldsymbol v_n)$ and $(\boldsymbol q_n,\boldsymbol v_n)\mapsto(\boldsymbol q_{n+1},\boldsymbol v_{n+1})$) and note that, from

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L351)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-LeapfrogInit · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> It is necessary to define an initialization procedure for $\boldsymbol v_{-1/2}$:

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L356)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.2-LeapfrogReconstruct · definition · 印刷p.65 / PDFp.87

### 2. 原文陈述

> And it is also necessary to use, at any subsequent step,

$$
\boldsymbol v_n=\boldsymbol v_{n-1/2}+(h/2)M^{-1}F_n,
$$


> if $\boldsymbol q_n,\boldsymbol v_n$ are both needed, e.g. for the evaluation of the energy or other velocity-dependent observable.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L360)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L364)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-Consistency · definition · 印刷p.66–67 / PDFp.88–89

### 2. 原文陈述

> The first assumption is that $\mathscr G_h$ is an $O(h^{p+1})$ approximation of $\mathscr F_h$ in the sense that there is a constant $K\ge0$ and a constant $\Delta>0$ such that, for $t\in[0,\tau]$, we have

$$
\|\mathscr F_h(\boldsymbol z(t))-\mathscr G_h(\boldsymbol z(t))\|\le\bar K h^{p+1},\qquad h<\Delta.\tag{2.10}
$$


> The assumption (2.10) that the local error is of order $p+1$, $p>0$, is termed the consistency of the numerical method. We say the method is consistent of order $p$.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L374)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-Stability · definition · 印刷p.66–67 / PDFp.88–89

### 2. 原文陈述

> To tackle the question of the growth of local error, we still must make an important assumption on $\mathcal G_h$, namely that it satisfies a Lipschitz condition of the form

$$
\|\mathcal G_h(\boldsymbol u)-\mathcal G_h(\boldsymbol w)\|\le(1+hL)\|\boldsymbol u-\boldsymbol w\|,\qquad\boldsymbol u,\boldsymbol w\in\mathcal D;\ h\le\Delta.\tag{2.11}
$$


> The assumption (2.11) that the method does not increase the separation between two nearby trajectories by more than a factor of the form $1+hL$ in each step is referred to as the stability of the method.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L386)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorRecursion · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> then take norms and use the triangle inequality and (2.10), (2.11) to get the following recurrent inequality for the error $\epsilon_n=\|\boldsymbol z_n-\boldsymbol z(t_n)\|$:

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L392)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ErrorBound · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> From this, the bound

$$
\epsilon_n\le\frac{\bar K}{L}e^{Lnh}h^p,\qquad n=0,1,\ldots,\nu,\tag{2.12}
$$


> follows by a straightforward calculation, for $h\le\Delta$.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L408)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ConsistencyConvergence · unnumbered_claim · 印刷p.67 / PDFp.89

### 2. 原文陈述

> This result shows that a method which is consistent of order $p$ and stable is convergent of order $p$.

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L436)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ScalarVerlet · Example 2.2 (map) · 印刷p.67 / PDFp.89

### 2. 原文陈述

> In this example, assume a single degree of freedom system, i.e. $q,p\in\mathbb R$, and take $M=1$. The Verlet method can be written in the form of a map, as in (2.8), or, in slightly more detail, as

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
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L482)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletExpansion · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> Combining terms of like powers of $h$, we have

$$
P=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{4}[F'F+p^2F'']+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletExpansion :
  ∀ (F : ℝ → ℝ) q p, ContDiff ℝ 3 F →
    Asymptotics.IsBigO (𝓝 0)
      (fun h => (scalarVerlet F h (q,p)).2 -
        (p+h*F q+h^2/2*p*deriv F q+h^3/4*(deriv F q*F q+p^2*deriv (deriv F) q)))
      (fun h : ℝ => h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletExpansion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F C³，使O(h⁴)余项有实际意义。 | [EXTRA] |

[EXTRA] F C³，使O(h⁴)余项有实际意义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；展开scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2。F C³足以在固定q,p处产生O(h⁴)动量余项；所减多项式逐项为p+hF+(h²/2)pF′+(h³/4)(F′F+p²F″)，系数、求导点和双侧h→0均正确。不把邻近页位置误差符号疑误归到本条动量公式。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletExpansion`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L488)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-ExactExpansion · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> Since $\dot q=p$, we have $\ddot q=\dot p=F(q)$, and the third derivative is $q^{(3)}=F'(q)p$. On the other hand $\dot p=F(q)$ implies that $\ddot p=F'(q)\dot q=pF'$, and thus

$$
p^{(3)}=p^2F''+F'F.
$$


> The Taylor expansion of the solution is (taking $q(t)=q$, $p(t)=p$):

$$
q(t+h)=q+hp+\frac{h^2}{2}F+\frac{h^3}{6}F'p+O(h^4),
$$



$$
p(t+h)=p+hF+\frac{h^2}{2}pF'+\frac{h^3}{6}[p^2F''+F'F]+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactExpansion :
  ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).1 -
      ((γ 0).1+h*(γ 0).2+h^2/2*F (γ 0).1+h^3/6*deriv F (γ 0).1*(γ 0).2)) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (γ h).2 -
      ((γ 0).2+h*F (γ 0).1+h^2/2*(γ 0).2*deriv F (γ 0).1+
        h^3/6*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))) (fun h : ℝ => h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.exactExpansion` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。 | [EXTRA] |

[EXTRA] F C³及实际标量Hamilton轨迹；以t=0归一时间原点，不改变自治系统陈述。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；F C³、全时实际轨迹γ且γ′=(p,F(q))；在t=0处同时给出位置和动量的三阶Taylor多项式，余项均为双侧O(h⁴)。位置三阶项F′p/6，动量三阶项(p²F″+F′F)/6，全部导数在初始q上取值。原文先写的q″、q⁽³⁾、p″、p⁽³⁾为展开的链式法则推导，已由同一实际ODE与正则性支持，并未改为任意指定Taylor系数。时间原点平移资格已披露。

### 7. 状态与证明位置

incomplete；`MD.Ch02.exactExpansion`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L498)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-DefectPrinted · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> We now examine the series expansions for the exact and Verlet solutions and find that these differ in the third (and higher) order terms.

$$
Q-q(t+h)=\frac{h^3}{6}F'p+O(h^4),
$$


> and

$$
P-p(t+h)=\frac{h^3}{12}[p^2F''+F'F]+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem defectPrinted : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1-
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
  sorry



/-- 修正版，对应原文 MD-2.2.3-DefectPrinted。改动：位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。 -/
```

独立修正版：

```lean
theorem defectPrinted_corrected : ∀ (F : ℝ → ℝ) (γ : ℝ → ℝ × ℝ), ContDiff ℝ 3 F →
    (∀ t, HasDerivAt γ ((γ t).2,F (γ t).1) t) →
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).1-(γ h).1+
      h^3/6*deriv F (γ 0).1*(γ 0).2) (fun h : ℝ => h^4) ∧
    Asymptotics.IsBigO (𝓝 0) (fun h => (scalarVerlet F h (γ 0)).2-(γ h).2-
      h^3/12*((γ 0).2^2*deriv (deriv F) (γ 0).1+deriv F (γ 0).1*F (γ 0).1))
      (fun h : ℝ => h^4) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.defectPrinted`；`MD.Ch02.defectPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际轨迹、F C³；t=0归一。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。 | [EXTRA] |

[EXTRA] 实际轨迹、F C³；t=0归一。；[ERRATUM?] 位置残差改加h³F′p/6，动量三阶残差保持原样；不证明原印反号式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt:3026–3028，MolecularDynamics/Chapter02/Statements.lean 的正式 scalarVerlet：Q=q+hp+h²F(q)/2，P=p+h(F(q)+F(Q))/2，确与教材算法对应。Ch02.lean:386–392 的对象、量词、C³ 及实际标量轨迹假设与原印一致；两个残差也字面保留原印正号。然而正式定义给 Q−q(h)=−h³F′p/6+O(h⁴)，故位置残差中再减 h³F′p/6 不成立。动量三阶缺陷 (p²F″+F′F)/12 正确。原印的字面忠实与命题的数学错误须区分：本条 FAIL 是确认原书错误已被写成假定理；[ERRATUM?] 成立，不是翻译错号。依赖内另有 verletDefectExpansion\_statement（3043–3048）明确采用修正符号，但本次判断来自展开计算，而非仅凭该名字。[EXTRA] C³、实际轨迹及自治时间平移合理，全轴条件强于必要。本声明体为 sorry；该事实独立于数学反例。

### 7. 状态与证明位置

incomplete；`MD.Ch02.defectPrinted`：未证（原书疑误不证）；`MD.Ch02.defectPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L512)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletConsistency · unnumbered_claim · 印刷p.68 / PDFp.90

### 2. 原文陈述

> These relations can be summarized as telling us that

$$
\|\mathscr G_h(\boldsymbol z)-\mathscr F_h(\boldsymbol z)\|=\kappa(\boldsymbol z)h^3+O(h^4),
$$


> where $\kappa(\boldsymbol z)=\kappa(q,p)$ is a function of the position and momentum. We may then define

$$
\bar K=\max_{t\in[0,\tau]}\kappa(\boldsymbol z(t))
$$


> bounding the local error by (with neglect of the fourth order terms) $\bar K h^3$. Thus the Verlet method is consistent of order two.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletConsistency : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
  sorry



/-- 修正版，对应原文 MD-2.2.3-VerletConsistency。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem verletConsistency_corrected : ∀ (F : ℝ → ℝ) (Φ : ℝ → (ℝ × ℝ) → (ℝ × ℝ))
    (γ : ℝ → ℝ × ℝ) τ δ,
    0 < τ → 0 < δ → ContDiff ℝ 3 F → ContinuousOn γ (Icc 0 τ) →
    (∀ z, Φ 0 z=z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun s => Φ s z) ((Φ t z).2,F (Φ t z).1) t) →
    (∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ, γ (t+h)=Φ h (γ t)) →
    ∃ κ : ℝ × ℝ → ℝ, ContinuousOn κ (Set.range γ) ∧
      (∀ z ∈ Set.range γ, 0 ≤ κ z ∧ Asymptotics.IsBigO (𝓝[>] 0)
        (fun h => ‖scalarVerlet F h z-Φ h z‖-κ z*h^3) (fun h : ℝ => h^4)) ∧
      (∃ K ≥ 0, (∀ t ∈ Icc 0 τ, κ (γ t) ≤ K) ∧
        (∃ t ∈ Icc 0 τ, κ (γ t)=K)) ∧
      (∃ C ≥ 0, ∃ δ₀ > 0, ∀ t ∈ Icc 0 τ, ∀ h ∈ Ioo 0 δ₀,
        ‖scalarVerlet F h (γ t)-Φ h (γ t)‖ ≤ C*h^3) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletConsistency`；`MD.Ch02.verletConsistency_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 实际标量M=1流、F C³、正时间窗和连续紧轨迹；O余项在h→0+解释；严格界C允许吸收余项，不宣称C=maxκ。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；检查全部量词与四部分结论：F C³、τ和δ正、γ在闭窗连续；Φ从每个z出发在统一局部时间窗满足实际ODE且Φ₀z=z；γ与Φ在所需正步长内一致。κ在range γ上连续非负并逐z给正侧h→0的h³主项及O(h⁴)；闭窗上存在真正达到的最大值K；另有统一C、δ₀使闭窗全部t的局部误差≤Ch³。正侧避免|h|³与h³混淆，C吸收余项而不强称C=max κ。该严格修正版合理，但来源忽略余项的界仍需人工确认。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletConsistency`：未证（原书疑误不证）；`MD.Ch02.verletConsistency_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L541)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.3-VerletStability · unnumbered_claim · 印刷p.68–69 / PDFp.90–91

### 2. 原文陈述

> To complete the convergence proof for Verlet’s method, we would still need to verify the second assumption. This requires the assumption that the force field $F$ satisfy a Lipschitz condition:

$$
\|F(\boldsymbol u)-F(\boldsymbol w)\|\le\hat L\|\boldsymbol u-\boldsymbol w\|\tag{2.15}
$$


> for all $\boldsymbol u,\boldsymbol w$. Generally speaking this could be taken to hold in a neighborhood of the solution where all approximate solutions for $h<\bar h$ are assumed to lie. With a bit of effort, it is then possible to demonstrate the stability condition for the numerical method (see Exercise 4).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletStability :
  ∀ n (m : Fin n → ℝ) (F : Q n → Q n) L δ,
    positiveMass m → 0 ≤ L → 0 < δ →
    (∀ u w, ‖F u-F w‖ ≤ L*‖u-w‖) →
    ∃ C ≥ 0, ∀ h ∈ Icc 0 δ, ∀ z w : Z n,
      ‖verlet m F h z-verlet m F h w‖ ≤ (1+h*C)*‖z-w‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletStability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。 | [EXTRA] |

[EXTRA] 全空间Lipschitz力（覆盖原文for all u,w版本）、固定正质量，步长窗口δ>0；稳定常数可依赖δ、质量、L。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐字核对印刷68页末段、式(2.15)和69页续段，一致。全空间力F的Lipschitz条件、正质量、L≥0、δ>0均在前提；C在h之前存在，故同一C适用于[0,δ]全部步长及全部相点z,w。Q是有限维坐标空间的上确界范数，Z是乘积最大范数；verlet确为含逆质量的速度Verlet位置/动量更新。更新为恒等映射加O(h)的全局Lipschitz扰动，有限步长窗吸收h²、h³项，因子1+hC合理。采用全空间版本而非局部邻域版本已明确披露，且h=0结论为恒等式。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.verletStability`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L580)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-FirstIntegral · definition · 印刷p.70 / PDFp.92

### 2. 原文陈述

> Recall that the condition for a given function $I:\mathbb R^m\to\mathbb R$ to be a first integral is that

$$
\nabla I(\boldsymbol z)\cdot f(\boldsymbol z)=\sum_{j=1}^m\frac{\partial I}{\partial z_j}(\boldsymbol z)f_j(\boldsymbol z)\equiv 0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_firstIntegral {n : ℕ} (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) : Prop :=
  IsOpen D ∧ DifferentiableOn ℝ I D ∧ ∀ z ∈ D, (fderiv ℝ I z) (f z) = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_firstIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。 | [EXTRA] |

[EXTRA] [EXTRA] 签名显式开放域与I在D经典可微；不再由不可微处fderiv=0总化值冒充守恒条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原句、梯度点积、求和指标j=1,…,m及恒零号逐字一致。n为任意自然数，I:Q n→ℝ、f:Q n→Q n，D为开放域。谓词同时要求IsOpen D、I在D可微，以及每个z∈D的真实导数作用于f(z)为0；在开放域可微保证fderiv是经典导数，与原坐标求和相同。开放域是原文下一句明许的范围；未把不可微点总化导数为零误当条件。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_firstIntegral`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L590)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralPreserved · unnumbered_claim · 印刷p.70 / PDFp.92

### 2. 原文陈述

> It is important in this definition that this is an equivalence that holds everywhere (or at least in some open set in $\mathbb R^m$), so the statement is not just that $I(\boldsymbol z(t))=I(\boldsymbol z(0))$ for some particular trajectory, but, moreover, $I$ is conserved for all nearby initial conditions. The flow map preserves the first integral, thus $I(\mathcal F_t(\boldsymbol z))\equiv I(\boldsymbol z)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem firstIntegralPreserved :
  ∀ n (I : Q n → ℝ) (f : Q n → Q n) (D : Set (Q n)) (γ : ℝ → Q n) a b,
    a ≤ b → DifferentiableOn ℝ I D → IsOpen D → firstIntegral I f D →
    MapsTo γ (Icc a b) D → solution f γ a b → ∀ t ∈ Icc a b, I (γ t) = I (γ a) := by
  intro n I f D γ a b hab hI hD hfirst hγD hγ
  have hd : ∀ t ∈ Icc a b, HasDerivWithinAt (fun s => I (γ s)) 0 (Icc a b) t := by
    intro t ht
    have hIt : DifferentiableAt ℝ I (γ t) :=
      (hI (γ t) (hγD ht)).differentiableAt (hD.mem_nhds (hγD ht))
    have hc : HasDerivWithinAt (fun s => I (γ s))
        ((fderiv ℝ I (γ t)) (f (γ t))) (Icc a b) t :=
      hIt.hasFDerivAt.comp_hasDerivWithinAt t (hγ t ht)
    rw [hfirst (γ t) (hγD ht)] at hc
    exact hc
  apply constant_of_has_deriv_right_zero (fun t ht => (hd t ht).continuousWithinAt)
  intro t ht
  exact (hd t (mem_Icc_of_Ico ht)).mono_of_mem_nhdsWithin (Icc_mem_nhdsGE_of_mem ht)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.firstIntegralPreserved` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。 | [EXTRA] |

[EXTRA] 开放D、可微I、实际解留域及闭时间窗a≤b；包含端点。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷70页从It is important到I(F\_t(z))≡I(z)的原文、括号及所有初始条件措辞一致。量化任意n,I,f,D,γ,a,b，要求a≤b、I可微、D开放、firstIntegral逐点为零、γ在整个闭窗留域并满足真实ODE。结论对全部t∈[a,b]为I(γ(t))=I(γ(a))。任意γ的全称量化覆盖任意初始条件；a替代0为时间平移推广。a=b退化窗结论仍正确，端点没有遗漏。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.firstIntegralPreserved`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L595)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-EnergyPreserved · unnumbered_claim · 印刷p.70 / PDFp.92

### 2. 原文陈述

> For example, in a Hamiltonian system, the flow map conserves the energy:

$$
H\circ\mathcal F_t=H.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyPreserved (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.energyPreserved` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。 | [EXTRA] |

[EXTRA] 实际Hamilton轨迹，H在轨道点可微，闭时间窗；现有第3章库仅作已证依赖复用，不开展第3章任务。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Ch02\_deps.txt:33 的 SymplecticCoordinates Nc=(Fin Nc⊕Fin Nc)→ℝ；:41 的 textbookJ=fromBlocks 0 1 (-1) 0；:1921 的 textbookHamiltonianVectorField H z=J*ᵥ(fun i=>(fderiv ℝ H z)(Pi.single i 1))。依次为 (q,p) 坐标，基向量导数为 (H\_q,H\_p)，场为 (H\_p,−H\_q)，并非依名称推测。故 dH(场)=Σ(H\_q H\_p−H\_p H\_q)=0。任意 H、γ、τ，在轨道全部窗内点 H 可微及 γ 满足该场的实际闭窗ODE关系后，全部 t 得 H(γ t)=H(γ 0)，完整表达 H∘流=H。[EXTRA] 轨道可微和实际解是合理资格，未假定能量守恒；τ<0 空窗，τ=0 平凡。已读取 :2728 起复用定理的同一签名及链式求导论证。Ch02 正文调用库定理、无直接 sorry；不据此认证证明工程。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.energyPreserved`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L615)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-AngularMomentum · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> There may, in specific instances, be additional first integrals present. For example, in a planar 2-body system in central forces, the angular momentum $xp_y-yp_x=l$ is a conserved quantity, thus $l\circ\mathcal F_t=l$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem centralAngularMomentum :
  ∀ (ρ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ × ℝ × ℝ) a b,
    a < b → (∀ t ∈ Icc a b, HasDerivWithinAt γ
      ((γ t).2.2.1,(γ t).2.2.2,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).1,
        ρ ((γ t).1^2+(γ t).2.1^2)*(γ t).2.1) (Icc a b) t) →
    ∀ t ∈ Icc a b, (γ t).1*(γ t).2.2.2-(γ t).2.1*(γ t).2.2.1 =
      (γ a).1*(γ a).2.2.2-(γ a).2.1*(γ a).2.2.1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.centralAngularMomentum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。 | [EXTRA] |

[EXTRA] 中心力写ρ(x²+y²)(x,y)，单位约化质量、实际ODE轨迹，a<b；正质量模型可缩放。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已重读实际声明。右结合 ℝ×ℝ×ℝ×ℝ 为 (x,y,p\_x,p\_y)，全部投影和导数元组展开为 x′=p\_x、y′=p\_y、p\_x′=ρ(x²+y²)x、p\_y′=ρ(x²+y²)y。任意ρ、实际γ及 a<b，全部闭窗时间守恒 xp\_y−yp\_x；导数为 p\_x p\_y+xρy−p\_y p\_x−yρx=0。中心力相对坐标和单位约化质量是合理模型资格，固定正约化质量版本同样抵消动量交叉项，可通过单位选择对应；a<b 排除仅需平凡处理的退化窗。未宣称存在解，故不必为给定的实际可微解另加ρ正则性。[EXTRA] 合理，无 ERRATUM 标记。正文有直接 sorry，证明未完成与签名 PASS 分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.centralAngularMomentum`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L625)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralMeanValue · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> Now if $I:\mathbb R^m\to\mathbb R$ has continuous partial derivatives, we may conclude directly that

$$
I(\boldsymbol a)=I(\boldsymbol b)+\nabla I(\boldsymbol z_*)\cdot(\boldsymbol a-\boldsymbol b),
$$


> where $\boldsymbol z_*$ is a point on the line in $\mathbb R^m$ connecting $\boldsymbol a$ to $\boldsymbol b$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem integralMeanValue :
  ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b = (fderiv ℝ I c) (a-b) := by
  intro n I D a b hD hs hI
  have hd : ∀ x ∈ segment ℝ a b, HasFDerivWithinAt I (fderiv ℝ I x) (segment ℝ a b) x := by
    intro x hx
    exact ((hI.differentiableOn (by norm_num) x (hs hx)).differentiableAt (hD.mem_nhds (hs hx))).hasFDerivAt.hasFDerivWithinAt
  obtain ⟨c,hc,heq⟩ := domain_mvt hd (convex_segment a b)
    (right_mem_segment ℝ a b) (left_mem_segment ℝ a b)
  refine ⟨c, ?_, heq⟩
  rw [segment_symm] at hc
  exact hc
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.integralMeanValue` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。 | [EXTRA] |

[EXTRA] 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际对象为 EuclideanSpace ℝ (Fin n)，即带欧氏内积的有限坐标空间，未使用 Q 的 Pi 最大范数。对所有 n,I,D,a,b，先假设开放D、整段 segment ℝ a b⊆D、ContDiffOn ℝ 1 I D（C¹），再存在 c∈segment，满足 I a−I b=(fderiv ℝ I c)(a−b)。在可微点该连续线性泛函作用就是 Σ∂ᵢI(c)(aᵢ−bᵢ)，故对象、量词顺序、同一见证及精确差值等式均忠实。闭线段是端点凸组合 {(1−s)a+s b:0≤s≤1}；a=b 亦有见证。[EXTRA] 局部开放域含整段是均值定理合理资格，D=univ 恢复原文全空间C¹假设；没有人为加强结论或偷添误差前提。正文无直接 sorry，不认证证明编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.integralMeanValue`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L637)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralLipschitz · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> Hence

$$
|I(\boldsymbol a)-I(\boldsymbol b)|\le\|\nabla I(\boldsymbol z_*)\|\|\boldsymbol a-\boldsymbol b\|.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem integralPointwiseBound : ∀ n (I : EuclideanSpace ℝ (Fin n) → ℝ) (D : Set (EuclideanSpace ℝ (Fin n))) a b,
    IsOpen D → segment ℝ a b ⊆ D → ContDiffOn ℝ 1 I D →
    ∃ c ∈ segment ℝ a b, I a-I b=(fderiv ℝ I c) (a-b) ∧
      |I a-I b| ≤ ‖fderiv ℝ I c‖*‖a-b‖ := by
  intro n I D a b hD hs hI
  obtain ⟨c,hc,heq⟩ := integralMeanValue n I D a b hD hs hI
  refine ⟨c,hc,heq,?_⟩
  rw [heq, ← Real.norm_eq_abs]
  exact (fderiv ℝ I c).le_opNorm (a-b)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.integralPointwiseBound` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。 | [EXTRA] |

[EXTRA] 实际EuclideanSpace ℝ (Fin n)，开放域含线段及C¹；实Fréchet算子范数等于Euclidean梯度范数。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷71页Hence及不等式的绝对值、梯度范数和a−b次序一致。采用实际EuclideanSpace而非Pi最大范数；D开放、包含闭线段且I在D为C¹。存在同一个c在线段上，既满足均值等式I(a)−I(b)=DI(c)(a−b)，又满足所需点态上界。在实Euclidean空间标量泛函的算子范数就是梯度的Euclidean范数；没有换成其他点或擅加统一梯度界。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.integralPointwiseBound`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L653)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralErrorPrinted · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> This means if we know that $\|\nabla I(\boldsymbol z)\|$ remains bounded, say less than $B$, in an open domain containing the solution, we could conclude that the error in $I$-values computed along a numerical trajectory is of order $h^p$,

$$
|I(\boldsymbol z(t_n))-I(\boldsymbol z_n)|\le\frac{\bar K B}{2L}e^{nLh}h^p,\qquad h<\bar h,\tag{2.16}
$$


> with the same assumptions as are needed to characterize the convergence of the method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem integralErrorPrinted :
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/(2*L))*Real.exp (L*k*h)*h^p := by
  sorry



/-- 修正版，对应原文 MD-2.2.4-IntegralErrorPrinted。改动：由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。 -/
```

独立修正版：

```lean
theorem integralErrorPrinted_corrected :
  ∀ n (I : Q n → ℝ) (D : Set (Q n)) B K L h (p k : ℕ) (a b : Q n),
    0 ≤ B → 0 ≤ K → 0 < L → 0 ≤ h → IsOpen D → segment ℝ a b ⊆ D →
    ContDiffOn ℝ 1 I D → (∀ z ∈ D, ‖fderiv ℝ I z‖ ≤ B) →
    ‖a-b‖ ≤ (K/L)*Real.exp (L*k*h)*h^p →
    |I a-I b| ≤ (K*B/L)*Real.exp (L*k*h)*h^p := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.integralErrorPrinted`；`MD.Ch02.integralErrorPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。 | [EXTRA] |

[EXTRA] 域含连接线段，B,K≥0及L>0；用原文先前轨迹误差界，不把待证积分误差作前提。；[ERRATUM?] 由给定点误差只推出KB/L，去掉不成立的因子1/2，不加倍K也不预设待证积分误差。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；展开 Q n=Fin n→ℝ（Ch02\_deps.txt:2816），因此 n=1 的范数为绝对值、坐标评价的 Fréchet 导数算子范数为1。任意 n,I,D,B,K,L,h,p,k,a,b，在正性、开放域含整段、C¹、域内导数算子范数≤B 和先前点误差≤(K/L)exp(Lkh)h^p 后，结论要求 (KB/(2L))exp(Lkh)h^p。这一1/2无法由这些假设推出，以下反例完全落实到实际 Q。B,K≥0、L>0、h≥0、整段留域及C¹均合理，但不能产生额外1/2；以任意点替代实际轨迹也是更强的断言，且签名未显式保留 h<hbar 的窗口。[ERRATUM?] 对固定同一 K 的推导缺口成立；本审计不把它扩大为对教材所有可能常数约定的裁定。Q 的 Pi 范数在 n>1 时不是欧氏范数，导数算子范数界应明确为相应对偶范数或改用 EuclideanSpace。正文有 sorry，FAIL 与此独立。

### 7. 状态与证明位置

incomplete；`MD.Ch02.integralErrorPrinted`：未证（原书疑误不证）；`MD.Ch02.integralErrorPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L667)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-Divergence · definition · 印刷p.72 / PDFp.94

### 2. 原文陈述

> the divergence of $f$ vanishes, i.e.

$$
\nabla\cdot f=\sum_{i=1}^m\frac{\partial f_i}{\partial z_i}=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_divergence {n : ℕ} (f : Q n → Q n) (z : Q n) : ℝ := (textbookCoordinateJacobian f z).trace

def divergenceFree {n : ℕ} (f : Q n → Q n) : Prop :=
  Differentiable ℝ f ∧ ∀ z, bp_divergence f z = 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_divergence`；`MD.Ch02.divergenceFree` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。 | [EXTRA] |

[EXTRA] [EXTRA] 保留散度辅助定义，并补经典可微向量场的散度恒零谓词；覆盖原句零条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原文散度消失句及从i=1到m的对角偏导和为零一致。bp\_divergence是实际Fréchet导数坐标矩阵的trace；divergenceFree补充全局可微并对所有z要求trace=0，覆盖原句完整零条件。bp\_divergence作为辅助函数未单独声明可微，但组合谓词提供资格。context\_notation所称f C¹强于实际Differentiable，已在修正JSON中改为可微。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_divergence`：定义；`MD.Ch02.divergenceFree`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L692)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-Liouville · Liouville’s theorem · 印刷p.72 / PDFp.94

### 2. 原文陈述

> Consider a set of points $S(t)$ in phase space with evolution associated to a differential equation $\dot{\boldsymbol z}=f(\boldsymbol z)$ described by the flow map $\mathcal F_t(S(0))=S(t)$. Liouville’s theorem [16] states that the volume of such a set is invariant with respect to $t$ if the divergence of $f$ vanishes, i.e.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouville
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set ((Fin n) → ℝ)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.liouville` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。 | [EXTRA] |

[EXTRA] [EXTRA]实际解族Φ联合C²（原文未重复此较强正则性）；f C¹、Φ0=id、τ>0及实际时间ODE；只对可测S表达Lebesgue体积。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原文描述S(t)=F\_t(S(0))、Liouville定理[16]及体积不变措辞一致；末尾原页为vanishes, i.e.，当前摘录截去i.e.而未标明省略，修正JSON补回，散度展示式仍归相邻条目。Lean对任意维数、C¹向量场f、处处trace=0、联合C²实际解族Φ、Φ(0,·)=id、t∈[0,τ]和任意可测s断言真实Lebesgue像集体积相等。C¹给局部唯一性，实际流在该时间窗单射，未用体积结论作为前提。签名没有0<τ；τ<0时无t可取，τ=0时由恒等初值成立。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.liouville`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L699)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-HamiltonDivergence · unnumbered_claim · 印刷p.72 / PDFp.94

### 2. 原文陈述

> It is a simple exercise to show that for a Hamiltonian system the divergence vanishes, since

$$
\nabla\cdot f=\sum_{i=1}^{N_c}\frac{\partial^2 H}{\partial q_i\partial p_i}-\sum_{i=1}^{N_c}\frac{\partial^2 H}{\partial p_i\partial q_i}=0,
$$


> by equality of mixed partials.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H C²，保证混合偏导对称。 | [EXTRA] |

[EXTRA] H C²，保证混合偏导对称。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；SymplecticForm.lean 展开 SymplecticCoordinates Nc=(Fin Nc⊕Fin Nc)→ℝ，前一组为 q，后一组为 p；textbookJ=fromBlocks 0 1 (-1) 0。SplittingError.lean 的 textbookHamiltonianVectorField H z=J·(i↦DH(z)e\_i)，因此分量恰为 (∂pH,−∂qH)。SymplecticMaps.lean 的 textbookJacobian 是实际 fderiv 的标准坐标矩阵。逐项取迹即 ∑ᵢ∂qᵢ∂pᵢH−∑ᵢ∂pᵢ∂qᵢH；点态 ContDiffAt ℝ 2 H z 保证混合偏导交换，故零迹覆盖原句最终断言，展示的计算链是该展开与混合偏导对称的推导。H、z 任意；C² 是合理充分资格而非最弱必要条件。HamiltonianVariational.lean 的 textbookHamiltonianHessian 使用真实二阶 fderiv，HamiltonianVolume.lean 的零散度定理据此证明该结论。本声明调用库定理、无直接 sorry；未运行编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonDivergence`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L711)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-HamiltonVolume · unnumbered_claim · 印刷p.72 / PDFp.94

### 2. 原文陈述

> Thus Hamiltonian systems always have volume preserving flows.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonVolume {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (t : ℝ) (ht : t ∈ Icc 0 τ)
    (s : Set (SymplecticCoordinates Nc)) (hs : MeasurableSet s) :
    volume ((fun z => Φ (t, z)) '' s) = volume s := by
  apply MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonVolume` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。 | [EXTRA] |

[EXTRA] [EXTRA]Φ联合C²；H C²、Φ0=id，τ>0；可测集S。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原文Thus Hamiltonian systems always have volume preserving flows.逐字一致。任意Nc和H:C^{2}，坐标为q/p两个Fin Nc块，J=[[0,I],[-I,0]]；向量场J∇H的符号与教材相同。Φ联合C²、在[0,τ]满足实际ODE且Φ0=id，对每个窗内t和每个可测s给出Lebesgue像集体积相等。没有额外假设散度零或体积守恒；前者由Hamilton结构产生。签名没有τ>0，需修正说明。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonVolume`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L719)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-VolumeChange · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> If we view the map $\mathcal F_t$ as a change of variables, we have

$$
\operatorname{Vol}(S(t))=\int_S |D|\,d\omega,
$$


> where $D=\det\left(\frac{\partial\mathcal F_t}{\partial\boldsymbol z}\right)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem volumeChange :
  ∀ n (Φ : Q n → Q n) (S : Set (Q n)), ContDiff ℝ 1 Φ → Function.Injective Φ → MeasurableSet S →
    volume (Φ '' S) = ∫⁻ z in S, ENNReal.ofReal |(textbookCoordinateJacobian Φ z).det| ∂volume := by
  intro n Φ S hΦ hinj hS
  have hd : ∀ z ∈ S, HasFDerivWithinAt Φ (fderiv ℝ Φ z) S z := by
    intro z hz
    exact (hΦ.differentiable_one z).hasFDerivAt.hasFDerivWithinAt
  have hcv := lintegral_abs_det_fderiv_eq_addHaar_image
    (volume : Measure (Q n)) hS hd hinj.injOn
  have heq : ∀ z, (fderiv ℝ Φ z).det=(textbookCoordinateJacobian Φ z).det := by
    intro z
    change LinearMap.det (fderiv ℝ Φ z).toLinearMap=_
    rw [← LinearMap.det_toMatrix']
    rfl
  simpa only [heq] using hcv.symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.volumeChange` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。 | [EXTRA] |

[EXTRA] Φ C¹单射，可测S；正则流的固定时刻映射具备这些资格；真实Lebesgue体积和lintegral。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Q n=Fin n→ℝ，textbookCoordinateJacobian Φ z=toMatrix' (fderiv ℝ Φ z).toLinearMap，所以 det 是实际空间导数的行列式。量词为任意 n、映射 Φ、集合 S，在 Φ C¹、全局单射、S 可测的资格下，像集 Lebesgue 体积等于 S 上 |det DΦ| 的非负 lintegral；ENNReal.ofReal 将非负实绝对值转为扩展非负实数，故覆盖无限体积。固定时刻流映射可代入；全局单射强于仅在 S 上单射，但合理地避免多重覆盖，C¹ 和可测性是明确充分资格。证明体通过 det\_toMatrix' 对接实际换元公式，无直接 sorry；本次未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch02.volumeChange`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L732)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-VariationalPrinted · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> To understand where Liouville’s theorem comes from, recall that the variational equations of the last chapter are a system of ordinary differential equations for $W(t)=\mathcal F_t'(\boldsymbol z(t))$:

$$
\frac{\mathrm dW}{\mathrm dt}=f'(\boldsymbol z(t))W.
$$


> Thus

$$
\dot W W^{-1}=f'(\boldsymbol z(t)).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem variationalPrinted : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) (Φ (s,ζ))) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) (Φ (t,ζ)))⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ)) := by
  sorry



/-- 修正版，对应原文 MD-2.3.1-VariationalPrinted。改动：Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。 -/
```

独立修正版：

```lean
theorem variationalPrinted_corrected : ∀ n (f : Q n → Q n) (Φ : ℝ × Q n → Q n) τ ζ,
    flowC1 f Φ τ → ContDiff ℝ 2 Φ →
    (∀ t ∈ Ioo 0 τ, (textbookCoordinateJacobian (fun y => Φ (t,y)) ζ).det ≠ 0) → ∀ t ∈ Ioo 0 τ,
    HasDerivAt (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) ζ)
      (textbookCoordinateJacobian f (Φ (t,ζ)) *
        textbookCoordinateJacobian (fun y => Φ (t,y)) ζ) t ∧
    (deriv (fun s => textbookCoordinateJacobian (fun y => Φ (s,y)) ζ) t) *
      (textbookCoordinateJacobian (fun y => Φ (t,y)) ζ)⁻¹ =
      textbookCoordinateJacobian f (Φ (t,ζ)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.variationalPrinted`；`MD.Ch02.variationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。 | [EXTRA] |

[EXTRA] [ERRATUM?] Jacobian在固定初值ζ求值；联合C²及变分矩阵非奇异作为显式充分资格，Df仍在真实轨道点求值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已实际展开 Statements.lean 的 flowC1：f C¹、Φ 联合 C¹、∀z Φ(0,z)=z、∀t∈[0,τ]∀z 时间导数为 f(Φ(t,z))；没有把待证变分公式作为前提。Q 与 Jacobian 为真实有限实坐标空间与真实空间导数。签名忠实保留原书移动取值点 W(t)=D\_yΦ(t,Φ(t,ζ))，同时要求 W′=Df(Φ(t,ζ))W 及 W′W⁻¹=Df(Φ(t,ζ))。这两条一般均错误；移动点的链式项和 Df 的取值点均不能省略。以下全实线 C∞ 完整流满足所有前提且 W 可逆，排除了正则性不足或域问题，确证 ERRATUM? 成立。正确变分矩阵应取固定初值 D\_yΦ(t,ζ)。原签名只有联合 C¹，也未显式登记空间导数关于时间可微的更强充分资格；修正时可用联合 C²。当前证明体是 sorry，但 FAIL 来源于反例而非 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch02.variationalPrinted`：未证（原书疑误不证）；`MD.Ch02.variationalPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L751)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-DeterminantODE · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> Now let $D=\det(W)$. One can show (see Exercise 5) that

$$
\frac{\dot D}{D}=\operatorname{tr}(\dot W W^{-1}).
$$


> This implies that

$$
\dot D=\operatorname{div}(f(\boldsymbol z(t)))D,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem determinantODE : ∀ n (A W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    HasDerivAt W (A t * W t) t → (W t).det ≠ 0 →
    HasDerivAt (fun s => (W s).det) ((A t).trace*(W t).det) t ∧
      deriv (fun s => (W s).det) t/(W t).det =
        Matrix.trace ((A t*W t)*(W t)⁻¹) := by
  intro n A W t hW hdet
  have hd := MolecularDynamics.textbookMatrixDet_hasDerivAt_of_linearODE W (A t) t hW
  refine ⟨hd,?_⟩
  rw [hd.deriv, mul_div_cancel_right₀ _ hdet, Matrix.mul_assoc,
    Matrix.mul_nonsing_inv _ (isUnit_iff_ne_zero.mpr hdet), Matrix.mul_one]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.determinantODE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。 | [EXTRA] |

[EXTRA] 实际W′=AW且detW≠0，符合原文W⁻¹及D除法的资格；A=f′(z(t))。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷73页Now let D=det(W)、Ḋ/D=tr(ẆW⁻¹)、This implies that及最终Ḋ=div(f(z(t)))D均一致。A,W是任意n维实矩阵曲线，在指定t要求真实导数W′=A(t)W(t)且det W(t)≠0；结论同时给det曲线的HasDerivAt以及导数除det等于trace((AW)W⁻¹)。取A=f′(z(t))即为教材实例；非零行列式正好许可原文两处除法。A不被签名限定为某个f的Jacobian，是已披露的线性变分方程推广。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.determinantODE`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L781)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-DeterminantExponential · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> and thus

$$
D(t)=D(0)e^{\int_0^t\operatorname{div}(f(\boldsymbol z(s)))\,ds}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem determinantExponential :
  ∀ n (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (W : ℝ → Matrix (Fin n) (Fin n) ℝ) t,
    Continuous A → (∀ s, HasDerivAt W (A s * W s) s) →
    (W t).det = (W 0).det * Real.exp (∫ s in (0 : ℝ)..t, (A s).trace) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.determinantExponential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。 | [EXTRA] |

[EXTRA] 实际W′=AW，A连续；tr A=div f(z(s))，全实线ODE资格用于任意t积分。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；A、W 是实际实方阵路径，D(t)=det W(t)；Continuous A 与逐点全实线 HasDerivAt W (A(s)W(s)) s 给出 D′=tr(A)D。结论保留任意 t、D(0) 因子及方向积分 ∫₀ᵗtr A，没有暗设 D(0)=1、t≥0 或 detW≠0，奇异初值亦适用。以已展开的真实 textbookCoordinateJacobian f (z(s)) 代入 A，即 tr A=div f(z(s))，得到原式；此实例须自身满足资格，不由前条错误移动点公式自动获得。A 连续是合理充分条件，全实线 ODE 比单个积分区间资格强，是明确登记的全局版本；局部流须另限其存在区间。当前证明体为 sorry，与签名语义 PASS 分开，未声称证明完成或编译通过。

### 7. 状态与证明位置

incomplete；`MD.Ch02.determinantExponential`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L794)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-FlowDet · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> In particular, if $\operatorname{div}f\equiv0$, we see that $D\equiv D(0)=1$ and it follows that the volume is constant. Liouville’s theorem may be summarized compactly as:

$$
\nabla\cdot f=0\Rightarrow\det\mathcal F_t'=1.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowDet
    (f : ((Fin n) → ℝ) → (Fin n) → ℝ) (hf : ContDiff ℝ 1 f)
    (hdiv : ∀ z, (textbookCoordinateJacobian f z).trace = 0)
    (Φ : ℝ × ((Fin n) → ℝ) → (Fin n) → ℝ) (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z)) (f (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) (_hτ : 0 < τ) :
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookCoordinateJacobian (fun y => Φ (t, y)) z).det = 1 ) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (Q n), MeasurableSet S →
      volume ((fun z ↦ Φ (t,z)) '' S) = volume S) := by
  constructor
  · apply MolecularDynamics.textbookDivergenceFreeFlowJacobian_det_eq_one_of_jointC2 <;> assumption
  · exact MolecularDynamics.textbookDivergenceFreeFlow_volume_image_of_jointC2 f hf hdiv Φ hΦ τ hODE hinit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.flowDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。 | [EXTRA] |

[EXTRA] [EXTRA]Φ联合C²、f C¹、Φ0=id，τ>0及实际ODE；D0=1由Jacobian初值而非结论假设。；[EXTRA] 补全可测集合真实Lebesgue体积结论，保留det=1；显式τ>0对应原[EXTRA]。已有证明仅用两条已证正式结论作合取小修补，无新证明路线。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷73页In particular至紧凑展示式逐字一致，保留D≡D(0)=1及体积恒定。签名任意维数，f为C¹且全局散度零，Φ联合C²、真实ODE、恒等初值，另明确0<τ。结论在整个[0,τ]上对每个初值给实际流Jacobian det=1，并对每个可测S给实际体积保存。D(0)=1来自初值；没有把Jacobian、det或体积结论放进假设。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.flowDet`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L803)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-LJOscillator · Example 2.3 (model) · 印刷p.73 / PDFp.95

### 2. 原文陈述

> A 1-d oscillator with Lennard-Jones potential is described by the equations

$$
\dot q=p,\qquad\dot p=-\varphi_{LJ}'(q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def ljOscillatorEquation (σ ε : ℝ) (_hσ : 0 < σ) (_hε : 0 < ε)
    (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  (∀ t ∈ I, 0 < (γ t).1) ∧
  ∀ t ∈ I, HasDerivAt γ
    ((γ t).2,-deriv (fun q : ℝ ↦ 4*ε*((σ/q)^12-(σ/q)^6)) (γ t).1) t

def oscillatorEquation (φ : ℝ → ℝ) (γ : ℝ → ℝ × ℝ) (I : Set ℝ) : Prop :=
  ∀ t ∈ I, HasDerivAt γ ((γ t).2,-deriv φ (γ t).1) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.ljOscillatorEquation`；`MD.Ch02.oscillatorEquation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。 | [EXTRA] |

[EXTRA] [EXTRA] 本条绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、正参数及正位置；原一般势关系另保留为辅助oscillatorEquation。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷73页Example 2.3的模型句和q̇=p、ṗ=−φ′_LJ(q)一致；74页只提供后续例子背景。主定义绑定明确LJ势4ε[(σ/q)^12−(σ/q)^6]、σ>0、ε>0，要求每个t∈I的位置正且γ在该时刻有真实二分量导数(p,−φ′)。这是单位质量振子，两个方程及负号完整。一般oscillatorEquation是额外辅助定义，不代替主定义的LJ资格。正q使显式势光滑，排除了q=0除法总化。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.ljOscillatorEquation`：定义；`MD.Ch02.oscillatorEquation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L818)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-LJBoundedPeriodic · unnumbered_claim · 印刷p.74 / PDFp.96

### 2. 原文陈述

> As a consequence of energy conservation, any bounded individual trajectory of this system will be a periodic orbit.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem ljBoundedPeriodic : ∀ (σ ε : ℝ) (γ : ℝ → ℝ × ℝ),
    0 < σ → 0 < ε →
    oscillatorEquation (fun q => 4*ε*((σ/q)^12-(σ/q)^6)) γ Set.univ →
    (∀ t, 0 < (γ t).1) → Bornology.IsBounded (Set.range γ) →
    ∃ T > 0, ∀ t, γ (t+T) = γ t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.ljBoundedPeriodic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。 | [EXTRA] |

[EXTRA] LJ参数正，实际全时轨迹且位置q>0；平衡解也允许任意正周期。；[EXTRA] 依赖小修：一般ODE关系改引辅助oscillatorEquation；原显式LJ势、正参数、正位置及全部周期结论逐字保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷74页原句逐字一致。Lean对正参数σ,ε、定义于全部实时间的实际LJ解γ、始终q>0、整条相轨迹范围有界，推出存在T>0且对所有实t有γ(t+T)=γ(t)。全时量化避免仅在有限时间窗内有界的逃逸解成为反例。LJ势在正半轴只有一个有限临界点（极小值）；非平衡有界全轨道处于两个有限转向点之间的闭能量曲线，平衡轨迹也满足存在正周期。没有将一般一维势的有界必周期误用为无条件命题，签名明确绑定LJ。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.ljBoundedPeriodic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L830)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-LinearDivergence · unnumbered_claim · 印刷p.74–75 / PDFp.96–97

### 2. 原文陈述

> Consider a linear differential equation system in $\mathbb R^m$,

$$
\dot{\boldsymbol z}=S\boldsymbol z,
$$


> for some matrix $S\in\mathbb R^{m\times m}$. The condition for the flow of this system to conserve volume is just that the trace of $S$ (which is the divergence of the vector field $f(\boldsymbol z)=S\boldsymbol z$) be zero.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem linearDivergence : ∀ n (S : Matrix (Fin n) (Fin n) ℝ)
    (Φ : ℝ × Q n → Q n), ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t z, HasDerivAt (fun s => Φ (s,z)) (S.mulVec (Φ (t,z))) t) →
    (∀ z, divergence S.mulVec z=S.trace) ∧
    ((∀ t, ∀ T : Set (Q n), MeasurableSet T →
      volume ((fun z => Φ (t,z)) '' T)=volume T) ↔ S.trace=0) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.linearDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。 | [EXTRA] |

[EXTRA] [EXTRA]实际全时C²解族Φ，Φ0=id并满足真实线性ODE；只量化可测T。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:618–626；依赖 ReviewDefinitions.lean（合集2816、2877行）展开 Q n=Fin n→ℝ，divergence f z=(textbookCoordinateJacobian f z).trace；LiouvilleVolume.lean（2365–2370行）展开 Jacobian=LinearMap.toMatrix' (fderiv ℝ f z).toLinearMap，条目(i,j)是 Df(z)(e\_j) 的第i输出分量。因此线性向量场的 Jacobian 正是S，散度等于迹。volume 在有限实函数空间采用标准乘积 Lebesgue 体积；不是有向体积，合集2488–2492行换元明确使用绝对行列式。量词先任意n、S和实际解族Φ，再C²、初值恒等和逐时逐点ODE；结论同时保留散度公式及全时全部可测集合体积保存↔trace=0。线性解族由ODE唯一性为exp(tS)z，其行列式exp(t trace S)，所以两个方向均正确。n=0也无例外。[EXTRA]全时C²对线性系统自动可满足；初值和ODE必要地标识所说的流，可测集合限制合理。Ch02.lean证明体含sorry；此PASS仅指签名语义，不指证明完成。

### 7. 状态与证明位置

incomplete；`MD.Ch02.linearDivergence`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L839)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-LinearEuler · definition · 印刷p.75 / PDFp.97

### 2. 原文陈述

> Applying Euler’s method to the same system results in

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+hS\boldsymbol z_n=(I+hS)\boldsymbol z_n,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_linearEuler {n : ℕ} (S : Matrix (Fin n) (Fin n) ℝ) (h : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  1 + h • S
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_linearEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:629–630 的 bp\_linearEuler=1+h • S；并展开依赖 ReviewDefinitions.lean:2878–2879 的正式 linearEuler，二者完全相同。矩阵1为单位矩阵，标量作用逐项相乘，故其乘向量的第i分量是z\_i+h∑_j S\_ij z\_j，恰为原文z_{n+1}=z\_n+hSz\_n=(I+hS)z\_n。隐式n及任意实矩阵S、实步长h无附加限制。这里定义更新矩阵而非另添迭代存在性断言，忠实于展示式；无EXTRA、ERRATUM或sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_linearEuler`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L848)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-EulerVolumePrinted · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> and the condition for Euler’s method to conserve volume is that $\det(I+hS)=1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerVolumePrinted : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ (linearEuler S h).det=1 := by
  sorry



/-- 修正版，对应原文 MD-2.3.2-EulerVolumePrinted。改动：标准无向体积的判据为绝对行列式1；原det=1不作必要条件。 -/
```

独立修正版：

```lean
theorem eulerVolumePrinted_corrected : ∀ n (S : Matrix (Fin n) (Fin n) ℝ) h,
    (∀ T : Set (Q n), MeasurableSet T →
      volume ((linearEuler S h).mulVec '' T)=volume T) ↔ |(linearEuler S h).det|=1 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerVolumePrinted`；`MD.Ch02.eulerVolumePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 标准无向体积的判据为绝对行列式1；原det=1不作必要条件。 | [EXTRA] |

[EXTRA] [ERRATUM?] 标准无向体积的判据为绝对行列式1；原det=1不作必要条件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；实际读取 Ch02.lean:634–638；展开依赖Q n=Fin n→ℝ及linearEuler S h=1+h • S（合集2816、2878–2879行）。volume是标准无向Lebesgue体积，合集LiouvilleVolume换元使用|det|；依赖Statements.lean:3129–3132的linearEulerVolume\_statement本身也明确写|det|=1，但当前Blueprint定理并未引用这个修正版，而是↔det=1。任意n、S、h且全部可测T的量词忠实照录原文，却产生数学错误：det=1是充分条件而非必要条件。[ERRATUM?]在当前明确的无向体积解释下成立，无须再NEEDS\_HUMAN。没有方向或小步长假设；仅h>0不能修复。证明体含sorry，不能使错误签名有效。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerVolumePrinted`：未证（原书疑误不证）；`MD.Ch02.eulerVolumePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L854)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-EulerVolumeCounterexample · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> The conditions for volume preservation by the flow map and its Euler approximation are essentially unrelated. Thus Euler’s method does not in general conserve phase space volume (it conserves volume only in very special cases—see Exercise 6).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerVolumeCounterexample :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → |(linearEuler S h).det| ≠ 1 := by
  sorry

theorem eulerVolumeCounterexample_det_only :
  ∃ S : Matrix (Fin 2) (Fin 2) ℝ, S.trace = 0 ∧ ∀ h : ℝ, h ≠ 0 → (linearEuler S h).det ≠ 1 := by
  exact MolecularDynamics.Chapter02Review.eulerVolumeCounterexample_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerVolumeCounterexample`；`MD.Ch02.eulerVolumeCounterexample_det_only` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 强化见证为每个h≠0时\|det(I+hS)\|≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det\_only辅助定理并重查，强化结论暂sorry，不写新证明。 | [EXTRA] |

[EXTRA] [EXTRA] 强化见证为每个h≠0时|det(I+hS)|≠1，覆盖实际体积不守恒；原桥接只给det≠1，原已证结果完整保留为det\_only辅助定理并重查，强化结论暂sorry，不写新证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷75页关于Euler一般不保体积的两句逐字一致。linearEuler=I+hS。主定理要求一个固定二维实矩阵S满足trace S=0，同时对每个非零实h有|det(I+hS)|≠1，确实区别真实体积与带符号行列式。辅定理只断言det≠1，并未冒称单凭它即可推出体积不保。取S=[[0,1],[-1,0]]，trace=0且det(I+hS)=1+h²>1，为两个声明的共同见证；这说明新增绝对值版本陈述正确。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerVolumeCounterexample`：未证（缺大型理论）；`MD.Ch02.eulerVolumeCounterexample_det_only`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L873)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-AsymmetricEuler · definition · 印刷p.75 / PDFp.97

### 2. 原文陈述

> the asymmetrical variant of Euler’s method defined by

$$
u_{n+1}=u_n+hf(u_{n+1},v_n),\qquad v_{n+1}=v_n+hg(u_{n+1},v_n).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_asymmetricEulerRelation (f g : ℝ → ℝ → ℝ) (h u v U V : ℝ) : Prop :=
  U = u + h*f U v ∧ V = v + h*g U v
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_asymmetricEulerRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:645–646，bp\_asymmetricEulerRelation f g h u v U V展开为U=u+h*f U v ∧ V=v+h*g U v；依赖ReviewDefinitions.lean:2880–2881正式asymmetricEulerRelation为同一表达式。f,g均为ℝ→ℝ→ℝ，所有变量为实数，新第一坐标U、旧第二坐标v的取值位置与原文两条更新式完全一致，且两条等式完整保留。只定义隐式关系，未宣称全局存在唯一求解器；无额外假设，不含sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_asymmetricEulerRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L882)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-AsymmetricJacobian · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> Solving for the various entries we have

$$
\mathcal G_h'=\begin{bmatrix}1/(1-hf_u)&hf_v/(1-hf_u)\\hg_u/(1-hf_u)&1+hg_v+h^2g_uf_v/(1-hf_u)\end{bmatrix},
$$


> and calculating the determinant of the Jacobian results in

$$
\det\mathcal G_h'=\frac{1+hg_v}{1-hf_u}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem asymmetricDet :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    ∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0 →
      (textbookCoordinateJacobian Ψ z) =
        !![(1/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) : ℝ),
          h*deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0));
          h*deriv (fun u => g u (z 1)) (Ψ z 0)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)),
          1+h*deriv (g (Ψ z 0)) (z 1)+h^2*deriv (fun u => g u (z 1)) (Ψ z 0)*
            deriv (f (Ψ z 0)) (z 1)/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0))] ∧
      (textbookCoordinateJacobian Ψ z).det =
        (1+h*deriv (g (Ψ z 0)) (z 1))/(1-h*deriv (fun u => f u (z 1)) (Ψ z 0)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.asymmetricDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。 | [EXTRA] |

[EXTRA] f,g及实际隐式解映射Ψ C¹；分母1-hfu≠0；偏导在(U,v)取值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:650–669；展开Q 2=Fin 2→ℝ、asymmetricEulerRelation两条实际等式（合集2816、2880–2881行），以及textbookCoordinateJacobian=LinearMap.toMatrix' (fderiv ℝ Ψ z).toLinearMap（2365–2370行），确认行i是输出坐标、列j是输入坐标，未转置。令U=Ψ z 0、v=z 1、a=∂u f(U,v)、b=∂v f(U,v)、c=∂u g(U,v)、d=∂v g(U,v)、D=1-ha。签名四项依次为1/D、hb/D、hc/D、1+hd+h²cb/D，并同时给出det=(1+hd)/D，逐项与原文相符。deriv(fun u=>f u v) U与deriv(f U) v分别准确表示上述偏导；g同理。先任意f,g,Ψ,h，再C¹及处处真实解关系，再任意z及该点D≠0，量词正确，无需散度零假设。[EXTRA]正则性和D≠0保障隐式微分，合理；全局C¹与关系较局部推导强，可局部化但无对象或公式改变。证明体含sorry；语义PASS不代表已证明。

### 7. 状态与证明位置

incomplete；`MD.Ch02.asymmetricDet`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L887)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-AsymmetricArea · unnumbered_claim · 印刷p.75–76 / PDFp.97–98

### 2. 原文陈述

> In the event that the vector field is divergence free, we have $f_u+g_v=0$ which implies that the numerator and denominator are identical, and it follows that $\det\mathcal G_h'=1$. Thus the asymmetric variant of the Euler method is area preserving, even though the standard Euler method is not.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem asymmetricArea :
  ∀ (f g : ℝ → ℝ → ℝ) (Ψ : Q 2 → Q 2) h,
    ContDiff ℝ 1 (Function.uncurry f) → ContDiff ℝ 1 (Function.uncurry g) → ContDiff ℝ 1 Ψ →
    (∀ z, asymmetricEulerRelation f g h (z 0) (z 1) (Ψ z 0) (Ψ z 1)) →
    (∀ u v, deriv (fun x => f x v) u + deriv (g u) v = 0) →
    (∀ z, 1-h*deriv (fun u => f u (z 1)) (Ψ z 0) ≠ 0) →
    Function.Injective Ψ →
    (∀ z, (textbookCoordinateJacobian Ψ z).det = 1) ∧
    (∀ T : Set (Q 2), MeasurableSet T → volume (Ψ '' T)=volume T) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.asymmetricArea` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。 | [EXTRA] |

[EXTRA] f,g及实际解映射Ψ C¹，分母处处非零；行列式1给局部面积保存，整集需单射域。；[EXTRA]Ψ实际单射，保证整集面积换元；Jacobian1本身仅给局部面积。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取 Ch02.lean:674–685；展开Q、真实asymmetricEulerRelation和标准坐标Jacobian（合集2816、2880–2881、2365–2370行），volume为有限实乘积空间的无向Lebesgue体积。先任意f,g,Ψ,h，再三项C¹、处处更新关系、∀u v的真实偏导和为零、解取值点的处处分母非零及Ψ单射；结论同时保留∀z det=1与全部可测T的像面积相等。偏导均在(U,v)取值；散度零给1+h g\_v=1-h f\_u，因此点态det=1；C¹、单射及绝对行列式换元给全局集合面积保存。[EXTRA]C¹、实际解映射和分母非零是合理的可微分支条件，全球版本强于原书局部计算但解释清楚。单射是保证全局换元的合理明确充分条件；不是声称这些其余假设必然不能推出它，不能泛称其独立必要性。仅det=1的一般映射不足以推出全局像面积相等，因此此额外条件与所选全球结论相称。无ERRATUM。证明体含sorry；语义与证明完成分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.asymmetricArea`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L905)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticMap · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> Let $m=2N_c$. A symplectic map $\Phi:\mathbb R^m\to\mathbb R^m$ is one that preserves the symplectic differential 2-form. The simplest way to write this is as the following algebraic condition on the Jacobian matrix of $\Phi$:

$$
\Phi'^TJ\Phi'=J.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_IsSymplecticMap {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) : Prop :=
  Differentiable ℝ Φ ∧ ∀ z, IsTextbookSymplectic (textbookJacobian Φ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_IsSymplecticMap` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。 | [EXTRA] |

[EXTRA] [EXTRA] 采用原文经典可微辛映射资格，移除不必要C¹限制；正式库C¹定义保持不变。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷76页从Let m=2Nc到Φ′ᵀJΦ′=J的定义逐字一致。bp\_IsSymplecticMap对两个Fin Nc块上的实际映射要求全局可微，且每个z的真实Jacobian满足AᵀJA=J；J块矩阵符号正确。没有要求额外C¹，也没有把抽象矩阵当作无关实际映射的Jacobian。此处只审教材局部导数/保形式意义的定义，不从非奇异Jacobian擅推全局可逆。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_IsSymplecticMap`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L918)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-OneForm · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> A 1-form $\alpha$ defined on $\mathbb R^m$ is a family of linear mappings from $\mathbb R^m$ to $\mathbb R$, defined for each point of $\mathbb R^m$. Let $\boldsymbol a:\mathbb R^m\to\mathbb R^m$, then we may define a one-form associated to this vector by $\alpha(\boldsymbol x)(\boldsymbol\xi)=\boldsymbol a(\boldsymbol x)^T\boldsymbol\xi$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def oneFormFamily (n : ℕ) := Q n → Q n →L[ℝ] ℝ

def oneFormOfCoefficients {n : ℕ} (a : Q n → Q n) (z : Q n) : Q n →L[ℝ] ℝ :=
  ∑ i : Fin n, (a z i) • ContinuousLinearMap.proj i

theorem oneFormOfCoefficients_apply {n : ℕ} (a : Q n → Q n) (z ξ : Q n) :
    oneFormOfCoefficients a z ξ = ∑ i : Fin n, a z i * ξ i := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.oneFormFamily`；`MD.Ch02.oneFormOfCoefficients`；`MD.Ch02.oneFormOfCoefficients_apply` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 保留逐点1-form类型，补由系数向量a构造连续线性泛函及α(z)(ξ)=a(z)ᵀξ评价式；新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷76页1-form线性映射族定义以及α(x)(ξ)=a(x)ᵀξ逐字一致。oneFormFamily对每个基点给一个连续线性实泛函；有限维中连续性自动成立，不是额外光滑条件。oneFormOfCoefficients是逐坐标投影的有限线性组合，对任意a,z,ξ，辅助定理断言评价恰为Σ\_i a(z)_i ξ\_i；对象、基点及完整评价式均覆盖。未错误要求a对z可微。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.oneFormFamily`：定义；`MD.Ch02.oneFormOfCoefficients`：定义；`MD.Ch02.oneFormOfCoefficients_apply`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L924)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-Differential · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> The differential of a function $g:\mathbb R^m\to\mathbb R$, denoted $dg$, is a family of linear mappings (one for each point in phase space) from vectors $\boldsymbol\xi\in\mathbb R^m$ into the reals defined by

$$
dg(\boldsymbol q,\boldsymbol p)(\boldsymbol\xi)=\nabla g(\boldsymbol q,\boldsymbol p)^T\boldsymbol\xi.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_differential {n : ℕ} (g : Q n → ℝ) : oneForm n := fderiv ℝ g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_differential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Q n=Fin n→ℝ（依赖:2816）和 oneForm n=Q n→Q n→L[ℝ]ℝ（:2882）。bp\_differential g=fderiv ℝ g，是每个底点的真实 Fréchet 导数，方向 ξ 进入线性泛函，在可微点评价为 ∑i,∂ᵢg(z)ξᵢ，正对应 ∇g(z)ᵀξ。默认坐标范数不改变有限维导数或此坐标等式；n 是总坐标数，可取 2Nc。fderiv 在不可微点取默认零是总化扩展，不能解释为不可微函数存在原文微分；原文 ∇g 隐含可微资格，在该资格下未改变定义。没有额外正则性限制或 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_differential`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L934)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-CoordinateDifferentials · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> So, denoting the $i$th position coordinate by $q_i$, we have $dq_i(\boldsymbol\xi)=\xi_i$; the differential is thus an example of a 1-form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def coordinateDifferentials (n : ℕ) :
    (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) × (Fin n → SymplecticCoordinates n →ₗ[ℝ] ℝ) :=
  (textbookDq,textbookDp)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.coordinateDifferentials` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33 的坐标空间分拆 q,p；:55–65 展开 textbookDq i u=u(Sum.inl i)、textbookDp i u=u(Sum.inr i)，map\_add/map\_smul 为逐坐标线性。蓝图配对这两个族，Fin n 对应教材 1,…,Nc，inr 对应 i+Nc，正负号、维数均正确。底点省略合理：坐标函数导数是与底点无关的固定评价泛函。dp 项来自本条 context 的 PDF99，合理且无额外假设；无 [ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.coordinateDifferentials`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L937)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-Wedge · definition · 印刷p.76 / PDFp.98

### 2. 原文陈述

> It is written $\alpha\wedge\beta$ and is defined, for vectors $\boldsymbol\xi,\boldsymbol\eta\in\mathbb R^m$ by

$$
\alpha\wedge\beta(\boldsymbol\xi,\boldsymbol\eta)=\alpha(\boldsymbol\xi)\beta(\boldsymbol\eta)-\alpha(\boldsymbol\eta)\beta(\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_wedge {Nc : ℕ} (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) α β -
    LinearMap.BilinForm.comp (LinearMap.mul ℝ ℝ) β α

@[simp] theorem textbookWedgeOneForms_apply {Nc : ℕ}
    (α β : SymplecticCoordinates Nc →ₗ[ℝ] ℝ) (u v : SymplecticCoordinates Nc) :
    textbookWedgeOneForms α β u v = α u * β v - α v * β u := by
  change α u * β v - β u * α v = _
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_wedge`；`MD.Ch02.textbookWedgeOneForms_apply` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33 明确空间是 ℝ^(2Nc)，:73–77 的 textbookWedgeOneForms 与 bp\_wedge 函数体相同。双线性乘法复合与减法展开得到 α(u)β(v)−β(u)α(v)，实数交换律化为 α(u)β(v)−α(v)β(u)，完整对应原式。参数 α,β 为固定底点的线性泛函，与 context 相符；结果双线性且交替，没有暗加光滑条件。邻接 apply 定理虽使用库名称，实际定义相同，不再有对象不明问题。无 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_wedge`：定义；`MD.Ch02.textbookWedgeOneForms_apply`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L942)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticForm · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> Summing these terms results in the symplectic 2-form, denoted $\psi_S$:

$$
\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_symplecticForm (Nc : ℕ) :
    LinearMap.BilinForm ℝ (SymplecticCoordinates Nc) :=
  (textbookJ Nc).toBilin'
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33–40 展开坐标及 J=[[0,I],[-I,0]]；bp\_symplecticForm 与依赖:85–87 的 textbookSymplecticForm 同为 J.toBilin'，评价是 ∑a∑b u(a)J(a,b)v(b)=∑i[u(inl i)v(inr i)−u(inr i)v(inl i)]。依赖:55–77 的 dq,dp 与楔积展开给出同一和，:90–107 明确登记坐标式和求和等式。故作为辛形式的定义，确实指定原文完整公式中的同一对象，没有符号、因子或维数错位；J^(i) 就是各 i 的两非零元素矩阵，其和为此 J。无 [EXTRA]/[ERRATUM?]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticForm`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L954)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-FormSumWedges · unnumbered_claim · 印刷p.77 / PDFp.99

### 2. 原文陈述

> The wedge product of the coordinate differentials $dq_i,dp_i$ may be written

$$
dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\xi_i\eta_{i+N_c}-\xi_{i+N_c}\eta_i=\boldsymbol\xi^TJ^{(i)}\boldsymbol\eta.
$$


> where $J^{(i)}$ is the matrix which has zeros everywhere except for $(J^{(i)})_{i,i+N_c}=1$, $(J^{(i)})_{i+N_c,i}=-1$. Summing these terms results in the symplectic 2-form, denoted $\psi_S$:

$$
\psi_S=\sum_{i=1}^{N_c}dq_i\wedge dp_i(\boldsymbol\xi,\boldsymbol\eta)=\boldsymbol\xi^T\left(\sum_{i=1}^{N_c}J^{(i)}\right)\boldsymbol\eta=\boldsymbol\xi^TJ\boldsymbol\eta.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem formSumWedges (Nc : ℕ) :
    textbookSymplecticForm Nc =
      ∑ i : Fin Nc, textbookWedgeOneForms (textbookDq i) (textbookDp i) := by
  apply MolecularDynamics.textbookSymplecticForm_eq_sum_wedges <;> assumption

def symplecticComponentMatrix {Nc : ℕ} (i : Fin Nc) : SymplecticCoordinateMatrix Nc :=
  fun a b ↦ if a = Sum.inl i ∧ b = Sum.inr i then 1
    else if a = Sum.inr i ∧ b = Sum.inl i then -1 else 0

theorem formSumWedges_components (Nc : ℕ) :
    (∀ (i : Fin Nc) (u v : SymplecticCoordinates Nc),
      textbookWedgeOneForms (textbookDq i) (textbookDp i) u v =
        ∑ a, u a * ((symplecticComponentMatrix i) *ᵥ v) a) ∧
    (∑ i : Fin Nc, symplecticComponentMatrix i) = textbookJ Nc := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.formSumWedges`；`MD.Ch02.symplecticComponentMatrix`；`MD.Ch02.formSumWedges_components` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原总楔积等式，补单项J⁽ⁱ⁾矩阵、逐项评价及ΣJ⁽ⁱ⁾=J；全部原结论保留，新补陈述不写证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原页17（印刷77页）两条展示式的符号和求和一致，但两式之间where J^(i) is the matrix…的定义句被无省略标志地删去。修正JSON补回该句，明确两个非零位置和正负号。Lean主定理给双线性形式等式；symplecticComponentMatrix逐点定义q\_i,p\_i交叉元+1和−1，其余0。components定理对每个i,u,v给楔积等于uᵀJ^(i)v，并给Σ\_i J^(i)=J。textbookDq/Dp分别取q/p坐标，wedge=α(u)β(v)−α(v)β(u)，textbookSymplecticForm=J.toBilin，故单项坐标式及最终uᵀJv没有符号或二倍因子错误。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.formSumWedges`：已证；`MD.Ch02.symplecticComponentMatrix`：定义；`MD.Ch02.formSumWedges_components`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L960)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-GeneralTwoForm · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> In general, a differential 2-form $\psi$ is represented in coordinates by

$$
\psi_{\boldsymbol z}=\sum_{i,j}a_{ij}(\boldsymbol z)\,dz_i\wedge dz_j,
$$


> with matrix of coefficients $A(\boldsymbol z)=(a_{ij}(\boldsymbol z))$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def coefficientTwoForm {n : ℕ} (A : Q n → Matrix (Fin n) (Fin n) ℝ)
    (z u v : Q n) : ℝ :=
  ∑ i, ∑ j, A z i j * (u i*v j-v i*u j)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.coefficientTwoForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q n 已展开为 Fin n→ℝ（依赖:2816）。蓝图 coefficientTwoForm 对任意底点依赖系数 A，评价精确为 ∑i∑j A(z)ij[u\_i v\_j−v\_i u\_j]，逐项就是 a\_ij(z)dz\_i∧dz\_j；底点、两个方向和双和顺序无遗漏。无需假设 A 反对称；该表达自动双线性反对称，不把 A 直接当双线性矩阵。[ERRATUM?] 的代数部分成立：实际矩阵为 A−Aᵀ，A 反对称时为2A。但本条原文只称 A 为双和的系数矩阵，这本身无错；关于后文直接使用 A 的疑点不能在本批 scope 内确认，故不认定本条有已证实勘误，也不改双和。无 [EXTRA]。 本次依据实际蓝图 /workspace/Ch02.lean:680–723 及依赖源码展开审计；哈希键 Blueprint/Ch02.lean 对应该附件的逻辑名称。仅审计签名语义，不作 Lean 编译或证明完成认证；本批定义和 formSumWedges 本地证明均无 sorry，所调用辛形式求和定理的所附证明也无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.coefficientTwoForm`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L978)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackOne · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> It is written $\Phi^*\psi$, so

$$
(\Phi^*\psi_{\boldsymbol z})(\boldsymbol\xi)=\psi_{\Phi(\boldsymbol z)}(\Phi'(\boldsymbol z)\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_pullbackOne {n : ℕ} (Φ : Q n → Q n) (α : oneForm n) : oneForm n :=
  fun z => (α (Φ z)).comp (fderiv ℝ Φ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_pullbackOne` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816 的 Q n=Fin n→ℝ；:2882 的 oneForm n=Q n→(Q n→L[ℝ]ℝ)，即底点参数化的实线性泛函（有限维下连续性不额外收窄线性对象）。展开 .comp 得 ∀z ξ，bp\_pullbackOne Φ α z ξ=α(Φ z)((fderiv ℝ Φ z)ξ)，底点、方向与原式完全一致。依赖:2886–2887 的 pullbackOne 同体。没有把 α 错取在 z，也无额外假设。Φ 不带可微条件是用总化 fderiv 扩展定义的域：在教材实际导数存在的全部点，公式正是原定义；不可微点的默认值不能解释为教材的真实导数，但不使可微范围上的定义失真。无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_pullbackOne`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L983)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackTwo · definition · 印刷p.77 / PDFp.99

### 2. 原文陈述

> The pull-back of a differential 2-form $\psi_1\wedge\psi_2$ is consequently defined as

$$
\Phi^*(\psi_1\wedge\psi_2)=(\Phi^*\psi_1)\wedge(\Phi^*\psi_2).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_pullbackTwo {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) (z u v : Q n) : ℝ :=
  A.val (Φ z) ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_pullbackTwo` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816、:2882–2889 展开 Q、oneForm、twoForm、pullbackOne、pullbackTwo。twoForm 是逐点连续双线性映射 A 加 ∀z u v，A z u v=−A z v u 的子类型；实数域上这也保证 A z u u=0，确为交替2-形式。蓝图与库 pullbackTwo 同体，两个方向均用同一底点的 DΦ(z)，A 在 Φ(z) 取值。依赖:73–82 的楔积展开是 α(u)β(v)−α(v)β(u)；对 α,β 的逐点族作同样展开，左侧拉回为 α(Φz)(DΦz u)β(Φz)(DΦz v)−α(Φz)(DΦz v)β(Φz)(DΦz u)，右侧两条拉回1-形式的楔积完全相同。因此本定义在可分解形式上实现原文乘法性，并合理推广到所有2-形式；不需要凭缺少单独定理把定义判缺失。没有额外光滑性要求；fderiv 的总化扩展在可微范围上正确。无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_pullbackTwo`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L987)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PullbackMatrix · unnumbered_claim · 印刷p.77–78 / PDFp.99–100

### 2. 原文陈述

> Given a differential 2-form $\psi_{\boldsymbol z}$ represented by the matrix $A(\boldsymbol z)=(a_{ij}(\boldsymbol z))$, the pull-back of $\psi_{\boldsymbol z}$ under $\Phi$ is defined by

$$
\Phi^*\psi_{\boldsymbol z}=\sum_{ij}b_{ij}(\boldsymbol z)dz_i\wedge dz_j,
$$


> where the matrix $B(\boldsymbol z)=(b_{ij}(\boldsymbol z))$ is related to $A(\boldsymbol z)$ by

$$
B(\boldsymbol z)=\Phi'^T(\boldsymbol z)A(\Phi(\boldsymbol z))\Phi'(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem pullbackMatrix :
  ∀ n (Φ : Q n → Q n) (A : Q n → Matrix (Fin n) (Fin n) ℝ) z u v,
    dotProduct ((fderiv ℝ Φ z) u) ((A (Φ z)).mulVec ((fderiv ℝ Φ z) v)) =
      dotProduct u (((textbookCoordinateJacobian Φ z).transpose * A (Φ z) *
        textbookCoordinateJacobian Φ z).mulVec v) := by
  intro n Φ A z u v
  rw [← textbookCoordinateJacobian_mulVec Φ z u,
    ← textbookCoordinateJacobian_mulVec Φ z v]
  rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec,
    Matrix.dotProduct_transpose_mulVec]
  exact dotProduct_comm _ _
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.pullbackMatrix` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2816 的 Q 和 :2365–2376 的 textbookCoordinateJacobian 展开为标准基下 LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，且 mulVec u=DΦ(z)u。蓝图全称量化 n,Φ,A,z,u,v，完整表达 (DΦu)ᵀA(Φz)(DΦv)=uᵀ[DΦᵀA(Φz)DΦ]v；所有方向上的双线性评价唯一确定矩阵 B，故 B(z)=DΦ(z)ᵀA(Φz)DΦ(z)，底点无误。对原文全指标楔积系数，coefficientTwoForm 展开为 uᵀ(A−Aᵀ)v；将本等式在 (u,v) 和 (v,u) 上相减，恰得拉回系数形式等于 B 的全指标楔积形式，故归一差异不损害本夹乘公式。A 无须反对称，可推广为任意矩阵；不添加假设，无 [EXTRA]/[ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.pullbackMatrix`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L991)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-PreservesForm · definition · 印刷p.78 / PDFp.100

### 2. 原文陈述

> We say that a 2-form $\psi$ is conserved under mapping $\Phi$ if

$$
\Phi^*\psi=\psi.
$$


> In coordinates, the conservation of the 2-form represented by matrix $A$ under a mapping $\Phi$ means that

$$
\Phi'^TA\Phi'=A.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_preservesTwoForm {n : ℕ} (Φ : Q n → Q n) (A : twoForm n) : Prop :=
  ∀ z u v, pullbackTwo Φ A z u v = A.val z u v
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_preservesTwoForm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:2884–2891 展开 twoForm 及实际调用的 pullbackTwo：A 是逐点交替双线性形式，拉回值为 A(Φz)(DΦz u)(DΦz v)，与 bp\_pullbackTwo 同体。蓝图 ∀z u v 的等式是 Φ*ψ=ψ 的完整逐点评价，量词顺序与对象正确。若 M(z) 是 A.val 的实际双线性矩阵，则它等价于 DΦ(z)ᵀM(Φz)DΦ(z)=M(z)。[ERRATUM?] 指出的底点补全正确，但原文前一式已明确 A(Φz)，因而当前省略底点可按上下文理解，不能确认是错误。若把原文 A 当任意全指标楔积系数，则严格只保存反对称部分；选实际交替双线性矩阵才得到字面矩阵等式。这是表示约定说明，不影响本条形式守恒定义。没有额外假设。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_preservesTwoForm`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1005)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticIffForm · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> In the particular case of the symplectic 2-form $\psi_S$, we have $A=J$, and the following condition for conservation under the mapping $\Phi$

$$
\Phi'^TJ\Phi'=J.\tag{2.17}
$$


> A map that conserves the symplectic 2-form, or, in coordinates, satisfies (2.17), is termed a symplectic map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticIffForm {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    bp_IsSymplecticMap Φ ↔ Differentiable ℝ Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  sorry

theorem symplecticIffForm_C1 {Nc : ℕ}
    (Φ : SymplecticCoordinates Nc → SymplecticCoordinates Nc) :
    IsTextbookSymplecticMap Φ ↔ ContDiff ℝ 1 Φ ∧
      ∀ z u v, textbookSymplecticForm Nc ((fderiv ℝ Φ z) u) ((fderiv ℝ Φ z) v) =
        textbookSymplecticForm Nc u v := by
  apply MolecularDynamics.isTextbookSymplecticMap_iff_preserves_form <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticIffForm`；`MD.Ch02.symplecticIffForm_C1` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。 | [EXTRA] |

[EXTRA] [EXTRA] 教材定义等价式使用本章经典可微辛谓词；原正式桥接以C¹为定义，不能直接沿用，保留sorry，不宣称已证。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷78页专门辛2形式A=J、式(2.17)、末句命名定义一致。symplecticIffForm使用任意实际Φ，左侧教材可微谓词，右侧可微且对每个基点z及向量u,v有ψ(DΦ\_z u,DΦ\_z v)=ψ(u,v)，完整双向等价。辅助\_C1版本两侧一致使用ContDiff ℝ 1；没有将C¹版和仅可微版混用。实际J矩阵与双线性形式相符，未遗漏任何基点或切向量。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.symplecticIffForm`：未证（缺大型理论）；`MD.Ch02.symplecticIffForm_C1`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1010)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-SymplecticDet · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> Taking the determinant of both sides of (2.17), we have

$$
\det(\Phi'^TJ\Phi')=\det(J)\Rightarrow\det(\Phi'^T)\det(J)\det(\Phi')=\det(J),
$$


> hence

$$
\det(\Phi')^2=1,
$$


> so $|\det(\Phi')|=1$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticDet {n : ℕ} (A : SymplecticCoordinateMatrix n) (hA : IsTextbookSymplectic A) :
    A.det^2=1 ∧ |A.det|=1 := by
  exact ⟨hA.det_square,hA.abs_det⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticDet` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；依赖:33–40、:138–139 展开 SymplecticCoordinateMatrix n 为实2n×2n矩阵、J=[[0,I],[−I,0]]、hA 为 AᵀJA=J；:49–52 的 J²=−I 给出逆矩阵 −J，取消 det J 合法，包括 n=0 的空矩阵情形。蓝图同时包含 det(A)²=1 与 |det(A)|=1，两项原文结论均保留。把导数矩阵推广为任意辛矩阵不收窄教材结论，无 [EXTRA]。依赖:183–197 的 det\_square/abs\_det 使用更强的辛矩阵 det=1 结果，证明途径强于教材不改变本条签名语义。无 [ERRATUM?]。 实际读取蓝图附件 /workspace/Ch02.lean:726–779；输出哈希键 Blueprint/Ch02.lean 是该附件的逻辑名称，并非声称存在同名物理路径。以下依赖行号均指 Ch02\_deps.txt 的合并文本。只读展开签名语义；本批七个声明的函数体/证明没有本地 sorry，相关已读依赖证明也未见 sorry；没有编译或作完整传递依赖公理认证，语义判定不以证明是否完成为依据。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticDet`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1025)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.3-HamiltonDet · unnumbered_claim · 印刷p.78 / PDFp.100

### 2. 原文陈述

> If the system is Hamiltonian, the map is symplectic for all $t$, and the determinant will be a continuous function of $t$, so the cases of interest have $\det(\mathcal F_t')=+1$. The flow map of a Hamiltonian system is volume preserving.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonDet {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (hH : ContDiff ℝ 2 H) (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t)
    (hinit : (fun z => Φ (0,z))=id) :
    (∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z ↦ Φ (t,z))) ∧
    (∀ t ∈ Icc 0 τ, ∀ z, (textbookJacobian (fun y => Φ (t,y)) z).det=1) ∧
    (∀ t ∈ Icc 0 τ, ∀ S : Set (SymplecticCoordinates n), MeasurableSet S →
      volume ((fun z => Φ (t,z)) '' S)=volume S) := by
  constructor
  · exact MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 H hH Φ hΦ τ hODE hinit
  · constructor
    · exact MolecularDynamics.textbookHamiltonianFlowJacobian_det_eq_one_of_jointC2 H hH Φ hΦ τ hODE hinit
    · exact MolecularDynamics.textbookHamiltonianFlow_volume_image_of_jointC2 H hH Φ hΦ τ hODE hinit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonDet` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。 | [EXTRA] |

[EXTRA] [EXTRA]联合C²实际解族，H C²、Φ0=id，τ>0；体积结论另项HamiltonVolume完整覆盖。；[EXTRA] 补∀t流辛性合取，同时保留det=1和可测集合体积；时间域仍Icc0τ，不额外假称τ>0。已有证明仅将现成流辛性定理与原合取作小修补。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；印刷78页Hamiltonian流辛性、行列式随t连续、det=+1及体积保存句均逐字一致。Lean给任意n、C² Hamiltonian和联合C²实际流、恒等初值及窗内ODE，结论有三项：每个时刻流为C¹辛映射；每点Jacobian det=1；每个可测集合体积保存。行列式的时间连续性由联合C²正则性得到，并且窗内恒等于1也直接给其限制连续。旧extra\_assumptions一条称τ>0、一条说不假称τ>0，自相矛盾；实际无该前提，已统一修正。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonDet`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1032)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-Hessian · definition · 印刷p.79 / PDFp.101

### 2. 原文陈述

> where $S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_hessian {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinateMatrix Nc := fun i j =>
  fderiv ℝ (fderiv ℝ H) z (Pi.single i 1) (Pi.single j 1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_hessian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。Ch02.lean:779–783 的 bp\_hessian 与 HamiltonianVariational.lean 中 textbookHamiltonianHessian 逐字相同：第(i,j)项为 D(DH)(z)[e\_i][e\_j]，e\_i=Pi.single i 1。这是实际二阶Fréchet导数的坐标矩阵；取z=Φ(t,ζ)即得到原文S(t)，点参数化未丢失轨迹取值语义。对称性另由本批HessianSymmetry承担。本定义无额外假设、无sorry；不在本条强求时间函数封装。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_hessian`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1049)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HessianSymmetry · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> where $S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hessianSymmetry {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) : (textbookHamiltonianHessian H z).IsSymm := by
  apply MolecularDynamics.textbookHamiltonianHessian_isSymm <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hessianSymmetry` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H在所取点C²，混合偏导相等。 | [EXTRA] |

[EXTRA] H在所取点C²，混合偏导相等。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。HamiltonianVariational.lean 展开的 textbookHamiltonianHessian 与 bp\_hessian 定义相同；Matrix.IsSymm断言转置等于自身，恰为全部混合二阶导数互换。Ch02.lean:786–790 对所有H和z，在ContDiffAt ℝ 2 H z下断言该对称性，因而也适用于任意轨迹点。点处C²是合理的充分正则性补充，非最弱必要条件；“混合偏导相等”不是另加假设，而是推出的结论。库证明使用二阶导数对称性，本地及该依赖证明无sorry；本次仅审签名，未运行Lean编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hessianSymmetry`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1056)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HamiltonVariationalPrinted · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> For the Hamiltonian system $\dot{\boldsymbol z}=J\nabla H(\boldsymbol z)$, these take the form:

$$
\dot W=JS(t)W,
$$


> where $S(t)=H_{zz}(\boldsymbol z(t,\boldsymbol\zeta))$ is a symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonVariationalPrinted : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 1 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) (Φ (s,ζ)))
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) (Φ (t,ζ))) t := by
  sorry



/-- 修正版，对应原文 MD-2.3.4-HamiltonVariationalPrinted。改动：固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。 -/
```

独立修正版：

```lean
theorem hamiltonVariationalPrinted_corrected : ∀ n (H : SymplecticCoordinates n → ℝ)
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ ζ,
    ContDiff ℝ 2 H → ContDiff ℝ 2 Φ → (∀ z, Φ (0,z)=z) →
    (∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s,z))
      (textbookHamiltonianVectorField H (Φ (t,z))) t) →
    ∀ t ∈ Ioo 0 τ, HasDerivAt
      (fun s => textbookJacobian (fun y => Φ (s,y)) ζ)
      (textbookJ n * textbookHamiltonianHessian H (Φ (t,ζ)) *
        textbookJacobian (fun y => Φ (t,y)) ζ) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonVariationalPrinted`；`MD.Ch02.hamiltonVariationalPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。 | [EXTRA] |

[EXTRA] [ERRATUM?] 固定初值ζ处的空间Jacobian，联合C²解族；原移动点评价式不证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。SymplecticMaps.lean 的 textbookJacobian Φ z=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，第(i,j)项为DΦ(z)[e\_j]_i；SplittingError.lean 的 textbookHamiltonianVectorField H z=J乘以各基方向的DH，故确为(q̇,ṗ)=(H\_p,-H\_q)。HamiltonianVariational.lean 的 Hessian为实际二阶导数。Ch02.lean:793–803 对所有n,H,Φ,τ,ζ，在H C²、Φ联合C¹、Φ₀=id、闭区间所有初值满足真实ODE下，宣称移动点W(s)=DΦ\_s(Φ\_s(ζ))满足Ẇ=J Hzz(Φ\_t(ζ))W。它忠实保留印刷疑误，却不是正确变分方程；[ERRATUM?]由下列全局光滑反例确定成立。即使加强Φ为C∞也不能补救。通常固定初值W=DΦ\_t(ζ)才满足该式；移动点同时产生空间链式项，且固定底点的变分系数在Φ\_t(Φ\_t(ζ))取值。C¹本身也不足以直接保证所需二阶混合导数。τ≤0时开区间为空，不影响τ>0的反例。签名FAIL与证明体显式sorry分别记录；该sorry不作为判FAIL的理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.hamiltonVariationalPrinted`：未证（原书疑误不证）；`MD.Ch02.hamiltonVariationalPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1064)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-MatrixCancellation · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> hence

$$
\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.
$$



### 3. 原文证明

> Computing

$$
W^TJ\dot W=W^TJ^2SW=-W^TSW,
$$


> whereas

$$
\dot W^TJW=W^TS^TJ^TJW=W^TSW,
$$


> hence

$$
\frac{\mathrm d}{\mathrm dt}W^TJW=W^TJ\dot W+\dot W^TJW=0.
$$


原文Computing、whereas和hence的矩阵计算按原页保留于proof\_latex；本条matrixCancellation\_time已登记实际乘积求导及零导数，时间区间上推出常值是后续步骤。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem matrixCancellation {Nc : ℕ}
    (S W : SymplecticCoordinateMatrix Nc) (hS : S.IsSymm) :
    (textbookJ Nc * S * W)ᵀ * textbookJ Nc * W +
      Wᵀ * textbookJ Nc * (textbookJ Nc * S * W) = 0 := by
  apply MolecularDynamics.hamiltonian_variational_matrix_cancellation <;> assumption

theorem matrixCancellation_time {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (I : Set ℝ) (t : ℝ)
    (_hS : (S t).IsSymm)
    (_hW : HasDerivWithinAt W (textbookJ Nc * S t * W t) I t) :
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s)
      ((textbookJ Nc * S t * W t)ᵀ * textbookJ Nc * W t +
        (W t)ᵀ * textbookJ Nc * (textbookJ Nc * S t * W t)) I t ∧
    HasDerivWithinAt (fun s ↦ (W s)ᵀ * textbookJ Nc * W s) 0 I t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.matrixCancellation`；`MD.Ch02.matrixCancellation_time` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | S对称；任意矩阵W。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。 | [EXTRA] |

[EXTRA] S对称；任意矩阵W。；[EXTRA] 保留已证代数消去；补真实时间矩阵曲线、对称S(t)、W′=JSW及完整乘积导数/零导数结论，未以导数结论为前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；原页20（印刷79页）Computing、whereas及两条中间矩阵等式一致；statement开头原页是小写hence，当前写成Hence，已作字面修正。代数主定理对任意W和对称S断言(JSW)ᵀJW+WᵀJ(JSW)=0。time版本对任意集合I和点t，假设S(t)对称及W在I内真实导数JS(t)W(t)，同时给乘积导数的完整两项表达式和零导数结论。交换的是相加项顺序，不是矩阵乘积顺序；J²=−I和JᵀJ=I的消去符号正确。任意I无需额外可微性，因为HasDerivWithinAt已提供所需局部资格。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

incomplete；`MD.Ch02.matrixCancellation`：已证；`MD.Ch02.matrixCancellation_time`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1096)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-FormConstant · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> This means that $W^TJW$ is a constant matrix.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem formConstant {Nc : ℕ}
    (S W : ℝ → SymplecticCoordinateMatrix Nc) (τ : ℝ)
    (hS : ∀ t ∈ Icc 0 τ, (S t).IsSymm)
    (hW : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt W (textbookJ Nc * S t * W t) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, (W t)ᵀ * textbookJ Nc * W t = (W 0)ᵀ * textbookJ Nc * W 0 := by
  apply MolecularDynamics.hamiltonian_variational_form_constant <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.formConstant` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。 | [EXTRA] |

[EXTRA] S(t)逐点对称，W实际满足W′=JSW，闭连通时间窗；这一独立矩阵ODE陈述不把流的变分方程结论作流辛性前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 SymplecticForm.lean: SymplecticCoordinates=(Fin Nc ⊕ Fin Nc)→ℝ（先q后p），SymplecticCoordinateMatrix为该索引的实方阵，textbookJ=fromBlocks 0 1 (-1) 0；因此Jᵀ=-J、J²=-I。Ch02.lean:814–821 对所有时间矩阵S,W及τ，在Icc 0 τ各点S对称且W具有实际区间内导数JSW下，推出每一t的W(t)ᵀJW(t)等于初始值；恰为连通时间窗常矩阵的全部结论。S逐点对称、真实矩阵ODE和连通区间是原推导合理背景；不要求S可微或连续，这是合理且更一般的陈述。端点采用HasDerivWithinAt适当；τ=0平凡，τ<0结论为空，无须τ>0。依赖HamiltonianVariational.lean实际利用乘积法则得到零导数，再用均值定理推常值；无sorry。本条独立量化W，不声称错误移动点Jacobian已满足ODE，因此前项FAIL不否定此条件命题。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.formConstant`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1114)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.4-HamiltonSymplectic · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> hence

$$
W^TJW\equiv W(0)^TJW(0)=J.
$$


> This proves that the flow map of a Hamiltonian system is a symplectic map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonSymplectic {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 <;> assumption



/-- 修正版，对应原文 MD-2.3.4-HamiltonSymplectic。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem hamiltonSymplectic_corrected {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (hH : ContDiff ℝ 2 H)
    (Φ : ℝ × SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : ContDiff ℝ 2 Φ) (τ : ℝ)
    (hODE : ∀ t ∈ Icc 0 τ, ∀ z, HasDerivAt (fun s => Φ (s, z))
      (textbookHamiltonianVectorField H (Φ (t, z))) t)
    (hinit : (fun z => Φ (0, z)) = id) :
    ∀ t ∈ Icc 0 τ, IsTextbookSymplecticMap (fun z => Φ (t, z)) := by
  apply MolecularDynamics.textbookHamiltonianFlow_isSymplectic_of_jointC2 <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.hamiltonSymplectic`；`MD.Ch02.hamiltonSymplectic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际解族联合C²；H C²、Φ0=id、τ>0及真实Hamilton ODE。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；原页21（印刷79页）hence、WᵀJW≡W(0)ᵀJW(0)=J及最后流为辛映射原句忠实。Lean对象为真实H和联合C²实际解族Φ，Φ0=id且满足Hamilton ODE；结论对每个t∈[0,τ]为IsTextbookSymplecticMap，展开即C¹与每初值点的Jacobian辛恒等式，初始Jacobian由Φ0=id为I。该签名本身数学正确，且没有τ>0前提。但原页紧邻上下文实际写W(t)=F′_t(z(t,ξ))，而变分矩阵通常应为D\_ξF\_t(ξ)；随移动点评价的全导数另有空间链式项。当前context只称疑点另项记录，未具体登记；按照保留原书数学疑误要求，本条需人工明确W的约定，不将正确Lean结论冒充对原书该推导的逐字证明。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.hamiltonSymplectic`：已证；`MD.Ch02.hamiltonSymplectic_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1125)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-ChainRule · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> Let $\Phi_1$ and $\Phi_2$ be any pair of symplectic maps. Then

$$
(\Phi_1\circ\Phi_2)'=\Phi_1'\Phi_2',
$$


> by the chain rule,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem chainRule {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  apply MolecularDynamics.textbookJacobian_comp <;> assumption



/-- 修正版，对应原文 MD-2.3.5-ChainRule。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem chainRule_corrected {Nc : ℕ}
    (Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hΦ : Differentiable ℝ Φ) (hΨ : Differentiable ℝ Ψ) (z : SymplecticCoordinates Nc) :
    textbookJacobian (Φ ∘ Ψ) z = textbookJacobian Φ (Ψ z) * textbookJacobian Ψ z := by
  apply MolecularDynamics.textbookJacobian_comp <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.chainRule`；`MD.Ch02.chainRule_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 两个实际映射在相应点可微；外导数在Φ₂(z)取值，原文简写省略底点。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；原页22（印刷79页）两辛映射、链式展示式和by the chain rule,逐字一致。Lean对任意两个全局可微实际映射Φ,Ψ及每个z，明确给Jacobian(Φ∘Ψ)(z)=Jacobian Φ(Ψ(z))·Jacobian Ψ(z)，矩阵乘法顺序正确。辛性对链式法则不必要，去掉该前提是有效推广；hΦ,hΨ是全局可微而不是extra说明中的仅在相应点可微。原文外导数评价点省略的NEEDS\_HUMAN问题已存在，本次保留：按标准简写约定可解释正确，若按同一z字面解释则不正确，需人工确认原文约定；不改动原文展示式。 本次仅审校所附声明签名与定义，不执行工程编译，不补证明；sorry不作为签名不通过理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.chainRule`：已证；`MD.Ch02.chainRule_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1152)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-SymplecticComposition · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> Thus the composition of any pair of symplectic maps is a symplectic map.

### 3. 原文证明

原书无独立完整证明。
> by the chain rule, hence

$$
[(\Phi_1\circ\Phi_2)^\prime]^T J(\Phi_1\circ\Phi_2)^\prime=[\Phi_1^\prime\Phi_2^\prime]^T J\Phi_1^\prime\Phi_2^\prime=\Phi_2^{\prime T}\Phi_1^{\prime T}J\Phi_1^\prime\Phi_2^\prime=\Phi_2^{\prime T}J\Phi_2^\prime=J.
$$


原书在结论前给出链式法则和保持辛矩阵的连续等式推导，无独立编号证明；推导记录于 proof\_discussion\_latex。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticComposition {Nc : ℕ}
    {Φ Ψ : SymplecticCoordinates Nc → SymplecticCoordinates Nc}
    (hΦ : IsTextbookSymplecticMap Φ) (hΨ : IsTextbookSymplecticMap Ψ) :
    IsTextbookSymplecticMap (Φ ∘ Ψ) := by
  apply MolecularDynamics.IsTextbookSymplecticMap.comp <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticComposition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意自然数Nc（含0），相空间为(Fin Nc⊕Fin Nc)→ℝ；Φ、Ψ为同一空间自映射，两个前提各含全局C¹及每一点DΦᵀJDΦ=J，结论是Φ∘Ψ全局C¹且逐点保J。textbookJacobian为标准基下Fréchet导数矩阵，J=[0 I;-I 0]，与dq∧dp一致。复合次序正确，无额外假设。原书省略Jacobian求值点的记号按链式法则解释。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticComposition`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1168)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-SymplecticInverse · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> and the inverse of a symplectic map is symplectic since $\Phi'^TJ\Phi'=J$ implies $J=\Phi'^{-T}J\Phi'^{-1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticInverse {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  apply MolecularDynamics.IsTextbookSymplecticEquiv.symm <;> assumption



/-- 修正版，对应原文 MD-2.3.5-SymplecticInverse。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symplecticInverse_corrected {Nc : ℕ}
    {e : Equiv.Perm (SymplecticCoordinates Nc)} (he : IsTextbookSymplecticEquiv e) :
    IsTextbookSymplecticEquiv e.symm := by
  apply MolecularDynamics.IsTextbookSymplecticEquiv.symm <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticInverse`；`MD.Ch02.symplecticInverse_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]e为确实全局双射且e和e⁻¹可微的辛微分同胚；原文前句从det非零推出全球逆无效，另项字面保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Lean对任意Nc、实际双射e，假设e全局C¹且保J，并另有e.symm全局C¹，结论给出逆映射保J以及其逆C¹；这个受限定理正确，[EXTRA]已披露。可是本页上下文把Jacobian非奇异当作全局可逆的理由；此Lean没有证明原文所暗含的任意保辛自映射均有全球逆。矩阵恒等式与映射可逆性必须分开，保留原书疑误供人工处理。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticInverse`：已证；`MD.Ch02.symplecticInverse_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1177)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.5-GlobalGroupPrinted · unnumbered_claim · 印刷p.79 / PDFp.101

### 2. 原文陈述

> The determinant of a symplectic map is $\pm1$, hence these maps are always invertible, and the inverse of a symplectic map is symplectic since $\Phi'^TJ\Phi'=J$ implies $J=\Phi'^{-T}J\Phi'^{-1}$. Thus the symplectic maps form a group under composition.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem globalGroupPrinted : ∀ n (Φ : SymplecticCoordinates n → SymplecticCoordinates n),
    IsTextbookSymplecticMap Φ → Function.Bijective Φ ∧
      IsTextbookSymplecticMap (Function.invFun Φ) := by
  sorry



/-- 修正版，对应原文 MD-2.3.5-GlobalGroupPrinted。改动：只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。 -/
```

独立修正版：

```lean
theorem globalGroupPrinted_corrected (n : ℕ)
    (e : SymplecticCoordinates n ≃ SymplecticCoordinates n)
    (he : IsTextbookSymplecticMap e) (hi : ContDiff ℝ 1 e.symm) :
    IsTextbookSymplecticMap e.symm := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.globalGroupPrinted`；`MD.Ch02.globalGroupPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。 | [EXTRA] |

[EXTRA] [ERRATUM?] 只对已给全局双射且逆C¹的辛微分同胚断言逆辛；逐点非奇异不推出任意保辛自映射全局满射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch02\_deps.txt：SymplecticForm.lean 第33–41行将 SymplecticCoordinates n 定义为 (Fin n ⊕ Fin n) → ℝ（q 后 p），矩阵为该指标上的实方阵，textbookJ=[[0,I],[-I,0]]；第138–139行 IsTextbookSymplectic A 是 AᵀJA=J。SymplecticMaps.lean 第238–241行 textbookJacobian 是实际 Fréchet 导数 fderiv 的坐标矩阵，第272–274行 IsTextbookSymplecticMap Φ 是 ContDiff ℝ 1 Φ ∧ ∀ z, DΦ(z)ᵀJDΦ(z)=J，不含全球双射。 Ch02.lean 第859–862行量词为所有 n、所有 C¹ 辛自映射，推出全球双射及选择逆 Function.invFun Φ 为 C¹ 辛映射。在双射假设成立时 invFun 是真实唯一逆，但辛假设本身不保证双射。[ERRATUM?] 成立，正式谓词确实允许下面 n=1 的光滑反例。这一假命题保留了原书全球可逆性疑误，命题为假本身不等于错误转录；独立的签名忠实性问题是本条 statement\_scope 包含原句全部展示主张，而签名没有明示“Jacobian 行列式 ±1”子句，也未给实际群对象/群结构。行列式由 deps 第312–316行可推出更强的逐点 det=1，闭合、单位与逆可另由本批前项及库群构造组合，但这些未成为本声明的完整结论。故按全部结论子句审计 FAIL。deps 第366–382行已经提供由真正全球辛微分同胚构成的 Subgroup 及其复合运算，可用于另列修正版。正文直接 sorry：这单独表示证明未完成，不作为 FAIL 的理由，也不尝试补证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.globalGroupPrinted`：未证（原书疑误不证）；`MD.Ch02.globalGroupPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1193)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-SymplecticIntegrator · definition · 印刷p.80 / PDFp.102

### 2. 原文陈述

> A symplectic integrator is an approximation of the flow map that conserves the symplectic 2-form.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_symplecticIntegrator {n : ℕ}
    (H : SymplecticCoordinates n → ℝ) (F : Flow ℝ (SymplecticCoordinates n))
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) : Prop :=
  ContDiff ℝ 2 H ∧
  (∀ t z, HasDerivAt (fun s ↦ F s z) (textbookHamiltonianVectorField H (F t z)) t) ∧
  ∃ δ > 0, (∀ h ∈ Ioo 0 δ, bp_IsSymplecticMap (G h)) ∧
    ∃ r : ℝ, 0 < r ∧ ∀ z, ∃ K ≥ 0, ∃ d > 0, d ≤ δ ∧
      ∀ h ∈ Ioo 0 d, ‖G h z - F h z‖ ≤ K * h^(r+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticIntegrator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。 | [EXTRA] |

[EXTRA] [EXTRA] 补实际Hamiltonian流、正阶局部一致性及可用正步长域；保辛性质与数值近似资格合取，C²为充分[EXTRA]，未把无关辛映射冒充积分方法。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；n任意；H在整个相空间C²，F是已给全球Flow并在所有t,z满足Hamilton方程。存在统一δ>0，对每个0<h<δ的G h要求可微且逐点保J；存在一个对所有z通用的实数r>0，每个z另有K≥0和0<d≤δ，使0<h<d时误差≤K*h^(r+1)。这确实把保辛与实际流的正阶局部近似合取；G 0、负步长、全局误差、对z一致误差没有被声称。全球流、C²及正步长范围均属已明示的充分限定。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticIntegrator`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1213)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-SymplecticEuler · definition · 印刷p.80 / PDFp.102

### 2. 原文陈述

> The following scheme is a slight modification of the Euler method.

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\tag{2.18}
$$



$$
\boldsymbol P=\boldsymbol p+hF(\boldsymbol q).\tag{2.19}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_symplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) :
    SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookPositionDrift m h ∘ textbookMomentumKick (textbookPotentialForce U) h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_symplecticEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开 Ch02\_deps.txt:568–571，positionProjection z i=z(inl i)；583–586，PotentialForce U q i=−DU(q)(e\_i)；619–630，kick 保持 q 并在旧 q 计算 P\_i=p\_i+hF\_i(q)，drift 保持 P 并给 Q\_i=q\_i+h(m\_i)⁻¹P\_i。Ch02.lean:869–872 的复合先 kick 后 drift，与 PDF102/印刷80 的(2.18)、(2.19)两式及 F=−∇U 完全相符，且与 deps:733–737 的 textbookSymplecticEuler 同一定义。m,U,h 是固定参数，不存在质量对位置的隐含依赖或隐式求解存在性承诺。定义对任意实数质量及任意 U 总化：零质量逆元为0，不可微处 fderiv 为0；这是教材有效域外的扩展，在可逆对角质量及可微势的教材域内没有改变公式，不作为额外物理实例宣称。无 [EXTRA]/[ERRATUM?]，本定义无 sorry；原书正文小写 q 疑误仍由原样保留的 A 审阅记录，不影响原两式。版本绑定：Blueprint/Ch02.lean 的实际附件副本为 /workspace/Ch02.lean，按该副本原始字节计算哈希；未修改附件。本次为定义展开后的只读签名语义审计，未编译工程，不将无直接 sorry 等同于全部依赖证明已验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_symplecticEuler`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1223)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-KickDifferential · unnumbered_claim · 印刷p.81 / PDFp.103

### 2. 原文陈述

> then

$$
dQ_i=dq_i+hm_i^{-1}dP_i,\tag{2.20}
$$



$$
dP_i=dp_i-h\sum_{j=1}^{N_c}\frac{\partial^2U}{\partial q_j\partial q_i}dq_j.\tag{2.21}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kickDifferential : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    ContDiff ℝ 2 U → ∀ ξ : SymplecticCoordinates n, ∀ i : Fin n,
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inl i) =
        ξ (Sum.inl i)+h*(m i)⁻¹*((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) ∧
      ((fderiv ℝ (textbookSymplecticEuler m U h) z) ξ) (Sum.inr i) =
        ξ (Sum.inr i)-h*((fderiv ℝ (grad U) (z ∘ Sum.inl)) (ξ ∘ Sum.inl)) i := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.kickDifferential` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²，实际Hessian。 | [EXTRA] |

[EXTRA] U C²，实际Hessian。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:876–882 的量词顺序为任意 n,m,U,h,z，在 U C² 后任意切向量 ξ、任意 i，结论为两式合取。已展开 Q=Fin n→ℝ（deps:2816）、坐标 inl=q/inr=p（33）、grad U q i=DU(q)(e\_i)（2932）、实际完整 Euler 步（733–737）及负梯度（583–586）。令 δq=ξ∘inl，则 D(grad U)(q)[δq]_i=∑_j ∂_j∂_i U(q)δq\_j：由有限维基展开及实际梯度导数得出，不是任意假设 Hessian。第一结论为 δQ\_i=δq\_i+h(m\_i)⁻¹δP\_i，第二为 δP\_i=δp\_i−h∑_j ∂_j∂_i U δq\_j，完整覆盖 PDF103/印刷81 的(2.20)、(2.21)，均针对整个步映射的实际 fderiv。[EXTRA] 全局 C² 保证势力 C¹及二阶导数，是合理充分条件，但强于单点计算所需，不能称为最低必要条件。固定对角质量来自模型；任意 m 的总化扩展在非零质量域完全一致，零质量仍满足扩展后的导数恒等式。无 [ERRATUM?]。该声明体有 sorry，证明未完成，独立于签名 PASS。版本绑定：Blueprint/Ch02.lean 的实际附件副本为 /workspace/Ch02.lean，按该副本原始字节计算哈希；未修改附件。本次为定义展开后的只读签名语义审计，未编译工程，不将无直接 sorry 等同于全部依赖证明已验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.kickDifferential`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1230)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-WedgeSelf · unnumbered_claim · 印刷p.81 / PDFp.103

### 2. 原文陈述

> but $du\wedge du\equiv0$ for any $u$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem wedgeSelf :
  ∀ n (α : SymplecticCoordinates n →ₗ[ℝ] ℝ) u v, textbookWedgeOneForms α α u v = 0 := by
  exact MolecularDynamics.Chapter02Review.wedgeSelf_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.wedgeSelf` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；deps:73–76 实际定义为 mul 双线性形式经 α,β 复合减去经 β,α 复合，故值为 α(u)β(v)−β(u)α(v)，等于78–82中的 α(u)β(v)−α(v)β(u)。取 β=α，实数乘法交换给零。Ch02.lean:885–887 对所有 n、线性一形式 α 及两切向量 u,v 量化，是 PDF103/印刷81 的 du∧du≡0 的正确逐点推广；在任一点取 α=du 即涵盖原句，不需要额外正则性假设来证明该代数恒等式。无 [EXTRA]/[ERRATUM?]。本体 exact wedgeSelf\_proved；deps:3172–3173 的 statement 和3360起的证明已提供，不以名称替代展开。声明无直接 sorry，未运行编译。版本绑定：Blueprint/Ch02.lean 的实际附件副本为 /workspace/Ch02.lean，按该副本原始字节计算哈希；未修改附件。本次为定义展开后的只读签名语义审计，未编译工程，不将无直接 sorry 等同于全部依赖证明已验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.wedgeSelf`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1239)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.6-SymplecticEulerPreserves · unnumbered_claim · 印刷p.81 / PDFp.103

### 2. 原文陈述

> This implies that

$$
\sum_{i=1}^{N_c}dQ_i\wedge dP_i=\sum_{i=1}^{N_c}dq_i\wedge dp_i,
$$


> which means that the method is symplectic.

### 3. 原文证明

原书无独立完整证明。
> Computing the 2-form,

$$
dQ_i\wedge dP_i=dq_i\wedge dP_i+hm_i^{-1}dP_i\wedge dP_i;
$$


> but $du\wedge du\equiv0$ for any $u$, hence

$$
dQ_i\wedge dP_i=dq_i\wedge dP_i;
$$


> and (2.21) implies

$$
dQ_i\wedge dP_i=dq_i\wedge dp_i-h\sum_{j=1}^{N_c}dq_i\wedge\frac{\partial^2U}{\partial q_j\partial q_i}dq_j.
$$


> It is then a simple exercise to show that

$$
\sum_{i=1}^{N_c}\sum_{j=1}^{N_c}dq_i\wedge\frac{\partial^2U}{\partial q_j\partial q_i}dq_j=0,
$$


> using the skew-symmetry of the wedge product and the fact that the Hessian matrix is symmetric.
原书给出保辛结论的计算性论证；其中 Hessian 双重求和为零明示留作 simple exercise，未逐项展开该消去计算。原论证完整转录在 proof\_discussion\_latex 中，不补写原书省略的演算。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerPreserves {Nc : ℕ}
    (m : Fin Nc → ℝ) (U : (Fin Nc → ℝ) → ℝ) (h : ℝ) (hU : ContDiff ℝ 2 U) :
    IsTextbookSymplecticMap (textbookSymplecticEuler m U h) := by
  apply MolecularDynamics.textbookSymplecticEuler_isSymplectic <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symplecticEulerPreserves` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²，固定对角质量；真实完整步映射。 | [EXTRA] |

[EXTRA] U C²，固定对角质量；真实完整步映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、固定对角系数m、势U、实步长h；hU要求U全局C²。完整步映射先动量kick p-h∇U(q)，后位置drift q+h m⁻¹P，输出保辛且C¹，与楔积求和结论一致。未假设正质量或非零质量；在教材非零质量域成立，Lean还把m=0按实数逆的总化定义扩展，保辛结论仍成立，不构成虚假定理。C²为充分[EXTRA]，应统一标记。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symplecticEulerPreserves`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1245)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-Adjoint · definition · 印刷p.81 / PDFp.103

### 2. 原文陈述

> Given any numerical integrator $\mathcal G_h$, consider the map

$$
\mathcal G_h^\dagger=\mathcal G_{-h}^{-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_adjoint {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm



/-- 修正版，对应原文 MD-2.3.7-Adjoint。改动：把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。 -/
```

独立修正版：

```lean
noncomputable def bp_adjoint_corrected {E : Type*} (G : ℝ → Equiv.Perm E) (h : ℝ) :
    Equiv.Perm E := (G (-h)).symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_adjoint`；`MD.Ch02.bp_adjoint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。 | [EXTRA] |

[EXTRA] [EXTRA]方法G每个可用h为实际Equiv.Perm；只在负步可逆时定义伴随，不能宣称任意步映射天然可逆。；[ERRATUM?] 把负步映射明示为Equiv可逆映射后定义伴随；不把任意数值积分器无条件当作全局可逆。原书any表述和Euler反例保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；E任意类型，G为每个实数步长都取实际置换的族；对任意h输出(G(-h)).symm，负号及求逆顺序完全符合定义。全球双射族比教材局部可逆方法强，[EXTRA]已披露，不会把任意非可逆一步法直接变成置换。这个定义只给伴随运算，不主张其精度或所有数值法可逆。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_adjoint`：定义；`MD.Ch02.bp_adjoint_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1253)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-FlowSelfAdjoint · unnumbered_claim · 印刷p.82 / PDFp.104

### 2. 原文陈述

> For the flow map $\mathcal F_h$, we know that the inverse map is precisely $\mathcal F_{-h}$, so $\mathcal F_h^\dagger=\mathcal F_h$, i.e. the flow map is in the normal sense “self-adjoint,” i.e. symmetric.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowSelfAdjoint {E : Type*} [TopologicalSpace E]
    (F : Flow ℝ E) : textbookAdjointMethod (textbookFlowMethod F) = textbookFlowMethod F := by
  apply MolecularDynamics.textbookFlowMethod_isSelfAdjoint <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.flowSelfAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。 | [EXTRA] |

[EXTRA] [EXTRA]给定全球Flow群；原文局部流若无全球存在，须在正负步都可用域解释，未宣称所有ODE有全球流。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意拓扑空间E及实参数全球Flow F；textbookFlowMethod F h=(F.toHomeomorph h).toEquiv。结论是整族函数相等，对全部实h有(F(-h))⁻¹=F(h)，完整表达自伴随。Flow按标准群作用含义采信；全球存在是已披露[EXTRA]，并非给任意ODE无条件断言全球存在。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.flowSelfAdjoint`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1264)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-BackwardEuler · definition · 印刷p.82 / PDFp.104

### 2. 原文陈述

> The adjoint method is defined by

$$
\boldsymbol Z=\boldsymbol z+hf(\boldsymbol Z),
$$


> and where the first was explicit, the second is implicit (it is the so-called backward Euler method).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_backwardEulerRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w = z + h • f w
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_backwardEulerRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意有限维Q n=Fin n→ℝ、任意向量场f、实h及输入z、输出w，关系w=z+h•f(w)逐分量正是隐式Euler方程。原文只给隐式方程，context\_notation明确不声称存在唯一解，因而用Prop关系而非无条件的输出函数合适；first/second指代与前句显式Euler一致。它不证明全局逆存在，也没有作此断言。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_backwardEulerRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1269)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-EulerAdjoint · unnumbered_claim · 印刷p.82 / PDFp.104

### 2. 原文陈述

> In particular, consider Euler’s method

$$
\boldsymbol Z=\boldsymbol z+hf(\boldsymbol z).
$$


> The adjoint method is defined by

$$
\boldsymbol Z=\boldsymbol z+hf(\boldsymbol Z),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerAdjoint (f : E → E) (G : ℝ → Equiv.Perm E)
    (h : ℝ) (hG : ∀ Z, G (-h) Z = eulerStep f (-h) Z) (z Z : E) :
    textbookAdjointMethod G h z = Z ↔ Z = z + h • f Z := by
  apply MolecularDynamics.euler_adjoint_iff_backward <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。 | [EXTRA] |

[EXTRA] [EXTRA]给定负步Euler实际双射；G(-h)与Euler映射逐点一致，不假设所有f/h可逆。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:14、912–916给出实赋范向量空间E及任意f、双射族G、h；先要求∀Z,G(-h)Z=eulerStep f (-h)Z，再对任意z,Z给出双向等价。Ch02\_deps.txt:897–898展开eulerStep为x+h•f x，1240–1245展开负步逆，所以左式等价于Z-h•f Z=z，移项恰为Z=z+h•f Z。没有颠倒初态/终态或量词，也未要求正步Euler等于G(h)。[EXTRA]只需负步Euler可逆；全步双射族为已明示的接口加强。可逆性不能省，例如E=ℝ,f(x)=x,h=1时负步Euler恒零。无[ERRATUM?]；包装证明及1284–1288复用证明无显式sorry，语义判断独立于证明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.eulerAdjoint`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1273)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-AdjointSymplecticEuler · definition · 印刷p.82 / PDFp.104

### 2. 原文陈述

> Its adjoint method has a similar structure:

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\tag{2.22}
$$



$$
\boldsymbol P=\boldsymbol p+hF(\boldsymbol Q).\tag{2.23}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_adjointSymplecticEuler {Nc : ℕ}
    (m : Fin Nc → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) :
    Equiv.Perm (SymplecticCoordinates Nc) :=
  textbookAdjointMethod (textbookSymplecticEulerEquiv m U) h

theorem bp_adjointSymplecticEuler_coordinates {Nc : ℕ}
    (m : Fin Nc → ℝ) (hm : ∀ i, 0 < m i)
    (U : (Fin Nc → ℝ) → ℝ) (hU : Differentiable ℝ U)
    (h : ℝ) (z : SymplecticCoordinates Nc) :
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inl i) =
      z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i)) ∧
    (∀ i, (bp_adjointSymplecticEuler m hm U hU h z) (Sum.inr i) =
      z (Sum.inr i) - h * fderiv ℝ U
        (fun j ↦ z (Sum.inl j) + h*(m j)⁻¹*z (Sum.inr j)) (Pi.single i 1)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_adjointSymplecticEuler`；`MD.Ch02.bp_adjointSymplecticEuler_coordinates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。 | [EXTRA] |

[EXTRA] [EXTRA] 本条显式正质量及U经典可微，并补原文(Q,P)两条坐标公式；原总化正式辅助Equiv保持，新增坐标陈述暂sorry。Mathlib Flow按用户标准含义直接采信，FlowSelfAdjoint只补材料复审。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；同时审查定义bp\_adjointSymplecticEuler和定理bp\_adjointSymplecticEuler\_coordinates。任意Nc，正质量hm、全局可微势hU、任意实h与初态z；伴随是原kick后drift置换在-h处的逆，故正步先drift后kick。结论两个∀i分别为Q\_i=q\_i+h m\_i⁻¹p\_i与P\_i=p\_i-h DU(Q)e\_i，求值位置Q及负号均正确。定义中的\_hm、_hU虽不参与计算，但定理显式携带这些前提。[EXTRA]充分且合理；sorry只表示未证明，不据此判签名失败。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_adjointSymplecticEuler`：定义；`MD.Ch02.bp_adjointSymplecticEuler_coordinates`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1280)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.7-AdjointInvolution · unnumbered_claim · 印刷p.82 / PDFp.104

### 2. 原文陈述

> the adjoint of the adjoint is the original method:

$$
\mathcal G_h^{\dagger\dagger}=[\mathcal G_{-h}^\dagger]^{-1}=[\mathcal G_h^{-1}]^{-1}=\mathcal G_h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem adjointInvolution {E : Type*} (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookAdjointMethod G) = G := by
  apply MolecularDynamics.textbookAdjointMethod_involutive <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.adjointInvolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际可逆步方法族Equiv.Perm；负步及双逆确实存在。 | [EXTRA] |

[EXTRA] 实际可逆步方法族Equiv.Perm；负步及双逆确实存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；E任意类型，G:ℝ→Equiv.Perm E为全实步长实际可逆族；结论是伴随算子连续作用两次后的整族等式。逐h计算为((G(-(-h))).symm).symm=G h，量词、负步长及双逆齐全。全实可逆族为充分[EXTRA]，当前元数据应加统一标记。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.adjointInvolution`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1299)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-Splitting · definition · 印刷p.83 / PDFp.105

### 2. 原文陈述

> Let $H(\boldsymbol q,\boldsymbol p)=H_1(\boldsymbol q,\boldsymbol p)+H_2(\boldsymbol q,\boldsymbol p)$ have flow map $\mathcal F_h$, and indicate by $\mathcal F_h^1,\mathcal F_h^2$ the flow maps for the systems with Hamiltonians $H_1,H_2$, respectively. The proposal is that the map

$$
\mathcal G_h=\mathcal F_h^1\circ\mathcal F_h^2
$$


> is an approximation of $\mathcal F_h$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_splittingMap {E : Type*} (F₁ F₂ : ℝ → E → E) (h : ℝ) : E → E := F₁ h ∘ F₂ h

theorem bp_splittingMap_eq (F₁ F₂ : ℝ → E → E) (h : ℝ) :
    bp_splittingMap F₁ F₂ h = splittingMap F₁ F₂ h := rfl

theorem bp_splittingMap_apply (F₁ F₂ : ℝ → E → E) (h : ℝ) (u : E) :
    bp_splittingMap F₁ F₂ h u = F₁ h (F₂ h u) := rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 组合构造定义；与MD-2.4.1-SplittingLocal跨条共同覆盖带真实Hamilton子流前提的近似结论。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_splittingMap`；`MD.Ch02.bp_splittingMap_eq`；`MD.Ch02.bp_splittingMap_apply` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。 | [EXTRA] |

[EXTRA] [EXTRA] 本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。

### 6. 审计结论

本轮修复：本条只定义组合构造；Hamilton子流资格及O(h²)近似由MD-2.4.1-SplittingLocal / MD.Ch02.splittingLocal共同覆盖。新增rfl桥接核对与该条所用F₁ h (F₂ h u)及splittingMap一致，不从任意函数族推断Hamilton流。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_splittingMap仅对任意类型E和任意两个函数族F₁、F₂定义F₁ h∘F₂ h，复合公式本身正确。但本条statement\_scope含整个引句：H=H₁+H₂、三者Hamilton流及近似结论；当前声明没有H、H₁、H₂、总流F、ODE/Flow前提或任何近似性质。context\_notation把精度交给下一条是合理分工说明，却没有建立本条定义与下一条splittingLocal的形式联系；该定理还使用独立的splittingMap定义。按要求核对完整结论，不能把纯组合构造视作全部数学断言已形式化。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_splittingMap`：定义；`MD.Ch02.bp_splittingMap_eq`：已证；`MD.Ch02.bp_splittingMap_apply`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1305)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-FieldAdd · unnumbered_claim · 印刷p.83 / PDFp.105

### 2. 原文陈述

> $J\nabla H=J\nabla H_1+J\nabla H_2$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem fieldAdd {Nc : ℕ}
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (h₁ : DifferentiableAt ℝ H₁ z) (h₂ : DifferentiableAt ℝ H₂ z) :
    textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) z =
      textbookHamiltonianVectorField H₁ z + textbookHamiltonianVectorField H₂ z := by
  apply MolecularDynamics.textbookHamiltonianVectorField_add <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.fieldAdd` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H₁,H₂在实际点可微，实际Fréchet梯度。 | [EXTRA] |

[EXTRA] H₁,H₂在实际点可微，实际Fréchet梯度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开deps:33、38–39、1921附近：坐标为(Fin Nc ⊕ Fin Nc)→ℝ，inl为q、inr为p；J为块矩阵[0,I;−I,0]；向量场为J乘以各基向量Pi.single i 1上的实际Fréchet导数。因此正是J∇H，而非任意名为梯度的参数。两项在同一点z可微保证fderiv(H₁+H₂)=fderiv H₁+fderiv H₂，结论逐坐标为所需加法。H由H₁+H₂直接构造，无遗漏H分解条件。[EXTRA]可微是原文梯度存在的合理资格，避免不可微处fderiv总化；无[ERRATUM?]。正文调用库定理，无直接sorry，未作编译或全依赖无sorry认证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.fieldAdd`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1316)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SplittingLocal · unnumbered_claim · 印刷p.83 / PDFp.105

### 2. 原文陈述

> For this to be a first order method, we need at least $\|\mathcal G_h(\boldsymbol u)-\mathcal F_h(\boldsymbol u)\|\le C(\boldsymbol u)h^2$.

### 3. 原文证明

> Expand $\mathcal F_h(\boldsymbol u)$ in a Taylor series:

$$
\mathcal F_h(\boldsymbol u)=\boldsymbol u+hJ\nabla H+\mathcal O(h^2)=\boldsymbol u+h(J\nabla H_1+J\nabla H_2)+\mathcal O(h^2).\tag{2.24}
$$


> On the other hand,

$$
\mathcal F_h^1(\boldsymbol u)=\boldsymbol u+hJ\nabla H_1(\boldsymbol u)+\mathcal O(h^2),\qquad\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+\mathcal O(h^2).
$$


> Composing the maps we have

$$
\mathcal F_h^1\circ\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+hJ\nabla H_1(\boldsymbol u+hJ\nabla H_2(\boldsymbol u))+\mathcal O(h^2).
$$


> Assuming $H_1$ is $C^2$, we have

$$
\mathcal F_h^1\circ\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+h(J\nabla H_2(\boldsymbol u)+J\nabla H_1(\boldsymbol u))+\mathcal O(h^2),
$$


> which agrees with the expansion (2.24) of the flow map through the terms of first order. Thus the splitting method does indeed provide a second order local approximation of the flow map.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem splittingLocal {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2)) := by
  exact MolecularDynamics.exists_hamiltonian_splitting_localError_bound
    D hD H₁ H₂ hH₁ hH₂ F F₁ F₂ u hτ hFD hF₂D hF₁D hF hF₂ hF₁ hc hinit hinit₂ hinit₁
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.splittingLocal` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。 | [EXTRA] |

[EXTRA] 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、开放域D，H₁,H₂在D上C²；u任意但由F 0 u=u与留域条件保证u∈D。τ≥0，F在[0,τ]上满足H₁+H₂的ODE，F₂满足H₂，F₁在F₂(s,u)出发的整矩形轨道满足H₁；初值、留域、矩形联合连续条件齐备。结论存在C>0使所有0≤h≤τ的实际复合与总流差≤C h²，τ>0还给右侧h→0的O(h²)。常数可依赖u及固定输入，未假设待证误差。τ=0时只需初值相等，BigO有τ>0前提，未把退化区间当作局部渐近结论。C²双势、留域及连续性均为充分[EXTRA]；原书second order local指O(h²)，不误读成全局二阶。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.splittingLocal`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1325)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-KineticFlow · Example 2.4 · 印刷p.83 / PDFp.105

### 2. 原文陈述

> Let

$$
H_1(\boldsymbol q,\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2,\qquad H_2(\boldsymbol q,\boldsymbol p)=U(\boldsymbol q),
$$


> then a splitting method for $H=H_1+H_2$ may be obtained by determining the flow maps for each of the two parts. For $H_1$ we have the differential equations

$$
\dot{\boldsymbol q}=M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol0.
$$


> The second equation tells us that $\boldsymbol p$ is constant, so it is fixed at its initial value, whereas the first equation says that $\boldsymbol q$ evolves on a linear path, hence its flow map is

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\qquad\boldsymbol P=\boldsymbol p.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)

def kineticHamiltonian {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  ∑ i, (z (Sum.inr i))^2/(2*m i)

theorem bp_kineticFlow_initial {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_kineticFlow m 0 z = z := by
  funext i
  cases i <;> simp [bp_kineticFlow]

theorem bp_kineticFlow_hamiltonian {Nc : ℕ} (m : Fin Nc → ℝ)
    (_hm : ∀ i, 0 < m i) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_kineticFlow m s z)
      (textbookHamiltonianVectorField (kineticHamiltonian m) (bp_kineticFlow m t z)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_kineticFlow`；`MD.Ch02.momentumKickDerivative`；`MD.Ch02.momentumKick_hasFDerivAt`；`MD.Ch02.kineticHamiltonian`；`MD.Ch02.bp_kineticFlow_initial`；`MD.Ch02.bp_kineticFlow_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。 | [EXTRA] |

[EXTRA] [EXTRA] 保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。

### 6. 审计结论

本轮修复：保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_kineticFlow对任意Nc、m、h、z给出Q\_i=q\_i+h(m\_i)⁻¹p\_i与P\_i=p\_i，坐标公式正确。另两条private声明momentumKickDerivative和momentumKick\_hasFDerivAt只论任意C¹力F的kick导数：位置投影不变，动量导数为dp+h DF(q)dq，其类型及前提合理，但与动能Hamilton流识别无关。全部声明均没有H₁=pᵀM⁻¹p/2、H=H₁+H₂、时间ODE或流初值/群律结论，不能核验引句的完整Hamilton流断言。m非零只在context文字中，不是Lean前提；零质量总化可作代数扩展，不能被称为教材M的实际逆。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_kineticFlow`：定义；`MD.Ch02.momentumKickDerivative`：定义；`MD.Ch02.momentumKick_hasFDerivAt`：已证；`MD.Ch02.kineticHamiltonian`：定义；`MD.Ch02.bp_kineticFlow_initial`：已证；`MD.Ch02.bp_kineticFlow_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1352)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-PotentialFlow · definition · 印刷p.84 / PDFp.106

### 2. 原文陈述

> Similarly, the flow map of the system with Hamiltonian $H_2=U$ is

$$
\boldsymbol Q=\boldsymbol q,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_potentialFlow {Nc : ℕ} (U : Q Nc → ℝ)
    (h : ℝ) : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookMomentumKick (textbookPotentialForce U) h

def potentialHamiltonian {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  U (textbookPositionProjection Nc z)

theorem bp_potentialFlow_initial {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_potentialFlow U 0 z = z := by
  funext i
  cases i <;> simp [bp_potentialFlow, textbookMomentumKick]

theorem bp_potentialFlow_hamiltonian {Nc : ℕ} (U : Q Nc → ℝ)
    (_hU : ContDiff ℝ 1 U) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_potentialFlow U s z)
      (textbookHamiltonianVectorField (potentialHamiltonian U) (bp_potentialFlow U t z)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_potentialFlow`；`MD.Ch02.potentialHamiltonian`；`MD.Ch02.bp_potentialFlow_initial`；`MD.Ch02.bp_potentialFlow_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。 | [EXTRA] |

[EXTRA] [EXTRA] 原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。

### 6. 审计结论

本轮修复：原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_potentialFlow对任意Nc、任意势U及实h返回kick(-fderiv U)。展开得到Q=q、P\_i=p\_i-h(fderiv ℝ U q)e\_i，符号、坐标次序正确。但是声明没有U可微前提，也没有H₂=U∘位置投影及HasDerivAt/Flow性质；fderiv在不可微点总化，不能无条件等同经典梯度。因此它只定义候选公式，没有完整覆盖原书“system with Hamiltonian H₂=U”的实际流断言。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_potentialFlow`：定义；`MD.Ch02.potentialHamiltonian`：定义；`MD.Ch02.bp_potentialFlow_initial`：已证；`MD.Ch02.bp_potentialFlow_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1399)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SplitEuler · unnumbered_claim · 印刷p.84 / PDFp.106

### 2. 原文陈述

> The composition of these maps simplifies to

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q),
$$


> which is precisely the Symplectic Euler method. Similarly, composing the same two maps in the opposite order gives the adjoint Symplectic Euler method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem splitEuler :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z) := by
  exact MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.splitEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n,m,U,h，两个函数等式均审查：splittingMap drift kick=原辛Euler（先kick后drift），splittingMap kick drift=伴随辛Euler（先drift后kick）。textbookSymplecticEulerEquiv采用置换乘法即函数复合，逆使顺序交换；输出P在原法drift中使用，伴随法在新位置Q施力。Q n和坐标直和空间转换无混淆。结论只是代数函数相等，故不需要U可微或m≠0来保证这个总化恒等式；物理质量/经典梯度解释应限定教材域。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.splitEuler`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1419)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-VerletComposition · Example 2.5 (Verlet is Symplectic) · 印刷p.84–85 / PDFp.106–107

### 2. 原文陈述

> For the Symplectic Euler method $\mathcal G_h$ and its adjoint method $\mathcal G_h^\dagger$, consider the composition

$$
\mathcal K_h:=\mathcal G_{h/2}^\dagger\circ\mathcal G_{h/2}.
$$



### 3. 原文证明

> Let

$$
\begin{bmatrix}\bar{\boldsymbol q}\\\bar{\boldsymbol p}\end{bmatrix}=\mathcal G_{h/2}\begin{bmatrix}\boldsymbol q\\\boldsymbol p\end{bmatrix},
$$


> i.e.,

$$
\bar{\boldsymbol q}=\boldsymbol q+(h/2)M^{-1}\bar{\boldsymbol p},\qquad\bar{\boldsymbol p}=\boldsymbol p-(h/2)\nabla U(\boldsymbol q).
$$


> and set

$$
\begin{bmatrix}\boldsymbol Q\\\boldsymbol P\end{bmatrix}=\mathcal G_{h/2}^\dagger\begin{bmatrix}\bar{\boldsymbol q}\\\bar{\boldsymbol p}\end{bmatrix},
$$


> i.e.,

$$
\boldsymbol Q=\bar{\boldsymbol q}+(h/2)M^{-1}\bar{\boldsymbol p},\qquad\boldsymbol P=\bar{\boldsymbol p}-(h/2)\nabla U(\boldsymbol Q).
$$


> The composition simplifies to

$$
\bar{\boldsymbol p}=\boldsymbol p-\frac h2\nabla U(\boldsymbol q),\qquad\boldsymbol Q=\boldsymbol q+hM^{-1}\bar{\boldsymbol p},\qquad\boldsymbol P=\bar{\boldsymbol p}-\frac h2\nabla U(\boldsymbol Q).
$$


> This is just the leapfrog/Verlet method in its Hamiltonian form.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletComposition :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z) := by
  exact MolecularDynamics.Chapter02Review.verletComposition_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletComposition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n,m,U,h,z，两个合取均正确：coordinateVerlet=pack(verlet(...)(unpack z))，且等于G†_(h/2)(G_(h/2)z)。前者的位置更新q+h m⁻¹p+(h²/2)m⁻¹F(q)，动量更新p+(h/2)(F(q)+F(Q))与两次半kick一次全drift一致；后者是kick(h/2)∘drift(h/2)∘drift(h/2)∘kick(h/2)，次序没有倒置。任意力函数的代数恒等式不需要正则性；U、零质量的总化扩展同上一条，不在本结论中声称实际Hamilton流或精度。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.verletComposition`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1428)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-VerletSymplectic · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Since we have obtained the method as the composition of two symplectic maps, and the symplectic maps form a group, we know that this method will also be symplectic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletSymplectic :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) := by
  exact MolecularDynamics.Chapter02Review.verletSymplectic_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²；真实完整步映射。 | [EXTRA] |

[EXTRA] U C²；真实完整步映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n、任意固定对角m、任意势U、实h，在U全局C²下，coordinateVerlet的完整kick(h/2)∘drift(h)∘kick(h/2)是C¹且逐点DΦᵀJDΦ=J。不是只验证某个子步。U C²为充分[EXTRA]，各实步长及零维均包括；零质量的总化仍使drift为保辛剪切，不使定理为假。原句借群性说明结论，在本例两个子法确有显式逆；保辛结论不需要一般保辛自映射都全球可逆。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.verletSymplectic`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1438)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SymmetricComposition · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> When we construct a composition of a method with its adjoint method, we see readily that it is symmetric, i.e. self-adjoint, since

$$
\mathcal K_h^{\dagger}:=[\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2}]^{\dagger}=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2}=\mathcal K_h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricComposition {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G := by
  apply MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symmetricComposition` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际可逆步Equiv.Perm；完整伴随半步组合。 | [EXTRA] |

[EXTRA] 实际可逆步Equiv.Perm；完整伴随半步组合。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意类型E及所有实步长的实际可逆映射；伴随为G(-h)的逆，组合为G†(h/2)乘G(h/2)，Perm乘法对应先右后左。结论为整个步族的自伴随等式，半步、次序和负步长均正确。Equiv.Perm为已披露的可逆资格。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symmetricComposition`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1445)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SymmetricEven · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Self-adjoint, or symmetric schemes have unique features; in particular they have even order [164, 227].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricEven :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
  sorry



/-- 修正版，对应原文 MD-2.4.1-SymmetricEven。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symmetricEven_corrected :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.symmetricEven`；`MD.Ch02.symmetricEven_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Q n为有限维实空间；r为正自然数，G、F均实际可逆且联合C∞，F具有群律。逐点局部误差O(|h|^(r+1))且非O(|h|^(r+2))编码有限确切阶；光滑自伴随族的首个非零局部误差次数为奇数，故r偶。群律与可逆性推出F 0=id；正阶误差推出G 0=id。加强条件已标EXTRA，结论合理；原句省略有限确切阶资格须保留提醒。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.symmetricEven`：未证（原书疑误不证）；`MD.Ch02.symmetricEven_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1455)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.2-CompositionSymplectic · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> More generally, if we have any two symplectic numerical methods, say $\mathcal G_h^1$ and $\mathcal G_h^2$, then the composition

$$
\mathcal G_h:=\mathcal G_{h/2}^1\circ\mathcal G_{h/2}^2
$$


> is another symplectic numerical method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compositionSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h) := by
  apply MolecularDynamics.textbookComposeMaps_isSymplectic <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.compositionSymplectic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、两族全实步长C¹辛映射，h为任意实数。项目定义用标准J及DΦᵀ J DΦ=J；textbookComposeMaps确为G₁(h/2)∘G₂(h/2)。结论包括复合C¹及每点Jacobian保辛，域和复合方向完整。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.compositionSymplectic`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1483)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.2-CompositionOrder · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> The order of this method is typically the minimum of the orders of the two methods involved, but it can be higher, as the example of the Verlet method (constructed by composing symplectic Euler and its adjoint) shows.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compositionOrder :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
  sorry



/-- 修正版，对应原文 MD-2.4.2-CompositionOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem compositionOrder_corrected :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.compositionOrder`；`MD.Ch02.compositionOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]两个方法逼近同一实际流；第一个方法1+L\|h\|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]两个方法逼近同一实际流；第一个方法1+L|h|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开全部本条自定义对象：Chapter02Review.Q n = Fin n → ℝ，r、s为自然数；F是每个实时间的双射族，假设∀h k z, F h(F k z)=F(h+k)z，因此F 0=id。G₁、G₂是任意方法族，不要求辛；这是阶数估计的合理推广。methodLocalOrder G F r 实为 ∀z, ∃C>0, ∃δ>0, ∀h, |h|<δ → ‖G h z−F h z‖≤C|h|^(r+1)，是每个固定初值的局部截断误差下界，C与δ可依赖z，既非确切阶也非全局误差阶。textbookComposeMaps 展开为G₁(h/2)∘G₂(h/2)。实际量词顺序为n,F,G₁,G₂,r,s，然后流律、两条逐点局部阶假设、G₁稳定假设，结论只有同一逐点局部意义的min r s阶下界。[EXTRA]同一实际流合理，误差传播稳定条件合理作为充分条件，但实际稳定性为∀δ>0 ∃L≥0 ∀|h|<δ ∀u v，与原文未言明的全域空间稳定性及每个有限步长区间要求相比明显更强；证明局部阶通常只需某个小δ，不能称该全部额外强度必要。逐点误差常数不能直接用于随h移动的初值F(h/2)z，若采用通常的误差分解证明，还需补足邻域一致性或另给严格论证；本审计不据此断言定理数学上为假。确定的FAIL理由是全部结论未覆盖：至少min阶仅允许、没有断言或展示严格更高阶的实例；原文明确的Verlet由辛Euler及其伴随复合并达到更高阶未表达，typically也未形式化为任何泛型结论。原文statement\_scope覆盖整句，不能以[EXTRA]注释把整句缩成下界定理而仍判完全忠实。无[ERRATUM?]，未发现需要据此修改原书的错误。Ch02.lean 1059–1065与本批签名一致，含直接sorry；证明缺口与上述签名语义FAIL分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.compositionOrder`：未证（原书疑误不证）；`MD.Ch02.compositionOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1493)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.3-HarmonicSplit · definition · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Some systems can be decomposed into a harmonic (quadratic) part $H_0(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T M^{-1}\boldsymbol p/2+\boldsymbol q^T A\boldsymbol q/2$ and an anharmonic part $H_1(\boldsymbol q,\boldsymbol p)=\breve U(\boldsymbol q)$. Then a splitting method can be formulated based on exact solution of the linear system together with “kicks” representing impulses defined by the anharmonic part. For a simple system consisting of a harmonic oscillator $H_0(q,p)=p^2/2+\Omega^2q^2/2$, such a method can be written

$$
\begin{bmatrix}Q\\\hat p\end{bmatrix}=\begin{bmatrix}\cos h\Omega&\frac{1}{\Omega}\sin h\Omega\\-\Omega\sin h\Omega&\cos h\Omega\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix},\qquad P=\hat p-h\breve U'(Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_harmonicAnharmonic (Ω : ℝ) (_hΩ : Ω ≠ 0) (U : ℝ → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_harmonicAnharmonic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。 | [EXTRA] |

[EXTRA] [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。；[EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义仅承担已明确限域的标量简例：Ω非零、U全域可微，任意实h及(q,p)。先按振子矩阵计算Q，再以同一Q计算P=−Ωsin(hΩ)q+cos(hΩ)p−h U′(Q)。不是在旧q施加kick。非零频率和可微资格均已披露；一般M,A分裂作为背景，不误作已形式化。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_harmonicAnharmonic`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1519)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-ImplicitLocal · unnumbered_claim · 印刷p.86 / PDFp.108

### 2. 原文陈述

> An implicit method will typically result in a system of nonlinear equations of the form

$$
g(\boldsymbol z_{n+1})=\boldsymbol\tau_n,\tag{2.25}
$$


> which will need to be solved at each timestep. The right hand side $\boldsymbol\tau_n$ is a vector that depends on the previous time-step $\boldsymbol z_n$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the space where $\boldsymbol z$ is defined, so we have a square nonlinear system. Typically $g$ will depend on the stepsize and coefficients of the method and will have the property that for $h$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $\boldsymbol\tau_n$, that is the mapping $g$ has a bounded and smooth inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem implicitLocal : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
  sorry



/-- 修正版，对应原文 MD-2.4.4-ImplicitLocal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem implicitLocal_corrected : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.implicitLocal`；`MD.Ch02.implicitLocal_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补g\_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。；[EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。；[EXTRA] 补g\_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；对每个n、联合C∞的g(h,x)、基点x及零步可逆导数A，存在统一小步长δ；每个小步长有开U,V包含x,g\_h(x)，MapsTo及双向逆等式。inv在V内C∞且函数值有界；可通过缩小局部邻域取得该界，不等于宣称全域逆有界。前提和局部性均明确，未假设所需逆已经存在。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.implicitLocal`：未证（原书疑误不证）；`MD.Ch02.implicitLocal_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1528)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-BackwardEulerSolve · Example 2.6 · 印刷p.86 / PDFp.108

### 2. 原文陈述

> The Backward Euler method,

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_{n+1}),
$$


> is an example of an implicit method. The calculation of a timestep involves solving a system of equations of the form

$$
g(\boldsymbol w)\equiv\boldsymbol w-\boldsymbol z_n-hf(\boldsymbol w)=\boldsymbol0.
$$


> The map $\mathcal G_t$ is defined implicitly by the equation

$$
\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\mathcal G_h(\boldsymbol z)).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w

theorem backwardEulerResidual_zero_iff (f : E → E) (h : ℝ) (z w : E) :
    backwardEulerResidual f h z w = 0 ↔ w = z + h • f w := by
  sorry

def backwardEulerMapRelation (f : E → E) (h : ℝ) (G : E → E) : Prop :=
  ∀ z, G z = z + h • f (G z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.backwardEulerResidual`；`MD.Ch02.backwardEulerResidual_zero_iff`；`MD.Ch02.backwardEulerMapRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。 | [EXTRA] |

[EXTRA] [EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；残差w−z−h•f(w)、其零点等价式、以及给定G的逐点隐式关系均吻合；未从定义推断解的存在唯一性。E的减法和实数作用按该表达式所需的实向量空间背景解释；摘录没有完整外围变量声明，本次仅作所给签名的语义核对。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.backwardEulerResidual`：定义；`MD.Ch02.backwardEulerResidual_zero_iff`：未证（缺大型理论）；`MD.Ch02.backwardEulerMapRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1559)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-Newton · definition · 印刷p.86–87 / PDFp.108–109

### 2. 原文陈述

> Solving the system may then proceed, from an initial guess $\boldsymbol z_{n+1}^{(0)}$ by use of Newton’s method:

$$
\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),
$$


> where $J^{(k)}$ is the Jacobian matrix of the mapping $g$ evaluated at $\boldsymbol z_n^{(k)}$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form

$$
\boldsymbol b_k=-(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),\quad J^{(k)}\Delta\boldsymbol z_k=\boldsymbol b_k,\quad\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}+\Delta\boldsymbol z_k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)



/-- 修正版，对应原文 MD-2.4.4-Newton。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def newtonPrinted_corrected {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newtonPrinted`；`MD.Ch02.newtonPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；newtonPrinted特意把当前被更新量xNext与残差求值量xPrev分开：xNext−J⁻¹(g(xPrev)−τ)，忠实保留原页n+1/n的混用，未擅改为标准Newton。J为连续线性同构对应可逆矩阵，也容纳所述可逆近似矩阵。原书的线性求解重写与该公式代数等价；未提供该等价的Lean定理，但定义没有错误变更字面公式。原书索引及“可逆映射所以Jacobian非奇异”的理由另须人工处理。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.newtonPrinted`：定义；`MD.Ch02.newtonPrinted_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1571)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-NewtonQuadratic · unnumbered_claim · 印刷p.87 / PDFp.109

### 2. 原文陈述

> Newton’s method (without approximation of the Jacobian matrix) has a remarkable quadratic convergence property, meaning that, when the initial guess is close the solution, the errors $e_k,e_{k+1}$ at the $k$th and $k+1$st iterations satisfy the relation

$$
e_{k+1}\le Ke_k^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newtonQuadratic :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newtonQuadratic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。 | [EXTRA] |

[EXTRA] [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意n、C²映射g、简单零点x及其可逆实际导数A；存在统一C,δ，对每个邻点y提供该点的可逆实际导数B，并给标准newtonStep g 0 y B的一步二次误差界。不是近似Jacobian，且不复用Printed版的错位索引。缩小δ可保证Cδ<1而获得持续迭代；所列EXTRA充分。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.newtonQuadratic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1582)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-FrozenNewton · unnumbered_claim · 印刷p.87 / PDFp.109

### 2. 原文陈述

> For example, if the Jacobian matrix is large and can be written in the form

$$
J(\boldsymbol z)=D+E(\boldsymbol z),
$$


> where $E$ is small in norm and $D$ is a constant sparse matrix, then, in many cases, the Jacobian matrix may be replaced by the constant matrix $D$ and the iteration will still converge.
> This rapid convergence is typically lost when the Jacobian matrix is approximated in some way, and one finds instead

$$
e_{k+1}\le\rho e_k,
$$


> where $0<\rho<1$, i.e., quadratic convergence is replaced by geometric convergence.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenNewton :
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 < ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.frozenNewton` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。 | [EXTRA] |

[EXTRA] [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1106–1111；依赖展开Q n=Fin n→ℝ及newtonStep g 0 y A=y−A.symm(g y)。A为固定D的可逆线性算子，x为残差零点；先固定δ,ρ，再要求δ>0、0<ρ<1、g为C¹以及整个球内‖I−A⁻¹g′(y)‖≤ρ，最后对每个球内y断言一步误差收缩。fderiv为实际导数，C¹保证其不是不可微时的默认值；comp表示先作用g′再作用A⁻¹。若g′=D+E，界等于‖−D⁻¹E‖≤ρ，明确了small必须相对于D的逆尺度，属于合理[EXTRA]，不是仅把所求误差界重写为前提。凸球上的导数界给出一步界，ρ<1保证球不变，归纳得e\_k≤ρ^k e\_0，涵盖几何收敛。常数矩阵稀疏和维数大是计算成本背景，不是收敛所必需；任意近似Jacobian均收敛并未被断言。依赖frozenNewton\_statement使用0≤ρ，实际声明使用原文0<ρ，按实际声明审计。定理含sorry，签名PASS与证明完成无关。

### 7. 状态与证明位置

incomplete；`MD.Ch02.frozenNewton`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1591)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-Conjugacy · definition · 印刷p.88 / PDFp.110

### 2. 原文陈述

> In general, we say that two maps $A$ and $B$ are conjugate if there is a homeomorphism $\chi$ such that

$$
A=\chi^{-1}\circ B\circ\chi.
$$


> A homeomorphism is a continuous bijection which has a continuous inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_conjugateMap (χ : E ≃ₜ E) (B : E → E) : E → E := χ.symm ∘ B ∘ χ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_conjugateMap` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1114 的正文为 χ.symm ∘ B ∘ χ。E 是实赋范空间，其拓扑已由实例给定；χ:E≃ₜE 包含双逆律及正逆连续性。构造函数明确给出原文共轭关系的右端，关系本身可由 ∃χ, A=bp\_conjugateMap χ B 表示；作为此定义的构造型编码可以接受。依赖 ProcessedMethods.lean 的 textbookConjugateMap（合集:1652）正文完全相同，不凭名称推断。无额外动力学假设，无[ERRATUM?]；定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_conjugateMap`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1599)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ConjugateIterates · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> Conjugate maps have the property that their iterates are also conjugate, since

$$
A^n=(\chi^{-1}\circ B\circ\chi)^n=(\chi^{-1}\circ B\circ\chi)\circ(\chi^{-1}\circ B\circ\chi)\circ\cdots\circ(\chi^{-1}\circ B\circ\chi)=\chi^{-1}\circ B^n\circ\chi.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conjugateIterates (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.conjugateIterates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；χ为实际Homeomorph，A、B为同一E上的自映射，假设A=χ⁻¹∘B∘χ；对任意自然数n（包括0），结论为函数等式A^[n]=χ⁻¹∘B^[n]∘χ。抵消方向和复合顺序正确。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.conjugateIterates`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1602)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ConjugateLimits · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> If $A$ and $B$ are maps of phase space, then the conjugacy implies that they have equivalent stability properties under iteration, since if $B^n(\boldsymbol z_0)\to\boldsymbol z^*$, as $n\to\infty$, for all initial points $\boldsymbol z_0$, then also $A^n(\boldsymbol z_0)\to\chi^{-1}(\boldsymbol z^*)$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conjugateLimits (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar)) := by
  intro z
  apply (MolecularDynamics.textbook_conjugate_iterates_tendsto_iff χ A B hA z (χ.symm zStar)).mpr
  simpa using hB (χ z)



/-- 修正版，对应原文 MD-2.4.5-ConjugateLimits。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem conjugateLimits_corrected (χ : E ≃ₜ E) (A B : E → E) (hA : A=textbookConjugateMap χ B)
    (zStar : E) (hB : ∀ z, Tendsto (fun k : ℕ => B^[k] z) atTop (𝓝 zStar)) :
    ∀ z, Tendsto (fun k : ℕ => A^[k] z) atTop (𝓝 (χ.symm zStar)) := by
  intro z
  apply (MolecularDynamics.textbook_conjugate_iterates_tendsto_iff χ A B hA z (χ.symm zStar)).mpr
  simpa using hB (χ z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.conjugateLimits`；`MD.Ch02.conjugateLimits_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；展开 textbookConjugateMap 后，签名的具体收敛命题忠实：先固定共同极限zStar，再假设∀z，B^[k] z→zStar，最后∀z，A^[k] z→χ⁻¹zStar。B轨道应从χ z出发；全称hB使这一换初值合法。ProcessedMethods.lean 的 textbook\_conjugate\_iterates\_tendsto\_iff（合集:1672附近）确实给对应初值和对应极限的双向收敛，并利用χ及χ⁻¹的连续性。所有实际用到的项目定义已找到，缺的不是库定义。需要数学判断的原文问题是 statement\_scope 中“equivalent stability properties under iteration”是否只指随后给出的全局共同极限例子，还是还要求一般Lyapunov稳定性、吸引性等性质的双向等价；签名仅明确形式化随后例子的单向结论，没有这些一般稳定性谓词。若来源范围只限该例子可判PASS；若包含一般稳定性断言则缺条款。无[ERRATUM?]；本地与所引收敛定理均无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.conjugateLimits`：已证；`MD.Ch02.conjugateLimits_corrected`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1609)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-EulerConjugacy · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> As an illustration, the Symplectic Euler method turns out to be conjugate to the Verlet method (see Exercise 12).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerConjugacy :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ textbookSymplecticEuler m U h ∘
      textbookMomentumKick (textbookPotentialForce U) (-h/2) = coordinateVerlet m (textbookPotentialForce U) h := by
  intro n m U h
  funext z
  let F := textbookPotentialForce U
  let q : Q n := fun i => z (Sum.inl i)+h*(m i)⁻¹*
    (z (Sum.inr i)+(h/2)*F (textbookPositionProjection n z) i)
  have hl : textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))=q := by
    funext i
    simp [q,F,textbookPositionProjection,textbookSymplecticEuler,
      textbookMomentumKick,textbookPositionDrift,Function.comp_def]
    ring <;> simp
  have hr : textbookPositionProjection n
      (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))=q := by
    funext i
    simp [q,textbookPositionProjection,textbookPositionDrift,textbookMomentumKick]
  funext i
  rcases i with i | i
  · change textbookPositionProjection n
      (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z)) i =
        textbookPositionProjection n (textbookPositionDrift m h (textbookMomentumKick F (h/2) z)) i
    rw [hl,hr]
  · change textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z) (Sum.inr i)+
      (h/2)*F (textbookPositionProjection n
        (textbookSymplecticEuler m U h (textbookMomentumKick F (-h/2) z))) i =
      textbookMomentumKick F (h/2) z (Sum.inr i)+(h/2)*F (textbookPositionProjection n
        (textbookPositionDrift m h (textbookMomentumKick F (h/2) z))) i
    rw [hl,hr,textbookSymplecticEuler_momentum,textbookPositionProjection_momentumKick]
    simp [F,textbookMomentumKick]
    ring

theorem eulerConjugacy_homeomorph (n : ℕ) (m : Fin n → ℝ)
    (_hm : ∀ i, 0 < m i) (U : Q n → ℝ)
    (_hF : Continuous (textbookPotentialForce U)) (h : ℝ) :
    ∃ χ : SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ z, χ z = textbookMomentumKick (textbookPotentialForce U) (-h/2) z) ∧
      (∀ z, χ.symm z = textbookMomentumKick (textbookPotentialForce U) (h/2) z) ∧
      coordinateVerlet m (textbookPotentialForce U) h =
        χ.symm ∘ textbookSymplecticEuler m U h ∘ χ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerConjugacy`；`MD.Ch02.eulerConjugacy_homeomorph` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 原代数恒等式及证明完整保留；补正质量、连续力资格下的真实Homeomorph见证、双向kick及共轭方向。新结论暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；同时审查代数恒等式与homeomorph版本。kick记为K、drift为D，Euler=D\_h∘K\_h；K_(h/2)∘Euler∘K_(-h/2)=K_(h/2)∘D\_h∘K_(h/2)=Verlet。后一定理取χ=K_(-h/2)，连续力保证正负kick连续且互逆；正质量已明列。所有n,m,U,h量词及共轭方向正确。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerConjugacy`：已证；`MD.Ch02.eulerConjugacy_homeomorph`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1628)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-Processing · definition · 印刷p.88 / PDFp.110

### 2. 原文陈述

> Let us suppose that we have such a conjugacy between two numerical methods $\mathcal G_h$ and $\tilde{\mathcal G}_h$, that is

$$
\mathcal G_h=\chi_h^{-1}\circ\tilde{\mathcal G}_h\circ\chi_h,
$$


> defined in such a way that $\mathcal G_h$ has order $r$ and $\tilde{\mathcal G}_h$ has order $s$ where $s<r$. Then, given an initial condition $\boldsymbol z_0$, we first modify (“pre-process”) this to $\tilde{\boldsymbol z}_0=\chi_h(\boldsymbol z_0)$, then take multiple steps with the method $\tilde{\mathcal G}_h$, and finally transform (“post-process”) the end result by $\chi_h^{-1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_processedIterate (χ : ℝ → E ≃ₜ E) (B : ℝ → E → E)
    (h : ℝ) (z₀ : E) (n : ℕ) : E :=
  (χ h).symm (oneStepIterate B h ((χ h) z₀) n)

def processingData (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (F : Flow ℝ E) (f : E → E) (r s : ℕ) : Prop :=
  0 < s ∧ s < r ∧
  (∀ t z, HasDerivAt (fun u ↦ F u z) (f (F t z)) t) ∧
  (∀ h, G h = textbookProcessedMethod χ B h) ∧
  methodLocalOrder G (fun h ↦ F h) r ∧ methodLocalOrder B (fun h ↦ F h) s ∧
  ¬ methodLocalOrder B (fun h ↦ F h) (s+1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_processedIterate`；`MD.Ch02.processingData` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。 | [EXTRA] |

[EXTRA] [EXTRA] 保留预/后处理算法；补实际ODE流与共轭、正低阶s<r、高阶G及低阶B相对同一精确流F的局部阶资格，¬s+1明确低阶而非仅下界；不以共轭误差结论为假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；bp\_processedIterate为χ\_h⁻¹(B\_h^[n](χ_h z₀))，先预处理再迭代再后处理；n=0也恢复z₀。processingData增加共同实际ODE流F、共轭关系、0<s<r、G的至少r阶及B的确切s阶局部误差资格。属于原文所假设的数据，未凭共轭无条件推出任意提高阶数。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_processedIterate`：定义；`MD.Ch02.processingData`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1674)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ProcessingIterates · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> The resulting approximation will be of order $r$ even though all timestepping was performed using a lower order method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem processingIterates (χ : ℝ → E ≃ₜ E)
    (B G : ℝ → E → E) (hG : ∀ h, G h = textbookProcessedMethod χ B h)
    (h : ℝ) (z₀ : E) (n : ℕ) :
    textbookProcessedIterate χ B h z₀ n = oneStepIterate G h z₀ n := by
  apply MolecularDynamics.textbookProcessedIterate_eq_of_conjugacy <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅预处理/迭代/后处理与G的精确迭代恒等式；同一所引原句的阶数结论及低阶资格由MD-2.4.5-ProcessingOrder完整承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.processingIterates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。 | [EXTRA] |

[EXTRA] [EXTRA] 本条明确仅承担算法与G迭代的精确恒等式；同一原句的r阶及低阶资格完整归MD-2.4.5-ProcessingOrder，保留原句不删并记录跨条映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；该条已在statement\_scope明确只承担精确迭代恒等式；所有χ,B,G,h,z₀,n及逐h共轭假设均完整。等式左端按同一步长先χ\_h、迭代B\_h、后χ\_h⁻¹，右端迭代G\_h；阶数部分由紧邻第13条单独承接，未在这里误声称已从恒等式推出误差估计。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.processingIterates`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1688)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-ProcessingOrder · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> The resulting approximation will be of order $r$ even though all timestepping was performed using a lower order method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem processingOrder (χ : ℝ → E ≃ₜ E) (B G : ℝ → E → E)
    (hG : ∀ h, G h=textbookProcessedMethod χ B h) (γ : ℝ → E) (τ : ℝ) (_hτ : 0 < τ) (r s : ℕ) (_hs : 0 < s) (_hsr : s < r)
    (F : Flow ℝ E) (f : E → E) (_hdata : processingData χ B G F f r s)
    (_hγ : ∀ t, γ t = F t (γ 0))
    (_hB : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError B (τ/ν) γ ν ≤ C*(τ/ν)^s)
    (horder : ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      oneStepMaxError G (τ/ν) γ ν ≤ C*(τ/ν)^r) :
    (∀ h ν, textbookProcessedMaxError χ B h γ ν=oneStepMaxError G h γ ν) ∧
    (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
      textbookProcessedMaxError χ B (τ/ν) γ ν ≤ C*(τ/ν)^r) := by
  have heq := MolecularDynamics.textbookProcessedMaxError_eq_of_conjugacy χ B G hG
  refine ⟨fun h ν => heq h γ ν, ?_⟩
  simpa only [heq] using horder
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.processingOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r自然数有限时间窗误差界；χh为实际Homeomorph。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。 | [EXTRA] |

[EXTRA] r自然数有限时间窗误差界；χh为实际Homeomorph。；[EXTRA] 补正时间窗与低阶B的s阶误差资格及0<s<r；原G高阶假设和两项误差转移结论、已证证明均保留。processingData另给严格低阶的一般方法资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；正时间窗τ、0<s<r、实际共轭与共同ODE流及轨迹资格均有列出。horder假定G的全网格全局r阶，这是原文“G有r阶”的资格，结论通过精确迭代恒等式转移给后处理算法；不是从B的s阶单独推出r阶。额外\_hB和processingData提供低阶背景但不用于等式转移，逻辑上可冗余。最大误差包括0至ν所有节点；两个结论与该范围一致。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.processingOrder`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1697)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.5-EulerEffectiveOrder · unnumbered_claim · 印刷p.88 / PDFp.110

### 2. 原文陈述

> One sometimes refers to the “effective order” of a numerical method as the order attainable via processing, thus the effective order of the Symplectic Euler method would be two.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerEffectiveOrder : ∀ n (m : Fin n → ℝ) (U : Q n → ℝ)
    (γ : ℝ → SymplecticCoordinates n) τ,
    positiveMass m → ContDiff ℝ 4 U → 0 < τ →
    (∀ t ∈ Icc 0 τ, HasDerivWithinAt γ
      (textbookHamiltonianVectorField (fun z => (∑ i, z (Sum.inr i)^2/m i)/2+
        U (z ∘ Sum.inl)) (γ t)) (Icc 0 τ) t) → ContinuousOn γ (Icc 0 τ) →
    ∃ χ : ℝ → SymplecticCoordinates n ≃ₜ SymplecticCoordinates n,
      (∀ h, textbookProcessedMethod χ (textbookSymplecticEuler m U) h =
        coordinateVerlet m (textbookPotentialForce U) h) ∧
      (∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        textbookProcessedMaxError χ (textbookSymplecticEuler m U) (τ/ν) γ ν ≤ C*(τ/ν)^2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.eulerEffectiveOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。 | [EXTRA] |

[EXTRA] [EXTRA]正固定质量，U C⁴；真实机械Hamilton轨迹及紧时间窗；处理器为实际Homeomorph，完整processed误差界，不以待证二阶作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开全部项目定义：Q n=Fin n→ℝ；SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ，以inl为q、inr为p；positiveMass m=∀i,0<m\_i；J=[[0,I],[−I,0]]；Hamilton场=J∇H。因此H=Σp\_i²/(2m\_i)+U(q)产生q′_i=p\_i/m\_i、p′_i=−∂_i U，与Euler及Verlet的质量和力符号一致。Euler=D\_h K\_h，Verlet=K_{h/2} D\_h K_{h/2}。processed一步法是χ\_h⁻¹ Euler\_h χ\_h，可取χ\_h=K_{−h/2}；C⁴势能确保力连续，正逆kick均连续，故存在的χ确可为Homeomorph。量词先固定n/m/U/真实轨迹γ及正时间τ，满足全部轨迹假设后再存在处理器与误差常数。processed最大误差覆盖从γ(0)出发的全部0≤k≤ν、物理时间kτ/ν；结论为至少二阶的整个网格误差界，不循环假设二阶收敛。[EXTRA]正固定质量排除机械奇异质量，C⁴为足够而非最弱光滑性，τ>0和真实轨迹给有限正时间窗；ContinuousOn提供紧轨迹像（在此导数条件下可冗余）；均合理。原文“order attainable via processing”在此表示可达到二阶，不声称任何特殊系统的最高可能阶恰为二，无需阶上界。无[ERRATUM?]。签名语义PASS独立于证明完成度：Ch02.lean:1206附近的该证明有sorry，本次未证明、编译或消除这一义务；依赖正文检索未发现sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch02.eulerEffectiveOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1714)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RK · definition · 印刷p.89 / PDFp.111

### 2. 原文陈述

> The family of Runge-Kutta methods for solving $\dot{\boldsymbol z}=f(\boldsymbol z)$ is defined by

$$
\boldsymbol Z=\boldsymbol z+h\sum_{i=1}^s b_i\boldsymbol F_i,
$$


> where the vectors $\boldsymbol F_i$, $i=1,\ldots,s$, are computed by solving the system

$$
\boldsymbol F_i=f\left(\boldsymbol z+h\sum_{j=1}^s a_{ij}\boldsymbol F_j\right),\qquad i=1,\ldots,s.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_rungeKuttaRelation {n s : ℕ} (f : Q n → Q n) (A : Matrix (Fin s) (Fin s) ℝ)
    (b : Fin s → ℝ) (h : ℝ) (z w : Q n) (F : Fin s → Q n) : Prop :=
  (∀ i, F i = f (z + h • ∑ j, A i j • F j)) ∧ w = z + h • ∑ i, b i • F i
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_rungeKuttaRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q n在deps:2816明确为Fin n→ℝ，有限维实向量空间。Ch02:1206–1209的∀i阶段方程及输出方程与deps:2900–2902和原文两式逐项相同；Fin s只是索引重编号。关系以给定F为参数，不断言隐式系统存在或唯一；无额外假设或勘误。此条为定义，无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_rungeKuttaRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1728)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RK4 · definition · 印刷p.89 / PDFp.111

### 2. 原文陈述

> An example of a popular 4th order explicit method is the choice of matrix $A$ with coefficients $a_{ij}\equiv 0$ except $a_{21}=1/2$, $a_{32}=1/2$ and $a_{43}=1$, and $b_1=1/6$, $b_2=1/3$, $b_3=1/3$, $b_4=1/6$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) : Q n :=
  let k₁ := f z
  let k₂ := f (z + (h/2) • k₁)
  let k₃ := f (z + (h/2) • k₂)
  let k₄ := f (z + h • k₃)
  z + (h/6) • (k₁ + (2 : ℝ) • k₂ + (2 : ℝ) • k₃ + k₄)

theorem bp_rk4_eq_rk4 {n : ℕ} (f : Q n → Q n) (h : ℝ) (z : Q n) :
    bp_rk4 f h z = MolecularDynamics.Chapter02Review.rk4 f h z := rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 四阶段公式定义；四阶结论由MD-2.5.1-RK4Order跨条共同覆盖，bp\_rk4\_eq\_rk4给出同一算法映射。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_rk4`；`MD.Ch02.bp_rk4_eq_rk4` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp\_rk4\_eq\_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。 | [EXTRA] |

[EXTRA] [EXTRA] 算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp\_rk4\_eq\_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。

### 6. 审计结论

本轮修复：算法定义与MD-2.5.1-RK4Order / MD.Ch02.rk4Order共同覆盖原句；新增定义相等桥接bp\_rk4\_eq\_rk4，使四阶声明所用rk4与本条公式明确对应。四阶定理原证明状态独立保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；四阶段定义正确展开a21=a32=1/2,a43=1及权重1/6,1/3,1/3,1/6，对任意有限维实向量场f、h,z有效。但本条完整当前Lean只有算法定义，未包含原句的四阶结论；context\_notation称“四阶陈述单列”，本任务给出的同一source\_id全部声明中没有该条或可核对的映射。因完整结论覆盖缺失判FAIL，而非算法公式错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_rk4`：定义；`MD.Ch02.bp_rk4_eq_rk4`：已证。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1734)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RK4Order · unnumbered_claim · 印刷p.89 / PDFp.111

### 2. 原文陈述

> An example of a popular 4th order explicit method

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rk4Order :
  ∀ n (f : Q n → Q n) (γ : ℝ → Q n) τ, compactTrajectory f γ τ → globalOrder (rk4 f) γ τ 4 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.rk4Order` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]compactTrajectory实际C⁶向量场与紧窗实际轨迹；高阶资格强于原文简写。 | [EXTRA] |

[EXTRA] [EXTRA]compactTrajectory实际C⁶向量场与紧窗实际轨迹；高阶资格强于原文简写。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；展开deps:2816,2824–2826,2941–2945：compactTrajectory包含τ>0、f全局C⁶、γ在[0,τ]内满足HasDerivWithinAt γ (f(γ t))、γ在该窗连续；紧区间连续像为紧，未把误差作为前提。rk4为与bp\_rk4相同的实际四阶段映射。globalOrder为∃C>0 ∃ν₀>0 ∀ν≥ν₀，整个网格0,…,ν的最大误差≤C(τ/ν)^4；oneStepIterate=(G h)^[k](γ 0)，oneStepMaxError是实际节点范数误差的有限最大值（deps:1443–1463）。量词表达固定轨迹、固定正时间窗的全局四阶上界。[EXTRA] C⁶强于必要正则性，作为充分资格合理；不要求原文未提供的任意隐式求解。无勘误。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.rk4Order`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1747)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-ExplicitRK · unnumbered_claim · 印刷p.89 / PDFp.111

### 2. 原文陈述

> This method is not symplectic, and it is in fact impossible to find symplectic explicit methods within the Runge-Kutta family.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem explicitRK :
  ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, i ≤ j → A i j = 0) → (∑ i, b i) = 1 →
    ∃ (H : SymplecticCoordinates 1 → ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1)
      (stages : SymplecticCoordinates 1 → Fin s → SymplecticCoordinates 1) (h : ℝ),
      ContDiff ℝ ∞ H ∧ 0 < h ∧
      (∀ z, (∀ i, stages z i = textbookHamiltonianVectorField H (z+h • ∑ j, A i j • stages z j)) ∧
        G z = z+h • ∑ i, b i • stages z i) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.explicitRK` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] [EXTRA]一致性∑bᵢ=1排除全零权重恒等映射；“不辛”解释为存在光滑Hamilton模型与实际阶段/步映射不辛，不宣称每个具体H均不辛。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意有限阶段数s、严格下三角A及一致性∑b=1，存在一自由度的光滑Hamilton量、正h及满足真实RK阶段方程的全域G使G非辛。量词正确表达不能对所有Hamilton系统保辛，允许某些特殊系统恰好保辛。∑b=1是必要的非平凡一致性资格，原extra\_assumptions为空，需补记。原书“不能找到”的措辞也应按一致RK方法理解。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.explicitRK`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1754)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RKSymplectic · unnumbered_claim · 印刷p.89–90 / PDFp.111–112

### 2. 原文陈述

> Let us emphasize that, while a typical RK method is not symplectic, some implicit Runge-Kutta methods are symplectic. The precise condition that must be satisfied [325] is

$$
b_i a_{ij}+b_j a_{ji}=b_i b_j,\qquad i=1,\ldots,s,\quad j=1,\ldots,s.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rkSymplectic : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) ↔
    (∀ n (H : SymplecticCoordinates n → ℝ) (h : ℝ)
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G) := by
  sorry



/-- 修正版，对应原文 MD-2.5.1-RKSymplectic。改动：保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。 -/
```

独立修正版：

```lean
theorem rkSymplectic_corrected : ∀ s (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ),
    (∀ i j, b i*A i j+b j*A j i=b i*b j) →
    (∀ n (H : SymplecticCoordinates n → ℝ) (h : ℝ)
      (G : SymplecticCoordinates n → SymplecticCoordinates n)
      (stages : SymplecticCoordinates n → Fin s → SymplecticCoordinates n),
      ContDiff ℝ 2 H → ContDiff ℝ 1 G →
      (∀ i, ContDiff ℝ 1 (fun z => stages z i)) →
      (∀ z, (∀ i, stages z i=textbookHamiltonianVectorField H
        (z+h • ∑ j, A i j • stages z j)) ∧ G z=z+h • ∑ i, b i • stages z i) →
      IsTextbookSymplecticMap G) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.rkSymplectic`；`MD.Ch02.rkSymplectic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H C²；真实阶段函数与完整步G C¹且确实满足RK关系。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。 | [EXTRA] |

[EXTRA] H C²；真实阶段函数与完整步G C¹且确实满足RK关系。；[ERRATUM?] 保留系数条件的充分方向，删除对可约Butcher表不成立的必要性；未建设不可约表理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开依赖：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，textbookJ=[[0,I],[-I,0]]；Hamilton向量场为J乘以实际fderiv的坐标梯度；textbookJacobian为实际fderiv矩阵，IsTextbookSymplecticMap为C¹且每点D Gᵀ J D G=J（deps:33–42,138–139,238–241,272–275,1921–1926）。 Ch02:1239–1248确实断言系数条件与所有维度、Hamilton量、实h及C¹实际求解映射/阶段的辛性等价；正则性[EXTRA]适于充分性，却不能修复对可约方法的必要性。正式deps:3230–3240只给充分性，不能替代Blueprint中的更强iff。无条件逆向为假，原条NECESSITY\_QUALIFICATION疑误已由展开语义下的明确反例确认。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.rkSymplectic`：未证（原书疑误不证）；`MD.Ch02.rkSymplectic_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1768)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussFamily · Example 2.7 (family) · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The Gauss-Legendre family of Runge-Kutta (GLRK) methods correspond to approximating the vector field at the Gauss points, i.e. the zeros of the orthogonal polynomials that arise in Gaussian quadrature. As these points are symmetrically distributed the GLRK schemes are symmetric, hence have even order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussFamily :
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ (∃ r : ℕ, 0 < r ∧ Even r ∧ methodLocalOrder G F r) := by
  sorry



/-- 修正版，对应原文 MD-2.5.1-GaussFamily。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem gaussFamily_corrected :
  ∀ n s (c : Fin s → ℝ) (f : Q n → Q n) (F G : ℝ → Q n → Q n), 0 < s →
    Function.Injective c → (∀ i, c i ∈ Ioo (0 : ℝ) 1 ∧ legendreValue s (2*c i-1) = 0) →
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ (Function.uncurry G) →
    (∀ h z, ∃! data : Q n × (Fin s → Q n),
      rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
        (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z data.1 data.2) →
    (∀ h z, ∃ stages, rungeKuttaRelation f (fun i j => ∫ t in (0 : ℝ)..c i, lagrangeBasis c j t)
      (fun j => ∫ t in (0 : ℝ)..1, lagrangeBasis c j t) h z (G h z) stages) →
    (∀ z, F 0 z = z ∧ ∀ t, HasDerivAt (fun u => F u z) (f (F t z)) t) →
    (∀ h z, G (-h) (G h z) = z) ∧ (∃ r : ℕ, 0 < r ∧ Even r ∧ methodLocalOrder G F r) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.gaussFamily`；`MD.Ch02.gaussFamily_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Legendre根节点、Lagrange积分系数；s>0，节点单射，C∞向量场和实际光滑G；真实唯一阶段及真实流资格。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际Legendre根节点、Lagrange积分系数；s>0，节点单射，C∞向量场和实际光滑G；真实唯一阶段及真实流资格。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Q=Fin n→ℝ、rungeKuttaRelation的实际阶段/输出方程（deps:2816,2900–2902），legendreValue按P₀=1、P₁=x及标准三项递推给出P\_s（3241–3244）；lagrangeBasis为∏_{k≠j}(t−c\_k)/(c\_j−c\_k)（3245–3246）。s>0、节点单射和P\_s(2c\_i−1)=0准确给出移位Gauss节点，积分系数准确对应配点法。methodLocalOrder（deps:3183–3186）展开为∀z ∃C>0 ∃δ>0 ∀|h|<δ，‖G h z−F h z‖≤C|h|^(r+1)，常数可依赖z；它是至少r阶的局部误差上界，不是确切阶。 Ch02:1253–1264保留反向步对称性，但∃正偶r且上述上界不表达实际阶的偶性；任意至少三阶方法也满足r=2。另[EXTRA]所有实h、所有z的唯一阶段/输出及全时间真实流远强于通常局部适用条件，实质遗漏大量光滑标准GLRK应用，不能仅称必要资格。无显式ERRATUM标记；这两项是形式化范围和结论问题。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.gaussFamily`：未证（原书疑误不证）；`MD.Ch02.gaussFamily_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1802)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-Midpoint · definition · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The simplest such method is the implicit midpoint rule:

$$
\boldsymbol Z=\boldsymbol z+h\boldsymbol F_1,\qquad\boldsymbol F_1=f\left(\boldsymbol z+\frac h2\boldsymbol F_1\right),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_midpointRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop :=
  w = z + h • f ((1/2 : ℝ) • (z+w))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_midpointRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Q=Fin n→ℝ（deps:2816），Ch02:1267–1268与正式midpointRelation（2910–2911）相同。原关系消去阶段后为w=z+h f((z+w)/2)；反向取F₁=f((z+w)/2)，利用w=z+hF₁得到z+(h/2)F₁=(z+w)/2。包括h=0，未除以h或断言任意系统可解。对象、量词和结论均忠实，无EXTRA或勘误；定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_midpointRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1836)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-MidpointProperties · unnumbered_claim · 印刷p.90 / PDFp.112

### 2. 原文陈述

> which has order 2.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem midpointProperties
    (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G F : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (U : Set (SymplecticCoordinates n)) (δ : ℝ) (_hδ : 0 < δ)
    (_hU : IsOpen U) (_hH : ContDiff ℝ 4 H)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      G h z = z+h • textbookHamiltonianVectorField H ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (textbookHamiltonianVectorField H (F t z)) t) :
    (∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    (∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3) := by
  sorry

theorem midpointProperties_generalODE (n : ℕ) (f : Q n → Q n)
    (G F : ℝ → Q n → Q n) (U : Set (Q n)) (δ : ℝ)
    (_hδ : 0 < δ) (_hU : IsOpen U) (_hf : ContDiff ℝ 3 f)
    (_hG : ContDiffOn ℝ 3 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U, G h z = z+h • f ((1/2 : ℝ) • (z+G h z)))
    (_hflow : ∀ z ∈ U, F 0 z = z ∧ ∀ t ∈ Ioo (-δ) δ,
      HasDerivAt (fun u ↦ F u z) (f (F t z)) t) :
    ∀ z ∈ U, ∃ C > 0, ∃ d > 0, d ≤ δ ∧ ∀ h : ℝ, |h| < d →
      ‖G h z-F h z‖ ≤ C*|h|^3 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.midpointProperties`；`MD.Ch02.midpointProperties_generalODE` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。 | [EXTRA] |

[EXTRA] [EXTRA]H C⁴，实际C¹求解映射及Hamilton解族；原文省略的资格明示。；[EXTRA] 补一般ODE局部二阶与Hamilton情形局部保辛；显式G0=id及实际方程、开状态域/小步长分支和真实流，移除全步长全初值解要求。C³分支及全域光滑场为充分[EXTRA]；二阶指至少二阶，非每个方程恰二阶。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两条定理均已核对：Hamilton版H C⁴、实际联合C³分支G、开U、小步长区间、G0=id、真实隐式中点方程和真实解族F；结论是该域每点Jacobian保辛及每个初值局部O(h³)。一般ODE版使用C³场与分支，给同样二阶局部界。不要求F在所有初值联合光滑，逐点ODE及场光滑已足够。保辛为局部域上的性质，并未错误要求G在U外C¹。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.midpointProperties`：未证（缺大型理论）；`MD.Ch02.midpointProperties_generalODE`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1842)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussTwo · definition · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The 4th order method ($s=2$) has coefficients

$$
b_1=b_2=\frac12,\qquad A=(a_{ij})=\begin{bmatrix}\frac14&\frac14-\frac{\sqrt3}6\\\frac14+\frac{\sqrt3}6&\frac14\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def gaussTwoData : Matrix (Fin 2) (Fin 2) ℝ × (Fin 2 → ℝ) :=
  (gaussTwoCoefficients, fun _ => 1/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.gaussTwoData` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；实际读取的 Blueprint/Ch02.lean 附件位于 /workspace/Ch02.lean，声明在1281–1282行。展开 Ch02\_deps.txt:2911–2912 的 gaussTwoCoefficients：Fin 2 按0、1索引，A₀₀=A₁₁=1/4，A₀₁=1/4−Real.sqrt 3/6，A₁₀=1/4+Real.sqrt 3/6；第二分量为两个实数权重均等于1/2。矩阵行是阶段索引i，列是求和阶段索引j，与 rungeKuttaRelation:2900–2903一致。完整A和b忠实于印刷p.90/PDFp.112展示公式；四阶结论由本批独立GaussTwoOrder条目承担。无额外假设、无ERRATUM标记或系数勘误。此def自身没有sorry；数据正确与四阶证明是否完成分开判断。

### 7. 状态与证明位置

self-contained；`MD.Ch02.gaussTwoData`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1872)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussTwoOrder · unnumbered_claim · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The 4th order method ($s=2$) has coefficients

$$
b_1=b_2=\frac12,\qquad A=(a_{ij})=\begin{bmatrix}\frac14&\frac14-\frac{\sqrt3}{6}\\\frac14+\frac{\sqrt3}{6}&\frac14\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem gaussTwoOrder (n : ℕ) (f : Q n → Q n) (G : ℝ → Q n → Q n)
    (γ : ℝ → Q n) (τ : ℝ) (_htrajectory : compactTrajectory f γ τ)
    (U : Set (Q n)) (δ : ℝ) (_hδ : 0 < δ) (_hU : IsOpen U)
    (_hcover : γ '' Icc 0 τ ⊆ U)
    (_hG : ContDiffOn ℝ 6 (Function.uncurry G) (Ioo (-δ) δ ×ˢ U))
    (_hzero : ∀ z ∈ U, G 0 z = z)
    (stages : ℝ → Q n → Fin 2 → Q n)
    (_hregular : ∀ i, ContDiffOn ℝ 6 (fun x : ℝ × Q n ↦ stages x.1 x.2 i)
      (Ioo (-δ) δ ×ˢ U))
    (_hstagezero : ∀ z ∈ U, ∀ i, stages 0 z i = f z)
    (_hstage : ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ U,
      rungeKuttaRelation f gaussTwoCoefficients (fun _ => 1/2) h z (G h z) (stages h z)) :
    globalOrder G γ τ 4 ∧
    (∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀, ∀ k ≤ ν,
      oneStepIterate G (τ/ν) (γ 0) k ∈ U) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.gaussTwoOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。 | [EXTRA] |

[EXTRA] [EXTRA]C⁶实际向量场/解轨迹，实际C⁶步族且满足阶段关系；实际求解资格，不把4阶误差作为前提。；[EXTRA] 改为紧轨迹开邻域U、δ小步长内的真实光滑阶段分支，显式G0=id；补充分细迭代留U，保留全网格四阶。C⁶分支为充分[EXTRA]，未无条件声称任意步长可解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两阶段A的四项与b=(1/2,1/2)正确；真实阶段及零步阶段值均明确。compactTrajectory提供τ>0、C⁶场、真实解及闭时间段连续性；开U覆盖紧轨迹，G与stages在小步长×U内C⁶、G0=id。结论为全网格O((τ/ν)^4)及充分细网格迭代留U，能由一致性、局部误差及紧轨迹邻域稳定性获得；没有把四阶界放进前提。globalOrder仅表示至少四阶，不是每个特定ODE恰四阶。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.gaussTwoOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1878)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-PartitionedVerlet · definition · 印刷p.90 / PDFp.112

### 2. 原文陈述

> As an illustration, consider the method:

$$
\hat{\boldsymbol P}=\boldsymbol p-\frac h2\nabla_qH(\boldsymbol q,\hat{\boldsymbol P}),\tag{2.26}
$$



$$
\boldsymbol Q=\boldsymbol q+\frac h2(\nabla_pH(\boldsymbol q,\hat{\boldsymbol P})+\nabla_pH(\boldsymbol Q,\hat{\boldsymbol P})),\tag{2.27}
$$



$$
\boldsymbol P=\hat{\boldsymbol P}-\frac h2\nabla_qH(\boldsymbol Q,\hat{\boldsymbol P}).\tag{2.28}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_partitionedVerletRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) (p : Q n) : Prop :=
  p = z.2 - (h/2) • partialQ H z.1 p ∧
  w.1 = z.1 + (h/2) • (partialP H z.1 p + partialP H w.1 p) ∧
  w.2 = p - (h/2) • partialQ H w.1 p
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_partitionedVerletRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；正式依赖展开：ReviewDefinitions.lean 第2816–2817行 Q n=Fin n→ℝ，Z n=Q n×Q n，第一分量为位置、第二分量为动量；第2913–2916行 partialQ/partialP 分别是固定另一变量后实际 Fréchet 导数在 Pi.single i 1 上的值，即坐标偏导。本批无 [ERRATUM?]，没有需要修正的原文错误；本次沿用 A 字段而不重做原文审校。 Ch02.lean 第1295–1298行三项合取逐项给出(2.26)–(2.28)：中间动量 p̂=p₀−(h/2)∂qH(q₀,p̂)，Q=q₀+(h/2)(∂pH(q₀,p̂)+∂pH(Q,p̂))，P=p̂−(h/2)∂qH(Q,p̂)。所有符号、系数、评价点一致；H、h、输入、输出、中间动量为参数，无存在性、唯一性或全球可解断言，无 EXTRA。fderiv 在不可微点有总化值，此定义应按原文偏导有意义的情形解释，不把总化解释为原文宣称非光滑求解。此条是定义，无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_partitionedVerletRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1896)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-PartitionedReduction · unnumbered_claim · 印刷p.91 / PDFp.113

### 2. 原文陈述

> When $H=\boldsymbol p^TM^{-1}\boldsymbol p/2+U(\boldsymbol q)$ this is just the leapfrog/Verlet method, but it can be used also for more general systems.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem partitionedReduction :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z w,
    positiveMass m → Differentiable ℝ U →
    ((∃ p, partitionedVerletRelation (fun z : Z n => (∑ i, z.2 i^2/m i)/2+U z.1) h z w p) ↔
      w = verlet m (fun q => -grad U q) h z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.partitionedReduction` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 固定正对角质量、U实际可微；中间动量存在关系与Verlet映射等价。 | [EXTRA] |

[EXTRA] 固定正对角质量、U实际可微；中间动量存在关系与Verlet映射等价。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；正式依赖展开：ReviewDefinitions.lean 第2816–2817行 Q n=Fin n→ℝ，Z n=Q n×Q n，第一分量为位置、第二分量为动量；第2913–2916行 partialQ/partialP 分别是固定另一变量后实际 Fréchet 导数在 Pi.single i 1 上的值，即坐标偏导。本批无 [ERRATUM?]，没有需要修正的原文错误；本次沿用 A 字段而不重做原文审校。 ReviewDefinitions.lean 第2840行 invMass m v 的第i分量是 m\_i⁻¹v\_i，第2948行 positiveMass=∀i,0<m\_i；第2932行 grad U 是 U 的实际坐标偏导。第2859–2861行 verlet 展开为 Q=q+hM⁻¹p+(h²/2)M⁻¹F(q)，P=p+(h/2)(F(q)+F(Q))。第2919–2922行正式 partitionedVerletRelation 与蓝图三式完全一致。机械 Hamiltonian 的偏导实际为 ∂qH=grad U，∂pH=M⁻¹p̂；于是 p̂=p−(h/2)grad U(q)，Q=q+hM⁻¹p̂，P=p̂−(h/2)grad U(Q)，恰为 F=−grad U 的上述 Verlet。量词 ∀n,m,U,h,z,w 在前，随后正质量与 U 可微，最后 ∃p̂ 的关系↔输出等式，双向包含全部机械情形结论；没有误加 h>0 或唯一解前提。EXTRA 固定正对角质量符合本章机械模型，是明确范围特化；非零质量已足以代数推导，正性物理合理但不是最弱条件。U 全空间可微保障偏导有意义，逐点资格即可，属合理加强。更一般 H 的适用性由前条无机械限制的关系表达，未声称一般 H 均存在解。定理正文有 sorry；此 PASS 仅判签名忠实，不表示证明已验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.partitionedReduction`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1903)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-GeneralEuler · definition · 印刷p.91 / PDFp.113

### 2. 原文陈述

> where $\mathcal G_h$ is defined by

$$
\boldsymbol P=\boldsymbol p-h\nabla_qH(\boldsymbol q,\boldsymbol P),\tag{2.29}
$$



$$
\boldsymbol Q=\boldsymbol q+h\nabla_pH(\boldsymbol q,\boldsymbol P),\tag{2.30}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_generalSymplecticEulerRelation {n : ℕ} (H : Z n → ℝ) (h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 - h • partialQ H z.1 w.2 ∧ w.1 = z.1 + h • partialP H z.1 w.2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_generalSymplecticEulerRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；正式依赖展开：ReviewDefinitions.lean 第2816–2817行 Q n=Fin n→ℝ，Z n=Q n×Q n，第一分量为位置、第二分量为动量；第2913–2916行 partialQ/partialP 分别是固定另一变量后实际 Fréchet 导数在 Pi.single i 1 上的值，即坐标偏导。本批无 [ERRATUM?]，没有需要修正的原文错误；本次沿用 A 字段而不重做原文审校。 Ch02.lean 第1310–1311行展开为 P=p−h∂qH(q,P)，Q=q+h∂pH(q,P)，与(2.29)–(2.30)一致；正式库 ReviewDefinitions.lean 第2917–2918行同式。输出动量同时出现在两个偏导的第二参数，输入位置为第一参数；对象、量词参数及两项合取全部正确。此为隐式关系而非选择求解函数，没有存在、唯一或全球求解结论，无 EXTRA。偏导按原文可微场景解释，fderiv 的非可微总化值不构成额外数学保证。定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_generalSymplecticEulerRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1911)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-GeneralSymplectic · unnumbered_claim · 印刷p.91 / PDFp.113

### 2. 原文陈述

> To see that it is symplectic, we first note that this is a symmetric composition of the form

$$
\mathcal K_h=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2},
$$


> where $\mathcal G_h$ is defined by

$$
P=p-h\nabla_qH(q,P),\tag{2.29}
$$



$$
Q=q+h\nabla_pH(q,P),\tag{2.30}
$$


> so it is enough to show that this basic method is symplectic.

### 3. 原文证明

> Taking differentials of (2.30) defining $\mathcal G_h$ and then wedge products and summing, we have

$$
\sum_i dQ_i\wedge dP_i=\sum_i dq_i\wedge dP_i+h\sum_i\sum_j H_{p_iq_j}dq_j\wedge dP_i+h\sum_i\sum_j H_{p_ip_j}dP_j\wedge dP_i.
$$


> The last term on the right vanishes by equality of mixed partials and the antisymmetry of the wedge product. On the other hand, using (2.29), we obtain, by similar means,

$$
\sum_i dq_i\wedge dP_i=\sum_i dq_i\wedge dp_i-h\sum_i\sum_j H_{q_ip_j}dq_i\wedge dP_j.
$$


> Relabelling the indices in this sum and using our previous work results in

$$
\sum_i dQ_i\wedge dP_i=\sum_i dq_i\wedge dp_i,
$$


> implying that the method is symplectic.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem generalSymplectic :
  ∀ n (H : Z n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n) h,
    ContDiff ℝ 2 H → ContDiff ℝ 1 G →
    (∀ z, generalSymplecticEulerRelation H h (unpack z) (unpack (G z))) → IsTextbookSymplecticMap G := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 基本隐式辛Euler的辛性子结论；所引原句的半步伴随复合、三步对应及对称辛性归MD-2.5.2-GeneralVerletSymplectic。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.generalSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H C²，真实C¹完整求解映射，逐点满足实际隐式关系。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条承担基本隐式辛Euler的辛性；同一原句的伴随半步复合、三步关系与对称性由MD-2.5.2-GeneralVerletSymplectic补全，原文不删。 | [EXTRA] |

[EXTRA] H C²，真实C¹完整求解映射，逐点满足实际隐式关系。；[EXTRA] 本条承担基本隐式辛Euler的辛性；同一原句的伴随半步复合、三步关系与对称性由MD-2.5.2-GeneralVerletSymplectic补全，原文不删。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；Z n为(q,p)对，unpack把标准坐标先q后p分解；关系为P=p−h H\_q(q,P)、Q=q+h H\_p(q,P)。H C²、G C¹且每点真实求解该关系，结论为全域C¹及标准J意义保辛。h可任意但仅对满足求解关系的实际G断言，未断言任意h必可求解。按明确statement\_scope只审基本隐式辛Euler；完整对称复合已明确交由另一个source\_id，本次未验证未提供的那一条。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.generalSymplectic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1917)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-GeneralVerletSymplectic · unnumbered_claim · 印刷p.91 / PDFp.113

### 2. 原文陈述

> To see that it is symplectic, we first note that this is a symmetric composition of the form

$$
\mathcal K_h=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2},
$$


> where $\mathcal G_h$ is defined by

$$
\boldsymbol P=\boldsymbol p-h\nabla_q H(\boldsymbol q,\boldsymbol P),\tag{2.29}
$$



$$
\boldsymbol Q=\boldsymbol q+h\nabla_p H(\boldsymbol q,\boldsymbol P).\tag{2.30}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem generalVerletSymplectic
    (n : ℕ) (H : Z n → ℝ) (G : ℝ → Equiv.Perm (SymplecticCoordinates n))
    (δ : ℝ) (_hδ : 0 < δ) (_hH : ContDiff ℝ 2 H)
    (_hG : ∀ h ∈ Ioo (-δ) δ, ContDiff ℝ 1 (G h))
    (_hInv : ∀ h ∈ Ioo (-δ) δ, ContDiff ℝ 1 (G h).symm)
    (_hstep : ∀ h ∈ Ioo (-δ) δ, ∀ z,
      generalSymplecticEulerRelation H h (unpack z) (unpack (G h z))) :
    let V : ℝ → Equiv.Perm (SymplecticCoordinates n) :=
      fun h ↦ (G (h/2)).trans (textbookAdjointMethod G (h/2))
    (∀ h, (V h : SymplecticCoordinates n → SymplecticCoordinates n) =
      textbookAdjointMethod G (h/2) ∘ G (h/2)) ∧
    textbookAdjointMethod V = V ∧
    (∀ h ∈ Ioo (-δ) δ, IsTextbookSymplecticMap (V h) ∧
      ∀ z, partitionedVerletRelation H h (unpack z) (unpack (V h z))
        (unpack (G (h/2) z)).2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.generalVerletSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H C²，实际C¹中间动量和完整求解映射，满足三步隐式关系。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 以真实可逆且C¹的基本求解族构造伴随半步复合V，补三步关系、V自伴随及辛性；仅δ小步长要求真实Euler关系，全球可逆族明确为条件性[EXTRA]，不宣称一般隐式方程必有全球解。 | [EXTRA] |

[EXTRA] H C²，实际C¹中间动量和完整求解映射，满足三步隐式关系。；[EXTRA] 以真实可逆且C¹的基本求解族构造伴随半步复合V，补三步关系、V自伴随及辛性；仅δ小步长要求真实Euler关系，全球可逆族明确为条件性[EXTRA]，不宣称一般隐式方程必有全球解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐项核对：n为任意自然数，q、p均为Fin n→ℝ，H定义于Q n×Q n；unpack按inl/inr取位置/动量，partialQ/partialP的求导变量和坐标方向正确。H为C²；δ>0；G是每个实步长上的双射族，仅在(-δ,δ)要求G及逆C¹并满足两条真实Euler关系。结论中Equiv.trans先作用G(h/2)再作用(G(-h/2))⁻¹，与原页复合方向相同。伴随的定义准确；V的全步长自伴随由逆映射及复合顺序直接成立，不依赖区间外Euler关系。区间内h/2和-h/2仍在区间，故两半步可合法使用假设；从第二半步的负步长Euler关系消去中间位置，所得三式正是partitionedVerletRelation，指定中间动量为unpack(G(h/2)z)的第二分量。辛性定义为C¹及DΦᵀ J DΦ=J，J的块号、坐标顺序和Jacobian均吻合。全局可逆族与双向C¹、真实求解关系是明确标注的条件性[EXTRA]，未把一般隐式方程的全球可解性当作结论。没有把辛性本身作为前提，也没有缺失所列完整结论。sorry不影响本次只读签名判定。

### 7. 状态与证明位置

incomplete；`MD.Ch02.generalVerletSymplectic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1926)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-Newmark · definition · 印刷p.92 / PDFp.114

### 2. 原文陈述

> As a special case of a partitioned Runge-Kutta method, consider the Newmark family of methods [280] defined for two parameters $\sigma$ and $\eta$ by the formulas

$$
\boldsymbol P=\boldsymbol p-h(1-\sigma)\nabla U(\boldsymbol q)-h\sigma\nabla U(\boldsymbol Q),
$$



$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p-h^2\left(\frac12-\eta\right)\nabla U(\boldsymbol q)-h^2\eta\nabla U(\boldsymbol Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_newmarkRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (γ β h : ℝ) (z w : Z n) : Prop :=
  w.2 = z.2 + (h*(1-γ)) • F z.1 + (h*γ) • F w.1 ∧
  w.1 = z.1 + h • invMass m z.2 + (h^2*(1/2-β)) • F z.1 + (h^2*β) • F w.1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_newmarkRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1331–1333；已展开 Ch02\_deps.txt:2816–2817 的 Q n=Fin n→ℝ、Z n=Q n×Q n，及2840的 invMass m v i=(m i)⁻¹*v i；它表示对角坐标质量矩阵的逆作用。z=(q,p)、w=(Q,P)。两个等式的对象、参数γ=σ、β=η、F=-∇U约定、系数及全部力项均与原页字面公式一致。位置式只对动量使用invMass；2923–2925的正式newmarkRelation与本地bp\_newmarkRelation逐项相同。无[EXTRA]；关系定义不要求求解映射存在，也不含sorry。原书位置力项缺M⁻¹的[ERRATUM?]确为质量一致性问题，见下一条正质量反例；本定义忠实保留该疑误。invMass在零质量时采用实数逆的全定义扩展，不据此解释物理零质量模型。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_newmarkRelation`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1945)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-NewmarkReduction · unnumbered_claim · 印刷p.92 / PDFp.114

### 2. 原文陈述

> For $\eta=0$ we then arrive at the Verlet method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newmarkReduction : ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkRelation m F (1/2) 0 h z w ↔ w=verlet m F h z := by
  sorry



/-- 修正版，对应原文 MD-2.5.3-NewmarkReduction。改动：采用显式质量一致Newmark关系，再与Verlet对应；原漏质量公式及反例保留。 -/
```

独立修正版：

```lean
theorem newmarkReduction_corrected : ∀ n (m : Fin n → ℝ) (F : Q n → Q n) h z w,
    newmarkMassCorrected m F (1/2) 0 h z w ↔ w=verlet m F h z := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.newmarkReduction`；`MD.Ch02.newmarkReduction_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 采用显式质量一致Newmark关系，再与Verlet对应；原漏质量公式及反例保留。 | [EXTRA] |

[EXTRA] [ERRATUM?] 采用显式质量一致Newmark关系，再与Verlet对应；原漏质量公式及反例保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Ch02.lean:1337–1339全称量化n、m、F、h、z、w，固定σ=1/2、η=0，断言关系与w=verlet的双向等价。已展开Ch02\_deps.txt:2923–2925：newmarkRelation确为缺力项质量因子的字面关系，未调用2926–2929的质量修正版。2859–2861的verlet则令Q=q+h invMass(m,p)+(h²/2)invMass(m,F(q))，P=p+(h/2)(F(q)+F(Q))。两种位置公式一般不相同，故原句的一般质量解释及当前Lean全称签名均为假，[ERRATUM?]成立。无[EXTRA]，质量正性也不能修复它。“仅M=I”只适用于对所有力和初值的普遍方法等价，不能排除特殊力或轨道的巧合。该定理体含sorry，签名失败由展开定义后的反例确定，不以sorry为判据。

### 7. 状态与证明位置

incomplete；`MD.Ch02.newmarkReduction`：未证（原书疑误不证）；`MD.Ch02.newmarkReduction_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1952)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-NewmarkDamping · unnumbered_claim · 印刷p.92 / PDFp.114

### 2. 原文陈述

> In practice the choice $\sigma=1/2$ is used to avoid spurious damping (it can be demonstrated for a simple model problem); this certainly would appear to be desirable in the setting of molecular dynamics.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newmarkDamping :
  ∀ (G : Q 2 → Q 2) Ω β h,
    ContDiff ℝ 1 G → (∀ z,
      G z 1 = z 1-h/2*Ω^2*(z 0+G z 0) ∧
      G z 0 = z 0+h*z 1-h^2*((1/2-β)*Ω^2*z 0+β*Ω^2*G z 0)) →
    1+h^2*β*Ω^2 ≠ 0 → ∀ z, (textbookCoordinateJacobian G z).det = 1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newmarkDamping` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]限定原文simple model为单位质量线性振子；h步隐式线性系统非奇异；用实际放大矩阵det=1表达无面积收缩，不声称任意势能能量恒定。 | [EXTRA] |

[EXTRA] [EXTRA]限定原文simple model为单位质量线性振子；h步隐式线性系统非奇异；用实际放大矩阵det=1表达无面积收缩，不声称任意势能能量恒定。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1343–1349；Q 2=Fin 2→ℝ，坐标0为q、1为p。量词依次为∀G,Ω,β,h，C¹条件、所有初值的两条实际隐式更新式、D=1+h²βΩ²≠0，最后∀z。Ch02\_deps.txt:2365–2370将textbookCoordinateJacobian定义为实际fderiv的标准基矩阵，条目(i,j)为(fderiv ℝ G z (Pi.single j 1))(i)，因此结论确为放大矩阵的行列式。展开更新得到a=h²Ω²、A=1-(1/2-β)a，Q=(Aq+hp)/D，P=p-hΩ²(q+Q)/2；矩阵为[[A/D,h/D],[-hΩ²(1+A/D)/2,1-a/(2D)]]，det=(A+a/2)/D=1。[EXTRA]单位质量线性振子合理落实原文simple model，非奇异条件使该全局求解可定义；C¹用于真实导数，在线性模型中也可由公式推出，属合理冗余。按照已披露的“无面积收缩”解释，结论忠实表达模型层面的阻尼检验；并未要求任意势能能量守恒或任意步长谱稳定。此条无[ERRATUM?]。定理体含sorry，PASS仅为签名语义判断，不表示已完成Lean证明。

### 7. 状态与证明位置

incomplete；`MD.Ch02.newmarkDamping`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1969)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-NewmarkNotSymplectic · unnumbered_claim · 印刷p.92 / PDFp.114

### 2. 原文陈述

> The implicit Newmark methods are not symplectic, but a related family of symplectic methods can be constructed by replacing interpolated forces by forces evaluated at interpolated positions [395].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newmarkNotSymplectic :
  ∃ (U : Q 1 → ℝ) (β h : ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1),
    ContDiff ℝ 3 U ∧ β ≠ 0 ∧ h ≠ 0 ∧ ContDiff ℝ 1 G ∧
    (∀ z, newmarkMassCorrected (fun _ => 1) (textbookPotentialForce U) (1/2) β h
      (unpack z) (unpack (G z))) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry



/-- 修正版，对应原文 MD-2.5.3-NewmarkNotSymplectic。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem newmarkNotSymplectic_corrected :
  ∃ (U : Q 1 → ℝ) (β h : ℝ) (G : SymplecticCoordinates 1 → SymplecticCoordinates 1),
    ContDiff ℝ 3 U ∧ β ≠ 0 ∧ h ≠ 0 ∧ ContDiff ℝ 1 G ∧
    (∀ z, newmarkMassCorrected (fun _ => 1) (textbookPotentialForce U) (1/2) β h
      (unpack z) (unpack (G z))) ∧ ¬ IsTextbookSymplecticMap G := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.newmarkNotSymplectic`；`MD.Ch02.newmarkNotSymplectic_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]存在一个非线性势能、β≠0与非零步长的实际可微求解反例；不是排除每个线性特殊情形。单位质量与字面式一致。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]存在一个非线性势能、β≠0与非零步长的实际可微求解反例；不是排除每个线性特殊情形。单位质量与字面式一致。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Ch02.lean:1353–1358；以原样沿用json\_review中的校正文句为审计对象。已展开Ch02\_deps.txt:33的SymplecticCoordinates 1=(Fin 1⊕Fin 1)→ℝ、2936的unpack z=(z∘Sum.inl,z∘Sum.inr)、583–585的textbookPotentialForce U q i=-(fderiv ℝ U q)(Pi.single i 1)，以及2926–2929的newmarkMassCorrected。m≡1时invMass为恒等，故关系确与字面Newmark一致。238–242的textbookJacobian使用真实fderiv，272–275的IsTextbookSymplecticMap要求C¹且所有点的Jacobian满足138–139的AᵀJA=J，J由39–40定义为[[0,I],[-I,0]]。签名存在量化U、β、h、G，再同时要求C³势能、β≠0、h≠0、C¹全局求解、所有初值满足更新及非辛性；已有C¹，故非辛性真正意味着某点Jacobian不保持J。[EXTRA]单位质量、非零参数及一个实际反例可合理见证该方法并非普遍辛；全局求解是额外构造负担，不能代表所有隐式参数。注释声称非线性势能，但签名没有显式非线性谓词（该描述不应当作已明示假设）。决定性缺失是原句第二子句：通过以插值位置处的力替换插值力构造相关辛方法族。现有签名完全没有该族的构造或辛性结论，故整体FAIL。无[ERRATUM?]；定理体含sorry与此语义缺失分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.newmarkNotSymplectic`：未证（原书疑误不证）；`MD.Ch02.newmarkNotSymplectic_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L1980)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.4-MultiTaylor · definition · 印刷p.92 / PDFp.114

### 2. 原文陈述

> we may approximate a single step by

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+h\dot{\boldsymbol z}_n+\frac{h^2}{2}\ddot{\boldsymbol z}_n+\cdots+\frac{h^k}{k!}\boldsymbol z_n^{(k)},
$$


> where it is possible to make use of higher order derivatives of the solution in formulating the method. Then using the differential equation, the time derivatives may be replaced by elementary differentials of the vector field.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_multiTaylor {n : ℕ} (d : ℕ → Q n) (h : ℝ) (k : ℕ) : Q n :=
  ∑ j ∈ Finset.range (k+1), (h^j / (Nat.factorial j : ℝ)) • d j
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_multiTaylor` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；这是截断Taylor步的定义而非关于任意导数数据的收敛定理。隐式n∈ℕ，d:ℕ→(Fin n→ℝ)，h∈ℝ、k∈ℕ；range(k+1)恰取j=0,…,k，实数阶乘强制转换和标量乘法正确。j=0项为d(0)，其余为h^j/j!乘d(j)，与原式逐项对应；k=0得到d(0)。d与真实解时间导数的对应已在context\_notation交代，定义无需再加入ODE解存在或可微性假设。没有声称已实现由向量场计算elementary differentials，也没有额外误差阶结论。[EXTRA]为空，与声明一致。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_multiTaylor`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L2002)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.4-TIPotential · definition · 印刷p.92–93 / PDFp.114–115

### 2. 原文陈述

> the Takahashi-Imada method [355] (also known as Rowlands’ method [316]) has the same form as the Verlet method

$$
\hat{\boldsymbol P}=\boldsymbol p-(h/2)\nabla\tilde U(\boldsymbol q),\quad\boldsymbol Q=\boldsymbol q+hM^{-1}\hat{\boldsymbol P},\quad\boldsymbol P=\hat{\boldsymbol P}-(h/2)\nabla\tilde U(\boldsymbol Q),
$$


> where the corresponding potential energy function is

$$
\tilde U(\boldsymbol q)=U(\boldsymbol q)-\frac{h^2}{24}\nabla U(\boldsymbol q)^TM^{-1}\nabla U(\boldsymbol q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def tiMethod {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h



/-- 修正版，对应原文 MD-2.5.4-TIPotential。改动：选择原负号改势路线，物理包装明示正质量和C²势；力式修正的加号在TIForce_corrected中另列。 -/
```

独立修正版：

```lean
def tiMethod_corrected {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ)
    (_hm : positiveMass m) (_hU : ContDiff ℝ 2 U) (h : ℝ) : Z n → Z n :=
  verlet m (fun q => -grad (takahashiPotential m U h) q) h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.tiMethod`；`MD.Ch02.tiMethod_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 选择原负号改势路线，物理包装明示正质量和C²势；力式修正的加号在TIForce\_corrected中另列。 | [EXTRA] |

[EXTRA] [ERRATUM?] 选择原负号改势路线，物理包装明示正质量和C²势；力式修正的加号在TIForce\_corrected中另列。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；逐项展开定义：n∈ℕ，m:Fin n→ℝ，U:Q n→ℝ，h∈ℝ，输入输出均为位置/动量对Z n。takahashiPotential中的减号、1/24、h²及Σ\_i(∂_iU)²/m\_i，与原页在M=diag(m\_i)时的改势完全一致；tiMethod使用该改势的负梯度。令F=−grad Ũ，verlet的位置为q+h M⁻¹p+(h²/2)M⁻¹F(q)，等于原页用p̂=p+(h/2)F(q)所得q+hM⁻¹p̂；输出动量为p+(h/2)(F(q)+F(Q))，等于p̂+(h/2)F(Q)。故没有半步系数或力号的转录错误。但本定义忠实于原页负号改势，并不同时满足紧随的正号括号力式；按要求将原书数学疑误交人工，不静默修复。另需人工确认M的对角质量约定：此签名没有一般矩阵参数；m也没有正性/非零约束，U没有可微性约束，故只能把物理方法理解为限制到非零（通常正）质量和足够光滑势的使用域。Lean在零质量或不可微势处的总函数扩展不构成原书物理含义。无\_corrected/_counterexample声明可供另审；没有[EXTRA]说明来补充上述使用域。

### 7. 状态与证明位置

self-contained；`MD.Ch02.tiMethod`：定义；`MD.Ch02.tiMethod_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L2007)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.4-TIForce · unnumbered_claim · 印刷p.93 / PDFp.115

### 2. 原文陈述

> The forces arising from such a modified potential can be worked out:

$$
\tilde F=-\nabla\tilde U=-\left[I+\frac{h^2}{12}U''M^{-1}\right]\nabla U,
$$


> where $U''$ is the Hessian matrix of the potential.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem tiForce :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q - (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q)) := by
  sorry



/-- 修正版，对应原文 MD-2.5.4-TIForce。改动：保留负号改势，负梯度力修正项应为加号；未改原书展示式。 -/
```

独立修正版：

```lean
theorem tiForce_corrected :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h q,
    positiveMass m → ContDiff ℝ 2 U →
    -grad (takahashiPotential m U h) q =
      -grad U q + (h^2/12) • (fderiv ℝ (grad U) q) (invMass m (grad U q)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.tiForce`；`MD.Ch02.tiForce_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量，U C²，真实改势梯度及Hessian作用。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 保留负号改势，负梯度力修正项应为加号；未改原书展示式。 | [EXTRA] |

[EXTRA] 正质量，U C²，真实改势梯度及Hessian作用。；[ERRATUM?] 保留负号改势，负梯度力修正项应为加号；未改原书展示式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；展开依据：Ch02\_deps.txt:2816、2840、2932–2934、2948，Ch02.lean:1371–1376。量词覆盖所有 n,m,U,h,q；positiveMass 是逐坐标 m\_i>0，ContDiff ℝ 2 U 保证真实二阶导数及 Hessian 对称性；fderiv ℝ (grad U) q 对 invMass m (grad U q) 的作用是 Hess(U)M⁻¹∇U。实际改势含负号，其负梯度必须为 −∇U+(h²/12)Hess(U)M⁻¹∇U，签名却取减号。它逐字保留了原书力式，却与其所调用的实际改势矛盾并成为假定理，因此不能作为可证明的忠实数学陈述通过。ERRATUM? 成立。EXTRA 中 C² 是充分且合理的统一光滑性条件（强于某一点有二阶导数）；正质量保证教材机械质量可逆，但纯代数恒等式只需各质量非零，故是物理上合理而非最弱必要条件。签名体有 sorry，证明状态独立于已经确定的语义失败。

### 7. 状态与证明位置

incomplete；`MD.Ch02.tiForce`：未证（原书疑误不证）；`MD.Ch02.tiForce_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L2021)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.4-TIOrder · unnumbered_claim · 印刷p.93 / PDFp.115

### 2. 原文陈述

> This method can be shown to have effective order four, meaning that there is a change of variables $\chi_h$ which can be used to transform the Takahashi-Imada method into one of order four using the processing technique of Sect. 2.4.5. The potential energy modification has been specifically chosen to annihilate terms in the local error expansion (after coordinate transformation).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem tiOrder :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
    ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
      solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
      ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        oneStepMaxError (fun h => textbookProcessedMethod χ
          (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
          (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
  sorry



/-- 修正版，对应原文 MD-2.5.4-TIOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem tiOrder_corrected :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
    ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
      solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
      ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
        oneStepMaxError (fun h => textbookProcessedMethod χ
          (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
          (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.tiOrder`；`MD.Ch02.tiOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量，U C∞；实际步依照上项负号改势；处理器为实际Homeomorph，原轨迹及有限时间窗误差结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正质量，U C∞；实际步依照上项负号改势；处理器为实际Homeomorph，原轨迹及有限时间窗误差结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；全部使用定义已找到：Q/Z、grad、invMass、verlet、takahashiPotential、solution、mechanicalField、positiveMass 见 Ch02\_deps.txt:2816–2817、2840、2859–2861、2932–2934、2941–2948；oneStepIterate/oneStepMaxError 见1444–1463；textbookConjugateMap/textbookProcessedMethod 见 ProcessedMethods 段（用原始行编号1649、1690定位，段中有额外 CR）。solution 是闭区间每点 HasDerivWithinAt γ (f(γ t))，mechanicalField=(M⁻¹p,−∇U(q))，所以是原机械轨迹。HasDerivWithinAt 已蕴含区间内连续，显式 ContinuousOn γ 冗余但合理。处理映射确为 χ\_h⁻¹∘B\_h∘χ\_h，迭代从 γ(0) 开始，等价于先 χ\_h 预处理、迭代真实 B\_h、再逆变换；误差是网格 0,…,ν 上完整位置/动量乘积范数最大值，不是单步误差。量词 χ 在 γ,τ 之前，C,ν₀ 在其之后，保证统一处理器而允许误差常数依赖轨迹与时间窗，ν₀>0 排除零分母，均合理。正固定对角质量与 U C∞ 是足够光滑的背景条件，C∞ 并非四阶所需最弱条件。失败依据是结论范围与处理器条件：原文还明确说坐标变换后局部误差展开项被消去，签名只有全局四阶界，没有局部五阶缺陷或消项断言；它对任意光滑势能要求整个 Z n 上的 Homeomorph，强于通常在轨迹邻域的变量变换，却完全不要求 χ\_h 光滑、随 h 正则或趋于恒等，无法承载所引用的局部误差展开。这个无正则性的全局共轭存在性不能直接等同于原文有效阶陈述。DEPENDENT\_ERRATUM 所指来源符号冲突确实存在，但不能只据冲突断言负号版本无有效四阶；下方谐振子计算说明这一限制。这里不声称签名允许的任意不规则 Homeomorph 都不存在；本条 FAIL 已由上述具体缺失条款和不合理强化成立，无须借缺依赖写 NEEDS\_HUMAN。定理体为 sorry，未验证其证明。

### 7. 状态与证明位置

incomplete；`MD.Ch02.tiOrder`：未证（原书疑误不证）；`MD.Ch02.tiOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L2046)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.5-Beeman · Example 2.8 (Beeman’s Algorithm) · 印刷p.94 / PDFp.116

### 2. 原文陈述

> The method treats the positions and momenta differently, updating these from the formulas

$$
\boldsymbol q_{n+1}=\boldsymbol q_n+h\dot{\boldsymbol q}_n+\frac{h^2}{6}[4\ddot{\boldsymbol q}_n-\ddot{\boldsymbol q}_{n-1}].\tag{2.31}
$$



$$
\boldsymbol p_{n+1}=\boldsymbol p_n+\frac h6 M[2\ddot{\boldsymbol q}_{n+1}+5\ddot{\boldsymbol q}_n-\ddot{\boldsymbol q}_{n-1}].\tag{2.32}
$$


> The shorthand $\dot{\boldsymbol q}_n\equiv M^{-1}\boldsymbol p_n$, $\ddot{\boldsymbol q}_n\equiv M^{-1}F(\boldsymbol q_n)$ has been used.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def beeman {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (h : ℝ) (qPrev : Q n) (z : Z n) : Z n :=
  let a := invMass m (F z.1)
  let aPrev := invMass m (F qPrev)
  let q := z.1+h • invMass m z.2+(h^2/6) • ((4 : ℝ) • a-aPrev)
  let p := z.2+(h/6) • mass m ((2 : ℝ) • invMass m (F q)+(5 : ℝ) • a-aPrev)
  (q,p)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.beeman` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；已展开 Ch02\_deps.txt 中 MolecularDynamics/Chapter02/ReviewDefinitions.lean 的正式定义（合集行2816–2817、2840–2841）：Q n = Fin n → ℝ，Z n = Q n × Q n；invMass m v i = (m i)⁻¹*v i，mass m v i = m i*v i。故 z.1 是位置，z.2 在本函数中是动量，a\_i = F(q\_n)_i/m\_i，aPrev\_i = F(q_{n−1})_i/m\_i。Ch02.lean 行1392–1398 给出 qnext\_i = q\_i+h*p\_i/m\_i+(h²/6)*(4*a\_i−aPrev\_i)，pnext\_i = p\_i+(h/6)*m\_i*(2*F(qnext)_i/m\_i+5*a\_i−aPrev\_i)，逐项忠实于原页116（印刷94）公式(2.31)、(2.32)，包含在更新位置处重新求力。固定对角质量是本章机械模型的表达范围，无额外定理假设或 ERRATUM?。定义对任意实数 m 总化：零质量时实数逆元为0，而原书 M⁻¹ 仅在可逆质量域有意义；这里是有效质量域上公式的总函数延拓，不是声称零质量模型满足原物理语义，因此不判为缺失定理前提。使用时需正质量（至少每个 m\_i 非零）。缓存旧力后每步一个新力评估是上下文性质，纯函数未编码缓存或求值计数，本条 statement\_scope 不要求该复杂度结论。此项为 def，无 sorry 证明义务；其他定理的 sorry 不改变这个函数体的公式语义。

### 7. 状态与证明位置

self-contained；`MD.Ch02.beeman`：定义。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L2074)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.5-BeemanOrder · unnumbered_claim · 印刷p.94 / PDFp.116

### 2. 原文陈述

> The order of accuracy of the scheme above can be shown to be three.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem beemanOrder : ∀ n (m : Fin n → ℝ) (F : Q n → Q n)
    (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 1 < ν₀ ∧ ∀ ν ≥ ν₀,
      ∀ z : ℕ → Z n, z 0=γ 0 → z 1=γ (τ/ν) →
        (∀ k, 1 ≤ k → z (k+1)=beeman m F (τ/ν) (z (k-1)).1 (z k)) →
        ∀ k ≤ ν, ‖z k-γ (k*(τ/ν))‖ ≤ C*(τ/ν)^3 := by
  sorry



/-- 修正版，对应原文 MD-2.5.5-BeemanOrder。改动：全相空间有限时间收敛修正为二阶；原three的其它阶概念待导师，二阶正向估计尚需证明。 -/
```

独立修正版：

```lean
theorem beemanOrder_corrected : ∀ n (m : Fin n → ℝ) (F : Q n → Q n)
    (γ : ℝ → Z n) τ,
    positiveMass m → ContDiff ℝ 4 F → 0 < τ →
    solution (mechanicalField m F) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
    ∃ C > 0, ∃ ν₀ : ℕ, 1 < ν₀ ∧ ∀ ν ≥ ν₀,
      ∀ z : ℕ → Z n, z 0=γ 0 → z 1=γ (τ/ν) →
        (∀ k, 1 ≤ k → z (k+1)=beeman m F (τ/ν) (z (k-1)).1 (z k)) →
        ∀ k ≤ ν, ‖z k-γ (k*(τ/ν))‖ ≤ C*(τ/ν)^2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.beemanOrder`；`MD.Ch02.beemanOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正固定对角质量，F C⁴；实际紧轨迹，前两步取精确起始值（强于三阶启动）；真实多步递推，保留两坐标误差。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 全相空间有限时间收敛修正为二阶；原three的其它阶概念待导师，二阶正向估计尚需证明。 | [EXTRA] |

[EXTRA] [EXTRA]正固定对角质量，F C⁴；实际紧轨迹，前两步取精确起始值（强于三阶启动）；真实多步递推，保留两坐标误差。；[ERRATUM?] 全相空间有限时间收敛修正为二阶；原three的其它阶概念待导师，二阶正向估计尚需证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开正式依赖：Q、Z、mass、invMass 如上一项；positiveMass m = ∀ i, 0<m i；mechanicalField m F (q,p) = (invMass m p,F q)；solution f γ 0 τ = ∀ t∈Icc 0 τ, HasDerivWithinAt γ (f(γ t)) (Icc 0 τ) t（合集行2941–2948）。因此 γ 确实是位置/动量的机械ODE解。Ch02.lean 行1402–1410 的量词依次为 n,m,F,γ,τ、全部假设、统一 C>0 和 ν₀>1、所有 ν≥ν₀、所有满足 z0=γ0、z1=γh 和 k≥1 多步递推的 z、所有 k≤ν；Z 的积范数控制两坐标，而不是只控制位置或终点。没有遗漏展示的误差子句，也没有把数值序列替换成独立单步映射。[EXTRA] 正固定对角质量合理；F 全空间 C⁴ 是足够但较强的平滑性限制，不是阶性质必需的最弱假设；τ>0 与 ν₀>1 保证有效网格和两点启动；闭区间连续由 solution 的逐点相对可导性已蕴含，冗余但合理，并给出紧轨迹；精确两点启动强于通常 O(h³) 启动，合理作为理想启动测试，但只是原句的受限版本。即使在这些强假设下全状态 O(h³) 结论仍为假，见解析反例。因此该签名虽保留原文 three 的全局阶解释，不能作为正确、无疑误的原文正式对应判 PASS。[ERRATUM?] 在这里明确的固定时间窗全局阶解释下成立；原书可能使用其他阶概念的问题不妨碍否定这个具体签名。原批所述单步动量 −h³/12 首项仅是局部缺陷，单凭它不能推出全局失败；下面直接证明非零全局 O(h²) 位置误差。该声明末尾 by sorry，未完成证明；FAIL 根据签名的数学反例作出，与 sorry 分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.beemanOrder`：未证（原书疑误不证）；`MD.Ch02.beemanOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../Blueprint/Ch02.lean#L2085)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

