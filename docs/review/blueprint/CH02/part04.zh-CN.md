[上一部分](part03.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## 1. MD-2.2.4-IntegralMeanValue · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> Now if $`I:\mathbb R^m\to\mathbb R`$ has continuous partial derivatives, we may conclude directly that

$$
I(\boldsymbol a)=I(\boldsymbol b)+\nabla I(\boldsymbol z_*)\cdot(\boldsymbol a-\boldsymbol b),
$$


> where $`\boldsymbol z_*`$ is a point on the line in $`\mathbb R^m`$ connecting $`\boldsymbol a`$ to $`\boldsymbol b`$.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L637)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L653)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.2.4-IntegralErrorPrinted · unnumbered_claim · 印刷p.71 / PDFp.93

### 2. 原文陈述

> This means if we know that $`\|\nabla I(\boldsymbol z)\|`$ remains bounded, say less than $`B`$, in an open domain containing the solution, we could conclude that the error in $`I`$-values computed along a numerical trajectory is of order $`h^p`$,

$$
|I(\boldsymbol z(t_n))-I(\boldsymbol z_n)|\le\frac{\bar K B}{2L}e^{nLh}h^p,\qquad h\lt \bar h,\tag{2.16}
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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L667)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-Divergence · definition · 印刷p.72 / PDFp.94

### 2. 原文陈述

> the divergence of $`f`$ vanishes, i.e.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L692)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-Liouville · Liouville’s theorem · 印刷p.72 / PDFp.94

### 2. 原文陈述

> Consider a set of points $`S(t)`$ in phase space with evolution associated to a differential equation $`\dot{\boldsymbol z}=f(\boldsymbol z)`$ described by the flow map $`\mathcal F_t(S(0))=S(t)`$. Liouville’s theorem [16] states that the volume of such a set is invariant with respect to $`t`$ if the divergence of $`f`$ vanishes, i.e.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L699)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L711)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L719)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-VolumeChange · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> If we view the map $`\mathcal F_t`$ as a change of variables, we have

$$
\operatorname{Vol}(S(t))=\int_S |D|\,d\omega,
$$


> where $`D=\det\left(\frac{\partial\mathcal F_t}{\partial\boldsymbol z}\right)`$.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L732)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-VariationalPrinted · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> To understand where Liouville’s theorem comes from, recall that the variational equations of the last chapter are a system of ordinary differential equations for $`W(t)=\mathcal F_t'(\boldsymbol z(t))`$:

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L751)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-DeterminantODE · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> Now let $`D=\det(W)`$. One can show (see Exercise 5) that

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L781)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L794)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.1-FlowDet · unnumbered_claim · 印刷p.73 / PDFp.95

### 2. 原文陈述

> In particular, if $`\operatorname{div}f\equiv0`$, we see that $`D\equiv D(0)=1`$ and it follows that the volume is constant. Liouville’s theorem may be summarized compactly as:

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L803)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L818)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L830)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-LinearDivergence · unnumbered_claim · 印刷p.74–75 / PDFp.96–97

### 2. 原文陈述

> Consider a linear differential equation system in $`\mathbb R^m`$,

$$
\dot{\boldsymbol z}=S\boldsymbol z,
$$


> for some matrix $`S\in\mathbb R^{m\times m}`$. The condition for the flow of this system to conserve volume is just that the trace of $`S`$ (which is the divergence of the vector field $`f(\boldsymbol z)=S\boldsymbol z`$) be zero.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L839)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L848)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.3.2-EulerVolumePrinted · unnumbered_claim · 印刷p.75 / PDFp.97

### 2. 原文陈述

> and the condition for Euler’s method to conserve volume is that $`\det(I+hS)=1`$.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L854)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L873)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L882)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L887)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

