[上一部分](part01.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

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

