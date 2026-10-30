[上一部分](part03.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / 下一部分：无

## 1. MD-2.5.1-RK · definition · 印刷p.89 / PDFp.111

### 2. 原文陈述

> The family of Runge-Kutta methods for solving $`\dot{\boldsymbol z}=f(\boldsymbol z)`$ is defined by

$$
\boldsymbol Z=\boldsymbol z+h\sum_{i=1}^s b_i\boldsymbol F_i,
$$


> where the vectors $`\boldsymbol F_i`$, $`i=1,\ldots,s`$, are computed by solving the system

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1728)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-RK4 · definition · 印刷p.89 / PDFp.111

### 2. 原文陈述

> An example of a popular 4th order explicit method is the choice of matrix $`A`$ with coefficients $`a_{ij}\equiv 0`$ except $`a_{21}=1/2`$, $`a_{32}=1/2`$ and $`a_{43}=1`$, and $`b_1=1/6`$, $`b_2=1/3`$, $`b_3=1/3`$, $`b_4=1/6`$.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1734)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
网站原返回（对应其审校版本）：PASS；展开deps:2816,2824–2826,2941–2945：compactTrajectory包含τ>0、f全局C⁶、γ在[0,τ]内满足HasDerivWithinAt γ (f(γ t))、γ在该窗连续；紧区间连续像为紧，未把误差作为前提。rk4为与bp\_rk4相同的实际四阶段映射。globalOrder为∃C>0 ∃ν₀>0 ∀ν≥ν₀，整个网格0,…,ν的最大误差≤C(τ/ν)^4；oneStepIterate=(G h)^[k](../../γ 0)，oneStepMaxError是实际节点范数误差的有限最大值（deps:1443–1463）。量词表达固定轨迹、固定正时间窗的全局四阶上界。[EXTRA] C⁶强于必要正则性，作为充分资格合理；不要求原文未提供的任意隐式求解。无勘误。 本声明在Ch02.lean中以sorry结束；这里只审计签名语义，未作Lean编译或证明通过判断。

### 7. 状态与证明位置

incomplete；`MD.Ch02.rk4Order`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1747)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1754)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1768)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1802)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1836)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1842)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussTwo · definition · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The 4th order method ($`s=2`$) has coefficients

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1872)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.1-GaussTwoOrder · unnumbered_claim · 印刷p.90 / PDFp.112

### 2. 原文陈述

> The 4th order method ($`s=2`$) has coefficients

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1878)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1896)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-PartitionedReduction · unnumbered_claim · 印刷p.91 / PDFp.113

### 2. 原文陈述

> When $`H=\boldsymbol p^TM^{-1}\boldsymbol p/2+U(\boldsymbol q)`$ this is just the leapfrog/Verlet method, but it can be used also for more general systems.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1903)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-GeneralEuler · definition · 印刷p.91 / PDFp.113

### 2. 原文陈述

> where $`\mathcal G_h`$ is defined by

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1911)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-GeneralSymplectic · unnumbered_claim · 印刷p.91 / PDFp.113

### 2. 原文陈述

> To see that it is symplectic, we first note that this is a symmetric composition of the form

$$
\mathcal K_h=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2},
$$


> where $`\mathcal G_h`$ is defined by

$$
P=p-h\nabla_qH(q,P),\tag{2.29}
$$



$$
Q=q+h\nabla_pH(q,P),\tag{2.30}
$$


> so it is enough to show that this basic method is symplectic.

### 3. 原文证明

> Taking differentials of (2.30) defining $`\mathcal G_h`$ and then wedge products and summing, we have

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1917)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.2-GeneralVerletSymplectic · unnumbered_claim · 印刷p.91 / PDFp.113

### 2. 原文陈述

> To see that it is symplectic, we first note that this is a symmetric composition of the form

$$
\mathcal K_h=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2},
$$


> where $`\mathcal G_h`$ is defined by

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1926)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-Newmark · definition · 印刷p.92 / PDFp.114

### 2. 原文陈述

> As a special case of a partitioned Runge-Kutta method, consider the Newmark family of methods [280] defined for two parameters $`\sigma`$ and $`\eta`$ by the formulas

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1945)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-NewmarkReduction · unnumbered_claim · 印刷p.92 / PDFp.114

### 2. 原文陈述

> For $`\eta=0`$ we then arrive at the Verlet method.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1952)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.3-NewmarkDamping · unnumbered_claim · 印刷p.92 / PDFp.114

### 2. 原文陈述

> In practice the choice $`\sigma=1/2`$ is used to avoid spurious damping (it can be demonstrated for a simple model problem); this certainly would appear to be desirable in the setting of molecular dynamics.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1969)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1980)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L2002)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L2007)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.4-TIForce · unnumbered_claim · 印刷p.93 / PDFp.115

### 2. 原文陈述

> The forces arising from such a modified potential can be worked out:

$$
\tilde F=-\nabla\tilde U=-\left[I+\frac{h^2}{12}U''M^{-1}\right]\nabla U,
$$


> where $`U''`$ is the Hessian matrix of the potential.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L2021)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.4-TIOrder · unnumbered_claim · 印刷p.93 / PDFp.115

### 2. 原文陈述

> This method can be shown to have effective order four, meaning that there is a change of variables $`\chi_h`$ which can be used to transform the Takahashi-Imada method into one of order four using the processing technique of Sect. 2.4.5. The potential energy modification has been specifically chosen to annihilate terms in the local error expansion (after coordinate transformation).

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L2046)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.5.5-Beeman · Example 2.8 (Beeman’s Algorithm) · 印刷p.94 / PDFp.116

### 2. 原文陈述

> The method treats the positions and momenta differently, updating these from the formulas

$$
\boldsymbol q_{n+1}=\boldsymbol q_n+h\dot{\boldsymbol q}_n+\frac{h^2}{6}[4\ddot{\boldsymbol q}_n-\ddot{\boldsymbol q}_{n-1}].\tag{2.31}
$$



$$
\boldsymbol p_{n+1}=\boldsymbol p_n+\frac h6 M[2\ddot{\boldsymbol q}_{n+1}+5\ddot{\boldsymbol q}_n-\ddot{\boldsymbol q}_{n-1}].\tag{2.32}
$$


> The shorthand $`\dot{\boldsymbol q}_n\equiv M^{-1}\boldsymbol p_n`$, $`\ddot{\boldsymbol q}_n\equiv M^{-1}F(\boldsymbol q_n)`$ has been used.

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L2074)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

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
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L2085)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

