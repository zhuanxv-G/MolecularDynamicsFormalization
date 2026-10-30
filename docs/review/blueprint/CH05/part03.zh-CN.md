[上一部分](part02.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## 1. MD-5.2.2-LiouvilleEquation · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> Therefore, since this should hold for an arbitrary domain $`\mathcal A`$, we must have

$$
\frac{\partial\rho}{\partial t}=-\nabla\cdot(\rho f).
$$


> This is called the Liouville equation or continuity equation. It tells us how the distribution of phase points varies in time and space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvilleEquation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleEquation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。 | [EXTRA] |

[EXTRA] [EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n和开放流不变D，f在D上C¹、Φ为联合C²的实际自治流，ρ在ℝ×D上C¹且各时刻为D上的概率密度，受限密度测度由Φ\_t推前。结论对任意实t及所有z∈D给出HasDerivAt(ρ·z)(−div(ρ\_t f)(z)) t，完整对应连续性方程。输运测度等式是真实分布输运条件而非预设PDE；开放域和连续密度使AE等式可提升为点态等式。不要求D外ρ光滑，无未披露的循环前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvilleEquation`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L442)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleProduct · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> An alternative form for the continuity equation is:

$$
\frac{\partial\rho}{\partial t}=-\sum_i\left[\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right],
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvilleProduct :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z = -ρ z*MolecularDynamics.Chapter05Review.divergence f z-MolecularDynamics.Chapter05Review.lie f ρ z := by
  intro n f ρ z hf hρ
  have hd := hρ.hasFDerivAt.smul hf.hasFDerivAt
  change HasFDerivAt (fun x => ρ x • f x)
    (ρ z • fderiv ℝ f z+(fderiv ℝ ρ z).smulRight (f z)) z at hd
  unfold MolecularDynamics.Chapter05Review.liouvillian MolecularDynamics.Chapter05Review.divergence MolecularDynamics.Chapter05Review.lie
  rw [hd.fderiv]
  change -(LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n)
    (ρ z • (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z).toLinearMap.smulRight (f z))) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-
      (fderiv ℝ ρ z) (f z)
  simp only [map_add,map_smul,LinearMap.trace_smulRight,smul_eq_mul]
  change -(ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap+(fderiv ℝ ρ z) (f z)) =
    -ρ z*LinearMap.trace ℝ (MolecularDynamics.Chapter05Review.E n) (fderiv ℝ f z).toLinearMap-(fderiv ℝ ρ z) (f z)
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleProduct` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。 | [EXTRA] |

[EXTRA] [EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅Liouvillian乘积法则的静态辅助引理；包含真实输运前提的完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates及MD-5.2.2-LiouvilleEquation承担。；[EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；liouvilleProduct本身正确：对任意n,f、实值ρ及z，在f、ρ于z可微的条件下，−div(ρf)=−ρ div f−L\_fρ。此为静态乘积法则，且statement\_scope及[EXTRA]明确如此；它没有时间变量、HasDerivAt或任何输运前提，因此不能单独代表所引完整时间PDE。文本宣称完整坐标时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担，但该source\_id及声明不在本任务提供材料中，且用户禁止用旧工程补查，故跨条完整性待人工核实；不把正确辅助引理判为错误定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.liouvilleProduct`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L453)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LieCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

本条等式为从原页内积公式提炼的坐标辅助表达，并非原页独立展示式；完整原文时间PDE见MD-5.2.2-LiouvilleProductCoordinates。

> $`\mathcal L_fv=\sum_i f_i\frac{\partial v}{\partial z_i}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lieCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (g : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  MolecularDynamics.Chapter05Review.lie f g z=∑ i,f z i*(fderiv ℝ g z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f g z
  unfold MolecularDynamics.Chapter05Review.lie
  have h := congrArg (fderiv ℝ g z) ((EuclideanSpace.basisFun (Fin n) ℝ).toBasis.sum_repr (f z)).symm
  simpa only [map_sum,map_smul,smul_eq_mul,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis] using h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 从原页内积公式提炼的坐标辅助表达，非原页逐字独立展示式；完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates另列。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.lieCoordinates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 返回A已指出该坐标等式是提炼的辅助表达，不将它标为原页独立逐字展示式。 | [EXTRA] |

[EXTRA] [EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。；[EXTRA] 返回A已指出该坐标等式是提炼的辅助表达，不将它标为原页独立逐字展示式。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意n、f:E n→E n、g:E n→ℝ及z，将线性映射fderiv g z在f(z)上的值展开为所有i:Fin n的f\_i(z)乘其在真实正交规范基e\_i上的值。有限求和、系数、基向量与实值域正确；对可微g后一项即∂ᵢg。没有显式可微前提时，仍是总化Fréchet导数的线性恒等式，不是声称任意g存在经典偏导；[EXTRA]所说无需另造形式梯度成立。

### 7. 状态与证明位置

self-contained；`MD.Ch05.lieCoordinates`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L474)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-DivergenceCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> $`\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right)`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem divergenceCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) z,
  DifferentiableAt ℝ f z → MolecularDynamics.Chapter05Review.divergence f z=
    ∑ i,(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  intro n f z hf
  unfold MolecularDynamics.Chapter05Review.divergence
  rw [LinearMap.trace_eq_matrix_trace ℝ (EuclideanSpace.basisFun (Fin n) ℝ).toBasis]
  simp only [Matrix.trace,Matrix.diag,LinearMap.toMatrix_apply,OrthonormalBasis.coe_toBasis_repr_apply,EuclideanSpace.basisFun_repr,OrthonormalBasis.coe_toBasis]
  apply Finset.sum_congr rfl
  intro i hi
  have hc := (PiLp.proj 2 (fun _ : Fin n => ℝ) i).hasFDerivAt.comp z hf.hasFDerivAt
  change HasFDerivAt (fun x => f x i) _ z at hc
  rw [hc.fderiv]
  rfl
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.divergenceCoordinates` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。 | [EXTRA] |

[EXTRA] [EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅真实散度的坐标辅助引理；同段完整时间PDE由MD-5.2.2-LiouvilleProductCoordinates承担。；[EXTRA] 坐标静态乘积公式已有证明；完整时间PDE声明存在但尚未证明，不把静态辅助引理冒充时间PDE。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；divergenceCoordinates正确断言任意n、f,z在f于z可微时，真实散度等于Σ\_i D(f\_i)(z)e\_i，是完整对角偏导和。它不含ρ或时间导数，statement\_scope已明确为辅助引理；所引原文却是完整连续性方程的乘积展开。其跨条承载者MD-5.2.2-LiouvilleProductCoordinates不在本任务材料，不能据名称确认该完整结论已保存；需要人工提供该声明核对。

### 7. 状态与证明位置

self-contained；`MD.Ch05.divergenceCoordinates`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L484)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-LiouvilleProductCoordinates · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> An alternative form for the continuity equation is:

$$
\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvilleProductCoordinates : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  MolecularDynamics.Chapter05Review.liouvillian f ρ z=-(∑ i : Fin n,(ρ z*(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+
    f z i*(fderiv ℝ ρ z) (EuclideanSpace.basisFun (Fin n) ℝ i))) := by
  intro n f ρ z hf hρ
  rw [liouvilleProduct n f ρ z hf hρ,divergenceCoordinates n f z hf,lieCoordinates n f ρ z]
  rw [Finset.sum_add_distrib,← Finset.mul_sum]
  ring

theorem liouvilleProductCoordinates_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (-(∑ i : Fin n,(ρ t z*(fderiv ℝ (fun x ↦ f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+f z i*(fderiv ℝ (ρ t) z) (EuclideanSpace.basisFun (Fin n) ℝ i)))) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvilleProductCoordinates`；`MD.Ch05.liouvilleProductCoordinates_evolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。 | [EXTRA] |

[EXTRA] [EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。；[EXTRA] 保留原坐标乘积法则证明，并以真实自治流、光滑密度和Measure.map输运条件补全部时间导数PDE；不把PDE作前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；同时核对两个声明。E n为实n维欧氏空间；第一式对任意n、f、ρ及z在点可微条件下展开-div(ρf)，两个坐标项和总负号正确。evolution对开且全时流不变的D、C¹场、实际全时间自治流及其C²联合正则性、D上的联合C¹密度逐点给出所有t及z∈D的时间导数。probabilityDensityOn要求非负、可积及积分1；densityMeasureOn是限制体积上的真实密度测度。推前等式是输运条件，并非把所求PDE作为假设；开域与连续性使测度层面的相等能确定点态密度。两个声明合起来保留完整时间导数和有限坐标和。[EXTRA]的强化足够且未循环；第一条EXTRA关于其他条目的旧说明不影响本条已有evolution覆盖。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvilleProductCoordinates`：已证；`MD.Ch05.liouvilleProductCoordinates_evolution`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L501)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-RectangularDomain · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Let $`A`$ be a suitable region of volume $`V`$ within the phase space (say a rectangular $`m`$-dimensional box).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def rectangularDomain {n : ℕ} (a b : MolecularDynamics.Chapter05Review.E n) := MolecularDynamics.Chapter05Review.rectangle a b
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.rectangularDomain` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。 | [EXTRA] |

[EXTRA] [EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则直接采信 Lean 4.34.0 / Mathlib v4.34.0 的标准数学含义；只从版本绑定的 Ch05\_deps.txt 展开项目自定义定义，不以 Mathlib 定义体未收录为材料不足。项目 ReviewDefinitions.lean 的 E n 展开为 EuclideanSpace ℝ (Fin n)，即欧氏 ℝⁿ，volume 是标准 Lebesgue 测度。项目 Statements.lean 的 rectangle a b={z | ∀i,a i≤z i ∧ z i≤b i}；boxFace a b i side={z | z∈rectangle a b ∧ z i=side}。展开 MD.Ch05.rectangularDomain 就是上述 rectangle。教材 PDF 页205在一般合适区域后明确给出矩形m维盒这一例子，本条将该例子的维数及坐标端点具体化，定义未冒称覆盖任意形状区域。体积V是区域体积的描述记号，不是额外数值结论。[EXTRA]矩形特化合理；本定义可用于空或退化盒是集合定义的自然延伸，后续通量定理另有a\_i<b\_i。没有漏掉本条的定理结论，也没有[ERRATUM?]。定义不含sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.rectangularDomain`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L520)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-FaceFlux · definition · 印刷p.184 / PDFp.205

### 2. 原文陈述

> $`\frac{d\nu}{dt}=-\int_{\partial A}f\cdot n\,\rho(z;t)\,d\sigma`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def faceFlux {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (ρ : MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n) (i : Fin n) (side : ℝ) :=
  ∫ z in boxFace a b i side,ρ z*f z i ∂(MolecularDynamics.Chapter05Review.hausdorffArea (n-1))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.faceFlux` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。 | [EXTRA] |

[EXTRA] [EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。；[EXTRA] 显式逐句范围及跨source\_id映射；原文保留，repair\_log追加。仅矩形单面的无定向通量辅助积分；原句全部面与质量导数结论由MD-5.2.2-BoxFluxBalance，光滑一般域由MD-5.2.2-GeneralFluxBalance承担。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；按本条明确的statement\_scope审校：faceFlux是任意n、f、ρ、a、b、i及side上的单面无定向坐标通量辅助定义，而非原文整条质量守恒定理。boxFace取闭矩形中第i坐标等于side的面；hausdorffArea(n-1)采用单位球体积除2^(n-1)的Hausdorff面积归一化，积分ρ f\_i正确。side并未被限制到上下端点；作为辅助定义可总定义，实际上下端点在条目3中代入。条目3的下端减上端给出质量导数，与外法向符号一致。接受显式拆分后的矩形范围；没有据此确认本任务未提供的GeneralFluxBalance，也不将本定义认证为一般域通量定理。

### 7. 状态与证明位置

self-contained；`MD.Ch05.faceFlux`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L525)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-BoxFluxBalance · unnumbered_claim · 印刷p.184 / PDFp.205

### 2. 原文陈述

> Using the divergence theorem, we may rewrite the latter quantity as a volume integral:

$$
\frac{d\nu}{dt}=-\int_A\nabla\cdot(f(z)\rho(z;t))\,d\omega.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem fluxBalance :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ) (a b : MolecularDynamics.Chapter05Review.E n),
  0 < n → (∀ i,a i < b i) → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 (Function.uncurry ρ) →
  (∀ t,MolecularDynamics.Chapter05Review.probabilityDensity (ρ t)) →
  (∀ t,MolecularDynamics.Chapter05Review.densityMeasure (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (MolecularDynamics.Chapter05Review.densityMeasure (ρ 0))) →
  ∀ t, HasDerivAt (MolecularDynamics.Chapter05Review.massFraction ρ (rectangle a b))
    (∑ i,(faceFlux f (ρ t) a b i (a i)-faceFlux f (ρ t) a b i (b i))) t ∧
    (∫ z in rectangle a b,MolecularDynamics.Chapter05Review.divergence (fun x => ρ t x • f x) z)=
      ∑ i,(faceFlux f (ρ t) a b i (b i)-faceFlux f (ρ t) a b i (a i)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.fluxBalance` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。 | [EXTRA] |

[EXTRA] [EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对所有n>0、严格非退化矩形a\_i<b\_i、C¹场、满足群律和ODE的实际流、联合C²流与联合C¹密度、每时概率密度及Measure.map输运。结论同时含所有t的真实质量函数导数和散度积分等于上面减下面通量。两式合起来正好是dν/dt=-∫_A div(ρf)，无符号错误、无PDE前提。紧矩形及连续导数足够支撑积分求导和散度定理。原书允许矩形例子，[EXTRA]公开了矩形特化，故按此特化PASS；未审核未附的一般域条目。

### 7. 状态与证明位置

incomplete；`MD.Ch05.fluxBalance`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L530)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-BoundaryTerm · definition · 印刷p.185 / PDFp.206

### 2. 原文陈述

> where the term $`B=\sum_i\int_{\partial A_\ell}uf_iv\nu_i\,d\sigma`$, is a surface integral over the boundary of $`A_\ell`$, where $`\nu_i`$ is the $`i`$’th component of the unit outward normal to the surface $`\partial A_\ell`$ bounding the region $`A_\ell`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def boxBoundaryTerm {n : ℕ} (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) (ell : ℝ) : ℝ :=
  let a : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => -ell)
  let b : MolecularDynamics.Chapter05Review.E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,(MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i ell-
    MolecularDynamics.Chapter05Review.faceFlux f (fun z => u z*v z) a b i (-ell))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.boxBoundaryTerm` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对f、u、v、ell及维数参数；a=(-ell,…), b=(ell,…)。每坐标上面减下面的通量作用于ρ=uv，正是∑∫uf\_i v ν\_i；u v f\_i与原文u f\_i v相同。n≥1、ell>0的原文盒子语境下，棱角是面积零集合，不妨碍面分解；n=1时0维面积是计数测度。函数作为总定义允许其他ell及任意数据，没有额外断言这些情形存在原文的光滑外法向。[EXTRA]为空不影响其作为积分表达式的定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.boxBoundaryTerm`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L543)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-TruncatedIntegrationByParts · unnumbered_claim · 印刷p.185 / PDFp.206

### 2. 原文陈述

> We truncate the domain to a large box $`A_\ell`$ with edge of length $`2\ell`$ centered at the origin, approximating the inner product by:

$$
\langle u,\mathcal L_fv\rangle\approx\int_{A_\ell}u\mathcal L_fv\,d\omega=\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega.
$$


> Splitting this sum up, we treat each term by integration by parts

$$
\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega=\sum_i\int_{A_\ell}uf_i\frac{\partial v}{\partial z_i}\,d\omega\tag{5.4}
$$



$$
=B-\sum_i\int_{A_\ell}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega.\tag{5.5}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem truncatedIntegrationByParts : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := MolecularDynamics.Chapter05Review.rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*MolecularDynamics.Chapter05Review.lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.truncatedIntegrationByParts` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。 | [EXTRA] |

[EXTRA] [EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对所有n>0、ell>0、全空间C¹场和标量u,v，以及实际盒A。lie f v=Dv[f]，liouvillian f u=-div(uf)，故右侧B+∫liouvillian(f,u)v正好是B-∫v div(uf)。有限维坐标展开和积分的有限和分配在紧盒与C¹条件下等价于(5.4)，结论编码(5.5)。原文≈没有被编码成精确全空间等号；本条局部积分恒等式不需要无穷远衰减，[EXTRA]的局部C¹及正边长条件合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.truncatedIntegrationByParts`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L551)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-RapidAdjoint · unnumbered_claim · 印刷p.185–186 / PDFp.206–207

### 2. 原文陈述

> Let $`u,v`$ be two scalar valued functions in $`\mathbb R^m`$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $`u`$ and $`v`$ are rapidly decaying we know that $`B\to0`$, as $`\ell\to\infty`$. Taking the limit, we are thus left with the equation

$$
\langle u,\mathcal L_fv\rangle=-\sum_i\int_{\mathbb R^m}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega=\langle M_fu,v\rangle.
$$


> We refer to $`M_f`$ as the adjoint operator of $`\mathcal L_f`$ and we write $`M_f=\mathcal L_f^\dagger`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rapidAdjoint : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry



/-- 修正版，对应原文 MD-5.2.2-RapidAdjoint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem rapidAdjoint_corrected : ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*MolecularDynamics.Chapter05Review.lie f v z) volume →
  Integrable (fun z => MolecularDynamics.Chapter05Review.liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.rapidAdjoint`；`MD.Ch05.rapidAdjoint_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；声明本身是正确的条件化版本：n>0，f为C¹，u,v为SchwartzMap，两个实际混合乘积分别可积，且真实盒边界项B趋0，才推出全空间积分配对相等。由紧盒分部积分和两个可积函数的盒截断极限可得该结论；没有将最终配对相等作为假设。但原页声称仅由u,v迅速衰减便知B→0，未明确f的增长控制；[EXTRA]把B→0改为前提是实质补充，不能据此宣布原书推论已成立。按任务规定保留原句并将原书条件疑点交人工；形式伴随记号也不等于闭Hilbert算子伴随的定义域识别。

### 7. 状态与证明位置

incomplete；`MD.Ch05.rapidAdjoint`：未证（原书疑误不证）；`MD.Ch05.rapidAdjoint_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L561)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-CompactAdjoint · unnumbered_claim · 印刷p.185–186 / PDFp.206–207

### 2. 原文陈述

> $`\langle u,\mathcal L_fv\rangle=\langle M_fu,v\rangle`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem liouvillianAdjoint :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u v : MolecularDynamics.Chapter05Review.E n → ℝ),
  ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v → HasCompactSupport u → HasCompactSupport v →
  (∫ z,u z*MolecularDynamics.Chapter05Review.lie f v z)=(∫ z,MolecularDynamics.Chapter05Review.liouvillian f u z*v z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.liouvillianAdjoint` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。 | [EXTRA] |

[EXTRA] [EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对任意n、C¹向量场及C¹实函数u,v，二者均有紧支持；结论为真实Lebesgue积分的配对相等。相关乘积及导数连续且有紧支持，故可积、边界项在充分大盒上消失。n=0时导数场为零，仍成立。此为已明确另列的紧支持版本，不宣称所有C¹紧支持函数属于SchwartzMap，也不把形式配对等同于闭算子伴随。与原页所摘等式及[EXTRA]范围一致。

### 7. 状态与证明位置

incomplete；`MD.Ch05.liouvillianAdjoint`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L586)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.2-MeasurePropagator · definition · 印刷p.186 / PDFp.207

### 2. 原文陈述

> The density $`\rho`$ evolves as the solution of the partial differential equation $`\partial\rho/\partial t=\mathcal L_f^\dagger\rho`$, where we interpret $`\rho`$ as a function of both $`z`$ and $`t`$ and view $`\mathcal L_f^\dagger`$ as only operating on the spatial components. This means, formally, $`\rho(\boldsymbol z,t)=e^{t\mathcal L_f^\dagger}\rho(\boldsymbol z,0)`$. We can think of $`\exp(t\mathcal L_f^\dagger)`$ as defining the propagator of measure.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def measurePropagator {n : ℕ}
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (_hf : MolecularDynamics.Chapter05Review.flow f Φ) (t : ℝ)
    (μ : Measure (MolecularDynamics.Chapter05Review.E n)) := Measure.map (Φ t) μ

def measurePropagator_general {X : Type*} [MeasurableSpace X] (Φ : ℝ → X → X) (t : ℝ) (μ : Measure X) :=
  Measure.map (Φ t) μ

theorem measurePropagator_density_evolution : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n)) (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : ℝ → MolecularDynamics.Chapter05Review.E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → MolecularDynamics.Chapter05Review.flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) (MolecularDynamics.Chapter05Review.liouvillian f (ρ t) z) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.measurePropagator`；`MD.Ch05.measurePropagator_general`；`MD.Ch05.measurePropagator_density_evolution` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。 | [EXTRA] |

[EXTRA] [EXTRA] 主接口限定实际自治流；保留一般Measure.map辅助定义，另列由实际初始密度推前得到的点态Liouville演化；ρ(0)是初值，形式指数作记号，不将PDE作为前提。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐一核对主定义、general辅助定义和density\_evolution。主接口包含真实自治流资格并作正时间Φ\_t推前；general仅为任意可测空间上Measure.map的总定义，不额外宣称任意Φ都是物理流。evolution对任意开且流不变D、C¹场、联合C²实际流、联合C¹且各时为概率密度的ρ，假设各时密度测度是初始密度的推前，推出每个t及z∈D处∂tρ=liouvillian f (ρ t)。ρ初值为ρ 0而非任意强加解；时间符号正确。形式指数只是演化算子记号，未声称已经构造一般无界算子的指数；[EXTRA]与实际编码相符。

### 7. 状态与证明位置

incomplete；`MD.Ch05.measurePropagator`：定义；`MD.Ch05.measurePropagator_general`：定义；`MD.Ch05.measurePropagator_density_evolution`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L594)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianDivergence · unnumbered_claim · 印刷p.186 / PDFp.207

### 2. 原文陈述

> The term $`\nabla\cdot f`$ vanishes for $`f=J\nabla H`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianDivergence {Nc : ℕ}
    (H : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hH : ContDiffAt ℝ 2 H z) :
    (textbookJacobian (textbookHamiltonianVectorField H) z).trace = 0 := by
  apply MolecularDynamics.textbookHamiltonianVectorField_divergence_zero <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianDivergence` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。 | [EXTRA] |

[EXTRA] [EXTRA]固定正式库的实际规范坐标、Jacobian及C² Hamiltonian；保留任意H，既有证明由真实Hessian对称性推出散度零。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；PASS：依赖 SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ，按 q,p 排列，textbookJ=[[0,I],[-I,0]]；SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e\_i))_i；SymplecticMaps.lean 的 textbookJacobian=LinearMap.toMatrix' (fderiv ℝ Φ z).toLinearMap，其 trace 正是坐标散度。因此任意 Nc,H,z 下的结论是 div(J∇H)(z)=0。[EXTRA]局部 C² 保证真实二阶导数对称，是合理的光滑性资格，不假设结论。原书无本条 [ERRATUM?]。本声明调用依赖 HamiltonianVolume.lean 中已给出 Hessian 对称性与 trace(JS)=−trace(JS) 的证明，声明本体无 sorry；此为静态语义审阅，未运行 Lean 编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.hamiltonianDivergence`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L613)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianSkewExpression · unnumbered_claim · 印刷p.186 / PDFp.207

### 2. 原文陈述

> From the above we know that for a smooth scalar function $`u=u(z)`$, $`\mathcal L_f^\dagger u=-\nabla\cdot(uf)=-f\cdot\nabla u-u\nabla\cdot f`$. The term $`\nabla\cdot f`$ vanishes for $`f=J\nabla H`$. Thus we have $`\mathcal L_f^\dagger u=-f\cdot\nabla u=-\mathcal L_fu`$. If this holds for all smooth $`u`$, we write $`\mathcal L_f^\dagger=-\mathcal L_f`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianSkewExpression :
  ∀ n (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) (u : MolecularDynamics.Chapter05Review.E n → ℝ),
  Differentiable ℝ f → Differentiable ℝ u → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  ∀ z,MolecularDynamics.Chapter05Review.liouvillian f u z= -MolecularDynamics.Chapter05Review.lie f u z := by
  intro n f u hf hu hdiv z
  rw [liouvilleProduct n f u z (hf z) (hu z),hdiv z]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianSkewExpression` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。 | [EXTRA] |
| 尚未覆盖的结论 | C² Hamiltonian的真实Hamilton场散度零桥接与本条实例化；正式库HamiltonianVolume的维数/坐标转换尚未在本条展开核对 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA]本条保留任意零散度场的实际表达式；Hamiltonian散度零另以正式库桥接；原书的skew-adjoint用语只作形式积分伴随记号，未声称已构造闭算子及其Hilbert空间定义域。；[EXTRA] 零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。

### 6. 审计结论

本轮修复：零散度可微向量场的条件乘积恒等式；原段从Hamilton场推散度零的桥接另为覆盖义务，不在本条预先假设后再声称证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；所列定理作为一般零散度场的条件命题正确：∀n,f,u，f和u可微，假设∀z div f z=0，再得∀z -div(uf)=-Du[f]。但本条statement\_scope覆盖整个原段，其中还包含f=J∇H时散度为零这一实质结论。当前所有声明既无H、J或Phase，也无从HamiltonianField推出div f=0的桥接。将散度零直接列为前提不能覆盖该结论。[EXTRA]称正式库另有桥接，却未给出其声明及所需正则性，不能按本任务的唯一输入核实。因此就完整原句覆盖判FAIL，并非认为已列的条件恒等式为假。

### 7. 状态与证明位置

self-contained；`MD.Ch05.hamiltonianSkewExpression`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L622)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-HamiltonianDensityPropagation · unnumbered_claim · 印刷p.187 / PDFp.208

### 2. 原文陈述

> An important consequence of the skew symmetry of $`\mathcal L_f`$ for a divergence-free system is that the propagator $`e^{t\mathcal L_f^\dagger}`$ preserves the integral over the whole phase space, i.e.

$$
\int_D e^{t\mathcal L_f^\dagger}\rho(z)d\omega=\int_D e^{-t\mathcal L_f}\rho(z)d\omega=\int_D\rho(\mathcal F_{-t}(z))d\omega=\int_D\rho(z)d\omega,
$$


> since we can view $`\mathcal F_{-t}(z)`$ as a change of variables by a volume-preserving map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianDensityPropagation : ∀ n (D : Set (MolecularDynamics.Chapter05Review.E n))
    (f : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n) Φ (ρ : MolecularDynamics.Chapter05Review.E n → ℝ),
  NullMeasurableSet D volume → ContDiff ℝ 1 f → MolecularDynamics.Chapter05Review.flow f Φ →
  ContDiff ℝ 2 (Function.uncurry Φ) → (∀ z,MolecularDynamics.Chapter05Review.divergence f z=0) →
  (∀ t,Φ t '' D=D) → densityOn D ρ → ∀ t,
    (∫ z in D,ρ (Φ (-t) z))=(∫ z in D,ρ z) ∧
    densityMeasureOn D (fun z => ρ (Φ (-t) z))=MolecularDynamics.Chapter05Review.measurePropagator Φ t (densityMeasureOn D ρ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.hamiltonianDensityPropagation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。 | [EXTRA] |

[EXTRA] [EXTRA]一般Lebesgue可测且流不变的相空间D；实际C²自治流，明确域的资格。体积保持是需要推出的中间结论，未作为结论假设；算子exp记号解释为实际pullback/map。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对∀n、D、f、Φ、ρ；D仅需Lebesgue零可测而不强制开，C¹场具有联合C²全时间实际流，全空间div f=0，D对每个时间流不变；densityOn要求D上非负、可测及可积而不要求归一化。结论对每个实t同时给出D上ρ∘Φ_{-t}的积分不变及其密度测度等于Φ\_t推前初始密度测度。全局流的逆是Φ_{-t}，散度零和正则性足以推出Jacobian行列式1，继而体积保持；未将体积保持作为前提。正负时间方向和限制域均正确。形式指数用实际拉回/推前表达，[EXTRA]合理。

### 7. 状态与证明位置

incomplete；`MD.Ch05.hamiltonianDensityPropagation`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L632)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.2.3-MechanicalLiouvillian · definition · 印刷p.187 / PDFp.208

### 2. 原文陈述

> The Liouvillian of a Hamiltonian system with $`N_c`$ degrees of freedom and a Hamiltonian of the form $`H=\sum_{i=1}^{N_c}p_i^2/(2m_i)+U(q_1,\ldots,q_{N_c})`$ can be written

$$
\mathcal L_H^\dagger=-\sum_{i=1}^{N_c}m_i^{-1}p_i\frac{\partial}{\partial q_i}-\sum_{i=1}^{N_c}F_i\frac{\partial}{\partial p_i},
$$


> where $`F_i=-\partial U/\partial q_i`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def mechanicalLiouvillian {n : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (u : MolecularDynamics.Chapter05Review.Phase n → ℝ) (z : MolecularDynamics.Chapter05Review.Phase n) :=
  -(fderiv ℝ u z) ((WithLp.toLp 2 fun i => z.2 i/m i),F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mechanicalLiouvillian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；核对Phase n=E n×E n、m为固定坐标质量、F仅依赖q、u和z为完整相空间标量函数与点。负Fréchet导数作用于(p\_i/m\_i,F(q))，在u可微处恰为-∑(p\_i/m\_i)∂q\_i u-∑F\_i∂p\_i u，两个负号正确。这是可复用的微分表达式定义，不自身断言任意F均由势生成。其Hamiltonian特化F=-gradient U、正质量和C²势由本批条目12明确给出并核对，故结合该显式特化可接受；单独此定义不构成从H推出身份的证明。零质量或不可微u下Lean的总定义扩展不解释为原书物理算子。

### 7. 状态与证明位置

self-contained；`MD.Ch05.mechanicalLiouvillian`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L642)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

